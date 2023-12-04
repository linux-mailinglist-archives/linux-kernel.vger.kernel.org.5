Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2FF802E48
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjLDJPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjLDJPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:15:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1804102;
        Mon,  4 Dec 2023 01:15:14 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B48gvrb000523;
        Mon, 4 Dec 2023 09:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=01OPOW75e+U6La/vwY6Hbbji8DSQjSaSwvGf99bqoqg=;
 b=J4NAlwMY4aWTsUYbGTcvTxI86EPYH7stai/Xrbvzs/Uzo/A4qOMrq2iYwUrobDM23hYV
 HG1bLSdwABwJ3H5plXUl5gADpAcgZyF2/DvxuCa44txqCCPY4wZeuoqMnXWfNgj5iF+4
 6HIIw/CHs/pyllSoJOKDIjW5rqH2ctlPdIKGsAAUMzBiAqIc7GNr3n/40hp4oWwHhztU
 91P1r1wImkv7Hskx75wYiWd80UNjmmksJgD8fBOsnfZG8L+6THrAz/2D2r5q1jl+fGGH
 NmzSL/XFcHZE2Jmz/FUZ7361P0NqTOZ7VhYMWZyFPu3nQwirSMFjanTBAR2lVZEJsHsK tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usbgf0xrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 09:15:11 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B48tSPE011097;
        Mon, 4 Dec 2023 09:15:11 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usbgf0xqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 09:15:10 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B474aFw008642;
        Mon, 4 Dec 2023 09:15:09 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3urh4k6t8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 09:15:09 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B49F85i13894312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Dec 2023 09:15:09 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF2B658063;
        Mon,  4 Dec 2023 09:15:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D41058059;
        Mon,  4 Dec 2023 09:15:05 +0000 (GMT)
Received: from [9.155.210.31] (unknown [9.155.210.31])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  4 Dec 2023 09:15:04 +0000 (GMT)
Message-ID: <117f0100-a3c2-49c2-88a9-aa0835942773@linux.ibm.com>
Date:   Mon, 4 Dec 2023 10:15:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/7] net/smc: compatible with 128-bits extend
 GID of virtual ISM device
To:     Alexandra Winter <wintera@linux.ibm.com>,
        Wen Gu <guwen@linux.alibaba.com>, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1701343695-122657-1-git-send-email-guwen@linux.alibaba.com>
 <1701343695-122657-6-git-send-email-guwen@linux.alibaba.com>
 <19b288d3-5434-40b1-93fa-7db47e417f60@linux.ibm.com>
Content-Language: en-GB
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <19b288d3-5434-40b1-93fa-7db47e417f60@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QdHQOpTvMIUirNPy3s92hNEOCxb-026T
X-Proofpoint-GUID: mxongkUlANfKudnnathzR1OuIFEKB034
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01.12.23 17:30, Alexandra Winter wrote:
> 
> 
> On 30.11.23 12:28, Wen Gu wrote:
> [...]
>[...]
> 
>>   	if (nla_put_u8(skb, SMC_NLA_LGR_D_VLAN_ID, lgr->vlan_id))
>> @@ -876,7 +877,10 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
>>   		/* SMC-D specific settings */
> 
> 
> I guess I never really understood, why we define a single linkgroup for SMC-D.
> Probably because SMC-R linkgroups were implemented before SMC-D support was added.
As I'm aware, this is indeed the reason.

> To all: Do we want to keep that concept?
> 
Since SMC-D and SMC-R still share many common code, this concept should 
be kept, at least for now and now for this patch.

> 
>>   		smcd = ini->ism_dev[ini->ism_selected];
>>   		get_device(smcd->ops->get_dev(smcd));
>> -		lgr->peer_gid = ini->ism_peer_gid[ini->ism_selected];
>> +		lgr->peer_gid.gid =
>> +			ini->ism_peer_gid[ini->ism_selected].gid;
>> +		lgr->peer_gid.gid_ext =
>> +			ini->ism_peer_gid[ini->ism_selected].gid_ext;
>>   		lgr->smcd = ini->ism_dev[ini->ism_selected];
>>   		lgr_list = &ini->ism_dev[ini->ism_selected]->lgr_list;
>>   		lgr_lock = &lgr->smcd->lgr_lock;
>> @@ -1514,7 +1518,8 @@ void smc_lgr_terminate_sched(struct smc_link_group *lgr)
>>   }
>>   
>>   /* Called when peer lgr shutdown (regularly or abnormally) is received */
>> -void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
>> +void smc_smcd_terminate(struct smcd_dev *dev, struct smcd_gid *peer_gid,
>> +			unsigned short vlan)
>>   {
>>   	struct smc_link_group *lgr, *l;
>>   	LIST_HEAD(lgr_free_list);
>> @@ -1522,9 +1527,12 @@ void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
>>   	/* run common cleanup function and build free list */
>>   	spin_lock_bh(&dev->lgr_lock);
>>   	list_for_each_entry_safe(lgr, l, &dev->lgr_list, list) {
>> -		if ((!peer_gid || lgr->peer_gid == peer_gid) &&
>> +		if ((!peer_gid->gid ||
>> +		     (lgr->peer_gid.gid == peer_gid->gid &&
>> +		      !smc_ism_is_virtual(dev) ? 1 :
>> +		      lgr->peer_gid.gid_ext == peer_gid->gid_ext)) &&
>>   		    (vlan == VLAN_VID_MASK || lgr->vlan_id == vlan)) {
>> -			if (peer_gid) /* peer triggered termination */
>> +			if (peer_gid->gid) /* peer triggered termination */
>>   				lgr->peer_shutdown = 1;
>>   			list_move(&lgr->list, &lgr_free_list);
>>   			lgr->freeing = 1;
>> @@ -1859,10 +1867,12 @@ static bool smcr_lgr_match(struct smc_link_group *lgr, u8 smcr_version,
>>   	return false;
>>   }
>>   
>> -static bool smcd_lgr_match(struct smc_link_group *lgr,
>> -			   struct smcd_dev *smcismdev, u64 peer_gid)
>> +static bool smcd_lgr_match(struct smc_link_group *lgr, struct smcd_dev *smcismdev,
>> +			   struct smcd_gid *peer_gid)
>>   {
>> -	return lgr->peer_gid == peer_gid && lgr->smcd == smcismdev;
>> +	return lgr->peer_gid.gid == peer_gid->gid && lgr->smcd == smcismdev &&
>> +		smc_ism_is_virtual(smcismdev) ?
>> +		(lgr->peer_gid.gid_ext == peer_gid->gid_ext) : 1;
>>   }
>>   
>>   /* create a new SMC connection (and a new link group if necessary) */
>> @@ -1892,7 +1902,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
>>   		write_lock_bh(&lgr->conns_lock);
>>   		if ((ini->is_smcd ?
>>   		     smcd_lgr_match(lgr, ini->ism_dev[ini->ism_selected],
>> -				    ini->ism_peer_gid[ini->ism_selected]) :
>> +				    &ini->ism_peer_gid[ini->ism_selected]) :
>>   		     smcr_lgr_match(lgr, ini->smcr_version,
>>   				    ini->peer_systemid,
>>   				    ini->peer_gid, ini->peer_mac, role,
> [...]
>> diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
>> index a584613..c180c18 100644
>> --- a/net/smc/smc_diag.c
>> +++ b/net/smc/smc_diag.c
>> @@ -21,6 +21,7 @@
>>   
>>   #include "smc.h"
>>   #include "smc_core.h"
>> +#include "smc_ism.h"
>>   
>>   struct smc_diag_dump_ctx {
>>   	int pos[2];
>> @@ -168,12 +169,14 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
>>   		struct smc_connection *conn = &smc->conn;
>>   		struct smcd_diag_dmbinfo dinfo;
>>   		struct smcd_dev *smcd = conn->lgr->smcd;
>> +		struct smcd_gid smcd_gid;
>>   
>>   		memset(&dinfo, 0, sizeof(dinfo));
>>   
>>   		dinfo.linkid = *((u32 *)conn->lgr->id);
>> -		dinfo.peer_gid = conn->lgr->peer_gid;
>> -		dinfo.my_gid = smcd->ops->get_local_gid(smcd);
>> +		dinfo.peer_gid = conn->lgr->peer_gid.gid;
>> +		smcd->ops->get_local_gid(smcd, &smcd_gid);
>> +		dinfo.my_gid = smcd_gid.gid;
> 
> For virtual ism, you will only see the first half of the GID.
> Is that acceptable?
> 
>>   		dinfo.token = conn->rmb_desc->token;
>>   		dinfo.peer_token = conn->peer_token;
>>   
>> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
>> index fbee249..a33f861 100644
>> --- a/net/smc/smc_ism.c
>> +++ b/net/smc/smc_ism.c
> 
> Some of the content of this file is specific to s390 firmware ISMs and some is
> relevant to all future ism devices.
> IMO there is some more work to do to create a clean "smcd-protocol to scmd-device" interface.
> Maybe also some moving between this file and drivers/s390/net/ism_drv.c
> 
> Maybe this would be a good next patchset?
> 

I see the need, too. However, there are bunch of things to do in order 
to improve the SMC code. We need to get our priorities straight. What 
clear is that this is not in the scope of this patchset ;-)

> Whoever takes this work, remember:
> https://lore.kernel.org/netdev/1c6bdfbf-54c1-4251-916e-9a703a9f644c@infradead.org/T/
> We want to be able to combine SMC, ISM and future kernel modules in any combination.
> Gerd's patch above was meant to solve the current problem. For additional ism devices,
> we need some more improvements, I think.
> 
> 
Thank you, Alexandra, for the remember! That we should keep in mind!
> 
> 
> 
>> @@ -44,7 +44,8 @@ static void smcd_handle_irq(struct ism_dev *ism, unsigned int dmbno,
>>   #endif
>>   
>>   /* Test if an ISM communication is possible - same CPC */
>> -int smc_ism_cantalk(u64 peer_gid, unsigned short vlan_id, struct smcd_dev *smcd)
>> +int smc_ism_cantalk(struct smcd_gid *peer_gid, unsigned short vlan_id,
>> +		    struct smcd_dev *smcd)
>>   {
>>   	return smcd->ops->query_remote_gid(smcd, peer_gid, vlan_id ? 1 : 0,
>>   					   vlan_id);
>> @@ -208,7 +209,7 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
>>   	dmb.dmb_len = dmb_len;
>>   	dmb.sba_idx = dmb_desc->sba_idx;
>>   	dmb.vlan_id = lgr->vlan_id;
>> -	dmb.rgid = lgr->peer_gid;
>> +	dmb.rgid = lgr->peer_gid.gid;
>>   	rc = lgr->smcd->ops->register_dmb(lgr->smcd, &dmb, &smc_ism_client);
>>   	if (!rc) {
>>   		dmb_desc->sba_idx = dmb.sba_idx;
>> @@ -340,18 +341,20 @@ struct smc_ism_event_work {
>>   
>>   static void smcd_handle_sw_event(struct smc_ism_event_work *wrk)
>>   {
>> +	struct smcd_gid peer_gid = { .gid = wrk->event.tok,
>> +				     .gid_ext = 0 };
>>   	union smcd_sw_event_info ev_info;
>>   
>>   	ev_info.info = wrk->event.info;
>>   	switch (wrk->event.code) {
>>   	case ISM_EVENT_CODE_SHUTDOWN:	/* Peer shut down DMBs */
>> -		smc_smcd_terminate(wrk->smcd, wrk->event.tok, ev_info.vlan_id);
>> +		smc_smcd_terminate(wrk->smcd, &peer_gid, ev_info.vlan_id);
>>   		break;
>>   	case ISM_EVENT_CODE_TESTLINK:	/* Activity timer */
>>   		if (ev_info.code == ISM_EVENT_REQUEST) {
>>   			ev_info.code = ISM_EVENT_RESPONSE;
>>   			wrk->smcd->ops->signal_event(wrk->smcd,
>> -						     wrk->event.tok,
>> +						     &peer_gid,
>>   						     ISM_EVENT_REQUEST_IR,
>>   						     ISM_EVENT_CODE_TESTLINK,
>>   						     ev_info.info);
>> @@ -365,10 +368,12 @@ static void smc_ism_event_work(struct work_struct *work)
>>   {
>>   	struct smc_ism_event_work *wrk =
>>   		container_of(work, struct smc_ism_event_work, work);
>> +	struct smcd_gid smcd_gid = { .gid = wrk->event.tok,
>> +				     .gid_ext = 0 };
>>   
>>   	switch (wrk->event.type) {
>>   	case ISM_EVENT_GID:	/* GID event, token is peer GID */
>> -		smc_smcd_terminate(wrk->smcd, wrk->event.tok, VLAN_VID_MASK);
>> +		smc_smcd_terminate(wrk->smcd, &smcd_gid, VLAN_VID_MASK);
>>   		break;
>>   	case ISM_EVENT_DMB:
>>   		break;
>> @@ -525,7 +530,7 @@ int smc_ism_signal_shutdown(struct smc_link_group *lgr)
>>   	memcpy(ev_info.uid, lgr->id, SMC_LGR_ID_SIZE);
>>   	ev_info.vlan_id = lgr->vlan_id;
>>   	ev_info.code = ISM_EVENT_REQUEST;
>> -	rc = lgr->smcd->ops->signal_event(lgr->smcd, lgr->peer_gid,
>> +	rc = lgr->smcd->ops->signal_event(lgr->smcd, &lgr->peer_gid,
>>   					  ISM_EVENT_REQUEST_IR,
>>   					  ISM_EVENT_CODE_SHUTDOWN,
>>   					  ev_info.info);
> [...]
