Return-Path: <linux-kernel+bounces-25883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABDC82D73D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD561C217F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2545A2C683;
	Mon, 15 Jan 2024 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N7F2dOAy"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97351E864;
	Mon, 15 Jan 2024 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZbOZrlXjdDJ7xZKuCA9uo4Jua7K4pX/6IbpG/jbfIa9BXVIXIgrE3bfK8opeTEyX8bGhVq1EkkltZo0ABZD525yDGq73BYY+c6J2E+XOPYG77AUfL/Ws99cJaPtldHfPfP4fuG8PZDD+LEsFz4SY+EAIPl6jtcX3tPHfq/6plRdtN15DSJqXT7G5xNEzUB8JEDcOwRo4WLMhNbvu0mLhUKtvR9M9pnjWbZexnmf70A3sdnSONFraxRqk6Obwmi06blQsYe0ZiFn0Zxt9GfjqOOYVtb/6VWisN0S3IhwVYIORxHcWYZjqDm4CTvhcL8foE1ZAsv0hIPEtZC5esXW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlPX5fIXD7SRoYylxLnPdmjFZsUfM8TocYbcEisCFik=;
 b=K5ImQKuR+Dp+9rOjVnKHyToybZB0//dGEE1VltQdhDNNyNk+KfcKfXWJ9YRrvwna55sMuD2aZlkUwv4qCO1aLD+S8jqJAw+vNkcY0XhiUZsriPkiWFphjWKZ1j5vmbnTb4vp5/yOlLu4Z/S3IxqQq6439crDp1ckbJ8BqX9c8vAL2OYK8CsM0B+pZsssE1ZCYAxjWaaOSeypsgu6x/3HmDqGID9zRtZh7MPOPv7k+opVrfY11uBO2q3xwRuiUbxgpqzvZvhpie9xLKqo475cvqRCLzXizjFc6BmKyiEn6tm9nBpY8KdMb9C0//Bm9TO4lW/rz9hz3SIBJXVEoBBisA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlPX5fIXD7SRoYylxLnPdmjFZsUfM8TocYbcEisCFik=;
 b=N7F2dOAyajNHEEC6XFoj2HN1T3tFcW/vYcOcn2zSU+8uV7gVzMm/EGODXjYXJ8t90UiIZLdSA0ZkO1hZ6hkWNPwfOdpW2nOsNpS6FLk2frFVw4Z81VVqKQ1SEO7ewOpCOl6Fv5D2WWZtjOcpFYJF9b/c3F7ff38+Jvq4pVWHTWvIjsByp1MBCC6nhpIRNlqnCILB5RpBoSM9RbPtjGTrcsl60mJoCb5qwb50HLOGuMVtp8zjAqgTganl7XBWw8EGMjoSZqwvSVIuX8gaUKNKvkDYprH9ZtsxlbtBY4qMIl4NQm+ylX/ZrAXn7jV6/0u+7SewqrOHjQEguh4oWJYsuA==
Received: from SA0PR11CA0158.namprd11.prod.outlook.com (2603:10b6:806:1bb::13)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 10:24:05 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::91) by SA0PR11CA0158.outlook.office365.com
 (2603:10b6:806:1bb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Mon, 15 Jan 2024 10:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 10:24:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Jan
 2024 02:23:53 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 15 Jan 2024 02:23:52 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 15 Jan 2024 02:23:52 -0800
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
Subject: Re: [PATCH 5.15 00/59] 5.15.147-rc1 review
In-Reply-To: <20240113094209.301672391@linuxfoundation.org>
References: <20240113094209.301672391@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <8c60deac-7df9-46e2-95e3-b40225bd6350@drhqmail201.nvidia.com>
Date: Mon, 15 Jan 2024 02:23:52 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1c85c8-3b7b-4cbb-f33d-08dc15b41a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DfCMjAWsZ57qwWc0BZWgSDZQpSOHpDe2dEb1rIHFQ4adaI55+ZTvZI+5jSYGcV62zZ7W5vngtoTj9tSm7soEPvh9yiU89ntUgxqs04VJNWSrU7EOKJptw1Mn9gpeSXJvAmuMwu6hkgQ2IOnxq3d7YeM7qdi0RQxdMMqc3WnN0kImHCvPVRtKhta9toEiEQRfcxqeyjEFU1/yb/wRb3Z7uljwyqbw9xw0eCHw7hTY3Dvz971aSw4fJ+T2awvKT82rBshJiY2xuoFCzN+pUQg9sA4jqougGpFW6dkN4wc0Eap8AZBJWjtfPgR1RYNzlND41opV0j3XfsyuVEuVFthIxNbpLyw0bEmTMedxjLJ5kV3f4ri6hTXqnzESOkLfiA1pCmoT52Z66931zy+xK7tOnRKAHxV+6fRliVuHLYhbw476Hvbg1aoRt8F7oF9RdsrDgGF6ReHObo3YsveEHh9oJKJFVHBlSLpJxFSDHvPGOqQMVYTLW8I1KMoJK9zBt2xNJ61psWcYxGiMG8sUQ0LFoET3ljxGO6xzNAulsKborZRPEo9Rr0m6Z6v7IFQAIVl95MlFQT914qo5de+TQ+nP31QOfthI7EHJ1TRP0dy+EmWQuy8P5lv8hMKmEQBtyp5hhCy/nJvlIwDqvmmhBWRonDckYdZoIQtAPGkEGiTHP+HQgRN3kxLee37RZGuPko/yZICXGQOiSszX4r4HDxg0oifo70vPWCt5BGzVdHHFiTds71rbyZmY1vkKxHmPsXcEC9nDnmto8Iv/Tz/88tgNVHSNVXUW6EsI2+LvAx3TzKQ=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(46966006)(36840700001)(40470700004)(7416002)(31686004)(5660300002)(40480700001)(40460700003)(2906002)(8676002)(8936002)(47076005)(336012)(426003)(26005)(41300700001)(36860700001)(54906003)(86362001)(6916009)(966005)(316002)(31696002)(4326008)(478600001)(356005)(82740400003)(70206006)(70586007)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 10:24:05.4067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1c85c8-3b7b-4cbb-f33d-08dc15b41a0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256

On Sat, 13 Jan 2024 10:49:31 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.147 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.147-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    102 tests:	102 pass, 0 fail

Linux version:	5.15.147-rc1-gf40fefd14722
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

