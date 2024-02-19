Return-Path: <linux-kernel+bounces-71236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FC485A252
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6181F25A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2004A2D611;
	Mon, 19 Feb 2024 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="pzNg2KMi"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653EF2CCB4;
	Mon, 19 Feb 2024 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343113; cv=none; b=gYMb/WgYn24YGhiB0T7QbJIb2G7kK9BFIMa8B78wi2k2bGf8KwneSWXB+5l5gB1YthsnQS2/aAYJFTVj5le47Uz3R4vdK9XYvQN7n9/epL5tNtNonT3vpVLyB8cYYg6ukcHoRwCXHU5MLc8VExXpmIFMkZhtWDqOZcnyEnepB7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343113; c=relaxed/simple;
	bh=FJbaoA87eFUUe6yASIOmEbTdDUloVvotdj5cwK4fWJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pwQRgD9tj+ExwEFbRIE/Cee16yz83ZNk5jAxBYSN5krvzKxBECegHtN8imel7Xo/2XhDTIlDBIze/UbTLQZUruktk1X8yft7lTwidi3N7hY1WD9GVOSmd+EVdrtejqTlIrnnzxVoV5KhAWNvCXBAmjsDmH+fCivVr8rSAwi14rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=pzNg2KMi; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36524116e30so3835215ab.0;
        Mon, 19 Feb 2024 03:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343110; x=1708947910;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhrDCWJ9wwQxB5K4GiqM2SV+/SMRy4JqmwfpEBy+AVc=;
        b=l2v7+W0zcwTf/NCzqKfbroInBtNXLt9qYaqOau5xB4lFc12sC6/rGERYKD9iueWlIN
         MmkfhKKzX10VO2TSpQ02gJqsXu71OpjJH0f8kyqe0MEf9FsMZOOF3vL8w7BkPSgIt0pX
         OnOHH6NedtDo57C23x8Av1+JOe28DWmNC0UBwR1R35u1yqLocep+BAS3i3OFyfbSTphM
         LVCqRL30E2hrwcLbcSVwQgPL1QwDKO6AldM45wzPq52QDL10dHWPWMelJZ7TwbKNx5sV
         ZuG+swiREK8hikLNhEkvTsBeyDlprStg6YQDqOryfRBaFBrJ91QyNpCDDrCsKmGCQR77
         wTig==
X-Forwarded-Encrypted: i=1; AJvYcCWMVCUL4IdbEKyeqUUL7EA7zxePDcx6Q/gbCSC6MTzpYDZSPknUnoU0aWcq8iKY46/RXyc9jYV8WRp21G1AI4LWIDkUF9kt/Meq6OgV
X-Gm-Message-State: AOJu0YxG5ZbdJybFB7G0FEN0ub5XMV56lo1eo0rNNG7GGYiElSavoEKm
	MZx1ixu8gHY8Rh9H3wL3Rdl8iOpuw/o0z/obtL49CjIHGazOju2e
X-Google-Smtp-Source: AGHT+IEGyUNNyuUkE1f90Xm8MPWwC7lTakjRz4MnJUY0A1UcYYnqSzEF+4FT8YKdpBs3fjktkme8tQ==
X-Received: by 2002:a05:6e02:1d09:b0:365:21a0:781f with SMTP id i9-20020a056e021d0900b0036521a0781fmr7241086ila.16.1708343110450;
        Mon, 19 Feb 2024 03:45:10 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ca27-20020a056a02069b00b005dc4fc80b21sm3745248pgb.70.2024.02.19.03.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 03:45:09 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708343108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qhrDCWJ9wwQxB5K4GiqM2SV+/SMRy4JqmwfpEBy+AVc=;
	b=pzNg2KMilZxV+ENhZP3IxYgZ5sr2PvxNJwAa9KjXAPxz35aW2U/h3YlpxU3mXL0ND4oGu+
	ochMMvC09hL9ft6nNdU1Ny+H8Fse2hjIq8QGMpGVOjyB7gflhUb0TR41noaNeMtO5lNnI1
	RwP07zZgx41eydF5WPark4lX8NHV//yQlTj2ywA5CAP93Zu3kNuBQw5FOgii2RA1PB8E22
	BltY3y4MPARPmbubCzB7M0MxWGUBKnC0k9RPv6/Gj8975d5a2S60UCK2ZbOf54s1bWsute
	UsWfr/ylSlG7iskOnNW7lnVyMBqD2HitBVljmykGWGfznpohkVXDaK6CpFmLVg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 08:45:53 -0300
Subject: [PATCH] scsi: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-scsi-v1-1-c5edf2afe178@marliere.net>
X-B4-Tracking: v=1; b=H4sIAHA/02UC/x2MQQqAMAzAviI9W9iGO+hXRES7qgWZsqIIw787P
 AaSZFBOwgpdlSHxLSpHLGDrCmib4soooTA44xrjbIuhSMQj7TzF60QlFZxpJkPWk2cDpTwTL/L
 813543w/UT9WFZQAAAA==
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2338; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=FJbaoA87eFUUe6yASIOmEbTdDUloVvotdj5cwK4fWJM=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0z9xLmg19XqT4mF25UVsBrB2eHKXeYD3x7FgR
 wCx/BlAe1+JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdM/cQAKCRDJC4p8Y4ZY
 puFtD/9RNN4djla/Zk57TJssmazE4+EXXIGi+g4z56LKupv7fbJ1Xu2uuzSp9HvHhyyxARBjc3J
 IvyyBGfJoCkNSb8DoAKi0KYwitGAO/RymH6+TGuw8RbPgsVLE+9hcTCTo600VAg0NkwqZhOuldU
 2/Jq9J8gClhwMlQzd6USEffTGSOkORkwEdi2gfsn3fg5haXimkN1QKbyxz10m/RA5XZ8b7lT3jc
 vSt70PkOlTxXDBI5m+rL0XqdVLAVGe22jU6W9NOLIT+TLptjKwrjfUWnUCp3bSAALUnbYJVEA26
 qObHI7LtPH1KC8SPAHEUcKL+zJNRn6sMeSVC09VREpuLm1h9D52BFgMWWQuCeKJoHJlCA/1/srX
 OYI6pHV/1OtChhqo1n7btoAEl1DmBeJfszLb6CQlIZFhHtTz/BLWmCHu1D5nl30WZ2DxREiObZe
 ma7Acme0/BdNkYw9OHjdklXOnvJkORcoBGsJnVAbS0yiNHiPHvOdhEsR5Fwq+NG//9w8OVfaLN6
 ebs8tR9TpkVDT7qXvAdfn7P4JtM9II42HWLu90ywBXfuO2QnK7z0QjbtnSWDs747CWEbTnOocjf
 XZLpU/4ah5qtHFvOiO+Nlv8w+PKTfHw78BxoCMnUR5E6xnMRkyXXtoWsb4UnN1ghIKN/Zng0OK0
 gXXHVLO39UDHrog==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
scsi_host_type, scsi_target_type and scsi_dev_type variables to be constant
structures as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/scsi/hosts.c      | 2 +-
 drivers/scsi/scsi_scan.c  | 2 +-
 drivers/scsi/scsi_sysfs.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index d7f51b84f3c7..4f495a41ec4a 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -371,7 +371,7 @@ static void scsi_host_dev_release(struct device *dev)
 	kfree(shost);
 }
 
-static struct device_type scsi_host_type = {
+static const struct device_type scsi_host_type = {
 	.name =		"scsi_host",
 	.release =	scsi_host_dev_release,
 };
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 70c0319be34c..44c1956b1720 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -412,7 +412,7 @@ static void scsi_target_dev_release(struct device *dev)
 	put_device(parent);
 }
 
-static struct device_type scsi_target_type = {
+static const struct device_type scsi_target_type = {
 	.name =		"scsi_target",
 	.release =	scsi_target_dev_release,
 };
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 14d0be0da0c6..49dd34426d5e 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -27,7 +27,7 @@
 #include "scsi_priv.h"
 #include "scsi_logging.h"
 
-static struct device_type scsi_dev_type;
+static const struct device_type scsi_dev_type;
 
 static const struct {
 	enum scsi_device_state	value;
@@ -1626,7 +1626,7 @@ int scsi_sysfs_add_host(struct Scsi_Host *shost)
 	return 0;
 }
 
-static struct device_type scsi_dev_type = {
+static const struct device_type scsi_dev_type = {
 	.name =		"scsi_device",
 	.release =	scsi_device_dev_release,
 	.groups =	scsi_sdev_attr_groups,

---
base-commit: 9f3dbcb5632d6876226031d552ef6163bb3ad215
change-id: 20240219-device_cleanup-scsi-bcbc0c15c5e0

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


