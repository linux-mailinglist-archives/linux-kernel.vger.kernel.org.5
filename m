Return-Path: <linux-kernel+bounces-20845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2AA82860F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509E41C23737
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB781364C6;
	Tue,  9 Jan 2024 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Hl3iDqxp"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BF479D4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id NA8UrZQuQ9gG6NBGmrEGUx; Tue, 09 Jan 2024 12:31:48 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id NBGlrWhCaim6ENBGmrbBmn; Tue, 09 Jan 2024 12:31:48 +0000
X-Authority-Analysis: v=2.4 cv=Qft1A+Xv c=1 sm=1 tr=0 ts=659d3cb4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GfQleyYEO+cc22AUyTT7qQ==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=4RBUngkUAAAA:8
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=_Wotqz80AAAA:8 a=5WGr0wUqv5Qhd2XfCJMA:9
 a=QEXdDO2ut3YA:10 a=_sbA2Q-Kp09kWB8D3iXc:22 a=AjGcO6oz07-iQ99wixmX:22
 a=buJP51TR1BpY-zbLSsyS:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MBKpXdgddFW+bxlw7X3WpJuwrJAjPBx5xfSRSdZ8pQY=; b=Hl3iDqxpvb198LtPOQ7+NwtxDd
	pApqMGH68v8rXXc3UAxIluKYdYfFG1IszgLON5bh/cNebOqFDNRFH1qKN0gqrM4QGWqWQQ3TSzpe2
	MmXss/chKCDFdthjLl4WOksGCJ6kW5w1VyyKVD69ce4RFHPpIa3R0hHDSj4glkOG02kqrtwK1X7sq
	ZbwAzGlWirIMrIYxrk5ce/K6cX/eGLI16Udsuv4jKbEndnv/q0SNqJ0YCvzzl6XK0DD2GmFo2gMBQ
	qUqHi8wjsnoWQOET4Yimx21+VdIcR92WJdYEG70piXvOMHCDwx2rXRO9ssEnljUz+th+L9b3gMM1K
	WF752VqA==;
Received: from 187.184.157.186.cable.dyn.cableonline.com.mx ([187.184.157.186]:42673 helo=[192.168.0.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rNBGj-002U7o-23;
	Tue, 09 Jan 2024 06:31:45 -0600
Message-ID: <7d7b94ba-9a1f-44de-8491-dc4864338f80@embeddedor.com>
Date: Tue, 9 Jan 2024 06:31:41 -0600
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
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <79ca2f85-1f8d-4a12-aa5a-09137033605f@moroto.mountain>
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
X-Exim-ID: 1rNBGj-002U7o-23
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.157.186]:42673
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDnuZ+6MzolOiRTGt+pFsemn166F6P4vNTbDRvl7TZNTByU+FE+SNPoDQLSzu8UB1fWEFccimlkXhZc9duX/JyI+OAFYXsQ6/gO43bgHN7qlmEtQ+cCw
 VUvoOz4KxRCHISV9rRuqpoPTs1mVv2gwXEq0zRjhIhmMNeoMhee32wB6c+ELw+in0wIyfdG07ZdubNtXrfa8JeSs1/Oo4HZjr0cQc5kQ/049uwj7GtExAd5y



On 1/9/24 03:07, Dan Carpenter wrote:
> On Mon, Jan 08, 2024 at 08:05:38PM -0600, Gustavo A. R. Silva wrote:
>>>> Gustavo quoted:
>>>> "Under FORTIFY_SOURCE we should not copy data across multiple members
>>>> in a structure."
>>>>
>>>> Reported-by: syzkaller <syzkaller@googlegroups.com>
>>>> Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
>>>> Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>>>
>>> Thanks for getting this fixed!
>>>
>>> Yeah, it's a "false positive" in the sense that the code was expecting
>>
>> It's a false positive _bug_, and a legitimate _warning_ coming from fortified
>> memcpy().
> 
> It really feels like you're trying to sell the cost of this as a good
> thing...  We've already merged fortify so why are you still fighting

No, I'm just describing (here[1] and below), clear and concise, what fortify
is doing in this particular case, in response to your first intervention
in this thread[3].

"The warning is triggered because of a write beyond the boundaries of
`dg_info->msg`."[2]

You're arguing that fortify caused a problem. I'm describing the reason
why the feature triggered the warning. That's it, I guess.

Thanks
--
Gustavo

[1] https://lore.kernel.org/linux-hardening/9c742547-0021-464b-b7a8-7af46b0a4afa@embeddedor.com/
[2] https://lore.kernel.org/linux-hardening/7826922a-d642-424e-bede-bfc45be9254d@embeddedor.com/
[3] https://lore.kernel.org/linux-hardening/fc132bde-d42d-4aac-ba91-7a939a18091a@moroto.mountain/

