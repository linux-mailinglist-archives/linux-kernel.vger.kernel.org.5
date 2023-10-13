Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E90A7C844F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjJMLW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJMLW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:22:56 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA6191;
        Fri, 13 Oct 2023 04:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoGXVwJEJtfDUMSGiHx4JVG+97Yy57eTvIoYL620aNs6Sy3oLTcO/8udNUUvrBCw/v4AAjMCy9AeMbJkJt66J+K9544XdRV3sWVoPQXWkAE4J23L8bpQp/lH6q2NJWI4qs5u1Z22ON4t2Vdmki26S9jy6LuKxIJ7vq3n3fDNbDtMIkqK2hmDCf9tnKXifs1cfhQYGclGlu7GhKRfMlpjCIzC3Vf1qi0l2I1uvPMjeZgU2X7mkoYeAk0hoIIDdbSYtfotiN8Cc0lc8MUiAOB1Q8Fp0cibyyumZHd+jjRUpRnsW2A1q2O8+KlC2ZHzimwZ+O4kXUG7ERF8UnSJlil1nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9ks7wfPjYklqP2OjIQKPmY4G+1cmPloa0oUqxQH5UY=;
 b=mc0YHjJ6CDW1RxxlRqdp1ivvvv/29TJCw0ZFwWJQ8RYeljrPfSZcrDVEZSm2eZTcgTxkZBwiKZYhsGNqG5x3YON6uuq3pSTVCkJJbg7s5FBtFbD0R4NUGdOxtu6NIsI06PLWlAz3LU4z8MnWYMmZ8hvXTli0eskklVXZZInpIP5na8yxeVE5xaXnReZ9MyfYVr2ZJ/USwkRc4zEFzhFgJmz9oFxODHW8yriPgVdpAcaFS9w9UySQW3/WdmEnIpm6nNeb3eh/TnwAh4kw/hZZEKSJYnEdDEmLhQTyRNa63hbvSQizucP9k/j3u0K886IQGLA6z8Al0b10rdnsC3bv8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9ks7wfPjYklqP2OjIQKPmY4G+1cmPloa0oUqxQH5UY=;
 b=VP1XpiqGtMWZO/4CxFbbVLT6kXY1RlHTHQi2vbc26G5bUZWhoVOWM/ZUGpOE2FOf9kG8+Xf35OXJZ7vAo5rB/Mt9knpbbhsoxPeyTAJ8lVryc+LDz1FeYIWyog99w5q/uz78pFZIyaVpE2L8bSXipavfzPdN+FOvc2V5KHu9Ghs=
Received: from MN2PR19CA0057.namprd19.prod.outlook.com (2603:10b6:208:19b::34)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 11:22:51 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:19b:cafe::33) by MN2PR19CA0057.outlook.office365.com
 (2603:10b6:208:19b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Fri, 13 Oct 2023 11:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 11:22:51 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 06:22:49 -0500
Message-ID: <91d61e1a-abb0-4b31-aa22-aff72d582ebe@amd.com>
Date:   Fri, 13 Oct 2023 13:22:44 +0200
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
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <02d3fa42-75a3-4f4f-ade6-204c8146d694@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 06515ee3-0f6d-4503-143f-08dbcbdebcb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFPB1eRe7b5HoF1nOSiXDmrb6JJhzYkZQfjjEdH3HJbqaWa/cNO8wCTq1/ji0te/L6rXg0fq0CX+MfeT5dq+JyUXGfM0R68FXAnHaGnj8aw2QWSGZ8G64bQ+syV91/wdk55o/y6Bv3gs8EXCAXSC+hJ6B0H6ikrdcXiDBVpGVDOx23j4W1i8h6Wx2Pq8PZwv3as09m29Iw+M2yvO5tuqTysXCGkZHOx8QiAJEVpY1n/fnultxsi6xBJkXrLuwCpCE16D5hn5hawexcA90uWz7/oZkpRxfgkFgkcGRC7rc9F3Gwgnkpa4qKWjHQ7H/tptPRxc+8MJOxW1XzpyGjziTFRGOCBAJTquxpPai5nan2qKxxXi/1of1iYdrD6XiLGVA2KPQjyZnuRFMuE/wXzRy8WkihPNu+adHxfKoC6c0mNppcKbLiZw3+nu3jYHoboB4U80+RSwbX2nKeBBjpWp0VH/M4vpqNv1isFSFD8pn4Rdv1UK6eddEY99uaEabU/4oMbcZ2NMxIlBzdUr47Rqrm2ekADbiefjp7hN8kdJ5Euuk/gZhXKCoRcOExTV3D4NsF6oXs4SsoxWnP4n8d9Rz6AQ21UoSNzakrPvQ3gSoyD3LwwvOhHAPxeL9tscfSOgZYhAVcpB/bnOL9QSrWJ1ZpC5HxYlSi4MC8Fhvhfx5VS+TnPhEpqSY4RnA69QK5rumrfCl1ZRofjO35mhft0lQYC+pLeNEFmFG0GdRsNxYH2CaUqdkAczGJOA5dRTaTajN0Y7fem3wmx4Z6Jkan4kbv+rAFDvRiJeHlLttYeyiKP/7xp0TRAdSad6KemamGG6sdFlirJBr/GVPxjXBADIjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(46966006)(36840700001)(40470700004)(478600001)(40480700001)(6666004)(4326008)(47076005)(8676002)(40460700003)(70206006)(966005)(16576012)(110136005)(70586007)(316002)(31696002)(86362001)(82740400003)(8936002)(2906002)(81166007)(356005)(36756003)(5660300002)(41300700001)(44832011)(36860700001)(26005)(16526019)(31686004)(2616005)(83380400001)(426003)(336012)(53546011)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 11:22:51.1947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06515ee3-0f6d-4503-143f-08dbcbdebcb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/23 12:30, Krzysztof Kozlowski wrote:
> On 13/10/2023 12:14, Praveen Teja Kundanala wrote:
>> Convert the xlnx,zynqmp-nvmem.txt to yaml.
>>
>> Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
>> ---
>>   .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      | 46 ---------------
>>   .../bindings/nvmem/xlnx,zynqmp-nvmem.yaml     | 59 +++++++++++++++++++
>>   2 files changed, 59 insertions(+), 46 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
>>   create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
>> deleted file mode 100644
>> index 4881561b3a02..000000000000
>> --- a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
>> +++ /dev/null
>> @@ -1,46 +0,0 @@
>> ---------------------------------------------------------------------------
>> -=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
>> ---------------------------------------------------------------------------
>> -The nvmem_firmware node provides access to the hardware related data
>> -like soc revision, IDCODE... etc, By using the firmware interface.
>> -
>> -Required properties:
>> -- compatible: should be "xlnx,zynqmp-nvmem-fw"
>> -
>> -= Data cells =
>> -Are child nodes of silicon id, bindings of which as described in
>> -bindings/nvmem/nvmem.txt
>> -
>> --------
>> - Example
>> --------
>> -firmware {
>> -	zynqmp_firmware: zynqmp-firmware {
>> -		compatible = "xlnx,zynqmp-firmware";
>> -		method = "smc";
>> -
>> -		nvmem_firmware {
>> -			compatible = "xlnx,zynqmp-nvmem-fw";
>> -			#address-cells = <1>;
>> -			#size-cells = <1>;
>> -
>> -			/* Data cells */
>> -			soc_revision: soc_revision {
>> -				reg = <0x0 0x4>;
>> -			};
>> -		};
>> -	};
>> -};
>> -
>> -= Data consumers =
>> -Are device nodes which consume nvmem data cells.
>> -
>> -For example:
>> -	pcap {
>> -		...
>> -
>> -		nvmem-cells = <&soc_revision>;
>> -		nvmem-cell-names = "soc_revision";
>> -
>> -		...
>> -	};
>> diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
>> new file mode 100644
>> index 000000000000..e03ed8c32537
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
>> @@ -0,0 +1,59 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/nvmem/xlnx,zynqmp-nvmem.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Zynq UltraScale+ MPSoC Non Volatile Memory interface
>> +
>> +description: |
>> +    The ZynqMP MPSoC provides access to the hardware related data
>> +    like SOC revision, IDCODE.
>> +
>> +maintainers:
>> +  - Kalyani Akula <kalyani.akula@amd.com>
>> +  - Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
>> +
>> +allOf:
>> +  - $ref: "nvmem.yaml#"
> 
> Drop quotes.
> 
>> +
>> +properties:
>> +  compatible:
>> +    const: xlnx,zynqmp-nvmem-fw
>> +
>> +  '#address-cells':
>> +    const: 1
> 
> Drop
> 
>> +
>> +  '#size-cells':
>> +    const: 1
> 
> Drop
> 
>> +
>> +required:
>> +  - compatible
> 
> required: block goes after patternProperties: block
> 
>> +
>> +patternProperties:
>> +  "^soc_revision@0$":
> 
> Why do you define individual memory cells? Is this part of a binding?
> IOW, OS/Linux requires this?

nvmem has in kernel interface where you can reference to nodes. nvmem_cell_get() 
calls. It means you should be able to describe internal layout that's why names 
are used. And address in name is there because of reg property is used to 
describe base offset and size.

Thanks,
Michal


