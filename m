Return-Path: <linux-kernel+bounces-167643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181A08BAC99
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437DF1C213C6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FA115219B;
	Fri,  3 May 2024 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="FNAgmZVE"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E8128F5;
	Fri,  3 May 2024 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714739810; cv=none; b=IJn/lQMJ5ax5EzvzwA3aYLXzYjeSlae3epHcaZIJOWlLZtoQ9zAkHnoRZ2t8JVmwTzW9dBFr8utXXvNtQoDbruEm8OQNFVnx9E2VVfEeOBFFuxnomKGdUxatdqcdYx58IRoDrNqa1W4Rk3oTUi7lspwZ24ErI7jWVBevXGcBJv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714739810; c=relaxed/simple;
	bh=nXZwx6IVJMBUefq5xdQYjmzDRIJO0v+73VppqwXi8oY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SukCMBSo0+ujholigsqmCKSyWH0wpT2Xlmsy2inSosLc9UdC6pueqypeAnjVxMbMp3DtGLBXcQqKWDYnL6D0i9Mf0RM6gXRZ1Xfjlr4RChiU4b2HBCJL0/RcIQYQH1TdS5CEZFmn8vgJ/IPInfIzf1R8c+UZFid2w8jlTIiiLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=FNAgmZVE; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1714739800; x=1715344600; i=parker@finest.io;
	bh=LPHhZm5lowvrZny9uJ95Cq5UJFclBqQhK3jaWOkbXOI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FNAgmZVEZ/orShUL7OL8sfx3sPurnAzvRjAn7KBacU5F10Rzm103golGxICUUB5B
	 QKQRheBvnEN53kSh3jA8tp/yfB/aSmIHsmWQW5+pCnYM/ctpb6/SQGsVY9cG8Czxh
	 fxyxev4g9GV62wL57rlIr8ogMltMOgzgpKQWyUZO6TQ2uk1++o/8OyNQ8TrJEXfRc
	 6MycymvBk3d69xMfwci/Cs++qr19qd4Ib7e9M5Ss7VFHH8fh/vPTNqnmXEbkze192
	 dtOuMLJ+6JIbyOLDEZwwbJqinwrflZgokjCMXSNZGmNTAWP/m3PKMLpqMUhlws3CI
	 306Qop0yDfljSrV4Hg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0M3z4W-1su0jq2fD8-00rZ6e; Fri, 03 May 2024 14:36:40 +0200
Date: Fri, 3 May 2024 08:36:38 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <20240503083638.0f8d9afb@SWDEV2.connecttech.local>
In-Reply-To: <ZjPVEr7D0lEf86kQ@smile.fi.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
	<20240502114645.4445b3da@SWDEV2.connecttech.local>
	<ZjO4vYEBzxU3fpzC@smile.fi.intel.com>
	<20240502120840.02c65f30@SWDEV2.connecttech.local>
	<ZjPL5z7ah-Qkct6l@smile.fi.intel.com>
	<20240502134949.5e780635@SWDEV2.connecttech.local>
	<ZjPVEr7D0lEf86kQ@smile.fi.intel.com>
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
X-Provags-ID: V03:K1:n6/uzA2IhZbVt2TgRaG7NyI/MlOCAXoi9/8kT6hEFaqRH/NC3VZ
 QInZr2mb9GSRUWHP82V7ASj9KQhTYkF5B1uacj8gipX0langyvY6v5oRNBpFVvIWGy10+Nk
 +pKxEr5g+CzJgPmure6SaTGHUJLCxuQ1bZQZu4UbY+A7NJ0yanwNoNM1xn024910V5WS2/b
 pza/H6Vc9BMROZ8St3ZCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y80D4vzoXK8=;wqrCnw9oWycvF2C1VXvSnRUeY2O
 2UQenEnZ5DBZ69bOXzzeM347nuuR+yPYrVZ2rT4V61xVu+tya3C7LO2W9x0WKi9FX5YdnBSS5
 /NEPilaLmPfbZu7h1CE7xOATDIDGSNg5VYaNCRHVEA0Pz1LvINl+CiSOENFqSOhKiO86rUT3g
 LBvPDsooqSRaRuI9DdKpnFs3IkutqtJOcV9MJB95t2736SmPX69go+vBtPJh67KnhudNo/nJb
 SwmiERK5OgAR84PsxFxibxlIwG7JSCCmkl9squG6bBXhpmrDMjLJBLKMu6iDJrRHbhpj0Dwwn
 jbcGVeYu/9jH1rHARsPnb55FLIJM1UlrDcUTbmKVsxs5nfprZHNjAo/Fw0Jo2rppq6+5k1t8S
 uvC+If+31ZpKdjfCes7YRLgvM4k8dPBr8ju1LIElosiM4q5LCt+rffOKFbwWpCFJetGHHDlPh
 3DKAEP4Atz3iRe47gi7yKIk/9+3UNES4eghY5RrRLhGCmajNImaqclpyTv0BBU2MqDL0r5p0x
 0W6erUMd75ARsxkcqQNbhapDLtkNUPAJGeaCyodIGk+3lqngAGVr7dgjycqiVOpDdRXv+ghj2
 8hyUGV1/gdyWjFDwlGndrkc0AziOGGyrNNzpOCtV9e+I/grl2x+HUJHI4D5T5Tw1sJskPldMi
 xUW/oj6NDbP7LWKV4v1b5gfv6mRNo15a+fD8nlsQ5U38lM9jEp7XSgYZnuDbGiLzZFjCCMIYX
 dw1/byrpKxPQmndO60p5Vtd+VLxenL06j6Xo2Wx+R5BwQOm5KkADzk=

On Thu, 2 May 2024 21:01:54 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, May 02, 2024 at 01:49:49PM -0400, Parker Newman wrote:
> > On Thu, 2 May 2024 20:22:47 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, May 02, 2024 at 12:08:40PM -0400, Parker Newman wrote:
> > > > On Thu, 2 May 2024 19:01:01 +0300
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Thu, May 02, 2024 at 11:46:45AM -0400, Parker Newman wrote:
> > > > > > On Thu,  2 May 2024 17:43:54 +0300
> > > > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > >
> > > > > > > After a rework for CONNTECH was done, the driver may need a =
bit of
> > > > > > > love in order to become less verbose (in terms of indentatio=
n and
> > > > > > > code duplication) and hence easier to read.
> > > > > > >
> > > > > > > This clean up series fixes a couple of (not so critical) iss=
ues and
> > > > > > > cleans up the recently added code. No functional change inde=
nted by
> > > > > > > the cleaning up part.
> > > > > >
> > > > > > Just an FYI I submitted a patch series that fixed several of t=
hese issues but I
> > > > > > think it fell through the cracks (I know everyone is very busy=
!).
> > > > > >
> > > > > > Link: https://lore.kernel.org/linux-serial/cover.1713533298.gi=
t.pnewman@connecttech.com/
> > > > > >
> > > > > > I believe my previous patch series is no longer required. This=
 one fixes
> > > > > > everything.
> > > > >
> > > > > I haven't noticed that, if it contains duplicated patches, I may=
 replace mine
> > > > > with yours if you insist.
> > > > >
> > > > > In any case it's better to reply there that you prefer this seri=
es to be
> > > > > applied, so Greg will not pick it up.
> > > > >
> > > >
> > > > I do not have a preference. I am fine with using yours if it is ea=
sier on
> > > > the maintainers.
> > >
> > > Up to you, there is no issue to take your patches in case they are t=
he same
> > > (or quite similar) as mine. I can pick them up, just tell me if you =
want this
> > > to happen with a list of the patches (as mail Message-Id).
> >
> > Just use yours.
>
> Okay, thanks!
>
> If you are going to test, better to pay attention to the BIT() conversio=
n patch
> as Ilpo noted an issue. I believe it's easy to drop (via local git-rebas=
e run)
> or move and test separately.
>

I am working on testing now but patches 7 and 12 did not apply with git am=
.
Both failed around lines 1095/1096.
I can apply them manually but I may be using the wrong branch (tty-next).
Which branch/commit did you create your patches from? I don't see it in th=
e
patch submission.

