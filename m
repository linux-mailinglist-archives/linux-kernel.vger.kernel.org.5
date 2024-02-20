Return-Path: <linux-kernel+bounces-73381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6D185C1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D2B286269
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD476768E9;
	Tue, 20 Feb 2024 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Kj5MUUU+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m/oYegNN"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806DE762EC;
	Tue, 20 Feb 2024 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447844; cv=none; b=UbXlgyuxHDJ1Q7nr1SFFxrV4bhCFlw1hhOfMu6co3DvaiyCe9Vv5sCG4+jE5ZyucJEegMw81WtnHVzoU2OsXHIX/kwFxrEBO+OBUgjB3ReeVOG/uAYTv0Udd/EnH0p/MzqMMIoU7oy6dqAw+m/00oUqNSY0TEMABXFze5KyFYSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447844; c=relaxed/simple;
	bh=vxrRcOGrjcUXKFMjfE9v+5kyRs2b+Jv2oM7bYUGohyY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=nnuQrNfN5sXEogvUVEWD19kDmVKuCe6QN5Veshxy+ovXXN4rEz/l9b0CEvFfOZKhJJcereX1H5OvCR/rZ3m36YzNIV3rMx4YzjGYt6/ODLwfnHLXYRbYZj5KOeaK+YcWM+Xi290KrsVXia4lVAP1Q7jO4mLwCSBVzP8Il5sFOwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Kj5MUUU+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m/oYegNN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 837D211400B6;
	Tue, 20 Feb 2024 11:50:41 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Tue, 20 Feb 2024 11:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1708447841;
	 x=1708534241; bh=Xdx7UMPYuTSf3OLQadP68fAB37rXHBcDMvWbLc/KP/w=; b=
	Kj5MUUU+4xv2ob/xq9pfn5O0O4I+AyJcImJu2G+ZzyDpj+oaA6a72uHt/KlP/yqA
	eP1GNTSaEyER8gLfCpUVjl+wSE8FyCuDkzC4bUd2/sxQ8qvF95i1GiManIv9ocPA
	bXNDdn/BF+dX1SVoYwbzEAP8MJQuKzG7HCDcKaL+LA3nKbbr/uihCXIY4ZEs4TOz
	flfC+ESS8t8e+3PGkg4vulE1q1f0QgPMfrzNi735vpOrWp+txZbjaGLbpwMFtE+b
	Bimaskk+1YMnvrvJIa+AP8YwEjM0/JpG/VrZmy9DMFfBT5zyYf52IuVzz0G+fWux
	xSA5JuLjEGv6MbOUodBVpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708447841; x=
	1708534241; bh=Xdx7UMPYuTSf3OLQadP68fAB37rXHBcDMvWbLc/KP/w=; b=m
	/oYegNNEUvZtQXIORtBuW/5c8CriiNPyOImgsAf5nG48oSlvuGcBilhXH/emNn7e
	fxfNLBYrh8WkosSRXm80sT8vf5CCG27EhMYk+tRnKg5BJon4qzCWASpSAHJ0+jqd
	FDoNapCI8ADuKIguEfA6ReElNCDIXd/wCuf/13KkVp4ba/Zr0d3lQiF/UEFf6nuS
	8HC+hEQoqbWNUmZnMMv4HPMovERWB97ksccFX0jmIKeo2KduFGFX5OkzXuZxZU2g
	XuzX9n+5ecD2Xrzj8YT3tUAMIKR/QwhziWWk00q+VWwGajUFRwRu3yb3I2Nav91D
	8JcrNZwxOUL3QSk8BB0mQ==
X-ME-Sender: <xms:YNjUZX9yLISOJcWVsW-6t1j6zuDl0O2fyaClYLTsjK_CdXcBx_biyw>
    <xme:YNjUZTv21CzfF2NlbTK6LVRhw00gDXlS6Oxpu9PrM35vN5xwBSR9a-MmqliQHQQiK
    60KEa1xYIW_tTJC-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfufht
    vghfrghnucfqkdftvggrrhdfuceoshhorhgvrghrsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepveevgfeikeeiheegtdejueffuedvjeejieevheevfeehveef
    ueeuledtveevtdeknecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrd
    horhhgpdhinhhfrhgruggvrggurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepshhorhgvrghrsehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:YNjUZVAxqoubL6kAJMlEkSlMa3UKWBKnOBdgEd0ecFTD8Bk0oETviw>
    <xmx:YNjUZTdLaHq69fpkZagYDpP6L05sPTRuJ008otdBiQCoraPWictkVg>
    <xmx:YNjUZcM08xZxxzp03KewqDItjYCf6wOvNnd2v4LqBiqNcDJJfUfLrQ>
    <xmx:YdjUZdF97FKvHYQyhkwsFy4OR0mH2ubWzoQT5JxFiDBs_mBxPN7gNw>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B0BC017000A1; Tue, 20 Feb 2024 11:50:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <00cae989-9640-4931-9683-dd889cd6b7db@app.fastmail.com>
In-Reply-To: <20240220110950.871307-1-cleger@rivosinc.com>
References: <20240220110950.871307-1-cleger@rivosinc.com>
Date: Tue, 20 Feb 2024 11:50:19 -0500
From: "Stefan O'Rear" <sorear@fastmail.com>
To: =?UTF-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>,
 "Jonathan Corbet" <corbet@lwn.net>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: "Robin Ehn" <rehn@rivosinc.com>, "Charlie Jenkins" <charlie@rivosinc.com>,
 "Jessica Clarke" <jrtc27@jrtc27.com>
Subject: Re: [PATCH v2] riscv: hwprobe: export largest userspace address
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024, at 6:09 AM, Cl=C3=A9ment L=C3=A9ger wrote:
> Some userspace applications (OpenJDK for instance) uses the free MSBs
> in pointers to insert additional information for their own logic and
> need to get this information from somewhere. Currently they rely on
> parsing /proc/cpuinfo "mmu=3Dsvxx" string to obtain the current value =
of
> virtual address used bits [1]. Since this reflect the raw MMU mode
> supported, it might differ from the logical one used internally.
> Exporting the maximum mmappable address through hwprobe will allow a
> more stable interface to be used. For that purpose, add a new hwprobe
> key named RISCV_HWPROBE_MAX_KEY which will export the maximum mmappable
> userspace address.
>
> Link:=20
> https://github.com/openjdk/jdk/blob/master/src/hotspot/os_cpu/linux_ri=
scv/vm_version_linux_riscv.cpp#L171=20
> [1]
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Stefan O'Rear <sorear@fastmail.com>

Ideally, we'd have something arch-independent, but this is a good interf=
ace
and simple enough to support in perpetuity.

-s

> ---
> v2:
>  - Note: tried sysconf to export it but this is not backed by syscall
>    and thus does not allow exporting such information easily.
>  - Use arch_get_mmap_end() instead of VA_BITS since it reflects the
>    maximum logical address used by the riscv port
>  - Change hwprobe key name from RISCV_HWPROBE_KEY_VA_BITS to
>    RISCV_HWPROBE_KEY_MAX_ADDRESS
>  - Link to v1:=20
> https://lore.kernel.org/lkml/20240201140319.360088-1-cleger@rivosinc.c=
om/
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 3 +++
>  arch/riscv/include/asm/hwprobe.h      | 2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>  arch/riscv/kernel/sys_hwprobe.c       | 4 ++++
>  4 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/arch/riscv/hwprobe.rst=20
> b/Documentation/arch/riscv/hwprobe.rst
> index b2bcc9eed9aa..a626aa21ac74 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -210,3 +210,6 @@ The following keys are defined:
>=20
>  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int whi=
ch
>    represents the size of the Zicboz block in bytes.
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_MAX_USER_ADDRESS`: An unsigned long whi=
ch
> +  represent the maximum userspace mmappable address.
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm=
/hwprobe.h
> index 630507dff5ea..150a9877b0af 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,7 +8,7 @@
>=20
>  #include <uapi/asm/hwprobe.h>
>=20
> -#define RISCV_HWPROBE_MAX_KEY 6
> +#define RISCV_HWPROBE_MAX_KEY 7
>=20
>  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>  {
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h=20
> b/arch/riscv/include/uapi/asm/hwprobe.h
> index 9f2a8e3ff204..a6da434be9da 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -67,6 +67,7 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
>  #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
> +#define RISCV_HWPROBE_KEY_MAX_USER_ADDRESS	7
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>=20
>  /* Flags */
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_h=
wprobe.c
> index a7c56b41efd2..19a47540b4a2 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -8,6 +8,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/cpufeature.h>
>  #include <asm/hwprobe.h>
> +#include <asm/processor.h>
>  #include <asm/sbi.h>
>  #include <asm/switch_to.h>
>  #include <asm/uaccess.h>
> @@ -202,6 +203,9 @@ static void hwprobe_one_pair(struct riscv_hwprobe =
*pair,
>  		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
>  			pair->value =3D riscv_cboz_block_size;
>  		break;
> +	case RISCV_HWPROBE_KEY_MAX_USER_ADDRESS:
> +		pair->value =3D arch_get_mmap_end(ULONG_MAX, 0, 0);
> +		break;
>=20
>  	/*
>  	 * For forward compatibility, unknown keys don't fail the whole
> --=20
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

