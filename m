Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEBB7FDE91
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjK2Rmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjK2Rmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:42:42 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B424095;
        Wed, 29 Nov 2023 09:42:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fG6Cra2m/CxhHX/zoE32gN7Yv2CmOX6bjz4NpJniuu1u4V/LhqYkWuCfX8Hfn0ESh5r064Q6If3dRLRcAzJsvRuhxiJOMRrEuZ8yOBotUcsqV8AjabNpxqdTIGVOqQzY3wkqfLMr+1UtFT1OwvVNW0Joj1gmimLUEauZvEErRfUGzUiLBCyhdiyKugDBV5WUhCXxYGqUc0OuIZ6ByVIubZYcYFY7pMsh0PY/D5HACVO3xUUoySTx3rzcPdCrC0vXEA4ltOumEgB8uiqm8rakgfrmnypiROGk2jmlLznRlmYBlpOmA9I64Y/L6hgCZzijCHJR132jWIwiScqqF5CVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFxWBMPP+2Cda0N9TnlOMEgv5vgcrM0ZZUd2AuWyrt4=;
 b=TgihLqcVJVCXzmuY26kKi+7HSh2HVqE2DH2pAsipo2WQlvRbfG36uievlS2vdOD+j8B1who6BI1mL+8u6O193zHnTgd2YHrXbv9bp+oqIirWW2+bufF20F0lTOoQb3/m6x93tbrIVCc6l0FKQIA+wzY5WiaZGb3rCtyXJra1c1t79GriwTbngaTku6EzclP625IZIerSsFAx5FooCQkLRbbZ74NqLBCHgYdabtyeP7Ijl1JvI9Py3YMq7ep+b5ZkcekOoYpjRPwkcuJEGsuLKhoUUi5v5NR4xG8gCEuEdu7ne8BoIbmVOKCnNE15o25AoR7yi6jkhR+iNhTKb694mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFxWBMPP+2Cda0N9TnlOMEgv5vgcrM0ZZUd2AuWyrt4=;
 b=x3xrCkJC9kIpHrZWnmDp5suNRbadg9H+bv//LiQN4um9FlEHQHUtkxQl3hwi+cQQeDKXnlI+ne8xIpEYnzycaPta3DuqsjBgTTb4DQH6hcHfp0E/3Bp1YIG8N6f9jjYV4jh98PoK3R9FSbAI+f4K4/gpZWKjDQrWQ5MZPjEJxk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 17:42:43 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e%4]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 17:42:43 +0000
Message-ID: <e92776fc-45be-4d2c-b0a0-440575bbd60c@amd.com>
Date:   Wed, 29 Nov 2023 11:42:40 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v7 3/4] remoteproc: zynqmp: add pm domains support
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, ben.levinsky@amd.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231117174238.1876655-1-tanmay.shah@amd.com>
 <20231117174238.1876655-4-tanmay.shah@amd.com> <ZV02P3bHEhPLQHBo@p14s>
 <93487d3c-c324-4b9b-8b25-0b4ea52237b4@amd.com> <ZV+V6V2sEWgsqngk@p14s>
 <a75b22c1-66e3-4fce-ae64-de79e73f3cfa@amd.com> <ZWdwl/8LC2Nn+vCq@p14s>
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <ZWdwl/8LC2Nn+vCq@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::13) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e915002-4121-4083-ce77-08dbf1029719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mBrs6q1K4RdhH+EtY/kE6Ogv9H5gk05kc8kq2UyGlMp9OIQRoXjG6srMiIKqnkp4pYY4KVI2koChgWgo8XBH/BUvTQf3R8QZESp/CfNXJW+F5r3pvm3RLJa1SlhdxQa5X9fGHgI+kQb4lypfKJJwRrHdJdIV404UaS0hApjM+bZumanAVG2ZT4c5iInR6rFMUPPhn/LdsMSwr2Ilcrqj424nCwu4oundJNU3Ue4WxUs7aBpm+2ZY4Yc7WSNAbYGwAlE9hhLJXpTZakNu0whAx1gW1xiXjPUUe2DIHZO1xZiX/SBN4dgbloVDxwGCVCuLoiykAfDN17c/KezcEhfNlsEaFJO+w2trQ+KtU1tPWmOdWkiT7Blp4+2El5eIp81MNouQcIIQgvarUJJvS+fTDrgEBDdtsVeNJfpyJmQsQlD2x6vVkTaO1wwSWPWrAEnxdvMTMp0+jXIUZq2roOJK6WpJuNG9AhU5UHOWgpdqZJj+5xATgchw7mQC90t61Voq+Iax3uai4YbjCdOqddTKlKrc1EoBtlIhpzhyFDBxz1pzP+Cvsf1MP2fDN1CLJt3R+ESzYj3FWACXtXuxRBhkrY/7W7gEc9wij8tvNNWK2jC+uRknCdlGU3etwQzWkpAT7//lrU5+pGkQdK0Bv67aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(366004)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66946007)(66556008)(316002)(6486002)(53546011)(66476007)(6916009)(6506007)(478600001)(6512007)(83380400001)(36756003)(86362001)(38100700002)(2616005)(44832011)(4326008)(5660300002)(8676002)(8936002)(41300700001)(31696002)(31686004)(2906002)(26005)(30864003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tzg2ckRTSEE1MmpGTUwrRTcza3JpWmpFL0hKKzJLN212cEp6Y01mb0tiZEtn?=
 =?utf-8?B?ZjlYUy9VRmNOQU43TXI4d01iNGN0a3ZVRUgrMmkxbmJZODFTVEErQ3ZwSEVT?=
 =?utf-8?B?TGFvMjBKbFA5TExBaVVybzQyc2g1U0NXOWNzeVpaKzR0dmdIbWE4M2tReTZB?=
 =?utf-8?B?bm9Lc3hVQkFNSjhrN0J6U29Xb3JCODVRVnBteW1LbGQrRnR3UExuQ2ZVRXlE?=
 =?utf-8?B?amM4bVFOQnlMcEFUYlBMVWRJOHQraDR0VjE3Nkdad2JJZEYybGRxRkpwTWxM?=
 =?utf-8?B?VGExWVZFelMwNGI5SWl6VCtTbHBwL3EraFpzaFgvU3dkWE9QdXg0VTlaRzEv?=
 =?utf-8?B?YkdZQi9yWHlhZ0ZZYnVyNCtkcDQ4cU1hbFFjV2NWV3ZDb29BaHdCclNZajIy?=
 =?utf-8?B?dzZUU1B4ZHBHbUFnWTc5ZnVJUnkxWVBvc2Z5SHBxdlBBMktZYjVYOGxVUTRD?=
 =?utf-8?B?NkZGSkQvdXVjMG9CbDZPZGlLcjY0cDhXS1JrdHJZSUlCN1kzcGRnOGsraHVy?=
 =?utf-8?B?SkhQdEx5eVIxZ2NTcDlRcGxVSGtVSFh3cjRpS3Z2WHNXN052OEo5djhXZmtW?=
 =?utf-8?B?Vkloakt0QkJzbUx1S0h3Zlp4c0FXaWtNMmUvaXhrVld2YjJYalZob2c5eUwr?=
 =?utf-8?B?NVpYTnY2aERRUDV1R3V3WTMxOEpXb1R1N2JCK1RKYTFYL0JwUFduUWk0b3Q5?=
 =?utf-8?B?eE5OR0hjRzI3cFhQcmN4b3hlYmZBUEgrMzhRL3pTMlllQVZFbVBxTlpua1E5?=
 =?utf-8?B?eS9QVE1Gb2FLRTlTSDloYUlueGJwL1RTRkg0c2xGazdlRTlnS2s3L2ZmWkQz?=
 =?utf-8?B?QWxna1B4cXVrc2RWRmZGb09KWlh3Q1NqODhZcmhWM2l2TUNlQjJlUkFDNm0x?=
 =?utf-8?B?TkJsSnBtNlBBSGRqVExjaDZVdENOWlhJYk5qVml6WldHUDY0ajYwcHFja3Jl?=
 =?utf-8?B?V1JqdmxvUGF0TVJBeCs2aFFWbk9xQjJXNEgxZHgzLzA3U2VuV01hYi9IUThh?=
 =?utf-8?B?a0krbVFyU3Q5UzFBVW1RNlU4VGdSOW9zRDNVNXhkVkQ4R1NQaTZoSDFLaEww?=
 =?utf-8?B?SW82bDc3M0VtbkpDYkRnK2hHUkZnVGxHeXZiais4aHllc2ZzeFp1NXlIRk9L?=
 =?utf-8?B?eERHRFVrYXc5M0JHZDlURHBnMVlNZ2ROZXA0SHNTbmg2VTFBV1luWTN1dGtx?=
 =?utf-8?B?K08rU25Ib1krc1lmT3Buak1Qck9JZVMySVluU2xrak5JaWxBa0c4UFpFbXZ6?=
 =?utf-8?B?eVFpMmxKeWhjcEltekNWWjFCMzJTSlppZXB6V1orQmxJOWk1a2RJcmM2RTBS?=
 =?utf-8?B?d2J6Y05UV1k0eHlQV28wYTNjVXZPUzIrTTJVMUdZNkJpQitZRnJTbzhEUnRM?=
 =?utf-8?B?NlN4c1kvYzZCaHk0UTBGWlRJQUxiK0pLZFpId2pYcXg4K2lRUHZlVGFuS2Qw?=
 =?utf-8?B?d2pnUXh3VTB0ZDFYU1lHYnRmT2RiMjZWSWF2dXFkbEU4RVdVMnBPK1V2SHFD?=
 =?utf-8?B?U1BxN2I4QmxFZHd1eFJtdXluRG1BNVFic2YwdG5sR1ZZY1Y5VmZtYVZkaG5r?=
 =?utf-8?B?V0RnNndSYS9pK3FPV29KNlBCcmpud1F5VUxKdlNzRXVZYUdVdnhxVXZRY0dI?=
 =?utf-8?B?NXNtK3Yzb2lYaVNlcTZGa0VRODd3cHFzbXhORUlQTm52dFcyaGZ2UGNhKzlZ?=
 =?utf-8?B?dDVzbjRHWk1nK01FZnRSY0ErV1JtMVQvT3diOGU0Nng0dVc5T0V6TmFHS1Jo?=
 =?utf-8?B?ZVFoTjZ4NVc5NHR5bWh1VVpRVHJkQ3BncmQ2emtvcHRNSGFLalhnZlc1RlQ1?=
 =?utf-8?B?THRMMGpBSTFDUTc0V2pUVnlkNHNxamN1Ykw3VStKQ0lQR0JLYmFieXhFdlZw?=
 =?utf-8?B?TGRCbVZ6QUh1b0FMRVFTUmtxYS9BUGRQVUYxWm41R2lNSk1NcnYvenI3aVpj?=
 =?utf-8?B?NFR4YUhmTmQxNkdrK3VhOXpGNFpsVjgydk5XcVpWdFpCYzVrZUtWTkJndjQ4?=
 =?utf-8?B?OXorZXJaMWZkWXhVVytZekxJR296TnJhVjVMOUJFV3NacmF5Y2FZUE5pdUZv?=
 =?utf-8?B?b3F3TzQ2MFhDM05odkRGQlZsNHJGZUp0SnFrbGFNVkxLZTFqYmN5MXNWTDho?=
 =?utf-8?Q?DvzF2GzpWiILqrPb7ZJpoaJ68?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e915002-4121-4083-ce77-08dbf1029719
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 17:42:43.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSy/t78tJKvbWShY9c+N7O4LUlIbeSRKS+D1WvWBQ65IoG/Y+oYopTrI/LTtl60S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/29/23 11:10 AM, Mathieu Poirier wrote:
> On Mon, Nov 27, 2023 at 10:33:05AM -0600, Tanmay Shah wrote:
> > 
> > On 11/23/23 12:11 PM, Mathieu Poirier wrote:
> > > On Wed, Nov 22, 2023 at 03:00:36PM -0600, Tanmay Shah wrote:
> > > > Hi Mathieu,
> > > > 
> > > > Please find my comments below.
> > > > 
> > > > On 11/21/23 4:59 PM, Mathieu Poirier wrote:
> > > > > Hi,
> > > > >
> > > > > On Fri, Nov 17, 2023 at 09:42:37AM -0800, Tanmay Shah wrote:
> > > > > > Use TCM pm domains extracted from device-tree
> > > > > > to power on/off TCM using general pm domain framework.
> > > > > > 
> > > > > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > > > > ---
> > > > > > 
> > > > > > Changes in v7:
> > > > > >   - %s/pm_dev1/pm_dev_core0/r
> > > > > >   - %s/pm_dev_link1/pm_dev_core0_link/r
> > > > > >   - %s/pm_dev2/pm_dev_core1/r
> > > > > >   - %s/pm_dev_link2/pm_dev_core1_link/r
> > > > > >   - remove pm_domain_id check to move next patch
> > > > > >   - add comment about how 1st entry in pm domain list is used
> > > > > >   - fix loop when jump to fail_add_pm_domains loop
> > > > > > 
> > > > > >  drivers/remoteproc/xlnx_r5_remoteproc.c | 215 +++++++++++++++++++++++-
> > > > > >  1 file changed, 212 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > > > index 4395edea9a64..22bccc5075a0 100644
> > > > > > --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > > > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > > > @@ -16,6 +16,7 @@
> > > > > >  #include <linux/of_reserved_mem.h>
> > > > > >  #include <linux/platform_device.h>
> > > > > >  #include <linux/remoteproc.h>
> > > > > > +#include <linux/pm_domain.h>
> > > > > >  
> > > > > >  #include "remoteproc_internal.h"
> > > > > >  
> > > > > > @@ -102,6 +103,12 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> > > > > >   * @rproc: rproc handle
> > > > > >   * @pm_domain_id: RPU CPU power domain id
> > > > > >   * @ipi: pointer to mailbox information
> > > > > > + * @num_pm_dev: number of tcm pm domain devices for this core
> > > > > > + * @pm_dev_core0: pm domain virtual devices for power domain framework
> > > > > > + * @pm_dev_core0_link: pm domain device links after registration
> > > > > > + * @pm_dev_core1: used only in lockstep mode. second core's pm domain virtual devices
> > > > > > + * @pm_dev_core1_link: used only in lockstep mode. second core's pm device links after
> > > > > > + * registration
> > > > > >   */
> > > > > >  struct zynqmp_r5_core {
> > > > > >  	struct device *dev;
> > > > > > @@ -111,6 +118,11 @@ struct zynqmp_r5_core {
> > > > > >  	struct rproc *rproc;
> > > > > >  	u32 pm_domain_id;
> > > > > >  	struct mbox_info *ipi;
> > > > > > +	int num_pm_dev;
> > > > > > +	struct device **pm_dev_core0;
> > > > > > +	struct device_link **pm_dev_core0_link;
> > > > > > +	struct device **pm_dev_core1;
> > > > > > +	struct device_link **pm_dev_core1_link;
> > > > > >  };
> > > > > >  
> > > > > >  /**
> > > > > > @@ -651,7 +663,8 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > > > > >  					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > > > > >  					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > > > > >  		if (ret < 0) {
> > > > > > -			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> > > > > > +			dev_err(dev, "failed to turn on TCM 0x%x",
> > > > > > +				pm_domain_id);
> > > > >
> > > > > Spurious change, you should have caught that.
> > > > 
> > > > Ack, need to observe changes more closely before sending them.
> > > > 
> > > > >
> > > > > >  			goto release_tcm_lockstep;
> > > > > >  		}
> > > > > >  
> > > > > > @@ -758,6 +771,189 @@ static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
> > > > > >  	return ret;
> > > > > >  }
> > > > > >  
> > > > > > +static void zynqmp_r5_remove_pm_domains(struct rproc *rproc)
> > > > > > +{
> > > > > > +	struct zynqmp_r5_core *r5_core = rproc->priv;
> > > > > > +	struct device *dev = r5_core->dev;
> > > > > > +	struct zynqmp_r5_cluster *cluster;
> > > > > > +	int i;
> > > > > > +
> > > > > > +	cluster = platform_get_drvdata(to_platform_device(dev->parent));
> > > > > > +
> > > > > > +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> > > > > > +		device_link_del(r5_core->pm_dev_core0_link[i]);
> > > > > > +		dev_pm_domain_detach(r5_core->pm_dev_core0[i], false);
> > > > > > +	}
> > > > > > +
> > > > > > +	kfree(r5_core->pm_dev_core0);
> > > > > > +	r5_core->pm_dev_core0 = NULL;
> > > > > > +	kfree(r5_core->pm_dev_core0_link);
> > > > > > +	r5_core->pm_dev_core0_link = NULL;
> > > > > > +
> > > > > > +	if (cluster->mode == SPLIT_MODE) {
> > > > > > +		r5_core->num_pm_dev = 0;
> > > > > > +		return;
> > > > > > +	}
> > > > > > +
> > > > > > +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> > > > > > +		device_link_del(r5_core->pm_dev_core1_link[i]);
> > > > > > +		dev_pm_domain_detach(r5_core->pm_dev_core1[i], false);
> > > > > > +	}
> > > > > > +
> > > > > > +	kfree(r5_core->pm_dev_core1);
> > > > > > +	r5_core->pm_dev_core1 = NULL;
> > > > > > +	kfree(r5_core->pm_dev_core1_link);
> > > > > > +	r5_core->pm_dev_core1_link = NULL;
> > > > > > +	r5_core->num_pm_dev = 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int zynqmp_r5_add_pm_domains(struct rproc *rproc)
> > > > > > +{
> > > > > > +	struct zynqmp_r5_core *r5_core = rproc->priv;
> > > > > > +	struct device *dev = r5_core->dev, *dev2;
> > > > > > +	struct zynqmp_r5_cluster *cluster;
> > > > > > +	struct platform_device *pdev;
> > > > > > +	struct device_node *np;
> > > > > > +	int i, j, num_pm_dev, ret;
> > > > > > +
> > > > > > +	cluster = dev_get_drvdata(dev->parent);
> > > > > > +
> > > > > > +	/* get number of power-domains */
> > > > > > +	num_pm_dev = of_count_phandle_with_args(r5_core->np, "power-domains",
> > > > > > +						"#power-domain-cells");
> > > > > > +
> > > > > > +	if (num_pm_dev <= 0)
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	r5_core->pm_dev_core0 = kcalloc(num_pm_dev,
> > > > > > +					sizeof(struct device *),
> > > > > > +					GFP_KERNEL);
> > > > > > +	if (!r5_core->pm_dev_core0)
> > > > > > +		ret = -ENOMEM;
> > > > > > +
> > > > > > +	r5_core->pm_dev_core0_link = kcalloc(num_pm_dev,
> > > > > > +					     sizeof(struct device_link *),
> > > > > > +					     GFP_KERNEL);
> > > > > > +	if (!r5_core->pm_dev_core0_link) {
> > > > > > +		kfree(r5_core->pm_dev_core0);
> > > > > > +		r5_core->pm_dev_core0 = NULL;
> > > > > > +		return -ENOMEM;
> > > > > > +	}
> > > > > > +
> > > > > > +	r5_core->num_pm_dev = num_pm_dev;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * start from 2nd entry in power-domains property list as
> > > > > > +	 * for zynqmp we only add TCM power domains and not core's power domain.
> > > > > > +	 * 1st entry is used to configure r5 operation mode.
> > > > >
> > > > > You are still not saying _where_ ->pm_dev_core0[0] gets added.
> > > > 
> > > > So, pm_dev_core0[0] isn't really need to be added for zynqmp platform, as firmware starts it with call,
> > > > 
> > > > zynqmp_pm_request_wake during rproc_start callback. I will document this in next
> > > >
> > >
> > > That is exactly what I am looking for.  That way people don't have to go through
> > > the entire driver trying to figure out what is happening with pm_dev_core[0].
> > >
> > > I'm also not sure about the power-up order.  Logically the TCMs should be
> > > powered up before the R5 in order to put code in them.  The R5s are powered in
> > > zynqmp_r5_rproc_start() but I am unclear as to where in the boot sequence the
> > > TCMs are powered - can you expand on that?
> > 
> > 
> > Sure. Following is call sequece
> > 
> > zynqmp_r5_rproc_prepare
> > 
> > zynqmp_r5_add_pm_domains -> Here TCM is powered on when device_link_add is called via zynqmp-pm-domains.c driver.
> > 
> > . . .
> > 
> > zynqmp_r5_rproc_start -> load firmware and Starts RPU
> > 
> > So what you mentioned is correct, TCM is being powerd-on before we load firmware and start RPU.
> > 
> > 
> > >
> > > > revision. For new platforms pm_dev_core0[0] will be added in future.
> > >
> > > Now I'm really confused - what do you mean by "pm_dev_core0[0] will be added in
> > > future"?
> > 
> > 
> > ZynqMP platform has platform management firmware running on microblaze.
> > 
> > This firmware design does not expect R5 pm domains to be requested explicitly.
> > 
> > This means, during zynqmp_r5_rproc_start when "zynqmp_pm_request_wake" is called,
> > 
> > firmware powers on R5. So, pm_dev_core[0] is not really used for ZynqMP.
> > 
> > However, this design was changed for new platforms i.e. "versal" and onwards.
> > 
> > Firmware of new platform expects pm domains to be requested explicitly for R5 cores before
> > 
> > waking them up.
> > 
> > That means, pm_dev_core[0] for R5 cores on new platform (Versal) needs to be used same as TCM.
> > 
> > Then, we should wake it up on r5_core.
> > 
> > To summarize:
> > 
> > For zynqmp only following call needed to start R5:
> > 
> > zynqmp_pm_request_wake
> > 
> > For "versal" and onwards we need two calls to start R5:
> > 
> > "device_link_add" and zynqmp_pm_request_wake
> > 
> > So, in future pm_core_dev[0] will be used.
> >
>
> Thanks for the clarification on both front.  The problem here is that we are
> keeping R5 power domain information in two different places, i.e
> zynqmp_r5_core::pm_domain_id and zynqmp_r5_core::pm_dev_core0[0].  
>
> Please see if you can retreive the power domain ID from
> zynqmp_r5_core::pm_dev_core0[0].  That way you can get the power domain ID when
> calling zynqmp_pm_request_wake() and zynqmp_pm_force_pwrdwn() and get rid of
> zynqmp_r5_core::pm_domain_id.

Thanks for this suggestion. Let me find out if I can retrieve that or not.

I believe it should be possible.

> > 
> > > > 
> > > > I hope this meets expectations.
> > > > 
> > > > 
> > > > >
> > > > > > +	 */
> > > > > > +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> > > > > > +		r5_core->pm_dev_core0[i] = dev_pm_domain_attach_by_id(dev, i);
> > > > > > +		if (IS_ERR_OR_NULL(r5_core->pm_dev_core0[i])) {
> > > > >
> > > > > Here IS_ERR_OR_NULL() is used while two if conditions for NULL and an error
> > > > > code are used in the loop for the lockstep mode.  Please pick one heuristic and
> > > > > stick with it.  I have no preference on which one.
> > > > 
> > > > Ok, I think IS_ERR_OR_NULL is more cleaner, I will address it in next revision.
> > > > 
> > > > 
> > > > >
> > > > > > +			dev_dbg(dev, "failed to attach pm domain %d, ret=%ld\n", i,
> > > > > > +				PTR_ERR(r5_core->pm_dev_core0[i]));
> > > > > > +			ret = -EINVAL;
> > > > > > +			goto fail_add_pm_domains;
> > > > > > +		}
> > > > > > +		r5_core->pm_dev_core0_link[i] = device_link_add(dev,
> > > > > > +								r5_core->pm_dev_core0[i],
> > > > > > +								DL_FLAG_STATELESS |
> > > > > > +								DL_FLAG_RPM_ACTIVE |
> > > > > > +								DL_FLAG_PM_RUNTIME);
> > > > > > +		if (!r5_core->pm_dev_core0_link[i]) {
> > > > > > +			dev_pm_domain_detach(r5_core->pm_dev_core0[i], true);
> > > > > > +			r5_core->pm_dev_core0[i] = NULL;
> > > > > > +			ret = -EINVAL;
> > > > > > +			goto fail_add_pm_domains;
> > > > > > +		}
> > > > > > +	}
> > > > > > +
> > > > > > +	if (cluster->mode == SPLIT_MODE)
> > > > > > +		return 0;
> > > > > > +
> > > > > > +	r5_core->pm_dev_core1 = kcalloc(num_pm_dev,
> > > > > > +					sizeof(struct device *),
> > > > > > +					GFP_KERNEL);
> > > > > > +	if (!r5_core->pm_dev_core1) {
> > > > > > +		ret = -ENOMEM;
> > > > > > +		goto fail_add_pm_domains;
> > > > > > +	}
> > > > > > +
> > > > > > +	r5_core->pm_dev_core1_link = kcalloc(num_pm_dev,
> > > > > > +					     sizeof(struct device_link *),
> > > > > > +					     GFP_KERNEL);
> > > > > > +	if (!r5_core->pm_dev_core1_link) {
> > > > > > +		kfree(r5_core->pm_dev_core1);
> > > > > > +		r5_core->pm_dev_core1 = NULL;
> > > > > > +		ret = -ENOMEM;
> > > > > > +		goto fail_add_pm_domains;
> > > > > > +	}
> > > > > > +
> > > > > > +	/* get second core's device to detach its power-domains */
> > > > > > +	np = of_get_next_child(cluster->dev->of_node, of_node_get(dev->of_node));
> > > > > > +
> > > > > > +	pdev = of_find_device_by_node(np);
> > > > > > +	if (!pdev) {
> > > > > > +		dev_err(cluster->dev, "core1 platform device not available\n");
> > > > > > +		kfree(r5_core->pm_dev_core1);
> > > > > > +		kfree(r5_core->pm_dev_core1_link);
> > > > > > +		r5_core->pm_dev_core1 = NULL;
> > > > > > +		r5_core->pm_dev_core1_link = NULL;
> > > > > > +		ret = -EINVAL;
> > > > > > +		goto fail_add_pm_domains;
> > > > > > +	}
> > > > > > +
> > > > > > +	dev2 = &pdev->dev;
> > > > > > +
> > > > > > +	/* for zynqmp we only add TCM power domains and not core's power domain */
> > > > > > +	for (j = 1; j < r5_core->num_pm_dev; j++) {
> > > > > > +		r5_core->pm_dev_core1[j] = dev_pm_domain_attach_by_id(dev2, j);
> > > > > > +		if (!r5_core->pm_dev_core1[j]) {
> > > > > > +			dev_dbg(dev, "can't attach to pm domain %d\n", j);
> > > > > > +			ret = -EINVAL;
> > > > > > +			goto fail_add_pm_domains_lockstep;
> > > > > > +		} else if (IS_ERR(r5_core->pm_dev_core1[j])) {
> > > > > > +			dev_dbg(dev, "can't attach to pm domain %d\n", j);
> > > > > > +			ret = PTR_ERR(r5_core->pm_dev_core1[j]);
> > > > > > +			goto fail_add_pm_domains_lockstep;
> > > > > > +		}
> > > > > > +
> > > > > > +		r5_core->pm_dev_core1_link[j] = device_link_add(dev,
> > > > > > +								r5_core->pm_dev_core1[j],
> > > > > > +								DL_FLAG_STATELESS |
> > > > > > +								DL_FLAG_RPM_ACTIVE |
> > > > > > +								DL_FLAG_PM_RUNTIME);
> > > > > > +		if (!r5_core->pm_dev_core1_link[j]) {
> > > > > > +			dev_pm_domain_detach(r5_core->pm_dev_core1[j], true);
> > > > > > +			r5_core->pm_dev_core1[j] = NULL;
> > > > > > +			ret = -ENODEV;
> > > > > > +			goto fail_add_pm_domains_lockstep;
> > > > > > +		}
> > > > > > +	}
> > > > > > +
> > > > > > +fail_add_pm_domains_lockstep:
> > > > > > +	while (--j >= 0) {
> > > > > > +		device_link_del(r5_core->pm_dev_core1_link[j]);
> > > > > > +		dev_pm_domain_detach(r5_core->pm_dev_core1[j], true);
> > > > > > +	}
> > > > > > +	kfree(r5_core->pm_dev_core1);
> > > > > > +	r5_core->pm_dev_core1 = NULL;
> > > > > > +	kfree(r5_core->pm_dev_core1_link);
> > > > > > +	r5_core->pm_dev_core1_link = NULL;
> > > > > > +
> > > > > > +fail_add_pm_domains:
> > > > > > +	while (--i >= 0) {
> > > > > > +		device_link_del(r5_core->pm_dev_core0_link[i]);
> > > > > > +		dev_pm_domain_detach(r5_core->pm_dev_core0[i], true);
> > > > > > +	}
> > > > > > +	kfree(r5_core->pm_dev_core0);
> > > > > > +	r5_core->pm_dev_core0 = NULL;
> > > > > > +	kfree(r5_core->pm_dev_core0_link);
> > > > > > +	r5_core->pm_dev_core0_link = NULL;
> > > > > > +
> > > > >
> > > > > The error path is much cleaner and readable now.
> > > > >
> > > > > I will continue tomorrow.
> > > > >
> > > > > Mathieu
> > > > >
> > > > > > +	return ret;
> > > > > > +}
> > > > > > +
> > > > > >  /**
> > > > > >   * zynqmp_r5_rproc_prepare()
> > > > > >   * adds carveouts for TCM bank and reserved memory regions
> > > > > > @@ -770,19 +966,30 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
> > > > > >  {
> > > > > >  	int ret;
> > > > > >  
> > > > > > +	ret = zynqmp_r5_add_pm_domains(rproc);
> > > > > > +	if (ret) {
> > > > > > +		dev_err(&rproc->dev, "failed to add pm domains\n");
> > > > > > +		return ret;
> > > > > > +	}
> > > > > > +
> > > > > >  	ret = add_tcm_banks(rproc);
> > > > > >  	if (ret) {
> > > > > >  		dev_err(&rproc->dev, "failed to get TCM banks, err %d\n", ret);
> > > > > > -		return ret;
> > > > > > +		goto fail_prepare;
> > > > > >  	}
> > > > > >  
> > > > > >  	ret = add_mem_regions_carveout(rproc);
> > > > > >  	if (ret) {
> > > > > >  		dev_err(&rproc->dev, "failed to get reserve mem regions %d\n", ret);
> > > > > > -		return ret;
> > > > > > +		goto fail_prepare;
> > > > > >  	}
> > > > > >  
> > > > > >  	return 0;
> > > > > > +
> > > > > > +fail_prepare:
> > > > > > +	zynqmp_r5_remove_pm_domains(rproc);
> > > > > > +
> > > > > > +	return ret;
> > > > > >  }
> > > > > >  
> > > > > >  /**
> > > > > > @@ -801,6 +1008,8 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
> > > > > >  
> > > > > >  	r5_core = rproc->priv;
> > > > > >  
> > > > > > +	zynqmp_r5_remove_pm_domains(rproc);
> > > > > > +
> > > > > >  	for (i = 0; i < r5_core->tcm_bank_count; i++) {
> > > > > >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > > > > >  		if (zynqmp_pm_release_node(pm_domain_id))
> > > > > > -- 
> > > > > > 2.25.1
> > > > > > 
