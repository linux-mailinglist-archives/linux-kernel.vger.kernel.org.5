Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179EC785752
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjHWMBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjHWMBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:01:34 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E23E5F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:01:32 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-570fde9baadso879671eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692792092; x=1693396892;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5YEBhZhoD6dr30AIMJU2oUf9f7QESvxiwlqE3A/1owk=;
        b=MPhsYX0cFKLJFNZ/2cc/bmkuijN1lA6UAbTebZFhjBs35BWSUDkHMkat/nVeT9WY/p
         zqo6ONxBgbay6vC4xE7yhyjWvE8ieaLyXYddOKRY2cUAg7ysL83hcGBp3pr/gULxUCGW
         7mHucum2b4P8rrPiJLh7wFsFYO7wtp4uSgwNua+RNuUhzpnSdcVsLKHyI/cb81wfppci
         7lmEAs4s0dvQchN2pg6h9oKLrSNbZ0F1XK+XL74i0BNRWn7/mPZ+4o+q9CaLNULnXywh
         tWvBIdG/Hc4qlE3Q2r+oDYH+tKs68ZDFNNn9hlYFXd2gnVRH7jK730TikKFyWU004ufo
         YHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692792092; x=1693396892;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YEBhZhoD6dr30AIMJU2oUf9f7QESvxiwlqE3A/1owk=;
        b=g29PvfMEZnvw0kBD7eMQ/1COMjILQMwwKGouR7q+a4haJDsC6M425FbtKrX7eONYNp
         Qv+19hGDHWEe1d0+2HL6P2omav0f6FD5vu2aL92C6+LZZb7lK31EZEsFRhY6bZSqqDJD
         vh/4MTaiwoeKorCNgKXIVmWRd/mWA9dAtNH/L980n2BtT1Nc3UdWk5SOrc414EJ5Kn75
         H/D7Gnz0jx1FNy5oqTU0nTRCvHzcaBQTnzTdwFPSLDsUy26EFulfRiwtYLdLoGyXCJNA
         zw0kbK+j7Bdv6iiTLHYAAE5WGNuHVWKrOTBEN5HHOfXOK2+UnVtCuYgdnIdwGT+hEwRL
         xJWg==
X-Gm-Message-State: AOJu0YzUTM9sVX+djmWQfvOVOUqrxmF1ONDZbmsVEWgCab3zHpbZgkJk
        1yd1Dvx/Y6ks1U19SHmM5kOsrZDsqQKyY8y0y0E=
X-Google-Smtp-Source: AGHT+IGdMBaqY8U5lYfVWUgRs8i18SdhOSdqAL16Q8xjC0KKeHW4s0WpLl3rJVZTFBgAohwJlGaZ48ghJ/Lqz0ZGJ+w=
X-Received: by 2002:a4a:6211:0:b0:56c:820e:7f02 with SMTP id
 x17-20020a4a6211000000b0056c820e7f02mr11046312ooc.0.1692792091674; Wed, 23
 Aug 2023 05:01:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5797:0:b0:4f0:1250:dd51 with HTTP; Wed, 23 Aug 2023
 05:01:31 -0700 (PDT)
In-Reply-To: <c5b9a025165a4c93aa10b462a40641dc@AcuMS.aculab.com>
References: <20230821202829.2163744-1-mjguzik@gmail.com> <ZOPSEJTzrow8YFix@snowbird>
 <20230821213951.bx3yyqh7omdvpyae@f> <CAGudoHHJECp2-DfSr5hudooAdV6mivvSO+4mC9kwUrWnSiob5g@mail.gmail.com>
 <20230822095154.7cr5ofogw552z3jk@quack3> <CAGudoHHe5nzRTuj4G1fphD+JJ02TE5BnHEDwFm=-W6DoEj2qVQ@mail.gmail.com>
 <20230823094915.ggv3spzevgyoov6i@quack3> <c5b9a025165a4c93aa10b462a40641dc@AcuMS.aculab.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Wed, 23 Aug 2023 14:01:31 +0200
Message-ID: <CAGudoHFuBwq78nZOJJ8itg0Kj8B2K1z5uRh2VEVNuBM=6wp0Wg@mail.gmail.com>
Subject: Re: [PATCH 0/2] execve scalability issues, part 1
To:     David Laight <David.Laight@aculab.com>
Cc:     Jan Kara <jack@suse.cz>, Dennis Zhou <dennis@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
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

On 8/23/23, David Laight <David.Laight@aculab.com> wrote:
> From: Jan Kara
>> Sent: Wednesday, August 23, 2023 10:49 AM
> ....
>> > --- a/include/linux/mm_types.h
>> > +++ b/include/linux/mm_types.h
>> > @@ -737,7 +737,11 @@ struct mm_struct {
>> >
>> >                 unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for
>> > /proc/PID/auxv */
>> >
>> > -               struct percpu_counter rss_stat[NR_MM_COUNTERS];
>> > +               union {
>> > +                       struct percpu_counter rss_stat[NR_MM_COUNTERS];
>> > +                       u64 *rss_stat_single;
>> > +               };
>> > +               bool    magic_flag_stuffed_elsewhere;
>
> I wouldn't use a union to save a pointer - it is asking for trouble.
>

I may need to abandon this bit anyway -- counter init adds counters to
a global list and I can't call easily call it like that.

>> >
>> >                 struct linux_binfmt *binfmt;
>> >
>> >
>> > Then for single-threaded case an area is allocated for NR_MM_COUNTERS
>> > countes * 2 -- first set updated without any synchro by current
>> > thread. Second set only to be modified by others and protected with
>> > mm->arg_lock. The lock protects remote access to the union to begin
>> > with.
>>
>> arg_lock seems a bit like a hack. How is it related to rss_stat? The
>> scheme
>> with two counters is clever but I'm not 100% convinced the complexity is
>> really worth it. I'm not sure the overhead of always using an atomic
>> counter would really be measurable as atomic counter ops in local CPU
>> cache
>> tend to be cheap. Did you try to measure the difference?
>
> A separate lock is worse than atomics.
> (Although some 32bit arch may have issues with 64bit atomics.)
>

But in my proposal the separate lock is used to facilitate *NOT* using
atomics by the most common consumer -- the only thread.

The lock is only used for the transition to multithreaded state for
updated by remote parties (both rare compared to updated by current).

> I think you'll be surprised just how slow atomic ops are.
> Even when present in the local cache.
> (Probably because any other copies have to be invalidated.)
>

Agreed. They have always been super expensive on x86-64 (and continue
to be). I keep running to claims they are not, I don't know where
that's coming from.

-- 
Mateusz Guzik <mjguzik gmail.com>
