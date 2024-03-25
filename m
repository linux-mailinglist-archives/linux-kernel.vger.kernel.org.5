Return-Path: <linux-kernel+bounces-117792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAC088B2DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD2B5B60FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C76A14A9D;
	Mon, 25 Mar 2024 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="ezkCU3ng"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199F01B969;
	Mon, 25 Mar 2024 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394180; cv=none; b=jB0JxxoSxlHKxksYx+UIUZpej4Uk+WPCQYJWJ0vWHgEDNIQ0vCzxZyg0Bqe6BmClOzIFJSa74GgF5Nv1FXeAzET+8Dx1tVOtnDlgYHBvJWboC7uOmsrY3XLVxMXH4V63YcfBnjvUWzaGXVQeG3AMICfbTSXqi0uHl0YFmL0eFMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394180; c=relaxed/simple;
	bh=FBaCIU/QKc8O+jfVz9mAPjwwXcmEgyAfdz0ZkQYLWtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZ5a5sOFlY3J7DjpXD2xbKwT8RJTSVEg5Z0Hho7u/OCSkTz9/JpSzb2v7ToFs0k68gl6lmgt6EpLKUejMQm0WXGlvdlS9wGcoI9XqBP2khQqDvKwGs4FipTi3oAorgFtMwftYRdhNy3jcHAVRHlHbn55exDqcpbhIwx+8wnhbE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=ezkCU3ng; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PIKWEu028215;
	Mon, 25 Mar 2024 19:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=HsQQaVfK6Od0VFK+iLeSTloVRjxn4J5cRsMR9GNjL5Q=;
 b=ezkCU3ngbQ9G2X2YqGUN7zk/YPzed/Sukghzz0rB5wnK9vb0kgsQG188wdzRPG3fLUKK
 4Vml6FKsYgnL4lw+SsxKCGf+pX2+u2rNlwd+pO85fB7gVMI43Wb4DG9H+7T/HFPfxstT
 eayEVc7nzsDryTHuWb5hSUx7qdkF7QZwpc+NCkwdLDiD6Y2yEn5R2rl3TnxoAZWdsgnK
 7D5hwBt91E75/p3sX5hEK8xNgd7MLD5m1ZXNvGfRbdJzDdX4HyXjflbfSxL+N36SxVel
 PPbhmkUYKmt/mkWVBhCnwM8IfhM71ZhBFCBPOplDIUj2cOOj5g8hBlirmNDQ0svFQAFh Jg== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3x36k1vr67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 19:15:35 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 3C4C2805EBA;
	Mon, 25 Mar 2024 19:15:34 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id F0F9D80163C;
	Mon, 25 Mar 2024 19:15:29 +0000 (UTC)
Date: Mon, 25 Mar 2024 14:15:27 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Pavin Joseph <me@pavinjoseph.com>, stable@vger.kernel.org,
        Eric Hagberg <ehagberg@gmail.com>, Simon Horman <horms@verge.net.au>,
        Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>,
        Sarah Brofeldt <srhb@dbc.dk>, Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
Message-ID: <ZgHNT1bYV8KNRr1G@swahl-home.5wahls.com>
References: <20240322162135.3984233-1-steve.wahl@hpe.com>
 <8cc9e238-fa70-402f-9990-f7e391b367a9@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cc9e238-fa70-402f-9990-f7e391b367a9@intel.com>
X-Proofpoint-ORIG-GUID: 1J9A2RlA4nbSnn1VN6TCvYxRifonpGVY
X-Proofpoint-GUID: 1J9A2RlA4nbSnn1VN6TCvYxRifonpGVY
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_18,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250115

I understand the original has been reverted, and that my way forward
is likely to combine the original patch and the fix into a combined
patch (possibly a set).  I still think some of this conversation will
be valuable to creation of that patch, so continuing to reply.  More
below.

On Fri, Mar 22, 2024 at 04:29:27PM -0700, Dave Hansen wrote:
> On 3/22/24 09:21, Steve Wahl wrote:
> > Some systems have ACPI tables that don't include everything that needs
> > to be mapped for a successful kexec.  These systems rely on identity
> > maps that include the full gigabyte surrounding any smaller region
> > requested for kexec success.  Without this, they fail to kexec and end
> > up doing a full firmware reboot.
> 
> I'm still missing something here.  Which ACPI tables are we talking
> about?  What don't they map?  I normally don't think of ACPI _tables_ as
> "mapping" things.

I'm refering to the memory areas that are mapped in machine_kexec_64.c
in the function map_acpi_tables.  These appear to be e820 table
entries that have a type of E820_TYPE_ACPI which the kernel marks as
IORES_DESC_ACPI_TABLES, or a type of E820_TYPE_NVS that the kernel
marks as IORES_DESC_ACPI_NV_STORAGE.

The name of the function that maps them is why I refer to them as ACPI
tables.  Sorry if that is inaccurate.

> It seems like there's a theory that some ACPI table isn't mapped, but
> looking through the discussion so far I don't see a smoking gun.

I think I'm saying more that the ACPI table doesn't list everything
that needs to be mapped, not that the table itself isn't mapped.  Not
sure if that changes your picture or not.

My debuging exchanges with Pavin showed that the regions mapped within
the map_acpi_tables function were the ones that left uncovered holes
in the identity map if you don't overshoot what's requested by using
full gbpages for everything.

For his system only, I manually added hardcoded regions corresponding
to the holes that got left by using 2M pages instead of GB pages, and
kexec succeeded.

Having the list of holes-not-covered (IIRC, four of them), I could
have persued which particular holes cause kexec to fail, but I did not
because I couldn't think of a way to make use of that information.
Even knowing which additional addresses need coverage for this
particular machine, I have no way of knowing what is in those regions,
nor how to generalize to what is needed on other machines.

> Let's say the kernel has a bug and the kernel was actively not
> mapping something that it should have mapped.  The oversized 1GB
> mappings made the bug harder to hit.  If that's the case, we'll just
> be adding a hack which papers over the bug instead of fixing it
> properly.

I hope you agree that by reverting, we have now papered over that bug,
just in a different way.

If a patch that leaves this papered over except for UV systems won't
be acceptable -- that's what I intend to do, just combining my two
patches -- please let me know what my way forward should be.

> I'm kind of leaning to say that we should just revert d794734c9bbf and
> have the UV folks go back to the nogbpages until we get this properly
> sorted.

Being larger memory systems (for example, 32 socket Sapphire Rapids
systems with a full set of RAM on each socket), UV probably suffers
the most from having an extra 4K per GiB to create the identity map.

> > @@ -10,6 +10,7 @@ struct x86_mapping_info {
> >  	unsigned long page_flag;	 /* page flag for PMD or PUD entry */
> >  	unsigned long offset;		 /* ident mapping offset */
> >  	bool direct_gbpages;		 /* PUD level 1GB page support */
> > +	bool direct_gbpages_always;	 /* use 1GB pages exclusively */
> >  	unsigned long kernpg_flag;	 /* kernel pagetable flag override */
> >  };
> 
> But let's at least talk about this patch in case we decide to go forward
> with it.  We've really got two things:
> 
> 1. Can the system use gbpages in the first place?
> 2. Do the gbpages need to be exact (UV) or sloppy (everything else)?
> 
> I wouldn't refer to this at all as "always" use gbpages.  It's really a
> be-sloppy-and-paper-over-bugs mode.  They might be kernel bugs or
> firmware bugs, but they're bugs _somewhere_ right?

Do you have a concise suggestion of what you'd call it?  I could use
*_sloppy if you'd like, but I don't care much for the way that
reads.

Thanks for your time,

--> Steve Wahl
-- 
Steve Wahl, Hewlett Packard Enterprise

