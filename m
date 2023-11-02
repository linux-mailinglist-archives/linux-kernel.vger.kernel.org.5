Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EC37DF16D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343639AbjKBLnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjKBLnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:43:04 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE7B198;
        Thu,  2 Nov 2023 04:42:53 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 7B6615C00F5;
        Thu,  2 Nov 2023 07:42:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 02 Nov 2023 07:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1698925372; x=1699011772; bh=ZH
        EuquhPntkdWzSrucJf7v5/zvj5F435h9SAa5O8f6k=; b=ak5mtVRldD1ynp8CF3
        PZEB+9JuM08uNUM5xuBMtrFG48TSICVeVkk35La7aFJxpaUmVpN0meovYN6xWCXM
        +6/1kjXeeA90z5VERleQAsqO2kKpUCmHMg3q0xYM4ombh27SyzcwT+uIGObOIeE8
        ACNXvCZqHI/qZQiEWAyiSAHllPPKfOGfJlPfNTfEbKHZI3QFTgWKumhfAB0M1WN7
        A1IhDZpHfHM/moAtSQqyogEG1+xwPumaQFHprQEIhrFJE9oUEnch95XkW0YoR+JA
        Rb3Y/a3OTRzBRNnuSLQnycHLLuOpkiguLu2WNQfrrzj5Iibl2DKIbOA/clxn/K1w
        X1/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698925372; x=1699011772; bh=ZHEuquhPntkdW
        zSrucJf7v5/zvj5F435h9SAa5O8f6k=; b=BIhWMPADjCeavnkC/DEhwL4gd+WpQ
        cNwke5zvo6V2r76ZLbPQj4sUiduH2fP0RV98xi645cLXebmU/nfd4HTX7AtFVn5Y
        jDK9qP0OHOjpokC3MQ9WHUzxxq/LCXGCCMcKWv+KPBEiMxyt8ArSmj1MQkrrrVtZ
        VwHrNB66OjtfStTI15gNCZ83NrTXYpnOBQSKY0hbPUh51aMrMY04ovAXxpkx6F8v
        RgB3QRsTP12s/4naOyPJ3WWFAB9dMcE2egAbzMZx5DXlx06DFH9cwRD5wXyU9ql+
        4SwQZesU3FDcVpdo8aiHle11GeawsBtQpDR3TxwrCqJU2Y/Tg8thx3LLw==
X-ME-Sender: <xms:PItDZfKKraEj66lEPLCyjTJQsoJAnmxuXpolJX5H0Tf5oDv2f_4Chg>
    <xme:PItDZTKxx_zugV81JSL3lWRP0zqQkD8pWxMYKVFjt3fKy4CJCLQHpf761Kk16zPNB
    ZOwv3TUn8aK0Q>
X-ME-Received: <xmr:PItDZXu2sbeqJzDlH_24nxQ6-2ez0MGqMjcpd14g-0Hj0h-xkCCHBARhhei1MiQzVbxdIde_BjjgaSDfBCqqlxSGGcA-uX16STq67Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtiedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekje
    euhfdtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:PItDZYag5AjifNA6L-emh600_e_IZPisI_aD2dW5HNuV9GZS2rzw4w>
    <xmx:PItDZWaBXJ2DtPoK2EkFdDdzMDmqGQb0nV1Muotj-ADPc1GDFyG19A>
    <xmx:PItDZcBYk1tAlTtIGKuoYwQfNQbargN7rdeDJDSkdqDbetSfbvQ9pw>
    <xmx:PItDZdVMMjgoq425maw_7V67Hl4CGK6OU_6Sa0uS9FCX7s76i2wY1A>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Nov 2023 07:42:51 -0400 (EDT)
Date:   Thu, 2 Nov 2023 12:42:48 +0100
From:   Greg KH <greg@kroah.com>
To:     dimadrumspro@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: tty: vt: vt.c: fixed segmentation fault in
 vt.c
Message-ID: <2023110206-robin-feel-d73f@gregkh>
References: <20231102113926.2019-1-dimadrumspro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102113926.2019-1-dimadrumspro@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Where is patch 1/2?

On Thu, Nov 02, 2023 at 12:39:26PM +0100, dimadrumspro@gmail.com wrote:
> From: Dima <dimadrumspro@gmail.com>

Is that your full name?

> 
> The previous code lacked proper synchronization, leading to potential data corruption and crashes. Added a spin lock to protect shared variable 'scrollback_delta' to prevent concurrent access.

Please wrap your lines properly, as your editor hinted that you should.

And always run scripts/checkpatch.pl on your patch before submitting it.

> 
> Signed-off-by: Dima <dimadrumspro@gmail.com>
> ---
>  drivers/tty/vt/vt.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 5c47f77804f0..29cf7fe11662 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -301,12 +301,13 @@ static inline unsigned short *screenpos(const struct vc_data *vc, int offset,
>  }
>  
>  /* Called  from the keyboard irq path.. */
> +static DEFINE_SPINLOCK(scrolldelta_lock);
> +
>  static inline void scrolldelta(int lines)
>  {
> -	/* FIXME */
> -	/* scrolldelta needs some kind of consistency lock, but the BKL was
> -	   and still is not protecting versus the scheduled back end */
> +	spin_lock(&scrolldelta_lock);
>  	scrollback_delta += lines;
> +	spin_unlock(&scrolldelta_lock);

How exactly did you test this?  This patch does not do anything that I
can determine.

And what "crashes" have you fixed here?  What "data corruption"?  Your
changelog text does not match this actual change at all from what I can
tell.

thanks,

greg k-h
