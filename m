Return-Path: <linux-kernel+bounces-165032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7C28B86D9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6506A1F2285C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B844EB38;
	Wed,  1 May 2024 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="P5nqocPF"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5EF43178;
	Wed,  1 May 2024 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714552106; cv=none; b=Edl0UuRcAwN/Zi1y7tqT/uB9jtpGVOIWkmb0EGkq+InU2uQpdKBTM3SSCqFMUBA6NwGmA+x1+qayzF5vXupFd8u4ELN3SdXRMGC2QEYb3t5UjIhZmUbF9zeICTZl8EM7TpSz0to63MAAzqvRSK9760EVx7noWWP+E9Uem+MEVlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714552106; c=relaxed/simple;
	bh=6Z6CExYf3bwnlZsAC5pyv6+LDVbnGn5ExaMHzkT8/vA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M6HxzzP4jZNrMz6KgOmlYyT0VY6Ax4rpW1MbQRV3U0YmeOjL/I1n41N0TQTFFkAVqUy8PYPXvwl5yrmmidKFkhuEZv1ciivlq0iacgqnyZxKB+0lBfKSrHk7/s5tn1Y/NWclpQ1/08jHQp9r/ciyiljtbJRA6BpkiG1nrry7WUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=P5nqocPF; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jltdGLOXvwsSJNbakaWYKBr2Z6UlzP6shIyKE8CH8c8=; t=1714552102; x=1715156902; 
	b=P5nqocPFxmKvzAOwGiaUjnKXfOT0ZZogjbw7pGbZ43wgdyMRTiUixi7lXViD/4MzLpohGxE/djm
	//XL/ssKSeI685RFvwS4Vsg+ySMrPJUk4vC4aPKlHp7/GT0IC+oOgY3saE8zGPyu09Q9KB9zl8J9T
	9zzrYTHoLt0Kio8qjEZdavPQD6oVQd9eYhQ4Dq9CU2rvKFd6UFC8p5fFAs0e6F1nIulEjC67bj+rY
	F2T7goL7GT2UxBImI1rAg2hqKQ/RLP00lCOgR8Prktr9yladj3GGyIhbssF4kDerhKR3lDKSS5kHj
	D6cZBnzIB3jfunmNmc30yp/n8MNzqsLBi+Vg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s25K0-000000043zb-20Dr; Wed, 01 May 2024 10:28:12 +0200
Received: from dynamic-078-054-136-214.78.54.pool.telefonica.de ([78.54.136.214] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s25K0-000000047Fx-18EO; Wed, 01 May 2024 10:28:12 +0200
Message-ID: <fb0293d85dbf82341c6b7e4d56fe8f1d23f7768a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] Revert "sh: Handle calling csum_partial with misaligned
 data"
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Guenter Roeck <linux@roeck-us.net>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 01 May 2024 10:28:11 +0200
In-Reply-To: <1e77ade4fb1d924ffaf226cb946ba3314ba59a1d.camel@physik.fu-berlin.de>
References: <20240324231804.841099-1-linux@roeck-us.net>
	 <059d03a5da257660fa0bc188c6cc8d0152e97704.camel@physik.fu-berlin.de>
	 <a9ac59cd-82db-45a0-9f85-ec3880c54dbf@roeck-us.net>
	 <cb8d3d2a-b843-49d5-a219-10a29b5877d0@roeck-us.net>
	 <1e77ade4fb1d924ffaf226cb946ba3314ba59a1d.camel@physik.fu-berlin.de>
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

On Tue, 2024-04-02 at 16:09 +0200, John Paul Adrian Glaubitz wrote:
> On Tue, 2024-04-02 at 07:06 -0700, Guenter Roeck wrote:
> > Hi,
> >=20
> > On Mon, Mar 25, 2024 at 07:34:00AM -0700, Guenter Roeck wrote:
> > > On 3/25/24 00:39, John Paul Adrian Glaubitz wrote:
> > > > Hi Guenter,
> > > >=20
> > > > On Sun, 2024-03-24 at 16:18 -0700, Guenter Roeck wrote:
> > > > > This reverts commit cadc4e1a2b4d20d0cc0e81f2c6ba0588775e54e5.
> > > > >=20
> > > > > Commit cadc4e1a2b4d ("sh: Handle calling csum_partial with misali=
gned
> > > > > data") causes bad checksum calculations on unaligned data. Revert=
ing
> > > > > it fixes the problem.
> > > > >=20
> > > > >      # Subtest: checksum
> > > > >      # module: checksum_kunit
> > > > >      1..5
> > > > >      # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/che=
cksum_kunit.c:500
> > > > >      Expected ( u64)result =3D=3D ( u64)expec, but
> > > > >          ( u64)result =3D=3D 53378 (0xd082)
> > > > >          ( u64)expec =3D=3D 33488 (0x82d0)
> > > > >      # test_csum_fixed_random_inputs: pass:0 fail:1 skip:0 total:=
1
> > > > >      not ok 1 test_csum_fixed_random_inputs
> > > > >      # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checks=
um_kunit.c:525
> > > > >      Expected ( u64)result =3D=3D ( u64)expec, but
> > > > >          ( u64)result =3D=3D 65281 (0xff01)
> > > > >          ( u64)expec =3D=3D 65280 (0xff00)
> > > > >      # test_csum_all_carry_inputs: pass:0 fail:1 skip:0 total:1
> > > > >      not ok 2 test_csum_all_carry_inputs
> > > > >      # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksu=
m_kunit.c:573
> > > > >      Expected ( u64)result =3D=3D ( u64)expec, but
> > > > >          ( u64)result =3D=3D 65535 (0xffff)
> > > > >          ( u64)expec =3D=3D 65534 (0xfffe)
> > > > >      # test_csum_no_carry_inputs: pass:0 fail:1 skip:0 total:1
> > > > >      not ok 3 test_csum_no_carry_inputs
> > > > >      # test_ip_fast_csum: pass:1 fail:0 skip:0 total:1
> > > > >      ok 4 test_ip_fast_csum
> > > > >      # test_csum_ipv6_magic: pass:1 fail:0 skip:0 total:1
> > > > >      ok 5 test_csum_ipv6_magic
> > > > >   # checksum: pass:2 fail:3 skip:0 total:5
> > > > >   # Totals: pass:2 fail:3 skip:0 total:5
> > > > > not ok 22 checksum
> > > >=20
> > > > Can you tell me how the tests are run so I can try to verify this o=
n real hardware?
> > > >=20
> > >=20
> > > Enabling CONFIG_KUNIT and CHECKSUM_KUNIT and booting with those tests=
 enabled
> > > should do it.
> > >=20
> >=20
> > Did you have time to test this on real hardware ?
>=20
> Not yet. I just returned from Easter holidays and need to get synced with=
 work first.

I might have to skip this for v6.10 as I haven't been able to test this yet=
.

I agree with the change in general, but I want to make sure I can reproduce
this on real hardware.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

