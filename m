Return-Path: <linux-kernel+bounces-1558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D15381500F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881D91C23B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3C03FE2C;
	Fri, 15 Dec 2023 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GbJAeEfO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581713FE30;
	Fri, 15 Dec 2023 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BFHKTbZ106791;
	Fri, 15 Dec 2023 11:20:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702660829;
	bh=lObQGXRy7yerKMFMrSX94IqXBTrSCZaZ+7s2Ymz0ppM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GbJAeEfOIgYqZc7By09SzhM3ZsXHOo/+thL6K3e7HdB4WS9s1TJ3Jz6j8Un9BR0Rx
	 px8QZ1YxF4z8l1gw0jB8Ctk0dP++dobJ4aQ+6bW92fILTBXbNK6Mp7iy6yUqed7tUL
	 LL1VgpGaTLYlXubavaD/7aFhEHDV3wyp766T/z84=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BFHKTmI036460
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 15 Dec 2023 11:20:29 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Dec 2023 11:20:29 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Dec 2023 11:20:29 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BFHKTX3115662;
	Fri, 15 Dec 2023 11:20:29 -0600
From: Nishanth Menon <nm@ti.com>
To: Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-luthra@ti.com>
Subject: Re: [PATCH v2 0/3] arm64: dts: ti: k3: Add additioal regs for DMA components
Date: Fri, 15 Dec 2023 11:20:26 -0600
Message-ID: <170266081594.3490039.10351809799939114334.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213135138.929517-1-vigneshr@ti.com>
References: <20231213135138.929517-1-vigneshr@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Vignesh Raghavendra,

On Wed, 13 Dec 2023 19:21:35 +0530, Vignesh Raghavendra wrote:
> This adds additional reg ranges which are not directly used by Linux but
> by other components like U-Boot
> 
> Binding is accepted via dmaengine tree and is in linux-next[0]
> 
> [0] https://lore.kernel.org/dmaengine/170083278148.771517.1841889156174413563.b4-ty@kernel.org/
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-am65: Add additional regs for DMA components
      commit: 0fa8d3a5eb8e737726a3c7376222ee40fae1988d
[2/3] arm64: dts: ti: k3-j7*: Add additional regs for DMA components
      commit: 1b62a3cfddbb5664bc4360b3cb0d76b9b99abdc5
[3/3] arm64: dts: ti: k3-am6*: Add additional regs for DMA components
      commit: 7643f7ebcbc723e682d22c207ac35b41d7248650

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


