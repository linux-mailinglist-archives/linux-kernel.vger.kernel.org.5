Return-Path: <linux-kernel+bounces-126668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38807893B3D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4BCB21931
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9D43E49C;
	Mon,  1 Apr 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gKtEF0Vm"
Received: from msa.smtpout.orange.fr (msa-209.smtpout.orange.fr [193.252.23.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC72383BA;
	Mon,  1 Apr 2024 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711976911; cv=none; b=UEdUH/Zu68KanzNjSc6dY9ZxPmnJooV5HvVMUIuRCbpzKzTbr4aSbPB9g6Su3EoLYS5n5yKgfK7SG9FG6id/QetcuvKEu/BXHtNWCRQS6Dk2XfB/x4SHb53WNPQslN0zhi/mze7Rj2Mxcuw/2jyMAGe6TbOwQguTRUsu/N4+rPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711976911; c=relaxed/simple;
	bh=3j7ZintJt6IY5YGQgufV4/rhKwMzKzmHz80qDoMWNpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ASQf53s+6DkcTkkPOQU7xjkL4aIturJuSZGCDxf8KZia1kFovQbXwUrF4F+E9Wk/8Pi68YQ91liWyCz03RGiHFW6SU10oyGdU+bYw3SOeHDztqNDd8aVLcQ8sXeEN2WEvzc7QXYhj+43DJsEPkrkzMfNHH4PKMvD2ykmEQPpd/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gKtEF0Vm; arc=none smtp.client-ip=193.252.23.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id rHOirI9t6uWdGrHOirOs7H; Mon, 01 Apr 2024 15:08:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1711976906;
	bh=98Z2FPBJRx39uUlwlsoLLukd26uFSpPNJzTdkcV+H8w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=gKtEF0Vm22hOmvVP8w6nKcQh5fM++77MKgJMF9Kn/o4hD9TNHriG3fQoUlowHZAHJ
	 NC7HGj449Mwrhz6bFSTkQCeObs7suwY6heb8Myi68AYHyFT+BE0HZBXaCID9uW8KO7
	 0BlTf4PgYxGFhUzKatCX00j2qZ0tLmuPmw5MjXVzw9Ah1C5TrSXy1lVyFhrcE/ihiH
	 bbV/CsipxrgwoY443nyTUVWMOz2heEJSZNtbmYV95/IooilM647eM+YCo9y/8M82mV
	 dVFQfsNonO2xFXqyNgWSI3AT5jmRYpg+wkT8bBZ1AJCgJCMtOz/NsH06r8EvVnUC0o
	 kQ+5itbwPD8ng==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 01 Apr 2024 15:08:26 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-fpga@vger.kernel.org
Subject: [PATCH] fpga: altera-cvp: Remove an unused field in struct altera_cvp_conf
Date: Mon,  1 Apr 2024 15:08:21 +0200
Message-ID: <7986690e79fa6f7880bc1db783cb0e46a1c2723e.1711976883.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct altera_cvp_conf", the 'mgr' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Apparently, it has never been used. It is not a left-over from a
refactoring.

The address of the 'fpga_manager' is handled via pci_[s|g]et_drvdata().

Compile tested only.
---
 drivers/fpga/altera-cvp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 4ffb9da537d8..6b0914432445 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -72,7 +72,6 @@ static bool altera_cvp_chkcfg;
 struct cvp_priv;
 
 struct altera_cvp_conf {
-	struct fpga_manager	*mgr;
 	struct pci_dev		*pci_dev;
 	void __iomem		*map;
 	void			(*write_data)(struct altera_cvp_conf *conf,
-- 
2.44.0


