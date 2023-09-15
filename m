Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EEB7A25DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbjIOSgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbjIOSfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:35:42 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B752105;
        Fri, 15 Sep 2023 11:35:35 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34fcbb4a097so1568185ab.1;
        Fri, 15 Sep 2023 11:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694802935; x=1695407735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhh/wBpFLk2YxTCyHBvIz67adRAxBtDWaMESKiiC4/U=;
        b=UIlTjq+Sz8pRYbeKRw0Y2zmhMjlIavv5FOl2IK22e7bfA4m8cVrZb1WfhH/jmFiI06
         U9O8zR7PY0cCvavCbBx90MeAHu+YTb/tR5Bx+GHKr9IK377mSMbmkcr/FWl10bAo2VG7
         bV2Vt/X6z4B8YQr+J6/FIt+TREZzum/Q41Xi0clUzI2+tklFJwJuxvmz3CP7hvyCDmWk
         2yhnYaj4NYm9JDUsJeMwkyMSmr0mThI152W77Ptk7Vas5JB0+VIT+bUWMZdIg8NmCV1r
         n01XO1quE5OlE7dmic56cl4W/vvA0nqo5NTvtwViQJXe69Crskom9Lv7yN04XqSEo/7L
         c75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694802935; x=1695407735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhh/wBpFLk2YxTCyHBvIz67adRAxBtDWaMESKiiC4/U=;
        b=dBHlhiGEICAmJLKGXRXap2bGMnL6QXZD6+zyJIcvSoT47aDkEPBjoWRmCVz/+r/unQ
         VESbmHoPZRLayCz1zqIOjvIxWnUZ0s5TGprd76ivCYdnl8Tp0wGhLfEpVxjmhdyvH9aS
         iK5KfJSVSFmsOyZ+ww10DcTe7SATdozlLsJPHuhJISF7qLS7BfIirUuviA/DVTgY6Ksv
         nRf5tUZFxiqHoKRzh0dN2ddmXdzpZ5CU8Fhmf5SR+v+M99AIHY+avk+K6jId0Q6e5FFh
         Ablg6lOq534GmS0jfi+D/ERE2l0lonH6SBylr+lDGcJ6p5372sOLHvUVQHyObMoswGO7
         QXXQ==
X-Gm-Message-State: AOJu0YxZ4HhwkJs46Z5SnLj+io2Z0c46VdVGkv+aegBf3R236OaHbpJI
        akj2PmcMWVCa/3sHghRk/vQ=
X-Google-Smtp-Source: AGHT+IFdWJGEojY/3icYzoleS4JW9eTiHbqoewNZRCdZVj1F67Fil/HcDOWYBfT/p+U99GmpGJEf1w==
X-Received: by 2002:a05:6e02:13d3:b0:34f:8039:a3b5 with SMTP id v19-20020a056e0213d300b0034f8039a3b5mr3136303ilj.26.1694802935093;
        Fri, 15 Sep 2023 11:35:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e24-20020a02a518000000b0042bae96eba7sm1199696jam.7.2023.09.15.11.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 11:35:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 15 Sep 2023 11:35:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hwmon: pmbus: refactor deprecated strncpy
Message-ID: <0b5ddd1e-2f78-4ef6-aadd-88ea53bbb9b2@roeck-us.net>
References: <20230915-strncpy-drivers-hwmon-pmbus-pmbus_core-c-v1-1-fca2cbca41ea@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915-strncpy-drivers-hwmon-pmbus-pmbus_core-c-v1-1-fca2cbca41ea@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 06:28:41PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer without unnecessarily NUL-padding.
> 
> `label` is zero-allocated and as such the NUL-padding behavior of
> strncpy is not required here.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 1363d9f89181..dcc8b12387cc 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -1394,7 +1394,7 @@ static int pmbus_add_label(struct pmbus_data *data,
>  	snprintf(label->name, sizeof(label->name), "%s%d_label", name, seq);
>  	if (!index) {
>  		if (phase == 0xff)
> -			strncpy(label->label, lstring,
> +			strscpy(label->label, lstring,
>  				sizeof(label->label) - 1);

'label' is allocated with kzalloc(), and, by copying one byte less
than the size of the field into label->label, it is guaranteed to be
terminated. Using strscpy() instead of strncpy() results in dropping
the last character of lstring if its length is sizeof(label->label) - 1.

Really, I am not going to accept any of your patches, sorry.

Guenter
