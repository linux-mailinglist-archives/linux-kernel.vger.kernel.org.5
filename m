Return-Path: <linux-kernel+bounces-64146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C4F853AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B9E1F237E1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB7D6087A;
	Tue, 13 Feb 2024 19:16:29 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1005FF0A;
	Tue, 13 Feb 2024 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851789; cv=none; b=f6EGC/V9ZVyjyEMgAWEVDQkbEINQcAhkd69uQcIJzNg6qvZXfgPnx6y0fgxGFxfQ1Db9vCQSHpVz83n8c/TAXyBD/3oiRQ5hnw2hB7llA5jAF7D5CzhiFGJB9ZHCPLCoALnW4dvqqRHp+AG7/IGKBatcnh9RaKjAkEeX/LJNwKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851789; c=relaxed/simple;
	bh=OUU1YZXo3yo0PciRPdb54Wmqd4/2SZ750LGczHwVk/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mf7ySwOzyCssdFzL77gCliErD7juCs79GzFXxlBRULUUHvZW3xbYSWUrxF6i55SpK2mF3CUBl/lSlYW0a4wuLYjjmaz51PfQ05ZgrAfLTe4tSFvajnsml+XbzMr6zJFhk/dIiOmmN4nRcQBaVS/+6sg40YoDJdbjvaSlZKztHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rZyGU-0008FY-SS; Tue, 13 Feb 2024 20:16:22 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	quentin.schulz@theobroma-systems.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v6 0/2] serial: 8250: Add support for rs485 half/full duplex on puma/ringneck-haikou
Date: Tue, 13 Feb 2024 20:16:15 +0100
Message-Id: <170785172857.3347621.5386366884287991661.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208-dev-rx-enable-v6-0-39e68e17a339@theobroma-systems.com>
References: <20240208-dev-rx-enable-v6-0-39e68e17a339@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 08 Feb 2024 16:39:54 +0100, Farouk Bouabid wrote:
> On the boards that we are using (ringneck/puma-haikou) a hardware switch
> can set the rs485 transceiver into half or full duplex mode.
> 
> In half-duplex mode the DE/RE signal of the rs485 transceiver is not
> connected to an RTS signal whose control is already handled in the rs485
> emulation (start/stop callbacks), but rather to a gpio. And since enabling
> the receiver requires setting this gpio active we need to do that in em485
> while receiving and disable it while sending to enable the driver mode.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: rk3399-puma-haikou: add rs485 support on uart2
      commit: 54448f711aa32f176534bbd7b1903cc6d1c8a50d
[2/2] arm64: dts: rockchip: px30-ringneck-haikou: add rs485 support on uart5
      commit: 5963d97aa780619ffb66cf4886c0ca1175ccbd3e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

