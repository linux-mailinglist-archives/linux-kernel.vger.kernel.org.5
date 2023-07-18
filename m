Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8717584E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjGRSen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGRSem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:34:42 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667699D;
        Tue, 18 Jul 2023 11:34:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51fdf291330so8579403a12.2;
        Tue, 18 Jul 2023 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689705280; x=1692297280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CDJU1xNl/ULWj322kCA9VUCu+qNR43l1QUPVjLOESE=;
        b=Z1HRyfaUpTGHw6aXl9a3TcNZn/SkAEZ7zCH+pZObqvl31ntWRjtOWKgNUsPUx2+PqV
         o3QOMLAD+VQRQUoTDZYqyicABXO2BFvizM4kVFutZS9qBzlnWEe+Dq1gGl+Nm5OLt7Hr
         JLtXGjPAZtGRwChG9JLwFTpcrb01rOYJ4WvJEiw4mltDsKQGDc2UM9VTVJl+uWMGeu2R
         wttEccktugaRFUiX3gmAAIINmS4z97QlGHKNOUajz0MEmlZf6Awi9wlrwXoox1TPx0vb
         amX1WT2JnRa9m1ut8R8g0eJbm281/D1xgzzWDQ3GwK7RKMR3fhK/LO3aYC2P+gUmDhoO
         0T8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689705280; x=1692297280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CDJU1xNl/ULWj322kCA9VUCu+qNR43l1QUPVjLOESE=;
        b=Ihy5yUtJ4pBtGZC8MfjonM3LSZzwhpH2znO7drE2cN5EIg2meNL8oa5RRI/HlGfr0E
         vDIAOeXVtbltRtOXgjbGP/sQEZoTayMQJALfBCFt9M9EOFtZb4M4By9NlxV2YF+tMHoK
         dYGOVkHRCyBfgyZd00UJIHmaj/K8aZaXvSnzy70RUNqJMEOnvwmpjiem0n3W0qG7sEvS
         8I0seIbPHKzAQZhqD7NmefwzSBE8VswLfSLoMlKEU0Dd+bO7RUhQW4YSHf5B0HTJq8Dv
         tPdX04VGczGZ3Rz9bkYPQNNIVChiPJ6DtaTU5iaO91l/SZq7X2Y84xBFFWQm6Aeae8h+
         ZtjQ==
X-Gm-Message-State: ABy/qLZI8YixCW+jpgTMH2+M40KdvoXPdI0SYdiqxYTjPLFjuq3Y++D1
        3+uMyF6xCqNr9WMJGm+yy6ELPTSJ62YdhDfDLgY0fBaoKDA=
X-Google-Smtp-Source: APBJJlEiUXhRs0IBYhp3A1XfmvheXrER1Do5YtX3SC5pXWWcoHceQp1HUB8Fos34Lity5PmRjJR+ak6zgF4xKNS2pkg=
X-Received: by 2002:a17:906:3019:b0:974:55ea:1ad8 with SMTP id
 25-20020a170906301900b0097455ea1ad8mr582885ejz.63.1689705279701; Tue, 18 Jul
 2023 11:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230711151248.4750-1-asmaa@nvidia.com> <CAMRc=McCwXeJpKuvHY4aheURimqh3ZznvVXKxsV2HzeT0=QYGQ@mail.gmail.com>
In-Reply-To: <CAMRc=McCwXeJpKuvHY4aheURimqh3ZznvVXKxsV2HzeT0=QYGQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 18 Jul 2023 21:34:03 +0300
Message-ID: <CAHp75VcQLKmbDtME5aZYt4P0Sw=pobKDCZ6OMCjdy+_iM8qT2A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: mmio: handle "ngpios" properly in bgpio_init()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, davthompson@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 9:21=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> On Tue, Jul 11, 2023 at 5:13=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> w=
rote:

...

> I'm confused. Is this the final version after all?

Seems to me so.

--=20
With Best Regards,
Andy Shevchenko
