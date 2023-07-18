Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6157584E4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjGRSfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGRSfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:35:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D659D;
        Tue, 18 Jul 2023 11:35:17 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e619bcbf9so8369791a12.3;
        Tue, 18 Jul 2023 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689705315; x=1692297315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3wCC1xYerGkLa+DSMHiGWz6Ey+IZIN2Q25DCTEZA/E=;
        b=UMKJO6nSlTdVM9mx7YWtHCdfpr2Pf38fTcJ0mWm8X88s6rsd2Y1x7tkTsi1CzEcpOk
         9v23jTlTjvWlM54Di8UOhceDjfPOYMoRFcpvxM/YwQLptaal9GTCfLw4yMMzbeirllj0
         GVl71qFwa2XU4oWsMtEynX3bsblXL4Ske6w9f4Ta6ncv507ErMwZ14kfdBE1QvB3NlF8
         z6oOzs9qc8X36Dmw4h96EnwkCTFEkHqEPuTRgWV+DQ6CWDgyVAYGiLoYE4W0HusXIu3Z
         5r6iRZ7cjCHvD4MZMJGLv3mNjHVpjclnQDFJMJeuXo2nrwrJt+SnNZgUEsvatWzAJI8i
         ub7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689705315; x=1692297315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3wCC1xYerGkLa+DSMHiGWz6Ey+IZIN2Q25DCTEZA/E=;
        b=J5h8eMrVLAhyOYHAhleiLwj4H+BZE99ME5QRWBJPUDuRIJCIuKhT9DTe/gaKBvkHRQ
         SyirVvzK7BkZGvmM/aLvrksmB6MvpFd1nuoyDszrIcZlMJSxhmc+0hTl4tJuFPH7F9GT
         T9hxea4sA7oipHfZv2OokU+2JEMGHiCzHF7RK5vaS+0fzis9mHDsrukuuktkhsbIUQNK
         /d6VH5MkHZKGdMfjNW+ICiyZssqxf2omprYpFztjO49qvc2KLqywMO4mt5adsal2YmoP
         ZpMqYFim2at7yy4XZ5aR0Pu2CVU7/fhgcmQ751LYg7kgDOn5t0LTmJu+CfO1ZKfYMG8K
         Q90w==
X-Gm-Message-State: ABy/qLa/ZSSyFaOPz0XYxm9JPLxK70Ta6X3g6a+1Kd+ejRWfTJwWKNrI
        SaBwTrn5Gk17uF1O9Qg9gOSGyJfjAveK/iRRfLQ=
X-Google-Smtp-Source: APBJJlF/8KBoBglQioLP3meu2gYDJxhwlP+RU4XkyAAPxA3DZAVrnDev3SFH37CrPwkPqt7T0LmwCgLZnA/WfOUp+og=
X-Received: by 2002:a17:907:2d92:b0:97d:2bcc:47d5 with SMTP id
 gt18-20020a1709072d9200b0097d2bcc47d5mr453886ejc.49.1689705315301; Tue, 18
 Jul 2023 11:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230710214910.31892-1-asmaa@nvidia.com> <CAMRc=MeQBSJ8Y92VfOfiaDjDyW44RunYt-D1aFraNaR_dTRVOQ@mail.gmail.com>
In-Reply-To: <CAMRc=MeQBSJ8Y92VfOfiaDjDyW44RunYt-D1aFraNaR_dTRVOQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 18 Jul 2023 21:34:39 +0300
Message-ID: <CAHp75VcKH4ZJ7HjjY6q_Woi2wAwnhiqyyPySOpK9Amt_SHB8ow@mail.gmail.com>
Subject: Re: [PATCH v5] gpio: mmio: handle "ngpios" properly in bgpio_init()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, davthompson@nvidia.com
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

On Tue, Jul 18, 2023 at 9:18=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> On Mon, Jul 10, 2023 at 11:49=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> =
wrote:

...

> Applied, thanks!

This has a bug.

--=20
With Best Regards,
Andy Shevchenko
