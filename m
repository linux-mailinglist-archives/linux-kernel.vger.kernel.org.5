Return-Path: <linux-kernel+bounces-106710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B723087F249
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74891C213E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC3E5917B;
	Mon, 18 Mar 2024 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BS+jUAOT"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C94B58ADE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797811; cv=none; b=TFIgIP66d5BP5+RmOP3jBZJmjUUzbQ41M10/Q7pmhv9TRmri5v/IQXifDDWIiHlq6qY4lqdEyeDIqOB9Aeyv7RAzjVFWysopdw85aJru+kWMeBxWuWqLJ9ZeD8yxab6VVWie6iWU6+LOkfDZWt6Vm2yoB6eHS0TP+ojNdO0NE1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797811; c=relaxed/simple;
	bh=2Ew0NAYVYC/WImUvrJ3PUN3YeN5BI3FzR7k3xT7PFuM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=luwyH9sgfUI2uevbojmo8ReX0It7V/Ke64nq7xj5qvVDYzqfhGXud+L49M8WvDTqelCGWZkP1IDWmP8/dnf7A61MdxJGzs0UAc2EujHj3itOHc2i+pKakfFd/tZskKTKs9ocFi4bx6tOTk88mEHSb5WDaFeb1kWWFsOfNKZvjvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BS+jUAOT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dddbeac9f9so32619925ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710797810; x=1711402610; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GwLO4qizopwzBhr0j80mQwVdTtL1XZUS6Bx2e5kiG2o=;
        b=BS+jUAOTX+thRDtjIvliY6bi9ejimwkQN9ejCQR20br2CiwO4SfVqaYp8BQ6/iEORI
         dqG70orUQnp22Eu+S4GucAoGSjFegAMJFcA7ciEMCuL1WWzJFa0HOJSdv4vCk91p7EW7
         WEq7MwwH+/qmveBnjZSNbineAquIsMOG925+pWteiSCZJo4A6yfgyLNpjNhzG+6HU2vV
         /qDMcvVzTQ//fGp9yi21fPUBRZN5SIaex1V/5TaPsJ1YEHKaee9JBlCxcXP1O6lQLUX5
         RpU9wWi1O81/h0pGq8ToT3zlS7lsamPhfIvY3n1nUGJpZp8iQarKD8iSCPoFIKaa3NwK
         UJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710797810; x=1711402610;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwLO4qizopwzBhr0j80mQwVdTtL1XZUS6Bx2e5kiG2o=;
        b=DDeBr6v/OOaADRY+vdXt7WHkG6MMSou35cKzbGlXzxrTmfvgLrAOxsMuP1XPSdZeV8
         yojJF4NA+3/Phmx5jppD5jBgIsgu0Su/oZvu48LANrMIb4JQ50h48KmXHswsYtDpGEea
         rXxtJBGyz9RMzIZnjkkRE59a4afZb3qsU8rFHVuBdU9hZC6HMy4FmsMLDzqzRn3+aMIm
         hysLDlVS3uB8oGAidXxdr/quvTKbee8U/q603xEhkyH1K621a7S6i/BUuKrb+XdooXZV
         xiKPRNBSBeYdEqLf+fPS3YKsW1BEHrAYZKbScJ2C6ObnKq+CELGYWSm7b4t6KcQIrQYL
         ouVw==
X-Forwarded-Encrypted: i=1; AJvYcCXtINnu6BXM0nZ7g7wyvC35tXjbheuYoVh7aS+UX/GX/LgaxA1SAeNohdRMG2ldZUz9NfEuvTMtW/W1dly5TlSoLR4KYuKbregvlEcI
X-Gm-Message-State: AOJu0YwNcOD0XXZofOulR4Kx9Wpwi+a2qgPmkfRmpuLte9f64bTw+ysY
	RZTd9ROn6RyyZY5mpEvdgCZUH4eE+CxNNVUqlEcROcfDxImkcDZI
X-Google-Smtp-Source: AGHT+IE/n+Kc2DH+TUGIOq+VrqDXIIw8Nz/gveRC8adMwWFN4tZP7KgAxCKgJzSZtKJPZj0g5diT+g==
X-Received: by 2002:a17:902:7c87:b0:1de:eca6:483d with SMTP id y7-20020a1709027c8700b001deeca6483dmr11379452pll.27.1710797809630;
        Mon, 18 Mar 2024 14:36:49 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.66])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902d08300b001dcad9cbf8bsm9775117plv.239.2024.03.18.14.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 14:36:49 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:06:45 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8712: Rename blnPending to bln_pending
Message-ID: <Zfiz7YFKAqAOGsu5@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rename blnPending to bln_pending in r8712_cmd_thread() to address
checkpatch warning "Avoid Camelcase" and conform to the kernel coding
style.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_cmd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
index bb7db96ed821..7e5a25b1c154 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.c
+++ b/drivers/staging/rtl8712/rtl8712_cmd.c
@@ -284,7 +284,7 @@ int r8712_cmd_thread(void *context)
 		pcmd = cmd_hdl_filter(padapter, pcmd);
 		if (pcmd) { /* if pcmd != NULL, cmd will be handled by f/w */
 			struct dvobj_priv *pdvobj = &padapter->dvobjpriv;
-			u8 blnPending = 0;
+			u8 bln_pending = 0;
 			u16 cmdcode = pcmd->cmdcode;
 
 			pcmdpriv->cmd_issued_cnt++;
@@ -294,12 +294,12 @@ int r8712_cmd_thread(void *context)
 						     0x0000ffff);
 			if (pdvobj->ishighspeed) {
 				if ((wr_sz % 512) == 0)
-					blnPending = 1;
+					bln_pending = 1;
 			} else {
 				if ((wr_sz % 64) == 0)
-					blnPending = 1;
+					bln_pending = 1;
 			}
-			if (blnPending) { /* 32 bytes for TX Desc - 8 offset */
+			if (bln_pending) { /* 32 bytes for TX Desc - 8 offset */
 				pdesc->txdw0 |= cpu_to_le32(((TXDESC_SIZE +
 						OFFSET_SZ + 8) << OFFSET_SHT) &
 						0x00ff0000);
@@ -318,7 +318,7 @@ int r8712_cmd_thread(void *context)
 					       (pcmdpriv->cmd_seq << 24));
 			pcmdbuf += 2; /* 8 bytes alignment */
 			memcpy((u8 *)pcmdbuf, pcmd->parmbuf, pcmd->cmdsz);
-			if (blnPending)
+			if (bln_pending)
 				wr_sz += 8;   /* Append 8 bytes */
 			r8712_write_mem(padapter, RTL8712_DMA_H2CCMD, wr_sz,
 					(u8 *)pdesc);
-- 
2.40.1


