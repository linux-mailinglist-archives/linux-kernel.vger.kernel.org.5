Return-Path: <linux-kernel+bounces-122414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC6B88F6F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C912965C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369A23FBB8;
	Thu, 28 Mar 2024 05:05:45 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980D23FB98;
	Thu, 28 Mar 2024 05:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711602344; cv=none; b=TLb4vCpxyOCbyrx3Bkeh4/Ub97eWKVXDrdJ2QI+PkszBPp7OgbQXEWC64oHIChn3XWaGqMMUaZBqjKumjCVyb5cBTybOTZs+x54vuf40Ryh/IxlQs33Wl7nxylK920gRc0xbxZNaxi6mfWEj0zlLZksrCLGRk4q4haxzuzShz64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711602344; c=relaxed/simple;
	bh=uyNP3A4nFMKzdjPXwhMNvOH4+khsPK7PwkFgVwnBGGQ=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=c/Vr1VK9+j+P/Sjhbeke4PDeUHDF3VfHSY3A4F6m0tgQsFr6Pt2ZHCcVx+Bl/RTsid7O6Fd86T5aQCWqBWPmoWK8MOhvUiw/BIE+6KIzRA3SV/RogBFRowwBinUvFuLtJMZ3ms6zbe+p+em2dgut77VljXNuBBth6caLW9218l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:49518)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rphxI-002r46-J6; Wed, 27 Mar 2024 23:05:36 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:38046 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rphxF-001XDL-MF; Wed, 27 Mar 2024 23:05:36 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Russ Anderson <rja@hpe.com>,  Ingo Molnar <mingo@kernel.org>,  Dave
 Hansen <dave.hansen@linux.intel.com>,  Andy Lutomirski <luto@kernel.org>,
  Peter Zijlstra <peterz@infradead.org>,  Thomas Gleixner
 <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,  Borislav Petkov
 <bp@alien8.de>,  x86@kernel.org,  "H. Peter Anvin" <hpa@zytor.com>,
  linux-kernel@vger.kernel.org,  Linux regressions mailing list
 <regressions@lists.linux.dev>,  Pavin Joseph <me@pavinjoseph.com>,
  stable@vger.kernel.org,  Eric Hagberg <ehagberg@gmail.com>,  Simon Horman
 <horms@verge.net.au>,  Dave Young <dyoung@redhat.com>,  Sarah Brofeldt
 <srhb@dbc.dk>,  Dimitri Sivanich <sivanich@hpe.com>
References: <20240322162135.3984233-1-steve.wahl@hpe.com>
	<ZgABC1oQ9YJW6Bw3@gmail.com> <20240325020334.GA10309@hpe.com>
	<87o7b273p2.fsf@email.froward.int.ebiederm.org>
	<ZgHTXvCQr6ycbVzp@swahl-home.5wahls.com>
	<87r0fv6ddb.fsf@email.froward.int.ebiederm.org>
	<ZgQ8Ej-MLlNJR6wn@swahl-home.5wahls.com>
Date: Thu, 28 Mar 2024 00:05:02 -0500
In-Reply-To: <ZgQ8Ej-MLlNJR6wn@swahl-home.5wahls.com> (Steve Wahl's message of
	"Wed, 27 Mar 2024 10:33:20 -0500")
Message-ID: <87zfuj2bgh.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rphxF-001XDL-MF;;;mid=<87zfuj2bgh.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/rP3vBnFdeRfpMQaudSwPj7iI+6ka9cSU=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
	*      [score: 0.3079]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Steve Wahl <steve.wahl@hpe.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2272 ms - load_scoreonly_sql: 0.10 (0.0%),
	signal_user_changed: 15 (0.6%), b_tie_ro: 13 (0.6%), parse: 1.61
	(0.1%), extract_message_metadata: 19 (0.8%), get_uri_detail_list: 4.5
	(0.2%), tests_pri_-2000: 5 (0.2%), tests_pri_-1000: 3.4 (0.2%),
	tests_pri_-950: 2.4 (0.1%), tests_pri_-900: 2.2 (0.1%), tests_pri_-90:
	520 (22.9%), check_bayes: 505 (22.2%), b_tokenize: 15 (0.7%),
	b_tok_get_all: 407 (17.9%), b_comp_prob: 7 (0.3%), b_tok_touch_all: 69
	(3.0%), b_finish: 1.45 (0.1%), tests_pri_0: 458 (20.1%),
	check_dkim_signature: 0.61 (0.0%), check_dkim_adsp: 3.1 (0.1%),
	poll_dns_idle: 1224 (53.9%), tests_pri_10: 2.0 (0.1%), tests_pri_500:
	1239 (54.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Steve Wahl <steve.wahl@hpe.com> writes:

> On Wed, Mar 27, 2024 at 07:57:52AM -0500, Eric W. Biederman wrote:
>> Steve Wahl <steve.wahl@hpe.com> writes:
>> 
>> > On Mon, Mar 25, 2024 at 10:04:41AM -0500, Eric W. Biederman wrote:
>> >> Russ Anderson <rja@hpe.com> writes:
>> >> > Steve can certainly merge his two patches and resubmit, to replace the
>> >> > reverted original patch.  He should be on in the morning to speak for
>> >> > himself.
>> >> 
>> >> I am going to push back and suggest that this is perhaps a bug in the
>> >> HPE UV systems firmware not setting up the cpus memory type range
>> >> registers correctly.
>> >> 
>> >> Unless those systems are using new fangled cpus that don't have 16bit
>> >> and 32bit support, and don't implement memory type range registers,
>> >> I don't see how something that only affects HPE UV systems could be
>> >> anything except an HPE UV specific bug.
>> >
>> > Eric,
>> >
>> > I took the time to communicate with others in the company who know
>> > this stuff better than I do before replying on this.
>> >
>> > One of the problems with using the MTRRs for this is that there are
>> > simply not enough of them.  The MTRRs size/alignment requirements mean
>> > that more than one entry would be required per reserved region, and we
>> > need one reserved region per socket on systems that currently can go
>> > up to 32 sockets.  (In case you would think to ask, the reserved
>> > regions also cannot be made contiguous.)
>> >
>> > So MTRRs will not work to keep speculation out of our reserved memory
>> > regions.
>> >
>> > Let me know if you need more information from us on this.
>> 
>> Thanks for this.
>> 
>> Do you know if there are enough MTRRs for the first 4GB?
>
> I don't personally know all the details of how BIOS chooses to place
> things, but I suspect that might be true.  The restricted spaces
> usually end up at the end of the address range for a particular node,
> and 4GB would be in the early part of node 0.  If the conversation
> develops further along these lines, I can find out more definitively.
>
>> I am curious if kexec should even consider going into 32bit mode without
>> page tables or even into 16bit mode on such a system.  Or if such a
>> system will always require using page tables.
>
> Unless I'm mistaken, wouldn't that put a pretty heavy restriction on
> where the kdump kernel could be located?

If you are coming from 64bit EFI it adds restrictions.

Most of my experience involves systems using a real mode BIOS and
folks thought I was strange for wanting to be able to load the kernel
above 4GB.

Having that experience, I am stuck wondering how all of the weird
backwards compatibility cases are going to work. Hmm.

There is one concrete case where it matters that I think still exists.

x86_64 processors startup in 16bit real mode, then have to transition
through 32bit protected mode, before transitioning to 64bit protected
mode.  Only in 64bit protected mode are page tables enabled.

All this happens during early kernel startup when the bootstrap
processor sends STARTUP IPIs to all of the secondary processors.

The startup IPI lets you pick where in the first 1MiB the secondary
processors will start.

Assuming there isn't a new processor startup sequence on your cpus
speculation before the processor loads it's first page table is a
legitimate concern.

> Or the target region for KASLR?

As I recall the kernel is limited to the last 2GB of the virtual
address space, as parts of the instruction 

>> If you don't have enough MTRRs on a big NUMA system I think it is
>> perfectly understandable, to need to use the page tables.
>> 
>> Please include this the fact that splitting GBpages is necessary because
>> of a lack of MTRRs in the change description.
>
> OK.
>
>> Given that it is the lack of MTRRs on a large NUMA system that make the
>> change necessary.   The goes from a pure bug fix change to a change to
>> accommodate systems without enough MTRRs.
>> 
>> That information makes it more understandable why older systems (at
>> least in the case of kexec) might not be ok with the change.  As for
>> older systems their MTRRs are sufficient and thus they can use fewer
>> page table entries.  Allowing for use of larger TLB entries.
>
> That last paragraph doesn't match what I think is happening.
>
> At least from my point of view, that some systems aren't OK with the
> change has nothing to do with MTRRs or TLB page size.  They simply
> require the extra "slop" of GB pages, implicitly adding a full GB of
> space around any smaller space requested by map_acpi_tables().
>
> The systems that failed with my original change also failed on earlier
> kernels when nogbpages was added to the kernel command line.  That
> creates the identity map using 2M pages for everything, with no GB
> page "slop".   I'm pretty sure these systems will continue to fail with
> "nogbpages" enabled.
>
> For one debug-kernel cycle on Pavin's system I added in hard-coded
> requests to explicitly add back in the areas that not being sloppy had
> excluded, and that brought kexec back to functioning; which further
> proves my point.  
>
> I wanted to be sure you understood this in case it has any effect on
> what you think should be done.

Sort of.

What kexec wants of an identity mapped page table really is to simulate
disabling paging altogether.  There isn't enough memory in most systems
to identity map the entire 48bit or 52bit physical address space so some
compromises have to be made.  I seem to recall only mapping up to
maxpfn, and using 1GB pages when I originally wrote the code.  It was
later refactored to share the identity map page table building code with
the rest of the kernel.

When you changed the page tables not to map everything, strictly
speaking you created an ABI break of the kexec ABI.

Which is a long way of saying it isn't being sloppy it is deliberate,
and that the problem from my perspective is that things have become too
fine grained, too optimized.

Pavin's definitely proves the issue was not mapping enough pages, it is
nice that we have that confirmation.

From my perspective the entire reason for wanting to be fine grained and
precise in the kernel memory map is because the UV systems don't have
enough MTRRs.  So you have to depend upon the cache-ability attributes
for specific addresses of memory coming from the page tables instead of
from the MTRRs.

If you had enough MTRRs more defining the page tables to be precisely
what is necessary would be simply an exercise in reducing kernel
performance, because it is more efficient in both page table size, and
in TLB usage to use 1GB pages instead of whatever smaller pages you have
to use for oddball regions.

For systems without enough MTRRs the small performance hit in paging
performance is the necessary trade off.

At least that is my perspective.  Does that make sense?

Eric

