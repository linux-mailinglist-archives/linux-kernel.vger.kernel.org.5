Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B9D80C6E7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjLKKna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjLKKn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:43:27 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DFDA9;
        Mon, 11 Dec 2023 02:43:33 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB9OrO0008438;
        Mon, 11 Dec 2023 10:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fMguoUzvTcEvxr+tvOI6ihG+SpskXOW7J635HmFcAgE=;
 b=qZUBgF5CYRE8R1ONMFpsBs/wFErh32zpFNt0bvO6S3UoTzXgYXgeWHUBFoQoC+3/Hhkc
 rD4BxV4bqX+0BsoemFsCOYacLlVfZBy3cCcLIV5Dmt371QFOFswGeCDgoewLf1JNex9D
 RuAWClfpHiVkzl2o8EHdb62uyUuajUepMEn7yeoZxuIVho2LZNtyn0Ltiu9r6Dq81rA0
 X9uCmfGsiZydsiV5wqm9qJk/Ry7IeeIA3jx64OrbzNJD2WMRPsFYthvniiNoOMUDWQ9+
 aVQG7NuLM1N2AOkSuTKVgxUTyCi19vq1bHYfBO6LJ2bsZTdD3MpaYydPMappIlHZas1F xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uwys51xbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 10:43:28 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BB9wuKp021767;
        Mon, 11 Dec 2023 10:43:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uwys51xax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 10:43:28 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB8ukdU005049;
        Mon, 11 Dec 2023 10:43:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4sk0d03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 10:43:27 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BBAhN2544892788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Dec 2023 10:43:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0AF52004B;
        Mon, 11 Dec 2023 10:43:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D85FF20040;
        Mon, 11 Dec 2023 10:43:22 +0000 (GMT)
Received: from [9.171.1.164] (unknown [9.171.1.164])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 11 Dec 2023 10:43:22 +0000 (GMT)
Message-ID: <ac3c0823-8705-4225-96c8-ed7bc55d1bfc@linux.ibm.com>
Date:   Mon, 11 Dec 2023 11:43:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/9] net/smc: introduce sub-functions for
 smc_clc_send_confirm_accept()
Content-Language: en-US
To:     Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1702021259-41504-1-git-send-email-guwen@linux.alibaba.com>
 <1702021259-41504-3-git-send-email-guwen@linux.alibaba.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1702021259-41504-3-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fgs5CcZVvQ3Wemd5GYk8mQe5xRiN88yU
X-Proofpoint-GUID: _MAECKM_MDhrtEM-jOVAKF9Dsz9vbOjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_04,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312110086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08.12.23 08:40, Wen Gu wrote:
> There is a large if-else block in smc_clc_send_confirm_accept() and it
> is better to split it into two sub-functions.
> 
> Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---

Thank you very much Wen Gu for improving the codebase.


>  net/smc/smc_clc.c | 196 +++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 114 insertions(+), 82 deletions(-)
> 
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index 0fcb035..52b4ea9 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -998,6 +998,111 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>  	return reason_code;
>  }
>  
> +static void smcd_clc_prep_confirm_accept(struct smc_connection *conn,
> +				struct smc_clc_msg_accept_confirm_v2 *clc_v2,
> +				int first_contact, u8 version,
> +				u8 *eid, struct smc_init_info *ini,
> +				int *fce_len,
> +				struct smc_clc_first_contact_ext_v2x *fce_v2x,
> +				struct smc_clc_msg_trail *trl)
> +{
> +	struct smcd_dev *smcd = conn->lgr->smcd;
> +	struct smc_clc_msg_accept_confirm *clc;
> +	int len;
> +
> +	/* SMC-D specific settings */
> +	clc = (struct smc_clc_msg_accept_confirm *)clc_v2;

Why is this cast neccessary? (Here as well as in smcr_clc_prep_confirm_accept
and in smc_clc_send_confirm_accept)
smc_clc_msg_accept_confirm_v2 has hdr and d0 as well.

IMO, it would be a nice seperate patch to get rid of the 2 type defs for
smc_clc_msg_accept_confirm and smc_clc_msg_accept_confirm_v2
and all the related casting anyhow.



> +	memcpy(clc->hdr.eyecatcher, SMCD_EYECATCHER,
> +	       sizeof(SMCD_EYECATCHER));
> +	clc->hdr.typev1 = SMC_TYPE_D;
> +	clc->d0.gid = htonll(smcd->ops->get_local_gid(smcd));
> +	clc->d0.token = htonll(conn->rmb_desc->token);
> +	clc->d0.dmbe_size = conn->rmbe_size_comp;
> +	clc->d0.dmbe_idx = 0;
> +	memcpy(&clc->d0.linkid, conn->lgr->id, SMC_LGR_ID_SIZE);
> +	if (version == SMC_V1) {
> +		clc->hdr.length = htons(SMCD_CLC_ACCEPT_CONFIRM_LEN);
> +	} else {
> +		clc_v2->d1.chid = htons(smc_ism_get_chid(smcd));
> +		if (eid && eid[0])
> +			memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
> +		len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
> +		if (first_contact) {
> +			*fce_len = smc_clc_fill_fce_v2x(fce_v2x, ini);
> +			len += *fce_len;
> +		}
> +		clc_v2->hdr.length = htons(len);
> +	}
> +	memcpy(trl->eyecatcher, SMCD_EYECATCHER,
> +	       sizeof(SMCD_EYECATCHER));
> +}
> +
> +static void smcr_clc_prep_confirm_accept(struct smc_connection *conn,
> +				struct smc_clc_msg_accept_confirm_v2 *clc_v2,
> +				int first_contact, u8 version,
> +				u8 *eid, struct smc_init_info *ini,
> +				int *fce_len,
> +				struct smc_clc_first_contact_ext_v2x *fce_v2x,
> +				struct smc_clc_fce_gid_ext *gle,
> +				struct smc_clc_msg_trail *trl)
> +{
> +	struct smc_clc_msg_accept_confirm *clc;
> +	struct smc_link *link = conn->lnk;
> +	int len;
> +
> +	/* SMC-R specific settings */
> +	clc = (struct smc_clc_msg_accept_confirm *)clc_v2;

Why is this cast neccessary? 
smc_clc_msg_accept_confirm_v2 has hdr and r0 as well.

> +	memcpy(clc->hdr.eyecatcher, SMC_EYECATCHER,
> +	       sizeof(SMC_EYECATCHER));
> +	clc->hdr.typev1 = SMC_TYPE_R;
> +	clc->hdr.length = htons(SMCR_CLC_ACCEPT_CONFIRM_LEN);

^^ this is overwritten below, so no need to set it here.

> +	memcpy(clc->r0.lcl.id_for_peer, local_systemid,
> +	       sizeof(local_systemid));
> +	memcpy(&clc->r0.lcl.gid, link->gid, SMC_GID_SIZE);
> +	memcpy(&clc->r0.lcl.mac, &link->smcibdev->mac[link->ibport - 1],
> +	       ETH_ALEN);
> +	hton24(clc->r0.qpn, link->roce_qp->qp_num);
> +	clc->r0.rmb_rkey =
> +		htonl(conn->rmb_desc->mr[link->link_idx]->rkey);
> +	clc->r0.rmbe_idx = 1; /* for now: 1 RMB = 1 RMBE */
> +	clc->r0.rmbe_alert_token = htonl(conn->alert_token_local);
> +	switch (clc->hdr.type) {
> +	case SMC_CLC_ACCEPT:
> +		clc->r0.qp_mtu = link->path_mtu;
> +		break;
> +	case SMC_CLC_CONFIRM:
> +		clc->r0.qp_mtu = min(link->path_mtu, link->peer_mtu);
> +		break;
> +	}
> +	clc->r0.rmbe_size = conn->rmbe_size_comp;
> +	clc->r0.rmb_dma_addr = conn->rmb_desc->is_vm ?
> +		cpu_to_be64((uintptr_t)conn->rmb_desc->cpu_addr) :
> +		cpu_to_be64((u64)sg_dma_address
> +			    (conn->rmb_desc->sgt[link->link_idx].sgl));
> +	hton24(clc->r0.psn, link->psn_initial);
> +	if (version == SMC_V1) {
> +		clc->hdr.length = htons(SMCR_CLC_ACCEPT_CONFIRM_LEN);
> +	} else {
> +		if (eid && eid[0])
> +			memcpy(clc_v2->r1.eid, eid, SMC_MAX_EID_LEN);
> +		len = SMCR_CLC_ACCEPT_CONFIRM_LEN_V2;
> +		if (first_contact) {
> +			*fce_len = smc_clc_fill_fce_v2x(fce_v2x, ini);
> +			len += *fce_len;
> +			fce_v2x->fce_v2_base.v2_direct =
> +				!link->lgr->uses_gateway;
> +			if (clc->hdr.type == SMC_CLC_CONFIRM) {
> +				memset(gle, 0, sizeof(*gle));
> +				gle->gid_cnt = ini->smcrv2.gidlist.len;
> +				len += sizeof(*gle);
> +				len += gle->gid_cnt * sizeof(gle->gid[0]);
> +			}
> +		}
> +		clc_v2->hdr.length = htons(len);
> +	}
> +	memcpy(trl->eyecatcher, SMC_EYECATCHER, sizeof(SMC_EYECATCHER));
> +}
> +
>  /* build and send CLC CONFIRM / ACCEPT message */
>  static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>  				       struct smc_clc_msg_accept_confirm_v2 *clc_v2,
> @@ -1006,11 +1111,10 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>  {
>  	struct smc_clc_first_contact_ext_v2x fce_v2x;
>  	struct smc_connection *conn = &smc->conn;
> -	struct smcd_dev *smcd = conn->lgr->smcd;
>  	struct smc_clc_msg_accept_confirm *clc;
>  	struct smc_clc_fce_gid_ext gle;
>  	struct smc_clc_msg_trail trl;
> -	int i, len, fce_len;
> +	int i, fce_len;
>  	struct kvec vec[5];
>  	struct msghdr msg;
>  
> @@ -1019,86 +1123,14 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>  	clc->hdr.version = version;	/* SMC version */
>  	if (first_contact)
>  		clc->hdr.typev2 |= SMC_FIRST_CONTACT_MASK;
> -	if (conn->lgr->is_smcd) {
> -		/* SMC-D specific settings */
> -		memcpy(clc->hdr.eyecatcher, SMCD_EYECATCHER,
> -		       sizeof(SMCD_EYECATCHER));
> -		clc->hdr.typev1 = SMC_TYPE_D;
> -		clc->d0.gid = htonll(smcd->ops->get_local_gid(smcd));
> -		clc->d0.token = htonll(conn->rmb_desc->token);
> -		clc->d0.dmbe_size = conn->rmbe_size_comp;
> -		clc->d0.dmbe_idx = 0;
> -		memcpy(&clc->d0.linkid, conn->lgr->id, SMC_LGR_ID_SIZE);
> -		if (version == SMC_V1) {
> -			clc->hdr.length = htons(SMCD_CLC_ACCEPT_CONFIRM_LEN);
> -		} else {
> -			clc_v2->d1.chid = htons(smc_ism_get_chid(smcd));
> -			if (eid && eid[0])
> -				memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
> -			len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
> -			if (first_contact) {
> -				fce_len = smc_clc_fill_fce_v2x(&fce_v2x, ini);
> -				len += fce_len;
> -			}
> -			clc_v2->hdr.length = htons(len);
> -		}
> -		memcpy(trl.eyecatcher, SMCD_EYECATCHER,
> -		       sizeof(SMCD_EYECATCHER));
> -	} else {
> -		struct smc_link *link = conn->lnk;
> -
> -		/* SMC-R specific settings */
> -		memcpy(clc->hdr.eyecatcher, SMC_EYECATCHER,
> -		       sizeof(SMC_EYECATCHER));
> -		clc->hdr.typev1 = SMC_TYPE_R;
> -		clc->hdr.length = htons(SMCR_CLC_ACCEPT_CONFIRM_LEN);
> -		memcpy(clc->r0.lcl.id_for_peer, local_systemid,
> -		       sizeof(local_systemid));
> -		memcpy(&clc->r0.lcl.gid, link->gid, SMC_GID_SIZE);
> -		memcpy(&clc->r0.lcl.mac, &link->smcibdev->mac[link->ibport - 1],
> -		       ETH_ALEN);
> -		hton24(clc->r0.qpn, link->roce_qp->qp_num);
> -		clc->r0.rmb_rkey =
> -			htonl(conn->rmb_desc->mr[link->link_idx]->rkey);
> -		clc->r0.rmbe_idx = 1; /* for now: 1 RMB = 1 RMBE */
> -		clc->r0.rmbe_alert_token = htonl(conn->alert_token_local);
> -		switch (clc->hdr.type) {
> -		case SMC_CLC_ACCEPT:
> -			clc->r0.qp_mtu = link->path_mtu;
> -			break;
> -		case SMC_CLC_CONFIRM:
> -			clc->r0.qp_mtu = min(link->path_mtu, link->peer_mtu);
> -			break;
> -		}
> -		clc->r0.rmbe_size = conn->rmbe_size_comp;
> -		clc->r0.rmb_dma_addr = conn->rmb_desc->is_vm ?
> -			cpu_to_be64((uintptr_t)conn->rmb_desc->cpu_addr) :
> -			cpu_to_be64((u64)sg_dma_address
> -				    (conn->rmb_desc->sgt[link->link_idx].sgl));
> -		hton24(clc->r0.psn, link->psn_initial);
> -		if (version == SMC_V1) {
> -			clc->hdr.length = htons(SMCR_CLC_ACCEPT_CONFIRM_LEN);
> -		} else {
> -			if (eid && eid[0])
> -				memcpy(clc_v2->r1.eid, eid, SMC_MAX_EID_LEN);
> -			len = SMCR_CLC_ACCEPT_CONFIRM_LEN_V2;
> -			if (first_contact) {
> -				fce_len = smc_clc_fill_fce_v2x(&fce_v2x, ini);
> -				len += fce_len;
> -				fce_v2x.fce_v2_base.v2_direct =
> -					!link->lgr->uses_gateway;
> -				if (clc->hdr.type == SMC_CLC_CONFIRM) {
> -					memset(&gle, 0, sizeof(gle));
> -					gle.gid_cnt = ini->smcrv2.gidlist.len;
> -					len += sizeof(gle);
> -					len += gle.gid_cnt * sizeof(gle.gid[0]);
> -				}
> -			}
> -			clc_v2->hdr.length = htons(len);
> -		}
> -		memcpy(trl.eyecatcher, SMC_EYECATCHER, sizeof(SMC_EYECATCHER));
> -	}
> -
> +	if (conn->lgr->is_smcd)
> +		smcd_clc_prep_confirm_accept(conn, clc_v2, first_contact,
> +					     version, eid, ini, &fce_len,
> +					     &fce_v2x, &trl);
> +	else
> +		smcr_clc_prep_confirm_accept(conn, clc_v2, first_contact,
> +					     version, eid, ini, &fce_len,
> +					     &fce_v2x, &gle, &trl);
>  	memset(&msg, 0, sizeof(msg));
>  	i = 0;
>  	vec[i].iov_base = clc_v2;
