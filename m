Return-Path: <linux-kernel+bounces-61401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95AD8511E7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25471B2524A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CA738DF7;
	Mon, 12 Feb 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLAS7pHH"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48F2BAE7
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736231; cv=none; b=DEUZBS97s9OGU04ryDKHgd3Z5mPNUqx5WGayIRvO09QlZqEoCIMQoGO8/pfOOON8CmJNOl0x1VVPP2P3LYqjbZKEU45+o5xWVVaEE82PmJ8hzKWLPVP8UB2dTpbcee9X8YpxfIlB6mDh4TTUM/8PTDifc0eURpLN8+EiCTMKxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736231; c=relaxed/simple;
	bh=56X0pseBQ6WVIu10r0CRACR7xBuAvbGd9xsxlu7zq8Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SRmn7EdQDVz6XkoDgAdiu2x802VQ0rRXgVJ36fTQuXlNmSRD6xJmuObjQJRoR4BpRFFzmf31wF5lK9jaDrAvlSBSluqsab/2J1DRVeQ2Iy++6q8xrpje4txkn8Vy5zJla1qBM5lA92Xg7uAkYQnT+dgE+hd5UVcRO6eH69sFH/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QLAS7pHH; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51182f8590bso1838784e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707736227; x=1708341027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PJUMoQkcVAa90I58l3DTM/q4GMcwM3UZhA1RVbNTEOQ=;
        b=QLAS7pHHzGPiJUahWN2R/+SeWtZ097Eq1RZ4Vhy1yEvK2K0zfffDbvJTZjj8xHzjXH
         rjy0ghkdntb+8+VuoP2PTZD+G9dgY1tOVbMaYOv4JyxUbmwdQzer7phRVDCX2iNA+Xtn
         aNDP9et9v90DZBRixmHS13mbaIe9arkb/nfWGITb+/bwUz5171ZPuIt/Y35oomIT80c+
         UUW+RQmaWOmQSERyL9s8MFFCdwFXKeOhQ5qSYPcAmJ/bzNbzU75N5c821Tw1q7hgvAdX
         r5ISWoLlV2vRd2CUe00YjIt9ixJARVqsgWTiBXteLR4r8BdI0manhBMvTtDtGLmHQSOk
         c6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707736227; x=1708341027;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJUMoQkcVAa90I58l3DTM/q4GMcwM3UZhA1RVbNTEOQ=;
        b=GkXtzYTtv9sZWYMqsY8TShymtDR4+ZHzhA0PfZYc0ul95c9U7X5UIyQxyFHpT/f99d
         g1x+W8DaQ8OlWvCi7RdkP2QMhnn1YUyXK9GfvyFhJ5e2Vmr2HH0lRcnNmhVf/UtzJXE1
         sZKOshckmIPrIxOLjiOKkYwsEGWMClKxnV2iFBt5yVYwAOyGAip2tKeSryzLIVueREtJ
         SmIh6L07o556rarNaLWpL76H2Fr5q+bzZmwrPjhIQn2yeyCbWOGjN+LQyaLaUUM21H76
         7GnBtJzId2+SNNCM9SGZPpqhgvZji7qEUgxI9wOtyQqdinotCKzjshKnme5lmJfgwqw8
         PKvQ==
X-Gm-Message-State: AOJu0YxoqPdEcq0mC6nvSMv6YrOanBZBkR9mzS0xwjWL8BwlgUHK7zGA
	Nl5jrhww/T3NVqHvpVHxXyPNHUUoxB1mZgmPR8CkBRcIX1SI2jMgevblL/kR50A=
X-Google-Smtp-Source: AGHT+IE8vAlvQn1bG1sV7ss/mRxlHNknxgQrle/b0f0yFD2xQgKGsAhyN8vXKAaPbChCJSwSG9vwKQ==
X-Received: by 2002:ac2:5f5c:0:b0:511:6952:70c0 with SMTP id 28-20020ac25f5c000000b00511695270c0mr3190186lfz.5.1707736227411;
        Mon, 12 Feb 2024 03:10:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVNoDeEVHe7SijgMjpeXARSjACBKjhUjq4Djfgb7vWa0AIYt7rCqKFVX4KdVMQmmXgpq+QggRJWPI/8ZdMw1mC3Ki5ftGR4fvTt5BIMlFycoSCY/l1wYzSUmFZyPzW5tLhmjXlDpuPHm/Ouvn2RhA9F76LJdYK86sKxm3cSWXoxLEupBx1WN+z1rSBE2fuOTYXajmhvmwE5pNt3NfZ3e70hTGxnPlb20sckAwg+7D6bp0h1udi/v7OZZsLA2KAxSEQEg6UQQD1gVBc+XybzdsZ8cJ0z+leaAFI5vZZR2o3fRr0DMqeMu734KSmxh8yVDqYeeJn/9Qs5N13A/3YuB5lsE7/MLkXywD5/0chmkB2isZsHmCwVQ3K4dYIAfT/iSGJH08ItD4w6C499oS1dIyaOiQ6o/subIKAN9Eg3LO2TggqgpxWP+vG3RO2Si9H4HTjb1ZLMumJR1YPAUvTqj0589KkZZo0
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id s8-20020adfecc8000000b0033b671f079dsm6444636wro.115.2024.02.12.03.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:10:27 -0800 (PST)
Message-ID: <690e64d6-8888-4f99-9ee0-c731aeea7762@linaro.org>
Date: Mon, 12 Feb 2024 12:10:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8650: Add dma-coherent property
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ling Xu <quic_lxu5@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: quic_kuiw@quicinc.com, quic_ekangupt@quicinc.com, kernel@quicinc.com,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20240125102413.3016-1-quic_lxu5@quicinc.com>
 <20240125102413.3016-3-quic_lxu5@quicinc.com>
 <069b82ac-b59c-4665-8a77-6c11a2463faa@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <069b82ac-b59c-4665-8a77-6c11a2463faa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 12:00, Krzysztof Kozlowski wrote:
> On 25/01/2024 11:24, Ling Xu wrote:
>> Add dma-coherent property to fastRPC context bank nodes to pass dma
>> sequence test in fastrpc sanity test, ensure that data integrity is
>> maintained during DMA operations.
>>
>> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 13 +++++++++++++
> 
> This wasn't ever tested:
> 
> sm8650-qrd.dtb: remoteproc@32300000: glink-edge:fastrpc:compute-cb@1:
> 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Ling,
> How is this testing-patches-before-sending work in different teams? Do
> you have such requirement?

No clue if the original DTS change should be reverted or these are in
fact DMA coherent, but let's choose one path...

https://lore.kernel.org/linux-devicetree/254c1d14-25e3-4f4c-9e79-4ef7cec4d22f@linaro.org/T/#t

Best regards,
Krzysztof


