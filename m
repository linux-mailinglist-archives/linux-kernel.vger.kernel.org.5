Return-Path: <linux-kernel+bounces-19063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EC1826764
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F79B211F5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 03:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239A711716;
	Mon,  8 Jan 2024 03:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="UjkVLkHE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DJIoHkmX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA6910799
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id DBBD03201200;
	Sun,  7 Jan 2024 22:22:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 07 Jan 2024 22:22:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1704684158; x=1704770558; bh=onmYDi2bgJAbWwtqW9n0m
	nXFLqOYwMLqr9H57OBtotE=; b=UjkVLkHEIcp+8C8yW+2P/o107DYOuV6263TUD
	yFZDEl2wUd2g8eZp2Er+7JwdLENyXqKoqs/3b7zLOZ0Bxo4ZI2mumMpYxXi5fCYl
	NyfnUyAxd7VuM8YL3H4uTX37EF2qg5AuzKZbKY9U5zTSXRlwVlygJXj1RkWYS7K8
	pchN/NAb1PpMeQt4VoyvfPzLnJgmOiMK0EwPHIcP76xEu0QhqrRjVwSBaaKbNt9E
	aZuWCS2GWLKyo8C4fLQWrfYZMTRCX/VUhBSQP0Z9sfi2zAttH3boqPWqfLXwcgyC
	IgQYekK61Aa/n3oy3uQieDHrsdLqV32aHMjs7wKFn/Ox00/aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704684158; x=1704770558; bh=onmYDi2bgJAbWwtqW9n0mnXFLqOY
	wMLqr9H57OBtotE=; b=DJIoHkmX/wkmIkvbmvXJReLJ6anRqGB4AVs0OdVrLKOf
	gjOy6LTWOnZAaR/M6s346AVm9r1CYgvGg0gCBICiNACeey9ggEQX/pzx5B4r+Gvl
	Jux7mTpdqxhY7Un1PRl2BbyhnonYeOj/yW1wEU5aP2Ptkc5dxU161Tqiv7IXYgtD
	k34gx8vHtFSMOVt9Q7N/1TpFUq0nlZ8ukHo3GFC2hlvhhmU5GXgIvTRK39jCN+Q/
	Acb7tlhkArdK63tSSukmjMzWNqhLnYpQ8BwGcNg63UNOhpjd7WyFiake19ADIMuT
	Xn+DsGsHA6mttoE70dXl4yCh60Q/OpW4bknt+QAH9A==
X-ME-Sender: <xms:fmqbZb9cF2QlTbiH7lGvYcx-Lw9bXcSrdUohiYQWy1x3cd1hV4bxhg>
    <xme:fmqbZXszUAX_FYFRlkqFbqi6FgsDJUQlnNs7erwdYzO7qQptEdOd8ex3oh12kBNTj
    -QW8Cd8aneLSspoavU>
X-ME-Received: <xmr:fmqbZZDFKmjSSiiW6i4p7cQQKLv76AQPw99qCyHXJ_tfvBZyUaTpOnfci3TkDke1DDC-ZeihOp8rDn_v5BnfUzcu_iOjGdIa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehhedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgrrhgu
    sehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepleegffffgfehhfejge
    ejheeivdfgleefheeuueetkedtffeihfevlefhgeevvdevnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfhgrsh
    htmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:fmqbZXfqWA36ojZ8uXz2birusTQ89Zaxx93VNKoVBTNv8LFWQ-uBtg>
    <xmx:fmqbZQODeiXsHr17V9SRP_JiYOQJm9zIUEdIBmZ0uqCk1zNmKes9lw>
    <xmx:fmqbZZkWiehbXZjoKU0zqEVhRK7wrp7QFdUt6ulpW3rmTYOsR3mbYg>
    <xmx:fmqbZVpWek8-eCig96LZCZLDIFJFbmAgOJtl9DtwcK_nlbQq4HFfSw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Jan 2024 22:22:37 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 0/5] staging: rtl8192e: renamed variable is40MHz and 4 other
Date: Sun,  7 Jan 2024 22:22:28 -0500
Message-ID: <20240108032233.4280-1-garyrookard@fastmail.org>
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

Patch 1/5) rename variable is40MHz
Patch 2/5) rename variable isShortGI
Patch 3/5) rename variable retValue
Patch 4/5) rename variable EWC11NHTCap
Patch 5/5) rename variable AdvCoding

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>

Gary Rookard (5):
  staging: rtl8192e: rename variable is40MHz
  staging: rtl8192e: rename variable isShortGI
  staging: rtl8192e: rename variable retValue
  staging: rtl8192e: rename variable EWC11NHTCap
  staging: rtl8192e: rename variable AdvCoding

 drivers/staging/rtl8192e/rtl819x_HT.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 58 +++++++++++------------
 2 files changed, 30 insertions(+), 30 deletions(-)

-- 
2.43.0


