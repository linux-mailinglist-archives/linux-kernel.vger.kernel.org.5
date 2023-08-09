Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B9A7764B6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjHIQJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjHIQJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:09:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE542680;
        Wed,  9 Aug 2023 09:09:14 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379G7ktK004035;
        Wed, 9 Aug 2023 16:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LN5Zb3Vc0Y8jm1fVsbeUigz9bkqKg7MAalmXR700Ttc=;
 b=XRmrYs7FY3I9ncEr7N/jmzmXyb7fbvFCQXAirXsZ4s8oy096s5zkkgesd+E5jj4uvm7j
 1nBsP7eSIzJ2S0v100FmnlX/Zq0QrQyQsIFomOKklQCGdizV4ql9CrhiwChC5rR3S4YW
 UCz5stBj3xiuLaq79lwXXxSBLcvJGqeE7p8u7XnnjOHbF2o7Q8UwAY/0Rb6sZZPPyacP
 6jTAtxWElHuXAT2+YbeSchIfGbdlppWVCIHDSCJ397KppjvA9oA9SUfCCj/XKvxWkJqX
 hzjqAJalWLs35+U5wgfLapGMUHN5HYoFL/qOls2/Nj8UaTlNraKzchUbLp7dRYxyG+kJ iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scdub08jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 16:09:05 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 379G94or009774;
        Wed, 9 Aug 2023 16:09:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scdub08hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 16:09:04 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 379EoCX5007592;
        Wed, 9 Aug 2023 16:04:03 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa14yj115-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 16:04:03 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 379G42BS58261964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Aug 2023 16:04:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E9A858061;
        Wed,  9 Aug 2023 16:04:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D34E75803F;
        Wed,  9 Aug 2023 16:03:59 +0000 (GMT)
Received: from [9.171.35.46] (unknown [9.171.35.46])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  9 Aug 2023 16:03:59 +0000 (GMT)
Message-ID: <1f162370-5878-80fc-25b9-0de22ba2efe1@linux.ibm.com>
Date:   Wed, 9 Aug 2023 18:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
From:   Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [RFC PATCH v2 net-next 3/6] net/smc: support smc v2.x features
 validate
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        jaka@linux.ibm.com, kgraul@linux.ibm.com, tonylu@linux.alibaba.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230807062720.20555-1-guangguan.wang@linux.alibaba.com>
 <20230807062720.20555-4-guangguan.wang@linux.alibaba.com>
In-Reply-To: <20230807062720.20555-4-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Dk60hfIM7WMLVyIwTPrVMvzL9-4FWYlc
X-Proofpoint-GUID: C28bjvl1b9fYCPbwxmzHypwfXbg_-MWR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_13,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090142
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
> Support smc v2.x features validate for smc v2.1.
> 
a bit more description?

> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
> ---
>   net/smc/af_smc.c  | 18 ++++++++++++++++++
>   net/smc/smc_clc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>   net/smc/smc_clc.h |  7 +++++++
>   3 files changed, 71 insertions(+)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 52279bdc100a..fd58e25beddf 100644
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
> @@ -1191,6 +1192,9 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>   	if (fce->release > SMC_RELEASE)
>   		return SMC_CLC_DECL_VERSMISMAT;
>   	ini->release_ver = fce->release;
> +	rc = smc_clc_cli_v2x_features_validate(fce, ini);
> +	if (rc)
> +		return rc;
>   
>   	return 0;
>   }
> @@ -1367,6 +1371,9 @@ static int smc_connect_ism(struct smc_sock *smc,
>   			if (fce->release > SMC_RELEASE)
>   				return SMC_CLC_DECL_VERSMISMAT;
>   			ini->release_ver = fce->release;
> +			rc = smc_clc_cli_v2x_features_validate(fce, ini);
> +			if (rc)
> +				return rc;
>   		}
>   
>   		rc = smc_v2_determine_accepted_chid(aclc_v2, ini);
> @@ -2417,6 +2424,10 @@ static void smc_listen_work(struct work_struct *work)
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
> @@ -2449,6 +2460,13 @@ static void smc_listen_work(struct work_struct *work)
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
> index ae80c191a834..4f6b69af2b80 100644
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
> +	    ini->release_ver < SMC_RELEASE_1)
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
> +	if (ini->release_ver < SMC_RELEASE_1)
> +		return 0;
> +
> +	return 0;
> +}

Why need the function? Since it returns 0 anyway.
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
> +	if (ini->release_ver != fce->release)
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
