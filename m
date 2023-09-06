Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDF679334D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 03:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbjIFBTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 21:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjIFBTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 21:19:46 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAB3EB;
        Tue,  5 Sep 2023 18:19:42 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bd066b0fd4so2045563a34.2;
        Tue, 05 Sep 2023 18:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693963181; x=1694567981; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0W55U5dkDtWOdXQ18nuxk1kw/1nO1uoqQOX3LJ5eFjs=;
        b=Ju7YLgWMmtclhLz+yUFP90di54dzLoSjA+FXJFfbZwc4DcOJ4Z3tAMxeYA46Thly0B
         y89Sfp1hA/P8/PrzbXX4wmcWgSu5HTxvMX83pbNepVor91wBiyixpXPKSdKKuH7SoOqA
         lG9zh6/mzPLUHWuWi/Yomc1KelC9lQMKfEk2VOZeXLSwrqrwpjpFCkykqVI09Pjj/TlT
         44gcgO4cHCMlUMOS+MYmLlV08xbS2zP3leeapYV0CFYSH0cfukiKBHLQUfNb2/WlWRgb
         UF7j+2mRZvzaYEV5DnKaEGKk6hDgRB9V3Hd7fV+ObQfHGQf2MK1y/6+8Z9aHn85lFGAy
         npSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693963181; x=1694567981;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0W55U5dkDtWOdXQ18nuxk1kw/1nO1uoqQOX3LJ5eFjs=;
        b=iRPMcihO6mn88d2zvhNvd3EqGEeWCBg7GmceXOXJGLKkA6Vsq1V3bR1VfgJ2lyATuR
         s6/Fnyqv6spsuYdJDqRkfOkZQlS5gyCdovIs9euE83StqJAO/kuwfU9/uqWGI/4Z0KcV
         LDCC5a9dPsULBngZodaty/gJWNynavHSrbFwPQSR4kZtd3qcmMJ29qWwiz04IeX6+Kgx
         uw2X1PUyoOCNaCa6ZHfRpL8K94eGiDKKrIa8iVUtnTjsKrQPUaQOJnHsOO1keZ09RdLt
         M6lB0GLPEwi+DTwfEdSI2e+QEYOhgzL8aUjjmT82RrJRD0oMIH58YZqyTGf/SA/vJjQZ
         W4zQ==
X-Gm-Message-State: AOJu0YzLJgYJpuwgJ9DgceKQg88gopG07CuxmKTkP8ntHcYOl5egkFeJ
        +Kpb+/zuNIuh9x+maMc5w5s=
X-Google-Smtp-Source: AGHT+IHUqIIfqH6hHVZT5nenrjqak3YLcIQPeKu8Rfz5D5SxRToO9MysRXt2zHBfuYzGWKBwZNR4JA==
X-Received: by 2002:a9d:7dd3:0:b0:6b7:56d9:533 with SMTP id k19-20020a9d7dd3000000b006b756d90533mr13624755otn.28.1693963181447;
        Tue, 05 Sep 2023 18:19:41 -0700 (PDT)
Received: from smtpclient.apple ([2401:e180:8850:2f48:dd19:4847:5d6f:9042])
        by smtp.gmail.com with ESMTPSA id bt19-20020a632913000000b0056129129ef8sm9870964pgb.18.2023.09.05.18.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 18:19:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Mining Lin <mimi05633@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5 1/1] rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R
Date:   Wed, 6 Sep 2023 09:19:29 +0800
Message-Id: <D6734DA5-839E-40A6-9085-F25BB8D70022@gmail.com>
References: <202309050635059ecd17a2@mail.local>
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        KFLIN@nuvoton.com, mylin1@nuvoton.com, openbmc@lists.ozlabs.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <202309050635059ecd17a2@mail.local>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
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

Dear Alexandre,

Thanks for your comments.
The replies are as follow.

Thanks.
Best regard,
Mia

>=20
> On Sep 5, 2023, at 2:35 PM, Alexandre Belloni <alexandre.belloni@bootlin.c=
om> wrote:
>=20
> =EF=BB=BFOn 05/09/2023 14:03:41+0800, Mia Lin wrote:
>> The NCT3015Y-R and NCT3018Y-R use the same datasheet
>>    but have different topologies as follows.
>> - Topology (Only 1st i2c can set TWO bit and HF bit)
>>  In NCT3015Y-R,
>>    rtc 1st i2c is connected to a host CPU
>>    rtc 2nd i2c is connected to a BMC
>>  In NCT3018Y-R,
>>    rtc 1st i2c is connected to a BMC
>>    rtc 2nd i2c is connected to a host CPU
>> In order to be compatible with NCT3015Y-R and NCT3018Y-R,
>> - In probe,
>>  If part number is NCT3018Y-R, only set HF bit to 24-Hour format.
>>  Else, do nothing
>> - In set_time,
>>  If part number is NCT3018Y-R && TWO bit is 0,
>>     change TWO bit to 1, and restore TWO bit after updating time.
>> - Refine error messages to pinpoint the correct location.
>>=20
>> Signed-off-by: Mia Lin <mimi05633@gmail.com>
>> ---
>> drivers/rtc/rtc-nct3018y.c | 87 ++++++++++++++++++++++++++++----------
>> 1 file changed, 64 insertions(+), 23 deletions(-)
>>=20
>> diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
>> index a4e3f924837e..9ec20f241e15 100644
>> --- a/drivers/rtc/rtc-nct3018y.c
>> +++ b/drivers/rtc/rtc-nct3018y.c
>> @@ -23,6 +23,7 @@
>> #define NCT3018Y_REG_CTRL    0x0A /* timer control */
>> #define NCT3018Y_REG_ST        0x0B /* status */
>> #define NCT3018Y_REG_CLKO    0x0C /* clock out */
>> +#define NCT3018Y_REG_PART    0x21 /* part info */
>>=20
>> #define NCT3018Y_BIT_AF        BIT(7)
>> #define NCT3018Y_BIT_ST        BIT(7)
>> @@ -37,6 +38,7 @@
>> #define NCT3018Y_REG_BAT_MASK        0x07
>> #define NCT3018Y_REG_CLKO_F_MASK    0x03 /* frequenc mask */
>> #define NCT3018Y_REG_CLKO_CKE        0x80 /* clock out enabled */
>> +#define NCT3018Y_REG_PART_NCT3018Y    0x02
>>=20
>> struct nct3018y {
>>    struct rtc_device *rtc;
>> @@ -46,6 +48,8 @@ struct nct3018y {
>> #endif
>> };
>>=20
>> +static int part_num;
>> +
>=20
> This must be part of struct nct3018y.
[Mia] I will move the part number parameter to struct nct3018y.
>=20
>> static int nct3018y_set_alarm_mode(struct i2c_client *client, bool on)
>> {
>>    int err, flags;
>> @@ -55,7 +59,7 @@ static int nct3018y_set_alarm_mode(struct i2c_client *c=
lient, bool on)
>>    flags =3D  i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
>>    if (flags < 0) {
>>        dev_dbg(&client->dev,
>> -            "Failed to read NCT3018Y_REG_CTRL\n");
>> +            "%s: Failed to read ctrl reg.\n", __func__);
>=20
> If you really insist on this change, what about:
>=20
> #define pr_fmt(fmt) "%s: " fmt, __func__
[Mia] Do you mean to replace dev_dbg with pr_debug? If yes, for consistency,=
 I'm going to refine all messages via pr_debug. Thank you for your suggestio=
n.

>>        return flags;
>>    }
>>=20
>> @@ -67,21 +71,21 @@ static int nct3018y_set_alarm_mode(struct i2c_client *=
client, bool on)
>>    flags |=3D NCT3018Y_BIT_CIE;
>>    err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
>>    if (err < 0) {
>> -        dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
>> +        dev_dbg(&client->dev, "%s: Unable to write ctrl reg.\n", __func_=
_);
>>        return err;
>>    }
>>=20
>>    flags =3D  i2c_smbus_read_byte_data(client, NCT3018Y_REG_ST);
>>    if (flags < 0) {
>>        dev_dbg(&client->dev,
>> -            "Failed to read NCT3018Y_REG_ST\n");
>> +            "%s: Failed to read status reg.\n", __func__);
>>        return flags;
>>    }
>>=20
>>    flags &=3D ~(NCT3018Y_BIT_AF);
>>    err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_ST, flags);
>>    if (err < 0) {
>> -        dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_ST\n");
>> +        dev_dbg(&client->dev, "%s: Unable to write status reg.\n", __fun=
c__);
>>        return err;
>>    }
>>=20
>> @@ -155,7 +159,7 @@ static int nct3018y_rtc_read_time(struct device *dev,=
 struct rtc_time *tm)
>>        return err;
>>=20
>>    if (!buf[0]) {
>> -        dev_dbg(&client->dev, " voltage <=3D1.7, date/time is not reliab=
le.\n");
>> +        dev_dbg(&client->dev, "%s: voltage <=3D1.7, date/time is not rel=
iable.\n", __func__);
>>        return -EINVAL;
>>    }
>>=20
>> @@ -178,26 +182,44 @@ static int nct3018y_rtc_set_time(struct device *dev=
, struct rtc_time *tm)
>> {
>>    struct i2c_client *client =3D to_i2c_client(dev);
>>    unsigned char buf[4] =3D {0};
>> -    int err;
>> +    int err, flags;
>> +    int restore_flags =3D 0;
>> +
>> +    flags =3D i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
>> +    if (flags < 0) {
>> +        dev_dbg(&client->dev, "%s: Failed to read ctrl reg.\n", __func__=
);
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
>> +            dev_dbg(&client->dev, "%s: Unable to write ctrl reg.\n", __f=
unc__);
>> +            return err;
>> +        }
>> +    }
>>=20
>>    buf[0] =3D bin2bcd(tm->tm_sec);
>>    err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_SC, buf[0]);
>>    if (err < 0) {
>> -        dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_SC\n");
>> +        dev_dbg(&client->dev, "%s: Unable to write seconds reg.\n", __fu=
nc__);
>>        return err;
>>    }
>>=20
>>    buf[0] =3D bin2bcd(tm->tm_min);
>>    err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_MN, buf[0]);
>>    if (err < 0) {
>> -        dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_MN\n");
>> +        dev_dbg(&client->dev, "%s: Unable to write minutes reg.\n", __fu=
nc__);
>>        return err;
>>    }
>>=20
>>    buf[0] =3D bin2bcd(tm->tm_hour);
>>    err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_HR, buf[0]);
>>    if (err < 0) {
>> -        dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_HR\n");
>> +        dev_dbg(&client->dev, "%s: Unable to write hour reg.\n", __func_=
_);
>>        return err;
>>    }
>>=20
>> @@ -208,10 +230,22 @@ static int nct3018y_rtc_set_time(struct device *dev=
, struct rtc_time *tm)
>>    err =3D i2c_smbus_write_i2c_block_data(client, NCT3018Y_REG_DW,
>>                         sizeof(buf), buf);
>>    if (err < 0) {
>> -        dev_dbg(&client->dev, "Unable to write for day and mon and year\=
n");
>> +        dev_dbg(&client->dev, "%s: Unable to write for day and mon and y=
ear.\n", __func__);
>>        return -EIO;
>>    }
>>=20
>> +    /* Restore TWO bit */
>> +    if (restore_flags) {
>> +        if (part_num & NCT3018Y_REG_PART_NCT3018Y)
>> +            flags &=3D ~NCT3018Y_BIT_TWO;
>> +
>> +        err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, fla=
gs);
>> +        if (err < 0) {
>> +            dev_dbg(&client->dev, "%s: Unable to write ctrl reg.\n", __f=
unc__);
>> +            return err;
>> +        }
>> +    }
>> +
>>    return err;
>> }
>>=20
>> @@ -224,7 +258,7 @@ static int nct3018y_rtc_read_alarm(struct device *dev=
, struct rtc_wkalrm *tm)
>>    err =3D i2c_smbus_read_i2c_block_data(client, NCT3018Y_REG_SCA,
>>                        sizeof(buf), buf);
>>    if (err < 0) {
>> -        dev_dbg(&client->dev, "Unable to read date\n");
>> +        dev_dbg(&client->dev, "%s: Unable to read date.\n", __func__);
>>        return -EIO;
>>    }
>>=20
>> @@ -257,19 +291,19 @@ static int nct3018y_rtc_set_alarm(struct device *de=
v, struct rtc_wkalrm *tm)
>>=20
>>    err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_SCA, bin2bcd(tm=
->time.tm_sec));
>>    if (err < 0) {
>> -        dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_SCA\n");
>> +        dev_dbg(&client->dev, "%s: Unable to write seconds alarm reg.\n"=
, __func__);
>>        return err;
>>    }
>>=20
>>    err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_MNA, bin2bcd(tm=
->time.tm_min));
>>    if (err < 0) {
>> -        dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_MNA\n");
>> +        dev_dbg(&client->dev, "%s: Unable to write minutes alarm reg.\n"=
, __func__);
>>        return err;
>>    }
>>=20
>>    err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_HRA, bin2bcd(tm=
->time.tm_hour));
>>    if (err < 0) {
>> -        dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_HRA\n");
>> +        dev_dbg(&client->dev, "%s: Unable to write hour alarm reg.\n", _=
_func__);
>>        return err;
>>    }
>>=20
>> @@ -473,23 +507,29 @@ static int nct3018y_probe(struct i2c_client *client=
)
>>=20
>>    flags =3D i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
>>    if (flags < 0) {
>> -        dev_dbg(&client->dev, "%s: read error\n", __func__);
>> +        dev_dbg(&client->dev, "%s: Failed to read ctrl reg.\n", __func__=
);
>>        return flags;
>>    } else if (flags & NCT3018Y_BIT_TWO) {
>> -        dev_dbg(&client->dev, "%s: NCT3018Y_BIT_TWO is set\n", __func__)=
;
>> +        dev_dbg(&client->dev, "%s: TWO bit is set.\n", __func__);
>>    }
>>=20
>> -    flags =3D NCT3018Y_BIT_TWO;
>> -    err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);=

>> -    if (err < 0) {
>> -        dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
>> -        return err;
>> +    part_num =3D i2c_smbus_read_byte_data(client, NCT3018Y_REG_PART);
>> +    if (part_num < 0) {
>> +        dev_dbg(&client->dev, "%s: Failed to read part info reg.\n", __f=
unc__);
>> +        return part_num;
>> +    } else if (part_num & NCT3018Y_REG_PART_NCT3018Y) {
>> +        flags =3D NCT3018Y_BIT_HF;
>> +        err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, fla=
gs);
>> +        if (err < 0) {
>> +            dev_dbg(&client->dev, "%s: Unable to write ctrl reg.\n", __f=
unc__);
>> +            return err;
>> +        }
>>    }
>>=20
>>    flags =3D 0;
>>    err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_ST, flags);
>>    if (err < 0) {
>> -        dev_dbg(&client->dev, "%s: write error\n", __func__);
>> +        dev_dbg(&client->dev, "%s: Failed to clear status reg.\n", __fun=
c__);
>>        return err;
>>    }
>>=20
>> @@ -507,7 +547,8 @@ static int nct3018y_probe(struct i2c_client *client)
>>                        IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
>>                        "nct3018y", client);
>>        if (err) {
>> -            dev_dbg(&client->dev, "unable to request IRQ %d\n", client->=
irq);
>> +            dev_dbg(&client->dev, "%s: Unable to request IRQ %d.\n",
>> +                __func__, client->irq);
>>            return err;
>>        }
>>    } else {
>> --=20
>> 2.17.1
>>=20
>=20
> --=20
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
