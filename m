Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF273761E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjGYQ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGYQ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:27:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE1911A;
        Tue, 25 Jul 2023 09:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7EacTgdLrEf5ZtDOB+jBuBmG9M5DjLDl/khiAQRt59icNvQpRaRj16B8FK+RZhZG9xiwz+JEiEqbfHrTaQfE7pTi+vV3hUKr7KsJV/4c+eJ9uD7zC9apxOom/HVsRcpvJARbEIGBIwcHih/7w/Qy1MRhK6FSEB1NlOwp6HNpNrgWXDDSTwdICB4UydNq8bbgX2mQs32GPMd3v7EWMmtCVpboorbG/AHP7xEvVl7Rz5y9nGKpINuMPunftnhrPnT5rLQHCvsJUgF0XOSaiKw+PELUBhqxbJ2r222f1p6KU37TdxxsTgIObGC5BsmXN/dmIloCqCm1m+zUeiWmKo0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNjPwb2OBMpr1cEWZx+bXdY7N3Lv8AK5LT1JJanLlRQ=;
 b=BNXZHAbSxhncWB4dpj4kRBi5mYjVHUAQGsWI+bh/GnEFysDH15iSyoFYCbvWjdjmy1+U4+mRLzEA35L1V/ZKS2ZOp0FQTN849agbZ2bjXfOwhOzMVsjvtd1mDsujn02tmuqgGdqkLhHKbhgSMK+yhuzxXi+6NwkY5f/KAOu4LTyWyMeYTrgITdcruXY56kp3ZLsx2Ju+W2p9z0FbWDllvP1gIPbhJKv7sFUNxFf/WwaJR55hjRzwVM+uU9EH+j/J0ykmcK36Ak1zhpoeuwE//aEhQk4T8rzAB+2P0gtFjWU7CUQTcDwkE7m1g9xPOGXDQvo6OjXfMPO7LaFfO5qxTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNjPwb2OBMpr1cEWZx+bXdY7N3Lv8AK5LT1JJanLlRQ=;
 b=ZxR+0HxbuojzCkLCq2S9QWWyMhlsZkEnRX1qV/4ymKi3t38povDQ+sgSB9GCxKHnIIRKudIMrTE0hbTDNcYQ7LJWZIm5F2uUcxnlfYgxpXner4qgkxjYxYus9PcaPmvCgihBVmO2xi0Tv3QykFPz9CvwGKHFHHx0+9EBp7zTghNED+7rYNCzwWz9qo+la0TZyPMukgDgqyvOHE6lfbu1JXxlavkCREiSaKrFL2bj61bPyiRYjpgkmRiuTomye5wZMx48YCVwVlyLPBXDvQ8qfW/yXl16DYjwuVRwJSECqzmZgbovxLHtkqH7yNZfKJIyBMCHeJH1aUIjwfhoQhEMAQ==
Received: from SJ0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:33a::24)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 16:27:46 +0000
Received: from DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33a:cafe::51) by SJ0PR03CA0019.outlook.office365.com
 (2603:10b6:a03:33a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Tue, 25 Jul 2023 16:27:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT114.mail.protection.outlook.com (10.13.172.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 16:27:45 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 09:27:32 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 25 Jul
 2023 09:27:32 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 25 Jul 2023 09:27:31 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>,
        <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 5.15 00/78] 5.15.123-rc1 review
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
References: <20230725104451.275227789@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <1d6ec1c5-cdd2-4f79-a4a2-4fbf955fd30f@rnnvmail203.nvidia.com>
Date:   Tue, 25 Jul 2023 09:27:31 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT114:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: e7619cc8-ec66-4ea0-3dde-08db8d2c1429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SgS6I+hQi+OlAWW/LdQp4gh3P7Doq7bNHXDGvV2NOztv7Xs/JSXupD2jFB1V4KYVFdwJQBwbbvQ0EG6PcLGIpVNCDrblyLfdmQ3gRvpAv/+4d1Mw1XMGpL3KmGpBC3ZfW1NQqfg9SlOapYzWn3EKAsTLpngkaOk2B0LKMy0XME3FkNJ5fDzxKgdU0B2rjHpXpua+2IzVFnlsmIgAnb1+FRViBtVTIdi4gRefCBarH/EkiPXTPxOp1FFJJ2e1eFUzBDCqKcxbLyIEMDSCV1DOCqwxqB/dZfViC0rVGwrIgG8fEEOc2z9uLjRBpF3x/ZssYDOUdg8dQbsT29djjMDq1yRI0J1MPkrg9Ex+COrFDHo2BW7ii3kQcXZGgRvBLnK/3F2lVsOsIGBUp2dw0XP4HDf9vLcSXSNJB9Z7a/NXguOYSJIg9yX2C6eLDgjiK1q0YE5BZLXyy5I/2uIrXOGImPCDEzZtlsE6i9RI6Puo2Am7o2cq39S4BoHCZIPfPyD+1Wa9jDJDNrzYBRtoP4srzVs+rhKmBGQO94QUZ8tGQAWcn4Syh4Lzk8tmQozpDJzB91vo+7zZ+DMA/uuykod5y4ywLewAN9ihNiEAMiQ5f8ecfQZ3h2YPK51uRL2gRr+k+0lF29DCdejJBj0R5JvZBmp7JNqD8qBCZOVhpu/UIdmLV6R48bH/y5WginoiadDdUJOBvnYxGg1i92hrwz5uApcO/GfUm274/ycwQ7/1JYYDNzh914AN6BFEWG+wxp87aZXf71d+FgpMYihOZlfs8PuJ3KOnD2c27W2KuyD7zPA=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(2906002)(426003)(40480700001)(40460700003)(47076005)(36860700001)(6916009)(4326008)(316002)(966005)(70206006)(70586007)(41300700001)(478600001)(31696002)(86362001)(54906003)(31686004)(7416002)(82740400003)(356005)(186003)(336012)(7636003)(26005)(8936002)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 16:27:45.7975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7619cc8-ec66-4ea0-3dde-08db8d2c1429
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 12:45:51 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.123 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.123-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    114 tests:	114 pass, 0 fail

Linux version:	5.15.123-rc1-g3bef1500d246
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
