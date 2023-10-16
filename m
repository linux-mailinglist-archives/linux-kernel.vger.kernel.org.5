Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F297CA4C0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjJPKHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJPKH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:07:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ED083;
        Mon, 16 Oct 2023 03:07:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0d9N9MxlVUmRK1NJDuWc8HVqvSHidVBZYM2EE61Htm9//JAliae6OMafLFqTwN0ZgW4mPJ5O4pbmMLpuLgwgqjVX9jkbambMdHHoO2VBXk9FFooEzGwTutPj6O1JxQoY1C35FuyKLhL0vkElrrYQZYTiVk4dz9nV771uxI598IYxuJJa2jl7IxYKMQ48AO64NdQdXJshZJzJLYaWkpXN4fkr8iKqR9OmIPTZwwp+ashz9HClrBmNmdJI8cmm7JHgEJzo0fiI6lMM2GlyAcPl1qecuyEhiWdH1PScyCf4HQYjY0Z4vWyIzegE8zxq7Sjgf12q2cFj+JxcxIcaQg6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APigHmRIYaxeLnHDWUXjTSyDvr7fKmWEtHLlMSQaAps=;
 b=a+zacAURtz6U+AdlKudRJkLiN9Yh9y3xcg2BzlJmfpztTtsOjdzBBco5yatUX9oC708mQTh3ntvTWH4EMWVn3RUaUN7pL8X6ZuX3R5QCzwPdyb7nABoXrUj7YEbmLWTuhA1NkldJrvtIyuU6G9CiHvaw0b+aDDB12Kzlh4EGWLfgM5RfGCxgWJ5ZmKrNftwXveEBkJ3hJgtQgakmspIWdWApzmhZ87gmXx7rhjTLc/oYSXs4cl5CZIj208rs9Ry/8VUfNobVtW6Nz45qi3etWowA1k4Yv99Kni4//mD0uEW0TmR2XB1zbm8hAGA0x3081v8v4tz7L+0hpQ3+qpOI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APigHmRIYaxeLnHDWUXjTSyDvr7fKmWEtHLlMSQaAps=;
 b=0j0XehbL8g1lWCpXUzU1UjTOGDpaFw7drZ1aiekpazI3mDbp3/E5//xhLeapAtVKgzxmLFP9UGTb9K3tJ4LB+FAL72Fm20Lw0oEo6zDcCbUf24W8rClqKBwxHuOfeQ8U8XfH37hLFIG/Yn3hZ2nAc9+v5/67tFjXEtjt34GcTxU=
Received: from CY5PR19CA0002.namprd19.prod.outlook.com (2603:10b6:930:15::8)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.35; Mon, 16 Oct 2023 10:07:24 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::ba) by CY5PR19CA0002.outlook.office365.com
 (2603:10b6:930:15::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 10:07:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:07:23 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 05:07:18 -0500
Message-ID: <a1d2875d-cb0d-4441-924c-d0ff8f9c2234@amd.com>
Date:   Mon, 16 Oct 2023 12:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] arm64: xilinx: Tune DTSes to remove warnings from
 make W=1 dtbs
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Piyush Mehta" <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Sharath Kumar Dasari" <sharath.kumar.dasari@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1695040866.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cover.1695040866.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e02381-d814-416c-8d72-08dbce2fb182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6uXLl4pQDrAa36p9uIAByVfZfGkEIDPMfqHQNutVjKLv22XTzE3CERWnSwz7wclEST7bKmgSLnIlOUPe+NHfs7Ja4Y9c2PQ8ezXEKjAT8Lfevf9tHugI0NeKglqdsG4G2O99FjCfhKtClwCQ2cxmEWo/F0Zym4DkVvGTl7hcMUBD5sOeIoE7LN1ukM5Qafz66rqwN6dIAPlJP4PDz5EtIQYk27Eir+73cqTybaiQr9ZgJwvcqAHjT39TgFuUnLcPlO4/cMv3+qjVEZ853GFmPITFy7TvghwOUPqQvuewwUHrJGD4Jcoj4yOdx/X9mBDbFitjR1wfjCAN6SibOa0IekormYyokpP8cYrmlUam6b70IgndoDTsg39+/6tZcV9c2mbNkW2jVRQuGpgUNZpWV8qD0prZzVKcgh7D5u97mKTYPc5vEdK0cj5JTvOrEq4P11niyNiLzdc08cEmrbMKHOBefsBXsQx9GZRf5nCGI7C6CeN0207vLpa9zK2i9gIPFo1Qt5Sd9OEwObHSAbJUWBVogavzNHy56xnZT3gq1aBOlrqXrEjprXk1tCJ1tVk6jk9hbuwEGKRxJorZ7Be4uJHia4ak9Q3jxWADRvGEkPa0HuVU4qv8cMtlxz/nB9LQ2YTxBIz/E1bOg9FwQbkZWu9PjYdo3YwmkfMUeRDNKqeFeZmnaHKG6YHaQewIQk5Mo+VIaUX8LrMIooUC1DwCg6PnAacSUJ0S8RMh+cWKgHiaHoCpHvjSDTJVhLMbLpyyqXO4jlG/Y+WnwRXGIFMzHNfUsO3X/7zAmJnbgNgFSpI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39850400004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82310400011)(36840700001)(46966006)(7416002)(478600001)(41300700001)(316002)(31686004)(8676002)(8936002)(4326008)(110136005)(70586007)(70206006)(54906003)(16576012)(40480700001)(53546011)(36860700001)(31696002)(47076005)(81166007)(356005)(82740400003)(86362001)(2616005)(26005)(36756003)(336012)(426003)(16526019)(83380400001)(5660300002)(44832011)(2906002)(43740500002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:07:23.9027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e02381-d814-416c-8d72-08dbce2fb182
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/23 14:41, Michal Simek wrote:
> Hi,
> 
> make W=1 dtbs is reporting couple of issues which this series is going to
> address. There is also one more changes related to removing additional
> compatible string which is reported by dtbs_check.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (6):
>    arm64: xilinx: Do not use '_' in DT node names
>    arm64: xilinx: Use lower case for partition address
>    arm64: xilinx: Remove mt25qu512a compatible string from SOM
>    arm64: xilinx: Put ethernet phys to mdio node
>    arm64: xilinx: Remove address/size-cells from flash node
>    arm64: xilinx: Remove address/size-cells from gem nodes
> 
>   .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    |  8 +++---
>   .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |  8 ++++--
>   .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    | 16 +++++++-----
>   .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |  8 ++++--
>   .../dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    | 26 +++++++++++--------
>   .../dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    |  8 ++++--
>   .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    |  4 +--
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 14 +++-------
>   8 files changed, 51 insertions(+), 41 deletions(-)
> 

Applied.
M
