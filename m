Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163B87813B4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379817AbjHRTnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379815AbjHRTma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:42:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C02F469A;
        Fri, 18 Aug 2023 12:41:29 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IJMO0h030831;
        Fri, 18 Aug 2023 19:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GK1ZkZgShzyA1iw3pfhsEPXbbH9VZ1BkPzEhorsOE9w=;
 b=OTmR/ervklVQwLL2EwfHy7/QpYSw3E0O9i0uPck5wDazD56KzSUbI5utgi+y2jFxZ3Ta
 eRXrRt65zRqZd8yBTjo0u9TFuAOGxpDD6UDkhPuOg6IAPH21lv6LFDm7D2SdXEqsPrFj
 /ga1fO5GdmDB7x3jcURml6Jc1Yo4MK0mb0g6GI6UoH/XOHNuKsNFcGv57hG7NcFxbWvs
 zm5k/iWEEhmj/vZLJtQ5yHAUMcymF3kT5k5ndapMQa+CcTopBZIK+hkc2cGBp998J0jE
 baIYk7Q0bbWeQkX7ZdHBMbwOlWMl8KdaBlpXFKtKiwTXuWtONXXP58UF20+EyGKoph2B 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjerb89pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 19:41:26 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IJZU3b001162;
        Fri, 18 Aug 2023 19:41:25 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjerb89pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 19:41:25 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37IJSuNo018920;
        Fri, 18 Aug 2023 19:41:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3seq428yvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 19:41:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37IJfL6222807232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 19:41:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4EF42004B;
        Fri, 18 Aug 2023 19:41:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E40B620040;
        Fri, 18 Aug 2023 19:41:20 +0000 (GMT)
Received: from [9.179.22.225] (unknown [9.179.22.225])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 18 Aug 2023 19:41:20 +0000 (GMT)
Message-ID: <b699df99-9375-9d7c-6e84-5e2131a93ddd@linux.ibm.com>
Date:   Fri, 18 Aug 2023 21:41:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v2 5/6] net/smc: support max links per lgr
 negotiation in clc handshake
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        wenjia@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230817132032.23397-1-guangguan.wang@linux.alibaba.com>
 <20230817132032.23397-6-guangguan.wang@linux.alibaba.com>
From:   Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20230817132032.23397-6-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pUwD9I9mtCrB66d7Nt68OmrrXSwv0zVN
X-Proofpoint-GUID: Y0lyoHRyT-iSmuu0ZuwJU7mIsmlMlkB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_24,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180178
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/08/2023 15:20, Guangguan Wang wrote:
> Support max links per lgr negotiation in clc handshake for SMCR v2.1,
> which is one of smc v2.1 features. Server makes decision for the final
> value of max links based on the client preferred max links and
> self-preferred max links. Here use the minimum value of the client
> preferred max links and server preferred max links.
> 
> Client                                       Server
>       Proposal(max links(client preferred))
>       -------------------------------------->
> 
>       Accept(max links(accepted value))
> accepted value=min(client preferred, server preferred)
>       <-------------------------------------
> 
>        Confirm(max links(accepted value))
>       ------------------------------------->
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>

Thank you for your contribution, Guangguan.

Reviewed-by: Jan Karcher <jaka@linux.ibm.com>

> ---
>   net/smc/af_smc.c   | 44 +++++++++++++++++++++++++++-----------------
>   net/smc/smc_clc.c  | 17 ++++++++++++++++-
>   net/smc/smc_clc.h  |  7 +++++--
>   net/smc/smc_core.c |  5 +++++
>   net/smc/smc_core.h | 12 ++++++++++++
>   net/smc/smc_llc.c  | 21 +++++++++++++++++----
>   6 files changed, 82 insertions(+), 24 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 8f041e871ddd..4d7152c8a80d 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -610,20 +610,22 @@ static int smcr_clnt_conf_first_link(struct smc_sock *smc)
>   	smc_llc_link_active(link);
>   	smcr_lgr_set_type(link->lgr, SMC_LGR_SINGLE);
>   
> -	/* optional 2nd link, receive ADD LINK request from server */
> -	qentry = smc_llc_wait(link->lgr, NULL, SMC_LLC_WAIT_TIME,
> -			      SMC_LLC_ADD_LINK);
> -	if (!qentry) {
> -		struct smc_clc_msg_decline dclc;
> -
> -		rc = smc_clc_wait_msg(smc, &dclc, sizeof(dclc),
> -				      SMC_CLC_DECLINE, CLC_WAIT_TIME_SHORT);
> -		if (rc == -EAGAIN)
> -			rc = 0; /* no DECLINE received, go with one link */
> -		return rc;
> +	if (link->lgr->max_links > 1) {
> +		/* optional 2nd link, receive ADD LINK request from server */
> +		qentry = smc_llc_wait(link->lgr, NULL, SMC_LLC_WAIT_TIME,
> +				      SMC_LLC_ADD_LINK);
> +		if (!qentry) {
> +			struct smc_clc_msg_decline dclc;
> +
> +			rc = smc_clc_wait_msg(smc, &dclc, sizeof(dclc),
> +					      SMC_CLC_DECLINE, CLC_WAIT_TIME_SHORT);
> +			if (rc == -EAGAIN)
> +				rc = 0; /* no DECLINE received, go with one link */
> +			return rc;
> +		}
> +		smc_llc_flow_qentry_clr(&link->lgr->llc_flow_lcl);
> +		smc_llc_cli_add_link(link, qentry);
>   	}
> -	smc_llc_flow_qentry_clr(&link->lgr->llc_flow_lcl);
> -	smc_llc_cli_add_link(link, qentry);
>   	return 0;
>   }
>   
> @@ -1212,6 +1214,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
>   	memcpy(ini->peer_gid, aclc->r0.lcl.gid, SMC_GID_SIZE);
>   	memcpy(ini->peer_mac, aclc->r0.lcl.mac, ETH_ALEN);
>   	ini->max_conns = SMC_CONN_PER_LGR_MAX;
> +	ini->max_links = SMC_LINKS_ADD_LNK_MAX;
>   
>   	reason_code = smc_connect_rdma_v2_prepare(smc, aclc, ini);
>   	if (reason_code)
> @@ -1856,10 +1859,12 @@ static int smcr_serv_conf_first_link(struct smc_sock *smc)
>   	smc_llc_link_active(link);
>   	smcr_lgr_set_type(link->lgr, SMC_LGR_SINGLE);
>   
> -	down_write(&link->lgr->llc_conf_mutex);
> -	/* initial contact - try to establish second link */
> -	smc_llc_srv_add_link(link, NULL);
> -	up_write(&link->lgr->llc_conf_mutex);
> +	if (link->lgr->max_links > 1) {
> +		down_write(&link->lgr->llc_conf_mutex);
> +		/* initial contact - try to establish second link */
> +		smc_llc_srv_add_link(link, NULL);
> +		up_write(&link->lgr->llc_conf_mutex);
> +	}
>   	return 0;
>   }
>   
> @@ -2463,6 +2468,11 @@ static void smc_listen_work(struct work_struct *work)
>   		goto out_decl;
>   	}
>   
> +	/* fce smc release version is needed in smc_listen_rdma_finish,
> +	 * so save fce info here.
> +	 */
> +	smc_conn_save_peer_info_fce(new_smc, cclc);
> +
>   	/* finish worker */
>   	if (!ini->is_smcd) {
>   		rc = smc_listen_rdma_finish(new_smc, cclc,
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index 60cfe37625b8..9573920c1773 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -433,8 +433,10 @@ static int smc_clc_fill_fce(struct smc_clc_first_contact_ext_v2x *fce,
>   	}
>   
>   	if (ini->release_nr >= SMC_RELEASE_1) {
> -		if (!ini->is_smcd)
> +		if (!ini->is_smcd) {
>   			fce->max_conns = ini->max_conns;
> +			fce->max_links = ini->max_links;
> +		}
>   	}
>   
>   out:
> @@ -942,6 +944,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>   	if (smcr_indicated(ini->smc_type_v2)) {
>   		memcpy(v2_ext->roce, ini->smcrv2.ib_gid_v2, SMC_GID_SIZE);
>   		v2_ext->max_conns = SMC_CONN_PER_LGR_PREFER;
> +		v2_ext->max_links = SMC_LINKS_PER_LGR_MAX_PREFER;
>   	}
>   
>   	pclc_base->hdr.length = htons(plen);
> @@ -1174,6 +1177,7 @@ int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
>   	struct smc_clc_v2_extension *pclc_v2_ext;
>   
>   	ini->max_conns = SMC_CONN_PER_LGR_MAX;
> +	ini->max_links = SMC_LINKS_ADD_LNK_MAX;
>   
>   	if ((!(ini->smcd_version & SMC_V2) && !(ini->smcr_version & SMC_V2)) ||
>   	    ini->release_nr < SMC_RELEASE_1)
> @@ -1187,6 +1191,10 @@ int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
>   		ini->max_conns = min_t(u8, pclc_v2_ext->max_conns, SMC_CONN_PER_LGR_PREFER);
>   		if (ini->max_conns < SMC_CONN_PER_LGR_MIN)
>   			return SMC_CLC_DECL_MAXCONNERR;
> +
> +		ini->max_links = min_t(u8, pclc_v2_ext->max_links, SMC_LINKS_PER_LGR_MAX_PREFER);
> +		if (ini->max_links < SMC_LINKS_ADD_LNK_MIN)
> +			return SMC_CLC_DECL_MAXLINKERR;
>   	}
>   
>   	return 0;
> @@ -1205,6 +1213,11 @@ int smc_clc_clnt_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
>   		if (fce_v2x->max_conns < SMC_CONN_PER_LGR_MIN)
>   			return SMC_CLC_DECL_MAXCONNERR;
>   		ini->max_conns = fce_v2x->max_conns;
> +
> +		if (fce_v2x->max_links > SMC_LINKS_ADD_LNK_MAX ||
> +		    fce_v2x->max_links < SMC_LINKS_ADD_LNK_MIN)
> +			return SMC_CLC_DECL_MAXLINKERR;
> +		ini->max_links = fce_v2x->max_links;
>   	}
>   
>   	return 0;
> @@ -1233,6 +1246,8 @@ int smc_clc_v2x_features_confirm_check(struct smc_clc_msg_accept_confirm *cclc,
>   	if (!ini->is_smcd) {
>   		if (fce_v2x->max_conns != ini->max_conns)
>   			return SMC_CLC_DECL_MAXCONNERR;
> +		if (fce_v2x->max_links != ini->max_links)
> +			return SMC_CLC_DECL_MAXLINKERR;
>   	}
>   
>   	return 0;
> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index 464b93b46047..c5c8e7db775a 100644
> --- a/net/smc/smc_clc.h
> +++ b/net/smc/smc_clc.h
> @@ -47,6 +47,7 @@
>   #define SMC_CLC_DECL_NOUEID	0x03030008  /* peer sent no UEID	      */
>   #define SMC_CLC_DECL_RELEASEERR	0x03030009  /* release version negotiate failed */
>   #define SMC_CLC_DECL_MAXCONNERR	0x0303000a  /* max connections negotiate failed */
> +#define SMC_CLC_DECL_MAXLINKERR	0x0303000b  /* max links negotiate failed */
>   #define SMC_CLC_DECL_MODEUNSUPP	0x03040000  /* smc modes do not match (R or D)*/
>   #define SMC_CLC_DECL_RMBE_EC	0x03050000  /* peer has eyecatcher in RMBE    */
>   #define SMC_CLC_DECL_OPTUNSUPP	0x03060000  /* fastopen sockopt not supported */
> @@ -136,7 +137,8 @@ struct smc_clc_v2_extension {
>   	struct smc_clnt_opts_area_hdr hdr;
>   	u8 roce[16];		/* RoCEv2 GID */
>   	u8 max_conns;
> -	u8 reserved[15];
> +	u8 max_links;
> +	u8 reserved[14];
>   	u8 user_eids[][SMC_MAX_EID_LEN];
>   };
>   
> @@ -239,7 +241,8 @@ struct smc_clc_first_contact_ext {
>   struct smc_clc_first_contact_ext_v2x {
>   	struct smc_clc_first_contact_ext fce_v2_base;
>   	u8 max_conns; /* for SMC-R only */
> -	u8 reserved3[3];
> +	u8 max_links; /* for SMC-R only */
> +	u8 reserved3[2];
>   	__be32 vendor_exp_options;
>   	u8 reserved4[8];
>   } __packed;		/* format defined in
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index a8091a3e6cdd..1e1475084bb4 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -896,10 +896,12 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
>   			memcpy(lgr->nexthop_mac, ini->smcrv2.nexthop_mac,
>   			       ETH_ALEN);
>   			lgr->max_conns = ini->max_conns;
> +			lgr->max_links = ini->max_links;
>   		} else {
>   			ibdev = ini->ib_dev;
>   			ibport = ini->ib_port;
>   			lgr->max_conns = SMC_CONN_PER_LGR_MAX;
> +			lgr->max_links = SMC_LINKS_ADD_LNK_MAX;
>   		}
>   		memcpy(lgr->pnet_id, ibdev->pnetid[ibport - 1],
>   		       SMC_MAX_PNETID_LEN);
> @@ -1667,6 +1669,9 @@ void smcr_port_add(struct smc_ib_device *smcibdev, u8 ibport)
>   		    !rdma_dev_access_netns(smcibdev->ibdev, lgr->net))
>   			continue;
>   
> +		if (lgr->type == SMC_LGR_SINGLE && lgr->max_links <= 1)
> +			continue;
> +
>   		/* trigger local add link processing */
>   		link = smc_llc_usable_link(lgr);
>   		if (link)
> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
> index 32b199477ef3..120027d40469 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -173,6 +173,15 @@ struct smc_link {
>    */
>   #define SMC_LINKS_PER_LGR_MAX	3
>   #define SMC_SINGLE_LINK		0
> +#define SMC_LINKS_ADD_LNK_MIN	1	/* min. # of links per link group */
> +#define SMC_LINKS_ADD_LNK_MAX	2	/* max. # of links per link group, also is the
> +					 * default value for smc-r v1.0 and v2.0
> +					 */
> +#define SMC_LINKS_PER_LGR_MAX_PREFER	2	/* Preferred max links per link group used for
> +						 * SMC-R v2.1 and later negotiation, vendors or
> +						 * distrubutions may modify it to a value between
> +						 * 1-2 as needed.
> +						 */
>   
>   /* tx/rx buffer list element for sndbufs list and rmbs list of a lgr */
>   struct smc_buf_desc {
> @@ -342,6 +351,8 @@ struct smc_link_group {
>   			struct net		*net;
>   			u8			max_conns;
>   						/* max conn can be assigned to lgr */
> +			u8			max_links;
> +						/* max links can be added in lgr */
>   		};
>   		struct { /* SMC-D */
>   			u64			peer_gid;
> @@ -387,6 +398,7 @@ struct smc_init_info {
>   	u8			smc_type_v2;
>   	u8			release_nr;
>   	u8			max_conns;
> +	u8			max_links;
>   	u8			first_contact_peer;
>   	u8			first_contact_local;
>   	unsigned short		vlan_id;
> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index 5347b62f1518..018ce8133b02 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c
> @@ -59,8 +59,6 @@ struct smc_llc_msg_confirm_link {	/* type 0x01 */
>   #define SMC_LLC_FLAG_ADD_LNK_REJ	0x40
>   #define SMC_LLC_REJ_RSN_NO_ALT_PATH	1
>   
> -#define SMC_LLC_ADD_LNK_MAX_LINKS	2
> -
>   struct smc_llc_msg_add_link {		/* type 0x02 */
>   	struct smc_llc_hdr hd;
>   	u8 sender_mac[ETH_ALEN];
> @@ -472,10 +470,12 @@ int smc_llc_send_confirm_link(struct smc_link *link,
>   	hton24(confllc->sender_qp_num, link->roce_qp->qp_num);
>   	confllc->link_num = link->link_id;
>   	memcpy(confllc->link_uid, link->link_uid, SMC_LGR_ID_SIZE);
> -	confllc->max_links = SMC_LLC_ADD_LNK_MAX_LINKS;
> +	confllc->max_links = SMC_LINKS_ADD_LNK_MAX;
>   	if (link->lgr->smc_version == SMC_V2 &&
> -	    link->lgr->peer_smc_release >= SMC_RELEASE_1)
> +	    link->lgr->peer_smc_release >= SMC_RELEASE_1) {
>   		confllc->max_conns = link->lgr->max_conns;
> +		confllc->max_links = link->lgr->max_links;
> +	}
>   	/* send llc message */
>   	rc = smc_wr_tx_send(link, pend);
>   put_out:
> @@ -1045,6 +1045,11 @@ int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry)
>   		goto out_reject;
>   	}
>   
> +	if (lgr->type == SMC_LGR_SINGLE && lgr->max_links <= 1) {
> +		rc = 0;
> +		goto out_reject;
> +	}
> +
>   	ini->vlan_id = lgr->vlan_id;
>   	if (lgr->smc_version == SMC_V2) {
>   		ini->check_smcrv2 = true;
> @@ -1169,6 +1174,9 @@ static void smc_llc_cli_add_link_invite(struct smc_link *link,
>   	    lgr->type == SMC_LGR_ASYMMETRIC_PEER)
>   		goto out;
>   
> +	if (lgr->type == SMC_LGR_SINGLE && lgr->max_links <= 1)
> +		goto out;
> +
>   	ini = kzalloc(sizeof(*ini), GFP_KERNEL);
>   	if (!ini)
>   		goto out;
> @@ -1414,6 +1422,11 @@ int smc_llc_srv_add_link(struct smc_link *link,
>   		goto out;
>   	}
>   
> +	if (lgr->type == SMC_LGR_SINGLE && lgr->max_links <= 1) {
> +		rc = 0;
> +		goto out;
> +	}
> +
>   	/* ignore client add link recommendation, start new flow */
>   	ini->vlan_id = lgr->vlan_id;
>   	if (lgr->smc_version == SMC_V2) {
