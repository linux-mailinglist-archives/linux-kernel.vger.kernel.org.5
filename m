Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121B47AD6A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjIYLF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIYLFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:05:52 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7193AB;
        Mon, 25 Sep 2023 04:05:45 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-49040dc5cedso1938697e0c.3;
        Mon, 25 Sep 2023 04:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695639945; x=1696244745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jl5w+wm2h45lPbVYf6Ll8mepBi7Pv/QtvC3mEzScBhI=;
        b=CuJ+4H4pk8Lzuvd7bX7ZpdN8A4QUn6BRx1ZGZe6Bsd+ftn1hP/lTxPPFuc/1WDjdlM
         22UY03PxpBM+aBw/e05e+EUDSM79dzEKC9EFrC/jrB6Jpl9g4mNbGMgx+xV3vOWAjKEN
         eoRAem/3+bYMN8M6tXceyoKK8iCn5bqdAtqVFtu2bG0o6AaLB5XKfU6X8CWWXr2XFU39
         Mi6eihmXGVo062hj0tLd5CpxrJ1mCXws2wIIBkRLb4CsggwbMV5vhUjRo+KtsPaPC7VN
         0Xjd/GYp/Lw+1GuEPoxGo4roJeZrNf3olOlSTATTB4uOX9h0nbf+02mf0DOLYKM/7bXT
         z6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695639945; x=1696244745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jl5w+wm2h45lPbVYf6Ll8mepBi7Pv/QtvC3mEzScBhI=;
        b=O62EhVTUN40L/7XCxmHwlkLfPaZjCGt9s5bPyqTk1AD8nTWEhPUxulsCsAyK+j1vCM
         vUvvC8vvS99o6QfEg3fGVRL+4wb8jGwIkcWqbFtN4LIWDpe4Bx4Ed5et72a7RVbTy6cP
         1Ie1g+r2Ag+MJTS6fiRWftQcZEYBMVL3KFQDANVUa6KHeQ6i9bM3mCqbQld055JpS+/b
         xFZBeYAMSUQkwbt6iDpr/uwc2tGy3MZ4M9xsoYnRbcRMimiDA70vR94tIrd03uiFYEoM
         UNmjzGZ84IIsyF4JRGL1Bvaxp8tQQ+pVCC7Ew/QRfpkft7Q9bnph+PExYbc11xzy7g7F
         a41w==
X-Gm-Message-State: AOJu0YzcnHrzT5zxRKeY7h1izTM6qTrYjWRgUrICmS+vMpDxpf7iaE+O
        IT5az4UooJpmtfGBqQiE4yOi7xY7j+DE5PQNZYA=
X-Google-Smtp-Source: AGHT+IHJFJ+CWx4Nr7N6iOlyC0jmEVz+54mGF9hHsv0FXf0duztogjizfTN6PlAZZ9dqWCGsM7NB3DEl5kpMWXJ3Th4=
X-Received: by 2002:a05:6122:46a4:b0:49a:3d72:fe89 with SMTP id
 di36-20020a05612246a400b0049a3d72fe89mr949650vkb.14.1695639944795; Mon, 25
 Sep 2023 04:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221026114908.191472-1-alistair@alistair23.me> <20221026114908.191472-2-alistair@alistair23.me>
In-Reply-To: <20221026114908.191472-2-alistair@alistair23.me>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Mon, 25 Sep 2023 05:05:32 -0600
Message-ID: <CADvTj4pdSkg5RWGThmj8Z_gOL5g2Ovhvfc-XtYTU88_0ve4NPw@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] Input: Add driver for Cypress Generation 5 touchscreen
To:     Alistair Francis <alistair@alistair23.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, dmitry.torokhov@gmail.com, shawnguo@kernel.org,
        rydberg@bitmath.org, alistair23@gmail.com, s.hauer@pengutronix.de,
        andreas@kemnade.info, Maxime Ripard <maxime.ripard@bootlin.com>,
        =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>,
        Peter Geis <pgwipeout@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 6:05=E2=80=AFAM Alistair Francis <alistair@alistair=
23.me> wrote:
>
> This is the basic driver for the Cypress TrueTouch Gen5 touchscreen
> controllers. This driver supports only the I2C bus but it uses regmap
> so SPI support could be added later.
> The touchscreen can retrieve some defined zone that are handled as
> buttons (according to the hardware). That is why it handles
> button and multitouch events.
>
> Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Tested-by: Andreas Kemnade <andreas@kemnade.info> # Kobo Clara HD
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  drivers/input/touchscreen/Kconfig   |  16 +
>  drivers/input/touchscreen/Makefile  |   1 +
>  drivers/input/touchscreen/cyttsp5.c | 902 ++++++++++++++++++++++++++++
>  3 files changed, 919 insertions(+)
>  create mode 100644 drivers/input/touchscreen/cyttsp5.c
>
> +
> +static int cyttsp5_hid_output_bl_launch_app(struct cyttsp5 *ts)
> +{
> +       int rc;
> +       u8 cmd[HID_OUTPUT_BL_LAUNCH_APP];
> +       u16 crc;
> +
> +       put_unaligned_le16(HID_OUTPUT_BL_LAUNCH_APP_SIZE, cmd);
> +       cmd[2] =3D HID_BL_OUTPUT_REPORT_ID;
> +       cmd[3] =3D 0x0; /* Reserved */
> +       cmd[4] =3D HID_OUTPUT_BL_SOP;
> +       cmd[5] =3D HID_OUTPUT_BL_LAUNCH_APP;
> +       put_unaligned_le16(0x00, &cmd[6]);
> +       crc =3D crc_itu_t(0xFFFF, &cmd[4], 4);
> +       put_unaligned_le16(crc, &cmd[8]);
> +       cmd[10] =3D HID_OUTPUT_BL_EOP;
> +
> +       rc =3D cyttsp5_write(ts, HID_OUTPUT_REG, cmd,
> +                          HID_OUTPUT_BL_LAUNCH_APP_SIZE);
> +       if (rc) {
> +               dev_err(ts->dev, "Failed to write command %d", rc);
> +               return rc;
> +       }
> +
> +       rc =3D wait_for_completion_interruptible_timeout(&ts->cmd_done,
> +                                               msecs_to_jiffies(CY_HID_O=
UTPUT_TIMEOUT_MS));
> +       if (rc <=3D 0) {
> +               dev_err(ts->dev, "HID output cmd execution timed out\n");
> +               rc =3D -ETIMEDOUT;
> +               return rc;
> +       }

I've been seeing this timeout error somewhat randomly on a Variscite i.MX6
QUAD/DUAL VAR-SOM-MX6 Custom Board based device at startup:

[    2.234089] cyttsp5 2-0024: HID output cmd execution timed out
[    2.239957] cyttsp5 2-0024: Error on launch app r=3D-110
[    2.245150] cyttsp5 2-0024: Fail initial startup r=3D-110
[    2.257502] cyttsp5: probe of 2-0024 failed with error -110

When it doesn't error I just see this:

[    2.061176] input: cyttsp5 as
/devices/platform/soc/2100000.bus/21a8000.i2c/i2c-2/2-0024/input/input0

I'm not sure if this is a driver issue or potentially a device tree issue, =
the
upstream kernel device tree node looks like this:

touchscreen@24 {
    compatible =3D "cypress,tt21000";
    reg =3D <0x24>;
    interrupt-parent =3D <&gpio3>;
    interrupts =3D <7 IRQ_TYPE_EDGE_FALLING>;
    reset-gpios =3D <&gpio5 13 GPIO_ACTIVE_LOW>;
    vdd-supply =3D <&reg_3p3v>;
    touchscreen-size-x =3D <880>;
    touchscreen-size-y =3D <1280>;
};

Full device tree here:
https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/tree/arc=
h/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts?h=3Dfor-next

The original vendor device tree node for the downstream kernel looked like =
this:
tsc@0x24 {
    compatible =3D "cy,cyttsp5_i2c_adapter";
    reg =3D <0x24>;
    interrupts =3D <0x07 0x02>;
    interrupt-parent =3D <0x07>;
    cy,adapter_id =3D "cyttsp5_i2c_adapter";

    cy,core {
        cy,name =3D "cyttsp5_core";

        cy,irq_gpio =3D <71>;
        cy,rst_gpio =3D <141>;
        cy,hid_desc_register =3D <0x01>;
        /* CY_CORE_FLAG_RESTORE_PARAMETERS */
        cy,flags =3D <4>;
        /* CY_CORE_EWG_NONE */
        cy,easy_wakeup_gesture =3D <0>;
        cy,btn_keys-tag =3D <0>;

        cy,mt {
            cy,name =3D "cyttsp5_mt";

            cy,inp_dev_name =3D "cyttsp5_mt";
            /* CY_MT_FLAG_NONE */
            cy,flags =3D <0x00>;
            cy,abs =3D
                /* ABS_MT_POSITION_X, CY_ABS_MIN_X, CY_ABS_MAX_X, 0, 0 */
                <0x35 0 880 0 0
                /* ABS_MT_POSITION_Y, CY_ABS_MIN_Y, CY_ABS_MAX_Y, 0, 0 */
                0x36 0 1280 0 0
                /* ABS_MT_PRESSURE, CY_ABS_MIN_P, CY_ABS_MAX_P, 0, 0 */
                0x3a 0 255 0 0
                /* CY_IGNORE_VALUE, CY_ABS_MIN_W, CY_ABS_MAX_W, 0, 0 */
                0xffff 0 255 0 0
                /* ABS_MT_TRACKING_ID, CY_ABS_MIN_T, CY_ABS_MAX_T, 0, 0 */
                0x39 0 15 0 0
                /* ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0 */
                0x30 0 255 0 0
                /* ABS_MT_TOUCH_MINOR, 0, 255, 0, 0 */
                0x31 0 255 0 0
                /* ABS_MT_ORIENTATION, -127, 127, 0, 0 */
                0x34 0xffffff81 127 0 0
                /* ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX, 0, 0 */
                0x37 0 1 0 0
                /* ABS_MT_DISTANCE, 0, 255, 0, 0 */
                0x3b 0 255 0 0>;
        };
    };
};
