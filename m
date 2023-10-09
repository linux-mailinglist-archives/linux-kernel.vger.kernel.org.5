Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381337BE7E4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377342AbjJIR2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376794AbjJIR16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:27:58 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA2194;
        Mon,  9 Oct 2023 10:27:56 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 71C225C0233;
        Mon,  9 Oct 2023 13:27:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 09 Oct 2023 13:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696872475; x=1696958875; bh=bp
        xIn05uY/U08nfsYtT4rBYIesMTzEwaJpdO00XFU2s=; b=E7HAb4+REZTWGtcQrQ
        1GjM4Pul71kt19zeswdWYM7IhscMTLXh0J02a0QJoMDYx5GKGRwNS0bijF6EsHn/
        6pKTuKTMwxchxYrO5IozEHZ+bHtmNvlpXeSl6zA3U7rN+i5tiipvkItzMJGOynnV
        KoyJJuke86Eo3848NINMcFKWFrZjJMSBtyp+9I1ItkxFUEysio5aShLbVhpGRVpI
        jGR6y7Ks6yYNArUk8jCF469KjtkVYOur0RgxGMS3QgO0+n8c8dgk1H14kyMKY1AR
        v+iu1KZpf9V9b1BkY9hhULHvcfrx9/r/0HMC0MVjUGCECtkVGlnlFiUQrvf/nuRy
        C/Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696872475; x=1696958875; bh=bpxIn05uY/U08
        nfsYtT4rBYIesMTzEwaJpdO00XFU2s=; b=ojOMwirzB0Lb9/TbEIyc2frjk+nci
        B3rsB4tEjr98/U8Pp0v4BJlySyhp0h/xCcninzSwbLHAywpKPZMXqU+ZghPzbSZY
        x/WjXH5t+Tt9BZFFqb/Vxg5yXwtT2xp9nc+fiuCIX4jNIx7jXLaLF9e0A9wu+LTQ
        C9mIFiA/f4pylVR1wwjxZwfZ6KAvCOiGN5Ffd/bNjyVDb2VTcmTaUygqbTQ5O2u9
        276Orf9fj0hqxye9/iJkuf3yjaVJx4rzrElwHXmdxNredclZ2LUQgoX6/MYTyxZ5
        GiDXHlpfGyl8/3+9UYgWVN5Votu6uvlItfAaNrOwkfNNmnDxh9wfxodZA==
X-ME-Sender: <xms:GzgkZeW_0kRmSE4QRbPkEsJXIC6oxsnht43xiSJ4GAtiLDf_j9Kewg>
    <xme:GzgkZamONWtGcmB781dTtaQL68W2LcqEY6i25NRSpPFq0xjBYsGcS4UOu1Ws7Rm-6
    1l1fBbgH2BhcQ>
X-ME-Received: <xmr:GzgkZSbsJc32GpVuuSc3ZcMVbDqOyJklkVeP8mmTBSSVepwgutpQgWf_d_x-t3zQDk9CIsa8-MeYqZpI7WNyBAxIe8tO0wkGU7QXcZSQL94>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheefgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:GzgkZVUcO1eDa1ADhpPAHur6vPzjjSzeV4QDrNBN3t94N1MpoynbNg>
    <xmx:GzgkZYkyP1ApgIqpqnGgX_ZiksciJdhzQP0qvXzrK6Z5ZTY24dJ7Ow>
    <xmx:GzgkZac2gtdK51VU48iPj21GNQHdXzptWqrQRRTx8eFKT-I9bMeijg>
    <xmx:GzgkZS4qYNtLUd5bjou2dtWN3JRP7qw_xhK_L6LfAU4ZmRpqLVMAzA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Oct 2023 13:27:54 -0400 (EDT)
Date:   Mon, 9 Oct 2023 19:27:51 +0200
From:   Greg KH <greg@kroah.com>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] drivers/hwmon: add local variable for newly
 allocated attribute_group**
Message-ID: <2023100908-pouring-synapse-75bd@gregkh>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
 <20231009165741.746184-2-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009165741.746184-2-max.kellermann@ionos.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 06:57:35PM +0200, Max Kellermann wrote:
> This allows the compiler to keep the pointer in a register and

Maybe, maybe not, there's no guarantee for register usage.

And it doesn't matter, this is a very slow path, no registers are
required :)

> prepares for making the struct field "const".

What struct field?


> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  drivers/hwmon/hwmon.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index c7dd3f5b2bd5..e50ab229b27d 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -783,6 +783,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>  	hdev = &hwdev->dev;
>  
>  	if (chip) {
> +		const struct attribute_group **new_groups;
>  		struct attribute **attrs;
>  		int ngroups = 2; /* terminating NULL plus &hwdev->groups */
>  
> @@ -790,8 +791,8 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>  			for (i = 0; groups[i]; i++)
>  				ngroups++;
>  
> -		hwdev->groups = kcalloc(ngroups, sizeof(*groups), GFP_KERNEL);
> -		if (!hwdev->groups) {
> +		hwdev->groups = new_groups = kcalloc(ngroups, sizeof(*new_groups), GFP_KERNEL);

So you have a const pointer AND a non-const pointer pointing to the same
thing?


> +		if (!new_groups) {
>  			err = -ENOMEM;
>  			goto free_hwmon;
>  		}
> @@ -804,14 +805,14 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>  
>  		hwdev->group.attrs = attrs;
>  		ngroups = 0;
> -		hwdev->groups[ngroups++] = &hwdev->group;
> +		new_groups[ngroups++] = &hwdev->group;

This shoul be identical, you assign both above the same way, so why
change this?

>  
>  		if (groups) {
>  			for (i = 0; groups[i]; i++)
> -				hwdev->groups[ngroups++] = groups[i];
> +				new_groups[ngroups++] = groups[i];

Same here.

thanks,

greg k-h
