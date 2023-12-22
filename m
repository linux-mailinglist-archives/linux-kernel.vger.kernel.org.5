Return-Path: <linux-kernel+bounces-9750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E260981CAB0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6981F234B4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE7B199D1;
	Fri, 22 Dec 2023 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="atUL3fsJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963DD1CA86;
	Fri, 22 Dec 2023 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJLiyP4xtEjzEN4x5KP8qrAI7fQMeoUoUfdoirH7v3b2zLV+kxHP3aCC0k3ytBwNUTZnaJSYlyD2W/05BuePOWkJX5XUQUsLo9htV+2dMDBMMDbQLQGaKj54bc3QND9571voLImzG2R2aR+b8MCMvGxU0WXoSTGuScJmRC5Z/GDykOVWjeDPCtNgqd97NvR/4WjBzgj4BB3D/+jJSXX9Ix8oE7f5yIAuMPShKYczwaFgln564WzYcFilxvHyj7DgYYYbgDAgzXwAlvoqyNCoXnZRzpInG2Pghc2T9tkVbFkYsyiFr0zH3mt/kkkP1FJgkpnLY1XX8lyPqT/9QJCuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/D4knUgQEtWVxKM6CeOr0J5s7RNx4TRWfVnTvhfXjLg=;
 b=lJyyl8aqyUpnWuRK5CpQ1w8vd7nI/d491DiqPXWHTYqRrOUD5kmZVfA/PUgy0sC9yCo/CFrt5R7sZA4j1M5kIHjkEplLuh+gcTUm3OZBGfu5ytrTGYwUkyGgC6QglIiVKVCaVD7jdR9gOCDSehRkE0SnnnZd0SkvOJv+n58kd6jUoxezud7ij6VJgE6/KdrxnmU3sk3voZ9ZwdPNiqR3TRdcIEK7OJL6ql6uI9+zAF8HjcOYd8PhPcyhx5BAloZKApDaaKA7zji+/AHc1123CvxMHaYtBkpxlnFey/C5vUoMsINscLSkYj0BQI/rME8VuYUlelQjDuLDgISI5IulsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D4knUgQEtWVxKM6CeOr0J5s7RNx4TRWfVnTvhfXjLg=;
 b=atUL3fsJUCG4iwch02Z2pTNNpBziWM45Qa0LOhUCBxAUDVTxEI95DHw6XxVtgmDBU/8Rdl3gWBqzRq8NRxl84sBGSmqN3+bpmL6oabtHEQETARg0EBRXjQNRY7y4BD3RM/BPV1GW1HivUPoJjAL0ECq4QCMIAfV0GpSjDjoJW7hHhucBQWeNYJkiXO/klqrPA6U6M7G8SrfJ/hB0TNBBjTYqnH2bKUT/TKx2jjFw1ByIruV9Qn6KTdgz4jm1EAXnCkh9+AGmLhdNH/jFrq/8PAkP+bnrCArRtQ5cVpBKFBiibnOlwLj3CLfdw/Ma0JqKWpjGNrVKgU50FEspdNixUQ==
Received: from BYAPR05CA0071.namprd05.prod.outlook.com (2603:10b6:a03:74::48)
 by CH0PR12MB5201.namprd12.prod.outlook.com (2603:10b6:610:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 13:28:21 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::8a) by BYAPR05CA0071.outlook.office365.com
 (2603:10b6:a03:74::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Fri, 22 Dec 2023 13:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Fri, 22 Dec 2023 13:28:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 22 Dec
 2023 05:28:09 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 22 Dec
 2023 05:28:09 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 22 Dec 2023 05:28:09 -0800
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
Subject: Re: [PATCH 5.15 000/159] 5.15.145-rc1 review
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <e543e041-cdc3-418c-8fba-de7dd5f3ec2e@rnnvmail201.nvidia.com>
Date: Fri, 22 Dec 2023 05:28:09 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|CH0PR12MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c59df16-79c2-4a10-6768-08dc02f1ddbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4fHYa5/UPqC/SZcfNTnY2WyPLdc0pSVicoY2mqjqcG58HPc4ArQ0w0TFAfV6jZeNA3S7lv1hF1401coZGJBSUY+R7rYoLpKS13eiByUz7qsuVsoM2WuEA8EWLFVBI47t9/2KzBiMdmsCHpWTzlmipvLrH4Bx6RkTsVHFINkxbYhY8iX84Qh8vbzIpataUMuNrqjfWkhH/BFqKEzpME9xF7QClRUiWNWHjw9f8Cws2WdaHMib11RdqoIP/cjse6IYJIQmUUZr/O83FsvKUAS0QBpjNw4ZUmnx0QlU98zzszPjxaBFZ33kUgm7C5XIPW3h+KS5agcmQop498UGIjraJi2NJFnbxRHIqd9aubft1/q0PCKeaAYwMa7orNlkQXWktt34JXqhpJYY64IK2MS7N0EEKVMcfwS3nGvJrhmLxHKtnDNXjpkifV+GuMYD0gNHxMNO7olSBdZUelyhgN1iGmjBxP4S8fYe0MG4ZI6StlRPr8YlqbGgKv4Z20MJOaCpdRLUhaVqa7gNP5LjfKv9xQniZYSDM+paLCxqubDt0Pq7JWRFchSOvBhQxJJ+pnCn5IWq/sSpng6x/iSim0N/VCi/cLn1OJrUeJPLt0Gv0x32N4G74CkUF2Dyl5/4Dn4OQRH1VNeid3kHf2S5dwY0RAdVToVWCEKhGE1sMjkFNRz0yQ/yDHnIW/y4dUk1JQ14FZ22iV5PbdUltik1LP0+FauPoawbMWnX49wNmQN55A7ywFkegddhvT4ajLO4WAul33aVqfetFnWUNTWYuglTIl6yyEWbVV9Q1BEOFReR4Lo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(36840700001)(40470700004)(46966006)(82740400003)(47076005)(41300700001)(356005)(31686004)(40480700001)(7636003)(40460700003)(31696002)(86362001)(36860700001)(426003)(336012)(26005)(316002)(478600001)(6916009)(70586007)(70206006)(54906003)(8676002)(8936002)(4326008)(7416002)(2906002)(5660300002)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 13:28:20.9069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c59df16-79c2-4a10-6768-08dc02f1ddbd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5201

On Wed, 20 Dec 2023 17:07:45 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.145 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Dec 2023 16:08:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.145-rc1.gz
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

Linux version:	5.15.145-rc1-ge7911feb56b7
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

