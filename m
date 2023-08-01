Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D6576B4DB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjHAMfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjHAMfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:35:04 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1628F1FC9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 05:35:02 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68730bafa6bso1504138b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 05:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1690893301; x=1691498101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VHSVdPgjixCyawH/oxZHoDJ8XeN+UtODsgWA/Uc7BmY=;
        b=EFEk4h1zbBmJb+3eXBDeDCdCNlcL1jhBIBmyWqCdHdAYg0ISJZzBZ4k3H/40+PSSXm
         R/zr34I4pB3cHxPnzHaSl0wcG/N0rj3eDmhphCIeJRjqtNqJpUt4M89z60sxo6XcAZDf
         i1UCJ1KvvCIT0kvvyJoRMxMjMX3vz6bR9u5+KBS6XN7ZLG0YOxzwEAlb3G6uUyWVrRsb
         ISy/IXDa24SEu9WcTnnlUO3fXFgdCnqbhMrFiAY1+uq5G1Vanvktcz8ysG0iye/kEu4B
         fih5Kr/bYcXDag4NmSPXS/CfqsYpujxxXG0Hj6mIgqhEZS5nsA3QsRNmjcFAzv7j2RSq
         GiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690893301; x=1691498101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHSVdPgjixCyawH/oxZHoDJ8XeN+UtODsgWA/Uc7BmY=;
        b=Sg+r47J97bqr1SW8vWtQi/AF4j9ObWH9zS0IRLcehl97TzbHF/XstlrEhCXSl+7RD8
         XVjinJIpY5J4j8COzN4OVdkCl8b42idwdHb5zcDNY7AHm12kaQUvspSjOjLeZ1avQSfY
         ZVmbQKgjJ7OZHErJoUTsgeQtSS7GudfICW13vmjfTJFaD1LResc5Fh9txzCQQtqXO5PO
         t9Iuv2HHNlYLM0XCwMORlt1FtYTW7qReEjuT3U+miaTlzHycqXLW4BX9c64FrMbqYc32
         kU4CJf5ZsFLWnvjSgT4OhEL9dy3w0n5tmDBlMYhxJcdu6zV97tD9KCYNFcwzFGe/qVNK
         2CEw==
X-Gm-Message-State: ABy/qLbQYVZ90ODSNsIwlHPoBrYm6WyhJZNVb2ojMgPE3HwavjQN2vVk
        ur4rVvp72exNT1jGr1XFs7YsVUGK+yaqOAy3wnqFSA==
X-Google-Smtp-Source: APBJJlGdtHt3O0jwPOTO/pweA/Fhhb9oRqDA0o4vmbf2AhycKP5/jabv0FPFWl6mf2OYZyDNT/0ucis1tkbgiMgUuqg=
X-Received: by 2002:a17:90b:3b8d:b0:268:e3d:1251 with SMTP id
 pc13-20020a17090b3b8d00b002680e3d1251mr15515134pjb.20.1690893301467; Tue, 01
 Aug 2023 05:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230727091358.3274620-1-Naresh.Solanki@9elements.com>
 <20230727091358.3274620-2-Naresh.Solanki@9elements.com> <41a8ae4b-0f96-9f26-f25b-b1554b2695d6@roeck-us.net>
In-Reply-To: <41a8ae4b-0f96-9f26-f25b-b1554b2695d6@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Tue, 1 Aug 2023 18:04:51 +0530
Message-ID: <CABqG17jKoJ8FJdA-vpX8uda9yi_ir3f2FxFAiE7GTaVM7Mb2aA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hwmon: (pmbus/tda38640) Add workaround for bug in
 SVID mode
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Thu, 27 Jul 2023 at 22:46, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/27/23 02:13, Naresh Solanki wrote:
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > Introduce a workaround to handle the issue where the regulator cannot be
> > enabled using BIT7 of the OPERATION(01h) register when in SVID mode.
> >
> > It works when in PMBUS mode. In SVID mode the regulator only cares
> > about the ENABLE pin.
> >
> > Determine if chip is in SVID mode by checking BIT15 of MTP memory offset
> > 0x44 as described in the datasheet.
> >
> > If chip is in SVID mode then apply the workaround by
> > 1. Determine EN pin level
> > 2. Maps BIT7 of OPERATION(01h) to EN_PIN_POLARITY(BIT1) of
> >     PB_ON_OFF_CONFIG.
> >
> > Tested working of TDA38640 in both SVID & PMBus mode.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > ----
> > Changes in V2:
> > - Remove dependency on DT propery,
> > - Runtime determine SVID mode & ENABLE pin level,
> > - Update commit message.
> > ---
> >   drivers/hwmon/pmbus/tda38640.c | 151 ++++++++++++++++++++++++++++++++-
> >   1 file changed, 149 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hwmon/pmbus/tda38640.c b/drivers/hwmon/pmbus/tda38640.c
> > index 450b0273fb59..daaf77f8bf82 100644
> > --- a/drivers/hwmon/pmbus/tda38640.c
> > +++ b/drivers/hwmon/pmbus/tda38640.c
> > @@ -18,6 +18,127 @@ static const struct regulator_desc __maybe_unused tda38640_reg_desc[] = {
> >       PMBUS_REGULATOR("vout", 0),
> >   };
> >
> > +struct tda38640_data {
> > +     struct pmbus_driver_info info;
> > +     u32 en_pin_lvl;
> > +};
> > +
> > +#define to_tda38640_data(x)  container_of(x, struct tda38640_data, info)
> > +
> > +/*
> > + * Map PB_ON_OFF_CONFIG_POLARITY_HIGH to PB_OPERATION_CONTROL_ON.
> > + */
> > +static int tda38640_read_byte_data(struct i2c_client *client, int page, int reg)
> > +{
> > +     const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> > +     struct tda38640_data *data = to_tda38640_data(info);
> > +     int ret, on_off_config, enabled;
> > +
> > +     if (reg != PMBUS_OPERATION)
> > +             return -ENODATA;
> > +
> > +     ret = pmbus_read_byte_data(client, page, reg);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     on_off_config = pmbus_read_byte_data(client, page,
> > +                                          PMBUS_ON_OFF_CONFIG);
> > +     if (on_off_config < 0)
> > +             return on_off_config;
> > +
> > +     enabled = !!(on_off_config & PB_ON_OFF_CONFIG_POLARITY_HIGH);
> > +
> > +     enabled ^= data->en_pin_lvl;
> > +     if (enabled)
> > +             ret &= ~PB_OPERATION_CONTROL_ON;
> > +     else
> > +             ret |= PB_OPERATION_CONTROL_ON;
> > +
> > +     return ret;
> > +}
> > +
> > +/*
> > + * Map PB_OPERATION_CONTROL_ON to PB_ON_OFF_CONFIG_POLARITY_HIGH.
> > + */
> > +static int tda38640_write_byte_data(struct i2c_client *client, int page,
> > +                                 int reg, u8 byte)
> > +{
> > +     const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> > +     struct tda38640_data *data = to_tda38640_data(info);
> > +     int enable, ret;
> > +
> > +     if (reg != PMBUS_OPERATION)
> > +             return -ENODATA;
> > +
> > +     enable = !!(byte & PB_OPERATION_CONTROL_ON);
> > +
> > +     byte &= ~PB_OPERATION_CONTROL_ON;
> > +     ret = pmbus_write_byte_data(client, page, reg, byte);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     enable ^= data->en_pin_lvl;
> > +
> > +     return pmbus_update_byte_data(client, page, PMBUS_ON_OFF_CONFIG,
> > +                                   PB_ON_OFF_CONFIG_POLARITY_HIGH,
> > +                                   enable ? 0 : PB_ON_OFF_CONFIG_POLARITY_HIGH);
> > +}
> > +
> > +static int svid_mode(struct i2c_client *client, struct tda38640_data *data)
> > +{
> > +     /* PMBUS_MFR_READ(0xD0) + MTP Address offset */
> > +     u8 write_buf[] = {0xd0, 0x44, 0x00};
> > +     u8 read_buf[2];
> > +     int ret, svid;
> > +     bool off, reg_en_pin_pol;
> > +
> > +     struct i2c_msg msgs[2] = {
> > +             {
> > +                     .addr = client->addr,
> > +                     .flags = 0,
> > +                     .buf = write_buf,
> > +                     .len = sizeof(write_buf),
> > +             },
> > +             {
> > +                     .addr = client->addr,
> > +                     .flags = I2C_M_RD,
> > +                     .buf = read_buf,
> > +                     .len = sizeof(read_buf),
> > +             }
> > +     };
> > +
> > +     ret = i2c_transfer(client->adapter, msgs, 2);
> > +     if (ret < 0) {
> > +             dev_err(&client->dev, "i2c_transfer failed. %d", ret);
> > +             return ret;
> > +     }
> > +
> > +     /*
> > +      * 0x44[15] determines PMBus Operating Mode
> > +      * If bit is set then it is SVID mode.
> > +      */
> > +     svid = !!(read_buf[1] & BIT(7));
> > +
> > +     /*
> > +      * Determine EN pin level for use in SVID mode.
> > +      * This is done with help of STATUS_BYTE bit 6(OFF) & ON_OFF_CONFIG bit 2(EN pin polarity).
> > +      */
> > +     if (svid) {
> > +             ret = i2c_smbus_read_byte_data(client, PMBUS_STATUS_BYTE);
> > +             if (ret < 0)
> > +                     return ret;
> > +             off = !!(ret & PB_STATUS_OFF);
> > +
> > +             ret = i2c_smbus_read_byte_data(client, PMBUS_ON_OFF_CONFIG);
> > +             if (ret < 0)
> > +                     return ret;
> > +             reg_en_pin_pol = !!(ret & PB_ON_OFF_CONFIG_POLARITY_HIGH);
> > +             data->en_pin_lvl = off ^ reg_en_pin_pol;
> > +     }
> > +
> > +     return svid;
> > +}
> > +
> >   static struct pmbus_driver_info tda38640_info = {
> >       .pages = 1,
> >       .format[PSC_VOLTAGE_IN] = linear,
> > @@ -26,7 +147,6 @@ static struct pmbus_driver_info tda38640_info = {
> >       .format[PSC_CURRENT_IN] = linear,
> >       .format[PSC_POWER] = linear,
> >       .format[PSC_TEMPERATURE] = linear,
> > -
> >       .func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
> >           | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
> >           | PMBUS_HAVE_IIN
> > @@ -41,7 +161,34 @@ static struct pmbus_driver_info tda38640_info = {
> >
> >   static int tda38640_probe(struct i2c_client *client)
> >   {
> > -     return pmbus_do_probe(client, &tda38640_info);
> > +     struct tda38640_data *data;
> > +     int svid;
> > +
> > +     data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> > +     if (!data)
> > +             return -ENOMEM;
> > +     memcpy(&data->info, &tda38640_info, sizeof(tda38640_info));
> > +
> > +     svid = svid_mode(client, data);
> > +     if (svid < 0) {
> > +             dev_err_probe(&client->dev, svid, "Could not determine operating mode.");
> > +             return svid;
> > +     }
> > +
> > +     if (IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR) || svid) {
>
> If you hide this behind IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR), reading
> svid outside the if() statement has no value.
svid mode check is needed only when regulator is enabled for on/off
control later.
Will align the code such that if svid_mode check is done only when
REGULATOR config is enabled
& if it is in svid mode then apply the WA.

>
> > +             /*
> > +              * Apply ON_OFF_CONFIG workaround as enabling the regulator using the
> > +              * OPERATION register doesn't work in SVID mode.
> > +              *
> > +              * One should configure PMBUS_ON_OFF_CONFIG here, but
> > +              * PB_ON_OFF_CONFIG_POWERUP_CONTROL and PB_ON_OFF_CONFIG_EN_PIN_REQ
> > +              * are ignored by the device.
> > +              * Only PB_ON_OFF_CONFIG_POLARITY_HIGH has an effect.
>
> Hmm, maybe I start to understand. This is really weird, since it changes
> the polarity of the EN input pin, effectively reverting its value.
> In other words, what really happens is that it is not possible to disable
> the chip with PMBUS_ON_OFF_CONFIG in SVID mode, and that reverting
> the EN pin polarity effectively simulates turning the chip on or off by
> software. Maybe software enable is disabled on purpose in VID mode.
> Is that really a bug or is it a feature, and is it really a good idea to
> override it ?
By design, SVID mode only has HW control enabled.
This was with the assumption that PGOOD will be used for controlling
Enable of another rail in Hardware.

Since my use case needs the complete PMBUS based control,
EN pin polarity flipping can be used for controlling output.

>
> AN_2203_PL12_2204_184108 might really help here.
>
> Guenter
>
> > +              */
> > +             data->info.read_byte_data = tda38640_read_byte_data;
> > +             data->info.write_byte_data = tda38640_write_byte_data;
> > +     }
> > +     return pmbus_do_probe(client, &data->info);
> >   }
> >
> >   static const struct i2c_device_id tda38640_id[] = {
>
