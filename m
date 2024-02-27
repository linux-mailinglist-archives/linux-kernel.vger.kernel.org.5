Return-Path: <linux-kernel+bounces-82682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D12868843
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF4928606D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C12E52F6E;
	Tue, 27 Feb 2024 04:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="PQDFt0n2"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7730134BC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008924; cv=none; b=BWwVRRhpZC7aGwZWeazXG4I0epW3p1KG1MojY0OQkxHsf1kt4S1dkOH5CrIyja9akdvTWnWo4bBk74En1S8/8eRsNhyUw3VzMVxDgzqMPioSfi1Qb9I6fHAR/m+BdjX4R4KARQx733ZUI0PXCDStNg+9Kyni2BHEaBB3d+nbVQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008924; c=relaxed/simple;
	bh=AWQdU3kluKJoPz7o6Ua8Eu/5RWK0WbDEPD6Ctry4hsY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Odfetb9C3yp491eKTQCCWBCkQ1C2DV5Q7GHz04IbQVvoACJAH/Nx8NILURXohVWdn7ZE1SZy3cVENbABvHXps8GR2RosLvVMz89mbIek5UgGVLFE24dgP1a9FNtYapI+Q3KaOrZkjhVbPvG6IG9lU3WtFcKJUc/3/4LpMBWrF34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=PQDFt0n2; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2204e9290f9so3110fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008922; x=1709613722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HY0NP7LwBEVPmbCQopnpQZWuVE0uOUptWypnv7hOyd0=;
        b=PQDFt0n2UIPl6vV5QrMaGQG1KyixqZRscg4px4BI4Wv2e4+koWv4RXVQnXLXA+K1H5
         68lXFzbpV695FHb25W659QaoGAuW3nKs5bMMttNVkXz+jcxCVr7Yx6gVw5eWgWiwlT6R
         TpG/t8wmsHxBgJ5PQCNAPS5q0DVJfsD6aRNpIIQOjQupCsKiUQqIYHK4eTnrxwN7xDbr
         sFtl1CYgjH2fPn5G0SSfUh100H921T3yVsJRJcVOUBFRwbt90cOfEt+w8agkSXthq58Z
         ePUch943+R11TaRpCT/hADztor+zJUcXJCvDIX6PZd0e4O8BHu+N3DmaGehwcOZqeZMT
         YYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008922; x=1709613722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HY0NP7LwBEVPmbCQopnpQZWuVE0uOUptWypnv7hOyd0=;
        b=WwpurXJOpUIU+F4qzKpuf25vHeFIn62vOFQEl3IFxJXtp/JnaVWFZ7nlO8clNbCEzZ
         t1m/tm6gGN3DocWTFusxyQPVPZ1aLODiBIkH8atT5zyXQX3U2SQOeO21wRd4YGHeDaIv
         HTk0eeH8sF0wyIs1MgRmWJfWRTtCnf9ekywlvZ55hVX2T1W48XTk77iSWasgW4RQ6uMQ
         sZcmHpzIPweUJoj7i1IHo28ZAtXKkrGj9GZNDAZy6NtQQ+bIgxtglnMAjL1xfIi340dB
         ZZheq8AbFk0KjbllSBcDR0aD5Zpe2Yjjtfg8z1vi08sLzkvTxAqlv+ceNOr5AypigQ7j
         2F4A==
X-Forwarded-Encrypted: i=1; AJvYcCUJe0r3zpOA58ZsR4H33OHc4G3G9mj8Eyl5I2rPpq3AID0Wyl5kB9dX5KlQdeUmlB0kf+X1vrTg52iMxiiLtTaD573ek4nTQK1Ojx3Z
X-Gm-Message-State: AOJu0YwRBHh4tK4y84c7mEpHyJ0kfHPGOU0GvMfJt3fsDPIWtQ4JurDi
	rPHEM1wmGdgiUQ+Wm3rKGerHOVPNaIWSUQZw36UHL7NEiWygJ0CMNTfeMsXDOMo=
X-Google-Smtp-Source: AGHT+IGq3R67hDCiBxtzlyXfpYYQ3rKc6mjiCveNfVzVaPM9pbPsxdkbXPgOX9OsNR61VLXSrmcqpQ==
X-Received: by 2002:a05:6870:918e:b0:21f:c7f9:a4d7 with SMTP id b14-20020a056870918e00b0021fc7f9a4d7mr7687168oaf.3.1709008921774;
        Mon, 26 Feb 2024 20:42:01 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:01 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 00/20] Staging: rtl8192e: Fix checkpatch warning for rtllib_softmac.c
Date: Mon, 26 Feb 2024 20:41:37 -0800
Message-Id: <20240227044157.407379-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series attacks checkpatch camelcase variables warnings found in
rtllib_softmac.c.
Thank you in advance to reviewers.
~ Tree Davies

v2: Fixes a few alignment and commit messages which went over 75 chars.

Tree Davies (20):
  Staging: rtl8192e: Rename function rtllib_rx_ADDBAReq()
  Staging: rtl8192e: Rename variable NumRecvDataInPeriod
  Staging: rtl8192e: Rename function SecIsInPMKIDList()
  Staging: rtl8192e: Rename variable PMKIDList
  Staging: rtl8192e: Rename variable Turbo_Enable
  Staging: rtl8192e: Rename variable osCcxRmCap
  Staging: rtl8192e: Rename variable bCkipSupported
  Staging: rtl8192e: Rename variable bCcxRmEnable
  Staging: rtl8192e: Rename variable CcxRmCapBuf
  Staging: rtl8192e: Rename variable BssCcxVerNumber
  Staging: rtl8192e: Rename variable CcxVerNumBuf
  Staging: rtl8192e: Rename variable asRsn
  Staging: rtl8192e: Rename variable AironetIeOui
  Staging: rtl8192e: Rename variable osCcxAironetIE
  Staging: rtl8192e: Rename variable CcxAironetBuf
  Staging: rtl8192e: Rename varoable osCcxVerNum
  Staging: rtl8192e: Rename varoable asSta
  Staging: rtl8192e: Rename reference AllowAllDestAddrHandler
  Staging: rtl8192e: Rename boolean variable bHalfWirelessN24GMode
  Staging: rtl8192e: Rename function MgntQuery_MgntFrameTxRate

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |   2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |   6 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c     |   2 +-
 drivers/staging/rtl8192e/rtllib.h             |  25 ++--
 drivers/staging/rtl8192e/rtllib_rx.c          |  30 ++--
 drivers/staging/rtl8192e/rtllib_softmac.c     | 128 +++++++++---------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |   4 +-
 7 files changed, 99 insertions(+), 98 deletions(-)

-- 
2.39.2


