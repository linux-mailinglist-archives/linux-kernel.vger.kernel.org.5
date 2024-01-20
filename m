Return-Path: <linux-kernel+bounces-31799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 800B48334BC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 14:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03EE1F22842
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 13:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8DBF4E2;
	Sat, 20 Jan 2024 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iupmm4Aa"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD11EAF6
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705755854; cv=none; b=M7lcRclzdYgv7nAJdc8hO6YD6EVvi3sxoFQAtp2rcogPtW7l2j57Q8Pbh6CX3yztU+60nLzuo+joqDvEn+Xb+o+f5kOpN5K9j/KipU4iXbI0heFyutVslGN9RMXfUsuf2eYW5O4ssUZNFV6hqdeKt6WIdOFS4e78RzkvKM1flPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705755854; c=relaxed/simple;
	bh=uk61y7dRGYGahSnylJp/7naFuCpcd2yPoEqnaDbOQI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2J7qxMVgj3cBbC6SE2I5Fh961vzkTEVJiPraw7hik/i1fsohgEOG5Ux6RN8iDFPe0MhGFWf3Fn/dYrPXKhYMTIs9t7B7Mk4yPAqyOu7INHVtHHcoQs26kJdPMmOam6YaCCpFKZnJB0E/cfsqzIV0aWq473gyxWAtPVXY3aWNE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iupmm4Aa; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2a17f3217aso156943266b.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 05:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705755851; x=1706360651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uk61y7dRGYGahSnylJp/7naFuCpcd2yPoEqnaDbOQI8=;
        b=iupmm4AaGVtPp2Gsa0Zve0avobmu9CG3n6e4CAI52cmUVQTAF5o8Pi+nBqfDI8ygj8
         wBiKp6Ih8S49BM4jU0kzmooCfSUfFxY2KWV5dTppCDs4WCALbOJ5JWkqPOSGjngbYn2o
         0mAfNYy8M7j/1MkZBEgqAUgDXQK4soXhjwmK/yKriAygrL/7Zbs78G4sNGICfImUnvmS
         bxaxDPkd0cu8uCSe7hmz+ztRLsmyzY3+X+qHQ69BcVNylgt/8TCickqC70K3ULv/fkAK
         eaGt1mTT40Rja67LT3/rtm30dG9WTA5Y+ZxJf2cwYb3Nb5Vn8fx8LoOEUAAjFR0/c8iy
         ze4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705755851; x=1706360651;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uk61y7dRGYGahSnylJp/7naFuCpcd2yPoEqnaDbOQI8=;
        b=CpH7fEsaLJ8zPEXPOW7lrRLCKQoo9g9DXDcrwIDIJuasF3vuxygsbFgjLfN35/5c7q
         MncyjdDihRYjENcgY1i8VgRWvHPY8ZdYzxsuyfhHbMedrTL1vS/ZtJIMkj61kPmni8YW
         GrdM3VU+u0pZ07ErhA8Vzihz0zmCM7gTZIpHnmKjaoZZbLbF18Klw9x44UgnFT/uK876
         bQEuAeQpBoS0Xe3IO0QvPRKqrdnPE/Bb49EP/+eYbIrQJ3W6ZqIJYu/Df3uPjd8/vnmf
         AZRa/An27bDbejbnyT1hlmotxboM+h74oYSA7+mNfdxsLUP6hAMOtnYSni+kiyBmmzL9
         Erqw==
X-Gm-Message-State: AOJu0YzbVqVn3/M4ZqVqnioT1RQNMEgHy0nZMgFIsdT7nEgtyqigsjLq
	6nLr/TTAN0Kklg8CTAKebnQxubF5Dp1aompdNSB2T874ivtz99RHi6SzXKghEIc=
X-Google-Smtp-Source: AGHT+IE3TW6xa/XT6ugvpd+R+nL/cPqlYt0gnHhLsJykqF/oltSUGqLLAQrDfUOOR/NHYEKhD9ZN+A==
X-Received: by 2002:a17:906:5784:b0:a2b:1ba9:873b with SMTP id k4-20020a170906578400b00a2b1ba9873bmr714181ejq.125.1705755850854;
        Sat, 20 Jan 2024 05:04:10 -0800 (PST)
Received: from [192.168.231.132] (178235179218.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.218])
        by smtp.gmail.com with ESMTPSA id vs7-20020a170907a58700b00a2caa85c56csm10453324ejc.38.2024.01.20.05.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 05:04:10 -0800 (PST)
Message-ID: <6ceb3c5d-4171-4f0e-a1c0-22a8488ea2bc@linaro.org>
Date: Sat, 20 Jan 2024 14:04:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add board-id support for multiple DT selection
To: Amrit Anand <quic_amrianan@quicinc.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org,
 andersson@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, kernel@quicinc.com
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.01.2024 12:20, Amrit Anand wrote:
> Device manufacturers frequently ship multiple boards or SKUs under a
> single software package. These software packages will ship multiple
> devicetree blobs and require some mechanism to pick the correct DTB for
> the board the software package was deployed. Introduce a common
> definition for adding board identifiers to device trees. board-id
> provides a mechanism for bootloaders to select the appropriate DTB which
> is vendor/OEM-agnostic.

Maybe it'd be a good idea to add it to the base spec!

https://github.com/devicetree-org/devicetree-specification

Konrad

