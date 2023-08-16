Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0476177E5A7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344427AbjHPPu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344429AbjHPPua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:50:30 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9042D6D;
        Wed, 16 Aug 2023 08:50:14 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2681223aaacso4512173a91.0;
        Wed, 16 Aug 2023 08:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692201014; x=1692805814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEohQI3NAdv35pnfkbCoDXE/h5uAREoOsMxQ8xvIZY8=;
        b=EgKmEeDfOazGq5uLbR01xSj/QK6VeK1mCysK5ZUWFM3ysweVXEaZ9uUAl5Pof25nQc
         84vLLBcc0oRJEs9Vu3CTsyU5J5kB34X5h4umaRnBjxWIJDmslHb5gS3Pwru3yldUvJcf
         +3RN96h77DApM0K/WyrcWjkDGAQUTZgSJEsF4atTJgRMDnvOtzSZApklUYtaxarGmFs9
         4z8k/mVXbM3Hrkv3vm0BOJGeOp4czwu7swzpb6cYb9tb5QjOI+qE9pAZSg15QSyajd4H
         2QvVIhcSBuKs338w5o6UZGtgSXKOJJn1M1o9A3o+FO/xLkjs84gCGmW+Mvls71OQr0Px
         RTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692201014; x=1692805814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEohQI3NAdv35pnfkbCoDXE/h5uAREoOsMxQ8xvIZY8=;
        b=JDNaB52t9WTwMXBiZUUO3ODZWSPFPjRQwU30vWWxJCvr5JqdyJT/py7rA6Ox/URmZP
         Bhga+6FaVo8kt7CE7ccEPOVlELP+aDk3bQpM276HMgtQ09tkEAKSbtot+DuhzIFYHeUl
         aJtDCRGyWap7vZ1ZScOtP4jd000/hKTAQ03EMx2Hmf+2VAQr2sQuwJyCai4ktJ9jomt5
         TwPtE95fYx1qxLeEi3phcvhRjL2GeG7ET0DUoM9PJcYfYF6e5nbm33C86WMtmfkadmVK
         UbM/GaPaxqQDp7H6J1xsO+/VzI/m70jzU2TbHxyJg2WL8z+g46wEMOPa+cdgZAQgvGPe
         pCSQ==
X-Gm-Message-State: AOJu0YxdxiqzZpEg20C6EMVLE8pNYo6TpclNHOTzQC3EZ5eEW8qyrrHP
        Xat7yxm8oaibQBi/kBrUZFg=
X-Google-Smtp-Source: AGHT+IGSMdQKf/ClfcmNH+AsywNOAdUlm3AF4v/Sx0H86wTrmhqjohRzEeHwEw1UhsmvckPxxxOiCw==
X-Received: by 2002:a17:90a:9a81:b0:26d:d3a:5e48 with SMTP id e1-20020a17090a9a8100b0026d0d3a5e48mr493159pjp.15.1692201014294;
        Wed, 16 Aug 2023 08:50:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902728c00b001bbaf09ce15sm13403257pll.152.2023.08.16.08.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:50:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 16 Aug 2023 08:50:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 0/7] rtc: Add support for limited alarm timer offsets
Message-ID: <8079bdf4-f790-451b-a2c2-be4e23c0c3a1@roeck-us.net>
References: <20230816133936.2150294-1-linux@roeck-us.net>
 <20230816150353137debc5@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816150353137debc5@mail.local>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Wed, Aug 16, 2023 at 05:03:53PM +0200, Alexandre Belloni wrote:
> Hello,
> 
> On 16/08/2023 06:39:29-0700, Guenter Roeck wrote:
> > Some alarm timers are based on time offsets, not on absolute times.
> > In some situations, the amount of time that can be scheduled in the
> > future is limited. This may result in a refusal to suspend the system,
> > causing substantial battery drain.
> > 
> > This problem was previously observed on a Chromebook using the cros_ec
> > rtc driver. EC variants on some older Chromebooks only support 24 hours
> > of alarm time in the future. To work around the problem on affected
> > Chromebooks, code to limit the maximum alarm time was added to the cros_ec
> > rtc driver with commit f27efee66370 ("rtc: cros-ec: Limit RTC alarm range
> > if needed"). The problem is now seen again on a system using the cmos
> > RTC driver on hardware limited to 24 hours of alarm time, so a more
> > generic solution is needed.
> > 
> > Some RTC drivers remedy the situation by setting the alarm time to the
> > maximum supported time if a request for an out-of-range timeout is made.
> > This is not really desirable since it may result in unexpected early
> > wakeups. It would be even more undesirable to change the behavior
> > of existing widely used drivers such as the cmos RTC driver.
> > 
> > The existing range_max variable in struct rtc_device can not be used
> > to determine the maximum time offset supported by an rtc chip since
> > it describes the maximum absolute time supported by the chip, not the
> > maximum time offset that can be set for alarms.
> > 
> > To reduce the impact of this problem, introduce a new variable
> > rtc_time_offset in struct rtc_device to let RTC drivers report the maximum
> > supported alarm time offset. The code setting alarm timers can then
> > decide if it wants to reject setting alarm timers to a larger value, if it
> > wants to implement recurring alarms until the actually requested alarm
> > time is met, or if it wants to accept the limited alarm time. Use the new
> > variable to limit the alarm timer range.
> > 
> > The series is intended to solve the problem with minimal changes in the
> > rtc core and in affected drivers.
> > 
> > An alternative I had considered was to have the alarmtimer code guess the
> > maximum timeout supported by the rtc hardware. I discarded it as less
> > desirable since it had to retry repeatedly depending on rtc limitations.
> > This often resulted in error messages by the rtc driver.  On top of that,
> > it was all but impossible to support rtc chips such as tps6586x which
> > can only support wake alarms up to 16,383 seconds in the future.
> > 
> > The first patch of the series adds support for providing the maximum
> > supported time offset to the rtc core. The second patch uses that value
> > in the alarmtimer code to set the maximum wake-up time from system suspend.
> > Subsequent patches add support for reporting the maximum alarm timer offset
> > to a subset of affected drivers.
> > 
> > Previous discussion:
> >     https://lore.kernel.org/lkml/Y19AdIntJZGnBh%2Fy@google.com/T/#mc06d206d5bdb77c613712148818934b4f5640de5
> > 
> 
> I'm fine with the series, however, this doesn't solve the issue for RTCs
> that have an absolute limit on the alarm (as opposed to an offset to the
> current time/date).
> 

I thought that is checked by rtc_valid_range() in rtc_set_alarm().
Am I missing something ? Of course that assumes that the absolute
maximum alarm timeout matches range_max, but I didn't find any
drivers where that would not be the case.

Thanks,
Guenter

> 
> 
> > ----------------------------------------------------------------
> > Guenter Roeck (7):
> >       rtc: Add support for limited alarm timer offsets
> >       rtc: alarmtimer: Use maximum alarm time offset
> >       rtc: cros-ec: Detect and report supported alarm window size
> >       rtc: cmos: Report supported alarm limit to rtc infrastructure
> >       rtc: tps6586x: Report maximum alarm limit to rtc core
> >       rtc: ds1305: Report maximum alarm limit to rtc core
> >       rtc: rzn1: Report maximum alarm limit to rtc core
> > 
> >  drivers/rtc/rtc-cmos.c     | 11 +++++++++++
> >  drivers/rtc/rtc-cros-ec.c  | 38 +++++++++++++++++++++++---------------
> >  drivers/rtc/rtc-ds1305.c   |  3 ++-
> >  drivers/rtc/rtc-rzn1.c     |  1 +
> >  drivers/rtc/rtc-tps6586x.c |  1 +
> >  include/linux/rtc.h        |  1 +
> >  kernel/time/alarmtimer.c   | 13 +++++++++++++
> >  7 files changed, 52 insertions(+), 16 deletions(-)
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
