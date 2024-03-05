Return-Path: <linux-kernel+bounces-92264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA669871DAA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C991B23DAD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67835C5E9;
	Tue,  5 Mar 2024 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="dk9g9bQl"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781F75BAE1;
	Tue,  5 Mar 2024 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637942; cv=none; b=uZGW60l9taysni5r9c+uO5xeyOCXXYJmyu68wuxmF99Bvgg4tzD1U60RcIVrFH2TW2algAF46azA1mwpsNV/k1+YH2x1pFEP2bbBlYR9KWjdwUimcpiF9T9TrqVBnfTOnjfTmJOFaKrGgNzWvjFKQ7zEBAwGVHyIFO7Tb9ODTqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637942; c=relaxed/simple;
	bh=5q6fWGzJDF4Cr+t+Q4ZtDga0mNsyD0fKUCudKOgxwSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oBu6DAyk4YyN29tSkb2KMxId/L6PfcocYJchHpZjmfNfiVCh6kKSb9xVRrVQcPRbhgLGk67jGRdTN14hpWRP0raJnE1WxINMO5NwPL/OJxHyxUg2xalkpIJkBFnLsLNE8XMBprqno9SZHrxQneObc0DiTkocTjxEtkr8C4GmW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=dk9g9bQl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dca160163dso53284525ad.3;
        Tue, 05 Mar 2024 03:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709637940; x=1710242740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WOWeUV5eu7K7ADBYbYMGJ4edFmuHXtVaBUr5dj3jp4s=;
        b=NxiwUKhvqkatFH5KmljfWAnTtF2L+PlYf5q91Dq5SJCCL0Imx6HD0kn2jEcpHH2xE3
         PRuAaTxYIVUzCGR4MhnrcI9tpQBVtEPY9LzetoqMfz3M+hkVqKEJigKYCpmbvxV4XGih
         mmc+/G1KUxlOokBLYRaIuj9kjzn3+E4Njc2ASQ6K7XxZeSfA/1xj/Bk8GjQBOXJ9Ywnc
         DI0N7mMvPKMCnF4fYD4mm58sRMFVVBMLYeBl6NC/gY6HHrndFojr2uh4qCWLC12gYX3q
         1G3hqFru0xZiPFnkd74fzMUIw1DCINwv/K5OlhRSPbC+YffPHyBrYHsmirIavW0SIDqO
         p52A==
X-Forwarded-Encrypted: i=1; AJvYcCW/Acg0/VBXYSxsA5XEH0TUpq1VFrm1YmEWMCf9DlacguT/cylfwLanwFiWnM0zFRg7c77bYbU7B+lytt/iQHW/aL221mhlOic5+Oxb
X-Gm-Message-State: AOJu0YzCjaVh31uSBRkG1YQuqxOiocc7WgakrxGaDnjAu5+XnUKbCmeE
	Vz1PaHe+j8LJsSSk8f3QbcO8c1iTaQEAdV4sl20P/Hxsle6W6IUM
X-Google-Smtp-Source: AGHT+IGUXpFr59sW4lncORlpbNGK+lRQRRG81LRGJDbmyPP/RxTAhbYFiNzqksv7c7m3B2/sPlUFog==
X-Received: by 2002:a17:902:bb8a:b0:1dc:d515:79c8 with SMTP id m10-20020a170902bb8a00b001dcd51579c8mr1263539pls.23.1709637939866;
        Tue, 05 Mar 2024 03:25:39 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ld4-20020a170902fac400b001db5b39635dsm10339272plb.277.2024.03.05.03.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:25:39 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709637938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOWeUV5eu7K7ADBYbYMGJ4edFmuHXtVaBUr5dj3jp4s=;
	b=dk9g9bQlFxSqOkU79It4v/sOubmLOtz/PRhwBH3x9RKev0kHkvhGDVTq1NuUAUMhlDDGpt
	KRxNl+b81YXfPXpNOWs3NuyUiBUSUFmlQiJjMMxbCoB4KlWfBDxXgufsprzp6mNu55IBSN
	HRueo18gcK8gHB4IOjTtZj4WVVEaSqjG4WyJyt75D/ZfrS2ajIiL7PixzgVVahv03qNqK6
	9qnY6iYi4faPe7iIDd14yzIRGi4IHYqclPaMJd25GV4Qy8XTYonJ9w4YV4vkurIw8qXlbN
	D8inmjE3tM88xt/V6qfpt0msqeiRsMl9bVNm1bBxZoTeo8Rf4EaYe9Z++hmm3Q==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 08:25:21 -0300
Subject: [PATCH 3/6] s390: vmlogrdr: make vmlogrdr_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-s390-v1-3-c4ff1ec49ffd@marliere.net>
References: <20240305-class_cleanup-s390-v1-0-c4ff1ec49ffd@marliere.net>
In-Reply-To: <20240305-class_cleanup-s390-v1-0-c4ff1ec49ffd@marliere.net>
To: Harald Freudenberger <freude@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2522; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=5q6fWGzJDF4Cr+t+Q4ZtDga0mNsyD0fKUCudKOgxwSg=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5wEgkKSV6XKyqjkv7lQOi6TINRqNdWkXRt6xY
 KBRZVz9tU6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecBIAAKCRDJC4p8Y4ZY
 pqiaD/4zbHEgwAVb8nVChiUJIYPSKp8ahQvpA1GNWHYfftzq+PQI6R0lS0v1i0T3GlEuiRXGkbw
 1ewhimZ5uflRulGmJRe4znpwaDKL9S8siL04TUPnuHLsLxPxLRbaFKbNEDbD3KgoJb3QX6qdgpz
 2xuRYJWIiygGlg1atZehftU2gudqDS4pAEb8JSQUT+Ydgz+e3TIcIBdy2U3O7h7Z92P2I6K5yeY
 TOr00+Ky2XZjQvqph6fiiWpvrCHJIPHr3IoVGPGJGoyMfVolN8pjvv5Bwv4MYz5pDHKgc+Y/bXw
 RIVHGG7KDxox/He8MhyzWNhq8+/fDiZ2l30xlFtEo1CRxU1ljS71/y0N45moNt9SpULhMnc4pQc
 Sx71nKJ0RDzhvouOlmZYkjh8OZwEj7N3xtl0w0knTdin7Hi+/lbWe7SsQ8fhAGAFt04oF+7s29h
 Clrjr271vQXdd2rVveNTBVYQuo9xoOpw8pYUdG4DJE0q5HUAcELyoQxwzkpAEF3EUWfDt2WWZWT
 Q9H4/OjMMdbjBluSS3GejgtS6ELzq4nMEm4iGzT5iewvDXdaNJ2ZWzqlC+bKoEnddmITSE6HTWJ
 adYchmfBk6hfNi9r+OmH5YG2EUKSf14OZZVv1H2iDLAlLnq5d+VKY0qTCFCDtC1VOcuunUS3jQo
 5rWtFf//xy6aKiw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the vmlogrdr_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/s390/char/vmlogrdr.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index 6946ba9a9de2..063d8f3565c9 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -679,7 +679,9 @@ static const struct attribute_group *vmlogrdr_attr_groups[] = {
 	NULL,
 };
 
-static struct class *vmlogrdr_class;
+static const struct class vmlogrdr_class = {
+	.name = "vmlogrdr_class",
+};
 static struct device_driver vmlogrdr_driver = {
 	.name = "vmlogrdr",
 	.bus  = &iucv_bus,
@@ -699,12 +701,10 @@ static int vmlogrdr_register_driver(void)
 	if (ret)
 		goto out_iucv;
 
-	vmlogrdr_class = class_create("vmlogrdr");
-	if (IS_ERR(vmlogrdr_class)) {
-		ret = PTR_ERR(vmlogrdr_class);
-		vmlogrdr_class = NULL;
+	ret = class_register(&vmlogrdr_class);
+	if (ret)
 		goto out_driver;
-	}
+
 	return 0;
 
 out_driver:
@@ -718,8 +718,7 @@ static int vmlogrdr_register_driver(void)
 
 static void vmlogrdr_unregister_driver(void)
 {
-	class_destroy(vmlogrdr_class);
-	vmlogrdr_class = NULL;
+	class_unregister(&vmlogrdr_class);
 	driver_unregister(&vmlogrdr_driver);
 	iucv_unregister(&vmlogrdr_iucv_handler, 1);
 }
@@ -754,7 +753,7 @@ static int vmlogrdr_register_device(struct vmlogrdr_priv_t *priv)
 		return ret;
 	}
 
-	priv->class_device = device_create(vmlogrdr_class, dev,
+	priv->class_device = device_create(&vmlogrdr_class, dev,
 					   MKDEV(vmlogrdr_major,
 						 priv->minor_num),
 					   priv, "%s", dev_name(dev));
@@ -771,7 +770,7 @@ static int vmlogrdr_register_device(struct vmlogrdr_priv_t *priv)
 
 static int vmlogrdr_unregister_device(struct vmlogrdr_priv_t *priv)
 {
-	device_destroy(vmlogrdr_class, MKDEV(vmlogrdr_major, priv->minor_num));
+	device_destroy(&vmlogrdr_class, MKDEV(vmlogrdr_major, priv->minor_num));
 	if (priv->device != NULL) {
 		device_unregister(priv->device);
 		priv->device=NULL;

-- 
2.43.0


