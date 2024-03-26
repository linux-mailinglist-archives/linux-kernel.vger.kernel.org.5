Return-Path: <linux-kernel+bounces-118318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C48E88B7CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAFC1B22FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9FE128811;
	Tue, 26 Mar 2024 02:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="dlh+DXZ0"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8899112838B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711421868; cv=none; b=Sgd9R8j9YX26EZbKg/5JAGfFMHdlfvz71LS+MOISizzF1heb7oQGTB08QH3/bW2xMMUUWkjGuRBePT+bgJnUxXOPZWv6VUJDWswK1PVA2xRRlcjGThlTNMMMOvb2yvcgi6U+Lv+5LhO+fuEwRNaGnUlFZXP3LcArZQBe62UD8qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711421868; c=relaxed/simple;
	bh=vX3bVL1HMc4EDAaj7B3gjYlT0mkkt+c/itIyWdTv+VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fG/u0xXUACj5uyVmExMXJimRlymhKc0eAl+BFibDlynFw5jenm5TT9QExv6l54dwGS8OUwUhCzvpgQTyp+kONH81cOJbSZEUB14YZuw29NCvnXghFQxXZDLXUZgu7afIJiOmtwqDrtF8wfC3EzlOYj+1qylu9o72PPziycyGGIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=dlh+DXZ0; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id omu8rUS5kDI6fox0TrsGGJ; Tue, 26 Mar 2024 02:57:46 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id ox0SrACoTsT9Box0SrGpPg; Tue, 26 Mar 2024 02:57:45 +0000
X-Authority-Analysis: v=2.4 cv=LIutQ4W9 c=1 sm=1 tr=0 ts=660239a9
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=UtBFqMlDG83dypD0sxEoAQ==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=yCkJhreVFDLjqfpo9JAA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o90u6YTpwASH2e8B6jU5tsJiGz540jLK6rTJxZ74n1E=; b=dlh+DXZ0+HwO8YHOI59tzajiU7
	qmQUEJvuedN+ivIXiM+FfIAcXWLstqvZG56435B6bnHtPH5bqkuJ30xQCzNyxhe/qIwjSIIJo5gAb
	74tfMHvhcn5K+NTqhs5jPpm7P3AExBIrcQ+mR6q56+/Win8S2npzBx8uELGUPlCRcpKJsPePQFnAB
	8uyrn8iUYbR742Q6aWCJNeDen3PvwnqLGKWY111yZWIiwASKIMAwOpUYuDcpNrJLsXrcsi3Lm3669
	KoJPufJI4vyGkljBC2rV6wZDaFT0nw3KRh+kVgTJnuMGX6zdeWkKySinxXTUkOqJkvfxafStVBPXm
	FoboauPg==;
Received: from [201.172.174.229] (port=52604 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rox0R-001mui-1e;
	Mon, 25 Mar 2024 21:57:44 -0500
Message-ID: <5c0bb827-e5f3-4178-ad46-8ac9b99d7726@embeddedor.com>
Date: Mon, 25 Mar 2024 20:57:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] RDMA/cm: Avoid -Wflex-array-member-not-at-end
 warning
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZgHdZ15cQ7MIHsGL@neat> <20240325224706.GB8419@ziepe.ca>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240325224706.GB8419@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.229
X-Source-L: No
X-Exim-ID: 1rox0R-001mui-1e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.174.229]:52604
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKqU1kXB0nY1oeZY4B2ss7IOXZ3Xq01NZDsPNGVcHFAKoDbHBjXLKSyTBCW9YMuaQyqc4H9UoP3htH39hpBVKlZnWVF+uImUNH4kr6tJLL1Fp89qCcHw
 8au/2nlz7oBuudabPaJBptD1sMe/hxp5b5T+D7HzGVj6EV032mWHwp/nbDLKu0TQTIgJfgO5gzZ+G1hrl1e6FGJ9THkank639Tl34XdDkdM8YjjlcI9c4jiM



On 3/25/24 16:47, Jason Gunthorpe wrote:
> On Mon, Mar 25, 2024 at 02:24:07PM -0600, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
>> ready to enable it globally.
>>
>> Use the `struct_group_tagged()` helper to separate the flexible array
>> from the rest of the members in flexible `struct cm_work`, and avoid
>> embedding the flexible-array member in `struct cm_timewait_info`.
>>
>> Also, use `container_of()` to retrieve a pointer to the flexible
>> structure.
>>
>> So, with these changes, fix the following warning:
>> drivers/infiniband/core/cm.c:196:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   drivers/infiniband/core/cm.c | 21 ++++++++++++---------
>>   1 file changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
>> index bf0df6ee4f78..80c87085499c 100644
>> --- a/drivers/infiniband/core/cm.c
>> +++ b/drivers/infiniband/core/cm.c
>> @@ -182,18 +182,21 @@ struct cm_av {
>>   };
>>   
>>   struct cm_work {
>> -	struct delayed_work work;
>> -	struct list_head list;
>> -	struct cm_port *port;
>> -	struct ib_mad_recv_wc *mad_recv_wc;	/* Received MADs */
>> -	__be32 local_id;			/* Established / timewait */
>> -	__be32 remote_id;
>> -	struct ib_cm_event cm_event;
>> +	/* New members must be added within the struct_group() macro below. */
>> +	struct_group_tagged(cm_work_hdr, hdr,
>> +		struct delayed_work work;
>> +		struct list_head list;
>> +		struct cm_port *port;
>> +		struct ib_mad_recv_wc *mad_recv_wc;	/* Received MADs */
>> +		__be32 local_id;			/* Established / timewait */
>> +		__be32 remote_id;
>> +		struct ib_cm_event cm_event;
>> +	);
>>   	struct sa_path_rec path[];
>>   };
> 
> I didn't look, but does it make more sense to break out the path side
> into its own type and avoid the struct_group_tagged? I seem to
> remember only one thing used it.
> 

I thought about that, but I'd have to change the parameter type of
`static int cm_timewait_handler(struct cm_work *work)`, and that would
imply also modifying the internals of function `cm_work_handler()` (and
then I didn't look much into it). So, the `struct_group_tagged()`
strategy is in general more cleaner and straightforward.

--
Gustavo


