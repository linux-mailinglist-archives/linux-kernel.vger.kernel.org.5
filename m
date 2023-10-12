Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919667C6734
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347073AbjJLHyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjJLHyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:54:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99054B7;
        Thu, 12 Oct 2023 00:54:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD161C433C7;
        Thu, 12 Oct 2023 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697097257;
        bh=p2v0qVTwQ8zFtxDaAzDhCwQKGwVkcbZvyeApiQQ8j/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ouBLpUMketvQ6mCLH7X09kSCmOomHs0DOSCilC36YVntLPf5w9krayQFWbPXi9Cg4
         ipBtNLnFUYoqwz+14rkFcqz9E/4Ho2rhQsGFqclgH7IuYqtCeArTZEVEizJSshwoa0
         CyFK1aecdN7YKe34LYpTI1x7dJ/cnhMM55Cb7T4Ublq8iOJ/LAyhj7wUQt1/xgfA9b
         wyKBna83KbcAYtLyuMlrgCyE2lJLG9Grvxn2yU8Uzxv6o+OXgizFJP2iIEJI+5n2VC
         LYhuQSAfwsLJ9JAa7cmz3855ThYGftRJrHeN/qlUFUxV7exNppjYnnYkDBp7D0vAuM
         xpEyDIGQiKidA==
Date:   Thu, 12 Oct 2023 08:54:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Subject: Re: [PATCH 2/2] iio: light: Add support for APDS9306 Light Sensor
Message-ID: <20231012085427.5f0fa4a3@jic23-huawei>
In-Reply-To: <07761a6c-85a8-c7bd-a0af-28d0f29b3e5d@tweaklogic.com>
References: <20231008154857.24162-1-subhajit.ghosh@tweaklogic.com>
        <20231008154857.24162-3-subhajit.ghosh@tweaklogic.com>
        <20231010153807.6335a043@jic23-huawei>
        <07761a6c-85a8-c7bd-a0af-28d0f29b3e5d@tweaklogic.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 01:07:10 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> On 11/10/23 01:08, Jonathan Cameron wrote:
> > 
> > No need to wrap the patch description quite so short. Aim
> > for up to 75 char for a commit message (and 80 for the code)
> > Here you are under 60.
> >   
> Thank you for taking time to point out these small issues.
> 
> >>
> >> Datasheet at https://docs.broadcom.com/doc/AV02-4755EN
> >>  
> > There is a tag for datasheets in the format tags block so
> > Datasheet: https://docs.broadcom.com/doc/AV02-4755EN  
> >> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>  
> > 
> > I took a quick look at the most similar part number adps9300 and
> > this does look substantially different but could you confirm you've
> > taken a look at the plausible drivers to which support for this part
> > could be added and perhaps mention why that doesn't make sense
> > I think it will be mainly feature set being different here, but also
> > it seems they have completely different register maps despite similar
> > part numbers!  
> I have taken a look at quiet a few light sensor drivers including
> apds9960 and apds9300, as you said that they are different. There are
> another two drivers apds990x and apds9802als in drivers/misc which are
> also very different but I can't say that I have been through all the
> driver files.
> 

Great.  Then as expected this separate driver make sense even if the
DT bindings can be combined.  Would be nice if they standardised
the interface, but some companies seem to feel the need to start from
scratch for each device they produce :(


> 
> > The interrupt controller for starters takes to no locks and can run concurrently
> > with other accesses from other CPUs.  That seems unwise.
> >  
> Well, regarding device access, interrupt handler just reads the status registers
> thereby clearing the interrupt status flag and releasing the physical interrupt line.
> What can be the issue if I don't use a lock?
Gah. I was far too sleepy that day.  Glad you interpreted my comment as intended :)

Hmm. You will be relying on the internal implementation of the regmap bus interface
resulting in locks being taken in the i2c controller.  That may be fine, but
it makes me a little nervous that it's relying on a particular implementation.

My normal assumption is that any driver that turns off locking in regmap is doing
so because it has various complex read modify write cycles so needs to have it's
own locks - but that it also applies those locks everywhere regmap would have
done (so for duration of every regmap call).

You may be fine, but you aren't meeting the requirements documented.
The flag to disable locking in regmap states:

 * @disable_locking: This regmap is either protected by external means or
 *                   is guaranteed not to be accessed from multiple threads.
 *                   Don't use any locking mechanisms.

It doesn't say you are fine for simple accesses and there are multiple threads
accessing 'the regmap'.

Unless you really care about it, I'd just leave regmap locking enabled.
The likely performance hit on a device on a slow bus is low and it avoids
us having to think too hard about this.


> >> +	ret = devm_add_action_or_reset(dev, apds9306_powerdown, data);  
> > 
> > Why at this point? I'd have thought it wasn't powered up until init_device()
> > which follows?  So I'd expect to see this call after that, not before.
> >   
> Right. I will do a bit more reading on this before using this. I assumed this
> functions registers the callback which gets called at driver release by the
> subsystem similar to release().

That's true, but with the addition that it is called in the reverse order of
being add to the devm managed release list.  So ordering matters.


> 
> Thank you Jonathan for the review. I'll get the changes done in the next version.
> 
No problem.   As a side note, feel free to just crop out any responses where
you agree with a review.  Default assumption is that if you don't comment that
is the case and it cuts down on scrolling when reviewer next looks.
They are also much more likely to take a look at a short reply than a long one!

Jonathan

> Regards,
> Subhajit Ghosh
> 
> 
> 
> 

