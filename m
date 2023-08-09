Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531967764A2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjHIQEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjHIQD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:03:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C74B1BD9;
        Wed,  9 Aug 2023 09:03:58 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379FxHCs016223;
        Wed, 9 Aug 2023 16:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XQEOLhyeZA2CAGyMflTobdYgDV1gAMa13Hpv99RXsFU=;
 b=cjhlIjEtL/YT5vE0HH+z+Px6vIChpn6T7mJeehyYlJ1MWXcbItwrYaCMyWoguKRDYUdG
 S7GRI5y80bePMMl4cB++WvceCq2kpR9JtCpJRyjq1AgbCZ0Z4h0eyZ9+jaTHsCXdXZ9u
 zf2QbmdazJvFV/9s5B0SclL9MMni+dGBzVw80iCRa/l56/6HecJxalqpOTDB6xxYgNKS
 R2i+BFwusjPYT2/FBjkhrFHD7IdFK+OkGcvGQvosGKivPmNchnQp38CbLZIgUQEjcVK1
 3Unoa6leZaAOw6jQxgO8Fa7MaCQ0LNynFIsGRqVM+JMQpprF17NAaKW6imLLyC5gMDL3 qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scdwt0369-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 16:03:46 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 379G03A8017504;
        Wed, 9 Aug 2023 16:03:45 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scdwt035v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 16:03:45 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 379EfLhv007543;
        Wed, 9 Aug 2023 16:03:44 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa14yj0xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 16:03:44 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 379G3hSq24445596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Aug 2023 16:03:43 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AA485803F;
        Wed,  9 Aug 2023 16:03:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C30E58060;
        Wed,  9 Aug 2023 16:03:41 +0000 (GMT)
Received: from [9.171.35.46] (unknown [9.171.35.46])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  9 Aug 2023 16:03:41 +0000 (GMT)
Message-ID: <ecafff58-c93a-5592-ddaa-d8724cf6bdcc@linux.ibm.com>
Date:   Wed, 9 Aug 2023 18:03:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
From:   Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [RFC PATCH v2 net-next 1/6] net/smc: support smc release version
 negotiation in clc handshake
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        jaka@linux.ibm.com, kgraul@linux.ibm.com, tonylu@linux.alibaba.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230807062720.20555-1-guangguan.wang@linux.alibaba.com>
 <20230807062720.20555-2-guangguan.wang@linux.alibaba.com>
In-Reply-To: <20230807062720.20555-2-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x5EylmUXVUkZtT6R8sqgwCByLOEuWFtQ
X-Proofpoint-ORIG-GUID: GwaGRFOZFGiomFznRO1JC_T985rnyEce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_13,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1011 mlxlogscore=999
 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090137
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
> Support smc release version negotiation in clc handshake. And set
> the latest smc release version to 2.1.
> 

Could you elaborate the changes? Without reading code, it is really 
difficult to know what you did, and why you did it. Sure, one can read 
the code and the support document, but the commit message should always 
be the quick reference. The following information I missed especially:
- This implementation is based on SMCv2 where no negotiation process for 
different releases, but for different versions.
- The Server makes the decision for which release will be used.

> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
> ---
>   net/smc/af_smc.c   | 22 ++++++++++++++++++++--
>   net/smc/smc.h      |  5 ++++-
>   net/smc/smc_clc.c  | 14 +++++++-------
>   net/smc/smc_clc.h  | 23 ++++++++++++++++++++++-
>   net/smc/smc_core.h |  1 +
>   5 files changed, 54 insertions(+), 11 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index a7f887d91d89..bac73eb0542d 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1187,6 +1187,11 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>   			return SMC_CLC_DECL_NOINDIRECT;
>   		}
>   	}
> +
> +	if (fce->release > SMC_RELEASE)
> +		return SMC_CLC_DECL_VERSMISMAT;
I'm wondering if this check is necessary, how it could happen?

> +	ini->release_ver = fce->release;
> +
>   	return 0;
>   }
>   
> @@ -1355,6 +1360,15 @@ static int smc_connect_ism(struct smc_sock *smc,
>   		struct smc_clc_msg_accept_confirm_v2 *aclc_v2 =
>   			(struct smc_clc_msg_accept_confirm_v2 *)aclc;
>   
> +		if (ini->first_contact_peer) {
> +			struct smc_clc_first_contact_ext *fce =
> +				smc_get_clc_first_contact_ext(aclc_v2, true);
> +
> +			if (fce->release > SMC_RELEASE)
> +				return SMC_CLC_DECL_VERSMISMAT;
> +			ini->release_ver = fce->release;
> +		}
> +
>   		rc = smc_v2_determine_accepted_chid(aclc_v2, ini);
>   		if (rc)
>   			return rc;
> @@ -1389,7 +1403,7 @@ static int smc_connect_ism(struct smc_sock *smc,
>   	}
>   
>   	rc = smc_clc_send_confirm(smc, ini->first_contact_local,
> -				  aclc->hdr.version, eid, NULL);
> +				  aclc->hdr.version, eid, ini);
>   	if (rc)
>   		goto connect_abort;
>   	mutex_unlock(&smc_server_lgr_pending);
> @@ -1965,6 +1979,10 @@ static int smc_listen_v2_check(struct smc_sock *new_smc,
>   		}
>   	}
>   
> +	ini->release_ver = pclc_v2_ext->hdr.flag.release;
> +	if (pclc_v2_ext->hdr.flag.release > SMC_RELEASE)
> +		ini->release_ver = SMC_RELEASE;
> +
>   out:
>   	if (!ini->smcd_version && !ini->smcr_version)
>   		return rc;
> @@ -2412,7 +2430,7 @@ static void smc_listen_work(struct work_struct *work)
>   	/* send SMC Accept CLC message */
>   	accept_version = ini->is_smcd ? ini->smcd_version : ini->smcr_version;
>   	rc = smc_clc_send_accept(new_smc, ini->first_contact_local,
> -				 accept_version, ini->negotiated_eid);
> +				 accept_version, ini->negotiated_eid, ini);
>   	if (rc)
>   		goto out_unlock;
>   
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 2eeea4cdc718..9cce1a41e011 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -21,7 +21,10 @@
>   
>   #define SMC_V1		1		/* SMC version V1 */
>   #define SMC_V2		2		/* SMC version V2 */
> -#define SMC_RELEASE	0
> +
> +#define SMC_RELEASE_0 0
> +#define SMC_RELEASE_1 1
> +#define SMC_RELEASE	SMC_RELEASE_1 /* the latest release version */
>   
>   #define SMCPROTO_SMC		0	/* SMC protocol, IPv4 */
>   #define SMCPROTO_SMC6		1	/* SMC protocol, IPv6 */
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index b9b8b07aa702..4ae27bf65732 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -420,11 +420,11 @@ smc_clc_msg_decl_valid(struct smc_clc_msg_decline *dclc)
>   	return true;
>   }
>   
> -static void smc_clc_fill_fce(struct smc_clc_first_contact_ext *fce, int *len)
> +static void smc_clc_fill_fce(struct smc_clc_first_contact_ext *fce, int *len, int release_ver)
>   {
>   	memset(fce, 0, sizeof(*fce));
>   	fce->os_type = SMC_CLC_OS_LINUX;
> -	fce->release = SMC_RELEASE;
> +	fce->release = release_ver;
>   	memcpy(fce->hostname, smc_hostname, sizeof(smc_hostname));
>   	(*len) += sizeof(*fce);
>   }

Personally I'd like release_nr instead of release_ver.

> @@ -1019,7 +1019,7 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>   				memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
>   			len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
>   			if (first_contact)
> -				smc_clc_fill_fce(&fce, &len);
> +				smc_clc_fill_fce(&fce, &len, ini->release_ver);
>   			clc_v2->hdr.length = htons(len);
>   		}
>   		memcpy(trl.eyecatcher, SMCD_EYECATCHER,
> @@ -1063,10 +1063,10 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>   				memcpy(clc_v2->r1.eid, eid, SMC_MAX_EID_LEN);
>   			len = SMCR_CLC_ACCEPT_CONFIRM_LEN_V2;
>   			if (first_contact) {
> -				smc_clc_fill_fce(&fce, &len);
> +				smc_clc_fill_fce(&fce, &len, ini->release_ver);
>   				fce.v2_direct = !link->lgr->uses_gateway;
>   				memset(&gle, 0, sizeof(gle));
> -				if (ini && clc->hdr.type == SMC_CLC_CONFIRM) {
> +				if (clc->hdr.type == SMC_CLC_CONFIRM) {
>   					gle.gid_cnt = ini->smcrv2.gidlist.len;
>   					len += sizeof(gle);
>   					len += gle.gid_cnt * sizeof(gle.gid[0]);
> @@ -1141,7 +1141,7 @@ int smc_clc_send_confirm(struct smc_sock *smc, bool clnt_first_contact,
>   
>   /* send CLC ACCEPT message across internal TCP socket */
>   int smc_clc_send_accept(struct smc_sock *new_smc, bool srv_first_contact,
> -			u8 version, u8 *negotiated_eid)
> +			u8 version, u8 *negotiated_eid, struct smc_init_info *ini)
>   {
>   	struct smc_clc_msg_accept_confirm_v2 aclc_v2;
>   	int len;
> @@ -1149,7 +1149,7 @@ int smc_clc_send_accept(struct smc_sock *new_smc, bool srv_first_contact,
>   	memset(&aclc_v2, 0, sizeof(aclc_v2));
>   	aclc_v2.hdr.type = SMC_CLC_ACCEPT;
>   	len = smc_clc_send_confirm_accept(new_smc, &aclc_v2, srv_first_contact,
> -					  version, negotiated_eid, NULL);
> +					  version, negotiated_eid, ini);
>   	if (len < ntohs(aclc_v2.hdr.length))
>   		len = len >= 0 ? -EPROTO : -new_smc->clcsock->sk->sk_err;
>   
> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index 5fee545c9a10..b923e89acafb 100644
> --- a/net/smc/smc_clc.h
> +++ b/net/smc/smc_clc.h
> @@ -370,6 +370,27 @@ smc_get_clc_smcd_v2_ext(struct smc_clc_v2_extension *prop_v2ext)
>   		 ntohs(prop_v2ext->hdr.smcd_v2_ext_offset));
>   }
>   
> +static inline struct smc_clc_first_contact_ext *
> +smc_get_clc_first_contact_ext(struct smc_clc_msg_accept_confirm_v2 *clc_v2,
> +			      bool is_smcd)
> +{
> +	int clc_v2_len;
> +
> +	if (clc_v2->hdr.version == SMC_V1 ||
> +	    !(clc_v2->hdr.typev2 & SMC_FIRST_CONTACT_MASK))
> +		return NULL;
> +
> +	if (is_smcd)
> +		clc_v2_len =
> +			offsetofend(struct smc_clc_msg_accept_confirm_v2, d1);
> +	else
> +		clc_v2_len =
> +			offsetofend(struct smc_clc_msg_accept_confirm_v2, r1);
> +
> +	return (struct smc_clc_first_contact_ext *)(((u8 *)clc_v2) +
> +						    clc_v2_len);
> +}
> +
>   struct smcd_dev;
>   struct smc_init_info;
>   
> @@ -382,7 +403,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini);
>   int smc_clc_send_confirm(struct smc_sock *smc, bool clnt_first_contact,
>   			 u8 version, u8 *eid, struct smc_init_info *ini);
>   int smc_clc_send_accept(struct smc_sock *smc, bool srv_first_contact,
> -			u8 version, u8 *negotiated_eid);
> +			u8 version, u8 *negotiated_eid, struct smc_init_info *ini);
>   void smc_clc_init(void) __init;
>   void smc_clc_exit(void);
>   void smc_clc_get_hostname(u8 **host);
> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
> index 3c1b31bfa1cf..1a97fef39127 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -374,6 +374,7 @@ struct smc_init_info {
>   	u8			is_smcd;
>   	u8			smc_type_v1;
>   	u8			smc_type_v2;
> +	u8			release_ver;

Also here, I'd like release_nr more.

>   	u8			first_contact_peer;
>   	u8			first_contact_local;
>   	unsigned short		vlan_id;
