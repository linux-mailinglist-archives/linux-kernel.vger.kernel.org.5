Return-Path: <linux-kernel+bounces-8928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C33E81BE45
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFE71F24534
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA38664A97;
	Thu, 21 Dec 2023 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="Th/nXTNa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2ISSMTs0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0621D55D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 64FFF3200B24;
	Thu, 21 Dec 2023 13:33:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 21 Dec 2023 13:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1703183631; x=1703270031; bh=heDuDpy+uISKkCe6vhwVw
	6pxYCqmXys1k071fX+whpA=; b=Th/nXTNasdsk1jaFCCwbtJgYHUGf6CUZc0ScC
	2enSM7DWoiW4KUQ81dc4nNZ7wPHXei9wMtsRkUjgAMygblSi90y1sEVG/MOqA7cK
	gC5DDdXhtm/vvi9Hp5c1auIqw2ZGajBefAILSqFfBekUCpMXMw4QQ/fOdDB8e6Tm
	jHdNVYfZYpWgKKdfBUV+cKkzz4OJ/AqLo0gaZMN9ulXNM8O9faJxrsYGMg+xrO+A
	Xkc8yzPpQZAEmk8HjKuaH0+nwga/RadIB5ONy1T/CxdGrPVh9YiKKx4DC6diY3zk
	wlEUZiS2BpBO4ZDs/GUGyT98TvShlWFg21SI8Fh8V7BV5vIxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703183631; x=1703270031; bh=heDuDpy+uISKkCe6vhwVw6pxYCqm
	Xys1k071fX+whpA=; b=2ISSMTs0qN6gg5QDipF1//4Jqi5zbvKQkNe78gHNovuE
	WZqWgvks30R3XK645ybKBhqp9/r2295cXn74/ZG/KJrusbUuma27XnBOGpxlf0U/
	F26dYMkRO+/cxV2n6tktPL3ro5N15zRd+D0UJa3aLg1wkXmZmoE+WAo/BiHon7/5
	yiHyh+wjAcMs7ZP7M3XPdb6GReQrpdO+s3wCW/Ib/n5u8valzUL7aiItM2S2nxHj
	cRIKIaRvLCWw+19Zz2Zo7AuUCo9+MBTuI5w4uvb8cUcU/1el/93OqwaKO1JMkvkS
	45bNv0RwHqCwRKQGbDGL/KrrdmAXY2zQkFSPagUi1g==
X-ME-Sender: <xms:D4WEZWVOUNRhdr4lkUo-XTW8hTwE484B-cC2D9eeO9MCQUMqO1oEFA>
    <xme:D4WEZSk7sq_S6ehK_ejMhkXxeaRlM7mSWQCFa7ZXxyNLDXDnQAhFwAm1sJhgFanfW
    HDKWY4N6Edd690sviI>
X-ME-Received: <xmr:D4WEZaZeNv-gopYJtK8IS7yWrdtxf9sQe0hhn6otBkBJPcNsiuMS44kF40BVI3QkVMxFTiqY1pG2-sdNfqiDccXtEjTXrLih>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgrrhgu
    sehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepleegffffgfehhfejge
    ejheeivdfgleefheeuueetkedtffeihfevlefhgeevvdevnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfhgrsh
    htmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:D4WEZdXcGv2YT3-IIChrXDnd_qSPgCbZ4aSUmQkunPLtIN_wH7ejjQ>
    <xmx:D4WEZQkpd23vxAfmbiqGyYIZt6UIEcKOBq1W561_dna2lR5vAd68tQ>
    <xmx:D4WEZScrzc0uvHR6mWBHG3GXLgX_IlebN2H17Kt-JIpK1nL85dB9dQ>
    <xmx:D4WEZagui1Cr7JnpNj63VuFidaZ13SnL0XYT-nD6DKHbwGvGbt_sVw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 13:33:51 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v2 0/5] staging: rtl8192e: rename variable HTInitializeBssDesc and (4) other
Date: Thu, 21 Dec 2023 13:34:08 -0500
Message-ID: <20231221183413.8349-1-garyrookard@fastmail.org>
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

(resubmittals)

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


