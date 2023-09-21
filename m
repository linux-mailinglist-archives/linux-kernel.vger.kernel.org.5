Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE1B7A9E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjIUT40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjIUT4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:56:08 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6819D7DAF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:29:15 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d815a5eee40so1494631276.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695320955; x=1695925755; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C3AGJ5YqreaKjGqVvvBcJoqmWbVP9NW6r7+ZQpOUS+4=;
        b=GGNT+nBkfIjI7is7u45fqw3D7HCvj0+jnBRkgxyMqT2M4iz05T4284QXI1vVKtekRH
         Hx+98Z+pudKX9moXYpC89AZBxBHO8wvLUNG3MTOL5ltJVaGORkagCtZX5TiD4Ve8N6rQ
         tjRyPv7htEUfOp+1RXRElHc3oLLgCBvwJ4XEIEUgf+ULKvYj7vOTJbihjf12Pr17o48x
         2A0BERxxtyYPUGBNboXraPNcWlMwwDMhq/+h7743fLzsKGsrLsNGb+bzwG39OOTe1tzv
         1aLLr8hlehv4XH7f6R6+ZGIPUuEamV/YijgZuUGyDpARtnc8bX6ugPXdhK4dVuPECNeN
         g/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320955; x=1695925755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3AGJ5YqreaKjGqVvvBcJoqmWbVP9NW6r7+ZQpOUS+4=;
        b=w7qbiQcozMeRn11GaPgG969SYe3xrFAdtmCkdk484NFqFU5WlWMsUh47gpPKWZpemw
         IGtrWLpxxHTQ2n83x2uexmx4eiEAzC3o34Dg7weyhFqsHTZEgEdKftKV6K8uJLWgzL48
         KblBxVovGHn9PcEDd0sNNv5O/Vq0zpr7AeFaJKI8W/fIx38IACQOAqqEsygwAsTsbhCQ
         /jZZd+woOwwzL97zgQuEbase3l2m+nv1dHC/iePowgAd3N/IMLwlCFHjKI0lxwaIZXRc
         Rfm0HZdlGqkZdf3Orr/0i9dXXSv2QelCS3ZpLc/ycwlMC0irUc/JRxvvqtCBKqVKf7Rt
         ntvQ==
X-Gm-Message-State: AOJu0YyMYtkiCwRoh1FKexW7FHT+iF11qSWWrepPppvVzCIbW17lqAPg
        TBIU6aY9036utJOSaf1y6K24IYWuSPKAXjOHnZB+PxpuPh8xU964fZk=
X-Google-Smtp-Source: AGHT+IGxEP7M4RGeRIoS5MoOfdR/G92y7IkWBKiScp+pN2700H3k/FEmydtbEwKJZ/XQkDiYo3ii4LoHbD1J2F0GMzI=
X-Received: by 2002:a05:6902:100c:b0:d80:68d1:b826 with SMTP id
 w12-20020a056902100c00b00d8068d1b826mr6552250ybt.6.1695301553511; Thu, 21 Sep
 2023 06:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
 <20230825112633.236607-13-ulf.hansson@linaro.org> <20230921112019.gftlr5ys3yw2nwgw@bogus>
In-Reply-To: <20230921112019.gftlr5ys3yw2nwgw@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Sep 2023 15:05:17 +0200
Message-ID: <CAPDyKFpkjOFhjKMY=4dDgngi7PftE_4c+4dHE2KcGAGYnjk6-Q@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] PM: domains: Allow genpd providers to manage OPP
 tables directly by its FW
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sept 2023 at 13:20, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Aug 25, 2023 at 01:26:32PM +0200, Ulf Hansson wrote:
> > In some cases the OPP tables aren't specified in device tree, but rather
> > encoded in the FW. To allow a genpd provider to specify them dynamically
> > instead, let's add a new genpd flag, GENPD_FLAG_OPP_TABLE_FW.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v3:
> >       - None.
> >
>
> Just checking if I need Rafael's ack here or that is OK as you are
> co-maintainer ? Again asking explicitly to ensure arm-soc is happy when
> I send PR.

This should be fine for you to pick up. Rafael would have objected if
this was something that he didn't like. Moreover, there's no other
patches being queued for genpd at this moment so no worries of
conflicts.

Kind regards
Uffe
