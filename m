Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DFF810E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjLMKeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjLMKeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:34:08 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02832AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:34:15 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5c85e8fdd2dso66005857b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702463654; x=1703068454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9FZnNzpRdub68izs5qvM26thxhHVaJuKTgF6tB6XgDg=;
        b=bg39wl1aPOasX3spzmIr+nx6l89vhqaryFyKrQw18UtjOSH8wl0ruVUqtDcmA1iZ9Z
         G3OChZvO0nlLm8J1xxZu+EAnnNGaVE9WF67wLTNHEChz39tYzY3lO7ne8tK89dk/o+O6
         SQy0flDUcEwkPBVA79oWf95jbQrSFEXZLBYG9iTbOuv+rK9Yq5EFEfMqJeQKMdc4ShBv
         cD8TdAvfhymSKyyfu7coGCpnPgx1GZzUEFO9YKa7o1q/3WyvAwFV8FJeHyoEhpnnOwp3
         fKswXI5sWTEhZ+XW70Kda9npx7vEaLjPj9iOmt+GfvQdOrhZJ2OQWqIcDxy80Xpm4z2z
         ZagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702463654; x=1703068454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FZnNzpRdub68izs5qvM26thxhHVaJuKTgF6tB6XgDg=;
        b=ZKE92JBd95OZBZWqV48Xd+K0SC+0W+dZZLtFm0Hk3UtLDa+pV+RQBkLApE6LSIBLuL
         Q9yc2i98hXoGxlMHnmP3WA8n5E0HgDdpZQ6tqV4n2XscA3Yxn2KKBKPGcWePaV8Iq8W6
         GMnErpJ56BhTROuo27XSfGdHoDHTXMvHX0u/Yy44nzRz4tyqeDPwXO7hqn38k/eOVmA/
         qwEnn4wV/PNHULCe741YOjMKi93AtTinEtrMG+szhCylZZtucNIwvG4PX2PA7z5Zni0f
         IHl1FX8K9pG6LHFKePXrOJ+BjDKwNZvAPloT4uk2oV8eXh3evRngYUpgLBTW4GmC9dkG
         NgUQ==
X-Gm-Message-State: AOJu0YyPUY2xv16+Zp+ImdCkvjRYWYmjM2kn/m92BAQJhwO+5fd/PR1N
        EKmWZUfXQhOjuSRJtJgCMnMcnJismk6YWSBzw8Q7SA==
X-Google-Smtp-Source: AGHT+IE4U9FmwvNewrvjILhFp2HgfiDj9jTykDdH41QxIuQSGD+dELOKoQEHH2rLaM7jTYmF3DiY8atm1BmmQeHHLmc=
X-Received: by 2002:a0d:e981:0:b0:5d7:1940:dd92 with SMTP id
 s123-20020a0de981000000b005d71940dd92mr5986727ywe.104.1702463654048; Wed, 13
 Dec 2023 02:34:14 -0800 (PST)
MIME-Version: 1.0
References: <20231205225856.32739-1-rdunlap@infradead.org>
In-Reply-To: <20231205225856.32739-1-rdunlap@infradead.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Dec 2023 11:33:37 +0100
Message-ID: <CAPDyKFrxhcTREpC3pozgvbi_7Q8BxXzEdYYkLFF5zv=viFVg7g@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: fix domain_governor kernel-doc warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2023 at 23:59, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix kernel-doc warnings found when using "W=1".
>
> domain_governor.c:54: warning: No description found for return value of 'default_suspend_ok'
> domain_governor.c:266: warning: No description found for return value of '_default_power_down_ok'
> domain_governor.c:412: warning: cannot understand function prototype: 'struct dev_power_governor pm_domain_always_on_gov = '
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/base/power/domain_governor.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff -- a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -49,6 +49,8 @@ static int dev_update_qos_constraint(str
>  /**
>   * default_suspend_ok - Default PM domain governor routine to suspend devices.
>   * @dev: Device to check.
> + *
> + * Returns: true if OK to suspend, false if not OK to suspend
>   */
>  static bool default_suspend_ok(struct device *dev)
>  {
> @@ -261,6 +263,8 @@ static bool __default_power_down_ok(stru
>   * @now: current ktime.
>   *
>   * This routine must be executed under the PM domain's lock.
> + *
> + * Returns: true if OK to power down, false if not OK to power down
>   */
>  static bool _default_power_down_ok(struct dev_pm_domain *pd, ktime_t now)
>  {
> @@ -406,8 +410,8 @@ struct dev_power_governor simple_qos_gov
>         .power_down_ok = default_power_down_ok,
>  };
>
> -/**
> - * pm_genpd_gov_always_on - A governor implementing an always-on policy
> +/*
> + * pm_domain_always_on_gov - A governor implementing an always-on policy
>   */
>  struct dev_power_governor pm_domain_always_on_gov = {
>         .suspend_ok = default_suspend_ok,
