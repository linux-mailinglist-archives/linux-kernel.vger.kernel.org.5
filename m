Return-Path: <linux-kernel+bounces-18490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EFA825E5A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241CB1C23285
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4184401;
	Sat,  6 Jan 2024 05:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="I+YPX2G3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C741FAE
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d9bba6d773so244430b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520566; x=1705125366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0cUcEr432jJDPoBzAXGhfAfATW/0uQ37Ygm+1e1bE7I=;
        b=I+YPX2G3BHmnPdiLQ7Hwvh22NDmwuKx91fpQDkNUYcv8Wwf8SlqJrakrAc7NN9Xw1i
         lxGxApxHOcVkKTwAkuAQVBX8/QJpNx59mHNkanIT3KHJk9zAtLPCu5OAAmvrDyYRM5pl
         +kGof/5tqf7hcLrOpeJjnhMS/w+kgOTToeAYdC2s1ZTntvzUQoQWYWMr2ZS0gI1tnswp
         bgyKyN9jxDwFux2FKO5kaRdY2hvsATch67KLGEs3hQf5CwTszrLZ0mT+IepFIYJ1yAoZ
         eIKYYDmHmfn3cXVdnLU0KSp7Ham4omza+XqjMnlkMYoZT9InI5JduhrBwQLgKoDR2Uza
         xEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520566; x=1705125366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0cUcEr432jJDPoBzAXGhfAfATW/0uQ37Ygm+1e1bE7I=;
        b=G3sXVKDST0NjXIv5E0JQLSO1CiGAF5Ce6lf1lyUzO3s075OSqMxeqbudPJ8Wag1XcT
         tjPkyCkZ+ZQGVU7l4cdMHstNYQvwPekIRMpVDueT3/xlerOaYUVaz2ogvmIzOdh77Isn
         iCM96DeNMDZ3FqlZhFndlC1yI9b3fbsGel32MTC4pSu3dEQzl9PtXPHvybLeTpB0pWyH
         +0KZyjzVPXCKpSGBkuluo/UPM6o4+iTS/4I2jA0X/wkmdY1BXfCAQUiYlXzaOvaqfwqj
         4gt9SuvXU5tev4NvwSh7XDUJvkglC38mi172dwSmuvGDpEjmCSEP3GMKh8UEZCTim3wb
         5dXw==
X-Gm-Message-State: AOJu0YwE0Da92pB333k6eMMapjTVlKObr3K4ONdYWzRHR1+W3Axfz1xt
	y+NllDPa9A0sAG4lcamDiifiRGX279t2qsH/c0tooEDiK0g=
X-Google-Smtp-Source: AGHT+IHaGvh6PP6Sl9ViixIGJEkv8PKMYN2FB+1f5L9+Hc90DKBQf6mP3KKiEzSNGmO2zGO1R8t0MA==
X-Received: by 2002:a05:6a20:8c23:b0:197:5be1:262b with SMTP id j35-20020a056a208c2300b001975be1262bmr531663pzh.83.1704520566578;
        Fri, 05 Jan 2024 21:56:06 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:06 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 00/21] Staging: rtl8192e: checkpatch fixes for rtllib_softmac.c
Date: Fri,  5 Jan 2024 21:55:35 -0800
Message-Id: <20240106055556.430948-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series' focus is on fixing checkpatch warnings regarding 
drivers/staging/rtl8192e/rtllib_softmac.c

Thank you in advance to reviewers
~ Tree

Tree Davies (21):
  Staging: rtl8192e: Remove unnecessary parenthesis in
    rtllib_softmac_new_net()
  Staging: rtl8192e: Rename variable SlotIndex
  Staging: rtl8192e: Rename function rtllib_MgntDisconnectAP()
  Staging: rtl8192e: Rename variable bMulticast
  Staging: rtl8192e: Rename variable MaxPeriod
  Staging: rtl8192e: Rename variable bAwakePktSent
  Staging: rtl8192e: Rename variable bSupportNmode
  Staging: rtl8192e: Rename variable bBusyTraffic
  Staging: rtl8192e: Rename function rtllib_MgntDisconnect()
  Staging: rtl8192e: Rename variable bFilterOutNonAssociatedBSSID
  Staging: rtl8192e: Rename variable array Bssid
  Staging: rtl8192e: Rename variable NumRxUnicastOkInPeriod
  Staging: rtl8192e: Rename variable SlotNum
  Staging: rtl8192e: Rename variable RemoveAllTS
  Staging: rtl8192e: Rename function RemovePeerTS()
  Staging: rtl8192e: Rename function rtllib_MlmeDisassociateRequest()
  Staging: rtl8192e: Rename function SendDisassociation()
  Staging: rtl8192e: Rename variable bHalfSupportNmode
  Staging: rtl8192e: Rename variable PMKCacheIdx
  Staging: rtl8192e: Rename function GetNmodeSupportBySecCfg()
  Staging: rtl8192e: Rename variable AsocRetryCount

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  8 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 32 +++----
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |  2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c     |  6 +-
 drivers/staging/rtl8192e/rtllib.h             | 26 +++---
 drivers/staging/rtl8192e/rtllib_rx.c          |  6 +-
 drivers/staging/rtl8192e/rtllib_softmac.c     | 86 +++++++++----------
 drivers/staging/rtl8192e/rtllib_tx.c          | 10 +--
 drivers/staging/rtl8192e/rtllib_wx.c          |  2 +-
 9 files changed, 89 insertions(+), 89 deletions(-)

-- 
2.39.2


