Return-Path: <linux-kernel+bounces-120513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013B388D893
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B096029F10D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8252E631;
	Wed, 27 Mar 2024 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="ZQUj/FRx"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64283612A;
	Wed, 27 Mar 2024 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527353; cv=none; b=cCwZYhLlHjGslmPLYJmwcrXagcrrpUotb6vacb+gYdT+2abWFdK+ymg/ASBhgGmls2/40ibYIro+zWTUuiwqNen8gu6uskkZ4ugHdyQ2ZsHrTgRQ2OLz1ZX/yzzlE9Au0k0del2UzXhQkdUSwCIEFqa5+Tthx5r0P95XK+uRu04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527353; c=relaxed/simple;
	bh=9zW+dvDM9/wXQGn6EIf+QJxDDRQRin0FzQ+DyTde2Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tt/EzhSaX/V50ANVGID/T+Oz0QpVIOo2l6X0A+g1Xo8m2MXQIHhGYCvlDuq09khHiJyCVUaiA2/u+5qrkPjE0xw0yUTYBohluIQlJFRHCyAWql3OaR81h316fzXduCJO49wejxEiq9BqXja/IuS64EiTiBDGd4LvefmotyUwaR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=ZQUj/FRx; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 8024B60462;
	Wed, 27 Mar 2024 08:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711527351;
	bh=9zW+dvDM9/wXQGn6EIf+QJxDDRQRin0FzQ+DyTde2Ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQUj/FRx6Z2EBttCnOxNBpRmzX3KS+Eblq3ZQB3XmS2FOYbaf/yhuc8iPx1Mhn7Rg
	 C+95PUM0+UkD5hvMc/Gn5XEbMjwHgHZr+p4pqHkcEwzpyEt5pV+pGr6yxE8lWQqDXM
	 i9AXJTs2QcNoOkFhj7KgStWLX5MJfok7POS9HhDszrw4h7/z+axRjOtz/mDX2uNBGu
	 6QU6jA8sXYyxEV1rdkXMM+rxn/jNYBVvOqHQ2sJQui19zNH2CDWDIt6UWBKbCnhUAH
	 DyBhuCb+uQ1AQLhilwMTyGYhSEtpy8dMSBQEMIkB/gUj3bhpMfQ/BRjRPdQ4Fc0m85
	 0rLnRWXphxS0w==
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] bus: ti-sysc: Add a description and copyrights
Date: Wed, 27 Mar 2024 10:15:05 +0200
Message-ID: <20240327081508.36747-3-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327081508.36747-1-tony@atomide.com>
References: <20240327081508.36747-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ti-sysc driver is missing coprights and description, let's add
those.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1,6 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * ti-sysc.c - Texas Instruments sysc interconnect target driver
+ *
+ * TI SoCs have an interconnect target wrapper IP for many devices. The wrapper
+ * IP manages clock gating, resets, and PM capabilities for the connected devices.
+ *
+ * Copyright (C) 2017-2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * Many features are based on the earlier omap_hwmod arch code with thanks to all
+ * the people who developed and debugged the code over the years:
+ *
+ * Copyright (C) 2009-2011 Nokia Corporation
+ * Copyright (C) 2011-2012 Texas Instruments, Inc.
  */
 
 #include <linux/io.h>
-- 
2.44.0

