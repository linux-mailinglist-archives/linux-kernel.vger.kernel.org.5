Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEAC7FA67C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjK0QdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbjK0QdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:33:10 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A73E4;
        Mon, 27 Nov 2023 08:33:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=id+NE0jQmHv8NZGdSkveZLRI5XH6f44jEilhdYQGwaNIYDISTpnfkBvZd8oY37XZqPJTdLhenB9j1D84IKniKXMFlM+0IpIGMMqF0kpZR61iPo4AWtCgC4uCG5NDMS3YJP8CJsyHctldv+uj+dv+DwPMN9ydW7RyndZGrjihqNO+/+NWOb4JKUkpW/AuZt+gtsTr0XbykZzyCWyLq0bTUHBsf29LojwOtKgruWnmIAJ3F3LdhoCiuSD+mabyhLfz/eKYDhqeyl8ozeZ7hkntUYcxF8NzAzgrroiwS21WuyacxcuMLpQqSy/m15232R9QmtjL6LukUxRoM2EElIJK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDd2qMtKs42w5Vrilo4QKqD7j2sE2mk+t9HixQDbxfs=;
 b=keUJbczKdjln1stY9ASOuP2V0Z9UkvHRWZ1wmP124P74UuqFzE6coQWuH7EZBt9xikTySEp7im/VWFmC3uO0OnLLpnTHUYwPw23nySaSuuMBEfs1rSFJ4jIsf1qf9k2ytk4FjkHnsPVSUL+w4aBsZo0QER2nbdShFAIASqM9mUqpDgYj2QDSzKocdVoSmpERSCdNE2v9mgqy9AUEsSzIXtajSlM/6DxufX+L30PMd5qW6QskNGYec/347nPnLmGcmqrMy02ucsemQIroV2MGncoKMveLHLC2UznMdKr+Y7TJdAxo0fWygL7XJVsETYNQUtz6R1YyKA642BUVbC1JxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDd2qMtKs42w5Vrilo4QKqD7j2sE2mk+t9HixQDbxfs=;
 b=mOtsFcM/4Q4swhtpnG9wbjrcOFsviUmL4geESONrS2TFjfRHyus5TyWyEgKa3llptFJ+V9GlxmgBThy9OV6lW7DxF18zC2Xbvi85ivsNQgIewTwgeQ8H0z3XpyG2Gv6nXe7htxQv9/6PYsBWR5xf3Eo/bjq5hirOCEvlxqlXTvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 16:33:09 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 16:33:09 +0000
Message-ID: <a75b22c1-66e3-4fce-ae64-de79e73f3cfa@amd.com>
Date:   Mon, 27 Nov 2023 10:33:05 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v7 3/4] remoteproc: zynqmp: add pm domains support
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, ben.levinsky@amd.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231117174238.1876655-1-tanmay.shah@amd.com>
 <20231117174238.1876655-4-tanmay.shah@amd.com> <ZV02P3bHEhPLQHBo@p14s>
 <93487d3c-c324-4b9b-8b25-0b4ea52237b4@amd.com> <ZV+V6V2sEWgsqngk@p14s>
Content-Language: en-US
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <ZV+V6V2sEWgsqngk@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::24) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a034497-d00b-414f-3438-08dbef668a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GwkBVLlmFh4Mey2NUrop+BXE+WBx+VfSohYAsMy2WMNsyj4ljcboZy4HBCLGhbGmcy7ykoVnO0bapE8ZN0DAi5/MD8LAPpQCpuSXQ6fAugeoBgANlJjMG/4KyAnPFjrCyyb5F/08P5zdE2NzpCZvhuWaCDfXzq8M9WJtuUMWWWm986ONKCAFJoHgtHRcVOxQILDXioyH666PlcTI1gqvnwOfv1UMI+OXDATzqERwj1q9G5LM+1D/esgaq9v1b6kH0K8HCzkUYl27JvMdz50Xr/y1OqtnEGH33SP28OIHJFYsN2ClgmH6Yk+W5FZZ7K5vjgor8QcTNU9eVxFbL80xC8Svk6U9X+rS6LWXd5NmUu1DXzUrewQ/Sd5BW8JhoDF1/iDAe5sehzwts65lqObSg9RbOQflcEYQTMj+ps9HPeFQKoW6crCnpFQm9fsUb2LRJvGJ5Hs8+vY9G+2YDSdTqVpLzznqJWVGDbXYfbRfJotWG8pSp0ijDgmusxstt0KSgN9gxk+N6xRkt2O8od0Lai2LTbUg+NcfBZMoQ99ssgEAVm3wKVwor/SL2fFub7+FXQvrhwKmMu1UgXv7t4i5tyLduSH9Ol911JLMj8qb7bvLNCU+17sCNTAHeNEB+3x3TNORLYswfkQIipo5VVn1yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(5660300002)(2906002)(30864003)(6666004)(31696002)(86362001)(6506007)(53546011)(478600001)(2616005)(26005)(6512007)(316002)(66946007)(66556008)(66476007)(6916009)(8676002)(4326008)(36756003)(8936002)(6486002)(38100700002)(83380400001)(44832011)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm4xMlFUMlpYc2FMbDBYZG5nWXlTRnpZdHc2bXl3R0VzZitnZllFL1ZHL3VS?=
 =?utf-8?B?SUoyaCtMblE3WlM2M2RlN3BGRG5Oaklid3J3QTVOV1V1eFVCOXhQcXViZmNn?=
 =?utf-8?B?dzZRM1ZlSkVZM28xdERHU0F0dmY5OWhFZ3lWWkhkVlpKcXEvcU90YjAwSDFP?=
 =?utf-8?B?NE1Wa3VqV3ZkeVZFZnppSCsvV3BVTmc3cmRXTFB5dlY2cG1GUzZ6dG53S1JS?=
 =?utf-8?B?Tnlva3g0NnQ3cE4yRTdhZjV2RWpmc0syVGhkUTRMT3JsTUU1U2tWeWFqQWxS?=
 =?utf-8?B?eHl4VmptSDNwYnE4c1FZRlRzcnVpUGxOSFd1K1ZVY245enlSUGVGZWk3MUd4?=
 =?utf-8?B?bVliTEVnVGs4WGEyUFVMU21xL3IyVWdqMDF3cnkvYUl6WTQxUlBwUlQyMld2?=
 =?utf-8?B?Y09oWG81VlJpdDgzeUwzcnJscDh6RW1WbGZhZUxtcFozM3I4WURRK3FVQWJ3?=
 =?utf-8?B?c3pncGM4S3FLcFVjTlV6bnFFV3dGcFFHRTh3TGpFRi9leERUUVpyU1FJNWtl?=
 =?utf-8?B?bSt3a2VlMGtNMWdMYXFpa2RWenUvYnh6VXdrd0dnRzYrb1Y1NlBhc1BHaCt2?=
 =?utf-8?B?aGFGYzBxK1FZQ1NBdHV5TTBneFczQ0R4eE4yVis3eWQ3T1l0ZHY3R1BSeFdJ?=
 =?utf-8?B?Ymw5VTJuMzE2QmxnQSt5SGtmQ3ovRGJyTEpIc1ZTbXJTRlBXZFlpbFhVQXBv?=
 =?utf-8?B?eDBZRzB0WVBUTjU0a3dFSit1b3NtWm5IMmRVS3FqOTFxeDR6RHVwYWNDRDg2?=
 =?utf-8?B?VDdFYnpNNTVaWldjcUZ3RXYwY1l2S3pxNjRmWjcvL240enl2cHhQOU10UnQv?=
 =?utf-8?B?Kzl1Z0EwRlFHVlozb3Jqb1YyUXVQVjhSdjN1ZFh5T0EvVkhIRzM4NXNLdDB3?=
 =?utf-8?B?bzAzczg1WmQ1eVVaNkJtSXYzWG9ia3FHRWdic1JUTENKOWhTbmZnN0xlcjFB?=
 =?utf-8?B?bU13N2FFQVVsZit2S3ZzOUlPdnM3OEJVMHltZi9mQzZEQngxOUdLTjl1a3cx?=
 =?utf-8?B?ekdZTmhacWZSNStvdjB3bEs0b25GRnhGOFpxcGNQSUNVaEg3MXViaWNKZnIx?=
 =?utf-8?B?Tlh4K0V6b0VrYWJHakprM21PemZGa2h2Zy9aNC9ndjNYY2ZXN0xSaUYxUU5W?=
 =?utf-8?B?ZmpXV1hwWTcycHdOdjZMWUpLTTQ2anRzTnJRSGRpUitZZlY2d0ROelFqNXQ1?=
 =?utf-8?B?dXhXWkxrOEtncDhJVFk4aituUUpMWVhzWlROT21sQVBXYklreStiUHNvK3NZ?=
 =?utf-8?B?K0ZUNEt1bzJFbFlMdGNCTlh2OUl5Z2lwcWNIVHF4U0xGRzl2Uzg2QkJEa2k3?=
 =?utf-8?B?SUdqSVVPUEZOYmlNSWhOaFFXNitzWVllVGpyNHhFUi9lWkMvYVdIMzZmM21M?=
 =?utf-8?B?QkhDU3hMSDZ3Ky85MVI2cFN0ekI5UlBQYU5OMCs0WkJrSDZ0UXlUYVcyWTZh?=
 =?utf-8?B?c25YbzdscnpIODd5TWxCSFJ5cGdkc253SHd3ZEdDZEt4YlFKbEFGc1M5cjZE?=
 =?utf-8?B?OERnbnFoRGJ6c2FXOVJWa1kxcUF2aXNiL3N5VUt2WExFdjkxSWJJbkF4WTU1?=
 =?utf-8?B?cG5mVXBzZkkrdzNiNFhCTElsOFI3UTl1MzR6NnBwZVpvSzIvOURBcHpvM2c4?=
 =?utf-8?B?V1V6Wnp6YW9KWitLMU1GWmhyOTl4ak9NdHJFL1RsbHNJVERBYjZWTmw5ZW5F?=
 =?utf-8?B?Szk4eUV3Q1Z3WVJ1UHdTK1ZzMmh4b1RjeU04QlUzekh2Zm9uTUcxaVFGaUQz?=
 =?utf-8?B?R1Y5YURWb0pxcVFzekdSWDBHaE5vTktXakNoVEJWRWN3ZXBDVUUyRi9wSXdj?=
 =?utf-8?B?dUd1TEQvbDVtdjJIRnFCeTczejd5OFBqc1NtYVEvZzhjYU9mdlprNU5VYyt2?=
 =?utf-8?B?WUp1YythU0dWS1hJTjJvbzhQbjJFTk4rRVErbHk2SHdTWGxCa1psQzkraWNZ?=
 =?utf-8?B?YzBHZW5JdmdRVUZkeXh1ejg0UUhhcWdYM3FUWEVyT01TdGZWYnBTNUxERnNn?=
 =?utf-8?B?TVhlUFBTV1hIMzhKcXpJeU15ZnVxb0tXYzRSTVBYbUQzRjBvdlFtQko0eDNm?=
 =?utf-8?B?UStIdXVKd3JzaXR0eGNvMUFqeU12bjdXVFRCUVNMZU9SWHpFQ2pUMmJLcGJx?=
 =?utf-8?Q?0Z424bDIfXTwIdpLlgwmTA0at?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a034497-d00b-414f-3438-08dbef668a46
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 16:33:09.0660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMpfvteoYo1DXRmdZ1TPo1r81peEuWYmQ3tqAkDGf4w1LIZ34iqoPRJmY7uiwdUZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/23/23 12:11 PM, Mathieu Poirier wrote:
> On Wed, Nov 22, 2023 at 03:00:36PM -0600, Tanmay Shah wrote:
> > Hi Mathieu,
> > 
> > Please find my comments below.
> > 
> > On 11/21/23 4:59 PM, Mathieu Poirier wrote:
> > > Hi,
> > >
> > > On Fri, Nov 17, 2023 at 09:42:37AM -0800, Tanmay Shah wrote:
> > > > Use TCM pm domains extracted from device-tree
> > > > to power on/off TCM using general pm domain framework.
> > > > 
> > > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > > ---
> > > > 
> > > > Changes in v7:
> > > >   - %s/pm_dev1/pm_dev_core0/r
> > > >   - %s/pm_dev_link1/pm_dev_core0_link/r
> > > >   - %s/pm_dev2/pm_dev_core1/r
> > > >   - %s/pm_dev_link2/pm_dev_core1_link/r
> > > >   - remove pm_domain_id check to move next patch
> > > >   - add comment about how 1st entry in pm domain list is used
> > > >   - fix loop when jump to fail_add_pm_domains loop
> > > > 
> > > >  drivers/remoteproc/xlnx_r5_remoteproc.c | 215 +++++++++++++++++++++++-
> > > >  1 file changed, 212 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > index 4395edea9a64..22bccc5075a0 100644
> > > > --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > @@ -16,6 +16,7 @@
> > > >  #include <linux/of_reserved_mem.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/remoteproc.h>
> > > > +#include <linux/pm_domain.h>
> > > >  
> > > >  #include "remoteproc_internal.h"
> > > >  
> > > > @@ -102,6 +103,12 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> > > >   * @rproc: rproc handle
> > > >   * @pm_domain_id: RPU CPU power domain id
> > > >   * @ipi: pointer to mailbox information
> > > > + * @num_pm_dev: number of tcm pm domain devices for this core
> > > > + * @pm_dev_core0: pm domain virtual devices for power domain framework
> > > > + * @pm_dev_core0_link: pm domain device links after registration
> > > > + * @pm_dev_core1: used only in lockstep mode. second core's pm domain virtual devices
> > > > + * @pm_dev_core1_link: used only in lockstep mode. second core's pm device links after
> > > > + * registration
> > > >   */
> > > >  struct zynqmp_r5_core {
> > > >  	struct device *dev;
> > > > @@ -111,6 +118,11 @@ struct zynqmp_r5_core {
> > > >  	struct rproc *rproc;
> > > >  	u32 pm_domain_id;
> > > >  	struct mbox_info *ipi;
> > > > +	int num_pm_dev;
> > > > +	struct device **pm_dev_core0;
> > > > +	struct device_link **pm_dev_core0_link;
> > > > +	struct device **pm_dev_core1;
> > > > +	struct device_link **pm_dev_core1_link;
> > > >  };
> > > >  
> > > >  /**
> > > > @@ -651,7 +663,8 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > > >  					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > > >  					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > > >  		if (ret < 0) {
> > > > -			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> > > > +			dev_err(dev, "failed to turn on TCM 0x%x",
> > > > +				pm_domain_id);
> > >
> > > Spurious change, you should have caught that.
> > 
> > Ack, need to observe changes more closely before sending them.
> > 
> > >
> > > >  			goto release_tcm_lockstep;
> > > >  		}
> > > >  
> > > > @@ -758,6 +771,189 @@ static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +static void zynqmp_r5_remove_pm_domains(struct rproc *rproc)
> > > > +{
> > > > +	struct zynqmp_r5_core *r5_core = rproc->priv;
> > > > +	struct device *dev = r5_core->dev;
> > > > +	struct zynqmp_r5_cluster *cluster;
> > > > +	int i;
> > > > +
> > > > +	cluster = platform_get_drvdata(to_platform_device(dev->parent));
> > > > +
> > > > +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> > > > +		device_link_del(r5_core->pm_dev_core0_link[i]);
> > > > +		dev_pm_domain_detach(r5_core->pm_dev_core0[i], false);
> > > > +	}
> > > > +
> > > > +	kfree(r5_core->pm_dev_core0);
> > > > +	r5_core->pm_dev_core0 = NULL;
> > > > +	kfree(r5_core->pm_dev_core0_link);
> > > > +	r5_core->pm_dev_core0_link = NULL;
> > > > +
> > > > +	if (cluster->mode == SPLIT_MODE) {
> > > > +		r5_core->num_pm_dev = 0;
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> > > > +		device_link_del(r5_core->pm_dev_core1_link[i]);
> > > > +		dev_pm_domain_detach(r5_core->pm_dev_core1[i], false);
> > > > +	}
> > > > +
> > > > +	kfree(r5_core->pm_dev_core1);
> > > > +	r5_core->pm_dev_core1 = NULL;
> > > > +	kfree(r5_core->pm_dev_core1_link);
> > > > +	r5_core->pm_dev_core1_link = NULL;
> > > > +	r5_core->num_pm_dev = 0;
> > > > +}
> > > > +
> > > > +static int zynqmp_r5_add_pm_domains(struct rproc *rproc)
> > > > +{
> > > > +	struct zynqmp_r5_core *r5_core = rproc->priv;
> > > > +	struct device *dev = r5_core->dev, *dev2;
> > > > +	struct zynqmp_r5_cluster *cluster;
> > > > +	struct platform_device *pdev;
> > > > +	struct device_node *np;
> > > > +	int i, j, num_pm_dev, ret;
> > > > +
> > > > +	cluster = dev_get_drvdata(dev->parent);
> > > > +
> > > > +	/* get number of power-domains */
> > > > +	num_pm_dev = of_count_phandle_with_args(r5_core->np, "power-domains",
> > > > +						"#power-domain-cells");
> > > > +
> > > > +	if (num_pm_dev <= 0)
> > > > +		return -EINVAL;
> > > > +
> > > > +	r5_core->pm_dev_core0 = kcalloc(num_pm_dev,
> > > > +					sizeof(struct device *),
> > > > +					GFP_KERNEL);
> > > > +	if (!r5_core->pm_dev_core0)
> > > > +		ret = -ENOMEM;
> > > > +
> > > > +	r5_core->pm_dev_core0_link = kcalloc(num_pm_dev,
> > > > +					     sizeof(struct device_link *),
> > > > +					     GFP_KERNEL);
> > > > +	if (!r5_core->pm_dev_core0_link) {
> > > > +		kfree(r5_core->pm_dev_core0);
> > > > +		r5_core->pm_dev_core0 = NULL;
> > > > +		return -ENOMEM;
> > > > +	}
> > > > +
> > > > +	r5_core->num_pm_dev = num_pm_dev;
> > > > +
> > > > +	/*
> > > > +	 * start from 2nd entry in power-domains property list as
> > > > +	 * for zynqmp we only add TCM power domains and not core's power domain.
> > > > +	 * 1st entry is used to configure r5 operation mode.
> > >
> > > You are still not saying _where_ ->pm_dev_core0[0] gets added.
> > 
> > So, pm_dev_core0[0] isn't really need to be added for zynqmp platform, as firmware starts it with call,
> > 
> > zynqmp_pm_request_wake during rproc_start callback. I will document this in next
> >
>
> That is exactly what I am looking for.  That way people don't have to go through
> the entire driver trying to figure out what is happening with pm_dev_core[0].
>
> I'm also not sure about the power-up order.  Logically the TCMs should be
> powered up before the R5 in order to put code in them.  The R5s are powered in
> zynqmp_r5_rproc_start() but I am unclear as to where in the boot sequence the
> TCMs are powered - can you expand on that?


Sure. Following is call sequece

zynqmp_r5_rproc_prepare

zynqmp_r5_add_pm_domains -> Here TCM is powered on when device_link_add is called via zynqmp-pm-domains.c driver.

. . .

zynqmp_r5_rproc_start -> load firmware and Starts RPU

So what you mentioned is correct, TCM is being powerd-on before we load firmware and start RPU.


>
> > revision. For new platforms pm_dev_core0[0] will be added in future.
>
> Now I'm really confused - what do you mean by "pm_dev_core0[0] will be added in
> future"?


ZynqMP platform has platform management firmware running on microblaze.

This firmware design does not expect R5 pm domains to be requested explicitly.

This means, during zynqmp_r5_rproc_start when "zynqmp_pm_request_wake" is called,

firmware powers on R5. So, pm_dev_core[0] is not really used for ZynqMP.

However, this design was changed for new platforms i.e. "versal" and onwards.

Firmware of new platform expects pm domains to be requested explicitly for R5 cores before

waking them up.

That means, pm_dev_core[0] for R5 cores on new platform (Versal) needs to be used same as TCM.

Then, we should wake it up on r5_core.

To summarize:

For zynqmp only following call needed to start R5:

zynqmp_pm_request_wake

For "versal" and onwards we need two calls to start R5:

"device_link_add" and zynqmp_pm_request_wake

So, in future pm_core_dev[0] will be used.


> > 
> > I hope this meets expectations.
> > 
> > 
> > >
> > > > +	 */
> > > > +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> > > > +		r5_core->pm_dev_core0[i] = dev_pm_domain_attach_by_id(dev, i);
> > > > +		if (IS_ERR_OR_NULL(r5_core->pm_dev_core0[i])) {
> > >
> > > Here IS_ERR_OR_NULL() is used while two if conditions for NULL and an error
> > > code are used in the loop for the lockstep mode.  Please pick one heuristic and
> > > stick with it.  I have no preference on which one.
> > 
> > Ok, I think IS_ERR_OR_NULL is more cleaner, I will address it in next revision.
> > 
> > 
> > >
> > > > +			dev_dbg(dev, "failed to attach pm domain %d, ret=%ld\n", i,
> > > > +				PTR_ERR(r5_core->pm_dev_core0[i]));
> > > > +			ret = -EINVAL;
> > > > +			goto fail_add_pm_domains;
> > > > +		}
> > > > +		r5_core->pm_dev_core0_link[i] = device_link_add(dev,
> > > > +								r5_core->pm_dev_core0[i],
> > > > +								DL_FLAG_STATELESS |
> > > > +								DL_FLAG_RPM_ACTIVE |
> > > > +								DL_FLAG_PM_RUNTIME);
> > > > +		if (!r5_core->pm_dev_core0_link[i]) {
> > > > +			dev_pm_domain_detach(r5_core->pm_dev_core0[i], true);
> > > > +			r5_core->pm_dev_core0[i] = NULL;
> > > > +			ret = -EINVAL;
> > > > +			goto fail_add_pm_domains;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	if (cluster->mode == SPLIT_MODE)
> > > > +		return 0;
> > > > +
> > > > +	r5_core->pm_dev_core1 = kcalloc(num_pm_dev,
> > > > +					sizeof(struct device *),
> > > > +					GFP_KERNEL);
> > > > +	if (!r5_core->pm_dev_core1) {
> > > > +		ret = -ENOMEM;
> > > > +		goto fail_add_pm_domains;
> > > > +	}
> > > > +
> > > > +	r5_core->pm_dev_core1_link = kcalloc(num_pm_dev,
> > > > +					     sizeof(struct device_link *),
> > > > +					     GFP_KERNEL);
> > > > +	if (!r5_core->pm_dev_core1_link) {
> > > > +		kfree(r5_core->pm_dev_core1);
> > > > +		r5_core->pm_dev_core1 = NULL;
> > > > +		ret = -ENOMEM;
> > > > +		goto fail_add_pm_domains;
> > > > +	}
> > > > +
> > > > +	/* get second core's device to detach its power-domains */
> > > > +	np = of_get_next_child(cluster->dev->of_node, of_node_get(dev->of_node));
> > > > +
> > > > +	pdev = of_find_device_by_node(np);
> > > > +	if (!pdev) {
> > > > +		dev_err(cluster->dev, "core1 platform device not available\n");
> > > > +		kfree(r5_core->pm_dev_core1);
> > > > +		kfree(r5_core->pm_dev_core1_link);
> > > > +		r5_core->pm_dev_core1 = NULL;
> > > > +		r5_core->pm_dev_core1_link = NULL;
> > > > +		ret = -EINVAL;
> > > > +		goto fail_add_pm_domains;
> > > > +	}
> > > > +
> > > > +	dev2 = &pdev->dev;
> > > > +
> > > > +	/* for zynqmp we only add TCM power domains and not core's power domain */
> > > > +	for (j = 1; j < r5_core->num_pm_dev; j++) {
> > > > +		r5_core->pm_dev_core1[j] = dev_pm_domain_attach_by_id(dev2, j);
> > > > +		if (!r5_core->pm_dev_core1[j]) {
> > > > +			dev_dbg(dev, "can't attach to pm domain %d\n", j);
> > > > +			ret = -EINVAL;
> > > > +			goto fail_add_pm_domains_lockstep;
> > > > +		} else if (IS_ERR(r5_core->pm_dev_core1[j])) {
> > > > +			dev_dbg(dev, "can't attach to pm domain %d\n", j);
> > > > +			ret = PTR_ERR(r5_core->pm_dev_core1[j]);
> > > > +			goto fail_add_pm_domains_lockstep;
> > > > +		}
> > > > +
> > > > +		r5_core->pm_dev_core1_link[j] = device_link_add(dev,
> > > > +								r5_core->pm_dev_core1[j],
> > > > +								DL_FLAG_STATELESS |
> > > > +								DL_FLAG_RPM_ACTIVE |
> > > > +								DL_FLAG_PM_RUNTIME);
> > > > +		if (!r5_core->pm_dev_core1_link[j]) {
> > > > +			dev_pm_domain_detach(r5_core->pm_dev_core1[j], true);
> > > > +			r5_core->pm_dev_core1[j] = NULL;
> > > > +			ret = -ENODEV;
> > > > +			goto fail_add_pm_domains_lockstep;
> > > > +		}
> > > > +	}
> > > > +
> > > > +fail_add_pm_domains_lockstep:
> > > > +	while (--j >= 0) {
> > > > +		device_link_del(r5_core->pm_dev_core1_link[j]);
> > > > +		dev_pm_domain_detach(r5_core->pm_dev_core1[j], true);
> > > > +	}
> > > > +	kfree(r5_core->pm_dev_core1);
> > > > +	r5_core->pm_dev_core1 = NULL;
> > > > +	kfree(r5_core->pm_dev_core1_link);
> > > > +	r5_core->pm_dev_core1_link = NULL;
> > > > +
> > > > +fail_add_pm_domains:
> > > > +	while (--i >= 0) {
> > > > +		device_link_del(r5_core->pm_dev_core0_link[i]);
> > > > +		dev_pm_domain_detach(r5_core->pm_dev_core0[i], true);
> > > > +	}
> > > > +	kfree(r5_core->pm_dev_core0);
> > > > +	r5_core->pm_dev_core0 = NULL;
> > > > +	kfree(r5_core->pm_dev_core0_link);
> > > > +	r5_core->pm_dev_core0_link = NULL;
> > > > +
> > >
> > > The error path is much cleaner and readable now.
> > >
> > > I will continue tomorrow.
> > >
> > > Mathieu
> > >
> > > > +	return ret;
> > > > +}
> > > > +
> > > >  /**
> > > >   * zynqmp_r5_rproc_prepare()
> > > >   * adds carveouts for TCM bank and reserved memory regions
> > > > @@ -770,19 +966,30 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
> > > >  {
> > > >  	int ret;
> > > >  
> > > > +	ret = zynqmp_r5_add_pm_domains(rproc);
> > > > +	if (ret) {
> > > > +		dev_err(&rproc->dev, "failed to add pm domains\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > >  	ret = add_tcm_banks(rproc);
> > > >  	if (ret) {
> > > >  		dev_err(&rproc->dev, "failed to get TCM banks, err %d\n", ret);
> > > > -		return ret;
> > > > +		goto fail_prepare;
> > > >  	}
> > > >  
> > > >  	ret = add_mem_regions_carveout(rproc);
> > > >  	if (ret) {
> > > >  		dev_err(&rproc->dev, "failed to get reserve mem regions %d\n", ret);
> > > > -		return ret;
> > > > +		goto fail_prepare;
> > > >  	}
> > > >  
> > > >  	return 0;
> > > > +
> > > > +fail_prepare:
> > > > +	zynqmp_r5_remove_pm_domains(rproc);
> > > > +
> > > > +	return ret;
> > > >  }
> > > >  
> > > >  /**
> > > > @@ -801,6 +1008,8 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
> > > >  
> > > >  	r5_core = rproc->priv;
> > > >  
> > > > +	zynqmp_r5_remove_pm_domains(rproc);
> > > > +
> > > >  	for (i = 0; i < r5_core->tcm_bank_count; i++) {
> > > >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > > >  		if (zynqmp_pm_release_node(pm_domain_id))
> > > > -- 
> > > > 2.25.1
> > > > 
