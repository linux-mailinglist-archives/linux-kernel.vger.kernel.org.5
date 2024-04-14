Return-Path: <linux-kernel+bounces-144408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5E08A458D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 23:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4CA1C20F5E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 21:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FF3136E3D;
	Sun, 14 Apr 2024 21:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVYV10Ds"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E88C136E2D
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713129593; cv=none; b=kWmXx5QMyNzYnvMlMu8u/MCDRM1x1QHuvJTETy904R1/7lMlwXTFA8UEvR6mUgmbPT+Gd0ksT6pTQvsV5nIRsQHuxRxcSNEfKebP27hE/wJPCfd2ajM/0dwPvyrlj13PxWFwLg0GrZO41ID4idMGNWl/DdiFzduvA4mN790T078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713129593; c=relaxed/simple;
	bh=5K5Ogx+feNGRCkvrgpO47/PQyMQD0hmYvg9zD+U3E+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NkvdxeZviVhDJlTVkKXhUxjNOeH5Rzx/nJl7D8X0+hpV8iHTJut3ct71PFLpwIzbuDU9oh2g/orGpvRo0+r9XGl39zIPNBDaU+HEbMB83tsECghVW+x3rh80HWrMzsM7FUbEb/2tC7gM/4x4KZpQldxhD8BkHgpjVuEfg5bioSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVYV10Ds; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-347c6d6fc02so51911f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 14:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713129591; x=1713734391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VJGyYtAAQc4uOgSGlTr4UuHrBeMB45QcA76q/h9gFi8=;
        b=PVYV10DsVKS9ycZQP51Nh8fEb6Wa0MWYOCTxAGQFS7IOJbVzMEq3ZwLGCnHFDOA/go
         v6Oji1mGY0KbJ+AShPP1b4UP7+asIc4fVQuslP7t1ZT+Lf10qJwQ6T45l/M5ajK3nUjp
         81chrJVc2XGf4RO7C1ZKsyPkZxctwJaC4EU5Q+9s1+L7QOP9+TG+z8zjRkNtahH/KOrX
         ZTpMS4HoxLcoS6TLw5+kplBrkcvM3Hbuh1azoot2GzHyDKbhaYKJUTUCoQDmdLmsRrd3
         7rQIMaAGw9r+R3wOwvEBkK7YUwz8Uuejbd20HDOC1KNvAxbJpNeu/4efifcXSxCDYdvo
         YpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713129591; x=1713734391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJGyYtAAQc4uOgSGlTr4UuHrBeMB45QcA76q/h9gFi8=;
        b=CZMeTO2qifgmAlULjUEY3Qq8v4lBTP11/jblSrja4AzYJshgDS05j2BSXHA+LKSh7b
         bSeJbNdXmxwC9rZ6EHPKoU4QojI2UnHJWrz8Dz3XReSo0VCwuuywMIltgG3tRweTxrls
         3EPSjwrWmJnDVzynfU99lEKbLi2wvMzY4AX7hmZ5Wz6Mgr/+AFCkpcpmh28ATnDtCGIP
         QdE4u+g0dJZINeKZ59oEk3B9KCNNzaYGeEMdyhf6PPSx+2w3v6SfkXv1dzuYVsxlvY3W
         lAY+cHycAngfJr6qL8A1dycEGv5eoUf4+ytb2pO6JeCs6S4xCksyorO56o75v4QnvI9n
         PGEA==
X-Forwarded-Encrypted: i=1; AJvYcCUMouVPYQFlDZ5AOX+KCsy1SLhWSMfA+n1aDFbMleHoBWaFMCSQnqxHa+VT0qwL1wsGjHTEHH/3UE7Qj3yfRyQL9/oxOEI0J+6wtzGI
X-Gm-Message-State: AOJu0YzVF4pnt9LEbhhVM8Lyu18hiGd1H3s0Kc71mL3cETZ41mZCnJTw
	xwXG6Yhh7XDKJRK72PNe73ZM8ICXNmGSntlTl2qmxkuEeA6TOzVT
X-Google-Smtp-Source: AGHT+IG/cPe12BQbE7o8QMo/GuWNnKDEgTsL2Xt3udNupBXE7QpBpi4Z6on6F0LOcXbx4fypPCRikg==
X-Received: by 2002:a05:600c:1c97:b0:418:2a57:3806 with SMTP id k23-20020a05600c1c9700b004182a573806mr3043430wms.0.1713129590469;
        Sun, 14 Apr 2024 14:19:50 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:5535:5568:577f:20c])
        by smtp.gmail.com with ESMTPSA id jg25-20020a05600ca01900b004169836bf9asm16436315wmb.23.2024.04.14.14.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 14:19:50 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] um: tlb: Remove unused flush_tlb_mm_range function
Date: Sun, 14 Apr 2024 22:19:34 +0100
Message-Id: <20240414211934.393303-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC 11.4.0 produces the following warning when compiling the kernel for
UML architecture (with UML defconfig):

arch/um/kernel/tlb.c:579:6: warning: no previous prototype for ‘flush_tlb_mm_range’ [-Wmissing-prototypes]
  579 | void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,)

This function is not used anywhere. It is not exported with
`EXPORT_SYMBOL` either, and therefore it is not usable for dynamically
loaded modules. Remove this function.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 arch/um/kernel/tlb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 7d050ab0f78a..70b5e47e9761 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -576,12 +576,6 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 }
 EXPORT_SYMBOL(flush_tlb_range);
 
-void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
-			unsigned long end)
-{
-	fix_range(mm, start, end, 0);
-}
-
 void flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
-- 
2.34.1


