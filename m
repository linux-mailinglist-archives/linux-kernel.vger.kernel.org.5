Return-Path: <linux-kernel+bounces-16976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BE38246B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 451BDB236A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3849825549;
	Thu,  4 Jan 2024 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N7qyNRvn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFCC286B7;
	Thu,  4 Jan 2024 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcmC93XmiYjDCPVwvQ0TcXn2eysQgcgBDlmiievBjQE0lmqEwDCqtOcaTBB9pXSefu3NPKHp+pCg6NcXuIBHnXkd2m/zq0t/lZ+8SYLCT7raUxeYckpN+PEbWUO2Fg3dVASVu5LSEyXtgnrrdTRZTz3h1txpz/KZupoFGap/zrIiWqLGHvEqb9WWXUC97D1OLOKRJWNusJz5MCo3WFKYd+on4klFl3o+i8/A9VIhoM9dW8I22k47bncgu0NQN+4h+D5BrbpWEQANgbN+rNnyaNPIGsrsXgsGNBUicS/uQrHdIC2wHkwW2vYe8lVEf4F/26n2dKre8ULulLeSYBMHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DWv71LqBBWyAbxpmrt121kU3isLM8VYxNCViQnyy4U=;
 b=moty6HCLFd8mLefTK1i2J61iQqh+F6HvejI8IQy2lVgEVjQK/i20Cy3gExByE2SaXX/lla6a4IK+NbTDE+q79ms4BLXm+lIDdfHrUcAC5wuN1AQ/C9An0c3WBsGCEVmpSVHYHtb9VtzfnCsUJ61MibfRvXSzBlc/oF4jhBcsev7Nc/yhPNx6etY4DlQS16YJ00pQXCoXW1SuopaPyDQx9sOB0Kk3GFRAot9Ln2ki8i2nIyWARwd6hkqPdFoa3L19Qdz1WTO2iJOBnrhARkzbyFpKluGwSH6e7yrkaG7CMy4rS9YS9IUqsKRWjPuBuOB1xKKGHdiqpQfGbLGhBwcT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DWv71LqBBWyAbxpmrt121kU3isLM8VYxNCViQnyy4U=;
 b=N7qyNRvnLHKhYkDnQpImO/tyQ+w5gvSacM9l1Q3SH2nJbGQSVLmLJwLMgiV1OVFkGlcqfYQbHRTD3ufA59xgekpOy9Hs+YZKpCQ9MgSbITdRNOqlGuu2gM3qCl0FZivmMY1xsxLh8+QhXtRMl3DW3BORYbzPQetx/PbcnXZG6yMupD84i3gB1+NpS15TibOPtxJN37VoQEAVSEal1VqzIVm9PYj++5U1s/x5ZNaBySrn5J+mo21JfbhuWQR/RtYXywL9/giIsrb0+c6UH06KypXWZW+9qvH5dRCJcQzBbxEYiLYt+1klrSakDytoe+ubEB6wnVNYInbxjnox+z6uAA==
Received: from DS7PR03CA0124.namprd03.prod.outlook.com (2603:10b6:5:3b4::9) by
 IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.13; Thu, 4 Jan 2024 16:52:35 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::46) by DS7PR03CA0124.outlook.office365.com
 (2603:10b6:5:3b4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16 via Frontend
 Transport; Thu, 4 Jan 2024 16:52:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 16:52:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Jan 2024
 08:52:24 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 4 Jan 2024 08:52:24 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 4 Jan 2024 08:52:24 -0800
From: Jon Hunter <jonathanh@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
	<rwarsow@gmx.de>, <conor@kernel.org>, <allen.lkml@gmail.com>,
	<linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 6.6 00/49] 6.6.10-rc1 review
In-Reply-To: <20240103164834.970234661@linuxfoundation.org>
References: <20240103164834.970234661@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <8bbe6dbe-de11-45c7-b16b-b94ba2ec84a3@drhqmail201.nvidia.com>
Date: Thu, 4 Jan 2024 08:52:24 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e575715-6e3a-42d2-0aa0-08dc0d458d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CrB0Hksr7IYLonPwnuXEgusNGupMfR0p9aNwBKx3Qz3+Fb/KGPFlPZ/P4MHbxRFvleMQyAw++06YFz2mAtxPVzJws8IGOaUWepnUIo0Mgu8Hs37M/OCxQsMRU4ed3tbJM9kzHvHS93h07vuvQusIFt9gCxHKK5QZ371mbVPwTm5JGRnpnvRiXrFooYB5xvLUbfDQPov+ZSYBsZZ/5olDaiezvC5VNyDPyvqohpiCdd6/vnort4zUyIuiMyvBnnQ06FMZfrl6esH0kgJ1a80YJfuJbQc8Tdw6lFLSLs1bP3Rcjl3mBZr71w1FC5TcB0p2uNB5rseyVEkpsIGgceynTmBxRV9DRxjp4lV0rlBTi73SQl3OSLjoe6vn+LSG0ZrSIw/K4ZM6eaJe+4SJCgO0J+r0zNFEiV8JEJGCii3Q0SdLpmC30mwGJ3hWdCp80QQCzXEUWpOiJgDDSVRO1qF3tTsYdaMh4lNNU/7Zodz4DDIYTuFcSdsY9OZz9XGP1YOilNKi36Z+No1fW7a/CMfzqezWAfJFDfffMdujeCCNNcqoBwLtuSveBKgWmi26O6i7yTf+xW1z8RECZ/T/H7yD9oyOp6/Hz+13m1w5goV/TrE/EDMC8Z5CjLu7dPKOt79zwDLaV1mtAeRQSl6c8RLzjXDNQuGbJnFv/EyTexmQK1vT2oRRCXv34XSTsMeZdlsh9AqRTaeuXLZ0tW10F013OZowPaCir32wg5JoXvotaN7KxoH+10rL7k49q/TUMP7sPFc9M5pzOnpbWhUu+YcUf2q2DuUaFzOkOQMMFmfL9M0=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(7636003)(356005)(966005)(36860700001)(478600001)(6916009)(86362001)(70586007)(31696002)(316002)(54906003)(47076005)(31686004)(82740400003)(70206006)(41300700001)(8936002)(4326008)(8676002)(2906002)(336012)(426003)(26005)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 16:52:34.9298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e575715-6e3a-42d2-0aa0-08dc0d458d16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647

On Wed, 03 Jan 2024 17:55:20 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.10 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.6:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    106 tests:	106 pass, 0 fail

Linux version:	6.6.10-rc1-g5fd1c89851c4
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

