Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0B07DBD78
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjJ3QJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjJ3QJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:09:22 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF1FC2;
        Mon, 30 Oct 2023 09:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lz2POrXg+r/N8QlMm8XVWq5W1En8imWKpDGJF5Lj1ZJDGxpCSXDMPtloX7avq7ZXJ4wOtyUopHrT5StTrQoBqZjLX5WogWs/d1hLj5C8kjJIH3PXhcxCU88tBqZVUxAjWBlKrUJALAmlTcCfA7MTO4ai8qAEMw8xQ14NzWXFTXcbuH2mBsSOwoNf+F2FxjR4F3EOy/g8xVXh18NOQqMdnoC6dmbFESfkKP82FYbnv8acmxnTbYNMysKj2n2WfbuvrkxDntoH26F9tbty8V7QaBMBkblv1TZq0IPkjqw1os6rrYGUFlUy28Whff+LTZXay0T+NXbfEwYadggkux9LgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywcVoH3E+GECq4GBYEFAEMvU8hQ+2Qy6FcXrSjenWjk=;
 b=GMZc2M0MDpEaXLbd2xGL6kJWVuaxdYpFXqBLEX1WNcL1ZT6ZuhMN7H/W245TdnQcbMioS3wDBj51FVw7j24FkF+IvGJkPlGF9qjVLPojBI3edeRmjooQQOIRHWBG8VklRD65zlw4gIztqBhsmVrtf0Te+bBlqb69kAoxOViAgyT+bX++PZ6vtdtDeim/0aU/EHRU0mWDEEJ6c1m4eWuLhyVk65GE94NdpxaXj+C1/kqjxGMzVGTZWuskjEzxBCqkpPkLfBqScEyN8rudHiPq/2p6CRvGKP1rp04/gagOWwDgZPIBc6UcTVBkWlitUQ5D+HiCOldundOjCIS/fAYc7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywcVoH3E+GECq4GBYEFAEMvU8hQ+2Qy6FcXrSjenWjk=;
 b=dGJHeXDcQ0lHVvkbAS7VI2Yw8mQCtjEA/zteBs0yML2b4lKd3tex3ts+2ykXn4ZZOzAs6zLheoatdzGMY8qcAEd/oLGDCPi+biWzUYCHaLjulCWfr3zvfG7NFYkoAT/xMGCdBtvk7CfuvCH1jrgELmrM8FK4Qox3qN61pHb5zmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by CH3PR12MB9169.namprd12.prod.outlook.com (2603:10b6:610:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 30 Oct
 2023 16:09:15 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::6b5f:4bf5:84d4:5503]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::6b5f:4bf5:84d4:5503%5]) with mapi id 15.20.6933.027; Mon, 30 Oct 2023
 16:09:15 +0000
Message-ID: <60f523da-f38b-473c-b5f1-f3af8c24bb9b@amd.com>
Date:   Mon, 30 Oct 2023 11:09:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] remoteproc: zynqmp: add pm domains support
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, ben.levinsky@amd.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231013042229.3954527-1-tanmay.shah@amd.com>
 <20231013042229.3954527-4-tanmay.shah@amd.com> <ZTAYASCZA3dZOvmJ@p14s>
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <ZTAYASCZA3dZOvmJ@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0065.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::39) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|CH3PR12MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: afdc12ab-625e-48ac-7d2f-08dbd9628fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gw8OnAvriGkgyujaek2oV37XpfyTIFzzdv8s4fEXTZHWg0FG71Se6BhHzD5MonpiAAy6MZ7MF3qxOzVUSjTGFu3OQyr3J9xpG0ILtilsUJflp4wbfVRV/xfBR9PGOyyTjKGZo8ySqI0DNgcsVzdzbBLAkRZ0qgeCYtyMezCaF7uKPow41IPjb8nA3fjDsOxe20tha0bn86qbsOTT/CR14t4KJbRrWhAUuFS+KOFwL2rr+qvBemkeAEPRG9M5SgKgoDW2JUiU2/oMHtxS3mibUQ9WYM9l5LPnYY7yqZabuQZFNm8ZedSNDjV96Yf4I0JXuPsuXpCm+g1buOCl7ExCszjAS3cnYQqdO3p0nBH4VGjOUyhgUy/It3xHAzI4LQhcJ1RecfTwlwLXu8CimLRKxG+6SYM7Jx6xD07YMO8kKv2g5q6GdJ+AbppVGDe7PSeXt+rNghYBvd8+fR1OyDjJO2t6h63aMjfC6SVIVWnzwWE7pH9Xx3xf5Al6CWUxp8Iays0D5HT1EsN8evKB22mWzHXQAl1atIVRGqO3yxTlPKeuNEo0GPFvM5D/z7zow52etDECkMDXOnmhFbysE26OYOpVFaZAHKP/bm6r9jdk9vSTyyYBlv+GPUC81Qx7UYkE3lh2yfm1pM0X+UlsXSbn0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(30864003)(2906002)(44832011)(4326008)(8936002)(6486002)(5660300002)(478600001)(8676002)(41300700001)(66946007)(316002)(66556008)(6916009)(66476007)(2616005)(31686004)(83380400001)(31696002)(36756003)(86362001)(38100700002)(53546011)(6666004)(6512007)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDlpc1p4YnhmWGN1QWsyMGQ5TGpsWHZlMDh1Z0ljQmpOL2lmNHBQYS81SXBn?=
 =?utf-8?B?SWpob21PY0MyeVJ4TTdvVWFINXRjVEM3Z29tN1hrSGdJMFBKQ3NzRFdIcEwy?=
 =?utf-8?B?U0N3UFU5L3o0WEZ3SnRBcDhuVEJaa0FlL29McmdWWDFyellMbTB6dWwvdDh0?=
 =?utf-8?B?bjQ2RjlhYTBxTHU3R0F6U1VTUmdkVTgrWlFiOS9hbHN5TUVBK3krMjA1S1Ru?=
 =?utf-8?B?SHNOTWxXcWVoNHZlUjdPd05ucURpYlZ2V1lLMy9xRGZ3dWtOZDRUUEdSdU9j?=
 =?utf-8?B?eXBaZCtvUS9zZWpmY2lZV3NXcEZtQ1FEcW9DRjQxekRJb2l1M3V2aUh2elV2?=
 =?utf-8?B?V3k5d2lXbmJLUEVtZmUrMjNoZ3FrT3k1ZjlQWkpmMFFINHFVNFNLaThkZ3Rh?=
 =?utf-8?B?VXRqVzBjYlZzd3ZSNFYreFdubG9nQkJmc0ErNTAxd2oxNHk3TFJrbzdXR3Bi?=
 =?utf-8?B?SVEvc04xZjltNzVjalYvMnNyOGpJOVlWanNrLyt5WXlJNk5LbU9jd2w5SlVo?=
 =?utf-8?B?dHJpTFRtK0FLQThvQ1k4aHZ2NkkzNjdoM2E2UWltcEFnVVo0Ni80TC9lVER1?=
 =?utf-8?B?R2xoYXBNNmFNdkFhS2lnZ3RzVUtSR1pBWFR4N2o2MzBwQ2kvendpZUU5Yktl?=
 =?utf-8?B?dnh4aUZWY0hMQU5OOTI4WkZORVpydTBwZmgvQ0xtSlV6MGtTQ2krMWZYNmRS?=
 =?utf-8?B?eEcvZlJHMHlyTncxV2ZuMlByU3FibENmQUR1ZXVINGllaXY3NTdzZmZWZ2lT?=
 =?utf-8?B?Q0trczk4S3JCT2pFNmdMcDBZcnBYZkIvZWtNc3k3NXU0VWd1a05ycVluR1Qv?=
 =?utf-8?B?bnZYMTVLNTAvb3FURUpVbVhxS2hvZ3RNdXloUlVuZGlPWmxsYjJwWDBiZjQx?=
 =?utf-8?B?SlNxME1JZ25tSDA4aGY3TVhPdTR0bWpBY09jek85ZHhSK2JvSDNwYXozVTRC?=
 =?utf-8?B?YlE1ejF2NkRhZHU5L3FOVlZlbzFMR1ZKOHh0OS90eWVGamNML1llSm03UTEr?=
 =?utf-8?B?eFpta0U5VkpBMTlwclE5dnhXcEx0UDFseDdvZzNtaFE1b0hZTGxUNWV6RlVO?=
 =?utf-8?B?VERRcnhjbUxwNWFsSGx0ZitudnhRWjM5WVYvSDR2Y3hzaHNEemF5bUZCNHZQ?=
 =?utf-8?B?YlNwUk9nYnI2S05Mam02RVN6azZKeEdvMFl1V0JuM055ZWpCeXQrejJzdXpn?=
 =?utf-8?B?VjVFUVpwdnpKTEIrVDNDRmhJdDB4bWx1Z3diY3lzNC9rVm1kWE8xUlFRRXlp?=
 =?utf-8?B?V3lBaHBLRWdSS3pXQ1Z2KzE4aXVwdmhvT2hxUFRIYm01OXlKeDV4NU1XamZW?=
 =?utf-8?B?VGMwUll2YWx4Y1FsemxVeEdnUldGdS8zQ01LOTdnVDArZjZuaHp1Q2NwVnl4?=
 =?utf-8?B?bW9GNXB6bDMxQkd0bllNTC84d1dDSFZkZ2FIYytObWFHbVFTK1RjemRhNzh4?=
 =?utf-8?B?L1BCZjl0enNXN2xJbk9Da1U2RUZ5dWFPTEhNVDhiOUd2dVRPRWtWNzdYeDRU?=
 =?utf-8?B?cStFVTdMYUM4VjNwWmsrZUFoNUppK2VVOUVvbzdtZDdwZXJrek85UkQ4TFZn?=
 =?utf-8?B?UHZ0YVVXNkhEZGFwdzFBNC95VXA2VmhsTkh3TjJrT1NUaVpFRFVlNnJMWWJK?=
 =?utf-8?B?aHNETzViUnFSdHBycS81cXN4TjZNK1M4RmYvOEF6V0JRTXdsOWhKbkN5bk9r?=
 =?utf-8?B?T29OMVphRXBRTTdnaE1ia3Nic1hibnFjbTBMNU5GN25ZWG1sM1VyVGdQTFJG?=
 =?utf-8?B?Q2VNallwZW1WaXN2R0hzd203OFZrNWhkVFRKMVhGRFJaSk9wWGpLR0ZQcmcr?=
 =?utf-8?B?NGIxcjJzNHpqWVhoWmd4VXFPSzBxekZGME43L0FCcVF5bTlkanJtbUZDbjNN?=
 =?utf-8?B?UlY4OW1EeVhJbTZvU3RhNnRoampzVnJORmZsTUpEdFR6ZjRIY3BGSGFlMUsz?=
 =?utf-8?B?NEJyNnNpRlRTK1dmQkx2TkJVRnBmM3oxQ3ZrZGlVbVVKWGZMSkZiOE56UkVJ?=
 =?utf-8?B?WHdZQXQyUVExNjRSN3poV3dMbUgyZUhRRXk4L1dMWVBkQUZMc1VET2w4MW5C?=
 =?utf-8?B?ZGxEby9WVU5MSzZXeWF5cUswaFJBZEtETkxGV01IcDBaTzBaN2YvenE2cTNX?=
 =?utf-8?Q?oCCrDD2CyQFC9WlVUYSala0Am?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afdc12ab-625e-48ac-7d2f-08dbd9628fea
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 16:09:15.0083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9X+jReEVJgilHPTzkf9ua4NimwSLPIap9YX+LHa9Vq0WWSffn1k9tBfrcEZnvKy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9169
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

I agree to all the comments, I will address them in next revision.

Thanks,

Tanmay

On 10/18/23 12:38 PM, Mathieu Poirier wrote:
> Good morning,
>
> On Thu, Oct 12, 2023 at 09:22:28PM -0700, Tanmay Shah wrote:
> > Use TCM pm domains extracted from device-tree
> > to power on/off TCM using general pm domain framework.
> > 
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > ---
> > 
> > Changes in v6:
> >   - Remove spurious change
> >   - Handle errors in add_pm_domains function
> >   - Remove redundant code to handle errors from remove_pm_domains
> > 
> >  drivers/remoteproc/xlnx_r5_remoteproc.c | 262 ++++++++++++++++++++++--
> >  1 file changed, 243 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > index 4395edea9a64..04e95d880184 100644
> > --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/of_reserved_mem.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/remoteproc.h>
> > +#include <linux/pm_domain.h>
> >  
> >  #include "remoteproc_internal.h"
> >  
> > @@ -102,6 +103,12 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> >   * @rproc: rproc handle
> >   * @pm_domain_id: RPU CPU power domain id
> >   * @ipi: pointer to mailbox information
> > + * @num_pm_dev: number of tcm pm domain devices for this core
> > + * @pm_dev1: pm domain virtual devices for power domain framework
> > + * @pm_dev_link1: pm domain device links after registration
> > + * @pm_dev2: used only in lockstep mode. second core's pm domain virtual devices
> > + * @pm_dev_link2: used only in lockstep mode. second core's pm device links after
> > + * registration
> >   */
> >  struct zynqmp_r5_core {
> >  	struct device *dev;
> > @@ -111,6 +118,11 @@ struct zynqmp_r5_core {
> >  	struct rproc *rproc;
> >  	u32 pm_domain_id;
> >  	struct mbox_info *ipi;
> > +	int num_pm_dev;
> > +	struct device **pm_dev1;
>
> s/pm_dev1/pm_dev_core0
>
> > +	struct device_link **pm_dev_link1;
>
> s/pm_dev_link1/pm_dev_core0_link;
>
> > +	struct device **pm_dev2;
>
> s/pm_dev2/pm_dev_core1
>
> > +	struct device_link **pm_dev_link2;
>
> s/pm_dev_link2/pm_dev_core1_link;
>
> >  };
> >  
> >  /**
> > @@ -575,12 +587,21 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> >  		bank_size = r5_core->tcm_banks[i]->size;
> >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> >  
> > -		ret = zynqmp_pm_request_node(pm_domain_id,
> > -					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > -					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > -		if (ret < 0) {
> > -			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> > -			goto release_tcm_split;
> > +		/*
> > +		 * If TCM information is available in device-tree then
> > +		 * in that case, pm domain framework will power on/off TCM.
> > +		 * In that case pm_domain_id is set to 0. If hardcode
> > +		 * bindings from driver is used, then only this driver will
> > +		 * use pm_domain_id.
> > +		 */
> > +		if (pm_domain_id) {
> > +			ret = zynqmp_pm_request_node(pm_domain_id,
> > +						     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > +						     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > +			if (ret < 0) {
> > +				dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> > +				goto release_tcm_split;
> > +			}
>
> This should go in the next patch.
>
> >  		}
> >  
> >  		dev_dbg(dev, "TCM carveout split mode %s addr=%llx, da=0x%x, size=0x%lx",
> > @@ -646,13 +667,16 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> >  	for (i = 0; i < num_banks; i++) {
> >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> >  
> > -		/* Turn on each TCM bank individually */
> > -		ret = zynqmp_pm_request_node(pm_domain_id,
> > -					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > -					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > -		if (ret < 0) {
> > -			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> > -			goto release_tcm_lockstep;
> > +		if (pm_domain_id) {
> > +			/* Turn on each TCM bank individually */
> > +			ret = zynqmp_pm_request_node(pm_domain_id,
> > +						     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > +						     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > +			if (ret < 0) {
> > +				dev_err(dev, "failed to turn on TCM 0x%x",
> > +					pm_domain_id);
> > +				goto release_tcm_lockstep;
> > +			}
>
> Same
>
> >  		}
> >  
> >  		bank_size = r5_core->tcm_banks[i]->size;
> > @@ -687,7 +711,8 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> >  	/* If failed, Turn off all TCM banks turned on before */
> >  	for (i--; i >= 0; i--) {
> >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > -		zynqmp_pm_release_node(pm_domain_id);
> > +		if (pm_domain_id)
> > +			zynqmp_pm_release_node(pm_domain_id);
> >  	}
> >  	return ret;
> >  }
> > @@ -758,6 +783,192 @@ static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
> >  	return ret;
> >  }
> >  
> > +static void zynqmp_r5_remove_pm_domains(struct rproc *rproc)
> > +{
> > +	struct zynqmp_r5_core *r5_core = rproc->priv;
> > +	struct device *dev = r5_core->dev;
> > +	struct zynqmp_r5_cluster *cluster;
> > +	int i;
> > +
> > +	cluster = platform_get_drvdata(to_platform_device(dev->parent));
> > +
> > +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> > +		device_link_del(r5_core->pm_dev_link1[i]);
> > +		dev_pm_domain_detach(r5_core->pm_dev1[i], false);
> > +	}
> > +
> > +	kfree(r5_core->pm_dev1);
> > +	r5_core->pm_dev1 = NULL;
> > +	kfree(r5_core->pm_dev_link1);
> > +	r5_core->pm_dev_link1 = NULL;
> > +
> > +	if (cluster->mode == SPLIT_MODE) {
> > +		r5_core->num_pm_dev = 0;
> > +		return;
> > +	}
> > +
> > +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> > +		device_link_del(r5_core->pm_dev_link2[i]);
> > +		dev_pm_domain_detach(r5_core->pm_dev2[i], false);
> > +	}
> > +
> > +	kfree(r5_core->pm_dev2);
> > +	r5_core->pm_dev2 = NULL;
> > +	kfree(r5_core->pm_dev_link2);
> > +	r5_core->pm_dev_link2 = NULL;
> > +	r5_core->num_pm_dev = 0;
> > +}
> > +
> > +static int zynqmp_r5_add_pm_domains(struct rproc *rproc)
> > +{
> > +	struct zynqmp_r5_core *r5_core = rproc->priv;
> > +	struct device *dev = r5_core->dev, *dev2;
> > +	struct zynqmp_r5_cluster *cluster;
> > +	struct platform_device *pdev;
> > +	struct device_node *np;
> > +	int i, j, num_pm_dev, ret;
> > +
> > +	cluster = dev_get_drvdata(dev->parent);
> > +
> > +	/* get number of power-domains */
> > +	num_pm_dev = of_count_phandle_with_args(r5_core->np, "power-domains",
> > +						"#power-domain-cells");
> > +
> > +	if (num_pm_dev <= 0)
> > +		return -EINVAL;
> > +
> > +	r5_core->pm_dev1 = kcalloc(num_pm_dev,
> > +				   sizeof(struct device *),
> > +				   GFP_KERNEL);
> > +	if (!r5_core->pm_dev1)
> > +		ret = -ENOMEM;
> > +
> > +	r5_core->pm_dev_link1 = kcalloc(num_pm_dev,
> > +					sizeof(struct device_link *),
> > +					GFP_KERNEL);
> > +	if (!r5_core->pm_dev_link1) {
> > +		kfree(r5_core->pm_dev1);
> > +		r5_core->pm_dev1 = NULL;
> > +		return -ENOMEM;
> > +	}
> > +
> > +	r5_core->num_pm_dev = num_pm_dev;
> > +
> > +	/*
> > +	 * start from 2nd entry in power-domains property list as
> > +	 * for zynqmp we only add TCM power domains and not core's power domain.
> > +	 */
>
> It would be worth mentionning where the 1st entry get added.
>
> > +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> > +		r5_core->pm_dev1[i] = dev_pm_domain_attach_by_id(dev, i);
> > +		if (IS_ERR_OR_NULL(r5_core->pm_dev1[i])) {
> > +			dev_dbg(dev, "failed to attach pm domain %d, ret=%ld\n", i,
> > +				PTR_ERR(r5_core->pm_dev1[i]));
> > +			ret = -EINVAL;
> > +			goto fail_add_pm_domains;
> > +		}
> > +		r5_core->pm_dev_link1[i] = device_link_add(dev, r5_core->pm_dev1[i],
> > +							   DL_FLAG_STATELESS |
> > +							   DL_FLAG_RPM_ACTIVE |
> > +							   DL_FLAG_PM_RUNTIME);
> > +		if (!r5_core->pm_dev_link1[i]) {
> > +			dev_pm_domain_detach(r5_core->pm_dev1[i], true);
> > +			r5_core->pm_dev1[i] = NULL;
> > +			ret = -EINVAL;
>
> Cleanup for this iteration is properly done here.  As such the while() loop in
> fail_add_pm_domains needs to be while (--i >= 0).  See my comment below.
>
> > +			goto fail_add_pm_domains;
> > +		}
> > +	}
> > +
> > +	if (cluster->mode == SPLIT_MODE)
> > +		return 0;
> > +
> > +	r5_core->pm_dev2 = kcalloc(num_pm_dev,
> > +				   sizeof(struct device *),
> > +				   GFP_KERNEL);
> > +	if (!r5_core->pm_dev2) {
> > +		ret = -ENOMEM;
> > +		goto fail_add_pm_domains;
> > +	}
> > +
> > +	r5_core->pm_dev_link2 = kcalloc(num_pm_dev,
> > +					sizeof(struct device_link *),
> > +					GFP_KERNEL);
> > +	if (!r5_core->pm_dev_link2) {
> > +		kfree(r5_core->pm_dev2);
> > +		r5_core->pm_dev2 = NULL;
> > +		ret = -ENOMEM;
> > +		goto fail_add_pm_domains;
> > +	}
> > +
> > +	/* get second core's device to detach its power-domains */
> > +	np = of_get_next_child(cluster->dev->of_node, of_node_get(dev->of_node));
> > +
> > +	pdev = of_find_device_by_node(np);
> > +	if (!pdev) {
> > +		dev_err(cluster->dev, "core1 platform device not available\n");
> > +		kfree(r5_core->pm_dev2);
> > +		kfree(r5_core->pm_dev_link2);
> > +		r5_core->pm_dev2 = NULL;
> > +		r5_core->pm_dev_link2 = NULL;
> > +		ret = -EINVAL;
> > +		goto fail_add_pm_domains;
> > +	}
> > +
> > +	dev2 = &pdev->dev;
> > +
> > +	/* for zynqmp we only add TCM power domains and not core's power domain */
> > +	for (j = 1; j < r5_core->num_pm_dev; j++) {
> > +		r5_core->pm_dev2[j] = dev_pm_domain_attach_by_id(dev2, j);
> > +		if (!r5_core->pm_dev2[j]) {
> > +			dev_dbg(dev, "can't attach to pm domain %d\n", j);
> > +			ret = -EINVAL;
> > +			goto fail_add_pm_domains_lockstep;
> > +		} else if (IS_ERR(r5_core->pm_dev2[j])) {
> > +			dev_dbg(dev, "can't attach to pm domain %d\n", j);
> > +			ret = PTR_ERR(r5_core->pm_dev2[j]);
> > +			goto fail_add_pm_domains_lockstep;
> > +		}
> > +
> > +		r5_core->pm_dev_link2[j] = device_link_add(dev, r5_core->pm_dev2[j],
> > +							   DL_FLAG_STATELESS |
> > +							   DL_FLAG_RPM_ACTIVE |
> > +							   DL_FLAG_PM_RUNTIME);
> > +		if (!r5_core->pm_dev_link2[j]) {
> > +			dev_pm_domain_detach(r5_core->pm_dev2[j], true);
> > +			r5_core->pm_dev2[j] = NULL;
> > +			ret = -ENODEV;
> > +			goto fail_add_pm_domains_lockstep;
> > +		}
> > +	}
> > +
> > +fail_add_pm_domains_lockstep:
> > +	while (j >= 1) {
> > +		if (r5_core->pm_dev_link2 && !IS_ERR_OR_NULL(r5_core->pm_dev_link2[j]))
> > +			device_link_del(r5_core->pm_dev_link2[j]);
> > +		if (r5_core->pm_dev2 && !IS_ERR_OR_NULL(r5_core->pm_dev2[j]))
> > +			dev_pm_domain_detach(r5_core->pm_dev2[j], true);
> > +		j--;
> > +	}
> > +	kfree(r5_core->pm_dev2);
> > +	r5_core->pm_dev2 = NULL;
> > +	kfree(r5_core->pm_dev_link2);
> > +	r5_core->pm_dev_link2 = NULL;
> > +
> > +fail_add_pm_domains:
> > +	while (i >= 1) {
> > +		if (r5_core->pm_dev_link1 && !IS_ERR_OR_NULL(r5_core->pm_dev_link1[i]))
> > +			device_link_del(r5_core->pm_dev_link1[i]);
>
> Because the cleanup is properly done above we can start the loop at the previous
> value of 'i', i.e --i.  The added bonus is that you don't need the if()
> statement.
>
> Another problem with starting at 'i' is that you get an out of bound access when
> all PM domains have been properly added for core 0 but fail for core 1.
>
> > +		if (r5_core->pm_dev1 && !IS_ERR_OR_NULL(r5_core->pm_dev1[i]))
> > +			dev_pm_domain_detach(r5_core->pm_dev1[i], true);
>
> Same as above.
>
> I will stop here for this revision.
>
> Mathieu
>
>
> > +		i--;
> > +	}
> > +	kfree(r5_core->pm_dev1);
> > +	r5_core->pm_dev1 = NULL;
> > +	kfree(r5_core->pm_dev_link1);
> > +	r5_core->pm_dev_link1 = NULL;
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * zynqmp_r5_rproc_prepare()
> >   * adds carveouts for TCM bank and reserved memory regions
> > @@ -770,19 +981,30 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
> >  {
> >  	int ret;
> >  
> > +	ret = zynqmp_r5_add_pm_domains(rproc);
> > +	if (ret) {
> > +		dev_err(&rproc->dev, "failed to add pm domains\n");
> > +		return ret;
> > +	}
> > +
> >  	ret = add_tcm_banks(rproc);
> >  	if (ret) {
> >  		dev_err(&rproc->dev, "failed to get TCM banks, err %d\n", ret);
> > -		return ret;
> > +		goto fail_prepare;
> >  	}
> >  
> >  	ret = add_mem_regions_carveout(rproc);
> >  	if (ret) {
> >  		dev_err(&rproc->dev, "failed to get reserve mem regions %d\n", ret);
> > -		return ret;
> > +		goto fail_prepare;
> >  	}
> >  
> >  	return 0;
> > +
> > +fail_prepare:
> > +	zynqmp_r5_remove_pm_domains(rproc);
> > +
> > +	return ret;
> >  }
> >  
> >  /**
> > @@ -801,11 +1023,13 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
> >  
> >  	r5_core = rproc->priv;
> >  
> > +	zynqmp_r5_remove_pm_domains(rproc);
> > +
> >  	for (i = 0; i < r5_core->tcm_bank_count; i++) {
> >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > -		if (zynqmp_pm_release_node(pm_domain_id))
> > -			dev_warn(r5_core->dev,
> > -				 "can't turn off TCM bank 0x%x", pm_domain_id);
> > +		if (pm_domain_id && zynqmp_pm_release_node(pm_domain_id))
> > +			dev_dbg(r5_core->dev,
> > +				"can't turn off TCM bank 0x%x", pm_domain_id);
> >  	}
> >  
> >  	return 0;
> > -- 
> > 2.25.1
> > 
