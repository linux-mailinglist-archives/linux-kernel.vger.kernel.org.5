Return-Path: <linux-kernel+bounces-11971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F9181EE59
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBBA1F21738
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417E144381;
	Wed, 27 Dec 2023 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rV5daALz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E027244375
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3369339f638so3920782f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 02:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703674555; x=1704279355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dq4Wg3sInsGjJll2pSpnEqdTyZFZWvCkPmk8fOtnaZs=;
        b=rV5daALzWYMsfVbnNqN0lVnx4uc30WSbSHtcuMnVV/BTJyMSrwcs0Hh9Nfko7/7OUa
         763IoRm65NsQOxoYcSX0dxcfPVpkq7rdDxLv5btPZCzokTox9HOSfPD4RgrYMc1nBr5B
         NurQclYmYrrgl6NkWNDSnsfX22geX3hMh1fq3TxjPpaDFPx7/fryDgdYlbJndhfGwbGz
         X0+oGldC17iSNEGH8IhqJ8cMV25RLzq2VDRdHWtoAqqq2jagJBgr4PkzpjRaUOGbRVgM
         7yqyjJdrJZUlBZBM2a573AVxFhORmBHzFiN2EXAKEGVYwY7BpHlocvzmPwppYFJT4/Lj
         9hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703674555; x=1704279355;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dq4Wg3sInsGjJll2pSpnEqdTyZFZWvCkPmk8fOtnaZs=;
        b=Lh4loV68a/1dV3AfpjbXk98J7vpQcW2cwxBAZELSc81WB2PXF7gpweTV7LS5vmV7NX
         sijz/iu4o+Z51eJHGmW3mSdTaCI3McLoZNzx9KObKv+ZFX4UeP2yzAfuTqp+4Ziam4sS
         TYGSMOkKAR7PR43XUVh/wANzB2BS+kVJB0kywDmX1xYLAagFhrDrE5CmJvnRbzx0DpyY
         qJGhqfEzOSKC6VA3Mzbe3I3j+R97aOnhOgXeQj9jDHiOGeCd1J1Hfrk7k7FSWvPdGsYy
         jOhIbIrY8lrzBnH8rmYwh6VGOAIaENvtLEa3QRZsiRIWm+gVqR0xPCNqf+4kx7TJSPRo
         uePQ==
X-Gm-Message-State: AOJu0YyjGg9ZONem8NvyJj5Zj/EQEvV9J7TFJ9zbhURG7E6LmyRHpBFc
	lnPVgm0EGikgDEw4qqbVtLYwKkb2xk53pQ==
X-Google-Smtp-Source: AGHT+IHMF2zqQo/m2lnVkVM+wA+VT1QUSuBSmdtliPtCQ8W14LS4KK9dtmUwlK+HPE63opIP34XHTQ==
X-Received: by 2002:a5d:6ac1:0:b0:336:746a:541a with SMTP id u1-20020a5d6ac1000000b00336746a541amr3417825wrw.87.1703674555046;
        Wed, 27 Dec 2023 02:55:55 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id s12-20020adfeccc000000b0033687672e48sm14141173wro.75.2023.12.27.02.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 02:55:54 -0800 (PST)
Message-ID: <2bfda4d9-73a7-46cd-b1f9-271242e60d7b@linaro.org>
Date: Wed, 27 Dec 2023 11:55:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v2 1/5] ASoC: dt-bindings: remove tas2563
 from yaml
To: "Ding, Shenghao" <shenghao-ding@ti.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "Lu, Kevin" <kevin-lu@ti.com>,
 "Xu, Baojun" <baojun.xu@ti.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz"
 <perex@perex.cz>,
 "pierre-louis.bossart@linux.intel.com"
 <pierre-louis.bossart@linux.intel.com>,
 "13916275206@139.com" <13916275206@139.com>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
 "soyer@irl.hu" <soyer@irl.hu>, "tiwai@suse.de" <tiwai@suse.de>,
 "Gupta, Peeyush" <peeyush@ti.com>, "Navada Kanyana, Mukund" <navada@ti.com>
References: <20231221101346.429-1-shenghao-ding@ti.com>
 <ZYReyHQxMAe-DKq4@smile.fi.intel.com>
 <2eeb19a0-5851-4684-836c-36ec53db6900@linaro.org>
 <d6e28ecdb1e3458f9e8626a77483c6ab@ti.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d6e28ecdb1e3458f9e8626a77483c6ab@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/12/2023 08:04, Ding, Shenghao wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Friday, December 22, 2023 1:32 AM
>> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Ding, Shenghao
>> <shenghao-ding@ti.com>
>> Cc: broonie@kernel.org; conor+dt@kernel.org; robh+dt@kernel.org; Lu,
>> Kevin <kevin-lu@ti.com>; Xu, Baojun <baojun.xu@ti.com>;
>> devicetree@vger.kernel.org; lgirdwood@gmail.com; perex@perex.cz; pierre-
>> louis.bossart@linux.intel.com; 13916275206@139.com; linux-
>> sound@vger.kernel.org; linux-kernel@vger.kernel.org;
>> liam.r.girdwood@intel.com; soyer@irl.hu; tiwai@suse.de; Gupta, Peeyush
>> <peeyush@ti.com>; Navada Kanyana, Mukund <navada@ti.com>
>> Subject: [EXTERNAL] Re: [PATCH v2 1/5] ASoC: dt-bindings: remove tas2563
>> from yaml
>>
>> On 21/12/2023 16:50, Andy Shevchenko wrote:
>>> On Thu, Dec 21, 2023 at 06:13:41PM +0800, Shenghao Ding wrote:
>>>> Remove tas2563 from tas2562, it will be supported in tas2781 to
>>>> better support dsp mode.
>>>
>>> DSP
>>>
>>> Shouldn't this patch go after the actual change happen?
>>
>> I would squash both, so device documentation does not disappear.
> I do not fully understand "squash both", do you mean still to keep ti,tas2563 in tas2562.yaml?

I meant to squash both binding patches (git help rebase).

Best regards,
Krzysztof


