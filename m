Return-Path: <linux-kernel+bounces-112621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9497887C19
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 10:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7DA1F21727
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA95171C8;
	Sun, 24 Mar 2024 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDsg1x2f"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A398831;
	Sun, 24 Mar 2024 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711272566; cv=none; b=kNRTSoMtqOUJ+HnP9jWJblTfXvwryWZG6DJ2QyLjEHjz3hx9mA8qdt3amjrr/wswu2eYE/nVPbouPSyrXF7S3ZeatwoPV9AXXTN27brMNZuIlYWeKTLIX2WdVzNfe7vpBAKsuNfnOIbxiKmcdKS72zecANyxoYJONF5FfuMtLfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711272566; c=relaxed/simple;
	bh=kJA1ENfcVIOkNw3avk4+tDK8aEfaH/g6voWzg9aHL18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hN8hBVYs3EHIc1aznxlegRTIfzUCYbsB8jGlfpSW4PYRHmnJ7A02CF1/Lh578z1xdeD4mq86aI981rvgasdJvlhDzj8tWZhJECcVe7NfKkW7Kz5fhAAvKSQYRWtRHmcpc6wWrhsXKU3BY8tJSnXpILnPYcsYEOwuXlQVAMbcNMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDsg1x2f; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1de0f92e649so23670365ad.0;
        Sun, 24 Mar 2024 02:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711272565; x=1711877365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o611cLqDFm70Z0Jt+IMAjJ8j+5plaV1gN+jC5Ar2By4=;
        b=ZDsg1x2f+nDdfdRuKuC7cXlFtS3k6R2UhQbg1KfMo4m4CTaECtcbx/csfubNVkBHg4
         KQhNLTWs6wrHkVYXTRq14UDKfDGQ0hdFzHGyI9ODMqWLtYLUIOORbuWleYdqUIeImjtG
         gVKGTOeJujg4I6w3tyF6wnGfnIiO7mllrru/krUl7cLYxjF6JT5SqltQtstmKzEmq1hd
         vT8uD87IYWZU6zazKb2N5VwkC3gIXVMrjwnEf09pHNsg3o5txE3jqPgD9SBWfqpivtbM
         u4NH1Nx4y9v6GLdeIaCOJH1ILHwxrrDdd6+DtNa7zj3oTRy3tyknJogDoOfjkBgr+gCg
         Iing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711272565; x=1711877365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o611cLqDFm70Z0Jt+IMAjJ8j+5plaV1gN+jC5Ar2By4=;
        b=ec/3jI18qq3Ha6jrqIWQsIY8iwcgeFlgtj2JH3eOOr8YmO4UxNj4s/4tfaKWBVIpwu
         lVt4g8+S0T+ZZH+UvFm9BLjhLUcXF6iuoRBM7xDpF1gqZWllrfGw8QIbj6cG7Qj7ky1k
         yzLx3Py2VTRykAU7UWHYSaNlg5oAmuNDz7xcKQrbYjUIGnAkbSMY0uZN/HGG91KjMiM/
         JN1rtjVAUhIppdWoZL9Xo/GdsbiNY2xXjBfXEzd/bvlmOSMPH4jO1QFBUDqoGipnSVjC
         0XLld+9rE6+CDuAP/4t8htR/76QayoOli/wAmYpTxaH9mKQ3W+ieQEPRJ7xNEOS7ZGxc
         QefA==
X-Forwarded-Encrypted: i=1; AJvYcCXJPcKORqASkhV+6ohv+cAE3rUy+I252JyH4JvKMFMp/M4tVU/xejz5MRdHw/D2/mYv4T2wQebxFuVVVXiwaxMfel0H42VM0Oy5RGCG78tMovvFkLLDk9LEf9d6B2xFXo+Sx4a6+oVylgo=
X-Gm-Message-State: AOJu0Yy9HS0y37I5E7Ex3mSxyArL9fS0af8AlfencfA/H9ifJbMnLktu
	Nu8iYp+OkxJ3wH7rrFCwuj8uKBOIGTkdBNi+mB1v3quG5Nio7dDa
X-Google-Smtp-Source: AGHT+IFvawNc97ardr5RtDisvgJA38GFboOggdtFCS3O754mL/vF+2DKsMyOKtUSOxQENHyFOa9F6Q==
X-Received: by 2002:a17:902:e542:b0:1e0:b5d4:9fcb with SMTP id n2-20020a170902e54200b001e0b5d49fcbmr1110472plf.34.1711272564702;
        Sun, 24 Mar 2024 02:29:24 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1004:e7c1:d108:f4f6:f7c6:2fde])
        by smtp.gmail.com with ESMTPSA id y12-20020a170902ed4c00b001e0a28f61d0sm2717347plb.70.2024.03.24.02.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 02:29:24 -0700 (PDT)
From: coolrrsh@gmail.com
To: slongerbeam@gmail.com,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	gregkh@linuxfoundation.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v1] staging: media: remove duplicates
Date: Sun, 24 Mar 2024 14:59:17 +0530
Message-Id: <20240324092917.19177-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

In Kconfig, the kernel configuration VIDEO_DEV is defined twice.
To prevent doing repeated checks, the redundant code was replaced.

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>

---
 drivers/staging/media/imx/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/imx/Kconfig b/drivers/staging/media/imx/Kconfig
index 21fd79515042..772f49b1fe52 100644
--- a/drivers/staging/media/imx/Kconfig
+++ b/drivers/staging/media/imx/Kconfig
@@ -4,7 +4,6 @@ config VIDEO_IMX_MEDIA
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on HAS_DMA
 	depends on VIDEO_DEV
-	depends on VIDEO_DEV
 	select MEDIA_CONTROLLER
 	select V4L2_FWNODE
 	select V4L2_MEM2MEM_DEV
-- 
2.25.1


