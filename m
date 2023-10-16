Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB977CA89C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjJPM4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjJPM4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:56:13 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172D9F0;
        Mon, 16 Oct 2023 05:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiGB6MJPc2VdZjCG4PGRjAflHotknwl26c0g4d9+AvQ5cTzp4UCtMMzzpWe2vHHkvEhBEVGN+0ZzNu8QUsTiXPFt1AeRkI85sP/I17q5FWXCtIRi0Q05uJRXElaazjInxwg4Fo3ISDwZPjYo5qEYMNrFu5MT+m4UrxK+otht7kr8KVjGVSkiFTgqHQSiDGPj60E1bB5JtYMxbdGJbtaZ/z+tkJNagP7FJY0k/vZMnrtusdkW2xFXeWbmzVz3uBOeMfNsJBHvu5JP+rly5ERpXWZ/43ybFTvvLPkp+dWjjVFoODW0XGCdTtkPapOU4SOnBoNitWzAuRAzhrOGVItU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGZTWbe16FlEM8eEjP0poL7KwuGV9hnSbvKJqqdWZv0=;
 b=TLE1970zZhw76ie03asGZih2y08Jg7mf0vC9rzijm+nrh377eK9+VR5Uv0wf19I6I15ftMDeeKf+6dNUj69gJoYXtG1zrm0JQUqvfLmvgiFQROdA/F4tcoB+nDAv8AQhPbrJwsLkGJLIxTzYljWIYNoM+VnuPORWNOdwoOC98yL5CYz7MeL836HOJlqwoNQG0evOj5fmkrbWyfnd/cMik/AUpEEDaffe69UhLzc0uiPtoIMPyMJXgUh2xJ1eDE7oRYCxIcluzYmOXVHqrp5/MrJWwnu31B/fn3hIyoVdPmUYRfRi049ppuZmr9eQoH7yoLWgyF7OlET8jBoH0X+KoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGZTWbe16FlEM8eEjP0poL7KwuGV9hnSbvKJqqdWZv0=;
 b=YCpYcNzcPnYUczHC3CCDsTpYpiGtPl1VUfV6fzFSyaY3xhQOsNP0jqCxPfFvdaLdu1wL2b/ureYVTJWhzXY+bn237D+IdnFlFu4bWc03VbeI4EEvtL6nOMOGPpRNu9wX5iIppWbQCwX4WfPeAAODHyd2oChNVuhkFupR80xiZq6fSaI0Ep8xdikIiOU3z2XTlRiUA6cnSvbE0hCQr/Pf271D5zN0eNK6jBtLpmR2+qoz083a+DGsVATl7HcH1Y3wGwnfcm41P4UIVHCYLJ2O9UJtle1Dcstg/skRxiIsVhNpd36div/9Pm4Nu83DJXQPHD6Mn7J/QK3Rp68DD7PAFQ==
Received: from BN9PR03CA0175.namprd03.prod.outlook.com (2603:10b6:408:f4::30)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 12:56:09 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::53) by BN9PR03CA0175.outlook.office365.com
 (2603:10b6:408:f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Mon, 16 Oct 2023 12:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 12:56:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 05:56:01 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 05:56:00 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 05:56:00 -0700
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
Subject: Re: [PATCH 6.1 000/131] 6.1.59-rc1 review
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b306c0fb-36df-4498-af3d-41e7d759a886@rnnvmail204.nvidia.com>
Date:   Mon, 16 Oct 2023 05:56:00 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6f3d64-4f91-4d65-54e2-08dbce4744dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2IQNk7FihwMd4QYpN+f/73iZpULOsg4MdkLPtjS4ZXrdSx/ji5L7ze4xY1MNhYK50tujvM7lRNCE+2KKS5i074ZHdwFSxwDhYR4mfJ5nfKwKrkEyskmaAz0ul/d+xDeT0C4w9ZTMubiwUJvor1D7A+P4DHB5R2ltwKr6NJvYqZVokutz63aYku+2OrUO+QxfWPV0e5D0nFYAvwjoJ8KeZfusOrQspxXdWNJEboqkPIM4jOHWvXFEcprl9VrBaMTmJtGuNGRGa5WsKEcVuaobbGZfVe+096DMlzuTGoPtNSC5jA8xJaKyZjmjUrraDheiTFbeucDhi/d/QNtjgtiwbxKqc29RYCWhFsZUOKVhotJPuUkqobcVWlcN6ADP2RJ/MEvxKggBj+gRRMWJvaYenGq2ZsczQpt9C2BZZLVKMPdJjkciswzpoa9+wTEVTF+QW2foILgHcKgJOpbaOOvWSJZD6U87b4eWKrZCq+0hVEZOILZhr88w79oyUe+UY68c/ul6df44TX1BWiImOSf84VnaZYHJkH6lrHtmiHd7s/dGPYgzZj69LWNoReVTQj6hukYRNPl2Cd8X0sJHvy2wj9iA8/G2auJ+OrHtoM3WyxgjDmBSRPczc/q16bHiiMZ/NGC7jD7fqc5bbHNTAipwiBfgwk4Q6EWPJB3cnqgHo5G3r2BjRcYaQOHavo1aiwXveeJfuLOZQxeqAwJJAEWf0nvB+c0tTtwGk6H0hGSX0YruetfAPI+fWkPZ6GM4ESOCTSHDfiq7f3Z4FFa8mtSVjFvU12UZ0cDCgpf4V1Dne4=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(86362001)(41300700001)(36860700001)(7416002)(47076005)(5660300002)(8936002)(4326008)(8676002)(31686004)(31696002)(2906002)(70586007)(70206006)(316002)(426003)(336012)(6916009)(54906003)(356005)(7636003)(40480700001)(478600001)(82740400003)(40460700003)(26005)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 12:56:09.4941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6f3d64-4f91-4d65-54e2-08dbce4744dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 10:39:43 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.59 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Oct 2023 08:39:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.59-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.1.59-rc1-g9b707223d2e9
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
