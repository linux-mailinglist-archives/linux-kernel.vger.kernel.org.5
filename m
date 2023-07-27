Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51453764E17
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjG0It2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjG0ItI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:49:08 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C08AD3A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:30:44 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-406bd9ed61cso4543531cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1690446643; x=1691051443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KxKDeGhB87z13po6LxXuIzFixiY+WDAlFjH7VoTTGVU=;
        b=PQ2RtRSUuogkataTfpEtJy9XQNkbMPUNv9pHW+D3P1QZUqvY3Bn7wf+P0uKBNHRWVt
         JSqlEEy3J7/Wq2qXw5DteXYV/3J8k8uwUiHS9miIl3BWgQGcz3t2sc6+DYBIUg6/zJjj
         5x8PS6GctNs9zt33Y0Bw9SifoD1WHHA+99F3bHB5KO9w5cZ3Wrt/KedunIER0BED1mbJ
         B2+7wIeRkQqCtDbdzaXZXFNDPoXsEh17bVCSy4GDqI+Iw3NJwMfK0VKpWR6K+9rR5ONb
         wQ2vmjw06wmuF7BC6/fDIvjp6Phh2H+FgYlJvpbe7m59QWgCWwG9N7JSh5YJ+MrXqdk2
         96Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690446643; x=1691051443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxKDeGhB87z13po6LxXuIzFixiY+WDAlFjH7VoTTGVU=;
        b=EFhKl8OjU/uo/uvtKG12vY7BW17ga3RbnIwr0PJyHGls4BvMAQqX/LvMYXYT16ze2D
         t8nflS445rZzz2I/rgSr+ecXnNDAULlrY4Zpnj88PobMNuAGjVxPFx8Nxbj/DEh2gL3c
         c1VN4C7TECyz0WSVF9Fawkce8a/5EkSO254mfhhyjRlXDERxNOot/1hh4uw4rO2gDfaA
         6NFmJO0xvR9PMQlBvk/eIAsVY9joqXvc8ydX5PFBLEcBnmeqNgNkoNopt6TEm6e7/T18
         emw7Zo225wN/RcoKEu6yxkXuKFjXLpmI3PZ1fF5shPwCFGByOBpkbe7+RvwA6GrrvAb3
         xMsQ==
X-Gm-Message-State: ABy/qLZDp4tQWp0NV1OAXOAVwmlIFLjWAhuC/AJlpsNP9PFODaYd+KaJ
        CUf/huh6fm7BzaJOrN54a/UC/fhpacwKG6XWnEhQ1XVbt0B0jJO/
X-Google-Smtp-Source: APBJJlFoR8XUFrivOlo6cpM/yxSjBjYfgDw6sU3YyKGuTzb2M1/AP/Vwx4FJdOi11UWfvY//oj7ieTNhzE8igFrEhKk=
X-Received: by 2002:a05:620a:2946:b0:767:c16:d202 with SMTP id
 n6-20020a05620a294600b007670c16d202mr5734535qkp.41.1690446643219; Thu, 27 Jul
 2023 01:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230725114030.1860571-1-Naresh.Solanki@9elements.com>
 <20230725114030.1860571-3-Naresh.Solanki@9elements.com> <46f3f44b-5c25-8193-70b5-59303be04ad0@roeck-us.net>
 <331889b5-caf7-ab68-fea2-6566e550d7e8@9elements.com> <a8b53088-70a0-f693-2081-4b9576ac492f@roeck-us.net>
In-Reply-To: <a8b53088-70a0-f693-2081-4b9576ac492f@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 27 Jul 2023 14:00:31 +0530
Message-ID: <CABqG17h8mcdp8t4Zh2=XrvRPQp_862i_pnp0Jx=g8dyftda7oA@mail.gmail.com>
Subject: Re: [PATCH 3/3] hwmon: (pmbus/tda38640) Add workaround for bug in
 SVID mode
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,


On Wed, 26 Jul 2023 at 19:49, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/26/23 05:22, Naresh Solanki wrote:
> > Hi Guenter,
> >
> > On 25-07-2023 07:51 pm, Guenter Roeck wrote:
> >> On 7/25/23 04:40, Naresh Solanki wrote:
> >>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >>>
> >>> The TDA38640 supports two operating modes to set the output voltage:
> >>> - PMBUS
> >>> - SVID
> >>>
> >>> Due to an undocumented bug the regulator cannot be enabled using BIT7
> >>> of OPERATION(01h) register when in SVID mode.
> >>> It works when in PMBUS mode. In SVID mode the regulator only cares
> >>> about the ENABLE pin.
> >>>
> >>> Add a workaround that needs the ENABLE pin to be left floating or
> >>> tied to a fixed level. The DT must contain the newly introduced
> >>> property 'infineon,en-pin-fixed-level' to enable this workaround.
> >>>
> >>
> >> Why is that property even needed ? Isn't the workaround always (and only)
> >> required if the chip is in SVID mode ?
> > Will add below function to detect SVID mode.
> > static bool svid_mode(struct i2c_client *client)
> > {
> >      /* PMBUS_MFR_READ(0xD0) + Address */
> >      u8 write_buf[] = {0xd0, 0x44, 0x00};
> >      u8 read_buf[2];
> >      int ret;
> >
> >      struct i2c_msg msgs[2] = {
> >          {
> >              .addr = client->addr,
> >              .flags = 0,
> >              .buf = write_buf,
> >              .len = sizeof(write_buf),
> >          },
> >          {
> >              .addr = client->addr,
> >              .flags = I2C_M_RD,
> >              .buf = read_buf,
> >              .len = sizeof(read_buf),
> >          }
> >      };
> >
> >      ret = i2c_transfer(client->adapter, msgs, 2);
> >
> drop empty line
Sure
>
> >      if (ret < 0) {
> >          dev_err(&client->dev, "%s:%d i2c_transfer failed. %d", __func__, __LINE__, ret);
> >          return ret;
>
> Return type is bool.
Yes. I've changed it to int so that return value can be validated.
>
> >      }
> >      /* 0x44[15] determines PMBus Operating Mode */
> >      return !!(read_buf[1] & BIT(7));
> > }
> >
>
> "The application note AN_2203_PL12_2204_210835 having information on the register map
>   of TDA38640 is under review. The document will be uploaded to the Infineon website
>   once the review is completed."
>
> How annoying. Is that really the only way to get that information ?
Datasheet does mention MTP register offset 0x44 bit 15 for PMBUS operating mode.
I validated those in my setup which has 4 tda38640 in SVID mode & 7 in
PMBUS mode.
>
> > Based on svid_mode will init accordingly:
> >      if (!IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR) || !np || !svid_mode(client))
> >          return pmbus_do_probe(client, &data->info);
> >
>
> This is unnecessary complexity. Just add the local read/write
> commands and be done with it.
>
>         if (svid_mode(client)) {
>                 data->info.read_byte_data = tda38640_read_byte_data;
>                 data->info.write_byte_data = tda38640_write_byte_data;
>         }
>
> though it would be useful to error check the return value.
>
>         ret = svid_mode();
>         if (ret < 0)
>                 return ret;
>         if (ret) {
>                 /* consider adding comments here */
>                 data->info.read_byte_data = tda38640_read_byte_data;
>                 data->info.write_byte_data = tda38640_write_byte_data;
>         }
Yes. I've updated accordingly.

Regards,
Naresh
>
> Guenter
>
> >      dev_dbg(&client->dev, "SVID mode");
> >
> > Regards,
> > Naresh
> >>
> >> Guenter
> >>
> >>> The workaround will map the PB_OPERATION_CONTROL_ON bit to the
> >>> PB_ON_OFF_CONFIG_EN_PIN_REQ bit of the ON_OFF_CONFIG register.
> >>> In combination with the fixed level on the ENABLE pin the regulator
> >>> can be controlled as expected.
> >>>
> >>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> >>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> >>> ---
> >>>   drivers/hwmon/pmbus/tda38640.c | 95 +++++++++++++++++++++++++++++++++-
> >>>   1 file changed, 93 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/hwmon/pmbus/tda38640.c b/drivers/hwmon/pmbus/tda38640.c
> >>> index 450b0273fb59..9d3b89d9845c 100644
> >>> --- a/drivers/hwmon/pmbus/tda38640.c
> >>> +++ b/drivers/hwmon/pmbus/tda38640.c
> >>> @@ -18,6 +18,72 @@ static const struct regulator_desc __maybe_unused tda38640_reg_desc[] = {
> >>>       PMBUS_REGULATOR("vout", 0),
> >>>   };
> >>> +struct tda38640_data {
> >>> +    struct pmbus_driver_info info;
> >>> +    u32 en_pin_lvl;
> >>> +};
> >>> +
> >>> +#define to_tda38640_data(x)  container_of(x, struct tda38640_data, info)
> >>> +
> >>> +/*
> >>> + * Map PB_ON_OFF_CONFIG_POLARITY_HIGH to PB_OPERATION_CONTROL_ON.
> >>> + */
> >>> +static int tda38640_read_byte_data(struct i2c_client *client, int page, int reg)
> >>> +{
> >>> +    const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> >>> +    struct tda38640_data *data = to_tda38640_data(info);
> >>> +    int ret, on_off_config, enabled;
> >>> +
> >>> +    if (reg != PMBUS_OPERATION)
> >>> +        return -ENODATA;
> >>> +
> >>> +    ret = pmbus_read_byte_data(client, page, reg);
> >>> +    if (ret < 0)
> >>> +        return ret;
> >>> +
> >>> +    on_off_config = pmbus_read_byte_data(client, page,
> >>> +                         PMBUS_ON_OFF_CONFIG);
> >>> +    if (on_off_config < 0)
> >>> +        return on_off_config;
> >>> +
> >>> +    enabled = !!(on_off_config & PB_ON_OFF_CONFIG_POLARITY_HIGH);
> >>> +
> >>> +    enabled ^= data->en_pin_lvl;
> >>> +    if (enabled)
> >>> +        ret &= ~PB_OPERATION_CONTROL_ON;
> >>> +    else
> >>> +        ret |= PB_OPERATION_CONTROL_ON;
> >>> +
> >>> +    return ret;
> >>> +}
> >>> +
> >>> +/*
> >>> + * Map PB_OPERATION_CONTROL_ON to PB_ON_OFF_CONFIG_POLARITY_HIGH.
> >>> + */
> >>> +static int tda38640_write_byte_data(struct i2c_client *client, int page,
> >>> +                    int reg, u8 byte)
> >>> +{
> >>> +    const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> >>> +    struct tda38640_data *data = to_tda38640_data(info);
> >>> +    int enable, ret;
> >>> +
> >>> +    if (reg != PMBUS_OPERATION)
> >>> +        return -ENODATA;
> >>> +
> >>> +    enable = !!(byte & PB_OPERATION_CONTROL_ON);
> >>> +
> >>> +    byte &= ~PB_OPERATION_CONTROL_ON;
> >>> +    ret = pmbus_write_byte_data(client, page, reg, byte);
> >>> +    if (ret < 0)
> >>> +        return ret;
> >>> +
> >>> +    enable ^= data->en_pin_lvl;
> >>> +
> >>> +    return pmbus_update_byte_data(client, page, PMBUS_ON_OFF_CONFIG,
> >>> +                      PB_ON_OFF_CONFIG_POLARITY_HIGH,
> >>> +                      enable ? 0 : PB_ON_OFF_CONFIG_POLARITY_HIGH);
> >>> +}
> >>> +
> >>>   static struct pmbus_driver_info tda38640_info = {
> >>>       .pages = 1,
> >>>       .format[PSC_VOLTAGE_IN] = linear,
> >>> @@ -26,7 +92,6 @@ static struct pmbus_driver_info tda38640_info = {
> >>>       .format[PSC_CURRENT_IN] = linear,
> >>>       .format[PSC_POWER] = linear,
> >>>       .format[PSC_TEMPERATURE] = linear,
> >>> -
> >>>       .func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
> >>>           | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
> >>>           | PMBUS_HAVE_IIN
> >>> @@ -41,7 +106,33 @@ static struct pmbus_driver_info tda38640_info = {
> >>>   static int tda38640_probe(struct i2c_client *client)
> >>>   {
> >>> -    return pmbus_do_probe(client, &tda38640_info);
> >>> +    struct device *dev = &client->dev;
> >>> +    struct device_node *np = dev_of_node(dev);
> >>> +    struct tda38640_data *data;
> >>> +
> >>> +    data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> >>> +    if (!data)
> >>> +        return -ENOMEM;
> >>> +    memcpy(&data->info, &tda38640_info, sizeof(tda38640_info));
> >>> +
> >>> +    if (!CONFIG_SENSORS_TDA38640_REGULATOR || !np ||
> >>> +        of_property_read_u32(np, "infineon,en-pin-fixed-level", &data->en_pin_lvl))
> >>> +        return pmbus_do_probe(client, &data->info);
> >>> +
> >>> +    /*
> >>> +     * Apply ON_OFF_CONFIG workaround as enabling the regulator using the
> >>> +     * OPERATION register doesn't work in SVID mode.
> >>> +     */
> >>> +    data->info.read_byte_data = tda38640_read_byte_data;
> >>> +    data->info.write_byte_data = tda38640_write_byte_data;
> >>> +    /*
> >>> +     * One should configure PMBUS_ON_OFF_CONFIG here, but
> >>> +     * PB_ON_OFF_CONFIG_POWERUP_CONTROL, PB_ON_OFF_CONFIG_EN_PIN_REQ and
> >>> +     * PB_ON_OFF_CONFIG_EN_PIN_REQ are ignored by the device.
> >>> +     * Only PB_ON_OFF_CONFIG_POLARITY_HIGH has an effect.
> >>> +     */
> >>> +
> >>> +    return pmbus_do_probe(client, &data->info);
> >>>   }
> >>>   static const struct i2c_device_id tda38640_id[] = {
> >>
>
