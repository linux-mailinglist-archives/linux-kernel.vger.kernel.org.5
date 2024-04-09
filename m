Return-Path: <linux-kernel+bounces-137262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077D289DFFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57F16B353C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BD613D520;
	Tue,  9 Apr 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="vJJQ40nB"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E8A139D0D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677632; cv=none; b=lup4kFPUKMLqu5uMMJqIBIyQ5ZSuJhr5ZjQ+MfPrfnuJqu/QRXfJaN23yJGYO8ypSddOKth2VG0CoXRhoVvQPESf24pIQhK5VVzHaK7KKCI8/x0uTk9edHDu/cWycfaR9PkPu6ARF+kiPCUoVyYvfQ4exYJHJquvI5lpNtOb3jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677632; c=relaxed/simple;
	bh=kjJfIRkcWjD4d/a8pBP5UFxEbKD7w/PFPgvdNrBqNOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M/SFUxGfHEPBpVSghCAGwQxbkDUYh2m7VH/eUpcU9AwOtoUN10HE9BvvRFWhjvl5APOkCH6j5HRSBYLOWxzG8ih77EBj1exGkSl0rwepxMecKh4RVKvyAJZx69gvYIUUUbnulUWr3o16yrLiZZqxcaxRtv2+ZAIutrCCGv8a9Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=vJJQ40nB; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso8061295a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712677628; x=1713282428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4203k0MNU0Fkt9KNemdvsHXqtx/8jnD0MSO6/g9ASP8=;
        b=vJJQ40nBwXSM0563d+h2sICVkvf/ZKTykmtMukj+6+8ODli98r4bJsqLEepr+KTz03
         8yFRtGUr7XcWMC2IaWBrJCEWtFjKmv9lT0uVUpGjSgjx4hzwn1EFkckTe1g+8sqGRrJr
         5wsSpVGeXN1vjVTTmbckq0NogU3d3aFpMiwAQP1a+cPMOWUtct1Az9GdrmTNbU593PXI
         sD8ICxCPmyDD2p0cIvfO6r4ShtztwH3k30kMGVSkvvJiIiFsEcdfEhrYkoQCF1b144Qt
         ujROY6/ugZWyo7tvvdf1RmWIkV7JfQkDOd4d/a/2Zve2yQDaBb4R0y9+zbVJ4lWTCxOC
         xI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712677628; x=1713282428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4203k0MNU0Fkt9KNemdvsHXqtx/8jnD0MSO6/g9ASP8=;
        b=tiDUlK/puFoa+aLeQPnvYFYSPWLsdEO3JghsgDd3vy8iFhuMFvXo5l+wo+aDcYZvd5
         FbNa5UKFwA9YXKd6rQDNL4e5n1qV7E43jkCtpTRiqCCJVVPitLJ71zEQLCTHNEqdNfqs
         w76vWJmgQgYR2BxBLM3hxN5+lhLlQqMmY3XJ5BIJlDDKqF++mXi+jNhjkMYgquyI4n3b
         rTYz7oBnxihbZ8isrhYZBUPrNxfVmdq9gKreIE+HecHqrsAi1J3eq9rcVw7XeFl6/wsY
         JvD5OeRQq+kyf1ZKB7U9XZY4wGhvsshtuXSb+rZD+4Wld7OtP63w3XHQAvJIaGJGykuT
         zOeg==
X-Forwarded-Encrypted: i=1; AJvYcCUu5pR3JZOgEuRsQqJUYdcLrds0S4ONUd9cx7LRS/mJEQG5V+eXW9QLd2WXg6/Z/Lp/42+LJYvSb0lrbAjQm95xOap1nvbkldcBt5ov
X-Gm-Message-State: AOJu0YzgjsP62XYjrTvsfS/tACQfrHlwP60rtL6tTm1VLkbxbAEU2uGy
	z0Dj8Hj2rs0IWj+TlqE5tiakhNKgKUSUUP4xQEL7J++UDnkAQj5zhjlKAV2biaM=
X-Google-Smtp-Source: AGHT+IEl+n0rpgPm8cfDPldPrbHhnQWaxn0ZzPLoB5/WAvh5CKYozK0O5M/N9gg8TNXebyyMOttA3g==
X-Received: by 2002:a50:c056:0:b0:565:6c72:40a9 with SMTP id u22-20020a50c056000000b005656c7240a9mr9158168edd.28.1712677627742;
        Tue, 09 Apr 2024 08:47:07 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id 12-20020a0564021f4c00b0056e62c8e3bcsm2415595edz.54.2024.04.09.08.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:47:07 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] compiler.h: Add missing quote in macro comment
Date: Tue,  9 Apr 2024 17:46:23 +0200
Message-ID: <20240409154622.292163-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a missing doublequote in the __is_constexpr() macro comment.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index c00cc6c0878a..8c252e073bd8 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -268,7 +268,7 @@ static inline void *offset_to_ptr(const int *off)
  *   - When one operand is a null pointer constant (i.e. when x is an integer
  *     constant expression) and the other is an object pointer (i.e. our
  *     third operand), the conditional operator returns the type of the
- *     object pointer operand (i.e. "int *). Here, within the sizeof(), we
+ *     object pointer operand (i.e. "int *"). Here, within the sizeof(), we
  *     would then get:
  *       sizeof(*((int *)(...))  == sizeof(int)  == 4
  *   - When one operand is a void pointer (i.e. when x is not an integer
-- 
2.44.0


