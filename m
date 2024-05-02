Return-Path: <linux-kernel+bounces-166805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF108B9FC6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FE7BB209C0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34E0171063;
	Thu,  2 May 2024 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="FlYyWJKE"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D9415B559;
	Thu,  2 May 2024 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672201; cv=none; b=Ma7/TZe1TaGFhe63cgKaj8Xnw1BO2/euQfV3xFtddnSssqQOtQA8G+ZnCMu0TJwpjvTOK+rui5CMmJNf6366XJ+UEhv9kJW6pUx2JuFKmGnJxIvRUcuBy7Dq5XgxKOf97gZUGjyHfkidMhgI5wqGrIfVYihLxzuDIQRxdw1TIDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672201; c=relaxed/simple;
	bh=36xbaZQK5rvL8AVLTc3xwwIoaFZkgtSgAllAbBJR660=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jviwjm7AxNQkm0Bb35E75Kd/M7FWgXb3UNkDtDHdaMOR9hDUwdp/+nyJhldibMOPuUI6+xiIhXxv1UNlINUvEulMO5VGTchF+LKVYmspsR02LZB4musjSVIn02Xyv7dFf8VBjW2zQbayLYBOBOVeg2wennSxe+rIAa6SqBQvlWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=FlYyWJKE; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1714672191; x=1715276991; i=parker@finest.io;
	bh=YVVNfIzw4NRqXyErxaTIu+r1IXsRrkuXQ6rRfu8a/Tk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FlYyWJKEFHrIl0P5k45TYXAPY1+5bw3jeQT8fCD5yX3OHPQIamuu93wlMfBOsT6c
	 wAdf3BRJ+eUAxLvb/P8Z+c38NLfdSJQVQxH1WIRDhfTaG6B71QdWiJAdZaIE9aQ8+
	 EGyfyvl6xra8gXOKAppKSRi6aFjqNiJKxzsmEvb5Ze5KoV/MCSb4T63hgZcVSzbkz
	 lm0zKiSnS/WWNV7hyHcfQj1osuf9QjCr7MxVpS3S7G5vjiyWJJYwlvsfdKPTjUtiW
	 on5nGmr7lbN76/IUVcPMsRTaOO4L/TglNR04vYkRtEhnI6ttgWa55wjxdTzK/6YVP
	 K/NWaBAq9OBPnSNNNw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MOznU-1sJ0yo3C16-00PMDN; Thu, 02 May 2024 19:49:50 +0200
Date: Thu, 2 May 2024 13:49:49 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <20240502134949.5e780635@SWDEV2.connecttech.local>
In-Reply-To: <ZjPL5z7ah-Qkct6l@smile.fi.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
	<20240502114645.4445b3da@SWDEV2.connecttech.local>
	<ZjO4vYEBzxU3fpzC@smile.fi.intel.com>
	<20240502120840.02c65f30@SWDEV2.connecttech.local>
	<ZjPL5z7ah-Qkct6l@smile.fi.intel.com>
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
X-Provags-ID: V03:K1:3xYxsYjrCIx+2Pq0JENutYfoErhLgbYQMKbjyqM4z7rX99TrIul
 hoPowlgSDIjXB8uiJYJNC55UZ13Chz+0QOUaEr0Y5nqLD5qIOW9AnYL3ft1y7e4gkadWyb/
 7GvEHSd5aM4u5LCDed4XOtydKVt7wFObcY4PTf5MEiRog6+MMATKzdTU0KV9v3N4c3VKcYT
 ErRHEmr8N6tqFCgn+p5uw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+bIjzS2iBZI=;UExRNUQgw6ik7VFbXAxSflRW0PK
 ge9BfOaEPX4xh03uQGRtU4dX1/oqEmxWfouVfy5wvTJfb6NqvGOxzGXPQUP9yTNBrx2DGQZG7
 /7jnTgE0ieOnOBa+7l19N4aeclF55eJncEW4fPet6Js2oGx96D5BDIs6uKxqNxr+b6mAANgjW
 l5PMGCOYP5qm7g7BoXbCNyHrlIVxQvROGXv7EtVdPrAJWSV1hSatay6FZXBYwDXvipUD0myi2
 Fr+Hu+S/unQ2tVL2U5TCWRhUQArquxTjAG87BZpTK0YeDhqkSv5+7LsMWX4dTEsoE6f7yuUh7
 2vq1R8NEOnaeEzpeNsnxwTQIR5WnCOvpTYT/4/hNraCZGkQFXTLPPGu8E29jn7kjL3x45Z3vq
 qcOqku+D+MQnoKsgRQAwQqo9kGmRqkMm1hPokHU6ErEa/1qbK0tXFaE2aEvl0GO7CHx0jUJCz
 AM+78rZuFhG0eo1gDq0Z83+GRkMKcxPYnD8fuZ2qAulmKBQNESgHB/xICPsYOZ4ta22rnKlcq
 j6cR55iqwcd4MZLm/OExmnyJgRcuhkeM4kc77wt5TKyDfnIhfI8mWS13VHqTMGPPqtOPLXIaq
 Q29v4mnhcTUM/i3oNOq0xDc4TSLuBbZF3bq5tUPgc7tBNc9FdZrDH4UUbgrMTwThKkXxDFmCl
 FIKWo4CxwZT+8is/CB8835hnAP1yO0Vk4obwC1HgvqvfgLY5J/kY8ou6xrEZp/ZP0zCXRuWcJ
 e5ngO1S4JcwQFVGVRfiLNTtPxvbgBp57iRUltqVoaWSOXxk+2Eiayk=

On Thu, 2 May 2024 20:22:47 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, May 02, 2024 at 12:08:40PM -0400, Parker Newman wrote:
> > On Thu, 2 May 2024 19:01:01 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, May 02, 2024 at 11:46:45AM -0400, Parker Newman wrote:
> > > > On Thu,  2 May 2024 17:43:54 +0300
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > > After a rework for CONNTECH was done, the driver may need a bit =
of
> > > > > love in order to become less verbose (in terms of indentation an=
d
> > > > > code duplication) and hence easier to read.
> > > > >
> > > > > This clean up series fixes a couple of (not so critical) issues =
and
> > > > > cleans up the recently added code. No functional change indented=
 by
> > > > > the cleaning up part.
> > > >
> > > > Just an FYI I submitted a patch series that fixed several of these=
 issues but I
> > > > think it fell through the cracks (I know everyone is very busy!).
> > > >
> > > > Link: https://lore.kernel.org/linux-serial/cover.1713533298.git.pn=
ewman@connecttech.com/
> > > >
> > > > I believe my previous patch series is no longer required. This one=
 fixes
> > > > everything.
> > >
> > > I haven't noticed that, if it contains duplicated patches, I may rep=
lace mine
> > > with yours if you insist.
> > >
> > > In any case it's better to reply there that you prefer this series t=
o be
> > > applied, so Greg will not pick it up.
> > >
> >
> > I do not have a preference. I am fine with using yours if it is easier=
 on
> > the maintainers.
>
> Up to you, there is no issue to take your patches in case they are the s=
ame
> (or quite similar) as mine. I can pick them up, just tell me if you want=
 this
> to happen with a list of the patches (as mail Message-Id).
>

Just use yours.
Thanks,
Parker

> > I will send a reply on my previous series that it is not needed and li=
nk
> > to this. I am new to the mailing lists so I didn't know what the proce=
dure
> > is for this situation.
>
> It's not about mailing lists, it's just a common sense.
>
> > Thanks for the fixes :),
>
> You are welcome!
>


