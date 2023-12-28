Return-Path: <linux-kernel+bounces-12559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B57D781F6CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BD81F23B02
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1307475;
	Thu, 28 Dec 2023 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nk1q8d+E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7608C7460
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3eb299e2eso27872025ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 02:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703758559; x=1704363359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEz3o6aITRq1rBmggln0tNpatmDHNuiUsikJCYQq8LQ=;
        b=nk1q8d+EOFA00IKuBV503PvF8LSIqqQX/e7dDxHOGiSYoMo2vfeACHLmt3mvZg2OLn
         pvGrd6I4H50Y1YHhTQVzwwzgcDRGQwWk3GOxi0/d0FJLocC3DJ67ZHjcrbrALYHQAse1
         S/Z5zvLjSL2RplUMdQuPfGe5u+bORxc7oAzogCKsvq3P4h23CyfRWxD0geA0XZQoxKoh
         IYNHPpxCKyl3LmrLdqKEx3IHiRdgoqnsAOiEOInTeJ00hBWnjqfK3amnMlPzW4Ab7yFh
         Qu9Y9x7t6Tb/mCTq1mS0az6Ie/47LrWtdTqBjwsNeyS+FILU1uDsSIWw2cPODKLwO6uk
         koaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703758559; x=1704363359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEz3o6aITRq1rBmggln0tNpatmDHNuiUsikJCYQq8LQ=;
        b=kxx+e9UN3PShrFUy0jdBKMYZ5kjiFvb1slvI+7O4XjD+qDp7wJhRVQpNLaN2QIOdU0
         C6+JNnfqAktVqx+1SAO1ytDCNUKh1CgSr+2iZSrjqEeiCeLquRumavRla5BKizMKLmvK
         88Cy9MPHdGIBpFExqczfLqTs/vJ4V3NkyIepZynd2388yY1JcehyedDJYRYxJGqk5IoH
         iksKJC9Zo5QzYLixjywlQ9USrh9uEt1dHJw1HfK0GNlAMHverq5/kgBOwRO9zAPwaU7w
         ySPT11fyCEm3TfBTc90S3/medxMeA7+d/xAIADxSNHBpRIQQrfq7SiXt1RWJVlW/f/vP
         v0kQ==
X-Gm-Message-State: AOJu0YwYxeFiVmwazMFgOjHe4yPgu0YdC86vcacW9xFTxoOhsUjbFqjn
	w6msuhBHC8ZjX9ZRmUQjx9A=
X-Google-Smtp-Source: AGHT+IGJ5Q93ZrW9nkQ3Vsaq4mnG4QWNm/1oefuGUzFbOO/j6dF28mKGUrfDWVezpelQyVTGtBSCRQ==
X-Received: by 2002:a17:902:d355:b0:1d4:419c:3c79 with SMTP id l21-20020a170902d35500b001d4419c3c79mr3170961plk.82.1703758558606;
        Thu, 28 Dec 2023 02:15:58 -0800 (PST)
Received: from localhost.localdomain ([202.137.218.78])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b001d3b7c5776asm13597207plb.160.2023.12.28.02.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 02:15:58 -0800 (PST)
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
Subject: [PATCH v2 2/3] powerpc/eeh: Add full stop to fix a grammatical error
Date: Thu, 28 Dec 2023 15:45:19 +0530
Message-Id: <5cac0f67a54c21ddadf5f2f844bf85544efecbdb.1703756365.git.ghanshyam1898@gmail.com>
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

Add a full stop at the end of one of the sentences to fix the
grammatical error.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
V2:
Added full stop to fix a grammatical error

V1:
This change was suggested in V1.

 arch/powerpc/kernel/eeh_pe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 8e0c1a8b8641..77d05740977a 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -27,7 +27,7 @@ static LIST_HEAD(eeh_phb_pe);
  * eeh_set_pe_aux_size - Set PE auxiliary data size
  * @size: PE auxiliary data size
  *
- * Set PE auxiliary data size
+ * Set PE auxiliary data size.
  */
 void eeh_set_pe_aux_size(int size)
 {
-- 
2.25.1


