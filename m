Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8405C7AAE81
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjIVJoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjIVJoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:44:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31381A4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:44:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c136ee106so238266266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695375844; x=1695980644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdRKYfkU2V6gOP1l0rl+gg/UKXzRcAR814PV9mfsZtg=;
        b=WxxeXc2+bUNQhb7b5kY1qmO9qTOIfjvGmebVyEYCVbDIEqzHj0/lEepeKkAwrGe1s4
         IrbP/2T/Nj2zBzZ7ugNveyeVxAQdu7D277NtjFtK2o3lWCWsukNZF6efnHMxJ66tBF8u
         nClw12vhYogjgi59VW5IyrT7ieL6Q3Wqalv02BX3HUFQBqCUgYeXPSRXdre+XZbC+mYP
         ZWdSsXq4oFUTwq/rIFMlqY7mAs8sdQ6y/z/9wI9ZhFXi9CRm5ybth1V+P63bT04kgR1V
         UELqLqoxLkbO44dkNBYIScrmnsxBdYloZwlMfFxtcqzFeNOMPb6Q1pVQU23PdFumBq2h
         nXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695375844; x=1695980644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdRKYfkU2V6gOP1l0rl+gg/UKXzRcAR814PV9mfsZtg=;
        b=hwicVvv50kQyqpr/Gae7IaBmiQCEPQUzgF79Er0kH2jgg3lV2Rju2NNPu1A+yx4P5j
         vWhu/RYXO7B27rzKyEsytpBSsQxq19oZ4ydcxBrGjCUCH4RtOmH9GS1xD6BFEiABGaTZ
         z+t1s3y799S6uSpOHotHc1OeTnpu/+JgW3/66iXCssLF8KQLOrqU0+WmJvFpQsjX+Ukj
         U+0rrRgH1XTjTcr4lfyU57cdhytVrMgeHOrUzilTF5edCQqpgqyC4XwUzCjtdqBMT5kR
         ozwPHPXRU0my3JhWCRgglWuvAjSoWEEJ+RS8aUSYgP+5Fxoe/MBMmYVw9nAKUHNF1UVb
         65Iw==
X-Gm-Message-State: AOJu0YzD3H4R6oDZpRD1qWNYQiZsbcY0EYk6o+anIPSkEBZNMPqzj1Tm
        KbL8R77EU9d9PFi4Z662a4fTCXylkDaPa8Kb2KFT7A==
X-Google-Smtp-Source: AGHT+IGzTDFs3N1XlqmSyonD0tr7m5R1VUvlIn3pnPNhs48aCfG9TawffgF5nbOhhiKcAhIFDyQ4MZdo5LcAry49Zos=
X-Received: by 2002:a17:906:304b:b0:9a1:af6f:e373 with SMTP id
 d11-20020a170906304b00b009a1af6fe373mr7142302ejd.42.1695375844005; Fri, 22
 Sep 2023 02:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230919024943.3088916-1-tylor_yang@himax.corp-partner.google.com>
 <20230919024943.3088916-2-tylor_yang@himax.corp-partner.google.com>
 <20230919-70b2f1e368a8face73468dfa@fedora> <CAGD2q_anfBP78jck6AbMNtgAggjOgaB3P6dkmq9tONHP45adFA@mail.gmail.com>
 <20230919-cc4646dbfb953bd34e05658c@fedora> <CAGD2q_bkTpvXiomWb_yerNjQfMVKOctYgBqF_RBSo_jYqyyyxw@mail.gmail.com>
 <20230922-unclothed-bottom-5531329f9724@spud>
In-Reply-To: <20230922-unclothed-bottom-5531329f9724@spud>
From:   yang tylor <tylor_yang@himax.corp-partner.google.com>
Date:   Fri, 22 Sep 2023 17:43:54 +0800
Message-ID: <CAGD2q_YsFdDVhE4JCmQSGMWOdpe_yzG8-CdWYPXtjeZsManvgQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: input: Introduce Himax HID-over-SPI device
To:     Conor Dooley <conor@kernel.org>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        poyuan_chang@himax.corp-partner.google.com, hbarnor@chromium.org,
        "jingyliang@chromium.org" <jingyliang@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 5:22=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, Sep 22, 2023 at 03:56:25PM +0800, yang tylor wrote:
> > On Tue, Sep 19, 2023 at 7:09=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > > On Tue, Sep 19, 2023 at 05:31:29PM +0800, yang tylor wrote:
>
> > > > The behavior of "himax,boot_time_fw_upgrade" seems not stable and
> > > > should be removed. "himax,fw_in_flash", I use the kernel config for
> > > > user to select.
> > >
> > > That seems like a bad idea, we want to be able to build one kernel th=
at
> > > works for all hardware at the same time.
> > >
> > I see, so I should take that back?
> > I'll explain more about it.
>
> Are there particular ICs where the firmware would always be in flash and
> others where it would never be? Or is this a choice made by the board or
> system designer?
>
Most cases it's about the system designer's decision. But some ICs may be f=
orced
to use flash because of its architecture(multiple IC inside, need to
load firmware to
multiple IC's sram by master IC). But if there is no limitation on
this part, most system
designers will prefer flashless.

> Thanks,
> Conor.

Thanks,
Tylor
