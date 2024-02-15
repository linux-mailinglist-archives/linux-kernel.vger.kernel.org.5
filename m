Return-Path: <linux-kernel+bounces-67784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFAA8570B4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925501F22591
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E156D1419AD;
	Thu, 15 Feb 2024 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O869b/tj"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E1441A87;
	Thu, 15 Feb 2024 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037291; cv=none; b=kMi21VxkRXOCclYLqTHCL79+9t4ox8xKts0NFpaLt/5FIEPCfXWa1tlqqyCWxuERRuq13OjGiUSlmasEFKLv7nHwAgOIDnJOlantIDtU8d7LLv+PpBsqDFJHBaEmoguXRvpUY8FdcjoPNLRfmWfigAh1qcbmPF9erlPNDv4PUFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037291; c=relaxed/simple;
	bh=/kWliuY+oG1YGeiKJ1UUmE2TUPvHlC+v3vpcBhn1ISg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mD6ooGTKQmK1mtFUqoZNzNI1+ec1j20iojacZBO23W3lE24TaFcSODxCof7qrOyUV4EOJ+p/oM0hzby9aRLlhfe0QJk5euSCSXZxeAnRq1MiVMaSx6Y7Pq+09R6MJhPFQvAsQjppla3l9P/OpibB4R61E0VfTPoSpGzmpUiTmMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O869b/tj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-411de7c6b3dso10958305e9.3;
        Thu, 15 Feb 2024 14:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708037288; x=1708642088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VxZz8dpdlBG3f4JnaEViziH04upv3BIHYbzmShbS36A=;
        b=O869b/tjCbq72ocV+gFLIHARD3m86QP8X1cAkVmIVrXKVjec/40dXAzE4L5j6vpxGN
         G37E0MCo+hM5vWetQgh86794+HyvZRJ7wQ/gi5//qBD/zdgdI29wBYbH0tu1E6fhr0d5
         z+YqpI8soXl2gFK4Sor1b+9cTQLMj+9FjH+ttzgu+0p+rBLOffTNFN5Iv1/bpyqXfMW5
         kNZoBZNhJdF9WvajH4LkjMGPMfczHwpyhNbQeUyw+5FRpuGkWlnIaTNlhH3o2z96mkqd
         PK9csP/VDKfo10JJJmZYDK9RMzUJLL8L4q51EEuPW+7QCzIwZwB9qPHpahdrRAc7M36C
         X0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708037288; x=1708642088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxZz8dpdlBG3f4JnaEViziH04upv3BIHYbzmShbS36A=;
        b=ZceB4IxEmPmtPGLaGhgHLYFVpUbKjy2f8P/YiQnIq73DD9n0xLU+iOa74fzDMOmCGy
         6iyUuVl8xBNwzZOH8NKJcxxEhlyj0+LmKiPelOVmOoX4/8mPCEhFJejX47SyDxoqJBkX
         bJexhjDdoQO4s0OB3tI7XFYyejP01OBp7TYiJT40rszHoPenS+/EqY0gswJSLtrMGSx/
         hVJAtKSqT9ia0p9aCHVTovmyJk4TDeVYh5yPd4oe/glFGwJGAenUU/zoklkcwOlgmNHd
         YOVTtt89AMqUgXTamPo1uuVsEXNhMSoXUJUOYJvebrUxI1hmXH6IHOh1MiEiffM47Naf
         xADg==
X-Forwarded-Encrypted: i=1; AJvYcCUQKFolgSgY9SjwrWr0gcrS0OCfrGdyn3lrfqIn6bUkdBUvGbJspqGBxpVLDDwUzcQ0eed29pRkiwPspI5op5tJv6mumTExHLt9lbDG
X-Gm-Message-State: AOJu0Yz1IvrGjuQzTM3Nz5EpR8aHUKFIQvzS1GDOIN3gCwY/GCX9u1VX
	9xx6Do09big93SODVPAycsjpbKnwDBAy30sGR4XAJXvVJoBT36Wl
X-Google-Smtp-Source: AGHT+IEHcn7vuCmdD0vbj0K6OCuGp4jwkwobudrNE34EGoVaEDBiYwLOq3sO8rU1BKDdccJHXR7NqA==
X-Received: by 2002:a05:600c:3b28:b0:410:1d3b:3424 with SMTP id m40-20020a05600c3b2800b004101d3b3424mr2460999wms.28.1708037287695;
        Thu, 15 Feb 2024 14:48:07 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l3-20020a1c7903000000b00410b98a5c77sm442936wme.32.2024.02.15.14.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 14:48:07 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: David Airlie <airlied@redhat.com>,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] agp/amd64: remove redundant assignment to variable i
Date: Thu, 15 Feb 2024 22:48:06 +0000
Message-Id: <20240215224806.2074087-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable i is being initialized with a value that is never read,
it is being re-assigned in the next for-loop statement. The
initialization is redundant and can be removed.

Cleans up clang scan build warning:
drivers/char/agp/amd64-agp.c:336:2: warning: Value stored to 'i' is
never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/char/agp/amd64-agp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index ce8651436609..47bd3b8a54b4 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -333,7 +333,6 @@ static int cache_nbs(struct pci_dev *pdev, u32 cap_ptr)
 	if (!amd_nb_has_feature(AMD_NB_GART))
 		return -ENODEV;
 
-	i = 0;
 	for (i = 0; i < amd_nb_num(); i++) {
 		struct pci_dev *dev = node_to_amd_nb(i)->misc;
 		if (fix_northbridge(dev, pdev, cap_ptr) < 0) {
-- 
2.39.2


