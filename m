Return-Path: <linux-kernel+bounces-111913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74098887290
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B346289D93
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277AF61696;
	Fri, 22 Mar 2024 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="i+Amu9mE"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD5760DDB;
	Fri, 22 Mar 2024 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130796; cv=none; b=ITawJBw4ofuM6KvHFCdWwuwyvS5EY0Z3iLvtmBVsMHxsaLK57aRtU1us/maFOQhIMSk+cy8mqObP4Xbcf9o67Jcw/N3AYa6cvg58xyzL5EzUEAUrAbN8Lqi4FCxrjnVf8fojxjQcY6TGbEw2rC77sFG1uLT2V/aOY1T/IZRMNtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130796; c=relaxed/simple;
	bh=m4EymJAcRXCFACL2i+rx3ZT9mEivNMdVXbX+DVFJh0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xx0yEaX8p4U10cmASZX/cnROipzoxYwBON7GZDKhcdQQ1xg21Xppt+iSU+TdHnske7ma6WljmgPvG9JjmrxZrEQmsA1279gIq2r9xKP+HPksGq3I4S3T6b5bPBInlfDdp5jMXl4IqoiSsiQiguXabrEs+gTX7NqQg2KrMXwN7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=i+Amu9mE; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42MF3ICi017502;
	Fri, 22 Mar 2024 18:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=IK/kIsHjXxasetLiveufgrhf6dqiTyTmYvGcseMR5vs=;
 b=i+Amu9mEsOh1MtV1apf/d33V1Gkn8viRK2c3KlHJNlh5JHW3ut/PuWP1ihoi5UiXwOQK
 3NfAGeW60E6a4ZF3MntgghCU+UATG/LevkEQX6hJ4o9rKZy29AypDLyiEfRW1dn306co
 JYDnWO6V5opdC/aJW9qJjzvH4ktqoKvARoKT5WXBlzp7Hy5Ak1gTlSUzwSYyiN+5CkvN
 ZYiOwxQH8nJjvemJQFJVSDWm+QtDXUJl5MlMhLNVjmDBpD7M1mEvesYusNhaSLsZPnrF
 jvP7sw3KlPU+Hsel+4/RN7tqSoND6AaM0+nBLWRJy5/bjai7lPnoXIu38Gn+sxulloWL Ag== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3x0wy88mgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 18:05:42 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 93943804DE1;
	Fri, 22 Mar 2024 18:05:41 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 1B94B80A3E5;
	Fri, 22 Mar 2024 18:05:36 +0000 (UTC)
Date: Fri, 22 Mar 2024 13:05:34 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Steve Wahl <steve.wahl@hpe.com>,
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
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
Message-ID: <Zf3Ibju7xTy_S0Rx@swahl-home.5wahls.com>
References: <20240322162135.3984233-1-steve.wahl@hpe.com>
 <003f1e83-fd93-4f4f-a316-d3e89e5a23a5@intel.com>
 <87le6ab2bn.fsf@email.froward.int.ebiederm.org>
 <2f8d726a-9800-4068-9c0c-6c4a79d69a85@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f8d726a-9800-4068-9c0c-6c4a79d69a85@intel.com>
X-Proofpoint-ORIG-GUID: sFebYI1E4bAOQKGP-DZ60C3kxFqZHSrR
X-Proofpoint-GUID: sFebYI1E4bAOQKGP-DZ60C3kxFqZHSrR
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_10,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=826 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403220130

On Fri, Mar 22, 2024 at 10:40:37AM -0700, Dave Hansen wrote:
> On 3/22/24 10:31, Eric W. Biederman wrote:
> >> I'd much rather add synthetic entries to the memory maps that have this
> >> information than hack around it by assuming that things are within a
> >> gigabyte.
> > So this change is a partial revert of a change that broke kexec in
> > existing configurations.  To fix a regression that breaks kexec.

Hi, Dave!

> Let's back up for a second:
> 
>  * Mapping extra memory on UV systems causes halts[1]
>  * Mapping extra memory on UV systems breaks kexec (this thread)

These are the same.  The most reliable way to create the problem[1] on
UV is a kexec to a kdump kernel, because of the typical placement of
the kdump kernel active region with respect to the reserved addresses
that cause the halts.  (The distros we typically run place the
crashkernel just below the highest reserved region, where a gbpage can
include both.)

What you didn't state here is the third bullet that this patch addresses.

* Neglecting to map extra memory on some (firmware buggy?) non-UV
  systems breaks kexec.

> So we're in a pickle.  I understand your concern for kexec.  But I'm
> concerned that fixing the kexec problem will re-expose us to the [1]
> problem.

> Steve, can you explain a bit why this patch doesn't re-expose the kernel
> to the [1] bug?
> 
> 1. https://lore.kernel.org/all/20240126164841.170866-1-steve.wahl@hpe.com/

This patch still has UV systems avoid gbpages that go far outside
actual requested regions, but allows the full gb pages on other
systems.  On UV systems, the new gbpage algorithm is followed.  On
non-UV systems, gbpages are allowed even for requests that don't cover
a complete gbpage -- essentially the former algorithm but using the
new code.

Hope that makes sense.

I would probably consider this buggy firmware, but got enough reports
of this regression (from Pavin Joseph, Eric Hagberg, and Sara
Brofeldt, all of whom tested the patch to see if it cured the
regression) that it seemd everyone would want it fixed quickly and
point fingers later.

In the private debugging exchanges with Pavin, I got some printks of
regions that were mapped, and did one exchange with hard-coded adding
regions not covered on his particular system back into the table;
there were four regions left out.  I added all four in one patch.  I
could have dived in further to diagnose which of the missing region(s)
were actually necessary to get kexec to succeed, but couldn't see what
I would do with that information once I had it, as I don't see a way
to generalize this to other platforms exhibiting the problem.

Thanks,

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

