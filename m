Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A38766BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbjG1L2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236244AbjG1L2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:28:50 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF123AB3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:28:47 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-52cb8e5e9f5so1283211a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1690543726; x=1691148526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Guw6xSEMNt/ZWDljMJQqkvfZd7fV3moBITl0CBYefCg=;
        b=V1TTMZ8TUf36g1/dKB95gkiZvF8vkGanvGS82g+hyQyEJLepTy1FDzCk1Glj99RbcC
         iHhtYaT5NSWXoTmatfAYYCE8NrSfFL+CskmBIG/vJeI+E8i/hQ/EQlVAdlAVLPFeGn+G
         aJ6YaQo+BeQu8Oxic6s4KQm97qn19Ta7RlYxK0HGy3o32/DBPd7V5yaW1md4sN+cMHJw
         a4lg15PHhJ+19mpP6Gi9luk7bvUUkjFW+H08H9IDDPfGaxcw6Yx6b01f5jpeHk/4TOd+
         hEkk62UgfMv83HjYtEbPBzhv6Tuov6c9Gx6TtnciWRF6dkxZYT6gks6zZOFNWsvJMmqH
         wfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690543726; x=1691148526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Guw6xSEMNt/ZWDljMJQqkvfZd7fV3moBITl0CBYefCg=;
        b=YtU4TTVs+W+B4S6hVc8AcOyH8angPRrf+FP0xzHhWdMTpCYFgT3E2Au9BMQTazG6RX
         pe/60vG0ZXNhjgdRcmiMIUmp4bjQe8spta4xikbggIqC+7641eRmfLQWOB13Iie5ier1
         +YUwT1RLpiHUCgYpLCPnh82evcMcoyn7Q2a9YbU0uVrT1Jfmj4uiM5kaQdFFP3naHwTb
         kGgHVEB3LDPAoRR5/NFUV1RdfziYSlzGhjsO6OfrLeYgiG2uxlcV4nwqrC8gvr9zVDuh
         sjzPnGNCJtIFuPOFCrTngONY8svH0NX7tKeCLjMjwXw9S2WV37VK9d2cucdkgf6ZyhTY
         p3SA==
X-Gm-Message-State: ABy/qLa+ho30TF0HRqwSrIBd3joVXzY7+k2ytkmdjCx/4Tz9fsBF3fuZ
        S5qypSbEdg8pMVFfoMpO1oaTXFgnVebpA3353x5+lJ6o9e9edyC6Zp0=
X-Google-Smtp-Source: APBJJlFqE15AjaSQutddHrut5E/eo2RwYtWjI954PTaMHP1SQeWefb79CfjZj4JQE32lXGaIxj+ajStL9NKCPJnDza0=
X-Received: by 2002:a17:90a:4094:b0:263:161c:9e9c with SMTP id
 l20-20020a17090a409400b00263161c9e9cmr2177072pjg.12.1690543726407; Fri, 28
 Jul 2023 04:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230728082527.3531940-1-Naresh.Solanki@9elements.com> <1cc12337-759e-c932-0303-b1b78e254c27@roeck-us.net>
In-Reply-To: <1cc12337-759e-c932-0303-b1b78e254c27@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Fri, 28 Jul 2023 16:58:35 +0530
Message-ID: <CABqG17jXyx4GQqa2M7w78r0F99FzsqpNhft3w3jtUGKuBbfCDg@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (pmbus/mp2975) Fix PGOOD in READ_STATUS_WORD
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,


On Fri, 28 Jul 2023 at 15:30, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/28/23 01:25, Naresh Solanki wrote:
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > MPS returns PGOOD instead of PB_STATUS_POWER_GOOD_N.
> > Fix that in the read_word_data hook.
> >
> Datasheets are not public, so I can not verify, but the code below
> only handles MP2973 and MP2971. What about MP2975 ?
I dont have MP2975 to even verify. I'm not sure if its applicable.
>
> Either case, this appears to affect most Monolithic chips, but
> not all of them. Please limit the statement to known to be affected
> chips.
Yes. With what we observed, this affects mp2973 & mp2971.
Will update accordingly.
>
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > ---
> >   drivers/hwmon/pmbus/mp2975.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
> > index 28f33f4618fa..410b6eae6d02 100644
> > --- a/drivers/hwmon/pmbus/mp2975.c
> > +++ b/drivers/hwmon/pmbus/mp2975.c
> > @@ -297,6 +297,10 @@ static int mp2973_read_word_data(struct i2c_client *client, int page,
> >       int ret;
> >
> >       switch (reg) {
> > +     case PMBUS_STATUS_WORD:
> > +             ret = pmbus_read_word_data(client, page, phase, reg);
>
>                 if (ret < 0)
>                         return ret;
>
> Please add a comment explaining what is going on.
Sure.
>
> > +             ret ^= PB_STATUS_POWER_GOOD_N;
> > +             break;
> >       case PMBUS_OT_FAULT_LIMIT:
> >               ret = mp2975_read_word_helper(client, page, phase, reg,
> >                                             GENMASK(7, 0));
> >
> > base-commit: a4bb1ce5b9e3ca403c04e20ebeae77fd6447cb11
>
