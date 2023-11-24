Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405F27F73AE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbjKXMWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjKXMWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:22:36 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C5BD44;
        Fri, 24 Nov 2023 04:22:42 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOCIHMi008611;
        Fri, 24 Nov 2023 12:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HmSY9atPAcdtE0eERT6r8L+jM+d0GuF903wQCeF27tI=;
 b=g3RYpi+Bp7xlrYwudZQVsmqhLjFiKlDjHxw9+svO/mXZ5XOJ0JXzOFbTm/egANxZ+rqk
 tNvIdhjAPoCJ5g222EGGsUuZPBy7e68byPO4aFZz6ggpo3rJl8pzvCycvEwRgIUYGK6e
 eftrHPKdzOYzRLgvXMGThnaPucfKSilkYMLzm/kLA7zk9/G6kUNU7ESwRfrZrHxyMBKn
 6giNc2TL759ChR8kke8pFh0eUV5eYj4tJzbtdYrf6zsmUrDfhhSpWCsuh6voJpvDvez3
 Q/fKIw7r1o+qxyjygxGnOMlNoYYNbvpE+iNSnrDgEJkevNGbC4UbuWmopJa8j6MNpI82 vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujuq6r2xx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 12:22:30 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AOCJBqh010447;
        Fri, 24 Nov 2023 12:22:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujuq6r2xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 12:22:30 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOCIsbT015944;
        Fri, 24 Nov 2023 12:22:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8kpdgyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 12:22:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AOCMQQb46989764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Nov 2023 12:22:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08E5320040;
        Fri, 24 Nov 2023 12:22:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D1A820043;
        Fri, 24 Nov 2023 12:22:24 +0000 (GMT)
Received: from [9.171.44.235] (unknown [9.171.44.235])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 24 Nov 2023 12:22:24 +0000 (GMT)
Message-ID: <9bb42e3a-88c1-4ec7-afd9-85e04eb68177@linux.ibm.com>
Date:   Fri, 24 Nov 2023 13:22:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net/smc: add sysctl for max conns per lgr
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
 <20231122135258.38746-3-guangguan.wang@linux.alibaba.com>
From:   Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20231122135258.38746-3-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AaS3aKng8_tv-Q4yp1AVkoPFmESW3cPL
X-Proofpoint-GUID: SqGm7dIOLdUxVm_fQb7J9q82VH-UfW7z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311240096
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
> Add a new sysctl: net.smc.smcr_max_conns_per_lgr, which is
> used to control the preferred max connections per lgr for
> SMC-R v2.1. The default value of this sysctl is 255, and
> the acceptable value ranges from 16 to 255.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>

Hi Guangguan,
thanks for your Submission.

Reviewed-by: Jan Karcher <jaka@linux.ibm.com>

> ---
>   Documentation/networking/smc-sysctl.rst |  6 ++++++
>   include/net/netns/smc.h                 |  1 +
>   net/smc/smc_clc.c                       |  5 +++--
>   net/smc/smc_sysctl.c                    | 12 ++++++++++++
>   net/smc/smc_sysctl.h                    |  1 +
>   5 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
> index c6ef86ef4c4f..a874d007f2db 100644
> --- a/Documentation/networking/smc-sysctl.rst
> +++ b/Documentation/networking/smc-sysctl.rst
> @@ -65,3 +65,9 @@ smcr_max_links_per_lgr - INTEGER
>   	for SMC-R v2.1 and later.
>   
>   	Default: 2
> +
> +smcr_max_conns_per_lgr - INTEGER
> +	Controls the max number of connections can be added to a SMC-R link group. The
> +	acceptable value ranges from 16 to 255. Only for SMC-R v2.1 and later.
> +
> +	Default: 255
> diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
> index da7023587824..fc752a50f91b 100644
> --- a/include/net/netns/smc.h
> +++ b/include/net/netns/smc.h
> @@ -23,5 +23,6 @@ struct netns_smc {
>   	int				sysctl_wmem;
>   	int				sysctl_rmem;
>   	int				sysctl_max_links_per_lgr;
> +	int				sysctl_max_conns_per_lgr;
>   };
>   #endif
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index 1f87c8895a27..0fda5156eef0 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -944,7 +944,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>   	}
>   	if (smcr_indicated(ini->smc_type_v2)) {
>   		memcpy(v2_ext->roce, ini->smcrv2.ib_gid_v2, SMC_GID_SIZE);
> -		v2_ext->max_conns = SMC_CONN_PER_LGR_PREFER;
> +		v2_ext->max_conns = net->smc.sysctl_max_conns_per_lgr;
>   		v2_ext->max_links = net->smc.sysctl_max_links_per_lgr;
>   	}
>   
> @@ -1191,7 +1191,8 @@ int smc_clc_srv_v2x_features_validate(struct smc_sock *smc,
>   		return SMC_CLC_DECL_NOV2EXT;
>   
>   	if (ini->smcr_version & SMC_V2) {
> -		ini->max_conns = min_t(u8, pclc_v2_ext->max_conns, SMC_CONN_PER_LGR_PREFER);
> +		ini->max_conns = min_t(u8, pclc_v2_ext->max_conns,
> +				       net->smc.sysctl_max_conns_per_lgr);
>   		if (ini->max_conns < SMC_CONN_PER_LGR_MIN)
>   			return SMC_CLC_DECL_MAXCONNERR;
>   
> diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
> index 3e9bb921e40a..a5946d1b9d60 100644
> --- a/net/smc/smc_sysctl.c
> +++ b/net/smc/smc_sysctl.c
> @@ -27,6 +27,8 @@ static const int net_smc_wmem_init = (64 * 1024);
>   static const int net_smc_rmem_init = (64 * 1024);
>   static int links_per_lgr_min = SMC_LINKS_ADD_LNK_MIN;
>   static int links_per_lgr_max = SMC_LINKS_ADD_LNK_MAX;
> +static int conns_per_lgr_min = SMC_CONN_PER_LGR_MIN;
> +static int conns_per_lgr_max = SMC_CONN_PER_LGR_MAX;
>   
>   static struct ctl_table smc_table[] = {
>   	{
> @@ -79,6 +81,15 @@ static struct ctl_table smc_table[] = {
>   		.extra1		= &links_per_lgr_min,
>   		.extra2		= &links_per_lgr_max,
>   	},
> +	{
> +		.procname	= "smcr_max_conns_per_lgr",
> +		.data		= &init_net.smc.sysctl_max_conns_per_lgr,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= &conns_per_lgr_min,
> +		.extra2		= &conns_per_lgr_max,
> +	},
>   	{  }
>   };
>   
> @@ -109,6 +120,7 @@ int __net_init smc_sysctl_net_init(struct net *net)
>   	WRITE_ONCE(net->smc.sysctl_wmem, net_smc_wmem_init);
>   	WRITE_ONCE(net->smc.sysctl_rmem, net_smc_rmem_init);
>   	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
> +	net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
>   
>   	return 0;
>   
> diff --git a/net/smc/smc_sysctl.h b/net/smc/smc_sysctl.h
> index 5783dd7575dd..eb2465ae1e15 100644
> --- a/net/smc/smc_sysctl.h
> +++ b/net/smc/smc_sysctl.h
> @@ -24,6 +24,7 @@ static inline int smc_sysctl_net_init(struct net *net)
>   {
>   	net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
>   	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
> +	net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
>   	return 0;
>   }
>   
