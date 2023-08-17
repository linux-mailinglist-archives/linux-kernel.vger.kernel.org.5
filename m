Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E774C77F0A3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348281AbjHQGmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348290AbjHQGmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:42:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60582705;
        Wed, 16 Aug 2023 23:42:13 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37H6dCBB014061;
        Thu, 17 Aug 2023 06:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iLTriCjkEvXTomKLhnbO3EDvQ0A8Ws1GPxt3WEhml/o=;
 b=QOA/hGbHYm3CeL0yoWsk0XS/iNqBF48mZzhqjth9v7o+/EUeFCLBOA2PbG99u/MxvCjH
 oJ4bQIpMgNb5belsL1uHLwkx3h3ZWaIJiRsrynnT31HnSVciPDTAqyLyqj35AA1UIw8a
 LQBJDXh56Uq1CznXLI//Oco+nKIVpJLvarKcLTkI9FnCUnYmO3B1RCCKKkhDWlTnoV+W
 rFXjJjWWEFZrfSQiKqMmJ2C3xgKX+McynewqVfFLJwenPpegl/MPXhj0Cukz62nNnVNZ
 aXIu3e8NxJj1PhBu/rKuFj4so23ptClpZrpFHWqniFl6BoeZ4EteFLETzrH4yjrSrSw1 KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3she8088y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 06:42:08 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37H6dTdX015524;
        Thu, 17 Aug 2023 06:42:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3she8088x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 06:42:07 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37H5rJCn001078;
        Thu, 17 Aug 2023 06:42:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3semsym65f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 06:42:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37H6g36B58458622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 06:42:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7C0120040;
        Thu, 17 Aug 2023 06:42:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AA8020043;
        Thu, 17 Aug 2023 06:42:02 +0000 (GMT)
Received: from [9.171.82.18] (unknown [9.171.82.18])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 17 Aug 2023 06:42:01 +0000 (GMT)
Message-ID: <dcbb9692-0494-1161-d873-ef67b3e7cb6d@linux.ibm.com>
Date:   Thu, 17 Aug 2023 08:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 4/6] net/smc: support max connections per lgr
 negotiation
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        wenjia@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230816083328.95746-1-guangguan.wang@linux.alibaba.com>
 <20230816083328.95746-5-guangguan.wang@linux.alibaba.com>
From:   Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20230816083328.95746-5-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SsaboPCx85oN4JgfNITYDmmi0JnHFZiu
X-Proofpoint-GUID: 5qf9X7wy_l9edl9ro9Di1NwafDPd9gvo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170057
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/08/2023 10:33, Guangguan Wang wrote:
> Support max connections per lgr negotiation for SMCR v2.1,
> which is one of smc v2.1 features. Server makes decision for
> the final value of max conns based on the client preferred
> max conns and self-preferred max conns. Here use the minimum
> value of client preferred max conns and server preferred max
> conns.
> 
> Client                                     Server
>       Proposal(max conns(client preferred))
>       ------------------------------------>
> 
>       Accept(max conns(accepted value))
> accepted value=min(client preferred, server preferred)
>       <-----------------------------------
> 
>       Confirm(max conns(accepted value))
>       ----------------------------------->
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
> ---
>   net/smc/af_smc.c   |  1 +
>   net/smc/smc_clc.c  | 41 +++++++++++++++++++++++++++++++++++++++--
>   net/smc/smc_clc.h  |  7 +++++--
>   net/smc/smc_core.c |  4 +++-
>   net/smc/smc_core.h | 12 ++++++++++++
>   net/smc/smc_llc.c  |  6 +++++-
>   6 files changed, 65 insertions(+), 6 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 65c02b48331f..f7174135c74a 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1212,6 +1212,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
>   	memcpy(ini->peer_systemid, aclc->r0.lcl.id_for_peer, SMC_SYSTEMID_LEN);
>   	memcpy(ini->peer_gid, aclc->r0.lcl.gid, SMC_GID_SIZE);
>   	memcpy(ini->peer_mac, aclc->r0.lcl.mac, ETH_ALEN);
> +	ini->max_conns = SMC_CONN_PER_LGR_MAX;
>   
>   	reason_code = smc_connect_rdma_v2_prepare(smc, aclc, ini);
>   	if (reason_code)
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index f71b22e50be5..6609b06f000f 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -427,9 +427,17 @@ static int smc_clc_fill_fce(struct smc_clc_first_contact_ext_v2x *fce,
>   	fce->fce_v20.os_type = SMC_CLC_OS_LINUX;
>   	fce->fce_v20.release = ini->release_nr;
>   	memcpy(fce->fce_v20.hostname, smc_hostname, sizeof(smc_hostname));
> -	if (ini->is_smcd && ini->release_nr < SMC_RELEASE_1)
> +	if (ini->is_smcd && ini->release_nr < SMC_RELEASE_1) {
>   		ret = sizeof(struct smc_clc_first_contact_ext);
> +		goto out;
> +	}
> +
> +	if (ini->release_nr >= SMC_RELEASE_1) {
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
> +		v2_ext->max_conns = SMC_CONN_PER_LGR_PREFER;
> +	}
>   
>   	pclc_base->hdr.length = htons(plen);
>   	memcpy(trl->eyecatcher, SMC_EYECATCHER, sizeof(SMC_EYECATCHER));
> @@ -1163,6 +1173,11 @@ int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
>   {
>   	struct smc_clc_v2_extension *pclc_v2_ext;
>   
> +	/* default max conn is SMC_CONN_PER_LGR_MAX(255),
> +	 * which is the default value in smc v1 and v2.0.
> +	 */

I'm afraid this comment is not going to age well. You already put this 
to the define itself so i plea to remove it here.

Thank you.
- Jan

> +	ini->max_conns = SMC_CONN_PER_LGR_MAX;
> +
>   	if ((!(ini->smcd_version & SMC_V2) && !(ini->smcr_version & SMC_V2)) ||
>   	    ini->release_nr < SMC_RELEASE_1)
>   		return 0;
> @@ -1171,15 +1186,30 @@ int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
>   	if (!pclc_v2_ext)
>   		return SMC_CLC_DECL_NOV2EXT;
>   
> +	if (ini->smcr_version & SMC_V2) {
> +		ini->max_conns = min_t(u8, pclc_v2_ext->max_conns, SMC_CONN_PER_LGR_PREFER);
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
>   	if (ini->release_nr < SMC_RELEASE_1)
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
> index 6aa3db47a956..a8091a3e6cdd 100644
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
> +			lgr->max_conns = SMC_CONN_PER_LGR_MAX;
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
> index b6c68db61f23..32b199477ef3 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -22,6 +22,15 @@
>   #include "smc_ib.h"
>   
>   #define SMC_RMBS_PER_LGR_MAX	255	/* max. # of RMBs per link group */
> +#define SMC_CONN_PER_LGR_MIN	16	/* min. # of connections per link group */
> +#define SMC_CONN_PER_LGR_MAX	255	/* max. # of connections per link group,
> +					 * also is the default value for SMC-R v1 and v2.0
> +					 */
> +#define SMC_CONN_PER_LGR_PREFER	255	/* Preferred connections per link group used for
> +					 * SMC-R v2.1 and later negotiation, vendors or
> +					 * distrubutions may modify it to a value between
> +					 * 16-255 as needed.
> +					 */
>   
>   struct smc_lgr_list {			/* list of link group definition */
>   	struct list_head	list;
> @@ -331,6 +340,8 @@ struct smc_link_group {
>   			__be32			saddr;
>   						/* net namespace */
>   			struct net		*net;
> +			u8			max_conns;
> +						/* max conn can be assigned to lgr */
>   		};
>   		struct { /* SMC-D */
>   			u64			peer_gid;
> @@ -375,6 +386,7 @@ struct smc_init_info {
>   	u8			smc_type_v1;
>   	u8			smc_type_v2;
>   	u8			release_nr;
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
