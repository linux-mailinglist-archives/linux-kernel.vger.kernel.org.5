Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27655777FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjHJRzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjHJRzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:55:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B659E10C0;
        Thu, 10 Aug 2023 10:55:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C4EB661CA;
        Thu, 10 Aug 2023 17:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A218FC433C7;
        Thu, 10 Aug 2023 17:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691690116;
        bh=0oob3MuuVbbSM5jo+74qp2G/ortoaaCy5iGcDUv66KM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QC+U6i7Fb9d3h7bvLVMN4/9bt5YLWuYlz8UZ3FNSeu1cH54rZ6gMXB3VZzGos3p0f
         XgjlducA/Seta8iOhFfuEC7TpJg9BZ5T4U0FXBzAX8ZT9g5VE4bCXGRjEEhnLAKCr8
         P86GS2lDHhmn1iWEhY7VPweh1P8JhmfsLwNUrjYB3XgGYgdEZja/SW9cCWNLuRF7Ps
         YJrWXD2KKgobmRb8WnFKxqEON874ebTJiSJ47ZK9o4Y63En6UjEhpFoCO/UUCYqzpU
         YjEagz89JM+NiAI7FeQJfBgZcVSwu8AthanOxH5HiGBGGQtMtkCljDJ0ONS9kDFGpS
         DXgO7jS4iq6gw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3A10DCE0ACC; Thu, 10 Aug 2023 10:55:16 -0700 (PDT)
Date:   Thu, 10 Aug 2023 10:55:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 00/92] 5.15.126-rc1 review
Message-ID: <882a606f-5776-46d1-a423-2c5ea0a1cd8f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230809103633.485906560@linuxfoundation.org>
 <20230809135326.GE3031656@google.com>
 <f47340c6-3c41-1f91-d0f9-fe0b59a23aac@roeck-us.net>
 <CAEXW_YQ4GqPwvUF8=8CWmdj=cD56v_eEVK-EirsObQXyBDFVpg@mail.gmail.com>
 <35e4b770-2ead-4a19-ad01-fa75996adef4@roeck-us.net>
 <20230809201413.GA3374446@google.com>
 <6b05a082-41a7-f0cf-c0a4-1cced8d5a230@roeck-us.net>
 <CAEXW_YT-7epvu4uUS19aDAcM0X63j9_L2aa-XGGFGSLceLu8bA@mail.gmail.com>
 <4dbe72a3-50ea-051c-96ba-d709b33d3a98@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4dbe72a3-50ea-051c-96ba-d709b33d3a98@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 02:45:44PM -0700, Guenter Roeck wrote:
> On 8/9/23 13:39, Joel Fernandes wrote:
> > On Wed, Aug 9, 2023 at 4:38 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > 
> > > On 8/9/23 13:14, Joel Fernandes wrote:
> > > > On Wed, Aug 09, 2023 at 12:25:48PM -0700, Guenter Roeck wrote:
> > > > > On Wed, Aug 09, 2023 at 02:35:59PM -0400, Joel Fernandes wrote:
> > > > > > On Wed, Aug 9, 2023 at 12:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > > > 
> > > > > > > On 8/9/23 06:53, Joel Fernandes wrote:
> > > > > > > > On Wed, Aug 09, 2023 at 12:40:36PM +0200, Greg Kroah-Hartman wrote:
> > > > > > > > > This is the start of the stable review cycle for the 5.15.126 release.
> > > > > > > > > There are 92 patches in this series, all will be posted as a response
> > > > > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > > > > let me know.
> > > > > > > > > 
> > > > > > > > > Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> > > > > > > > > Anything received after that time might be too late.
> > > > > > > > > 
> > > > > > > > > The whole patch series can be found in one patch at:
> > > > > > > > >        https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.126-rc1.gz
> > > > > > > > > or in the git tree and branch at:
> > > > > > > > >        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > > > > > > > and the diffstat can be found below.
> > > > > > > > 
> > > > > > > > Not necesscarily new with 5.15 stable but 3 of the 19 rcutorture scenarios
> > > > > > > > hang with this -rc: TREE04, TREE07, TASKS03.
> > > > > > > > 
> > > > > > > > 5.15 has a known stop machine issue where it hangs after 1.5 hours with cpu
> > > > > > > > hotplug rcutorture testing. Me and tglx are continuing to debug this. The
> > > > > > > > issue does not show up on anything but 5.15 stable kernels and neither on
> > > > > > > > mainline.
> > > > > > > > 
> > > > > > > 
> > > > > > > Do you by any have a crash pattern that we could possibly use to find the crash
> > > > > > > in ChromeOS crash logs ? No idea if that would help, but it could provide some
> > > > > > > additional data points.
> > > > > > 
> > > > > > The pattern shows as a hard hang, the system is unresponsive and all CPUs
> > > > > > are stuck in stop_machine. Sometimes it recovers on its own from the
> > > > > > hang and then RCU immediately gives stall warnings. It takes 1.5 hour
> > > > > > to reproduce and sometimes never happens for several hours.
> > > > > > 
> > > > > > It appears related to CPU hotplug since gdb showed me most of the CPUs
> > > > > > are spinning in multi_cpu_stop() / stop machine after the hang.
> > > > > > 
> > > > > 
> > > > > Hmm, we do see lots of soft lockups with multi_cpu_stop() in the backtrace,
> > > > > but not with v5.15.y but with v5.4.y. The actual hang is in stop_machine_yield().
> > > > 
> > > > Interesting. It looks similar as far as the stack dump in gdb goes, here are
> > > > the stacks I dumped with the hang I referred to:
> > > > https://paste.debian.net/1288308/
> > > > 
> > > 
> > > That link gives me "Entry not found".
> > 
> > Yeah that was weird. Here it is again: https://pastebin.com/raw/L3nv1kH2
> 
> I found a couple of crash reports from chromeos-5.10, one of them complaining
> about RCU issues. I sent you links via IM. Nothing from 5.15 or later, though.

Is the crash showing the eternally refiring timer fixed by this commit?

53e87e3cdc15 ("timers/nohz: Last resort update jiffies on nohz_full IRQ entry")

This commit fixed something similar for me in v5.16.

	https://paulmck.livejournal.com/62071.html

							Thanx, Paul
