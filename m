Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7D278848D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244058AbjHYKQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244365AbjHYKQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:16:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F152268C;
        Fri, 25 Aug 2023 03:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1KIEm4qIfGA/yTeTc6dwy+qJ7I31hGOILeaL8CeTTom2sIoVLYcXXgEx6r+qLw9YxzSdm8QmnORhYKXwnpYS/3wUNL+7iE/kUFSjSsX14CZk5yItGm8gX78BKcv7D9Cl0RIZYvpPbArvoYb8T2QoTBelJKJ1i9yYf9+1HpFU8RLiyoRfCXLKma1icAQCMOGWbJg/UA+widmBxX4yuq2kmJ3p54W0uTnqGSsvGaurcKxF452sxRbNlxdEBH8IR4WX/+oT3r+2mR1II5Rmt8e+n6dybSVHlz1SeUdX/jAQXlVEruIbZkhrfV2OWaFLymKOaeVeG+Fc2410HXYcWYesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjVyQUTxHRU8sEHF5lrfyyyOgfhCeO29y8uxEdOyy/Q=;
 b=QFD4hwZPUBcFwO1vB2BgXly/5jimLM8lkTqD+mDVoIX6jS9/Sm4sNZ4C54CB88AMlkIg+KPd2RNpQ+uBrlG6CUMoMr5/eL0fQAVmpe1ruGyj7FS/2b/nKveonsD9Z3R8ZLWzxrTfwKAz46O7OwCMc5Ffk4djsN2xcckLU9b6HZ6EvIlbd6OFBv/uLU+h0pZ2pvVjJBLU6j9hVImhatrm6bXKk4Sfw9vAxUoutXv9MY07uvyyIQ4eb9R5NJEmdn5wk4DlW+ektc2x0m2xZXLTDfh5cUFoydWjw7PhkV3HA3pVjHkC2HaotD+ZfXjqXtv/U8E58H8WcNTYrGOzFErabw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjVyQUTxHRU8sEHF5lrfyyyOgfhCeO29y8uxEdOyy/Q=;
 b=VTAHOsjqZ7KYg7MCuKA29OpN9SQfxDmFe9cAUoCP+a/2WcX6Er3xgSdZRbNYW+bJBKNHCyH9pkGURedFwy7+MVbJmTVNQemNh1oEtAdYLKKPJpHCQzRx25xh3NnYdAnLqCXJQkNbFaObhRdRVlwCIlrD1UkPfaMQEO+T8gCx6P24oKTMRzaK5CwE5cLKpYw3qZh8F/jfjwBsgb8g7tdUHCNNnRdxGNIxxr6ZzW1MyvWlLfGg6zoTwrfKGehYUjFr0oe8uPZpxcp5e/jX3y8bLbETa8EeOVgQPZYcZkhcMrom78t0pibDiqgTgnMs3KxiUu31whqPiM83USXVjFaPIg==
Received: from DS7PR05CA0004.namprd05.prod.outlook.com (2603:10b6:5:3b9::9) by
 SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 25 Aug
 2023 10:14:46 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::9c) by DS7PR05CA0004.outlook.office365.com
 (2603:10b6:5:3b9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Fri, 25 Aug 2023 10:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 10:14:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 25 Aug 2023
 03:14:34 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 25 Aug 2023 03:14:33 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 25 Aug 2023 03:14:33 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>,
        <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 5.15 000/139] 5.15.128-rc1 review
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <e0660126-7a7a-469f-a758-a66d4e72564e@drhqmail201.nvidia.com>
Date:   Fri, 25 Aug 2023 03:14:33 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b3f8aa-6877-42c9-30af-08dba5541b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOVp9gHXCqEketgYUq8/zGmx6Km8fuW5tQw65epAg1LnE4gayCezfQlinc/r/UQ13TRKcB56GiabV16HsBQSdN6H/t6o8AtBf22jbaODyoC2hvzxACSCNVGNb8eY3mTi17MVLFRvMub8jOlFyBz9K2oj/RZZHjGY3RuFvExiaSh4iMyHgNQ6RgsgsHAYfM3gHR0OAXQ15LGj0JFhj13TyDTTW+00KFZgkr+6kt0u4gSeBNWW2TYGj9ASv0hE9zoAk77l1miZYVfrGxOy5sDtsi4M5Qz58pvMZpt4Li+I7k74xOwVSJcgCYQFvE7AqikaI6rApe7hzL3PJ7cAI0E8qEEq18+v5y8kEgssyKfArHWAR6d/r2d1mSDXDA9vtJ21F/dB1Qdcx1X463w3UdiSngs62up6d/W9+9Gk+CcKNqWlfZaZvMV0km+ZQKbkb484nMbXcvL5xh8bAdKiKb8E8CHbiHV59SBLnL2cCjmZqQq6Kr4Bv/M7bPZ00rporr/jTeisSPihtNgUqub+JjnbR7PACDknHq8BfqykfGtKBrY74Ps7SZGtrsbluF0bkQoDxSG9HtQ7NDtLrW0le2kQcCHNtwDDHBvSV90HRxRu5TxTDOsgJbI2qaiW/f04pDx3hzeYOf7DA/j0ZAX25T1nWg8KjCyYca/eq4Ww/ISRC+MrCrI2DRhAOCE3L6ueA7v+FHxUgjT5QjbB3IVbdjOVA1kywsX/7aIg9vYOQsNSUJjn8Hq8qEh5fF2Q/004O01/5RZ/mxjyTTsaoMEC+EsmwnLFXzHGp6naYXAAaqysZRM=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199024)(186009)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(47076005)(26005)(336012)(426003)(86362001)(31696002)(40480700001)(356005)(82740400003)(7636003)(36860700001)(40460700003)(8936002)(316002)(8676002)(41300700001)(54906003)(2906002)(70586007)(4326008)(5660300002)(6916009)(70206006)(31686004)(7416002)(966005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 10:14:45.9734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b3f8aa-6877-42c9-30af-08dba5541b86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 16:48:43 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.128 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 14:49:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.128-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    114 tests:	114 pass, 0 fail

Linux version:	5.15.128-rc1-g00e5f0b76767
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
