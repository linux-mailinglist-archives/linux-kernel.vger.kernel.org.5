Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEEC770DDE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 07:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjHEFMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 01:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEFMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 01:12:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27D44ED8;
        Fri,  4 Aug 2023 22:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691212325; x=1722748325;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ce1MLn6Uj4gkCbiQpQAkVH4qRsen04DezDmImuD+U+Y=;
  b=Yf4tJjTfGDyGbQb/EsR6JBjBB1TO4FGB5cEM1ok1EUWkRLS93CCcRDoG
   HPH4NBpfWDylQf9/7BcG43IHYgdNxst6J+h6GJ8JA0Y4DS7spQNez44xp
   bZss77hbtx39vaH0ylfmzn/lDxamhPWEZQ97fvk0WDGKlLKY9v/c/jMQu
   ohfm1m0Rw5Zn2+zP/dRzlwvMmPiLhxO3LEHs8tMISzX+YV6ihDaIwb/jw
   Uexer2YZWGhS6fI9OYcPmEwh2CZdD5dHdU2SqVNWIBV358vc4U+MyTonU
   aVufKqb4bF5FpqTFNdeSApXGJDezz/huh/n5AByWpc9+80LTioMeynfdG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="350600109"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="350600109"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 22:12:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="723905983"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="723905983"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 04 Aug 2023 22:12:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 22:12:04 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 22:12:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 22:12:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 22:12:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbNWVSUwrgK3uSE6rlo5T01lqr1qYEAHdUNavRQCqZVRll9+YWbUz4r3DtWIwf5lq98fr5t0kNVKK5oQ5kU5q2QE5Os94mR+rjWkO8ioj2UuAlD4xGjcclVeghop5l45y159oB77+eJEkml+qt6v4w1MC7Wyph75RuN635ea/YrI1gvWYNtcGv5bOZgWhb0nIHqugnf06EkT2rLuAwcRFBCc1TzbdD+X5lFN5reW/L4lW81osXH1l+NoZdcjC6oa2BGOUnPrO624jqa1WANfCStjM0kA7cq/XMbMAe8VazmerKrzOutkeAQNfNrI5yM1Juevg0RlcImGsOez+J4YVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ce1MLn6Uj4gkCbiQpQAkVH4qRsen04DezDmImuD+U+Y=;
 b=I8zG/WaeHC93VV4aAzIjPZ/Otmw01kL1V7TcV22jD2zlfCI0upioy02GcVO3Ocebo9OlVlztDXv/AB4aodDj83vOBQ291tVZuZfLf4EuqD+WAk2YWzdetwzykKMsuHxyl9PqQns6koQWyc+iiQwL/qVruyeWf1uVNVZYU+3i8joWyMaHWzgnFpYHlZf2EnInIPFKm0v3JyHPv1gLJ4W+7gsvkUEbIJ084EZVMvzztDcS/ALPn7fHapQtnHSBC9Tp1b0ESlYb1SG+JY7Q19pTQUGA2Kf+Abm2AAXR/j60pEuWsCY+PqW/Tj9xEppQGGt3x7oN1ObqxGn4XLiv6pi+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW6PR11MB8366.namprd11.prod.outlook.com (2603:10b6:303:24c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Sat, 5 Aug
 2023 05:11:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.046; Sat, 5 Aug 2023
 05:11:54 +0000
Date:   Fri, 4 Aug 2023 22:11:51 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Peter Gonda <pgonda@google.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dhowells@redhat.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, <peterz@infradead.org>,
        <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] keys: Introduce tsm keys
Message-ID: <64cdda1725a8e_2138e2947d@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com>
 <CAMkAt6ot9zyUL9Ub-qYq+d9v-6rTft4ea2mUxp3o1s3GVFq7nw@mail.gmail.com>
 <64c7f3df475d5_51ad02943f@dwillia2-xfh.jf.intel.com.notmuch>
 <CAMkAt6p9yEM7A5B9TyZsVTH=X=UQ3Z9wfYDg9etuc806mNdOiQ@mail.gmail.com>
 <64c80077d7144_51ad02941@dwillia2-xfh.jf.intel.com.notmuch>
 <CAMkAt6pPCJ0YsWaL692heDCUYjF9KCBq3PNiPK2LyBd=wD0+ig@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMkAt6pPCJ0YsWaL692heDCUYjF9KCBq3PNiPK2LyBd=wD0+ig@mail.gmail.com>
X-ClientProxiedBy: MW4PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:303:16d::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW6PR11MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e6b581-b249-4d2e-3245-08db95727bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2V8Sxqp1aldfA9D5rdFmO3r71x7mf5yOXvKd0P45wgGAENrV2JNDWGyN0IJNSmmm9CXfnsENscTI9jAUdejfWpjCvaVS2IQLdtlNl4T+339pKq6KI97sLTw3Nb0OZmqE9YVD7+9oCpCNrJ9Kx5lC+7qsxXAtE9qQWn6KY3wYVPkghBhq2wdIS4bPMEpPIkSDOgnvBYztugwcuXsCf/yQx2aL5fKboOJlmBH5OBO8XInY2e31i7ftQWdB08840I3yRH2Th7tL+2DA4jlkKGbYNokDLO1I/Dww58CD8GZZeu8sCUysw55P97h1/tO4a5AO6/tjoOgMYEd0BK3CITLy+/4zy8w5VrtEBR8jMehHLrho+NrK+A2KYg0JkeLilX3Hi4GLSTAFBqeSx3dVFqCnODzwDUo7A8FifHxT2GFLUmiZnvGq8mDecw9f+EOhdSkeGJ9LtBnlTVM227lQFHlpou+BrpN/hyiwk71y6wT/nxfqxrktvstVFeX2SjsHT94nOri+T6PWl/kNtZNaLPYpu26XM4+tcRq3Ef44CGurQ7eDy6+SttZH6YGuGBgENen
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(39860400002)(376002)(346002)(1800799003)(186006)(451199021)(38100700002)(2906002)(4744005)(6486002)(478600001)(6506007)(4326008)(41300700001)(66946007)(82960400001)(66556008)(26005)(66476007)(316002)(9686003)(6512007)(110136005)(5660300002)(8936002)(54906003)(7416002)(6666004)(8676002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wdtnB+v4+YampE5Iuzqwwy1d6xH/knWwEd20/RovRjQ4ALwt3NthkPSVJtD3?=
 =?us-ascii?Q?xeIIp2wwRpiW/IllhWt0YQuPKL12A57FFcUaVosvQUhoemQjRPZ48rAeUNY2?=
 =?us-ascii?Q?UBMvBG8DxiuYiQdoPqraF1k3dgogMqMb+/qvDWe2SdRZG8imLd1A5GcFuKOe?=
 =?us-ascii?Q?yKprGGVF0L5m0vS5Qw5v0dCcuX92dI8WA4ZfC49Tg5kVrIw//v1ayy1g31pk?=
 =?us-ascii?Q?iJuWZy6cC890onkDmMbJQc8cVlxbdN0YC6r9nbczAldyuRESxUXJ5326P63P?=
 =?us-ascii?Q?6BrmX+bFju8U1hZVe6SSgswW8L/YQJg5Zvi+cFSeO6Wx274Ih6qniwkKwwQv?=
 =?us-ascii?Q?DjsNnYZHGLNtqYGxXChlhcLaW8Q7bbiQfRyONFREMVY3LBei0fj/W3BTQRou?=
 =?us-ascii?Q?F3tJrLjMyFn+gQoq1CCfq+e9c7DfwhETZr+4PJF9mDHql+97lcRwQueycIi9?=
 =?us-ascii?Q?PCya0u1GEUsbq3gR1I34LYdmEw6g5805PGjFACyFGTC57eh9RMxScInUacSJ?=
 =?us-ascii?Q?NAYZrwS4EQglfM+eFeOa7Dab7OCf/pBfvgDUz3gozk15Tx3sLNvN5ALCXp0C?=
 =?us-ascii?Q?mlf3p6VoKXvhQej0V9DIu0ZzH8mEtogQ2WFmKDppHZ9hkfQjUtgYcs51UOmc?=
 =?us-ascii?Q?j8ZAJviS7mzMeM//cFkeQ0RKDttvowd3A9GlNoIahYibEZm4stwat83o5rjG?=
 =?us-ascii?Q?dHkklZx6BW6l5glbXCibgVlpIMWby9dNN8U9THD4oieiowl14XX2E24gCjIR?=
 =?us-ascii?Q?jgOFBox5lQaveUXfoNAoS8NRA53jIcgxGTHA317v5GPRktIZHp/vpvgunvKu?=
 =?us-ascii?Q?sVlKexN5GJ9NoTsKz7Xn4Upo48acgA7be3YIcfjOiqlqHQzkplGoi/ObGvlU?=
 =?us-ascii?Q?0jf/1mMEcxAUY1KT03+xgm3WaDI1hzR9OsLKHANDDTplAGHdGVTJ24zPmeHK?=
 =?us-ascii?Q?tcrdu9anz9ka3l+vkJcOlpRvMEFzvUgmBFNIYynY/5TPNassZEgeVDTMYVkO?=
 =?us-ascii?Q?7DsmBiSFWiMkMj/JoB427brVWnQ3k/W8jcVT1jSc00wXPVvd3/XmgVGJiwu/?=
 =?us-ascii?Q?enKLbNvbECBRw9rC9EfdFbEyRS8KVevzMDmq/F+4J4lc5001Rsvgb5o1waxm?=
 =?us-ascii?Q?VIw+d1IEygcyY66LfBKkgR2d6ngRou8U7DBY3Bq2M1DZ2ZXcEfRQLpy4DYzj?=
 =?us-ascii?Q?xCqjrLnlrVL3dO66RUNm2tbX4CI6bmH0ty9cusnxiTKHvq04mqJAANwPINsX?=
 =?us-ascii?Q?LK9zv/EwzJqqjON5efJWoide54/jtp1HsfOV0sEfCCpcH9YzVdNeIa6exzA1?=
 =?us-ascii?Q?CjPwRxh5F4NXTkW3iPCHGqMSKJm9xvpeeU6PN2CSWBlSOpz7c/APatpaEPho?=
 =?us-ascii?Q?bf7lqQRlxznM5+jJVDUwr9YA7dd6G/kHgPfU9VLAcQI0ycytKYWrbGGKzxP9?=
 =?us-ascii?Q?Q22KbOzssEIzp9bIn1rNbBHJHaVhOygCtRzWXXegZhRA3oDoDpdniJ6gmvUg?=
 =?us-ascii?Q?0Zq75/81/WuqibFl4hErtCtpUkPc/m+7Z7BCSHj1ahATB0N1W/E0GH//m5Wb?=
 =?us-ascii?Q?XY5GarcEzFyuUeJcfjx+SfWl1xSubq5DO7n6ikliziLkw3OQ+vlKFpPRtQ5z?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e6b581-b249-4d2e-3245-08db95727bf3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2023 05:11:54.2899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2q8l5GKMDo14RjxbjeA/t7Y4qfnON4NrzYmgufXkEBePNTwuBvVnfJoSv1hCAiMcSum21mL56BZIwbasrev4ek3jwwcjcAxATa7R+FfRmtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8366
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Gonda wrote:
[..]
> OK the overhead is negligible. But why is this any better?

I need to answer this directly. This is better because vendorA is forced
to collaborate with vendorB about instantiation options. No more "stick
new feature that might be duplicative in a siloed driver in
drivers/virt/coco/$vendor". This is better for the kernel.

Once standardization materialized this is already ahead of the game
providing a front end to instantiate that common format. This interface
choice forces ongoing community collaboration on how options are
presented. It takes a position that all existing options that sevguest
already exports are in scope and provides a place to have a discussion
about how and when to add more options. This is better for
collaboration.
