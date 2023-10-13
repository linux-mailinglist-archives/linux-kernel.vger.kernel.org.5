Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4BA7C8443
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjJMLTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjJMLS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:18:58 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C14010B;
        Fri, 13 Oct 2023 04:18:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ktle9V0XE8f5oLcInn3dej4q+CaHxll9EX8ylrx1IHrPh/DZdizUILKKYdx2hRrAusgqy+tcbTVwrxszWy5rH6Vxos587eycscaBgzi1uVa2GM8tB5aJ9kllBPwU1GIv6CpmqEB6qahhZZd2sO/T/Xp9MR6BFSG2dcOWfJaw7wKXmjExXLABYOVzJYyVjWENv1urrOqXqJMMvOVxkBbZm7FDPzYfZaSXOn5/Aq+Ce8MQDIgLp/0nuDF0kwYTrgDGeDmJOFktFOUJstCv25K2kTVpRrJG6AnUYB+9J6dvizXL4QnSa3CSOzFyPIhdrVunKfdawXhLvnXqyy2nJmDG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjFl4xPWx5jAemVjsuAMLiYgL29MXpiSRcu3Y1IOUn0=;
 b=ejcYJqc0q2ptSEWl1X2WpfXk/e+vQ10O1bxnSRXy+ddfbaH/Tb6TdvVc/PCRWrGmOLKSbT00rAX1CipKYfBFlqsieeP4PW0e+fQwm5zTWw3cNwI/73HVuIlzszm2ij61o2A5zQMcEOALzmfv/4+qUgPQOmEByLsR0vu1Ta+/Nrf0R35IK+kZtRltAUaMBFUmTdtZQQchAYUUiA1qRzFYB3wmQLrE3VGC7dCFVEvw5Ig2JHr28EXJCMxtnrIokmfLRUGs4L5uYrXNtshfJnEJYJVNHZWnIDZ4EIzdAO0XYr78y43acQDQkmayyq9/BnVe3hDV1JtgvcvfImSG5gYdyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjFl4xPWx5jAemVjsuAMLiYgL29MXpiSRcu3Y1IOUn0=;
 b=hU/wcUViL4chFL7kJkzH8Toflum6ejTgp4+V+44Wfmv/i1x81EKZZTm7jj25z+Y32h7k6hRC8vPWvEvg3NO2PMwBzro2yCE1I+eCBIMwvNqPA6r9BHke+6zsyzLlaqb5xkNZuegRks78ga6sMZkvkF5fbE5Iuf5/Q/MluzlElj4=
Received: from BL1P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::29)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 11:18:48 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::9a) by BL1P222CA0024.outlook.office365.com
 (2603:10b6:208:2c7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Fri, 13 Oct 2023 11:18:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 11:18:47 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 06:18:45 -0500
Message-ID: <ec924502-ddf0-4821-945d-7c1649502574@amd.com>
Date:   Fri, 13 Oct 2023 13:18:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: zynqmp: Add ZynqnMP nvmem nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Praveen Teja Kundanala" <praveen.teja.kundanala@amd.com>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20231013101450.573-1-praveen.teja.kundanala@amd.com>
 <20231013101450.573-5-praveen.teja.kundanala@amd.com>
 <acd0e775-9766-49b6-8dc1-22fdd5d63688@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <acd0e775-9766-49b6-8dc1-22fdd5d63688@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 0423b141-0f7b-4ec0-2643-08dbcbde2bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bK2t5khZGJ5+CXxFEWBSlCvok+oZL+aMo6P69gAhXr1g3K+sVub1TCoWJxYTdsu0X2H05IxdEIFT2dUdUI40QuJ69HvMq3LXW5hk2KoR50hHjnDerXPcOwDaY0pPgIDga257QrntK2bzv/BHAqON/sIjCfsKxhTihclWoE8UPKAovJ1W9yVdYHfBiBPI6J9txCT7yNJvAJdIT4V5mUWDEfv+j20oXtVeteh2Cy6rhWsbLWdYG9voEbGUOK/mskhF6TlCHcXNmgd206xc8SBFt+Aa7ALH/ypFD7rcagkS9mq/GZODZ5G9B06spkOO93hkE1Nb8HXazEDLWw1cATfEtyLwyGyytvXIVJARQVNl+CI9+/SVjIKg3vMVShB127AAmaiyWwqcCOicWIlwYjnlk6GKyq3oOILr0wuXaEpj0XCI0I5SoKtzrFDobwUGk8PQKyrndFUsbmBTUsa3X6Ta/o5a7BFvFCu6hsc6yamcf20hnvwg1i8QZ3KCGrzFAIWn5V0G/NL38WpLLiyqeg8v/R16aJcY7ofMjd2vzFKbkyTaD2WgpCQcrM0e8YwfWwBEbUxCuBxpoqVNPoQsUiwos96mdbZI65j07n5S5YV78ptexxxpZhTfA7KaHOJkjGNEe6Di0kfXCLajTmNs2h0aJYNMRq6WBIKs/9nBnyNVBkuNNgiM98ZeioeXeNfaeN8gVT5hdY1Zcn6mEUED69M89QXdFSFXgh//IXELGP3C0MCH8BWAYkY4ertJbBjSfTc+n0akYwXrSuxKIiAZWAhiDss2RtNXfuy0jN/zJGL4Jb4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(82310400011)(1800799009)(64100799003)(451199024)(186009)(36840700001)(40470700004)(46966006)(478600001)(16576012)(316002)(16526019)(82740400003)(53546011)(70586007)(70206006)(110136005)(966005)(31686004)(4326008)(41300700001)(44832011)(8676002)(8936002)(356005)(81166007)(36860700001)(336012)(26005)(426003)(2616005)(40480700001)(83380400001)(2906002)(5660300002)(40460700003)(31696002)(36756003)(47076005)(86362001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 11:18:47.8599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0423b141-0f7b-4ec0-2643-08dbcbde2bae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/23 12:32, Krzysztof Kozlowski wrote:
> On 13/10/2023 12:14, Praveen Teja Kundanala wrote:
>> Add nvmem DT nodes for ZynqMP SOC
>>
>> Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
>> ---
>>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 55 ++++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> index 02cfcc716936..b8807dcce442 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> @@ -190,6 +190,61 @@ nvmem_firmware {
>>   				soc_revision: soc_revision@0 {
>>   					reg = <0x0 0x4>;
>>   				};
>> +				/* efuse access */
>> +				efuse_dna: efuse_dna@c {
> 
> No underscores in node names. I see now from where did you get the
> initial pattern. Would be great if you fixed Xilinx DTS :/

I actually fixed soc-revision here.

https://lore.kernel.org/all/5137958580c85a35cf6aadd1c33a2f6bcf81a9e5.1695040866.git.michal.simek@amd.com/

Thanks,
Michal
