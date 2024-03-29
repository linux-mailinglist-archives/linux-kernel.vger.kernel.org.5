Return-Path: <linux-kernel+bounces-125057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A92891F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3CA288AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A471422A7;
	Fri, 29 Mar 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rnplus.nl header.i=@rnplus.nl header.b="NNZS4nqI"
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00944219E1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.25.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711718432; cv=none; b=uYtcoOoH1PaG5XFDj35dFuz4GGfHrgMOCTgSnYXblY96GZr4alaHCQI6tUzU4dFnvJJAApbiDf1oLS59zXcsnbbVGfUq+1gSRdGtWcvG74edaQ5XMePLAiHFIInAFoZ6z3ptLi9niFJn9BQCYILnIdE1MH4DGeRV5cNfMTFCaPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711718432; c=relaxed/simple;
	bh=l8mCvlJVZrar8f+bwi8D1Jsz6VsyqIEPsPow82A7rHw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pCI05hELIzOBySZlgx08h39wWqxY7qOE7We16OQRWE/5bNAcOzcwLIR3CSQuSsiD4pDnwnZiT348hQTkZsDZkyMcEO/EosTM4Z/UNCQiUBvoc4NwKxztfTRUYiHaHQ3l2TfGcESdlyNTGHCqB6G2b3HVgwcE3S0jv5vlwODOQZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl; spf=pass smtp.mailfrom=rnplus.nl; dkim=pass (1024-bit key) header.d=rnplus.nl header.i=@rnplus.nl header.b=NNZS4nqI; arc=none smtp.client-ip=178.251.25.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rnplus.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rnplus.nl
Received: from localhost (unknown [127.0.0.1])
	by mail.rnplus.nl (Postfix) with ESMTP id 32E6137947D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:05:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
	by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MXLnyqwwDtZC for <linux-kernel@vger.kernel.org>;
	Fri, 29 Mar 2024 14:05:35 +0100 (CET)
Received: from localhost.localdomain (184-179-179-143.ftth.glasoperator.nl [143.179.179.184])
	by mail.rnplus.nl (Postfix) with ESMTPSA id 4D0C3379192;
	Fri, 29 Mar 2024 14:05:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
	t=1711717524; bh=l8mCvlJVZrar8f+bwi8D1Jsz6VsyqIEPsPow82A7rHw=;
	h=From:To:Subject:Date;
	b=NNZS4nqIzaD2hCfu8CA8gTwt99O9g00IswvSMQLre+7+i4h5LYupSeCU5p93fzP9W
	 WWdY1u+D30lLuArKURoztIIMP+dcvzvAhLCU0JWLysSGgcMTByFbyZW5NwCVPc/13J
	 n6hTZvPbIcEEEv2vvnV64ld5LtvO5LTdvL65Alv8=
From: Renze Nicolai <renze@rnplus.nl>
To: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	arnd@arndb.de,
	olof@lixom.net,
	soc@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	joel@jms.id.au,
	andrew@aj.id.au,
	renze@rnplus.nl
Subject: [PATCH 0/3] ARM: dts: Update devicetree of Asrock X570D4U BMC
Date: Fri, 29 Mar 2024 14:01:38 +0100
Message-ID: <20240329130152.878944-1-renze@rnplus.nl>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

These patches change the GPIO table, ADC channel configuration and
I2C bus configuration of the devicetree for the X570D4U BMC as part of
ongoing efforts to support OpenBMC on this platform.

Best regards,
Renze Nicolai

Renze Nicolai (3):
  ARM: dts: Modify GPIO table for Asrock X570D4U BMC
  ARM: dts: Disable unused ADC channels for Asrock X570D4U BMC
  ARM: dts: Modify I2C bus configuration

 .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  | 152 +++++++++---------
 1 file changed, 78 insertions(+), 74 deletions(-)

-- 
2.44.0


