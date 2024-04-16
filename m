Return-Path: <linux-kernel+bounces-146991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171F68A6DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48CC31C223B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF2B13281D;
	Tue, 16 Apr 2024 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE8rRiqc"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63951131E41;
	Tue, 16 Apr 2024 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277164; cv=none; b=IO+ZF1zmZjP0HO2xdzwlPeUkblYM6uOkPpCXXXpwhNDhbljmUAAlQyM2STUg90lLO1U6psVlCwihCrhGtVs7ZEsATm9hYEqc8NJ0atUerKiA67xJ06twSTRg1Jx+xOFPYWEPCbifo5Pgc8mid9aBW1eZOUn/ix7L4oYMYIass20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277164; c=relaxed/simple;
	bh=aq0hA7B0x5d706qgYJ1t7a6tNJ/tdhFYP2EzIgnL85g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZK8B2S5YlW69JTcfA1JfbAJCS10f2yWTjF2rJ3WW9L4LDHmDO6cKYEXvevcTH9meD/2gSeDRr7lM1SuoKSCkhWjqA17nLU4OvSAqYZz3bycWvG6oj/qF9IAjMXE6Trubu45nE5pGX498GEzH7Jhm09ELFNP8edm/t9Bqi3wgcX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE8rRiqc; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-518931f8d23so3487570e87.3;
        Tue, 16 Apr 2024 07:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713277161; x=1713881961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GMJKaoKwWKNVSrwIZ9iKLJO15TvA/nZDanwLNQOYh8=;
        b=nE8rRiqc7I+q/npdJ0/6j0j+devTGf9eSrsDT0pWu60EbdQtcaJc6Js5v2frJOoX2V
         FJXsZmsS7/+cecpaCn5BOglwYRKE7t7XCfqxSdqlUmcNfyUtSDzM5X5syjTNq+oEqAA4
         FJR+BxO4vnlMzVAR0oMOa9v0Ota4t3sG/l7dvz3itxYt4UeQf5I3l22zfglq4ttSxnqE
         etEj11DsZq1pkWAccZik1kArpdW7AwxeWwHV2yECVkLrnxH2EwcHickJfPpLq2YOZams
         d2BRVc7G/kK1sZ9ekbjnGB4gh3wvVc1ptaDTeW/cgaH5Xf5pvVBFQhlWj/Hj8SyUQ37o
         FqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713277161; x=1713881961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GMJKaoKwWKNVSrwIZ9iKLJO15TvA/nZDanwLNQOYh8=;
        b=kP0xFJiox2bMvFXNAOH7kphHle/TfZZAtutV2apQr8N4dgTiz+SHJBvWU5ztbrVQJx
         EpJEfSEdCMICnMWEpToDLm+2+1aN0tvdKpO5Xcj6SXxVGm5J1gOURBRKria06tcK6pDb
         qWoZiqH5qAXzj9uHMx5oZYJ0XyPROb4ughesGTO5wMG9s67C53vBJjEfx1d4yz/iSDet
         PbejUROn+Jo0FTLJae0r2Fe8zUMZemMhuE/sVhh6mLzla0gc3u7IE3uK3mrO2ZweJFWL
         +ijYBWzBpX96lNmiARjnHr1H7i7L/tNwQO7SOWUOZF7k/2zdcQn3SJWRFUbwQ4TU8uIg
         DPhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlhDS2U/nfGVMintYh4SSO2SUp7H4rJiPqJveY+Zt/4HWiy4wk3BQIStbuWE2+wC1gl/6oj62Hw6+OJBAnicA/tqXDrV+cRMSB8PJ2SqIzzp7mguy1IhmEwUCxSQl15LsuSipCNy++KY4=
X-Gm-Message-State: AOJu0YwfzoeHxgvzZ+l07XcduTHG3+n3Dp72HUy2ugb2jIYWMfMwW0L0
	BDRvPd9aRsNYyZD6aMjpAiOt9lXz8aliNIqWEMCJo4zy6XKkCN/H
X-Google-Smtp-Source: AGHT+IHBJ0Nzhvg9pviwXNYSE4vtYuBxCtJRz2rlBKHTpH2keTuRXZuNdEJjborrQSYEGwDaBlmXwQ==
X-Received: by 2002:a05:6512:39c5:b0:518:de06:31b6 with SMTP id k5-20020a05651239c500b00518de0631b6mr5329251lfu.3.1713277161120;
        Tue, 16 Apr 2024 07:19:21 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-57-233.cust.vodafonedsl.it. [188.217.57.233])
        by smtp.gmail.com with ESMTPSA id b11-20020adfe30b000000b0034625392416sm15055114wrj.104.2024.04.16.07.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 07:19:20 -0700 (PDT)
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: 
Cc: martin.hecht@avnet.eu,
	michael.roeder@avnet.eu,
	tomm.merciai@gmail.com,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] media: i2c: alvium: Move V4L2_CID_GAIN to V4L2_CID_ANALOG_GAIN
Date: Tue, 16 Apr 2024 16:19:05 +0200
Message-Id: <20240416141905.454253-6-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416141905.454253-1-tomm.merciai@gmail.com>
References: <20240416141905.454253-1-tomm.merciai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Into alvium cameras REG_BCRM_GAIN_RW control the analog gain.
Let's use the right V4L2_CID_ANALOGUE_GAIN ctrl.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/media/i2c/alvium-csi2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index 30ef9b905211..56d64f27df72 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -1993,7 +1993,7 @@ static int alvium_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 	int val;
 
 	switch (ctrl->id) {
-	case V4L2_CID_GAIN:
+	case V4L2_CID_ANALOGUE_GAIN:
 		val = alvium_get_gain(alvium);
 		if (val < 0)
 			return val;
@@ -2025,7 +2025,7 @@ static int alvium_s_ctrl(struct v4l2_ctrl *ctrl)
 		return 0;
 
 	switch (ctrl->id) {
-	case V4L2_CID_GAIN:
+	case V4L2_CID_ANALOGUE_GAIN:
 		ret = alvium_set_ctrl_gain(alvium, ctrl->val);
 		break;
 	case V4L2_CID_AUTOGAIN:
@@ -2154,7 +2154,7 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
 
 	if (alvium->avail_ft.gain) {
 		ctrls->gain = v4l2_ctrl_new_std(hdl, ops,
-						V4L2_CID_GAIN,
+						V4L2_CID_ANALOGUE_GAIN,
 						alvium->min_gain,
 						alvium->max_gain,
 						alvium->inc_gain,
-- 
2.34.1


