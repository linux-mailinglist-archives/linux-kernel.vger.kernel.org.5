Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2307E7A5B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjISHsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjISHsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:48:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA54118;
        Tue, 19 Sep 2023 00:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8yYVqfu2DTTxcHXavkWDF8KsQj2fFqIG0tOYfWgZMShgV8/APTVfaTlEjilXx09S+ssOM9+Rz6HX1+ial5ZZxlH1WtiG0WBYUTyBbmAH+Aw9lTxQCIBAJ/NFY9tHd6ooujseUzA+LpMn62dgZ92JT4QK2JCbLY2PxxtqFo/1KH7YKfHH6KaW0HIO8BY/3G5q/rOTPXYQhYjL29eG73v4GF3Dk3P8cVxfJph8JCmz3Y8IfUoIy9JdeQ3k/v790puAxXP8iCReGEBaOV5C8FWZopHftZ+yJKpvf0Pz44OamyeYS3fKMJULwS1pEdhYVgUrqppI4NJj0GtLT7NHhhSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwAXQ1JwTRbEcBnIHyb/B8864+yYtKUUuiXIq2OLwfY=;
 b=d6/xGE9GbIx3XFyKbUlN9P6gPJz94rk6x0jyFAr/fVa+AIUfN15E9zzXd+a8zBm53Vw8ixGrafWqHu/MoFFHI7MYGHVdmqad0J0aflF4rHi+GZj5alwvQM94qTEtx/WDLE0LujoBXdd6a180dyf5NxC/JuwUhrNc9d+FF41eNB4ZQ6/WtCJjbFELCn3jD29CKpge1ahPRYrdsXEupGL3trslSTHXGJZZkIcIk4f/mdoH6TO6OuQ9trvKW5CVmQsv9chx41U2NuUoiBNCSj459PDQLGlOc4IGjsK1lI1YWNur6AygPOU41voxsQpsd9fYjGDvDAFbnsD/x7RCWw+EfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwAXQ1JwTRbEcBnIHyb/B8864+yYtKUUuiXIq2OLwfY=;
 b=TRo+JmbXZ2k9e5GlbC1eH8LmoxFVldV68nChv2iU5HeF0t93w2AEA6BKmZsu+j7WV0+TXefEw7yAqbT1lnG1lb9+NuGwV1lnmA/EZFYKzdbKUsfeWnvJKwTnTqwSt7zlFUI2HEE0i0pIs0ua0N1tJ8XGBBD+RoDAQquSJD/C7Dg=
Received: from DM6PR04CA0030.namprd04.prod.outlook.com (2603:10b6:5:334::35)
 by IA1PR12MB8333.namprd12.prod.outlook.com (2603:10b6:208:3fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 19 Sep
 2023 07:47:58 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::8e) by DM6PR04CA0030.outlook.office365.com
 (2603:10b6:5:334::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Tue, 19 Sep 2023 07:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Tue, 19 Sep 2023 07:47:57 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 02:47:53 -0500
Message-ID: <3a11c2e6-2086-4b06-9b8c-177cfba06034@amd.com>
Date:   Tue, 19 Sep 2023 09:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm64: xilinx: Do not use '_' in DT node names
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1695040866.git.michal.simek@amd.com>
 <5137958580c85a35cf6aadd1c33a2f6bcf81a9e5.1695040866.git.michal.simek@amd.com>
 <20230918145616.GA16823@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230918145616.GA16823@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|IA1PR12MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c80e8e-8bbd-499b-925f-08dbb8e4bd91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fMYLtbQMLUoUFmucJvq7N3Pgzu2gQeCiR/rarjf7MrLc+QijoW4MrHOjDJ2ffH0v80L3GeWcPdwIS4eR8IPT52upJ7Nc6dfhsSPndu1XK0cBLYPj6vi9PwSdeagM/qh74Ul2U1vMwKPiq8OuIjW4KniM21SpanmXBpHRdIuNotIuBWtwaRpQ3SfVajUBHEvOQUdp3SdplEthkt5zH3Rtv57sHc/qYCV1AHpB8bI8/ASAfMReJTZC5Sz39AWvJcipznQ2ewUKmgXDZGFxEB7E8ZuGeNKrQ5f0SWR/f80iENNV94MF9vRy4iMohuoHm2etpr7Urwzc+6g0OHdy3yx1jys9tWQSB/pprS72HwSX51CdMOevAURhTWNPe7q3PgE6MRG0XS+K+O7Nez+ZYDuix3mRCzyQL19ZJF3bsHpFha80h2twfDyHnWDX0gtBIv1UrJIfxOF/QNFW5Z2YF4kJPoXss4cTL2ani+Tyum0roG5Ns1SxjJmZYKePMKsZRmq5RXa7Tq4oZjatGWbsO18wxm1drQOO3Ry4nexqQEbaermTy4uhSJuPDMhVt3QU9NWryjYnwIpwruXaglWk7wuWDatOxw0BSFggqlB5241V9BBuSblcoxx0mbEcVSO74VE0LEnvrIqPgKnrPOKdjHR6MvWWQleByHEnbW7mHEqSTWvBBlAJvBIMXjwZeMjfgNE2YiVgxWJ8IuBYodDv7JPeMcTEF6XysNEE/fkSTAEdwKGLehjb9vSVFCGQDF3GYSoN5Ud5JwvkOF5Rp/G9oHeO6hOouWitNQO8y0hCxlNmwdc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(82740400003)(356005)(53546011)(83380400001)(5660300002)(966005)(2616005)(54906003)(81166007)(70586007)(16576012)(8936002)(4326008)(41300700001)(6916009)(8676002)(336012)(70206006)(36860700001)(31686004)(26005)(426003)(16526019)(316002)(478600001)(44832011)(86362001)(47076005)(36756003)(7416002)(2906002)(31696002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 07:47:57.4139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c80e8e-8bbd-499b-925f-08dbb8e4bd91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8333
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/23 16:56, Laurent Pinchart wrote:
> Hi Michal,
> 
> Thank you for the patch.
> 
> On Mon, Sep 18, 2023 at 02:41:12PM +0200, Michal Simek wrote:
>> Character '_' not recommended in node name. Use '-' instead.
>> Pretty much run seds below for node names.
>> s/zynqmp_ipi/zynqmp-ipi/
>> s/nvmem_firmware/nvmem-firmware/
>> s/soc_revision/soc-revision/
>> s/si5335_/si5335-/
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> The si5335 nodes may be better named after the clock name instead of the
> component type, but that's nitpicking.

I don't know what's the guidance on this. fixed-clock.yaml is using generic 
"clock" name. I have no problem to do it if this is recommended way to go.


>> ---
>>
>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 4 ++--
>>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi            | 6 +++---
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>> index d0091d3cb764..52f998c22538 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>> @@ -123,13 +123,13 @@ ina226 {
>>   		io-channels = <&u35 0>, <&u35 1>, <&u35 2>, <&u35 3>;
>>   	};
>>   
>> -	si5335_0: si5335_0 { /* clk0_usb - u23 */
>> +	si5335_0: si5335-0 { /* clk0_usb - u23 */
>>   		compatible = "fixed-clock";
>>   		#clock-cells = <0>;
>>   		clock-frequency = <26000000>;
>>   	};
>>   
>> -	si5335_1: si5335_1 { /* clk1_dp - u23 */
>> +	si5335_1: si5335-1 { /* clk1_dp - u23 */
>>   		compatible = "fixed-clock";
>>   		#clock-cells = <0>;
>>   		clock-frequency = <27000000>;
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> index b61fc99cd911..e50e95cbe817 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> @@ -129,7 +129,7 @@ rproc_1_fw_image: memory@3ef00000 {
>>   		};
>>   	};
>>   
>> -	zynqmp_ipi: zynqmp_ipi {
>> +	zynqmp_ipi: zynqmp-ipi {
>>   		bootph-all;
>>   		compatible = "xlnx,zynqmp-ipi-mailbox";
>>   		interrupt-parent = <&gic>;
>> @@ -194,12 +194,12 @@ zynqmp_power: zynqmp-power {
>>   				mbox-names = "tx", "rx";
>>   			};
>>   
>> -			nvmem_firmware {
>> +			nvmem-firmware {
>>   				compatible = "xlnx,zynqmp-nvmem-fw";
>>   				#address-cells = <1>;
>>   				#size-cells = <1>;
>>   
>> -				soc_revision: soc_revision@0 {
>> +				soc_revision: soc-revision@0 {
> 
> Unless I'm mistaken, this will change the userspace API, as it changes
> the nvmem cell name. Is it an issue ?

Based on
https://docs.kernel.org/driver-api/nvmem.html#userspace-binary-interface

The only interface to user space is via nvmem file which has all of them 
together. And reference to this node is the same if used inside kernel itself.
That's why I think there is no change in connection to user space API from nvmem 
side. Of course entry is listed differently if you parse DT names.

Thanks,
Michal
