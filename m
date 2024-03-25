Return-Path: <linux-kernel+bounces-118125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5478188B436
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8618E1C3E84B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11D184FDC;
	Mon, 25 Mar 2024 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKmhSCDR"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D725B84D08
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406028; cv=none; b=qmtLBdWJ158EU0Gpn/Wmkx/d9SXLzO+3drG0LNOnPnrnd4InXesYpWlt67DmOol/QTXCCE4xaofkS5ANKzbm3C6tWCWKMc6DKFl5R7xXD5+MXEOzSj7nhp2F5oCkjDh29QzbUU2Sw8V61+ZrzoLVcy06AuIW6dD3BvVmx4okt4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406028; c=relaxed/simple;
	bh=nWy26S5cj5CXdPcBf9dbCQGQIk5BbZMPt9JbLu2oKN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxUj4XGtZEi4R62ibl1q/sHdatU6T2/q2BN5QqEMjXYqchfQdCnXBkhKQn5LO2TDr4EQQx8ujCfet5zhftMjgL+muoTQ/GuEUjuOeiCDVzKzSbSTOsv9NmdyLCEd0nwRIWhcy9lm4OSztfnBwh6oAD8xYKdXNmaZGGdyTl0UIdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKmhSCDR; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cedfc32250so3042056a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711406026; x=1712010826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlCoIx7jLqN5Is/HEKy53SFm13f31lm8FF5rHEKGzHA=;
        b=CKmhSCDR/SyjUms0IqsUSLSK/9OJ1cisFMRDb4zc2DgTEuXjvYjbE4P/lOfuadZ0cK
         yuBPw2CZmzSBKq9ev+NamjIR4O1UViu/KiNoCdYvD4hnO8BHY/o1rxgtrXrdkt6Hk4Vi
         nq0qM/5gk7Gxy2lGIEoVM6ZSX3GuG2pn6kWmCjHq52MfmYCZYp63tapnDO13l52bNM4a
         tLby7py23iRiIdvnCzL2zQyLp4rrPQStvx7UpclyA8phK7dxolerggkLa9UB+sMg/KaE
         eY9Z9GOTJoELwJ2WGAAUrGl1De388OgCPDJgCxlou9OFtrrSnNM2TG1CqrBVC1E74u2y
         pLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711406026; x=1712010826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlCoIx7jLqN5Is/HEKy53SFm13f31lm8FF5rHEKGzHA=;
        b=gRaB6F2kXzQtHItzYBS/IuNSuaQ/5Q3UJEp9Vcq12OEQaEM8At9zJQOC0B//Irwzk4
         3uKhpQX4pBVJZFLqX/gipnbqKSrWluqTg4GDATsIGPx3lXm114x5UzOEk79C7jh57N0l
         S6aZLTStvbZdtv7Aw9wRW8vYvxm7s19cEqjuR3zqBoYIdOE2KhXLqCzvIxjUpN0yve0V
         +9zajcD9eAsuL12N0DJI1tDMgdB7wQd/izTW4pM12FUjGEsnAsHqDI2GG8hf+r+VfkU3
         S0+tvjOlcGiVRXaOL9fLgTZG1Nfhjie8CKi4eR3cZkKHmdRCamOX9ZdXmWyIxEK2f4ny
         SBhA==
X-Gm-Message-State: AOJu0YxduqzRVgBpJnWow8FFA+NAEBjJfzJApHQ63YVX+SSveE4VnMeM
	d/6bPkXFrReDbeZIQbqPbP7llfIpKgXbqIVV0azgvdYRpgcx9PJ8
X-Google-Smtp-Source: AGHT+IHqkDjxiCBXirJRGAONJPRKYdtlto3CBeWqAPDu5xBIWL2dfiUZrx6HsrjVwyLsjkfUNcQ0aQ==
X-Received: by 2002:a17:90b:f08:b0:29b:c2b3:2712 with SMTP id br8-20020a17090b0f0800b0029bc2b32712mr6441165pjb.26.1711406026161;
        Mon, 25 Mar 2024 15:33:46 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id sx16-20020a17090b2cd000b002a053cdd4e5sm4356173pjb.9.2024.03.25.15.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:33:45 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 4/5] mm: Make pgoff non-const in struct vm_fault
Date: Mon, 25 Mar 2024 15:33:38 -0700
Message-ID: <20240325223339.169350-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325223339.169350-1-vishal.moola@gmail.com>
References: <20240325223339.169350-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hugetlb calculates addresses and page offsets differently from the rest of
mm. In order to pass struct vm_fault through the fault pathway we will let
hugetlb_fault() and __handle_mm_fault() set those variables themselves
instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..c6874aa7b7f0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -507,10 +507,11 @@ struct vm_fault {
 	const struct {
 		struct vm_area_struct *vma;	/* Target VMA */
 		gfp_t gfp_mask;			/* gfp mask to be used for allocations */
-		pgoff_t pgoff;			/* Logical page offset based on vma */
-		unsigned long address;		/* Faulting virtual address - masked */
 		unsigned long real_address;	/* Faulting virtual address - unmasked */
 	};
+	unsigned long address;		/* Faulting virtual address - masked */
+	pgoff_t pgoff;			/* Logical page offset based on vma */
+
 	enum fault_flag flags;		/* FAULT_FLAG_xxx flags
 					 * XXX: should really be 'const' */
 	pmd_t *pmd;			/* Pointer to pmd entry matching
-- 
2.43.0


