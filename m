Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4677E2946
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjKFQBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjKFQBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:01:23 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A516C191;
        Mon,  6 Nov 2023 08:01:20 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-28023eadc70so3782851a91.2;
        Mon, 06 Nov 2023 08:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699286480; x=1699891280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/ZJvRrwXA2Jr1mUYtLe2oJYo/zkme5IWQIgqlZsdJU=;
        b=HTrMmpiagdaziZjZcCHsBshtgLiJDNIwKUjjTnZRWd4YSFnT07j7ocUt0xRvLkD0N+
         ggfRS4R7OoudsQB1QLogFBCsOF0hY0xkT6alI6DZqaXhMOsdUUL602r5NhzvMlhHp7Cw
         uavrXxGGj0i7mZe1bRRGxobyBO/qhU6usqYFEmdJg2DIdqYPQ5vEIeU0ivc0hJ/+r91h
         CxdHCPy6g5VGmP18aI+fipJ9GZYFvZu2XKuWM1xIdw77e8njrUhRkhoxG8UBWVi4Oppf
         Jsf/OBr8F0d+ZLmeYQXy1sJ46WYY/9MU6WxsHvYR2fDSyLE8wz2p0qMRItgU4ABikwOs
         YzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699286480; x=1699891280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/ZJvRrwXA2Jr1mUYtLe2oJYo/zkme5IWQIgqlZsdJU=;
        b=mZPdKKc1hF8Y5HVXX9081UncxZgogBP/IJOaSMcw7X5zRzXqfZI8nF+gjmsU2OgY5P
         FszkXI7JBmpGmB0J3YS9GiF219lJs+htjd00y1/Ffq/AXpHrgMAgH2b+NGQPcRrCQf1J
         uvy4ya+x8JLj6yv1NKUl7FBgVP3o5k4RO5u6RE3klMUh3+lIcc5/6t2NU+vJnwTTqig8
         jrmSJOGb30sqIuplpl3SOnQ0xt2oHLZ3/3QEYZ53eJ2Njd6H2GdUiYFl6mtSR5GK9BLL
         3285xOc7IuvimLPcs+LEzfSKdNYhM9HNXMjFzIJUER8t93dlMXk+pLqkp/icPg16xuPB
         gO9A==
X-Gm-Message-State: AOJu0YxPytjUQTA5YIc6m9HGHUmh9I21+nGnq31/FVy49akQgCgYFeE3
        S+MpCVPoMhxgNDGozQqNYhw=
X-Google-Smtp-Source: AGHT+IEPFLOrUvORXeB5tk1m/mourVb+H8FJ1SN93sBnY40s2lSeD4Zqn0rnsc50ASb1js34bpWiQA==
X-Received: by 2002:a17:90b:4a01:b0:27c:fafd:f785 with SMTP id kk1-20020a17090b4a0100b0027cfafdf785mr18431837pjb.47.1699286479695;
        Mon, 06 Nov 2023 08:01:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cn18-20020a17090af09200b0027d015c365csm5664356pjb.31.2023.11.06.08.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 08:01:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 6 Nov 2023 08:01:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Nik Bune <n2h9z4@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: rectify entry for DIALOG SEMICONDUCTOR
 DRIVERS
Message-ID: <82dbb256-f79a-4bf1-a7c4-d43dd8926318@roeck-us.net>
References: <20231106095349.9564-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106095349.9564-1-lukas.bulwahn@gmail.com>
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

On Mon, Nov 06, 2023 at 10:53:49AM +0100, Lukas Bulwahn wrote:
> Commit bd888a4377ae ("dt-bindings: watchdog: da9062-wdt: convert txt to
> yaml") converts da9062-wdt.txt to dlg,da9062-watchdog.yaml, but misses to
> adjust its reference in MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Repair this file pattern in DIALOG SEMICONDUCTOR DRIVERS.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0410322b740a..bd9077b1fd41 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6123,7 +6123,7 @@ F:	Documentation/devicetree/bindings/regulator/dlg,da9*.yaml
>  F:	Documentation/devicetree/bindings/regulator/dlg,slg51000.yaml
>  F:	Documentation/devicetree/bindings/sound/da[79]*.txt
>  F:	Documentation/devicetree/bindings/thermal/da90??-thermal.txt
> -F:	Documentation/devicetree/bindings/watchdog/da90??-wdt.txt
> +F:	Documentation/devicetree/bindings/watchdog/dlg,da90??-watchdog.yaml
>  F:	Documentation/hwmon/da90??.rst
>  F:	drivers/gpio/gpio-da90??.c
>  F:	drivers/hwmon/da90??-hwmon.c
> -- 
> 2.17.1
> 
