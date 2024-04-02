Return-Path: <linux-kernel+bounces-128122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327CD89566B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635B61C22993
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE5186146;
	Tue,  2 Apr 2024 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="OIojHHSc"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55385466B;
	Tue,  2 Apr 2024 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067271; cv=none; b=QL52B4kTSW/O7FYv1DqiBVxkF/p++gyjUJkTy7+VVhqIiAXumsvE1RaeDhFKKcC6syAfA302HdBKJKD/aJI7/i8xN9cuB7ld5ljsqruozygoBMhUOS+/P/0bnqiJbm6XBKxm8nJZpCwJZkkNS09gxFmGZCXm9KAkOxMlOaP+2B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067271; c=relaxed/simple;
	bh=xGBS8087o4E2OFVrwhMP2Fd9XpiplM/rOINlshOr56M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PoIfIuUvne2l0Dhggb7w+uJhDu61LKh/+8i9b/sz2g2yiPmV2bPSftMb7sAlx09Cj+AtEOPVBifYX4dHuLClVxafX8JZV0aZaCTmu0Hpd5wKCnbivxTAV7JpaBxt+hftTkCa6kZfLPwxG1Uc3dnk5b04LXPJImRKgguhAFyzTyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=OIojHHSc; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7FYEajHHZNrGHETCR6Q3fzJ6HNWJWU4r/hKJctcIepI=; t=1712067267; x=1712672067; 
	b=OIojHHScqszIjU2KfVSb6eKfmUZQH0X+pj1tdpiI1K4mkXSrbysLEmAJJaUH7xlzFZMjTaFgqr7
	4RoFGFsVfJuYcdtapDnnPw0w2DnxyPdjPO0JBcBewOl0Nfdfmzzahf+XdGq4Sq1QvIZpei35OlC6J
	idjnrkUOkXMNTL94NGj3Hld93DiGmmxGsW4JC47SzDX/lBwpMTHdk/CpncC2EpXeAu6MOGURentPD
	ue1qqauoBEKjc4Y6RvBHKbU/rUPEhKyoPnhC3zc8O7C8KIOOutYhOkNWaLVnVIFzfvtYKaz8SBawz
	P9GgsxTBOE6z3X+X6wyjlTZ009wIb3SzAJ4Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rrepN-00000001CzR-2fhC; Tue, 02 Apr 2024 16:09:29 +0200
Received: from p57bd9555.dip0.t-ipconnect.de ([87.189.149.85] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rrepN-00000000Hav-1nB3; Tue, 02 Apr 2024 16:09:29 +0200
Message-ID: <1e77ade4fb1d924ffaf226cb946ba3314ba59a1d.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] Revert "sh: Handle calling csum_partial with misaligned
 data"
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Guenter Roeck <linux@roeck-us.net>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 02 Apr 2024 16:09:28 +0200
In-Reply-To: <cb8d3d2a-b843-49d5-a219-10a29b5877d0@roeck-us.net>
References: <20240324231804.841099-1-linux@roeck-us.net>
	 <059d03a5da257660fa0bc188c6cc8d0152e97704.camel@physik.fu-berlin.de>
	 <a9ac59cd-82db-45a0-9f85-ec3880c54dbf@roeck-us.net>
	 <cb8d3d2a-b843-49d5-a219-10a29b5877d0@roeck-us.net>
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

On Tue, 2024-04-02 at 07:06 -0700, Guenter Roeck wrote:
> Hi,
>=20
> On Mon, Mar 25, 2024 at 07:34:00AM -0700, Guenter Roeck wrote:
> > On 3/25/24 00:39, John Paul Adrian Glaubitz wrote:
> > > Hi Guenter,
> > >=20
> > > On Sun, 2024-03-24 at 16:18 -0700, Guenter Roeck wrote:
> > > > This reverts commit cadc4e1a2b4d20d0cc0e81f2c6ba0588775e54e5.
> > > >=20
> > > > Commit cadc4e1a2b4d ("sh: Handle calling csum_partial with misalign=
ed
> > > > data") causes bad checksum calculations on unaligned data. Revertin=
g
> > > > it fixes the problem.
> > > >=20
> > > >      # Subtest: checksum
> > > >      # module: checksum_kunit
> > > >      1..5
> > > >      # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/check=
sum_kunit.c:500
> > > >      Expected ( u64)result =3D=3D ( u64)expec, but
> > > >          ( u64)result =3D=3D 53378 (0xd082)
> > > >          ( u64)expec =3D=3D 33488 (0x82d0)
> > > >      # test_csum_fixed_random_inputs: pass:0 fail:1 skip:0 total:1
> > > >      not ok 1 test_csum_fixed_random_inputs
> > > >      # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum=
_kunit.c:525
> > > >      Expected ( u64)result =3D=3D ( u64)expec, but
> > > >          ( u64)result =3D=3D 65281 (0xff01)
> > > >          ( u64)expec =3D=3D 65280 (0xff00)
> > > >      # test_csum_all_carry_inputs: pass:0 fail:1 skip:0 total:1
> > > >      not ok 2 test_csum_all_carry_inputs
> > > >      # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_=
kunit.c:573
> > > >      Expected ( u64)result =3D=3D ( u64)expec, but
> > > >          ( u64)result =3D=3D 65535 (0xffff)
> > > >          ( u64)expec =3D=3D 65534 (0xfffe)
> > > >      # test_csum_no_carry_inputs: pass:0 fail:1 skip:0 total:1
> > > >      not ok 3 test_csum_no_carry_inputs
> > > >      # test_ip_fast_csum: pass:1 fail:0 skip:0 total:1
> > > >      ok 4 test_ip_fast_csum
> > > >      # test_csum_ipv6_magic: pass:1 fail:0 skip:0 total:1
> > > >      ok 5 test_csum_ipv6_magic
> > > >   # checksum: pass:2 fail:3 skip:0 total:5
> > > >   # Totals: pass:2 fail:3 skip:0 total:5
> > > > not ok 22 checksum
> > >=20
> > > Can you tell me how the tests are run so I can try to verify this on =
real hardware?
> > >=20
> >=20
> > Enabling CONFIG_KUNIT and CHECKSUM_KUNIT and booting with those tests e=
nabled
> > should do it.
> >=20
>=20
> Did you have time to test this on real hardware ?

Not yet. I just returned from Easter holidays and need to get synced with w=
ork first.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

