Return-Path: <linux-kernel+bounces-63724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D0E8533B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CDD1F2B43D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C205EE70;
	Tue, 13 Feb 2024 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="fxRUG6+y"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE226AD4;
	Tue, 13 Feb 2024 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836053; cv=none; b=Jiy3g/+7kSOcfKaAKr0Hv52TdutIIkrjcX2t1mbNkydZARrsvv4JyX2bTtRNEDFkjq+TJIF91ItcIRLerVRgrY9Iwqhmhk4aaYlkrhCDaKzz/be9t3GURZ1kc01R6fgAw02ccZjPy3ksAoILHr/s7yVjz0DuzJTI8/jgBF/UpGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836053; c=relaxed/simple;
	bh=K8jnAbBqeBhJFRVuQFwzQgzQsFNB5g/b5LfJqEQCsHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyDU0aH/xmZT5zuAw8Ivvy8Y+chxVcLWZ6SqykQEByD9EK0WwqrOgGHsbo6E3D8KlPqSkDK+6zrXqXJ9AFRiTdkItH3xgpkQEV47ukALdmpiKrQK6w2RohE7Hhkkr53LnGnjTr92n/kRcQu7l5jxsubLhlY1rLPt+0SH3S4sJ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=fxRUG6+y; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4TZ3yd4Dj4z681k;
	Tue, 13 Feb 2024 15:45:13 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4TZ3yH6LD4z67wS;
	Tue, 13 Feb 2024 15:44:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1707835513;
	bh=v6NrxM1eJN7Z7yzkWSBTKUltm5dbJ2HTXi9hG2LMSTA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fxRUG6+yBSU+BFXn6+rebuuiiuqqWopqe29Vz2GaIf78w+V69ZIB+Af31iKeLr62p
	 qpQdz7sWHzQ58CP3tqsZon5MfZ78+Sms5m4nebpjjUITGZQ1A2ZnKMsF4BxSh1OMBa
	 S898RixpmWtD3+3XqXRY4JGgZ7I8bBk64Oy1wp1k=
Message-ID: <4582ff28-a443-4b0f-ba92-f48c414e2248@gaisler.com>
Date: Tue, 13 Feb 2024 15:44:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build regressions/improvements in v6.8-rc1
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-mtd@lists.infradead.org,
 mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-hardening@vger.kernel.org, qat-linux@intel.com,
 linux-crypto@vger.kernel.org,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Netdev <netdev@vger.kernel.org>
References: <CAHk-=wiB4iHTtfZKiy5pC24uOjun4fbj4kSX0=ZnGsOXadMf6g@mail.gmail.com>
 <20240123111235.3097079-1-geert@linux-m68k.org>
 <d03e90ca-8485-4d1b-5ec1-c3398e0e8da@linux-m68k.org>
 <0229fa60-2d87-4b1c-b9f0-6f04c6e4dbdd@app.fastmail.com>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <0229fa60-2d87-4b1c-b9f0-6f04c6e4dbdd@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-23 15:21, Arnd Bergmann wrote:
>>>  + /kisskb/src/arch/sparc/include/asm/floppy_64.h: error: no previous prototype for 'sparc_floppy_irq' [-Werror=missing-prototypes]:  => 200:13
>>>  + /kisskb/src/arch/sparc/include/asm/floppy_64.h: error: no previous prototype for 'sun_pci_fd_dma_callback' [-Werror=missing-prototypes]:  => 437:6
>>
>> sparc64-gcc{5,11,12,13}/sparc64-allmodconfig
> 
> Andrew Morton did a patch for the sparc warnings, and Andreas Larsson
> is joining as a maintainer, so hopefully he can pick that up soon.
Which patch do you refer to here? I can not seem to find a patch fixing
these ones in particular on lore.kernel.org.

Thanks,
Andreas


