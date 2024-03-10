Return-Path: <linux-kernel+bounces-98131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C694E87757C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02A81C21AB7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6614F125CB;
	Sun, 10 Mar 2024 05:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="dxR34k7Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cOZKlecU"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D76DA29;
	Sun, 10 Mar 2024 05:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710050281; cv=none; b=uDwoiiHH+Lc1A/kpbshVePy1Clyn+aSyM6ZqPX3QaBj+6aLXil7JT34RClmxGVeXi0338Jbf/SKSrBECFOxQg6BiC+R63SWcCRCLhdJVlc6S0uW/ftvhD4gt5/+k+5Q0wAPOWBgP63eF4i2vp3diArUiZGhI/li0s6MDANLa6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710050281; c=relaxed/simple;
	bh=cAsFJJrQGQZgLcVkBFlr3Wp7kEzY3h1MWkrlBNxmMgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RlWXUVONTwUHrZaup+++4RTmBFWDqBXZb9djtVCPzRNTqbtS2tLYCh4NoyT3il8p0GtpabG6QLxXSchI0a+n1TNoCy90BPfIptLrhpWM6dU/6VeNnYzUiso4a74QOxAwZbDc54Z0aHY7AaTR8YSaA+aoh3vXFLF1Ithg2BM8B9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=dxR34k7Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cOZKlecU; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id C046632000E5;
	Sun, 10 Mar 2024 00:57:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 10 Mar 2024 00:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1710050278; x=1710136678; bh=1tc5RQbYz4q2VQJ6rVNSF
	hWp3RWt+mn6/F2SItJvABk=; b=dxR34k7QLdXHBKPAD6eVQ1msL/aPBgls2kphf
	mF8gjSw2oRCi6pg2QjRyxNdlwdCD0eQYUd9oDr6jHhaaRDAwx7Mskg4lcJAeZpaQ
	nBIIbRCXohutJxpKWAuDewrHN8Mgsgn4TE3s91UP5YODWZVoLq/a1XYmTn8EPqrV
	2dyyOJklHjBFmnejDZPWRVB8uK/6mFCnOZh/uSQkLvBnsTf9QFhMNiJiLhzzx6Gq
	ujrgJU2+EyzVDteM/i3/8UFcqFg+hAlG6eJ1V1wsHgLZk21rGXOq/vdw2adlMBiQ
	MK2Ql5rjzHSILCs2ONkGb0wUsh658xv/Gzf0oFFJYEVEGKqag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710050278; x=1710136678; bh=1tc5RQbYz4q2VQJ6rVNSFhWp3RWt
	+mn6/F2SItJvABk=; b=cOZKlecUXWTlvmW7m3BKb6NFntyXOwauAFF0dErnQ4e+
	G4ejLFBik2YEgWHBimRpG/yzJBeXq4YmlLsYkiEofSNO3BGjF9Y82ZVp4Gbl6MwL
	lLkkm6f5RYiouiPRzHEU9q/w51gcU268GvQWeO4SIyJcoyahfkcwlyHqlcwy6CCg
	yQc3cCGS3AF7NMk6/naMfxA+I5gaqeWtbXM+LjLd5qvuer0bYlEfR7ZxqRcPBGjF
	cbVY25g1J8nuIvZMQpDfwpu/A42sppAu00Hh+L3Ij1/oqOaDZdRX+v3aN6YG2178
	wXa1RbyxEt9u3ZJ22ot2OB7bq/S8IIVkxM7GEviknA==
X-ME-Sender: <xms:5kvtZTk6LXxOFpcxUuXNskA9_4fRr6d3e5l0MZp92y2sdlGhCk1Rxg>
    <xme:5kvtZW0cE-TZBPEPpJtR5fAr7p4CMf7unIody4go8feZk43BGWJIm6pKtg1rZG2r2
    Rabres-_n9IcYMYDc8>
X-ME-Received: <xmr:5kvtZZpgifmvdfMKxDSQSBQxB83tU3KTxvAWdU56sOmVrX5sl3S50tL_cc_F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieekgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:5kvtZbnpI4taGD4T6ECUYymIgpr3YBE1IuO4yfAvnFmvp7GUEBAC0g>
    <xmx:5kvtZR1-FqOAO5XlGQkPpfLwd2IYVTnWDZIVJunqLFdWMH2PFyphQA>
    <xmx:5kvtZatchI80jAYOMLYb6ZnbMcCPnfx6Qt8urewagfYWPIySpQ4A9g>
    <xmx:5kvtZayM_TRhgTb6ys-_iz0tIbufJFE_vii7rO856S6sg1JVcGO7Mg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Mar 2024 00:57:55 -0500 (EST)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v1 0/1] asus-wmi: add support variant of TUF RGB
Date: Sun, 10 Mar 2024 18:57:49 +1300
Message-ID: <20240310055750.13160-1-luke@ljones.dev>
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
  - add missing define for WMI method

Luke D. Jones (1):
  platform/x86: asus-wmi: add support variant of TUF RGB

 drivers/platform/x86/asus-wmi.c            | 12 +++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.44.0


