Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1A277DE44
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243769AbjHPKMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243751AbjHPKMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:12:08 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06762E48
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:12:03 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so57399085e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692180721; x=1692785521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20xjCMIn17IR0IdsU0wkbDugtTRHdsqXhz5TVu8BY4Q=;
        b=iUa6RfbNJiCDGwPc2p1UrDJKJVExj7TEUy1Q0T03zhK962sdA57EUI1jLn4zGNcwdk
         GaPe+iyXbcTz2mjIG3L9kpunNRkPzvfHnj6FOG7VvD57BYEHsUtTnoQRR9HduT7dENoq
         rpZtt4pJwn+9H0dhrOI/kcXOTxDysTM2/rpzXo5wrTY8sF8GnBRYWup3yNNhqeAwDaj7
         mh+SRw2RHBTydloOBeuIk30C7MSCNrLtRfJtWjQ+AfvucaaMlk0DIPTrexPC9SsaNia0
         HMzANM3PhUMWOBdDe3BSjWtYNKgNYon39l0m51eApoiE8y/012cfMYILDKyc6Xjp0fzd
         u47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692180721; x=1692785521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20xjCMIn17IR0IdsU0wkbDugtTRHdsqXhz5TVu8BY4Q=;
        b=L1uGini2gCoKbfojV8qTFsikY1Ti3UZlNFvIPEtk+m3hPkSe/2Z2N7CtldzCWSjP2V
         51xMLAnI19lc+7L446czuKIz4ymm+wMkORKzUN6F6sWBs/rfW3wQaICIkKlDXzCqaM9j
         cX09q+KmjaYP5nHopzL683JFyRz67k2D4u7oxLMehg+ImG5dSe+Bi4KEcx9D5iCg3s9W
         b45cdrUA4OYGsCuLnVBllrHEorxv0bHVuTyMTV6G91E8C5vBJ8GV3mAw6NVB+7s9wrxl
         Qdcedj7zBEqxnssXcN6j87cTpmeByZgiYGnT8f5ggPJR52VNVZAT9MVhsRXRMR6cARZt
         RPnQ==
X-Gm-Message-State: AOJu0YyODQbWMOkS8w6aDKN+qOf/KsmKihs4ehO29B7TVfh1v58/viVj
        HXgclQGT+eilq5hpSM9IzfX3wg==
X-Google-Smtp-Source: AGHT+IHSmdjyfsa9LPesk0EAdqOUpnrKFYU5CJ1/Qu2idCvNcIQerf3QA9ZKNflrp62PA12OridiYg==
X-Received: by 2002:a5d:4385:0:b0:317:e04c:6791 with SMTP id i5-20020a5d4385000000b00317e04c6791mr1255859wrq.62.1692180721405;
        Wed, 16 Aug 2023 03:12:01 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v1-20020adff681000000b00313e2abfb8dsm20829375wrp.92.2023.08.16.03.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:12:01 -0700 (PDT)
Message-ID: <b8812390-7570-dc91-6a12-964c28a85d30@linaro.org>
Date:   Wed, 16 Aug 2023 12:12:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next] thermal: samsung: fix Wvoid-pointer-to-enum-cast
 warning
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>
References: <20230810091318.70261-1-krzysztof.kozlowski@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230810091318.70261-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 11:13, Krzysztof Kozlowski wrote:
> 'soc' is an enum, thus cast of pointer on 64-bit compile test with W=1
> causes:
> 
>    exynos_tmu.c:890:14: error: cast to smaller integer type 'enum soc_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

