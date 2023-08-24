Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719FA7870B8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbjHXNp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241531AbjHXNpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:45:19 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA54A1BF0;
        Thu, 24 Aug 2023 06:44:45 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d77ad095e5cso2183215276.0;
        Thu, 24 Aug 2023 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692884682; x=1693489482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L++NA8ke0GN/NNiuM/G0nTg7LegUkjXFtGuKBbBOH1w=;
        b=UgVoTCQubHd1qwiimanSqGkEVrkMTW72GXN83pM2kFfNbS+uOCYw/MCADTcdkKnbA+
         U/a1YQd4mAxzomgBfeLbSL/bELcMo9LW/qtLdhqo4RgILjMXtpEXqsiyLOyUqIkjJet9
         RvcOw0UAoxi/uKG9D9vXFZvAlrGZv/5fM+3GO5rXl4IakNHc8yEhzSxjI/x6I7MAi/gQ
         noag08SvtxT96ZrO3JZ2tLC2tuJzZRwS2Zj+eGLFRafpTx0LQLUCukQV7KCfn68r4OUL
         f7/zkZGE9YQRPAh0GFGg7rMCQoj/2vwMmkPZP3ZyBVo4Yg5WvxR6F+EGCyYP6hyNLsw4
         ws0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692884682; x=1693489482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L++NA8ke0GN/NNiuM/G0nTg7LegUkjXFtGuKBbBOH1w=;
        b=GNRlDcdUppTM1mUOmAdh3aL3pCdA3O/sVbNj87RF5AG8ZI7Rw0kFNvndR4CS/ni11b
         oNzuvV7Rv4DMKShlSlHA8kCHJpwgRFt94ZAFjDxYjwDXlKnu9DYCI3N0X/jeNQMa796j
         8ujradLmc0fxtJtE0E4z3/BB+obLzVOU9/tZRZJmccN89tTcHCoW3t7q71WpU/GOtbbi
         bYaAKU0QdEdn4Rtpe3ST3NbSpMwvGmClF1eccUHsBaj1mfe28HxKSdEpnbKRnMJqmpad
         FN+Wsg/96JKhbr9sRPzOaXVC4SzuTZa1K07j7PdAUiAgRynkFvbVIa5uSuzGoYoyRHzc
         0Ivw==
X-Gm-Message-State: AOJu0YwAn5JR81qZ7vI1nbnH8ysSn2MsdjCBGOVWaL53QWIK5txe/355
        Shb+Z8rH5QNosRCeU39iCORVa/SkzVu1d5lgGM0=
X-Google-Smtp-Source: AGHT+IG4NUzGkJ9KF5zltjHWgg18YpDMndnMusgfmCnwzfgcZJq8YxKQfYGjiw0JMzgBPOxrI/NbB2YX0/4z3/DaPfM=
X-Received: by 2002:a25:2596:0:b0:d78:9e9:ba4a with SMTP id
 l144-20020a252596000000b00d7809e9ba4amr1306594ybl.39.1692884680462; Thu, 24
 Aug 2023 06:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692824815.git.mehdi.djait.k@gmail.com> <923d01408680f5ac88ca8ee565a990645578ee83.1692824815.git.mehdi.djait.k@gmail.com>
 <ZOdFyKHBc6BcOgZw@smile.fi.intel.com> <eb47d0c9-9144-c947-f91e-d487c6ec9c45@gmail.com>
 <ZOdddZ0Zpk5CknH8@smile.fi.intel.com>
In-Reply-To: <ZOdddZ0Zpk5CknH8@smile.fi.intel.com>
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
Date:   Thu, 24 Aug 2023 15:44:29 +0200
Message-ID: <CAFukWp2Z0OCrJdTy+wzVs9jdCm70YNR-66q06=xoyGhaHg=aog@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,
Thank you for the review.

On Thu, Aug 24, 2023 at 3:39=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 24, 2023 at 03:52:56PM +0300, Matti Vaittinen wrote:
> > On 8/24/23 14:58, Andy Shevchenko wrote:
> > > On Wed, Aug 23, 2023 at 11:16:40PM +0200, Mehdi Djait wrote:
>
> ...
>
> > > > + int ret, fifo_bytes;
> > > > +
> > > > + ret =3D regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_=
bytes);
> > > > + if (ret) {
> > > > +         dev_err(data->dev, "Error reading buffer status\n");
> > > > +         return ret;
> > > > + }
> > > > +
> > > > + if (fifo_bytes =3D=3D KX022A_FIFO_FULL_VALUE)
> > > > +         return KX022A_FIFO_MAX_BYTES;
> > > > +
> > > > + return fifo_bytes;
> > >
> > > This will be called each time ->get_fifo_bytes() called.
> > > Do you expect the fifo_bytes to be changed over times?
> > > Shouldn't we simply cache the value?
> >
> > I think this value tells how many samples there currently is in the FIF=
O.
> > Caching it does not sound meaningful unless I am missing something.
>
> I see. I think my confusion can be easily cured by renaming the callback =
to
>
>         get_amount_bytes_in_fifo()
>
> or
>
>         get_bytes_in_fifo()
>
> or alike.

or leave it as is. The function is documented:

@@ -99,6 +101,7 @@ struct device;
  * @inc5: interrupt control register 5
  * @inc6: interrupt control register 6
  * @xout_l: x-axis output least significant byte
+ * @get_fifo_bytes: function pointer to get number of bytes in the FIFO bu=
ffer
  */
 struct kx022a_chip_info {
  const char *name;
@@ -121,6 +124,7 @@ struct kx022a_chip_info {
  u8 inc5;
  u8 inc6;
  u8 xout_l;
+ int (*get_fifo_bytes)(struct kx022a_data *);
 };

--
Kind Regards
Mehdi Djait
