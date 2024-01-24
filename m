Return-Path: <linux-kernel+bounces-36821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C723183A759
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8082C28D32F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E2C1B5A0;
	Wed, 24 Jan 2024 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLSjG8AI"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985EB1119C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706093903; cv=none; b=aPDZKTO9kMiqNuxiTKXg4zf782Oh6y29Pa9GCzPfCtC4b4mS0aLZhHHfWkdqThWGu737t8WLJRW05w1o6ZjvTz1gYAjQSt01OQZXLWgPtnBeHh1fgRxHUJpYw4pYYE7p1nM13WQMKVyx6peK/jOFNxAVFUeN7t4qId7i6SWt5zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706093903; c=relaxed/simple;
	bh=wOa1a15URAxU8n05sFB6jneNgvxjEAxEfI+1gpcKVHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tExNfytaLBFlPOeE81gGy/+XHrLsIo+0meDuxyUfDFFlqot3Se3OgW+3IYcEdJR4Hshjp5q4rc/jkOHrl86Lr4/sptdoUkrZaZCRpW3DgadnogD2P0ZjWS5eUzoVFX3iJ0bwRtQaoJT30ikf2aI8Jr6i/UxYxLFAKdSWb3xtw9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLSjG8AI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3106f5aac8so88388166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706093900; x=1706698700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ev+MvDWxtLh9tCM9Z9MMVPgHcCFJtvGcjwdf7MijC/Y=;
        b=eLSjG8AIJITQb05QAftDulO2tRZqhwgic4zqDMmqcTWEfxoOrMLZA85HAsOp7fhFzR
         zwcnP1x0eHDFTUu7Uq82NM/+y3sKkLURv1nDxFRgbKHjLIp6KT94BTDEbBlh980Oenxi
         GDyJ/1+aVwRRwDf6eCBniokvu/OwpcWO4uAftNxavLg1LOesYo+MupbdFCp4EbMYdgds
         /xgGTxVXfNmXbSvT7r5RTvKEUv+3jbTaZfbzRnyJxH9QjWxIC3/SCoWpfwFNp1fWw9Pp
         +sJNAwTFMxUGC2ijSWq3WtaqtGwBv0eoVEcSMhovvhNcySGace7kogkSlX1azqQw+6Sc
         Lb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706093900; x=1706698700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ev+MvDWxtLh9tCM9Z9MMVPgHcCFJtvGcjwdf7MijC/Y=;
        b=lt1FWt92QcAPW4gdCp6zoQT5x1xYTFSh1FkbaDj7+x9bXY/Z/ftUFoPc6BvH5Bg0mX
         /mgZjkzVxiglgaVecJvYpl8Ul1P//SeLbmwGkaTd+K67WZ/bxFWUfvu2+jTIr08srxwe
         IQnEd6IHtAJw5JQvQAli/mIaBZlOyusqyaTQ0VTzZem3Q9esMcUpUUSvjiG7Dk52Al8M
         UJXHhLvU/ggFCye0Qrp+0G2tairUDZdlstlgoBgd7MVZWffznIZZNfNhh3oiYocKfYCo
         /E9c6bv6xutAbD3lIqRQs45Fb3USBZjlRcOYVnRfjajXTu6quX8YChP6hjPU8/05vezT
         q+vQ==
X-Gm-Message-State: AOJu0YyM2hWtjGt7LZUuPHMn8mnJdeFVpYpEQ19yne6RAV7jsjW3avAO
	Uvl5n20eoN1O7O56o53YU03LV6CLe4IUWjw351rHspeo+Szy/RqZ
X-Google-Smtp-Source: AGHT+IHPPN5EBz4nG4cvQ6syyC4Ac3R7lnIXDl67kwZ2kp+L6y9SZN6cJmxn9qgxzF5QW2DciYp3lQ==
X-Received: by 2002:a17:907:c243:b0:a2d:a6b7:cce with SMTP id tj3-20020a170907c24300b00a2da6b70ccemr973001ejc.122.1706093899520;
        Wed, 24 Jan 2024 02:58:19 -0800 (PST)
Received: from localhost.si (84-255-245-182.static.t-2.net. [84.255.245.182])
        by smtp.gmail.com with ESMTPSA id tj3-20020a170907c24300b00a310f2b4b91sm646377ejc.48.2024.01.24.02.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 02:58:19 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/asm: Implement local_xchg using CMPXCHG without lock prefix
Date: Wed, 24 Jan 2024 11:58:16 +0100
Message-Id: <20240124105816.612670-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement local_xchg using CMPXCHG instruction without lock prefix.
XCHG is expensive due to the implied lock prefix.  The processor
cannot prefetch cachelines if XCHG is used.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/local.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/local.h b/arch/x86/include/asm/local.h
index 73dba8b94443..f9af6908aa2f 100644
--- a/arch/x86/include/asm/local.h
+++ b/arch/x86/include/asm/local.h
@@ -131,8 +131,20 @@ static inline bool local_try_cmpxchg(local_t *l, long *old, long new)
 				 (typeof(l->a.counter) *) old, new);
 }
 
-/* Always has a lock prefix */
-#define local_xchg(l, n) (xchg(&((l)->a.counter), (n)))
+/*
+ * Implement local_xchg using CMPXCHG instruction without lock prefix.
+ * XCHG is expensive due to the implied lock prefix.  The processor
+ * cannot prefetch cachelines if XCHG is used.
+ */
+static __always_inline long
+local_xchg(local_t *l, long n)
+{
+	long c = local_read(l);
+
+	do { } while (!local_try_cmpxchg(l, &c, n));
+
+	return c;
+}
 
 /**
  * local_add_unless - add unless the number is already a given value
-- 
2.31.1


