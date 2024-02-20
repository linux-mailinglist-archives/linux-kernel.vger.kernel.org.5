Return-Path: <linux-kernel+bounces-72319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B5785B1F4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06222842B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D3E482C8;
	Tue, 20 Feb 2024 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD8fdPdC"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14717554;
	Tue, 20 Feb 2024 04:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708404163; cv=none; b=lP6aImu78SKDeoLqkWD/qZREr4pgtoSC6iuOHG1qtCxMXeS7HIDRBLJkrpMU/swZev6ICb8Pu21rdVxn6e9GyRQPT843Ir7KtoO/x5g1iUVdR1ZLFGI1/nsLprdcwDkHdjJ+OfJ/gVs2EnTg/We3osBu5R/ZHnN+0673gGSSyGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708404163; c=relaxed/simple;
	bh=7pvaqoLmPrwWYnFwOVxUo22bsimQIabq7xOyzIwKpN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ek0d75ckZQQO0vfkDB+hqLFha5nbj/tEc9z5ycEfOZ97szR1gITMGPe3ynLidNezcGHzj27du3fbj5YrIqazNDwu8NRQbGdzRZluRodhMuigZMOzfm/SwSvqkNy+fZ9+PIJ+nNTBoUrnBqIjfh/0duLgqN6vz8gf6QLXG4ZoFR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hD8fdPdC; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cedfc32250so4091108a12.0;
        Mon, 19 Feb 2024 20:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708404160; x=1709008960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AqVfvVlCEsMFd8kDIu0G8Zi9nnrXu8SbCnlkzTz8Wyk=;
        b=hD8fdPdCbzQRv3HlNQuIPEqK2o52blpVNRQV8c6k+aqV2t6jFCtwt4eAWWWxYlIdnn
         QN7eWOfHaQBhuuIQROiaZjCU3OtCkRok77faIQxsUQ6yDfxNvSoVrmIevTvvzavYNqdD
         r2nv0Q56zGnjQOFq/o0z5vDpfQ2G2P1LA3hQpJNEfyudNQ5QCR4Xc8C1zmCbVyiDiS8M
         pjytBRvPMWKS2p1JVXC/nb4BbAIHX0NaKzYL2HMHxndzpFXN3a75m/1gAIhMo0sto+uD
         n9fMuOd+xSe28AoDalbHO/Ly1LKFPrd6P3PfxaOUkvvYuYDSItmhZ4FU2BskdjAVbnCb
         F2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708404160; x=1709008960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqVfvVlCEsMFd8kDIu0G8Zi9nnrXu8SbCnlkzTz8Wyk=;
        b=DabyDf/ymGL6Msa+VPBXPmLArg20KJoAUaYjrD2/106EWP0A6oDHLiBFMR5bLshxnq
         OI8fhGgah8BDC8DQxOluKA2Ct1mN1aD5g3di/BxUEFbSs5WD1tAA2G/8diDPDmvlP2FG
         YOuK00NlvF7gEaIcucZQNYtLu7/YhzVo7Dzd+BLqevZzLPjP1tgXpQ3FH3d174qo3zT1
         E8wItmbqHuQ4NDi7Q3KWLUXJdcurYPGkhC5jrC+z1i7OAX6bXEkuIdHjRyXc69pCoNzH
         +FCGjzPOOLQYd28uusBi4EtdH12WGhZ2gF+7BjHK7tYg4sHWbIxHWFGPfOFJmJX3ckQY
         kmzg==
X-Forwarded-Encrypted: i=1; AJvYcCUGASa5hM5BJVv7HXvkAAvw7P+/NEV3j7jMvWAKLEbgul41eCiF1R6ua3x0m4UNXcRn0LqExVz/AEVU7/+Kl3kMLiS40jVn2BDsUkoM
X-Gm-Message-State: AOJu0YzYtmKkSqdroeTC2BMto7FuuBGTdX0sCJevQNW1NnAT6t1TLtEG
	VEztFkMi/mmh/8xLmyl52u/y1dQgCJHFtyZWpAZVgDxEpkD2iAS1WsXOpZdewnQ=
X-Google-Smtp-Source: AGHT+IH7b8iYxtKzocgG0J0SkAeGEF419TU5CXcVokvMNLXSl8f/lZ3WhG4rT5AOx6Ao9Hyid25Tag==
X-Received: by 2002:a05:6a21:1789:b0:1a0:9939:c7f9 with SMTP id nx9-20020a056a21178900b001a09939c7f9mr6968166pzb.13.1708404160369;
        Mon, 19 Feb 2024 20:42:40 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a5bd:9c11:af2b:aecf])
        by smtp.gmail.com with ESMTPSA id f9-20020a17090274c900b001d9eefef30csm5195923plt.6.2024.02.19.20.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 20:42:40 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To: davem@davemloft.net,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Yang Shen <shenyang39@huawei.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH 1/2] crypto: hisilicon/zip - fix the missing CRYPTO_ALG_ASYNC in cra_flags
Date: Tue, 20 Feb 2024 17:42:21 +1300
Message-Id: <20240220044222.197614-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing CRYPTO_ALG_ASYNC flag since hisilizon zip driver
works asynchronously.

Cc: Yang Shen <shenyang39@huawei.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 drivers/crypto/hisilicon/zip/zip_crypto.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index c650c741a18d..94e2d66b04b6 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -591,6 +591,7 @@ static struct acomp_alg hisi_zip_acomp_deflate = {
 	.base			= {
 		.cra_name		= "deflate",
 		.cra_driver_name	= "hisi-deflate-acomp",
+		.cra_flags		= CRYPTO_ALG_ASYNC,
 		.cra_module		= THIS_MODULE,
 		.cra_priority		= HZIP_ALG_PRIORITY,
 		.cra_ctxsize		= sizeof(struct hisi_zip_ctx),
-- 
2.34.1


