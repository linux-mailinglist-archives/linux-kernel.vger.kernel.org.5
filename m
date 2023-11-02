Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223AA7DF2F7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376344AbjKBM43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjKBM41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:56:27 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E27E121
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:56:20 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5b31c5143a0so11030237b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698929780; x=1699534580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsAjcGl2UpHPgEQeJujj5h3M2CG8DtmrGk5g/mrx/Gk=;
        b=QzuHAefrSZCMQDhfvQt41JRfqMsy37D2hBR/5PWZW9QiY4HBiTdRB3KRW71sq+qCay
         qm02OvTRM3BTJ9OKXEX4YBjezDiznpe4UxwIPeJR0vkkAlHf2FANjJ8Tuilzy6yQT8Zf
         0wFWypNmL8HpmwJhee0gfcHKeRzK3LdDqSOFkzguIeeInSYxWtkYhdgiSEOlK9cg1Vgd
         m9f+QScfiX2M+xkeG/r5vDt/hYVpIqNLCKhYUkvY0iWWb2D5j5jJOCRWIzZWWHkznK2o
         uUu+W8OXuDOIK3UhMWlYeHcpr6FbvVo9qfrcGOInLP0i5SrmeO1rcoBqYXGutxJBxVDG
         qLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698929780; x=1699534580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsAjcGl2UpHPgEQeJujj5h3M2CG8DtmrGk5g/mrx/Gk=;
        b=w0dIZqLpkdO50p2DSgeUdNsmQADLN8T9oeVmCYesv+Q7KIMKNU++DSMjqOFI8oijEg
         J9VZe0fhC/pTz2xOA3S2joESLdp5jCE5V9pEHB8nL1LlcGGC7PHS4Bb4qPQ3BmFjzlVf
         GsLJhlLBMfl0NNBHefJ/Vm/+B0kiso54gXJRROmpoJ0tyqbNuEIryYAeswdrNgyP/Ryf
         xy9vfCqxk2YzbE4Nh3S+unscEqfIG4JvZhxoyFxn+1bop9NtXBacOYbpvGafCNpfnXHo
         Hb4sI2ISWGwEWwmmgWMXC71AnQ0p+WJ4AsdBK8ZJXh7E4sqBU3HIaJI4xDKcs6nglOJH
         nx2A==
X-Gm-Message-State: AOJu0Yw+Mx8E9RfSvbo/BMfmcz8ehYbqs7FWPXJRH3ncq6ahNdsPe87I
        cGQ23Fyb4iwYdlDY7lyzW82F6HbCxZLekdYv9a00Kg==
X-Google-Smtp-Source: AGHT+IEz9bjCq1ln/F8/UzX3flETc6xhBQrn1tNDeiGtyC5Mern9SR/xTfC/eMkvZYPtbRtdn/D38/AQ5b9I5g/B2qI=
X-Received: by 2002:a05:690c:fd6:b0:5b4:501c:b719 with SMTP id
 dg22-20020a05690c0fd600b005b4501cb719mr4293035ywb.31.1698929779854; Thu, 02
 Nov 2023 05:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231030155340.3468528-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdb3wLAZfU+_E0r5Rr_HD-bdFpf7K6bMD6dqiK1Ryv7NAQ@mail.gmail.com> <ZUOXVSij9497HrBR@smile.fi.intel.com>
In-Reply-To: <ZUOXVSij9497HrBR@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Nov 2023 13:56:08 +0100
Message-ID: <CACRpkdaYpgg7Umc3=QZ1QxH=jzt-wJh+msu5DuVn1aRUvzkeGA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: tangier: Move default strength assignment
 to a switch-case
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Raag Jadav <raag.jadav@intel.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 1:34=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, Nov 02, 2023 at 08:36:11AM +0100, Linus Walleij wrote:

> > So where does this 1 come from in the end? That's the piece I
> > am missing in this explanation. Somewhere, someone decided
> > to pass 1 to indicate "pull to default resistance".
> >
> > Is it coming from ACPI firmware?
>
> No, it's pure Linux kernel decision.
> gpio_set_bias() is who made that. That's why it needs to be chosen on glo=
bal
> level.

Aha I see, that makes sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
