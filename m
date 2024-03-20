Return-Path: <linux-kernel+bounces-109432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73757881900
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 145A6B21EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C9E85C4E;
	Wed, 20 Mar 2024 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbGdZ8dK"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE2254BFD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710969687; cv=none; b=We5sJh34St8Yt0OmcUNL/AbiJaFQlzzE37xfujzpDECms997XHnKw/WTCncXpEe7r/NWMrhknnd92KX5Oesz0VyOwT3JI9dY4ok2Rv9scspJwvhnNh6xTkMXZnJ7xzdH+UbcCtnZwJ7qXWkI64xMetkfHD7x6wQ2cfWvjXSv5ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710969687; c=relaxed/simple;
	bh=vkzABc60DDDx4rXWD1NjB1beCB8+pLCXYepZAQvIp8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUtdPoHQmgOmNA3IVlsnn6CMBHAgOISrlfEzoFMecbvZDRFNiMhtHFlQECwm8izReZbkGuj9KQPrUEG6pQK/39yKXqtPd/VD+iwgQ1dbpWP7uwFx6NnAb61judO0He/24mbjENp9SjPfjIXmA61qAzpfhOJq0yhzRxmGqqKr0P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbGdZ8dK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dedb92e540so2624525ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710969685; x=1711574485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=779Uj2F3PYn9kXcgRZutyeuSV4eghutXpu5LL+l0UEM=;
        b=jbGdZ8dKmfsnGZgYihn0T7RSqkItQPW4NYVUFH4VGZd4736e2E3YX73gQkbY10xCKZ
         N4gqKBrhidJQiQGNMZVbqGdKrFB1OFcIkYbMNBoiqZGFMv5kS/ApacU9WAI4tu4eromZ
         yMQULIgj8jCs1PeV7xqKFogKl/PYDKq24c2OPen2RAq5XAfSXUgRDNCRgj8Wu/7/glPd
         Nl6NVFBJiv0palqZEsEYuKkZmWplhBrM1xZMMaf1BRrU7VahEzpJSSKOa8KwyfSWpzwV
         YzEjxPKgxHEquLqp7b2SRNtXlTRNvYw0Y6idLPWYziGX+/qIv68U5ZR1G9lzeVbCq/LM
         6jsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710969685; x=1711574485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=779Uj2F3PYn9kXcgRZutyeuSV4eghutXpu5LL+l0UEM=;
        b=rZ0GW+4x0RdJbRzflEBblDUVjKBa180O6DSJSZBh+ECgTG52nADckTWe4GhJxEO5ba
         yZrQShPZunhkOzCH8HB98fvJDK6GTrgUZN+SMeBDXIUtzKIctbJybVvp0exmxzcE8zKb
         QNZWF7p1rphRlxCWjoo76AnxVWaInlkmPVEj6WZuieQb8nzQrrga2HW573y5a/+B8YN+
         zLNh9M5b/8/cRl2/AkYp6nvZBNsZr/HbHJZSK1/EPkWTrfWglPWB9PJAqrIz/kGDQjIL
         aF9vak9UiPrKqj4ZxypdbaEiQHl0H7eY8gQ+Gy110Emz89HGJxmrGCfFBaH75EoW4JAi
         5xGg==
X-Forwarded-Encrypted: i=1; AJvYcCWUZ6UM7JCQCjcCXfAIjwKzg4kcG+KWbjbBsI5MjYoLk8PJFaobvMD7gZK2HaumcXdS+uEcE9rTItEJg+jbLMSFYcPqBE6zfAP2Foaf
X-Gm-Message-State: AOJu0YwxaclRVI8uB+BcpLXHVNNjXDLw2+rMrhAf5zSCmt3Ozz/v+gai
	jH2E4CW8Iat7ALMHoWfrOL1X2AosR2YAhPAQNcryahyHCf0FsJKv0w3bWPIoTXY=
X-Google-Smtp-Source: AGHT+IEUU/ejkhFCzJrWhls+yceRl7vVx/Xll4bJinHES1RwcQ1KtqDXGzkTVzfkk/7wHoHjTqO8tA==
X-Received: by 2002:a17:902:b198:b0:1dd:8ed0:59d0 with SMTP id s24-20020a170902b19800b001dd8ed059d0mr970249plr.17.1710969684990;
        Wed, 20 Mar 2024 14:21:24 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id u16-20020a17090341d000b001dd3bee3cd6sm7930912ple.219.2024.03.20.14.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 14:21:24 -0700 (PDT)
Date: Thu, 21 Mar 2024 02:51:22 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v3 3/3] staging: rtl8712: rename backupTKIPCountermeasure to
 backup_TKIP_countermeasure
Message-ID: <3fd64e6671d3f86c49fd8c6ba9ef64c4f0e0b75e.1710965653.git.ayushtiw0110@gmail.com>
References: <cover.1710965653.git.ayushtiw0110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710965653.git.ayushtiw0110@gmail.com>

Rename variable backupTKIPCountermeasure to backup_TKIP_countermeasure
to address checkpatch warning 'Avoid Camelcase' and to ensure
adherence to coding style guidelines.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
Changes in v3: No change

Changes in v2: No change

 drivers/staging/rtl8712/mlme_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/mlme_linux.c b/drivers/staging/rtl8712/mlme_linux.c
index ac8196d24ce0..436816d14cdf 100644
--- a/drivers/staging/rtl8712/mlme_linux.c
+++ b/drivers/staging/rtl8712/mlme_linux.c
@@ -88,7 +88,7 @@ static struct RT_PMKID_LIST backup_PMKID_list[NUM_PMKID_CACHE];
 void r8712_os_indicate_disconnect(struct _adapter *adapter)
 {
 	u8 backup_PMKID_index = 0;
-	u8 backupTKIPCountermeasure = 0x00;
+	u8 backup_TKIP_countermeasure = 0x00;
 
 	r8712_indicate_wx_disassoc_event(adapter);
 	netif_carrier_off(adapter->pnetdev);
@@ -103,7 +103,7 @@ void r8712_os_indicate_disconnect(struct _adapter *adapter)
 		       &adapter->securitypriv.PMKIDList[0],
 		       sizeof(struct RT_PMKID_LIST) * NUM_PMKID_CACHE);
 		backup_PMKID_index = adapter->securitypriv.PMKIDIndex;
-		backupTKIPCountermeasure =
+		backup_TKIP_countermeasure =
 			adapter->securitypriv.btkip_countermeasure;
 		memset((unsigned char *)&adapter->securitypriv, 0,
 		       sizeof(struct security_priv));
@@ -117,7 +117,7 @@ void r8712_os_indicate_disconnect(struct _adapter *adapter)
 		       sizeof(struct RT_PMKID_LIST) * NUM_PMKID_CACHE);
 		adapter->securitypriv.PMKIDIndex = backup_PMKID_index;
 		adapter->securitypriv.btkip_countermeasure =
-					 backupTKIPCountermeasure;
+					 backup_TKIP_countermeasure;
 	} else { /*reset values in securitypriv*/
 		struct security_priv *sec_priv = &adapter->securitypriv;
 
-- 
2.40.1


