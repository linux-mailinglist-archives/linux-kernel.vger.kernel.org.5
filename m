Return-Path: <linux-kernel+bounces-21312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E90828D69
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A3C287B12
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDF03D548;
	Tue,  9 Jan 2024 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIbX3DKg"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5C93D3A7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bc4f49a3b6so3696352b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 11:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704828714; x=1705433514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PBnpa/7xlrSbnA3Nm7BMZMZEN1FuSc8e9znQIZPVWWQ=;
        b=XIbX3DKgtiILJc491zm91AZ4qAoZVsez7vEuHE5HvFamGShCGT5ugNYXpqnwsVdGoe
         8SW5FN+Kb+1G8J0bdpf2wwfjl/BirTmPzWQGa73LLDAqRMdS0LsDnF/RNocG0UfiHCCk
         +rsNc75+nDJJPzlKcXZlfOiuJvNMbkix6yunbvdBTO+kiCwBUlZc+F1Gv0RGnCrsLntk
         fwfLWqzmqbkz1OkchYwhC3aFDaGfEn7XBDVhI5rK0d5z9pdEPtfsbn78hSpb+6h8/csJ
         xmXB4Ge6iAWVTwYsTpsEQIDESDz7TpFPugF9Cks9vHqbhqIpFbx2eK0bPI/HuU3Udxnv
         OH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704828714; x=1705433514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBnpa/7xlrSbnA3Nm7BMZMZEN1FuSc8e9znQIZPVWWQ=;
        b=eflbvygfiZBTDHrU+6oENhZxk6dAktdlBYEQI/GANtzXLTAoB5TuaMrR4n3VR94g2C
         VJ7cZKqNDWs6S8tPEeDY8ubAEuNDmp9TktKG1WQat3SJu8DSRLr+d/8S9f063f7jnmO1
         +ffZXmW3ZFHTSsJzBjnhuyLC60qV7FlEwq079CXClAkmFZtoIIJ4Ndz53btZHAYovr0y
         HluCa2Do/dDAYlzSnUSuuUXw6r/FHE7PC/IAVhXPGrDWxcQRPCUQaYt9gBli///nwUOg
         wxaD05u0BnNDe9g1h5iZxqV692IQPP7xj9Yu6ZTgGttAdlsSZPe9GWRIdFIaa2orE3wM
         tcpA==
X-Gm-Message-State: AOJu0YxVXk2a7C3AxBQ0BC5HeymAGyp2IWZMWOB+OCAtxhCpNs3zQR8x
	CKvHNP7Y9r/ch77AU8j/cEQ=
X-Google-Smtp-Source: AGHT+IH7zrV9oxl6TmkXukuqZboCYoT7R9fSIVyaATb0QfvPmgkY/BRdMdgTOF5M+7EcvrEZFU4bDg==
X-Received: by 2002:a54:4709:0:b0:3bc:3c4a:44b with SMTP id k9-20020a544709000000b003bc3c4a044bmr7023972oik.106.1704828714635;
        Tue, 09 Jan 2024 11:31:54 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id w2-20020a62c702000000b006d9a0059a9asm2173490pfg.172.2024.01.09.11.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 11:31:54 -0800 (PST)
From: Yang Shi <shy828301@gmail.com>
To: oliver.sang@intel.com,
	riel@surriel.com,
	fengwei.yin@intel.com,
	willy@infradead.org,
	cl@linux.com,
	ying.huang@intel.com,
	akpm@linux-foundation.org
Cc: shy828301@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] mm: mmap: no need to call khugepaged_enter_vma() for stack
Date: Wed, 20 Dec 2023 22:59:42 -0800
Message-Id: <20231221065943.2803551-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Shi <yang@os.amperecomputing.com>

We avoid allocating THP for temporary stack, even tnough
khugepaged_enter_vma() is called for stack VMAs, it actualy returns
false.  So no need to call it in the first place at all.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 mm/mmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b78e83d351d2..2ff79b1d1564 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2046,7 +2046,6 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		}
 	}
 	anon_vma_unlock_write(vma->anon_vma);
-	khugepaged_enter_vma(vma, vma->vm_flags);
 	mas_destroy(&mas);
 	validate_mm(mm);
 	return error;
@@ -2140,7 +2139,6 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 		}
 	}
 	anon_vma_unlock_write(vma->anon_vma);
-	khugepaged_enter_vma(vma, vma->vm_flags);
 	mas_destroy(&mas);
 	validate_mm(mm);
 	return error;
-- 
2.41.0


