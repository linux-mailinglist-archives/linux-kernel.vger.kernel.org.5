Return-Path: <linux-kernel+bounces-60424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B606D8504B2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E795F1C20DE5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 14:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127E754656;
	Sat, 10 Feb 2024 14:23:03 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF72F53E30
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707574982; cv=none; b=n/VSn3fwMpdZst5MQghMb9lSVIbJ1EAXems6iFl0qvOoBdkY6kCIg8nP0E6VcOnvBBPtGZrpzzVkA0wfKImyXtNZ+ZsBZYtZKbxbPwS/j5VkG0alx6kur9iI9UbDqOuvyZBtnXmEmLWKe+VHE8e7RQI6vmiu+piTseYyBV2HpbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707574982; c=relaxed/simple;
	bh=OCdrhsWhvA4a4/A756/EUUI1BZgzj9AkFJv1Fy6Ehpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=i85F5f/c92+02H15ZPFX1Vf2IwTGvlR8g42pYCJJoLeRxM8O9dIkD8gEAo3ALOs9FEZzmchEauJWuRIfCrJP7Q/hu1kCksG3/Pz/Vxe8mRFiIe0eLA0wMox0yjfDZzau348OZ1Z38hhtUt/F8E5UiZIwG1szOkYAQOns8IvUTJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-285-P2GNB8rOM5-27t9QbLe7Bw-1; Sat, 10 Feb 2024 14:22:57 +0000
X-MC-Unique: P2GNB8rOM5-27t9QbLe7Bw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Feb
 2024 14:22:36 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Feb 2024 14:22:36 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Lucas De Marchi' <lucas.demarchi@intel.com>, Andi Shyti
	<andi.shyti@linux.intel.com>
CC: Yury Norov <yury.norov@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Jani Nikula
	<jani.nikula@linux.intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, Jani Nikula <jani.nikula@intel.com>
Subject: RE: Re: [PATCH v3 2/3] bits: Introduce fixed-type BIT
Thread-Topic: Re: [PATCH v3 2/3] bits: Introduce fixed-type BIT
Thread-Index: AQHaWtQsWHNiAo+Zx0GwnNabxeNy8rEDowcg
Date: Sat, 10 Feb 2024 14:22:36 +0000
Message-ID: <d42dc197a15649e69d459362849a37f2@AcuMS.aculab.com>
References: <20240208074521.577076-1-lucas.demarchi@intel.com>
 <20240208074521.577076-3-lucas.demarchi@intel.com>
 <ZcUz3V56qNeTVq66@ashyti-mobl2.lan>
 <ilppncjskpt52bijaoxlwcklawjpw5cqrndtx2g5xnwpj6bhbm@kn5yjscaha5e>
In-Reply-To: <ilppncjskpt52bijaoxlwcklawjpw5cqrndtx2g5xnwpj6bhbm@kn5yjscaha5e>
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

..
> >> +#define BIT_U8(b)=09=09((u8)(BIT_INPUT_CHECK(u8, b) + BIT(b)))
> >> +#define BIT_U16(b)=09=09((u16)(BIT_INPUT_CHECK(u16, b) + BIT(b)))
> >> +#define BIT_U32(b)=09=09((u32)(BIT_INPUT_CHECK(u32, b) + BIT(b)))
> >> +#define BIT_U64(b)=09=09((u64)(BIT_INPUT_CHECK(u64, b) + BIT(b)))
> >
> >considering that BIT defines are always referred to unsigned
> >types, I would just call them

Except that pretty much as soon as you breath on them
the u8 and u16 types get converted to int.
If you want them to be an unsigned type then you need
to cast them to (unsigned int).

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


