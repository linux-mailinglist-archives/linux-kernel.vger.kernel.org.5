Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6BB7B7A3D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241747AbjJDIjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241722AbjJDIjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:39:18 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A097A83;
        Wed,  4 Oct 2023 01:39:15 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3af5b26d599so1309738b6e.2;
        Wed, 04 Oct 2023 01:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696408755; x=1697013555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9/MtXqLrtXt958q8e0H362E4aqBcq4uYbsSDrU1xpVo=;
        b=PhoFhT+k8iXZbJJWigYXQ2gDiWymPPg0UofingBuJzNZGfEwB1SwvSL6vt3eRw9FRx
         OZp9MLgJegcY8yDW3uWABPAFTmOJT3ZHmJfRUTyp4rh95X++ehEAEstJPFbNNsQQXgDA
         OoIXTN/pOSdcSa4+Exev4oUm2znAMBRN4r+LR8PtUSL06Vo52nQtuQhnmzZyMkoRaBwr
         RLcE+57Cqty0YMvxZzzl7dzpWxq6v6dm0uoId5YIZMgcMr3usPLBeGjwzjbBSoIXbumI
         wyZjnNoCQ2DY0AqaRMPGIqkae9gCa65VqB5orSg7rL2KwJMv2F7XB4wrJ6vimHbyL1C6
         XxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696408755; x=1697013555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/MtXqLrtXt958q8e0H362E4aqBcq4uYbsSDrU1xpVo=;
        b=ek3xBBikbO6Vuqr+lyakfZWzBidtq5ftM51LMN9NwFhuIsfLNKAgMOdTlRiCgf7Znk
         qeS0/E/l3NLbC5oEGEA2e84uePCia/6mF0QjJGwYYCrYbGLroMCN9zMvoAuPoAVZRbjN
         20HtEcqETVw1sx8GAfFvRnRBDlCcpQBdOUkCI8ZYgTm0z57g682PDatR+8btlfTb/Xi+
         lxkmkfwTZQOnZH6jHa067ibAS7Sf/qShmh4xL5yf0DSHDG1nDcMMNHYvo713UsFGi56I
         7MBS2tVI1Ao0V0Mnn1sOmDhWgBvI5FyEbferu6Z4S4kL8aKKeTk3wMs25rV4Bvm3qVBm
         QwYw==
X-Gm-Message-State: AOJu0Yx0r2WjNmIwJ+Q3Pig2bg7h49NFivjPnKvhr91f+LX6AZm0exnH
        CNsQc0b/cnF/z4070Q4DKylJPxziUlx10B2evmg=
X-Google-Smtp-Source: AGHT+IH1aQ0coht5UnO8z19LdQOou4tP5HFtLkJ2ThHn63GXnYbzb+gTd3YZzR0HSSBWWRSrxmNXvqSaVMVjTGYliQM=
X-Received: by 2002:a05:6808:1ce:b0:3a9:6400:62c6 with SMTP id
 x14-20020a05680801ce00b003a9640062c6mr1734553oic.32.1696408754882; Wed, 04
 Oct 2023 01:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230921073217.572151-1-alessandro.carminati@gmail.com>
In-Reply-To: <20230921073217.572151-1-alessandro.carminati@gmail.com>
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
Date:   Wed, 4 Oct 2023 10:38:39 +0200
Message-ID: <CAPp5cGRSGQGq-4DckxrXTuG=BqwLm9cLHgjY8+MMe8Qgcon4Cw@mail.gmail.com>
Subject: Re: [PATCH v2] clk: Sanitize possible_parent_show to Handle Return
 Value of of_clk_get_parent_name
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philip Daly <pdaly@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gentle ping

In the original email, I acknowledge that I misplaced the maintainers mail
addresse from the "to" field.

Il giorno gio 21 set 2023 alle ore 09:33 Alessandro Carminati (Red
Hat) <alessandro.carminati@gmail.com> ha scritto:
>
> From: Alessandro Carminati <alessandro.carminati@gmail.com>
>
> In the possible_parent_show function, ensure proper handling of the return
> value from of_clk_get_parent_name to prevent potential issues arising from
> a NULL return.
> The current implementation invokes seq_puts directly on the result of
> of_clk_get_parent_name without verifying the return value, which can lead
> to kernel panic if the function returns NULL.
>
> This patch addresses the concern by introducing a check on the return
> value of of_clk_get_parent_name. If the return value is not NULL, the
> function proceeds to call seq_puts, providing the returned value as
> argument.
> However, if of_clk_get_parent_name returns NULL, the function provides a
> static string as argument, avoiding the panic.
>
> Fixes: 1ccc0ddf046a ("clk: Use seq_puts() in possible_parent_show()")
> Reported-by: Philip Daly <pdaly@redhat.com>
> Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
> ---
>  drivers/clk/clk.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c249f9791ae8..473563bc7496 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3416,6 +3416,7 @@ static void possible_parent_show(struct seq_file *s, struct clk_core *core,
>                                  unsigned int i, char terminator)
>  {
>         struct clk_core *parent;
> +       const char *name = NULL;
>
>         /*
>          * Go through the following options to fetch a parent's name.
> @@ -3430,18 +3431,20 @@ static void possible_parent_show(struct seq_file *s, struct clk_core *core,
>          * registered (yet).
>          */
>         parent = clk_core_get_parent_by_index(core, i);
> -       if (parent)
> +       if (parent) {
>                 seq_puts(s, parent->name);
> -       else if (core->parents[i].name)
> +       } else if (core->parents[i].name) {
>                 seq_puts(s, core->parents[i].name);
> -       else if (core->parents[i].fw_name)
> +       } else if (core->parents[i].fw_name) {
>                 seq_printf(s, "<%s>(fw)", core->parents[i].fw_name);
> -       else if (core->parents[i].index >= 0)
> -               seq_puts(s,
> -                        of_clk_get_parent_name(core->of_node,
> -                                               core->parents[i].index));
> -       else
> -               seq_puts(s, "(missing)");
> +       } else {
> +               if (core->parents[i].index >= 0)
> +                       name = of_clk_get_parent_name(core->of_node, core->parents[i].index);
> +               if (!name)
> +                       name = "(missing)";
> +
> +               seq_puts(s, name);
> +       }
>
>         seq_putc(s, terminator);
>  }
> --
> 2.34.1
>
