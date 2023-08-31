Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DCD78EBFE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243245AbjHaLaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjHaLaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:30:21 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BEACF3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 04:30:18 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-58fb73e26a6so8626187b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 04:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693481418; x=1694086218; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P69XUW20N8v7WEMjFdBLz18m8BcCG/JpWdxrnZjKH6E=;
        b=fnN+VNeVUpKwQQt0k3Xnu27qeFcOSU9nH1noWjivYHbOohp/QG3cxNzA3QhRS8Pfm7
         +MhmYcS6vePiOO6Vek6PxtFeSbxh6F/ZTF9yzwvyNl+qLPWH6AWIz5ghs1kk4BJbzw3m
         d8dRrq6eY3u7ga9Z6IS3luxtLQUynjp69R3bQJBuZ8hbODLQl8K+z0kB+ckW2SNHnb+z
         G5LqnqBztKHjvk/7V3jmcCaGrRIldTyk9kZh1f96+oyjHWs6sbYF3kfQicAxVZTwn4aN
         ZUUic92eA4GIOXiULeiSejxxvSe2GktH4cZQAYg87Jx3Qkjya+btCp9Rdko30NSKOspW
         +tOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693481418; x=1694086218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P69XUW20N8v7WEMjFdBLz18m8BcCG/JpWdxrnZjKH6E=;
        b=URQxss5Gm5Vge6EDgzMU4ZFXIC2XgQrLxk/5JFj8Z/E1aKKo2c2HoC4J+Lupy0B27y
         ZCrA7k027b4ARqnutLQNhoLGwUhcmay8gVyb+k5tUSpTRfQaKMSC++CSag66E0zKf0KX
         c2IFAIqFF4N5dlf/u61veNY9Io/dMY2WQaJV5bxSNOi4kzu6eDkaNM+LnFushLQ/jw/u
         7Uq7HS256h2dHiZbSm80/5D98U3wYOvXXCXLQ3ygP9D4Btl/91fLeQ5wTCiZe+IsjupF
         Xqwzz2elmY2o9WVtvokw4QByrXaKxQGhZ0TEjjdJ5EAakaHT6o0ig4+cfNyG4CaxsuU6
         HFtA==
X-Gm-Message-State: AOJu0YywbK8hSzw+R9250rNVDCDjEk1XSObhSHxWJxTay4J/rBzEEzhd
        /zyeLrazI42nMXU226DOOITb8guHw5IHIkHAhjGjjA==
X-Google-Smtp-Source: AGHT+IG3wpX5o5TiwoJaSIAlQpooeho0BC4+cHA8fCogEyPi1wHFnguG8bxZPAZFD7dF/rKVCn4IqkeFKeyBGy0NZRo=
X-Received: by 2002:a5b:889:0:b0:d78:5d61:ddee with SMTP id
 e9-20020a5b0889000000b00d785d61ddeemr4745877ybq.30.1693481417767; Thu, 31 Aug
 2023 04:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230829213441.310655-1-ulf.hansson@linaro.org>
 <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
 <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
 <96bb0de0-06d9-46f8-b02f-dc924afff13c@app.fastmail.com> <CAHk-=wi5Lh-NG_rvcx3Zyqd2Uhj76G4V73tWCFULhVzOU6e1xg@mail.gmail.com>
 <CAPDyKFrJH-1uaPCwnWZDPi4MRtOm=N2CHSRyvjXRDbQ1y-oOrw@mail.gmail.com>
 <CAHk-=wj1j0HuNWKLEzi74zEr2rGnMLEFZjLvV=rzdqzQPqOzdQ@mail.gmail.com> <CAHk-=whpfnSqToqx9f7G4-QssDHW2TBPqiXc5q1=q7w9NKxiSg@mail.gmail.com>
In-Reply-To: <CAHk-=whpfnSqToqx9f7G4-QssDHW2TBPqiXc5q1=q7w9NKxiSg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 31 Aug 2023 13:29:41 +0200
Message-ID: <CAPDyKFpeH5XV36NaaoWQw8tuXhi6jOtEAfWujC9An-tSzSStvQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC/genpd driver updates for v6.6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 02:08, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 30 Aug 2023 at 08:07, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, 30 Aug 2023 at 01:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Please advise me on how to move forward.
> >
> > Just to not cause pain during the merge window, I think I'll take the
> > current trees (eventually - I still have other things pending first),
>
> I took the existing pull requests since they were next in my pile.

Thanks!

>
> But I hope we can get the naming sorted out still during this merge
> window and not leave it pending for some later time.

No problem, I will take care of this. Allow me a few days to send you
another pull-request for this.

Would "drivers/pmdomain" be okay for you, as suggested by Rafael?

Kind regards
Uffe
