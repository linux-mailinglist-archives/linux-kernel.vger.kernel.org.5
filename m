Return-Path: <linux-kernel+bounces-135651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7AC89C944
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174AF287A46
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390AD1422D8;
	Mon,  8 Apr 2024 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffNbVrFN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773871422BA;
	Mon,  8 Apr 2024 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592139; cv=none; b=fD0scmo/D16/9XhLHEDharW4faIcwgpIEncDihcBaaFeib55WQ/U2/f6IDDbJ44Wpos+0nXI1FETJV130s889xEg156Q4M1fR3s5D6TVf+uvZeomFTtMXzFcsc7v+WByCxJ0sv3txX1t3FaEAqXdgvDmJr/u28zR9RG95KtEUzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592139; c=relaxed/simple;
	bh=ipJuww1ndidw63caquJ6tDL3B0VB+7HW4TINvZ2UjVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmYsepsOcVn75T/Tpt2LGLgDfUCIn9syTd7NHIQ8cM4LaVSf1OO5oIG7ZVyOwNk4azM0Ars9DLfdQfXKrdsQF4e1DM6b8935NKhGLXs1ztRG/7pT8O6n0AKehhvFvzqJtuv9dJsFBckW5UxwcnmkhagP0/QrSo2ewDXpUIp/KJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffNbVrFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929A6C433C7;
	Mon,  8 Apr 2024 16:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712592139;
	bh=ipJuww1ndidw63caquJ6tDL3B0VB+7HW4TINvZ2UjVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ffNbVrFN+q2m8pyqLML6+DLMCxPr7L/hs4qh5BmeJGCpaFELcB7r0g1qe9knYyjpv
	 yEcceoV4lLaZV3KBJPvbc2KLHEJcrwXrIgXZAl/K+lK6Jt6ErT8G5V2r5wOQ2sdmDv
	 HuL4Wu+e+AUa2N5nfbDayTspRel9n0EtMBptWwDO5F7dfWCVg4aQ2+6kNI5WMHG5Pz
	 Q+zUB3GR6uVgkpn+LNRUsfNoaFxz/5yQV+8RbHrsRh39Pd28EYCCE4TciW1w2t9Obb
	 NTGLfcPyTfkGyye0Ms+WT0ij8l0GSAOnDCxVCJ6RndIQEX1/eL8QNubkZm/IenF0Lx
	 AXpQ2R74I0TIQ==
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	horatiu.vultur@microchip.com,
	steen.hegelund@microchip.com
Subject: Re: [PATCH v2 01/10] arm64: dts: microchip: sparx5: fix mdio reg
Date: Mon,  8 Apr 2024 17:00:40 +0100
Message-ID: <20240408-okay-deserving-8d06e76c2183@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240405190419.74162-1-krzk@kernel.org>
References: <20240405190419.74162-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1759; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=KA9ih6u3mBi75U8iJUf9RHVwjiBPZpzGXCIcfRNCroo=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGkiIissMo//8H4vX5VzuOMm7+z5Qptmr5/+MMIzZ6bwv 0mnnfhvdpSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiG5gZGTbeU3jFtmLqwvB7 uxkyjrH1WBu+3PHj6l6bgO8Wbin15/cy/BX4+6rPaUUEe0TRze3vYte7b+neY7Jj0qxdG5/5BL3 2SeMFAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Fri, 05 Apr 2024 21:04:10 +0200, Krzysztof Kozlowski wrote:
> Correct the reg address of mdio node to match unit address.  Assume the
> reg is not correct and unit address was correct, because there is
> already node using the existing reg 0x110102d4.
> 
>   sparx5.dtsi:443.25-451.5: Warning (simple_bus_reg): /axi@600000000/mdio@6110102f8: simple-bus unit address format error, expected "6110102d4"
> 
> 
> [...]

Applied to microchip-dt64, thanks! I'll re-direct it to fixes either if
some wider cleanup needs some of these warnings gone before v6.10-rc1.

[01/10] arm64: dts: microchip: sparx5: fix mdio reg
        https://git.kernel.org/at91/c/5d83b9cbe7cf
[02/10] arm64: dts: microchip: sparx5: correct serdes unit address
        https://git.kernel.org/at91/c/013627825bbe
[03/10] arm64: dts: microchip: sparx5_pcb134: add missing I2C mux unit addresses
        https://git.kernel.org/at91/c/9dcf4ec57700
[04/10] arm64: dts: microchip: sparx5_pcb135: add missing I2C mux unit addresses
        https://git.kernel.org/at91/c/5150c3df4c2e
[05/10] arm64: dts: microchip: sparx5_pcb134: align I2C mux node name with bindings
        https://git.kernel.org/at91/c/d3dd7bed4210
[06/10] arm64: dts: microchip: sparx5_pcb135: align I2C mux node name with bindings
        https://git.kernel.org/at91/c/b0d5a3ce782a
[07/10] arm64: dts: microchip: sparx5_pcb134: drop LED unit addresses
        https://git.kernel.org/at91/c/55fb5a97ebe0
[08/10] arm64: dts: microchip: sparx5_pcb135: drop LED unit addresses
        https://git.kernel.org/at91/c/5945df4de0e2
[09/10] arm64: dts: microchip: sparx5_pcb134: drop duplicated NOR flash
        https://git.kernel.org/at91/c/f1595d501ea4
[10/10] arm64: dts: microchip: sparx5_pcb135: drop duplicated NOR flash
        https://git.kernel.org/at91/c/6c7c4b91aa43

Thanks,
Conor.

