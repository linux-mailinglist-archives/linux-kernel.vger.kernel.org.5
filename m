Return-Path: <linux-kernel+bounces-1805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 640AC81545C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5A41F2567F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160C048CD9;
	Fri, 15 Dec 2023 23:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="tHh8fX+y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mrd/ZQBc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA0B3013E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 171BA5C01B4;
	Fri, 15 Dec 2023 18:11:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 15 Dec 2023 18:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1702681919; x=1702768319; bh=JUtINVqY1e3cJupn+9kUI
	Kovwyk1PAYLXChLhNrV78M=; b=tHh8fX+y90mfh00AhUBf86K2cIJqDnZ5xAPTb
	fzKbBvGFSZzdO2pokMed4cIkStzYSzcmZco4z3mHAEqKZGqoQlpF5NIzhPkqB16+
	PTuPycUBqhLnY8728c/e7mtVdAxcvequHoh9tyh4CdsUvR7LurM4ow9Th4pKPhEc
	Nya2d1rSpXRmEyrHipXp3HwiaMWWuYynbaoPuIVT5yriUrrcCLzz91USGlLIZen2
	xc+f2xflxaKWP3xWAO+S6+U1Cy0h+rZne3KsSaiuX+yKfsXuDjijOt4VjXmj3H1n
	C4CMEkg+tGOdcfXaNUv7zmABcAJeAFbOg14sLxcKrvijApb2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702681919; x=1702768319; bh=JUtINVqY1e3cJupn+9kUIKovwyk1
	PAYLXChLhNrV78M=; b=mrd/ZQBc4mwx3ohXmBFOWd0SuY+oNXw/fs4OmjJm4jUg
	RJqOfKOyPbHYGfP7MuQUmlC1lqQ/32+lwAMowlqql/pWVTckPfY0klM2ftbdemaw
	YKsE9ldMhR5D8qQtuWRZ7y6VEKkTKE2gFo3cu/ffWJcsWa5p7nFEsSrDBxq/bpqe
	nsJTIXHft1RoOb2iIn71jZMIDb9BO34+vChis46YLjGRdjPC7GiEYzBWm+XuL1qO
	togSnCsFbv3h2az/Lew+SSdEqwvtLmkGGP0TfgWkHF60F01WjhNvOKIfqxjosVIq
	G9gtKso3+Zl11WSa6u4nEM3ro8Tt2o9Qhw6aWswb4g==
X-ME-Sender: <xms:Pt18Za7NaOFy8Ns1gvvSQYVS9pifhD7B-WpbC64XJa_LP1cbLO-0Nw>
    <xme:Pt18ZT4DyOrbc0VFXcewPBJ-OTFd5Glb_LSVwPtJ2gmhLZeigN83TWkY3utYbVgjh
    gnUj6VA5iXLtpQL0jk>
X-ME-Received: <xmr:Pt18ZZdtm2KtvawuJE4gsszaib1oKBDX8Va22X6SussH5Njad2LK2q8yHhw5rUKuioDxYcMFDoAMBsHWpF_IFFgCylCfwDQh9yanb0m3fcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtfedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgrrhgu
    sehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepleegffffgfehhfejge
    ejheeivdfgleefheeuueetkedtffeihfevlefhgeevvdevnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfhgrsh
    htmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:Pt18ZXK_ut4kpp7fGw7pd_qNlyHdwUiJsGqnX4hZhwxLKqzqSu4YvQ>
    <xmx:Pt18ZeKz3zKYPrrdssH2PpWByiBAKDBYvyrE7bKIu6BDw0oKMsOgGw>
    <xmx:Pt18ZYw_G_b2H-cQaPXI1OKdDXU9dtYEgxQQS6BXz-zXqkjH4_N1fQ>
    <xmx:P918Za2K366zEz65Kb1WjqS4Y0leIkYE0A6IkX_otGPG6HyKbAb9vQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 18:11:58 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v2 0/4] [Series 4] staging: rtl8192e: rename variable pHT and (3) other
Date: Fri, 15 Dec 2023 18:12:31 -0500
Message-ID: <20231215231235.8265-1-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series renames (4) different variables with
the checkpatch coding style issue, Avoid CamelCase.

(resubmittals)

Patch 1/4) rename variable pHT
Patch 2/4) rename variable pCapELE
Patch 3/4) rename variable HTGetHighestMCSRate
Patch 4/4) rename variable HTFilterMCSRate

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>

Gary Rookard (4):
  staging: rtl8192e: rename variable pHT
  staging: rtl8192e: rename variable pCapELE
  staging: rtl8192e: rename variable HTGetHighestMCSRate
  staging: rtl8192e: rename variable HTFilterMCSRate

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 86 +++++++++++------------
 drivers/staging/rtl8192e/rtllib.h         |  2 +-
 drivers/staging/rtl8192e/rtllib_wx.c      |  2 +-
 3 files changed, 45 insertions(+), 45 deletions(-)

-- 
2.41.0


