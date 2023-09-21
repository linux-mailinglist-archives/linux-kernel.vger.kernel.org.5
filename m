Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0107AA5B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjIUXhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjIUXhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:37:48 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9671129;
        Thu, 21 Sep 2023 16:37:37 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LNbHU6006989;
        Thu, 21 Sep 2023 23:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6frfaR+mGjgWkxpLGIwlHQPJ482h1kBrBY/clzdMMPg=;
 b=Qo24VLdBtE2fVvZmknXcb1JCLKq/gpAzci4F5z6Cdhh5Mx7hzVRwStvpZvVRDXihHuHt
 IQytS/5k4dAeuhqxsY4fbBBJjZlnsHUWbiFudg6mGwtm19Z76OLIorn2Fb1nGpIK1cvF
 sSn9vdEe+ICi1V/HDNNaPREF1nazhdpIQzVD76FdedNbNOuNxvU+eAwOl75t2in1N3Ti
 7Zl6kLSZS/+aW1tXM92aECYnuqL68JZ4qUDUaUxGnojT/f68xz5YxK+mPBc+GMpSrGT+
 igS/9Ixz1F/hJ4JPQST9Gwtg0NP19nTyVwe1Cd6H54Y0Xxpqiu+VSGX47hWJlhjMBu2t yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t8x1023q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 23:37:32 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38LNbVI7008837;
        Thu, 21 Sep 2023 23:37:31 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t8x1023he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 23:37:31 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38LN6ZXp022936;
        Thu, 21 Sep 2023 23:32:26 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t8tspvrhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 23:32:26 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38LNWP7D36504192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 23:32:25 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DD0F58043;
        Thu, 21 Sep 2023 23:32:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1660D58053;
        Thu, 21 Sep 2023 23:32:23 +0000 (GMT)
Received: from [9.171.4.137] (unknown [9.171.4.137])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 21 Sep 2023 23:32:22 +0000 (GMT)
Message-ID: <d2878b74-9bd4-dd6b-8ecd-75f22a4730d4@linux.ibm.com>
Date:   Fri, 22 Sep 2023 01:32:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
From:   Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [PATCH net-next v3 06/18] net/smc: extend GID to 128bits for
 virtual ISM device
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1695302360-46691-1-git-send-email-guwen@linux.alibaba.com>
 <1695302360-46691-7-git-send-email-guwen@linux.alibaba.com>
In-Reply-To: <1695302360-46691-7-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ea8ALVbglfHCoBrwuzJukIRngddg-K4N
X-Proofpoint-GUID: qf0NSUpWc2pVVW7w0a-4kY4eXIYNkWll
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309210205
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.09.23 15:19, Wen Gu wrote:
> As the SMC-Dv2 protocol introduces virtual ISM devices, whose GIDs
> are UUIDs generated by software, the maximum length of SMC-D GID has
> been extended to 128 bits.
> 
I think it is necessary to say that the GID is extended to 128 bits only 
for virtuel ISM device(s).

> So this patch adapts the relevant code to make it compatible with
> 128 bits GID.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   drivers/s390/net/ism_drv.c | 17 +++++++++--------
>   include/net/smc.h          | 15 ++++++++++-----
>   include/uapi/linux/smc.h   |  3 +++
>   net/smc/af_smc.c           | 45 +++++++++++++++++++++++++++++++++------------
>   net/smc/smc_clc.c          | 35 ++++++++++++++++++++++++-----------
>   net/smc/smc_clc.h          |  4 ++--
>   net/smc/smc_core.c         | 38 +++++++++++++++++++++++++++++---------
>   net/smc/smc_core.h         |  7 ++++---
>   net/smc/smc_diag.c         |  6 ++++--
>   net/smc/smc_ism.c          | 18 ++++++++++++------
>   net/smc/smc_ism.h          |  3 ++-
>   net/smc/smc_pnet.c         |  4 ++--
>   12 files changed, 134 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> index a34e913..7801a6a 100644
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
> @@ -774,10 +774,10 @@ static void __exit ism_exit(void)
>   /*************************** SMC-D Implementation *****************************/
>   
>   #if IS_ENABLED(CONFIG_SMC)
> -static int smcd_query_rgid(struct smcd_dev *smcd, u64 rgid, u32 vid_valid,
> -			   u32 vid)
> +static int smcd_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
> +			   u32 vid_valid, u32 vid)
>   {
> -	return ism_query_rgid(smcd->priv, rgid, vid_valid, vid);
> +	return ism_query_rgid(smcd->priv, rgid->gid, vid_valid, vid);
>   }
>   
>   static int smcd_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
> @@ -811,10 +811,10 @@ static int smcd_reset_vlan_required(struct smcd_dev *smcd)
>   	return ism_cmd_simple(smcd->priv, ISM_RESET_VLAN);
>   }
>   
> -static int smcd_signal_ieq(struct smcd_dev *smcd, u64 rgid, u32 trigger_irq,
> -			   u32 event_code, u64 info)
> +static int smcd_signal_ieq(struct smcd_dev *smcd, struct smcd_gid *rgid,
> +			   u32 trigger_irq, u32 event_code, u64 info)
>   {
> -	return ism_signal_ieq(smcd->priv, rgid, trigger_irq, event_code, info);
> +	return ism_signal_ieq(smcd->priv, rgid->gid, trigger_irq, event_code, info);
>   }
>   
>   static int smcd_move(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx,
> @@ -830,9 +830,10 @@ static int smcd_supports_v2(void)
>   		SYSTEM_EID.type[0] != '0';
>   }
>   
> -static u64 smcd_get_local_gid(struct smcd_dev *smcd)
> +static void smcd_get_local_gid(struct smcd_dev *smcd,
> +			       struct smcd_gid *smcd_gid)
>   {
> -	return ism_get_local_gid(smcd->priv);
> +	smcd_gid->gid = ism_get_local_gid(smcd->priv);
>   }
>   
>   static u16 smcd_get_chid(struct smcd_dev *smcd)
> diff --git a/include/net/smc.h b/include/net/smc.h
> index f75116e..d8db5e1 100644
> --- a/include/net/smc.h
> +++ b/include/net/smc.h
> @@ -51,9 +51,14 @@ struct smcd_dmb {
>   
>   struct smcd_dev;
>   
> +struct smcd_gid {
> +	u64	gid;
> +	u64	gid_ext;
> +};
> +
>   struct smcd_ops {
> -	int (*query_remote_gid)(struct smcd_dev *dev, u64 rgid, u32 vid_valid,
> -				u32 vid);
> +	int (*query_remote_gid)(struct smcd_dev *dev, struct smcd_gid *rgid,
> +				u32 vid_valid, u32 vid);
>   	int (*register_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb,
>   			    void *client);
>   	int (*unregister_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb);
> @@ -61,14 +66,14 @@ struct smcd_ops {
>   	int (*del_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
>   	int (*set_vlan_required)(struct smcd_dev *dev);
>   	int (*reset_vlan_required)(struct smcd_dev *dev);
> -	int (*signal_event)(struct smcd_dev *dev, u64 rgid, u32 trigger_irq,
> -			    u32 event_code, u64 info);
> +	int (*signal_event)(struct smcd_dev *dev, struct smcd_gid *rgid,
> +			    u32 trigger_irq, u32 event_code, u64 info);
>   	int (*move_data)(struct smcd_dev *dev, u64 dmb_tok, unsigned int idx,
>   			 bool sf, unsigned int offset, void *data,
>   			 unsigned int size);
>   	int (*supports_v2)(void);
>   	u8* (*get_system_eid)(void);
> -	u64 (*get_local_gid)(struct smcd_dev *dev);
> +	void (*get_local_gid)(struct smcd_dev *dev, struct smcd_gid *gid);
>   	u16 (*get_chid)(struct smcd_dev *dev);
>   	struct device* (*get_dev)(struct smcd_dev *dev);
>   };
> diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
> index 837fcd4..0d2f020 100644
> --- a/include/uapi/linux/smc.h
> +++ b/include/uapi/linux/smc.h
> @@ -99,6 +99,9 @@ enum {
>   	SMC_NLA_LGR_V2_OS,		/* u8 */
>   	SMC_NLA_LGR_V2_NEG_EID,		/* string */
>   	SMC_NLA_LGR_V2_PEER_HOST,	/* string */
> +	SMC_NLA_LGR_V2_PAD,		/* flag */
> +	SMC_NLA_LGR_V2_GID_EXT,		/* u64 */
> +	SMC_NLA_LGR_V2_PEER_GID_EXT,	/* u64 */
>   	__SMC_NLA_LGR_V2_MAX,
>   	SMC_NLA_LGR_V2_MAX = __SMC_NLA_LGR_V2_MAX - 1
>   };
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index bacdd97..9e31033 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1044,7 +1044,8 @@ static int smc_find_ism_v2_device_clnt(struct smc_sock *smc,
>   {
>   	int rc = SMC_CLC_DECL_NOSMCDDEV;
>   	struct smcd_dev *smcd;
> -	int i = 1;
> +	int i = 1, slot = 1;
> +	bool is_virtdev;
>   	u16 chid;
>   
>   	if (smcd_indicated(ini->smc_type_v1))
> @@ -1056,14 +1057,19 @@ static int smc_find_ism_v2_device_clnt(struct smc_sock *smc,
>   		chid = smc_ism_get_chid(smcd);
>   		if (!smc_find_ism_v2_is_unique_chid(chid, ini, i))
>   			continue;
> +		is_virtdev = __smc_ism_is_virtdev(chid);
>   		if (!smc_pnet_is_pnetid_set(smcd->pnetid) ||
>   		    smc_pnet_is_ndev_pnetid(sock_net(&smc->sk), smcd->pnetid)) {
> +			/* GID-CHID array is not enough for a virtual GID (128bits) */
> +			if (is_virtdev && slot >= SMC_MAX_ISM_DEVS)
> +				continue;

I'm wondering what the check is for. e.g. If slot is 8 after checking if 
(slot > SMC_MAX_ISM_DEVS) later, then does makes sense to continue the 
iteration?
>   			ini->ism_dev[i] = smcd;
>   			ini->ism_chid[i] = chid;
>   			ini->is_smcd = true;
>   			rc = 0;
>   			i++;
> -			if (i > SMC_MAX_ISM_DEVS)
> +			slot = is_virtdev ? slot + 2 : slot + 1;
> +			if (slot > SMC_MAX_ISM_DEVS)
>   				break;
>   		}
>   	}
> @@ -1409,8 +1415,9 @@ static int smc_connect_ism(struct smc_sock *smc,
>   		rc = smc_v2_determine_accepted_chid(aclc_v2, ini);
>   		if (rc)
>   			return rc;
> +		ini->ism_peer_gid[ini->ism_selected].gid_ext = aclc_v2->d1.gid_ext;
>   	}
> -	ini->ism_peer_gid[ini->ism_selected] = aclc->d0.gid;
> +	ini->ism_peer_gid[ini->ism_selected].gid = aclc->d0.gid;
>   
>   	/* there is only one lgr role for SMC-D; use server lock */
>   	mutex_lock(&smc_server_lgr_pending);
> @@ -2101,7 +2108,8 @@ static bool smc_is_already_selected(struct smcd_dev *smcd,
>   
>   /* check for ISM devices matching proposed ISM devices */
>   static void smc_check_ism_v2_match(struct smc_init_info *ini,
> -				   u16 proposed_chid, u64 proposed_gid,
> +				   u16 proposed_chid,
> +				   struct smcd_gid *proposed_gid,
>   				   unsigned int *matches)
>   {
>   	struct smcd_dev *smcd;
> @@ -2113,7 +2121,10 @@ static void smc_check_ism_v2_match(struct smc_init_info *ini,
>   			continue;
>   		if (smc_ism_get_chid(smcd) == proposed_chid &&
>   		    !smc_ism_cantalk(proposed_gid, ISM_RESERVED_VLANID, smcd)) {
> -			ini->ism_peer_gid[*matches] = proposed_gid;
> +			ini->ism_peer_gid[*matches].gid = proposed_gid->gid;
> +			if (__smc_ism_is_virtdev(proposed_chid))
> +				ini->ism_peer_gid[*matches].gid_ext =
> +							proposed_gid->gid_ext;
>   			ini->ism_dev[*matches] = smcd;
>   			(*matches)++;
>   			break;
> @@ -2135,9 +2146,11 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
>   	struct smc_clc_v2_extension *smc_v2_ext;
>   	struct smc_clc_msg_smcd *pclc_smcd;
>   	unsigned int matches = 0;
> +	struct smcd_gid smcd_gid;
>   	u8 smcd_version;
>   	u8 *eid = NULL;
>   	int i, rc;
> +	u16 chid;
>   
>   	if (!(ini->smcd_version & SMC_V2) || !smcd_indicated(ini->smc_type_v2))
>   		goto not_found;
> @@ -2147,18 +2160,26 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
>   	smcd_v2_ext = smc_get_clc_smcd_v2_ext(smc_v2_ext);
>   
>   	mutex_lock(&smcd_dev_list.mutex);
> -	if (pclc_smcd->ism.chid)
> +	if (pclc_smcd->ism.chid) {
>   		/* check for ISM device matching proposed native ISM device */
> +		smcd_gid.gid = ntohll(pclc_smcd->ism.gid);
>   		smc_check_ism_v2_match(ini, ntohs(pclc_smcd->ism.chid),
> -				       ntohll(pclc_smcd->ism.gid), &matches);
> +				       &smcd_gid, &matches);
> +	}
>   	for (i = 1; i <= smc_v2_ext->hdr.ism_gid_cnt; i++) {
>   		/* check for ISM devices matching proposed non-native ISM
>   		 * devices
>   		 */
> -		smc_check_ism_v2_match(ini,
> -				       ntohs(smcd_v2_ext->gidchid[i - 1].chid),
> -				       ntohll(smcd_v2_ext->gidchid[i - 1].gid),
> -				       &matches);
> +		smcd_gid.gid = ntohll(smcd_v2_ext->gidchid[i - 1].gid);
> +		chid = ntohs(smcd_v2_ext->gidchid[i - 1].chid);
> +		if (__smc_ism_is_virtdev(chid)) {
> +			/* check if extended entry exists and is valid */
> +			if (i >= smc_v2_ext->hdr.ism_gid_cnt ||
> +			    chid != ntohs(smcd_v2_ext->gidchid[i].chid))
> +				continue;
> +			smcd_gid.gid_ext = ntohll(smcd_v2_ext->gidchid[i++].gid);
> +		}
> +		smc_check_ism_v2_match(ini, chid, &smcd_gid, &matches);
Here is also not that clean with smcd_gid.
E.g. the 1st device is a virtual device, then
smcd_gid.gid_ext = ntohll(smcd_v2_ext->gidchid[2].gid)
while the 2nd device is not virtual one, then the smcd_gid.gid is 
rewritten, but the smcd_gid.gid_ext is still 
ntohll(smcd_v2_ext->gidchid[2].gid)
>   	}
>   	mutex_unlock(&smcd_dev_list.mutex);
>   
IMO, I don't think that is a good idea to use the same varable smcd_gid 
for checking both native ISM device and non-native ISM device. Because 
the compiler can LOAD and Store the value you don't really want from the 
perspective of optimization.

> @@ -2207,7 +2228,7 @@ static void smc_find_ism_v1_device_serv(struct smc_sock *new_smc,
>   	if (!(ini->smcd_version & SMC_V1) || !smcd_indicated(ini->smc_type_v1))
>   		goto not_found;
>   	ini->is_smcd = true; /* prepare ISM check */
> -	ini->ism_peer_gid[0] = ntohll(pclc_smcd->ism.gid);
> +	ini->ism_peer_gid[0].gid = ntohll(pclc_smcd->ism.gid);
>   	rc = smc_find_ism_device(new_smc, ini);
>   	if (rc)
>   		goto not_found;
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index 125b0d2..c08e138 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -882,11 +882,13 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>   		       ETH_ALEN);
>   	}
>   	if (smcd_indicated(ini->smc_type_v1)) {
> +		struct smcd_gid smcd_gid;
> +
>   		/* add SMC-D specifics */
>   		if (ini->ism_dev[0]) {
>   			smcd = ini->ism_dev[0];
> -			pclc_smcd->ism.gid =
> -				htonll(smcd->ops->get_local_gid(smcd));
> +			smcd->ops->get_local_gid(smcd, &smcd_gid);
> +			pclc_smcd->ism.gid = htonll(smcd_gid.gid);
>   			pclc_smcd->ism.chid =
>   				htons(smc_ism_get_chid(ini->ism_dev[0]));
>   		}
> @@ -919,10 +921,11 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>   		read_unlock(&smc_clc_eid_table.lock);
>   	}
>   	if (smcd_indicated(ini->smc_type_v2)) {
> +		struct smcd_gid smcd_gid;
>   		u8 *eid = NULL;
> +		int slot = 0;
>   
>   		v2_ext->hdr.flag.seid = smc_clc_eid_table.seid_enabled;
> -		v2_ext->hdr.ism_gid_cnt = ini->ism_offered_cnt;
>   		v2_ext->hdr.smcd_v2_ext_offset = htons(sizeof(*v2_ext) -
>   				offsetofend(struct smc_clnt_opts_area_hdr,
>   					    smcd_v2_ext_offset) +
> @@ -934,14 +937,21 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>   		if (ini->ism_offered_cnt) {
>   			for (i = 1; i <= ini->ism_offered_cnt; i++) {
>   				smcd = ini->ism_dev[i];
> -				gidchids[i - 1].gid =
> -					htonll(smcd->ops->get_local_gid(smcd));
> -				gidchids[i - 1].chid =
> +				smcd->ops->get_local_gid(smcd, &smcd_gid);
> +				gidchids[slot].chid =
>   					htons(smc_ism_get_chid(ini->ism_dev[i]));
> +				gidchids[slot].gid = htonll(smcd_gid.gid);
> +				/* virtual-ism takes two slots */
> +				if (__smc_ism_is_virtdev(gidchids[slot].chid)) {
> +					gidchids[slot + 1].chid = gidchids[slot].chid;
> +					gidchids[slot + 1].gid = htonll(smcd_gid.gid_ext);
> +					slot++;
> +				}
> +				slot++;
>   			}
> -			plen += ini->ism_offered_cnt *
> -				sizeof(struct smc_clc_smcd_gid_chid);
> +			plen += slot * sizeof(struct smc_clc_smcd_gid_chid);
>   		}
> +		v2_ext->hdr.ism_gid_cnt = slot;
>   	}
>   	if (smcr_indicated(ini->smc_type_v2)) {
>   		memcpy(v2_ext->roce, ini->smcrv2.ib_gid_v2, SMC_GID_SIZE);
> @@ -977,7 +987,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>   			vec[i++].iov_len = sizeof(*smcd_v2_ext);
>   			if (ini->ism_offered_cnt) {
>   				vec[i].iov_base = gidchids;
> -				vec[i++].iov_len = ini->ism_offered_cnt *
> +				vec[i++].iov_len = v2_ext->hdr.ism_gid_cnt *
>   					sizeof(struct smc_clc_smcd_gid_chid);
>   			}
>   		}
> @@ -1019,12 +1029,14 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>   	if (first_contact)
>   		clc->hdr.typev2 |= SMC_FIRST_CONTACT_MASK;
>   	if (conn->lgr->is_smcd) {
> +		struct smcd_gid smcd_gid;
> +
>   		/* SMC-D specific settings */
>   		memcpy(clc->hdr.eyecatcher, SMCD_EYECATCHER,
>   		       sizeof(SMCD_EYECATCHER));
> +		conn->lgr->smcd->ops->get_local_gid(conn->lgr->smcd, &smcd_gid);
>   		clc->hdr.typev1 = SMC_TYPE_D;
> -		clc->d0.gid =
> -			conn->lgr->smcd->ops->get_local_gid(conn->lgr->smcd);
> +		clc->d0.gid = smcd_gid.gid;
>   		clc->d0.token = conn->rmb_desc->token;
>   		clc->d0.dmbe_size = conn->rmbe_size_comp;
>   		clc->d0.dmbe_idx = 0;
> @@ -1036,6 +1048,7 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>   				htons(smc_ism_get_chid(conn->lgr->smcd));
>   			if (eid && eid[0])
>   				memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
> +			clc_v2->d1.gid_ext = smcd_gid.gid_ext;
>   			len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
>   			if (first_contact) {
>   				fce_len = smc_clc_fill_fce(&fce, ini);
> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index bcf37c8..611763a 100644
> --- a/net/smc/smc_clc.h
> +++ b/net/smc/smc_clc.h
> @@ -281,8 +281,8 @@ struct smc_clc_msg_accept_confirm_v2 {	/* clc accept / confirm message */
>   			struct smcd_clc_msg_accept_confirm_common d0;
>   			__be16 chid;
>   			u8 eid[SMC_MAX_EID_LEN];
> -			u8 reserved5[8];
> -		} d1;
> +			__be64 gid_ext;
> +		} __packed d1;
>   	};
>   };
>   
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index d520ee6..c36500a 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -284,6 +284,9 @@ static int smc_nl_fill_lgr_v2_common(struct smc_link_group *lgr,
>   {
>   	char smc_host[SMC_MAX_HOSTNAME_LEN + 1];
>   	char smc_eid[SMC_MAX_EID_LEN + 1];
> +	struct smcd_dev *smcd = lgr->smcd;
> +	struct smcd_gid smcd_gid;
> +	bool is_virtdev;
>   
>   	if (nla_put_u8(skb, SMC_NLA_LGR_V2_VER, lgr->smc_version))
>   		goto errv2attr;
> @@ -299,6 +302,16 @@ static int smc_nl_fill_lgr_v2_common(struct smc_link_group *lgr,
>   	smc_eid[SMC_MAX_EID_LEN] = 0;
>   	if (nla_put_string(skb, SMC_NLA_LGR_V2_NEG_EID, smc_eid))
>   		goto errv2attr;
> +	smcd->ops->get_local_gid(smcd, &smcd_gid);
> +	is_virtdev = smc_ism_is_virtdev(smcd);
> +	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_V2_GID_EXT,
> +			      is_virtdev ? smcd_gid.gid_ext : 0,
> +			      SMC_NLA_LGR_V2_PAD))
> +		goto errv2attr;
> +	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_V2_PEER_GID_EXT,
> +			      is_virtdev ? lgr->peer_gid.gid_ext : 0,
> +			      SMC_NLA_LGR_V2_PAD))
> +		goto errv2attr;
>   
>   	nla_nest_end(skb, v2_attrs);
>   	return 0;
> @@ -506,6 +519,7 @@ static int smc_nl_fill_smcd_lgr(struct smc_link_group *lgr,
>   {
>   	char smc_pnet[SMC_MAX_PNETID_LEN + 1];
>   	struct smcd_dev *smcd = lgr->smcd;
> +	struct smcd_gid smcd_gid;
>   	struct nlattr *attrs;
>   	void *nlh;
>   
> @@ -521,11 +535,11 @@ static int smc_nl_fill_smcd_lgr(struct smc_link_group *lgr,
>   
>   	if (nla_put_u32(skb, SMC_NLA_LGR_D_ID, *((u32 *)&lgr->id)))
>   		goto errattr;
> +	smcd->ops->get_local_gid(smcd, &smcd_gid);
>   	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_D_GID,
> -			      smcd->ops->get_local_gid(smcd),
> -				  SMC_NLA_LGR_D_PAD))
> +			      smcd_gid.gid, SMC_NLA_LGR_D_PAD))
>   		goto errattr;
> -	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_D_PEER_GID, lgr->peer_gid,
> +	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_D_PEER_GID, lgr->peer_gid.gid,
>   			      SMC_NLA_LGR_D_PAD))
>   		goto errattr;
>   	if (nla_put_u8(skb, SMC_NLA_LGR_D_VLAN_ID, lgr->vlan_id))
> @@ -1514,7 +1528,8 @@ void smc_lgr_terminate_sched(struct smc_link_group *lgr)
>   }
>   
>   /* Called when peer lgr shutdown (regularly or abnormally) is received */
> -void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
> +void smc_smcd_terminate(struct smcd_dev *dev, struct smcd_gid *peer_gid,
> +			unsigned short vlan)
>   {
>   	struct smc_link_group *lgr, *l;
>   	LIST_HEAD(lgr_free_list);
> @@ -1522,7 +1537,10 @@ void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
>   	/* run common cleanup function and build free list */
>   	spin_lock_bh(&dev->lgr_lock);
>   	list_for_each_entry_safe(lgr, l, &dev->lgr_list, list) {
> -		if ((!peer_gid || lgr->peer_gid == peer_gid) &&
> +		if ((!peer_gid->gid ||
> +		     (lgr->peer_gid.gid == peer_gid->gid &&
> +		      !smc_ism_is_virtdev(dev) ? 1 :
> +		      lgr->peer_gid.gid_ext == peer_gid->gid_ext)) &&
>   		    (vlan == VLAN_VID_MASK || lgr->vlan_id == vlan)) {
>   			if (peer_gid) /* peer triggered termination */
>   				lgr->peer_shutdown = 1;
> @@ -1859,10 +1877,12 @@ static bool smcr_lgr_match(struct smc_link_group *lgr, u8 smcr_version,
>   	return false;
>   }
>   
> -static bool smcd_lgr_match(struct smc_link_group *lgr,
> -			   struct smcd_dev *smcismdev, u64 peer_gid)
> +static bool smcd_lgr_match(struct smc_link_group *lgr, struct smcd_dev *smcismdev,
> +			   struct smcd_gid *peer_gid)
>   {
> -	return lgr->peer_gid == peer_gid && lgr->smcd == smcismdev;
> +	return lgr->peer_gid.gid == peer_gid->gid && lgr->smcd == smcismdev &&
> +		smc_ism_is_virtdev(smcismdev) ?
> +		(lgr->peer_gid.gid_ext == peer_gid->gid_ext) : 1;
>   }
>   
>   /* create a new SMC connection (and a new link group if necessary) */
> @@ -1892,7 +1912,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
>   		write_lock_bh(&lgr->conns_lock);
>   		if ((ini->is_smcd ?
>   		     smcd_lgr_match(lgr, ini->ism_dev[ini->ism_selected],
> -				    ini->ism_peer_gid[ini->ism_selected]) :
> +				    &ini->ism_peer_gid[ini->ism_selected]) :
>   		     smcr_lgr_match(lgr, ini->smcr_version,
>   				    ini->peer_systemid,
>   				    ini->peer_gid, ini->peer_mac, role,
> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
> index 9f65678..d57eb9b 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -17,6 +17,7 @@
>   #include <linux/pci.h>
>   #include <rdma/ib_verbs.h>
>   #include <net/genetlink.h>
> +#include <net/smc.h>
>   
>   #include "smc.h"
>   #include "smc_ib.h"
> @@ -355,7 +356,7 @@ struct smc_link_group {
>   						/* max links can be added in lgr */
>   		};
>   		struct { /* SMC-D */
> -			u64			peer_gid;
> +			struct smcd_gid		peer_gid;
>   						/* Peer GID (remote) */
>   			struct smcd_dev		*smcd;
>   						/* ISM device for VLAN reg. */
> @@ -417,7 +418,7 @@ struct smc_init_info {
>   	u32			ib_clcqpn;
>   	struct smc_init_info_smcrv2 smcrv2;
>   	/* SMC-D */
> -	u64			ism_peer_gid[SMC_MAX_ISM_DEVS + 1];
> +	struct smcd_gid		ism_peer_gid[SMC_MAX_ISM_DEVS + 1];
>   	struct smcd_dev		*ism_dev[SMC_MAX_ISM_DEVS + 1];
>   	u16			ism_chid[SMC_MAX_ISM_DEVS + 1];
>   	u8			ism_offered_cnt; /* # of ISM devices offered */
> @@ -545,7 +546,7 @@ static inline void smc_set_pci_values(struct pci_dev *pci_dev,
>   void smc_lgr_put(struct smc_link_group *lgr);
>   void smcr_port_add(struct smc_ib_device *smcibdev, u8 ibport);
>   void smcr_port_err(struct smc_ib_device *smcibdev, u8 ibport);
> -void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid,
> +void smc_smcd_terminate(struct smcd_dev *dev, struct smcd_gid *peer_gid,
>   			unsigned short vlan);
>   void smc_smcd_terminate_all(struct smcd_dev *dev);
>   void smc_smcr_terminate_all(struct smc_ib_device *smcibdev);
> diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
> index 7ff2152..9c465cc 100644
> --- a/net/smc/smc_diag.c
> +++ b/net/smc/smc_diag.c
> @@ -168,12 +168,14 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
>   		struct smc_connection *conn = &smc->conn;
>   		struct smcd_diag_dmbinfo dinfo;
>   		struct smcd_dev *smcd = conn->lgr->smcd;
> +		struct smcd_gid smcd_gid;
>   
>   		memset(&dinfo, 0, sizeof(dinfo));
>   
>   		dinfo.linkid = *((u32 *)conn->lgr->id);
> -		dinfo.peer_gid = conn->lgr->peer_gid;
> -		dinfo.my_gid = smcd->ops->get_local_gid(smcd);
> +		dinfo.peer_gid = conn->lgr->peer_gid.gid;
> +		smcd->ops->get_local_gid(smcd, &smcd_gid);
> +		dinfo.my_gid = smcd_gid.gid;
>   		dinfo.token = conn->rmb_desc->token;
>   		dinfo.peer_token = conn->peer_token;
>   
> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> index 8f1ba74..35d31e7 100644
> --- a/net/smc/smc_ism.c
> +++ b/net/smc/smc_ism.c
> @@ -44,7 +44,8 @@ static void smcd_handle_irq(struct ism_dev *ism, unsigned int dmbno,
>   #endif
>   
>   /* Test if an ISM communication is possible - same CPC */
> -int smc_ism_cantalk(u64 peer_gid, unsigned short vlan_id, struct smcd_dev *smcd)
> +int smc_ism_cantalk(struct smcd_gid *peer_gid, unsigned short vlan_id,
> +		    struct smcd_dev *smcd)
>   {
>   	return smcd->ops->query_remote_gid(smcd, peer_gid, vlan_id ? 1 : 0,
>   					   vlan_id);
> @@ -223,7 +224,7 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
>   	dmb.dmb_len = dmb_len;
>   	dmb.sba_idx = dmb_desc->sba_idx;
>   	dmb.vlan_id = lgr->vlan_id;
> -	dmb.rgid = lgr->peer_gid;
> +	dmb.rgid = lgr->peer_gid.gid;
>   	rc = lgr->smcd->ops->register_dmb(lgr->smcd, &dmb, lgr->smcd->client);
>   	if (!rc) {
>   		dmb_desc->sba_idx = dmb.sba_idx;
> @@ -354,17 +355,20 @@ struct smc_ism_event_work {
>   static void smcd_handle_sw_event(struct smc_ism_event_work *wrk)
>   {
>   	union smcd_sw_event_info ev_info;
> +	struct smcd_gid peer_gid;
>   
>   	ev_info.info = wrk->event.info;
>   	switch (wrk->event.code) {
>   	case ISM_EVENT_CODE_SHUTDOWN:	/* Peer shut down DMBs */
> -		smc_smcd_terminate(wrk->smcd, wrk->event.tok, ev_info.vlan_id);
> +		peer_gid.gid = wrk->event.tok;
> +		smc_smcd_terminate(wrk->smcd, &peer_gid, ev_info.vlan_id);
>   		break;
>   	case ISM_EVENT_CODE_TESTLINK:	/* Activity timer */
> +		peer_gid.gid = wrk->event.tok;
>   		if (ev_info.code == ISM_EVENT_REQUEST) {
>   			ev_info.code = ISM_EVENT_RESPONSE;
>   			wrk->smcd->ops->signal_event(wrk->smcd,
> -						     wrk->event.tok,
> +						     &peer_gid,
>   						     ISM_EVENT_REQUEST_IR,
>   						     ISM_EVENT_CODE_TESTLINK,
>   						     ev_info.info);
> @@ -378,10 +382,12 @@ static void smc_ism_event_work(struct work_struct *work)
>   {
>   	struct smc_ism_event_work *wrk =
>   		container_of(work, struct smc_ism_event_work, work);
> +	struct smcd_gid smcd_gid;
>   
>   	switch (wrk->event.type) {
>   	case ISM_EVENT_GID:	/* GID event, token is peer GID */
> -		smc_smcd_terminate(wrk->smcd, wrk->event.tok, VLAN_VID_MASK);
> +		smcd_gid.gid = wrk->event.tok;
> +		smc_smcd_terminate(wrk->smcd, &smcd_gid, VLAN_VID_MASK);
>   		break;
>   	case ISM_EVENT_DMB:
>   		break;
> @@ -530,7 +536,7 @@ int smc_ism_signal_shutdown(struct smc_link_group *lgr)
>   	memcpy(ev_info.uid, lgr->id, SMC_LGR_ID_SIZE);
>   	ev_info.vlan_id = lgr->vlan_id;
>   	ev_info.code = ISM_EVENT_REQUEST;
> -	rc = lgr->smcd->ops->signal_event(lgr->smcd, lgr->peer_gid,
> +	rc = lgr->smcd->ops->signal_event(lgr->smcd, &lgr->peer_gid,
>   					  ISM_EVENT_REQUEST_IR,
>   					  ISM_EVENT_CODE_SHUTDOWN,
>   					  ev_info.info);
> diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
> index 2ecc8de..e6ea08c 100644
> --- a/net/smc/smc_ism.h
> +++ b/net/smc/smc_ism.h
> @@ -33,7 +33,8 @@ struct smc_ism_vlanid {			/* VLAN id set on ISM device */
>   
>   struct smcd_dev;
>   
> -int smc_ism_cantalk(u64 peer_gid, unsigned short vlan_id, struct smcd_dev *dev);
> +int smc_ism_cantalk(struct smcd_gid *peer_gid, unsigned short vlan_id,
> +		    struct smcd_dev *dev);
>   void smc_ism_set_conn(struct smc_connection *conn);
>   void smc_ism_unset_conn(struct smc_connection *conn);
>   int smc_ism_get_vlan(struct smcd_dev *dev, unsigned short vlan_id);
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 1177540..9f2c58c 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -1103,8 +1103,8 @@ static void smc_pnet_find_ism_by_pnetid(struct net_device *ndev,
>   	list_for_each_entry(ismdev, &smcd_dev_list.list, list) {
>   		if (smc_pnet_match(ismdev->pnetid, ndev_pnetid) &&
>   		    !ismdev->going_away &&
> -		    (!ini->ism_peer_gid[0] ||
> -		     !smc_ism_cantalk(ini->ism_peer_gid[0], ini->vlan_id,
> +		    (!ini->ism_peer_gid[0].gid ||
> +		     !smc_ism_cantalk(&ini->ism_peer_gid[0], ini->vlan_id,
>   				      ismdev))) {
>   			ini->ism_dev[0] = ismdev;
>   			break;
