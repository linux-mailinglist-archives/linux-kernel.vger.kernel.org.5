Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D527902AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 21:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350693AbjIAT6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 15:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjIAT6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 15:58:38 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EC710FB;
        Fri,  1 Sep 2023 12:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjFjPpVeCKTyQdfVZmvJElY+O0awKbPPidilzdzwBAT7wqTHcGrrEkvIlvRx1Fdr7Rjb4B9O2oarGlS7WwL4SOo7Yo0bXLX4Svm+wJtOcvMtjcisyYJUNid+psbeEk2P9gEF2TI5aUutOM/JIh3cHgwYaTJQcbNLkH3N/Wtp5rH61N+7yGqZYJqBgqtazTBDuhzr3dfW0SOk6MsBh+Rb3pglNhUyzhjabXNfJ8leFaMV+Q9L4tRGeRbLzemBwFiH227uLR+fE4F3ZFdOxrXWeW7B7l71+UunWlviGJzP5Jy0Xua5lw5soO7ImvjxXy86xJRthfFQTeetq2Dw339Kmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPMaSTXL66311050R9JoIKS5YUCzbJxWiwIvgOnVzt8=;
 b=a+x+Nasl2XAlBHCXpcVpXL0WVN/gU47W4ZxoWRxwQ73GOW0sh2Z2dgBZfcP8RrLeXzZXSh19tquK3lSJYC9Nh/3SeuPD7r67dpPXqhcxYHzwSCzP8/EUpxqAGNeajygrlr64TZQxP7LjSZjFqAJ+Ck5Q5OPE8WWZIxoIdLf7tiAwO85nBrNmJ/UHW+beNEuukC9L2Uo5ck9n5xkZf/aUfk4zuzFA95TwT8D0ExcOUaX1eJ9C5WuujDomGi5hBDztXOjwERteSwF9dZwLwSnU35Z4RoM3Z+4xPsLpjDn5//qLG3SdytK+mA5TpaG+7Pgp3WMu70Yfr72gGV/e3yXgJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPMaSTXL66311050R9JoIKS5YUCzbJxWiwIvgOnVzt8=;
 b=OpAKEhLxog1twkA8ErEJzwoHoNJ4uleRwYlsNjUoUqbjn6pbT8Bod0QV0ntRORQAHYzmUpn7r9rbKbS590pBmxiqJ6jVIRKjZT9yjskoPSVvN/7JBgNv3Bra+rmhkwAL89IxyPKPVZZ2bmM1F9vzlXiVI4gxJT3P+KSCT0a50NE502eGTu5amiPqRZ/yJStEXuIPIxiFt9jitSRtxvn3+o/Bxi55+2ZiunnCCj+IhgpAGTesCgt334YnYcZu1zr4VTKlGexELopoDvdRGlQa9tZl0SAYxxlDzJN9aU9zkQryetjmFqzgtDjSwNUGHeyVJkgPFXIIcgd5GqZCbx11pg==
Received: from SA0PR11CA0096.namprd11.prod.outlook.com (2603:10b6:806:d1::11)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Fri, 1 Sep
 2023 19:58:30 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:d1:cafe::58) by SA0PR11CA0096.outlook.office365.com
 (2603:10b6:806:d1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.26 via Frontend
 Transport; Fri, 1 Sep 2023 19:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Fri, 1 Sep 2023 19:58:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 1 Sep 2023
 12:58:18 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 1 Sep 2023
 12:58:17 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 1 Sep 2023 12:58:17 -0700
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
Subject: Re: [PATCH 5.10 00/11] 5.10.194-rc1 review
In-Reply-To: <20230831110830.455765526@linuxfoundation.org>
References: <20230831110830.455765526@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <a23fe364-4de8-4d42-823d-68dfe97e3f65@rnnvmail203.nvidia.com>
Date:   Fri, 1 Sep 2023 12:58:17 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 40026c28-c7d1-4bb3-7a79-08dbab25d096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bn5H+EMGlhinRM8u9gtq51bDJfpqwAtOiKtZE4r3Ws/mTGWo/V8fmrtEnD6NpPtrtHrp1FvybtfTNHtto/4lyvqSpjqWGS7a/3wPVm3AxpltWgDtjOpZoHq+vyKLMUBsTbL4F1jtf3k0Q/e5TSjxghw4bu5spOVVO14jYqP/qkXBMjHbYE8kKfpxBv1iWNQ8AIV+BHrCQCfRYSwIeq0B0i0vUnFRX0ZlmfSnqyEHEEcDoIlCfrb53UmTNguQ7vYEoVJ7Su/FkjxP8ATNHx7LKKVweGBlcRF+Kh91L6M2kY5Mr/4z+h5ml+pN0YscuqafeSsdMBMg8LeOysPFYgTqyuF52T0GgMwYX2Mmdfw+75MLUSLeYdTDVwv6TJHe6pVtKi0id8FWYZ9kiScCzjZivuZh1KdNru0nvb4uQDNG8PtupPTOwx8wl3fCDdX3ryYrPiI5BcNR/deSKIFpHt+KszPlyRZ1GgAByHgYjPpmpR0TmyTUZW+6Gj0Vrp0wD6bLdU2y+7XPgRuANKdotrHlofCrQcLawgqLigWFgiOjO3riy2sIhttfnTQDPO4SZETsObo/Ut8VmNxcx7ghFckANNE4xNUgfNdOC7j+CCfcr4emeD7jqq/8C819rWOb9xltuGntNn7ysaVkU46xjF1lKXOB7b11Uj8HpSGygj6LsK0xfk7iqvI4y5rKGwh2g5+lHMmVLxSux4ih3J4zdJWdDGQf0kIqj9FvAj+nW5wV/lxP/5puv4wxrp8vcNFLyuSvsiAfga6v7W5gLoHx58jB9nwhJsC2bXiY5ytBk1yl4EU=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(41300700001)(316002)(4326008)(7416002)(426003)(336012)(2906002)(47076005)(86362001)(5660300002)(26005)(36860700001)(40480700001)(6916009)(8676002)(31696002)(8936002)(82740400003)(7636003)(356005)(966005)(54906003)(70586007)(478600001)(70206006)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 19:58:30.3313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40026c28-c7d1-4bb3-7a79-08dbab25d096
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 13:09:52 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.194 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.194-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    75 tests:	75 pass, 0 fail

Linux version:	5.10.194-rc1-ge25611a229ff
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
