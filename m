Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B5B7DB1C2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 02:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjJ3BAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 21:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjJ3BAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 21:00:49 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ED9BD;
        Sun, 29 Oct 2023 18:00:45 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CEBC71BF203;
        Mon, 30 Oct 2023 01:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698627644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CM76VELg8yRF9N2N/Qz4+zJQH0u4ctzk5oy/OV0miPA=;
        b=eD0BWt7fD4oaM1J7IRlRwqIh7vBROnZOd8XG/HrlKie5sJZUTOz3rb/4zCVBMTHMxocQ6q
        THiIlTQS3CKMbO+xDHCYg3mhMB+ge27DkoTS2boc23zg41PG8D75yOGq/4IdS3FGFcHOqJ
        Nlojdl2be0WQL8BVZhMckd68udRh/kIezcSui8ULTLf62iVBFDGS35wtShrczWbLBuKt1c
        bs+7YFOnUL+mOhihjpKzI1NuFcaIIbOQWNAqQ7eXy7woZskg3cnyP7z31wk4AO44lep8M6
        JjbLGVIvE9JNR+cRzou8Khm/b7Kw3gV8h3PxgjwzRyG0ooZR1mpsbC1M+PQECA==
Date:   Mon, 30 Oct 2023 02:00:43 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     John Stultz <jstultz@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 0/2] rtc: alarmtimer: Use maximum alarm time offset
Message-ID: <202310300100434b7ed65b@mail.local>
References: <20230915152238.1144706-1-linux@roeck-us.net>
 <169862665994.296255.17369001298571068518.b4-ty@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169862665994.296255.17369001298571068518.b4-ty@bootlin.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2023 01:44:55+0100, Alexandre Belloni wrote:
> 
> On Fri, 15 Sep 2023 08:22:36 -0700, Guenter Roeck wrote:
> > Some userspace applications use timerfd_create() to request wakeups after
> > a long period of time. For example, a backup application may request a
> > wakeup once per week. This is perfectly fine as long as the system does
> > not try to suspend. However, if the system tries to suspend and the
> > system's RTC does not support the required alarm timeout, the suspend
> > operation will fail with an error such as
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/2] rtc: Add API function to return alarm time bound by rtc limit
>       commit: b0790dc7419f334574fc5416690913ab4c9e9ba5
> [2/2] rtc: alarmtimer: Use maximum alarm time offset
>       commit: f628128dfe77f6e475507798b0f7ed25831ae893
> 

Actually, this is already in tip but I didn't get the notification.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
