Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22718770CDE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 03:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjHEBGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 21:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjHEBGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 21:06:15 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707E34EDE;
        Fri,  4 Aug 2023 18:06:14 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bb29b9044dso2459946a34.1;
        Fri, 04 Aug 2023 18:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691197574; x=1691802374;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5wLxtngQDf95laPzAr998ewYrpc6/LmQcNIxOteIueI=;
        b=JWEJoBXO0UGnBg4xLdw9KEUhTH4lf77t4U6moAOmDX1C3WqbrVn5+P7FXQ8ajzo70m
         3e/bt6Yn9H5A6cs+o19Z4C1zxcT4Et4m5abUWYZInQ1vxhkrUERvFXsImX2e/W3YpV0y
         MJDLZNtb6Mz6g1WmggiYRNxAYKbjQPfE9Hl/4M9hLwFDdXJi166vWIcQYeRTPnhJJYOa
         ijF8FYpFkp7oqHhWSIXvlxrG+UOuYO3wy+mJ2meE07tjEMkje7c42ME9yAweWkUXz+33
         4uV3V8Ld4pJPhV1V1BINXfsLX3bscp/Uu7w4V/Rj3IlZV3giEvAfAcTDasK9x9+ZBd7c
         HYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691197574; x=1691802374;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wLxtngQDf95laPzAr998ewYrpc6/LmQcNIxOteIueI=;
        b=SS4sjsNgW6gOw7nuNRskOcpXg3NMsw/Br7habEC/VL28N28MIIdBqizxQ2FfMlCvXv
         sHKDnFqYsr14F/EUiZQaaW+vYCiH5FQ45xMmmn6x4JgIPczhu8RTBCIGx22RH6aY/zPU
         DKNOuZbUM6xpMLs23FeFVscVl3D+DLImNTcRPjxDyP3xZfj4JwFxv8l8skoaT6F13aNR
         cIZDnDAFt6Mw2NlGyOFPdayWBwXey994XxDk9Mud/o5spOHA8IGuScy134ePFtuZ0AEU
         PqZ8+BqWQPSP8QGoZ0A7C694C2UWyETtq0rUJQSgL3CMW/2mdwwJUq0r9kHlTlOrw2oa
         BUew==
X-Gm-Message-State: AOJu0YwqyL14GF3tW1IfvttcOcPckWpcm807m3ImlEB/BODMxcUc82eQ
        aAe8agViZQdcrO5w71j6wEiPd3USjvTPrrxoI8w=
X-Google-Smtp-Source: AGHT+IG8PbrHRgIVAkXmrYRri3sk0mgD3rxRszibk3mbzi2/k2uRhFt/+JykTBC0PKuE3GPwCgYcPa9/gb2M+tKCYKM=
X-Received: by 2002:a05:6870:82a2:b0:1b0:449e:cff9 with SMTP id
 q34-20020a05687082a200b001b0449ecff9mr4064524oae.57.1691197573686; Fri, 04
 Aug 2023 18:06:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7b87:0:b0:4f0:1250:dd51 with HTTP; Fri, 4 Aug 2023
 18:06:13 -0700 (PDT)
In-Reply-To: <CAHk-=wiG9xaVvBJXHqTxtop0=mW9KxPS9C54ED23p59VNEKdWg@mail.gmail.com>
References: <20230708191212.4147700-1-surenb@google.com> <20230708191212.4147700-3-surenb@google.com>
 <20230804214620.btgwhsszsd7rh6nf@f> <CAHk-=wiy125k1dBmQFTGpHwiOqEyrD6xnd4xKWfe97H_HodgDA@mail.gmail.com>
 <CAGudoHFsAU_BDCOuz8UgDBLGEM8xg=aUGjaVoqkM_Zvxo2Re_g@mail.gmail.com> <CAHk-=wiG9xaVvBJXHqTxtop0=mW9KxPS9C54ED23p59VNEKdWg@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Sat, 5 Aug 2023 03:06:13 +0200
Message-ID: <CAGudoHFsxmiezZREyVkrPYBBij3u9SNaxLWipOOPy5S+5pJcZA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fork: lock VMAs of the parent process when forking
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        regressions@leemhuis.info, bagasdotme@gmail.com,
        jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        stable@vger.kernel.org
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

On 8/5/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Fri, 4 Aug 2023 at 16:25, Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> I know of these guys, I think they are excluded as is -- they go
>> through access_remote_vm, starting with:
>>         if (mmap_read_lock_killable(mm))
>>                 return 0;
>>
>> while dup_mmap already write locks the parent's mm.
>
> Oh, you're only worried about vma_start_write()?
>
> That's a non-issue. It doesn't take the lock normally, since it starts off
> with
>
>         if (__is_vma_write_locked(vma, &mm_lock_seq))
>                 return;
>
> which catches on the lock sequence number already being set.
>
> So no extra locking there.
>
> Well, technically there's extra locking because the code stupidly
> doesn't initialize new vma allocations to the right sequence number,
> but that was talked about here:
>
>
> https://lore.kernel.org/all/CAHk-=wiCrWAoEesBuoGoqqufvesicbGp3cX0LyKgEvsFaZNpDA@mail.gmail.com/
>
> and it's a separate issue.
>

I'm going to bet one beer this is the issue.

The patch I'm responding to only consists of adding the call to
vma_start_write and claims the 5% slowdown from it, while fixing
crashes if the forking process is multithreaded.

For the fix to work it has to lock something against the parent.

        VMA_ITERATOR(old_vmi, oldmm, 0);
[..]
        for_each_vma(old_vmi, mpnt) {
[..]
                vma_start_write(mpnt);

the added line locks an obj in the parent's vm space.

The problem you linked looks like pessimization for freshly allocated
vmas, but that's what is being operated on here.

-- 
Mateusz Guzik <mjguzik gmail.com>
