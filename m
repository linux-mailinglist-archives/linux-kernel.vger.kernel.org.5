Return-Path: <linux-kernel+bounces-167094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6628BA475
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0B2284DB1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D211C36;
	Fri,  3 May 2024 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="WJglenFn"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6856A193;
	Fri,  3 May 2024 00:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714695524; cv=none; b=ZpaGxVexsrIqv4Kz+L6kVWAQE8tyFDiqHkyZAMacMsjDZGiHXDH0AWdtipfK0Ll6kstDpkYEYhTbU5R3Sa+dExfLDh8m+LbO6L06I3qx1IMc8okjLcG62G7XCwlP287ie3yayDZZowJqLLqkptde8dY0mjFbiQQHiYLyEx4kPik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714695524; c=relaxed/simple;
	bh=iSY/EcBkl6M2WDfei+JmiBgnUw4IF2mgm7jlDQyvb/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+51f5wk7SAkt6evpNPIjO7PnEPwXutTyqI8xElmx9hxNjggvnHIGr7lBZ6f2GlSWFAqFcQuz8P3rxG8V1qeFyA3KCqZdmpEQjS73sQZ5L9jD58vj0uRKpEaiSXrTyyOhCfiq1Nd0n8drzIJXdssiiWbgRWK8r23uc8nqB2quAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=WJglenFn; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=S3+XujSNwKFc1eyZFjrWRqLEvo5FCdCdxPoPAWMrF5g=; b=WJglenFnw3Pd5li1
	uIzgTgNiBYDLOnrpMaOA/mU1VqmDgwOPhK6i9tSj+eWXgXabOkDz3jm14lG/Np56KKTySKizB82Lw
	gRd5LNOeR3gGz0TjFzTEqzaUL3Mj7Rh1v6WbLdIg7uKTP1AhEYV1Mq+xNK/6/ZJQVtK2xPVPkAH5Y
	rkozDnowBcJqABOUNf9Yx4JuFVjq7vLFNFTGRVLg9TFB9WlgaQd3n/yAANoizFuuH5/FhBH7+ySwb
	fTu7bqKY8yCYQEfjvhtlIMvMGAfgHVf0pexhvKLL/eijcXKsOA+5cME+d+O1PK1lvhd/pivPigb/c
	VWx6WTeOejgtpii8dQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s2gdI-004MfL-2H;
	Fri, 03 May 2024 00:18:36 +0000
From: linux@treblig.org
To: 3chas3@gmail.com
Cc: linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] atm/fore200e: Delete unused 'fore200e_boards'
Date: Fri,  3 May 2024 01:18:22 +0100
Message-ID: <20240503001822.183061-1-linux@treblig.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

This list looks like it's been unused since the OF conversion in
2008 in

commit 826b6cfcd5d4 ("fore200e: Convert over to pure OF driver.")

This also means we can remove the 'entry' member for the list.

Build tested only.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/atm/fore200e.c | 3 ---
 drivers/atm/fore200e.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 9fb1575f8d883..cb00f8244e411 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -94,9 +94,6 @@
 
 static const struct atmdev_ops   fore200e_ops;
 
-static LIST_HEAD(fore200e_boards);
-
-
 MODULE_AUTHOR("Christophe Lizzi - credits to Uwe Dannowski and Heikki Vatiainen");
 MODULE_DESCRIPTION("FORE Systems 200E-series ATM driver - version " FORE200E_VERSION);
 
diff --git a/drivers/atm/fore200e.h b/drivers/atm/fore200e.h
index caf0ea6a328a8..5d95fe9fd8364 100644
--- a/drivers/atm/fore200e.h
+++ b/drivers/atm/fore200e.h
@@ -830,7 +830,6 @@ typedef struct fore200e_vc_map {
 /* per-device data */
 
 typedef struct fore200e {
-    struct       list_head     entry;                  /* next device                        */
     const struct fore200e_bus* bus;                    /* bus-dependent code and data        */
     union        fore200e_regs regs;                   /* bus-dependent registers            */
     struct       atm_dev*      atm_dev;                /* ATM device                         */
-- 
2.44.0


