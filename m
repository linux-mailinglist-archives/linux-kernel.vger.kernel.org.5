Return-Path: <linux-kernel+bounces-4350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 006F2817BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA8C1F2466C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06B974097;
	Mon, 18 Dec 2023 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjoclVYz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5237349E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702931310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOWn0wj6qXxxeTngLZ5KOGdMqo1DcukWPJi/j2lPYpM=;
	b=PjoclVYz9Y73PqGw4yXSUhhRwR4TcWqMwXulDGUMz0Z72XPfdTImjreDxjHdpFPbh3AbSJ
	9nweWUvzLOfVlMzn0x0Uv5Ra0pPTPoyRPbA0wx5W4e2wV34wKRoULMaeJbGLqUc0jk8GjH
	UCbGfb/MPinSwQ+KSh2WTR43cuFl6wE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-ws12NWgcNCuxoApUFSJLRQ-1; Mon, 18 Dec 2023 15:28:28 -0500
X-MC-Unique: ws12NWgcNCuxoApUFSJLRQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c514f9243so25052135e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:28:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702931307; x=1703536107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOWn0wj6qXxxeTngLZ5KOGdMqo1DcukWPJi/j2lPYpM=;
        b=GPRK6kDa55W1M4cQvNuGo78ZnG8XemA5G90Hg4HOrxkuS2f3VuwwmzhV1eqdPiY8ju
         zlXcP7caX1Ir9778bUvwNuyYuqMTwP6+jDXovOskvsQqAUov4QgXT4dLV1oUKhYKdk1Z
         LXDkkI+p5YM4vpMvqgawS5gRGA4A+0lDzbmK1M609PcZ4O0LW3ldXMw09CywmM2MVg0R
         l/wu8qqX+uYH1Q096RCp0kN9zzMHGI4s4fvjlFLh8gz3c8kF0G+6BEO4HnYfQFXcFjNQ
         G6Fli6uWQTXSZwVpmtAcI2AinQ1TEvM1nJ/kvDw5eVXyeqgff6xA2FWWrPkjTPOfYf1u
         EA1A==
X-Gm-Message-State: AOJu0YwNw4ep3ADT10ClPKZLf4WxUGtJ11oZ60nizgCsmtaznsTK9Pt1
	rtSNSrsdqhM0ptLSQs0hYMhw/p2i+0f15Gbjzh2yCrZprXlykfPf7kITjhx/Jltn0rlzhaDnym9
	fTwghoATh6OdyF+XvKw1sZw8=
X-Received: by 2002:a05:600c:a05:b0:40d:1748:d0aa with SMTP id z5-20020a05600c0a0500b0040d1748d0aamr1672747wmp.100.1702931307710;
        Mon, 18 Dec 2023 12:28:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHy4tnHt3nijGGcXssK3ZXuXwABkOFt85EuXUEgUmM1Fa5xYettK+MtYLbbXXwZG2y8eX++YQ==
X-Received: by 2002:a05:600c:a05:b0:40d:1748:d0aa with SMTP id z5-20020a05600c0a0500b0040d1748d0aamr1672742wmp.100.1702931307492;
        Mon, 18 Dec 2023 12:28:27 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c1d8300b0040d1450ca7esm9487652wms.7.2023.12.18.12.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 12:28:27 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [RFC PATCH v3 2/2] fpga: set owner of fpga_manager_ops for existing low-level modules
Date: Mon, 18 Dec 2023 21:28:09 +0100
Message-ID: <20231218202809.84253-3-marpagan@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218202809.84253-1-marpagan@redhat.com>
References: <20231218202809.84253-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch tentatively set the owner field of fpga_manager_ops to
THIS_MODULE for existing fpga manager low-level control modules.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/altera-cvp.c             | 1 +
 drivers/fpga/altera-pr-ip-core.c      | 1 +
 drivers/fpga/altera-ps-spi.c          | 1 +
 drivers/fpga/dfl-fme-mgr.c            | 1 +
 drivers/fpga/ice40-spi.c              | 1 +
 drivers/fpga/lattice-sysconfig.c      | 1 +
 drivers/fpga/machxo2-spi.c            | 1 +
 drivers/fpga/microchip-spi.c          | 1 +
 drivers/fpga/socfpga-a10.c            | 1 +
 drivers/fpga/socfpga.c                | 1 +
 drivers/fpga/stratix10-soc.c          | 1 +
 drivers/fpga/tests/fpga-mgr-test.c    | 1 +
 drivers/fpga/tests/fpga-region-test.c | 1 +
 drivers/fpga/ts73xx-fpga.c            | 1 +
 drivers/fpga/versal-fpga.c            | 1 +
 drivers/fpga/xilinx-spi.c             | 1 +
 drivers/fpga/zynq-fpga.c              | 1 +
 drivers/fpga/zynqmp-fpga.c            | 1 +
 18 files changed, 18 insertions(+)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 4ffb9da537d8..aeb913547dd8 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -520,6 +520,7 @@ static const struct fpga_manager_ops altera_cvp_ops = {
 	.write_init	= altera_cvp_write_init,
 	.write		= altera_cvp_write,
 	.write_complete	= altera_cvp_write_complete,
+	.owner		= THIS_MODULE,
 };
 
 static const struct cvp_priv cvp_priv_v1 = {
diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index df8671af4a92..354221c609e6 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -171,6 +171,7 @@ static const struct fpga_manager_ops alt_pr_ops = {
 	.write_init = alt_pr_fpga_write_init,
 	.write = alt_pr_fpga_write,
 	.write_complete = alt_pr_fpga_write_complete,
+	.owner = THIS_MODULE,
 };
 
 int alt_pr_register(struct device *dev, void __iomem *reg_base)
diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 740980e7cef8..3be05796a6fc 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -228,6 +228,7 @@ static const struct fpga_manager_ops altera_ps_ops = {
 	.write_init = altera_ps_write_init,
 	.write = altera_ps_write,
 	.write_complete = altera_ps_write_complete,
+	.owner = THIS_MODULE,
 };
 
 static int altera_ps_probe(struct spi_device *spi)
diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index ab228d8837a0..740ce82e3ac9 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -264,6 +264,7 @@ static const struct fpga_manager_ops fme_mgr_ops = {
 	.write = fme_mgr_write,
 	.write_complete = fme_mgr_write_complete,
 	.status = fme_mgr_status,
+	.owner = THIS_MODULE,
 };
 
 static void fme_mgr_get_compat_id(void __iomem *fme_pr,
diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index 7cbb3558b844..97afa6dc5d76 100644
--- a/drivers/fpga/ice40-spi.c
+++ b/drivers/fpga/ice40-spi.c
@@ -130,6 +130,7 @@ static const struct fpga_manager_ops ice40_fpga_ops = {
 	.write_init = ice40_fpga_ops_write_init,
 	.write = ice40_fpga_ops_write,
 	.write_complete = ice40_fpga_ops_write_complete,
+	.owner = THIS_MODULE,
 };
 
 static int ice40_fpga_probe(struct spi_device *spi)
diff --git a/drivers/fpga/lattice-sysconfig.c b/drivers/fpga/lattice-sysconfig.c
index ba51a60f672f..1393cdd11e49 100644
--- a/drivers/fpga/lattice-sysconfig.c
+++ b/drivers/fpga/lattice-sysconfig.c
@@ -348,6 +348,7 @@ static const struct fpga_manager_ops sysconfig_fpga_mgr_ops = {
 	.write_init = sysconfig_ops_write_init,
 	.write = sysconfig_ops_write,
 	.write_complete = sysconfig_ops_write_complete,
+	.owner = THIS_MODULE,
 };
 
 int sysconfig_probe(struct sysconfig_priv *priv)
diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index 905607992a12..46193a47f863 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -358,6 +358,7 @@ static const struct fpga_manager_ops machxo2_ops = {
 	.write_init = machxo2_write_init,
 	.write = machxo2_write,
 	.write_complete = machxo2_write_complete,
+	.owner = THIS_MODULE,
 };
 
 static int machxo2_spi_probe(struct spi_device *spi)
diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 2a82c726d6e5..023ccdf2d5da 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -362,6 +362,7 @@ static const struct fpga_manager_ops mpf_ops = {
 	.write_init = mpf_ops_write_init,
 	.write = mpf_ops_write,
 	.write_complete = mpf_ops_write_complete,
+	.owner = THIS_MODULE,
 };
 
 static int mpf_probe(struct spi_device *spi)
diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index cc4861e345c9..a8ab74b30006 100644
--- a/drivers/fpga/socfpga-a10.c
+++ b/drivers/fpga/socfpga-a10.c
@@ -463,6 +463,7 @@ static const struct fpga_manager_ops socfpga_a10_fpga_mgr_ops = {
 	.write_init = socfpga_a10_fpga_write_init,
 	.write = socfpga_a10_fpga_write,
 	.write_complete = socfpga_a10_fpga_write_complete,
+	.owner = THIS_MODULE,
 };
 
 static int socfpga_a10_fpga_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index 723ea0ad3f09..87f3f4a367d0 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -538,6 +538,7 @@ static const struct fpga_manager_ops socfpga_fpga_ops = {
 	.write_init = socfpga_fpga_ops_configure_init,
 	.write = socfpga_fpga_ops_configure_write,
 	.write_complete = socfpga_fpga_ops_configure_complete,
+	.owner = THIS_MODULE,
 };
 
 static int socfpga_fpga_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index cacb9cc5757e..63a5a2fe4911 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -393,6 +393,7 @@ static const struct fpga_manager_ops s10_ops = {
 	.write_init = s10_ops_write_init,
 	.write = s10_ops_write,
 	.write_complete = s10_ops_write_complete,
+	.owner = THIS_MODULE,
 };
 
 static int s10_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
index 6acec55b60ce..4c2a3e98f8ad 100644
--- a/drivers/fpga/tests/fpga-mgr-test.c
+++ b/drivers/fpga/tests/fpga-mgr-test.c
@@ -187,6 +187,7 @@ static const struct fpga_manager_ops fake_mgr_ops = {
 	.write = op_write,
 	.write_sg = op_write_sg,
 	.write_complete = op_write_complete,
+	.owner = THIS_MODULE,
 };
 
 static void fpga_mgr_test_get(struct kunit *test)
diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
index baab07e3fc59..2705c1b33d09 100644
--- a/drivers/fpga/tests/fpga-region-test.c
+++ b/drivers/fpga/tests/fpga-region-test.c
@@ -52,6 +52,7 @@ static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
  */
 static const struct fpga_manager_ops fake_mgr_ops = {
 	.write = op_write,
+	.owner = THIS_MODULE,
 };
 
 static int op_enable_set(struct fpga_bridge *bridge, bool enable)
diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
index 4e1d2a4d3df4..20b8db0d150a 100644
--- a/drivers/fpga/ts73xx-fpga.c
+++ b/drivers/fpga/ts73xx-fpga.c
@@ -96,6 +96,7 @@ static const struct fpga_manager_ops ts73xx_fpga_ops = {
 	.write_init	= ts73xx_fpga_write_init,
 	.write		= ts73xx_fpga_write,
 	.write_complete	= ts73xx_fpga_write_complete,
+	.owner		= THIS_MODULE,
 };
 
 static int ts73xx_fpga_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/versal-fpga.c b/drivers/fpga/versal-fpga.c
index 3710e8f01be2..02fd8ed36ff0 100644
--- a/drivers/fpga/versal-fpga.c
+++ b/drivers/fpga/versal-fpga.c
@@ -40,6 +40,7 @@ static int versal_fpga_ops_write(struct fpga_manager *mgr,
 static const struct fpga_manager_ops versal_fpga_ops = {
 	.write_init = versal_fpga_ops_write_init,
 	.write = versal_fpga_ops_write,
+	.owner = THIS_MODULE,
 };
 
 static int versal_fpga_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index e1a227e7ff2a..d58cf0ccbd41 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -218,6 +218,7 @@ static const struct fpga_manager_ops xilinx_spi_ops = {
 	.write_init = xilinx_spi_write_init,
 	.write = xilinx_spi_write,
 	.write_complete = xilinx_spi_write_complete,
+	.owner = THIS_MODULE,
 };
 
 static int xilinx_spi_probe(struct spi_device *spi)
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 96611d424a10..241e1fe48a13 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -548,6 +548,7 @@ static const struct fpga_manager_ops zynq_fpga_ops = {
 	.write_init = zynq_fpga_ops_write_init,
 	.write_sg = zynq_fpga_ops_write,
 	.write_complete = zynq_fpga_ops_write_complete,
+	.owner = THIS_MODULE,
 };
 
 static int zynq_fpga_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index f3434e2c487b..2f66400d2330 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -101,6 +101,7 @@ static const struct fpga_manager_ops zynqmp_fpga_ops = {
 	.state = zynqmp_fpga_ops_state,
 	.write_init = zynqmp_fpga_ops_write_init,
 	.write = zynqmp_fpga_ops_write,
+	.owner = THIS_MODULE,
 };
 
 static int zynqmp_fpga_probe(struct platform_device *pdev)
-- 
2.43.0


