Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9118580A800
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjLHP6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjLHP6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:58:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68321724
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:58:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6BEC433C7;
        Fri,  8 Dec 2023 15:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702051123;
        bh=MlWQ/Dqc/AdBNC5cQ3npxxMUqS8al00CqKTethLo9es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b1SkW/EcrCMKqeaA/I8hLeACshg+6uCnC84Jn04sJBo5QHoDP7+xVe+XGwfVE7RiQ
         3JAHUknhkxZoJAJd7pddJLCaFLy0c7ARDdi1j0q3e7domv5eG6D1GNMDinCcNB/88w
         IYmrpsP6/EZuSlqfozW28atd3S5PVi5rPKP50sDk=
Date:   Fri, 8 Dec 2023 16:58:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gustavo Padovan <gustavo.padovan@collabora.com>
Cc:     stable@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>
Subject: Re: stable/LTS test report from KernelCI (2023-12-08)
Message-ID: <2023120846-taste-saga-c4a9@gregkh>
References: <738c6c87-527e-a1c2-671f-eed6a1dbaef3@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <738c6c87-527e-a1c2-671f-eed6a1dbaef3@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 12:29:35PM -0300, Gustavo Padovan wrote:
> Hello,
> 
> As discussed with Greg at LPC, we are starting an iterative process to
> deliver meaningful stable test reports from KernelCI. As Greg pointed out,
> he doesn't look at the current reports sent automatically from KernelCI.
> Those are not clean enough to help the stable release process, so we
> discussed starting over again.
> 
> This reporting process is a learning exercise, growing over time. We are
> starting small with data we can verify manually (at first) to make sure we
> are not introducing noise or reporting flakes and false-positives. The
> feedback loop will teach us how to filter the results and report with
> incremental automation of the steps.
> 
> Today we are starting with build and boot tests (for the hardware platforms
> in KernelCI with sustained availability over time). Then, at every iteration
> we try to improve it, increasing the coverage and data visualization.
> Feedback is really important. Eventually, we will also have this report
> implemented in the upcoming KernelCI Web Dashboard.
> 
> This work is a contribution from Collabora(on behalf of its clients) to
> improve the Kernel Integration as whole. Moving forward, Shreeya Patel, from
> the Collabora team will be taking on the responsibilities of delivering
> these reports.
> 
> Without further ado, here's our first report:
> 
> 
> ## stable-rc HEADs:
> 
> Date: 2023-12-08
> 6.1: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=45deeed0dade29f16e1949365688ea591c20cf2c
> 5:15: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=e5a5d1af708eced93db167ad55998166e9d893e1
> 5.10: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=ce575ec88a51a60900cd0995928711df8258820a
> 5:4: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=f47279cbca2ca9f2bbe1178634053024fd9faff3
> 
> * 6.6 stable-rc was not added in KernelCI yet, but we plan to add it next
> week.
> 
> 
> ## Build failures:
> 
> No build failures seen for the stable-rc/queue commit heads for
> 6.1/5.15/5.10/5.4  \o/
> 
> 
> ## Boot failures:
> 
> No **new** boot failures seen for the stable-rc/queue commit heads for
> 6.1/5.15/5.10/5.4  \o/
> 
> (for the time being we are leaving existing failures behind)
> 
> 
> ## Considerations
> 
> All this data is available in the legacy KernelCI Web Dashboard -
> https://linux.kernelci.org/ - but not easily filtered there. The data in
> this report was checked manually. As we evolve this report, we want to add
> traceability of the information, making it really easy for anyone to dig
> deeper for more info, logs, etc.
> 
> The report covers  the hardware platforms in KernelCI with sustained
> availability over time - we will detail this further in future reports.
> 
> We opted to make the report really simple as you can see above. It is just
> an initial spark. From here your feedback will drive the process. So really
> really tell us what you want to see next. We want FEEDBACK!

Looks great!

A few notes, it can be a bit more verbose if you want :)

One email per -rc release (i.e. one per branch) is fine, and that way if
you add a:
	Tested-by: kernelci-bot <email goes here>
or something like that, to the email, my systems will pick it up and it
will get added to the final commit message.

But other than that, hey, I'll take the above, it's better than what was
there before!

How about if something breaks, what will it look like?  That's where it
gets more "interesting" :)

thanks,

greg k-h
