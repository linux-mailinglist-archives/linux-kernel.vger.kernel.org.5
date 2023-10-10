Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A927BF808
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjJJJ52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjJJJ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:57:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736D394;
        Tue, 10 Oct 2023 02:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGaddiYG/bA+mPYC38cOVpuM4AvQh78I0cwp+niDs5HDsLnSn+XfgQUf/MxhRhB3oaIQM1vEHGQNnixnMi/YeImO0//UfH/TDIIeGHhVsmw0ECDTnfJl1m8jDYUYHp+RirLui1524b/Znc5p02bMQkNUQkVyueDn/OyxrfSoEPyF1ijF5rpbAVayLngf2aiSMrgPiVLoSZtZxaMAxegiNR32urkZVJlFNykYxrKYH6nW8CSqZxq3aTmZl9drDd3JaFBPO4N+I8n3qLBZsAjtjaMumAbTtbnBxID/SypE3gouKKgVqAmvjzn7elgHCtJStsDM3zP669JgY5pW9VzPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chWcO9aO+JsVa+SoYjM0nBCjbazFWOujXgRlDoFrJA8=;
 b=lBOKkfbfkJczwTCCpKeyNCV9eZli8tWDSvV41w8Wm8gsE4gj5wql+kTsULDoV8d4/+IDs5KalRv7P1pMuCqNRhiJ5eijvr42eFnaWgtI+7qzI8A1Y3XQVxAKVwmVbjDfRuXlN4KEWFgVJNR32QMr1cPrnw387fY3s3AD5NigUTQ30VI2Vg5d/k+hen/QBlFuo/xR3dGZn9J2TwEsN+vXMYMw3Nycb/jA744uyjET/xUoqcviIWUSzgQ0TibWjIyf/iI+JJehgLcJ8T79Wir5dJtpS29uqWb+435VK9Vrq9wYMjFW81959y23YVHbDqg4RbfpI0wixxMUHgxrvXYwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chWcO9aO+JsVa+SoYjM0nBCjbazFWOujXgRlDoFrJA8=;
 b=JuP8LqOsxuO70qTZx3xK48zo2XdtEX6NMlyMTplZ6LuZq8rBcam12MRT424T5FVHR/SWL0YrDeImkY9zI6fIcYQzz3QERUDK+1RytszxPao/HDKw/h5gUbbeq/XvB7XzQmpgiwottrtz0/DP2chejKEkGX7WWcef7WglKrjAL0ahKp8mN330l6tGzWFpVzLh3QRc+pF9SF0dEk9s4edN2AFomCu6AAytdINL3NHJFBvM8an9u+DYRMcjda6VJuhfBPXheBVQjc15CCO8bWsI0suV4bp2jauyHbbnaM4oYlVK9klUaOE7WbLM6xmWjJ1kwUeTpYNhHCRlLM2eZLHUYg==
Received: from CY8PR11CA0001.namprd11.prod.outlook.com (2603:10b6:930:48::27)
 by SN7PR12MB6959.namprd12.prod.outlook.com (2603:10b6:806:261::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 09:57:21 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:48:cafe::7) by CY8PR11CA0001.outlook.office365.com
 (2603:10b6:930:48::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 09:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 09:57:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 02:57:12 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 02:57:11 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 10 Oct 2023 02:57:11 -0700
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
Subject: Re: [PATCH 5.10 000/226] 5.10.198-rc1 review
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <a8d5f23e-2d3a-44fa-a1c8-0c698f7169fd@rnnvmail201.nvidia.com>
Date:   Tue, 10 Oct 2023 02:57:11 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SN7PR12MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c95dea-9bb0-44f6-7067-08dbc9774c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAnbVoDOS0niR+6SKwKPBYQqOianRbNko3cxuL6rPrMPFF9gv42jPQpv/d7XSYZZQudPjDBNhTOnZOcJnopIq2azR/RTVSuwzj6WEAvVLJITQexQ8TAgC8+CKkXgY1Xj39JA4VixBluhRvChjUp91VCbAb0nS8JToWyLu6DV/El42lPpmhgu89vv/II1WFYLboF3FiLg0kMJhBpCC5bKxSPWgJKwZeyNchzpOqGA7V4QL71POZBoviseqLVFVNHcBsQb/BR+hT+89gGYc0kMKDesujvErnptXabSqk8PmDQPt/jS37JEtV5UCbFNAneo7IzpU1EXtm25ekOUdFiIeVouw6ZNohKT1nSu0WEt6u/EDNRrZv3ffcr4zD8PYyubrZnDMKEAOkHvNlTLMjPhbt1Z3J/GYBXL1NhA77MeUKpu3p4Q7TAsAmBycBStkbmsU3ON1pGRUTMmOyFtG99HDaYn6tWyhgFHnQI500ousYnM9WmYhzQ+K3JHLHEsIXBK9RuuaWk2dQf0lU44MZ1ovDHOlV8g6soOMIKiJy5OZ5IBxK4KmgC/0Mjr8h8mG9WSAVe+4RztS6Jca6AI2ymfVrb3pGjhb0GiPTzTSrWiHUu9HU6AXRg9TAasQyhXRXZhmRmiLdZEOP97j3YvAnd2W9eyRQ9Wm62tdZCmsUpbUVk++69tX6H0ebE+SDVHOBLFdZuVVhsNS23rKXjfPmdZ4cy2fjMhoBFuA75oeRP0p7jsuANVnQCEFswlJbGfOojjeSpvPxOm8/LQXKtqi9C09mX9yuGBjg4AJ2m6MmluJkI=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(31696002)(356005)(86362001)(7636003)(31686004)(82740400003)(40480700001)(2906002)(478600001)(966005)(41300700001)(4326008)(5660300002)(8936002)(8676002)(336012)(426003)(40460700003)(6916009)(70206006)(7416002)(54906003)(70586007)(316002)(36860700001)(47076005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 09:57:21.6818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c95dea-9bb0-44f6-7067-08dbc9774c14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6959
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Oct 2023 14:59:21 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.198 release.
> There are 226 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.198-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    68 tests:	68 pass, 0 fail

Linux version:	5.10.198-rc1-g18c65c1b4996
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
