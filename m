Return-Path: <linux-kernel+bounces-11159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44CB81E247
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 21:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E2A282262
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 20:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE702539E2;
	Mon, 25 Dec 2023 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="M/wEDifA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9744B53807
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bb82a52002so3556486b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 12:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703535797; x=1704140597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OdIPxbQKa8Cv8Owffg1R/sXrNLQmQN3H0nynm3esdh0=;
        b=M/wEDifAE38I5LVdhYq9gxvvNRgVGnvO97HOs/lvBNpvRWepNNMYr+kVUxyXDoI4Gd
         D5C8dwm7FreA/R/yTe62sGdOAxcgdpp2ysNB8z+ABYgzm3B7N4KQ6E3egr+1MHzpJc/c
         IdJuVnqHXZTmmoMi8e10NJmUn+nkrZjeB7GQw2NkkMZOpFveOdWiRQycK3ZnItgUWjJ5
         i0jdAVzQ68iYsOpy/CJUPaamGcaqXQWeaL7UVCPTkDGP8w8PtCTMB45GH+hqbgoiFj64
         OsaG4NytiZG+HLF2ISwQtZ6HCG6DfwJDR1r8FPG30LMY8tmxJ7LQqgT8qa29GJcY3Gdy
         s93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703535797; x=1704140597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdIPxbQKa8Cv8Owffg1R/sXrNLQmQN3H0nynm3esdh0=;
        b=urGZfd4x24MT6JMQr2ucwZcn7qvbyNx0MiYy8zEUuFbEVfzTn0XyeuXwHdikSscN+h
         1J3e/cTGgeUkwgHcuQRS/cZ9MHnlzHB1Gcfi6ZFongkbA8dQ84nUdnhs11Sbi8HNpvID
         zQQcV0t0LyPbLF56NXf8dxbZGI5+ZrsDEnGQ8bNIddBNFAUQN7T0Uh/koRInPNSYZAZP
         vi1iZ2sOtVvEtAjdgIGiMuEpAVLVzNwDWCELfmSEt7RwJHRsss6/vom1qohVGs2IeVPO
         j2SlyBNQq+M+anaJQhZ5NKqDUaerNmyKWD2PWYqSm1flK1kS2DJx/yFlLiw7kGpFevDz
         MiFw==
X-Gm-Message-State: AOJu0YxiSnfbAm4WWI+gjhiHmYKrR1BDo0MVxh5BTKboPHmLGWvjQEef
	y7RVxFrycGgvlVnmhret369FisG6vMXHJz0Qg4VI628x3ZE=
X-Google-Smtp-Source: AGHT+IEQgsE+uywm+xiKRXj/Hjj5W83ncMof8v6BQFCHCmoQfiKQ1ESsELo0NiuzSk6j40Lm4ya9ag==
X-Received: by 2002:a05:6359:4c06:b0:172:f31a:6bfb with SMTP id kj6-20020a0563594c0600b00172f31a6bfbmr9053739rwc.51.1703535797423;
        Mon, 25 Dec 2023 12:23:17 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id l17-20020a17090aaa9100b0028be5732f01sm8741246pjq.0.2023.12.25.12.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 12:23:17 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 0/6] Staging: rtl8192e: Rename 5 vars/ 1 function to fix CamelCase
Date: Mon, 25 Dec 2023 12:23:08 -0800
Message-Id: <20231225202314.31869-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series renames 5 variables and 1 function to fix checkpatch warnings
Thank you in advance to reviewers
regards,
Tree

Tree Davies (6):
  Staging: rtl8192e: Rename variable bUsed
  Staging: rtl8192e: Rename variable NumTxOkInPeriod
  Staging: rtl8192e: Rename variable NumRxOkInPeriod
  Staging: rtl8192e: Rename function rtllib_EnableNetMonitorMode()
  Staging: rtl8192e: Rename variable bIsAggregateFrame
  Staging: rtl8192e: Rename variable OpMode

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 10 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 24 +++++++++----------
 drivers/staging/rtl8192e/rtllib.h             | 12 +++++-----
 drivers/staging/rtl8192e/rtllib_rx.c          | 14 +++++------
 drivers/staging/rtl8192e/rtllib_softmac.c     | 18 +++++++-------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |  2 +-
 6 files changed, 40 insertions(+), 40 deletions(-)

-- 
2.39.2


