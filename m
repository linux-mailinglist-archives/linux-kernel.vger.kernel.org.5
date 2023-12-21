Return-Path: <linux-kernel+bounces-8940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C9481BE59
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D252816E4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7189064A9A;
	Thu, 21 Dec 2023 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJdx07Mp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5732C1F601
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-54c5d041c23so1259580a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703183922; x=1703788722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kI54ctZ1zxG+ccdO4E1v3hg0oukkXhIS/AujWXv6nbk=;
        b=aJdx07MpdCCDbnrFsvGqYAGgJnQWwMKFx0Z6sFbiD2Oj9VZHn4+9daaYxDvi2OYBmy
         BMqsy///Bbk+1eFfN9GEWgOnBdUO8eeJi4EOV9hXMiqJjdtKSuSSRdNJSK/d/kOXS0q+
         BV4zhRfBQ/f/rvepoJJXIUaL63rUjmA6sTyTspJ4ch4Bz86DRbfY5MFa4EFzYb4j+gOg
         FjNnF0Vpa9/EfVxrCc/Lc/9I5gkBlcsBrnjjmyjuwyHCUJ7BbAYBjeZFavuLPJgbqujS
         VeJCr7HoYJiNgpHW4mh2Xwsk7yum2Eys4X46DPhRieD/48IdkfkbrMF2PtlCpTINPAyA
         GKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703183922; x=1703788722;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kI54ctZ1zxG+ccdO4E1v3hg0oukkXhIS/AujWXv6nbk=;
        b=T75qGoyza7yvhqT/9BZR1BDLSCIRAwVxNKi5Hy31eX65RZifRA/1EhIzfBPioh6JhQ
         /H6gRg0zwnrwQZ7sM3Wlqb573RTq1B66DILI43CL+g+rAi4NbSgxNoCt6nSGgQWiz3uT
         NI/ndxycUOiygBtM2xbtMTbTBhl2aljtUVysJ6CeIZI13fOIwAomiF08H395hJl/bbCY
         6nC8tHRny3OQX929XnPej2yyG86ojpn8HqkATQpzUamk4zHV3Q10OJiHMzgUd0dX+ol4
         Jkg+TqmcPGfQhFibiTKB6P5P1TGtLUKt0gqU03NhMEqUDpIXeY62GgAblDszxf6yK+Je
         KQmw==
X-Gm-Message-State: AOJu0YxYgT+CzLwtgLh+vWaf7W+/DwhEH821u5tZzQT5g6tdcA4PYRZH
	SYAMAe0iHl726g4cmPTINZ2n1qdPbn/uNA==
X-Google-Smtp-Source: AGHT+IHyZfJMfImeN75ulfr22BZwFPBycinBR2C+7RRdUe+0tz/AbkB5F2RdVRHbzhRyMH0NKKyshg==
X-Received: by 2002:aa7:d44b:0:b0:554:42fd:aa8a with SMTP id q11-20020aa7d44b000000b0055442fdaa8amr5121edr.149.1703183922561;
        Thu, 21 Dec 2023 10:38:42 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id b10-20020a0564021f0a00b00552d45bd8e7sm1498888edb.77.2023.12.21.10.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 10:38:42 -0800 (PST)
Message-ID: <50dceec0-3a43-4363-8404-d701f726acc0@linaro.org>
Date: Thu, 21 Dec 2023 19:38:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/22] ARM: dts: samsung: exynos5420: Enable
 cros-ec-spi as wake source
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Tzung-Bi Shih <tzungbi@kernel.org>, Raul Rangel <rrangel@chromium.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, Rob Herring
 <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.6.I06b059021de1bf6103e60a73211f078f2af75d17@changeid>
 <7199b7b7-238e-45de-96f1-0f04d0fa718d@linaro.org>
 <CANg-bXD+TVHO3o6f66fJXQ7AtXxPY00TQqjvX2vwk9PyTd1ZaA@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CANg-bXD+TVHO3o6f66fJXQ7AtXxPY00TQqjvX2vwk9PyTd1ZaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/12/2023 19:29, Mark Hasemeyer wrote:
>> You do not need this property, if driver assumes that. Just enable it
>> unconditionally.
> 
> The goal of this patch series is to change exactly that: to prevent
> the driver from unconditionally enabling the irq for wake.

But why? What is the problem being solved? Is unconditional wakeup in
the driver incorrect? If so, mention it shortly in the commit msg, what
is rationale because existing one does not justify this change.

> The driver works across numerous buses (spi, uart, i2c, lpc) and
> supports DT and ACPI.
> SPI+DT systems all happen to need irq wake enabled.
> 
>> I don't think anything from previous discussion was
>> resolved.
> 
> Which previous discussion do you mean? In v1 it was suggested to split

https://lore.kernel.org/all/20231213221124.GB2115075-robh@kernel.org/


Best regards,
Krzysztof


