Return-Path: <linux-kernel+bounces-65550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB36A854E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5381F22487
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CE160BA8;
	Wed, 14 Feb 2024 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="ncSNmTFH"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CFC2E3FD;
	Wed, 14 Feb 2024 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928282; cv=none; b=K0gssFFeSpPzYQ+khkCUeP12WhnFoAhgRDq6xO4yhOWGIRHh0EY49JyMf4ex1mzUeLzRE3yIdJ57Rf5cSvSsN/7+6qMR1/vCV3RBNUlldx292jwnl7xWvGvPupHCl0pCJ3QvjKzEpNd8AVlGSsGDMqTJxkMH53ryU5zycF7zdT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928282; c=relaxed/simple;
	bh=j+BTeatZZlf1h9pl+OsDVOfCSlmG99/+7fK0HV5XrIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLFTLGuvq5UOyhJyCSOh3ZFZEeZA30VIi8c7z4a3TTrh1hrrLPYZ3f8NKC7duZnfqsF7/RIhph4lW6NIhySZ90konZQ0/R4go6GVLmq7tTzIRyDzpTaR1c3/B9hZ7CGyfLGfzR30QhXrYvUBwsWewiEGBUZ5oUf2zT2F1FQRaxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=ncSNmTFH; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id D27391A2E9E;
	Wed, 14 Feb 2024 17:31:13 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1707928274; bh=j+BTeatZZlf1h9pl+OsDVOfCSlmG99/+7fK0HV5XrIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ncSNmTFHLJBf2f3Iy6uzxBbQWC3Imeomo/GUJ524Kz418qGLs366OJ7P06cdfu7xh
	 1A7ifrfNxDqyo1HQ6W/Hw9kpapCU8BocN6elIuysMWLswEisfTxkB24TCvcM2Uez78
	 nrrN+RGpWtVklfLfu6axfJ89ihttLC6rmZ0yzBGbolVbMZkNMqLIr9FMqh6H6Nmk8e
	 eBH56GDA++NDthFKVf+RuQGtrkMxLraejRphC7tRqI4vCsDwe43R5mu+oYXEGiR1Ov
	 G2LGoifR2/X52qlkWryvxEwMfV8ZJqx28SMFxl+SFp15N9EhGb0/xKfj8wn0IiYIR6
	 esxRE4Z054p2g==
Date: Wed, 14 Feb 2024 17:31:12 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Tesarik
 <petrtesarik@huaweicloud.com>, Jonathan Corbet <corbet@lwn.net>, David
 Kaplan <david.kaplan@amd.com>, Larry Dewey <larry.dewey@amd.com>, Elena
 Reshetova <elena.reshetova@intel.com>, Carlos Bilbao
 <carlos.bilbao@amd.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Petr Mladek <pmladek@suse.com>, "Paul
 E. McKenney" <paulmck@kernel.org>, Eric DeVolder
 <eric.devolder@oracle.com>, Marc =?UTF-8?B?QXVyw6hsZQ==?= La France
 <tsi@tuyoix.net>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Nhat Pham
 <nphamcs@gmail.com>, "Christian Brauner (Microsoft)" <brauner@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Guenter Roeck <groeck@chromium.org>, Mike Christie
 <michael.christie@oracle.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Maninder Singh <maninder1.s@samsung.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH v1 5/5] sbm: SandBox Mode documentation
Message-ID: <20240214173112.138e0e29@meshulam.tesarici.cz>
In-Reply-To: <2024021415-jokester-cackle-2923@gregkh>
References: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
	<20240214113035.2117-6-petrtesarik@huaweicloud.com>
	<20240214053053.982b48d993ae99dad1d59020@linux-foundation.org>
	<2024021425-audition-expand-2901@gregkh>
	<20240214155524.719ffb15@meshulam.tesarici.cz>
	<2024021415-jokester-cackle-2923@gregkh>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 16:11:05 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Feb 14, 2024 at 03:55:24PM +0100, Petr Tesa=C5=99=C3=ADk wrote:
> > OK, so why didn't I send the whole thing?
> >=20
> > Decomposition of the kernel requires many more changes, e.g. in linker
> > scripts. Some of them depend on this patch series. Before I go and
> > clean up my code into something that can be submitted, I want to get
> > feedback from guys like you, to know if the whole idea would be even
> > considered, aka "Fail Fast". =20
>=20
> We can't honestly consider this portion without seeing how it would
> work, as we don't even see a working implementation that uses it to
> verify it at all.
>=20
> The joy of adding new frameworks is that you need a user before anyone
> can spend the time to review it, sorry.

Thank your for a quick assessment. Will it be sufficient if I send some
code for illustration (with some quick&dirty hacks to bridge the gaps),
or do you need clean and nice kernel code?

Petr T

