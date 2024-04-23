Return-Path: <linux-kernel+bounces-154858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FC28AE211
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB1A2830FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B7767A0D;
	Tue, 23 Apr 2024 10:25:12 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6486565BBB;
	Tue, 23 Apr 2024 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867912; cv=none; b=IgSXNN8yBiITZLlysBFRf5asZ06RCDsN4e5gbIBEiJfO6DZRsWI7eaibt7u7eI+zSmpxf/BIA2RVXmLUnV3ZrPD+MWo3loFdT8ry33m2oA5NOIt1bhUlCHobvWtVO2g+G4Q6V/ZLdznwXGfRrKKFe7HCcBRprZcVxyY44doTj3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867912; c=relaxed/simple;
	bh=8AXi8OUpScL7BVYVhgt2tU7sCAHNA/RzYAox3j3pXu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SeibJOTwO2Xppom1HMBfIXkkbIuLQIoO4HG/eawwmBn8cZPT55us46mnCCbZkfzSCTmVuoudPzqBDGdctDpgnizE9rJbUBdd3TI93f/V2OFRN/Ef5m6JXCB12F3rKcIW30+RMoGtFLM4ihsERKUkL/AeqcUTUCEdNh7g8zRUSso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-617d25b2bc4so56800877b3.2;
        Tue, 23 Apr 2024 03:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713867909; x=1714472709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPPWzjJiCdBwxq/+2FF0OgIBij0pVVSa6URME/LnKcc=;
        b=eoZpKXHvPe/un6CF8hC3oiCiXa2O+xYE8l/K8sj2sOXgBrLu8KBObQDaGcl2O0mzTv
         mUINzGFOs6uWZwTNkPkD2U6xFHYS7tMwCEr1aYiu7BU517/Fh3W7GV9gE1B0L6mvOgLv
         rsW+xaRS8/ky5pg0SpYfEm6HDKtOs/w8EPFRXjbzkEV1kyjogjwTndm/mO7FnHMv8meG
         WhGoYvCucxtJ7OWSs1fVN6sJDUjJ63pVEcaF1D1CZWVSpcxmetUVOJRHD8NkqwNOrZf5
         Ioa3KJWntTDtMXx9XVmlOns+cjUWSvtvFABLd9BxgxH/toqPEF6ln+EAhiYMaD/r5IPx
         76IA==
X-Forwarded-Encrypted: i=1; AJvYcCUYPcZDphEgRF3m53u6fO6ud4qKVkRn5lWOeOeVFEIH2G2W9S0c3rICwlc72cAM4bpg69uxvIYQrPGsvqRTvxbqcp8rVcXp21/XX0eOdrZclJaQk756WW8tCthIaicdYq/ILoj8MDwFlSvTClg=
X-Gm-Message-State: AOJu0YwQmTm/NbdCMtbCKfvDIcnoHH7nGD3qCNXc5lzWf91bERNwjAG9
	317j42CY23u6iFqkZi+Pe2mefOhUvK6nprq7/kb35qfsFtBIaPRhn5gmJSlv
X-Google-Smtp-Source: AGHT+IEUZftydvP8Z1Jm/EKEuVWyOQ5OB++3D1QfaVmxv/4JqLTF9fT4HjnCoaUeL5/vB+UQIjPlCQ==
X-Received: by 2002:a05:690c:6485:b0:61a:ccb0:7cdd with SMTP id hs5-20020a05690c648500b0061accb07cddmr11944978ywb.46.1713867908675;
        Tue, 23 Apr 2024 03:25:08 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id c10-20020a81e54a000000b0061447e2be82sm1991167ywm.51.2024.04.23.03.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 03:25:08 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61804067da0so54214447b3.0;
        Tue, 23 Apr 2024 03:25:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBlxphphCHOWktpkbGimxtrp0Ll0L+oLMUSaFCAuZzi8+88xX8VKKOlfJgh1RnEPoqHddLlk1GFxMwQmxf9bWQfTDb8iu462oM3vXQL1swSE5imKCPfn4lc8ZY0gNv5mhEZ9kRJg7LAYmS2/Y=
X-Received: by 2002:a25:8185:0:b0:dd0:972b:d218 with SMTP id
 p5-20020a258185000000b00dd0972bd218mr12175796ybk.41.1713867908226; Tue, 23
 Apr 2024 03:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416-bcachefs-fix-format-specifier-validate_bset_keys-v1-1-3ea2cdf28b12@kernel.org>
 <xznpzlnjcf3goexunm6azwercgwz7ikgum3i4gpdyxwykb4e4l@ascd3uztphq3>
 <CAMuHMdV9wMO2E=xNezs5FiDK_F3XKaVPaFbhh9+7djd26KkgMA@mail.gmail.com> <omczcaeo74gwmsnysol6m7wwrh4rcdonmcn3fwp64pkavczqcp@enobbzrlpymb>
In-Reply-To: <omczcaeo74gwmsnysol6m7wwrh4rcdonmcn3fwp64pkavczqcp@enobbzrlpymb>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Apr 2024 12:24:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX04q-af8BVWqGgeG5gkZrrDJWsnrJh5j=XG97vrdTQrg@mail.gmail.com>
Message-ID: <CAMuHMdX04q-af8BVWqGgeG5gkZrrDJWsnrJh5j=XG97vrdTQrg@mail.gmail.com>
Subject: bcachefs broken in next (was: Re: [PATCH] bcachefs: Fix format
 specifier in validate_bset_keys())
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Nathan Chancellor <nathan@kernel.org>, bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kent,

On Mon, Apr 22, 2024 at 9:32=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Mon, Apr 22, 2024 at 02:47:32PM +0200, Geert Uytterhoeven wrote:
> > On Wed, Apr 17, 2024 at 12:09=E2=80=AFAM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > > On Tue, Apr 16, 2024 at 08:16:02AM -0700, Nathan Chancellor wrote:
> > > > When building for 32-bit platforms, for which size_t is 'unsigned i=
nt',
> > > > there is a warning from a format string in validate_bset_keys():
> > > >
> > > >   fs/bcachefs/btree_io.c: In function 'validate_bset_keys':
> > > >   fs/bcachefs/btree_io.c:891:34: error: format '%lu' expects argume=
nt of type 'long unsigned int', but argument 12 has type 'unsigned int' [-W=
error=3Dformat=3D]
> > > >     891 |                                  "bad k->u64s %u (min %u =
max %lu)", k->u64s,
> > > >         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
> > > >   fs/bcachefs/btree_io.c:603:32: note: in definition of macro 'btre=
e_err'
> > > >     603 |                                msg, ##__VA_ARGS__);      =
               \
> > > >         |                                ^~~
> > > >   fs/bcachefs/btree_io.c:887:21: note: in expansion of macro 'btree=
_err_on'
> > > >     887 |                 if (btree_err_on(!bkeyp_u64s_valid(&b->fo=
rmat, k),
> > > >         |                     ^~~~~~~~~~~~
> > > >   fs/bcachefs/btree_io.c:891:64: note: format string is defined her=
e
> > > >     891 |                                  "bad k->u64s %u (min %u =
max %lu)", k->u64s,
> > > >         |                                                          =
    ~~^
> > > >         |                                                          =
      |
> > > >         |                                                          =
      long unsigned int
> > > >         |                                                          =
    %u
> > > >   cc1: all warnings being treated as errors
> > > >
> > > > BKEY_U64s is size_t so the entire expression is promoted to size_t.=
 Use
> > > > the '%zu' specifier so that there is no warning regardless of the w=
idth
> > > > of size_t.
> > > >
> > > > Fixes: 031ad9e7dbd1 ("bcachefs: Check for packed bkeys that are too=
 big")
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202404130747.wH6Dd23p=
-lkp@intel.com/
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202404131536.HdAMBOVc=
-lkp@intel.com/
> > > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > >
> > > Thanks, applied
> >
> > This is still not fixed in today's linux-next, while the issue is now
> > causing breakage on several 32-bit defconfs in v6.9-rc5.
>
> Apologies, I just neglected to update my for-next branch, it's in now.

Thank you, I can confirm it is there.

However, linux-next is broken again on lots of configs
http://kisskb.ellerman.id.au/kisskb/head/a59668a9397e7245b26e9be85d23f242ff=
757ae8/

fs/bcachefs/btree_key_cache.c:1057:64: error: 'struct srcu_struct' has
no member named 'srcu_sup'; did you mean 'srcu_idx'?

I have bisected this to commit f2d47ec26af5b235 ("bcachefs: Btree key
cache instrumentation"), but I cannot find that patch on any mailing list
archived on lore.

Please do not include untested and/or unreviewed patches in any branches
included in linux-next.

Thank you!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

