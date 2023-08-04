Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E10076FA87
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjHDGyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjHDGyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:54:47 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A61AE7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 23:54:46 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d18566dc0c1so2056639276.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 23:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691132085; x=1691736885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tl864Gq8vHCZkWE8SgIk2gfcLPUIoY0UDu4IrEIG2Dk=;
        b=kjlK7a/wOrqXSEtLt4ROFH8j/d7kFXj68rwUI1UyMGBSuaVEKDbBeIMNDng/2NVOO4
         rC2y2cjxmF/Y2XyFx0l4V3Gc1HEUaFmcWGId+CJaqQYHLjRbOnWzms28cQaLyT/MuA85
         R+9YdJS2LE0TbvasQ5ryYuxfhxOwDE/y3sAz0sPuVmekTqArfmCLcTHQuTbsIr9fhVjZ
         3x5iBmpuSWSs5eQfqS2covmwyOpb4stwxGu1wOKkfcozr8BY5nn46FUPCvqcZrFc05vd
         sXdjMVjxHo/LAutV3T+EZlSrcA+qQrRw46UqzhXE17e3cYny74H1ohx2xTwRdmiOjx0C
         DRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691132085; x=1691736885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tl864Gq8vHCZkWE8SgIk2gfcLPUIoY0UDu4IrEIG2Dk=;
        b=YjPGT/ToZzDoqr3CLwuZPUoL5eH9cnadyw8JOHSs/JPk5anvuzP6o3HqIMVcHGCiCg
         cBAngN6I1dsaWKR2Diqcq3zrbz+M7oFXy6oxWiDbc2Iz0A1O3aZvrbGopJJAFKNd2acw
         ybY0Y0gucb2NNROn/RH2962jEfJv40UH3yYUdq8liHbk/dLHPQcQRIGqPyCq+b9JkBbh
         Dj1rDmxShTzw+0dxq/ObBkg7nwxV3Ee8AF29JeiQS4lx+u9h1lfXIkwfhfDznVgMEWGq
         2Ow1dvVYDo0ivJnC35kxGS5FCoPnFEt0ulWViPxkW+E/5hOAC0wP4u9w7dPwG5vZJe2Y
         YqMA==
X-Gm-Message-State: AOJu0YyG/tJwgelUsmOnMa/3n8VXkCfzNqCaOfnYt7Lep2gGb93dxEqa
        bGK2XLPl1RY730w3wGo0kGZGemOXHDrXyRiRd7hk+g==
X-Google-Smtp-Source: AGHT+IEhQ+6ThvcSE8KTMZvx52SiuW4/p5gljqKGvysnVYcucKxlQcJrOxdrnH5kpTMGlkvNeQAaFzJ4yWelK3R15Kk=
X-Received: by 2002:a81:69c2:0:b0:586:24d1:338e with SMTP id
 e185-20020a8169c2000000b0058624d1338emr938772ywc.30.1691132085474; Thu, 03
 Aug 2023 23:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230803085734.340-1-nylon.chen@sifive.com> <20230803-vehicular-leggings-2830239f818a@wendy>
 <20230803-caretaker-voicing-e982f2334067@wendy> <CAHh=Yk9A3MP4Zgz53+s_ugvMtnv57igY=+Yccbp9Om9jBuxXqg@mail.gmail.com>
In-Reply-To: <CAHh=Yk9A3MP4Zgz53+s_ugvMtnv57igY=+Yccbp9Om9jBuxXqg@mail.gmail.com>
From:   Nylon Chen <nylon.chen@sifive.com>
Date:   Fri, 4 Aug 2023 14:54:33 +0800
Message-ID: <CAHh=Yk842gFpR1a3=KiB-Yb7T1Dqbg627MBK+hntjgMtd5z6-w@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] Change PWM-controlled LED pin active mode and algorithm
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, geert+renesas@glider.be,
        pavel@ucw.cz, vincent.chen@sifive.com,
        emil.renner.berthing@canonical.com, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor@kernel.org, zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Thank you for patiently giving me advice. I appreciate your help.

Not long ago, I said, "This patch needs to be accompanied by
modifications to the pwm_sifive_apply() function to make sense."

I recently reviewed the v3 version, and after discussing it with Emil,
there are several areas that require modification. I will provide the
necessary changes for each of them:

1. polarity check. (Suggestion from Uwe)
- if (state->polarity !=3D PWM_POLARITY_INVERSED)
+ if (state->polarity !=3D PWM_POLARITY_NORMAL)
2. avoid using old periodperiod, not state->period
- period =3D max(state->period, ddata->approx_period);
- frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
+ frac =3D DIV64_U64_ROUND_CLOSEST(num, period);
3. add a conditional check can be added in the code to set
ddata->approx_period to state->period when state->period is smaller
than ddata->approx_period
  if (state->period !=3D ddata->approx_period) {
  ...
+       if (state->period < ddata->approx_period) {
+               ddata->approx_period =3D state->period;
+       }
-       ddata->approx_period =3D state->period;
+       period =3D ddata->approx_period;

I will use 'unmatched' on my end to verify again. If there are any
other errors, feel free to point them out. Thank you.

Nylon Chen <nylon.chen@sifive.com> =E6=96=BC 2023=E5=B9=B48=E6=9C=884=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=889:42=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Conor,
>
> Conor Dooley <conor.dooley@microchip.com> =E6=96=BC 2023=E5=B9=B48=E6=9C=
=883=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:44=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > Hey Nylon,
> >
> > (I yoinked the reply to 1/1 to here, as it makes more sense in this
> > context)
> >
> > > On Thu, Aug 03, 2023 at 10:15:10AM +0100, Conor Dooley wrote:
> > > > On Thu, Aug 03, 2023 at 04:57:33PM +0800, Nylon Chen wrote:
> > > > > According to the circuit diagram of User LEDs - RGB described in =
themanual hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pd=
f[1].
> > > > >
> > > > > The behavior of PWM is acitve-high.
> > > > >
> > > > > Removed patches: 1
> > > > > New patches: (none)
> > > > >
> > > > > Links:
> > > > > - [0]:  https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-9=
5c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf
> > > > > - [1]:  https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8=
e9e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf
> > > > > - [2]:  https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b=
2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf
> > > > >
> > > > > Changed in v4:
> > > > >  - Remove previous updates to the PWM algorithm.
> > > >
> > > > Why? I don't recall the conclusion on the previous version being th=
at
> > > > that patch was not needed.
> > >
> > > I apologize for forgetting about this update earlier. Just now,
> > > I tried to pull rebase master and noticed that other developers seem
> > > to have made some fixes to the algorithm. Upon closer inspection, I
> > > found that they addressed the part we previously discussed with Emil
> > > and Uwe, such as "first pwm_apply_state."
> > >
> > > Therefore, my instinct tells me that they have already taken care of
> > > the issues we discussed before.
> >
> > I didn't see anything in linux-next that would solve this problem of
> > inversion. The last meaningful change is:
> >         commit 334c7b13d38321e47d1a51dba0bef9f4c403ec75
> >         Author:     Emil Renner Berthing <emil.renner.berthing@canonica=
l.com>
> >         AuthorDate: Wed Nov 9 12:37:24 2022 +0100
> >         Commit:     Thierry Reding <thierry.reding@gmail.com>
> >         CommitDate: Mon Jan 30 16:42:45 2023 +0100
> >
> >             pwm: sifive: Always let the first pwm_apply_state succeed
> >
> > which predates your v3 by quite a bit.
> >
> > > I will review the conflicting parts in the pwm-sifive.c code in my v4
> > > version once again to ensure there are no omissions. If I find any, I
> > > will submit v5 accordingly.
> >
> > And if this patch is okay in isolation, please reply here explaining
> > which commit fixed the algorithm, so that I can pick it up.
> This patch needs to be accompanied by modifications to the
> pwm_sifive_apply() function to make sense.
>
> I will double-check and review the previous discussions to ensure
> that. Thank you for your response.
> >
> > Thanks,
> > Conor.
