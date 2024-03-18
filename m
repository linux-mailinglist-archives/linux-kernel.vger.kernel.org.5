Return-Path: <linux-kernel+bounces-106327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA8987EC70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203C71F23974
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E272D52F7F;
	Mon, 18 Mar 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0Tr5OJe"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39F3524BD;
	Mon, 18 Mar 2024 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776784; cv=none; b=kYZ/yEnEAmqdFjaWKOlRTTUqXmt0RLyEjifjZhBwEW9GeY8qIwIbM1szsi/Zm8K8wQSs6dOfNnzW3ICrfyOn3hp/ptWphcKqCy4I063k1/15EoSpUXTiC/uId1kLXGp3sspHRspv52IM1hHAFHheAT1loTwr8LS25BOPXNXhokA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776784; c=relaxed/simple;
	bh=WxHwKXMNCGsjAQJ9XWxSYt4pFJRKzmB/HVljAZQq3VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnlYzlKMmwO7LkXc0hvj/Y3okAtgdEIh4L4okJPSFoz/QP7EVq38Hm5IOj1J8YmaS2opEShfJLYbELh62QLvimOVmtWRaiafDjxL6SZFOzILVwceavjMkq4PvUk7ZMbSgDFlkLFwC9/Mr/lHbKCSN+2lBQMYT7wG/wPZkR2cqzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0Tr5OJe; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6cb0f782bso3777001b3a.1;
        Mon, 18 Mar 2024 08:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710776782; x=1711381582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWDSD9O32qOZWl7Ul+3Std0rh3NiTvNf73A2v9mV+98=;
        b=V0Tr5OJeR6QySZHXPh8fQeIgCjXdxO0ojsW0hIDX46GbMsoyABBNBRi5YdHePpizlw
         usV03aaU9FA0rCBvw2gxT/I2HKl2LR0x1rOgqoe2XNDDiluUI4CZ+G1/ShOZRoiEnO+h
         sY3yYit2M5Ob26BHiy4ljXGa3H5Rijngn40uzX3IHvuMnzjKEZkmfLVOxD/O06swJLi2
         g0sht2Z5reE3Gsgj9/63uhId3o/40n/UrAlAM8zmXr5lDQvhHRKS7PHWP52FIV4zesSF
         0zgZgmsR94nxsPvjC7DB461BS2fkRUl8guZbh5rPcy61DvHMeYhCWqksP4magp1+J0HO
         DwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710776782; x=1711381582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWDSD9O32qOZWl7Ul+3Std0rh3NiTvNf73A2v9mV+98=;
        b=TzorPBEarq2oC/nOANb1utimX8Y6CT93yO0z2i/+zXYWvaajEekOfSLCwoNd+5UoLT
         8RbOGdsL4OljfZFI437f8tb+k0d0Dq2TkJjq7u7Xc2CO6h3H/lDtSTSxE7ilhW8szYT+
         /x5lka0QUoA15muKdOdVopBhekaelZOdPmKlOtTWdaSDsbJMPknocY+BYloGJr5j3tGF
         IH6+D3tnQcX01Aw72hLMfKGSgPlc5lchIV3BQ2da2ICgfYrMuMa5rom47EiH88L4cZ1A
         FJ/+a20V5CSRRmGIHzHCxxsvAtwwThsA64xYmvWD1ESmLJsiZyZQH3+z/sR7HQDBuann
         Hu9w==
X-Forwarded-Encrypted: i=1; AJvYcCXakiQu3QvYbSEZnNAlMdkea0hw61Ghxc94d8aaDuhKbDPk26gFAF7CfY06ArWOPEj0c3bF+n1YE/+wl/BmVi9bqT9eBL55JnHwTpA=
X-Gm-Message-State: AOJu0YyXaDf0WEI9GU58S3y5zPAduxCN+pSmKw7L88iVk2lj6CiTen50
	XBGlSqqwulY4wmmL3iu9InkA6Y2J8SUsihSIxi7N6rTrb6TM4dEFGoGoVTUtRDU=
X-Google-Smtp-Source: AGHT+IF9ezMFrgmg81YnnlBQ5XtkvSji7s6rZhcEn39FQIiZxnqwEtV7xv/hjiJy3hhnovoustu1TA==
X-Received: by 2002:a05:6a20:72ab:b0:1a3:409f:b9a3 with SMTP id o43-20020a056a2072ab00b001a3409fb9a3mr12468512pzk.23.1710776781794;
        Mon, 18 Mar 2024 08:46:21 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:31f8:807c:8911:659b:1495])
        by smtp.gmail.com with ESMTPSA id u8-20020a6540c8000000b005e840ad9aaesm2400080pgp.30.2024.03.18.08.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 08:46:21 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v2 2/2] hwmon: lm70: fix links in doc and comments
Date: Mon, 18 Mar 2024 21:08:35 +0530
Message-ID: <20240318154540.90613-3-five231003@gmail.com>
X-Mailer: git-send-email 2.44.0.273.g4bc5b65358.dirty
In-Reply-To: <20240318154540.90613-1-five231003@gmail.com>
References: <20240318130840.74589-1-five231003@gmail.com>
 <20240318154540.90613-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update links in the documentation and in-code comments which point to
the datasheet.

The current links don't work because National Semiconductor (which is
the manufacturer of this board and lm70) has been a part of Texas
Instruments since 2011 and hence http://www.national.com/ doesn't work
anymore.

Fixes: e1a8e913f97e ("[PATCH] lm70: New hardware monitoring driver")
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 Documentation/hwmon/lm70.rst | 2 +-
 drivers/hwmon/lm70.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/lm70.rst b/Documentation/hwmon/lm70.rst
index 11303a7e16a8..02ed60dddffb 100644
--- a/Documentation/hwmon/lm70.rst
+++ b/Documentation/hwmon/lm70.rst
@@ -5,7 +5,7 @@ Supported chips:
 
   * National Semiconductor LM70
 
-    Datasheet: http://www.national.com/pf/LM/LM70.html
+    Datasheet: https://www.ti.com/product/LM70
 
   * Texas Instruments TMP121/TMP123
 
diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index c20a749fc7f2..481e4e1f8f4f 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -6,9 +6,9 @@
  * Copyright (C) 2006 Kaiwan N Billimoria <kaiwan@designergraphix.com>
  *
  * The LM70 communicates with a host processor via an SPI/Microwire Bus
- * interface. The complete datasheet is available at National's website
+ * interface. The complete datasheet is available at TI's website
  * here:
- * http://www.national.com/pf/LM/LM70.html
+ * https://www.ti.com/product/LM70
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
2.44.0.273.g4bc5b65358.dirty


