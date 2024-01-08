Return-Path: <linux-kernel+bounces-20035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE87E827877
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71DE1C21556
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B9C55794;
	Mon,  8 Jan 2024 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="UcuRE8b/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E7055C11
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id MuM0rnqW4oMN9MvBorreTt; Mon, 08 Jan 2024 19:21:36 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id MvBorBURFyxR5MvBorECh3; Mon, 08 Jan 2024 19:21:36 +0000
X-Authority-Analysis: v=2.4 cv=JYOvEGGV c=1 sm=1 tr=0 ts=659c4b40
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GfQleyYEO+cc22AUyTT7qQ==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=4RBUngkUAAAA:8
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=xBSaC5TXKjcKYkrMF84A:9
 a=QEXdDO2ut3YA:10 a=_sbA2Q-Kp09kWB8D3iXc:22 a=AjGcO6oz07-iQ99wixmX:22
 a=cvBusfyB2V15izCimMoJ:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rxv1zyBPmROyH3ODikrSiXesbgEjrba4VMOwSjsq8Bs=; b=UcuRE8b/Z8LikqSXkz82gnemfo
	5s0zrEyCNtKTDjk6HHrqCtfDwBPPlrdxtnwO21fRoyfMO8z+THBoyTPbOBjbuDEtlaVbu1P7DC6D7
	PcBPVl0ER3Osiw2Enn6lqQC+3NhDSMMyRFWFyjRCvM1K6ovQdchituyy86QeUQ6awQn6Tkp/6oXyz
	CklilmjSS+JJYzvyyR0yRsmyJwHbq2LqnQx0Sthz8QQpggBcobS/75iJzybv+JAeUttaDhSufLhE0
	iyE2ZNVnk2tfYejn9JUJ9Q4Ohj63go4LPd/qqq3tZT9k4X7relp63HU//hpuhzzVgCK/6qgee2H2O
	5ehjGSag==;
Received: from 187.184.157.186.cable.dyn.cableonline.com.mx ([187.184.157.186]:32462 helo=[192.168.0.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rMvBm-000aMY-0G;
	Mon, 08 Jan 2024 13:21:34 -0600
Message-ID: <7be0e5cc-058e-474e-bca9-f1c5b9a5f507@embeddedor.com>
Date: Mon, 8 Jan 2024 13:21:30 -0600
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
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 linux-hardening@vger.kernel.org, keescook@chromium.org, error27@gmail.com,
 gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
 Vishnu Dasa <vdasa@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, vegard.nossum@oracle.com,
 darren.kenny@oracle.com, syzkaller <syzkaller@googlegroups.com>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
 <fc132bde-d42d-4aac-ba91-7a939a18091a@moroto.mountain>
 <7826922a-d642-424e-bede-bfc45be9254d@embeddedor.com>
 <8023e9f4-c14b-453a-8071-ef94bba0d0d3@moroto.mountain>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <8023e9f4-c14b-453a-8071-ef94bba0d0d3@moroto.mountain>
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
X-Exim-ID: 1rMvBm-000aMY-0G
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.157.186]:32462
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIXnlu80mlNMk2Tb6Cd2rmVFiFcIBCB1tuWPwCCwf40GPYyBwJTY2vxnfFWKfFCuLvm8QL4CVWiaI0DEeIZpgBYnlPL6Kj+/w4aYEYOAePF2D1RNQ0sB
 S42s9Za2Pha2SLV1Hsjf/VPPlCKkMKnJWqf4oCGd/8Xk5hIX4fbSI9pKnMgNibPyZufA3WSJqz+Ak9rKaYLQ2mA7HP1ePlm9hvM8xqIlNDi93z4muLKNR2Y1



On 1/8/24 12:36, Dan Carpenter wrote:
> On Mon, Jan 08, 2024 at 11:03:51AM -0600, Gustavo A. R. Silva wrote:
>>
>>
>> On 1/8/24 01:33, Dan Carpenter wrote:
>>> On Fri, Jan 05, 2024 at 08:40:00AM -0800, Harshit Mogalapalli wrote:
>>>> Syzkaller hit 'WARNING in dg_dispatch_as_host' bug.
>>>>
>>>> memcpy: detected field-spanning write (size 56) of single field "&dg_info->msg"
>>>> at drivers/misc/vmw_vmci/vmci_datagram.c:237 (size 24)
>>>>
>>>> WARNING: CPU: 0 PID: 1555 at drivers/misc/vmw_vmci/vmci_datagram.c:237
>>>> dg_dispatch_as_host+0x88e/0xa60 drivers/misc/vmw_vmci/vmci_datagram.c:237
>>>>
>>>> Some code commentry, based on my understanding:
>>>>
>>>> 544 #define VMCI_DG_SIZE(_dg) (VMCI_DG_HEADERSIZE + (size_t)(_dg)->payload_size)
>>>> /// This is 24 + payload_size
>>>>
>>>> memcpy(&dg_info->msg, dg, dg_size);
>>>> 	Destination = dg_info->msg ---> this is a 24 byte
>>>> 					structure(struct vmci_datagram)
>>>> 	Source = dg --> this is a 24 byte structure (struct vmci_datagram)
>>>> 	Size = dg_size = 24 + payload_size
>>>>
>>>> {payload_size = 56-24 =32} -- Syzkaller managed to set payload_size to 32.
>>>>
>>>>    35 struct delayed_datagram_info {
>>>>    36         struct datagram_entry *entry;
>>>>    37         struct work_struct work;
>>>>    38         bool in_dg_host_queue;
>>>>    39         /* msg and msg_payload must be together. */
>>>>    40         struct vmci_datagram msg;
>>>>    41         u8 msg_payload[];
>>>>    42 };
>>>>
>>>> So those extra bytes of payload are copied into msg_payload[], a run time
>>>> warning is seen while fuzzing with Syzkaller.
>>>>
>>>> One possible way to fix the warning is to split the memcpy() into
>>>> two parts -- one -- direct assignment of msg and second taking care of payload.
>>>>
>>>> Gustavo quoted:
>>>> "Under FORTIFY_SOURCE we should not copy data across multiple members
>>>> in a structure."
>>>>
>>>> Reported-by: syzkaller <syzkaller@googlegroups.com>
>>>> Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
>>>> Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>>>> ---
>>>> This patch is only tested with the C reproducer, not any testing
>>>> specific to driver is done.
>>>>
>>>> v1->v2: ( Suggestions from Gustavo )
>>>>           1. Change the commit message false positive --> legitimate
>>>>              warning.
>>>
>>> The commit message is fine.
>>>
>>> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
>>>
>>> But, I mean, it's not really "legitimate".  It meets the fortify source
>>> heuristic, but it's still a false positive.  Fortify source is
>>> *supposed* to find memory corruption bugs and this is not a memory
>>> corruption bug.  It's just that these days we have to treat foritify
>>> false positives as crashing bugs because people enable it and we have to
>>> fix it.
>>>
>>> Let's not pretend that fortify has helped us in this situation, it has
>>> caused us a problem.  It has taken valid code and created a crashing
>>> bug.  I'm not saying that the cost isn't worth it, but let's not pretend.
>>>
>>
>> It's a "legitimate warning" (which differs from a "legitimate memory
>> corruption bug") in the sense that the feature is doing what it's
>> supposed to do: reporting a write beyond the boundaries of a field/member
>> in a structure.
>>
>> Is that simple.  I don't see the "pretense" here.
>>
>> BTW, is this _warning_ really causing a crash?
> 
> I don't know how many people have Reboot on Warn enabled but I've heard
> it's a shocking high number of people.
> 
> My problem with "legitimate" is that it's a biased word which imples
> "good".  A more neutral way to describe it would be "acceptable" or
> "matches the heuristic".
> 
> Generally, we get a lot of patches which are to make a tool happy and
> sometimes like here it's probably an acceptable cost.  But I think
> other times people lose sight of what it's all about and confuse good
> and bad.  In some kind of very literal and narrow sense this warning is
> bad.  It takes perfectly okay code and turns it into a crashing bug.  In
> the larger sense and long term view then, sure, the heuristic is useful,
> but right here, in this situation, it's bad.


This is right on point:

"In some kind of very literal and narrow sense this warning is bad."

Let's say the vast majority of people is of this opinion. Thus, they
engage in never-ending discussions, and end up disregarding this sort
of warning, deciding to ignore it completely. Then, a lot more of these
warnings go unfixed. Then, a couple of actual memory corruption bugs
are introduced. Then, people don't notice them. Then, the hardening
feature ends up becoming useless.

Why insist on disregarding something that is clearly beneficial to
acknowledge and worth correcting right on the spot?

This is real work that must be done if we want the feature to help us
detect bugs and potential vulnerabilities.

Thanks
--
Gustavo

