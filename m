Return-Path: <linux-kernel+bounces-1046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 380B08149BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABE8FB221F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24872EAE6;
	Fri, 15 Dec 2023 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l+vVsi/H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5352DB8F;
	Fri, 15 Dec 2023 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAfbtxpXAqxALG0JXvOA2MKFl6jIfGizO++7C2yoR1x+IS0jvwITi7XBX6sMD+hDqq1VdYQdWJ/l+kXEWsRHn50DD5ovBRoGQg6O5IQANGUHcXNoCCP8zO8h+q8JJYY86uX+1pIpP79TKrClj2JJFXaBYSHVuW19lqcaZbhclFSBO9m5o6RuVbQlbwC2RC7sfGtAHl1ZGdGgvfys1nhUk0byvkArpq/4oWQ9AE55eHkjjEtUeDgq/lYIRMqsWNw2RG++TslHcqpuiZ8y/JBnfc5vGtaARio6ld0CT4Z+qmu9r310Ft9RAESWEYe9IZ3MpFmSJqoQHT1LJ9tSan7OQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/xCRfaPh51Oj0btLGj8Q/q97bSo4/Tj61GBLILPYR0=;
 b=cwNcmGJB1gVkGlKcQEhau5rOC1pvBowLtl1+rQX0AD0BXsvtZUwSfBLKLWIvRjUABP5sD6DjRPu4cHoOWNXoZHzSBfqP3WkaXfUxqgw/R8o5pRv7MQ1h7eo0uJRrMuI2PR6HAb11BHArJoW9ZGRptgPtWHrqk3xbtFuVmyKSuXZ1sq2iMjNr1JWip354UBNy5MbGg32WzL12L/usNnA5eTwqjLebDgGI7l1QChDb3LfAlQskkPuFu623snk9cMBFknCmj0nf7DANmUKPxVYfF8IAjsL/qFN4Oq9qXjviX3d+D8HeQ/ReD+lpHlHfZUMpBHXLJwFYmmlFZm6TaoQSvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/xCRfaPh51Oj0btLGj8Q/q97bSo4/Tj61GBLILPYR0=;
 b=l+vVsi/HQnGvnhZ+XqFohSljOxIBnWsTfOf+NU8LxH7NNLw1476L+J28zBz+70YLgZJfDoL7xZNRrz36BikO1V9l/4G2Zs+RKGIDWH282hMcV/43ATE7XR5IGPMyzHF/+RxqqGPoL7o5bjeV1LPQB61XsqmBqxe5J6MZDWwRH8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.31; Fri, 15 Dec 2023 13:54:17 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c%6]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 13:54:17 +0000
Message-ID: <c7d174d3-028f-9ce4-7ef5-3e033c195159@amd.com>
Date: Fri, 15 Dec 2023 19:24:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset downstream
 ports created by boot firmware
Content-Language: en-US
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
 andreas.noever@gmail.com, michael.jamet@intel.com, YehezkelShB@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213054914.GI1074920@black.fi.intel.com>
 <20231213061805.GK1074920@black.fi.intel.com>
 <20231213062306.GL1074920@black.fi.intel.com>
 <adcc6446-8c30-a258-e19b-76fca2c50d21@amd.com>
 <20231213115256.GM1074920@black.fi.intel.com>
 <f673ffc8-f6f8-4898-d809-effb2c24e53e@amd.com>
 <20231214070746.GS1074920@black.fi.intel.com>
 <32163f49-8387-0754-534f-1764e731f26d@amd.com>
 <20231214073242.GT1074920@black.fi.intel.com>
 <ff143967-63ff-c4fb-9c88-8537a663c45b@amd.com>
 <20231215115521.GW1074920@black.fi.intel.com>
From: Sanath S <sanaths2@amd.com>
In-Reply-To: <20231215115521.GW1074920@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::9) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|DM4PR12MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0a8da3-d96f-4ea5-6b1c-08dbfd7553ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nmutC/s+8o8lotlR3wO3q1sWgp7yQH8/Cea461NvxziB3pjerpGlla7Tqgm/bNpIbcso2r3/Exyv0/Nn7EfKZPg92XLswGf4WquQS+8/Vrc7viVyDd9Gk83cAvpUHMou4isPOrqK1vMr9bjHINe3wZryRTTB32l+CYgRt3ZvzgQFDlTawk/YCM9z9h/eGHxvOPC6lI50GQGLkgs67CUQ2Y4NF2alYNNxebmxB6ED10PJxGjtmvSmFWflyzZ6tAiWEP1TtgbYSxLxM532+7Nrkq3odU9fMzqXOZ4Jw+576bapS72y3p/coyVJxO1BlUuBKlXYC0+FbG6tf5mtiw7rDfqga34JuWYQ4ZslqDB+W0fo2aBEJjtL4V/VktztdT4yd53xMlWr1FTGp3/9CzDFcB5thnEwJWdIL2lWfT1+wEf7zeGdZ0t7NTKBCq1b+B9QCPhlE826GDLxsxenZ8BHSVBTIAi4pn7+z9rWtCvdYHmMQ/57G4Vvs40okFMxrcwkvOxHIBY04Ary4ooTYOj9BVpycDp4ey/SqY9A9q4v9CeG8LV7d20QW/APqTO7YGrHLsjbmk70LiM3GUayES1DzhXsAlN5APGeYcS4N16YOQTFN8CzxzWLzyqze1oRAGxiqXe+xfaa8AOcwHUri8/LAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(26005)(66574015)(6506007)(2616005)(31696002)(36756003)(38100700002)(83380400001)(5660300002)(4326008)(6512007)(53546011)(6666004)(6916009)(316002)(66946007)(8676002)(6486002)(8936002)(66556008)(66476007)(2906002)(30864003)(41300700001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTlIRVNmZy9tczNmU3dEc2c2ZE1hWThxWnIvaDVlY1Y4aDdJTmd0cEtzNnVj?=
 =?utf-8?B?UUUyeTZ6QUNLUVlUVTFzcENkdmdWNUozRDBlTTN6cndjMkN3aU1UZVVVcXY5?=
 =?utf-8?B?YzdvVUVBdE16enVHdjhXc2xyTU5mWGIxMFp5S1lwNGpaOWJGVmxhUkJsWXla?=
 =?utf-8?B?ZFV4YWlqN3BzZys0VlhDRUdHRUI5Si9yWHVxZCswQUNDN1Bva2t3cUVGVHJT?=
 =?utf-8?B?bEpFYlFINXNhdzh5Y3NNVzIrcDNrZkdjR2xwMXk4eURGdFZWWlFKUjFpLzlK?=
 =?utf-8?B?Y2FBUkVQbU44Uml0RHVOb2o2eUt0bmZaZk52bXY3UDRrcHBrTFFKaVZrYkNJ?=
 =?utf-8?B?TDQ4WnNYWm94WXh0N0phNVpTbGwwcE5JbUFCR2wvMjM1SEVaL0dZWFNTRmtZ?=
 =?utf-8?B?Z0JOV1VhTFhadDBKZWpFakJjdWYzaERDNTFkYm9ObU9lM0tPdWIzQVNhUE92?=
 =?utf-8?B?UENWbEx6ajhIbDdyTW4rZHB4a1pjMllKdHcvQ0dRckR1VUZhY0U5RGR2aVh0?=
 =?utf-8?B?clpsT1lVcHBUUDAzUVlnQ0tCaFV2bzFYNmtmY1RmZlFRam5hRUQ1SWxMMC9E?=
 =?utf-8?B?dElSY0xhQzRsdHlxd1I2U0FzWVlrYlcyZXAzQWpJV0w0WHlkekN3emVvVHgx?=
 =?utf-8?B?SW11Q20wajA4RHFxNU5iV3poL3p4TFlhNzFCcGx0elJjWXFka2l0RDZWS0JT?=
 =?utf-8?B?UVlRS0hyZ2drQkpKeWxDeTRPU05PVVRCbVdwSkZ2K0hLOHRHVEViM0FtOGZo?=
 =?utf-8?B?RHJZV2lxMFBSYmE0ODB6dnNvOStxZ1pvcDc2ZkZRaEpUKy8zdC96ZmZKK0hh?=
 =?utf-8?B?MUUwVTVjWnJWQmcvWWkxMTJnd21USmhMNktqcUpzSDBROW4vTFBGdG02NFlV?=
 =?utf-8?B?VVdnR3Z5c1VoL1RRd25zK1ZCQjhVYVdOOENoN2IwSlpndjNnSXAxSjJ4TFR1?=
 =?utf-8?B?T3U5UzNOeHg2RUtFVWNPcmFXOHRVNXpYeSs3VTB2eEZGbHMxOUVvQXpKaE5q?=
 =?utf-8?B?eWd3cFNSM3czd0h6Y3paaS80NGpWWHRrdkdmTlRYb3J1aTV6M2NNdFhOR2xP?=
 =?utf-8?B?Q3ZYUDl2akJVQWsvRGZQVU1lQmpJYkE3VWF5S2NpR0lhcERWMkdhVU9waG9M?=
 =?utf-8?B?KzNzNWt0UWNWQUpiTm1PeU9jeG9BUW9EL2ZrN25GS2NBUGpmY3RWZnh5eGdu?=
 =?utf-8?B?QXF2VDV3NUdtUEJub0tZa3JFeFh3T1NQZ0J4WEhvcXlDbGF2Ykw1WkY2OTlP?=
 =?utf-8?B?TXloNTdCd3Zxb29vVmJzeE8yWWI1RWJic01RM3NhMW1RK3V6RHp2MlpNOHhm?=
 =?utf-8?B?dnEvWitQSDdwNmVBUFpna1VMSVJwVVc2cDJ6eHh0bDhNU2hnSlc5NjhNVFl4?=
 =?utf-8?B?eC9zcDZpN1piRkptSlRjbXhzQXpUL0J1U3NLQ041bGxsR3VxL3FwVE1MS0E5?=
 =?utf-8?B?KzJhZUtwWWlIemNkSXBZWDFZSnpZdzNNZVFJMW5qSmQ2VDM5M3V5ZFUxOTda?=
 =?utf-8?B?T0t1aXNMRUU1dG44YkdwSXVKR2VSTng5djYwNVBkNURrTFg2WGFJWGYzcVBt?=
 =?utf-8?B?eFJYTkQ3NDdwaG4ybzNqcy9laEdNQ3ZKK0NoUmp2RWRUdUN4MVFvQnpQT0Jl?=
 =?utf-8?B?Ujk4UFEyLzhnS1VzaVdKVzZmU2dLTHZFd3lnK3E2NkVucHc1RkFMUTZsRVZ4?=
 =?utf-8?B?T0w4QlB6YUhpMXNvQkNUVkpoeiszNE1Bdk8ySEVsMWJuZisyWFJPbUZYcHg0?=
 =?utf-8?B?QkJNYmJ3aHVrZzFRWHZrN29IWU1zY3VNbDBoWjA1QkpOOWxQcmNFUjBnazJU?=
 =?utf-8?B?cDVJcU0yaGpCaEtHckhMdncremlNVkp6cHFLSEdBZVg0WTRhOXFKN01qbnZv?=
 =?utf-8?B?UkZzSW1OR0o1TGdmVm9FK0FNY21SZi9YV1pqcjNUMWFaSHpWOU8rN3pOenJP?=
 =?utf-8?B?dUdNREx4WkVBdlNaMU51UEtPYkF2ZzNkSXR3WlI1TUNZVVBFRlhHSVBUVFNo?=
 =?utf-8?B?S0ZQU2pnbXZIN2p2WHpqWEhRRll5ZW5sdGs3V2Iyb3IyRXdZako5bzBLYlhM?=
 =?utf-8?B?aUN0Qy9ZcHhYY1dHYUVPcS81VmRLSElDTEJPRHRCazJMVEhMQjljZ3hRTE1K?=
 =?utf-8?Q?mihOFebTCpzS1fEMIF82u3o5F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0a8da3-d96f-4ea5-6b1c-08dbfd7553ad
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 13:54:16.5562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElO0SyM/2PnLIjndxHgdIKdaw9nc/QvaSROahOeScZPD97MtBvPZrY3wA224A/AEpAtN/D6sj0KXqvI8+PxF0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5962


On 12/15/2023 5:25 PM, Mika Westerberg wrote:
> On Thu, Dec 14, 2023 at 09:00:29PM +0530, Sanath S wrote:
>>> Unfortunately that's not possible because tb_switch_reset() lives in
>>> switch.s (and should live there) and tb_deactivate_and_free_tunnel() is
>>> part of tb.c (as should be). This is actually why I would like to try
>>> the "reset" protocol adapters + their path config spaces in
>>> tb_switch_reset() as then that would work with any router and does not
>>> need to have any knowledge about tunnels or tb.c internals.
>> Ok.
>> To perform a protocol adapter reset we would require upstream and downstream
>> adapter ports. So that we can use tb_port_write() set the ADP_PCIE_CS_0.Path
>> Enable bits.
>> Challenge here is to get the upstream port without discovering. I'll think
>> more on this line
>> if its possible to reset the protocol adapters and its path.
>>
>> If you have any reference here or any idea already in mind, let me know, I
>> can give it a try :)
> Here is something I had in mind. Only build tested now, and not split
> into proper patches. This would make it possible to reset any router if
> we ever need that (not sure if we want to add the TBT2/3 bits now). Let
> me know if you see problems with this.
>
> Feel free to use this code as you like (or ignore completely).
Thanks Mika for your suggestion.
It looks good to me and I'll be checking this on Monday.

I have one doubt on protocol adapter reset part which I have mentioned 
below.
> diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
> index ec7b5f65804e..31f3da4e6a08 100644
> --- a/drivers/thunderbolt/domain.c
> +++ b/drivers/thunderbolt/domain.c
> @@ -423,6 +423,7 @@ struct tb *tb_domain_alloc(struct tb_nhi *nhi, int timeout_msec, size_t privsize
>   /**
>    * tb_domain_add() - Add domain to the system
>    * @tb: Domain to add
> + * @reset: Issue reset to the host router
>    *
>    * Starts the domain and adds it to the system. Hotplugging devices will
>    * work after this has been returned successfully. In order to remove
> @@ -431,7 +432,7 @@ struct tb *tb_domain_alloc(struct tb_nhi *nhi, int timeout_msec, size_t privsize
>    *
>    * Return: %0 in case of success and negative errno in case of error
>    */
> -int tb_domain_add(struct tb *tb)
> +int tb_domain_add(struct tb *tb, bool reset)
>   {
>   	int ret;
>   
> @@ -460,7 +461,7 @@ int tb_domain_add(struct tb *tb)
>   
>   	/* Start the domain */
>   	if (tb->cm_ops->start) {
> -		ret = tb->cm_ops->start(tb);
> +		ret = tb->cm_ops->start(tb, reset);
>   		if (ret)
>   			goto err_domain_del;
>   	}
> diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> index d8b9c734abd3..623aa81a8833 100644
> --- a/drivers/thunderbolt/icm.c
> +++ b/drivers/thunderbolt/icm.c
> @@ -2144,7 +2144,7 @@ static int icm_runtime_resume(struct tb *tb)
>   	return 0;
>   }
>   
> -static int icm_start(struct tb *tb)
> +static int icm_start(struct tb *tb, bool not_used)
>   {
>   	struct icm *icm = tb_priv(tb);
>   	int ret;
> diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
> index 633970fbe9b0..63cb4b6afb71 100644
> --- a/drivers/thunderbolt/lc.c
> +++ b/drivers/thunderbolt/lc.c
> @@ -6,6 +6,8 @@
>    * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
>    */
>   
> +#include <linux/delay.h>
> +
>   #include "tb.h"
>   
>   /**
> @@ -45,6 +47,49 @@ static int find_port_lc_cap(struct tb_port *port)
>   	return sw->cap_lc + start + phys * size;
>   }
>   
> +/**
> + * tb_lc_reset_port() - Trigger downstream port reset through LC
> + * @port: Port that is reset
> + *
> + * Triggers downstream port reset through link controller registers.
> + * Returns %0 in case of success negative errno otherwise. Only supports
> + * non-USB4 routers with link controller (that's Thunderbolt 2 and
> + * Thunderbolt 3).
> + */
> +int tb_lc_reset_port(struct tb_port *port)
> +{
> +	struct tb_switch *sw = port->sw;
> +	int cap, ret;
> +	u32 mode;
> +
> +	if (sw->generation < 2)
> +		return -EINVAL;
> +
> +	cap = find_port_lc_cap(port);
> +	if (cap < 0)
> +		return cap;
> +
> +	ret = tb_sw_read(sw, &mode, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
> +	if (ret)
> +		return ret;
> +
> +	mode |= TB_LC_PORT_MODE_DPR;
> +
> +	ret = tb_sw_write(sw, &mode, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(10000);
> +
> +	ret = tb_sw_read(sw, &mode, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
> +	if (ret)
> +		return ret;
> +
> +	mode &= ~TB_LC_PORT_MODE_DPR;
> +
> +	return tb_sw_write(sw, &mode, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
> +}
> +
>   static int tb_lc_set_port_configured(struct tb_port *port, bool configured)
>   {
>   	bool upstream = tb_is_upstream_port(port);
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index fb4f46e51753..b22023fae60d 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -1221,7 +1221,7 @@ static void nhi_check_iommu(struct tb_nhi *nhi)
>   		str_enabled_disabled(port_ok));
>   }
>   
> -static void nhi_reset(struct tb_nhi *nhi)
> +static bool nhi_reset(struct tb_nhi *nhi)
>   {
>   	ktime_t timeout;
>   	u32 val;
> @@ -1229,11 +1229,11 @@ static void nhi_reset(struct tb_nhi *nhi)
>   	val = ioread32(nhi->iobase + REG_CAPS);
>   	/* Reset only v2 and later routers */
>   	if (FIELD_GET(REG_CAPS_VERSION_MASK, val) < REG_CAPS_VERSION_2)
> -		return;
> +		return false;
>   
>   	if (!host_reset) {
>   		dev_dbg(&nhi->pdev->dev, "skipping host router reset\n");
> -		return;
> +		return false;
>   	}
>   
>   	iowrite32(REG_RESET_HRR, nhi->iobase + REG_RESET);
> @@ -1244,12 +1244,14 @@ static void nhi_reset(struct tb_nhi *nhi)
>   		val = ioread32(nhi->iobase + REG_RESET);
>   		if (!(val & REG_RESET_HRR)) {
>   			dev_warn(&nhi->pdev->dev, "host router reset successful\n");
> -			return;
> +			return true;
>   		}
>   		usleep_range(10, 20);
>   	} while (ktime_before(ktime_get(), timeout));
>   
>   	dev_warn(&nhi->pdev->dev, "timeout resetting host router\n");
> +
> +	return false;
>   }
>   
>   static int nhi_init_msi(struct tb_nhi *nhi)
> @@ -1331,6 +1333,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	struct device *dev = &pdev->dev;
>   	struct tb_nhi *nhi;
>   	struct tb *tb;
> +	bool reset;
>   	int res;
>   
>   	if (!nhi_imr_valid(pdev))
> @@ -1365,7 +1368,11 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	nhi_check_quirks(nhi);
>   	nhi_check_iommu(nhi);
>   
> -	nhi_reset(nhi);
> +	/*
> +	 * Only USB4 v2 hosts support host reset so if we already did
> +	 * that then don't do it again when the domain is initialized.
> +	 */
> +	reset = nhi_reset(nhi) ? false : host_reset;
>   
>   	res = nhi_init_msi(nhi);
>   	if (res)
> @@ -1392,7 +1399,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   
>   	dev_dbg(dev, "NHI initialized, starting thunderbolt\n");
>   
> -	res = tb_domain_add(tb);
> +	res = tb_domain_add(tb, reset);
>   	if (res) {
>   		/*
>   		 * At this point the RX/TX rings might already have been
> diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
> index 091a81bbdbdc..f760e54cd9bd 100644
> --- a/drivers/thunderbolt/path.c
> +++ b/drivers/thunderbolt/path.c
> @@ -446,6 +446,19 @@ static int __tb_path_deactivate_hop(struct tb_port *port, int hop_index,
>   	return -ETIMEDOUT;
>   }
>   
> +/**
> + * tb_path_deactivate_hop() - Deactivate one path in path config space
> + * @port: Lane or protocol adapter
> + * @hop_index: HopID of the path to be cleared
> + *
> + * This deactivates or clears a single path config space entry at
> + * @hop_index. Returns %0 in success and negative errno otherwise.
> + */
> +int tb_path_deactivate_hop(struct tb_port *port, int hop_index)
> +{
> +	return __tb_path_deactivate_hop(port, hop_index, true);
> +}
> +
>   static void __tb_path_deactivate_hops(struct tb_path *path, int first_hop)
>   {
>   	int i, res;
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 900114ba4371..c4f486629a2b 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -676,6 +676,13 @@ int tb_port_disable(struct tb_port *port)
>   	return __tb_port_enable(port, false);
>   }
>   
> +static int tb_port_reset(struct tb_port *port)
> +{
> +	if (tb_switch_is_usb4(port->sw))
> +		return usb4_port_reset(port);
> +	return tb_lc_reset_port(port);
> +}
> +
>   /*
>    * tb_init_port() - initialize a port
>    *
> @@ -1532,20 +1539,64 @@ static void tb_dump_switch(const struct tb *tb, const struct tb_switch *sw)
>   }
>   
>   /**
> - * tb_switch_reset() - reconfigure route, enable and send TB_CFG_PKG_RESET
> - * @sw: Switch to reset
> + * tb_switch_reset() - Perform reset to the router
> + * @sw: Router to reset
>    *
> - * Return: Returns 0 on success or an error code on failure.
> + * Issues reset to the router. Can be used for any router. Returns %0
> + * on success or an error code on failure.
>    */
>   int tb_switch_reset(struct tb_switch *sw)
>   {
>   	struct tb_cfg_result res;
>   
> -	if (sw->generation > 1)
> -		return 0;
> +	tb_sw_dbg(sw, "resetting router\n");
> +
> +	if (sw->generation > 1) {
> +		struct tb_port *port;
> +
> +		tb_switch_for_each_port(sw, port) {
> +			int i, ret;
> +
> +			/*
> +			 * For lane adapters we issue downstream port
> +			 * reset. That clears up also the path config
> +			 * spaces.
> +			 *
> +			 * For protocol adapters we disable the path and
> +			 * clear path config space one by one (from 8 to
> +			 * Max Input HopID of the adapter).
> +			 */
> +			if (tb_port_is_null(port) && !tb_is_upstream_port(port)) {
> +				ret = tb_port_reset(port);
> +				if (ret)
> +					return ret;
> +				continue;

I had thought in similar lines when you told about reset protocol adapters.

But, here we are traversing through all the ports, what if we get to 
perform the DPR first ?
and then the PCIe, USB and DP reset. This may cause unplug event before 
we  tear down
protocol adapters and its path configuration. (I may be wrong)

I'll check the behavior on Monday and update.

Assuming this works, I can incorporate the suggestion and send out v3 with
appropriate tags ? It can be split into 3 patches.
> +			} else if (tb_port_is_usb3_down(port) ||
> +				   tb_port_is_usb3_up(port)) {
> +				tb_usb3_port_enable(port, false);
> +			} else if (tb_port_is_dpin(port) ||
> +				   tb_port_is_dpout(port)) {
> +				tb_dp_port_enable(port, false);
> +			} else if (tb_port_is_pcie_down(port) ||
> +				   tb_port_is_pcie_up(port)) {
> +				tb_pci_port_enable(port, false);
> +			} else {
> +				continue;
> +			}
>   
> -	tb_sw_dbg(sw, "resetting switch\n");
> +			/* Cleanup path config space of protocol adapter */
> +			for (i = TB_PATH_MIN_HOPID;
> +			     i <= port->config.max_in_hop_id; i++) {
> +				ret = tb_path_deactivate_hop(port, i);
> +				if (ret)
> +					return ret;
> +			}
> +		}
> +
> +		return 0;
> +	}
>   
> +	/* Thunderbolt 1 uses the "reset" config space packet */
>   	res.err = tb_sw_write(sw, ((u32 *) &sw->config) + 2,
>   			      TB_CFG_SWITCH, 2, 2);
>   	if (res.err)
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index 8bc3985df749..5e5e3aebe018 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -2590,7 +2590,7 @@ static int tb_scan_finalize_switch(struct device *dev, void *data)
>   	return 0;
>   }
>   
> -static int tb_start(struct tb *tb)
> +static int tb_start(struct tb *tb, bool reset)
>   {
>   	struct tb_cm *tcm = tb_priv(tb);
>   	int ret;
> @@ -2631,12 +2631,22 @@ static int tb_start(struct tb *tb)
>   	tb_switch_tmu_configure(tb->root_switch, TB_SWITCH_TMU_MODE_LOWRES);
>   	/* Enable TMU if it is off */
>   	tb_switch_tmu_enable(tb->root_switch);
> -	/* Full scan to discover devices added before the driver was loaded. */
> -	tb_scan_switch(tb->root_switch);
> -	/* Find out tunnels created by the boot firmware */
> -	tb_discover_tunnels(tb);
> -	/* Add DP resources from the DP tunnels created by the boot firmware */
> -	tb_discover_dp_resources(tb);
> +
> +	if (reset && usb4_switch_version(tb->root_switch) == 1) {
> +		ret = tb_switch_reset(tb->root_switch);
> +		if (ret) {
> +			tb_sw_warn(tb->root_switch, "failed to reset\n");
> +			return ret;
> +		}
> +	
Ok. So idea is to drop reset for <= TBT3 currently.
> } else {
> +		/* Full scan to discover devices added before the driver was loaded. */
> +		tb_scan_switch(tb->root_switch);
> +		/* Find out tunnels created by the boot firmware */
> +		tb_discover_tunnels(tb);
> +		/* Add DP resources from the DP tunnels created by the boot firmware */
> +		tb_discover_dp_resources(tb);
> +	}
> +
>   	/*
>   	 * If the boot firmware did not create USB 3.x tunnels create them
>   	 * now for the whole topology.
> @@ -2702,7 +2712,7 @@ static int tb_resume_noirq(struct tb *tb)
>   {
>   	struct tb_cm *tcm = tb_priv(tb);
>   	struct tb_tunnel *tunnel, *n;
> -	unsigned int usb3_delay = 0;
> +	unsigned int usb3_delay;
>   	LIST_HEAD(tunnels);
>   
>   	tb_dbg(tb, "resuming...\n");
> @@ -2715,19 +2725,7 @@ static int tb_resume_noirq(struct tb *tb)
>   	tb_free_unplugged_children(tb->root_switch);
>   	tb_restore_children(tb->root_switch);
>   
> -	/*
> -	 * If we get here from suspend to disk the boot firmware or the
> -	 * restore kernel might have created tunnels of its own. Since
> -	 * we cannot be sure they are usable for us we find and tear
> -	 * them down.
> -	 */
> -	tb_switch_discover_tunnels(tb->root_switch, &tunnels, false);
> -	list_for_each_entry_safe_reverse(tunnel, n, &tunnels, list) {
> -		if (tb_tunnel_is_usb3(tunnel))
> -			usb3_delay = 500;
> -		tb_tunnel_deactivate(tunnel);
> -		tb_tunnel_free(tunnel);
> -	}
> +	usb3_delay = tb_switch_is_usb4(tb->root_switch) ? 500 : 0;
>   
>   	/* Re-create our tunnels now */
>   	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list) {
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index 7ad55f5966f3..2bc8eca965ed 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -489,7 +489,7 @@ struct tb_path {
>    */
>   struct tb_cm_ops {
>   	int (*driver_ready)(struct tb *tb);
> -	int (*start)(struct tb *tb);
> +	int (*start)(struct tb *tb, bool reset);
>   	void (*stop)(struct tb *tb);
>   	int (*suspend_noirq)(struct tb *tb);
>   	int (*resume_noirq)(struct tb *tb);
> @@ -752,7 +752,7 @@ int tb_xdomain_init(void);
>   void tb_xdomain_exit(void);
>   
>   struct tb *tb_domain_alloc(struct tb_nhi *nhi, int timeout_msec, size_t privsize);
> -int tb_domain_add(struct tb *tb);
> +int tb_domain_add(struct tb *tb, bool reset);
>   void tb_domain_remove(struct tb *tb);
>   int tb_domain_suspend_noirq(struct tb *tb);
>   int tb_domain_resume_noirq(struct tb *tb);
> @@ -1156,6 +1156,7 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
>   void tb_path_free(struct tb_path *path);
>   int tb_path_activate(struct tb_path *path);
>   void tb_path_deactivate(struct tb_path *path);
> +int tb_path_deactivate_hop(struct tb_port *port, int hop_index);
>   bool tb_path_is_invalid(struct tb_path *path);
>   bool tb_path_port_on_path(const struct tb_path *path,
>   			  const struct tb_port *port);
> @@ -1175,6 +1176,7 @@ int tb_drom_read(struct tb_switch *sw);
>   int tb_drom_read_uid_only(struct tb_switch *sw, u64 *uid);
>   
>   int tb_lc_read_uuid(struct tb_switch *sw, u32 *uuid);
> +int tb_lc_reset_port(struct tb_port *port);
>   int tb_lc_configure_port(struct tb_port *port);
>   void tb_lc_unconfigure_port(struct tb_port *port);
>   int tb_lc_configure_xdomain(struct tb_port *port);
> @@ -1307,6 +1309,7 @@ void usb4_switch_remove_ports(struct tb_switch *sw);
>   
>   int usb4_port_unlock(struct tb_port *port);
>   int usb4_port_hotplug_enable(struct tb_port *port);
> +int usb4_port_reset(struct tb_port *port);
>   int usb4_port_configure(struct tb_port *port);
>   void usb4_port_unconfigure(struct tb_port *port);
>   int usb4_port_configure_xdomain(struct tb_port *port, struct tb_xdomain *xd);
> diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
> index 87e4795275fe..efcae298b370 100644
> --- a/drivers/thunderbolt/tb_regs.h
> +++ b/drivers/thunderbolt/tb_regs.h
> @@ -389,6 +389,7 @@ struct tb_regs_port_header {
>   #define PORT_CS_18_CSA				BIT(22)
>   #define PORT_CS_18_TIP				BIT(24)
>   #define PORT_CS_19				0x13
> +#define PORT_CS_19_DPR				BIT(0)
>   #define PORT_CS_19_PC				BIT(3)
>   #define PORT_CS_19_PID				BIT(4)
>   #define PORT_CS_19_WOC				BIT(16)
> @@ -584,6 +585,9 @@ struct tb_regs_hop {
>   #define TB_LC_POWER				0x740
>   
>   /* Link controller registers */
> +#define TB_LC_PORT_MODE				0x26
> +#define TB_LC_PORT_MODE_DPR			BIT(0)
> +
>   #define TB_LC_CS_42				0x2a
>   #define TB_LC_CS_42_USB_PLUGGED			BIT(31)
>   
> diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
> index 675d1ed62372..9e002bf73d2e 100644
> --- a/drivers/thunderbolt/usb4.c
> +++ b/drivers/thunderbolt/usb4.c
> @@ -1107,6 +1107,45 @@ int usb4_port_hotplug_enable(struct tb_port *port)
>   	return tb_port_write(port, &val, TB_CFG_PORT, ADP_CS_5, 1);
>   }
>   
> +/**
> + * usb4_port_reset() - Issue downstream port reset
> + * @port: USB4 port to reset
> + *
> + * Issues downstream port reset to @port.
> + */
> +int usb4_port_reset(struct tb_port *port)
> +{
> +	int ret;
> +	u32 val;
> +
> +	if (!port->cap_usb4)
> +		return -EINVAL;
> +
> +	ret = tb_port_read(port, &val, TB_CFG_PORT,
> +			   port->cap_usb4 + PORT_CS_19, 1);
> +	if (ret)
> +		return ret;
> +
> +	val |= PORT_CS_19_DPR;
> +
> +	ret = tb_port_write(port, &val, TB_CFG_PORT,
> +			    port->cap_usb4 + PORT_CS_19, 1);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(10000);
> +
> +	ret = tb_port_read(port, &val, TB_CFG_PORT,
> +			   port->cap_usb4 + PORT_CS_19, 1);
> +	if (ret)
> +		return ret;
> +
> +	val &= ~PORT_CS_19_DPR;
> +
> +	return tb_port_write(port, &val, TB_CFG_PORT,
> +			     port->cap_usb4 + PORT_CS_19, 1);
> +}
> +
>   static int usb4_port_set_configured(struct tb_port *port, bool configured)
>   {
>   	int ret;
>
>

