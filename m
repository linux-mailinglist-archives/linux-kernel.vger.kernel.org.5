Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763FE76B6FE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjHAOON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbjHAOOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:14:05 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C81B26AD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEF+YVtAhzLa/HNEQsfK0ELlxQle5cWmvEv0F4v7c1wagqnU/1lledIh/cErudtSxpdxfkNzuEgnWl2QC2Y7bFykzRcvv0eSLivKNz2ou8LX+gmLOgzykJf2JOAyMdBhto51A1/06wgWFmEBk3gMscWB0EfY9N3YsbKsPStdv94yQxirok9BQ/ox4XI98EuQDrfL7PyemR9+7OK0JrPgI0vJCmk+zTygJB3O/GEWIV/nXN/QjDbRZiplmkYU4u2fuL2h07REsSe2xTIpXvfgObIvXODzC8yXU6bSNvHbEec+p/h94UTwTH60qmwC3/anZeZlhCF6VNRPaHa16AVgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WTmZPImN1HO0inF8rerYKyJiIYOninbUT2b2107yp0=;
 b=oeZnzlFkEXCt4BtKnpAnt05gGUVxuEGy/kJ4p5/lFMZr86v7wgL+t8AuIL41gWnqlQkRR5IDHcDsDKUxtwFDrh4dODv8y49vFOTobm8wo8N3/4Op2sO/eIozzKsrwSUOcoWLpPCFLrjAv60Hj/G8XMKk/1yvmG6bz2G3XQI06KCaoU3f5oLQNl9GXA8JTEI4CgGIvAxGuKOHrV09KxA63x3uoEB3FF9Fr6mp6p843dmI4/w9ztbtXETfXA3MYTLStNsa1cnITP/N0skfh9vDkZu0XUwZi4Idq8pOZdu0X4oN4ZDTStsHnFqqWDLEi0d1TDWRxDVhmzqQZGO6cTjBkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WTmZPImN1HO0inF8rerYKyJiIYOninbUT2b2107yp0=;
 b=LPM7kmSLHqReMIRfRaUzcvo2AIDjsqkag+lX64W71ppVwnzqFS6DLU7wDjkP4IMWf9D4VyAnpvClUr6Kbi+X2OuwgxgiCHLssyS9P6Ga/BAdEQBXHJJ79gQhVGCJ+36n0GhZExrSCmhRZg+DpSgqOlsSvqOPvpZhqEm2Tp7yBxnqKCSrOikmybLW07fCZDvyvPaKPAxQD03FYD4xd8K4blvkLttODldTmbj6zhycDkMSrTknkkXiOiaP3VYZQGnwC0/RuLwH8eVpWdvA+yID1pqoHCBYUXq7bIS2jRij1Fv7B0u57/fgkGXg8jft2nWyPzw31f8c6EpkoFuI1JN8xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 14:13:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:13:46 +0000
Date:   Tue, 1 Aug 2023 11:13:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v2 5/8] iommu/arm-smmu-v3: Skip cd sync if CD table isn't
 active
Message-ID: <ZMkTGJFWrIO4q4Ej@nvidia.com>
References: <20230731104833.800114-1-mshavit@google.com>
 <20230731184817.v2.5.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731184817.v2.5.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
X-ClientProxiedBy: CH2PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:610:59::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: b440cf8a-6202-4a7b-e5d9-08db929984d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VmG5u7NGaRVfMR8wDqManfd/3WGSrHvqrtRg9Ib9TtdHld8+oiB8xMDG5WNWko+ZUJM2a5b34+O9u+SKtAT6ECFYJdx3pZaPBPymDzZ6vH24QPFDmVfOqD9tk0ygeb1LyBDdfcIvUA/0pnwvdr6CQmH+5tOASrawvtomEIOCZSwNuaJ51GydtwhkntbGV4wjHq0F/lOffss+qs0k2fClsa1PZSRJlclUMGv1w/ccf7fdTDEaggZEQ0vQv30Ue6P6lHqMcsoQCQKBYaEJqYtMvznzrOmj5Shq7tY+0oP+W/F8xUB/eOSu2CsV/DSGMhtx5QsClioijoF6JjlT8b/wqfG6PWZhBCKPagUCZZ6W2BWd395xcnnw138uhhZidziG6sfQJY5DhIPvXJFCi5ZMY5/okVdZ/tQb5N1YUt1673UpWdmdMK+YaaPX5RyPTFUI8EEf1GYG7x+1vqQUSrBDB8LemGxbPFA6YEERB2F1tj6tAHbE/JcBf4sAUwIivM7vqumMNklmHDdrlp+7KyWG0CCkyeehIwMnz5SFsAAoEZ94UzYIBaQPhgsrOmWdvMdv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(8936002)(8676002)(36756003)(6486002)(41300700001)(478600001)(2616005)(2906002)(4744005)(26005)(316002)(186003)(86362001)(6506007)(5660300002)(38100700002)(6512007)(4326008)(6916009)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J3E65JSJiK1dUmBeOr9uXHLcfDLzp+MzqrMT2wzskJQZhiRf1a2ikGkJKhyg?=
 =?us-ascii?Q?xo1NiWywWVTy4xIVAHM11TbIfRia0j/SEZ+K2TGZAIxAF6BtPLqjCNo0D7rp?=
 =?us-ascii?Q?xCyebEKx3Hrbr1nl1ma08HSAFudjq1R9R43FYWVK0wAzY+L3ZAinxn5Nsd0L?=
 =?us-ascii?Q?P1tSqlZjHN/aYOofOSF2qdbqqvEupgFDtj+fUyiHn53A3XSA26laFd+Q5jlV?=
 =?us-ascii?Q?DgPLhi6fqmuwjTRtHMYXzJ/vGZ9GIDVmUoYYLdbXPKyizQ0EnDRQV6rKIOiw?=
 =?us-ascii?Q?8O7GfV/CoNwiKvh5eODMj4Tjp0zQ2aqjeSEvN2eKfl3Oh54PYnBZ20L+UJzW?=
 =?us-ascii?Q?WAyRh1G4mvBJ28PfPc6EEQU0pX3RNj+wY0GXN+EZRPa8NJdcRm0hZpliciX9?=
 =?us-ascii?Q?CCHWXJsHCBaryPkia7zwWYt19yfD7e9i9Yi4BJobCkeWFBatGOQyA+U60YuF?=
 =?us-ascii?Q?MyglQX94ELJX/UkwwicHE0wYhayxq6d5tmWRsfex0YuaNKYLcUBNqD+i0+Ho?=
 =?us-ascii?Q?gsIPcXb12A/4mE5myaWj4mqVaNi6GlwbPsTxfo0aECeUd9XhS5c677zNxKKO?=
 =?us-ascii?Q?WROvYJ0bpPGSv3o3dSi0T3gDjAXZ/t1/hkRAFnaZaq3H6yBU2+LibGV9/GyC?=
 =?us-ascii?Q?Nd5S4HWk0WKatiKE471inemKGSEyhZKyzkdeNkNeo5O0s8z4+dTtYwyi/u9c?=
 =?us-ascii?Q?usH0UJNbsAi4fw+ScMIa8hfI4YgEYhhgv1Sm9yhQGGTFfRRSzNSl93lEJkWQ?=
 =?us-ascii?Q?cT40z7UPqk93dxwjgaqx27keoLgbKwVTgiiSb4dHhyXRC2UCHyo7cwy5iZbh?=
 =?us-ascii?Q?PF4db55TVtIWVir32AWfaYaFekNLgg3k8di7SGsx7TCGAZv71xnJdmeyfwCh?=
 =?us-ascii?Q?S83A8rGlEQ9Lk4Tu0H3X2+TBs1lWh+YGrrTxJVqutr/PFqVbfFtoF8SD/M8n?=
 =?us-ascii?Q?wG5Zis33k4Ao5/WtYTA+uIVmEzACWmAnw2s9aU9l0VEW0uyUfiVHig7WkAns?=
 =?us-ascii?Q?yzq+dkIPNUSjJuDfELwqe71V0v7TQdUGuzq5WJnQ9eaIL8P5WtMwVX30H8R6?=
 =?us-ascii?Q?a4nNEofr77gYqHs2BgL1tf9dujRIzVIxsnMyQdn4lrFHQQAfEuOmko2v7rzT?=
 =?us-ascii?Q?fnl8BQOR+v+QRrq4vjjerVAI4NiRYqvpMkZcrtQK9cXbMQ/iTiT3nKo0NyO3?=
 =?us-ascii?Q?bgDjjhaUoXRwZUN7Kwn91FbkcBVPelxeN6ax3HQqVPb4IkjAhVCgt+O5P1SZ?=
 =?us-ascii?Q?tm1/TcmSgVOWJlWpFSReCQ6Hdxr7s09MzculTIT/t1tEYGj7eKvpubSCoF8J?=
 =?us-ascii?Q?sSG7Wz2UIO/GocyR6Se5f4TU226g3YtfXVo/Zhq2BAA7bI1JzksLdTYXLTrK?=
 =?us-ascii?Q?ID9xjnctmt1PgmvV+7/RiIpb8Qgv0J3acbY9lxYgUiZPiT8fFuUaDBOp4Ey8?=
 =?us-ascii?Q?3GYqYECXmK1CSsu/4cdxD19BeIQHnZZhFweArx6U227k7Z7VSj00tsxw4zNw?=
 =?us-ascii?Q?Yfg7BxZChbKm3HLQFu6whnlHJhA3uEkcJuKyoKiIk4Znz90uiULd5UboRzaC?=
 =?us-ascii?Q?CR4hkV6f6szOxnWEXBooaMM/I5BEypf1MbYXHXrF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b440cf8a-6202-4a7b-e5d9-08db929984d6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:13:46.0775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sag4UWPvB0c2kT+1ia98+g26O5HMYqiil0dBHf4uFSlCT3wdOLhtXVC313j2+AH0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
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

On Mon, Jul 31, 2023 at 06:48:15PM +0800, Michael Shavit wrote:
> This commit explicitly keeps track of whether a CD table is installed in
> an STE so that arm_smmu_sync_cd can skip the sync when unnecessary. This
> was previously achieved through the domain->devices list, but we are
> moving to a model where arm_smmu_sync_cd directly operates on a master
> and the master's CD table instead of a domain.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
> Changes in v2:
> - Store field as a bit instead of a bool. Fix comment about STE being
>   live before the sync in write_ctx_desc().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
