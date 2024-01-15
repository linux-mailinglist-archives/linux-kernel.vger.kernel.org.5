Return-Path: <linux-kernel+bounces-25881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9652482D737
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3811C2181C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372A910795;
	Mon, 15 Jan 2024 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SlRIjveS"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988AB101C2;
	Mon, 15 Jan 2024 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHp7bS1i/XV30jAyKcEI9lMuFdEHWW/ICe210CEm+kvRb21xJeHpXkm8sN3WcTHXpRj1e4AhPXqorRiZNB7N5D4ti1/ExS/azDMXrrHRy8cCmFHvGgVB4CplD54n+KqYNeoGX38IRfXgWjGR3XRUv1w0gyhmPrJNRK2ol+Bc24lD2Y0MH/fXIvXN7TShISeYKR5A+U50GMIykISMkDg7HABEk/NUQBICwRIIszKWGbT8FE9+bjDkOKHg5QI5xHzrKc2Jq7BN+7msd1lh2LV8OrdKuAwoJzfoY1yj5XfLpSId9lIhNnYQcqeDkFVnFYkd3Rd9e9RZd6KyNWOOwrT8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GurMbWFZ3nxc20LnyAhZdA7VJchfGvGGhTRatO8khjc=;
 b=ReXx1KpoCjZkI+J2spIy1JkuJGhJqhZTuH+Uxswlc6dNhgcpPGLqaBhS85dJ7ll6j19pT854qNRNHOhhXNxf7X6YdFzzwQha7BEba0OSymGea6Zyimlc/x4kQxNPXkjqeOlt6ZJulq9KVVxnGH2up3mCI6WNXpFuiKVOFAhovlB+u2gSowGFWqBe7LtgGvL8ZIqfr3ZlNrzXvpjLtOyLKZRYk9wuhOjQtSzx4NQp0vDmJ/wkkBmUDo8fdVISPh1cEYOq27MclW7Dsrf6Eqi5SHV1fYUiX1sj6MRSk/17ANC5aFUv6FHycK1D6xN8/IUclmbWDsh0qZeHqyvfDatIwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GurMbWFZ3nxc20LnyAhZdA7VJchfGvGGhTRatO8khjc=;
 b=SlRIjveSe2xe3lFDfSGLtFUzFFrTEfJaGTSJpa15cgKx10QLtoDD4w7EjgI1tLM2liE6X9EnNBV1Q+h5S4Y6dxqKApWBSC8UTkDfK2BVtvpGDAfKyZS2JWQ9OM2pbocqbRI0GEehopnRlhqwbsQfkLsoSzp3wgY+6DdM4EgYwZMhMe94dcCn+c9IPI2DGkMfXfu3WPBqvJ8ckc0c0j5V2wM0EexQePMxT//6zmVM+qzEpPcodp8cQLQ30UWY5u7h577puMXjRTTwBkwiYusGBmSMEcoQypBozhPRMcnGKGt42IYm59MV7SHTV7Ua36x/q/MEgQqVkg23HvXkZSmmyQ==
Received: from BY3PR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:39b::17)
 by BL0PR12MB4899.namprd12.prod.outlook.com (2603:10b6:208:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 10:24:04 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::86) by BY3PR05CA0042.outlook.office365.com
 (2603:10b6:a03:39b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.15 via Frontend
 Transport; Mon, 15 Jan 2024 10:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 10:24:03 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Jan
 2024 02:23:54 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 15 Jan 2024 02:23:53 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 15 Jan 2024 02:23:53 -0800
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
Subject: Re: [PATCH 5.4 00/38] 5.4.267-rc1 review
In-Reply-To: <20240113094206.455533180@linuxfoundation.org>
References: <20240113094206.455533180@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <0dc76f8b-3044-4d04-889c-56140f7163f6@drhqmail203.nvidia.com>
Date: Mon, 15 Jan 2024 02:23:53 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|BL0PR12MB4899:EE_
X-MS-Office365-Filtering-Correlation-Id: fa5655ae-ed05-4645-5948-08dc15b41925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UNi8Iv1aCedPZf0DH7NvLhlu7gSAcchmfh81IQ9zV+OAe5+bq574dsA/L1PSP3SIM6AK+7MIqkgmw7g6Bi96+dZCtUoMRrArXMzgG728r9KNEqFVbkTYgoxBCr6qkox41cb/JlaiEPOevSrciDf/m6MuxZr4gfqjUokyiLPl4ocmpbF1Q6g/JYoHfo3OUAe0jUIDLMCp7muRTIk6pvXO4UMbmgrfh3GDlEjEuBtLQER4E7Bqhq/xEPWqk5yoXM1C9b2CcP6+5Me1UrdmWXBou8lVgeOkSVQ7OQrHIb/eRCKojKP++laP18nag4BRi2O8Gchwb3GRP3NztqgIGslhdWDGeoBXdKBahvxh8IRdI7XwtTv7vAPIxHuYmJ3JGxBimz6hCLerkwq6oUi+yedL7y6G5d0HyYjr5cZtg3ZBsruJuaZK1IOhcA9tf0zrSukCqLORnaydrau2u/02Kzq87k3w5jtnCKFRn/Mi87tmB3Sg7YddwPnlMG1sGgz68ytl14C3jpLdA58Akui/cHGDBgB40pCLeym+tmrheXT8HPM3AUsI5NwSVF5a7M0Rfi+f0rHPq2riOt2i11Rauawt7watxCIfZpXmDxpnmRyG3rSAtUxObFYQ9MfTIlKt+jbqR1ab73Kvoq6oeUNlxf4AzVK1u51PUAFFOcIRNhZO4UTP5hiEcOAt3X7a1vEdWX8D/PUfyfdYz+mXIneTLYOWrO7nW/jtP5fevwRTkn7sSd6DtDxQh2K8ue4QmpeVcftQn4xKBdIQcCreOLqKeohHmBPdRPxC7aNNUTq3kWG+5U8=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39850400004)(346002)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(336012)(7636003)(356005)(82740400003)(31686004)(40460700003)(40480700001)(86362001)(31696002)(426003)(26005)(8676002)(316002)(54906003)(8936002)(6916009)(70206006)(966005)(70586007)(36860700001)(478600001)(47076005)(41300700001)(5660300002)(4326008)(7416002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 10:24:03.9161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5655ae-ed05-4645-5948-08dc15b41925
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4899

On Sat, 13 Jan 2024 10:49:36 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.267 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.267-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    24 boots:	24 pass, 0 fail
    54 tests:	54 pass, 0 fail

Linux version:	5.4.267-rc1-g86b133f1f903
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

