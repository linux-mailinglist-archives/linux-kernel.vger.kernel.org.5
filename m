Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05DC7BCF55
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 19:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344958AbjJHREG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 13:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344915AbjJHREE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 13:04:04 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DED9F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 10:04:03 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-692c02adeefso2803883b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 10:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696784643; x=1697389443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qxoU4OHIoeBK9ji2zbzwkkBd9mupqYsOWbXItFCCnls=;
        b=fGNP8mfQEGFEby8aK3zZepKld88IXRdUurMxOy8i/ya+yfJ1QlX+Jq3hT9L6NSss6I
         0/mT77NtEUbJzufPer8wiosykktya0WCcYfmysILLAoX+b4YXxFHszR1KLPqr03SOus1
         USMay7lQJ0Botqn3Zd7CKLBHfDTyLsV4xRaTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696784643; x=1697389443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxoU4OHIoeBK9ji2zbzwkkBd9mupqYsOWbXItFCCnls=;
        b=SosMl5R7KUT1HnXK5txMGCq8SPbWBjFtcYK1R3635fDc/FE07ssB+Q8ShUmHFPBTkD
         Jvg4812TsX37guEgvQhT0VsJGg5D6N7+t6zy7nTXkNTyEYtIQcAYtITGgyJLYHxZ/2am
         Tp7NSFfIbsU/GcvKtFi1iFQtPd7Fpodgds3DZrKQfpnoEo20xYd/ElXvlWN2bbgmdBeX
         aa3NPQi4hTi8u8XgtP7vyilRjxDju9c0QLNxzbb6HbFerY24bY3Xc+WSoxFRNskFZFWP
         GCZZbYsQ0mmks/jMqmHqvYiSaP6IeVm+TuNvqI0voFOVIaZsFqAgSbni1To86HIo6J3L
         jE7Q==
X-Gm-Message-State: AOJu0YzFi7fhZt6lmiJOXbEyaEP9kArCriCRLD0B8b5KLlxEN9H4DIvS
        +bdnWR9jZgNLT/MfkToqnbOyPg==
X-Google-Smtp-Source: AGHT+IEEeNmMJAwl/ixD1qEg1w/8dwvTcuYpgFLmflDVQdLpeZdvcLzrDROPnl0wnhtg8BzWKTimSg==
X-Received: by 2002:a05:6a20:8f03:b0:161:3120:e888 with SMTP id b3-20020a056a208f0300b001613120e888mr14529085pzk.46.1696784642780;
        Sun, 08 Oct 2023 10:04:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x9-20020a63b349000000b00563ea47c948sm5923442pgt.53.2023.10.08.10.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 10:04:01 -0700 (PDT)
Date:   Sun, 8 Oct 2023 10:04:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Lukas Loidolt <e1634039@student.tuwien.ac.at>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Marth <daniel.marth@inso.tuwien.ac.at>
Subject: Re: Missing cache considerations in randstruct performance feature
Message-ID: <202310081002.F5A5D6F8A@keescook>
References: <f3ca77f0-e414-4065-83a5-ae4c4d25545d@student.tuwien.ac.at>
 <202310062111.809AB4E56@keescook>
 <91b28627-c3e1-4b56-bd7d-ed8b607add39@student.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91b28627-c3e1-4b56-bd7d-ed8b607add39@student.tuwien.ac.at>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 12:38:28PM +0200, Lukas Loidolt wrote:
> On 07.10.23 06:12, Kees Cook wrote:
> > On Sat, Oct 07, 2023 at 12:30:01AM +0200, Lukas Loidolt wrote:
> > > In my tests, however, the performance version behaves more or less like the
> > > full version of randstruct.
> > 
> > Can you try this patch?
> > 
> > 
> > commit d73a3244700d3c945cedea7e1fb7042243c41e08
> > Author:     Kees Cook <keescook@chromium.org>
> > AuthorDate: Fri Oct 6 21:09:28 2023 -0700
> > Commit:     Kees Cook <keescook@chromium.org>
> > CommitDate: Fri Oct 6 21:09:28 2023 -0700
> > 
> >      randstruct: Fix gcc-plugin performance mode to stay in group
> > 
> >      The performance mode of the gcc-plugin randstruct was shuffling struct
> >      members outside of the cache-line groups. Limit the range to the
> >      specified group indexes.
> > 
> >      Cc: linux-hardening@vger.kernel.org
> >      Reported-by: Lukas Loidolt <e1634039@student.tuwien.ac.at>
> >      Closes: https://lore.kernel.org/all/f3ca77f0-e414-4065-83a5-ae4c4d25545d@student.tuwien.ac.at
> >      Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
> > index 951b74ba1b24..178831917f01 100644
> > --- a/scripts/gcc-plugins/randomize_layout_plugin.c
> > +++ b/scripts/gcc-plugins/randomize_layout_plugin.c
> > @@ -191,7 +191,7 @@ static void partition_struct(tree *fields, unsigned long length, struct partitio
> > 
> >   static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prng_state)
> >   {
> > -       unsigned long i, x;
> > +       unsigned long i, x, index;
> >          struct partition_group size_group[length];
> >          unsigned long num_groups = 0;
> >          unsigned long randnum;
> > @@ -206,11 +206,14 @@ static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prn
> >          }
> > 
> >          for (x = 0; x < num_groups; x++) {
> > -               for (i = size_group[x].start + size_group[x].length - 1; i > size_group[x].start; i--) {
> > +               for (index = size_group[x].length - 1; index > 0; index--) {
> >                          tree tmp;
> > +
> > +                       i = size_group[x].start + index;
> >                          if (DECL_BIT_FIELD_TYPE(newtree[i]))
> >                                  continue;
> >                          randnum = ranval(prng_state) % (i + 1);
> > +                       randnum += size_group[x].start;
> >                          // we could handle this case differently if desired
> >                          if (DECL_BIT_FIELD_TYPE(newtree[randnum]))
> >                                  continue;
> > 
> > --
> > Kees Cook
> 
> I think, this is still missing a change in the randnum calculation to use index instead of i.
> Without that, randnum can be larger than the length of newtree, which crashes kernel compilation for me.

Oops, yes, I missed that while refactoring my patch to reduce lines
changed.

> 
> diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
> index 178831917f01..4b4627e3f2ce 100644
> --- a/scripts/gcc-plugins/randomize_layout_plugin.c
> +++ b/scripts/gcc-plugins/randomize_layout_plugin.c
> @@ -212,7 +212,7 @@ static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prn
>                         i = size_group[x].start + index;
>                         if (DECL_BIT_FIELD_TYPE(newtree[i]))
>                                 continue;
> -                       randnum = ranval(prng_state) % (i + 1);
> +                       randnum = ranval(prng_state) % (index + 1);
>                         randnum += size_group[x].start;
>                         // we could handle this case differently if desired
>                         if (DECL_BIT_FIELD_TYPE(newtree[randnum]))
> 
> 
> The patch seems to work after that though. For the previous example, I now get the following layout:
> 
> func1 (offset: 0)
> func3 (offset: 8)
> func4 (offset: 16)
> func6 (offset: 24)
> func7 (offset: 32)
> func8 (offset: 40)
> func5 (offset: 48)
> func2 (offset: 56)
> func10 (offset: 64)
> func9 (offset: 72)
> 
> Regarding the shuffling of groups/partitions (rather than just the randomization of structure members within each partition), I'm not sure if that was intended at some point, but it might be worth looking into.

Yeah, this is also clearly not working.

> I'd assume it would improve randomization without sacrificing performance, and it's also what the clang implementation of randstruct does.

Thanks for testing!

-Kees

-- 
Kees Cook
