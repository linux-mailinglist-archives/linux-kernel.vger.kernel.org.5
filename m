Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A5E7DB1BD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 01:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjJ3ApC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 20:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjJ3ApB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 20:45:01 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFC7BA;
        Sun, 29 Oct 2023 17:44:57 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5210C60002;
        Mon, 30 Oct 2023 00:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698626695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kd9sLOcMMocLV175wLPiLGXs3b5Bj/22gAGv9j68f7E=;
        b=eMfQmjI/ZhpQPs9jjJINnL3RQL0QKRhiLBClr7b/1igTAsLyPXeph4B7Tlda7uv8Eumdh1
        aPoUv56g2e2w6H/h9pVZJXTZwQyvrQsCkp0KzYHHu78GV5PYEtzYaFh2CXAZca1+fndhak
        9YfS2obxbhzJ7BCC7VOfgIouKULquXFEhBy/pL3ZwFqSLfqWbQGUOtEjl2fyJE1zSeZ7QC
        RNbDfL5XcmQHPCUf/pRR1IxKcpm0tuRj+tQYpG6yC31ZVl2DX7ORJ2QZh+IoLXyBpchNiI
        AE2xk3aS8n2w+tUZHt9qU2bmjemvwMCCxkWXi//9mx38s6aKUxpWD1bsl8UB7w==
Date:   Mon, 30 Oct 2023 01:44:55 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     John Stultz <jstultz@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 0/2] rtc: alarmtimer: Use maximum alarm time offset
Message-ID: <169862665994.296255.17369001298571068518.b4-ty@bootlin.com>
References: <20230915152238.1144706-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915152238.1144706-1-linux@roeck-us.net>
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


On Fri, 15 Sep 2023 08:22:36 -0700, Guenter Roeck wrote:
> Some userspace applications use timerfd_create() to request wakeups after
> a long period of time. For example, a backup application may request a
> wakeup once per week. This is perfectly fine as long as the system does
> not try to suspend. However, if the system tries to suspend and the
> system's RTC does not support the required alarm timeout, the suspend
> operation will fail with an error such as
> 
> [...]

Applied, thanks!

[1/2] rtc: Add API function to return alarm time bound by rtc limit
      commit: b0790dc7419f334574fc5416690913ab4c9e9ba5
[2/2] rtc: alarmtimer: Use maximum alarm time offset
      commit: f628128dfe77f6e475507798b0f7ed25831ae893

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
