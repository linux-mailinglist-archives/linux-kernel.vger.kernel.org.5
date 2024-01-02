Return-Path: <linux-kernel+bounces-14507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA28821E0D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC2A1F22DFA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6732314AAA;
	Tue,  2 Jan 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpjT9yYl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7871914A92
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso1884001a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 06:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704207010; x=1704811810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvEmLr+UaTr62j3UG+52tMfBhddUI6/cULZMLMKbxpo=;
        b=IpjT9yYl6bKZX6tRvqhFWK/37Jm7ejB4R0mFwTe+r1zBExaVCHU6YoX5wSrlh13frC
         u9jGyWwT1QZFv+LiLhaAOgQvlZutpAKLUITlpyx32FbTdGXk9JADZz4FoGahz4Fno+53
         Lpr0dsRWJtYeRB57KNWCg0oO8lJqda5xlEadFCxHlOuZElNuJ1cTlMXT1oS8QT6FTmDS
         yojeRyMDXnb1iNU9kK8+vIcuSl/VZ0c4ikIqpx1fm775jWK5w9DkJRYwJ7YI+kPxHyOV
         AHfeaIJ4c7ECBOZtS36a0kx0u09ifeRzD9iH33Ty5qheohjyMfToDyC2IxXHBlyGX8gt
         O/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704207010; x=1704811810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvEmLr+UaTr62j3UG+52tMfBhddUI6/cULZMLMKbxpo=;
        b=W2QFIVwG30ueJ0IJnNd0tyN5A0ARD70WxFTwoLUYAOAcAFwnoW+vUDcF/BnISBME03
         nWsNOA8FRdMlK96cY06bNsamx5YZR6QqfHWmNC29s9j5HfqNeEGZrQrMoFnYmtqydlf3
         o7xhk7jXZPFGAen9rOHL/LEhatBhrKDGItKvzlww5+smRVIcFJZVBYtxNEJVammpsv8G
         8w1ImUCxhmcqyE2i1cGX6BI1uCxizooOAWlQ+aM4lqBXcSGQHKEA/rqBdvHrON/MLqo2
         KDC09Z/OduIfimGT2kq3xNFmXNandWT3+4Kn1hWgNen4702GbCA9YltCjrNw0DWNIvex
         wA5Q==
X-Gm-Message-State: AOJu0YywLfGicw8+lqBPT9Ry+o34Dvba7CXgaGmDU29ujZRM8axzA0S8
	7CCKyTtfWp7pMnG37mTQLUqcc5l0uNqffg==
X-Google-Smtp-Source: AGHT+IFNmn5V6rq7TK2Nmxo31rOyhLq839u1k8G5xOyK4HuBoRPhSjdEBFSmj7nj+1BJk9QdvNEOGw==
X-Received: by 2002:a05:6a20:37a5:b0:197:22c2:2c3 with SMTP id q37-20020a056a2037a500b0019722c202c3mr783310pze.38.1704207010538;
        Tue, 02 Jan 2024 06:50:10 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a005300b0028be216595csm25836878pjb.4.2024.01.02.06.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:50:10 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Takashi Iwai <tiwai@suse.de>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH v2 1/3] x86/crash: remove the unused image parameter from prepare_elf_headers()
Date: Tue,  2 Jan 2024 22:49:03 +0800
Message-ID: <20240102144905.110047-2-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102144905.110047-1-ytcoode@gmail.com>
References: <20240102144905.110047-1-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The image parameter is no longer in use, remove it. Also, tidy up the code
formatting.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c92d88680dbf..792231a56d11 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -198,8 +198,8 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 }
 
 /* Prepare elf headers. Return addr and size */
-static int prepare_elf_headers(struct kimage *image, void **addr,
-					unsigned long *sz, unsigned long *nr_mem_ranges)
+static int prepare_elf_headers(void **addr, unsigned long *sz,
+			       unsigned long *nr_mem_ranges)
 {
 	struct crash_mem *cmem;
 	int ret;
@@ -221,7 +221,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	*nr_mem_ranges = cmem->nr_ranges;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret = crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
@@ -349,7 +349,7 @@ int crash_load_segments(struct kimage *image)
 				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/* Prepare elf headers and add a segment */
-	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz, &pnum);
+	ret = prepare_elf_headers(&kbuf.buffer, &kbuf.bufsz, &pnum);
 	if (ret)
 		return ret;
 
@@ -452,7 +452,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
 	 * memory resources.
 	 */
-	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
+	if (prepare_elf_headers(&elfbuf, &elfsz, &nr_mem_ranges)) {
 		pr_err("unable to create new elfcorehdr");
 		goto out;
 	}
-- 
2.43.0


