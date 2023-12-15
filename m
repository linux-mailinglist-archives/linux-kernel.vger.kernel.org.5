Return-Path: <linux-kernel+bounces-1431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1088A814EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0A02876E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF35282EF1;
	Fri, 15 Dec 2023 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JQldu+Ni"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D530106;
	Fri, 15 Dec 2023 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTVcTzFLsRGOBPYC4spB16bLGTlJo9KdxAZxc/MPr/FIA5eQqkIBZHHhBdTHidH3TfmfIBoYHTTui0e9BBav8q50b4O1VbED93Z4HNk7iujbuV4+Q9ksPC14wNVmfAxDCrOibC/TL+H9hcijWD2mK4eIvQGemK7VcBs9t3+fXiEq4Xm/eFIIJWCOOdwAPIAj8sVWc/ZzWbl5AAYjWoNc8/yXem/nDxeyVmeAtLqLMM8WbKjjrSZbYV+nE0+8XfWcYWEH8lR/IeWB2ydEuVPh+XrX2CSg50ZuoAlSBCIMC45uZysDLpvvDwszGeEuIABej5E8Z/cdRVpXBgGwU8LIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0TwU+XDWTKGeeIZesvCdZrMJhYwlygHQtiRJBGFldo=;
 b=HmYj46NjC5OabD/HXiEy9eOA2gjJ1n7Mlv3fKUS0lyXXjLUx9gdBYo1mfGRqmjYGVst+OfV1N5Jurp4VuVoBwSC3f+tSeswpDEnPQ6xvNfb3AeJHVlB/SyhKu8qRiJarzLTBIE9Hw3cqVAD4mQYeWnAzbNf27SdXTYxstNUsk6QV3gzMShoKy225Gd32ktHv3O7BJG37L379WdLYoynnkmXKvZc/A/qAFLXs8pVXW9GmUuTYdjMqMXMxmx+A/Fq5ADvmv8mSouCgPuhESn6ok1qDoW/hM/2kUJ++aZVmGmQ10GoVfK+ndOwoACGzkAzL+8bt16d+bWZvt45+daMp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0TwU+XDWTKGeeIZesvCdZrMJhYwlygHQtiRJBGFldo=;
 b=JQldu+NiYPkHnCruckfCddmr3zSBeCmE/sYP44ly7/h7Vy7+f1NZOtC2p120vk732KOt7ET8xPV63+UIb5B6CjYKIL5PihfIYdfEWH+yNK3cfNKInUj/zv5nFNBTxLYeNd3ul+pwQ8+I5w+pFIblVIYwuDTxJpO41TE0Ts8in8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Fri, 15 Dec
 2023 17:37:34 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bec4:77b3:e1d1:5615]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bec4:77b3:e1d1:5615%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 17:37:34 +0000
Message-ID: <58fd07c6-ce04-f802-08d2-1a65245aca00@amd.com>
Date: Fri, 15 Dec 2023 09:37:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH iwl-next v6] ice: Add support for packet mirroring using
 hardware in switchdev mode
Content-Language: en-US
To: Andrii Staikov <andrii.staikov@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marcin Szycik <marcin.szycik@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>
References: <20231212125126.3297556-1-andrii.staikov@intel.com>
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20231212125126.3297556-1-andrii.staikov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::14) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be5a4bb-e5cd-4e2b-320d-08dbfd948581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QuJdTzjXYqnpnvfCXPlKWmuM4WWO4KJkfpb1jxRzzET+pq6OWTmEncBsQH8XV5YI58hF5ku/IUlxUDB1uQWY8NsUx2BHX1yCNiYJmXZTgyXoeC14XYH4xMP6qJgTWckIVeeWUuM32tjQ153emLNxwfUibSulgd003l5fSfvep900wY8S1+V8iGFwJ/hpK8DA/EMZlnpxhWAbU0Mh+GRgM2gwKZjTRkUXZxwdcrCHN27dW8/qWUZENMbGKFOuszvPd3z8dGd1pOandhLV4f0eIvLvhA4NZKZmOBGe6UmftLy/SWk11gOAjrdrvpt4NqbPoMt+bBTdsApEweNuFheRLsxq1zrscn6vsksRLMuUelbByITjgZM7bplZD7Rd9ROJQHW2YI8i+yE2NtARn3u9FogA9yF5YaZvPdChK4hD4rtC6dc19lROGT3n0JdPm4WNfEKqlVkHrUOOLUQMSAAXCqQhWO01Tu7sqP7H34jWkGhCyWgk7DA68Lz+pWaIe0rC3LUajRegDbkQdbPqcRgG5ZxPbOnfAsxFuyrItXkunqMno61PG2o5U4VwxeTLx9Im6i6+uIH6L5YUc6TJK69kFE9nNZc/Ftf8QB6qkc1f03b3M4Hv9NNDMomFspRXDqDeNHsI416y/mnkp6kt0Ik7Q0XlDx+x+wmQc+kB1cON10WZGj9ZJdPoPSM9EhbmrE9P
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(66476007)(66556008)(54906003)(31686004)(41300700001)(8676002)(6666004)(83380400001)(2906002)(8936002)(4326008)(38100700002)(5660300002)(66946007)(316002)(31696002)(6486002)(478600001)(53546011)(2616005)(36756003)(6506007)(6512007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0FVRU5wMG5NaitHN01kNk1UbVNqK2FiUE1YK3k0bEFqNUc3b1VpVitwd2NP?=
 =?utf-8?B?S3F4TVNNcnB3OVZsdWlLcHFxc1k5bVhtYnNYZ2tSbThYbFoyckdIcVU1TGU1?=
 =?utf-8?B?dDJxUEp2L0h3cUZjZ3FYdEhHSzZiSUFzR2dzSkpvN0NQSnAvWE5SZHkzWUxP?=
 =?utf-8?B?TXlUYmU0U3RUL0RMd25ZSWZCYlN1SENVekZXODlWL0V6WElKN1BSa3ViUHRT?=
 =?utf-8?B?eGNIZStENU84WXI2b3ZVU1FYTkEyQ3RMZTdueVlWQ1ZyMVJRL1FkRGIzZDVT?=
 =?utf-8?B?eWdZa3pXU1E2ZFBNL1BpOXo3dWVUWTYrdlJZQWlYVHgyWFRveW42NC9YM3FS?=
 =?utf-8?B?Tk5URk1ETVJEV09zc2hCM0hhcXRLMkZuNitubmJkdGZKUXRWMlNwS2ROV2Nh?=
 =?utf-8?B?WXFQaVdOYUxaYllZbk1tUWw0TFJpcXVOdlBjN2N2YlE3cEVmYW1ydTVIM0tP?=
 =?utf-8?B?d25wSXdRaEZjUkQ0S29abmxjaTRTa05ieUJwaDB4T0d0Vjg2VTUwTnB0Vkdl?=
 =?utf-8?B?eGZnREhtSE55UE5selZaQjRIWjZ4cStxeUkvcmo4OVpyNjNNSXR4Vy85WTVZ?=
 =?utf-8?B?N0Z1emppcnBPK1ltTDFESGREK09lYzdIQ2VVZzdTRGNTQUovajBBdlZSRnUy?=
 =?utf-8?B?UWpXTkxDL0NFZDBPc3dLTGp2QzZzaWRNanZSWlR6akRZcm91MDhKTlUxVkdI?=
 =?utf-8?B?NkxIT2M2b2hrWndhZmJlZ3d3SW5uL3BQVlpCOGpJbjNpcVVtYjZ3TCt6dkh4?=
 =?utf-8?B?Unp4ZDVQR2FhTFJhM1JRQ3BCZ2Fxdno5WjBGQktPbGNHRVdZTHFHbStqcCtI?=
 =?utf-8?B?MzYwVFgzb1RyZkVzbURIK2dyY3ZkRDRzbHZ4a2JBSVQzL1Jodnp6aEd1ZFJG?=
 =?utf-8?B?eG5KOE1xdnJWNjMyWDEwSnNrSlFPTGc4R0pHYnNOcXBZbTdLQzh1eVAvcnlo?=
 =?utf-8?B?VFVra1BGMG1kNFdJZS9TbEhIQXh3QUhoaWhjdGdyQUZ4NlVaTnRjemV3WkpL?=
 =?utf-8?B?NlFiRVJvck1DVkpZQ1hBb1AyUHp3RFhHVnpERWxOSjdRVlpVdCtUUXNDbWwz?=
 =?utf-8?B?WHk3by92SXNXQThBTnNvMWJiNWhJbW0vUTE4V0ZHbDlqT25DSEhwY0ZmN21M?=
 =?utf-8?B?UzJPRlhLckhmdlo5NCswMldNSm9uZFNnUHlVbWFYT0NmdFBLTmJLbzNMUGpR?=
 =?utf-8?B?SVpEV25qVEZ1MVVSZTBmdy9seTF5czNoS0JCR3UxOU44K2dmVXBNS091MzFK?=
 =?utf-8?B?NlJCc2FkaklIUndldUZvS1FtMHAvNUFZK1JmTm1hREZyVng4NGJxSW9nQk83?=
 =?utf-8?B?ZHM5bkRaVUxhWjF0ZlFUYmw1WG1HK1N4WUN3ZGdrKzRCamh4d2JZWUprWkN2?=
 =?utf-8?B?clFveEk4bDJuakhsMGJtd0R6OHVBRzZGZUlrODFiMEh4ZEZONGczS2VIK1lY?=
 =?utf-8?B?dmFrSk9LaVVOcmZESnRvT1c4dUZxUldVam0ydS9UNXk3djNNZFJRSmhTeFdi?=
 =?utf-8?B?dVhNL1o0eTBvdlJqTlhURU9HMG1BQ1BaWXRUQWMxZ2V4M0ZuWjMzTmZTT1hu?=
 =?utf-8?B?WXZGbEMwMzkyRlZycnFSc2xxRG9tS1VEU2JkNUNFb3czQ1dmd2xQZGJUMTZD?=
 =?utf-8?B?a1pGNDVYTDQ1cXlrQklRV29ST2dIWCs5K3FBUWlWc0lhMWNBZmhoUDZiRE9l?=
 =?utf-8?B?Q1RBcHhlRW00RzY1am55aFR6Wi8rNjAyYXRrS0FLQS9kblU5aTFrQXBSZnBl?=
 =?utf-8?B?N0JWTnRtSXVjWStOdThSUzVSSGFNTDcrTkxOYWlzeldnTmJLTGNiUnNiRjhh?=
 =?utf-8?B?dWpOeDUrWjBiVVNuWC9kaG9iUGtjd2tsU0Uxd1lDWVU1Z1J2NjdaQnpEV0Vq?=
 =?utf-8?B?QkFsOTlLWEQ0ejFUYWVoVGQxakJCK3lKc1J6RFIvK0lNc2dXQlIxWWkraU9D?=
 =?utf-8?B?R0tndE5GVFhZOUZPQm1QcXZBMXlWWW5ZNENpVzBzTGxncW1zYmd3SzVjRFQ5?=
 =?utf-8?B?eXo1VzFFbVJEQ1U5ck1SNWRRMFNPRnJkcWg4RWpEOEZWVzhzSnNNL1RCTFhW?=
 =?utf-8?B?ZFRzQlVyNzFRZ3Q4Qk11djZCTi9KeU1YUU9YaHl2STZJcCs2VTN3aW83ajJt?=
 =?utf-8?Q?LoYNAaYQlfDTwejs/p2+Nuceb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be5a4bb-e5cd-4e2b-320d-08dbfd948581
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 17:37:34.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Isog1/HkUVloUdbUvLGuPcTiCNx6/DxxVmhJpVa06BxwmjvpqJXfb9jvhfqew3w3ydSo826WhBIzh9px51FWug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728



On 12/12/2023 4:51 AM, Andrii Staikov wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Switchdev mode allows to add mirroring rules to mirror incoming and
> outgoing packets to the interface's port representor. Previously, this was
> available only using software functionality. Add possibility to offload
> this functionality to the NIC hardware.
> 
> Introduce ICE_MIRROR_PACKET filter action to the ice_sw_fwd_act_type enum
> to identify the desired action and pass it to the hardware as well as the
> VSI to mirror.
> 
> Example of tc mirror command using hardware:
>    tc filter add dev ens1f0np0 ingress protocol ip prio 1 flower src_mac
>    b4:96:91:a5:c7:a7 skip_sw action mirred egress mirror dev eth1
> 
> ens1f0np0 - PF
> b4:96:91:a5:c7:a7 - source MAC address
> eth1 - PR of a VF to mirror to
> 
> Co-developed-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
> ---
> v1 -> v2: no need for changes in ice_add_tc_flower_adv_fltr()
> v2 -> v3: add another if branch for netif_is_ice(act->dev) ||
> ice_is_tunnel_supported(act->dev) for FLOW_ACTION_MIRRED action and
> add direction rules for filters
> v3 -> v4: move setting mirroring into dedicated function
> ice_tc_setup_mirror_action()
> v4 -> v5: Fix packets not mirroring from VF to VF by changing
> ICE_ESWITCH_FLTR_INGRESS to ICE_ESWITCH_FLTR_EGRESS where needed
> v5 -> v6: Additionally fix some tags
> ---
>   drivers/net/ethernet/intel/ice/ice_switch.c | 25 +++++++++----
>   drivers/net/ethernet/intel/ice/ice_tc_lib.c | 41 +++++++++++++++++++++
>   drivers/net/ethernet/intel/ice/ice_type.h   |  1 +
>   3 files changed, 60 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
> index ee19f3aa3d19..4af1ce2657ad 100644
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> @@ -6065,6 +6065,7 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
>                rinfo->sw_act.fltr_act == ICE_FWD_TO_Q ||
>                rinfo->sw_act.fltr_act == ICE_FWD_TO_QGRP ||
>                rinfo->sw_act.fltr_act == ICE_DROP_PACKET ||
> +             rinfo->sw_act.fltr_act == ICE_MIRROR_PACKET ||
>                rinfo->sw_act.fltr_act == ICE_NOP)) {
>                  status = -EIO;
>                  goto free_pkt_profile;
> @@ -6077,9 +6078,11 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
>          }
> 
>          if (rinfo->sw_act.fltr_act == ICE_FWD_TO_VSI ||
> -           rinfo->sw_act.fltr_act == ICE_NOP)
> +           rinfo->sw_act.fltr_act == ICE_MIRROR_PACKET ||
> +           rinfo->sw_act.fltr_act == ICE_NOP) {
>                  rinfo->sw_act.fwd_id.hw_vsi_id =
>                          ice_get_hw_vsi_num(hw, vsi_handle);
> +       }
> 
>          if (rinfo->src_vsi)
>                  rinfo->sw_act.src = ice_get_hw_vsi_num(hw, rinfo->src_vsi);
> @@ -6115,12 +6118,15 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
>                  status = -ENOMEM;
>                  goto free_pkt_profile;
>          }
> -       if (!rinfo->flags_info.act_valid) {
> -               act |= ICE_SINGLE_ACT_LAN_ENABLE;
> -               act |= ICE_SINGLE_ACT_LB_ENABLE;
> -       } else {
> -               act |= rinfo->flags_info.act & (ICE_SINGLE_ACT_LAN_ENABLE |
> -                                               ICE_SINGLE_ACT_LB_ENABLE);
> +
> +       if (rinfo->sw_act.fltr_act != ICE_MIRROR_PACKET) {
> +               if (!rinfo->flags_info.act_valid) {
> +                       act |= ICE_SINGLE_ACT_LAN_ENABLE;
> +                       act |= ICE_SINGLE_ACT_LB_ENABLE;
> +               } else {
> +                       act |= rinfo->flags_info.act & (ICE_SINGLE_ACT_LAN_ENABLE |
> +                                                       ICE_SINGLE_ACT_LB_ENABLE);
> +               }
>          }
> 
>          switch (rinfo->sw_act.fltr_act) {
> @@ -6147,6 +6153,11 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
>                  act |= ICE_SINGLE_ACT_VSI_FORWARDING | ICE_SINGLE_ACT_DROP |
>                         ICE_SINGLE_ACT_VALID_BIT;
>                  break;
> +       case ICE_MIRROR_PACKET:
> +               act |= ICE_SINGLE_ACT_OTHER_ACTS;
> +               act |= FIELD_PREP(ICE_SINGLE_ACT_VSI_ID_M,
> +                                 rinfo->sw_act.fwd_id.hw_vsi_id);
> +               break;
>          case ICE_NOP:
>                  act |= FIELD_PREP(ICE_SINGLE_ACT_VSI_ID_M,
>                                    rinfo->sw_act.fwd_id.hw_vsi_id);
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> index 08d3bbf4b44c..b890410a2bc0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> @@ -689,6 +689,41 @@ ice_tc_setup_drop_action(struct net_device *filter_dev,
>          return 0;
>   }
> 
> +static int ice_tc_setup_mirror_action(struct net_device *filter_dev,
> +                                     struct ice_tc_flower_fltr *fltr,
> +                                     struct net_device *target_dev)
> +{
> +       struct ice_repr *repr;
> +
> +       fltr->action.fltr_act = ICE_MIRROR_PACKET;
> +
> +       if (ice_is_port_repr_netdev(filter_dev) &&
> +           ice_is_port_repr_netdev(target_dev)) {
> +               repr = ice_netdev_to_repr(target_dev);
> +
> +               fltr->dest_vsi = repr->src_vsi;
> +               fltr->direction = ICE_ESWITCH_FLTR_EGRESS;
> +       } else if (ice_is_port_repr_netdev(filter_dev) &&
> +                  ice_tc_is_dev_uplink(target_dev)) {
> +               repr = ice_netdev_to_repr(filter_dev);
> +
> +               fltr->dest_vsi = repr->src_vsi->back->eswitch.uplink_vsi;

It seems like multiple places use this and pf->eswitch.uplink_vsi. Would 
it be worth adding a helper function for this, i.e.:

ice_get_eswitch_uplink_vsi(pf)

> +               fltr->direction = ICE_ESWITCH_FLTR_EGRESS;
> +       } else if (ice_tc_is_dev_uplink(filter_dev) &&
> +                  ice_is_port_repr_netdev(target_dev)) {
> +               repr = ice_netdev_to_repr(target_dev);
> +
> +               fltr->dest_vsi = repr->src_vsi;
> +               fltr->direction = ICE_ESWITCH_FLTR_INGRESS;
> +       } else {
> +               NL_SET_ERR_MSG_MOD(fltr->extack,
> +                                  "Unsupported netdevice in switchdev mode");
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>   static int ice_eswitch_tc_parse_action(struct net_device *filter_dev,
>                                         struct ice_tc_flower_fltr *fltr,
>                                         struct flow_action_entry *act)
> @@ -710,6 +745,12 @@ static int ice_eswitch_tc_parse_action(struct net_device *filter_dev,
> 
>                  break;
> 
> +       case FLOW_ACTION_MIRRED:
> +               err = ice_tc_setup_mirror_action(filter_dev, fltr, act->dev);
> +               if (err)
> +                       return err;
> +               break;
> +
>          default:
>                  NL_SET_ERR_MSG_MOD(fltr->extack, "Unsupported action in switchdev mode");
>                  return -EINVAL;
> diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
> index 5a80158e49ed..20c014e9b6c0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_type.h
> +++ b/drivers/net/ethernet/intel/ice/ice_type.h
> @@ -1055,6 +1055,7 @@ enum ice_sw_fwd_act_type {
>          ICE_FWD_TO_Q,
>          ICE_FWD_TO_QGRP,
>          ICE_DROP_PACKET,
> +       ICE_MIRROR_PACKET,
>          ICE_NOP,
>          ICE_INVAL_ACT
>   };
> --
> 2.25.1
> 
> 

