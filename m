Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D6F787163
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbjHXOXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241555AbjHXOXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:23:23 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6867619BE;
        Thu, 24 Aug 2023 07:23:21 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a7aedc57ffso4622547b6e.2;
        Thu, 24 Aug 2023 07:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692887000; x=1693491800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iD7VPnwf3Paz+cr3qd3Ag+TZIEHXdPJrYY8sf9TpOuM=;
        b=HjKrVPLEqevehlYr5+mYHiR91/DCvfgFJZm7iUb4tDXO1ULkdzPVqPQx+FVx9q9mpf
         endftKhr3fKhyc2cDDV59RYM1xldnQ2+T1GS9buzCat2hYHU+Q+/di4bMf4nnpqp1Omb
         PrYHAZ4JzjlgJCt4Z/4WTki4EuOk6YYcMS9FA62CJLL3b72i0QYtCi0dW2U4UkEc3a/P
         AQhtgYZWYsRrWKwuGvOWMAtjEew+0kqzf05dYlss0KEU04TS/xo4B0y2L4WvOXPdWgmU
         6QxghloWjtpH1s5yUbyfa9XsQ9TB8FAzBgMvw6JPipgkLFu1MvJPuv0kxUKaejx2w6gj
         ngbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692887000; x=1693491800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iD7VPnwf3Paz+cr3qd3Ag+TZIEHXdPJrYY8sf9TpOuM=;
        b=jnAw14dm9OH8BTd1ShcmQIM4XNaAN+hG4QfGnVJ6IX3b89sS4nJ13Fw8llGsmLXpl8
         ZJ4DA18a66CLLHwfpn0p2TeikKVAzVl9SEwIhCH0STEs+pXzhGpIls+QlMk/6oduNdSc
         SjEMOfeqDMjadh0p/aFfCRUaejkdyZfvZI7rLXk8yULSyvjA0f6sNNL2CEl94W5Ehow1
         TrIYj0qrDVgZViVrUGaG+tLGGtV5VCpyoH55JcrhMpmZHj/TtunKKqiqVchZARqVHpXm
         qE9mbBykLkaw+3XUWP/soASqmsOK33p6rNj1ZSqdZGno/4XVfd7PUQPIslbhLlAU4TvQ
         kfKw==
X-Gm-Message-State: AOJu0Yz9YRZoBgAqRnGdJIce3TEqwtPvv5OCP25UGzsKgModPxyKiGtE
        vo1ZNhll3DCnb+D5xHmOuyBOumifAkziZF45wtE=
X-Google-Smtp-Source: AGHT+IGTFcy9Vx97rOwy9lZGFc0mtXZh7LR2Hm0d6w4mdE9jW1XwGWZxbnng4fA9NrWQkvhG3H6r9Y/QlmSV8k1BayE=
X-Received: by 2002:a05:6358:881e:b0:132:ce1f:6793 with SMTP id
 hv30-20020a056358881e00b00132ce1f6793mr18628874rwb.21.1692887000276; Thu, 24
 Aug 2023 07:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692824815.git.mehdi.djait.k@gmail.com> <923d01408680f5ac88ca8ee565a990645578ee83.1692824815.git.mehdi.djait.k@gmail.com>
 <ZOdFyKHBc6BcOgZw@smile.fi.intel.com> <eb47d0c9-9144-c947-f91e-d487c6ec9c45@gmail.com>
 <ZOdddZ0Zpk5CknH8@smile.fi.intel.com> <CAFukWp2Z0OCrJdTy+wzVs9jdCm70YNR-66q06=xoyGhaHg=aog@mail.gmail.com>
 <ZOdfeaW6AxE4eeqw@smile.fi.intel.com>
In-Reply-To: <ZOdfeaW6AxE4eeqw@smile.fi.intel.com>
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
Date:   Thu, 24 Aug 2023 16:23:09 +0200
Message-ID: <CAFukWp0ubncNcMiw-s_h5GoP1_RsjTaw3XxayGMuaeJJJneBow@mail.gmail.com>
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

On Thu, Aug 24, 2023 at 4:06=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 24, 2023 at 03:44:29PM +0200, Mehdi Djait wrote:
> > On Thu, Aug 24, 2023 at 3:39=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Aug 24, 2023 at 03:52:56PM +0300, Matti Vaittinen wrote:
> > > > On 8/24/23 14:58, Andy Shevchenko wrote:
> > > > > On Wed, Aug 23, 2023 at 11:16:40PM +0200, Mehdi Djait wrote:
>
> ...
>
> > > I see. I think my confusion can be easily cured by renaming the callb=
ack to
> > >
> > >         get_amount_bytes_in_fifo()
> > >
> > > or
> > >
> > >         get_bytes_in_fifo()
> > >
> > > or alike.
> >
> > or leave it as is. The function is documented:
>
> > + * @get_fifo_bytes: function pointer to get number of bytes in the FIF=
O buffer
>
> Do you find it unambiguous? I do not.
>
> Still needs more words to explain if it's a capacity of FIFO or is it amo=
unt of
> valid bytes for the current transfer or what?

how about change the description to:
function pointer to get amount  of acceleration data bytes currently
stored in the sensor's FIFO buffer

and change the function to "get_amount_bytes_in_fifo()"

--
Kind Regards
Mehdi Djait
