Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9C47DCBDB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343755AbjJaLcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbjJaLcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:32:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1373DA6;
        Tue, 31 Oct 2023 04:31:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cz0AszdpkpMucjMcpNpYnWtyJXOqnAagDsX8Vbgc60uzMBIh3q6N2swFm+jAnJtFUM3Vsk7eW57rNMN5yg5Q8532KwIwB3e+XQ/zO0J9yBmVAlFrtMBIVH+BTVVBahbjqg0L8HoD63Gxa78yhGpWbp+RayJg5UIWIZKDBqahU5TUgOmFiHQiiZPHULU9ZGib8v0AYKVbCh7NLPCPUL0vpP8mmmRH6o/DUO6bNOt2mawupM+pe/iYJrwcpEFQ+UgdcYMWKCYSu2cNYsTig/5rwsTu91fRKETS41J/2fNalZoLw8nRzjqEBJdFt3VK4FaVwqvcvgtBtkXk08/hDa4PSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvoxKC9rKfTJ+gX2v9OLDH64jTjXRvjskYK+ZaUEFIo=;
 b=k7Ul+MP1+UFfIihTDBBwX32x3IaZJ5Fv+sXSovdcoGZ3oIbP6B8r/5UyvyV7Damv27BB5uzGQiIz6Srgo0TUijwelnP1YErorke3Wx9XD4SquZoFgt6uuv5b6AaRYsIKyRqf+LY6J8/uUoYtlipYt2uqh3qeBCgTva7pXaS9jjFiOSz7og46Cd9SJAcoQx/ydHdyCUu1HfjrLeMRzKUwzM6HJJEO+aw4WnKdBsRka2vs7W3c7IGFdJahc4cnQsXyi+zB4V4/E6qbs0CI5bKevpCWvRJTFydAcIIce9tgYcXuFlzgHiYtyqPQ7355yBW+Qx1hGSlEAMOK3BGCXUi8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvoxKC9rKfTJ+gX2v9OLDH64jTjXRvjskYK+ZaUEFIo=;
 b=WNEKVdVunUOIPqkEejkgRMUFRd0qYaj75Uieum3ZdS3QlaFjT5O4auK/zW2Xw81D8dadjp8lxuDIXD6O1oNfOc4WoCD8qogdZlZZ3y5ymIEkeHrhgIloYH3UAknT/fD1Lxtjn4gvfEgt42QAcpr+nC2eVJ1YHr0jSNkiZI8uZVoKufDfUdGiFHF1JUZGXdILZQzrtB50ThXT/sHNAH1qTYnwlMm6RTPcuqPwRDxTY6AL7mgVgUTBLcSZ/kibMDLHAZQZENNb5juJbHu6GW92WOg+DLFxE6kOrt3uWS+NsT/uFw0DMV5/7gjnAvZFk4LbWFPZJBAnx4d5NZaPwjR2Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 11:31:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Tue, 31 Oct 2023
 11:31:55 +0000
Date:   Tue, 31 Oct 2023 08:31:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: linux-next: manual merge of the iommufd tree with the iommu tree
Message-ID: <20231031113154.GX3952@nvidia.com>
References: <20231027155522.6b2863a4@canb.auug.org.au>
 <20231027171522.692a58ec@canb.auug.org.au>
 <20231030182621.GV3952@nvidia.com>
 <20231031161214.25560598@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031161214.25560598@canb.auug.org.au>
X-ClientProxiedBy: MN2PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:23a::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4592b7-48f2-466b-a3f8-08dbda04fc38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UbTnQ0Tpb97uflITebsRx6+t2XHEpJTx+5RzWRCtnz0UQt7/CvvKxpn/W4LXEleenVjDBvZl6TN63zbCuoFpDIIQCrArgWMHZyIopi30wBVgjIDSG0DYSwp5hg4ka3HSz+A1/AxqGdtrbYYUiwDyHzAQibw4vBbhcTWUh1MbiWkyeMBLKDLdnqP0pIRekTw1n7IEINZgyETdsrkMyUYBIbnyFz/FuYSWw3hp113N8Y4hSgB2z2ZILH5LeYBVF09pUwxrNKf9pBGwZMGZnBJS76+GXEZhPZ4chvNFMKq1V75JcblGyc8vqutNSpYbX/4x3NDXGzgdIp3ycObUFp6V85tXahvT3NYRzTWZeMT441tAuz+VZQSYrTMAvq7ad4TLzshk3Qhel3vR8W12vXpMhBYIpIe9ASJvbAxRMJSdGL7i+CcUH0i6QDwUY2ATlfjJmJvt5vDxM/NWWQLL3q9FvBhhBVBjTezi5CwdNELwisgdoSGck55G/WWE3Bfo8h+L7Z3xFt3Zda/yafhfwUrzmA4wOUuYzbovk0Gn9rWlt5tD5LfSHTs0J8gWlUtwyR4J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(6512007)(6486002)(478600001)(83380400001)(26005)(1076003)(2616005)(2906002)(5660300002)(66946007)(66556008)(41300700001)(54906003)(66476007)(8936002)(8676002)(4326008)(316002)(86362001)(36756003)(33656002)(38100700002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HbNbJemcS8DhGZ0cXScwkGJEp7wx9l7Olbm3P4XNUKz5RDzwD99xyvPdgOoG?=
 =?us-ascii?Q?Eo5io+WydlsX0YxKmDR3ZzS9XEyYx86EHpkpNsCyROmd3cpp/QH+4W3I0gjp?=
 =?us-ascii?Q?unqq7y6be8Ybkr2FoPbuDl7edZO1iAiw+QVVKzlXY29RkppiXWhhfWBpHwtw?=
 =?us-ascii?Q?Oakeq3n7YhY3HvHodF/10YCrwosd/k7eyxiFrtCExNLK/YGlXcLPJtJmqW/7?=
 =?us-ascii?Q?hpkCcmWrLsfvUDJVACf+60e/I4kRw+304jvF9IvX220sc3pbg/ej9kK4WS+H?=
 =?us-ascii?Q?QCpF56s49pyUoxHOyPqiSUBZXXamSbQ0c6YaU3IcdyCP3jfS17NdxJ2VEEUD?=
 =?us-ascii?Q?Qk/yjZzKuQ9JD2ofjYovzpEsB8zLH8kLDvQ242/ADdzva7mZcvVqnbHT8tD2?=
 =?us-ascii?Q?zOGN1X5S2APJSXiSivLgpI02nlz99OcnrvvUQ/cJqwA0u/hlUo2CejV85Ohv?=
 =?us-ascii?Q?X8MV7en7vU86Wj2W4hnkTC32FAnqDNbn4s+O5lr4UXFbAHmfoVM+TZKs454l?=
 =?us-ascii?Q?Jik5Czqa5pRfwMT4Av3bU7pCYgsrDAA05es7Vsje8Yllt0BJ4e9C0ByIGSxQ?=
 =?us-ascii?Q?Xez2prFSgtQ8Ro0gAl/I0HaxVmnacfw3vxcvmzNE+k5SevCotPnKsEjqVepQ?=
 =?us-ascii?Q?AF5yQ8aksZh1Ff0uvQEgQecAnxWpRqCehi/zI9eRNwjj2Prk2ZSJUsH4ySq5?=
 =?us-ascii?Q?YiRQa1hrTJLbeCxvHJ7Bx/2Fe69TRP4JmfJSSVoS4Fr5ucOAbPTyskKl/F7m?=
 =?us-ascii?Q?sDg+9+bnd/I4chZWRZSdEzleGkUpDUJXw7jHeTz5W+m3PAaLXJ58gCl6/IUr?=
 =?us-ascii?Q?Nq1X1kDjzb+VfjZLdtMudtJDhNjag8UR3rd6ks/x4ueHlDo5NXuyuUOzBj3G?=
 =?us-ascii?Q?G//b45kqQxNbEKMeoBJIiFEAV3yoVMlzxoeFB1u44LqDVGiJgOR020r0gBvA?=
 =?us-ascii?Q?JlARO/ZkThJDdA/TTvDSnsbho+n3dLbSJEffVmfP1wFPJqlhWeF/q1nEI+Ek?=
 =?us-ascii?Q?2vE6QiZ2g0hXbq4/tOvLIam8meoDIjiLxZuRQRAfe1uAZRdeznl12a+AUkkw?=
 =?us-ascii?Q?rux5iPZp7wNbkaF0yXg1Jc+L5fM6QvMsx21T13y4IPt+0ovn6t56LBvjjcbJ?=
 =?us-ascii?Q?UyYyu3M8ZErWSxNr6OTq6NUDAG3eUUoQtQGZc00URIzGnclqI7u4d9J2m2Zm?=
 =?us-ascii?Q?uAM4+UoehvEuDF70dLRBJj9F6QZHU8gWUOantIAmzqWjDZhKZYaB14M1mRe3?=
 =?us-ascii?Q?twDrnGHwj2lm3kdCdSZx+Q611zz3jPsP9JadDUqRkFyHBJqs9rCs4D58Zcd0?=
 =?us-ascii?Q?2cmMmbCs3aIJQwJILVgeVaymHyOsrXq+o0+wneAZKinR19m1wezaEOnRZGXu?=
 =?us-ascii?Q?cKiKios+W+MR/5ahd3Ds2cKk2H+V2sAYGsenGu023wWzMMDiMMwtt6QL2z/B?=
 =?us-ascii?Q?y8tS5ZrZWdkAyXhhniFzOUZEc5IP3pAl5CXOPjdmEXyp/UB5x4HV/Jhnf/FL?=
 =?us-ascii?Q?mCgZMawVgHpv7ofKgL7kWks0QB8+eltfNvZy1ZQYRcbX8w7XB5Q8v0eiBA51?=
 =?us-ascii?Q?QlH9qnNRAMaXf13Plyc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4592b7-48f2-466b-a3f8-08dbda04fc38
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 11:31:55.0416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjtadhLhSaUttrBLpNPQW8f2+Mj8Zpx9IiJahdqtAjOidz1/fo4ssnzGs6e4F8pR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 04:12:14PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 30 Oct 2023 15:26:21 -0300 Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Fri, Oct 27, 2023 at 05:15:22PM +1100, Stephen Rothwell wrote:
> > > 
> > > On Fri, 27 Oct 2023 15:55:22 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:  
> > > >
> > > > Today's linux-next merge of the iommufd tree got a conflict in:
> > > > 
> > > >   drivers/iommu/iommufd/selftest.c
> > > > 
> > > > between commits:
> > > > 
> > > >   1c68cbc64fe6 ("iommu: Add IOMMU_DOMAIN_PLATFORM")
> > > >   13fbceb1b8e9 ("iommufd: Convert to alloc_domain_paging()")
> > > > 
> > > > from the iommu tree and commits:
> > > > 
> > > >   408663619fcf ("iommufd/selftest: Add domain_alloc_user() support in iommu mock")
> > > >   266ce58989ba ("iommufd/selftest: Test IOMMU_HWPT_ALLOC_DIRTY_TRACKING")
> > > >   7adf267d66d1 ("iommufd/selftest: Test IOMMU_HWPT_SET_DIRTY_TRACKING")
> > > >   a9af47e382a4 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
> > > >   0795b305da89 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag")
> > > >   65fe32f7a447 ("iommufd/selftest: Add nested domain allocation for mock domain")
> > > > 
> > > > from the iommufd tree.
> > > > 
> > > > I fixed it up (see below) and can carry the fix as necessary. This
> > > > is now fixed as far as linux-next is concerned, but any non trivial
> > > > conflicts should be mentioned to your upstream maintainer when your tree
> > > > is submitted for merging.  You may also want to consider cooperating
> > > > with the maintainer of the conflicting tree to minimise any particularly
> > > > complex conflicts.  
> > > 
> > > The resolution should have been as below (I think).  
> > 
> > This was too horrible, I pushed a patch to reorganize the new iommufd side
> > code to more closely match how the domain_alloc_paging stuff is
> > supposed to work
> 
> I have used the conflict resolution below now.

Yep!

Thanks,
Jason

