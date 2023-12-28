Return-Path: <linux-kernel+bounces-12558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D2681F6C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF811C231C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548906FBB;
	Thu, 28 Dec 2023 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkzsvbSA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785386FAD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3cfb1568eso48402645ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 02:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703758552; x=1704363352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yn4PjDhWbiUDcREinT7MxzjPPyipkYfgnBTzXRdwj/Q=;
        b=JkzsvbSAvvtcQruKW+RAfJbn/fECMW+eN9LR+wUFEcajq0ZFZvRfKPm78Ljo0PFR7i
         i8xkWWKwVRDzjpMOdmclz8EMhtW5nCYu5QJ3serzWh4rbqJuXki+Yl4IX4vBbhSii3Sv
         7MqlXCwGNy8KkuYXI4UoV61XQ92t3n9iQIHau1gCxjh5tW/B8u6G3GugTUdzpxy72U0P
         7PAJYWxgL/e5Rtd1nFkViDUi5VaHJhHczCY+WRZXYtlSMgYYz/YF5AWSBlawL413SYm8
         Q3PNKaBMBJfqasFvAH1CxVexW9NjWgbcgRt1ULHZeV77ctNiM7/yXKqu/+iWii4kGHIG
         BbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703758552; x=1704363352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yn4PjDhWbiUDcREinT7MxzjPPyipkYfgnBTzXRdwj/Q=;
        b=EV/o6GF1OuT5xirGilVL9Hf3zEenMceBNLe74JqWI7vK0mf+lX6sBLsOxeeUd1QyYY
         G/ljKIM+CGFOfb3ywXUxNXQpyjudANRuBLjKpVkkb4hZ1TVx+hN8zBZ3Rtl+qxz7FLEX
         G1jtGqngU0NWjmvgC97BVLW8OHkCxZsvX1adSChYaRIPcHWHONiVBRTnFoILNrCQEwQX
         OEy7zWuftpGeesVa56Z4p+xkNk5GDLMvhWvOmgESowUHrBfCuLRfA10BEZ8/wrDqbW3c
         nVcIlOGT1W/L3uJfrKKBnbbsdoQgyHQ3odq9izHtHVzuomDnysjC47FrzS7QqmxlzjGe
         FriA==
X-Gm-Message-State: AOJu0Yx08hKf7N609nmeaxlAY60aBPDjXntfJDpa05ecLyIT32o1zs/L
	ld6IYTXeE0lOaxWtrbQEZ60=
X-Google-Smtp-Source: AGHT+IEuC3VurKyKElPnBjdSeN0Q9VJ3a/JroMigD54+KoAUJG0qOWfTl+Z743BSSq/AttUhmE5KVg==
X-Received: by 2002:a17:902:b097:b0:1d3:fb6e:f392 with SMTP id p23-20020a170902b09700b001d3fb6ef392mr10000934plr.14.1703758551718;
        Thu, 28 Dec 2023 02:15:51 -0800 (PST)
Received: from localhost.localdomain ([202.137.218.78])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b001d3b7c5776asm13597207plb.160.2023.12.28.02.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 02:15:51 -0800 (PST)
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To: mahesh@linux.ibm.com,
	oohall@gmail.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] powerpc/eeh: Fix spelling of the word "auxillary"
Date: Thu, 28 Dec 2023 15:45:18 +0530
Message-Id: <2ab034609285b21c309cd8ab26c937c846d37ee7.1703756365.git.ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1703756365.git.ghanshyam1898@gmail.com>
References: <cover.1703756365.git.ghanshyam1898@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed spelling of the word "auxillary" in
arch/powerpc/kernel/eeh_pe.c and
arch/powerpc/include/asm/eeh.h

Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
V2:
Updated commit message and description

V1:
Fixed spelling mistake in the word "auxillary"

 arch/powerpc/include/asm/eeh.h | 2 +-
 arch/powerpc/kernel/eeh_pe.c   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 514dd056c2c8..91a9fd53254f 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -82,7 +82,7 @@ struct eeh_pe {
 	int false_positives;		/* Times of reported #ff's	*/
 	atomic_t pass_dev_cnt;		/* Count of passed through devs	*/
 	struct eeh_pe *parent;		/* Parent PE			*/
-	void *data;			/* PE auxillary data		*/
+	void *data;			/* PE auxiliary data		*/
 	struct list_head child_list;	/* List of PEs below this PE	*/
 	struct list_head child;		/* Memb. child_list/eeh_phb_pe	*/
 	struct list_head edevs;		/* List of eeh_dev in this PE	*/
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index e0ce81279624..8e0c1a8b8641 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -24,10 +24,10 @@ static int eeh_pe_aux_size = 0;
 static LIST_HEAD(eeh_phb_pe);
 
 /**
- * eeh_set_pe_aux_size - Set PE auxillary data size
- * @size: PE auxillary data size
+ * eeh_set_pe_aux_size - Set PE auxiliary data size
+ * @size: PE auxiliary data size
  *
- * Set PE auxillary data size
+ * Set PE auxiliary data size
  */
 void eeh_set_pe_aux_size(int size)
 {
-- 
2.25.1


