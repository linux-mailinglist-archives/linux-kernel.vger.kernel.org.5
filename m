Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C327D74E4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjJYTzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJYTzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:55:31 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221F0C4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:55:27 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b3f6f330d4so49382b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698263726; x=1698868526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVfs2vQPn6075GttomjikJbq1FdZzRDZ6l0gLyS0UXY=;
        b=L3Fa/njmA3EkAUK3JY7DH7uHw2sSPrYxfEyF/V65uSeMOKZkWRZjv3UKRLz5chXKxb
         dmnBtR280sROIOiQt4947zEw+k52NUU7MKrRymeF+gdoTZf7GV85OcKgsRcshr+D6BTU
         KDkLjYzzazwjF0bBC7ofq5h37rho4lme7SuyF9b34RthaGs3QcqIfiE6xxZ2XTAZzoL6
         VN8jEBXAdrJhz5Lc+WlO8gRAVimyQEwC01vo685MZ0ZGin7nkjTEHEUkRQ+722u2feQK
         7gJSuoG9WHIyUdcC+HJSgqk0KC/KlqoPfj1aPjvOxwVd4/Pw0hFL5XDDI/I/lsePHJI0
         tnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698263726; x=1698868526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVfs2vQPn6075GttomjikJbq1FdZzRDZ6l0gLyS0UXY=;
        b=eTKJ4qRcyZBaTKnhjqGtKPJHSLXfGTbmWSKSxq6cGxleJRrj7KD614Lme7vHDI2DV9
         O0Fdbb43nQ61+RiVlOH072oNS+lcvwLFPz/6HDBehyL6JoQQIdyvyl/4Dt0eonZSkmEf
         Cm5YTyq/bpaiP83lwtVD6rZBlCVt7FzFuvadrHf450bBCCW2TPA08nKKbAZPMeUW0MZZ
         zU4B2JTXTm4v7mB46xq6tgqY3re+zK7kHfbVvoxcS+qpEWbx2Qqok4nyimQn51vn0Guz
         oQ1hk7cBvIdZvYCior2yAlrAwxrvaEAHV0cpRw4Ye4QFdNoqbEvWm3/xMaK2pC0/uAj1
         R7hQ==
X-Gm-Message-State: AOJu0YwPrePSm1ril7JOLOPdhhUmQ2B1Jxkp8XJ88MVhWBalkAWR6Nz2
        Q4KDoScCibLO5Df1yLg3gQLciFmaP1ecMdroHR159w==
X-Google-Smtp-Source: AGHT+IE5aFGh12IgD6465G/P90VCx3AJDx5zrTXXimxuEuhvkas9UEy1EiU1Xj52N1div6ehkYg4X+nOL8OdN0SShD8=
X-Received: by 2002:a05:6808:1586:b0:3ae:5c48:6f41 with SMTP id
 t6-20020a056808158600b003ae5c486f41mr20419217oiw.28.1698263726480; Wed, 25
 Oct 2023 12:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 25 Oct 2023 21:55:15 +0200
Message-ID: <CACRpkda+qSzAQggm0_MhhvK-D+f_V77O3=u=03zEOWWVTV_TJQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] gpio: mmio: Make driver agnostic
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 8:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Driver uses so far some OF APIs when generic fwnode ones can be used.
> Replace these APIs accordingly. Note, this will help to clean up OF
> headers even more.

Clean, elegant and does exactly what we want.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
