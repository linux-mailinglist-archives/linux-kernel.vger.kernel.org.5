Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A6E75E099
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjGWJJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjGWJJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:09:08 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9558B1BD3;
        Sun, 23 Jul 2023 02:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/CUJ513QjI5UA3yJpzV899AXYATXik2iha6HgPMj1rHjNcqDmfCqzTOaohAuzzAz3d/D8QS9caauOuxCWsQGLhx8mrVtNPstg5qzM0a3ubbljZ17JCrpmWn8UsOfEK6/BK8WIyTbb9tjBKECtGnWxJBj1x+qjrEfxs36WuheES1U4+xylfpJxgXbOBfZ/c5GAbNZXraUBtEgy6LD3CZQDdXMGaAGI4NVWvn1WPet7Zp//T39P1b0erkG4grQUJzQT+w3lfb53c8/EfbbSkcJvEUMK1D+7a/BToCXXk5mUsCSc5M9gejNT2jo23fTLGoiotDMfmT3/KKcu+EglEVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWwubb5H7uJjjn7dJWFYU300BebDL0cbchsTXeim7YE=;
 b=EPKNodCsNcIOYyHsWaeCWP/khrQM0hT4XQz+S10WYQB1Ws4dkYQ+iZGH4BT80Ae+R5krksQ8hMKsW/FciHvw1W934Nrfw1nxIy/WeHM1aiD7URlsaiN6DpcSYEWTl0IJ30xz5RVxVyFkXtwFLg4deNNlkO73mSHWNN/1hcXILFs6OeZsDHvEfOzkUmS25wP3WNmtRBZ6XZF+8CgO2QLAAezD4oRmyvJ5tS1xUxtzwHSnkUV5jEmtQXRdX09Kveig4dGuELME4TevRWhm7BczTnP7gf/nap+tt80Wg7i+hPwzcu3z7oKByQHArL8Z/xZ8i9FVr2jTBK5l1OnEbWCn9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWwubb5H7uJjjn7dJWFYU300BebDL0cbchsTXeim7YE=;
 b=QCVkH8icoEukCG+Qnvp2gc8kxTfJWrairbNZsOFnJ+a0E2V2wr2irG37fnUph4Z6itiNiCLCUczcYNQ57JCt/Oj9M+k5+ax/xTma5n3DGWmPBJg0+qwAxH2lHbJKbqKsuT+xe74Qk16dIg10beYQQPRorUQ74+INVz5SqafZJnhjd55/ZNaTR6G0cAFvg+zF9vWDirpmDVNKSpHRpbzlSy7eK2stNXzUhw3O4JYhdyj3ixS/rH88cvj4Zt/xro6qfW+efNn47N2cfMduHvx04ChbdPS/VfNEhcFhTRhdbB3ZE1lV8TUYX53MTevjKObCrsNzZM4tQc3u43gTJu/GFw==
Received: from MW2PR2101CA0016.namprd21.prod.outlook.com (2603:10b6:302:1::29)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.29; Sun, 23 Jul
 2023 09:09:02 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::86) by MW2PR2101CA0016.outlook.office365.com
 (2603:10b6:302:1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.16 via Frontend
 Transport; Sun, 23 Jul 2023 09:09:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.22 via Frontend Transport; Sun, 23 Jul 2023 09:09:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 23 Jul 2023
 02:08:57 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Sun, 23 Jul 2023 02:08:57 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Sun, 23 Jul 2023 02:08:57 -0700
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
Subject: Re: [PATCH 6.4 000/292] 6.4.5-rc1 review
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <e5538d53-5fa6-4ea2-8d6a-96f4ab345d2f@drhqmail201.nvidia.com>
Date:   Sun, 23 Jul 2023 02:08:57 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 70acd110-666a-4ade-fcd8-08db8b5c7524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fdl8xOzXAm5w77Zf6NW096JO+c7dXgxvAN2fTXCXdFKWPa6GvSA3QRCtB53//w+NsHSp8X71Oy8nIh19urKM889zMndCqwzgclP56cMBEtpdJyI61nv2SFl0/+XXen9Lre61Buuhyvid7Ps/mKwFcHwmpVpZV+rrXdA2C8Ldu9Pv+E673ZzqVUpM5QrMhcMUQ6pSizPVprOyr2bePwIpUnIprRQKpwbDmvzWwWYoUhX6VW8DVj0PIT2/gL2wCBjc9d6hJEz7TEDHoqEJedHTLE4qVTNtfZNkRhjEg5+PM9yetDst1JhWhfYO01eWZfICRDoVE5ASKiWyIXV3nWlY37SqO0Xta2ofGhP/cpclJPGdg5f/l0kQ5SxTf5KiAt2qRToDkXf3BPHoMZnlq0cukRd1kQ6DCuXz0IKjtltBSybpEfm5WDyxWKhLxGsPtWRCLqICD8/T3A+N7KGHVMdXHJ6hfKwWTu9n2aRlQ0EdrfgwStN+B4lspytxJHyRwW/ANgk/Su/j2lGWv5ZlIvK5zv5sqA/ghGLsiUz37ZOzFkaWKTCSPAfevK2V8x8wBHPf7EuYUjCBvYBpYqrzT3VednyWI9qdw1k9rlM6fyKRzBaDmkW07wQj1dFIemSnTZk3w7Q38GWf55Oej2ZOI4wcRWyrEwAN0JZuqWX9N+rygBelmnt2DL8eYnrVRpZyehLkoMNolj6EaXt3rC+Fk80eXTf844EScFH+wnnQHF3/6GqJkdnBgP42IXH67WGj094hYB9a7dfoVStgPrmXv8731WVITFJEfWxrxGn0iMGq4CI=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(47076005)(41300700001)(426003)(186003)(336012)(478600001)(26005)(40480700001)(966005)(40460700003)(2906002)(31696002)(86362001)(7416002)(5660300002)(6916009)(70586007)(70206006)(4326008)(7636003)(356005)(82740400003)(8676002)(8936002)(316002)(31686004)(36860700001)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 09:09:02.0886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70acd110-666a-4ade-fcd8-08db8b5c7524
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 18:01:49 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.5 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Jul 2023 16:04:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.4:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.4.5-rc1-g698271d38e0b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
