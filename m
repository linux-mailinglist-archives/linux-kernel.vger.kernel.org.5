Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC0F7EABAA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjKNIev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjKNIet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:34:49 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CF0124;
        Tue, 14 Nov 2023 00:34:46 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9ac3b4f42cso5386720276.0;
        Tue, 14 Nov 2023 00:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699950886; x=1700555686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/E4Cf0M4V5F0WlgqnFgKCGSH1Y+g90bkSzK4WkmZ9Ok=;
        b=eTTYUYehjCFDtksxtp0GJb/YiGE0eIsoqdhe8UUyAih7ODisUvbJGxeG5GyZ0oM8u7
         7+anMXcEJd6y1l4F0JQJqpyF4F+ESTQqhOEBwfMFrxL5yp9sucwWgVQPvwet9lbB1FBh
         vNTgSc1+tnuPqtnqBgQeU6qd8aHToi8x1VhJkjRmHp6ctnzMjTwVwThq3/kuhCfJ9Vkx
         vIsoQIinXvN3lc8ggkZ4TpJ0KHByXm+t9XgitY+cRXAau3XSgVS/I98zvRJQ2xlPVmTC
         eLXzAS6/FRv6xcdZA5X9oEhMXlce/BXdb4Cdjv+nUCMp006PB1fdlQXPvBK7lEkFImvq
         L1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699950886; x=1700555686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/E4Cf0M4V5F0WlgqnFgKCGSH1Y+g90bkSzK4WkmZ9Ok=;
        b=V2IC3VxSegkjqy/3BCEstP6aQ3FxXUDDxruhFArHbZokhEVo+NFMSXCcVl2BbRfQ0E
         AgO0KI9Yvb7cxZyKjBO+IEVRpVq1O9iT1LSii6EzpBSq3SycR6hCpdBVVprxA+X2KVOg
         PWrieOP8SV4squzSyD81WUwUgmnZXqqb1RRnfftnd5RMDiyeT7wZu2tJGauGDhrYI+5q
         FW7gsDsD3ncOR0a8+vKgzuzslvrCplZyCXTGYBDYdJF9txK1Cj5kOi6Vyllhzs5USjVf
         SJ488UVjZxU3Xcowms70Ti+yJtmfUwosb1kCT9nWI88MQX3Qb4WBlxTTLZxjBedK7id8
         heuA==
X-Gm-Message-State: AOJu0YzGzjIs6bnriJqe3ZJoOxvjaj6KG6L1fg2o981lTAuh9R/NGMEs
        SrGkYPgjr6QJAJ67FUgm3B6KyOZJTxnUhPmIJw==
X-Google-Smtp-Source: AGHT+IEDBJRlQc4+CTKuE1ufc1L8ZN2XXLmwnBMuEexIlSb+dExGtYAsrsXOP1GvcH4zBDL/1flBYtp2Z61RhRPrbBU=
X-Received: by 2002:a25:b345:0:b0:daf:627f:9988 with SMTP id
 k5-20020a25b345000000b00daf627f9988mr1361915ybg.7.1699950885949; Tue, 14 Nov
 2023 00:34:45 -0800 (PST)
MIME-Version: 1.0
References: <CACkBjsbUytfJS1ns0pp=o=Lk5qbQ5weD4_f8bPFrW5oV0tCXZw@mail.gmail.com>
 <CABWLsev9g8UP_c3a=1qbuZUi20tGoUXoU07FPf-5FLvhOKOY+Q@mail.gmail.com> <CABWLsesED+S_XNnWJDvJnPV7D0K5U4y3VjGQ7EKeecnufw4xbQ@mail.gmail.com>
In-Reply-To: <CABWLsesED+S_XNnWJDvJnPV7D0K5U4y3VjGQ7EKeecnufw4xbQ@mail.gmail.com>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 14 Nov 2023 09:34:34 +0100
Message-ID: <CACkBjsbxO802EsBWUsGvkV8VPtsRLhRh2rHnGRuy_ziFXj=X0A@mail.gmail.com>
Subject: Re: bpf: incorrect stack_depth after var off stack access causes OOB
To:     Andrei Matei <andreimatei1@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 1:03=E2=80=AFAM Andrei Matei <andreimatei1@gmail.co=
m> wrote:
>
> I have sent https://lore.kernel.org/bpf/20231113235008.127238-1-andreimat=
ei1@gmail.com/T/#u
> as a fix.
>
> Hao, thanks again for the report. For my edification, how did you get
> the KASAN bug report with your repro / which tree exactly were you
> running against and with what config? I've run your repro program in
> the VM created by vmtest.sh, with an added CONFIG_KASAN=3Dy in the
> config, and I did not get the bug report in dmesg; I got nothing.
> However, if I change the variable offset bounds to be around 200 bytes
> instead of 12, then I do get a kernel panic because of a page fault.

I guess the key difference is that I do not use JIT (CONFIG_BPF_JIT=3Dn).
With KASAN, the interpreter is instrumented for memory access checking,
but JITed eBPF programs will not, that's why you need to increase the off
to trigger the page fault.

Here is my config: https://pastebin.com/raw/q170XGxd

Also, this bug can be exploited by users with CAP_PERFMON, and kernels
after v5.10.33 are all impacted. So we should CC stable kernel:

Cc: stable@vger.kernel.org
