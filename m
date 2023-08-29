Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAB178C0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjH2IqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbjH2Ipj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:45:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBF7AD;
        Tue, 29 Aug 2023 01:45:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yw7qqBX6X2/jEg2IxqNSkMbqrtdqp2PTR+sViBbEd83iB0dkKGTVDC1vhx/t0FmTRaNuMC73rjc3diqJp6KxQyOb3CO9Y11W5gPfX9Zu/Ri0EJuRSCsKF7X+jKkpJ5eikqKwwSOqEPRocGwg8KoCDX7jrUdzJCoK3nWySxepJmE5nj0m6vNwZJ1pPJS+La2fRV0S6T0nTv7YFF6ebRTFnCPx1uWvaosrvu/kuk+7Ri9KApusKNQG8WgMd+r6euuaH17IPsU3N6f7TAWZpRIXJlSU12XcOcjfzMig9Uu9gdLBZC+MPo3f5beFw7IZ3JCdrbLnz+KsDQeCqQvln5RtNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URZ8bNJiASlSCDa9y8rZagLfeDEsL/4JQEtMqV3kd4Y=;
 b=WEPv4jTOkN3sOHihpDfOngcYkiftJyncTjEo1LfKMQHPmddn0lYUZyez2aKPDWZabY2xP2iRXYseL3ruJqjvRLsWdzJiYj3NzHByGS75+FjmuCHFXYbuDz28p3RS0t5zvHY2S+TYcfLiDaBgSUMoCh9wcxBhOTD4tXHb8RUwQP481Bn+dOXarWlOUIkbwEQBFREJRLDDG/cjtQAlg8ZFiwDMLMtJoDiWkQrvY2f9R8/RzOZjKcfea89g+gi8cYZUuHuVgK7E5MYyjJEc4bYTqjsfEJLYTDmUmScCqiUowpmxz1FWhyQmQy4aPYuMBTr78d9pzsQCUG2pHJcNZEuq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URZ8bNJiASlSCDa9y8rZagLfeDEsL/4JQEtMqV3kd4Y=;
 b=kjq5PoSrwzbxYGgpx0SpeLwHDWYE/Yo4QGW0ptpMQkKz4BWI4f20zfCnwn7ruUDzEdnQmLuQ3jEgEPxszvCIcE+0jsxsDIF1zQ8x9AwqkqAfpZBpeHDx6DPQraMTRBqRC0ohCzLBumRq/k0i916bfPVk0YXZZXqUhHz6f3bASH7jGOubdkYHzMGEeG+B1oPlCfrirjat5IFi8JXbZAiMJKZSxKhvGo0PPWOzIy75/VZX2IRIV5vA/zM/O9ju60alzVgrbUz3HgDjLwjFCFOADCU8Cdr3Y85MKO0ldoJ94N3Cdm10FqsajaxmaQeVqsviM2WiZwW4TdaN0Fp+iv4WFA==
Received: from BYAPR21CA0011.namprd21.prod.outlook.com (2603:10b6:a03:114::21)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 08:45:33 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::ba) by BYAPR21CA0011.outlook.office365.com
 (2603:10b6:a03:114::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.8 via Frontend
 Transport; Tue, 29 Aug 2023 08:45:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 08:45:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 29 Aug 2023
 01:45:18 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 29 Aug
 2023 01:45:15 -0700
Message-ID: <b795f75a-83b1-2ebf-871d-50aa9ccd2178@nvidia.com>
Date:   Tue, 29 Aug 2023 14:15:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch] cpufreq: tegra194: fix warning due to missing opp_put
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bbasu@nvidia.com>
References: <20230828120959.24680-1-sumitg@nvidia.com>
 <20230829055930.csddryecm72ehz3o@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20230829055930.csddryecm72ehz3o@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|MN2PR12MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: dec34736-0d6e-4e41-f708-08dba86c4e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hbN9nZDFYP53geVwm4ZdITe01w192FfHPqGX50s54BDN9GfyjDwvqD7Fy7pAXeoc541tJ19tKDbDzwqQa8ijdgXb+FL3fip2O8UhiMwP5bOfFev0zu3/yteuIO9Wgi1CTTdCEiGgNT9iSppZnscznKmn8Ui3tN5AQDjgS+wwDgLDkfnCxxNZhau7OGP7lCxzB8FcuCMFs8IIIJ3tPUYEJQCj1Vq9KOOn49O1cAC8gfkeXT/sk+qWioQLyJKAmZipwX/21a7BTHxMm/Xixz4AVtCSgQCriFLj99QBkXV9jlDhiVSE1/EX8AYhj7jWwkllIAL8Kc0v9EHXSqA3Wy/xuVucjyB5V7fyW7BM1VUsA7ClsOLaqGZPAbtuWnXvDAyMYXOX9Bk88qXZw5vNXqWaXigybP5x8OY0Wlq9K1X9sLOpuQdfxyLWgirzt5BhT6Ei9uYG7IoPPdJ+SyA8d2EN1WDK6H1jPQlGXNPtCAJ9GshL3NLYcq91RA+x+9iI6gFfAWPkQ11V07mAnjHIJt7jd89E09N1rLfBcspIc8dSW+mGy4rHVp10P/Hm6vaWkTIw+fSxjbFx7excafMUVRG1wbFTB9C+M7d/2GIz3LHf9eCb1p0oRsRoofIpmzL5O82MH+0Bs3bf9+ZPPrOOqi5votlxdBBh1GOwTHyhv8GfNdFc0zELAR3gJ5n7QLRuvdOuxekazoCDtadOyLraMJPWL8WuwKQsrCxNy3PWCZh/mUjLpHiFFb/fdzUOuQCBnnwujmrk2cBKVoL23My50MiTfw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(82310400011)(1800799009)(451199024)(186009)(46966006)(36840700001)(40470700004)(40460700003)(316002)(6916009)(16576012)(41300700001)(4326008)(426003)(336012)(2906002)(83380400001)(31696002)(86362001)(47076005)(2616005)(107886003)(16526019)(36756003)(26005)(5660300002)(8676002)(40480700001)(36860700001)(8936002)(6666004)(356005)(7636003)(82740400003)(54906003)(53546011)(70206006)(70586007)(478600001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 08:45:32.1461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dec34736-0d6e-4e41-f708-08dba86c4e0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/08/23 11:29, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 28-08-23, 17:39, Sumit Gupta wrote:
>> Fix the warning due to missing dev_pm_opp_put() call and hence
>> wrong refcount value. This causes below warning message when
>> trying to remove the module.
>>
>>   Call trace:
>>    dev_pm_opp_put_opp_table+0x154/0x15c
>>    dev_pm_opp_remove_table+0x34/0xa0
>>    _dev_pm_opp_cpumask_remove_table+0x7c/0xbc
>>    dev_pm_opp_of_cpumask_remove_table+0x10/0x18
>>    tegra194_cpufreq_exit+0x24/0x34 [tegra194_cpufreq]
>>    cpufreq_remove_dev+0xa8/0xf8
>>    subsys_interface_unregister+0x90/0xe8
>>    cpufreq_unregister_driver+0x54/0x9c
>>    tegra194_cpufreq_remove+0x18/0x2c [tegra194_cpufreq]
>>    platform_remove+0x24/0x74
>>    device_remove+0x48/0x78
>>    device_release_driver_internal+0xc8/0x160
>>    driver_detach+0x4c/0x90
>>    bus_remove_driver+0x68/0xb8
>>    driver_unregister+0x2c/0x58
>>    platform_driver_unregister+0x10/0x18
>>    tegra194_ccplex_driver_exit+0x14/0x1e0 [tegra194_cpufreq]
>>    __arm64_sys_delete_module+0x184/0x270
>>
>> Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/tegra194-cpufreq.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
>> index 88ef5e57ccd0..f63f7a6c2034 100644
>> --- a/drivers/cpufreq/tegra194-cpufreq.c
>> +++ b/drivers/cpufreq/tegra194-cpufreq.c
>> @@ -454,6 +454,8 @@ static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
> 
> You need to put the OPP here, even if this fails.
> 

Sent v2 with the change. Thank you for pointing.

Regards,
Sumit Gupta

>>                if (ret < 0)
>>                        return ret;
>>
>> +             dev_pm_opp_put(opp);
>> +
>>                freq_table[j].driver_data = pos->driver_data;
>>                freq_table[j].frequency = pos->frequency;
>>                j++;
>> --
>> 2.17.1
> 
> --
> viresh
