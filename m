Return-Path: <linux-kernel+bounces-24753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E8182C1D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B701F218C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA9B58AB7;
	Fri, 12 Jan 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l5+sjcVK"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDB11EB50
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3368b1e056eso5158708f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 06:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705069822; x=1705674622; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NmU6FjbcYWnssDfQrvaQbMBGWJvzjg9Ug1O6rh+F1fk=;
        b=l5+sjcVKPWv0AmoRsvIhU619nCCT0WLMtH9zQM+ezBSTUM9njuqsECNh7k1ItdpPFr
         A3T+OWURLkTvVilRDvsQAptG8czVLg1VWUCDaNOyeRYIcSXzbAeiedN4qKsMxhRFiSqE
         yzFA6kI/Gmc7DhB2pHXSV6107G2HF1UOV7/6e9YwJ8Kff1UC1cv9jAKwrLj6uMzyE10p
         ZgjNDi06+B7tNlV6sEUjmh9aZeG0vbuXK8ahZ6h/d32yIq3M9ti7L9WtL1Ng8mblHVde
         A1kUbSBdsCD28Sm3/gbi7ZhYt4+9k4sTMo9v3gDDbp9yLKy0FGzV8k32uyOXNEReevY7
         aRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705069822; x=1705674622;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmU6FjbcYWnssDfQrvaQbMBGWJvzjg9Ug1O6rh+F1fk=;
        b=JhsGkYRNrFu2Sjcy0wcYlnsVuBDPaO2TJWOAmk+7QtINYYbvoh3i+zct4nee0sovMk
         Ew5zqVj8ZXiOnidczBbwq22xt9BhpIBfxp1tOny9r1MT7z4klg1QXITujOCOR6h2yzvL
         paEuhpnkHwMzNVt3octAIIZ89B924pubZs3GVxx0cBwAGZzHUWXX6u3W1JXmkiTtrUIY
         UfmBq3sPxCEuT6yrzZqAhRTVfPkZu2EU4vYuVrbZA5OtPS0UAZyWl4uXEtX0KHC54XOl
         XntFFuJbVBhWyI5jyKdVtC3kShDouUkdaWN/QCBB9CPTkOAsUWPL0eCEqawVv2hLnIey
         xZ4w==
X-Gm-Message-State: AOJu0YyTvKWh+gaioxsYl8Amj/aEyiQGLgeYpEGXhwjaMjUSr9+lMtgo
	6sRoc/Xqm1s3W58n3MjS6UOo8m4ZskB1jg==
X-Google-Smtp-Source: AGHT+IE9jqnAYtRzeY8zdjvlncxWey0s5skhE+kPz5ZnIjIk2Pxsu+gMm5ShylsGvcGoOJV/IzbWcw==
X-Received: by 2002:a05:6000:10c4:b0:336:6514:a97f with SMTP id b4-20020a05600010c400b003366514a97fmr716022wrx.106.1705069822073;
        Fri, 12 Jan 2024 06:30:22 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d5088000000b003364a0e6983sm4010911wrt.62.2024.01.12.06.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 06:30:21 -0800 (PST)
Date: Fri, 12 Jan 2024 17:30:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] thermal/debugfs: Unlock on error path in
 thermal_debug_tz_trip_up()
Message-ID: <efe2a897-4af0-4204-8105-1bee7d6b9380@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Add a missing mutex_unlock(&thermal_dbg->lock) to this error path.

Fixes: 4731c8f16a0e ("thermal/debugfs: Add thermal debugfs information for mitigation episodes")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/thermal/thermal_debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
index a3fa09235da1..a3f06029fc54 100644
--- a/drivers/thermal/thermal_debugfs.c
+++ b/drivers/thermal/thermal_debugfs.c
@@ -591,7 +591,7 @@ void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
 	if (!tz_dbg->nr_trips) {
 		tze = thermal_debugfs_tz_event_alloc(tz, now);
 		if (!tze)
-			return;
+			goto unlock;
 
 		list_add(&tze->node, &tz_dbg->tz_episodes);
 	}
@@ -619,6 +619,7 @@ void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
 		(temperature - tze->trip_stats[trip_id].avg) /
 		tze->trip_stats[trip_id].count;
 
+unlock:
 	mutex_unlock(&thermal_dbg->lock);
 }
 
-- 
2.43.0


