Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E244680CA82
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343596AbjLKNHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKNHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:07:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00928E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:07:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF09C433C8;
        Mon, 11 Dec 2023 13:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702300067;
        bh=ZDCtyG813baQDVWKjc89UP4RJr4fKedSXMPxHtc1i/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sHFNXcyodzwBK+JWl3fj37d2dGy1Q7Qo4oaSMXrFvju/1jTUCBOIx/6Y5QAfI1vnR
         3QxEB6c7oHLf8poxzBjt69BeppZLm9EM2GC14khbC3xZ7PK/E7+2PPQdly9yiHRhHx
         UlK1UAJ7WGakdKBxsFiRc7V7tihpnH0mNGVgyVkc=
Date:   Mon, 11 Dec 2023 14:07:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guillaume Tucker <gtucker@gtucker.io>
Cc:     Gustavo Padovan <gustavo.padovan@collabora.com>,
        stable@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>
Subject: Re: stable/LTS test report from KernelCI (2023-12-08)
Message-ID: <2023121131-delirious-roster-e729@gregkh>
References: <738c6c87-527e-a1c2-671f-eed6a1dbaef3@collabora.com>
 <2023120846-taste-saga-c4a9@gregkh>
 <1ca05280-a03c-66c0-cd67-87c58c8f3929@gtucker.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ca05280-a03c-66c0-cd67-87c58c8f3929@gtucker.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 11:14:03AM +0100, Guillaume Tucker wrote:
> On a related topic, it was once mentioned that since stable
> releases occur once a week and they are used as the basis for
> many distros and products, it would make sense to have
> long-running tests after the release has been declared.  So we
> could have say, 48h of testing with extended coverage from LTP,
> fstests, benchmarks etc.  That would be a reply to the email with
> the release tag, not the patch review.

What tests take longer than 48 hours?

> I've mentioned before the concept of finding "2nd derivatives" in
> the rest results, basically the first delta gives you all the
> regressions and then you do a delta of the regressions to find
> the new ones.  Maintainer trees would be typically comparing
> against mainline or say, the -rc2 tag where they based their
> branch.  In the case of stable, it would be between the stable-rc
> branch being tested and the base stable branch with the last
> tagged release.

Yes, that is going to be required for this to be useful.

> One last thing, I see there's a change in KernelCI now to
> actually stop sending the current (suboptimal) automated reports
> to the stable mailing list:
> 
>   https://github.com/kernelci/kernelci-jenkins/pull/136
> 
> Is this actually what people here want?

If these reports are currently for me, I'm just deleting them as they
provide no value anymore.  So yes, let's stop this until we can get
something that actually works for us please.

thanks,

greg k-h
