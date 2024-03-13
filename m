Return-Path: <linux-kernel+bounces-101163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAB987A34B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D8A1F22222
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FDB1CF9C;
	Wed, 13 Mar 2024 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0D0WAzO"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCCA1CA94
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710314002; cv=none; b=KPw5vDRyDghBc+Ag1qmf9ig3FHIGjQfJP/yWsHMvY5NAgukf9lxMuRxHTteYHMrWxJtJzM5YR4sBLT1nhDeviLzHH8Wr6yJUdimp2JKEezKbA0YB09L+2ryqp6dapmePtKaBs6lH1uYdP+2A2C4sZW0P2aGY1myYzbvuNaE95+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710314002; c=relaxed/simple;
	bh=NswmWCAg+kMRO6U9D0wl7waRlD6nXsRyQ2PxmrtRxow=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ljuXHFnJgMzlB48Xd7FibR+C+qbcrofgI9HqM/rnczttcXcDBMlxZpyIfQ+vD1oFPv05OXVjslkBXZtkKpIN1/n4E6QgCZyd8xeUGeCJ71Vo1a/8WbUziZXg0NNtQgYLSi/E9ODAGTY3nRQ0AFfmvNHStEdFckoKC5Zh1phRD3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0D0WAzO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc13fb0133so34078055ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 00:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710314000; x=1710918800; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBO1QyjEKgY+z+cbFw6h6LK60G04OlYaLIToSeOvUhY=;
        b=f0D0WAzOmGZ8xHDIr6Eh2zZIUT0GxMuQ0vsQLWtdL0ytyXuhrgAQXjzR6AxSW7FvEr
         XDVZbFkxkZTImC7HrNkrlhx9e5bBVi9HPLMemTJA0XXt/dcQlSWDFEpBQUo2iMQ6f8hK
         44xrlNLeD5IPkhbp8OfXxsHJC+MWTRC0xzZfYUt1ZL9GCUNJvuSXMEyzJbkYdjzkYAXz
         mfHzsMiq2R8PpNT9xfUQmZUGYZ8fsooXW2fj4Fv4EeunrsGFzz/RCN13INbvUWboOcRs
         Xqy3LY2sZS3FE4FFf5VR+4q5RHPHkNfV+ARKipcYEoabfWgqB25fHdAyty3egCXHHmia
         afyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710314000; x=1710918800;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBO1QyjEKgY+z+cbFw6h6LK60G04OlYaLIToSeOvUhY=;
        b=WR83PtWxN+lEEPauKw1ByywMb1hMgQVTeJFVGUDHpSEaAJK2GIhRjceTjR9Mz8PDTt
         fnMmEDSnJ7uy4dehJizGZ65/U//vINO9m7TwIYa5TAeM76FQXnnBsxeFpXO2mfQDjv0B
         z9lbpwuyx3qkEQU+1JM2V6SG2rsWMSnzt+dWVWOIHhE9NPc4OTcF6bnc0N8UP6f5f6MH
         ziDUlAfSS4aRkOWzmierPvuai9dmFVvZUIGegH69udboS5+YHZkBP9YRuHYaJqJHbUtS
         ZqwmFx7+5tvgLa+2E687SyHvHKc2CBFd/IIUU1IOT34SPIuL5o4D4xwTSDaGT5HOFi8P
         M1GQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1pa13Peb3vAsV/NAGuR/IhEHLaOMQEm1kyIoBYTJhq2qehz/OO68cVR5RDHEalv2nFNXg+WgcBtqPXBAkqjIjKqu3svdbDRW5Mjct
X-Gm-Message-State: AOJu0YwU21Xoq3jF4bYrB4gaEG+A7RIorPCOvk6DGg9GkjMhIvwyFq2k
	w4cqUzTWvR3754QckRCPqaL8PzVNsRrzkEjS5EBGrc8xwfQ5X+f/
X-Google-Smtp-Source: AGHT+IFblix/LUHDLSUUvpaHyyUSlGJQl+RzQPyKcxgsHFzN57XwW20vnlxtvFbGF30VidNwlzsWzg==
X-Received: by 2002:a17:902:b691:b0:1dd:6eba:c592 with SMTP id c17-20020a170902b69100b001dd6ebac592mr8500687pls.56.1710314000537;
        Wed, 13 Mar 2024 00:13:20 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902ea0200b001dc6b99af70sm7806180plg.108.2024.03.13.00.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 00:13:20 -0700 (PDT)
Date: Wed, 13 Mar 2024 12:43:18 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v3] staging: rtl8712: rename tmpVal to avg_val
Message-ID: <ZfFSDoNPjQypC829@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rename local variable tmpVal to avg_val in function process_link_qual
to give intuitive meaning to variable and match the common kernel
coding style.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>

Changes in v3: changed variable name tmpVal to avg_val
Changes in v2: added a period in message
---
 drivers/staging/rtl8712/rtl8712_recv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index a3c4713c59b3..1fabc5137a4c 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -861,7 +861,7 @@ static void query_rx_phy_status(struct _adapter *padapter,
 static void process_link_qual(struct _adapter *padapter,
 			      union recv_frame *prframe)
 {
-	u32	last_evm = 0, tmpVal;
+	u32	last_evm = 0, avg_val;
 	struct rx_pkt_attrib *pattrib;
 	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
 
@@ -883,8 +883,8 @@ static void process_link_qual(struct _adapter *padapter,
 			sqd->index = 0;
 
 		/* <1> Showed on UI for user, in percentage. */
-		tmpVal = sqd->total_val / sqd->total_num;
-		padapter->recvpriv.signal = (u8)tmpVal;
+		avg_val = sqd->total_val / sqd->total_num;
+		padapter->recvpriv.signal = (u8)avg_val;
 	}
 }
 
-- 
2.40.1


