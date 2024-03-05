Return-Path: <linux-kernel+bounces-92980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1418728F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95471C2222B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C99412AAD3;
	Tue,  5 Mar 2024 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOEnPUEZ"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389935C5FD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672129; cv=none; b=t9GJt12/2e+CrB7/VOiFVycBRi1mRw2MeyTFR9oYG+rSz5PHaGvTVcqFH4FDO1uqC5PPswgazArzEOONWprPyZO13z7HwVNl9Qtk69Bbz8QZEKerkwtZW1L8b+hsf+efcv8befhq5EYeiV0aAwhZ3ibgQNBS2oyMUK3Cc4RIH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672129; c=relaxed/simple;
	bh=BN1b6zvn0mXQcEw8gr8v8xPVeOlkbb0NQ2kIIOQHa94=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Dg936HJaLXePJ4ijnX1UyQkzPfXA5KLiRjXdsOLobFv/857EV9Rhg4NPNlP4mRbSTIox4sLhrplMCHxuwoWPSXAWPTGHWYGLjxEFbjr4LsygpHJZDLF0yDCJ25s2vKgfP+iz5PWpZ2saySXscMlSaYXIDB/Kn7CxTzZo/c4O+Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOEnPUEZ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso779224966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 12:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709672126; x=1710276926; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oP24OS7ZzqD+Zl+BkOuZfNprFfPd65vwT7x7albUKok=;
        b=bOEnPUEZGo2zYYgsjc6jdFhPr39G46QgCuLUMDdJDsMUzcvD44c6bPTy1Ejgx/f+7U
         /UIvlimPa+SKetAjFG1f8shdmzxtdq9H8526BdMuGXSmX4e7TXDLb8oijBHXgdmjT7k4
         VNfrC058g0zjxJD9z96y0gPnkjgOKdKPyAoCdvPWlHZg7XUmZotIDTvTVSV/D/QaSu8y
         8tjMz9qs7CaLSloTujfLdY1PzCFn9kCdyKI6hu7Kt0Nk6CLppfRvqi64hd0AyvER1uxU
         L+2ZEDINoS6+4LWRblhiyt4jW3ADXPEzik/9wqFWVricS9TFZnX9/r3vPCONZQH14CVu
         Np7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709672126; x=1710276926;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oP24OS7ZzqD+Zl+BkOuZfNprFfPd65vwT7x7albUKok=;
        b=rnLpN0m2p8BhpNWt9fQFXdnt8oQwODrkdpm1iLfUDc1XUyQifV+2RPcpXRRD1k/6md
         11sUcEEySeOBqOq1tojbXz8W5mCPKbdebsU/XANiYIPPmAcGXeh55HvzEw/bjjyxiBjY
         2VcowWaiSuzKPC457gRKY45oU79MRGI36NfLn9s+arqM+I1x7Uunh7hw7yixmniRD1Iq
         UeQs1+k/R9pibumQB6PSKWGgzQBgMGWj/QiiDQvJCpd0VqSVd/Q8FooD/4DMFB71pU6u
         LJ8CmomV6l+6i/nCEmOkfOWVBajwqdYgcpj9bgW89wOTj+D3XnmNFy7c+YV7L/jM3Fkl
         zQ/w==
X-Gm-Message-State: AOJu0Yx8NPVrxqQBz2zjrfcTEFgy/qE7mICL0fecsQ0qIJKAcoVrdapp
	3vY8OjZYWK7sFhC+4Cv+Ha/65ZPwT4XuwU8LL4KYv9Fw387e4rlN
X-Google-Smtp-Source: AGHT+IHSrhTYl6q2VuQD4XG7sZkLrlViBxtvmS9oLq/KExJkUc7zwwXWdZpsW+kuutlXNDTk4vUUsg==
X-Received: by 2002:a17:906:c7cc:b0:a44:7a34:e620 with SMTP id dc12-20020a170906c7cc00b00a447a34e620mr9040115ejb.4.1709672126245;
        Tue, 05 Mar 2024 12:55:26 -0800 (PST)
Received: from ?IPV6:2a01:c22:724c:8900:6035:9a03:530d:5671? (dynamic-2a01-0c22-724c-8900-6035-9a03-530d-5671.c22.pool.telefonica.de. [2a01:c22:724c:8900:6035:9a03:530d:5671])
        by smtp.googlemail.com with ESMTPSA id s2-20020a1709060d6200b00a45a73e0be9sm1097405ejh.180.2024.03.05.12.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 12:55:25 -0800 (PST)
Message-ID: <b1d69d07-14a9-4f10-9155-a0a46d8ea872@gmail.com>
Date: Tue, 5 Mar 2024 21:55:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jean Delvare <jdelvare@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] firmware: dmi: Add info message for number of populated and
 total memory slots
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As part of adding support for calling i2c_register_spd() on muxed SMBUS
segments the same message has been removed from i2c_register_spd().
However users may find it useful, therefore reintroduce it as part of
the DMI scan code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/dmi_scan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 015c95a82..2c682b580 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -42,6 +42,7 @@ static struct dmi_memdev_info {
 	u8 type;		/* DDR2, DDR3, DDR4 etc */
 } *dmi_memdev;
 static int dmi_memdev_nr;
+static int dmi_memdev_populated_nr;
 
 static const char * __init dmi_string_nosave(const struct dmi_header *dm, u8 s)
 {
@@ -448,6 +449,9 @@ static void __init save_mem_devices(const struct dmi_header *dm, void *v)
 	else
 		bytes = (u64)get_unaligned((u32 *)&d[0x1C]) << 20;
 
+	if (bytes)
+		dmi_memdev_populated_nr++;
+
 	dmi_memdev[nr].size = bytes;
 	nr++;
 }
@@ -824,6 +828,8 @@ void __init dmi_setup(void)
 		return;
 
 	dmi_memdev_walk();
+	pr_info("DMI: Memory slots populated: %d/%d\n",
+		dmi_memdev_populated_nr, dmi_memdev_nr);
 	dump_stack_set_arch_desc("%s", dmi_ids_string);
 }
 
-- 
2.44.0


