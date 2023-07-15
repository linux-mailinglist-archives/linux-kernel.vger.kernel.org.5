Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF60754A1E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjGOQZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGOQZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:25:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C0830EA;
        Sat, 15 Jul 2023 09:25:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b9cdef8619so19358795ad.0;
        Sat, 15 Jul 2023 09:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689438315; x=1692030315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGyZgaoUMpdXX1Wex/SmBCCZR56/f91ve/VwNHuEkZg=;
        b=Fb20pxloZaZRbrbIQIubHKm49dnkDNVq5u4Ks0tlH6gD0zr1AZGaQaNk8Fd1OdV6y9
         CW6ZpYdtqKcgFNHMQG18oHSGiD344/ZomVnXR3bb7JJz/lNHu6P6ifJffKoOzdAxeu8L
         14oOBVQmW39ipJvhm9HubNNqPQDa82zGj78DYR75OLUkssbEc65xyFvejNDFF1kb1QIu
         KB0bFfMezSFKwbN7P10BfuxgECcyrnjLOlwpT6v/TT6ksCKKfKcFbxyj2LBx6HWuVcbF
         +gzG9gB6E9BJUWMSuv2moagHG1dilNgkBvFd0aJKB49M7PHZKrz4BwiYZTmAqWfpn5eN
         zpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689438315; x=1692030315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGyZgaoUMpdXX1Wex/SmBCCZR56/f91ve/VwNHuEkZg=;
        b=LkmmemqDY+o/P2V66BGWiEwVw3EX8/H9ra5V0YgqhEGSwJPsLxG+yq6uiGsUTBHnvm
         IPUKh57Oe4NVeZiFvFit2dl+Kr25pecnz0NsEkAJXyHPt5eS6yo+vlQ98FsT4USdbR2/
         KeflfDTa+FdDH2QqR+OrNlXn/3l59F1S6j8L3bXrVvgxClDfY5Jc9KtgwGGGoDb8PgCk
         cMsOgM0c8nhF5DGC3w8Q9aRpUdy5jX7MmJYlTUYYJtSL19kMBNrom6JVjTzS+zfRh0g/
         PdaOZOuUIS4ksxx3bcDWnmWzI7JEZSfnIY7zHWQqaqcnVloi7SDJeLBSe5AYXKdDT8ZI
         /dOA==
X-Gm-Message-State: ABy/qLbAqs2GaLU/bFoYFS7Y7cwBc+g+M98Jen/jjlN51+Uw5Hfbh6NF
        7nCq7xTlZdOahyUlv5AdZ+xTI0a0Y1c=
X-Google-Smtp-Source: APBJJlE9X9oHguRpA3NCyFMHaI4hHBrv53fCOCXLD+8oxKGl55NlkKHWl59L5p1UU2QkjGcwcW9aHg==
X-Received: by 2002:a17:902:7d96:b0:1b9:cca6:551b with SMTP id a22-20020a1709027d9600b001b9cca6551bmr5745979plm.7.1689438315553;
        Sat, 15 Jul 2023 09:25:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c10-20020a1709029d8a00b001b83db0bcf2sm9676155plq.141.2023.07.15.09.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 09:25:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 15 Jul 2023 09:25:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Fix incorrect PWM value
 readout
Message-ID: <b8b5d0e3-10a1-479d-824f-19f4c75530d4@roeck-us.net>
References: <20230714120712.16721-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714120712.16721-1-savicaleksa83@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 02:07:11PM +0200, Aleksa Savic wrote:
> Commit 662d20b3a5af ("hwmon: (aquacomputer_d5next) Add support for
> temperature sensor offsets") changed aqc_get_ctrl_val() to return
> the value through a parameter instead of through the return value,
> but didn't fix up a case that relied on the old behavior. Fix it
> to use the proper received value and not the return code.
> 
> Fixes: 662d20b3a5af ("hwmon: (aquacomputer_d5next) Add support for temperature sensor offsets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/aquacomputer_d5next.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index a981f7086114..a997dbcb563f 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -1027,7 +1027,7 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  			if (ret < 0)
>  				return ret;
>  
> -			*val = aqc_percent_to_pwm(ret);
> +			*val = aqc_percent_to_pwm(*val);
>  			break;
>  		}
>  		break;
