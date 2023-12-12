Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1111880FA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377789AbjLLWVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377700AbjLLWVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:21:41 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238B3B3;
        Tue, 12 Dec 2023 14:21:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6o868zgUQwN9/sClRajZbcrywa+489hikhtCQik3UFQDnBB1hUF2rw6balhfkwmPT6nHTB5fKLrb5T6ITa1VKoFa14lcu4fRqnjrgeQPsI5WGA3F/v8csNHqUioe99FMAp3OAk3krO1v7wuTVlUKdhtjBZqq4AeSSxob3po3XDqEiW1G0WsnGPd1fxE1m1JEXVcT4oOj4xpJvRo6vRoKdjaZ7boJPtAKTh5NX2dKEWNQ3OvVk8Q00RJhHNEqpl1IE2YN/aiH3HA12KbUtht23DBFMKJ/wkXxSZVRIDldSeWQ7Wraj2mM+SwiHSUyxq8z0NxEdnBL1rXCMdPaHAISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/9BJfQjX2OyiRuui0V5zAo2yD76VNhu/17AJDcoyWM=;
 b=O2tkxgenECqY3N+X4kCKxgGKAbX1pbU4zCJR3aLWjtRZAb6iOIC0e98ZmjFFB8SnfC0qa/kNsaFRTAFgnlwDpbAyicfMn+kSn/auhZ9N/meP/KDI6YvjgZy4OE1V/NmMUY0sfqP5ZxX7CtIR4OPvJAQPX4h9nGGfZwXMroL4aOFjzANL64GeKJqtYAxXXpKu9GrPlAyRoWSSmIu2z2J0phGrWilb8ZVoG90zTiLY9DkxI0E3qQBR/Or+C2fcSVDj/bPg1XLbxueLPGxsqanKK58UzHTfJxD8SELA2SLRl5pjImn3qE2kmvCnU52THr76sCkYA9j7crTYmpldTyvLHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/9BJfQjX2OyiRuui0V5zAo2yD76VNhu/17AJDcoyWM=;
 b=MmM75xFe/aFQRn7mILrmTSYponHIfvln7vT2qs6zmiOkvtOpVsrVy9mMLUFEziDXvtWzxiSCvfUcg4MGmRvjOiWPxGzEyjOC2n/9EyPRDmWsjh2YgNH9H5gcbOeHxka2l42rVmcOBRZfhrdEk353A05gnwSAji83B3d9AK1BwV72OhG6cDLWH1yR2JIH6jB9AstSaNlbYDGjATjt4f3XAGhI4t9Y+3x6m8i+FSsqu6nat/DktZ+pDEzolql5BrekmLIaB9wqb2L0JdEPZEwAm3exk7fDRtXrRuubPhxnkkkH42hv7xn3fHnbti6UATJWDulgHT545txRTGqfy8OCxw==
Received: from SA0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:806:130::14)
 by BY5PR12MB4872.namprd12.prod.outlook.com (2603:10b6:a03:1c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 22:21:43 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::c) by SA0PR13CA0009.outlook.office365.com
 (2603:10b6:806:130::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Tue, 12 Dec 2023 22:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 22:21:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 12 Dec
 2023 14:21:20 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 12 Dec 2023 14:21:19 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 12 Dec 2023 14:21:19 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>, <allen.lkml@gmail.com>,
        <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 6.1 000/194] 6.1.68-rc1 review
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <d0fe9ac8-ffd6-4232-8d15-85d8cbe08f72@drhqmail203.nvidia.com>
Date:   Tue, 12 Dec 2023 14:21:19 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|BY5PR12MB4872:EE_
X-MS-Office365-Filtering-Correlation-Id: fc995391-9e6e-4e06-ce37-08dbfb60b8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rVA8Al2qKg837XaIY543uLgyRomMrL4hOWqfL1jcvE3INtutDK6QN5FC50ULSahHN9mhNVYXklbYKRA2njbDgwCBuHYTF0xN90BV58oFq9EqfgHZm//vRPdpfgc6QXc3mBNKneRpgitWdhivahwUlIEzb6sfquqAD0Zb7wMZOuiAniPRO28Ku1s3E7BpEl1v3akR1ux0RHJFuNsKS30PfTgSCpfwvWT7fC1RH11+pz7Hgr4TnfZC0iXAKjvBR+5+gWi+EsHYmTlr2lZjBleldSeA3BsyndehTRNp36uK9fnGApbKCz1mDae1i/pRnzoX6g6eS19WAgFcRdaODuF48zADW1k4bY3HVQgdXYhEx1pWOfDKHJzw6slYDyH8qan8YbAUVsXQ8HFkjBcBo3RosuHMJFX//yYfaKUko7v+hcacDmBeN2wg3vElE36uA7STPGSbUUGpVtjziQUzY2LNhgaHtEyKVLGxP+XerRd/oxwk/o9Qm5RJpyfoKIstNHhbq6CO4sGXpQNzW1sHro1ENd7EtYJR1i0AaoplPdgJ73CdbEWQM1JKhDxzpFkbDvhVM3iXLEUcwmwuXNIxlBNjUmwPD6vddTy/cQuQc9t5xxsz67Gx+pyxTQ+PSHhghGB+tSNHKDS9c91VMZ5hlv+UNrMFJynDw6R0m5lwpmW8WPCwNkgiqvY6n7zSYKGtZrk7Ip5WtV6ZkKYIiWUUp5juskhjsR3j4MJ5kvqzrJO4vdQ6M03mHc2PUDWbCqLGTLp4xlz9rqELoPXfYU7YNaJS5mO+3eiQ+ieX6Lt1/GStSBs=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(31696002)(426003)(47076005)(36860700001)(8676002)(4326008)(5660300002)(41300700001)(8936002)(7416002)(478600001)(2906002)(966005)(316002)(336012)(26005)(86362001)(54906003)(6916009)(70206006)(70586007)(7636003)(82740400003)(356005)(40480700001)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 22:21:43.5441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc995391-9e6e-4e06-ce37-08dbfb60b8aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4872
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 19:19:50 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.68 release.
> There are 194 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.68-rc1.gz
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

Linux version:	6.1.68-rc1-g807435a379b4
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
