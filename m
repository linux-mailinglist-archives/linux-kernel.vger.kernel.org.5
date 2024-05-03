Return-Path: <linux-kernel+bounces-167521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1088BAAC2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D7C1C218D9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F98152176;
	Fri,  3 May 2024 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="DOsfCdzb"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E08D152173;
	Fri,  3 May 2024 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714732292; cv=none; b=gsTPPAyGgW21oVTb3T0/slF4fOsyt/xe195YAxGoenj6o4TQkjNa153uj9M0Aga45/DT8taux7NyhS7CbNX0NwgrypNyR7PS4lud4uQjii0n6SCKW7jBU5130SsLTl+5PWX5DmAFR5S5yWAH2NBYqr7kerSGWBOnTwsMphK9wes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714732292; c=relaxed/simple;
	bh=/VYcrI5lgQGb2p+gY8ksuATjQzg17sttS0+fWfOnvZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WV797/LybaYaCFbadlUCkjMFxuAMCFqvXbOW7A/EBgBcDQnXTfA3wFjL71NitKfVlvp9pD70V4YTj9nkKbv+0CnxMXy14zree4yZNLtmCVHG7BjGAW1BvfNjbqLzDZcO9ZLu145zTfBK8+iLwptmV/bNmy+ylHxf3JuoARZ9BDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=DOsfCdzb; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1714732286;
	bh=TIJc0C8VYI8NP8T6hYxCZ0p55TU3pPioI63BIn1neXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DOsfCdzbo/QkOFusLlMfAQECua0i8qmby3YWGrPVdXT/SpMWYUE+K7j4vWvgtVQ3x
	 hZ43szoi/d2SMlQpZEJ1Ej9Ju6KxOD9a99mLh7ApID9yQNZdkIlhPhECCNEMYiNkxR
	 KoFBt3grljGCxECdyNggoYvqK6v2YFFmQHY7gtxeh+MmU7Kk6kRhP6Rtt9ptPVL8lJ
	 GUAkxOVK7T4BPIxZ+gnO2VJ6YJgPwwA8nXyZ3OL++de8kyAmBNRcKIzJjt/yHKR1Hc
	 WAFqOqbeJKE/ZTO8t5kU59JyqbcS374agfuaiOzvmMqnU+DYPlLSHhDpyu3I3LZDiJ
	 bnntoOkp+Ytyw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VW6Xt5JkVz4wnv;
	Fri,  3 May 2024 20:31:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: manoj@linux.ibm.com, ukrishn@linux.ibm.com, fbarrat@linux.ibm.com
Subject: Re: [PATCH 2/2] MAINTAINERS: Make cxl obsolete
In-Reply-To: <2492716e18c515e21b855305c0bc760057dbcf7a.camel@linux.ibm.com>
References: <20240409031027.41587-1-ajd@linux.ibm.com>
 <20240409031027.41587-2-ajd@linux.ibm.com> <87bk6jb17s.fsf@mail.lhotse>
 <33cf08b4fe751af156b1a7c17f69a0ca37dc5eed.camel@linux.ibm.com>
 <2492716e18c515e21b855305c0bc760057dbcf7a.camel@linux.ibm.com>
Date: Fri, 03 May 2024 20:31:24 +1000
Message-ID: <87le4ruqyr.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Donnellan <ajd@linux.ibm.com> writes:
> On Fri, 2024-05-03 at 13:15 +1000, Andrew Donnellan wrote:
>> This doesn't seem quite right to me, I don't think we can just
>> redefine
>> CONFIG_CXL as a bool, but I'll do something like this. Probably won't
>> bother for CXLFLASH since they'll see it for CXL anyway, but I might
>> add a warning message on probe to both drivers.
>
> The more I look at how to do this, the more issues I see, though
> perhaps because I personally use olddefconfig more than I use
> oldconfig.
>
> Without changing the default to n, running olddefconfig is liable to
> switch CXL back on in configs where the user has disabled it.

Yes that's true.

> Conversely, if the user has set CXL=y rather than CXL=m, I'm not sure
> if there's any way to make it such that olddefconfig doesn't reset one
> symbol or the other to the default m.
>
> Honestly, I'm very tempted to be a little more aggressive and a) not
> bother with trying to play games with symbols, b) change the default to
> n in this release, c) add a warning printed on probe, and see whether
> anyone complains.

You mean just changing CXL to default n?

The problem is that has no effect on folks with existing configs. Those
of us who build from defconfigs will have it turned off, but any actual
users with existing configs will just still have it enabled.

I'm not really convinced printing warnings does much. I guess an actual
WARN_ON might work, but only if someone is watching the console.

> We could also print a message during the build itself, though that kind
> of noise is liable to break things in other ways?

More likely to break some CI somewhere, and a good chance it isn't even
seen by a human unless they're paying close attention to the build
output.

> It would be kind of nice if kbuild had some way to mark a symbol for
> deprecation which could print a warning during configuration.

Yeah, though it suffers from the same problem that there's a good chance
no one notices.

The below I think works. It does print a warning about CXL changing from
tristate to bool, but that seems harmless.

In all cases olddefconfig will turn CXL off, whether it was on, off
or =m beforehand. A fresh defconfig has it off. The only way to turn it
on is explicitly.

cheers

diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
index 5efc4151bf58..e62c16cc7292 100644
--- a/drivers/misc/cxl/Kconfig
+++ b/drivers/misc/cxl/Kconfig
@@ -9,11 +9,18 @@ config CXL_BASE
        select PPC_64S_HASH_MMU

 config CXL
-       tristate "Support for IBM Coherent Accelerators (CXL)"
+       def_bool y
+       depends on DEPRECATED_CXL
+
+config DEPRECATED_CXL
+       tristate "Deprecated support for IBM Coherent Accelerators (CXL)"
        depends on PPC_POWERNV && PCI_MSI && EEH
        select CXL_BASE
-       default m
+       default n
        help
+         The cxl driver is no longer actively maintained and we intend to
+         remove it in a future kernel release.
+
          Select this option to enable driver support for IBM Coherent
          Accelerators (CXL).  CXL is otherwise known as Coherent Accelerator
          Processor Interface (CAPI).  CAPI allows accelerators in FPGAs to be

