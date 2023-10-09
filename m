Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06767BD431
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345379AbjJIHXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjJIHXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:23:03 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C75BAB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 00:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696836179;
        bh=QwqFqkXh+UwZPAFFs4+wsmZwhgNgtwMLcNYLANcfZzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IC3/eBwVy7afGzWq1WxfzfAQrcJOn26dEgf/B9CszKdCS1AhRmMDQ91ascjNIqntg
         J/ElC7SLdXmBD75hG0dtwk0iBz4q0Rp0tDuR1TYYf+3zdYyluQ6MKKy/AvC3sHQwWf
         NO0mbcy0Fl0hE53KtpxgPqj+Luguflh9KbdUCCFs=
Date:   Mon, 9 Oct 2023 09:22:59 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: nolibc changes since 6.6-rc1 for linux-next
Message-ID: <f9695abc-f1f2-49e0-901b-41a078ec57c5@t-8ch.de>
References: <dcfa99da-eb3e-4c85-9e7f-092bbb1be801@linuxfoundation.org>
 <48c01af3-d373-4546-a8f2-d81fa447eaaa@t-8ch.de>
 <25382680-956a-4612-b930-f6823c71cf8d@paulmck-laptop>
 <696fc488-63d3-444c-a9f2-14d7a7379143@linuxfoundation.org>
 <23bc3841-4cda-4a23-a67f-a944e1104f1d@paulmck-laptop>
 <20231007070630.GB20998@1wt.eu>
 <d80c1da1-56f8-4b94-b1e2-eef75a52d022@paulmck-laptop>
 <fad7814f-0bbd-43f0-a205-9ba2c08bac22@t-8ch.de>
 <76a51116-46bb-4271-b5ac-c101e02d5a63@paulmck-laptop>
 <ZSOjhgIbK8bs3Asu@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSOjhgIbK8bs3Asu@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy, Paul,

On 2023-10-09 08:53:58+0200, Willy Tarreau wrote:
> On Sun, Oct 08, 2023 at 09:27:43AM -0700, Paul E. McKenney wrote:
> (...)
> > The other approach involves rebasing the "nolibc/next" stack
> > on top of the "nolibc/fixes" stack.
> 
> That was my initial expectation as well, it's much easier, preserves
> the patches ordering so it guarantees that all fixes are always present
> in -next and that there won't be conflicts when they're finally submitted.

The workflow Paul described indeed makes a lot of sense.

I can redo it this afternoon.

> [..]

> > While in the area, would the following (absolutely not urgent or even
> > particularly important) patch be a good idea?  This gets rid of a line
> > of noise from "git status" after running the tests.
> 
> Good idea, feel free to propose a patch ;-)

How about directly folding it into the original patch?
I can take care of that later today, too.

Thomas
