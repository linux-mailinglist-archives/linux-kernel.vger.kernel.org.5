Return-Path: <linux-kernel+bounces-110154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0A1885AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A398B216E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E1784FA0;
	Thu, 21 Mar 2024 14:38:00 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46C51EB3B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031879; cv=none; b=Bax/xhBJqZCSpp4jvY4XOAM65KVlJRmHCuiByHiPgZzSF+Lh31q2jnrBy2P6Ac0h26Ozk6l6BkOf7auIpFCztAfzdImGnL+ARaaOcZMzA6QYjMMPvNhqzU0N5MLXZ/8IPJ9qKcOFB2v0/2mdi1pHAEOrrlQmtOCqpcaLgW4MV9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031879; c=relaxed/simple;
	bh=LP3FeeZH4nKE2ePG3cz0fkEKsYcfyJbnepgga50dUlM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=tZqTjto6N0i5M3AltxsEnn2ebdJrmosJjDCwgP2vAq32vstjthfv9quO/7EMPuCcOCroAq0ggBzjwXANm+kQNI9HUsWT5FSdMj2cdHt/RJRvHdBlgvYYxn5X+1EMQFpUURPPdsj9MbCpXGCNTH8cHOYrewukWhV4YP3hUnSXENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-187-6fRfpWVCPDm3cO9Kixse_g-1; Thu, 21 Mar 2024 14:37:54 +0000
X-MC-Unique: 6fRfpWVCPDm3cO9Kixse_g-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 21 Mar
 2024 14:37:28 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 21 Mar 2024 14:37:28 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Russell King' <linux@armlinux.org.uk>
CC: Ard Biesheuvel <ardb@kernel.org>, 'Jiangfeng Xiao'
	<xiaojiangfeng@huawei.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"keescook@chromium.org" <keescook@chromium.org>, "haibo.li@mediatek.com"
	<haibo.li@mediatek.com>, "angelogioacchino.delregno@collabora.com"
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
Thread-Index: AQHae3ROEuI+AaCprEesIWGaAOB7ebFB9uHAgAAWtoCAAAVW8IAACy4AgAADrmCAAAjqAIAAC+ng
Date: Thu, 21 Mar 2024 14:37:28 +0000
Message-ID: <9d6057b110034c04b6b590522c8c69cc@AcuMS.aculab.com>
References: <1710906278-23851-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZfqiD8Yw0oOVHW/p@shell.armlinux.org.uk>
 <84a57ca8-8963-ca24-8bd1-ddc5c33bf4da@huawei.com>
 <Zfs7sT6Pxy5yjnPC@shell.armlinux.org.uk>
 <bad25937-fc98-8e11-4279-ab6b3a727c1f@huawei.com>
 <bbcca1e205384cf0b42236e17f3969f7@AcuMS.aculab.com>
 <ZfwYx/8k8FVONg6+@shell.armlinux.org.uk>
 <db930076c837456f999daee5cb76735f@AcuMS.aculab.com>
 <ZfwmomjUwQdCefzh@shell.armlinux.org.uk>
 <0fd55e156195440bb1d815dd8300894b@AcuMS.aculab.com>
 <ZfwxMuPflqlVyCDd@shell.armlinux.org.uk>
In-Reply-To: <ZfwxMuPflqlVyCDd@shell.armlinux.org.uk>
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
> Sent: 21 March 2024 13:08
>=20
> On Thu, Mar 21, 2024 at 12:57:07PM +0000, David Laight wrote:
> > From: Russell King
> > > Sent: 21 March 2024 12:23
> > ...
> > > > That might mean you can get the BL in the middle of a function
> > > > but where the following instruction is for the 'no stack frame'
> > > > side of the branch.
> > > > That is very likely to break any stack offset calculations.
> > >
> > > No it can't. At any one point in the function, the stack has to be in
> > > a well defined state, so that access to local variables can work, and
> > > also the stack can be correctly unwound. If there exists a point in
> > > the function body which can be reached where the stack could be in tw=
o
> > > different states, then the stack can't be restored to the parent
> > > context.
> >
> > Actually you can get there with a function that has a lot of args.
> > So you can have:
> > =09if (...) {
> > =09=09push x
> > =09=09bl func
> > =09=09add %sp, #8
> > =09}
> > =09code;
> > which is fine.
>=20
> No you can't.... and that isn't even Arm code. Arm doesn't use %sp.
> Moreover, that "bl" will stomp over the link register, meaning this
> function can not return.

With 9+ arguments they spill to see https://godbolt.org/z/Yj3ovd8bY

Where the compiler generates:
f9:
        cmp     w0, 0
        ble     .L2
        sub     sp, sp, #32
        mov     w7, w0
        mov     w6, w0
        mov     w5, w0
        mov     w4, w0
        mov     w3, w0
        stp     x29, x30, [sp, 16]
        add     x29, sp, 16
        mov     w2, w0
        mov     w1, w0
        str     w0, [sp]
        bl      f
L2:
        ret


A traceback from inside f() definitely needs to use LR-4
for the stack offset.

(arm64 doesn't seem to support -mno-sched-prolog).

I've failed to get different sized stack frames for the true/false
sides of the branch.
The compiler seems to pre-allocate the space for extra args rather
than using 'push' type instructions.
This was certainly better for some x86 cpu (p-pro?) but has now
gone out of fashion.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


