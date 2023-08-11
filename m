Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6047786D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjHKFAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHKFAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:00:21 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA5C171D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAC64Uj0Gk3vuLjgB+YZcPmpS0YfLqNC28j+fuqglw0YjEwKw7lk+VGSlac7CzqhRoS1ZfNzvh7Tfx630jYpj+FGWIJkUnJRXtP5pVJ5Sua8JRFC20fV/TJDkIKRKf2cPlTAYto5K9yV6B9eQp9q8m8g+qqHpQrg9iXhqRcr40upVEgTOUG+uzeCEaOhatSCGGRuNUTecSHWisETps4NRt/5vhW9zP0bXChuSnnXjkKeiXAYN1p0jRqj98B/exBheNOg0bsAgd7/PLe3auJayWOccus0wQsCOVi9om06hrZnCDszeKX8jhq7YuLbMuhdkB9UoOn/ODlTlHVbFzS2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9tXp+TKN9KY5TjCVF4BgMQQGFkyPR347ns9gEqSAvw=;
 b=J9kv/Q6LMdTC2SUOTA791TkxwxlumHsXXtbFdq0394X5esF1QnC0kr6UPFS+bm88RXqxyVWOrEEiF2q062P5jJ7TgZ7884KeoJJ5eilXHuypgGIC06+Ui4HJ06Z1ysXMhnSymZnhHJ0AEWdx5NGqXJcowvI6cQI37/CvpDafsZS90Nc6mvCsGMHfR/Vp8g/zri28PdAjVduNqdQTGGn55Lqpbgch/hbFiQ02PIMbXgRa0tQs3kDAMS5hKXeOF3VABak5lksbT1hf/tJEPG0NcE10m1YbF92k6PbqKe2D6rckxPskKiADoh8HBi6qXVI0lvJEw6eKZgunR0UaxbRJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huaweicloud.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9tXp+TKN9KY5TjCVF4BgMQQGFkyPR347ns9gEqSAvw=;
 b=Ujdt5hOdlRUelST1oSReLxUEaGpD+OJeblhk252nWNimeFqZsicvlzdSw41mzT1jf02SCa6B8vZVM5phY5Qj3cFIfue1fbQLQ574cyDbJTwCt+FV+BjJ4JnOzsxqT2Ag3xZHbXF9kPK2OYTRnWOkaUe7bib9N08wCFFFfKMkLWU/XHg6aoKufi+ijo3x6iFEcV3HnulvpcL1diFttoPdkV4b9MDWpv3KjGFN3idxQHY+VW/+RbuhGgjcXleYA16huNhjY5xGB40zATs3VPcubZ6fgDbEtXaRc44pgbpArYsGj/ZA6Ftx/IBIAyKVzKBzN2TkVrEn+Ds39IZfKk6DvA==
Received: from CH2PR18CA0021.namprd18.prod.outlook.com (2603:10b6:610:4f::31)
 by MW4PR12MB6707.namprd12.prod.outlook.com (2603:10b6:303:1ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 05:00:16 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:610:4f:cafe::43) by CH2PR18CA0021.outlook.office365.com
 (2603:10b6:610:4f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Fri, 11 Aug 2023 05:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 05:00:14 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 10 Aug 2023
 22:00:02 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 10 Aug 2023 22:00:02 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 10 Aug 2023 22:00:01 -0700
Date:   Thu, 10 Aug 2023 22:00:00 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: Add support for ECMDQ register
 mode
Message-ID: <ZNXAUAVZ/nNXl7qK@Asurada-Nvidia>
References: <20230809131303.1355-1-thunder.leizhen@huaweicloud.com>
 <20230809135603.GE4226@willie-the-truck>
 <eaa7758e-9ff4-a039-7f94-734f63c72ba6@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eaa7758e-9ff4-a039-7f94-734f63c72ba6@huaweicloud.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|MW4PR12MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec7eb8d-8afb-4950-0ac9-08db9a27d993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v8P/MTqLqGvQkWNgxUkMdy9X75USirFtVxSCdq8AYFDC6JSu9K3ulBRjWQ1pbSIrMa4De+3kq4GHDCuD5p/8SUCPxIbFFViIj9Qu4lzXfVpOM+VdkgNtQ3fQVn5c6+u4WFxIQG4GtcV+I69LM2kGSrfGtxWHG33+Mp57FVb6ihCJgWinbfFzMATfQ3pRktq50nH0c+Zzn0K+710PWSwMUCuMzdfGiWzJE10Guf8IMchWb2H9yR6UYMkcRU+AGTSI4vk0+qcV5WkY309AKeTDvhxGTRD5eSX+wQpa0kI1g5eD/HTAFMWOcjbmstjJfuglYvIG7TXq7SPoGv0luj0+/lZryKvv0RjEW2nIXU9jceDKfitB48G61r6guQ5/2PJVOTpvrs1mio/HcOngCAaQhZmxNg7jqiG6++z1sIWBAN7enhohL7A3vyEbfdlC6eEnbZsSFDIXTb3Il2QO+lgi5oowj69oYiZ+L3cjjx4nzB8K2A8MiRdi30sDwMa6jSxHzW2yZOgpui/RWl445Vpgl9/VyBVWaXaTl3byQq5XHPGKDh7KP387JsGiyByJkl8FHOoM9lbZ7fvaS2XkVlpqoAPsjVYGiaEOSH5Zfq5Q83k2SZGbjxBKhnCjmYDLiy7wGvEj9YCC5qxpWiB4K0RaPl/P2n1aSoP+H0uqijkrBiMvGYwZBYtgMgODAGYpn2iG/fX+8L0wCivcTT//gkjzxetU203AUZ4cbF+164FFR69XhGGfr57QGIIlC4HSYOkBPBIE/pIlr6fCdMlML+JxiKRUkSnmULg7yhkzsZ/QnjM=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(82310400008)(1800799006)(186006)(46966006)(36840700001)(40470700004)(54906003)(5660300002)(47076005)(6916009)(36860700001)(70206006)(7416002)(70586007)(4326008)(478600001)(83380400001)(86362001)(41300700001)(8676002)(8936002)(316002)(2906002)(40460700003)(7636003)(426003)(82740400003)(356005)(40480700001)(55016003)(33716001)(9686003)(966005)(53546011)(336012)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 05:00:14.6814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec7eb8d-8afb-4950-0ac9-08db9a27d993
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6707
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 07:18:36PM -0700, Leizhen (ThunderTown) wrote:
> On 2023/8/9 21:56, Will Deacon wrote:
> > On Wed, Aug 09, 2023 at 09:13:01PM +0800, thunder.leizhen@huaweicloud.com wrote:
> >> From: Zhen Lei <thunder.leizhen@huawei.com>
> >>
> >> v1 --> v2:
> >
> > Jason previously asked about performance numbers for ECMDQ:
> >
> > https://lore.kernel.org/r/ZL6n3f01yV7tc4yH@ziepe.ca
> >
> > Do you have any?
> 
> I asked my colleagues in the chip department, and they said that the chip
> was not commercially available and the specific data could not be disclosed.
> However, to be sure, the performance has improved, but not by much, the
> public benchmark is only about 5%. Your optimization patch was so perfect
> that it ruined our jobs.
> 
> However, since Marvell also implements ECMDQ, there are at least two users.
> Do we think about making it available first?

I have seen something similar (~5%) with VCMDQ on NVIDIA Grace,
when running, in host OS, TLB flush benchmark tests concurrently
on different CPUs.

Although VCMDQ could be slightly different from ECMDQ, both have
a multi-queue feature. And the amount of improvement in my case
came from a reduction of congestion at issueing commands to the
multi queues vs. a single queue. And I guess ECMDQ might benefit
its 5% from that too.

If we decide to move ECMDQ forward, perhaps we can converge some
of the functions to support both :)

Thanks
Nicolin
