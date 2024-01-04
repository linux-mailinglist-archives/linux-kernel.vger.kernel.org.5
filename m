Return-Path: <linux-kernel+bounces-16625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4905C824168
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A806AB21BBF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DAF21A0A;
	Thu,  4 Jan 2024 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m1nxoq/5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B34219FE;
	Thu,  4 Jan 2024 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COR0NAipkgicm7cMxHA6x4hXpMwnOTWQfYlNk1OO5Y5qnyBW0u3MNhwbDN6C07BzDwFSkKB9tdpM6LUwANjDn0emtDnxshi5lvy+63QoW9vING6zGbwNq/19N+rYZIquPPPxi5x1mQXNlE23pheFdwYUkMM5ces9E7PNjE3bSv/mWxnSvF0M4TmV3F5cdOnofTed4b7NhWAB5MWGIqoWvbrfHB+PxwEycreA7AcCDDSabHcR6w7wMGrgkK2EPcSgwy7fBLAApe6aMlGYEQwGM6f6ORw2lkBmpBmHhKaqDpIeRtyT2OVUk0c4fnBPhYzh7fvP+DwRY4Kfg2Zn4SgsTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rPl2AQ77mdSNtSmWkhrZaDNVmvxUOXHW8MhK7eDPcI=;
 b=OijWA4LJsCUYAORFYOpUFHf/2LJUplrT8xXvb3WhKzbV/r3C8Wq6aC/KEX2ZLskaVscVI3CQ7JqQUVAuGMng6Xxj49GHCtcY2YNmiyGT76KL7FbuLlbZTX4j/xeq71dyRciisFLuSHWo0E7lzVyLr78o4hS9PVWBjwoYkgqtYCFygoix0IewY6xg3yXGo/pD9K40nswn3mKpSHnfcUEqiIm0po+Qif42PjJ7YO9WKfCHUulnao7nzLaNct7r1BoIU2Qzg+Kww704iJ0hoDp1l+LT67AKuTl0+9aXnoU1W9b4XlOjYZ/5NoYWEcelImScP7OyiQnSqncxNxsu+rAwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rPl2AQ77mdSNtSmWkhrZaDNVmvxUOXHW8MhK7eDPcI=;
 b=m1nxoq/5PSNxBxxZhw4pxQZWR8k4u5XGU6Xbk3xksgPNbOv6QtlgNqYj4/sXPiT23nMCpnJ4QcfUlcueSe6L7P1aP0yESudjS5A7wGEzWkkl2e4v6HkpWk3Iv376IPezsUdQRej43PLgYZYYqbC3IvgIECgHgC47e+pUH+aIfcupHNqNR9tQKxL8ON7Obc8KZwasQYf/+SKC2eSGNAi+PPyeAUaeYtlDBz+LwJlizsiiR5EAe7RQuk/d9wuSffkRPJBG9v+ZEEzjCIm2dFZPkmDSRujtVdkX4dLWMj9KDdNkZOYI3HcRzO1lrYxPKzJDquFzXx3kUEyBnP3XqRre/w==
Received: from CY5PR15CA0216.namprd15.prod.outlook.com (2603:10b6:930:88::11)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 12:12:25 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::95) by CY5PR15CA0216.outlook.office365.com
 (2603:10b6:930:88::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15 via Frontend
 Transport; Thu, 4 Jan 2024 12:12:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 12:12:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Jan 2024
 04:12:15 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 4 Jan 2024 04:12:15 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 4 Jan 2024 04:12:15 -0800
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
Subject: Re: [PATCH 6.1 000/100] 6.1.71-rc1 review
In-Reply-To: <20240103164856.169912722@linuxfoundation.org>
References: <20240103164856.169912722@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <c82e1a26-700f-4a79-a995-20f44bc22520@drhqmail203.nvidia.com>
Date: Thu, 4 Jan 2024 04:12:15 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 6076a6db-1c71-459c-a113-08dc0d1e69be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GNOibgi3Fn0G2XZAPvAomqpw/BF8DqrEgvjSRqHxS/8Jg0ro41/jEPmW5a8+mngdoWSA81Xl8TtGia3likqIYCWQFhg2/AVWMPn8/e3L36QKYqbLWIA9c16oCFMBqe12dLGzyALn9ZKqD9lbKyT2ossyaI/IiZbzqsPZxzjYPZLJ6PEq3wWkt+toUJpDQ6ku/n4nUVllxv15jO1gokjBSdwuNZ6txQjoumourhQGAMyUAK1dDhBPfrIGgakA5jQosP1Dn0QN/8y+kXBO42twJWbR6O5GkgbMrG3LQpt0eGSHlWujHVVSS4gHA/Jb4mmG8EXLXn99uGUTP9LZzXs9pfrNZ/Sptj7xd9YM7I0UTfgcTzMYVLfZmDo+1z60UhS/7BSatChW5+dnWCR5FL9y9A/UfNjax/gnQxxqR3KIghAV5kXhaXTRw97DVFe3w8tCsf46eWT6WgK+Xb7hYdCLUKMtwQR0W89TU1iX9Z+zHmDJZWyiPGbgJqNxZYNRhBj/q7wtxeaQdWrTThCQNF7RJBQFzt18AEXSwLEBfgXMZXtFe26qqNZaQEbLKF/I6Bxy8swV6o+lq54EW+qiG/LlAcm2igg+C6XG1cfpbVX1ngoIc3NQkhyxK4r6aN/dBGEQa+tLrjzHdViRfUjppa6qWtPvqHROYJks0oSRaJ+hgGyNGniTNVOkohYdBS/saEVA34gHR1Qv37ZXaL8krRZ6DTHFH8+G5sNy+BwAOlogTxjlSEZha8CiB1DdulP5v2VDd3R3WODKPdBRBo55uygQXsqkqD/d5um1KAve7pklrWw=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(82740400003)(356005)(7636003)(31686004)(40480700001)(40460700003)(31696002)(86362001)(426003)(336012)(47076005)(478600001)(966005)(36860700001)(70206006)(70586007)(316002)(26005)(8676002)(6916009)(8936002)(4326008)(54906003)(41300700001)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 12:12:25.3110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6076a6db-1c71-459c-a113-08dc0d1e69be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558

On Wed, 03 Jan 2024 17:53:49 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.71 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.71-rc1.gz
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

Linux version:	6.1.71-rc1-g55d8c3a7d744
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

