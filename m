Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BEA7FC229
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjK1QoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjK1QoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:44:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BC4D6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:44:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3042EC433C8;
        Tue, 28 Nov 2023 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701189862;
        bh=VXBxDQYXemPJD2OWSBAxs4OdN3/5YPb2d7fGJc3c0so=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=feZ0lBAvj+a8TYsX0HsEYspGxzNhQjd6bEAOt8m5Y2IcAG55AsIPeHaUle7U62GiO
         h6bD/CDMiYE5nH++594r6bvD4651o+5eOZUkkxaf1mTVfcOeMKagIeWuNp7ry4a+aP
         kR/BMdqQUQlxXYpbF+mYE3UxVeSFzdfYIHGkHvkxdFVc0iX1/uVM2HGWVJIZIBBcYF
         kVAk7n+2kd+6S+YoOSLe69xs2K092B6hR7i/LjHE+QbDWDt7mdsFuBIVtvb3hFUiDi
         Yhrmq6M3ibZqPQRlbZhnBqWyBSlxQOdD7uoDG63X+LMzX3gfrCNqCRvnIzwXgWlwdf
         ai8Pvb1JYmpDQ==
Date:   Tue, 28 Nov 2023 08:44:21 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Ahern <dsahern@kernel.org>,
        Saeed Mahameed <saeed@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231128084421.6321b9b2@kernel.org>
In-Reply-To: <20231128162413.GP436702@nvidia.com>
References: <20231121070619.9836-3-saeed@kernel.org>
        <2023112702-postal-rumbling-003f@gregkh>
        <20231127144017.GK436702@nvidia.com>
        <2023112752-pastel-unholy-c63d@gregkh>
        <20231127161732.GL436702@nvidia.com>
        <2023112707-feline-unselect-692f@gregkh>
        <ZWTtTjgBrNxpd9IO@x130>
        <20231127160719.4a8b2ad1@kernel.org>
        <20231128044628.GA8901@u2004-local>
        <20231128065321.53d4d5bb@kernel.org>
        <20231128162413.GP436702@nvidia.com>
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

On Tue, 28 Nov 2023 12:24:13 -0400 Jason Gunthorpe wrote:
> You said you already rejected it at the very start of this discussion
> and linked to the video recording of the rejection discussion:
> 
> https://lore.kernel.org/all/20231019165055.GT3952@nvidia.com/
> 
> This session was specifically on the 600 FW configuration parameters
> that mlx5 has. This is something that is done today on non-secure boot
> systems with direct PCI access on sysfs and would be absorbed into
> this driver on secure-boot systems. Ie nothing really changes from the
> broader ecosystem perspective.

The question at LPC was about making devlink params completely
transparent to the kernel. Basically added directly from FW.
That what I was not happy about.

You can add as many params at the driver level as you want.
In fact I asked Saeed repeatedly to start posting all those
params instead of complaining.

> I second Dave's question - if you do not like mlx5ctl, then what is
> your vision to solve all these user problems?

Let the users complain about the user problems. Also something
I repeatedly told Saeed. His response was something along the lines
of users are secret, they can't post on the list, blah, blah.

You know one user who is participating in this thread?
*ME*
While the lot of you work for vendors.
