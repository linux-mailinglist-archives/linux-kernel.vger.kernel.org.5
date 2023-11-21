Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1431A7F32FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjKUQAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbjKUP76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:59:58 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA0B197;
        Tue, 21 Nov 2023 07:59:55 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cf669b711fso13619515ad.2;
        Tue, 21 Nov 2023 07:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700582395; x=1701187195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fq3/SeE6KNYDBQttCmY4nSF67urFZudHZ9zaRpvfJak=;
        b=awDCcdZ4mkaiRtHxio++m6oTzwWw30ShpEYZd4oCsc7XzvvZ5OMqWTfXUR++QFk+4L
         iNXo1HMHGkFbtBrnpKrh9PB1pEXf+VV67kqmaGb62EX+ta3Sb1PLYcsxt5hcJXJx9hNp
         Vxhx1mYi2ljm/lvcYab8LuYOp9Qeeh7e6hRTBZLSrDQPhzx4Ur0q6PiqXor5mnJQoC7g
         bU+qlnKCzxmeCvQquBxGtiCGf6m6FbGjvqYzZ70SO9zoFF3TufUVHXMLhs/wHW/qe+mv
         /m6pspBijBSNUof69SPeOiKNm2hMJAkPiztfzlf7TBCD0cNJdW7NMWoSSyPHG167k+UO
         6j0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700582395; x=1701187195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fq3/SeE6KNYDBQttCmY4nSF67urFZudHZ9zaRpvfJak=;
        b=LE6oSJV2TWcMBGoDvKY39s8b9KyQiWxjM86QHsVg/sqUhOrFq81/zmJMzZtrxxjNgS
         IfyXvGIQv0okYhXKR00rOJy3qHmFaAcZhgRsX/0ObjbmC9i4NTltxIyAOggO1xf9p9fF
         cQ0d25lvlPWGOs7Q8DI2zJfcvWeBsqIq1aWreKBC2Ts7r/YsorJwc5qC5jH2dySAXroE
         PfQeMvBRUMo6CtMf9cebipKm7HeQ0ZfU22M+v2Nv6UacCtNgkJaMyPFHw0/nzYpCjZ7e
         Q43xI7uFPgTPuT4/59aJcn+uZjgGHsHkc7bKYVNamQxNAzCQf7XHFkXwAGnyznb9gpAF
         uhlQ==
X-Gm-Message-State: AOJu0Yw8mSPzWJTmd2PSW1ywr27SpvgH0X8JXY08BBJ9jbIoAyiaxZ/W
        yJ9hCsFWsLmtGEpenReU/gBe+Ey8Wak=
X-Google-Smtp-Source: AGHT+IGd7CBkN16EspGA4syivW/jO35Ypu5wh51n4ix+l0fo3Rh6XJvYysCbmFkkGBX7E372WmXDSg==
X-Received: by 2002:a17:903:2301:b0:1cc:5589:7dba with SMTP id d1-20020a170903230100b001cc55897dbamr11433532plh.43.1700582394533;
        Tue, 21 Nov 2023 07:59:54 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902da8600b001a98f844e60sm8104668plx.263.2023.11.21.07.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 07:59:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 21 Nov 2023 07:59:53 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xing Tong Wu <xingtong_wu@163.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, xingtong.wu@siemens.com,
        tobias.schaffner@siemens.com, gerd.haeussler.ext@siemens.com
Subject: Re: [PATCH v3 2/2] hwmon: (nct6775) Fix fan speed set failure in
 automatic mode
Message-ID: <f7deda1b-7c47-44b3-9e9f-21300cf43bb4@roeck-us.net>
References: <20231121081604.2499-1-xingtong_wu@163.com>
 <20231121081604.2499-3-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121081604.2499-3-xingtong_wu@163.com>
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

On Tue, Nov 21, 2023 at 04:16:04PM +0800, Xing Tong Wu wrote:
> From: Xing Tong Wu <xingtong.wu@siemens.com>
> 
> Setting the fan speed is only valid in manual mode; it is not possible
> to set the fan's speed in automatic mode.
> Return error when attempting to set the fan speed in automatic mode.
> 
> Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/nct6775-core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
> index 88300fb99bb9..83f1da5acd22 100644
> --- a/drivers/hwmon/nct6775-core.c
> +++ b/drivers/hwmon/nct6775-core.c
> @@ -2553,6 +2553,13 @@ store_pwm(struct device *dev, struct device_attribute *attr, const char *buf,
>  	int err;
>  	u16 reg;
>  
> +	/*
> +	 * The fan control mode should be set to manual if the user wants to adjust
> +	 * the fan speed. Otherwise, it will fail to set.
> +	 */
> +	if (index == 0 && data->pwm_enable[nr] > manual)
> +		return -EBUSY;
> +
>  	err = kstrtoul(buf, 10, &val);
>  	if (err < 0)
>  		return err;
