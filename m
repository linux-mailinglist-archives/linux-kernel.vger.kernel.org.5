Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965AA7D79EA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjJZBD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJZBD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:03:27 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765EEAB;
        Wed, 25 Oct 2023 18:03:25 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a90d6ab962so2531237b3.2;
        Wed, 25 Oct 2023 18:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698282204; x=1698887004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WrM4E7UT9gMAfZY/UT00yV8LoPYhUEnBYTYxCfk/DxI=;
        b=gkp/LUqWFXYEVha2hQepZ6zvU7Cl9IZT5PJfykaCAPD9bcJMqOkdoACkEY8sADLqiE
         Ejbo6RJGsufsgkgCoYaOXM7WFqdnPcdR4nmBjweSfkntdQQplogN9CEJYRK3tihcY6mX
         DXtT/WE30oJIQujvlEuWEwDhCfN/DKFF+7iy6ojDN0VcRVY1GXHhF/wtvHvVKX7s3Gly
         wsmB3vEVPTCXf7zoP9156ZisMsB6Rtg+y5AMYhipF7OhrENV8AEJ56qMPWh0uE+x1P3C
         mGjnuDkLTVDHNaBuaHwLqNwGXBYmndk2Ng1mbNEW1VYlYcai1NLrthXuo8sKxqfm6wyn
         j+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698282204; x=1698887004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrM4E7UT9gMAfZY/UT00yV8LoPYhUEnBYTYxCfk/DxI=;
        b=lxIcMEAio1rwwfEiey1J04IrT9I1Ed1MQlJxWU23yEgMY2R2YC9p6xmxqOvVdm6sOp
         v86sx9yLMWIyQC2Y8MfQOgxwJxwH3uqo8oaTm16ZHIFrUnWwOKdEZMr1i/ArOMAv/Wz3
         GanfPFeXtqk3yDmMeBQ6XPeDEs/8audya3FgK/Nvmr3gcojYWDez814Np/MAbCM74Vit
         EdIvVaO38kdHAyyYo98IIn3fkyLtfIhR2F+qchEfkVa2rW9SuVznR4xoS/h72mZ5F5rz
         4ISDN1pFSKoYe9E7RyIOtUPySLPn7n8Q++4RIsMBzi70SVmw0tDchiFrXp+vYKbLcpNa
         yCDw==
X-Gm-Message-State: AOJu0Yz7DxlqUFuaQVxXLMPN7mF+HSyYB9tZ9DnZ2IC0i5GTmZya+oJu
        uGS6cUrjHBkvMdnguIwaI2k=
X-Google-Smtp-Source: AGHT+IHs0oqTMEljgSgaCwNCoS+Nl5WwHpn3eBD432MhDB0JLivK/oEmJ9Qk8bLk/xKng9iYyQjdOw==
X-Received: by 2002:a0d:d54a:0:b0:5a7:d412:af32 with SMTP id x71-20020a0dd54a000000b005a7d412af32mr18122487ywd.10.1698282204629;
        Wed, 25 Oct 2023 18:03:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p130-20020a815b88000000b0059b20231f1dsm5525876ywb.121.2023.10.25.18.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 18:03:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 25 Oct 2023 18:03:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Richard Leitner <richard.leitner@linux.dev>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] MAINTAINERS: Add entry for ina238 driver
Message-ID: <f5d92f5b-dc78-4227-b556-2617ef239496@roeck-us.net>
References: <20231025-ina237-v1-0-a0196119720c@linux.dev>
 <20231025-ina237-v1-1-a0196119720c@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025-ina237-v1-1-a0196119720c@linux.dev>
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

On Wed, Oct 25, 2023 at 10:34:11AM +0000, Richard Leitner wrote:
> The ina238 driver is available since 2021 but lacks a MAINTAINERS entry
> file. Therefore add the missing entry now.
> 
> Signed-off-by: Richard Leitner <richard.leitner@linux.dev>

NACK. I am already the hwmon maintainer, and there is no need
to list me as maintainer for every hwmon driver.

Guenter

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 668d1e24452d..28f91c8a2e1c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10267,6 +10267,12 @@ F:	Documentation/hwmon/ina2xx.rst
>  F:	drivers/hwmon/ina2xx.c
>  F:	include/linux/platform_data/ina2xx.h
>  
> +INA238 HARDWARE MONITOR DRIVER
> +M:	Guenter Roeck <linux@roeck-us.net>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	drivers/hwmon/ina238.c
> +
>  INDEX OF FURTHER KERNEL DOCUMENTATION
>  M:	Carlos Bilbao <carlos.bilbao@amd.com>
>  S:	Maintained
