Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6D9781D0F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 11:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjHTJN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 05:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjHTJNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 05:13:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8EA31E9F5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 11:59:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24E4A608C0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 18:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32ADC433C8;
        Sat, 19 Aug 2023 18:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692471548;
        bh=muSsZQXeH5W5ZWIQQGcJYHD2XdcfeOyxVM9kY1wr7f8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i74yyXCF1RpoTfnu1exjW2hK1HDtKw2oAVHRpVll+Mt2HqVxOFnXWkki5CEEZFNcb
         2gOurktbrZNr16tNwNkzOM2rd40R2TfPCei7W3ZewL6qgYUI3cSUL4y8i8fiaVHcQm
         i/8i5QlbHq+2OOh3cagGRp2QU+QkTKfN0FNz2c+fFxqAjEagqnJeJjJS0/kJffU0XU
         JHd4jdq4eSU7dh4PY8I7ZNvIsLRiq328kzObyS5l47RPqXhyZ8Z7xU7a0NDO60Ram+
         khhDhMrwPC+aOzNJ6JlzrpQMl14uzaikCMDbV3w7dOcKGRhSfMh6wToV3rrs+M38i9
         0wqRsPMeYRA5Q==
Date:   Sat, 19 Aug 2023 20:59:01 +0200
From:   Simon Horman <horms@kernel.org>
To:     Furong Xu <0x1207@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v2 1/1] net: stmmac: Check more MAC HW features
 for XGMAC Core 3.20
Message-ID: <ZOEQ9TYM/FX8UPr6@vergenet.net>
References: <20230819105440.226892-1-0x1207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819105440.226892-1-0x1207@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 06:54:40PM +0800, Furong Xu wrote:
> 1. XGMAC Core does not have hash_filter definition, it uses
> vlhash(VLAN Hash Filtering) instead, skip hash_filter when XGMAC.
> 2. Show exact size of Hash Table instead of raw register value.
> 3. Show full description of safety features defined by Synopsys Databook.
> 4. When safety feature is configured with no parity, or ECC only,
> keep FSM Parity Checking disabled.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> Changes in v2:
>   - Rebase patch on net-next. Thanks Simon :)

Likewise, thanks.

Reviewed-by: Simon Horman <horms@kernel.org>
