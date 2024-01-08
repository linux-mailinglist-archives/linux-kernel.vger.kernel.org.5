Return-Path: <linux-kernel+bounces-19343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADCE826BB5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30C6282EEF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8B314270;
	Mon,  8 Jan 2024 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pWFQYBYf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A89C134BF;
	Mon,  8 Jan 2024 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+LxUL6IsZm4ocZ9T6jpX/EtevhW8H0gZrzJAbB0cJ8D/3BlaUYaFy+7dLCbwIst0G378f/m9g1MCwYevoZWvJ9LDSWd5maVsg8kzSvO5a4yG/tmtWV9wayHb+MmJfHUNC5nXXsrvQm2Gc3VN86nk8jyZsSh0CjNf9fOo+hxhTrz3Pb4M+Swvh/DdXp2Y/bQZ09KksK1K9x+bIlRxpmwrsgGJuS2fQ7d+cxqRqzL0or7B5PwKH68K30YctX8GgLLbBYzAccZnh0JEC/e+WugbLvdsMgKqG7aPsLRKCMFwxsgPiyjWf7dbMPXWj2hVgNxt/QyY8u30qVfThVo6kxpIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26qo+ngDCraIHUl0R2YgU4gQP8W/hTvShUZGFDu55i4=;
 b=A2m8/k04Yj8zLB3d3e8uobsi7ofhUYW3e3CRCGr+AXvOls1tBdzM6sdnyb+thxFlIjmO+ndIQbv5VaqM9UbxCH2HTY+xkWcxE1v3Y49Ahm6TuRJuFTV36bgkT4nt3Ylb8Ro9DBzbb6bz15R9V3po6q2zF0fxgSS0wz7/zbAnx20E7EThspJOPW9e2l95/5LpR6THdt9G0qH65nd8WORQJxg4Cvf9uy+H6ikPZ9Kg8u5EUykJg0T54iHk32RJQ5aYedW7g6Qsw6LOCgLFaRI09+f3/DnWwehJMgCZCy2xwvxLa7IRM2bV9CFgqmB5QEazLMXRZMRoMaoRVgyoVoysRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26qo+ngDCraIHUl0R2YgU4gQP8W/hTvShUZGFDu55i4=;
 b=pWFQYBYfZGHGpGc/YjIOpcw6c/C3LIdUg210wE1A39ASJzoRjAr0E+y+6AGN2qQy9NPWLGoPoXdjSGrEau10uo/GAUOHDZtVes9Qpbguu4v8DDDPzylzMhzLfh5S1ogbyNDG3DtUqS/fhWPgx2FZOghMeNF2q159RbyZY+8fnoaN2P0+Of+z+5RxtHe6N//QTw0Oy2E9Q9b3mXWej1aS6JymZfzGSP4ROgug6WyfjjRvLa1rmIv2sX065URncvZN3zPJG51cILaTPSY5pohDnZ1xYrfQjFFJrhlkXscZhl6mGexK4KE4XZc+fjMpuFTpNyzRNN3ah6w3BHN9S5BM3A==
Received: from SJ0PR03CA0073.namprd03.prod.outlook.com (2603:10b6:a03:331::18)
 by DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 10:42:57 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::c4) by SJ0PR03CA0073.outlook.office365.com
 (2603:10b6:a03:331::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Mon, 8 Jan 2024 10:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 10:42:57 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Jan 2024
 02:42:46 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Jan 2024
 02:42:45 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 8 Jan 2024 02:42:45 -0800
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
Subject: Re: [PATCH 4.14 00/19] 4.14.335-rc3 review
In-Reply-To: <20240107123823.571931307@linuxfoundation.org>
References: <20240107123823.571931307@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <41074bdc-52f6-4841-bea8-112956c5f762@rnnvmail201.nvidia.com>
Date: Mon, 8 Jan 2024 02:42:45 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|DS0PR12MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d60d49-3831-45c1-23cb-08dc103693bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FPGBvzsEpUoqBf9WWJhac/B9MYuG3cjZp0o0oz5a+auIviU+DtJrMbz+YCMSaJbOIY1XbUAa/QvD9mFDhenqNcOFavNorT4hb+VhN1XHx7nMJwbpdEQ8nJnfoskFPCs7UOzQGUSufN1/Qowd1wKWwY2/iagY+mw6hzi+2nifjrfPEbVwYXdB8CK0FEoTDhq87q2JSMNlHyUH5eDEU/lulycHnsuLRWW0hIJzLaj/CY+Uc+dK8kWzhSgzfzZpFc+KiFkMc+uof+16RaM77eGmgQwaH2FvPyGL8RMThbCZyqsi069sgLy3LnAvxbukOk/ajpMje8Tv1d6FUQ4Sb0bKfSfu7TlVlTeYrY9iLpW0J3N+JK4XDpsO28JsKeP43NVAymJBQgczpXda6A7bmmMu7lj5IT7LBl2BWqPBy5Kv/kLBzsaQYTGRmG+CMdejZhsU1aOFWJ/6LK5daY1C3LMhqnzRj/QY9mJfnsaojjbGK6X85RDM/d39NTvtpPDnjBgMw1DMQZmajf9LxYFy+F5ns4WFKN7XzAx6HGkDz6pR9mC+G33w0z5ErQDPyvr60MBEqUN/hQS/xmrOh8kf9MZpnZMHqm0rlbDsR8C/n8HGunBLTOaI22zZf+4n8WX9LSXB33U9wL4eDQqhd5Gv949fKbAlmaZfXSF1M347vfHoAjAJiU60AANkEtYKoupG/3NMcV77hD6Mku8bxeQ3LBY1oPUP0FAwr4IrOUlIzmVXrWeaRImvZaqgFYprdL68hB8ocp9ezyyXD6bnkTwgJpmfeIg0NPjihyvozC4GK4a+s0g=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(26005)(336012)(426003)(478600001)(966005)(47076005)(5660300002)(2906002)(41300700001)(7416002)(70586007)(54906003)(316002)(70206006)(8676002)(8936002)(4326008)(6916009)(82740400003)(36860700001)(86362001)(31696002)(7636003)(356005)(40460700003)(40480700001)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 10:42:57.2379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d60d49-3831-45c1-23cb-08dc103693bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486

On Sun, 07 Jan 2024 13:38:33 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.335 release.
> There are 19 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Jan 2024 12:38:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.335-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.14:
    10 builds:	10 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.14.335-rc3-g58efe9e4bff4
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

