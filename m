Return-Path: <linux-kernel+bounces-33143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C48C983652F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D821F23ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5940D3D392;
	Mon, 22 Jan 2024 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VAn/Wbtl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l4dpU6qq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C3E3D0C9;
	Mon, 22 Jan 2024 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932728; cv=none; b=X/9qzKUaXf+5rL5i5sixKv6DKGzTTKCtd39wDgs7GHM5krHvn3XT4F5NpP6CY3apUSdW9uWWne0A8VyBrLChBIs/0dBVKEQjkjE0SrrRc77IQ8yGOre7sCXLkMofKGiIWj3WTgfX1qUoNzzJSa7F8xmozmxXjh5KZ1EB6zO46rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932728; c=relaxed/simple;
	bh=1FgSBCt8MGeNgIiZjDNRRNW3t32Gf8a5iOJcBW3pu2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKPKyxdqTnJlrC6dXbShLVJ3qM/251cbXwj0Ay/uEzDFX8zk5kqoslbb8Xb/5+Cfp1Ql5+uXe3M/RMjMqe5W/YKiLAsqD85teECN8dkeQ9f0ZtCMnYEas7F1HV7jMw0fvj0AwH8WCcaGNIZYQFotAg+U9mrLSaJ7+DYHdrFzVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VAn/Wbtl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l4dpU6qq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Jan 2024 15:12:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705932725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FgSBCt8MGeNgIiZjDNRRNW3t32Gf8a5iOJcBW3pu2U=;
	b=VAn/Wbtllja7Cb8dL8rDv+MCQW8iMWLsAvcH0o8TF4VBsOeajiEnekeUP6t9KId7suVGn/
	cWFAcf8VB5zeiB5i3YR2CFvaohqUXeWtru9SHrp1pOMpZR5Z/fRwjpXfQB49LqknTQ30v5
	tiGxP6Bft1ObRJVm6yWMcTomg5y133ozkotsY2F1oM2P3cjsY9yzYgBsQ3fVN56C0kiNuH
	1glGi8ABd+RmdqO2Pw2uI/h0fjD4PfDjV+6GryMx4g4kmRheJMe+AtikpP8ZIyTx322axQ
	kiqDqgom7WGhSgr6xVsJk17piADCnXaZ+g1rWX/io0sDQDmV/I7eRH9holtblA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705932725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FgSBCt8MGeNgIiZjDNRRNW3t32Gf8a5iOJcBW3pu2U=;
	b=l4dpU6qqZkC7kAGMhLlninKdAaGtv1RzLQoAyhcSE4PBWEKxYpERziD9VTsZUZiij95Sj3
	bahdfQiZHM5lAhAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Nicolas Schier <n.schier@avm.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: resolve symlinks for O= properly
Message-ID: <20240122141203.CWe3n5rG@linutronix.de>
References: <20231215160637.842748-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231215160637.842748-1-masahiroy@kernel.org>

On 2023-12-16 01:06:37 [+0900], Masahiro Yamada wrote:
=E2=80=A6
> Using the physical directory structure for the O=3D option seems more
> reasonable.
>=20
> The comment says "expand a shell special character '~'", but it has
> already been expanded to the home directory in the command line.

It might have been expanded, it might have not been expanded. Having a
shell script:
| #!/bin/sh
|=20
| exec make O=3D~/scratch/mk-check defconfig

with bin/sh =3D dash results in:

| make[1]: Entering directory '/home/bigeasy/linux/~/scratch/mk-check'

while bin/sh =3D bash expands the ~ properly before for O=3D. Would it be
too much to ask, to expand the ~?

Sebastian

