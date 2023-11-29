Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76E07FCD23
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376868AbjK2DBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjK2DBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:01:53 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870FA1AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:01:59 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5c21e185df5so4491464a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701226919; x=1701831719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmmZdnMG5cx1ucOkJTYJz9C0ueulBI91QAmZKkzSQnk=;
        b=A0R2EeRJnUaK5k770z1FbAKoxgXbgN5Eg3LIiRz4iI3cBOAZWiGRcCcl73fhsVdOYC
         l/vda9BrrWFzXRQx1m2RxYeQ0z9zs/k6+riuYwP7dnqklJoLsOjJ6zQ+8nzjiDK7/Pl0
         TSXuChgqvxJrq8cDCu/x1a25IU8rOgUrO5dLCT5kUZa58FRggfSwikEBRzW49Bm59dMw
         zCQxe0mQ+o5qpHXLdV+1r+8PiTJYHbgqCBm+dJMysJc4KKheukOVF+2lXGbioVzJINfi
         55+4W55jTVvIvJcSMSkaEszbuMv7nfSYYjmRYLAjB7EPzkylSffRLaXaV/1IbPKTC7Nc
         VhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701226919; x=1701831719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmmZdnMG5cx1ucOkJTYJz9C0ueulBI91QAmZKkzSQnk=;
        b=XgdoCP/nVmtmpwB16zkMewIPVKI7qu8K76LY/VFG7ZZvFnB4cQ2NCSscG/d5Lk40bD
         ZK5bWl2lGdIiLmZYM0z/1LCSBLTMYFFJwqFSSqrcI4fXJTp8GqvOd5q7+xRbv+yaspV5
         /Vi+kcJ9u5F9JT/ggrg8Gu9sLX/KZ1OgdDQaF5wm+qVBsod/YzBvFRz3n+SMtuCgna+E
         aREv2+zbG62YpB2ZMfMN9QCv8OF2Qfsry6otFd9ppWI5LvyIUiCQHI72iBjTXpGlC8k9
         ZJTBRiS7gHlef2IpU3yeCkhy+27L5WI6pyyPpOX2sE0mogMM07YLNpDyDWcGX+btYOzM
         d/ow==
X-Gm-Message-State: AOJu0YxvZV+GRXnEAUs0v/nTSRL8/0mCLjap+FIIRweFBys+0ibTZyU0
        hB3aV4/823R7LuRHNOdJ1DbPfQ9zgLWqnTL5uQs=
X-Google-Smtp-Source: AGHT+IGnzMPnHxO60vC1ojrSQZx1ZUStF+SQpvY4lfHFS3JYWC+jAHzm4FZ5/2GQ51SFSCY35ZknJWpTMhCgJeAVM+k=
X-Received: by 2002:a17:90b:4c02:b0:285:dbbe:1178 with SMTP id
 na2-20020a17090b4c0200b00285dbbe1178mr7726571pjb.39.1701226918871; Tue, 28
 Nov 2023 19:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20231128075532.110251-1-haibo.li@mediatek.com> <20231128172238.f80ed8dd74ab2a13eba33091@linux-foundation.org>
In-Reply-To: <20231128172238.f80ed8dd74ab2a13eba33091@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 29 Nov 2023 04:01:47 +0100
Message-ID: <CA+fCnZcLwXn6crGF1E1cY3TknMaUN=H8-_hp0-cC+s8-wj95PQ@mail.gmail.com>
Subject: Re: [PATCH] fix comparison of unsigned expression < 0
To:     Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Haibo Li <haibo.li@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, xiaoming.yu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 2:22=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 28 Nov 2023 15:55:32 +0800 Haibo Li <haibo.li@mediatek.com> wrote=
:
>
> > Kernel test robot reported:
> >
> > '''
> > mm/kasan/report.c:637 kasan_non_canonical_hook() warn:
> > unsigned 'addr' is never less than zero.
> > '''
> > The KASAN_SHADOW_OFFSET is 0 on loongarch64.
> >
> > To fix it,check the KASAN_SHADOW_OFFSET before do comparison.
> >
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -634,10 +634,10 @@ void kasan_non_canonical_hook(unsigned long addr)
> >  {
> >       unsigned long orig_addr;
> >       const char *bug_type;
> > -
> > +#if KASAN_SHADOW_OFFSET > 0
> >       if (addr < KASAN_SHADOW_OFFSET)
> >               return;
> > -
> > +#endif
>
> We'd rather not add ugly ifdefs for a simple test like this.  If we
> replace "<" with "<=3D", does it fix?  I suspect that's wrong.

Changing the comparison into "<=3D" would be wrong.

But I actually don't think we need to fix anything here.

This issue looks quite close to a similar comparison with 0 issue
Linus shared his opinion on here:

https://lore.kernel.org/all/Pine.LNX.4.58.0411230958260.20993@ppc970.osdl.o=
rg/

I don't know if the common consensus with the regard to issues like
that changed since then. But if not, perhaps we can treat this kernel
test robot report as a false positive.

Thanks!
