Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D24762E39
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjGZHn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjGZHnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:43:33 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2127.outbound.protection.outlook.com [40.107.100.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8B530C1;
        Wed, 26 Jul 2023 00:39:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjIPL8FQtsQ5YW9vj7ZKe+AHolSnxK4fNVMCqU2tMTBbnePEtX8wA2cmVrFmigBxBQFGSJU4ystx9WsXORVsQFgCPg43LHPDM8w5fEH4YTXIvq5ruOls3ILFXgmvpYrwjKXBt8BoTlASyAg7qU3KJA6qAGLbpU2fD7Eo0vdRMAGdbGnfBcft+SkIQ9LlXM5Nyc77n78XTmgb3aiEfQ97EweD6CnRNkFs6ulzExvYHJEzBWVCVEv8TGcAW2g31Q4+BjfJpo3zVFlkS6C5ICaQNL7fvyIjhJ/hRzB1KbbAvJUcogGLf+H+JZS+oi6SWPK2R0Pyh3XlnxIAkSRNqfWKBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRKIWP04fAU6kkdY0uf/pBMBMPw31uVUdltmhrtL5pc=;
 b=jkIlRbMvGo/qkYGJ+I6HDUugFyqN16WrlxECgnHAtSFOjtDTqTlEJ5hdWn/USMN5fwp9E3n12a0axVqHsQPGrUyuFvNjLjguUG9eHMO5ulbAAGQBhTWpuoAxBw+3gLROKAm8ixl7mKrJqNsT0gZrXoq6gnwjsnhrYRDj5KriexYlhF8LJ5nV4CBW7F8SDwzMvJnAuRR+etn7+vTOc3K/lW6/lHuIkW560agNmsiYtA6JSnEJhC/ohTsBTZQay/fY13kFE0vrFiw64IxnFv4RbJ4JdY1+u2cguUOgZhuZZP9nvxHwuyaf4/MDmKRv4pNnqbLA2fwleMGN+PmD4oZNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRKIWP04fAU6kkdY0uf/pBMBMPw31uVUdltmhrtL5pc=;
 b=o5F0tFxMuI/6+WP4nRG/TJJoTsQc+hgm6I8LMO+Dv8hCinGE5v6tmX9XqoF+e7SGh1LjIu7DMrBd8kgTWlfM9rR1hbsJzI5BAwbn2wkpP9vV07uFQgDD/NInMrM1RN1VRtpBRW9f5PdoyNBxILYmtsAvfmxd2bMCCdKmZJOzec4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB6540.namprd13.prod.outlook.com (2603:10b6:510:2fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 07:39:00 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 07:39:00 +0000
Date:   Wed, 26 Jul 2023 09:38:52 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: Re: [PATCH net-next] flow_dissector: Add IPSEC dissectors
Message-ID: <ZMDNjD46BvZ5zp5I@corigine.com>
References: <20230725032451.505189-1-rkannoth@marvell.com>
 <ZMAnk5Kl3qp17fko@corigine.com>
 <MWHPR1801MB19180BF179A96933AC4E0070D300A@MWHPR1801MB1918.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR1801MB19180BF179A96933AC4E0070D300A@MWHPR1801MB1918.namprd18.prod.outlook.com>
X-ClientProxiedBy: AM8P251CA0020.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::25) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e076e9-b637-45db-56af-08db8dab606c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ksW3fxRSoYbSsple67hfhwLpJi0VdQFxpcijtWihgK2/MKR7o78fz0wY7xZI7Xsq3P9bm7pK4CxiJouaGDBx/6yaSEsJHS/7/K7yYwGGhY6XHBBFSK/QAKKaCdkoal2XLRqK4U4IKtFf4htTZcIVvxbS02LuMV6stRa96j5ad5lRYL1cxcXOjdArAZ7gu0QDZisyB9bewrZhu2bJuOmzqryJ+ATOUDeLYG7uFw3QdxxDFx1YBUxuxCxKaKJzDH/7oxbF45nhA2VFhLRrqJsTXy1/PswSTHvGTBvvnQ2Z/1mx+taJ+lzSn1UTp/ar8nZawhTbd2lmVwB8wqkLy7DbQVtklGb1kPTkvgJHrEMIfRhE3yLP0Sg1QS3/9WbjHbsKdBr3Rbs2j1+HjetOBuaQfCdvPdv8F5nH2OsRhx9q6U88Q67r76cNPjDeSk0XThe0n1ZYN4qloLxuYhRR4yAlACKae4b9o4kTzoZKazZfiVTLuAn0Yyc4F6m+8Iz8p/uTtZH2gj1AqwR1h/TjmTAIq77ZXg1kjeEhmP0j/vfFWnv5dR+oQ7ooM+iOZNoqDI1ZyAkFHsoj5d4SQYxTSmjn3lNfb+pg+szylmcslu+1xyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(366004)(376002)(136003)(346002)(396003)(451199021)(36756003)(7416002)(44832011)(86362001)(2906002)(83380400001)(53546011)(186003)(6506007)(38100700002)(966005)(6512007)(6486002)(6666004)(4326008)(66556008)(6916009)(316002)(66476007)(2616005)(8936002)(5660300002)(66946007)(41300700001)(478600001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vjEmSnjfG8Bb9NcSxrnhnQ2GRHM51a/re6PONnzY1ZWD5/rIl6DW184y7zx8?=
 =?us-ascii?Q?Sj1QI+dbItmQqSUkWmJdviH/d3jDi6KbEIqAcAvvJMP9rtqQV34yUZLlG41K?=
 =?us-ascii?Q?+CJluH22s3Qk6JCEovWxQYXur/NC2WinJXTpF2QuYVvdkOgQKXFfcg7PZwo5?=
 =?us-ascii?Q?bDkovoxNbx3tVZG0mShgo8YLwpOVbdw4U7qtttEfd2b0mfFljw8UBcIfHYdl?=
 =?us-ascii?Q?o3zIT0Qp+01d0CZsqw623s6hBfL0wgOsBSnF1qeeVoEs5DSPLykK5hNC0P+v?=
 =?us-ascii?Q?jVL6ngoJWMCFCYg56Qt3dMA4vErnIYSpy+Kxk3D8yTaVTSl8GQsmvjoztdZp?=
 =?us-ascii?Q?g+qqD83Da5USMPOFgjYc4uKOe2GEBOhAeL9Xef2Rv632E4ZgmMAMvo0dd8cz?=
 =?us-ascii?Q?4AO4kgOtvckmzWFM1H95Ap085K1lOByOqTgm0GSSojTAyZ8kmwl8uBKpdAj3?=
 =?us-ascii?Q?hhSjLlP2t5O1wSJ9iWe9939/dlIpnc1FtO1jWp8l8NrM5swJtZxMyG8E2cud?=
 =?us-ascii?Q?flF9WI+orC002jGNVkdfzpLxlsT/HVs3o1jHORwi+z2ImM+iT8kDxMKf1m/u?=
 =?us-ascii?Q?ynoYfhKA6tW5H6AedPQQrJKluINFUvnUpuqU7ewIuyTV2IsFptLrjwpFnaqR?=
 =?us-ascii?Q?yo7ZYSbTeWUU4E7C08Cb3yZFR08zHHIae1iycuduS2sZVcpAGVkUbQv6TIv0?=
 =?us-ascii?Q?MKzEqp2RTfVwokpfmZv7jpPacwyJvPF9yGUgs2dDBjeQXcjgE/6Y+wlad9OM?=
 =?us-ascii?Q?wqSAsq5P5yFH50KGJAGsak1v6YYUgyq118AYHg1JHtBO2AzVr/xv2idkAad0?=
 =?us-ascii?Q?gBK0n67Sc75sK7fRXF5sHDHC3s6/M7Y69ezDSEc/mt7XtGFNs4mIIiaENtuT?=
 =?us-ascii?Q?CSkqBoyZ8YiEJB60saUiXj2nlVirwNLYs6qzm/yLeqB/hii3pJnygj1rwX/h?=
 =?us-ascii?Q?PDROdTg6H89GYC6GMmT71ZasisFzzur+pkabl/5kRMtNcSNwieGeTvl7+4yK?=
 =?us-ascii?Q?4JmBW4QwgfBlv2ubPqI1WYYkAvHU0roGp9NJF4URZoB62LBx7D9e2FpeBP1D?=
 =?us-ascii?Q?qw9HJPB8RLgw/DBBMh91ViR/3d1RSkAwQE1lkLz1SzXX0gApLFnDDG0QLJeV?=
 =?us-ascii?Q?VMNzRVefDF0nurMNQWvsGOZ7keX1NaxUXAdrpMn+KSEWjeF4afaLDmmgkpCn?=
 =?us-ascii?Q?YG0hNXzXY3qpfAO/rmSlUljLwrE4CnilL+4rJA7YfhDO3A5SFkZ9+/wu1A+r?=
 =?us-ascii?Q?WFJCxr/yn7NHv+ZhXKZGKC3jvMo8Pta1bqsSR/2YPcApfrVwmmehEXnx2ssu?=
 =?us-ascii?Q?X47fyjO2YMm79ARd1QaeegAOLve+cGzU0oiMVUqnNHv4ph3P5D1Db/7n5Vkh?=
 =?us-ascii?Q?eFwruHdNBCoeoTFoujjsWCWfK8AqEOLOG9TUZ/GAH2vAfPT+4eU8dJJDoVra?=
 =?us-ascii?Q?4EHw6+bsHoP02taPnh6NUvB/jN1AwzBU76XxZUfixdomYXG3/eHY/RPzsRMM?=
 =?us-ascii?Q?XRr7liHCQpKej9plToNTkLr231rTsM9uKC422H1Y5GfKX4jqq9s7Dew1voc8?=
 =?us-ascii?Q?zrGwdeaBKw6cB2Sa0j/Sg73LJsVt8JNzoQ027gLd4IZt/CAv0s4Xaks5m1S8?=
 =?us-ascii?Q?0vUTKa+MQSXWGTthk+MJ0YB+csgVpADfo8CvfqmBo5Ad7x2J+KvVM4ib2ZTi?=
 =?us-ascii?Q?IJMlMQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e076e9-b637-45db-56af-08db8dab606c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 07:39:00.1286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +S9ZfQ+vIwCAzsCKvTxoMYPRL9xwwebX5/KSOplW6LsxfBgXfaB64tlOcrkeW+CQU2c6HoardlUlg39ODuZ3T1W3n2RGvx2PU77hkT1ZUqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6540
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 06:34:34AM +0000, Ratheesh Kannoth wrote:
> > From: Simon Horman <simon.horman@corigine.com>
> > Sent: Wednesday, July 26, 2023 1:21 AM
> > Subject: [EXT] Re: [PATCH net-next] flow_dissector: Add IPSEC dissectors
> 
> 
> > >  	FLOW_DISSECTOR_KEY_NUM_OF_VLANS, /* struct
> > flow_dissector_key_num_of_vlans */
> > >  	FLOW_DISSECTOR_KEY_PPPOE, /* struct flow_dissector_key_pppoe
> > */
> > >  	FLOW_DISSECTOR_KEY_L2TPV3, /* struct flow_dissector_key_l2tpv3
> > */
> > > +	FLOW_DISSECTOR_KEY_IPSEC, /* struct flow_dissector_key_ipsec */
> > >  	FLOW_DISSECTOR_KEY_CFM, /* struct flow_dissector_key_cfm */
> > >
> > >  	FLOW_DISSECTOR_KEY_MAX,
> > 
> > ...
> > 
> > Hi Ratheesh,
> > 
> > With this change, this enum now has 33 values, excluding
> > FLOW_DISSECTOR_KEY_MAX.  I.e the range of values is from 0 to 32.
> > 
> > But dissector_uses_key() looks like this:
> > 
> > 
> > static inline bool dissector_uses_key(const struct flow_dissector
> > *flow_dissector,
> >                                       enum flow_dissector_key_id key_id) {
> >         return flow_dissector->used_keys & (1 << key_id); }
> > 
> > And the type of the used_keys field of struct flow_dissector is unsigned int, a
> > 32bit entity.
> > 
> > So an overflow will now occur if key_id is FLOW_DISSECTOR_KEY_CFM.
> > 
> > This is flagged by Sparse.
> > 

Hi Ratheesh,

> Thank you !
> 1)  How did you run sparse to detect this error. When I ran  below command, it did not throw this error/warning ?
>        make  C=2 net/core/ V=s

I ran:

	make C=2 net/core/flow_dissector.o

FWIIW, I also saw the warning using make  C=2 net/core/ V=s


>       sparse version is 0.6.4

I am using sparse git commit ce1a6720f69e, because at one point that
was the newest revision at a time the packaged version I had wasn't working
for me, and that was the latest commit at the time.

       https://git.kernel.org/pub/scm/devel/sparse/sparse.git/commit/ce1a6720f69e

> 2)   Is it okay to change  variable type of  "used_keys"  from "unsigned int" to "unsigned long long" to accommodate this.
>        This variable is used at lot of places in the code.

I might go for u64.
But yes, I suspect making the variable wider is a viable solution.

Given that it is widely used it would be good to inspect
how it is used to make sure this change makes sense.

I would make this change a separate patch if it is more than one line.

Also, while you are there, can you fix the spelling mistake in
the comment on the 'used_keys' line in struct flow_dissector ?
It's the same line that needs to be changed to change the type of 'used_keys'.

