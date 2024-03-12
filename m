Return-Path: <linux-kernel+bounces-99692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 862FC878BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10641C2145B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588D629AF;
	Tue, 12 Mar 2024 00:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PHhDC2sf"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9151FB2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710202443; cv=none; b=ZvnOoWmIZ2yVlRVdwBgV1iMD/mfx847ixg9B0slZkTxOzroZVxZFudkUI/vhEp0aapTnYbeCtO5qg+Augtroec7P9Ttv9gbeoPd2seHgOOHMTDrT29EHTuxMY3WA4LSo9XEhTzyNeE++x4oAPo7zBuS3e5iIEg5Jf7DU3uMW6kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710202443; c=relaxed/simple;
	bh=TZTFjad6w9R/A4c9QK4bJhaZRfOkzkbY0KMoh1WV0Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nbps6Qj9FiJR5msEW4Deah9l1X33t6Y4naQGVE608btLi+qQUIjUEhSf8MjmrS5gmix3Yd2gCIQrmXcxP7We3/6VPpRC9qADuQToEY5ASNWxUrdqTkhbV8BWK9WeotP0+V9pelxL4P3Dh0UGNLMhrFf9AlmCYkevD5ajl1Byyg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PHhDC2sf; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d3fb16f1a9so60071611fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710202440; x=1710807240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sX3f9yGyYab0yOk456EndE47zdI6JIzRTWi8Je071cs=;
        b=PHhDC2sfuHBuCBmoc2/RiBE6Vr+bdjz0Yl/QiFzEDgAZo/zA+ZfPSAmvgESijOGfmY
         lAtiLwTZP3rDqX7GOORFvgAfN7PqaFkEs+0E7IAkf/A8DktD6uRZN7B8gFt/YBlPS7Vq
         c9uSvZPotur95L8Qo2DbCo0WzvN2RE3i/Jzb71HgA/8hDsuAnH7KQBJHKFyn83+HmXcR
         lx1cMiBdrJ5RYLfbzGFBOpzj/sDhVhHukOKbRdq+vKQ1iqNjOIBe2SId1rorTDYXejL4
         Y6i1jLUsOyYc7P9+1CL/XjwOdWL58IjC/GERir4MnRR7R6zxqhXcYyeUXSfeJo0SGh/V
         M8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710202440; x=1710807240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sX3f9yGyYab0yOk456EndE47zdI6JIzRTWi8Je071cs=;
        b=YCo3T27ewVEOgfSqMRmuCsbVKaOiQY6GgtdO/XuPTf2smFKDCmkHBDkCrr8nkcJZAM
         Lv9ZaSgloeKmELrsfl76+8prEDs5YHILQ0xwxr91UlNIYe3CJe10+VJC6NMEZUDyEOVa
         82Pq5v6lQd1jR6XHteaI/KxQ9dZqfZahtSFy+xU9kJ6yUPI8gelv9volxlLY8stALOTx
         +t1p21SqCH8URtYb6IOq5Ru669L3JpTekhcm8AkzDqNd7cVdlFwq2s6z5gTmQiL6I0S8
         Sh3YJJb0/zG7gEB3UnC3dzycfpKNSSVw9rI6Fj+0M+fxBAJNdRoa6ZSnbc5pJOM8t+R0
         QpSg==
X-Forwarded-Encrypted: i=1; AJvYcCUaBYdzsZnfV1XJswqS3p+KbF2tsLSOFainBwJ8e1WiAAEyWDsYJcxexdp6rQ+kNQkcpXBYpjIf2I0xWHP88tBKEMrxiI1DG24jsFvH
X-Gm-Message-State: AOJu0Yy5IN6OGEhAbP5YPBQuvb6hGnmtJv8GVUdpOLEc4uiob8RbGmkQ
	lNgIs1C4sWcUneg9U1xX0fFe7Sc4bE20xhx5lSozNyE4pEE4pb0oGt51kSBj7hk=
X-Google-Smtp-Source: AGHT+IFSP0vgMmSJK2RcLkt/TA0YFOfGHvh6uKZayMl6ahMenA7pBLqxxgSD3eZ9uJuin/YYmNhLaw==
X-Received: by 2002:a19:8c1d:0:b0:513:200e:cced with SMTP id o29-20020a198c1d000000b00513200eccedmr3037840lfd.27.1710202439987;
        Mon, 11 Mar 2024 17:13:59 -0700 (PDT)
Received: from [172.30.205.61] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id t22-20020a195f16000000b00513a7962930sm807970lfb.89.2024.03.11.17.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 17:13:59 -0700 (PDT)
Message-ID: <5ddecfb7-fcd2-4df2-95d9-882939a1637b@linaro.org>
Date: Tue, 12 Mar 2024 01:13:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm64: dts: qcom: qcm6490-idp: enable PMIC Volume and
 Power buttons
To: quic_huliu@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240311-gpio-keys-v5-1-08823582f6c9@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240311-gpio-keys-v5-1-08823582f6c9@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/24 11:09, Hui Liu via B4 Relay wrote:
> From: Hui Liu <quic_huliu@quicinc.com>
> 
> The Volume Down & Power buttons are controlled by the PMIC via
> the PON hardware, and the Volume Up is connected to a PMIC gpio.
> 
> Enable the necessary hardware and setup the GPIO state for the
> Volume Up gpio key.
> 
> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

