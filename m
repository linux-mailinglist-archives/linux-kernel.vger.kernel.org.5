Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15B17CE5CA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjJRSBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjJRSBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:01:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11hn2200.outbound.protection.outlook.com [52.100.171.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BE0113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fk3G02lqJ1EwXFsB+zFpmLg1par0yoSE41gcGlcS8YPIjAXBXMgeUw78FNc/xTnw8nUJiSmVW8ZjyCFs98XhFgv5vXHCrr8g4Oy+z1NyXi5D2oNO8hvNI1eJ38f6ktN6qJuNl4g3Yx3M/uOaxKbw8wglvwVEgXWC3fyohHdeSIVWWC7xtm62+EEkEA4CjJVVVY9Lmg/rfK+IXhyYHt2bFBYDfI7M9SIc1ZOHOkKC9IzyimbiNhemUDtm18BlZES7Rxou8Sb548Izaqlv6+yDLQwyQS6qswm/cuBa6qtGZS4jzUuHBj4jAEnRbNbC/gjg+NNGi+Oa6CkdMoT9l2ehhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzP2vFUh46JhYc4Eb76QC4gm3VmpVKTa32xn4px0Hlc=;
 b=ToqLherhvsGKqqGS4Ybu3oDde3pX6zNJOuCHttaxvFxuKvBL6RNxddfjukS/anHZz8g7XsLliiz0fio0CzHMwgda6XLjwqzfpWDuNj1RFwKSS8YjP8856rfaHLzZoxF+imJZc3B9NaxW6E+tQcyPKH3BbHv2AYFIHHbnpsIw1bXJqVIQgKc+xybssHjBUNOkhWA3UwONSfv1aUYU3noiuWwrdK1rI9vhUiJDAn/5w+iwxvii9FyPjx+xFdHpOeJKsDgX+oDLRl6nbw8/AnU0wGg3esyh3DYaTkzjomp+5IQB1MZZ16K9s52JggUnUtZQi8GBMT7Fg0u13Lt5xM0ysQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzP2vFUh46JhYc4Eb76QC4gm3VmpVKTa32xn4px0Hlc=;
 b=S9ESUwjoWGagf57Q5uwJAr6n0fRPENxMLzMloNGUPW7SPijPuOsEDryZU+L8EQ1X4B08Jasc3D2EZzKRsAB+tYCDW1K52tQhXA7GxOIZY0kBtgZGKN4oGhOFkgVcV1PlFcdKcQW/NgIOxeFQX84UQPuGmPfHiWeGLyemi18dnncOzNRxGsVczhSCHF+YnMUVZkpm51S/1E7r2liEvcCoqvM+PLbXy5GjzylceHrS/tSC8t1FybAsU2H7jSNBhzpZHZwmFIUP1BXwZvR72JegcBq6KIE+mNcTT4X3HSqJxr++wJqfnuPNilct3dJw9LtkzE+jFc5Q9uHWSTpZ/fknag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 18:01:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 18:01:30 +0000
Date:   Wed, 18 Oct 2023 15:01:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231018180128.GA719006@nvidia.com>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-3-saeed@kernel.org>
 <2023101835-trapdoor-unicycle-788a@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101835-trapdoor-unicycle-788a@gregkh>
X-ClientProxiedBy: BL0PR0102CA0030.prod.exchangelabs.com
 (2603:10b6:207:18::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd76b85-5429-4e47-1531-08dbd0044190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CXiSr6tj4UIZ1QYUz/HRdH4HXmV+wUKXRHvBapLaIT5DwdFcK4q2p125Dqm9?=
 =?us-ascii?Q?Uhdy+mp2imtwK0ZOyREqlAqhIu6JH6gq064OnHZ3QsLKOSJIaUQ1RbmwXa38?=
 =?us-ascii?Q?vZYj5jLq2PYvGR+4PssCmUOulBLN6mh+UEiEnBBMfFCdHKapVx8/XO462DdO?=
 =?us-ascii?Q?KcWXkB5kcoFrESBjNgK8qL1PjtptqcYVinY+u99ukCqQvAUL5nRd445JbO6s?=
 =?us-ascii?Q?GXkSK3SVhdfulgWVlXKfSarMXLmNjDTU9RUWZY+pcBi167eBkMcaeMr70iNq?=
 =?us-ascii?Q?eiZaWcNnlMoQwZX1X11cgprISeFL/c0VZPlriV3uhu/If6V/cnJmN53ADowr?=
 =?us-ascii?Q?u/ABxo0LmGQbL8jCN3eVE+xVgfL0TODky1Wp+7gW30k7sfBpWRzDpO923rBX?=
 =?us-ascii?Q?RDkRTWM1fZ+h8S6XhWo2zM1sTWPEoioMmjFiTigQh5xjaAyputg2VVseXrvJ?=
 =?us-ascii?Q?5UeKECbOVWJJARD3/mxM1IQ+sgMBm+wjhY1vGQga0kBO2YAtqQtFFzdViT51?=
 =?us-ascii?Q?5TUut+jI9xf37iTSOLD3IIZqPmIBHhtDteimP7KuJwh3bcku4OVKvUGHueOx?=
 =?us-ascii?Q?3sGnuaIvo2IIoxXlZ3w7qL7EeTasFFlgQ8gYV3pS8KIKbrIlGx75CWIiH2Fl?=
 =?us-ascii?Q?ls9gg5H2gbaUn60B0jCUkTsh6uAiHQGkN7RxLlcbANl81MCi+UeD1R5ITYcp?=
 =?us-ascii?Q?QG2LNwr0x1JJhU016m+blvTH+q7Y68mP8hPhvtrM9LTBWEzv+d032rviRAmR?=
 =?us-ascii?Q?wOWOsLLBzOhoOw9i3hF8w2mMjx8GjrkiR27zXBH3U35pXNjX4M85p0xhfsyp?=
 =?us-ascii?Q?Vq5GGYcolPGCFy+rJy/hrrB5kem/G5Hr1A6e1GoSL0bpcZM7PbLSz71Kjg4d?=
 =?us-ascii?Q?vAwbPA8BUwn1CC4gxjEbiDjUtvxWbWrxp/i5xM7Zh3UQFoY1tV5Z5OZC+mRA?=
 =?us-ascii?Q?PWc2S60+9xCGD+tyX03o10oy78gCn7Ys2LQoFN9p3g7nIl4tTm2doc6mZAXZ?=
 =?us-ascii?Q?BMqi+JIbCMDqepUnpS1TPV7R5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(1076003)(26005)(6506007)(4326008)(8936002)(107886003)(2616005)(8676002)(316002)(5660300002)(41300700001)(2906002)(4744005)(478600001)(6486002)(54906003)(66556008)(66946007)(6916009)(66476007)(86362001)(38100700002)(36756003)(33656002)(6512007)(27376004)(42413004);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v3eEGx3icIHKBSPciZNr7U+uM6MuN05vdVRaszZ/AFje+nRQnWFDbxQ2cYvo?=
 =?us-ascii?Q?vNdByfwPXyEcnqOkHlfhYDwQnXuCWOgQfi04kCUf/WoYWMg76WMAIMcFDh9A?=
 =?us-ascii?Q?GX0vK27XjqmiEkGAAh9e/1QBxXY0JKB8+VSRSKAsW21KZ+K9Rgzty/x4kJQ+?=
 =?us-ascii?Q?3YobzPvXEQWF7A3NVcVyMjnOkSlbMIpFCqcFLZLExIioacat+TMJhoLZKryC?=
 =?us-ascii?Q?Pn++JE2v15VYd3/OCGGFL3sTd4VgIyMvpR3fd2qRFKQ8ll4ZwMP+M7E/sgJB?=
 =?us-ascii?Q?LFRB5Gp+hwxZmlNGxJFF317vthXFvhxHJDONQmcV8qSYxK/MQeVJxgIJujF/?=
 =?us-ascii?Q?3JZkRlci1uX13styT/g0s9Pww/YnxggruN3QUNCwcPRFK4h2/q5cfYBgj31O?=
 =?us-ascii?Q?Lb0CoguF7kceDl4cY8fHVw9xJDNxURmJMqqNml8llYdyDmXxb3DwV593TyYb?=
 =?us-ascii?Q?1s66SN7CvYOZsLZqvd5N+Prv6WByNDC3ucCUJXjIkXRg9ufDpn81i50RVIjw?=
 =?us-ascii?Q?UVSyaCDfnuNlxxiBWZnnsCEVDRVGW+DyGYUxpKimMeX/tHWajYAVZZ1bT0NI?=
 =?us-ascii?Q?G1N/VxqVOTJmTdnXSSWabngUIiPF3NaV663mKMiSlvteiFrAe6hgHTVtk5iH?=
 =?us-ascii?Q?smmhB4fDaN2QmACRt0dkiqIBVEHbPPem1cSZPlvdERGjgmwTZZfygPJZZImU?=
 =?us-ascii?Q?bg8uC6ZPUMesGAqMiL09jTZLXoP0fBgMz/2Xh+/TDzJ7RC0YJzutOPAQ5BTS?=
 =?us-ascii?Q?FejZdcg49IicqaiUG2FAWfAtdgJMQoJ4o+cP5ST1yYjOCTeTIHrPXLCb+c2t?=
 =?us-ascii?Q?yUGnL+aMiLwsu8CufMMr7HCu9kDjK21yP6Up/wKyZz9UnhQkucH+u3QIjJAK?=
 =?us-ascii?Q?jfZ845vqAydYvl6lw2XEFtG9c0mbuqKdjFFIPgHAu+Fa8vYg7yKUuoP34oYD?=
 =?us-ascii?Q?MXF66C4Nx5vLLmohY90LJ/lOQqlQHMDhbkauoerNBMVsfxpapokVm0uepEo4?=
 =?us-ascii?Q?qrvmS91+6dzbRG2Q1uF5rL+nlmHHTdwUsvbX1h1hJnUDN+hMHx86+TL8wviv?=
 =?us-ascii?Q?SCX9P/s6f1Bnw2+LLfgiPLnDxWy7BUC02M+GIsQM0fjyqUsG55ozvAtQoWHf?=
 =?us-ascii?Q?FiDm5uXUkJ/jUxuJog6cxD/MGc6iTmM/JFjSyg/pPVXBP94cWWVv0aWRDlTu?=
 =?us-ascii?Q?k7xj56+R/4tdZ7D9Tqt1Gno7cw0NwN1WnA0zKuk2Pkv4EEaWTVZwHKqI7Qf/?=
 =?us-ascii?Q?7DRKTIED5hbbqYt52heH5PF53SxX1/6OPpV0yDxheI1DCbO/OlWl+kFc96zD?=
 =?us-ascii?Q?JYk255/4srA2o4kQ8uOruabwWqRKnRBZ3elTYabpU8P1lInfUaEZnZESbvhO?=
 =?us-ascii?Q?s6RWlCYniMPkiMxTgCZkDtQBHHX+XfjrGtJ5ieF/8TwvInoOcRR6535QlEsd?=
 =?us-ascii?Q?DV7r0mFewpkfT8mOVHCZA2RBDBaD07kUSfbMnWKK18XBE/7ovOZh8cOdXpz0?=
 =?us-ascii?Q?MjtDZTWX0zU8IPBrgnrY71mUadU3+ARYNu2MRKKrc3DD8DDkkcCMkQ9Py7Az?=
 =?us-ascii?Q?+WpGHtmaIf2DWrGwgw6HOcFpnfKnB5lF7zuah+Q3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd76b85-5429-4e47-1531-08dbd0044190
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 18:01:30.3980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4l2oho+ng7iCwv6LALMvtzvhdQ5hFPx4qYBhOmEJGl9PngyuV+/sI8S8CkEctpeO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:30:00AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 18, 2023 at 01:19:38AM -0700, Saeed Mahameed wrote:
> > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> 
> For dual-licensed code, I need a LOT of documentation as to why this
> must be dual-licensed, AND a signed-off-by from your corporate lawyer
> agreeing to it so they convey an understanding of just how complex and
> messy this will get over time and what you are agreeing to do here.

Can you provide a brief or whitepaper discussing this complexity
please? This pushback is news to me, Mellanox and the RDMA ecosystem
has been doing this for over 15 years now. I would need something
substantive to have a conversation with our legal.

However, I believe we can get an exception approval for single license
MIT or BSD-3-Clause for this code.

Thanks,
Jason
