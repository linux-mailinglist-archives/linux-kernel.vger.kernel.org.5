Return-Path: <linux-kernel+bounces-68723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B1C857F07
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFA028A2D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4DC12D758;
	Fri, 16 Feb 2024 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWCTUrJR"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D1312C804;
	Fri, 16 Feb 2024 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092758; cv=none; b=sPTBWEzYbqrhs+hJI+NvcgQmE46KQhSq4oxf2U/RXzhLSJKBDzT0030qbdoWmkXrMlqp31dOeAVAZO78rzvU8Koyv9Ddr2a8M+MV+XnG0227F7ZB8QcGA4GzZBHAZczF4FtB4JSe2Do7yQw3TK+WpZwkNHfOgU/VtvsL348O5wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092758; c=relaxed/simple;
	bh=cWKkcyG5ZwXc0YFOg/Yb0Q1JqcwSJX1rIPLlJbsCIG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJvR12NaYHJ1v0n3f4OMZ732PxTh2do5bl4wOG/QmPern3QRRj6wYCmx9jtl5ZIpoMAx/VQILQW78iywY2lrb1s/TgL+BJE6j8nuekeHBLYLq2HXxeLjvMJET2Oi3X3CIrop9VZLI7cOlB+9vOBibtOrbBMKVpIdKGqDWTCL7MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWCTUrJR; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-511ac701428so2471517e87.2;
        Fri, 16 Feb 2024 06:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708092755; x=1708697555; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a+lu+p9rqt3Ou+KwAMQ7uRO2icdU4O11skffs0WESHQ=;
        b=jWCTUrJRosKxeC2EfX34Wbc+GyNcAd1bWuJOaPeLyp1P9PHDpylgO5NDGYpB933FLj
         1rytFfyEN9WWe/gl4CYJxvc2dEJLheOolsBLiY2DboCAbErg9yZAQZdjbm8qhP/71/w2
         XAsAoiVc7kxOmZCSajp/7EbDHjn7emR0Te+mpRjkAaiMEtlTTyPKyeqR9oBzC1+7sQ0l
         RLJNumeTs8Dgsn9GvoJeUJbKEu/DtjtdeSgxcW6zlnoPt6OnynGxabk4fpxwbVtZBtRt
         dJHGoIx/AZPt9lcMaa1hi4b3cW122r/KFZ+NISygDHrIFZpXVIHUxOdK+WBsn3RnWgIN
         e4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092755; x=1708697555;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+lu+p9rqt3Ou+KwAMQ7uRO2icdU4O11skffs0WESHQ=;
        b=lf7yX2AaPg5+FcLRyljar6Ua+2p5vdJ25Ys/wDt3xS1x8TM54l5i9T0dX2lDavt8nU
         o8jRsadiU15xalHaU8dE2fXukGuVHqgzsW8ZeibtI5K9OR7Js/TCGPZoVUQJbWNwzYC7
         HeR498qo/OTkG3D9PlVEIDDLYRcaM1nfnEIV93M78UxC4yGGoYZPLXTNJXF3nh1kipVg
         t2gnrWekz8YJlpm8HJP4KGtPsJcOQN5hJcXbNrHkM18ihRiRnLixy6QTfcSr7jTIaLyD
         DWzvF8TwGuBiw0rNCVqrSBe1EOmz5ZnqruR1e640YxeDortQTLjBlwunE7e1uyfxhKh2
         IzDg==
X-Forwarded-Encrypted: i=1; AJvYcCVEWE9dDDCt/Rz0Dw0+NJIG7ZobZ7qb46Mbs0SYFdTta+A8/4X3T1FLi7LJzjCMGREvRVuoXfg2UVVr69XbLCPa4/iKXKg9l6PPe0dE3s7+/OQtuKaqJCUcQO1UUQn+C5BsZNTE2WTh1Cjlwt8RO2pxMV2IgGWLxHIyQBnMj+3RyRkxJJTF/A==
X-Gm-Message-State: AOJu0YwNodmIwyhgMimhw2UAVUE1kxmXti/xujFjDim6TPf1L0fZ5/Py
	+dBQc8fT3Bhq+wxzLE94Npo5ESJWdPMAOFn5FlUwf6BQB4U92pUC7BELFqJWptI=
X-Google-Smtp-Source: AGHT+IGnEhPHkQbv6q58TjYgQkHuoUjhnktjBYfl4VBf2/WgHnugeR/LPuqnjtkP7RGP7cV6EDRyJg==
X-Received: by 2002:a19:2d57:0:b0:512:9d10:53cd with SMTP id t23-20020a192d57000000b005129d1053cdmr188286lft.50.1708092754500;
        Fri, 16 Feb 2024 06:12:34 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id q7-20020ac25287000000b0051176a6a88esm616530lfm.5.2024.02.16.06.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:12:34 -0800 (PST)
Date: Fri, 16 Feb 2024 17:12:31 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, 
	Stephen Rothwell <sfr@rothwell.id.au>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] tty: mips_ejtag_fdc: Fix passing incompatible
 pointer type warning
Message-ID: <qefx2cny4g3v6gvafw2gqx6bqncoxbo37vtbutvgofezvof3uh@zu7vthspxs3u>
References: <20240215171740.14550-1-fancer.lancer@gmail.com>
 <20240215171740.14550-5-fancer.lancer@gmail.com>
 <4971bda5-e337-4c40-b7bd-5da4b7dae5d7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4971bda5-e337-4c40-b7bd-5da4b7dae5d7@kernel.org>

On Fri, Feb 16, 2024 at 06:51:01AM +0100, Jiri Slaby wrote:
> On 15. 02. 24, 18:17, Serge Semin wrote:
> > mips_ejtag_fdc_encode() method expects having a first argument passed of
> > the "u8 **" type, meanwhile the driver passes the "const char **" type.
> > That causes the next build-warning:
> > 
> > drivers/tty/mips_ejtag_fdc.c: In function ‘mips_ejtag_fdc_console_write’:
> > drivers/tty/mips_ejtag_fdc.c:343:32: error: passing argument 1 of ‘mips_ejtag_fdc_encode’ from incompatible pointer type [-Werror=incompatible-pointer-types]
> >     word = mips_ejtag_fdc_encode(&buf_ptr, &buf_len, 1);
> >                                  ^
> > drivers/tty/mips_ejtag_fdc.c:216:24: note: expected ‘const u8 ** {aka const unsigned char **}’ but argument is of type ‘const char **’
> >   static struct fdc_word mips_ejtag_fdc_encode(const u8 **ptrs,
> >                          ^~~~~~~~~~~~~~~~~~~~~
> 
> It's a correct change. But why the compiler complains, given
> KBUILD_CFLAGS += -funsigned-char
> ?

What a tricky question you asked.) It cost me some new gray hairs, but
I guess I figured the correct answer out.

First of all it turns out that "char", "signed char" and "unsigned
char" are three _distant_ types. The "-funsigned-char/-fsigned-char"
flag changes the signedness of the plain "char", but it doesn't make
it matching to any of "signed char" or "unsigned char". Thus the flag
you mentioned couldn't suppress the warning I discovered (a bit later
you'll see that it is unrelated to that flag, but to the fact that the
types are different). Here is a simple test-code illustrating what I
said above:

1: int main(int argc, char *argv[], char *env[])
2: {
3:         char c;
4:         char *cp = &c;
5:         signed char sc;
6:         signed char *scp1 = &c;
7:         signed char *scp2 = &sc;
8:         unsigned char uc;
9:         unsigned char *ucp1 = &c;
10:        unsigned char *ucp2 = &uc;
11:        return 0;
12: }

$ gcc -Wall -Wno-unused-variable -funsigned-char tmp_char.c -o tmp_char
tmp_char.c: In function ‘main’:
tmp_char.c:6:29: warning: pointer targets in initialization of ‘signed char *’ from ‘char *’ differ in signedness [-Wpointer-sign]
    6 |         signed char *scp1 = &c;
      |                             ^
tmp_char.c:9:31: warning: pointer targets in initialization of ‘unsigned char *’ from ‘char *’ differ in signedness [-Wpointer-sign]
    9 |         unsigned char *ucp1 = &c;
      |                               ^
$

See, a new warning (not as the one in the patch log) is printed
despite of having the "-funsigned-char" flag specified. A more
detailed discussion around that you can find here:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=28912
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=23087
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=71202

The next question would be: "Why don't we see such warning printed all
over the kernel then?" That's because the "-Wno-pointer-sign" warning
suppressor is enabled in the kernel. It shuts up the sign-mismatching
pointers cast warnings. So no warning will be printed if the test-code
above is compiled as:

$ gcc -Wall -Wno-unused-variable -funsigned-char -Wno-pointer-sign tmp_char.c -o tmp_char
$

But why do we still see a warning as mentioned in the patch log? It
turns out that the "-Wno-pointer-sign" flag only works for the
_simple_ pointer signedness mismatch, but not for the multi-level
pointers. So as long as there is a pointer-to-pointer or
pointer-to-pointer-to-pointer, etc involved, another warning will be
printed. Here is the test-code modified to re-produce the compile
warning cited in the patch log:

1: int main(int argc, char *argv[], char *env[])
2: {
3:         char c;
4:         char *cp = &c;
5:         signed char sc;
6:         signed char *scp1 = &c;
7:         signed char *scp2 = &sc;
8:         signed char **scpp = &cp;
9:         unsigned char uc;
10:        unsigned char *ucp1 = &c;
11:        unsigned char *ucp2 = &uc;
12:        unsigned char **ucpp = &cp;
13:        return 0;
14: }

$ gcc -Wall -Wno-unused-variable -funsigned-char -Wno-pointer-sign tmp_char.c -o tmp_char
tmp_char.c: In function ‘main’:
tmp_char.c:8:30: warning: initialization of ‘signed char **’ from incompatible pointer type ‘char **’ [-Wincompatible-pointer-types]
    8 |         signed char **scpp = &cp;
      |                              ^
tmp_char.c:12:32: warning: initialization of ‘unsigned char **’ from incompatible pointer type ‘char **’ [-Wincompatible-pointer-types]
   12 |         unsigned char **ucpp = &cp;
      |                                ^
$

See, the lines 6 and 10 don't cause any warning printed (due to the
"-Wno-pointer-sign" flag), but the new lines 8 and 12 do. This is the
case that simulates what was discovered in the
drivers/tty/mips_ejtag_fdc.c driver and what was fixed in this patch.
I don't know for sure but I guess the compiler considers the
high-level pointers a bit differently than the single-level ones. So
the pointers to different pointer types are considered as
incompatible, which is also relevant for the char-family types since
these are three distant types. Thus that's what the warning about.

> 
> > Fix it by altering the type of the pointer which is passed to the
> > mips_ejtag_fdc_encode() method.
> > 
> > Fixes: ce7cbd9a6c81 ("tty: mips_ejtag_fdc: use u8 for character pointers")
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >   drivers/tty/mips_ejtag_fdc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
> > index aac80b69a069..afbf7738c7c4 100644
> > --- a/drivers/tty/mips_ejtag_fdc.c
> > +++ b/drivers/tty/mips_ejtag_fdc.c
> > @@ -309,7 +309,7 @@ static void mips_ejtag_fdc_console_write(struct console *c, const char *s,
> >   	unsigned int i, buf_len, cpu;
> >   	bool done_cr = false;
> >   	char buf[4];
> > -	const char *buf_ptr = buf;
> > +	const u8 *buf_ptr = buf;
> >   	/* Number of bytes of input data encoded up to each byte in buf */
> >   	u8 inc[4];
> 
> thanks,

Please explicitly add your tag if you are ok with the fix.

-Serge(y)

> -- 
> js
> suse labs
> 

