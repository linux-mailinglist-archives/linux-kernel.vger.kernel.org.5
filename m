Return-Path: <linux-kernel+bounces-70457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 313DC85981D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F951F21446
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FF66EB76;
	Sun, 18 Feb 2024 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="feXa9mrL"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37B66EB59
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708276456; cv=none; b=OE0y+C1Iujdy273c48zsO3mf3VlrWy8Opk+UdoGOHFht3ecjKZQrmLmUn51drhKLlgXtlENzED2d7HHCKU4c+HG8kZNVFjnVjic+fpGXs3wERhJaO9DBdC0NyhLtU3SPIUWprfhauWU2DmeorEiJwKv5f1boTWNoO+FqbeF62x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708276456; c=relaxed/simple;
	bh=ik6LFU2g/Xtu20Bggy3zuFPBkfuHDKfMzcQaypec6kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6/HdJZzH/cVSzGIK5EC8kDK1ejIF6YjqPF5lZNBliJ4vUgTLoomYO432Mm2rFzbITylWt8sKZYiPM2Dk+jYML9aicGNzLHtV1mH9ZCn6C01O2TmC2Tn6nkAUxqod5o7x6GNgUXhBEl/t6W7jdg1h6c/pjwYvH/0CrTaT59lFow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=feXa9mrL; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5611e54a92dso4746561a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 09:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708276452; x=1708881252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5PgXy1mNzNznf4vOrmS/GojRXSRWqYAQYz0rl4V8+Nk=;
        b=feXa9mrLcYwE+fLSIUZ5Va4emMDsZt8o/8+K80JNtmSnjfr/Ng2d8f6qijflkKgRGc
         S/IvXY+zV2dRBNhU5QWCzZehlTcYFjQnAbqPzYZnpCFYTuE3bRuAC15q6aR3PvIVll0y
         7HlmNtrd1+Bpf0WzL85JGFMlObVXVRVP1IJiYqv8JvhLUEsJm0ZoCl/enstIAIETWarD
         /2r/59P1ra2EFx3NUX1AzS3iP1DZovYLJW/fZMwi2sYPGehGQEt85UmHkaikG191Cfe0
         fVqTRsgyfAPPbLsqbhDQMgwXWSrE/bOjDh00xQRKOJJQWhgJczD+YgR3AwVNn2H42LxH
         34wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708276452; x=1708881252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5PgXy1mNzNznf4vOrmS/GojRXSRWqYAQYz0rl4V8+Nk=;
        b=U7ggxiFqWIMZn4LdA+g2gq65KYPi7XX8jhGbrfxb6WJj5M6FYfYx37ePeN5YdUtjro
         iabtX5SrFoNtyxFSBcwqAdBMfYw6wY0MWFJfybOb4pxquPykLCTd4PkVom/ZBEvr4sGS
         OZ818Pc0XqCXG0Ges6UzEkQ1L+VRQd7mteaYlFiDaT2ijCgfa1saYRDUwwbVosfrdndA
         1yD63hwhNtNSgPSqg41mVeA7thqv2cgOgpQAMLAfF5NmDUnCLDyskLNvIDTQzeMIQ5p5
         NNNnfS4JAuWC6xAJ8sckLRN8SofrccI4wDMnbB1FcXmWk/auTwIfu2m3bvGHJ6CcV1gK
         ewvA==
X-Forwarded-Encrypted: i=1; AJvYcCVrVLo5aWj7534Jo7yYi2jeDoH2ioaY9+rY3r8nUjKWMlfxwFcuXV+rzwNbHqSHnHIobVE2C015ettwul6JAbtpSKGdWQPHjxoZ9OFI
X-Gm-Message-State: AOJu0YxyubWBp4U4owi5+MtszreJUcCC5FSrNu1rPT0v+JVz2kteSAol
	uEth8pE1h3nHIB92xIBqzDa7GP/iZxMe3RwVXtHs9F5fCyjQ1QNWuXn7nFVluXo=
X-Google-Smtp-Source: AGHT+IEfeVD9FTs1tbP21ChidSSSzh6e4y/Zb+Eco3tgIv7H2djxYDlNAVeZed/uf0Qg3ajMvLhDXA==
X-Received: by 2002:a17:906:40d2:b0:a3d:d0fa:e2dc with SMTP id a18-20020a17090640d200b00a3dd0fae2dcmr5267607ejk.55.1708276452087;
        Sun, 18 Feb 2024 09:14:12 -0800 (PST)
Received: from ?IPV6:2001:1c06:2302:5600:366d:ca8f:f3af:381? (2001-1c06-2302-5600-366d-ca8f-f3af-0381.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:366d:ca8f:f3af:381])
        by smtp.gmail.com with ESMTPSA id ha1-20020a170906a88100b00a381ca0e589sm2085309ejb.22.2024.02.18.09.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 09:14:11 -0800 (PST)
Message-ID: <44c669a0-3722-4a58-be78-0c91f0573ca1@linaro.org>
Date: Sun, 18 Feb 2024 17:14:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm6150: define USB-C related blocks
Content-Language: en-US
To: Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 gregkh@linuxfoundation.org, quic_wcheng@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240217163201.32989-1-danila@jiaxyga.com>
 <20240217163201.32989-4-danila@jiaxyga.com>
 <6bf11ccd-ff08-369b-913f-277c189afb76@linaro.org>
 <b0b732b8-456a-4021-8277-cd51f01ead17@jiaxyga.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <b0b732b8-456a-4021-8277-cd51f01ead17@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/02/2024 8:05 a.m., Danila Tikhonov wrote:
> I know that some interrupts have both for PM8150B, but for PM6150 all 
> interrupts are rising.
> Please look at the downstream kernel:
> https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/187022f2721d584ac4ec92c0ac1af77da487521d/arch/arm64/boot/dts/qcom/pm6150.dtsi#L319
> https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/187022f2721d584ac4ec92c0ac1af77da487521d/arch/arm64/boot/dts/qcom/pm8150b.dtsi#L292
> 


Please take a look here, I think the same logic should apply to your 
patchset.

https://www.spinics.net/lists/devicetree/msg665558.html

---
bod

