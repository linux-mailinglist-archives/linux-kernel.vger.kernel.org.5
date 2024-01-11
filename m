Return-Path: <linux-kernel+bounces-23003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C785582A644
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A691F22463
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2082EC8;
	Thu, 11 Jan 2024 02:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j9vfgpIm"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3F5A4A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-20503dc09adso3193028fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704941940; x=1705546740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iusV3IyQOZs3xOP+4u/FoLP2ed3pvxpbfjuW8JoG9bs=;
        b=j9vfgpImK4SrHWburcEebxx33c4qZ3HM34SDhqsD3U6lOcV+ODoYtvkQDlZJfPFTFz
         5wPTSB863fTsc539mdqLqP2TFOAYl4SV2fm7bJxB1Mu7y7zFByOz6HzvpscDfF/qQSTF
         uW7z22BOLcRTAamCMl+XlijTB14OO0oWA3mcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704941940; x=1705546740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iusV3IyQOZs3xOP+4u/FoLP2ed3pvxpbfjuW8JoG9bs=;
        b=uakq4EvZ3FbC6jTTp6RbdqQdRAYws7sycIYA2qYhmsRmEkx1f8sbI/YSBEZyBq6Yl3
         1I7Q8oANcLe8oF3m6MZEL02Sw8tuim2PDWZ4PvC4UO6cOuC1YkGLdzcjbBNNDJzdAFDk
         Qj10Tph+nn6mfA5Ae4De1/TZx8Md+0yFbKfnxTJmslUZ0tOfvgCs4vzumuidsNLKCycz
         qT4rspDkr9ilzmY+nZrNRg2s6u/CDMqfipEmauqxjkbIkjDYMgNneIV9ZeOlnasPt+v0
         la9Wx6aLH2UlUwfgCE2BwR2CzREsK8nN4H2ZxNAfh4gOeY7w7Zx7ysm1IKBiQXBAhNwp
         pHLw==
X-Gm-Message-State: AOJu0YwXf6dsMiI7NV3rBRWwt4yflt/RjHd0wdOtF4QT2CfZYiA6KXeu
	TAMPeVmUV3YcxgoOUdl+tLhgWMeULfhkkvM+/DVtUEpeia57
X-Google-Smtp-Source: AGHT+IEskTSe0nGIcOItqfJ6SepvxiQWh43wQkxn0KPGgUFpEKm7ALUXSUzjdhE2a+LQiKbpeQ6rkBIhe4NhubhRI6U=
X-Received: by 2002:a05:6871:4e97:b0:205:e3bd:6920 with SMTP id
 uk23-20020a0568714e9700b00205e3bd6920mr543948oab.95.1704941939966; Wed, 10
 Jan 2024 18:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109154547.1839886-1-jeffxu@chromium.org> <20240109154547.1839886-3-jeffxu@chromium.org>
 <ZZ2uXyPCE+l2Uccr@casper.infradead.org>
In-Reply-To: <ZZ2uXyPCE+l2Uccr@casper.infradead.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 10 Jan 2024 18:58:48 -0800
Message-ID: <CABi2SkVFVYWiYNCzsfFbkOW4kurysYp2X79prqoHFb488QKbYQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/4] mseal: add mseal syscall
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 12:36=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Jan 09, 2024 at 03:45:40PM +0000, jeffxu@chromium.org wrote:
> > +extern bool can_modify_mm(struct mm_struct *mm, unsigned long start,
> > +             unsigned long end);
> > +extern bool can_modify_mm_madv(struct mm_struct *mm, unsigned long sta=
rt,
> > +             unsigned long end, int behavior);
>
> unnecessary use of extern.
>
> > +static inline unsigned long get_mmap_seals(unsigned long prot,
> > +     unsigned long flags)
>
> needs more than one tab indent so it doesn't look like part of the body.
>
> > +{
> > +     unsigned long vm_seals;
> > +
> > +     if (prot & PROT_SEAL)
> > +             vm_seals =3D VM_SEALED | VM_SEALABLE;
> > +     else
> > +             vm_seals =3D (flags & MAP_SEALABLE) ? VM_SEALABLE:0;
>
> need spaces around the :
>
> > +++ b/include/uapi/asm-generic/mman-common.h
> > @@ -17,6 +17,11 @@
> >  #define PROT_GROWSDOWN       0x01000000      /* mprotect flag: extend =
change to start of growsdown vma */
> >  #define PROT_GROWSUP 0x02000000      /* mprotect flag: extend change t=
o end of growsup vma */
> >
> > +/*
> > + * The PROT_SEAL defines memory sealing in the prot argument of mmap()=
.
> > + */
> > +#define PROT_SEAL    _BITUL(26)      /* 0x04000000 */
>
> why not follow the existing style?
>
> > +static inline void set_vma_sealed(struct vm_area_struct *vma)
> > +{
> > +     vma->__vm_flags |=3D VM_SEALED;
> > +}
>
> uhh ... vm_flags_set() ?
>
Thanks. I agree with all the comments above and will update in the next ver=
sion.

-Jeff

