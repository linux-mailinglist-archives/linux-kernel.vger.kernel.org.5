Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E1875773F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjGRI7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjGRI7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:59:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF09EB5;
        Tue, 18 Jul 2023 01:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTAi8LlDcl6MRWEy0bQdDl5n6WxAAKnzT9yVH6Yo9o6i8Sb14WsfLFM3jo7jJK6DmJhx47qE2biPpVsdldE0hH9kopH0/IHbL4lvklIlkutj8jlV+W937y/hu7jXDIoCV66iDTORApauG2D3nneHzgK4lqEziSuPcsyFms6xmrbq2AQs3NTzPxj/nUvl+QdeSjYoQcfGpsUJl7T9EyCu5EfDE6afraU7Hn+lgfrJMs/Y2P5f2I1Yz5VEPwvG1hHSkLByAD/3dzkXya3qkkHVSlBRERqcw6R/av2VcoKv8YfvkSWGSVsBT+3dA6fxJn5jQopFS3E5109L+bdIpOuXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIyIRjGKx7PJh2GUtj2zTJGRUlziKpwjHPbwd92fsHg=;
 b=l+/33Har2GdjLeQk5OV22+8TyERIXJ1uXERk/k0N++lYJ2d7WdAqQytOaeFaMJzrz31RT+XA6BBSkqHPziYzaxrEFETNJIyd18j1K4pvhXpBcBRRaBcQ4fbHsQt2tIT7GLqItYsnK9iJ7k4n0SOkI7nIHGHkjZoMw77/oZNLQRx8CEJArNvUZ6tVaAdOnweVqg+6H10wt6UuWYCgeTfS8k9P6U0SlgI/AqEP+oOBuIZ45o1/0oARjiZuMRa5lMysP/OOI+qs7dmUt9ZypXDitmitSocZ6ARcHplugpKCsi6rstxj/ta6jticCBmnx52tpT7otZFoBcgIy3R+phulrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIyIRjGKx7PJh2GUtj2zTJGRUlziKpwjHPbwd92fsHg=;
 b=UV62iY4OV+uh4ZVxXjSUBgkJU0G5bcTTClIxl/oyD3PJcldz6SxdiFfbGJpD5yd5fDUiOw4nVNpEhXt1FJYMR/z4DQ6kAjk4A3l/1itPs2yJfchJzroEMz81Hwce8zI6+4i6flVXB/Dug+N5XANCloOsXxBLOXusbKVnD3yNodfzOHOisqFCkzOOcXiv7S26h9gZmqZCGuMhcRKiamIwDMPlfmU8KIZKeE5/7LPmUtV9/sywmUnFZVYJhDU6ZGYJi1n+0ziNiJNdO2pAZC/rZh12R74SelVuSFcMLq5YTlBqkTio77UHFQqZAwnXI3jn8Cz3Tmp0t3jtzVbkpFAu/g==
Received: from BN9PR03CA0197.namprd03.prod.outlook.com (2603:10b6:408:f9::22)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 08:59:39 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::2e) by BN9PR03CA0197.outlook.office365.com
 (2603:10b6:408:f9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Tue, 18 Jul 2023 08:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 08:59:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 18 Jul 2023
 01:59:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 18 Jul 2023 01:59:28 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 18 Jul 2023 01:59:28 -0700
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
Subject: Re: [PATCH 6.1 000/589] 6.1.39-rc3 review
In-Reply-To: <20230717201547.359923764@linuxfoundation.org>
References: <20230717201547.359923764@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <f6955e78-c23b-457e-a635-126f5fdab4ca@drhqmail202.nvidia.com>
Date:   Tue, 18 Jul 2023 01:59:28 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4455f6-1d45-4a96-595b-08db876d51a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5jD7IkTggOaNab+fjVDXI6p6MEpaBpEDnmLc2W0I4x4GkWh558H6hZw78HY+BzNOuxQtS7e20bX7PayRTFWe1q1Ue9KcqgZDMLMEnUtWqZrMEVur6GN+ws+zwe16W+NmNaCalgWHhCvVwJZFy13qMPC7W0KQbwoQalkjbXV3CNQrL8kdP4sPyPmK6sQcYl2nimTfDDEs+tA+0IGTqfd9CrKgUe/1Y8rZz1OCpzJiI/ABQUJVSbHY81HqVXnqJ8PkRJDZcaAOm6ZxNcIdPjM2ryjdsjSZIwycJ/OVwCHF07C1JHyWL+bh8omQaYN1PU0WYiuOCBe/IJ4WP/msTRdHikTkKu17RoYgjEC47ZPUULEBctJhY9rgPsNu0zsdTibd4ky1HgCzZvJx0XVrDCBkWOgcV3+qganrRQ85ixIlOExEfdeqOjfFH3XeBBi1By62Ncm5I+ijQsJjN7CBLCN0nrnsMbC7QsWtP4rhebQznYL0IcnqClkyvZZoToOdEDFqpiGMtqHpN5jKo3AEwO58MrqHjrAHyIPByEIBgnuL4fITA51v5E9tNat87ylkh6cKO9l8MJyNpGD3EGRbcvhDA0UqDGMBc9j1QSURr/b8e7qXoi2ABkg3OwhWTLThOp4hcdMeXYL7BGbWU29rsq6OLVfbPR8KUGTTQqtDBYl2rslxJdngZBc9hbhPK7Eu3hEj8ZkN6xlRADzgU5XsdRn+r+6BqSQY2WfJ4y4/+5cMRYFOIqVGxQej1oOwqcVOFowXAcWLWFyFYoKmaMTObSiYQZu94SUTHWkMj+RpGJAhzQ=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(966005)(40480700001)(26005)(40460700003)(70206006)(70586007)(5660300002)(54906003)(7416002)(31696002)(2906002)(316002)(41300700001)(4326008)(8676002)(8936002)(6916009)(86362001)(478600001)(82740400003)(7636003)(356005)(31686004)(36860700001)(47076005)(426003)(186003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 08:59:39.2223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4455f6-1d45-4a96-595b-08db876d51a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 22:34:23 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.39 release.
> There are 589 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Jul 2023 20:14:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.39-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    7 builds:	7 pass, 0 fail
    22 boots:	22 pass, 0 fail
    104 tests:	104 pass, 0 fail

Linux version:	6.1.39-rc3-gce7ec1011187
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
