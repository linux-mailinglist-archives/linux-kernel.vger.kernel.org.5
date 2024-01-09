Return-Path: <linux-kernel+bounces-20245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C454827C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B961F24271
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3332ECE;
	Tue,  9 Jan 2024 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lxPBleWt"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDCD818;
	Tue,  9 Jan 2024 01:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fdg0G57F1+ykGza7ifJKOOyydxCNE7UfLfZ7jz/fQrVYG42JPWoNt9FtUElkvKmcW/BynghtrGqzupQ+Mc0UQzA4K98bSKdFMUl/HuTtWtyAi+xIS2CHcYyZEyoaVcvOJQ0Th8+56Tc1q1TOFKEEyJf1jStdOR14TW+7WRAZMF5aXW6vzhvUfU2KCi50huevPeWG9wEGHxvzW6djW5ReEKxFpBc1XE+J62yNI+A7TA6ujqs6ToJGq6mtgkAcBM+EDQuFykDjy8L+OG1nnD2hq887eNW0XjDPiwhLqg9UbQTzzX7Mxqr7fJN8uUjuM1OM5EMuGmLELQqZojYURsYlBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Luo28bXdGOejmUUHP0FazaYgi4QZWskoT2lQVDcTETE=;
 b=HP40POcoY9c+NE1ck24mJsqAUcXlbbnEW+I74PyGWrMUVd/v2buJZBrVAm7xyf28XslWRzScnR2zUg7TiHqMC4oSc7XViPGB3+71qK2UlPr270HR/OR/qem/qMpNf3zk8itu1mdYsb9ti6MrgryxpO/3ca1+2QLXkTBnb08VxRJ/PCggfqguaslUfDyVEahk9TUdcDygeRvkXf5sGK2RdLtVlSKHoOy33UB3zgFt24Lq0fdQNk/om8/68zsGgrcFEh1wYnCNroCxuGP0wp04uedgKz5tOv47hrivALtG3KSNInW51/G9kS57LY3nOH73i5OsbmtyS0FbLgyCjW+Fww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Luo28bXdGOejmUUHP0FazaYgi4QZWskoT2lQVDcTETE=;
 b=lxPBleWtnUBBc40utBEj4VwNy0xbZ/uKJIwCs9KS3pXufMUxmrrc0qiGlpF+o5OQNwazHwYfxlItK+r5UkEeIWJGeXYd3mhdm8aZ4u4Y3i3rTmSTqsG0filqX3iLsyTAvuNPgywEOI5IBwPCh4uY5Z/UOqMb1uILVTeKM0AxrXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8543.eurprd04.prod.outlook.com (2603:10a6:102:216::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 01:06:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 01:06:20 +0000
Message-ID: <cb7e8dea-cab0-ca04-df52-3d588cf01371@oss.nxp.com>
Date: Tue, 9 Jan 2024 09:06:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 1/2] firmware: arm_scmi: clock: implement get
 permissions
From: Peng Fan <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com, cristian.marussi@arm.com, mturquette@baylibre.com,
 sboyd@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, ranjani.vaidyanathan@nxp.com,
 glen.wienecke@nxp.com, nitin.garg_3@nxp.com, chuck.cannon@nxp.com,
 Peng Fan <peng.fan@nxp.com>
References: <20231207093345.581048-1-peng.fan@oss.nxp.com>
In-Reply-To: <20231207093345.581048-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 3569083c-dacc-4f49-a5e3-08dc10af3094
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6x37wsV1aTFziDMZU/9GibeDvzJ9ig6jsFVcZq6jwtc/ffyah6sUjWrioVS4anrdJouVhnxlCL582e7Qs5VT3a+mgSWrzMNrgsIGrGAbkwMYqANXyDCPjkGq5g+uJ/0LBv6pJ2YxmJLMHVcNcrodaEvjgk0w5dz5x8Qq3JvfWM9RGkfwVNM4VFEWVEkCSKStTxn8TSjYz9R+QEUtLw47K3NeK5KYoa3m0AIQV+THsv/L9c89TMxgFfZnOy10hXbI5EYtF/JueMmD3J5tPjwPT10Q+mT5X9R8+LYwNzq9yfOzFLY0XezZdI4JVckTHXJQADAl3tvD8i87ZyrnZfZiBtadHl2LVUGTQSXPOMdlyc6GNdjE7qbM9TRFulPCjb0SdlNNAiuuB9X48g91IzvIOEm5Dnyc0kK96QM1Fzpy1dTzAMHC27gfd+XLs+48g1aD912wjaqzSYSP/p960IhCTVCMXlnvRGyN1Lu1jyNEbVPCKIGykW2q1Mzi8ZOgCho3WPzbAgiL8s0GUMgdgJ7Vh/LRUk6Fs39TkirTxFkRR1nCv7LR+SRmexNdv6CVPskw9BRLAXRHsWt5N0Q9Ugtk0OH5RPgcU7Pw4X/s1b6bHmQts5nNLPFxPuWGVvVya8pCRx/SRhqmpIUbqoeDOOQb2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31686004)(83380400001)(41300700001)(66946007)(31696002)(86362001)(38100700002)(26005)(2616005)(6506007)(53546011)(6512007)(966005)(6486002)(2906002)(66556008)(66476007)(316002)(6666004)(478600001)(44832011)(8936002)(4326008)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0FTTDZpZXRWZEJBOXNyQlgrZUU4N0Q1eUJHaVBMb2U2QzF4M1RCc3RvaHVV?=
 =?utf-8?B?Vktjc3dCamdSNGVMaHhzTnNySm4vSWE4RmJPQTh5Q0lQUkVORXhSc3dVejRk?=
 =?utf-8?B?SUpoOGYwWi84VUZjZ1V1bitJdkt6VURWM3BiNWhsTmM0QlA2a2MvZU5qeERu?=
 =?utf-8?B?cmpvU01hR05sT3YyVEdxUHFnQ0d4ZURJSXVzUDBLVGJpN0J4NzQ1UHkvRWJF?=
 =?utf-8?B?MmQycDNpMnhLSk5kWEljQzJ3WWNZdGNWZUdieFBUWElpVElKYlJadnVGT2FH?=
 =?utf-8?B?aVRUQlU0ak1UR1RnelpVVE9EM1hOaHUwNlgyNzdjbnR3QWVEZEVLUDJsMUdu?=
 =?utf-8?B?TXRDbW9sckttYXY0QzEvdkcxd2VVbytRb0Q5eVgwNUp3cm1BODFzbXdqTjNO?=
 =?utf-8?B?V2hUcEY2Tm00UmRHRkh3b0RTU1NhOTg2UlFRN2JlaUVGRERDTUJ1K0VoanBz?=
 =?utf-8?B?V0kvZERkSTBKV2s4aDlPdCtZSjBtQU0wbTNQcWRVM00zS3lhRFFTWDZtMGJP?=
 =?utf-8?B?Zy82TU1wbVd6WVJ3N2FuV0xuY2RSWWdHY2dNNnVVcFE2YmF1OFFabTBUaUhh?=
 =?utf-8?B?UFdJS2IxOUdLOEo0aW53NEhmbHNwS011Ry9HMUgvcFJ4Ykt0U3h0THJMNjF0?=
 =?utf-8?B?bnRhQ2NCUmE1dVl3SmtMZUx2K0hDbXZPdTlnY3d2ZXE3dkRnc25xVzQrd0pL?=
 =?utf-8?B?UjVlUU01TWI3eUZpNHlaaUsrSlFCMTE0OUlXeEgxSFVPbFdCdDZtSzJ6ZTEz?=
 =?utf-8?B?R0pDK3h1aHdJeWFvbTlpSU50TDBqZ1BXYlNoWTAxTTlmbjdGa1BKMllXaFh4?=
 =?utf-8?B?ZUgyTTRCNmNXK0FjMGtueFJ4RFNJODBRSk81KzhJYms0eEQxbmlscG1UdmZo?=
 =?utf-8?B?WmtrQVZKTzJWSDczTHQ2QXl4TjJsemRGOGV0UWlMYTFSeEgrTXlVQVk2ZEpv?=
 =?utf-8?B?REVYbTR2Q2U0a1JrK3FFaGgwQzVNZGpxLy9SNThGVVk1eC9idmRsa2ZGMXVU?=
 =?utf-8?B?bVFBaWM0a0Yrdjk3R1ZLNndmWUphVUFrOEo4N2FpNjV0Wlh5QlhGWXhFcmQz?=
 =?utf-8?B?VHUyeE5ZR3hvWG1lR21BdjZhT2hOQzJkQzBtRWpENzh2RFU2R3o2ajJtZWhp?=
 =?utf-8?B?VmJrRjZUenRHUjFuS2ltSi9Qa2d6b1NxdjVjY3NyeVRrVytYS2dkUHM4cy83?=
 =?utf-8?B?WnZWblNqaURQNFlRV2FVTE14aWxmaDRnY2MvK2ZrU3hTdmJST2pVM05QMzBj?=
 =?utf-8?B?azhIUE42dDMvOUIwQU1Wb0tQNEprRGM5OTJ4L0VpUXFqd1JUT1RmT3ZrbkRp?=
 =?utf-8?B?MlE1bTh1MThQb2ZzdGxQQkV0YU1TQ3gvVC81UzgvRjhSY0xBOFVkSzRGcnlO?=
 =?utf-8?B?MDROM2hKMFQvcndmaWFoYVVDdFlKTkpZL0pVNkJkV3BudUR0NlhIRFhQcVB2?=
 =?utf-8?B?UHppNk1zQnZGOU9Jd0Z3L2F2djJGNzQ5RDl3S296ZFpJMmgxclNueXBJNjRa?=
 =?utf-8?B?bXJScmFNTm1jZlVZTzNpNVlyZGpGUEcrZU5YajBmZnlUNW80b0VhR1kyUDZT?=
 =?utf-8?B?cXlxeTRLNnBXaDI1elhyWXdBeDErMlEzSVFWNCtlREZmQi9mcFVkRFI5dDRl?=
 =?utf-8?B?MjljUjVud1gxL0JkekxnNmNvOUgxZjI4dE8xU2ZtaWUyUkp3NGxtOUllYzFi?=
 =?utf-8?B?cXhKVGdHMGxTZmE1Q1FFUVhIK2dmREl2VWpFdlphVEZKY3NlNVBkRGRLc0pC?=
 =?utf-8?B?a1kvd2dWUzV5VHVPVFVtdGV6cnR1MTRvZkdLV0tocHhPZDhZd2N6Wkg5ZTdZ?=
 =?utf-8?B?T3lTeWEzV2c4SGk0dlRXWWM1TFZDU2FyNjB6R2U5NkpQaTBoa3VNYjRJbE1E?=
 =?utf-8?B?N0dyM0FDTjFVRkhZLzhVa0dvdFA5WFpRTW9nRWRNOGV4NHQ5bFdoVXJ5d3Za?=
 =?utf-8?B?NCtPakxhY0pTZDRjMDVTQ1lXQlNiMWhuTHdEMWhkYTRRZHFYdHFySWFnemxV?=
 =?utf-8?B?eUdnSU5oSmJheTF4YUd0L2RQWWNzSkV0V1hvTm5oM1Y1cVpGSllLSElPR1Br?=
 =?utf-8?B?U0l1UlI5akE1UkxlSWlkNWIwTUJkamVWMFBkdnJKRVZuWENlWklsKytkNHFx?=
 =?utf-8?Q?VqN+D+JIAoGGnZELdY9joNUTt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3569083c-dacc-4f49-a5e3-08dc10af3094
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 01:06:20.7862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkvgzynNUBObCB3sMAOcd7dKbyrpqITOUn7WPgQxE3cPrDw5YXd55i3IGbGebCnU6GYFD5zGfP/g71bNbATC6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8543

Hi Sudeep, Cristian,

Are you ok with this patchset? It's been pending for 1 month.

Thanks,
Peng.

On 12/7/2023 5:33 PM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> ARM SCMI Spec 3.2 introduces Clock Get Permission command. This patch
> is to add the support. Add three bool entries to scmi_clock_info to
> indicate the operation is forbidden or not. If the CLOCK_GET_PERMISSIONS
> command is not supported, the three bool variables will default
> set to false, otherwise they will be set according to the return result
> of CLOCK_GET_PERMISSIONS.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>   Take Cristian's suggestion, https://lore.kernel.org/all/ZWiqqfQ73tezFmSk@pluto/
> 
>   drivers/firmware/arm_scmi/clock.c | 53 +++++++++++++++++++++++++++++++
>   include/linux/scmi_protocol.h     |  4 +++
>   2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index 98511a3aa367..0e048530bea2 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -25,8 +25,13 @@ enum scmi_clock_protocol_cmd {
>   	CLOCK_POSSIBLE_PARENTS_GET = 0xC,
>   	CLOCK_PARENT_SET = 0xD,
>   	CLOCK_PARENT_GET = 0xE,
> +	CLOCK_GET_PERMISSIONS = 0xF,
>   };
>   
> +#define CLOCK_STATE_CONTROL_ALLOWED	BIT(31)
> +#define CLOCK_PARENT_CONTROL_ALLOWED	BIT(30)
> +#define CLOCK_RATE_CONTROL_ALLOWED	BIT(29)
> +
>   enum clk_state {
>   	CLK_STATE_DISABLE,
>   	CLK_STATE_ENABLE,
> @@ -46,6 +51,7 @@ struct scmi_msg_resp_clock_attributes {
>   #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
>   #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
>   #define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
> +#define SUPPORTS_GET_PERMISSIONS(x)		((x) & BIT(1))
>   	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
>   	__le32 clock_enable_latency;
>   };
> @@ -281,6 +287,35 @@ static int scmi_clock_possible_parents(const struct scmi_protocol_handle *ph, u3
>   	return ret;
>   }
>   
> +static int
> +scmi_clock_get_permissions(const struct scmi_protocol_handle *ph, u32 clk_id,
> +			   struct scmi_clock_info *clk)
> +{
> +	struct scmi_xfer *t;
> +	u32 perm;
> +	int ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, CLOCK_GET_PERMISSIONS,
> +				      sizeof(clk_id), sizeof(perm), &t);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_le32(clk_id, t->tx.buf);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		perm = get_unaligned_le32(t->rx.buf);
> +
> +		clk->state_ctrl_forbidden = !(perm & CLOCK_STATE_CONTROL_ALLOWED);
> +		clk->rate_ctrl_forbidden = !(perm & CLOCK_RATE_CONTROL_ALLOWED);
> +		clk->parent_ctrl_forbidden = !(perm & CLOCK_PARENT_CONTROL_ALLOWED);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
>   static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
>   				     u32 clk_id, struct scmi_clock_info *clk,
>   				     u32 version)
> @@ -307,6 +342,7 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
>   		if (PROTOCOL_REV_MAJOR(version) >= 0x2)
>   			latency = le32_to_cpu(attr->clock_enable_latency);
>   		clk->enable_latency = latency ? : U32_MAX;
> +		clk->attributes = attributes;
>   	}
>   
>   	ph->xops->xfer_put(ph, t);
> @@ -327,6 +363,8 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
>   			clk->rate_change_requested_notifications = true;
>   		if (SUPPORTS_PARENT_CLOCK(attributes))
>   			scmi_clock_possible_parents(ph, clk_id, clk);
> +		if (SUPPORTS_GET_PERMISSIONS(attributes))
> +			scmi_clock_get_permissions(ph, clk_id, clk);
>   	}
>   
>   	return ret;
> @@ -499,6 +537,10 @@ static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
>   	struct scmi_xfer *t;
>   	struct scmi_clock_set_rate *cfg;
>   	struct clock_info *ci = ph->get_priv(ph);
> +	struct scmi_clock_info *clk = ci->clk + clk_id;
> +
> +	if (clk->rate_ctrl_forbidden)
> +		return -EACCES;
>   
>   	ret = ph->xops->xfer_get_init(ph, CLOCK_RATE_SET, sizeof(*cfg), 0, &t);
>   	if (ret)
> @@ -585,6 +627,9 @@ scmi_clock_set_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
>   	if (parent_id >= clk->num_parents)
>   		return -EINVAL;
>   
> +	if (clk->parent_ctrl_forbidden)
> +		return -EACCES;
> +
>   	ret = ph->xops->xfer_get_init(ph, CLOCK_PARENT_SET,
>   				      sizeof(*cfg), 0, &t);
>   	if (ret)
> @@ -668,6 +713,10 @@ static int scmi_clock_enable(const struct scmi_protocol_handle *ph, u32 clk_id,
>   			     bool atomic)
>   {
>   	struct clock_info *ci = ph->get_priv(ph);
> +	struct scmi_clock_info *clk = ci->clk + clk_id;
> +
> +	if (clk->state_ctrl_forbidden)
> +		return -EACCES;
>   
>   	return ci->clock_config_set(ph, clk_id, CLK_STATE_ENABLE,
>   				    NULL_OEM_TYPE, 0, atomic);
> @@ -677,6 +726,10 @@ static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id,
>   			      bool atomic)
>   {
>   	struct clock_info *ci = ph->get_priv(ph);
> +	struct scmi_clock_info *clk = ci->clk + clk_id;
> +
> +	if (clk->state_ctrl_forbidden)
> +		return -EACCES;
>   
>   	return ci->clock_config_set(ph, clk_id, CLK_STATE_DISABLE,
>   				    NULL_OEM_TYPE, 0, atomic);
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index f2f05fb42d28..ad75784b567b 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -47,6 +47,9 @@ struct scmi_clock_info {
>   	bool rate_discrete;
>   	bool rate_changed_notifications;
>   	bool rate_change_requested_notifications;
> +	bool state_ctrl_forbidden;
> +	bool rate_ctrl_forbidden;
> +	bool parent_ctrl_forbidden;
>   	union {
>   		struct {
>   			int num_rates;
> @@ -60,6 +63,7 @@ struct scmi_clock_info {
>   	};
>   	int num_parents;
>   	u32 *parents;
> +	u32 attributes;
>   };
>   
>   enum scmi_power_scale {

