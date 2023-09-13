Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C58379E05A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbjIMHC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjIMHC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:02:26 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AA7173E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:02:22 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9aa2c6f0806so376644066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694588540; x=1695193340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z1rc1LzbJvJ0G+OA+LqqEMmtttFt0Qb849U5LVF5BIk=;
        b=jXV8LyzdTB48lSCITDrh0bhcp3AWZlg4KylufRDHhVIPKwBL1GdfIA6JXQhjm8+CIQ
         ybsMNVbwPvUw1M3Msa4OkfD+KAnSXEYbLgFV+5coCdfGR4x4yHUHo1aPkJ5sWvy5PJ8B
         lvbKkg/7cvhf90u1A+xg6sHqg3wo0Ae2fjzfE80IFymw0Pu9wSi87uDE7oZ1v+H06v4Z
         BT3ksOONBKiGZp3b7EQTSGpG2s9rG3GxtQ75wXf1nNxvo9mGDS70FGXY+nDEmhVxNDjc
         qW7JHHQUdJ5sTcd2DRsxd+2zTgF1UsYYC220nsP7K00avRYbXAznCzwYju6SkU6k/f1m
         nnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694588540; x=1695193340;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1rc1LzbJvJ0G+OA+LqqEMmtttFt0Qb849U5LVF5BIk=;
        b=Vdty5/yW34+0tZMPGB8EWn4RhZTSy2JJawYU1KoxYjrvRYUOB9tOntn6TSsaTjqldb
         ozIe+ij60QoofQJq5sZqKiC0pMbVMVBJIHeOc2tu+OMJt9Iba7D2++8JX5j0IH/gnxLc
         iRKNU3wtsV4jZFPR90awI3M4q1zsrpxpUdQZnTPGRlJmPaR5bZ1Soah6FXlQieriTyS2
         PoX/hOMsQRg/r5ZeKmTuxF4nTDvB7WrxTOpaWW0XyrdlHXsXlOapjBrbOw4jIfh8yh5V
         CeETfMBWgI2d8W0FN4CFpXwdlnDZVCIpPBBCDVMgU2wSsCwEgx6ru0duh5uaz+eu62bc
         +DCQ==
X-Gm-Message-State: AOJu0YzYwPafPxhAQvwwjNDkzv83zHUd4JQO0NZQ9g3X/QIrQ1c7QC/q
        94Le9/oNgoqmgZBB6nmOBkMZUw==
X-Google-Smtp-Source: AGHT+IHnEJGHmwstPMJ15Zy3Rri6suCLCTKqHXLKWj9VzFdV1R44d+EmH96hsTtvp4FgjExxgPAXPg==
X-Received: by 2002:a17:906:1da9:b0:9a1:d087:e0c0 with SMTP id u9-20020a1709061da900b009a1d087e0c0mr1099470ejh.42.1694588540407;
        Wed, 13 Sep 2023 00:02:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906941800b0098921e1b064sm7871387ejx.181.2023.09.13.00.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 00:02:19 -0700 (PDT)
Message-ID: <cc6ad994-a3c3-03d6-6095-14e43f105314@linaro.org>
Date:   Wed, 13 Sep 2023 09:02:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V2 1/5] ASoC: dt-bindings: Adds properties to
 "awinic,aw88395"
Content-Language: en-US
To:     wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        rf@opensource.cirrus.com, shumingf@realtek.com,
        ckeepax@opensource.cirrus.com, herve.codina@bootlin.com,
        13916275206@139.com, ryans.lee@analog.com,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        fido_max@inbox.ru, povik+lin@cutebit.org, arnd@arndb.de,
        harshit.m.mogalapalli@oracle.com, liweilei@awinic.com,
        yijiangtao@awinic.com, colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230912065852.347000-1-wangweidong.a@awinic.com>
 <20230912065852.347000-2-wangweidong.a@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230912065852.347000-2-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 08:58, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Adds properties to "awinic,aw88395" to make files more complete
> 
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
> ---
>  .../bindings/sound/awinic,aw88395.yaml        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
> index 4051c2538caf..4965aa4a5370 100644
> --- a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
> +++ b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
> @@ -32,11 +32,28 @@ properties:
>    reset-gpios:
>      maxItems: 1
>  
> +  awinic,audio-channel:
> +    description:
> +      It is used to distinguish multiple PA devices, so that different
> +      configurations can be loaded to different PA devices
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 7
> +
> +  awinic,sync-flag:
> +    description:
> +      Flag bit used to keep the phase synchronized in the case of multiple PA
> +    $ref: /schemas/types.yaml#/definitions/uint32

Looks like bool, not uint32. If you made it uint32 for some future
purpose, then the name "flag" is misleading and anyway what would be the
third option here for sync?

Best regards,
Krzysztof

