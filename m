Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CC8776ABE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjHIVHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjHIVHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:07:47 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33AA1724;
        Wed,  9 Aug 2023 14:07:46 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1c034312675so181385fac.3;
        Wed, 09 Aug 2023 14:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691615266; x=1692220066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQhPymUQatLez9OhAXnkjteLBnvrlDrlwzKYnLXCkIU=;
        b=EUnhMb2XtpgZMeivppTYpKUPHU/1tJTVNBvx8vjB6hgiPMyGsMKylvyif+u5Dy9rTO
         MbQnLpB9E25ZjsusJDPz5b2JQva54uSYWYx+1c4sA6X4S0vkJkRcrz01EIBvZMxr57Zl
         srRkBKI4gD1LySDPQnA8AFHo8eQclUdgOBu5zQe0t6UHyPNBGHga2x38AT3tJopFblRM
         /wolOhfa4YMk3v7GqzGSVnmS01EF8XvsSnMK4eMdDmRPLskyVcvqMA2jHa5XPkMH7CaF
         wrnnPYbeFBNeFTymBA7lA6EtgvuuWWPGNhHBn4V9roF47dPo0wrijxcmSVNKIse63GnY
         Eupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691615266; x=1692220066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQhPymUQatLez9OhAXnkjteLBnvrlDrlwzKYnLXCkIU=;
        b=F9+GPqKHORhV/3dRmkBUQXnEh6DGAUkuTgikpmdXhrhWxoeqxqta0WGAFZmcWvgwJh
         vgCC7cSIi4qDp7wJ+LPSX8m3vuVmLobggXu44fzcjJ+qANJlFE0Kyan20M/yjGPmNrl7
         uPZfPCF20qtj3JIId8SDIRLwPsdS10OeOcbeg4GxZREMINuyPu8WVqYlhJcc/QQkAgCX
         X7MdqJ5jT4tu0rDtV8XS0FBbkhteQGQ7ABz9RmxLt2l9U8JDBQqbRvhHyntsSA5OWbb1
         s5+gqIy9jomAg4plTEqSwDNohKJ2eX1bdYABUZVd0tV+HPgxag3UpAKfhj9BdIgwetYW
         3Nng==
X-Gm-Message-State: AOJu0Yz76vZEjWz2DhEhk2uqNpqmB7juuf54RyC7gz+SS2cXtoiA8JDr
        zSQG7TFnXqgNPUXlG8/zB6C9B1KKiRsDCZ3K3b0=
X-Google-Smtp-Source: AGHT+IEfcjCJMWcdPFDkWHU7lh8NId2uR9ZSbF4zjNWL5iX3wKgvPA5uGM4+ivUnywUPI0zMEhF9Oh8mRWxuJA61RBA=
X-Received: by 2002:a05:6870:88a9:b0:1b4:7411:5c0c with SMTP id
 m41-20020a05687088a900b001b474115c0cmr443843oam.13.1691615265775; Wed, 09 Aug
 2023 14:07:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:129a:0:b0:4f0:1250:dd51 with HTTP; Wed, 9 Aug 2023
 14:07:45 -0700 (PDT)
In-Reply-To: <CAJuCfpE6K6x7EKAr2rtW1Gn+1oht6w2qZSZ2bGATfoe8C8fJhA@mail.gmail.com>
References: <20230708191212.4147700-1-surenb@google.com> <20230708191212.4147700-3-surenb@google.com>
 <20230804214620.btgwhsszsd7rh6nf@f> <CAHk-=wiy125k1dBmQFTGpHwiOqEyrD6xnd4xKWfe97H_HodgDA@mail.gmail.com>
 <CAGudoHFsAU_BDCOuz8UgDBLGEM8xg=aUGjaVoqkM_Zvxo2Re_g@mail.gmail.com>
 <CAHk-=wiG9xaVvBJXHqTxtop0=mW9KxPS9C54ED23p59VNEKdWg@mail.gmail.com>
 <CAGudoHFsxmiezZREyVkrPYBBij3u9SNaxLWipOOPy5S+5pJcZA@mail.gmail.com> <CAJuCfpE6K6x7EKAr2rtW1Gn+1oht6w2qZSZ2bGATfoe8C8fJhA@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Wed, 9 Aug 2023 23:07:45 +0200
Message-ID: <CAGudoHEU62Rpp+uJakCFgKC36y3th=Qx+jE+b7KJh6_jeH7cNg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fork: lock VMAs of the parent process when forking
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, regressions@leemhuis.info,
        bagasdotme@gmail.com, jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/23, Suren Baghdasaryan <surenb@google.com> wrote:
> On Fri, Aug 4, 2023 at 6:06=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>>
>> On 8/5/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> > On Fri, 4 Aug 2023 at 16:25, Mateusz Guzik <mjguzik@gmail.com> wrote:
>> >>
>> >> I know of these guys, I think they are excluded as is -- they go
>> >> through access_remote_vm, starting with:
>> >>         if (mmap_read_lock_killable(mm))
>> >>                 return 0;
>> >>
>> >> while dup_mmap already write locks the parent's mm.
>> >
>> > Oh, you're only worried about vma_start_write()?
>> >
>> > That's a non-issue. It doesn't take the lock normally, since it starts
>> > off
>> > with
>> >
>> >         if (__is_vma_write_locked(vma, &mm_lock_seq))
>> >                 return;
>> >
>> > which catches on the lock sequence number already being set.
>> >
>> > So no extra locking there.
>> >
>> > Well, technically there's extra locking because the code stupidly
>> > doesn't initialize new vma allocations to the right sequence number,
>> > but that was talked about here:
>> >
>> >
>> > https://lore.kernel.org/all/CAHk-=3DwiCrWAoEesBuoGoqqufvesicbGp3cX0LyK=
gEvsFaZNpDA@mail.gmail.com/
>> >
>> > and it's a separate issue.
>> >
>>
>> I'm going to bet one beer this is the issue.
>>
>> The patch I'm responding to only consists of adding the call to
>> vma_start_write and claims the 5% slowdown from it, while fixing
>> crashes if the forking process is multithreaded.
>>
>> For the fix to work it has to lock something against the parent.
>>
>>         VMA_ITERATOR(old_vmi, oldmm, 0);
>> [..]
>>         for_each_vma(old_vmi, mpnt) {
>> [..]
>>                 vma_start_write(mpnt);
>>
>> the added line locks an obj in the parent's vm space.
>>
>> The problem you linked looks like pessimization for freshly allocated
>> vmas, but that's what is being operated on here.
>
> Sorry, now I'm having trouble understanding the problem you are
> describing. We are locking the parent's vma before copying it and the
> newly created vma is locked before it's added into the vma tree. What
> is the problem then?
>

Sorry for the late reply!

Looks there has been a bunch of weird talking past one another in this
thread and I don't think trying to straighten it all out is worth any
time.

I think at least the two of us agree that if a single-threaded process
enters dup_mmap an
down_writes the mmap semaphore, then no new thread can pop up in said
process, thus no surprise page faults from that angle. 3rd parties are
supposed to interfaces like access_remote_vm, which down_read said
semaphore and are consequently also not a problem. The only worry here
is that someone is messing with another process memory without the
semaphore, but is very unlikely and patchable in the worst case -- but
someone(tm) has to audit. With all these conditions satisfied one can
elide vma_start_write for a perf win.

Finally, I think we agreed you are going to do the audit ;)

Cheers,
--=20
Mateusz Guzik <mjguzik gmail.com>
