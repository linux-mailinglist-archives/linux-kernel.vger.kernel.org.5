Return-Path: <linux-kernel+bounces-110009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A12B8858D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF561C21ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD41762E5;
	Thu, 21 Mar 2024 12:08:32 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F967604D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022911; cv=none; b=uxt23jcQqKDDlrCpHkj65Sr+Esu4b2XsE5B3shbAyvjBcE2zFzI/VW4hi70Jk2nrJl8J6/sUKa5jDbJMaGsVDKjn5wE01Ege/36DcjxTsaQ1dcfLP7ybj23VFX9goEySu3OJkc/gu92KBL0c44DtnkIhHq8t+hlxA+lGHxE2q28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022911; c=relaxed/simple;
	bh=GqyvfRUi6RfErn9zYplQfeZe7bnkSZoOo+d9kCUvcWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Z+hVxErj1A1utKbGclUXe7saf3PJa5EcOuh96itCjKzogjPY4zpfkIs6QmTuR90qrOW080gTFqnTtip9mG2TOpeslc0Q7UYgA9luPZWhZczbkA2SZ1LfO36fTNJluvrDOXgWqlyr4ZiLxOb2/mfEx9kJctd4xOBfQgbxYSB2SNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-71-oIAj6dgUOY2gPCXUAXYLDg-1; Thu, 21 Mar 2024 12:08:17 +0000
X-MC-Unique: oIAj6dgUOY2gPCXUAXYLDg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 21 Mar
 2024 12:07:51 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 21 Mar 2024 12:07:51 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Russell King' <linux@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>
CC: 'Jiangfeng Xiao' <xiaojiangfeng@huawei.com>, "arnd@arndb.de"
	<arnd@arndb.de>, "keescook@chromium.org" <keescook@chromium.org>,
	"haibo.li@mediatek.com" <haibo.li@mediatek.com>,
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
Thread-Index: AQHae3ROEuI+AaCprEesIWGaAOB7ebFB9uHAgAAWtoCAAAVW8A==
Date: Thu, 21 Mar 2024 12:07:51 +0000
Message-ID: <db930076c837456f999daee5cb76735f@AcuMS.aculab.com>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <1710906278-23851-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZfqiD8Yw0oOVHW/p@shell.armlinux.org.uk>
 <84a57ca8-8963-ca24-8bd1-ddc5c33bf4da@huawei.com>
 <Zfs7sT6Pxy5yjnPC@shell.armlinux.org.uk>
 <bad25937-fc98-8e11-4279-ab6b3a727c1f@huawei.com>
 <bbcca1e205384cf0b42236e17f3969f7@AcuMS.aculab.com>
 <ZfwYx/8k8FVONg6+@shell.armlinux.org.uk>
In-Reply-To: <ZfwYx/8k8FVONg6+@shell.armlinux.org.uk>
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

From: Russell King
> Sent: 21 March 2024 11:24
>=20
> On Thu, Mar 21, 2024 at 10:22:30AM +0000, David Laight wrote:
> > How aggressively does the compiler optimise 'noreturn' functions?
>=20
> I've seen cases where the compiler emits a BL instruction as the very
> last thing in the function, and nothing after it.

I've also seen the compiler defer generating a stack frame until
after an initial conditional.
That might mean you can get the BL in the middle of a function
but where the following instruction is for the 'no stack frame'
side of the branch.
That is very likely to break any stack offset calculations.=20

> This is where the problem lies - because the link register value
> created by the BL instruction will point to the instruction after the
> BL which will _not_ part of the function that invoked the BL. That
> will probably cause issues for the ELF unwinder, which means this
> issue probably goes beyond _just_ printing the function name.

Isn't this already in the unwinder?
A BL itself isn't going to fault with PC =3D next-instruction.

For pretty much all code isn't *(LR-4) going to be BL?
On arm that is probably testable.
(It is pretty much impossible to detect a ACLL on x86.)
If it is a direct BL then you'd normally expect to the be
a call the function containing the current 'PC'.
The obvious exception is if there was a tail call, and printing
the called address would then be useful.
(It might help with leaf functions that don't generate a stack frame.)

I remember issues with the solaris sparc backtrace that used to
get confused by leaf functions...

> I have vague memories that Ard has been involved in the unwinder,
> maybe he could comment on this problem? Maybe we need the unwinder
> itself to do the correction? I also wonder whether we should only
> do the correction if we detect that we're pointing at the first
> instruction of a function, and the previous instruction in the
> text segment was a BL.

It might be enough to depend on whether the address is that of a
fault (where the instruction could be retried) or from a call/trap
instruction where it will be the following instruction.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


