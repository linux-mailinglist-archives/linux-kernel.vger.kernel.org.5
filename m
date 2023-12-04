Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A76803ED9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjLDT4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjLDT4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:56:18 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F3CD2;
        Mon,  4 Dec 2023 11:56:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqZcyp+w3Jn1atJLSfPvk5AoUviEDt1vUzJFB56ilaLRpEbU/WQ7RqryeeAX/M92pT3aFaLIb+2A784gJ1LX9ncA4meI+46b19UAy/a91ThK7CGmAKy53avHt1Um/ByCH+mHalzZNH8m33HiVh0Pu2atSk2Q/qFf6VwvDYhPBJxzpQtg7y6y1Gf0177lRrx7IpDUdeXUAG3eGuqU5KizKBgVnx4xCtomdomHsv0Q4sT5UN7T74dGSmPA/z1BrkcV4U3d41Lhm+IKQNDcRmFIm/XLW6BfPlBcQP7ej+EP6WzwwE69vq0dZlA1s31lkpbrXLB9VEqOMCOFLMiYCy5uNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqFWTFXSWKEeNsJjBnYPFFSva2Nwz4lDdeShJkKwVo8=;
 b=fn0wDKSULJAhyaHXG1OrwXtPm1n5bQjvr/FcMS1xtgWKDh00ILgNBG4dx5uEuYnimFfGkVW3fn3q2e9xPuV4VNQPXoGGlI52Pz29wmTIWugpEt5m8N5jKcY7+JuwY32gpMok91vAnygNVTjbn6mhNBSVP+W3sCeRnEvH+kvb9hGWsxrNwHKYjd7PSY6jUMXruk787hN3edZkeVRtLb3GPs3VHTxLZ2qT0n3jq8KmXrupWGic6lxCUH8T5gRM5sy+O6LhlLMK6x65q1fhf0IpmcMpKoMkg8QInfeHDVTiz/t/JEX0eIwxrpTtr9rOfCv1fIYKx2kQeeRSCpzgyulOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=suse.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqFWTFXSWKEeNsJjBnYPFFSva2Nwz4lDdeShJkKwVo8=;
 b=G8NTCiP/NyEbvvBsvvo20oaZZia4lRaM9gDd5qALJvAbGpEDebMS98GwsK4c5LQGc/nKy9jNzVN4ALvGz1jBThGrmPGgCYGvMKY1u2C4mDh5f1n5EdV4BNYmgdO21U+oaGfET9h8qBUI28cCLSTnHMYD4JxOtabrVhNTFfUte14UuttW9ffhk+PvHAWp56Ww1TQtnvTXKg4Fu9VqOsHsJuCBIfpNH4VZjQ/UB7XHj7yBODGBlJ3/bJcGWga0HXy2x2rQDJoasXXpGPmOEFxYD7S8AKUmrlA2fXGJQnXrEjB0PMH+lz4WGZ3e2+cVlt564qpKmtWC3Q/EQkyCCI0OoA==
Received: from SA0PR13CA0025.namprd13.prod.outlook.com (2603:10b6:806:130::30)
 by CH0PR08MB6921.namprd08.prod.outlook.com (2603:10b6:610:c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 19:56:18 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::93) by SA0PR13CA0025.outlook.office365.com
 (2603:10b6:806:130::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.23 via Frontend
 Transport; Mon, 4 Dec 2023 19:56:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 19:56:17 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Mon, 4 Dec
 2023 12:56:16 -0700
Received: from [10.3.111.233] (10.3.111.233) by
 RestrictedRelay17EX19B.micron.com (137.201.21.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Mon, 4 Dec 2023 12:56:10 -0700
Message-ID: <1db561a9-6984-418d-9305-a2a5ece93696@micron.com>
Date:   Tue, 5 Dec 2023 01:26:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [RFC PATCH 0/2] Node migration between memory tiers
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
CC:     <aneesh.kumar@linux.ibm.com>, <linux-cxl@vger.kernel.org>,
        <linux-mm@kvack.org>, <dan.j.williams@intel.com>,
        <hannes@cmpxchg.org>, <hasanalmaruf@fb.com>, <haowang3@fb.com>,
        <ying.huang@intel.com>, <gregory.price@memverge.com>,
        <tj@kernel.org>, <hezhongkun.hzk@bytedance.com>, <fvdl@google.com>,
        <john@jagalactic.com>, <emirakhur@micron.com>,
        <vtavarespetr@micron.com>, <Ravis.OpenSrc@micron.com>,
        <Jonathan.Cameron@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>
References: <20231130220422.2033-1-sthanneeru.opensrc@micron.com>
 <ZW3zl2Fke5FtQCv3@tiehlicka>
From:   Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
In-Reply-To: <ZW3zl2Fke5FtQCv3@tiehlicka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|CH0PR08MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 98390326-ba47-4410-d3e4-08dbf5031427
X-LD-Processed: f38a5ecd-2813-4862-b11b-ac1d563c806f,ExtAddr
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjuN/uEFYikDgk9nKmolzClgrERKdOAXssMbsRHj3Euw7I7Qt2TSo8UhmmZD0mRFHuoeJSPkc5fzmbCxom4Aexm9fTQ/CI5uHXvNrEmQLdKkn6t4YsChdcXUgiINl3GFt49MTIosIOVUFkGAItMdru7vGZxNhtApPUzwcrtyw7LmCXvfqRpXv+dnwtk4Nbun3DbuhHAtWSO8asUtim/sK04j0+Fv5/aYDk9Sp7a7VyaNl0CDRrPO7KSwcxEuvVngLQHIdJtrW1EurkEI5JdzcLxxope86yixxqnmydtu+zeDe7NQwi/73oVP9NMSDCsA734POPEx4Y5i90weMgshFcJ7N7rqCUBoHXD44CfAG9YdN6/o/myDuKjA+UPDLlTgGaBtpZNTWQ76eOXuk+9MzFW6qayCcrqUwosE11zhzZ0TCoI411+jaKnxFzGGzsleVP52yeiD/41ccnqNtnh8YcGB0W8cG2imLaSLa4BYlMLQI8v0nJDE3qKNP5NnRkbAjeQbpKZGQppQFiDZb9zhWzUAlpxFs9ZRzhBkfnOXncWdtl0xnZDMmRWbrMYJQMwgTJYnrR0RrXL30WO0ZlUS3qq1dXUk22kr0MnULU4QUPZbm1PEVRFlpIIVAaLCmauuWmCIrLDzGbk89dDaGCmSCNp75NM1HUEOoL2rUR7LbexE/TjIeBNyDzkLjaoq1j5oYtuBJI7yLZUbXtEkDI/NJScVHvxjHiI38VOM+gNyScqhOQ1HDdtSXGfz3C6h2HccVueFM2cXqc2s/VbHx/4txNxH4RSIu6xjODalmI7vE/bNzPi6ygf0Ovnx3bIlBILo82m5vmQ3DxSLUhIP01IcIvi4p8DIaKZ4FZ+infAtm6E=
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799012)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(336012)(426003)(83380400001)(82740400003)(478600001)(6666004)(26005)(40480700001)(53546011)(2616005)(316002)(4326008)(6916009)(70586007)(16576012)(54906003)(8936002)(8676002)(70206006)(31686004)(36860700001)(356005)(47076005)(7636003)(5660300002)(7416002)(40460700003)(2906002)(41300700001)(36756003)(86362001)(31696002)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 19:56:17.3981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98390326-ba47-4410-d3e4-08dbf5031427
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR08MB6921
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/2023 9:13 PM, Michal Hocko wrote:
> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you recognize the sender and were expecting this message.
> 
> 
> On Fri 01-12-23 03:34:20, sthanneeru.opensrc@micron.com wrote:
>> From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
>>
>> The memory tiers feature allows nodes with similar memory types
>> or performance characteristics to be grouped together in a
>> memory tier. However, there is currently no provision for
>> moving a node from one tier to another on demand.
> 
> Could you expand on why this is really needed/necessary? What is the
> actual usecase?

Hi Michal Hock,

Following two use-cases we have observed.
1. It is not accurate to group similar memory types in the same tier,
    because even similar memory types may have different speed grades.

2. Some systems boots up with CXL devices and DRAM on the same 
memory-tier, we need a way to move the CXL nodes to the correct tier 
from the user space.

Regards,
Srini

> --
> Michal Hocko
> SUSE Labs
