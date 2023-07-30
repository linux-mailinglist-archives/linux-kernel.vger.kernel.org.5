Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D00B7687B6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjG3Twk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjG3Twh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:52:37 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D95E5;
        Sun, 30 Jul 2023 12:52:36 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a7293bb9daso305139b6e.1;
        Sun, 30 Jul 2023 12:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690746756; x=1691351556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irYInVnPS/tUqtpxyqyZYacAjAqpYI1s0BeAjiIXhKs=;
        b=IKArmNfX22kFqJijV9KRBuanClgspS2RXSSPhdRAyRrvWs2qkY5Uw5iW2SNkFKbnML
         mC8AlioIRJC8Bdy+br1Yj5KeMXBXOzz6N04mF2kqoguTeIKsO6fqx5qho6Jx2w3oyqAk
         KBQWB4VrZLi8EgYMa1FUqQFM+UwI4CiTopOqPKAXTo2doi5ZW0Mx0aKvHGmwIdJBJ6L7
         jCNjWdfbbyxIFNrqgiwscVQA9cCYYUqMBncGSd4apeJfiWYIyAwd6jPGPdlffNCnWWI3
         WSd3OflX9XhUEeH4R1q45aX9x0C7C/1KJ/Wgno3dRhCBXH3QyP438zRppKBaRsI732Xv
         ghSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690746756; x=1691351556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irYInVnPS/tUqtpxyqyZYacAjAqpYI1s0BeAjiIXhKs=;
        b=Z5p5EupIghoLsTpQ6qdbvIaVhtiwNJpmQCPwkQi0uRQwybAYs3zWhYKpLPxVF7TdXx
         ykGuJjTNh+U+L3XxZPadElSBKcYO1vcCD0zZn+O87Pb89use4Oemxq19VdLwOgDa31bA
         6A0vfKJNsfhStpKynnkO3YClDNT4qCXcZK1JSJkBYJ1A2f7Q5hypphcXJcoyF0U1rG3O
         Oh/O9TcNg68acqioy+k3FNygDBeWE2tiyi1IrBp5PI7QkyzhCWU+Wi5NRlf0j0ZU545a
         k0s3FThEhyC83BucMS2uT9PzHBMT2tKUujpwsbrDo9mwxf6BZwEo1dFJkp5hggsBggd+
         ZSMg==
X-Gm-Message-State: ABy/qLYMtwEmylntGiJ0zNaXKPZhszK7uj0QHveFq0WyV2Vi6qiVaWAv
        7TOxIZS2xCiCqvhOqe0o6FkEuvZfbHlM+ZBgLQ0wOGI9QAo=
X-Google-Smtp-Source: APBJJlEd+JN7dZLSeZVhITyU+FL8s60tAB7damK2WCtdPFayxWJkkIkkkOo/b5MFw94eA7N+YsykXHZ7ToKt/EyQttM=
X-Received: by 2002:a05:6808:10c2:b0:3a1:dcca:9628 with SMTP id
 s2-20020a05680810c200b003a1dcca9628mr9692947ois.10.1690746756142; Sun, 30 Jul
 2023 12:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230728182522.18477-1-aboutphysycs@gmail.com>
In-Reply-To: <20230728182522.18477-1-aboutphysycs@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 30 Jul 2023 22:52:00 +0300
Message-ID: <CAHp75Vekz_muk8yuTC0aneN6jZhOtCBmVXc9M1B4ggKO92f1_Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: sama5d2-piobu: remove unneeded call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, andy@kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org,
        ludovic.desroches@microchip.com,
        Alexandru Ardelean <alex@shruggie.ro>
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

On Fri, Jul 28, 2023 at 9:25=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
com> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
