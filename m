Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60D6778381
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjHJWOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjHJWOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:14:18 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC50E271E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:14:17 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-79095499a16so47811739f.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691705657; x=1692310457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4hiprcKNrSu45FYJFqt/DEzd7xwq3zHBCL0qQdixIF4=;
        b=Xfb+n0VtNScCegii2P4RzfZczEUQuSVo7obA0O6kFZyYOmsiu+tihz0otguRzFaD6J
         tDeFDoqXJJe4J8zUT/NCkIab66n2n57t7CjCYZymFNH4j/tuSnupLGy/Dsk01LWQ/hVy
         z+Uo+iiUL3POyXR2dg/2v484lOvAQZVQ+iSo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691705657; x=1692310457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hiprcKNrSu45FYJFqt/DEzd7xwq3zHBCL0qQdixIF4=;
        b=Mu2QOOqj+K34sUWnESSE7HGqyOxhkpTE3Yd4jIk+6q/kGzbJT0SCX/tuEXFdkiH5Rn
         q8smPNFvTQaOFAsbwUJmjN9a4YRacOtO/G8OJFmm/lMJFIWAy4Dm9YGYeGK/ndk0yCjA
         RAPCX95jz3I/MRD3VOnJfXc5jHBceLEESrHhyUjK94IKXE0whKcSdIXbdTziTA7lkWKL
         qPIQqIwfgmzqzdnE8YyDTjpVTVrJBVbjgyuhF0PWyt9HDhQzWTmyyj3Hb3Tx/JViV3/A
         9nEeEPZinlWNAs5PTEIsN1AlsLbPShz0uGHRvh73E2vPIusDkyvTWcZFnlkYVGUvvssE
         YW7g==
X-Gm-Message-State: AOJu0YxGdLsOaJmH5jeyheEujYPCLq4odGYTMBQdDl6WvRRuVqG5oYwH
        qUaY/MB8gVPrUbSVZd3UlCT4Fw==
X-Google-Smtp-Source: AGHT+IGS2W0U+h/ngAgBVacPFn+CjwVE3Qd00/iFJ9fG0NTgSxzxb0e/yuuEXmraAsbqDSVTD7Y3qQ==
X-Received: by 2002:a6b:6d07:0:b0:790:a13d:d63a with SMTP id a7-20020a6b6d07000000b00790a13dd63amr412908iod.6.1691705657279;
        Thu, 10 Aug 2023 15:14:17 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id gq8-20020a0566382d0800b0042b6ae47f0esm677353jab.108.2023.08.10.15.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 15:14:16 -0700 (PDT)
Date:   Thu, 10 Aug 2023 22:14:16 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 00/92] 5.15.126-rc1 review
Message-ID: <20230810221416.GB562211@google.com>
References: <20230809135326.GE3031656@google.com>
 <f47340c6-3c41-1f91-d0f9-fe0b59a23aac@roeck-us.net>
 <CAEXW_YQ4GqPwvUF8=8CWmdj=cD56v_eEVK-EirsObQXyBDFVpg@mail.gmail.com>
 <35e4b770-2ead-4a19-ad01-fa75996adef4@roeck-us.net>
 <20230809201413.GA3374446@google.com>
 <6b05a082-41a7-f0cf-c0a4-1cced8d5a230@roeck-us.net>
 <CAEXW_YT-7epvu4uUS19aDAcM0X63j9_L2aa-XGGFGSLceLu8bA@mail.gmail.com>
 <4dbe72a3-50ea-051c-96ba-d709b33d3a98@roeck-us.net>
 <882a606f-5776-46d1-a423-2c5ea0a1cd8f@paulmck-laptop>
 <20230810215416.GA562211@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810215416.GA562211@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 09:54:16PM +0000, Joel Fernandes wrote:
> On Thu, Aug 10, 2023 at 10:55:16AM -0700, Paul E. McKenney wrote:
> > On Wed, Aug 09, 2023 at 02:45:44PM -0700, Guenter Roeck wrote:
> > > On 8/9/23 13:39, Joel Fernandes wrote:
> > > > On Wed, Aug 9, 2023 at 4:38 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > 
> > > > > On 8/9/23 13:14, Joel Fernandes wrote:
> > > > > > On Wed, Aug 09, 2023 at 12:25:48PM -0700, Guenter Roeck wrote:
> > > > > > > On Wed, Aug 09, 2023 at 02:35:59PM -0400, Joel Fernandes wrote:
> > > > > > > > On Wed, Aug 9, 2023 at 12:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > > > > > 
> > > > > > > > > On 8/9/23 06:53, Joel Fernandes wrote:
> > > > > > > > > > On Wed, Aug 09, 2023 at 12:40:36PM +0200, Greg Kroah-Hartman wrote:
> > > > > > > > > > > This is the start of the stable review cycle for the 5.15.126 release.
> > > > > > > > > > > There are 92 patches in this series, all will be posted as a response
> > > > > > > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > > > > > > let me know.
> > > > > > > > > > > 
> > > > > > > > > > > Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> > > > > > > > > > > Anything received after that time might be too late.
> > > > > > > > > > > 
> > > > > > > > > > > The whole patch series can be found in one patch at:
> > > > > > > > > > >        https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.126-rc1.gz
> > > > > > > > > > > or in the git tree and branch at:
> > > > > > > > > > >        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > > > > > > > > > and the diffstat can be found below.
> > > > > > > > > > 
> > > > > > > > > > Not necesscarily new with 5.15 stable but 3 of the 19 rcutorture scenarios
> > > > > > > > > > hang with this -rc: TREE04, TREE07, TASKS03.
> > > > > > > > > > 
> > > > > > > > > > 5.15 has a known stop machine issue where it hangs after 1.5 hours with cpu
> > > > > > > > > > hotplug rcutorture testing. Me and tglx are continuing to debug this. The
> > > > > > > > > > issue does not show up on anything but 5.15 stable kernels and neither on
> > > > > > > > > > mainline.
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Do you by any have a crash pattern that we could possibly use to find the crash
> > > > > > > > > in ChromeOS crash logs ? No idea if that would help, but it could provide some
> > > > > > > > > additional data points.
> > > > > > > > 
> > > > > > > > The pattern shows as a hard hang, the system is unresponsive and all CPUs
> > > > > > > > are stuck in stop_machine. Sometimes it recovers on its own from the
> > > > > > > > hang and then RCU immediately gives stall warnings. It takes 1.5 hour
> > > > > > > > to reproduce and sometimes never happens for several hours.
> > > > > > > > 
> > > > > > > > It appears related to CPU hotplug since gdb showed me most of the CPUs
> > > > > > > > are spinning in multi_cpu_stop() / stop machine after the hang.
> > > > > > > > 
> > > > > > > 
> > > > > > > Hmm, we do see lots of soft lockups with multi_cpu_stop() in the backtrace,
> > > > > > > but not with v5.15.y but with v5.4.y. The actual hang is in stop_machine_yield().
> > > > > > 
> > > > > > Interesting. It looks similar as far as the stack dump in gdb goes, here are
> > > > > > the stacks I dumped with the hang I referred to:
> > > > > > https://paste.debian.net/1288308/
> > > > > > 
> > > > > 
> > > > > That link gives me "Entry not found".
> > > > 
> > > > Yeah that was weird. Here it is again: https://pastebin.com/raw/L3nv1kH2
> > > 
> > > I found a couple of crash reports from chromeos-5.10, one of them complaining
> > > about RCU issues. I sent you links via IM. Nothing from 5.15 or later, though.
> > 
> > Is the crash showing the eternally refiring timer fixed by this commit?
> > 
> > 53e87e3cdc15 ("timers/nohz: Last resort update jiffies on nohz_full IRQ entry")
> 
> Ah I was just replying, I have been seeing really good results after applying
> the following 3 commits since yesterday:
> 
> 53e87e3cdc15 ("timers/nohz: Last resort update jiffies on nohz_full IRQ entry")
> 5417ddc1cf1f ("timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped")
> a1ff03cd6fb9 ("tick: Detect and fix jiffies update stall")
> 
> 5417ddc1cf1f also mentioned a "tick storm" which is exactly what I was
> seeing.
> 
> I did a lengthy test and everything is looking good. I'll send these out to
> the stable list.

I just read your post for the first time. And just to humor you about my
debugging which was very similar to yours, I got as far as this statement in
your post (before looking for fixes in timer code):
<quote>
Further checking showed that the stuck CPU was in fact suffering from an
interrupt storm, namely an interrupt storm of scheduling-clock interrupts.
This spurred another code-inspection session.
</quote>

My detection of this came from gdb, within that 2000 second stall, I broke
into the VM with --gdb and kept dumping the stuck CPU's stack with "thread X"
and "bt". I noticed that it was always in the timer interrupt. Here were the
stacks: https://pastebin.com/raw/L3nv1kH2

Then I narrowed my search down to timer events by enabling
boot options ftrace_dump_on_oops and panic-on-stall ones, and noticed a storm
of hrtimer_start coming out of the long stall. I was all but certain it was a
tick storm and noticed it kept programming hrtimer to the same event.

Ah, then I just did a "git diff" in kernel/time/ between v5.15 and v6.1 and
noticed the missing patches. ;-)

Though in my experience, I wasn't seeing a KTIME_MAX-type of value like you
mentioned in the post. What I noticed is that the tick was never stopped, it
just kept firing a bit earlier than was requested and in the interrupt exit
path (of the delivered-too-early timer interrupt), it kept re-requesting the
tick.

thanks,

 - Joel

