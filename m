Return-Path: <linux-kernel+bounces-44076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5178E841D09
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E7C1F26167
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5677D54668;
	Tue, 30 Jan 2024 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HSVBKq41"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01225645A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706601239; cv=none; b=OYwptx+LKC1v5JZ7Bb+i/o0hMXT+szzhheslk1ff54CIVDOWFjjUeXnj36z4YvdASK8UyFhLFTxvdRwryBrPLxcuQ7hvEMDUmmtuDLsUAIs4Xxj1zqN2NdyZDhwDy9Y8e32a/MpJSQlhvsPPzjSPa9ulCphlKUHASDSTuD6jtvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706601239; c=relaxed/simple;
	bh=3NRFhG0LFEEZz4jUxyIebYTcUYAZx7C9kx83JRBYHI4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CJJ1L2MB6COsiys59M3V08k7WLXHJm3NENp5VMq5cApqycxnCUvZI4e8eEcUXKyIdv7iKIoXq5QqRpysqQybXv8sXeyHfMj7oK+crsvvWdB0kCtDaQVcaxRYMv/TQ2435VOOD3GT1e3AK9wFfkPwrd+zDMtdXDC6V26rWJwuzw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HSVBKq41; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28fb463a28so421439066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706601236; x=1707206036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3NRFhG0LFEEZz4jUxyIebYTcUYAZx7C9kx83JRBYHI4=;
        b=HSVBKq410O5toRQHWhhXK1+a810MJIkq2CkDDSa8x+W3TqHoVt5aA1n6PjDF4PA2hs
         cP1+ttlQVke9rEOwizLU7MtnGtLkD6PhZV0A0Rnm3rnloelxEeb00rm0Tzrj2grphqjC
         P8aPaNpnTfxSIDMIF4RosTjS0IJ4DXzxKpHJqciZ1vGRAfk9tw2HaKdnK9aw/Lc0P9vk
         D7FT6JdToISoQnHSNKvus724J9pt3icsBBvtk5KYWC0zy0S3cms0SQYbt+qd8oH97IBU
         Ey9K+DGS2hUuuGxht2rNGN5tYHFORydJs1qvHZ/Tb3US3YbMhTVsGbWMeG2iAFBOyPXM
         hS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706601236; x=1707206036;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NRFhG0LFEEZz4jUxyIebYTcUYAZx7C9kx83JRBYHI4=;
        b=mIdaWC/F3AjLBfu6X4NIqxQxipKr00EbkGP3g5OVvvdxbj4OUjZSd3vYXn+/2XMrso
         SVDGvAmzxdSp/nIHxVMJLFaT1T0UVcgvizQkJj82DR9XWRJv5+ATN7AqU81GhVSdWhMo
         nKyWdj11D6whsGOBNv1+55S6Mx2BOLw3DdiW0STQ0BAqdMTro81u+i25LAj6QcuHBOJ3
         PqiF5kay2Sqc/9i/npZPj9d4LaQuHgKdv6UulBlT8HoSxSHnOQqKVA5e1OOn9MpiY44X
         rxquNaGYBzWEvFz0j5EOSdKUKeKq9lfF6iA3KiaF6N2vs9UGdHP8+FJfkEkmUwd0xjpy
         YIrA==
X-Gm-Message-State: AOJu0YxLByeGCG+I2GOBuyUomzZZm37bcRVOdL7/GLr3YzsgzxiNnxpf
	Z/llyTvAtLflE1CCi7jujZEe3HZUbj4BL2LaVMGHvqOLizPwCNVyauB4nrDH2Zc=
X-Google-Smtp-Source: AGHT+IG0xIN6Wq+CQaIprYFhoRfHcs4BZgDz9GXKxO3R9oBCKqyMFB6tqBufNM2RSjJQe7z66OXbFg==
X-Received: by 2002:a17:906:b893:b0:a35:46d8:53ce with SMTP id hb19-20020a170906b89300b00a3546d853cemr5596503ejb.18.1706601236109;
        Mon, 29 Jan 2024 23:53:56 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ss6-20020a170907c00600b00a3533f17981sm3846787ejc.219.2024.01.29.23.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 23:53:55 -0800 (PST)
Message-ID: <d2ea2261-5581-46d7-8ac1-3441425566ac@linaro.org>
Date: Tue, 30 Jan 2024 08:53:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: fpga: xlnx,fpga-slave-selectmap: add DT
 schema
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Charles Perry <charles.perry@savoirfairelinux.com>, mdf@kernel.org
Cc: hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
 krzysztof.kozlowski+dt@linaro.org, bcody@markem-imaje.com,
 avandiver@markem-imaje.com, linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
 <20240129225602.3832449-2-charles.perry@savoirfairelinux.com>
 <f3cfffa0-5089-4bf7-b424-d5e949e36d67@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <f3cfffa0-5089-4bf7-b424-d5e949e36d67@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 08:52, Krzysztof Kozlowski wrote:
> Please run your patch through Xilinx folks before sending.

Uh, you are not Xilinx folk, so disregard that. Yet still amount of
trivial issues here point that you need to start from scratch from
existing schema or example-schema.

Best regards,
Krzysztof


