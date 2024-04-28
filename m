Return-Path: <linux-kernel+bounces-161529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEA28B4D3C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11DF4B20E60
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6DB73506;
	Sun, 28 Apr 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIaP5DaA"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E6C7319C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714325481; cv=none; b=BQR521CKUP4HOdjYeecdmqcvgCHn8POv+rda6te8lD6DOVuQUocZJmWTaxq/RezL+m34ci9oua1jfRNzaIM/bCYBi0+teUyMKicxAchHH2aAh5uz3RS4KkNmrvrfofn8niibwHk2O7xk+IWstkMrPdFpYX5NJhdHyQ+IOS0qT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714325481; c=relaxed/simple;
	bh=aS1hVFDot8tUcexvL9ujXRy4a2hTRJJG9AoytZrjhCo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J27ZBq6t2we1B4DhYiUtrF5NXNMISLcBg2SwWbeK2EgmdtZbtwA5TQc6/HY6Ru395I/mYWR7z9JfQr1FX2dypYaVyl1KcrA/aVzqI0MdKKZAWFP0Y8UNW8isHoUkyQTdBvocD2VC3W3utr4LhSRB8Ta4rh6xcVTvtLyB+2YMiO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIaP5DaA; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34cdb750bb3so281069f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714325479; x=1714930279; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nCXiLm7VS4Eni3fCxaG++r7MP5fvvrXVGrzMU/enG2Q=;
        b=SIaP5DaA+aegeQ+h1j/D5RJLEKuLMnCWtC2kFpmJ5pQg97+c4MM3EKI8rUGFODbyiF
         3xZh55M+3ltKyaesemgB9eGvTlwcxGK1HH3VsOkvGxI/tnMfjSYklaqdoPRqda0wBZY5
         0vbgTzUFZgOu2J173HZdKi+r6Gtl14lAAXXPOT1Yuyny6OKPUBU2/TCkeWFrtS2TbVuS
         qlQp7Hpx6QNyi4FisMVTKiuD4cH68hU+DDk/vKdVufeTmdiFEnxf1UsjBiMrwJgRVwJJ
         OJVdCICoi4Wtzq6LNX9gTOpgBHjZJR2TTel78qWo3mXSprcTVbXF041QGYPPtpYJhFNI
         PL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714325479; x=1714930279;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCXiLm7VS4Eni3fCxaG++r7MP5fvvrXVGrzMU/enG2Q=;
        b=IGfGpkYVfYIsWEiBA5OghkZB2H1YIYD4zneibX9OAur1h1CzJnLxmWQWyR+uno4T14
         ZRAu5i9PikpqbHO/DrNx/a+vFpcoI/YH+oyz1aNXZiNhpkZxTdcOhpeDabO+RQpLfgQO
         YP5l5oAzr4Q2Y06qlVJdTq11gFhij2I6tJjHXcgVsiw77kurfFa5yulKAIvMTW3mWodQ
         BHcd342fgIIOxsRokH1oV77/JqZKrKigyJ9VKL2zybRl0RZxWTw3d8QNmEEE3qGxvclv
         Kt0Y/dG92bo+8VD4h3BGFByk4zeQSSyGC7tP+7joFWTLOz/pN+EuyTT9QIGnEt76/RjD
         1cgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNWUyGahdU8QqP7rX92mQzb/cwB2H+1Q3MX0YLDR6DyIKkRQj4ucbX/YmjGiMv+cCLSGM35BH6HopGe/pqKK5UVhSt1HFp74WoTphZ
X-Gm-Message-State: AOJu0YzuCevESHBsj38oHgrdnwLtb8Zmoa8VDbKuZ7QRPocsHdG8L70x
	0uLfK4Cgctu4Zlzb6esvoP32u8+a7heA/Y5nDfpegun7K9+HmW0=
X-Google-Smtp-Source: AGHT+IEeG+G37i7NVp5ja1AM14qlgFHjmVKbYwRMQbRbBGfFM38L09NBHsClX0q2aMNL35z0lM1Vxw==
X-Received: by 2002:a5d:630d:0:b0:34c:f87b:f9fb with SMTP id i13-20020a5d630d000000b0034cf87bf9fbmr1485757wru.25.1714325478569;
        Sun, 28 Apr 2024 10:31:18 -0700 (PDT)
Received: from octinomon.home (182.179.147.147.dyn.plus.net. [147.147.179.182])
        by smtp.gmail.com with ESMTPSA id d18-20020a05600c34d200b0041b083e16e2sm16631101wmq.2.2024.04.28.10.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 10:31:18 -0700 (PDT)
Date: Sun, 28 Apr 2024 18:31:16 +0100
From: Jules Irenge <jbi.octave@gmail.com>
To: mingo@redhat.com
Cc: tglx@linutronix.de, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
	peterz@infradead.org, rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] x86/tsc: Use div64_ul instead of do_div()
Message-ID: <Zi6H5P_mc6DPR_v3@octinomon.home>
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
index 5a69a49acc96..2da37f33dd17 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -484,7 +484,7 @@ static unsigned long pit_calibrate_tsc(u32 latch, unsigned long ms, int loopmin)
 
 	/* Calculate the PIT value */
 	delta = t2 - t1;
-	do_div(delta, ms);
+	div64_ul(delta, ms);
 	return delta;
 }
 
-- 
2.43.2


