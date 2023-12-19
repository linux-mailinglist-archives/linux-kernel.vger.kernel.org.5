Return-Path: <linux-kernel+bounces-5085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C12C9818665
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F5128672D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C4C15AE3;
	Tue, 19 Dec 2023 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mHxVx6Y1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2F18AEA;
	Tue, 19 Dec 2023 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cj8kC/ybPSjip6KZkHgkf6xrVEiRGeHHDI3aDZgHY5pHtM7FjBVrcxcH8LkTXmwUIEirqLhz8q8draW6DKPRkEBTwMNKKHUswtV7N2/hZaIT1zuEvTIZPu1WkGLkbDENcgm+JIPbZUQFOwGf+7unUHj0D8snDOQDFOhLzE6zZ7YqWESbedNovLN3cV2vlzYIVJfXpc2Q0lHqa4WpYb7iSZluXzc9jGTdruSC9AfvrgToa57lHm+tuPFTYghK6aJQTfLWH4VkOS3UKl59+ei9152XIGw0prSStr9qFYj2evER9/Zdz3MlCBBpcNkXHEfkJ4oADV9SbCp2te5pu82X6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwyQOyW4vS6SWpNubs1zQt1F+ZWacpKTh2/u8H8M5f0=;
 b=nkhY1t+rh8nqB64ew6LoWPIwg2kA3zHvRxER4AZBszHcKVwHeosQfxBXzrXuIq1VGz8mhM+dU/xF3G8v13Kex6cy1nk74ugcdOccjV0WoWZ58m51pwoy2JLXiB7K5vlF398pboZdtzL1DXGkrNbyxYXeytXqIG8V9cNTCs/7Dywuv9GkwjG45ccRgnAp6Gt6FzBHs4a89iRADLZrzJj+Mh5rrrGZBPuqSuwey0dZgy6O6LyTe1qOENk7m+BivvekpPB8ja6R1tTRDS7bNNapmr4gymNpJeixA3SI28mjMOhvd/rRhEIM7J5O2wY3udQ/K1E72iQjrFezKC4EjRd6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwyQOyW4vS6SWpNubs1zQt1F+ZWacpKTh2/u8H8M5f0=;
 b=mHxVx6Y1zimX/oFzwboswd46ktQM0jDWgBoXbUuyjIGEVxXNkVKgLAVYVvLSViqPay7TV4nZ6yTh0pbFcNnZOV1riP1FF36xwSLOMhyORY6wbNePXUcTGdYnIx67Kvmtn75DDYZAAS5oq+ALFuSlbim6sTlHbz/Oi/v6hpPfvTSC/x8kHLJNMSbtbrBsOn05DJIHFcK5cvHqRtc/6eE+9tTSKL3LC0HL6IRAaR5uyV0sTnKaTOapvsaTGtEkLB0aRI0Y4nZ/gmuEKhdaHSpAQpWJxTDk3ldfvSyDjFiorW+zUTph1RWM9be6It6R1KwmLHfLafrcHOXqwLR+UjqODQ==
Received: from MW4PR03CA0128.namprd03.prod.outlook.com (2603:10b6:303:8c::13)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 11:31:08 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::17) by MW4PR03CA0128.outlook.office365.com
 (2603:10b6:303:8c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 11:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 11:31:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 03:30:55 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 19 Dec 2023 03:30:55 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 19 Dec 2023 03:30:55 -0800
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
Subject: Re: [PATCH 5.10 00/60] 5.10.205-rc2 review
In-Reply-To: <20231219074407.947984749@linuxfoundation.org>
References: <20231219074407.947984749@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <c87071c5-de5b-4a72-ac18-69ee206f295e@drhqmail202.nvidia.com>
Date: Tue, 19 Dec 2023 03:30:55 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: 801faf28-d724-4ddb-94a4-08dc0085fec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TATBePbsXZhZO7BQElcyW9HI7V9uCgAyhjn6mqM/luO7fBri4EOaQBDYTvVIAjqsZrq1IW+mgFD4kf6FcdVWHw7uyLVXNjvTyoEoK1fgsagOeIV2XJHI/YbFlNnkOl6Mqk1PakkEBCgxeV1PZ9qfcpTFTp0YHnjaf+ZFxe4H+1kdR/WF2cGBycC1F+gIs4LVo8DwfRkehIJTloDLylqhEHb9Cf7eNHv8hZHExjYwWloiiZhjDF4NM+q9vl8kecSKwBcOLwibqbA4wVp57F6VmUc9qKhn7O7yejFac9XxFx16zcxi09TjqlYmF2tpgjMdd7ckNmnWZ1ggz3WCcUzUnt8oeBzJt13HAC8lxaYnYceACmWGhKyh2YgeZO5xlxw4S9yIL4JhVhOFozIE1ns0JBa5rXGyHDk46QxUnaIkd/vIAUNWs7NMeRe4TlkRrkIABfrooN5dLscPaEKVT0Kdq2/YnHKY1wIe+7x58o9lOWzDAdWJJpzHyyzzwgCy/9qeqTHoCY6FciVTPDzE2NbouZWHCJwC5xFkPOs/063CW8/dBE3Z4zqCdhuec8AuJIfK7qM/cJp/ore1ZdZKLTDIe97yLkWgQPy9RH23BXoJyqgGcKxLSEekLpoGTWpjlLHsqUS2+UGvegoL3vDFELXhM4ieUvwL5XInrR98xvZK7dSSIVkshPfWyFiuP83xm8GgN1wVf88NxDLHaVHgWQSCvPyRNMnBiM4c0OIaS/6isCgFtpEZRilmrbI6Ory55OtW4tYg5LxZzJl0X4H3J14skbWZQuj56Mvys/kteUh7nlo=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799012)(40470700004)(46966006)(36840700001)(40480700001)(2906002)(86362001)(8676002)(8936002)(31686004)(356005)(7636003)(54906003)(7416002)(5660300002)(70206006)(316002)(6916009)(4326008)(70586007)(31696002)(36860700001)(40460700003)(966005)(478600001)(82740400003)(41300700001)(26005)(47076005)(426003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 11:31:08.3867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 801faf28-d724-4ddb-94a4-08dc0085fec3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195

On Tue, 19 Dec 2023 08:53:19 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.205 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 21 Dec 2023 07:43:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.205-rc2.gz
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

Linux version:	5.10.205-rc2-g163d4e782432
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

