Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EA07E551C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344723AbjKHLWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344656AbjKHLVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:21:52 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159E01BF1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:21:50 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-66d1a05b816so46064796d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 03:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699442509; x=1700047309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WbK1qQZMhL0UyUEskip3O7w49fLhRM2vZKP3ZSvFYk=;
        b=H+LDNwoMcxULQSifPL1N9H+HbdxJKCnvtZ9KvOaHOuU4WMisVx0wWTiYuih//dVrI4
         KXHHgQ2KNlZv2eEdVkTeDEF3Ykdq+QJsz/Exnn9QNPL0yiwRKQftxxqYBgv8XDwUZl+l
         eXCIYbH9hNP31ayNOl08cPlusiDzgMLuX7NUVgI52IJ7O+bv8g3PpkFP4rpZll9PvBO3
         2pILoXmhu7DzX2WQOEiMZ+0yFhahFgDtNyRMbAWXltRM72m0oLuYVrzvSyHj5mWDJ4PR
         B6n7BFFCg1gE779lW9BGNztKZavSGn6vP4auZsQs10iJd54vlcxlTG5SjE1Qv4APwdmc
         OBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699442509; x=1700047309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WbK1qQZMhL0UyUEskip3O7w49fLhRM2vZKP3ZSvFYk=;
        b=JKzDNpbOwIc5HHA+QePyTMv4DucQv6ZsUnnpyp7nt7suR8LrilP75+khawksEBRtkE
         XELwDyWW8rcRcQ3zQwPy4K333hdLU5NH1BUq5G/YNB5jEaxLYvlxLKisAR3ZcFngvirW
         G0m/9emeS34OxKJFrO9/s8VsmZalGICaeiq3xYvHdwXty0K6qj6rl0DY/5iRQNHNs1xt
         b6gFBHRNqCCaVz1igTVyLPdyiIHWS/BFKpAt6NarH3wpYEQrqaiWG2vzM8g1ibNI4t4j
         XiEPJcjVaF7JdzK0sM9ejRoHkSY/O4LeUASLuP8aoctTPazfSRrGVLjDL6qdi9DiTmH6
         H4ow==
X-Gm-Message-State: AOJu0YxfcU8kH3foKVCp03HmShZrb6xST5VT+yxOgkmYwoMUW1vy+jVy
        2e//CRf4COyqysozMXugP0Ai+v1jy9W25LvM2fCDKg==
X-Google-Smtp-Source: AGHT+IHkM7Zz9YGVd5cg0w5zMDhUonnSmd8ty3Bmuen4IPcSzWl3Y7Bi/ii33xTS0GXdtkoqowbiW20l1cdep/WcKvs=
X-Received: by 2002:ad4:5967:0:b0:66d:949d:717e with SMTP id
 eq7-20020ad45967000000b0066d949d717emr1544322qvb.42.1699442509189; Wed, 08
 Nov 2023 03:21:49 -0800 (PST)
MIME-Version: 1.0
References: <20231103112237.1756288-1-anders.roxell@linaro.org> <CAEf4BzahAuskkD9YqxQpZDaUcu_jTuNAfbkkwP4dzJH=cTaVKA@mail.gmail.com>
In-Reply-To: <CAEf4BzahAuskkD9YqxQpZDaUcu_jTuNAfbkkwP4dzJH=cTaVKA@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 8 Nov 2023 12:21:38 +0100
Message-ID: <CADYN=9+koLV3eg85hVBkRtiAuygyngWxWChpnh=iUPVH4JeTjg@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: xskxceiver: ksft_print_msg: fix format
 type error
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2023 at 17:26, Andrii Nakryiko <andrii.nakryiko@gmail.com> wr=
ote:
>
> On Fri, Nov 3, 2023 at 4:23=E2=80=AFAM Anders Roxell <anders.roxell@linar=
o.org> wrote:
> >
> > Crossbuilding selftests/bpf for architecture arm64, format specifies
> > type error show up like.
> >
> > xskxceiver.c:912:34: error: format specifies type 'int' but the argumen=
t
> > has type '__u64' (aka 'unsigned long long') [-Werror,-Wformat]
> >  ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%d]\n",
> >                                                                 ~~
> >                                                                 %llu
> >                 __func__, pkt->pkt_nb, meta->count);
> >                                        ^~~~~~~~~~~
> > xskxceiver.c:929:55: error: format specifies type 'unsigned long long' =
but
> >  the argument has type 'u64' (aka 'unsigned long') [-Werror,-Wformat]
> >  ksft_print_msg("Frag invalid addr: %llx len: %u\n", addr, len);
> >                                     ~~~~             ^~~~
> >
>
> With u64s it might be %llx or %lx, depending on architecture, so best
> is to force cast to (long long) or (unsigned long long) and then use
> %llx.

Thank you Andrii,
v2 posted https://lore.kernel.org/bpf/20231108110048.1988128-1-anders.roxel=
l@linaro.org/T/#u

Cheers,
Anders

>
> > Fixing the issues by using the proposed format specifiers by the
> > compilor.
> >
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  tools/testing/selftests/bpf/xskxceiver.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/s=
elftests/bpf/xskxceiver.c
> > index 591ca9637b23..dc03692f34d8 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > @@ -908,7 +908,7 @@ static bool is_metadata_correct(struct pkt *pkt, vo=
id *buffer, u64 addr)
> >         struct xdp_info *meta =3D data - sizeof(struct xdp_info);
> >
> >         if (meta->count !=3D pkt->pkt_nb) {
> > -               ksft_print_msg("[%s] expected meta_count [%d], got meta=
_count [%d]\n",
> > +               ksft_print_msg("[%s] expected meta_count [%d], got meta=
_count [%llu]\n",
> >                                __func__, pkt->pkt_nb, meta->count);
> >                 return false;
> >         }
> > @@ -926,11 +926,11 @@ static bool is_frag_valid(struct xsk_umem_info *u=
mem, u64 addr, u32 len, u32 exp
> >
> >         if (addr >=3D umem->num_frames * umem->frame_size ||
> >             addr + len > umem->num_frames * umem->frame_size) {
> > -               ksft_print_msg("Frag invalid addr: %llx len: %u\n", add=
r, len);
> > +               ksft_print_msg("Frag invalid addr: %lx len: %u\n", addr=
, len);
> >                 return false;
> >         }
> >         if (!umem->unaligned_mode && addr % umem->frame_size + len > um=
em->frame_size) {
> > -               ksft_print_msg("Frag crosses frame boundary addr: %llx =
len: %u\n", addr, len);
> > +               ksft_print_msg("Frag crosses frame boundary addr: %lx l=
en: %u\n", addr, len);
> >                 return false;
> >         }
> >
> > @@ -1029,7 +1029,7 @@ static int complete_pkts(struct xsk_socket_info *=
xsk, int batch_size)
> >                         u64 addr =3D *xsk_ring_cons__comp_addr(&xsk->um=
em->cq, idx + rcvd - 1);
> >
> >                         ksft_print_msg("[%s] Too many packets completed=
\n", __func__);
> > -                       ksft_print_msg("Last completion address: %llx\n=
", addr);
> > +                       ksft_print_msg("Last completion address: %lx\n"=
, addr);
> >                         return TEST_FAILURE;
> >                 }
> >
> > @@ -1513,7 +1513,7 @@ static int validate_tx_invalid_descs(struct ifobj=
ect *ifobject)
> >         }
> >
> >         if (stats.tx_invalid_descs !=3D ifobject->xsk->pkt_stream->nb_p=
kts / 2) {
> > -               ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%=
u] expected [%u]\n",
> > +               ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%=
llu] expected [%u]\n",
> >                                __func__, stats.tx_invalid_descs,
> >                                ifobject->xsk->pkt_stream->nb_pkts);
> >                 return TEST_FAILURE;
> > --
> > 2.42.0
> >
> >
