Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4483378C676
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbjH2Nur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbjH2NuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:50:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA162BD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:50:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50078eba7afso7060151e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693317020; x=1693921820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EXJHebw1V4bZ1/ki3Vw73QN6j29Qahgy3RzS/itoss=;
        b=QNN4vjMpQRJamoWPaQeIDRuDmabhTmsOwrgycZHuQwtsju3MdzmvqbecxFixHauRbX
         Hpiv4uz3L8UwwOgLj2opM8WqwcmYVjdna1TCtcvKFjcpxSGOQZfubIw2GojbEU4UeVee
         bSLfIg6+/6faChHrPZ6tKOqZfs8ie/Ox0MFPlQ9GLhWT/h59iOfNBzGUK6sp6npHQceM
         Pwrh+ktAAv3ugMXHlE0cPDcOFW9hBCBi0senUfY2hH853+U/rs0J2cQeEUwU9PbdAwFA
         KJ/n8pkZx6GhTYHOzvhHsBTKpPeIQmzGFSvIrrQC34I/uhL21HT0vNExJ/egSxzSw/18
         yGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693317020; x=1693921820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EXJHebw1V4bZ1/ki3Vw73QN6j29Qahgy3RzS/itoss=;
        b=HsfxcdX5lbaBPlokE8/oKB3YxtxC28RrGI+mQDIbys6CrdnetcI3w7uI1znYloXPc6
         yepttC1aWEf0xtuIfKcyEhe/n1tj1c71mOObX3GpX/cgyArD8dQpYuSgJb+zJhnulq+c
         vJ2+uokmy2NqQ2imNZToAUI8Hjdmor7rIoN6AkxYkFH+2+sYDoL3wqM2bESENv/AnRag
         m2C0wcJBQRngKa/9oPUPriog2Ob8jHS3SKl/DN0NBCd2fJn2JIJdSZTHxP1g3Vs1ppZL
         MrDOGABpN0WQJOiJPJ2LEYzi8Kgy+wsOJlgkjthnGRgeifFvoXaL7nBzsYXA66ebv84p
         LMmg==
X-Gm-Message-State: AOJu0YwG7X4jp1AHNI2V4h/3yH8wuVUYtYmHEkjiGUXAUV0z+emlSgL7
        lADbUgDym1y1/LhoFwBEWFVmKjoeeiPbNoGbs0jjAU9M
X-Google-Smtp-Source: AGHT+IHl3ql42DrMlSRqSPaDG2DrXMaqylxXAv+/RB9sCOGgn7GSTpZ+UINLDxqXdRcB2auAOReIOqKXFc/pI7TKW3I=
X-Received: by 2002:a05:6512:3241:b0:4fd:f889:b9d2 with SMTP id
 c1-20020a056512324100b004fdf889b9d2mr18279727lfr.38.1693317019712; Tue, 29
 Aug 2023 06:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230828184353.5145-1-yury.norov@gmail.com> <5247e354-cb7f-4df7-37a5-95cebed43d4c@rasmusvillemoes.dk>
 <ZO304SCFoP2wmnNA@smile.fi.intel.com>
In-Reply-To: <ZO304SCFoP2wmnNA@smile.fi.intel.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 29 Aug 2023 06:50:08 -0700
Message-ID: <CAAH8bW-jO=BEY3j5JVJcuVsCeUzWsgNqfg-b7EHt-w00vjP+gQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] bitmap: rework bitmap_{bit,}remap()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 6:39=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 29, 2023 at 09:33:29AM +0200, Rasmus Villemoes wrote:
> > On 28/08/2023 20.43, Yury Norov wrote:
> > > This series adds a test, const-time optimizaton and fixes O(N^2)
> > > complexity problem for the functions. It's based on discussion in
> > > bitmap: optimize bitmap_remap() series [1], but there's much more wor=
k
> > > here, so I decided to give it a separete run, and don't name it as v2=
.
> > >
> > > bitmap_remap() API has just one user in generic code, and few more in
> > > drivers, so this may look like an overkill. But the work gives ~10x
> > > better performance for a 1000-bit bitmaps, which is typical for nodem=
asks
> > > in major distros like Ubuntu.
> >
> > Can you find just _one_ project on Debian Code Search or elsewhere that
> > actually uses mbind(2), that could possibly ever trigger the use of tha=
t
> > bitmap_remap stuff? Also, the bitmap may be order 10, but that's just
> > because the kitchen sink distros are silly, real machines have nowhere
> > near that number of nodes, so even if mbind is used, the bitmaps
> > involved will never actually have anything beyond index ~64.
> >
> > I think this is all total overkill for non-existing problems, and when
> > it takes me 20 seconds to find the first bug, I really don't think it's
> > worth the churn. I'm not giving a thorough review on the rest of the
> > series, nor commenting on followups.
>
> I posted one patch to replace these APIs with something else, more partic=
ular
> for GPIO case(s). Have you chance to look at that? With that taking in, I=
'm
> fully agree on the above statement (as we lose the user of this complicat=
ed
> thingy which is a niche of the NUMA as you mentioned already).

I saw the code in a comment in some thread but not as a separate patch, and
AFAIK you said it's a work-in-progress.

Sorry if I missed your submission. Can you please send the patch or point m=
e to
the previous submission?

Also, if after your change bitmap_remap would become a NUMA-specific, shoul=
d
protect it with NUMA guards?

Thanks,
Yury
