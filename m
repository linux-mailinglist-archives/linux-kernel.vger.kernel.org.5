Return-Path: <linux-kernel+bounces-63856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DB1853591
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4101F228D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0D75F56A;
	Tue, 13 Feb 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="raf3WQah"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9785F47E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840346; cv=none; b=MnbisBcwyC31hJWjL8ZB+oHsf26lA4ZQaQeZpiPhy6i5FO9pNUuBunkj1DEHumSB/qASYFHJonOePKkkgDWTM4NBpiEC3lEvRWE/FD7teJvklnbvXcV8fH1yymCDAk4ZgwROCTA5GgjbK8kNMywdJJXADWeIqgmF+2I0gMKN3qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840346; c=relaxed/simple;
	bh=WlWQhkPvqvvxS2SzBrkZ/UlzsYw4kCBq05WyUUmIeGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mZhoaa3YpWGEGo17CYo8XT7wLGl/vt8CTw8tGqtYYI+K9c2cFK1+ZioU16nyR8Sf51SYbfMEFn41l5gn1Cl+QM+A0HNuzjhYBGEDiYKh8XTco40KdGtWn/lhiUypoyxTYeSClLLWfI4bh8M5f7WTUDyIL8tOT8FBc1g0RQwFD04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=raf3WQah; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 33F623F670
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1707840336;
	bh=m2uF9MzAc75gHZLl1cGiAQQWw9h+uBS56/okcKFf60I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=raf3WQah8zNsNPVOzR1PhNHICi3ggftNbmG6DQw1thtnCi457J2Aa2QHj9Wi9qF/P
	 ZO6Lt4rq0U2gADPpGFuLLPOnbTqels514DWdHp7FegRSOdTt71SQb0SpjkSGbIBOIn
	 Um7L1jL75id0xT6AodT+FdM37ZkTTkjvRdSO9ZJZqbby/FoFux23ekSp6dUVZeneDg
	 is7hvJKoHQuX6iCLWuryHIjKlLgoj3a4jiYWRu6K+kZ7ipI/d7GG3rHPWgH5vbOmxO
	 qrmWCnoq0q1YDp2m5aX0D53U4v9Fdw+c8lmrOoDvq8EiPMoWLgJ34SotIfehcCBXgM
	 i8dq4uHwx7YOQ==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1d542680c9cso58216175ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:05:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707840334; x=1708445134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2uF9MzAc75gHZLl1cGiAQQWw9h+uBS56/okcKFf60I=;
        b=iaijq68tK8vEDT1wf+P5WfzW2RdfU8YZ85WgH2FOKHdCGxobPnpveB3UujxHqRRy/z
         3VQ8EHeQU2sdpa7fsy1BXrRlBINxudHOJKq9qSAPae7mlXvtvjQFtukNrrIArKnyF0uG
         QdfcAiqha3+xUPWXmGqOGcrddPdMcyh2r0vU+bYC/jNJfFtVsKd94IYRueTUeDzYB+Oi
         0r0LMTNXzO5JLo3OMyohDrorxhoDgrFwR9M3Ymyi7nalOX+vOOFAqAS9G2x2rwpFaJ5m
         xUhl+FXxZnWufu8HEXf31MS+IaYH88bdHK1Y2numwXAHDZZAyN10ZkAL9eupgxFdZ3u4
         QVlQ==
X-Gm-Message-State: AOJu0YxdEMMCMldiT1q5Ksr1WsMmgI31GMVSK2cCO6R6f9fQeSSJPGSo
	l1Edxb7U7tEHvhaFLc2yVT2OKyOqTd2ZSqIwHrZK8O4EiTlmeRjrUQquthdewZZHmMfJ4AON8T2
	ipUXpe4NMnEnupdL942gffuHHmlBGg8i79JSd98YAzO7As1G1nMi0NUBH8lrA97/fZLDs9RWf3S
	RRnjZ213fAjf4o
X-Received: by 2002:a17:902:eccc:b0:1d8:e2af:f7a3 with SMTP id a12-20020a170902eccc00b001d8e2aff7a3mr9033462plh.60.1707840334693;
        Tue, 13 Feb 2024 08:05:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/I9tj91UbaygSHRr/+8Vld7JgcLjlxqJeYSEJsh8+q9pnwmMcdOZcAzCm83FWMUNwV/QEjQ==
X-Received: by 2002:a17:902:eccc:b0:1d8:e2af:f7a3 with SMTP id a12-20020a170902eccc00b001d8e2aff7a3mr9033435plh.60.1707840334330;
        Tue, 13 Feb 2024 08:05:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU370TRTXx+dacoVfx8mFo22IPUsO2OwdpclHJxKZsi5lmYJwY+5eGsyVEBemBP6a1cq6kbjlf50zD3qUaVfvGtd13P4uTaqf+6/t9abkgxfKkieVEaNkc7XiJdjIz0W28DeO9YExb6vkQMhffzi6tkYW2S8/O6ssHihqQQe4+ENcjGXPp2yrt0WFE/PMqqrCIE6ECppESNDIqTO93hgA==
Received: from fenrir.. ([179.108.23.66])
        by smtp.gmail.com with ESMTPSA id bf5-20020a170902b90500b001d9c1d8a401sm2251685plb.191.2024.02.13.08.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 08:05:33 -0800 (PST)
From: lincoln.wallace@canonical.com
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	corbet@lwn.net,
	brgl@bgdev.pl,
	linus.walleij@linaro.org
Cc: Lincoln Wallace <lincoln.wallace@canonical.com>
Subject: [PATCH] Documentation: gpio: Add a note on the deprecated GPIO Testing Driver
Date: Tue, 13 Feb 2024 13:05:22 -0300
Message-Id: <20240213160522.37940-1-lincoln.wallace@canonical.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lincoln Wallace <lincoln.wallace@canonical.com>

A deprecation note was added on gpio-mockup Kconfig since v6.7,
update the documentation to inform users.

Signed-off-by: Lincoln Wallace <lincoln.wallace@canonical.com>
---
 Documentation/admin-guide/gpio/gpio-mockup.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/gpio/gpio-mockup.rst b/Documentation/admin-guide/gpio/gpio-mockup.rst
index 493071da1738..a6424de925da 100644
--- a/Documentation/admin-guide/gpio/gpio-mockup.rst
+++ b/Documentation/admin-guide/gpio/gpio-mockup.rst
@@ -3,6 +3,11 @@
 GPIO Testing Driver
 ===================
 
+.. note::
+    Since kernel version 6.7, this method is being deprecated. Prefer using
+    Documentation/admin-guide/gpio/gpio-sim.rst instead for kernel versions
+    newer than 5.17, which is when gpio-sim was added.
+
 The GPIO Testing Driver (gpio-mockup) provides a way to create simulated GPIO
 chips for testing purposes. The lines exposed by these chips can be accessed
 using the standard GPIO character device interface as well as manipulated
-- 
2.40.1


