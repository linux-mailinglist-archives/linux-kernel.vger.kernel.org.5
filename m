Return-Path: <linux-kernel+bounces-68106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DFD85760B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0C81F23E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D59F14280;
	Fri, 16 Feb 2024 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HsTXEjE4"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9403BD527;
	Fri, 16 Feb 2024 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708065076; cv=none; b=Mf+hd+0Bguch5nm6zmK0dW6PvsQ+H0uldLF8n37IpcPCPYSWl2H9a87Np4ECvujl2wXffB4c1o00R2dk9G9Np30C+2iriPXeJUPMwrGKSgwOddZqumYnBY+PxJDctcC9+We47A0ZF9ZsO9e/Vda8T0PWqiYa+qedUY5tugMfsqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708065076; c=relaxed/simple;
	bh=UKVarjtEQaZz+89eGFFfI1BdI2Ntw5zoJTTo+Y85YXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdU9k6TrnmMGLrHI5R1ANnQGfpBYdpSjFqxxTNnrdnl127x+SxL5MuLiP9yEGcvxtvdlf4eqtU6CMqOGdasv6gqic8M3wEq15qAk4eovpsYCC7GLOVtzEXH/9sp1JXIrmgRFRP1qOIdxBXNZfDQd8mzTbrBr5Yd6FMd0E72+KUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HsTXEjE4; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41G6V6Ox113404;
	Fri, 16 Feb 2024 00:31:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708065066;
	bh=/IuEyiwR4vC6wmxB/CPvlfA/K8tcnmenx5yNFdRRBQM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=HsTXEjE4fyvKCkYuuKbpOFIaBqktl1MQvWopiqBuoybVnX4NOPwne5KxrPV4mSIbO
	 yPClHvAJKhf2tfp6R1gechia3SZcnzapKLFLUkCXP5EB/cA+Bv7Yuxja4IBaMPzxiG
	 ehhbNhybkw8GdvOnL3np1jv9aANODiSnbxqifwns=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41G6V6wv116681
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Feb 2024 00:31:06 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Feb 2024 00:31:05 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Feb 2024 00:31:05 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41G6V249107324;
	Fri, 16 Feb 2024 00:31:02 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jan
 Kiszka <jan.kiszka@siemens.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Bao Cheng Su <baocheng.su@siemens.com>
Subject: Re: [PATCH v3 0/7] arm64: dts: iot2050: Add support for new SM variant
Date: Fri, 16 Feb 2024 12:00:59 +0530
Message-ID: <170806504067.3877215.4593036714741774948.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707463401.git.jan.kiszka@siemens.com>
References: <cover.1707463401.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jan Kiszka,

On Fri, 09 Feb 2024 08:23:14 +0100, Jan Kiszka wrote:
> Changes in v3:
>  - rebased
> 
> Changes in v2:
>  - LED improvements
>  - factor out DP and USB3 dtsi files
>  - fix subject of last patch
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/7] dt-bindings: arm: ti: Add binding for Siemens IOT2050 SM variant
      commit: 2a99c7792a0cf4f1df1362f43f319af509c05bd8
[2/7] arm64: dts: ti: iot2050: Disable R5 lockstep for all PG2 boards
      commit: 93abe383bfd35357b3319a2430afb7826324337d
[3/7] arm64: dts: ti: iot2050: Factor out arduino connector bits
      commit: 1ef134a43213360aeef8f5508b5760bf0cf73280
[4/7] arm64: dts: ti: iot2050: Factor out enabling of USB3 support
      commit: f1a024f76db0167987fb9b53d4ae5483c118ead7
[5/7] arm64: dts: ti: iot2050: Factor out DP related bits
      commit: f2c6d71e4728528b031d6e93b97a5c21018efa70
[6/7] arm64: dts: ti: iot2050: Annotate LED nodes
      commit: 5adf911c7067d3d76d85cc33fd60e201ce43d89d
[7/7] arm64: dts: ti: iot2050: Support IOT2050-SM variant
      commit: 8829fe97f1b505acd63f25e4f36bc90957b24c29

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
Vignesh


