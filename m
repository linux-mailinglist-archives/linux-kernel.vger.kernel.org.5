Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9172754A3E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjGOQ43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGOQ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:56:27 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F17FD;
        Sat, 15 Jul 2023 09:56:26 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5440e98616cso2709521a12.0;
        Sat, 15 Jul 2023 09:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689440186; x=1692032186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvfZoyg2FH97ZqUsaABaPTbas5CzIMCCVK9y4nrfBLw=;
        b=UUmLasDCoIjp6Iz4ZEI6n02kILYbIYZ8PYQrpPSuIfONNMGiuEysDiibWE7QC7CrGe
         qTZOhUp3yxVJk4n0Kyvu09ypkOD51nOK7V2WCs+tP5zjUbqy48c8Ab8lExlqTyLmHLqt
         TkkBTbsj0LGx5YVasm8WLNB4LJ8WqFoxGn0eRZqrvOyyUBuYxoCrTe3RaPdLXN/0owHk
         fjyQuAYXopJyA+8yEGflnZ2e33t8kmuXRF3wgSwwZm7E97TiacyRuAyBEAbloqjqK7eK
         RhHI7Jaf6y55O/ivUutPtjMH98J8LrZjCy84g5slq1uqql6bUhucjFFMEp+0RQQUG0i+
         BPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689440186; x=1692032186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvfZoyg2FH97ZqUsaABaPTbas5CzIMCCVK9y4nrfBLw=;
        b=Ejv1hzhYQVqA66W65Ahj6NYNd3oSaDSfBxkoy56hJ8qXTY3jbNOpDvaYFu5f+VW+kM
         MPHOI0UWyXP2rrKZysO+YPNMsQbEMleWRnc56XDwJ720nufq1+RVmAbYzrz8isE87+Vz
         AzroGXpCF2C8vIoAvH1ejv8+Yc2cmqey3W3CwCK2ep6sr1BMGMdlkBbEAOLL0Zc+1qNB
         oKoU8e1QDxgOkenZ3NiIOWkj2uZSLOI4ne627A49xBDNFI5m0wkmyR15k4K/FbQcm6vc
         KUBhTbiM9bBineGxqMOVgeIwu9RO7LCvgv2U2JFa6q/zxsubFrqm+4sQa9eoS339FKq/
         IxHQ==
X-Gm-Message-State: ABy/qLZinvVk0xBEgm5UWbku/NzI+MmyhygtXIGs0NN5QcqVTEibo33b
        H3CsJBY6r5//1eWaCOokqTJhLPmlBxg=
X-Google-Smtp-Source: APBJJlEzgnPBiVXPjCj1oC6XTCJX4Mpsy9P08FKlDvqjSRTYRXtsej4OdH1CO52tg83sgiT3KSnq8A==
X-Received: by 2002:a17:90a:f82:b0:262:f550:6413 with SMTP id 2-20020a17090a0f8200b00262f5506413mr7572485pjz.6.1689440185772;
        Sat, 15 Jul 2023 09:56:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a000500b0026307fa0442sm2891876pja.49.2023.07.15.09.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 09:56:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 15 Jul 2023 09:56:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v2] hwmon: (pmbus/max20730) Remove strlcpy occurences
Message-ID: <4b256962-5472-4174-a4c1-38d46795df0c@roeck-us.net>
References: <20230712214307.2424810-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712214307.2424810-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 09:43:07PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with direct assignment.
> 
> strlcpy in this file is used to copy fixed-length strings which can be
> completely avoided by direct assignment and is safe to do so. strlen()
> is used to return the length of @tbuf.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied.

Thanks,
Guenter

> ---
> v2:
>  * Includes driver name in commit header.
>  * Removes unrelated change tbuf{ 0 } -> tbuf{}.
>  * Fixes bug where @tbuf was being passed instead of @result.
> 
> v1:
>  * https://lore.kernel.org/all/20230712144429.2845940-1-azeemshaikh38@gmail.com/
> 
>  drivers/hwmon/pmbus/max20730.c |   64 +++++++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 31 deletions(-)
> 
> --
> 2.41.0.255.g8b1d071c50-goog
> 
> diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
> index 7bcf27995033..1de34da177c9 100644
> --- a/drivers/hwmon/pmbus/max20730.c
> +++ b/drivers/hwmon/pmbus/max20730.c
> @@ -114,6 +114,7 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
>  	const struct pmbus_driver_info *info;
>  	const struct max20730_data *data;
>  	char tbuf[DEBUG_FS_DATA_MAX] = { 0 };
> +	char *result = tbuf;
>  	u16 val;
> 
>  	info = pmbus_get_driver_info(psu->client);
> @@ -148,13 +149,13 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
>  			>> MAX20730_MFR_DEVSET1_TSTAT_BIT_POS;
> 
>  		if (val == 0)
> -			len = strlcpy(tbuf, "2000\n", DEBUG_FS_DATA_MAX);
> +			result = "2000\n";
>  		else if (val == 1)
> -			len = strlcpy(tbuf, "125\n", DEBUG_FS_DATA_MAX);
> +			result = "125\n";
>  		else if (val == 2)
> -			len = strlcpy(tbuf, "62.5\n", DEBUG_FS_DATA_MAX);
> +			result = "62.5\n";
>  		else
> -			len = strlcpy(tbuf, "32\n", DEBUG_FS_DATA_MAX);
> +			result = "32\n";
>  		break;
>  	case MAX20730_DEBUGFS_INTERNAL_GAIN:
>  		val = (data->mfr_devset1 & MAX20730_MFR_DEVSET1_RGAIN_MASK)
> @@ -163,35 +164,35 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
>  		if (data->id == max20734) {
>  			/* AN6209 */
>  			if (val == 0)
> -				len = strlcpy(tbuf, "0.8\n", DEBUG_FS_DATA_MAX);
> +				result = "0.8\n";
>  			else if (val == 1)
> -				len = strlcpy(tbuf, "3.2\n", DEBUG_FS_DATA_MAX);
> +				result = "3.2\n";
>  			else if (val == 2)
> -				len = strlcpy(tbuf, "1.6\n", DEBUG_FS_DATA_MAX);
> +				result = "1.6\n";
>  			else
> -				len = strlcpy(tbuf, "6.4\n", DEBUG_FS_DATA_MAX);
> +				result = "6.4\n";
>  		} else if (data->id == max20730 || data->id == max20710) {
>  			/* AN6042 or AN6140 */
>  			if (val == 0)
> -				len = strlcpy(tbuf, "0.9\n", DEBUG_FS_DATA_MAX);
> +				result = "0.9\n";
>  			else if (val == 1)
> -				len = strlcpy(tbuf, "3.6\n", DEBUG_FS_DATA_MAX);
> +				result = "3.6\n";
>  			else if (val == 2)
> -				len = strlcpy(tbuf, "1.8\n", DEBUG_FS_DATA_MAX);
> +				result = "1.8\n";
>  			else
> -				len = strlcpy(tbuf, "7.2\n", DEBUG_FS_DATA_MAX);
> +				result = "7.2\n";
>  		} else if (data->id == max20743) {
>  			/* AN6042 */
>  			if (val == 0)
> -				len = strlcpy(tbuf, "0.45\n", DEBUG_FS_DATA_MAX);
> +				result = "0.45\n";
>  			else if (val == 1)
> -				len = strlcpy(tbuf, "1.8\n", DEBUG_FS_DATA_MAX);
> +				result = "1.8\n";
>  			else if (val == 2)
> -				len = strlcpy(tbuf, "0.9\n", DEBUG_FS_DATA_MAX);
> +				result = "0.9\n";
>  			else
> -				len = strlcpy(tbuf, "3.6\n", DEBUG_FS_DATA_MAX);
> +				result = "3.6\n";
>  		} else {
> -			len = strlcpy(tbuf, "Not supported\n", DEBUG_FS_DATA_MAX);
> +			result = "Not supported\n";
>  		}
>  		break;
>  	case MAX20730_DEBUGFS_BOOT_VOLTAGE:
> @@ -199,26 +200,26 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
>  			>> MAX20730_MFR_DEVSET1_VBOOT_BIT_POS;
> 
>  		if (val == 0)
> -			len = strlcpy(tbuf, "0.6484\n", DEBUG_FS_DATA_MAX);
> +			result = "0.6484\n";
>  		else if (val == 1)
> -			len = strlcpy(tbuf, "0.8984\n", DEBUG_FS_DATA_MAX);
> +			result = "0.8984\n";
>  		else if (val == 2)
> -			len = strlcpy(tbuf, "1.0\n", DEBUG_FS_DATA_MAX);
> +			result = "1.0\n";
>  		else
> -			len = strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
> +			result = "Invalid\n";
>  		break;
>  	case MAX20730_DEBUGFS_OUT_V_RAMP_RATE:
>  		val = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_VRATE)
>  			>> MAX20730_MFR_DEVSET2_VRATE_BIT_POS;
> 
>  		if (val == 0)
> -			len = strlcpy(tbuf, "4\n", DEBUG_FS_DATA_MAX);
> +			result = "4\n";
>  		else if (val == 1)
> -			len = strlcpy(tbuf, "2\n", DEBUG_FS_DATA_MAX);
> +			result = "2\n";
>  		else if (val == 2)
> -			len = strlcpy(tbuf, "1\n", DEBUG_FS_DATA_MAX);
> +			result = "1\n";
>  		else
> -			len = strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
> +			result = "Invalid\n";
>  		break;
>  	case MAX20730_DEBUGFS_OC_PROTECT_MODE:
>  		ret = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_OCPM_MASK)
> @@ -230,13 +231,13 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
>  			>> MAX20730_MFR_DEVSET2_SS_BIT_POS;
> 
>  		if (val == 0)
> -			len = strlcpy(tbuf, "0.75\n", DEBUG_FS_DATA_MAX);
> +			result = "0.75\n";
>  		else if (val == 1)
> -			len = strlcpy(tbuf, "1.5\n", DEBUG_FS_DATA_MAX);
> +			result = "1.5\n";
>  		else if (val == 2)
> -			len = strlcpy(tbuf, "3\n", DEBUG_FS_DATA_MAX);
> +			result = "3\n";
>  		else
> -			len = strlcpy(tbuf, "6\n", DEBUG_FS_DATA_MAX);
> +			result = "6\n";
>  		break;
>  	case MAX20730_DEBUGFS_IMAX:
>  		ret = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_IMAX_MASK)
> @@ -287,10 +288,11 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
>  				"%d.%d\n", ret / 10000, ret % 10000);
>  		break;
>  	default:
> -		len = strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
> +		result = "Invalid\n";
>  	}
> 
> -	return simple_read_from_buffer(buf, count, ppos, tbuf, len);
> +	len = strlen(result);
> +	return simple_read_from_buffer(buf, count, ppos, result, len);
>  }
> 
>  static const struct file_operations max20730_fops = {
