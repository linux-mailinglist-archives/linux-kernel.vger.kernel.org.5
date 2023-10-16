Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3227F7CA4E9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjJPKM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjJPKMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:12:24 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97504107
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:12:21 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9151fc5903so4869636276.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697451141; x=1698055941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uv5Uae5UmSQxVEsmwl5TN/YrBxW9LPgFAY62qTwF/dg=;
        b=qXfZpktt5l+MkiCWYsa/eb3oL8Huv7dep4wh+B+gAWfuScqHzDIKWWu4yhtr/4nO47
         9c1/WuI3aRwlA516WVn62dEwNUrNzWn6I6yAV0pIHg47q6wQlNJRCGZSWd4qpXlqn++y
         hzezQxgvvEguYYTn3u56eEULA2P9ubfy+kWyZ8zTLRU8pvf6An66KFVQckiMvNwo5OK2
         fEShV01lQdvTjWKtdxVxZbw0rkIXbH90WoMAOHphdWPIAW8T9EtZRUK27qc6klCk6DEe
         uXyLbX2GK8hxX8Ab215RKf6LtRx1zhhV8iXsfm2WYXb7f+FzwrkMN1WvQUK80VXrdek5
         bCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697451141; x=1698055941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uv5Uae5UmSQxVEsmwl5TN/YrBxW9LPgFAY62qTwF/dg=;
        b=GgeS/jhmgj7SNyyft2bBUIP3qhedadYE9wRI4CKCnJ9bXzhvaJPPfwfHiD8xv2g8+8
         v1pRNucZ8VCnEwutRzuZkr9KmEJo5GWaM3U8Cg6zsJuVdwe0qDvk/DzUSWMjs9To+UOy
         invoiaeeKIDobWiFIFsLoQdiOumvfdiwMdH3XCCuOhDZ7fKMqv9Lq+ARuCz6TBqqIHbq
         F81iPV694rS/07Hx4fvyNdazh88ZfPpjjIjbm+gz91dL3Ag1Bi8nNZoJjY1bPUCYfJjG
         8yVcImCtS5aS29QbkCvXjO2o94rm1GVuJVXmb7Bw0DcnrHqwrkb52n4TV2z2XOj5lkZX
         oeUA==
X-Gm-Message-State: AOJu0YywA5/HSBYlspBseYknSn8zbZHgYRzbJnQRhOAjfh6L3HCNCCm/
        9hHBw4L1m5V+9Et8c3ZViiRlhU4kCWelF/rSp5iL7Q==
X-Google-Smtp-Source: AGHT+IHogU+oXlyPoAe9oxJ1k+4wdalEiXaZswNxlbBUueCP3rIK8SfSBZk+1xNHSXQz1MUiB41Xn6w82/mBEO6fSB0=
X-Received: by 2002:a25:f910:0:b0:d81:894b:28e4 with SMTP id
 q16-20020a25f910000000b00d81894b28e4mr31091512ybe.51.1697451140795; Mon, 16
 Oct 2023 03:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697186772.git.viresh.kumar@linaro.org> <a5bd698a7a899fb63b4c5caec7068bf5a395165c.1697186772.git.viresh.kumar@linaro.org>
In-Reply-To: <a5bd698a7a899fb63b4c5caec7068bf5a395165c.1697186772.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Oct 2023 12:11:45 +0200
Message-ID: <CAPDyKFpHy-32h+yu4X-psGqpaqFNpY0CgveHgd_3Zu57KPg3Dw@mail.gmail.com>
Subject: Re: [PATCH 3/5] OPP: Reorder code in _opp_set_required_opps_genpd()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 at 10:48, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Reorder code in _opp_set_required_opps_genpd() to reduce duplicate code.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index f42b663a4d8b..3516e79cf743 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1076,7 +1076,18 @@ static int _opp_set_required_opps_genpd(struct device *dev,
>  {
>         struct device **genpd_virt_devs =
>                 opp_table->genpd_virt_devs ? opp_table->genpd_virt_devs : &dev;
> -       int i, ret = 0;
> +       int index, target, delta, ret;
> +
> +       /* Scaling up? Set required OPPs in normal order, else reverse */
> +       if (!scaling_down) {
> +               index = 0;
> +               target = opp_table->required_opp_count;
> +               delta = 1;
> +       } else {
> +               index = opp_table->required_opp_count - 1;
> +               target = -1;
> +               delta = -1;
> +       }
>
>         /*
>          * Acquire genpd_virt_dev_lock to make sure we don't use a genpd_dev
> @@ -1084,24 +1095,17 @@ static int _opp_set_required_opps_genpd(struct device *dev,
>          */
>         mutex_lock(&opp_table->genpd_virt_dev_lock);
>
> -       /* Scaling up? Set required OPPs in normal order, else reverse */
> -       if (!scaling_down) {
> -               for (i = 0; i < opp_table->required_opp_count; i++) {
> -                       ret = _set_performance_state(dev, genpd_virt_devs[i], opp, i);
> -                       if (ret)
> -                               break;
> -               }
> -       } else {
> -               for (i = opp_table->required_opp_count - 1; i >= 0; i--) {
> -                       ret = _set_performance_state(dev, genpd_virt_devs[i], opp, i);
> -                       if (ret)
> -                               break;
> -               }
> +       while (index != target) {
> +               ret = _set_performance_state(dev, genpd_virt_devs[index], opp, index);
> +               if (ret)
> +                       break;
> +
> +               index += delta;
>         }
>
>         mutex_unlock(&opp_table->genpd_virt_dev_lock);
>
> -       return ret;
> +       return 0;

Why always return 0 and not the error code anymore?

[...]

Kind regards
Uffe
