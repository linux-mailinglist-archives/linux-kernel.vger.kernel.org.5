Return-Path: <linux-kernel+bounces-20917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A97A5828755
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3FA1F2569F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB5039ACC;
	Tue,  9 Jan 2024 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qkNNAzYn"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAE339AC1;
	Tue,  9 Jan 2024 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEjCiJh+CqSGBjMusdlyFOe0Fop2Bj5iMyu1h91TJe4CE6I7ywM96kklMsbYLO3onYx+UO66n8ojb229YTKS/eD9fP17Cwh+Wd5uP78wmhHpsyvDfdVf5/pDsDWuYEPKSaOMGD4ICaMAxJ2CVFb4I/kymnHTU9Nlq/+TJzlmk6hgHU9Q5SF12ZJbnk/Ig1cz4mYHEZcPR2QvYrCKyuD9WUyrJKDufPxcJ0a61mW5lDrp9hmjkosmGVcMtq44ma7RDHWIvu3iacZlXfakwjEs+M6kZEq3UJh+6m5nadHqsLBPLF58pFFTFIuPiGR25QNZdxwu3XrYcKAQIF5/8MJpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAX5XKHrN2DQ3vguRbKPg10ae7P5k4VOaFXeNpEABtw=;
 b=YCOFz2tNiQQxKmilLVgdduGbczNngGpCt3EKB+A8aM+kcBUV5wRdCKEnNpCP4zPzNOo274lZuShgg50xttrXwxlf0qWSUI9tud6JGMjp9K9xc3S+xnf70axjdnYmKy97u4nKqKTvWjZCcN7seSdXkkgXXobEqPH+1+Ox4RQRCJMKZD8l8VW4hSGx7dwYrXpSpIFVmhcYMn7o3WteAH2XCIH26JNQnqwTMcB9I3roMhI2NKlPzTRAasATg4RvSdw5kizfQpvhUqQAuFerov4vMObw5Sqyo5+j4Cw0FQFd8oeJi9R2MPH0nCE7egLZqlY8RkZEqg9LCpOPcDsDMw7/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAX5XKHrN2DQ3vguRbKPg10ae7P5k4VOaFXeNpEABtw=;
 b=qkNNAzYnC55oLeEHl+0qvS7X7UYEBKXg4gXTO6EHsFAeudp/MMqyCKY0cDB59ut8G+aCwF7aw0VqPlJllTP5hsfsc23YjQMCj8vI000iEv5GAerKaCNHeD3c9w+AXEi9u+J9l3e5Wi9hSoNy8tqfgX+eg8lFetBEFnCxpS0IOMY9l1soTu7hTn5Ww6VvnuXchxusOwwCGY1LiZS3spge04yfWWd209EeWeHSOTfrwShSymZTJjY7FSylBhqz/fUPmsOKc2dx4nyriIokS8vlDPdhXI1hedeUsbIT2ggTWkQW11r+uCElGKAtatPaMUzu4AkX/UkTpnx9SlJIu63sVw==
Received: from SJ0PR13CA0211.namprd13.prod.outlook.com (2603:10b6:a03:2c1::6)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 13:46:32 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::33) by SJ0PR13CA0211.outlook.office365.com
 (2603:10b6:a03:2c1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.15 via Frontend
 Transport; Tue, 9 Jan 2024 13:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 9 Jan 2024 13:46:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 05:46:10 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Jan 2024
 05:46:10 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 9 Jan 2024 05:46:10 -0800
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
Subject: Re: [PATCH 6.6 000/124] 6.6.11-rc1 review
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
References: <20240108150602.976232871@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <dba3289d-e43f-423d-8a78-e9f804cbcfc9@rnnvmail205.nvidia.com>
Date: Tue, 9 Jan 2024 05:46:10 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f348536-3e16-44c0-f8fe-08dc1119634f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	chgErXSeWvEI2rQfxQ26jeQYNbGmN25V/Cujfi6FD1Ox2XHqO0fiNHv9sn32CXMYnn74zq9DlH7Kfacg2mxA+yMXr6526Dj+B8Ev8adVWDrAvCvkw17ZqQIPGEp+/2jOex5OxkpPUqEycCjUUOGrfAIgHc+drGnzCPv/pdJQMyHBtuv+kYjRkNirifkjmco7fU1WhniRP9rSmCXen695Z4tkf81J4tPW/DJV9dZxl6Ay0FXNZK4HWrQYibW4k2NYaUbxDEO6FnaFjaHQrnESGKHK35hAYCG3e69p+5cv0YL3g1c4+U+Au1P/+TFY83prAuxdi9fGTozCOflWd+YSW7Wk4cn3BkV/Jg73f4RCXlPPtA1qi1ff1ruuleUa9nV53Tv5yvf6Itnow8Iw1gXoPeJtJd3xmvSdRAvGtcIIkGLmsUFnf/SCCKelFprNtfbICgamtSEZERCyjue6pLOgho/pouIsH/G2dMppmH9eUUJ/tfCFnGUYIOeU2BRg0ufWnB/xjNJzktZgKUiIy6V5E5OvjPvFlMhfeEbh50cJITXN4trX6JoUzKfxpz0uYozjfz37SXsW2zcMbGxvHRb/pK9/SwsHgDE/jhvOcZQJLre6SK408SHhhkYrH4Dk9Z7u4EwChtRJZASRIdPOZUWGMgDuAi5vczqQ14v09Tq+rX1K4kgDR1Iqc19v76AbIsj9tL5Gon4Ibc+HBlgxdKv7zDP3idnJ5qsjXlpalWbFbGS/zZMQcqimXXGyquxYxcNnY74WJF+I2LXBQedo6oYm1n6vePRv5XUDdk4Lkw1NUMY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(31686004)(70206006)(41300700001)(70586007)(356005)(31696002)(86362001)(7636003)(82740400003)(36860700001)(47076005)(5660300002)(336012)(26005)(426003)(966005)(2906002)(6916009)(54906003)(316002)(478600001)(8936002)(8676002)(4326008)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 13:46:31.7495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f348536-3e16-44c0-f8fe-08dc1119634f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538

On Mon, 08 Jan 2024 16:07:06 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.11 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Jan 2024 15:05:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.11-rc1.gz
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

Linux version:	6.6.11-rc1-gc52463eb66c8
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

