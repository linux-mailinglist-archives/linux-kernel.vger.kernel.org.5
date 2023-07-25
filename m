Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C93761D00
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjGYPKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjGYPKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:10:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08621FF3;
        Tue, 25 Jul 2023 08:10:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8ad907ba4so29147565ad.0;
        Tue, 25 Jul 2023 08:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690297808; x=1690902608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1K+i7mlSf2+UQsadMuz2ht79KN5VhwZVnNbPb9Y0ncE=;
        b=gZsR9O+6lSmiy4LzYiS855WPSn4QWJUZ/0QmdmQdjPZHwinY1ruFsvPXiJlBbdzF+t
         30IL6IxLhwbUE3aIyxxlTOlt2FiRPvNEmWxlxeTAAKdKdPPj2iF7Y4mtKnbQWr9FoJ4j
         vHf1a+AtFuwAQw6eZ6p+hSgVCd3lWnnJHlkN8DRNCFyFPH+rkkGJFJN76AaM4tmf/1K7
         xatywjfwJRxX8SbpfpEMZFtjaVn7lUY5+JY5qsAuxvyRyUAKajdXOKHl5Pj/ZjN3yXK/
         tyf9MLJZ0NNivxqiUQElrUF6vo+Ex+ZfFByyZCMOCLFiVkjX7G1ffOy6H8fawau/yjtv
         +jlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690297808; x=1690902608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1K+i7mlSf2+UQsadMuz2ht79KN5VhwZVnNbPb9Y0ncE=;
        b=G5+E/ZmsDnycLrxyRQgUmr2+2ZDML2fmBRL1sorgpVxDc+YG4+pACdfLEYO4WAcpE0
         zAwQ8ctvkIMC+nloaFH5zHgcrMFGB6VaD5h3j+O37VtLAjXYjGKFQerlefOUY92S5Z0g
         CC+llx9q7y3IavOpuCkM19RScCcFJWxw7KRPjUUfCK3AsBDv6HsdGYRUCa/wCoQbVbWK
         vAnO9NOqDAAnDR8G10vNdJ2Gal8QcfC1W21055bIjhvFO/QrK7G4XNvzTrrAtBYegGBb
         h3j/y0eqyXCf0f342EATxNwmfDGWu8llvypnCDFz5ycRxqZ5DLyMxY2XrUZr/pdklfBt
         EvGw==
X-Gm-Message-State: ABy/qLZ6GP4EYt0LfOznRyTHLN4fOYIPFuAzzTXQbEUTPmiXKSXAz9tI
        xHuaZSXObuptZJTUkOewZWp5riT0SQ8=
X-Google-Smtp-Source: APBJJlFnx77ckpnQMESYR7HJ9waI0Jko3LiJyOZb8alJ21T+1O9EQ5Gu93l4HnQEf9LtqWAObpg2RA==
X-Received: by 2002:a17:902:e805:b0:1b8:4e69:c8f7 with SMTP id u5-20020a170902e80500b001b84e69c8f7mr11932791plg.23.1690297808087;
        Tue, 25 Jul 2023 08:10:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902728100b001a5260a6e6csm11174298pll.206.2023.07.25.08.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:10:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 25 Jul 2023 08:10:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Seo <james@equiv.tech>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (hp-wmi-sensors) Initialize pevents in
 hp_wmi_sensors_init()
Message-ID: <324b865f-9afb-43cf-8a84-b16c360fbcce@roeck-us.net>
References: <20230725094817.588640-1-james@equiv.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725094817.588640-1-james@equiv.tech>
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

On Tue, Jul 25, 2023 at 02:48:17AM -0700, James Seo wrote:
> The following warning is given by the Smatch static checker:
> 
>   drivers/hwmon/hp-wmi-sensors.c:1937 hp_wmi_sensors_init()
>   error: uninitialized symbol 'pevents'.
> 
> If there are no instances of the HPBIOS_PlatformEvents WMI object
> available, init_platform_events() never initializes this pointer,
> which may then be passed to hp_wmi_debugfs_init() uninitialized.
> 
> The impact should be limited because hp_wmi_debugfs_init() uses this
> pointer only if the count of HPBIOS_PlatformEvents instances is _not_
> zero, while conversely, it will be uninitialized only if the count of
> such instances _is_ zero. However, passing it uninitialized still
> constitutes a bug.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-hwmon/f72c129b-8c57-406a-bf41-bd889b65ea0f@moroto.mountain/
> Signed-off-by: James Seo <james@equiv.tech>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/hp-wmi-sensors.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> base-commit: 55612007f16b5d7b1fb83a7b0f5bb686829db7c7
> 
> diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors.c
> index 3a99cc5f44b2..17ae62f88bbf 100644
> --- a/drivers/hwmon/hp-wmi-sensors.c
> +++ b/drivers/hwmon/hp-wmi-sensors.c
> @@ -1913,7 +1913,7 @@ static bool add_event_handler(struct hp_wmi_sensors *state)
>  static int hp_wmi_sensors_init(struct hp_wmi_sensors *state)
>  {
>  	struct hp_wmi_info *connected[HP_WMI_MAX_INSTANCES];
> -	struct hp_wmi_platform_events *pevents;
> +	struct hp_wmi_platform_events *pevents = NULL;
>  	struct device *dev = &state->wdev->dev;
>  	struct hp_wmi_info *info;
>  	struct device *hwdev;
