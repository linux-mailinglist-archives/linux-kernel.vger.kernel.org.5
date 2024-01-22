Return-Path: <linux-kernel+bounces-33576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06509836B96
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7260F1F245F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3959405FE;
	Mon, 22 Jan 2024 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A0kRBFiG"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D473405EF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936905; cv=none; b=ed8V0I0U4qsNrlWCQmkEj47qF6foQC8lDh+wlLZlHVh/N2CWAHleBYsRHUPjcQVBwuTzutmxN0J7BIATQO+3N8hFwINOR4CjbFp3XaQmgxtO4S7XFN/4O2dp5oBYQPuASmpi9fLTeYln+0KAERW2tFbCwfMPGzMAyR/HlZfUgsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936905; c=relaxed/simple;
	bh=kDaZTGvX1qegyipawpDHtqiFJZ07zD34kOucMWLGuCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRJDzYmQ6l6J08dt7tzal1y80oVfHrEpQ02YyKxKGBVHfNYhbwK4qlMGpeZXgwqcsUGrra3mnVqmY8m7J2oLUydR+O1vyi6qYadVj7T4niBPipR7q2i/539QicWKKd0zE/qeg+KYjaYLr9H4JmyVwz5N5BhKLGd971l3QJel/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A0kRBFiG; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5ffb528dc8dso12913347b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705936902; x=1706541702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=azZj8uWoAYXpYPWNpYpxGJSP02xYLkyFYL+zSVWu1Bk=;
        b=A0kRBFiG6UAmHBkpek1H0z+ZugkprCM4v+dvp8ZkbvS2euJqTiIj63D9KyEHLJuQku
         Ppy+zal9ycNrL0i7kzjKn3ScnHuy3F1qza3DknfSeHG7t1Yzw3c8uFsV83Pz7PcEIJnd
         iegoZGjmVUjiHjc98u44hQ7Xm0fTaLlIV6iAwQjK5ArBKw5aHwvIjGwG/3MRHq0jhOOM
         VzQD0YfMuD3IwywGPHN7TD2cAnO+urH4d8p8n2r59iuOPwba6/zapiBiA07hBK91/olR
         1sEjlV4pl2gG96cM79rxqXwHHY/X1Lhzh8BQeePzXAlxx9v+xQOyN+n1p6NIcPK4D+p0
         F8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705936902; x=1706541702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azZj8uWoAYXpYPWNpYpxGJSP02xYLkyFYL+zSVWu1Bk=;
        b=p6viZj1ZScxR0n4WfFl1VSkg5aJg0wKvO4tQOtQQYnu/E1RIKN0EMs3dPpcCwvuy/p
         jb5s9TWG8bM5cv7q+vqHg3NMMN1q9g7jtr8EwM5V+s/mx/g2q2kR2Aj9DijcIYfbqZri
         vqCnYGIRxg0iH+G4CQcfuIXlhH88CRfKPFgbcFw6zxS1ClGctmKbfMNRWTretzk6ASQv
         4o5s6nMCSDMoEfY0CwG6ZHAxiNs2LyXIi0lArASGm2M0lQ+8wlXaQx3SKzbiGmiTmULP
         h+F+0LWwy+fMapbgCKZklM7Zlw/viIoH7+wtodmyz6QAwwxtdOmIr3dHwP4Ke/WswXmK
         Uwiw==
X-Gm-Message-State: AOJu0Yw4jfkIZbCQV3eAAcSWkY2R7jKMBlj2LsDz0j9RoA9BWc20vhJR
	vxL3dx3iTUk1mneyTU/7J0ImUaYVuEwdREUdwFjpCF6PJWXh3dYWjp7FaGWQ+0ev0USdMwBRn4n
	VuLmhUjP75OeofX/OOxLzpBbg0zZxFsXvUuaP1g==
X-Google-Smtp-Source: AGHT+IGYCqA4bk0i1nasQEY2oO3ecNWeQHgvLLj0Cs/eKLO9AkpXZlekz3dN0S9SpflSX5Qf9j4n4Z9Lq2p6MFv6bDE=
X-Received: by 2002:a81:5cc1:0:b0:5fa:1942:f055 with SMTP id
 q184-20020a815cc1000000b005fa1942f055mr3274396ywb.48.1705936902370; Mon, 22
 Jan 2024 07:21:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103-genpd-perf-order-v2-1-eeecfc55624b@gerhold.net>
In-Reply-To: <20240103-genpd-perf-order-v2-1-eeecfc55624b@gerhold.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 22 Jan 2024 16:21:06 +0100
Message-ID: <CAPDyKFr3TRWM9UOtKkxSXKCAFN5wuvWLNcUfQuqGD91Ut1Ys1g@mail.gmail.com>
Subject: Re: [PATCH v2] PM: domains: Scale down parent performance states in
 reverse order
To: Stephan Gerhold <stephan@gerhold.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 22:10, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> Power domains might have parent domains assigned that are automatically
> managed by the PM domain core. In particular, parent domains are
> automatically powered on/off and setting performance states on child
> domains is translated to parent domains (e.g. using an OPP table from
> the device tree).
>
> Currently parent performance states are always adjusted before the
> performance state of the child domain is changed.
>
> However, typically a parent/child relationship between two power
> domains with performance states models the requirement to keep the
> parent domain at a performance state equal or higher to the child
> domain. When scaling down there is a brief moment where the parent
> domain will end up having a lower performance state than required by
> the child domain.
>
> To avoid this, we need to differentiate between scaling up/down and
> adjust the order of operations:
>
>  - When scaling up, parent domains should be adjusted before the child
>    domain. In case of an error, the rollback happens in reverse order.
>
>  - When scaling down, parent domains should be adjusted after the child
>    domain, in reverse order, just as if we would rollback scaling up.
>    In case of an error, the rollback happens in normal order (just as
>    if we would normally scale up).
>
> Implement this by moving the existing functionality of
> _genpd_set_performance_state() to two separate functions that are
> called in the proper iteration order.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

I have tested this with my local set of test drivers - and things are
now working as they should. Thanks a lot for fixing this!

I have applied the patch for next, but it's probably a good idea to
add a fixes/stable tag to it and queue it as a fix instead. What do
you think?

Note that, I took the liberty of slightly updating the commit message
a bit, to try to make things even more clear.

Kind regards
Uffe



> ---
> Changes in v2:
> - Rebase to adjust for move of drivers/base/power/domain.c
>   to drivers/pmdomain/core.c
> - Regenerate CC list
> - No code changes
> - Link to v1: https://lore.kernel.org/r/20231205-genpd-perf-order-v1-1-6597cc69a729@gerhold.net
> ---
> Related discussion: https://lore.kernel.org/linux-pm/ZWXgFNKgm9QaFuzx@gerhold.net/
> ---
>  drivers/pmdomain/core.c | 124 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 77 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index a1f6cba3ae6c..fec9dc6ab828 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -311,72 +311,102 @@ static int genpd_xlate_performance_state(struct generic_pm_domain *genpd,
>  }
>
>  static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
> -                                       unsigned int state, int depth)
> +                                       unsigned int state, int depth);
> +
> +static void _genpd_rollback_parent_state(struct gpd_link *link, int depth)
>  {
> -       struct generic_pm_domain *parent;
> -       struct gpd_link *link;
> -       int parent_state, ret;
> +       struct generic_pm_domain *parent = link->parent;
> +       int parent_state;
>
> -       if (state == genpd->performance_state)
> -               return 0;
> +       genpd_lock_nested(parent, depth + 1);
>
> -       /* Propagate to parents of genpd */
> -       list_for_each_entry(link, &genpd->child_links, child_node) {
> -               parent = link->parent;
> +       parent_state = link->prev_performance_state;
> +       link->performance_state = parent_state;
>
> -               /* Find parent's performance state */
> -               ret = genpd_xlate_performance_state(genpd, parent, state);
> -               if (unlikely(ret < 0))
> -                       goto err;
> +       parent_state = _genpd_reeval_performance_state(parent, parent_state);
> +       if (_genpd_set_performance_state(parent, parent_state, depth + 1)) {
> +               pr_err("%s: Failed to roll back to %d performance state\n",
> +                      parent->name, parent_state);
> +       }
>
> -               parent_state = ret;
> +       genpd_unlock(parent);
> +}
>
> -               genpd_lock_nested(parent, depth + 1);
> +static int _genpd_set_parent_state(struct generic_pm_domain *genpd,
> +                                  struct gpd_link *link,
> +                                  unsigned int state, int depth)
> +{
> +       struct generic_pm_domain *parent = link->parent;
> +       int parent_state, ret;
>
> -               link->prev_performance_state = link->performance_state;
> -               link->performance_state = parent_state;
> -               parent_state = _genpd_reeval_performance_state(parent,
> -                                               parent_state);
> -               ret = _genpd_set_performance_state(parent, parent_state, depth + 1);
> -               if (ret)
> -                       link->performance_state = link->prev_performance_state;
> +       /* Find parent's performance state */
> +       ret = genpd_xlate_performance_state(genpd, parent, state);
> +       if (unlikely(ret < 0))
> +               return ret;
>
> -               genpd_unlock(parent);
> +       parent_state = ret;
>
> -               if (ret)
> -                       goto err;
> -       }
> +       genpd_lock_nested(parent, depth + 1);
>
> -       if (genpd->set_performance_state) {
> -               ret = genpd->set_performance_state(genpd, state);
> -               if (ret)
> -                       goto err;
> -       }
> +       link->prev_performance_state = link->performance_state;
> +       link->performance_state = parent_state;
>
> -       genpd->performance_state = state;
> -       return 0;
> +       parent_state = _genpd_reeval_performance_state(parent, parent_state);
> +       ret = _genpd_set_performance_state(parent, parent_state, depth + 1);
> +       if (ret)
> +               link->performance_state = link->prev_performance_state;
>
> -err:
> -       /* Encountered an error, lets rollback */
> -       list_for_each_entry_continue_reverse(link, &genpd->child_links,
> -                                            child_node) {
> -               parent = link->parent;
> +       genpd_unlock(parent);
>
> -               genpd_lock_nested(parent, depth + 1);
> +       return ret;
> +}
> +
> +static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
> +                                       unsigned int state, int depth)
> +{
> +       struct gpd_link *link = NULL;
> +       int ret;
> +
> +       if (state == genpd->performance_state)
> +               return 0;
>
> -               parent_state = link->prev_performance_state;
> -               link->performance_state = parent_state;
> +       /* When scaling up, propagate to parents first in normal order */
> +       if (state > genpd->performance_state) {
> +               list_for_each_entry(link, &genpd->child_links, child_node) {
> +                       ret = _genpd_set_parent_state(genpd, link, state, depth);
> +                       if (ret)
> +                               goto rollback_parents_up;
> +               }
> +       }
>
> -               parent_state = _genpd_reeval_performance_state(parent,
> -                                               parent_state);
> -               if (_genpd_set_performance_state(parent, parent_state, depth + 1)) {
> -                       pr_err("%s: Failed to roll back to %d performance state\n",
> -                              parent->name, parent_state);
> +       if (genpd->set_performance_state) {
> +               ret = genpd->set_performance_state(genpd, state);
> +               if (ret) {
> +                       if (link)
> +                               goto rollback_parents_up;
> +                       return ret;
>                 }
> +       }
>
> -               genpd_unlock(parent);
> +       /* When scaling down, propagate to parents last in reverse order */
> +       if (state < genpd->performance_state) {
> +               list_for_each_entry_reverse(link, &genpd->child_links, child_node) {
> +                       ret = _genpd_set_parent_state(genpd, link, state, depth);
> +                       if (ret)
> +                               goto rollback_parents_down;
> +               }
>         }
>
> +       genpd->performance_state = state;
> +       return 0;
> +
> +rollback_parents_up:
> +       list_for_each_entry_continue_reverse(link, &genpd->child_links, child_node)
> +               _genpd_rollback_parent_state(link, depth);
> +       return ret;
> +rollback_parents_down:
> +       list_for_each_entry_continue(link, &genpd->child_links, child_node)
> +               _genpd_rollback_parent_state(link, depth);
>         return ret;
>  }
>
>
> ---
> base-commit: 0fef202ac2f8e6d9ad21aead648278f1226b9053
> change-id: 20231205-genpd-perf-order-bf33029c25ac
>
> Best regards,
> --
> Stephan Gerhold <stephan@gerhold.net>
>

