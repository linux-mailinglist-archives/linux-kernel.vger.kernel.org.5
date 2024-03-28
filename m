Return-Path: <linux-kernel+bounces-122515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4BF88F8EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1255DB25862
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082AC51C21;
	Thu, 28 Mar 2024 07:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b="hDEvtKWY";
	dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b="mmVn94K0"
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7180539FC6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611619; cv=none; b=goIWvbbrq5/Qm17UtI/gBAM6IHqVyEGW8Y1n4UXNPlvHMPeESUswC70RL+zH82dqxddsNo6dgKj8TDxXMRyIo6ktfnwH5Dop2sOtDpyoacHbY7CcmVjRStY7enpOVVD6h61xrkrTEQZAXw8cpeGYRAJsFQPYAgpwwkEewkZ06Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611619; c=relaxed/simple;
	bh=ZbOA7cQBnwcYuFarB35iNEmCOhuX3PT8ziPIpbB6uGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mnrxKFa7LaeZWmW9ocduMLqLCD5E8IpRRoDJGGi/IBZOPh2Z53ohH1i7SILAHI1tYXK2GQv1KTkpVfD3KOWYVSDm2068xGqOs3L0sDkExVsmR94qUdljITjsXJlaOnGJ2nkOKDxutmu7hrBLZuw3/Ub7gmmch6grkYZr1Zs/SDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com; spf=fail smtp.mailfrom=syntacore.com; dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b=hDEvtKWY; dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b=mmVn94K0; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=syntacore.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 6909EC0011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
	s=mta-04; t=1711611128;
	bh=/Rj61iC0oZxd7dGL2v5n+B0zL+Y+qY+UXJbpEedJLvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=hDEvtKWYhFo2AWZSmlNj5ja6wWfNlL51jNz7DCGFhB3Oiw/EurUXBEHYRWVN9+qHv
	 bWJGsm83AaFCb3RfhTEWCnjmasm/ww1uzvBBdidW1Ydai2aFVn1R7kv+Pphu8eYhwi
	 uf+5qKVpPfidLk066sQs0BZZzPdHiPNGEXO7OlF9KJLaUfEjmHiYc2UdKktwB3rA5N
	 vDlXtUCmdkpLCe7tMC1RRP2hHFAEljeAnh+CUMG32smpNVev0KQDfsAYtjwOZjo3rE
	 Spb4VpiFdesRzUBal8lDiTyVE2V/2epU4C53dvwcBL3t4unrAeFN4PAw/Ka0TQk5ls
	 MSQiKqVpIL1sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
	s=mta-03; t=1711611128;
	bh=/Rj61iC0oZxd7dGL2v5n+B0zL+Y+qY+UXJbpEedJLvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=mmVn94K0zC4przTgvepIALBY9SaSP2N+597VCWMcZV3Hx4tATYRfgRuhQVIYF+rH0
	 yr28VMLTqPDu+6XKr6RZMqdcDRIwTAnUFQl4kfGCP6dtgOTxN3K/A9E0/YzNItcNEK
	 a8qx6P+qgRBHQbVGph/jnNCk4riPjmHv0CaWGHGGIdcyP4JUbd+IUwxb5ezqOycs0d
	 Pr8DWmhVdYcsBlHtJDoFoYnIdXmLpeRjxljrAHgttR961f2GK7sC4LwrsJGqOB0iCo
	 9PbENpAvKyS9AvKRg1VbsrFwRT892defzSJR+IqwwfQugf2GWU9FHXyXyXcSEl2nl6
	 dTbXlez4LiGtw==
Message-ID: <352f8101-01c3-45b9-9d53-ef0021cc6f46@syntacore.com>
Date: Thu, 28 Mar 2024 10:32:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Check that vdso does not contain any dynamic
 relocations
To: Alexandre Ghiti <alexghiti@rivosinc.com>, Roman Artemev
	<roman.artemev@syntacore.com>, Guo Ren <guoren@kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240326113831.283025-1-alexghiti@rivosinc.com>
Content-Language: en-US, ru-RU
From: Vladimir Isaev <vladimir.isaev@syntacore.com>
In-Reply-To: <20240326113831.283025-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 S-Exch-01.corp.yadro.com (10.78.5.241)

Hi Alexandre,

26.03.2024 14:38, Alexandre Ghiti wrote:
> 
> Like other architectures, use the common cmd_vdso_check to make sure of
> that.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/vdso/Makefile | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index 9b517fe1b8a8..dd4877f25928 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -49,7 +49,7 @@ $(obj)/vdso.o: $(obj)/vdso.so
> 
>  # link rule for the .so file, .lds has to be first
>  $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
> -       $(call if_changed,vdsold)
> +       $(call if_changed,vdsold_and_check)
>  LDFLAGS_vdso.so.dbg = -shared -S -soname=linux-vdso.so.1 \
>         --build-id=sha1 --hash-style=both --eh-frame-hdr
> 
> @@ -69,7 +69,8 @@ include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
>  # actual build commands
>  # The DSO images are built using a special linker script
>  # Make sure only to export the intended __vdso_xxx symbol offsets.
> -quiet_cmd_vdsold = VDSOLD  $@
> -      cmd_vdsold = $(LD) $(ld_flags) -T $(filter-out FORCE,$^) -o $@.tmp && \
> +quiet_cmd_vdsold_and_check = VDSOLD  $@
> +      cmd_vdsold_and_check = $(LD) $(ld_flags) -T $(filter-out FORCE,$^) -o $@.tmp && \
>                     $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@ && \
> -                   rm $@.tmp
> +                   rm $@.tmp && \
> +                   $(cmd_vdso_check)

For some reason I thought that this check is in the common vdso code and just missed hwprobe relocation...

Tested-by: Vladimir Isaev <vladimir.isaev@syntacore.com>

> --
> 2.39.2
> 

Thank you,
Vladimir Isaev

