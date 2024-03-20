Return-Path: <linux-kernel+bounces-108304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CBC8808EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A721C229D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF427464;
	Wed, 20 Mar 2024 01:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="X8elGtQR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qn5Jqo/q"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718361364;
	Wed, 20 Mar 2024 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710897295; cv=none; b=Fq5eVJ/X0xgoPQxX3DSNSuyWUfT2l9Km9cigPPY3DWhzZukj61kQvSV6jMWX/ZUyoOffpLq0CfkhjEgQ+ja3SKusQPhC5jmVn/96gEiO0CozhbML1A57KejJM8vG3VrJYyWQtlcmUX0dLdsEiQPKi9lbYObL45lKv36IqSiee9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710897295; c=relaxed/simple;
	bh=NVFUlNqRxq1Uus2ToltgLB2wNffN6AHcUTXHyp1UtgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k7CRtTVTaR/MWgKp1cuFMzUIRMz1VJafsj4cIFqoVpRvuVPODnhi22ablOrAPyfsdIVeshDEItRYO608Lq7JPDDfIou8jmHmwgg7lrDRACOwmLv/WFe1xnyq72zQAru/ubLoLCxNdN7qTTfp45LvFhtxJ2wsZfce216kjjbDSDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=X8elGtQR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qn5Jqo/q; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 62FDA13800A2;
	Tue, 19 Mar 2024 21:14:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 19 Mar 2024 21:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1710897292; x=1710983692; bh=CD1CUvEtWJnkCx6sbY5X9
	0fBM75VSF+YhIznuPipNn0=; b=X8elGtQRNAYIY15GAmrk0HIZYBeQMgMfUyfeK
	MLb8t9cFMKLIdK+o2vAv+EdnMPiKvSE2u2C6PE+aUgn6TnE1sTiATkJ8T2U0Rl77
	+eFTvwzchtAIr6oAx8gesex+KI1b/sFXOa7v+GmqSOz1GjdD0H+/E4RvcYvfgfvc
	wC9CdJV0AQL4DARBBLGa3gqoUbwe7vVlC9puFMzIPXMrKzF4Io+UuzeC5HCo5ERz
	bLpwQF293qCoSfkQ8ND7wRfdPpk2sq+8543mATIQfTo1OEQ4uMpmMYIE9kjhWpD+
	DpEXHP0wcn1JWVbpGnBLRRJCFsDiEXQ93oixr/sbSts/vWWSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710897292; x=1710983692; bh=CD1CUvEtWJnkCx6sbY5X90fBM75V
	SF+YhIznuPipNn0=; b=qn5Jqo/qwUCKj67YcALIAIwt0nHyOKwxwNOL+99pHT/D
	h/eRO5B4aodaXlAvJhC+CGOW7Z901+IQs2bHizL9Yt1DaYM02lTGUzZws4HEFhZs
	BCIcYv11iE0TZWTvFZCJxaWsYDWW/8qAOb/8s8mv6Qk46op0lRWXVHtQTvIrZdcX
	1zG9dt3NW9l+KwB4LqkvDqKQJCbrfsskmUb8OuCCkm5GXD22K4Q9aoZ483r86uVm
	4TTAXwarqmpsg8hxZE4SUUKE6gN3FPB0kQpFcV+FGAXiEJQq637Ew0AOkPD9/FjX
	N9dy350AiGWGsHkLeNaw6yC4TAnaZaGRpIvRe5ftSA==
X-ME-Sender: <xms:jDj6ZZxPh1ae0efRlcGhz4wgr_3kd-aaPxhhVfCvM0frrMnjO8ibFg>
    <xme:jDj6ZZQp6Vxhs1hFdvzQpW1e6QsntAZVp6jYuszCwFQWOBGba2YCxYfoo4qZ2lfKH
    fGJcu3bpToewyDCuEw>
X-ME-Received: <xmr:jDj6ZTUEcq6oZngEJZpCKwM22vbYXkFGv1-7fWCnQn1tvnGCIGiEgkPyVetO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledvgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:jDj6ZbjUEtJYJkjpprpdCV9posgeu6zNZ19T3wK8AOijiTtEpg37Tg>
    <xmx:jDj6ZbCmBUMSb62gxUgd_fI32Fu0ULqgYXNBlpcua6kXxuQK-vXrGA>
    <xmx:jDj6ZUK1UGhiY62DyxqvlonpZ3HT5wTU--i9mBgNYkXU4T8GWppfqQ>
    <xmx:jDj6ZaAKrLSfDTDMlPL8lXJ1ffF60LSzFcuEtG7c6ANa-HSSz1_b1Q>
    <xmx:jDj6Zd3TF0UKWE0sgn2xogjQPEqlM-kRbSCTNeU9oyUwgZaT-xggcw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 21:14:49 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 0/1] asus-wmi: add support variant of TUF RGB
Date: Wed, 20 Mar 2024 14:14:41 +1300
Message-ID: <20240320011442.11608-1-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
- v2
  - remove unrequired kbd_rgb_mode_available check
-v1
  - add missing define for WMI method

Luke D. Jones (1):
  platform/x86: asus-wmi: add support variant of TUF RGB

 drivers/platform/x86/asus-wmi.c            | 13 +++++++++++--
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.44.0


