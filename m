Return-Path: <linux-kernel+bounces-106582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E012E87F0A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0F91C21386
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D64457326;
	Mon, 18 Mar 2024 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayJwjy/M"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669DF56B77
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710791763; cv=none; b=Z+y+R/Y5RQyesMK4taWDaWGUT8nUdUGjmgs9kNXtmevAkNCNmAdH5J4VykaxomxykYvXw5SwUtYC36deV4W22o0aVEQgCsSNhA4ot7pEyutQweD72wfzyDPSdxz2e3CpGBLPsDLhh8tLq+rPmjT1TplY0IgkEHcW6nneaccqHB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710791763; c=relaxed/simple;
	bh=xH4J9BOVooc0F5rECk+PxtigvTft5gVlU+S7SOx5rwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJHXbqwC/jqmXzgkVx5eMiOKjHE/pADfr8aZNYBd2VhU6SvqdBwXDqffzTE0Q+GeYfLPsyfsfSMgpKPP3w7Z7dAmA53Y8Dccm/JjaBxSWfQa5oDwB+IJYnDoX/k3N9gmFuhhO626Tw343urJbgRFPYOujDxfw2XYfWISvh0J1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayJwjy/M; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5e152c757a5so2948387a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710791761; x=1711396561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vyqSy28RTKkkd91Z04lpmQCt/lHnaiuG23pASkEtwFo=;
        b=ayJwjy/MePp6ST2IfOWCO60C1ONLuPTsFsv+vBKMr5qUiruDqkwGw9O/tcImuKpzVL
         8M7vnV+kYre1HS0ySspJUAYtg9uZHI1au/o5bPBhS9YvjUXLsQ/IWnOGmzbCBCg/Fjfc
         T/ZHsVXMv2XOcqPKAe1h9gAGO3RJesQYdbKklw4t0AP3O4tIKQkulVJEWjfqvNcxd59S
         VW7HZ+UVdJ3m0vxd9Z2kQ5/BvH6/W8setU8rS33STF0HkznrCZmYpickD6q9vVT+nGxX
         5n0Sgk73jNhQVxQaaeZkn2oIxYeGcraoq6Q8T4jVwYyh9Cti4zKbdtjah8YH1SOzYYgQ
         wRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710791761; x=1711396561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyqSy28RTKkkd91Z04lpmQCt/lHnaiuG23pASkEtwFo=;
        b=mhquTDix7cPn+g+ExwCjlW3q5AAjjBEclIM4mGIkqWv/B93xc888ocbcs6Jc9jnSNB
         GXYpAWSX9rCtclvs17rq67cmK5ewkLgf8sc8U7pfznYbREAANGL6BpYrLG67rLs79E/h
         roxkr+6KU45wr4iGytewLus49XTARl/qPGP+5qKsnAzznvxhVeg59/CiESuv0q0QNtzS
         XidlS6HDFuZcjL4DamcRZJLLi6T1JUBFvj5k2i8sAPojEZ2zSb7P9LgAiggHmCC8vsqp
         /4WwcNm2Q1ZJ1VTHc+49kaGkw79OpsnfrgXUd147adLMg03JsTQfcnk4lR9qVdxwttDu
         oo+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUp9HRxhYm+Ar4vZMNg9tVQ4RLc5hP9/bUozHXcAOMR8U0i7SdeUYKW8CkmtA/8Mb8HHPYjU7+SOZv03p/Vok32AUbcgu8piF2Nf6P
X-Gm-Message-State: AOJu0YwaCiAVOjBGXN7RSbHCHfarl2Y8j8yldirwDl0H2r244FRaQdop
	3UDCPMC6vBALSifoRVj3oCjpc+KNKjLIwgCD8WZ+8Y+/GTz/Cyz+
X-Google-Smtp-Source: AGHT+IHs5jw/gZ1xolbHKkGmR9XR0pXwcVtAN09AM37fbqAnwgkiBrSjazhJm7UhUvqWwyzx5M2jVg==
X-Received: by 2002:a17:90b:1196:b0:29b:aa4e:3b74 with SMTP id gk22-20020a17090b119600b0029baa4e3b74mr8416054pjb.17.1710791761544;
        Mon, 18 Mar 2024 12:56:01 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.68])
        by smtp.gmail.com with ESMTPSA id ie15-20020a17090b400f00b0029de90f4d44sm7482606pjb.9.2024.03.18.12.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 12:56:01 -0700 (PDT)
Date: Tue, 19 Mar 2024 01:25:58 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v2 1/3] staging: rtl8712: rename backupPMKIDList to
 backup_PMKID_list
Message-ID: <10336a70a7d1b87857664e9733a419791e0e2ada.1710703217.git.ayushtiw0110@gmail.com>
References: <cover.1710703217.git.ayushtiw0110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710703217.git.ayushtiw0110@gmail.com>

Rename backupPMKIDList to backup_PMKID_list and remove extra spaces
between RT_PMKID_LIST and backupPMKIDList to address checkpatch
warnings and match the common kernel coding style.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>

---
Changes in v2: Checked any possible reuse of backup_PMKID_list 
manually and rebuilt, rebooted the kernel and loaded the driver 
with modprobe. 
 
 drivers/staging/rtl8712/mlme_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/mlme_linux.c b/drivers/staging/rtl8712/mlme_linux.c
index b9f5104f3bf7..a8cda81f4240 100644
--- a/drivers/staging/rtl8712/mlme_linux.c
+++ b/drivers/staging/rtl8712/mlme_linux.c
@@ -84,7 +84,7 @@ void r8712_os_indicate_connect(struct _adapter *adapter)
 	netif_carrier_on(adapter->pnetdev);
 }
 
-static struct RT_PMKID_LIST   backupPMKIDList[NUM_PMKID_CACHE];
+static struct RT_PMKID_LIST backup_PMKID_list[NUM_PMKID_CACHE];
 void r8712_os_indicate_disconnect(struct _adapter *adapter)
 {
 	u8 backupPMKIDIndex = 0;
-- 
2.40.1


