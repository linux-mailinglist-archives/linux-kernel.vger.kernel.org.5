Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139C0808863
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379452AbjLGMq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbjLGMqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:46:17 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0072410FE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:46:22 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5d852ac9bb2so6613047b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 04:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701953182; x=1702557982; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VI0Dv+MkJTCAPGHL7fb9uH8dV/Mhy8R6r6OQ9YvGWaY=;
        b=Tz2+RgoEHRb82TqBFGZJZb3cwiiRjTIIw/8Aq4lNIpvlx2ZzcNMoYZRr3Izp5daAus
         6obmVLt5DNB2PQAEW9nY7riWIpwXfr0GCh3yEtexC7OASm44l5ioCHryibfkWrMqXc8z
         1py1zYXWYRTQ9s/w4wI8EtXo6WdS8+ymFyOBaLB1TPsYDNWcj8mxz5kgEuirukEM6hde
         ePhasyTuxrZi0/xYo6WENJg17iTtk4o3k7cjcxTXMHVptgfkXK8Ucabo9cQ8upYLXBIq
         PG8dgyPeIMFh9NfZlviwfIbN0yvrxXY1VF8P5PMsR+ZZgGKB4bhs7Dn6F4K8RYei+s7v
         c/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701953182; x=1702557982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VI0Dv+MkJTCAPGHL7fb9uH8dV/Mhy8R6r6OQ9YvGWaY=;
        b=xUBM72rsZY7tJzyxLliBjceno0XE83nh7tBQ0B/WIsLyN0/FoLGGrmhnrKlseqjEmD
         q8OIVLllk/kc8F+x4aUeZYOa7dbEvP6Q06FQgb1kcebvmLd/19KZYQUU5GabB6izE0BA
         w+/Z0V1pD/nXnVAA3TgITBVc5qt+PQ7XHPl8EgUTspe87KT74QRm9IXet5Z1VJrgOdQy
         /wG03CNCn2bMIe1daSBmaq6LFE8M5EsKRpSHm1DXkqhzovUUXPoU6kSz9cNiN9h8ebLg
         6ARdoqJ68F1bPNTwtxxpCditktUjhBW4sN7F+wLA9lrMyZ9EZITWszOM4cBJxZ5+YL2G
         KJTA==
X-Gm-Message-State: AOJu0YzA5/YEe+5Awunoq6n5tjLfKcyeqR8V5HL0C7Ccv91a8X4Bi7F2
        KnWWhD86semUq6VkbwdLjz42GDgm2Unt7LVNh3l3lA==
X-Google-Smtp-Source: AGHT+IFEOW0K8NPLkg1XDUGQAovRn5vj/jSL4Juak4jk5D8i07yxZPAAzlxqeeQUWKmXDhOp0eDutvDQE7eu5xUt/MY=
X-Received: by 2002:a5b:dc3:0:b0:db7:dacf:2f15 with SMTP id
 t3-20020a5b0dc3000000b00db7dacf2f15mr2108499ybr.92.1701953182192; Thu, 07 Dec
 2023 04:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20231205225856.32739-1-rdunlap@infradead.org>
In-Reply-To: <20231205225856.32739-1-rdunlap@infradead.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Dec 2023 13:45:46 +0100
Message-ID: <CAPDyKFp2HZ1r4FXBYMN=uK6JTkADBtw+NH0dDeT3HJ9bV90wdA@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: fix domain_governor kernel-doc warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
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

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

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
