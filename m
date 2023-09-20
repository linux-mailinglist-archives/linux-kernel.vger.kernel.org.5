Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0042E7A74D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjITHvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjITHux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:50:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4118A133;
        Wed, 20 Sep 2023 00:50:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3200257b9a3so3468875f8f.3;
        Wed, 20 Sep 2023 00:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695196244; x=1695801044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlzHTfHgS7DIEzzPJ69/Nl7roPtenVnlUobepr30yTw=;
        b=Zs1iswTQLjB/GmsDbSOxzXEo87i7En0Js0LHm7sNaVT7xKV7Pu+e+uDuNM5ImHjmRz
         baHQ8R5HaY3R74+i1nCtMMz1FrCQJfe5pI79om0GkmR+iF569HsQbV2bvXQOc/AtidQ9
         XdiDHiRUDtWPV2SId57XTABdBfiBtyldp4NpkvSidNaI5FF3UVEjWk+L/jBLsF981WWH
         T8lB0HKgI0tcRYX83oSHt0+qevUDAHKQJw28SIumuFXm/fV0aJbWfYtZigIjqAe+oW4L
         rMSYuZMdZ998QUdWOV9IYx6H0HT1K2yZZ+/n2qwNuU5F8cbAnOMhp/HjVq6caV1b+uAe
         i2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695196244; x=1695801044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlzHTfHgS7DIEzzPJ69/Nl7roPtenVnlUobepr30yTw=;
        b=NTXPxXUHUC26qYq1JqbZyQv6zICllCp/G9Ti060bkZoo6HpjdtI1tGezUiQS3VAgor
         CbWvqJ3lSosn8aQ8QHaFbY6aZQ+/MYXKfofTn5N6dnwEKgKDOGWiQVz0AWfR14fmqqHE
         NKQD73/hFHy6gGWg5kITnqC6hCKv25EQUNeOuojXoF7O8HZdZzUwFCaWVivZl2bwjXjg
         ElPG4WKJC/9VABAyf4N7bOLop8Muy0X/i4B8+gInTh0UX77oz1SQfw7EP0eJBQ4J4+ew
         yj65t59uMHsyyRIkUuf8Fk25t1FNDFPjR3uuSs2nP3Vmg6eWGnNqrgnhaSnb4U1ohPvr
         2OKA==
X-Gm-Message-State: AOJu0YytzUtyr8BQqVbRn75ljKlFzEtoyBujoaATY+xvaTlRKu70Wv79
        D/YxRUMjSkEMKumwXJrgZ9s=
X-Google-Smtp-Source: AGHT+IEEmHXQCsShaamGnvoU38VzYpHCM+Fifd+ZtlaDpeigN7nlVyFwbMp3MQeBupf+fI/pxclJFg==
X-Received: by 2002:adf:ee88:0:b0:314:1b36:f440 with SMTP id b8-20020adfee88000000b003141b36f440mr1457739wro.70.1695196244358;
        Wed, 20 Sep 2023 00:50:44 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id q11-20020adff50b000000b0031c71693449sm17768372wro.1.2023.09.20.00.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:50:44 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     mripard@kernel.org
Cc:     abelvesa@kernel.org, bbara93@gmail.com, benjamin.bara@skidata.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        festevam@gmail.com, frank@oltmanns.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, mturquette@baylibre.com, peng.fan@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        shawnguo@kernel.org
Subject: Re: [PATCH 05/13] clk: keep track of the trigger of an ongoing clk_set_rate
Date:   Wed, 20 Sep 2023 09:50:37 +0200
Message-Id: <20230920075037.1737982-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <gyx5a6sacm6xens4jmxqynehloumsxyft35u6nd445qsv5345l@553vkj27ywef>
References: <gyx5a6sacm6xens4jmxqynehloumsxyft35u6nd445qsv5345l@553vkj27ywef>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, 19 Sept 2023 at 09:06, Maxime Ripard <mripard@kernel.org> wrote:
> On Mon, Sep 18, 2023 at 12:40:01AM +0200, Benjamin Bara wrote:
> > From: Benjamin Bara <benjamin.bara@skidata.com>
> >
> > When we keep track of the rate change trigger, we can easily check if an
> > affected clock is affiliated with the trigger. Additionally, the trigger
> > is added to the notify data, so that drivers can implement workarounds
> > that might be necessary if a shared parent changes.
> >
> > Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> > ---
> >  drivers/clk/clk.c   | 12 ++++++++++++
> >  include/linux/clk.h |  2 ++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 4954d31899ce..8f4f92547768 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -33,6 +33,9 @@ static struct task_struct *enable_owner;
> >  static int prepare_refcnt;
> >  static int enable_refcnt;
> >
> > +/* responsible for ongoing rate change, protected by prepare_lock */
> > +static struct clk *rate_trigger_clk;
> > +
> >  static HLIST_HEAD(clk_root_list);
> >  static HLIST_HEAD(clk_orphan_list);
> >  static LIST_HEAD(clk_notifier_list);
> > @@ -1742,6 +1745,7 @@ static int __clk_notify(struct clk_core *core, unsigned long msg,
> >
> >       cnd.old_rate = old_rate;
> >       cnd.new_rate = new_rate;
> > +     cnd.trigger = rate_trigger_clk ? : core->parent->hw->clk;
> >
> >       list_for_each_entry(cn, &clk_notifier_list, node) {
> >               if (cn->clk->core == core) {
> > @@ -2513,6 +2517,8 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
> >       /* prevent racing with updates to the clock topology */
> >       clk_prepare_lock();
> >
> > +     rate_trigger_clk = clk;
> > +
>
> So I don't think that interacts very well with the clk_hw_set_rate
> function you introduced. It looks like you only consider the initial
> clock here so you wouldn't update rate_trigger_clk on a clk_hw_set_rate
> call, but that creates some inconsistencies:
>
>   - If we call clk_hw_set_rate outside of the set_rate path (but in
>     .init for example), then we end up with a notifier without a trigger
>     clock set.
>
>   - More generally, depending on the path we're currently in, a call to
>     clk_hw_set_rate will notify a clock in different ways which is a bit
>     weird to me. The trigger clock can also be any clock, parent or
>     child, at any level, which definitely complicates things at the
>     driver level.
>
> The rate propagation is top-down, so could be get away with just setting
> the parent clock that triggered the notification?

As I mentioned in the other response, this implementation seems to be
just a hack to get additional context in the notifier. I think that's
also a problem Frank had in his approach. Inside the notifier, it's not
clear what to do with the incoming change. Because it could be either
"intended", meaning a sub-clock of the current clock has triggered the
change, or "unintended" (e.g. a sibling has triggered the change, but
the subtree beyond the current clock still requires the old rate, and
therefore the clock needs to adapt). Therefore I think if we use
req_rate here, we might be able to achieve the same thing in a better
way.

Thanks!
