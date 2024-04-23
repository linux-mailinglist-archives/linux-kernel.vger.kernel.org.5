Return-Path: <linux-kernel+bounces-155128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DD28AE59F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0D52826C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CB67E761;
	Tue, 23 Apr 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyQViz9F"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE477E107;
	Tue, 23 Apr 2024 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874159; cv=none; b=g744XnMyuMvJViRviMCiYtvxuFs5pVL610c/uTz+NqE7MFYpsbKHKdvBejUl/y0tJ+OC/Rr+U4b3YytWGlurJErWPhXpalmpS9WuQSiG+CMo5agFuQNo2KLYg5tp7LexyEGwZ+gOwFHKC1/HDUf3SW/g0AD/q2206//OwTVKXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874159; c=relaxed/simple;
	bh=DqAxcZojSFBpoMldO48rTRcAj9CJRVYlNxxwmZ+KCYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2WLxD7r0QPx3u3Pn3ZsG8uSsKBVnry5FY0UWaYoWXgUNf9JsPCXSi70hp/GupjvaaXbkiO7KdQDJEew/Rk8phCsgmOwLoOhH1dc7GgmUateYL+7CGHRqMxeOYbZgt3g/vERf78q40XulJ1Yc30ua6sCH9KL8qoQL/Qzc3+KIZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyQViz9F; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso4370663b3a.1;
        Tue, 23 Apr 2024 05:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713874158; x=1714478958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JD8KzsjwQNW5Mdt9sS+9e+K7nGb99FJ60SB1TmA7vGU=;
        b=iyQViz9FzqGmLR7cX/x+2TaACY4eJAkrYArxJEgJYOeJ67DSQDFzvyfG2mEWT628fV
         UrErwFgujF3ppNJ+x2IoLoST+Wa8KJrWcZJ7L7v/+Ps0vhHa68xpTHgXSi9esDPr7gqz
         j9eGv8CSsMJHx2JUjG64k1LODUJos9SHPsudirC/0TNAEO+c7C0DRnGa8+6ARNS3vQC+
         99vol4YjyHcNsdtFVsl6PcXCU5dcteqBj887aFP2kRRIJUREXXP8RZ0xjCMDXcDlldji
         sx+bvxIp9WQIAfQ+wngSHLgWSt0d4tAjWuV2TxOZEq+q+QdWF8o2mYO57nKWwhHWJdSl
         YQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713874158; x=1714478958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JD8KzsjwQNW5Mdt9sS+9e+K7nGb99FJ60SB1TmA7vGU=;
        b=bzA/G6bb2JGrjYdGlHp+9KeJ5Wf4v5yroEyvT1XXY5I+BL88o7ZClRZ8WcU0ZQtH5o
         PfOIAv0Sv++oQS1nyoTGwO5E7195SIMdV9ohL15RsH8f1l3kydVUlJ12bBRJ9ExlDHQg
         Nfa9htIADTQz82Bmnkux+h8rsRtu6xlIOiddYXSZ4j0ZCP+tseOQ2+MeH4bE0Kf3Yeqw
         jD4xrzmaINoJR5si6zJ/os2Sf1DgAKRK6Aag+CPUOBLuJeuKHPrw0snm8i4vQw3lZmiq
         +AnwnTzH5Uq7qMaasFNZ03yQYFTjxjjXUJDbV2fQQu89tcPYfvS0QDTizJILXmoFnuUx
         OzdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF0RRBCDH/ZMqJjN4TaRuGrwUFRStZN9t6LoSblk74dY+fn6e0hqjzVV81Y1KYxkb7JYIdo05sEvx6L7Dfbu6SAI/OEQvaVaOXG2HrjngKTcEcR4j3e4cvYQc1oeOXJ3F9CJxM2sVR2cxixyDhjDy0WOK+Gb3VelcnoGm1MqB7Y/k//6NH+kyHYjXUikeGS8G2piQ6/JgvnYDEWE5MT0Jp2II=
X-Gm-Message-State: AOJu0YzYjM3z/jVzLeWrAjhm8fRnm13vDHZ+67EVU0i7RCQcO65kFdkJ
	J2aICd8QEJpRVlzK4XDpfpxLgM6dkkVkYvXZ5khS9WpeW3vFxuD6
X-Google-Smtp-Source: AGHT+IE40ykf+mEpl55K6A02/SSlpDeuDZCZGKRaz7HDtT4vnfBrFszi0oyTjRw6NqOoIH4PKxYGYw==
X-Received: by 2002:a05:6a00:14d3:b0:6ea:f05d:d2ec with SMTP id w19-20020a056a0014d300b006eaf05dd2ecmr14857159pfu.2.1713874157996;
        Tue, 23 Apr 2024 05:09:17 -0700 (PDT)
Received: from [10.66.66.2] (ec2-3-111-32-5.ap-south-1.compute.amazonaws.com. [3.111.32.5])
        by smtp.gmail.com with ESMTPSA id 9-20020a630b09000000b005dbed0ffb10sm9292598pgl.83.2024.04.23.05.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 05:09:16 -0700 (PDT)
Message-ID: <7560e32a-7142-4022-90dd-938777fea0d9@gmail.com>
Date: Tue, 23 Apr 2024 17:39:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3] ASoC: dt-bindings: tegra20-ac97: convert to dt schema
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240423115749.15786-1-sheharyaar48@gmail.com>
Content-Language: en-US
From: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
In-Reply-To: <20240423115749.15786-1-sheharyaar48@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

For dtsi changes, I have created another patch : 
https://lore.kernel.org/all/20240423120630.16974-1-sheharyaar48@gmail.com

