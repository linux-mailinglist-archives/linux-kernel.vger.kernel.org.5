Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3340A761E82
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjGYQ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjGYQ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:27:57 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881BC172E;
        Tue, 25 Jul 2023 09:27:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cO8abwuwX3RXjje8wvcGgewgqhOeJPeiD9HMy/NQjaqN7X20veK1MQ2aXikWpAsonH32h3GSBQ/T0ti50xNizzA5fZJYOz5xroiPuTqFmm9nXxzpULqiRrlsrzXVz58wmLzR65OBVBvdeJfJbcs3COPkwpIeJTjn+s27tfaJC/nsFK1n+6/+72dx8SyNZyCV6eeUlWciEjdN31yY1zgXG2AYfmy2ZLhprS198XoSMkO/lCnXKKVDrDvCoFcUdNCeMzHsYbGVpyINGaIaOTir1LYmdNFaN/a7yFPioKAvT8rDTLH1yv4Z7qP45q6obLBI9XZyWvMe4S15/5p6TvaD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqX8e4lPwR+HhDxNF5HjFvbFjf5TJ3sSbab+6LRICCU=;
 b=Gx1i/8I7T0SKDSFxnoeyefcYYKeMW40OpiCQt3tKx+RWmNiyldq3+Bu90IwlUlEpOPbsZDIKUQ9Ut8Zd6RAGcmqJ39xPstXROcJyEbnh20n34/JhjTG6hbPuHAWjDGQJgsqEg0m4cFucl5Wz0gZfXB7CQFstL8vuVIQ/arSG15MMbnAZimxcPiiL2N70+E+8UcaQbXrjypMVDRt6Ibdq0rQLo6jcreDk8H3KSyyG/RCnHKkSLzHcl6CG0YaZnq6w0dW2q3XiRrOdYOroVQq0xjGeAX0O/aDMsv/llwvylzYjZAADvVNCLhiUXrxXa6W7mi2hb9bwVf+9LL570nCrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqX8e4lPwR+HhDxNF5HjFvbFjf5TJ3sSbab+6LRICCU=;
 b=LGYr5kJ2sUIbKgy81CWakC6XuMcWIQMCOMPqG4p/+8TahpAuxx16pWW0ByKhKG9LadnSF5GmZ2cD7ME1fHHwyc8DC2oX6uzHLuR5QUgsFwbm3C4RtWsVR1U4PrFgncJEGiH4Gv2IJK+F8gIApQDhXgCzQRdaG3hL18fMR3NsCb0q3u/BtGLP+NY9VvXdTUX0mloKREDmc501ibs61XGEv2eScK6oChWte/KAwsoeI2QE4RPzprkbIEHcTlczHSWP8JcZkvhN6BmIsmB+PuqL3M8dgzzktyjjU8yWZDGPHTH/C0yExro5R4nrfeyWkg059qd9edwUkCpcyVesA6EgqQ==
Received: from DS7PR05CA0005.namprd05.prod.outlook.com (2603:10b6:5:3b9::10)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 16:27:54 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::25) by DS7PR05CA0005.outlook.office365.com
 (2603:10b6:5:3b9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25 via Frontend
 Transport; Tue, 25 Jul 2023 16:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 16:27:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 09:27:40 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 25 Jul
 2023 09:27:40 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 25 Jul 2023 09:27:40 -0700
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
Subject: Re: [PATCH 5.10 000/509] 5.10.188-rc1 review
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <4439ab9f-4fe5-4386-bd30-55128286624b@rnnvmail202.nvidia.com>
Date:   Tue, 25 Jul 2023 09:27:40 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT015:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3850ff-9d35-42eb-e6b3-08db8d2c1945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MRxfqUrIVluvSCzQR+scxUCWi896U/e8R4HR8ozPtOQYIdp7J9fB6LlMghgeOB54jKk/+VBv36Ooq7Gs7gBfK7NGsD632MgfiAJtFKrDwp9j3irCObEX2fBMsNnpZbOwqxcSbWlHQBDtwOc2DV7znqsm+zFQkvhVqRhO6Ryeg5f6UgYYaHFLaBAoUI2UrtXIuOjRaT2Wi55XTGUMwBkHPLm8mS6uGn/uhGDJoDhUduIvoVteXHscdhdos8TuWoE6h6Lcm2f0TuQzr0u8F6m5Q0S3/OGzifBGs6A7IgzJ27/J5Wv98lOpp5MxnGaFUqrrTSpPbnXDi0H//F6s/MOHNkzMxhMo833JD9FlCDi8p29UFl6WjfkCc3zxub1Z/0HY6Zl+hLNzIHHUMHZikAL365t7CYI/9GgcPww9FlRDAxtQ6UJGuHvCs0KVJiGOwu/qDon8W+yJPfffrkp4DPGN1xQ53gfPifH01xo3pixoaniCz5KNxL7IceKY7Mf3nHNbFT1OVKrkGK0qKJMO1HuU38I0cDSZjU375WsgKHOCALgpr1XPS7VKzV4W2pPPCiTY6Jnmdc5xZ7uy0zLVoU9D+f2QbHLO5yOtYVvKMNj6A9385o3Jlldt/dTPLabrnq2jIUV3mCoj8seaGaCD71wkrQztJzAq0wMkya2iLJQXNfJP3sTQrQlFfRu8zTjlpg2G5RS/dXM9csQcT4KPmgzsLfnDhzmBfD/zwjHQ+ysz8Nka+v6FiqJnQ75BQvnJPIH1h4502IjZ4YztmCAVUW+C9TjP62z53MyaTM/oqYyR07A=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(47076005)(41300700001)(336012)(426003)(186003)(478600001)(26005)(40480700001)(966005)(40460700003)(2906002)(31696002)(86362001)(7416002)(5660300002)(6916009)(70586007)(70206006)(4326008)(356005)(7636003)(82740400003)(8936002)(8676002)(316002)(36860700001)(31686004)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 16:27:54.3739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3850ff-9d35-42eb-e6b3-08db8d2c1945
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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

On Tue, 25 Jul 2023 12:38:59 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.188 release.
> There are 509 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.188-rc1.gz
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

Linux version:	5.10.188-rc1-g4a64f0370103
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
