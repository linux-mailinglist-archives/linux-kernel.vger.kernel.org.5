Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2D977EC38
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346661AbjHPVuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346647AbjHPVtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:49:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4A42724;
        Wed, 16 Aug 2023 14:49:40 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GLfwVv004682;
        Wed, 16 Aug 2023 21:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=hNNANv15yH1Zo0ppvh9C2vzHLnZQ7emq5X0bG6j6a2g=;
 b=J/bFvHVZjzqWpcNegzK8rBuKqMfwyY00ds23RonSGhF9IAHb2e7dopoP8iMM7fgXFlZe
 GMVTXIff4EZKSoqV9TjNOqsthTjks4OCIpNGAyhJYekloFuZWcOc4d6ZfwMHyAcKfqdd
 rFU2ZMuB3l2Tsy+uUUY0drO5KtGvYcA8B/Z2dcxatFYnleLW8dG+zwQz1mv45oA5auOr
 dyAUSlYpyhtvaT4nKPx4lpgo75JuUUCKhPsDHH84jC5pGkR9A/m8ejQWCMg6PEOcsPAM
 4vqVD6xEVSnBVLOmWS2j5HpnMH6vlqtBbk4ppXYd9V9CCkUHZ+j8QfXFxnatLlHbpihq NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sh6kng4sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 21:49:36 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37GLjMab013828;
        Wed, 16 Aug 2023 21:49:36 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sh6kng4rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 21:49:36 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37GKPMtp018843;
        Wed, 16 Aug 2023 21:49:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3seq41r34b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 21:49:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37GLnWl944826976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 21:49:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A7472004E;
        Wed, 16 Aug 2023 21:49:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2313F20043;
        Wed, 16 Aug 2023 21:49:31 +0000 (GMT)
Received: from [9.171.14.142] (unknown [9.171.14.142])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 16 Aug 2023 21:49:31 +0000 (GMT)
Message-ID: <dc94f888-971b-dbc2-d417-9e14734266fc@linux.ibm.com>
Date:   Wed, 16 Aug 2023 23:49:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 2/6] net/smc: add vendor unique experimental
 options area in clc handshake
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        wenjia@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230816083328.95746-1-guangguan.wang@linux.alibaba.com>
 <20230816083328.95746-3-guangguan.wang@linux.alibaba.com>
From:   Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20230816083328.95746-3-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BKEyvAmLS58oCDRWxs_tkgqDMaSz8h__
X-Proofpoint-GUID: xUppBLtr5HCofeBo2z7Jj1FMezvY2OCR
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_18,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160192
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guangguan Wang,

thank you, some minor thoughts on this one.

On 16/08/2023 10:33, Guangguan Wang wrote:
> Add vendor unique experimental options area in clc handshake. In clc
> accept and confirm msg, vendor unique experimental options use the
> 16-Bytes reserved field, which defined in struct smc_clc_fce_gid_ext
> in previous version. Because of the struct smc_clc_first_contact_ext
> is widely used and limit the scope of modification, this patch moves
> the 16-Bytes reserved field out of struct smc_clc_fce_gid_ext, and
> followed with the struct smc_clc_first_contact_ext in a new struct
> names struct smc_clc_first_contact_ext_v2x.
> 
> For SMC-R first connection, in previous version, the struct smc_clc_
> first_contact_ext and the 16-Bytes reserved field has already been
> included in clc accept and confirm msg. Thus, this patch use struct
> smc_clc_first_contact_ext_v2x instead of the struct smc_clc_first_
> contact_ext and the 16-Bytes reserved field in SMC-R clc accept and
> confirm msg is compatible with previous version.
> 
> For SMC-D first connection, in previous version, only the struct smc_
> clc_first_contact_ext is included in clc accept and confirm msg, and
> the 16-Bytes reserved field is not included. Thus, when the negotiated
> smc release version is the version before v2.1, we still use struct
> smc_clc_first_contact_ext for compatible consideration. If the negotiated
> smc release version is v2.1 or later, use struct smc_clc_first_contact_
> ext_v2x instead.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
> ---
>   net/smc/af_smc.c  |  2 +-
>   net/smc/smc_clc.c | 44 +++++++++++++++++++++++---------------------
>   net/smc/smc_clc.h | 15 +++++++++++++--
>   3 files changed, 37 insertions(+), 24 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 97265691bc95..7b54c153bd0d 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1113,7 +1113,7 @@ static int smc_connect_ism_vlan_cleanup(struct smc_sock *smc,
>   
>   #define SMC_CLC_MAX_ACCEPT_LEN \
>   	(sizeof(struct smc_clc_msg_accept_confirm_v2) + \
> -	 sizeof(struct smc_clc_first_contact_ext) + \
> +	 sizeof(struct smc_clc_first_contact_ext_v2x) + \
>   	 sizeof(struct smc_clc_msg_trail))
>   
>   /* CLC handshake during connect */
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index 7c5627c6abcc..624dc970d187 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -391,9 +391,7 @@ smc_clc_msg_acc_conf_valid(struct smc_clc_msg_accept_confirm_v2 *clc_v2)
>   			return false;
>   	} else {
>   		if (hdr->typev1 == SMC_TYPE_D &&
> -		    ntohs(hdr->length) != SMCD_CLC_ACCEPT_CONFIRM_LEN_V2 &&
> -		    (ntohs(hdr->length) != SMCD_CLC_ACCEPT_CONFIRM_LEN_V2 +
> -				sizeof(struct smc_clc_first_contact_ext)))
> +		    ntohs(hdr->length) < SMCD_CLC_ACCEPT_CONFIRM_LEN_V2)
>   			return false;
>   		if (hdr->typev1 == SMC_TYPE_R &&
>   		    ntohs(hdr->length) < SMCR_CLC_ACCEPT_CONFIRM_LEN_V2)
> @@ -420,13 +418,19 @@ smc_clc_msg_decl_valid(struct smc_clc_msg_decline *dclc)
>   	return true;
>   }
>   
> -static void smc_clc_fill_fce(struct smc_clc_first_contact_ext *fce, int *len, int release_nr)
> +static int smc_clc_fill_fce(struct smc_clc_first_contact_ext_v2x *fce,
> +			    struct smc_init_info *ini)
>   {
> +	int ret = sizeof(*fce);
> +
>   	memset(fce, 0, sizeof(*fce));
> -	fce->os_type = SMC_CLC_OS_LINUX;
> -	fce->release = release_nr;
> -	memcpy(fce->hostname, smc_hostname, sizeof(smc_hostname));
> -	(*len) += sizeof(*fce);
> +	fce->fce_v20.os_type = SMC_CLC_OS_LINUX;
> +	fce->fce_v20.release = ini->release_nr;

I don't like that this is called fce_v20.release which can be set to 
v2.1 here although the struct is named v20. Maybe let us call the struct 
something like fce_v2_base or fce_base_v2.

> +	memcpy(fce->fce_v20.hostname, smc_hostname, sizeof(smc_hostname));
> +	if (ini->is_smcd && ini->release_nr < SMC_RELEASE_1)
> +		ret = sizeof(struct smc_clc_first_contact_ext);
> +
> +	return ret;
>   }
>   
>   /* check if received message has a correct header length and contains valid
> @@ -986,13 +990,13 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>   				       u8 *eid, struct smc_init_info *ini)
>   {
>   	struct smc_connection *conn = &smc->conn;
> +	struct smc_clc_first_contact_ext_v2x fce;
>   	struct smc_clc_msg_accept_confirm *clc;
> -	struct smc_clc_first_contact_ext fce;
>   	struct smc_clc_fce_gid_ext gle;
>   	struct smc_clc_msg_trail trl;
> +	int i, len, fce_len;
>   	struct kvec vec[5];
>   	struct msghdr msg;
> -	int i, len;
>   
>   	/* send SMC Confirm CLC msg */
>   	clc = (struct smc_clc_msg_accept_confirm *)clc_v2;
> @@ -1018,8 +1022,10 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>   			if (eid && eid[0])
>   				memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
>   			len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
> -			if (first_contact)
> -				smc_clc_fill_fce(&fce, &len, ini->release_nr);
> +			if (first_contact) {
> +				fce_len = smc_clc_fill_fce(&fce, ini);
> +				len += fce_len;
> +			}
>   			clc_v2->hdr.length = htons(len);
>   		}
>   		memcpy(trl.eyecatcher, SMCD_EYECATCHER,
> @@ -1063,15 +1069,14 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>   				memcpy(clc_v2->r1.eid, eid, SMC_MAX_EID_LEN);
>   			len = SMCR_CLC_ACCEPT_CONFIRM_LEN_V2;
>   			if (first_contact) {
> -				smc_clc_fill_fce(&fce, &len, ini->release_nr);
> -				fce.v2_direct = !link->lgr->uses_gateway;
> -				memset(&gle, 0, sizeof(gle));
> +				fce_len = smc_clc_fill_fce(&fce, ini);
> +				len += fce_len;
> +				fce.fce_v20.v2_direct = !link->lgr->uses_gateway;
>   				if (clc->hdr.type == SMC_CLC_CONFIRM) {
> +					memset(&gle, 0, sizeof(gle));
>   					gle.gid_cnt = ini->smcrv2.gidlist.len;
>   					len += sizeof(gle);
>   					len += gle.gid_cnt * sizeof(gle.gid[0]);
> -				} else {
> -					len += sizeof(gle.reserved);
>   				}
>   			}
>   			clc_v2->hdr.length = htons(len);
> @@ -1094,7 +1099,7 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>   				   sizeof(trl);
>   	if (version > SMC_V1 && first_contact) {
>   		vec[i].iov_base = &fce;
> -		vec[i++].iov_len = sizeof(fce);
> +		vec[i++].iov_len = fce_len;
>   		if (!conn->lgr->is_smcd) {
>   			if (clc->hdr.type == SMC_CLC_CONFIRM) {
>   				vec[i].iov_base = &gle;
> @@ -1102,9 +1107,6 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>   				vec[i].iov_base = &ini->smcrv2.gidlist.list;
>   				vec[i++].iov_len = gle.gid_cnt *
>   						   sizeof(gle.gid[0]);
> -			} else {
> -				vec[i].iov_base = &gle.reserved;
> -				vec[i++].iov_len = sizeof(gle.reserved);
>   			}
>   		}
>   	}
> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index b923e89acafb..6133276a8839 100644
> --- a/net/smc/smc_clc.h
> +++ b/net/smc/smc_clc.h
> @@ -147,7 +147,9 @@ struct smc_clc_msg_proposal_prefix {	/* prefix part of clc proposal message*/
>   struct smc_clc_msg_smcd {	/* SMC-D GID information */
>   	struct smc_clc_smcd_gid_chid ism; /* ISM native GID+CHID of requestor */
>   	__be16 v2_ext_offset;	/* SMC Version 2 Extension Offset */
> -	u8 reserved[28];
> +	u8 vendor_oui[3];
> +	u8 vendor_exp_options[5];
> +	u8 reserved[20];

Could we either make those variables a bit more self explaining via 
their name (e.g. vendor_organization_uid) or adding a comment /* vendor 
organizationally unique identifier */

>   };
>   
>   struct smc_clc_smcd_v2_extension {
> @@ -231,8 +233,17 @@ struct smc_clc_first_contact_ext {
>   	u8 hostname[SMC_MAX_HOSTNAME_LEN];
>   };
>   
> +struct smc_clc_first_contact_ext_v2x {
> +	struct smc_clc_first_contact_ext fce_v20;

as stated at the top where the release is assigned i'm not completly 
happy with the naming.

> +	u8 reserved3[4];
> +	__be32 vendor_exp_options;
> +	u8 reserved4[8];
> +} __packed;		/* format defined in
> +			 * IBM Shared Memory Communications Version 2 (Third Edition)
> +			 * (https://www.ibm.com/support/pages/node/7009315)
> +			 */
> +
>   struct smc_clc_fce_gid_ext {
> -	u8 reserved[16];
>   	u8 gid_cnt;
>   	u8 reserved2[3];
>   	u8 gid[][SMC_GID_SIZE];
