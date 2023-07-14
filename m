Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FBD753AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbjGNMVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjGNMVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:21:40 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0E63589
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:21:37 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso841676a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689337297; x=1691929297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vKPCYi6KH5ixV5Dyvebx4XZChTDDw8w3UlWPbSm3lU8=;
        b=KtiElmlb3CgSrlUVicYRXjQ/XqqtuVJKzBYOd4mPPyTCmzmOF99bc4smFNRnkzEdOV
         ja9Ef76Rzhcg2BI2I8QkhBWwTEl55sQ7HtnkPG6UNL4LnHiUs2LfhLrMxo2gsIDJ/Ytp
         rWCMvP1oSoy8dGxYpkbzpmYkQibESzrlBznET3zQRnKUfss8bfbIBpAg6TiMPrpOS3pf
         UvyY6q5+BaqL3bdkFshqY//L5dOJgPRVYIZyIhir9KXnvpwuOYW57IMrXPvzF1Ho+U8H
         IHsoYCWdcbSJRbnU2tq3F1OCJo0jKqFtz2CxAwIwBjPNVYveZvUkeG8H9MeuSzXBMgO0
         NPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689337297; x=1691929297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKPCYi6KH5ixV5Dyvebx4XZChTDDw8w3UlWPbSm3lU8=;
        b=gap6PcVAzjT+I9Ce/Go/4bAq0PS3lpntE95VQ+eNk6tbgkeK0Ab16+D7gpgMDd3vfz
         awM21AqTlTGye7XxAN/84dvcRJ+G70++nImzIeTxjKpTTTNn0OzANy60gOA0+PZMr3iw
         xSwxCFYMBrvDC7QCwkunaQ6VGHkZKy80A51wdqlBWdqY5gbTcnqSvD1a70dYzqTktYhY
         0++uRt1JH/s3r2n/zzZai2glXJ/ffgJeCa4RzXAQCLguHZw60nihIo4Zs+yjhedmWg9o
         pBZVaPsTTIx0rFKJeV5ukJG4Sgc1MbTzv38oY8s6Xck10jIwt++1sOukQ1UbI3b1JvM4
         r22Q==
X-Gm-Message-State: ABy/qLavdr7jGQAegyCHjrBl5SG/g77BfjC+vgzmOT/5MSxfoVZ13+2I
        g12HRsYrFhde1BZUqDF/Yy43EsiwWaLj1k9MNKCAM6B7eoJFSO6mF4NL4w==
X-Google-Smtp-Source: APBJJlFaY1AZjySEwrcQoAaRIWzNqIw/3VXJQbvL09Jy8JFNwV/tPuhq1DMwL3B40xDM6NGLU6GNjHpUyRIzJ4ZjWC4=
X-Received: by 2002:a17:90b:388:b0:263:abea:94d1 with SMTP id
 ga8-20020a17090b038800b00263abea94d1mr2879280pjb.44.1689337296871; Fri, 14
 Jul 2023 05:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230712114754.500477-1-Naresh.Solanki@9elements.com>
 <20230712114754.500477-4-Naresh.Solanki@9elements.com> <38157958-9723-73bc-f79a-1ac8c80c512e@roeck-us.net>
In-Reply-To: <38157958-9723-73bc-f79a-1ac8c80c512e@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Fri, 14 Jul 2023 13:23:26 +0200
Message-ID: <CABqG17gHj+wAVqHR0o9ospcAMYPTnO0xtcPGPc8GqNb03mO58w@mail.gmail.com>
Subject: Re: [PATCH 4/8] hwmon: (pmbus/mp2975) Simplify VOUT code
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Wed, 12 Jul 2023 at 17:50, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/12/23 04:47, Naresh Solanki wrote:
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > In order to upstream MP2973/MP2971 simplify the code by removing support
> > for various VOUT formats. The MP2973 and MP2971 supports all PMBUS
> > supported formats for VOUT, while the MP2975 only support DIRECT and
> > VID for VOUT.
> >
> > In DIRECT mode all chips report the voltage in 1mV/LSB.
> >
> > Configure the chip to use DIRECT format for VOUT and drop the code
> > conversion code for other formats. The to be added chips MP2973/MP2971
> > will be configured to also report VOUT in DIRECT format.
> >
> > The maximum voltage that can be reported in DIRECT format is 32768mV.
> > This is sufficient as the maximum output voltage for VR12/VR13 is
> > 3040 mV.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > ---
> >   drivers/hwmon/pmbus/mp2975.c | 54 ++++++------------------------------
> >   1 file changed, 8 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
> > index 04778f2dcbdb..ebc9a84b8ad3 100644
> > --- a/drivers/hwmon/pmbus/mp2975.c
> > +++ b/drivers/hwmon/pmbus/mp2975.c
> > @@ -70,7 +70,6 @@ struct mp2975_data {
> >       int vref_off[MP2975_PAGE_NUM];
> >       int vout_max[MP2975_PAGE_NUM];
> >       int vout_ov_fixed[MP2975_PAGE_NUM];
> > -     int vout_format[MP2975_PAGE_NUM];
> >       int curr_sense_gain[MP2975_PAGE_NUM];
> >   };
> >
> > @@ -83,22 +82,6 @@ MODULE_DEVICE_TABLE(i2c, mp2975_id);
> >
> >   #define to_mp2975_data(x)  container_of(x, struct mp2975_data, info)
> >
> > -static int mp2975_read_byte_data(struct i2c_client *client, int page, int reg)
> > -{
> > -     switch (reg) {
> > -     case PMBUS_VOUT_MODE:
> > -             /*
> > -              * Enforce VOUT direct format, since device allows to set the
> > -              * different formats for the different rails. Conversion from
> > -              * VID to direct provided by driver internally, in case it is
> > -              * necessary.
> > -              */
> > -             return PB_VOUT_MODE_DIRECT;
> > -     default:
> > -             return -ENODATA;
> > -     }
> > -}
> > -
> >   static int
> >   mp2975_read_word_helper(struct i2c_client *client, int page, int phase, u8 reg,
> >                       u16 mask)
> > @@ -273,24 +256,6 @@ static int mp2975_read_word_data(struct i2c_client *client, int page,
> >               ret = DIV_ROUND_CLOSEST(data->vref[page] * 10 - 50 *
> >                                       (ret + 1) * data->vout_scale, 10);
> >               break;
> > -     case PMBUS_READ_VOUT:
> > -             ret = mp2975_read_word_helper(client, page, phase, reg,
> > -                                           GENMASK(11, 0));
> > -             if (ret < 0)
> > -                     return ret;
> > -
> > -             /*
> > -              * READ_VOUT can be provided in VID or direct format. The
> > -              * format type is specified by bit 15 of the register
> > -              * MP2975_MFR_DC_LOOP_CTRL. The driver enforces VOUT direct
> > -              * format, since device allows to set the different formats for
> > -              * the different rails and also all VOUT limits registers are
> > -              * provided in a direct format. In case format is VID - convert
> > -              * to direct.
> > -              */
> > -             if (data->vout_format[page] == vid)
> > -                     ret = mp2975_vid2direct(info->vrm_version[page], ret);
> > -             break;
> >       case PMBUS_VIRT_READ_POUT_MAX:
> >               ret = mp2975_read_word_helper(client, page, phase,
> >                                             MP2975_MFR_READ_POUT_PK,
> > @@ -578,20 +543,18 @@ mp2975_vout_max_get(struct i2c_client *client, struct mp2975_data *data,
> >   }
> >
> >   static int
> > -mp2975_identify_vout_format(struct i2c_client *client,
> > -                         struct mp2975_data *data, int page)
> > +mp2975_set_vout_format(struct i2c_client *client,
> > +                    struct mp2975_data *data, int page)
> >   {
> >       int ret;
> >
> >       ret = i2c_smbus_read_word_data(client, MP2975_MFR_DC_LOOP_CTRL);
> >       if (ret < 0)
> >               return ret;
> > -
> > -     if (ret & MP2975_VOUT_FORMAT)
> > -             data->vout_format[page] = vid;
> > -     else
> > -             data->vout_format[page] = direct;
> > -     return 0;
> > +     /* Enable DIRECT VOUT format 1mV/LSB */
> > +     ret &= ~MP2975_VOUT_FORMAT;
> > +     ret = i2c_smbus_write_word_data(client, MP2975_MFR_DC_LOOP_CTRL, ret);
>
> Writing this back is only needed if MP2975_VOUT_FORMAT was not already cleared.
Yes. Will optimize it as:
if (ret & MP2975_VOUT_FORMAT) {
ret &= ~MP2975_VOUT_FORMAT;
ret = i2c_smbus_write_word_data(client, MP2975_MFR_DC_LOOP_CTRL, ret);
}


>
> > +     return ret;
> >   }
> >
> >   static int
> > @@ -650,11 +613,11 @@ mp2975_vout_per_rail_config_get(struct i2c_client *client,
> >                       return ret;
> >
> >               /*
> > -              * Get VOUT format for READ_VOUT command : VID or direct.
> > +              * Set VOUT format for READ_VOUT command : direct.
> >                * Pages on same device can be configured with different
> >                * formats.
>
> Not sure if this comment still makes sense.
Yes. Updated the comment as below:
/* Set VOUT format for READ_VOUT command : direct. */
ret = mp2975_set_vout_format(....

>
> >                */
> > -             ret = mp2975_identify_vout_format(client, data, i);
> > +             ret = mp2975_set_vout_format(client, data, i);
> >               if (ret < 0)
> >                       return ret;
> >
> > @@ -689,7 +652,6 @@ static struct pmbus_driver_info mp2975_info = {
> >               PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> >               PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_POUT |
> >               PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT | PMBUS_PHASE_VIRTUAL,
> > -     .read_byte_data = mp2975_read_byte_data,
> >       .read_word_data = mp2975_read_word_data,
> >   };
> >
>

Regards,
Naresh Solanki
