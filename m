Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D777B5D16
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 00:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjJBWXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 18:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjJBWXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:23:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C1DC4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 15:23:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-406618d0991so2697505e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 15:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1696285390; x=1696890190; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fCiH9a5W/fqJ38SwmAjZfsGQXwRLcdeZgKgDR4wEc4=;
        b=WUPKUNl+oj8JAfd+eGEBBQak7B0dl5FAQ9HwTdpFHWa7P2Uqe6k7KuaSoo/QjoCzIX
         o95/k1RjXwR5N1Rhi7G6H+h2P4ClRdNeloGz2/LhiGQ3/SOOKoiSnPuNHBs3wchCaox7
         34ppdml2YbVLN65KxNvYniVa5zv35c/0XVm8/Y/yxr6rzt+F2DjdhZKP/P0nDVFMFJox
         a2GIkqZFNRdCsbSnq3SBBBAmMnT4gUPXrnbadozZGXZzISiGxgsO4QL0hvuDc8ay1Lfj
         Gsc7WZH69rsFURbdAnpSORJPxyBbAdGeYIPU3mQatSAW6QWq0MWq/RDfGkgkSiep6StF
         CFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696285390; x=1696890190;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fCiH9a5W/fqJ38SwmAjZfsGQXwRLcdeZgKgDR4wEc4=;
        b=EDfQRVsf5kA0f7o9H+tnGqeVptyvXrirl8Rpug08B0uwd2D1YoMRCmC1IM8YcDmhJ3
         FLInW8n6MHLmMnsBB+akaJ6MSwuil9OPeK3VsY0K7Q9OAmSOx1UJUH5cpR31AIIeWGvA
         NQfQYHtT3c2Ca1mIyW2/MKvfBHgaUDqKD53NTyO2cwNWzUxRw1fi/RKCn7izTiHZH/dE
         fuTd5bp/URFHSv5jxsCtqSeXhHz5bZz1RpReNeCvhsBvyqsaYaDiuHSh9VmrASbdQDQg
         PqDHW41NTDBlIDhGOnMrxAnFnOu8hH0RyTrJhBPDDsrVF23RSL5wxnyDNLXLetMWGb0S
         sHcA==
X-Gm-Message-State: AOJu0YyTPsfJ7nGiqY2ebpZL4tfhUwVlIOAGElv25vY2Cdl8DFFtIRyN
        WZdE52dVk3HAMmbGXp6VzUMg4w==
X-Google-Smtp-Source: AGHT+IF0+hsZ77J1FUzLRT2PMI9V2R5c1nXxGrMA9Nc9wPd3CzAgHdKCKNewknKvF/5TrzCPMoWkOA==
X-Received: by 2002:a05:600c:1c11:b0:406:592b:e5aa with SMTP id j17-20020a05600c1c1100b00406592be5aamr9328015wms.14.1696285389514;
        Mon, 02 Oct 2023 15:23:09 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id n7-20020adff087000000b0031c6e1ea4c7sm11760280wro.90.2023.10.02.15.23.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2023 15:23:09 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAP6exYLtQuyqMgG6jRAhizp-52ebu3OLNSXe8a8xvLALYFD3kA@mail.gmail.com>
Date:   Mon, 2 Oct 2023 23:22:58 +0100
Cc:     =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?utf-8?Q?Bj=C3=B6rn_Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Maslowski <cyrevolt@googlemail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF617BC9-0FE4-4468-8FF9-06BD8A8115E2@jrtc27.com>
References: <20230926150316.1129648-1-cleger@rivosinc.com>
 <20230930-patchy-curdle-ef5ee6e1a17c@spud>
 <8ce6cd97-6d63-4174-a290-40690c81e205@rivosinc.com>
 <20231002-spearman-doze-70cc026ac13e@spud>
 <693e6584-1e66-48c0-aa7c-61d9f88abd4c@rivosinc.com>
 <CAP6exYLtQuyqMgG6jRAhizp-52ebu3OLNSXe8a8xvLALYFD3kA@mail.gmail.com>
To:     ron minnich <rminnich@gmail.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Oct 2023, at 16:32, ron minnich <rminnich@gmail.com> wrote:
>=20
> This was a very interesting read. One other thought crossed my mind,
> which is that a RISC-V implementation might make the alignment
> delegation hard-wired to always delegate to S mode. I.e, the bit might
> be WARL and always 1. For what I'm doing, this would actually be
> pretty convenient. Just want to make sure this code can accommodate
> that -- wdyt?

Such an implementation would violate the spec:

  An implementation shall not have any bits of medeleg be read-only
  one, i.e., any synchronous trap that can be delegated must support not
  being delegated.

Supporting that is thus out of scope.

Jess

> We have found lots of value in our experiments with delegating
> alignment traps to Linux -- not least because they tend to locate
> problems in the kernel :-) -- we've found issues in module loading,
> early startup (there's a needed .align2 directive for sbi secondary
> startup, AFAICT) and the timing code for misaligned load/store
> handling.
>=20
> I don't know how you test this unaligned trap handling, but it might
> be worthwhile to work that out. You can test via oreboot and the
> visionfive2, save we have not figured out why SMP startup is going
> wrong, yet :-), so we're not as feature-complete as needed. But soon.
>=20
> Thanks!
>=20
> On Mon, Oct 2, 2023 at 5:19=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger =
<cleger@rivosinc.com> wrote:
>>=20
>>=20
>>=20
>> On 02/10/2023 12:49, Conor Dooley wrote:
>>> On Mon, Oct 02, 2023 at 09:40:04AM +0200, Cl=C3=A9ment L=C3=A9ger =
wrote:
>>>>=20
>>>>=20
>>>> On 30/09/2023 11:23, Conor Dooley wrote:
>>>>> On Tue, Sep 26, 2023 at 05:03:09PM +0200, Cl=C3=A9ment L=C3=A9ger =
wrote:
>>>>>> Since commit 61cadb9 ("Provide new description of misaligned =
load/store
>>>>>> behavior compatible with privileged architecture.") in the RISC-V =
ISA
>>>>>> manual, it is stated that misaligned load/store might not be =
supported.
>>>>>> However, the RISC-V kernel uABI describes that misaligned =
accesses are
>>>>>> supported. In order to support that, this series adds support for =
S-mode
>>>>>> handling of misaligned accesses as well support for =
prctl(PR_UNALIGN).
>>>>>>=20
>>>>>> Handling misaligned access in kernel allows for a finer grain =
control
>>>>>> of the misaligned accesses behavior, and thanks to the prctl =
call, can
>>>>>> allow disabling misaligned access emulation to generate SIGBUS. =
User
>>>>>> space can then optimize its software by removing such access =
based on
>>>>>> SIGBUS generation.
>>>>>>=20
>>>>>> Currently, this series is useful for people that uses a SBI that =
does
>>>>>> not handled misaligned traps. In a near future, this series will =
make
>>>>>> use a SBI extension [1] allowing to request delegation of the
>>>>>> misaligned load/store traps to the S-mode software. This =
extension has
>>>>>> been submitted for review to the riscv tech-prs group. An OpenSBI
>>>>>> implementation for this spec is available at [2].
>>>>>>=20
>>>>>> This series can be tested using the spike simulator [3] and an =
openSBI
>>>>>> version [4] which allows to always delegate misaligned load/store =
to
>>>>>> S-mode.
>>>>>=20
>>>>> Some patches in this series do not build for any configs, some are
>>>>> broken for clang builds and others are broken for nommu. Please =
try to> build test this more thoroughly before you submit the next =
version.
>>>>=20
>>>> Hi Conor,
>>>>=20
>>>> Thanks for the feedback, I'll check that.
>>>>=20
>>>>>=20
>>>>> Also, AIUI, this series should be marked RFC since the SBI =
extension
>>>>> this relies on has not been frozen.
>>>>=20
>>>> This series does not actually uses the SBI extension but provides a =
way
>>>> to detect if misaligned accesses are not handled by hardware nor by =
the
>>>> SBI. It has been reported by Ron & Daniel they they have a minimal =
SBI
>>>> implementation that does not handle misaligned accesses and that =
they
>>>> would like to make use of the PR_SET_UNALIGN feature. This is what =
this
>>>> series addresses (and thus does not depend on the mentioned SBI =
extension).
>>>=20
>>> Ah, I must have misread then. Apologies.
>>=20
>> No worries, maybe I should actually remove this from the cover letter =
to
>> avoid any confusion !
>>=20
>> Cl=C3=A9ment
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

