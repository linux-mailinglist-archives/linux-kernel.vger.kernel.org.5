Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FE777F13C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348483AbjHQHcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348469AbjHQHcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:32:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04445268D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:32:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so72270385e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692257518; x=1692862318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jj+zmFcS53FxiFXdFT3100UbX55OahW6GngbYoCny6o=;
        b=PLVH/ed2a/eOd6iKZuSO3DTDv56DPfgIfYVnkAxbHUSMCBruBJmvkn+sIy9aZXCqE+
         v1k1/IsCVUvm6B2CZnVw5Pq597Kx+gDtKmw3aiL9oFi4S3tWGB2p1W+gTgTdrMEwuNyX
         i7fgPASN/i/3/wKKpfNPgQWA77eHoqrsU8tDGdq7UAqe97I25xiYm6lwLr8LrE7u1qm/
         to/joITdRq0K8T/voGQm4z5qxDUw+dHfOrg3D6HXyzzjjiNy+HGKBaBsH98ot7aWoHjw
         88q5Ijr+eV7E6RZ1R0X6anDg5bL8vxm26JJRgMEowKLw04lzXg67jzYpJshVTXGgMwSQ
         QeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692257518; x=1692862318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jj+zmFcS53FxiFXdFT3100UbX55OahW6GngbYoCny6o=;
        b=DHGSozNREQMBONTaSKL4VrYE4tTHkKNSfTH54Mgi4awSw+7Bj1U/nN61aS0qQUsfGI
         8b4eHQrLIt+/dO/ptRfwTFnM7tOjmjjVtf5hR0vDHMhMBH7cIWcH7JP3WGJCII/ygwVi
         A2qwAj9p3wllzn42aH8b2aVZoUyxWzxOLb/OT4WSPIdU4hV6RvHK8ffFXp6D7UO4Daas
         P4Ul7J21peMF6lX9CYd/ZFBaSVCp3FhLgyfUa54INp54e/sV5Dgf4aLnhTkJCp05luOm
         TGhsHlt4VHBoBmXxwwFXD77FUmG3XDHtEcA4hqp4pqMM4oTZpblOvscsems9OrZi8o4i
         RISA==
X-Gm-Message-State: AOJu0YxX7wTGUpHevA1u+wL63FvtMU0D2/uZhpJ5hcTSsHbVf7FSYkbA
        9xXnSSk+SU9+qIU23HpepLpe9A==
X-Google-Smtp-Source: AGHT+IGzexNfIMNiyYf04wPFvQ+KprnkNte0v5qmm1q1BFzdIXuiSxv8wB5TM7QDdlSZYaz7yM/Ehw==
X-Received: by 2002:a05:600c:228d:b0:3fe:16c0:6b44 with SMTP id 13-20020a05600c228d00b003fe16c06b44mr3303735wmf.12.1692257518429;
        Thu, 17 Aug 2023 00:31:58 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id j11-20020a5d604b000000b0031ad5470f89sm1740984wrt.18.2023.08.17.00.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 00:31:58 -0700 (PDT)
Message-ID: <b59547f8-6301-8c95-546f-d454f98d00fc@linaro.org>
Date:   Thu, 17 Aug 2023 09:31:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v16 1/2] thermal: loongson-2: add thermal management
 support
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20230817021007.10350-1-zhuyinbo@loongson.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230817021007.10350-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2023 04:10, Yinbo Zhu wrote:
> This patch adds the support for Loongson-2 thermal sensor controller,
> which can support maximum four sensor selectors that corresponding to four
> sets of thermal control registers and one set of sampling register. The
> sensor selector can selector a speific thermal sensor as temperature input.
> The sampling register is used to obtain the temperature in real time, the
> control register GATE field is used to set the threshold of high or low
> temperature, when the input temperature is higher than the high temperature
> threshold or lower than the low temperature threshold, an interrupt will
> occur.
> 
> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v16:
> 		1. Remove the test and message in the context of
> 		   devm_thermal_add_hwmon_sysfs.

Applied, thanks

