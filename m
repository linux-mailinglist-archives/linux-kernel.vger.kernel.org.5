Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0525757742
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGRI75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjGRI7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:59:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD19103;
        Tue, 18 Jul 2023 01:59:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYGhbMrRHGeeh9wgKfjcr7HDatpqUyHNDTWy5UIlfEWY7My6OCKsyjAvCxYOGTIGTgMhy35V0QNLsk75i0f5H79OKVT8ihN1H5MWDd9S3hSRcFJUsHceFAzHle5UADgTuk3BBc9/gZdcaj2kOYdb+GjvzX3pGnokKZUHquOHRp98YVCDg6D1H9NH9RuESGE6v1kYVpZuf4tq0EdoWCS972ZvTtxfebjBx5eUo8UrLzB1yOYrw9YL3a48Dm/f5gCz7BIzHSEvfUY+PdE3BDEIzpguSPa8DNJHszxxRzbo6QX/26elwNm0NfyjSf0KamsmdB0eLEP0AJn+P7OBels0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnDYwocU4dF3E9Nm/oi5bkAmJcAWzGq46QkOrKVCeW8=;
 b=kxELp+8sxSQneBW0LPIuZ4Fld1MeyCOeUGXvKxfVCwfGcZNNn7ERRsaG6vWWw7L9rpYd+AWV4AQs5mKnkohz4a/bUZ9oFBYJS5FnpEiOZFVMJU99Ov9OEWzLbSJ3KjLgFLXVZYzUIdaDIl2zZZmVdvoXzsTiY+Idg6G4DEfVRSTqSKNsxFRPg0XRW7RPauly4AeHwpxaCLHPf32SGBCPcnYxeqjCH9vvp20G1f3kGJ3E+fOKRxCpU7cb0EE0wBOX7dd5mQ2E56zoPFCerI4Fq2YIo0aykF+GDhVAJ2wY/xt9sorjGaJmiCKb5Uyd27Xc1xVaERxqKDNkLqIYbHKM2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnDYwocU4dF3E9Nm/oi5bkAmJcAWzGq46QkOrKVCeW8=;
 b=dO7rOX5sthyfUCZ83q4xE6n+FBM1qntDFuw+d77ltM7rW+7h22dqAlI7ttphzx5UYqeJ2ghtNt2aDpm77P0HLdW0cehaidi0MiovU4OUkjlHITraRqjDwEa3PWDrzPokJ12KsUObPAY6hh/9oalRC6r+EUkgbuH/nr6KnwDF226nKGLAlvFsbFDCKkyytQGJtgD34lC9fLB6bZNNPxsB3drC1+PqDj1Nc0JbFhgLReawFijSyDbMF4CoHPef0TCqX0h1EO1d7PYrqiratehzl3R7GWuFzRBF/lSDB7p3K9sJOCjWe3ahpqXPide2CcWm+ujg7tlQnICQ5RLz0twwtA==
Received: from DS0PR17CA0001.namprd17.prod.outlook.com (2603:10b6:8:191::19)
 by MW6PR12MB8899.namprd12.prod.outlook.com (2603:10b6:303:248::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 18 Jul
 2023 08:59:45 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:191:cafe::67) by DS0PR17CA0001.outlook.office365.com
 (2603:10b6:8:191::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Tue, 18 Jul 2023 08:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 08:59:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 18 Jul 2023
 01:59:31 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 18 Jul
 2023 01:59:30 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 18 Jul 2023 01:59:30 -0700
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
Subject: Re: [PATCH 6.4 000/801] 6.4.4-rc3 review
In-Reply-To: <20230717201608.814406187@linuxfoundation.org>
References: <20230717201608.814406187@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <e47ebbf9-f069-46b6-a515-549e1433da5f@rnnvmail204.nvidia.com>
Date:   Tue, 18 Jul 2023 01:59:30 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|MW6PR12MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a13ada7-782e-4d55-aabf-08db876d5514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ZEsYMiSMGtMyvpQdmtmkfNmxzc5bI0jmvFuyUtNoAeKTX70bEecsQRzVx8FCAiFaFsaIFubKPt17RZcKnGz5yErvXntYYchPgU8612eEOqeYBxRMHv93LeT5CYZbBr394tRnAdn64PUMQ4pO0EIZKelojArXkT93iLqthbnfZwPakuPndIvgLa88GcO2jbnjC/FNUKOJbKYc2Nku1UdhIKsFQMKNlen3SwU3aIGRmH4+Bmj47PPK3vH7rJu+XMkG2RVVjmWWO8MLDEMTNIFKoRNXko6lNW8vGH2XaAeSXqjQchLdmW8Du2LQEZPb85ePqncjvielcxxa6RKWZdNg5MImK7G9VraLKpz/cOQwm/4sUi8Nr6fTX+8GeLHYpeWzpVIRzvwEPzM5HF87ET06bNAe4yrLKMXsQ3cM5rcIdjJ65wmMZ9nSFVTKOqfL1ImVkGKat8xGp835RZstJjm+5S1VO9jBbQuzBm8ZIcH4cv72gzfNWelpn8CcdZp9Dw4ECkTgQan4Kb6S1MUbap03w71lzqytoYHIF+G2Otds/BGIt1YBBWwGKYC7l2P8Us5Ityv3zE+1+NRY9RLwnkrjgqx7l8G4K3BZj/sJZlWHLYI6eNTU2k7dGkCc2p3xMcMHuXMlXeTJjqI817QUw0wUG0qwcEUq3o7jSZz2WSYr/qCeoz/iHWAwtkfxIwA4pyppem+sV4sO4T3TvlyqdQb3et/b4cvey0kHn0d2ArGEbVymc2J7dYqq4uMch1TWMoVSBTk2rDeMIMvm+r7NcrutcyPrvbig/qIhYTzh7X3WlQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(31686004)(2906002)(478600001)(6916009)(4326008)(70206006)(54906003)(86362001)(31696002)(41300700001)(316002)(70586007)(40480700001)(336012)(426003)(186003)(356005)(966005)(82740400003)(7636003)(5660300002)(7416002)(8676002)(8936002)(40460700003)(26005)(47076005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 08:59:45.0097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a13ada7-782e-4d55-aabf-08db876d5514
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8899
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

On Mon, 17 Jul 2023 22:34:36 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.4 release.
> There are 801 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Jul 2023 20:14:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.4-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.4:
    7 builds:	7 pass, 0 fail
    22 boots:	22 pass, 0 fail
    104 tests:	104 pass, 0 fail

Linux version:	6.4.4-rc3-g0e8d2fdfb188
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
