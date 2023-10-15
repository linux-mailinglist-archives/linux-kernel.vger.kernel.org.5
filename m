Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526D97C99DC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjJOPv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjJOPvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:51:25 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DF8AD
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 08:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FXwPyjqWiCTv56Ioz3mefBSAkEc1XsthE5iVJkJEyJY=;
  b=e7W4sjjnj8N7KEMPRhyKVtgNOFk+Mr6f3FQ02aFiIBQc1VDe64c3XgXy
   W2izKuGBmDyeiNzbjNB0bB33J25iDVOjkv6Pgp2kpykJqbXbYGAYpRHSQ
   73XOrhGuLUbYhryOnrOmFU915SLagsXhhvx2h86cKp5gLwSEvEUaShbNP
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,226,1694728800"; 
   d="scan'208";a="131311678"
Received: from unknown (HELO hadrien) ([87.129.180.234])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 17:51:19 +0200
Date:   Sun, 15 Oct 2023 17:51:17 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] staging: rtl8192u: Align descendant arguments
In-Reply-To: <0162d0d350aebd6b9d7cec1e7965b6b8ee42f82e.1697367161.git.gilbertadikankwu@gmail.com>
Message-ID: <783d0f3-8133-3bb7-a86-ba9843f6a22f@inria.fr>
References: <cover.1697367161.git.gilbertadikankwu@gmail.com> <0162d0d350aebd6b9d7cec1e7965b6b8ee42f82e.1697367161.git.gilbertadikankwu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 Oct 2023, Gilbert Adikankwu wrote:

> Align descendant arguments to the open parenthesis as per the "Linux
> Kernel coding style" in Documentation/process/coding-style.rst
>
> Mute the following checkpatch error:
>
> CHECK: Alignment should match open parenthesis
>
> Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
> ---
>  drivers/staging/rtl8192u/r819xU_firmware.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/rtl8192u/r819xU_firmware.c b/drivers/staging/rtl8192u/r819xU_firmware.c
> index 4f8629e47e82..c515b4773e37 100644
> --- a/drivers/staging/rtl8192u/r819xU_firmware.c
> +++ b/drivers/staging/rtl8192u/r819xU_firmware.c
> @@ -88,8 +88,8 @@ static bool fw_download_code(struct net_device *dev, u8 *code_virtual_address,
>
>  		index = tcb_desc->queue_index;
>  		if (!priv->ieee80211->check_nic_enough_desc(dev, index) ||
> -		       (!skb_queue_empty(&priv->ieee80211->skb_waitQ[index])) ||
> -		       (priv->ieee80211->queue_stop)) {
> +		    (!skb_queue_empty(&priv->ieee80211->skb_waitQ[index])) ||
> +		    (priv->ieee80211->queue_stop)) {

It's another change, but there are unnecessary parentheses here.

julia

>  			RT_TRACE(COMP_FIRMWARE, "=====================================================> tx full!\n");
>  			skb_queue_tail(&priv->ieee80211->skb_waitQ[tcb_desc->queue_index], skb);
>  		} else {
> --
> 2.34.1
>
>
>
