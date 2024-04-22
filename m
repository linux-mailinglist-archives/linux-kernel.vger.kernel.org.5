Return-Path: <linux-kernel+bounces-153722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B2D8AD234
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E661C20AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011AB154440;
	Mon, 22 Apr 2024 16:39:59 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC741474BA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803998; cv=none; b=DsVDUGDJJFZBRb7fHdGjA83a2cA5+KbhHeImi/UrG5l6/NG4KlUH9LWb8C7Yydbx0TYcTDCwy++GhW8EAap46j8IsHQMK1Z3SNRVq8Lm6BztNGev455/TqqkTQ43m0eQ81uAc05m0JbDOXpyWx0Cd/eCMlHzCYH5xg5RZKgK88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803998; c=relaxed/simple;
	bh=rlKTHKhLg8XjAcbkOtbufJQCunukFqHg3zqgJ96Gtyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O7IVjBVpezZQHvvpjQGjjEsHFDCGMDCBleQvsGSShM6FqyjBgappoHQTY0mYlHlfTfCE+ZHRlZQnXx00VfztoWCQ29qlV2iEAICqJzkbXq8Y1hAb6/O9Wyk1LRCT/UAHSuEG/zS7j1s0QcXbJkZP/fj+rYp49ar3g6sdNRqBx8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d85.versanet.de ([94.134.29.133] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rywht-0004gq-0r; Mon, 22 Apr 2024 18:39:53 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@theobroma-systems.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add support for the dual-role dwc3 controllers on rk3588-tiger
Date: Mon, 22 Apr 2024 18:39:48 +0200
Message-Id: <20240422163951.2604273-1-heiko@sntech.de>
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

changes in v2:
- split out extcon addition into separate patch
- fix comments in patch1 to cover all affected controllers

Heiko Stuebner (3):
  arm64: dts: rockchip: fix comment for upper usb3 port
  arm64: dts: rockchip: add usb-id extcon on rk3588 tiger
  arm64: dts: rockchip: add dual-role usb3 hosts to rk3588 Tiger-Haikou

 .../boot/dts/rockchip/rk3588-tiger-haikou.dts | 64 ++++++++++++++++++-
 .../arm64/boot/dts/rockchip/rk3588-tiger.dtsi | 15 +++++
 2 files changed, 76 insertions(+), 3 deletions(-)

-- 
2.39.2


