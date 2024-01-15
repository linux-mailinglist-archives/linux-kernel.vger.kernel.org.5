Return-Path: <linux-kernel+bounces-25884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2461A82D740
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9F51F22148
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F082C69F;
	Mon, 15 Jan 2024 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VgM13D+G"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A262A249E2;
	Mon, 15 Jan 2024 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nxnf6nO3OEOiENBTqB5r0puMW4ShW4JIdAFupFYtnFVe9znYQGWaRcf7eN97LzBSyIeN/idzgeIa+dE4ZFs5d3XlMMFADCVzxmMRMIsJ69XExUTcgph2qXmgN1/5li5Cz0W6Bj+bUxE03+S1R0X9eHihEhsgpgpQXNzT8tCcrbStnhf0n8dr1dUdhkE2vlBNTdo/TG+Wc3fPxPEIRqN8sb3LOUnt+wNvCpnsr7WlDAw5bL+fsZLZq92acin+TVbQbCr+a6GBCtIwDIjMfNld267f4e7ncycJqKsh8gSg7/D+QH/JOUWjzf1FyRCnI3NllxoUbJHWcJFDp1FgmVSazA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=futRTkGihukVbLbAD+IUORgmi71/k2+T2ETRR97by9c=;
 b=UQzGnG6ZIOxeQoryDKaeL2MRxzhLq6WMjAVNwO5wijS7t16DY1P5ddTVKB5v/ZHi6gRXHud6bUk1xCKJ9rZs3VbB5CdMJY0M7BlI/gq6ZwW5u3mMnd3iAXuHotgPn2C5lMec0TnBCoXHuQac4EPBODKoKTSHIJD3lPb5Rjgnt77Sqsax2+Mn4W02KIA2xSA+XGiAxHphIRk5NbVp4taZ7kmZT2Sj2Li8Vm//3kEhRNQzwPtL3Ya32vgbVLttMzgfTHbDIypfg0sI+CkuoHz8B3GTvNlYnjKDDFq7fkky9rwHKDsG653fBzt7gzx9QO8Qa74gPGAIAsTnauJHWk1PcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=futRTkGihukVbLbAD+IUORgmi71/k2+T2ETRR97by9c=;
 b=VgM13D+G27ObHdHYgcif/uCyzOkdeVBIg1uBofRMaCc1Rv/gueB6B1DmKKhF+Mg6F6dDvDlNPYd6f+S/a7Ngg9uegz4o56/A/Fo1/rCAZPR2T1/u9nMhP+ZiKyIWxYytLNyLyb5EzDxohgXUX85urRGv27GSUO8N75r9MxCvo8In40Bu2+2jn3owjqCGKmuL/PCLcPLoCn71jh5MpLcnmimknxjlLjtOvHTYdeHE5Ye4LNf1479JHYjBQxdN3OZZBD8CUodPEPAPYxbzG6NuQYfn1jEm08eVXaZpyTmwiADjChkBj33prO9fpMopr1siW7sI1kotnKtQTVS+PfqvqA==
Received: from DS7PR07CA0015.namprd07.prod.outlook.com (2603:10b6:5:3af::26)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 10:24:08 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::5e) by DS7PR07CA0015.outlook.office365.com
 (2603:10b6:5:3af::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Mon, 15 Jan 2024 10:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Mon, 15 Jan 2024 10:24:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Jan
 2024 02:23:55 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Jan
 2024 02:23:55 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 15 Jan 2024 02:23:55 -0800
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
Subject: Re: [PATCH 6.1 0/4] 6.1.73-rc1 review
In-Reply-To: <20240113094204.017594027@linuxfoundation.org>
References: <20240113094204.017594027@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5de2f64a-4cd9-4374-b7c9-ae4c21593882@rnnvmail201.nvidia.com>
Date: Mon, 15 Jan 2024 02:23:55 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: 997ad163-7ccc-4441-f02d-08dc15b41bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MI3OySSM/gYegVxlbAQBfCIIEiPcWr6UpH1crbedmbz6vUQOZ+cIlpv3QF8iuXLc+nSGpZrlRG7aEV0t8rzpoxxSjZEeyVUNDOdtHTucuRWGOvVHL/PktU6uIXovZJSxf/FWCsb/PUO1rzZvJSK27xbr9etmMeXhpoKm5D5zKeV8blqKiKxhy4qMA43W0c6fnjUyDX+uhy+6cVd/Zj4rRop9kHQDnOjG9l6DZ5Z5iP3E9s3LC9HL+nyradFcrdQZpo0D3zZ4CA40b9oWQk/uYOG6DLwNHfY8YV6t/pgA1Z+7LgrW962Ryas9rODGYkzW2ctLoxl4fbMu1OCkbeYmEu8KhURAAymYrwCjfDlpR3P4X+5rNXjj6FgfR2OphsJeB9boe4PvWO/luZDFzC51QZEO4TVGMjdrWGXS27zg4vDDPJgKJFDv8f9QiUSKuMNG/9nga+iREixQSyup9XFQPy8MtpB7wpN90wy5JMV2Gxb8EWvlc1A1lv0oz1/nYe0dxJIsiLIN4Nymh8ocVEdfeWKyTp2JjkUWFLFHyNgQJHmxc4ofF7L2+QOqq1TGW84sAHkgNoVzQY12bQQzt8Ay6vaBqNHDuoySBZfp+f0B3M/QaKx3I8pk4+5hGNClsFy4n2Qmjdk/9LTY2Itv5LTnx7WBbOfqZ1OSa10WECei6esG92DNSPBYwPo+GGCXslC2rSoUCAnpFDXX1H3ROuINcdE1RdBpc6kWUN84t6hKSfsr1yCsJ4tcda7by8rZ92DdE32TrNrFRkygR+AiGCz2cof8oPJe+qyUNoQAy9KJHa4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(2906002)(41300700001)(7416002)(5660300002)(478600001)(82740400003)(31696002)(86362001)(966005)(336012)(36860700001)(26005)(356005)(426003)(47076005)(7636003)(8936002)(8676002)(4326008)(70586007)(6916009)(70206006)(316002)(54906003)(31686004)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 10:24:08.1395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 997ad163-7ccc-4441-f02d-08dc15b41bb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460

On Sat, 13 Jan 2024 10:50:38 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.73 release.
> There are 4 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.73-rc1.gz
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

Linux version:	6.1.73-rc1-gccaabe946278
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

