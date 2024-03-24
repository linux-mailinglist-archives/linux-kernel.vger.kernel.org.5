Return-Path: <linux-kernel+bounces-112860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58A8887F1F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FA1281798
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E49F1D69E;
	Sun, 24 Mar 2024 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/IAQfR7"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814201CD00
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711314984; cv=none; b=UryPWA52awfdbLxPl1zcnL0Iu28GX30OvvbojPSAYkfGdfJ7T+QAed524iLsi/STVqY2YIA3jysPclMZb6VSZlOZF+dHCiw4gZLDqvg5p/0ew8ligK507f8pDzT0QWhcMRDwl3tNWRlfd3QrGY6bcydDyE9GQU5+lS+bS9Fqkzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711314984; c=relaxed/simple;
	bh=iyxLUF8voIIK/fK/5eHIb+b18lryX+ZiEkTFUpt2cJA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dA5uceBvKb5pJm6lWzDtA6RxoMc4BQUfUV1MY2pJ6XjjnhR4JVSewIIwmexrzrg2H7rk6s+LiEIBzqeh7Y23S3YALrMPo/9TAsMGR6gnekgk+4+PQNGUiYxkBV9V/xrG4BpCUWoJuuR2VUePca+l8ONaweYdk/uOZk9ApiRLUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/IAQfR7; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-222a9eae9a7so2025707fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711314982; x=1711919782; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pln1HFj7xRGcjDqNNAdcybo1cDlWpEN/yYmJg/vxZWY=;
        b=j/IAQfR7ZQrFDp/8ja2bXCbdWGZ3cQ3c6zgXt+V5kMInabeYjA6PyFLvmQkzau9AsN
         DQVMPTolZ7qjTqTtiAv9T0/7X6WeSU8jh4x+4wzmZ+ayXjU16e8B+32JBtWmSsRcMiFi
         Dh25NhNe48eyj3iGC8B22skl5wiQS+XdGJJxGDM6z0c52r8Y4fyScWsQ2dG9gD5iXCdI
         bDXRTwm5DerWM4BAQrPFaYNazVPGPyIV49juhMGUVRDwbyLsukaTMLO+/5xGfL61DxSD
         mFgTSYpPmcaW7Z6M7Ebi6Sa4p77Wm54FszMVrl+R6FlJ1rWTxqJw+TeFsFMP/NLNQ6cx
         LwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711314982; x=1711919782;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pln1HFj7xRGcjDqNNAdcybo1cDlWpEN/yYmJg/vxZWY=;
        b=Z6/GG5TeCXO+I2IY1uP4mBeaOj7DKEvXZB1DeX0AMSKiFD2jlVxerpEEg2GBRPCWhZ
         kaHu7dhOZqSqBpn3/MrT68FVW2G4H0/H+F2vrfPau0WKbj04FTigkhytMjVFR69CQ5tw
         3dlpHtcEzrLxD4DE8yervleu38tC4AtuVot0rvm7ncKLv4NqQZk5y6Go0cX6LXmZSLf/
         hPT3DwbuOB2rcs90VplZklW9r+g97jPkmoll8WmpDfcVm1kZBgeFSMgVhz4oRnlnFY0X
         osyYnA+OJzBbHvtZyqdXGTrBye/Imm+7+FEnCdNR6yxDFeGfxdOHBzEnQomvAPzvlppj
         jMog==
X-Forwarded-Encrypted: i=1; AJvYcCXmF2arFOF0HKH6M18KbNjeNpeDZS7m5rplNfzFeKsucswmwnIGG1Rl1I849fLezXUEgu5kGJChdEy+8BP85vIIB1YdMiskNOoeuFgx
X-Gm-Message-State: AOJu0Yy0yU9VcPs67L6trcRD3m2OVSJLZPED0XOM4FkKt+TIDz0LFS20
	yLBnYQFcpMVPm+JdO8cPkeCtbtp0M6IIl0t3WpKdMuOD0liPhmai
X-Google-Smtp-Source: AGHT+IGDb8h4GXS8FBNAQV+Y9fiLoMqubuSJuORQE1s3/Wcvji4vy/2U9keX2dUqcFA0d2WDa4JVSw==
X-Received: by 2002:a05:6870:944d:b0:21e:a839:d807 with SMTP id e13-20020a056870944d00b0021ea839d807mr6520463oal.54.1711314982451;
        Sun, 24 Mar 2024 14:16:22 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id j16-20020aa783d0000000b006e6b959b636sm3003077pfn.53.2024.03.24.14.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 14:16:22 -0700 (PDT)
Date: Mon, 25 Mar 2024 02:46:15 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8712: Add space between operands and operator
Message-ID: <ZgCYHwYOmqfwMeU0@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add whitespace in union recvstat between operator '>>' and operands
'RXDESC_SIZE' and '2' to conform to common kernel coding style.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_recv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.h b/drivers/staging/rtl8712/rtl8712_recv.h
index f4d20b0efd4e..a1360dcf91ce 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.h
+++ b/drivers/staging/rtl8712/rtl8712_recv.h
@@ -82,7 +82,7 @@ struct phy_stat {
 
 union recvstat {
 	struct recv_stat recv_stat;
-	unsigned int value[RXDESC_SIZE>>2];
+	unsigned int value[RXDESC_SIZE >> 2];
 };
 
 struct recv_buf {
-- 
2.40.1


