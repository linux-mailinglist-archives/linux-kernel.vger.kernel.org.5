Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E3E7817BA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 09:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343694AbjHSG5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245508AbjHSG5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:57:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E7E2102
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:57:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3D3F60F9E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 06:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F12FC433C7;
        Sat, 19 Aug 2023 06:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692428256;
        bh=NJ+AzEErbCS9Uj2GmaQZ/wrbE6c9H2qORM9U8sYbwSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=INaR/I8iU3IbGQDU94rliksjxWziuXDqnC9Jnq5nAMRg1AaDpg86WgrTbTnMdlfTN
         TkGM56cqN9GQMUQgSmGgf7h/vVLstHdEyikRSYJ8naChN54OhtsrygQwSkz6/49hHO
         KPObH40gdfoktYdrq1yTgFW36X++c2EnTWqG8O79H4o5Ev5AWuutX7sicPYxiUSzrV
         X+imAjAz59fiAkfXZHesbyV7gWPEamh/dT0tnJl6+k1k7ne8yBZ85Qkp7hGI8W5DFc
         uNYyFpzS5jMB4bov+DqKA5bXrQ/4dceSiKG/yTPgZMnBQaU+bHnDP99qy1dwei1lcD
         AoRHrc5Gyoaig==
Date:   Sat, 19 Aug 2023 08:57:31 +0200
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
Subject: Re: [PATCH net-next 1/1] net: stmmac: Check more MAC HW features for
 XGMAC Core 3.20
Message-ID: <ZOBn22NT/GYbZKxY@vergenet.net>
References: <20230818094832.179420-1-0x1207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818094832.179420-1-0x1207@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 05:48:32PM +0800, Furong Xu wrote:
> 1. XGMAC core does not have hash_filter definition, it uses
> vlhash(VLAN Hash Filtering) instead, skip hash_filter when XGMAC.
> 2. Show exact size of Hash Table instead of raw register value.
> 3. Show full description of safety features defined by Synopsys Databook.
> 4. When safety feature is configured with no parity, or ECC only,
> keep FSM Parity Checking disabled.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Hi Furong Xu,

thanks for your patch.

Unfortunately it does not apply cleanly to net-next,
which means that it isn't run through the upstream  CI and
creates a process issue for the maintainers.

Please consider rebasing on net-next and reposting.

-- 
pw-bot: changes-requested

