Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5BF7687AA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjG3TtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjG3TtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:49:22 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6144C10D8;
        Sun, 30 Jul 2023 12:49:18 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a5a7e7cd61so2416774b6e.0;
        Sun, 30 Jul 2023 12:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690746557; x=1691351357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIQSLgIdQUNfneyaA02ZMgmzid7TD+sfwmPY2r2YrHE=;
        b=BFG8YjYeKz7rIZMbSCE5gbiCKMXpB4l5AnSrTprpUeJjg3eyIWbZdLGAKE98HO7Ao6
         Ix8Va+2J12gkjLwQ/ECgd0mk9ceLWdLKx69Kl0tb7RzislZaX8cIo2DvXQ+98nHEwH6B
         TP4/swp8YkENRa9i3S4KBWtbzj+99BvVdeoMhzmCD4ANWsWOFAFnXEeH6XdthWkg1xYv
         Ydn73zuszDxYxV+nPrCCmtIIGbC+sHFBmwqIZMMMuzpe+HIifW7hjjBtEGlX/RSb2VFx
         eQCwvZ46Wk1GaBkyXEJjDlK3XLxeYCdshNxuPC7Hnzkl3JZ0atnXTrfLgAn+GqVX1XS3
         DO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690746557; x=1691351357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIQSLgIdQUNfneyaA02ZMgmzid7TD+sfwmPY2r2YrHE=;
        b=dng9n2hAvYHbnPSaIw6ulwsRJphBFAiR85FZZSi5LOGN4WTyoVY6nOYAM1hV2mE3p0
         DMG0lv9OyAnk9Y3fsG/Q2hKMpZzVvxfygKz58k3KKKFMraH6uKI2+bicWDLd6AzsNyqI
         U0HYXWJCo+4TX0qtNrDdEiHQLRBU1td4++IldyavNmv9mXBcipDYAcfAReY6H0aVx2qk
         RUui/qjUgWUFWW2RC0ATxxGTCbWMyLmILuEj8IWR7QGmxzB6sJHbTwg154Wm6XZ/JKOa
         f0iZ5u5qdB/Kq5e/kcH1z0H/pJsKnQld/bzKE8opINyyAXbDlJwCMa0zIsCh/N6/hY1+
         7WOQ==
X-Gm-Message-State: ABy/qLZT5Tj22XZ2Cyp8TgPXlTmZaWEzyyYS6EIJdeFtASh5m9PMSRjD
        YfoEMoz32E3n/Yi8QrhYIVMsXbOe7bnN0WFnSpD8K3xniS0=
X-Google-Smtp-Source: APBJJlGx/ZTEhQ0x8I1dI2IahOu41uCfqqphM8twVUVRVscTK5LM9BP381GpMzBCnSkDY2bUHX87wgACPBe0322juks=
X-Received: by 2002:a05:6808:188f:b0:39f:f42c:863 with SMTP id
 bi15-20020a056808188f00b0039ff42c0863mr10776952oib.6.1690746556919; Sun, 30
 Jul 2023 12:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230728175914.18088-1-aboutphysycs@gmail.com>
In-Reply-To: <20230728175914.18088-1-aboutphysycs@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 30 Jul 2023 22:48:40 +0300
Message-ID: <CAHp75VeZvrtt3eEJyiqNbuoLFZDGcv=kyZn+8Qeb9Xqk9a3e-A@mail.gmail.com>
Subject: Re: [PATCH] gpio: palmas: remove unnecessary call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
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

On Fri, Jul 28, 2023 at 8:59=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
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
