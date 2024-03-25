Return-Path: <linux-kernel+bounces-118093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5EB88B3F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D336D1C3F0AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0737D76023;
	Mon, 25 Mar 2024 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XloSv+Wm"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388386F517
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405478; cv=none; b=cT00rnAg50F9Cy6haK539JmNLDOc9hPUGHux7WlNHVv3x5t20vy0KYHAEblUzivk+N9m+33XqNqsDeAAvci9oIHQqg9nZkGRefj1YepfqDcJ6Fdf9ZB0CLeE0qj1S/8H6eRtt3mJsN+p6TPgxyNeHbEUsD6aVTfqrVyPFPXYG3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405478; c=relaxed/simple;
	bh=wJVK5tXpnbNJy8aZViPglYEaaZ4qoW+WUNxbWWBdJfw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=a9oQa4jo5CvWs+jOphhang9w7eXmhRzmkyRyhOPofnp6fjn1mbtD+KMLXrkxi8CXIZ1GOqWtSkwHvK2sbUy6Rzq7x+cGSLuN2Bmu/3fjgjDAhsEXqgDZVvkk4qw0Bhv6XsA6DyuSbZwACPZX4BBUf4JP/PbfgVeI/fiWyi1pbwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XloSv+Wm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4148e07651aso668975e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711405474; x=1712010274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dXgqwpxj+KRr4XwZTo05/pEPqIQTgbSxC+kzqX6yUf0=;
        b=XloSv+WmxT1eiPpVkrr5yKUEJyhQ+QyfN6dC8L+H2T3Oyv8BaJsl723gH/2I502puV
         +Lmb89sLZq5f5xsJ1bJlK/xGZBr0kw+wKkmP9JpZgdbs2SuubPIpmfrNfA/oCMeb49Nu
         75GknAbm8Vbh/UCKl6TsVTNjCTSkNC/XrGASYrKb4/hbh4LYMxLET9m/NP0xCB1i+iwB
         HdIVI7Tq4o6PsvFXGQutmKe5F/xzxqsGOkvukRIV/NY78QHtESVG/aSeoEFeDneqggoo
         ASLtIM9HppCcVqU77ayfUD7+bo1hs4XUJY7ME3mqOJKnRPdGngAWaiUsj5IDxNo8Q1JQ
         tWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711405474; x=1712010274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXgqwpxj+KRr4XwZTo05/pEPqIQTgbSxC+kzqX6yUf0=;
        b=XB8ICNx4PxoWTdPg3zWCCCx27gz3OGcAlW85k1u+ZyeCxD5iWdtdPPyMBMdYO3GbVo
         ofEvC3gpaY20DWoC00tI1nNJ3mqb9h94SVufKpL+oE6SUeNd0nA/X/j+4KDdcju5H77B
         gS3wv3pPQzBS3+rZ/laOXS0Ivfs72XyPDWRIg5kZhDqXPnMuv4H0C4e7EuF8Pi57lnOg
         +jkN+8A0pnxC7gyem45hb4kkWKREf/sRA/KkZ1moVR5bqcZ8YeH8bUFuzBO0s6wCOpuQ
         Kmt5/mGOuk6V7/zmfA0QXAun9/7kdnICmr9f09fcXrPeRhrY2vFlRaQaXCee7AtHJjhc
         Ik/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVy/741tXMM08itrizDa4rTvcZEagxODCW0+CntLaqFPjTxiYEU2n7BUH8XSJ7CgVNjeS9LKB5J0ZlXJNXgdURX7nSQESZjaeA+ciXh
X-Gm-Message-State: AOJu0YyiFTOI1fSd0Psrk1iWwMaxmKEFxqn+HS3PpnA2wOvXSJrrj4u2
	Xp68IBjNpLs0ik9/9eXqsIElr5YsIkqadI31/bSNfDfcBUvqyfFBq3BjwVV1dpo=
X-Google-Smtp-Source: AGHT+IHzTrGtvlIVmQWKYZYg11O0smq126+5aIaG6kGa7LYYwh2qINAQ8cjhf5mRBs0O31WiAm2i+Q==
X-Received: by 2002:a05:600c:511f:b0:414:7db2:8be5 with SMTP id o31-20020a05600c511f00b004147db28be5mr6453786wms.26.1711405474360;
        Mon, 25 Mar 2024 15:24:34 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id n10-20020adfe34a000000b0033de10c9efcsm10513994wrj.114.2024.03.25.15.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:24:34 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rafael@kernel.org
Cc: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Revert "thermal: core: Don't update trip points inside the hysteresis range"
Date: Mon, 25 Mar 2024 23:24:24 +0100
Message-Id: <20240325222424.4179635-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It has been reported the commit cf3986f8c01d3 introduced a regression
when the temperature is wavering in the hysteresis region. The
mitigation stops leading to an uncontrolled temperature increase until
reaching the critical trip point.

Here what happens:

 * 'throttle' is when the current temperature is greater than the trip
   point temperature
 * 'target' is the mitigation level
 * 'passive' is positive when there is a mitigation, zero otherwise
 * these values are computed in the step_wise governor

Configuration:

 trip point 1: temp=95°C, hyst=5°C (passive)
 trip point 2: temp=115°C, hyst=0°C (critical)
 governor: step_wise

1. The temperature crosses the way up the trip point 1 at 95°C

   - trend=raising
   - throttle=1, target=1
   - passive=1
   - set_trips: low=90°C, high=115°C

2. The temperature decreases but stays in the hysteresis region at
   93°C

   - trend=dropping
   - throttle=0, target=0
   - passive=1

   Before cf3986f8c01d3
   - set_trips: low=90°C, high=95°C

   After cf3986f8c01d3
   - set_trips: low=90°C, high=115°C

3. The temperature increases a bit but stays in the hysteresis region
   at 94°C (so below the trip point 1 temp 95°C)

   - trend=raising
   - throttle=0, target=0
   - passive=1

   Before cf3986f8c01d3
   - set_trips: low=90°C, high=95°C

   After cf3986f8c01d3
   - set_trips: low=90°C, high=115°C

4. The temperature decreases but stays in the hysteresis region at
   93°C

   - trend=dropping
   - throttle=0, target=THERMAL_NO_TARGET
   - passive=0

   Before cf3986f8c01d3
   - set_trips: low=90°C, high=95°C

   After cf3986f8c01d3
   - set_trips: low=90°C, high=115°C

At this point, the 'passive' value is zero, there is no mitigation,
the temperature is in the hysteresis region, the next trip point is
115°C. As 'passive' is zero, the timer to monitor the thermal zone is
disabled. Consequently if the temperature continues to increase, no
mitigation will happen and it will reach the 115°C trip point and
reboot.

Before the optimization, the high boundary would have been 95°C, thus
triggering the mitigation again and rearming the polling timer.

The optimization make sense but given the current implementation of
the step_wise governor collaborating via this 'passive' flag with the
core framework it can not work.

From a higher perspective it seems like there is a problem between the
governor which sets a variable to be used by the core framework. That
sounds akward and it would make much more sense if the core framework
controls the governor and not the opposite. But as the devil hides in
the details, there are some subtilities to be addressed before.

Elaborating those would be out of the scope this changelog. So let's
stay simple and revert the change first to fixup all broken mobile
platforms.

This reverts commit cf3986f8c01d355490d0ac6024391b989a9d1e9d.

This revert applies on top of v6.9-rc1.

Fixes: cf3986f8c01d3 ("thermal: core: Don't update trip points inside the hysteresis range")
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reported-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Cc: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Conflicts with commit 0c0c4740c9d26 in:
	drivers/thermal/thermal_trip.c

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_trip.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index 09f6050dd041..497abf0d47ca 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -65,7 +65,6 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 {
 	const struct thermal_trip *trip;
 	int low = -INT_MAX, high = INT_MAX;
-	bool same_trip = false;
 	int ret;
 
 	lockdep_assert_held(&tz->lock);
@@ -74,36 +73,22 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 		return;
 
 	for_each_trip(tz, trip) {
-		bool low_set = false;
 		int trip_low;
 
 		trip_low = trip->temperature - trip->hysteresis;
 
-		if (trip_low < tz->temperature && trip_low > low) {
+		if (trip_low < tz->temperature && trip_low > low)
 			low = trip_low;
-			low_set = true;
-			same_trip = false;
-		}
 
 		if (trip->temperature > tz->temperature &&
-		    trip->temperature < high) {
+		    trip->temperature < high)
 			high = trip->temperature;
-			same_trip = low_set;
-		}
 	}
 
 	/* No need to change trip points */
 	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
 		return;
 
-	/*
-	 * If "high" and "low" are the same, skip the change unless this is the
-	 * first time.
-	 */
-	if (same_trip && (tz->prev_low_trip != -INT_MAX ||
-	    tz->prev_high_trip != INT_MAX))
-		return;
-
 	tz->prev_low_trip = low;
 	tz->prev_high_trip = high;
 
-- 
2.34.1


