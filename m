Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF587F67D3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjKWTuJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Nov 2023 14:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWTuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:50:08 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA55091;
        Thu, 23 Nov 2023 11:50:14 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1efba24b038so279087fac.1;
        Thu, 23 Nov 2023 11:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700769014; x=1701373814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPnVIP7WE+e1m6kbF0iZl32seDul9DiRZGTrCiOrxg0=;
        b=FNIWBW2c7Kj6ZofayiRNXObglnaSc+VU/SNbg0ft6JE7UTzJc5Mebgwio3mbx1OjpK
         6zs8uu89SJPbQRvoflVlE8chKohmuZgGOgSR9+5PXUXDWawDo8Tf8MgMZyPCKM9JJ1f4
         GvlDXoxOEI0JMhAYQrhvBq+hWEZC9vXXmmvZFIp/+ht1a2qNnPJXYhmhaEkpS8TC4zpD
         Y4OdVYauiQ7/HaUyK9oQFpWhtuOwEv2I0IbJ3F7MpArbSnF5PO8wVKnsHWq8HbVtsvom
         leRFITfw7BAGE3PhPFRFVsXS6J336C04r3Fhf24HrS+cktjJnSFn4KCjt/s8hvqYi29M
         awug==
X-Gm-Message-State: AOJu0YzMXzcUP4hmO2AxCShoIGz0fHgEORzW1hXUyAlY1rAzyYuOLYMy
        WVBIOiBWF0GWAUg3fptvOEqaNRQuRgBOOa8pg931+S1/
X-Google-Smtp-Source: AGHT+IFUFtQSgD+W8Yy8QPiwQE4p1RlFzJFt/GSUiRGPuyvIdEEMv1z9wpYE6RAlbcCC6n75J8HSPBnaL6jFaFWFHNM=
X-Received: by 2002:a05:6871:530f:b0:1d0:e372:6cf8 with SMTP id
 hx15-20020a056871530f00b001d0e3726cf8mr463783oac.2.1700769014104; Thu, 23 Nov
 2023 11:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20231025192225.468228-1-lukasz.luba@arm.com> <CAJZ5v0gniBtFduwjhDku+OZzjvkCaFK7ew0uJTfW254XKTOyyw@mail.gmail.com>
 <ce8f1a13-b56f-4419-a954-8d987af44112@arm.com> <5fd9ce52-9216-47ae-9ed3-fabb0f3b02fd@arm.com>
In-Reply-To: <5fd9ce52-9216-47ae-9ed3-fabb0f3b02fd@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Nov 2023 20:50:01 +0100
Message-ID: <CAJZ5v0jL38PgFYVXFj2Py5NvUU0xFGU45w=TdcBXqr7v+xToag@mail.gmail.com>
Subject: Re: [PATCH 0/7] Minor cleanup for thermal gov power allocator
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Thu, Nov 23, 2023 at 4:19 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Rafael,
>
> Gentle ping
>
> On 10/26/23 13:22, Lukasz Luba wrote:
> >
> >
> > On 10/26/23 09:54, Rafael J. Wysocki wrote:
> >> On Wed, Oct 25, 2023 at 9:21 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>
> >>> Hi all,
> >>>
> >>> The patch set does some small clean up for Intelligent Power Allocator.
> >>> Those changes are not expected to alter the general functionality.
> >>> They just
> >>> improve the code reading. Only patch 3/7 might improve the use case for
> >>> binding the governor to thermal zone (very unlikely in real products,
> >>> but
> >>> it's needed for correctness).
> >>>
> >>> The changes are based on top of current PM thermal branch, so with the
> >>> new trip points.
> >>>
> >>> Regards,
> >>> Lukasz
> >>>
> >>> Lukasz Luba (7):
> >>>    thermal: gov_power_allocator: Rename trip_max_desired_temperature
> >>>    thermal: gov_power_allocator: Setup trip points earlier
> >>>    thermal: gov_power_allocator: Check the cooling devices only for
> >>>      trip_max
> >>>    thermal: gov_power_allocator: Rearrange the order of variables
> >>>    thermal: gov_power_allocator: Use shorter variable when possible
> >>>    thermal: gov_power_allocator: Remove unneeded local variables
> >>>    thermal: gov_power_allocator: Clean needed variables at the beginning
> >>>
> >>>   drivers/thermal/gov_power_allocator.c | 123 ++++++++++++++------------
> >>>   1 file changed, 64 insertions(+), 59 deletions(-)
> >>>
> >>> --
> >>
> >> The series looks good to me overall, but I'd prefer to make these
> >> changes in the 6.8 cycle, because the 6.7 merge window is around the
> >> corner and there is quite a bit of thermal material in this cycle
> >> already.
> >
> > Thanks for having a look! Yes, I agree, we can wait after the
> > merge window. It just have to be cleaned one day a bit and I postponed
> > this a few times, so no rush ;)
>
> I've seen you've created the new pm/thermal. Could you consider to take
> those in, please?

Sure, I'll get to them presumably tomorrow and if not then early next week.

> I would send some RFC on top showing the issue with reading back the CPU
> max frequency from the PM_QoS chain.

Sounds good.
