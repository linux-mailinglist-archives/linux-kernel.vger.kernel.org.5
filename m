Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CE976911B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjGaJIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjGaJId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:08:33 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6378D107
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:08:32 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a36b30aa7bso3254590b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1690794511; x=1691399311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqOCi2n1NavpFlE8N26eyv2e5UnlllC9f92WXhukPKI=;
        b=cYAJPeYLtVVoiLUwCyjZ8P38cbBUwPis0IrA6N3kL/xfsVxo7qe0AWLuUePHBqoOVl
         6ctaUU6EdYF3voWE7ZmEABrE/xHm4sUfqS9Kv9UiJhwi0YkQk4oRBCYQrhDztsNQp6Jg
         aYs10i8JktYMjQINoMiWuJM8FTf/LCICmGSMLJ5HxNGfEB5ufTTdWvvxa7GRnHfRuLi7
         xgoijvAFN4/5DHx/aTeWekfrA2ukUz96iGfrJ4lw8/YO7fjz/E/syai/5bE9mjN9pxEV
         gcfAO9gYKcC0c1BqdsRIZ3zqIPo0GlPqp6h8Ur2WPTSgFqR632SikI9UDhgQdL55f04+
         jLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690794511; x=1691399311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqOCi2n1NavpFlE8N26eyv2e5UnlllC9f92WXhukPKI=;
        b=aCvBiJ+I9QiASnpbW09ZXf9Oii54xPMpF/Vjq+eLPoRcWEE2K9uYNnEfes99UbBTGj
         0R/5Qb3/eZqQsxbEFc7CSYNCKV+KRbJp3r1LbNU8iPn6WBEHfdzzDBcmUijC/dapV9Bb
         7//JTVD0vXj+auhAtXpZ+cYi4g46vyCjDdDPNJVcx4zbTqnUnVY5NCOBNxFTfiju4aIp
         vc5BwByTKCW8p9QXbHydPcp9LT+EepRFC6B59rVhLRm3vJXHR8tokUUyna9gtjvp4qvj
         R4/EpSfLyW2qT8N6qrYBmDTvsuxm8/kYwaFQ1eoDJ7zbeYK/OC9f+NK0zcNbbacE70M/
         ePOQ==
X-Gm-Message-State: ABy/qLaw+xMazL2XafaDTmdrBgroLoVZt39AnwE9/0fPmXRS8loSSqAD
        Z213c8b7p3OdEDDNScZvBSs0FLQBrTpBIdrf92ZnRQ==
X-Google-Smtp-Source: APBJJlFKWbIu+gOTrcov/jDSicFXjI+6huFpwHlI//frStRCRx/QnMVL/uGQimp7mFbHTx56qYtD7RLRsBe2gRdSUEk=
X-Received: by 2002:a05:6808:f91:b0:3a3:640d:ed71 with SMTP id
 o17-20020a0568080f9100b003a3640ded71mr12058385oiw.10.1690794511632; Mon, 31
 Jul 2023 02:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230728082527.3531940-1-Naresh.Solanki@9elements.com>
 <1cc12337-759e-c932-0303-b1b78e254c27@roeck-us.net> <CABqG17jXyx4GQqa2M7w78r0F99FzsqpNhft3w3jtUGKuBbfCDg@mail.gmail.com>
 <f47d38f8-02e7-3269-2754-300be3d4036e@roeck-us.net>
In-Reply-To: <f47d38f8-02e7-3269-2754-300be3d4036e@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Mon, 31 Jul 2023 14:38:20 +0530
Message-ID: <CABqG17huhzk6oV5rJj0GSpAbvqtSyd37CKnSAsFMkjYW0FeiSg@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (pmbus/mp2975) Fix PGOOD in READ_STATUS_WORD
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, 28 Jul 2023 at 19:56, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/28/23 04:28, Naresh Solanki wrote:
> > Hi Guenter,
> >
> >
> > On Fri, 28 Jul 2023 at 15:30, Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On 7/28/23 01:25, Naresh Solanki wrote:
> >>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >>>
> >>> MPS returns PGOOD instead of PB_STATUS_POWER_GOOD_N.
> >>> Fix that in the read_word_data hook.
> >>>
> >> Datasheets are not public, so I can not verify, but the code below
> >> only handles MP2973 and MP2971. What about MP2975 ?
> > I dont have MP2975 to even verify. I'm not sure if its applicable.
> >>
> >> Either case, this appears to affect most Monolithic chips, but
> >> not all of them. Please limit the statement to known to be affected
> >> chips.
> > Yes. With what we observed, this affects mp2973 & mp2971.
> > Will update accordingly.
>
> Please also add a comment that MP2975 is likely affected but can not be
> confirmed due to lack of a datasheet.
I have the datasheet for MP2975 but haven't verified it on real HW.

Regards,
Naresh
>
> Thanks,
> Guenter
>
> >>
> >>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> >>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> >>> ---
> >>>    drivers/hwmon/pmbus/mp2975.c | 4 ++++
> >>>    1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
> >>> index 28f33f4618fa..410b6eae6d02 100644
> >>> --- a/drivers/hwmon/pmbus/mp2975.c
> >>> +++ b/drivers/hwmon/pmbus/mp2975.c
> >>> @@ -297,6 +297,10 @@ static int mp2973_read_word_data(struct i2c_client *client, int page,
> >>>        int ret;
> >>>
> >>>        switch (reg) {
> >>> +     case PMBUS_STATUS_WORD:
> >>> +             ret = pmbus_read_word_data(client, page, phase, reg);
> >>
> >>                  if (ret < 0)
> >>                          return ret;
> >>
> >> Please add a comment explaining what is going on.
> > Sure.
> >>
> >>> +             ret ^= PB_STATUS_POWER_GOOD_N;
> >>> +             break;
> >>>        case PMBUS_OT_FAULT_LIMIT:
> >>>                ret = mp2975_read_word_helper(client, page, phase, reg,
> >>>                                              GENMASK(7, 0));
> >>>
> >>> base-commit: a4bb1ce5b9e3ca403c04e20ebeae77fd6447cb11
> >>
>
