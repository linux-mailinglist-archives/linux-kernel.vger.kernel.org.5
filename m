Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D947815AB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 01:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242180AbjHRXLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 19:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242168AbjHRXKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 19:10:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1280128
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 16:10:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so1861a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 16:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692400251; x=1693005051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdyYAb+5jM+9F39CDpe94bQcIc8bF9RgX/mGXcLPW0A=;
        b=aNzK9siZ34VI3YJ8tPguNg4ypmVD9LAqYTRM0RdmWuCBgfVFZTgLQwFLBD0BQsv17Y
         EWjkY7mm/V6mkD2HVKOBUE6uxoWerjpo6f1lfiQljQFYNk81G1bZvxtW6wFvLmCPifL/
         cPSMlXmX1f728TCsILO6OdVUUEvwlHtFVa46hAUUnsjuTcDg9jELT9M/bItSbyFiJQ5y
         w2rGYRkCfIQRClpyTPnA2gdYMbyrro2EYZkiOo5ZPgU4lJJ/NmtJ1QavFYKxMg31EqD8
         9gcwSUHURJIrMPYsllhEheoNZocGzlbjqFVy0ZmPYQ0sZxBmeW7Gb7T0kn6jDgJFIZ5y
         4QKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692400251; x=1693005051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdyYAb+5jM+9F39CDpe94bQcIc8bF9RgX/mGXcLPW0A=;
        b=Y3xCvw0VFKuZMoaBCPNo3VB8hKDzNXbmvJj++9SEPBSs7ayl/wg4tEF+Vwsquh0Vop
         aS1valYVbdJp3iIJsGCCZ4cZJ/zuWideJsnleqqtY11dbH5YF4v/jvXUlC1lFaU3Cmb1
         DoxZX5zFv1PAWY8uD/RFDzmq9B9OtWhGOjcnwVqN1duThbgkqah/bP1NLbk3o+aNzzk2
         XAqYtQsCrWqySYkYrhrp/8yu0TsCMJ65YpfUY68OEJQFUfkx0u1fapkto1A02JqcblbD
         JLKHO8r7mhvk5+ciwkfjIEDimXs0nHQRxW/V1HAcu1m0P71XP4Hh3EJfsm307dKEz8GU
         pVuA==
X-Gm-Message-State: AOJu0YycRThPqlU6uisCWDccsOWpHWcdol1rzjSwLDrVU/GgWoBV+gNN
        iUFqvs998kfokGj1+ANT7ZOGgEko7tCDshD8hdDeRA==
X-Google-Smtp-Source: AGHT+IGDCuh8jkeMdAC5UaVks350E9zgqCFxyseaLK7vZ9WtXLAThFnSYRZUZlWV3Y40WVIt7FRvxDyAwBy4uYHECjg=
X-Received: by 2002:a50:874f:0:b0:523:bdc9:48a9 with SMTP id
 15-20020a50874f000000b00523bdc948a9mr176000edv.0.1692400251094; Fri, 18 Aug
 2023 16:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230818211533.2523697-1-zokeefe@google.com> <20230818211533.2523697-2-zokeefe@google.com>
 <CAAa6QmSN+7zWTMhYY9rEBf8U5xZ3kwfZXUuvT=ZGmEXLpNm0Kg@mail.gmail.com> <ZN/t4sgCe5lsFUpR@casper.infradead.org>
In-Reply-To: <ZN/t4sgCe5lsFUpR@casper.infradead.org>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Fri, 18 Aug 2023 16:10:14 -0700
Message-ID: <CAAa6QmTDQ13rWDRVqJgTYhutVyo+eczXtq4kd-TarS=wMhqpAw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] smaps: set THPeligible if file mapping supports
 large folios
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Yang Shi <shy828301@gmail.com>,
        linux-kernel@vger.kernel.org
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

On Fri, Aug 18, 2023 at 3:17=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Aug 18, 2023 at 03:14:02PM -0700, Zach O'Keefe wrote:
> > Sorry -- noticed only too late that there are still many
> > false-negatives for THPeligible, since by this point in the function
> > we've already applied sysfs and prctl restrictions, which file-fault
> > ignores. VM_HUGEPAGE also needs to be checked for the file-fault case.
>
> I'm not entirely convinced that unifying all of these things leads
> to code that's simpler to understand.
>

I'm trying my hand at rearranging this particular function to make it
simpler -- but thought the refactor better left for a follow-up patch.

This patch was just about surfacing the possibility of getting THPs
through file fault to the user. Maybe the inverse is more frustrating
(claiming THPs are eligible, but then never getting them), but given
we expose the field, I feel like we might as well try to make it
accurate. The actual complexity is just a reflection of the the
different eligibility requirements chosen for each of
(anon, shmem, file) x (fault, khugepaged, MADV_COLLAPSE).



> > On Fri, Aug 18, 2023 at 2:15=E2=80=AFPM Zach O'Keefe <zokeefe@google.co=
m> wrote:
> > >
> > > File-backed memory can be backed by THPs either through collapse, whe=
n
> > > CONFIG_READ_ONLY_THP_FOR_FS is enabled, or through fault, when the
> > > filesystem supports large folio mappings.
> > >
> > > Currently, smaps only knows about the former, so teach it about the
> > > latter.
> > >
> > > Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > ---
> > >  mm/huge_memory.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index cd379b2c077b..d8d6e83820f3 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -136,7 +136,16 @@ bool hugepage_vma_check(struct vm_area_struct *v=
ma, unsigned long vm_flags,
> > >                          */
> > >                         !!vma->vm_ops->huge_fault :
> > >                         /* Only regular file is valid in collapse pat=
h */
> > > -                       file_thp_enabled(vma);
> > > +                       file_thp_enabled(vma) ||
> > > +                        /*
> > > +                         * THPeligible bit of smaps should surface t=
he
> > > +                         * possibility of THP through fault if the f=
ilesystem
> > > +                         * supports it.  We don't check this in faul=
t path,
> > > +                         * because we want to fallback to the actual=
 ->fault()
> > > +                         * handler to make the decision.
> > > +                         */
> > > +                        (smaps && vma->vm_file &&
> > > +                        mapping_large_folio_support(vma->vm_file->f_=
mapping));
> > >
> > >         if (vma_is_temporary_stack(vma))
> > >                 return false;
> > > --
> > > 2.42.0.rc1.204.g551eb34607-goog
> > >
