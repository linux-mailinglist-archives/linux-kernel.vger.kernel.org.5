Return-Path: <linux-kernel+bounces-40939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B219B83E886
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D3EFB21D2A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED4823D8;
	Sat, 27 Jan 2024 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VRplKrZJ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B11C39E
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706315828; cv=none; b=HMZqtQGD3xqiidQR9JbQCobwlm2HNbjureCTL2AhvR2TZ62542IVGSiUoexPfU+d4a53MuGF1U1Uk0Rf4NPFfl0g5N6jbzvrAwLdIRlDkugkVtoNAlnM6dB9HRZacMoYPMjOqb8/pnTQuUwZ95cATe8pgEOJbhb/N0mqnkvhAls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706315828; c=relaxed/simple;
	bh=7mFQ2Sp6CaIqeHrP9eaRjtzUktjvoRpJ+ySFpau5l0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z9VLCo6yiWJeGGcN8U/iGkshetprwl0oSmgQNzjAyAMpJDfvqL2VWuyI1TcHVdQcaXBe9RVJdsAtQ/pfGoT4CpxH7wyaxi92uOPDFT/VJcaQSgBO1gKNs7LY1/W9n6Zw/l+P8v80JiwkB25/YZ6Ydky21Hpe4AbNrTDGFGQ3A/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VRplKrZJ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a353f5407f1so2836366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706315825; x=1706920625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OEuX2u9xZxa9H/kOkuaGTOBQEZ702dhTtekxS4cUQE8=;
        b=VRplKrZJq0cM0MCL0HIS4UWF86Mblj5yWm6ffubLbM8PM5IZNAg54zpJjENdHr1MRK
         +D0aPKQop+aFzSq1aDbV1lRnCPIlffDawSS6mPwBM3oe+rJrsFSR4thZcfcjgsjTpajU
         VDZU14NxrOxSKMWT/3qzP12SHyZRs/lt6Ye64EPD5kTnYj/4kjRqEbuR+mr32sWJpkdG
         YhdJJyJnP7VyyP6mZj3ocAudSEzJcM3yWzZHsGGl9Wn1KUM/uamsFBO1GRRUDv41RASk
         IQBwdiKDuUpqZDZqLEN3dnMHzLZw9ZC58kxvLcaXtyjxCp+PWjlUPiSdJOyffyoavmow
         yDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706315825; x=1706920625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEuX2u9xZxa9H/kOkuaGTOBQEZ702dhTtekxS4cUQE8=;
        b=NgsEG6wd37tMCGh8vF9CNPvsoWsvHOUGQKdyypXsvMr58xRJf/ddENR8fKMhcZH+BG
         zN5KjteokG1Xa/0e/d48C93mu3XSyecbZcPc944sTppREY/0wFuK4VG2UoBQRi/egCyV
         J0NdchL4Oc12IVU2am7ZJKM2NKcXL1suAyNxVUsuLlAtbbfDSz98+KB1Od0eSJs2hIHX
         0ORiD1+lcNrNvmcGr36Yz9SU+P2tRq+hg9za6mkADQ/hLOZKZdGKLKjVeLnBFsOLC6Bh
         r10jUTCXI1QC/Pwt9SOU6mENEFgG4O0Q5okULIvyjUHm6XoV1mPPcju/T9s5c29XB0R5
         KP2g==
X-Gm-Message-State: AOJu0YwQ6LuD5zZR4wOaZaIZVqmDHISQDCHDcW/0V+ibw4zWKZV2iMw9
	UY8OifHiLqDDi1IEnRVVWsE7ZsuWd4mtwBxV2zmb+P6E3hpdHzd4bFHwcTmjcRU=
X-Google-Smtp-Source: AGHT+IHjfGheZyV2ZBT3VN27rpnKEmCPMQFKGEPt8gQ33V8m4RIxz59dLoYVueBDi2EAIs/NbD3HjA==
X-Received: by 2002:a17:906:c343:b0:a2e:70b4:28b0 with SMTP id ci3-20020a170906c34300b00a2e70b428b0mr358260ejb.3.1706315824712;
        Fri, 26 Jan 2024 16:37:04 -0800 (PST)
Received: from puffmais.c.googlers.com.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id vi1-20020a170907d40100b00a2f48a43c3esm1152235ejc.7.2024.01.26.16.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 16:37:04 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: peter.griffin@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	tudor.ambarus@linaro.org,
	willmcvicker@google.com,
	semen.protsenko@linaro.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: gs101 oriole: peripheral block 0 (peric0) fixes    
Date: Sat, 27 Jan 2024 00:35:49 +0000
Message-ID: <20240127003607.501086-1-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

While working on peric1, I've noticed a few issues in the peric0 area
and these patches are the result. They should all be pretty
self-explanatory.

Cheers,
Andre'

 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 9 +++++----
 drivers/clk/samsung/clk-gs101.c              | 8 +++-----
 2 files changed, 8 insertions(+), 9 deletions(-)


