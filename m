Return-Path: <linux-kernel+bounces-98129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F42877578
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00011F22313
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB771427B;
	Sun, 10 Mar 2024 05:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="TYTSvajk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZBHDVqMB"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9256F11187;
	Sun, 10 Mar 2024 05:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710050006; cv=none; b=bdRg5U+XqeO+S4CiaZD6o3moXhjuu1/wkunkup1MedU8YeP6qXwG1YqsIMAAi1Nc3niNfVvFJnRXLstuzpfPSkt5k3QdZ40suCBjTW+n62lytg+BkHDYRE0Ml8zOwf65Jodsd6B4YviUNx5aFylJpK7OIGhU6xU8MX5RSYBKcN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710050006; c=relaxed/simple;
	bh=2wOh83HnBhx1otKc16AoVrX9HuNjsfoUVAuZ5jtZxRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=keaQZUX+l9kvipyhbGmj1/uPpF/aLqEswzNNzN/6K51EGAJrA+9MK0Bhnjb8yKOzg5tfH3INF4VmJl4nCwbMmPEYPiVREHGhvMFNCaYms6qpfS2z3MYgLg+ff3lqr6aPpA90lSN+CTf373JpSoc0QnAaPCrm2HylqYGk8u0nfB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=TYTSvajk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZBHDVqMB; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 086FA1800075;
	Sun, 10 Mar 2024 00:53:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 10 Mar 2024 00:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1710050002; x=1710136402; bh=gmryNO6e4mNG5DUbmtbWL
	rETime890uOx6ZmnWDhp/k=; b=TYTSvajk/tDsFTsppQJLGHnQFjTRVxnOvp9M2
	EaIhXapzaeMG+brJsEHRKq1uyZLdgvtFgAu8T4n7k5KH+xCDawFiut2YS5GneEfh
	UTgAo6TjMj4yczykq0yOJ7ONnzDUIaHic2WrpdhoPR+oQA1no7ucAkmJXO+xq+/M
	UmQoSZBJ5fFCiVtgUopkPRJxUAY0iFfCedsrjY8/newkRzZ/I7fVJNLnVS2qosDF
	8d6zokxczzG/CxKVP2t2cVLAYeOPVRbA8uFjTvdwOHrYN9is096f24HQNmMd461P
	hcV30q5Lnhcye2kH5caD6Y9DTYU8zC1seTrzUUtFY8uif630g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710050002; x=1710136402; bh=gmryNO6e4mNG5DUbmtbWLrETime8
	90uOx6ZmnWDhp/k=; b=ZBHDVqMBq8+TgmDTqw96PXXgs7FkuWIKwwJPOVPyfZza
	Hwnc6dtkHHQrY5ecbxgH+h9qdaOAncvJUii98Z/TPfsNwGghIe5tmqVv2KXTOQme
	WqvTPpe7nxG2ow8nsGSDCr3Wdbu0v2DykUtoD3gXQIUs04ilLc2ODJKHlox1xQm5
	Yub86nEl5YiCwRxH7SmPh6PsA2TSTTuEKl032Um+8yrZcXV79ukyfStmM1whwgoH
	06FQhkUDj+ANk84jZN98tgZ6qG78GzHHyrXTDtwof5hn8gdrwG/xhpxus+jAd+sc
	gR7obpZyzDB4/0CDep3l2VU9aleu05GHhL7qWfiUuQ==
X-ME-Sender: <xms:0krtZbogWvsu35z7Sd1J_xAKfR9cOsYJOSOOpJ2jl7ThFWWtqPinjQ>
    <xme:0krtZVonNb5Z003Gx0bTyelRRPiK-ITB3zujhJTLBPeb35atkr5UDeIffqaZNj_-a
    grvJZaxHl66C2QTmek>
X-ME-Received: <xmr:0krtZYP1VAgA1XsHFgg-JF0GwNyCz5xq_OR2TbVzlCn13BvJUK14TqZzaYQh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieekgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:0krtZe6mZxRqsZtCfj__TLczaVT2WEbBk20LZd6v6N3KQZekK6hrXw>
    <xmx:0krtZa6rx1M85-oIAXEVKQF5dA4Q0lBWu2u2_rpLO-2Kt5-aXl0SxQ>
    <xmx:0krtZWgJkbnRtSfLNntND1fzlsUFzaFlECBAP8MDjxi-MGKvxZL01A>
    <xmx:0krtZV3dZ9QD1_4XLM5LjrGdt19pz7Kphql0aErL1S2DXgs5AYz6CtYW4-s>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Mar 2024 00:53:19 -0500 (EST)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 0/1] asus-wmi: add support for Vivobook GPU MUX
Date: Sun, 10 Mar 2024 18:53:11 +1300
Message-ID: <20240310055312.11293-1-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note to self to not try catching up on things while sick.

Changelog:
-v1
  - Add missing define for new WMI method
-v2
  - Actually add the right one

Luke D. Jones (1):
  platform/x86: asus-wmi: add support for Vivobook GPU MUX

 drivers/platform/x86/asus-wmi.c            | 18 +++++++++++++-----
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.44.0


