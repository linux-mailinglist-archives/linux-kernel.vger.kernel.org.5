Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F37763491
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjGZLLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjGZLLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:11:21 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3949E132
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:11:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98e011f45ffso964189666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690369878; x=1690974678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+UY5aLC+dC/ndM3p8qV+XcIRwaYtKhRxbIV9WFyvcU=;
        b=z4it2c3JFnu+LBMwOMT8UHYA3Qmg6TdUV3x9kFC4mFuyZuwZ0p2axey6WCw2WHsh4y
         8FFzUxOn7Ru0s4iz+xZgEeZN0MJew8T76QYKd34/I07L0FbygTzB5d+LYL7x4bujwtzQ
         Yu6m2Ftjn06vOv9o6olODTidyokwNTEyHtJvpXu6b8QW1MjGlTOS3wojuc3DlzjsTsw0
         UgRT1i/uXI90UAIgoW8erQV43FmemU9nf5iUSyeZerP91wRmpM6JqEj7GURr1z21TJFA
         44A4QqsymC4RMkSuUDphx7+NcqZ7asaZUZCqbyGFH3JTAfR7u8f8r21G6oQ89VkrzthK
         MN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690369878; x=1690974678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+UY5aLC+dC/ndM3p8qV+XcIRwaYtKhRxbIV9WFyvcU=;
        b=IYD6txsGvzv3uV3aoSAzRDwmkxvSabxCl2v1qYWE3OjRBzo0NZ1OCPjAdIzi/xVsxM
         WBuvr9XkBcveKMj0NJ+ZgG0g66ZR0xbEOxQYZevoPiSLrK6gqrngWda5FgXKFkLJKTXz
         2YCGQ6INQ5gAX0+6uFKUSX5d+ZqJebqZmaNmekKYsUgv6Nt1hce4URS9HphRD4ppo3Vb
         2SFoXCri8YtOoLve8nDal7O4gYQ/JXw7s8f1kO4WwhQXZzAVqYki+v7Yhel3OqvEYdG4
         CW+r9kU5e77taSqThH3n3juCKheRpvHbM4eP+g0NUnPJBsdyssOTdV4XbwmJTbzxR4o5
         zlMw==
X-Gm-Message-State: ABy/qLb0XEoVaiJi4Ihil1jyaoteiO0AQ3dqHd1o4tnk7+eqzH3/AiDn
        3XID/GAYpg4RwmiDt1VRvbS+Pg==
X-Google-Smtp-Source: APBJJlH0DR6qoWo2zM+56h1wbrR4G3XZE9wCgfCy3Yer0np7E+K0OKdn6yOkRHJjv/ZGfjXNTfmpNw==
X-Received: by 2002:a17:906:77db:b0:993:e9b8:90f5 with SMTP id m27-20020a17090677db00b00993e9b890f5mr1282347ejn.8.1690369878658;
        Wed, 26 Jul 2023 04:11:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id fy17-20020a170906b7d100b009931a3adf64sm9665454ejb.17.2023.07.26.04.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 04:11:18 -0700 (PDT)
Message-ID: <30caa2df-4cfc-761e-759f-039e4ff858dd@linaro.org>
Date:   Wed, 26 Jul 2023 13:11:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ASoC: loongson: drop of_match_ptr for OF device id
To:     YingKun Meng <mengyingkun@loongson.cn>, broonie@kernel.org,
        lgirdwood@gmail.com
Cc:     xry111@xry111.site, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
References: <20230726110516.703342-1-mengyingkun@loongson.cn>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230726110516.703342-1-mengyingkun@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 13:05, YingKun Meng wrote:
> The ASoC Sound Card driver can be compile tested with !CONFIG_OF
> making 'loongson_asoc_dt_ids' unused:
> 
> sound/soc/loongson/loongson_card.c:200:34: warning: unused variable 'loongson_asoc_dt_ids' [-Wunused-const-variable]
> 
> As krzysztof advice, we drop of_match_ptr so the device id
> can also be used on ACPI.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307242008.xqdjgk04-lkp@intel.com
> Fixes: d24028606e76 ("ASoC: loongson: Add Loongson ASoC Sound Card Support")
> Signed-off-by: YingKun Meng <mengyingkun@loongson.cn>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

