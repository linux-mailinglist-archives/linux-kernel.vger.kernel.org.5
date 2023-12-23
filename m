Return-Path: <linux-kernel+bounces-10447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 062E281D47F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A361C21064
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692E2DF43;
	Sat, 23 Dec 2023 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ftDyf+Zx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5F6DDC2
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55372c1338bso2817560a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 06:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703341046; x=1703945846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxS4YAdMN5goxWOvjAG3QNJdl3D9INpvcTS+TWD84LU=;
        b=ftDyf+ZxLRl9+Q0WBpMKrmhZa7Piu4AVwCp6n0DW9opPB4plo7cH+lFguUPkli5ZDw
         hojE5HqH4kyddjS5AMQQIE7qvYgPw8GUC3ddg9wc+FUGK7YWbwVptSvKJSQNrpg08vhE
         xzdRYIdIL7FtzKBZHJ6eDIxOumATnRSVb6M9HA+PjYdz1rhOPfd2T6o5QQBFiSlDdszH
         irokrZRtI7zFwhxj8x/mUCe7HrB0q0U3kTk9ya5Z2oNnyy/9dWFaJs8L5OBdY1pYSoJ/
         Glh1PSjBzqS6Nos27qMonZMaP5VM//c/+DYIwbMvBWfzDnoLlt2+noqmYMeXG1hpdQTs
         xFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703341046; x=1703945846;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxS4YAdMN5goxWOvjAG3QNJdl3D9INpvcTS+TWD84LU=;
        b=WAqB31cp8vWa6XQZUbdFVlBnoQWnOV4qWBbZEdqO6oMGQvOlfnX/emyj/WlqJK4CAe
         DCN/s1YN0mTQyjzdpCCQ6WeBtZWK9RFbBxC7H93ZM/8nf/PaNbl62oyVCjI4HjTsiOS0
         o4HxN80V1C2d/bVzYXU6y+RRzZyi1+F7H7OpJb0AV76FqzCFdwTT5ArF8QlanTwxPD0S
         cew1X6lt5d6Mo7kngDdm9XSQyzU8BxnqWXVsvlJVCjJXap6rywleaO/PIM2O5HrBl+CS
         8IBxEzC3pMDhxVBrx/RmqOvbmV6EUmMW41eB0SgdX5iVD/a34JSartYpM8XDH+KNOWh4
         MzHg==
X-Gm-Message-State: AOJu0Yylw1Uwl8dfz/OlYEcaYOPTQTXCl3WotlYZB0/5XCH2anzJch92
	BlbG00nFdm+rsk5FS9L1BeQM5ob/VGfX2g==
X-Google-Smtp-Source: AGHT+IEWtpfDXYGsfGjVykzE4s2kT08nlXX7oErV7FIaPBuKHaM5JQyEJ4f/VjRiaPlC1R8iV9wZ2g==
X-Received: by 2002:a50:bb02:0:b0:54c:4837:7583 with SMTP id y2-20020a50bb02000000b0054c48377583mr1578310ede.47.1703341046402;
        Sat, 23 Dec 2023 06:17:26 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id u15-20020aa7db8f000000b005549006dadfsm711109edt.58.2023.12.23.06.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Dec 2023 06:17:25 -0800 (PST)
Message-ID: <401f400a-e267-4131-82ee-a5759edaa3cb@linaro.org>
Date: Sat, 23 Dec 2023 15:17:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: regulator: Convert ti,tps65133 to YAML
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Apitzsch?=
 <git@apitzsch.eu>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>
References: <20231217-tps65132-v1-1-73c69a960d28@apitzsch.eu>
 <170282308261.876422.2237767392476986368.robh@kernel.org>
 <951a01b5da3061e1ac1d396ba7f6629e3a0e9a1e.camel@apitzsch.eu>
 <b67eba2a-b07a-4076-92bb-07bd0faf338e@sirena.org.uk>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <b67eba2a-b07a-4076-92bb-07bd0faf338e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/12/2023 15:49, Mark Brown wrote:
> On Fri, Dec 22, 2023 at 08:50:14AM +0100, André Apitzsch wrote:
>> Am Sonntag, dem 17.12.2023 um 08:24 -0600 schrieb Rob Herring:
>>> On Sun, 17 Dec 2023 14:21:39 +0100, André Apitzsch wrote:
> 
>>> dtschema/dtc warnings/errors:
>>> /builds/robherring/dt-review-
>>> ci/linux/Documentation/devicetree/bindings/regulator/ti,tps65132.yaml
>>> : 'maintainers' is a required property
>>> 	hint: Metaschema for devicetree binding documentation
>>> 	from schema $id:
>>> http://devicetree.org/meta-schemas/base.yaml#
> 
>> I haven't add a maintainer, yet, as the driver for tps65132 doesn't
>> list one.
> 
>> Who is willing to be listed as maintainer for this device or who can be
>> asked to become a maintainer for tps65132?
> 
> You could just put the list in as a fallback I guess?
> 
> The requirement for DT maintainer does seem to in conflict with the push
> to convert things when people are doing incidental work on the driver...

I agree. How about relaxing the check and not marking missing maintainer
as a failure?

Best regards,
Krzysztof


