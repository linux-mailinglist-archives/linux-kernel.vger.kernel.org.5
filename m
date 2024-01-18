Return-Path: <linux-kernel+bounces-30100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C108831938
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFBF1C226BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD8A24B4A;
	Thu, 18 Jan 2024 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkXhqtgp"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEED1241E2;
	Thu, 18 Jan 2024 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581406; cv=none; b=Xu6dA+EqkQ/yh0ufoVobGZ8/z2RnZ7u32uM6qu6qqJu30R7n1Olu+/FgKsGy547Q4vh57TsGriHfs+FVNdW5XtQboh6XKBj3LTXNmpzv451tI/px2iQn3rQNyinQwkylud7bsWVAA6EK+VeXQoIkbl7zKZGcSzAjeEwUW9AGbz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581406; c=relaxed/simple;
	bh=GSZCSpOqqzhMr6RwGuO1VJCCM884qyencHZG28chH8c=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=EBT01LHbZ0PLetbh9RZn3D9ORQU2HAcw98kwH1wABok7hfPYeDFfSTqVf2cqExwktn5TN0WKayeA1GPRAOn/qhcu0OZnfAdtqEMSiZyflMncMzfmxuQYRTuHuA/S5/JBOatIE8e5ecmt0wWL0aFzKHHIb0GibED8BooIXnLMnRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkXhqtgp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-336c9acec03so9986388f8f.2;
        Thu, 18 Jan 2024 04:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705581403; x=1706186203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vA5DjepX8LO8HhgjcEQi+IWwObZWbeSNM5x2007oZCo=;
        b=lkXhqtgphqWJDB2Fde4+QiEg7VNhst1hP3USufwGsHPUrHj62X3Ybs4Fmo5s7WRGyj
         C86EekwaYn62lWAW7u2kydmMFlNZWL4r3LFErsMfcFVHrZP7YDBacZRJYaTkAQsye0j/
         qTPCEgm2ScDAvrvn6X7soXDnKYlJTb9Hx2Eb8m0yes8RQ5r4CWlKw6ID7r0ZZzCv0EHs
         +1/MJgEp0zfPfbHY1gTcj+yo5NW2JwusNwTFfWN04yZ4kJc/CWdqLWIgNTMDKdLuCoNw
         0rtgSEx+DAJQAxe1N7Hu8l2PjdNkLnY4GezMRDUNX4OOGoEpuiwOdM3nh/W4KpnPWjfA
         As+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705581403; x=1706186203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vA5DjepX8LO8HhgjcEQi+IWwObZWbeSNM5x2007oZCo=;
        b=hyPBoRIk5jUDI2nV2GH2j4H57qRgcLvaRIV2cWpgBdKy6A/j78zuqHqiysODae6o40
         e93xm60uow3H0FQemVMjkMlafDbxgshuBv1TRhvhewCEh20mBwQeLOITAcYxwpIdric+
         xIgiTxJg0uR0kVMgMPiyBknRqOiH2KFVZOguEbKMNmxXlbO24YatAjw5PNpdYEHZ4+0C
         FStBoZb1wGc44Jiiv3rk+3+ikfiKqaI3eyBp0opC3tL2Hqx6oERsJUER3yC1hsgBDxVG
         b/BInnm49gZ3B8AK4qbLYFt4T1KngoPIfotCGG5XccJpW5ddxggYklMCcEqq03QeKUCM
         RsVQ==
X-Gm-Message-State: AOJu0YzS4xl97S9dqmdukj+/3oRooj0ubAWECPFsyH7hIHjf3Crwceu8
	Al94qeC+R0hfb5szE31/uQFNzNET3NaqMzKHQHTD7UjxfwnJvY5H
X-Google-Smtp-Source: AGHT+IHaaeFxW7LHOmm4opdqNbFrJe66ZBuztiswDWE9W2nJuSGi1SBoZ4OebX2R7NA/FUs/dGT+vg==
X-Received: by 2002:a5d:4051:0:b0:336:ba58:dade with SMTP id w17-20020a5d4051000000b00336ba58dademr460304wrp.62.1705581402845;
        Thu, 18 Jan 2024 04:36:42 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id cp32-20020a056000402000b00337c55d9a28sm3027825wrb.93.2024.01.18.04.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 04:36:42 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] comedi: ni_mio_common: remove redundant assignment to variable status1
Date: Thu, 18 Jan 2024 12:36:41 +0000
Message-Id: <20240118123641.2542208-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable status1 is being assigned a value that is never read, the
assignment is redundant and can be removed.

Cleans up clang scan build warning:
warning: Although the value stored to 'status1' is used in the enclosing
expression, the value is never actually read from 'status1'
[deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/comedi/drivers/ni_mio_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/comedi/drivers/ni_mio_common.c b/drivers/comedi/drivers/ni_mio_common.c
index 980f309d6de7..824b026238b5 100644
--- a/drivers/comedi/drivers/ni_mio_common.c
+++ b/drivers/comedi/drivers/ni_mio_common.c
@@ -3798,8 +3798,7 @@ static int ni_serial_hw_readwrite8(struct comedi_device *dev,
 	devpriv->dio_control &= ~NISTC_DIO_CTRL_HW_SER_START;
 
 	/* Wait until STC says we're done, but don't loop infinitely. */
-	while ((status1 = ni_stc_readw(dev, NISTC_STATUS1_REG)) &
-	       NISTC_STATUS1_SERIO_IN_PROG) {
+	while (ni_stc_readw(dev, NISTC_STATUS1_REG) & NISTC_STATUS1_SERIO_IN_PROG) {
 		/* Delay one bit per loop */
 		udelay((devpriv->serial_interval_ns + 999) / 1000);
 		if (--count < 0) {
-- 
2.39.2


