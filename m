Return-Path: <linux-kernel+bounces-63501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB15853079
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C931F27D85
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC443D99E;
	Tue, 13 Feb 2024 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="l7WIuQDz"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41892BB02
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827222; cv=none; b=hAqWtJl+2Z3BlDTqcmyRqAlpBU6NqseAMfNHFuUbHikSHo8qpjDXKeEe6R9VMtIhtFX7HWaSCJS0uc6qW6cQYXk/S0WG7TLns+rGnFuOAjVbAAcrIx1C4mUR+4RWqY9lFPYNBjcZ9eaKyUC9TekJdcr1v+E4gduCKl8B7e+vkvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827222; c=relaxed/simple;
	bh=2bUi5ocU7hGIKKXsYhWjmW0y66Qa9iTEbHZUbBCfOHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fTaXX9kE2ugApard+0gNsvDHdgIIkkntHF9toMH6lNGbgMvrrD3zdegkICYe9mZb9XNAIY32nB087BCqXRDWZ6T0DY1MksjGXeFX2NaStg4IJnw207+83UHuo80SvOV8wZKDmcdRwC+Lt8tT6cjj8klLIdyJEr/+9nyCTQYq5U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=l7WIuQDz; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d09bdddfc9so56938301fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1707827217; x=1708432017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AiPjHiM2hRS+OoUkP3LtwjwT4ETlSRpcnKvPYoLHR4I=;
        b=l7WIuQDz5jQQCUfXtLRB6sf+V7xIt/qkHOpuiV3w1fbmcrL1+FBDjVV8ijwyWb7j1F
         +ZKcglSCMewJBJSKOp4ljSkjiXfIP6zQGRT9wlye+9/Ts+4D8CvfoLGiHAqR+CLS8uyr
         1QzCCMvGASIblpZNGeZEEd0XAn76JZ6FcWSZHasxOLG77/qUFoXm/SNjgNrP38jhofuN
         oG6kR43NlJXR45nNwDdbfowQI/P6NIk2UxVy0DVYtirWEwuPFopLxKbZpy43lWYXMlxj
         /guGSDC5fYr2ICeLZmL9I/rbwGA+wLqqJmgtJfTQqwtsICGcr7LKuR5lrttKgF6DHi/j
         vEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707827217; x=1708432017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiPjHiM2hRS+OoUkP3LtwjwT4ETlSRpcnKvPYoLHR4I=;
        b=NO3lqKID3SKT59+K3h1t2j2X0+cjeiysSnj4eeVvaOwqylUGExpuDke8VZWQ+F+T5X
         j+3euV7yU8PQ6WrLoacF/L7JR1UWzLAMCVDsbYw0UBpnUtWEQYjDar22GVvLyojsAzQg
         lTyJW4EkMYLCVdI+gwN2I/6ubahHjHmDAOYBwDx+O1bnRrX70cBB3tckq3megqblO89O
         TLbaeRnbxi/N6pB5GinMOngwsudswpY1PIzVIV2XOtWkgnOqWuCMgW+oQV6tvBqRO+nI
         2Z7aDEyRsDQJeOcFkTU4E6Mc4rxzoviw5fuWGICYfcRKuQQUFNmxVdUId8zqcawcTEuG
         95NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSYFaua1eiuSQp49+Ck5wJ8ZKjh/wcmBO/kCvrAfycCjo00moJJ6RELyrMufpUXrnqyx0x4q5Rz+ACHkJ9ynqzxme/AZv0glcWnj8L
X-Gm-Message-State: AOJu0YzH8yGXOFMzY88UdxudB5G3X7O6R+KptRgF/iPEDqTZ7jPQEzHs
	1hLEvzcYcKD0MbhuxtPo2SjNoTCwjjgLsl8H3INeI7ZvC9+UGkNvd00/VPdd530=
X-Google-Smtp-Source: AGHT+IEt67WUBHbKpCxVtemm/Vm7tBxAQm62HxQJ0X7AMI9PDt8IG937eE32+LLj0r6JPBOUwbI8pg==
X-Received: by 2002:a2e:87cb:0:b0:2d0:dfa7:8a87 with SMTP id v11-20020a2e87cb000000b002d0dfa78a87mr6577428ljj.8.1707827216914;
        Tue, 13 Feb 2024 04:26:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3t52NRpuLVWSjP60f+B3gFgGqGMkEgJbn/JTKGOAbhNlQzBS9KzWwy+lM+Xk7C58NBXRTGq5Wqa0N9OBBX6X+qf3QDhqjLQ5jYSd4eQTd8ICqCpY0sREytYemlYT7QsVxCroAQEx6iOqGQbWTTgVbgnKxncJzY3/FYOhI50REQZw/pRJqBkjlrmORshYgUFUwQ50gbU72XgxcJ1l/
Received: from fedora.fritz.box (aftr-82-135-80-242.dynamic.mnet-online.de. [82.135.80.242])
        by smtp.gmail.com with ESMTPSA id jx6-20020a05600c578600b0040ffd94cd27sm11444420wmb.45.2024.02.13.04.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 04:26:56 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] tools: selftests: Remove unnecessary semicolons
Date: Tue, 13 Feb 2024 13:23:18 +0100
Message-ID: <20240213122317.1883-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 tools/testing/selftests/bpf/benchs/bench_local_storage_create.c | 2 +-
 tools/testing/selftests/kvm/access_tracking_perf_test.c         | 2 +-
 tools/testing/selftests/timers/nanosleep.c                      | 2 +-
 tools/testing/selftests/timers/nsleep-lat.c                     | 2 +-
 tools/testing/selftests/timers/set-timer-lat.c                  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
index b36de42ee4d9..e2ff8ea1cb79 100644
--- a/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
@@ -186,7 +186,7 @@ static void *task_producer(void *input)
 
 		for (i = 0; i < batch_sz; i++) {
 			if (!pthd_results[i])
-				pthread_join(pthds[i], NULL);;
+				pthread_join(pthds[i], NULL);
 		}
 	}
 
diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 3c7defd34f56..447e619cf856 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -239,7 +239,7 @@ static void vcpu_thread_main(struct memstress_vcpu_args *vcpu_args)
 		case ITERATION_MARK_IDLE:
 			mark_vcpu_memory_idle(vm, vcpu_args);
 			break;
-		};
+		}
 
 		vcpu_last_completed_iteration[vcpu_idx] = current_iteration;
 	}
diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index df1d03516e7b..34e61507fa1f 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -72,7 +72,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
diff --git a/tools/testing/selftests/timers/nsleep-lat.c b/tools/testing/selftests/timers/nsleep-lat.c
index edb5acacf214..d839fa4e6e08 100644
--- a/tools/testing/selftests/timers/nsleep-lat.c
+++ b/tools/testing/selftests/timers/nsleep-lat.c
@@ -72,7 +72,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
diff --git a/tools/testing/selftests/timers/set-timer-lat.c b/tools/testing/selftests/timers/set-timer-lat.c
index 50da45437daa..d60bbcad487f 100644
--- a/tools/testing/selftests/timers/set-timer-lat.c
+++ b/tools/testing/selftests/timers/set-timer-lat.c
@@ -80,7 +80,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
-- 
2.43.0


