Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B9D80362B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjLDOOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjLDOOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:14:12 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98484B9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:14:18 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b894f5a7f3so2415440b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701699258; x=1702304058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0I6C4lHtAjdDOgBRB1tna7Hi6HkljA5Ej+x6ZNqkNO8=;
        b=QXqgZTLZsSBdiZY9hjaO+y9Q0UPPxjQOj+owZqyLMYKybejgDnJ22JkBgObuN2wlkZ
         /8P/GMLGWNDFydsTepyzH13nz17h+PVD6zuYIk2eDTKPyk9lGmcwmpfKeFH7p6rVWUwP
         2SUk9aF5Es8Or0Etv0FL+a58XU7n5ICzUK+FCMohd6pgfrSmTb7OLNjY3gtDMhpxovVh
         YsGxarRoqMVIAGFM8FUPz0miH0iA8OhZTwHNM9fKtW5gTiQOE1d+XFpf60IMhEII45tn
         XuD27OUNRZBktBYTpz3BopSRWtCgXJaRFdj++WBAx4xiYw19HQ6E9RnqIfZqrGFkjzFM
         E1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701699258; x=1702304058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0I6C4lHtAjdDOgBRB1tna7Hi6HkljA5Ej+x6ZNqkNO8=;
        b=PXTyCjyBgLA0Mpc6J5GVbJf7MUmm1WCRa8IaRzySWkEsudshN+7OEmSPj5uMz+5RV9
         DU6AzCCcgTD4DhTxniTFLbrNvrWli+uFBgeppKNIpxfOAUKfYK7tLQ8GzOCdaLI332hx
         2qlPZK6SKbbG1zzERjgQWCufXUssR8S6M5/6o+m7GyMrLje21z+VJBJZoswh7UJ4M3Qg
         X9I2rHtlSDRPj/D/ZE2R0FbmMZWeiw5VZE6BbNG62UYW7zTdu0Q4JIyWE1qoWJ++/IFl
         5H2aOJEmt5Y27Gau1DUSLyDhuvHJyz4OfaHoTyWMw5afy0NhwLamL9jRAHEhEt1hdv7k
         Aoqg==
X-Gm-Message-State: AOJu0YxWFA0DnZL6nDw79lYOMrnSMJJkcNK3aXyOyoSbJtJO6ndNx7JR
        awiFRazId1hO0c8DpvqMolszGVlYdD8LSt9vfq0=
X-Google-Smtp-Source: AGHT+IFEu8TprTdadCbPaDT3i4fWi2XekDqfyNrrQK6RXnb0qoLqCmgcb28e4hgbpi0Bnkuu5MH6XObjr5/U/0yDe2g=
X-Received: by 2002:a05:6870:d3cd:b0:1f9:fa57:f72a with SMTP id
 l13-20020a056870d3cd00b001f9fa57f72amr7540705oag.38.1701699256359; Mon, 04
 Dec 2023 06:14:16 -0800 (PST)
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
 <CADnq5_Oy6RMyJ52TbsxVjZ=0p=wYJHduE4X8B3DiYnqHYJUAvw@mail.gmail.com> <87edg3koka.fsf@vps.thesusis.net>
In-Reply-To: <87edg3koka.fsf@vps.thesusis.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 4 Dec 2023 09:14:04 -0500
Message-ID: <CADnq5_PtSV1C6Up78XX8ejExqaiM-wzHVFhCRtxboS1Y4cF-Ow@mail.gmail.com>
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

On Sun, Dec 3, 2023 at 3:40=E2=80=AFPM Phillip Susi <phill@thesusis.net> wr=
ote:
>
> Alex Deucher <alexdeucher@gmail.com> writes:
>
> > Phillip,
> >
> > Can you test this patch?  I was not able to repro the issue on the
> > navi2x card I had handy, but I think it should fix it.
>
> I pulled -rc4 and it still had the problem.  I applied this patch, and
> yes, it fixed it!
>

Great!  I'll include it this week.

Alex
