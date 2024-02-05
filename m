Return-Path: <linux-kernel+bounces-51990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC881849260
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7FB1F22767
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD6479CF;
	Mon,  5 Feb 2024 02:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="fRTUbibM"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A454CAD27
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707099922; cv=none; b=Us4KoFtMffYBLG+5pJuocb1GqkNbHw2rUyf8kfitTkCp8CNnp2EXKrerCad94jObUw7EpSakTba2SIr6lSoB+XEHsp63y1mhfGCxcI8JzKtKla4r67XKkUDbR460OfymMbvFv8+yZK212dQa1SqK+azTDp4GL4ZvLXJuCnyzF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707099922; c=relaxed/simple;
	bh=8e2ZtlAdrtsfponDxeWJ9SpUMacZnh0zw7mhcfhkb88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PPY+s3Zm5L9OCFGti9WRkyId54RRmvJdFRs+Vn0gevPuiR5srCFhOSy4getK115ORTqvmUQ9w9OfBAWEzrbJlY7eVfOux3oo1WJsEMY9tB02WnyiEW+V8mkkXTfttvSPdiAUTvUija/NCMvWqbh3XyfYlVr313duZiXRz6t1mVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=fRTUbibM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so3095561f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 18:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1707099919; x=1707704719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w8scmLEsyzGxoS8Gc0uCCvoQDZ8pPxzLZfnYWsrBWUA=;
        b=fRTUbibMeu8IOUrMBRykoIhEFldewn+85ilF1zECtXHml7+qXISZo251hJoH8xfNzh
         TXPKKb5S2pxLL3Ma3IBsTqJHpy/kgET4W5W+K6gbYTf27SRwiKdlO2i8G446yHLsypNw
         gUX0v4qtRp9l9cszG/4Q7R9CgoJpk9mXDQXTAHTYmeXDXCEtSFptgVaDyfpUtpnODQnE
         DESTYHGgD9lyuR9o5vDzdvS6NdqknKc72fi/6a36cpv95O9iovv3FFV39Y4nB7wRAQ7v
         N8MUw3FupsX1UgEr+advRah+Equ0o7ElFuRocQ20dwKp27of+ooqpjNbtJdfcm6DQK06
         uPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707099919; x=1707704719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8scmLEsyzGxoS8Gc0uCCvoQDZ8pPxzLZfnYWsrBWUA=;
        b=UQHiFT609jlkpHW61N7CN8bXq45Fl4sdUjw2FdAkgNMxUwZCdlZp6+Lq8Wg8af/HOK
         NjbfA79GwxNakl9dyK+mlkmwyFma0KRl7+uhepw1erLcwHqVf1FCflbmGapO7CTvX1xC
         oMixB+/i7gzzYwwTt8sMZuVILPWXsqYVas5t215Lrnf0wbkPBccjXF1wERemWHnEL7SV
         ThQ7piT7K2I7JDy2bePuTJ31ie0vq0m2ihbJRYrdsM9h7rL0JMsuSwEZ8zV3hEP2JLky
         +YKKyT/6zdBjrHybK/ir9WLCJ+etouVpHnUH1Ib/Yo/JygjPvLsk/Du6fxoMjuSbCLzy
         iwyg==
X-Gm-Message-State: AOJu0Yz/IQrvaSughwZQonUqAUZ4WiCWo3AEMlJm4ONrAG+u4ogP50rp
	fwP3XhPtAdB1mj/65fKgd14FQ2T1K4mbKSyGmELSAagVwJRc+fayoXDY9vsxQrY=
X-Google-Smtp-Source: AGHT+IGFgnJsXnfu8s6Z2SS2anOiJGG6PLT0W7S2m34AkU5x9hit1oXft5S64KpZWwFPrOfrnr/llQ==
X-Received: by 2002:adf:fcc5:0:b0:33a:e2d3:c3ec with SMTP id f5-20020adffcc5000000b0033ae2d3c3ecmr8699060wrs.60.1707099918847;
        Sun, 04 Feb 2024 18:25:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWXl4Ig7R7yZxUjzj3JEz1+xOHBtc/N6U2uE07YtlDNBfjKKklvgEV4vxbQ56jwyhh77pLVToizjHEmHEO5GhPaz5CcJRivwVUN0f6eS4cHKc26l6Voe21ivkxAD5I42aqMvXKfI7Vo0eAnm7XsW/B4iMjC1eH4Kxz4vXHNo6sfujNOmBYRdyQnLfV0NgYNBCxFA5K/XlfwqyBL91pNrp+GJfNcBjud0Utide8L5Nfsbkl37jQK7n8z1CLggN+HoAI+9rc2oP+tLFOMeP67lwhnevmZHw==
Received: from airbuntu.. (host109-154-238-234.range109-154.btcentralplus.com. [109.154.238.234])
        by smtp.gmail.com with ESMTPSA id x9-20020adff649000000b0033947d7651asm7032099wrp.5.2024.02.04.18.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 18:25:18 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH] cpufreq: Change default transition delay to 2ms
Date: Mon,  5 Feb 2024 02:25:00 +0000
Message-Id: <20240205022500.2232124-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

10ms is too high for today's hardware, even low end ones. This default
end up being used a lot on Arm machines at least. Pine64, mac mini and
pixel 6 all end up with 10ms rate_limit_us when using schedutil, and
it's too high for all of them.

Change the default to 2ms which should be 'pessimistic' enough for worst
case scenario, but not too high for platforms with fast DVFS hardware.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 44db4f59c4cc..8207f7294cb6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -582,11 +582,11 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
 		 * for platforms where transition_latency is in milliseconds, it
 		 * ends up giving unrealistic values.
 		 *
-		 * Cap the default transition delay to 10 ms, which seems to be
+		 * Cap the default transition delay to 2 ms, which seems to be
 		 * a reasonable amount of time after which we should reevaluate
 		 * the frequency.
 		 */
-		return min(latency * LATENCY_MULTIPLIER, (unsigned int)10000);
+		return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2*MSEC_PER_SEC));
 	}
 
 	return LATENCY_MULTIPLIER;
-- 
2.34.1


