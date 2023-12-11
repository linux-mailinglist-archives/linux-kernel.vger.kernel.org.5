Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB05480DA44
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjLKTCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344328AbjLKTCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:02:09 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0935B4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:02:15 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-425928c24easo60481cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702321335; x=1702926135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KbcZPb3ouJho6Kgt8unn6XTmhQsbLYfRLMQ3Ty9aJ8=;
        b=ewBQ2+NWTIjvRSqDb9QeOuePngiKNOVIAbFJqxBHlWZ2tP0J3HUpv+DEyw8TYWw64h
         MZ2rovbdLI8H+1ghfrIoUaJp2FOYXyjcCVesdTnJvgN7kngySUkHjacRXJEIhOKL+eld
         di9fWCTEynvaHXgLKukODQq/Cxk0jRhrSxs32lOpTuRlvYLv0NtMGtTeWDjvQjnnlkz7
         zSiMYY/gHR3EipL2u6Le+TfaNTaO+Q8o3Q9kXPJ9JB5TOgPJNFeLXSmA4V/GZelTGvqY
         +AcDIFmp1elq0pz3YOEeiM2ez8jBkLMzcwTZPF47/9Rzy/0x2BvewMne4FsNCJY4DTlU
         izZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702321335; x=1702926135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KbcZPb3ouJho6Kgt8unn6XTmhQsbLYfRLMQ3Ty9aJ8=;
        b=LNhqphWhlC2uTt+ZR6V+5OP4vz2GDBqiHYUBVMQkZhpfHPd0OozUgkfjjad+T1l+pm
         YS81o5P33KLiSPlg7Avdee8s0aELh6JA/sa9utffaMGtjCQWJWxERy/NKcHeYyjtKiwO
         qZ2+uFFSQDjU5kIVZRef8X51XImW+ZacwH+FOj6Hn8/wFIAmpgATKpIlNONQSb3Q15tg
         AhyCRzKUPM+7qcIeEcFm9bMscE1l+h2rgk5qhghJEPah1J1GcGohqcQcTHTSQjo4KK0M
         sIms5+CeCojzdW6vt0dUaykrlkRe0L622bUzymrE8QE+qnNmr+xfSR6JYVik7Mbr7Q6b
         qX2Q==
X-Gm-Message-State: AOJu0YxCz32RI2HsOnRG6hVgFkEKZQQJN5HKM9zVQu9kbEl0xXUDu0mc
        QcI5jQG7mCoY4N3EVZjq1G6SCuPdwSd59pSu4ZGS/Buw7EnMYqz2NCQ=
X-Google-Smtp-Source: AGHT+IFrfbj+eLMmkxLHWrqC5LctWxqWsndhpUQUdOAM30S9/QPHzDfQh81E3QDwDztHsUxuyk9EMgb9BvR0ULYp+nM=
X-Received: by 2002:a05:622a:190c:b0:423:b6a1:2088 with SMTP id
 w12-20020a05622a190c00b00423b6a12088mr738239qtc.5.1702321334910; Mon, 11 Dec
 2023 11:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20231204172646.2541916-1-jthoughton@google.com>
 <20231204172646.2541916-3-jthoughton@google.com> <20231211184236.GB26462@willie-the-truck>
In-Reply-To: <20231211184236.GB26462@willie-the-truck>
From:   James Houghton <jthoughton@google.com>
Date:   Mon, 11 Dec 2023 11:01:38 -0800
Message-ID: <CADrL8HXqKfG9S0xLot6gA7_Vhw7rod6WqqgcKAVWNZ4FJOquQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: mm: Always make sw-dirty PTEs hw-dirty in pte_modify
To:     Will Deacon <will@kernel.org>
Cc:     Steve Capper <steve.capper@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Mon, Dec 11, 2023 at 10:42=E2=80=AFAM Will Deacon <will@kernel.org> wrot=
e:
>
> On Mon, Dec 04, 2023 at 05:26:46PM +0000, James Houghton wrote:
> > Make it impossible to create a sw-dirty, hw-clean PTE with pte_modify.
> > Such a PTE should be impossible to create, and there may be places that
> > assume that pte_dirty() implies pte_hw_dirty().
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
>
> I'm not sure how, but you seem to be missing the '---' separator and the
> diffstat here, so I suspect this might confuse tools such as b4 which try
> to apply the patch directly.

Thanks for pointing that out. Looks like it came from using
`--summary` in git format-patch. :/

>
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/=
pgtable.h
> > index b19a8aee684c..79ce70fbb751 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -834,6 +834,12 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t=
 newprot)
> >               pte =3D set_pte_bit(pte, __pgprot(PTE_DIRTY));
> >
> >       pte_val(pte) =3D (pte_val(pte) & ~mask) | (pgprot_val(newprot) & =
mask);
> > +     /*
> > +      * If we end up clearing hw dirtiness for a sw-dirty PTE, set har=
dware
> > +      * dirtiness again.
> > +      */
> > +     if (pte_sw_dirty(pte))
> > +             pte =3D pte_mkdirty(pte);
> >       return pte;
>
> Looks like this is a fix for Catalin to pick up (patch #1 isn't necessary
> afaict).

If only this patch is taken, make sure to add cc:stable and the fixes
tag from patch #1. Thank you!
