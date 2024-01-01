Return-Path: <linux-kernel+bounces-13917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045F78214C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 18:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147E01C20AAE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 17:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836728F7E;
	Mon,  1 Jan 2024 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="CXEJS0rK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8D8F6C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id KIiKrxz79WcCIKMKJrCZaV; Mon, 01 Jan 2024 17:43:47 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id KMKIrK3qO97pzKMKJrwtVT; Mon, 01 Jan 2024 17:43:47 +0000
X-Authority-Analysis: v=2.4 cv=ULDOoQTy c=1 sm=1 tr=0 ts=6592f9d3
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GfQleyYEO+cc22AUyTT7qQ==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=4RBUngkUAAAA:8
 a=yPCof4ZbAAAA:8 a=s-YHb6lbn-Xrcz-ehpMA:9 a=QEXdDO2ut3YA:10
 a=_sbA2Q-Kp09kWB8D3iXc:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=huackJ8jZzDmN0sqCQfiharq0gTzy0SAIzq039inA2o=; b=CXEJS0rKPiVtT0jkmsZb232rnJ
	2+WW4RY+4KPwgyCD2zH5QJFt53/kD82w6Rp5uen9NUtZ49P8M8HASTOL56IYlZMWSi1D5ws7RuDHZ
	vKGXdwvPnSEGKKzTd2kCUbhNIpIvH4Z205mNYsMFcDl26ImPEHYR4bDn4scPJJnIGjAUvfbgr79kB
	VkK/l36AumOzmYgg+1qHnZoa2RkATQtftLxLsR1EQ6K2GaY8Y/nTxDJpw9VTEfVtZRidkedRdC9a7
	4t8fSkMI/WmMbzwM3BTSa9Z+Kq4NPaRxZokXMtRvKkmcZ6Q9/2mvt1bwuvS+xUC4qDQUDR5E7eaUK
	wUE14Tmg==;
Received: from 187.184.157.186.cable.dyn.cableonline.com.mx ([187.184.157.186]:10555 helo=[192.168.0.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rKMKH-002ID1-2h;
	Mon, 01 Jan 2024 11:43:45 -0600
Message-ID: <cc8d5ac1-99b6-480d-86ca-f76ed9c324c3@embeddedor.com>
Date: Mon, 1 Jan 2024 11:43:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] VMCI: Silence memcpy() run-time false positive
 warning
Content-Language: en-US
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 linux-hardening@vger.kernel.org, keescook@chromium.org,
 gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
 Vishnu Dasa <vdasa@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: vegard.nossum@oracle.com, darren.kenny@oracle.com,
 syzkaller <syzkaller@googlegroups.com>
References: <20240101130828.3666251-1-harshit.m.mogalapalli@oracle.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240101130828.3666251-1-harshit.m.mogalapalli@oracle.com>
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
X-Exim-ID: 1rKMKH-002ID1-2h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.157.186]:10555
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfF4aNoZeoIxpCZx9rSOn2N10wT/UbxMn2PSeh5PuiwexcZXSX+eq4T8HgWV/AutFjPyOuVtrGvpN1EJf9wT9WKszUvKpWMFN6lJoAthrDkHDXD1lIuV2
 zo/Iom7jUK1o659NpKvmR7yiO6F+Dln78u11KtMds7hjOGF++a7P3x9CPa5w/vv51re92ZOxhXAs7zFxLMIj6D6iyeNEhnI82EVULCUDzC/YMb6z5m2UMd1E



On 1/1/24 07:08, Harshit Mogalapalli wrote:
> Syzkaller hit 'WARNING in dg_dispatch_as_host' bug.
> 
> memcpy: detected field-spanning write (size 56) of single field "&dg_info->msg"
> at drivers/misc/vmw_vmci/vmci_datagram.c:237 (size 24)

This is not a 'false postive warning.' This is a legitimately warning
coming from the fortified memcpy().

Under FORTIFY_SOURCE we should not copy data across multiple members
in a structure. For that we alternatives like struct_group(), or as
in this case, splitting memcpy(), or as I suggest below, a mix of
direct assignment and memcpy().


> 
> WARNING: CPU: 0 PID: 1555 at drivers/misc/vmw_vmci/vmci_datagram.c:237
> dg_dispatch_as_host+0x88e/0xa60 drivers/misc/vmw_vmci/vmci_datagram.c:237
> 
> Some code commentry, based on my understanding:
> 
> 544 #define VMCI_DG_SIZE(_dg) (VMCI_DG_HEADERSIZE + (size_t)(_dg)->payload_size)
> /// This is 24 + payload_size
> 
> memcpy(&dg_info->msg, dg, dg_size);
> 	Destination = dg_info->msg ---> this is a 24 byte
> 					structure(struct vmci_datagram)
> 	Source = dg --> this is a 24 byte structure (struct vmci_datagram)
> 	Size = dg_size = 24 + payload_size
> 
> 
> {payload_size = 56-24 =32} -- Syzkaller managed to set payload_size to 32.
> 
>   35 struct delayed_datagram_info {
>   36         struct datagram_entry *entry;
>   37         struct work_struct work;
>   38         bool in_dg_host_queue;
>   39         /* msg and msg_payload must be together. */
>   40         struct vmci_datagram msg;
>   41         u8 msg_payload[];
>   42 };
> 
> So those extra bytes of payload are copied into msg_payload[], so there
> is no bug, but a run time warning is seen while fuzzing with Syzkaller.
> 
> One possible way to silence the warning is to split the memcpy() into
> two parts -- one -- copying the msg and second taking care of payload.
> 
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This patch is only tested with the C reproducer, not any testing
> specific to driver is done.
> ---
>   drivers/misc/vmw_vmci/vmci_datagram.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_datagram.c b/drivers/misc/vmw_vmci/vmci_datagram.c
> index f50d22882476..b43661590f56 100644
> --- a/drivers/misc/vmw_vmci/vmci_datagram.c
> +++ b/drivers/misc/vmw_vmci/vmci_datagram.c
> @@ -216,6 +216,7 @@ static int dg_dispatch_as_host(u32 context_id, struct vmci_datagram *dg)
>   		if (dst_entry->run_delayed ||
>   		    dg->src.context == VMCI_HOST_CONTEXT_ID) {
>   			struct delayed_datagram_info *dg_info;
> +			size_t payload_size = dg_size - VMCI_DG_HEADERSIZE;

This seems to be the same as `dg->payload_size`, so I don't think a new
variable is necessary.

>   
>   			if (atomic_add_return(1, &delayed_dg_host_queue_size)
>   			    == VMCI_MAX_DELAYED_DG_HOST_QUEUE_SIZE) {
> @@ -234,7 +235,8 @@ static int dg_dispatch_as_host(u32 context_id, struct vmci_datagram *dg)
>   
>   			dg_info->in_dg_host_queue = true;
>   			dg_info->entry = dst_entry;
> -			memcpy(&dg_info->msg, dg, dg_size);
> +			memcpy(&dg_info->msg, dg, VMCI_DG_HEADERSIZE);
> +			memcpy(&dg_info->msg_payload, dg + 1, payload_size);

I think a direct assignment and a call to memcpy() is better in this case,
something like this:

dg_info->msg = *dg;
memcpy(&dg_info->msg_payload, dg + 1, dg->payload_size);

However, that `dg + 1` thing is making my eyes twitch. Where exactly are we
making sure that `dg` actually points to an area in memory bigger than
`sizeof(*dg)`?...

Also, we could also use struct_size() during allocation, some lines above:

-                       dg_info = kmalloc(sizeof(*dg_info) +
-                                   (size_t) dg->payload_size, GFP_ATOMIC);
+                       dg_info = kmalloc(struct_size(dg_info, msg_payload, dg->payload_size),
+                                         GFP_ATOMIC);

--
Gustavo

>   
>   			INIT_WORK(&dg_info->work, dg_delayed_dispatch);
>   			schedule_work(&dg_info->work);

