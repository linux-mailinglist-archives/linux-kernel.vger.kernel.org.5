Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC797C56EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjJKOeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjJKOeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:34:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA2890;
        Wed, 11 Oct 2023 07:34:13 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BEVNAa012906;
        Wed, 11 Oct 2023 14:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=IiaYUCjyK9kZwQr3Mcj2XTB6CIc79PEtX61tyNIY+6I=;
 b=RW8a3bAjfHeVMeB4ZapKDM6nW1nFqyR/HiQYXPoSBqfUNi9zPS04g/cCl9Ry985DXhNb
 AhWaaMWqKSIqSbZiLZy3mQDyLitvDi1Zkp4zX42a7bkrrypv9i/wHQy0odIrAbUtpeKH
 VJ3617TLOtByL3K6W7rY3JcQWKU9UncHsBUnOsLKnUNh0pmXH8zngqdRJFK9Jfhf2G0+
 dxGnoOJsTwwLm0YCiYBv9TOhn+BzDk9XRikEjLFOUDTRDvwvcaWptFhw6HBB2iwA8Uem
 gqZeon1KmdScc7ahUHqTGK130r2IPl10NAA5f+p/HK39M3M+7LGW/2EbMKUZRthrVpf3 ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnwba0nhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 14:33:45 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39BEVNgs012903;
        Wed, 11 Oct 2023 14:33:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnwba0nd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 14:33:44 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39BCx52l001150;
        Wed, 11 Oct 2023 14:33:42 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkkvk08p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 14:33:42 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39BEXf3L26018486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 14:33:41 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52D155805B;
        Wed, 11 Oct 2023 14:33:41 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8B605804B;
        Wed, 11 Oct 2023 14:33:38 +0000 (GMT)
Received: from [9.171.29.13] (unknown [9.171.29.13])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 11 Oct 2023 14:33:38 +0000 (GMT)
Message-ID: <8403e613-e51e-4c76-a542-3bdd3050cfa9@linux.ibm.com>
Date:   Wed, 11 Oct 2023 16:33:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net/smc: fix smc clc failed issue when netdevice
 not in init_net
Content-Language: en-GB
To:     Albert Huang <huangjie.albert@bytedance.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>
Cc:     "D. Wythe" <alibuda@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231011074851.95280-1-huangjie.albert@bytedance.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20231011074851.95280-1-huangjie.albert@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XoxWrBBea8b99XYLqJVss4AyPrBPm4Ml
X-Proofpoint-ORIG-GUID: dylW30NxWSrBwOnlahl3jJp_MgSbvedN
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_09,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.10.23 09:48, Albert Huang wrote:
> If the netdevice is within a container and communicates externally
> through network technologies such as VxLAN, we won't be able to find
> routing information in the init_net namespace. To address this issue,
> we need to add a struct net parameter to the smc_ib_find_route function.
> This allow us to locate the routing information within the corresponding
> net namespace, ensuring the correct completion of the SMC CLC interaction.
> 
> Fixes: e5c4744cfb59 ("net/smc: add SMC-Rv2 connection establishment")
> Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> ---
>   net/smc/af_smc.c | 3 ++-
>   net/smc/smc_ib.c | 7 ++++---
>   net/smc/smc_ib.h | 2 +-
>   3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index bacdd971615e..7a874da90c7f 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1201,6 +1201,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>   		(struct smc_clc_msg_accept_confirm_v2 *)aclc;
>   	struct smc_clc_first_contact_ext *fce =
>   		smc_get_clc_first_contact_ext(clc_v2, false);
> +	struct net *net = sock_net(&smc->sk);
>   	int rc;
>   
>   	if (!ini->first_contact_peer || aclc->hdr.version == SMC_V1)
> @@ -1210,7 +1211,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>   		memcpy(ini->smcrv2.nexthop_mac, &aclc->r0.lcl.mac, ETH_ALEN);
>   		ini->smcrv2.uses_gateway = false;
>   	} else {
> -		if (smc_ib_find_route(smc->clcsock->sk->sk_rcv_saddr,
> +		if (smc_ib_find_route(net, smc->clcsock->sk->sk_rcv_saddr,
>   				      smc_ib_gid_to_ipv4(aclc->r0.lcl.gid),
>   				      ini->smcrv2.nexthop_mac,
>   				      &ini->smcrv2.uses_gateway))
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 9b66d6aeeb1a..89981dbe46c9 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -193,7 +193,7 @@ bool smc_ib_port_active(struct smc_ib_device *smcibdev, u8 ibport)
>   	return smcibdev->pattr[ibport - 1].state == IB_PORT_ACTIVE;
>   }
>   
> -int smc_ib_find_route(__be32 saddr, __be32 daddr,
> +int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
>   		      u8 nexthop_mac[], u8 *uses_gateway)
>   {
>   	struct neighbour *neigh = NULL;
> @@ -205,7 +205,7 @@ int smc_ib_find_route(__be32 saddr, __be32 daddr,
>   
>   	if (daddr == cpu_to_be32(INADDR_NONE))
>   		goto out;
> -	rt = ip_route_output_flow(&init_net, &fl4, NULL);
> +	rt = ip_route_output_flow(net, &fl4, NULL);
>   	if (IS_ERR(rt))
>   		goto out;
>   	if (rt->rt_uses_gateway && rt->rt_gw_family != AF_INET)
> @@ -235,6 +235,7 @@ static int smc_ib_determine_gid_rcu(const struct net_device *ndev,
>   	if (smcrv2 && attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP &&
>   	    smc_ib_gid_to_ipv4((u8 *)&attr->gid) != cpu_to_be32(INADDR_NONE)) {
>   		struct in_device *in_dev = __in_dev_get_rcu(ndev);
> +		struct net *net = dev_net(ndev);
>   		const struct in_ifaddr *ifa;
>   		bool subnet_match = false;
>   
> @@ -248,7 +249,7 @@ static int smc_ib_determine_gid_rcu(const struct net_device *ndev,
>   		}
>   		if (!subnet_match)
>   			goto out;
> -		if (smcrv2->daddr && smc_ib_find_route(smcrv2->saddr,
> +		if (smcrv2->daddr && smc_ib_find_route(net, smcrv2->saddr,
>   						       smcrv2->daddr,
>   						       smcrv2->nexthop_mac,
>   						       &smcrv2->uses_gateway))
> diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
> index 4df5f8c8a0a1..ef8ac2b7546d 100644
> --- a/net/smc/smc_ib.h
> +++ b/net/smc/smc_ib.h
> @@ -112,7 +112,7 @@ void smc_ib_sync_sg_for_device(struct smc_link *lnk,
>   int smc_ib_determine_gid(struct smc_ib_device *smcibdev, u8 ibport,
>   			 unsigned short vlan_id, u8 gid[], u8 *sgid_index,
>   			 struct smc_init_info_smcrv2 *smcrv2);
> -int smc_ib_find_route(__be32 saddr, __be32 daddr,
> +int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
>   		      u8 nexthop_mac[], u8 *uses_gateway);
>   bool smc_ib_is_valid_local_systemid(void);
>   int smcr_nl_get_device(struct sk_buff *skb, struct netlink_callback *cb);

If it works for VXLAN, I'm still wondering why this case doesn't work, 
could you please answer it?
https://lore.kernel.org/netdev/00bbbf48440c1889ecd16a590ebb746b820a4f48.camel@linux.ibm.com/


Thanks,
Wenjia
