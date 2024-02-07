Return-Path: <linux-kernel+bounces-57061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F90984D38E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F9DEB21738
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51405128360;
	Wed,  7 Feb 2024 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZ7DJ1jh"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCDF127B64;
	Wed,  7 Feb 2024 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340633; cv=none; b=DCelRtxFuxrzd9ll40gaxkaUQsALT80+irRnyDWCVpi8DStsPm14wsOIl6TXp3DyWb/tqRD0HLaPzwjBj6sGOg4nCPGdyyW61yGQg8XbmQXozZviGcIt4FIUq6i2JrxyEAOkz4FEkypibfQCkX/R6E3e7pPcC+nsKDh/gCsVjUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340633; c=relaxed/simple;
	bh=K6vokJcR7HWb+RwnRjZ2DzN5s4WTL1Gy/n0b51sgHqQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kq+SML3SEiLkLRIJg8lQBfd2+z9EUoYONuT4sCm/o6j8ml/gaQKEMrMjwBxK+MxabyLxKHnIMvPwUnVAnf2yY8nITtxXRcFrkJy3aAmeuXg+h5b9RPUxziOLyrSHRlWaD7DIwrzTUEw7Y8djcJjEfc2zVGBRcM3H5FDO2SQ0cf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZ7DJ1jh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-511689ef2b3so950013e87.2;
        Wed, 07 Feb 2024 13:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707340630; x=1707945430; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qVBalHq5WWv0zl7Pnbpf8WpyjeHoC2AZj28LtTs8xs=;
        b=ZZ7DJ1jhg7MM5YvEYGFA8Z1QjzbjRJrjzz9HWD5x3f+/O/gLF5LwwYquGTgFxy9WPN
         1xYOphkvf67snsJCHD0M7pvPY/FW7mEYmvtR6dOdzyzB9ioB9hKCiBv8NHSiheDvtiPf
         UPJydffOK12FVSbu156w/VN1WbvFzcZq8be43pZlFiSJKr1Nn/AZwkOG3rC2IJTXYQcD
         SB5EVhRGkA+zSbZO4hxsQMMxJz7z4nNlbDknMRVXEcIVAfrWeMDO6ZXQIBlttaQ+tXSM
         +912ngatV8X0ZNwpAkg15WvSrMsoFLejU2We/OJufxOePE/NLYOXiMsA277KiEzhuxcN
         vFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340630; x=1707945430;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qVBalHq5WWv0zl7Pnbpf8WpyjeHoC2AZj28LtTs8xs=;
        b=NRGlGqbdzyvnMOXRzcTaIy4vtiAetFKOdbNg8pyA4NYChDiWBwVmZpx4DVrY/JUGNZ
         HPHxyACS+fePNm3wcYjAquD3g/n34q6nGy6tMK+JQ9J19acRDDZQdONzqVLcd8DDpwwo
         KmPOeMq3dTkzME7Qc0ul6xAwWdCWXH0b+lCHaX2fz/Wfmj39j/xkgipYy3HJZsCcO2sU
         O0xul7oL0OqWbyuWy6mVPfz44mTG25LwKnBi9Ly6Wn8LjPBsXCtkPgUPfmrsFmKSJYHN
         vy+UBGB9+phu96dTXq+e5dodTAebace9ONDDD3Hry8UdFPH2FPol/g+jA/YCQEmQIoeV
         Xykg==
X-Forwarded-Encrypted: i=1; AJvYcCWDSBbmFZF3t/vDoEDTEikCS66rpAXnAa17Fr565ysZU8i+g1OONInBsTdYP8SjlsYAHQ246pGxmVaDPUJMvsRsCGz2YthScTQUPCWC
X-Gm-Message-State: AOJu0Yx2eMuo++vpeSYg4Q1SOZRwRqae88nwCJ/xRUz7Vf/YqP1cmFV2
	Y+k6xj4gMEW18odIhevSJUIPfPeRgEvqsvG58Vf/zgYg1SIcwspq3CZMe/OMfXdvEg==
X-Google-Smtp-Source: AGHT+IE4oyVtMIDzWaS5YN8nmvGDfjDvMSwCasc+WjLB1/AGLmtiRdfL0zGzukbz5MihmcijNVK6WQ==
X-Received: by 2002:a05:6512:522:b0:511:4e85:5b2e with SMTP id o2-20020a056512052200b005114e855b2emr4662453lfc.24.1707340629649;
        Wed, 07 Feb 2024 13:17:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0FU6famsTtlnQ9SgOOMH1EKPKXLEbrHfZKGP2FK5g+eMg87dJLog2YfXp2lUcb6IJ+Zm6m0kwfUqvS8Ox1Tg243t3kX8Tt5PgmsbNDK4A21I83a6jJz3tZlW9sSlhZFJlltduKquctF8rY0Dtr1NonAlt+Mp2xzVb0U522X3wM0Bhu0LlD3SAOvcGmmF3oInCPCmAfo4y7DtR
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3314-d4ec-5095-daa3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3314:d4ec:5095:daa3])
        by smtp.gmail.com with ESMTPSA id h3-20020a0564020e8300b00560622cd10fsm98362eda.68.2024.02.07.13.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:17:09 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] hwmon: chipcap2: fix uninitialized symbols
Date: Wed, 07 Feb 2024 22:17:07 +0100
Message-Id: <20240207-chipcap2_init_vars-v1-0-08cafe43e20e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFPzw2UC/x3MQQqAIBBA0avErBPMBKurRIjaWLMx0ZAgvHvS8
 i3+fyFjIsywdC8kLJTpCg1D34E7TTiQ0d4MggvJBVfMnRSdiUJToFsXkzKz4+wnZ6TiFqGFMaG
 n55+uW60fOya29WQAAAA=
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707340628; l=1025;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=K6vokJcR7HWb+RwnRjZ2DzN5s4WTL1Gy/n0b51sgHqQ=;
 b=Q/e4WrTzNsDXrMGjuGwccn30CNkm0oXw1Oi3B0W4K2hOc3yV/nlEA+FS+ypDy6itTG0o6HW8W
 /gVuOErPvcrCqptQlXNZYbctVD8/MxcwA+Qa+A5cC3QbLg5D4aFTsjO
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

Two static checker warnings have been found with Smatch[1] when checking
the chipcap2 driver. Two variables might be used uninitialized under
certain circumstances (explained in the commit messages).

This series fixes the two warnings and optimizes the error paths involved.

The fixes have been tested with Smatch (including cross function database),
and the bugs could not be reproduced anymore.

[1] https://lore.kernel.org/linux-hwmon/294e4634-89d4-415e-a723-b208d8770d7c@gmail.com/T/#t

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      hwmon: chipcap2: fix uninitialized variable in cc2_get_reg_val()
      hwmon: chipcap2: fix return path in cc2_request_alarm_irqs()

 drivers/hwmon/chipcap2.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)
---
base-commit: 65f976a4299c5de2d2c9162c0337f95b7447243d
change-id: 20240207-chipcap2_init_vars-b39f8ca470be

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


