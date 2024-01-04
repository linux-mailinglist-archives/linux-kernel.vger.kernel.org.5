Return-Path: <linux-kernel+bounces-16623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8520B824163
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182A2282D00
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AD921A1E;
	Thu,  4 Jan 2024 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UQg5Irm0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33AA21375;
	Thu,  4 Jan 2024 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJ+5MhhtoglouewM3aEyJMjawO0wgaNrm1/3P38pmAcf53eVNd4s0h/rwC7LnhWAbSXDMDmPUmExcAXciPm0nia7GgWwpEsQ2aNBlBJEMpDwtdHQVWzZhedyhdxj4nafdDMSnERyRos9BL8MeTK2U0Hl1xobY6UhnBGdkbmNZCGHU2Pc3uHDalCFvqhPqxM9n60ZFAqRhiapU9E4OXTKI9I+8rAcRB1mnAG71ZjpXGmU5mFIrPx01ZzHT/FSery3pKl9CfievLrTdO85Zh3Hk4yydqm+J9Ael3+7HwPZhB+cEiG1YISfc2+acL+QBYv0f3I8ePuG1X7sgIq5NaSaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvcgBwo07ZqkE3UcXqlebkCXSGftW6sAwGPj8JUJ1ns=;
 b=SlQMZ1Gn5DDfXKvqxEH8kgM5lFXMwDWSR4g9NI9iJ2HmVQIt5oeZhXNMCUfDDYBvEBKOfWRl3FhivbwOXF6J1cWaS78eGePvI4MFlDTeqZIhPdNUp06eXcgAFiuXKt1/IAldCvwaPDXX9kBynz+RY35RVtckIhcfzkrLKFPhel2+5BPunITc255WcV0u0ZtTW8tn52r+sw5v9CyCZBnPXZWL6PqjSiuY3Zv/HCtr2hzLuRqLsTjUN1I/VepqPT6zJvkJYeyATVNMNFWBy0nthGxxr2pjpvq8VhAlz3VWUqaC1KYCfVKZXqxyVfVxn6ulKvn/Loj/1XH2DIrvC26Vig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvcgBwo07ZqkE3UcXqlebkCXSGftW6sAwGPj8JUJ1ns=;
 b=UQg5Irm02D1JXYzYHDXR1MPhAxUS2nMV4qj9ElgMQhub7GuTSa61eyf80fagxX0do4poB8LZkRWAMji4DhSMP6C+2mioQngVSUkXO0nqDas4cFs4CetcyCynJQSe1UYRG0uQo0aszaj3ze3oCNdtytzjwXdvHMo38PQjoaLu2S7K2z4/pQQF5LXntEaJB+slRxEAozgRKjpi0SC+WM8noAPl+Qhj6n2iEn/iS7big1U7OxEWIvcYjzCaHp7lUM/fsa21NmtPk6/E3tFUciuk+lFGCwWGB5V9ZObUB4Qgxbd5bOhH2d4JlTsEKPn+D6KkfdEwGpRy7T/lrjR4KMkggA==
Received: from DM6PR06CA0076.namprd06.prod.outlook.com (2603:10b6:5:336::9) by
 SA0PR12MB7461.namprd12.prod.outlook.com (2603:10b6:806:24b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.13; Thu, 4 Jan 2024 12:11:49 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::d7) by DM6PR06CA0076.outlook.office365.com
 (2603:10b6:5:336::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14 via Frontend
 Transport; Thu, 4 Jan 2024 12:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 12:11:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Jan 2024
 04:11:42 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 4 Jan 2024 04:11:42 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 4 Jan 2024 04:11:42 -0800
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
Subject: Re: [PATCH 5.10 00/75] 5.10.206-rc1 review
In-Reply-To: <20240103164842.953224409@linuxfoundation.org>
References: <20240103164842.953224409@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <c8cf41ba-ee61-49ee-9a9a-0eb1a8da5585@drhqmail203.nvidia.com>
Date: Thu, 4 Jan 2024 04:11:42 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SA0PR12MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: adce727d-0199-4822-7a65-08dc0d1e53eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F8p3bFohfH1Heh02anvsY75qieNrpcdyBQf42E+dIA3CCW8E6UUY0hxr6ZB0nHoqieI2CHWDOLkxwFetOfg9ZS+WM5dehK28WKXuDcaQx8SeqVhXlkQOQSeEfO9mhWJ8M80FHVYU892W38I90R+qqSFK9ZM/7xuKJX2s8Ba7nB7ENlfExTdMaUwj/zoCEO0cnolBBmxg7YcmnWPiHDS8cLsbsrMjfSkVU6J3c7RttH7CqvcTJhnjWMeJmzmOO7ZcxlKWzNyxzLH0EdDfRbu9Ba4Bt411W2eOQGDB2ZxZj+2BfXuLpc5qWESWnOv+auRWpyOP4HYoJN4y7uiKPeZPkKyCHf0Q6NaPbWjfZx/ZDCygXpFVN+xHcmhY6tQ3clLwqN1F/R1RB7fvNlhiAFNL4L/Fe1wzjNcVTZ/olVwd62scrL/K7dba8Uqx3KPZzvn7phuufS47VITTMEhOLWUC1EGdnPu5y0gbn2Xc8Y8UUb/iLwwxBaTKtt7xoIcajp2Ty9hoGywrjBx82nMUo5SVCv0DPJDd/N8Mw1a5qS8pce6F/aK8CruM82Rl7XmiMWVLVTnh/dAfb4Bn3SKCLyl9MQeXwexK8CxxpGpa/o0glP2T6sbgm9APQ/8Kcujbhb1WvDF9N6M42y1AYBxKEfIVtkL8kNQTN4pmiah9rAZV0qcvwcYZ5OAYZXo5+U7tpeKtpdyUSm3v2wnoTPT+qHhTtN/XM/cuxm8+q3+RFobJMHYKB/sYLrwnS1WeiA6hVqpGC3uz/B2WTk79VGDHEY+675Pwl74fE9Ei1y7U/NyttXA=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(36840700001)(40470700004)(46966006)(31696002)(86362001)(356005)(7636003)(478600001)(966005)(70206006)(70586007)(31686004)(54906003)(6916009)(26005)(336012)(426003)(7416002)(5660300002)(2906002)(8676002)(316002)(8936002)(4326008)(36860700001)(82740400003)(40480700001)(40460700003)(47076005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 12:11:48.6951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adce727d-0199-4822-7a65-08dc0d1e53eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461

On Wed, 03 Jan 2024 17:54:41 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.206 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.206-rc1.gz
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

Linux version:	5.10.206-rc1-g6ed2e58a1d40
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

