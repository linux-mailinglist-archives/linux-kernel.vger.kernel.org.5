Return-Path: <linux-kernel+bounces-86664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F8D86C8A3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CB11C2133A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AFC7CF1B;
	Thu, 29 Feb 2024 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuLDC8px"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8E963513;
	Thu, 29 Feb 2024 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207753; cv=none; b=UAX0LKaTErMWOF3DoC6xxpOINgyER58VGnONXXUrhP4Rw/5UV+DzQPUSxtqcW39Aboisbq/lyLBDKS/GWFZgja32fLwO6PPIgLK8lARU0O5kV72wtsRlpxp50FXVCnjRWMlGjLiWrdCALFFBkbKGH4rrCgBrzl4mtG9ed+04Pbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207753; c=relaxed/simple;
	bh=UdV8nI1R7svJiga7K5tB9T8mcssDDoAC02uPYSD0dzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=e8Mo+zutld4eDOIYYFLj/iL7kxET9pSbyIYCGjO7jK3qlhMaDcTdWVVAK2haggWrF0LKTknYb8IMb6TJunchB56bGLLGsEzR3bocPgTlF3gnoNQSKml+XYztMoX0S+3691Y3WJ9WDEzSDWccVTPJZpe8uPkKammyMNF2RLE8R8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuLDC8px; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33dc3fe739aso1154856f8f.0;
        Thu, 29 Feb 2024 03:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709207750; x=1709812550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3HzubJKeDkwNFU7Oa58TDZNZ/OqHmsfg3cBhyCqsBE=;
        b=DuLDC8pxvWSuralPGPG0hOAA4ZZODe49BKSz+lPEuM3hVpF6LIFVYqyI+YdqPPBwKW
         +z3rseOB9aCoTcUk17yI95hbmoJpEOeyuZDPPsmnklH1N/OV4OSBhi5egT62J8lIqi5d
         RGsW4r1JT0B1XxxcYKmPmfqucwMIoPqa2Wu5pmQlnUjvviBYnu4cc4NSYVTDC60XK6PZ
         usWnNZmkWXMM6xgQETtPC9mJlnluCys4CxVVQmPTqvnG0znFqBWdGnLoId41c17tndRn
         2KKxtUXZ0dUHVyATzMPnuyKk3Os0ldfe2T2wfPCwDR+ZAqA0cy5/wjPXIQ7PtBdxct9H
         uS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709207750; x=1709812550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3HzubJKeDkwNFU7Oa58TDZNZ/OqHmsfg3cBhyCqsBE=;
        b=rj1teONeknkTVjdf8Fl17VKyb40LpAr1H3gLcJOSIdlSEy7x/M8qPygaEZznhslfsj
         U0ixgUGD6bzT7BbDdQde533Z5LbG4tfFx18UhMvxSHLmsSGRNr3her3wYQjNOCwDlbyS
         Vyr06woM0uvgRLOmg97KNk1NRvOtB3YEescpJpd+6Kfj3JInUsGXbMNeRvontQksEPrn
         tqdEMBmzZGAZ838m+FXEMwZ5qwTKfEY8rSQS4VyX7MbD5PFdvMALPSP2VWHFlUSvD/kI
         NmnUk+ei9JrhuHyxX2QcKmg+aouvPj2Vy3HBcDmSaSeN8keMgTlCUqBv6Ffei8irKJX/
         ovKg==
X-Forwarded-Encrypted: i=1; AJvYcCVZKZDP2obXmZ22NWvwou9QKlLrfTrJ3QHTXFJqf87DX9sicefazFgDbfVu9eG05AV2lWdqq64Lpo4aPqKj45jrgoh90atSh9Z+XTzh5Ey8+F6xjqG2/uXusxj/FwhgRaznK6TJY8nI
X-Gm-Message-State: AOJu0Yzi4vtBKKdbkfjALqj/TJCLBtHkVLWqqPBdBG+nYeSHRabNwOks
	QfeFWcti/pZqEBj7Gssa7IqYmzJKQnJTSqe1srhTaXGJs2cbYSjs
X-Google-Smtp-Source: AGHT+IGtM/H/g7iLIBNlJc/9cyGBam/KlX7h/oaZvUR/iazkfIkYkCZN4BGe9Cy3uJEtGVbE+YGxPQ==
X-Received: by 2002:adf:9c8b:0:b0:33e:30a:c6bd with SMTP id d11-20020adf9c8b000000b0033e030ac6bdmr1982066wre.6.1709207749860;
        Thu, 29 Feb 2024 03:55:49 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d634b000000b0033d6fe3f6absm1544540wrw.62.2024.02.29.03.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 03:55:49 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: musb: remove unused variable 'count'
Date: Thu, 29 Feb 2024 11:55:48 +0000
Message-Id: <20240229115548.218713-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable count is being initialized and incremented but it is never
actually referenced in any other way. The variable is redundant and can
be removed.

Cleans up clang scan build warning:
drivers/usb/musb/musb_gadget.c:1747:12: warning: variable 'count' set
but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/musb/musb_gadget.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 051c6da7cf6d..55df0ee413d8 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1744,7 +1744,6 @@ static inline void musb_g_init_endpoints(struct musb *musb)
 {
 	u8			epnum;
 	struct musb_hw_ep	*hw_ep;
-	unsigned		count = 0;
 
 	/* initialize endpoint list just once */
 	INIT_LIST_HEAD(&(musb->g.ep_list));
@@ -1754,17 +1753,14 @@ static inline void musb_g_init_endpoints(struct musb *musb)
 			epnum++, hw_ep++) {
 		if (hw_ep->is_shared_fifo /* || !epnum */) {
 			init_peripheral_ep(musb, &hw_ep->ep_in, epnum, 0);
-			count++;
 		} else {
 			if (hw_ep->max_packet_sz_tx) {
 				init_peripheral_ep(musb, &hw_ep->ep_in,
 							epnum, 1);
-				count++;
 			}
 			if (hw_ep->max_packet_sz_rx) {
 				init_peripheral_ep(musb, &hw_ep->ep_out,
 							epnum, 0);
-				count++;
 			}
 		}
 	}
-- 
2.39.2


