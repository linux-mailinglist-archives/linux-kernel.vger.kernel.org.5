Return-Path: <linux-kernel+bounces-38955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED8B83C8F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AD01C2372F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA96133426;
	Thu, 25 Jan 2024 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cJ70+Uo4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H7AnADWU"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C62133409;
	Thu, 25 Jan 2024 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201305; cv=none; b=hUWj4eptoEF+oh5yzyV1nKFpQ69i5D1+T1Z/6K0yW2DZ46rKlnvGBJins0ukZIIXS9u2MHpBPSSCbepnBPxATb6pYwmT+++t5kf9dj3IgF6hp8dYLLUEyVoDhTCl+HNhZGLG9qb1hqjwOigguzFNKYNOiEo+XpaYZO+BZgdgVtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201305; c=relaxed/simple;
	bh=IRwJ0TMkwrUt/pbqRLgyTYDNt0RpyKyPLiKJWU0pKOY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=jgsNOtcWxZZMJS8z5JwtuuJt2a2/9kZfLP7Ww9lOo4hiWuhZ0hBtCLlXED502aYvt8F/hk/VIupBw8UPDYeKlNOaGvtphyBg8BLK4F96KJwKXCnAtLt9jT0RfSTU+Uiiy1911mVHNxjqv5LpF7jljlP8KwJSX/27N6R9Ljls5u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cJ70+Uo4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H7AnADWU; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 3655D3200AFB;
	Thu, 25 Jan 2024 11:48:22 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 25 Jan 2024 11:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706201301;
	 x=1706287701; bh=7RObLEsmqCUsuKu6leTIFIVyQ4Z62QVJOMWQ8jNtjjY=; b=
	cJ70+Uo46ietnMAzKmBUR1zehbq4uYCQXos0JapO3J04wLdUnhEfZlj4YUxPPAg8
	GFAOATWioJNivmbcs8hktjOzFeNyKvw+OSrZVRzuEkQvTMZ0vStfSNbQX6Tp8BOY
	ED0nqO//B0oHxNoi1ZJiIVvJbbaObziJmCu3qQdsITDDvcupr5WaE3M11Ix71z9t
	dXcXnmrFTbwdpccUPFJFiSWwUY2zD3mxKgJy3PscborZvvkk3llLBTXYmNDSMZV9
	OADoHcK9KdxiZpb8RQlRRLiWaO/AxaoRS9fZ9j+KOqNJbmuWT9RovVqW4js6ABdc
	PL8dy+cBv7xWpAA6cRHIEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706201301; x=
	1706287701; bh=7RObLEsmqCUsuKu6leTIFIVyQ4Z62QVJOMWQ8jNtjjY=; b=H
	7AnADWUn80T4NfwgQXzQE9E57BBsqQ1XTKHidubNzbHSOaFeD710YUmag9oIqiGR
	SzL8mBxVm1FG7eKZkcVF77W7QvHB9RlV/yjW8ttJDi5xRQXYSLeOXa0rEIv+E7Ai
	+N+iLNxPYH/8lYulHrYYwF0hVceHtr1jkCg0R8tUqpM1v431BiJrFRhSi4Ruxk93
	uK7NkMSqkLCjH1wj22cx1tBx4wdxXirX8M9M/IuaIPg2z1SBf1f3mqDymiF+c32Q
	Zjhtyn4aB0T1qbD7OJxjlsAdKv1l23ktn7PK6ntw7uM+tTw+Si+3u9nf2O4lSh9T
	pbbrOm4ZveVc/emZMRYrw==
X-ME-Sender: <xms:1ZCyZZu_m9agGzLlQ8qfJD6cZmnQ984BEtwC6hhW7C__FfAxF40bow>
    <xme:1ZCyZSfzT6MCJk76BgT04TX9oVjUC4thPO3dMF_yyhbBjI0QjJwh71YAg-jGXykPE
    VMOx0LwVEiv9kFPr-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelhecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfgjeev
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:1ZCyZczp006U4CnrXt2igNh3fOhYEiPqlQpRPEqugxjUqHMUjxbeoA>
    <xmx:1ZCyZQNAO6k3L9iBA9GM84UokYiKqUGh4uPA8z24XBb4so36kDjZWA>
    <xmx:1ZCyZZ-3xCIFWAN-6m75cZdEXRb9WVEbEDpD7yKNkBs_eg-Et4qGtQ>
    <xmx:1ZCyZSOVSNeC82OU3Og8y9onoxsQ8MS2AGoMPBYyzjkEIkce5cIbdQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 04612B6008D; Thu, 25 Jan 2024 11:48:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <63b3828d-8482-4435-9c98-50578bbbbe07@app.fastmail.com>
In-Reply-To: <10405963.nUPlyArG6x@terabithia>
References: <20240124004028.16826-1-zfigura@codeweavers.com>
 <CALCETrU+Eb5CdkqfYK8JvOiPA7K-6Bfs4uEWiu-U9oH95XfvKw@mail.gmail.com>
 <5907233.BlLQTPImNI@camazotz> <10405963.nUPlyArG6x@terabithia>
Date: Thu, 25 Jan 2024 17:47:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Elizabeth Figura" <zfigura@codeweavers.com>,
 "Andy Lutomirski" <luto@kernel.org>, wine-devel@winehq.org
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Wolfram Sang" <wsa@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Alexandre Julliard" <julliard@winehq.org>
Subject: Re: [RFC PATCH 1/9] ntsync: Introduce the ntsync driver and character device.
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024, at 04:42, Elizabeth Figura wrote:
> On Wednesday, 24 January 2024 16:56:23 CST Elizabeth Figura wrote:
>> On Wednesday, 24 January 2024 15:26:15 CST Andy Lutomirski wrote:
>> > On Tue, Jan 23, 2024 at 4:59=E2=80=AFPM Elizabeth Figura <zfigura@c=
odeweavers.com> wrote:
>>=20
>> [There is also a potential problem where some broken applications
>> create a million (literally) sync objects. Making these into files ru=
ns
>> into NOFILE. We did specifically push distributions and systemd to
>> increase those limits because an older solution *did* use eventfds and
>> *did* run into those limits. Since that push was successful I don't
>> know if this is *actually* a concern anymore, but avoiding files is
>> probably not a bad thing either.]
>
> Of course, looking at it from a kernel maintainer's perspective, it wo=
uldn't=20
> be insane to do this anyway. If we at some point do start to care abou=
t cross-
> process isolation in this way, or if another NT emulator wants to use =
this=20
> interface and does care about cross-process isolation, it'll be necess=
ary. At=20
> least it'd make sense to make them separate files even if we don't imp=
lement=20
> granular permission handling just yet.

I can think of a few other possible benefits of going with
per-mutex file descriptors:

- being able to use poll() for waiting on them individually in
  combination with other file descriptor based events (socket,
  signalfd, pidfd, ...)

- replacing your logic around xarray with something a bit
  simpler. As far as I can tell, your code is all correct here,
  but it would be easier to understand if it looked more like
  other code I'm familiar with.

> The main question is, is NOFILE a realistic concern, and what other pr=
oblems=20
> might there be, in terms of making these heavier objects? Besides memo=
ry usage=20
> I can't think of any, but of course I don't have much knowledge of thi=
s area.

I would think that RLIMIT_NOFILE is a sensible way of
managing this, at least this way it's possible to prevent
exhausting memory with too many mutexes, but still raising
the limit if you need more than whatever default one might
come up with.

     Arnd

