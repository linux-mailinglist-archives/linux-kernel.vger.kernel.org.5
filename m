Return-Path: <linux-kernel+bounces-3203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A8E81691B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445D21C22587
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1E211188;
	Mon, 18 Dec 2023 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZagKMmn9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C0911C9B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a1ca24776c3so721396866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 01:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702890172; x=1703494972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oj5BsM/xGdC3KN8KGTSJH/xUgeBwNL/Afk9gki+yN4=;
        b=ZagKMmn965hsrkwxh82v6nHzBduiyW5gLhVj4fqJiFzkFDlKcAs6cqf34oepW9E2tv
         PeD7ogoqbczjEbTTtf4FRaa0QhQtBkPZetSqjJ79JI7pVApHp/rXDEjHNT9baUbzoESH
         YyFofvfrGnhPuspyocT19lOosLE4t7vk5BCYJyQfoO3AGbj4XXEi+667SDWaS3Yrr1eG
         9X1LJ3MKQrGwpXpjKf6UE2aUtB+ivzZKVg50tpzR1fRIUidXWgKKDsXbbyRcFpjQAIVy
         1Dm1gP5QrnauFC3tYMhf83wxLmRBfmHkp2PMajiu4IkVr0Hq8YPL9Kspgc4zk92tIyUR
         slLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702890172; x=1703494972;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oj5BsM/xGdC3KN8KGTSJH/xUgeBwNL/Afk9gki+yN4=;
        b=Ln2SD6eS8sk33aeuuUqCxSunkPLSHq0cKET4yIgmu4v6XO5f8lvBvxYaMELU6hyooO
         VUrMcDvp1b3znZ38iqyiGHT48iCgJXYhtvPI3vcNZWz8QiFeGr1xnhZdrptrOYlMmzE3
         6E0N6MuyDPX4tSUW4iOWYrF5xW0KudFQEvHFhy/noWk6G0s414ks7AUPBHcw2ZFeIsi2
         De0T9tvEOVr8BLc8Xnc8ApXuzyT6SIv1HN7OzmRtx3j1Cx2up3lFbos+RbuhKVfiakmM
         CeAGe+LlddMuHrmfHlOhFFRF9ce+hN+saSup8ubeIdNPSnmYBG1WQGeaGb2q6viRt+jQ
         WZFw==
X-Gm-Message-State: AOJu0YxRV8rSvWS7ZZVZpcz5vkvm9FTfd15V5FrHt4RGB2CWt07WTL/V
	c7AHlWg1kpiUhRcX9ZxHvqOVDQ==
X-Google-Smtp-Source: AGHT+IHS0mtHIvUG2u9ha9s798b2XIZD4KdzteJIQM8j9zcnguqcNxT/VI6ojy355UDA/EKpSNJeeQ==
X-Received: by 2002:a17:907:6d0f:b0:a23:4cab:a076 with SMTP id sa15-20020a1709076d0f00b00a234caba076mr1970270ejc.33.1702890172710;
        Mon, 18 Dec 2023 01:02:52 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id vh6-20020a170907d38600b00a0180de2797sm13884771ejc.74.2023.12.18.01.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 01:02:52 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: peter.griffin@linaro.org, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: s.nawrocki@samsung.com, tomasz.figa@gmail.com, cw00.choi@samsung.com, 
 alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
 robh+dt@kernel.org, conor+dt@kernel.org, semen.protsenko@linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel-team@android.com
In-Reply-To: <20231218064333.479885-1-tudor.ambarus@linaro.org>
References: <20231218064333.479885-1-tudor.ambarus@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: clock: google,gs101: rename CMU_TOP
 gate defines
Message-Id: <170289017091.18651.1346933339464153967.b4-ty@linaro.org>
Date: Mon, 18 Dec 2023 10:02:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Mon, 18 Dec 2023 06:43:33 +0000, Tudor Ambarus wrote:
> The gs101 clock defines from the bindings header are derived from the
> clock register names found in the datasheet under some certain rules.
> 
> The CMU TOP gate clock defines missed to include the required "CMU"
> differentiator which will cause collisions with the gate clock defines
> of other clock units. Rename the TOP gate clock defines to include "CMU".
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: clock: google,gs101: rename CMU_TOP gate defines
      https://git.kernel.org/krzk/linux/c/35f32e39b4d9b436354c2a37623c393a2ac7cf87

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


