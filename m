Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908F87B34B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjI2OR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjI2ORy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:17:54 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73FF1B1;
        Fri, 29 Sep 2023 07:17:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZ3PkLGbyHzkGDycyOpZ/tK7HAnR1PwiTCnlbFaj4decv2VJ58zHr8mXRTQ5DoXaH0cDG6PTO2oU3jpCg9bmW1fu62+PUhFIxdZPavyA+xXyqF43I9YhPVRNGzYSN2pbD3T46w1ztkwTxpQ/4pynWbwDp+RRmVel0KsENL3GKylZkBfhajPvi/YLZM+g0Dr8WAWPaXcMHhRLDFmYPeEe3fsHyXoBmSj5y33XFuffZpNqk6E91NQZo77GmeNMiwHzLAHDPhHybSUdwHVU/m31CZ/jxlTHE2nd0LFEbI5w833spPkO+7wz/H9Yo/MwWHrCzRvEEbYVLfCxHPPfSxQCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8LJr8Gh6MefqP3lE6LajajUVw7+JKpymgM42hTbJjE=;
 b=HHnYQbTT6eZjJmdcc8xU5aLV+RETnp0hI/CacCh9b05mgyE9O8x/NqvrUlMJlvmXB74cRWc3oeYpK0evUoygh79XBwS1j422AgqqGgd1aEQDRHoTBRQ/DE45VFx/LJPL2XV5afOnZ1zNAdVV3qassOOfB8aGy2LyKCLW+CHxvu/Vfc7H7F18CWpSGMTjarKnL3DNWqRiMwU00O+jrNjdsf26RyGtYDp0mP9iYaqD0wyaOkxrt09CuAYE8+pLTVpW8iCi4J3U0vvttVqJc+efpEYfZlGTaxZd4qRo8xOvUXHgJW47ZVQd8fcmta3y/BOQJ12Mdr2dBaigkWlXugqkfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8LJr8Gh6MefqP3lE6LajajUVw7+JKpymgM42hTbJjE=;
 b=ELxk4z6gkMG9eUMISRba0VzcgtLn9J08NTwAUrrsLh6PR+yXypqPJT0BD1SPok7hAJnaqJB9h9jkxigH1Wa0YGL85u09auOrWvwuDtzSI9MlCAm4e4UoIs4XNUJrN6BIYAMEiBiY1rHQwRJ+EbCqh8uaIz0J3dfGGsMvLPcKew/wQ/73SzcKHluz5oYmHC0jcmuPLgh6mlA6QLFvaoiWT9bUrpOO2gUHi5yVA7z6kl4vMPfleIRypdCCPHw0RRpwi5AmSoILiyUyWEW8eEoYbR/qWdMZX3ZwkOWNDTqlp9s4ZqCoK6HAXSHZj8hei+E8zKO3f1jih82wINK/F1UDDA==
Received: from CYXPR02CA0088.namprd02.prod.outlook.com (2603:10b6:930:ce::11)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Fri, 29 Sep
 2023 14:17:48 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::1d) by CYXPR02CA0088.outlook.office365.com
 (2603:10b6:930:ce::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26 via Frontend
 Transport; Fri, 29 Sep 2023 14:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.19 via Frontend Transport; Fri, 29 Sep 2023 14:17:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 29 Sep
 2023 07:17:41 -0700
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 29 Sep
 2023 07:17:38 -0700
Message-ID: <8cb33679-5056-8983-9334-3ab3d170568a@nvidia.com>
Date:   Fri, 29 Sep 2023 19:47:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v2 1/2] cpufreq: tegra194: save CPU data to avoid repeated
 SMP calls
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <amiettinen@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20230901164113.29139-1-sumitg@nvidia.com>
 <20230901164113.29139-2-sumitg@nvidia.com>
 <20230928070545.b7l367qi2q4rynji@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20230928070545.b7l367qi2q4rynji@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 295bcc0c-6032-4560-b356-08dbc0f6dbf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pjZuFSP9JZxl68Dsi/mntVHQITeRnOc6axX2tBwioAJYSzbEORgzmIwZw4sa3T98pc69+Kb5V5UbDJVbkq77iQJ5G+BcAvbYJ5090SOduCZdK3+KZiNBo16q2Ey+spN24FySBo53QySZTbVv+3tJuHFaCL7CQGZxYSlcEt9yr/C80TU4xbf6XarwMbQQXHkFKbwUP6xUImJBklqjPvPClzNxg0F315BuLiDJd0bgXYm5VzVeNBWya83YlsN4a+lK0HBfl8IkzGXPa75moKIeVHYcfhGEOJtuO6/laGlmrsQscdspEEjFoa1cEVG+v0ZalH9b3ws6nr1nXayh6wC66clZwv/CJ49VPk/zI8Y6LiOJrUEc/tewe42oVs39tqNN2qcX/r4yaw6dgc1PzTjVGYN8pOqSnimKd0fKnWh6ABBZIIsEdIcL7cxELNgZVBAeVtE5yu009cPf/hVUI0gtqPhpSK/blRnhkpXoPRhV8OFC3w7I4kcG5kPaqacwlduPezxtUO/9EK3EIDRB61l1zBCqc7GH+/EbotYL6yL5BNbQMSqTLUknzJ0BTaWed9mOrUE1Dk+RbJDJOArBuFsDHLI4IvOvFw/NRbLqpAIIPgh/02xq81H0lxAtC4Zr4u9sWOUFGjdInMYz2vlskrcMx7ANhIBu5hML504a3PK6lIaw+UDXGWwKZqP8VR24FsLwSzuxqduzm46DLEFnkkM5R17oe6vyyOg6XYt571IfD9TkMKqgf7E8rwJreELZmjTrxskFwL8dqiE9A2VRdEGfA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(36756003)(478600001)(107886003)(356005)(36860700001)(2906002)(7636003)(5660300002)(82740400003)(16526019)(4326008)(2616005)(336012)(26005)(8676002)(31686004)(8936002)(53546011)(83380400001)(41300700001)(40460700003)(70586007)(426003)(6666004)(16576012)(54906003)(316002)(6916009)(70206006)(40480700001)(86362001)(31696002)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 14:17:48.6516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 295bcc0c-6032-4560-b356-08dbc0f6dbf6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/09/23 12:35, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 01-09-23, 22:11, Sumit Gupta wrote:
>> @@ -131,19 +132,10 @@ static int tegra234_get_cpu_ndiv(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv)
>>   static void tegra234_set_cpu_ndiv(struct cpufreq_policy *policy, u64 ndiv)
>>   {
> 
>> +     for_each_cpu_and(cpu, policy->cpus, cpu_online_mask)
> 
> (Yes this is existing code, but ..) you don't need to perform AND with
> cpu_online_mask as policy->cpus should only contain currently online CPUs.
> 
> Please check if you ever see it differently.
> 

I think this was kept to be safe.
Should I removed the AND in v3 or send separate patch?

>> +     data->cpu_data = devm_kcalloc(&pdev->dev, data->soc->num_clusters *
>> +                                   data->soc->maxcpus_per_cluster,
>> +                                   sizeof(struct tegra_cpu_data), GFP_KERNEL);
> 
> This should be: sizeof(*data->cpu_data) instead. Didn't checkpatch complain
> about it ?
> 
> --
> viresh

Checkpatch didn't highlight it.
Will do the change in v3.

Thank you,
Sumit Gupta
