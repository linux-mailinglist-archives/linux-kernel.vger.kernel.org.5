Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE40677DEDD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243832AbjHPKev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243908AbjHPKe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:34:27 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAF3210D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:34:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe426b8583so64401635e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692182065; x=1692786865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Zt5s29TnSg/CAmpiGJTp2KeGbSi5eYrrS3v7ExYhXA=;
        b=XrTS+uZWIuwDbjV2LJQ6SaPt+4MG+NZ0PDne2qv/Mm0VWAwJiLWmy0oA8mNvJ85tZD
         ovhnG7HnZezWid/JQ5eZUvQ5ZkJ43t+JAAU37fuM7hv0eP3cS0691IBZ8N0+gVg5nh+7
         0XjvUI7QiT6DXAkOKBo7kqayPQwo1hmBxUUj2UgFNibnNY7VTekNygLuBdA7XWbFHC+6
         5OkhGyTvnnhvlKTWst3gMYaRrDaEECz99+uYZxU0Lx8BJm6YJThyuV7uWTyaZu7Am2tM
         I1/d4RLrNTe/Nuow5B7Ins8jTXRqyuUM8YJeP4wXGxm/CcqWN0hRzHU4ucZbo/w9l2Iw
         kqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692182065; x=1692786865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Zt5s29TnSg/CAmpiGJTp2KeGbSi5eYrrS3v7ExYhXA=;
        b=Vx8qhX5bKmxY68ewbqqviZ4HJ+CUos4i8EpCiY0S/DNwDbqgF2I8ZVIIqbfXYbuWZO
         dSygUtZ2QGs2ugRHEOCXsd4NJ75FLS86GUk6WC9jY7X3QY2BPhBBJwOMBZlJ8YFQbFlp
         WpS7gsimoLlJyimOz/lV6bb2s2RqijCI1JmnXOP54PkGeCpcliiz/QrO0Zn8OiVLHlo2
         wvcrCy2OP8S2GRd4YaH5tCT6C5Igcv4f0h6Vh3ndPw+w7EGZq5N5eXJ0FoQW+Tw+iYwR
         eV5daeGriiPcoWfWwFwHoD1UMQLqCU4amVg6e+b9pQglnOR/H61EaVYobFom5bo1Sg0Y
         fguQ==
X-Gm-Message-State: AOJu0YwD5k2fr0N9erNIbRzgJ7Fk7M3Lj6zenh+9NsBUzsBGfg0iNnNo
        FXe/S+9fz5qxF/1yiz4fE2ggvVMy/SGQJxEweFM=
X-Google-Smtp-Source: AGHT+IEHnjG1745XHVSq0ZGcqMftv8YU1ddVlDVtAVOTAo25ZERTfubpQnq/0Y1258rby6TxUWnjkA==
X-Received: by 2002:a7b:c458:0:b0:3fe:4cbc:c34c with SMTP id l24-20020a7bc458000000b003fe4cbcc34cmr1071490wmi.24.1692182064818;
        Wed, 16 Aug 2023 03:34:24 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c16-20020a7bc010000000b003fc00212c1esm20895369wmb.28.2023.08.16.03.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:34:24 -0700 (PDT)
Message-ID: <3a34c547-f6f5-7e8a-8a2c-157dd651490c@linaro.org>
Date:   Wed, 16 Aug 2023 12:34:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal: mediatek: auxadc_thermal: removed call to
 platform_set_drvdata()
Content-Language: en-US
To:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rdunlap@infradead.org, void0red@hust.edu.cn, daniel@makrotopia.org,
        bchihi@baylibre.com, aouledameur@baylibre.com,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        rui.zhang@intel.com, amitk@kernel.org, rafael@kernel.org,
        alex@shruggie.ro
References: <20230811192847.3838-1-aboutphysycs@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230811192847.3838-1-aboutphysycs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 21:28, Andrei Coardos wrote:
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.
> 
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---


Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

