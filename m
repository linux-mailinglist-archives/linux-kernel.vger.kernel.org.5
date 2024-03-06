Return-Path: <linux-kernel+bounces-94080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAE287399B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DACD1F221E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C870134751;
	Wed,  6 Mar 2024 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccY+KH1+"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F348131E4B;
	Wed,  6 Mar 2024 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736346; cv=none; b=aup75mIS22McD41uDid6aOGWm2V6ZNz+fR+MN7T8Eagm6sq76ZIxgdku9mEWRZ8lBigirGVmwYz4+SSKpTU/3D6Q6AF/Bo6mkdegEcTGgYMsU79hGF5C3vsDj/w42J4yh8cO/HJEDpZUUMkHf72YHEYiYcrC4SzMSB84pqOe5pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736346; c=relaxed/simple;
	bh=e+ep/XwmsT7Yh1b1D1RYbEhxCj9dy0Vb9THbZ73QXZw=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=MGeZpSqC5bs7QXNH6ssUy+Cea7KehvTgxnaIIIMu+NF/ocUattMqTUPwk9ZNsJrOek0o35BU0khcgmRuZg0tY1fLgigcHiLaa5PnfHYyi331sFcU9saLy4PVMTwvgjRhGQA5ADMnMzZg9lR7bE7bEuj1FJfa9eWXwQXOYOklruM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccY+KH1+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc49b00bdbso62853475ad.3;
        Wed, 06 Mar 2024 06:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709736343; x=1710341143; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E1YRruC7SM8vAzg0Nu8qzt4Lrpb3IUqILsIMELMlA1Q=;
        b=ccY+KH1+aZTEPngZJtr4iOFKi98dKWWGbpuf0ZH/Ee67Qq/namtFWYNzkjnjL/6mhz
         UbGzubGph3tiRdsdDHjuGVnwNdi2bCZ6URI7z8v81YO2qV8KB5UWKV9ogZI5yTE3XZ1k
         0FQvA5kUDhr/fjdZK1a+yY++3yyQGSgR2f6KAi+PKdTlkSsgzO4ooSlZKHt0k+iRiC9/
         uWu/lIOKF850TBKciujGRmRZqTIEIf6+ill2SwAeKkzzclFfB1IHtEbEMFpVUcj7YzbR
         O+Soa0YMOflqY1Xl88xYLZ5rjW09lKgWWmf0peTMdrii3Rtu72pBwWCI/zCZO6WWVwJc
         vn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709736343; x=1710341143;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1YRruC7SM8vAzg0Nu8qzt4Lrpb3IUqILsIMELMlA1Q=;
        b=NeaoW7fRFrUIqD8qTyDEIu/p+OlAdLRuB2nBtRZbcE2EJQEHmDQ6Y1WBw5dSqMq/KK
         rlGSfuJitQ3aOW5CdKsjJnUxJg9uylYWVC8MIsj86BcvpSLyY9nzZ41jBg8FmU4NDTlf
         Pk4nOIBL1pyRmLY+thdrHgqfpXC+kCDjrs1ebRjgeuZsPvPDfrT6/KFANFBNs4IF97qy
         t1YvrLrcIJBXPXglcGMDt8PUkaq69vg+pVN5sSmCmkYHk6C6LAetBCbaRR6dZh1NbpW3
         K1CQtTwwg1tzyrCMtuXZO3+it4V6VsIxGtQfMs5xNHJQjGV0jAexYLf4/aefnFHImpit
         CYIw==
X-Forwarded-Encrypted: i=1; AJvYcCXViFM+GhrCIQ0F96W7H81vUmfywT6Ud9UDWBJdt5HNW6Sc1kjfTrKwTFZOd5pR82dG7Pg/xkDaVHAMuwfc7N6e0RpvieZcHh9RWjlV
X-Gm-Message-State: AOJu0YwWxOP2uD51ZtQYEmNv69bcsaqsziu1wP33qBa6nQW27gmLqGft
	Y3GtkmL8w4ZSV709NUIg5kAewXoLLUTV2FezGdOvVhpKXG09rlDx+Oejrus9u6nTAQ==
X-Google-Smtp-Source: AGHT+IGV7TNaPmyFhgfwMek5J+5Y12r4bOImepIT2tPJ5tYQyVGUOBNXI0/1Ml6MOEc76ZlUrbitiw==
X-Received: by 2002:a17:902:c081:b0:1dc:cee2:5ffc with SMTP id j1-20020a170902c08100b001dccee25ffcmr4408105pld.6.1709736343486;
        Wed, 06 Mar 2024 06:45:43 -0800 (PST)
Received: from ?IPv6:2401:4900:1c3c:9b3c:7685:c6c9:539d:b4dd? ([2401:4900:1c3c:9b3c:7685:c6c9:539d:b4dd])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b001d8e41b3f95sm12661345plg.51.2024.03.06.06.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:45:43 -0800 (PST)
Message-ID: <b442a768dd23d9c6fdac6fcc30bc86794e85c8f5.camel@gmail.com>
Subject: [PATCH] Subject: Improved help text for rtl8712
From: Ayaan Mirza Baig <ayaanmirza.788@gmail.com>
To: kernel-janitors@vger.kernel.org
Cc: ayaanmirza788@gmail.com, linux-kernel@vger.kernel.org
Date: Wed, 06 Mar 2024 20:15:35 +0530
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


From df9050d0dff9e4160172dbc910f718c16095fc8d Mon Sep 17 00:00:00 2001
From: Ayaan Mirza Baig <ayaanmirza.788@gmail.com>
Date: Wed, 6 Mar 2024 19:53:12 +0530

Rewrote the help text paragraph for R8712U and R8712_TX_AGGR

Signed-off-by: Ayaan Mirza Baig <ayaanmirza.788@gmail.com>
---
 drivers/staging/rtl8712/Kconfig | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8712/Kconfig
b/drivers/staging/rtl8712/Kconfig
index 8de26425225b..c3ea29003fc6 100644
--- a/drivers/staging/rtl8712/Kconfig
+++ b/drivers/staging/rtl8712/Kconfig
@@ -6,16 +6,17 @@ config R8712U
 	select WEXT_PRIV
 	select FW_LOADER
 	help
-	    This option adds the Realtek RTL8712 USB device such as
the
-	    D-Link DWA-130.
-
-	    If built as a module, it will be called r8712u.
+	  This is a driver for the RealTek RTL8712U USB 802.11n
wireless
+	  network card. It is also known as the RTL8192SU.
+	  Used in devices like the D-Link DWA-130
+	  If built as a module, it will be called r8712u.
=20
 config R8712_TX_AGGR
 	bool "Realtek RTL8712U Transmit Aggregation code"
 	depends on R8712U && BROKEN
 	help
-	    This option provides transmit aggregation for the Realtek
-	    RTL8712 USB device.
-
+	  This option enables Realtek RTL8712U transmit aggregation,
+	  which can improve performance by combining multiple small
packets into fewer,
+	  larger ones for transmission.
+	  This can be especially beneficial for large data transfers.
=20
--=20
2.34.1



