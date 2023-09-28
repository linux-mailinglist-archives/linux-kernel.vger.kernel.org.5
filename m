Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9BC7B1500
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjI1HhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjI1HhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:37:24 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21414AC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:37:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-503f39d3236so20461387e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695886639; x=1696491439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OdEvpR7e634F6Xq7gphI0yR6+BY3xXYw+rzm/HECnb4=;
        b=oUjU9k19aJD1i006n0Drky1DEhTr21HRFAKoZLkOfFG7Qyneswn/luach8U7sBVSm8
         /6uoiaCR1z9Ivjxet8ibzokUoP3nQKF5YMFTOPiHr4gu0fEHGMlZIgSsBSh2BgELnbXP
         uo3D9F2GJUFVVxRgFufHGclLliJ4yi3i5YevTttP9ED2ZAtQ48mxxGTO7k+J/Lf7BaS3
         6zSmwCNg9WjbWYVMOMk8uJB0jqBFjpL71RABl66+PbfcL1F0UtFu8MRJ1EVPFhAsRxmm
         sh1WXE8IVyEFw6Su2vaduTL4b3QO0G0Kz4gdl81WNgXLk/BrjJrwdYCzys9H4WtqPVq6
         7CtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695886639; x=1696491439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OdEvpR7e634F6Xq7gphI0yR6+BY3xXYw+rzm/HECnb4=;
        b=qL6BAQLMyty5n2r8u4dLpTBhee1Unn3NGthpF+XZ6KYB8ypli81sOzX0uhErUPJIC1
         nhyIRtQpQaXzVbKXSqaOCzJBRJHQLECGGgKp6qbJEGfpkV2BsneAnMVtxZpzcYf7HuxT
         0Cyvmvv2+LwBYED8hMWyPYLmEL4yi25vdQQCuF4sqmu9z+B8+4QvqBgpSZkoK/IYqN5F
         vWlVDou5kPLqniyOvc1UdaAiSpqjcRTjliCPxAlXW34piwO949m8AofOVExIvLiE39kX
         Nn+xVHfU58Ovr6A5lBsxqDI1bsH/ynHaX/W+8GF89zfG5Lt+d/eSWl0UVRkv+e9bguN5
         0T/A==
X-Gm-Message-State: AOJu0Yzganqx8aGYMvCkAb/PDvX2qAxpkqxcxS4YmTTDw1ntXoOYR4BX
        FK7C1gTyE/KZw+1iKkR0YTDC/w==
X-Google-Smtp-Source: AGHT+IEiAv4nqQ0UosPBmy5DqVigj7fS+2PeREuoogljv96EOrQq59RDc/DzJ9LREX0UxZnPslp5hA==
X-Received: by 2002:a05:6512:1103:b0:4fd:f84f:83c1 with SMTP id l3-20020a056512110300b004fdf84f83c1mr480905lfg.64.1695886639123;
        Thu, 28 Sep 2023 00:37:19 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id s13-20020a5d424d000000b0031f729d883asm18744112wrr.42.2023.09.28.00.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 00:37:18 -0700 (PDT)
Message-ID: <5828d18a-6ec3-68cd-b97e-3f4a181dc953@linaro.org>
Date:   Thu, 28 Sep 2023 09:37:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/4] thermal/drivers/mediatek/lvts_thermal: add mt7988
 support
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230922055020.6436-1-linux@fw-web.de>
 <20230922055020.6436-5-linux@fw-web.de>
 <ZRTBFJPL3NwWpMSP@pidgin.makrotopia.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZRTBFJPL3NwWpMSP@pidgin.makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2023 01:56, Daniel Golle wrote:
> On Fri, Sep 22, 2023 at 07:50:20AM +0200, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files.de>
>>
>> Add Support for Mediatek Filogic 880/MT7988 LVTS.
>>
>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> 
> Tested-by: Daniel Golle <daniel@makrotopia.org>
> 

Thanks for the testing tag

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

