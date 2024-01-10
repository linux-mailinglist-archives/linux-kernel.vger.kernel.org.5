Return-Path: <linux-kernel+bounces-21776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7927F82941A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275E028838C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A0F3DB85;
	Wed, 10 Jan 2024 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dg+Yxi/0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92B43C46A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704870942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIMuati7cTP1ekV5ZbT9f3EKmgfJPaZbTXabrZEOoZs=;
	b=Dg+Yxi/06TuSt2mOWoR+U+FuLjCwmJcKyuk+p7yCBRJlzP+gYO8B8fjfGGVOuOKrIw2U7W
	0ut7b2KPu1/ETwzv9JvzgCvhSb0lZpvnVy8NKct0GXpgkh2/5+I4q4T7vGPIElGTU/zf/J
	5YHIWHYaW9vssqVkPRSm32W4ttZwQoU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-Vj_YWPS1NXGPaUOF6IRDww-1; Wed, 10 Jan 2024 02:15:41 -0500
X-MC-Unique: Vj_YWPS1NXGPaUOF6IRDww-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3bbf47262ccso4677241b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 23:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704870941; x=1705475741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIMuati7cTP1ekV5ZbT9f3EKmgfJPaZbTXabrZEOoZs=;
        b=wkpwOtjhU5n9U2nuPKWc3nhUdEQl93FeqDSRGPrD1BdrsiDnea7UrJ8Nk4uZDV/Jql
         aMDY7e8Ms4s6EE93Ike67St+T8kbynUjs50PZtFXq4ofeB9YK4E+X+eSTAzuOQuC9FI5
         s+7gLRzMuU8nOcNEdHod3d/KqPe3VUTnCg1u7C0ziuUg34hsVPhpw2Gsh6G1ss4ZnXgg
         lr5jVJegl/BvYZ9ZPsulh3HUXBwRkuUyeKAVRWtjdHbewOMZiGAwbooalXYf/nPjbt29
         5/k3G3KgnOzMWO5cNRpyHWdoNOlK05g0EyaAaE/dr4E/cCWkx7cqCGUqFekvuO50oGwo
         +sXw==
X-Gm-Message-State: AOJu0YwSiDSJjxSfwVnp3sj8gSM6JuWHaQUKmYwrem5wb79b0aJLmQHy
	yl5v/iLsQduZeBliDNTUNW56VmaOQ0Mr/UxZoiApHzw6USIN0K1EnblP48Xt13Rz+p1QwNUPasA
	CURajqakj+7Xufh9f0ejOQ9U837Tm87jW
X-Received: by 2002:a05:6358:1aaf:b0:170:efd3:2d03 with SMTP id gm47-20020a0563581aaf00b00170efd32d03mr362969rwb.24.1704870940766;
        Tue, 09 Jan 2024 23:15:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJcFUBjKVUIJPEhGlRkafdWTlR6G4YnJSwKhOQCYafVe4/F9qJkNxmR+QYOhfzYVY6ABRGog==
X-Received: by 2002:a05:6358:1aaf:b0:170:efd3:2d03 with SMTP id gm47-20020a0563581aaf00b00170efd32d03mr362951rwb.24.1704870940380;
        Tue, 09 Jan 2024 23:15:40 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090ac10e00b0028d0c8c9d37sm751199pjt.22.2024.01.09.23.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:15:40 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 4/5] x86/crash: pass the dm crypt key to kdump kernel
Date: Wed, 10 Jan 2024 15:15:19 +0800
Message-ID: <20240110071522.1308935-5-coxu@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110071522.1308935-1-coxu@redhat.com>
References: <20240110071522.1308935-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1st kernel will build up the kernel command parameter dmcryptkey as
similar to elfcorehdr to pass the memory address of the stored info of
dm crypt key to kdump kernel.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/crash.c           | 15 ++++++++++++++-
 arch/x86/kernel/kexec-bzimage64.c |  7 +++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c92d88680dbf..69e1090f01bc 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -262,6 +262,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 				 unsigned long long mend)
 {
 	unsigned long start, end;
+	int r;
 
 	cmem->ranges[0].start = mstart;
 	cmem->ranges[0].end = mend;
@@ -270,7 +271,19 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 	/* Exclude elf header region */
 	start = image->elf_load_addr;
 	end = start + image->elf_headers_sz - 1;
-	return crash_exclude_mem_range(cmem, start, end);
+	r = crash_exclude_mem_range(cmem, start, end);
+
+	if (r)
+		return r;
+
+	/* Exclude dm crypt key region */
+	if (image->dm_crypt_key_addr) {
+		start = image->dm_crypt_key_addr;
+		end = start + image->dm_crypt_key_sz - 1;
+		return crash_exclude_mem_range(cmem, start, end);
+	}
+
+	return r;
 }
 
 /* Prepare memory map for crash dump kernel */
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index a61c12c01270..6e8adfe0b417 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -76,6 +76,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
 	if (image->type == KEXEC_TYPE_CRASH) {
 		len = sprintf(cmdline_ptr,
 			"elfcorehdr=0x%lx ", image->elf_load_addr);
+
+		if (image->dm_crypt_key_addr != 0)
+			len += sprintf(cmdline_ptr + len,
+					"dmcryptkey=0x%lx ", image->dm_crypt_key_addr);
 	}
 	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
 	cmdline_len += len;
@@ -433,6 +437,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		ret = crash_load_segments(image);
 		if (ret)
 			return ERR_PTR(ret);
+		ret = crash_load_dm_crypt_key(image);
+		if (ret)
+			pr_debug("Either no dm crypt key or error to retrieve the dm crypt key\n");
 	}
 
 	/*
-- 
2.43.0


