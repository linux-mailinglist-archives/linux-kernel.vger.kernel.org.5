Return-Path: <linux-kernel+bounces-21000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 818E082884E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363441F250A3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4DF39ACD;
	Tue,  9 Jan 2024 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="oSmz2Qe5"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C73B39AC4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id N9L4rX9kAMVQiNDCnroyvI; Tue, 09 Jan 2024 14:35:49 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id NDCmryb0k55BJNDCnrOUuO; Tue, 09 Jan 2024 14:35:49 +0000
X-Authority-Analysis: v=2.4 cv=QcR1A+Xv c=1 sm=1 tr=0 ts=659d59c5
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GfQleyYEO+cc22AUyTT7qQ==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10
 a=4tGuUO7FMUkCr9MuFAcA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KXjAbIiafMI8Sanzb/fkeo5iWhzB478LPXEZMnXq5CM=; b=oSmz2Qe543rszavCY24Ct54hWb
	c9v8pNeI4L5wGjtmRB1MjccXK4NWwZpkc2w5xVm7kA7ugstm8F9pg3cMN5X+Ki+YCWj1+Jp3u9m/d
	gcEg0SvpgEaNCAeeTKRTrptzXQef4AZaEnssiNhtqC4hA6wXX6ZAFM34Ce5R7BvMMl8Y+fIfiaufw
	ErSwCmVM9YJQgXFvG/SD4W3Wri/kAbNGc2P5xpABlTQWs1wVltT1JeEOv3AINgsHXThO4Hm7NfR70
	ebBpc2N1oNrqK+LudgQ4t1RS1en5k2SlePxkbPzZ2bnfGelqFWk0KlKBTb7p4yYdppy3jqNSYi2AT
	S/CjoVmw==;
Received: from 187.184.157.186.cable.dyn.cableonline.com.mx ([187.184.157.186]:58650 helo=[192.168.0.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rNDCk-000iaD-1s;
	Tue, 09 Jan 2024 08:35:47 -0600
Message-ID: <4603630c-3bb2-42b6-b0dd-79d500460ab4@embeddedor.com>
Date: Tue, 9 Jan 2024 08:35:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] VMCI: Fix memcpy() run-time warning in
 dg_dispatch_as_host()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Kees Cook <keescook@chromium.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 linux-hardening@vger.kernel.org, error27@gmail.com, gustavoars@kernel.org,
 Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, vegard.nossum@oracle.com,
 darren.kenny@oracle.com, syzkaller <syzkaller@googlegroups.com>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
 <202401081430.9DAB37B46@keescook>
 <9c742547-0021-464b-b7a8-7af46b0a4afa@embeddedor.com>
 <79ca2f85-1f8d-4a12-aa5a-09137033605f@moroto.mountain>
 <7d7b94ba-9a1f-44de-8491-dc4864338f80@embeddedor.com>
 <36aecc9a-ac30-436f-b42b-39f63513d743@moroto.mountain>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <36aecc9a-ac30-436f-b42b-39f63513d743@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.186
X-Source-L: No
X-Exim-ID: 1rNDCk-000iaD-1s
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.157.186]:58650
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP+CxLEurex02gmL574R++giqRpZenJw9Kj8uHaXbkG3RpaOD+gh6aw5niiPV+SUw5BdQKlonm8phSQfV0d4+7X+2vFuzeqrLpdgpN7Dzt5WUtqrbD0T
 4ObBkQEfhy+AaWHXsFGHV4Jr0mj/FuCkLiTpkQfzL/fPRxOGDJIgwqMETAos2eVGt4mwRp715Gloe8cIQU0Cz3A1k1IIqbMRymcu0Oi5mUaA3PO5zzv55DRL



On 1/9/24 07:22, Dan Carpenter wrote:
> On Tue, Jan 09, 2024 at 06:31:41AM -0600, Gustavo A. R. Silva wrote:
>>
>> You're arguing that fortify caused a problem.
> 
> Yes.
> 
> Before: Code working correctly
> After: Kernel Panic
> 
> At first, I started to question if I was going mad, but then I looked
> through the email thread and Harshit tested it and proved that the
> kernel does actually panic depending on the .config.
> 
> I mean realistically we should backport this patch to old kernels,
> right?  And if we had to assign a Fixes tag to this it would need to be
> the commit which adds Fortify to the kernel.  Prior to that commit the
> code was fine.
> 
> Again, I'm not saying that Fortify is bad overall.  Probably in DnD it
> would be Chaotic Good where it's overall good but sometimes a pain.
> 

You know what, I think the discrepancy here lies in the fact that, before,
fortify didn't complain about writes across multiple members in the same
struct, as long as we remained between the boundaries of the struct. This
was done via __builtin_object_size(p, 0).

In recent times, that has changed, and now fortify has been tightened to warn
about writes beyond the boundaries of a single object. This is now done via
__builtin_dynamic_object_size(p, 1)/__builtin_object_size(p, 1).

And, if this patch is to be backported, _technically_, the Fixes tag should
probably be assigned to that change from __bos(p, 0) to __bos(p, 1):

commit f68f2ff91512 ("fortify: Detect struct member overflows in memcpy() at compile-time")

In any case, fortify should now emit this sort of warning, and that adds
an extra layer of hardening to the kernel.

Thanks
--
Gustavo

