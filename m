Return-Path: <linux-kernel+bounces-69747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291CF858E04
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89DA2819DB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8097E1DFF3;
	Sat, 17 Feb 2024 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="hKR3/Yhk"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E631D526;
	Sat, 17 Feb 2024 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708158049; cv=none; b=VAqPtnYtCZOL5XR9wonNXp6u0Eq5mDPh+Y4NYnCcKOVcl/uehFdqucLs16myrIDvmpF5kZUYdSh+6/zEyoWBvnBigGO1QAicN2jIGb0fTUDe6fnZ0chorEKH5crYYA7IuZMBPWK7UjVwYRr7kY1XTYwYtlnWf1FFp8f/1GURrCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708158049; c=relaxed/simple;
	bh=78DJpSgRADSQ8xQ51c9xtgYjH6BRPB5WjDqxTZCNphY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=JoZlMenoTgWYwz6pb5WKyNLkGGtmPy0R4VDgK67nNI+zBq/CxMRH4l7HLQEvOVGb51wDOcEuG4fvbo4JQtkBPszNa8k1G4Z+fOBC5bh52T8cT+LIKvvOXyUyQsPbRl851njJwcv+lTrPqBNj6oWDw1Z2RyKhhYrQ4X+VrAutzeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=hKR3/Yhk; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0H8yS7B9ijf/Bav3Ome14xQsniFW8pPuUVlXJhECckA=; b=hKR3/YhkMhJeF4jgVsEzADhqba
	/ODX3nXaqmPdPftLmbKNy6ic/PS6oDqjxV0B3p0m9ixDBHbfDtseK77Xk3rovxVqo6kaiS6Lm8MU5
	DH8BQ2BqRF3hX3ilbM3pk+3bJBk+gWXMh2sNt5gde9c65zkRueqHk4Uc//fvio7MBy/L3ys1Lt+Zo
	KC8SmV3yUB8l7+3pYRK0dpftLXjs0gTi7NIxQqWf8N64igdju18WyV8AkpoB2ofo7wp4ph8jt66EM
	YOl4IXyqLRdsSaIPxeaSPOx6QNio7FpAQKZBoOYjlBJ19QU7k8F7xcckL1uq9TUbSo+iheHgvG3kJ
	4ejKNJ3Q==;
Received: from p2003010777002c001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:2c00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rbFvz-009WA0-GB; Sat, 17 Feb 2024 09:20:31 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rbFvy-00DabZ-0p;
	Sat, 17 Feb 2024 09:20:30 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	bcousson@baylibre.com,
	tony@atomide.com,
	andreas@kemnade.info,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH v4 0/5] mfd: twl: system-power-controller
Date: Sat, 17 Feb 2024 09:20:02 +0100
Message-Id: <20240217082007.3238948-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add system-power-controller property in the bindings and
the corresponding implementation and use it where
appropriate.
Not all cases are hit yet, there has probably to be a
separate series after going through with a brush.

Changes in v4:
- fix spelling/grammar
- drop twl4030 dts cleanup, it would need an IB
  or be postponed till next release 

Changes in v3:
- twl-core: 
   - remove repetitive verbose error messages
   - placed constants at top part of function
   - minor cleanups

Changes in v2:
- add A-By
- fix compiler warning

Andreas Kemnade (5):
  dt-bindings: mfd: ti,twl: Document system-power-controller
  twl-core: add power off implementation for twl603x
  ARM: dts: omap-embt2ws: system-power-controller for bt200
  ARM: dts: omap4-panda-common: Enable powering off the device
  mfd: twl4030-power: accept standard property for power controller

 .../devicetree/bindings/mfd/ti,twl.yaml       |  2 ++
 .../boot/dts/ti/omap/omap4-epson-embt2ws.dts  |  1 +
 .../boot/dts/ti/omap/omap4-panda-common.dtsi  |  1 +
 drivers/mfd/twl-core.c                        | 28 +++++++++++++++++++
 drivers/mfd/twl4030-power.c                   |  3 ++
 include/linux/mfd/twl.h                       |  1 +
 6 files changed, 36 insertions(+)

-- 
2.39.2


