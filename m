Return-Path: <linux-kernel+bounces-20047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126818278A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AEC1C21E51
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FDC53811;
	Mon,  8 Jan 2024 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bu6gTd+5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0053814
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d88fff7faso23662415e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 11:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704742596; x=1705347396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ooq6Y/Bu2G6JvyfUEidd2TCbjg/tonoTWRKQtOf1ea4=;
        b=bu6gTd+57Zt92vtZYfzgE98F8zr16r86kZuzSA2YK4C29YVArXgEFDrBrK/7uEzqq7
         bkGH/6/Z+jo8tASdoY3Nx83/Gm6brV6vu8O0s/zCKq9Vyk+E434BgNqYSe5UA7cyldXm
         FxQQ0awe9M3R1S2k9nZAwjXFHERDTH4PdqYuyJ3v2y65QeMJwBBnA3dBkV27bZ2gubY9
         dzzxvQAUZhFtKTWzr9kB26R+SvacnAclXtK/VC/zNUIu7hkjXdKHcfEdv9jbPsXxqXxf
         hk8hh4hVi+RFk1Vy61ymLEl4LlI/okX9DpyJdkhu1tEkeNpqma/qRdlj1WZOmswkwtZs
         tN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704742596; x=1705347396;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ooq6Y/Bu2G6JvyfUEidd2TCbjg/tonoTWRKQtOf1ea4=;
        b=BUJ1nU+plZ0k60ZW/g/IuPZpoedOnElFW67hLJZdzU4Yg9nUBesnJaWHyVJ91QcVez
         EAeZio+25BNFArLhY3Y3YhRKdPnW1OZl2DQ0ocZyXjM9XuUmbRR22VFmLDX8gOngM8aj
         jzfBgnmwVk8+e2R8D35wnJmZV465yf4yV0vvu1YtYLimUi7jYvjKTVS3GOiCsaPAp3lD
         ybeBCmOvIs/D1oyR45P//C3eM7miNEtPKcEX09V3YlU4NuQJPCxjQw6k5pF/QX4Dj5dl
         3H4uIXl2lu2thAXW2YjoCH0Q9jtbkKXppJxmaxuaTHmlx5Me4MoEiVtGLiJw9NshtOMC
         DvGg==
X-Gm-Message-State: AOJu0YzPixwcL6e97Zg4wWYBDLxL8Bxjdjv9js0gE16Ef2Zy2muPJDjR
	SkiPk4m9/r3QuHB9dwomW2PFI4O3zKfQig==
X-Google-Smtp-Source: AGHT+IEycGvY/C4DqA9z7Su+zmZMsZIZzzn+/DcKOqASsrM2CwBLnUrpB5NteqL4eWP5a3kZdMkDXQ==
X-Received: by 2002:a7b:c44f:0:b0:40e:4755:a52f with SMTP id l15-20020a7bc44f000000b0040e4755a52fmr483812wmi.230.1704742595995;
        Mon, 08 Jan 2024 11:36:35 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090622ce00b00a2ace215a78sm184056eja.114.2024.01.08.11.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 11:36:35 -0800 (PST)
Message-ID: <1e1ef0a0-6639-4a4d-9b4e-50bcee3fb3c5@linaro.org>
Date: Mon, 8 Jan 2024 20:36:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] dt-bindings: soc: sophgo: Add Sophgo system
 control module
Content-Language: en-US
To: Chen Wang <unicorn_wang@outlook.com>, Chen Wang <unicornxw@gmail.com>,
 aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
 palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com,
 robh+dt@kernel.org, sboyd@kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, haijiao.liu@sophgo.com,
 xiaoguang.xing@sophgo.com, guoren@kernel.org, jszhang@kernel.org,
 inochiama@outlook.com, samuel.holland@sifive.com
References: <cover.1704694903.git.unicorn_wang@outlook.com>
 <acebc88db3e5fcd2a2607b56842af7443a6e1289.1704694903.git.unicorn_wang@outlook.com>
 <cc7cc943-7242-4fd1-9b56-3ece0a418e05@linaro.org>
 <MA0P287MB2822E54A6DD36F914DB56E98FE6B2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <MA0P287MB2822E54A6DD36F914DB56E98FE6B2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/01/2024 08:20, Chen Wang wrote:
> 
> On 2024/1/8 15:03, Krzysztof Kozlowski wrote:
>> On 08/01/2024 07:48, Chen Wang wrote:
>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>
>>> Add documentation to describe Sophgo System Controller for SG2042.
>>>
>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>   .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     | 34 +++++++++++++++++++
>>>   1 file changed, 34 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>> new file mode 100644
>>> index 000000000000..1ec1eaa55598
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>> @@ -0,0 +1,34 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-sysctrl.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Sophgo SG2042 SoC system controller
>>> +
>>> +maintainers:
>>> +  - Chen Wang <unicorn_wang@outlook.com>
>>> +
>>> +description:
>>> +  The Sophgo SG2042 SoC system controller provides register information such
>>> +  as offset, mask and shift that can be used by other modules, such as clocks.
>> "offset, mask and shift" is not a register information stored in
>> syscons. Are you really sure, that your system controller hardware
>> stores offsets of some other registers?
>>
>> Show as some example of such offsets, masks and shifts provided by this
>> hardware.
> 
> The system control module is defined here: 
> https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/system-control.rst. 
> It contains some registers related to pll and gates.

I do not see there registers providing shifts and offsets... just values.

> 
> Some other clocks registars are defined in 
> https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/clock.rst.
> 
> memory-map is defined in 
> https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/mmap.rst


Please fix the wording because it does not make sense. System controller
does not provide register information. Your datasheet provides register
information.

Best regards,
Krzysztof


