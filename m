Return-Path: <linux-kernel+bounces-88672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD16286E510
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F611C2125C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6636670CBB;
	Fri,  1 Mar 2024 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEOzgbzV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B64368;
	Fri,  1 Mar 2024 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309650; cv=none; b=HbIbgNg+wuRrLkIm2n4tQLTFbMTihHcWi9Mtywm9XypdyGxL4MNYOJzGFQH3erqTsNPP7brA8AvzDj5/BgBeqgUx3cfmbDamyFG92LVB1yPvkjCe+lHGVa4y9MqaxYV0obhU/qRnUZ19WWfKqZHPo6hhlQ5rocYzhGvmR4BleP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309650; c=relaxed/simple;
	bh=BikzDK1QW0K2bWi7muKUljDgu1skoyyFPZELijkX52k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dirbx7EbcL3vTgfHH/Zk8+hpKhEs1Oe2UVoOz8ozw6Bue1IXRVWi2CQKNoWaysrLitsI/XHY3riv3GAMIBKe6SnluU8eCWtPDyYahqi0KEesfr3JGFMGifu9ifTdLzZaS1jksOr0ju9lq1ArcKd6wWr33bvyrAQJD4N5mqNGSsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEOzgbzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3EEC433C7;
	Fri,  1 Mar 2024 16:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709309650;
	bh=BikzDK1QW0K2bWi7muKUljDgu1skoyyFPZELijkX52k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TEOzgbzVFsLomQFvAfuSVAfDEuhsD4VvQdASJ6LjNj10+td2wi0MCxU4FIP3pi0V7
	 a1TdcPajbG1NfAVladYc6nqtbsgm3GdUE8uSqAUN76NLm1P3oOASJQ4NOcT87a7FzR
	 a6Zk/13yRchQIQ8WyZpiIKujV3KCDpKc44CQgFzPorDsheHjwjGq4M6uDjEkuMLGuv
	 x8Fkbl1iqCWIZsmUnn511pkATzZudzJ7jsOqi3iuhNBT6HV6r2eTimTDV9+4RhQZxM
	 PZjiakJ1gh/Tjya4WNczaoQIZ7roUSxYyfZEpOHv4dc8uTxI0L6Y5Azs4Tgl0QTplD
	 MbhZGTNc1pykA==
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [v3] riscv: dts: starfive: jh7110: Add camera subsystem nodes
Date: Fri,  1 Mar 2024 16:14:00 +0000
Message-ID: <20240301-wildfire-glue-983d58132599@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219032741.18387-1-changhuang.liang@starfivetech.com>
References: <20240219032741.18387-1-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=355; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=caay3mRU/JhC/YsFIkNMgzQjqWb0CeveGJRpWt2VyHA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKkP/x03ZRMI+/XnQ7JJfsT3mQumPClRPfv3XWH47x9vh TuVZ3D96ShlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBENixl+CuzbQHLC3uW2w1f 791QF1ryMNCNP8f9iIV7BsvOAh/9kr2MDH3cs4Rz1yz8W+G18e7FDdkWKlNPz9ixe+2WSf3P8rc cZWYHAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Sun, 18 Feb 2024 19:27:41 -0800, Changhuang Liang wrote:
> Add camera subsystem nodes for the StarFive JH7110 SoC. They contain the
> dphy-rx, csi2rx, camss nodes.
> 
> 

Applied to riscv-dt-for-next, thanks!

[1/1] riscv: dts: starfive: jh7110: Add camera subsystem nodes
      https://git.kernel.org/conor/c/28ecaaa5af19

Thanks,
Conor.

