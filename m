Return-Path: <linux-kernel+bounces-12834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9BE81FAB3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27221F22EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 19:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8727C111AA;
	Thu, 28 Dec 2023 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AD8olIbS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED010A2C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-594c253f037so1305302eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 11:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703791484; x=1704396284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdRA67GFcUxloyx4tvXG24BR0us5wKd/dCuK68J3MHc=;
        b=AD8olIbSF1T9ru3ZOHQxMGmG2zoh3Hqx+EreWVlsZudz0c3rLRO1Ytuy3YgGDXuiH3
         Ny0UDLezhJbnTR7m+sp1q7aaR0JpmtkW/tsR1hcepxc9NazcQ/sE2F0uSFffrcfNjW2T
         NSXeMpUQz54Xz55KaYzB3PxA8M2sqhT6cpxdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703791484; x=1704396284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdRA67GFcUxloyx4tvXG24BR0us5wKd/dCuK68J3MHc=;
        b=hLzlkg8c3dBk6CcDzVRuzaz1xrueUMZdb+kvQc2E4fXKdVu9O1yVwxy5X5PZ0W3ZTw
         O9jM6KMASyD/kCWP+36hv2yn74RGqI8JUfKf6wA+vHDIokbdpFVPOTEu1kH8bC7+DESP
         4cEtvLN+4odfri6/ED8EP4IV9TH0A3cvV05Hcs6eDA3DcL6x5JH0Cf6wVhHUkDXoq611
         RGBjrbROD7wx0gSd0ZPlbi6wOd92FzuZzYQdBHW3y5onkHCInDRLwJZMwXVlB0B3twJF
         q0Z98ljEWHGaM90n/lrczz+WDg4ypqUdQr70eCqrA1gYtqSU7B4SbMBke2vYD3RqDaYO
         NP1Q==
X-Gm-Message-State: AOJu0Yxpos8wolE2tOeZ60FrHdRGhzQ5zH8aR9zdOqibnJzWi64cgQ96
	3j+VnWpEYIbyvQ6ALcTmBWNjrMY/wKCiylRTBhMC8ckoVXou5/ScGGHKtymH369X05qBrQjNiky
	R5ng5FKyLvnn52sgeJY9qhQtSbinK2UikpM0qeHv+y2jG5o6HCeQKGDOZTrPUXP4wZ4AoT/CiP9
	lttpZObMhEOLrsu4li7iXgV+s=
X-Google-Smtp-Source: AGHT+IGHYW0xYeyV3d3r2997V8Recw3s/K6MrDUwDBVQ7/8JTxUclwzguPNHYesx6/e0rfKwu0U8Qw==
X-Received: by 2002:a05:6358:103:b0:174:dc10:e528 with SMTP id f3-20020a056358010300b00174dc10e528mr5198591rwa.39.1703791484151;
        Thu, 28 Dec 2023 11:24:44 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id k16-20020aa79990000000b006d9aa04574csm9522987pfh.52.2023.12.28.11.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 11:24:43 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	namit@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	jsipek@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com
Subject: [PATCH v4 3/6] ptp/vmware: Use VMware hypercall API
Date: Thu, 28 Dec 2023 11:24:18 -0800
Message-Id: <20231228192421.29894-4-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20231228192421.29894-1-alexey.makhalov@broadcom.com>
References: <20231228192421.29894-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Makhalov <amakhalov@vmware.com>

Switch from VMWARE_HYPERCALL macro to vmware_hypercall API.
Eliminate arch specific code. No functional changes intended.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Nadav Amit <namit@vmware.com>
Reviewed-by: Jeff Sipek <jsipek@vmware.com>
---
 drivers/ptp/ptp_vmw.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
index 27c5547aa8a9..e5bb521b9b82 100644
--- a/drivers/ptp/ptp_vmw.c
+++ b/drivers/ptp/ptp_vmw.c
@@ -14,7 +14,6 @@
 #include <asm/hypervisor.h>
 #include <asm/vmware.h>
 
-#define VMWARE_MAGIC 0x564D5868
 #define VMWARE_CMD_PCLK(nr) ((nr << 16) | 97)
 #define VMWARE_CMD_PCLK_GETTIME VMWARE_CMD_PCLK(0)
 
@@ -24,15 +23,10 @@ static struct ptp_clock *ptp_vmw_clock;
 
 static int ptp_vmw_pclk_read(u64 *ns)
 {
-	u32 ret, nsec_hi, nsec_lo, unused1, unused2, unused3;
-
-	asm volatile (VMWARE_HYPERCALL :
-		"=a"(ret), "=b"(nsec_hi), "=c"(nsec_lo), "=d"(unused1),
-		"=S"(unused2), "=D"(unused3) :
-		"a"(VMWARE_MAGIC), "b"(0),
-		"c"(VMWARE_CMD_PCLK_GETTIME), "d"(0) :
-		"memory");
+	u32 ret, nsec_hi, nsec_lo;
 
+	ret = vmware_hypercall3(VMWARE_CMD_PCLK_GETTIME, 0,
+				&nsec_hi, &nsec_lo);
 	if (ret == 0)
 		*ns = ((u64)nsec_hi << 32) | nsec_lo;
 	return ret;
-- 
2.39.0


