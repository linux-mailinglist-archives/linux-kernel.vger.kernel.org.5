Return-Path: <linux-kernel+bounces-119193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33FF88C556
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EEBC2E13A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68C113C3E1;
	Tue, 26 Mar 2024 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmJDdAEm"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5F013C3E0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463974; cv=none; b=Kga8zmf05D92KU5ziu1CfYf1pY2MpwK/DUHx4VToiTyr5qzQ6oOtLAO6Ga6U+Jg85/LiLh+X2cRom8mDz7uTfHQtYRzJKztwAVlbPW1GzhG1hGfa1QCcNhCwNKZPf+zxptjkY4gc1gNkSRHRwpVEpG2JNbdGJDQyZdxh//8/x0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463974; c=relaxed/simple;
	bh=PVCqUI2IthMT8jtHUQFgN0wk4nd/zHp6x9pGlyM8wjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVCFsiqtb6MikjwCLJScb8NeifUEGuuSxLDOd/TZUptnnT74r3LeV57c9KV1K/gdjG8yaYO1FNU2lM2SGRMGhNQAvIYM0LG02j+4OS6Ci+eWURLSN67vBYSb+Ej8FRHlLHjpsDSv+aLxynxrpgnT1oH0U2RvWaTVGnQTOSVFTfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mmJDdAEm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-341cf28e055so1475908f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711463970; x=1712068770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfqyT8DykVWS2FVT06Lc/GB2ETA54ZjApWkcdYSEHgE=;
        b=mmJDdAEmdcbg0XZ0wVIXC76s8wLBrcmWLcyW2MIbty/FPvCRK9LP7CJjR938Ihj7a8
         hwJUY+skNoWBMpMf7kcKKYzZSbfO2Y3u+/UW8XeMpjIVuro0BOAHuYI7ifNGRzvGaXPW
         m2MF339XVJV1sIk5JSmTJA/VdVMmN15NutP3SlOhqjFfFDC11WSPobqNmFntqtCBO5v/
         fRxmaFcks0hg/5B++kL47PfE14q41OfIvIFnqZRokCX8a1WL11e1UMJ/X1/++hwwFdSb
         09hChma3FRfpKFg3P6RRd4WgLFD1dm+oWkFR7M6jp/rMVqxUK+tmS0jPpEWikb05eSy/
         Pcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711463970; x=1712068770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfqyT8DykVWS2FVT06Lc/GB2ETA54ZjApWkcdYSEHgE=;
        b=hv/EHwKW1c3MKdQ1EPR/oVLWeAkSXZXKXrZi+PtnGWliHXME1gGRM2HYitRYAyLZYG
         l0F3OJcYlld3Ru9otd2TxW/KTr7DHPcu1cxqXnZpBuNFTp7jwvg2bLJpCh2Cctql968J
         NdLo/WgqEmcGSxg7tQZ2i0J46i4LddoKFvEBMDQMCX4ywwMYZFxTMUbZy1duvdSejDGw
         FAUBX9GiMz9EUN3ts5OoqnwWcUYAGqhnLUpQIUV/JHFaivmrFUuaPvKwYCDjzQHwDFqC
         ivN69/KB97RAU+kExeyw6luDxOrLa4aHkiWNc4ATN3R0E94zd1vYKwp4/hCmhZv+PLL4
         PZwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYSKB8CC+TXB0x/YQljqjPqYXsOgwtJSX6MQMGvI/rQtayK0DUu92ZHwmbnx8xK+cloPW1J+wpn5Q80339WzWUrT5cMkEw0aLgLHYg
X-Gm-Message-State: AOJu0YzFq0zB4vzh0869wZC6NVvoXkmGEjqYJ/Ket3snDHDYYoeh20uH
	bir+IkMNUZkuAizMT9yq+nO4DbQ5LS9cGs8e80icjucqWajIYVjmotvj/gksD2g=
X-Google-Smtp-Source: AGHT+IFMbpIbW88EA8mOGps+QLuXd1FMyYQpvKzji8LKbQ9tVeTRAt7QVs0I2203R8pDGu9n+TxvwA==
X-Received: by 2002:a5d:42c3:0:b0:33e:7650:1297 with SMTP id t3-20020a5d42c3000000b0033e76501297mr7274848wrr.6.1711463969712;
        Tue, 26 Mar 2024 07:39:29 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.252])
        by smtp.gmail.com with ESMTPSA id bo4-20020a056000068400b00341b749ab8bsm10004692wrb.69.2024.03.26.07.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 07:39:29 -0700 (PDT)
Message-ID: <b80134a2-99b8-489e-860e-7ddb2bda576a@linaro.org>
Date: Tue, 26 Mar 2024 14:39:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm64: dts: exynos: gs101: order pinctrl-* props
 alphabetically
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 peter.griffin@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, willmcvicker@google.com,
 kernel-team@android.com
References: <20240326103620.298298-1-tudor.ambarus@linaro.org>
 <20240326103620.298298-3-tudor.ambarus@linaro.org>
 <9f2c715e671de0c083355bfbece703936e14045a.camel@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <9f2c715e671de0c083355bfbece703936e14045a.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/26/24 11:13, André Draszik wrote:
> Hi Tudor,
> 
> On Tue, 2024-03-26 at 10:36 +0000, Tudor Ambarus wrote:
>> Reverse pinctrl-* lines, first pinctrl-0 then pinctrl-names. Move the
>> pinctrl-* properties after clocks so that we keep alphabetic order and
>> align with the other similar definitions.
> 
> Krzysztof had requested to change not just the DTSI but all instances for GS101
> here:
> https://lore.kernel.org/all/98810c49-38e6-4402-bd47-05d8cbc99ef3@linaro.org/
> 

ah, yes, makes sense. I saw you had your own patch doing the reverse,
I'll take yours and rebase on top.

