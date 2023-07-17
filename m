Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9101B755D74
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjGQHvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjGQHvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:51:11 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A35C7;
        Mon, 17 Jul 2023 00:51:10 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b6f943383eso59439911fa.2;
        Mon, 17 Jul 2023 00:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689580269; x=1692172269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdvmJmDWWDsKPwBUXibJSiHawWBtjbP4ynK0j2yvrUI=;
        b=p9xAGXz4bX8T8QhVwHGm42SbYjno3i0HBw64iH4AkHt0H8p+VQeWmO4s4jRzxJgOjT
         hdNxxVKhdA/NyTBAgE4V09Z5sKb5JVijH062XUVy7zTKa8wyB9TSJjSEfbLKo628ai3H
         X29+DUNUqmU9Gs9nQ18urKOy8AfHVwnJuQqXNexAmejHEkU7k52QySDbQp2mYULgw3Wp
         oZp3SDx5dewaJJ1g3iq9IDpd5jcEKNZNV0iyf5omIVcCxXz7CrUnX+KGOgRstoIC8s5M
         EYh58jsbr6Nct9r5T3dcg+fwHlIe4R0MGYafCVgMecn2MMiiFX2BPLFw3N1Yo4i6cDpF
         xrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689580269; x=1692172269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdvmJmDWWDsKPwBUXibJSiHawWBtjbP4ynK0j2yvrUI=;
        b=hFU8KV9cIDgMYF4dlch6Rvg2IBbfTSdA4IS0RVxESUBr6UwWnnb1eX4mbbGJO3Apsj
         KOW81/kQARcz1xivkEJCKuE0IyKYROIr+ZwUhlNEYJz8wlpvkO5mB+tU77tRTmV3/VB7
         1XFtoDTl3y7vwv5otIYvo9j/s+4V+ByZ49aUs3c2BZRMjPF/UTMSOV72GO0PFwHY8+53
         6c1AWvtrMRmW5+2QrMCpuz4QfRGrIf8a0yQb94gC85Q2HENNdoTMOV89uotm7iFheXw6
         0qBu3qsSrAvmt2Vz0i0QbpLlwnuiS1pmcdo+RK7Lcp2KqbiF+D/Pw1FmruIBa3jirqqP
         FXMA==
X-Gm-Message-State: ABy/qLZw4Y9Wak7ydwaGpDmwtApmK/wumRE0IduoZ0zQKMJMxrcojuG/
        w/V5sDgfvepEVXD2uF5NjdBguqkLarQAFtzUf/Q=
X-Google-Smtp-Source: APBJJlG6zusNiSKLB741ID5TTlAleRJE0hv83e4VccVX9+/pxOuTxEXak5WBgVFaUgK5N7AIv7J1MI9eLrYmc7JatFg=
X-Received: by 2002:a2e:9c02:0:b0:2b4:83c3:d285 with SMTP id
 s2-20020a2e9c02000000b002b483c3d285mr8330250lji.38.1689580268474; Mon, 17 Jul
 2023 00:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230626085811.3192402-1-puranjay12@gmail.com>
 <7e05efe1-0af0-1896-6f6f-dcb02ed8ca27@iogearbox.net> <ZKMCFtlfJA1LfGNJ@FVFF77S0Q05N>
In-Reply-To: <ZKMCFtlfJA1LfGNJ@FVFF77S0Q05N>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Mon, 17 Jul 2023 09:50:56 +0200
Message-ID: <CANk7y0gTXPBj5U-vFK0cEvVe83tP1FqyD=MuLXT_amWO=EssOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/3] bpf, arm64: use BPF prog pack allocator
 in BPF JIT
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        catalin.marinas@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Jul 3, 2023 at 7:15=E2=80=AFPM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Mon, Jul 03, 2023 at 06:40:21PM +0200, Daniel Borkmann wrote:
> > Hi Mark,
>
> Hi Daniel,
>
> > On 6/26/23 10:58 AM, Puranjay Mohan wrote:
> > > BPF programs currently consume a page each on ARM64. For systems with=
 many BPF
> > > programs, this adds significant pressure to instruction TLB. High iTL=
B pressure
> > > usually causes slow down for the whole system.
> > >
> > > Song Liu introduced the BPF prog pack allocator[1] to mitigate the ab=
ove issue.
> > > It packs multiple BPF programs into a single huge page. It is current=
ly only
> > > enabled for the x86_64 BPF JIT.
> > >
> > > This patch series enables the BPF prog pack allocator for the ARM64 B=
PF JIT.
>
> > If you get a chance to take another look at the v4 changes from Puranja=
y and
> > in case they look good to you reply with an Ack, that would be great.
>
> Sure -- this is on my queue of things to look at; it might just take me a=
 few
> days to get the time to give this a proper look.
>
> Thanks,
> Mark.

I am eagerly looking forward to your feedback on this series.

Thanks,
Puranjay
