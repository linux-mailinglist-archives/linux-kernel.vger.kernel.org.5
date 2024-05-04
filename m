Return-Path: <linux-kernel+bounces-168442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6548BB8AA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E70FAB22195
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50DB15B3;
	Sat,  4 May 2024 00:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGIDu0fK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B2C629;
	Sat,  4 May 2024 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714782076; cv=none; b=I8Tc7ZTsBhO67jlQN69jyPzSSeU6gGqdtOzpMOLjG/hOokwNZ9YPLnshGsC8neQQ1dy8PtL0eXc8Nfrl3b+iz5PQboNKTEOYY0tPM50sn9jsJuR3krHi3rR7Qbp6NTwUGR1aqDXwphmDi9TtTmHTDXSgAyZy7zPyc0nVvljfWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714782076; c=relaxed/simple;
	bh=yP+2iZaNfuy4VuiXaL0zmGDR2KLSPl+3nYtHp/N/ijs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=ISl8wa9KkEWSEJbtU5FhT37b2pp9OCVeVO18z+O3eZ5tW5aNL8wu62Dz+CliDKF537oCCIfdXzVRp7Ow4LzBUZrnM3J0wJhX1kz3ui9fYW9HJOlS1siOHANQAxJFMQ1scYUGujoJlKZwuHtzy5vphYeN+lGCihv+MSz0CzEtj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGIDu0fK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63974C116B1;
	Sat,  4 May 2024 00:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714782075;
	bh=yP+2iZaNfuy4VuiXaL0zmGDR2KLSPl+3nYtHp/N/ijs=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=EGIDu0fKWx1Zl2N92TP+rsDvXkAkhZqdf9GL7Cm+4YShK+WmIMxu7Gl2CL4vWI+ta
	 KfkXiDzDr4563l3Kggxn4z2UzrdHWp3nLv9X1RY7g94bvy1hRvmoBi2W65hkxFEp0H
	 T1avmrYlz+DqzgBdzPd1W5fBmGLUUPFbirov00abDPXaVTC2bE8Ti3HzDbRixOmtd3
	 XCSe2NVnrJdhzjDEyqaRoHUfsAHOkGCI0jlzKgsEXhsnU7uhfYIznZ0bnKmrp4141F
	 oG8Jr3SggdnA+UpgAXvd3WkCGcR3sfuCj55c9XA3wo6qtjPWxTpD3fPKAuIBn2DII+
	 /+oUACdlC1O8g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 May 2024 03:21:11 +0300
Message-Id: <D10FIGJ84Q71.2VT5MH1VUDP0R@kernel.org>
To: "Ignat Korchagin" <ignat@cloudflare.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
In-Reply-To: <20240503221634.44274-1-ignat@cloudflare.com>

On Sat May 4, 2024 at 1:16 AM EEST, Ignat Korchagin wrote:
> TPM derived keys get their payload from an HMAC primary key in the owner
> hierarchy mixed with some metadata from the requesting process.

What metadata?
What is "the requesting process"?

>
> They are similar to trusted keys in the sense that the key security is ro=
oted
> in the TPM, but may provide easier key management for some use-cases.

Which use cases?

Two first paragraphs are confusers not motivators with three undefined asse=
ts.

> One inconvenience with trusted keys is that the cryptographic material sh=
ould
> be provided externally. This means either wrapping the key to the TPM on =
the
> executing system (which briefly exposes plaintext cryptographic material =
to
> userspace) or creating the wrapped blob externally, but then we need to g=
ather
> and transfer the TPM public key to the remote system, which may be a logi=
stical
> problem sometimes.

What are the *existential* issues?

You are start by inconviences with trusted keys without describing for
what the trusted keys are used for.


> Moreover, we need to store the wrapped key blob somewhere, and if we lose=
 it,
> the application cannot recover its data anymore.

I don't frankly understand what you are trying to say here. Somewhere is
not a place. It is an indeterministic entity.

>
> TPM derived keys may make key management for applications easier, especia=
lly on
> stateless systems as the application can always recreate its keys and the
> encrypted data is bound to the device and its TPM. They allow the applica=
tion
> to wrap/unwrap some data to the device without worrying too much about ke=
y
> management and provisioning. They are similar in a sense to device unique=
 keys
> present on many mobile devices and some IoT systems, but even better as e=
very
> application has its own unique device key.

Does it or does it not make it easier? Please decide.

That said hard fine from mainline perspective unless there is an
existential issue.

>
> It is also easy to quickly "wipe" all the application keys by just resett=
ing
> the TPM owner hierarchy.
>
> It is worth mentioning that this functionality can be implemented in user=
space
> as a /sbin/request-key plugin. However, the advantage of the in-kernel
> implementation is that the derived key material never leaves the kernel s=
pace
> (unless explicitly read into userspace with proper permissions).

Please describe the implementation with request-key in the context of
the use case where it is used. That is what this should have started.
Then the motivation. Then the proposal for solution. And also focus
only on existential factors.

I have no idea for what the key created with this is even used, which
makes this impossible to review.

BR, Jarkko

