Return-Path: <linux-kernel+bounces-5086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32980818669
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B150C1F23D75
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE15C15ACF;
	Tue, 19 Dec 2023 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lC52lx+6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C584815ACB;
	Tue, 19 Dec 2023 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yjgqr1DpN6EcDM2HZ0IUJs1oPtkSLDnBibBU0Bp3Pbn3p06QYG4rL6+ZXOOsCKG5XqdNwangV9YdZrJ816W7qAkB/y5xoSSv1PmEJeeEtk+YS+e/0JI1DBtlT35kSmC/Gsdt8zi3nhJSG9RSmfOmFpDf8qrS7zgVXbBJGNm/6WdQztYQmShN+BLeEcZng6XDoGEezKXF2pAS0aNY3w1ZHfJUuMk0BKh2BATIt+pkVPqZH88YSPDLpBat0OdrQBjfmceWUTijXA+7vUHEFwq9lF0OFqRq8vIrqP3BPUcvHikuQZuinjgNfnUzVtFW1MOQ2I70evEROboTVPSf2nfYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ENVvj6jSC5VDTPt8nzXo606iz06KcGjkIrvwEopmkw=;
 b=PAgWg1UtzI1c7QKd/94qPY1Z3G0DlNuotrurA7YyLhg+aJA8EphmBbSOOkvOqJxRc25+EffEU0rUAcCgs3I1/Cfb+T7aQjTgG3WY4gY/GYuJA311kqDek0FGT7hmh6NtALdr/0pWBJLpIv+awA1oQfrPYLTaNNHCDS267AVUcgZIq3vTM/Si64gz3HBMqYlrcyZDqcKbubmREDP5f4TmqJju0nE6uSW2lDjrT8N1/rb2bpdfMAOP2H+S4tqmGO6oF52jqe4JlPK2ua2fskyiJGX4f3Z4XdgoDwa7dZhnZnfubNBcw9T6gARFvDO+CmvUFUXX/1hRNwrJUOEJ0G8FUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ENVvj6jSC5VDTPt8nzXo606iz06KcGjkIrvwEopmkw=;
 b=lC52lx+6eyDBPPgT5ojpsexb+F5aRXbuw1c9jHLscbMVXzHw/B4dhy8pfAKiWDNAx8VRzb/tUvIU80EbdYqp5ev82FXPEBOtjui82mowmcAG/Oss16Pl4I7RZO6JIZgMZy0hL4qOcLc/igEleVSWBPoQmsUFSbTQ00Xdi5ClTe+u3faEp00AyOMUa41LdiCixVcJ4uAmvilYqCBjL/Js0CnqWwQVPCsfHR21lZTVAlg3kR6TQDWQupV4+6ZYBSCL04+XEPce5X5uhMOybLYkXjz4lfXmVf7mPwIBO4FR/YBLMwNIVYa/N3XM/iXXECdpmb56ipmBI+MZQkMYonzI9A==
Received: from SJ0PR13CA0006.namprd13.prod.outlook.com (2603:10b6:a03:2c0::11)
 by MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 11:32:29 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::37) by SJ0PR13CA0006.outlook.office365.com
 (2603:10b6:a03:2c0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.17 via Frontend
 Transport; Tue, 19 Dec 2023 11:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 11:32:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 03:32:17 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 03:32:16 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 19 Dec 2023 03:32:16 -0800
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
Subject: Re: [PATCH 6.1 000/106] 6.1.69-rc1 review
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <a7b7cad3-d2ae-4fc4-8936-bb9bafd87bc4@rnnvmail205.nvidia.com>
Date: Tue, 19 Dec 2023 03:32:16 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ea8343-63e2-428f-dcc4-08dc00862ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	53/LMrz61aAJ6lP9WtUQceDmMs/ZVIxDvCaHli20FlRTiDg0qtLs7BLLVNNComRvwSNl0dzG7krm9p0BX8SUXtywm82RwRZsgatGunG+f04+AEkUUhXkbmWEKXMytSRwlbPyohVWdUy4Ptzc85AOrrzAAoPHuLeHw6ejYP6LuzTutgVXgqppLFzoH4QibTowExKzLPP30idOOYyli8vNTnhNHSnzDRX7MSVwnUd2/34DcNd4L+GSB27souusdw+JaDWss9uHUz7nzHUfYqobsAOD9YeakD0Lj/rj60JVGf0pLNrstK9YyFtxMD5lJzYKLeMT/3qfF88hpQy596L3uVurqEfLQPEsnj+kdsV3cCxzuFnRujVsWsJ7LHeCOyf+lgx+1DBPL7w98QZ2N0c/Vo1piXMOTzrIoB2d12P6NVEY5SVRs3AkXhMZJTZmPIiAu/tku4a7wo6y/saOrNlbM37ALSrsWGWSxC7Z3Z3uv/N8H9B9Zxx9wQmhy0W/WE8p43RIm4a7+ifDgNcjH7bJHy2b8kJppB48Ex4pb8CmyvNhrfxtYWVw77D0RQtSH21IDU5HhHCqtXS3jWvP5yPb/R+UCPed4x+yEN1SH1mU6IXsGwLZuCjOde1wjRS0iaX2Kjd1ZHdLIzn3NiTPhZBAzo0obIhh5JA7hq8+X4EpJyv+PyJTGyemSUY8hNO0MOvFZWwJtmQ3YmTVPuxdSx2erzlbhQPpPlvZicJgMSyU0hmcrY/hcYUBEjzMVPFOmQKQ4jsjtq/t0Wgemg2EnXLQI5lA/U2UF57XuU05z8OwvyM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(478600001)(70586007)(54906003)(6916009)(70206006)(316002)(26005)(40480700001)(966005)(426003)(336012)(47076005)(40460700003)(8936002)(4326008)(8676002)(31686004)(36860700001)(7416002)(5660300002)(2906002)(7636003)(356005)(82740400003)(86362001)(41300700001)(31696002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 11:32:29.0240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ea8343-63e2-428f-dcc4-08dc00862ed3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261

On Mon, 18 Dec 2023 14:50:14 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.69 release.
> There are 106 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.69-rc1.gz
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

Linux version:	6.1.69-rc1-gd4e0eced6308
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

