Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F3D7FC1C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346154AbjK1PrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346059AbjK1PrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:47:01 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638D012A;
        Tue, 28 Nov 2023 07:47:05 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6d8029dae41so2712896a34.0;
        Tue, 28 Nov 2023 07:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701186424; x=1701791224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM6IJHXap0cWHVgv8jcH9qHYNny0Fi1EYGKNuvxbiD0=;
        b=TKG9EXwACnvWXmxqmaeooyWGw34+FJIGtPSD/po1VyjFPdfGwHPJiW3Ct5MPyPZQy0
         bTMlQSPKyTB+i2pVjpPtxMQujgMj1a++zKIvM8rJvZpFnbMGHOJtZtC86Ufdm0w0sD6v
         szoiy4ud/1ckVNxtj7fPC/5h0jtUFT8S1M5aSsZdsPgVZzWJ1S+qWUXwAnH1Rh5ViRqV
         GWjx4+o2kOL5HISnuHGSDnPp3uv+bjGlGPGhTV9JxfrIqrCHWqlZbx2rOap5lj3K4oXE
         XzI0EvO6p000GT0k0Cs0Ipe0y6M/wjGE7T3GGtdnrWry771euXIkwSbzZY7KCuUK6PKp
         3Cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701186424; x=1701791224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cM6IJHXap0cWHVgv8jcH9qHYNny0Fi1EYGKNuvxbiD0=;
        b=Z2BghdY0cGMc4T05LZSfragodwg+jo6lmcPJWZRqGzoAHSph7JAZcAD4hnwn8ZnlYq
         IPfUXC/L6PU4kHU9A2eiJtrbyskNw2XYrQTQx3VDsg/GUMJIxWMJwfLSksCKBrXxhN+q
         rqSBrDp5nQDhExeCbHkISWjwgZVnIRHrxIN264+FFpE5Zvw4KmCU00QeQvlYWpNWFcDP
         OA0EUNJDyUtgXANCytKia/UGDorBIwKuj4gv8tPZSYMOVMVF/8HZsXjJ5WyeZ/a5SfaK
         IrU3V5T+mW+FwxudLO5pbSXa8j+/HUD+pIBjzfeWFIz2Y3ljTZooXKEDLmyguZtVict3
         6WPA==
X-Gm-Message-State: AOJu0Yws/TXs3MCv+jIzBtjISKcUFV0CNvFzHrd92LECG+q0ifZiybUW
        O15XUgn8Jhg4eBmwuuQLXX0YT0onN95l7p5kQ0o=
X-Google-Smtp-Source: AGHT+IGyhl5v7GLlbP0U7JzSZav8TWObNwdNZ/p+U+JKJ3cJI+0dp/6n/qDLP+1tW4xvmtotemP04gahFL4htQaUDiM=
X-Received: by 2002:a05:6830:213:b0:6d7:ed0f:87d4 with SMTP id
 em19-20020a056830021300b006d7ed0f87d4mr16552726otb.33.1701186424670; Tue, 28
 Nov 2023 07:47:04 -0800 (PST)
MIME-Version: 1.0
References: <20231125200519.1750-1-ddrokosov@salutedevices.com> <20231125200519.1750-3-ddrokosov@salutedevices.com>
In-Reply-To: <20231125200519.1750-3-ddrokosov@salutedevices.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Nov 2023 17:46:28 +0200
Message-ID: <CAHp75Vfsz6KPgHbttumzngkU2BkDS_6FZ3r4eTENCcML3mYD+Q@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] leds: aw200xx: support HWEN hardware control
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

On Sat, Nov 25, 2023 at 10:05=E2=80=AFPM Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> HWEN is hardware control, which is used for enable/disable aw200xx chip.
> It's high active, internally pulled down to GND.
>
> After HWEN pin set high the chip begins to load the OTP information,
> which takes 200us to complete. About 200us wait time is needed for
> internal oscillator startup and display SRAM initialization. After
> display SRAM initialization, the registers in page 1 to page 5 can be
> configured via i2c interface.

...

> +       chip->hwen =3D devm_gpiod_get_optional(&client->dev, "enable",
> +                                            GPIOD_OUT_HIGH);
> +       if (IS_ERR(chip->hwen))
> +               return dev_err_probe(&client->dev, PTR_ERR(chip->hwen),
> +                                    "Cannot get enable GPIO");

You can make it neater with

  struct device *dev =3D &client->dev;

--=20
With Best Regards,
Andy Shevchenko
