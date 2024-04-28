Return-Path: <linux-kernel+bounces-161530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE4A8B4D3F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15DA1B20E66
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F00773510;
	Sun, 28 Apr 2024 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTr00tsG"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC667317F
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714325540; cv=none; b=s2hiqnSthUzssaTgs24BDXSRb863Y+jlFXGztnoios/1HuK76UuOPhcueJhAglNV+mrNeFUN1fTbRrQuCVDLqngYd2RFZ2P9n3HjO6dcZvJuXDHva39nKZhg296AC2Sxq5uGgcHHdy5ct700doEPdwh/Mfg0q1fO//CQ7K6rZ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714325540; c=relaxed/simple;
	bh=RvT5KD+W0rlQ33towC84Y7SN8xNBBTRJcOrHEgq712s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SF0xUNad1yZPPD5RrcNFK4/JtSP/1NKR+T97ibeoC6nta9cdSQEdtazSOQ11dlcyOxIO/3PehaIS9ZLpfdT/YR1trIJcja7v1/NNg+vLUNojUYX8ViWsUi2rtdMFTX/P3KX6nRdvOy1OqHa48rZLjq1GQl5XmIUUSrVOXfUiBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTr00tsG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41c011bb920so3312665e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714325538; x=1714930338; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1rY2PGAHZi3Huhj/LRFqVdoVolC+65tUPmpsUKBQy4=;
        b=YTr00tsGyxGaDKJvYlO+3p4Jrl0D/x9e5zOeHDoiQKMLIseTrPHE6KVjZ5dY8hyGKc
         khTjznZGSBje77da7yvP8BIx6QTj5MnDL6da4NIr5cnf8dEhxAPSpUCI72pLkhr/DKjK
         PnWmkjWbh1ctnJaP9HhfjRMf93Ng0PDCbKFkBsKPbIyyt4Ykm9kupLcNMnCwLycoeoX/
         WUHbXp2lpjoh8XQ2CovaW5H+zWvcSCTSwDmynAhHeXeWBA1ySrbb9y+9S5ClCRJQUh6W
         KfDnWjjSzQA3m3vNLY9SL6GGcurOcaDaEpSh6J/O1N8rXwPdVdS9ZnISFD4KSXjQjWFt
         wyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714325538; x=1714930338;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1rY2PGAHZi3Huhj/LRFqVdoVolC+65tUPmpsUKBQy4=;
        b=j9TqmHSPTS47Oic8+9eDBv7Ss1iMO1FH6/5poOaPNbqwiYtcxgO5xNTrL3EmDn8NSx
         2vWzZj5vXKU0JqcpEn2dWNRGWV2PYA1Nc5TFZfksYkw1eNGq+CpsYHlEs83wTqHOoA/v
         STalweNjpo7+Z8ZESPzPq3umItdXpC4ki0Vw9BrexNVZrfWk/B4p7+sKNgXPEUK4g3bg
         iTHvnrsEwfYeMei+4xrbq2FOY90XKawEFsOW79TmmqiY8x00zveR5v7azHiC+hf4X4Ci
         G5DBQf/X1OULPRTfJ9Wt2zf901wvRTueix8ZCq2FPCCyeTvJUSXQvZnJuE1DdhonViNR
         IAug==
X-Forwarded-Encrypted: i=1; AJvYcCWN0BOu4bPUkh3VozB3kv7YELBdTSxPK5tsV+u/l47ZP81aTNtxbrTf6qGbTMTypQkdWZe7jpEISFAkHgj8vMvtO6aRNOh+IuzsBdvv
X-Gm-Message-State: AOJu0YzCxHWgJCTGaEW/R3/J4dGOZMIXLJzQnZQ/0GXhj+ICXS4JBUOn
	G4AxhQE4Iacqgbym7AKXYqBo/XeEI/jLWJWI4Tj631FC15GATro=
X-Google-Smtp-Source: AGHT+IHbgPRjHDu79U91t1WWRqAp7Sev8rriRxNGCI46JIL6EuKvvhs+C5gN3CcF7ZXORuq585A68A==
X-Received: by 2002:a05:600c:4506:b0:41c:66:18c2 with SMTP id t6-20020a05600c450600b0041c006618c2mr2300839wmo.4.1714325537635;
        Sun, 28 Apr 2024 10:32:17 -0700 (PDT)
Received: from octinomon.home (182.179.147.147.dyn.plus.net. [147.147.179.182])
        by smtp.gmail.com with ESMTPSA id n26-20020a05600c3b9a00b0041bf87e702asm4497992wms.10.2024.04.28.10.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 10:32:17 -0700 (PDT)
Date: Sun, 28 Apr 2024 18:32:15 +0100
From: Jules Irenge <jbi.octave@gmail.com>
To: mingo@redhat.com
Cc: tglx@linutronix.de, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
	peterz@infradead.org, rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] x86/tsc: Use div64_ul instead of do_div()
Message-ID: <Zi6IHzCyyaY2IZNx@octinomon.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

do_div() truncates a u64 divisor to 32 bit.
This can lead to non-zero being truncated to zero for division.

Fix coccinelle warning
WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 2da37f33dd17..2ed154a2642c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -823,7 +823,7 @@ static unsigned long pit_hpet_ptimer_calibrate_cpu(void)
 
 		/* Check the reference deviation */
 		delta = ((u64) tsc_pit_min) * 100;
-		do_div(delta, tsc_ref_min);
+		div64_ul(delta, tsc_ref_min);
 
 		/*
 		 * If both calibration results are inside a 10% window
-- 
2.43.2


