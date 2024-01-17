Return-Path: <linux-kernel+bounces-29251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395D9830B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51EE01C26661
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFA222611;
	Wed, 17 Jan 2024 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WfDQxeks"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138E122EF3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510835; cv=none; b=r4QdfUN21TqPtXvY/THSnl3/Q33b31vEF/rUhp22HROHmQ+qbhsDc/BSbCjoTAf13g8zh9psZB+f3CSyxuGvh8T8Alb39aomHzS2KNbgw2yJAgVvzmVeb0FgVPD3o4sOk2F8Vwyba36dYauKaWAMdwUkrMY44YNzrOkmgSlgFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510835; c=relaxed/simple;
	bh=pq/Av+SSO69BeU9h8xuQL0aN3Uu8++2iivejVhGQ0P4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=I0dil4fXmJ9VDV+wxmPrs1RxB72i2+zD/bJ7a/WEKBw487e2hEhXY/NOE2DdMKE04zxxvQ/SiRLO3VivA0JtahVVZ21MF2++6NuylFbJ94hQHRi2T0bzJuW41gXtSeEis3n8M8nGJlXhP2EAlEs1/ZtwtZe+o3sP6lY7NQ1Gt6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WfDQxeks; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5ff7ec8772dso1817647b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705510832; x=1706115632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cZ2p7jEyFK0ojPkUOrVvKOvjb7MyzhY/xh/W7SjMLt0=;
        b=WfDQxeks9usOT6CfMsy6kO5Lyutt7cRJZq6JjRFOOdwWplzwUkEsrueDUPpmreZqAP
         Fvk2j8GVgrrgA1D6taAlFnm1Xb3nhFkFhaT2femamQcT+3TO4M7NMXD+DUfnY0hol5fQ
         FqnN0to2d52e+W10bEoxuMw+H+zRxTDbmgfscR3E9J98+mo7YcAT15qJmf7t8GKw+vYR
         QsGXO8ZsWlytFJBZ/Mk2A+3YHdYQLcwRJU7feTlTejqf2BSJOZOpN0Iv/K7923XM2BpH
         o+yEUmbZiH+qQhDUAOOx9Y6rdRU6VtjuqdrdOq3LdEVjQkgczScjOUj57UOCl6lTuFqI
         vhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705510832; x=1706115632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZ2p7jEyFK0ojPkUOrVvKOvjb7MyzhY/xh/W7SjMLt0=;
        b=O4IgA1g5KYMAo07UvWCWuQdvUP8M8DxZDFwPqJN8HYmjKNcjDCKTcHgiI+1q9jNL0v
         VCsNVvhZH2oqfLA2TuHgpsG3wsgpRhQaIapnaotGcJEj/k0OPXN4Rfy8vAKwQYduC1cB
         p0P4uJ0Iy+Ee3Rw740fr2LdYtNfhk0RpSo7SvXBe36Ja9t2LGoBlmmr8hdV8GEQejkaw
         XKx8ZMzvzZ0kVGCAEWFiI6Pws79FNYZBf/4Fz17ppBhSbI0XyeNMNUf8cO9+cMPwcckN
         4jiai9N3q3jSpTPOtZc9GpZEGaqNafMnkTo0Hap1HL6kOXAT9ISuxN2e8K3YlfVwxSSC
         18bg==
X-Gm-Message-State: AOJu0YyDzVDVlJzvIXbG4OK7FfdV/rPI2pDon3bcfhpOMDAF4cGuyz9T
	tslvlOMXQALVdsns/vv6NIrDB6PwFStwEuYzrgxt+uT0SsOpmQ==
X-Google-Smtp-Source: AGHT+IF3FBzrMaCLiZsZn2QO1HbliJx8eevMzxoBDHbU8qLUWtN/6V0qU7QemeuQaYTOe3s7ypkdwkWCAQzUxQorL3M=
X-Received: by 2002:a81:4e8f:0:b0:5ff:7a0c:b610 with SMTP id
 c137-20020a814e8f000000b005ff7a0cb610mr489485ywb.31.1705510831859; Wed, 17
 Jan 2024 09:00:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103-genpd-perf-order-v2-1-eeecfc55624b@gerhold.net>
In-Reply-To: <20240103-genpd-perf-order-v2-1-eeecfc55624b@gerhold.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Jan 2024 17:59:55 +0100
Message-ID: <CAPDyKFrycE-ONA753Z4tnYP5_NsRCtSfGr12ctFNDftvEQL8Gw@mail.gmail.com>
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

Thanks for posting this - and sorry for the delay Stephan!

I just wanted to let you know that I am looking at this right now and
will be testing this on my end too. Allow me a few more days - I will
get back to you again, asap.

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

