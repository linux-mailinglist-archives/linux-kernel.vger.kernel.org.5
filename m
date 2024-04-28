Return-Path: <linux-kernel+bounces-161375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 824608B4B48
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20D9281E7A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CB242047;
	Sun, 28 Apr 2024 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHNM84IX"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C883C6BA;
	Sun, 28 Apr 2024 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714301309; cv=none; b=WyIRSgKq1te1Uo2dHEu7Dtz48x5bRVwJUw093E5ELPCNaVqEx1lawdbVALfC9feV/D5yk2vlSjco17JNEMagXJ/paqCz83D0KahLFFyZpi1XL7sPuzZEGQqzbDIh1K5NBYJtnH4jbh6cQM26H0Lwh0EFE9c0OJ70kDlEOr8WneI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714301309; c=relaxed/simple;
	bh=Su/MY+1KtEeGyvMIifzPiHhGM0TGMM0UV3nYAxi+vw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QaWsPrzwQQUbTPaRaizilBCnDzKYiA0la/coIiphvKciSbe/soBNPhAuWivO+dCYj15z1vHGisQZCRYhfrX6vhM8D8ploqkX29KDjsxb8IwO9QRK9hITcke4M2gy5bSDDGXvqC8Lyuky2RLBpAQ4e+1/Ph++ZizmLYIbDuNiCQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHNM84IX; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso51501221fa.0;
        Sun, 28 Apr 2024 03:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714301305; x=1714906105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8ov05+t8Udb82mVCBM5lM9IrrAklTv8DXCty+zYSw8=;
        b=GHNM84IXkCB9T6IzyOLqwvOIF9cW0rLOJ5V/jcKbOYhqALoD/+GRNTuaonJw3L3AdV
         e7CZgzPvElZi6Cxbfdx7oMnK9BC8Y7wqewj03pPVIQvbeqMGqntGwP79HZbd+p7AYm3u
         f7A9dObtKZ/htfzeBb7vLqCuEza2y20fUT+C4bxoSkrsX0xuPI0QCLUhMMZ938QBPPZE
         ZCPHcQRJZe/736YuPM5gFAjoUKf8WLKyiqifH1OFKetVphYE2Hh+1FPv8+zul3QhX1yb
         FV9Tpm1pkqea9RcPug3Ql3VtLhebM1WKd28nCNI9OGDHB2C03b57p8Ogvje/D8PcBVJF
         C7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714301305; x=1714906105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8ov05+t8Udb82mVCBM5lM9IrrAklTv8DXCty+zYSw8=;
        b=gIGdqfxVzm9zr/3dbLBsu9sNr7jOb8KgQ4w1Zn2GCnHEqn3c9KSxH0Vglomh3rIGls
         BRvZ9EogJFAPiACXAGsIvTINUHfP1hegXZJH1UJoih4k6NibAvGc7BxNsGLF3MJmp+6H
         ItVQC+W0/3w0aKZvWwJQHFiLb8J4xxL61nk1UBdOQfbk93sy6xVVUaEhBSti3XF8i+SQ
         uVEx2BLSfNxT0JdG9jbWc6uC6GeMeSZeBsFbgs/OBDUbR4ply9UCQi1AjPE//hMNglhs
         bQrAKLxbRK4zm/bj8mMolaHebS1yifukiG6FLfra5X1ElT2iJ4CMvsXxKDBDxdClovBi
         cx3A==
X-Forwarded-Encrypted: i=1; AJvYcCVr2/tdztcfxY/96EiMiiPPw7vU75dZV15F5zH1U/iigFrL3Ic5dxNpAYs5K4s97kxk2+hgbPJJA0t66EtFpn2Yp5Xfx8TosSdp4U1YZY3i1LH86GfHVgpCbiJ7o2KKgZ59HEfjoa3R
X-Gm-Message-State: AOJu0YzRBWNlfpnP7bnvDk51dtuBRiYiDoS0Ro+F3V+yYgMWqWdG94F9
	sN4mWtJ9CBREH3BUsMh5FYcp0YDjrY6tf6iMsz8L6ZOYnTjo8XL78eXA80r3xMQ=
X-Google-Smtp-Source: AGHT+IHJ66y4zP9H052R5AVwBxDdQIMYbgcbut6Vo4d3VEMmzDT67P/wVKvvch/X0SUThN7T3JaLQw==
X-Received: by 2002:a2e:8910:0:b0:2dc:d7a6:1e53 with SMTP id d16-20020a2e8910000000b002dcd7a61e53mr4794433lji.18.1714301303631;
        Sun, 28 Apr 2024 03:48:23 -0700 (PDT)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c4ec700b0041c24321934sm1268352wmq.41.2024.04.28.03.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 03:48:23 -0700 (PDT)
From: Aleksa Savic <savicaleksa83@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: Aleksa Savic <savicaleksa83@gmail.com>,
	Jonas Malaco <jonas@protocubo.io>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] hwmon: (nzxt-kraken3) Add support for NZXT Kraken 2023 models
Date: Sun, 28 Apr 2024 12:48:09 +0200
Message-ID: <20240428104812.14037-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the 2023 models (standard and Elite) of the
NZXT Kraken all-in-one cooler lineup.

The first patch changes how the driver chooses the shown name which is
based on the model, while the second patch builds on top of that and
implements support for the new models.

Aleksa Savic (2):
  hwmon: (nzxt-kraken3) Decouple device names from kinds
  hwmon: (nzxt-kraken3) Add support for NZXT Kraken 2023 (standard and
    Elite) models

 Documentation/hwmon/nzxt-kraken3.rst | 19 ++++++----
 drivers/hwmon/nzxt-kraken3.c         | 55 +++++++++++++++++++---------
 2 files changed, 48 insertions(+), 26 deletions(-)

-- 
2.44.0


