Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F5D80E62A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjLLIcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjLLIcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:32:13 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E0ED5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:32:19 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67ab16c38caso35791496d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702369939; x=1702974739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4kqMN+HbgK8h0LRfiST0/gaIQ4yUhlUvwCL2KbU+eI=;
        b=ohaMR0vso/xbPTodlA9davmFnr6Wk8qwVFrDd3oymXW1n0MjDY+dLUIx6j3mTwKq15
         6quMuRTWo8Rkgnv63ObkHSRfVuFpOCnF2VVmk+Hfg647kW1rYBf52yUNbw12fTb7fAiI
         C1LY2Wc0r+B60Parv06z9G9IyptP9l7q+29+wCJjMKsUKQ6Scy/F21uOXzuVcvT86SdT
         fKnc44KtKdXJ7BIs5m4E939lphbz/bC8Gj1nl5JXoP+gh+hyttBasQtAZ8DY0Lx4xdCA
         PcsuI1xRX4fs+zqt+FKo9CU8DqC365fTbDgHOUUPr9LI8Xn1jNq1LPAmYnv/KYfu8GVn
         GEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702369939; x=1702974739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4kqMN+HbgK8h0LRfiST0/gaIQ4yUhlUvwCL2KbU+eI=;
        b=wY9Sexlb4lC5cqTluaxy3jtdogmvaP23cBm8gRjdj6A9PQXZiRWT3MDAfnhDy3P8Gv
         xk7o/Wxn/XzFvocE0EGQ86DwqnC57Deo+N8akjiEjmkvuyXUNmVNwczZMOJMWrtfi4D4
         40V3yLLCD+GOEkLhmDAPlYd7ETJaf7Talqh2jSAWqFJ96yh71FMeghIW/5DfDvjTDUcU
         KMu/QvJmPvXMNmYxWschZ4+tx4JfzppDI0h/6k4/LwN6bCq9cfzT1M1vvyMEJZ+JhNc7
         NMjdLUJL/CN5GlPlKFk/NC1mVnAVpquLPOp2wRJLMPXrrIZD9y5mfQy1uYzEECPU/GvO
         uICw==
X-Gm-Message-State: AOJu0YzBep3Kffa1/NFPSSp92CxToaoysmGivQr4cCm/R3Nfl3DaOMW3
        quhmwwGPthUFZPDl8zrxsMHiWiFwyN9nKF+LWOiHhA==
X-Google-Smtp-Source: AGHT+IG0V6b2w6UWHUlW9pxYWTaS0uDQUzxhZQ4B06wFrRKsghNDJX6XvOe1qtLzaxB+JBeOLMSozUSB2UxByYZ/7u8=
X-Received: by 2002:a0c:be89:0:b0:67a:a721:7850 with SMTP id
 n9-20020a0cbe89000000b0067aa7217850mr5392942qvi.117.1702369938818; Tue, 12
 Dec 2023 00:32:18 -0800 (PST)
MIME-Version: 1.0
References: <20231211104855.558096-1-vincent.guittot@linaro.org> <CAJZ5v0i37gGqt=oGC4BxJ4hT5pxhAdL7dPxGf7w3D8THqwAOwQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0i37gGqt=oGC4BxJ4hT5pxhAdL7dPxGf7w3D8THqwAOwQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 12 Dec 2023 09:32:06 +0100
Message-ID: <CAKfTPtDXLDpGChy7UXVsV75NHK1OPGHaGYf5G663HWnau4kAHg@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] consolidate and cleanup CPU capacity
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org,
        lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org,
        beata.michalska@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 at 20:52, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Dec 11, 2023 at 11:49=E2=80=AFAM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:

[..]

> >
> > Vincent Guittot (7):
> >   topology: Add a new arch_scale_freq_reference
> >   cpufreq: Use the fixed and coherent frequency for scaling capacity
> >   cpufreq/schedutil: Use a fixed reference frequency
> >   energy_model: Use a fixed reference frequency
> >   cpufreq/cppc: Move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}
> >   cpufreq/cppc: Set the frequency used for computing the capacity
> >   arm64/amu: Use capacity_ref_freq to set AMU ratio
>
> This series touches multiple places, but mostly schedutil, cpufreq and
> the EM, so please let me know if you want me to pick it up.

This serie has been rebased on top of tip/ched/core to fix a conflict
with another change already queued in kernel/sched/cpufreq_schedutil.c
