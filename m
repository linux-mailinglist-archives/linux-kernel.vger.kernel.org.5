Return-Path: <linux-kernel+bounces-7787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BC381AD08
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 386B4B218B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E1D27702;
	Thu, 21 Dec 2023 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="gRDkVydo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SmjcwgfF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE522338
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 848E13200A80;
	Wed, 20 Dec 2023 22:09:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 20 Dec 2023 22:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1703128169; x=1703214569; bh=S8kq+ZcQq3volLdHUggxF
	+uRhAbqpjv9oNMSix9Veq0=; b=gRDkVydoTkNfEQTXXRPhCdhHBud65TPAkQmWN
	vAhUIx+8zmGsX8hBcrXnkJ8N5mzdxf26ouPJcleCvZUyRxDwrJEPblB0Zw2TeKzl
	JNdzhMejD980JkreGvGjeU7s/zV0OAadad3fxCEmW7wqRIRRIZ9rf4n6jOsmfZ/8
	Dn1VmKldUhe2nrsJGwJ6cfraWTn1fLEa7N8wo68JBdHmlvnko81eIc8slRFefSVZ
	uHnYYoRwvN7B5hoLhU2VrwvXLlx/fRPFP5qOwRsxZv5xi44ztJOjh3/BOXAPYOsA
	U3VPc8yVa17Y6vkyrbA69BW6GjOp1C2xuGdX/eSKy1ryoQDfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703128169; x=1703214569; bh=S8kq+ZcQq3volLdHUggxF+uRhAbq
	pjv9oNMSix9Veq0=; b=SmjcwgfFgRA7umbrg60OfXiFE3Pvhp8jQUZYYbcgacAt
	1h/Vd4k7Zlnw+1WsyQ34x+MJfxRix0l9MwufJwuvLSovOI6cIoFLgRS1YUeP1iXo
	MSkJo8RJ8cideDMe80jM04+H3WZNzdUD9QWC07JFO/Nw2TI9Hz43qcLePdz3dJsV
	BYVkiPbSVxLr8/HdnWHqfU+UQreCr94XKFud+xFmQ3A6Z9edd69/MM9WDIrL74i9
	2bvlDeSM1ScwlG7rbQHzJ4b9ERXtlUBUXtyu2beEO5NcbO5AHay+aDpACRsVO5ay
	KNQhUJS6o/Kn4UL2AxZILHFeZODfu3GE9dXevPmowA==
X-ME-Sender: <xms:aKyDZUtBhqlPJA6HazUmnEmu0mhxfA1VNLyEqFpSIB8G9aUaPs3zfw>
    <xme:aKyDZRdL7U8U59QFye0FoOHfYtnjx7-xwI8kpm4kl4Tc6LSc9UzJkjAOgDYYsK5Wn
    _TjSWWrUrNB_pZ9-Tk>
X-ME-Received: <xmr:aKyDZfz6E1z8wTn4Yi9vB1RJvPywre388quFenBbjsSk7pI2BQdaP-pw5_5z8kc1mzDpU93YVljLrBe8qfSLoJ3P17lVr73t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddufedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgrrhgu
    sehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepleegffffgfehhfejge
    ejheeivdfgleefheeuueetkedtffeihfevlefhgeevvdevnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfhgrsh
    htmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:aKyDZXOxM1Uzvdh0nJFPqiInMGp_f8m6MGy9ka57DJqsYZgfpT8HDw>
    <xmx:aKyDZU-kt0RF6iDugSY66uWAfFQa3pIKyvpCR4_Gk2QfbJLvTl564A>
    <xmx:aKyDZfWLirs-MSKeNzHlqf__h2y8uZjF4zXvQghoYtO7O5iHprRvug>
    <xmx:aayDZTab2oQ-W7N9iZZayBZnc58OzJbsdEdFgiBVpJYI9IFcAASVLw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Dec 2023 22:09:28 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@list.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 0/5] staging: rtl8192e: rename variable HTInitializeBssDesc and (4) other
Date: Wed, 20 Dec 2023 22:09:59 -0500
Message-ID: <20231221031004.14779-1-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series renames (5) different variables with
the checkpatch coding style issue, Avoid CamelCase.

Patch 1/5) rename variable HTInitializeBssDesc
Patch 2/5) rename variable HTResetSelfAndSavePeerSetting
Patch 3/5) rename variable HTCCheck
Patch 4/5) rename variable HTSetConnectBwModeCallback
Patch 5/5) rename variable ePeerHTSpecVer

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>

Gary Rookard (5):
  staging: rtl8192e: rename variable HTInitializeBssDesc
  staging: rtl8192e: rename variable HTResetSelfAndSavePeerSetting
  staging: rtl8192e: rename variable HTCCheck
  staging: rtl8192e: rename variable HTSetConnectBwModeCallback
  staging: rtl8192e: rename variable ePeerHTSpecVer

 drivers/staging/rtl8192e/rtl819x_HT.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 16 ++++++++--------
 drivers/staging/rtl8192e/rtllib.h         |  6 +++---
 drivers/staging/rtl8192e/rtllib_rx.c      |  6 +++---
 drivers/staging/rtl8192e/rtllib_softmac.c |  6 +++---
 5 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.43.0


