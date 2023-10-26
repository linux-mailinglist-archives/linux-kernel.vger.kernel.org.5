Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C5A7D8BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 00:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344896AbjJZWkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 18:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJZWkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 18:40:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C43CC;
        Thu, 26 Oct 2023 15:40:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVXhjvoWUFp5dR1hmjqTYWcEP/Sf/i94aoQ4+VugAkqWKpdSLSkQdZtjeV+cafmzoo3lW2WVXyl/oAEdLKclns33z6UIOyH/LtITqFS6RmjDDZAnD0ntUPvSEjttRYCz232uuJcPL5OJdznDw+cZkNeRXAueHkS1HG4VsIKd3hBOuiUrJs2PE5/fqdEs654RIWJ4R6SY+WxwbErnQAHSIvowdRcHCaaGE1my1iRSHMdlA4d6iMNw2+UWgtnEMv4le9VrPyW+n1gzLLefgzAuWqUdbfZ/cot2l4wzq4K3aLrycbnLc5YEwYKhqp1rerSTzpK/0Z3sgkCu2Y1tNmiVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3Tda/ZvMRc4T5IM9oz76YDeinAIKHlQ+eTTKBDrLD4=;
 b=l1u8XhSC1DJdEjoR19RqlTIzTxNwxs3R6ayAeXXom3lEs9rTabkdDXNun0kaqrusRxiexKpvt0X/ks+kiYCJJsN2OlpuCn+bsBWE4cposuJgLuxXb5PTCM7+RefS05MWKlFiXf2u70CyqLGaMqFA0JVjOLd/6an0I3VgrWJBnIdwfJgPJeDy878d0asNuIOFaR6MYP7j87shs76TZr8k/1fomKyd+UstRv7SoXzpe7YbpVAaR6woiHcli6Xh3RoXlvDmCDV3TuwhMCIk53ZohS/v7RyQinH7TjSvZ2AtUG//qwRFT4XvWh0FNbUBBPJNCfaOSjQAMFR+Y0Vvb5qGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3Tda/ZvMRc4T5IM9oz76YDeinAIKHlQ+eTTKBDrLD4=;
 b=5Vqvqt4+s1QWBKGPRK3H6de3v0jH1gpql2GCCqqZV7d+6F5/W21Dwi6/sBMkzRd04G05u+UFtKT6N8Ke72Qo0aFXVrQihsM6AIAweH1vfl+ttOLExm1O27+0FeoSOCNNYplWvdlMGmtyPjvvcUdWYoaBehDD7QxqnFX+t14IcIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW3PR12MB4524.namprd12.prod.outlook.com (2603:10b6:303:2d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 22:40:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1e4c:5da0:33ed:ff3a]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1e4c:5da0:33ed:ff3a%7]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 22:40:28 +0000
Message-ID: <a03e5f5e-ac9c-f8b1-0260-d58ede569d67@amd.com>
Date:   Thu, 26 Oct 2023 17:40:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
References: <20231025235046.12940-1-tony.luck@intel.com>
 <20231026200214.16017-1-tony.luck@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <20231026200214.16017-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW3PR12MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: 757abfe3-0d73-4ae2-8895-08dbd6748d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kF3CpZxC3CUvLtYOJhoxs2EQypF+YohB6Iu5V6pAYnxm9fTtDpfl5RCZDhLxWSUv4/GrpYgYKolLtmnD3hXDPfz/G69BHvDZ4cxaPlZzovQ+nLPHBfVNpWM7rd86tPnT3q9o4z5Ys/u/jbKrjik769DFLniVxyGdQIi0+I43xAD337Lkcb9CSO8nPX2dSwlCoZn/Ohha9QUJchcnGc/4vdqz9SRUhdFxyFXI2ApAdrE+9HREhk8VuuXEz65ubPVUvGzxI+cfvfd6NCa0jDmF+bu8tSFtYs/uxl7rotEPL22U3Gq/aEJzHPUzsj2TpT5e0aWDZnPY1ZlbpFNuRPvstf5LJLD9Y9Guc5ZW16FRDFhgo5NgZ+oPYQPnMHH34xOANWi0WruXY2vCe7YmC6cAOp1x22/1Ma6xSZEirOWbkAJ3CzTumWCbxwOU/hCdci3i7dmi805/BoR3OzTrP19G//r2U1cUyVJ2vB1V0kgSVwABRt6F8ta5RJH3lPrAIuKkthdk7lhjouEjmBeI/6McEJn6Lpnp0MbkXNRBb8AV2XR7UaQNjlfCcwGB8yIKTOrCRZSh6Z+jRzhWQfyxoIbEWXRoYQxTs4V5LppRDBvLgtAJSfcL3ougPt1Lk4r6TzMx7Y6oWlwG5ok7z/CZriZRqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(26005)(110136005)(478600001)(6512007)(316002)(6506007)(54906003)(66946007)(66476007)(66556008)(36756003)(6666004)(2616005)(6486002)(7416002)(83380400001)(38100700002)(8676002)(8936002)(4326008)(2906002)(31686004)(5660300002)(41300700001)(53546011)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEtobDI0VGorOEhnVFVnK0dhaGtEUDYwYnVzODVRUnVEOGxiZzRCK1ZXQjEx?=
 =?utf-8?B?dDhNdEhJMW5iSDlZbTNBSDFXTGJFQUFIclhGa3RoRTZodUVNNnYvZ2dyK1dG?=
 =?utf-8?B?MmkwZWlRVDV0ekFHWWNmaGFjYi9SeWFkeHcyc2JtblRIZlhIU3ZDTjMrdzJY?=
 =?utf-8?B?dTRvQlFydjh3MDcvdE42eEZwS1VJam92OER0emNkOE1IdER2Q3J6dEdNcVNY?=
 =?utf-8?B?eVlqOUg1K003R3RNRjJGbU16czNMQlFFRjB0ZHVhVERLWld6M3oza0FNOERE?=
 =?utf-8?B?MEd1K25KWk94TnVmbVJRc3NKZUdiNkNYb3YxbUQxWmFMR0ljall2T3Y3bmRB?=
 =?utf-8?B?eFVnVGc1VWJKckZyMzJ4KzE2cExzTFRMRE1IWFNZN3VoWXlRRms3WUtZRDhl?=
 =?utf-8?B?UklGbFFZYjJ1K1VaLzVyTldPaGZ3UFh2OWs5SGRYaDBEMDZuQkFha201a2Jv?=
 =?utf-8?B?STEyV0hMUzZtZmliaW80RGpJMzhTdlNCQ2V0OGMwY3VnV0t0Rmt5NXdGdmo2?=
 =?utf-8?B?bEV2TEZsQWRPeFRvTlFSTXFlTmNKTlVON2plcFhrenlMRjFwdTYyVTZaMjRu?=
 =?utf-8?B?bjlvaUpGRmFvN2ZWZVNuUHV5RDlqVnFzQVNYMHptL2JqSlplQkdnS29Rcmt6?=
 =?utf-8?B?V3BKR2E0Vi9oTi80dXJqN0gxUFUxWkJKbWt0eE16MTVjU0NkOVlVUTJuOG1l?=
 =?utf-8?B?d3puU25pNWVoSFhjZzQ5TkpFc1RQTWVVek5xNkNac1JaMFhuK01vZEw3Znl0?=
 =?utf-8?B?UDRwYVExOHQrcTdMWUd4eUpYczNUSk5vTER4MVpwWHpKOEJnb1V6VzZ0eFVW?=
 =?utf-8?B?UHYreGZNejNvcHRORXZ4QjZLWFBnOXcxTEF6U2x4cm1qdEZxbzBSclJ6YTdn?=
 =?utf-8?B?ZlRXd0dLVFZnSEVFamNDbG1xNzZueDIrQjNNa1JQS2RndkpwOGVtbWJsbHJr?=
 =?utf-8?B?TzkvemdSd3dpUk1CakJ0elB5QWhWQUhWb2F4cGNIV2RRaVpab1RnZTBBS0JY?=
 =?utf-8?B?c0V4K29ZVnp3Nk1UdEhIR01ITXJXMi9QQUYxSXN0N1VXK1piaGFCU3FJdlBK?=
 =?utf-8?B?Q3djbnpXU3pEUFV5VExNRXlqYms5ZUdwbmJselB2NUNnZVF6T3ZQOVRUNXJD?=
 =?utf-8?B?aW5oalhaSk9SODd5VERDTjhyS3VPTDg5d1YyN3JnbHdJNURhazVid2g2ejFj?=
 =?utf-8?B?ZkZyY0lGYUlYTHB5K3lwQThxWDdxVzc4U1E2S1VBUUNSNyswQjVGd3hMUWNY?=
 =?utf-8?B?MlZDVG5QbzlHem9vSTFKaUE0aDRRSktKai9QS2ZvelFUWFQ5aGNjaE4rb21T?=
 =?utf-8?B?bkN4Slp2ODlXZFJuR01zNTdnZDE1a1ZneTVRSHB3ZUNPbFNBNFpIYVU3SHkr?=
 =?utf-8?B?cE9NU1BSWFNweEhlR2VPRmQ2Qmg4UHJOT2lOMG84TU9RZWdzK2JNdFB1SmJW?=
 =?utf-8?B?Rm5yem5GeG5BcGNtWFhOM3FBUVM4eDdvaTlKVVpRdDlIc09SNXJUOC9mdW9E?=
 =?utf-8?B?bDRTT3h2MWRLWWl2elVYUlgzbmNiS2ZmRS9FYkFoSE53MXcxcU0wdlpnMGN1?=
 =?utf-8?B?Z25URWVIMGtoZmNBZGtSdWgrL05OZjhKSGNsL1AyNGpJT1hCbWpidTJUVmJM?=
 =?utf-8?B?dk5peEFxTktjeEtYY2lCdnNxZDczZVVMV250VDg3c2s3VFlJZnZtamxxTlhY?=
 =?utf-8?B?dGhpV05aYUVkdEZQbjRIak41M0Z3eW9xQVlDTC9EckgzcGpiR0Jzb2g4ODFS?=
 =?utf-8?B?dWtoUFNvclZ2VmdJSmE3ZTJWODJqaU8xOXhKWkVFeS9EU3JlK0Y5R0ZrM2RR?=
 =?utf-8?B?WVF1VHdHYlRaaUtuMW5QUjVXSmlmMHU3M0lubVdwRVJhTWNkbHQyb25wL0Yr?=
 =?utf-8?B?d1UzekloSmNMb0V4MzJUeDJGaUFMK01zQ3dHeWpzVjl6czdDYkl6N3VESmNq?=
 =?utf-8?B?dnlrTWt4T3dRWjdNSlUzeUh0OXJEVHd3WHZaR0x6d3M1djl3dWRWb3kyZWtp?=
 =?utf-8?B?ZitTS1RPNFNpMG5JL2lBWGtUUlBnNE9vRkJoV3g1MmlBb1U5ZTlPZXU4VGxi?=
 =?utf-8?B?K0hjWkR2WnVPZ2N4VzF3WTZkbjFoL1MySFVnbE1wd3lmek5YWmV2MXllYlQz?=
 =?utf-8?Q?UKeg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757abfe3-0d73-4ae2-8895-08dbd6748d5f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 22:40:28.0713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13bQGhv9OCKaQMuIlLK28wV+l5eIOHhu/ziLsKS/hJDXhYS7cuuMpMnP6NOetBQW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4524
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 10/26/2023 3:02 PM, Tony Luck wrote:
> On Intel the various resource director technology (RDT) features are all
> orthogonal and independently enumerated. Thus it is possible to have
> a system that  provides "total" memory bandwidth measurements without
> providing "local" bandwidth measurements.
>
> If local bandwidth measurement is not available, do not give up on
> providing the "mba_MBps" feedback option completely, make the code fall
> back to using total bandwidth.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> Change since v2:
>
> Babu doesn't like the global variable. So here's a version without it.
>
> Note that my preference is still the v2 version. But as I tell newbies
> to Linux "Your job isn't to get YOUR patch upstream. You job is to get
> the problem fixed.".  So taking my own advice I don't really mind
> whether v2 or v3 is applied.
Hmm. I like v3 better. Few minor comments below.
>
>   arch/x86/kernel/cpu/resctrl/monitor.c  | 43 ++++++++++++++++++--------
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
>   2 files changed, 31 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index f136ac046851..29e86310677d 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -418,6 +418,20 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>   	return 0;
>   }
>   
> +/*
> + * For legacy compatibility use the local memory bandwidth to drive
> + * the mba_MBps feedback control loop. But on platforms that do not
> + * provide the local event fall back to use the total bandwidth event
> + * instead.
> + */
> +static enum resctrl_event_id pick_mba_mbps_event(void)
> +{
> +	if (is_mbm_local_enabled())
> +		return QOS_L3_MBM_LOCAL_EVENT_ID;
> +
> +	return QOS_L3_MBM_TOTAL_EVENT_ID;
> +}
> +
>   /*
>    * mbm_bw_count() - Update bw count from values previously read by
>    *		    __mon_event_count().
> @@ -431,9 +445,11 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>    */
>   static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
>   {
> -	struct mbm_state *m = &rr->d->mbm_local[rmid];
> +	enum resctrl_event_id mba_mbps_evt_id = pick_mba_mbps_event();

How about evt_id instead of mba_mbps_evt_id? It seems pretty mouthful 
for temp variable.

>   	u64 cur_bw, bytes, cur_bytes;
> +	struct mbm_state *m;
>   
> +	m = get_mbm_state(rr->d, rmid, mba_mbps_evt_id);
>   	cur_bytes = rr->val;
>   	bytes = cur_bytes - m->prev_bw_bytes;
>   	m->prev_bw_bytes = cur_bytes;
> @@ -518,6 +534,7 @@ void mon_event_count(void *info)
>    */
>   static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>   {
> +	enum resctrl_event_id mba_mbps_evt_id = pick_mba_mbps_event();
same comment as above.
>   	u32 closid, rmid, cur_msr_val, new_msr_val;
>   	struct mbm_state *pmbm_data, *cmbm_data;
>   	u32 cur_bw, delta_bw, user_bw;
> @@ -526,14 +543,14 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>   	struct list_head *head;
>   	struct rdtgroup *entry;
>   
> -	if (!is_mbm_local_enabled())
> +	if (!is_mbm_enabled())
>   		return;
>   
>   	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
>   
>   	closid = rgrp->closid;
>   	rmid = rgrp->mon.rmid;
> -	pmbm_data = &dom_mbm->mbm_local[rmid];
> +	pmbm_data = get_mbm_state(dom_mbm, rmid, mba_mbps_evt_id);
>   
>   	dom_mba = get_domain_from_cpu(smp_processor_id(), r_mba);
>   	if (!dom_mba) {
> @@ -553,7 +570,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>   	 */
>   	head = &rgrp->mon.crdtgrp_list;
>   	list_for_each_entry(entry, head, mon.crdtgrp_list) {
> -		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
> +		cmbm_data = get_mbm_state(dom_mbm, entry->mon.rmid, mba_mbps_evt_id);
>   		cur_bw += cmbm_data->prev_bw;
>   		delta_bw += cmbm_data->delta_bw;
>   	}
> @@ -595,7 +612,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>   	 */
>   	pmbm_data->delta_comp = true;
>   	list_for_each_entry(entry, head, mon.crdtgrp_list) {
> -		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
> +		cmbm_data = get_mbm_state(dom_mbm, entry->mon.rmid, mba_mbps_evt_id);
>   		cmbm_data->delta_comp = true;
>   	}
>   }
> @@ -621,15 +638,15 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
>   		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
>   		rr.val = 0;
>   		__mon_event_count(rmid, &rr);
> -
> -		/*
> -		 * Call the MBA software controller only for the
> -		 * control groups and when user has enabled
> -		 * the software controller explicitly.
> -		 */
> -		if (is_mba_sc(NULL))
> -			mbm_bw_count(rmid, &rr);
>   	}
> +
> +	/*
> +	 * Call the MBA software controller only for the
> +	 * control groups and when user has enabled
> +	 * the software controller explicitly.
> +	 */
> +	if (is_mba_sc(NULL))
> +		mbm_bw_count(rmid, &rr);
>   }
>   
>   /*
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 69a1de92384a..0c4f8a1b8df0 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2294,7 +2294,7 @@ static bool supports_mba_mbps(void)
>   {
>   	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
>   
> -	return (is_mbm_local_enabled() &&
> +	return (is_mbm_enabled() &&
>   		r->alloc_capable && is_mba_linear());
>   }
>   

Otherwise looks good to me.

Thanks

Babu

