Return-Path: <linux-kernel+bounces-92455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C90E2872061
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C582285BC3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D918663A;
	Tue,  5 Mar 2024 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="jBwL6mKY"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8524F8615E;
	Tue,  5 Mar 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645885; cv=none; b=nPhNp4K6m+WF7aOEmlLFy8JSTefqUzOPUO1jKOZEEIZ0cuK1nG3v3KoKFIeDSMjzGGgSTZ3qOHBHIfMRT6oZPyK+IOHwFSpb6vVbWVTFX/XXDuf+rFYCv76XQqCKDhGVFmotIGy9aXwX+2Mk6XoZ69XG+X6wR9qVtxphWR4WcWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645885; c=relaxed/simple;
	bh=3F8rwXrhfyylZetLLMxD8EhNhOIe6vvR4rLOA84mL6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VTK3gJX3TSwt1jDOSkffxBrc/zaqrxNaOMUJ9S6Lq6z68QIaWQPeKA1WFV6nAlXGDccYjFR31Ty5lh1a8Vce3TodVB8DZ/vlXXtHMhLD1n1VrkXAmnz/dnDeh+YjLQYCxdEJ1z936S3QkdZspMR71nMh9vJ2Jh61k05SRLynKc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=jBwL6mKY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so26757675ad.3;
        Tue, 05 Mar 2024 05:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709645883; x=1710250683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SQNlQEnrZpFxVhCSu8x09R56O9PkjIqUdvHfDcTSzpg=;
        b=LDhy9AR9HdZjOjiaVodC80paAdNqrxtqQPshHAoJXWCkGNpDd2bR7GwcvdN6lGZqmb
         HmJfPzv2Z/y0MBOYvEsunppqLPiixtmlSn/vEMi1Iji+42ABKcPZwZZHuhXAvIsu2NKR
         Q2ZxBNkpeH2vFDoQxC8yKT8HpMfvqDFYg9+pejJ4FPtiVx7RBhNeOclu0xHCmo61fUqU
         kTPsdA/c56ywG1IZtW+SWBt8rH2dd8YVcoTN5YvkTTmMy2WSxHXf5N5NJnIY87x/A0Zp
         GgrfrPi9iUYb4Y/fxVaMXjAT81XaHXsEFSjpSgQslFFmVyYG7AzC8IrSz7OxSZdPfaMu
         PK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2i0Og3fNoHzd9Z7hMNxsG5ooO3007AoG+0hEXtJaL4l9ViEtAqU0X7uX9WG2HUHLvwftNWBGi7jtYtt3Ha3wZPz/R4bBFvprBUJUL
X-Gm-Message-State: AOJu0Yz1d8os/Z4kcrfkahucZ86la9Hj63cFk2MoC1JsYHhYO9VipRC+
	aNgk69RQrWrnQfk1BP/w/bdOzf0W5AZeWH1H77i6MqAYwW6qDCmQ
X-Google-Smtp-Source: AGHT+IE/P+HawYGAndvjB2sLHKglYwCNqf0kSj6bvzCwrNveS0bstjcptV2MtZeeJvrtL9J7SV60EQ==
X-Received: by 2002:a17:902:eb88:b0:1dc:43d:962 with SMTP id q8-20020a170902eb8800b001dc043d0962mr1819754plg.42.1709645882805;
        Tue, 05 Mar 2024 05:38:02 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b001dcd00165a7sm10745537plk.38.2024.03.05.05.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:38:02 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709645881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQNlQEnrZpFxVhCSu8x09R56O9PkjIqUdvHfDcTSzpg=;
	b=jBwL6mKYae6RatXXUtrnKJk62+pXT/fPuESyV0vneFAMSahLvyriJYorJUV53/h97zqepm
	ARThXKt1eEc6m5oGB/1HZM/+9Z9opooU2U9GSu72y3NFr7r99+UU2OIITS8X1RQSE0F+3S
	bw9XOqp5ySxj6t2YHvUPye2qtWQiUbKlegrw6/irwLb6dF4Xrl7n4lY3KZ4Xq+2lT+LAfU
	40AtVFtn3tN6mK6yRMzRgvR2kvUrUY1LxemADOQNokpGhRirswGJmvM7XsRyu1sYOFJ80P
	4YPHepWjYy5FhEO2kveP/6yupRtXSpLjbSHpDVc6BNc3xc1jJ9+ikjF8N4+IyA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 10:37:51 -0300
Subject: [PATCH 2/2] mips: sibyte: make tb_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-mips-v1-2-e93726711468@marliere.net>
References: <20240305-class_cleanup-mips-v1-0-e93726711468@marliere.net>
In-Reply-To: <20240305-class_cleanup-mips-v1-0-e93726711468@marliere.net>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2414; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=3F8rwXrhfyylZetLLMxD8EhNhOIe6vvR4rLOA84mL6E=;
 b=owEBbAKT/ZANAwAKAckLinxjhlimAcsmYgBl5yAuIMVDnFd8oEStRPuydUwWo2xrujQCF1hZl
 FxuvZeIp32JAjIEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecgLgAKCRDJC4p8Y4ZY
 pis/D/jW/FGaYFU+9x9B3e5RPxsPAkrhoyzNI/O4/lD6gBb1zWMnvZDt7wYH1trrfKXGXS5OhNN
 sR9WS6mThDMVw3Azax/TxygelPJ8lRAlgr4KJeQKmFTX1wtXZTM/paa1/wibbX2EeeMptJd2nBZ
 mvEgkX2komqM2miBrm7A3gJ34mLyP13Cr9m6EY7Uq1iLDIOiQm1fEqCdQXT+BlWG6D3oDeq4tkQ
 Y0kW/I5fZAtjYHAXd71suRuMuNtm4nwD8SbrysZYFTUN37ZdnjHRLVeafFxGV4nfvAdMM4GziSE
 P2lpyVbIrq+NUZXJbQQI95/kL2FlsWOol60hwO3hyBc2ts3sWqlwf/UFEnl4N40wvY6DCVkso83
 3/Sfpwfc+9ad7EMswsy2m9wCcCs7jQppH1SdlR0PCN6khLQ/6ekC7w4NfBv8RLfCF9RsHeMhbEu
 Xsn782UhHQN347gC8V+R/ZV7aHW3sMwgbnj1H3D3pU2gJXm6Ha7TS927jIJHFZQuTgeeX4CPgyg
 CvdlW4dQ6yoPvN5cLkU0douPbywa8pM12/AYsPWcNYue45CefxY8gc6g3Uq+xDfEtO9iV3dRfqp
 cdOGnwsuUSL7nBvXyu/OJVjA74NfwUPkjrPFm5TZC5X0HCsKksSTYjvzv/6heDcYN6RBBfCeACg
 jO+YjFAOCRMau
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the tb_class structure to be declared at build time placing
it into read-only memory, instead of having to be dynamically allocated at
boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
KTODO: use device_register instead of device_create?
---
 arch/mips/sibyte/common/sb_tbprof.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/mips/sibyte/common/sb_tbprof.c b/arch/mips/sibyte/common/sb_tbprof.c
index 408db45efdc8..af5333986900 100644
--- a/arch/mips/sibyte/common/sb_tbprof.c
+++ b/arch/mips/sibyte/common/sb_tbprof.c
@@ -535,13 +535,14 @@ static const struct file_operations sbprof_tb_fops = {
 	.llseek		= default_llseek,
 };
 
-static struct class *tb_class;
+static const struct class tb_class = {
+	.name = "sb_tracebuffer",
+};
 static struct device *tb_dev;
 
 static int __init sbprof_tb_init(void)
 {
 	struct device *dev;
-	struct class *tbc;
 	int err;
 
 	if (register_chrdev(SBPROF_TB_MAJOR, DEVNAME, &sbprof_tb_fops)) {
@@ -550,15 +551,11 @@ static int __init sbprof_tb_init(void)
 		return -EIO;
 	}
 
-	tbc = class_create("sb_tracebuffer");
-	if (IS_ERR(tbc)) {
-		err = PTR_ERR(tbc);
+	err = class_register(&tb_class);
+	if (err)
 		goto out_chrdev;
-	}
-
-	tb_class = tbc;
 
-	dev = device_create(tbc, NULL, MKDEV(SBPROF_TB_MAJOR, 0), NULL, "tb");
+	dev = device_create(&tb_class, NULL, MKDEV(SBPROF_TB_MAJOR, 0), NULL, "tb");
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out_class;
@@ -573,7 +570,7 @@ static int __init sbprof_tb_init(void)
 	return 0;
 
 out_class:
-	class_destroy(tb_class);
+	class_unregister(&tb_class);
 out_chrdev:
 	unregister_chrdev(SBPROF_TB_MAJOR, DEVNAME);
 
@@ -582,9 +579,9 @@ static int __init sbprof_tb_init(void)
 
 static void __exit sbprof_tb_cleanup(void)
 {
-	device_destroy(tb_class, MKDEV(SBPROF_TB_MAJOR, 0));
+	device_destroy(&tb_class, MKDEV(SBPROF_TB_MAJOR, 0));
 	unregister_chrdev(SBPROF_TB_MAJOR, DEVNAME);
-	class_destroy(tb_class);
+	class_unregister(&tb_class);
 }
 
 module_init(sbprof_tb_init);

-- 
2.43.0


