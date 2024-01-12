Return-Path: <linux-kernel+bounces-24751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BA682C1CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAEC61F249ED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EC56E2C8;
	Fri, 12 Jan 2024 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tOfZRD9v"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F414C6DCEB;
	Fri, 12 Jan 2024 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmyPuvGHY4OI1JbyJDXuDgFwaB8Yy48BAWdP5mBMc4JodqXNnccwax88HRqlrDTqoNZJt/oOdOFOVj8Aj5DHCdc8LAqpQEMSxsphccZV4xX7CaIE4Mn94r+/C8kz3CeFDyAV0P+BJUjU57VtT6BJsfBgWJGNmJD7Z14qZLL47/Ymagc0arqJef/Ym/vqtm3sMsrqsmX5cVlX71TC7W8PqnK3U/NlCns3vslDR9jhtG/mW5k1g5ZzpshTeqgnQ1y2zopsSAS0cubQoihvHc2BGWDK6qbZOBdumXSOFvpZSIm8k0SN6HSyzNRVPG+X2yNYzNRZOTC2+BUFxVwUokCvcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fISCV+I/C64XNPusOqnlTMPROHtFCHOnwaczqIvdW30=;
 b=HsQmmmMAdbtUlvpubY5QPp+k7pjm1eio1XhfKwSqwFU0n/VVxhe+aPnne8mtDSJObwyx7MEaugfXYOZfhGZdb1MzQlbjLn8YxNbH0VzVDSxB08kEaE1Wl3oqwVvNF0s7LIU9YR3xh0qI3ukSXGKreEUHx4S07aTR+/Yi5LOeltx29no3Jy9c9DnJ7AhSoaLoeD+VzEXffcbsdcc7gY/iwTHLZqP+mCGQvjoxjUoR1ZaVCSnADa+T/NQGXpzs+k9i5miBMC+Yv6hdQImh6oZ6vp5K+YmHoq9XlwE3VTsFYl285xKipNQvktDhV0cs777UxUgHVVp3qBFhcujFTMaQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fISCV+I/C64XNPusOqnlTMPROHtFCHOnwaczqIvdW30=;
 b=tOfZRD9vXsJbBho0W9D1GRWhKWpVrV9znyHrluIsUrQX2EW/XRaclrhRxmzh0yzQbM4RkiQuukot0yL/uLa84dsjJyU6OTzw0Ad7t0KmM3k7zGSPvid4j0z5kNfhLEaHe8d1d04UkTyePOTZP5+On8u6KPWuuSdecHO6iiyT+uLBDsyOpyEmVP2GURiXmUxtiEj9la3ujyaasvNl5ve+Qvjar8ccNQP4OysYvP4veWDUXvl+msKTFEf2gmT1o+1sFwebwSR5h9ZU6H7o8lKl7L93GeH2o8hQfBJZWECUx1nxI2y6usrkqmhOD73uMTtqXEHIMBHJwWx8ggu0ItvdKA==
Received: from SN6PR05CA0004.namprd05.prod.outlook.com (2603:10b6:805:de::17)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 14:27:25 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:805:de:cafe::41) by SN6PR05CA0004.outlook.office365.com
 (2603:10b6:805:de::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.13 via Frontend
 Transport; Fri, 12 Jan 2024 14:27:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 14:27:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Jan
 2024 06:27:08 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Jan
 2024 06:27:08 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 12 Jan 2024 06:27:07 -0800
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
Subject: Re: [PATCH 5.10 0/7] 5.10.207-rc1 review
In-Reply-To: <20240111094700.222742213@linuxfoundation.org>
References: <20240111094700.222742213@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4b833322-3722-470b-99a0-0be4c6f2abab@rnnvmail205.nvidia.com>
Date: Fri, 12 Jan 2024 06:27:07 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|BL1PR12MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: be2c8de2-9238-4ec4-dce2-08dc137a98ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cilJAbPWMkAwG30t/BjeND0XMbuaZnD9Bzp400Tr9CyiYc1Rh3ko7ukoBBHURzKl5ZzKGxavG/fAcOzqw2kmaq9+ZCldz5rRYH5QwzD0fJAMGr3uAwQ7f1p85UZLsYZL/bS8ovOzzemcn7KRP1AhtSjU8Woo9lrcxsabda14u4qtV0F0H7TtiJvEDxXMwvkw3Vfdw7BwLTy+JfzTMR/RIgHgDjEfoLDqEKYXQtREQ5qbvyt0zGBVu2gAbbDAyQk8wRfj+0PiJILnjg6sq/n7E47E0sloNZt+dKo9h+dgi9MVUsv45yG6EqK+W+Yc2QLNXnXDWTa/jtTG7tISqctVJiiiRMJcY9nnRH8NRhQP7xhyaFvIovlesSNw2mos8rcHRCNf8e8ILQbeeJzxC2ieEGqiWmcISVr89g+l8p57dhmRyj4qiDgbycw4X4XaCt67QjC07YwqE/Ggzux5JL7q7NYQZttB6R29d+cqArt0Sfhf4lctx9EIEhd8wahpjG2B8oQUnVYybC6rOQtn/R1Pc4yQt/62msRnDoDctcoGqLCW5DnU4aBTp7BBgVBhuIH0hhbeKvjhZMLd35/Xiall4BCLzVJ/4D5Bo3APZ5WAEJV4JIof9QxQhyAN6KijCY5Lfc+jI59/qhaboIq9iez9zdyDwpGR1HmeQGyH2xutK/90ENx+zDWL/EyPHfHJAccCc5NJsUDCfs5nKIuuV15QEidzvsngUdH57+47LXRdyDER5xoSKdfMt8+zV1y7nFmnjk2vVJKlRYxvEpDvPAEii5eDenC0T97LQ3J7XcV1yDU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(31686004)(40480700001)(40460700003)(7416002)(2906002)(5660300002)(41300700001)(478600001)(4326008)(8676002)(8936002)(54906003)(70586007)(70206006)(6916009)(316002)(966005)(86362001)(31696002)(7636003)(82740400003)(47076005)(36860700001)(26005)(336012)(426003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 14:27:25.0828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be2c8de2-9238-4ec4-dce2-08dc137a98ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160

On Thu, 11 Jan 2024 10:52:49 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.207 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Jan 2024 09:46:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.207-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    68 tests:	68 pass, 0 fail

Linux version:	5.10.207-rc1-g9d64f2ec9cf9
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

