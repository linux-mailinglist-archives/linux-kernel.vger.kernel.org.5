Return-Path: <linux-kernel+bounces-63690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F243185334F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65955B24951
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F805B03B;
	Tue, 13 Feb 2024 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="KBftyMgU"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EAA57875;
	Tue, 13 Feb 2024 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835046; cv=none; b=tsgoS2LxbjlQhwWsnkhLUYF1nVWeex9vcQND0EWL/5GzJGS31mMgrUyosG/hikmluonjsO/iFNK4p+RlD7of0K4OsG7upW2Ku+mZ+nzdVCnn95XGhl9RZFyFNfaDeThZZf9EYaV13wHgTM5VYq885yWtblJQlHcFm+1IEEvPenM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835046; c=relaxed/simple;
	bh=b+eID30zZZ8FDfe97vo0F3zfOPTLqWXPCwkzir9cgYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KymNK5y5DmrnXgNQn1RYmswsJSwoTL6hGGaUWys65bDoMfwvYVGiAXOyfpbcebD6V3abv9NNnqBR/YikKcXwLUm7qiSyVXVmvOxiLe6nf0dYVi/n4tmN/v4BkESCiWfYOMSRSRqydEocKxHX6ktcCuNaa0Q/8H9SwJIxDGehvmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=KBftyMgU; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e0507eb60cso2838276b3a.3;
        Tue, 13 Feb 2024 06:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835044; x=1708439844;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glipsrPj8RSTDLD1+6P5i/aNX8jAK2VQKFjNxY0ilJU=;
        b=VnKtwPQ76jS+FqIz7S+w08UjCfZF3iPIkIiNojMsJgqo5OqdhHnz9fWmed0ZCVdmRp
         GeAP1E0WskeWRpc0JXiiP5fP75Nhl5PqLJ3I1orLflNlGnzGGVicTzOorPMlgYJt0o64
         uk96xbiKI/r+cx31Woyomk5tGX3wAvbosJLST0aQN0g9ZVDay/OVOV/uK4EBDh/Qqo0A
         CKihI19ExiFTLszhCMJy6QxpRCLQ7r5oHGwKNg37aaDuNXkedOZY3P6CIup4u2CNH//a
         Np32CY7Zc1XDgrK4W4y0QfWTgvTk7+AN+neiySGIrQesIBJfSIYiuMGnpuXkXdH6nmaS
         ftXA==
X-Forwarded-Encrypted: i=1; AJvYcCVFrzGkPeIrdTObKgrJkyqk8Vp+tsOhJs1A4mYo1bpXL25aIEsnXWSRxBIqn6rq1a54Vj2qbhjVTV3a5GRBuzWv5tlAnXTLfOvn5oZs
X-Gm-Message-State: AOJu0YxioRYuhiiObTthQEau6Ej3zIODpl6k2kGEZBFhV4cc7M/VmiU/
	FKfv4evuI4sw6uoxqp3qIZJjedybytXPri1tOmseM4gWcAEUFEla
X-Google-Smtp-Source: AGHT+IHm9RT1yXwrGMD9UGY71C0KKxv9EMVof6Blc6M5Y1wEY027KViE29pdE9ZMRg7phJUaBmgwgw==
X-Received: by 2002:a05:6a00:10c8:b0:6e0:f7a3:7201 with SMTP id d8-20020a056a0010c800b006e0f7a37201mr2531631pfu.25.1707835044049;
        Tue, 13 Feb 2024 06:37:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2FSkn/S33iNK3cekS+a2pQinDjD/AOq8fP3xd8PMhu/wp2fI/vXCPEDhRHS3E55arfcynzrC3F/FsCN3A+L1+mngPNiYt6alre6OS5FSvft5+aorU6W95BHnmLBU5ORkiAFB0C14Sho0KqQhWz1wzRbNHdXRMKw==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id gu15-20020a056a004e4f00b006d6b91c6eb6sm7730082pfb.13.2024.02.13.06.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:37:23 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707835042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=glipsrPj8RSTDLD1+6P5i/aNX8jAK2VQKFjNxY0ilJU=;
	b=KBftyMgUUz9xYE1XI8lwCA8LRkGVgiIBpANcOH5xOOwNYoS2288DNKfd10ROd25jnllKTp
	mvHVf0nWYeG2OsA19o1hErHmfhgLUti5dRMKmVAIZ4wNICUpPZ6/gXbSK3sJUrtIxh4tk4
	ZYeVBmJ84wLqFFywMr8QWhv997IfM2+dKRe8Pu+YG9a7to2C7G/71k9QV4Ypwosif4uIGS
	WhzkCWSj/49LIL2SlZA2CUmRltbX3FYk+2H3zwcDnkC6Q3KH/sv9G+exRAqMdzkBurAIII
	cXTa8ZU+q8wdUYwfDWnUSIdQJkS4soxWIuTmh/qx9kIKONcLX1YDDIW7U4lQ2Q==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 13 Feb 2024 11:38:02 -0300
Subject: [PATCH] parisc: make parisc_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-bus_cleanup-parisc-v1-1-2e61c77e66c6@marliere.net>
X-B4-Tracking: v=1; b=H4sIAMl+y2UC/x3MQQqAIBBA0avIrBNMC7KrRITaVANh4lAE0d2Tl
 m/x/wOMmZChFw9kvIjpiAV1JSBsLq4oaS4GrXSjdG2kP3kKO7p4JplcJg7SGmU701oXPEIJU8a
 F7n86jO/7AeKjTitkAAAA
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=b+eID30zZZ8FDfe97vo0F3zfOPTLqWXPCwkzir9cgYQ=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBly37JxbSK6Bq8pOyqJLvTLZdBxxdVCc45nPDtb
 Gvc3rCBCfKJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZct+yQAKCRDJC4p8Y4ZY
 pidOD/0UCza1levJlpC1gxTIoxpv1AFDIqk7JSHD61wHmz+S8dyfel2AF/Wp+y5E/wxnjtxsk8y
 GE9VMLSDSDj4QKmPzrtPTM/EyhYwTx3kViVJ5ZwlRj8GgFzn1ZeB5qX+7mdMvoUkt7Y8KFz+nSZ
 4rD85I/GU2NSLl0sKLufn3a5q5x94Qai/pJerw1kmKQr9bB40vsEN/FK50go4EVHiffLF11bAWE
 SFFTnuZ5SKrhu5lE5Gam4Ms2mWo08h3SCxLBA/bBVnSv/dyRi8zyeTsnAsSP79GrmvG6sBi8Fab
 rD8W2N282BTLl3SxSbnLm7K0sDhWCWw4vO2PPtolWPt4yxNybo2hOXYYPOnr4nrTcpXP19kbb2h
 SyM2b87Gv1p5+Zd/iFaFDM4CJ/PsC5Hf5QAeY8Qh/WkSte8MfAQBtsQZ/rwjS3/62kpA8iimteH
 hgEXudINW0DxBFBRnQUzQWOLhPj6UEBUohIdxaBiummZcH1U1NI4oGff91tSlJKa/OsfKUtOLNv
 quSCVmjkrM3JEzBfPvhzmzj1c+4dodBZ5a5DboOxI/Yoca1PDZYslejQ8yAJOXpSQprg2sXoqFa
 qqQET8fuiCei62k1RkYAfoID1DgVBxMeRRFGoeLAbrF49AF2srNozQJv7hQpbJMamCUFXl746UB
 yHetN9AWqq086Eg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the parisc_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/parisc/include/asm/parisc-device.h | 2 +-
 arch/parisc/kernel/drivers.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/parisc-device.h b/arch/parisc/include/asm/parisc-device.h
index 4de3b391d812..7ddd7f433367 100644
--- a/arch/parisc/include/asm/parisc-device.h
+++ b/arch/parisc/include/asm/parisc-device.h
@@ -61,7 +61,7 @@ parisc_get_drvdata(struct parisc_device *d)
 	return dev_get_drvdata(&d->dev);
 }
 
-extern struct bus_type parisc_bus_type;
+extern const struct bus_type parisc_bus_type;
 
 int iosapic_serial_irq(struct parisc_device *dev);
 
diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
index c7ff339732ba..ac19d685e4a5 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -618,7 +618,7 @@ static struct attribute *parisc_device_attrs[] = {
 };
 ATTRIBUTE_GROUPS(parisc_device);
 
-struct bus_type parisc_bus_type = {
+const struct bus_type parisc_bus_type = {
 	.name = "parisc",
 	.match = parisc_generic_match,
 	.uevent = parisc_uevent,

---
base-commit: 82b143aeb169b8b55798d7d2063032e1a6ceeeb0
change-id: 20240213-bus_cleanup-parisc-93098359acbe

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


