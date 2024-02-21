Return-Path: <linux-kernel+bounces-74901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233EB85DFC5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CEE2861BD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A333F7F7DC;
	Wed, 21 Feb 2024 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GlyxbrQ8"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9091E4AF;
	Wed, 21 Feb 2024 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526003; cv=none; b=aEbw1861quMGRIcKI3mBndcyw8VlYj9kfsw7X4GiaPyM/eJpxdg4av8f9sozFupfym4JAz+H5cCJ6TTCIozW07Ln8iC+m7gPoPS+sjzSHKYTDW79Vkt99C8HZCpJR3tkImCxUQmlqGT+ZEJQt0mccFaW8g4LLnMJVy6tJnT9Tc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526003; c=relaxed/simple;
	bh=Wc428/NF3UCWmMZpleDfxN9wyCJ3mPXf/MXkk7fNIwE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LT1/WnabxsmYt6bCYnOUL7WqDcf7fuieouSWiHKGeTz5fEURUZ6sw2EsHka7v+zaEAEIbhJrKptTcml9o76OlbdxgrU3eGIM+igSxJ8DfD1yqgQAz3X/YXZisCAGIYwwBDdPeZROiEbnI9rh30Xwbc84KjcoEflxyl75ZMgbHOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GlyxbrQ8; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708525690; bh=Wc428/NF3UCWmMZpleDfxN9wyCJ3mPXf/MXkk7fNIwE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GlyxbrQ8JKpJ+9lA2hTakh30wGJzeSasfbdTiIjRjPOoYio7hAup7UU7eggZKvaF7
	 aO1ErsbJ7lB3amQJH4b24OJAJEtdlph18/PDPxyuSdBnWODY8f/Wxlu9W8Yaeaia03
	 UpTvi8r5uH+7ftGdTjmC0EofCZzpMy3mBg7T63TY=
Received: from [127.0.0.1] ([240e:379:2240:ef00:159c:db93:bdcd:c9c6])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 70827887; Wed, 21 Feb 2024 22:28:08 +0800
X-QQ-mid: xmsmtpt1708525688t0nbwvoqg
Message-ID: <tencent_DF3D7C2E8248DA188E3FB8DF31FE21478D08@qq.com>
X-QQ-XMAILINFO: NdRzF9Zpj4ldhvkRO4Jn+nI5lMyK6PMRWyr9/3cjs4uG8JXjcWebYVbF2ZoF0D
	 QkDwfOpT0ooFKZXnRhQZL6/O+gTx/dAF74IiJGBBwKH6HzbGW3+GdQUVv/5lBGas08RdhaCYw6fB
	 wF8JJUUoRCFasl2lJg7bPoOMtwI81wI9K1v7O/svR2VirizWsg5tIbBE6EIjMa3VI02Mc1cdqpt/
	 OsCVrQawh9dY5xSrCufqDW9DgvVaXT41Olj9cxSkvy1uGtZS1gvXv2VKxjl37RiepW0kkFU7LeVl
	 sJzKxDp/zRTFvNxCU95V5TpYM3BmJFwsq1lCtpMb2VNd56B5qn2w5+RQcyQAfHkClSeZkagH1VEX
	 PvsbIAQ0W2RsEWXQq21VLQCOca640pRimI+1dJVLmUqsEDGLrIUgEVKrSfdvxkkSZ3F+SGXviTpv
	 JoK7jvyizyvFKQO0jStQ/aT70brjFjYJfqSDB6gyVgscKrcHi899137rYG64kSXKESZF8rXLSHEZ
	 cA6Q/P4yHD9yJ/tjDPBjjPuHeiUoBLo+RVod8bDw6WHd/7bwWUEKboywP1VpDMQaNINm8HhzZPSP
	 H5HWY9aYWc+JQ2BwxcX8P+ssEri6RnzxMRA8t4kfwY8/ou1x7KWZl7iOgPjre7/kIOr3xeVkpeQ7
	 V8ocZjhfvsVY/gcUJypSlXxPzs0ko4gEzcO53m1DW3LPJI/HQBShiW0E1gLAsNFEQuPTHErb4BdR
	 VttGWBhmgaxbueklyQwtJq6u8yjDNwS8KvnH66XtG5lKYL56RHNe6CEJoTGu8c+32fQMdEAWNMLN
	 FNk9Qzd/G/oN7LlN572zeg6tQvb7uYf2DGLKVLX/gUXdrqonmJXB/USi28nMy3QT/rNtD/VJbi2O
	 NA6hpQuj8/x9TqlY93WJgP9w2PJZgcKb4RT4i4MzKArssxVj/6v4na9WHj/8W0NBHcB3ojOW8T5/
	 PimedPC8dQM6kgb8l/TldAzr6W2E0TE7l+mY60Uatdb84CzUNNDYWaWQ6/vlFbr5K+JIxp+iU=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-OQ-MSGID: <c6dd5cb481328dd3f75bc2e476d9c6d69031c43b.camel@cyyself.name>
Subject: Re: [RFC PATCH 0/1] riscv: dts: Allow BUILTIN_DTB for all socs
From: Yangyu Chen <cyy@cyyself.name>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley
 <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org, Masahiro Yamada
 <masahiroy@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Rob Herring
 <robh+dt@kernel.org>,  devicetree@vger.kernel.org
Date: Wed, 21 Feb 2024 22:28:08 +0800
In-Reply-To: <20240221-islamic-quartered-3863e44bc862@spud>
References: <tencent_AB625442CC1BCFF86E04D7B5891C43719109@qq.com>
	 <20240221-islamic-quartered-3863e44bc862@spud>
Autocrypt: addr=cyy@cyyself.name; prefer-encrypt=mutual;
 keydata=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
	0mslfht1JyMf5dUi38RQI/fOO0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-21 at 11:30 +0000, Conor Dooley wrote:
> Hey,
>=20
> On Wed, Feb 21, 2024 at 03:01:53AM +0800, Yangyu Chen wrote:
> > The BUILTIN_DTB kernel feature on RISC-V only works on K210 SoC
> > only. This
> > patch moved this configuration to entire riscv.
>=20
> To be honest, I would rather delete BUILTIN_DTB (and the
> configurations
> that depend on it) than expand its usefulness.
>=20

I agree it=E2=80=99s useless for most platforms because we need to start SB=
I
before kernel on RISC-V except NOMMU M-Mode Linux and SBI also need a
DT to work. However, it has been there for M-Mode K210 and it is set by
default for XIP kernel. So there might eventually be another patch to
support some new soc that will do this like this patch.

> > Although BUILTIN_DTB is not a good choice for most platforms, it is
> > likely
> > to be a debug feature when some bootloader will always override
> > something
> > like the memory node in the device tree to adjust the memory size
> > from SPD
> > or configuration resistor, which makes it hard to do some
> > debugging.
>=20
> My inclination here is to say "fix your bootloader" and if that's not
> possible, chainload a bootloader that allows you control over
> modifications to your devicetree.
>=20

Chainload a bootloader like S-Mode U-Boot on some platforms is hard due
to some drivers like pcie controller does not come to the mainline repo
of the bootloader, and some bootloader source repos provided by the
vendor may require specific versions of the compiler to work, which
makes users not easy to do some kernel debugging if change DT is
needed. The simplest way to do this I can imagine is to write a simple
bootloader by myself link the kernel binary and the dtb I want to it
and replace the a1 register point to the dtb address before jumping to
the kernel. However, kernel has this feature, why should I do it
manually rather than provide a more generic patch for everyone with
this need to use?

> > As an
> > example, some platforms with numa like sg2042 only support sv39
> > will fail
> > to boot when there is no ZONE_HIGHMEM patch with 128G memory. If we
> > want
> > a kernel without this patch to boot, we need to write the memory
> > nodes=20
> > in the DT manually.
>=20
> If, as Alex suggests, there's a way to gain support some more memory
> in
> sv39, we should do so - but it is worth mentioning that highmem is on
> the
> removal list for the kernel, so mainline support for that is highly
> unlikely.
>=20

Yes. But I=E2=80=99m debugging some mm performance issues on the sg2042 ker=
nel.
Specifically, it=E2=80=99s about the IPI latency when doing rfence on
sfence.vma or fence.i. I would like to reduce the memory size and allow
the mainline kernel to boot and test without taking some out-of-tree
kernel patches. If I remove some DIMM modules from the board to reduce
the memory size, it will also lose some memory channels and even leave
some numa nodes with zero memory, and the compatible DIMM module is
hard to find.

> > Also, changing DT on some platforms is not easy. For Milk-V
> > Pioneer, the
> > boot procedure is ZSBL -> OpenSBI -> LinuxBoot -> Linux. If DT gets
> > changed, OpenSBI or LinuxBoot may refuse to boot. And there is some
> > bug on
> > LinuxBoot now which does not consume --dtb argument on kexec and
> > always
> > uses DT from memory.
>=20
> I don't use Linuxboot, but let me try to understand. Linuxboot uses
> kexec
> to boot the main Linux kernel, but the dtb you want to use is not
> used, and
> instead the one that Linuxboot itself was booted with is used?
>=20
> It sounds like Linuxboot has a --dtb argumet that is meant to be used
> to
> set the dtb for the next stage, but that argument is being ignored?
>=20

Yes. That=E2=80=99s correct.

> That sounds like a pretty serious issue with Linuxboot which should
> be
> fixed - what am I missing?
>=20


Sure, that should be fixed in the LinuxBoot. However, I think not every
kernel developer should fix some complex bootloader like LinuxBoot
which is built upon the linux kernel with a huge initrd rootfs and runs
some userspace tools to support the boot process. If something is hard
to control, skip it, and doing some override for debugging will be a
better choice.

> > So I would like to do debugging on DT using
> > BUILTIN_DTB, which makes it very simple,
>=20
> > I can even install the kernel in
> > the distro's way and provide a kernel package for other users to
> > test.
>=20
> I'm not sure what you mean by this, other distros manage to create
> kernel packages without using builtin dtbs.
>=20

I mean I can provide a distro package like Debian .deb and distribute
it to other users to test without changing their dtb from the entire
boot process. Because changing the DT from the entire boot process
might prevent their vendor-provided OpenSBI or LinuxBoot from working.
Some vendor kernels may be developed out-of-tree and do not use the dt-
binding from mainline. Even for very basic CLINT and PLIC dt bindings.
It is only for testing, not for the production environment.

> Thanks,
> Conor.

I want this feature to allow more people to participate in debugging
some kernel issues without taking a huge amount of time to deal with
bootloader issues about changing the DT. I think it will be good for
our under-development RISC-V community. Imagine we hardly change the
ACPI table for x86 machines but we sometimes change the DT for
ARM/RISC-V board, right? Also, some SoCs that run M-Mode NOMMU Linux
may need it in the future like K210 for XIP without a prior bootloader.

Thanks,
Yangyu Chen.


