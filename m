Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062C47DF548
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjKBOrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKBOrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:47:51 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12042B7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:47:46 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5a9d8f4388bso707955a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1698936465; x=1699541265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BwaYXZPU1hQEMGgRdu2M9aQmHUJvo+2fE01ng2l9LSs=;
        b=KhJhhdY9DT0PqmgJ2oumKZFWrJGjEIEhgi7nxs7cZgybRtReS6jGSLn8ku4bUZdR6f
         5om2rloiD6XGlvENi+eneoBA5q0Y9cFlz97NVLIhqHy2uzXufp3Hz1uEx29d1jlR6q/p
         gM6j0K5cdhxvEv1NgpOANk06kQr5t77v0MD57+hED6Z4bfGBBo7jfvZod54Iq9GskP57
         jdytEHybyLK0OLz9NChhSJI6sRhkPsWIBgOvOgwKW41U31u5FFq6GJl0/SRDhiuKIlS5
         GVE2p8aX2UWQ34s34OprcyPwLCJNNivY5G6dDNuifqr/Vwdtj8zNA4m2w+BnImzcfMl9
         hwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698936465; x=1699541265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwaYXZPU1hQEMGgRdu2M9aQmHUJvo+2fE01ng2l9LSs=;
        b=Cxuv54NW77qFe/IuuBwkvH/41Gdt1/7CFj9EE/oMv/mFI3AV0H/SE5ezgWhxWCcaSU
         HQQXYTpJv5M5vd2CInyLYyIPGs98TYSqbWz3SDPdzctdMBa6GbAYcjD3NQOdCesYRggu
         6skohYdSDYno7FoojvaW2uOBWaYjMbC46NSVyKMsb96ZQabABcRQ/CIBWBc9IDhevVV/
         5LEABTYEsRoCHdXg2qs6Bf5YfmOuZ1m7mJvRpWss/vqK85WS0gLMXs5qmBuFtRMqZUhK
         ywcvsVQNvN6dsSqNJa253mx1giXYtoo0xFv+PtkAfE+jYbeKO9NXYE3/Q7OSbxIyXIji
         pR0g==
X-Gm-Message-State: AOJu0YwzjbP9AvXVJLnxxhe35ooxs5NCGmg1CDpYurfca8us912apgK6
        iQ6/jSgQe2SmyO1QMDkryCZ/ZWwqM14wGXQUSZ1IAQ==
X-Google-Smtp-Source: AGHT+IF0J0Hf/2LNLeY7moJtwauXVxOaPGXnoAxx/IarWXU3Ll50LDNuuF8+cq0y8E3b4QJIBmg6sf3utcFF+2I+Zzk=
X-Received: by 2002:a17:90b:38c6:b0:280:1df1:cbc7 with SMTP id
 nn6-20020a17090b38c600b002801df1cbc7mr12800756pjb.19.1698936465526; Thu, 02
 Nov 2023 07:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231005133059.917577-1-naresh.solanki@9elements.com>
 <f8dd6d53-7c0b-4a89-9ec4-400aa242c020@sirena.org.uk> <CABqG17iufSniSLZ2vU5fFduFwV2FL8jNzMcsveOgFUME1jXmgg@mail.gmail.com>
 <aa3f5615-dddf-4c94-88c7-494cf7cd80ab@sirena.org.uk>
In-Reply-To: <aa3f5615-dddf-4c94-88c7-494cf7cd80ab@sirena.org.uk>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 2 Nov 2023 20:17:35 +0530
Message-ID: <CABqG17h949R+3NFgA1MvPLZFc6zkBi+WRPSE9qP4fCBv5gdXHw@mail.gmail.com>
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

On Thu, 2 Nov 2023 at 18:36, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Nov 02, 2023 at 05:35:42PM +0530, Naresh Solanki wrote:
> > On Thu, 5 Oct 2023 at 22:30, Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, Oct 05, 2023 at 03:30:58PM +0200, Naresh Solanki wrote:
>
> > > We probably should filter the events more, there's events for pre and
> > > post voltage change for example which aren't status changes so would be
> > > spurious.  It ought not to break anything but we should still avoid
> > > unneeded work.
>
> > Can you please provide me inputs on the additional filtering needed for this.
> > Like some list of events for notify on status?
>
> I think I'd start off with just reporting things that are obviously
> errors and not things that should ever go off during normal operation.
This is what I could come up with:
        if (event & REGULATOR_EVENT_VOLTAGE_CHANGE) {
                name = dev_attr_microvolts.attr.name;
                sysfs_notify(&rdev->dev.kobj, NULL, name);
        } else if (event & (REGULATOR_EVENT_DISABLE | REGULATOR_EVENT_ENABLE)){
                name = dev_attr_status.attr.name;
                sysfs_notify(&rdev->dev.kobj, NULL, name);
        }

Regards,
Naresh
