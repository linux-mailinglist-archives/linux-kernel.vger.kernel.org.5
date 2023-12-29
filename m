Return-Path: <linux-kernel+bounces-13143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492EA820044
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2121C228F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7C4125B5;
	Fri, 29 Dec 2023 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKCdEhD5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50BF125C2
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d5b159497so32138045e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 07:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703863967; x=1704468767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBV/7PaW4P47dG71ThTz4mpRUWo+1GXipo7IifZARY0=;
        b=QKCdEhD5kr2YqGwiIUpC9twy2Dt9epB5DDCRBNwPGG+zL1I2x2Gmw87bxO0SDhhzC7
         nlcBSE6mWS4nNJ/0Wdo8xpRhoJ2Z9mLpOVV7eM8q/N7IYTs4JLFwBGpWCjcayR5S9fAU
         d0NqAzwCxZ14on7zkZ6Fu0nA6dKENevxI0X5DOcar5UqK3jztUQqZPjQolJ8UYvaK2OD
         EPqVxpjMuGiiscsavfzdz84y1JTqqKMTi6puTOsw+lXZTPiCnWdkbge6DGfCikvpOo+j
         jpuy+U+avrFjCY2nEnnzdJ6SEEyWlwHnl3pXNkp8IFcouaboBQz3OAZvVPzBP/FvDkoC
         Uz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703863967; x=1704468767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBV/7PaW4P47dG71ThTz4mpRUWo+1GXipo7IifZARY0=;
        b=tLqYvNyIWqZasfNMf6u0fyKduv1LC5SR2J7+or1zr93J8I4kJdvDD55bO+HNCRMPdd
         GRQxWEgIDTF2iKRXNUzOKFZGGOzk4kAk24nSklN5ii+6ePZC5i+rwsmr6G4iHoqoCfAG
         knxAWDPiZI98TI40/9r82bmgn9oGHBBC120OlKxbt+3n/AAlaZW0sa12hoOvqVmwRyAz
         WbpT9XfUl1dLkX0s5vD+D8ZUIoZ0SzhHix6OSgL8568ePdDDFGVRLt5Dt5wxFybWhWIb
         fbCh8mu7cxdnyFWy6cvSJZntqOA/fbPRji2ZqR5B69i5z38BubPxQI31ysPtQKndvvwY
         loqg==
X-Gm-Message-State: AOJu0YxXGZur3fDKutjLpZETfojnDYYxLbcta50jQRZmgxtXudxz3tHa
	I9XAju4jrowLvKBuNrhnZbmkKXzalw3/DA==
X-Google-Smtp-Source: AGHT+IHUiN6XZIdwAXRLcRITtLiGLnkVYKO3F7jsDb4wMCIBC7tWPwYjDUrucl2FCndQ8fGAijA1nw==
X-Received: by 2002:a05:600c:a03:b0:40d:7c3e:cdb4 with SMTP id z3-20020a05600c0a0300b0040d7c3ecdb4mr304924wmp.59.1703863966719;
        Fri, 29 Dec 2023 07:32:46 -0800 (PST)
Received: from localhost.localdomain (bl17-216-113.dsl.telepac.pt. [188.82.216.113])
        by smtp.googlemail.com with ESMTPSA id j10-20020a05600c1c0a00b0040d5b7b9ba1sm12058259wms.6.2023.12.29.07.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 07:32:46 -0800 (PST)
From: Malkoot Khan <engr.mkhan1990@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Malkoot Khan <engr.mkhan1990@gmail.com>
Subject: [PATCH 2/2] mm/cma: Use 'unsigned int' for cma_area_count type clarity
Date: Fri, 29 Dec 2023 15:32:38 +0000
Message-Id: <20231229153238.153627-2-engr.mkhan1990@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229153238.153627-1-engr.mkhan1990@gmail.com>
References: <20231229153238.153627-1-engr.mkhan1990@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace 'unsigned' with 'unsigned int' for the variable cma_area_count.

Signed-off-by: Malkoot Khan <engr.mkhan1990@gmail.com>
---
 mm/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/cma.c b/mm/cma.c
index 01ccd26e8bc2..dd3c39d30ad6 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -37,7 +37,7 @@
 #include "cma.h"
 
 struct cma cma_areas[MAX_CMA_AREAS];
-unsigned cma_area_count;
+unsigned int cma_area_count;
 static DEFINE_MUTEX(cma_mutex);
 
 phys_addr_t cma_get_base(const struct cma *cma)
-- 
2.34.1


