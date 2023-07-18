Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD20757DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjGRNdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjGRNdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:33:08 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C048697;
        Tue, 18 Jul 2023 06:33:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AF9825C007D;
        Tue, 18 Jul 2023 09:33:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 18 Jul 2023 09:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1689687184; x=1689773584; bh=Tz
        mq/nK7eqvFosoiqIm7nW5CF/NRWQWr0Xx7OWV5RoE=; b=JkkS+MKKUpB+gaQfIL
        0kgHZn8rzCv8rtKiOAx6gJfptEnr5BFquVp0yb6DOeQ3q/6+zT/7Bb7viJoKPhSt
        vxl+gCSC50gsSYHAixPdpO+S+mdp1DIDVnUDgOyIcFdmTSm4ravuK7pe2Ois83Bf
        76/4lnHWcOACKGd3+Hb/6DpLA8PivTcP64jOAqYck+I3KNu7eAAFm7KDXv9BMp10
        x/ljYkpLqFib7XqkgjtNphulJsP0WtkPi4HTkqePoyGbxQKMtic5SWg19d1suVO3
        q84bbDuJT9eATyPOuFSqqD3GJHFlUSElmaZsT+5IW7C2qLl1l1ZCKs6P/troHxhn
        Y/PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689687184; x=1689773584; bh=Tzmq/nK7eqvFo
        soiqIm7nW5CF/NRWQWr0Xx7OWV5RoE=; b=Bo4S8QcsCvxMOTn0ymcerE1qVV4/u
        lLMT/LIRzz60aP5BHUslJsauS1SkOMBOjEbPKOXgQXU+vVvrLUr2zkYpBJNnzLVK
        euQh8LRGaj4L1rj8298GVuNWh/7r0rWH0ZSs+XtrLuwZMQUKKtBY/bCe2wakGGNY
        8J5MPB/rThyidywuK1nRiBUrVrjxcWXTkBZspi/3ysVtsxtrc1vXekbhtclgHFf+
        H7jwt5Vpj8vE4WGGh6kOb0QAc88LU8k8fvQOAokmbyxvKLYXaU/93XAKjbs18U5W
        9Lz+QdfLJuwewi2mHkRJvQnjwoqsEPNejJy/qsKAr1giuloIxK7/Aen3A==
X-ME-Sender: <xms:j5S2ZFTxIWcV3FblGUZNORcg1xcl_Yol-HukCFcc-BO5mReEMiKI_g>
    <xme:j5S2ZOxUqwEyMHRlGAmWXWJUH56CGtkWxxEBq0ZPAqBeGOB4Do9-LcBRHcLuywQTo
    -hm9q3LlT7SFw>
X-ME-Received: <xmr:j5S2ZK2IL41LFX77-mfIw_FhspcmzNLByhZi0R5FKPdDPIkz6aLxmsQaDZQj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejue
    fhtdeufefhgfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:j5S2ZNALaBy3MWS2P0uxTO6UfiTNsknmmZ1OpvUjMsDfGoFxxPO6Mg>
    <xmx:j5S2ZOir7RItwwL1ltUmVCHaKLHyKFVrmzMSkar4C2pbWFaGqbM2gQ>
    <xmx:j5S2ZBo-a8KbYhr__yjXxWKNz8O4MvoAQHTs1fVrIvmP57MaTH8qCA>
    <xmx:kJS2ZHX2NT7U99Kow2TsEshrsf654Nq1GYgDX1F42aekPBt3gznR4Q>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jul 2023 09:33:02 -0400 (EDT)
Date:   Tue, 18 Jul 2023 15:32:58 +0200
From:   Greg KH <greg@kroah.com>
To:     hanyu001@208suo.com
Cc:     mchehab@kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] wifi: av7110: remove space before ')'
Message-ID: <2023071830-quotation-gaining-8cbe@gregkh>
References: <tencent_C61A29FA864A05D9D83277F0CF7721A52D0A@qq.com>
 <89948b0041b6553b65a8cf8e8f1152b4@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89948b0041b6553b65a8cf8e8f1152b4@208suo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 03:27:58PM +0800, hanyu001@208suo.com wrote:
> The patch fixes the following errors detected by checkpatch.pl:
> 
> ./drivers/staging/media/av7110/av7110.c:2556: ERROR: space prohibited before
> that close parenthesis ')'
> ./drivers/staging/media/av7110/av7110.c:2558: ERROR: space prohibited before
> that close parenthesis ')'
> ./drivers/staging/media/av7110/av7110.c:2599: ERROR: space prohibited before
> that close parenthesis ')'
> 
> Signed-off-by: Yu Han <hanyu001@208suo.com>
> ---
>  drivers/staging/media/av7110/av7110.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/media/av7110/av7110.c
> b/drivers/staging/media/av7110/av7110.c
> index a5a431c1..6b9df2c 100644
> --- a/drivers/staging/media/av7110/av7110.c
> +++ b/drivers/staging/media/av7110/av7110.c
> @@ -2553,9 +2553,9 @@ static int av7110_attach(struct saa7146_dev* dev,
>           * use 0x03 to track RPS1 interrupts - increase by 1 every gpio3 is
> toggled
>           * use 0x15 to track VPE  interrupts - increase by 1 every vpeirq()
> is called
>           */
> -        saa7146_write(dev, EC1SSR, (0x03<<2) | 3 );
> +        saa7146_write(dev, EC1SSR, (0x03<<2) | 3);
>          /* set event counter 1 threshold to maximum allowed value
> (rEC p55) */
> -        saa7146_write(dev, ECT1R,  0x3fff );
> +        saa7146_write(dev, ECT1R,  0x3fff);
>  #endif
>          /* Setup BUDGETPATCH MAIN RPS1 "program" (p35) */
>          count = 0;
> @@ -2596,7 +2596,7 @@ static int av7110_attach(struct saa7146_dev* dev,
>           * then RPS_THRESH1 should be set to trigger
>           * every TS_HEIGHT (512) lines.
>           */
> -        saa7146_write(dev, RPS_THRESH1, (TS_HEIGHT*1) | MASK_12 );
> +        saa7146_write(dev, RPS_THRESH1, (TS_HEIGHT*1) | MASK_12);
> 
>          /* Enable RPS1
> (rFC p33) */
>          saa7146_write(dev, MC1, (MASK_13 | MASK_29));
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
