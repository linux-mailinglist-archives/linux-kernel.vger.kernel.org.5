Return-Path: <linux-kernel+bounces-25885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA2182D742
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039032822FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8702813AE9;
	Mon, 15 Jan 2024 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gC+Ekwey"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D72101C8;
	Mon, 15 Jan 2024 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWVych42aeI6WXO8DDBxeHm88H4ubw985xJXdhDMEc8HrLbwVfsskTrS3j5MaZ2awnAygvCpqZI59TTJoz6kcwgp1mhyrXIm+poVqNysTp6A1eehXHp8bB+OBPJRaTXYHASIe/KskBxuHQIv/KAuwtOemrITfsPa1Gboc/oS7Su76qm6tNku3GTykYKGJDe79XY88hMfbBGHkqFZ2TdE3qjKi+ORn1oo6Z/eTRMSO9RU5syPlhCOB+GvYkiPpW+whTJOyoMGQm7A2c3B/vJeuZJ8ERG98r2ju+zXwVvwwg4Ok9WPr+0OB0fEWX+ycYKKLXv+dVgSU4d4ZVXygMMOVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4JFDBvhCMkaCvpLowTOIdaZiG945sBJOW1ik5jrkW8=;
 b=GQ2dVd8XjjKhf4os4flhj1ujOMbMUzhUboRO3/GUr2rBttgZCC0DjtVgQHUOwgjZbYIXyND9NrMK0p13uH5jqe0XpuDSgvSsRYTJLhmQG4k1W7QYlJXn3OasjB5c0LUQFzm7Q0KudURAcY4W6H2PpLXJFjgWTyUNYwhrEG0jouLW0STCmB3L3SSuhZzvXa4hrbIJB5SueBDmrJvWVMoTt6ZeNFzDlUPRJcGfmkpHJHZ/EXU7y3m3dYm4pkTT8Y8bI2tHB9auGYF/MnpQoNUCPsypUnNbGjCMoxc2M7zYW00B93Iv+WZrlS2bDwU6HyNO59qrwHFbnC3SHfljKUqSag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4JFDBvhCMkaCvpLowTOIdaZiG945sBJOW1ik5jrkW8=;
 b=gC+EkweyoR8R0gpnVHpN4VqC/59lVt5wu7wsvvIlonQasJQarZYNGIB7mbaacRvdvruAsjEf/C60K0a084VJCF1O4+o1DE6Uij+UEK/Kbm40ikrQb4krwgVjO6W9aYPRbMIkVSSXD30SqjtYjyUuINAmKIlL4erdr0p+pVNAF2sQoik4aSCjGhjrJsm39tbS0ni3+iNflNqKk1pMgLX/GqSgO7Rgv7SkpeEAdeMn4vGQ1NHDxifIDAFCVNny8UDLcQ8+7/M9Gy1M4K9a1R9UgPFH9PGuiH90pBY/snqoZYEMc3rWOncG45GQpgxniUgB392d9k+jJNIlZAlSF4uTsA==
Received: from DS7PR03CA0213.namprd03.prod.outlook.com (2603:10b6:5:3ba::8) by
 CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.21; Mon, 15 Jan 2024 10:24:53 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::5b) by DS7PR03CA0213.outlook.office365.com
 (2603:10b6:5:3ba::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Mon, 15 Jan 2024 10:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 10:24:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Jan
 2024 02:24:35 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Jan
 2024 02:24:35 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 15 Jan 2024 02:24:35 -0800
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
Subject: Re: [PATCH 6.6 0/1] 6.6.12-rc1 review
In-Reply-To: <20240113094204.275569789@linuxfoundation.org>
References: <20240113094204.275569789@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <140b98c0-6a43-4b70-b515-e2b974a2bf41@rnnvmail202.nvidia.com>
Date: Mon, 15 Jan 2024 02:24:35 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|CY5PR12MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: eae138ab-057f-4404-c14a-08dc15b436ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9iDfh9iaMfqmLvQT+S9gKKKuQFLc+9+20wtgJI4rMFTUspqxoVhV9ny42qGC9/MjE317oMmFvgd+kzHRnSdgbNTcSy8RkcJo6PP+BeHOgln533LUT5RBlKFErxv3pCbGjnNSRJQVZ9JugRLr1PqHYmEwVPChmWzTbvDvCQfkVBDQZwDG4JXICCUqmhuCGshhzF+awiowqsAc+mKp6BVQR8WSV8Pkfs8TEO2r72yAdm1nUjaZKxpGIuXyT2NFdf1YJLF6fQ3CrkA9cdB4KPQ8ll7cDTHLivnuvJeUtw3euUnnMGQgnHxlp+/OZpdbdvslNEhmOcoiHkjx2fsVMNgzmWVcG0n9LBdvTnJUecdGwc5aCi2v9L6Etg26QpK2EY3qbQiw01W0PzVKTtFFw3vv0HbZ/wtVK3dk70100h6Sob9xrhewgr1c63WFzFr3hBucImEmyvy0arpIahugOc23ltek4nXxVi1wDGBX7aT2CguG5dAieKrVs4eQIl/Izb8qoSQBeXK8IlRHSvo/APaVp1g+C8lRK+/UlywFJg/T/+cTU+P1nsGmV6GijYy6sXxF7gGgOrzor3Rw6V7X1iVDnRFsPtdVNuqr+z5CPXnu4Xo6MvmL7rYCrXKgYR7cfeNfcBwVqfBKtibBOHpl/icYw4O6CqxvxpYex1xfH3WOUW2K9MAgou59DZspq2reMs97s3ULXnULNgmDZbtoz45j1W4yIfIpVmtXJb0u9lIF3T0QdGb4+CH74b8EolkUuKy7bk6XbJtMTx4VB+SWtJxdy+RKuTLNAQgazM0gjRAcI8E=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(46966006)(40470700004)(36840700001)(70206006)(70586007)(966005)(6916009)(316002)(54906003)(478600001)(41300700001)(8936002)(8676002)(4326008)(7416002)(2906002)(5660300002)(82740400003)(7636003)(356005)(47076005)(426003)(40460700003)(36860700001)(31696002)(31686004)(40480700001)(26005)(86362001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 10:24:53.5023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eae138ab-057f-4404-c14a-08dc15b436ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274

On Sat, 13 Jan 2024 10:50:58 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.12 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.12-rc1.gz
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
    116 tests:	116 pass, 0 fail

Linux version:	6.6.12-rc1-gf44c56831910
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

