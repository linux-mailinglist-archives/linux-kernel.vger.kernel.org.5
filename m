Return-Path: <linux-kernel+bounces-51242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8642848836
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF771C214F0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1E35FEEC;
	Sat,  3 Feb 2024 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="Ce2E6P5N"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5210A5FDA6;
	Sat,  3 Feb 2024 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706985521; cv=none; b=XbA5Xt6O8B4WiETj2p0UesbNA5Bo/zgK+tg0C2ORiVW6cTDpIbPtE4skmhWvOxB3WIFZawUSyEcYGn7WRD/oW4VwUJ4aYVbmAqkiik1HxOVjTNT5EIihovl4HCN+1aLo7zK7FbBXxgBbkzm5WJMXS65pIN/E8SDcoilvwJnhWJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706985521; c=relaxed/simple;
	bh=2inBWz21WgEBkLxfvELl9mMVwMw+EEpdVfSqZvNraWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HgYCWBVYkoqrkwLyzbNCNAkTSHX5jDn6XG8pBMCB8mNlJQetS/81Bp+394IczAie9b20jhfqWs3UvaNRIM1i+LG8OmI589yvir5a4HBYQIAnNl/LVv0xr65cJVNS3zT7cbDa/Af3JZExh3aYvXptv8JYmYThnH3E2LBsrtAj3pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=Ce2E6P5N reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso2572265a12.2;
        Sat, 03 Feb 2024 10:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706985519; x=1707590319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Jzu0xNVcsNVUFtxM5faJFuror84fHuOgPvvmzuxijM=;
        b=myCHBy/HG2+8i3nF1SAJD9bfiDBjmoVlMAEYFTRWCVhRzYKrh453atT8feEle0HhbL
         kPeKEQTNHmoO5dzGEgVv61WZYekrk+M4H3O2JpElTf5ShRPCbKerovJ/t3dkanqd5pht
         UE/ZOL1/orr5EDHYWc2XxDWvtaqQB75iqgGvAhv7iMCU54iKPY8XCBgMfMtxDCpjR0AG
         plhFYdos1zBmyM0G/FHBBMOwQ+nvDgXZPqjBsrdTNv/zL5cnI2cf5gLvmklYug8o6pNf
         40z+Fhm0KkqDMpYPvPamcoLjY8DJGldbpgP6EC7rattHkDDsORf3dVYWfTsR/Wlsff4B
         zf3A==
X-Gm-Message-State: AOJu0Yyg9NDFR+kDPMsvbHlKGB8nw0nZRe+u2GU6LwkDjGQyo5A6dTha
	ZQL86xZkDffM31CgE6b29XbUGSHsWM9+9kU2B5HdxhDxkz7FX7JFP7MfUBItEdpRUw==
X-Google-Smtp-Source: AGHT+IEpo4CS3LpjqI6X5dbH5EM3CpZFNfsXPXLI9xtnYZS+RUBtzI9jRUMMs0PNYSQW4OrLM/4qgg==
X-Received: by 2002:a05:6a00:88b:b0:6dd:a072:867 with SMTP id q11-20020a056a00088b00b006dda0720867mr6839560pfj.15.1706985519480;
        Sat, 03 Feb 2024 10:38:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVL0VSKVhFreRfuUe/AJy+z1cB1ikPZfrYNrSmUAXRkG+kvvFH8E8p1xUTSvDBnZDbotQK5JWxuR6nIykm3B81pN7Kwn4ZSWKLsbiGDSS5DgUA56mhNVRgkHlX/pv0dVXCe0MlA2FCBFtkqfdpy0g1t6RjXV//QKEkIZg1COpalo6AGS49MrwGMflf2hQakrF7Gi6PQSs4MzAojjF33cgySnX4h5XQn/OBDuQ1GaJPpZdSrYehMRaDi+/sFQg1zvAYYDEVrtmT7ZPJQdJZWvGcudrsMklEzNVUy6/4MDAYel5wC6T5AYUWIbj+0WJuGG3RvBM2jwJ2V
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id u3-20020a62ed03000000b006dddd685bbesm3698261pfh.122.2024.02.03.10.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 10:38:39 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706985518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Jzu0xNVcsNVUFtxM5faJFuror84fHuOgPvvmzuxijM=;
	b=Ce2E6P5N6K45qd3vFzqIEdicH7gPzyubWFJL+XBeOlPKlX7/HC9AEWiJ5yYqhQaVARnZCG
	ULUmDPqISRlIW/pBXqFvsEORYq61s0l7G8YYFSGp0AQT/IR4v89MTQxHp2r4XoBfJ4hBLo
	qcttVfmLbsUt59W1l7N+Eai1XEf5XwbICtHaKrZmUJjlpjZcbY0mAJp6BBus1KfxClAEMO
	zKbV4wY7HYR0ydPY2rLT7IPhOYqzYhDaIhQXc7ESKioJQkU8Z8P9COl9JIpNO2nz9bypH6
	SQ9fFWTQ/KCdoDu/LZbBcBSLmNpkWAaQSxUXpoSECOMjKYzlTNRMwCMecNab4g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 15:39:00 -0300
Subject: [PATCH 1/3] scsi: fcoe: make fcoe_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-scsi-v1-1-6f552fb24f71@marliere.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=2inBWz21WgEBkLxfvELl9mMVwMw+EEpdVfSqZvNraWc=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvohGqYPyHio/Ic46fqTbCMPWxC6TR8Oktc6Eq
 Fd+HUp/LNyJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb6IRgAKCRDJC4p8Y4ZY
 ph72EACFBJHzA2UxLVnmRmp+FFnPGN5cYR/yA5X+e3RaHel2Du6qnNhQW7OOEZ99N1HJmHGWF1a
 kFXwrIFNJJArIwg5l8XllvwVIcamUL0KNjOHz59L6LbLi5F/HXOlMG3sxRrVJr+H4+JvyHX+RnH
 hggjRB8UVU50e0Y+NLgLTt3e0V7AR3FF34SS7mM4hFfRqMFhO2ihMXMNJClMET4T5bo0wtZlnsZ
 csRRHCCt1qpBSYMOa8sxjZX+Oa1LAD+75wxl6HTSiDQbrdJaUAYrEI/5l9lQGOOeiD0cZZLblpn
 GqI1W52GNCNwnEQJJKj5A41a9RLrYGuJ2/OWJsK5ttlmXWFbxTdzCjHeLq9VqE+ZmIZJTscpx+A
 I51/3SppthoMwzYUsjn90lK7soqMzZjfYAXW8xI3ez2KJgPwgByRwMxkLkb5RQpUWi1cKVLrMN9
 Rga6J68N4MgBJzWinWlUJPYwQLpmyIF7z4lcLD4T+81b7UCNTzEOAObYHaQUnXAGzwnpiwZX6W4
 E3ITSPMq0j65bzgOUjqjV9HHB7z588S4R7xanG6jwQiMp7CX0q8pqBoKsQM8D0NmjepGNL+NXhk
 w+OKCeKsXcjW02eR0+wkDjM3dWqYoI/z9dX4lMgSNotFQyDQaMNFuBJi5ZcuWE/fk3RqruEmtAx
 fdkQISBACRlwn3A==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the fcoe_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/scsi/fcoe/fcoe_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
index c64a085a7ee2..453665ac6020 100644
--- a/drivers/scsi/fcoe/fcoe_sysfs.c
+++ b/drivers/scsi/fcoe/fcoe_sysfs.c
@@ -597,7 +597,7 @@ static const struct attribute_group *fcoe_fcf_attr_groups[] = {
 	NULL,
 };
 
-static struct bus_type fcoe_bus_type;
+static const struct bus_type fcoe_bus_type;
 
 static int fcoe_bus_match(struct device *dev,
 			  struct device_driver *drv)
@@ -664,7 +664,7 @@ static struct attribute *fcoe_bus_attrs[] = {
 };
 ATTRIBUTE_GROUPS(fcoe_bus);
 
-static struct bus_type fcoe_bus_type = {
+static const struct bus_type fcoe_bus_type = {
 	.name = "fcoe",
 	.match = &fcoe_bus_match,
 	.bus_groups = fcoe_bus_groups,

-- 
2.43.0


