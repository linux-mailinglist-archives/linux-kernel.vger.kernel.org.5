Return-Path: <linux-kernel+bounces-124429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F7B89177A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040BF1C2223D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F73F6A00F;
	Fri, 29 Mar 2024 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5oioUz2"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDD94439E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711710918; cv=none; b=Qodcufja/V0YmmSo/9WrLlgBWHgAcQ9KV2D2I/8nI4HYN4DFxsyaEDClea+frMDyACcT6B+7brqgGPBFsV6wAoK0BHwk0KlrbSFG1TxLOXPGoBeaQS6JsiA2OAZVTXKdg6c/EDM+Ehfizb4mpFm2XHibKxsaNiKQ9DHGKEHEH4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711710918; c=relaxed/simple;
	bh=EOA+jVJLIL4PoU6sggptKp83PTQ9H4I6t2TXmnpH+Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJM1+ehttkis/m8ttdBdqR7eG79S3vKtOf0tZYq/8NYdI7jRQ+2HMduHgBPZei8ROporCCsxMTCYY0D9gK08DouSJaGge9Y8ub8RRpFI6PIy7ve0B3ejFAiCQp32ylmFC4UO+4LBh/tU+bFheuL4n7X2e81XYoSd6wKbNtbCWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5oioUz2; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so2746478a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711710915; x=1712315715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6y2nKwiZaKwgK5YzfxmEPHK3AhO3OAbsE+oqfU69W60=;
        b=S5oioUz2IVV0L7TvywOhS+ZfOjnU/G+gzN9LxJsqryWvOmrXrMrVt4TcLhbu9oCTvk
         fqGE/nMpP+BmJKhx2sZVP6xfqZ1xfnLARTcrMZIJkFHXJrTXQISQEea9fTLQ1k3TK6RX
         BVmpbKvMC6XhYrITnoMPWLdnLiZ+HrH0rWFxs4C1qgY/zAhM4rjjerTZ2hUx0+HdsfSs
         PKzgxkXRqC0ZdVFmFK5wPxn6YKtnHoBca4tHSHswjT3LaPJy2n9VyNVFG6yatcLKevIS
         +tXR+8tNHXSYn84eBNX92xin0E6Rgy9Hvw0wf0P4MFJ1LfL5AXGOAiP3O7i83FTKZZp3
         Lu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711710915; x=1712315715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6y2nKwiZaKwgK5YzfxmEPHK3AhO3OAbsE+oqfU69W60=;
        b=Djiu/WRxMj7ZfbDeNsAHwit5tNl2hGoANocdCBoSgeF9pLWk3pOG8MLQ6D68Rro7r0
         L9XSvqnfevf6KHTfQnNjDsuqNbLfW6UEZBpA6zeZVx0zfDypyDVsHUSLv/XBxWdRP21P
         c4YMbDC68fDSAtsXv0DtBv4ctppDLZpcs/Pge4gxH/7/CittdVA2AdA7zEgCKUjD/dLW
         PQjO7ATWCfogC3ch/Rml4xigCfS+EFro4lKtwrlE0LIY8ouilTUs+0s4X5L89AEW9FET
         qzXks0xbLC2zYUIhYqtZelXgNCqKv2Ev285I+1aZ15qpbtJYcqY9oJqADxzbFHC3wjac
         F/4w==
X-Forwarded-Encrypted: i=1; AJvYcCXQ+k8sQfcmBfFUw7agNWEUhyst4ewTVRvbn88llT85xjH0gOF71jsprgnXBbwYPVIBoalkZugQZRi4jdJyv8efwhcJofN64YYiQ5PA
X-Gm-Message-State: AOJu0YymiLQaaR6RjGeMOKwGdBmhA1gZ3lLOV747xhmVdo3/vEGM3LAM
	RMGDIVxhoVaEETtoFsVlPyXg6Tn4zfr/NbqcJdc1XBrptqeSvRtq
X-Google-Smtp-Source: AGHT+IE5klrgPZzCTIgoZMg7FftfA+RvHdIDLm/hKVpxaSnluYHsG8iorvKRB1Q777aNIaYvqscaaw==
X-Received: by 2002:a50:aad5:0:b0:568:260b:e502 with SMTP id r21-20020a50aad5000000b00568260be502mr1086610edc.13.1711710915192;
        Fri, 29 Mar 2024 04:15:15 -0700 (PDT)
Received: from localhost.localdomain (ip-77-25-34-65.web.vodafone.de. [77.25.34.65])
        by smtp.gmail.com with ESMTPSA id f4-20020a056402194400b0056c4cdc987esm1894625edz.8.2024.03.29.04.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 04:15:14 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8192e: remove unnecessary wrapper
Date: Fri, 29 Mar 2024 12:14:58 +0100
Message-ID: <20240329111458.14961-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_rtl92e_dm_ctrl_initgain_byrssi() is just a wrapper around
_rtl92e_dm_ctrl_initgain_byrssi_driver(). Using a wrapper here adds
no value, remove it. Keep the name _rtl92e_dm_ctrl_initgain_byrssi().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
Compile-tested only.

 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 4c67bfe0e8ec..aebe67f1a46d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -163,7 +163,6 @@ static	void	_rtl92e_dm_check_tx_power_tracking(struct net_device *dev);
 
 static void _rtl92e_dm_dig_init(struct net_device *dev);
 static void _rtl92e_dm_ctrl_initgain_byrssi(struct net_device *dev);
-static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev);
 static void _rtl92e_dm_initial_gain(struct net_device *dev);
 static void _rtl92e_dm_pd_th(struct net_device *dev);
 static void _rtl92e_dm_cs_ratio(struct net_device *dev);
@@ -929,11 +928,6 @@ static void _rtl92e_dm_dig_init(struct net_device *dev)
 		dm_digtable.rx_gain_range_min = DM_DIG_MIN;
 }
 
-static void _rtl92e_dm_ctrl_initgain_byrssi(struct net_device *dev)
-{
-	_rtl92e_dm_ctrl_initgain_byrssi_driver(dev);
-}
-
 /*-----------------------------------------------------------------------------
  * Function:	dm_CtrlInitGainBeforeConnectByRssiAndFalseAlarm()
  *
@@ -952,7 +946,7 @@ static void _rtl92e_dm_ctrl_initgain_byrssi(struct net_device *dev)
  *
  ******************************************************************************/
 
-static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev)
+static void _rtl92e_dm_ctrl_initgain_byrssi(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u8 i;
-- 
2.44.0


