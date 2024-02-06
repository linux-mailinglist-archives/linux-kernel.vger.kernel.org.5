Return-Path: <linux-kernel+bounces-54512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 765F684B023
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6621C247EE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCE012D16B;
	Tue,  6 Feb 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZM6d4TY"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F412D170
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208831; cv=none; b=UvPEVAKazAhQCjSvW7NEuG8zMiLg+vwj5VCQJH9HO3h7iztD7TGlNoA2w70BavwBivLH/A3D36wIe2YbtkcL0zFm81IQG28MpA35lRacEQj0wk4HeWrCfP71AxXY5Rb1jvbH+KpUiLeCDcsLUNCdtzzbojPLtriAr2M/y7bXplI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208831; c=relaxed/simple;
	bh=0+OljlHEvVulzoH2yMalpa0WXEZWeNlJXz6QgyzVqpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ze6iv41i/KeDzcPuM0wUEBM0ewLWIiNq8Vi5KTwD8rQdQTX42xTOCWnz2Z80iw2T8wRECQmihrg7GoWaB7VC1lGd/Eox9bOzeq/OC/WUMKWQ+FWWSrsmLR2gEDcbUOHHkDefqbdeNNBKFylbY4C77G8x+zw+GNbLI6Na54hDaTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aZM6d4TY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fe2d3d5cbso2764015e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 00:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707208828; x=1707813628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+BjCkuHYJ7wlRDiHwrpZK8dT4seUjek4Zt+IyiKbnqk=;
        b=aZM6d4TYA15osmJRIJ3O+pSFkBd+t7S49Sdjo3fDzVX1NMCS+bqE+71vx4XJEI35Gl
         Jdj8Jd3emMQyiUYnJ445BiHVPblp36jXyQlCO2yIZNvZ0fk54J/EQru/QXWPtlHO+ley
         FSN1biproMmDHl4XVN7Scu/QsIZUqzSeuFRfJjO2Xl9CLZoAhW+5Lt82Q0RYN8DSHybO
         g8z9syY6HT+rXKy05Vg7YjtnycxbNgD4yV2xtCUczErjw/8oD/Wd50p3fz8ilUB5vFu2
         blecRpmI4GndaHVWk3j//pISAnSiGn1ht8cGlARetyQaQTb3VdsynyLmBBiWneI7khtW
         5fAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707208828; x=1707813628;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+BjCkuHYJ7wlRDiHwrpZK8dT4seUjek4Zt+IyiKbnqk=;
        b=EaGP/M6/HFJFJy2oO6GloZzUbYWiiRkt2RHrG8izUL62KPinLd2/KxipNZyD/3EoWz
         hFoPfkWlGywucmGNrYV853oFChyQuh4g2aCFXu0ma5nHAUsftVIzcUJzW7DMm0b0ZtH1
         ELYTlJ54J2I5f2SoD1FHHODSePy4tbyFoFt8DQsNnX19Ib6EEJcICrx/iFYv8QJVuDKL
         bsn0qibC7UcXLvPgt44vYkKH10e6gf4iZdeYSLBEY/cI5D6g36jL574p929kfMNYQV9T
         sascNOAZ8v84PVtOfTwSkXI1uAld1XBJ/DvOwEqe+zsesGP6Ka6FL629oZXNJfO6wWQl
         nxIw==
X-Gm-Message-State: AOJu0YwWmlMnK4ZwUcFSPpKllTTnaMh8XBHitpsU24ridv1q8gdjr2mq
	kJc5+m8dgPDhvBHqG43439fy03tBB9r7jirebqsnakhmik9Y5L3vFF3Q68oTVX4=
X-Google-Smtp-Source: AGHT+IG7W+xq1WtAZCy2pd+OKJEdMO65lf45G4Fm2KuM0FtJG1ZEjz4SCZC1hjA8rECCpqxKFH7Eiw==
X-Received: by 2002:a05:600c:1c9a:b0:40e:b447:ae7d with SMTP id k26-20020a05600c1c9a00b0040eb447ae7dmr1449057wms.33.1707208827746;
        Tue, 06 Feb 2024 00:40:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUIqujsHfAafAM73iPvBcIwOjt8p/ysmSU7y6fHLwCfDH3k8fMUjvwJ3wCK/4Njn1XM4BfldvX1kycr3a5uktNDjExozNAWqwkwY14WQr90iyLpO7M5wD/LGCB/yjFn9VqOFVIYBx53HOmWtexIm6/kCrob5iotbBJLFxUhpilDD4hxqvKWjp+KG+it4InIkIdOp4l9Ol1mf4lxGvq+W5lq7TjboAUwZt+qc2AMNxBvfMlWg8VGvTrSJxzwfmiCO7EQOGuvqucnh8l/Ktn1BfASXZtGCqs2hJrDkPgDu0WGfxUW1zJA3j2dlM2JVwlrHzEUP2a5yD4vRw==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c458d00b0040fe5994d0csm819865wmo.0.2024.02.06.00.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 00:40:27 -0800 (PST)
Message-ID: <221f6e6e-0399-4b2e-8fcd-9af40b1b6f03@linaro.org>
Date: Tue, 6 Feb 2024 09:40:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] soc: qcom: llcc: Add regmap for Broadcast_AND
 region
Content-Language: en-US
To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <cover.1707202761.git.quic_uchalich@quicinc.com>
 <169277f53affed98ef41e5a7cbf2401fe62716bd.1707202761.git.quic_uchalich@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <169277f53affed98ef41e5a7cbf2401fe62716bd.1707202761.git.quic_uchalich@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 08:15, Unnathi Chalicheemala wrote:
> Define new regmap structure for Broadcast_AND region and initialize
> regmap for Broadcast_AND region when HW block version
> is greater than 4.1 for backwards compatibility.
> 
> Switch from broadcast_OR to broadcast_AND region for checking
> status bit 1 as Broadcast_OR region checks only for bit 0.
> 

Driver changes cannot be after DTS, because there should be no
dependency between hardware description and drivers. Hardware did not
change, did it? Your patchset might have wrong ordering or might break
bisectability.


Best regards,
Krzysztof


