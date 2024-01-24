Return-Path: <linux-kernel+bounces-37765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFD683B4E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FCB2863C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF520136648;
	Wed, 24 Jan 2024 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="DGB3WYaP"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1131350FF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136299; cv=none; b=mzcbq6ZsG/sBSHYW75CZyvPz5C9wnCi3Q9NJzHIDR7YIUvCK039xOy3ylCmB8qzLjWXDtsjS12K64t1Y/NtvJA2HB4TEOdfe5xIwyQvL4JiEbzpQxUUc91PhH7niOSXycwrnP6BObxduQtdV9EPLN+WP3rIbLLd0CcKDawjhxNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136299; c=relaxed/simple;
	bh=2LI+n0NSZxIFwasn14oMhGM67wNVvtAwhMC/6gpzngg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LaGKMYF1Dw9j4gsoyfVZaU06eP0mJxEZ3jG0vm4RlrWKH9szL33p0Ust+pdS9Q7lJIpmenMKUE7JCcX8g7LXusUSQw473+TXAsXZAZinKZML0FPlob3e+Y/cHscS8Yi6yYRIdaIk77013Z0zAG05eTsiebqMQB8owzh0DUFN/Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=DGB3WYaP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d7232dcb3eso30180525ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706136296; x=1706741096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nVA/7PiRf+yK+UXU506sZM4NUP/OQ32pk51Oj1lxJ5Q=;
        b=DGB3WYaPuwDrdfi07yS/34wIED7+YJwPGzMO5ZyFhFS5m0d8UkiE6JiZOswa35t9/F
         j3ON46wbnzQIziQShD4S7b9Rwk87kEXmumMyvhNd7m8t6WaUoKvrXH9MbKjpkDq1aDwH
         NeEWkZ1m7BLnQ4gTF6VH8SpGgXSLebeVnefZhKEl3jph6+giO6IbRyNUD45vwP1+26kY
         h9ETu5mqlrxzC1CoUcaDJjr56QTu9ROu1ZJwwNz3CtaH/pIOj/rAaz0ImOaxne1bkJcC
         a3HwfCP+d9VLHvXDFKtN2NNMWkLfXtkLIWtv9xWV0KAyLnfbiy8OzdjgWWN3mCm1xcsl
         1jDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136296; x=1706741096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVA/7PiRf+yK+UXU506sZM4NUP/OQ32pk51Oj1lxJ5Q=;
        b=d5qMdiUuR5pu+ED08lWw3fIrcoMZUmYB9pgQkGtF74P39vwHXscjSfNxGTmtoJKeDZ
         hrU8mk0XcHjJ8FtkqqpggGS6oAJiVS6bU8cD+2qoGtrI6QLWnTEV3YUBe+E0d2YZ9w6O
         Dwsly7zyOLVk0SnvNKshXKYYfeKh1ImrkK6C3BC8g5KGwjD8Vxk5w454YaW8vGqnWbxQ
         AQda7CYfpOxUZzX+CaaCngWbCMoBgPy4vZvu/3rs1+efCH8AhwdhH5BHQjEcgguUlQC/
         UuguhasJ2tQ+O4RUcGZNPi5sroXQfT4/jHI38ng7u0oyWW83K1NvAr8e2cRjfCtJ5yZJ
         5Dwg==
X-Gm-Message-State: AOJu0YxCnhp0YPAiP9g3toF4JdUYPa0o26ulBU3dR8hkZp1wjGL2tBTV
	yoe+7OpHwfqiYeVK3WZe1lyXJiGxuO1Kr7cZVvLsk07fV0RZo/o2rL4Q9VGMMQTRe/Qm7rUZEqo
	9
X-Google-Smtp-Source: AGHT+IE/utPrHKSYmmpRHBP60l+OqEUPiPMjyxbXstmF5/R5lyXgM4fY0AwbCmOxW+rUVwgAJD/XBA==
X-Received: by 2002:a17:902:e5c4:b0:1d7:92c3:bbee with SMTP id u4-20020a170902e5c400b001d792c3bbeemr135448plf.38.1706136296343;
        Wed, 24 Jan 2024 14:44:56 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c28500b001d73a2acc0csm6743987pld.283.2024.01.24.14.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:44:56 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 00/18] Staging: rtl8192e: 18 Additional checkpatch fixes for rtllib_softmac.c  
Date: Wed, 24 Jan 2024 14:44:34 -0800
Message-Id: <20240124224452.968724-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Another checkpatch fix series to be applied after the series titled:
'checkpatch fixes for rtllib_softmac.c' submitted by me, to the list, 
on 1/5/2024

Thank you in advance to all reviewers
regards,
Tree


Tree Davies (18):
  Staging: rtl8192e: Rename variable FirstIe_InScan
  Staging: rtl8192e: Rename function rtllib_rx_ADDBARsp()
  Staging: rtl8192e: Rename variable LPSAwakeIntvl_tmp
  Staging: rtl8192e: Rename variable LPSDelayCnt
  Staging: rtl8192e: Rename function pointer SetHwRegHandler()
  Staging: rtl8192e: Rename function MgntQuery_TxRateExcludeCCKRates()
  Staging: rtl8192e: Rename variable PeerHTCapBuf
  Staging: rtl8192e: Rename variable PeerHTInfoBuf
  Staging: rtl8192e: Rename variable LPSAwakeIntvl
  Staging: rtl8192e: Rename variable SelfHTCap
  Staging: rtl8192e: Fix paren alignment for
    rtllib_disable_net_monitor_mode()
  Staging: rtl8192e: Fixup if statement broken across multiple lines.
  Staging: rtl8192e: Remove unecessary blank line
  Staging: rtl8192e: Fix if statement alignment with open parenthesis
  Staging: rtl8192e: Rename variable Octet
  Staging: rtl8192e: Rename variable LpsIdleCount
  Staging: rtl8192e: Rename variable NumRecvBcnInPeriod
  Staging: rtl8192e: Rename variable bForcedBgMode

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 18 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |  4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |  2 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c     |  2 +-
 drivers/staging/rtl8192e/rtl819x_HT.h         |  6 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c     | 32 +++----
 drivers/staging/rtl8192e/rtl819x_Qos.h        |  2 +-
 drivers/staging/rtl8192e/rtllib.h             | 18 ++--
 drivers/staging/rtl8192e/rtllib_rx.c          |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c     | 96 +++++++++----------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |  4 +-
 drivers/staging/rtl8192e/rtllib_tx.c          |  8 +-
 14 files changed, 100 insertions(+), 104 deletions(-)

-- 
2.39.2


