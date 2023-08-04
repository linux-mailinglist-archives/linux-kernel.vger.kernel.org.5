Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5280676F70F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 03:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjHDBmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 21:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjHDBmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 21:42:20 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0853423F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 18:42:18 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5861116fd74so17889587b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 18:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691113338; x=1691718138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giD5crJvVgFXxEOjUQ9Yq0Y5c2PK/y9XDLcfiurNQEY=;
        b=bbPLdps+zGZvnWfC0ij+NMQEfOt2gNinAPJJZiO8Yzi1j5Ys7cz6KVf+cUn2GQlk0B
         Eu7JkLy7WinuqqUb1Y3C4Ixg1DqX0pjHxLsthYxkM6N9hS/+u2Hav/Ox+44DG7ZkUGMR
         x+C0nTaQtLMMnAMMQHlPvDdDdd6DDiuaNljvwRktma/vRkilHtbuMHq/qiNstSGMEWD3
         1DxfBKwQSWt47850VXbktJMzOFBicXid6NjUyeplXK0+JMPJwGIRu5s1PFzzwPGwNuoo
         oD2DUYJabV+jVXI7kZnoxVQxfJdIOfUN2VvkXtiFYuXvmbgwqV+aO/1qhRJqLu3hs0ih
         TEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691113338; x=1691718138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giD5crJvVgFXxEOjUQ9Yq0Y5c2PK/y9XDLcfiurNQEY=;
        b=TbZeqloE+gI03QPS3f0CsIyR8dpWWXVYVKojf9IWO+SIx2Ikhfz3B3ha2c9ClGWnub
         yQx6wzyabQuErLHf92Hj5odO2yXU1Um445u8tyKO++b1a69dhmlFukybDLBOdJ4uAoKK
         YCXtNNQ3IziOFpZxZHXVzob+st2fWQmy5n0KLjOXgSh+TzDQSi8Osxfoa8wnp3iGKy0z
         P9EsYZ6kQKWmnQgW73WxJTmdv+aXJXYGAQut71GDW6khO3XVJWABSI5Qde0gPmuZ5ajx
         oxC9PSA6l5dHw/EJ1BeUxKWPkhloJ4Aq2WUFz11tr7+wN4wm9P5D8emWJMMsOCl3KvPE
         290w==
X-Gm-Message-State: AOJu0YweEVrPfyxh7iyPR89llvOmKzygeVDjYKTOzzgPxi/beimuMYPc
        PCiZ+JMIusf7XFJToByVRs+b3yfBnafkq+bMmbERkw==
X-Google-Smtp-Source: AGHT+IE2GOuOWOrI3eLUWlcZE1w35uJr5Ss1GfYBoSJYqAQUdRHIocBAQZMyVMKMIgPWxo+ZI3IaojEWNQmnAmBj/Sw=
X-Received: by 2002:a81:a545:0:b0:577:3eaa:8d97 with SMTP id
 v5-20020a81a545000000b005773eaa8d97mr281414ywg.17.1691113338123; Thu, 03 Aug
 2023 18:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230803085734.340-1-nylon.chen@sifive.com> <20230803-vehicular-leggings-2830239f818a@wendy>
 <20230803-caretaker-voicing-e982f2334067@wendy>
In-Reply-To: <20230803-caretaker-voicing-e982f2334067@wendy>
From:   Nylon Chen <nylon.chen@sifive.com>
Date:   Fri, 4 Aug 2023 09:42:06 +0800
Message-ID: <CAHh=Yk9A3MP4Zgz53+s_ugvMtnv57igY=+Yccbp9Om9jBuxXqg@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Conor Dooley <conor.dooley@microchip.com> =E6=96=BC 2023=E5=B9=B48=E6=9C=88=
3=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:44=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hey Nylon,
>
> (I yoinked the reply to 1/1 to here, as it makes more sense in this
> context)
>
> > On Thu, Aug 03, 2023 at 10:15:10AM +0100, Conor Dooley wrote:
> > > On Thu, Aug 03, 2023 at 04:57:33PM +0800, Nylon Chen wrote:
> > > > According to the circuit diagram of User LEDs - RGB described in th=
emanual hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf[=
1].
> > > >
> > > > The behavior of PWM is acitve-high.
> > > >
> > > > Removed patches: 1
> > > > New patches: (none)
> > > >
> > > > Links:
> > > > - [0]:  https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c=
8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf
> > > > - [1]:  https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9=
e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf
> > > > - [2]:  https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d=
8-86ed8b16acba_fu740-c000-manual-v1p6.pdf
> > > >
> > > > Changed in v4:
> > > >  - Remove previous updates to the PWM algorithm.
> > >
> > > Why? I don't recall the conclusion on the previous version being that
> > > that patch was not needed.
> >
> > I apologize for forgetting about this update earlier. Just now,
> > I tried to pull rebase master and noticed that other developers seem
> > to have made some fixes to the algorithm. Upon closer inspection, I
> > found that they addressed the part we previously discussed with Emil
> > and Uwe, such as "first pwm_apply_state."
> >
> > Therefore, my instinct tells me that they have already taken care of
> > the issues we discussed before.
>
> I didn't see anything in linux-next that would solve this problem of
> inversion. The last meaningful change is:
>         commit 334c7b13d38321e47d1a51dba0bef9f4c403ec75
>         Author:     Emil Renner Berthing <emil.renner.berthing@canonical.=
com>
>         AuthorDate: Wed Nov 9 12:37:24 2022 +0100
>         Commit:     Thierry Reding <thierry.reding@gmail.com>
>         CommitDate: Mon Jan 30 16:42:45 2023 +0100
>
>             pwm: sifive: Always let the first pwm_apply_state succeed
>
> which predates your v3 by quite a bit.
>
> > I will review the conflicting parts in the pwm-sifive.c code in my v4
> > version once again to ensure there are no omissions. If I find any, I
> > will submit v5 accordingly.
>
> And if this patch is okay in isolation, please reply here explaining
> which commit fixed the algorithm, so that I can pick it up.
This patch needs to be accompanied by modifications to the
pwm_sifive_apply() function to make sense.

I will double-check and review the previous discussions to ensure
that. Thank you for your response.
>
> Thanks,
> Conor.
