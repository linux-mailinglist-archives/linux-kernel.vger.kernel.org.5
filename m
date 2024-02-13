Return-Path: <linux-kernel+bounces-64148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC491853AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E321C247CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC69C5FF00;
	Tue, 13 Feb 2024 19:16:40 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3360B93;
	Tue, 13 Feb 2024 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851800; cv=none; b=n0byHSu2bFipw/9N71hcXVuXqujs6M1X5vwzJjGTW5ha0e4kNTJOITLmkq2sPdSElvaBKviVjWmoHmqZIUjcblc5EwdPTX0I2uDSCK6kTrjtobBeNDGPBaRw1q6gdAqkdeCImkW+8L6U4dJ6vTfFYIb0Jrme/Jr97Jfw+Xx3q8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851800; c=relaxed/simple;
	bh=2kiXKWq0p/I+xaYA6ptVCKpkX0qnMpqceybemBMY+cA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBgcmRmg1bLBsd14UTBY0BVFLDDnnkrFGTcFCV7G4GTmwo1N20cDiG5Pnc74symJ2Vu3HD2KfSZr5py24tO0XsNuu/57fZCZFZYab91fPtJqWx1rgWTQAkC3/SUBWNc2vuTu48+wLV+V0i8Q1Sro6ok1JvrM741x01Wzmv0tl6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rZyGV-0008FY-Td; Tue, 13 Feb 2024 20:16:23 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	=?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>,
	linux-rockchip@lists.infradead.org,
	Lucas Tanure <lucas.tanure@collabora.com>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Christopher Obbard <chris.obbard@collabora.com>,
	linux-kernel@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>,
	Rob Herring <robh+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Jagan Teki <jagan@edgeble.ai>,
	Dragan Simic <dsimic@manjaro.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	John Clark <inindev@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: rk3588: remove redundant cd-gpios in sdmmc node
Date: Tue, 13 Feb 2024 20:16:18 +0100
Message-Id: <170785172862.3347621.15441860587856403205.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201034621.1970279-1-kever.yang@rock-chips.com>
References: <20240201034621.1970279-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 1 Feb 2024 11:46:21 +0800, Kever Yang wrote:
> The sdmmc node already have a "&sdmmc_det" for pinctrl which switch the
> GPIO0A4 to sdmmc detect function, no need to define a separate "cd-gpios".
> 
> RK3588 has force_jtage feature which is enable JTAG function via sdmmc
> pins automatically when there is no SD card insert, this feature will
> need the GPIO0A4 works in sdmmc_det function like other mmc signal instead
> of GPIO function, or else the force_jtag can not auto be disabled when
> SD card insert.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: rk3588: remove redundant cd-gpios in sdmmc node
      commit: d859ad305ed19d9a77d8c8ecd22459b73da36ba6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

