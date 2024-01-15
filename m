Return-Path: <linux-kernel+bounces-25589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A51982D315
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6E51F21318
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BD120F4;
	Mon, 15 Jan 2024 02:21:08 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2E51C1FAA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 02:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 706546 invoked by uid 1000); 14 Jan 2024 21:20:59 -0500
Date: Sun, 14 Jan 2024 21:20:59 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: "Dr. Henning Kopp" <hkopp22@yahoo.de>,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  Linux Power Management <linux-pm@vger.kernel.org>,
  Ulf Hansson <ulf.hansson@linaro.org>,
  "Rafael J . Wysocki" <rafael@kernel.org>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Viresh Kumar <viresh.kumar@linaro.org>,
  Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: Why does Linux not implement pthread_suspend() and
 pthread_resume()?
Message-ID: <5d1b969d-6c0a-4077-87ee-e41ab164fa3b@rowland.harvard.edu>
References: <0219492d-3971-f8e0-8b46-22d442a2d442.ref@yahoo.de>
 <0219492d-3971-f8e0-8b46-22d442a2d442@yahoo.de>
 <ZaPrVWwqkHMj3Bpp@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaPrVWwqkHMj3Bpp@archie.me>

On Sun, Jan 14, 2024 at 09:10:29PM +0700, Bagas Sanjaya wrote:
> [also Cc: linux-pm people]
> 
> On Sun, Jan 14, 2024 at 12:20:04PM +0100, Dr. Henning Kopp wrote:
> > Hi everyone,
> > 
> > I have a question regarding pthreads. In particular, I was wondering why
> > there is no way to suspend and resume a thread in Linux.
> > 
> > In Windows, there is SuspendThread() and ResumeThread() from
> > processthreadsapi.h. However in Linux, there does not seem to be a similar
> > function in pthread.h.
> > 
> > When researching this issue i found multiple ways to work around the
> > inability of suspending a thread, such as using mutexes. But my question is
> > why nobody bothered implementing suspending/resuming threads.
> > 
> > I found one answer on stackoverflow [1] that mentions that pthread_suspend
> > and pthread_resume_np is in the "Unix specification", but not implemented in
> > Linux. I tried to follow up on this hint and get access to the Posix spec,
> > but i am not affiliated with a university anymore, so i was unable to
> > download the spec.
> > 
> > I read "man 7 pthreads". It mentions that there are two Linux
> > implementations of Posix threads, that differ in some details from the Posix
> > spec. However, it does not mention suspending or resuming threads at all.
> 
> LinuxThreads and NPTL?
> 
> > 
> > I hope this is the right mailing list for my question. If it is off-topic,
> > please accept my apologies.
> > 
> > So my question is: What is the reason that Linux does not implement
> > functions for suspending and resuming threads?
> > 
> 
> Confused...

These are indeed the wrong mailing lists (and people) for this question.  
These lists are dedicated to discussions about the Linux kernel.  But 
pthreads is a userspace library; it runs in user mode and is not part of 
the kernel at all.

The best approach would be to find the group responsible for writing and 
maintaining the Linux pthreads implementation (probably some subgroup 
of the people working on the GNU C library), and ask them.

Sorry I can't be of any more help.

Alan Stern


