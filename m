Return-Path: <linux-kernel+bounces-99964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E045F878FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899BC2818DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A5977F07;
	Tue, 12 Mar 2024 08:47:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4D8762FD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233258; cv=none; b=E8rSOipQS1sY+roxZ6CPbXeMiazeGHRWuCeGREM1Y8qnHIHgfRWIMQ33yq88Sb/hEUWB98BSAgNIhTIJJF0/WZynA1Hy9B5T2ZgAdvKG4tlrcJ0CG6RyolLKvfonr4MXrSC8dKF9/P3iaKGVPKz2pmuYH7jZXMX3lwMGp/A0Qpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233258; c=relaxed/simple;
	bh=+JLFmmaZj3Ymmlu48P7kWzmpOoHj+5HBjBTEMR4GtDQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hSk5+kbEXXoBvCl/jFgz+Sh2oDJJBItQo8l09LV/mgwiOPQ9mmSp7cRWxEyLErge32dNOQdNOZbABjIBytAFD1/+1/20vXo/PoK3Odlgpw8UwolX88wxdsB/hTnqCnEgRAidzTAu+U/Hi2sJ7TDHtCPBKs87ieMDLyCUxjH4fFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rjxnC-0001Io-F9; Tue, 12 Mar 2024 09:47:26 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rjxnB-005scx-3M; Tue, 12 Mar 2024 09:47:25 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rjxnB-0003LK-0A;
	Tue, 12 Mar 2024 09:47:25 +0100
Message-ID: <f35398925846addb282df9c8a6f09d24ecc5c6fc.camel@pengutronix.de>
Subject: Re: [PATCH 0/3] reset: Convert to platform remove callback
 returning void
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org,  linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Tero Kristo
 <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 kernel@pengutronix.de
Date: Tue, 12 Mar 2024 09:47:24 +0100
In-Reply-To: <cover.1709674157.git.u.kleine-koenig@pengutronix.de>
References: <cover.1709674157.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2024-03-05 at 22:32 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> this series converts all platform drivers below drivers/reset to struct
> platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
> Provide a remove callback that returns no value") for an extended
> explanation and the eventual goal.
>=20
> All conversations are trivial, because their .remove() callbacks
> returned zero unconditionally.
>=20
> There are no interdependencies between these patches, so they could be
> picked up individually. But I'd hope that they get picked up all
> together by Philipp.

Thank you, I'll pick them up.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

