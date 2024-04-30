Return-Path: <linux-kernel+bounces-163380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C2A8B6A24
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C5E1C21962
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D6A17BB4;
	Tue, 30 Apr 2024 06:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="RFzzKtqE"
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF9818E0E;
	Tue, 30 Apr 2024 06:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456945; cv=none; b=eNggfnS6YpHV0c9+4f2zY0gL7G6f57/dZqkqgQD79NoLDM6Q/UwvPlLUgYbO31wlnhaMZUY8YfV7sXlOJdSS9RKMaMu5xLmZ3SRIp1LbDRycSJ8R7s/pVtKtPT/dTWhx93d+hN5Cmr0p8hVjjJdD2zPH46dIxrOOdsCMS8wR7qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456945; c=relaxed/simple;
	bh=c+jOECq5iNHGoPllZKnFae0KEe4r8vbzMvsoppCbQtM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=nHfwdrUbG2KRYkpLWzXrXcPjBUTqmECuYTPkIBZGg3UIoDXZkz4vhxADAndwL4xMVRzIGGHZMkJSt2lHprSKNC5miavyh2p0miKFRvaWfmyviuNcTC2ni4TpBMT/TKvmL8HFOGQwcTsMs7VrPBn8nVterrPsan4wJWv4lCuufx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=RFzzKtqE; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:To:From:Cc:
	Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YW2t+Uyy5JF6+HVc5XVOdFTIDcJXXBz01l/hz5M5h+E=; b=RFzzKtqEIfkcbwU9s3vkm6rEkn
	z9kFRqXkyZlhK7yRyTDnWqG7sDyTDpsbL9QD81sD537u7yBvW7W4PDPFUDTtcWtLvA10vqahiOeXg
	UgafH36gq7N+sHSKNrQg4LMLMvhzOnOIHGzsAUDnTJEchrXtr0V50INDzB6osSVpZ6pL6ZZbWG12d
	qIxcnm6xb7Vc2ia0P7zZCJIJjMoSAlxekpO5bEL9PVaeNQuon1PbBPmQ+52b0ybFfi7wc5C8oPJh4
	qqQR6dt0+s3xhuGvPRdKy1kcfxOHgif1oX0kLR/LSmIStTSLVUppdvtQb006goD1dMKjn99UO3/FB
	UKnk4a5A==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1s1gGQ-000KCY-FG; Tue, 30 Apr 2024 07:42:50 +0200
Received: from [185.213.155.203] (helo=localhost)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1s1gGP-000Opj-2L;
	Tue, 30 Apr 2024 07:42:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Apr 2024 05:42:49 +0000
Message-Id: <D0X7UJELGST3.2IL1AFDJ89N07@folker-schwesinger.de>
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add Radxa ROCK 3C
Cc: "Conor Dooley" <conor+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Rob Herring" <robh@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Chukun Pan" <amadeus@jmu.edu.cn>, "Heiko Stuebner" <heiko@sntech.de>
X-Mailer: aerc 0.17.0-118-g0a1af14fd916
References: <20240428123618.72170-1-amadeus@jmu.edu.cn>
 <20240428123618.72170-3-amadeus@jmu.edu.cn>
In-Reply-To: <20240428123618.72170-3-amadeus@jmu.edu.cn>
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27260/Mon Apr 29 10:23:47 2024)

On Sun Apr 28, 2024 at 2:36 PM CEST, Chukun Pan wrote:
> [...]
> +&sdhci {
> +	bus-width =3D <8>;
> +	max-frequency =3D <200000000>;
> +	mmc-hs200-1_8v;

Out of curiosity, does this board also support HS400? From a very brief
look this board seems quite similar to Rock 4 series boards, that do
support HS400.

> +	non-removable;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
> +	vmmc-supply =3D <&vcc_3v3>;
> +	vqmmc-supply =3D <&vcc_1v8>;
> +	status =3D "okay";
> +};


