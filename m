Return-Path: <linux-kernel+bounces-143583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A43C8A3B21
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0341C215CE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E391C6B8;
	Sat, 13 Apr 2024 05:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGZsFLwg"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA99CEAC7
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 05:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712986143; cv=none; b=bDKa54V1eJHI94tbgYLXRrpeumAZxfSgBQWxhfnhbMfgXVyarURBnk0bBDglC/AozFwFlc6Tw2/2jrAFZb7kB4y0kvfcKvJwLupkJrPOJBe/OAd+rCxpPRqRCu6lEEiZcRQqZKkHlTnXV3AC7ZGvwYmqgqz7bjEl4/KgDHGv+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712986143; c=relaxed/simple;
	bh=Vvv0BZjMNTN7ytI2GzQh0FPiY+0SNL9l/1DOsIB44JU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A0aJzyzqEZUAwGDp3y8ILZoQbJycpkFrfjhXY6flo9MhtUWP4yCRyHRMC2QgXFLU4KNfmSLP4USpgD94Q8QMhppVuTLWl/ObhjJCxkTvQOnjgFojbaTHUwzu5G4Ar3vqDHWguTFxKiE+YToPHn9SlPvOH8iHZan3/QtFQZJq+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGZsFLwg; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso1266410b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 22:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712986141; x=1713590941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwoUC8Lk5gZoc2Xih3FgKCcBy4dD9FmKd3RULbF9kv4=;
        b=QGZsFLwgzxL9+AkpMoRsJEcTE5/wlsU+qan4twQ608dbHnQvME2g3NpZ6DBPEaN1Be
         Xxta3V+cIX8yfu1/W400GHwFnPNUXD2QTEJGmAf6C7MsdkECgM4nJn7N1sp74bErA2xH
         3yjWnHB6ykdGsOmaCdsirMfk8M1xXo8OZ2gELCvLpnLLgeF9YP8+a1w6vaBfyCO4b70+
         jfkc7EhgNAiK/CLhVaWUIMMx1G0K60Ps/xX7iPIBHwVf+u83x0x6W/XNzxx8d5cw0x4Y
         Ef77V/k4vG34618yyUHfjRo8n9gMdRy98cnRrXVYXbezCht5VeQfM3D16QCKX/4tltUt
         dljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712986141; x=1713590941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwoUC8Lk5gZoc2Xih3FgKCcBy4dD9FmKd3RULbF9kv4=;
        b=vBw0+L0cfqeto1fsJUM7TNNuCRiuCazZgRFWyKnGje/fzjSVJ5LVUHQRziMiJGjNKa
         06nTpYwMGCMfVuxwN3QGLvmNErgljXugSpi24OXgNEPuwCLnAu2IUDg7Df712vpDG2lk
         TfZLNQ7OwmdRqwZaYlAM/HhpzPSQpuxobEBQieQSusb5aqOcI1BurgN/L9Xeogsokt46
         fvoe0oR0wnd3t7JQwONFf7hTvELAu3GQlvccgOs6gEFJ9yq2tnF4YUbxqD/ojuyUPfWt
         O+5awza8QUUVUkiudMrxC1hbZ6lvq2Es6/56nWKjH4u2JrjjMlbG2ZW+a/djF/7ac8Px
         0w3w==
X-Gm-Message-State: AOJu0YztqIzHJlVLvO2pmETs6hV+aPJdPIOIs7rCqRGaxjUAXW46elw/
	ND9U7T02vIb5UIewgfMHvSnJov7IKXkh01/Q2ggjMvTJeMaDE+ebbcFPXjx/8vw=
X-Google-Smtp-Source: AGHT+IEoxvKV/18HgRIaj+2p6QE4hGPE9KCpAejVMN4T+wBHHx9B97ggWw3X0IT7HWUKPh7c+ewdRg==
X-Received: by 2002:a17:902:d48a:b0:1e5:5c49:ad4b with SMTP id c10-20020a170902d48a00b001e55c49ad4bmr4129183plg.38.1712986140991;
        Fri, 12 Apr 2024 22:29:00 -0700 (PDT)
Received: from lima-default.. ([180.217.195.31])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001e2526a5cc3sm3880277plh.307.2024.04.12.22.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 22:29:00 -0700 (PDT)
From: Chin-Chun Chen <chinchunchen2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Chin-Chun Chen <chinchunchen2001@gmail.com>
Subject: [PATCH] include/linux/bitops.h: Fix function fns
Date: Sat, 13 Apr 2024 13:28:50 +0800
Message-Id: <20240413052850.9419-1-chinchunchen2001@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modified the function fns to resolve a calculation error by:
1. Reducing n first.
2. Adding 1 at the end to get the correct index.

This commit improves the accuracy and reliability of the code.

Signed-off-by: Chin-Chun Chen <chinchunchen2001@gmail.com>
---
 include/linux/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..2457610f74eb 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -258,8 +258,8 @@ static inline unsigned long fns(unsigned long word, unsigned int n)
 
 	while (word) {
 		bit = __ffs(word);
-		if (n-- == 0)
-			return bit;
+		if (--n == 0)
+			return bit + 1;
 		__clear_bit(bit, &word);
 	}
 

base-commit: 8f2c057754b25075aa3da132cd4fd4478cdab854
-- 
2.40.1


