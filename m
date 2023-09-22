Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1006E7AAAB8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjIVHsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjIVHsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:48:39 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D932CA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:48:34 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-45274236ef6so869783137.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695368913; x=1695973713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAOgao/u9B0r0EeNR2cp3sQtHumqHto+rh8OFb2uoh8=;
        b=Qg/GqlzZrjmq3MQN3j67tuA2e7hfAvbjK0Wj0eci8Zc4FnBZ+UwxxZNCYny2dshBAF
         kL5zoX6AQha71fNKqViiOgqwYXFGLglSNeDB4jevLesItHybSWY7iIq9fn1bX6TvSZg6
         WAHhhB3f12ZLHsS6QzIqR4q19ADWw6C/RIfPSm5D83wOTVjmt9UT5Ti8orPJ8LVQHF+W
         s6XoSy0rSDNY9yfBMhQ36uUCy6/XASEKcias6JilBz1K6C+TqGWbxa8fblqQkukyjfMN
         NfFDyTtOq8nhaph1CvnsIIqW3cOu7zSA98Ql0LX2Zfgl2179rGst5LfHHwt+hwKqeoa1
         /Ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695368913; x=1695973713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAOgao/u9B0r0EeNR2cp3sQtHumqHto+rh8OFb2uoh8=;
        b=U5E40T+m6DjINn62489du0hKUG3QpwR0mDmidIHGYhZDS437+gezNLPI5L9dek5r4P
         mxFuAgZHOd4cmt+NLw1TbPjHHqscD131ZDEH6Xmmp5ajCxbl1M7xMzCYY6efkspLwdNW
         fltRktnVvZkbHWbGl/kDklrYAiw17SgyrHN65x5MydFTkvnSXy1kJyFW1CrN6jBQtxjC
         nT9gvsodhkY06KP/WysR20GoHX/xnIiBkssoAXCCaAeSbpfEDSHlX31yo79svZBvZrSj
         GJ4NUCCCcoKT8Fp15lPgw1G8AhBfiYwdweUhaQ6LXzNVWywPhKVrI2DuNh1lIIoT9SWa
         2XoQ==
X-Gm-Message-State: AOJu0Yx1gb5Fgad7D/5Vs6FG3RCsXrGcx9jMEVMhTmrvr8eo/WqK1o3Z
        CmaIQ3wuyd/dYaAfZHXbfoPAvv+bmqlEv1MshCEAuw==
X-Google-Smtp-Source: AGHT+IFdJLGjtvAG8/1/+PiRTsHeb3LvR2YKD1Qr597IyNHmETWaEkjY4oVTZnhp32fxWp2n/Gl8g7eN1Pwglg9CpCg=
X-Received: by 2002:a67:e88d:0:b0:452:9b18:b326 with SMTP id
 x13-20020a67e88d000000b004529b18b326mr8342318vsn.10.1695368913153; Fri, 22
 Sep 2023 00:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230720173956.3674987-1-glider@google.com> <20230720173956.3674987-2-glider@google.com>
 <ZLyI+0EL1VztnHLe@yury-ThinkPad>
In-Reply-To: <ZLyI+0EL1VztnHLe@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 22 Sep 2023 09:47:53 +0200
Message-ID: <CAG_fn=X62Mm2AxScRUHv6MxLAy24SXmSLtwXJqYDXi9_og-mMw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] lib/bitmap: add bitmap_{set,get}_value()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Regarding the rest of the series:
>  - I still see Evgenii's name in mtecomp.c, and EA0 references;

Double-checked there are none in v5 (only the Suggested-by: tag)

>  - git-am throws warning about trailing line;

I checked locally that `git am` does not warn about v5 patches. But
given that the patches are generated with `git format-patch` I suspect
they get garbled when you download them, could it be the case?

>  - checkpatch warns 7 times;

It now warns 4 times, three warnings are about updating MAINTAINERS (I
don't think there's need for this), the last one is about
CONFIG_ARM64_MTE_COMP_KUNIT_TEST not having three lines of description
text in Kconfig.

> Can you fix all the above before sending the new version?

> Have you tested generic part against BE32, BE64 and LE32 architectures;
> and arch part against BE64? If not, please do.

I did now.


> You're mentioning that the compression ratio is 2 to 20x. Can you
> share the absolute numbers? If it's 1k vs 2k, I think most people
> just don't care...

In the other thread I mentioned that although 20x compression is
reachable, it may not lead to practical savings. I reworded the
description, having added the absolute numbers.

> Can you share the code that you used to measure the compression ratio?
> Would it make sense to export the numbers via sysfs?

Done in v5

> Thanks,
> Yury



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
