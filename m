Return-Path: <linux-kernel+bounces-20914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EBF82874D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9111C23B5F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338B138DD8;
	Tue,  9 Jan 2024 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tBYItdfD"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC886D6F9;
	Tue,  9 Jan 2024 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKsBP9EkBrVOAzWGvswHnahmrRckZSWYvPacsRjUpC6elLKd++eayGJNjFr41rWFxfOcv8ahOfbmbCmdiNehN8ZAib38UrbF5V8LyTiUvIQxqYjdJmpu2itOCpsDQYemO6/qUTxK5+CIGmvK63AGf3+IoSgWD6uEiFa0AfWzF4TE8d3E7txQLndvPkH1PublwCmYVQky5QjY9tRh/0J9ypo4uWU/ChrST64CLU4v5BBJLugq+68RAfK+pZvztwX0DZnmy6Q+1Oue+BsN3rSRRDdnP328GeO52aScDcb8BaY2nYKBgnD+uhz9rUX1F6L3QRdZ9lNPZC9yN+1guZIB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVLoRuNhJ7pkQJ+K4HQR8gG1ImxeEAexoE8gUR/q09o=;
 b=Q17Yh8fHWRqrHfTSRxFMC/2JbLTbZNf7NID0m0S5PzeQAhzSUM+rVMPlt+ZPsrGu5D7IM3MpDcDmkA9s9wc++Li5BYySeRfgveQF4IFduvHoZ5PqC/JKePq/FnLEDETU9/eII0sDCe9dP6TmoZmnHgp68gHjOdD4OM7RCQPFAkHXP1y1bUwinylj2O2FWqkzn2086OLRDsbRHC/4tj3/+vd7dnSkObtE68xV7pKMveL9bQKllLfa6BI1JtqffirUhGmIJLWKGDt1g7+Pr+wV9lSynHqeLTBs4sVdqccbz9oC5NKprrWFEQnDdwu11u15baGOizNGiakuTi4r577n8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVLoRuNhJ7pkQJ+K4HQR8gG1ImxeEAexoE8gUR/q09o=;
 b=tBYItdfDGQI+9oXJaEfkMaNRi5mGmkSjZsabqCrafZysvRZAQThLHRC/nLJZsfhcM3jItPNcLAbzsKZMsXCXIYyqptYVr/OUefxLY8tI5kDMGhZW/d95nfKxKC0iUwHeE+aEyME7S0K8EVunIyG0CuRUTAduIEfbM9B/9lzTCKJI7gDta1rVGCYEOSXS+xb7QH7YWUu8SWT2hh4nvBQMNpdxKoXItYajUaLsX3KsXXRpGmp2uOG5LpcbIjYOyBNMJdZ6OFPdvDDo1wfg8gGxeQGyrvv24xPU6VKR+BQhfR+5akRlxO09t1oMFrFN0ewW5YPWlia1/M1LWXyZlp1fdw==
Received: from SJ0PR13CA0225.namprd13.prod.outlook.com (2603:10b6:a03:2c1::20)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 13:45:23 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::fe) by SJ0PR13CA0225.outlook.office365.com
 (2603:10b6:a03:2c1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Tue, 9 Jan 2024 13:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 9 Jan 2024 13:45:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 05:45:06 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 05:45:06 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 9 Jan 2024 05:45:06 -0800
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
Subject: Re: [PATCH 4.14 0/7] 4.14.336-rc1 review
In-Reply-To: <20240108141854.158274814@linuxfoundation.org>
References: <20240108141854.158274814@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <d11336e6-14f9-4fbc-9480-718d7942b597@rnnvmail203.nvidia.com>
Date: Tue, 9 Jan 2024 05:45:06 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: e8cc0195-bf0b-4d21-80e4-08dc11193a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5dADAAAmgTIh0i4NndXdJC7VXQyyxHs3HmznUO+wg0YYUmA0Rz6Mm29rtfAPgpMPnB1cp2unj0e5cowsqGWQFl7BQuKCMXkgYnqRyfqH7cCfs0ELImDlPwpCNZrqSWz4TVvL7pCA7PxYTfvsHN7SDy04NSNIYZVlPWIHSdtD1Y6jWeUNAoMngMEO8tvEMcIJVadhRFtF4N+FqC3LVGByoXikSQEb79xxpaHfYGidYOc7qwduJ6HEEMLJd9vjdNBAQIrVGVZm3oEl/9yNT4hIOyg/AmDi10Lq/5FNPNZjS6S7pPDg043nY/9aR6rHKXDASLl/FoIdoxtpQsy0WOGae6Ejb53y8Zus3c0UWNn3iRl8zP3kVV2So83gGMfRePrx3rEwWyJtKH4AlkB5XuAOyYXIoCXNuqNNyzkxUEw6CqaeQAZQYqfyrl+dX0FUwNmZEHywy3NTBZpEb0AoHp+MJzxxkFQX1y4aZZM43Vc0gsPtLYQ/sBa4AKusPZtc9UPrwTpiCArUeib49r+VpIBmp5NNoVEf/I1IAa5yvSnaD+ND0rK+9aqjTSxcPi8oamsIwn9/+CI8eaGUzb8DqnGfl7KrMXkCH3Zw8XKMv1AYhG+oRDxLsPBKicN5Xxz2qU1o0C5liNQssHgThnu2uXd7IBpX6NmgYnkfrKMqArx6GKvt7u4XQlAXNqE+6opXm5PeyBt6L0p7TJhshBigxUc58B+7lKGalEpB4rDIr0/GS7o0cc5cW7I3wIjX+9q8cR1muI9l8nZ1kGXVyXUHMqp7rBlt1cY7Y88Uo4KyK5D1AmM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(2906002)(7416002)(82740400003)(5660300002)(86362001)(41300700001)(356005)(7636003)(31696002)(54906003)(31686004)(36860700001)(316002)(336012)(426003)(8676002)(8936002)(47076005)(70206006)(70586007)(40480700001)(6916009)(26005)(478600001)(966005)(40460700003)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 13:45:23.2810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cc0195-bf0b-4d21-80e4-08dc11193a80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581

On Mon, 08 Jan 2024 15:21:54 +0100, Greg Kroah-Hartman wrote:
> -------------------------------
> NOTE, this is the LAST 4.14.y-rc release cycle that is going to happen.
> After this release, this branch will be end-of-life.  You all should
> have moved to the 4.19.y branch at the very least by now, as this is it,
> time to stop using this one.
> -------------------------------
> 
> This is the start of the stable review cycle for the 4.14.336 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Jan 2024 14:18:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.336-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.14:
    10 builds:	10 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.14.336-rc1-g2025e3e69905
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

