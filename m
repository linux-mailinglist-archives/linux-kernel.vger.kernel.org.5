Return-Path: <linux-kernel+bounces-137106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FD589DD0D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262231C22D80
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532F8137931;
	Tue,  9 Apr 2024 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="E0rzidTt"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA91311BD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673585; cv=none; b=Nt8hg4Hq9YrpFgnt54ZFrKGqcxxOoxLuDFleLmxLSu/cEFpRpWpRYtBNURpPyEh7P9Oxq2NyQUL9LCyp5FlJgjSwJnxcHtp6oEq3YncVUn93L8T14rS/5f0T9nvJfb3IjGANewQeNjiFN6jLWUk5SoxaziDNW2RMLXVUU8eu0zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673585; c=relaxed/simple;
	bh=TH1h7MdVELSk3JCaDMw0GDrcO+j42FGSx/z+WAQnVRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g/F0jgMZzbYdsFjB/4o0uX2QOdA20GDaM6iQveoeaRGAAS/LXQT4mKohlJ0yoEx5kl31duoRB5hF9NPaOQyWuQQn8MbLu7ypY9ScpxTOWpGXElWL8aUq8QLCj6hle5dXZJl7QPf6e2sW6NWTgc900xzn40BdqKABlAoj9wPweGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=E0rzidTt; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-346407b8c9aso157929f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712673581; x=1713278381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/9/nrLk0Oz3ZkCeLo4hEqjMq5lF9FFuOkhf5GrC8XZU=;
        b=E0rzidTtPkb714Jy/BPnGsrIImvB4fKGi5dDvuhxEoPv8pgOTlEk5IJhGx76P/QGJ5
         eHOA4Vxla2C6UiP3gvXm4kYoTBWcbEBD26qN16zYfsS/KfSooCSa9pujQIfHFKLDcYPI
         XI5UEFM+bAj6n8bDtvpdWytdeBUBpaDg/tBuiw7QGSrKinlLUtTfeuZyd8furUtHc+Lf
         XcMKYaOZuMkPX40PynUlWdXrvHVZgi+XBL1VO8VGbdICaGIViNOeRpXpcEtror7fDNxm
         R3kWJbXU4dLB7B3+mUQlU214fC1P/gK7sChNRmDy4cPLw1HuNSr5/NmWz27KyD6jre9R
         k/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712673581; x=1713278381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9/nrLk0Oz3ZkCeLo4hEqjMq5lF9FFuOkhf5GrC8XZU=;
        b=aM2AXFfUKNC8WV83FV+vxCCGAIrQmV4YNIWSmIAyAChdAY+pm8UZR6MABCA/qxdgJC
         W1PvTFb9QzDdQ1ykaEdByo/hUW8GwlaKaZVjadq/CDULYXbqorxKYl+F7+Kq29O3Q7Zi
         0cON1Ej253zelutXUUlfpllk6CEFwJqnK9JyLFNJ0p7JO1xVk7trTgy150MLvR57FM3r
         ms3EvWUNRn5NeF6N3497iNgE9cyhA4uIvyptYR5YyjXiLlMCYGGeM/DAEAZsKsTfbrO6
         /qtko/S+tAkFvXjevCM04R/hNhEQ1LhwKXQ675HeGmh0AUY/+z0lUK4Pzyq6PM41q/er
         ZOzA==
X-Forwarded-Encrypted: i=1; AJvYcCVuX2wP1J7YHNeIVw0KGAbgwdgpjjHYMB0QEORzkMl9wvhnV22lVJeDywi4kNVZzDVW7j7t2WYnoYGFKm4V39qquCQXsWoYBtidmZ2G
X-Gm-Message-State: AOJu0YzOf3uNhiEuI7l7hR14a6JMquY0fRIMJq4iMLfFFAXvAMR2BN5l
	oMA5n0AKQG1rpkcwh+xx3u0zI3azqHp1/+EZh5hIDb4epskX/HR+gnTd3oMI06OveqlYraaMqUH
	UxX0=
X-Google-Smtp-Source: AGHT+IH9Po4S7zSdF+PAgblHA4vhd4X35mwBM0ndJYesLaZ8jMkEdvD3pz+xcLzEWjeQdxEpDh/97w==
X-Received: by 2002:a05:600c:5103:b0:416:b4c9:db2e with SMTP id o3-20020a05600c510300b00416b4c9db2emr913040wms.3.1712673581264;
        Tue, 09 Apr 2024 07:39:41 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:322c:7eda:35fd:4614])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d638c000000b003432ffc3aeasm11594008wru.56.2024.04.09.07.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 07:39:40 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH riscv/fixes] riscv: hwprobe: fix invalid sign extension for RISCV_HWPROBE_EXT_ZVFHMIN
Date: Tue,  9 Apr 2024 16:38:37 +0200
Message-ID: <20240409143839.558784-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current definition yields a negative 32bits signed value which
result in a mask with is obviously incorrect. Replace it by using a
1ULL bit shift value to obtain a single set bit mask.

Fixes: 5dadda5e6a59 ("riscv: hwprobe: export Zvfh[min] ISA extensions")
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/uapi/asm/hwprobe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 9f2a8e3ff204..2902f68dc913 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -54,7 +54,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZFHMIN	(1 << 28)
 #define		RISCV_HWPROBE_EXT_ZIHINTNTL	(1 << 29)
 #define		RISCV_HWPROBE_EXT_ZVFH		(1 << 30)
-#define		RISCV_HWPROBE_EXT_ZVFHMIN	(1 << 31)
+#define		RISCV_HWPROBE_EXT_ZVFHMIN	(1ULL << 31)
 #define		RISCV_HWPROBE_EXT_ZFA		(1ULL << 32)
 #define		RISCV_HWPROBE_EXT_ZTSO		(1ULL << 33)
 #define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
-- 
2.43.0


