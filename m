Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE18770C60
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 01:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjHDXZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 19:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHDXZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 19:25:50 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9614C2D;
        Fri,  4 Aug 2023 16:25:49 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a5a7e7cd61so1779197b6e.0;
        Fri, 04 Aug 2023 16:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691191549; x=1691796349;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ECpGsVgScrXWZOLp4MGlhJInQlqSJK5uh2ufnsxsdQ=;
        b=KN5ZYHb0WcW1urRTacMTcHcK1iJfsyKLuTL34dGK3epmEymYUfmkINYqz6aEbdMp+W
         zP3dEKtnz6JUtoqVZ1SnahfZCc5VVKFxGx/8h93CY/AxPITLLZOB6+xETO/sMYVRHySA
         TaMiFlxxDsv7HIJe00SxpQVu9Hn7GKNHwBxbOGtO1AXBFT+BEswiulBLKt6bP6OMt4wd
         12MBsdSJMyXvBwCe6D2ym2yxWn3SVy+r1EJz04/d6QPozmfj9tn6XaE+A3eVha3VW8Bw
         HsxwAfYJFsWa+JNVAHCA2y3A6DqjGG47Z5jkfZegfqiTqVqo78ji96xRiH5TdjogMFji
         HGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691191549; x=1691796349;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ECpGsVgScrXWZOLp4MGlhJInQlqSJK5uh2ufnsxsdQ=;
        b=j4hvMb+8XTDdn0Yk2A6LWb8uv3KTnRMQxOQ3dhdf+MxzCvZLTx9TB8CdKAyY42VGum
         t8/JdsMgTMs3fd6cKo1vMzKBYPpUi5jPgHoRZ6i9sZRvKk/dRoOuuC0ZMVjmnq8QyDGZ
         SOhfC4+Vqa9/ZBpwEOCaOkv+svcn4arWcmC1Cv3rf8hiK4PVNUf9O5XyPYPi50t9AqsC
         84dEpld5jQS4X5BzmrZa0S2P3lDJn9b+GuMsCwbVvJiS447m4Ph3cMAW2Lq9KiJlaqbu
         KkGByiUZGDdL7raxMc0weLWJYSvft76ASABFzDn4/XjpcrDRzo3atr/FU+/OjXGOJVBr
         fnnA==
X-Gm-Message-State: AOJu0YwVt51/Wx4urQ5w7Z+e9R2lqzYrAHN03/W4G3R/hsoQnzaCH8FU
        EQ+1tN3nbwoEABpQOHA7YTavG1Bg+bilcEYsOGE=
X-Google-Smtp-Source: AGHT+IGtBQglFMOFnETZZ/fmovN1PMvk23bCpNKojUYy5iXfJ0+vg0zUB8AJgZ4V2vFlc91Ap5FBtffJGXGc3wkjEE8=
X-Received: by 2002:a05:6808:3a7:b0:39c:7d50:ab86 with SMTP id
 n7-20020a05680803a700b0039c7d50ab86mr778649oie.29.1691191548939; Fri, 04 Aug
 2023 16:25:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7b87:0:b0:4f0:1250:dd51 with HTTP; Fri, 4 Aug 2023
 16:25:48 -0700 (PDT)
In-Reply-To: <CAHk-=wiy125k1dBmQFTGpHwiOqEyrD6xnd4xKWfe97H_HodgDA@mail.gmail.com>
References: <20230708191212.4147700-1-surenb@google.com> <20230708191212.4147700-3-surenb@google.com>
 <20230804214620.btgwhsszsd7rh6nf@f> <CAHk-=wiy125k1dBmQFTGpHwiOqEyrD6xnd4xKWfe97H_HodgDA@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Sat, 5 Aug 2023 01:25:48 +0200
Message-ID: <CAGudoHFsAU_BDCOuz8UgDBLGEM8xg=aUGjaVoqkM_Zvxo2Re_g@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Fri, 4 Aug 2023 at 14:46, Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> I don't see it mentioned in the discussion, so at a risk of ruffling
>> feathers or looking really bad I'm going to ask: is the locking of any
>> use if the forking process is single-threaded? T
>
> Sadly, we've always been able to access the mm from other processes,
> so the locking is - I think - unavoidable.
>
> And some of those "access from other processes" aren't even uncommon
> or special. It's things like "ps" etc, that do it just to see the
> process name and arguments.
>

I know of these guys, I think they are excluded as is -- they go
through access_remote_vm, starting with:
        if (mmap_read_lock_killable(mm))
                return 0;

while dup_mmap already write locks the parent's mm.

I don't see any surprise relocks of the semaphore.

Granted, should someone *bypass* this mechanism the above would be moot.

-- 
Mateusz Guzik <mjguzik gmail.com>
