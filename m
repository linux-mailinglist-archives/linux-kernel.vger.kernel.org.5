Return-Path: <linux-kernel+bounces-166661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EB08B9DBB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E96F282D1B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AA515B56A;
	Thu,  2 May 2024 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="G8G8RJMr"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A53C15B0EB;
	Thu,  2 May 2024 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714664817; cv=none; b=Wm2RACK55shu4bEFP/ta2Esln897GouoQR5T2ICyCrNxbp0i/lYHBl8NeGndJsuTLHvT3Ta0kAyyd1JvLEC8iAIJXRJQFnGVWK9fxOSsdqTQ9G3Z+Rdre62qrsZWKgDgyRpYnOewob4Lhqz3YHHVrSYG6oeKXYeny958bzPASq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714664817; c=relaxed/simple;
	bh=oRLMPIRmH0L3S4dLlbRn+CFDlEccLEbdESTmdU7+6h8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I9/gkCLidWLmyL3OTKDmx9mD8+EzeCfb6T3EOGj+2gI/aRLBQFpdyNeQFLQUBko/GaL4UDa9m+c+agLmKO2j025LsRdJeTL3ZHJuzzZkCiliSVma8MN6m18txlxsVdsjjCdiFNQ9UNG/R3Ckf+d8RStnG/k8Oef3HVeD5gbk+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=G8G8RJMr; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1714664806; x=1715269606; i=parker@finest.io;
	bh=JuKFKEC+LOJ7wPWjlDBwr8Xf3q9SXwvqF/zqeP3+MSA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=G8G8RJMrcd2Q/0dLVixk6qFEW6bidnn+dYgAr7dFY8M2MT4MpYcfnr2TfTAj1KcQ
	 BVoYJC6Ngd97R4cBYXe2nlayMzb9jUUNZOl+ggTu2tgVL/UsMP6ME6AoRTOFVlxuC
	 HaDszz92vBRRpzse71TrOdqwqdcQYcilJxr6tLZbcGH+AO1xD/HIOwEqbXKrtXJtG
	 N65c2vtOzHyYXxxfIqiIZ2J6w7XkGpCdmr0RroUiOZhfmk2VEu2zj4ewCCZcHtlSc
	 QQiQhSPr8silUT0VEm7dB7GCaKNItk2wn+gQm1S8aCLc+V9qFXo0MHivZhARrsb5+
	 H76pv6WjIG8XMKtz5Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0M0fUG-1sw2g41qT0-00vW79; Thu, 02 May 2024 17:46:46 +0200
Date: Thu, 2 May 2024 11:46:45 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <20240502114645.4445b3da@SWDEV2.connecttech.local>
In-Reply-To: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y74OxBTAuylE00jMhbQ+7GrgtTwVdQXjzPk6Le7tnxMZq1nX3R1
 xxpBdGblpwAUDywlWku12+fNoYHMJtTtCacsSL3ZUutUDmK1hlDvZuyHyRmNL2einqsdTOu
 2L/SrrldRLxykNyKoL1f6PDMs/kPiqztsa69nnkG+umBMurtML+GoL8omDzQVVysnSWco/P
 l9Hxfexhs5ScQb52h1pjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hUf6SGK8ArE=;8MKunMbe28rzhoUqEhj7QoMoIdz
 sPM/AB57bT1OVXl/N+rx7/BpwPwapdXs03aYt6He3Vmqxcrdff6+EMqz0cxnYWp0d6fVgDIxq
 P9NdJ37dCL3jGyTaeP7XTa5C174vkwFKdmowc1BoNKkSoBQNUk1ti766qIM6+kHTIprbhrIWT
 rc7nFrKodGBpH6hMWq7/aNKfN8I+ZPAU6adHXQdOUCabmh2QNuI+PFC/D/WGJoESiaeFuTzkO
 wDtZq4ocnp70mGKzenVJO7XB/W/4X9Fw3GK+K7tNNSUSamBq4bmNWWOs8fXDU7eNVH1NTuGRO
 VrfNKsbr6NiVL6W69VGrt7cqFfusL/0a+wMq/2PYGj/cVFH1YoG95t1qpyEVUk/DA+13Z4ctr
 d0fBP6/gZE2W4ppBf8iuPIzwbJ2JaaWD7s8eKYgUFZaDarQ8LPcpWSI9wZIJemgTMKq/BPoju
 CeMjAubs3H02sqy9StRTRuCvVgPHBAGieekky8djzX8zIc3mqRUzEjqNTWMfxjnNqhR60VGhH
 2VNMCg5tsiY8gpak5pbexkQOgaYveAeEvhdzL+36I9y0jayh3zw9UD6XQY6UAJdPICciMV22Y
 qB22ii00stbLeyAtfN0miN5CJN1C7J71ZRliKPHHkhf3su0/YVxUFjT/RsQTSEZWgNiigVvJN
 CkRQLW9RqLPbv4kKZLmNLddO8M17+VS8mUby3SwSoswIUACywHNNHGnTiA/2plkWc/67Bvbo/
 8xQvPUpb3NfOQZffMyL9TlmZgCfqZ58IS0iAaROyAMmx8vo/1EfcTE=

On Thu,  2 May 2024 17:43:54 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> After a rework for CONNTECH was done, the driver may need a bit of
> love in order to become less verbose (in terms of indentation and
> code duplication) and hence easier to read.
>
> This clean up series fixes a couple of (not so critical) issues and
> cleans up the recently added code. No functional change indented by
> the cleaning up part.
>

Just an FYI I submitted a patch series that fixed several of these issues =
but I
think it fell through the cracks (I know everyone is very busy!).

Link: https://lore.kernel.org/linux-serial/cover.1713533298.git.pnewman@co=
nnecttech.com/

I believe my previous patch series is no longer required. This one fixes
everything.

Thanks,
Parker

> Andy Shevchenko (13):
>   serial: 8250_exar: Don't return positive values as error codes
>   serial: 8250_exar: Describe all parameters in kernel doc
>   serial: 8250_exar: Kill CTI_PCI_DEVICE()
>   serial: 8250_exar: Use PCI_SUBVENDOR_ID_IBM for subvendor ID
>   serial: 8250_exar: Trivia typo fixes
>   serial: 8250_exar: Extract cti_board_init_osc_freq() helper
>   serial: 8250_exar: Kill unneeded ->board_init()
>   serial: 8250_exar: Decrease indentation level
>   serial: 8250_exar: Return directly from switch-cases
>   serial: 8250_exar: Switch to use dev_err_probe()
>   serial: 8250_exar: Use BIT() in exar_ee_read()
>   serial: 8250_exar: Make type of bit the same in exar_ee_*_bit()
>   serial: 8250_exar: Keep the includes sorted
>
>  drivers/tty/serial/8250/8250_exar.c | 454 ++++++++++++----------------
>  1 file changed, 200 insertions(+), 254 deletions(-)
>


