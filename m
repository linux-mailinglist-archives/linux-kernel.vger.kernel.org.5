Return-Path: <linux-kernel+bounces-92908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345008727F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661761C26D31
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0DE86644;
	Tue,  5 Mar 2024 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="C0gcKsy1"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241F95BAE6;
	Tue,  5 Mar 2024 19:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668177; cv=none; b=Udwb4W/pAlTiXCZvsdsihVbraRYPETm4kM+I8SkzjNek7M6xbk/LZ2tP5fMkfIWWJ0SSQ2f/4m8YerAk6hu9bVopolGaNErdyB9rDjKvWsVMXtTPDqEBqXDHkdo1Jco2gRGqKhA8gdlSTjTx4tmEdIvSm0hodKeswkTHGp5k5B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668177; c=relaxed/simple;
	bh=VkBMZ6uvcoLMbEFlLtofkjyk2zqIpdamVqvDDtRYx+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fqgMEU9IEvP6ryfm/0p45x6yqg+AMoXfyxyLchqV6yEIzwbUMQ6WXsWKL31K927INNml0qiFQxkjOdn6pJeAz3AjH6yVVsUzfspHhBlzPOsDqQu8KMPlge3mTRl3z89SV+lQ/72aQ9nxbmd4HKqtHo+hR0eUoGaFxlHN3uof7cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=C0gcKsy1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dd10ae77d8so21251635ad.0;
        Tue, 05 Mar 2024 11:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709668175; x=1710272975;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtqgETXLKjgR1p4wKAyyn6Q/qXLeOPAi7s3PU6sDMeA=;
        b=I3D59L9rWBvmSTooE0oSlnHGI1QZu9hGkUqX4sfAA4boxCozRPyRQtGNDo4A8fBW3c
         QZA05Z/R24oIXkaovh2/72owsfWhOGxGvhA3E7+TP5h/Z860uneJxdwqzeGRZI+ZZHl8
         mZrvabyS/FOrPTH1XVlZsiARsoWL87+2lB4iHyT/UAUnWXj/y6G2aRoL6xjRG3Inw2jh
         21HUYtHrL4mweb6+G7Qw0sjPK6RXPfG/5NaUAhvs423Sm7x8DRfcIIQ5xNEUTC2hEUGF
         2xL5xuOyihDREx3IOSnd3lghwFozHzfBPpH79B2nBIoLYNoD2auY86JxvnUhOF/vAiym
         0lHA==
X-Forwarded-Encrypted: i=1; AJvYcCXXceT9DV49MLaOjUr5N/Pc+D7uww6L6+HrQwdifd2OtRVhbWsyvnvq9jtFIs2cSksZ00r2XaaX38OYBCcmiwOzcmi0ed06U9xPH3Ra
X-Gm-Message-State: AOJu0Yz9kxXQzuWqZyFc5vgkjjDl5wf3fPWuWC1v/My5YUcnmWJK3aFt
	ldC4uA1blbPuI1yADNMxsGjwzx2+fKagN7YMohLaJv8Pdc5abIru
X-Google-Smtp-Source: AGHT+IGXWIckJwcNi9UVmtMifTU+CI++i7E5rixATFQHhDakWLSIHbDGXuRemVvvNPj9GtnGddxjNQ==
X-Received: by 2002:a17:902:f7c6:b0:1db:e792:bb38 with SMTP id h6-20020a170902f7c600b001dbe792bb38mr2294128plw.63.1709668175502;
        Tue, 05 Mar 2024 11:49:35 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id a21-20020a170902ee9500b001db5753e8b8sm10923564pld.218.2024.03.05.11.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 11:49:35 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709668173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DtqgETXLKjgR1p4wKAyyn6Q/qXLeOPAi7s3PU6sDMeA=;
	b=C0gcKsy1aN3WyKQAmo7jipQEWe072m990ulqUbWSf4kPtji9za0awbjocF0Oe1pcqKGVOI
	/Z6K1b60I/B6owpQ81bykhlzlxKhJgevTcZBKf+gOCyqwh0GRaZw7W8cdCX4meQ1iX1R7n
	euK2IOZkPgprmKvSuB0d83GFDtpSxPyrU7mySiHhqfqmDMcKvYSh5/DnZVqCyHZ/kRkpD8
	KxdcCTfw/qv4vMDdkk+eJrbKikZ4qA7hcigBKublqmAZQrPRHCkSv3/iyWMDd7nv7oRnRg
	XiiUP7MDaEtlqP+BRfUwVw8trL6ZM3xfv3yjcfXuYzMT9tLBypm4ft1IPi2tww==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 16:49:30 -0300
Subject: [PATCH] mmc: core: make mmc_host_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-mmc-v1-1-4a66e7122ff3@marliere.net>
X-B4-Tracking: v=1; b=H4sIAEl352UC/x3MQQqAIBBA0avErBNsSoyuEhFiUw2YhUMRRHdPW
 r7F/w8IJSaBrngg0cXCe8yoygL86uJCiqdsQI2NrrVRPjiR0Qdy8TzUtnllDZq2anBGS5C7I9H
 M9//sh/f9AI9A1N9jAAAA
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=VkBMZ6uvcoLMbEFlLtofkjyk2zqIpdamVqvDDtRYx+Y=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl53dJkdgqxaSCwBdPoF06r6pJEsydkdDAvBf3y
 9cTs5cWKrGJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZed3SQAKCRDJC4p8Y4ZY
 plhPEAC4Z6gP1vFK/bcbHaG5VzTwzirHkLiwPfAZME6KufwCnp9paFjW2Ar6h7XxfBA36lZySeZ
 H5sG3E4pXXQSl1MzD4jQNp8mMwVQhe29NetVfIQNBCLrb5pOCE3KH5+1V/sfEqo1BWAIAcFWzsY
 2y+Ng4Cr8vDVN947iAIjilvxM1GbBmk/tpNQe4oQWHMIKBLM/++7Cl1rdYUd2wJ+jI+R0QMGdVQ
 NIw7WIANGJLCoPibe/23nDxffvVsTH1k6Hb+/k+GQV++vDTiLH2f76koOpv3GklLn3IvIBGRRHD
 Axz4bPPbiEfA4NSJZecSYdypcN2lxZjkUy3TyBGgjyTPwWvM3y2fK6YHIMV3+E8jNHPhJOx/7i1
 7Xy49FBvOlBAK6g2tQA4iCAyWjAE26Elmfej15Fsiowy8pBw6WgndF69fnhriO7OWRuNESlnxnO
 3qyFoNL/TbGwec/ZCihkLesAgu7zFFebyEt3xXEdrY1p1g5EnI4T5C1A0km1QSz7myozS2SqE/V
 cUEvmnmej9AhP+canvmoZKP5Bic640wfofstLLBcqIkJj/Cghcl8uOJrCREvouiJNeS+s6fvKDQ
 yVQfStMJH85iWX+gbAdgvqwfpOhVrkVfbskdo4XaJXEBHVNxmwGmshegkOIUJSO/HMkRL2AqmXb
 f4CVNYWIXZjGd0w==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the mmc_host_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/mmc/core/host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 3aa9dda6fd4f..8f8781d6c25e 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -88,7 +88,7 @@ static int mmc_host_classdev_shutdown(struct device *dev)
 	return 0;
 }
 
-static struct class mmc_host_class = {
+static const struct class mmc_host_class = {
 	.name		= "mmc_host",
 	.dev_release	= mmc_host_classdev_release,
 	.shutdown_pre	= mmc_host_classdev_shutdown,

---
base-commit: 0cd8fd15a75e82ef249e99b3d80e2012a729d028
change-id: 20240305-class_cleanup-mmc-75258142f27e

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


