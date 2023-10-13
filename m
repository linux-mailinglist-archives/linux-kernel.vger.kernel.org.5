Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3252A7C8561
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjJMMIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjJMMIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:08:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E17BD;
        Fri, 13 Oct 2023 05:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHdq8RENcl/7jkowHEIi1z0y1Ct0BJ2YE9HebWeTAD2uUM1UcsplWwpTQwidEwHgM2jcZ7Ynqb6y1D3xH+1cfKJ+OthQo0zrBTMRkbTB9dUHOBeM+CFaGfWMzQkGqcZnBO06GV86B+ZK6UWw4V1pcSF5FzD/VkOGXHouKJoOQpipS1Uu8ZvdYP/ZstVREnTtqwrjm46w2QK9NnWZ07qth9aW7b0acwfG/w0CgE1Iv7EPb1b3ePPSGYokXoPCNmaLJ44bBIzx58ZcAg21XScwDfIyu8lywQfONtPrwvaoAlqbZYHNX7/igVoXIEnBsDQ7YsShUt6NB6kEUAsCgprfbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuWsr2NtjgiT5fzK4vw4xHSqtk7t3GoIoAWySjWRPm0=;
 b=kUSBgTBIqvqVWxhbqy09Y8ptggvShE5eBc8im7J0lDk8CQlMIxs/FAm+18IqbMsEH3LZaB3NE3qCw1sLQ6EbQJlI55jI1zioGR4lQjdzjMLBNYNpgTb9u/YOOISSFd5Mlz5eVRR8z+To7e8m8Huh9Nwoho6jDaTEJtrro7oMRWJF4cGJjbuOn3GSgRe7b8+tUAkH3XozD4B7GfTjDL84Jf2kHaDwimj9Jjm4P2UDQC3j7BtVBlLtHyzRoliHV+s77x6AuLYHPT3Tjpasj0h+VXJNwpCWz/Q1QDDVasRQmkMqjqxckwT/rUNMGwGX+Rwzz/3goO6Q9jVPLX4Bu1+Znw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuWsr2NtjgiT5fzK4vw4xHSqtk7t3GoIoAWySjWRPm0=;
 b=eBT6NzL2fLP5piJ8xpGgacXCx/PR3JkwBLCuS8drN9owHWWahgq1JT9Hx58kwBA1CgjaVMA/D07y9sJMXxxw9bN2qAdnrRD22Zlv1y0tEtGi9mLmLFzSKteMyMBjcdzj6OG9UIyHuZFLJvCMLjn2bUNBGrvxDl/uRvLEymwd5hk=
Received: from MN2PR04CA0012.namprd04.prod.outlook.com (2603:10b6:208:d4::25)
 by CH3PR12MB9314.namprd12.prod.outlook.com (2603:10b6:610:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 12:08:47 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::e2) by MN2PR04CA0012.outlook.office365.com
 (2603:10b6:208:d4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Fri, 13 Oct 2023 12:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 12:08:47 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 07:08:44 -0500
Message-ID: <5a3b6efe-5884-4727-a1e1-e9b8b0658523@amd.com>
Date:   Fri, 13 Oct 2023 14:08:42 +0200
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
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <b5a2d37b-168c-4cc9-9dc0-68f131cdf3ad@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|CH3PR12MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: ecde8736-7183-4204-9fea-08dbcbe5275f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4Ukh3eZNpRaeaKsBeOA845ikjaHTBwFhNCEWsret2R+vY6UcCu6tAedWQHhYCXQm3hq9VLt4/Cdw5Ypry2PPbNJGb70HCetbA/F3cGOnBl/8w6XrkFT1+mRycPyKZQWagRAiuE80sKz8hm15Sasc8uTNGSgBvRYF7Mhtud+QuUwjGXeABIwMgJSb3lxqgucAvI1anPVnGJUJLlZDwE0sEf4aqlHVd+ytsZj2pvh6JCNW9yJfD7Jl6iyZyKKZI3cd32+BsrKNLETZ7jib/M8yDTgRToTqqyXAJtHLojio0hDIggkcJ8f+LxJ4wFwYr9/LTU8Oa24oAHwI3UaxAK27CjKcEhi8GOomJL63JeBbmdOkdDmAR0J48WkDXJvNbosBB24TfE1lqt6W4QXe+hjK5vH4uHLtj63FfVc0HiVjovb3ogcWwQrOeLYXTgtcm1jDIHvffovxnSVLKRdiWBRF+3OWQ9iMWPqPhVCHQ6mC1kD0POwPMbr94VMujdQha0aTnHN/9BksBj8gnhycBbldReosIbFWyuqEd9PB1dwiTYJOUy9iogLqrO2ozomskDURDVsx/jNIDGlB/ldzQVdqhmSsqJr5OKS4oVJGzhwcEZ7XlCVxonApD8GKHWbsUqaUoJkBG7pdMgZRyDs1wXANqkvcG26+fTICgmRxiTyWHj3y0tBcSX9zk4utpc4oLHc05iqQl4SHhcZZ14NrrQ8JRo7QTMfU5Me9VdKV88cFdW2y42yCDwUH3GgGGGFF7/cNgXAkvvlpUzmNXAekWURUJK8i8UDdR0Tr276dz+0VvadXC/UL6KcjSNLD3FoGtBG
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(53546011)(316002)(16576012)(70586007)(2616005)(70206006)(110136005)(478600001)(31686004)(16526019)(26005)(8676002)(40480700001)(2906002)(8936002)(426003)(336012)(4326008)(36756003)(36860700001)(356005)(81166007)(83380400001)(41300700001)(5660300002)(44832011)(31696002)(86362001)(40460700003)(82740400003)(47076005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 12:08:47.1115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecde8736-7183-4204-9fea-08dbcbe5275f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9314
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/23 13:58, Krzysztof Kozlowski wrote:
> On 13/10/2023 13:51, Michal Simek wrote:
>>
>>
>> On 10/13/23 13:46, Krzysztof Kozlowski wrote:
>>> On 13/10/2023 13:22, Michal Simek wrote:
>>>>>
>>>>>> +
>>>>>> +required:
>>>>>> +  - compatible
>>>>>
>>>>> required: block goes after patternProperties: block
>>>>>
>>>>>> +
>>>>>> +patternProperties:
>>>>>> +  "^soc_revision@0$":
>>>>>
>>>>> Why do you define individual memory cells? Is this part of a binding?
>>>>> IOW, OS/Linux requires this?
>>>>
>>>> nvmem has in kernel interface where you can reference to nodes. nvmem_cell_get()
>>>> calls. It means you should be able to describe internal layout that's why names
>>>> are used. And address in name is there because of reg property is used to
>>>> describe base offset and size.
>>>
>>> That's not really what I am asking. Why internal layout of memory must
>>> be part of the bindings?
>>
>> It doesn't need to be but offsets are hardcoded inside the driver itself and
>> they can't be different.
> 
> Hm, where? I opened drivers/nvmem/zynqmp_nvmem.c and I do not see any
> hard-coded offsets.

Current driver supports only soc revision from offset 0.
But if you look at 5/5 you need to define offsets where information is present.
+#define SOC_VERSION_OFFSET	0x0
+#define EFUSE_START_OFFSET	0xC
+#define EFUSE_END_OFFSET	0xFC
+#define EFUSE_PUF_START_OFFSET	0x100
+#define EFUSE_PUF_MID_OFFSET	0x140
+#define EFUSE_PUF_END_OFFSET	0x17F


> 
>>   On different nvmem locations like MAC location in
>> eeprom this can vary across boards but in this case location has to be only like
>> this.
>> I am fine if they don't need to be actually check but there is no any other way
>> how they can be composed. And also others are not valid that's why not to
>> describe only valid one.
> 
> OK, that would be valid (if I find anywhere the offsets) and answers my
> questions but I wish it was documented somewhere. Because now you are
> making it a binding, so it cannot change (e.g. for different devices
> with same hardware but different firmware or manufacturing process, for
> future hardware sharing this binding).

ZynqMP firmware with xlnx,zynqmp-nvmem-fw compatible string is using this map.
If there is different firmware likely xlnx,zynqmp-nvmem-fw compatible string 
can't be used.

> In any case the binding should have only items which are really fixed
> and OS depends on them. Neither this nor next commit answers this.

Actually 5/5 has this in commit message
	0 - SOC version(read only)
	0xC - 0xFC -ZynqMP specific purpose efuses
	0x100 - 0x17F - Physical Unclonable Function(PUF)
                 efuses repurposed as user efuses

Thanks,
Michal

