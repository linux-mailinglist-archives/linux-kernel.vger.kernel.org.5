Return-Path: <linux-kernel+bounces-84061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFD486A1D1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B248287885
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6442C14F960;
	Tue, 27 Feb 2024 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="msOK8oUm"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2803B2D60B;
	Tue, 27 Feb 2024 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070210; cv=none; b=Hb1UGycVXqjM+hu1KUUXA0Tp5RBgrFxMnoOFpj9Rt7qhaRvK6LDIaL5ym7ASt3JBsaPNLHRrCSWJpVjBX7BfhG8a1kE+QsmYGot2w9UNIbM1MI9Ci4S0ypld0XUcNIV6rbCyqMPcTrBcYvdgCpmZnvO8SvwMhXcTEOH7tuKPSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070210; c=relaxed/simple;
	bh=jt8unC483IhQ8MJvE5mBrE1Joy0tUhMSb/gpWTBv198=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxMp2a0D189u8m0Wa6O5FdWV4qFaogflwn+EXkvyk2LHiB3MJIvkFi413U1CkhdM5KY9y4QRDkJkTPVqic9iTkwXBrtfOjDevDY97sP3NML8qPKUciZ872mQX+y/seGMBYoJd0e5Wd6cY+6Mb/kdl1CJ7EkQRg3ubokLO43XNik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=msOK8oUm; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709070190; x=1709674990; i=deller@gmx.de;
	bh=jt8unC483IhQ8MJvE5mBrE1Joy0tUhMSb/gpWTBv198=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=msOK8oUm2aaYzEnf0rMTvQj5nQEChAtTry6ADLeVBArR8Efjs9NblokNDPnO7hMg
	 JjA0PFOBtV5Hwv6I3aVm5Yr/nrsli/IXEXTA7nk2G4mKKR+8oqiCzSVy8xm9CclEn
	 U8hzx/IUSIh4rLE/PmGCaLccNt2eiCMTLJHAhjFUB3fJQqP0zUD1zc4zn4r1uP3X+
	 LMxI3p4XQZrwxGq9IEp4zFI8ad7Puo6BcrUj+mwr4pRoUOdx3IQECrUYRvHFR0u1h
	 uPTtKzW7yGo05YzyL86fvmmC5dUoO1xpGR66EGxMPn99ENBqZzjdj+2CN6U/lSt57
	 4dH9iMcSzl+CrFNYUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.157.76]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MulqD-1qo4rt0fXX-00rnpP; Tue, 27
 Feb 2024 22:43:10 +0100
Message-ID: <00ea2941-0289-440b-8281-84d283d796b3@gmx.de>
Date: Tue, 27 Feb 2024 22:43:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] parisc: Strip upper 32 bit of sum in csum_ipv6_magic
 for 64-bit builds
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240227203351.3445929-1-linux@roeck-us.net>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240227203351.3445929-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/1ym+tJ7pi4GE6vNP5deNz7oOXAYx/Ru2jHagOnFxFfafytxJY/
 wEEIxma0amCz6RNy7jPJWHbnkfX4eV20qX34vI09YLmYBYIZuRiqJsnY+i2HLYpqjbVlQBq
 BdBIEP9d+ydDJR0hg3EAh7QlSbFNK/kmX8GZpFUmAT6k6WxCJTiKFp4/JL11oBKfD9CWmD/
 dBNrqPRCMwuJGleVu9uoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nvU+gO8JLzY=;HmlVYUv1uymRKPhnHVVNUulnj7G
 mFQllGoXlxmRR2I03Ha+AC8cpsnM2eYUEL0YYqiTi1M4Ft6IOlLu3HfA8FselcZ46J1hGF6Nr
 lM6JqKt6+aGqLHdp2HprIYQ7yf5GZuTVJ6HLViH1kQTpGJi9GB3caArSHvRYdqe+Uo89q1gB+
 Db3aRwNCJYJk+Juk66QmoDP965AZEh/oRNZHiNxU2o0B8MHZtg/f8jTWq3pB5H2+htB1W/xu6
 QzhsNruQhnrEXR+otWiWl/YVPDSxZBm5z2TNRbh733tozhqxA9ZdrcriRrpVDEO4BfhBSypmW
 eIAux1nrXsy4JRP6e9wSPHJaQ1qldVPR0pIfqDIt96STtPf0u48dQn2JGt0GoH7+mDonEZJ2X
 X3ZO9fBeC4u6/T35kiUUrNhyqayFAvLbMnyknMHnwnU3aXXh6XiTujUAU6eQOy/o3rm9yObUg
 y5Tb4LeRMdhyT+/q+jOqIHamoNAGbdgTc3zT31N7Ey0gF9L1Z6s3R4/ORMShOoNS1gkAMxgkV
 0JkN2usA9JHFpo1tHVyISy8QML28vFQmWC/4xH21Eg4M13olTboBu9iifMHPLUKisFsZ28vCX
 acwHa8R6eNIymvBWS25HL36bnLBYBiHQaJz+5OiyZDmnE9gREuArHwq9YHuJ2qFpQcBEHO0ex
 XyVIJGSf3vDmRawxxe9lj4uEcYPdbu9TAIlDpyc/PRxLYFv+ea5Ihy+BD3NulKmZ6By/6nJK/
 EMMXWWA9Ds3GAKuq6k+eeAt/H3q2upskUBKuI2LJwErzzq0y4EFpvnx0wd9/e2G4yQ48qgY3i
 VculGdm9awwBsYQeNvTJcvTB/svOF26eGZo9T0yeG5rN0=

On 2/27/24 21:33, Guenter Roeck wrote:
> IPv6 checksum tests with unaligned addresses on 64-bit builds result
> in unexpected failures.
>
> Expected expected =3D=3D csum_result, but
>      expected =3D=3D 46591 (0xb5ff)
>      csum_result =3D=3D 46381 (0xb52d)
> with alignment offset 1
>
> Oddly enough, the problem disappeared after adding test code into
> the beginning of csum_ipv6_magic().
>
> As it turns out, the 'sum' parameter of csum_ipv6_magic() is declared as
> __wsum, which is a 32-bit variable. However, it is treated as 64-bit
> variable in the 64-bit assembler code. Tests showed that the upper 32 bi=
t
> of the register used to pass the variable are _not_ cleared when enterin=
g
> the function. This can result in checksum calculation errors.
>
> Clearing the upper 32 bit of 'sum' as first operation in the assembler
> code fixes the problem.
>
> Acked-by: Helge Deller <deller@gmx.de>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

applied.

Thanks!
Helge

> ---
> v2: Updated subject, clarified that the problem only affects 64-bit buil=
ds,
>      added Helge's Acked-by: tag.
>
>   arch/parisc/include/asm/checksum.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/as=
m/checksum.h
> index c949aa20fa16..2aceebcd695c 100644
> --- a/arch/parisc/include/asm/checksum.h
> +++ b/arch/parisc/include/asm/checksum.h
> @@ -126,6 +126,7 @@ static __inline__ __sum16 csum_ipv6_magic(const stru=
ct in6_addr *saddr,
>   	** Try to keep 4 registers with "live" values ahead of the ALU.
>   	*/
>
> +"	depdi		0, 31, 32, %0\n"/* clear upper half of incoming checksum */
>   "	ldd,ma		8(%1), %4\n"	/* get 1st saddr word */
>   "	ldd,ma		8(%2), %5\n"	/* get 1st daddr word */
>   "	add		%4, %0, %0\n"


