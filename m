Return-Path: <linux-kernel+bounces-150788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6675B8AA495
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2331B288623
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94C1199E8B;
	Thu, 18 Apr 2024 21:03:42 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E718E199E80
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713474222; cv=none; b=njk42xIT3C0zAV9Yldj6cWCzyXJHzvbiP6EOMYRdusx2eCMmQ91mZGo4HXMn2QAchyjgJLCulVF/FKmn6gMmzwwsqY8R3x7VSeYDHeLRDdiTZ5gZF/gki0k19djNcLdF2RemEP1Zgk+3GnGqSkyhZqKJcAaW7RccCXXny/HkOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713474222; c=relaxed/simple;
	bh=Qym9bt4zejnn5uBXM6Zu5o/ac/7Tt8Dr8PEUXoax4jA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I21LecjIr/MZVvo5sR4/6hoIcyh6JslVM1V+DZe7lPTrYEa9rhmOGLW2IT3U+Tee7Ys+4gAjF5+KD8DQ3kK8k9rDh3UdtnjIweDEDythZTJ7XtiXdwBwW/XtIhluNwL5PXAxxs1BlCE+em7MvFdyt/caeUdsbwVC36svnalfMTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861917.versanet.de ([94.134.25.23] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rxYus-0002jJ-GS; Thu, 18 Apr 2024 23:03:34 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@theobroma-systems.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add support for the dual-role dwc3 controllers on rk3588-tiger
Date: Thu, 18 Apr 2024 23:03:30 +0200
Message-Id: <20240418210332.2394871-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A comment fix and then the addition of the nodes for the dwc3 controllers
using the newly merged usbdp phys.

Heiko Stuebner (2):
  arm64: dts: rockchip: fix comment for upper usb3 port
  arm64: dts: rockchip: add dual-role usb3 hosts to rk3588 Tiger-Haikou

 .../boot/dts/rockchip/rk3588-tiger-haikou.dts | 60 ++++++++++++++++++-
 .../arm64/boot/dts/rockchip/rk3588-tiger.dtsi | 15 +++++
 2 files changed, 74 insertions(+), 1 deletion(-)

-- 
2.39.2


