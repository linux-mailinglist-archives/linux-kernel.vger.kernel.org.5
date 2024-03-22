Return-Path: <linux-kernel+bounces-111682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE202886F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823371F23799
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACAC4D5A5;
	Fri, 22 Mar 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbW5Ujlb"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D93E482C1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120318; cv=none; b=bohyLDoO6mmSMLrMxHcGAePin/aWpaBVWugwWufItgMTXsGssAG3XxJlUr3yuW1VUFOcewhZf2hubHiMtv900VOh+jyltj402XqOzwuTNUIeDXhYnHHPOmszV/4KQcWpupMYrjXdZWffi9oYbNI6m67MzutSTFqdO8SEDAotju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120318; c=relaxed/simple;
	bh=e26f5oBYl1V7sQG3UDIthvm988qnELAgzd5n3j9cLew=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rsFFnhh61t/WPVNHPj6Yso2Mpx9hlD15WZcTU2KSmi5rYuNz833VGGkM2lYCT9jiLDeQKQQrUwwQv8WbYhSYWwOgofbZjsOh/Twi0n3BebU4bXSiUCLdkZtzpVqbHJuMyRpuLr3n6/m3lE6qFH034Ht3XyWe6cOyqcSWo9B0x7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbW5Ujlb; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-430acf667afso14097571cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711120316; x=1711725116; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=swSy6KPdMtuES3cNHj9q9SkIUTExBeYlvBJDd89Ngu8=;
        b=KbW5UjlbcCiUuo3qPGieUTfz8q5l9B9DBxU87zZl4oBAexlWEoRus/hZ/taGpIfgrG
         y+sVNsGTsjdaAou+kritRrMJloBkkg9SUWd0P+AjKbRi6tENb2sIJ5hw8nqOi9yy7dVR
         Q1D46XBE9vHhEJ0Ov09Ai+x+CF48NoDFxDHsh1aS4l8HW9Dfx8osJ/eNHSbLtJnTdnA7
         Tz0GkIV8rc+XTCmIDT6SMPeK8PubN/2AdXAzHLglto5QkaRawxUMd1PjfAFs8jxQzZC7
         lE/uCY5j7VI/Zxbxv7kPr4hhzrmetjZKs472qXZoQD41ii5objv8LF/aaaUNmMeBt5HA
         Ar5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120316; x=1711725116;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swSy6KPdMtuES3cNHj9q9SkIUTExBeYlvBJDd89Ngu8=;
        b=RqWcC3SVoMTwl+KxSMHe4tZO1NESzSfsoWB+xALHtTrp2hECg+6yfic+S78/lYjRLn
         Q3Z6TSnoYVV0jik12M8UignUk/UfPg9+B+VUg1h88hel4Y3xLiHwIofuIxTYDgvMqcS6
         bou03D2dkxfKSsYgMk3y5eGob07/zSVNvIy6cgZ0S0daHh5H8XghNvhP6/493xFa92Z8
         h6qufFeBc3ukq20Nq3q2URGa+PFTIDdZdjAY1VyFcaQgFQJx1xa7vvdPY5so/Wmk9HLp
         +aVNev8VncjY8MNnPgmp/jRuTDryn6CMICMmJENktEgzWiUgF/Wqzjb27xkUHXPg+TnX
         0zYg==
X-Forwarded-Encrypted: i=1; AJvYcCVNH+yceYLSDoPiKRrDh+j0ReyjxyF4ii1vCB+7AUR56JLsZWDmX1NUGsOWkJcmExEdR+KaZMFFGZjvztpQKlmzrbNR1u0/FNUAWj7u
X-Gm-Message-State: AOJu0YwKQj/A7i32rWiqLynK+elF/5wCwUuF2P3ouuvyQuzuOLC0Hrxu
	sAYx3bovlBcF7e9Y/alFLjGTAFGgVz7iBGjoiqS6MMUojtxYzECh6lOa/s0yelMCYA==
X-Google-Smtp-Source: AGHT+IGwmx8XOENCOWZn3tWl6dEYzPhYxPqy7UkM8ujgB0AZfux8SEqhs3WZtfkf6KTWcr49GGZr5A==
X-Received: by 2002:a05:622a:148d:b0:431:24a8:ab83 with SMTP id t13-20020a05622a148d00b0043124a8ab83mr2837032qtx.18.1711120315845;
        Fri, 22 Mar 2024 08:11:55 -0700 (PDT)
Received: from dev ([50.202.39.176])
        by smtp.gmail.com with ESMTPSA id y10-20020ac8128a000000b00430ef755b74sm938341qti.27.2024.03.22.08.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:11:55 -0700 (PDT)
Date: Fri, 22 Mar 2024 09:11:52 -0600
From: Brandon Crain <bcrain1606@gmail.com>
To: larry.finger@lwfinger.net, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: rtl8712: Removed unnecessary parentheses
Message-ID: <Zf2fuHV2gmSOSEnx@dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Removed uneccessary parentheses from source file

Signed-off-by: Brandon Crain <bcrain1606@gmail.com>
---
 drivers/staging/rtl8712/recv_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/recv_linux.c b/drivers/staging/rtl8712/recv_linux.c
index 215fca4abb3a..2bf4661432a9 100644
--- a/drivers/staging/rtl8712/recv_linux.c
+++ b/drivers/staging/rtl8712/recv_linux.c
@@ -105,7 +105,7 @@ void r8712_recv_indicatepkt(struct _adapter *adapter,
 	skb->data = recvframe->u.hdr.rx_data;
 	skb->len = recvframe->u.hdr.len;
 	skb_set_tail_pointer(skb, skb->len);
-	if ((attrib->tcpchk_valid == 1) && (attrib->tcp_chkrpt == 1))
+	if (attrib->tcpchk_valid == 1 && attrib->tcp_chkrpt == 1)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 	else
 		skb->ip_summed = CHECKSUM_NONE;
-- 
2.34.1


