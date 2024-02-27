Return-Path: <linux-kernel+bounces-83988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C856686A11F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8981B24B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E479514E2C6;
	Tue, 27 Feb 2024 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Zu9frZL6"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004AC13AA36
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067023; cv=none; b=AywQ3AEc6hzwhxN7rZ6yyDDIoPTvIkxRbFau8eqB6DpcBcx0hbDGGsngcqWaMkCbirbE6RqcGvP5avRACrsQn2Dd0G1OqOZ0PWf/04YRtssIWPZ5BfvUOJvtBxoUXZYib1o8lf9DTdqXwMO2siVUrioj1WaYdMoAXLU+gH3qFZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067023; c=relaxed/simple;
	bh=V0nCT2skZgBbNraDiDIAFnZwCe6uAfIZSMhyxik40i0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lwBuT/Fl3UntF+7BlqJaZaDlfynEm51ohQXpjMqK1Apo/otFcG6DTI4r405E66xgG3+73/lEvJNZVIE40A2o0oZex0+18MtuLRzmv30c9MOy8Z5dIUdrJC0Gb2Z5D+8lFw3CD9j1SIuJISrZpe+lnc0oU3pO1Se17ZYbdA1LUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Zu9frZL6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d0a7f2424so3208295f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709067019; x=1709671819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0XHnjehPu8w7ACthUoBFkI7yFqIdEnfMFK14QBWxeOs=;
        b=Zu9frZL6Qjxu6tB6FJ/PzoFGUEC9jmX2n4OdBG/WgUAywEdPTej0HB3wau0wdfQQfI
         0XmxN/PmkXBG36WHlIUThJZjXaMPEZj60eBAjOIPCcPJgVn9WfjmMaUKJq7nMiis216i
         rW3UPXrSZH+cqXSi8PfLF7c8ppzEV/ylJbDCTjL6O8XHtqt8jFQzC/Y0f68VQVFM8gmx
         h0mDcHowQr7epO23Ybqsb37+lNJvunXORvcO4nemBHTWOHat0GsQa9YGoqS7o6rpoD11
         G8kl3kG3Q+K11lo8SLw7ZBeHJLE/Vo2VaMnKIhqvW/RMpBbfEX1ekmGvqtsNjrJTh7GO
         9cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709067019; x=1709671819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XHnjehPu8w7ACthUoBFkI7yFqIdEnfMFK14QBWxeOs=;
        b=JJ0WgVIAaSL7x7HcVTm8/IwmBKKm9jOEGo09aIM3GXuLqHYLFD7YI8HOkdu/ATxVXE
         FMzY8wtX0H2s0z6CU2EisFu5WodSzsT/2W8SmRuOY0VioZPkGG8+8EJPk8Wcw6cTC0Mh
         e3vXENTJwbg0KdRDdub/b9VQYNhD14sbKaxfGIUmEYhMQyMG+thQCk6fhTa0+0OC2zHc
         re/7Qj97xa5LB274iIYmPXlNT9KSGnQTpkmqP29Nz1Tl5JQ4uDwVTx2wRNWSfhI0pQCP
         s6+nayXRykmMXLkV/bTXkrQMsn5EJ0VVcNPmFh25lpXvpOpSiyC0TBUYb2nx+TBJXqPa
         F4Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWe7a3/+7mel8zWXF7BM4DsoQ98nmb3GAPEhBUrggVcqh8qnpqip3o5aN1XcssAm62PoS9Vlz9QYjKFUq46qH2tXFnw4vR3yrywQunb
X-Gm-Message-State: AOJu0Yx1GaM2mE0yvvCsd43S7kBUhcr7sceMBGl4kVI+5TeWHB0w1qQW
	g9DYi4Dg6nAw7P4O6aDxZzkSsa+ISvr+ml+7lomHeiqu07j/pjazZ3rZPgGqyFI=
X-Google-Smtp-Source: AGHT+IGg926H9ZvAb29YFFW84p6+A5ehuWN+jwxyTWEE7ddKRSp+9GoX1bKzBsQBX03xsQMwOehwyA==
X-Received: by 2002:a5d:6d0d:0:b0:33d:a452:2fff with SMTP id e13-20020a5d6d0d000000b0033da4522fffmr10131949wrq.11.1709067019379;
        Tue, 27 Feb 2024 12:50:19 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id u14-20020a056000038e00b0033dca6f8b44sm9763929wrf.16.2024.02.27.12.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 12:50:19 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Qinglin Pan <panqinglin2020@iscas.ac.cn>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes 0/2] NAPOT Fixes
Date: Tue, 27 Feb 2024 21:50:14 +0100
Message-Id: <20240227205016.121901-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This contains 2 fixes for NAPOT: patch 1 disables the use of NAPOT
mapping for vmalloc/vmap and patch 2 implements pte_leaf_size() to
report NAPOT size.

Alexandre Ghiti (2):
  Revert "riscv: mm: support Svnapot in huge vmap"
  riscv: Fix pte_leaf_size() for NAPOT

 arch/riscv/include/asm/pgtable.h |  4 +++
 arch/riscv/include/asm/vmalloc.h | 61 +-------------------------------
 2 files changed, 5 insertions(+), 60 deletions(-)

-- 
2.39.2


