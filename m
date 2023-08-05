Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1876E770CF1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 03:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjHEBRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 21:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjHEBRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 21:17:01 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60A84EDE;
        Fri,  4 Aug 2023 18:17:00 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bc8d1878a0so2306303a34.1;
        Fri, 04 Aug 2023 18:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691198220; x=1691803020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cu168Y9vRpg+vzxEgSTGxY5n1ZLC+DuEViAjXzgPHZs=;
        b=folnjqF0aKRuew+xhfxHFYWs8LU+t5rP5KIRDLS0LazdBGhH9vtd1rk3BObzT3m5/y
         ukLp+VvYZQ4Ov8BDfr5g28AkAWB4g/hxW1Ssb8KRkKEt5RbkmTW2rc739qTXAxeDDDUE
         iIwn+0jXiPiqotQdwWEEf4v2EV8llX8EjhKSrtIZFTH7mwFarOlyk1wE1w1aDt0GwCX9
         2i9+2hZ2zwdOB7u07/U9V1zz19XN4xpjHrLB6dRkyuWahGPwMFFO19gkHFqsD51e7KcF
         SGCnklBW6xXIGZNAIl9Y7eHS6bVtNiEuidNQcV2Z29dq9T8Xtl8zifCjWsz1/ZOz282N
         Y2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691198220; x=1691803020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu168Y9vRpg+vzxEgSTGxY5n1ZLC+DuEViAjXzgPHZs=;
        b=iz8RKmMZF8DB0jbMi7s1duK8dzESL69dnlbi1fInYj+yAfW00wX8YAJfzcvc9DtocB
         +705fpAQ3Nk6/b/QEL6myodj97BMti1T/npXlML1J1US8tvyetBovNGvduZMLpjyLfh2
         QPPTzoMzoOHCsuJyOa2CJ+7pxCSE/mTIrf4mrdV0k5/9ZzQxlXZhpsApyU3ZOCjE0RNr
         S1NGXxsr/XH6pJsb8ASOAEssvKfahEY2CyVXYQBfdD15zAxTRyIg1lL1ivOVI0huA0+1
         4m4ykVzqCWSuY8v04NXi1SOmk+pbquXmRvlR5rN6DegsYNLoCMk9anHTdCaRtdRs64/n
         7xOA==
X-Gm-Message-State: AOJu0YxpN8rvPwt1V2Wc4S6Q0WwCwgRk5yQPJUzZo4XsBLBlmdIsgDUh
        Ww/P/B7EzRlG8FHfEz2gbKtjEdMDtAEOcmIgcDY=
X-Google-Smtp-Source: AGHT+IEuQ/dvOW7eFSBM63FzAr7WHgJtR9IpCyPZws0vFNx4oFHhozb1cWWML9qeqWJlkUR7TgqFe1XMIHdejPAlQbA=
X-Received: by 2002:a05:6870:ecac:b0:1b7:2edd:df6d with SMTP id
 eo44-20020a056870ecac00b001b72edddf6dmr3872658oab.10.1691198219991; Fri, 04
 Aug 2023 18:16:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7b87:0:b0:4f0:1250:dd51 with HTTP; Fri, 4 Aug 2023
 18:16:59 -0700 (PDT)
In-Reply-To: <CAJuCfpHYBqULvwNELO3Gkc0bkKDV7VJxMjvBru4zaAz4WKQNhw@mail.gmail.com>
References: <20230708191212.4147700-1-surenb@google.com> <20230708191212.4147700-3-surenb@google.com>
 <20230804214620.btgwhsszsd7rh6nf@f> <CAHk-=wiy125k1dBmQFTGpHwiOqEyrD6xnd4xKWfe97H_HodgDA@mail.gmail.com>
 <CAGudoHFsAU_BDCOuz8UgDBLGEM8xg=aUGjaVoqkM_Zvxo2Re_g@mail.gmail.com>
 <CAHk-=wiG9xaVvBJXHqTxtop0=mW9KxPS9C54ED23p59VNEKdWg@mail.gmail.com>
 <CAJuCfpGWGsh2BRgwcJ7oVHnqZfrtiesvhzomK0ZmxE_KK=R7FA@mail.gmail.com>
 <CAJuCfpG6BBP+fjV9oyBx3SNiKhiafPzM9vV9bx_goO2aZzAptg@mail.gmail.com>
 <CAGudoHFrDG6-u-XXEmQoPS2CJ2Wpo4ETwhXc2R=jy78RSYw-Zg@mail.gmail.com> <CAJuCfpHYBqULvwNELO3Gkc0bkKDV7VJxMjvBru4zaAz4WKQNhw@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Sat, 5 Aug 2023 03:16:59 +0200
Message-ID: <CAGudoHGm2hbjSG-2kJevF=xGpz=4Sd0m5CjVO8Ntsahqz5NcGA@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/23, Suren Baghdasaryan <surenb@google.com> wrote:
> On Fri, Aug 4, 2023 at 5:49=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>> However, the other users (that I know of ) go through the mmap
>> semaphore to mess with anything which means they will wait for
>> dup_mmap to finish (or do their work first). I would be surprised if
>> there were any cases which don't take the semaphore, given that it was
>> a requirement prior to the vma patchset (unless you patched some to no
>> longer need it?). I would guess worst case the semaphore can be added
>> if missing.
>
> No, the only mmap_lock read-lock that is affected is during the page
> fault, which is expected.
>

I have difficulty parsing your statement.

I am saying that any 3rd parties which can trigger page faults already
read lock mmap_lock or can be made to do it (and I don't know any case
which does not already, but I'm not willing to spend time poking
around to make sure). One can consider 3rd parties as not a problem,
modulo the audit.

Past that there does is no known source of trouble? In my original
e-mail I was worried about processes up the chain in ancestry, perhaps
some of the state is shared(?) and the locking at hand neuters any
problems. I'm guessing this is not necessary.

Bottom line though it looks like this will work fine?

That said, I'm not going to submit a patch I can't confidently defend.
As I did not dig into any of the VMA code and can't be arsed to audit
all places which mess with "foreign" mm, I'm definitely not submitting
this myself. You are most welcome to write your own variant at your
leisure. :)

--=20
Mateusz Guzik <mjguzik gmail.com>
