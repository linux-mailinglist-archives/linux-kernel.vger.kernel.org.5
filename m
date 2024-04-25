Return-Path: <linux-kernel+bounces-158791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71178B24F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA831C21FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B0E14AD3A;
	Thu, 25 Apr 2024 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="f3Ob8V05"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D514A638;
	Thu, 25 Apr 2024 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058535; cv=none; b=eZVz53xVJUeIbAOnSOEE+KFA8UWoFjT8Ylbge9uprGbuzdU4zwyteplwrMhCfxDrMqBTQMBk3e9EhHh4hdlFo57ONjdLMYWIzE4queFeUTGcWvWykU6P//Uccz1l8VMN7t5EKOT6M222KowQkqaKkGX0yt1RtLU2zig9J/QNnBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058535; c=relaxed/simple;
	bh=jizBKTX8MvHG0cRj+2IzEtYv+6KlE66nInc7exVUWzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPIS6XkjhuHnBuRhGrHHqZVKiZdri71xfcztPAtYOp6YDgTc9opImxqDo4IFi5JMHbynjTrvrwGMUmo0MY6rL1RTIjUO8wcoNnxBTI2HWb/wcX89L8Qd/A3432M7u6t5rWnqcGhQlu18kVQoB3l+74/lDqwkDqIYWXdwemXwDsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=f3Ob8V05; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C72B740E01C5;
	Thu, 25 Apr 2024 15:22:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zo89ggfrjeLT; Thu, 25 Apr 2024 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714058521; bh=6wNh2/5WJqAiPo6RPMCDTroIUccA+3uUajnQfIANALw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3Ob8V057rdVSck90A83wZXeph/7GtAdQYLuTScSMYcMsRlDy322GITOZB08R+2zH
	 WJAQPRKWgI6rGP5DekauVZRYVC6v+x0djmLHr4YM5x8Sn+yE6qw1+Tuw/dFLoxEgMt
	 O4WWlkpuAoNiMRBJIWn6gaOqdtb0+P14QGl5fOYzlw1cGRu1xYEGnL3uxMdJKaBuJg
	 R2OzjcscwRkLGZGJ3L9V1kttt6yFvrs+wGpvAlQIdZqVA1JLfMMFfr74b67uvPbPRS
	 61vpzoxHqCtIK3bBjCPcbv3xBolTUaMjEqobmzgwaMNEViuOPbwbZLkVTaKtxPomon
	 3wS2TjSW3M4l/KPIhyPrbevzhE8yRvOBxhxxkhaB0armH29aAtv0vcphTaf+tTHM8k
	 69IEcBdf6tdGFrOUOn41HjjaBQyB0AtllH4DNANzvv/oerKUqq4NZ3AbGUpnosCefQ
	 SAsCoJR+lxGWQL67jAC4kRYHVm12uzQyPEE0QCcHZbba2O+TG2976Zb9N7UsemohsT
	 I9Y9qSmIgHdiLXC0hpawtrmiSpZ8y80rSue9T0oeWT5mdgSp2JwtFEfPzdeMkPY1Jv
	 YTBrtpi4DOkMmVnoT1dzUQF30BsuCRgLfSnbYez9K4Kdomax740C14p2fW3I3gfpbh
	 DxbQwYxgvWIRX+kxSk0WuNpo=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3D3DB40E0192;
	Thu, 25 Apr 2024 15:21:36 +0000 (UTC)
Date: Thu, 25 Apr 2024 17:21:30 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	hpa@zytor.com, dave.hansen@linux.intel.com, mingo@redhat.com,
	tglx@linutronix.de, x86@kernel.org, netdev@vger.kernel.org,
	richardcochran@gmail.com, linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com, zackr@vmware.com,
	linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
	timothym@vmware.com, akaher@vmware.com,
	dri-devel@lists.freedesktop.org, daniel@ffwll.ch, airlied@gmail.com,
	tzimmermann@suse.de, mripard@kernel.org,
	maarten.lankhorst@linux.intel.com, horms@kernel.org,
	kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v9 1/8] x86/vmware: Correct macro names
Message-ID: <20240425152130.GJZip0-l040XCyUapN@fat_crate.local>
References: <adcbfb9a-a4e1-4a32-b786-6c204d941e9f@broadcom.com>
 <20240424231407.14098-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240424231407.14098-1-alexey.makhalov@broadcom.com>

On Wed, Apr 24, 2024 at 04:14:06PM -0700, Alexey Makhalov wrote:
> VCPU_RESERVED and LEGACY_X2APIC are not VMware hypercall commands.
> These are bits in return value of VMWARE_CMD_GETVCPU_INFO command.
> Change VMWARE_CMD_ prefix to GETVCPU_INFO_ one. And move bit-shift
> operation to the macro body.

I don't understand:

$ git grep GETVCPU_INFO
arch/x86/kernel/cpu/vmware.c:51:#define VMWARE_CMD_GETVCPU_INFO  68
arch/x86/kernel/cpu/vmware.c:478:       VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);

so that's a VMWARE_CMD 68, at least the prefix says so.

And those two are *bits* in that eax which that hypercall returns.

Or are those two bits generic but defined in a vmware-specific
hypercall?

Hm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

