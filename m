Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F664781980
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 14:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjHSMT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 08:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjHSMT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 08:19:58 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72B31B338;
        Sat, 19 Aug 2023 05:18:41 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-688787570ccso1388835b3a.2;
        Sat, 19 Aug 2023 05:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692447521; x=1693052321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LP4BhzHZn+HKypDY1EM8ChXmx2+bUOC7C+vfj1foBU=;
        b=FxykcGOWxWwICgdfXma2xq0dNMY16+jnKtx5Y1rgqS5UXrMEOiYOFmpEvFpdxGnaQX
         662o7o9i01mIEzxmi1ZMshkrM85ZEZHK6hay9TpO6sgew2rhOr61aKHjS4cDAGRARvtQ
         zn3J9PUimY1cg7tjCMzLalFEfoNYR8aE7I5PEk2ZOoM0lFWmSzSmu6F69YHmKZg/d3SV
         1tnyLvYk6pzpbkg2PGzFxk2xWGC5FV6e7logofBMZHKxT+YNjNZF8gImMCY2Qco3t5kQ
         S56IyaJrsHfbZ8XcPhuh3euXBpX2tw9LqZtQUEarsNjOpMRymgVjR0B2dOYRqThJI6y5
         MHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692447521; x=1693052321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LP4BhzHZn+HKypDY1EM8ChXmx2+bUOC7C+vfj1foBU=;
        b=Pk2/8hOaCkw3iFKxj80AuPaoVIBgzZLKEyVl2QVC7FvKkcT3Et4E9+vCjxjuZ3atX0
         cZSvCRey1hBanYZly6MwBm6t3mR3VOVaoiBiNXQLcD+Yi2BwhNhQ/rRXo9NvQRkmWpwx
         vJBQ+QpfCawjjsnwu4g0EJodmQ7Ouf2vNnKF/ccqDLwtujdrReUAECq7GNUeWcLJpzhH
         vPJjz7aDpvIVnmnJ6rymU09n9KcNBSdXNtV5MtSuFysnkjmHDZUjbsJOXIKMSRkBsLFx
         kfW1CT/+gt3PWjVY/oNj5fXPhI2QXBYr+g9vGRnYmgwVksf0/rEPH1G2HhxqFFxHEQMU
         r4Nw==
X-Gm-Message-State: AOJu0Yy2wQ6z5zxH5FM0Kyvgt0bDYQvrkvcOecfO3lkFe/vDnYI6ZRIW
        cDhRJxzM6iOKpbSAD1KabjEnYouS74g=
X-Google-Smtp-Source: AGHT+IEOU2OlCaUhIDhLAkeR+GX6r4RQ3bdebNiCn+BdVxklonlw/okZVdZYhSrmMgU2eiWIhxwV5Q==
X-Received: by 2002:a05:6a20:a10a:b0:138:1980:1375 with SMTP id q10-20020a056a20a10a00b0013819801375mr1678494pzk.25.1692447521136;
        Sat, 19 Aug 2023 05:18:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n16-20020a62e510000000b00687fcb2ba7csm3067242pff.103.2023.08.19.05.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 05:18:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Aug 2023 05:18:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: pmbus: Drop unnecessary clear fault page
Message-ID: <924e7072-f521-41b8-9f15-3c03d316a07d@roeck-us.net>
References: <20230817092527.808631-1-Naresh.Solanki@9elements.com>
 <20230817092527.808631-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817092527.808631-2-Naresh.Solanki@9elements.com>
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

On Thu, Aug 17, 2023 at 11:25:25AM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> The pmbus_check_byte_register function already calls clear
> fault page, so there's no need to do it again in
> pmbus_identify_common.
> 
> TEST: Verified using an I2C bus analyser to confirm that only
>       one clear fault page is being send instead of two in a row.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index cbfabdd69056..1363d9f89181 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2541,7 +2541,6 @@ static int pmbus_identify_common(struct i2c_client *client,
>  		}
>  	}
>  
> -	pmbus_clear_fault_page(client, page);
>  	return 0;
>  }
>  
