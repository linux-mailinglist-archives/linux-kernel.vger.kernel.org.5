Return-Path: <linux-kernel+bounces-96283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8519E8759B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107DC1F22218
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07D6143730;
	Thu,  7 Mar 2024 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t12Sbg0f"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC831428F1
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847879; cv=none; b=qaesXpn8rlr4JZ0c1eHf7bJSHaNuqsOC+0uyvYNANZBFfAq0jaLBWC8usyN7kAA4wRkZGa0OHH3X3zu7PWoR0JjgE9TdLHmzQmGk5MwwS42K/aGmFoeKcNA/g+xMv+/i301pLxxXRD8U5HBdjxXzgyE88I/6Q2LKvJRAVI/R+N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847879; c=relaxed/simple;
	bh=3IHdm2Kbt7Oqnq7hLlZmkndR1cR6l2HysmJJhv/D7aw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e2y/LiDQx8wlDt1wfzctwMflN7N3pxdnXoY3Mp9lnEazNNF4x2YHXP3BBvJPDzoMdxkIs+mxurGpVAy6mQtsnuVuT2qeFSXG73WemhQkqDRrtBptuLQ9EUt4KEIJ2YUuvu1lodP/YsbZFeIHifQir4PDgaka3CkMrJ7kKIlmLdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t12Sbg0f; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so416263276.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 13:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709847876; x=1710452676; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bwEvId1GeDg0DYsAPfhWaL+EMmX4DxPU1q6ezkgbZrY=;
        b=t12Sbg0fmiaJ8ZPu1iNR/moz/Rv7t0woY9Uo/tp3vQRv3UYDh+D9Mz37JF4+D2vR8d
         gGL6Hd5oT741qaEVFSpJVAOXrlAhgrwQSXvkaIHINhnV87bbHBvUp9p/+bf+Noxs5H0i
         7XRRQZsqZPmvS8wi8b1Ran6Ern7ffGEV5XEkbPqNiXUI/PjhI/VOuRhaRBmbMXrtEgR4
         2hsbygjgg8akvUdHVewVHGQZ2/I9d4QpcN0B3ZJTNsW0Y1GGwYfp7/CY7nxgNsN4RPxL
         AOkjER25vHQcwAk0qdGv7eDY8NZAPzAUuTZ6OocIgLz5Co5MjCpSeQt8oIswcVBublTn
         nrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709847876; x=1710452676;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bwEvId1GeDg0DYsAPfhWaL+EMmX4DxPU1q6ezkgbZrY=;
        b=AnqZoba3FQQJ3gXCMlo2qRL9GZnFMlun8CcgkUpExGyzBYohnjFyNZ0AoyOFYSrNVl
         IvI1m+JNFBSlD3+uLjWjlblFjWxdpLIQa/fo+G8g4QpDAzQ7fKqGliAKGFgxPYF0sOqt
         v1Z330LFGrjzYuo6smTb0jBkWr0eihGEkznjyhA+pfP+A/z4MrNZLfEoCwyfr3nw2dpG
         a8PGPdGGiwqo24oF0N+PF6kym/CdmuEZSHlKF8G7WVG6MTOarxCHx94qjNg+pgK2Ox2N
         SdV+oT/udQudRV1qT5PT0tw3QssV61GVi3h0MWAWwL06h58xCRH36VRQxZ0adeE7S9SD
         Yqhw==
X-Forwarded-Encrypted: i=1; AJvYcCWHNCfriJ8kaUK8tuR25gkuuzDCZbDHUeI8TzJUukJTFDir1hYWSd4VI7byJQNo6QdRnFx/IZM1zNX89jHqKqilRmZMTuGmaW9A4TsL
X-Gm-Message-State: AOJu0Yww/W1k3JAAxFkNYXDTAhNu3xXrwvrUOV1kI7hIexvbj/DiNP0P
	JFSBzU4dr+XIzQZHM9f0KynRUErhdOWFWJm5YLYkJvdpdGAYvNRlw0ZcJtxayZRulfi+YQtfhzA
	dGpybjL4R5g==
X-Google-Smtp-Source: AGHT+IFayAfHaKkEPZo+rNikCLiHI2VeVbBzc8tGK0HM4m0xNsouXgxkmZIRd60W1RhGlE+CFfrrZUPbCKvAZQ==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69c0:c447:593d:278c])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1209:b0:dc6:e20f:80cb with SMTP
 id s9-20020a056902120900b00dc6e20f80cbmr701381ybu.3.1709847876592; Thu, 07
 Mar 2024 13:44:36 -0800 (PST)
Date: Thu,  7 Mar 2024 13:44:17 -0800
In-Reply-To: <20240307214418.3812290-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307214418.3812290-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307214418.3812290-7-ipylypiv@google.com>
Subject: [PATCH v8 6/7] scsi: aic94xx: Add libsas SATA sysfs attributes group
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>, 
	Xiang Chen <chenxiang66@hisilicon.com>, Artur Paszkiewicz <artur.paszkiewicz@intel.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

The added sysfs attributes group enables the configuration of NCQ Priority
feature for HBAs that rely on libsas to manage SATA devices.

Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/aic94xx/aic94xx_init.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 8a3340d8d7ad..ccccd0eb6275 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -14,6 +14,7 @@
 #include <linux/firmware.h>
 #include <linux/slab.h>
 
+#include <scsi/sas_ata.h>
 #include <scsi/scsi_host.h>
 
 #include "aic94xx.h"
@@ -34,6 +35,7 @@ MODULE_PARM_DESC(use_msi, "\n"
 static struct scsi_transport_template *aic94xx_transport_template;
 static int asd_scan_finished(struct Scsi_Host *, unsigned long);
 static void asd_scan_start(struct Scsi_Host *);
+static const struct attribute_group *asd_sdev_groups[];
 
 static const struct scsi_host_template aic94xx_sht = {
 	.module			= THIS_MODULE,
@@ -60,6 +62,7 @@ static const struct scsi_host_template aic94xx_sht = {
 	.compat_ioctl		= sas_ioctl,
 #endif
 	.track_queue_depth	= 1,
+	.sdev_groups		= asd_sdev_groups,
 };
 
 static int asd_map_memio(struct asd_ha_struct *asd_ha)
@@ -951,6 +954,11 @@ static void asd_remove_driver_attrs(struct device_driver *driver)
 	driver_remove_file(driver, &driver_attr_version);
 }
 
+static const struct attribute_group *asd_sdev_groups[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
+
 static struct sas_domain_function_template aic94xx_transport_functions = {
 	.lldd_dev_found		= asd_dev_found,
 	.lldd_dev_gone		= asd_dev_gone,
-- 
2.44.0.278.ge034bb2e1d-goog


