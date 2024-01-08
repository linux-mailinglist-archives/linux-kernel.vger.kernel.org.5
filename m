Return-Path: <linux-kernel+bounces-19873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D578275FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91FC1C22618
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F8E53E2A;
	Mon,  8 Jan 2024 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="TK/BHEQB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26095472A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id MpkRrOOr18uLRMt2brNT9t; Mon, 08 Jan 2024 17:03:57 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Mt2arRdAWD6lhMt2arjUWB; Mon, 08 Jan 2024 17:03:57 +0000
X-Authority-Analysis: v=2.4 cv=LNR1/ba9 c=1 sm=1 tr=0 ts=659c2afd
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GfQleyYEO+cc22AUyTT7qQ==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=4RBUngkUAAAA:8
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=ZvJPU1clwQC8LSIsbNEA:9
 a=QEXdDO2ut3YA:10 a=_sbA2Q-Kp09kWB8D3iXc:22 a=AjGcO6oz07-iQ99wixmX:22
 a=cvBusfyB2V15izCimMoJ:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zVnMDgYqQIW31yhlq5X+5vjFVCRFGlx7qcSQZAIaikw=; b=TK/BHEQBl2MBSv1vTxi/fBTG6w
	5P6o+PbNfRxLqQrNMSF9Yn0LkA01bzddDvZcFe9XL4llxXTfRxNpqkqkyeQzZmUObGzTDFvEAnT7z
	VbxZtkYqOY1dCwlUgFar7Y7W+fwWUNhCr/rBYuNZfognJFTEFSCqwJXNeDYbzTMIbA+HxQ+k2nwR5
	kGkFm/d2R9t3tpVJqViO+yovW6PdS3YUuVUgn5bccLQKpCHdyfhJaWtHX6t3gvhDYPz4ew2Xw1lDa
	7L1GqRX9wLI6aMeCz0QJi4y6tBbqjNQ/YSh9KPTQGahoxX9ObnQAe7+pf4kzpr9Xrn9XWFVueez+s
	88YDv9jg==;
Received: from 187.184.157.186.cable.dyn.cableonline.com.mx ([187.184.157.186]:18340 helo=[192.168.0.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rMt2Y-002LqS-1z;
	Mon, 08 Jan 2024 11:03:54 -0600
Message-ID: <7826922a-d642-424e-bede-bfc45be9254d@embeddedor.com>
Date: Mon, 8 Jan 2024 11:03:51 -0600
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
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: linux-hardening@vger.kernel.org, keescook@chromium.org,
 error27@gmail.com, gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
 Vishnu Dasa <vdasa@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, vegard.nossum@oracle.com,
 darren.kenny@oracle.com, syzkaller <syzkaller@googlegroups.com>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
 <fc132bde-d42d-4aac-ba91-7a939a18091a@moroto.mountain>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <fc132bde-d42d-4aac-ba91-7a939a18091a@moroto.mountain>
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
X-Exim-ID: 1rMt2Y-002LqS-1z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.157.186]:18340
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPeKeb2K9nBa0qb0PRtnb7QcQY7EjvOllmlOBb5V/b6rgV8GvY37+NUnPD3ZA53FLN9cINJSG23BegxTHlf0w74VJQN+vviqNkY1PF7DjVV0c2KKjV/k
 yAaNMEkQz1GQ3ZssQqhMIu4QwbgqPuKopfFJnC+6S3DWlWyXgYOjN47mewtBMjMbtRNonz/ibYGYz1ZvLyDhjGyU6Rein/7ykRNPS9Uhv3mcOdPRbZJT9iUQ



On 1/8/24 01:33, Dan Carpenter wrote:
> On Fri, Jan 05, 2024 at 08:40:00AM -0800, Harshit Mogalapalli wrote:
>> Syzkaller hit 'WARNING in dg_dispatch_as_host' bug.
>>
>> memcpy: detected field-spanning write (size 56) of single field "&dg_info->msg"
>> at drivers/misc/vmw_vmci/vmci_datagram.c:237 (size 24)
>>
>> WARNING: CPU: 0 PID: 1555 at drivers/misc/vmw_vmci/vmci_datagram.c:237
>> dg_dispatch_as_host+0x88e/0xa60 drivers/misc/vmw_vmci/vmci_datagram.c:237
>>
>> Some code commentry, based on my understanding:
>>
>> 544 #define VMCI_DG_SIZE(_dg) (VMCI_DG_HEADERSIZE + (size_t)(_dg)->payload_size)
>> /// This is 24 + payload_size
>>
>> memcpy(&dg_info->msg, dg, dg_size);
>> 	Destination = dg_info->msg ---> this is a 24 byte
>> 					structure(struct vmci_datagram)
>> 	Source = dg --> this is a 24 byte structure (struct vmci_datagram)
>> 	Size = dg_size = 24 + payload_size
>>
>> {payload_size = 56-24 =32} -- Syzkaller managed to set payload_size to 32.
>>
>>   35 struct delayed_datagram_info {
>>   36         struct datagram_entry *entry;
>>   37         struct work_struct work;
>>   38         bool in_dg_host_queue;
>>   39         /* msg and msg_payload must be together. */
>>   40         struct vmci_datagram msg;
>>   41         u8 msg_payload[];
>>   42 };
>>
>> So those extra bytes of payload are copied into msg_payload[], a run time
>> warning is seen while fuzzing with Syzkaller.
>>
>> One possible way to fix the warning is to split the memcpy() into
>> two parts -- one -- direct assignment of msg and second taking care of payload.
>>
>> Gustavo quoted:
>> "Under FORTIFY_SOURCE we should not copy data across multiple members
>> in a structure."
>>
>> Reported-by: syzkaller <syzkaller@googlegroups.com>
>> Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
>> Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>> This patch is only tested with the C reproducer, not any testing
>> specific to driver is done.
>>
>> v1->v2: ( Suggestions from Gustavo )
>>          1. Change the commit message false positive --> legitimate
>>             warning.
> 
> The commit message is fine.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> But, I mean, it's not really "legitimate".  It meets the fortify source
> heuristic, but it's still a false positive.  Fortify source is
> *supposed* to find memory corruption bugs and this is not a memory
> corruption bug.  It's just that these days we have to treat foritify
> false positives as crashing bugs because people enable it and we have to
> fix it.
> 
> Let's not pretend that fortify has helped us in this situation, it has
> caused us a problem.  It has taken valid code and created a crashing
> bug.  I'm not saying that the cost isn't worth it, but let's not pretend.
> 

It's a "legitimate warning" (which differs from a "legitimate memory
corruption bug") in the sense that the feature is doing what it's
supposed to do: reporting a write beyond the boundaries of a field/member
in a structure.

Is that simple.  I don't see the "pretense" here.

BTW, is this _warning_ really causing a crash?

Thanks
--
Gustavo


