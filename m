Return-Path: <linux-kernel+bounces-70087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B81918592E6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736AD283EFE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641DE80620;
	Sat, 17 Feb 2024 21:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHx1GETt"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD557F7F6
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708204422; cv=none; b=U0C+i+hFZOpm0CdgSjadK9gwncuInd0YYEiF+UJIE2jbnVk8G64evDTav7P2wPnHVM7DGdX8XgmX78VdFwwDqewlfXbpdLoo3mT71Ba2kgD63/n7eI7TgDyeBdtocWaKiLTr26S0IN2NvJVW294wcQLzEETr49u1McE0B6P/pao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708204422; c=relaxed/simple;
	bh=I3tCiGlk5ny85vI8kqZUsRbjY/tEETYNUbs6XI91XYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u1s3VjPKXW9KjYOC9XhYpVleKbgtwZs0z2MhwqUQff2bqjb8OAdhN3QOOKFLtj2moPiQLrx+7cB8BRY1Wsrz79vxsmk5eKY2RxiFBPknyPIfkC6yQexPYZm6n1S0rdRjOmeOahN2UiAWLpZhfU1gqpt66YlKKglHwQl75LF2BHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHx1GETt; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563cf3087cfso3015553a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708204419; x=1708809219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMro+oCLHPLwncyYRlafFQVVFeqU1GH/O+kRfL0UaO4=;
        b=gHx1GETtliz3/NPqjBkkC+Gv+3T/tDHRs3b4Ln4TxUYIwDJXgISUeI3+ksKgeehHtN
         21p4FcpfEDLu4ZBQjYJW8fMCgTpeQYyi0zCmPo+9GK4iRodzUBU6hfuLXBowQ46XJJBM
         5VLmFeRmuLxoaCLlSm+Q5gBKEuTC5I9RZI0FqE7rwW2TgyzFku7e3gHucvL45CE1iGhF
         xsjzhyyK52WIpgp0+pLquq7DZXHdwCNe4mBjAXzRNLlFV0K/aYeYUjTq/PcJQa8vKcdo
         Cb8j40bK1OqIr4ExZgF8JxVTPUitQtmNwWiQ3PIBi58wsTJbvtYIUSoo4bixUJtE/xMA
         dYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708204419; x=1708809219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMro+oCLHPLwncyYRlafFQVVFeqU1GH/O+kRfL0UaO4=;
        b=eQGoqMo2NDo4RZ6OaXx+4qxUQeGWFiBCQcUno9bu+ujHAuSgmJ+SvBlwMqYuZqfk0G
         pVrlykkgRYvUDVbOAoA9Noq/bgiug7Nfss3jq6gs40LlPsx5zAyflALAGUZXSxUarOjr
         BOqknKCPB7DLk+BZHwp5czRPFglJuuJyc30oN9+w9IlVTjQS1UAGE9upQl07BCPYIDEf
         jWwL7FjheFt9SADCkzGx9+KkUpV5yOb+OzU2QDU3G5uVbAbzsEkxIPrp7OGqPK54ic3X
         dnqwtJ1bcs02tFv2i2E7iwixK79N20hG0rZGeAyc8/ct8cFm8u8B1y/gJM4MJODsKmpy
         Nzxg==
X-Forwarded-Encrypted: i=1; AJvYcCVtKAZzOa+nFvH+5044VOcFRTtZapXn1bYkYvb6Pwx7ldVHBnqhKPJElZ2S7droB2PTnEiX1oZ+9Y9/F81gb6p3WROAlNE/YhR4W9bs
X-Gm-Message-State: AOJu0YxPNTxZsxFouChn4ZCh4RKIQE6nJhc64g8PCkeg3LDvB2yGSu1E
	WRvGJzwLsLSV0KD3kOqi0PKtJEvz++15NKdFfdCKERI/hBfL5Z48waJ7HtY6
X-Google-Smtp-Source: AGHT+IEoNBqCOK0k4SmqM3vYyOz2c2cDzzAfpxUu5xcR4QMvO5z2o0Wwr6bO/vQj3VwyKOQQ9qlk3Q==
X-Received: by 2002:a05:6402:b23:b0:561:347f:ec5e with SMTP id bo3-20020a0564020b2300b00561347fec5emr6143066edb.32.1708204419145;
        Sat, 17 Feb 2024 13:13:39 -0800 (PST)
Received: from pinguine.lan (ip-176-198-146-182.um43.pools.vodafone-ip.de. [176.198.146.182])
        by smtp.gmail.com with ESMTPSA id n3-20020a05640206c300b005644eca3befsm132087edy.85.2024.02.17.13.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 13:13:38 -0800 (PST)
From: "Moritz C. Weber" <mo.c.weber@gmail.com>
To: florian.fainelli@broadcom.com
Cc: linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Moritz C. Weber" <mo.c.weber@gmail.com>
Subject: [PATCH v2 5/8] Staging: vc04_services: bcm2835-camera: fix brace code style check
Date: Sat, 17 Feb 2024 22:12:43 +0100
Message-Id: <20240217211246.28882-6-mo.c.weber@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240217211246.28882-1-mo.c.weber@gmail.com>
References: <20240217211246.28882-1-mo.c.weber@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reformat function parameters to fix checkpatch check:
Increase readability and consistency

Signed-off-by: Moritz C. Weber <mo.c.weber@gmail.com>
---
 .../staging/vc04_services/bcm2835-camera/bcm2835-camera.c    | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index e2d058732..b9745bb80 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -783,9 +783,8 @@ static int vidioc_overlay(struct file *file, void *f, unsigned int on)
 			ret = vchiq_mmal_port_connect_tunnel(dev->instance, src,
 							     NULL);
 		if (ret >= 0)
-			ret = vchiq_mmal_component_disable(
-					dev->instance,
-					dev->component[COMP_PREVIEW]);
+			ret = vchiq_mmal_component_disable(dev->instance,
+							   dev->component[COMP_PREVIEW]);
 
 		disable_camera(dev);
 		return ret;
-- 
2.30.2


