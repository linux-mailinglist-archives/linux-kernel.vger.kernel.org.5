Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F67978E3BC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 02:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344798AbjHaAI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 20:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344791AbjHaAIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:08:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC80CD7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:08:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c93638322so43579966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693440499; x=1694045299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/HSUbvCmjvUYxW13fpTOiENotuRhulbUWAS63hgfbqw=;
        b=O7akR2iWzN71ztsSjRz+GItTwV0EPBJIdyxpg+7BUM3P0hTWxrvJX6kIDwOVLicZxl
         d4JqgKdGNf4v6nv1aCiV4YQpDq2fKhRCAwZ/x0bbsEqD8KlZRUN6o7fdvWkv2J8HFvll
         3RBpSn93Ln7gVUe7w/LG3GZjW5lSyPpiMrhqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693440499; x=1694045299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HSUbvCmjvUYxW13fpTOiENotuRhulbUWAS63hgfbqw=;
        b=NsKyeDSfyMbNPdViZQ4wWwWwNILjrKACuMQ/tgCpIDbagCkQOwvHExp52ZTnoSkQiS
         Izsq7IHyI9vvPqd2Aar7c5aM6gd4EMy6o8xT7hgpMdt+NhD8v+46FLdkPZL2SQvXgwum
         yVYMo4io0PoINReTpaqQRjvMzUQtIiAe7NnMwSZ062w0l+uVwXwd10K4xQcUp4Aqeyqf
         9As4QI11MjWYoxVVDXuYbpYqxAklI4w1ReeH2bMrZyQTsD8NNVcfwch20PFG6y8Z34i9
         010IeUIZUIh4W/ZoAxvkeaubOHWujsJIbMt168OpEu9C1Rtgjj3qb54KJ0N03HgwnwL6
         BrFg==
X-Gm-Message-State: AOJu0YyfMHCw+pHAhOUdV8JnMnpCd/pqhCHhYmOH4n2x0LCsTe9huOlq
        lYAntQy/dXvPGBMed6gxlxnCqXdtrijwsGYUa5kQ6Q==
X-Google-Smtp-Source: AGHT+IH3Hf7NgQfZk65EZhJ6fsrU5zxFr6xsRzpYWSOXs+gHLHPHlcWecw049wgPCWm1XEJXEBdIBg==
X-Received: by 2002:a17:906:224b:b0:9a5:bceb:1cf8 with SMTP id 11-20020a170906224b00b009a5bceb1cf8mr1392190ejr.3.1693440499291;
        Wed, 30 Aug 2023 17:08:19 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id e19-20020a1709067e1300b009a198078c53sm110139ejr.214.2023.08.30.17.08.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 17:08:18 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-99c93638322so43577266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:08:18 -0700 (PDT)
X-Received: by 2002:a17:907:7799:b0:9a5:cc2b:50e5 with SMTP id
 ky25-20020a170907779900b009a5cc2b50e5mr1382530ejc.32.1693440498078; Wed, 30
 Aug 2023 17:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230829213441.310655-1-ulf.hansson@linaro.org>
 <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
 <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
 <96bb0de0-06d9-46f8-b02f-dc924afff13c@app.fastmail.com> <CAHk-=wi5Lh-NG_rvcx3Zyqd2Uhj76G4V73tWCFULhVzOU6e1xg@mail.gmail.com>
 <CAPDyKFrJH-1uaPCwnWZDPi4MRtOm=N2CHSRyvjXRDbQ1y-oOrw@mail.gmail.com> <CAHk-=wj1j0HuNWKLEzi74zEr2rGnMLEFZjLvV=rzdqzQPqOzdQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj1j0HuNWKLEzi74zEr2rGnMLEFZjLvV=rzdqzQPqOzdQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Aug 2023 17:08:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpfnSqToqx9f7G4-QssDHW2TBPqiXc5q1=q7w9NKxiSg@mail.gmail.com>
Message-ID: <CAHk-=whpfnSqToqx9f7G4-QssDHW2TBPqiXc5q1=q7w9NKxiSg@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC/genpd driver updates for v6.6
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 at 08:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 30 Aug 2023 at 01:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Please advise me on how to move forward.
>
> Just to not cause pain during the merge window, I think I'll take the
> current trees (eventually - I still have other things pending first),

I took the existing pull requests since they were next in my pile.

But I hope we can get the naming sorted out still during this merge
window and not leave it pending for some later time.

               Linus
