Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E9A75DE19
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 20:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjGVSY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 14:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGVSYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 14:24:24 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824FD2727;
        Sat, 22 Jul 2023 11:24:20 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3456fda4ed1so15984495ab.0;
        Sat, 22 Jul 2023 11:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690050259; x=1690655059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFxsM2OL5aJZXeujrybxptIwXjhT5R/1lLYKKwOWi0A=;
        b=Rvz9B8lVED3sN95U3XJl3TEtiukuSzsbOdesAzL7Svh6lfkhCGSpvC4TVwGM1znFr5
         WBsoaENrEPDhbLdU7BFyO+3/1dhrZ1jtTlQA8HH1nG2hKA8WdF0uiSpO1LeHq/P1wZd/
         6aETySLJTt3ON1+Y1ICFKqbjpDDJ+MBf8wZFxU8NpIP2GWka0GRmZeTmpmoelGUh6e6K
         lqUaMr4IV2yKNFxwI7sLAlScTtchaNBnUsQYl7pZhUaV06W7smAGy3j882s85phB7+fW
         JT96qJRM2Y+SNVbnMxGT/UXXpu3fdNt/Fi8sjJBS0I6E1iRy+FcViz5nmQ1ikEK/hqHe
         0qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690050259; x=1690655059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFxsM2OL5aJZXeujrybxptIwXjhT5R/1lLYKKwOWi0A=;
        b=fl4glydN/Ie/SBH5SdBoaXnRmhyJ+TX5gGt/Ls4H6LHrhNXYKP61Rq8FcVdunyY8/s
         C5xpb2T1wofxoelrdM+EotBbwhWC2MS3xSLrbrEpv+cOUq5/yNWoR5U9mNXr8JenGMwr
         lF1lGEcpDxXURyP6y0/2PD9ehAas960x+xaAoL25rTDpo54YyVUfbpxM6YMSKg0Be5g/
         3xCznzvVTbYbhiHbo/On3Ohgze+ZEAVsLJUABhDsB18QohatvSw/dwBU2sbOiZuAHPNx
         XDBMiYvt968FYYMRJDjvVZszV/iLuVGqHWHwEaQE0kbCysEAyKBaqQx5g2wfJS2qNTdk
         Z5uw==
X-Gm-Message-State: ABy/qLavdWplaAET/Dndsp2E6QHBNq7r17tftwHTW6KjX/twYRWIKfdo
        YUfrJfKyUeDmsf3ZDt33ut1BVXunjR8=
X-Google-Smtp-Source: APBJJlEY1z+uGDMNv16OaY3bOqUl4wO6kTsdNz9BhmYFs1kf3sCGPSK6brp3AVFyKS80vnEWmSFWUg==
X-Received: by 2002:a92:cd8a:0:b0:345:7497:3cb7 with SMTP id r10-20020a92cd8a000000b0034574973cb7mr4367445ilb.10.1690050259620;
        Sat, 22 Jul 2023 11:24:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v10-20020a02cbaa000000b0042036f06b24sm1828981jap.163.2023.07.22.11.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 11:24:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 22 Jul 2023 11:24:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Seo <james@equiv.tech>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: hwmon: hp-wmi-sensors: Change document title
Message-ID: <7a689374-25bd-4b82-acbe-159fb85a2347@roeck-us.net>
References: <20230722172513.9324-1-james@equiv.tech>
 <20230722172513.9324-3-james@equiv.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230722172513.9324-3-james@equiv.tech>
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

On Sat, Jul 22, 2023 at 10:25:14AM -0700, James Seo wrote:
> Change title to "Kernel driver hp-wmi-sensors" for consistency with
> most of the rest of Documentation/hwmon.

Not sure if it is worth it, but either case: Signed-off-by: missing.

Guenter

> ---
>  Documentation/hwmon/hp-wmi-sensors.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/hwmon/hp-wmi-sensors.rst b/Documentation/hwmon/hp-wmi-sensors.rst
> index a6bca9aecdde..a611c6263074 100644
> --- a/Documentation/hwmon/hp-wmi-sensors.rst
> +++ b/Documentation/hwmon/hp-wmi-sensors.rst
> @@ -2,9 +2,9 @@
>  
>  .. include:: <isonum.txt>
>  
> -===========================
> -Linux HP WMI Sensors Driver
> -===========================
> +============================
> +Kernel driver hp-wmi-sensors
> +============================
>  
>  :Copyright: |copy| 2023 James Seo <james@equiv.tech>
>  
> -- 
> 2.39.2
> 
