Return-Path: <linux-kernel+bounces-98126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0CC877571
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99EAF1F21787
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E627C11CA1;
	Sun, 10 Mar 2024 05:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="VSTZKNsR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RhvapMqw"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0BA11187;
	Sun, 10 Mar 2024 05:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710049522; cv=none; b=Wuj90+H8l32eVYFAECgOY5DMY20KtVVv+bT3whMqzcE/pdtui5G//MBS35sG1q+jACXgHh17uf/YIPNGVOVOCrKJd3k1Yng9oVjaC4srSgUN50o4VEBszQ4EiyKfJad16j3f6AUh0Pf8z0Mhwx26JZAsyxAJPx/SI+NXe07bLSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710049522; c=relaxed/simple;
	bh=HLqCEkT765g/ooytphNVLtlFfHrNE8zgfGSGzONv/wU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aW1csUg7Grti3Tyu+iDf3W6HuzyY37amI2o/Wo+ztY3r/S/MF5VyPLxuQ+AD9oKmN8DiHfzHGvQnWM5LwIl9GCWFl0DHsrN0TMhA39NqHDnzyfWYK8M73NOGsuFXTF9/YrpkxyIQbzgIUSM+RVlIAGUmHMjFcYhPlNKUeyEQ6nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=VSTZKNsR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RhvapMqw; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3B5891800086;
	Sun, 10 Mar 2024 00:45:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 10 Mar 2024 00:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1710049518; x=1710135918; bh=TUY/NbmmUinSyFdDkFWJE
	U/J22Tn046+8BPbZu7yzmg=; b=VSTZKNsR9uK1d185CAGuGv78NgakXUK5r7gm4
	Q/9MIBmySHiM2ffS7TfKJKgQTzAoUhXIt/xtiH57vMaK3m53haSv+jI3vJXrVttu
	Gp/9eua4FkOvAHaGL75hHekDkCWWU829oQCtVrZh/riIp60Tt/Rqv72A8a5b8h0v
	M7NRAlOnWrzLTqL28P7ktYqclnfzlOoh25UDYpyGb8i0QF5jREYDWT/5zVRaIV+c
	Pdb/V3uhVh/5Br6C0VCLdeKvqRcojfUeRcE70l+TMwHlt6BPos9MLD+8Yxe7EeHg
	mGqv4kGkWtR3HEPGvmU3Ftco6pZD3rMasT+wHMPSWa4ifT4XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710049518; x=1710135918; bh=TUY/NbmmUinSyFdDkFWJEU/J22Tn
	046+8BPbZu7yzmg=; b=RhvapMqwLQtdvIwOtjDr3RYpHqqU0Z4WtUq3Eim576ph
	aSEX63mTc3xL8+HRu7ZOBgvvOuUpytJD2+MBvarF9eni2rGa/jx9SjWZFUsZjpVS
	tAYBUmfx10Gc0L17PHvmV8oV4O6uCWoXEGnOR0IQH4smY+xnop+vwh+phj6/DkM9
	/nEl3McK6Lx/GJhTA+7ScHgAHZ1GHNTJL5RtqiNhn8usv0A86fnPDcFiBOlC9pDD
	aNt6WMkgDm59nl4WJX1o1P9zi+nDAwtPEQUeGvQYXtbnLxW5FMzs95IT+vUz7n6u
	2nkbgUZfBfwuJ6EZn9EGBh2fVZ8UzdRUJVE1d7j+cw==
X-ME-Sender: <xms:7UjtZa2OqFI0wB9QshWnUwT39R8JO7CtS7c61R9KbyyfwmJ5zNoiNQ>
    <xme:7UjtZdFJZnfvc76zGbVR27MkvYJBlKc19iFmvpXu3l7ay1N9rWolSmxWJOpmpbxGn
    ORnzsh4_iFKuJYHFsY>
X-ME-Received: <xmr:7UjtZS6M6_55BlhxZkccmjG-xmVZQZrkUXq5y3IE1BH8NW5EXazb6MXRBNgN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieekgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:7kjtZb1vh40dBGhe6f74uZgUaS9M-2EU56oxZdggi3eyfW0Omu530Q>
    <xmx:7kjtZdEljhWgt_l94U7k-x_Xh6CenvW75Ia3lgWLrrjNZic08qK4yw>
    <xmx:7kjtZU98En-6Uu6Q7eDiSpA6Fl9eIWKZdFMxWNwL4wzXFL7NVoyUww>
    <xmx:7kjtZRikDb-FLSyfuSqAe7swGpfU19j2Bt8XGVR7M7Qr2JrQQM6PXJRAZuo>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Mar 2024 00:45:15 -0500 (EST)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v1 0/1] asus-wmi: add support for Vivobook GPU MUX
Date: Sun, 10 Mar 2024 18:45:07 +1300
Message-ID: <20240310054508.8528-1-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
-v1
  - Add missing define for new WMI method

Luke D. Jones (1):
  platform/x86: asus-wmi: add support for Vivobook GPU MUX

 drivers/platform/x86/asus-wmi.c            | 18 +++++++++++++-----
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.44.0


