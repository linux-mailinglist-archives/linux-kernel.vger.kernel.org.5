Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802767EDC97
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbjKPIHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjKPIHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:07:14 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30AEC1;
        Thu, 16 Nov 2023 00:07:09 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc7077d34aso4531255ad.2;
        Thu, 16 Nov 2023 00:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700122029; x=1700726829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylEbJqf5nzYlj2CjniIYkSjKgcOsYzRZT9btvlXuXoU=;
        b=ZU+PBPzcqSeS1kvwkK7ovQlU5sDEHDV3O+2knxzhpJj/sCT8FXoD57iYPvZuX96/Pv
         aSZIAOBgb/CeIP6Ji1kKxyN3fj9uWuNsZe8kbAeALmXWzseZuTjeqeC0/u0BMQccH+JH
         pOXdomuFZaFg5b226sQPPmkd80hS7ZePVXZRcSQhxLuj+UAOItN/Hs1R5BfqZKN1LQZi
         R9CvIFEvT1PQZhnZVCTT4fyp/Iva98blRG+FRl6eF/OTdkgptXDWat9GVJBCHtLEde9/
         qwSSmuXFVjIPDsyFGp2tHv534I+FHJQ3RwuNUI3jUrI87uaeNgjabpxclbj6OIBWoMuV
         WWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700122029; x=1700726829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylEbJqf5nzYlj2CjniIYkSjKgcOsYzRZT9btvlXuXoU=;
        b=eGeC0MvhMaQL+xAOXGT8EOIXLm4emiKH/7tDjBIMFML6hPrJzqUh1jOTFMAJ64jAp3
         lc7WFFFbdVm4419ZhYxrSdI75GzcWXn86ar7VWB7li39ftfJgEWdtKnhgr3AdfEpErzX
         ccxNBOF1H3zK1X4yTRviH/DqtmM8pNjJ7VCsFMbhMTHts1QUXsxdFZcfah//8cfCXHci
         ECeY3Pzt51eY1TEw07jyWYU10WOhcAnJstzsoucWBiR8aKpDPSd+2QCM18qVCbPO8fzq
         RwByjzyIrqVJSr8yT7fcjHjC42+Ou5mUp2eMNUDlCiDvWDa+FDkiJs4RbrWOEuqgiO+n
         7kOg==
X-Gm-Message-State: AOJu0YwiAqXpRrwJtTrIo9UwoXpwbVPtNu96b4+tOB6GHTcpPv8dauNU
        gEqn8/DOq9sIh0w2gLH+peA=
X-Google-Smtp-Source: AGHT+IEO9XcaCmV/yhgCwRetjjp65+8LXDylpMIcKWf3QwcN9FLhx0GAeoF6c1SWItWdzUNpr6j4vg==
X-Received: by 2002:a17:902:ea10:b0:1cc:51ca:52e5 with SMTP id s16-20020a170902ea1000b001cc51ca52e5mr8260400plg.44.1700122029012;
        Thu, 16 Nov 2023 00:07:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c20a00b001b7f40a8959sm8601819pll.76.2023.11.16.00.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 00:07:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 16 Nov 2023 00:07:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xing Tong Wu <xingtong_wu@163.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, xingtong.wu@siemens.com,
        tobias.schaffner@siemens.com, gerd.haeussler.ext@siemens.com
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Fix logic error for PWM enable
Message-ID: <4616f6a2-f81d-47cb-9574-2319d04d3f34@roeck-us.net>
References: <20231116022330.2696-1-xingtong_wu@163.com>
 <20231116022330.2696-3-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116022330.2696-3-xingtong_wu@163.com>
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

On Thu, Nov 16, 2023 at 10:23:29AM +0800, Xing Tong Wu wrote:
> From: Xing Tong Wu <xingtong.wu@siemens.com>
> 
> The determination of the "pwm_enable" should be based solely on the mode,
> regardless of the pwm value.
> According to the specification, the default values for pwm and pwm_enable
> are 255 and 0 respectively. However, there is a bug in the code where the
> fan control is actually enabled, but the file "pwm_enable" incorrectly
> displays "off", indicating that fan control is disabled. This contradiction
> needs to be addressed and resolved.
> Solution: Update the logic so that "pwm_enable" is determined by mode + 1,
> remove the "off" value for "pwm_enable" since it is not specified in the
> documentation.

The chip specification is irrelevant. What is relevant is the hwmon ABI,
which says

What:           /sys/class/hwmon/hwmonX/pwmY_enable
Description:
                Fan speed control method:

                - 0: no fan speed control (i.e. fan at full speed)
		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                - 1: manual fan speed control enabled (using `pwmY`)
                - 2+: automatic fan speed control enabled

which is what the code currently implements or at least tries to
implement.

Guenter

> 
> Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>
> ---
>  drivers/hwmon/nct6775-core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
> index 2111f0cd9787..575db6cb96e9 100644
> --- a/drivers/hwmon/nct6775-core.c
> +++ b/drivers/hwmon/nct6775-core.c
> @@ -900,8 +900,6 @@ static const u16 NCT6116_REG_TSI_TEMP[] = { 0x59, 0x5b };
>  
>  static enum pwm_enable reg_to_pwm_enable(int pwm, int mode)
>  {
> -	if (mode == 0 && pwm == 255)
> -		return off;
>  	return mode + 1;
>  }
>  
> -- 
> 2.25.1
> 
