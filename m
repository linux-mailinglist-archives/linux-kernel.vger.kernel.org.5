Return-Path: <linux-kernel+bounces-21778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB39082941C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17A11C25857
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92833F8C0;
	Wed, 10 Jan 2024 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbY/pXwc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36863EA96
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704870950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PudTy4UMKikLIiXUIiw3l2EC2dKIPcn2JPVx++F8WCw=;
	b=GbY/pXwcySk3cdIJCpO4ZMEOMvkwxxVZxGE99/GcZPAwf1AqtdVdsaeG50cAIoGwqNbjwU
	ElmLqqlOzjTr6YhR5TcxbzIDtmR2+v1tBvx1RmBSqguvBc5wIVWzB6Qxji641cgZUR9I5B
	SxtFiGfj/YoEaFmEu0K7IWxwcmYHkzo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-ATLLaRc3P7qOyehsFcR_8g-1; Wed, 10 Jan 2024 02:15:46 -0500
X-MC-Unique: ATLLaRc3P7qOyehsFcR_8g-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5ca5b61c841so1126754a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 23:15:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704870946; x=1705475746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PudTy4UMKikLIiXUIiw3l2EC2dKIPcn2JPVx++F8WCw=;
        b=fFWntteoTKWpyahbciKJDAXIRjeDyXY7o/sXJPH2R6bA58E2mv4jvmn59/mSvBAxVC
         BCtznCXUV8dU77WWn2yQMep3o3taQqWodXdDiJWJeo4y4m92BDJ0NLFHPRiYXbNkfImj
         UV5UJgHPuOvSArm3STKRV9b2PwGPmXz+4lZ0Ash8M6ZuQpdFgct7w3uLiJdmTNWmsBZ0
         ayx+CtxATw3k16M69w/63z1m/9JDe9Bx/lMWpIMMnsfKeZv2tBUpZei/fDWKe1V7DxlJ
         ghlSCUzGl1iuiVFm1YNJRkV515dFTfkcx/pZG16wOskJBQ0EQcJle9iPSpwWpv91Pc1Y
         YlNg==
X-Gm-Message-State: AOJu0YwLOE62tFl6Zy3LZZ+ZwwMwVwfaUc//UbcezttzcCFGO+nj7bIg
	mgnY9iuhtMwVWz0Vd+eezfC0nUqUjXEzb+5xGqKkb1oSPMyeoGSUjhnwFPpytNJDWCMD40P0D7G
	C0HHIZOdbo3uXKNKFHB5+mv4x8ExhQ5lX
X-Received: by 2002:a17:903:230a:b0:1d5:6b59:bc9e with SMTP id d10-20020a170903230a00b001d56b59bc9emr548214plh.113.1704870945695;
        Tue, 09 Jan 2024 23:15:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGswbCFzBG9UMiPV/9Dz8iVcTS6B/kBunqAERbzsPjXLLiiVVLr67UttS61AMPcGr+g+Ep+Yg==
X-Received: by 2002:a17:903:230a:b0:1d5:6b59:bc9e with SMTP id d10-20020a170903230a00b001d56b59bc9emr548193plh.113.1704870945323;
        Tue, 09 Jan 2024 23:15:45 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db8500b001d4c955cc00sm2906719pld.271.2024.01.09.23.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:15:45 -0800 (PST)
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
Subject: [PATCH v2 5/5] x86/crash: make the page that stores the dm crypt key inaccessible
Date: Wed, 10 Jan 2024 15:15:20 +0800
Message-ID: <20240110071522.1308935-6-coxu@redhat.com>
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

This adds an addition layer of protection for the saved copy of dm
crypt key. Trying to access the saved copy will cause page fault.

Suggested-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1a3e2c05a8a5..c9c814b934b8 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -546,14 +546,32 @@ static void kexec_mark_crashkres(bool protect)
 	kexec_mark_range(control, crashk_res.end, protect);
 }
 
+static void kexec_mark_dm_crypt_key(bool protect)
+{
+	unsigned long start_paddr, end_paddr;
+	unsigned int nr_pages;
+
+	if (kexec_crash_image->dm_crypt_key_addr) {
+		start_paddr = kexec_crash_image->dm_crypt_key_addr;
+		end_paddr = start_paddr + kexec_crash_image->dm_crypt_key_sz - 1;
+		nr_pages = (PAGE_ALIGN(end_paddr) - PAGE_ALIGN_DOWN(start_paddr))/PAGE_SIZE;
+		if (protect)
+			set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);
+		else
+			set_memory_rw((unsigned long)phys_to_virt(start_paddr), nr_pages);
+	}
+}
+
 void arch_kexec_protect_crashkres(void)
 {
 	kexec_mark_crashkres(true);
+	kexec_mark_dm_crypt_key(true);
 }
 
 void arch_kexec_unprotect_crashkres(void)
 {
 	kexec_mark_crashkres(false);
+	kexec_mark_dm_crypt_key(false);
 }
 
 /*
-- 
2.43.0


