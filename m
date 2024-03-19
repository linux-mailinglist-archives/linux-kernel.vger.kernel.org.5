Return-Path: <linux-kernel+bounces-107721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FDE8800C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369C51C21FED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EA7657C4;
	Tue, 19 Mar 2024 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HSqSmUf1"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35427651B1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862348; cv=none; b=CuxCqhY3Jp/F4A0cYRJ4lvlF0RY5FRXeS3LYb3YRlQLCOTRAlPX+CLHCDePe1/ZrVnqA5/4tQo+l8smcHUSY1JkloH8Xiymu5/fEZdTW37q6eYVKeNXSQr+6OdNb9rJiu3iSPefVGtPF6+42ByxypCjSkDaLIKo2/5q3kilV4lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862348; c=relaxed/simple;
	bh=8el5b0ku76GSCLCtv0GaKB2j97sbDuSq9KU5iCRoZis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rifGQJgPHt3fZCMLJQZpLodzjNwMzzLRVScHSMHOI8VPb+uDio+cTVhP2UlZFwf4Ap1EXb+GKmP0gOifMK+3+vJedw8+Fq2UJEWVTvB6i0TfhWZ+heT7T6S0Jb9SkHB3bv/m7AQBd1jm5P2IbHhANbshgkygM3yZDAYHJt8ngZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HSqSmUf1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56a9f5694dcso2514714a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710862344; x=1711467144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zGCyaLMf02ijHLm5O55hQliE3n2jRuqUVXctXO/9sQU=;
        b=HSqSmUf14MAn360J0E94mRXEdrAuaqmq27ocM9BSyn+wZVnBQOS4gl55SGYrXFvlGO
         rrCJMsQzAaz8U5j8+oTmXNqRQFaS7+ujhbO6I0ljPBaBhEVtCJvYKnChg9T2nLOY7xve
         mZXwrS6vxq1zTy6Hiyst2lnyu9uqSK3IgGzb9fE8hlUtDlGzQ47e9iam/PXchbcnJmjD
         hBs12NrO4r5gT1WxlkCDnznlAqNAvuNjkQkSBcAsd842YHs+Z3RMl/8lwFKaet1N7Re0
         uC7/879BquNgZIRbykVDX/GYYG/VMNsOVIzXg7eb0UtBl8pBFgfwLHfMtRX8ahM1nU9g
         ng0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710862344; x=1711467144;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGCyaLMf02ijHLm5O55hQliE3n2jRuqUVXctXO/9sQU=;
        b=qj/JpLHK+bwXqdF6mECdK8wKjJjfkC2F8LGp0QaqcO726to8lItAlG8+v+jZadHZ8O
         VA8yYVHGhvQTOw7mJiEM5oVD06qgJEP3LQSsWaJ328WnwC1yfPJ8OS3aJYUUWWVBwBvM
         EknTqmv/gym8DoRsFYVjCnwbkmGfetEFGsQskLR40yIBZBABJEk1jwI0sEqBcfibyHka
         BM0rw597BuUuLIUEqa9dQ4hiMMiuMS69VkKSCCHxK8jdYkVs3ZAu4/tux7GxKuezqhs7
         tpH05g8JxKLbk24v1jj+TKaA5k3JlH1beJLx8zAGC4PW88OROXASgQ5QxOj26bjpriw8
         3Czg==
X-Forwarded-Encrypted: i=1; AJvYcCWo03aAjdabDkvEF7z6L1Xny8TkgADkThhwyqxvQO+kDAC9KhgTkggEor07bOh0o+km+WUvv51ZR2L23GcGnN1SZHsZ4yalxhx+lwiQ
X-Gm-Message-State: AOJu0YztD4XK+crBBA7yoECep5Rz930XUk0TCaN1YdvPSw4+9V7uZUSW
	tUISIiqaAMoTOaN0Mgx4tmMD1dA789o9shoVzqEgVnWYc4mDkQQRHdmBvKi/4nw=
X-Google-Smtp-Source: AGHT+IF7N1mDC4fgf8qY9b9XCwDzluCYv2BhD/gXy823eH0CyQes7kVo7POByw46U5TsUotSOMfg4w==
X-Received: by 2002:a17:906:ecf8:b0:a46:7c9c:10d0 with SMTP id qt24-20020a170906ecf800b00a467c9c10d0mr1653135ejb.23.1710862344297;
        Tue, 19 Mar 2024 08:32:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id dl19-20020a170907945300b00a44b90abb1dsm6116305ejc.110.2024.03.19.08.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 08:32:23 -0700 (PDT)
Message-ID: <cc82a7e8-eadd-44d1-af08-2d7594006778@linaro.org>
Date: Tue, 19 Mar 2024 16:32:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] virt: vmgenid: Add devicetree bindings support
To: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, thomas.lendacky@amd.com,
 dan.j.williams@intel.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: graf@amazon.de, dwmw@amazon.co.uk, bchalios@amazon.es,
 xmarcalx@amazon.co.uk
References: <20240319143253.22317-1-sudanl@amazon.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240319143253.22317-1-sudanl@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 15:32, Sudan Landge wrote:
> 
> To check schema and syntax errors, the bindings file is verified with:
> ```
>   make dt_binding_check \
>   DT_SCHEMA_FILES=Documentation/devicetree/bindings/vmgenid/vmgenid.yaml
> ```
> and the patches were verified with:
> `scripts/checkpatch.pl --strict v1-000*`.

BTW, if you insist on that and claim that this is a real hardware thing,
please upstream your hardware DTS...

Best regards,
Krzysztof


