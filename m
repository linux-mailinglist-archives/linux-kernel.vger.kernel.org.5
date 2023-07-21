Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F2075C80C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjGUNmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjGUNmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:42:04 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABEA1722;
        Fri, 21 Jul 2023 06:42:03 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666edfc50deso1357135b3a.0;
        Fri, 21 Jul 2023 06:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689946923; x=1690551723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ma570Bdn3cwknPzORB+8tE1TTAnqybBCYnCZYlb551M=;
        b=VnV7fhqoF241mX8uDGONkp94/HXy7GAlBoDoyvwMIKlvRhap7jfh7SQ1xYZj3kVq99
         tVz+h2pQvNWukDQ87fWSraVkmfHMWHlJpxO3CBQEXBOQ0iqRyQCH2yFESclQwT8rhRDE
         i05xwzjhsx6AIkUPSyCL6nKjNy76RdUZEH/F5euQ9u3lags3uJoUcbmF9NJkPA7eF5Lh
         RjjKXBnxy4RKdNnd0UvGXtxu8fCojahHQP7C/YgXml/Uts42Tekx4uHxpDe201y+EoDO
         fgSwYXdo9WGis7Urm5WukiDpbPZ/2eXAdiN6hBU9xWmxlll15V3X/qdQ+xJNOjfLaBSu
         EyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689946923; x=1690551723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ma570Bdn3cwknPzORB+8tE1TTAnqybBCYnCZYlb551M=;
        b=ftBGGHYq2UTR8SpWa6ffT8xzQGygGsrLB2ZhfV0Xm5qXSmV+2bvCl22zYvbMnDewQb
         HB/fU+NDIPw08/KbESeiFOQuTYVL6rayWxWrEOArmPMjgSiGnaqr3dzBDFLS6jJ2p9BY
         kfGZ2i7Q7Cmts39m+Fgc6oA+Iy/rJOy/D5xvEzKXgb2lBzp7vYtiXCKmbv3t5+PiK7rA
         Z4JjpYLeqprJhY4fklUmNg8ZXw1Qoy2G5glpIOKU12fPl7Q+OuUEIsjESLbvnDCQEkpo
         OX+zQMgGppiSCP2guHlo6Y1tW2jBFochmXYd48BIE3faVkUJKxKw82apdKm5drWZ8NZf
         ms/g==
X-Gm-Message-State: ABy/qLZ9/J5U2keiumGITAH2La4EJKLT7VCaaHrLiWjcLjWFSgcJ44YT
        5J4wud63MnYwSG0w9D+AoPk=
X-Google-Smtp-Source: APBJJlHMePiTjCA/IB4qRQ04dKomcs4sSzWZbyZzg8ESqUPVIgOvkgYhO5BBmrQp5HJkqJ8m+mToBw==
X-Received: by 2002:a05:6a20:4411:b0:132:f926:5891 with SMTP id ce17-20020a056a20441100b00132f9265891mr2701504pzb.4.1689946922654;
        Fri, 21 Jul 2023 06:42:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3-20020aa79243000000b006732786b5f1sm2952576pfp.213.2023.07.21.06.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:42:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 21 Jul 2023 06:42:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florent CARLI <fcarli@gmail.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yoann Congal <yoann.congal@smile.fr>
Subject: Re: [PATCH] watchdog: advantech_ec_wdt: fix Kconfig dependencies
Message-ID: <3ea7f3f3-c153-4ee9-98e4-5f01de0ac88c@roeck-us.net>
References: <20230721081347.52069-1-fcarli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721081347.52069-1-fcarli@gmail.com>
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

On Fri, Jul 21, 2023 at 10:13:47AM +0200, Florent CARLI wrote:
> This driver uses the WATCHDOG_CORE framework and ISA_BUS_API.
> This commit has these dependencies correctly selected.
> 
> Signed-off-by: Florent CARLI <fcarli@gmail.com>
> Co-authored-by: Yoann Congal <yoann.congal@smile.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index ee97d89dfc11..2108283b438c 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1075,6 +1075,8 @@ config ADVANTECH_WDT
>  config ADVANTECH_EC_WDT
>  	tristate "Advantech Embedded Controller Watchdog Timer"
>  	depends on X86
> +	select ISA_BUS_API
> +	select WATCHDOG_CORE
>  	help
>  		This driver supports Advantech products with ITE based Embedded Controller.
>  		It does not support Advantech products with other ECs or without EC.
> -- 
> 2.39.2 (Apple Git-143)
> 
