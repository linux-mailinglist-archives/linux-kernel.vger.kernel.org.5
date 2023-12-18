Return-Path: <linux-kernel+bounces-3143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF2E8167EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D6B282DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C20310795;
	Mon, 18 Dec 2023 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzXmsz00"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2883D101C2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cd870422c8so150678a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 00:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702887610; x=1703492410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGXJfJUC6+i72m0QAwIpuYVASGrOzqEaIU/ssLgkxys=;
        b=QzXmsz00IbtbrMT/EePyvRpumxd/aCtyrwZurD0InPTjCV5Cs4P9a8C908EP1bJZxU
         SR7rzyeqMtmoZP/a6sZTpOEenIt9CLJzW6z+4w0EkSKWWzD+MqeIpafXcRL+ozBQH+Tm
         7CfPmHWAJRFlaO9rrEu/QTQBY+zaNPvUiA9BThyU6MJuDQ1NKHaXBM/uH30To6rknOpH
         02HFiQWwKrnQLXckyP92POSBhdgJjkDG2Ui/K2UaQLAWVfY4KvFmE1xXbFWWA4R9Cw5j
         38rkg5ElM6WDDEu0X6amg0ja7jYIt6Z80KPZlTyvSNLgCz2Sl/iRxyRMQ9HMsFDeVe2u
         OJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702887610; x=1703492410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGXJfJUC6+i72m0QAwIpuYVASGrOzqEaIU/ssLgkxys=;
        b=CP1GJSIh4Zof6fIwmsFQ14QWUpVFDz1UTfOPxhwE27nWzKbCV9Xh4M7iWX8W36uEhJ
         5Vvv8nVUGN+IHPWOxZ10a8bhD3SaRHRmHlzbknSaJ1JCeAkY1jE8nPQdEPJufRuggK4l
         4/W5uUzilmSCJcQpaUDAsAPLEqmvtR9GeGZzCpG0OSk3gfw602xb/IwwR48XLhM/EUmY
         7v7/6ntGR1mouV9VcVFPew3jsU+5twmw032AQeRnCuo2FAu+E45OsPyCDwlqxC1DTiA5
         MnWgZIeVls4rcUaMv4ckkg8CJMTAeDm4XOV0EAej7mrjb9+/ujfNCE12PKr+I+nrxDRT
         Fgiw==
X-Gm-Message-State: AOJu0YxD0IAKgL/SOD5ilf/3z5qykUvEWjKLJRmVExh8EeaFNk7LTt3m
	JdCnyF+mMrayBP2SRlivaEY6E1SzJrA=
X-Google-Smtp-Source: AGHT+IEKvVYdPp68O5SMLi09JSS6ZiB8EJPj5nr/rrg/BFpl7pNHLPjglrvlKg1U1yk+zb4Au0xJjA==
X-Received: by 2002:a05:6a21:627:b0:190:354d:f90f with SMTP id ll39-20020a056a21062700b00190354df90fmr7340264pzb.117.1702887610090;
        Mon, 18 Dec 2023 00:20:10 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902704200b001d06b63bb98sm18426954plt.71.2023.12.18.00.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 00:20:09 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Takashi Iwai <tiwai@suse.de>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 1/2] x86/crash: fix potential cmem->ranges array overflow
Date: Mon, 18 Dec 2023 16:19:14 +0800
Message-ID: <20231218081915.24120-2-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218081915.24120-1-ytcoode@gmail.com>
References: <20231218081915.24120-1-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The max_nr_ranges field of cmem allocated in crash_setup_memmap_entries()
is not initialized, its default value is 0.

When elfcorehdr is allocated from the middle of crashk_res due to any
potential reason, that is, `image->elf_load_addr > crashk_res.start &&
image->elf_load_addr + image->elf_headers_sz - 1 < crashk_res.end`,
executing memmap_exclude_ranges() will cause a range split to occur in
crash_exclude_mem_range(), which eventually leads to an overflow of the
cmem->ranges array.

Set cmem->max_nr_ranges to 1 to make crash_exclude_mem_range() return
-ENOMEM instead of causing cmem->ranges array overflow even when a split
happens.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/kernel/crash.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c92d88680dbf..3be46f4b441e 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -282,10 +282,6 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	struct crash_memmap_data cmd;
 	struct crash_mem *cmem;
 
-	cmem = vzalloc(struct_size(cmem, ranges, 1));
-	if (!cmem)
-		return -ENOMEM;
-
 	memset(&cmd, 0, sizeof(struct crash_memmap_data));
 	cmd.params = params;
 
@@ -321,6 +317,11 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	}
 
 	/* Exclude some ranges from crashk_res and add rest to memmap */
+	cmem = vzalloc(struct_size(cmem, ranges, 1));
+	if (!cmem)
+		return -ENOMEM;
+	cmem->max_nr_ranges = 1;
+
 	ret = memmap_exclude_ranges(image, cmem, crashk_res.start, crashk_res.end);
 	if (ret)
 		goto out;
-- 
2.43.0


