Return-Path: <linux-kernel+bounces-92940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE88287285C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59ADF1F23F47
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0B0128814;
	Tue,  5 Mar 2024 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="kepbZQeZ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636D75C5FD;
	Tue,  5 Mar 2024 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669494; cv=none; b=pLuBLR+c30C6ZFOClftRpE6P+8X1Zwr8gKeuu/W/ZkcJ+/8lkVIOFcIloEgVFcj9YXXWIhG6xMDmQfigvskWlKoVOHiAu1NnCPKIHDSocG5vVBjNNk/uh0DiLGm7FfWRIgCEyfkOfX5AaYJtxuxPGP70hmkw1OZcDdc0QZhtoCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669494; c=relaxed/simple;
	bh=sBMG2Sdf93554VyRVy3RWJ9u84ZlTno+zPBBKHQmVqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fdhCsiVBd8oU3+6xj9/kQlaX1jfcz0NIJwlPQIFns7IS8URe4PlrG+W6J1jpBUq2gJHp2rzkrz9GBh1UX1gTYIjSxcIItSF00zhUGOpnsROq2l5nTwUpDE+vLoPt3hWhjVwQpai2g6vSJULasluliVV4B5DASpTUFGQ20xelR/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=kepbZQeZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc75972f25so51072195ad.1;
        Tue, 05 Mar 2024 12:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709669492; x=1710274292;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Hssqx8a/gP1qJ3tFv3UV+u3V+2x5mG70hb0AJG6/qE=;
        b=LnV8DVvQaRKiAvYfHdVVuxeQMLcSxzonx0l21vQVXmOR1bhoZMOzxUkg3YZ8Qf5/Uh
         XL/i7t9SNlK+UsHGKcmUjHgAzW/Hybf3QeAF+mpWW7M7B9yYx1xhIfKI3eA/IcQEJ8Vr
         z1g1WZBoRKFJssgaVN3vr5KO8pv5s8707sfG3HtbYeU6XpcZSyKW1Splf9KCirUZb9Xc
         Dttb3hvPpdbhd7fztemGLHck+MRhoJ9Ys/Fe7qP2+oOqzlhIOm0Vqsq8w46tE/h4+61U
         Ph+xuLWSv429A8ljE5cOfSzQ2fT3AlIMYP2ISXIhkWy5dJ4duRlwWbmrgw+mbLBE9jbH
         D4rw==
X-Forwarded-Encrypted: i=1; AJvYcCXERQbOJurjmr1NX420b980CQAQb2uM2ArOpv05EZC4X7gS0e3K7fgfebkLfpZqjOP7UCLg9lIuZllzBwCRFKZG7ylQ2Ht/OVv566HL
X-Gm-Message-State: AOJu0YwYWm0EUHkwcLHCrn7HNIcIDNa+EbdMg3Xw+yrzESY8I6ZbkJeT
	7TydIlCSKFXoYFhh9w8Gy5a2ZJvv62bakN469HoE9v4W9ZZQiynZ
X-Google-Smtp-Source: AGHT+IESvt2XwY85Rot2nB1gUxXTUfdjQfryJf0lu7DyyEeeKYVDTFL5M2iRWxv2WD35uGUmeOaZsw==
X-Received: by 2002:a17:903:11cc:b0:1dc:7fb4:20cb with SMTP id q12-20020a17090311cc00b001dc7fb420cbmr3210157plh.62.1709669492572;
        Tue, 05 Mar 2024 12:11:32 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b001dbbe6f1dc5sm11120996pln.40.2024.03.05.12.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 12:11:32 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709669490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2Hssqx8a/gP1qJ3tFv3UV+u3V+2x5mG70hb0AJG6/qE=;
	b=kepbZQeZSyt7ND4rRil76mwRz3fXglBp6lsC6VgieHMDNJMYOnmKMbFqioO//1nZVrTT1T
	hq7YdpNwgDHD9AJGSzafa37oWw+DZvkfFrsE5y+DCtOEpzF3I3L8jVIbEx2NaP0KTgbs1w
	Mm/lvMlW1jdiRTZLDG38UqFMNE6+7873bIiFIYHxXjMj1TjuSNOHtOkM3uRVPDMYt3B+kD
	koJm7nIhx8wrSSuVJpGmHO4yEdYBPgkgSpjYxmw5rvcGvs/lAz7vFdJQ3CPj/4iwE0w6Jh
	xzL7MjPzXIohI/DMGi8MQBwbtD+94gUcL1+kDcLF8vDMiuYQiC7gVQjl1HZ1iw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 17:11:27 -0300
Subject: [PATCH] ptp: make ptp_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-ptp-v1-1-ed253eb33c20@marliere.net>
X-B4-Tracking: v=1; b=H4sIAG5852UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwNT3YKSAl0zoxRDEwtDSzNLE3MloMqCotS0zAqwKdGxtbUASlJSbVU
 AAAA=
To: Richard Cochran <richardcochran@gmail.com>, 
 Yangbo Lu <yangbo.lu@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3461; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=sBMG2Sdf93554VyRVy3RWJ9u84ZlTno+zPBBKHQmVqM=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl53xvM24B2UdXp52EeONnoHNXzM18gGWh5ZAU3
 59SYUNxKn2JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZed8bwAKCRDJC4p8Y4ZY
 puy7D/41SV4zg3/dSkWGB52omGUYRCNvpYFT/ZPlM7lXiEmNw2Jc006JrM+x3VZISTYhKO2u9vX
 CBRlG04TopN3GANwhkNnFi+jGmwcQS8ijFNd0Z694bkhKK2pwasoQ14a+Arp1e1FS57aJz3Ey4u
 JdwbIOfh8TCnUefI4t8k35I5gytuEFrb01FjPZJrxWYWw0IYZJcvsi+UiRnUKZNxZsUwXgxRtFe
 17Pj8xfv/2aeMtkcfyufebi9u3nTZfM1voPBtBCajL280ATmdJcS1JBOQTp0wprvy7ReWCNVAW3
 AfQ3pAh4br/1vXA/8RX0k7zVXtVY0Yi42jx6wCbT0YLgn7IfnYtzQA4UOSR43ivLCuua0eUYmdx
 JDOJfDMeAWY7WAPshgF0kD3OgWw1NHWEkBSfEi63lJl8ndW952mHRj4Jrp43VYl34zxyzIperVZ
 qBa2Yu2tDRVmKawC5LdMaXosE9IviCMnvdRLsHXgPs+u5DbyBjxR6Cn6d4y2xcvyRepEYBhMa83
 Pgs07NWJFj52ILA5CrUp7kzg4OgwabwHC5Tz8uInYUBomiRe2wmDvnvPVvPjPFUU0H2V92zSCZX
 WZ473j68m2ZrYPr8iYa4FcMTqJAxUpH7dKB+VgqG+COsTFKiRpYiCkDtbzgBhreu1MqJXofZQYB
 ke2CU9As7Ip/Xpw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the ptp_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/ptp/ptp_clock.c   | 18 ++++++++++--------
 drivers/ptp/ptp_private.h |  2 +-
 drivers/ptp/ptp_vclock.c  |  2 +-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 15b804ba4868..00c7992fd43f 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -25,7 +25,10 @@
 #define PTP_PPS_EVENT PPS_CAPTUREASSERT
 #define PTP_PPS_MODE (PTP_PPS_DEFAULTS | PPS_CANWAIT | PPS_TSFMT_TSPEC)
 
-struct class *ptp_class;
+const struct class ptp_class = {
+	.name = "ptp",
+	.dev_groups = ptp_groups
+};
 
 /* private globals */
 
@@ -322,7 +325,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	/* Initialize a new device of our class in our clock structure. */
 	device_initialize(&ptp->dev);
 	ptp->dev.devt = ptp->devid;
-	ptp->dev.class = ptp_class;
+	ptp->dev.class = &ptp_class;
 	ptp->dev.parent = parent;
 	ptp->dev.groups = ptp->pin_attr_groups;
 	ptp->dev.release = ptp_clock_release;
@@ -495,7 +498,7 @@ EXPORT_SYMBOL(ptp_cancel_worker_sync);
 
 static void __exit ptp_exit(void)
 {
-	class_destroy(ptp_class);
+	class_unregister(&ptp_class);
 	unregister_chrdev_region(ptp_devt, MINORMASK + 1);
 	ida_destroy(&ptp_clocks_map);
 }
@@ -504,10 +507,10 @@ static int __init ptp_init(void)
 {
 	int err;
 
-	ptp_class = class_create("ptp");
-	if (IS_ERR(ptp_class)) {
+	err = class_register(&ptp_class);
+	if (err) {
 		pr_err("ptp: failed to allocate class\n");
-		return PTR_ERR(ptp_class);
+		return err;
 	}
 
 	err = alloc_chrdev_region(&ptp_devt, 0, MINORMASK + 1, "ptp");
@@ -516,12 +519,11 @@ static int __init ptp_init(void)
 		goto no_region;
 	}
 
-	ptp_class->dev_groups = ptp_groups;
 	pr_info("PTP clock support registered\n");
 	return 0;
 
 no_region:
-	class_destroy(ptp_class);
+	class_unregister(&ptp_class);
 	return err;
 }
 
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 45f9002a5dca..18934e28469e 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -120,7 +120,7 @@ static inline bool ptp_clock_freerun(struct ptp_clock *ptp)
 	return ptp_vclock_in_use(ptp);
 }
 
-extern struct class *ptp_class;
+extern const struct class ptp_class;
 
 /*
  * see ptp_chardev.c
diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
index dcf752c9e045..7febfdcbde8b 100644
--- a/drivers/ptp/ptp_vclock.c
+++ b/drivers/ptp/ptp_vclock.c
@@ -241,7 +241,7 @@ int ptp_get_vclocks_index(int pclock_index, int **vclock_index)
 		return num;
 
 	snprintf(name, PTP_CLOCK_NAME_LEN, "ptp%d", pclock_index);
-	dev = class_find_device_by_name(ptp_class, name);
+	dev = class_find_device_by_name(&ptp_class, name);
 	if (!dev)
 		return num;
 

---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240305-ptp-62d148196947

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


