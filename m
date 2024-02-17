Return-Path: <linux-kernel+bounces-69883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8910B858FD4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C89282ADC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626427B3C7;
	Sat, 17 Feb 2024 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcMKsZO0"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058107A72E
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708178250; cv=none; b=nKnIbSnYaZmYxVDt4L5rsluo4M7k+ZRp0ex7CiAB/BaCNeS7fzqinTLmtOqfJTzRBN3A8d/P4LgSlsrA1nMrNI/SzURWeVEymyDPL2qOjHal3kctWnPoGKgg9bwDm82vaUCL0hPhpA7QwegHqs0kaIMbye0o9qPap2X0myc2hno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708178250; c=relaxed/simple;
	bh=ryM+C4TUaD1TtA4eDxWWXV1YoFmsoAFDJN7ycQy+f5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iiak8YWTtR71iedLLaTk2YHi4Z0zCOCE6PqA+wM825aeLGqsO/w/PdDgp0V8UAG0ImVnT1XpFLnBvJWLwHkHIXG+WVWUZGG55kNzLDTzkpVC0dfiPrgQuXerM+i/m6xrSILoYk/wtY7AiR2GWOicYtSSUaGwkbxc/OtVP/FsN+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AcMKsZO0; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5129ece824aso1043556e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 05:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708178247; x=1708783047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHkv62BBlSsKFseDzKxHUgPCAgv++YI7qwmDq3fNylE=;
        b=AcMKsZO0GYso5J1BvhAiCjI8T8H9K24dRA19lIuv6yXly/9ojulI8UgjtcYf5/QoSF
         u5ccCxC7w/0ITBh7yp/VvcteGue0T6nXENUbMVavQ/l4/23LwborqS0twJ2BOaZi7Os8
         ULa4zGnsl2sVXWqa6qP1CFw5crQUxgIqntxaFD37JIk8eWKYqAMZHVLiew4lM7wX7PyW
         q5XnBqbsLfR4S2Bwe0HWjtFE/bGFQM2rfyq12XYd70mKUzK26u0yKxtkycOa2mr+BiFn
         6jvkKN8w9sfeIphh098lQeiqj38+qV43O6p6LGrC4X9Z+N9Q2K301MuXTDquYcPJD9bf
         bC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708178247; x=1708783047;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHkv62BBlSsKFseDzKxHUgPCAgv++YI7qwmDq3fNylE=;
        b=XoUUZEM0Elcj/AYZt0/TJYVD0Hi1G+t4ChWgUPKDjY83mX5weO0fiM/11AwxZDxpms
         SjYCjLX4WROQc1/0qvBp+Sa9AX1zhoaGLSNZu1kbedCnwIpkLjR0isXPyOvSLNLxEK0T
         NwD9GAbGpptPN3YLKvMVRXhDeZBmZY8ro155itGJy9NBCMj9g6w56OmoCh0xOEyrtNYZ
         alNgS6820zp0YHcjHnthwU8d8QC2rfAyZn7tRVY+Y43iBSy4Ge4fw1YQ3PVJb3yw4i3/
         dYYCiVNeQHuTnIYMTWE+3c00CyDhkErW6HD2GYDhy7x/1UJUOW6gnr4zJ+RFH6AtK/Jk
         G/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWg2IjAHC0sopYcQoebFbg4Xbn3sgZCU0Z3DPUeK7vfKBdBL/DcwK2tXUHAsPrJD1jLAsNGYyNgy/3CAQUJsQAmX776cR1CCVYONMCp
X-Gm-Message-State: AOJu0YwtlHbLlndc0PkS9nBOvNIjblOkuq8ScQCBjVXvQ07yUPZ1TStg
	DmmhZTjUAtrQHH1ngE8OCXJi9mkct84xLHSjo+Ukwcn20MZ4hBZChdni5H7fT9Q=
X-Google-Smtp-Source: AGHT+IEb3VOP9YWFz1SvNwuQRPmz6cT7GnOXl00S+pVjzHLAxIqQi4ENCZ3RixYd/Eus3N/cMGHK6w==
X-Received: by 2002:ac2:4145:0:b0:511:7021:9418 with SMTP id c5-20020ac24145000000b0051170219418mr4909371lfi.69.1708178247242;
        Sat, 17 Feb 2024 05:57:27 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id ec11-20020a0564020d4b00b005643f110e66sm71005edb.16.2024.02.17.05.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 05:57:26 -0800 (PST)
Message-ID: <ad30fcc6-4a47-411a-9deb-ee26cb6109ff@linaro.org>
Date: Sat, 17 Feb 2024 14:57:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: i3c-hub: Add Renesas RG3MxxB12A1 I3C HUB
Content-Language: en-US
To: Steven Niu <steven.niu.uj@renesas.com>, alexandre.belloni@bootlin.com,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
Cc: zbigniew.lukwinski@linux.intel.com
References: <20240217131412.4145506-1-steven.niu.uj@renesas.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240217131412.4145506-1-steven.niu.uj@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/02/2024 14:14, Steven Niu wrote:
> +
> +    patternProperties:
> +      "@0,0$":
> +        type: object
> +        description: |
> +          Backend for handling SMBus mode, should be named: backend@0,0
> +          Adding this node installs the backed for handling SMBus Target mode communication.
> +
> +        properties:
> +          compatible:
> +            description:
> +              Compatible of the I2C/SMBus backend.
> +
> +          target-reg:
> +            description:

Heh, you did not even bother with testing this...

Best regards,
Krzysztof


