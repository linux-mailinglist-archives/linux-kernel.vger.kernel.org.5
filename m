Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6B57CA124
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjJPICG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPICC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:02:02 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F507A1;
        Mon, 16 Oct 2023 01:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgkQm0RaxTJgwp1mNfCrYk/oIIGMTGeooBdW6eMbYRQlEgdVgUURHjO3FG5PG/K7U5HjdPFXbZ6g6c0xON/AiXIwYeMQe7kUsRHMsp1gsICG+LYpdsZcmhGSKnOHmR7TGVBXGrvwUsnHLW72ziX4jKiF8XNlq6ce/R9BVNFzSxPTWaSkHABrRekyvcHW4cIk6992+C1RSY7MY60wUwgBqSN6uFn1eWzLAB35WcgnyNJr9h1e1y8be/YOM1hKFzFsMtt6e+62rpkzvjZFesxKO2PwKFzcPJ13vdBg9maduR1aERHQ6pyRAxNLYyPWruP8FpquHXqn2VGhUFOUMIj/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrIEm0tO4RSRsP68w/JV71LXE2EQ3k/m8DhfZ7uycMQ=;
 b=ODIotOrH1/qilRsPorf5Xv5zQcleJAYhKVKwEE90MitqUiE4PO+Qi6WklGVNY6JRrlhgj7bnN08O92bxtQ9ABf184NoS4j0de7CmLPrn/Rt2N6rs+fhkt4xuVkBYrjFYfDX6hk96TRXnO1xytutZSO1KOIPSfgREXm6LNcmscVlreTsHERmIvfJ3PhbzbJX44BDKo8Oh06iLV3F23SZJlxS+4wfzmuN7khLDRk7faEzloTtzJenmO4xJJUKqGOK0ZoPjAHP9dq7g/Bkv6TYjoF1WzQd5WSMWx0TCMkDLzTjAZC0QUUS0xhs3uqVunSe2c5htzRr+eSMDl0m1PxIg9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrIEm0tO4RSRsP68w/JV71LXE2EQ3k/m8DhfZ7uycMQ=;
 b=O0ju5b9Di2m6xYFAebjsF/tynVO1OogyK/KjSXWH6wkyD0IHlY20xzr0GnYlKZG4Fy0PS0wRc6MInS0ZkBhZ0NgPfIWN79Hs7tGcnwOWLxPugtVIbWQae+iKe8qjjxZG1XmfMk5MpE2aWq0WFgZY+z8uNy9ypZE4izBLtPqPpcA=
Received: from CY5PR15CA0052.namprd15.prod.outlook.com (2603:10b6:930:1b::9)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 08:01:55 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:1b:cafe::d9) by CY5PR15CA0052.outlook.office365.com
 (2603:10b6:930:1b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Mon, 16 Oct 2023 08:01:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 08:01:54 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 03:01:52 -0500
Message-ID: <1da65bde-c64b-46cf-be49-3a687d6ffef1@amd.com>
Date:   Mon, 16 Oct 2023 10:01:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to
 yaml
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Praveen Teja Kundanala" <praveen.teja.kundanala@amd.com>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20231013101450.573-1-praveen.teja.kundanala@amd.com>
 <20231013101450.573-3-praveen.teja.kundanala@amd.com>
 <02d3fa42-75a3-4f4f-ade6-204c8146d694@linaro.org>
 <91d61e1a-abb0-4b31-aa22-aff72d582ebe@amd.com>
 <b72e6fe0-2ba4-47ac-80a5-94ee4101ad2b@linaro.org>
 <013e44c6-45f5-44c1-94b3-536955fae78f@amd.com>
 <b5a2d37b-168c-4cc9-9dc0-68f131cdf3ad@linaro.org>
 <5a3b6efe-5884-4727-a1e1-e9b8b0658523@amd.com>
 <209334cd-c922-4bd6-b116-83297c7e8b79@linaro.org>
 <edbd1434-c05b-461f-96e5-f57775dcf915@amd.com>
 <a990fead-b7af-48e6-ab28-3a69ce07d248@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <a990fead-b7af-48e6-ab28-3a69ce07d248@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: a1eec6a2-2817-48ba-0862-08dbce1e29ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vcG2nTOvd9glY9FH4c/HEx93dZraSKeCyr45BmKrC/KSHZ9hwm/ulcz1ewCa8uKaO23s0se/CPs27DrFO32hmG1XG1LMG4BFYjvy3OJ4R7cci94kDV13wjT5yub2w4HGuwXhqw7JX/CJxdZz2BzcB9wiLdePlYptMoC82lUOxAzwnnv5Q+BmmYmjhEaPlfSIY4bD2z/a4nT0jRr2JPDy0x4mJl3dm6PVOd0TxzFXW2prCmBt8+6DdL/pH1z/+ScUDBnPfM+c4fF9fPECfE9Si0RhX7+8NrHCTXT8ic6n2EE0HyDgGLzQrQY8s7ExtvZzsqQ+uM7YFWc4bc4dFMTc1F/VlSSsxQYsAJfz+tZqAIwwrXzvOrijc8j3jmlMr8lIyEUq65ypnTRtOARB5XwFZRS5ToEAOPlt1qNDal6noo09XsqS/QJJaQinpWDuUoNfqNg9/xfJAWoc32R9HfXqSQubiXfK9zsAORat4zsO0KOn+T8gUNtHyiY0T2iWplVYI4CumVvE7HLdoPJ3xwmw8Rj4OHpCExmSE5JByaASsM6c1R8tai6GRmlgWULiznDuji5qqF9zeOB/9TCLnj8tRIWQRxPhB2pbvo6ywanMnFEv5T/5ikK3ODjMvSMJCdGJU8tm9vwodXMYn3tVs0mSnrshx8f/6jvaLyvb9HLJ2EbcyNh/XnNgkgk7CAlpMtkwfWALgSxhgZIgr/GBFimv7rJ0PtZbSjuQ3lWjt3wzw6kpJ2ixdJfUm6O4rTjB6lY7acqdDVBiFFlnERhKFe3eBSo2Zst4N6FBu9jObnBLI+I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(31686004)(40480700001)(40460700003)(53546011)(478600001)(966005)(47076005)(36860700001)(31696002)(86362001)(36756003)(81166007)(356005)(82740400003)(2906002)(83380400001)(16526019)(426003)(336012)(26005)(2616005)(70586007)(70206006)(5660300002)(41300700001)(16576012)(110136005)(8936002)(8676002)(4326008)(44832011)(316002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 08:01:54.5641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1eec6a2-2817-48ba-0862-08dbce1e29ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/23 15:10, Krzysztof Kozlowski wrote:
> On 13/10/2023 15:06, Michal Simek wrote:
>>
>>
>> On 10/13/23 14:54, Krzysztof Kozlowski wrote:
>>> On 13/10/2023 14:08, Michal Simek wrote:
>>>>
>>>>
>>>> On 10/13/23 13:58, Krzysztof Kozlowski wrote:
>>>>> On 13/10/2023 13:51, Michal Simek wrote:
>>>>>>
>>>>>>
>>>>>> On 10/13/23 13:46, Krzysztof Kozlowski wrote:
>>>>>>> On 13/10/2023 13:22, Michal Simek wrote:
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +required:
>>>>>>>>>> +  - compatible
>>>>>>>>>
>>>>>>>>> required: block goes after patternProperties: block
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +patternProperties:
>>>>>>>>>> +  "^soc_revision@0$":
>>>>>>>>>
>>>>>>>>> Why do you define individual memory cells? Is this part of a binding?
>>>>>>>>> IOW, OS/Linux requires this?
>>>>>>>>
>>>>>>>> nvmem has in kernel interface where you can reference to nodes. nvmem_cell_get()
>>>>>>>> calls. It means you should be able to describe internal layout that's why names
>>>>>>>> are used. And address in name is there because of reg property is used to
>>>>>>>> describe base offset and size.
>>>>>>>
>>>>>>> That's not really what I am asking. Why internal layout of memory must
>>>>>>> be part of the bindings?
>>>>>>
>>>>>> It doesn't need to be but offsets are hardcoded inside the driver itself and
>>>>>> they can't be different.
>>>>>
>>>>> Hm, where? I opened drivers/nvmem/zynqmp_nvmem.c and I do not see any
>>>>> hard-coded offsets.
>>>>
>>>> Current driver supports only soc revision from offset 0.
>>>> But if you look at 5/5 you need to define offsets where information is present.
>>>> +#define SOC_VERSION_OFFSET	0x0
>>>> +#define EFUSE_START_OFFSET	0xC
>>>> +#define EFUSE_END_OFFSET	0xFC
>>>> +#define EFUSE_PUF_START_OFFSET	0x100
>>>> +#define EFUSE_PUF_MID_OFFSET	0x140
>>>> +#define EFUSE_PUF_END_OFFSET	0x17F
>>>
>>> There is nothing like this in existing driver, so the argument that "I
>>> am adding this to the binding during conversion because driver needs it"
>>> is not true. Conversion is only a conversion.
>>
>> Conversion in 2/5 is adding only soc revision which is already there. It is
>> starting from 0 and world size is 1. And 0 is not listed because that's start
>> all the time.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvmem/zynqmp_nvmem.c?h=v6.6-rc5#n39
> 
> This defines the nvmem config, not what should be where.
> 
>>
>> And soc revision was also listed in origin binding example.
> 
> Example is not a binding. Please drop enforcement of some specific nodes
> from the binding.

ok. Fine.
Praveen: Please drop that descriptions about sub nodes.

Thanks,
Michal
