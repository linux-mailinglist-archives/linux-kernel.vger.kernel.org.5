Return-Path: <linux-kernel+bounces-154999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9930A8AE42C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375971F23823
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E163284A21;
	Tue, 23 Apr 2024 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b="D4KlswLM"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46222E576;
	Tue, 23 Apr 2024 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872152; cv=none; b=u4Q/RrrswW/1mK579kgYicf00xbMKEKjfdx4ZC9uA5YEZtwqAnzCCsJm7oi+/+7HTnF7r09c63EWLjzpbRg4vnsjQVPbEFlhS+O1NOD/33MHOh1DgPJyFDgjddZ6gYmIAYRPEyvX6D7W+inoIt+1Jq2NIqvy7MWCrdrQWjNdvrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872152; c=relaxed/simple;
	bh=lJt8E0U3Mk8gFwh7JvTQ5k6BmWh49nIGxdJHH7cyVEc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ct6yk8DCFxRwf035BG2y4tKPwbJJd7bRvYKzFLlBI+C6d2ITebi165a3ZmaKgDlsdReXP36lfie1/S2TcTc4i0JXSY2Eg6+kPLHdrJb6VISFhuT2h00UFuvlFn5+Or1zh6AYUMnULuw0Ua32Oz3Pm7bt28Gv1RnExmawruWF0YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pqrs.dk; spf=pass smtp.mailfrom=pqrs.dk; dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b=D4KlswLM; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pqrs.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pqrs.dk
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqrs.dk; s=key1;
	t=1713872145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SeGdmR9Tag7SOUwFc4v/9fCbObSDxffUEqU54SLcBGw=;
	b=D4KlswLM0VXPMkuJTMq35iulmEONaMwMfl8HvhVphaihApvIHqllOgFN5Y0nWva7M7lurJ
	q4yNNV0XZVvh6doS2hT5OTxjs/h39LV0LlXkEheJcH7L1vxntdsjTZy10g0RSFlH/dP4OJ
	V3lji1l8Nw9kb7dqL8Y0Z4eHKA7T5QdDClIqR0UC7UrLzQvpU+68jwpmdzbB0Ra7x497HW
	2RI8kJ5IR5bcKL11KMq0lI84xnDyn/rk2ugJhBGxGalKS5Ev+NB5BdqW+ydF1mokVIkgKl
	AIBNCwu+00UeA2MhmfGUtpiiqWejUDRzeRe1dZmVHWC6evCtvfRhFNX3OumR7A==
From: =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Subject: [PATCH 0/3] spi: sc18is602: add support for SC18IS606
Date: Tue, 23 Apr 2024 13:35:29 +0200
Message-Id: <20240423-sc18is606-v1-0-094ef37d5a59@bang-olufsen.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAGdJ2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEyNj3eJkQ4vMYjMDM90UY3NTM0Pj1KQUCyMloPqCotS0zAqwWdGxtbU
 ACtPpnVsAAAA=
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
X-Migadu-Flow: FLOW_OUT

The SC18IS606 is basically already supported by the driver, but since it
has a larger data buffer and fewer chip selects, it deserves its own
compatible string together with some minor modifications to the driver
to support this.

While at it, convert the device tree bindings to YAML before adding an
additional compatible string.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
Alvin Šipraga (3):
      spi: dt-bindings: nxp,sc18is602: convert binding to YAML
      spi: dt-bindings: nxp,sc18is602: add compatible for SC18IS606
      spi: sc18is602: add support for SC18IS606

 .../devicetree/bindings/spi/nxp,sc18is602.yaml     | 60 ++++++++++++++++++++++
 .../devicetree/bindings/spi/spi-sc18is602.txt      | 23 ---------
 drivers/spi/spi-sc18is602.c                        | 29 ++++++++---
 3 files changed, 83 insertions(+), 29 deletions(-)
---
base-commit: 5343a65e03e4ee9f81508032e70b547e3c9f99ed
change-id: 20240423-sc18is606-d375613ebd82


