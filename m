Return-Path: <linux-kernel+bounces-51895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F1A84907B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1218B21CCC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B340286BF;
	Sun,  4 Feb 2024 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="K4DOjjmC"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842628688
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707079945; cv=none; b=bl1uBbnSmxh1iC27Hhx2TzWqmP6oGnbYVUxcq1QIiiCzj1YOrNt0Dob3pkOZmNvedrPN0JgHiz1PP94kFY2Z4a1yzhSFalh8rr15YRQzk+n7p2BeGzKJZ87jt7sXDLDdsL241RJy6zIQ32rMtxIyZp6uch5pE0n70cCH5Vw0QMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707079945; c=relaxed/simple;
	bh=sbDgyhLemt9WBM8/41UER9Vp4nTwIRVkedKPpoL3NUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GgnGdiyp1ey7n3tOFGZ/lfyHSBBsq+bOf9LUqIEfazib1wjWxf0Q91jyt3JEruK/lVvYCIgzERRpCSyXFVsbBuWalu/jEYvTjBEYRr4I0o3uy0qJ8CF3q+eK5GvjSP9jry3eD1P9lu7aTK0D1rBYeseDzPXDCxF14QuwxLcAfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=K4DOjjmC reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-290b37bb7deso3077713a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 12:52:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707079943; x=1707684743;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClGn8ecbU90TEqn2u6KZZZz4O47dZbbXURgIbg3kG2k=;
        b=gvQzPrtVOoCHrmaUK2TJE5vKCcyXTJQEt+c5NgfXHhxn0gINDoI83D1bodCT6Qww4/
         ificgbwqn64rx8GEF0wS41HBt5Pb/haKXKcPCT83WsFsd3QCV9VPBSXdOa40FnFSwLuS
         S5SYb51Il25piLzK9f0RsM+4oim5Mjf7qeyqWf8wtsjrRSrWlKE3jyp+p4d3qLYRFH8f
         M9RK6YwRt9vLjLgZy5lDcZJWq2lR3FBkSJf3NuWzZYCtrWVGXmhoIR8nF/JJvHw/bHP/
         0MvAcbIFxhlij0hpdxFxx/siU7qnmevK8948QPlB+giNaEMp0zHpoyf45+wkSP1A2fmI
         Esxg==
X-Gm-Message-State: AOJu0YyYo7yv+BBh5Eb8o8hhYwKKSFJ1gzax8G4RceHtEZCVgpvbJ1DO
	2oLOscjwXAaHwOFdGmezD/maeVYkRDybUCXDeP6u8viIw7ZvDfUM
X-Google-Smtp-Source: AGHT+IGwI+tmMj1Hb+S7XDaQ6Osr7BoUGeig7QhjNWvkOD5fdQf33VJmNq/7osImTH9HJ7rzv3UrHA==
X-Received: by 2002:a17:90a:d70f:b0:296:1bf4:e797 with SMTP id y15-20020a17090ad70f00b002961bf4e797mr7396926pju.39.1707079943581;
        Sun, 04 Feb 2024 12:52:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXZptgEgoAqPO/fTbxR4ln9UrXnO4Z/I65NwR863eqa8UnQwb55H/HmRC+gbiPdkYQo+ERurQuxcPVnLToxA1a78RFgjLXkD8uJdvh9SGW0yLgxztRw/XPWSFrLZ9u909Z4zH2qjlespfmZerVw5m2Ubfpu8C57bQ7ZVDjKvI/eEuA/Et+PM6MBSdK7OgICbJP9hvYmUfAXZ7c=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id se13-20020a17090b518d00b0028d8fa0171asm3697044pjb.35.2024.02.04.12.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:52:23 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707079942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ClGn8ecbU90TEqn2u6KZZZz4O47dZbbXURgIbg3kG2k=;
	b=K4DOjjmC2N94iaAG09XzaTmx6ylEsNVITmdO1FSvxeS6zhOM9x9vVpd1JoI27a7zk06/+2
	XjHVQxVYAmQCSeJuxRizYm4TiDjgYu9eMiarzPPgykvSY4mkAzTdjszsobhq1K9vqUZEk6
	cQLyAK0qfKZ2acuMqocOLGMRp1Wt3g4xORUmZw39jB9jabwQ+oycAPAMpFq/pPV+GRJenx
	nyIBxubFVPOluzPeSj8Fu4VTg7xAAC3T50QuuOBxFn/hT2wQ4hHOfiLfSLrBcmOf+kMnCU
	/ao19X2G/pIzFhQst3UguCD7crgNBDkmNgXcQCWbhwfvbDq9/CeQNS0/IRG4rw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:52:51 -0300
Subject: [PATCH] virtio: make virtio_bus const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-virtio-v1-1-3bcb2212aaa0@marliere.net>
X-B4-Tracking: v=1; b=H4sIACL5v2UC/x3MTQqAIBBA4avErBMmk/6uEhFpYw2EhVYE0t2Tl
 t/ivQiBPFOALovg6ebAu0so8gzMOrmFBM/JIFEqlKiEvsJoNprcdYib/cm7aC3WlSmNxqqBFB6
 eLD//tB/e9wPxXdFUZAAAAA==
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=sbDgyhLemt9WBM8/41UER9Vp4nTwIRVkedKPpoL3NUQ=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv/kke1/UbX16S1OwqSFTauQH9I5P+fSdkKA8e
 VF6yGm5+jyJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/5JAAKCRDJC4p8Y4ZY
 pscUD/49sG93DuRWQirQHxFOKP5JYeZvBKitNbaw1hjWE1YXjwlNU1541CqegIAAaJGup9Wc3eZ
 u3Ia3zlN+DJN4sXY4AaKRiGPcYvKaXik343Srgo9diDhep00X5sSKUQWUMPET3STdNSI1XCTLi2
 PA59oyxD9tpOlrCdOpF9pWENfM2WPd0kfIl99ejXJQ2qc1VUK0b+4xsvN/KtF2dkCVVM0qDgbT8
 qnWJP0tVWPKacoNpr+kd4VcsGgGMks7iJtwEUUYMGHpaGWFIVY+c+QO3nWWMLs60kxQ3Jl/FcWa
 MYyk8NqiIXeuUYmTjDm7z1ZAtvbvXLg4YYbP1ZEqLBL61ij+jz2rp7gKAX8Vs2jOp8a0vjX/z4R
 GGFFKL5gqebTjNqNFOsRu9duN4sF3A7QL238R68eeqEfKcI3+mZ2Ffr5aoXp7g7xPfZM281sILZ
 EAT+K4O8dT+sTe/HdImQ/dtisX7+zmbGDUuCtaDl6ClfxMT79YrSM92Hra1xSmSbnCHQ9NIdCJa
 1tWDKnWsBTbFBS/Gevd4FpYjYwMh8ahiUPmNW5MUQmxTAaiqzY4PBvVvQ2yMHEjtKqiKuXU6jgw
 wkhmVWkfOLKYIua9gyZQ/JaBIKReOsSMdkrr5fIaFpscWyAHnzq5gfYzuWk1EOBRHVkOWBUzKEv
 thYsbSkh8c6/qtg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the virtio_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index f4080692b351..a68e6556f71b 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -353,7 +353,7 @@ static void virtio_dev_remove(struct device *_d)
 	of_node_put(dev->dev.of_node);
 }
 
-static struct bus_type virtio_bus = {
+static const struct bus_type virtio_bus = {
 	.name  = "virtio",
 	.match = virtio_dev_match,
 	.dev_groups = virtio_dev_groups,

---
base-commit: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
change-id: 20240204-bus_cleanup-virtio-9f076c3cb068

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


