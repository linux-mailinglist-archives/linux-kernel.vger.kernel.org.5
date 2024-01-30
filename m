Return-Path: <linux-kernel+bounces-45488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A90843161
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1103C286F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8EA79959;
	Tue, 30 Jan 2024 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMZlGmcD"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E88E79957
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657856; cv=none; b=sRuQgHRkiVcGOMRbF7PRohAekmwHnYikLCHp5gz2M6EdltECPgfRAc7EfRcqmf+Opmzb1r26PX/yuog8pRaR6700/DMhFAbZBBbOfEgjS4YVrskGmwfqKaBlOjUNOhU0o7jpaumP8tvCPPnmhXi92Mg4ukEjVXkKgYgZjqWiEJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657856; c=relaxed/simple;
	bh=1s19bgggjYqjahoc37BYPQjaNkY0EJv/JXA/THdndYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ux1sw4/vTPyP1Rdwh70guGlbE9P7lpGlyTN1tyKdAhTQBgsx1pxVAXikUeSaLRLpmlPjWvzFSzdgCkBiTr8fm0iB8Exv2DoRdzx9wiUUkoBU5BLV2IalVEcKiDun/mXhjwifdDV9K25Ueg6q1YvhZK8EYnrG0gMPV8IMlry6YTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tMZlGmcD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a34c5ca2537so513022866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706657853; x=1707262653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gsxL/I99xpEvCIDVwY097FiG8G++5DelyKefubwrp9s=;
        b=tMZlGmcDEvVipqDGLA8Baj+4Fx+MHVV7OYXcTinPrBr/k0MX9ZWMwPRQOwehx67pn/
         jHA2pv7mcXWWYc31xN309oWRKS1wcpYRR24OpFmzyVWM0PqXGb3FVxoXLaPX8dU7uGzR
         vyElFZCUZLo+odsJ7sSjvPFMDb3sBYVt4UuVwm21VrE1EToXIXXQeBmGI9OtfHMhYAPr
         5/8v0cBhNhKxqsm6hXjkwvfCjaDI2opyBdpk88EkmjS9Ug61BlriY79RBsnOOA6JOg79
         Qw3RWNfPla1+PvTA4cxrvY1gJqMc91fqYkdEWomKNEjAa1OTbtO47zHQB23dn+EwBOAb
         8eWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706657853; x=1707262653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsxL/I99xpEvCIDVwY097FiG8G++5DelyKefubwrp9s=;
        b=eHyLOQl+oJ03hRwBhpEmc5Yo8rPiQKrpo7tgUw+G0VrEx+5qde93vm3KJB82aNmW9W
         Zp49/3EUc+D9gd34wNT5cKiSrQzvBFI2xcHlnC4oc0HNp02Tp6oXRfVDnNg8vniuhqoU
         SrhaBAhNMlK+fI2//cdiAGQyrtEnX/YEneu8lyO5syPzNqehvWUk68h2S8lVXHX1F0Cf
         OcYysorOcNSOxedl0pT9A7Kv8zcqX8yj5YXtapHtKlGR4eYGOBc7yBK2KSuuB7sx7xNh
         NJXa2TDVjV06Uv/CAp8rvvTduVl4SJ9/xuP0o6CgBhwI/FIJ++yM0dY11lqeK+TFx5bg
         1tCQ==
X-Gm-Message-State: AOJu0YySglwAlchY8s4poo/MgXjGuKAM/QEN0fSMZHDUGZpfwZasL20H
	QTZP80afIs2rfQNaTDw4eHnOrZxTemw/UzEcF6xjbqZbMLpzNoHl0uOEzbyJaYc=
X-Google-Smtp-Source: AGHT+IExlGe+3KAgx9wd47PjYqPJmrXUI3Bi+ipxi1Or9XP82qWolc5r13mu2jTYPFQBAHAN37+EiA==
X-Received: by 2002:a17:907:10db:b0:a31:8a51:67df with SMTP id rv27-20020a17090710db00b00a318a5167dfmr7027211ejb.9.1706657852290;
        Tue, 30 Jan 2024 15:37:32 -0800 (PST)
Received: from puffmais.c.googlers.com.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id hw18-20020a170907a0d200b00a3600d7c2fbsm1676507ejc.176.2024.01.30.15.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:37:31 -0800 (PST)
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
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH] arm64: dts: exynos: gs101: add stable i2c aliases for gs101-oriole
Date: Tue, 30 Jan 2024 23:37:00 +0000
Message-ID: <20240130233700.2287442-1-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that we have more than i2c interface, add aliases to ensure
deterministic bus number assignment.

So as to keep compatibility with existing Pixel userspace builds, use
the same bus numbers for hsi2c_8 and hsi2c_12 as the downstream
drivers with the intention to eventually add all the earlier busses as
well.

Suggested-by: Will McVicker <willmcvicker@google.com>
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
Note, this patch should only be applied after series
"[PATCH v3 0/7] gs101 oriole: peripheral block 1 (peric1) and i2c12 support"
https://lore.kernel.org/all/20240129174703.1175426-1-andre.draszik@linaro.org/
---
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
index 6ccade2c8cb4..23314ed78c96 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
+++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
@@ -18,6 +18,8 @@ / {
 	compatible = "google,gs101-oriole", "google,gs101";
 
 	aliases {
+		i2c7 = &hsi2c_8;
+		i2c8 = &hsi2c_12;
 		serial0 = &serial_0;
 	};
 
-- 
2.43.0.429.g432eaa2c6b-goog


