Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4277CAC35
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbjJPOvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjJPOvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:51:01 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D686AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:51:00 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d84c24a810dso5428150276.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697467859; x=1698072659; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t6TpPo/vwkpHV5qsDs+Hl9dfgpdTK0YrBJIlUco4xNY=;
        b=jCn5ur0sLrGJABlZm7RnqCCu2I/NG+doobbQOLTr8Hw6dVvi3WEm7LI1ybbElejTxW
         Jo51iG/900rXfe+K0oCehNeE70cN1dv5YEdGs37BJpGydrg0B4PPiqVtOAZElaiEISnI
         OKrczFeXIK58SKNHJQzD3nIe2TMwlWMH0ZX0N1JVc0/5iE+ENISwuG5dwZbFqbnhILow
         fRlTK3chKSlL68ry11XH2AP0WUciehx5kCugL/Podl3Cw3fUnPgYt70p3g3a2qUL0VSw
         rVFLkp36o3kVQlUW/ege8rS5NU6qex36cWvB9zx+Eq1WXPbmxZVcbOQjPQhYzeNltQQ6
         dWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697467859; x=1698072659;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6TpPo/vwkpHV5qsDs+Hl9dfgpdTK0YrBJIlUco4xNY=;
        b=pd451ZR9jxV1+1b47KbBw0bkwwLQGx+rCqnBR+2sAE2iEE62iG5k3+H8Aaf7Kr+/8u
         2qhDifo4TNe+EliSBTEeTliGxjw/lBh9nBwQW8Olkx5Kf06KO0hBTtB2sIGjYc7UrosW
         W9oUwDIsVr0re8MC4tZfKe0Z8vz05s7vRQlfn2eHb+kU0pzCQQmEbc3+QEohVtka5LZY
         K3CLzdptaoVSBT6A0B1fUWcJv7dyaIFY2kitp7oRsfJUiDs/s3OlTyLlpz7IpJUZZehy
         +sJw25n94wHpUtFejgLsyq7k/H8eKslTO3IzUyYwTlFHwHeQ2sz6fn8ycW+HQ/PdbBpW
         DRpA==
X-Gm-Message-State: AOJu0YyeyFEAK78XWOwkOzLpY+jB5r4maK1OjtC1wI+2AgLj6Oocvly7
        c/9XOemDyw3/RavgkNyxfLbPvlpacWoJyzo/+P+tMw==
X-Google-Smtp-Source: AGHT+IHg2RkjtSbBnb2/FY+1Wt+X2XCXGEaHzpUDXik6p3PxtIxp31icp7RW8ZnWPE0omSZ+etrx0B9s/BE4V5eqSDE=
X-Received: by 2002:a25:75c2:0:b0:d7f:c4ed:d6af with SMTP id
 q185-20020a2575c2000000b00d7fc4edd6afmr31109979ybc.40.1697467859708; Mon, 16
 Oct 2023 07:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697186772.git.viresh.kumar@linaro.org> <a5bd698a7a899fb63b4c5caec7068bf5a395165c.1697186772.git.viresh.kumar@linaro.org>
 <CAPDyKFpHy-32h+yu4X-psGqpaqFNpY0CgveHgd_3Zu57KPg3Dw@mail.gmail.com> <20231016103813.mz26xhfzfca7c7kf@vireshk-i7>
In-Reply-To: <20231016103813.mz26xhfzfca7c7kf@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Oct 2023 16:50:23 +0200
Message-ID: <CAPDyKFrSmXVy6gE_ZzH-hEMmdjw+F-q+bpR=QVMUGrQj8-ct6g@mail.gmail.com>
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

On Mon, 16 Oct 2023 at 12:38, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 16-10-23, 12:11, Ulf Hansson wrote:
> > Why always return 0 and not the error code anymore?
>
> Oops, fixed with:
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 3516e79cf743..42ca52fbe210 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1076,7 +1076,7 @@ static int _opp_set_required_opps_genpd(struct device *dev,
>  {
>         struct device **genpd_virt_devs =
>                 opp_table->genpd_virt_devs ? opp_table->genpd_virt_devs : &dev;
> -       int index, target, delta, ret;
> +       int index, target, delta, ret = 0;
>
>         /* Scaling up? Set required OPPs in normal order, else reverse */
>         if (!scaling_down) {
> @@ -1105,7 +1105,7 @@ static int _opp_set_required_opps_genpd(struct device *dev,
>
>         mutex_unlock(&opp_table->genpd_virt_dev_lock);
>
> -       return 0;
> +       return ret;
>  }
>
>  /* This is only called for PM domain for now */
>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
