Return-Path: <linux-kernel+bounces-104485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29B887CE8D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F64A1C20949
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82669376F3;
	Fri, 15 Mar 2024 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yFl2fyCm"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1056637167;
	Fri, 15 Mar 2024 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710511937; cv=none; b=I9cHPRsXJuXbkEUzlUYHwxG/7oj8gcvV1SfQd+YhWkTwXzNQSiX7CMPOW9V9sVceveNUga6yp58B+HpF59Kqx0w3m7EMKti6EcN9FQF9+uXmHJVzLmoS59JGYEUtSlFzAUCZ6zxIXF/K0uO0N7XRXYrwFOFmT/fxfah+A0M6/Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710511937; c=relaxed/simple;
	bh=lDggbsGVPM1jhhJN1V2iUjTn/te3NkJhRIw7wWD1fBw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E/SkCXJa/rKSEGZlmLFE5agDU+U0tmEQFAElyCmAe2hK0FUTyrjmws8UCGROTw9GivrcT0OSJhgP7vF0ydx5eDxnyqU1YRNavP5uVFDjZkQQpOzn1j2cstje7HFqx/K/GspUEUNf4nR9JS1Iw7z0rgu7LHoMrllmKf/GL5NR1oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=yFl2fyCm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PyFfX2uCch2/EAvx8/2qfWz35TKluRnYnWc6BnNUd0I=;
	t=1710511935; x=1711721535; b=yFl2fyCmK7OeTFI4awpLGOED4bf6dhznOM8Pl5YG0rEzNxd
	CBNYd1pG6fHq36KF61FgiPMEEWATPF3c9E0mmU+2lxWHLUpCgtsTlRkXn9mWYEGfMVr1X+lqjWH2w
	XzvL+7vGCH3REdt2qHCv8knwr4YnIEqcJhlKUVgx/ZTDNnXB//YJoQLfbmNMayiEojLO28K6pNBus
	pwuIkJs/x4gCvkfgHswdRnHc/7Zp90uNIui7lZrcPpMA4ReCEDaaTuFgcQ+9B+GueHKTabFlFjI7n
	BlW6VbcL5VxOP4a0YUK8Rz1oq+82eAAWm4Jb3kWiWrz3mRllLZMpgtoh7GHmMq4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rl7r8-00000000LJF-0jgH;
	Fri, 15 Mar 2024 14:44:18 +0100
Message-ID: <66994d628df70a5ff535908efc16568d3a5a4c80.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v3 0/2] rust: crates in other kernel directories
From: Johannes Berg <johannes@sipsolutions.net>
To: Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida
 Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Date: Fri, 15 Mar 2024 14:44:16 +0100
In-Reply-To: <20231104211213.225891-1-yakoyoku@gmail.com>
References: <20231104211213.225891-1-yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

So I realize this is an old patch, but I didn't find another version,
and discussions seemed ongoing at least a month ago. I also came across
it pretty randomly.

Anyway, question:

> If you want to use a crate with your Rust module just add a `rust-libs`
> variable in your Makefile with a value of the relative directory of
> said crate plus its name, e.g.
>=20
>     # Link with the foo crate
>     rust-libs +=3D ../path/to/foo

Should this perhaps be relative to the kernel's root dir instead?=C2=A0

If I'm reading this correctly, then a hypothetical rust wireless driver
that lives in

  drivers/net/wireless/<vendor>/<name>/

using some wireless rust infrastructure would probably end up with
something like

  rust-libs +=3D ../../../../../net/mac80211/rust/

or whatever, which seems rather odd vs.

  rust-libs +=3D net/mac80211/rust/

Seems to me that chances are that subsystems/drivers that have rust
infrastructure will not necessarily have them close to each other, like
in this example?

You have this in the sample too:

+rust-libs					:=3D ../../drivers/usb/core/usb

but it's less pronounced since it's just samples/rust/ :)

johannes

