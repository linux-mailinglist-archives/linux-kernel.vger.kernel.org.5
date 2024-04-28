Return-Path: <linux-kernel+bounces-161499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156668B4CCD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60DB281747
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F9E71B3D;
	Sun, 28 Apr 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1n5JNUo"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF4D138C;
	Sun, 28 Apr 2024 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714322432; cv=none; b=UTQFe/gDqu1Ko2welNiLp9fvyPREC01Iih8lUdSUr3PE6DKm4pRPWe+yOXBRjw/be3WmSd/bH2Aob3ojIwHNkrblxAQimb54IGUBePtzxvhplbx6wYHRs4/AY6hJa6erO6+f9T6TUiUTYngCIOGZbpYCPuoM3FGLcUK3tINAoAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714322432; c=relaxed/simple;
	bh=eWyNQEQgmbKTog4PZQGoo+/kvgutwCEHij/3lF15QW0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FNBstz7XPc/UYjCqirhTVXNn4W/TnDx7JV8yJaQ5ZMZUFoMUQlLxRaHqqVlv7uPLJHcUCrS/Rv6AZ/QOGfUPA20o/wkoZ30WuPjzIALiwD1K7CXaNQLsbNbnGN7Dt55vJUz40CWQxVXXJS6laHzHTGTmAn0E4J8NSRRjW1eQY90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1n5JNUo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41b782405bbso18538285e9.1;
        Sun, 28 Apr 2024 09:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714322429; x=1714927229; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9vyGMkh9OeP8CcYsJVV9fAYIaFmcX5CM85mePm5ypHY=;
        b=l1n5JNUovFEpaj2xjbw+dh7BH2bbyKfv/KNf7eXMm5CdqL/PMA4YaufLK7eMNpQlte
         3IMEsvEUXIqn8GX4nZ071UHk7ctKZ6CzmKlWbUZItcdFgtIPsghBmSqCtzIzzAknA0l2
         ScpBjmH1l8qyCXF91xa4gKvCcVUwEIZKcR387NlZk3cFOS4FEceSBI/y2FSiZ/Hp8Zr5
         yBwwQsvgTV22VlfdJYLt4WPk5GLZ+7JP08Bh4o5284tX6/jvIBrOukE98TOBo8P5rp1r
         dBGc+OlqMtGxKMqgjOap23TsbTKmO9X37nHR0F6L+rtvoKSAx1Ny51hTHj2vp3MiE5Ub
         V/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714322429; x=1714927229;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vyGMkh9OeP8CcYsJVV9fAYIaFmcX5CM85mePm5ypHY=;
        b=cFdwA8CIcjEOODjSlZXgUqhmby3mRxiTOZ8xf4A+xvNw4penk3R4HKIcNRLlm//rgp
         y2qvTBy+t1B5m71oVPMAxZRCe0Qw3wSO9qZDmna2UPcf6MKDEpLzx2dsNlrnX4ALR9W3
         Z6jQlv/H0e7g/v4TcXFntZIP8HY9MFoQQWjV2w+JH7j403/I09iPIznO56ZGaD4ASO65
         UeSTV+ACtXfaWQ6MJvGqgUQDT6CpqZClaOTAG4zmL5gRANp8Z9rHdtz9JjfMXfMWWhEm
         C1R26o1b+toVQKo4aNbpVAt0xyjdtNA7xij4DLjqAkQz1c+s3fK8aORAPPGSbVZn+dDS
         piyg==
X-Forwarded-Encrypted: i=1; AJvYcCVrWnA2c+FUEly0fVdwIA4S2Y7tqjlilD63/DnsF8YyOirjvt1aCH+TN39KBBLEj3d6TDnFOEG/2A1f4zfTAqhc4V8e3UxeUmVflo5Sewhz0GQ1kggF0fGC8lw/V7U6Cv+u/YkjOV9BPoB0SEbSLA==
X-Gm-Message-State: AOJu0YyI9MFkFOKGwYGTFvlLK1+hVjidlgi8v4ya16EKKREDs3joQl0B
	wSKl40x6Pl6j304QMbJMf6ikiXW8WnGOAr/uQ0zvUCy9arskqO0=
X-Google-Smtp-Source: AGHT+IELEnN4RuPB49/k0moK6uLDWfhKfFObOUQ9TI7Smjxdi5ZIe9JaWQPy/Wi/IvJCB9lHs/0QFQ==
X-Received: by 2002:a05:600c:358e:b0:418:d91b:f1a3 with SMTP id p14-20020a05600c358e00b00418d91bf1a3mr6203963wmq.38.1714322429275;
        Sun, 28 Apr 2024 09:40:29 -0700 (PDT)
Received: from octinomon.home (182.179.147.147.dyn.plus.net. [147.147.179.182])
        by smtp.gmail.com with ESMTPSA id iv14-20020a05600c548e00b0041c14e42e2bsm2819474wmb.44.2024.04.28.09.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 09:40:29 -0700 (PDT)
Date: Sun, 28 Apr 2024 17:40:25 +0100
From: Jules Irenge <jbi.octave@gmail.com>
To: mark.rutland@arm.com
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/amd/power: Use div64_u64 onstead of do_div()
Message-ID: <Zi57-TMgU19puaQM@octinomon.home>
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
WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 arch/x86/events/amd/power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index 37d5b380516e..ff003c1a645b 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -64,7 +64,7 @@ static void event_update(struct perf_event *event)
 	delta *= cpu_pwr_sample_ratio * 1000;
 	tdelta = new_ptsc - prev_ptsc;
 
-	do_div(delta, tdelta);
+	div64_u64(delta, tdelta);
 	local64_add(delta, &event->count);
 }
 
-- 
2.43.2


