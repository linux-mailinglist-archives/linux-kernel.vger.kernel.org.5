Return-Path: <linux-kernel+bounces-111206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD37886922
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2FD1F24F08
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE521CAA9;
	Fri, 22 Mar 2024 09:24:51 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39771B7F3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099491; cv=none; b=i7BsSBTSSy+RuXxoGkSphxqhZNCHsaxbiqrtT1FrxK/Jgm+4ii8AC+EWsXzVWeDR9MLbNxfk36RTDLdPPZMKD2uXxkT1Jv7dagD2Gru+sU8C2yXu5Dk2BlBx81DR+6g5QliZqb4+OSnxGaZAo8nHiVUVxYpk3uIwtWwkx1CGh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099491; c=relaxed/simple;
	bh=I8uHjlu16AjqAEeseHfO0a200Pi5aGA00Cly8jsvsTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=sdnvNPgVE5NxvANDvvgT21SOfzXnBuxdH4fxbrVs5DG8G4WXabiOu6fxFXpgnvOJFjKhqqsKZS9DH+XyuyEKlwvIjBneVsGvLp7uLbLWSc7ma6iix31bYItSlfT0mepv10qGk/Qb7XPpY3AS6ec7ERj7nJVv11Ks71D6xwyVOkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-79-v95uIj2DP4yt8BN4J_ZXpQ-1; Fri, 22 Mar 2024 09:24:46 +0000
X-MC-Unique: v95uIj2DP4yt8BN4J_ZXpQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 22 Mar
 2024 09:24:21 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 22 Mar 2024 09:24:21 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Russell King' <linux@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>
CC: Jiangfeng Xiao <xiaojiangfeng@huawei.com>, "arnd@arndb.de"
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
Thread-Index: AQHae3ROEuI+AaCprEesIWGaAOB7ebFB9uHAgADsd8GAAJnLsA==
Date: Fri, 22 Mar 2024 09:24:20 +0000
Message-ID: <2b2993fb215c4a5abd7d77ff1c984113@AcuMS.aculab.com>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <1710906278-23851-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZfqiD8Yw0oOVHW/p@shell.armlinux.org.uk>
 <84a57ca8-8963-ca24-8bd1-ddc5c33bf4da@huawei.com>
 <Zfs7sT6Pxy5yjnPC@shell.armlinux.org.uk>
 <bad25937-fc98-8e11-4279-ab6b3a727c1f@huawei.com>
 <bbcca1e205384cf0b42236e17f3969f7@AcuMS.aculab.com>
 <ZfwYx/8k8FVONg6+@shell.armlinux.org.uk>
 <CAMj1kXG2EGvgGuV-K7h5qDVJeLMd5hkq8GzigzCRzh9Z8cgyWw@mail.gmail.com>
 <ZfzMFv3zmYY36l9u@shell.armlinux.org.uk>
In-Reply-To: <ZfzMFv3zmYY36l9u@shell.armlinux.org.uk>
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
> Sent: 22 March 2024 00:09
>=20
> On Thu, Mar 21, 2024 at 11:43:41PM +0100, Ard Biesheuvel wrote:
> > Given that this particular issue would just disappear if the compiler
> > would just insert a BRK after the BL, I'd prefer to explore first
> > whether we can get this fixed on the compiler side.
>=20
> Arm32 doesn't have a BRK instruction. What would be appropriate after
> the no-return BL would be OS specific.

It would need to depend on what was being compiled.
For the kernel it could be much the same as BUG().
(Probably without any extra data.)
I suspect that arm32 could use 'swi' in kernel space,
but you wouldn't want to use that in userspace.

Looks like armv5 has a bkpt instruction - could that be used?
Or does the kernel need to support armv4?

The last arm I wrote anything for was a strongarm.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


