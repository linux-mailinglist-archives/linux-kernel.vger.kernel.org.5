Return-Path: <linux-kernel+bounces-161296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD088B4A5C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205C81C20D1D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2B65026A;
	Sun, 28 Apr 2024 07:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="iZBE7t/v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Arzk1BJj"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175464F889
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 07:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714288435; cv=none; b=mJS0AsUGoDHjS5xYG32bdBRc9ueCKkYaM1LZVnz+VcCk7d1XEpKxLbXBgeG2a6ZENovq4063Zkv8Cr5Xvgp8jxrXuV6FYe36pIfF2l7x9g2FZFI0hdzrHpQ+oQ7i4+XIszvBhIH6MOuWsuMOU5ja/EPN+cX8ZHjrdb5oMv5L6E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714288435; c=relaxed/simple;
	bh=zyQaPcFnCFxP5JA0dX1mIbA1AFWwAOuBdTMIvUywo8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+guJ3aXrV5riUKJOyT3UZrA1EOY3IY/rszR4jWtYnq02+VsxWnoOTRupELCusH4NIQ69squGl86reI14rXVsE03XioNZnzYb4teKFx8gckrRYn2HpXEfUEMOM1fZpAIqN7wvNgOyvCAoihyLZl5/rdYC0lLA875HvSu+89wuOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=iZBE7t/v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Arzk1BJj; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 00F441C0010E;
	Sun, 28 Apr 2024 03:13:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 28 Apr 2024 03:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1714288431; x=1714374831; bh=KDmNy1AVOz
	mB9RMGBkgjMaqD0qRXGqGIyc3NwAF6bY8=; b=iZBE7t/veACqUYIZXmHq2/Kw9v
	817wcnRjHcUqdrRHfF3zZ4Vu+DARQpPTzwt2L4IT/I51+hbI0sk5Gsf6okI8IeHM
	P9slcgucOn1hB3KpzhtwUfMzwhlpcRGFPQfeN/GWsF0W+dhtTHiJE5qh8QaoNA0O
	9VhtxBtfLtBv2pxqq2sDXanYbjVVqXoyDkImbGBnCBFVELI/xgZDsAxnzJ8xmA4q
	h9ZWiq3h31u0oOlAli8lAMKPRwpli+af5vZMbhWUtdQrAOKll7wwUcIqPL19/A+s
	Wpu8E8G9EoYqdkquGOS1V+UkGnd066zN8XFa+FYahUHCz7ci8YE+Mh6V79Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714288431; x=1714374831; bh=KDmNy1AVOzmB9RMGBkgjMaqD0qRX
	GqGIyc3NwAF6bY8=; b=Arzk1BJj5F89lDd80+be6Imx6Fu872tbOrCYk9tpTrS1
	NioyYQ11YQdzU1645a0ow5zUomW98/uqZWBHpIuuypjq43SM+opocw95fIUQPurV
	AktMB8aSTiO63NYPKDeGYZIYOSpuahDNyEwjN68RWjAPrWrRRYdlpbPlKdQ7tkGY
	NdLQSemzAj0NJ2rHT5EM5gIePlxA7LVX70wMAb9iniRXOHWpON52sOPndsnn/arJ
	H1pAiWJ9hvJGwsKXjZANQTsvT30iI7TTZ/R8X3oRMInx6bJdv3MsbqRDAo4/0HVe
	tfpGvG91Y/bkSt0SNCuSPa2ygORJ+aTv43f6Lh8jHg==
X-ME-Sender: <xms:L_ctZijb6f1mVvklX7VgJq6us49UXy7Dcf7W0PuPskSzRGOvYY2EDQ>
    <xme:L_ctZjBcTjhmXqHiW-FOOKnKFKLYj5Ok7BBEPP4kD_ixJZ2PU2hq5mdlnq-FrlpkB
    _bxW0vbpixo_zZjmUs>
X-ME-Received: <xmr:L_ctZqG40PNJJZdrZw_0jpSqFN7aVJQZ-jkshGZlKkHQHnmVnUlQCqIH7yX07D8Iw1e8xyNRaQqxdQanTkKwlXzeiPzYy2yrx7dYiTAyLhSqTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffve
    ekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:L_ctZrSuDm3RTJ1w3cp8mKyuOds-xojXn3xVUTVvWNJ0ngFM3lmp9w>
    <xmx:L_ctZvzeaQIWsXmLcy1sE7KnlwHmoURGm4aYYFC6XTQHMSPeTgKu_Q>
    <xmx:L_ctZp71oL4Ml7C2uceDQ3LIYBYdHYbemqc3FkqcKRnDlg21xKPbJQ>
    <xmx:L_ctZswZeqs7R_i_UMFMVMeQJCVwJF0nHEFMPX0P9XIbcve6r2HOcA>
    <xmx:L_ctZq9PW4x14P39ENl3zRe1lNWmmJv8RcgVWuq018zAbIl2Q1ZyJ8aB>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Apr 2024 03:13:50 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] firewire: core/ohci: add inline helper functions to serialize/deserialize header of asynchronous packet
Date: Sun, 28 Apr 2024 16:13:38 +0900
Message-ID: <20240428071347.409202-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Between core and 1394 ohci driver modules, the data of 'struct
fw_packet' is utilized to deliver data of asynchronous packet.
Especially, its 'header' array member is for the parameters of packet.
However, the serialization/deserialization are done by local hard-coded
macro in each module. It is inconvenient.

This series of changes adds some inline helper functions to replace
them. A KUnit test is also added to check them.

Takashi Sakamoto (8):
  firewire: core: add common inline functions to serialize/deserialize
    asynchronous packet header
  firewire: core: replace local macros with common inline functions for
    asynchronous packet header
  firewire: ohci: replace local macros with common inline functions for
    asynchronous packet header
  firewire: ohci: replace hard-coded values with inline functions for
    asynchronous packet header
  firewire: ohci: replace hard-coded values with common macros
  firewire: core: obsolete tcode check macros with inline functions
  firewire: core: add common macro to serialize/deserialize isochronous
    packet header
  firewire: core: replace local macros with common inline functions for
    isochronous packet header

 drivers/firewire/.kunitconfig                |   1 +
 drivers/firewire/Kconfig                     |  16 +
 drivers/firewire/Makefile                    |   3 +
 drivers/firewire/core-transaction.c          | 152 ++---
 drivers/firewire/core.h                      |  21 +-
 drivers/firewire/ohci.c                      |  78 +--
 drivers/firewire/packet-header-definitions.h | 234 ++++++++
 drivers/firewire/packet-serdes-test.c        | 582 +++++++++++++++++++
 8 files changed, 952 insertions(+), 135 deletions(-)
 create mode 100644 drivers/firewire/packet-header-definitions.h
 create mode 100644 drivers/firewire/packet-serdes-test.c

-- 
2.43.0


