Return-Path: <linux-kernel+bounces-83161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 339EF868FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579901C21BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E5813A87C;
	Tue, 27 Feb 2024 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GxtuEB2o"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D899813A274;
	Tue, 27 Feb 2024 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035586; cv=none; b=L+xWtN6kRvtP0YJONcjyMhwqlwvUMR+EGVwHbhQD4TGU6vt3CAY3jMRurxDRkFDmAzelTpNwCV372U3jeF2nwWVSjq8yhYengKXv6ubOkxiLoTNGU+qU87DRH2e8P+7VCzBGCBqKpVYSDn75U1mWgcDEJugWjyZlK99rAGUN9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035586; c=relaxed/simple;
	bh=WvJArsUTJXRJiZdUCPnafcBXTHqHKXd8uQhLhgKJhZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ln26wItKYUGOml/8MWkBT2SoQ3wlQj8hNKVWAhaLnwa5K9S0Ujso9SWOW0why8yAYWqn/eAgN1PdFwyyNvA8Zl/eeTmxvAjea2q9mOHqu4KpsGgOrj/D9WB2nq4kWkOdLfbE0TceYBpdtLjg3nyjCPVGQ9prCJW5AKq1Mg9oXOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GxtuEB2o; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 777041C0004;
	Tue, 27 Feb 2024 12:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709035581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIrYh61CXichMQDwM9T6CmacuZVLBIfhKTVUXwxZYBE=;
	b=GxtuEB2ovjmpeD6CflqWcUa6WGVUI2jNXi4BkBFeRvhBoV52Q91DF7Vx4d8ebxUKPU/oxO
	z9UKoSQFWPY4fCYkX3S0feEQFA14hZe8CQ830J8X8U/NW48Z7Mn8+njjk2ckQWyhIIXLyb
	Adcby25xzXXQHD0UFwysY2zvjuprwAte95k06679TJMAt1QfKflmwwGAm9bw2I2K3Ou38a
	WYKVjW8RQiQAHWX0/3kcRJbAAMGLm/BI10lHarq9TeLWBCi1GKxLbosbyh7iIIHtMPDGxS
	sugb7JzWflHYVJKYwvMOtI5HfbIzO9gXcb5dEApWhnxYOO0aavauleBks362eg==
Date: Tue, 27 Feb 2024 13:06:19 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij
 <linus.walleij@linaro.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones
 <lee@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Android Kernel Team
 <kernel-team@android.com>
Subject: Re: [PATCH RESEND 0/2] leds: gpio: Add devlink between the
 leds-gpio device and the gpio used.
Message-ID: <20240227130619.4b47d409@bootlin.com>
In-Reply-To: <CAGETcx_=g1dCH=YMUkc7VquUmLs=bNZMspUxH+V49uhcV0Bx2w@mail.gmail.com>
References: <20240220133950.138452-1-herve.codina@bootlin.com>
	<CAMRc=MfWPEOHeNvAwra-JxHZBFMrQbP+273zbFLDZfxi7fx8Yg@mail.gmail.com>
	<20240220155347.693e46e1@bootlin.com>
	<CAMRc=MeSgCOLZvFOXF4eQOp=bTz38K5Krzuy9r569-jnDx1zFA@mail.gmail.com>
	<20240220164730.03412479@bootlin.com>
	<CAGETcx_=g1dCH=YMUkc7VquUmLs=bNZMspUxH+V49uhcV0Bx2w@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Saravana,

On Tue, 20 Feb 2024 19:28:17 -0800
Saravana Kannan <saravanak@google.com> wrote:

> On Tue, Feb 20, 2024 at 7:47 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Hi Bartosz,
> >
> > On Tue, 20 Feb 2024 16:30:11 +0100
> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >  
> > > On Tue, Feb 20, 2024 at 3:53 PM Herve Codina <herve.codina@bootlin.com> wrote:  
> > > >
> > > > On Tue, 20 Feb 2024 15:19:57 +0100
> > > > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > >  
> > > > > On Tue, Feb 20, 2024 at 2:39 PM Herve Codina <herve.codina@bootlin.com> wrote:  
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Note: Resent this series with Saravana added in Cc.
> > > > > >
> > > > > > When a gpio used by the leds-gpio device is removed, the leds-gpio
> > > > > > device continues to use this gpio. Also, when the gpio is back, the
> > > > > > leds-gpio still uses the old removed gpio.
> > > > > >
> > > > > > A consumer/supplier relationship is missing between the leds-gpio device
> > > > > > (consumer) and the gpio used (supplier).
> > > > > >
> > > > > > This series adds an addionnal devlink between this two device.
> > > > > > With this link when the gpio is removed, the leds-gpio device is also
> > > > > > removed.
> > > > > >
> > > > > > Best regards,
> > > > > > Hervé Codina
> > > > > >
> > > > > > Herve Codina (2):
> > > > > >   gpiolib: Introduce gpiod_device_add_link()
> > > > > >   leds: gpio: Add devlinks between the gpio consumed and the gpio leds
> > > > > >     device
> > > > > >
> > > > > >  drivers/gpio/gpiolib.c        | 32 ++++++++++++++++++++++++++++++++
> > > > > >  drivers/leds/leds-gpio.c      | 15 +++++++++++++++
> > > > > >  include/linux/gpio/consumer.h |  5 +++++
> > > > > >  3 files changed, 52 insertions(+)
> > > > > >
> > > > > > --
> > > > > > 2.43.0
> > > > > >  
> > > > >
> > > > > Can you add some more context here in the form of DT snippets that
> > > > > lead to this being needed?  
> > > >
> > > > / {
> > > >         leds-dock {
> > > >                 compatible = "gpio-leds";
> > > >
> > > >                 led-5 {
> > > >                         label = "dock:alarm:red";
> > > >                         gpios = <&tca6424_dock_2 12 GPIO_ACTIVE_HIGH>;
> > > >                 };  
> > >
> > > Do I understand correctly that the devlink is created between "led-5"
> > > and "tca6424_dock_2" but actually should also be created between
> > > "leds-dock" and "tca6424_dock_2"?
> > >  
> >
> > Yes, that's my understanding too.  
> 
> I'm replying here instead of the RESEND because here's where the
> context and example are provided.
> 
> I quickly poked into the gpio-leds driver. Please correct me if I'm
> misunderstanding anything.
> 
> It looks like led-5 will be added as a class device. But the
> dev->fwnode is not set before it's added because it uses
> device_create_with_groups(). So, fw_devlink doesn't create a link
> between led-5 and tca6424_dock_2 unless tca6424_dock_2 is added after
> led-5. Which coincidentally seems to be the case here. Might want to
> explicitly create the device in gpio-leds driver.
> 
> The issue you are trying to fix is a generic issue that I'd like to
> fix in a generic fashion. It's one of my TODOs which I've mentioned
> before in conferences/emails to LKML: device links framework has a
> bunch of gaps when it comes to class devices. I've been thinking about
> it for a while, but it needs a lot more work and testing. I'll roll in
> this case when I deal with it in a generic fashion. But here's the
> general idea of things that need to be addressed:
> 
> 1. "Managed" device links allow having a class device as a supplier,
> but that'll mean the consumer will never probe.
> 2. What if a class device is a consumer and the supplier isn't ready.
> What does it mean for the class device to be added? Is it available
> for use? Probably not. Can we do something here that'll be useful for
> the class implementation?
> 3. What if the supplier and consumer are class devices, when does the
> consumer class device become "available" (do we check the suppliers of
> the supplier?)?
> 4. What happens if the supplier of a class device gets removed? Do we
> notify the class so it can do the right thing? Do we force unbind the
> first ancestor that's on a bus? (your case).
> 5. What if a supplier class device is removed, should we unbind the
> consumer (if it's a bus device)?
> 
> I'm currently working on a patch to break dependency cycles. Once
> that's in, the next TODO item I work on is going to be this or clock
> framework sync_state() support.
> 
> So, I'd recommend waiting this out if it's not urgent.
> 
> Heh, here's my commit on my local repo from a year ago when I touched
> on this and realised the scope of the work.
> 
> commit 7dcaad52e569209104408f3e472fde4ef8cd5585 (class-devlinks-v1)
> Author: Saravana Kannan <saravanak@google.com>
> Date:   Mon Feb 13 13:40:43 2023 -0800
> 
>     add class support to device links
> 

Well, on one side we have this current patch that fixes the current issue in
the gpio-led use case.

On the other side, I have a commit hash from your local repo which is one
year old and some more work is needed on it.

Maybe my patch is not fully correct but it fixes the issue.

Do you have any idea about when your work on that topic will be available?

Best regards,
Hervé

