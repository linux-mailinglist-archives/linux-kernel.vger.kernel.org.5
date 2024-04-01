Return-Path: <linux-kernel+bounces-127120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F3189472B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E571C20DC6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336375646D;
	Mon,  1 Apr 2024 22:11:56 +0000 (UTC)
Received: from smtprelay06.ispgateway.de (smtprelay06.ispgateway.de [80.67.31.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D6F4683;
	Mon,  1 Apr 2024 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.31.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009515; cv=none; b=jqaYBC7D91jE1wcuCj47ph2v+tyg+s/Xn3pefJy4QMML6L1ess+d6/Qrx+HHF8aNYtM6drQYJkTIASIqn7E6ShrNdFRiQzy5TF4+sKmY6RSPMd1aIZgm8P3eoRNB3oqZmY++gicUET5rJsOWZxgvQVSQ3VIzUVnh8ooFwwd2Gic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009515; c=relaxed/simple;
	bh=gZIvbC9QcJ+z4erMfxk2BKLYyhXqYUfIhZMoeDsxtTk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fkB88N5Cd6ccW24DHzmPtYsqPtjznrs2hSX14hvFBvH8WxTaAi8Ry8irCpo7yFYwtTdiZYvds2NWGKBdwHXTNp0MGmIrMR9bBy58ZPzL0P42fwPYDaubFpp8VQeXkDBlR7INGnZRNuEMNQ6rgGfcfpoUg9b2Od/CuPeqtsch+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apitzsch.eu; spf=pass smtp.mailfrom=apitzsch.eu; arc=none smtp.client-ip=80.67.31.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apitzsch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apitzsch.eu
Received: from [92.206.191.65] (helo=note-book.lan)
	by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <git@apitzsch.eu>)
	id 1rrPsV-000000008VN-0dPK;
	Tue, 02 Apr 2024 00:11:43 +0200
Message-ID: <e842cda99206852bce7f7acc99d5dd360e313639.camel@apitzsch.eu>
Subject: Re: [PATCH v2 0/3] Add sy7802 flash led driver
From: =?ISO-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
To: Trilok Soni <quic_tsoni@quicinc.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
  Conor Dooley <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 linux-leds@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-hardening@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,  ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
Date: Tue, 02 Apr 2024 00:11:41 +0200
In-Reply-To: <d2de0a0e-6cbe-3472-0a84-797f827ac635@quicinc.com>
References: <20240401-sy7802-v2-0-1138190a7448@apitzsch.eu>
	 <d2de0a0e-6cbe-3472-0a84-797f827ac635@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=

Am Montag, dem 01.04.2024 um 14:45 -0700 schrieb Trilok Soni:
> On 4/1/2024 2:23 PM, Andr=C3=A9 Apitzsch via B4 Relay wrote:
> > This series introduces a driver for the Silergy SY7802 charge pump
> > used
> > in the BQ Aquaris M5 and X5 smartphones.
> >=20
> > The implementation is based on information extracted from
> > downstream as
> > the datasheet provided by a distributor of the hardware didn't
> > include
> > any information about the i2c register description.
> >=20
> > Signed-off-by: Andr=C3=A9 Apitzsch <git@apitzsch.eu>
>=20
>=20
> Is this the right email address? "From" shows
> devnull+git.apitzsch.eu@kernel.org.=20
>=20
This was created by b4 using the web submission endpoint.

Andr=C3=A9

> > ---
> > Changes in v2:
> > - bindings: remove unneeded allOf
> > - bindings: example: move flash-led-controller under i2c node to
> > fix
> > =C2=A0 check error
> > - Cc to phone-devel
> > - Link to v1:
> > https://lore.kernel.org/r/20240327-sy7802-v1-0-db74ab32faaf@apitzsch.eu
> >=20
> > ---
> > Andr=C3=A9 Apitzsch (3):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: leds: Add Silergy SY7802 fl=
ash LED
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leds: sy7802: Add support for Silergy SY=
7802 flash LED
> > controller
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arm64: dts: qcom: msm8939-longcheer-l910=
0: Add rear flash
> >=20
> > =C2=A0.../devicetree/bindings/leds/silergy,sy7802.yaml=C2=A0=C2=A0 | 10=
0 ++++
> > =C2=A0.../boot/dts/qcom/msm8939-longcheer-l9100.dts=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 26 +
> > =C2=A0drivers/leds/flash/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +
> > =C2=A0drivers/leds/flash/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/leds/flash/leds-sy7802.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 532
> > +++++++++++++++++++++
> > =C2=A05 files changed, 670 insertions(+)
> > ---
> > base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
> > change-id: 20240325-sy7802-f40fc6f56525
> >=20
> > Best regards,


