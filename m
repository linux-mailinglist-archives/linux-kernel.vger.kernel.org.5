Return-Path: <linux-kernel+bounces-19346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6DF826BBC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E457B20EDF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6ED14005;
	Mon,  8 Jan 2024 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P72lV5mL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24701426B;
	Mon,  8 Jan 2024 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6+55NFWzh+6sD0nrtIyoNmpTnR0hx/ps1VNi5ZkPsbE520wObwJeLV4LuinozJdk6mXHY/ECWr16ETFReWsjj4dJbsCODWqT91KkyvbU8aOsJPoBkq9teOgiwURaAbqeiog9wPGbvrtE2cObk7tCQIwI53wpWoQ7Ci2GxTowpDAH+79NzAqyV177beQLm324ckGS9n68F/zn7GV1auGfAjtkE/wVXYPwBODMQQlCrY03PQkS5P6iThSnTeyM1P5uoRixEXMBCcoUrpsK5xTbNeUjq4eFRmn4vZxmMV7NvJXqypdjkF5mKzxQheXdblsn+DIxr9tArplBZ03ErDUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbqR78B8QXd4L+yXp0jJ8bdI+RolG99A235jO2t9UxA=;
 b=X4ScE4SgF1ee8ryyYsdplCKJUzAB+/GVaaVJi3oMH2I0W1MmCtiVqpvWAcOXR0uHIf9tJ8Pb/qqVofG2Z0Ws9La7TlDkm47hSkBQW0ttpypTf78Gj2xb9bFECQzgWfTw5e965tyGk7Y+/WFjsijTG8ZHCc5A/yX7G5uJk2arIOA3X5yQs12Qp2cHK0JouvT1m2ZFXaSD3aBPccVauP5oqYAOVBksl569i4W9FB1hP9qChcEz2RM84sD8TWqMukpr0BUCu69ec1V8vkW9AICf4u9PkHMI3c2UsGKU8qzMRzi6bho4cYEHKX+pLS2Gop2/YMiEauh5C++9UPS8Btcx6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbqR78B8QXd4L+yXp0jJ8bdI+RolG99A235jO2t9UxA=;
 b=P72lV5mLWP4Ssl+qhG4yWyD0HPAhgCwCIVYg/J/iQEh1LEfk2m3fgdegiITv1BaaA8zMic/DiJjvTf6rtJ59hIOysH5Xn8Cbv/pqW4KT8elwHFNdDVkFwNAfXEZ9ZHCWOvFiOevshw9OsFYFY2ncJo2ibYf3+SboHEHTuR3aqKw68f6e0GVJNfxjguSPKHC0XOpPny1vTzksQBhU8Ea0YdjevAg7PcXdg3t2d0TbdtimP4O1r1vGuF7HildFW7FGx+kCQBeqDA9G2gWFSg5swJWQEAKURALlW0I8WE/GuhA4GlPIvDq49eqC9CtxNOhRl9N1bcohB1ML04id1L4Qzg==
Received: from BLAPR03CA0132.namprd03.prod.outlook.com (2603:10b6:208:32e::17)
 by IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 10:44:39 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:32e:cafe::75) by BLAPR03CA0132.outlook.office365.com
 (2603:10b6:208:32e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 10:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 10:44:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Jan 2024
 02:44:21 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 8 Jan 2024 02:44:20 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 8 Jan 2024 02:44:20 -0800
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
Subject: Re: [PATCH 5.4 00/45] 5.4.266-rc2 review
In-Reply-To: <20240106084016.200641776@linuxfoundation.org>
References: <20240106084016.200641776@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <664a5443-08a8-419a-a3b4-5654138b97d4@drhqmail202.nvidia.com>
Date: Mon, 8 Jan 2024 02:44:20 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|IA1PR12MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: c041001a-b9a0-4c3d-f340-08dc1036d0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yGVIIgYUoFMzx1ibTLUWPdQdObIbY2cJHFyFVFtSyvakiXIB8I+dYR9JgqbHvPqSrCMc0NDS+WTVitKOhy3bcVXMdTEHDOSRucWSHLk8XEwQ6dEidtecKTPVrsvVXpCcUpYRZ22a0Ke/ulmzkOmHmGZ+qVZ6fhM24hujBBZotYfhBpWR42P+GX0Mv2RYjxhuKZllFC4wxBFFNas3TXpMKQCEwORTLX6ONxQqTHk/Pnc7eVwl9H/+ORO7jA0aTUFnbxwx9Hba74/PukaqpZIq/Rke5psdf7a2hnYYMnqyVqYxWRE+gS8rbimgkA0xvKWUm6GMWN65rSpYWZceBJHiKqtF8XbCdcopho94MuRXfZ3YUV6ds69c4j5+wFkO/CHO4jHiSW5vsy4s+Va4UVAYKbMwubTCrHB5IuH/zg48YZBPQtQvCZK23i+Jl9ZTR5KNm9QAP6pAINXf6dLm/YPQURWbNJ/5ge3GlldC/5oqak+bEJTrgXUneaG6TSlk2xRqh3nFppY485aOTPTEdKjRhdIbsVXhb73QJj0qVQVHVkuxKqIYJzmVt1n404qVvNJcFfZvsAmkkI0Txtox6ws1ZxaItbVzjUnb9Frc5V3j5OxL60wqOmpQ/48QmJeKYlGv2eymEtmi2jaKeK64R7t2ZeBlGRuxaaUptT6p0njK9aFLe33Z7mRTLmP+cBJTyU5bo1e5kf3ok/ZPPiplE6/IdMHgaHt2aBDTz4ifR4yNxCP7ByQtxGQEmPUgM3vNQEXHY8SVIoM5hXXHxEOUXlOkkXV4UKoFvLiuioEJdeLxqxA=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(316002)(70206006)(70586007)(6916009)(54906003)(8936002)(8676002)(966005)(31696002)(478600001)(86362001)(2906002)(7416002)(41300700001)(4326008)(5660300002)(336012)(426003)(40460700003)(47076005)(40480700001)(36860700001)(26005)(7636003)(356005)(82740400003)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 10:44:39.3887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c041001a-b9a0-4c3d-f340-08dc1036d0b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234

On Sat, 06 Jan 2024 09:40:33 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.266 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 08 Jan 2024 08:39:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.266-rc2.gz
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

Linux version:	5.4.266-rc2-g27678f7dfd94
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

