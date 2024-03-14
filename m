Return-Path: <linux-kernel+bounces-103195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BE687BC31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3825286F13
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE576F06F;
	Thu, 14 Mar 2024 11:48:48 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC146EB6D;
	Thu, 14 Mar 2024 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710416927; cv=none; b=mEZAOY4V58FKAm3sUNz1AjhK6SD63nWe6ROfvx6QvZZIH7K+5Wsydry/c7i3/VQWv1iBEj+8cfr73AInzTlQtHymNz2NtRCFh2eXrz3mpTRD5vSv/Z+SfLV+SzDl7PuIP1ES2kngAgCLil0/p5+YiWXK2jgT7xyFRTXEhPzu6a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710416927; c=relaxed/simple;
	bh=7ZiBPpdN/pRir9iGW2WDn9wd7ox5+ZWpl5rz4L8hPpM=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HhNVcJuuK4QcruPysEGwnrJxJkIO/bEKUCZ1/pofYyJymEBZm9D2Lh05xnK8PI15L/wsu2M6JSUywL7LWgpMYo8rYmuJtnwARXZzIuEda8EQv0pV+QZjrvh8J2rqOaL3/quEghVIWK749GaaVJxj7IiWNAw4zRCE6RxeFhgdIrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TwQb24vv0z1xrD5;
	Thu, 14 Mar 2024 19:46:54 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 18715180061;
	Thu, 14 Mar 2024 19:48:41 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 19:48:40 +0800
Message-ID: <da60f9b8-0ea7-4580-ab45-f294801605f9@huawei.com>
Date: Thu, 14 Mar 2024 19:48:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, Salil
 Mehta <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Yufeng Mo <moyufeng@huawei.com>, Huazhong Tan
	<tanhuazhong@huawei.com>
Subject: Re: [PATCH] net: hns3: tracing: fix hclgevf trace event strings
To: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, netdev
	<netdev@vger.kernel.org>
References: <20240313093454.3909afe7@gandalf.local.home>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240313093454.3909afe7@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)

Reviewed-by: Jijie Shao<shaojijie@huawei.com>

on 2024/3/13 21:34, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> [
>     Note, I need to take this patch through my tree, so I'm looking for acks.
>     This causes the build to fail when I add the __assign_str() check, which
>     I was about to push to Linus, but it breaks allmodconfig due to this error.
> ]
>
> The __string() and __assign_str() helper macros of the TRACE_EVENT() macro
> are going through some optimizations where only the source string of
> __string() will be used and the __assign_str() source will be ignored and
> later removed.
>
> To make sure that there's no issues, a new check is added between the
> __string() src argument and the __assign_str() src argument that does a
> strcmp() to make sure they are the same string.
>
> The hclgevf trace events have:
>
>    __assign_str(devname, &hdev->nic.kinfo.netdev->name);
>
> Which triggers the warning:
>
> hclgevf_trace.h:34:39: error: passing argument 1 of ‘strcmp’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>     34 |                 __assign_str(devname, &hdev->nic.kinfo.netdev->name);
>   [..]
> arch/x86/include/asm/string_64.h:75:24: note: expected ‘const char *’ but argument is of type ‘char (*)[16]’
>     75 | int strcmp(const char *cs, const char *ct);
>        |            ~~~~~~~~~~~~^~
>
>
> Because __assign_str() now has:
>
> 	WARN_ON_ONCE(__builtin_constant_p(src) ?		\
> 		     strcmp((src), __data_offsets.dst##_ptr_) :	\
> 		     (src) != __data_offsets.dst##_ptr_);	\
>
> The problem is the '&' on hdev->nic.kinfo.netdev->name. That's because
> that name is:
>
> 	char			name[IFNAMSIZ]
>
> Where passing an address '&' of a char array is not compatible with strcmp().
>
> The '&' is not necessary, remove it.
>
> Fixes: d8355240cf8fb ("net: hns3: add trace event support for PF/VF mailbox")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h  | 8 ++++----
>   .../net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h    | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
> index 8510b88d4982..f3cd5a376eca 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
> @@ -24,7 +24,7 @@ TRACE_EVENT(hclge_pf_mbx_get,
>   		__field(u8, code)
>   		__field(u8, subcode)
>   		__string(pciname, pci_name(hdev->pdev))
> -		__string(devname, &hdev->vport[0].nic.kinfo.netdev->name)
> +		__string(devname, hdev->vport[0].nic.kinfo.netdev->name)
>   		__array(u32, mbx_data, PF_GET_MBX_LEN)
>   	),
>   
> @@ -33,7 +33,7 @@ TRACE_EVENT(hclge_pf_mbx_get,
>   		__entry->code = req->msg.code;
>   		__entry->subcode = req->msg.subcode;
>   		__assign_str(pciname, pci_name(hdev->pdev));
> -		__assign_str(devname, &hdev->vport[0].nic.kinfo.netdev->name);
> +		__assign_str(devname, hdev->vport[0].nic.kinfo.netdev->name);
>   		memcpy(__entry->mbx_data, req,
>   		       sizeof(struct hclge_mbx_vf_to_pf_cmd));
>   	),
> @@ -56,7 +56,7 @@ TRACE_EVENT(hclge_pf_mbx_send,
>   		__field(u8, vfid)
>   		__field(u16, code)
>   		__string(pciname, pci_name(hdev->pdev))
> -		__string(devname, &hdev->vport[0].nic.kinfo.netdev->name)
> +		__string(devname, hdev->vport[0].nic.kinfo.netdev->name)
>   		__array(u32, mbx_data, PF_SEND_MBX_LEN)
>   	),
>   
> @@ -64,7 +64,7 @@ TRACE_EVENT(hclge_pf_mbx_send,
>   		__entry->vfid = req->dest_vfid;
>   		__entry->code = le16_to_cpu(req->msg.code);
>   		__assign_str(pciname, pci_name(hdev->pdev));
> -		__assign_str(devname, &hdev->vport[0].nic.kinfo.netdev->name);
> +		__assign_str(devname, hdev->vport[0].nic.kinfo.netdev->name);
>   		memcpy(__entry->mbx_data, req,
>   		       sizeof(struct hclge_mbx_pf_to_vf_cmd));
>   	),
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
> index 5d4895bb57a1..b259e95dd53c 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
> @@ -23,7 +23,7 @@ TRACE_EVENT(hclge_vf_mbx_get,
>   		__field(u8, vfid)
>   		__field(u16, code)
>   		__string(pciname, pci_name(hdev->pdev))
> -		__string(devname, &hdev->nic.kinfo.netdev->name)
> +		__string(devname, hdev->nic.kinfo.netdev->name)
>   		__array(u32, mbx_data, VF_GET_MBX_LEN)
>   	),
>   
> @@ -31,7 +31,7 @@ TRACE_EVENT(hclge_vf_mbx_get,
>   		__entry->vfid = req->dest_vfid;
>   		__entry->code = le16_to_cpu(req->msg.code);
>   		__assign_str(pciname, pci_name(hdev->pdev));
> -		__assign_str(devname, &hdev->nic.kinfo.netdev->name);
> +		__assign_str(devname, hdev->nic.kinfo.netdev->name);
>   		memcpy(__entry->mbx_data, req,
>   		       sizeof(struct hclge_mbx_pf_to_vf_cmd));
>   	),
> @@ -55,7 +55,7 @@ TRACE_EVENT(hclge_vf_mbx_send,
>   		__field(u8, code)
>   		__field(u8, subcode)
>   		__string(pciname, pci_name(hdev->pdev))
> -		__string(devname, &hdev->nic.kinfo.netdev->name)
> +		__string(devname, hdev->nic.kinfo.netdev->name)
>   		__array(u32, mbx_data, VF_SEND_MBX_LEN)
>   	),
>   
> @@ -64,7 +64,7 @@ TRACE_EVENT(hclge_vf_mbx_send,
>   		__entry->code = req->msg.code;
>   		__entry->subcode = req->msg.subcode;
>   		__assign_str(pciname, pci_name(hdev->pdev));
> -		__assign_str(devname, &hdev->nic.kinfo.netdev->name);
> +		__assign_str(devname, hdev->nic.kinfo.netdev->name);
>   		memcpy(__entry->mbx_data, req,
>   		       sizeof(struct hclge_mbx_vf_to_pf_cmd));
>   	),

