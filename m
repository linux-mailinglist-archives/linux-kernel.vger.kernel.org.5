Return-Path: <linux-kernel+bounces-26379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0F982DFA4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA0AB20AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BC918633;
	Mon, 15 Jan 2024 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Mq6/yHPG"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764551862E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id PIIfrs4oFCF6GPRdlrJFqP; Mon, 15 Jan 2024 18:24:53 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id PRdkrvQfgV9xYPRdkrBTtO; Mon, 15 Jan 2024 18:24:53 +0000
X-Authority-Analysis: v=2.4 cv=NfP1akP4 c=1 sm=1 tr=0 ts=65a57875
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=7YfXLusrAAAA:8 a=EvbeSHRCGunigFkjgBEA:9 a=QEXdDO2ut3YA:10
 a=9cHFzqQdt-sA:10 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cIx2Q42MgOjugJW5xmZxdWQVR1i47N/QKStLLpKq8T4=; b=Mq6/yHPGzLLoNSdcpmx19D4Jes
	JzGBWh6pD3zHKVecZhvQSW9tHcq8+nhACrFU9TF4ajxJJbXnJMZB/TQ51NVPYYCVMH3OzoJ7N1ux2
	KuABoEG3GfuEexc3avK3N2J0zV/xL7Pp5ToVPuKe1o6aNBmMd3xY+yNaDzE93S9ie4ewjLghCded+
	qL25txjMZ4IQZ+1f2KRkYkFv1DdNGnkXAm6+DZZtcvQdtJLqz2uIAXF8SyjKUF8X9jc5PfW1SS7Er
	cGdwIDq/qmLHkOCjkScF7yRbwCpMZ51GzJ3IudxUXXm2aRKgjm+dFoij3iHGwNPA4CsjY69ROyQpK
	KzYV82TQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:43136 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rPRdj-003vCX-2g;
	Mon, 15 Jan 2024 12:24:51 -0600
Message-ID: <77d29a54-ca71-4a2a-99ca-f2932c72e32d@embeddedor.com>
Date: Mon, 15 Jan 2024 12:24:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] eventfs: Use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240115181658.4562-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240115181658.4562-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1rPRdj-003vCX-2g
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:43136
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHVywbHxAfDqlvYsGQq2ylcILyjtg+8s35Il3yVGDJg+yIo/GyqGAc9gxWCDZ2/OxegrUIfaFqG/Thwdtelp+LYdA4LlcrIXofaUdg6Jy8IZ62Ua1+62
 XaiUIaTbEZnY0spTIwC2vHkjCYXJBdlEAniHLuaRm5GsQndqhqfKZURE7HyDPAPROlql1bdqp6QKQEzsPgVSxutyrIEgzI8A+n+rB6oMuHiZVzvbhsj5oAlp



On 1/15/24 12:16, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> size * count in the kzalloc() function.
> 
> [1] https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
> Changes in v2:
> - Update the commit message to better explain the changes (Mark Rutland)
> 
> Previous versions:
> v1: https://lore.kernel.org/linux-hardening/20240114105340.5746-1-erick.archer@gmx.com/
> ---
>   fs/tracefs/event_inode.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index fdff53d5a1f8..f8196289692c 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -93,7 +93,7 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
>   	/* Preallocate the children mode array if necessary */
>   	if (!(dentry->d_inode->i_mode & S_IFDIR)) {
>   		if (!ei->entry_attrs) {
> -			ei->entry_attrs = kzalloc(sizeof(*ei->entry_attrs) * ei->nr_entries,
> +			ei->entry_attrs = kcalloc(ei->nr_entries, sizeof(*ei->entry_attrs),
>   						  GFP_NOFS);
>   			if (!ei->entry_attrs) {
>   				ret = -ENOMEM;
> @@ -874,7 +874,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
>   	}
> 
>   	if (size) {
> -		ei->d_children = kzalloc(sizeof(*ei->d_children) * size, GFP_KERNEL);
> +		ei->d_children = kcalloc(size, sizeof(*ei->d_children), GFP_KERNEL);
>   		if (!ei->d_children) {
>   			kfree_const(ei->name);
>   			kfree(ei);
> @@ -941,7 +941,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
>   		goto fail;
> 
>   	if (size) {
> -		ei->d_children = kzalloc(sizeof(*ei->d_children) * size, GFP_KERNEL);
> +		ei->d_children = kcalloc(size, sizeof(*ei->d_children), GFP_KERNEL);
>   		if (!ei->d_children)
>   			goto fail;
>   	}
> --
> 2.25.1
> 
> 

