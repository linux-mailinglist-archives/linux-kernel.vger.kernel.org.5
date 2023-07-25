Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBF6761D06
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjGYPME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjGYPMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:12:02 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2346F128;
        Tue, 25 Jul 2023 08:12:02 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-563de62f861so7157a12.1;
        Tue, 25 Jul 2023 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690297921; x=1690902721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1K+i7mlSf2+UQsadMuz2ht79KN5VhwZVnNbPb9Y0ncE=;
        b=Fuw2K/IiWZgWLZow/It4IMeAsOn9oA0KIRavpmmuefFzF0OEMS37Q0+sD9gLbhbn9M
         baSNjKDfZybqhKMUmhHqUm/yYKWARfQqGHZALVfbgcxMvdztBlgm5P+64f6/KGT1rmhw
         X1LzS6JF+VY59pm/0MMKt8cj/wkWIeheS2TEgP1NLRoJedV6xf8ujOxI3M/wQL5iv0TD
         hISaaM+6w9lIF80bmnb/8TBiGC4lHI3POsuOzSp3U0HtNgRFLXkJAIEY8JaJMnB2RGUm
         FkcL21SeZmjlzl6lyAf/odFonpohMDz2BdrBbwiTKtqYZozhp2lEUpu0mBheBx2pDBMr
         /veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690297921; x=1690902721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1K+i7mlSf2+UQsadMuz2ht79KN5VhwZVnNbPb9Y0ncE=;
        b=hIHC6JaqqswLppq6awKk66+T1BgDcyNhtwCfT00275S3gcKKY4IgeaDHnPmhml/GKd
         X3E1BTF8xnb9oQwDK3PKFbUHWwTqLeVrVoW+hU7xQfCuTn1BCtWXtl24hDLewSU23ZJO
         wcEqhvtrByz7cLIyPfZ4C/6++rwwTFtjXngpEOtOiemudKHClIsjjvGvI2sRTK7bp5zd
         kbQvAhmdBDQ/xs09+TMUmvNvw6ArIE83FgM9HeDLSteY07h6knBqFVoOEDllLlfKn2hh
         c2ZVtYB6EaFumtdmKUOhSc3SQfRmCIn+5LQvQfc7OVCaRuXp0XfhVfR0WZoC3i/frcJo
         9zxg==
X-Gm-Message-State: ABy/qLZyRnIelF+dHorQCgLHHQxpyeA2zGlyJSschPIbKHdpyXZ7Q1ys
        J73CTpa9EMuSWcfrepNzNgA=
X-Google-Smtp-Source: APBJJlFzRkJFGHJD6i4My0dQn8buh5u10emnPTWynCNoKwvLzyLDMgHocPqch0Xif0RMyK/R1W7D5A==
X-Received: by 2002:a05:6a00:9a0:b0:686:baf2:35f4 with SMTP id u32-20020a056a0009a000b00686baf235f4mr388055pfg.29.1690297921510;
        Tue, 25 Jul 2023 08:12:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m7-20020aa79007000000b006636c4f57a6sm9793039pfo.27.2023.07.25.08.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:12:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 25 Jul 2023 08:12:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Seo <james@equiv.tech>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (hp-wmi-sensors) Initialize pevents in
 hp_wmi_sensors_init()
Message-ID: <46734914-d323-44b3-8e97-b34aa4fc9f89@roeck-us.net>
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
