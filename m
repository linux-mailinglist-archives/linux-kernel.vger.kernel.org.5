Return-Path: <linux-kernel+bounces-101116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6138E87A2A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932531C219B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77A312E51;
	Wed, 13 Mar 2024 05:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2zBXd+A"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BA4111A9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 05:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710307469; cv=none; b=W2Q3IEGk/hMYiB9woTaq8RbIPCm0IqxrOv2zyDm+9sJJYT+GNyIxy18iE3ymFSqNrkPMmUSOPoymxuHFabjvB++a+DWCMCVxvSQq+DzG42I2DvD/vX9C0H3Hehsm0IIenoN6r0bx6sjTTzi7kzBzOTFJvXDhysHdqdRZGqzsbns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710307469; c=relaxed/simple;
	bh=qpIypB8WcF7kHWP8sQXT/y04bsj8awY5629fpJsi5bg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J15AHRwlZyGMjSrEePw9312mA0qmaBEP8gXMqq6KAkW/z/O1VEqWiES9J9REcYmgHlA10VqOlThWVoEszeZe0O0qYoUfyoMxj9FkRnpK25MdbsXVFUkuszdSykRcTZxLDo+GF+JvbR4TJ9KIvk99F1iqlQS+ARAHbKrWQipxfP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2zBXd+A; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dd97fd66cdso24388935ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710307467; x=1710912267; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G8Ujbc0uorKR7iJQIvU/pWAtBegJQ/IssHdTYPNNDzE=;
        b=j2zBXd+AnVSXX6YAiT86gqvx1X+l7mCl9kgQXsLLwqzJiipHWFfZEI2bOexBh1ZtlD
         bbP6em93dfIqmm7fCoC4Wom9tyTncbwI3V9DRGUDasnueOTFwAMY9vdpy21xlgGQYnY8
         0GndyPi+Qv0jrvWnJ80vUdrRx6BKJF5jF7MCDOjIW+AUE8BhjGKtkNpfTbbRzKyUfD3S
         UBhDky3R/+zfuQV5FWOb2pcApA+/lk82CoJU2O5JNmEgtUXgXuEeTN44vKs3Vc+ORwEm
         0as8IqNNYlOovZeu6YvmsMvma5fwaXi4GlIa/ZVY0kxoEAhUnPs3ppWT4B7RuxRUGqp5
         +69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710307467; x=1710912267;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8Ujbc0uorKR7iJQIvU/pWAtBegJQ/IssHdTYPNNDzE=;
        b=Br6Ct2VTsZhd+2eUjhb70+O5S6veJLOGn98/6ShzfWbzLXvPCBu9ZGzhr21tmQ9O5i
         yaNjI4/G2Uw3TOj8xjt5KUbHXVfC1c0saitdFqFuLQTa4l+Qd+D0yv6K3L3XQe6O3WSQ
         sdz6Ydt1Qz7hGOI4fnNJOkWvYB44+otNmr+pmn7BkKVtRPng2CtpS5QyR4qtxhtY117C
         LqM1+BBlebs7KH6m4pKg/izzjjx3RQdBamJE6w7pKW7RdMERckRphISWLKaKHbe4WgC5
         L/icpV0LF4kxRuwBuxJebhF+mbMLm/5aZhpNMR7iGEPMmnz7cJjjdadGYzgaOj9RLwAk
         vEbg==
X-Forwarded-Encrypted: i=1; AJvYcCW6RpVNkR7jrUtHsxjTYNR1e5Tk08tMktgOBccGDB1irQA4/gcyHss8g2ZY3SMX6xMEhwSIMDy5gwX2/weS8aSwj6FesEk7xf4PyT26
X-Gm-Message-State: AOJu0YxK54qNw7hx1k0m2GbLjimNzpfbgvqqJB9zrQ3HOkfhWIXYa0+h
	KH2W7+WQyNVVnE2ff0HYNzLvywEeVlIErmY55W3U38XSf/olshf4
X-Google-Smtp-Source: AGHT+IGF71tvtFMzeowtGndCZgs8bsvRaTbVptGpopMBIMFMaSEsFb17m5ypAyW3ZqI7ev9FO0xt8w==
X-Received: by 2002:a17:902:d2c1:b0:1dd:a616:820a with SMTP id n1-20020a170902d2c100b001dda616820amr7108857plc.8.1710307466970;
        Tue, 12 Mar 2024 22:24:26 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id ko13-20020a17090307cd00b001dcc7795524sm7673178plb.24.2024.03.12.22.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 22:24:26 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:54:24 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8712: renaming tempVal to temp_val
Message-ID: <ZfE4iDfGUyq/C9s4@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Renaming variable tempVal to temp_val to address
checkpath warning 'Avoid Camelcase' and to
ensure adherence to coding style guidelines

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index a3c4713c59b3..7fb9dfaa7448 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -861,7 +861,7 @@ static void query_rx_phy_status(struct _adapter *padapter,
 static void process_link_qual(struct _adapter *padapter,
 			      union recv_frame *prframe)
 {
-	u32	last_evm = 0, tmpVal;
+	u32	last_evm = 0, tmp_val;
 	struct rx_pkt_attrib *pattrib;
 	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
 
-- 
2.40.1


