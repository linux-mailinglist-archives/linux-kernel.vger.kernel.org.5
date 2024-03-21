Return-Path: <linux-kernel+bounces-109888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BD0885760
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C04D2834A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC13456751;
	Thu, 21 Mar 2024 10:23:06 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A7A56448
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711016586; cv=none; b=NfD2KYcdNRS53IJLCwNlOUA5qRQK3a96gFWqhhWN6kJNWTo1gO7JDuoOe1D5Z5Y1ceaE56hW9zEWPZG6VpXXwNE0nsLD07JPKsm/Bu3yCFnPpsb6Cynmy/YCHxEuhkoQE939suK9ep4p/k5JnZYMosn95l65hTRra0g0iK8KjCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711016586; c=relaxed/simple;
	bh=5JPCZ+qBJS79Nz0MHkbWXC6seLKtP4tznYnQqpZf1HQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=O8EbWDAcX7/VoDPD3yoXJkTQ7ouE+3TQz2jdKzulknCAELsRISR7YEQBj/sWOYsPDNMkzXBR9gCA8H90fcpa1G8sY7P0YuUNZ+qbnTeMDlln6yEZEv3++aIbqLnoI6X0+SO1ienoWohIdUhFUlmNkGqgYZZTAfKcyQpatKjcDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-212-p3JOoYAWPBWRUG8sgCg1aA-1; Thu, 21 Mar 2024 10:22:55 +0000
X-MC-Unique: p3JOoYAWPBWRUG8sgCg1aA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 21 Mar
 2024 10:22:30 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 21 Mar 2024 10:22:30 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jiangfeng Xiao' <xiaojiangfeng@huawei.com>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: "arnd@arndb.de" <arnd@arndb.de>, "keescook@chromium.org"
	<keescook@chromium.org>, "haibo.li@mediatek.com" <haibo.li@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "amergnat@baylibre.com"
	<amergnat@baylibre.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "douzhaolei@huawei.com"
	<douzhaolei@huawei.com>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "kepler.chenxin@huawei.com"
	<kepler.chenxin@huawei.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "nixiaoming@huawei.com"
	<nixiaoming@huawei.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"wangbing6@huawei.com" <wangbing6@huawei.com>, "wangfangpeng1@huawei.com"
	<wangfangpeng1@huawei.com>, "jannh@google.com" <jannh@google.com>,
	"willy@infradead.org" <willy@infradead.org>
Subject: RE: [PATCH v2] ARM: unwind: improve unwinders for noreturn case
Thread-Topic: [PATCH v2] ARM: unwind: improve unwinders for noreturn case
Thread-Index: AQHae3ROEuI+AaCprEesIWGaAOB7ebFB9uHA
Date: Thu, 21 Mar 2024 10:22:30 +0000
Message-ID: <bbcca1e205384cf0b42236e17f3969f7@AcuMS.aculab.com>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <1710906278-23851-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZfqiD8Yw0oOVHW/p@shell.armlinux.org.uk>
 <84a57ca8-8963-ca24-8bd1-ddc5c33bf4da@huawei.com>
 <Zfs7sT6Pxy5yjnPC@shell.armlinux.org.uk>
 <bad25937-fc98-8e11-4279-ab6b3a727c1f@huawei.com>
In-Reply-To: <bad25937-fc98-8e11-4279-ab6b3a727c1f@huawei.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

How aggressively does the compiler optimise 'noreturn' functions?
Consider:
void f(...)
{
=09...
=09if () {
=09=09...
=09=09noreturn(...);
=09}
}

Without the noreturn() call it is a leaf function.
So the compiler doesn't need to save 'lr' on stack
(or the save could be deferred to inside the conditional).
Since noreturn() doesn't return it can be jumped to.
Additionally 'lr' can be used as a scratch register prior to
the noreturn() call.

So it is likely that inside noreturn() (and anything it
might call) you don't have a valid 'lr' chain at all.
No amount of picking between 'pc' and 'pc-1' is going to fix that.
The only way you can find a return address is by searching the
stack and hoping to find something that works.

So you need the compiler to 'not believe' the 'noreturn' attribute.
Setup a normal call frame and put a faulting instruction after the
call in case it returns.
That would give you half a chance of generating a backtrace.

Without that I suspect you are playing whack-a-mole.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


