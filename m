Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE347D2CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjJWI1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjJWI1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:27:31 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89682188
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:27:29 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7ac4c3666so29819467b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698049648; x=1698654448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZOFQ0M9LgikeEj2rkmCDSHNE1BhU9zXckel0uG4DB4=;
        b=M1sH6teBF5ovungRCquHWkw/YDlESHlQmnHjVVoBPlN75vp9DFByTsQJeBfKfHOsZ4
         L/JwJ4Hz+DD2oe+TBnihj61lS30kg9ozGmyDJeFG9H3/wW8MoX5HHG7ldHRHi4yjeUM2
         UO9gqKv+1pWhq8r42d7waqLp1NKT5uUdIG1OZUyGNwzCVmCWtz9WvC94McR+dODgpqWl
         rkJdJNhgWdMMUWgnL5+EdomjE8+cGGxk1HGQU3rv3LAdLIX58kArHBNCfrlKZxeIa56+
         jaiGlMzPkBrbdmMIfL/evnUVaKpyvOvnt7spM/HYQwAq6fEL1lgVS7iDIGNq6cYJqYUG
         Qv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049648; x=1698654448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZOFQ0M9LgikeEj2rkmCDSHNE1BhU9zXckel0uG4DB4=;
        b=fM+NXu6wUccC1knVdg6G7KrUb5xD2R/A6Oc+GFhHzuPhDlh2+5fpVXXbcPeZR1ALaA
         DibbWRi081eaUksV6nqqBeqLn8N1IA+BeinMso09qCOLVi2lMsohuZ3zD9bH0dOqieVj
         /pZsL6Ws3w//Bct1+FwOT0i+5RC8Acr9A1jQ+slqhjwT4n6QLlSLeSlgt3ybhcdmO5bM
         FCeLa1LkgNOp4s7dcwS+ywKv6MIBknzG24XYukJSbJAE5UiLC0YgLj1p0Nut1yuSJmBA
         ss27GMdFY39/Mu//rquat04HT1e5MDes90KbPs6NmN8fpVGILg+VX+y7AxTQH/5z5hzV
         DHEQ==
X-Gm-Message-State: AOJu0YzRhfiriikHNQEnofx4pWHpVwQ+Zn4c1YHzMEV0PXkfSew7SCSH
        aPx/BKxU1p6CNicEQp77L1v1dsfWbGi8FtYa8gWDGA==
X-Google-Smtp-Source: AGHT+IGSavD/b+qLnxLyBKBAb/sJuaSpIHsaO9sHOD3ZetzmZkYjrXXXn+jJIOcoXv+71ys7FgOIacmNZkJIWD7KUpA=
X-Received: by 2002:a81:a0d7:0:b0:59b:d3cd:ffb6 with SMTP id
 x206-20020a81a0d7000000b0059bd3cdffb6mr8677462ywg.33.1698049648757; Mon, 23
 Oct 2023 01:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231013145935.220945-1-krzysztof.kozlowski@linaro.org>
 <CACRpkdZUSkr2MLB870Y5O2Qxvbnz++XUKMm+BXG1yx9vrOEvwA@mail.gmail.com> <8f608e3c-a282-4df2-abcd-8e38efc35843@linaro.org>
In-Reply-To: <8f608e3c-a282-4df2-abcd-8e38efc35843@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 23 Oct 2023 10:27:17 +0200
Message-ID: <CACRpkdYzhEJhN9BFdbZkJ7LurtT+dFMg97SLY-q91SNCZ8bikw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pinctrl: qcom: lpass-lpi: allow slew rate bit in
 main pin config register
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 10:22=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> On 23/10/2023 10:19, Linus Walleij wrote:
> > On Fri, Oct 13, 2023 at 4:59=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >
> >
> >> Changes in v2
> >
> > I tried to apply this to the pinctrl devel branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.gi=
t/log/?h=3Ddevel
> >
> > It doesn't apply, could you rebase it?
>
> The context depends on my previous fix which you applied and sent for
> v6.6 already:
> https://lore.kernel.org/linux-arm-msm/CACRpkdaybnYEmkgv7VG4fh5sXQ7uwHm2wH=
2Khja-P1b6idYr8w@mail.gmail.com/
>
> I can rebase, but I am afraid it will cause conflicts. Is it reasonable
> for you to merge v6.6-rc7 into your devel branch?

Torvalds is usually not super-happy when we do that, especially
this late in the development cycle it gets a bit ugly with all
the stuff that brings in.

Can we wait with this patch set until the next development
cycle or is it urgent?

Yours,
Linus Walleij
