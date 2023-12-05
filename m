Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EE1805E7E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345300AbjLETUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLETUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:20:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FEB135;
        Tue,  5 Dec 2023 11:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701804036; x=1733340036;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=GNtW/jX/5jQxHCXSMJ0ptkGHJfYlDzfz4eeLoG30rK8=;
  b=OHYAXcmMdnNuuM7W14gDUqJVNDP7nedHiUtb303cdH9Ajjm/VRgEZteR
   WEzdlO50qIHbZZk09biYqGW8Ipi2e1xE1CyxNr52zi1u/gcsCz7QcObLC
   8SOHqlWEeLTSo/0S+1fFOCtB4NkcCCW6GwV67I0thKa+xo1EaEf0in0gG
   saf2xTiYqS2LvSPaE+VyX6gF0x2QTVM9kEeauC8WWESu7Z0r7QGvYBtOW
   u5xP2Oza98JV1qpbw2wmIZlbi+xpnyKSTH7CcbubDS4f3tvzX8g98HJOA
   UaYu/vHtoO4sVuBYwxkNqfjbyrmA6y6Rdh7aVH7kxZaYwtUShSuMg6R8S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="392812014"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="392812014"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 11:20:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="837058867"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="837058867"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 11:20:35 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 11:20:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 11:20:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 11:20:35 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 11:20:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFPbOn2x9/W5p5c2NZtMR7YpCUG3FElOqnOr0/Sm1Rm8oEdw2wMhSIpFIO3ksxOlMAFtTUFa1QErOlxcXKyw43UwPLoLLsdXPBI0tmRI4NDquHC0Wd8fd4n00hYnO2hJ1DaajE2qn0MlcewxbctdPU6Fhg1PeONQ2H1iBVwFH5vw7cchBzitID7kXkChvExNKhnJMFHazcVw2NSLUAHeASCAS5ccFoQbYShtW7tAxMM+DHowJ1KZ49ule84drcoO5auHaTbVKrr1lQEnBU3u4eJf664jieffW4Ku7+eHixupazDRCzq7BXBtHbkRZ2WD4mVOrZA62cSf8apKde24ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yddesP6tHL9ySgZtiE+2eu+ug3rfyl06NiYXx2gdWaI=;
 b=DvcYqkulxEW6KNzCbW0j0hKwCaWdWMIgyclLOWxT6JQIRMDNuZZP/nSDrPuTC3/syGPMKCuDW0WVNaRE8+yAL/nZ2bgv+XmcGbdG8jlSi9WJYrK38dk+4SpGgBdPOBrmlHqJfKRnz8G1rVgrsv04375xtIav6+KyQeUUoBaolQHUfuyn0ldmhzDxE/flWyHfbVCUKPBw6JEWyM08xZLeLtqnxsOTo483qpUuRqNaIdlyt9bRKeNXJo3Ad8y4DV8xMqn8hvlfcyZVZ8Xytcxj06nDT3+e0QrT4oLTvQNw8nvsk/BRCqnKxXqHP2KoBfjQfJItdPwRtJ1iEl/6LjanDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 19:20:27 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 19:20:27 +0000
Date:   Tue, 5 Dec 2023 11:20:24 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "ashok_raj@linux.intel.com" <ashok_raj@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/3] hwmon: (coretemp) Introduce enum for attr index
Message-ID: <ZW93+OhBNRB+T/EM@a4bf019067fa.jf.intel.com>
References: <20231127131651.476795-1-rui.zhang@intel.com>
 <20231127131651.476795-2-rui.zhang@intel.com>
 <ZWkDQ5y3e4oPONni@araj-dh-work.jf.intel.com>
 <0646bcf5-fd41-41e5-b7b1-06b425973c86@roeck-us.net>
 <ZWllSmdI5pVGc0+3@a4bf019067fa.jf.intel.com>
 <a67fdc5ff2401519b99479c1b487b16c707ce0da.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a67fdc5ff2401519b99479c1b487b16c707ce0da.camel@intel.com>
X-ClientProxiedBy: SJ0PR13CA0185.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::10) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DS0PR11MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: ba9c68b6-9a96-4080-9d53-08dbf5c73d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GR/Vq3tpEjaoX0K/C7SrlyyjbhfLpQHvxDjhs//2LH6wW5fRvaOGaCqjV4NYoiEinotSqu2LWtEy3GhtM79DFwHZjRC/zXmEq5WjjkqGOWeruxj1Y+Qj5MsZ9jG7sN3dWRnVoe3w5VE719jiIimaOrdRz34ATMrBOkd6xGubzd2GFAjSowug3jOTWt8uafsYs1kkQGNQCV4k7HgBPKV/ENqMrn+sh2DiKMH93UNxItPkG7hCjPLuOxHttUSyoPCWpRefWXFjwwzT4CGIrmvRKc1HhjREe0XvAu4pO7BPTCycKWxOq924bqHo48/wbdKaArxaMsL7DGpkiti3LhQN9uvW3ITbsx3o0RUakkwfJnP46LzlWk6hIPzMNQ/LVcSgKCQqw4+EI5QZ7NJFh3Awe+MT48MUAzC8lsGmyxVYkb143Ym0zwGwnzOh3hpRdQsmAlYYopnzMCAy99Ck4EbptrVPuvLuQlcwDiCGkPthy9EpXRHHLSAMjMizqT06VLzhw06s81BP9sBCA3N4HxWORMOxj7iUomOvQFXUMWKPPybn0aRYS7VgYFMmjqBDuc2a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(44832011)(82960400001)(2906002)(5660300002)(4744005)(86362001)(41300700001)(6506007)(478600001)(6486002)(6666004)(6512007)(38100700002)(83380400001)(26005)(8676002)(4326008)(6862004)(8936002)(66946007)(6636002)(66476007)(66556008)(54906003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kq8SGgxbxzMulxfc3MisP9pXD61wN5r7J+lt+0hHAOqSe6Uf6lOoLY69sh?=
 =?iso-8859-1?Q?DdZs7Z93yMCp9CcvcFPTORXfHEeIMaJAOjSLGdO8aETU0rQLpTZCtZkmFC?=
 =?iso-8859-1?Q?h5N+bylMZjm8LemRkewCgailIXCI6IFt8reJEgw5f98ZBwbumuQLbdrwxB?=
 =?iso-8859-1?Q?6JpLWHl1ZgDVfA2MbCVqBTxUfErth5YKB1+Pr0RhH4T2V27jvqvw5+EvKj?=
 =?iso-8859-1?Q?RxgfCKfR75oasTkPR895ZYkT4lcFbMrpQ+qmYqvP2LtA/5gCpi6nSnlKBP?=
 =?iso-8859-1?Q?RArF0QYd8jJopiHhUU9s2IAGrTrPD6YqNpI/sfBtDudrsnjPTQJhZWBmHK?=
 =?iso-8859-1?Q?yvE2lXWqo8fh3ei/IMqeNbXVsppgs+WsZPG2VVoPNgCHFi2stKmuqy1W3P?=
 =?iso-8859-1?Q?PG/LQyspe2OmntuPdBcjI1oxvrd31G2BxdgE1QFC2HDjbQ2Xc9AM/lj0Xm?=
 =?iso-8859-1?Q?cuGmn7L/2/n0Lb5WgUS6Nbj+USYeFJsZdb+5h2Yn6MQ5+EloTzYJsCMXjs?=
 =?iso-8859-1?Q?vlec9XvBI0rC8Dqntn3016W1On2C534CwULaHZLKXgoNIFBAhxBlnifmvx?=
 =?iso-8859-1?Q?hNQJZtFNZ4xGXYu8YdPbo/95JxRsRvOqhdcSHS3Y0wSew1U7BQl3vHWGQW?=
 =?iso-8859-1?Q?vAr0e1MIVMaS528noEtVzRK7wvtaRSo+s734w1Z3i3TsDpQVq67VFHVaRv?=
 =?iso-8859-1?Q?LCiffqjDlhCgk0hDsHCsqobmkJu76hhWDLGhFSLWKeYzZLYWta4sKmphJB?=
 =?iso-8859-1?Q?fQ3RcWVxsng5GhJPDMRZYEvkv4POB9Ojx4CkC+sMV5w6P6dgoVFaA3iHI+?=
 =?iso-8859-1?Q?mW1CXCSDZnZerDUQ3jUorZHXTFzb7lNYpfhnzV+UjLo+rEhk1EtJO2ElYX?=
 =?iso-8859-1?Q?GSL39pN3icEUseI8KiGeA/8GlCkliM9MY4kNdg1OcWzdkjsm1Nn/Jemefi?=
 =?iso-8859-1?Q?vLx35l6jt8gWP/xqBDBU5wEojDNnkmrP9uaKfibzcsmklewvXF67OVlVPc?=
 =?iso-8859-1?Q?d1Qd6mhMIqATsIUW/WgHpUvE9UKFMK83kf+S3XTLkYECV1+fLjnNNYVyrV?=
 =?iso-8859-1?Q?nfuKG/zPW5r7gemouVnZoL7XWIC7iQHVRaqiFSTcQTLopcJJtXsh0toqdp?=
 =?iso-8859-1?Q?mUgFIhKMVTAhqAmJUI+oTNezdNt0B/0U7y+lQ7+82AkPUiiVBgSjwcnJen?=
 =?iso-8859-1?Q?77rEfi5y/VTdVEAUCwYK1RigM2cnNry0Pwrf3DceXNopVx/UWKx2hP6zKR?=
 =?iso-8859-1?Q?7MHltekYRhf4xRMQfJIAZAj70Np6qR4B/eIsJXRqeEYBJOkiuToD1TOcPF?=
 =?iso-8859-1?Q?aZCKTiAVprkBkIDzsoUC9FwIvDScuohMa7DV9/DRvJNikMNaUvX9fPZkRg?=
 =?iso-8859-1?Q?vzatXPN8egelhqntygTB2oDlm04YGvmEpz1UOgGvQJTXdtT3hrF4REbMAv?=
 =?iso-8859-1?Q?uytfA/RWsPWFxRrXdg1LRC/cB0UMfTTCkVRqRwJFZ0a+mKBG+lbpOHUwHE?=
 =?iso-8859-1?Q?GvPxKOIg3uKFv8ZbHtSfIEKg5ws2AJRLfiaZFi4YMh3Roiq5TS9qcY5rJL?=
 =?iso-8859-1?Q?kNsbXjvYMPsY4Bl/LCYnLnUc4MkWXC3GkOkT4cj60FzW+83eeIuzvHpqns?=
 =?iso-8859-1?Q?LXle46fFGl+YNru+DIjZbNb8fy93tIfmS8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9c68b6-9a96-4080-9d53-08dbf5c73d13
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 19:20:27.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9UrS0V77eyX6ZW3TcFQeGinGm0/zDZeIM7SSLwk+N/8bl0KaLbHKzsyqLnPTJEZfyylC1dySaYgGYHl4ytxuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7381
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 09:29:24AM -0800, Zhang, Rui wrote:

[snip]

> > 
> > How about 
> > 
> > ATTR_LABEL,
> > ATTR_CRIT_ALARM,
> > ATTR_TEMP,
> > ATTR_TJMAX,
> > MAX_CORE_ATTRS,         /* One more than TJMAX */
> > ATTR_TTARGET = MAX_CORE_ATTRS,
> > TOTAL_ATTRS
> > 
> > Each enum can be assigned any value, but this way they are just
> > increasing
> > order. 
> 
> ATTR_TTARGET is the next attribute after ATTR_TJMAX so it should be
> right after ATTR_TJMAX.
> MAX_CORE_ATTRS is the number of basic attributes so it should be
> ATTR_TJMAX + 1.
> TOTAL_ATTRS is the number of possible attributes so it should be
> ATTR_TTARGET + 1
> 
> ATTR_LABEL,				// 0
> ATTR_CRIT_ALARM,			// 1
> ATTR_TEMP,				// 2
> ATTR_TJMAX,				// 3
> ATTR_TTARGET,				// 4
> MAX_CORE_ATTRS = ATTR_TJMAX + 1,	// 4
> TOTAL_ATTRS = ATTR_TTARGET + 1,		// 5
> 
> How about this one?

Sorry for the delay... yes, this sounds fine.
