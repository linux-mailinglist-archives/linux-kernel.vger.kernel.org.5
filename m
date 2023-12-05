Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA2E80455A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376444AbjLECwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344119AbjLECwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:52:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701E6BF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:52:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE33C433C7;
        Tue,  5 Dec 2023 02:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701744732;
        bh=EdPT0D7iQR/UUGO665qQNSALpBEJ+4Q7yzIggGYt+IY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qEl86zg3qrkgdVwO1uWAQ0QtcHS86eAhjAyo3Ut2ID/fjR4NsfF1zNAhvKXSseiCp
         ppA7cOlhod8g9lYZt+hSF1pHHBfDxHhB5nuqsHOvJ2trZSPCPWW+LvLOzWCn30AOd3
         smkPzXI57CHH9PjHLAPCFkANWCsuMeDT03stNBpgZUMEyBFVIpYdwgdTEp5vqzTYr9
         KP8IRoU2g30RRmNvShYWSrlDaJh0dasDkShMwWMLTURdtIZGBp5MHKe446v0/EX6kt
         TJNmdQRWr8pRvoeg4BNAGczkU06qRgojqRlrUqkSzQDR+NglaSIv5rmpUkPbfyt7vV
         hcxWW9hnSer4w==
Date:   Mon, 4 Dec 2023 18:52:10 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Aron Silverton <aron.silverton@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saeed Mahameed <saeed@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231204185210.030a72ca@kernel.org>
In-Reply-To: <oxtcvxwbj2hzv4lxnxubo3hoxn7diyzhm2oj3tsw2toxbc3og4@ddglhm6r3oa5>
References: <ZWTtTjgBrNxpd9IO@x130>
        <20231127160719.4a8b2ad1@kernel.org>
        <20231128044628.GA8901@u2004-local>
        <20231128065321.53d4d5bb@kernel.org>
        <20231128162413.GP436702@nvidia.com>
        <20231128084421.6321b9b2@kernel.org>
        <20231128175224.GR436702@nvidia.com>
        <20231128103304.25c2c642@kernel.org>
        <ZWZJGF7moDM_k6TU@x130>
        <2023112922-lyricist-unclip-8e78@gregkh>
        <oxtcvxwbj2hzv4lxnxubo3hoxn7diyzhm2oj3tsw2toxbc3og4@ddglhm6r3oa5>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 15:37:56 -0600 Aron Silverton wrote:
> > To Jakub's point, no, we don't care about enterprise distros, they are a
> > consumer of our releases and while some of them pay the salaries of our
> > developers, they really don't have much influence over our development
> > rules as they are just so far behind in releases that their releases
> > look nothing like what we do in places (i.e. Linux "like" just like many
> > Android systems.)
> > 
> > If the enterprise distros pop in here and give us their opinions of the
> > patchset, I would GREATLY appreciate it, as having more people review
> > code at this point in time would be most helpful instead of having to
> > hear about how the interfaces are broken 2 years from now.  
> 
> We will be happy to test and review v4 of this series.
> 
> Fully interactive debugging has become essential to getting to the root
> cause of complex issues that arise between the types of devices being
> discussed and their interactions with various software layers. Turning
> knobs and dumping registers just isn't sufficient, and I wish we'd had
> this capability long ago.

Could you shed some light on what issues you were debugging, broadly?

> Our customers have already benefited from the interactive debugging
> capability that these patches provide, but the full potential won't be
> realized until this is upstream.

Can you elaborate on why "full potential won't be realized until this
is upstream"? The driver looks very easy to ship as a standalone module.
