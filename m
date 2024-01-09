Return-Path: <linux-kernel+bounces-20915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A30828750
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2411F24929
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F8138FB7;
	Tue,  9 Jan 2024 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rIfANYRc"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E420238DD8;
	Tue,  9 Jan 2024 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYBgIc0HGOBWlLf0mZkZzhejg1akTvxa+/Kt/4JrO9RY2T8VJmVA1gopZSz0glKiRF4KbP3B+fLtUwmH+aLOnw0oFk8KhQ2B2YNS9Lio0WSrB/3Ah05gHazITDXAoVXUD9eNBfLfwo374L0wRTGZjCzE71WaTKjksszPy0wozNJNINlwa5QwbLdbu7512UlZC+JEhD+3vIRoJF0InCiQqf5TaiEafWo/HQnr3Q7iAmGkE6i5bMQwJsat3y0wLoC3Y9qeT6x3Hx5BNQwHag0QTHM/Gm2b76HMzc2iq/pSgwQ3T+uz2Ck3EECAIKUTT0RYy0Okc2IRjbVuc60J4xM4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjUZT6DxswRyIMy/BzqNxgACEejcsOEWUdjAQA854I4=;
 b=efqzliE60yuFqEQAinCrDDcoh7YUaIp8cfeNiz4o2QHW9LF6oJ8V5r7Laut4LNcXPXLMgFC0y+TJ1GzGOLHiUuAGbcKdvfVUxjC6fmZZD1DzEBBcYnbhe6tKCVSp26WuWOiui/ok+RWQQ29ErWtAL/0iPXTr94nZwGEZXrSrcdo8d12tP6JgPlXfyFgC478WoTMJOREATGN4+34/RSDYqIkj69K7HaWSW0cMXpvX59iv8hVnC/IXS5LJunooaqI1lHCUXdyJOsPH6m0NmseaFjTA4yJEkuWLxRlGxBQV7EJtuBpbEqkiZpHoOWzHhvuqXpR9RU9YIR/FLbbcQFOtqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjUZT6DxswRyIMy/BzqNxgACEejcsOEWUdjAQA854I4=;
 b=rIfANYRcwWocixivatYTnYMSMmOKLpuA0GVIU4pZ637jN87V5OGikgbdJ6UhCAPxrPNZ0cEjZu/q7ccIbIpcCoi7RWtYeTEvCScpT2pI1Uialz8DjSUX0MEObgZjeREeijI0CAvio6dTUAbKZLpIg2w/mRdU38QlNAXKB2u1ALa0vLElzRD9JT3fqDqv3Ql7jL937k74KuTw+fvZtU5cL8Dl8YvpVfVQeIfPeXZDLaDLjGLD/ObDkllQ9xrKJRYTlLSWzYj5qJkgC1lQyUnJjYhwFu4mEnkHXjwQCyj23kRplvkc+fImFaaa1Q2z8L49X0rCUddXRZ4BZz+/GJ9f0Q==
Received: from DS7PR03CA0128.namprd03.prod.outlook.com (2603:10b6:5:3b4::13)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 13:46:19 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::ab) by DS7PR03CA0128.outlook.office365.com
 (2603:10b6:5:3b4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 13:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 13:46:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 05:45:52 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 05:45:51 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 9 Jan 2024 05:45:51 -0800
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
Subject: Re: [PATCH 6.1 000/150] 6.1.72-rc1 review
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <54802b66-cee3-4c44-85c5-6e2e37db0361@rnnvmail205.nvidia.com>
Date: Tue, 9 Jan 2024 05:45:51 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: e322898d-0d35-4239-db0f-08dc11195b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sAtn1Rk9LLFm5x5zNozhDEgEvzLvIg6mWZF86JbFWsPupEbNCN4EjkMpUWgp3uWPZLhqnwnveq0+XleKVOTcihcycoynrt+ZnoVn1LiW3V/YeNeEMAIIg33Xr0ptkQ+JPoPccQehCIV184Gv4QpA8KVNvBpwR3kjiFhV3oxSVXnIOu1eTEYJ+SYfaQ0lVjlhp9ERZ3jgJdu+RGnbBgs1pvVVplxp9wiVmc2buAzktJtonlzDHKlUekSYBL1OgRdJTj12DqhEMAoSKjNtqOcaLWIrptb13/tl1WWFxPXIRk1Cll3vTWmq+NIHQjPiH8INaaniAZBXzbwBtf6PuyGS8E+cbL2pLBc+wXuit1GAmPQMN3NWe124f/0i2+6sJ4HcKeR/MX1WpjU93SqEybJaMKtoUjSpT35QDqST95hO2FKlfVGkNnCmCnrnBvpObzCc8ICCYezYV7VWQ63pFxPffx+2Kpftl+37prLtp5bDHIcxApa4KKbVO8MorDq9NQR0X57WS5fdTnZDvu4eR8zsT46Z09UxDxUJTSHPDGMMQSKiEg86uJCaDyrtoWOUsvanXXo9bQaWUS7nAxDjcG/zzVwKwbVuFpJ4HHUca243ahphL47eNjtud0guqJBsgMRQSmOIFReIO2M7KOrM9ViY/c9ybEhrjaEwm0Xbph82BcxS6Y7BRk8k73wENQbcLZeltrHVJy8b4Zy9qdDNYuqy2ASGfY7ScmtwJ7Fh/aZAemd61JXV3my1rceHjFVg9nkUeJMpWboihVm/8pKyd6yZHFrisxXA7z9rs3HBfhjSMfs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(336012)(426003)(966005)(26005)(478600001)(2906002)(5660300002)(41300700001)(47076005)(54906003)(70586007)(316002)(4326008)(8676002)(8936002)(70206006)(6916009)(82740400003)(36860700001)(356005)(31696002)(86362001)(7416002)(7636003)(40460700003)(40480700001)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 13:46:18.4848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e322898d-0d35-4239-db0f-08dc11195b73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670

On Mon, 08 Jan 2024 16:34:11 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.72 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Jan 2024 15:34:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.72-rc1.gz
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

Linux version:	6.1.72-rc1-g28e6ce52ce18
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

