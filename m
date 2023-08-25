Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83F07885D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240089AbjHYLeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240694AbjHYLdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:33:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288551FD7;
        Fri, 25 Aug 2023 04:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+erQsb1nw5OK+nYcOaIItpqHoqfNesOIkhpgC5LFfxNMZUVPWVUwirx6ZC9/7OizJTsg2TEytxgqot4PkQzHI81AUvUkYNbK2WvuJe7i3Wg83FukacrwjqEbqXCPbnvmGLHVbxn5yJEWqFMovJ/bgPez01Nuc1MgSe5NLwpO5Q05w4eYs/b/qIqQpBXmvJJFEdFfVeiHfYlOCKg8jxHcvwQbYj0hzXsWlUlaK6dq6BduArMGkftjYu86/4SJTCChabgBfqk/9wcAR9/o35NJxaBEeItIYWu660Q/1eOiDVKnJ3eNJ6s/Qw+QrWycRb7zwS56WvzXBomgQpXzUMHLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymp+iHYDIG1jZB+PKaiOWJZWXFca8nrsnUbgxibJT/Q=;
 b=PPKJIro/hbDNP+BEkXuFgSCL8K8G4yZNk9uhst3BmFZ7uoDRHBGUW7pUwT1WaDghRfJKMd9zUTfbO0U/6uInv8uqUb25v5UE9PJ2hNB0i/nn51x4U6syzbZVfVtV4rtN4q42ipmplM78qCJelDKz1yv16xJZR4YmJ1JQG4sh2dInmnB2S3EeOmMrNKaoFbXHh63wmkGOwSsdSPq4pDnTgReMzp3WQ3buEXYQuExMVkUnUZOfrSIDuoGBorrE/pTuSu2TTT9khfFzaRgLP/oP85Nk4/x0FDrumWpivSmmfwPc1OPC1BeM06tmU0NT4kPgLNTGfBqzAUN/1ZRUL1rE5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymp+iHYDIG1jZB+PKaiOWJZWXFca8nrsnUbgxibJT/Q=;
 b=HAUi0dRkMnYyi+Xf/hRAchslRsu1yHv2ehQOmlWKqAl4VnvU5ARORnL4HYIm+aSFzsvKKW3Zjx2MTeNI0ZlNkY+mvBP21CAkEhYx5AdOMTeAfP4QeeAzOODi+ZkVYtEOlBkY58uPLyMjFVjddWjB59ou9W9hKGqA8ZDkEWn5lfU5TPr5P29X8lyabu4LGdsUVyZEZtdvvKSPOqWHIV/0DYDyzwEBDncR8gFqnmssi1yMkP0+Orjzpkacadly2gr3+VHDsDx04sb+H2+Huz+a2wPKjKxNcFuQFtJq7NE36mCjVPdMLmwEbiQAaQ18oeEfPxIwDz6Xl6k+GM5DUzUDVg==
Received: from BY3PR05CA0050.namprd05.prod.outlook.com (2603:10b6:a03:39b::25)
 by CH0PR12MB5331.namprd12.prod.outlook.com (2603:10b6:610:d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Fri, 25 Aug
 2023 11:33:50 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::ef) by BY3PR05CA0050.outlook.office365.com
 (2603:10b6:a03:39b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Fri, 25 Aug 2023 11:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 11:33:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 25 Aug 2023
 04:33:34 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 25 Aug
 2023 04:33:30 -0700
Message-ID: <e8114572-3e4b-1b1c-40fa-1dbc44d4f098@nvidia.com>
Date:   Fri, 25 Aug 2023 17:03:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch] cpufreq: tegra194: remove opp table in exit hook
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230809153455.29056-1-sumitg@nvidia.com>
 <20230810053127.y4wmumlggkro7r66@vireshk-i7>
 <17b11665-874a-5b06-bc97-70f5202f238b@nvidia.com>
 <20230816033402.3abmugb5goypvllm@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20230816033402.3abmugb5goypvllm@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CH0PR12MB5331:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a61d9d7-d7b0-416d-712d-08dba55f270d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8ScwLKLp6eGH5rhemhsGG9q78QGGF2g5h90tiXK2jVsYD8MXobg/rgr0EAs/XVJZzsgzoeRDf3DdZtV0U7/+v1n4zXD+YmNTfbp0lMyo2rQPuIlIUJhVln5uko6qyOgk72T/8ZgPAac+TcvIXUtVVL/FbE7rrsK2nd3/V+v0ZWYhPWCJezga03fs3vIg6PvL9PXBNNp7aBcrmSAb/tQwZBdnALB0cGcEUIQNWoENnnEvVy6M707RvSXvazZ7SBtoqSpGwS8IDG6afaGwLQDQsvMRnpkKxl2fRzuY35wWwh7rrhzA5dVSCpdIrEE04gjjT2OKN2Bq2+p485iuLBifes9kQmC1z7t29ArwgCZsaF0Lvy6zm+aeqKrrodqT5xGCHjGNe1E5XTPhw3K4KSxjQwDXyNnAcQjrjBH2XJBv7oWmEUVnktRmg0Ec5MxyfVksic/F8DGAi8swYL+vf2+ZZV/9C0dgz6f7YtnghMQIuiYiUIIWPUC6KcrO2Es5h2KG05wSdI4KAuKAMZhNCjwM9iwNwGtHvSP5y1G7xcWCADUv37Iw1zuceQLZ8Ajl2CnUvWbUTnUIHo9ZT2PtWI7TyBnA/aHnJUUFvInh/eqGRIKzH8D3uFYt6pLF/gCnPn1sylu3MQ01CICUYoDkyCr2OWfKRyepBegCcI9CAbTPayEQ4eweIEL3MHli9PftdEKdVvfXoGB2u3+bKTAw4V0oOmHodfgGzow5pQBT75tGExagB8HFalwJqMna5JTxONJqfOCGQbbAI9CcL4rWOMAxSdu24Vy2jJ+XYPnvwOGkNYXGY0h/tHEX0w1BS6kq6Yh
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(186009)(82310400011)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(6666004)(83380400001)(336012)(426003)(82740400003)(356005)(7636003)(86362001)(31696002)(36860700001)(36756003)(47076005)(16526019)(40480700001)(26005)(2616005)(107886003)(316002)(2906002)(6916009)(54906003)(70586007)(16576012)(70206006)(41300700001)(31686004)(4326008)(8676002)(8936002)(5660300002)(478600001)(966005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 11:33:49.7788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a61d9d7-d7b0-416d-712d-08dba55f270d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5331
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> Add exit hook and remove OPP table when all the CPU's in a policy
>>>> are offlined. It will fix the below error messages when onlining
>>>> first CPU from a policy whose all CPU's were previously offlined.
>>>>
>>>>    debugfs: File 'cpu5' in directory 'opp' already present!
>>>>    debugfs: File 'cpu6' in directory 'opp' already present!
>>>>    debugfs: File 'cpu7' in directory 'opp' already present!
>>>>
>>>> Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>> ---
>>>>    drivers/cpufreq/tegra194-cpufreq.c | 13 +++++++++++++
>>>>    1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
>>>> index c90b30469165..66a9c23544db 100644
>>>> --- a/drivers/cpufreq/tegra194-cpufreq.c
>>>> +++ b/drivers/cpufreq/tegra194-cpufreq.c
>>>> @@ -454,6 +454,8 @@ static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
>>>>                 if (ret < 0)
>>>>                         return ret;
>>>>
>>>> +             dev_pm_opp_put(opp);
>>>> +
>>>>                 freq_table[j].driver_data = pos->driver_data;
>>>>                 freq_table[j].frequency = pos->frequency;
>>>>                 j++;
>>>> @@ -508,6 +510,16 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>>>>         return 0;
>>>>    }
>>>>
>>>> +static int tegra194_cpufreq_exit(struct cpufreq_policy *policy)
>>>> +{
>>>> +     struct device *cpu_dev = get_cpu_device(policy->cpu);
>>>> +
>>>> +     dev_pm_opp_remove_all_dynamic(cpu_dev);
>>>> +     dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>>    static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
>>>>                                        unsigned int index)
>>>>    {
>>>> @@ -535,6 +547,7 @@ static struct cpufreq_driver tegra194_cpufreq_driver = {
>>>>         .target_index = tegra194_cpufreq_set_target,
>>>>         .get = tegra194_get_speed,
>>>>         .init = tegra194_cpufreq_init,
>>>> +     .exit = tegra194_cpufreq_exit,
>>>>         .attr = cpufreq_generic_attr,
>>>>    };
>>>
>>> If it is only about hotplugging of the CPUs, then you can also do this I guess.
>>>
>>> commit 263abfe74b5f ("cpufreq: dt: Implement online/offline() callbacks")
> 
> You should do this as well, this makes hotplugging paths much faster. i.e. on
> top of this patch.
> 

Sent a separate patch to add online/offline callbacks.
   https://lore.kernel.org/lkml/20230825111920.8257-1-sumitg@nvidia.com/

Also, sent v2 of this patch with updated commit description.
   https://lore.kernel.org/lkml/20230825111617.8069-1-sumitg@nvidia.com/

Thank you,
Sumit Gupta

>>> But since your driver is capable of being built as a module, I suggest you try
>>> to build it as one and insert remove it multiple times. It must cause you some
>>> trouble as you don't implement an .exit() before this patch.
>>>
>>> Eventually, I think you need to do both, what this patch and 263abfe74b5f do.
>>> Just that the reasons need to be correct for both the changes.
>>>
>>> --
>>> viresh
>>
>> Hi Viresh,
>> I got the same message on inserting and removing the module multiple times
>> as you suggested. After applying this change, the message is not coming. So,
>> the current change is resolving both scenarios as __cpufreq_offline() calls
>> either exit() or offline().
>> I can update the commit message to mention both scenarios and keep change as
>> it is?
>>
>>    cpufreq_remove_dev
>>    |-__cpufreq_offline
>>    |--tegra194_cpufreq_exit
>>
>>    cpuhp_cpufreq_offline
>>    |-__cpufreq_offline
>>    |--tegra194_cpufreq_exit
> 
> --
> viresh
