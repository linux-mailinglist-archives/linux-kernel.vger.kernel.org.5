Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6963D785980
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbjHWNjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbjHWNjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:39:48 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6343198;
        Wed, 23 Aug 2023 06:39:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-26f3e26e59cso2537856a91.0;
        Wed, 23 Aug 2023 06:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692797986; x=1693402786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOK5CRwsaqs85wt6f2CGJEL5j+Al2yb9ep0E5pLTroM=;
        b=bJLHAqQ5GZGeUGLTMgxzu6PG/h4EcSTPT67BPy7RnqnAlv7C9B3fssI97ZvfThO5iy
         kdiZEh/pdRMCqJZNnQ3WOY65dKULMxBQsdqQsV9DJ49+VOTJdtzUpoXEzVmET9XyUJt5
         RenohtVCeDqthFdOuWi1JPsByhsmxvDomR3zGhEe8S2Q/Na1ZZrHW04bE1YOzicaAcjP
         IQ3HEAnws3KHRwHXPOoObT9H3SXJNN5POcQV6ROoI9E+L6ojac6Q+MEbv8YGlnNRYiMb
         jr2ObCRM/gX/rzw8H22XzZRVbyzUkzabDO1RNc63uZd31kk1ghEKLccMlqsvF1gCvs7B
         4VPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797986; x=1693402786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOK5CRwsaqs85wt6f2CGJEL5j+Al2yb9ep0E5pLTroM=;
        b=lJFz+ZFaJUQUln9Z1UFo3E6ItnALN953F8gblh4VHGvPIRdFacDTSLt4xbw17phFm4
         +awhWuklhCkD/2PqGcECI7/EHnGmN0qS83HyrSFcPaWnaOdfuCnsPyRGywU0tizAiOPu
         UnS2lQItzrvn1M87yO1JnK61kSBz0it6xmFHpE4Vo12lBJkToXmQVgX/rk5kGgJUESdj
         0CFiK9DV1fS9/G5G1axlu7rDULvJ0gTUwp6IzpDYabc3jISmKNKu0tZTCL791vOc3KLF
         z4fHY4ZcyHzu+UZU6IjMtayBERg6H+HZ97jaSWLQrLccr+bBaS5AH+UjJsUZAwNcfWUf
         qnAA==
X-Gm-Message-State: AOJu0YypqqtE/oomj3rf7ENHsK/jPqKvndmZnZhQbQAzFVKQUPhU/ag9
        L2ZgNrlQ0Ulxgro9NDTltPU=
X-Google-Smtp-Source: AGHT+IGjcViQKH3GHOWrPKrXnL7/axkeVL2dFUz1FSPB4G3KOxDlRDcMkp1/S2uPhYGLgxC46dQ0Wg==
X-Received: by 2002:a17:90a:1508:b0:26d:23c3:9f30 with SMTP id l8-20020a17090a150800b0026d23c39f30mr18203197pja.14.1692797986143;
        Wed, 23 Aug 2023 06:39:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v23-20020a17090ae99700b00263e4dc33aasm11337417pjy.11.2023.08.23.06.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:39:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 23 Aug 2023 06:39:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: use capital "OR" for multiple licenses in
 SPDX
Message-ID: <f1197557-7d27-453b-b9df-c6dbb3e0f377@roeck-us.net>
References: <20230823084540.112602-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823084540.112602-1-krzysztof.kozlowski@linaro.org>
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

On Wed, Aug 23, 2023 at 10:45:40AM +0200, Krzysztof Kozlowski wrote:
> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.
> 
> Correct also the format // -> .* in few Allwinner binding headers as
> pointed out by checkpatch:
> 
>   WARNING: Improper SPDX comment style for 'include/dt-bindings/reset/sun50i-h6-ccu.h', please use '/*' instead
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Rebased on next-20230822, so might not apply cleanly.  What does not
> apply, can be skipped and I will fix it after next RC.
> ---
[ ... ]
>  Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml         | 2 +-
>  Documentation/devicetree/bindings/hwmon/lltc,ltc4151.yaml       | 2 +-
>  Documentation/devicetree/bindings/hwmon/lm75.yaml               | 2 +-
>  Documentation/devicetree/bindings/hwmon/microchip,mcp3021.yaml  | 2 +-
>  Documentation/devicetree/bindings/hwmon/national,lm90.yaml      | 2 +-
>  Documentation/devicetree/bindings/hwmon/nxp,mc34vr500.yaml      | 2 +-
>  Documentation/devicetree/bindings/hwmon/sensirion,sht15.yaml    | 2 +-
>  Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml          | 2 +-
>  Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml          | 2 +-

For the above:

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter
