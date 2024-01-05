Return-Path: <linux-kernel+bounces-18089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A44B8258BB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09841F23639
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6B831A71;
	Fri,  5 Jan 2024 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="tJnDb4XG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13383174E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id LB0WrqIuoAxAkLnVsrY4Ve; Fri, 05 Jan 2024 16:57:40 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id LnVdru74nYjq0LnVerxq2G; Fri, 05 Jan 2024 16:57:26 +0000
X-Authority-Analysis: v=2.4 cv=afxyIDkt c=1 sm=1 tr=0 ts=659834f6
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GfQleyYEO+cc22AUyTT7qQ==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=48sfuStoL9JXZ_Dqu6YA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I92cwQ2M/ukJXYyLK/8tnkWQfwmfCkto22shFNhUE+0=; b=tJnDb4XGok36sMRvy7Be4/SrBN
	a/bf3/kYa2z3Qyal/FpKQL6fD3/rKmVKsegD/0JlH4XqPcTvSwucVLOV8UbXRFgo0O4fyfB0UYzOq
	HBgJqMtYIlKTDl1yCG5toTaIN4lsPHhSJClx72owRO3iKkepgd5FRpPAiQbJanyRW1yBeo/eUl9Ay
	NekhlR+Z91RXfsobY2XQMjHWSKtaIdzJMky1a/fgkPA/A6KE/p62uYAi4w1AISaDoFRBTVK3CVQxr
	80OBvop7xNyla4K9xhy3AUgRl8eX8/KAnRhXB7sn/GgUBd58dk+rDeTYyNrTR0kNkkC8TkAcjrOgY
	Ve7W++oQ==;
Received: from 187.184.157.186.cable.dyn.cableonline.com.mx ([187.184.157.186]:37427 helo=[192.168.0.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rLnVc-001rsQ-01;
	Fri, 05 Jan 2024 10:57:24 -0600
Message-ID: <923c1008-3571-4383-95f3-ebbbef7271ae@embeddedor.com>
Date: Fri, 5 Jan 2024 10:57:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] VMCI: Use struct_size() in kmalloc()
Content-Language: en-US
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 linux-hardening@vger.kernel.org, keescook@chromium.org, error27@gmail.com,
 gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
 Vishnu Dasa <vdasa@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: vegard.nossum@oracle.com, darren.kenny@oracle.com
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
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
X-Exim-ID: 1rLnVc-001rsQ-01
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.157.186]:37427
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIW6DiC6/rYB7RY6eXxlUU11xGu96JoRlciG669JZafHiJ7MQn0CKs1AEyKXhxGWrxyWQn3JR3yAnf+1YhgYRXto5Xmob+XbdJtdvqkgNyWVerS6z6lg
 9Eal55EYNucBkRWoCLs7WvTnbT6ZrIZBT+ytht5XVelwFRQUG7Dud8+scUqGg+j0CERZdoGySw19fcWj4qGVc3Si840vCoheceWPKwDkb3NAG+lN3rjy8wCm



On 1/5/24 10:39, Harshit Mogalapalli wrote:
> Use struct_size() instead of open coding.
> 
> Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   drivers/misc/vmw_vmci/vmci_datagram.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_datagram.c b/drivers/misc/vmw_vmci/vmci_datagram.c
> index f50d22882476..ac6cb0c8d99b 100644
> --- a/drivers/misc/vmw_vmci/vmci_datagram.c
> +++ b/drivers/misc/vmw_vmci/vmci_datagram.c
> @@ -224,8 +224,8 @@ static int dg_dispatch_as_host(u32 context_id, struct vmci_datagram *dg)
>   				return VMCI_ERROR_NO_MEM;
>   			}
>   
> -			dg_info = kmalloc(sizeof(*dg_info) +
> -				    (size_t) dg->payload_size, GFP_ATOMIC);
> +			dg_info = kmalloc(struct_size(dg_info, msg_payload, dg->payload_size),
> +					  GFP_ATOMIC);
>   			if (!dg_info) {
>   				atomic_dec(&delayed_dg_host_queue_size);
>   				vmci_resource_put(resource);

