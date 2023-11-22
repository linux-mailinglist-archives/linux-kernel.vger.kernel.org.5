Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547C97F4812
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344102AbjKVNpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343568AbjKVNpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:45:47 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDF110CE;
        Wed, 22 Nov 2023 05:45:44 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a00a9c6f283so373262466b.0;
        Wed, 22 Nov 2023 05:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700660742; x=1701265542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md1yJyViVJIk7bLbArcNZW7/RCjayNMC8N02jDNysO4=;
        b=ch4GalIXl3dk5A3Nde7K6ha0vSoqXiq8GlivBm64yEA5gkYwvhjHSmYSSrrUWBZQxN
         KWVIy0xl6mWTGPM1pBUGt9NXa6awo4YXdN2HCpScrWKHHxO9uEBqipL/ogEsfg3kEdNV
         mS+FhXnhEFbjfUgzbtlX0LRjfG4Lkv1DogZXJzMprC3KluT9fU0IEMhP+751iNwakl8l
         hBNuqErYdlpNf/v2kL85oEYWNWPPH0+Kb7pyjcslX/YkrcLwSV+i8LNnwECEC/JSHQDk
         t2SCE3UcceXuDAEI5+Gb5tOZ4iook7FON725REWvgMJQ5wHQPQZog4pw78Q/loR/6ukn
         hFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700660742; x=1701265542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=md1yJyViVJIk7bLbArcNZW7/RCjayNMC8N02jDNysO4=;
        b=DUD465gjirqgF2mAOfWEzd/WvNDInuBelu37aSPzVCyu6giOGO63LDGkX5qhYHyYnr
         6gigR2Kag/kYDsAFYywolB/s98uvv1pNMVdO9sUu0+GbAtnf/JqaO52iZZqsiS0hDiJ0
         7gVPwn4VFP+09g0BuF2tiveBS7X7RqipMUoTVv/6lqozKpudlmUy4ucmHinA0OLLGQw8
         aAl4Fro8AbsEAFpg0FTHmFa93yqAZdKMOTC8u0kCeoKcPSYxPyN32XaMBDQi6BEs+tW6
         ekt4KYYQGtlo4eUPq0ReKy8GGbfWOb0NAb6HzwlrBsZ1umH5Kc6ZK31Tt3utPpP0BFu1
         qvXA==
X-Gm-Message-State: AOJu0Yz5Nbk9/lLaPCDekrwERYwWhcMhlteHUy9088QdIN30wDpoXnE6
        ISCvM3T5F85gFH+MtH+UhPV3xGaT1CxMFIgMe28=
X-Google-Smtp-Source: AGHT+IEDJD80sNR88v2ZEvEEO8EO3ir1FQB2gTnGz7Y36msid1xY1pR45oM0Od6H7q9Cr5vTAN6bxG6Disb78sSlYj4=
X-Received: by 2002:a17:906:4e93:b0:9fc:ae47:5f0d with SMTP id
 v19-20020a1709064e9300b009fcae475f0dmr1464027eju.71.1700660742134; Wed, 22
 Nov 2023 05:45:42 -0800 (PST)
MIME-Version: 1.0
References: <20230825141226.13566-1-lukas.bulwahn@gmail.com>
 <c67bd324-cec0-4fe4-b3b1-fc1d1e4f2967@leemhuis.info> <20231112181036.GBZVEVHIIj/Oos1cx4@fat_crate.local>
 <0e9cbe6f-ac6c-47f2-b663-a22568799eca@leemhuis.info>
In-Reply-To: <0e9cbe6f-ac6c-47f2-b663-a22568799eca@leemhuis.info>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 22 Nov 2023 14:45:30 +0100
Message-ID: <CAKXUXMzo4cOW3p-XhODanMy5Lig7zHqnqbYJ5aXNvbeYLwfrrQ@mail.gmail.com>
Subject: Re: [regression] microcode files missing in initramfs imgages from
 dracut (was Re: [PATCH] x86: Clean up remaining references to CONFIG_MICROCODE_AMD)
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
        hpa@zytor.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
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

On Wed, Nov 22, 2023 at 10:15=E2=80=AFAM Linux regression tracking (Thorste=
n
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 12.11.23 19:10, Borislav Petkov wrote:
> > On Sun, Nov 12, 2023 at 04:03:32PM +0100, Linux regression tracking (Th=
orsten Leemhuis) wrote:
> >> That's because dracut until the recent commit
> >> https://github.com/dracutdevs/dracut/commit/6c80408c8644a0add1907b0593=
eb83f90d6247b1
> >> looked for CONFIG_MICROCODE_AMD and CONFIG_MICROCODE_INTEL in the conf=
ig
> >> file to decide what to include or not.
> >
> > They've been told a bunch of times already that grepping .config for
> > specific symbols is not how one should check whether one should add
> > microcode blobs to the initrd or not because Kconfig symbols are not an
> > ABI.
>
> Maybe, but you know how Linus sees things like this: what's considered
> an ABI/API or not is nearly[1] irrelevant - if a change breaks something
> that used to work then it needs to be fixed.
>
> [1] unless you fiddle with things obviously internal; not sure if this
> case would qualify for him, but somehow I doubt it -- but I might be
> wrong there.
>

Thorsten, I think you are wrong here in this case. We are talking
about the kernel build configuration options and their names and these
are certainly not stable and never have been.

Some indication to show that the rate of change we are generally
talking about without anyone considering this stable ABI/API:

You can run "find . -name Kconfig* | xargs grep -h -E '^(menu)config '
| sort | uniq" on each kernel release. Then diff those lists of
configs with increasing kernel config versions.

If this would be stable, then only config options should appear and
little should disappear, but that is not the case. And if something
disappears, it should relate to a driver/feature that was removed, but
that is also not always the case.

Here are some quick numbers:

v6.0 to v6.1: 43 removals
v6.1 to v6.2: 40 removals
v6.2 to v6.3: 350 removals
v6.3 to v6.4: 86 removals
v6.4 to v6.5: 73 removals
v6.5 to v6.6: 61 removals

* Removals can also be potentially a renaming.

So, these config names are certainly not stable ABI/API. We can
investigate a bit deeper on which changes are due to driver removals,
which due to config removal but making a feature default and which are
simply a config renaming, but in the past, hardly any kernel developer
has considered this interface to be a special stable ABI/API.

Further, to my knowledge looking at kernel discussions and the
repository, there are currently no tools out there that would assist
in updating a kernel build configuration from one version to the next.

So, we are talking about roughly more than 50 removals to kernel
config options every release, and now there was this one special case
in one release, where a tool incorrectly relies on this one config
option to be stable. That is not a regression of a stable ABI/API,
that is a misuse of an internal non-stable ABI/API.


Lukas
