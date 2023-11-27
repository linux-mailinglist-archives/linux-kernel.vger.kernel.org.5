Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F36F7FA54F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjK0Pxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjK0Pxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:53:53 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455F48E;
        Mon, 27 Nov 2023 07:53:59 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E23C55C028B;
        Mon, 27 Nov 2023 10:53:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 27 Nov 2023 10:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1701100436; x=1701186836; bh=RV
        PtMXqwnKRTq3/SvOKl47wsrx36gr/hOLiwd56gh60=; b=KhEEuz8vhFWoA0MJJu
        dAS3GZuTJ+ESGv49306E5ktsWGTK9IBiNfnzhcXLCjbZI+UtMqXSvppI+BLaPHU1
        1rkpoXx7kw+ghKbljjytUC/+LOB2RQPoxi+ivGMQRCeIXDOrOmzRvv7cHjx7iBAq
        7VHyMK7Vaf1cumhfQ48+pXCXr+tYSLFmI7NOl74DJrI2B8dCo5bLdB6akxiPqFZ7
        F8dKukpeGLCL4qs5CX9vybeE2ZC1Wngsc1P0t+zplcxcigkT7INrPpAI+7PH9hI8
        OayP1a+8YKF+EJ6DYEMQ9Gb8IMso9/d0CoefIgMK5l1SwRglSoK35edrtsAD8WL+
        6a4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701100436; x=1701186836; bh=RVPtMXqwnKRTq
        3/SvOKl47wsrx36gr/hOLiwd56gh60=; b=KYCziQKjew1WHTQXoN5Dw1l47XC6K
        RJA4fVgWLdTLw9Ax0ekWpIDYPvsUKNo6DpwBtJsX1Lj19mR1/FIcNeiNxMZal0Ow
        5a+HaPJsG15/2RsQ9Z3UXOW9QhrHyJE17Eg677/+yL5kRS8Jxa7AWdQ8Kbbd8gv0
        dcjz3vdAxuW4T4OVMe/nNpeayz0uKxwHeZ5sheNXkUsfIH6uQO7p4zdxTU7msOFg
        0yPa3iFnp00ILvfKxavllf8bWRUBjaZPab7U5X9+bTfNXKtjBkhXP9KvUvCX+KEE
        eIXC/sNx/JJ6r4Wy00gSM6RGVXow4UI5kyltrKidcW15AWv6AaT/m53HA==
X-ME-Sender: <xms:lLtkZTxds9KCaErDq52aGewAXPSSkarwlHN4mkYj1Vz8pa-ZP8Yuug>
    <xme:lLtkZbS2aB9N9stzT7b-kr7-FUU2LanNb48JnYej_jqbt8-zYpZMhq0SZ6Pq97lBV
    d9VNERH_tg85A>
X-ME-Received: <xmr:lLtkZdXaC_F1R47aPUY33k10NLTJDt4GfxjgQQCh_tq6m6dr3pV_32sNN9AcjmEbOOmRKAJ8yypShaZgcRhHYkboHLm74WK-9xq0N3Obc8I9y0_MFm5Pmzk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiuddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:lLtkZdj25v_LkDMMFpqpAKM_mmF9bLJc61a0wLtLKrnajN7J_3dVow>
    <xmx:lLtkZVDugJLsohqrUIybYkDBpdq-V2i1ticf1kaf0LQb-TqqI3Ku8Q>
    <xmx:lLtkZWL0p8mEvHyuwFYxHMs6tbVtOGFQ0Ri-yuxu4cD4_7m7j1QyEA>
    <xmx:lLtkZd5b_xdTP4l7dS0pHxJjR1AmT0H0CwJGJDE9GhwX58qPneU7rQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Nov 2023 10:53:55 -0500 (EST)
Date:   Mon, 27 Nov 2023 15:53:54 +0000
From:   Greg KH <greg@kroah.com>
To:     Malcolm Hart <malcolm@5harts.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sven Frotscher <sven.frotscher@gmail.com>,
        git@augustwikerfors.se, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: ASoC: amd: yc: Fix non-functional mic on ASUS E1504FA
Message-ID: <2023112720-foam-epileptic-1f30@gregkh>
References: <b9dd23931ee8709a63d884e4bd012723c9563f39.camel@5harts.com>
 <ZWSckMPyqJl4Ebib@finisterre.sirena.org.uk>
 <87leajgqz1.fsf@5harts.com>
 <08590a87-e10c-4d05-9c4f-39d170a17832@amd.com>
 <87h6l72o8f.fsf@5harts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6l72o8f.fsf@5harts.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:44:37PM +0000, Malcolm Hart wrote:
> 
> 
> >From da1e023a39987c1bc2d5b27ecf659d61d9a4724c Mon Sep 17 00:00:00 2001
> From: foolishhart <62256078+foolishhart@users.noreply.github.com>
> Date: Mon, 27 Nov 2023 11:51:04 +0000
> Subject: [PATCH] Update acp6x-mach.c
> 
> Added 	ASUSTeK COMPUTER INC  "E1504FA" to quirks file to enable microphone array on ASUS Vivobook GO 15.
> ---
>  sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
>  1 file changed, 7 insertions(+)
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

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

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
