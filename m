Return-Path: <linux-kernel+bounces-12560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DFF81F6CB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB14B23875
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86E379E1;
	Thu, 28 Dec 2023 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWrdTcNo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1F779C3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3e6c86868so46484615ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 02:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703758564; x=1704363364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNHLMctTGdj0vJuWMi2GfIyN84VKiMYcb1/R8itcyWI=;
        b=DWrdTcNo4z5I8y51Bz7ilWELp+V+cijmusF17Z5zlJeVp2fVMoyY39kQ8wLO6Xmz7I
         lhVBbUsjRWZoaI3Qjqo378zLPbDScaGHb/4rr/WucKdYc3nAexCFf8BVhHecewOqcRpD
         b8mloIM2K1Y6VSlJpQP/+TUpULp447Hry2smppSsJdPizYolce1K2luVsmNDoncGGGFa
         cLr77S5WdX26vi2GJcPyxYGREwWrd8LEc5ouqt/Kf/wDJLk0T3zl2YhI822BJZ6mysCc
         FfFcRdmES1yhiQ80UqtGy+OVqC3XvNb4r/ygr0AgfUKAtfDf5goC1fS/4eTm0yJtQ7nq
         mkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703758564; x=1704363364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNHLMctTGdj0vJuWMi2GfIyN84VKiMYcb1/R8itcyWI=;
        b=NEhZJGUdgOQLceD73s34VtaOA8O+xgHxnhW3IpwcKeWwX+y/rZLUleHvXceph9gi18
         w9H/1lOgXI+MGwB0TSODWxtp0d5IC78q1sp1SHhVWz9rKtjNTpsZZPqQumK2tYspH54J
         zYP33m5w9LPr3EExlLSJi/ey4NLIqDRtldeMtuLAFr6knV0kTQLzucBkpTcuceHwPuMc
         NCdAiHfQiqVK1yAaIiBbStN8zwXkPoeMifw3OuCIkYZFMjlrs9hy2IxUP/S5rw2Rh+cS
         zk9kVxKaw8OkoRS/7sb91tRGmMcufdJ5B07HSYlynTpqm95gy38N0AQpdK/2AqJ59BVa
         kdAA==
X-Gm-Message-State: AOJu0Yy/NzIjiCdAqiReRea7WucvMxWEwAehhl3zOqMf3YZP4xBat6Z2
	uZsC6Cnh0UhnKjHYwAOuc6g=
X-Google-Smtp-Source: AGHT+IFFydiaNrDle8dam8zUjk8eRbhdaFZzJtMA7YLsdjFqtf7QVNzOdLODSR1iC6M6pgtIzCX80Q==
X-Received: by 2002:a17:902:d4c9:b0:1d4:4eb6:865 with SMTP id o9-20020a170902d4c900b001d44eb60865mr7318803plg.2.1703758564314;
        Thu, 28 Dec 2023 02:16:04 -0800 (PST)
Received: from localhost.localdomain ([202.137.218.78])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b001d3b7c5776asm13597207plb.160.2023.12.28.02.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 02:16:04 -0800 (PST)
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
Subject: [PATCH v2 3/3] powerpc/eeh: Add the units of size param in the description
Date: Thu, 28 Dec 2023 15:45:20 +0530
Message-Id: <b306ad66489517f5c99694c3f1bc11f6bedf2757.1703756365.git.ghanshyam1898@gmail.com>
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

Add the units of the size param in eeh_set_pe_aux_size function
description.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
V2:
Added the units of size param in the function description

V1:
This change was suggested in V1.

 arch/powerpc/kernel/eeh_pe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 77d05740977a..2038454ce864 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -25,7 +25,7 @@ static LIST_HEAD(eeh_phb_pe);
 
 /**
  * eeh_set_pe_aux_size - Set PE auxiliary data size
- * @size: PE auxiliary data size
+ * @size: PE auxiliary data size in bytes
  *
  * Set PE auxiliary data size.
  */
-- 
2.25.1


