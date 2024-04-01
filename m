Return-Path: <linux-kernel+bounces-126747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0558C893C3C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42082826FE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCDE3A29B;
	Mon,  1 Apr 2024 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="XAx41JhG"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE251E524
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711981950; cv=none; b=jsK5jcu6K0YAWusn2waB0AVBAzvRhu9hU1u3yw62CSO8e+NuIzPpnRUEbh65beObsF9bJHYO6sEyLkYSh0GZySPxyNH2n7w3oBrkBBVzGvtEf2PARhXMN8cFOSiOhM5ySVejj32TN1A2G+L1U906Eydh4SYwBh5/2Am8enwOMwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711981950; c=relaxed/simple;
	bh=5RFG1P0trv213iNz6lPAGEzxo0INSuWfbGbyDr0HWos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2PhsQTHIFSHdX8wRV/Q5SYvLi31rZOYxBzwsIfOmVtRwZFzw7UNsqc7JjYETBZe4hZC16DypfKQyf7fJWJxcEQ4v2GWCyQ7g7Xx6Jm/EihUvgLu9ELDQvyM8Inv0CoL6mby0xb5NUFW7nZl6l2qAp+Yc98hRlw5EQ8lMqSw7+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=XAx41JhG; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-515a81928a1so6609498e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 07:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1711981946; x=1712586746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=El4LrRmYhlbOjZRwrcwB9TwBTLghA1Bd8l15+x6qDcw=;
        b=XAx41JhGw/9P16HOQkpxHTOaS6l+23oYyJH59k5NrqOIUSU2p2jCBfFwVuJIqPhFr0
         WPPIH8xV/J1ISSvOPyOvUrKlkx2Opwjin8gKyy/q8u3FQ5z+mxwLS/yCQH6DWDub/qnN
         Ahqjjds28vjcOqnj2IDVvzgueDALBpZQzHakjNdrNWvRWxhsFEv6aOmqwfWYPPdwmi4J
         tyjXMYxCyyvX0xnwH3RAQJN/c2vrScKQISlwOkRQgrhIruXNLHjOhUFkstRenzbHHL00
         caQQnechSKOU3k2ggJiniUwbEHIPZjX2RygoLINGcnBSDwYg2kfpLeKgw26YdPhcV5GN
         peVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711981946; x=1712586746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=El4LrRmYhlbOjZRwrcwB9TwBTLghA1Bd8l15+x6qDcw=;
        b=DdFtUGrKbjt3sG0u7+Ar4RMe8bOrBd71WHAcRlDG0UgXb6wLODAJSoqmJ1sKp1Q5tE
         gWAhtaC4X2v+HtLH9T9AUx6Yi+z+LWtYgMZ2Svk7hH5jicIe8a6N4OQ3VBfZjDijsxii
         kkX2DU10EVIoGoKVJb8R19rrrDyeP7Ls608sj4PNw1O2v10g/zyKtxXhR2CDDwOtktOC
         39+4WD/fQDnpnWnqZcBxctX2ie60DC1egyKGIWI/e6/9Tqub8kUJAo74AJ2plInQYd3m
         DRX4yCztUgFjuBXNQC4ziWSco/T7hzvcGPAJIMUTAVsOYeVJzKOVQIHZX1l4SyV+ZVD7
         hs4A==
X-Forwarded-Encrypted: i=1; AJvYcCVruDt+jSUSU+1oAZ53vYWNuKfEW3ccIp0sf07Zv2lcY8r+t2MlSiPcI9fAyk/GiGXP/k9qFZ2tTkySpPVx3pdBd35w4kukPzFFCcDY
X-Gm-Message-State: AOJu0YwYmftwe05NFg5KFTKiKGnUgpDoVf0VrIyiRvadSQqNOpQ4GTjY
	1C0+yDDAwOTw3r1Hh3orelkyL3o/CBgZ5AfG6w3hRwS7HiBdBhOtPZNuLSVL2fo=
X-Google-Smtp-Source: AGHT+IEMW99M0edrHUadb0vXV/wJnQfPsriyVM1q+WtAMIG59lBvbqp7qXMEFHgOorsz1HkhdHcI8A==
X-Received: by 2002:a05:6512:4016:b0:513:c61c:7331 with SMTP id br22-20020a056512401600b00513c61c7331mr9855974lfb.3.1711981946364;
        Mon, 01 Apr 2024 07:32:26 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id xj7-20020a170906db0700b00a4e379ac57fsm4029466ejb.30.2024.04.01.07.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 07:32:25 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: imran.f.khan@oracle.com,
	leobras@redhat.com,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	peterz@infradead.org,
	riel@surriel.com,
	tglx@linutronix.de
Subject: [PATCH v2] smp: Use str_plural() to fix Coccinelle warnings
Date: Mon,  1 Apr 2024 16:31:18 +0200
Message-ID: <20240401143117.171139-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327224216.54342-2-thorsten.blum@toblux.com>
References: <20240327224216.54342-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following two Coccinelle/coccicheck warnings reported by
string_choices.cocci:

	opportunity for str_plural(num_cpus)
	opportunity for str_plural(num_nodes)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Include missing header file
---
 kernel/smp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index f085ebcdf9e7..28fee28174e0 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -25,6 +25,7 @@
 #include <linux/nmi.h>
 #include <linux/sched/debug.h>
 #include <linux/jump_label.h>
+#include <linux/string_choices.h>
 
 #include <trace/events/ipi.h>
 #define CREATE_TRACE_POINTS
@@ -982,8 +983,8 @@ void __init smp_init(void)
 	num_nodes = num_online_nodes();
 	num_cpus  = num_online_cpus();
 	pr_info("Brought up %d node%s, %d CPU%s\n",
-		num_nodes, (num_nodes > 1 ? "s" : ""),
-		num_cpus,  (num_cpus  > 1 ? "s" : ""));
+		num_nodes, str_plural(num_nodes),
+		num_cpus,  str_plural(num_cpus));
 
 	/* Any cleanup work */
 	smp_cpus_done(setup_max_cpus);
-- 
2.44.0


