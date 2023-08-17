Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB37C77FEB9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354768AbjHQTve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354798AbjHQTvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:51:23 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F390EE;
        Thu, 17 Aug 2023 12:51:20 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7994040002;
        Thu, 17 Aug 2023 19:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692301879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wHKQb0SmxhWjxqmZQ9159wjV4k0plINo8JRIiEa3nHs=;
        b=JFPt83KuEKi5EXmtWYJ2Sj7oMl1X5lfc9+Ygp6fKL3/vVgjC5kdazP6TM8ysUERLH4ekbF
        0Q266DWhwlmpstyDcBN9FE+sDXwSSps0+iEOHwdjyHbZsxd3h1G0yrzRml1UewEvK9SKPn
        iaHl8D1N9pS6SSIrqQGA8hqKQChHemJhNb6MtD+8ZGq6J52dy0BgIyQIphHMqidrp6rT7L
        +Gb/q9828ysKQfq8Q5ab/sJIZ+xWd4lU7VGI46BDWL0TBGsUJeOXKb+FfPIYBYBEpB2aCc
        W3XyWrNnHl0p7CavaGgILZIoN7SgI+neNSLmzXVRs9/1Zyb5fE3QUVP4vmlFnw==
Date:   Thu, 17 Aug 2023 21:51:17 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 0/7] rtc: Add support for limited alarm timer offsets
Message-ID: <202308171951177626a54c@mail.local>
References: <20230816133936.2150294-1-linux@roeck-us.net>
 <20230816150353137debc5@mail.local>
 <8079bdf4-f790-451b-a2c2-be4e23c0c3a1@roeck-us.net>
 <20230816161435bd2bbd4a@mail.local>
 <6ffc915e-ca91-4b64-b7a5-f13f60df8b1d@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ffc915e-ca91-4b64-b7a5-f13f60df8b1d@roeck-us.net>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 12:12:14-0700, Guenter Roeck wrote:
> On Wed, Aug 16, 2023 at 06:14:35PM +0200, Alexandre Belloni wrote:
> > On 16/08/2023 08:50:12-0700, Guenter Roeck wrote:
> > > > I'm fine with the series, however, this doesn't solve the issue for RTCs
> > > > that have an absolute limit on the alarm (as opposed to an offset to the
> > > > current time/date).
> > > > 
> > > 
> > > I thought that is checked by rtc_valid_range() in rtc_set_alarm().
> > > Am I missing something ? Of course that assumes that the absolute
> > > maximum alarm timeout matches range_max, but I didn't find any
> > > drivers where that would not be the case.
> > > 
> > 
> > There are RTCs where this is not the case. When this is far away in the
> > future enough, the usual solution is to clip range_max which works but
> > is not really great intellectually.
> > 
> Do you have an example, by any chance ?
> 

I'm sorry, I've been looking and I couldn't find it anymore. Don't
bother with this for now.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
