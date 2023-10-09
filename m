Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B27E7BE79F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377770AbjJIRTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377587AbjJIRTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:19:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5475B94;
        Mon,  9 Oct 2023 10:19:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-27740ce6c76so2786041a91.0;
        Mon, 09 Oct 2023 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696871947; x=1697476747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYsDyuLHhe+jjGyQkgh34WNXlJPcA2wIrKJwL6sse2g=;
        b=djobItllvsdaWsPyMmBKs9iMLkVIhT3QNjxCHlA93mNyWwIvMKABKy5BcYyL7SRQvl
         2pEUhwHe7Tx1eOt/IC/C0Ca+42SGoYOa8hma5Nn+TPZB7t9GtQzOnFVdI5IbxGQoZ2SR
         DwrniADAOfgfA7twc15fEo3yBtdHCWoHgE6JygNDW3bM0uACdLotjKZwR07MiTs0z2wE
         eqdQjyw6RNC6LJ5VZitDRs8NLFG+HK3cRHRx5h01Ob0vs1DKoYdbnpnOft2VwCt1UlqF
         NafRXrtoH0W12pkbK7xBh48XV0z2XF6S/soFQRB06Ieg0juSofN/N3284tHZyYQbwCL/
         ldkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696871947; x=1697476747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYsDyuLHhe+jjGyQkgh34WNXlJPcA2wIrKJwL6sse2g=;
        b=eHKixegULPzIZ7C2SUH5/H41t7gqY1dXEXNkyzch1fe4sshTC5qf1bcCOOKPaJSlfj
         DDzTLSGTsQ6PKOn9ulnZ+e3WveJayt53oJXkqfWvRxzdZw5+0uZh1OBxbdWNFb9f6Fbm
         oXonynIORveeHDKDLglVvPptbcwRa1oJELC+7QUNk0ENjjw2BxSklAXTKmk97s1Fjjy5
         yPv9Xb05W5DRem/CjbqMqCtOwser+/5l+tCMVWbPv5UuIsSkyy6fNQOIOy1EvcgEzaWn
         CX9POYBlcDuMoGmsMKi5vsIFglQgub/Vq1uXKhSFu1mheR2rrc2OYZxfXN4aW5ydpIv6
         q9ag==
X-Gm-Message-State: AOJu0YyOKQF4ieRuGwIksv+9VSfSkt3h2iNVj+SfoA+erSznMyjnpfdm
        Ww5KIRul3tQ7fFtvqbJ3HAn+3VkrzNI=
X-Google-Smtp-Source: AGHT+IEDVJTqcauNyoJ4QmdtJElIMGQj7TZ0gNMtHAXchJoiIlwpyZ7gIWM8Jj/+9FhZNzcemHUazw==
X-Received: by 2002:a17:90a:d804:b0:273:efc0:33eb with SMTP id a4-20020a17090ad80400b00273efc033ebmr11720051pjv.14.1696871946579;
        Mon, 09 Oct 2023 10:19:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090adb4c00b0027722832498sm10650839pjx.52.2023.10.09.10.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 10:19:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 9 Oct 2023 10:19:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] drivers/hwmon: add local variable for newly
 allocated attribute_group**
Message-ID: <bab3c83c-2ba8-4d23-b3cb-2f233898f7f2@roeck-us.net>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
 <20231009165741.746184-2-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009165741.746184-2-max.kellermann@ionos.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 06:57:35PM +0200, Max Kellermann wrote:
> This allows the compiler to keep the pointer in a register and
> prepares for making the struct field "const".
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

I have no idea what this is about, and I don't see how that would
improve anything, but ...

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

CHECK: multiple assignments should be avoided
#101: FILE: drivers/hwmon/hwmon.c:794:
+		hwdev->groups = new_groups = kcalloc(ngroups, sizeof(*new_groups), GFP_KERNEL);

either case, this change is not acceptable.

Guenter
