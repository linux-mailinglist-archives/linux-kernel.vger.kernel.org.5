Return-Path: <linux-kernel+bounces-141789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F528A2372
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C5E1C22BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D03BDDC9;
	Fri, 12 Apr 2024 01:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BCuVMQDc"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CBCD299;
	Fri, 12 Apr 2024 01:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886710; cv=none; b=sBA68asQLsXyX2gIychERvT67B26dTe6CA7Gk6BHjsrMZxOEktSre7tNrH5FzIQGoAPMZlJHyF5IUpohOYc621YlcAfeA3Ey8kowKhO34uGDQ8gVPkJV8yKgS45MTN2E0//NZDchRYnO1kcfOW1iJPRCTNMTn9pKoATWQeR+8Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886710; c=relaxed/simple;
	bh=9foBUyuwAc/BVowri7rNOQtXGtztZ3wtSpYnM6Ic54g=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=tqzGjCQC1YeIw/StGM83RtcF/oWI0sDyG0RZIQo2+CBTmwRWZd3hSaiDa/8+1krUMqd2PUHpzEQ1lLziPEleTu/Qwj2IbPn4MXj2vQNa7WPfHyvahGS4tTsB98WDQoVbaPwtPvargKi0WzR5/yvRSqjlslPLI6jgLNifHLK50Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BCuVMQDc; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712886691; bh=grNHUKauo33AOqUbUNv6E8S7kTP2vs4ALEUy8MB1AYA=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=BCuVMQDco6omgrXz4+I3E7l+HPxVhvEmH+JdZXyVKLqnUmRkG6iBBie/Nk7tRS410
	 862H4SPWo1J+hduySbpUPk9V6RY9LTVtGUvcu/sETKpzypjw4b+1W8EUB3llcUI8pK
	 MfjzcazVm2UDSn8nUist8M1GjCnfhG6trJYbG2vE=
Received: from smtpclient.apple ([2406:840:f99a:b03c:85cb:7203:1084:e303])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id C898B00C; Fri, 12 Apr 2024 09:50:09 +0800
X-QQ-mid: xmsmtpt1712886609tgl1651vh
Message-ID: <tencent_3EC60EBE4F410FED19C726DCA218AA10E707@qq.com>
X-QQ-XMAILINFO: Msgy4IdPSbYaZ64GTE7WkXXeggA/2VsreH9GQ9OT9UyO2Ihb4jjUAwx/RrMBzk
	 vrBDoQ/g7uFY4E7iXB0Sl0bgoDE/d/PV765MFVHfULK4AhCYJhr7uOkc44uBuTSMQ06FlqjJr1oJ
	 aZUiSlUU48WdPPXkfREvScKcBCvPa3uh2zNfX/QBq18mDH/kad32384cwMti0baQa4cYPAWaDzJh
	 NV9uliLT+PJZXtF4RBmUini0fTtXUUysLpMbmeUJA2KCgOQXY6/KA5XC/0wW5XQmVFqYjPOKBFnp
	 YabGR4yRFXPgkavkrIQilDcBe2w8aOycfWEUcHgXV0HuiC4JUxOXq7xla4g9DQklhRjn36ZQqOxl
	 VOCUHLL8QRC8uBq2zq8zwUI1Lf0iNYatltiuXd5eGLODi7Zs6kLBAMvJP4t1AyTfCu+on8bx9hdW
	 OeiFYYsxS1At2cSnyQeGrF5auR9DRtpOs5+mHv2w1+o9G0uht20HJpo2sKcI3TjYjzbKfgF45Ln+
	 5ygg5CNVuFF+P038YORYiuuY8XJgO7LA0/1Hj5nIG4CDv0GC19dJjFds4QvTGFiF/3gZvkcy9cw3
	 0IyE0ht3nEm24AmpIOhy4GiBxG9VMowtAV4W0J/v/pATFxZGrkcSICuKfZ1zCzbsN8LOKXdVejxX
	 XgBp17Gre62tGXv1gArNGusQKZKFze57c8fSKzeapsHMg6b66vSYYd6Ke2pFG+Hqf2dUftYyzFDC
	 6YQdJhz70qAG23Z7IImPOwzdQ9dz4iBxizTAZG6ZeKZ46qA3pCPzwdfmUD8PFltc6hrBBGeAzCTv
	 BSDweV68npXjf382Jjm6+LVbixWlRDIf3lnlu14fCoMYQwb4i2JCO6BEF8eaECgtBHaNNafaGZ5T
	 TmxSsLePzsIuXWHCE3n5tHncA9HLO0lfgDelPv7lJAxBQ9yATKvo/+lpIxUYdxYbas7cwm8bCR9f
	 aG0iBZL4uBEJ+N/l7emvrwZmm2iQTDO0P9aCl2ktJqZ7MTO26iHdPhS+kWnlIj
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: linux-next: manual merge of the riscv-dt tree with the risc-v
 tree
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240411094901.2130c36e@canb.auug.org.au>
Date: Fri, 12 Apr 2024 09:49:58 +0800
Cc: Conor Dooley <Conor.Dooley@microchip.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul@pwsan.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <0DA22639-19D6-4766-AD5D-9A0A3B6CB2AB@cyyself.name>
References: <20240411094901.2130c36e@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On Apr 11, 2024, at 07:49, Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Hi all,
>=20
> Today's linux-next merge of the riscv-dt tree got a conflict in:
>=20
>  arch/riscv/Makefile
>=20
> between commit:
>=20
>  3b938e231b66 ("riscv: merge two if-blocks for KBUILD_IMAGE")
>=20
> from the risc-v tree and commit:
>=20
>  ef10bdf9c3e6 ("riscv: Kconfig.socs: Split ARCH_CANAAN and =
SOC_CANAAN_K210")
>=20

I am the author of this commit. I just renamed CONFIG_ARCH_CANAAN to
CONFIG_SOC_CANAAN_K210 in arch/riscv/Makefile.

> from the riscv-dt tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your =
tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any =
particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/riscv/Makefile
> index 7c60bbe1f785,fa6c389c3986..000000000000
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@@ -143,15 -133,7 +143,15 @@@ boot :=3D arch/riscv/boo
>  ifeq ($(CONFIG_XIP_KERNEL),y)
>  KBUILD_IMAGE :=3D $(boot)/xipImage
>  else
> - ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
> ++ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN_K210),yy)

I reviewed commit 3b938e231b66 ("riscv: merge two if-blocks for
KBUILD_IMAGE"). Your change only replaces the ARCH_CANAAN symbol with
SOC_CANAAN_K210 here. My intention for ef10bdf9c3e6 ("riscv: =
Kconfig.socs:
Split ARCH_CANAAN and SOC_CANAAN_K210") is to use loader.bin only for
Canaan K210 SoC but not for other Canaan SoCs. So I think that's the =
right
way to resolve merge conflict.

Reviewed-by: Yangyu Chen <cyy@cyyself.name>

> +KBUILD_IMAGE :=3D $(boot)/loader.bin
> +else
> +ifeq ($(CONFIG_EFI_ZBOOT),)
>  KBUILD_IMAGE :=3D $(boot)/Image.gz
> +else
> +KBUILD_IMAGE :=3D $(boot)/vmlinuz.efi
> +endif
> +endif
>  endif
>=20
>  libs-y +=3D arch/riscv/lib/


