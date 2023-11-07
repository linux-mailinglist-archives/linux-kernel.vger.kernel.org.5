Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF687E464E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjKGQmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKGQmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:42:12 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B45DA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:42:10 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4084095722aso44605045e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 08:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699375329; x=1699980129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aAG3sacWPBXSFUKSzpLXVeo1JwNyPZim0mcCKaII7ao=;
        b=CNkaL2V2W7+FJ6YDANmoPGm47YrR16icM2je6IHnBGh+XPTwZw/MGd+JWbc1r8vMmn
         5bxHZDMmsL66HowPYhbiol/kmk7Z0ymokIbqbAWAjJO0L3huQ6Cyhha9WdvSOsdKHeyt
         5ae78Z8CG0wrviym9bpebuABGo6CMG1WkdQhCBTzm4PctK5o2iaSV1KTlhbfXNVA2nDj
         VarJXs3wDRVvsbxvu0Q47XkrTjH3BLbKZPvkLtH1CSERKjzRpjhglME6iGCuBvmMMuKY
         WhQYrXph9V7T2yRwfixgMgXqa/P/2vd1oCFYeH8uoyEvzzALKT8Ql0I0FDqfc6kqekHx
         Ft0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699375329; x=1699980129;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAG3sacWPBXSFUKSzpLXVeo1JwNyPZim0mcCKaII7ao=;
        b=tN67jvcMQ2AcMnH7HJboRpKkmAtxFs6H+IyY6cLN6agG7/NZYkd3pKYT/xs1sl6TQV
         ZJ82U0sZO5FDDRs8wPFVVaKmZE9sNrCFPbjHo80f795mNrT8+J/6tViyQ0M1gri5jDub
         axvCGhLzooXeoNDgVpTTtdn6Qe7zxxWaQl3xrplHYPw/oAf5K3qK2+Jq6ISBrF5wPVpi
         hKixl8X1CS+bk997v4jOJ1w/HjOv1Q/vxW1jMMopQi3zh+f4HokYBsecc321v0qNSvC3
         Hv4KeahOOFhg/bLyGU9K1WL9X2N/h9NBDfwDEhO5Rfqb23WBc3zONfZ6WPvm+TGcnE+1
         0EFA==
X-Gm-Message-State: AOJu0YwgiBf5sslL3QPJB3TfYEOoc0s9opLDZ5fDmzmN3TvRJUkX0xCz
        MYlT/5xez9Ihq9Lz19pmuKoGXA==
X-Google-Smtp-Source: AGHT+IGtV8OXtohdPAz3Te0I370Z73N5I/MwJUUSOLej4VBNI6ZYLhl9YpdbBnIh49F+ckhoVho50g==
X-Received: by 2002:a05:600c:6023:b0:409:718b:33e0 with SMTP id az35-20020a05600c602300b00409718b33e0mr2932919wmb.16.1699375329097;
        Tue, 07 Nov 2023 08:42:09 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id ay8-20020a05600c1e0800b0040772138bb7sm16560031wmb.2.2023.11.07.08.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 08:42:08 -0800 (PST)
Message-ID: <a683c2b1-5caa-4014-b8bb-9caed303adb2@linaro.org>
Date:   Tue, 7 Nov 2023 17:42:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] crypto: rockchip: add rk3588 driver
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Corentin Labbe <clabbe@baylibre.com>, davem@davemloft.net,
        heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     ricardo@pardini.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20231107155532.3747113-1-clabbe@baylibre.com>
 <20231107155532.3747113-7-clabbe@baylibre.com>
 <07bbb8c3-b6c0-4e5e-8fe9-2fcbb71b7dbc@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <07bbb8c3-b6c0-4e5e-8fe9-2fcbb71b7dbc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2023 17:35, Krzysztof Kozlowski wrote:
> On 07/11/2023 16:55, Corentin Labbe wrote:
>> RK3588 have a new crypto IP, this patch adds basic support for it.
>> Only hashes and cipher are handled for the moment.
>>
>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>> ---
>>  drivers/crypto/Kconfig                        |  29 +
>>  drivers/crypto/rockchip/Makefile              |   5 +
>>  drivers/crypto/rockchip/rk2_crypto.c          | 739 ++++++++++++++++++
>>  drivers/crypto/rockchip/rk2_crypto.h          | 246 ++++++
>>  drivers/crypto/rockchip/rk2_crypto_ahash.c    | 344 ++++++++
>>  drivers/crypto/rockchip/rk2_crypto_skcipher.c | 576 ++++++++++++++
>>  6 files changed, 1939 insertions(+)
>>  create mode 100644 drivers/crypto/rockchip/rk2_crypto.c
>>  create mode 100644 drivers/crypto/rockchip/rk2_crypto.h
>>  create mode 100644 drivers/crypto/rockchip/rk2_crypto_ahash.c
>>  create mode 100644 drivers/crypto/rockchip/rk2_crypto_skcipher.c
>>
>> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
>> index 79c3bb9c99c3..b6a2027b1f9a 100644
>> --- a/drivers/crypto/Kconfig
>> +++ b/drivers/crypto/Kconfig
>> @@ -660,6 +660,35 @@ config CRYPTO_DEV_ROCKCHIP_DEBUG
>>  	  the number of requests per algorithm and other internal stats.
>>  
>>  
>> +config CRYPTO_DEV_ROCKCHIP2
>> +	tristate "Rockchip's cryptographic offloader V2"
>> +	depends on OF && ARCH_ROCKCHIP
>> +	depends on PM
>> +	select CRYPTO_ECB
>> +	select CRYPTO_CBC
>> +	select CRYPTO_AES
>> +	select CRYPTO_MD5
>> +	select CRYPTO_SHA1
>> +	select CRYPTO_SHA256
>> +	select CRYPTO_SHA512
>> +	select CRYPTO_SM3_GENERIC
>> +	select CRYPTO_HASH
>> +	select CRYPTO_SKCIPHER
>> +	select CRYPTO_ENGINE
>> +
>> +	help
>> +	  This driver interfaces with the hardware crypto offloader present
>> +	  on RK3566, RK3568 and RK3588.
>> +
>> +config CRYPTO_DEV_ROCKCHIP2_DEBUG
>> +	bool "Enable Rockchip V2 crypto stats"
>> +	depends on CRYPTO_DEV_ROCKCHIP2
>> +	depends on DEBUG_FS
>> +	help
>> +	  Say y to enable Rockchip crypto debug stats.
>> +	  This will create /sys/kernel/debug/rk3588_crypto/stats for displaying
>> +	  the number of requests per algorithm and other internal stats.
>> +
>>  config CRYPTO_DEV_ZYNQMP_AES
>>  	tristate "Support for Xilinx ZynqMP AES hw accelerator"
>>  	depends on ZYNQMP_FIRMWARE || COMPILE_TEST
>> diff --git a/drivers/crypto/rockchip/Makefile b/drivers/crypto/rockchip/Makefile
>> index 785277aca71e..452a12ff6538 100644
>> --- a/drivers/crypto/rockchip/Makefile
>> +++ b/drivers/crypto/rockchip/Makefile
>> @@ -3,3 +3,8 @@ obj-$(CONFIG_CRYPTO_DEV_ROCKCHIP) += rk_crypto.o
>>  rk_crypto-objs := rk3288_crypto.o \
>>  		  rk3288_crypto_skcipher.o \
>>  		  rk3288_crypto_ahash.o
>> +
>> +obj-$(CONFIG_CRYPTO_DEV_ROCKCHIP2) += rk_crypto2.o
>> +rk_crypto2-objs := rk2_crypto.o \
>> +		  rk2_crypto_skcipher.o \
>> +		  rk2_crypto_ahash.o
>> diff --git a/drivers/crypto/rockchip/rk2_crypto.c b/drivers/crypto/rockchip/rk2_crypto.c
>> new file mode 100644
>> index 000000000000..f3b8d27924da
>> --- /dev/null
>> +++ b/drivers/crypto/rockchip/rk2_crypto.c
>> @@ -0,0 +1,739 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * hardware cryptographic offloader for RK3568/RK3588 SoC
>> + *
>> + * Copyright (c) 2022-2023, Corentin Labbe <clabbe@baylibre.com>
>> + */
>> +
>> +#include "rk2_crypto.h"
>> +#include <linux/clk.h>
>> +#include <linux/crypto.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/reset.h>
>> +
>> +static struct rockchip_ip rocklist = {
>> +	.dev_list = LIST_HEAD_INIT(rocklist.dev_list),
>> +	.lock = __SPIN_LOCK_UNLOCKED(rocklist.lock),
> 
> Drop it, not needed.

To clarify: I mean entire structure.

Best regards,
Krzysztof

