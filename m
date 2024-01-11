Return-Path: <linux-kernel+bounces-23335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4E382AB3A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA5D2B27211
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D9B14A9C;
	Thu, 11 Jan 2024 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdJvJaDW"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3FA1429F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4b74a9a9d4cso1538271e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704966538; x=1705571338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eaM81UE8HNBCwln5s5TJQ6eHQuRiuHL2tpn+YpV4pcA=;
        b=AdJvJaDWTLBxh4UQ1ddX1nEUBNz/2Qe9P4wwum3PoWIl9TlgPuP8YNs3lheZPQpz8q
         bWGGYTnnDfQNbUQndnG4PT5FYmf+ZLIG/7MOp0SMADvBnbeERbOS6SyW2W/EAQ9tlEJE
         YuzmifAFrD+uiN8f3gSRnvhzeeL6BeJ61q/seZmdHFUsbV/OP6NTu9KhrwgXbN8G5cdn
         m4U3YbHhQ1IinzqK7kUxHVbkCxqOL/DkdqEzW5VXc/hqSZWH3+0xIoY3b5EdME3aq5Jz
         b7it8BYSWtNTJQl880dUtv0A6bYWMaEgrUYTVCJMUV+rmkJF4xFSk2FPMvtlY6M5+5s6
         /tuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704966538; x=1705571338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eaM81UE8HNBCwln5s5TJQ6eHQuRiuHL2tpn+YpV4pcA=;
        b=lvxD94bK2o8Tb466743x+LWyv9IJ4i92PkQ5u7vMtkBLTTrOIRJwKe4pVMUQVxGf3x
         EdJsE4lenR5uA4fhLBz6VSaBy9Qssd6le6S5Ss99gy8m4+urz/6s5HkRGXMzUr8+tyDL
         cB0stbmufQ+MVWMTh4DLDqnv6GPu2x9Wlk7ZzvsQSwL9VrVdp3eH+n6KgsijQRPFwfGS
         F9nsn7oxJE9ecS9hxQAMe/huAP1tOYN3v+OGzbWw16piyPiIMTmC4BSmuh1v1VHSRfRO
         zoTVdhNcGbi0EOL0UhBY+KfDEzutkFu8pNdDO3uIWlI9NbCpPGWkXc7MOxK27FL2Y4Sq
         cgOg==
X-Gm-Message-State: AOJu0Yyb1NUJ5IorXjuf3Fa5QOuA9L20gPz0p/ltC7bTVYJIVT5Xf/Fe
	cOktWfOCweuxrZut4pP2FvMctwiEmp9JwXe4ByEGThZJr8UR
X-Google-Smtp-Source: AGHT+IHOjyMfyL2jnUGJGBvS0vHHyjT8WL4gkvYRqPM9FPv9rtIY76L2L/PPfrYeqDs7i/HHossZLlXRco2LPjFq1Vo=
X-Received: by 2002:a05:6122:a20:b0:4b6:eb5a:ee98 with SMTP id
 32-20020a0561220a2000b004b6eb5aee98mr227842vkn.14.1704966537737; Thu, 11 Jan
 2024 01:48:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700502145.git.andreyknvl@google.com> <9f81ffcc4bb422ebb6326a65a770bf1918634cbb.1700502145.git.andreyknvl@google.com>
 <ZZUlgs69iTTlG8Lh@localhost.localdomain> <87sf34lrn3.fsf@linux.intel.com>
In-Reply-To: <87sf34lrn3.fsf@linux.intel.com>
From: Marco Elver <elver@google.com>
Date: Thu, 11 Jan 2024 10:48:19 +0100
Message-ID: <CANpmjNNdWwGsD3JRcEqpq_ywwDFoxsBjz6n=6vL5YksNsPyqHw@mail.gmail.com>
Subject: Re: [PATCH v4 12/22] lib/stackdepot: use read/write lock
To: Andi Kleen <ak@linux.intel.com>
Cc: Oscar Salvador <osalvador@suse.de>, andrey.konovalov@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 00:01, Andi Kleen <ak@linux.intel.com> wrote:
>
> Oscar Salvador <osalvador@suse.de> writes:
> >>
> >> With this change, multiple users can still look up records in parallel.
>
> That's a severe misunderstanding -- rwlocks always bounce a cache line,
> so the parallelism is significantly reduced.
>
> Normally rwlocks are only worth it if your critical region is quite long.
>
> >>
> >> This is preparatory patch for implementing the eviction of stack records
> >> from the stack depot.
> >>
> >> Reviewed-by: Alexander Potapenko <glider@google.com>
> >> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > Reviewed-by: Oscar Salvador <osalvador@suse.de>
>
>
> Has anyone benchmarked this on a high core count machine? It sounds
> pretty bad if every lock aquisition starts bouncing a single cache line.
>
> Consider using RCU or similar.

stackdepot is severely limited in what kernel facilities it may use
due to being used by such low level facilities as the allocator
itself.

I've been suggesting percpu-rwsem here, but looking at it in more
detail that doesn't work because percpu-rwsem wants to sleep, but
stackdepot must work in non-sleepable contexts. :-/

