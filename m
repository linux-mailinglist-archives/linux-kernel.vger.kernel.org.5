Return-Path: <linux-kernel+bounces-5088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB04818670
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87291B236E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1296415EA3;
	Tue, 19 Dec 2023 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kCI96506"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1331802A;
	Tue, 19 Dec 2023 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhlGB1FDeRBwDS2L968oHziCH8i7ZRZ4+aemZVQnvczq6xj7sUwNqr/8dSxob+yeGz/q03jCG6rIGsabxOMWL8yZmJ33VdEnMd5pWUDSxDLHwLUyaOBAlWUIDk5OpU2GOGPs72LWCO7BlagANx4nX5VG0EfatrlGqh6uKDYMTAhFh86A1EhdKGdptdJG29PBli1HrAP+GVEiQYVx2vp20F8JxyjnYmb6B87Yyk3jWPu8leHqJew2XC5VPZlf4zc6ZdAti+CvvWRorXwHr9U5/art4V7jduh+c+ZgjwcS0q1nQ7AnWz5VfrsECNslLgpV6Rym4shGZABrQ+sgAQU8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k31RBGlNX7U3ZABGKo9YD0vwR4InI0xEA6s64n4Uj+s=;
 b=d4ESN5V32TA9eUwRnqQkB6dmGsFkN3C2M6Ur+/776Oh0WOmmN6IHbTYF7NW1336pkFkPgDiZdfOZdPYsfdyhrsGjbbaAn6c0044oZsPpT+YQT/hyTYT12vTBtba9g68WMa8mD4/PJCXr+MkzGiqgAnC03PQr/v1dw4M6ngab0tG1VIVvOfHNshtIZncQj287hjzUXd2CN6OrdEtxTZs2LJtVMvb5azgnb7BHRd3U568ob7iN6vpN+Gsl9doxk8VYaTPfd0dZUaoEgxvkdgXj7OAvH8pAgM7MsyHPpXCvMdCrF0h+2DiJrY5hCYlkHBRYi7COnpdgd+x0NZZTnXDXyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k31RBGlNX7U3ZABGKo9YD0vwR4InI0xEA6s64n4Uj+s=;
 b=kCI96506FdeUCOusB2bMiRRuzzhkGL94mAkEtDvQq1gonh85cdn6xZfy76EaU6Q1KMToDNFZckGsDLnIKPQvrtEerO9d9S/DoaJDy23f/eNEvR6KJcxCzG93CWK0z/aSYHaTkaIvgUwk7koaY8XYRc3WtwznIx4jnyV9YQqCracuRnd5u3lLmN5t6rI+Zksc9CzrMAxxEzTYCh+V7crsouHgoA8Yv9Sl4EEEiOFFYWESU7+Jio1W1BX3ndQuUk0QBGw5UZj/M4Rv1555gd0GMGD5XQxtMLPsvc3QmSNW8Jz4bp2/uTeXipiv4R9t+2vzLLyTj4BvcVJUDS5JqDQnwA==
Received: from CYZPR17CA0016.namprd17.prod.outlook.com (2603:10b6:930:8c::25)
 by BL0PR12MB4930.namprd12.prod.outlook.com (2603:10b6:208:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 11:33:03 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:8c:cafe::3f) by CYZPR17CA0016.outlook.office365.com
 (2603:10b6:930:8c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 11:33:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 11:33:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 03:32:49 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 03:32:49 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 19 Dec 2023 03:32:49 -0800
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
Subject: Re: [PATCH 6.6 000/166] 6.6.8-rc1 review
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <65fece32-70ac-4289-a0de-4aaa1a9ae6f0@rnnvmail204.nvidia.com>
Date: Tue, 19 Dec 2023 03:32:49 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|BL0PR12MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbe7ba1-c670-4c98-e9ec-08dc00864356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XPpaXKVhJdInAMSNxp0zSnde1lzIj6Qzt0dYa8tCA4c5M0959jqqTws5wVByO+aC9q9cyK3IBN296y01tQS1XWsTOOqKo7lhitsZEcbxBpTgyRcmuJ16RDx0ERT1LB1ZNkxMVwsAyd+uPb/D4kyXUoa6VY06cOEdOXakBEIf9Uj3Ru7l/cMFK6UdrD4HPJsRomh4Iod1HcMWaIXU05CE5fvDvRn85poIMCqv1YYwKIDVtNw8Z8jBGXq1xCT2BeYMnVHRdJRTSPljdXRloGQl+Ao75LB7C2u+2cTa2Pv9wAxkmrjJyrxcgqDRVholEh2DpADYx4+VKscwkkQ9B/T/TQOFMDD7qznAnqBKQJrVhJa7f6ob624LZ3s/UiQ0/zyL1nLdWQjNX2F9aeGZT0lcFwvwlLuRfSEThutyc6a5CvllQPF0QYDJcF2AdO3+rntu9xi/q+V/lk6D8WM5jRRo5+QXRrSCX+11I7AhwF9Qt9SL20vhCsPMps94z7/A96Izvxe5G3pB2sNx1nybNVBNc1tn27+MwEohhpnNmf0AyzhJ41KkkGY1e/kjH/FZ2QEUzaFSF8tL/0UefDlykYfAVtPpYjDy6+ZfzBVb/sMlOcV8kyqAm7RQCevM8mDJLqaCpJOP1wTLwTBfdwvVDyZzMPvvULRliVf9Pk254EWIotLelnSTfL3cSXgQY0FbtKxBLRxd0BsENKpvC/5JsVLs4W3G0YXAneM3ub2f0r1KctW814Uldqi/Dg/MF2r8390FubsHL+5eQtcmz5ZCRC8PxXUD4Su7Z64YWS5qJ9FB7eM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(966005)(7416002)(478600001)(26005)(426003)(336012)(82740400003)(356005)(41300700001)(36860700001)(7636003)(31696002)(86362001)(47076005)(2906002)(40480700001)(70586007)(70206006)(54906003)(6916009)(316002)(4326008)(8676002)(8936002)(31686004)(5660300002)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 11:33:03.3748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbe7ba1-c670-4c98-e9ec-08dc00864356
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4930

On Mon, 18 Dec 2023 14:49:26 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.8 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.8-rc1.gz
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

Linux version:	6.6.8-rc1-gaa90f2b75bff
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

