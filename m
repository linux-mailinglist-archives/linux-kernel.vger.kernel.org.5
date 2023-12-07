Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A599808D04
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjLGQUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjLGQUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:20:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042E411B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:20:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01601C433CA;
        Thu,  7 Dec 2023 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701966044;
        bh=w7Xd+/OSbJk+99OQ/CNyt9RR9EvA1R1smLyRfv0wPeE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nfSVX9gxMKlehSViXQ3Klw264+i4ncJhVTZy87Mh4ZIbSNzXPeL0KoMtmdkWwbzdB
         waxbbpkx0NWueh/RiOuR9A9mF2arnZO5XrFIAWQkQUVsIwuvTJjlDtT/0z6WpBQrkS
         9Jql4vR9VfjRK4ARm5uqMq5ljy4gz8Ma/j9kWobmEF0q8ofJEnX4hqgDeeLKoOXMY5
         jnstQlGdVAO1WbJLP/mL+xEsmbONzyqsKZ89ym8emLxnPokoE0GoAwXqditx9lBEB1
         9gNeIT0DOBbli1/KWaRazG9m9NmaN/pcc6a2WzS2/TESeFMtyMCnAMqr9pv2Gw210O
         JuufPwAB2toow==
Date:   Thu, 7 Dec 2023 08:20:42 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Ahern <dsahern@kernel.org>
Cc:     Aron Silverton <aron.silverton@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saeed Mahameed <saeed@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231207082042.6229868e@kernel.org>
In-Reply-To: <2bbc4c40-ff8b-4243-9987-dc7d5502a37c@kernel.org>
References: <20231128044628.GA8901@u2004-local>
        <20231128065321.53d4d5bb@kernel.org>
        <20231128162413.GP436702@nvidia.com>
        <20231128084421.6321b9b2@kernel.org>
        <20231128175224.GR436702@nvidia.com>
        <20231128103304.25c2c642@kernel.org>
        <ZWZJGF7moDM_k6TU@x130>
        <2023112922-lyricist-unclip-8e78@gregkh>
        <oxtcvxwbj2hzv4lxnxubo3hoxn7diyzhm2oj3tsw2toxbc3og4@ddglhm6r3oa5>
        <20231204185210.030a72ca@kernel.org>
        <fgalnohzpiox7rvsf3wsurkf2x3rdtyhwqq5tk43gesvjlw6yl@i7colkh2sx5h>
        <20231205204855.52fa5cc1@kernel.org>
        <2bbc4c40-ff8b-4243-9987-dc7d5502a37c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David, I agree with your points. I think you're misreading
what I said.

On Thu, 7 Dec 2023 08:54:51 -0700 David Ahern wrote:
> You rail against out of tree drivers and vendor proprietary tools, and
> now you argue for just that.

I don't rail against out of tree drivers, very much the opposite.
Linux supports out of tree modules, and I agree that's 100% the
correct thing to do. I'd encourage more people to take advantage of
that. The problem is quite the opposite, all the "security hardening"
is making it almost impossible for users to take advantage of OOT
modules.

> There is no reason debugging capabilities
> can not be built into the OS and used when needed. That means anything
> needed - from kernel modules to userspace tools.
> 
> The Meta data point is not representative of the world at large -
> different scale, different needs, different expertise on staff (OS and
> H/W). Getting S/W installed (especially anything requiring a compiler)
> in a production server (and VMs) is not an easy request and in many
> cases not even possible.

I did not say it's easy.

> When a customer hits problem, the standard steps are to run a script,
> generate a tar file and ship it to the OS vendor. Engineers at the OS
> vendor go through it and may need other data - like getting detailed
> dumps from individual pieces of H/W.

You say that like this is not _exactly_ what I just said!?

> Every time those requests require
> going to a vendor web site to pull down vendor tools, get permission to
> install them, schedule the run of said tool ... it only serves to drag
> out the debugging process. ie., this open-ended stance only serves to
> hurt Linux users.

Right, exactly. What are you arguing with then? As I said - we have a
very open / accommodating policy for extracting all sort of debug and
state dumps. You can put whatever read only stuff you want in debugfs**
Read-write interfaces must be constrained to a clear set of commands /
settings but also very much allowed. As you said users need to be able
to extract debug info to share with the vendors, no tools necessary.

** (this will surprise you but you can also put stats there, if they 
    are custom, I don't care if they go into ethtool -S or debugfs)
