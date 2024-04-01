Return-Path: <linux-kernel+bounces-126715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AEA893BE8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D77282363
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453E14597E;
	Mon,  1 Apr 2024 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8s+dnhf"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B4B4436C;
	Mon,  1 Apr 2024 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980601; cv=none; b=qAUz2L2bvvaUSUWevH8k5HOcOEILubDsPuiOOJJKdMh6jcVO5GKsydzQXqBB9q6qWzxWB/J4AInVcC3cFMcBPN/6Fw8cg9u7dxScjOdiv8c5wbKH44gjIg8GjpBUsfcqDxeJ/LFKNtmAHGFpvPx0EkEErSNZzu3rhZuwVWwETb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980601; c=relaxed/simple;
	bh=uixfFlzrYgpSvjoL5IWecBS0EOJUkWi0ZDlFNpE5bAw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iPF+vm7Lq2+b8f0lm0PHhUnYeO/Dqnd4Kno5sBNs8jCtENQbEsZ8uplBPTm/Sgq2lgGhC7/lSVPedL4cKC0GNipg5XdWkZWE5LUi6Iswiij7MHicjUAsY3flminqUYzq3+PWqF+ahQCF6lHZenMrVpw8/O2vC5FQgkNs6JKrSQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8s+dnhf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e0ae065d24so33356275ad.1;
        Mon, 01 Apr 2024 07:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711980599; x=1712585399; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4LnTcUG5Gn+ClqY8LoKNtIWxJo6imLCDbbvZEP8U+iU=;
        b=O8s+dnhfxxLcoi3v5uMGdccixjkCtbzrVRKNcTP/j8+RCzJ0w+h4/TwZN2++GTkD8r
         Lm8qyN42an6VQdxeajOJiwtxWxiWdGMcJ1Shmy94dLshTwKXrZD98bYIqBOo4tabRjcY
         swhIf3QQFUm8rSYVg13cvUfoLpRnRiL/BmsL7BSD35BCZJqKD8NvATeGzWkd3dS2NQLr
         Ip3j46iOICoX2YgvgwMNhMN0RIx7mDHBEiWE6rGmtXNr8iYdugk87A/dBCHzNtOqeEji
         7UWGugCuwnGQRIo+ZrI66vDM4JMGEtopdqisM22U2DcGGtUkNUuURVaGGe3cKSe2xl5i
         HAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711980599; x=1712585399;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LnTcUG5Gn+ClqY8LoKNtIWxJo6imLCDbbvZEP8U+iU=;
        b=L4Y6DWp1gWYv7sGixKQNtOPSQcpLyTkUXam+z6qTjJIZ67RVvPThXFD4sAlSY7LCSk
         jDRicMum+8Xi3VuQvWMptjQHbKJSqr/A6C08vpcqAyj6qv4PKG4BuDUJrqcdAsaUKNMf
         a8ZAEPv0uOoI7W3aSC2o3RzG71/sYHfVTRYTmPCtUY97cAlJF22KF+PhZHEzswqeKZSg
         URanRAM54H73kJcs8CO25xnb/XnPY7xqMgYqzVjaJhgH8n2OFyveDprNHzC76vCA3f79
         zY+oKTzSeriu1N/0nlO6S/sfx40nVlUXkCDxDL+dGEhYhKg0gQyaCE+vGTApzJ98iJGv
         KICA==
X-Forwarded-Encrypted: i=1; AJvYcCUx2uPA20XSf7WIKPw9xGGbuveAmL6mdsF4qf7EEB1XtztVWoNpIe9Ad+IHXntYDDFvVN0polC/ZMB/aWlne5M87DCZEVwY
X-Gm-Message-State: AOJu0Yy8DUJMlGZvYrWjwLLNn9dGkuXcYfxvQO5Bvs1OQrs5uvESdJ6/
	SkM3x3XuzZbGk+3DmIag/pKUAuJf7AYmMMjm2/O0b3x2BI4nIlhEah94l9yYIHg=
X-Google-Smtp-Source: AGHT+IHsnqWUepxaIzaonpn0Lcg6hP1btF1hE4+WhjbYUVeNGv+A/038rxyG2j0bgQt/u/zLI8KtKA==
X-Received: by 2002:a17:903:986:b0:1dd:7f7c:945f with SMTP id mb6-20020a170903098600b001dd7f7c945fmr10033900plb.17.1711980599171;
        Mon, 01 Apr 2024 07:09:59 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b001e0f504a74csm8921254plr.269.2024.04.01.07.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 07:09:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0984E184EC504; Mon,  1 Apr 2024 21:09:55 +0700 (WIB)
Date: Mon, 1 Apr 2024 21:09:55 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Viktor Malik <vmalik@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, ncopa@alpinelinux.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Stable <stable@vger.kernel.org>
Subject: Fwd: stable kernels 6.6.23 and 6.1.83 fails to build: error: unknown
 type name 'u32'
Message-ID: <ZgrAM4NjZQWZ2Jq6@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lF6ZRc2CngG1ApMg"
Content-Disposition: inline


--lF6ZRc2CngG1ApMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Bugzilla, ncopa@alpinelinux.org reported resolve_btfids FTBFS regression
on musl system [1]:

> The latest releases fails to build with musl libc (Alpine Linux edge and =
v3.19):
>=20
> ```
> rm -f -f /home/ncopa/aports/main/linux-lts/src/build-lts.x86_64/tools/bpf=
/resolve_btfids/libbpf/libbpf.a; ar rcs /home/ncopa/aports/main/linux-lts/s=
rc/build-lts.x86_64/tool
> s/bpf/resolve_btfids/libbpf/libbpf.a /home/ncopa/aports/main/linux-lts/sr=
c/build-lts.x86_64/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-in.o
> In file included from main.c:73:
> /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_i=
ds.h:7:9: error: unknown type name 'u32'
>     7 |         u32 cnt;                                                 =
            =20
>       |         ^~~               =20
> /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_i=
ds.h:8:9: error: unknown type name 'u32'
>     8 |         u32 ids[];        =20
>       |         ^~~                   =20
> /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_i=
ds.h:12:9: error: unknown type name 'u32'
>    12 |         u32 cnt;  =20
>       |         ^~~                       =20
> /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_i=
ds.h:13:9: error: unknown type name 'u32'
>    13 |         u32 flags;
>       |         ^~~
> /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_i=
ds.h:15:17: error: unknown type name 'u32'
>    15 |                 u32 id;
>       |                 ^~~
> /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_i=
ds.h:16:17: error: unknown type name 'u32'
>    16 |                 u32 flags;
>       |                 ^~~
> /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux/btf_i=
ds.h:215:8: error: unknown type name 'u32'
>   215 | extern u32 btf_tracing_ids[];
>       |        ^~~
> make[4]: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/build=
/Makefile.build:98: /home/ncopa/aports/main/linux-lts/src/build-lts.x86_64/=
tools/bpf/resolve_btfids
> /main.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [Makefile:83: /home/ncopa/aports/main/linux-lts/src/build-lt=
s.x86_64/tools/bpf/resolve_btfids//resolve_btfids-in.o] Error 2
> make[2]: *** [Makefile:76: bpf/resolve_btfids] Error 2
> make[1]: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/Makefile:13=
54: tools/bpf/resolve_btfids] Error 2
> make: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/Makefile:234: =
__sub-make] Error 2
> ```

Bisection led to upstream commit 9707ac4fe2f5ba ("tools/resolve_btfids:
Refactor set sorting with types from btf_ids.h") as the culprit.

See the report on Bugzilla for the full thread and proposed fix.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218647

--=20
An old man doll... just what I always wanted! - Clara

--lF6ZRc2CngG1ApMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZgrALAAKCRD2uYlJVVFO
o79xAQCQId87Ud0/1xV9IsBEtZCjTXCaiIJ42QJb+2ChKJUaWQD+NCIew9+kI275
bI5KRT1jaCWXzSGYBW2gKyeoeAdUsAw=
=Dx2A
-----END PGP SIGNATURE-----

--lF6ZRc2CngG1ApMg--

