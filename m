Return-Path: <linux-kernel+bounces-14508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA0E821E0E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA84F2838C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2722614F73;
	Tue,  2 Jan 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9+gvbW8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516B514F67
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28c467446f0so4159082a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 06:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704207019; x=1704811819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nx9emZL9ku/A2bkH8s+Myg+EcmBlTQ3WIwd3hli5Dao=;
        b=K9+gvbW8XwHe079jSn5gCAvnEQ2XmA19vVTdGS1SZmIBvxnSYwtvmOtoxvnDdYXsxW
         bvGjlDeDpXPp/zMzvZZvcJcSOUspOFB9eIrQmQMnPJwU6mtJmaSv1wqbeAq3AMeqsArM
         ItoDxaidzPjMWjxpMw3LfFfvYLtxXf8B4XzrI8McHr503FcpQaPebBI4ujVlWph1vWQj
         kYlEVC6pJcARsJmt9NyD3hnhb808RDiz6xJd0Guv2dSE3464QfmglRut6H3e6hgaCwdM
         RvP2EQqm+7yMPhaIv6mMQRUWLAaaRmTECKh00j7UxdjHgh7NWvG5bWsjCDIF2y/9e44k
         hf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704207019; x=1704811819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nx9emZL9ku/A2bkH8s+Myg+EcmBlTQ3WIwd3hli5Dao=;
        b=YET1OPTpwjrMIYj3LASJumK+W0NJwNYRx8SjKm4FxGX4iNzClfRp8ST0U8K3Tqci9P
         F4+/u6O5VPIMIDhfKgQOjCDeOaoxVUKolr723+J+UfBZ53KCC7QZLyhT3z6OC9gENANA
         WKy/MCeULV+ZkJRUHZfFUEGH3RbwixDiRgfKM+B33cWD4cAorznK8EYr+WCYR49h4SJr
         KoBHUmfTedOsGn8gd0UP4DS3lHTsrBoQnhAgTo2FFbIoPqLeZkLQ3a167gmkK4lgjXdA
         LlFYDqQq8VcGG8vVgFHndg5Dq36HW9J0bDqhVvx2/yXYicJlFFJ1on3IbevKsCd5oqGE
         O9MQ==
X-Gm-Message-State: AOJu0YxR2OFPv5oiW8QJDkmF0JrbTnIPbsVQZII2qDfphW79uTozf4Sc
	T4R4v/jRpFrDwRZtRcqG95eGebrilbuLog==
X-Google-Smtp-Source: AGHT+IH1AtANcoTpV/1fg7LaSPtmB+gncYnvxJC4l0K9bGliRbPQf3qOvwE+k/EciIKWd+fgvtLnfw==
X-Received: by 2002:a17:90b:3781:b0:28b:d31d:bca5 with SMTP id mz1-20020a17090b378100b0028bd31dbca5mr21613623pjb.32.1704207019429;
        Tue, 02 Jan 2024 06:50:19 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a005300b0028be216595csm25836878pjb.4.2024.01.02.06.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:50:19 -0800 (PST)
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
Subject: [PATCH v2 2/3] x86/crash: use SZ_1M macro instead of hardcoded value
Date: Tue,  2 Jan 2024 22:49:04 +0800
Message-ID: <20240102144905.110047-3-ytcoode@gmail.com>
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

Use SZ_1M macro instead of hardcoded 1<<20 to make code more readable.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 792231a56d11..249b5876e7ec 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -170,7 +170,7 @@ static int elf_header_exclude_ranges(struct crash_mem *cmem)
 	int ret = 0;
 
 	/* Exclude the low 1M because it is always reserved */
-	ret = crash_exclude_mem_range(cmem, 0, (1<<20)-1);
+	ret = crash_exclude_mem_range(cmem, 0, SZ_1M - 1);
 	if (ret)
 		return ret;
 
-- 
2.43.0


