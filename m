Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9048977E518
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344130AbjHPPZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344197AbjHPPZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:25:08 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D8A2736;
        Wed, 16 Aug 2023 08:24:42 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bc5acc627dso45048065ad.1;
        Wed, 16 Aug 2023 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692199481; x=1692804281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngO87r6M9TGEA2djCG1Or5SZ7WxlLI8g56zO4Oh4E4M=;
        b=m16fvJRMH6ofGj279cBUFDGCRwhFz0ufsSySwh5Fk6e6CtdG8foMnTzmzRy1bPQEy7
         DAweLQMdMWQhVbe5HDJBbof9+Ko2ZtEsXhVVnAshn+4aIGDM7Qmvo7lKBik96WafhDEg
         PjQ7BasJJCHX7tPOYYq3QYFpntpOvOmnA9wI2byVh21raLgIXK6vCD8kWVbkFMX39QrD
         d1+6v5mJNWK5CzFQboPyBLs/TJlGJvRF3ZqsU1OrPWHhnn6AdGvcFA6P0csn7O1bCKIg
         da6DAZAkuhO8E+DLQC8I2DUDxGGwQCTk9g2ptcCOOHuf3u6HSVV/Fj78j4mQvKhqaVul
         2aEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692199481; x=1692804281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngO87r6M9TGEA2djCG1Or5SZ7WxlLI8g56zO4Oh4E4M=;
        b=iwKeDLIuDRMQvDaOdXGNt16CGg2VfvbcIZClXmX2URC86mSL1eBCtoEq6BxiLAUiln
         ABlNxw0RFKOhPW7KaJFtsFpLqhHaxaKjnzXaVWwNYiaTLldXaCfyGGAbYY8u6SHsv/lf
         NLUU+OQFGVA8MBragGKku2MZIi834JU4HYDyyxQtgAqxkz47nMTfki0MXPcoRsXcwgB5
         i/n+UfSEs99jKrAfjLdgIEBMnVFdNutpxg2fHUnLNw6oUAS/hm4vVJTx1TJ8zRlQ0Kz1
         vsv2Zla4gITm6NVQLvZ/J2ygXUx91lnHaId5QMZZj7ERaakPokzAAeh5dlnpS0rGgytJ
         gsnQ==
X-Gm-Message-State: AOJu0YxihipAGmLMKJuEu2OB5Vd6oJGK36rFQQdNa4U0H6VkpqVukxGh
        6nnodgh/iW0U5Du11dwZ1RY=
X-Google-Smtp-Source: AGHT+IGyFr1Z9TkUuBFAf+4YTv6BG/g0FoU9eunu326AygnZgQvF1QfGHHPKZTnphOu7ioyGkrlK3w==
X-Received: by 2002:a17:903:41d0:b0:1bb:994c:bc43 with SMTP id u16-20020a17090341d000b001bb994cbc43mr2369018ple.18.1692199481272;
        Wed, 16 Aug 2023 08:24:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x18-20020a1709027c1200b001b9ff5aa2e7sm13264063pll.239.2023.08.16.08.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:24:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 16 Aug 2023 08:24:39 -0700
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
Subject: Re: [PATCH 1/7] rtc: Add support for limited alarm timer offsets
Message-ID: <9b6c7803-f258-472d-9983-530e42e80816@roeck-us.net>
References: <20230816133936.2150294-1-linux@roeck-us.net>
 <20230816133936.2150294-2-linux@roeck-us.net>
 <202308161457306eecdefb@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308161457306eecdefb@mail.local>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 04:57:30PM +0200, Alexandre Belloni wrote:
> On 16/08/2023 06:39:30-0700, Guenter Roeck wrote:
> > Some alarm timers are based on time offsets, not on absolute times.
> > In some situations, the amount of time that can be scheduled in the
> > future is limited. This may result in a refusal to suspend the system,
> > causing substantial battery drain.
> > 
> > Some RTC alarm drivers remedy the situation by setting the alarm time
> > to the maximum supported time if a request for an out-of-range timeout
> > is made. This is not really desirable since it may result in unexpected
> > early wakeups.
> > 
> > To reduce the impact of this problem, let RTC drivers report the maximum
> > supported alarm timer offset. The code setting alarm timers can then
> > decide if it wants to reject setting alarm timers to a larger value, if it
> > wants to implement recurring alarms until the actually requested alarm
> > time is met, or if it wants to accept the limited alarm time.
> > 
> > Only introduce the necessary variable into struct rtc_device.
> > Code to set and use the variable will follow with subsequent patches.
> > 
> > Cc: Brian Norris <briannorris@chromium.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  include/linux/rtc.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> > index 1fd9c6a21ebe..b6d000ab1e5e 100644
> > --- a/include/linux/rtc.h
> > +++ b/include/linux/rtc.h
> > @@ -146,6 +146,7 @@ struct rtc_device {
> >  
> >  	time64_t range_min;
> >  	timeu64_t range_max;
> > +	timeu64_t range_max_offset;
> 
> While range_min and range_max are for the wall clock time, I would
> prefer using a name that would clearly mark this as an alarm related
> variable.

Sure, no problem. Do you have a suggestion ? alarm_range_max or
alarm_range_max_offset, maybe ? I'd also be happy to use some other
term for 'offset' if you have a suggestion.

Thanks,
Guenter
