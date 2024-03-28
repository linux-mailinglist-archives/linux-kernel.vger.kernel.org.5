Return-Path: <linux-kernel+bounces-122894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B763988FF1C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B4429366A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0637F7DB;
	Thu, 28 Mar 2024 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rttbFsEk"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27607F46C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629288; cv=none; b=oG7UFc/OLeaozV555thHcUsgjryM4VMu/XS1Kp06Ae7jopGWpf2OHJw9NnRIT+oCFbupXIBg7CG+Z2dBsNLEQKJhcYi8d2hrtlvkmelE7kwsAuaE/X+jT6PJWHndsW6QraCVruj6OmxPJ/0oP7X1SKDjKs/SgeSyTyo6DpXiAKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629288; c=relaxed/simple;
	bh=nbNp3qfZWcDDvV1zUWwDB7cZvmbMHfTCHJLRRggYk9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lri4o6jduWeRMF6PdeXmcnd/xLCxQgo4i1HXty0knZoOP36zUuRZIhmFuEH3PRZ3JRTcD9EY05XD3f8t5q5IdH2Wj0W5qVgp24KL816HmQc/h2QF4a8YCUWIHwaFhXvUCw6j0hVh8C13/GCKZrd5G3F7tY85/kCOrrbXgSAgWi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rttbFsEk; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ed7ef0ae8so610083f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711629285; x=1712234085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjhTo09dO/7V38CJBlOuZewKYi9PkSHGMjLUhNN+TaQ=;
        b=rttbFsEkfE0WCDfh3IHrfdeHpOA+l9B+onZ7v/4MfjceKF4580RqC0Jql5iXxyOjQB
         fjve1+5WcnSPKyOjff1037BjJSIUmKHzFOiakpymVP9Tr4eIjZNqavRGZmrgqk9nvnYm
         0jFlmILn0rONktVqMV+wf6mAgsQlR1So7vqPu3/OY9ypcFVpr02aw+GFP9XAk8nYjzE0
         WUB8qU5Fo14c58bRuitkgDmAn7oMl4RTBwgiXrqM8YkmTMVz9JPpLvJMWkWf8AdJYH+h
         K58KCQIzpIuFkCfvNs3VzODAR4fL4h+yJ+IL3wOnWTCfp4w7wbs8WLSMf3Cp4/WC7iI/
         CPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711629285; x=1712234085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjhTo09dO/7V38CJBlOuZewKYi9PkSHGMjLUhNN+TaQ=;
        b=EazBH1vxfJ94wvs3cJDu+toJ6czK4V47CwTjRiVYNiuT7seNqS3XeLBuc7HcWsTTDn
         +gmDG/66n8SKBakLSER6JiRWgfqjRWAyaPsdt2+pWfi7eNiXFv8IOhVgW/YjjGrbI7HX
         rUUkTUM6l8SSbPdRtRNHsrKIfJfdJr8wH+jOjXgDhJX2SPvYjMP2kuIIq07FIX2eFgP8
         UmXrBgAVZjzObagoU2Jf3naQLZinM1mVHkSn9JNhloO9Q1wIzwZ3OYTPHYD1krPrf+Uq
         jPKpxCakZiculOtt8ldbZNvaolffLkcQ7B9ljBIPoA5fWkWbVVIGoZQP7uu8/e1DSxCz
         E+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU7OVt5591HUTN2SPrjhzBOWqGfmp3OGw2WKfo6DDjvWwOtswnWz4ng60qsI5so3Bm3ddNy5uw82R4iQGoKRDsknSakMhaNBBRvQvC
X-Gm-Message-State: AOJu0Yx+mhiBxHDNasyI9BjQGRVDw9NlF7hNsSBYVhZUtafuPEVhc+Td
	0bfURFE9+6yuMalwx/kKo5YEToY61IDPT0qMW+JARr5lIR7CO+ozYtc0mD2KDio=
X-Google-Smtp-Source: AGHT+IEeEXB2tNCVWGb87xNYSbBQDlb72910RZrNwEk6zjsX5DNZR0GunhOGsmBaPuzi8NH9mWDR+g==
X-Received: by 2002:a5d:4ccc:0:b0:342:2ea8:18fa with SMTP id c12-20020a5d4ccc000000b003422ea818famr2188036wrt.15.1711629285483;
        Thu, 28 Mar 2024 05:34:45 -0700 (PDT)
Received: from ta2.c.googlers.com.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id u6-20020adfa186000000b00341e2146b53sm1639671wru.106.2024.03.28.05.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:34:45 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	krzysztof.kozlowski@linaro.org
Cc: alim.akhtar@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	willmcvicker@google.com,
	kernel-team@android.com,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	semen.protsenko@linaro.org,
	linux-clk@vger.kernel.org,
	jaewon02.kim@samsung.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 1/3] clk: samsung: introduce nMUX for MUX clks that can reparented
Date: Thu, 28 Mar 2024 12:34:38 +0000
Message-ID: <20240328123440.1387823-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240328123440.1387823-1-tudor.ambarus@linaro.org>
References: <20240328123440.1387823-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All samsung MUX clocks that are defined with MUX() set the
CLK_SET_RATE_NO_REPARENT flag in __MUX(), which prevents MUXes to be
reparented during clk_set_rate().

Introduce nMUX() for MUX clocks that can be reparented on clock rate
change. "nMUX" comes from "n-to-1 selector", hopefully emphasising that
the selector can change on clock rate changes. Ideally MUX/MUX_F()
should change to not have the CLK_SET_RATE_NO_REPARENT flag set by
default, and all their users to be updated to add the flag back
(like in the case of DIV and GATE). But this is a very intrusive change
and because for now only GS101 allows MUX reparenting on clock rate
change, stick with nMUX().

One user of nMUX() will be GS101. GS101 defines MUX clocks that
are dedicated for each instance of an IP (see MUX USI). The reparenting
of these MUX clocks will not affect other instances of the same IP or
different IPs altogether.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/clk/samsung/clk.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index a70bd7cce39f..fb06caa71f0a 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -133,7 +133,7 @@ struct samsung_mux_clock {
 		.name		= cname,			\
 		.parent_names	= pnames,			\
 		.num_parents	= ARRAY_SIZE(pnames),		\
-		.flags		= (f) | CLK_SET_RATE_NO_REPARENT, \
+		.flags		= f,				\
 		.offset		= o,				\
 		.shift		= s,				\
 		.width		= w,				\
@@ -141,9 +141,16 @@ struct samsung_mux_clock {
 	}
 
 #define MUX(_id, cname, pnames, o, s, w)			\
-	__MUX(_id, cname, pnames, o, s, w, 0, 0)
+	__MUX(_id, cname, pnames, o, s, w, CLK_SET_RATE_NO_REPARENT, 0)
 
 #define MUX_F(_id, cname, pnames, o, s, w, f, mf)		\
+	__MUX(_id, cname, pnames, o, s, w, (f) | CLK_SET_RATE_NO_REPARENT, mf)
+
+/* Used by MUX clocks where reparenting on clock rate change is allowed. */
+#define nMUX(_id, cname, pnames, o, s, w)			\
+	__MUX(_id, cname, pnames, o, s, w, 0, 0)
+
+#define nMUX_F(_id, cname, pnames, o, s, w, f, mf)		\
 	__MUX(_id, cname, pnames, o, s, w, f, mf)
 
 /**
-- 
2.44.0.396.g6e790dbe36-goog


