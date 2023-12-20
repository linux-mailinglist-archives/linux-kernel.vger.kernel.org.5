Return-Path: <linux-kernel+bounces-6954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 820EA819FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668901C2285A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909522D638;
	Wed, 20 Dec 2023 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ciger4O+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E758221A02
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703078860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oKIB9gFYr7Un1QLzbk3UPXWE4HqA26pp2IjPiB0lSto=;
	b=ciger4O++PXytOTjomWm0CcgwrIexlO0h1J4j4dmYjzcakeXNXquhn4r5iv9n3tNu5PFeK
	TuaVYJqNAzdhE53PTp2T7n+KWMGRxD8fjIuvhDGIuz+k0k1b5UUiCCifs28SMQ3NOw5HjT
	Tn/Gb5XkF0jKVqeyoGru2qx7x+BJiqg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-cz9FcmV8NIeYvcpQSrSHhg-1; Wed, 20 Dec 2023 08:27:37 -0500
X-MC-Unique: cz9FcmV8NIeYvcpQSrSHhg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61A41836F21;
	Wed, 20 Dec 2023 13:27:36 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AF0B92166B31;
	Wed, 20 Dec 2023 13:27:35 +0000 (UTC)
Date: Wed, 20 Dec 2023 21:27:32 +0800
From: Baoquan He <bhe@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: arch/sh/kernel/relocate_kernel.S:38: Error: invalid operands for
 opcode
Message-ID: <ZYLrxFyei79R5D8N@MiWiFi-R3L-srv>
References: <202312182200.Ka7MzifQ-lkp@intel.com>
 <ZYJ/M1HZ9ITfs4qe@MiWiFi-R3L-srv>
 <20231220060030.GV1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220060030.GV1674809@ZenIV>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 12/20/23 at 06:00am, Al Viro wrote:
> On Wed, Dec 20, 2023 at 01:44:19PM +0800, Baoquan He wrote:
> 
> > >    arch/sh/kernel/relocate_kernel.S: Assembler messages:
> > > >> arch/sh/kernel/relocate_kernel.S:38: Error: invalid operands for opcode
> > >    arch/sh/kernel/relocate_kernel.S:41: Error: invalid operands for opcode
> > >    arch/sh/kernel/relocate_kernel.S:126: Error: invalid operands for opcode
> > >    arch/sh/kernel/relocate_kernel.S:129: Error: invalid operands for opcode
> > 
> > I reproduced this error, haven't got why and a way to fix it, will come
> > back later if I have fix.
> 
> At a guess - after that commit ARCH_SUPPORTS_CRASH_DUMP is enough to enable CRASH_DUMP,
> which selects KEXEC_CORE regardless of ARCH_SUPPORTS_KEXEC.  And on sh you have
> the former selected on any UP build, while the latter - only on MMU ones (i.e.
> not SH2).

Yeah, you are right. I managed to set CONFIG_CPU_SH4=y and CONFIG_MMU=y,
the building passed.
---------------------
CONFIG_CPU_SH4=y
CONFIG_CPU_SH4A=y
CONFIG_CPU_SHX2=y
...
CONFIG_MMU=y
...
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_CRASH_DUMP=y
-----------------------------

Since the kexec_core code building depends on CONFIG_MMU=y, we may
need to add dependency on MMU for ARCH_SUPPORTS_CRASH_DUMP. I made below
change, do you think it's OK?

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 7500521b2b98..fe1500871648 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -548,6 +548,7 @@ config ARCH_SUPPORTS_KEXEC
 
 config ARCH_SUPPORTS_CRASH_DUMP
        def_bool BROKEN_ON_SMP
+       depends on MMU
 
 config ARCH_SUPPORTS_KEXEC_JUMP
        def_bool y


