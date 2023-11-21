Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C867C7F25A7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjKUGPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjKUGP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:15:28 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984F0E7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:15:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqCMM7CBOwmSXVTHx2KM+dao0wRRK0U2HCkUtSBzdMXebYO7mxqQE+V7gl0xO8CdfZ6gH+j1nXvLD+73TrZes44lAcbALJ1iP67mYGcyW0kwCk1x66Dbdht437kaSOyLts5RGOvcQug7aMkF5Y4dK9E5553QebdJGnep/Z6M8/El3tmo8K4S60u65uJLLa9Ewk8silKdk5cpBQOYJGt5JQy5PCU4YCuFyE5bIOaWc17Wxxosy9uOGT/oEpJbHCvdvF8fDGTtJIz0KsTfq25aA9gZWzO3nl6VUje9qSq0LHxi3fRDbrWgRihldyntxNgoje6VVMNDlr0bFC/HnJqhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEJ/0jhiLlAj5NKKVmbg6DnSqk+YY1VVE/Zsj54CHRQ=;
 b=X0z7HW2Xe3xvcKBZ6aNWXsgJCuPw8ySykO50uk3++RbdRdamo66kPYetUM4UiaCHgCYyA69vThx1NCinfHmuDdQqD1S4nFvGCTwFB0xNfTMgseCJEoWuwqKc3cwTMxsec3vNxwTjBbu+DLYHciKGox/FxFcMLEHXKSedIJAoM8dA/t+0D0BMzIgIBCIlzQuzm7NdGmTJIcbVlLR9q1VL3IVD0WHLGVDL2G/cH8aGE4sYoyfBX5e1vCugfvyW8WO7DHHqpz0RQiVdvVK1uUVPWGzloOzC+ayQ+/a8pBQzAzQfLxXlhtOu1GeAG0dxD5pdB0BrRFmLt12PnkaWesukPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEJ/0jhiLlAj5NKKVmbg6DnSqk+YY1VVE/Zsj54CHRQ=;
 b=iYNrkBcP8/CTHXqEElvV9RmmrK8IjC/TuLCAl6rCXQguAtPelg2NaC6uVcY4ZQNnPZlK6gjJt9YzpoerBcjabcEPPO+Tt3CAKZf6FV0VBZjWqEStN0Wj3OUtXJWSZPYPMgGF03pMRJFHXH7MJUvAXe/UiYRlIrrQLMspWHK6Vzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Tue, 21 Nov
 2023 06:15:20 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 06:15:20 +0000
Message-ID: <2c8daf55-22f8-f79e-ae02-6fc8d505ade2@amd.com>
Date:   Tue, 21 Nov 2023 11:45:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu/amd: Set variable amd_dirty_ops to static
Content-Language: en-US
To:     Kunwu Chan <chentao@kylinos.cn>, joro@8bytes.org,
        suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com
Cc:     kunwu.chan@hotmail.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231120095342.1102999-1-chentao@kylinos.cn>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231120095342.1102999-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0224.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::19) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH0PR12MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 4187f003-e97e-404b-5b95-08dbea593d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2BGyR64IftisJJu+TGbF7QsvHT5wLsWTA0u9bYRNyAQ8ATjJ5rwp0/RWmAa8tmf8te8UXU4nfr8rRYRu9hIOhlsHCEffyol6dTZ4nL9pbIrsPMU79DhXnX6OxH1cTY+uZ1hQEUcBCabp2pk75EfL4T4EgvAUH0GFMv6nuRJ/wO2YwdB1ExRgVFn6hJzH7m6jFlvdLlTbcYtFT7wEwQHTBD0eO07S+kz8iXY53wf/svPThPY6TNv+EkDs6hYpbsnGRNYOdAK1++uEBAYdXSuY1cJXiK2aFpwi1sJQUaiGLoMrgH0PSUOC7zDlgAsKiLUE4YByWaVmsN4Ewe5KNSsq/2Uvg3pUTTpfjbr1A/MjDSccjPn2PPo7hhtiOcu93q4OJdF1BMHFFMF9IFkHvgWgH/ryXynCuRCkawWIVku2fxDWDqfWc3eeUsPPVvaUY1ab88GJ6PvHnKYwOk3vefQkljz/FWW+ahQ0P6PWSEanmO2f4wpJjHIbRluI8ZW0ENRToVQ0o+lnPc2Px8hoX7vh9PaJ9t5DqW3j83UxzKEtCoeIBIyLS+kXQ1oLuhAeEsGfL+X11fUFSZ0qrk+/UDVLQd3HZzPNYZI5VZz2n455scB1jxQSx+O8ujAcM2d8X5sv35ttchambUfw2jXbpqg1nHBJ1MIMVVrpmJDddqYc6rM09rL4VKeIDkIQmd0PgG31bt+CMykdS0EgDAtvutOcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(230173577357003)(230922051799003)(230273577357003)(186009)(1800799012)(64100799003)(451199024)(31696002)(31686004)(86362001)(6486002)(6666004)(6506007)(66946007)(66556008)(66476007)(316002)(36756003)(2616005)(53546011)(6512007)(26005)(41300700001)(83380400001)(478600001)(44832011)(2906002)(5660300002)(4326008)(38100700002)(8676002)(8936002)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXhXZndpT3NLMnB5eVMzU3J3eVRCeGpuZjg4M1BNeGtVeDFORUxBZ0ZQR0Rn?=
 =?utf-8?B?OCs3eUhFSDBMZkVycHo3dnN1ellVRjljeGNVcEhCbGJ3RGk2QUtQYlU5VXFF?=
 =?utf-8?B?cGk5UHFSd1dVTTU2OGovTncxTFBvVEZDUVVwck5ZQ0Q0RHZlMlpPY0hnYmI5?=
 =?utf-8?B?OW1DVkVEVUM5S29IemNuckREakY3azd3Vkt3Y3U5R3Evb3l6amMrL3B6OUpu?=
 =?utf-8?B?ODBoYzZVdHdjOFR2QXByYnI3Zzc0RHVvMUlpRWtHcEdOUm8yQzlzT1Jsc285?=
 =?utf-8?B?dDVoRE9CcVFYNjhRYUEvMnJpWGVzOHpZSGozVXovUTBwanJ4a1lCWDJyck43?=
 =?utf-8?B?eG8xaitpNk55UE1IWGhPZ1VXMlZ4d0VWN1BvRHMxbDM1Tk1TRW8yTUlobGJP?=
 =?utf-8?B?MW93UnBQRUhvNEo0N1RVbFVOWm9oNzRDYUhXMFJhUnRHOWc3aFk0NzhPUThw?=
 =?utf-8?B?RmJyOTlSWjdpdFN1aXNkOUtQK0lDbHBlOUs3SW51Ti8wVGdnQzhKMXRXVnl5?=
 =?utf-8?B?Vmp3V1NQZVZBY3Z0N0R4bVViZHdNaGZJVno4Q2dtSFJTa3RYdEEva21aeGRL?=
 =?utf-8?B?OUtOWnJjNytlODRlNVIyRXFyNFQwbXVoTm9QRVRsa0pkdkpVSmdNMWRtbkto?=
 =?utf-8?B?LzdOeXFLVWxhb25RQytwZFh3MVFtdERnOEFSVHBFT2R6OWFWZWtRNXcyR1Fh?=
 =?utf-8?B?djlHUEU2Ykh0Rnk1YWdQVGtYUTdneFFFSkVUcmd0cUNvSmI0Yjk3Njd2QVVk?=
 =?utf-8?B?Z1Q4cFVRdU5PWWhTYnE3YWMwa2ZLcmF3OVZhL1h0VjMzVk8yTHk3a0N5OUhF?=
 =?utf-8?B?czdEbm5vbU9BbWtaVk0xS3grQ1NvdVB4SlFSNWtZYXZWREFWOHBwS21xSW0x?=
 =?utf-8?B?ak9oSituQndKenhXNGhtNDRRSU1QdzZ2WHppQXNMcXRlTEttN2pWeGo1TnJq?=
 =?utf-8?B?RGczcm9kU3hZc250eUtoOG9PU2dUNmtEVExCZTFxZUl3S3R6OHBvcGJiQ3Zz?=
 =?utf-8?B?Zm1Gc0gxb0dBSGNJdVBTODlQRHJSdTNmZkxHVndaTkVxL1pQYzlWYy84RFc4?=
 =?utf-8?B?UTkwNTZZSW50ejZrWDA0bmdQdUN5QmZSNExEaTBPSkZsaGNqRHVGdXA2MVVq?=
 =?utf-8?B?STdPdmx1eFp0N2JucXRjcHY4RnZ1N1JrRHNSc1ZKRUxtbTlKS3VkU29hWS9J?=
 =?utf-8?B?OEZIZHlQaEVKSkE0bmhRUzZaTHpPaEpMZUdmQzA4b1ZjTkVLUFhtaHZvOVZL?=
 =?utf-8?B?UC80QWpjMWdGbzEzek5VMXZDbzRxL1VmZG5QZzdlaUVVb2pyQTd1SEFlcmRm?=
 =?utf-8?B?MkN2czE2ek1vOWQzUlM1bTBPeFdjTjBNSjUyN3JzWGRrMEl0K0ljWkVqNGZK?=
 =?utf-8?B?NmJCTTVueXF4SlJXNy9yY1lIOWpqWG43SFR4Rm1GNzRJK3RVcGpXTWJqOU9R?=
 =?utf-8?B?TExwUXkveGh3VkNBL3hIT0ptRlN2b3NvMEREb3FLb1pzRUFlMDZXM2Fxc0I3?=
 =?utf-8?B?TFFLL0pWYWJiOG15ZWJudDlVWmM3TzJHQk14K3gzVXlVdDZLVXRuRWJIck9P?=
 =?utf-8?B?V0ZIOGs4UGYwUlNrMFppanRmcmVqN0R2eWFETlhLc09kNy9IeklZUk0ydzVs?=
 =?utf-8?B?TDJUcytaeXI3TWNodTQ0bkQrZG1lMVdSb2x1WUZQNzFEZVdGWDRPYU5xL3Zr?=
 =?utf-8?B?dUpiRllJTHhOdUxSVFRVQjJhQU0ybTlyS3JTd3FZOHZPMEw3WjNudlhhVmZF?=
 =?utf-8?B?TTg4N3JsM291YjdrbzJsUGpTWW5Wa2lMblB1cEtuUGUwMkFkNURYNHBLQnlp?=
 =?utf-8?B?eVNUYmV0UGlxNFk4Y285cWlrd0l0Si9Hb1puUWJvNXBnQ3lHUkhyODY0aHRI?=
 =?utf-8?B?NEYrUlNrZzVzNUVhVUp6YXYxZ2trUTN0TFhkVytmUHBOUW56YkRNd1h5ZHUx?=
 =?utf-8?B?K3RtQngzNk9MVUFBNlZaaXlEbnZDTGxmcFFIamdCS0orNHJqYmJ3ZzNwSE8y?=
 =?utf-8?B?L0ZaQnB6eW1NVVY3dTYxcjh6bFRSNW9QN002NEVhYW05RjJaclF4OU1yS001?=
 =?utf-8?B?STl2cG1MT0M1dndiS1FYSm9qVmZWRzhtZWNHN3Fzc0NLRUc4RGk2QVB6aXdN?=
 =?utf-8?Q?fpYbTZQgWGS156Tqm0Rw6U6Ev?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4187f003-e97e-404b-5b95-08dbea593d04
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 06:15:20.4534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wh61lM0dnE/v1oyyWHZuTyy9aF9u1lXHIaE7Pb2FNd7U18uSCOlWamltguPrk5q4hTugGWTCNafYXYxOXV9jFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/2023 3:23 PM, Kunwu Chan wrote:
> Fix the followng warning:
> drivers/iommu/amd/iommu.c:67:30: warning: symbol
>  'amd_dirty_ops' was not declared. Should it be static?
> 
> This variable is only used in its defining file, so it should be static.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Thanks for the fix. Looks good to me.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> ---
>  drivers/iommu/amd/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index fcc987f5d4ed..9f7064360828 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -64,7 +64,7 @@ LIST_HEAD(hpet_map);
>  LIST_HEAD(acpihid_map);
>  
>  const struct iommu_ops amd_iommu_ops;
> -const struct iommu_dirty_ops amd_dirty_ops;
> +static const struct iommu_dirty_ops amd_dirty_ops;
>  
>  int amd_iommu_max_glx_val = -1;
>  
> @@ -2635,7 +2635,7 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
>  	return true;
>  }
>  
> -const struct iommu_dirty_ops amd_dirty_ops = {
> +static const struct iommu_dirty_ops amd_dirty_ops = {
>  	.set_dirty_tracking = amd_iommu_set_dirty_tracking,
>  	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
>  };

