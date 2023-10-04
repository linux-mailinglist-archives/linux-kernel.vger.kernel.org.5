Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7141B7B8667
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjJDRZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjJDRZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:25:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1958E9E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 10:25:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561E0C433C7;
        Wed,  4 Oct 2023 17:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696440328;
        bh=EAkymE/o1SEBuuXWw/QWqDVXCelOtrX/lIByZ98hZJ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TNb11iPBE2/5MFKAgt05MTpJXTCKaIRg7rCPai1At0nx3R0M2a7EjH2tWaI5wFPYf
         hA3ncCBOS+DrGShHe2ZURe/G/+bQpAwBBPeJzWBpOlXmrIzglx2dP3YwQkjQ8AMoOn
         +s4qHiabBnKnJCa+8wOl0AillAzht3ndXGpK1fY7NLoNSRKDgFo0/jFjWqpul7VIGa
         5kJpkO3HmmyogY1Xha9d6cKdRx7AjPAKG+evYOrdJ4P+HeWlIrz23NBHQaflMeXXh8
         K8YcHwGoRf00F0jJN++kA9oh46nv5aFKQO1Ik9YwOXE4zsl3UopI3pn/AJpkCYxv0v
         i0OdPY+YLekwA==
Date:   Wed, 4 Oct 2023 10:25:27 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     patchwork-bot+netdevbpf@kernel.org, khalasa@piap.pl,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ixp4xx_eth: Specify min/max MTU
Message-ID: <20231004102527.3a4bf0e2@kernel.org>
In-Reply-To: <CACRpkdacagNg8EA54_9euW8M4WHivLb01C7yEubAreNan06sGA@mail.gmail.com>
References: <20230923-ixp4xx-eth-mtu-v1-1-9e88b908e1b2@linaro.org>
        <169632602529.26043.5537275057934582250.git-patchwork-notify@kernel.org>
        <CACRpkdacagNg8EA54_9euW8M4WHivLb01C7yEubAreNan06sGA@mail.gmail.com>
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

On Tue, 3 Oct 2023 23:54:49 +0200 Linus Walleij wrote:
> Sorry Paolo, this is the latest version of this patch, which sadly changed
> Subject in the process:
> https://lore.kernel.org/netdev/20230928-ixp4xx-eth-mtu-v3-1-cb18eaa0edb9@linaro.org/
> 
> If it causes trouble for you to replace the patch I can rebase
> this work on top of your branch, just tell me.

Yes, please! Sorry about the mess, we're a bit backlogged after we
all went to Kernel Recipes :(
