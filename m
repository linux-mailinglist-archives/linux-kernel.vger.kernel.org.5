Return-Path: <linux-kernel+bounces-102719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F74D87B674
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15569B21B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6253C35;
	Thu, 14 Mar 2024 02:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpxlXB9S"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50753624;
	Thu, 14 Mar 2024 02:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710383750; cv=none; b=TDKP8HEsRve0p14G1i9O6oxXSX634MLbH5R5IMcvKRXKHrHtk/2sjPQEljTiKh+Ni4yx3ISOBqa1rtspkzqAnRHTndOLyw4v2z4B5qWoChUnCPl+GP4UjXvMZ4+jDyx7ASCGfLG575zbZnGZk2erTULjOB7gDF4dk+T5HPo23RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710383750; c=relaxed/simple;
	bh=otFFZ4kCoqh0OGmZx2efEKE49ZpKF/UqxAHsaExNqCw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Mo9VgqFmqtHIT9nTqqRUnc1rEZV3e2MPBcfzQcM9E7W65rzfdk2wb56LjQ5WIJIO300azYUln7gZWX9s6qGn3NJcY/22ENvQtWlOYXpzB6+t3C6DT3YXrYJjpsl/sOki6uZfl+JCSbmO+fM6xt84Q3Qscn+ogs1W2Zj76q2oSdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpxlXB9S; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dd922cbcc7so3788575ad.2;
        Wed, 13 Mar 2024 19:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710383746; x=1710988546; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZANHP8iCfO3Zku85A5blshkUSrvbAKkebJN2nvnOvU=;
        b=SpxlXB9SigL9Smu+nlukwePlJNWX9cVP8Y/Y7wH/QQm/WTo0xrlX4seS/0jzpwJ79l
         q5k+ZBJ+NjDzB2b7G/mInaw3Cn60hszRRtGKh2jqqT2VSJiQQON1W5VLkPgsVNogmwMx
         A9oK19KJpGlrdGPAh1brSJFJxzSRY6KlZvDJCJ4X9oo0RXewdC6T3JyHMDa5y5dW8uDC
         74hhbL55LprkkM/N/a17bbAQTaNDscxAOhyhyPYugwaZXIb71u9bRHmeXQvrSLCPX2AS
         CAE3WBp9s7JKoPEDjH/RiCh8OlyqdUzVYB+KFbltOsTUKPc/i5+1lOSXq65NJ8nyEdJw
         ER6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710383746; x=1710988546;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZANHP8iCfO3Zku85A5blshkUSrvbAKkebJN2nvnOvU=;
        b=Oolsy5YSB3TMw3twD2oh1iYR4DAyrsSWTDLN0xLunu7ZYSRRLH3oWOA9Lgsglj1+qU
         hc/KF5H26BCY+yeLuKGeYAIr6Zxj8A68B5v9jE8VMM6T9UIQ6YL9jMw0uNamh8mWy0aX
         hzr6WqDmeJtvmkyXJAag5tyRAQ6Ro0MLyuAXp0y/6oS6SOM2eLmxHYHYPgJtYD4LPvXD
         dHg+ZxXGat9DmCbfar1c8299VokobtcmoGZUgeU8g1I0EGNWHt5w1oppwB2RY25xWsIj
         K/MLZP8Dgs4fzHYfop/Sknf5qaXC//qcml3iY4Y9+9CKQ/MQlF9b4eQrDObNv2y1616q
         O09Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtNqROWrUT1dCc0FRvCK1qQSJVV0DN4EhdOkn9fX9f/rpW88m4ogdGiifYeXOe2WB410/O5yqCDBP69VM+rthHWiylNR16/jyd
X-Gm-Message-State: AOJu0YwzYuPvy0dOo8wIcVOhZpjeA2vXilNbJRdWwcWt9Dt0iJa9xYEs
	i6atosdsp3oIeKrZJRovQrY7EmJXB7NwFU+ZuDkDOu1vf64QbcR1
X-Google-Smtp-Source: AGHT+IH9JOfH+Xv/kcv1T0k0xQMYk0dt1Sf36p17mlA2it8IwbjGyiv71T+gdnIUsHFnsgUiefPTnQ==
X-Received: by 2002:a17:902:6542:b0:1dd:2e6:b951 with SMTP id d2-20020a170902654200b001dd02e6b951mr677666pln.12.1710383746061;
        Wed, 13 Mar 2024 19:35:46 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902b94a00b001dd61bc14f2sm341396pls.8.2024.03.13.19.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 19:35:44 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 35E1418492D83; Thu, 14 Mar 2024 09:35:39 +0700 (WIB)
Date: Thu, 14 Mar 2024 09:35:39 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Memory Card Mailing List <linux-mmc@vger.kernel.org>
Cc: Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: Fwd: optee/fTPM access to RPMB via tee-supplicant broken in 6.6.13
 compared to 6.5.10
Message-ID: <ZfJie_hcHzH92Fon@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WJU2XFqERq13rW83"
Content-Disposition: inline


--WJU2XFqERq13rW83
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Mikko Rapeli (Linaro) <mikko.rapeli@linaro.org> reported fTPM regression
when using optee tee-supplicant client [1]. He wrote:

> Firmware TPM device (fTPM) use of RPMB storage via optee tee-supplicant c=
lient is broken in 6.6.13 compared to 6.5.10 kernel.
>=20
> Commit which breaks this is in MMC core:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
id=3D1653a8102868264f3488c298a9f20af2add9a288
>=20
> mmc: core: Use mrq.sbc in close-ended ffu
> commit 4d0c8d0aef6355660b6775d57ccd5d4ea2e15802 upstream.
> <snipped>...
> If this change is reverted, then RPMB access works. This error path also =
triggered a kernel crash reported and fixed via https://bugzilla.kernel.org=
/show_bug.cgi?id=3D218542
>=20
> In failure case optee side fTPM Trusted Application (TA) panics because s=
ecure storage operation fails. This happens right after loading kernel side=
 fTPM module.
>=20
> Here an example from synquacer aarch64 board:
>=20
> https://ledge.validation.linaro.org/scheduler/job/82680
>=20
> + tee-supplicant -d --rpmb-cid 880103534c4436344710565b65a08800
> + sleep 10
> + modprobe tpm_ftpm_tee
> E/TC:? 0=20
> E/TC:? 0 TA panicked with code 0xffff0000
> E/LD:  Status of TA bc50d971-d4c9-42c4-82cb-343fb7f37896
> E/LD:   arch: aarch64
> E/LD:  region  0: va 0x40005000 pa 0x3061b000 size 0x002000 flags rw-s (l=
delf)
> E/LD:  region  1: va 0x40007000 pa 0x3061d000 size 0x008000 flags r-xs (l=
delf)
> E/LD:  region  2: va 0x4000f000 pa 0x30625000 size 0x001000 flags rw-s (l=
delf)
> E/LD:  region  3: va 0x40010000 pa 0x30626000 size 0x004000 flags rw-s (l=
delf)
> E/LD:  region  4: va 0x40014000 pa 0x3062a000 size 0x001000 flags r--s
> E/LD:  region  5: va 0x40015000 pa 0x306b2000 size 0x011000 flags rw-s (s=
tack)
> E/LD:  region  6: va 0x40026000 pa 0xe6ac0000 size 0x002000 flags rw-- (p=
aram)
> E/LD:  region  7: va 0x4005f000 pa 0x00001000 size 0x068000 flags r-xs [0]
> E/LD:  region  8: va 0x400c7000 pa 0x00069000 size 0x01f000 flags rw-s [0]
> E/LD:   [0] bc50d971-d4c9-42c4-82cb-343fb7f37896 @ 0x4005f000
> E/LD:  Call stack:
> E/LD:   0x4009d01c
> E/LD:   0x4005fb40
> E/LD:   0x400601b8
> E/LD:   0x4007ef3c
> E/LD:   0x40097fc0
> E/LD:   0x40060a2c
> E/LD:   0x400a31f4
> E/LD:   0x40098170
> [   15.831833] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke erro=
r: 0xffff3024
> [   15.832524] tpm tpm0: tpm_try_transmit: send(): error -53212
> [   15.833058] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke erro=
r: 0xffff3024
> [   15.833732] tpm tpm0: tpm_try_transmit: send(): error -53212
> [   15.834233] optee-ftpm optee-ta-bc50d971-d4c9-42c4-82cb-343fb7f37896: =
ftpm_tee_probe: tpm_chip_register failed with rc=3D-53212
> [   15.835289] optee-ftpm: probe of optee-ta-bc50d971-d4c9-42c4-82cb-343f=
b7f37896 failed with error -53212
>=20
> strace logging of tee-supplicant shows following ioctl()s being called on=
 rockpi4b arm64 board:
>=20
> https://ledge.validation.linaro.org/scheduler/job/82872
>=20
> + strace -f -s 999 -t /usr/sbin/tee-supplicant --rpmb-cid 880103534c44363=
44710565b65a08800
> 00:00:04 execve("/usr/sbin/tee-supplicant", ["/usr/sbin/tee-supplicant", =
"--rpmb-cid", "880103534c4436344710565b65a08800"], 0xffffce0953c0 /* 6 vars=
 */) =3D 0
> 00:00:04 brk(NULL)                      =3D 0xaaaac5a08000
> 00:00:04 mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS=
, -1, 0) =3D 0xffffbabab000
> 00:00:04 faccessat(AT_FDCWD, "/etc/ld.so.preload", R_OK) =3D -1 ENOENT (N=
o such file or directory)
> 00:00:04 openat(AT_FDCWD, "/usr/lib/tee-supplicant/plugins/libteec.so.1",=
 O_RDONLY|O_CLOEXEC) =3D -1 ENOENT (No such file or directory)
> 00:00:04 newfstatat(AT_FDCWD, "/usr/lib/tee-supplicant/plugins/", 0xffffc=
127f3c0, 0) =3D -1 ENOENT (No such file or directory)
> 00:00:04 openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3
> 00:00:04 fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D6299, ...}) =3D 0
> 00:00:04 mmap(NULL, 6299, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0xffffbaba9000
> 00:00:04 close(3)                       =3D 0
> 00:00:04 openat(AT_FDCWD, "/lib/libteec.so.1", O_RDONLY|O_CLOEXEC) =3D 3
> 00:00:04 read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0\267\0\1\0\0\0\0\0\0=
\0\0\0\0\0@\0\0\0\0\0\0\0 \1\1\0\0\0\0\0\0\0\0\0@\08\0\t\0@\0\32\0\31\0\1\0=
\0\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\250+\0\0\0\0\0=
\0\250+\0\0\0\0\0\0\0\0\1\0\0\0\0\0\1\0\0\0\6\0\0\0\200\374\0\0\0\0\0\0\200=
\374\1\0\0\0\0\0\200\374\1\0\0\0\0\0\210\3\0\0\0\0\0\0\300\3\0\0\0\0\0\0\0\=
0\1\0\0\0\0\0\2\0\0\0\6\0\0\0\270\374\0\0\0\0\0\0\270\374\1\0\0\0\0\0\270\3=
74\1\0\0\0\0\0\20\2\0\0\0\0\0\0\20\2\0\0\0\0\0\0\10\0\0\0\0\0\0\0\4\0\0\0\4=
\0\0\08\2\0\0\0\0\0\08\2\0\0\0\0\0\08\2\0\0\0\0\0\0 \0\0\0\0\0\0\0 \0\0\0\0=
\0\0\0\10\0\0\0\0\0\0\0\4\0\0\0\4\0\0\0X\2\0\0\0\0\0\0X\2\0\0\0\0\0\0X\2\0\=
0\0\0\0\0$\0\0\0\0\0\0\0$\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0S\345td\4\0\0\08\2\0=
\0\0\0\0\08\2\0\0\0\0\0\08\2\0\0\0\0\0\0 \0\0\0\0\0\0\0 \0\0\0\0\0\0\0\10\0=
\0\0\0\0\0\0P\345td\4\0\0\0\234&\0\0\0\0\0\0\234&\0\0\0\0\0\0\234&\0\0\0\0\=
0\0\234\0\0\0\0\0\0\0\234\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0Q\345td\6\0\0\0\0\0\=
0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\20\0\0\0\0\0\0\0R\345td\4\0\0\0\200\374\0\0\0\0\0\0\200\374\1\0\0\0\0\0\20=
0\374\1\0\0\0\0\0\200\3\0\0\0\0\0\0\200\3\0\0\0\0\0\0\1\0\0\0\0\0\0\0\4\0\0=
\0\20\0\0\0\5\0\0\0GNU\0\0\0\0\300\4\0\0\0\3\0\0\0\0\0\0\0\4\0\0\0\24\0\0\0=
\3\0\0\0GNU\0\316\324\4\243\\l\273\215\253Q1TG\233\31c\21\215\272u\0\0\0\0\=
24\0\0\0\37\0\0\0\2\0\0\0\7\0\0\0  \0\n\0\0\0\0@\0\300\10\0\0\31\337\37\0\0=
\0\0\0\0\0 \0\0\0!\0\0\0\"\0\0\0#\0\0\0\0\0\0\0$\0\0\0&\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0'\0\0\0\0\0\0\0(\0\0\0)\0\0\0\0\0\0\0\0\0\0\0*\0\0\0\0\0\0\0\3759=
\303Q{\234:\347\373\315\7\346\361\255\323\17\231FFa\376\34\300/\333+mG\375\=
377S\337u#3P\373\253s\325\233B\265\370W\237g\264\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\3\0\n\0", 832) =3D 832
> 00:00:04 fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D67488, ...}) =3D 0
> 00:00:04 mmap(NULL, 196672, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_DENY=
WRITE, -1, 0) =3D 0xffffbab41000
> 00:00:04 mmap(0xffffbab50000, 131136, PROT_READ|PROT_EXEC, MAP_PRIVATE|MA=
P_FIXED|MAP_DENYWRITE, 3, 0) =3D 0xffffbab50000
> 00:00:04 munmap(0xffffbab41000, 61440)  =3D 0
> 00:00:04 munmap(0xffffbab71000, 64)     =3D 0
> 00:00:04 mprotect(0xffffbab53000, 114688, PROT_NONE) =3D 0
> 00:00:04 mmap(0xffffbab6f000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP=
_FIXED|MAP_DENYWRITE, 3, 0xf000) =3D 0xffffbab6f000
> 00:00:04 close(3)                       =3D 0
> 00:00:04 openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_CLOEXEC) =3D 3
> 00:00:04 read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0\267\0\1\0\0\0\300\2=
06\2\0\0\0\0\0@\0\0\0\0\0\0\0\10\"\31\0\0\0\0\0\0\0\0\0@\08\0\f\0@\0<\0;\0\=
6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0\240\2\0\0\0\0\=
0\0\240\2\0\0\0\0\0\0\10\0\0\0\0\0\0\0\3\0\0\0\4\0\0\0\300|\25\0\0\0\0\0\30=
0|\25\0\0\0\0\0\300|\25\0\0\0\0\0\37\0\0\0\0\0\0\0\37\0\0\0\0\0\0\0\10\0\0\=
0\0\0\0\0\1\0\0\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\3=
66\257\30\0\0\0\0\0\366\257\30\0\0\0\0\0\0\0\1\0\0\0\0\0\1\0\0\0\6\0\0\0\34=
0\320\30\0\0\0\0\0\340\320\31\0\0\0\0\0\340\320\31\0\0\0\0\0(E\0\0\0\0\0\0p=
\16\1\0\0\0\0\0\0\0\1\0\0\0\0\0\2\0\0\0\6\0\0\0\340\372\30\0\0\0\0\0\340\37=
2\31\0\0\0\0\0\340\372\31\0\0\0\0\0\340\1\0\0\0\0\0\0\340\1\0\0\0\0\0\0\10\=
0\0\0\0\0\0\0\4\0\0\0\4\0\0\0\340\2\0\0\0\0\0\0\340\2\0\0\0\0\0\0\340\2\0\0=
\0\0\0\0 \0\0\0\0\0\0\0 \0\0\0\0\0\0\0\10\0\0\0\0\0\0\0\4\0\0\0\4\0\0\0\0\3=
\0\0\0\0\0\0\0\3\0\0\0\0\0\0\0\3\0\0\0\0\0\0D\0\0\0\0\0\0\0D\0\0\0\0\0\0\0\=
4\0\0\0\0\0\0\0\7\0\0\0\4\0\0\0\340\320\30\0\0\0\0\0\340\320\31\0\0\0\0\0\3=
40\320\31\0\0\0\0\0\20\0\0\0\0\0\0\0\210\0\0\0\0\0\0\0\20\0\0\0\0\0\0\0S\34=
5td\4\0\0\0\340\2\0\0\0\0\0\0\340\2\0\0\0\0\0\0\340\2\0\0\0\0\0\0 \0\0\0\0\=
0\0\0 \0\0\0\0\0\0\0\10\0\0\0\0\0\0\0P\345td\4\0\0\0\340|\25\0\0\0\0\0\340|=
\25\0\0\0\0\0\340|\25\0\0\0\0\0\334l\0\0\0\0\0\0\334l\0\0\0\0\0\0\4\0\0\0\0=
\0\0\0Q\345td\6\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\0\0\0\20\0\0\0\0\0\0\0R\345td\4\0\0\0\340\320\30\0\0\0=
\0\0\340\320\31\0\0\0\0\0\340\320\31\0\0\0\0\0 /\0\0\0\0\0\0 /\0\0\0\0\0\0\=
1\0\0\0\0\0\0\0\4\0\0\0\20\0\0\0\5\0\0\0GNU\0\0\0\0\300\4\0\0\0\3\0\0\0\0\0=
\0\0\4\0\0\0\24\0\0\0\3\0\0\0GNU\0\16\321\234\23\363@\327\21\342\211/\"\272=
\242\3\235\251\21\231\300\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\5\0\0\0\17\=
0\0\0", 832) =3D 832
> 00:00:04 fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D1650952, ...}) =3D 0
> 00:00:04 mmap(NULL, 1826640, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_DEN=
YWRITE, -1, 0) =3D 0xffffba992000
> 00:00:04 mmap(0xffffba9a0000, 1761104, PROT_READ|PROT_EXEC, MAP_PRIVATE|M=
AP_FIXED|MAP_DENYWRITE, 3, 0) =3D 0xffffba9a0000
> 00:00:04 munmap(0xffffba992000, 57344)  =3D 0
> 00:00:04 munmap(0xffffbab4e000, 8016)   =3D 0
> 00:00:04 mprotect(0xffffbab2b000, 73728, PROT_NONE) =3D 0
> 00:00:04 mmap(0xffffbab3d000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MA=
P_FIXED|MAP_DENYWRITE, 3, 0x18d000) =3D 0xffffbab3d000
> 00:00:04 mmap(0xffffbab42000, 48976, PROT_READ|PROT_WRITE, MAP_PRIVATE|MA=
P_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0xffffbab42000
> 00:00:04 close(3)                       =3D 0
> 00:00:04 mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS=
, -1, 0) =3D 0xffffbaba7000
> 00:00:04 set_tid_address(0xffffbaba70f0) =3D 159
> 00:00:04 set_robust_list(0xffffbaba7100, 24) =3D 0
> 00:00:04 rseq(0xffffbaba7740, 0x20, 0, 0xd428bc00) =3D 0
> 00:00:04 mprotect(0xffffbab3d000, 12288, PROT_READ) =3D 0
> 00:00:04 mprotect(0xffffbab6f000, 4096, PROT_READ) =3D 0
> 00:00:04 mprotect(0xaaaab032f000, 4096, PROT_READ) =3D 0
> 00:00:04 mprotect(0xffffbabb0000, 8192, PROT_READ) =3D 0
> 00:00:04 prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=3D8192*1024, rlim_max=
=3DRLIM64_INFINITY}) =3D 0
> 00:00:04 munmap(0xffffbaba9000, 6299)   =3D 0
> 00:00:04 getrandom("\x45\x61\xf7\xa9\xcb\xf9\x99\x5a", 8, GRND_NONBLOCK) =
=3D 8
> 00:00:04 brk(NULL)                      =3D 0xaaaac5a08000
> 00:00:04 brk(0xaaaac5a29000)            =3D 0xaaaac5a29000
> 00:00:04 openat(AT_FDCWD, "/usr/lib/tee-supplicant/plugins/", O_RDONLY|O_=
NONBLOCK|O_CLOEXEC|O_DIRECTORY) =3D -1 ENOENT (No such file or directory)
> 00:00:04 openat(AT_FDCWD, "/dev/teepriv0", O_RDWR) =3D 3
> 00:00:04 ioctl(3, TEE_IOC_VERSION, {impl_id=3DTEE_IMPL_ID_OPTEE, gen_caps=
=3DTEE_GEN_CAP_GP|TEE_GEN_CAP_PRIVILEGED|TEE_GEN_CAP_REG_MEM|TEE_GEN_CAP_ME=
MREF_NULL, impl_caps=3DTEE_OPTEE_CAP_TZ}) =3D 0
> 00:00:04 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=3D{func=3D0=
, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE|TEE_IOCT=
L_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_=
NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATT=
R_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]}+ modprobe tpm_ftpm_=
tee
>  =3D> {num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_=
INOUT|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_=
PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x208, c=3D0}]}}) =3D 0
> 00:00:15 rt_sigaction(SIGRT_1, {sa_handler=3D0xffffbaa1e330, sa_mask=3D[]=
, sa_flags=3DSA_ONSTACK|SA_RESTART|SA_SIGINFO}, NULL, 8) =3D 0
> 00:00:15 rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) =3D 0
> 00:00:15 mmap(NULL, 8454144, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_STA=
CK, -1, 0) =3D 0xffffba190000
> 00:00:15 mprotect(0xffffba1a0000, 8388608, PROT_READ|PROT_WRITE) =3D 0
> 00:00:15 rt_sigprocmask(SIG_BLOCK, ~[], [], 8) =3D 0
> 00:00:15 clone3({flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLON=
E_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTI=
D, child_tid=3D0xffffba99f270, parent_tid=3D0xffffba99f270, exit_signal=3D0=
, stack=3D0xffffba190000, stack_size=3D0x80ea60, tls=3D0xffffba99f8e0} =3D>=
 {parent_tid=3D[162]}, 88) =3D 162
> strace: Process 162 attached
> [pid   159] 00:00:15 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) =3D 0
> [pid   162] 00:00:15 rseq(0xffffba99f8c0, 0x20, 0, 0xd428bc00 <unfinished=
 ...>
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SHM_REGISTER, {addr=3D0xaaaac5a0900=
0, length=3D0x208, flags=3D0} <unfinished ...>
> [pid   162] 00:00:15 <... rseq resumed>) =3D 0
> [pid   159] 00:00:15 <... ioctl resumed> =3D> {length=3D0x208, flags=3D0,=
 id=3D1}) =3D 4
> [pid   162] 00:00:15 set_robust_list(0xffffba99f280, 24 <unfinished ...>
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x208, c=3D0x1}]} <unfinished ...>
> [pid   162] 00:00:15 <... set_robust_list resumed>) =3D 0
> [pid   159] 00:00:15 <... ioctl resumed> =3D> {ret=3D0, params=3D[{attr=
=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1=
, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D=
0x208, c=3D0x1}]}}) =3D 0
> [pid   162] 00:00:15 rt_sigprocmask(SIG_SETMASK, [],  <unfinished ...>
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   162] 00:00:15 <... rt_sigprocmask resumed>NULL, 8) =3D 0
> [pid   159] 00:00:15 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x600, c=3D0}]}}) =3D 0
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SHM_REGISTER, {addr=3D0xaaaac5a0a00=
0, length=3D0x600, flags=3D0} =3D> {length=3D0x600, flags=3D0, id=3D2}) =3D=
 5
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x600, c=3D0x2}]} =3D> {ret=3D0, params=
=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META=
, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=
=3D0, b=3D0x600, c=3D0x2}]}}) =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   162] 00:00:15 <... ioctl resumed> =3D> {num_params=3D3, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT, shm_=
offs=3D0, size=3D0x206, shm_id=3D1}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMR=
EF_OUTPUT, shm_offs=3D0, size=3D0x600, shm_id=3D2}]}}) =3D 0
> [pid   162] 00:00:15 openat(AT_FDCWD, "/sys/class/mmc_host", O_RDONLY|O_N=
ONBLOCK|O_CLOEXEC|O_DIRECTORY) =3D 6
> [pid   162] 00:00:15 fstat(6, {st_mode=3DS_IFDIR|0755, st_size=3D0, ...})=
 =3D 0
> [pid   162] 00:00:15 mmap(NULL, 134217728, PROT_NONE, MAP_PRIVATE|MAP_ANO=
NYMOUS, -1, 0) =3D 0xffffb2190000
> [pid   162] 00:00:15 munmap(0xffffb2190000, 31916032) =3D 0
> [pid   162] 00:00:15 munmap(0xffffb8000000, 35192832) =3D 0
> [pid   162] 00:00:15 mprotect(0xffffb4000000, 135168, PROT_READ|PROT_WRIT=
E) =3D 0
> [pid   162] 00:00:15 getdents64(6, 0xffffb4000ba0 /* 5 entries */, 32768)=
 =3D 120
> [pid   162] 00:00:15 openat(AT_FDCWD, "/sys/class/mmc_host/mmc1/mmc1:0001=
/cid", O_RDONLY) =3D -1 ENOENT (No such file or directory)
> [pid   162] 00:00:15 openat(AT_FDCWD, "/sys/class/mmc_host/mmc2/mmc2:0001=
/cid", O_RDONLY) =3D -1 ENOENT (No such file or directory)
> [pid   162] 00:00:15 openat(AT_FDCWD, "/sys/class/mmc_host/mmc0/mmc0:0001=
/cid", O_RDONLY) =3D 7
> [pid   162] 00:00:15 read(7, "880103534c4436344710565b65a08800", 32) =3D =
32
> [pid   162] 00:00:15 close(7)           =3D 0
> [pid   162] 00:00:15 close(6)           =3D 0
> [pid   162] 00:00:15 openat(AT_FDCWD, "/dev/mmcblk0rpmb", O_RDWR) =3D 6
> [pid   162] 00:00:15 ioctl(6, MMC_IOC_MULTI_CMD, 0xffffb4000b70) =3D 0
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D104, buf_ptr=
=3D{num_params=3D3, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_MEMREF_INPUT, shm_offs=3D0, size=3D0x206, shm_id=3D1}, {attr=3DT=
EE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT, shm_offs=3D0, size=3D0x600, shm_id=
=3D2}]} =3D> {ret=3D0, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_IN=
OUT|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PA=
RAM_ATTR_TYPE_MEMREF_INPUT, shm_offs=3D0, size=3D0x206, shm_id=3D1}, {attr=
=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT, shm_offs=3D0, size=3D0x600, shm=
_id=3D2}]}}) =3D 0
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   159] 00:00:15 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x1, c=3D0}]}}) =3D 0
> [pid   159] 00:00:15 close(4)           =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x1, c=3D0}]} =3D> {ret=3D0, params=3D[{=
attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x1, c=3D0}]}}) =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   162] 00:00:15 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x2, c=3D0}]}}) =3D 0
> [pid   162] 00:00:15 close(5)           =3D 0
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x2, c=3D0}]} =3D> {ret=3D0, params=3D[{=
attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x2, c=3D0}]}}) =3D 0
> [pid   159] 00:00:15 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x208, c=3D0}]}}) =3D 0
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SHM_REGISTER, {addr=3D0xaaaac5a0900=
0, length=3D0x208, flags=3D0} =3D> {length=3D0x208, flags=3D0, id=3D1}) =3D=
 4
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x208, c=3D0x1}]} =3D> {ret=3D0, params=
=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META=
, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=
=3D0, b=3D0x208, c=3D0x1}]}}) =3D 0
> [pid   162] 00:00:15 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x600, c=3D0}]}}) =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SHM_REGISTER, {addr=3D0xffffb400100=
0, length=3D0x600, flags=3D0} =3D> {length=3D0x600, flags=3D0, id=3D2}) =3D=
 5
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x600, c=3D0x2}]} =3D> {ret=3D0, params=
=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META=
, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=
=3D0, b=3D0x600, c=3D0x2}]}}) =3D 0
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   159] 00:00:15 <... ioctl resumed> =3D> {num_params=3D3, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT, shm_=
offs=3D0, size=3D0x206, shm_id=3D1}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMR=
EF_OUTPUT, shm_offs=3D0, size=3D0x600, shm_id=3D2}]}}) =3D 0
> [pid   159] 00:00:15 ioctl(6, MMC_IOC_MULTI_CMD, 0xaaaac5a084b0) =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D104, buf_ptr=
=3D{num_params=3D3, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_MEMREF_INPUT, shm_offs=3D0, size=3D0x206, shm_id=3D1}, {attr=3DT=
EE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT, shm_offs=3D0, size=3D0x600, shm_id=
=3D2}]} =3D> {ret=3D0, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_IN=
OUT|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PA=
RAM_ATTR_TYPE_MEMREF_INPUT, shm_offs=3D0, size=3D0x206, shm_id=3D1}, {attr=
=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT, shm_offs=3D0, size=3D0x600, shm=
_id=3D2}]}}) =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} =3D> {n=
um_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_=
IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR=
_TYPE_VALUE_INOUT, a=3D0, b=3D0x1, c=3D0}]}}) =3D 0
> [pid   159] 00:00:15 close(4)           =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x1, c=3D0}]} =3D> {ret=3D0, params=3D[{=
attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x1, c=3D0}]}}) =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   162] 00:00:15 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x2, c=3D0}]}}) =3D 0
> [pid   162] 00:00:15 close(5)           =3D 0
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x2, c=3D0}]} =3D> {ret=3D0, params=3D[{=
attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x2, c=3D0}]}}) =3D 0
> [pid   159] 00:00:15 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x208, c=3D0}]}}) =3D 0
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SHM_REGISTER, {addr=3D0xaaaac5a0900=
0, length=3D0x208, flags=3D0} =3D> {length=3D0x208, flags=3D0, id=3D1}) =3D=
 4
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x208, c=3D0x1}]} =3D> {ret=3D0, params=
=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META=
, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=
=3D0, b=3D0x208, c=3D0x1}]}}) =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   162] 00:00:15 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x200, c=3D0}]}}) =3D 0
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SHM_REGISTER, {addr=3D0xffffb400100=
0, length=3D0x200, flags=3D0} =3D> {length=3D0x200, flags=3D0, id=3D2}) =3D=
 5
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x200, c=3D0x2}]} =3D> {ret=3D0, params=
=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META=
, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=
=3D0, b=3D0x200, c=3D0x2}]}}) =3D 0
> [pid   159] 00:00:15 <... ioctl resumed> =3D> {num_params=3D3, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT, shm_=
offs=3D0, size=3D0x206, shm_id=3D1}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMR=
EF_OUTPUT, shm_offs=3D0, size=3D0x200, shm_id=3D2}]}}) =3D 0
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   159] 00:00:15 ioctl(6, MMC_IOC_MULTI_CMD, 0xaaaac5a085d0) =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D104, buf_ptr=
=3D{num_params=3D3, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_MEMREF_INPUT, shm_offs=3D0, size=3D0x206, shm_id=3D1}, {attr=3DT=
EE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT, shm_offs=3D0, size=3D0x200, shm_id=
=3D2}]} =3D> {ret=3D0, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_IN=
OUT|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PA=
RAM_ATTR_TYPE_MEMREF_INPUT, shm_offs=3D0, size=3D0x206, shm_id=3D1}, {attr=
=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT, shm_offs=3D0, size=3D0x200, shm=
_id=3D2}]}}) =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   162] 00:00:15 <... ioctl resumed> =3D> {num_params=3D3, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT, shm_=
offs=3D0, size=3D0x206, shm_id=3D1}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMR=
EF_OUTPUT, shm_offs=3D0, size=3D0x200, shm_id=3D2}]}}) =3D 0
> [pid   162] 00:00:15 ioctl(6, MMC_IOC_MULTI_CMD, 0xffffb4000cc0) =3D 0
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D104, buf_ptr=
=3D{num_params=3D3, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_MEMREF_INPUT, shm_offs=3D0, size=3D0x206, shm_id=3D1}, {attr=3DT=
EE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT, shm_offs=3D0, size=3D0x200, shm_id=
=3D2}]} =3D> {ret=3D0, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_IN=
OUT|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PA=
RAM_ATTR_TYPE_MEMREF_INPUT, shm_offs=3D0, size=3D0x206, shm_id=3D1}, {attr=
=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT, shm_offs=3D0, size=3D0x200, shm=
_id=3D2}]}}) =3D 0
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   159] 00:00:15 <... ioctl resumed> =3D> {num_params=3D3, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT, shm_=
offs=3D0, size=3D0x206, shm_id=3D1}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMR=
EF_OUTPUT, shm_offs=3D0, size=3D0x200, shm_id=3D2}]}}) =3D 0
> [pid   159] 00:00:15 ioctl(6, MMC_IOC_MULTI_CMD, 0xaaaac5a086c0) =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D104, buf_ptr=
=3D{num_params=3D3, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_MEMREF_INPUT, shm_offs=3D0, size=3D0x206, shm_id=3D1}, {attr=3DT=
EE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT, shm_offs=3D0, size=3D0x200, shm_id=
=3D2}]} =3D> {ret=3D0, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_IN=
OUT|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PA=
RAM_ATTR_TYPE_MEMREF_INPUT, shm_offs=3D0, size=3D0x206, shm_id=3D1}, {attr=
=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT, shm_offs=3D0, size=3D0x200, shm=
_id=3D2}]}}) =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} =3D> {n=
um_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_=
IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR=
_TYPE_VALUE_INOUT, a=3D0, b=3D0x1, c=3D0}]}}) =3D 0
> [pid   159] 00:00:15 close(4)           =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x1, c=3D0}]} =3D> {ret=3D0, params=3D[{=
attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x1, c=3D0}]}}) =3D 0
> [pid   162] 00:00:15 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x2, c=3D0}]}}) =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   162] 00:00:15 close(5)           =3D 0
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x2, c=3D0}]} =3D> {ret=3D0, params=3D[{=
attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x2, c=3D0}]}}) =3D 0
> [pid   159] 00:00:15 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x208, c=3D0}]}}) =3D 0
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SHM_REGISTER, {addr=3D0xaaaac5a0900=
0, length=3D0x208, flags=3D0} =3D> {length=3D0x208, flags=3D0, id=3D1}) =3D=
 4
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x208, c=3D0x1}]} =3D> {ret=3D0, params=
=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META=
, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=
=3D0, b=3D0x208, c=3D0x1}]}}) =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   162] 00:00:15 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x200, c=3D0}]}}) =3D 0
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SHM_REGISTER, {addr=3D0xffffb400100=
0, length=3D0x200, flags=3D0} =3D> {length=3D0x200, flags=3D0, id=3D2}) =3D=
 5
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x200, c=3D0x2}]} =3D> {ret=3D0, params=
=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META=
, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=
=3D0, b=3D0x200, c=3D0x2}]}}) =3D 0
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   159] 00:00:15 <... ioctl resumed> =3D> {num_params=3D3, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT, shm_=
offs=3D0, size=3D0x206, shm_id=3D1}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMR=
EF_OUTPUT, shm_offs=3D0, size=3D0x200, shm_id=3D2}]}}) =3D 0
> [pid   159] 00:00:15 ioctl(6, MMC_IOC_MULTI_CMD, 0xaaaac5a087e0) =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D104, buf_ptr=
=3D{num_params=3D3, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_MEMREF_INPUT, shm_offs=3D0, size=3D0x206, shm_id=3D1}, {attr=3DT=
EE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT, shm_offs=3D0, size=3D0x200, shm_id=
=3D2}]} =3D> {ret=3D0, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_IN=
OUT|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PA=
RAM_ATTR_TYPE_MEMREF_INPUT, shm_offs=3D0, size=3D0x206, shm_id=3D1}, {attr=
=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT, shm_offs=3D0, size=3D0x200, shm=
_id=3D2}]}}) =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} =3D> {n=
um_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_=
IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR=
_TYPE_VALUE_INOUT, a=3D0, b=3D0x1, c=3D0}]}}) =3D 0
> [pid   159] 00:00:15 close(4)           =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x1, c=3D0}]} =3D> {ret=3D0, params=3D[{=
attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x1, c=3D0}]}}) =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   162] 00:00:15 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x2, c=3D0}]}}) =3D 0
> [pid   162] 00:00:15 close(5)           =3D 0
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x2, c=3D0}]} =3D> {ret=3D0, params=3D[{=
attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x2, c=3D0}]}}) =3D 0
> [pid   159] 00:00:15 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x208, c=3D0}]}}) =3D 0
> [pid   162] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SHM_REGISTER, {addr=3D0xaaaac5a0900=
0, length=3D0x208, flags=3D0} =3D> {length=3D0x208, flags=3D0, id=3D1}) =3D=
 4
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x208, c=3D0x1}]} =3D> {ret=3D0, params=
=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META=
, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=
=3D0, b=3D0x208, c=3D0x1}]}}) =3D 0
> [pid   162] 00:00:15 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x200, c=3D0}]}}) =3D 0
> [pid   159] 00:00:15 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   162] 00:00:16 ioctl(3, TEE_IOC_SHM_REGISTER, {addr=3D0xffffb400100=
0, length=3D0x200, flags=3D0} =3D> {length=3D0x200, flags=3D0, id=3D2}) =3D=
 5
> [pid   162] 00:00:16 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x200, c=3D0x2}]} =3D> {ret=3D0, params=
=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META=
, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=
=3D0, b=3D0x200, c=3D0x2}]}}) =3D 0
> [pid   162] 00:00:16 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   159] 00:00:16 <... ioctl resumed> =3D> {num_params=3D3, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT, shm_=
offs=3D0, size=3D0x206, shm_id=3D1}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMR=
EF_OUTPUT, shm_offs=3D0, size=3D0x200, shm_id=3D2}]}}) =3D 0
> [pid   159] 00:00:16 ioctl(6, MMC_IOC_MULTI_CMD, 0xaaaac5a08900) =3D 0
> [pid   159] 00:00:16 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D104, buf_ptr=
=3D{num_params=3D3, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_MEMREF_INPUT, shm_offs=3D0, size=3D0x206, shm_id=3D1}, {attr=3DT=
EE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT, shm_offs=3D0, size=3D0x200, shm_id=
=3D2}]} =3D> {ret=3D0, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_IN=
OUT|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PA=
RAM_ATTR_TYPE_MEMREF_INPUT, shm_offs=3D0, size=3D0x206, shm_id=3D1}, {attr=
=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT, shm_offs=3D0, size=3D0x200, shm=
_id=3D2}]}}) =3D 0
> [pid   159] 00:00:16 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   162] 00:00:16 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x1, c=3D0}]}}) =3D 0
> [pid   162] 00:00:16 close(4)           =3D 0
> [pid   162] 00:00:16 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x1, c=3D0}]} =3D> {ret=3D0, params=3D[{=
attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x1, c=3D0}]}}) =3D 0
> [pid   159] 00:00:16 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x2, c=3D0}]}}) =3D 0
> [pid   162] 00:00:16 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   159] 00:00:16 close(5)           =3D 0
> [pid   159] 00:00:16 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x2, c=3D0}]} =3D> {ret=3D0, params=3D[{=
attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x2, c=3D0}]}}) =3D 0
> [pid   159] 00:00:16 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]}+ rngd
> ++ pidof rngd
> + RNGD_PID=3D165
> + '[' -c /dev/tpm0 ']'
> + mkdir -p /run/dbus
> + dbus-daemon --system
> + DBUS_PID=3D144
> + ABRMD_PID=3D170
> + tpm2_dictionarylockout -c
> + tpm2-abrmd --allow-root
>  <unfinished ...>
> [pid   162] 00:00:16 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x208, c=3D0}]}}) =3D 0
> [pid   162] 00:00:16 ioctl(3, TEE_IOC_SHM_REGISTER, {addr=3D0xaaaac5a0900=
0, length=3D0x208, flags=3D0} =3D> {length=3D0x208, flags=3D0, id=3D1}) =3D=
 4
> [pid   162] 00:00:16 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x208, c=3D0x1}]} =3D> {ret=3D0, params=
=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META=
, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=
=3D0, b=3D0x208, c=3D0x1}]}}) =3D 0
> [pid   159] 00:00:16 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x600, c=3D0}]}}) =3D 0
> [pid   162] 00:00:16 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   159] 00:00:16 ioctl(3, TEE_IOC_SHM_REGISTER, {addr=3D0xaaaac5a0a00=
0, length=3D0x600, flags=3D0} =3D> {length=3D0x600, flags=3D0, id=3D2}) =3D=
 5
> [pid   159] 00:00:16 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x600, c=3D0x2}]} =3D> {ret=3D0, params=
=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META=
, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=
=3D0, b=3D0x600, c=3D0x2}]}}) =3D 0
> [pid   159] 00:00:16 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   162] 00:00:16 <... ioctl resumed> =3D> {num_params=3D3, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT, shm_=
offs=3D0, size=3D0x206, shm_id=3D1}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMR=
EF_OUTPUT, shm_offs=3D0, size=3D0x600, shm_id=3D2}]}}) =3D 0
> [pid   162] 00:00:16 ioctl(6, MMC_IOC_MULTI_CMD, 0xffffb4000e40) =3D 0
> [pid   162] 00:00:16 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D104, buf_ptr=
=3D{num_params=3D3, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_MEMREF_INPUT, shm_offs=3D0, size=3D0x206, shm_id=3D1}, {attr=3DT=
EE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT, shm_offs=3D0, size=3D0x600, shm_id=
=3D2}]} =3D> {ret=3D0, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_IN=
OUT|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PA=
RAM_ATTR_TYPE_MEMREF_INPUT, shm_offs=3D0, size=3D0x206, shm_id=3D1}, {attr=
=3DTEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT, shm_offs=3D0, size=3D0x600, shm=
_id=3D2}]}}) =3D 0
> [pid   159] 00:00:16 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x1, c=3D0}]}}) =3D 0
> [pid   162] 00:00:16 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   159] 00:00:16 close(4)           =3D 0
> [pid   159] 00:00:16 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x1, c=3D0}]} =3D> {ret=3D0, params=3D[{=
attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x1, c=3D0}]}}) =3D 0
> [pid   162] 00:00:16 <... ioctl resumed> =3D> {num_params=3D2, params=3D[=
{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x2, c=3D0}]}}) =3D 0
> [pid   159] 00:00:16 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]} <unfini=
shed ...>
> [pid   162] 00:00:16 close(5)           =3D 0
> [pid   162] 00:00:16 ioctl(3, TEE_IOC_SUPPL_SEND, {buf_len=3D72, buf_ptr=
=3D{num_params=3D2, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT=
|TEE_IOCTL_PARAM_ATTR_META, a=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM=
_ATTR_TYPE_VALUE_INOUT, a=3D0, b=3D0x2, c=3D0}]} =3D> {ret=3D0, params=3D[{=
attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT|TEE_IOCTL_PARAM_ATTR_META, a=
=3D0x1, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT, a=3D0=
, b=3D0x2, c=3D0}]}}) =3D 0
> [pid   162] 00:00:16 ioctl(3, TEE_IOC_SUPPL_RECV, {buf_len=3D168, buf_ptr=
=3D{func=3D0, num_params=3D5, params=3D[{attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_N=
ONE|TEE_IOCTL_PARAM_ATTR_META, a=3D0, b=3D0, c=3D0}, {attr=3DTEE_IOCTL_PARA=
M_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOC=
TL_PARAM_ATTR_TYPE_NONE}, {attr=3DTEE_IOCTL_PARAM_ATTR_TYPE_NONE}]}E/TC:? 0=
=20
> E/TC:? 0 TA panicked with code 0xffff0000
> E/LD:  Status of TA bc50d971-d4c9-42c4-82cb-343fb7f37896
> E/LD:   arch: aarch64
> E/LD:  region  0: va 0x40005000 pa 0x3061b000 size 0x002000 flags rw-s (l=
delf)
> E/LD:  region  1: va 0x40007000 pa 0x3061d000 size 0x008000 flags r-xs (l=
delf)
> E/LD:  region  2: va 0x4000f000 pa 0x30625000 size 0x001000 flags rw-s (l=
delf)
> E/LD:  region  3: va 0x40010000 pa 0x30626000 size 0x004000 flags rw-s (l=
delf)
> E/LD:  region  4: va 0x40014000 pa 0x3062a000 size 0x001000 flags r--s
> E/LD:  region  5: va 0x40015000 pa 0x306b2000 size 0x011000 flags rw-s (s=
tack)
> E/LD:  region  6: va 0x40026000 pa 0xe6bb4000 size 0x002000 flags rw-- (p=
aram)
> E/LD:  region  7: va 0x4005b000 pa 0x00001000 size 0x068000 flags r-xs [0]
> E/LD:  region  8: va 0x400c3000 pa 0x00069000 size 0x01f000 flags rw-s [0]
> E/LD:   [0] bc50d971-d4c9-42c4-82cb-343fb7f37896 @ 0x4005b000
> E/LD:  Call stack:
> E/LD:   0x4009901c
> E/LD:   0x4005bb40
> E/LD:   0x4005c1b8
> E/LD:   0x4007af3c
> E/LD:   0x40093fc0
> E/LD:   0x4005ca2c
> E/LD:   0x4009f1f4
> E/LD:   0x40094170
> [   16.187823] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke erro=
r: 0xffff3024
> [   16.188548] tpm tpm0: tpm_try_transmit: send(): error -53212
>=20
> Good working case with stace output and 6.5.10 kernel is available from h=
ttps://ledge.validation.linaro.org/scheduler/job/82883
>=20

And then, he tried the workaround on tee-supplicant itself:

> Discussion in https://lore.kernel.org/all/20231129092535.3278-1-avri.altm=
an@wdc.com/ refers that multiple threads are calling the RPMB ioctls throug=
h a shared file descriptor. Jens Wiklander <jens.wiklander@linaro.org> prov=
ided simple patch to optee_client/tee-supplicant to reduce to single usersp=
ace thread:
>=20
> https://github.com/OP-TEE/optee_client
>=20
> --- a/tee-supplicant/src/tee_supplicant.c
> +++ b/tee-supplicant/src/tee_supplicant.c
> @@ -588,6 +588,8 @@ static bool spawn_thread(struct thread_arg *arg)
>         int e =3D 0;
>         pthread_t tid;
> =20
> +       return true;
> +
>         memset(&tid, 0, sizeof(tid));
> =20
>         DMSG("Spawning a new thread");
>=20
> This does not fix or work around the issue.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218587

--=20
An old man doll... just what I always wanted! - Clara

--WJU2XFqERq13rW83
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZfJidwAKCRD2uYlJVVFO
o3hPAP0ZfBBiLN0Pkl34ufF87HcKsGiWHw2u47++Dm4/qAqGHQD/Wtn01+VKHCMj
VMPV6TY6NVApbxlMw/1vqB8kKoyGdwU=
=LZOh
-----END PGP SIGNATURE-----

--WJU2XFqERq13rW83--

