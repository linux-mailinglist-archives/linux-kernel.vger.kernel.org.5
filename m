Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F817DF1FE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344379AbjKBMH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbjKBMHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:07:00 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ECA1BF5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:05:53 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-28003daaaa6so843222a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1698926753; x=1699531553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RvVgx9g9NA7N3/n80mpWy1Rln6NY9q3dd5rFRvIdV3Q=;
        b=fXcgOg6ToD4gx045r1GL4Pc7yetQYcXmK/IA5ikQTBcTvJ3SnFKva2SSB9YRulvMWE
         jHtK+7iDJxrLTgdFbp6iTIHkso+9AyBw4h8lLfRVaQ38m1la2jOthvAzKiN0CAQ88/w9
         DfCFuIT6oQilwdplJ7bhQwFGFtXbs7WzcokW7PqwySbxgLQoHn1pD7qtRfKKGAJDU6b8
         LUIyD7+NRQJKHBtPtLoNtOnfILljrC+A/ETi/vdj122VA5dRih72yw+4dxROaQCHnUym
         TgmXio/D4sDbGldvio2QCixX42ghrMsEF+q1b//sXZyKhQaT2UGfuNybm4UnH7pmhVYj
         Vw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698926753; x=1699531553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvVgx9g9NA7N3/n80mpWy1Rln6NY9q3dd5rFRvIdV3Q=;
        b=lGXQamsVV8tM8SvvPvP8wRWQDZ15qEJsueYCBwEcs27d56ntNQaqnRqtY9/helVmxf
         p6Z9kPfiRYqHhUUTswfEduFpERLUG0wFF/sC0/zOzLZc2zTPJ9lA5A/95gSBoc0Dzzfi
         CHLS7WDkJrzSztI4HG90AVO0oC/KL7Q6fvyB48efvRP3uiIqaUUkeeaR+3tNkdbKwGbR
         fqNn2uieoljh8tBz+15JIcPOdvwbtMd1BHxQ3Eyv0okBVQrY7DZPYARc2KkcbcuWvwf4
         S/wExDtsLc0wQgZ/pj8LVVJvKi2WuEsEq7vSqdsA8O01l/xpfF2cEneC/0n0HDQhcqXq
         ktwg==
X-Gm-Message-State: AOJu0YzfxjnrlKbcGCQkaQ76e4W05TXSrx3G6aY65TszUEEdhBbXx9Vn
        iny5WhaJmtAY5rR33iFGoGab3SJx9sNCr/dFigHNhsT7YVc1ivVi
X-Google-Smtp-Source: AGHT+IH5TGXlu6HwCJsma6xxBplALVQdeqhfS/E8+fYdsbS3z2wug9/dWKAiudsmxwRA5GX34Tx50oENdayn877xFps=
X-Received: by 2002:a17:90a:f48d:b0:280:46ac:be71 with SMTP id
 bx13-20020a17090af48d00b0028046acbe71mr11392356pjb.15.1698926752570; Thu, 02
 Nov 2023 05:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231005133059.917577-1-naresh.solanki@9elements.com> <f8dd6d53-7c0b-4a89-9ec4-400aa242c020@sirena.org.uk>
In-Reply-To: <f8dd6d53-7c0b-4a89-9ec4-400aa242c020@sirena.org.uk>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 2 Nov 2023 17:35:42 +0530
Message-ID: <CABqG17iufSniSLZ2vU5fFduFwV2FL8jNzMcsveOgFUME1jXmgg@mail.gmail.com>
Subject: Re: [PATCH] drivers/regulator: Notify sysfs about status changes
To:     Mark Brown <broonie@kernel.org>
Cc:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, 5 Oct 2023 at 22:30, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Oct 05, 2023 at 03:30:58PM +0200, Naresh Solanki wrote:
>
> >  static int _notifier_call_chain(struct regulator_dev *rdev,
> >                                 unsigned long event, void *data)
> >  {
> > +     const char *name;
> > +     int ret;
> > +
> >       /* call rdev chain first */
> > -     return blocking_notifier_call_chain(&rdev->notifier, event, data);
> > +     ret =  blocking_notifier_call_chain(&rdev->notifier, event, data);
> > +
> > +     if (event & REGULATOR_EVENT_VOLTAGE_CHANGE) {
> > +             name = dev_attr_microvolts.attr.name;
> > +             sysfs_notify(&rdev->dev.kobj, NULL, name);
> > +     } else {
> > +             name = dev_attr_status.attr.name;
> > +             sysfs_notify(&rdev->dev.kobj, NULL, name);
> > +     }
>
> We probably should filter the events more, there's events for pre and
> post voltage change for example which aren't status changes so would be
> spurious.  It ought not to break anything but we should still avoid
> unneeded work.
Can you please provide me inputs on the additional filtering needed for this.
Like some list of events for notify on status?
