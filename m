Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E35275B21C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjGTPNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjGTPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:12:57 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F134E2704
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:12:49 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b74209fb60so13731711fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689865968; x=1690470768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OR4CnZp6F7D4KAQ0BL845tbrVz9ugD0EX7S7dGF5yAU=;
        b=pO+ADtc6up0M6npJq2D7M9CPM5XSRbEjmN5kw5Y4sDaVIw4SufxISznRG33rqAeTsh
         ftacbyqghje6LEWXp/IKmIU5EhuTv/MbhZQw3VPCCGNJ2m/0ZQAoIGltOSrSgCQI6g27
         0Wqb8CBXCVZplCfldJV3FFKjzhU8nTv4mtH+2H7aoytnEvu/51SwQqU9aOLWvHAgMAGc
         HOEN7wicYJsN1vEIANEbT5zGlCt6Ps6tbvH9wTddAGSrC31GU/XjkCKDCfTORxnPRMa3
         tYVsOkmdnpL+HYvFzx7IIbN5fBXbjpVVfLpV/PiplICvCcPuc0ErMi69HFGzT5QpHEt6
         PpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689865968; x=1690470768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OR4CnZp6F7D4KAQ0BL845tbrVz9ugD0EX7S7dGF5yAU=;
        b=SxSx50BmyhFL/3um/lmeguE8s9s/wVfGysdHnIXjjOilNxW6LU5q/UVe8/730dy+k7
         994s2vrklTUHOwy2L02n6Wm+2BnEf+wcebP3xz6ScI4Z7uM15qk7ycUiI+eW4YSpSOdb
         PiSj4dPeHU6mgJgAUL48cO+7mpq0wBFJxSwVRtAv8N1ly22s7HR55Gz/ReErpCoUbJ43
         NEIy+virdr0HFfHUdH+QW26SLDVhU8aTcI/EV7kbNe/lmQ0DfUytKgkel9j3pCr5zDvf
         zN1yZvJ3z5SmYMj6h81hN+6KuhFQUX3yMJwn34gwSXwdpIjhsxbPyN2AGd2y2ogeS0ul
         fQ1g==
X-Gm-Message-State: ABy/qLbUyMq63f502hCOCmJiMMY6CnuRoz9rVLYHrxKLoIJGMgs8E6bG
        g/fQJj1dDRzsgCruyktCQL9xboUakSLE22L4etfM7w==
X-Google-Smtp-Source: APBJJlGGvCyKQ0is6wgjsQg1NXCvU3HK0pcsuXhP+KW9UwSvuyAY7ouvvwRHKVbH8WSa7H+UhgqxHSJYFfpzCfSMQNU=
X-Received: by 2002:a2e:870d:0:b0:2b5:8bb9:4dd6 with SMTP id
 m13-20020a2e870d000000b002b58bb94dd6mr2539937lji.12.1689865968242; Thu, 20
 Jul 2023 08:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230705194544.100370-1-nick.hawkins@hpe.com> <20230705194544.100370-3-nick.hawkins@hpe.com>
In-Reply-To: <20230705194544.100370-3-nick.hawkins@hpe.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Jul 2023 17:12:36 +0200
Message-ID: <CAMRc=MfaEfaZ7yYrFtc+XChzPX1C1AV1xAZPRZyJKA+z7D6-vw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] gpio: gxp: Add HPE GXP GPIO PL
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 9:49=E2=80=AFPM <nick.hawkins@hpe.com> wrote:
>
> From: Nick Hawkins <nick.hawkins@hpe.com>
>
> The GXP SoC supports GPIO on multiple interfaces. The interfaces are
> CPLD and Host. The gpio-gxp-pl driver covers the CPLD which takes
> physical I/O from the board and shares it with GXP via a proprietary
> interface that maps the I/O onto a specific register area of the GXP.
> This driver supports interrupts from the CPLD.
>
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
>

[snip]

> +
> +/*
> + * When an interrupt fires for a PSU config change
> + * there is a need to know the previous PSU configuration
> + * so that the appropriate gpio line is interrupted for
> + * the correct PSU. In order to keep this variable up to
> + * date it is global so that it can be set at init and
> + * each time the interrupt fires.
> + */
> +u8 psu_presence;

I'm not buying it. There's no user of this variable outside of this
compilation unit, is there? If there was - the name should have some
prefix but even then, I don't see a need for this to be global. Why
don't you put it in struct gxp_gpio_drvdata?

Bart

[snip]
