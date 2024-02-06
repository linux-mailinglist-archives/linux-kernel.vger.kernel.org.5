Return-Path: <linux-kernel+bounces-54427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D013984AF1A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE92281A29
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65295128839;
	Tue,  6 Feb 2024 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zzu5gxRo"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E312882A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205119; cv=none; b=I1XNQnUA//Jr44cOUgR6gan+4qBlqN/RdOMNMGnRF6rXnJULoQny9zFg6/FwtCfKmaxnetm80/7IhYa1ruJK2gi5aTcgNTFn0x/Gt23298KAg00QJtpLAqgXFTbQGFPFADxOwZ/0hOV+9q0Qp3Fkh4V6Ib1LlXDLcQpiP3+Bq3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205119; c=relaxed/simple;
	bh=Efz1Ai0Yhcde9iMs11/ENKsG71OZOemWJ3eBjAqiIn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZQjsDphQaOrKyjVUy/qZNscGACv544nrHiPNjHrk9Vf4gBQmtks/HXqpXn7uLR8UJJKewFK3nxCafwafk90XIaMZVJK1So/ltw8ALIBKaQLd1/x14eZnHXn6KtxDjUHL1vuZlxXWYKAyAcSVcOd4++s8PvI/eXRlUSn/5Ad1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zzu5gxRo; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b18099411so1329028f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 23:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707205116; x=1707809916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6w15fge9TXp5Hcr8qk7hKXgjlXRpBtatQoDLixUJTMM=;
        b=zzu5gxRossMByEyEM4ugD6Vx6ARAclA/jWyA/LWbMkANx61VFihs0/4Hy4mDkdteZX
         F16GjQ1k3ygj8uLqz+8RklxI3GvDwFu7jW3luFF6u57Gat+mY+eEI2B8I/ktr5NRmqxM
         fVaYfDwvUDK6qrIKsTnj7KkY+hahUKWjDo7fI9q3g1WUv6HXcSc8iyDLt8NgPr0rKQx+
         KYLySiFbeo7aql/bdLs8EKiluhJnCvSuC+IvtyP3bmQHIG7Mlt5qXmZXucgWAiV4dkCk
         whLGmtY9RQ89r6V1hi8WskYb++neBQKJT+9RXx9d2LZbHqlTvzZAVa/mRMZPLotjuFf1
         LaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707205116; x=1707809916;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6w15fge9TXp5Hcr8qk7hKXgjlXRpBtatQoDLixUJTMM=;
        b=VPfqp4ceSasBs/vVzVrp+vwTY+trdKCigk9BGo773kCxp5QGmO7Wtv6Q4Wq6VIEASK
         WBNIkpcO1k7q4Umr2GaWKVgUroEIDu8nVDBhoVWCXd4QgmRSBAyIO4yk1HMwZ7/iUNk5
         jLXmFP9voCijgCCUv8e5wRAe1pIuyWigPggoUDpRL4e4EoILUTonwoLzBa4iFA1wMBht
         BSMYl0Xjm+0vbgLPrQOB4uzGfofv0KVexyTnXNCBS535n7Yp6/1XitXT3hfYh7y+RpoJ
         F6GpbpSDIb7rZdb5h1mApLXmQG9bTJyhjzGMtXg4Xrkwtkl7GqGawAY7DBxuBigG8geN
         +tRg==
X-Gm-Message-State: AOJu0YwKHqEkKbEhnRXNZlvbojouhLk3WN1BFOV/rD559L+f7vnMg4kn
	9NGZY4FEOkrUSTCm1UDDWXhTb5jkO2UQHQBC5Gsh6yTUq15ktpvsNWR7YYLBFJs=
X-Google-Smtp-Source: AGHT+IEm2a5u66l1x8uPT0tLZYfF5LSs4ryYitD3OhZxnZe0axcDQkMX451FcMr0gIMQmniotWC09w==
X-Received: by 2002:a5d:558e:0:b0:33a:fe3b:b2ae with SMTP id i14-20020a5d558e000000b0033afe3bb2aemr543985wrv.66.1707205115802;
        Mon, 05 Feb 2024 23:38:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUYk2zmAyRUTGvg2tDlzw3DmjozGkhcA5/RNY0rncp3qzW6D/KA282NtCFv0xb8HVlZCIUYpFVfO9MnF3dSnRNq5uQbxDnK4h9Q5eOm47JqwDaezALO0ueCA/xi2R8SDNU6XBFe4ZYdYY1mq83MVmzcsLf3z97K64BDyYTioiQ4RNL6g7H4GtFVNCrCRtzL8YXy+ohB3tyfqGvA3jOoghC7rISyOxgnEfUD2GastFXXc4IPe7JQRglBlZm2xjo/I0sfc30VqCZKCio/nxa6y7YpqA0x7+BXpF5hs0MMjx4dwWH/u3A22BXPuk42ML6KT+3nyR6t+d+wrNneEDs4CxHOkLmPaSW6Yq0mtws3Ho4cw+j2nnOE5gbCZ6n9m/SCgxQQPWpKfPGe/1GuFp8HZzPIpDTaNezB6JcWsFbEoCSoj3ukjiSy5gBtIw0TE6vU5ubWExbsmLagzfzSRZfNaEnpske0DemKdth7tJNB58hPZ/5kacqKklvHdN+Yv1nk6kEVA7aRHDG785ZWyZysxOdBp2RC7oxV21J2PvoIciUu8k+WSplowaYBPdVzBcPtIA9IWpRbg/ok2JzlG7nuxv+BZvIA7Ksys0XSnjoeJb+MwksHTULmj8Cob9u/Gx53+/mnXM9TGjnStj/FVC94lDPu15RXh8XtvcbTudL4uA3yJNCUe0P7X7HRx/azBWqyjKLki93vHpU2GnWdpLOXjKZ/UXJDubFH/oPfcb9y4+rt0RdfQqe01Fp3v14=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d694f000000b0033b0d2ba3a1sm1343752wrw.63.2024.02.05.23.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 23:38:34 -0800 (PST)
Message-ID: <0c6e1f4e-a548-46df-93f0-0fea9daa9784@linaro.org>
Date: Tue, 6 Feb 2024 08:38:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] dt-bindings: msm: qcom,mdss: Include ommited fam-b
 compatible
Content-Language: en-US
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240121194221.13513-1-a39.skl@gmail.com>
 <20240121194221.13513-4-a39.skl@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240121194221.13513-4-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/01/2024 20:41, Adam Skladowski wrote:
> During conversion 28nm-hpm-fam-b compat got lost, add it.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


