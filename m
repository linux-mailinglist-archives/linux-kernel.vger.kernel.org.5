Return-Path: <linux-kernel+bounces-155413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C57EF8AEA11
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6750E1F227E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F4F13BAC7;
	Tue, 23 Apr 2024 15:02:52 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362D13B5BD;
	Tue, 23 Apr 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884572; cv=none; b=kQOfQWEG7wGW4HWuW0GZgJSsPX0rY+3Hkq573WmdpJg99cJXD3jbcckh2JhS+aNDhNKYl+lTKjkc1To8zLWzHorIR9+nxjwhmfJWziFpuEcJA1xynQ/WNdCRTsOwlSmzE65WlAlYjwI96mma2zhAuSnH/jA3m6uU5HFvjGXgTjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884572; c=relaxed/simple;
	bh=Nn/cBR6ymJ2MA5QONdG7bKZd99gxiK0LAjjwzA1qQBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmB+TaxgiPyrWnLo/NZjUruj7yIGQnTicOVRMi2Zvgel0RTL3IlN4sjBY/Z8XHeiJOg7free/5pKkUFo5jvC5U2SuwvHY9YggRIzPFDZjcnRIcP5y+03DLDNvLX0NKoGDgMN4F6I0/DAVrvj2XmY88gfkDXmQizpIOg2cVPC4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d9e.versanet.de ([94.134.29.158] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rzHfF-0007Cj-Km; Tue, 23 Apr 2024 17:02:33 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jianfeng Liu <liujianfeng1994@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Weizhao Ouyang <weizhao.ouyang@arm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 sfr@canb.auug.org.au
Subject: Re: [PATCH v5 3/3] arm64: dts: rockchip: Add ArmSom Sige7 board
Date: Tue, 23 Apr 2024 17:02:32 +0200
Message-ID: <2484736.irdbgypaU6@diego>
In-Reply-To: <1a78e0e1-af0a-4bb9-8d2d-982e244a1ce1@arm.com>
References:
 <20240420034300.176920-1-liujianfeng1994@gmail.com>
 <20240420034300.176920-4-liujianfeng1994@gmail.com>
 <1a78e0e1-af0a-4bb9-8d2d-982e244a1ce1@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Montag, 22. April 2024, 11:08:48 CEST schrieb Weizhao Ouyang:
>=20
> On 2024/4/20 11:43, Jianfeng Liu wrote:
> > Specification:
> >         Rockchip Rk3588 SoC
> >         4x ARM Cortex-A76, 4x ARM Cortex-A55
> >         8/16/32GB Memory LPDDR4/LPDDR4x
> >         Mali G610MP4 GPU
> >         2=D7 MIPI-CSI Connector
> >         1=D7 MIPI-DSI Connector
> >         1x M.2 Key M (PCIe 3.0 4-lanes)
> >         2x RTL8125 2.5G Ethernet
> >         Onboard AP6275P for WIFI6/BT5
> >         32GB/64GB/128GB eMMC
> >         MicroSD card slot
> >         1x USB2.0, 1x USB3.0 Type-A, 1x US3.0 Type-C
> >         1x HDMI Output, 1x type-C DP Output
> >
> > Functions work normally:
> >         USB2.0 Host
> >         USB3.0 Type-A Host
> >         M.2 Key M (PCIe 3.0 4-lanes)
> >         2x RTL8125 2.5G Ethernet
> >         eMMC
> >         MicroSD card
> >
> > More information can be obtained from the following website
> >         https://docs.armsom.org/armsom-sige7
> >
> > Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
>=20
> Reviewed-by: Weizhao Ouyang <weizhao.ouyang@arm.com>

thanks a lot for also sending this review from your @arm.com
address, this alleviates all the naming concerns a bit for me :-)



