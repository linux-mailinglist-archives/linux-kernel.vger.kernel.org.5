Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4887F013E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 17:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjKRQ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 11:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRQ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 11:58:35 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E904E5;
        Sat, 18 Nov 2023 08:58:32 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9ca471cf3aso2890272276.2;
        Sat, 18 Nov 2023 08:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700326711; x=1700931511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+puumHBwG15d9J6rc0y92l94G1vv6CAlOkN6zqMuV0=;
        b=OyHHTfN8OWCfVHTs3YJzi+i1odxmjrMdY+RIhzxNdrJwC2V2/qFaYl7GJ2MRXM8w+R
         8UoUivcBOhVLsG26KadiRR9OF1SRRfJXrLBiIvCR1TnrxD503gRJhVR6BzsA7gl73sLa
         jCpwYuqT6rjkJuw9wMaE5POFJ/UptMjwxJcGqQzlwGKNAAEZUQQhCZlCVgf4pv1fkJ8o
         SXQntDUx4t5wOcTCKwHeQqoe3n7+s/m/SZgRcvG3+/9MMb/HHlHUZ1+ObBBWtB5P0vcA
         /dWEj4vIgQp4crj7nU9N0eViRgLoGz7wPC+j+AYsjUfb65dNLPClcuZ6GBKAtXZTXKZ0
         7IgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700326711; x=1700931511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+puumHBwG15d9J6rc0y92l94G1vv6CAlOkN6zqMuV0=;
        b=T7pODJQ0eDykD25pVybO8Y23TFgijDqvTHgDTg3Wxyp5anr5LAN6xBLSz/RF9Y7aJT
         kwIXaMQDR6hoJJ7xeZNVLytWVdaj+PoAjwraM0nJHVEJ51VRoWdR1eaIGzwApGgAxIAQ
         bSIY+ylZa2kvFwNsTaXOoVrJHjQZKfujExSye20KxgFFcKP56NW5Iqsikisg+32WwmbP
         loxQOLGeW0Is8p1RYOncThLJbaoaeLAxLZ6tJPsFq9LBMlA72BVF2OgJMj4gLIODsPK9
         RQOfteANGgaSdhJplMP9s3XASTbEsDC8FEQqaEhrCFsFDLBkeX8Qf3zNoXBOmC46oJ/L
         vhMQ==
X-Gm-Message-State: AOJu0YwOU4Y7BqzMhipM/oF7SVHCJHcNjfUPyYxUCfKpGxaQRbIsjMwr
        nJVeFILekce/HE53IAxgM5VVjU1BcQ/8wrRFFek=
X-Google-Smtp-Source: AGHT+IEiHHassuObi4T4IbCqGNK6bxkEISXFCSXcgm/rvOZinGs4+1EcvnBaloGDhAB8ee7sFndHInenrYwiqxcNN2M=
X-Received: by 2002:a25:dbc5:0:b0:db0:2f97:8757 with SMTP id
 g188-20020a25dbc5000000b00db02f978757mr2705194ybf.38.1700326711409; Sat, 18
 Nov 2023 08:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20231101142445.8753-1-ddrokosov@salutedevices.com>
In-Reply-To: <20231101142445.8753-1-ddrokosov@salutedevices.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 18 Nov 2023 18:57:55 +0200
Message-ID: <CAHp75Vffji=WH8_vTwrvhmPqwD=NjqHB2B83dSk0axSWM9vTnA@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] leds: aw200xx: several driver updates
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     lee@kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        kernel@sberdevices.ru, rockosov@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
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

On Wed, Nov 1, 2023 at 4:24=E2=80=AFPM Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> The following patch series includes several updates for the AW200XX LED
> driver:
>     - some small fixes and optimizations to the driver implementation:
>       delays, autodimming calculation, disable_locking regmap flag,
>       display_rows calculation in runtime;
>     - fix LED device tree node pattern to accept LED names counting not
>       only from 0 to f;
>     - add missing reg constraints;
>     - support HWEN hardware control, which allows enabling or disabling
>       AW200XX RTL logic from the main SoC using a GPIO pin;
>     - introduce the new AW20108 LED controller, the datasheet for this
>       controller can be found at [1].

For non device tree binding patches
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
One nit I commented on the individual patch.

--=20
With Best Regards,
Andy Shevchenko
