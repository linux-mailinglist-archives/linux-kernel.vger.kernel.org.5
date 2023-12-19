Return-Path: <linux-kernel+bounces-5084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC571818662
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587371F22707
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34EC18059;
	Tue, 19 Dec 2023 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LdHMnI9g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20418042;
	Tue, 19 Dec 2023 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXlq7u2dcKzwAnn/6qKhJmxPwszvWKCYXg1OVHLiouT3uAU2KF6YZwGrOijaaWQ7WpCtIhjx77rSdG+eiH5pDLbcDG4TEY9HX2fwx/8ORECvAbf6UEi24hhU0rAm0vj+WOY/ly7lbgJMB3qfEogC7kIyelWTVTM9NfaShSLJlakvkopcrZI0u15g4feEKh+GmFCshDW3N+KqKGRewzKoJL47U0Xt4A21ulAYUc9wGrh10cQosf1ZvOJJTQwDzwkuXOSDvNY8Uyd3XqARgG46HAkHYDzfW3yvf7m72vaxeVhDt2LdxYDgiCvat720gGn3DYei3QOPWHcn8WnInOaWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gh2h37fFqAOlDCDBR8BWki+EYJg8iGtWWPqnV+UBnHg=;
 b=kcVmfu1N8QY2M9CKMfAuwdZZ07n5zym/EOqTy8OrlvT/l+zGbLtEZjTvd/H40+K6hrMEcc9jDk1iE+sRnEIvMMWGrGod+KAcAd3K0/qqNecKC/oXgtJn5XckSE1nXK/1NQ7iVtQ4gjak8BxG++e6ZdpTZfFagw14n/54SIbAOM0kEeYsZeh2nihGlhgHRr4W0YO/fJnMDNeU0g8EIKvHG32QWX6pqrilc4GYn3bLws/5VvDFN52hkz148I8xoh/tRianUFlCRQ4l1fy2lGdQW9NHgDzEPNK3tL9kQAdA+FC/HGptFz9jvMIsUEUqtGo7e68KTgw4Tvv79V7Y4pOT9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gh2h37fFqAOlDCDBR8BWki+EYJg8iGtWWPqnV+UBnHg=;
 b=LdHMnI9gX4anCgQDFVHYA5C/DZQtct4E83I8i0HT4+1O+baDAmXbgDYFv0V6zi3SOC2tej5m0qOoJQX7vpoioG3k4ce8Sz5sNGJB0p95zaK/eksS4GC3AbWJuhL7xKrrX0BJYZYmH8zDxlz8LlKqTU58XgxbzbgPC4Md6wYnm21IjLXol4w72yPB+glDtGG5enocVRRujyxPKg9mmGrvXdSJE2oGSHBKgV7C4O7Dc6q7/aV3IPDt7TLnWTRadAz34yB3j8wzCAQ0z1b7S6Sc8wtVGiBA0WZkXylPrmhvf1n46Edu9c4bG0AH0lg7zjjoLkPe7yaOk6o/ID7YcrcqDA==
Received: from BL1PR13CA0343.namprd13.prod.outlook.com (2603:10b6:208:2c6::18)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 11:30:54 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2c6:cafe::69) by BL1PR13CA0343.outlook.office365.com
 (2603:10b6:208:2c6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.17 via Frontend
 Transport; Tue, 19 Dec 2023 11:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 11:30:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 03:30:35 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 03:30:35 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 19 Dec 2023 03:30:34 -0800
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
Subject: Re: [PATCH 5.15 00/83] 5.15.144-rc1 review
In-Reply-To: <20231218135049.738602288@linuxfoundation.org>
References: <20231218135049.738602288@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <e62c2aad-a21d-4250-b8ab-aac831f75093@rnnvmail201.nvidia.com>
Date: Tue, 19 Dec 2023 03:30:34 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 649dcba8-9409-469f-38e4-08dc0085f68c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gjFrN204NOCnRB23hRpBowxJG9WkP1lOdcD9bE5/SIwB/J2E8p4RrHhP/DImHlU85ScHQ/LMXe0uIU3FdxhQx/jU8fX3FC/SCaIT4WaSuni9UT3tbaS8vsN5bvzF+WCUELC91spcbq8jB5TuogVXiwQJ4yT/jwep7TPglSS1l4QPKXd78M6R4lIsFB8NJps9kKp0wPILZ+mnkvb9Sle2VBFbeDgPulKjaeKrNrrp3M8C7zujrntM1AYUEoIo+mgmDFV83Ae7uho1VbNoptYQb+5dswIxlxpygC9p68hdHm8QTsg/uaCWKJg/DZQY5O5USjBt+dDnZePlHJ7v0TEW1bqkoZJhDM6nimiWdxr1kU/6dis8Osq2dmctHi+p+Z05Db5tyfYbqeJIT3Oi7518UeLT8GK+ivDd3sXUz5bu5QyBOVY3Eonj5/stDMvHQ0WvcDWb9Bf/+l6Na9D2oOBy0GlzK2PFwePtVf4Gqfl/wkfnL2sdv8/CIlZl7k87GRT1EuKjxokNM4t9+EwYr9k7nXlHsvyNMFFL2gHM5dFuEBnxsFxAQXh7B0/oomOesFmL5WGqFtrZce1IsyOEuPJyDOZWXMLmC6xv0Opg0u8qj8pZx7o6H5a+3r7Opv8iX96EzoktQCU2g0GZKDZBmEOf1bUPzj8Or14CRwRT8wWXKtm+GRvP6eV5xStUjD1E0BzhlocWqz86/pFkQgoCd2G0kwmJXr41gJkgZcZ4e2lTOsawy/0Rd6X0vrKmg7M2RZDzrKKbz9xF1o704JDQSUXM0CBruMRoDFIwxcB0tzp60Ds=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(82310400011)(64100799003)(1800799012)(451199024)(186009)(36840700001)(46966006)(40470700004)(6916009)(316002)(336012)(426003)(7416002)(70586007)(54906003)(70206006)(40480700001)(2906002)(4326008)(47076005)(8676002)(8936002)(5660300002)(36860700001)(26005)(966005)(478600001)(31696002)(86362001)(31686004)(41300700001)(40460700003)(356005)(82740400003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 11:30:54.4771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 649dcba8-9409-469f-38e4-08dc0085f68c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728

On Mon, 18 Dec 2023 14:51:21 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.144 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.144-rc1.gz
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

Linux version:	5.15.144-rc1-g2d628f368ca8
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

