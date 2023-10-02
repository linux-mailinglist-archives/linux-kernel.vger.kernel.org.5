Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4657B5C29
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjJBUiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 16:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjJBUiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:38:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4D1BF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 13:38:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431D4C433C8;
        Mon,  2 Oct 2023 20:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696279085;
        bh=jKPwA4P6nQ5kxg8vRRfjFSgIxbHzzXE+7FY6uh0C2P4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eMqhukkfUrEcD0BYIw9hLxIg3fzeK2MSY6RlwpYsMwk4n5udXEKJm6wwceq/UawYM
         bT3W3blw2X//ge96SadRcKD0FxGUAXyHMk3kZor4RdwSmulOXquYqaw5j0M4PBssRe
         WqnQmm41g0i2mKi8jIj1InHjEihqmUiuebgAHmQ4X5gslT6R5yK9Ta9Vhv1640MrYc
         9w4FoxLQg3zQR4mh6IROehSrpEV9sR8WRYtXNpzYVw0PU342FQAp5hV2EyX843gaET
         d62nT5V31kd18lwm3t0l1Xs7EO5od75lDmW3YN4tukKwGuKhXsdargVQob1MR/oC3M
         JCaCGvym2RQSA==
Date:   Mon, 2 Oct 2023 13:37:59 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: remove unneeded
 stmmac_poll_controller
Message-ID: <20231002133759.133d8a97@kernel.org>
In-Reply-To: <ZRKozLps8dmDmQgc@pilgrim>
References: <20230906091330.6817-1-repk@triplefau.lt>
        <626de62327fa25706ab1aaab32d7ba3a93ab26e4.camel@redhat.com>
        <ZRKozLps8dmDmQgc@pilgrim>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 11:47:56 +0200 Remi Pommarel wrote:
> > I'm sorry for the incremental feedback, but we also need a suitable
> > Fixes tag, thanks!  
> 
> I didn't include Fixes tag because it would go back up to the initial
> driver support commit [0]. I can't be sure that this commit includes
> necessary NAPI implementation to be able to get rid of
> .ndo_poll_controller callback back then. And I am not able to test it on
> older version than 5.15.x hence I only included the 5.15.x Cc tag
> version prerequisite.
> 
> But I surely can add a Fixed tag if it is ok for it to be [0].
> 
> Also sorry for the long replying delay.
> 
> [0] commit 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers")

AFAIU the Fixes tag only indicates where the bug was present,
no guarantees on whether the fix can be backported as far back.
IOW I think [0] as Fixes tag will be perfectly correct, please
repost with it included?
