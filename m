Return-Path: <linux-kernel+bounces-74708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD7F85D80B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0990B1C22370
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611746995F;
	Wed, 21 Feb 2024 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0fv94/P"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0300669319;
	Wed, 21 Feb 2024 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519181; cv=none; b=MdHBfA55Uvo4KlLz2rFFYJruKqWKsZqajtBlBzUNye5iUAtydqnP0pECH0+80MgGF/bp17kbZ2a7o+gP+5/K1hsM/IKc/wsEGHUjkegozUvoY9Zg1j8qb6ULr1Ydnc04lWt+3vvINF8HvYHevA15vE29f/i863PsZTNxo+t3Eeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519181; c=relaxed/simple;
	bh=Qe/A6k+4smPWDWXCEf215lQP3giMaXGWgCGQgwSs7sM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nlzK8wc/OvFC9dlTRnaSiQtCh3sWiKC3EqFmDyh66SKBWxMHjsotvcp/TREIdfRQ2QhUE7FMo8nngnqQOWSA9vSPPEov+4CaQCqk0tIlaX4uz15CJ6hXPnYOkbP2WNbO2LAsTfUA3IyXCLZWPYpT9pkS065M5jUyDFJDMzpt3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0fv94/P; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d6cc6d2fcso426685f8f.2;
        Wed, 21 Feb 2024 04:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708519178; x=1709123978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TVXQ0SykxtzeFN8y51Iqsk4cWHv4fF8waP8HNiw0MEc=;
        b=H0fv94/PnPtgLjRQE6+3xeWR0N8Rv3M1QocsELb4sJetNrTo2/h+1/sysb96RvStmx
         zYr5k05QZCmjPOHW8OHwegq73+MQR/aoY7Md6ckpv40JI+1FoRc9iE9Wt56Olj0wcVbA
         CO/lRMELTBJ64ej6M/tLEdVSIVEeeVPo4cMRctGYU27i05lV5SEFPcuTAadBeDggo3G3
         A6i2UXv+spCGC9ojhbbPwOhMv7ia8alp9XtoqJ07rGg+sVejt/ls7326ZfS/+bcQYb5g
         E5Yz3fJ0ND2FxU1Qc0jVeseBhn6MJj7HaiplG3soxxnD9Tg/BS6bPn0tx3bMFQTRiIXf
         11HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708519178; x=1709123978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVXQ0SykxtzeFN8y51Iqsk4cWHv4fF8waP8HNiw0MEc=;
        b=Hrgidrnf18HCCpsYl/TAwkUipwIywDwuiz3VdO41yCBSPpWvLDPDod4yLTukb9pKAh
         9gSWUPzD0lR1J2yrgIGg9tmUek52eZiiWf1FtU+6HLmpz8mVvVita6f207HRJRjW7FN7
         uYwoUeGRIMsPD1fsKzpULchQIX8CPEDJcPhZEcuJXnJZDC/bXZUJUkPBBorObYaQvToj
         4ax7jU+p9ehBDiu1duqMyjLW8T8w3BhL/2f52toQxswlz6UrU6GnJ/GUS58LOcL+oW95
         qIrBPBHvmu9XckYARbErhLtm1RA+mq8QAr/G2pN6sxw3HOVkIBNVBIS5uMjzMHgxLXnJ
         WTBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWepAUvnBb9o5l4AxOm/qXCjVr8hKpg6jq+YHRO3SKpGfJSovWHMo17cXS/JDimvRp5i+zkIeM1t3IW4RK7VM90REVGSGh/qxBfOlKXBSrmFCuFwhzIoSNLBkGPBHVAziJPg66FesLacA==
X-Gm-Message-State: AOJu0YxPL/lucXU4qc8Q3XsottkO6rE1E1CL3ynEJwGJ3KlqINfk7TYt
	/4oXR5yEAh2nxSHrxzaNaKO1g/bdQYiXnLFg3uNVqARfOFC3V4kF/5x6R/Ff
X-Google-Smtp-Source: AGHT+IEW/AB1dE8aKxnnyDVexgJ/J1eQz7jQelMynzFOSmmZ11AioLANDucPhDTx1xpQT19Mjnx0Aw==
X-Received: by 2002:adf:ab07:0:b0:33d:3218:3378 with SMTP id q7-20020adfab07000000b0033d32183378mr8378085wrc.20.1708519178015;
        Wed, 21 Feb 2024 04:39:38 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bu19-20020a056000079300b0033d3d9447e3sm11686342wrb.83.2024.02.21.04.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 04:39:37 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ACPI: thermal_lib: Add missing checks for errors in return code ret
Date: Wed, 21 Feb 2024 12:39:36 +0000
Message-Id: <20240221123936.3421462-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Static analysis with clang scan build detected various return codes
being assigned and not checked. The calls to the trip point functions
probably should be error return checked as these can fail because
of unlikely issues such as invalid ACPI object names or ACPI value
evaluation failures.

Cleans up clang scan warnings, such as:
drivers/acpi/thermal_lib.c:106:9: warning: 2nd function call argument
is an uninitialized value [core.CallAndMessage]
        return thermal_temp(ret, temp_decik, ret_temp);


Fixes: 6908097aa5a7 ("ACPI: thermal_lib: Add functions returning temperature in deci-Kelvin")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

Note: Not tested.

---
 drivers/acpi/thermal_lib.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/thermal_lib.c b/drivers/acpi/thermal_lib.c
index 4e0519ca9739..4d27048ef075 100644
--- a/drivers/acpi/thermal_lib.c
+++ b/drivers/acpi/thermal_lib.c
@@ -103,6 +103,9 @@ int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_tem
 	int temp_decik;
 	int ret = acpi_active_trip_temp(adev, id, &temp_decik);
 
+	if (ret)
+		return ret;
+
 	return thermal_temp(ret, temp_decik, ret_temp);
 }
 EXPORT_SYMBOL_GPL(thermal_acpi_active_trip_temp);
@@ -122,6 +125,9 @@ int thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
 	int temp_decik;
 	int ret = acpi_passive_trip_temp(adev, &temp_decik);
 
+	if (ret)
+		return ret;
+
 	return thermal_temp(ret, temp_decik, ret_temp);
 }
 EXPORT_SYMBOL_GPL(thermal_acpi_passive_trip_temp);
@@ -142,6 +148,9 @@ int thermal_acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
 	int temp_decik;
 	int ret = acpi_hot_trip_temp(adev, &temp_decik);
 
+	if (ret)
+		return ret;
+
 	return thermal_temp(ret, temp_decik, ret_temp);
 }
 EXPORT_SYMBOL_GPL(thermal_acpi_hot_trip_temp);
@@ -161,6 +170,9 @@ int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
 	int temp_decik;
 	int ret = acpi_critical_trip_temp(adev, &temp_decik);
 
+	if (ret)
+		return ret;
+
 	return thermal_temp(ret, temp_decik, ret_temp);
 }
 EXPORT_SYMBOL_GPL(thermal_acpi_critical_trip_temp);
-- 
2.39.2


