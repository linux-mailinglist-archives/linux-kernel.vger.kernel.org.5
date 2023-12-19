Return-Path: <linux-kernel+bounces-5083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BFF81865F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA692867C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BA9168DF;
	Tue, 19 Dec 2023 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SDH3XHx6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745CE168C0;
	Tue, 19 Dec 2023 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXT7leeCNnuM+FkxM1JyLvFf3/jb1TAHd8QACe+fkGelXYw96NlGPe7bE2pFlRkqpnsrnpJWne8XSrVMbNzOm9eY/VBcRrBwAa3mRD1fr9OO80wTdmtLmvREnZiCR5+Azco1eg9RGO6XtsTlcreZ2kRF+jTA1dkTPxbKMa6XwtABkolNIr/m/TMXIw6rKg+yuKFTrneipl6rKqrETWPW4CDocVJ9scQJ7u9zfz+koF7SayXoCm3bwR6NCZMVhJKUcKnSQyv4CR2tCdoUwyHgk8Nxrf7kduksx+x4VMFzceZtJ8vPf4DBzn2JUw/9bkJAL835SJhXOJx3UZ7StoQbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfvYf6EVoRvqpanlgm+hCeR47ySVJh/pzGO1BS2UX4E=;
 b=ibzJgrjFvQiPU70RMa+JpnBaRq1zrn+GKxQ5abfBaIvm7QUK0Pgv/g5oytmPPJ7KTgELglis2km1Xs7wB8wg5OPuJFdEM5HXumqstjoGbdq1rp9PJPr1d1sHUAyv4Zt8BFPJML5+cUHAMIToDWZ0XSRa4cLmMs0gH+okfB7RGIkRRQMjuOkloS/MM9HKAvPusTPdumaIXrQ/Us7/lGWxfWx1Vn9hovDvST1CtRdL4zFri3oHfsKT6TovA1mpGs6De95+XLpXpJL6CbMIDNLiF/6ol607EGal0OW3boou3tLyzYaU/axTSnh5mnzGoJ5gUj9bWc3qy3HTUFjLFdpKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfvYf6EVoRvqpanlgm+hCeR47ySVJh/pzGO1BS2UX4E=;
 b=SDH3XHx6dEUqRtTU+lmeYPA1mjobkqzqLkaakvFl3lRjpS7il7kbumSrN0gEg4OtRJIMXIJLvNXGEnY2jPUzQpU/5B6jEEXP+P0DaRqK1R2V/jad5/C804oULSlp8et9V5cW2vO/G3zr6PO5sINPorAwJ4cAvzWAt4JsMG3o8tIfQDez/yfOibEf/L8VFUDhHbrk2rYmGHi4mhse6Ok4Nbq0wkhZwojR4lfBM/iNWzTZFUAqhCFqYtB45zuggtpnP2rKeR0wsTGct1t9K6HwQbTJb2xJHo3eWto54NNGaSM9FY5ysrX9cojvnH9d5FDzcZiwl0ZNaFbjWa4DDazdIg==
Received: from BL1PR13CA0341.namprd13.prod.outlook.com (2603:10b6:208:2c6::16)
 by DS0PR12MB9400.namprd12.prod.outlook.com (2603:10b6:8:1b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 11:30:51 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2c6:cafe::fb) by BL1PR13CA0341.outlook.office365.com
 (2603:10b6:208:2c6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.17 via Frontend
 Transport; Tue, 19 Dec 2023 11:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 11:30:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 03:30:32 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 03:30:32 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 19 Dec 2023 03:30:31 -0800
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
Subject: Re: [PATCH 4.19 00/36] 4.19.303-rc1 review
In-Reply-To: <20231218135041.876499958@linuxfoundation.org>
References: <20231218135041.876499958@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <0708bfa8-a73d-4019-ae7d-f23e9195b1e4@rnnvmail202.nvidia.com>
Date: Tue, 19 Dec 2023 03:30:31 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DS0PR12MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ebaf38-b67c-438b-4232-08dc0085f42c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JMNE3R2LdM5QCLOu8a2C//FkyFHN8fwD1pKuP3PWa7ByGugbAaOyvawQO/sdBldvFODn8Z+YW/1FBfHMHx1yYGrD5Oz4B4NtXKn/TY0n+B13bfdCXG15by/Z8SwE2SeYBhpzelxjMgYwL1Ze01Fk+zjFmXG3Eq1o7bIqc2qXbsjgDlaBEmVL6QDEOkVH/SKfprELfOgg12PDjrOX0+zWdDEzghsLUnjuwnZEB3uj9Pzv+3DO9NXi4lTcjahCoZL7pe5H2SWMpve8gfc5dnsOZfwUiXu0Ya86ZrSzEJ/L0qQ5Pi7XTtZv3Q5AsZt5lkSJjQs+rHj/gFTv4/6m0gtaw12EScvbDt2IDBEZr7HAYAUKmXiHD0+pdSMXlrA/XeSYlgEEC1zu0jYVX9shbCXoAbMQN9Lqb+NBWcm4yUP4rbxXU+EvKIKLyrXhhce5CoRBU1t5rXiglqBp/4sTx168HQU56eVD7KyrUF0KEwju027iLK0BYT8nNOkzpqYxgcDeL0n9TmRPzJz5o0MYeCPJ5UeLbB/k/ATO8R1++L1S5+abpMWxEZ3/hSOLFzmY4F7HuWa77GaUzole7dDhc4g5w5+ZQunbIphD1MJOb7x6jjW3E3FSIwCudRcoV6nzioR2Wkxqe0QtxLRXwsAuE1d5Xd2COvsMK+vmjV/m3Yk1i+35oIRYCiFTlxD7DCujD/KEG/EArcyGsSam0Rn+JUTSSfL7Saagzcr+QrvRVxFTAnqzBaQPW391lhgaeb8uH+1uvcp0OrxLDYi97ANE/yKC3wqDDnAV8vfKDACHZyDTfqk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(40460700003)(26005)(336012)(36860700001)(8676002)(966005)(47076005)(5660300002)(8936002)(7416002)(478600001)(4326008)(54906003)(316002)(70586007)(70206006)(2906002)(41300700001)(6916009)(82740400003)(356005)(86362001)(31696002)(7636003)(426003)(31686004)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 11:30:50.4928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ebaf38-b67c-438b-4232-08dc0085f42c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9400

On Mon, 18 Dec 2023 14:51:10 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.303 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.303-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    10 builds:	10 pass, 0 fail
    20 boots:	20 pass, 0 fail
    37 tests:	37 pass, 0 fail

Linux version:	4.19.303-rc1-gc6ac8872cc6c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

