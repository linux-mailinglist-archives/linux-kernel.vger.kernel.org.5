Return-Path: <linux-kernel+bounces-81144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAA2867117
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099481F2837B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB06660273;
	Mon, 26 Feb 2024 10:16:12 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FD66024C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942572; cv=none; b=GfFsM+qZE3ByhPz9f9XlcxbUboTQRhXj3pZXXf/6WXDsM/iN3SOC5/OkjY4PbGg7UjSoMaNXtwxnP/4wYOKAdDasTVF04UXnYXDkY8yc9AQ9obrtyycCv/eX1AZRT78x02DlI1vObte+5NaA/glgbZ8Zguk/X8Ee+U5ncaHvxv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942572; c=relaxed/simple;
	bh=VmTbkppW6YpAajcXsJ4b9OS5/DxwJNy3p3kYrUucLas=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=LBrnqy8JxZPLMgiqKsyUr+Bko1Lc8b9NFE0IA/4pQaqut9VwBlvIPw5wIpytrQ4KSmRnYxojXUIzPC69kO1fH3rE+BqVHECfakEQNWKHIGKsluXfAV1YzgO53cU1HdBUUU/f5yD8Au+qIs4gkCNS01kr5p8hUStNl08Tmusdgto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-91-CfTYQ5CAOY6_UOUoiheBlQ-1; Mon, 26 Feb 2024 10:16:02 +0000
X-MC-Unique: CfTYQ5CAOY6_UOUoiheBlQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 26 Feb
 2024 10:16:01 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 26 Feb 2024 10:16:01 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'kernel test robot' <lkp@intel.com>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, 'Linus Torvalds'
	<torvalds@linux-foundation.org>, 'Netdev' <netdev@vger.kernel.org>,
	"'dri-devel@lists.freedesktop.org'" <dri-devel@lists.freedesktop.org>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, 'Jens Axboe'
	<axboe@kernel.dk>, "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
	'Christoph Hellwig' <hch@infradead.org>, "'linux-btrfs@vger.kernel.org'"
	<linux-btrfs@vger.kernel.org>, 'Andrew Morton' <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>, 'Andy Shevchenko'
	<andriy.shevchenko@linux.intel.com>, "'David S . Miller'"
	<davem@davemloft.net>, 'Dan Carpenter' <dan.carpenter@linaro.org>, "'Jani
 Nikula'" <jani.nikula@linux.intel.com>
Subject: RE: [PATCH next v2 11/11] minmax: min() and max() don't need to
 return constant expressions
Thread-Topic: [PATCH next v2 11/11] minmax: min() and max() don't need to
 return constant expressions
Thread-Index: AdpoC6KUHy5Z1N7yRkiaBkc7ZdEdRQAjHDKAAAEYtvA=
Date: Mon, 26 Feb 2024 10:16:01 +0000
Message-ID: <bd7321effdf24d11aa16098bb40869ce@AcuMS.aculab.com>
References: <a18dcae310f74dcb9c6fc01d5bdc0568@AcuMS.aculab.com>
 <202402261720.EAMC0eHM-lkp@intel.com>
In-Reply-To: <202402261720.EAMC0eHM-lkp@intel.com>
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

From: kernel test robot <lkp@intel.com>
> Sent: 26 February 2024 09:42
...
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402261720.EAMC0eHM-lkp=
@intel.com/
>=20
> All warnings (new ones prefixed by >>):
>=20
> >> arch/x86/mm/pgtable.c:437:14: warning: variable length array used [-Wv=
la]
>      437 |         pmd_t *pmds[MAX_PREALLOCATED_PMDS];

Not surprisingly I missed X86_CONFIG_PAE builds :-)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


