Return-Path: <linux-kernel+bounces-109494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66893881A32
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E121C20C65
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACEC8615C;
	Wed, 20 Mar 2024 23:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="g+JfZlv5"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55F11E87E;
	Wed, 20 Mar 2024 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710977925; cv=none; b=t/FofJQhtX0KhjAKYeTnhF/sx9heQCRfSmNXepYtiipBKadYhCdQSYgWuIOXfX9+rr4cMMhRctwRVchT4n6iu9atyqySkdW5YuCMKpfEarTNOwmxi1nxqxQ/7sxSnv6KKPTV/CMbFNNuw+fPIa8sWshCIDxy4pFzSXoIP5rJ5Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710977925; c=relaxed/simple;
	bh=+2SWIsd88ucu5ws7uxhQnlemEmeUg8lx9NbQy9iP82Q=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=HWV4J5J48mTD8iVJIndjQZWp5OPZVSYE7+HVafEvI3AK8+FND6Ws0thuMUXRMlgrvZdODYBJ4kClL9Tdr3W5qrRK3SfsI/8f+oH5rWu6nrDKNKw6LKkPZ8r+I3eZAnAKFg0fyiuxcmxbid3pnpbaPWljPL0Dm2dghmMXVRokFhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=g+JfZlv5; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Content-Type:From:Mime-Version:Subject:Date:
	Message-Id; bh=NJNvmjRg6+oJD+f8rosyW4DUgth/EkIgF8KUF7RekOg=; b=g
	+JfZlv5pCw6ae43XDwcHmzR4d1lHl9pvpTQMsm/WZKERzH+NIsNImOSiXpm874dC
	/VMHqVTcE3m8EeA1J4Yjy9UUK46cBsAfUT+mN9ytXs+zgIDZTwkyxGNJ09QY2o95
	kGbaV+VzJ03oaiCxpnz2mK1Jk7VQNuQRIeYw4+idAA=
Received: from smtpclient.apple (unknown [119.143.49.21])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wD3Py80c_tl2DLlAA--.33361S2;
	Thu, 21 Mar 2024 07:37:26 +0800 (CST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Meiyong Yu <meiyong.yu@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Documentation: coding-style: ask function-like macros to evaluate parameters
Date: Thu, 21 Mar 2024 07:37:14 +0800
Message-Id: <EFB48F08-F0B5-47C0-8C47-00A542344AC9@126.com>
References: <20240320001656.10075-1-21cnbao@gmail.com>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Guenter Roeck <linux@roeck-us.net>, Max Filippov <jcmvbkbc@gmail.com>
In-Reply-To: <20240320001656.10075-1-21cnbao@gmail.com>
To: Barry Song <21cnbao@gmail.com>
X-Mailer: iPhone Mail (21E219)
X-CM-TRANSID:_____wD3Py80c_tl2DLlAA--.33361S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWrur45Xr1DtrW3Zw15XFb_yoW5Gr1xpF
	Z8JF47Xa18XFyUArnrJ392yFyxJrWrCFW3Wrsxtry5uF43A3Z2gry3tr15uan7Ar409ay7
	ua12krsruFyayrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bbiSdUUUUU=
X-CM-SenderInfo: 5phl501qjo53a6rslhhfrp/1tbijh2nhmVLZvJUWgABsH


> On Mar 20, 2024, at 08:17, Barry Song <21cnbao@gmail.com> wrote:
>=20
> =EF=BB=BFFrom: Barry Song <v-songbaohua@oppo.com>
>=20
> Recent commit 77292bb8ca69c80 ("crypto: scomp - remove memcpy if
> sg_nents is 1 and pages are lowmem") leads to warnings on xtensa
> and loongarch,
>   In file included from crypto/scompress.c:12:
>   include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
>   include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but not=
 used [-Wunused-but-set-variable]
>      76 |                 struct page *page;
>         |                              ^~~~
>   crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
>>> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunused=
-variable]
>     174 |                         struct page *dst_page =3D sg_page(req->d=
st);
>         |
>=20
> The reason is that flush_dcache_page() is implemented as a noop
> macro on these platforms as below,
>=20
> #define flush_dcache_page(page) do { } while (0)
>=20
> The driver code, for itself, seems be quite innocent and placing
> maybe_unused seems pointless,
>=20
> struct page *dst_page =3D sg_page(req->dst);
>=20
> for (i =3D 0; i < nr_pages; i++)
>    flush_dcache_page(dst_page + i);
>=20
> And it should be independent of architectural implementation
> differences.
>=20
> Let's have a guidance in codingstyle to ask for the evaluation
> of parameters.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Huacai Chen <chenhuacai@loongson.cn>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Suggested-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
> Documentation/process/coding-style.rst | 7 +++++++
> 1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/process/coding-style.rst b/Documentation/proces=
s/coding-style.rst
> index 9c7cf7347394..8065747fddff 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -827,6 +827,13 @@ Macros with multiple statements should be enclosed in=
 a do - while block:
>                do_this(b, c);        \
>        } while (0)
>=20


> +Function-like macros should evaluate their parameters, for unused paramet=
ers,
I do not support this point, if the parameter is unused, why not to remove i=
t.

about the warning,  is  tool misreport,  the tool must make better

> +cast them to void:
> +
> +.. code-block:: c
> +
> +    #define macrofun(a) do { (void) (a); } while (0)
> +
> Things to avoid when using macros:
>=20
> 1) macros that affect control flow:
> --
> 2.34.1
>=20


