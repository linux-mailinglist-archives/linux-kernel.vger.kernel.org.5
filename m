Return-Path: <linux-kernel+bounces-137357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 383CE89E11A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78DA3B2AB06
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E4A15665B;
	Tue,  9 Apr 2024 17:02:17 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ACE156244;
	Tue,  9 Apr 2024 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682137; cv=none; b=Y/K5EMpOctEE1Co/Pez5v8kLdOFRnsCO5JHcrmLYJlV04TKIVPgliOuEZ9SBM+jN07OnkXPN7LZUUwxrMjIDD5aTZSq9wwdjkHbZ495tM5xP0xPa0nwkKtsNJo+SbE7/RS/GGcK0vriXokZ77pdS9O7CoQcmnh4hRophUES/Hqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682137; c=relaxed/simple;
	bh=Ld1GNPh7eliglJwz4JBGCOxXq7qQT41qVZlmJL8DJ24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W61KxIYvN21Hi4Flg2vqdvYEvlMB0JS1LvomCHbYY4Y4GMbEcRGadq8vcxlCeCNMpT6f6rrjJmW+Tzqg+Hd/BNq4HECzHxAK9qj2ScNX2hDT9OLjBIQK57JyjNmlW77mIwn3n0zp2+kP/1zwbXx1kCigA298wXq/r2UBVq5rm2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e3c7549078so25623965ad.0;
        Tue, 09 Apr 2024 10:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712682135; x=1713286935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NU+IDV5MPL7YcPa1Of4+Gylt4ybk+lO5OFWOj3lGe3I=;
        b=hOE1bzQ2VZQ9f1nstzmBkuhgq+9PCpRoY+D3G6/51B9AE+rvoTxGU1PoJUNyLJvPGi
         kSmOgtSxPqJaE9rN6Eq1f1F2U/ateC7pSc13H2JRDpNkzu4dpFHyRF9DPbiKVEcQz5K/
         tBexZrHT7CrG39pPH944VEDRhFysVvLzb1mivBKIsOKyCCzPKFhM5TrRWvDwhSV9R3cn
         YwRgM+2Tvu3nxEbD0m9U0keqgWMN1o4KTgweX+KpK/yfFfQdmdIOOIKwVr+jlfVi6X8y
         +Tj41BnIePcqwKinOoPAYBJDLXnVqQBExIuFxNCwl4/5WzlSrJppQaLEZB23LbdUrFQB
         AgYA==
X-Forwarded-Encrypted: i=1; AJvYcCV0xs0nIZAiAWoBz8MVpTjuAtJAWTUOAU6kKQXvvycrQSADzPRWe4LfoP0nIlUs+G/a6TADQhHkbhNjPHOXxwo+q4nl2cKv+HsESDzQNcm2VGhYfmf3u0+i32/RdnnhPOv4cg6l1gGuZVquOm3wOw==
X-Gm-Message-State: AOJu0YysDRYesbEal26z/qjMBpp5YxIwo7767blWHc6/moPZeSRhD3k4
	6DiCMHgPsrLfooz//ijF4B9s1EYS/tmeL2j9UgFPgXGfD2ZpRiSBcg+/G/gHA08Y2Xz9UsTHyCI
	isE0xiUZ49P8m0OmMA1LurM5zVn8=
X-Google-Smtp-Source: AGHT+IEpJNTORpTm1ddk7PF/G0t6Ihuam5TpPLhreBZHNaS0kqHtFWmIzr2KECl8i2g5CiMZixMScHe0Kk2GD+Fw5Sk=
X-Received: by 2002:a17:902:a3c5:b0:1e4:39e0:660c with SMTP id
 q5-20020a170902a3c500b001e439e0660cmr4030195plb.23.1712682135001; Tue, 09 Apr
 2024 10:02:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401160805.51277-1-yakoyoku@gmail.com> <CAP-5=fXu4uM=cU8Q=1JP19sELfarNE9BtBmbFW0Uyq2e_HJ6QA@mail.gmail.com>
 <CAM9d7cjgfQpo6dgV4f5Wm4shVpknzP4_m36AkTwaUaF4jLrV1w@mail.gmail.com> <3485d1b1-7824-4e62-82b4-ed52360122dd@gmail.com>
In-Reply-To: <3485d1b1-7824-4e62-82b4-ed52360122dd@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 9 Apr 2024 10:02:03 -0700
Message-ID: <CAM9d7chCGcPQrHbpX0aDWy127a=RG5uFRpVBQ4Lc+jYgRy5uLQ@mail.gmail.com>
Subject: Re: [PATCH] perf srcline: Implement addr2line using libdw
To: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Apr 4, 2024 at 5:10=E2=80=AFPM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> On 4/1/24 8:31 PM, Namhyung Kim wrote:
> > [...]
> >
> > Thanks for doing this!  Yep, we could unset the env temporarily.
> >
> > As a general comment, perf has some helper functions for libdw
> > in util/dwarf-aux.[ch].  Please take a look and use/update them.
>
> Whoops! I haven't seen that file, thanks for mentioning it.
>
> > [...]
> >
> > Probably we can use cu_find_lineinfo().
>
> I could use that, I'll see.
>
> > [...]
> >
> >>> +static struct a2l_data *addr2line_init(const char *path)
> >
> > debuginfo__new()?
>
> `libdw_a2l_new` can be another option too.
>
> > [...]
> >
> >>> +static int get_inline_function(struct dso *dso, struct inline_node *=
node,
> >>> +                              struct symbol *sym)
> >>> +{
> >>> +       struct a2l_data *a2l =3D dso->a2l;
> >>> +       Dwarf_Addr addr =3D a2l->addr + a2l->bias;
> >>> +       Dwarf_Addr bias =3D 0;
> >>> +       Dwarf_Die *cudie =3D dwfl_module_addrdie(a2l->mod, addr, &bia=
s);
> >>> +
> >>> +       Dwarf_Die *scopes =3D NULL;
> >>> +       int nscopes =3D dwarf_getscopes(cudie, addr - bias, &scopes);
> >
> > It's not clear to me how this dwarf_getscopes() and later
> > dwarf_getscopes_die() work together.  Can you please add some
> > comment?  Also we have die_get_scopes() and I think it's simpler.
>
> I think the first is to get the scopes at an address and the second is
> for the scopes with the addr offset at that DIE. Off the top of my head.
>
> > [...]
> >
> > Why not get the function name from the abstract origin?
>
> I'm not getting it, where's that abstract origin?

IIUC DW_TAG_inlined_subroutine has DW_AT_abstract_origin
to point to the original definition of the function.  It should have
the name of the function.

 <2><5ca8>: Abbrev Number: 40 (DW_TAG_inlined_subroutine)
    <5ca9>   DW_AT_abstract_origin: <0x5eeb>
    <5cad>   DW_AT_low_pc      : 0x24efc6
    <5cb5>   DW_AT_high_pc     : 0x2d
    <5cbd>   DW_AT_call_file   : 3
    <5cbe>   DW_AT_call_line   : 135
    <5cbf>   DW_AT_call_column : 9

Thanks,
Namhyung

