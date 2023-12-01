Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90BD801482
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379534AbjLAUdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjLAUdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:33:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C2CF1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701462824; x=1732998824;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Xu7CMeC3dGnPr3uRIa05L5Ub9oLDMVrOc3CiW/40r54=;
  b=nzI3LL04EsJ1mf5fWYBSgP3vdkuf9Q4sETB0S1oFyYPBmacZ+bXe+JR0
   w4IATle4zzFWt1X2o3HoNWyw351lvuFiX0xHUyLh3qEUOXuQjbIjCqB2u
   sJkk2b7UgQ6EsypUe/JOUyTxHGwJnB4Cab7rPdnyo6SshiJfaxSFctx7b
   fCcD3Pu6EuXFOC526MrQ2SV6tTQKdErDcdr7A3XXWJwOqE/EP9sDAL1Aj
   9sbNl7JfklEWNroOTQs377xQrnfBgpDQeor0Iu5xvt3dBw6JikiWBMDku
   ueWV5kWNnRXcdb5gtBym0ySHA/h65PDvc1IluJLZqnZD+7ovzKmFWbpBU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="396351960"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="396351960"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 12:33:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="804182208"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="804182208"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 12:33:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 12:33:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 12:33:42 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 12:33:42 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 12:33:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCWhALzHghvVvhqv2Hp2EAKsFpP1LuRrdwP6cdpYa3w7FzRw2UylYkoQoloiTMc2Tjd0dUPW7KBnWMLEX2m3vm8kvqV/6HSks/1Jz7Sya/vhjSMWyVbsrvCSKRrp6nek41fufppgVpByncvjVknU0yUrgME1VFyyFlAj6MJYl/3UX7mNl5eleAaNSAtrSGH4iaDQwai8/JcyD6Zyr1KEbwcdZSnFqVxuQN+gRzCeqZ4V9HKcOf2tQ6hat8nY8Y6x0xAZMEoS4TOCQzVdM499tLTKNGRWnY2A/tyTjbKxI+djkL/FEZe/u65VVUGtzQGZ5PZJgbEqLmuncMO+k9EKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF5W1ISf2rUQvX1AmILTRm+JRHre2gFOn5pt325FsP0=;
 b=lgS/kyOjn51Bpmve3DzBXTTHLFNB0uYhuDCll2QabFeaUbj0QdGn27bzt9oeCu/FKX2VZhmpjGzlVQOfuIqGk2QCCo/1vdWSwnpI8hIBrl8qW/sYxhAgFPeWWu+dRPIH4j7Y9rq65JPkv2dx/G2hT6uLI5aVHvE8vmaXD2D5MyP4kkha7ueBvtwY8Hl2AcPJGeMccDYkg9J2p/qm4HfUyuUH1lR1aFwsW4woUlQLuOZ4lIws42kRH+n5DOCeT1HbhGdag84zaeGQlQCYLuWXzzb9mqZRKRP6G6dkegsG0jYCdScV7YUlhzVXPXO2CiJCEtbmVN56ysD5lpe9nLOpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SJ0PR11MB5583.namprd11.prod.outlook.com (2603:10b6:a03:3bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 20:33:40 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e%5]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 20:33:40 +0000
Date:   Fri, 1 Dec 2023 12:33:34 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/2] x86/microcode: Rework early revisions reporting
Message-ID: <ZWpDHgNjhQKLodF6@a4bf019067fa.jf.intel.com>
References: <20231115210212.9981-1-bp@alien8.de>
 <20231115210212.9981-3-bp@alien8.de>
 <ZWjVt5dNRjbcvlzR@a4bf019067fa.jf.intel.com>
 <20231201163928.GCZWoMQNAAQSA9U12D@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231201163928.GCZWoMQNAAQSA9U12D@fat_crate.local>
X-ClientProxiedBy: MW2PR16CA0042.namprd16.prod.outlook.com
 (2603:10b6:907:1::19) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SJ0PR11MB5583:EE_
X-MS-Office365-Filtering-Correlation-Id: c3233a5b-8e82-435e-deef-08dbf2accd9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0W3h7zUO+u0C/mW2HHWw9jAgMTsSIxednojRbU0gLjM2WOjAK9iIgOVEC/eRv5tPX3TSL9KcqZLu8KsHY2E6dBHmURbqAlwMpZYuu7Gp534b9nnUHZn5ZvrVSxGdLZLrUFXMYu9FuEHPQpf7LRiQw10L2Vf76ZUYZIv93n1J+90hS2gnbPZuvq0Uk+sucHfN9WRVJmw5SGwJAWUhAjUtXqtm5ugBrCDNlQgJGg4b4AmRGJwgR4HPXS6fcNTDV4Gd7auCiHRxeHe2TFSax6zt73+gVbJPryjGVRK0VfSz9rWhzjfw8eXz/Wgi2AAq869b1MPJWToef2ow+8qmkXG5z43ryWTIt5HxUjZdBK0q4J2ybNL/RwHPbOO6Fbs72+S0a4mHwwIIwmY3jhahUNWgf3ph+lmsXB3Ej0LfzC7JdqLyI44bX6og+ICqsRdC7pRW/TfFwch7mu3qIzhwi1R09uHx/phB59lUkN7ewKd1N/Rn7exqNW5mpsBjqMbAB575xrcuR8uYZXx/hhT0vlLo1LWaUt5oTp6hEL3dX/itO/ckdTup7QobUo0BkVXjJ1hg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(107886003)(82960400001)(86362001)(38100700002)(83380400001)(44832011)(6506007)(5660300002)(6666004)(316002)(6512007)(66556008)(54906003)(66946007)(478600001)(66476007)(4326008)(8676002)(8936002)(6916009)(41300700001)(2906002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ILyGLq8N8nYVE+Ah/ebQo57goLyBQLko3kskYq4t+BMKn97dxqfdijEnGXFv?=
 =?us-ascii?Q?jLnom3xdY3dKMPHRLXnmjUxniT93syPOtbbjHKVJIeYaZPhZVA+vEQbkQWM6?=
 =?us-ascii?Q?spBCaxa+WOYvujHnsFn5XyB48ZWYuuten9sXqIMO7pthZscFACEzYM5TqYSn?=
 =?us-ascii?Q?PlkUaSkcvZdKHjAozToH/ijEJrlChfxalrhgz9c/qr0iv86emecMtP/B3mE8?=
 =?us-ascii?Q?Vf2HJbycsiSkIBLM3Adi9xhZIwpX3h8bVoMeAZxRC+J1AVoVge/8hPClBZKB?=
 =?us-ascii?Q?rfQ63EWyZ20y4q+hPDz/0f1pbf+UdkXUbcRyyCB8NM0wqZEpNcYBAfQmbY3b?=
 =?us-ascii?Q?xByjipsrkoZ1GS2J/uVafxp3zJl3i4tU3U5sl7QAY90Crb63fIZqAB2JrOXo?=
 =?us-ascii?Q?xf8g50915UniBzGuDo9x7MmJlCFxz73+1ROjCHqz9QSbwQbHQn+UeZgVN8qB?=
 =?us-ascii?Q?aW3gzarGBH0Zn8OL1A4bubNiLLomJaEeoNXTKqAl8zw8YY53ftYArYBDA+Uq?=
 =?us-ascii?Q?O16cfvhGv5mRIAG1F0GzDAA8kjApa8ytkjEthNNbAzUWS68q/KAWV90MKrRy?=
 =?us-ascii?Q?VinpTQRbhuHN9BZwoFKSP6Wjhm58VfqOZv+Jx1TUETEj/z6r2KH0vcLxuv9B?=
 =?us-ascii?Q?ClxIk7vzYKVPFVQyh/NsmxCQY5yNt32iPRXgfYMNrMkTEGyVsVEjH0hDNp8+?=
 =?us-ascii?Q?nvsW2gAvd3EHRoXpHyNh+dkIh4d4nuGGYACKksDHFadHCLK58OSRAygePDKk?=
 =?us-ascii?Q?bAcyo6L9KQa3ApPKKQ8rDR2Aj6xvIZ8wsv9VVE2L911NMs9OIxKpkqZQGv/4?=
 =?us-ascii?Q?ai6W7rWcZd0DOJO/BHimtsL29xzxQWYpfGRIH+DYpCBEjE4MGR8D7vypNk7q?=
 =?us-ascii?Q?zVZE2oZd7RdpAuwEnohCH3y7TJF7NIx9TO7KLuiNf/sd0WUwe0hu5RwjcyrD?=
 =?us-ascii?Q?YVYEnddtAZ0vbq+NTGywntk7NHxyHNKCPQN20qoOfLt/UVinwHUZOzTs/AtR?=
 =?us-ascii?Q?zW/9cGD9gTN75ENx3dFMqkms05yq9AjWSwKDWdZ/uSESb0W40eD+O7PzBoCb?=
 =?us-ascii?Q?r718LeSyNhomWg+pziUX4QadK3LLaiG7ygNIgkMB71Ea/l1YwGKo9cJG3UE7?=
 =?us-ascii?Q?t/ff8xRp5AKbTRBqUFdsdGtu2ZbyR0S2XrwjOQeqxLG/kXoDIrSF7tfoBGq2?=
 =?us-ascii?Q?xUM61d+WF2wHdAGsXHK2LjgtpjwmPgwCJIYHRuQdj85tv8jp+2m0uJ1UFnIE?=
 =?us-ascii?Q?k91leTaCFVCwXDHsUj1HBjHAkmIIgE+3DBb/r6D8DfkLpQZG2Q8AQxyx+FfM?=
 =?us-ascii?Q?JPwxOza7Ph7uiXJR37SYPACOT5clDKlg0iyQkw7g3fcOGnm4UKe0MVOwg807?=
 =?us-ascii?Q?qe5hniDKJY53g+ntHCADSCTf44scQEQerv+WEFQZq34ej1rB9Yz2Q1gHxDse?=
 =?us-ascii?Q?uO/AXLcz5iHX+/bjvbvo4zULzF2uIp3t12BFh7mx0l5xWcVYOnYmsVoWd4JA?=
 =?us-ascii?Q?mwiOxKnOV9accUEDab43HHcWIqi1F4TDjBwzlkwrIiakvtDmsSWH81KNc+QB?=
 =?us-ascii?Q?30/Eq20e+ZocEb7A66RZsq5Xd09c9HwELSLRVyqi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3233a5b-8e82-435e-deef-08dbf2accd9a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 20:33:40.4439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OJ86Feyw5CRQ7wSo0DUq7Ond4sqTv2cWoDBzXWGHgwg7qkIGkuzihF+gcBY8NZdnq2XABpZZIrTpNCvTtPpVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5583
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 05:39:28PM +0100, Borislav Petkov wrote:
> On Thu, Nov 30, 2023 at 10:34:31AM -0800, Ashok Raj wrote:
> > new_rev is always assigned even if there was no microcode to apply.
> 
> That is wrong.
> 
> In my defence, I don't have an Intel machine which has up-to-date
> microcode in the BIOS and the blob has the same microcode revision. All
> my Intel test boxes do update microcode.
> 
> > - On AMD, the ucode is loaded even if the current revision matches what is
> >   being loaded.
> 
> From the commit message of the patch you're replying to:
> 
> "What is also missing on the AMD side - something which people have
> requested before - is showing the microcode revision the CPU had
> *before* the early update."
> 
> The logic is, we want to dump before-after everytime there was
> a successful early upload.
> 
> > Currently, it's displayed as below:
> > 
> > [  113.395868] microcode: Current revision: 0x21000170
> > [  113.404244] microcode: Updated early from: 0x21000170
> 
> There's something else weird going on though. I would expect that that
> machine should not update microcode if it cannot find newer. Maybe the
> scan_microcode() logic is a bit weird still.
> 
> Please run this debug + fix patch and send me full dmesg from that
> machine.
> 

I'll get a dmesg shortly once i get my test system back.

What I meant was 

void __init load_ucode_intel_bsp(struct early_load_data *ed)
{
        struct ucode_cpu_info uci;

        ed->old_rev = intel_get_microcode_revision();

        uci.mc = get_microcode_blob(&uci, false);
        if (uci.mc && apply_microcode_early(&uci) == UCODE_UPDATED)
                ucode_patch_va = UCODE_BSP_LOADED;

        ed->new_rev = uci.cpu_sig.rev;
}

ed->new_rev is always assigned, just not for the UCODE_UPDATED case. Hence
even if we had no microcode to update ed->new_rev ends up being non-zero.

