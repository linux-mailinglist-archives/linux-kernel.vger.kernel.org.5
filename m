Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8315678F2B4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347067AbjHaSe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjHaSeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:34:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EBBE64
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:34:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-271914b8aa4so825024a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1693506862; x=1694111662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=libU7Rt7ZI5S+r4uHABLMi5BcLRzKen88gKTlWDNkJM=;
        b=f8WJPwYycEp8Wl8b4Iy2zXEcGNIBgK/rKE1RZD/2p1ehA3N99E0OLlsISYivE+aOyH
         emKvs8sGZX1NdsMcBtNvNA0FXbeVC8rfR74dvW0fDABAw+EcQH5lJlXBgdlYsLP3VvvI
         x7qjwHJ+PYkN257PBFU7SteBM1W7yxJvmDFCyF/qcTgAn7FUSxB6XtIKk46gIgue5I2j
         1nHkRDxYW6dfWKW+6U3058DfQMN4RuqkuszgNJe0sJEaTaLNYg/htyTsJmK0dJIHUhQ3
         U0yl2mrjxtBRGi/EVVgDdF4AOZcbb3LpptpAJOYc/GvsK8I+edsBqTr99itWMKBLaK5L
         LG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693506862; x=1694111662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=libU7Rt7ZI5S+r4uHABLMi5BcLRzKen88gKTlWDNkJM=;
        b=WW8nIKSoQmhw6jRDHJGtepKX97wTGgN834odTs+1snnpsRlUBDPJEOHlDPVx1Ofvri
         OrdtAwUIQqphpaj2xPvz4z4oNGgLWEsaCZlAU1qLtvs+jBjLvCk65kxSfTmCd8qCc8t0
         xOXopauxsHhDunYjVVaOqpODFB09UN9wWrIQgMBk2F0TD/b3EyckM6GRV/f6tFr/9GDL
         MI3LdnB+q/Ry9BEL558CYKjRgEg9W8ZIbT3moV85nAba8k6ffUb8sUXx1oUhnqtzDJQH
         HpYnv+iLLv5NOwzkEDDEKlXscKIrmPu2cXYk0b/RQqmHtmLTCgR6OoDx8RCG53lVRJrR
         0rMQ==
X-Gm-Message-State: AOJu0Yx9Vez3MytJkvH51oR9rKqr5vD+X4gdrVY+XVZTvhju+HKf2Af0
        QvloGmncsqHEBrQSALrs2X2Es2lvF4KRUgjpZ0PQvWWOrOkKzrNOzpCm5O77
X-Google-Smtp-Source: AGHT+IHPow69FStqp53qeys+PTI6Rp+jbySd/IKrYP66LcErfTXPdQQTwmnk1bpH/dV5yxggud2kmZd4Oqpox52Bias=
X-Received: by 2002:a17:90a:1c16:b0:262:f798:b60d with SMTP id
 s22-20020a17090a1c1600b00262f798b60dmr176631pjs.6.1693506862088; Thu, 31 Aug
 2023 11:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230831121412.2359239-1-Naresh.Solanki@9elements.com> <813261e9-71d8-4fb6-aab0-474915662598@sirena.org.uk>
In-Reply-To: <813261e9-71d8-4fb6-aab0-474915662598@sirena.org.uk>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Fri, 1 Sep 2023 00:04:13 +0530
Message-ID: <CABqG17hrfLMynD0OKurfR2694ak0LN0pnpK82DOPqDAW-rhO0A@mail.gmail.com>
Subject: Re: [PATCH 1/3] regulator: Add uapi header
To:     Mark Brown <broonie@kernel.org>
Cc:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
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

Hi


On Thu, 31 Aug 2023 at 18:05, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Aug 31, 2023 at 02:14:08PM +0200, Naresh Solanki wrote:
>
> > +#define REGULATOR_EVENT_UNDER_VOLTAGE                0x01
> > +#define REGULATOR_EVENT_OVER_CURRENT         0x02
> > +#define REGULATOR_EVENT_REGULATION_OUT               0x04
> > +#define REGULATOR_EVENT_FAIL                 0x08
> > +#define REGULATOR_EVENT_OVER_TEMP            0x10
> > +#define REGULATOR_EVENT_FORCE_DISABLE                0x20
> > +#define REGULATOR_EVENT_VOLTAGE_CHANGE               0x40
> > +#define REGULATOR_EVENT_DISABLE                      0x80
> > +#define REGULATOR_EVENT_PRE_VOLTAGE_CHANGE   0x100
> > +#define REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE 0x200
> > +#define REGULATOR_EVENT_PRE_DISABLE          0x400
> > +#define REGULATOR_EVENT_ABORT_DISABLE                0x800
> > +#define REGULATOR_EVENT_ENABLE                       0x1000
>
> I'm not sure embedded the raw numbers in the UAPI like this for just one
> driver is ideal - it might be better to do something string based,
> though that would result in us ending up with a file per event which is
> a bit noisy.
I guess this is the standard approach & can be a starting point for
future use cases.

If you still insist on string based then can you please elaborate on it.
Is the events attribute is expected to print string of space separated
events like
for REGULATOR_EVENT_ENABLE -> ENABLE
And even multiple events like: 'UNDER_VOLTAGE REGULATION_OUT'

Let me know your thoughts.

Regards,
Naresh
