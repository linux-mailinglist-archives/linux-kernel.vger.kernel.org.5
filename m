Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA11377C614
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjHOCqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbjHOCqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:46:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BA8171B;
        Mon, 14 Aug 2023 19:46:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bdc8081147so17229005ad.1;
        Mon, 14 Aug 2023 19:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692067561; x=1692672361;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBQ92kohH7JMrCClRaKPkEsOhf96ZT5UADuYTehrlmU=;
        b=IrYqikNG70bqTMekq6S8AERUH06zWR7D8dR4b1se1DivMCv98aFt60wB0YFS2qGe5F
         FctUoRWZ5IVHWLjwBDqsvzSRcHMuYobDAlqeZ10INv7hVB8A5a6p8Fs+zVIBju2SFpnC
         +7pJuXc8Zc98RvhgUTvMEwjKezCaHHX52beeDkhGEZYGf1ibgM9hR9QRuNXaAcLv/teF
         pPWwVRY3Qo25T9SHagFPmMjk/0sQCXX1gIjUfeXNcq/PyOdOXqL4h86YQ/mnjN7TwAvr
         8yjaWKr6UgXUoj4bMBDRNRNfNvfALfQsKKscx4VOvjqE7MchRvhHT1aOkk0STNzH/m7Y
         dZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692067561; x=1692672361;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wBQ92kohH7JMrCClRaKPkEsOhf96ZT5UADuYTehrlmU=;
        b=Zt4yjhHBzgoyg3vfsUfhFmJ7ARttYsy/usAGc6tdcuIiaqiIP0KGYQ0hk9gSMixCZe
         GYVEn/GWgSRQ7k/bMNBpWoQcIVdoTc8uBn/4IVRv6KTUiEAWD2IZ+92E26hA+2cTqMBA
         nWoxJCcW6xu16laWTdmXaLGNP1RLoPc9aqMFT0G9GLcBx5dFY6DsTOL6ofkuyek8JV4S
         RwLyfbymU42kUmyQLueuNCxR9JNssLHT4hh26L7Sj0BzVB/D2GCb4WsyT5dqagW2ndXt
         YJ82t25eC0hUpJ5Ep2LblVWE8tHqyfzY7y4K3QB/MB+5qtgG36vAIB+FC6ATmx+lwtKd
         El3Q==
X-Gm-Message-State: AOJu0YxX65OVfMs52DGLTlrXk0k4Sj3Ru9KeL1ACcOv0vYKNbbwoFlpd
        bPBcQoCMD3toVEjFMHVqOSs=
X-Google-Smtp-Source: AGHT+IHQ8UZ6DdrRyAirju3lt0PmovMHo8QZvirQPOeY21h6YU4yAN8uyMmHAh7XDW/huVq8TXVsNQ==
X-Received: by 2002:a17:902:ecce:b0:1b0:3ab6:5140 with SMTP id a14-20020a170902ecce00b001b03ab65140mr1132925plh.4.1692067560990;
        Mon, 14 Aug 2023 19:46:00 -0700 (PDT)
Received: from smtpclient.apple ([2401:e180:88a1:80ef:f4f9:717b:5cd:3109])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001bdc9daadc9sm5834170pld.89.2023.08.14.19.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 19:46:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Mining Lin <mimi05633@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 2/2] rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R
Message-Id: <295A0B20-FB6F-4858-8B25-6C5E8357DEBB@gmail.com>
Date:   Tue, 15 Aug 2023 10:45:48 +0800
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        KFLIN@nuvoton.com, mylin1@nuvoton.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
To:     Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: iPhone Mail (20G75)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=EF=BB=BFDear Paul,

Thank you for your comments.
The replies are as follows.

Thanks.
Best regard,
Mia

> On Aug 10, 2023, at 4:16 PM, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>=20
> =EF=BB=BFDear Mia,
>=20
>=20
> Thank you for your patch.
>=20
> It=E2=80=99d be great if you made the commit message summary/title more sp=
ecific. Maybe:
>=20
> Add support for NCT3015Y-R
>=20
> Am 09.08.23 um 11:51 schrieb Mia Lin:
>=20
> An introduction what the NCT3015Y-R is and listing the differences to NCT3=
018Y-R would be nice.
[Mia] I will add more detail. Thank you for your comments.
>=20
>> - In probe,
>> If part number is NCT3018Y-R, only set HF bit to 24-Hour format.
>> Else, do nothing
>> - In set_time,
>> If part number is NCT3018Y-R && TWO bit is 0,
>> change TWO bit to 1, and restore TWO bit after updating time.
>=20
> Why? This also looks unrelated to the NCT3015Y-R support. Could you factor=
 it out into separate patch?
[Mia] The NCT3015Y-R and NCT3018Y-R use the same datasheet but have differen=
t topologies.
Therefore, the settings here are to set according to different models to mat=
ch the behavior of each chip.
>=20
>> - Use DT compatible to check the chip matches or not.
>=20
> Could you please add the datasheet name and revision?
[Mia] Use DT compatible to check does not make sense. I will remove it.
>=20
>> Signed-off-by: Mia Lin <mimi05633@gmail.com>
>> ---
>> drivers/rtc/rtc-nct3018y.c | 88 +++++++++++++++++++++++++++++++++-----
>> 1 file changed, 78 insertions(+), 10 deletions(-)
>> diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
>> index a4e3f924837e..edc73be3ab59 100644
>> --- a/drivers/rtc/rtc-nct3018y.c
>> +++ b/drivers/rtc/rtc-nct3018y.c
>> @@ -7,6 +7,7 @@
>> #include <linux/i2c.h>
>> #include <linux/module.h>
>> #include <linux/of.h>
>> +#include <linux/of_device.h>
>> #include <linux/rtc.h>
>> #include <linux/slab.h>
>> @@ -23,6 +24,7 @@
>> #define NCT3018Y_REG_CTRL    0x0A /* timer control */
>> #define NCT3018Y_REG_ST        0x0B /* status */
>> #define NCT3018Y_REG_CLKO    0x0C /* clock out */
>> +#define NCT3018Y_REG_PART    0x21 /* part info */
>> #define NCT3018Y_BIT_AF        BIT(7)
>> #define NCT3018Y_BIT_ST        BIT(7)
>> @@ -37,6 +39,20 @@
>> #define NCT3018Y_REG_BAT_MASK        0x07
>> #define NCT3018Y_REG_CLKO_F_MASK    0x03 /* frequenc mask */
>> #define NCT3018Y_REG_CLKO_CKE        0x80 /* clock out enabled */
>> +#define NCT3018Y_REG_PART_NCT3015Y    0x01
>> +#define NCT3018Y_REG_PART_NCT3018Y    0x02
>> +
>> +struct rtc_data {
>> +    u8 part_number;
>> +};
>> +
>> +static const struct rtc_data nct3015y_rtc_data =3D {
>> +    .part_number =3D NCT3018Y_REG_PART_NCT3015Y,
>> +};
>> +
>> +static const struct rtc_data nct3018y_rtc_data =3D {
>> +    .part_number =3D NCT3018Y_REG_PART_NCT3018Y,
>> +};
>> struct nct3018y {
>>  struct rtc_device *rtc;
>> @@ -52,7 +68,7 @@ static int nct3018y_set_alarm_mode(struct i2c_client *c=
lient, bool on)
>>    dev_dbg(&client->dev, "%s:on:%d\n", __func__, on);
>> -    flags =3D  i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
>> +    flags =3D i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
>>  if (flags < 0) {
>>      dev_dbg(&client->dev,
>>          "Failed to read NCT3018Y_REG_CTRL\n");
>> @@ -109,8 +125,10 @@ static int nct3018y_get_alarm_mode(struct i2c_client=
 *client, unsigned char *ala
>>      *alarm_flag =3D flags & NCT3018Y_BIT_AF;
>>  }
>> -    dev_dbg(&client->dev, "%s:alarm_enable:%x alarm_flag:%x\n",
>> -        __func__, *alarm_enable, *alarm_flag);
>> +    if (alarm_enable && alarm_flag) {
>> +        dev_dbg(&client->dev, "%s:alarm_enable:%x alarm_flag:%x\n",
>> +            __func__, *alarm_enable, *alarm_flag);
>> +    }
>=20
> The two hunks look like unrelated fixes. It=E2=80=99d be great, if you fac=
tored those out into a separate patch.
[Mia] I will factor it out into a separate patch.
>=20
>>    return 0;
>> }
>> @@ -178,7 +196,30 @@ static int nct3018y_rtc_set_time(struct device *dev,=
 struct rtc_time *tm)
>> {
>>  struct i2c_client *client =3D to_i2c_client(dev);
>>  unsigned char buf[4] =3D {0};
>> -    int err;
>> +    int err, part_num, flags, restore_flags =3D 0;
>=20
> Why is err now initialized to 0?
[Mia] I will refine it.
>=20
>> +    part_num =3D i2c_smbus_read_byte_data(client, NCT3018Y_REG_PART);
>> +    if (part_num < 0) {
>> +        dev_dbg(&client->dev, "%s: read error\n", __func__);
>> +        return part_num;
>> +    }
>> +
>> +    flags =3D i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
>> +    if (flags < 0) {
>> +        dev_dbg(&client->dev, "%s: read error\n", __func__);
>=20
> Could you make these distinct error messages, so users are able to pinpoin=
t the correct location right away? (Or does `dev_dbg` already provide that i=
nformation? Maybe the line? (Also more cases below.)
[Mia] I will refine error messages. Thank you.
>=20
>> +        return flags;
>> +    }
>> +
>> +    /* Check and set TWO bit */
>> +    if ((part_num & NCT3018Y_REG_PART_NCT3018Y) && !(flags & NCT3018Y_BI=
T_TWO)) {
>> +        restore_flags =3D 1;
>> +        flags |=3D NCT3018Y_BIT_TWO;
>> +        err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, fla=
gs);
>> +        if (err < 0) {
>> +            dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n")=
;
>> +            return err;
>> +        }
>> +    }
>>    buf[0] =3D bin2bcd(tm->tm_sec);
>>  err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_SC, buf[0]);
>> @@ -212,6 +253,18 @@ static int nct3018y_rtc_set_time(struct device *dev,=
 struct rtc_time *tm)
>>      return -EIO;
>>  }
>> +    /* Restore TWO bit */
>> +    if (restore_flags) {
>> +        if (part_num & NCT3018Y_REG_PART_NCT3018Y)
>> +            flags &=3D ~NCT3018Y_BIT_TWO;
>> +
>> +        err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, fla=
gs);
>> +        if (err < 0) {
>> +            dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n")=
;
>> +            return err;
>> +        }
>> +    }
>> +
>>  return err;
>> }
>> @@ -456,6 +509,7 @@ static int nct3018y_probe(struct i2c_client *client)
>> {
>>  struct nct3018y *nct3018y;
>>  int err, flags;
>> +    const struct rtc_data *data =3D of_device_get_match_data(&client->de=
v);
>>    if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
>>                   I2C_FUNC_SMBUS_BYTE |
>> @@ -479,11 +533,24 @@ static int nct3018y_probe(struct i2c_client *client=
)
>>      dev_dbg(&client->dev, "%s: NCT3018Y_BIT_TWO is set\n", __func__);
>>  }
>> -    flags =3D NCT3018Y_BIT_TWO;
>> -    err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);=

>> -    if (err < 0) {
>> -        dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
>> -        return err;
>> +    flags =3D i2c_smbus_read_byte_data(client, NCT3018Y_REG_PART);
>> +    if (flags < 0) {
>> +        dev_dbg(&client->dev, "%s: read error\n", __func__);
>> +        return flags;
>> +    } else if (flags & NCT3018Y_REG_PART_NCT3018Y) {
>> +        if (!(flags & data->part_number))
>> +            dev_warn(&client->dev, "%s: part_num=3D0x%x but NCT3018Y_REG=
_PART=3D0x%x\n",
>> +                 __func__, data->part_number, flags);
>> +        flags =3D NCT3018Y_BIT_HF;
>> +        err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, fla=
gs);
>> +        if (err < 0) {
>> +            dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n")=
;
>> +            return err;
>> +        }
>> +    } else if (flags & NCT3018Y_REG_PART_NCT3015Y) {
>> +        if (!(flags & data->part_number))
>> +            dev_warn(&client->dev, "%s: part_num=3D0x%x but NCT3018Y_REG=
_PART=3D0x%x\n",
>> +                 __func__, data->part_number, flags);
>>  }
>>    flags =3D 0;
>> @@ -530,7 +597,8 @@ static const struct i2c_device_id nct3018y_id[] =3D {=

>> MODULE_DEVICE_TABLE(i2c, nct3018y_id);
>> static const struct of_device_id nct3018y_of_match[] =3D {
>> -    { .compatible =3D "nuvoton,nct3018y" },
>> +    { .compatible =3D "nuvoton,nct3015y", .data =3D &nct3015y_rtc_data }=
,
>> +    { .compatible =3D "nuvoton,nct3018y", .data =3D &nct3018y_rtc_data }=
,
>>  {}
>> };
>> MODULE_DEVICE_TABLE(of, nct3018y_of_match);
>=20
>=20
> Kind regards,
>=20
> Paul
