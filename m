Return-Path: <linux-kernel+bounces-98141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEB6877590
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 07:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAA9282096
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260B38494;
	Sun, 10 Mar 2024 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="hi4BduWw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mMSrdn+n"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC961FA1;
	Sun, 10 Mar 2024 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710053660; cv=none; b=T4p3ugXc9pTnt5dmb+xzpJCtKuQDeYuZnQadG0VDxBXTGAP08PJGoHuymjUvhmTURO9Tm83a0cEDcTsW1T+EHzJOdjml8yerpSCv+pRnXbpCu+JomYnUHGr6bgtdglz3Gq7pi4HbQXeGsKoxmYUhvx6gjiNSBMUHZiKzc2etWug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710053660; c=relaxed/simple;
	bh=OwS8nDeqtGr1rmEfzI+LWLVFUsn8Q8aWRGAPBNbUmws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M4Q1/zZorRjqB2mj9w+tRJIfwb7OPFqJc205jK8ZCi63HkOdMtbBcJWe51PFOI6tXsjxK0AZ8bWzjFm50jS0yRvLLizr9nY1OIVoYZYeJ8eXSUjR9Ne68P1fyLnEqjqfLo+xj63B5IIaj7riqarUm++4CWtmERSP/E8CpzHOGW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=hi4BduWw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mMSrdn+n; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3D23F13800DA;
	Sun, 10 Mar 2024 01:54:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sun, 10 Mar 2024 01:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1710053657; x=1710140057; bh=IIac5zrdA507kcgG5IGDl
	Jei6Vcq0vVvlgbn1RGjh0I=; b=hi4BduWwi2uWqoQy51+UsLfZFFTuHdtRHFYl7
	GUgzMQuCpsDVt8GuJsCUpnKpX6D/0tio0J3HMJzOrcY8JNpfcm2vq758BmVp2gGr
	E6izR/UBrST7XQ553DxNMrn0I295ExgsobU3pYgu5T9MtePMLliaSYjhhbsoZ3I4
	618cp0h01vArT8HUrftEXefy6L0xvAgTUOw+kc2EBJ6JemkNScv1m9n/qQDRKzWY
	OEoao9Vo4SKRfHZ9R9bNtzWXkVvXA3S8v249pNd1NLY2F/wI6yP9Oy42d0u72HR2
	euSrvbfPYNI5iAMh1DmBOZjyqiS54T+XncQh8EG2jymuK3bZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710053657; x=1710140057; bh=IIac5zrdA507kcgG5IGDlJei6Vcq
	0vVvlgbn1RGjh0I=; b=mMSrdn+n8Vzdm6u+hioNBiWrrSgMkZUrRnIavbMoEsmU
	VAZyNgcz+2HfPL+xp73VqtaU/74z+5bC2AvlKumv/unfKBl8qsu0QDG13AdcYayG
	tXVG/2x0Kx4ioPZS22MGDKGrzQEZYdnuVsTeekbDIWERrcRAk6Ri7XPEGVgN1vqM
	GqrUxTnnKEBjCbIM2xC6R6qd6QB/HAJEljxqdvLxkeAptOYiovaddHsDCD2Ew8Mt
	t0eQSX5Wi1DzA/W4dMf3xBakpUg+ev7uu/WcDrQsxKGluv/coQ6b5X9Hd+6jKvUT
	QjJ3EKxDRtHxcGnBkHicPahgs/bFXGseyOnH1ukfdg==
X-ME-Sender: <xms:GFntZaq-UuiYixomWr8YdhJbMU2l3rIUT7yNQMkkpGU3a60prMtYlQ>
    <xme:GFntZYoGNrs4QX7DcqTGA41S-sfb5pl5FlzATlwigA-ffhxPQ-5tB4df5HZsyNQwi
    EfkvsMaSNL7H2tpgxs>
X-ME-Received: <xmr:GFntZfMceerQqL5iZe6sNz2Mf80ZDQXU5SW3TvFMrOjB83q1gkOm2rjpqo9_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieekgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:GFntZZ4Re1QHbELu0Dl10twBFIkCiuNHwsZMqLJlsYzDJP_2e0EOlg>
    <xmx:GFntZZ44JggWmb4X6h-RDikRHP0VA4yfiOOE6kJ4KHrCi8-ezIdY0Q>
    <xmx:GFntZZirsoVz9oLBlp-W4WOmhUwjRyfJfAY_VO2o2ib4s3EHB9EWdg>
    <xmx:GVntZc1p3p1u2EiXnO5pOYplN5orbPDcEmKPSZ-1IHX03IUfsy2F4A>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Mar 2024 01:54:14 -0500 (EST)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v1 0/1] asus-wmi: add support for 2024 ROG Mini-LED
Date: Sun, 10 Mar 2024 19:54:07 +1300
Message-ID: <20240310065408.63703-1-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
- v1
  - Add missing value conversion for new mini-led
  - Catch and ignore a bogus read return if set to "off"

Luke D. Jones (1):
  platform/x86: asus-wmi: add support for 2024 ROG Mini-LED

 .../ABI/testing/sysfs-platform-asus-wmi       |  8 ++++
 drivers/platform/x86/asus-wmi.c               | 48 ++++++++++++++++---
 include/linux/platform_data/x86/asus-wmi.h    |  1 +
 3 files changed, 51 insertions(+), 6 deletions(-)

-- 
2.44.0


