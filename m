Return-Path: <linux-kernel+bounces-51243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4B9848838
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A470E1F231E4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A193E6024E;
	Sat,  3 Feb 2024 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="gOqyDLNn"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6853B5FF06;
	Sat,  3 Feb 2024 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706985524; cv=none; b=dU/yO2Nn2RxE7oGY2P5ox6lEYvFYd+gWTLLcmeoEYH4vnyRvFXuMhEWhAcPiRfAZ53Rs0B4Uha+5bFt7F31Vohggvtu5Jb7EnJK3CkFvIO1I9+OtLkXTq44T8tOLK/3EZTs6nkY5C6oQRVwPqFM9cu15W2Gsg+y1VEKGNDnrC1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706985524; c=relaxed/simple;
	bh=NaQA4PF+6+PiQe73H9K2PkqG2deGzQRk37uWx5C77BM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VEkBzRO0hZeg1BACB1S3xYP48wBKUyru9VHWVYEExX6cmggN23p5VPxKHCy6yYShdab2OnOzLUzpITBDII39559ACZiYgKbRcr6Abk/xSV78kWSs2bjXGkGyU8eOwDI6/4s0yz2u7iyR+YQmTDS43FV19/1tHyDNfZXg0Yx4NsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=gOqyDLNn reason="key not found in DNS"; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6de2735151cso2236398b3a.1;
        Sat, 03 Feb 2024 10:38:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706985523; x=1707590323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kb77DxUXuA9JnTo+yla0GbkGq2BKsOKXHKXFf1Mh4gM=;
        b=CtP+Nyx664jkGEG9fY6NGhhQEInd/U0gEHjOQ6wfFhEFTC9qKSdmLTp75KayxJpgQW
         Os3bUv0UMZ9VYjJ8UR4iyooH339OWirPJR8qNuGsfuojQM6WP2n71u0gNRFGGglkns1z
         c+5o3HP1LJuhSgKSVSSKNpCa4+lYYbD3D16mDA3evdz4loIhykCJOlRiqK1UMq29qqAt
         00c+ZDmsDx7TfENba1JzeFAYiyJgTam/mXe38Gm/4b3fg8M6BM05Q+gXE6MCtrKzZYd7
         yggK3+EgH61shUFXPpnvqP4xjpjHMVtFirVyYajPV3+OOIimrVcXWi8XshoDNjAvR8NO
         tZTA==
X-Gm-Message-State: AOJu0YxWBYoQw2qsewOIhtP6nP2o86dP06F1/IMxRMsVrmLI73H5VJ+u
	SJfu4HxvxfSA87tlVkW/4jDzD0om5pmVEkRXQU4gMZdajjpefKim
X-Google-Smtp-Source: AGHT+IFrxsg2Fcead+MyGMI/9pLrQ1oGjtT2W7kWxdpIPsPR3382oI1ClimH0rlY8azeRkwT5b9wFw==
X-Received: by 2002:a05:6a00:2:b0:6dd:b12f:c394 with SMTP id h2-20020a056a00000200b006ddb12fc394mr7764822pfk.32.1706985522666;
        Sat, 03 Feb 2024 10:38:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVPl1jmE5g27ixp+ruWfznzA9zcthfckMCF+JkL4y70Gm8K2DqBwpc3nBCHybsMC4DP2ff35D2IVc8vdLLWt0z+idmGMKX1+UUPxEOw5xfGxokHMeZOvFw14pPQmAeraFXkwpH6VWtusJxGI4AiewS+VgAXEkeh4+6pjNUSjzuEvSSuXdeam9giSuxKgCfqjbAERVMHmrg0+hyj/YpLsqWv7Al30gfiPPtedG2r8dhpxvHIjha8pjO8sYU8LqpTQ9DL4offzOsjJHfsZQ1X/6VR/b9+d063mzFjYJ3rqAoSpVsr4dMEHJAKk7reYSsPBhjLDcR/kUWd
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id u27-20020a62d45b000000b006ddd31aae37sm3824945pfl.33.2024.02.03.10.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 10:38:42 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706985521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kb77DxUXuA9JnTo+yla0GbkGq2BKsOKXHKXFf1Mh4gM=;
	b=gOqyDLNnby2H/hVSD4yByt0OxZESX2C9u8NPSFtPgXEFrdbFBe1eINHKBZvPxC0w8kqzhC
	hNm9y7ov9NKItvQYW7R9zPxeOsf0hQ63igRsnBHAaXDg0V4Q17BoYCMnjfjkvoDxYQol3P
	yEPMEfXW1N4MF+YX8oR8otvL09oGt8vA11KiN0qBCZSpIyM/R4giuX314oM5qBDB5Avwnu
	HALH3WH13HWRx15wVugAPIxJNi2RBuqfqVnHyg2FckNcpKe+/wcfM+hdm7dMvywz5P5+Vw
	liHVMNPzDVQv0I51sbJTv6IwOWuQ6AO6WUL2kkPSpKeko6xNun2/oqB/MxSdKA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 15:39:01 -0300
Subject: [PATCH 2/3] scsi: iscsi: make iscsi_flashnode_bus const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-scsi-v1-2-6f552fb24f71@marliere.net>
References: <20240203-bus_cleanup-scsi-v1-0-6f552fb24f71@marliere.net>
In-Reply-To: <20240203-bus_cleanup-scsi-v1-0-6f552fb24f71@marliere.net>
To: Hannes Reinecke <hare@suse.de>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>, 
 Mike Christie <michael.christie@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 open-iscsi@googlegroups.com, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=NaQA4PF+6+PiQe73H9K2PkqG2deGzQRk37uWx5C77BM=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvohGe1KvZqQmTsf6WEwjrz4nBYh0/P+G8QNhO
 ZaX47c7uMOJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb6IRgAKCRDJC4p8Y4ZY
 por/D/9unbq7kpwByLET0gU5ru1X/fAYul7pZGjEg27P/Jcp9qH0Bl4s8rtS40mlfTe9XRMOshn
 FIlv/VOYX13/xFZaBPTS39jr0P5dIZg3429bW6r+ElIsXlJKFReBliomBQrWuX6g2nroF6DRE0N
 f93uJ3P20jOFEDD16y7ckrwh3+S7TsdhbMFD/LaV5w0kcol394lZe6Ma4PRyR4YoC1yCyjx/dCZ
 icW7vbUQSqKR0kKWBQpjUSsgczU/QHPmIcppkJugpy/ulXOOtYI1i8AdLjj3FGoqCQfiohlcHPi
 iNFRtzPxSTjN+/kLd30G0VA7S1peo64tQOTqELVSRF94oMuusL0pmjECZodEktNRaoq9xHU0qbo
 OajQMFlyTsHEnMVHDdfYU48UZeGYmTYK8kJztJXrdMlbZgvlNr7q9PavKmOwQQtBa145H+2SY10
 jTr01/LlKNYJSzjouXWMX6/2YZynV6I3+OrTXp+GYjT9S1ps65chT5SrDM1jyTtU2zxem06Sasz
 nH7By3ykuUdCXQi6ciOAO10zWUFVdZRJZ4jm6R18SqKf3OSfvNmbGOj3gyC2PXvOqGKVLRuQaO3
 3g/qIfebOwNwwV8YJZ0y/qAAF8PeA4s8KqliUWjVnmeybE0SLDrEwRpuJZK86ZjpJhA8XNMQPT7
 eA9kx5FeZoS+Bzw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the iscsi_flashnode_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/scsi/scsi_transport_iscsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 3075b2ddf7a6..af3ac6346796 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -1201,7 +1201,7 @@ static const struct device_type iscsi_flashnode_conn_dev_type = {
 	.release = iscsi_flashnode_conn_release,
 };
 
-static struct bus_type iscsi_flashnode_bus;
+static const struct bus_type iscsi_flashnode_bus;
 
 int iscsi_flashnode_bus_match(struct device *dev,
 				     struct device_driver *drv)
@@ -1212,7 +1212,7 @@ int iscsi_flashnode_bus_match(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(iscsi_flashnode_bus_match);
 
-static struct bus_type iscsi_flashnode_bus = {
+static const struct bus_type iscsi_flashnode_bus = {
 	.name = "iscsi_flashnode",
 	.match = &iscsi_flashnode_bus_match,
 };

-- 
2.43.0


