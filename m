Return-Path: <linux-kernel+bounces-51894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2763E84907A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25582B228D1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17BD25564;
	Sun,  4 Feb 2024 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="Ap0GftvT"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F425542
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707079819; cv=none; b=IMEdaUbt1lXqgJDlTC2si4OhyDapdCd2R/mVvGzlF6h0++lDpv5nIO7mwA4m+8HYw9WZSOkyBM2PWOQ0oNMKLp34euTuS+1IJmZRo/ZWuNqU0gB6SGjxuQ1kLY4kIUorrox8wp7fHWxGQf70rUhYV85uC+9g+4vRaMf00COcaA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707079819; c=relaxed/simple;
	bh=1lhg0N2Gi8e7QR494sY3Bu1CxQqmtpmbTRWwdhi/iXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d66vd8QUWOa1Kh810pIIpcPZvWo1Y0s9pOrBBgz1/J0PxBomtEelPVAim0rpLR5oLXNckHYssAHzXdg2082nFOmq+7n/HFOL8HRtGIcqDji537oyyBJEJsud3Bd8vNAtGnUx8joS/guyXFUdRvjsaQO970e/g6Jp7YflIKDKqmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=Ap0GftvT reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso3149949a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 12:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707079817; x=1707684617;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fytadz0HTFoWf6wt3XGkZ/DfN+V7jmo50MJNI2n11Xc=;
        b=cRuk+GiGwDI1eXtY43+Iqwa/uH+rzYj4SIdd8J4a4/6SWarUFpvJPyadd3bO2EOYT/
         3BTp9Y4oKhrIKe694wBnD24AiCtIc9imFFSk2Veh1LfuoMBkmPbs9xlza7AN8I+SN/aW
         GFBmmTbrSpSsXIuO68zpy21zgDBEkQ3F7tnfaVyGCJhSGNBZQfE6i/AB3r+VEt4iWNhF
         kF8uYnuSqOp8Y3Wf98EJAi/ncxSMBQ2ikhB8FSGmcKWQGFBqDqh0kyiejBDl1LKjRBnk
         fvLyC6Pbq7jswpDU6dM5qmmBdnrZVHk8nOpo78OqTtgBnXpUxv2llChwpdgc2HM4OVyd
         sayQ==
X-Gm-Message-State: AOJu0Yw68U6t70aYnX6XeO2QOODjX1NmuIzYfiipwkg2RHLRv8j/FrOK
	9LJIHkHFfm6DD3omzcDV5NorKfDTFMqPDWvhx0d+hMpoz2dC5cuY
X-Google-Smtp-Source: AGHT+IHWHmMvoGxNS7Vqp8v0zNqpws7zwcQUBO1/7apiK4TDRR8E09od/4k9ioTgeq3+6Zy1aRv3Ew==
X-Received: by 2002:a05:6a20:36a5:b0:19b:fdbd:66e4 with SMTP id s37-20020a056a2036a500b0019bfdbd66e4mr10712175pze.38.1707079817062;
        Sun, 04 Feb 2024 12:50:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXTA0aYsM9Ql7A2eobzafnrFph9peJaDPDfNJ463bt6gZ6e+IhnlaKx03KtLnSgcxVQOWhBQ5xxWtDnMJuvkv2d/s+vgFDcZuWUb7Y/JMUgrmxUg8Wq+3+1vxO+xBMlnRZNl5DtKCq5Y2CUYjeppPC26lUvBfQMIj6slrsPQ5RU61NxgBQFBs4RbkWY10zM9bs++7QBxIf7BSI=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id k23-20020aa792d7000000b006dde1781800sm5315179pfa.94.2024.02.04.12.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:50:16 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707079815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fytadz0HTFoWf6wt3XGkZ/DfN+V7jmo50MJNI2n11Xc=;
	b=Ap0GftvTG4KxfXmIAffUKVFUfQzhHeCo8iVvwjX0nE8OV0k3UjwyC/HWz3W3KNP6Y4Vrgx
	kAW2u+hWEeqfVQueGW5Vy9gc2n43h0uECwSRvz9Gr8k7gtjfRkQNwVtuWlDSeWJHqO/2q7
	UYpnUp/Jgi8Oz3Af3rf7jVKaRAh4tjBAs9k0c3U9LVm4xfx9iiSbp3fqveWp5foGXU4gQc
	hgvahFjJrEtccUBVhoylzUzU1a4l4KhanvsdzHZ4+z4ebKfZkC2C30nVYIevAa3Ktm/lnP
	cBWueZOHqZY8WBbt1hUMEBBmMG0XCVOfP18z0uNIoeIrvcnjTczDeumYwbJlVw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:50:45 -0300
Subject: [PATCH] vdpa: make vdpa_bus const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-vdpa-v1-1-1745eccb0a5c@marliere.net>
X-B4-Tracking: v=1; b=H4sIAKT4v2UC/x3MQQqAIBBA0avErBPUJLKrRITWVANhoiSBePek5
 Vv8nyFiIIwwNhkCJop0uwrRNrCexh3IaKsGyaXikitmn7isFxr3eJY2b9iAQtuh76Tee6iZD7j
 T+y+nuZQPCAQW92IAAAA=
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=1lhg0N2Gi8e7QR494sY3Bu1CxQqmtpmbTRWwdhi/iXk=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv/immH0AiDOuYoylWvA1eHHcBbs75g6tpUx7U
 zkiACFqX3+JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/4pgAKCRDJC4p8Y4ZY
 pvfVEACcW3xpwIKP/RBDINjyXeg6yVkVkqsnWtlfRrWubFZUmgyj/0SuU9jT7lJ4ACvO1DNnafG
 zN5mJctyoVAkKzPzyKxc4aDzCjMvWabeEXFxE/Cpbw35L2RiHsf2kXP+akmCbbloxlvKN/EgKeh
 f6PWxPFUzZJYqsEQbLts81d+wk/ocdACaBgFT2JQWcJ9DMlTFneRbp9hTy+DO/RXzEkb2LQGQ7l
 nN4m0GQM3m8BCHWkXdKGqqgwQ/h5BK5JY/STOgn/PFDevagXJubBLGoEsFmDMdvZOW/zwhEzYwP
 4/ZmPuKmV4+Vm0nl0f9IQh1v5y9tUDFiIOHORHvfURt46zeur/48jf6tc0tdEYdMaoMZO35IptR
 447CZ/Ei2NCMbTFGFKQl9ahrT0Jkya7bgCA5UZDGTikaev4lr//KNic9+pL/a+rhoVbxT5UCIgB
 Tbl1PlsxQuIRX354qD+9DW+NNmA/MPYQLWH+865+V/NWmdzxFhTH3bs5Ba579xVl+s7696cM0Xt
 luqTtNPxA9V6XNr+dTQpZGGADG2xzMLz1hkjOIJ/Nh0o+4gHHi0sS6SMXRJJo1E1zfLg9NF1H1P
 zW0Ag7O6IFi7M06pSlJ51vOHoWbPfr7pOT5KFu5Hl3FDxikYJmDIdmio9eR+2VDyFE97roGr29s
 YTPBUFNr9rbT8wA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the vdpa_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/vdpa/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index d0695680b282..c73c06102e7e 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -115,7 +115,7 @@ static const struct attribute_group vdpa_dev_group = {
 };
 __ATTRIBUTE_GROUPS(vdpa_dev);
 
-static struct bus_type vdpa_bus = {
+static const struct bus_type vdpa_bus = {
 	.name  = "vdpa",
 	.dev_groups = vdpa_dev_groups,
 	.match = vdpa_dev_match,

---
base-commit: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
change-id: 20240204-bus_cleanup-vdpa-8e19b86329f6

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


