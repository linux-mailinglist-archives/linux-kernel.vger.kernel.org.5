Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D5B7FC448
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbjK1Tbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjK1Tbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:31:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DCD1988
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:31:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F498C433C8;
        Tue, 28 Nov 2023 19:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701199911;
        bh=zCDwbROaUVxfVcFqjwU03nDOAOmZ9prweH8i9xKxAMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HJXfN25Ahmu/3BcSrAj1tMC4nv613mpyfegOsfbV1J3RRSuIuT2Qu8zlKSK6ZSCAZ
         dbD6asZm5S978AOcYRhBxlGBnjJv6GxjVhlLoy2P6+XotXCgTYHqY07K6J8NtnTkR8
         t4KTt6wZhesr7FIczoyJhqV6IIg8mQSKpA/UXRX49+5ct6W6xkFW1fbjHC6vYCGpp6
         pDYCeA7ijdbgTrTJwWfEnIz0T+pcXuuwtj98Dt1OdmiLjXoZgZdtRwt5z5SuZjCNpR
         VeFMWESfLP7QWXvI/JDdNggCOxx1Sq7txEpywc5ZmijAmNEFpLzFb8UtGv4NJ+1rqv
         ttqnU4SWXV+hQ==
Date:   Tue, 28 Nov 2023 11:31:49 -0800
From:   Saeed Mahameed <saeed@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, David Ahern <dsahern@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <ZWZAJSXrWBQO-9qQ@x130>
References: <20231127144017.GK436702@nvidia.com>
 <2023112752-pastel-unholy-c63d@gregkh>
 <20231127161732.GL436702@nvidia.com>
 <2023112707-feline-unselect-692f@gregkh>
 <ZWTtTjgBrNxpd9IO@x130>
 <20231127160719.4a8b2ad1@kernel.org>
 <20231128044628.GA8901@u2004-local>
 <20231128065321.53d4d5bb@kernel.org>
 <20231128162413.GP436702@nvidia.com>
 <20231128084421.6321b9b2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231128084421.6321b9b2@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Nov 08:44, Jakub Kicinski wrote:
>On Tue, 28 Nov 2023 12:24:13 -0400 Jason Gunthorpe wrote:
>> You said you already rejected it at the very start of this discussion
>> and linked to the video recording of the rejection discussion:
>>
>> https://lore.kernel.org/all/20231019165055.GT3952@nvidia.com/
>>
>> This session was specifically on the 600 FW configuration parameters
>> that mlx5 has. This is something that is done today on non-secure boot
>> systems with direct PCI access on sysfs and would be absorbed into
>> this driver on secure-boot systems. Ie nothing really changes from the
>> broader ecosystem perspective.
>
>The question at LPC was about making devlink params completely
>transparent to the kernel. Basically added directly from FW.
>That what I was not happy about.
>
>You can add as many params at the driver level as you want.
>In fact I asked Saeed repeatedly to start posting all those
>params instead of complaining.
>

We posted many params over the years the you shot down on the spot,
do you really expect me to implement 600 of those knowing that you will
nack 80% of them asking to have common knobs for all vendors, and you know
that is impossible.
you nack patches then ask for a porpossal, we came up with many proposal
and discussed them face to face on multiple occasions, LPC/netconf etc,
then you ask for patches, then you nack again, we are just going in circles
here..

>> I second Dave's question - if you do not like mlx5ctl, then what is
>> your vision to solve all these user problems?
>
>Let the users complain about the user problems. Also something
>I repeatedly told Saeed. His response was something along the lines
>of users are secret, they can't post on the list, blah, blah.
>

I never said it is a secret, but I can't publicly reveal who my customers
are and what they want, you know very well who asked for the high
frequency counter sampling.. So we came up with a very clear solution,
that has nothing to do with netdev, since for that particular use-case it
is not netdev specific, and netdev stack isn't even present.

>You know one user who is participating in this thread?
>*ME*
>While the lot of you work for vendors.

And how *YOU* expect the vendors to debug *YOUR* issues, if you don't
allow them to access their HW? 

Asking all vendors to use *YOUR* "devlink generic_dev generic_knob" is an
insult to all vendors, how about you provide the ASIC design and RTLs
to all vendors and we just manufacture it for you.. 

