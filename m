Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EEB7CA4EB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjJPKMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjJPKM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:12:28 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A892FA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:12:25 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9b0f27dea5so2782661276.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697451145; x=1698055945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cC+G0VD0B1vguy9ZUz5RNgtqNtR/UA55N1fyHCOoEy8=;
        b=prUan8YHMPOJ5yy7HipDeNxAwn9YGnJIaXR6piJAXfPBSf5Gx6S5GMCbSDOVY17Uii
         enBqrB5l/oatfntaMY481D1pmBNb3mL6oPGblUi7pCbfnh71pEEwzXWNRr4eWo7KTibN
         f0pQlG59vCLrvvm/CmOsV50UFXAh8BGKPAZrBwg9kB4EgOYrwr8oy69nHkuQEjrvoO1D
         1cx4ufh6TsfDYGzsr7tHUylFe9hk8mVdWZoZNT+Iex5/uA/0JmNNep/OZGPb9lMGeRBy
         OxSt45ybgKoGUx6xhh6TwuT8mdBwtCRHiH+3xI1cYjhKclz5rPFTl2/ZWX3FLkxpdWOl
         jLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697451145; x=1698055945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cC+G0VD0B1vguy9ZUz5RNgtqNtR/UA55N1fyHCOoEy8=;
        b=RpHQgXcXmqy2ne/mx2v88/qiqAK75l3uvXPPTS0oi5FizC5LR2n5ndCLs5ZQLQbJRm
         TanIuvhXwHqB8cLE9d081FMwhLZjO500wVluXhXQlynxGCfVGqwUOyfnCYLCQT7ZSs4r
         VKDX/+qE04mdswhdRauU/6np3XWIRN4hQFpHvSkOcE5SOJXIJF/M9NitOESpXKtPhD1J
         cYpWY9iwzbkda4yszddt/vsugrL19cXDZQzdhVQtXre2nhUm2yKZyJxl8jx23xCfzHe2
         6NvdOd7wh7yjxVn5biWA9BaMN1aEFmpM1BST31KeuJ7EpYeEPAckRIsBabMZn97jbm/X
         09/w==
X-Gm-Message-State: AOJu0YzCaEUrmMqcEqNOE4gniMLfX7amKYG88W0Ciof86ToOyaO5DScx
        aBVdc4KyZzk8XZPg8pPYYm+N05INOTXGB0RJT5VOvw==
X-Google-Smtp-Source: AGHT+IHFGtmDMkOFZtRbruZRQXYw0ZXvBDMMEMnMXkCEVeGXBLNpsW5prEUQnRuOv0JoicbYkOXIm4M/srlI8GdPnGE=
X-Received: by 2002:a25:2d2:0:b0:d9a:fd25:e3ef with SMTP id
 201-20020a2502d2000000b00d9afd25e3efmr7984208ybc.64.1697451145096; Mon, 16
 Oct 2023 03:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697186772.git.viresh.kumar@linaro.org> <afec94cb6515e79c3b336f74be8aa929a303b26f.1697186772.git.viresh.kumar@linaro.org>
In-Reply-To: <afec94cb6515e79c3b336f74be8aa929a303b26f.1697186772.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Oct 2023 12:11:49 +0200
Message-ID: <CAPDyKFreG1Umg3G0+MBrXYcQhHytch3AzWmUWd=xHrCNNGnULA@mail.gmail.com>
Subject: Re: [PATCH 4/5] OPP: Remove genpd_virt_dev_lock
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

On Fri, 13 Oct 2023 at 10:49, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> All the config operations for OPP tables share common code paths now and
> none of the other ones have such protection in place. Either all should
> have it or none.
>
> The understanding here is that user won't clear the OPP configs while
> still using them and so such a case won't happen. We can always come
> back and use a wider lock for all resource types if required.
>
> Also fix the error on failing to allocate memory.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/opp/core.c | 33 +++------------------------------
>  drivers/opp/opp.h  |  2 --
>  2 files changed, 3 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 3516e79cf743..befe46036ad5 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1089,12 +1089,6 @@ static int _opp_set_required_opps_genpd(struct device *dev,
>                 delta = -1;
>         }
>
> -       /*
> -        * Acquire genpd_virt_dev_lock to make sure we don't use a genpd_dev
> -        * after it is freed from another thread.
> -        */
> -       mutex_lock(&opp_table->genpd_virt_dev_lock);
> -
>         while (index != target) {
>                 ret = _set_performance_state(dev, genpd_virt_devs[index], opp, index);
>                 if (ret)
> @@ -1103,8 +1097,6 @@ static int _opp_set_required_opps_genpd(struct device *dev,
>                 index += delta;
>         }
>
> -       mutex_unlock(&opp_table->genpd_virt_dev_lock);
> -
>         return 0;
>  }
>
> @@ -1474,7 +1466,6 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
>                 return ERR_PTR(-ENOMEM);
>
>         mutex_init(&opp_table->lock);
> -       mutex_init(&opp_table->genpd_virt_dev_lock);
>         INIT_LIST_HEAD(&opp_table->dev_list);
>         INIT_LIST_HEAD(&opp_table->lazy);
>
> @@ -1510,7 +1501,6 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
>  remove_opp_dev:
>         _of_clear_opp_table(opp_table);
>         _remove_opp_dev(opp_dev, opp_table);
> -       mutex_destroy(&opp_table->genpd_virt_dev_lock);
>         mutex_destroy(&opp_table->lock);
>  err:
>         kfree(opp_table);
> @@ -1678,7 +1668,6 @@ static void _opp_table_kref_release(struct kref *kref)
>         list_for_each_entry_safe(opp_dev, temp, &opp_table->dev_list, node)
>                 _remove_opp_dev(opp_dev, opp_table);
>
> -       mutex_destroy(&opp_table->genpd_virt_dev_lock);
>         mutex_destroy(&opp_table->lock);
>         kfree(opp_table);
>  }
> @@ -2395,7 +2384,7 @@ static void _opp_put_config_regulators_helper(struct opp_table *opp_table)
>                 opp_table->config_regulators = NULL;
>  }
>
> -static void _detach_genpd(struct opp_table *opp_table)
> +static void _opp_detach_genpd(struct opp_table *opp_table)
>  {
>         int index;
>
> @@ -2449,13 +2438,11 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
>         if (!opp_table->required_opp_count)
>                 return -EPROBE_DEFER;
>
> -       mutex_lock(&opp_table->genpd_virt_dev_lock);
> -
>         opp_table->genpd_virt_devs = kcalloc(opp_table->required_opp_count,
>                                              sizeof(*opp_table->genpd_virt_devs),
>                                              GFP_KERNEL);
>         if (!opp_table->genpd_virt_devs)
> -               goto unlock;
> +               return -ENOMEM;
>
>         while (*name) {
>                 if (index >= opp_table->required_opp_count) {
> @@ -2478,29 +2465,15 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
>
>         if (virt_devs)
>                 *virt_devs = opp_table->genpd_virt_devs;
> -       mutex_unlock(&opp_table->genpd_virt_dev_lock);
>
>         return 0;
>
>  err:
> -       _detach_genpd(opp_table);
> -unlock:
> -       mutex_unlock(&opp_table->genpd_virt_dev_lock);
> +       _opp_detach_genpd(opp_table);
>         return ret;
>
>  }
>
> -static void _opp_detach_genpd(struct opp_table *opp_table)
> -{
> -       /*
> -        * Acquire genpd_virt_dev_lock to make sure virt_dev isn't getting
> -        * used in parallel.
> -        */
> -       mutex_lock(&opp_table->genpd_virt_dev_lock);
> -       _detach_genpd(opp_table);
> -       mutex_unlock(&opp_table->genpd_virt_dev_lock);
> -}
> -
>  static void _opp_clear_config(struct opp_config_data *data)
>  {
>         if (data->flags & OPP_CONFIG_GENPD)
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index fefdf9845692..08366f90f16b 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -160,7 +160,6 @@ enum opp_table_access {
>   * @rate_clk_single: Currently configured frequency for single clk.
>   * @current_opp: Currently configured OPP for the table.
>   * @suspend_opp: Pointer to OPP to be used during device suspend.
> - * @genpd_virt_dev_lock: Mutex protecting the genpd virtual device pointers.
>   * @genpd_virt_devs: List of virtual devices for multiple genpd support.
>   * @required_opp_tables: List of device OPP tables that are required by OPPs in
>   *             this table.
> @@ -212,7 +211,6 @@ struct opp_table {
>         struct dev_pm_opp *current_opp;
>         struct dev_pm_opp *suspend_opp;
>
> -       struct mutex genpd_virt_dev_lock;
>         struct device **genpd_virt_devs;
>         struct opp_table **required_opp_tables;
>         unsigned int required_opp_count;
> --
> 2.31.1.272.g89b43f80a514
>
