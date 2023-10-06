Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1467BBE4A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjJFSE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjJFSEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:04:25 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3032CDB;
        Fri,  6 Oct 2023 11:04:24 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-65b0216b067so28795646d6.1;
        Fri, 06 Oct 2023 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696615463; x=1697220263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oahi2dyVEaZskw5jxKCp0Yrt/7KivDjXw0+gyqOGweg=;
        b=mSRDdp7pWmEPkNQnPmZAZbKB6/gyTll9DHvCHYlnT/+xgK6BsmIIIW7AZg5d05yelo
         pj7tZq6MeyKyQbdW5HXmqdSAtpBk39uLd1yWOFGn9YspSwh44wPrsgAPMBdSOWnBNfUV
         ahhnlFmPtr0A8OytiPvOw+dxy+f8hfE46/M2rgk1Gsbip07+9QblRt0zzgh0UKF5+5WM
         aO03xU6NyOENzXgZvoTgknTZPIWVCp6sRMujj4/2rzN1R9E0RAhP3MNbmNn/HSKbI0Lr
         QskpSvpCVUc2bsG9oJH5QawERT05yIhsSCoaFtuG28C098eWsiLGo+KsvxiD6grAtKzg
         aPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696615463; x=1697220263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oahi2dyVEaZskw5jxKCp0Yrt/7KivDjXw0+gyqOGweg=;
        b=ahNUQ5GAgWgayUE8HhsEBsRH/uc6IC318gn5AximMCdqa7pm14HeqUFXwuf+A840M+
         bz+4ODf1D3H+dv0Xj9ETU9gku1TrkEVfb0i9l5nmSC5Wd/WXU0BNOhYV+RoXfJhJD8Bq
         CU0o9KyzN4soXlvWsrA79sXbKvSOFkLVveodUOrmKiWv9vLOmjwcDQsBox02K0TZ8AHB
         0eB7AMwMvdo5kXF6+39Duk0vVdXkNEMZmAgfXyVKmJhu+Y9g62ZNolcZKzBxw4YFJEMT
         +7M1ffnAo5p4XiEbYFxKD0Q0D2zKHjAFXlrY3AZTarxPN9pgLSGm6LR4cPFjG0UoYwvH
         5ltw==
X-Gm-Message-State: AOJu0Yyicv66mHgmqtgzyGy/NI78902pMu06BPSwjabVN6syOuIRK2Sc
        q4rZPKNNm7Avk6Oa/OFc34PVBiMG0OhxoDLWe2cRppb1KtE=
X-Google-Smtp-Source: AGHT+IE34GkElrxFcY5JkwPfFMyXCiywAt8LnJLGogO91k/Z5EQjHlqRzKTxxPay08Pse6fYrzg2vDX53XD9Fw+nCEA=
X-Received: by 2002:a05:6214:c29:b0:658:310d:2214 with SMTP id
 a9-20020a0562140c2900b00658310d2214mr6255280qvd.9.1696615463170; Fri, 06 Oct
 2023 11:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231006160437.15627-1-ddrokosov@salutedevices.com> <20231006160437.15627-10-ddrokosov@salutedevices.com>
In-Reply-To: <20231006160437.15627-10-ddrokosov@salutedevices.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 6 Oct 2023 21:03:47 +0300
Message-ID: <CAHp75VcntHXe31H8C9GcGhc+HRA-gZjtD=uibMMYN-FS254RJw@mail.gmail.com>
Subject: Re: [PATCH v1 09/11] leds: aw200xx: improve autodim calculation method
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     lee@kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        kernel@sberdevices.ru, rockosov@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org,
        George Stark <gnstark@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 7:05=E2=80=AFPM Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> From: George Stark <gnstark@salutedevices.com>
>
> use DIV_ROUND_UP instead of coarse div

Please, respect English grammar and punctuation.
Refer to macros and functions as func() (note the parentheses).

...

>  #define AW200XX_REG_DIM2FADE(x) ((x) + 1)
> +#define AW200XX_REG_FADE2DIM(fade) \
> +       DIV_ROUND_UP((fade) * AW200XX_DIM_MAX, AW200XX_FADE_MAX)

Have you checked if the overflow is _now_ possible (compiling on
32-bit platforms as well)?

--=20
With Best Regards,
Andy Shevchenko
