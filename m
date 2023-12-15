Return-Path: <linux-kernel+bounces-887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2056781477D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B2E1F2425E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5162D7BB;
	Fri, 15 Dec 2023 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1ZmY41Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81172D7AB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5908a63a83fso430559eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702641555; x=1703246355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ns8mRhF3ZB8rmGf30ann8sbOyHbBVDczvz9z2SKkRIc=;
        b=Q1ZmY41QyaFvGqrr9CSCN0deG/vAo2Z35NcN/WWUZf1+m7B/P1cai6iixiGEjFAZyk
         wXV1phgANtUbxXHz3+ywOymY9qoQljqrbR0VKVkxCqDWhvavpIwy0jaYUAe0GXVETd/B
         nki4aPg/qJc7LYAmYBOTxJNG9SLR4lCJ77haATkFaR1neJK2H14x7G+wNy6ExqbxO7mM
         iWOkWzEjWiok7gWQMn8oU2VzP3xdOfMf5ZCtErOxk6pGs44cYh7+F4MOzxF5q/f0py9B
         3wl73+K+dS31NaXryhr03Zj1P3QlzTnZWpQ82pk1yTYB1OHHgWMsSyWbUi+GgIHTUaZz
         iU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702641555; x=1703246355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ns8mRhF3ZB8rmGf30ann8sbOyHbBVDczvz9z2SKkRIc=;
        b=EbyqGHKq0/jACnkftQazZ+njbVtaDMm2JKTE//ANbfmUZd1bCKfNA9wC8zkYJWXWjY
         RLK50lAw2BNvQwb3GpI0CFw5wnq09z17y9RaKL6wZcV3Y85JTLLeb6kIXpiWh1JAYW6i
         boz//mS2b7xQ9UN/CX90mnWOejSfQ8ydN9p4uRVyOJPo6cKa7zeBlnIvWGPofKbp1ab8
         QWarzzcDyH3KmkwrzMo2umsPPwSCn2fFY6cKNr4qZ2dnp8DzuX5p+uf+VGPrwsF8B3d8
         n2rRVa6bG5BrCxYLZu19OcpI+n+2fAvrpRMCCV9P/OI8ycdid9D7jyWtFW1qUI33bEca
         Ngaw==
X-Gm-Message-State: AOJu0YzIvRW3kCou0jFI26IjqCzKHV+teOqCPd71n7vn0QeqCTk1sSem
	RnI/evWJ5lxoVq7raYorRWc=
X-Google-Smtp-Source: AGHT+IFjZoDMEaUpN4R5gxsVNnhUAULzvXlGHcIuKhMaszcsmozG8uuTDLX/OvWo0XicCqilwSQlZw==
X-Received: by 2002:a05:6359:594:b0:16d:fc9b:f6b7 with SMTP id ee20-20020a056359059400b0016dfc9bf6b7mr10394679rwb.5.1702641555464;
        Fri, 15 Dec 2023 03:59:15 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:701a:b050:6cb4:5fa2:1942:26e1])
        by smtp.gmail.com with ESMTPSA id f21-20020a056a00239500b006ce57f2a254sm13284675pfc.209.2023.12.15.03.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:59:15 -0800 (PST)
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To: mahesh@linux.ibm.com,
	oohall@gmail.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arch: powerpc: kernel: fixed some typos
Date: Fri, 15 Dec 2023 17:28:57 +0530
Message-Id: <20231215115857.575697-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed some typos

Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
 arch/powerpc/kernel/eeh_pe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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


