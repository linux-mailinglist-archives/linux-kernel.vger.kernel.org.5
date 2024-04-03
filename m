Return-Path: <linux-kernel+bounces-130055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729EC8973E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 827B0B2D66A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA15C14A629;
	Wed,  3 Apr 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="kA1ORBz6"
Received: from mail-108-mta14.mxroute.com (mail-108-mta14.mxroute.com [136.175.108.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ECE14A623
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156956; cv=none; b=jErO+UduzJxRB5AmQ5qP1QpRbVTYILr6feXd0uIM9i5Da8TQQzZUqMxq/fNhpLlDiIn2vhc6Y8IgYftnwBmtxJ8SrtUD+f5zjlabDoTDq0IGASyEfqua+QqvVTA/oeDS2h8BOsM3N3peo+fnxKoCp3Od64/nNnt2TmPuAmUHbdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156956; c=relaxed/simple;
	bh=wIpVOMNTepZOMW3UvbZH0rdRDmA+UQLMgr2GlfwRQGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apyOZkNIR0atTtbSeMGifONjk/9faxNlbUfgYmAQ8/WuBZ8PjFxf01jq4XZSjlTslfMVzcYvKnQEDk3tBe96bbTr7udwBiEqKAMVF5eBPkVF84/GE9q1KcXMa7uggDws5hoauYYpl3I2/epLfmpc+FnkvzXCi5uObNyvf4lM+Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=kA1ORBz6; arc=none smtp.client-ip=136.175.108.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta14.mxroute.com (ZoneMTA) with ESMTPSA id 18ea480b8510003bea.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 03 Apr 2024 15:08:03 +0000
X-Zone-Loop: a429ce91b5c75c1644299d16a354a98c61e831894818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+hno/NO5DLefJIOqoOH2kmnTpizyU8GDGwSxBdTiTxg=; b=kA1ORBz6pfHHAqSDL9oc6Bnp9o
	ektfpP8ACACEUehYTzqVKk5hoQ5s2j+4+K9osj+aBbYHGNfnAYZo+3MK9DoiyCBNDbXEp5GtFkM0f
	Iz/dgW5juy0V3OvJfzkwOriPQLHG5GazMSMcoJuxmsKrNoje3ChMBqlPerDNYhAGzIfDgyOE6iNyP
	3H3wvWhKEQ8LMQK3/P5dZLaoD48ZaKkJ4rmpMGd+xq+3AwCPylLEhaBAuKgN6UnAwtF1a95NoBhNx
	aXkhC+1upEF8WKoydrMT2JHjeLPYpepESAYT0tK/FOmAWM61zQjAj6XojaitK9ktHXMlYld53wAnf
	OmGrZV4A==;
From: git@luigi311.com
To: linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pavel@ucw.cz,
	phone-devel@vger.kernel.org,
	Luis Garcia <git@luigi311.com>,
	Ondrej Jirman <megi@xff.cz>
Subject: [PATCH v3 22/25] dt-bindings: media: imx258: Add binding for powerdown-gpio
Date: Wed,  3 Apr 2024 09:03:51 -0600
Message-ID: <20240403150355.189229-23-git@luigi311.com>
In-Reply-To: <20240403150355.189229-1-git@luigi311.com>
References: <20240403150355.189229-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Luis Garcia <git@luigi311.com>

Add powerdown-gpio binding as it is required for some boards

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Luis Garcia <git@luigi311.com>
---
 Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
index c978abc0cdb3..33338139e6e8 100644
--- a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
@@ -36,6 +36,10 @@ properties:
   reg:
     maxItems: 1
 
+  powerdown-gpios:
+    description:
+      Reference to the GPIO connected to the PWDN pin, if any.
+
   reset-gpios:
     description: |-
       Reference to the GPIO connected to the XCLR pin, if any.
-- 
2.42.0


