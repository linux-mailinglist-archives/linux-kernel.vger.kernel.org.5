Return-Path: <linux-kernel+bounces-3144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1548167ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A7C282EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5FB10A09;
	Mon, 18 Dec 2023 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iReT5LRV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC9310945
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d5c4cb8a4cso338788b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 00:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702887617; x=1703492417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvtwbkM/YdjgqaGJqTGdamlOh6hMCrBAljky/y7FuDQ=;
        b=iReT5LRVYLLmKpreD/LcQELXOFWPbdMrbKpFm+5qEGGA0/ILCRKucrH+a2fAv5dZLN
         +AFxwN66+kjAmspEEQar7vJHa8Tg2ZldSdoKZwyYP6dEwCE4kE+SNMlr5HR0IYqePpq1
         IhsA3x7eBBLCkMmPZfhL1tp+2KEAnN5FmDMFOKjjqBJ+6odFdMCGH2hSjHC1Xa7KAL3j
         Xfn4MIhfGYdOO4SVgfwSFuXafhlz2H63im0a0KBcxrneoxLzXqkpwY+3NZJMuXgCI3P6
         Wkpy7MCsKdf9dTyqB3ir1UUhL81LaBTcoUhS/TdrF7hPji+BGO6FqKNfU7Hu70SF/rb0
         HZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702887617; x=1703492417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvtwbkM/YdjgqaGJqTGdamlOh6hMCrBAljky/y7FuDQ=;
        b=uQ2eteC2h4BnSAV0R9/vGyZjlfQ3pcZFKgiS07xrMUVkpVI4VoILt0NSOOqAktsO6j
         MkVGUmxfRtG3sOfJEqMGsdboZbRMEUmAc/klTagSyB5x098jtzsNyHWC1bdq4I1WJlC/
         adbSKcy9cFPkagesjXaBpydpMWRGYGZjlOjWCC74OMh1Be5SqZdyTcGGg8zBKHl36Ff2
         IuiK4VLtpmGjgceEDjxV+PxO0TYsAcF7aId7StcxypoubqSXo8nQjuqfzBjmMELDCB1e
         vGvdTWa9Ga8TTKuKnnmVS41umrFKx8NhtlQ1EMlnG2nbnNKo2+Hl4Se/sN+8u6+3qGMP
         vyMw==
X-Gm-Message-State: AOJu0Yz3JFcR59bnEJyu5k3YMHXOm2YImWibLi/MD56HBv9Zoyx+Im2o
	lD+l/Jm5hWVU24ZDFcwuFv/nDsHhc3U=
X-Google-Smtp-Source: AGHT+IFS47iWKp0aLsUcouQ18fn+/N7PUVISE2ITXf0MrXj8Wa2enO5fz+9dQOTuj96z+0IEcN1Yag==
X-Received: by 2002:a05:6a21:6da1:b0:18b:8e3d:ed2 with SMTP id wl33-20020a056a216da100b0018b8e3d0ed2mr8903752pzb.31.1702887617285;
        Mon, 18 Dec 2023 00:20:17 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902704200b001d06b63bb98sm18426954plt.71.2023.12.18.00.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 00:20:17 -0800 (PST)
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
Subject: [PATCH 2/2] crash_core: fix out-of-bounds access check in crash_exclude_mem_range()
Date: Mon, 18 Dec 2023 16:19:15 +0800
Message-ID: <20231218081915.24120-3-ytcoode@gmail.com>
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

mem->nr_ranges represents the current number of elements stored in
the mem->ranges array, and mem->max_nr_ranges represents the maximum number
of elements that the mem->ranges array can hold. Therefore, the correct
array out-of-bounds check should be mem->nr_ranges >= mem->max_nr_ranges.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/crash_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d4313b53837e..991494d4cf43 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -627,7 +627,7 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 		return 0;
 
 	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
+	if (mem->nr_ranges >= mem->max_nr_ranges)
 		return -ENOMEM;
 
 	/* Location where new range should go */
-- 
2.43.0


