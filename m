Return-Path: <linux-kernel+bounces-163371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E10168B6A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7405428327C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7021772D;
	Tue, 30 Apr 2024 05:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMQwkc9m"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03917582
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456160; cv=none; b=TwaRkJolah9KDPPrd9FVLURWumTtYPmv0vUKbjqgB2zO+vHBXClz0mRMaPIUnREKfSeHn1eq/5Z8JKkff0XWSkGg5PmK3mjJ6w6UfxMYjKJZ89R+4lObfv9fsi5O3syVzKiN4GVBv7n/6O9rUhH2+JGNr5Hf0LPLGMWhxjkPmJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456160; c=relaxed/simple;
	bh=PKavDLHA7akrSiYv3ddEc5JsYq3c/1MGnBbU+XVGTK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YOROElmOHVt68SNImjwschS+pB4pSNpTGqg+31W1MYOlitDCOcMvQTWrLVQqPmtCXbzvZlFI4Raizqc9H2DqwhkxTP0ZHNeTtofaqDxYffYW41R9V4RJhWW4yF1PAV+cfmsqU1xXoW+3RgpESBPe9Lqcc8YTTSEtxhlyWvU1lyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMQwkc9m; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2af37c18c10so1286387a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714456158; x=1715060958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dpy361oIB3q72pLwZ2bKiieKmkru5Dup93g/6xzldv0=;
        b=lMQwkc9mgF56kMCo3ZR26n6TEbpPf/ZJiZCDB7QGn2VAmM+JxPW9HX7w/DZE1Lxi/o
         m+WbPsBU/HO86u1/gIs5kY0sry+uWaurDXxSbWAw5Tb3FC37Z0AYCB7T2KGKI593kPqE
         ObdF1S7jKQb6gvlibUEmh/ou6ifU9Y0YnZhFASp5V2Wh3lLoGikrTK1GpYudddig6JcU
         nstj/hfnJG1i9chTYtd4rTyAf4Vc05WTc2COVbJuEFqhRglTAxgY+Yx6PfUr4lCsmcGT
         iG5IW3Fh8tiPpCJuWb7EcuyNqozX4TlBsqa62ISHv6F1IMijapZzu9BM3tZVsUtve5qU
         DZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714456158; x=1715060958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dpy361oIB3q72pLwZ2bKiieKmkru5Dup93g/6xzldv0=;
        b=aNPKt0j2qS2LtX/OxCyuhNOYkp2rxbuk98i1MqPcSkdwMXDPRuwLj2GDp2g3VVzo+2
         bnKPpuPZVflbJIsl9zeW9R4Fyuef0rZSZgamk86lJ9zs2u/VD8gwFyj5vad184BGnwC3
         5OVC2vhMF3UTNvZazmYdmmuxpPukh10HVaK2sJYhA1Kz/qfhyai8kiuLy0ba+aNAfZfR
         sR/6Tl2VNsJC65w02peYAWA76W83nwcaGX096G9gIDKeIYDJ5ah6W096Q9nsIMILaa2D
         Q+ofDQ/oqX4WHzYqQwTQMSSmsMxW7TydFtQPbaYUY6BhtNqMtBcxtle26IMKw/M1xztZ
         c0DA==
X-Forwarded-Encrypted: i=1; AJvYcCXDBamZRdiFJ0pljJo5KN6ScLtXQPZbzyIFGvt0k2QwToJ9bGWqOWnyR0X73e9PfiyOB97PuOkM0ntFNw+DNDPnb3LMHAG/CHv6YzZN
X-Gm-Message-State: AOJu0YxhwHYsz14KJywAXuVkRowHeGu21kMeGQNjfO5mOuYUlAFSLRhV
	iSrLg8IzF+sWHzLrMDx1UX+nMDQDzw2AEyNA5WEPe3hQIaFuHScS
X-Google-Smtp-Source: AGHT+IECS/AUeClgPUXQv2ctZBuAY39CVd5tT4ASKQev7MnMM1vBtPcx0JboiOpSdPot59rqAmAxlg==
X-Received: by 2002:a05:6a21:7894:b0:1ae:4145:a250 with SMTP id bf20-20020a056a21789400b001ae4145a250mr14891313pzc.3.1714456158066;
        Mon, 29 Apr 2024 22:49:18 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090adb4c00b0029df9355e79sm20471652pjx.13.2024.04.29.22.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 22:49:17 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 0/2] bitops: Optimize fns() for improved performance
Date: Tue, 30 Apr 2024 13:49:10 +0800
Message-Id: <20240430054912.124237-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch series optimizes the fns() function by avoiding repeated
calls to __ffs(). Additionally, tests for fns() have been added in
lib/find_bit_benchmark.c.

Changes in v2:
- Add benchmark test for fns() in lib/find_bit_benchmark.c.
- Change the loop in fns() by counting down from n to 0.
- Add find_bit benchmark result for find_nth_bit in commit message.

Link to v1: https://lkml.kernel.org/20240406235532.613696-1-visitorckw@gmail.com

Kuan-Wei Chiu (2):
  lib/find_bit_benchmark: Add benchmark test for fns()
  bitops: Optimize fns() for improved performance

 include/linux/bitops.h   | 12 +++---------
 lib/find_bit_benchmark.c | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 9 deletions(-)

-- 
2.34.1


