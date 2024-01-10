Return-Path: <linux-kernel+bounces-21760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC648293DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03341C2570E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AB236AFE;
	Wed, 10 Jan 2024 06:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C8dA4Rn4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0682F37;
	Wed, 10 Jan 2024 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A5mBRT006193;
	Wed, 10 Jan 2024 06:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Mt3GyiJ9vVGutRC7UpvXBsOFoaqPH0dyfdXlQVtmUKQ=; b=C8
	dA4Rn4cAaFV0VDK8A5vFJGhi7FASnixOppYM6nd7K2FXLGJYesjJI5oAUVD9SIDa
	4er77hR2eRkexDNg7gWb6Lnu2SAm7D9b+osbZeBRc9/SJFfVTfMfsSHmvOGR0m8m
	EefaQY8h/j+kVddR2ySg/OsIRQg+XZcPZZYZMViePI0NvXhS990Ds2RrG4lw7Xz8
	iX+L4WL+Qv6m4XYM56oQcTMmlRr97VZARZmTehPUJyBdk1DZy25bS6TQQASR8dOB
	qnRZ9R3eBVmjE05zBQDRBylLz23UZa0A2ockxLOd7tuuPv0fi3C0a4aifuMoXLaI
	Kek40FSei4pIYQRKFElQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9bmhnx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 06:57:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40A6uxXk027386
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 06:56:59 GMT
Received: from [10.110.90.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 22:56:59 -0800
Message-ID: <c23523c1-bf37-48f4-9580-3f4c12ed746f@quicinc.com>
Date: Tue, 9 Jan 2024 23:56:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: qualcomm: rmnet: fix global oob in
 rmnet_policy
To: Lin Ma <linma@zju.edu.cn>, <quic_stranche@quicinc.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240110061400.3356108-1-linma@zju.edu.cn>
Content-Language: en-US
From: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
In-Reply-To: <20240110061400.3356108-1-linma@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6b046fD024XHp5d7aYnVqvprru-on4ln
X-Proofpoint-GUID: 6b046fD024XHp5d7aYnVqvprru-on4ln
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100055

On 1/9/2024 11:14 PM, Lin Ma wrote:
> The variable rmnet_link_ops assign a *bigger* maxtype which leads to a
> global out-of-bounds read when parsing the netlink attributes. See bug
> trace below:
> 
> ==================================================================
> BUG: KASAN: global-out-of-bounds in validate_nla lib/nlattr.c:386 [inline]
> BUG: KASAN: global-out-of-bounds in __nla_validate_parse+0x24af/0x2750 lib/nlattr.c:600
> Read of size 1 at addr ffffffff92c438d0 by task syz-executor.6/84207
> 
> CPU: 0 PID: 84207 Comm: syz-executor.6 Tainted: G                 N 6.1.0 #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x8b/0xb3 lib/dump_stack.c:106
>   print_address_description mm/kasan/report.c:284 [inline]
>   print_report+0x172/0x475 mm/kasan/report.c:395
>   kasan_report+0xbb/0x1c0 mm/kasan/report.c:495
>   validate_nla lib/nlattr.c:386 [inline]
>   __nla_validate_parse+0x24af/0x2750 lib/nlattr.c:600
>   __nla_parse+0x3e/0x50 lib/nlattr.c:697
>   nla_parse_nested_deprecated include/net/netlink.h:1248 [inline]
>   __rtnl_newlink+0x50a/0x1880 net/core/rtnetlink.c:3485
>   rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3594
>   rtnetlink_rcv_msg+0x43c/0xd70 net/core/rtnetlink.c:6091
>   netlink_rcv_skb+0x14f/0x410 net/netlink/af_netlink.c:2540
>   netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>   netlink_unicast+0x54e/0x800 net/netlink/af_netlink.c:1345
>   netlink_sendmsg+0x930/0xe50 net/netlink/af_netlink.c:1921
>   sock_sendmsg_nosec net/socket.c:714 [inline]
>   sock_sendmsg+0x154/0x190 net/socket.c:734
>   ____sys_sendmsg+0x6df/0x840 net/socket.c:2482
>   ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
>   __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fdcf2072359
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fdcf13e3168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fdcf219ff80 RCX: 00007fdcf2072359
> RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000000000003
> RBP: 00007fdcf20bd493 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fffbb8d7bdf R14: 00007fdcf13e3300 R15: 0000000000022000
>   </TASK>
> 
> The buggy address belongs to the variable:
>   rmnet_policy+0x30/0xe0
> 
> The buggy address belongs to the physical page:
> page:0000000065bdeb3c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x155243
> flags: 0x200000000001000(reserved|node=0|zone=2)
> raw: 0200000000001000 ffffea00055490c8 ffffea00055490c8 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>   ffffffff92c43780: f9 f9 f9 f9 00 00 00 02 f9 f9 f9 f9 00 00 00 07
>   ffffffff92c43800: f9 f9 f9 f9 00 00 00 05 f9 f9 f9 f9 06 f9 f9 f9
>> ffffffff92c43880: f9 f9 f9 f9 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9
>                                                   ^
>   ffffffff92c43900: 00 00 00 00 00 00 00 00 07 f9 f9 f9 f9 f9 f9 f9
>   ffffffff92c43980: 00 00 00 07 f9 f9 f9 f9 00 00 00 05 f9 f9 f9 f9
> 
> According to the comment of `nla_parse_nested_deprecated`, the maxtype
> should be len(destination array) - 1. Hence use `IFLA_RMNET_MAX` here.
> 
> Fixes: 14452ca3b5ce ("net: qualcomm: rmnet: Export mux_id and flags to netlink")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
>   drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index 39d24e07f306..5b69b9268c75 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -396,7 +396,7 @@ static int rmnet_fill_info(struct sk_buff *skb, const struct net_device *dev)
>   
>   struct rtnl_link_ops rmnet_link_ops __read_mostly = {
>   	.kind		= "rmnet",
> -	.maxtype	= __IFLA_RMNET_MAX,
> +	.maxtype	= IFLA_RMNET_MAX,
>   	.priv_size	= sizeof(struct rmnet_priv),
>   	.setup		= rmnet_vnd_setup,
>   	.validate	= rmnet_rtnl_validate,

Thanks for fixing this

Reviewed-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>

