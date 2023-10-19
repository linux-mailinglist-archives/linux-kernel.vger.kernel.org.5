Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95587D022D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345312AbjJSTA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjJSTAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:00:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42ECCA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:00:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vv1pVIJ96xzKDXRc9mu0NAkW0gcGb+N9L53WbJ/C8dHsgK5YmclgZfkEPBGnDa2KLuDKNXJdVZpmym1fKCCSKugo6JiisgqO0r5r1bAQ8p5Y5P4VFI6vbhNU9zKVsLstJcqfURjDW9ve3PIlFYjyxLpexVsyNUYkF3aUbNjdZVv3ogf9o25FjfA7SMzZanRRFC4W/QpEIXSn4MCn3yPCiEYtBpvwE7VTpeFmHLduxrDhWlimcQv+10y/JakaZReVBUIXYdokB8BNFT5oqDO9RdAARMIrcouXBAfu+Q8OsplUFFj2ehCEk5Gpk/22aeUgbF4OzdxrqYOhwW+ifUqrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9c2YB7SF6jOdHf01INOWJckSSTUgJrbcDzuyQHq/pm4=;
 b=U4xZVHh+I8rS09UdfuI1065b67vEtKecmTf4OhsKtGYC8tb47zYUSWvD9W4RcYC/7Koxup5EIoALajZx0KjYVeVktcz658jtP9GCcJjCii4Ya5YtthwibDqoc4Lo6pWPPZcWTAF5+c/hZ5U1SJRlJBS5AmeX2Fe04BPNb95Qk6Iq9ujV6xC9mJ/XJmbhHDpu0kVaAXWxjJr0iMDo66Q3sR/e9Nxz6UPaxC5cgDK9MBSgaDOeDOxjbBlU34Tp+5gUo9rVYcSAraneMzHZf1khURHptbgAH5jIVbS0qOnqMouGXMXX1J+GNZHMkk30nDZVowMQZNwXq1wHrD6BoqFBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9c2YB7SF6jOdHf01INOWJckSSTUgJrbcDzuyQHq/pm4=;
 b=aYr2/yfUpKAZrQTEOIpc/q1tz8h6VhXiCDUQ5/JmZo5TqASsWddCj81FjmMpWwJYdtw9sjvyCwt9YBoDMGEHFLb/bNC+KuYHJZKcZJHD21cCF/6DgQkLPhgoZDHn2hV9YuDmZ7kwIdWhBeGWg28rnJJeugGzxMOmgB6kJIkjm/1lxMwKs31gmOHzI56LD2YLNnHVR2yfBGkw4z0dm4th4oqOLt92wdsgmHuhf4r2e5/+MyIJ51aTjrc+J5lJOTBeja762s6i9Ff92hVT8hyH859A2iVpk2U8L4ZlWK+UX2fTXOtUVV9gSbguKM9Jj2SHa+FSZmKPKtKzhmL+ac/lIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 19:00:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 19:00:49 +0000
Date:   Thu, 19 Oct 2023 16:00:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231019190046.GV3952@nvidia.com>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-3-saeed@kernel.org>
 <2023101835-trapdoor-unicycle-788a@gregkh>
 <20231018180128.GA719006@nvidia.com>
 <2023101808-quicksand-roman-0da7@gregkh>
 <20231018185629.GD3952@nvidia.com>
 <2023101913-owl-showman-5858@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101913-owl-showman-5858@gregkh>
X-ClientProxiedBy: SJ0PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: c26d9468-1514-4a04-2f22-08dbd0d5b525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uqWCq3L7IVbZOOdzsWxX+uloJ74/8VANr6OwbtKyagyLhiaC8c7MfKYquowp8/XZMHQPzELkhXO9MC5RJ8IAwxllNm198V+6Mj6Lrwa47s9PvJ7+YLXfkRVcl448zNPK8D1qhmuc26yxGoAY3xIG1jMj5QYDDhsPbLd4JkH3vgLg3k/QNLsKrGRAhm5642ziRV78hDQkbC750d1LpkeHKGlLSSlVCS7j2JWLodzbFFzWspCp6cxG0ftFLlJqwwfehMdnIi1dLS0s+TbmC0x/3JvN+8+NflUvYMyTsL2P6C1djTxtdmmCKr1vjcD8r8fanXlKqVJXCExhpbpHYarXRO249OKFO408L/GFneOS+kecZ09nQGK7m+lxQ+P5rSuVqCFEMEPqNr65sxH9M26FiAR5iiOsHn+Pz5oJMBNZK3WHWrEt23lFjEqm0oIgCpwYfXy2NIClMBPd8MdMpHFexhd3z2cXYhLeSDZWHTKWHtARUmy+4APxvZhxxG0fiiuzXIwoY0yOBPw/UBDY8CN5zFdgD0fZuzUGc12Fll2FVzsgpJ2eTMOs8fKWbAbxetE34YMNVnnInKhZe0XjVh+QtAyKKTl3TmeoTlT2RRyNpl1nA9dL5Q2tJM7+gPDsY3agrRFi1dciDoioRqrYtUECMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(83380400001)(38100700002)(4326008)(107886003)(36756003)(2616005)(6512007)(66476007)(86362001)(6916009)(2906002)(316002)(1076003)(41300700001)(5660300002)(54906003)(66556008)(66946007)(478600001)(8676002)(8936002)(6506007)(33656002)(6666004)(6486002)(26005)(42413004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NAtiSYCMBYu4plzae8AkCD/gYgadaMFCOW28F71YqJNi+11GOP71FE5O3lTp?=
 =?us-ascii?Q?4jv1ZbnMpo6PzBUaNKtNFrF21AhQXPs42UazIMgsbyNltT7ptULSB71ewiSG?=
 =?us-ascii?Q?PYEBmMDDfIGd3AJ7WjGfIE3iFn6pEIK3jDFxNc3ARIeEaV5pXt6qVS25YmT+?=
 =?us-ascii?Q?6C+Mgk6Gf6OgIhvt+6y3WuF1KvcdZm8fQdeiXda4fC2FJvfJ4Yk6eJHtEhxM?=
 =?us-ascii?Q?HeureErGVoC6YfFeB1xjp4p4SW53w2YW7a8UrtsOcKYdBNzpWuvfdfJkzfs/?=
 =?us-ascii?Q?z8GykuudPJ3W4bWsBb9iTnAqIwdvPZwXO3n3xnl2658F7ZfGjHwqhOZbSDov?=
 =?us-ascii?Q?5j7iklyVZsfcKiEi7DowbSE+s37TCmYGYBX7GNnZWz7fW0Qk+xLRmFwsArAP?=
 =?us-ascii?Q?IfnYaXOobVbTibfc4KWd3q7pr9MmI5dK3qjj5TttiPGdkH/YVXmUVobe25lT?=
 =?us-ascii?Q?2jAOUau07YQ6pGPfpz3pMYqinVjDybPSzIum6cOhifhx0D9z1yGmUZFKz/WN?=
 =?us-ascii?Q?lHyZNaeoh1fQWO+VWWQXZqGkRpGA1MfsudMcAQpn+GQUhRVCTRL9htFn+oGQ?=
 =?us-ascii?Q?8kbjpsAvejBFz11EO6QFTxJ27Xz8DxEvbSW8W0Wim5Q/CmJ75AwJFsiz7ZvC?=
 =?us-ascii?Q?iKb2yaWsLf0Ws54JNPnKepyc/ExCdIqLTjBOw+f4q07gs6sC+H2KEEpDO1l+?=
 =?us-ascii?Q?m4mSWKDfx1EqUgAPV27dDc2oJK7FFYcbGrkciE7pFvLw6kJKwoqIRk+KK2zy?=
 =?us-ascii?Q?m73fOEoeSJX8eDUe0IblyYxMebtLdh8fGzJrvdL2rrtrcv2q5Ihh77iExrxV?=
 =?us-ascii?Q?fy0dtjH4+XC7ZFUij72Wus5NJ9zZMtZ5DorXtlPQugK0MXRp+VphJwDKmuM6?=
 =?us-ascii?Q?v+lR6/T13I0iRt123W/icqODr3HAKBIg5Exz/2TijErjyBa2hnj4QtPFW6Vx?=
 =?us-ascii?Q?bI4drGgfvTR3S8vgtmYu1xMKvnkFe/TeqiqB0dYsl4onpPuvU/WxvIaUJ1hg?=
 =?us-ascii?Q?Chrkrz+DLA1T7UdYvkxaGKkVI+hMEgxOLGefmmeg9zGWpqxGiUSSLHxs1UDc?=
 =?us-ascii?Q?Vc3/htRlIVRWuUzZ/5weGEX4e+RxSb2ZxKYuIRS68IBJVMCxOe4XuxbBO/Hi?=
 =?us-ascii?Q?8j76Xp35S5WWqgxEGHWiJ+IzI/5sv03cZDCHYyfCmWSDNGVTAKPFwwlu1EaI?=
 =?us-ascii?Q?JmhoiSPbA24M1muMK+rkYsYg0X2zh6bTdq9zirUN3IWlcdNfwFB3CNeV/XEn?=
 =?us-ascii?Q?arSghaFLeGTt8O2teLrPWQ7Aq+TTuI720gGu3UuNPR3sqhAvvwfa5F63NcdP?=
 =?us-ascii?Q?4lYp/uwIuSgQ61gMMwGOY3S8w9IW4wg+HyCfAvAP48yZLlX4hHOdf736uPjb?=
 =?us-ascii?Q?0NVLOscDjZY6tsqfpZw6bEPDy5XGv1fCeF5aoRygm+MO3vRyLGffQSWp4eiD?=
 =?us-ascii?Q?Bn7LpTltQaK33qh9P3oOabgrdemyD+PANk0xDS0uNXMS69FHTPaTnyKIMx8a?=
 =?us-ascii?Q?Zo+PRTaBUuTe2genvEG3SkwL9uznMs57JLFyLTOCWVcLaQwYVQPD+DZAPR2R?=
 =?us-ascii?Q?fqbonatDFxa6TuQSFmv6dDa+v5xiC62Uap3iRmhq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26d9468-1514-4a04-2f22-08dbd0d5b525
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 19:00:49.0880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VT0/N/Puy0DDTR3zLHK9j2z3w5pT6y+EFSAxeuaHNIKiyKUSaWiug8rlDf/erMID
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 07:21:57PM +0200, Greg Kroah-Hartman wrote:

> > Are you talking about OpenIB specifically or the concept of dual
> > license (eg GPL/MIT) in general?
> 
> I'm talking about OpenIB specifically.

Let's put that aside, I think Saeed made a C&P error since he works
mostly on the historical code that is grandfathered. He will fix it to
be another our-legal approved license, probably "BSD-3-Clause & GPLv2"

> > All of the Mellanox driver stack (over 400 files now!) is dual
> > licensed because we have a large team of people working the Mellanox
> > driver for many operating systems with many different licenses. We
> > want the certainty of a permissive license for the driver code we
> > supply to Linux as the team routinely references and/or re-uses
> > Mellanox authored Linux driver code into other scenarios under the
> > permissive side of the dual license.
> > 
> > For instance I could easily see the work Saeed has done here finding
> > its way into FreeBSD. We significantly support FreeBSD employing
> > maintainers and develop a sophisticated Mellanox driver over
> > there. This would not be possible without the Linux driver being dual
> > licensed.
> 
> Yes it would, you can take the work that you all do and license it under
> the BSD license and put it into FreeBSD just fine.

Sure, you can do that at day 0, but mlx5 is now about 10 years old and
has tens of thousands of commits. Many non-Mellanox commits. (mostly
non-significant, IMHO, IANAL)

If Mellanox today writes a new patch for mlx5 based on that history,
can that patch be re-licensed to BSD if the file it is based on is GPL
only with a complex history? Our legal has historically said no to
this question.

We are not dumping code over a wall where there is some internal
reference that has a single copyright. The mlx5 driver team is fully
integrated with the upstream community lead processes. I'm very proud
of how Mellanox is able to work like this.

> But you are saying you require Linux developers to help you with
> your FreeBSD drivers, which is not always fair or nice to take from
> others that way (in my opinion.)

AFAIK Mellanox has never done "require". If you want to do significant
work in mlx5-land and want GPL only then put it in its own file with a
GPL only license.

This has happened in drivers/infiniband which started in 2005 with a
group of like-minded people/companies that wanted to enable a full
ecosystem across a lot of operating systems. Later someone came with
significant work and wanted GPL only so it was placed in its own files
with a GPL only license.

I agree that "require" is not really fair, but I think there is room
in Linux to support people that want their open source work shared
outside Linux along side people that don't.

> > AFAIK this has also been a long time accepted Linux practice, there
> > are many examples in the driver tree. What has changed now that Saeed
> > tries to add 3 more files the giant driver? I need a bigger
> > explanation if we are going to revisit this practice with our legal.
> 
> "the giant driver"?  I'm confused.

The > 500 files of approx:

$ git ls-files | egrep -i mlx5

See the other thread debating what mlx5 HW actually is.

Remember that Leon created auxiliary bus so these complex multi-system
HWs could be split up cleanly into their respective subsystems? This
is an aux device driver for the misc subsystem as part of the giant
cross-subsystem mlx5 driver. Ie Saeed is adding 3 more files to that
existing monster.

> > To be clear, we can surely get the approvals to remove the offensive
> > OpenIB from these files. eg mlxsw is already approved using
> > "BSD-3-Clause OR GPL-2.0".
> 
> For your new files, please make them single license.  If you insist on
> dual licensing them, I will insist on have a lawyer sign off on them so
> that they understand the issues involved with dual licenses, and just
> how much I hate them in the kernel tree as they are a pain over time.

Please share with me what words you want to see and I will get them
from our legal team.

> I think the only real place this works out is the ACPI core, for the
> obvious reasons that we all want a solid ACPI core that all operating
> systems can use.  And Intel goes through a lot of extra effort and time
> and energy to keep that going, so it is costing them real money to do
> this work for this, so that makes sense.  For just a hardware driver for
> a specific company, this feels very selfish in my opinion.

It costs Mellanox real money/etc too. I'm not sure I see who it is
selfish to?

> I would be really interested in if you all actually have taken any
> not-from-your-company changes to your drivers and copied that into other
> operating systems for anything "real" that wasn't just tiny bugfixes.
> Have you?  If not, why go through this hassle?

The FreeBSD team references the current state of the driver in Linux
to guide their work. I don't think they carefully track the providence
of every single line. Not doing that is the main point of a dual
license.

Honestly, this has been done for 15 years now and has never been a
hassle at all. If you are asking why go through the hassle you are now
requesting - then I will have to get back to you based on how much
hassle it turns out to be :)

I believe strongly that Mellanox's efforts in FreeBSD are open source
noble and not selfish at all. I'm confident our legal will shut down
that project without a dual license, so I will go through some hassle
at your request to protect it.

Regards,
Jason
