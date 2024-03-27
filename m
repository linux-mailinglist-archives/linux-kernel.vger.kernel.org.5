Return-Path: <linux-kernel+bounces-121543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995B588EA80
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB25B31E89
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70E413CC63;
	Wed, 27 Mar 2024 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="PvRe4boi"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E713777A;
	Wed, 27 Mar 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553715; cv=none; b=E4CDLkbZMg5p7EVu1uoWBRx6n2f4uZ1rzCkkNXiSSMeajL68ddozJVc7XrLfHxgorQSMcRmpveHMA3oRPsVtE6gITec01ACoHNNcWLeGd5sk5QhjFh3QLG3WydOgEQK4aCZAJMv1yRXzON3DaZOkVPEVkKa9f6n7bDjVpxVKVSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553715; c=relaxed/simple;
	bh=3dGKXadnvUzzFxKE9M8CbOWXoP1h+Vaqd44OvUDZdaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECQ4b2x8jstzODKas2x6w+/Zj0vRcDITIfL057DdicHyFJvL/N5lTZ8RV4RI4F6JR48ifhPJlO8S82aiQvayxhskzYKKMjDIBuqIjd30HqYcTnv3U2JmB6ZpN+XW56jirXxwVtz6Glx180DUmHU1qjOI+6qL7LNryQAz66mPbas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=PvRe4boi; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42REeGd6013349;
	Wed, 27 Mar 2024 15:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=HP/lAbwJJi4uuj4vGtzb1Gyy0HMSeSMy8EHwIc6WHJ0=;
 b=PvRe4boiY81wL4J0eRAsH5zeZMIEjCCWyW6c32sXB4+S2RpgJTCvnaPw77VFqNqK4yTb
 xXpKTDezZh2btM5dE/+ZOWDDl/F1Xu07TGrVgrnw7UnRuZrOXDf3dswmIMaan78dy++b
 f30zWXJfX3fHkWDb/9pQLU7r0JqrX/NP6+wvsbaGhfnRbzP5RAE1isTeK3ZqTTiTyrhE
 Q3HggkVIP3fqvt7w6jovmySTEJkcvUx5mTZcXyTPhYSr84twqpMsa7LUf9QDiqK17OHm
 Wyz0PF0+p4GYP7/hl0xZJomttQqDzDDt4BR7NfefO1yTOj07e+/L/PgoTRkGOp15jAZk xg== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3x4jtta1f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 15:33:35 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 45ED0295C2;
	Wed, 27 Mar 2024 15:33:34 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 8943180851C;
	Wed, 27 Mar 2024 15:33:22 +0000 (UTC)
Date: Wed, 27 Mar 2024 10:33:20 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Russ Anderson <rja@hpe.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Pavin Joseph <me@pavinjoseph.com>, stable@vger.kernel.org,
        Eric Hagberg <ehagberg@gmail.com>, Simon Horman <horms@verge.net.au>,
        Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
        Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
Message-ID: <ZgQ8Ej-MLlNJR6wn@swahl-home.5wahls.com>
References: <20240322162135.3984233-1-steve.wahl@hpe.com>
 <ZgABC1oQ9YJW6Bw3@gmail.com>
 <20240325020334.GA10309@hpe.com>
 <87o7b273p2.fsf@email.froward.int.ebiederm.org>
 <ZgHTXvCQr6ycbVzp@swahl-home.5wahls.com>
 <87r0fv6ddb.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0fv6ddb.fsf@email.froward.int.ebiederm.org>
X-Proofpoint-GUID: 6jR5NrVJvBQoLKa05dSFACb5VGeJ02fX
X-Proofpoint-ORIG-GUID: 6jR5NrVJvBQoLKa05dSFACb5VGeJ02fX
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_11,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403270106

On Wed, Mar 27, 2024 at 07:57:52AM -0500, Eric W. Biederman wrote:
> Steve Wahl <steve.wahl@hpe.com> writes:
> 
> > On Mon, Mar 25, 2024 at 10:04:41AM -0500, Eric W. Biederman wrote:
> >> Russ Anderson <rja@hpe.com> writes:
> >> > Steve can certainly merge his two patches and resubmit, to replace the
> >> > reverted original patch.  He should be on in the morning to speak for
> >> > himself.
> >> 
> >> I am going to push back and suggest that this is perhaps a bug in the
> >> HPE UV systems firmware not setting up the cpus memory type range
> >> registers correctly.
> >> 
> >> Unless those systems are using new fangled cpus that don't have 16bit
> >> and 32bit support, and don't implement memory type range registers,
> >> I don't see how something that only affects HPE UV systems could be
> >> anything except an HPE UV specific bug.
> >
> > Eric,
> >
> > I took the time to communicate with others in the company who know
> > this stuff better than I do before replying on this.
> >
> > One of the problems with using the MTRRs for this is that there are
> > simply not enough of them.  The MTRRs size/alignment requirements mean
> > that more than one entry would be required per reserved region, and we
> > need one reserved region per socket on systems that currently can go
> > up to 32 sockets.  (In case you would think to ask, the reserved
> > regions also cannot be made contiguous.)
> >
> > So MTRRs will not work to keep speculation out of our reserved memory
> > regions.
> >
> > Let me know if you need more information from us on this.
> 
> Thanks for this.
> 
> Do you know if there are enough MTRRs for the first 4GB?

I don't personally know all the details of how BIOS chooses to place
things, but I suspect that might be true.  The restricted spaces
usually end up at the end of the address range for a particular node,
and 4GB would be in the early part of node 0.  If the conversation
develops further along these lines, I can find out more definitively.

> I am curious if kexec should even consider going into 32bit mode without
> page tables or even into 16bit mode on such a system.  Or if such a
> system will always require using page tables.

Unless I'm mistaken, wouldn't that put a pretty heavy restriction on
where the kdump kernel could be located?  Or the target region for
KASLR?  

> If you don't have enough MTRRs on a big NUMA system I think it is
> perfectly understandable, to need to use the page tables.
> 
> Please include this the fact that splitting GBpages is necessary because
> of a lack of MTRRs in the change description.

OK.

> Given that it is the lack of MTRRs on a large NUMA system that make the
> change necessary.   The goes from a pure bug fix change to a change to
> accommodate systems without enough MTRRs.
> 
> That information makes it more understandable why older systems (at
> least in the case of kexec) might not be ok with the change.  As for
> older systems their MTRRs are sufficient and thus they can use fewer
> page table entries.  Allowing for use of larger TLB entries.

That last paragraph doesn't match what I think is happening.

At least from my point of view, that some systems aren't OK with the
change has nothing to do with MTRRs or TLB page size.  They simply
require the extra "slop" of GB pages, implicitly adding a full GB of
space around any smaller space requested by map_acpi_tables().

The systems that failed with my original change also failed on earlier
kernels when nogbpages was added to the kernel command line.  That
creates the identity map using 2M pages for everything, with no GB
page "slop".   I'm pretty sure these systems will continue to fail with
"nogbpages" enabled.

For one debug-kernel cycle on Pavin's system I added in hard-coded
requests to explicitly add back in the areas that not being sloppy had
excluded, and that brought kexec back to functioning; which further
proves my point.  

I wanted to be sure you understood this in case it has any effect on
what you think should be done.

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

