Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1037C7F73AB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344941AbjKXMWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXMWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:22:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EEFD46;
        Fri, 24 Nov 2023 04:22:36 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOAqEBT001145;
        Fri, 24 Nov 2023 12:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MVn8DboT28MvZPXQn5cpVRGsiYl8MrxbQqdWU2PP2dc=;
 b=a+qW/hAg0aOk8EMBebCvMbC/48JHzRUdTF060JXQBP+8AV6gl7Vi9xverAEhqV4/m6y+
 QnudYgPEbz0zlSRJVwTgW6i5ObCT6hP4nOOJolPpSrDI6JPRRxaoLjVnsQoWwB27Eqdw
 GC03t1P1r1mgpKt2ASa0EXMeq4vB9atYkWLw4s+9FFJh/iAaynnumBVoeC8CJ//T2LSO
 2VV5n1j1Q89V89hH6DgAFubMBKXiA2YpxViNv2i/NE2MF94ewI5jhkGtL43Bv8cMd8nY
 OKw7lpqkJxbGmb3hvJxedPskDOdUxwAq5U+6ERztx2Z/mgBJnN4rqqkaG+uEch2RIkUM fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujtf3su87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 12:22:27 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AOCDB3d010966;
        Fri, 24 Nov 2023 12:22:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujtf3su7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 12:22:26 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOCIk7i015317;
        Fri, 24 Nov 2023 12:22:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8005p73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 12:22:25 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AOCML5d24380110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Nov 2023 12:22:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2C362004B;
        Fri, 24 Nov 2023 12:22:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1423920040;
        Fri, 24 Nov 2023 12:22:20 +0000 (GMT)
Received: from [9.171.44.235] (unknown [9.171.44.235])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 24 Nov 2023 12:22:19 +0000 (GMT)
Message-ID: <1c843b3d-b7f3-4c84-aa12-b40b5d74a404@linux.ibm.com>
Date:   Fri, 24 Nov 2023 13:22:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net/smc: add sysctl for max links per lgr
 for SMC-R v2.1
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        wenjia@linux.ibm.com, kgraul@linux.ibm.com, corbet@lwn.net,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com
Cc:     tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231122135258.38746-1-guangguan.wang@linux.alibaba.com>
 <20231122135258.38746-2-guangguan.wang@linux.alibaba.com>
From:   Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20231122135258.38746-2-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KxgIITNdX0kBz3459lyCp-EJpNlzZiUk
X-Proofpoint-ORIG-GUID: 8h5SFJxtH_-TlCd8-JIzNsaFQRMMFswG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1011 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/11/2023 14:52, Guangguan Wang wrote:
> Add a new sysctl: net.smc.smcr_max_links_per_lgr, which is
> used to control the preferred max links per lgr for SMC-R
> v2.1. The default value of this sysctl is 2, and the acceptable
> value ranges from 1 to 2.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>

Hi Guangguan,
thanks for your Submission.

Reviewed-by: Jan Karcher <jaka@linux.ibm.com>

> ---
>   Documentation/networking/smc-sysctl.rst |  8 ++++++++
>   include/net/netns/smc.h                 |  1 +
>   net/smc/af_smc.c                        |  2 +-
>   net/smc/smc_clc.c                       | 10 +++++++---
>   net/smc/smc_clc.h                       |  3 ++-
>   net/smc/smc_sysctl.c                    | 12 ++++++++++++
>   net/smc/smc_sysctl.h                    |  1 +
>   7 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
> index 769149d98773..c6ef86ef4c4f 100644
> --- a/Documentation/networking/smc-sysctl.rst
> +++ b/Documentation/networking/smc-sysctl.rst
> @@ -57,3 +57,11 @@ rmem - INTEGER
>   	only allowed 512KiB for SMC-R and 1MiB for SMC-D.
>   
>   	Default: 64KiB
> +
> +smcr_max_links_per_lgr - INTEGER
> +	Controls the max number of links can be added to a SMC-R link group. Notice that
> +	the actual number of the links added to a SMC-R link group depends on the number
> +	of RDMA devices exist in the system. The acceptable value ranges from 1 to 2. Only
> +	for SMC-R v2.1 and later.
> +
> +	Default: 2
> diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
> index 582212ada3ba..da7023587824 100644
> --- a/include/net/netns/smc.h
> +++ b/include/net/netns/smc.h
> @@ -22,5 +22,6 @@ struct netns_smc {
>   	int				sysctl_smcr_testlink_time;
>   	int				sysctl_wmem;
>   	int				sysctl_rmem;
> +	int				sysctl_max_links_per_lgr;
>   };
>   #endif
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index da97f946b79b..f8da484efe90 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -2457,7 +2457,7 @@ static void smc_listen_work(struct work_struct *work)
>   	if (rc)
>   		goto out_decl;
>   
> -	rc = smc_clc_srv_v2x_features_validate(pclc, ini);
> +	rc = smc_clc_srv_v2x_features_validate(new_smc, pclc, ini);
>   	if (rc)
>   		goto out_decl;
>   
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index 8deb46c28f1d..1f87c8895a27 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -824,6 +824,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>   	struct smc_clc_smcd_gid_chid *gidchids;
>   	struct smc_clc_msg_proposal_area *pclc;
>   	struct smc_clc_ipv6_prefix *ipv6_prfx;
> +	struct net *net = sock_net(&smc->sk);
>   	struct smc_clc_v2_extension *v2_ext;
>   	struct smc_clc_msg_smcd *pclc_smcd;
>   	struct smc_clc_msg_trail *trl;
> @@ -944,7 +945,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>   	if (smcr_indicated(ini->smc_type_v2)) {
>   		memcpy(v2_ext->roce, ini->smcrv2.ib_gid_v2, SMC_GID_SIZE);
>   		v2_ext->max_conns = SMC_CONN_PER_LGR_PREFER;
> -		v2_ext->max_links = SMC_LINKS_PER_LGR_MAX_PREFER;
> +		v2_ext->max_links = net->smc.sysctl_max_links_per_lgr;
>   	}
>   
>   	pclc_base->hdr.length = htons(plen);
> @@ -1171,10 +1172,12 @@ int smc_clc_send_accept(struct smc_sock *new_smc, bool srv_first_contact,
>   	return len > 0 ? 0 : len;
>   }
>   
> -int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
> +int smc_clc_srv_v2x_features_validate(struct smc_sock *smc,
> +				      struct smc_clc_msg_proposal *pclc,
>   				      struct smc_init_info *ini)
>   {
>   	struct smc_clc_v2_extension *pclc_v2_ext;
> +	struct net *net = sock_net(&smc->sk);
>   
>   	ini->max_conns = SMC_CONN_PER_LGR_MAX;
>   	ini->max_links = SMC_LINKS_ADD_LNK_MAX;
> @@ -1192,7 +1195,8 @@ int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
>   		if (ini->max_conns < SMC_CONN_PER_LGR_MIN)
>   			return SMC_CLC_DECL_MAXCONNERR;
>   
> -		ini->max_links = min_t(u8, pclc_v2_ext->max_links, SMC_LINKS_PER_LGR_MAX_PREFER);
> +		ini->max_links = min_t(u8, pclc_v2_ext->max_links,
> +				       net->smc.sysctl_max_links_per_lgr);
>   		if (ini->max_links < SMC_LINKS_ADD_LNK_MIN)
>   			return SMC_CLC_DECL_MAXLINKERR;
>   	}
> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index c5c8e7db775a..89b258cedffe 100644
> --- a/net/smc/smc_clc.h
> +++ b/net/smc/smc_clc.h
> @@ -422,7 +422,8 @@ int smc_clc_send_confirm(struct smc_sock *smc, bool clnt_first_contact,
>   			 u8 version, u8 *eid, struct smc_init_info *ini);
>   int smc_clc_send_accept(struct smc_sock *smc, bool srv_first_contact,
>   			u8 version, u8 *negotiated_eid, struct smc_init_info *ini);
> -int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
> +int smc_clc_srv_v2x_features_validate(struct smc_sock *smc,
> +				      struct smc_clc_msg_proposal *pclc,
>   				      struct smc_init_info *ini);
>   int smc_clc_clnt_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
>   				       struct smc_init_info *ini);
> diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
> index 5cbc18c6e62b..3e9bb921e40a 100644
> --- a/net/smc/smc_sysctl.c
> +++ b/net/smc/smc_sysctl.c
> @@ -25,6 +25,8 @@ static int max_sndbuf = INT_MAX / 2;
>   static int max_rcvbuf = INT_MAX / 2;
>   static const int net_smc_wmem_init = (64 * 1024);
>   static const int net_smc_rmem_init = (64 * 1024);
> +static int links_per_lgr_min = SMC_LINKS_ADD_LNK_MIN;
> +static int links_per_lgr_max = SMC_LINKS_ADD_LNK_MAX;
>   
>   static struct ctl_table smc_table[] = {
>   	{
> @@ -68,6 +70,15 @@ static struct ctl_table smc_table[] = {
>   		.extra1		= &min_rcvbuf,
>   		.extra2		= &max_rcvbuf,
>   	},
> +	{
> +		.procname	= "smcr_max_links_per_lgr",
> +		.data		= &init_net.smc.sysctl_max_links_per_lgr,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= &links_per_lgr_min,
> +		.extra2		= &links_per_lgr_max,
> +	},
>   	{  }
>   };
>   
> @@ -97,6 +108,7 @@ int __net_init smc_sysctl_net_init(struct net *net)
>   	net->smc.sysctl_smcr_testlink_time = SMC_LLC_TESTLINK_DEFAULT_TIME;
>   	WRITE_ONCE(net->smc.sysctl_wmem, net_smc_wmem_init);
>   	WRITE_ONCE(net->smc.sysctl_rmem, net_smc_rmem_init);
> +	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
>   
>   	return 0;
>   
> diff --git a/net/smc/smc_sysctl.h b/net/smc/smc_sysctl.h
> index 0becc11bd2f4..5783dd7575dd 100644
> --- a/net/smc/smc_sysctl.h
> +++ b/net/smc/smc_sysctl.h
> @@ -23,6 +23,7 @@ void __net_exit smc_sysctl_net_exit(struct net *net);
>   static inline int smc_sysctl_net_init(struct net *net)
>   {
>   	net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
> +	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
>   	return 0;
>   }
>   
