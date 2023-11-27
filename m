Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9F17FA023
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjK0M6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbjK0M6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:58:44 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB64AA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:58:49 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c27ee9c36bso3031003a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1701089928; x=1701694728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zb7LG4+VC86lAK3ACNOsqD4c+4Q3Zl+YX9v/JCc2Lsw=;
        b=ncFrNiSd6zzwoLe7jqogXnWo19X38R/PoeSJBL4uxYyCX4tLHFAlHjrCgIZYmXhLFg
         ADwLmLm1HE3L8lxph3EaNKpmZPSlnhiCaZBPuizUlOMCrz7QxyQ/NKJAKmQU29DgATqR
         JFvSz5TGW18Si6gghRhlM6rJD/4D0wbNfMV5Ohn2aQAiALhmo6pF9Ywjr3KW6dZ0DlQG
         waEkoMRO4IEREO0oyCu2tLfSVoy2V0oF8x29R0CIChkjvUriFe431DxITS/gTqkWZo+j
         m+szBx+k6dnbeLcd8mwbkj3fwlf6bdsCHFeOJDmHzXh1ZkhO016oGyVgf1E30cBAkoFc
         UuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089928; x=1701694728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zb7LG4+VC86lAK3ACNOsqD4c+4Q3Zl+YX9v/JCc2Lsw=;
        b=m60Iq933RINP6hgpr68ZwmzeRZLW7GWqbe4KFP5KoXyvfykCh+bswC1iBjEX1Ca7yw
         lmm6Ov3pJQnQt5V/a611SJM3GhxSSDLxEy7zqLuzHvDo9UfkNtuPQ5f7PtghXH3RBZGP
         lpn0dbLb86/6swuiDvD7OHSNpclZP9rSTH3jHdzy3DjB4hOe8MBFIHWPoqa/VVTa29lm
         NQxsf2tGI6kmJBMzeE/OB/I4/btRs5EK0cME33glOrlqnV2adrq6IQxxJvyQaS5i0ufY
         /ym8tUUrxFYPdniAEm1p41DVZBlWTkX7rD7adH06EB7kK9Bm7SLL2uN0ZNpjMrvTbaSQ
         pRpQ==
X-Gm-Message-State: AOJu0Yxx63n3a0s8msg0/E2GMgQuFlUrUt6LUbM9PUkOttlEfHJYh6Ny
        GL2owrqIVbl/vTDLFbPRC4XRaFZKNLtXTGe+RUA+3Q==
X-Google-Smtp-Source: AGHT+IED72gn7lrICwt9dspFALErw3zzL/Mo+GIDENL1lqLFyfYwPcVMIv337Xlw9EVnLjHJzGLwS8GX9uQZvPG71ps=
X-Received: by 2002:a17:90b:1a8d:b0:280:c9a1:861e with SMTP id
 ng13-20020a17090b1a8d00b00280c9a1861emr13211345pjb.13.1701089928629; Mon, 27
 Nov 2023 04:58:48 -0800 (PST)
MIME-Version: 1.0
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu> <20231127-process-dinginess-cea6dd652b99@wendy>
In-Reply-To: <20231127-process-dinginess-cea6dd652b99@wendy>
From:   =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date:   Mon, 27 Nov 2023 13:58:36 +0100
Message-ID: <CAEg0e7jjLCEL28exKqWBUAMSRj_M9bSBxmOM-1Bu-Fpfmd8hjQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] RISC-V: Add dynamic TSO support
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Daniel Lustig <dlustig@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 11:37=E2=80=AFAM Conor Dooley
<conor.dooley@microchip.com> wrote:
>
> Hi,
>
> On Fri, Nov 24, 2023 at 08:21:37AM +0100, Christoph Muellner wrote:
> > From: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> >
> > The upcoming RISC-V Ssdtso specification introduces a bit in the senvcf=
g
> > CSR to switch the memory consistency model at run-time from RVWMO to TS=
O
> > (and back). The active consistency model can therefore be switched on a
> > per-hart base and managed by the kernel on a per-process/thread base.
> >
> > This patch implements basic Ssdtso support and adds a prctl API on top
> > so that user-space processes can switch to a stronger memory consistenc=
y
> > model (than the kernel was written for) at run-time.
> >
> > I am not sure if other architectures support switching the memory
> > consistency model at run-time, but designing the prctl API in an
> > arch-independent way allows reusing it in the future.
> >
> > The patchset also comes with a short documentation of the prctl API.
> >
> > This series is based on the second draft of the Ssdtso specification
> > which was published recently on an RVI list:
> >   https://lists.riscv.org/g/tech-arch-review/message/183
> > Note, that the Ssdtso specification is in development state
> > (i.e., not frozen or even ratified) which is also the reason
> > why I marked the series as RFC.
> >
> > One aspect that is not covered in this patchset is virtualization.
> > It is planned to add virtualization support in a later version.
> > Hints/suggestions on how to implement this part are very much
> > appreciated.
> >
> > Christoph M=C3=BCllner (5):
>
> I know this is an RFC, but it could probably do with a bit more compile
> testing, as:
>
> >   RISC-V: Add basic Ssdtso support
>
> This patch doesn't build for rv64 allmodconfig
>
> >   RISC-V: Expose Ssdtso via hwprobe API
>
> This one seems to build fine
>
> >   uapi: prctl: Add new prctl call to set/get the memory consistency
> >     model
> >   RISC-V: Implement prctl call to set/get the memory consistency model
> >   RISC-V: selftests: Add DTSO tests
>
> These don't build for:
> rv32 defconfig
> rv64 allmodconfig
> rv64 nommu

Thanks for reporting this. You are absolutely right.
In my defense, this patchset was compile-tested and got some limited
run-time testing in QEMU.
But after that, I wrote the documentation, which triggered a renaming
of several function/macro names,
and these changes did not see adequate testing. I am sorry for that.

I've already fixed the patches (addressing the issues you have
reported, plus other small issues).
To not distract the ongoing discussion, I will not send an updated
patchset right now.
In case you are interested, you can find the latest changes (rebased
on upstream/master) here:
  https://github.com/cmuellner/linux/tree/ssdtso
I've also extended my local compile-test script to include all
mentioned configs.

In case you want to play a bit with these changes, you can also have a
look at the QEMU
patchset, which also got support for the prctl (which is not part of
the published mailpatch):
  https://github.com/cmuellner/qemu/tree/ssdtso
With these changes, you can run the kernel self-test binary in
user-mode emulation.

BR
Christoph
