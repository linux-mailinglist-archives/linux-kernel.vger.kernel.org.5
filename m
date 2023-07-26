Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BA2762FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjGZI2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjGZI1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:27:47 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2095.outbound.protection.outlook.com [40.107.237.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323D25FD8;
        Wed, 26 Jul 2023 01:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHnToHkcNV/tcKJfz+Jggyw0v9uqGkSl4OdVw9KyeLl/9PlyJ9ilPbGBhPVzBnGt1/hInKmf9gxzhwTpNDP+s4p41CaqkXhFqj4x4ITRd/NuJoKxnkjZvDjkQTExw4r6v/yObF6z6z1mpzIRNztxBhDVa/ON5K+lcYABGsmjfR4RStuknpxQmvpmbfl0wfhhy8FP/T++UevOyuyI44mR86qdzfwarNPS2Q4pz9FEg9wtld5IJWOeIHtqrh0EkQm87ursWyS0dnD4sft0bKo0VlDzA8RLz0U/jeMvUAhBp7vqNVBvKBzBLmxrkOQBAMlWYZGU6sjmHBRZNzG/MQ/4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUbcLr3YD8jMjxN0w5qK3WL0AfcH7Z30XgLS8V6k0lw=;
 b=HmDru1rj/SvYFGUmPKQbXc997q14PnfQZ6VET9NlBp6FK6m9iuugjaNzsx/bK5JSmZRtb3qKQ+GwgArVNOJYZZfbqkMGjcvzdhaCxP2z4Hv4NLnffRmk0/yWaG90f8vP5cGZegBS+Ny+VVZ7HNlIFq+Q3U62fw+LitRpbD0q5Fv/XWvyAJa9uEeaRj7Iu82RlY01vzFlmJLi5k0zMoMx8+JW5AoKa2t4Yg8LfYjUy0mdxKn1Gj6jBxFAINaOajmRFK72lX5eyVVb4H48g9hHacoJ4eVSaXZw/a/41e7/XwGv8+/tq+0OOK6v3gpF522FLkaYXzjlFJN5YMajwNVTsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUbcLr3YD8jMjxN0w5qK3WL0AfcH7Z30XgLS8V6k0lw=;
 b=wSlHTw18G41+LDgZNMxIRhfDHXelsoHmibleovC1TyXIkAZQeDMy8NJyxa5WMwcnEO/gAFhg9N7+PPddMXra/bn8v1BIbsZKyzEScpFdFfVyuDFqPlW+fcWRUz+RPp4EHteLFmZAjU2KjRv52/hg7qQWewO8TXWQJJKtLFDYSRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB3630.namprd13.prod.outlook.com (2603:10b6:208:1e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 08:17:21 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 08:17:20 +0000
Date:   Wed, 26 Jul 2023 10:17:13 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Atin Bainada <hi@atinb.me>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/3] net: dsa: tag_qca: return early if dev is
 not found
Message-ID: <ZMDWic7Wo/bJBnjG@corigine.com>
References: <20230724033058.16795-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724033058.16795-1-ansuelsmth@gmail.com>
X-ClientProxiedBy: AM0PR10CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::26) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB3630:EE_
X-MS-Office365-Filtering-Correlation-Id: a07d5ba4-9eb4-4321-9f62-08db8db0bbac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVTSJMpGFd3hdtFnGxqnR+TJqvsOk2K59qIUE0LGnjPpWDb7NpiMojZCuAJCFsUpc9CIFegurPAcwbUAhFfdqJqNMbvfNfckMmAs8ChcDnFjO4rh4WRYqexfNM5EJOYcpX+8hMaBT0ycQ2+H81qLL7rCd6+yV0+plDs1/Nz2OduNJUBHb5/pB7l8Jmvonz/Zj1OB51KkwBp0EXR5vnAiMGNQQN7x2w6hjA1wWHp4jmHdGqh64xNuMpibnqqZoBv8DmFWciiFgnQYGuVQj955outSyOrrUltGGn+C8y6150QGBtOi47BcDTgSZ0EqF7FQ0Xnoqdgq+2RP0f1SpIq99iujhvFw3cW5CPqn2xchohQx5ccpGXVYWcS/sWjGVDAXLMKuPuV/CcQiPvII7qACC7ETlehZK+a74LOoAMhTUeac0fXJ8RAMFMXr7iaZbotQn5eRkhcj+5roDVCO5g5WCZmmgBBOylqUZZ4NUPPqVCYapnavZNYHIauSnDe1RSl18MRpES4agkvsAkSbo3hYj1Hcatq+IrOrg5tBxxBOysSGZACsd9rbttw1k9+HPN6mtn8hKGhT7yDs2p2A2xe1Kav5GnYn0aCQRMZbUbI5Up8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39840400004)(366004)(346002)(376002)(136003)(451199021)(6666004)(6512007)(478600001)(54906003)(38100700002)(6486002)(5660300002)(41300700001)(8676002)(316002)(66946007)(66476007)(8936002)(66556008)(4326008)(6916009)(2616005)(186003)(6506007)(86362001)(44832011)(4744005)(7416002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9QFmQ99y3t98jG3vhxbRC9tjXZS/XkTxJX8aGJSOp7U/zegYpydJ62lkqdE5?=
 =?us-ascii?Q?AhsSNLfQTPvhqQ0spX17MAdz6hOVdfeJJia11eSVNsYllt81F0jLVnvc6R5J?=
 =?us-ascii?Q?q6SZgZeAyFZIcGPGK7M8IhpBTdkUN3FkIDgLW0yXg2mhsgbud5mMzdllixvi?=
 =?us-ascii?Q?Cf69rJqPQifgRDNIXuLHPu/sJmoocFTsJfd/Lr61iTgH3Wuvupd94TN3f3gL?=
 =?us-ascii?Q?MDV6b700B7ErlltjU1cXpv8M49rlKjqzdNy39m2znD3iMHzenB60iln0ntpH?=
 =?us-ascii?Q?pPIGJytgyXTVsPXxajpeam+TUkW1lZB++4hGEUq1jpK+M86V1ZvLHMW/IFoZ?=
 =?us-ascii?Q?vrx5jBgbf4YEarbGGy1qv6SxH78Qu+Fg5WxAiNenFvNakvtTvidfESMtuqBA?=
 =?us-ascii?Q?6n7Q5G/jr/yR6kxOXwkZoHfA9XpeDXsW3BgEN0zWIGr6FrDwuc1+h5K/Ljpa?=
 =?us-ascii?Q?ng/5rB1zIaimklWfpNdFIZSV1w1/Ez1LxEZgc4QC3/B9kYyC7Y7Z/kkedTAH?=
 =?us-ascii?Q?tRBF4LoMtjKMf8B5N3LBQlfLZp5gE+NOdEm2U3HBXxDjtpnsaszJ/XfRXsj4?=
 =?us-ascii?Q?cJZxtUMpEnW6OkmceuXzbCbgwdw4w2UYqkkQsXMJSbHxnaOV8DcYIR6ivyC+?=
 =?us-ascii?Q?WAWYX/QBI6Gh1/s0H2KpCRobsm1I4llNG7N3Amh2yELIdyUx+NsQMhOrbO+r?=
 =?us-ascii?Q?3qEMRqga7GBl/BssPbnHst2asItLx6hV1vq+cmdHBRdJ+GGH/IUHbonMiya+?=
 =?us-ascii?Q?41f4puHoA3+w/cXQfcnQqAyP28F2a2DyFIvaHrGX3a6ZBxZfimlyIzEAdPTy?=
 =?us-ascii?Q?hfEQU2zm9drXQkfHLw3Fw58JzQ8tNEVxfKtmmoLMN/Z7A3+AZH6uXQnmATSO?=
 =?us-ascii?Q?Ofu/drTR9BM3GFDTDWlVJuZp629Cb8X7pOS6fOOjJe680x2RN0dVRC2FfUIR?=
 =?us-ascii?Q?qQMa627rxUYNHwdahm3GDVmXL+Oe+j71mcxFRuvusFijVJd1VJpLWjClWKQx?=
 =?us-ascii?Q?FuHpLjfnNYqP8O+CognFpxaN0XOlszZ7bPpLwsxmfyDIcOn1Q/zPUTnFVtEK?=
 =?us-ascii?Q?vWBisxXtBSCOmemIfh/wBhwVuXtrds1W10Cq8R/IGKFY2sknppOcBkz6zZwZ?=
 =?us-ascii?Q?G/C1fRFMIPqqLddrzDKNYn2EFAUV16tKr0yZrlcoWL8yCiwTxk13Mxp1dl6r?=
 =?us-ascii?Q?RO4gaGd3HdPaIUttnEDCJnnjSkj17jiXBqNIB8vdHLrplufruTCLcNsUH4rp?=
 =?us-ascii?Q?pdfOfuMbgc2RiMBdZfU0ZzMe/Vn6Gxs1Kys0LjwnnIrC6yHZT/FpI+OGz7kn?=
 =?us-ascii?Q?kuxyS/xfukfhsaFBqTq+NuJiMrpmbjKoMBqvf9VTqj6WLIzjt8mjIHAKbU0x?=
 =?us-ascii?Q?CW1W7ZaAgoukhadLK51QrXBZRFnxJMrLNlSDs0CL5YksFdN5AZDLQ+Gf48qb?=
 =?us-ascii?Q?YW3HgNJUwobVEEMRgDMtMKtm4o2X9G1CiZDNeS80x9+AP5nCLBNYQ1SWg4zk?=
 =?us-ascii?Q?7GOeXtN7moe0cysXD0s0l5QXnfhBj3WnX3zn8b4DGMSLW4xMhpL9WH48ETWT?=
 =?us-ascii?Q?aETR3Hx0HIp5R5iSUIlXLfLB6jEeyfHLBphuNZYIAg0NVLQfqkFdNiPCP+fl?=
 =?us-ascii?Q?vxgPpzN7VCjMKT8NcHBxUsCjXJDRXQZoPkxUtaiTDFNx3aEIFQe68J/B87Rf?=
 =?us-ascii?Q?NEMyqw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07d5ba4-9eb4-4321-9f62-08db8db0bbac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 08:17:20.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8pR1Ag2d+OAnVcpFwQL8Shog9uF+N+1PwPjLYSrH9NjfV40ITqBw0toRkQPhEdpsA5yF6sB4nEKQvsSLxieRT2OgNkzRwOjCn/1jT82meU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3630
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:30:56AM +0200, Christian Marangi wrote:
> Currently checksum is recalculated and dsa tag stripped even if we later
> don't find the dev.
> 
> To improve code, exit early if we don't find the dev and skip additional
> operation on the skb since it will be freed anyway.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

