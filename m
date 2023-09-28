Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B4B7B1FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjI1Ool (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjI1Ooj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:44:39 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAD31A1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:44:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-502f29ed596so5719e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695912275; x=1696517075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BFwIpXTwL/lUKsUPWcI8rCYf21e0USndOV3VkIfXzr4=;
        b=4aQV6YeY6iROW554n7rXB5howK8VsvKRNWX8a3DNmBIYMPkbBacwGWbnQob50OxIPN
         snU2FUQ/wdeFDsL4rDUwnllZDQOasLaGkntz5J5tGQ117b5b2RUsVjhC5MkCLKyq+blv
         HxRJsgB7cUxb7K80XelNxlktBfEtOg8KpweSQ5XMRRCQ4VqNff4rw0PsMxN8F/YO2zA/
         x2SkKBE5lHVqfOJ97KFYJenZ4uMHX+kr0Ovxdrfj2CK3vX0WzrbDxJXK44B5mMOSQvEE
         qYsnlWUG0FmvWfgfAorDxSohC8+WSWUsneaCdYuWW5ov7u6r1sWj+pVx/h7rN18O92e/
         3kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695912275; x=1696517075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFwIpXTwL/lUKsUPWcI8rCYf21e0USndOV3VkIfXzr4=;
        b=tQFPKMiGh/HOFxH8tffrvgKoLaxwcETkxBKL0oJxK87V5LtDsnEGJOzIJRDBG/ybBt
         VHS/8+atpBsoDEdICvnwwztkeEFob99tosd07UMYQBws0onZMeX2QYOt3wb61uCSK93w
         jOp2aVNoNI3aAK+7d3pVkIjG/usdEQIv3fBcMSBnuqX0zIpGVxn+Emv9FAtFUAHPpCh4
         bjPAeeqRYcdNKaQQZ0vAH5pzM1cdkq/7raeoxyPhmJ+Nf5aYrirsLGxJgAWUOBwyAJt8
         Lk1owD1jeSmX74QQytAsIivsc31cyQcy93Drv86gb0SzuvHIw3vqT1A2hCiR9fCRCpx6
         VKdw==
X-Gm-Message-State: AOJu0YyphqeCDafG1ZMScUIPQ86rZ1Pjan7Lu1R8WDK7CCioFssFDaFu
        y8CSAolHzQ2s5JQZ09pYpQB5ou5bfuTCbiw3WuP85Q==
X-Google-Smtp-Source: AGHT+IF+k5c+rX4zUNgLUDd2nRwl2MXqWoD/9z4V0hFhg8SGKLIhAegXLUkZVGYDQSttL/WplGoCXnRj0bwajDSqRps=
X-Received: by 2002:ac2:47f2:0:b0:502:a55e:fec0 with SMTP id
 b18-20020ac247f2000000b00502a55efec0mr247781lfp.6.1695912274999; Thu, 28 Sep
 2023 07:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <2c421e36-a749-7dc3-3562-7a8cf256df3c@efficios.com>
 <20230926205215.472650-1-dvyukov@google.com> <CACT4Y+beLh1qnHF9bxhMUcva8KyuvZs7Mg_31SGK5xSoR=3m1A@mail.gmail.com>
 <875y3wp6au.fsf@oldenburg.str.redhat.com> <CACT4Y+aVY+KPmBXYDBpA+JmLHvk=o5bt9d4tV5L41e813e0SVw@mail.gmail.com>
 <87bkdmznl6.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87bkdmznl6.fsf@oldenburg.str.redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Sep 2023 07:44:21 -0700
Message-ID: <CACT4Y+Y4S7yicthk6ziFh_M53W3D_tbWFnLjcsT+szzLy4ZmYA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
To:     Florian Weimer <fweimer@redhat.com>
Cc:     mathieu.desnoyers@efficios.com, David.Laight@aculab.com,
        alexander@mihalicyn.com, andrealmeid@igalia.com,
        boqun.feng@gmail.com, brauner@kernel.org, carlos@redhat.com,
        ckennelly@google.com, corbet@lwn.net, dave@stgolabs.net,
        dvhart@infradead.org, goldstein.w.n@gmail.com, hpa@zytor.com,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com, mingo@redhat.com,
        paulmck@kernel.org, peterz@infradead.org, pjt@google.com,
        posk@posk.io, rostedt@goodmis.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sept 2023 at 01:52, Florian Weimer <fweimer@redhat.com> wrote:
>
> * Dmitry Vyukov:
>
> > On Tue, 26 Sept 2023 at 21:51, Florian Weimer <fweimer@redhat.com> wrote:
> >>
> >> * Dmitry Vyukov:
> >>
> >> > In reality it's a bit more involved since the field is actually 8
> >> > bytes and only partially overlaps with rseq.cpu_id_start (it's an
> >> > 8-byte pointer with high 4 bytes overlap rseq.cpu_id_start):
> >> >
> >> > https://github.com/google/tcmalloc/blob/229908285e216cca8b844c1781bf16b838128d1b/tcmalloc/internal/percpu.h#L101-L165
> >>
> >> This does not compose with other rseq users, as noted in the sources:
> >>
> >>   // Note: this makes __rseq_abi.cpu_id_start unusable for its original purpose.
> >>
> >> For a core library such a malloc replacement, that is a very bad trap.
> >
> > I agree. I wouldn't do this if there were other options. That's why I
> > am looking for official kernel support for this.
> > If we would have a separate 8 bytes that are overwritten with 0 when a
> > thread is descheduled, that would be perfect.
>
> That only solves part of the problem because these fields would still
> have to be locked to tcmalloc.  I think you'd need a rescheduling
> counter, then every library could keep their reference values in
> library-private thread-local storage.

This unfortunatly won't work for tcmalloc.
This data is accessed on the very hot path of malloc/free. We need a
ready to use pointer in TLS, which is reset by the kernel to 0 (or
some user-space specified value). Doing to separate loads for counters
in different cache lines would be too expensive.

It may be possible to make several libraries use this feature  with an
array of notifications (see rseq_desched_notif_t in my previous
email).
