Return-Path: <linux-kernel+bounces-5081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F93818659
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB4D28673C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3F815ACB;
	Tue, 19 Dec 2023 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OsdG09lX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C204016405;
	Tue, 19 Dec 2023 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXTXvG0sYVFKp0RLj/oIR1cPcooh8bMrnQlmD7B5U64QaGhmHbw7o+rx/coUzFzIp6XJBVxg/M4Q5G+Yh9wBodLndZ4vfxZQlcnsxD6us7HOQQndNhdVfH6C8AQf9gsRPRwPd6WESlAKvBEYbEpRsInDkBRrBP+Z4rLOFF8uUDXowOwj3T+jLsEZN7Uy7PwPrzSQYr0rts/rCyoQSzim2VBh/beOhblM/DYSmYeMd0kLJDU9hmLHyFDCs0e3KG7Jpn9kdWphTkfk2e8LAc28mui70Fh5Bldi981siaEaNwKnGiEAUiCSf/AciEadFNbdJ2jo5hmcnaSwMNzON6NwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGiA9hyXZJr/shqEpxBtZwsxCU1Lp+MBYudFbNw/DJo=;
 b=CJXf2sANkhrzojGQ6IE7hUSwgah/ripCvpIeLpfUWyiXm+uFIl9E2T5a5eV+FPojSRMJXoDhZaqlPADC6ctUAE5nAMt1UPY++fPhMfvvH5AP+OjqkxuSMCs0TNArBZ83jkhaG/KhVRAXbUbC42dTect/GlftpocYUvK8ICrjnOQnPdIXeLYMrqifOU07DDKPt1ppz9TjMSFraoLUiNFiwPpgZsQ6u6+CR8KBjqUs78OE5JmCEzEal0282UXWsZ8vZ/PF/1QcNSsqtypX3oKxa3njvQyn+loti8DKPHvxd47vxrMDR1cwqDiRdb9MrScW8f+wk2Z8Uwf5J+4ARiqsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGiA9hyXZJr/shqEpxBtZwsxCU1Lp+MBYudFbNw/DJo=;
 b=OsdG09lXggAZ4iXjviDsa3+iBxcgNeVmGMO9IOCyIFQWNLNP25+wF7+PB447t1NHEdidcI3QnDUMdk7eTslNztUomA1TlKy4bDmdznekdrVLiHY1M9VMrHkcOHfgQqUimFu3uFHvxzE4HOecuVazIiAZvPwee7Wqqjo+BRueerFZ5x7Tik3KSljYVQmE12P0mcA7mevhV9PkWURCLpMBhc/xR5IntdOSiaIUN9dLNdKF6VJNnTQ3VLWJ2Mv5ujrDSQ5+takTfHYhnNMNYtUr0djb1ANPet3Q2ivFcIQrLt2tgpOMBzLXPhcyLZen8EvB4eeExYAhfYmwlj7JTr8FGQ==
Received: from BL1PR13CA0017.namprd13.prod.outlook.com (2603:10b6:208:256::22)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 11:30:46 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:256:cafe::12) by BL1PR13CA0017.outlook.office365.com
 (2603:10b6:208:256::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.17 via Frontend
 Transport; Tue, 19 Dec 2023 11:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 11:30:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 03:30:30 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 03:30:30 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 19 Dec 2023 03:30:30 -0800
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
Subject: Re: [PATCH 4.14 00/26] 4.14.334-rc1 review
In-Reply-To: <20231218135040.665690087@linuxfoundation.org>
References: <20231218135040.665690087@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <de1bb27b-0ce4-44e1-b652-7c7868c3ad60@rnnvmail205.nvidia.com>
Date: Tue, 19 Dec 2023 03:30:30 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: adcb0caa-5ecb-4f7a-e7ed-08dc0085f1a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mtijNGgnrJUKlpLuu/FYvcK4YYQ2v+ttL9T/F+/y+AnGF35VBLemBs/QMn4efmB7Nh/X6c+W98gWv2buAP42BJwvArrqzuC8kRVpnuJQb6RbWOl1gZToXou7gxSO4+ft1K4is198GibUmNuoCWLgn+pP+N9M8Y4ja7Wum6766h5oJ8SUdWAEmTRrZVm1WqU1Na9zTtxy9hITya9f504sT8XKnsLPmgWfep/B5g/vsfXP+Ko74h5ZAqLeS5o6v0X+GqcXW67h95HvGlr0m+2lUnpNiSL9akMkXzUbxJ4oKjN3otJnYEDG25k3m3ggp2TPImBEZ8PG8hm9TN8FPs1Q1PVMWOs6pIDd33aRsxpHvui/lOSpNtYFPPQH1divkueBpb0CCjiABwaAhys2kqaeMSiUJtx+uJyDXVtZAoife2EMOW7eBVqwhszrWn9mU6b5QBOUty7bejJCqhXiL5JqfQ7TTEHye6ygxuSyMdq0mq6bK6tLuj2BliwYwP4zYrSmoNgUhgxExA9Oc3ULYZJ1NRMeqg7ZF5N/K/Y93SGgioe9AV7jQdg9cgfMWlMaLu9C6zHFgu3jxPRSnEARnFzTzCYZNXZDgw9hUwr1WdUo4zpuqByUDejnw9UN5GrrFzmJfoC9AMmJ9QjCVYfC2+kAPXI0Stzm7kWGtNnL30s/zraG80gY8uiXVs7oiFrttL2EgkDk8iaswpvbunpiB8hou7QFUmwcvx9vrb8BVnNMM1LYZdblDEADtsswoDVOIe5Affgp8AmIlEPMmvS4wAXr/plGshkXa8f5GFiv2MIe3mo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(26005)(336012)(426003)(36860700001)(8936002)(4326008)(47076005)(5660300002)(6916009)(2906002)(41300700001)(7416002)(966005)(478600001)(54906003)(8676002)(316002)(70206006)(70586007)(356005)(82740400003)(31696002)(7636003)(86362001)(40480700001)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 11:30:46.2568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adcb0caa-5ecb-4f7a-e7ed-08dc0085f1a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730

On Mon, 18 Dec 2023 14:51:02 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.334 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.334-rc1.gz
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

Linux version:	4.14.334-rc1-g2461d9a65af2
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

