Return-Path: <linux-kernel+bounces-92934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0002F87284D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB408282CC7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3957912AACC;
	Tue,  5 Mar 2024 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="qVPWBe//"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BE212A149;
	Tue,  5 Mar 2024 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669106; cv=none; b=qK5nSv0HgC7omoxAoSNMXntcXPSlUthLtBV8k74Jn38NUaJia23cABj2a2lslc/epbDYc2DVSJlO9fWWlMIhTLxXhD1LN/7VwNhKacjuuWRJYsK9OwiggiehGI6yY7ZfoXPqex5LSirHur0yYXNvOg6zYMG4Y157o0jypQfPbz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669106; c=relaxed/simple;
	bh=YZTaLjjFT/KLFWWkPvhUSkm9BYaounWSYwxOnFbZQz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QQawtw8Lq7asGyR8hkKui0NtXdEm9XrtUwiBC4EKh0qGOJiWyj4L6QT5Iln8JB9PnTZVOVBtz7YmJ+yJd5k5IA7TEmmw0tNjfYQDsxLy5WN32ntr+6sgc9g8mqRGmM5mV2WlsIqhtcd6aNQv1AReJTis+3bznzSb36fx8fftS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=qVPWBe//; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e5b1c6daa3so4450521b3a.1;
        Tue, 05 Mar 2024 12:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709669104; x=1710273904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FZTWd9DbXRejEhbcIioTB3EZSK0Ji4qWnnxxicPNz+Q=;
        b=eNlX/tS1+WgS5Vss9WcvmkPjlSrmJERY8WhNQSvzYcocNoTtLWOCg+kgyEet2JhTzx
         lxyUNA5xYegC4Re3+0PLXWmbDltzU3B4zjVA7ebWGSLhoYPkcyU5c2Xu8QBradmo4k3/
         XVjHxXi3IPfYXSpX+nLSOfvyC9HyP0Jehi2tbieVkYL5lWcMW1LhRGD/mhPs+CLYT/P+
         ATZmJGnWsx/AG6X2uM/qpgvZXfoKd9QFRLUE0uGpYG75XFA0RjsH0fbSCPRtvjkrvl/O
         yhfOEPRiYPFP14SrRDc4NONGlK8XTZuyZU7DY9HVJA/u3Ou3p3p1kD5UVgEeWqveMWT4
         i/PA==
X-Forwarded-Encrypted: i=1; AJvYcCXDgDlzhjxOQrd1cpsluoMfl8dfOc8L7DGanN7MyMH3FiPcc9zuJ2Ro9vvubi41+CfDwCwyzrOQRoMeYIb4PlX7d3AL35n1RLmltM3OO3Ftc+EMxyOeRqYgzMmN4ldT10vPJ3Mv
X-Gm-Message-State: AOJu0YxasUR523NsbWHZDA2Kb/XU1ZPve1Wqh/YOSJDu/TZKG+qopc/G
	+MJLfEIpFJQ89gUWXQWiKqQFrqi5MDpxYUQRcW+mvcpklEtiLQ3j
X-Google-Smtp-Source: AGHT+IFIl2NrPwqTiISF9Go+pQWcM3cCTr41iJJCwzm6mjFxoMDaAMuRu+2X8SviM16nWFC4ZTfjVw==
X-Received: by 2002:a17:903:1ca:b0:1da:933:fb15 with SMTP id e10-20020a17090301ca00b001da0933fb15mr3622710plh.0.1709669104217;
        Tue, 05 Mar 2024 12:05:04 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b001dbad2172cbsm11219140plb.8.2024.03.05.12.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 12:05:03 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709669102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZTWd9DbXRejEhbcIioTB3EZSK0Ji4qWnnxxicPNz+Q=;
	b=qVPWBe//w3DpPnIs6GRUq5wwi5HyaC95COLqr6lCgIgUKeTKzLUr4T5G9PDO1C0I/yCuT/
	E4VEYdL91I3mFmRzIyatLGNjkJFh7mbEv5gsOh6Ka7ub8Uyxsybid7wSZsEmrRy14J/vcD
	vTn2YeH1Z3L7wNADGATIbNcIEKzhQdwFFbcw66GS+5nF02d9pBWcrtgZKZKKU9VYUJx/an
	uM7H2i7PoJ58QGx6nv3NSHP27TAmhIXUg+/zkqqFdSNqWrpWONCyWVtZJEoR2dJ0u45R8Q
	v4epS0ZLiMeza9ugbbUtL6xOJoMMMvE8mZvyhWnIe250o0FhaC/sY/hzEsF1Eg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 17:04:48 -0300
Subject: [PATCH 2/2] isdn: capi: make capi_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-isdn-v1-2-6f0edca75b61@marliere.net>
References: <20240305-class_cleanup-isdn-v1-0-6f0edca75b61@marliere.net>
In-Reply-To: <20240305-class_cleanup-isdn-v1-0-6f0edca75b61@marliere.net>
To: Karsten Keil <isdn@linux-pingi.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2256; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=YZTaLjjFT/KLFWWkPvhUSkm9BYaounWSYwxOnFbZQz4=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl53rlQZ/+vWAMt8H0wXzwFeSF/iLM4YqeJ1QiJ
 f+T53+0OxyJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZed65QAKCRDJC4p8Y4ZY
 pg1qD/0Qo66VwiLUkpaYCQHO2IhT4GEQXqzCvSS+BHXkSJBFYWXZSx/Yo3GcIk7GRKTG/JhuY8+
 uVF6wB9kGKdS4EL2DUj9Jr7pNRs34YfZzn4h84Juamk0gunqeLjDK9mE0r9FqrrhcEnRFmd33/O
 UFp/f1kROyUunbYCDLsjmezDhJgZxuidgjolmGPIJ4jtJUyyZZt6+ysfWRoLBzGyYaso+QIS5sU
 G2uZSowpBRKw+8bWNHr3qMoeMmME7CcGrQ/5ZbqxHySdPcA4CQVIXwGE2CcL42vY/2gKRijdhgD
 atbz7nd3RKffd3eAdgwwZnfsIhu0mPmgxKsXD6uTDQKynFUQ5Pio3g/uN/QUVa2L0Mg5ydgVUWZ
 ZfjfYpD3BVVeLUnXGe69d2urWoYDBbUBwcY+Nuj6Fyko8B/rzxvsKaUYbztPvOc6oyXcDyCNMnh
 hhOQQDhhCwP9wWBH+zR5FXV1oI6iG05UHG438grh68UL9owdz4opiZIFTE7x0b73OrwlWk9ffkQ
 ZdLrliImKA9sre14gE7YWYI206dzKQrN5rszk0V40A4y7GSjumsh5lr3fScgOnmGhCLaCe5FSHC
 Mi9ChEX7ikgIziZk9YtXL2NP+Wjwu1ST+oVnbXFVM0yHMRuy7M29/RhZTj+asvZHNekN6vrfoao
 AtJGTtx6dBkz0Gg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the capi_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/isdn/capi/capi.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index 6e80d7bd3c4d..3ed257334562 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -49,7 +49,9 @@ MODULE_LICENSE("GPL");
 /* -------- driver information -------------------------------------- */
 
 static DEFINE_MUTEX(capi_mutex);
-static struct class *capi_class;
+static const struct class capi_class = {
+	.name = "capi",
+};
 static int capi_major = 68;		/* allocated */
 
 module_param_named(major, capi_major, uint, 0);
@@ -1393,18 +1395,19 @@ static int __init capi_init(void)
 		kcapi_exit();
 		return major_ret;
 	}
-	capi_class = class_create("capi");
-	if (IS_ERR(capi_class)) {
+
+	ret = class_register(&capi_class);
+	if (ret) {
 		unregister_chrdev(capi_major, "capi20");
 		kcapi_exit();
-		return PTR_ERR(capi_class);
+		return ret;
 	}
 
-	device_create(capi_class, NULL, MKDEV(capi_major, 0), NULL, "capi20");
+	device_create(&capi_class, NULL, MKDEV(capi_major, 0), NULL, "capi20");
 
 	if (capinc_tty_init() < 0) {
-		device_destroy(capi_class, MKDEV(capi_major, 0));
-		class_destroy(capi_class);
+		device_destroy(&capi_class, MKDEV(capi_major, 0));
+		class_unregister(&capi_class);
 		unregister_chrdev(capi_major, "capi20");
 		kcapi_exit();
 		return -ENOMEM;
@@ -1427,8 +1430,8 @@ static void __exit capi_exit(void)
 {
 	proc_exit();
 
-	device_destroy(capi_class, MKDEV(capi_major, 0));
-	class_destroy(capi_class);
+	device_destroy(&capi_class, MKDEV(capi_major, 0));
+	class_unregister(&capi_class);
 	unregister_chrdev(capi_major, "capi20");
 
 	capinc_tty_exit();

-- 
2.43.0


