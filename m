Return-Path: <linux-kernel+bounces-146533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663BA8A66A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AFD1C20E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16A784D3D;
	Tue, 16 Apr 2024 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="ijJKh8pH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BJeB4dSo"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299784A3E;
	Tue, 16 Apr 2024 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258259; cv=none; b=N4NpRxFkaHU0vBneVFEfCc0Yt1h8YllymPZI0o+IZ0kRkuB2Qv5f7/OY4qNOr5+8z7HVdj+bCuTR4kobJB/OkYId1R+WV5OpI81pOHYZUw8PCdRy3NIHaifc/ieWFesn547LUz98jw/Pj4KnyumxfSfmYN+21un07EFSMDm2lRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258259; c=relaxed/simple;
	bh=v1y9dRYHe0svgH7s9/X9lwzKkOs/vH7gNWmkHCijCx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpAttoYURXBzExt7GHYVTqWbM1t7S6iEgRkXVP693pmEZkC97wDD7fuO+DH8y7kbxjIyFFKo6Sy4r05GNWzk7Aw17BkyfYbSZk+BLjEoQVxsizrYraDfmTAdOseZfNQ9JRdsr1tEbXCAdzNNIAkMVgCw5059pIQYAZzlKDeheuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=ijJKh8pH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BJeB4dSo; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id A4F3913800F7;
	Tue, 16 Apr 2024 05:04:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 16 Apr 2024 05:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1713258256; x=1713344656; bh=xmGcjjo1yrDKct9p1g+TS
	wdLOpbMI9QsjQTbhQ3iaTA=; b=ijJKh8pHtIX5AaB0XlBC09kcM/t7fYDewwvUg
	JN4YWnafPNYluduvucibzzpoEI6QGEQEl3NgOjLElVREYqTGSCb008eti+x50ck9
	RKpQa7z3vlPpjJwTXK3Y26Y5JUbeuoUZsbLhZ4qavOEpjXM1XAAWovxWDO1i0W+W
	Mrx8fh7S/2j1khYguo2LQZl/uzgIea455hl7oZEynUsyvFMJZVTJV2LcLG57OCsV
	UWO/7xHrgeE2aYeJsn6NZp0Cp5HaXIhOgaeRDzzOXRjx2k1AQZr7M3Vrvrs0vxEg
	GUe7xvMExvPisDNBr9XSDS57etmbz02bWdV4kTPTVsBtiI55g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713258256; x=1713344656; bh=xmGcjjo1yrDKct9p1g+TSwdLOpbM
	I9QsjQTbhQ3iaTA=; b=BJeB4dSocokIi/9m9g2LzT1Jtd03Z+psdrnIaGuhHd1a
	YPcqaim33/IOW/qIZlYutvh6aCFiQ/DVSo0nrvsiUzznuI0MZ3WQg5ph8ImvToKQ
	1i70MbMbENg+e0/NAfTRZYcLW5ZWRHpJt+yGFN1o1dJoz2nO5FpOI2QK1Gmp8Gnr
	aIp9BU3SL/WTA0V+OUVxQbBOilADMi1VgEpdmigmOFSlKtwEMu/sXdmwfIcTFStf
	CRyVWVfShUEOCgDt/23a7TMtYuWAV3QBwDY3yAmlhvP2mj3mBcmO+IbaZ/Bi0N12
	nojN2oYNnOXkMwU6Rf5++Kryj14mUB8Q+0nc3Z+CjQ==
X-ME-Sender: <xms:ED8eZt8UITKh9xWNG5w9VrIQ2WHodkYKEN7coDzw23R5HnQP91_xEQ>
    <xme:ED8eZhtZYPgtaB1JsT3-YFFwX52w8G2geb9hv17kcdxABbCos0p2T_S4wPFjHleWe
    w505AfnS-mmkTZwV0U>
X-ME-Received: <xmr:ED8eZrCKWNexPLwhXoocn28TcUMQ8X4MgTthnkxFDys11kEyLhZvg0TXHORr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:ED8eZheZcPx4ptb-kewoaOBqhtkFehW1-PKwT8NL-ybAJcUXi3i3Pw>
    <xmx:ED8eZiOd8_RGQm8NlZ2y5DDLV9n0_A9POX9BqcLn2jv6KVDtaEIJzg>
    <xmx:ED8eZjn2EeL6ZO3taWAbJ94Bc6IdqTpT68hDhiwOWvIVCYP4JXsi3Q>
    <xmx:ED8eZsudBkI2cOZiGg_53NOvE0kDgV4CBAzolcFbUocx9atODo-Xxw>
    <xmx:ED8eZvr6I9cnxdrTSmaJ_gNG97v5cedOjcQ1GD1TLGfEM_agluaNL_Cq>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Apr 2024 05:04:13 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 0/4] HID: Asus
Date: Tue, 16 Apr 2024 21:03:58 +1200
Message-ID: <20240416090402.31057-1-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a small series of patches that does some cleanup and also adds some
initialisation support for the ROG Ally and the ROG X13 devices. The series is
a partial prep fro a *much* larger 2k line patch adding full feature support
for the ROG Ally - this patch isn't included as I don't want to hold up this
small series during review.

Luke D. Jones (4):
  HID: asus: fix more n-key report descriptors if n-key quirked
  HID: asus: make asus_kbd_init() generic, remove rog_nkey_led_init()
  HID: asus: add ROG Ally N-Key ID and keycodes
  HID: asus: add ROG Z13 lightbar

 drivers/hid/hid-asus.c | 132 ++++++++++++++++-------------------------
 drivers/hid/hid-ids.h  |   2 +
 2 files changed, 54 insertions(+), 80 deletions(-)

-- 
2.44.0


