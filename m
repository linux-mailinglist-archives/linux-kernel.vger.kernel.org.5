Return-Path: <linux-kernel+bounces-84635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5878986A950
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E9BBB23188
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6867C286AC;
	Wed, 28 Feb 2024 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="A23y+ng2"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8CD25605
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106804; cv=none; b=WyXhqfgVxY3RFxRH1McU/iNRQx9k6tQauT0JNuJ6beuBMA48MeecCuuao1MFtXjaFiU2OAiNrWLpnVwekMglgnUIVtWQCKkLvLV69nNjBfE/a4GusmGrPd0YxekJXeB4TFCzNMV+POdBnv39KL6z2t5inwkBY3y+yYbdTS4vEaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106804; c=relaxed/simple;
	bh=uiNV5GxuIw+2wK1NRUMnwrIPShLTOVx6Wtri/oC0dQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5/z23bErDe04N6VNJe6ExaOgEaesN7uNJ9SnSnw3uLKG0RKyZB83h7FqhHKrIO/1iUxJ40e/oRd8u2W+IDy0LREYGwbw1VukdjndF0vUYTJK96uIcNpDwu0dyR9u1CfHMRSEvGHWq4YjLbM4jEnLDy698nN0LQzaKPogvZ+rz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=A23y+ng2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3f6aed454dso143459466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1709106801; x=1709711601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/4jINKFGsyIzql22NGVobeSi0DTkJ0EFvem76bD04Y=;
        b=A23y+ng2K1BpILvjdlL9Yh6W8Bx+vPUN25tFKr8zPJtzvRuX86b57Zon3Xl2JoTOsD
         Q2wTSj2Cy5QzEi79u2XzOO6ddUl9HIM4MLA1WtUx1d/Q5oa0qxM5O2k+UIkviU/NHMvY
         dvmzqvQ+7xm/RK/8Injep+FklLrhYgMm3MncwBP4hq08ih+p76lfOnVRmY6XXsDScasn
         v+VyNjpeXJld+/e3gypwydJ/oWwcnUBiJ6DwrGywFM93I8i2u1LY5/yKfVMXfTJcJvVl
         0vbLris3RPK4USDlSywME3yY6Qk2pwveSPFJQmdjXXGKIhH+jial52Rwkbvbyw0cU8FI
         NxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709106801; x=1709711601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/4jINKFGsyIzql22NGVobeSi0DTkJ0EFvem76bD04Y=;
        b=nFLabM7qYiUj4ibtJ2RGldLDf4lX/y0p41F23+Q/c8wHMRV48igt7kLvxE0bV85lau
         em5RgO8FBtE8RgRvu2ysryRDcsX/kAmc5Obaawf05CHkHzfNBn6GAiUM3pnfDloNgPOw
         YdA0xlTtlx0IAYNj6Q5oniCOp73/H7r51tawXZ2Tqg+XdjgqTktn9a6U+yEQ4peoWChU
         DPmc+ghC1ZleIlFVd87Efeuh/pCYwgghYzKSDaDyEidaDa/bgOhf4jpUA0/bRmBgBeap
         eg/awz48QvduaG9zmtd9PVTEjKQc0PpdfBvW4eM2ggfvY8C++y/Dq+xacjZfB9yW4Fo3
         VllQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLpjy/GNn2zClmihba9JCl2IhHIT/2Rs5imyqqBe/e6FJGsOQpGgsSbsVSO4t4F3jcDAc1dULgGmx4sYLgUYDMyKt8P8tvhVP0CZE0
X-Gm-Message-State: AOJu0YwlO43hru8ODZdzTkvs8EH5XUeEzdIT5u6bpNyRzG6H3qnH6XAK
	tNJpxhsucb4aWQ4Ji1VrHql2rR8YDomtN/bCN0Zh4IMf7mDT863oxPPfgI9PNbg=
X-Google-Smtp-Source: AGHT+IGxRTh2VGuVfyRxq6BtQ8iD2uJcNHz9XuBbzRygjMNWPj9gsIbmn5zp+jnwEkU5YGHp5IJmxQ==
X-Received: by 2002:a17:907:7898:b0:a3f:8915:1622 with SMTP id ku24-20020a170907789800b00a3f89151622mr8214302ejc.4.1709106801367;
        Tue, 27 Feb 2024 23:53:21 -0800 (PST)
Received: from limbo.local ([2a00:1bb8:11f:a33a:d002:9fcd:70bf:4f2a])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090608ce00b00a4396e930bdsm1561581eje.79.2024.02.27.23.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 23:53:20 -0800 (PST)
From: Daniel Drake <drake@endlessos.org>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: hpa@zytor.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	david.e.box@linux.intel.com,
	mario.limonciello@amd.com,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v3 2/2] Revert "ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default"
Date: Wed, 28 Feb 2024 08:53:16 +0100
Message-ID: <20240228075316.7404-2-drake@endlessos.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228075316.7404-1-drake@endlessos.org>
References: <20240228075316.7404-1-drake@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit d52848620de00cde4a3a5df908e231b8c8868250, which
was originally put in place to work around a s2idle failure on this
platform where the NVMe device was inaccessible upon resume.

After extended testing, we found that the firmware's implementation of
S3 is buggy and intermittently fails to wake up the system. We need
to revert to s2idle mode.

The NVMe issue has now been solved more precisely in the commit titled
"PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge"

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215742
Acked-by: Jian-Hong Pan <jhp@endlessos.org>
Signed-off-by: Daniel Drake <drake@endlessos.org>
---
 drivers/acpi/sleep.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 808484d112097..728acfeb774d8 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -385,18 +385,6 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "20GGA00L00"),
 		},
 	},
-	/*
-	 * ASUS B1400CEAE hangs on resume from suspend (see
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=215742).
-	 */
-	{
-	.callback = init_default_s3,
-	.ident = "ASUS B1400CEAE",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "ASUS EXPERTBOOK B1400CEAE"),
-		},
-	},
 	{},
 };
 
-- 
2.39.2


