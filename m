Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75107B8D8D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243856AbjJDTmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243845AbjJDTmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:42:49 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B54A9;
        Wed,  4 Oct 2023 12:42:46 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7741c2fae49so13041285a.0;
        Wed, 04 Oct 2023 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696448565; x=1697053365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNEUrx2f0EOsYSNLwljjtMrsuJmbZYcwoRJZYPUoB3Y=;
        b=dGYWCUvNp/T8+HspqGVG2u1DZEYcsHJ6xn0hkJDUL4IM8UtFA1tm9PQVNEqP0mEfk3
         KgY9foXPEUGUDvQBTBee/TS0mlUiBxicEtqaB00ex1jQci0P1S2x9Vtkegm4gHXlHGy7
         w1U0vlQxcV5hv7DHZGjQ4SUSdhGb6uzWaggdXJEFIrd7yHEuukD2DmOZDzr2sspBR1bn
         0kSDC9cnj3rxxAuZFO1wqTxQW3PBNSQLKTI8iNmE7X5J48pmfj6uonrkMgYr7UVghGhy
         6oxwqckiQMiFnLgh4clASzjHM1d9c/lDzndLZuW127gnY7ha8skaJR0W/nWAH3T9KVAv
         2BDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696448565; x=1697053365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNEUrx2f0EOsYSNLwljjtMrsuJmbZYcwoRJZYPUoB3Y=;
        b=p12KmS8D1GS0CSiDcBuaJQWbhAfr5VOqNidVB0oLh/tTnNZCBet0KrNtjnjZTrHA0S
         QlQnyl1kEtdoWj8vSb55VmPaCnjWRIwIHBeMMSspbwFQS8+T/XfTztMMrTPZgKyDUrgf
         sluAmM/ikT60tsImARELPRWMuUA0JV9wSYWTSma6it7H+uupJHs94vOcmCuwchrx8cln
         xtOm0zkDXGHp57tov2ql3o/coZsQv/PnhN1FlAc3WmGOqCP3FrfI33FgKCO47vTFSkp+
         IAUUR5p50gBWuajhZqY8e2/VHVNdv6lj3ofSF1MMLCxUZaxClI1EnwCxcUgoikVo8NCL
         5/Kw==
X-Gm-Message-State: AOJu0Yxt5zbpZt0CvU7BvP7D/ltwV7353WxHhYU+QouxJFTb/3wio0CR
        zPwAyD04tir4Bxew/oDr2gSWF5y7OL620U4pMdQ6rWO9PXo=
X-Google-Smtp-Source: AGHT+IHzq0mBsVSOM/oReFyc7rW719H1KDBi3mMkvT3/axT9y1WEUjEQ4JUkJ//VnSO1fK16h3VjChV+UUtPths+0ok=
X-Received: by 2002:a0c:aa08:0:b0:658:2037:718c with SMTP id
 d8-20020a0caa08000000b006582037718cmr2796522qvb.40.1696448565340; Wed, 04 Oct
 2023 12:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230926190818.931951-1-andriy.shevchenko@linux.intel.com>
 <76d1e643-9b81-4c23-8f46-73fe59913600@kernel.org> <CAHp75VdKF+QfSsUwVSrSEng_xY_2ZW_0t0kBuXYPPcBi3_6LxQ@mail.gmail.com>
 <cac56745-f611-48c2-bb1b-e86a3694fa59@kernel.org>
In-Reply-To: <cac56745-f611-48c2-bb1b-e86a3694fa59@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Oct 2023 22:42:08 +0300
Message-ID: <CAHp75VeNG3cE5XmnhPyVQmR4Ppfk7CarSahU8-5Kpgg7TwLMjg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: denverton: Enable platform device in the
 absence of ACPI enumeration
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 4:20=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
> On 04/10/2023 15:09, Andy Shevchenko wrote:
> > On Wed, Oct 4, 2023 at 11:18=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >> On 26/09/2023 21:08, Andy Shevchenko wrote:

...

> >>> +MODULE_ALIAS("platform:denverton-pinctrl");
> >>
> >> Why do you need the alias? It's the same as ID table. You most likely
> >> miss MODULE_DEVICE_TABLE() or your table is just wrong.
> >
> > This is cargo cult from pinctrl-broxton.c. If we want to fix, we need
> > to fix both.
> > Care to send patches?
>
> I don't understand how some other file affects this. Why do you exactly
> need module alias here? Which use-case does not work without it (after
> adding proper MODULE_DEVICE_TABLE())?

We try to keep these drivers uniform. So, if something should be done
differently, it should be done for all affected drivers.
Since patch is applied, now we have two drivers to improve.

--=20
With Best Regards,
Andy Shevchenko
