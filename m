Return-Path: <linux-kernel+bounces-154557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F588ADD9A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931B81F220EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4577923759;
	Tue, 23 Apr 2024 06:44:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D717BB7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854655; cv=none; b=CCN5DAk+Eex/AeRCHcQzbDUU+mRrErqVI389IaD7DhPCC2BxEBOETjr5RiuP3tMhplWs3ZXzNGK8b30g5QSlcfMTd6Nl4cyTpge3ziGG0qiM861+pO/KgxzfsMEeboBXNQiN13TDZEIFgSjTxbZLa8EcupWAWz46z8WKJEs/NbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854655; c=relaxed/simple;
	bh=3yvG2JR0FVm384FMkHjhLQhJrk9XdHHltko3LnCBBic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j0n3jRkiQ9fIEQ4CVM08UjfCzUB2W43RWuWdt86uCK0Z1kiHN8GP/Pwmfs251UFhEnkS7gEXR3L1kjc0S2w/1hRyc/MpguLlYhLL/h9eQw9NX5wWWFBdNDFiFhZZhiMM8rCVp7HtO6RLhNvH5hjTA9l0iSH1CQKdOC31NOp2svY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1rz9sp-0007P6-Hm; Tue, 23 Apr 2024 08:44:03 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: =?utf-8?Q?S=C3=A9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
  Pengutronix Kernel Team <kernel@pengutronix.de>,  Fabio Estevam
 <festevam@gmail.com>,  Clark Wang <xiaoning.wang@nxp.com>,  Linux Team
 <linux-imx@nxp.com>,  Alexandre Torgue <alexandre.torgue@foss.st.com>,
  Jose Abreu <joabreu@synopsys.com>,  Maxime Coquelin
 <mcoquelin.stm32@gmail.com>,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  imx@lists.linux.dev,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/3] arm64: mx93: etherrnet: set TX_CLK in RMII mode
In-Reply-To: <f01d49cf-5955-405c-9c2b-05b0c7bb982c@armadeus.com>
 (=?utf-8?Q?=22S=C3=A9bastien?=
	Szymanski"'s message of "Mon, 22 Apr 2024 11:28:08 +0200")
References: <20240422-v6-9-topic-imx93-eqos-rmii-v1-0-30151fca43d2@pengutronix.de>
	<f01d49cf-5955-405c-9c2b-05b0c7bb982c@armadeus.com>
User-Agent: mu4e 1.12.4; emacs 29.3
Date: Tue, 23 Apr 2024 08:43:58 +0200
Message-ID: <87mspkk28h.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


Hi,

On 2024-04-22 at 11:28 +02, S=C3=A9bastien Szymanski <sebastien.szymanski@a=
rmadeus.com> wrote:=20
=20
> Hello,  On 4/22/24 10:46, Steffen Trumtrar wrote:=20
> > This series adds support for setting the TX_CLK direction in the eQOS e=
thernet core on the i.MX93 when RMII mode is used.  According to AN14149, w=
hen the i.MX93 ethernet controller is used in RMII mode, the TX_CLK *must* =
be set to output mode.=20
>  Must ? I don't think that is true. Downstream NXP kernel has an option t=
o set TX_CLK as an input:=20
>

re-reading that passage again, it only says "other registers that must be c=
onfigured" and that the ENET_QOS_CLK_TX_CLK_SEL bit "is 0b1" for RMII. So, =
maybe you are right.=20


Thanks,
Steffen

> https://github.com/nxp-imx/linux-imx/blob/lf-6.6.y/Documentation/devicetr=
ee/bindings/net/nxp%2Cdwmac-imx.yaml#L69
>=20
> https://github.com/nxp-imx/linux-imx/commit/fbc17f6f7919d03c275fc48b0400c=
212475b60ec
>=20

--=20
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

