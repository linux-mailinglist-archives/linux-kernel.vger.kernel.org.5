Return-Path: <linux-kernel+bounces-116658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D39D88A1F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1A11C36585
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFC212C806;
	Mon, 25 Mar 2024 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="dVLgP0FN"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC2512BE8F;
	Mon, 25 Mar 2024 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711352392; cv=none; b=gOp4or5Ie3htOfo005O/rVNiqjs80aaLhX/d6MnrBcioNzgPe0wd71h+ZSLeuSC5yAKpZ1S8GMKBLenlEHao3Klwyg0wc2v9I2pD3gqHeZFc+iR38nRJcnghlrLSzWSWa9RsrLs/6jzMCmTnygYxE0OJfZYvs6nFJSbI5ibXrJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711352392; c=relaxed/simple;
	bh=XFiw51vlECFiOAnFpViM0CRHuQQPdgcCXN8991y13SY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FxXqPeKDFzGZFEq+3o3NUsDbth60GohcADFIVzAyBvhZLlOmtcqEf7tv0/e8xgd/zmmpfkBfMSU6UkKjybLMBBbMVL+AP3DNR2QqNhzXKawEZtQ9fYM1XrbcGR8nMXA/yVpj5cxqYXtitHBy97gjn2AO3vtaLwDglAbvKTHvhI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=dVLgP0FN; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NgQWIpjniJT6NNNxu1cRYbeyGqHYyx6QE33+2jP9vIY=; t=1711352388; x=1711957188; 
	b=dVLgP0FNhsv95kc7Ecck2ksERsUeSooplAGhNHs4FlpukrqRKV82ChK3iGDkM+ZYm+3iUrwa3xm
	kDH7JCQC7Q0ljK1zzpsQjPQLbvg/Rw7lKXXUnQ00x7EOw/pa0o4dN73yHspeeRnZN1CbBaexC8j8t
	E5j227o6LC4jxvNm+FvG1GJc2r9f7TbrW2dihnUXaqOzOwMyZM1wB66s0uu1Tu9sZfstf62t7oaIk
	x6nsT4RcP7e37pp8ZTubpjITJl2GhsS8n9VksuNt3HsztOTE2/C3RKiuW0Dv5wxjfQjLkvZQnqk7b
	1Cm7rytq+cyoXSfApyeHUNV+NI3n/dY3P9xQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1roevj-000000009Wd-3Ixh; Mon, 25 Mar 2024 08:39:39 +0100
Received: from p5b13a6ce.dip0.t-ipconnect.de ([91.19.166.206] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1roevj-00000003ImZ-2RWE; Mon, 25 Mar 2024 08:39:39 +0100
Message-ID: <059d03a5da257660fa0bc188c6cc8d0152e97704.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] Revert "sh: Handle calling csum_partial with misaligned
 data"
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Guenter Roeck <linux@roeck-us.net>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 25 Mar 2024 08:39:39 +0100
In-Reply-To: <20240324231804.841099-1-linux@roeck-us.net>
References: <20240324231804.841099-1-linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Guenter,

On Sun, 2024-03-24 at 16:18 -0700, Guenter Roeck wrote:
> This reverts commit cadc4e1a2b4d20d0cc0e81f2c6ba0588775e54e5.
>=20
> Commit cadc4e1a2b4d ("sh: Handle calling csum_partial with misaligned
> data") causes bad checksum calculations on unaligned data. Reverting
> it fixes the problem.
>=20
>     # Subtest: checksum
>     # module: checksum_kunit
>     1..5
>     # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/checksum_kun=
it.c:500
>     Expected ( u64)result =3D=3D ( u64)expec, but
>         ( u64)result =3D=3D 53378 (0xd082)
>         ( u64)expec =3D=3D 33488 (0x82d0)
>     # test_csum_fixed_random_inputs: pass:0 fail:1 skip:0 total:1
>     not ok 1 test_csum_fixed_random_inputs
>     # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.=
c:525
>     Expected ( u64)result =3D=3D ( u64)expec, but
>         ( u64)result =3D=3D 65281 (0xff01)
>         ( u64)expec =3D=3D 65280 (0xff00)
>     # test_csum_all_carry_inputs: pass:0 fail:1 skip:0 total:1
>     not ok 2 test_csum_all_carry_inputs
>     # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c=
:573
>     Expected ( u64)result =3D=3D ( u64)expec, but
>         ( u64)result =3D=3D 65535 (0xffff)
>         ( u64)expec =3D=3D 65534 (0xfffe)
>     # test_csum_no_carry_inputs: pass:0 fail:1 skip:0 total:1
>     not ok 3 test_csum_no_carry_inputs
>     # test_ip_fast_csum: pass:1 fail:0 skip:0 total:1
>     ok 4 test_ip_fast_csum
>     # test_csum_ipv6_magic: pass:1 fail:0 skip:0 total:1
>     ok 5 test_csum_ipv6_magic
>  # checksum: pass:2 fail:3 skip:0 total:5
>  # Totals: pass:2 fail:3 skip:0 total:5
> not ok 22 checksum

Can you tell me how the tests are run so I can try to verify this on real h=
ardware?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

