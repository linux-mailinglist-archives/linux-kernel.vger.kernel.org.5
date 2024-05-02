Return-Path: <linux-kernel+bounces-166024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D598B94E6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD601F22E34
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2092225DD;
	Thu,  2 May 2024 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="piLTaoHC"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F02032D
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632706; cv=none; b=RqP96Nq5Kr7SEGCrQ1tqehYIcjV+Mw1EH2Jktk4E2wRwn1brIOckkf/3S0OFEQ3HIvGUagoBF27A7Xv1QJ86UeIa/8LgHMfxkpl6LhJAPru/DMgUSfZYmu8B1eGaTYzYvaegMGJe8rSHEiBRu/MaX98b+sGT4xbsp5RCNc3H6u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632706; c=relaxed/simple;
	bh=AzGGXMNisgtOgDKqW2TST5EGH/yE9Qp4z4if1pjzE3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQArg+dZ14RKIB/HRf0Z6pdcyPi9yO1AwztktPOaYuLv8kQS6kvKsy8opR0YxZE+Oi+5JgSGhWdwr4pObHP4G5nHq8EaWCwrpgF07zvP7jyrEJM1a2RtvRFD/3EnLgpB43L8EZEnDNNre7YzKhY5Zm6/hXroSrx8fFv/combfmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=piLTaoHC; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so9244988a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 23:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714632703; x=1715237503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AzGGXMNisgtOgDKqW2TST5EGH/yE9Qp4z4if1pjzE3A=;
        b=piLTaoHCddCTbweKGPSOrGUGN19/aMGd4HEoB7xrHyCqtXkHqQlparP86cw37xNR3j
         +7ppqJldaeFiDrdQ3O21spS6Qt0Fvsgh3R0IQ2A0nwcZWeeMpVYmi3zJ/yi0n9rF9v78
         sPsR1RFx+6s0icnCUjiG90R4I9bYZQ5VuwndudqMj8c99uWzhkXpAaDhRNYKWGl+tVoC
         Kqz/iW84t32h39tn2QPpsw3+R2ZTVcSk5CT91DTKUOX5dEE9MOC7DcTk2jXC+lPfNEDt
         zTq7ozajc9P/lvS6cBMGwspTxG4D/4peMoE4fovCCIRA4jXW1qcvyhGtT6lrYuLDHHqk
         voOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714632703; x=1715237503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AzGGXMNisgtOgDKqW2TST5EGH/yE9Qp4z4if1pjzE3A=;
        b=SeEO6sflD8L3VbA0r4CRq2rnpJ5ccajh64qwGbn7rE6gHSi2KpSKpkt0nIbw4rYdXb
         YW5JUzRX1jh/Ap84JpqHOKBgCbF55QrFHQ/5Eizo0hdi8/1/sYHflrq7uYuIYC8bzpOg
         1Phgl6S3uG6T8HIoOAK8t97m2GgZqlcyD6N5WGNdu0ppoIsoR3tXCrbyMb+4cjsrdnti
         N/jIyM/cmFtv4wBny55W/7OQBklldx5bUOmNBN5FN3gH6v/C5e7PAGCpizgv5vFVONKc
         QXkquhgdc45xZIfFstJJC8sB5TEv8AZ8ZlbFb87QrfqP8M1kJ/W1CT3YUPkT8T90Hn2r
         HWTg==
X-Forwarded-Encrypted: i=1; AJvYcCWmet2nGfH+rYeF1bq+hrl096YCCYyZ0XjxuCqguy2U5k35SZKmI4wSRBtA1r3koCrj9tk+MzBwjzk2nNBY7CXxrDKHOmPOMMkwgH/p
X-Gm-Message-State: AOJu0YyYAxP20JAMsLKbRkkGy+K0FeeE9QK6+eRfQjRe745xv9Tc70Ub
	hKP1y801Wx5+aJAgXszcMNUKzvLH3FIApQiGur/LzDZIpcVPCaGDTaMSOGqpQFk=
X-Google-Smtp-Source: AGHT+IGD8e3r3noDyYD2YIvp2atQuDcHh14YWuoYf1EutnrQXpRjic8pwNHE8h4pntM0COs1kCdDDA==
X-Received: by 2002:a17:907:9722:b0:a59:70d2:91b7 with SMTP id jg34-20020a170907972200b00a5970d291b7mr285927ejc.13.1714632702898;
        Wed, 01 May 2024 23:51:42 -0700 (PDT)
Received: from [172.20.10.10] ([213.233.85.172])
        by smtp.gmail.com with ESMTPSA id t23-20020a1709064f1700b00a5544063372sm181102eju.162.2024.05.01.23.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 23:51:42 -0700 (PDT)
Message-ID: <498ff366-b247-4586-b02e-5cbfba5927ac@linaro.org>
Date: Thu, 2 May 2024 07:51:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: exynos: gs101: specify empty clocks
 for remaining pinctrl
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240430-samsung-pinctrl-busclock-dts-v2-0-14fc988139dd@linaro.org>
 <20240430-samsung-pinctrl-busclock-dts-v2-4-14fc988139dd@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240430-samsung-pinctrl-busclock-dts-v2-4-14fc988139dd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


All 4 patches could have been squashed in a single patch as they do the
same thing, but I'm fine either way:

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

