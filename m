Return-Path: <linux-kernel+bounces-125708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E32892AE6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D535D1F21B6D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F8D36137;
	Sat, 30 Mar 2024 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HT4JrJGm"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3DE36AEC
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711798939; cv=none; b=f/dwj9gLE8lQnr9qMdGRrCrZ2btS5gxvKdx1p/jH7AkTfHjJRN32Q13/dN/0hfH/JiurhHbyhR/wQQpBN6Z0UdUHCG330RIVZsqKg3Zi8MywPrR9JARh6iPd+PZDBSaICodvtDLwBq5OD5LvJB4C4oM5rr9rmVROLhZGeRtkhpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711798939; c=relaxed/simple;
	bh=phvGZ09GCCEeBwb0R2IVJ0+92/CIeeuWJyklwGXtw+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRcltkTUlunVDxoV0tK7nhYA83G4ClWKCxVlyGwgx+SZOQw4yVnog7snDtsdYd0DyhaIiGErlunfyam10G0g9wt5BSYveRQbg6PL67aozcXCNupvusvk4m8PHxlSo60qLh3CkwOa+Ywz4oCc8didtBxpZS69wCJN7SJFyiB5WLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HT4JrJGm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41553f150b9so8254405e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 04:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711798936; x=1712403736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wMESD1A5qcJKQru//VVRS6eiwJM8A7WAsmOSDt4Z5PM=;
        b=HT4JrJGmAStS3Aw7mArwhI4+zL3AmaBb9nWNi0/hvYbEVsoRb0orFEeM7nsyIgnYVc
         P+s34dlq6F1BmL9fBzAbVKjUjq9ZvpsUICGgATFtrNzLKK8YI1ODcf5sp43WlJwAUWr1
         Oty3MCdJKkcbJwc2i6TwQTckKQQO6g2+AvH8DgdHMoaUlZMaN0Ydc5YnwW9Hlpi+eeQp
         QavSpCZrVnzyp4k4eAi6pOQPq1jXTtbjIIzIYNSWJYdPjj/kSE3z4gvC69NzzFTsYgnw
         aDIXlkw0cgxcjf9fY1P7YUqysf0LcPRgtLKOn1R0rkwlw48gkvmMuyvqsA3qbef1IsbW
         qFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711798936; x=1712403736;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMESD1A5qcJKQru//VVRS6eiwJM8A7WAsmOSDt4Z5PM=;
        b=A4oC94AiGO5TFizaqFIJ/qahD541V081/v5BTj/FBRIt/tullbehWSALA/PB0ch+I1
         +hQ1pV6ZMMqvTwcA2W5Wyc9P6e7OvdXt5TyzebXBKBkxcFm0Kn97Wtsmn8TpxxCx+PN9
         GPaJPmp53dgF54VuQJ3hKzw9r18fNLtMnSIawfxIXZnbOu6evihC7iUOiGHrL3IWCAcx
         /8JZzJWFMP42fz7fxKsbL8ThXi0YeKZHGUdHBcrOOmtajbbpHdEuqWjhXjVY8NCBLM8f
         3VaCek/6LF7hitowrgskJzXE0kNgXbNJqC/gZXk7RjaLmmJ9VRTsCmCMDukZsy7XgRNf
         sb7w==
X-Forwarded-Encrypted: i=1; AJvYcCW4RLiQHC7ogZ5hnuwLDnLJajYM02JxkVqxwRyg/zZGDEaa9muFHVFl66HabmEFKQsR0mwT29d4W9k4pBhiQaH3DgOy0V0C8G17k485
X-Gm-Message-State: AOJu0Ywb3BDmSUkovLVcdJJkLCM5nfE9wn+Wt7f9kiSMkXiZrP+AHsom
	GDKVH+xh4dRJHy9fYZO8H35rtvjWWUeW//0MfktM7qyY1ufmQzQ6V7U86J3Wty4=
X-Google-Smtp-Source: AGHT+IFL+wkmVxWISulNpDXstMTMHOiTNijaEFzURCA6rgOYygUuwW6ze3Z6sTAaPKmF3MWTfSf4dg==
X-Received: by 2002:a05:600c:4449:b0:413:f3c4:4d95 with SMTP id v9-20020a05600c444900b00413f3c44d95mr4040548wmn.10.1711798936233;
        Sat, 30 Mar 2024 04:42:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c4f9200b004148c3685ffsm8349161wmq.3.2024.03.30.04.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 04:42:15 -0700 (PDT)
Message-ID: <4a7b6d14-1857-47de-bb30-31aee8a00164@linaro.org>
Date: Sat, 30 Mar 2024 12:42:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] LLCC: Support for Broadcast_AND region
To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240329-llcc-broadcast-and-v4-0-107c76fd8ceb@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240329-llcc-broadcast-and-v4-0-107c76fd8ceb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/03/2024 22:53, Unnathi Chalicheemala wrote:
> This series adds:
> 1. Device tree register mapping for Broadcast_AND region in SM8450,
> SM8550, SM8650.
> 2. LLCC driver updates to reflect addition of Broadcast_AND regmap.
> 
> To support CSR programming, a broadcast interface is used to program all
> channels in a single command. Until SM8450 there was only one broadcast
> region (Broadcast_OR) used to broadcast write and check for status bit
> 0. From SM8450 onwards another broadcast region (Broadcast_AND) has been
> added which checks for status bit 1.
> 
> This series updates the device trees from SM8450 onwards to have a
> mapping to this Broadcast_AND region. It also updates the llcc_drv_data
> structure with a regmap for Broadcast_AND region and corrects the
> broadcast region used to check for status bit 1.

Your way of sending patches makes it difficult for us to review them.

b4 diff -C '<20240329-llcc-broadcast-and-v4-0-107c76fd8ceb@quicinc.com>'
Grabbing thread from
lore.kernel.org/all/20240329-llcc-broadcast-and-v4-0-107c76fd8ceb@quicinc.com/t.mbox.gz
Checking for older revisions
  Added from v3: 5 patches
---
Analyzing 39 messages in the thread
Preparing fake-am for v3: dt-bindings: arm: msm: Add llcc Broadcast_AND
register
ERROR: v3 series incomplete; unable to create a fake-am range
---
Could not create fake-am range for lower series v3


Please reach internally within Qualcomm to get some guidance how to
properly set up your work environment.

Best regards,
Krzysztof


