Return-Path: <linux-kernel+bounces-60850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD94850A24
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43431F21B86
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6555C5EE;
	Sun, 11 Feb 2024 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Ka0K8Rd3"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3358E5C5F3
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707666660; cv=none; b=fU+BI65W65TwzITM/cd6VOdDk5zcPQbLaQRBdY27rwUB2ZqAgkDUMon2PGm5ucbWPDN400FN6ayTULkTzgLyw113mV322zKD6pbCULgv9vS68gN+0VlEdWBcL4n77xUb9BiESpCMz6Of1Bsrvh78uhHUmvr7ySCVDmmARFEhhHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707666660; c=relaxed/simple;
	bh=la73JL/A1C8uRQjAcaKo8g4M6f9oZL367qO73DSOApM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=On3okp3OmGph7G+pF2UYd/6oNptK1blGPalC8yjxt56jXbjtqW+QsaaDahrddkq6l9yAELdDIRHF3ecXK/p5zauZJ7yVgAU5gJsNfD8ISdTs+Iv7c0/mqWA9GgTqtYFfCwayNbJSeBHUjo6B9G9sOYByRDMuBGB4RjXGLOLWCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Ka0K8Rd3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d72f71f222so19673365ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 07:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707666658; x=1708271458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1BNZ84Y3xDb3GMAj84ILySVuBx8QI76q/yJskyRslVo=;
        b=W9f5gv+ZHECwI7Fh9ei4nx7kQSKtpE3Cuc5f5g6oxD77YxXpi72kxFNRXLFZbsskkz
         jZgme+bUVbPUE8fh6A5LASX1DtvedWMfj+pJ0pTj0eiAvQSXcQty/a8NlA+UQW0YhBFa
         /tP3QJLpwygEKnFtirMzWVi6LuNCr2TvLIPB1yW8bwrpIefn8qxkfV6PuwH1OrRYzvvX
         HXsdNDejrmZS4bSyfkECq7A3x+jdg0ta7aMnxKQp54FoNvJ2UOUVMlGSzgq3uj9SWm1o
         Lpf7nut4iZ6Rus75M8zHC8EPIDHF7vAR/ULrh4hLK0QgpTpOzzyO7jWYwSDceLyUkV7C
         MwJA==
X-Forwarded-Encrypted: i=1; AJvYcCWWaJ9Nt65UeMB5wXyqn/AaAo/F8y7e8yQGBMzCioDi28NTSe5UTGP7rZuk7pKCkHzGG6Vs6NK2pYiqUxBC0YE8sBFeG0nYg62MHRZF
X-Gm-Message-State: AOJu0Ywn8m/o0itmNbP9HUT21+wfhtp7nhtaPwqKROzmyRLNNrQfZt4G
	AjxH8Y7zemBfeML7E5T9Md2qL892IMheJzLrjIq7+yHW90LXlanc
X-Google-Smtp-Source: AGHT+IHaj72MhLMXtnawIPoVxCOid24C0jX6e7gkX/cJBBCJhpTz6Wv6DoXLH3vtQ//rRTWankiyhw==
X-Received: by 2002:a17:902:7488:b0:1d7:133e:5c09 with SMTP id h8-20020a170902748800b001d7133e5c09mr4640406pll.22.1707666658086;
        Sun, 11 Feb 2024 07:50:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0lmC8VOnsyE6ooalTe+rlhWXzTpJzmMMMaA/Q5rTdlFModaLNpA+dEyHtBUvf36SZUkQ3SHxR80msaxMq1k/ifZey4BjHJUE6et19FuS/+/TZzZn0xiatRtK2HWYD958UuBas0csfF32d0n9+6r0vbVHdIA9ui6Da7eMKMAk9k874
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001d995305c8bsm4412107plq.290.2024.02.11.07.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 07:50:57 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707666656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1BNZ84Y3xDb3GMAj84ILySVuBx8QI76q/yJskyRslVo=;
	b=Ka0K8Rd3HPVRfMeOpn11LRm959IdRpJ5RjJ/NYx58Lx6wpHYS4LHLprOjJOO6o1D6/oMC7
	ecNazYLQtxSNRVDv20b4TZKNpsUGkuQ5KTK6kBSoXqbPwyzectNU2EQkJqmkQ62DlIpTW1
	8FciazaNJYpUydMi55iEPu3PrIiB11LWIYUIAqAbRoaOMl/E+PfSuzZn2xdP8PUlF3qoew
	63APsQ6T1b8H6LLR4o/fYtXIs+JuTRbNt/u+hZD0/SwFtD3FyvdPMaX/251kBYuFPvcrth
	tXHgWV2Hy0jQeROrXRY0GVAfIuRDvbEXIxUQikEGmWLv6m0OfoeBSirhrR5eqQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 11 Feb 2024 12:51:29 -0300
Subject: [PATCH 1/2] firmware: arm_ffa: Make ffa_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240211-bus_cleanup-firmware2-v1-1-1851c92c7be7@marliere.net>
References: <20240211-bus_cleanup-firmware2-v1-0-1851c92c7be7@marliere.net>
In-Reply-To: <20240211-bus_cleanup-firmware2-v1-0-1851c92c7be7@marliere.net>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1543; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=la73JL/A1C8uRQjAcaKo8g4M6f9oZL367qO73DSOApM=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlyO0BEZtdBTMzyUB0v3ir9NUAdEUSjuOXoVPKw
 Ajio99rre+JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcjtAQAKCRDJC4p8Y4ZY
 ptIXD/4mUxMskUGE+nNrEYzifLiSK8nfea/azJ7pr+wb2q+TIesolp2EP82z5CrE9B07oRGnjuv
 v2xvpgeBq392vt4eOGv6m4IyvojFNzjEkLsCxi+N3lvPZkC7B6U8fue5++loD/xl6AxW5BP6z8e
 W+RUQLeXmUYDGX2Qx5IHTiekL8pgoqMC8HDx9Vla2I05Xe1f4Mn80ZuXW4sIrS/deiQCN5NmsIj
 prJlAcW+kFSg3FE7QdOVOTQ4mi5TAdT722ZLpz1mbhn1d4+FHMIfvED83r0xnhhCJ9Q+k9Eh8TV
 oYJMLGBx7eowa4xe8Tl/O/yHeVK5q5xaVaPBvAtSDETNcrLVG0eyAyCDnAEaIPG/RYUK4W2Ldcg
 aHNaZKTQ7XuMGKAEHtGD2BHy/ZjxXqCA2CDgfHJxLqrVCDDw/cMKfoJcPP55cVu2dlsajFVPSR8
 aSeni8lrClSxvvMQKjS1cjkZvhhb8D+w2z26/FT1lkc/2fZlSoLJVob/BvF3CDN7ORsRbsVjRfj
 m5C5Moi97E/uMChpkPWU4iv/IJx2iijTXfIwFU41EtMDD0GnwOrEbKLA06m5m5ve0PsOLmwjZmF
 Nbv54lSBXVfAeoTjYN8Ju8Sbk5qDSnKa/lQ8WUFCfx9CwoLxa57lsE+212Vy/w0o0lO7OUY+ltA
 4385uq7vzYplz4w==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the ffa_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/firmware/arm_ffa/bus.c | 2 +-
 include/linux/arm_ffa.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index 1c7940ba5539..2f557e90f2eb 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -105,7 +105,7 @@ static struct attribute *ffa_device_attributes_attrs[] = {
 };
 ATTRIBUTE_GROUPS(ffa_device_attributes);
 
-struct bus_type ffa_bus_type = {
+const struct bus_type ffa_bus_type = {
 	.name		= "arm_ffa",
 	.match		= ffa_device_match,
 	.probe		= ffa_device_probe,
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 3d0fde57ba90..c906f666ff5d 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -209,7 +209,7 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev) { return false; }
 #define module_ffa_driver(__ffa_driver)	\
 	module_driver(__ffa_driver, ffa_register, ffa_unregister)
 
-extern struct bus_type ffa_bus_type;
+extern const struct bus_type ffa_bus_type;
 
 /* FFA transport related */
 struct ffa_partition_info {

-- 
2.43.0


