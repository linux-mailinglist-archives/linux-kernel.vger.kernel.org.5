Return-Path: <linux-kernel+bounces-25880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD1682D733
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC2A1F220BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A04101E3;
	Mon, 15 Jan 2024 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PCcSvILn"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8D7101C1;
	Mon, 15 Jan 2024 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXS9U9TCrgNzCaoyC8E+aGupG0AwADcKMF20Jw8gxxpLPCXtE5KdVueMIZKSqvSpp1RitDM3ObMb+r35tsCa6SvYeNTW5b1urNJpP6OjsxZOMQ+c30ry+qvsGmqKTmiJPSYARuJsTIlwGMuO4+KpTvgL+SyHTMNyb7wsenur5ax3zmtNntMHN1V6vIfzstHglluWSZURCsfuF5P19cxcya91mq6qU4tkWP7x53qB3OaU66rmEFi2SOE/2vn+VO9em3Ndw5pQKLOg4qT/7s/VLRbTHzLzZ+hJsPeQn7nToTYkZYWE/kqXjh6XkcfwSK6e1nV6Q3XE27ODXz73LfPirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0sm2CSOtsYWL1ekXbon0kV9Ps3azI3I+L9538Xwphw=;
 b=l0QD+g3pkg6Jtvcb/rJjw83jBWqF2l4Gy2/9NR/ZjWf18ucNFUtOaiFZYXh3mpjpWNxw0Ybv2eBFoJZIhkrr7yQGPJ3+Jd50ZuplTFYOES64aAc0cYLJinEL+pElFKfU8hDUwVR3sa9T/AdnvfWe9PAOgWZqlb4khTVYKiH1x8rERP1IUZNgfp9eX8QdvsuzB6zy+61MlhAD2nZbUb/uk/sTMvJhqOnB5w/iY1MvYMu1vxMbs9e3umLPPWnYe+2HteOofqqkPPM7yx7mrDw8DdL4cl2fahMuBOIVlMwqtL6qXnItkf1Vzrz8IShHmtX+3RWIY/XZV0ODDVe8YS1vNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0sm2CSOtsYWL1ekXbon0kV9Ps3azI3I+L9538Xwphw=;
 b=PCcSvILnw52P16DxmDPUsqug70W1/I8GiuJ8IHtHKUTHIImfcG3CYJVijoR3B9v3uJciMagHBTI5kZG9ih+lJI24D3ldy+SRsPjYaoSj95XL6oR6bLJBIicBS+oQjToa8W8XhTGGXRtttgPN2norQbUUE/a3bOog6ha6hVmPBboiPY5REMY9tOKn6y7zIBhttK7Otypgj8KkqQTuIjVen4asDbKxnSkuCEinOjS1DEKAo3xbBzCz5b1hVGmGTur8ItYqmAjzFVZ3P1C9Plnz59jTk3SkWFjZXgAmmFafMV5BUA5HuWUHygZYBjn7yWJJCOrS64WPTDHiSY9usVPK+w==
Received: from MW4PR04CA0284.namprd04.prod.outlook.com (2603:10b6:303:89::19)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.24; Mon, 15 Jan
 2024 10:23:26 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:89:cafe::23) by MW4PR04CA0284.outlook.office365.com
 (2603:10b6:303:89::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Mon, 15 Jan 2024 10:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 10:23:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Jan
 2024 02:23:21 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 15 Jan 2024 02:23:20 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 15 Jan 2024 02:23:20 -0800
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
Subject: Re: [PATCH 4.19 00/25] 4.19.305-rc1 review
In-Reply-To: <20240113094205.025407355@linuxfoundation.org>
References: <20240113094205.025407355@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <0f51a020-ce31-46d3-a2bf-cd52434c80bd@drhqmail203.nvidia.com>
Date: Mon, 15 Jan 2024 02:23:20 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b134cdc-75fb-43d1-125f-08dc15b40282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CawBj73gkiY5+HY0Oi1WI7k6EBaoOWWLpiu/mL1IpLiG8uVrn16QO0Fkm++KnrF4eMMxwJS+FknO5wPJsU//e0YDBL7PGhlHE30qVxg7hY2d+2N5lBRuM1DvQFi0WYBLKzdacpZ+JcXNkAe1jdpJwomoN9VfrraGaQWnyjhnt+npeZPryarO3mmQvRaMv+2hi77HXSgiUjzWKXLq77d4y17WF2Uaos9CVxB5yfuuAXgxhltgNBXY1c3r25pjvdx+DATvsoEvR8uCYVpdb+KDWIGdaCOGkdqbZtB+qUCGcmmYDW9J4sqQ8mP33j+edV1idlM0G/ASgJ+VBoj8wtV5YdiFtj8sSSMGzk3MoMBxEewc5Gu+nJ4E+8lzBb80VEMm8/JsRDCOzLzHjeLwu6LM2D6MNdkRW1QtXi+VYyNmSCG14w/cU7zcyWHpAkFY7PgXpVcK5KAmzHt7aij9K7g9oXn1Yh3KvzRzUBc7lCy9+DQvBIP9uf6p4ytN7Uew8/GCb0ZVFEbqTABuYl7eYLuJDsF/ngT0ZLBTtTHci7WiKWBqJrG2yxV/WskaB2fCVwuwg+Ku3AY4yIfGe8gowFV0jiIfrCNFlO1jOjfrUaE/5YL+4mhznAWV7nJe2qsTf4c/Er1XhnXiN8TuksDmQ7uY0ydHNMgIRP+zVMHzZotGQU+HM6pLD89wG6peqGYL4VBWiEGQUNDGTiQ/H8g5jLD2ZgjKk0XJULqDTMEkvo+FiqTqtOav1F9t04e929BAlR1ZkLuLtbAPRig71aN8FFxCsG8kT9RepLxM5drq+TQFImY=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(31686004)(40480700001)(40460700003)(426003)(336012)(26005)(86362001)(31696002)(356005)(7636003)(36860700001)(47076005)(4326008)(5660300002)(82740400003)(8936002)(6916009)(316002)(478600001)(8676002)(54906003)(70586007)(70206006)(7416002)(41300700001)(2906002)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 10:23:25.9205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b134cdc-75fb-43d1-125f-08dc15b40282
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745

On Sat, 13 Jan 2024 10:49:41 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.305 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.305-rc1.gz
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

Linux version:	4.19.305-rc1-gcb74230da507
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

