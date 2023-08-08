Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7B7774AB9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbjHHUeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjHHUd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:33:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DB61BAFD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 12:59:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3275562BFF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 19:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D7FC433C8;
        Tue,  8 Aug 2023 19:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691524755;
        bh=vaL2GmK6E30etgPK/7amdzCna9Tu7rMpzE4Hc5iSZ1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eP3OhvsFV740uKM4wAelsA49oWXmvK9xYJHKORXwcTkDrSeQp+Xdqc/mvhWuQMbZg
         pu3WzPRtCxrVoaon4argOZWH/7Gf3fPWD7R1e9/pGriWEboaYGN7O87Hoc1zt5Gp42
         AawQxcbbq9OdbOM/KhVTxNnezvS1Yvj4jDQG5pHdiukdD6ciNEfVwRLAz0TtC/Eh+L
         6aChhUkEzYBezywSBFJikE0og6LXAYWNCZm/4DOCxbbLK8ZblLQcJHp7FNYjIJb1EB
         Ijsei8Gve7vDojv3odcpuWgr1J7hDyOWCJranWmKVDFGKtyoh1f8SmhsAXFWptXGt1
         vxn8Hd0urihmA==
Date:   Tue, 8 Aug 2023 21:59:10 +0200
From:   Simon Horman <horms@kernel.org>
To:     Furong Xu <0x1207@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v2 1/1] net: stmmac: xgmac: RX queue routing
 configuration
Message-ID: <ZNKejh2ukx7Fwo66@vergenet.net>
References: <20230808021906.1120889-1-0x1207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808021906.1120889-1-0x1207@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 10:19:06AM +0800, Furong Xu wrote:
> Commit abe80fdc6ee6 ("net: stmmac: RX queue routing configuration")
> introduced RX queue routing to DWMAC4 core.
> This patch extend the support to XGMAC2 core.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> Changes in v2:
>   - Convert the shift ops to FIELD_PREP

Thanks!

FWIIW, I think if the code moved to using FIELD_PREP then
probably the _SHIFT defined can be cropped.

Reviewed-by: Simon Horman <horms@kernel.org>
