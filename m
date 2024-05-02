Return-Path: <linux-kernel+bounces-166731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B378B9E9A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54508B27286
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584D858AA3;
	Thu,  2 May 2024 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ka+j6hsS"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B2216D32E
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667466; cv=none; b=HKQPPA0+W93D8D4hFYRkggW283WtCunO4YIE0+GQSA0NPCztNmHHX1S0DSe50nsL6D5nz7lv6i7aTJuAMsfWSHYKRDrNHd6xf7cSoo8XM8AUHI3RIldUJd/ue+RJW088IsSlZg3rpBA1kwk4uek9yhhBonRDwyxSRCpN5Ng91gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667466; c=relaxed/simple;
	bh=7tqFLXEGX1hzMxf0x/3E/Y7L0Jk4uLDGDQtll/rrlRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzFVI1edm+A9XzB5oQC1FNiF4LkA+AAqjWmxeyKfKQS+RTHiIL+WFPvHgyAwnYE8oIeebEo88z2Z28voNAl5LRr8JVbONSSjPPL4NAhGHaWCt4GO7wSrquXb1+Z0CKfoAhXQgymv7blXk3bc1gbtLQb+dMxDtLtLhxzWh1x2UdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ka+j6hsS; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=TdQgSEvfJ6Qb02EKAsmMB+9UIAIMULoIie1MDiHv8qo=; b=ka+j6hsS4O4HSBYH
	6iIksQXf51qFNYdmM7/6yRnSGGliCLPnq5WDFleXFSVfX/kLyh9EWRTF9VttrQibry+hbKil5aS1e
	guQsizXN9RRxHzvpQczlpHZz+RNri90kgDcNYYG5larGmI3psBufHJvQcdtH7r3v8YdhNdBl2WfCI
	N8adn0ISAdpkEgWmNCG9H8D/mp1xgJ+QGetXWGd/2SWQxHUAp5VQVFY8pGIVREXt4TidoDEpRBxLh
	1EP83LnOCJoZCU40u3RUem4mA6Mu772pFDfUNa8cVxE5DK7CN4T6EDxX2a98HbXjWimJ//HjmsPhL
	xDRXLtQpD1sRAvtp8Q==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s2Yft-004ILZ-08;
	Thu, 02 May 2024 15:48:45 +0000
From: linux@treblig.org
To: sudipm.mukherjee@gmail.com
Cc: arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	linux-parport@lists.infradead.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/3] parport: Remove 'drivers' list
Date: Thu,  2 May 2024 16:48:21 +0100
Message-ID: <20240502154823.67235-2-linux@treblig.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502154823.67235-1-linux@treblig.org>
References: <20240502154823.67235-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The list has been empty since:
 'commit 3275158fa52a ("parport: remove use of devmodel")'

This also means we can remove the 'list_head' from
struct parport_driver.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/parport/share.c | 9 ---------
 include/linux/parport.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 49c74ded8a53c..7849c25a8967a 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -49,8 +49,6 @@ static DEFINE_SPINLOCK(parportlist_lock);
 static LIST_HEAD(all_ports);
 static DEFINE_SPINLOCK(full_list_lock);
 
-static LIST_HEAD(drivers);
-
 static DEFINE_MUTEX(registration_lock);
 
 /* What you can do to a port that's gone away.. */
@@ -165,10 +163,6 @@ static int driver_check(struct device_driver *dev_drv, void *_port)
 static void attach_driver_chain(struct parport *port)
 {
 	/* caller has exclusive registration_lock */
-	struct parport_driver *drv;
-
-	list_for_each_entry(drv, &drivers, list)
-		drv->attach(port);
 
 	/*
 	 * call the driver_check function of the drivers registered in
@@ -191,10 +185,7 @@ static int driver_detach(struct device_driver *_drv, void *_port)
 /* Call detach(port) for each registered driver. */
 static void detach_driver_chain(struct parport *port)
 {
-	struct parport_driver *drv;
 	/* caller has exclusive registration_lock */
-	list_for_each_entry(drv, &drivers, list)
-		drv->detach(port);
 
 	/*
 	 * call the detach function of the drivers registered in
diff --git a/include/linux/parport.h b/include/linux/parport.h
index fff39bc306290..2a4424b601565 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -258,7 +258,6 @@ struct parport_driver {
 	int (*probe)(struct pardevice *);
 	struct device_driver driver;
 	bool devmodel;
-	struct list_head list;
 };
 
 #define to_parport_driver(n) container_of(n, struct parport_driver, driver)
-- 
2.44.0


