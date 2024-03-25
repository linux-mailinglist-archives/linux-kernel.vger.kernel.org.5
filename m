Return-Path: <linux-kernel+bounces-117821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92AC88AFF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E67E1F64EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BDF14AB8;
	Mon, 25 Mar 2024 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQd6003u"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F31BC20
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394940; cv=none; b=PK1PAT9JAiCp2CNQFnIdF1/SAsDHFPxSca4n8P1n/coIGcNTwUclZaWztLS+8YNTKFCI4kv1AURf4F1t2jL4gKi0WEO6TT2v1qjs0j+zPsVc8PWMu153ihm35gQPWdt4w3ctQdSbRbzH7N2S3+DExRZXifS1xwf4Qy211jwYxT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394940; c=relaxed/simple;
	bh=w0zWA6EouN/rnNXOFnnIdvhkYC84L+qVzJNf7dwYdnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZabA58VUE2F1uwcYM3ItkkScTjXXU3iZJFfef1qAuKJRyd/TNdbeDcCOkvHFAdYc12BZ8D/B7fuALpU3HXwsMRMe9b4QTKpbA0TcKIoMP3LJvaMvkbzSKQ4Er76iTo1dptxPHDF11+we2hWtEstxgC4PzRe/2mRh+E+OgHwhWXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EQd6003u; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so3512224a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711394937; x=1711999737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=chfmXDrKNNgP9X6i+M1nQ4WqhWA7PJIRLQjiG2HOs+4=;
        b=EQd6003uua0bPvzTCd4ofw+oitbqaTYoIwBgO1mSuctoLq06Hfdj234sD4ycfQKHYS
         8JZ3lUzWRgdhF+DMhpAIzsqT3o+FlD6kplJEPDmFgJtvp+TLiiNhpmpz50TkFo0L8fhk
         x2Tu0wq5QrxGhXT65XvrQnaY58tvAd5I653qYy1NwbvvY4Dp2yHduK27Mk/X2GNCNz93
         02V/jD9t5kHhfQ/3xJuYDkgzpu4G3vSu3YPhHYS/7rMu5EoRC0jAyTB8rwxj2jKMdYnX
         qn3bbk50XylIQLPq8Z5mZpEHgMYevmPb4i1FHgTTvjuCh01wlFSIbvVWrfrnJ2Var5P/
         A79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711394937; x=1711999737;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chfmXDrKNNgP9X6i+M1nQ4WqhWA7PJIRLQjiG2HOs+4=;
        b=jETFxCkQ0Sijipjv7hSkEp3aYJdE4ez/2KS3nz3QY0IUSoLebk1ceHPiY4+hNyfywo
         cLhlwOU+5mOihULBw52BtlEZF5edRoHfZ+HavA979/d0p0DyCTUKkfCmJhvwDxChJBwt
         CXCpcjcfBvYgwFt2OjIUBzg6ArTYK/Mri/yqi9UwMP/7AEocseWYRBWGPvFhFSqSscrH
         DKfXygXcGI8YqRiTXnXf+57WBLQrSlx+f7+3pzWjItuBIFXaw4UVeQ9F8gy5rjWMnotX
         kgQt5ZIsVsMLRJB6mrvwinoJJPKSc68Paaumct+7ggBuWFvBz/Q5fQXaESTgCynABNeY
         UMwg==
X-Forwarded-Encrypted: i=1; AJvYcCWUjjtpBtddaRGAZF+HbcmhWqvdHl3dUznSKfJcnD/glFoLsNXfbCjn70MF6Ff5X0YRy6EUevZ8/ru2h3QaAv2nsG3HtB5QC2NSjq2u
X-Gm-Message-State: AOJu0YxR/cnTvEszYsnUHIzdak3Aa6s7+uq9Waj8VLauVBi+DNbAfUTH
	FmQs3SbO3fV4Cah4cbP3rV1QCRhFbfuqOZbfN3JeU8s6Z1o+q6KiKzslcr9G/38=
X-Google-Smtp-Source: AGHT+IE2RMfSM2cCW0wAoarbiw70Ce0mza7FQxB+mDpyNdrL6qh2g3k4ATVlcyLo5+nesKjyumi69g==
X-Received: by 2002:a50:c014:0:b0:568:d729:a41a with SMTP id r20-20020a50c014000000b00568d729a41amr5522869edb.9.1711394937180;
        Mon, 25 Mar 2024 12:28:57 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id t6-20020a056402020600b0056bb6a51dd9sm3256518edv.24.2024.03.25.12.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:28:56 -0700 (PDT)
Message-ID: <0be5b908-7e3a-4cea-b8b7-cf726b32c8b3@linaro.org>
Date: Mon, 25 Mar 2024 20:28:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: configs: enable REGULATOR_QCOM_USB_VBUS
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20240325-arm64-config-usb-vbus-v1-1-d14601f81d08@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240325-arm64-config-usb-vbus-v1-1-d14601f81d08@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.03.2024 2:46 PM, Dmitry Baryshkov wrote:
> Enable the VBUS regulator used on Qualcomm platforms (RB1, RB2, RB5) to
> supply VBUS voltage to the USB-C connector.
> 
> Reported-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

