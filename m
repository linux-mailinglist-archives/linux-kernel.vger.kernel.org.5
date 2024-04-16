Return-Path: <linux-kernel+bounces-147469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8908A7496
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34AEE1F21F42
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D5413849A;
	Tue, 16 Apr 2024 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="JA4Q1Z/K"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B2713792D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295242; cv=none; b=AD+5QMmu0czB3LmjvRH4jB4A4RmycFXRK4UV1p8eohOyFDAAKncIpPwM9EV9q+6F/F+NSse5DHOJ10v/8aJ3twbkrOtmyOymD3XeE+Pfa3AIo/RbNwwNQWqUo+g5kKZeUXqo+RiJ4Itdgh9bxG8ST/0kxnDuhCvErbVWhj9y11o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295242; c=relaxed/simple;
	bh=5qcKuUFEXJAj5jrbqiLvzMPkKKsc2Zpg7ofBMee6fJI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ER3wZr/nbvyfSMjAxGo4D7Bd5GF7u54C5iOGKlG0nPMfLlFGVB5NlpTnlwjVGH0/EvZ2K04I/4BkUtVEHhcyhKzvFTq93Kl9fQpl3JxZrS5O0iToJI2Y135KifDRtrzPP2ZdvLd+3nAJwumyK1KyCCvCuxA19/b3p3ApQRqFyWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=JA4Q1Z/K; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1713295238; x=1713554438;
	bh=5qcKuUFEXJAj5jrbqiLvzMPkKKsc2Zpg7ofBMee6fJI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JA4Q1Z/Kfq2B9xCOZl1sB30t8BiUbqz3JtIqG/nmhdHw2stIKhIzySwnUjQcQm4kL
	 9N9SJYuq7PCb9aYxb1nlhNteCmK1zdd7GS0rNex0PeOlC4xWVz+8xVbFNv19q4+4Rt
	 /5CinoOCT60ubUyli1LBBD8mLjofcYW18Pb1+QzYPVzV6y1CvRwBZ6gj8Ct3pKaQf9
	 +NjP1OHduxgTeap1cKc23acEcgLGach0T+290OBH+3TxdsVN8oR0ChnawQPQWQq4oC
	 V00uRG5tuPM+EDZjFpXlJPdSPurYx6L52z5BE4H30RhY0zUW9dwTbqwIZmjG1/Un+3
	 br9YAx1Mg4AwA==
Date: Tue, 16 Apr 2024 19:20:18 +0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From: Michael Pratt <mcpratt@pm.me>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Wander Lairson Costa <wander@redhat.com>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Vamshi Gajjela <vamshigajjela@google.com>
Subject: Re: [PATCH v2 1/3] serial: core: Store fifo timeout again
Message-ID: <zTaajAZtS59Hv5offvbHJV1ptivBxD4WaZP_M-zQkicUtDb4mokpuKCFGIzUVL3p2yDSqHx9Uf2vIYVlbGeHN8xMJ6H3VWxwH3MPe1cH5a4=@pm.me>
In-Reply-To: <Zh7KV0FuM2B56J7w@smile.fi.intel.com>
References: <20240416182741.22514-1-mcpratt@pm.me> <20240416182741.22514-2-mcpratt@pm.me> <Zh7KV0FuM2B56J7w@smile.fi.intel.com>
Feedback-ID: 27397442:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Tuesday, April 16th, 2024 at 14:58, Andy Shevchenko <andriy.shevchenko@l=
inux.intel.com> wrote:

> ...
>=20
> > + if (port->fifosize > 1)
> > + port->timeout =3D uart_fifo_timeout(port);
>=20
>=20
> else
> port->timeout =3D port->frame_time;
>=20


Consistent with what I said in the other reply, the only reason that
I have an if statement here, is to avoid doing extra math for devices
without a fifo, as a specifically calculated timeout value would be useless
in those cases.

However, if you don't like the 10 ms default timeout, perhaps port->frame_t=
ime
could actually be a more reasonable default value? That is, provided that w=
e have a process
for calculating the proper value already in place...

>=20
> --
> With Best Regards,
> Andy Shevchenko



Thanks for taking a look :D

--
MCP

