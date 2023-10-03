Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11BA7B6BB3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbjJCOeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbjJCOeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:34:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED5CAB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:34:15 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-278eaffd81dso715122a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696343655; x=1696948455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrQlyNTcBpU1f1rZ80Y8vZ/aGweIhaB8Z84P7zZh5GA=;
        b=XFrGzurnB7Mbz00SnVItTA6ll/V49d0/FX8r/cBCsq0ba2+97YboGotBy4I0WRpLnu
         T0A7HLgCEf6QEB0jXt9BIFOkyhdfK2qTqp1w1lCeqK8Ar+5Awz/0pvoB9K/jXVjeNCPm
         t7UDgoFfi6kKpDx+3Ty6/8iaHm407bPrdupMWdDklztffMl0uIYeTT2CeMECtm5fdZax
         o2Q1SjR+UXkrZWja1jwnRupXQ9NCL+AnW1uyx07+rvD1ul0vqZkMc8k4SFxBr3s9DbZ2
         kpEEnV+m4dk0hR+puQpcDnVB8YmhXihPi2WvokQpYMFStpXhzHg38p9uKzh5EukQKJJx
         JXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696343655; x=1696948455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrQlyNTcBpU1f1rZ80Y8vZ/aGweIhaB8Z84P7zZh5GA=;
        b=tQTMEto7g2dwMMNpu8CB6/S8uR0viUqDcoi6kA4dJjyPu7GHy3xGnx2icR+EUk5+g+
         DFWPcx9lKL92LhPyZ9Tcln4l0jyl6TAre3xRRMqItRDtI8Z32CYEJh2FPZSchVkAX56K
         MJ5jWI42cYCI62EoLdRuW2Qj7soweenrcvidJCa8OozxK1DvZemxB5VxX01NUtMyTxK0
         rbXAQq4vwzphXlKXp0rjWEVwI/krVmQ4h3WXKO0OVrgk2RBMR+Rnmi0/jwcL74BL8Uk+
         ApxAxI+eDYJTyk7CehPa1ak7armXAoRtLkgzlrhJ+vfgZMZPSGzrIIMw9Ru8v8dbVDM9
         wMkw==
X-Gm-Message-State: AOJu0YwA53aE9WiTWPGYK+V7rVVGWOzlokgfhV8GEpqoKTCTlNhpGBg/
        jCdQ02Q1RD2kszimGaLsGVFSgsf8MsCrYEav939qWg==
X-Google-Smtp-Source: AGHT+IFIiYZLHH48AhfdT6YjFlv0v4C9r4DWhzUUTISfCnF9IZXkjlGQyV8klqJTMp0sA9qYSM1Oa1m5drFm2TGL/9A=
X-Received: by 2002:a17:90a:ab84:b0:274:abbc:4ef2 with SMTP id
 n4-20020a17090aab8400b00274abbc4ef2mr11604020pjq.30.1696343655060; Tue, 03
 Oct 2023 07:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-hib_zero_bitmap_fix-v1-1-6cfdcb785250@quicinc.com>
 <CADyq12wRVJURCuB0ZjL878J-U9kCxNE0pSoihRWBP8OJWk1M1A@mail.gmail.com> <990198cf-59bb-484d-9383-dd7d133c8105@quicinc.com>
In-Reply-To: <990198cf-59bb-484d-9383-dd7d133c8105@quicinc.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 3 Oct 2023 10:33:38 -0400
Message-ID: <CADyq12y9r373gH3Zsnov8TtFFryG6cLbe1S5N-kPdvzjCjxfuQ@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Fix a bug in copying the zero bitmap to
 safe pages
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        kernel@quicinc.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 11:08=E2=80=AFPM Pavan Kondeti <quic_pkondeti@quicin=
c.com> wrote:
>
> On Sat, Sep 30, 2023 at 07:37:13AM -0400, Brian Geffon wrote:
> > On Fri, Sep 29, 2023 at 1:31=E2=80=AFPM Pavankumar Kondeti
> > <quic_pkondeti@quicinc.com> wrote:
> > >
> > Hi Pavankumar,
> >
> > > The following crash is observed 100% of the time during resume from
> > > the hibernation on a x86 QEMU system.
> > >
> > > [   12.931887]  ? __die_body+0x1a/0x60
> > > [   12.932324]  ? page_fault_oops+0x156/0x420
> > > [   12.932824]  ? search_exception_tables+0x37/0x50
> > > [   12.933389]  ? fixup_exception+0x21/0x300
> > > [   12.933889]  ? exc_page_fault+0x69/0x150
> > > [   12.934371]  ? asm_exc_page_fault+0x26/0x30
> > > [   12.934869]  ? get_buffer.constprop.0+0xac/0x100
> > > [   12.935428]  snapshot_write_next+0x7c/0x9f0
> > > [   12.935929]  ? submit_bio_noacct_nocheck+0x2c2/0x370
> > > [   12.936530]  ? submit_bio_noacct+0x44/0x2c0
> > > [   12.937035]  ? hib_submit_io+0xa5/0x110
> > > [   12.937501]  load_image+0x83/0x1a0
> > > [   12.937919]  swsusp_read+0x17f/0x1d0
> > > [   12.938355]  ? create_basic_memory_bitmaps+0x1b7/0x240
> > > [   12.938967]  load_image_and_restore+0x45/0xc0
> > > [   12.939494]  software_resume+0x13c/0x180
> > > [   12.939994]  resume_store+0xa3/0x1d0
> > >
> > > The commit being fixed introduced a bug in copying the zero bitmap
> > > to safe pages. A temporary bitmap is allocated in prepare_image()
> > > to make a copy of zero bitmap after the unsafe pages are marked.
> > > Freeing this temporary bitmap later results in an inconsistent state
> > > of unsafe pages. Since free bit is left as is for this temporary bitm=
ap
> > > after free, these pages are treated as unsafe pages when they are
> > > allocated again. This results in incorrect calculation of the number
> > > of pages pre-allocated for the image.
> > >
> > > nr_pages =3D (nr_zero_pages + nr_copy_pages) - nr_highmem - allocated=
_unsafe_pages;
> > >
> > > The allocate_unsafe_pages is estimated to be higher than the actual
> > > which results in running short of pages in safe_pages_list. Hence the
> > > crash is observed in get_buffer() due to NULL pointer access of
> > > safe_pages_list.
> >
> > Rafael pulled https://git.kernel.org/pub/scm/linux/kernel/git/rafael/li=
nux-pm.git/commit/?h=3Dlinux-next&id=3Df0c7183008b41e92fa676406d87f18773724=
b48b
> > which addresses the null pointer dereference which regardless
> > shouldn't be touching the list directly and should be using
> > __get_safe_page().
>
> Thanks for pointing me to this. I have verified hibernation by pulling th=
is
> commit to v6.6-rc3 and it works as expected.
>
> This commit is currently queued for v6.7, can it be included in next -rc =
or
> we have to apply the patch I have sent to make sure that hibernation work=
s on
> v6.6 when it gets released.

It was CCed to stable, so it will be included in stable kernels.

>
> >
> > >
> > > Fixes: 005e8dddd497 ("PM: hibernate: don't store zero pages in the im=
age file")
> > > Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
>
> Thanks,
> Pavan
