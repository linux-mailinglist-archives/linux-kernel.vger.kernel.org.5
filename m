Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A827BF25C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 07:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442133AbjJJFnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 01:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377040AbjJJFnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:43:43 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C9D9E;
        Mon,  9 Oct 2023 22:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQVvIa3/jVwX3s58SFxF72eNzmRpPQ/kwumbcb949XrWcKIIp00GvrE8UIn/1Mvpvatg9FCP79W6r1IN8h3HSU6EtW/KC/Eaa7S02ruKQl6sIO2JqYU9RYr7m+NS+wCsDkL5W57frfrz4skvOtkrRTZgoIPl5rIYW7XOOdDXsuXzsCVviRgPpxuJRGke/dnfruqFi8IZ2onIJbEbX+1Xw2CgGRR29N2Ai7my7hlI1xHv3uH4WFL8bq6b3ugVK9+hUkGBU4F1pdSCgpY4zpjJUQPZ0el38hRv7E6UDfwnzeMyqX/LW8kFiMhhuQd9OiTx/oKu4Kqzpl1bRex47ZUo6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEWESLgEh3beEjM42BubV2L0SE0Ya/BjFcUjAt1TUTM=;
 b=KThjFB2ifzA0w5bGmQXHyrRw3xAPMbiiQDNYk4cxAQxAfc1SynaGF59lnXmjZaVZBRsxfMmh7gyP42QpRyRLRKoNnai7lGahNK6wHtZtRHxWIyGhTq4+zHeD8BFAP5SzF9NcBXEdm7UhDdcqYXoSMZtHdIbDlwO7m/hlniIW3LBknuybnlD0V+rLUN+4pf+6ZOR2kTcRPuCRe1gB/tt1O6p+SB52IPxzSGcbN0TM2XC0UpIdTDIlFijxbF2PKpMiqwhwZajZEOpqXS6gXDUGosPZTtUkhzRiG+jQa8hr8H2pH6BZPE9CZ6Z7azmmg/IOHIsITvDzdoYj9PQ+aNX3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEWESLgEh3beEjM42BubV2L0SE0Ya/BjFcUjAt1TUTM=;
 b=tLM3XIJMFbwL9MZBxTBQeyOi9tD5Ir8W5EC9H296EWM3AJHKVVxTuI73/8ErvK/aotMIWbuVhWgykB7BX/KgUXdifIjG/NdIcrAILqHr9JbYrS5jEq8AoNX3QaTDJ+XkN5JQjkhu9G9PPALmNbp5kgMouQAe9qqCZf2/1jpyYVpUyFMdmieFuH9zjXoWzOwxh7TwqQnrbbAFuB8FaiwnCdQ/I81BdscEXhcDCtdAirCSGSzgmUZNc75NAyF/tg9wCpgj/T78L/KdLtiKbXCTC85fZESB2hZlBm9vFnoE6GHGqFH6fm5IW4l24vWuEzPeehVUiojA8HK5DV7wh2ZaEg==
Received: from CH0PR04CA0064.namprd04.prod.outlook.com (2603:10b6:610:74::9)
 by PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Tue, 10 Oct
 2023 05:43:39 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:610:74:cafe::a4) by CH0PR04CA0064.outlook.office365.com
 (2603:10b6:610:74::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 05:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 05:43:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 22:43:25 -0700
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 22:43:22 -0700
Message-ID: <d4b62c0e-f07c-93a2-6d81-63373d7fff87@nvidia.com>
Date:   Tue, 10 Oct 2023 11:13:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v3 0/2] Improvements to the Tegra CPUFREQ driver
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <amiettinen@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20231004140537.1954-1-sumitg@nvidia.com>
 <72e9f769-9cbb-274e-e99d-10c71f84bbe0@nvidia.com>
 <20231010053710.hrq3ifktt7j4n4ln@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20231010053710.hrq3ifktt7j4n4ln@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|PH7PR12MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d0393a-f116-42e3-ac35-08dbc953dae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GleiD9qk0aVIdx9Z97ZFn77k3W/dtDOO6YOmqxid6kGLlckLXgPaTKBXNillMnCluw+y4TvSThDPUVNXmVL35Poh14+RhdcJw2NxAPzkgHCXsiaRkE/fu5F/NWrNscoXBkqEyUjG4FdPtLkLF+IA/16s/yfE9SzQss/lFqHo66KBPT1h2dm45ioteVo1iNntfyr/5jQpg46FtQOGOKualnlCWc1KVj/cFxaCW1oxA1DUd58f0BZWr3lR5u/7gyPAG/JLuHH++u6ovNOaIY6rtNZc4sp1kIDjZsRogOK/WYLkjNq2wqBfra3eH/BV0Fs3kJZPT3xCfwPNKXYTxtl12nHZkuGOWPtvs34jRqhu2jpRxl7O2DDSBxci2qSQfXG8Lx3xwxoeHzYq712WBKjX+YRTtqClNizlgEV2aVApdcRNaelqWHIuOo3qZaPb4Tfze3hhYGpREos0M8cxEy4AchG5P1qKFVePDon9xqAWYfgitZ0Iib7z1jkbGHT2R6vqByxxYV3NMldhE4OufGLkWzqE0//BNONIkOHmTOOzPWMZtKAHvhlULcJKy4Fc8fHb+vR0eT5W/V/0APjJwaBwZ+0Gd+YU3p+5emKTjz7cP/xkURThXAEwieGrEvdD2splFvPiTW+3TUeoIgNcsJ/qDtZldSV9N0xo7CVpmMWZTTD5dQfuplaWN4QjNvAsMi+FJ02nT2uCkFytA3uZ6WZX1poI5djRPldZTJ98VtSetk2C6S4/n1IVS+bJCbXdeEdMgVfAHvUooukcn4UjQmuzDTnYtbdrXm3v0CfHcANUEHW8LgqgqG8iDfswEGB10dOLz/MMmlOXUU7FzPkO2/OsO5jJGoUSaJdVlk2nZgoVYmw=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(82310400011)(1800799009)(64100799003)(186009)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(53546011)(107886003)(2616005)(478600001)(966005)(6666004)(336012)(47076005)(426003)(26005)(16526019)(83380400001)(2906002)(5660300002)(16576012)(54906003)(70586007)(70206006)(4326008)(8676002)(8936002)(6916009)(41300700001)(316002)(356005)(82740400003)(7636003)(36860700001)(36756003)(86362001)(40480700001)(31696002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 05:43:39.3826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d0393a-f116-42e3-ac35-08dbc953dae6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5928
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/23 11:07, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 09-10-23, 17:06, Sumit Gupta wrote:
>>
>>
>> On 04/10/23 19:35, Sumit Gupta wrote:
>>> This patch set adds below improvements to the Tegra194 CPUFREQ driver.
>>> They are applicable to all the Tegra SoC's supported by the driver.
>>>
>>> 1) Patch 1: Avoid making SMP call on every frequency request to reduce
>>>      the time for frequency set and get calls.
>>>
>>> 2) Patch 2: Use reference clock count based loop instead of udelay()
>>>      to improve the accuracy of re-generated CPU frequency.
>>>
>>> The patches are not related but have minor conflict. So, need to be
>>> applied in order of patch numbers. If 'Patch 2' is to be applied first
>>> then will rebase that and send separately.
>>>
>>> ---
>>> v1[2] -> v3:
>>> - Patch 1: used sizeof(*data->cpu_data) in devm_kcalloc().
>>>
>>> v1[1] -> v2:
>>> - Patch 1: added new patch.
>>> - Patch 2: changed subject and patch order.
>>>
>>> Sumit Gupta (2):
>>>     cpufreq: tegra194: save CPU data to avoid repeated SMP calls
>>>     cpufreq: tegra194: use refclk delta based loop instead of udelay
>>>
>>>    drivers/cpufreq/tegra194-cpufreq.c | 151 ++++++++++++++++++++---------
>>>    1 file changed, 106 insertions(+), 45 deletions(-)
>>>
>>> [2] https://lore.kernel.org/lkml/20230901164113.29139-1-sumitg@nvidia.com/
>>> [1] https://lore.kernel.org/lkml/20230901152046.25662-1-sumitg@nvidia.com/
>>>
>>
>> Hi Viresh,
>>
>> If there is no further comment.
>> Can we please still apply these patches for 6.7 ?
> 
> Applied. Thanks.
> 
> FWIW, you should have rebased the other commit (which removes cpu
> online mask) over this one. I had to fix the commit manually now.
> 
> --
> viresh

Sorry, my bad.
Thank you for your help.

Best Regards,
Sumit Gupta
