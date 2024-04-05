Return-Path: <linux-kernel+bounces-132658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4F68997E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD28D1C21040
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF51A15EFDB;
	Fri,  5 Apr 2024 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaprvcCt"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A015EFA3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306027; cv=none; b=utnG+wsT5zz8c5HTy47rp28/1zAAZQspdFUsoF9UFVDELJXFhhid3er8PwHAje10b1o5WeDolzhBPg6sumKMBYCayxfMG2J3mRfEQrWMmDwGIoz6GycZ3DeZI9sK07kIp9gIP2yogp1NVtRWWhHGAcroTpV97db74UzBq9ekqjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306027; c=relaxed/simple;
	bh=uSs3vQDQdyugqG4s1lMSgYhJIT3pNYdW7ZqIjWSeERE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FrP0nk0jbHgWcTB8E0sgU6+OMA5bpiLtrrmPrhhuF1Ri3BbWAJs1d0on5u0SbNif4OACxww2v+0ngqjrP70MLQUPS6i/KphK7YTrs2JxUg+vXw7vlYuVP+k7XKUOEIgucS7vKRXS3zCLENiJPR9oOAFz7XzQdzeGEQQEVsJoB/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaprvcCt; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a51a701bc21so36749666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 01:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712306024; x=1712910824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UbtbyNCk6KsAiwat1danRvLj4rWxtebP2css0h/SV0s=;
        b=ZaprvcCt3O9cMoxNV5yFoEc1SUZiMmlV32z2xWXxapoaBAwFUz2eCbWpDMOmC70QB9
         TNP6rgFgsIyrL5mgdAxM64uHxnESyaskVQ2U0bsRXLQa8a8gpW1HPPk3sHrdaSdZYm7f
         ASc0r202O9zKmJErFpYxcuQnlHqD7ahBkh7R5ell8DE7Lhzb8NA8sWTJWjT+pz+jT2vq
         i2YBVO60x4DVl3QAlVzCuFk5PsJsKNDKlCuDIiS7jSnb26U3o4xgoJTGxDIH82g27o5h
         mXCno+GvJH35dnxhlEhfkw6Nh4IyfbFN2D469+4apORhSjelbzh2AL6evMwC7Mr2+AJt
         FSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712306024; x=1712910824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbtbyNCk6KsAiwat1danRvLj4rWxtebP2css0h/SV0s=;
        b=MpbqCWtk479b7XuRutj5SJPEPOtsjc93sxvk0TdM+lacBP+Ddcy6ZRcwvyq9pCSBHr
         vzxEsAg+VV9kszW40QnyO8yH3tPAQOPSNaBjq8Qh+0CICmFGRVUmVsWM9bDsDrwXaKjY
         Cp+rgECinSWVBXQCcKuePTGnIeGXA6aFjmkj7xu5K56QN6yqNERmMrmfUTtaQStms2Qx
         bHll6bMF7e5SF88D7bXpj7yFZd+S/QQBlBhhBzBZrba7KnmVKCEAl8TzVCwtXSw0LVgF
         pMcdYgjMbWTfB3gkTNtmi/ANxE0jkC/yXvbRkxRvOjfjYKaG4bJF+0by7HYF3fUGzrbO
         l/Sw==
X-Forwarded-Encrypted: i=1; AJvYcCW870O8rgTuFsHKwrIUxPMYHCwgARlh7mjsuXVdIX79hR1xls1Q+Q8/6yQCMQzpbK64PVYiJLIzSm64xA+ARlsL79ZYRaTQzpuLEnGj
X-Gm-Message-State: AOJu0YwLz1g/RmDGFffTUQMYc7ndsbb/Ybs1xrDAPHiLgsy6CtTv0+tP
	WY0tEFjlU2ltk7fOQCfkpkmsBvT6XGd4k4tzfo5zb1NI502rnWgu
X-Google-Smtp-Source: AGHT+IEK1RsegEAenrgJrW4WSZu/82Cct3JgprPhVKTKLSfyVFRJ6BM5Hhiuzqsr/VHp0OUWzyXEIw==
X-Received: by 2002:a17:906:c102:b0:a51:abb0:a8a1 with SMTP id do2-20020a170906c10200b00a51abb0a8a1mr221604ejc.54.1712306023519;
        Fri, 05 Apr 2024 01:33:43 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id g15-20020a170906198f00b00a4e2bf2f743sm569629ejd.184.2024.04.05.01.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 01:33:42 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: xen-devel@lists.xenproject.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] locking/x86/xen: Use try_cmpxchg() in xen_alloc_p2m_entry()
Date: Fri,  5 Apr 2024 10:32:53 +0200
Message-ID: <20240405083335.507471-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use try_cmpxchg() instead of cmpxchg(*ptr, old, new) == old.

The x86 CMPXCHG instruction returns success in the ZF flag,
so this change saves a compare after CMPXCHG.

Also, try_cmpxchg() implicitly assigns old *ptr value to "old"
when CMPXCHG fails. There is no need to explicitly assign
old *ptr value to the temporary, which can simplify the
surrounding source code.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/xen/p2m.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index 9bdc3b656b2c..99918beccd80 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -555,7 +555,6 @@ int xen_alloc_p2m_entry(unsigned long pfn)
 			/* Separately check the mid mfn level */
 			unsigned long missing_mfn;
 			unsigned long mid_mfn_mfn;
-			unsigned long old_mfn;
 
 			mid_mfn = alloc_p2m_page();
 			if (!mid_mfn)
@@ -565,12 +564,12 @@ int xen_alloc_p2m_entry(unsigned long pfn)
 
 			missing_mfn = virt_to_mfn(p2m_mid_missing_mfn);
 			mid_mfn_mfn = virt_to_mfn(mid_mfn);
-			old_mfn = cmpxchg(top_mfn_p, missing_mfn, mid_mfn_mfn);
-			if (old_mfn != missing_mfn) {
-				free_p2m_page(mid_mfn);
-				mid_mfn = mfn_to_virt(old_mfn);
-			} else {
+			/* try_cmpxchg() updates missing_mfn on failure. */
+			if (try_cmpxchg(top_mfn_p, &missing_mfn, mid_mfn_mfn)) {
 				p2m_top_mfn_p[topidx] = mid_mfn;
+			} else {
+				free_p2m_page(mid_mfn);
+				mid_mfn = mfn_to_virt(missing_mfn);
 			}
 		}
 	} else {
-- 
2.44.0


