Return-Path: <linux-kernel+bounces-106274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E27DE87EBB9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B46B21937
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDD24F898;
	Mon, 18 Mar 2024 15:09:43 +0000 (UTC)
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617064F1EB;
	Mon, 18 Mar 2024 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774583; cv=none; b=VJkRHCHxieTuP+mPChrgrR05X7yBbf00fpduBCn68wzQKOFmboeyQDGMjlqeYWd9x3uRxAq5VJFsg2FOqC1gGOZOzwNFYt8ZSSMgfquU4Uz6QCEP0zeARQ4z7JJyM98IA7SU+XcLYQ8P/td4y4vRprXKb9yEK7uMv7C6ooj1MNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774583; c=relaxed/simple;
	bh=FipI5WsNECJeOw6c7DF39GapkTYB24oPG38+PzmCmUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o13HcvXzzJwBgIGpJlv07tDTrT47GgK/2mzOe8+TJrHEf4uRF8WLH00cmrC95GE7xrBXnJFEkF8vQ3hXZX/FVukGjj7C3fxZZRMGm/fCrB7SvQ2+SoSBKIZ6RDt0KH5I58eA5EP+ePEISfcgSl8HtzBgIScpZkfweK1X7h2q6kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from mgb4.digiteq.red (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id 13E7853CF0;
	Mon, 18 Mar 2024 16:09:32 +0100 (CET)
From: tumic@gpxsee.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH] media: admin-guide: Fix mgb4 driver documentation structure
Date: Mon, 18 Mar 2024 17:09:19 +0100
Message-ID: <20240318160919.6144-1-tumic@gpxsee.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martin Tůma <martin.tuma@digiteqautomotive.com>

Fix the mgb4 driver documentation structure that breaks the "Video4Linux (V4L)
driver-specific documentation" outline.

Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
---
 Documentation/admin-guide/media/mgb4.rst | 35 ++++++++++--------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/media/mgb4.rst b/Documentation/admin-guide/media/mgb4.rst
index 2977f74d7e26..e434d4a9eeb3 100644
--- a/Documentation/admin-guide/media/mgb4.rst
+++ b/Documentation/admin-guide/media/mgb4.rst
@@ -1,8 +1,10 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-====================
-mgb4 sysfs interface
-====================
+The mgb4 driver
+===============
+
+sysfs interface
+---------------
 
 The mgb4 driver provides a sysfs interface, that is used to configure video
 stream related parameters (some of them must be set properly before the v4l2
@@ -12,9 +14,8 @@ There are two types of parameters - global / PCI card related, found under
 ``/sys/class/video4linux/videoX/device`` and module specific found under
 ``/sys/class/video4linux/videoX``.
 
-
 Global (PCI card) parameters
-============================
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 **module_type** (R):
     Module type.
@@ -42,9 +43,8 @@ Global (PCI card) parameters
 
     where each component is a 8b number.
 
-
 Common FPDL3/GMSL input parameters
-==================================
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 **input_id** (R):
     Input number ID, zero based.
@@ -190,9 +190,8 @@ Common FPDL3/GMSL input parameters
     *Note: This parameter can not be changed while the input v4l2 device is
     open.*
 
-
 Common FPDL3/GMSL output parameters
-===================================
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 **output_id** (R):
     Output number ID, zero based.
@@ -282,9 +281,8 @@ Common FPDL3/GMSL output parameters
     Number of video lines between the end of the last valid pixel line (marked
     by DE=1) and assertion of the VSYNC signal. The default value is 2.
 
-
 FPDL3 specific input parameters
-===============================
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 **fpdl3_input_width** (RW):
     Number of deserializer input lines.
@@ -294,7 +292,7 @@ FPDL3 specific input parameters
     | 2 - dual
 
 FPDL3 specific output parameters
-================================
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 **fpdl3_output_width** (RW):
     Number of serializer output lines.
@@ -304,7 +302,7 @@ FPDL3 specific output parameters
     | 2 - dual
 
 GMSL specific input parameters
-==============================
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 **gmsl_mode** (RW):
     GMSL speed mode.
@@ -328,10 +326,8 @@ GMSL specific input parameters
     | 0 - disabled
     | 1 - enabled (default)
 
-
-====================
-mgb4 mtd partitions
-====================
+MTD partitions
+--------------
 
 The mgb4 driver creates a MTD device with two partitions:
  - mgb4-fw.X - FPGA firmware.
@@ -344,9 +340,8 @@ also have a third partition named *mgb4-flash* available in the system. This
 partition represents the whole, unpartitioned, card's FLASH memory and one should
 not fiddle with it...
 
-====================
-mgb4 iio (triggers)
-====================
+IIO (triggers)
+--------------
 
 The mgb4 driver creates an Industrial I/O (IIO) device that provides trigger and
 signal level status capability. The following scan elements are available:

base-commit: b14257abe7057def6127f6fb2f14f9adc8acabdb
-- 
2.44.0


