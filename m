Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C46F7BB8E9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjJFNUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjJFNUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:20:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C172A95
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:20:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F146C433C9;
        Fri,  6 Oct 2023 13:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696598408;
        bh=bkjpF90xs9W6T4GDw1pW54wVAZduRqdmSqenrnKSVcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z0J5LgVgp4BGBGj1lMOMt+xJoI2Ba4Z7PR4IPip5Yn70+NgGSi1U3CbVMzOICe3C6
         OWTBOcaLvpI1LOPbT9SWpMjRCsNWYvhjbfpKKiNOdNJ/6UV1DvrAddOMfv3lL2N9/5
         bs+bsMdo/P4OjncA4lCHgwmI8uZ8KKf2e7fx9B1o=
Date:   Fri, 6 Oct 2023 15:20:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>
Subject: Re: [PATCH 1/3] staging: greybus: raw: make raw_class constant
Message-ID: <2023100649-oxymoron-entrap-b959@gregkh>
References: <2023100533-broadband-hunk-9e91@gregkh>
 <ZSAHoIN8p2ROXvh/@runicha.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSAHoIN8p2ROXvh/@runicha.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 06:42:00PM +0530, Deepak R Varma wrote:
> On Thu, Oct 05, 2023 at 03:58:34PM +0200, Greg Kroah-Hartman wrote:
> > Now that the driver core allows for struct class to be in read-only
> 
> Hello Greg,
> When you say "Now", has anything changed recently that facilitates this
> improvement?

Yes.  Well, it showed up in the 6.4 kernel, so not that long ago.

> Where can I read more about this change?

Running:
	git log --oneline --author=gregkh v6.3..v6.4 drivers/base/
will show you the some of work that happened here to make this possible.
There was work done to the driver core, and the kobject core in earlier
kernel releases that the changes in 6.4 built on top of.

thanks,

greg k-h
