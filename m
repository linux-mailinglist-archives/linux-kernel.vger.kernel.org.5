Return-Path: <linux-kernel+bounces-101140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357DA87A2FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611D71C215A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3237A14A8C;
	Wed, 13 Mar 2024 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvQ4yIg2"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F571170A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710311846; cv=none; b=hRZGcG8UWgBVtRQNPkbhxIJVzAB3zrXg4x0skPaLrq+S5WBL1X6cAbpzng5CHjtVBHC4JEGC4JxFMGJRJ2Qy5QW52PA6B8V9etQsLn1kmAF7PAHNN+o+lmbo1HljD2g3+dDHck4MGdHvYP/Sfs7qSp0+ec3OXL1lgDa99Oha83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710311846; c=relaxed/simple;
	bh=Or2WBw6YX+IV5xSEQOQCL8yhX3fsths6Q0NUzC55HSk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bu49rBCd1wygWzPNZMTmxURy7llhmUh2s7Bfvr1/sOlzJ70I7fanan5fEN/Q5KbQkU1J6mGI/ipdKFusxetkDK6GlVxEopx8Qloljz28IJ/c3Ys60srHA9uKq2CDeIGgvbniP/DX3KXG+Zm1+aSAkL6peZviCbKHUZt33BQz4LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvQ4yIg2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc13fb0133so33925285ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710311844; x=1710916644; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMaXmk4HmWbUzjVR3qh9Tt2QkYGm0OxfkEbHr+IeT1o=;
        b=SvQ4yIg2H28haN/Xl7NwVLcsxKPpWSXL3LmHU+Yk0lVgiBuxmZLpAQ7Xm3U5CouVel
         PTRCqTzap+jbT2LeiaM75c3+MdZmdvI0y0fgTjuEi8rz+mVxYnhmYyXDnsWxVzrGM/yJ
         qtXI845JHTlUChQHkSqfaMiMo5cJBZajLoY9sACDq/1as9g2mrrPil0R51OG8extrZiw
         oRClNth1MBgzllXcDaTG+dkcGCuVD2p7YQu+PCqAWbILuiF1s6Voq72P5wJ9e//03REC
         EHT8rloXSLMV8or+6SpTHTma4KKwL4qu0N9khmQUI1Yd39bEuo/hQVU9kTWroTpWVZTM
         pFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710311844; x=1710916644;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMaXmk4HmWbUzjVR3qh9Tt2QkYGm0OxfkEbHr+IeT1o=;
        b=tVko2RE1RP+VTsvg0q9dPUTnXrdAxIBc4HqocfbltD6jYUZsD8hobFNUJTe5Nin8nq
         fhyv5gd8608JkNVwD6AET7PmLMyonc0J1phtYlN2tLK5u58dlztSvqyGSvMlFlfW3KHc
         biJaDbNAcfLwtZ4zz/5zpaceeNzPHqfyFJLYHHL3UcfjAgtB5DZTXibvLns+G1zo+XY9
         rxwZlp0+MZIiOME/0nylo7N5ISgeEuiShre0KV0W5GZaSw3+cFf1bJ66Gn0CYdiTYpOf
         f1y9sKlcXdQ7TCShjlCYp7/s+o6H4eEpeAYMtCqdkZPPYh2KmUniKGc1LMV+tOmTA83R
         PKgg==
X-Forwarded-Encrypted: i=1; AJvYcCUhVvfszLiFJ+n3SsEsU7BSl6WQF8q6YcT2P5LjKZNmYJaSMkHqnfqKDyOv6JWUNc8Fj+/nT8gubwDYBbQaEtTVKcFJcKGQ7bM1cEbh
X-Gm-Message-State: AOJu0YwDai31MsK++mKSlB3HM3xiUK3uAotyftPZZDxBpnOxNsGvSqo4
	w18dfinoR/eShpi6xGWxI5OMuVYjF9cZR/lnyO/arj2JwcFhzOPe
X-Google-Smtp-Source: AGHT+IHSBF/+uzvX9U2ZYfAO+2838arE+6lGwa1EqQmBoQnYcSrzbS1DAOthlhWvDqnPpZ8pPal/0w==
X-Received: by 2002:a17:902:f689:b0:1dd:9250:2d26 with SMTP id l9-20020a170902f68900b001dd92502d26mr11241330plg.47.1710311844309;
        Tue, 12 Mar 2024 23:37:24 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001dcb18cd22esm5828256plg.141.2024.03.12.23.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 23:37:24 -0700 (PDT)
Date: Wed, 13 Mar 2024 12:07:21 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v2] staging: rtl8712: rename tempVal to temp_val
Message-ID: <ZfFJoZWURDM+Uin4@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rename variable tempVal to temp_val
to address checkpatch warning 'Avoid
Camelcase' and to ensure adherence
to coding style guidelines.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>

Changes in v2: added a period
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


