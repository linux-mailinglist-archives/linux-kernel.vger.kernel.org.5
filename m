Return-Path: <linux-kernel+bounces-71276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3742785A2C6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D481F2214C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDC02E84A;
	Mon, 19 Feb 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="GLA3jWiP"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52DC2E832
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344154; cv=none; b=hUUIeEYKS5EcQ0YkSXhROiqj9+fMYhT1gfLefUD2SArYRghuzwe3+8MVe0/7RQiDEicOIhNHvcH64DnU7jmfmvPqB2+CJNVOFoTqPfhjhEQ0V9NU7reJULAsRUpd6VzZYTZUCCavJRzLa7/v9RbYaodf0NbX/SrzPgjswuLrLag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344154; c=relaxed/simple;
	bh=V4QRYQ76YEpXXNMyK5V0fnE0QpgAewPnLJMPRZ8+iSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GbHSWqfcYJSnp2prDg7KmT1BA44wtq0ShM2Kr8m02pLtnO6J7HIL4Iu4019ZzBjSjZyKbqyrtpJPW/HxXmSHeiGFDCfsiKe4mgqaIl4uJQDWtDwl/Cj3YyO1tyd3LQ03YwuP2XeCcl0g9Y19FpCymO52zMCP546XYgQB2LTDEBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=GLA3jWiP; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2907a17fa34so2350834a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:02:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708344152; x=1708948952;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2hACCCQq6ctsb61YdZfXiP9Cf/ZpEuBHB2ZECqqD5A=;
        b=fqkzAXb0h/XgBj9/2qdgW4qBjibcm7hpCvzVd0ZwP3RcT1pvP4lEK5NN/MQQ7umaVc
         ZDoBdJRjTcpQW3iWrO3xxinMjw1iFpHXmMYVdnCIzMBAl6BLx9ZbnDnzA0b0hWmxzif9
         OjyrUmR6FepEGG04t4ExPqwYfl9OfXmI0FrMOOiYlv6p6UQ+tfDYeEWa1in5LVvNDDEo
         PCELugrFzIzbV9T3eDCfdEHKwuYmuWJUg8HgmGgdgwxiYa4weHxY64a1C9z53ElHKJIC
         EP3N4NViEj+SKIUwIRcjPjik5LIU6O5K8LLFK5liBm/Fgf49fnqk36PW4uaswfKZAAPJ
         Saog==
X-Gm-Message-State: AOJu0YydGZUa5MUNIoOn5V51poDJyUXg50AkRFyvZB9GNx5pWd4BUmks
	3bZLlmgTNJ+i31PVL8PBGq38Bq5in6r8sWeCPk/0FEpNdtLHqPIU
X-Google-Smtp-Source: AGHT+IEO+YceAxGq2zoMcU6dSkph8vmrCIO81MsGwhvnHlOxsV6tVSs3Bi29WEspnQG7z4rGjj8g5g==
X-Received: by 2002:a17:90a:d243:b0:299:9ba4:abe6 with SMTP id o3-20020a17090ad24300b002999ba4abe6mr1749666pjw.46.1708344150939;
        Mon, 19 Feb 2024 04:02:30 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id gw3-20020a17090b0a4300b0029718f72ad3sm5126787pjb.44.2024.02.19.04.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:02:30 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708344149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H2hACCCQq6ctsb61YdZfXiP9Cf/ZpEuBHB2ZECqqD5A=;
	b=GLA3jWiPfbc35JQVF/PpwYZwxKUTNUioga/Ok1SoTYCgQTMIjQGElW2L2aK2wXrjQ1vXnE
	+rCYxAJaXrqtRLmLTM7DqEIqTmrTN+Ety2TkswvsF8iqVw0vF/kUpSO+rHVXa8hvrrP8fH
	g9KXDgectJMv8K7GmQZ9o31BzcYiaaQOP/EDwyVAYQRJo+bngUEQTxPmF7A2pVUcHVc2q0
	9YB7e/4VyDMvbnLZWmHWQtbP4/f2LufRVpOyyeUDD++NLKsvJ/iMnIgsrvY+vZJKmkEjWU
	pKakv9y0qJWVgumDUucFWnZsMJmYFnun4cOo9sAt0LD6C7r6tI9DZQOC3gLILQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 09:03:11 -0300
Subject: [PATCH next] bus: fsl-mc: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-fsl-mc-v1-1-d206b8b90f2b@marliere.net>
X-B4-Tracking: v=1; b=H4sIAH5D02UC/x2M7QpAMBRAX0X3t1sz5ONVJM12xy1GG1Ly7pafp
 845DwTyTAHa5AFPFwfeXIQsTUDPyk2EbCKDFLIQMmvQREnToBdS7tzRhgVXjaM0ta1UmYvaQGx
 3T5bv/9uBo/uA/n0/rKXtfm0AAAA=
To: Stuart Yoder <stuyoder@gmail.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6005; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=V4QRYQ76YEpXXNMyK5V0fnE0QpgAewPnLJMPRZ8+iSU=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl00OC7UwZ8Nbbx/scP4H7DsOPAQv3LfbSIDf7w
 Pd5guhK1ZOJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdNDggAKCRDJC4p8Y4ZY
 piGBD/0bu6xlhMehhehiv7GOBEfHsJlzUi2KMB8YcoxxTzu5gAxpsmRGTP+o5QPMkq4thc+fp+W
 va20fT14amRdGHGlgOHY/PbRwA86NbKik7Jnw+uuSwhONhu1Ws1c4HuYJhZG2WPcYrRZOPxEzFg
 tSu84QZEGMYqoKHPKZ4criSJXv0PqdRqhnJY/ogPbudPJd5ctRFQ17Y2Q6QoR/S/InoXVajONRy
 ICxqEbeWKlw7ikvQVIBuoCvC+5x9yWB3MkwbfG/KwCyLgPNyPB/bID8qw8avDrIR6O+JdYCuhzy
 a4YTpf2/UYIgM+s+3SXZE8JWoscZVB2OV0/4YrdHga8/nzW8OPVdBeFDeyOGZADigEjWo+11cMm
 tf0AgyJlzCXdTAjKOQ0vqzJiUMOizGok7hK6/krmlLyGiYgnDQKQTmTNG9xf0xf6seVe0mnVMnw
 u1sL6Iukrfek7rNZ7jHLfg+09qd59fTU5X4JZEOlLWweCZSiS7PlmiIdV2S45lNEGL4C/6O3sNm
 TXGCDlf1NrxfAT+L+mf+c87pl5Hny3fzmrcy9H1FxZzs37TlQhYsHsnfNOKzepW5BZ7dRNoCa9m
 +R1QjJPzW+wKNgvVZBtBAdGaSC+VMXCCSZisoeyiZhBwXeA64gJ4kMb8hfNqmGGtqLRQb80OI/h
 1dl9deN300fRuyQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move all the
device_type variables used in the bus to be constant structures as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 32 ++++++++++++++++----------------
 include/linux/fsl/mc.h          | 30 +++++++++++++++---------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 78b96cd63de9..f75ca3f0d75a 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -320,82 +320,82 @@ struct bus_type fsl_mc_bus_type = {
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
 
-struct device_type fsl_mc_bus_dprc_type = {
+const struct device_type fsl_mc_bus_dprc_type = {
 	.name = "fsl_mc_bus_dprc"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dprc_type);
 
-struct device_type fsl_mc_bus_dpni_type = {
+const struct device_type fsl_mc_bus_dpni_type = {
 	.name = "fsl_mc_bus_dpni"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpni_type);
 
-struct device_type fsl_mc_bus_dpio_type = {
+const struct device_type fsl_mc_bus_dpio_type = {
 	.name = "fsl_mc_bus_dpio"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpio_type);
 
-struct device_type fsl_mc_bus_dpsw_type = {
+const struct device_type fsl_mc_bus_dpsw_type = {
 	.name = "fsl_mc_bus_dpsw"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpsw_type);
 
-struct device_type fsl_mc_bus_dpbp_type = {
+const struct device_type fsl_mc_bus_dpbp_type = {
 	.name = "fsl_mc_bus_dpbp"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpbp_type);
 
-struct device_type fsl_mc_bus_dpcon_type = {
+const struct device_type fsl_mc_bus_dpcon_type = {
 	.name = "fsl_mc_bus_dpcon"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpcon_type);
 
-struct device_type fsl_mc_bus_dpmcp_type = {
+const struct device_type fsl_mc_bus_dpmcp_type = {
 	.name = "fsl_mc_bus_dpmcp"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpmcp_type);
 
-struct device_type fsl_mc_bus_dpmac_type = {
+const struct device_type fsl_mc_bus_dpmac_type = {
 	.name = "fsl_mc_bus_dpmac"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpmac_type);
 
-struct device_type fsl_mc_bus_dprtc_type = {
+const struct device_type fsl_mc_bus_dprtc_type = {
 	.name = "fsl_mc_bus_dprtc"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dprtc_type);
 
-struct device_type fsl_mc_bus_dpseci_type = {
+const struct device_type fsl_mc_bus_dpseci_type = {
 	.name = "fsl_mc_bus_dpseci"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpseci_type);
 
-struct device_type fsl_mc_bus_dpdmux_type = {
+const struct device_type fsl_mc_bus_dpdmux_type = {
 	.name = "fsl_mc_bus_dpdmux"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpdmux_type);
 
-struct device_type fsl_mc_bus_dpdcei_type = {
+const struct device_type fsl_mc_bus_dpdcei_type = {
 	.name = "fsl_mc_bus_dpdcei"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpdcei_type);
 
-struct device_type fsl_mc_bus_dpaiop_type = {
+const struct device_type fsl_mc_bus_dpaiop_type = {
 	.name = "fsl_mc_bus_dpaiop"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpaiop_type);
 
-struct device_type fsl_mc_bus_dpci_type = {
+const struct device_type fsl_mc_bus_dpci_type = {
 	.name = "fsl_mc_bus_dpci"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpci_type);
 
-struct device_type fsl_mc_bus_dpdmai_type = {
+const struct device_type fsl_mc_bus_dpdmai_type = {
 	.name = "fsl_mc_bus_dpdmai"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpdmai_type);
 
-struct device_type fsl_mc_bus_dpdbg_type = {
+const struct device_type fsl_mc_bus_dpdbg_type = {
 	.name = "fsl_mc_bus_dpdbg"
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_dpdbg_type);
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index a1b3de87a3d1..4b9311f122e0 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -438,21 +438,21 @@ struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
 
 extern struct bus_type fsl_mc_bus_type;
 
-extern struct device_type fsl_mc_bus_dprc_type;
-extern struct device_type fsl_mc_bus_dpni_type;
-extern struct device_type fsl_mc_bus_dpio_type;
-extern struct device_type fsl_mc_bus_dpsw_type;
-extern struct device_type fsl_mc_bus_dpbp_type;
-extern struct device_type fsl_mc_bus_dpcon_type;
-extern struct device_type fsl_mc_bus_dpmcp_type;
-extern struct device_type fsl_mc_bus_dpmac_type;
-extern struct device_type fsl_mc_bus_dprtc_type;
-extern struct device_type fsl_mc_bus_dpseci_type;
-extern struct device_type fsl_mc_bus_dpdmux_type;
-extern struct device_type fsl_mc_bus_dpdcei_type;
-extern struct device_type fsl_mc_bus_dpaiop_type;
-extern struct device_type fsl_mc_bus_dpci_type;
-extern struct device_type fsl_mc_bus_dpdmai_type;
+extern const struct device_type fsl_mc_bus_dprc_type;
+extern const struct device_type fsl_mc_bus_dpni_type;
+extern const struct device_type fsl_mc_bus_dpio_type;
+extern const struct device_type fsl_mc_bus_dpsw_type;
+extern const struct device_type fsl_mc_bus_dpbp_type;
+extern const struct device_type fsl_mc_bus_dpcon_type;
+extern const struct device_type fsl_mc_bus_dpmcp_type;
+extern const struct device_type fsl_mc_bus_dpmac_type;
+extern const struct device_type fsl_mc_bus_dprtc_type;
+extern const struct device_type fsl_mc_bus_dpseci_type;
+extern const struct device_type fsl_mc_bus_dpdmux_type;
+extern const struct device_type fsl_mc_bus_dpdcei_type;
+extern const struct device_type fsl_mc_bus_dpaiop_type;
+extern const struct device_type fsl_mc_bus_dpci_type;
+extern const struct device_type fsl_mc_bus_dpdmai_type;
 
 static inline bool is_fsl_mc_bus_dprc(const struct fsl_mc_device *mc_dev)
 {

---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240219-device_cleanup-fsl-mc-b2d8f7a5308d

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


