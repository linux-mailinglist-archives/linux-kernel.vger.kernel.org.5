Return-Path: <linux-kernel+bounces-97792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082E6876F76
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEAE1F21838
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 07:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673C536AE7;
	Sat,  9 Mar 2024 07:02:25 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC02E64C;
	Sat,  9 Mar 2024 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709967745; cv=none; b=Ne1VSLOKUoj/+ReXPaTwX36UkZVbq5NCf11CAx8u5JAGJ5yOl3g7AnZ5r9NUoR3RDLscvFQh+bz4OnqezeTNixvu3cKaP3d9U1gLLA7ItMsPJZWBSBq6Sig03Y+a7AVeOLopnTSh9n5IQsJVqsqHlCop/edQY/K6lqVn+IEm2Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709967745; c=relaxed/simple;
	bh=fcqIP1aDsDuKHBodo8lkda9HYuh11qM+q2IRi1pwpoc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LrulIMAdykeQ+XS0ieBfEx+F20jPKL708e3biwBK0y/7Gz92Oj1ZDf8gK99+odvGxYa3nLQGeQefhNG0vvVJ+jZ3X39zBxJDOrw17Q7w4q747UR9CBTCqWzhla9yYKEwpmriyManDqQoRvEaim+n2ihHYkHW/gh7OVXgwzxfjW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 78A2180553;
	Sat,  9 Mar 2024 07:02:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id E28D12002C;
	Sat,  9 Mar 2024 07:02:18 +0000 (UTC)
Message-ID: <0cfbea8be50a1f3da6ab748d463fe29d1e515cb8.camel@perches.com>
Subject: Re: [PATCH 0/2] HID: samsung: Object code size reduction and
 neatening
From: Joe Perches <joe@perches.com>
To: linux-input@vger.kernel.org
Cc: Sandeep C S <sandeep.cs@samsung.com>, Junwan Cho
 <junwan.cho@samsung.com>,  Jitender Sajwan <jitender.s21@samsung.com>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
Date: Fri, 08 Mar 2024 23:02:17 -0800
In-Reply-To: <deebac6b6d06a6cd49ac09606a07576b84e35894.camel@perches.com>
References: <cover.1706732238.git.joe@perches.com>
	 <deebac6b6d06a6cd49ac09606a07576b84e35894.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: E28D12002C
X-Stat-Signature: 5fm1skraf5wuhgupob94g8spkiaryyzo
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/4i80LMxg7IwGLHuXdu2cNF3kfZ3ed7sk=
X-HE-Tag: 1709967738-122518
X-HE-Meta: U2FsdGVkX1+V80WyY5ksMpGY6+YR7OUIjwifXN8Vwjv71arjGJSTNyLMiqDhgLNExl1xnH7iS+4YcfR6oPLpVWlOly3fao9vDYDTKMAW/1LlYEAsNugz9mC1TH6jdsuMVT7HSDlAJ9mtYXGAGcOeSuRdSUvEyw88s595Rzejfvun1BXqBgSABFgHf+G38DLIvcXzVh+3OhOuXPEzRmIFhLGdmdKeI8Pltp4Syb7vSCQbIOKZRClDaUf5sysA1rfN879rCOh8ComZILspQF5/fkQY7Tu5wr6Ya5LdvlKCEG8skZEQATCPYGl72wf1+aj0

On Mon, 2024-02-12 at 10:09 -0800, Joe Perches wrote:
> On Wed, 2024-01-31 at 12:21 -0800, Joe Perches wrote:
> > Reduce object size and neatening
> >=20
> > Joe Perches (2):
> >   HID: samsung: Reduce code size
> >   HID: samsung: Object size reduction and neatening
> >=20
> >  drivers/hid/hid-samsung.c | 652 +++++++++++++++++---------------------
> >  1 file changed, 283 insertions(+), 369 deletions(-)
>=20
> Any comment from the samsung folk on these?

Ping?


