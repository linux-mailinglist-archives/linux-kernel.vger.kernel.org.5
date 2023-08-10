Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3644C7783B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjHJWei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjHJWeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:34:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0770D2D47;
        Thu, 10 Aug 2023 15:34:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8287F65A3C;
        Thu, 10 Aug 2023 22:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1095C433C8;
        Thu, 10 Aug 2023 22:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691706874;
        bh=MfRibW6RHgL1B8fzoaM7FBu1oS6YuLOwVbLNTgdwo3s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XE7cHH49JEBTBjITOQPDDC9UNc9Kg4M0ZnHPgwOehGdlb9UfwF6QIcr/1JVxdyurb
         oq4usIYrqviUqghzjbjQRNllXgAIepm1HdvhHQjx45rskWDqmcfpVzF9EA/ncIxWlj
         XmPL1HQmyLZgj91sx3VJ/XkmtByv5Ri2SBXRt+5a2UwemTJQUAEHbBdos2gOcJWZ++
         hqLEAsBqpdrLMRdoE80m57ThR4pdAkej+3l4HCD5mTasaerE96MKfhSKPHE4yuYAjK
         9o5teWOa32Uj2Hn9vm2IqjFg2373XY0lyj/VYsx/aby1cB2maGwen6ZhLh9Tnla3A6
         une10eyzfKr7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 77163CE0AB1; Thu, 10 Aug 2023 15:34:34 -0700 (PDT)
Date:   Thu, 10 Aug 2023 15:34:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 00/92] 5.15.126-rc1 review
Message-ID: <4e15cd09-08a6-42c1-bd33-ac38d8fcd9bb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f47340c6-3c41-1f91-d0f9-fe0b59a23aac@roeck-us.net>
 <CAEXW_YQ4GqPwvUF8=8CWmdj=cD56v_eEVK-EirsObQXyBDFVpg@mail.gmail.com>
 <35e4b770-2ead-4a19-ad01-fa75996adef4@roeck-us.net>
 <20230809201413.GA3374446@google.com>
 <6b05a082-41a7-f0cf-c0a4-1cced8d5a230@roeck-us.net>
 <CAEXW_YT-7epvu4uUS19aDAcM0X63j9_L2aa-XGGFGSLceLu8bA@mail.gmail.com>
 <4dbe72a3-50ea-051c-96ba-d709b33d3a98@roeck-us.net>
 <882a606f-5776-46d1-a423-2c5ea0a1cd8f@paulmck-laptop>
 <20230810215416.GA562211@google.com>
 <20230810221416.GB562211@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810221416.GB562211@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 10:14:16PM +0000, Joel Fernandes wrote:
> On Thu, Aug 10, 2023 at 09:54:16PM +0000, Joel Fernandes wrote:
> > On Thu, Aug 10, 2023 at 10:55:16AM -0700, Paul E. McKenney wrote:
> > > On Wed, Aug 09, 2023 at 02:45:44PM -0700, Guenter Roeck wrote:
> > > > On 8/9/23 13:39, Joel Fernandes wrote:
> > > > > On Wed, Aug 9, 2023 at 4:38 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > > 
> > > > > > On 8/9/23 13:14, Joel Fernandes wrote:
> > > > > > > On Wed, Aug 09, 2023 at 12:25:48PM -0700, Guenter Roeck wrote:
> > > > > > > > On Wed, Aug 09, 2023 at 02:35:59PM -0400, Joel Fernandes wrote:
> > > > > > > > > On Wed, Aug 9, 2023 at 12:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > > > > > > 
> > > > > > > > > > On 8/9/23 06:53, Joel Fernandes wrote:
> > > > > > > > > > > On Wed, Aug 09, 2023 at 12:40:36PM +0200, Greg Kroah-Hartman wrote:
> > > > > > > > > > > > This is the start of the stable review cycle for the 5.15.126 release.
> > > > > > > > > > > > There are 92 patches in this series, all will be posted as a response
> > > > > > > > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > > > > > > > let me know.
> > > > > > > > > > > > 
> > > > > > > > > > > > Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> > > > > > > > > > > > Anything received after that time might be too late.
> > > > > > > > > > > > 
> > > > > > > > > > > > The whole patch series can be found in one patch at:
> > > > > > > > > > > >        https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.126-rc1.gz
> > > > > > > > > > > > or in the git tree and branch at:
> > > > > > > > > > > >        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > > > > > > > > > > and the diffstat can be found below.
> > > > > > > > > > > 
> > > > > > > > > > > Not necesscarily new with 5.15 stable but 3 of the 19 rcutorture scenarios
> > > > > > > > > > > hang with this -rc: TREE04, TREE07, TASKS03.
> > > > > > > > > > > 
> > > > > > > > > > > 5.15 has a known stop machine issue where it hangs after 1.5 hours with cpu
> > > > > > > > > > > hotplug rcutorture testing. Me and tglx are continuing to debug this. The
> > > > > > > > > > > issue does not show up on anything but 5.15 stable kernels and neither on
> > > > > > > > > > > mainline.
> > > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > Do you by any have a crash pattern that we could possibly use to find the crash
> > > > > > > > > > in ChromeOS crash logs ? No idea if that would help, but it could provide some
> > > > > > > > > > additional data points.
> > > > > > > > > 
> > > > > > > > > The pattern shows as a hard hang, the system is unresponsive and all CPUs
> > > > > > > > > are stuck in stop_machine. Sometimes it recovers on its own from the
> > > > > > > > > hang and then RCU immediately gives stall warnings. It takes 1.5 hour
> > > > > > > > > to reproduce and sometimes never happens for several hours.
> > > > > > > > > 
> > > > > > > > > It appears related to CPU hotplug since gdb showed me most of the CPUs
> > > > > > > > > are spinning in multi_cpu_stop() / stop machine after the hang.
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > Hmm, we do see lots of soft lockups with multi_cpu_stop() in the backtrace,
> > > > > > > > but not with v5.15.y but with v5.4.y. The actual hang is in stop_machine_yield().
> > > > > > > 
> > > > > > > Interesting. It looks similar as far as the stack dump in gdb goes, here are
> > > > > > > the stacks I dumped with the hang I referred to:
> > > > > > > https://paste.debian.net/1288308/
> > > > > > > 
> > > > > > 
> > > > > > That link gives me "Entry not found".
> > > > > 
> > > > > Yeah that was weird. Here it is again: https://pastebin.com/raw/L3nv1kH2
> > > > 
> > > > I found a couple of crash reports from chromeos-5.10, one of them complaining
> > > > about RCU issues. I sent you links via IM. Nothing from 5.15 or later, though.
> > > 
> > > Is the crash showing the eternally refiring timer fixed by this commit?
> > > 
> > > 53e87e3cdc15 ("timers/nohz: Last resort update jiffies on nohz_full IRQ entry")
> > 
> > Ah I was just replying, I have been seeing really good results after applying
> > the following 3 commits since yesterday:
> > 
> > 53e87e3cdc15 ("timers/nohz: Last resort update jiffies on nohz_full IRQ entry")
> > 5417ddc1cf1f ("timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped")
> > a1ff03cd6fb9 ("tick: Detect and fix jiffies update stall")
> > 
> > 5417ddc1cf1f also mentioned a "tick storm" which is exactly what I was
> > seeing.
> > 
> > I did a lengthy test and everything is looking good. I'll send these out to
> > the stable list.
> 
> I just read your post for the first time. And just to humor you about my
> debugging which was very similar to yours, I got as far as this statement in
> your post (before looking for fixes in timer code):
> <quote>
> Further checking showed that the stuck CPU was in fact suffering from an
> interrupt storm, namely an interrupt storm of scheduling-clock interrupts.
> This spurred another code-inspection session.
> </quote>
> 
> My detection of this came from gdb, within that 2000 second stall, I broke
> into the VM with --gdb and kept dumping the stuck CPU's stack with "thread X"
> and "bt". I noticed that it was always in the timer interrupt. Here were the
> stacks: https://pastebin.com/raw/L3nv1kH2
> 
> Then I narrowed my search down to timer events by enabling
> boot options ftrace_dump_on_oops and panic-on-stall ones, and noticed a storm
> of hrtimer_start coming out of the long stall. I was all but certain it was a
> tick storm and noticed it kept programming hrtimer to the same event.
> 
> Ah, then I just did a "git diff" in kernel/time/ between v5.15 and v6.1 and
> noticed the missing patches. ;-)
> 
> Though in my experience, I wasn't seeing a KTIME_MAX-type of value like you
> mentioned in the post. What I noticed is that the tick was never stopped, it
> just kept firing a bit earlier than was requested and in the interrupt exit
> path (of the delivered-too-early timer interrupt), it kept re-requesting the
> tick.

That "git diff" wouldn't have shown me much at the time, but I am very
glad that you found it!

							Thanx, Paul
