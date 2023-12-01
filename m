Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8DD80110A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378295AbjLAQbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjLAQbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:31:03 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603A083;
        Fri,  1 Dec 2023 08:31:08 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1GUIPF002470;
        Fri, 1 Dec 2023 16:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wIr0pVsfWvGANkOc79yLdF5wut93kx7dMxtsOXN+uIM=;
 b=PBAiFj3AbnqLXfcM+338Fq8tg/e5CgOFSD7CgcyyBcmNm6cxPsG5rY2XYUD9+++sQ3MK
 ZQJ7Tfl/ufnVx1e8kuQhWP5DYTiDQo/RGFe+04q5zQwYyJ9UCCiBj6LqL50MEFRcU7vc
 cAulEEijM/AfeZpQEGa87N3t2OQCfDOWGSDaGSHEg0gVqHSnlEcKlq0UCTY9oOEBmxoX
 4V9yI3jjmtYLoMUbzPQTMTS2ji4fCSHzNWM1ezooOdf6ScjZkM1izv1CR1ySvzykDnjw
 oBBdVOlm4bOkdAa8HXT1Rtjzi/V0TAthXpBl4xD0yuZ5kHHNNutXvv4dLT6W5rNVk99p Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqk2k822r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 16:31:01 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B1GUOXQ002818;
        Fri, 1 Dec 2023 16:31:00 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqk2k821v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 16:31:00 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1DoNlE031663;
        Fri, 1 Dec 2023 16:30:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukun06cwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 16:30:59 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B1GUumi22872826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Dec 2023 16:30:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40FF12004B;
        Fri,  1 Dec 2023 16:30:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10B8A20040;
        Fri,  1 Dec 2023 16:30:55 +0000 (GMT)
Received: from [9.179.28.5] (unknown [9.179.28.5])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  1 Dec 2023 16:30:54 +0000 (GMT)
Message-ID: <19b288d3-5434-40b1-93fa-7db47e417f60@linux.ibm.com>
Date:   Fri, 1 Dec 2023 17:30:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/7] net/smc: compatible with 128-bits extend
 GID of virtual ISM device
Content-Language: en-US
To:     Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1701343695-122657-1-git-send-email-guwen@linux.alibaba.com>
 <1701343695-122657-6-git-send-email-guwen@linux.alibaba.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1701343695-122657-6-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J3ErTrvEnCj9xbn8jvO_FnmGVAPd24SY
X-Proofpoint-GUID: 9gnKUn2vcGwTXfSkZZM2aoUcRnPA4FpH
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_15,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312010112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.11.23 12:28, Wen Gu wrote:
[...]
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 766a1f1..d1e18bf 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
[...]
> @@ -1048,7 +1048,8 @@ static int smc_find_ism_v2_device_clnt(struct smc_sock *smc,
>  {
>  	int rc = SMC_CLC_DECL_NOSMCDDEV;
>  	struct smcd_dev *smcd;
> -	int i = 1;
> +	int i = 1, entry = 1;
> +	bool is_virtual;
>  	u16 chid;
>  
>  	if (smcd_indicated(ini->smc_type_v1))
> @@ -1060,14 +1061,23 @@ static int smc_find_ism_v2_device_clnt(struct smc_sock *smc,
>  		chid = smc_ism_get_chid(smcd);
>  		if (!smc_find_ism_v2_is_unique_chid(chid, ini, i))
>  			continue;
> +		is_virtual = __smc_ism_is_virtual(chid);
>  		if (!smc_pnet_is_pnetid_set(smcd->pnetid) ||
>  		    smc_pnet_is_ndev_pnetid(sock_net(&smc->sk), smcd->pnetid)) {
> +			if (is_virtual && entry == SMC_MAX_ISM_DEVS)
> +				/* only one GID-CHID entry left in CLC Proposal SMC-Dv2
> +				 * extension. but a virtual ISM device's GID takes two
> +				 * entries. So give up it and try the next potential ISM
> +				 * device.
> +				 */

It is really importatnt to note that virtual ISMs take 2 entries.
But it is still hard to understand this piece of code. e.g. I was wondering for a while,
why you mention CLC here...
Maybe it would be easier to understand this, if you rename SMC_MAX_ISM_DEVS to something else?
Something like SMCD_MAX_V2_GID_ENTRIES?

> +				continue;
>  			ini->ism_dev[i] = smcd;
>  			ini->ism_chid[i] = chid;
>  			ini->is_smcd = true;
>  			rc = 0;
>  			i++;
> -			if (i > SMC_MAX_ISM_DEVS)
> +			entry = is_virtual ? entry + 2 : entry + 1;
> +			if (entry > SMC_MAX_ISM_DEVS)
>  				break;
>  		}
>  	}
[...]



> @@ -2154,18 +2176,35 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
>  	smcd_v2_ext = smc_get_clc_smcd_v2_ext(smc_v2_ext);
>  
>  	mutex_lock(&smcd_dev_list.mutex);
> -	if (pclc_smcd->ism.chid)
> +	if (pclc_smcd->ism.chid) {
>  		/* check for ISM device matching proposed native ISM device */
> +		smcd_gid.gid = ntohll(pclc_smcd->ism.gid);
> +		smcd_gid.gid_ext = 0;
>  		smc_check_ism_v2_match(ini, ntohs(pclc_smcd->ism.chid),
> -				       ntohll(pclc_smcd->ism.gid), &matches);
> +				       &smcd_gid, &matches);
> +	}
>  	for (i = 1; i <= smc_v2_ext->hdr.ism_gid_cnt; i++) {

IMO the following code would be easier to read, if you change the above to count 
from i = 0; i < smc_v2_ext->hdr.ism_gid_cnt;
and then use i and i+1 as indexes below.

>  		/* check for ISM devices matching proposed non-native ISM
>  		 * devices
>  		 */
> -		smc_check_ism_v2_match(ini,
> -				       ntohs(smcd_v2_ext->gidchid[i - 1].chid),
> -				       ntohll(smcd_v2_ext->gidchid[i - 1].gid),
> -				       &matches);
> +		smcd_gid.gid = ntohll(smcd_v2_ext->gidchid[i - 1].gid);
> +		smcd_gid.gid_ext = 0;
> +		chid = ntohs(smcd_v2_ext->gidchid[i - 1].chid);
> +		if (__smc_ism_is_virtual(chid)) {
> +			if (i == smc_v2_ext->hdr.ism_gid_cnt ||
> +			    chid != ntohs(smcd_v2_ext->gidchid[i].chid))
> +				/* a virtual ISM device takes two GID-CHID entries
> +				 * and CHID of the second entry repeats that of the
> +				 * first entry.
> +				 *
> +				 * So check if the second GID-CHID entry exists and
> +				 * the CHIDs of these two entries are the same.
> +				 */
> +				continue;
> +
> +			smcd_gid.gid_ext = ntohll(smcd_v2_ext->gidchid[i++].gid);
> +		}
> +		smc_check_ism_v2_match(ini, chid, &smcd_gid, &matches);
>  	}
>  	mutex_unlock(&smcd_dev_list.mutex);
>  
[...]



> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index e2e437b..2d8bc0b 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
[...]
> @@ -1020,23 +1033,28 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>  	if (first_contact)
>  		clc->hdr.typev2 |= SMC_FIRST_CONTACT_MASK;
>  	if (conn->lgr->is_smcd) {

It would be nice to have 2 subfunctions for ism and rdma instead of this large if/else block.

> +		struct smcd_gid smcd_gid;
> +		u16 chid;
> +
>  		/* SMC-D specific settings */
>  		memcpy(clc->hdr.eyecatcher, SMCD_EYECATCHER,
>  		       sizeof(SMCD_EYECATCHER));
> +		conn->lgr->smcd->ops->get_local_gid(conn->lgr->smcd, &smcd_gid);
>  		clc->hdr.typev1 = SMC_TYPE_D;
> -		clc->d0.gid =
> -			conn->lgr->smcd->ops->get_local_gid(conn->lgr->smcd);
> -		clc->d0.token = conn->rmb_desc->token;
> +		clc->d0.gid = htonll(smcd_gid.gid);
> +		clc->d0.token = htonll(conn->rmb_desc->token);
>  		clc->d0.dmbe_size = conn->rmbe_size_comp;
>  		clc->d0.dmbe_idx = 0;
>  		memcpy(&clc->d0.linkid, conn->lgr->id, SMC_LGR_ID_SIZE);
>  		if (version == SMC_V1) {
>  			clc->hdr.length = htons(SMCD_CLC_ACCEPT_CONFIRM_LEN);
>  		} else {
> -			clc_v2->d1.chid =
> -				htons(smc_ism_get_chid(conn->lgr->smcd));
> +			chid = smc_ism_get_chid(conn->lgr->smcd);
> +			clc_v2->d1.chid = htons(chid);
>  			if (eid && eid[0])
>  				memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
> +			if (__smc_ism_is_virtual(chid))
> +				clc_v2->d1.gid_ext = htonll(smcd_gid.gid_ext);
>  			len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
>  			if (first_contact) {
>  				fce_len = smc_clc_fill_fce_v2x(&fce_v2x, ini);
> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index e64c235..dcc63f4 100644
> --- a/net/smc/smc_clc.h
> +++ b/net/smc/smc_clc.h
> @@ -205,8 +205,8 @@ struct smcr_clc_msg_accept_confirm {	/* SMCR accept/confirm */
>  } __packed;
>  
>  struct smcd_clc_msg_accept_confirm_common {	/* SMCD accept/confirm */
> -	u64 gid;		/* Sender GID */
> -	u64 token;		/* DMB token */
> +	__be64 gid;		/* Sender GID */
> +	__be64 token;		/* DMB token */

Good catch, that this needs to be __be. (including the host to net conversions you did above)
This is not related to the subject of this patch though. So either this should be in a separate patch
or at least mentioned in the commit message.

>  	u8 dmbe_idx;		/* DMBE index */
>  #if defined(__BIG_ENDIAN_BITFIELD)
>  	u8 dmbe_size : 4,	/* buf size (compressed) */
> @@ -285,8 +285,8 @@ struct smc_clc_msg_accept_confirm_v2 {	/* clc accept / confirm message */
>  			struct smcd_clc_msg_accept_confirm_common d0;
>  			__be16 chid;
>  			u8 eid[SMC_MAX_EID_LEN];
> -			u8 reserved5[8];
> -		} d1;
> +			__be64 gid_ext;
> +		} __packed d1;
>  	};
>  };
>  
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index d520ee6..32eece5 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.> @@ -506,6 +506,7 @@ static int smc_nl_fill_smcd_lgr(struct smc_link_group *lgr,
>  {
>  	char smc_pnet[SMC_MAX_PNETID_LEN + 1];
>  	struct smcd_dev *smcd = lgr->smcd;
> +	struct smcd_gid smcd_gid;
>  	struct nlattr *attrs;
>  	void *nlh;
>  
> @@ -521,11 +522,11 @@ static int smc_nl_fill_smcd_lgr(struct smc_link_group *lgr,
>  
>  	if (nla_put_u32(skb, SMC_NLA_LGR_D_ID, *((u32 *)&lgr->id)))
>  		goto errattr;
> +	smcd->ops->get_local_gid(smcd, &smcd_gid);
>  	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_D_GID,
> -			      smcd->ops->get_local_gid(smcd),
> -				  SMC_NLA_LGR_D_PAD))
> +			      smcd_gid.gid, SMC_NLA_LGR_D_PAD))
>  		goto errattr;
> -	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_D_PEER_GID, lgr->peer_gid,
> +	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_D_PEER_GID, lgr->peer_gid.gid,
>  			      SMC_NLA_LGR_D_PAD))
>  		goto errattr;

For virtual ism, you will only see the first half of the GID.
Is that acceptable? Today we use netlink only for display purposes. 
What if somebody uses the netlink content as functional input to a user space program?


>  	if (nla_put_u8(skb, SMC_NLA_LGR_D_VLAN_ID, lgr->vlan_id))
> @@ -876,7 +877,10 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
>  		/* SMC-D specific settings */


I guess I never really understood, why we define a single linkgroup for SMC-D.
Probably because SMC-R linkgroups were implemented before SMC-D support was added.
To all: Do we want to keep that concept?


>  		smcd = ini->ism_dev[ini->ism_selected];
>  		get_device(smcd->ops->get_dev(smcd));
> -		lgr->peer_gid = ini->ism_peer_gid[ini->ism_selected];
> +		lgr->peer_gid.gid =
> +			ini->ism_peer_gid[ini->ism_selected].gid;
> +		lgr->peer_gid.gid_ext =
> +			ini->ism_peer_gid[ini->ism_selected].gid_ext;
>  		lgr->smcd = ini->ism_dev[ini->ism_selected];
>  		lgr_list = &ini->ism_dev[ini->ism_selected]->lgr_list;
>  		lgr_lock = &lgr->smcd->lgr_lock;
> @@ -1514,7 +1518,8 @@ void smc_lgr_terminate_sched(struct smc_link_group *lgr)
>  }
>  
>  /* Called when peer lgr shutdown (regularly or abnormally) is received */
> -void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
> +void smc_smcd_terminate(struct smcd_dev *dev, struct smcd_gid *peer_gid,
> +			unsigned short vlan)
>  {
>  	struct smc_link_group *lgr, *l;
>  	LIST_HEAD(lgr_free_list);
> @@ -1522,9 +1527,12 @@ void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
>  	/* run common cleanup function and build free list */
>  	spin_lock_bh(&dev->lgr_lock);
>  	list_for_each_entry_safe(lgr, l, &dev->lgr_list, list) {
> -		if ((!peer_gid || lgr->peer_gid == peer_gid) &&
> +		if ((!peer_gid->gid ||
> +		     (lgr->peer_gid.gid == peer_gid->gid &&
> +		      !smc_ism_is_virtual(dev) ? 1 :
> +		      lgr->peer_gid.gid_ext == peer_gid->gid_ext)) &&
>  		    (vlan == VLAN_VID_MASK || lgr->vlan_id == vlan)) {
> -			if (peer_gid) /* peer triggered termination */
> +			if (peer_gid->gid) /* peer triggered termination */
>  				lgr->peer_shutdown = 1;
>  			list_move(&lgr->list, &lgr_free_list);
>  			lgr->freeing = 1;
> @@ -1859,10 +1867,12 @@ static bool smcr_lgr_match(struct smc_link_group *lgr, u8 smcr_version,
>  	return false;
>  }
>  
> -static bool smcd_lgr_match(struct smc_link_group *lgr,
> -			   struct smcd_dev *smcismdev, u64 peer_gid)
> +static bool smcd_lgr_match(struct smc_link_group *lgr, struct smcd_dev *smcismdev,
> +			   struct smcd_gid *peer_gid)
>  {
> -	return lgr->peer_gid == peer_gid && lgr->smcd == smcismdev;
> +	return lgr->peer_gid.gid == peer_gid->gid && lgr->smcd == smcismdev &&
> +		smc_ism_is_virtual(smcismdev) ?
> +		(lgr->peer_gid.gid_ext == peer_gid->gid_ext) : 1;
>  }
>  
>  /* create a new SMC connection (and a new link group if necessary) */
> @@ -1892,7 +1902,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
>  		write_lock_bh(&lgr->conns_lock);
>  		if ((ini->is_smcd ?
>  		     smcd_lgr_match(lgr, ini->ism_dev[ini->ism_selected],
> -				    ini->ism_peer_gid[ini->ism_selected]) :
> +				    &ini->ism_peer_gid[ini->ism_selected]) :
>  		     smcr_lgr_match(lgr, ini->smcr_version,
>  				    ini->peer_systemid,
>  				    ini->peer_gid, ini->peer_mac, role,
[...]
> diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
> index a584613..c180c18 100644
> --- a/net/smc/smc_diag.c
> +++ b/net/smc/smc_diag.c
> @@ -21,6 +21,7 @@
>  
>  #include "smc.h"
>  #include "smc_core.h"
> +#include "smc_ism.h"
>  
>  struct smc_diag_dump_ctx {
>  	int pos[2];
> @@ -168,12 +169,14 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
>  		struct smc_connection *conn = &smc->conn;
>  		struct smcd_diag_dmbinfo dinfo;
>  		struct smcd_dev *smcd = conn->lgr->smcd;
> +		struct smcd_gid smcd_gid;
>  
>  		memset(&dinfo, 0, sizeof(dinfo));
>  
>  		dinfo.linkid = *((u32 *)conn->lgr->id);
> -		dinfo.peer_gid = conn->lgr->peer_gid;
> -		dinfo.my_gid = smcd->ops->get_local_gid(smcd);
> +		dinfo.peer_gid = conn->lgr->peer_gid.gid;
> +		smcd->ops->get_local_gid(smcd, &smcd_gid);
> +		dinfo.my_gid = smcd_gid.gid;

For virtual ism, you will only see the first half of the GID.
Is that acceptable? 

>  		dinfo.token = conn->rmb_desc->token;
>  		dinfo.peer_token = conn->peer_token;
>  
> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> index fbee249..a33f861 100644
> --- a/net/smc/smc_ism.c
> +++ b/net/smc/smc_ism.c

Some of the content of this file is specific to s390 firmware ISMs and some is
relevant to all future ism devices.
IMO there is some more work to do to create a clean "smcd-protocol to scmd-device" interface.
Maybe also some moving between this file and drivers/s390/net/ism_drv.c

Maybe this would be a good next patchset?

Whoever takes this work, remember:
https://lore.kernel.org/netdev/1c6bdfbf-54c1-4251-916e-9a703a9f644c@infradead.org/T/
We want to be able to combine SMC, ISM and future kernel modules in any combination.
Gerd's patch above was meant to solve the current problem. For additional ism devices,
we need some more improvements, I think.





> @@ -44,7 +44,8 @@ static void smcd_handle_irq(struct ism_dev *ism, unsigned int dmbno,
>  #endif
>  
>  /* Test if an ISM communication is possible - same CPC */
> -int smc_ism_cantalk(u64 peer_gid, unsigned short vlan_id, struct smcd_dev *smcd)
> +int smc_ism_cantalk(struct smcd_gid *peer_gid, unsigned short vlan_id,
> +		    struct smcd_dev *smcd)
>  {
>  	return smcd->ops->query_remote_gid(smcd, peer_gid, vlan_id ? 1 : 0,
>  					   vlan_id);
> @@ -208,7 +209,7 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
>  	dmb.dmb_len = dmb_len;
>  	dmb.sba_idx = dmb_desc->sba_idx;
>  	dmb.vlan_id = lgr->vlan_id;
> -	dmb.rgid = lgr->peer_gid;
> +	dmb.rgid = lgr->peer_gid.gid;
>  	rc = lgr->smcd->ops->register_dmb(lgr->smcd, &dmb, &smc_ism_client);
>  	if (!rc) {
>  		dmb_desc->sba_idx = dmb.sba_idx;
> @@ -340,18 +341,20 @@ struct smc_ism_event_work {
>  
>  static void smcd_handle_sw_event(struct smc_ism_event_work *wrk)
>  {
> +	struct smcd_gid peer_gid = { .gid = wrk->event.tok,
> +				     .gid_ext = 0 };
>  	union smcd_sw_event_info ev_info;
>  
>  	ev_info.info = wrk->event.info;
>  	switch (wrk->event.code) {
>  	case ISM_EVENT_CODE_SHUTDOWN:	/* Peer shut down DMBs */
> -		smc_smcd_terminate(wrk->smcd, wrk->event.tok, ev_info.vlan_id);
> +		smc_smcd_terminate(wrk->smcd, &peer_gid, ev_info.vlan_id);
>  		break;
>  	case ISM_EVENT_CODE_TESTLINK:	/* Activity timer */
>  		if (ev_info.code == ISM_EVENT_REQUEST) {
>  			ev_info.code = ISM_EVENT_RESPONSE;
>  			wrk->smcd->ops->signal_event(wrk->smcd,
> -						     wrk->event.tok,
> +						     &peer_gid,
>  						     ISM_EVENT_REQUEST_IR,
>  						     ISM_EVENT_CODE_TESTLINK,
>  						     ev_info.info);
> @@ -365,10 +368,12 @@ static void smc_ism_event_work(struct work_struct *work)
>  {
>  	struct smc_ism_event_work *wrk =
>  		container_of(work, struct smc_ism_event_work, work);
> +	struct smcd_gid smcd_gid = { .gid = wrk->event.tok,
> +				     .gid_ext = 0 };
>  
>  	switch (wrk->event.type) {
>  	case ISM_EVENT_GID:	/* GID event, token is peer GID */
> -		smc_smcd_terminate(wrk->smcd, wrk->event.tok, VLAN_VID_MASK);
> +		smc_smcd_terminate(wrk->smcd, &smcd_gid, VLAN_VID_MASK);
>  		break;
>  	case ISM_EVENT_DMB:
>  		break;
> @@ -525,7 +530,7 @@ int smc_ism_signal_shutdown(struct smc_link_group *lgr)
>  	memcpy(ev_info.uid, lgr->id, SMC_LGR_ID_SIZE);
>  	ev_info.vlan_id = lgr->vlan_id;
>  	ev_info.code = ISM_EVENT_REQUEST;
> -	rc = lgr->smcd->ops->signal_event(lgr->smcd, lgr->peer_gid,
> +	rc = lgr->smcd->ops->signal_event(lgr->smcd, &lgr->peer_gid,
>  					  ISM_EVENT_REQUEST_IR,
>  					  ISM_EVENT_CODE_SHUTDOWN,
>  					  ev_info.info);
[...]
