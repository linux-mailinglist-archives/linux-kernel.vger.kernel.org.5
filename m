Return-Path: <linux-kernel+bounces-75563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B442785EB2A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FEC1C21DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F2686158;
	Wed, 21 Feb 2024 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+ENc9fT"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161B10953
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551896; cv=none; b=K3bysYSREbziFBCriclXCbHZwTFCQmTZFTY4u0jlC6XvHnF/GK78R1NvoSEVZYOp7vD2bP0l7pPwUrh1D0oA8DLJAQTrTXkAHyhe2srboir3pTGxui+j96YjEYuxbk4ryoES/lJZzwW/oC++oqlPNgboD5ZQOBV1Sbp8agR1Qm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551896; c=relaxed/simple;
	bh=aA4Gy6/ZaYz4uFrJ/NMt48u1DHVuC+PyHyZgzp065GY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYptzfI2ujvb+EDrMAiiEwfqLTgMzrFzVCIS7vL5DzaGBrlLh1Bli53ZnuftelGvt5KJaDzj9lOI4LqbwX09mxEx+yGaGWbwBEFJ2U1Sp2ijGdZ27Up9p/149ltuqqDPAG/w26Kt18gflSMZa9AutAaefbU8Uzg6cbeD+TeZ6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+ENc9fT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d0a82685dso1432571f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708551893; x=1709156693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lkDHZ0S83xtn+c72wEW0bI98J9xkgLKPq4ec2sPDp98=;
        b=m+ENc9fT+KVSrGAdVQ5TIBmdfw8ooBGjsRfme3akoSSWCGPGaascrxR03krPblD2mv
         xqKYyU8L6SxPGPjPvuJJH+rVNhMG5IL6ejJdHQ9XhdhI9wtxIdA3kpU2X8+r1KZKOev3
         n4RwjqS1jO56xNopcLyRNXlhbNI9zudxDCXZZmOaqVSwJ8nPysk26wx5OUc51shPYXc1
         jWD9keOeYoCfhKKVhtlInCAvTkJx8TWgVxi/ktS6UUzpD8IGJOeXD7riTywZbZbsEAaA
         uwE4keUEgi6XTsnCvFvS5uqX1eSLYDh1rAJ2vjQN3MvCQeqCO+NwGkKVnn2GygQKuReh
         F9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551893; x=1709156693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkDHZ0S83xtn+c72wEW0bI98J9xkgLKPq4ec2sPDp98=;
        b=mD1L09ro1xB2Eu3ndo/rXAeT7KqV4izaAZVd9e7/EEKqiY4Ov/RvI6iehTpJ9lysWN
         iNLj/qZVM1DU5oLfcN4Hn7tFWa+hA2lKr9xNMReRvfqeyfLkqeIVnim3pWgQS30dcSGe
         YdtEhN+nSyhDWN8wAuSj2ErhYwnJ4BPTVvq3KyEy1EQr7GtdnKD4vSyc59UjfCAa5Z8G
         rZ6Fu85jA+5SI5Y+Y2jS/oBmQOpTFK7R9Nn4Up6lmRdJrDd5A9OS8Nv7xM7YNmkLnw7/
         jI6bf3qeyfQRHHyfHuocrZ6/88VvCINeReiaPihFFylKSMZxn7yddfOzBNCDxMs1bqeR
         RGmw==
X-Forwarded-Encrypted: i=1; AJvYcCVUbUO5bXWMseA66nDME+JHPB8D8lQLxvwlf2YALVvI9k2ssd0kTY2wW/NycMbwy1GdEtUFoFJzwbIw60xXLQgkJfjpF9GiX1YksLUr
X-Gm-Message-State: AOJu0Yx9vSexDZxqOPTW/s5ts7/vm4P+KCbLfRmf5kYabBF/zBNFlQQH
	usF4f9GF454vMnD39xcUBoAeFRW2dL/Vaflxn6Q95zPUJsJfmBC1
X-Google-Smtp-Source: AGHT+IEJF23POes/HJ593ZB4NM8Ylgv1aapcgQcDcaOl/NVHEklg1wOcfPg2Bdb8oYt/DPIuYgraNw==
X-Received: by 2002:a05:6000:a15:b0:33c:fa05:68b with SMTP id co21-20020a0560000a1500b0033cfa05068bmr11757428wrb.0.1708551893278;
        Wed, 21 Feb 2024 13:44:53 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c1c0e00b00412680b270csm3982837wms.5.2024.02.21.13.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:44:49 -0800 (PST)
Date: Wed, 21 Feb 2024 22:44:47 +0100
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] staging: rtl8192e: Remove variables tsf, beacon_time and
 Antenna
Message-ID: <8f400e46ed16ec7a226284c42654855b2aba6502.1708461563.git.philipp.g.hortmann@gmail.com>
References: <cover.1708461563.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708461563.git.philipp.g.hortmann@gmail.com>

Remove unused variables tsf, beacon_time and Antenna.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 348644998744..945874c1495d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -474,8 +474,6 @@ struct rtllib_rx_stats {
 	u8  control;
 	u8  mask;
 	u16 len;
-	u64 tsf;
-	u32 beacon_time;
 	u8  nic_type;
 	u16 Length;
 	u8  SignalQuality;
@@ -486,7 +484,6 @@ struct rtllib_rx_stats {
 	u16 bCRC:1;
 	u16 bICV:1;
 	u16 bShortPreamble:1;
-	u16 Antenna:1;
 	u16 Decrypted:1;
 	u16 Wakeup:1;
 	u16 Reserved0:1;
-- 
2.43.2


