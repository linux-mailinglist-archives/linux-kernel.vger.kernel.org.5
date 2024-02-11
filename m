Return-Path: <linux-kernel+bounces-60844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1382850A1A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5964CB210BB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61515C5FC;
	Sun, 11 Feb 2024 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="qijXgEK5"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1D15B697
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707666277; cv=none; b=rH9jymALdBTYJmt3eXfDLFWfmCR5ID6nTqfniT2zg6no97ho8TXcLAVagYMEFSK21vjPA5Fvm9pilD4whSzk7kAxzhKVs6Sd0gdyim4qc77FsztAGDOFn9jNPZMgKHItVE7MT3dizjFBS/2xER3nMVFg33dMQRNFbIvhIdR/emQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707666277; c=relaxed/simple;
	bh=DK2hrKQSmA/m3vpTrCvZiCmzCE4CNhTcTtfORvNIHKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W5ADTJVXUaiLWyGZIDHw/OYw47kA/s1pZK/7gVKd9A4OTl13/UW0f8STMOB0/A9+1SUhhaXkdn4umqsFjUv9BS985RMLsRYuVab3vFIAI8wxofwZ6MUfj9d0IKTYMjy/WXvrGWR+T+WvlBe8clLDkgVWa47x/9a/+mCo7/Jmz7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=qijXgEK5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e0a608a36bso615636b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 07:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707666275; x=1708271075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+E1K6pvxB8MK9OPanevb+L76gD9CBZNqNqAXOGIap8=;
        b=vrFRXVKHw7gn3cJ78AV/P8CwNFoc8t4WQHSFwqe4F6Q2O5ZjZQU1HI81DTuKC+qdk3
         XiaA4bkWffXHSkQ1d+2UJ3jvIgkkAILMeRpsX2ahviR1zmVjINiMWMb+S22wcoa3Vzh5
         kbnZrmUiFeD1AWzYGJDy+MeDAxoyEKbu2vLNvMGkcNhKBUcTl1KOeVlh8uh2+UT8kBwb
         h31qKLKGGee4INc7P3VYyzAZ9bwPYTCJxjpGQM7SvNpHTijmxek4nbK5+YFrExLRWLsT
         YrDYZh1XT8Wu/zJWRtd6paffYIkU7YvMLuffnoJ22HeoZY/fCvXdO9rTeH/FoiorTA/a
         Pj6A==
X-Gm-Message-State: AOJu0YxWft+4AC4W3lCUxsbmMbsAmxENjiG+8q/d16Xj/+7OTuofisZH
	f8Il7Cqw9kITLoc1RZkzJg50+FRdSX6ynC2QP/W8zNC2covIUuYV
X-Google-Smtp-Source: AGHT+IGLetR+W3FaSqd3kOAF4ILwXsCwRToCqcwZEu6Aar8deWxH3+qJzpXXK3ztiWTSRl4GbGzatQ==
X-Received: by 2002:a05:6a00:be7:b0:6e0:8618:d06f with SMTP id x39-20020a056a000be700b006e08618d06fmr5402240pfu.15.1707666274945;
        Sun, 11 Feb 2024 07:44:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXowjBnPL7K9TK313W9v8e42KDNQ3ZT6FsdhfMJNawbT5WwAY0VqGgpdHlVURzVY68fpOFbk9+nVLFAYhSW8njDRcbAewbib/wCqr5tbbpvIzBvYM4F1egyCY5ZP8gYybgXxb/f9NvDuA==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id y2-20020aa78542000000b006db87354a8fsm3893001pfn.119.2024.02.11.07.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 07:44:34 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707666273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+E1K6pvxB8MK9OPanevb+L76gD9CBZNqNqAXOGIap8=;
	b=qijXgEK5ILnIFBQD9mvvYrk8HhV0qF/7h3NkHCWDSW0OfQp8hRZA7zCNXbLnbSBplY04O6
	Kirdbej8E/m2bGTTDavzL0V5tkjGqQG3iZLzBvxWJsobdgM764bjSbtoNxfecOaou8sNAA
	45mWTzntZE2Y4vEehnQC4a7HUTVK62ScQPL0Wk2JfZYtEr6enThuUsScK2oXrRvvZyK4q+
	cLYb4wJH/Pqp5B+cdaZL9SC6XvTsK7y8BxOf7T9lFgBjRyJ2bjklPz6NrcW0ZaR2KVDILT
	fnHk7SKjHgfdrCoUmlU7d0ik15oDH9b8+Z5IsYeHN4s+VMbvR4ZnUi86ulp2Bg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 11 Feb 2024 12:45:07 -0300
Subject: [PATCH 1/2] ARM: sa1111: make sa1111_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240211-bus_cleanup-rmk-v1-1-65668e578d55@marliere.net>
References: <20240211-bus_cleanup-rmk-v1-0-65668e578d55@marliere.net>
In-Reply-To: <20240211-bus_cleanup-rmk-v1-0-65668e578d55@marliere.net>
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=DK2hrKQSmA/m3vpTrCvZiCmzCE4CNhTcTtfORvNIHKU=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlyOuDqUqPoEntFfTN/v8LK/S+wiWRLSEiI9Huc
 C7rg+ncd+mJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcjrgwAKCRDJC4p8Y4ZY
 pvIXD/9BytVKk7OtOHgQDQKhGi1j48y4AfQjvEXViMSGASXzWJtxHoXXUXGmoijiXFA/Vjre6nv
 VcrWhAEJefFI9uWhY2pVF03wIciV2ZPU8/o6b7VvXuUNApCraIvXRkQ/xCEj01Gzb/smU0nIRQP
 G/ePjYwB8yOGt5tOTS/9qCZh/xesDnuY0dVI0Utyz+e5O+3hLyfCvmSSUYiRnfJCWvCDwL5f0R1
 eG0j2jLsGXqh9/W6Io+YUfVatwlIMbOFIlHV3FVpCq/BXBLKFLjE1xQZJjyUtydMUUazBkeK2ko
 E3vtiY52OUmTSd6tvBqPwwdSsvM/FxIII47OrMHYxaawnjNTMAqDpSjBQldmZcvGtNCVl41QaK7
 t+eDVRURWVc43GKX+BHgR2rDGnKPcrz/Ubp6uBHvYLW/SixQA+yZX6ijU4oB9S7LiG7FBieiM1B
 sUoKRMoirYDNF/6upir6YPZT42CnWXDZBy3r3iw7S55aasn1AIaBqiSj4fkO6qWeVR+pky334TJ
 24zo3NGov5M+MMOY13NCOIvfBZ+tmhhVOhEm/eIxP38xLRsU7le94dVdTjX/95X5fraNkYf2SFk
 P9tZXsrYNejtKbCZK70LU3pxVE8q3Ut9Ts5zTES8ChW0THysUQ7x6mvyqiR4Qa+8UDROzg6jfaR
 WHVaAcirRIze2CA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the sa1111_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/arm/common/sa1111.c               | 2 +-
 arch/arm/include/asm/hardware/sa1111.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 1fbd7363cf11..de5eba0a11f6 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -1367,7 +1367,7 @@ static void sa1111_bus_remove(struct device *dev)
 		drv->remove(sadev);
 }
 
-struct bus_type sa1111_bus_type = {
+const struct bus_type sa1111_bus_type = {
 	.name		= "sa1111-rab",
 	.match		= sa1111_match,
 	.probe		= sa1111_bus_probe,
diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index d8c6f8a99dfa..02f3f9ca8582 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -368,7 +368,7 @@
 
 
 
-extern struct bus_type sa1111_bus_type;
+extern const struct bus_type sa1111_bus_type;
 
 #define SA1111_DEVID_SBI	(1 << 0)
 #define SA1111_DEVID_SK		(1 << 1)

-- 
2.43.0


