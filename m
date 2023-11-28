Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE827FC4F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344921AbjK1UJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjK1UJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:09:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3A383
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:10:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5D6C433C7;
        Tue, 28 Nov 2023 20:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701202202;
        bh=K6Xt5r/KWRZDak2N2GxiFYTdyVHnUjvbJFtqF4jWPwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P98rUFF1CB6n+nrnecTOo8tJ13l1VIojfi4kCFPpiNzHrODvLKgPXwP5CRRUTgnYr
         LW3kkjgcS7/NI1AGsf7+8eIWHs7B92BkhQcIv48QvsZcS4K84cqvq23A4iYqQQ1q9Y
         9x3AwvNpJCUQLQi3lxC9Ps3k+MzGNlCExkUuxwpo82A26bVPgZ/Mwq/4tAlS0kLxEq
         XVmrf6/VjtGVTQ5G4LamVdT/q5lZmHRelCqvwnzVj+hDywgTxXhwnSQYfXNX0ymYyG
         bLp6Jsiwo7ufstQ2fko0/+owq+mheZ/rqAA2AZuFCPT6ACcp33SmrVvl1NZGR6G1tW
         5P5P3SRNqOZZA==
Date:   Tue, 28 Nov 2023 12:10:00 -0800
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
Message-ID: <ZWZJGF7moDM_k6TU@x130>
References: <20231127161732.GL436702@nvidia.com>
 <2023112707-feline-unselect-692f@gregkh>
 <ZWTtTjgBrNxpd9IO@x130>
 <20231127160719.4a8b2ad1@kernel.org>
 <20231128044628.GA8901@u2004-local>
 <20231128065321.53d4d5bb@kernel.org>
 <20231128162413.GP436702@nvidia.com>
 <20231128084421.6321b9b2@kernel.org>
 <20231128175224.GR436702@nvidia.com>
 <20231128103304.25c2c642@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231128103304.25c2c642@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Nov 10:33, Jakub Kicinski wrote:
>On Tue, 28 Nov 2023 13:52:24 -0400 Jason Gunthorpe wrote:
>> > The question at LPC was about making devlink params completely
>> > transparent to the kernel. Basically added directly from FW.
>> > That what I was not happy about.
>>
>> It is creating a back-porting nightmare for all the enterprise
>> distributions.
>
>We don't care about enterprise distros, Jason, or stable kernel APIs.
>

Oh, I missed this one, so you don't care about users? 

Users often pay to distros for support, and distros always turn to vendors
for debug situations, in fact one of the high stakeholders for this is an
enterprise distro..

Also Jason and I are users, and more than 300 engineers at nvidia
and dozens of customers are users, deploying 100s of thousands of ConnectX
chips in their fleets.

if it weren't important for us and our users, I wouldn't even fight this
hard.. but it is important, and very useful, I can't express that hard
enough.

So you don't care ? Then don't ask about who the users are, in the other
email, apparently it's all about your personal opinion and views about
vendors what drives your responses. So it is really hard to debate with
you..
