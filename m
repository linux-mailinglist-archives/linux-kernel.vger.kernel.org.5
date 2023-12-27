Return-Path: <linux-kernel+bounces-12292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EF481F26B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC111C21A01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEE24988C;
	Wed, 27 Dec 2023 22:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="krCSo3aN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DB72CCCA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbe02bb7801so997615276.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703715647; x=1704320447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tJU9l/YnXSfJWcO+44BoHgFXGz2Qdb3kbK4CGXTYLI=;
        b=krCSo3aNisaOVH5pSDD6S+qagJRN6AMSVU1nwSvMlSn6a4rg2AJwcOXAsezhforU4/
         QCIW/UiGV1NIPp6kVh+vqYJB3N+T4f/nZWL6b/8+ulwxoWN8XaRmLQZh+aOXNWFYAezh
         C/GCHenG9uKkq0cXOJiSD+duwyWToXM3Q9wDhj3FEdykZSnMoUGX1S1BZqkbpwje77OU
         rTNVQOb5DeKcXAQ94lZJ8TmF54xT4OoclymsTEwIGZAbx+j9kt6o7JeLNyHbTPT6+SRX
         Uaa+zrV0wztriByw+vzOZWd5Dvyl+6Jt2K5oiCImpY56Eci+0OXbw4WMsVHW+H6YHyR9
         E+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703715647; x=1704320447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tJU9l/YnXSfJWcO+44BoHgFXGz2Qdb3kbK4CGXTYLI=;
        b=qKtR2kC8ovEYnYO++JDfrV05XuJQ4u/BpUqMtUzflcOG/ZD+TJ1UlYPd6bNe+dZBYL
         FJSGvf28AbiozNSUQKwbQmA4HMmKXcevFs7eb+G58iGAVu42vo40C3ejmRRXSJiV3WTB
         4qn5HvwAxbCF0bIhP89kAx/BA6ebFkAynbKvQydCMXzDYl04jjoCEo/ukI4ZPENdGNEF
         6avHlnPP59Gv+XQhTw+gzn90y0wIHYzBYvPdCovpZcefK2TlWYZIenjF1DPGYVSzzoje
         SZxdW7s6lxYQhjQMqgCxzFjYC0aDh68sdYFwwtDst5wGsj04rGPoFMa2oZWaRPHPwRF8
         KSBw==
X-Gm-Message-State: AOJu0YzdvI2n7YauT9ss4gYqGpsEoZeVTOSxi9Ha/VKU//PMlpVwU8he
	pZgMSF2c+Yvm/YHlUDxDfcrKLZ2WCX5gK3p0x73iGfx5Pcpbcw==
X-Google-Smtp-Source: AGHT+IEHTZhlfm58S4gMevFkW7mXC+BltaXElG8mlV1aIzlykceOCs1WQVuqtwOEARkspBUD8pMj3swGMGJFDQZ9q/0=
X-Received: by 2002:a25:ff11:0:b0:dbd:998:5fbb with SMTP id
 c17-20020a25ff11000000b00dbd09985fbbmr3007264ybe.99.1703715647217; Wed, 27
 Dec 2023 14:20:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222235248.576482-1-debug@rivosinc.com> <20231227134514.13629032c39decdf1dddcc75@linux-foundation.org>
In-Reply-To: <20231227134514.13629032c39decdf1dddcc75@linux-foundation.org>
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 27 Dec 2023 14:20:36 -0800
Message-ID: <CAKC1njTry42zAkZWq3pAgoe3YFaHN6UcB4i56BDQRxYbTEigRw@mail.gmail.com>
Subject: Re: [PATCH v1] mm: abstract shadow stack vma behind arch_is_shadow_stack_vma
To: Andrew Morton <akpm@linux-foundation.org>
Cc: rick.p.edgecombe@intel.com, broonie@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 1:45=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 22 Dec 2023 15:51:04 -0800 Deepak Gupta <debug@rivosinc.com> wrot=
e:
>
> > x86 has used VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) to encode shadow
> > stack VMA. VM_SHADOW_STACK is thus not possible on 32bit. Some arches m=
ay
> > need a way to encode shadow stack on 32bit and 64bit both and they may
> > encode this information differently in VMAs.
>
> Is such a patch in the pipeline?  Otherwise we're making a change that
> serves no purpose.

Yes I do have patches in the pipeline for riscv.
On riscv, presence of only `VM_WRITE` (i.e. (flags & (VM_READ |
VM_WRITE | VM_EXEC))
=3D=3D VM_WRITE) would mean a shadow stack.
And yes there would be  relevant patches to ensure that existing consumers =
using
`PROT_WRITE` gets translated to (VM_WRITE | VM_READ)

>
> > This patch changes checks of VM_SHADOW_STACK flag in generic code to ca=
ll
> > to a function `arch_is_shadow_stack_vma` which will return true if arch
> > supports shadow stack and vma is shadow stack else stub returns false.
> >
> > ...
> >
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -352,8 +352,21 @@ extern unsigned int kobjsize(const void *objp);
> >   * for more details on the guard size.
> >   */
> >  # define VM_SHADOW_STACK     VM_HIGH_ARCH_5
> > +
> > +static inline bool arch_is_shadow_stack_vma(vm_flags_t vm_flags)
> > +{
> > +     return (vm_flags & VM_SHADOW_STACK) ? true : false;
> > +}
>
> The naming seems a little wrong.  I'd expect it to take a vma* arg.
> Maybe just drop the "_vma"?

Well I did start with taking vma* argument but then realized that
`is_stack_mapping`
only takes vma flags. And in order to change that I would have to
change `vm_stat_account`
and every place it's called.

In the next version I'll either do that or drop `_vma` from the
proposed function name.

>

