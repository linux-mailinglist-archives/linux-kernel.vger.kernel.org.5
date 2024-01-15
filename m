Return-Path: <linux-kernel+bounces-25882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BBA82D73A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649141C216E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108F21E868;
	Mon, 15 Jan 2024 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m/Bi5eDh"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9323101C1;
	Mon, 15 Jan 2024 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrKLXB76WB2Gdw31gAwqxUqyeC5inhOJjSJdNy/2OktTOYUaf9GCUtr3CF/2r/jBqWRL9cQj1V52pHfwcptui28imNWemNGSlOdJjOZUX5Qw0YyoSbLk4bkgUu9+SfJ3JWYGSfUIC2p78aAGquH1cuZTRnqHDbyevTg7NR6RqCINK+KOpPbSBGAHZ+R6a9rBLXoivNw7qaL+jAe/CZcXz2iDmKsOo6vMQ158P9NeDPiIAm428zTxb0oo7VFrsRxvy85xuFUIabVRvLG7XveZipblGnUcrUb586JYeIySPntTjZ5bBoLFl4ga6Hfq/jTMNdCDhzd9U0z2EbEXtVQvdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqDWMwjEFuAKF4GQFXlLd7Cqdl4QSwwAyyXj5xERQ7I=;
 b=h6yqrvyopq554NEbUmkyclCh53qt6Hc95qlQBUEdesuitg4X8aNQEK4XXWFBMJR+wpMqNErW+YyuZK0JLLCEYx0jbavHZf38yx75wLNt8NZ+wXF7Cu4eRWUFhknzztnNZCNNHQVpKTx0fT40Uc6wM5acqWDSr7bge37Uzv3oJM9DMH/3MdWzLGam8TuDhwgWX+JK5YZxybcM9P9S3DWbIbqr8cqfjdr60F5hL2q4UoXdHRquEh9mmkBJNNprsfYXI+5uyMYHn1Lsb+ma8iywj2WDGjsU25fg66EPs2FfCnSD2RnH9f7YFqBeIWWERpdyFCK192IGDPgZAZa1vVhMrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqDWMwjEFuAKF4GQFXlLd7Cqdl4QSwwAyyXj5xERQ7I=;
 b=m/Bi5eDhHzFT7MYiE/r8reF8k9zcW9NyAO/v8gaeYgnVToM5ce9Cqnas9iHS7ZSp2Rg5nuDkWu8sbGeRsvJAIMyT6oos1urRJO3x3DG5UEBHDALOtWCnfEe4JawDrPlMK7L9yHm8U5QGK954pIxDxjFhVsteecBhFrejKpeSqxT1ZR4Q2/hr7BeSQU/4LKf77NWpXpTr1TsX2ZOndMm3Wh8ZJXi3iUf20b9aj3AQXLSWFhIKBDlpQPF25EOtcZ1dAB14Eys5EyOurr3Xultb2RHB0UGF61PFrNPoLbZqtkLI1iJZWDaxvNBtpntg76KH6OlUSpMujRLZPLLJYON9+A==
Received: from CY5PR19CA0061.namprd19.prod.outlook.com (2603:10b6:930:69::7)
 by DM3PR12MB9328.namprd12.prod.outlook.com (2603:10b6:0:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.25; Mon, 15 Jan
 2024 10:24:06 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:69:cafe::7c) by CY5PR19CA0061.outlook.office365.com
 (2603:10b6:930:69::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Mon, 15 Jan 2024 10:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Mon, 15 Jan 2024 10:24:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Jan
 2024 02:23:52 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Jan
 2024 02:23:51 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 15 Jan 2024 02:23:51 -0800
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
Subject: Re: [PATCH 5.10 00/43] 5.10.208-rc1 review
In-Reply-To: <20240113094206.930684111@linuxfoundation.org>
References: <20240113094206.930684111@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7f61ef78-d9ac-44e8-ae4d-28eb66390197@rnnvmail202.nvidia.com>
Date: Mon, 15 Jan 2024 02:23:51 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DM3PR12MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: c93f1d33-e314-4e9e-4d2c-08dc15b41aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZAviCzmtxvlJgkx1xQMsjdPvjjS35pVC5SsFXeZkCiB7nQbev/asK/vHAwViAZ9lX0zZsr5BIzPYsgyYc1uMB8VpJikhGKb2gbKQALnThGABjEo0qM+z6W4PW3ptkJnMo8qq60e69soi0ZF3U04E+gmbvQLgjW2/WHVynL+UihYAZ4b8yZdKX1UXc0D0mMxQz+cVnGQthVWeTEopklh8lr1UX+ZpiPt0845zq1a+Gs0gCvQzO8MtT3TQx0N/guRdHssTbX0af8Bkjo2prr3eQR7pVm+VMZlN4VehcM8U30llnEa/xNbjc1DgLCDrK476K8uxtNR+g6S74eBtGsapy4HPCTPPkxhfnKGLRWlm9+UzGInCtaqzN9oG9TtzOgiATg439bj/HIbKWryfqKq7k4aXqB84ncXkX2NNl6BEbLf5TokTwJ8vv+rLKPBhGzYo1FvOb8kqNtiJXKKorWvehE5DIOQkCIfDG+S3CqhfT89VLWHzOcbrWtXTcLEp56uRNhWwf9tcY3G7GzgH/KBi8F0d5H567FOF+TheCEJkQlEXqQLEHANpJPm7Kkr3gl2H6Vdy79VKOLd6xJhlYtyeopG0T6gTM6myXTHRt1F8IOjbtAI99CDZYKKEKfSJoANKWK9csxEXrDzJV2mZhdLIDY9qITBQRhhA6FYVTfMsKjxzu2dEPa82cOH1M/mRslZqM1L2OYGMz/hzx5wRyr5bPG/OjdHjfRdpF5KwDxYpNcM97B2QIr5sqn6bomE81s6Yz0iNSB/P6f1Oe4llC/GW5gIpfW1cORvT0lp07hlh7Js=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39850400004)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(478600001)(82740400003)(7636003)(966005)(4326008)(36860700001)(8676002)(316002)(8936002)(336012)(54906003)(86362001)(6916009)(70586007)(70206006)(26005)(356005)(31696002)(40480700001)(40460700003)(426003)(47076005)(31686004)(5660300002)(2906002)(7416002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 10:24:06.4026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c93f1d33-e314-4e9e-4d2c-08dc15b41aaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9328

On Sat, 13 Jan 2024 10:49:39 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.208 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.208-rc1.gz
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

Linux version:	5.10.208-rc1-g7884d82278ab
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

