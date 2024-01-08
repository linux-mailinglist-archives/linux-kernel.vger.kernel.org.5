Return-Path: <linux-kernel+bounces-19344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9FF826BB8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309C4282F1C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67F514005;
	Mon,  8 Jan 2024 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qRqRf5Yz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD3714263;
	Mon,  8 Jan 2024 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLSFkJ/9aPp4aqAZlrfW2sQjtbVEcLimJko0lmeF3gxWsnTazmyt+Bb8SUObmH6SsJ4O25QqqTZg1UGMdeCqXO1CspXHxS1qlmzh79SDdLaPoqoP78A4LM0rSaC3djHUFrJqtAe42Gb+PVc1dOb7OMw8FTUYC3t88zFRtrCJ//gOa2u5Ng9tjDO9cQ96OGYpJJkvJY9DlcWK9BUCiBrKDXABCw8H8YvkURP888zYWuq0sBu9Mb1jEfkTtng0eDz84zOlglkCQiDiMbRAnzFdrZZApU/0iOxXlbIo5L3cslR8bXd0Lyc0WR/PW9gPzm7xnzFRy3RHfYPT1I2pPkKadg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQ5GjlcWFJ36XYcI5IDjjL+TAahVu7WHl03GeLU7PUs=;
 b=mTtetPa/f7JDgOpH6gOj6UK4a7DVhd7x52DLxSbaRaHacKi6F8YF+4H0jc9K7X3sK82h9hWuiPy4Tt3xK9uPs4XtNFWFpfIrz5hwtElkvtCUa/Rco7SRVPpai18o06PBXPglTEDCjzt4npT1mRJFCOSqw9g8uJoscZCtfyPgieTxQUkHbbm2qiWZIxy9NbMGFGlIdzTDa0DNNTO1auZXVUgWdzHyYDShbSkuSNPQBu7IYrLS4jxWtb6/jkEmTR1rbxNUO/AJW1XUeozz5eklvMPelGFHEjNGtSwrFPsavJRlrS/vgoCkLQQa+q9POoKK8FF/3GEYDGduTW7q575PrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQ5GjlcWFJ36XYcI5IDjjL+TAahVu7WHl03GeLU7PUs=;
 b=qRqRf5YzliyhFhPkdZzZakvXxqCkDVUKzaeHoI6GKoQrC9d8yHSKpZCcIoXEjDqAtDGCNEsoKQZ3+TQH7EhsY2hyv5nK0l4FePIc7rq1nRXaho2VGzDcxb2wwqAUGyMuK+6EyDuExgKLyUNU99ohRzQnokxBKYPtDkO92lBGvhUeD76omzYnYNiscEF2kwZeLti01AGyq3COAc3kIupPx1EbF1ArVlgavRFlhsxTiU9/AeqkgPwFU4aEnzhhXmbFeD0hjAyjIq+OHMrVJZXBT5ZlnXxIkLzms8k/2FdK6FFerJOcgY5zV/qTSrOK9kO6wffXvNPmC+lvXOOlc4xEAA==
Received: from BL0PR02CA0092.namprd02.prod.outlook.com (2603:10b6:208:51::33)
 by SN7PR12MB7322.namprd12.prod.outlook.com (2603:10b6:806:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 10:43:14 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::4e) by BL0PR02CA0092.outlook.office365.com
 (2603:10b6:208:51::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 10:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 10:43:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Jan 2024
 02:43:00 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Jan 2024
 02:42:59 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 8 Jan 2024 02:42:59 -0800
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
Subject: Re: [PATCH 4.19 00/41] 4.19.304-rc1 review
In-Reply-To: <20240105143813.957669139@linuxfoundation.org>
References: <20240105143813.957669139@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <0bed8009-bc89-40cd-9056-fe5b74d98ff2@rnnvmail202.nvidia.com>
Date: Mon, 8 Jan 2024 02:42:59 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SN7PR12MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5cd86f-252d-40d7-b918-08dc10369da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mCo8V8GYAIONlycBWjdKQ/OmhwUKvB/Q6BfLoRW7/GOgx9rI4qsAjKoCZHyFhrUi4DtC9f6vfVnGz5eZ6louTBnxHymL24pBTl8YicYv4iXG0wbpIyxzapU/DjwFesVWUFnwqOxHU30Fm0wnrF5j1qWKzWCA0gcl1XbghMaT95D8S3kbplIE6+kCUidH7HRind2166XtH9PoNsAI4ae/UEfPg9+EF+SHU56Bu3xwKex84y+v2h9Hw6hsRVHkb+oyEHVnK3xMoilf2tQGQoZAKHnpcZ35LEFoeWGAcUOXg0Kg4JocUfkduMPlcOx+OKunS3nVruQfAHUQT2Jhbba2ASy8mI00+yFgPLRVR599KDIV77Pi781/9KKwviFMq0lifD15vN2fQK8tECzRodsPcWJv5sO3Jd5K4IAHs6fVeT82b/hldzx85TjGUjtCAnH7YujKYkKep+ROrlaAe2Ag+ZpzMxMzElc974lHws9iqi7kar+HcMP0XNL+wzHfFMlj9dylu0fbXkChN00ornYykyZq9x9eBaqd7eHCM1IxqIhJj4klMiKeNLUTYHDn8Qios4hoD/oTzB2XxC7pRnCj9ajVDpCrqcVy6N0Va0mEqupEwdEINpIE5BbTGTD73MYCJd9XKlmFNdYFGxkh0ietksStzslAzpigeAi3AJ0BzKc4VyD5fyUvnlx7bLjc7kMOr92plrVKWVtmWkSUsqvnz2UFWVwLaFcmj3h+V0gJqsqXcZPyXrDzk61jn3LOHGnfvrnE/Y7hNq8avT6E1rBOn+i6MX4f9QRzTsmbJY2Qbcg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(7416002)(5660300002)(82740400003)(86362001)(41300700001)(7636003)(356005)(31696002)(31686004)(36860700001)(316002)(54906003)(426003)(336012)(8676002)(47076005)(8936002)(40460700003)(70206006)(70586007)(40480700001)(6916009)(26005)(478600001)(966005)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 10:43:13.7095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5cd86f-252d-40d7-b918-08dc10369da8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7322

On Fri, 05 Jan 2024 15:38:40 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.304 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 07 Jan 2024 14:38:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.304-rc1.gz
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

Linux version:	4.19.304-rc1-g3ddaf9daf2cf
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

