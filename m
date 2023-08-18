Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09457813B3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379801AbjHRTnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379863AbjHRTmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:42:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD7049CA;
        Fri, 18 Aug 2023 12:41:35 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IJYBhk009775;
        Fri, 18 Aug 2023 19:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=03YW9tQ9QrxfsGADva+yPv6ebdTtC8yWARZR3tHcstY=;
 b=e59uGDQHtPanu/pM5Io3+BgTOM9Ph6FInJFw97PmiVskADcT/orTqUulsJ9XbiECXEoE
 Z1lgjPY7VY6Izz5MkqeOA0IFEzHtoIWKHurALC1frN0fwr1rhZiMDkahiI6FH78/yPUS
 Z4B0n1EJD6Yx/HE0cUedIhyWOPHigUur0szOh2G2wizVBhFB/63Y3B2Cy3XsUwDn0aPr
 JoNNJTe8cmvfMDK9x1SDjPqRfGEfaHhggg3mE2xRBeva2tFrL6jSjIWf/H4fRQ5PjZ8a
 ygDSrmBFOVdpjWmj4wRV9MuyXmOVdFad8jl4yWoJhGT1s7k8NhObYhC4/axhDwDbJsc9 RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjeavgt00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 19:41:30 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IJT4V4030954;
        Fri, 18 Aug 2023 19:41:30 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjeavgsyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 19:41:30 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37IHQu86013500;
        Fri, 18 Aug 2023 19:41:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sepmkh49a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 19:41:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37IJfQrv43843900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 19:41:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8342B2004F;
        Fri, 18 Aug 2023 19:41:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF10120040;
        Fri, 18 Aug 2023 19:41:25 +0000 (GMT)
Received: from [9.179.22.225] (unknown [9.179.22.225])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 18 Aug 2023 19:41:25 +0000 (GMT)
Message-ID: <6f6ee3e4-6a17-fef0-20a7-6bd052afd22f@linux.ibm.com>
Date:   Fri, 18 Aug 2023 21:41:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v2 3/6] net/smc: support smc v2.x features
 validate
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        wenjia@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230817132032.23397-1-guangguan.wang@linux.alibaba.com>
 <20230817132032.23397-4-guangguan.wang@linux.alibaba.com>
From:   Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20230817132032.23397-4-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MH8eRSAE8xxE1pH7udOYltyEM6X9yjPq
X-Proofpoint-ORIG-GUID: q_vfe3E8LeFPYl3HYYM5XPfCLBIfE6Gb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_24,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180178
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/08/2023 15:20, Guangguan Wang wrote:
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
> For client, v2.x features' validation should be done in smc_clc_clnt_
> v2x_features_validate when receiving v2.1 or later CLC Accept Message,
> for example, the decision to accpt the accepted value or to decline
> should be made in this function.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>

Thank you for your contribution, Guangguan.

Reviewed-by: Jan Karcher <jaka@linux.ibm.com>

> ---
>   net/smc/af_smc.c  | 18 ++++++++++++++++++
>   net/smc/smc_clc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>   net/smc/smc_clc.h |  7 +++++++
>   3 files changed, 71 insertions(+)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 10bec585983f..9174dedd9b3b 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1168,6 +1168,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>   		(struct smc_clc_msg_accept_confirm_v2 *)aclc;
>   	struct smc_clc_first_contact_ext *fce =
>   		smc_get_clc_first_contact_ext(clc_v2, false);
> +	int rc;
>   
>   	if (!ini->first_contact_peer || aclc->hdr.version == SMC_V1)
>   		return 0;
> @@ -1188,6 +1189,9 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>   	}
>   
>   	ini->release_nr = fce->release;
> +	rc = smc_clc_clnt_v2x_features_validate(fce, ini);
> +	if (rc)
> +		return rc;
>   
>   	return 0;
>   }
> @@ -1362,6 +1366,9 @@ static int smc_connect_ism(struct smc_sock *smc,
>   				smc_get_clc_first_contact_ext(aclc_v2, true);
>   
>   			ini->release_nr = fce->release;
> +			rc = smc_clc_clnt_v2x_features_validate(fce, ini);
> +			if (rc)
> +				return rc;
>   		}
>   
>   		rc = smc_v2_determine_accepted_chid(aclc_v2, ini);
> @@ -2412,6 +2419,10 @@ static void smc_listen_work(struct work_struct *work)
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
> @@ -2444,6 +2455,13 @@ static void smc_listen_work(struct work_struct *work)
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
> index 728f88616266..d3c892ee7177 100644
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
> +int smc_clc_clnt_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
> +				       struct smc_init_info *ini)
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
> index bd75382f374d..552d0656252c 100644
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
> +int smc_clc_clnt_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
> +				       struct smc_init_info *ini);
> +int smc_clc_v2x_features_confirm_check(struct smc_clc_msg_accept_confirm *cclc,
> +				       struct smc_init_info *ini);
>   void smc_clc_init(void) __init;
>   void smc_clc_exit(void);
>   void smc_clc_get_hostname(u8 **host);
