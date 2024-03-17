Return-Path: <linux-kernel+bounces-105516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EE287DFA1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D98F281601
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5341B1EB36;
	Sun, 17 Mar 2024 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUoAINK4"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D591CD2A
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710703567; cv=none; b=MibOGgiRfQP/5nFffh3Akyf2EFfSxlHYTXHpjvfB4cEUOdPAJ80hLvktKCURJY2FnlrMGMxELyyIe+axE1Nl89ojJsADDL2lJTYVpnjVLYPE/i95gVCnjR0ezVR7+1ZXkz16kS60yHL2jToV1E5k2EFB9R85xoGWqAW4EF4m7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710703567; c=relaxed/simple;
	bh=eLV0CSNLZVxwDb61FAEDUHSpvfXBaoJw6TBhaBomd1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVX/6GDg2SegHSKz1fTAvd9jtb2mVonqfVAgNq5REQD+Y7RaWzYQ0fyJ7hUgZ5k0tIY4+SVG8JDjzan5BP2uxa6a4C3s6ye8FfROHARo8+ZIAbqlD3kiN6sGqXiqjNcncdeCqEpNMkCGrh57xHe0QvZIu/JMovfZqAfrYEe2/mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUoAINK4; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-22222357d76so2398174fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 12:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710703565; x=1711308365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uhlA0khsXTr13PWQMJChrTc0wcbpicVimWfo8/ANB2k=;
        b=XUoAINK42hSgdVJuQUJydNXgVYpDt0dUZVptBANKiEmaClzVggtaZ35qP9YC2yF5/s
         w4RUNlYq3U6W4LifA0g/CrPgzulb3yebqpk+VQlyPFCsNBdaThqFkV+k4s7SHNs8QSTE
         6pg0/xV8vzrSL0eAuZ8JgU0dzi8rSCrg+DfO9lFsGPcgs0j8Px1u1/HMjOPKxiv+A7mY
         1sOIhHuk7JmshAyUqmlESKKemDrZ86R+rHmHXZJJjwEL02JYyaN9mWSzb2Ju0KS+/QB6
         EberJAe6dZM/61eK8GnL1THsO/c3YzLghCoGs/oBmiFYo2DgjgWcBYOveuCGV4QftgBb
         Y+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710703565; x=1711308365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhlA0khsXTr13PWQMJChrTc0wcbpicVimWfo8/ANB2k=;
        b=ik/aIUA6RqsLnE23qnWAUgH9FPNTvTdCZ/31pp7E7lmQOywI+56EvNU97vxO+Ez65K
         I+m5pzYvmgMQgB1FSqzxANIHdJYNqc18j1SLA2OGjfel251vAyhmPQZ9+OXDmcllUJlM
         6aGSnLjirJ9xmsx4Sst3/iQuKwAiW0xlccZ8PCSIMnqyedn3Z0GfWKY+GVqdRaWgyNgk
         oNYDgAbqRoa8NoCdbPCBhsSP9V/9gqTl681emEvmwz4Q0XH/qEEmJ6rTpPEfE3OO6JlN
         pV62NhsbK0hQpIfP7lBiHTcavzRZGdsiWf026HG9CA/HH75uac+yEn2Gnml1l/UipOZp
         AgLA==
X-Forwarded-Encrypted: i=1; AJvYcCVQnUPdewGfomCfuwNE93sPLKTRrR2iiGQeUwVBpU9Szqspp6R3e36W8j8ai7rUkU2PmxSymfRda5ywOsqO+42Y6pD2oJuicE97iAdX
X-Gm-Message-State: AOJu0Yz91kdMQAgrU4Ec+1C5QXqBxEVtgh/gcd6/wCqlZTLWX9AMmJ37
	zY6pFwsiAgrcNkn2SJD3GimIy3sLpNWMi2DnD1hrgDA29XLDaxBE
X-Google-Smtp-Source: AGHT+IEeatJjLah63pbaUrOCPXVFpqa9d1LONam7ODwmgRFtkiYcWQKSaZi8G2acq0WEmh6RY6Ugyg==
X-Received: by 2002:a05:6870:fbab:b0:221:30a9:e481 with SMTP id kv43-20020a056870fbab00b0022130a9e481mr11479762oab.36.1710703564223;
        Sun, 17 Mar 2024 12:26:04 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id kt2-20020a056a004ba200b006e6233563cesm6474347pfb.218.2024.03.17.12.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 12:26:03 -0700 (PDT)
Date: Mon, 18 Mar 2024 00:56:01 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH 1/3] staging: rtl8712: rename backupPMKIDList to
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


