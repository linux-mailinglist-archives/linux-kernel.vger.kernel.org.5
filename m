Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7887077D7A2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 03:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241022AbjHPBXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 21:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241014AbjHPBWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:22:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5C71FFB;
        Tue, 15 Aug 2023 18:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbPmx+dUv3PgmES0Y+2ZuIiv8Pxkq9+D4S4M7QLuFgaY6eMEcD0fnbZemmVVfRiMnVxyVgOu9WOHqfSjsuLZdp/4gvWJ631heq5EnnqKYo9mNcZX5D19YYbhRfjVkd37uL3+Rcg93hjQKSfSmP2ySxGgU/gTZTB2BoefmI1rgN2JaIL4uEO937Lv2GsrN6ZL0/Lb1Z+CCCtFhvKUqy3cjz5k3KBpqJMnB8E8q2LDlobaGFfgtkwVmzHVx2e/JVm2Qg/ByWXxALVEf/PEUI+Hw/u/CEkX/chlYMaqhjYUKMHOieuIDtLWbNZt/FsNG8+QOaX08XTFTAk5IrMFBqAUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElCP1+EKWUMM80HhDNhjriK/jEOsoaEovzmDRudUFEA=;
 b=DsG/QeBuemT95NaCKSyDgGdkykSg+pK/axhTBJegI4oBLQE2htQzpk0YMQ3GJF69VwTX4hxWTQvqyOnoJ8ZAWGd8QKMxpLNL2LT46wxJJT/w9G46WF82FipE0bSFSowk+2B6pk8cqnxzqRqCQ0oUMuRmhiEWIlb9su4HrGk6LYWaikQUVZaP44ZKLV8UXo9cxh8IJYcOQJnde7+k0VqFCpQKpydCLsiqE++ucBvCiMfagiqAZqs6leXA5jrKogx9NoiR/ExKz8qhb419FtlqJ9UjyNC9nHrO/I8JiRqSoEtP+J85316RVSlKTJp/CH5IKMfXODMT04RIYpkVJb6W1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmx.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElCP1+EKWUMM80HhDNhjriK/jEOsoaEovzmDRudUFEA=;
 b=MscjKF1hoUMZW9SSANJC2SKn2DSePRIT1XS0MwpWTWlFo3yS4TG/OS8t/PsJ+s/dy0UgF7LnGV2fXN8OPvuHwYk5195ptPPJZRU9dJKQrXHQc/NBQEbhOmMB/PdziKWuLd7+/WGCWfijyQ+59SzBCLWbVh7b2X3CuYzkZLkQ07A=
Received: from CH0PR03CA0108.namprd03.prod.outlook.com (2603:10b6:610:cd::23)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 01:22:33 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:610:cd:cafe::cf) by CH0PR03CA0108.outlook.office365.com
 (2603:10b6:610:cd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 01:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.5 via Frontend Transport; Wed, 16 Aug 2023 01:22:32 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 20:22:28 -0500
From:   Brad Larson <blarson@amd.com>
To:     <j.neuschaefer@gmx.net>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>,
        <andy.shevchenko@gmail.com>, <arnd@arndb.de>, <blarson@amd.com>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <broonie@kernel.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <davidgow@google.com>,
        <devicetree@vger.kernel.org>, <fancer.lancer@gmail.com>,
        <gerg@linux-m68k.org>, <gsomlo@gmail.com>,
        <hal.feng@starfivetech.com>, <hasegawa-hitomi@fujitsu.com>,
        <joel@jms.id.au>, <kernel@esmil.dk>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee.jones@linaro.org>,
        <lee@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <walker.chen@starfivetech.com>,
        <will@kernel.org>, <zhuyinbo@loongson.cn>
Subject: Re: [PATCH v15 4/6] arm64: Add config for AMD Pensando SoC platforms
Date:   Tue, 15 Aug 2023 18:22:21 -0700
Message-ID: <20230816012221.59796-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ZNnoeAG8MevNTjtV@probook>
References: <ZNnoeAG8MevNTjtV@probook>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fde4db9-6285-4967-c479-08db9df743e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgENl9OO09zhEPL1Q3+89DS7YXR9ww4c01S+CVrVMQhKU8Rtj2tEFvp8rcdejhQ9wfdhwbpamVKDQqOMs4WfU9dXuZLj/IL+6JJlFryX9ajIcwovGgSeVSTFLXkwojA+Jhc3yf3cG9KY4oQqX/pxAml1B+FEoioCkV316yQVh7CkLmxaeWm9xR8NDF70aBm4aTNTPf8nvKGb0Ndl91MaVzwfNF5H59OWLhE7JP0E6IP6oTT2ALIrc1vcEiiJp2vRyNAEQqEc0qlNGbaSvIrXDX9B3YiSaLn9z3ZTD964UinKF9erXAJNGiXxsSk+9nS7/ZrFgz/lZcuaSV9oHuK+NVD3H2JL+0FkguReFewNIE1JSsm39wizPyzRDhITXWkRXcvqrBkirCM3EsSyRnYA/EE6q+icBQH/zu2vQGtm+sWFKDIL9Fk0yAMc91/Bd3l7f/QI22eh2ATkb8DxLxHR+xzeaeUpZ7o9UYg5IY4TOfRwyuS1p/ZJevaQJ/IcsTbHpqqu/7Bzflmkz8zw8xeByXWe53tSqcyIRGSZdN8N3b8q8qI+K0eaZ6KqGtgMvRvh7BHESCaH5Sl8e+n8bxqT98S6iA9EP71LDimSpH0gbfqOlc4jAIvJta1XVzU3E95nO+WYHVZCFANPd4FVwVv96iZ8LgHtnuDb2pCxfbnSQg1sDnylioXu+RdcS8bu6V+eW2hGE4b1+DA37qAVVIQj1mLfK9Ls+Nm0aND4V45n8OU3/fXIBwuOhABHOyU5vC4qLCXTPz3mFTYeCbL5diNwCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199024)(186009)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(70206006)(4326008)(70586007)(41300700001)(6916009)(2906002)(81166007)(316002)(478600001)(47076005)(7406005)(426003)(5660300002)(7416002)(2616005)(36860700001)(40480700001)(356005)(53546011)(26005)(8936002)(16526019)(1076003)(6666004)(8676002)(40460700003)(336012)(54906003)(36756003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 01:22:32.2912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fde4db9-6285-4967-c479-08db9df743e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Mon, Aug 14, 2023 at 10:40:17 +0200, Jonathan NeuschÃ¤fer wrote:
> On Fri, Aug 11, 2023 at 11:05:17AM -0700, Brad Larson wrote:
>> Add ARCH_PENSANDO configuration option for AMD Pensando SoC
>> based platforms.
>> 
>> Signed-off-by: Brad Larson <blarson@amd.com>
>> ---
> [...]
>> +config ARCH_PENSANDO
>> +	bool "AMD Pensando Platforms"
>> +	help
>> +	  This enables support for the ARMv8 based AMD Pensando SoC
>> +	  family to include the Elba SoC.
>> +
>> +	  AMD Pensando SoCs support a range of Distributed Services
>> +	  Cards in PCIe format installed into servers.  The Elba
>> +	  SoC includes 16 A-72 CPU cores, 144 programmable P4
>> +	  cores for a minimal latency/jitter datapath, and network
>
> Out of curiosity, what are A-72 and P4?
>
> A-72 sounds like Arm Cortex A-72, P4 seems to refer to the P4
> programming language (https://opennetworking.org/p4/).
>
> Perhaps something like:
>
>+	  Cards in PCIe format installed into servers.  The Elba
>+	  SoC includes 16 Cortex A-72 CPU cores, 144 P4-programmable
>+	  cores for a minimal latency/jitter datapath, and network

Thanks for the review!  Yes, exactly.  I'll add that change which
makes the description more precise.

Regards,
Brad
