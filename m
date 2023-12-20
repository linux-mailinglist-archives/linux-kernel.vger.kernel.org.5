Return-Path: <linux-kernel+bounces-7182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA6381A2E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0CC283980
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD9C405C6;
	Wed, 20 Dec 2023 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/bqWExl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D413FB0B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d7750e2265so1900655b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703086902; x=1703691702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p9mFvLLx7lZ73kFF3I62j/aGFgf0ra8eVik2ke1j8Zo=;
        b=S/bqWExl7JDhnH1WlpGso6frLcTVpkPdT9xjmMaK2J7lENjkjqprSpzXbWx7qfnInZ
         V5Tufu8gtj3Dzxcu7zrwNx8/wor5iDtVDmYDMbEUGUKs/WWXW64by/Cwn1VEikHYr263
         KmK+sdCTi2sJeSimQUIVivF3m329rygTL0oLmy1SWwvEAlXRBG++oD6ATUzrJSwUun3u
         72iaRmSRBhbg48qZ6DaUzVdQ2i9gDeFAP9B7IpFjcxkrh8FzZ4zCsgLTnoVVVtx/dxjj
         HtLhfd9BjvJNFMAZmK5ZbFkuE0qecgmDoXnHY+WJ0G0IDbLoA10cdX2cYjz+hTIisdLl
         vL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703086902; x=1703691702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9mFvLLx7lZ73kFF3I62j/aGFgf0ra8eVik2ke1j8Zo=;
        b=cbBkozSDDadd2B0qZKfS3OLBedT3sXvZsLoQm3aJwpFWBL2nKEFmDo7Ft3LHq5WdX/
         ZUkOsObEY5f1sPwH9JbBVute/EBrcSmsblquQQPJYuCVBqz0pv0u+dQMWvahV3VBBjv5
         Sunzx+e74TnVD8sW9zq2PDTtsQ/Pn41V8gO2kUK8RE2fBx5G99DAc6IYqC3QiOtLg3zL
         +GiXF3sqf/Z7PZ9kXKAPLK2VQlZ04HXdRZEGkR0OEY5WigUTlvcO1ZNd8qANRU8DWk9c
         oMD8N5GgWEYouH6/3kF5E0L9Up6N77+bjUnmy8hbNXxRXV0XlP+78+aknVTj+BGfwRrB
         H+CA==
X-Gm-Message-State: AOJu0Yx5RORBwmb/vs4SmuiFCuzOVxqcY/4KneDkbpD0iLM+8MdhxQ5p
	2MLZTgJAJqw3RutF5ZV4qWU+/4ub8YA=
X-Google-Smtp-Source: AGHT+IE9NTARvHnxZGa80VQ2zRnWB2AD5Je+ZSkuhee+chKhEHjXud7Dv94+MDUssChXgrMhzO7Gsg==
X-Received: by 2002:a17:902:f689:b0:1d3:b35e:7b16 with SMTP id l9-20020a170902f68900b001d3b35e7b16mr4559002plg.86.1703086901632;
        Wed, 20 Dec 2023 07:41:41 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b001d07ebef623sm8790083pla.69.2023.12.20.07.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:41:40 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] x86/kexec: fix incorrect argument passed to kexec_dprintk()
Date: Wed, 20 Dec 2023 23:41:05 +0800
Message-ID: <20231220154105.215610-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kexec_dprintk() expects the last argument to be kbuf.memsz, but the actual
argument being passed is kbuf.bufsz.

Although these two values are currently equal, it is better to pass the
correct one, in case these two values become different in the future.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index e9ae0eac6bf9..114cb690ec0b 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -496,7 +496,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		goto out_free_params;
 	bootparam_load_addr = kbuf.mem;
 	kexec_dprintk("Loaded boot_param, command line and misc at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		      bootparam_load_addr, kbuf.bufsz, kbuf.bufsz);
+		      bootparam_load_addr, kbuf.bufsz, kbuf.memsz);
 
 	/* Load kernel */
 	kbuf.buffer = kernel + kern16_size;
-- 
2.43.0


