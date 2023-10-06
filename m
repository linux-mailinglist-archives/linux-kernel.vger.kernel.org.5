Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57007BB4D4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjJFKIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjJFKIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:08:42 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4453FC;
        Fri,  6 Oct 2023 03:08:38 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-503f39d3236so2408284e87.0;
        Fri, 06 Oct 2023 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696586917; x=1697191717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=osJYzTdN8E4ajBT02BHqBdC7TAGRf8KWAino8TfH2Do=;
        b=cghMRjk7/T9KUEEN1nWJdAdXuwzOm8D7RS2XTv06BdXdO9M0c6vDALkhcFA9Xl53qO
         3jXs7XdEgqoHkqoPY1nIAbRcYWf+K7g2CkpG6Pbnt3K+46fpo+E8QjrLSposdTyLCy20
         XZC0pl5VgzeYcOahU4v+rBe7nug5zdhJMVaq8jVjcwLQZMpXVt1M2LNMWbsWJfKzrS73
         abSFtiAzVxKWqfde5ap9CbdFmXmMDMrnwXRoQoQO/wAZ8pw1NsqBvBDsZE+NThYjirJa
         R0xfKqQNnMFOAljhGNckdug9GYMXddduIhXSxkLayP9aVS7KlBWiQoWQPt7bDbzJ8W94
         9b7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696586917; x=1697191717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osJYzTdN8E4ajBT02BHqBdC7TAGRf8KWAino8TfH2Do=;
        b=UCMX9yagNpLDo1M4ty8lVJgGEaAhQbNBd+r4Au6dYL9YZHJ9gptptzeAPmGNfGsLWg
         JRmw+s/xocG9+4gz6cRzXGLO9MZpV0m086XnCKXkrI/Fpz8iuH6/5TCYOIpdZLhjeECj
         Sug04s7bVmed8oh+OSm0jvv84P8RRfvQMx/ZungOMwi2757t+x0zJT+IXIgqw6XJJmsH
         QEiWk2P3I/+8hKBXzJYARXsGtTn0j8nzESCbO8cnyJE5yTFgKjfr91lqBQhJi09UF7VY
         ejbXASxCFSd8s6NjM7zYoUEj9eBsvTi4OWg//zEh4gMRDW51LuqtTB6pFzSWk0B63M0k
         dBbw==
X-Gm-Message-State: AOJu0YzOrpL52zFoRT0lpaOmV7eavMz3U7OmExiL8rrmUIlGW1egYL6d
        NvV8H3dkca1iZh42AV7PZcM=
X-Google-Smtp-Source: AGHT+IED9GQikXczfKT0cS5GMmyEBz/AdHxccg6OjFgXOMmxPrn1cm+Z3Q6ubL10fyYOPOdv4cLdvQ==
X-Received: by 2002:ac2:5b83:0:b0:503:3787:f75a with SMTP id o3-20020ac25b83000000b005033787f75amr6234875lfn.62.1696586916355;
        Fri, 06 Oct 2023 03:08:36 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id u7-20020a056512040700b00501ce0cacb6sm243567lfk.188.2023.10.06.03.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:08:35 -0700 (PDT)
Date:   Fri, 6 Oct 2023 13:08:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rohan G Thomas <rohan.g.thomas@intel.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     alexandre.torgue@foss.st.com, andriy.shevchenko@linux.intel.com,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, joabreu@synopsys.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        pabeni@redhat.com
Subject: Re: [PATCH net-next 1/1] net: stmmac: xgmac: EST interrupts handling
Message-ID: <cjgx6e3agc6gpvs75nhkf6wlztk73epmct6tcuooyqvk2nx2o2@vr5buyk637t3>
References: <20231005070538.0826bf9d@kernel.org>
 <20231006072319.22441-1-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006072319.22441-1-rohan.g.thomas@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rohan, Jakub

On Fri, Oct 06, 2023 at 03:23:19PM +0800, Rohan G Thomas wrote:
> On Thu, 5 Oct 2023 07:05:38 -0700 Jakub Kicinski wrote:
> > On Thu, 5 Oct 2023 20:14:41 +0800 Rohan G Thomas wrote:
> > > > So the question now is whether we want Rohan to do this conversion
> > > > _first_, in DW QoS 5, and then add xgmac part. Or the patch should
> > > > go in as is and you'll follow up with the conversion?

Jakub, this was my intention if Rohan wouldn't have agreed to perform
the cleanup. Though I couldn't promise to do that in an instant.
I would have needed a month or two to find a free time-spot for that.

> > >
> > > If agreed, this commit can go in. I can submit another patch with the
> > > refactoring suggested by Serge.
> > 
> > Did you miss the emphasis I put on the word "first" in my reply?
> > Cleanup first, nobody will be keeping track whether your fulfilled your
> > promises or not :|
> 
> Hi Jakub,
> 
> Agreed. I'll do the cleanup first.

Rohan, thanks in advance. Although I don't see why it's required to be
done in the prescribed order only as long as the update comes in a
_single_ patchset. Adding EST IRS-status support to XGMAC core module
first, then factoring out both XGMAC and QoS (note both 4.x and 5.x
seems to support that) EST code would be also acceptable. Seeing you
have already done the first part, it would have taken less work in
general.

Jakub, what do you say if Rohan will just re-submit v2 with the
addition cleanup patch and let him to decided whether the cleanup
should be done first or after his XGMAC-EST IRQ update?

> > > Again, thanks Serge for the prompt response. Regarding the below point in your
> > > earlier response,

> > > > > 2. PTP time offset setup performed by means of the
> > > > > MTL_EST_CONTROL.PTOV field. DW QoS Eth v5.x HW manual claims it's "The
> > > > > value of PTP Clock period multiplied by 6 in nanoseconds." So either Jose got
> > > > > mistaken by using _9_ for DW XGMAC v3.x or the DW XGMAC indeed is
> > > > > different in that aspect.
> > > 
> > > This is a little confusing...
> > > I referred databooks for DW QoS Eth v5.30a and DW XGMAC v3.10a. In both this is
> > > mentioned as "The value of PTP Clock period multiplied by 9 in nanoseconds".

Interesting thing. My DW QoS Eth _v5.10a_ HW manual explicitly states
that it's multiplied by _6_ in nanoseconds (just rechecked). So either
there is a difference between the minor DW QoS Eth IP-core releases or
the older HW-manuals have had a typo in the MTL_EST_CONTROL.PTOV field
description. Synopsys normally describes such changes (whether it was
a mistake or a functional change) in the IP-core release notes. The
release notes document is supplied as a separate pdf file. Alas I
don't have one.( Even if I had it it would have been useless since the
change was introduced in the newer QoS IP-cores. Rohan, do you happen
to have the release notes for DW QoS Eth IP-core v5.30 at hands?
Something like DWC_ether_qos_rc_relnotes.pdf?

Also please double check that your DW QoS Eth v5.30a for sure states
that MTL_EST_CONTROL.PTOV contains value multiplied by _6_. So we
wouldn't be wasting time trying to workaround a more complex problem
than we already have.

-Serge(y)

> 
> Best Regards,
> Rohan
