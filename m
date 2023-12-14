Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C74A81368C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjLNQnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjLNQnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:43:13 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FFE128
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:43:16 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-28b0a265f92so692684a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702572196; x=1703176996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWHIEYa09hnCSRRLYxrxmRkCfuGY/Q51Trzc6SpnBLw=;
        b=yFuj6SdJhzHQiVDRC7YNgxaqoxUnrBjeV+16dPdpLgUtcLBdemEBdVnTDOPVAxnp0Y
         ALCJrqQ24A695tlJHWxa+HsguzzhxV0BXpi31XZ1E+FvQjIx1c8GRid1ypNgoPRn7HOo
         JcKMlt+q07qr96uHxdho/0jpc7fB4eXywI31cMgl8LRt9uFnJt8Xs0/3gWVCRfoIDgCH
         0Tht8BMAMNTXkO9/T1lGnSPd1t0R4U/G9kcE9nDof/lUU1HvKxUIYd2sr/YCfUypIuNf
         GStywy2QIlsFhGOdldRt/wc+NZZwMIJJXuGFLcEhWfmC5C7H7RmivXxlkNAx+NXpXPJb
         Qatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572196; x=1703176996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWHIEYa09hnCSRRLYxrxmRkCfuGY/Q51Trzc6SpnBLw=;
        b=xSUdsDX0WQ4NpSzWLp49POnsLTBrG7WI8cSHTg5y3z9cIiUxdBs6aXwbLgeN0EUsax
         OA71RHMsqLTD0S9nW4Xn39W7qxKk0vNhEQKKkDF+pAP6rdnU/VIFx33CCVplNDIBjqXW
         mbmGSYw4pzMCoFAR2ksCp5RxYcrbSNuhJYsLl1v8TpRpLtv+ku4N+9gGY1thdlBxMmbf
         kRQL2pCbFhI9fed/dMosM5wmwdygpWGBa52Gzs7Rsc3PyH0n8+p+V9RjwUsntzG3y4DD
         WJEy7+BzL7enYwDauF/wIH14BVK+q9i/GuFW2jsoDCxH/hs+kMrQnCbsw+8rGea61CVH
         34vA==
X-Gm-Message-State: AOJu0YxuONXmhl8UL753sh0TPArZtHTfww4X2tXffp2lvZYOHYgmRFIy
        67Ri3pzz4QNyBrXGO+Rg8ZShpkSy7PpOTygShT6D+A==
X-Google-Smtp-Source: AGHT+IE3sHyxROiMhjfefDzAoNruqBYfiJM6J3A7LkcGt1ZODtMjrMmf12UjnIx2lJL2ANOUXdxmTmRkKyRZD80Ekzk=
X-Received: by 2002:a17:90b:3594:b0:28a:df4b:46cb with SMTP id
 mm20-20020a17090b359400b0028adf4b46cbmr2249609pjb.35.1702572196038; Thu, 14
 Dec 2023 08:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
 <20231214105243.3707730-8-tudor.ambarus@linaro.org> <CAPLW+4mNjCbJ+VbKR66DFSkiXHyxdjgvwjN7azxjJQ6UxQikEw@mail.gmail.com>
 <f3d61c49-1a46-476c-b7a5-6cc6a06a33ed@linaro.org> <CAPLW+4=tyr8Pcoe6Wm0Wtmkk4udDpuAiOKy7+C+Fwa6mvt3VoQ@mail.gmail.com>
 <5de5cddd-2bab-4408-b31f-f48bef98f14c@linaro.org>
In-Reply-To: <5de5cddd-2bab-4408-b31f-f48bef98f14c@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 14 Dec 2023 10:43:04 -0600
Message-ID: <CAPLW+4n-S2jaVPUwKTFC_iabnDd_qDV=ZubMqhz-X9XiZzzJow@mail.gmail.com>
Subject: Re: [PATCH 07/13] clk: samsung: gs101: mark PERIC0 IP TOP gate clock
 as critical
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, andre.draszik@linaro.org,
        saravanak@google.com, willmcvicker@google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
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

On Thu, Dec 14, 2023 at 10:15=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linar=
o.org> wrote:
>
>
>
> On 12/14/23 16:09, Sam Protsenko wrote:
> > On Thu, Dec 14, 2023 at 10:01=E2=80=AFAM Tudor Ambarus <tudor.ambarus@l=
inaro.org> wrote:
> >>
> >>
> >>
> >> On 12/14/23 15:37, Sam Protsenko wrote:
> >>> On Thu, Dec 14, 2023 at 4:52=E2=80=AFAM Tudor Ambarus <tudor.ambarus@=
linaro.org> wrote:
> >>>>
> >>>> Testing USI8 I2C with an eeprom revealed that when the USI8 leaf clo=
ck
> >>>> is disabled it leads to the CMU_TOP PERIC0 IP gate clock disablement=
,
> >>>> which then makes the system hang. To prevent this, mark
> >>>> CLK_GOUT_CMU_PERIC0_IP as critical. Other clocks will be marked
> >>>> accordingly when tested.
> >>>>
> >>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> >>>> ---
> >>>>  drivers/clk/samsung/clk-gs101.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/c=
lk-gs101.c
> >>>> index 3d194520b05e..08d80fca9cd6 100644
> >>>> --- a/drivers/clk/samsung/clk-gs101.c
> >>>> +++ b/drivers/clk/samsung/clk-gs101.c
> >>>> @@ -1402,7 +1402,7 @@ static const struct samsung_gate_clock cmu_top=
_gate_clks[] __initconst =3D {
> >>>>              "mout_cmu_peric0_bus", CLK_CON_GAT_GATE_CLKCMU_PERIC0_B=
US,
> >>>>              21, 0, 0),
> >>>>         GATE(CLK_GOUT_CMU_PERIC0_IP, "gout_cmu_peric0_ip", "mout_cmu=
_peric0_ip",
> >>>> -            CLK_CON_GAT_GATE_CLKCMU_PERIC0_IP, 21, 0, 0),
> >>>> +            CLK_CON_GAT_GATE_CLKCMU_PERIC0_IP, 21, CLK_IS_CRITICAL,=
 0),
> >>>
> >>> This clock doesn't seem like a leaf clock. It's also not a bus clock.
> >>> Leaving it always running makes the whole PERIC0 CMU clocked, which
> >>> usually should be avoided. Is it possible that the system freezes
> >>> because some other clock (which depends on peric0_ip) gets disabled a=
s
> >>> a consequence of disabling peric0_ip? Maybe it's some leaf clock whic=
h
> >>> is not implemented yet in the clock driver? Just looks weird to me
> >>> that the system hangs because of CMU IP clock disablement. It's
> >>> usually something much more specific.
> >>
> >> The system hang happened when I tested USI8 in I2C configuration with =
an
> >> eeprom. After the eeprom is read the leaf gate clock that gets disable=
d
> >> is the one on PERIC0 (CLK_GOUT_PERIC0_CLK_PERIC0_USI8_USI_CLK). I assu=
me
> >> this leads to the CMU_TOP gate (CLK_CON_GAT_GATE_CLKCMU_PERIC0_IP)
> >> disablement which makes the system hang. Either marking the CMU_TOP ga=
te
> >> clock as critical (as I did in this patch) or marking the leaf PERIC0
> >> gate clock as critical, gets rid of the system hang. Did I choose wron=
g?
> >>
> >
> > Did you already implement 100% of clocks in CMU_PERIC0? If no, there
>
> yes.

Ok. Are there any other CMUs (perhaps not implemented yet) which
consume clocks from CMU_PERIC0, specifically PERIC0_IP clock or some
clocks derived from it? If so, is there a chance some particular leaf
clock in those CMUs actually renders the system frozen when disabled
as a consequence of disabling PERIC0_IP, and would explain better why
the freeze happens?

For now I think it's ok to have that CLK_IS_CRITICAL flag here,
because as you said you implemented all clocks in this CMU and neither
of those looks like a critical one. But I'd advice to add a TODO
comment saying it's probably a temporary solution before actual leaf
clock which leads to freeze is identified (which probably resides in
some other not implemented yet CMU).

>
> > is a chance some other leaf clock (which is not implemented yet in
> > your driver) gets disabled as a result of PERIC0_IP disablement, which
> > might actually lead to that hang you observe. Usually it's some
> > meaningful leaf clock, e.g. GIC or interconnect clocks. Please check
> > clk-exynos850.c driver for CLK_IS_CRITICAL and CLK_IGNORE_UNUSED flags
> > and the corresponding comments I left there, maybe it'll give you more
> > particular idea about what to look for. Yes, making the whole CMU
> > always running without understanding why (i.e. because of which
> > particular leaf clock) might not be the best way of handling this
>
> because of CLK_GOUT_PERIC0_CLK_PERIC0_USI8_USI_CLK

That's not a root cause here. And I think PERIC0_IP is neither.

>
> > issue. I might be mistaken, but at least please check if you
> > implemented all clocks for PERIC0 first and if making some meaningful
> > leaf clock critical makes more sense.
> >
>
> Thanks,
> ta
