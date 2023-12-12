Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC5780EF65
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376919AbjLLOza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376947AbjLLOz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:55:28 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE13D5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:55:33 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1ef36a04931so4072232fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702392932; x=1702997732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FC/Vpfr7MIARIwnwGGWmXjjUlNgWi23Htq/xmbvsJCk=;
        b=RYUg6dECdrY1AhiwPnaDqtSRgtZ+3Oh6WngOnbdJepOPTj+9uOByxTVo+t7fod4Hn9
         091rsdOomHvQS7CV19zrTlIsO8kgHg/uBu5hRhYWNE8emgoyGYt8tyyjLtCCVUz4lSlp
         9fAkvwzTVVy31ZwwaX1jxkWylpo/CHdrmO2ulUqjMWZeqndKwmbbUJAyPLyIGh8dXruW
         U86U2wmxYbOi67lu+edQCY0IkOk6l4dkKCr26udoMkvolCKVUlhgYFMt/7u2skM3f87f
         AU3WqLFUlywYbuuxnzgykl0lTB1XcpJpnRvlF9B7gZKCu3Iq5b8rUALgTWgcUUxFtk60
         QH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702392932; x=1702997732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FC/Vpfr7MIARIwnwGGWmXjjUlNgWi23Htq/xmbvsJCk=;
        b=dUJ/WqGdtEWZzqQYmTBX/lHIdFFf/882pvDqcueXbb3r/G7dFa2e0VGbxg/mdyYUKU
         tBjToCXomWCB2WCignt6mYM5Dq/MbmY7nZtVLjmvV7o/6vmTXts4MyAFZa9lC0O7toJX
         WCBja3DXfJZuJdi2NTHlvL4wACFtzyiTgvZfCm/OyGlaqbV3P/Uglm0bn95Vb5pTu6JJ
         dSVu9X5KguEH7ZHNapFRda1yyQHSIfkQSt6p73pFgG89r7VgJahrDkI/8PzyUHnLOWyH
         b15xGB2etNmCeVnwjYMJJmeS1j+L40vQ/vE5tj+RtknaLhsjT6YqleGHVqveUXP0dFX/
         Ixiw==
X-Gm-Message-State: AOJu0Yx2SzcHvOVOJx/yYdbPqVFqV3f+x5+/BzNQHuS6J7zEhxECD3NS
        YCfg1vjF/GCzmJ3G5nARQGLAI5tM8yVPyoCAJeAONbs7
X-Google-Smtp-Source: AGHT+IHq+QzxCX8gQUM6S0hC7Fo7q1dTCZTgvw/J1vuRyfhGGu2MpPtuJGqJYnc/6KWnfR91d4qZpois0AOaWLPWIjw=
X-Received: by 2002:a05:6870:f155:b0:1fb:75a:c417 with SMTP id
 l21-20020a056870f15500b001fb075ac417mr5948435oac.64.1702392932689; Tue, 12
 Dec 2023 06:55:32 -0800 (PST)
MIME-Version: 1.0
References: <87edgv4x3i.fsf@vps.thesusis.net> <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com> <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com> <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
 <87jzq2ixtm.fsf@vps.thesusis.net> <CADnq5_Ou-MVVm0rdWDmDnJNLkWUayXzO26uCEtz3ucNa4Ghy2w@mail.gmail.com>
 <95fe9b5b-05ce-4462-9973-9aca306bc44f@gmail.com> <CADnq5_MYEWx=e1LBLeVs0UbR5_xEScjDyw_-75mLe8RAMnqh6g@mail.gmail.com>
 <CADnq5_OC=JFpGcN0oGbTF5xYEt4X3r0=jEY6hJ12W8CzYq1+cA@mail.gmail.com>
 <9595b8bf-e64d-4926-9263-97e18bcd7d05@gmail.com> <CADnq5_N6DF-huOzgaVygvS5N_j_oNUEC1aa4zRsZTzx8GOD_aw@mail.gmail.com>
 <CADnq5_PgMxoW=4iabtgeHydwye-6DvwvCyETdfBToEpuYWocmA@mail.gmail.com>
 <CADnq5_P0S7Jem0e4K6mG2+bboG8P56nELaGC1p4Pfx-8eV-BjQ@mail.gmail.com>
 <CADnq5_Oy6RMyJ52TbsxVjZ=0p=wYJHduE4X8B3DiYnqHYJUAvw@mail.gmail.com>
 <87edg3koka.fsf@vps.thesusis.net> <CADnq5_PtSV1C6Up78XX8ejExqaiM-wzHVFhCRtxboS1Y4cF-Ow@mail.gmail.com>
 <87y1e05me4.fsf@vps.thesusis.net> <87r0jsw9g3.fsf@vps.thesusis.net>
In-Reply-To: <87r0jsw9g3.fsf@vps.thesusis.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Dec 2023 09:55:21 -0500
Message-ID: <CADnq5_MYSCd32p2doPMN1_vcrUZvHMDPn83LU-0oVBS6fuRVuA@mail.gmail.com>
Subject: Re: Radeon regression in 6.6 kernel
To:     Phillip Susi <phill@thesusis.net>
Cc:     Luben Tuikov <ltuikov89@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-kernel@vger.kernel.org,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Danilo Krummrich <dakr@redhat.com>
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

On Mon, Dec 11, 2023 at 7:28=E2=80=AFPM Phillip Susi <phill@thesusis.net> w=
rote:
>
> Phillip Susi <phill@thesusis.net> writes:
>
> > And it works, but 6.7-rc5 does not, even though it includes that patch.
> > Here's the syslog from the attempt.  I'll start bisecting again.
>
> I checked out the patch that got merged upstream and it also fails.  I
> looked at the two commits, and I see what happened.  Your original patch
> MOVED the call to amdgpu_ttm_set_buffer_funcs_status().  The one that
> got merged into Linus' tree instead DUPLICATES the call.  Oops?
>

Yeah, I messed up the patch somehow when I applied it.  Fix up already
queued up to add the missing chunk.

Alex
