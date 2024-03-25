Return-Path: <linux-kernel+bounces-116395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5299A889A52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757A51C33011
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF59413EFF3;
	Mon, 25 Mar 2024 05:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="PxbrELzz"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0319141997;
	Mon, 25 Mar 2024 02:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332415; cv=none; b=juNYLh7N+0r7jqn7Tx4HV0ohr44Ktx1kB0maVowF+oh+qn/v67qgrc2KFEajeM/wdNbxAqJ7A5VlUHHufnmiM/mdvcK2p3Btc/bv2ZGxAdbS1Km8JtdhTOH0MWns0ny1iqUHZKck1GeHyhsl3sHyhe8XDSLvjz/PMZAG6X0bdfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332415; c=relaxed/simple;
	bh=th+lOl8TaguURs7T4/qevNJns4c251FfNsGSkCJOYCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SKSnqvKpmd2WphB35xhJxMyfCZCBd6UBeSgfZc8OcLPAej9CROlxWH0otMnR/5oMZAmdT+GE6i6NWJ3L6VtCNJ3psO3Gt9LFUYJ4hgT1zM91iB605BsxN2Av3l7tmiyLM1QMMQ0ewXNmw2f/xkQD28P99ne379aYiVihyDJSavQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=PxbrELzz; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42P1WPnj029411;
	Mon, 25 Mar 2024 02:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : content-type : in-reply-to
 : mime-version; s=pps0720;
 bh=dxof5wf3hIra4YnNU29jynn3K8tspUO9+ofjFnVhJ5I=;
 b=PxbrELzzeWv6d8P8+veX1uY4xFJMBZruTXQf/CdNJVNOsrMIbwn77mIMdxNGwG9fzH1r
 Mo/b72iMhvQuY0gx6LtqpdlZIEaxnGqUr69bqJ/Tlfhk7ZduKw5fQJtgVs0rAvFH3GZ7
 rthx+bY8U+TNSKgBqyV8tMOhMcHW4J/ibfDiUUgQe1haXK1FGyssLoWu1tPH/KxT5Nlj
 XxOHp6Y/dxlPGLh69TlsJsZI/maf+imlhB8zmY8eRbR756IsjXwojLt/98e9U/pJ1q65
 wV1t326RyhyHm027t1FiYXm2468KT2PZaBLCX2YlJdcclJg0ubLO17UGA4JOaS8KgDVO dw== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3x1nrhc41k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 02:03:52 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id ADD96800349;
	Mon, 25 Mar 2024 02:03:41 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id BF9F2800EFE;
	Mon, 25 Mar 2024 02:03:36 +0000 (UTC)
Date: Sun, 24 Mar 2024 21:03:34 -0500
From: Russ Anderson <rja@hpe.com>
To: Ingo Molnar <mingo@kernel.org>
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
        Sarah Brofeldt <srhb@dbc.dk>, Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
Message-ID: <20240325020334.GA10309@hpe.com>
Reply-To: Russ Anderson <rja@hpe.com>
References: <20240322162135.3984233-1-steve.wahl@hpe.com>
 <ZgABC1oQ9YJW6Bw3@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgABC1oQ9YJW6Bw3@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-GUID: cE3LkNmzgzy5T9RG2lGAzoCUF_seZTCo
X-Proofpoint-ORIG-GUID: cE3LkNmzgzy5T9RG2lGAzoCUF_seZTCo
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
 definitions=2024-03-24_18,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250010

On Sun, Mar 24, 2024 at 11:31:39AM +0100, Ingo Molnar wrote:
> 
> * Steve Wahl <steve.wahl@hpe.com> wrote:
> 
> > Some systems have ACPI tables that don't include everything that needs
> > to be mapped for a successful kexec.  These systems rely on identity
> > maps that include the full gigabyte surrounding any smaller region
> > requested for kexec success.  Without this, they fail to kexec and end
> > up doing a full firmware reboot.
> > 
> > So, reduce the use of GB pages only on systems where this is known to
> > be necessary (specifically, UV systems).
> > 
> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > Fixes: d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")
> > Reported-by: Pavin Joseph <me@pavinjoseph.com>
> 
> Sigh, why was d794734c9bbf marked for a -stable backport? The commit 
> never explains ...

I will try to explain, since Steve is offline.  That commit fixes a
legitimate bug where more address range is mapped (1G) than the
requested address range.  The fix avoids the issue of cpu speculativly
loading beyond the requested range, which inludes specutalive loads
from reserved memory.  That is why it was marked for -stable.

> If it's broken, it should be reverted - instead of trying to partially 
> revert and then maybe break some other systems.

Three people reported that mapping only the correct address range
caused problems on their platforms.  https://lore.kernel.org/all/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/
Steve and several people helped debug the issue.  The commit itself
looks correct but the correct behavior causes some side effect on
a few platforms.  Some memory ends up not being mapped, but it is not
clear if it is due to some other bug, such as bios not accurately
providing the right memory map or some other kernel code path did
not map what it should.  The 1G mapping covers up that type issue.

Steve's second patch was to not break those platforms while leaving the
fix on the platform detected the original mapping problem (UV platform).

> When there's boot breakage with new patches, we back out the bad patch 
> and re-try in 99.9% of the cases.

Steve can certainly merge his two patches and resubmit, to replace the
reverted original patch.  He should be on in the morning to speak for
himself.

Thanks
-- 
Russ Anderson,  SuperDome Flex Linux Kernel Group Manager
HPE - Hewlett Packard Enterprise (formerly SGI)  rja@hpe.com

