Return-Path: <linux-kernel+bounces-154805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB988AE143
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921F81F23488
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0329959B4D;
	Tue, 23 Apr 2024 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QV9dkTFI"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0A459151
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865556; cv=none; b=idntR3Icw+4dtfpVnv7NLUDenqvVRq+dSWpMkeo1AqKZoRe3+VdFbAakPQ66JaXb7JJHWdo/BrJmGLOIK0D2FhfTWmzfkwUlVEMkT7TY6PQxnEpf5FRkhlw+wrQb8Y8go3KnOHaGYlEtxmZWdL4nGEWO1tkZH0Pn7mMYL16ixiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865556; c=relaxed/simple;
	bh=0OXawXezReq/pJRii8qLy/MIW9NlwSQfDqgM87a8Cyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R62R64pK/EIYHtZjInqvnWAkIY1J/pWO8rGkM6/H6GrqlKPJN+zDLJ+oaE8bWUKEXv0fR+zfoCySlgDSHZ/jrNU2Rnsb2wmsz1TwNyZ+AXrOJ/DTQmeEQK5Rj4uwUjifhUjdcsgDLVHvRi//dgxQGTy/eT8lAOZeMSDE9famylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QV9dkTFI; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5200202c1bso647045766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713865553; x=1714470353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0OXawXezReq/pJRii8qLy/MIW9NlwSQfDqgM87a8Cyc=;
        b=QV9dkTFIBoSXGdispda3NjaYxHBNH3K25e/b7iwLWosGYMb6qpbAsGyXg+Hj5yOmG/
         sGEv7f6K3tuk7I/alh67NZHC09qlrjWrOfXBdm8aCVHnyfX+crQ0RPgCR9CjxTlBjSUu
         h+2Pqah4gtxVvIwieg0q6oB778bD0GQD3uga8T58/8RFldnAjYc1+QzUkVRbXcHGalvS
         cQS97Z3n2pTCEjQUoQ9gvvypkPypNJLrLffILd2Wxsk+MCuHH2qKlBLxIXgOCOgitqbI
         055NlysDytSqoorNithSIkq17f86XmUh6rl6BZ4n+b5w3ysR1GAEC8UhY05VG601Ot3I
         pOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713865553; x=1714470353;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OXawXezReq/pJRii8qLy/MIW9NlwSQfDqgM87a8Cyc=;
        b=PlY8rwNn/cCsTKvNKq7S7YDUW95SY/wKb9teHitu4qDeXKgWrOXoK6KxvL748T8bBP
         PAz8BbMWUhNiPP07uQCbXqk9d9+z66+//Z9BHc9NuPdZ3qv+mG4Zti1DX6prxX4/b/2m
         7GGpv+cvfjwFWYfvufjDEJr5A0iy5UP7tGA0pEiufCjEWhgMGxsy88BdSFDontwcUwHz
         Oz2UjW2r/cqOLB7HlNqanFl1gyP0zYV+3SzPGT4SBW0NUxWitQPx/tn7AuxlWgdfQrD6
         SymeIXxjwf22bRhaTq+0wFWO3ZY0Jlw1lVMOSc1PwT2lKuqPvkqSBQkHTercaK1n/KTg
         jFXw==
X-Forwarded-Encrypted: i=1; AJvYcCVLXulY5lrW4HtuUPo4+1RMk1HfE6FNRYaCUatx76A78khTeC/LSL6dGsU56VBYI4Eg9PgpKEM0lToH1qp8AqqRiLyia3lk1AKjYbXk
X-Gm-Message-State: AOJu0Yy0MFwGAjp6cWt6XxPCJX+GKEP2FmKNbxWzTV6vI9oV8tQuDp3r
	SMNRtPPd2abCLbPWr2mmKZxRpSMMFkLNWJ12Dh67gUTJ2Z4V+SW2TPQSD1BAxAw=
X-Google-Smtp-Source: AGHT+IEDNnvCIJghyjpAWJKdMY7UMuoZjbCNlqfphMG1kOwc/wCe7RDUjLqV7plqyEmjEjFqGTPORQ==
X-Received: by 2002:a17:907:1115:b0:a58:7ea5:c49b with SMTP id qu21-20020a170907111500b00a587ea5c49bmr1395621ejb.42.1713865548776;
        Tue, 23 Apr 2024 02:45:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id gc24-20020a170906c8d800b00a55ac217235sm3076796ejb.90.2024.04.23.02.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 02:45:48 -0700 (PDT)
Message-ID: <605ebf52-a7d6-455b-9009-dad36b8cd8eb@linaro.org>
Date: Tue, 23 Apr 2024 11:45:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] dt-bindings: iio: imu: Add docs for ADIS16545/47
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
 linux-kernel@vger.kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, corbet@lwn.net,
 conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
 <20240423084210.191987-4-ramona.gradinariu@analog.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240423084210.191987-4-ramona.gradinariu@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/04/2024 10:42, Ramona Gradinariu wrote:
> Update ADIS16480 existing documentation with documentation for
> ADIS16545/47 devices.

Nothing in this commit msg explains me why they are not compatible,
while driver suggests a bit they are.

A nit, subject: drop second/last, redundant "docs for". The
"dt-bindings" prefix is already stating that these are bindings which is
documentation.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Best regards,
Krzysztof


