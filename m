Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1614785E54
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbjHWRMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjHWRMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:12:18 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15234E66
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:12:17 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-57129417cecso31897eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692810736; x=1693415536;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3kf5tMI8ut+y9FRn5NAWKGikc29U/xDcFhkC4R7s/0=;
        b=HvcujqRF/eEGtkLS78l2UiWtOLNFAF2fPJCbxw3yT3qh9h2t6ZW6Bh9M4YQFHoF7uX
         xieuwO9PrRtr71KL94kNhh6jrrr1ZTphr2uigNOYobuM8AfblOvfy6B0KMBpnujLZCP9
         PV9AFrzGhlhoJEojhq1eoOe3Ic3Wpq9G3ZEgeKYqDzAVh87Gp1MwRCRd010WjuRA0nvn
         X3zbZtgJ/LnuD7F3CwWPgKILFu7WYk4XVFBPiC6DD4KSd5WIk0n1skHsy+Ier/TSgPkY
         /kiDSf3/xE5JNyBSDUHB1mn4Sj0859nGDhPk+LyDO3Bkg00J+4/TnOGIXvS0lxPZoEW3
         dhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692810736; x=1693415536;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3kf5tMI8ut+y9FRn5NAWKGikc29U/xDcFhkC4R7s/0=;
        b=gEBxkAyzbjUipMGeCd8mjBz82uMk/LS/bwcxGY1wqFCdzDm5U7ladoshVyMTe9kBAl
         E3jxSx6eIXGsfQKbYoEiDinzZrK3pFlb0WVHJWhTBviz9Bbd2p7fG1a4eAjWgDUGkY/k
         R4hgBM+I0z4h4+KPfFr6j/Ul1ld2mTvngh5kC2FQFppB9Qz6il8CyEDQjedy4zF5uIbi
         sg2vCKNcQsSTMbfQzPSfwFVDFeoP9dY39lTNLRdqPsgmr+zzp/TlMp6K7KXowDoDOXS+
         SSFqq/vVZujoL+ugPDvXLo0YPCaONJIs9FfHcBh2fz6G0UY03ZQFo/MuXyT351C7x9qT
         0IQQ==
X-Gm-Message-State: AOJu0Yy1jpsaSuow6zZnTDbVaKI6lXvGE1JKr30W09LgDhkM9eIwHA/B
        YO7JaYfE1JMPQv20dz4q8kwv/IsJrE5poxIgL8Y=
X-Google-Smtp-Source: AGHT+IGUs5LH9rHaR0tTkbQsJfX/lg3J2ggw+7MvXrCzYgEErNZnSIOE5nVbwlTeFJnRNO/tAn8zkbJ7hvqLbIHTKcg=
X-Received: by 2002:a4a:e64e:0:b0:56c:a9fe:f701 with SMTP id
 q14-20020a4ae64e000000b0056ca9fef701mr8579452oot.3.1692810736161; Wed, 23 Aug
 2023 10:12:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5797:0:b0:4f0:1250:dd51 with HTTP; Wed, 23 Aug 2023
 10:12:15 -0700 (PDT)
In-Reply-To: <20230823164116.aqjl6f5m2o3rwyxe@quack3>
References: <20230821202829.2163744-1-mjguzik@gmail.com> <ZOPSEJTzrow8YFix@snowbird>
 <20230821213951.bx3yyqh7omdvpyae@f> <CAGudoHHJECp2-DfSr5hudooAdV6mivvSO+4mC9kwUrWnSiob5g@mail.gmail.com>
 <20230822095154.7cr5ofogw552z3jk@quack3> <CAGudoHHe5nzRTuj4G1fphD+JJ02TE5BnHEDwFm=-W6DoEj2qVQ@mail.gmail.com>
 <20230823094915.ggv3spzevgyoov6i@quack3> <CAGudoHFFt5wvYWrwNkz813KaXBmROJ7YJ67s1h3_CBgcoV2fCA@mail.gmail.com>
 <20230823154728.rpkw6fpwvwqbnnh3@quack3> <CAGudoHFvGwcQ+8JOjwR3B=KtHiVqC1=eiNgGv33z29443VJdFg@mail.gmail.com>
 <20230823164116.aqjl6f5m2o3rwyxe@quack3>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Wed, 23 Aug 2023 19:12:15 +0200
Message-ID: <CAGudoHEmKLkPHMegbuqDOdS-HvojWYJ-KKVjUs=N4e3DLMg-zA@mail.gmail.com>
Subject: Re: [PATCH 0/2] execve scalability issues, part 1
To:     Jan Kara <jack@suse.cz>
Cc:     Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        shakeelb@google.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23, Jan Kara <jack@suse.cz> wrote:
> On Wed 23-08-23 18:10:29, Mateusz Guzik wrote:
>> So the question is how much does this matter. My personal approach is
>> that avoidable slowdowns (like atomics here) only facilitate further
>> avoidable slowdowns as people can claim there is a minuscule change in
>> % to baseline. But if the baseline is already slow....
>
> I get your point but over the years I've also learned that premature
> optimization isn't good either as we will be dragging the maintenance
> burden for a long time ;) It's a balance.
>

Mate, your proposal is not maintenance burden-free either. ;)

I claim mine is simpler and faster for single threaded case, but is
not generic so should another consumer show up with the single vs
multithreaded need, there may or may not be more work to accommodate
it.

-- 
Mateusz Guzik <mjguzik gmail.com>
