Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42DC7B7297
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 22:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbjJCUfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjJCUfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:35:50 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBF6AB;
        Tue,  3 Oct 2023 13:35:47 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-534659061afso2292452a12.3;
        Tue, 03 Oct 2023 13:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696365345; x=1696970145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqdB+JUHcFiGktTAMBzkuM441kM6m0DdlaLG8beYiPI=;
        b=g9ctOq66oJCRGqrTObc/vmDlcYLgxodnOlStf+YDsazSVp8PGcQ7wNzCOO4PzEUQ1F
         GFFPlosdJsEv4WSt1UMzARs0LJaFbiZf8KCgspP+Bcctxsv2RVnTAjg0dDJ3UMjxALfI
         0eFTbvrYsLc9ZbnX3kl6D1Y4j3iiqs8Zsw4Urte6991nXiENzfRdm2o2HdYfhX/7VGE6
         s4kzc64WLY1l8UpBRfVFJh70NNGaiNF1Fb9lq/d339nd+Hi2NxS5IOq2xyEnc7IYCjmI
         2DLRiLZQKXvE6B4ca0WfClrgH/onRcpyBv/5p4MPBCJz6S+6rUseMYkVoKzl48ScmfmE
         82Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696365345; x=1696970145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqdB+JUHcFiGktTAMBzkuM441kM6m0DdlaLG8beYiPI=;
        b=NmWI70cLVzjtPY7LLGMPxxSJZ3BsTvO8kxXSp6Sp063SW7ygbdpq/RR9leLrxmTVvL
         sVPi2QNWLRD5H1Z9er7HNkDZhLEeXhr7il49Gv++2YT0x/ezXy2YOPlDEt1LT+h7bi8b
         vxlB7CqRtTsNjPZ5PP5/ugEslo9INP8mAUm2hEdim/Ay5cHmQX4bD7cBxGzjEam+/TAf
         xASWPKat/g6yteBqHJBKkWItSNd6T9hcZLE5Gql0b/FoyvTxMskFu0Ej6N9Kyv+8N+6K
         18tUAbTky9HOfciI6q2+CeF57VzoChjucwF6SwvDG6wyGzljgCV+vE1eXwoXglvPaDtX
         uhBw==
X-Gm-Message-State: AOJu0YzFYZzYFLNEqF+4fsPrdoMsyUfqWVYmIxfp/lnSAvuUnlOnlr4m
        xGpALfbHpFq6u+/0jVUT2pbKTEdXtB5ZOoejo9sndsnKwM8u0g==
X-Google-Smtp-Source: AGHT+IFtz3sRHIiHBp0ES9GvQG+rFCC7YNSRi0k8np6ylSpW+5DQTBzH7jeF5qdF+RpJKkYX0W/losyCF7NajUlo4Fw=
X-Received: by 2002:aa7:d503:0:b0:538:ae5:6138 with SMTP id
 y3-20020aa7d503000000b005380ae56138mr259035edq.34.1696365345398; Tue, 03 Oct
 2023 13:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-3-jagathjog1996@gmail.com> <20230924153055.0b3486f9@jic23-huawei>
 <CAM+2EuJBxj7P-ymu84u308g8LCemSEsYi_TSHYtaK9PyrhqrfA@mail.gmail.com>
 <5eb148b4-25eb-460d-9ec8-0a40bec1dc6f@gmail.com> <CAM+2EuJUGu4QUCdZ7d28RaLNipJRVuASP9wSzF14k=oBoC4e_Q@mail.gmail.com>
 <833fc809-b1d4-471e-afa3-68ded78b20f0@gmail.com>
In-Reply-To: <833fc809-b1d4-471e-afa3-68ded78b20f0@gmail.com>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Wed, 4 Oct 2023 02:05:33 +0530
Message-ID: <CAM+2EuKJwW8i9-1Y4v7ccaT3HUHJ9E79j7cPWqzbig_tcFWxSA@mail.gmail.com>
Subject: Re: [RFC 2/2] iio: imu: Add driver for BMI323 IMU
To:     Denis Benato <benato.denis96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis, Jonathan

On Sun, Oct 1, 2023 at 7:23=E2=80=AFPM Denis Benato <benato.denis96@gmail.c=
om> wrote:
>
> Hello Jagath,
>
> On 9/29/23 09:59, Jagath Jog J wrote:
> > Hi Denis,
> >
> > On Thu, Sep 28, 2023 at 2:55=E2=80=AFAM Denis Benato <benato.denis96@gm=
ail.com> wrote:
> >>
> >> Hello,
> >>
> >> Some devices (as my asus rog ally) have an ACPI node describing a BOSC=
0200 sensor. The IC being used in those devices is a  bmi323 but as a resul=
t of how the ACPI table reports that device, it is detected by the existing=
 kernel module and we have no way of differentiating until after the chip I=
D probe.
> >>
> >> The module loaded is bmc150-accel-i2c.c which currently doesn't suppor=
t the bmi323 and the loading of the module just fails at chip check.
> >
> > bmc150 driver supports multiple accelerometer sensors such as
> > bma222, bma280, bmi055 and all of them are having similar
> > register map, but the bmi323 register map is completely different
> > from bmc150.
>
> I apologize for the confusion.
>
> What I was trying to say is that to have the bmi323 working in those afor=
ementioned devices bmc150 will need to be modified: that is the probe funct=
ion that ends up being executed, fact that cannot be changed because it dep=
ends on the ACPI implementation shipped on those devices.
>
> Therefore I was asking about the best way of handing control to the new d=
river and how that should be organized: in my implementation the new bmi323=
 code was written inside the bmc150-accel-core.c and only shares sleep/susp=
end, probe and removal functions in addition to checking for the new chip p=
resence before checking for any bmc150 chip as that issues an i2c write, wh=
ile the check for the bmi323 only requires an i2c read.

Means you want to handle control to the standalone driver from bmc150.
Sorry, I didn't find any examples.

Important thing to handle is the bmi323 private structure and call required
exported functions from another driver.

Jonathan: Can you suggest any example wrapper drivers which handle that way=
?

>
> We also have done duplicate work as I have written a driver for that chip=
 myself, but it's not as good as yours because my hardware didn't come with=
 the IRQ pin connected and so I couldn't develop triggers and I only got th=
e i2c interface working.
>
> >
> >
> >>
> >> I have solved the problem by expanding the current bmc150-accel-i2c.c =
and bmc150-accel-core.c files to handle that IC in almost every part: gyros=
cope, accelerometer and temperature sensor.
> >>
> >> What is the best way of organizing code to have this module mainlined?=
 Is it correct leaving files called bmc150-accel-* even if it is managing a=
nother IC and and not just the accelerometer part anymore?
> >>
> >> TIA for your time.
> >>
> >> Best regards,
> >> Denis Benato
> >
> > Regards
> >
> > Jagath
>
> TIA for your time.
>
> Best regards,
> Denis Benato

Regards
Jagath
