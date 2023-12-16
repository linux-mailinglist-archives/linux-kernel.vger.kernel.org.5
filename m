Return-Path: <linux-kernel+bounces-1915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FAC8155C1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C731C234F1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED43111B;
	Sat, 16 Dec 2023 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="c2S1Jf8F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ozwy/yDX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FA210EE
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 52B863200A1F;
	Fri, 15 Dec 2023 20:00:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 15 Dec 2023 20:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1702688441; x=1702774841; bh=JUtINVqY1e3cJupn+9kUI
	Kovwyk1PAYLXChLhNrV78M=; b=c2S1Jf8FOSXSfi0oKoxi0DRnMy9Q9tgw1Ir1O
	knDT3pf3ppWa+0nKQb6js3bhGsZDwLRWvMC3pn4UG/pVxzSk1aHH2Uxism8AwQ5u
	6yAv+3cnIOYLgubJNhkZRaZUqXqU4Np42lMtf7QQVeeAwERx3WOFgn3LVOWFCDVu
	uBJ38uiPB5bX40Rdr1kOxB3DOjoiuDJ6vTPxG0noDHlb38v52YVLGOhXGv0TOwie
	vMLRAlsg6sm0NF4KHPk2qcEC13k8845NQlMw14UCa3Ixzud8GE14j/CZzehbX+/w
	bRH5ToDujwECl0s8/J3CBv6LKit5qUMImY0dXKjFYguCOvy+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702688441; x=1702774841; bh=JUtINVqY1e3cJupn+9kUIKovwyk1
	PAYLXChLhNrV78M=; b=ozwy/yDXDMomc9KAgvHHQx+ApAN4LyQ4NZ66Gl1GcqDo
	PB/n6DWG6qyUqj0IkH0g95+ATaxo9uuXwM7uMiv6VsDodDyaDTVGDhIRweRiGwH4
	ncnoPNzuIOBfPZq0raGFtz0aYboMI0NIzg57S/4R/+xPzhG86GCX9Uq3rG2eYXHt
	9tnawpmnrvEz0DdVGgze2t/Vunlqou1Lp1exsWvdBcp3QLe4ByePzgFoSPjywZUa
	WFpaQD90KwEVYg91T1p90NkTLfUgHW7bNo6/D4C+YIfWF6TB/kDo+1nqXVb3ZmDe
	QXF+J9SB7BktdljjmcnZXzVQFwNF+aJiWwQ5eumrww==
X-ME-Sender: <xms:ufZ8Zbs6YC5A6pYQlj-vJ0G9h_yqZ8A9ZLl80pS4rKBl5wGbVp_wwg>
    <xme:ufZ8ZccfF8rxlQpsBRF8JV93rC5ROx5t-wD6btCaV5TfRZnEBt90Zy1KmOznDo2ZP
    rd0nCdzldYjrSLB7ro>
X-ME-Received: <xmr:ufZ8ZeypOaeUhrqNx80y9l-uUrvnVY9ydk7YllX0fNi_DaSdG4L5-hrycPJnK4IJWmKfi15bXZRIPvdNzWSYzHayNvKdv0JmHt31k2b6FbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtfedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgrrhgu
    sehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepleegffffgfehhfejge
    ejheeivdfgleefheeuueetkedtffeihfevlefhgeevvdevnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfhgrsh
    htmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:ufZ8ZaPNqpRBvhvZ23Cs8hcwDq7e24UxyqdxJE_kSdTISCWoumsnzg>
    <xmx:ufZ8Zb_EAepZmlYnhMYaXgV-XJGE1gmmOvckjhJRj0HXS-9YNL2liQ>
    <xmx:ufZ8ZaX7frzJUjz67CzsQ_0IV0Z7lRpxvVfX3ZG9QiLGxxSNUQ04Xg>
    <xmx:ufZ8ZeZQK-qoDCUIj1KApIqKQHNowSEoTVXNZSdSTW95DoLJT-JaQQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 20:00:41 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v2 0/4] [Series 4] staging: rtl8192e: rename variable pHT and (3) other
Date: Fri, 15 Dec 2023 20:01:01 -0500
Message-ID: <20231216010105.9810-1-garyrookard@fastmail.org>
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


