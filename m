Return-Path: <linux-kernel+bounces-166047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD1F8B9536
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E581F1F21F82
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6FF224EF;
	Thu,  2 May 2024 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="dDbvuils"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D5224DD;
	Thu,  2 May 2024 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714634622; cv=none; b=VMWt9A217yXSqser3qlrmA/R00ysF8ojDwCoyiwDrlul0cUJGXCL4qws1swkFCPNQeHVTIO7h2jtnPjowqbwEHHOWKlPzRw1muP6TPIiM2WexTkYbUDzc6E/9fb14KE1wNe3f7IPhSXKaO36ZozwOKII+zAk9usQJ0Oap2a4I7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714634622; c=relaxed/simple;
	bh=OAPu2d3tsahOzOfqL2nij3yfKpurUG7VkdlPTEnOS5A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gnVCiFHk7P9hfpQYGOi5bq6tNk4myT53Ns9UTl1o8qk163MG7XSPFMkSUQAGkqbT+AmCh+IaVXNPUOjj1ur+29+OcA3sdeWtIJQrFrXMcRsAZQiukKPfQfbR5knfuCqcVHpoNkYCJUHAlhgZRoo49VtejFHnXQ+/gIXZRgPdH+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=dDbvuils; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vbRJF07hlrUuCJ+609sJCuNQGmpKq/+/IBXqo+OmWKM=; t=1714634620; x=1715239420; 
	b=dDbvuilsgl0xmsg8eoHrAi6TBOWwO0Hue7waH1u69Phk4cpjqtkogI9ls5oIMvixqjTnL8THPq6
	OrpG2Djv29YN+6k4pMNhOmc9DKfdXId4aMStb6ewr7ZxkjKL+MRVo63qmJ89UqohTLoWYWrCF9WSm
	sU3QnW+cKN04Z0Q9s0T+dVnlZ81p/0YhYFroaqUBWBhIBv+l4bV+hlMz0bXMOOoXL6G4Fj4ICDuNS
	DYJpejoH/MdW/smQQQzVuFn8rRhVU+WS1p7dwRZmSGhmU160HzVRZ1L6xZYRrB2ssyBMTWKGMOmMy
	StdwJ5VQnfHSesHUZH+PDSlJLXffx0SBULkw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s2Qn2-00000000PtR-11CU; Thu, 02 May 2024 09:23:36 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s2Qn2-00000003dnj-05J7; Thu, 02 May 2024 09:23:36 +0200
Message-ID: <87b7b7a99b8addc82ac7ce229801b744c9ef838e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] Revert "sh: Handle calling csum_partial with misaligned
 data"
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 May 2024 09:23:35 +0200
In-Reply-To: <CAMuHMdVcE79i0RPQHJBJjpXY6U-M-AQ2gh+C25u_777PZgPxXQ@mail.gmail.com>
References: <20240324231804.841099-1-linux@roeck-us.net>
	 <059d03a5da257660fa0bc188c6cc8d0152e97704.camel@physik.fu-berlin.de>
	 <a9ac59cd-82db-45a0-9f85-ec3880c54dbf@roeck-us.net>
	 <cb8d3d2a-b843-49d5-a219-10a29b5877d0@roeck-us.net>
	 <1e77ade4fb1d924ffaf226cb946ba3314ba59a1d.camel@physik.fu-berlin.de>
	 <fb0293d85dbf82341c6b7e4d56fe8f1d23f7768a.camel@physik.fu-berlin.de>
	 <CAMuHMdVcE79i0RPQHJBJjpXY6U-M-AQ2gh+C25u_777PZgPxXQ@mail.gmail.com>
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

Hi Geert,

On Thu, 2024-05-02 at 09:21 +0200, Geert Uytterhoeven wrote:
> On landisk:
>=20
>  KTAP version 1
>  1..1
>      KTAP version 1
>      # Subtest: checksum
>      # module: checksum_kunit
>      1..5
> -    # test_csum_fixed_random_inputs: ASSERTION FAILED at
> lib/checksum_kunit.c:500
> -    Expected ( u64)result =3D=3D ( u64)expec, but
> -        ( u64)result =3D=3D 53378 (0xd082)
> -        ( u64)expec =3D=3D 33488 (0x82d0)
> -    not ok 1 test_csum_fixed_random_inputs
> -    # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit=
c:525
> -    Expected ( u64)result =3D=3D ( u64)expec, but
> -        ( u64)result =3D=3D 65281 (0xff01)
> -        ( u64)expec =3D=3D 65280 (0xff00)
> -    not ok 2 test_csum_all_carry_inputs
> -    # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.=
c:573
> -    Expected ( u64)result =3D=3D ( u64)expec, but
> -        ( u64)result =3D=3D 65535 (0xffff)
> -        ( u64)expec =3D=3D 65534 (0xfffe)
> -    not ok 3 test_csum_no_carry_inputs
> +    # test_csum_fixed_random_inputs: Test should be marked slow
> (runtime: 9.814991070s)
> +    ok 1 test_csum_fixed_random_inputs
> +    # test_csum_all_carry_inputs: Test should be marked slow
> (runtime: 19.621274580s)
> +    ok 2 test_csum_all_carry_inputs
> +    # test_csum_no_carry_inputs: Test should be marked slow (runtime:
> 19.614096540s)
> +    ok 3 test_csum_no_carry_inputs
>      ok 4 test_ip_fast_csum
>      ok 5 test_csum_ipv6_magic
> -# checksum: pass:2 fail:3 skip:0 total:5
> -# Totals: pass:2 fail:3 skip:0 total:5
> -not ok 1 checksum
> +# checksum: pass:5 fail:0 skip:0 total:5
> +# Totals: pass:5 fail:0 skip:0 total:5
> +ok 1 checksum
>=20
> As we aim for correctness over performance:
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> However, given the big impact on performance, it would be great if
> someone could find out what's wrong with the optimized version.

Thanks for testing this. I will pick this up then since it actually fixes a=
 bug.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

