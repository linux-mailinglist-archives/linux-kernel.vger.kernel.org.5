Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BE68002A6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 05:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjLAErR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 23:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjLAErP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 23:47:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF12171F;
        Thu, 30 Nov 2023 20:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701406041; x=1732942041;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JDLRpKTSRrEw/g7XT/CM3vm9/sL/ruhWUtc67KOIm4o=;
  b=H0pxZp2XGb5rDmv114LfmKA6wDLtEhWTMINiPdwuKYnXFG2FtRSngsLX
   3hpRiU2SCATb/hT0DO+ekcbpj7ZvR8iGLgmjut0ZVg1yT7PJsm+4IIPLF
   DeM174WSvgpvkCP/DiexmWSwR+mnEIh8YKxbRSKh/PeygjdPMei4qUtoL
   4TXep1hdKvvq5vkA2pd58HBtd2NXGtMdzV73GR3ttXqPTAMCmExqnLj0/
   PBM3rSuzsaz7c9q4rcw+iSJYwnirT2Z4XLLUhoUxYgS4NQC1dsSP82WAs
   gUNCPLMk6vgax6LEjM5bUnETJpN0IYOrpayYB4WFLPCfSAQEIsy4Ydf9c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="424588073"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="424588073"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 20:47:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="769544904"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="769544904"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 20:47:20 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 20:47:19 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 20:47:19 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 20:47:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jn6w0UVJaJnzPuHc5kHBcqmzBcK+/2ar+32shsH+Yb1xookia2xcR8nyps688a2cKu9gsUmJ6p2I35R0mZsreppyw8O0LBdDv3dyYgXkyWzzu8K8RXYw1NvfXqxCmrUz/rFco0rW81EG2QIFVJQPJ7EntV6HDzZZBzdXV2kbpE0AJUs53Dv3tGqqONKeKfvrlfXT4PNv3OsWTOjNc9oWgEJQBwAXHFlxzi4y2tZx7LypO7MTSoLzvJLI7pZ4IB+bMkRgnegsHN27rKbQmviXuN3J7olASmOmcVFH/eQmiRYTVlOAo8uJjg5LuVZJ6FB2hoyXN8iUB61VMk6JQPasZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G28QBAQDR5G/axx/LLtF5bTs+UO5+sn32ryRGWavuu0=;
 b=RrsVRhQCVnwQ5a6Ctezy8MmubRacbQOyzAZ/FBpn+qNbMqIQa/SHCzVEr7yj8VVdzTzjwg87JxOpCLeuRMNHxAOtjVCsFVadYMy1nKWFBWS7bFW7XEYR5Gn+6wZHsHWYjhNQ83TPAp2irpkngRjX8+c+Oh6QmYsrFcYeD25heQL8RCQsugCmZrD0GkNDUnr9pQAkaqfXbKUCHj0h9VhA7sym6a6GyO482turSlONWGOOdhTPFa57QK1wgTk2+pqNw/AhuDvedNR/ti2hkj78dPgr8NQs5bsMy/IkxJfQWF1nk3fUei/8EFXF070o64pJ17ac67oZFzDClMyHYdYOjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MN2PR11MB4711.namprd11.prod.outlook.com (2603:10b6:208:24e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 04:47:12 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e%5]) with mapi id 15.20.7046.023; Fri, 1 Dec 2023
 04:47:12 +0000
Date:   Thu, 30 Nov 2023 20:47:06 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Ashok Raj <ashok_raj@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>, <jdelvare@suse.com>,
        <fenghua.yu@intel.com>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/3] hwmon: (coretemp) Introduce enum for attr index
Message-ID: <ZWllSmdI5pVGc0+3@a4bf019067fa.jf.intel.com>
References: <20231127131651.476795-1-rui.zhang@intel.com>
 <20231127131651.476795-2-rui.zhang@intel.com>
 <ZWkDQ5y3e4oPONni@araj-dh-work.jf.intel.com>
 <0646bcf5-fd41-41e5-b7b1-06b425973c86@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0646bcf5-fd41-41e5-b7b1-06b425973c86@roeck-us.net>
X-ClientProxiedBy: MW4PR04CA0315.namprd04.prod.outlook.com
 (2603:10b6:303:82::20) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|MN2PR11MB4711:EE_
X-MS-Office365-Filtering-Correlation-Id: 244c6694-f6ce-428a-32f4-08dbf2289537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVb24q1fmnLKB9bfpR4VNn4WlJXGXxZkSURAhZGIdvhASHAFxrpRBFtvh2wASvG9voD/ITIMvLRcxZZeweAd8CHWCPYjQ1m2E8Y2GPZmol5sUquVFqo7MtIiswv3UScEyJgRCgqyQSq6HybbGads45iyqktkAva7DtAWWQYnsNiP4+MvlPrR8zSiyZObR1QnB0tCF/C9JCbvGMTOcaGNAmtWLdieZHiXoq1066PJagBfpQX+IR22A9LrkPc7L3L3Lg6+dN0CV/rYAzzHTVaCzLZqIjGywN7JLMtISIvtY/l6LiMXYIUjnMYa8AGb9Uyra59HZWRfn+dmFOuDuF4J4mcYkSQGHi6ACmj3/qjfIBiQLhnBWk34OU2v4M38kAyp4fGvCUk32exjmBtI+0Uj/3anE9aohtROVNfU7EhcWYzQXjK+yi6vZJZbVURL3+cez7zmWkHzqXSvuy3ocNERHuCbMWNoADchWsPVFDxa0ibaL+mh2Ygk74WsqohsoNWmQ0/gu+S6FVetVRT8J0RygSFDyZpMCn5+4A8HD3GSjKDdoqcumNw848wgYO67GNv2EcjPHPnSKnn32QFvtmqQpmOZnyegb/N4lfNkRPhFhSQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(478600001)(66556008)(8936002)(6916009)(86362001)(8676002)(4326008)(54906003)(44832011)(6486002)(316002)(66476007)(66946007)(41300700001)(2906002)(5660300002)(82960400001)(38100700002)(6506007)(6512007)(53546011)(6666004)(83380400001)(26005)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m26JFOF/jWwsRNBSpeze8ySCb/NK1EHUUSi4xcpGlh0eDHF6S182lUyF8Q2a?=
 =?us-ascii?Q?od5ZW8l200t3xoZZ1HJKJhYQSWXMN8NekEAmRurqGTn1q9tnqj1fLpjKHwOA?=
 =?us-ascii?Q?5Uhr7ZrHckehpcDy5iV7DKQLptPdtqMyWaa724ejiGFz1El+6dEHnXNZ8Ywo?=
 =?us-ascii?Q?cPpMYvHtoRTbsSJ583MgFEqJqU0nEbaJB5RKNXFPKhO0V21jYZDr0oPMeqjl?=
 =?us-ascii?Q?ULqnLBr4BpVwEr1upyoiRqyxafd2JCopWcUYIk57cL3bqx8r3XEy/xB79qCn?=
 =?us-ascii?Q?FJ4kWMdsf8GZSV2UHMhETNd6KZxfyNQHOiHgjTyq4HOc52IhnABsdNGFaKKs?=
 =?us-ascii?Q?4tPbyBd1i+k6FLJLViTwb5aXeeTo7iNoi3llmDzGMhwqZSKVH1QzX1p0MuIF?=
 =?us-ascii?Q?DMu9lRoB7nhhtGALnkkhvxqUQ9rf5LCbMZYDlyMy++lQvaWbO4MK9e5tXZZ2?=
 =?us-ascii?Q?RvKsbC6J8Nro7fx32k1CxN8RPiCpNMtf5ozG18NpFu5AmpeAzifokoOuzNqe?=
 =?us-ascii?Q?xybv+9h2Y6LqfYh6whsyqhpCOI1W9WEEDiN9cU4M8LfNDdeC/iG0I06ttBQk?=
 =?us-ascii?Q?MEeS00H5xnBzjrnvj2s2xPTAP9xKFPe1zH7SrzKODEUlR0XWgCR3HObEqeSj?=
 =?us-ascii?Q?EWdcJFovVwp+eHX42HRZsJO0gPMbdul0hQqcEKTnsZ0+WIdphrQbynC/dIOB?=
 =?us-ascii?Q?TtzNgVdwip0XKLrBD6Bjfq6hH9gKKh5GhM0poF5HsFMLpS6M7oiCpT42MfS6?=
 =?us-ascii?Q?wXGn2rNuUg8PqTaA+SrwReQKrZDaQdFzgtlnr6gQuPtr4bCId/2A7U7J85Ex?=
 =?us-ascii?Q?T6lh7cyGEipznRDNMhi8MHEPymfO+IuUPrzKbpp/RQJFiR+45HzIXoQpZoPh?=
 =?us-ascii?Q?/+8UEWdBwgGmRGDepDjxrjQ4LQDJrp4APk3+JTN6seTFGvlqRgBdePGlOEMP?=
 =?us-ascii?Q?4P2KT/iTb6HSQ4shT5CqGgdbodXnX3OM+fA4O4mU8mTuAE9auE8BhL6KEhZb?=
 =?us-ascii?Q?lfwrhndpFkKLpCxBx0zaqZCGFuhvJG3bHaOIu5e+UsZ32xbuuXibjgWOIteA?=
 =?us-ascii?Q?edXfSLQnE+wsXmXsVr3zQsx1l/aQbIL9oG2VFW5L0hXrEYia8kfxKny2B+EL?=
 =?us-ascii?Q?oCv1q8nAFbRMa5/F5KBfiFEOvNzv0rl/IDPdvuJZ/dmX4cnD7TOIUebmFF7c?=
 =?us-ascii?Q?s1PDYPHz6GU3eUj2+ly7Q/x+wPQFwMpfLtp/KbQn4EGbfTvDvx4hbmz1GBFm?=
 =?us-ascii?Q?4a9/Q0n1clBxn/UZ8jw/tiRrvrLKIUOllaouFofbepFGLzEZvy5y/cdoxj9m?=
 =?us-ascii?Q?lHWMUKIFnZJ7WJl7clu9EgTA2BLA2MXdIkntdLb1avRCiZR25p3WXm8LW7CW?=
 =?us-ascii?Q?xbZZe09gqjE+SWtY7riZkPitpiwC4U5RIdRa4OcEHeJN7eRzEnHZAxsTT6Q7?=
 =?us-ascii?Q?JsciRAWp7cL7OBINNi620i+A7nn59sH8eDYGSguu+p2QPcD4GqrPITJG5n9W?=
 =?us-ascii?Q?TEXmmqeu4sZOyKIFuZiTQXTZ49HsHVLskcqXyLSb+/hXSq6xSb3+Wgq4RUda?=
 =?us-ascii?Q?HEYtvCxKMaOwGgCzq6ADEBnHXzDD69fa+JI1NZqO65oLeqzmMjDN2h5N236K?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 244c6694-f6ce-428a-32f4-08dbf2289537
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 04:47:12.0136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qD8J6WHz1Fsi4sOpu+CfbWztVQIYncCg03b9a56hpG/P6Mte7wSuyB/4nvfOlcOO46UdXpkvnr4H84+0jJMtxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4711
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 08:14:48PM -0800, Guenter Roeck wrote:
> On 11/30/23 13:51, Ashok Raj wrote:
> > On Mon, Nov 27, 2023 at 09:16:49PM +0800, Zhang Rui wrote:
> > > Introduce enum coretemp_attr_index to better describe the index of each
> > > sensor attribute and the maximum number of basic/possible attributes.
> > > 
> > > No functional change.
> > > 
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >   drivers/hwmon/coretemp.c | 12 ++++++++++--
> > >   1 file changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> > > index ba82d1e79c13..6053ed3761c2 100644
> > > --- a/drivers/hwmon/coretemp.c
> > > +++ b/drivers/hwmon/coretemp.c
> > > @@ -43,10 +43,18 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
> > >   #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
> > >   #define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
> > >   #define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
> > > -#define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
> > > -#define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
> > >   #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
> > > +enum coretemp_attr_index {
> > > +	ATTR_LABEL,
> > > +	ATTR_CRIT_ALARM,
> > > +	ATTR_TEMP,
> > > +	ATTR_TJMAX,
> > > +	ATTR_TTARGET,
> > > +	TOTAL_ATTRS,			/* Maximum no of possible attrs */
> > > +	MAX_CORE_ATTRS = ATTR_TJMAX + 1	/* Maximum no of basic attrs */
> > 
> > This seems odd. TOTAL_ATTRS being the last entry seems fine, but defining a
> > MAX_CORE_ATTR the way above sounds a bit hacky.
> > 
> 
> Complaining is easy. What do you suggest that would be better ?
> 
Fair enough.

How about 

ATTR_LABEL,
ATTR_CRIT_ALARM,
ATTR_TEMP,
ATTR_TJMAX,
MAX_CORE_ATTRS,		/* One more than TJMAX */
ATTR_TTARGET = MAX_CORE_ATTRS,
TOTAL_ATTRS

Each enum can be assigned any value, but this way they are just increasing
order. 


