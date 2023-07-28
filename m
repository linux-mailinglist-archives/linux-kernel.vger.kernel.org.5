Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB497660C7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjG1Aal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjG1Aai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:30:38 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE5926B8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:30:37 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58439daf39fso15699347b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690504236; x=1691109036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8B+W4raln+fv6bRAh+wapLWcAVc89dNXktdeHQoG6I=;
        b=R9szNUv2ZXW5zeBHnA8N6txCctyHWtdup0t5MpljMkM2wCH9mHOEhopcvj7mEPRj8w
         bz8pMacXdEXTX8FzSfL9SiHynmFMWI5fYjw64Lc1Fnal2gmC0+8FeTqxX0CbIsVnY8v2
         qqMYxdVQrZ7U0OrbNJDpgkAIw1VxS/TLuw31UscNdEEh0tzwMUcnVZD1oF5/XNQlDhkj
         Xpyh5tUMk+DGMFDZLloZa1S9TVtmQjHxkxZ3a+jAINAXw5T9dIdZKGyqGVdZ49mPpxBm
         q/usOPtbZIhpwcus31k+jZW6XdWgjymSKK8cx0TyCXQORyYBmgZMdcJk8O4zx3wPRcBA
         bLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690504236; x=1691109036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8B+W4raln+fv6bRAh+wapLWcAVc89dNXktdeHQoG6I=;
        b=OMnLudXxNoaJnHojvaw2+pEVkUc5eQjPKMBW7Tz013KksxeRMs7X0XXKseBbUeqvJg
         RGYBseyYiyPZQML/2EHmcPcUAOkrg8ZgTm5h99bx9eupcIjZs9ud/suHyA5oerDtKyFj
         kl8tqmGDY+ovYRJOHUS8AAYdIEWFXnAzAC/1iLGNVtyvZuqAaotcd2/O7q/DXWjpQ89h
         +57+EWeNaF8b6ZcDY2G9vv3DK75zOJ071Tv/dSmX3WEjRtmUpXO2C/g9EmSAtgdk3pEm
         MuswvdJmesKLMSmPBWE6Udvw9sokU4DwI4jBUlwelnvDiqKaTNbuHUCgKCrIk1x983k5
         RZvg==
X-Gm-Message-State: ABy/qLaj7q3e0Bu1oMgUTEncegJbTooRyWXJMBD1UIS1NmuftFtzls2l
        CemDZaXDd2MEnB9W/pBjHy4JIZejJaGj9rq3Svd5Uw==
X-Google-Smtp-Source: APBJJlH7n38F5r8G3MCJnx4Juf2UJal3ebOupKmPU7479rxAqPe5XWUKDBfUjXNx0UXc7gfdoY7JMyb1nguTwnlhN5w=
X-Received: by 2002:a81:d548:0:b0:575:4b1c:e5ea with SMTP id
 l8-20020a81d548000000b005754b1ce5eamr284331ywj.47.1690504236099; Thu, 27 Jul
 2023 17:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230728091849.7f32259d@canb.auug.org.au> <ZMMCnvc3h7XT/NM2@casper.infradead.org>
 <20230728102022.7593856b@canb.auug.org.au> <CAJuCfpHzz3f8Ru7C03b-TVi0g1gcMOEkd2v=ayNunEEs6cjZxg@mail.gmail.com>
 <20230728102936.66ac5481@canb.auug.org.au>
In-Reply-To: <20230728102936.66ac5481@canb.auug.org.au>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 27 Jul 2023 17:30:23 -0700
Message-ID: <CAJuCfpFQZPhHEQTQF_js=jrh1sV22ykrqFNXSdN71DFRv9=GyA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 5:29=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi Suren,
>
> On Thu, 27 Jul 2023 17:23:45 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
> >
>  Hmm. 657b5146955e ("mm: lock_vma_under_rcu() must check vma->anon_vma
> > under vma lock") should be adding a "inval_end_read" label. At least I
> > see it in https://lore.kernel.org/all/20230726214103.3261108-3-jannh@go=
ogle.com/
> > and will check Linus' tree in a min. I don't see that label in your
> > patch...
>
> It's there in the file, but did not conflict with anything.  What I
> published is not a "patch" as such, but a diff showing the conflict
> resolution.

Ah, sorry for the noise then.

>
> --
> Cheers,
> Stephen Rothwell
