Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15A77AA00F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjIUUbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjIUUbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:31:19 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26467ADC70
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:04:36 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d776e1f181bso1558712276.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695319475; x=1695924275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F2iVUKRDazi3scGbQVKzP0TAbm4bJPvzK2OVT1wMEJk=;
        b=ihCE/CO6f0msFcDogY4QtRpMIRxcqeKg28OLw3FLeHy5UtGUzqEEHj5/HxQHdrFhuM
         UGWbPwm9sLMU1ziBNOPxeeNcX/YLtEngKbexspepy8x2zePYE6FWKEYmHO6vVt7a+8Ty
         VJSs/yAJHdPIKmnGEwzVEoldYGhJQ9HPCVITRzzDmsWM2o/3YZ10sD36P9i0Plz8XEr9
         3M9jp2zVqV5/flLouzwLLPUye8+/YnLYJIwG4whufhhpTjUziqCUCQwxlUz+cWYqNpvw
         wjgDjGiFIIUXbMqzTG9FtjLHmOI4qtEM1mpoiYuMYzYucVLJe9fykqx1ILB/iZLlZ8iu
         xUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319475; x=1695924275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2iVUKRDazi3scGbQVKzP0TAbm4bJPvzK2OVT1wMEJk=;
        b=RwRRC9ELErH4u956rd10nvx9F2TIZ/48mmaHLoxHuCllQb43MW1g5i4Y4nzg3SHydj
         JFquA0mgeCMMDguIHk19x7a1qIbwgClOKifWJz31P9iw6tG/s5WSENYeY042DPIfywjV
         Wv9grujQYUuNxJJvYl5YkxscSzTZmHRrsVgaA46Vv8SZ69nbMiMJiHWvIh8LGGHAR4nL
         Q2Sw/H0g5wH7HUpzGhLMj1j0jeDqfCiNP7IaHbG3OVn1GVLtB4zxbptTpzEUC5u98chG
         I+POHfh4fFZ7d2p66s5hGmeLOY6WrnU7E/8IL3MuyRYsWRUDg4733yOVGtpZ8aDV35zs
         82bQ==
X-Gm-Message-State: AOJu0YzSemNmxsuCH3UznOmwSc7LNjfVJz0Gm537Ctj8a2l+uEvvqkEC
        F1odJqfC1tgwrIkddoRgr+iux//PHR/QxOkljBdSboZtnTpHSojuqic=
X-Google-Smtp-Source: AGHT+IGBGzSSuWFuR2CMHZuIrQTlTZeWSJ2mzK6C15pX7OZvwpMOeVL7zOjvauq3dqsE+276vjD7PnFCpmTJ4T71ZBo=
X-Received: by 2002:a5b:f91:0:b0:cf8:1070:82d3 with SMTP id
 q17-20020a5b0f91000000b00cf8107082d3mr5445675ybh.32.1695303482171; Thu, 21
 Sep 2023 06:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230919121605.7304-1-ulf.hansson@linaro.org> <20230921113328.3208651-1-sudeep.holla@arm.com>
 <CAPDyKFrGDZzyp4G1fS5PGCE95b3_w4kJyZfnDs=BEuYLzJ7uXA@mail.gmail.com> <20230921133343.h3chbszl2iuf2b55@bogus>
In-Reply-To: <20230921133343.h3chbszl2iuf2b55@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Sep 2023 15:37:25 +0200
Message-ID: <CAPDyKFrQAKhofKikc4xV5o=oqAoGOfD9XLiqHNUSBmeCmWE5-w@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: Move power-domain driver to the
 pmdomain dir
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
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

On Thu, 21 Sept 2023 at 15:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Sep 21, 2023 at 03:10:56PM +0200, Ulf Hansson wrote:
> > On Thu, 21 Sept 2023 at 13:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > To simplify with maintenance let's move the Arm SCMI power-domain driver
> > > to the new pmdomain directory.
> > >
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Cristian Marussi <cristian.marussi@arm.com>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Feel free to take it through your scmi tree!
> >
> > Note that, we should move the Kconfig options too, but that requires
> > changes that I am carrying in my pmdomain tree. We can either wait
> > until the next cycle or you could send your pull-request to me this
> > time (instead of through arm-soc), then we can fix this as a late
> > minute change. The decision is yours.
> >
>
> OK. Lets us just delay SCMI Kconfig changes for the next cycle then. I assume
> you would have other changes merged by then. Or may be as a fix as it would
> be hardlt 10-15 line with 2 Kconfig options. Let me know if you disagree or
> have other ideas.

Let's delay, it's probably easier. Maybe a fix for rc1 would be best.

Kind regards
Uffe
