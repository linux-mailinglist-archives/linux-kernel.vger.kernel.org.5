Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B727D774006
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjHHQ60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbjHHQ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:57:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B78949FE;
        Tue,  8 Aug 2023 08:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691509332; x=1723045332;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s1sAXoFZzoxtmSPekAhyWblGTofBgXGp9jnA9JVIFvQ=;
  b=MNZUF7Ulz3AmaSWk/WaqNrJBvi7yJX0Ib2it4lDjW8eO2q5UP60fPtQ9
   35LW6mmhV1LYvx4SKZxiqUFY4pCwi6cGmz3Hk+RvmDen7WDwfNv4UZYTK
   uJW2uYWlOiCkxTpsU48Pe5rDIMKL86NsvijEOQco8W7hgjO9AfHZ+sGMw
   +Ke6B9VAGOu/snCx3HFh1+50805VpAjjgm2OgQQTh9Dl6Ngw2ivKyPp/Y
   7DFUw4635Ve7Ln5/bxiVHJp6OCIc+7s6G0rTmmN0Ke6VzQWdqSh69U97N
   AHtp/ANiTzyeRxuJb4DiPfjL+bdyXvBzbb5tiqAYDVIk/b2eBzabouQOA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457121804"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="457121804"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 23:56:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="760793102"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="760793102"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 07 Aug 2023 23:56:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 23:56:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 23:56:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 23:56:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 23:56:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZzkJliYIMfEhXCBg3CS3BPi8MIgMcxo9bncwhoUK5XtS3qNMB9SVH0NQiaCf6vlE5o9Kg79oxRjzbr5rbM1jCeSM1HpdEoP8C56ZGoLc/hwn+oxWZXfyRRNaN0fw+mFBRyqV3m1oMzMslnSo9xcemj3TquoTytbPI2rSSxdXq/bTKzZAtuY/kBZHqfL/g0r+y5KELiICdcvoETA0cns0HPmwidQU/BnEb6fDSZ//xXbyiEvV35xs4lLFM3XdaJrjC0IVfrzMKiSXJePqZhQlmJvg52dLUaP7yHMvzHO+5ixEiFa3v0DAXMZHcBemfl3JsOVXOsiwmIma9dEXZNcvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhDCGwnluKIsqVeyGU12q6+3l+qcgS43YUkWTZLkUu4=;
 b=j2ViAmc/xh4s3EPx7a6uU45mN+k2U8CCXaOS1c6z54Tr3479fQx8GbM/1uZSDoA6610ECDK9IXt8Q9EHyRtUZxhm6gfOALbCvOyUnrPvqvLbO0CZ51Oo2SZJykAbp2uc+xNsTzrf64GALhxxOwohY7hwU1WhBJiKrlnHc5Pi3JGudh3PCTW5Dxdp0a5QuHYbt+jnt27LQ1Ao3533mxA+IfEoTeVSPS7gWkpqcb4EdZW19d83p0jt6ah7xi8O5pf3EtUHeQaep800WFO6QTK+95VR+FW4h8vt17CHBfttFMqeOqkfbHYQu5qxuzK7DhglVtSwk2eU0cuXZh6m/th/sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6404.namprd11.prod.outlook.com (2603:10b6:510:1f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 06:56:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 06:56:46 +0000
Date:   Mon, 7 Aug 2023 23:56:43 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Rapoport <rppt@kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>, <x86@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 0/2] CXL: Apply SRAT defined PXM to entire CFMWS window
Message-ID: <64d1e72b52f54_5ea6e294f3@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1689018477.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1689018477.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0275.namprd04.prod.outlook.com
 (2603:10b6:303:89::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: 471181a6-b0f4-4e9c-b959-08db97dca1be
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h1c7iBDUAtTNXLKO0y/5KxeYrclxfjLG7OnKzQSeeR20ljBOoCjrCCIhHke51QJoqD25n7jgDG6I1TMp9IgQHiQjrpj8dRMWPnNNUx3S4jJfkZqhEkV8DmNUM/TKXqpp/0DIWfhT+VQef9Yd8q76qW/SO858/t22M3o8ookSk2ceBPDgoWJ1clXHx3YnYbyFXqvsBmdDWHDs+k5+Dqajagor37oqIfo7FDmAdgSh10vyZcCGhuidS2iY9vpD2pQJVxUb0IlGYiv8FFZ2AkAmFWlQ3R4Ueq/nMzTe6siMi7IoAMyMibtzX/2FsV5kFBUrIr7h3W0W07QIaZgUFCf80uiN3npvMkafbOqTfZsICFhUor2FA6sllZuFNVQyPdb8Tu1VXv6AOkoMMjXqShjRRhMuepMRv2jm8V2LCQltfAJn79kFYmvx/j2oOBVjkv2rYoQlUGPti/OEavAOSs9n0rv8QX4HCgM2Gr99g9VzUH7c2O5uFk4eJ2MErK5TM9vq41L0PXIfcIezpzhPWJ6B0VOE8OOtC5l2og8UjwlC8cx8s5tBJpfbScCdBWSPo8dpmshnLtysiY8EzsEod8ITy4boylNtt2AW3vDqRZorzQzlTAYowTo7P5hxrxqkYKAElrVgZ9VCLiXiv14DYpcV2H4FOZNpXOdZcGRGr14BRlU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(346002)(396003)(366004)(186006)(1800799003)(90011799007)(90021799007)(451199021)(82960400001)(921005)(478600001)(9686003)(38100700002)(86362001)(110136005)(4326008)(66946007)(66556008)(66476007)(316002)(6512007)(966005)(6666004)(6506007)(6486002)(26005)(41300700001)(4744005)(2906002)(7416002)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EzMNHPRDMTdveZoQxJ/6X2kat+MSTGBYHVGooTVq1236MsmZAyIMnH2JhqQt?=
 =?us-ascii?Q?ISSjqnlo3ZXQiPtJCCIF1oQMx2z0QJezH4XlAAr1W8QkcBuqsrWr2JNiwt2x?=
 =?us-ascii?Q?qavjSUtCmcnGn4drwEuM5FF6UJvrM7c5oEilq8hOQtF6dCIEQobCqeT2QTkP?=
 =?us-ascii?Q?dehpwqNENyl6jnzo1JFzzv8ajdxVtalVA2xkJWzTgm8qpUw8lHvUPFj3leEi?=
 =?us-ascii?Q?WSPOR5eJJ6fQbghNThi+7C99Rd8DuFDF2GOZvV87fYhpRkK0P3OnDolCWwyS?=
 =?us-ascii?Q?mT2fav5xt0QWXstYEOxNWq/8X41FOPLWO3JQPj8BWNMGYM2RLOtXVYmURnmH?=
 =?us-ascii?Q?UxJLBWt0InpsyhQJMeUUfDeHqNE/E/USktceec2tQUFdX1EnrJ782SQccE/4?=
 =?us-ascii?Q?vkv8WRCuvE+OY1QESpCtuOO5lYgXZd7iYPq0ZwH3JqQ2fWF8r/aHkuscqk9J?=
 =?us-ascii?Q?4MbD1zYaxo6ZzvPW6x9tUXeaNbUi6C3oGZ3iQM87CKyXFBGYPKNF5jmDdfxb?=
 =?us-ascii?Q?QetOZ+50L0yoENdOEru0f4gz7XfysCxu0xGmaIfiJ5zAtpNWYmpwvKhdFFXh?=
 =?us-ascii?Q?PrgKS2oqt5iREJUlA+zuJKS+fKQRjnk6nYSbx0RRF3+BEFLaBOG2f+okgYxW?=
 =?us-ascii?Q?YCab0A0SA15F3EUjQZGxZsGktvY+8B2U8svKUwUrvnpBWXWkATbVlW4RSr+l?=
 =?us-ascii?Q?ak/CixelxM2Os8XLB4+2hltAK2ZA6dgTkUEGQEz8tCqyAMYo/Lmza7Vpc0jO?=
 =?us-ascii?Q?qyi7pg3b/RNIXwb014i2sFSnfCzrKLZTEZsvOE9ncepPNPx8LMw2q/3jef3R?=
 =?us-ascii?Q?8B8n7Uw7smVMfO6oQ5uJG7dlCeUjOPjPXWnR4qMIX5o1ciNzpknxo2W7LFCs?=
 =?us-ascii?Q?zRBENghk66sbNIMpkQpgnvupyRPAHI1YOwlXfqMQVmza8yUwOPibH6Ff6bfl?=
 =?us-ascii?Q?Ml1JcfANmHyZjozy1HAHCtPQz15Y+MJ3yZaYv/pk0Jxm5TqdxyPsEACWg3Lp?=
 =?us-ascii?Q?XludNUIw0pYFskNSp0ibqVvfb9Kgt8R7ZcppEC4OAcHDSAR2O4SnW8WzFLRo?=
 =?us-ascii?Q?wjPLOKfLPUyKktdkA4TggAzZPPkH7M22Qur3VqaftgVMvQrf+r/6C4UQnQh6?=
 =?us-ascii?Q?N0Pl/ojeO64bTlndJp3HzxIi1a5MevRcxbgOELYDCXGkcS7T0vj7LflhLUYK?=
 =?us-ascii?Q?Qbn9tfR7wK8Lv8ziugAXfRLSm63UdQRfcuD9Gt7aQx1DdzbHkSH37hGSK7tD?=
 =?us-ascii?Q?9QbAz1vUprdOcG2KKWK1UPn2zndJ4zLo96yj0KYBEkmz97zrG5YV7EPr0rhm?=
 =?us-ascii?Q?Wi1hR1wDq/58p8WzD23PBUTcY8XDl27HAsLttsUlXtAYfnxnBXWfLOU6pcCI?=
 =?us-ascii?Q?sSBDoiqeZHLOTitM3s9ixzTiEcj1QbsCCMK7YZLGnbGwU9kTSR2OmxBDEa6N?=
 =?us-ascii?Q?38G/QxBFtNU/pmFejhqdC56scFvYox2bXozGTVtY5gQR1wJp7HU4j1wrWp9J?=
 =?us-ascii?Q?HbIcJaQW3u0X+Dc9/remNWT6GoHzBVXjK6sv1QN0cs2XLqT7+zJ+1a6eIjMK?=
 =?us-ascii?Q?AxSbqlSCj+fht8Qg9OQbJQZDMUUIESnJq2ZMqub7L2P3DvrQF11ewxApRe8F?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 471181a6-b0f4-4e9c-b959-08db97dca1be
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 06:56:46.6567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GA/HosfEt4eYoIQyWk47s9ttLuIpdQkBAzwqi6aXaOxcfMmPSB+VH6fr+Fl11Vfho+ZKpeSxyIBkGfemjlX9KayZvS7sW0OTo115V96r9yA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6404
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

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> 
> Changes in v4:
> - Remove useless export of numa_fill_memblks()  (Dan)
> - Rebase on latest tip tree

This thread has gone quiet. Any concerns from x86/mm folks if I take
this through the CXL tree with an x86 ack? Or anything else I can help
out with on this one?

> 
> v3: https://lore.kernel.org/linux-cxl/cover.1687645837.git.alison.schofield@intel.com/
> 
> ----
> 
> Cover Letter:
> 
> The CXL subsystem requires the creation of NUMA nodes for CFMWS
> Windows[1] not described in the SRAT. The existing implementation
> only addresses windows that the SRAT describes completely or not
> at all. This work addresses the case of partially described CFMWS
> Windows by extending proximity domains in a portion of a CFMWS
> window to the entire window.
[..]
