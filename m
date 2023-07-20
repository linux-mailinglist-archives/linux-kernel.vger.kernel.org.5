Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70E575ADB1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjGTMB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjGTMBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:01:25 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044AD10F5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:01:24 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-78654448524so28777139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689854483; x=1690459283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tPgRTBCM977gv6ppD9dyp6sm3R1el/53OCuH7O8kZs=;
        b=HCCWLsdMHVrRSRmcWQZ1gyQhIQ8PnZKEgxRhbxB4rzrssUNXiyiEHCiQTy9m2CaVUD
         UC7hMy9bDCXQitgt9kEW40HmaobypIsgcOh6dTaLhUsRdXEy0UgQhdarWl8nEjesiMqu
         wf94a8jLEFk04/WCVqYe6tapDFuSVjBgyS5OpZt/0oZOve7cYVpEGottkxqZGBzX47Ql
         w6+gDTrOSXAZ/BcABN30IDbdfi2r1U2qys6+Rp5M2yNZMw4/Xo3rJ1QslrUhF1tmwhFN
         NLdvGC4WoKZU1q2yrX1bWPUXS9Vfb3rlVxqYSlyxiDcpYPUfzkOQyZvICHSD0tGzVZbq
         /jOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689854483; x=1690459283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tPgRTBCM977gv6ppD9dyp6sm3R1el/53OCuH7O8kZs=;
        b=M3pkjmP+w8+FDOVji+jHE2OOrKQl48u56ehyAzKEVnsfE3m9/51QpHht4xmvcye7SA
         ox6HQJmQB4HdK37GsphkXKujY88LZo0NKoQxP6z8iFRCBF/jM42dDKgmoBdNZCvkvAlF
         I002whqepcvDic/TEmAPIRAJFuDs/4Foil1ecd732Ym4kSofYudxV81gS0P4ffHqi071
         vBUMuHQjd2e0bm/bGSbfvuX25TOrfKZhwA96CIIvGktSkAwOHn5NBdl96QYnv/inIHhl
         XnAAuwWdM/MIXA1JwVn4NN4bSj/hF9pAUW54pVvQio8F3tnRO2oxyGTTGEMkl8fTQshD
         FnNQ==
X-Gm-Message-State: ABy/qLbJD2Iv4nr8JPOFtrAslEzxpxZxunR6gjHV2T+YS+9myX0NvCxI
        tWfm0W07MTBIeZtZc4JibO1iVNTt5P/nNpBFQMiwDyWsHwueN8W6ODJSsQ==
X-Google-Smtp-Source: APBJJlGo7PEyRReYO9+p6LLeUUTPFw7HirHSo/Bn91FisLSigztupOls/qSdo1v5ldtaZUTFDzRtAyX9iK196mYflvs=
X-Received: by 2002:a5e:9403:0:b0:784:314f:8d68 with SMTP id
 q3-20020a5e9403000000b00784314f8d68mr8639142ioj.1.1689854483201; Thu, 20 Jul
 2023 05:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230717113709.328671-1-glider@google.com> <20230717113709.328671-4-glider@google.com>
 <ZLd+J3BkI3oK5vCw@yury-ThinkPad> <CAG_fn=USWBm=mdhgOz_df0veGQdioGOARqpZH5rAg3_fwhpbjA@mail.gmail.com>
 <ZLhQRyWSQax5/DCL@yury-ThinkPad>
In-Reply-To: <ZLhQRyWSQax5/DCL@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 20 Jul 2023 14:00:42 +0200
Message-ID: <CAG_fn=WPE9fS=iKiYZB0dwNpdbdDwQWz+3XTECN3r131Hm4sGQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
To:     Yury Norov <yury.norov@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 11:06=E2=80=AFPM Yury Norov <yury.norov@gmail.com> =
wrote:
>
> > Would it help if I add a comment explaining that iN is an N-bit
> > integer? Or do you prefer something like
> >
> >   r_sizes[0..4] : 5 x 7 bits
> >
> > ?
>
> Yes, that would help.
Ok.


> > >                      7 : Invalid handler
> >
> > No, 7 means "treat this handle as an out-of-line one". It is still
> > valid, but instead of tag data it contains a pointer.
>
> So, it's invalid combination for _inline_ handler, right?
Yes, that's right.

> Anyways, I'm
> waiting for an updated docs, so it will hopefully bring some light.
It's on the way.

> > > > +
> > > > +/* Transform tag ranges back into tags. */
> > > > +void ea0_ranges_to_tags(u8 *r_tags, short *r_sizes, int r_len, u8 =
*tags)
> > > > +{
> > > > +     int i, j, pos =3D 0;
> > > > +     u8 prev;
> > > > +
> > > > +     for (i =3D 0; i < r_len; i++) {
> > > > +             for (j =3D 0; j < r_sizes[i]; j++) {
> > > > +                     if (pos % 2)
> > > > +                             tags[pos / 2] =3D (prev << 4) | r_tag=
s[i];
> > > > +                     else
> > > > +                             prev =3D r_tags[i];
> > > > +                     pos++;
>
> This code flushes tags at every 2nd iteration. Is that true that
> there's always an even number of iterations, i.e. rsizes is always
> even, assuming r_len can be 1?
>
> If not, it's possible to loose a tag, consider rlen =3D=3D 1 and
> rsizes[0] =3D=3D 1.

By design, ea0_ranges_to_tags() only accepts ranges that sum up to 256
(as produced by ea0_tags_to_ranges())
We could add a check for that, but given that it is an internal
helper, a comment should suffice.

But r_sizes[i] does not have to be even (otherwise we could've used
this fact for a more efficient compression).
For example, if the array of tags is {0xab, 0x0, 0x0, 0x0...}, then
r_len =3D 3, r_sizes[] =3D {1, 1, 254}, r_tags =3D {0x0a, 0x0b, 0x0}.

>
> If yes, you can simplify:
>
>      for (i =3D 0; i < r_len; i++)
>              for (j =3D 0; j < r_sizes[i]; j++)
>                      tags[pos++] =3D (r_tags[i] << 4) | r_tags[i];
>
> Anyways, in the test can you run all possible combinations?

I will extract code from compress_range_helper() to generate different
numbers of ranges and test against those.


> > > > +/* Translate allocation size into maximum number of ranges that it=
 can hold. */
> > > > +static int ea0_size_to_ranges(int size)
> > > > +{
> > > > +     switch (size) {
> > > > +     case 8:
> > > > +             return 6;
> > > > +     case 16:
> > > > +             return 11;
> > > > +     case 32:
> > > > +             return 23;
> > > > +     case 64:
> > > > +             return 46;
> > > > +     default:
> > > > +             return 0;
> > > > +     }
> > > > +}
> > >
> > > I wonder if there's a math formula here? Can you explain where from
> > > those numbers come?
> >
> > I'll add a comment there.
> > Basically, for the inline case it is the biggest N such as 4 + 4*N +
> > 7*(N-1) <=3D 63
> >
> > (not 64, because Xarray steals one bit from us)
> >
> > For the out-of-line case it is the biggest N such as 6+4*N + 7*(N-1)
> > <=3D array size in bits (128, 256, or 512).
>
> So it's: N <=3D (BIT_CAPACITY + NUM4 - NUM7) / (TAGSZ + SZ)
>
> Doesn't look like a rocket science...

Note that the size of largest_idx is picked based on the largest N for
64-byte buffers.
And the size of r_sizes[] depends on the number of tags that fit into
128 bytes: if we throw away the largest range, each of the remaining
ones will fit into 7 bits.
But this will not be the case for e.g. 3-bit tags (we'll need 8-bit sizes t=
hen).

Changing mte_size_to_ranges() to "(size * 8 + MTE_BITS_PER_SIZE -
largest_bits) / (MTE_BITS_PER_TAG + MTE_BITS_PER_SIZE)" indeed looks
better than hardcoded numbers, but we should keep in mind that the
parameters depend on each other and cannot be easily changed.

>
> Why don't you code the formula instead of results? Are there any
> difficulties? Things may change. For example, in next spec they
> may bring 3- or 5-bit tags, and your compressor will crack loudly
> with hardcoded numbers.

The main reason for the compressor to crack loudly would be the
hardcoded assumption of the tags consisting of 4 bits.
I don't think it is practical to account on that number to change (and
e.g. use bitmap_read/bitmap_write to convert tags into ranges) - we'd
rather have a static assert for that.


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
