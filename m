Return-Path: <linux-kernel+bounces-8192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC8481B364
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E101C25058
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2754F60D;
	Thu, 21 Dec 2023 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUrvf1v6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5059E4F203
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3e05abcaeso4279605ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 02:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703153888; x=1703758688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M6NIr38DFBWDZyn+9oG1rPeiRckvDgmloLxDUP+lGxk=;
        b=aUrvf1v6dXaeJi5Q+VXgTqFktHaI0S4bl7JejXh9wtIMAn3S/D1We8FqHWVJeBK4Ev
         7ZyYv96HxRgW8g8K+4+s0pYQf9BR1We2/A1hYCKgq9Q+G1BMs0DLmaHVXbFneKt9ni6x
         WuzXTQrosNbgxdgWUstb2lf3oaGh2fAY+ZKbtDtgaURCuNOpsXx5/UU788LyoTGJdOjF
         Z9U5IQRFHWiOMrQVGuxa6gLrmT6cmnUZHRTc24IsdEuyi+yFn5C05FrJlGfN9uUStpyg
         iBrXnwR09amuJ3/mxodjiQQo0ht5IEsE7SolcwuqXraMyubDr3bPhB5+SIA18aBTXq5F
         4LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703153888; x=1703758688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M6NIr38DFBWDZyn+9oG1rPeiRckvDgmloLxDUP+lGxk=;
        b=Xt5Q6qOMrZqxkPXGPCfSO4YqAuPyD3725XgiKqCq8Acf4i5hNHPxUD4HN3MxSAgEyI
         uUNxkfgJH/SJlja8oS47VvGhff4j4E3vK/l9/GbrNhVkEMcSmQHDh1izld215PWvicn8
         o7s+aw34BeHrCh7FaMPSY43FVDi+8sdtYS+ikGy95qZjkfgjKD6AT+CiDjgdmurNp1Ok
         q0enlymSPkMzMvxktX6kmXcMdr+knz/GzqB4NQ8Twdtdgaygi7/zS80WQCmYYbR8PQlU
         yDeOnS4CHubHmHrhgVq90kijmvu/fBjD97S69VX6BU6XwJHEtjSA6ZEnhQm3W15YJMFN
         3kpg==
X-Gm-Message-State: AOJu0YzJUj4oNLifbgO6W4FsUw4b3nqfDyHQQtSZgDVP6vpQWC1s5J+1
	yVqS6Tk8ED47aTz1xPG4+qeq+NjEb8U=
X-Google-Smtp-Source: AGHT+IGeSMifuSlZ3eGvRhBSncLQrvYxQzUJxE3dTXFno94ky3upBk44K71olMO1EOoTRq1QNEd2lQ==
X-Received: by 2002:a17:902:7848:b0:1d3:2d73:e1ae with SMTP id e8-20020a170902784800b001d32d73e1aemr8568885pln.109.1703153888223;
        Thu, 21 Dec 2023 02:18:08 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902ee9100b001d0c418174fsm1255375pld.117.2023.12.21.02.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:18:08 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Simon Horman <horms@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] x86/kexec: fix incorrect end address passed to kernel_ident_mapping_init()
Date: Thu, 21 Dec 2023 18:17:02 +0800
Message-ID: <20231221101702.20956-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel_ident_mapping_init() takes an exclusive memory range [pstart, pend)
where pend is not included in the range, while res represents an inclusive
memory range [start, end] where end is considered part of the range.

Therefore, passing res->end directly to kernel_ident_mapping_init() is
incorrect, the correct end address should be `res->end + 1`.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/kernel/machine_kexec_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 6f8df998890e..bc0a5348b4a6 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -44,7 +44,7 @@ static int mem_region_callback(struct resource *res, void *arg)
 	struct init_pgtable_data *data = arg;
 
 	return kernel_ident_mapping_init(data->info, data->level4p,
-					 res->start, res->end);
+					 res->start, res->end + 1);
 }
 
 static int
-- 
2.43.0


