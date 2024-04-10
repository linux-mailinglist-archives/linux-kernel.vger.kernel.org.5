Return-Path: <linux-kernel+bounces-138195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F58E89EDF5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92205B20E53
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0AA15920C;
	Wed, 10 Apr 2024 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SoozskmI"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D478154BF4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738679; cv=none; b=TaZkydPwCco1m0yGfnwdChnU4lkPQBa1VeWYCS2ORBSfqixdMuZLPBtE6/F7BeizXBo6J2Mu0r9xdQYqIDG8bSAuGPFw4cYr7jDwGg9/yFlNW0rQvlEOhMqPdRTgecBoC057TdAIVoiNePZgaenYx8sqJ1FVxckzpPKZHyCccBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738679; c=relaxed/simple;
	bh=HLM+siIzI9gfsMuMCjbFCwclreaT8/ySNQbMMaZri2I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bJUIrv1e1brADjEGjgXwg3P5YT/ry1TIvobclbLh7buZA6RUcLZ/zijVvQo1sjMjWQqYSxlkILvrW0CzK1NpcXND6tLPzv/8kP9cropCax1K5L1CYt836iE1i14A7Ywexlkua34/he5mLAcuhnDP0mjQourRxwM7gEAWxlp0qZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SoozskmI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d0c004b1so7664910e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712738676; x=1713343476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tL/hejvPD3PbqYhLtjIKj09ojZVksO+lKOONb6rjF+Y=;
        b=SoozskmIwmd0XLG1Yzd0so5rVJekNiA8f+RjH31FwytRx3kAH1deufV/w4iD8VURt8
         RXX3xHc2QYdXDQ1Ff+ajJ2j/v8XlKyblI/IKE76ovcMOsdj+0PzOnIWs79bm5WcemUfv
         uKo5gd1Pxesj8ftB6eTDKxFn8lDP9khlRolh9UK5GtXGaIRvDl7DX6gyKb8N1li/MjKm
         7lRHZqdt+6HkmqfFiNYhFbHOmMFohaR+VoAylsfHYQ0SPkNPtblAKiIlgYqLBrfrZ7Ci
         tjShVNQLuQUHQpDnWFURaW7Wi1rVkLPVdNU4bMMJC3rInfG5kL2ZCpCnrt5WEtOaLM/m
         uqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712738676; x=1713343476;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tL/hejvPD3PbqYhLtjIKj09ojZVksO+lKOONb6rjF+Y=;
        b=YfTLTEdHNcURh2y1c06Ak0gqGJk7g8Llx/pWH0YB9zZrxa1+TJO1UfFUCZRDSpvj3v
         kp0HTI3ier5FfpbPofWlwyAVG6NXkehgBZsrhx6X6ns+i9pCkjcNlaXRmRe11Xdo2eTG
         SQlulTIQ/Nmi42+gXa5W5upNmuQlRjU3ydDSaDAhX+VsGEGeHj6ZYyASgR6JNq6AIVUs
         6Uc1qaqSFZkqUHiYlOAwQ20UMv7vC1Nj5D78pct7Lw3Q9CqSwiXilYWsdrntwherWm9/
         JOXA1SwUFnQX9IWImkv+xvuDkkwuBseG6prle3HdO/uz+6wLAUJyKH+DWdQJTveYkLlY
         5jmw==
X-Forwarded-Encrypted: i=1; AJvYcCVQlea7QJQXex1uf0vp1GY3Jrz4RcxDtSyDHiqgLnyoXcYuMbye0kVHwpxYj5TdmnsqtmJmzmRY0mNNSB6UUPXU0opdhvn79COSnNWT
X-Gm-Message-State: AOJu0YwHExErNEREHlGJ5+V8FDTmwC6YOnphavmDwjZepHUZgVfNQh1t
	VSYOL+DJGMWnGms+AD7vRsydUqtelDxzxb5pY19C0ACymDepOjiwu9Q6ro3JEas=
X-Google-Smtp-Source: AGHT+IF0JtJINjE07BONPobTqgkLaueGpS6HMGL8AwC9YGgwC7b9srjrGwJa1zSxM101ClsmVsldRA==
X-Received: by 2002:a19:751a:0:b0:513:c757:33d9 with SMTP id y26-20020a19751a000000b00513c75733d9mr1507262lfe.53.1712738676249;
        Wed, 10 Apr 2024 01:44:36 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:49de:129e:d25e:c803])
        by smtp.googlemail.com with ESMTPSA id t1-20020a05600c41c100b00416b5e6d75dsm2066078wmh.1.2024.04.10.01.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 01:44:35 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240408-amlogic-v6-9-upstream-fix-clk-module-license-v1-1-366ddc0f3db9@linaro.org>
References: <20240408-amlogic-v6-9-upstream-fix-clk-module-license-v1-1-366ddc0f3db9@linaro.org>
Subject: Re: [PATCH] clk: meson: fix module license to GPL only
Message-Id: <171273867547.2243434.4736877056369076935.b4-ty@baylibre.com>
Date: Wed, 10 Apr 2024 10:44:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Applied to clk-meson (v6.10/drivers), thanks!

[1/1] clk: meson: fix module license to GPL only
      https://github.com/BayLibre/clk-meson/commit/e0892cb47351

Best regards,
--
Jerome


