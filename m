Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039637FD71A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjK2MuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjK2MuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:50:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8263310C3;
        Wed, 29 Nov 2023 04:50:18 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATCgY8c029708;
        Wed, 29 Nov 2023 12:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EzA4WwZlpTwtLpc5qn5yjI1HnJlLlVE5vgC5PGKaOBM=;
 b=bxkMzhdklcpQFW3l91VpLaA8ddFD/8n0EfkLQxnljtCN9YXAJr4LXfElHz3o/IcoMYQE
 0+Y3GBmvkhW+3n5DwX2aOO1iOoLKmTTagqZWfTTt1OwHTMX2MYp5UDMXBcQsvFLmrx0n
 ihIURn8y02UODoCX6ncOcGsHKgD2I9VK/HMLpJkZbIZSto0WhU9axCC98HvPnimfo7Jw
 IM/W/htJbco8MHDAwHM8wNdIL1GW/cl/xE7TIgTpuBMx+gZlfo1xSRYY1ZTcLdtBAoM8
 QS+sBS8vQJOk0H3eTgNnUsZdWhHA1BP8S+5xiKq5yAXoqgMbK4gkkARXyQpaYlKyP1Wr qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up5hn09b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 12:50:15 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ATChIZT032157;
        Wed, 29 Nov 2023 12:50:14 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up5hn099h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 12:50:14 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATB4D6r018149;
        Wed, 29 Nov 2023 12:50:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukv8nq77u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 12:50:13 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ATCoCKF17826364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2023 12:50:12 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37EA158065;
        Wed, 29 Nov 2023 12:50:12 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3830C58063;
        Wed, 29 Nov 2023 12:50:09 +0000 (GMT)
Received: from [9.171.77.152] (unknown [9.171.77.152])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 29 Nov 2023 12:50:09 +0000 (GMT)
Message-ID: <298442c7-40f0-42ab-b5cb-07603d8689f5@linux.ibm.com>
Date:   Wed, 29 Nov 2023 13:50:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [PATCH net-next v2 1/7] net/smc: Rename some variable 'fce' to
 'fce_v2x' for clarity
To:     Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1700836935-23819-1-git-send-email-guwen@linux.alibaba.com>
 <1700836935-23819-2-git-send-email-guwen@linux.alibaba.com>
Content-Language: en-GB
In-Reply-To: <1700836935-23819-2-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2r_HYvL8MltjZR7VOzGrzQ4JLhEgCung
X-Proofpoint-GUID: diyUylKDQAoWfFRPB-qKbn5Dw4u8iuRo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_09,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.11.23 15:42, Wen Gu wrote:
> Rename some smc_clc_first_contact_ext_v2x type variables to 'fce_v2x'
> to distinguish them from smc_clc_first_contact_ext type variables.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/smc_clc.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index 0fda515..c41a249 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -418,15 +418,15 @@ static bool smc_clc_msg_prop_valid(struct smc_clc_msg_proposal *pclc)
>   	return true;
>   }
>   
> -static int smc_clc_fill_fce(struct smc_clc_first_contact_ext_v2x *fce,
> +static int smc_clc_fill_fce(struct smc_clc_first_contact_ext_v2x *fce_v2x,
>   			    struct smc_init_info *ini)

Since this function is only used by v2.x, IMO, this function name could 
also be changed to e.g. smc_clc_fill_fce_v2x.
>   {
> -	int ret = sizeof(*fce);
> +	int ret = sizeof(*fce_v2x);
>   
> -	memset(fce, 0, sizeof(*fce));
> -	fce->fce_v2_base.os_type = SMC_CLC_OS_LINUX;
> -	fce->fce_v2_base.release = ini->release_nr;
> -	memcpy(fce->fce_v2_base.hostname, smc_hostname, sizeof(smc_hostname));
> +	memset(fce_v2x, 0, sizeof(*fce_v2x));
> +	fce_v2x->fce_v2_base.os_type = SMC_CLC_OS_LINUX;
> +	fce_v2x->fce_v2_base.release = ini->release_nr;
> +	memcpy(fce_v2x->fce_v2_base.hostname, smc_hostname, sizeof(smc_hostname));
>   	if (ini->is_smcd && ini->release_nr < SMC_RELEASE_1) {
>   		ret = sizeof(struct smc_clc_first_contact_ext);
>   		goto out;
> @@ -434,8 +434,8 @@ static int smc_clc_fill_fce(struct smc_clc_first_contact_ext_v2x *fce,
>   
>   	if (ini->release_nr >= SMC_RELEASE_1) {
>   		if (!ini->is_smcd) {
> -			fce->max_conns = ini->max_conns;
> -			fce->max_links = ini->max_links;
> +			fce_v2x->max_conns = ini->max_conns;
> +			fce_v2x->max_links = ini->max_links;
>   		}
>   	}
>   
> @@ -1003,8 +1003,8 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>   				       int first_contact, u8 version,
>   				       u8 *eid, struct smc_init_info *ini)
>   {
> +	struct smc_clc_first_contact_ext_v2x fce_v2x;
>   	struct smc_connection *conn = &smc->conn;
> -	struct smc_clc_first_contact_ext_v2x fce;
>   	struct smc_clc_msg_accept_confirm *clc;
>   	struct smc_clc_fce_gid_ext gle;
>   	struct smc_clc_msg_trail trl;
> @@ -1037,7 +1037,7 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>   				memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
>   			len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
>   			if (first_contact) {
> -				fce_len = smc_clc_fill_fce(&fce, ini);
> +				fce_len = smc_clc_fill_fce(&fce_v2x, ini);
>   				len += fce_len;
>   			}
>   			clc_v2->hdr.length = htons(len);
> @@ -1083,9 +1083,9 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>   				memcpy(clc_v2->r1.eid, eid, SMC_MAX_EID_LEN);
>   			len = SMCR_CLC_ACCEPT_CONFIRM_LEN_V2;
>   			if (first_contact) {
> -				fce_len = smc_clc_fill_fce(&fce, ini);
> +				fce_len = smc_clc_fill_fce(&fce_v2x, ini);
>   				len += fce_len;
> -				fce.fce_v2_base.v2_direct = !link->lgr->uses_gateway;
> +				fce_v2x.fce_v2_base.v2_direct = !link->lgr->uses_gateway;
>   				if (clc->hdr.type == SMC_CLC_CONFIRM) {
>   					memset(&gle, 0, sizeof(gle));
>   					gle.gid_cnt = ini->smcrv2.gidlist.len;
> @@ -1112,7 +1112,7 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>   						SMCR_CLC_ACCEPT_CONFIRM_LEN) -
>   				   sizeof(trl);
>   	if (version > SMC_V1 && first_contact) {
> -		vec[i].iov_base = &fce;
> +		vec[i].iov_base = &fce_v2x;
>   		vec[i++].iov_len = fce_len;
>   		if (!conn->lgr->is_smcd) {
>   			if (clc->hdr.type == SMC_CLC_CONFIRM) {
