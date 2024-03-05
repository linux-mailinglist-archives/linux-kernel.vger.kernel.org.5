Return-Path: <linux-kernel+bounces-93108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3BC872B20
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455861F2545C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F001712FF9D;
	Tue,  5 Mar 2024 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ht2ltYkY"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F59E12DDB2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681686; cv=none; b=OywXj12+CPPtt9X1KDn8Ed90M+eSNxHeNUV7Z2NN8H2RRhsNZWPdYyYP1KZ7b0CPk95kcngt8SUI029OjXVmgb7IzaFvaj9E3PeCdfpUQmtMssA9sY6elY7UqrCrq2NWK7/emG3CJoNHkv9xg3Tb2liH2kR5Omf9C8MIlbxzKes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681686; c=relaxed/simple;
	bh=oKHJz8KX639JHaY4FxkGeuRgysM8ixCYP31PDePvR/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s9eHNdE+hleqOqVlljFRJgYzk5dXXXrZeyH1sq5q31Zs9O3pO6A0ce1b2Br2PmwTO8Cfw0pnmN2iux32bPn4GdF3iKac6x/CH7ZxixLSFtmKyehTf9yx9jVMvxmFNsWNyIl42VxiAyac91/YBFpA2bqMc0RNNYe/d6MMxJgBM4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ht2ltYkY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60810219282so78113727b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 15:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709681684; x=1710286484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R/Gd0jRGfWXRd5LSFgmnGhf286BOGmU7x4htLcq4bds=;
        b=ht2ltYkYovKDw+rkhfKf8Wo+0OReFa20ICI9kZuXwFDMwVBueoyUI2Co2xDjAT9IYI
         lDc6J1WERayjV/yvNVmXpUSk87eJjeHbTTQYQM2IuRmRqh5cD3DmgEaSLNpzUZ0Zohx3
         94mzdXh9Tnpu2qyEAQJvnTjScRK8M2LbLg0/sT+DkfrsKFn9tnhUvuuBzkXhHZEI5ifV
         /tfgs2mMWdRuoqTbhcQeXrKvn6nFJkPGNPJL3kcIHPgJbU+e42nQAmcTcYfCZNIxrnyV
         8rY5yq8cB8M5gerkAwrXS4tKg2FbeTf1dW9BW/413/2T9IC4K1EoOUrEjsGb5nRTp2Ck
         Jq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709681684; x=1710286484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/Gd0jRGfWXRd5LSFgmnGhf286BOGmU7x4htLcq4bds=;
        b=T3QQMCSGwGMrpLRMggkvrbLQcEydyKCSJs2pWuD+cjkAExanmx2bdFTqEJyVkh5k3d
         fY3EejN4R4Our1fLoMQ45poZqth3RMX6SRfEpd1FzUrNl31j67DhV5hN0I+cl+PwXcPT
         IM9itVy49mrkXE6nm9YztTVXPFELcOzAwESqCIg7hqEj8dfFRMaC+VSSUxM8zIDLgwUT
         dr69nfPlqNvQfonWqH+jKo6UzpetYPY2aAR0UBJl1HyfZmOnNdmfk978ed0+P4594pSx
         tmLsbMJK0OyNl+mLGa/P10e78PHqIn9UVDIamGln6C+Ru2oyPKYycY30zd38omj2nwI4
         j1wQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5u9MHgB//PjNbBuJxRjL6+A8ZtG2pmte73QhW1/txkyET1m10aXPHkQVq0V2TcHJEvmDon751wFhJiF3oxJOhHnZ2RaKimv/V9LA1
X-Gm-Message-State: AOJu0YxfecV8K4IQqrwpyxVIG+9e08AsvxN2yRWggJ4nGQtP0YHbEppj
	lZj4SescYfYX3ZbKPfB8AR8FMYKDr045kYuVuSJgRxl4mzcQpU0vtv5CsjzWuGNSrVUXEVM9N0D
	qXb2wCWQbDGA0f41GXoErVw==
X-Google-Smtp-Source: AGHT+IGAp9/lowPpevoGgxO6AVRrNKa1EDrxjPg50w1kHJVDcThAxX6KQnG119Aw9qN/A+OBNDlix25FOCb265goww==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:7947:0:b0:609:359a:9313 with SMTP
 id u68-20020a817947000000b00609359a9313mr2995157ywc.1.1709681684397; Tue, 05
 Mar 2024 15:34:44 -0800 (PST)
Date: Tue, 05 Mar 2024 23:34:38 +0000
In-Reply-To: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709681680; l=2333;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=oKHJz8KX639JHaY4FxkGeuRgysM8ixCYP31PDePvR/I=; b=it20B8oEmrPPFj34tDnAo4Ojh4hPjBzwi2qKfmpt/w+DdvBX6HYJceOYTm/Cy2VY/qxpBA2UD
 lqH/vh4t55GDuJiu/Zvhhq9hXwO+V8wMcpojq7qCbWnxBJHE5ZwhMEb
X-Mailer: b4 0.12.3
Message-ID: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-3-5b78a13ff984@google.com>
Subject: [PATCH v3 3/7] scsi: qedf: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, Kashyap Desai <kashyap.desai@broadcom.com>, 
	Sumit Saxena <sumit.saxena@broadcom.com>, Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, Ariel Elior <aelior@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, Nilesh Javali <njavali@marvell.com>, 
	Manish Rangankar <mrangankar@marvell.com>, Don Brace <don.brace@microchip.com>
Cc: mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, MPT-FusionLinux.pdl@broadcom.com, 
	netdev@vger.kernel.org, storagedev@microchip.com, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

We expect slowpath_params.name to be NUL-terminated based on its future
usage with other string APIs:

|	static int qed_slowpath_start(struct qed_dev *cdev,
|				      struct qed_slowpath_params *params)
..
|	strscpy(drv_version.name, params->name,
|		MCP_DRV_VER_STR_SIZE - 4);

Moreover, NUL-padding is not necessary as the only use for this slowpath
name parameter is to copy into the drv_version.name field.

Also, let's prefer using strscpy(src, dest, sizeof(src)) in two
instances (one of which is outside of the scsi system but it is trivial
and related to this patch).

We can see the drv_version.name size here:
|	struct qed_mcp_drv_version {
|		u32	version;
|		u8	name[MCP_DRV_VER_STR_SIZE - 4];
|	};

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/net/ethernet/qlogic/qed/qed_main.c | 2 +-
 drivers/scsi/qedf/qedf_main.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index c278f8893042..d39e198fe8db 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -1351,7 +1351,7 @@ static int qed_slowpath_start(struct qed_dev *cdev,
 				      (params->drv_rev << 8) |
 				      (params->drv_eng);
 		strscpy(drv_version.name, params->name,
-			MCP_DRV_VER_STR_SIZE - 4);
+			sizeof(drv_version.name));
 		rc = qed_mcp_send_drv_version(hwfn, hwfn->p_main_ptt,
 					      &drv_version);
 		if (rc) {
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index a58353b7b4e8..fd12439cbaab 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -3468,7 +3468,7 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 	slowpath_params.drv_minor = QEDF_DRIVER_MINOR_VER;
 	slowpath_params.drv_rev = QEDF_DRIVER_REV_VER;
 	slowpath_params.drv_eng = QEDF_DRIVER_ENG_VER;
-	strncpy(slowpath_params.name, "qedf", QED_DRV_VER_STR_SIZE);
+	strscpy(slowpath_params.name, "qedf", sizeof(slowpath_params.name));
 	rc = qed_ops->common->slowpath_start(qedf->cdev, &slowpath_params);
 	if (rc) {
 		QEDF_ERR(&(qedf->dbg_ctx), "Cannot start slowpath.\n");

-- 
2.44.0.278.ge034bb2e1d-goog


