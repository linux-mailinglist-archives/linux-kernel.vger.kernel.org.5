Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFBE7D567A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343614AbjJXPcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjJXPcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:32:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94839BD;
        Tue, 24 Oct 2023 08:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dteVYKMsvU/J82l/GqG/AfOFUhNFhHpMSUfxa4TnLqTHvQ7RXadwBnMbC/JVx2g4PD/bw2+4F+dKuLTaFeDv5/0+YvL5c2JfDI6uRpoDrbduosl+VQR/nBjHp1ZA+fKbVIdsUMwUvIgjPL4S98/43By6i344J1OQ+ALTM802gtu9vbEL1Le75MZtvlG8RvoOr/jvdXlSKpMes1/fiL0YwNuNTkHPC7cBp5ddR/3YLHvEucfkuTnRLIFXQ7xJYM0L9ZlX9YS/vB9yZFB1IXEGKK+bdiKkkxVgBX2VHzxzNTQPXZhZrWGFb/wB4/ryJH11exW10P/hVab3/hxhoRax9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6h00Ob2PUOSWjxErhOQ3PQ1xyZsvFsyVQzZ2j4RwvY=;
 b=MRWNICrTfSOkhmkFZV9tr4tAD8Svn6biJ76bT3msfmiKmWPge6UuGRHAR7cUHOI81bkkOzyK7DzIkITwhDAFmPvmnJsfopWvEKYQixIeLxKIe6qS38ulQUf+wPKjXm6mO/ttuqjUiz7xSIi6SdOREbeTNf/31buM65RJWk3Ds6qLBG6CmNQo38kcSUPHJ7brQ+J+K4X7qZ4sAH2qXXNloUJK3F41n9/dnN/N/GYZpo4byJslHRG23sqGPjxcJD8K/JeVDbxO8VI/8HI9uE2ODraWTawXE9bIbOw2j5rcyAKGrsh6/WXtV91mRexT06KcNz1yGHvJ/J300ZQkeradmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6h00Ob2PUOSWjxErhOQ3PQ1xyZsvFsyVQzZ2j4RwvY=;
 b=SCsx1jn8dAnTUJs8Kp3FPg7tBBdmfwVMfEZbDAQNA5Pj1bBOYqJKkeCbDypkzbi36ZpQFbGTK63hGCEaqOGcS4x7OeUQ1TQfkxqAOsyUTDhulEYia5tfKjqeHxQ+nMxjqmQHLmSzrCaqx2HKP/yd+XwYy7RccuAfnDfcY4I9yTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB5181.namprd17.prod.outlook.com (2603:10b6:510:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 24 Oct
 2023 15:32:28 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6933.014; Tue, 24 Oct 2023
 15:32:28 +0000
Date:   Tue, 24 Oct 2023 11:32:58 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        akpm@linux-foundation.org, sthanneeru@micron.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [RFC PATCH v2 0/3] mm: mempolicy: Multi-tier weighted
 interleaving
Message-ID: <ZTfjqoEZXQWs/rxV@memverge.com>
References: <20231009204259.875232-1-gregory.price@memverge.com>
 <87o7gzm22n.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZS3jQRnX4VIdyTL5@memverge.com>
 <87pm1cwcz5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZS33ClT00KsHKsXQ@memverge.com>
 <87edhrunvp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZS9HSIrblel39qrt@memverge.com>
 <87fs25g6w3.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZTEud5K5T+dRQMiM@memverge.com>
 <87ttqidr7v.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttqidr7v.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BYAPR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::39) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: 06be4987-3344-46b2-db52-08dbd4a66e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLFa1t1dcxXQzi7zefMuStbZBXR3yIH3zkdRFz36FmY1+tPVBnu8doEozC9kPu5uIaSF+9pfUHmXUA1vw7NtGlKgR9f/Hon94Blkd57Gw8FRO4rS0XrahVHuxTHcIA795Iy13gmBUx7e3kVTwiPA5AWWsSdkHqBBo4hRm0djhiwYacCRd4lguWECNHirYWhggxRQPVNN7PPmVK6yNWbP0mpe8mDXYlAuCMo2BcvinKz84H/qC9Vu9R+xfavDoKPT4lyrZ3PERD5/0PR2zwnAWfEwlE+mRwqfnAUhpm6EVzpzPKwvPPygcjKZINiV5YzxvlxDCeREoFup9xPgF/kZ8vYHLC/o9DYa/iNegGV5xzuGntJcjWolD5R19AvGLBuPvLhPs4EI+mpNneFXtZ79D8GqbPkPwOxcpYcktd0Rc1N4amR+1Z81mSIwcDfA+lWyy8QiECkPkQwuCqEZx+u5hZXfBUSSAs8kWncOrwxg2eIXAmOzWlA0nEplxONADn0Bv+puA8Ry+SawpdAAyRAJy1DZlEslo8UNpr9sMNVIjHBoctDUzQ/nc/mqYvK4dakUugfmi9IF+LUMx4zJpPOFhXG/IG7DI7jdXPLyiSyg/qJKRIZcUh+/qWRS5DCJRuF0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(366004)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(36756003)(2616005)(26005)(6512007)(6506007)(38100700002)(6666004)(316002)(66556008)(86362001)(6916009)(66946007)(54906003)(66476007)(6486002)(478600001)(83380400001)(41300700001)(4326008)(44832011)(8936002)(8676002)(7416002)(4744005)(2906002)(5660300002)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1g2k5BSSl6bxBZjgTaXyC2d6h81NhLnzsoyVPeTHQ/5Qi5QC0vKSJCg8yz7W?=
 =?us-ascii?Q?P1Rb/iIEUb5hxgL+OP0hTJqLemPhA1fWFo5zvheO7jUFHJ62tm9K6k90u2sY?=
 =?us-ascii?Q?u6fe5M8v3BFLEnfbCzdtbt9/Ce9bUZFGEAdc61lHp5LavVpRG4jbt7ZnYxQj?=
 =?us-ascii?Q?N+WL22VOUJKMOnnn0TRb7apHvIdchcTVnt8KE55rofrx7A8K5sXzzIgOX2yX?=
 =?us-ascii?Q?R0aWqbqpNYx7hXV/uHJOOzPjnUBUXfIcsxZQEJMXufONU74bqik/GsjLumBC?=
 =?us-ascii?Q?H1NqWiNI/bhtwnDz2TA6gDPcGG5tXiBFQ2qGlKO1lgBFI4eBd3uo5M2TXjIQ?=
 =?us-ascii?Q?L6/VxVLDCkOEQvN/SNhUQFLtiKBew2Lvc8DmDhOWndKUECMbzYguL2BCT+Xx?=
 =?us-ascii?Q?HVULyDZPrP6GTGif8PW7RQj/pT1g4HiONjkMx1UIUPfONO/zEPEXGHkU/rU2?=
 =?us-ascii?Q?yGhNOn8XWLhFk1VhKDDWY8SBpj86edn4FHaO/2WRlHwYVLRcBNYNcJTzVRgo?=
 =?us-ascii?Q?cfDwRkwvQZxPeCBU62JP5+DKx7D6ExC5VVDnN1raK02BTZscMcot0waPR4D1?=
 =?us-ascii?Q?xwqmyt2jjlvwQ7wG80TeXCmBS2NwnyC0ttYWmBpxAgARLmmiRtoC/L0U8T4b?=
 =?us-ascii?Q?bBaPwRvFobmHKdmjHw7BITgtV7H8QOysxn/88FxywalmhkpCLJnkIhgPVSVr?=
 =?us-ascii?Q?Pll2eyiH2KQ+yASqGco4wk7qqN5uJg6bEVeQGNTMOqOS4nFZ+AgQI1UyZylk?=
 =?us-ascii?Q?xNz/Q7KT5/I2evDU9slxJKQGE/1HarNROpEfqPnF7xRlay1fMPNhzfHuZKfy?=
 =?us-ascii?Q?1kwYN7ovDLGjOnRQpJ0S9x+XqqZ+4kU9mq++zGUkXD/weopwq4oM4Q3anFGY?=
 =?us-ascii?Q?ZLNdLSOozw/j9AS/YXS6tay/EKxIsJXt83goBoqf1NKWTKGfUQUwq4sggtLj?=
 =?us-ascii?Q?gHaJoyWbSnml3ox2dL3lu1Lfojm9p3U4WK3fEfKjmKfxfKMu1e3FDmQFzZpJ?=
 =?us-ascii?Q?0faGvgeNIdxvpLD4idCk3CitEPEwHKPdt0bHzpcQp/kIGkt9/9+9xAc3itV4?=
 =?us-ascii?Q?bDSN2+OAAeXppykXqCSWZvKtzXyS9MxKnI0AZFB/R6SLrHXh3Etuepa+Y8SY?=
 =?us-ascii?Q?x6djPCt+IXd1DTz3/asru5swWXrnJ9R7KFoR4UQ+ZSaLJPTAqC3P6JUpNSOV?=
 =?us-ascii?Q?FNB7HFdplrITJT9kkMC21peyafTM+UjXqDB8P+8sCBuE3uvCD9AlJiUJMXZY?=
 =?us-ascii?Q?yqDXWGcS5pj23IO0Fai0D5r0VspfLscmvgpSwn7Xa7yd0eZyTtZL3IX0odIE?=
 =?us-ascii?Q?Cy5c1WvWjFMqwp1IZ/HYaoXqyk0SsjViGqjVRWkPXJVu/csXPmUs4piaoaTI?=
 =?us-ascii?Q?nz9zTISupk0ttIfvX/9Wg8dxoGsJN+W2yS9ysJwPiEnO9hjjBDQRdZb4OFXk?=
 =?us-ascii?Q?egl4JdJP39vHPgj/pLmsyjzogNefBzZwOk6QhFTxYccCOrmA8Yx9AQhTq7RW?=
 =?us-ascii?Q?/kFJ42Opzs8GX8gqeWp/e/N7f8CQtwMbptrr7LbXpqbWXpxil9Le/Qeb/ydl?=
 =?us-ascii?Q?Xs05K1vzWsfAGSEZxTthUtqjSeaSLvwghmjJoTuAvmSJ74ytN0by27dGZxvw?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06be4987-3344-46b2-db52-08dbd4a66e06
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 15:32:28.0989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZYNe/50niXack6VmQz50IV3YGbucBBScIKXplL3WlMfO95/VN5cZxTo+Umw29ILsGAFn++qemkYFJexr8sSq9NsIp9V9uh/Il8Z443/JSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 10:09:56AM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> > Depends.  if a user explicitly launches with `numactl --cpunodebind=0`
> > then yes, you can force a task (and all its children) to run on node0.
> 
> IIUC, in your example, the `numactl` command line will be
> 
>   numactl --cpunodebind=0 --weighted-interleave=0,1,2,3
> 
> That is, the CPU is restricted to node 0, while memory is distributed to
> all nodes.  This doesn't sound like reasonable for me.
> 

It being reasonable isn't really relevant. You can do this today with
normal interleave:

numactl --cpunodebind=0 --interleave=0,1,2,3

The only difference between this method and that is the application of
weights.  Doesn't seem reasonable to lock users out of doing it.

> 
> IMHO, we should keep thing as simple as possible, only add complexity if
> necessary.
>

Not allowing it is more complicated than allowing it.
