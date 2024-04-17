Return-Path: <linux-kernel+bounces-148571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6440A8A8491
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4E0DB24112
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B779140369;
	Wed, 17 Apr 2024 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="Hpe5VNQK"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF7613FD6B;
	Wed, 17 Apr 2024 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360421; cv=none; b=n8TWeM+pnxd2QkldPVw5Io9v/BtAGD4qZD0bt+aynAciNJtHRjXQ784qj0LpPriC0R10NuE2BPaithK7ZtQQsZUyvXa0J0CKRhWatPdJDOI1JU+ETSBmlsQAEX1AXtX9U5nDs91oajQjw/nnDQC/HGeDPYDkPwoistyD7wylPIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360421; c=relaxed/simple;
	bh=7unMVTWULZZOIkOrGq6pLfL+TykuSYcel8/gJQZ184M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNGmCvSVhO1M8sjopSHff8+NZEzRlEwdlku602ZU4Pq/RwAlQJkZll9mvWGOk/+E7NS/UMji3GxFegVHRZ5X/JOpKCCtFY+U8xzawLpqAow5i8Ilob+YXwqZpbcIvH7AMmmjNn0OIMaGptI7WmkQ0jRbbGIQd7egT7mnAXWElko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=Hpe5VNQK; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713360403; x=1713965203; i=parker@finest.io;
	bh=AFZKecGzkiP2XXDBRScWjkWab63jreNlaaFDY4qgss0=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Hpe5VNQKCeuDLtK97VSgj08HOMNDabkoSoe4LpY+dFx/yBX0a7MfUea/oU80P8ns
	 Yr6hqOQUyHD+lURxm1LKKRKr92Pbv2E9dHQiEgKvoh7GdKd0gNwu00Hep/EGm6oax
	 1KO838PBmpQePT/Zp2AvyrDnxWB7wuJD9Zv9XHNd3nAYJK3f46obE1xFGhH82+CW0
	 hE8AlhlROqxEz6El5Yj6h1fnwqzR496RqP8yagumuz1+80Janet87SrAhtzXSEglK
	 3HvW6vq0cK0btfTtNLaDQK6qvCRY/oITxO0f7aP4kHfCYIZPQtsRTtt9iVECC+4Cr
	 qXqu4KcHHMJw1l4RLQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MXJY3-1sHgjX3wVZ-00WByr; Wed, 17 Apr 2024 15:26:43 +0200
Date: Wed, 17 Apr 2024 09:26:41 -0400
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v3 0/8] serial: exar: add Connect Tech serial cards to
 Exar driver
Message-ID: <20240417092641.6f7dacd8@SWDEV2.connecttech.local>
In-Reply-To: <2024041723-abroad-jugular-89db@gregkh>
References: <cover.1713270624.git.pnewman@connecttech.com>
	<2024041723-abroad-jugular-89db@gregkh>
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
X-Provags-ID: V03:K1:9u3K2h5p0zTgP3oeh/SDVSme7udVSX7hLs5Czj2AcWKpcd5VD1j
 2zaz3G0gvSiGTBI7CMVK7rOVZ6Q8qhdm3hDeIPCKexxnU0EI0kl1CnwttAgy2AVI3WRbzIs
 w6SdQ0WozK3pP0cKfrKOyG6WRmyI7JekNs0kjmbVkXK0n0jOhqLSMrbnZgpgRpwl8lryUn5
 LHExE/ln/OaN7Oy+ld0NQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oVscr/TTaYk=;dPXq/yaKkJGvKfb5sCIKs7JY4jl
 j+J9IgQQ8PiPOrVv1C+457LFJVgt0DaxTZl36dQ+ldW9SInC16F8VN4O0yixrOQrJMMHrkwtH
 ul8Qpr3x2ebQjaUr/s0c43lP7l1DpTgjca/QyWh/lReqc7mB9AcWLaXVa/xHlsJPiR6TAchP/
 OkzamWls4ny4/onJOFNtevAyH/XMzjyPBSwksWnUSm0iRxsYCaZeaXBaND6PYBMg7aew+gdDE
 3YYt03ooR8VZYP+dZ+f/uIuzO+ysXWyZEN2Ca2surl/8mRSNwRaqsa5kZcOjz6jWlaMgnItZc
 GxpmAKkiYcrVaLQvuydSTJzi9h1KVaV88QT2SrxxT3RlIBtPJxTTA/+tUZw13JgKjnS/S6HJm
 DmlsjQLif95cnW1EAuMU3+A3iRrkzEsCH7ndOhx+sCANun2Zgp3mf02teCwM/+KXMCxvWofqh
 42nhX6HA0mz5CLQ4EYbjyYQB5UNNeXiCukUVsPsm9LO5o8bodakSW1Zn4Al2qva74MGZfTK/P
 1kjOM3FxluxNVgPG8kq/HPUG9ze9nJhCLNPtXKAnRyccaP4GgbBzIqn24+zammo856HKLMvCY
 /sz3+imLAc4JTuOC3apwGFFMpoqVAG8dKtXek7zDBD00NgdzdjlOC5pNDDbaTXoJKAff3EJyO
 MtO9lVkcR8rSr/r34vj5Pjnt94Pt0N4/kOiucqW77jhvLf60k9r3W/2hckHp5nfjOAQ6WlukU
 jPcusEpAfpwPZPKW0SUaK8zv3wiyJhZJ4r8zYuve4zfykXwqfn1ny8=

On Wed, 17 Apr 2024 13:24:49 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Apr 16, 2024 at 08:55:27AM -0400, Parker Newman wrote:
> > From: Parker Newman <pnewman@connecttech.com>
> >
> > Hello,
> > These patches add proper support for most of Connect Tech's (CTI) Exar
> > based serial cards. Previously, only a subset of CTI's cards would wor=
k
> > with the Exar driver while the rest required the CTI out-of-tree drive=
r.
> > These patches are intended to phase out the out-of-tree driver.
> >
> > I am new to the mailing lists and contributing to the kernel so please
> > let me know if I have made any mistakes or if you have any feedback.
>
> Much better.  I took the 1st patch already in my tree to make it
> hopefully easire for you to rebase and redo the rest.
>
> thanks,
>
> greg k-h

I will resend with the updates.
I have been using the "main" branch of gregkh/tty.git so far. Is that corr=
ect?
Or should I be using "tty-testing"?

Thanks again for bearing with me while I figure this out :).
Parker

