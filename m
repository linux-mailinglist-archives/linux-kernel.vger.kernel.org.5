Return-Path: <linux-kernel+bounces-18301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B6D825B23
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A5C1C23989
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7D935F18;
	Fri,  5 Jan 2024 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AwPpw0Tp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FF635F0C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2046b2cd2d3so1241427fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 11:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704483465; x=1705088265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrOZywRVHYQrwYA4rEvbQOcCE+oYGeNQVUbfflcP1O8=;
        b=AwPpw0Tphp3fbFYYPoIYS3l2fzwPI7FZuvaKt+ycRxz2VmTgh4ojp1DLrZSdTOnJ6g
         BtAeHYG/qwzoZnRxTOKSvh4m6j/lDY8vLErNY19GAmguko+y2KQcsAtykqbMZFDgDXen
         MQnDnjpT+xrvYfR3UAaEm2g6v1W8nj2Oo76a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704483465; x=1705088265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrOZywRVHYQrwYA4rEvbQOcCE+oYGeNQVUbfflcP1O8=;
        b=t4RVDY6arLLH8FaUY6rNV/clFe5ppSCdXHVLIpUFC03w0GjKDc2WoN3RMQRlSH+sW3
         zs+ExelowLsNJi639XmInREdCD9ISlfgsoQCcRn9KW713TV6Dc826DgbgQWTWP2ChFyP
         aUMjpyKDNx8C0I8cd68agU0VcuPhlXr+lPgwTn3ixe7fBvt/nxWJ2VxwFJ7uhZkfn1xt
         ohjj1x7bU01HoVcDj8RW2WdCHZPi0kuOcnUwkMPAhHxwR+y3C/y+b9dTDIJLSurwchOQ
         zVzpfwl+nlge4IHkPg0zQZ2h4qu0QisV+/XlI5Y2CCHV2Zz3UUr/AjJOLOe3dOu8t0Yo
         5TCA==
X-Gm-Message-State: AOJu0YzsF+qq/eMlv+jVKrylw8aj2Vr8VKwCEHK/jcY22g1lCZVYwJHU
	KF6RycWvtY2JyAg9TcpqA7cb0v8m37o31Bb9IjdnRekOoZEF
X-Google-Smtp-Source: AGHT+IF+iHC1gEAXC43HF3ocZtXJBAdcsjjaDe5rzg2X0p+MIUjbNDmhc5uxVg01loIn0VUHcHP25gmmMl2GNf+rx+4=
X-Received: by 2002:a05:6870:a19f:b0:203:c869:cd44 with SMTP id
 a31-20020a056870a19f00b00203c869cd44mr2937532oaf.92.1704483465420; Fri, 05
 Jan 2024 11:37:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104185138.169307-1-jeffxu@chromium.org> <20240104185138.169307-5-jeffxu@chromium.org>
 <796b6877-0548-4d2a-a484-ba4156104a20@infradead.org>
In-Reply-To: <796b6877-0548-4d2a-a484-ba4156104a20@infradead.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 5 Jan 2024 11:37:34 -0800
Message-ID: <CABi2SkWF8sVeqjOar8MMftEv-piZuLtb8Pt5Bz7dNTekcwzByg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/4] mseal:add documentation
To: Randy Dunlap <rdunlap@infradead.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 3:47=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
>
>
> On 1/4/24 10:51, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add documentation for mseal().
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  Documentation/userspace-api/mseal.rst | 181 ++++++++++++++++++++++++++
> >  1 file changed, 181 insertions(+)
> >  create mode 100644 Documentation/userspace-api/mseal.rst
> >
> > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/user=
space-api/mseal.rst
> > new file mode 100644
> > index 000000000000..1700ce5af218
> > --- /dev/null
> > +++ b/Documentation/userspace-api/mseal.rst
> > @@ -0,0 +1,181 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Introduction of mseal
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +:Author: Jeff Xu <jeffxu@chromium.org>
> > +
> > +Modern CPUs support memory permissions such as RW and NX bits. The mem=
ory
> > +permission feature improves security stance on memory corruption bugs,=
 i.e.
> > +the attacker can=E2=80=99t just write to arbitrary memory and point th=
e code to it,
> > +the memory has to be marked with X bit, or else an exception will happ=
en.
> > +
> > +Memory sealing additionally protects the mapping itself against
> > +modifications. This is useful to mitigate memory corruption issues whe=
re a
> > +corrupted pointer is passed to a memory management system. For example=
,
> > +such an attacker primitive can break control-flow integrity guarantees
> > +since read-only memory that is supposed to be trusted can become writa=
ble
> > +or .text pages can get remapped. Memory sealing can automatically be
> > +applied by the runtime loader to seal .text and .rodata pages and
> > +applications can additionally seal security critical data at runtime.
> > +
> > +A similar feature already exists in the XNU kernel with the
> > +VM_FLAGS_PERMANENT flag [1] and on OpenBSD with the mimmutable syscall=
 [2].
> > +
> > +User API
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +Two system calls are involved in virtual memory sealing, mseal() and m=
map().
> > +
> > +mseal()
> > +-----------
> > +The mseal() syscall has following signature:
> > +
> > +``int mseal(void addr, size_t len, unsigned long flags)``
> > +
> > +**addr/len**: virtual memory address range.
> > +
> > +The address range set by ``addr``/``len`` must meet:
> > +   - The start address must be in an allocated VMA.
> > +   - The start address must be page aligned.
> > +   - The end address (``addr`` + ``len``) must be in an allocated VMA.
> > +   - no gap (unallocated memory) between start and end address.
> > +
> > +The ``len`` will be paged aligned implicitly by the kernel.
>
> Does that mean that the <len> will be extended to be page aligned
> if it's not already page aligned?
>
Yes.
the code (do_mseal) calls PAGE_ALIGNED(len).
mprotect() also has this.

Two test cases cover this part.
test_seal_mprotect_unalign_len
test_seal_mprotect_unalign_len_variant_2

-Jeff

> --
> #Randy

