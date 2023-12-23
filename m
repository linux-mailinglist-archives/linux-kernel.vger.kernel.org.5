Return-Path: <linux-kernel+bounces-10595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580FC81D6BF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 23:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FEF1C217C6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 22:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65611D55E;
	Sat, 23 Dec 2023 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="SMOMG5yQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DF617992;
	Sat, 23 Dec 2023 22:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WQqgGTEwuLhlIxmsY9OCm79lCP4c8fjqeivswo07Uss=; b=SMOMG5yQw5LmvcVevj3y9hKNjd
	3ubyOctZi6yzf1g4UMsO9JkOV1rru8GDfB7jk+W0WHvXM5aKY9weUet+C5hGsoNpempy7wOSrk7nn
	/jbPQzpTwlqjf9TKn9xxJYXLCXitBEvFb2Lc9ukh2UyCC0RHzjPMPPdxjWwwh4Fv36gjuPEGoUbuh
	2U9S1XED1glSbQZxsQBWPI0SbDLk6mByt4VPvSxa652w1o4lNvIeFjlA0TB/Xkbul+cfVRwKpNo4W
	+EEP3utuEdhOUzbCLmsu+UmnElaV0Fs5Rava1qVdq/bNAFFyULHqQZ2+s/AsFrWcgea1QhPUzrH8q
	JdiAwywQ==;
Received: from p200301077700c3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:c300:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rHAEJ-007f7W-3c; Sat, 23 Dec 2023 23:12:23 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rHAEI-003Fa2-0E;
	Sat, 23 Dec 2023 23:12:22 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	rydberg@bitmath.org,
	andreas@kemnade.info,
	linus.walleij@linaro.org,
	Jonathan.Cameron@huawei.com,
	u.kleine-koenig@pengutronix.de,
	heiko@sntech.de,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/4] Input: zforce_ts: standard properties
Date: Sat, 23 Dec 2023 23:12:09 +0100
Message-Id: <20231223221213.774868-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accept standard touchscreen properties to also enable specification
of touchscreen orientation.

Changes in V3:
- adding R-bys, no change in code

Changes in V2:
- correct mail address in .yaml

Andreas Kemnade (4):
  dt-bindings: touchscreen: convert neonode,zforce to json-schema
  dt-bindings: touchscreen: neonode,zforce: Use standard properties
  Input: zforce_ts: Accept standard touchscreen properties
  ARM: dts: imx6sl-tolino-shine2hd: fix touchscreen rotation

 .../input/touchscreen/neonode,zforce.yaml     | 72 +++++++++++++++++++
 .../bindings/input/touchscreen/zforce_ts.txt  | 34 ---------
 .../dts/nxp/imx/imx6sl-tolino-shine2hd.dts    |  6 +-
 drivers/input/touchscreen/zforce_ts.c         | 36 +++++-----
 4 files changed, 94 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt

-- 
2.39.2


