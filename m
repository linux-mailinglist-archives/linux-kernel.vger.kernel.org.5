Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8DF77F0A7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348288AbjHQGmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348284AbjHQGmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:42:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59932712;
        Wed, 16 Aug 2023 23:42:21 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37H6MBQe032610;
        Thu, 17 Aug 2023 06:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=eP8BrrK0OzB+TYK489u9f3/W5cYO6XPo52Es/2tdiIA=;
 b=gvbkukIC5hnIGo30bsClABk9Xrl11OcRDDPKSdMoJELxKIZaIBjXzjMunVJMMeckU5hJ
 oVuwcZbn816Yvuys9UjjuUlHNc3qGeX4/JAVi9mvDX3sBsFXEiKdHBhQAB20Rnflsa16
 S+84Pyu5X1+c1GAiN8ig+X6AzcBUhYTSbTiopBIP5P+IjQtpXlb0VkSDTzPF2M89TNvU
 /jUjPq4XYQ2vCGt+E7C3xf0Zjy/zWBqFOfFz9J2ATNuUMNFBf2TDhDKFCbCRL3REuJ54
 g4d16HrBfuPt80A3ojmJC/GTd4e37PeqDAZrVtXRXGy8SuNN9IGDB2TgV1QCZy4AJHYr gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3she79rgg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 06:42:16 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37H6Mbpf001199;
        Thu, 17 Aug 2023 06:42:16 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3she79rgfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 06:42:16 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37H5ulFV001073;
        Thu, 17 Aug 2023 06:42:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3semsym66c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 06:42:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37H6gCGc22217348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 06:42:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1450920040;
        Thu, 17 Aug 2023 06:42:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 363012004B;
        Thu, 17 Aug 2023 06:42:11 +0000 (GMT)
Received: from [9.171.82.18] (unknown [9.171.82.18])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 17 Aug 2023 06:42:11 +0000 (GMT)
Message-ID: <08e116ea-e907-0141-4766-c4c84cbd87d2@linux.ibm.com>
Date:   Thu, 17 Aug 2023 08:42:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 3/6] net/smc: support smc v2.x features validate
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        wenjia@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230816083328.95746-1-guangguan.wang@linux.alibaba.com>
 <20230816083328.95746-4-guangguan.wang@linux.alibaba.com>
From:   Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20230816083328.95746-4-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QUTHj9GbHIdiKk7ZSxNWjR_NuVf8j0ky
X-Proofpoint-ORIG-GUID: NssYzYI_upW2v_ekPpXecXOt_e4dKzUG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
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

Hi Guangguan Wang,

minor renaming.

On 16/08/2023 10:33, Guangguan Wang wrote:
> Support SMC v2.x features validate for SMC v2.1. This is the frame
> code for SMC v2.x features validate, and will take effects only when
> the negotiated release version is v2.1 or later.
> 
> For Server, v2.x features' validation should be done in smc_clc_srv_
> v2x_features_validate when receiving v2.1 or later CLC Proposal Message,
> such as max conns, max links negotiation, the decision of the final
> value of max conns and max links should be made in this function.
> And final check for server when receiving v2.1 or later CLC Confirm
> Message should be done in smc_clc_v2x_features_confirm_check.
> 
> For client, v2.x features' validation should be done in smc_clc_cli_
> v2x_features_validate when receiving v2.1 or later CLC Accept Message,

please use either clnt or client for the function. I know we have some 
functions with cli in them but they need to be cleaned up down the road.

Thank you.
- Jan

> for example, the decision to accpt the accepted value or to decline
> should be made in this function.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
> ---
>   net/smc/af_smc.c  | 18 ++++++++++++++++++
>   net/smc/smc_clc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>   net/smc/smc_clc.h |  7 +++++++
>   3 files changed, 71 insertions(+)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 7b54c153bd0d..65c02b48331f 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1169,6 +1169,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>   	struct smc_clc_first_contact_ext *fce =
>   		(struct smc_clc_first_contact_ext *)
>   			(((u8 *)clc_v2) + sizeof(*clc_v2));
> +	int rc;
>   
>   	if (!ini->first_contact_peer || aclc->hdr.version == SMC_V1)
>   		return 0;
> @@ -1189,6 +1190,9 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>   	}
>   
>   	ini->release_nr = fce->release;
> +	rc = smc_clc_cli_v2x_features_validate(fce, ini);
> +	if (rc)
> +		return rc;
>   
>   	return 0;
>   }
> @@ -1363,6 +1367,9 @@ static int smc_connect_ism(struct smc_sock *smc,
>   				smc_get_clc_first_contact_ext(aclc_v2, true);
>   
>   			ini->release_nr = fce->release;
> +			rc = smc_clc_cli_v2x_features_validate(fce, ini);
> +			if (rc)
> +				return rc;
>   		}
>   
>   		rc = smc_v2_determine_accepted_chid(aclc_v2, ini);
> @@ -2413,6 +2420,10 @@ static void smc_listen_work(struct work_struct *work)
>   	if (rc)
>   		goto out_decl;
>   
> +	rc = smc_clc_srv_v2x_features_validate(pclc, ini);
> +	if (rc)
> +		goto out_decl;
> +
>   	mutex_lock(&smc_server_lgr_pending);
>   	smc_close_init(new_smc);
>   	smc_rx_init(new_smc);
> @@ -2445,6 +2456,13 @@ static void smc_listen_work(struct work_struct *work)
>   		goto out_decl;
>   	}
>   
> +	rc = smc_clc_v2x_features_confirm_check(cclc, ini);
> +	if (rc) {
> +		if (!ini->is_smcd)
> +			goto out_unlock;
> +		goto out_decl;
> +	}
> +
>   	/* finish worker */
>   	if (!ini->is_smcd) {
>   		rc = smc_listen_rdma_finish(new_smc, cclc,
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index 624dc970d187..f71b22e50be5 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -1158,6 +1158,52 @@ int smc_clc_send_accept(struct smc_sock *new_smc, bool srv_first_contact,
>   	return len > 0 ? 0 : len;
>   }
>   
> +int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
> +				      struct smc_init_info *ini)
> +{
> +	struct smc_clc_v2_extension *pclc_v2_ext;
> +
> +	if ((!(ini->smcd_version & SMC_V2) && !(ini->smcr_version & SMC_V2)) ||
> +	    ini->release_nr < SMC_RELEASE_1)
> +		return 0;
> +
> +	pclc_v2_ext = smc_get_clc_v2_ext(pclc);
> +	if (!pclc_v2_ext)
> +		return SMC_CLC_DECL_NOV2EXT;
> +
> +	return 0;
> +}
> +
> +int smc_clc_cli_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
> +				      struct smc_init_info *ini)
> +{
> +	if (ini->release_nr < SMC_RELEASE_1)
> +		return 0;
> +
> +	return 0;
> +}
> +
> +int smc_clc_v2x_features_confirm_check(struct smc_clc_msg_accept_confirm *cclc,
> +				       struct smc_init_info *ini)
> +{
> +	struct smc_clc_msg_accept_confirm_v2 *clc_v2 =
> +		(struct smc_clc_msg_accept_confirm_v2 *)cclc;
> +	struct smc_clc_first_contact_ext *fce =
> +		smc_get_clc_first_contact_ext(clc_v2, ini->is_smcd);
> +
> +	if (cclc->hdr.version == SMC_V1 ||
> +	    !(cclc->hdr.typev2 & SMC_FIRST_CONTACT_MASK))
> +		return 0;
> +
> +	if (ini->release_nr != fce->release)
> +		return SMC_CLC_DECL_RELEASEERR;
> +
> +	if (fce->release < SMC_RELEASE_1)
> +		return 0;
> +
> +	return 0;
> +}
> +
>   void smc_clc_get_hostname(u8 **host)
>   {
>   	*host = &smc_hostname[0];
> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index 6133276a8839..66932bfdc6d0 100644
> --- a/net/smc/smc_clc.h
> +++ b/net/smc/smc_clc.h
> @@ -45,6 +45,7 @@
>   #define SMC_CLC_DECL_NOSEID	0x03030006  /* peer sent no SEID	      */
>   #define SMC_CLC_DECL_NOSMCD2DEV	0x03030007  /* no SMC-Dv2 device found	      */
>   #define SMC_CLC_DECL_NOUEID	0x03030008  /* peer sent no UEID	      */
> +#define SMC_CLC_DECL_RELEASEERR	0x03030009  /* release version negotiate failed */
>   #define SMC_CLC_DECL_MODEUNSUPP	0x03040000  /* smc modes do not match (R or D)*/
>   #define SMC_CLC_DECL_RMBE_EC	0x03050000  /* peer has eyecatcher in RMBE    */
>   #define SMC_CLC_DECL_OPTUNSUPP	0x03060000  /* fastopen sockopt not supported */
> @@ -415,6 +416,12 @@ int smc_clc_send_confirm(struct smc_sock *smc, bool clnt_first_contact,
>   			 u8 version, u8 *eid, struct smc_init_info *ini);
>   int smc_clc_send_accept(struct smc_sock *smc, bool srv_first_contact,
>   			u8 version, u8 *negotiated_eid, struct smc_init_info *ini);
> +int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
> +				      struct smc_init_info *ini);
> +int smc_clc_cli_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
> +				      struct smc_init_info *ini);
> +int smc_clc_v2x_features_confirm_check(struct smc_clc_msg_accept_confirm *cclc,
> +				       struct smc_init_info *ini);
>   void smc_clc_init(void) __init;
>   void smc_clc_exit(void);
>   void smc_clc_get_hostname(u8 **host);
