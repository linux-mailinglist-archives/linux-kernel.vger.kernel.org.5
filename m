Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688D37C98F5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 14:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjJOM2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 08:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjJOM2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 08:28:30 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBE0A9;
        Sun, 15 Oct 2023 05:28:28 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-49dd647a477so1119710e0c.3;
        Sun, 15 Oct 2023 05:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697372907; x=1697977707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhN3921uVY9PqUXI+6AaZ5ld60TSo4nIWxl7BRmfz8Y=;
        b=OMJzpElznPawud3NLGCoSifRWT2/ziX5hPqAxXRywoWQkCvUjs/kx2McAEuyLTOkMu
         INYT/gMZBGUe4LljlQru9cy4nWxo7ZibTs94f2j7tdTKonowPpPRFCIbj+gvCXPnIQ40
         8ZUobf7tX9P6AR6DCGodYVTITVW8Tf65HpJTBXonTKxTzkbfnOukemqcLzwmQUB8jD1S
         /Wycmg1k2L/XrDnaXWZo87sseGqG30xpd8SpXq2pS2lbfZB81hbdUO8rxKJ5/EJtP/qy
         qf9BFNPz0hcn6N0e2CYGmOsXs8khVUFNXLflT2CPFOhOGbu+3u450OzqbvwYqyLPriYk
         xARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697372907; x=1697977707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhN3921uVY9PqUXI+6AaZ5ld60TSo4nIWxl7BRmfz8Y=;
        b=VZAid+X7mlX23KiORJX0IEFnCKu/tt5kdhup0Xcc1uttPMbKnZ11rX7vm9Z9aAvXSk
         BEim1cdnotlLEuuIrrpI/jDQgrxZPGGZlC1fLKeYbRbIqsVNZH0N5uZWdyH3h6PIURBA
         WMrO5jthlJ4ykXc+sjrxCj29ewlkOJ6JvxvkfGqpYFCtvFXglQXhFPrpXfmwqPS9UC8X
         UVvEN+4XtjcYAkKV/TWv/PA/YmFwqcp+WVyL+k2/Dej0fhW2OFWrjqFXOVuDmyn3CPGe
         hJn48pBXdXTlrPhdOYE+XFWvHnQOTVSCU/SkiazQp8sgyEG+7fjkglA94oELdLF1YGdh
         gZ3g==
X-Gm-Message-State: AOJu0YxwnaLPiupm8qoTEKxmIa1Nit9N5BQd4eoRfNLzT562QRMQXrNd
        BZBuPJLbK9Fq2fN5V43LoykokdQ9qxI=
X-Google-Smtp-Source: AGHT+IFtyQ7J8Sgj1URA5BtqngSz+OP4M9Yws66VQ+ciwMUqwwpacd5z7TEbqONzrD/Gqm6yeMFnmA==
X-Received: by 2002:a1f:cb45:0:b0:49a:b737:4dfa with SMTP id b66-20020a1fcb45000000b0049ab7374dfamr23493661vkg.4.1697372907380;
        Sun, 15 Oct 2023 05:28:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f191-20020a1f9cc8000000b0049d0fd4d2ffsm584705vke.35.2023.10.15.05.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 05:28:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 15 Oct 2023 05:28:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nik Bune <n2h9z4@gmail.com>
Cc:     wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        skhan@linuxfoundation.org, stwiss.opensource@diasemi.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: watchdog: da9062-wdt: convert txt to yaml
Message-ID: <aa7cdd4d-b8bd-47df-b0ad-2384076c279f@roeck-us.net>
References: <20231014170434.159310-1-n2h9z4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014170434.159310-1-n2h9z4@gmail.com>
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

On Sat, Oct 14, 2023 at 07:04:34PM +0200, Nik Bune wrote:
> Convert txt file to yaml.
> Add a mainterner block. Took a value from dlg,da9063 PMIC.
> 
> 
> Signed-off-by: Nik Bune <n2h9z4@gmail.com>
> ---

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> Changes in v3
> - Changed type of dlg,wdt-sd property from boolean to uint32. Following the discussed in v2 patch thread. 
> 
> v2 patch: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231010211439.98458-1-n2h9z4@gmail.com/
> 
> 
>  .../bindings/watchdog/da9062-wdt.txt          | 34 -------------
>  .../watchdog/dlg,da9062-watchdog.yaml         | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
> deleted file mode 100644
> index 354314d854ef..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -* Dialog Semiconductor DA9062/61 Watchdog Timer
> -
> -Required properties:
> -
> -- compatible: should be one of the following valid compatible string lines:
> -	"dlg,da9061-watchdog", "dlg,da9062-watchdog"
> -	"dlg,da9062-watchdog"
> -
> -Optional properties:
> -- dlg,use-sw-pm: Add this property to disable the watchdog during suspend.
> -	Only use this option if you can't use the watchdog automatic suspend
> -	function during a suspend (see register CONTROL_B).
> -- dlg,wdt-sd: Set what happens on watchdog timeout. If this bit is set the
> -	watchdog timeout triggers SHUTDOWN, if cleared the watchdog triggers
> -	POWERDOWN. Can be 0 or 1. Only use this option if you want to change the
> -	default chip's OTP setting for WATCHDOG_SD bit. If this property is NOT
> -	set the WATCHDOG_SD bit and on timeout watchdog behavior will match the
> -	chip's OTP settings.
> -
> -Example: DA9062
> -
> -	pmic0: da9062@58 {
> -		watchdog {
> -			compatible = "dlg,da9062-watchdog";
> -		};
> -	};
> -
> -Example: DA9061 using a fall-back compatible for the DA9062 watchdog driver
> -
> -	pmic0: da9061@58 {
> -		watchdog {
> -			compatible = "dlg,da9061-watchdog", "dlg,da9062-watchdog";
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml b/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
> new file mode 100644
> index 000000000000..f058628bb632
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/dlg,da9062-watchdog.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dialog Semiconductor DA9062/61 Watchdog Timer
> +
> +maintainers:
> +  - Steve Twiss <stwiss.opensource@diasemi.com>
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    enum: 
> +      - dlg,da9061-watchdog
> +      - dlg,da9062-watchdog
> +
> +  dlg,use-sw-pm:
> +    type: boolean
> +    description:
> +      Add this property to disable the watchdog during suspend.
> +      Only use this option if you can't use the watchdog automatic suspend
> +      function during a suspend (see register CONTROL_B).
> +  
> +  dlg,wdt-sd:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    description:
> +      Set what happens on watchdog timeout. If this bit is set the
> +      watchdog timeout triggers SHUTDOWN, if cleared the watchdog triggers
> +      POWERDOWN. Can be 0 or 1. Only use this option if you want to change the
> +      default chip's OTP setting for WATCHDOG_SD bit. If this property is NOT
> +      set the WATCHDOG_SD bit and on timeout watchdog behavior will match the
> +      chip's OTP settings.
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    watchdog {
> +      compatible = "dlg,da9062-watchdog";
> +      dlg,use-sw-pm;
> +      dlg,wdt-sd = <1>;
> +    };
> -- 
> 2.34.1
> 
