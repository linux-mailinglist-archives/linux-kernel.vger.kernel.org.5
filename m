Return-Path: <linux-kernel+bounces-1414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA57814EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD28A1C24387
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDD141857;
	Fri, 15 Dec 2023 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fRuOfuZo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87064177F;
	Fri, 15 Dec 2023 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BFHLCBp107022;
	Fri, 15 Dec 2023 11:21:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702660872;
	bh=6yrAw4EhU4TedQWsadNLo1W9eYBDW8OQFUq/C6pXaeo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fRuOfuZoN3JrOXPfDMihnZmlQW9Ar297qdG1/Bpxnhm2ImvVZkPxJmxEiUZy0dvyV
	 ph8IrgB9eikgv/Us6LKDgs1W3CL1VaYPdcyUZOK6c37jvkIMC6zCVHqqcKXAtc/HH7
	 Q8oq2l9Xgf4KmE4yX/Hh/wUMzVIZPh8Mz+Bf3Nlk=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BFHLCmP007915
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 15 Dec 2023 11:21:12 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Dec 2023 11:21:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Dec 2023 11:21:12 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BFHLCJJ116403;
	Fri, 15 Dec 2023 11:21:12 -0600
From: Nishanth Menon <nm@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Bhavya Kapoor <b-kapoor@ti.com>
CC: Nishanth Menon <nm@ti.com>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] arm64: dts: ti: Add Itap Delay Value For High Speed DDR
Date: Fri, 15 Dec 2023 11:21:09 -0600
Message-ID: <170266085077.3490141.14935960940418963459.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201082045.790478-1-b-kapoor@ti.com>
References: <20231201082045.790478-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Bhavya Kapoor,

On Fri, 01 Dec 2023 13:50:42 +0530, Bhavya Kapoor wrote:
> This Series adds Itap Delay Value for DDR52 speed mode for eMMC in
> J7200 and for DDR50 speed mode for MMCSD in J721s2 and J784s4 SoC.
> 
> Rebased to next-20231201
> 
> Bhavya Kapoor (3):
>   arm64: dts: ti: k3-j7200-main: Add Itap Delay Value For DDR52 speed
>     mode
>   arm64: dts: ti: k3-j721s2-main: Add Itap Delay Value For DDR50 speed
>     mode
>   arm64: dts: ti: k3-j784s4-main: Add Itap Delay Value For DDR50 speed
>     mode
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-j7200-main: Add Itap Delay Value For DDR52 speed mode
      commit: 908999561b4340089896b89cef51dae07fc001cb
[2/3] arm64: dts: ti: k3-j721s2-main: Add Itap Delay Value For DDR50 speed mode
      commit: 4a52a8208568a85b0d51e5ca81be5925973ef108
[3/3] arm64: dts: ti: k3-j784s4-main: Add Itap Delay Value For DDR50 speed mode
      commit: 8bbe8a7dbaabb84d93321f116966af73ba6a7233

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


