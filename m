Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF247A5A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjISHGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjISHGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:06:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B7511C;
        Tue, 19 Sep 2023 00:06:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zof/3keUIRFI+/K+8F96YHHD301oTeUI9Q9pFjxCBkL5lfyxiStFdc1lo16VGNXdSTUORUFYhomMK4/Z3tIfa8qQH+l4Ft4GLY1MTzHYwEfdy32niS7PiCnF4Poz6KmALpE9LqM7rNqnm8I/rvR+SwYfgs2lmBCN9iEV2uCX9r2J3JF4oVQ3/V5iGtR7LeSCnG2HJC2dMzltEiyoEXl07mjz9VjUYDJ1sMpRz0KMr5UaK3F95IuMqrHPIDBjHpMuenneCZfyxInTXB/VG91TBwy6LJsLaiRimk85R1n5H7PlaqbJ5IbOQNHQBIdYZowsFVsu8JuFJr2W6gkXM9hjww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atGURf+pKf+WKa+oId0diXaZcb09gy+edz37oEtn8QI=;
 b=BfOIME1UKqckb998S6a/d4TgkM7eQcLoIjCbpQicnjeZb5S8GSMsg8PdSwEiV8Y4DM+JvaWLWTyZD//v3cI7lxOustLZLGlqjVq18jHh7NoaqUT4UXAYPjwNHPlcsdxT5LIxzIUHEnfONSmKf9WoF/0PfTOlJOD3jm+D8FuyTWop1KV+NmBkHmaWjuh0fNc2LFhm9lCIcDgbmfd282CJPYK0DfjvFA5qYuTXzl+kB0/En8NLOl++mBcLFTZrqKrFLwN64fLZlaJKgyLcaepo2xqm4x8GH903gqJ+pGi8Wj+n2WJls0mYQ8K4FQanM1O9ba1PK2SAsHo4hAk5IYipxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atGURf+pKf+WKa+oId0diXaZcb09gy+edz37oEtn8QI=;
 b=ZebKGDenhOfh34QqhVBWycXidIWTC2ZD7rUWyDOkAga/PXaCvJjpP3qUP+GkDM7svNOxOIPVDXjnBx4Vemm5fz1KjHyniW6oGEoiAciE5yu7pLMurzLaHoway+c/ISIZk6EVqntK3Lq4C+K+4l2znFk8sK1pnCXzGN83M9Q81EQ=
Received: from MW4P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::8) by
 CH0PR12MB5057.namprd12.prod.outlook.com (2603:10b6:610:e0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.28; Tue, 19 Sep 2023 07:06:42 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::37) by MW4P223CA0003.outlook.office365.com
 (2603:10b6:303:80::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Tue, 19 Sep 2023 07:06:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 07:06:41 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 02:06:36 -0500
Message-ID: <9a870a76-cb98-4c1c-89c5-b68f5f77c47e@amd.com>
Date:   Tue, 19 Sep 2023 09:06:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm64: xilinx: Remove mt25qu512a compatible string
 from SOM
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Sharath Kumar Dasari <sharath.kumar.dasari@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1695040866.git.michal.simek@amd.com>
 <a1e975f5785dfb6eb04e8d5905dcaa7467ccd585.1695040866.git.michal.simek@amd.com>
 <20230918150119.GC16823@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230918150119.GC16823@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|CH0PR12MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd69559-b8ce-4af1-2140-08dbb8def994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oLmdJ4ReJfUDnMFzmvARWyvM173ZMEZzoEcvsbsdn/d0cQslicvzCIPZcPXkUJGeyJBmk8bQqOXaqj34RA0Ud8SQgLAxD5cio1yOndSeWw2DqvYwTe6m3TqNKL+osqQe4tP1QGE1k5LevtVibaKxpzm/FbHcVqN4T2G1Vtw2BYUoeSBsmkflYQFdKP9yjNS1Z6HIpQkT4FfMp7OXjC1Ah8FarvwGPAxR3MjUDyyM71KZKttd0bdkQBxgkxBWtMaZkDxdSsqRAY/rwnnxQKhK1EpOBl6fNtTZxkc3x7jmiIB2E/+DCdGkbiHawKMZNoqJvFTmpGxkqboyunO0TbBb4br449yJj62Ov3aJSIF3x/XK+XFS5BXDRm0Al2VDRvGH4uDi10ogfpRegE52KGMknLV5M2tiRJdHV4WK2lrN3S7ZRUu2JdpngsRWkrXjwp8x3yO5H7hbAARB6bdANuqha28MYNtf4rXXAyyIkRS3aHBr95WA0Ohsi628B3/Mp3tynXrn0H+x8s42cV74WoPZD4K0c609ruUYop6iHXfFrcPFdy7B4RZ8kDFYG+f1wy4nLSzsHWTwJiZM38IikxT70VQvmTPmlCTDWPBwt+RbOS+ekzGidgnGy8L0ae8k4nXjFCfPX/a48kzjD98B2/qH1IXH43GX3be8I0x1nobTBlJiHRQYEjPLkTLyju0zxI0nQXN/e1CCzGVb88Mg243d6lXqVLcX40LXK7cOATy6O86DSwVXx7tayF8kFxeRZL79362AwNaR9/Dzw3PYZRNit3OxwxD6lXC70EZcYGbExAQKRD/rrpW7nj+VZ/+hy5Jo
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(53546011)(6666004)(478600001)(83380400001)(47076005)(2616005)(16526019)(26005)(336012)(426003)(2906002)(44832011)(316002)(70206006)(70586007)(54906003)(16576012)(110136005)(5660300002)(4326008)(8676002)(8936002)(41300700001)(7416002)(40460700003)(36860700001)(86362001)(31696002)(82740400003)(81166007)(36756003)(40480700001)(356005)(31686004)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 07:06:41.0979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd69559-b8ce-4af1-2140-08dbb8def994
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5057
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 9/18/23 17:01, Laurent Pinchart wrote:
> Hi Michal,
> 
> Thank you for the patch.
> 
> On Mon, Sep 18, 2023 at 02:41:14PM +0200, Michal Simek wrote:
>> mt25qu512a is not documented in DT binding that's why remove it.
> 
> How about adding the compatible string to the bindings instead ?
> 
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
>> index 157dcb4a27a8..cd5cd7f3b5ce 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
>> @@ -131,7 +131,7 @@ mux {
>>   &qspi { /* MIO 0-5 - U143 */
>>   	status = "okay";
>>   	spi_flash: flash@0 { /* MT25QU512A */
>> -		compatible = "mt25qu512a", "jedec,spi-nor"; /* 64MB */
>> +		compatible = "jedec,spi-nor"; /* 64MB */
>>   		#address-cells = <1>;
>>   		#size-cells = <1>;
>>   		reg = <0>;
> 

arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts is using only jedec,spi-nor

Renesas and our SOM are using it.
arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi:310:           compatible = 
"micron,mt25qu512a", "jedec,spi-nor";
arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi:239:          compatible = 
"micron,mt25qu512a", "jedec,spi-nor";
arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts:136:          compatible = 
"micron,mt25qu512a", "jedec,spi-nor"; /* 64MB */

Rob/Krzysztof/Conor: What's the recommendation? I see 02g variant listed and 
micron-st also has 256a/512a variants.

Thanks,
Michal
