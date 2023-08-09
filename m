Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B977764A6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjHIQEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHIQEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:04:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36011FFE;
        Wed,  9 Aug 2023 09:04:40 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379Fte0u028942;
        Wed, 9 Aug 2023 16:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=R2zdP5G7QB1hSj2ET35XnD6HnS83LlmtG897yiiA/LA=;
 b=YV43+b2mnTcSbfxhqamSOGQFeLNJiy/OK6hKs8fXNf08iIzDcUsVUMhWZBDbW4F+ZftM
 0vS8byvMkvYnqjX2jXfmqtCM+EDzwJJ9mSMuVGS4ciRb9J0wlan3PIZV8qK1wg+Np03r
 vHbXc29K0k41k9KaHG7p3ruKrMnv08swtv4AmpHzRdSDuycLB/ZVrY+w0oZJSku0MdL0
 m0xpTjIEJyPPqn2bBvd8tZV3TlBs+Z5CuId41J5hf44eR/ZAB1slFiAcJ+enHW+eD2vD
 7lK4MHxqI4+uwyk+G3rsZifzn6LxpB9dP/rOtwNClSV0YO72xmo2/fxss71TGb8AoODW Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scdvbr7k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 16:04:35 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 379Fw8nQ001730;
        Wed, 9 Aug 2023 16:04:35 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scdvbr7jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 16:04:35 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 379EKRtv015374;
        Wed, 9 Aug 2023 16:04:34 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sb3f339cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 16:04:34 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 379G4W5L25232100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Aug 2023 16:04:33 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A40E05803F;
        Wed,  9 Aug 2023 16:04:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65C825805A;
        Wed,  9 Aug 2023 16:04:30 +0000 (GMT)
Received: from [9.171.35.46] (unknown [9.171.35.46])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  9 Aug 2023 16:04:30 +0000 (GMT)
Message-ID: <a7ed9f2d-5c50-b37f-07d4-088ceef6aeac@linux.ibm.com>
Date:   Wed, 9 Aug 2023 18:04:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
From:   Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [RFC PATCH v2 net-next 4/6] net/smc: support max connections per
 lgr negotiation
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        jaka@linux.ibm.com, kgraul@linux.ibm.com, tonylu@linux.alibaba.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230807062720.20555-1-guangguan.wang@linux.alibaba.com>
 <20230807062720.20555-5-guangguan.wang@linux.alibaba.com>
In-Reply-To: <20230807062720.20555-5-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RBfh0SwSlACwIFuM_2r76JM0dfpu05Ae
X-Proofpoint-GUID: xXnQ-yTJUR8xr47gP5SpafooTOtbIVVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_13,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090141
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07.08.23 08:27, Guangguan Wang wrote:
> Support max connections per lgr negotiation for SMCR v2.1,
> which is one of smc v2.1 features.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
> ---
>   net/smc/af_smc.c   |  1 +
>   net/smc/smc_clc.c  | 41 +++++++++++++++++++++++++++++++++++++++--
>   net/smc/smc_clc.h  |  7 +++++--
>   net/smc/smc_core.c |  4 +++-
>   net/smc/smc_core.h |  5 +++++
>   net/smc/smc_llc.c  |  6 +++++-
>   6 files changed, 58 insertions(+), 6 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index fd58e25beddf..b95d3fd48c28 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1214,6 +1214,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
>   	memcpy(ini->peer_systemid, aclc->r0.lcl.id_for_peer, SMC_SYSTEMID_LEN);
>   	memcpy(ini->peer_gid, aclc->r0.lcl.gid, SMC_GID_SIZE);
>   	memcpy(ini->peer_mac, aclc->r0.lcl.mac, ETH_ALEN);
> +	ini->max_conns = SMC_RMBS_PER_LGR_MAX;
>   
>   	reason_code = smc_connect_rdma_v2_prepare(smc, aclc, ini);
>   	if (reason_code)
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index 4f6b69af2b80..e2b224063dcc 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -427,9 +427,17 @@ static int smc_clc_fill_fce(struct smc_clc_first_contact_ext_v2x *fce,
>   	fce->fce_v20.os_type = SMC_CLC_OS_LINUX;
>   	fce->fce_v20.release = ini->release_ver;
>   	memcpy(fce->fce_v20.hostname, smc_hostname, sizeof(smc_hostname));
> -	if (ini->is_smcd && ini->release_ver < SMC_RELEASE_1)
> +	if (ini->is_smcd && ini->release_ver < SMC_RELEASE_1) {
>   		ret = sizeof(struct smc_clc_first_contact_ext);
> +		goto out;
> +	}
> +
> +	if (ini->release_ver >= SMC_RELEASE_1) {
> +		if (!ini->is_smcd)
> +			fce->max_conns = ini->max_conns;
> +	}
>   
> +out:
>   	return ret;
>   }
>   
> @@ -931,8 +939,10 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>   				sizeof(struct smc_clc_smcd_gid_chid);
>   		}
>   	}
> -	if (smcr_indicated(ini->smc_type_v2))
> +	if (smcr_indicated(ini->smc_type_v2)) {
>   		memcpy(v2_ext->roce, ini->smcrv2.ib_gid_v2, SMC_GID_SIZE);
> +		v2_ext->max_conns = SMC_CONN_PER_LGR_MAX;
> +	}
>   
>   	pclc_base->hdr.length = htons(plen);
>   	memcpy(trl->eyecatcher, SMC_EYECATCHER, sizeof(SMC_EYECATCHER));
> @@ -1163,6 +1173,11 @@ int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
>   {
>   	struct smc_clc_v2_extension *pclc_v2_ext;
>   
> +	/* default max conn is SMC_RMBS_PER_LGR_MAX(255),
> +	 * which is the default value in smc v1 and v2.0.
> +	 */
> +	ini->max_conns = SMC_RMBS_PER_LGR_MAX;
> +
>   	if ((!(ini->smcd_version & SMC_V2) && !(ini->smcr_version & SMC_V2)) ||
>   	    ini->release_ver < SMC_RELEASE_1)
>   		return 0;
> @@ -1171,15 +1186,30 @@ int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
>   	if (!pclc_v2_ext)
>   		return SMC_CLC_DECL_NOV2EXT;
>   
> +	if (ini->smcr_version & SMC_V2) {
> +		ini->max_conns = min_t(u8, pclc_v2_ext->max_conns, SMC_CONN_PER_LGR_MAX);
> +		if (ini->max_conns < SMC_CONN_PER_LGR_MIN)
> +			return SMC_CLC_DECL_MAXCONNERR;
> +	}
> +
>   	return 0;
>   }
>   
>   int smc_clc_cli_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
>   				      struct smc_init_info *ini)
>   {
> +	struct smc_clc_first_contact_ext_v2x *fce_v2x =
> +		(struct smc_clc_first_contact_ext_v2x *)fce;
> +
>   	if (ini->release_ver < SMC_RELEASE_1)
>   		return 0;
>   
> +	if (!ini->is_smcd) {
> +		if (fce_v2x->max_conns < SMC_CONN_PER_LGR_MIN)
> +			return SMC_CLC_DECL_MAXCONNERR;
> +		ini->max_conns = fce_v2x->max_conns;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -1190,6 +1220,8 @@ int smc_clc_v2x_features_confirm_check(struct smc_clc_msg_accept_confirm *cclc,
>   		(struct smc_clc_msg_accept_confirm_v2 *)cclc;
>   	struct smc_clc_first_contact_ext *fce =
>   		smc_get_clc_first_contact_ext(clc_v2, ini->is_smcd);
> +	struct smc_clc_first_contact_ext_v2x *fce_v2x =
> +		(struct smc_clc_first_contact_ext_v2x *)fce;
>   
>   	if (cclc->hdr.version == SMC_V1 ||
>   	    !(cclc->hdr.typev2 & SMC_FIRST_CONTACT_MASK))
> @@ -1201,6 +1233,11 @@ int smc_clc_v2x_features_confirm_check(struct smc_clc_msg_accept_confirm *cclc,
>   	if (fce->release < SMC_RELEASE_1)
>   		return 0;
>   
> +	if (!ini->is_smcd) {
> +		if (fce_v2x->max_conns != ini->max_conns)
> +			return SMC_CLC_DECL_MAXCONNERR;
> +	}
> +
>   	return 0;
>   }
>   
ok, now I have the answer from the last patch.

> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index 66932bfdc6d0..54077e50c368 100644
> --- a/net/smc/smc_clc.h
> +++ b/net/smc/smc_clc.h
> @@ -46,6 +46,7 @@
>   #define SMC_CLC_DECL_NOSMCD2DEV	0x03030007  /* no SMC-Dv2 device found	      */
>   #define SMC_CLC_DECL_NOUEID	0x03030008  /* peer sent no UEID	      */
>   #define SMC_CLC_DECL_RELEASEERR	0x03030009  /* release version negotiate failed */
> +#define SMC_CLC_DECL_MAXCONNERR	0x0303000a  /* max connections negotiate failed */
>   #define SMC_CLC_DECL_MODEUNSUPP	0x03040000  /* smc modes do not match (R or D)*/
>   #define SMC_CLC_DECL_RMBE_EC	0x03050000  /* peer has eyecatcher in RMBE    */
>   #define SMC_CLC_DECL_OPTUNSUPP	0x03060000  /* fastopen sockopt not supported */
> @@ -134,7 +135,8 @@ struct smc_clc_smcd_gid_chid {
>   struct smc_clc_v2_extension {
>   	struct smc_clnt_opts_area_hdr hdr;
>   	u8 roce[16];		/* RoCEv2 GID */
> -	u8 reserved[16];
> +	u8 max_conns;
> +	u8 reserved[15];
>   	u8 user_eids[][SMC_MAX_EID_LEN];
>   };
>   
> @@ -236,7 +238,8 @@ struct smc_clc_first_contact_ext {
>   
>   struct smc_clc_first_contact_ext_v2x {
>   	struct smc_clc_first_contact_ext fce_v20;
> -	u8 reserved3[4];
> +	u8 max_conns; /* for SMC-R only */
> +	u8 reserved3[3];
>   	__be32 vendor_exp_options;
>   	u8 reserved4[8];
>   } __packed;		/* format defined in
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 6aa3db47a956..5de1fbaa6e28 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -895,9 +895,11 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
>   			lgr->uses_gateway = ini->smcrv2.uses_gateway;
>   			memcpy(lgr->nexthop_mac, ini->smcrv2.nexthop_mac,
>   			       ETH_ALEN);
> +			lgr->max_conns = ini->max_conns;
>   		} else {
>   			ibdev = ini->ib_dev;
>   			ibport = ini->ib_port;
> +			lgr->max_conns = SMC_RMBS_PER_LGR_MAX;


It is kind of confused sometimes SMC_RMBS_PER_LGR_MAX is used and 
sometimes SMC_CONN_PER_LGR_MAX. IMO, you can use SMC_CONN_PER_LGR_MAX in 
the patches series for the new feature, because they are the same value 
and the name is more suiable.

>   		}
>   		memcpy(lgr->pnet_id, ibdev->pnetid[ibport - 1],
>   		       SMC_MAX_PNETID_LEN);
> @@ -1890,7 +1892,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
>   		    (ini->smcd_version == SMC_V2 ||
>   		     lgr->vlan_id == ini->vlan_id) &&
>   		    (role == SMC_CLNT || ini->is_smcd ||
> -		    (lgr->conns_num < SMC_RMBS_PER_LGR_MAX &&
> +		    (lgr->conns_num < lgr->max_conns &&
>   		      !bitmap_full(lgr->rtokens_used_mask, SMC_RMBS_PER_LGR_MAX)))) {
>   			/* link group found */
>   			ini->first_contact_local = 0;
> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
> index 1a97fef39127..f4f7299c810a 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -22,6 +22,8 @@
>   #include "smc_ib.h"
>   
>   #define SMC_RMBS_PER_LGR_MAX	255	/* max. # of RMBs per link group */
> +#define SMC_CONN_PER_LGR_MAX	255	/* max. # of connections per link group */
> +#define SMC_CONN_PER_LGR_MIN	16	/* min. # of connections per link group */
>   
>   struct smc_lgr_list {			/* list of link group definition */
>   	struct list_head	list;
> @@ -331,6 +333,8 @@ struct smc_link_group {
>   			__be32			saddr;
>   						/* net namespace */
>   			struct net		*net;
> +			u8			max_conns;
> +						/* max conn can be assigned to lgr */
>   		};
>   		struct { /* SMC-D */
>   			u64			peer_gid;
> @@ -375,6 +379,7 @@ struct smc_init_info {
>   	u8			smc_type_v1;
>   	u8			smc_type_v2;
>   	u8			release_ver;
> +	u8			max_conns;
>   	u8			first_contact_peer;
>   	u8			first_contact_local;
>   	unsigned short		vlan_id;
> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index 90f0b60b196a..5347b62f1518 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c
> @@ -52,7 +52,8 @@ struct smc_llc_msg_confirm_link {	/* type 0x01 */
>   	u8 link_num;
>   	u8 link_uid[SMC_LGR_ID_SIZE];
>   	u8 max_links;
> -	u8 reserved[9];
> +	u8 max_conns;
> +	u8 reserved[8];
>   };
>   
>   #define SMC_LLC_FLAG_ADD_LNK_REJ	0x40
> @@ -472,6 +473,9 @@ int smc_llc_send_confirm_link(struct smc_link *link,
>   	confllc->link_num = link->link_id;
>   	memcpy(confllc->link_uid, link->link_uid, SMC_LGR_ID_SIZE);
>   	confllc->max_links = SMC_LLC_ADD_LNK_MAX_LINKS;
> +	if (link->lgr->smc_version == SMC_V2 &&
> +	    link->lgr->peer_smc_release >= SMC_RELEASE_1)
> +		confllc->max_conns = link->lgr->max_conns;
>   	/* send llc message */
>   	rc = smc_wr_tx_send(link, pend);
>   put_out:

Did I miss the negotiation process somewhere for the following scenario?
(Example 4 in the document)
Client 				Server
	Proposal(max conns(16))
	----------------------->

	Accept(max conns(32))
	<-----------------------

	Confirm(max conns(32))
	----------------------->
