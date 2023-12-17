Return-Path: <linux-kernel+bounces-2878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E19B816394
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E85B21412
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D01D4B137;
	Sun, 17 Dec 2023 23:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="kAVSwyWZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE714B12A
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 23:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d4bef65786so1013124b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 15:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1702857323; x=1703462123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+snDZLy8asIzjWt/vwGJS1mTnyKPWwo7tBhs/9ZgD6U=;
        b=kAVSwyWZu5xbtOy+wsbqaMPt7TNg1B8ITLjS7N0QDLHlVGZOuC7meSnCEfHM6denQ5
         PTxiSvBJYIzmzOWmAsc3OgOmFyj0en6H+ugfLbBKl6N25wUa0SHgu0tcV1gekykY2ulS
         WwAUlBtYrwHXjc8WQKs+pXmZYBnnP2fturN4OUZHVAMmrLpK01Vml02KETmGfOtUgeSh
         aoWX/V7H3gdMC3y0T6oNzB1OEySSLOOtrNP6h1XVZ6THSNnaX3G6lhp6R2XIjtbvj51S
         N8adpiK8fND3MZiDCS2zCRHVcNeSBnDrxqJsbA6qT1kdsOFl1Zvtfy7sw2NLfi9dTosU
         /RzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702857323; x=1703462123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+snDZLy8asIzjWt/vwGJS1mTnyKPWwo7tBhs/9ZgD6U=;
        b=B3efnIYG4F6Ga3RSqTG6MbjsRC46zLremq2feMS8fhkNHfmYfT5nR+BLiC2ghXTbhu
         orRCNIi32shZKKdi0ftcWVWNHG51mIemVg6o0I1zwUwvlep/qe89YdLwhVZNoSPh99s+
         MJf5HWCsAj7Es9JfvsUfkk1buZ/tAE0/bryJLBxtrvZSCdLp5FGUDfrLdJYMgerl1k4B
         hXKfFXoKxAeQE3Xkb7pYK0yeXEH2a1/MvinLdp6diMIPdvoxRgfAzrb6L92KgkJL3rHx
         yAC6rIfqzZzygK6QNh8bkOCLG7slWlA2u2CILKj148CfRuMxnI5r77jI/b5xFIH/goFo
         KzPQ==
X-Gm-Message-State: AOJu0YywF5cs5GJ+OibQCj0Q+UIuemOzMJLxGQ+CXfyybGdenWacmOnU
	fVoc9C0Ty8V59HlR1uOgu+0LdQ==
X-Google-Smtp-Source: AGHT+IEhhHmfErk1tQPNZa/a/PRZEl+UUQTMCyLJSO6YlKgJZLduDAp6OmhQQ3j3jweGGeuHjKHm1g==
X-Received: by 2002:a05:6a20:3d87:b0:190:cc38:7d7c with SMTP id s7-20020a056a203d8700b00190cc387d7cmr17446543pzi.44.1702857322824;
        Sun, 17 Dec 2023 15:55:22 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090aec8b00b0028ae8284840sm9036176pjy.10.2023.12.17.15.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 15:55:22 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 0/6] Staging: rtl8192e: Rename 6 variables to Style guide spec
Date: Sun, 17 Dec 2023 15:55:14 -0800
Message-Id: <20231217235520.30377-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set renames variable to fix checkpatch warnings
Thank you in advance to reviewers
~Tree

Tree Davies (6):
  Staging: rtl8192e: Rename array variable RxTsRecord
  Staging: rtl8192e: Rename array variable TxTsRecord
  Staging: rtl8192e: Rename variable ucTSID
  Staging: rtl8192e: Rename variable pDelBaParamSet
  Staging: rtl8192e: Rename variable TxRxSelect
  Staging: rtl8192e: Rename variable pBaStartSeqCtrl

 drivers/staging/rtl8192e/rtl819x_BAProc.c | 42 +++++++++++------------
 drivers/staging/rtl8192e/rtl819x_Qos.h    |  2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 36 +++++++++----------
 drivers/staging/rtl8192e/rtllib.h         |  8 ++---
 4 files changed, 44 insertions(+), 44 deletions(-)

-- 
2.39.2


