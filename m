Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE4B756F11
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjGQVle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGQVld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:41:33 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278A5136;
        Mon, 17 Jul 2023 14:41:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51f7fb9a944so7016104a12.3;
        Mon, 17 Jul 2023 14:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689630090; x=1692222090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJvtasqqKaQL2h12DaU6LUoGc2FmpEmVYsuyHj/CRRg=;
        b=duu9wh20NcF95Nck9xqBAxn04Ry/Dw+nqY0yUR6C0IeSbVveaTBmVj3rGX2QAr2eJl
         F+QuAAPfvoXtO6CVe1OyE7aeJNPF34U5RftZDXgG0nppZJzSDckPrsEIqv+/FBXVOBQC
         i9neGxH85O3m+3dyh6PRB8hGE4wWGVY8R4wiGAIurWhsPru5dOIimYza/PyClWynKO8T
         ecHeSR5oToqZGHRQzbq1tjuLKpP836Z1knplTTT0ENJSfyAFCMTlUzvSPJkzfIh06cCQ
         x5IzX4vIiUx8Lqv7eIwXgeHzJrGCsjf2mD5/eOtAjnHJ0B8YK5c+EfSEPUvOZr3JbIQA
         h1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689630090; x=1692222090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJvtasqqKaQL2h12DaU6LUoGc2FmpEmVYsuyHj/CRRg=;
        b=BaaVYe5ocQnZVbkHAWz3tAm/n7Ggzuo4PHpJ++0S+4vpSo0R1sVOrzGa1tfKEn8tf/
         532KKm8ap5gmpvd+cLzgRUGolaCuRmKBXbJFBd+qaQklFY7A0/5SKzGvN90H2syR3+As
         93CjoR9xMlQnT0ROzmHdGd5Zz285B7AFCILyzaZj5uf+bjfenynz6MvrZsJqQKNITQYu
         HY0YqsSNeZVyssk2TdUHcoLQPXlt5gxz6wweBzQZj3ZWGHYNe96NGpFhAQyozkzbetMq
         rfMx6Lj6/fD0HdbLRar0Sb+pGzYwA8rlNbXGmExYjWdy2aStqDQMU1rRTMbWTUYtZ8Xo
         U8Ag==
X-Gm-Message-State: ABy/qLYN+eBf/a/b/z/kL8irxIb5jzK81sMWHO2MbIdMgOzdd6det+/x
        PadT/IlCMgf6CNLPyGqXhvjy221SbHobINDOeE5H8wPCt6I=
X-Google-Smtp-Source: APBJJlE+8JxaBZ/3Qgz7WWzKvQxFgSufFLpbWADS/LQwPkbBegwuUOKouKFwUvRqfTTzOtMxjpfFXaqsM8SyBbHOBUk=
X-Received: by 2002:aa7:c9d6:0:b0:51e:ebd:9f5b with SMTP id
 i22-20020aa7c9d6000000b0051e0ebd9f5bmr11115742edt.36.1689630089934; Mon, 17
 Jul 2023 14:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230717205357.2779473-1-samuel.holland@sifive.com> <20230717205357.2779473-2-samuel.holland@sifive.com>
In-Reply-To: <20230717205357.2779473-2-samuel.holland@sifive.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 18 Jul 2023 00:40:53 +0300
Message-ID: <CAHp75VeD=R2kp4wbCkJUEzi3TP4GXAhciAdWkQm247tgwR7-Ww@mail.gmail.com>
Subject: Re: [PATCH 1/2] of/irq: Export of_irq_count()
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 11:54=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> This function is used by the SiFive GPIO driver. Export it so that
> driver can be built as a module.

Can we rather reduce use of of_*() APIs?
For example, why not use platform_irq_count()?

--=20
With Best Regards,
Andy Shevchenko
