Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529D776A271
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjGaVHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGaVHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:07:48 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6850C188
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:07:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso46059285e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1690837661; x=1691442461;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNCGPjrbiEcyOtFfnoUVJfAnHPG+PuJqCkOivI0dKrA=;
        b=FXyIWqpqhN+jTLM7VoB9X8KH9YGhO3BdVRbPbL+PqDUSp4+sviIuBIY/Rvv02m/PBA
         OnULbqTAvH7W4XDTR6e8EQa0mMDiOhc4hPLf94ek9tER+nUJ74XdGiM7Hgjlhwp5TGsK
         BHCfbC1lvxYVlSsXlfSDvTe2mgW/GDyVERsPc0MUkS7KSQvhSG0+WvVDNp02prlogtz3
         U6NjH3bUOIHxcNto+k5TNole3bbMs0gx5RIibAPmBjwg/8GwthgOZzOPFo63b4htdzXM
         lZJtxm13vuKhLuqzyzJC8ldXvCiFLon4KJY1ATFOEgtSl3IGVU3+3Z9vPHPWtu0i0gae
         bjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690837661; x=1691442461;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNCGPjrbiEcyOtFfnoUVJfAnHPG+PuJqCkOivI0dKrA=;
        b=kcu7jP4KQlG659drmlTtUwzWxW1VyAraOBtkmx0MorngeXlG3iqfmDOKvouVc2cRvi
         c6hTD5slJ4bew7+lQaZzy08p7t6e3VSuEM5iHq4edUKzoR0EbJmt/K+HhpvAIS1RAEZJ
         zr49K/0CDCz0UN75swoMRvjQ5m1Tjfg0cnF1i7OZz4u6pFEBrJ7Be3rkPqBbzuKI1KKf
         wOiJs2GfbhbCGcspzUB2kHb78ENtQHvogfMNOitAuCx7JRplBHNYKtoh4SxxUdrhNE0S
         KBL4x+iOrHxHobHOYyMNk84zBRoS4oh4FWPz8V6peBlBB7GXNeqwQTMFloum+GvnGxaf
         sugw==
X-Gm-Message-State: ABy/qLZ6+RtJHnnS+rKauJ3sOFoW6BV8bRWXQxAOOXIFlrjLEVuuS8o9
        zcMgn6TWYsWw06BrGFKGswjxMQ==
X-Google-Smtp-Source: APBJJlGHTwVNWd//PZQ9JNGaGWYFnzIoYEDoehkWWJ7bscA0fSlZcXrSVnZcugVxt0+DshWg2nS0QA==
X-Received: by 2002:a05:600c:2213:b0:3fe:2102:8083 with SMTP id z19-20020a05600c221300b003fe21028083mr741960wml.26.1690837660761;
        Mon, 31 Jul 2023 14:07:40 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id k17-20020adfe8d1000000b003143867d2ebsm14090234wrn.63.2023.07.31.14.07.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Jul 2023 14:07:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v4 09/10] tools: lib: perf: Implement riscv mmap support
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <ZMgP6hhD/k7QNQ3t@casper.infradead.org>
Date:   Mon, 31 Jul 2023 22:07:28 +0100
Cc:     Ian Rogers <irogers@google.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Brendan Sweeney <brs@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?utf-8?Q?R=C3=A9mi_Denis-Courmont?= <remi@remlab.net>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Atish Patra <atishp@rivosinc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A8F40EA-0322-4E52-B806-AE93B5D7CFAE@jrtc27.com>
References: <20230727141428.962286-1-alexghiti@rivosinc.com>
 <20230727141428.962286-10-alexghiti@rivosinc.com>
 <CAP-5=fU5XYXrVnRUidpwjV2LiTsdebfidL43_Qo4Z7TBxMsVGA@mail.gmail.com>
 <CAHVXubgVAe1WsiZx5Ay+3KPK4u24k_vsnTwFFmBeVsHrGXwhfw@mail.gmail.com>
 <CAHVXubj80rQRShuDS09BeTrfR6nux0A68EMWLbeat8fd_Y3YdA@mail.gmail.com>
 <CAP-5=fWwzuGZ6a6Z38ndsb7gw7_uwS0a2VGXx08hMeiK8eZ91w@mail.gmail.com>
 <CAHVXubjhM9C1fw_Us=8+RuSJbW0pacFAk9gp7j2=BtMUPy_Byw@mail.gmail.com>
 <CAP-5=fUbiaVwSAhTbymyhdUPcVAXHiQZZexAOnrqid0LsPmfpw@mail.gmail.com>
 <ZMgP6hhD/k7QNQ3t@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jul 2023, at 20:47, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Mon, Jul 31, 2023 at 09:46:07AM -0700, Ian Rogers wrote:
>> On Mon, Jul 31, 2023 at 9:06=E2=80=AFAM Alexandre Ghiti =
<alexghiti@rivosinc.com> wrote:
>>> I have just had the answer internally (thanks to @Brendan Sweeney):
>>> csr modifications can alter how the memory is accessed (satp which
>>> changes the address space, sum which allows/disallows userspace
>>> access...), so we need the memory barrier to make sure the compiler
>>> does not reorder the memory accesses.
>>=20
>> The conditions you mention shouldn't apply here though? Even if you
>> add a memory barrier for the compiler what is stopping the hardware
>> reordering loads and stores? If it absolutely has to be there then a
>> comment something like "There is a bug is riscv where the csrr
>> instruction can clobber memory breaking future reads and some how =
this
>> constraint fixes it by ... ".
>=20
> If the hardware doesn't know that writing to a csr can change how =
memory
> accesses are done and reorders memory accesses around that csr write,
> you've got a really broken piece of hardware on your hands ...
>=20
> I know nothing about risc-v, and maybe the definition says that you =
need
> to put a memory barrier before and/or after it in the instruction =
stream,
> but on all hardware I'm familiar with, writing to a CSR is an =
implicitly
> serialising operation.

satp has some special rules due to the interaction with TLBs. Enabling
/ disabling translation by toggling between Bare and non-Bare modes
doesn=E2=80=99t require any kind of fence, nor does changing the ASID =
(if not
recycling), but any other changes to satp (changing between
Sv39/Sv48/Sv57 or changing the page table base address) do require
fences (not really sure why to be honest, maybe something about having
separate kernel and user page tables?..). =C2=A75.2.1 Supervisor
Memory-Management Fence Instruction of the privileged spec (the one =
I=E2=80=99m
looking at is version 20211203 but dated October 4, 2022) details this.

Jess

