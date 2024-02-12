Return-Path: <linux-kernel+bounces-62161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB18851C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD0128395D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305483FB1D;
	Mon, 12 Feb 2024 18:09:31 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170A13D561;
	Mon, 12 Feb 2024 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707761370; cv=none; b=pfL2H53gDXAtyk/F2ztnu/L+F8csLHaFfWNpvm49ui9cFA3WQPOHF92mdFZ3hmG2KaH7VERVvNoRPLKCnR+ZZpviBsyUgPOOzudi6v70l4S1zbMK5Ouf9uaRlHP77dn3+lWFJChG4OnOM5hzJ6fioTLRyCSachS90zGqjM1qUAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707761370; c=relaxed/simple;
	bh=JbCAC8rYj0FfUruBWQ/40PlhIi/uOHdvmCbaUOUo364=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gPDzd0DEWabOfkgAmeDxYt++KHlmX2S58P7y1kJH7EVEIwuy/MtDO898ocD9lCjHnKw6i0dIMFku/KrOzI8UKurT3aiadzrYuYpkSSmkFUBxvQjXw5S8gHAVMh5EVwJlCOONQnWAZE0hQq1g6CEnFQiD6GBLEi4pp/ihM9q/f6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 1BCF0A0AB9;
	Mon, 12 Feb 2024 18:09:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 8F0542000D;
	Mon, 12 Feb 2024 18:09:18 +0000 (UTC)
Message-ID: <deebac6b6d06a6cd49ac09606a07576b84e35894.camel@perches.com>
Subject: Re: [PATCH 0/2] HID: samsung: Object code size reduction and
 neatening
From: Joe Perches <joe@perches.com>
To: linux-input@vger.kernel.org
Cc: Sandeep C S <sandeep.cs@samsung.com>, Junwan Cho
 <junwan.cho@samsung.com>,  Jitender Sajwan <jitender.s21@samsung.com>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
Date: Mon, 12 Feb 2024 10:09:17 -0800
In-Reply-To: <cover.1706732238.git.joe@perches.com>
References: <cover.1706732238.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8F0542000D
X-Stat-Signature: wo4xxtrhywzf5sjkq9k83wxgjkr5fk9m
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18A8v/ssR7DfqgBGeSb6SK9GstaVs96LP8=
X-HE-Tag: 1707761358-946541
X-HE-Meta: U2FsdGVkX1/KSSkazv2+7+66z1CTi9wY7iEn7kkpz419rA/Ds2Iwrb+60+ZckPbA1oGlZGateH6lbuPRZIj113JXmY7LH+x37CTusDwiW+rmpCFwIuonwySjjJLo0iMt71JLtLeG+vpj7pd8vSuNowVNvpeyCR1GDfFjiyMJhVJybBtVStGX4C3EgyKosLZX/mXdh7AMoZKWhyx5w0rsLplAN7k6FwXwG3ZcxJ/K//xb2i95Squ4wixs+o4KCxg6eLgQwxa7B0sEm/vsy5fgVwx8mCvEfPek7pe9VmmIqt+JnsZ0YMrlpKznIsXs4NUf

On Wed, 2024-01-31 at 12:21 -0800, Joe Perches wrote:
> Reduce object size and neatening
>=20
> Joe Perches (2):
>   HID: samsung: Reduce code size
>   HID: samsung: Object size reduction and neatening
>=20
>  drivers/hid/hid-samsung.c | 652 +++++++++++++++++---------------------
>  1 file changed, 283 insertions(+), 369 deletions(-)

Any comment from the samsung folk on these?


