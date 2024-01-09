Return-Path: <linux-kernel+bounces-20269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9DC827CAE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779721C2336C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A651844;
	Tue,  9 Jan 2024 02:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="JqNEmyzS"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C58133DD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 02:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id Mzv5rKufACF6GN1UvrN7Th; Tue, 09 Jan 2024 02:05:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id N1UvrwCNUZKctN1UvrJCTm; Tue, 09 Jan 2024 02:05:45 +0000
X-Authority-Analysis: v=2.4 cv=a+kjSGeF c=1 sm=1 tr=0 ts=659ca9f9
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GfQleyYEO+cc22AUyTT7qQ==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=4RBUngkUAAAA:8
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=mDV3o1hIAAAA:8 a=cm27Pg_UAAAA:8
 a=JA-m-T4maVgcW0BiTrcA:9 a=QEXdDO2ut3YA:10 a=_sbA2Q-Kp09kWB8D3iXc:22
 a=AjGcO6oz07-iQ99wixmX:22 a=_FVE-zBwftR9WsbkzFJk:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5B0dw/Up6ifNtvRAU765UMOVfZFbZSraBE9QG9ssVwU=; b=JqNEmyzSUnsh8EYFiP4v4OCBA/
	xVqwtTnSCB9gNCBNgvZCiLxUGwWa2QaW0F1ZNjoQKNEwnWwl8rZACqm5PAOJZOPZdvuxTmTR4JOtW
	sP62IPVdwFqf4wXOYcJkpGQ20p25ZBMI9frzL1egwtJiicSGXjd2+WljjecPCYf87dmpIEIog18tb
	aAs9pfeypFV3o6MP6d0GB/2YWhRtEvhBbbnP/IFDBcwQk6XCy34PA3glf8Io4cg7AfAElSYZROxgU
	OXPHryzuZ+h+HBd3A/8AQY/i0z0t3X2w/2fmTddSVB+qvEMGCjlGLY1obzmTEOczx5/N0B19tHsyF
	mmmgiomA==;
Received: from 187.184.157.186.cable.dyn.cableonline.com.mx ([187.184.157.186]:65048 helo=[192.168.0.3])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rN1Us-003hSm-2w;
	Mon, 08 Jan 2024 20:05:43 -0600
Message-ID: <9c742547-0021-464b-b7a8-7af46b0a4afa@embeddedor.com>
Date: Mon, 8 Jan 2024 20:05:38 -0600
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
To: Kees Cook <keescook@chromium.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: linux-hardening@vger.kernel.org, error27@gmail.com,
 gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
 Vishnu Dasa <vdasa@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, vegard.nossum@oracle.com,
 darren.kenny@oracle.com, syzkaller <syzkaller@googlegroups.com>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
 <202401081430.9DAB37B46@keescook>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202401081430.9DAB37B46@keescook>
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
X-Exim-ID: 1rN1Us-003hSm-2w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.186.cable.dyn.cableonline.com.mx ([192.168.0.3]) [187.184.157.186]:65048
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOWSpWgqF4gA0Pc8w3+ii3NS4K/DK00Rr7j7EJXPX3PkKgkDaagihdhKFphEAxtV3INHMFFLj3KudI9iotpW+K/p+Jsis6I3iWcseWQyoS5aW+sF3Miz
 6k+4IwTFGj3fLwJVBZYf29uDElHbOC6RWaXJIfxqFEwZBHh0Goo+74tBc501SVXafjfg0Kph94NpfZh9cKcF3rBQxBp7ZQkECTU09ObbFXLQN7nCDJ4K1ev/



On 1/8/24 16:37, Kees Cook wrote:
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
> 
> Thanks for getting this fixed!
> 
> Yeah, it's a "false positive" in the sense that the code was expecting

It's a false positive _bug_, and a legitimate _warning_ coming from fortified
memcpy().

> to write into msg_payload. The warning is triggered because of the write
> across the flex array boundary, which trips a bug in GCC and Clang,
> which we're forced to work around.

The warning is triggered because of a write beyond the boundaries of
`dg_info->msg`. It's not directly related to the fact that there is a
flexible-array member following `dg_info->msg`.

> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101832 (fixed in GCC 14+)
> 	 (not yet fixed in Clang)

This issue is not related to the compiler bugs mentioned above.

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thanks!
--
Gustavo

