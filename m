Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38701790469
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 02:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbjIBAMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 20:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIBAMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 20:12:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8991A8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 17:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693613532; x=1725149532;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gjTBAD4HjNzX0voJIaa7DiqV9gx1dTvio+8oArQXZlE=;
  b=l2yHUsPZJvFRqfU9l8JwF98YwgC/BcPOiyYDR+4Ky9/NLublm0HCIASy
   SaMxqFkbPWYnKVddecTLQ9o09nv5IgihUZgrkEuu9uJdlPhT74Y59+QgS
   AabUJkkF1SNrUFRTLNzoygSPsPSGWJcFCQaC+vbn0X2H7fR9GXkg/dM9W
   t9IKl1JjBDJa6UlZS9RCDg7qRgBA8nXlCHyR91n9rqBMTVwtyQf6Az79Q
   So1o8+AuZLdnu9ANEfzFbQ/9Wv0WcOOEcexbWUi5VUZK1Le7KI6J8sNX8
   hVTcKMV03NxIWpV4AsgvVbC09Sat7M13bqfkpvS9ht2dWOO2f0PAzYYC1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="407328896"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="407328896"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 17:12:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="733682123"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="733682123"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 17:12:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 17:12:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 17:12:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 17:12:11 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 17:12:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8oplCH8YA0Ism5VV4kun5L+9Eu06kuw1kHTza/C2ydpUeim0C3ImLbzuQ7gjvlo0lwnzyMiviriOThgSj9oB9oRBmxjm8oa+pkpy7HDdcauMK2PtmO6Rlr12qG0GC4pEXU5TZ0v33qB4YO7ymGTV8aga/QTsv10z84kBExPSg7nj3vyeM2Z8hSCcY2cHT9lns1mHaImpeOGjnbcU8QT7e1Lla7LM2Fu/DpfSnK5QgCdVmik8kcQHbojDvTzbm4mV0+r5nQ5U+120iyvvcmGK5LN9DSkm0inAVBERRvyI047+ASCquARFv2S3vrlYMXSH1VAQo+MnV+ZNCS3JYEsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjTBAD4HjNzX0voJIaa7DiqV9gx1dTvio+8oArQXZlE=;
 b=GkjYpdYdPAF1FOGJIhixqDn07efPyZPQ0TmKJMQLYYfS92rqWx8vwYsUwvAsGJc0CEfxlN8Q53i2yxeaExctBSEvlPPO0aA1a5r6Ki+W9/d4/H74B9Rxmx8LkowDCGi04xpgPNRX506xcYI7AhICPc5s4LJQa0MAucvTxVIrqeHjnT/qlyuNKMM6aVw6IaqDBvKiLgseZAVMMX3PttshYR6J3l+5fGy9iYnIptAvAd+VJeQdhSqNWYbL+XHXTAPbu261Y7Uz9Pu0IxcnZBjBfkkppYg1gNG/mS+/l2ufCFjpnBw/3XHHI5yJl7HqnCnI/dJH8DTDjfOSO+/Vgyl2sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH7PR11MB7097.namprd11.prod.outlook.com (2603:10b6:510:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27; Sat, 2 Sep
 2023 00:12:05 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::5e34:ee45:c5e8:59d0]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::5e34:ee45:c5e8:59d0%7]) with mapi id 15.20.6745.020; Sat, 2 Sep 2023
 00:12:05 +0000
Message-ID: <883c1f5a-723b-0010-0327-0c4240521abe@intel.com>
Date:   Fri, 1 Sep 2023 17:12:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] selftests/x86: Update map_shadow_stack syscall nr
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>
References: <20230901181652.2583861-1-rick.p.edgecombe@intel.com>
 <e2ae1d89-9abf-338e-e56a-dc4be19b9bfc@intel.com>
 <b92afa6dbd074409095e525204d538f451ee4823.camel@intel.com>
 <148522e4-a4ec-a35b-df25-e04eeb5f51c4@intel.com>
 <339cd90a9b77706bd65b6d45f49edf009a9d46a0.camel@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <339cd90a9b77706bd65b6d45f49edf009a9d46a0.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::16) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH7PR11MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 1451b9cd-6cea-441d-1b29-08dbab493d74
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5J/N+cka9BtF/t9kGz4+6afZ+GRNk6dfDtIe7LvBB6rue618YEyViHP8MLMAk9TZiAejrwpTlUZMcBrIJUluT9BQO6tu4JT9Dj8QhAYV+DFzYp2dHiF+pvF9wS4458o5MKvXpRWaEdikZyBhQktDCgTFXAbxbivTh82TRqMB7d/nTHcZv6de6TLGT5mnqsnZZqBSKYcptl7FgdsOVst77jWTa/B0hUX92kDLZBoQi993pqgBeG6RJrnf14o+EVihjTwD25UiBFxyfDLBEW7+oED4v3xyEACfHjXo2Z7uwtpzaxzYrlhROxMW4Amd27lY4zJrYA0xVGINdE9u8k1y/EHFh4yun5pMurcESNYQxFzcpzDtd6B5IDCn8FET//fK/wMcxCBDXcq8HHC5o2jdTB9rq8My9AwI/Szmexf3iQoECHQEEyqRBeha03z7tGPkTeONCXVoMCTaJgwHHtLyz4J5S5yUrIIf5+b0v1DtwFsBaiLkYdIYfZrGXgC+Rut4z2DfdgwGGJit/nwkvMBCxDvJZikdN+wQDdIc3Sx1Ux2/ktJOOx1qO0IOyYPxyKqNmlKqXA2sMk+MpcViMg2GRN7B9+HeEcPilY2kYxk69RMAFNhMCZVGD4Cg5u/yRcPF0gYLxw86TPIPRKle/NQZndUYWOwJmRa3CBHeM//A8PI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199024)(1800799009)(186009)(31686004)(921005)(6506007)(6512007)(6486002)(36756003)(558084003)(31696002)(82960400001)(86362001)(38100700002)(2616005)(2906002)(26005)(53546011)(478600001)(110136005)(66946007)(8936002)(8676002)(5660300002)(4326008)(7416002)(44832011)(316002)(66556008)(66476007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlBlVWZpaU5jR3loVWxJdW03WHhYM3oxZmpBbUFBUU5VcXE0anU5YXYxaFZZ?=
 =?utf-8?B?eXRia0tIaUVDNE1yT3dOR2lhM0pqSXd4TW5XcGZsS2xxdjhmazZ1NDM2MW9O?=
 =?utf-8?B?SG94REs5NDBMWEZyUlBscU9qVFYxQkZMb0tiV0VJbU9qUHBYMnhwZEtXN3l1?=
 =?utf-8?B?NWxaYTBaTkdFRnQwanFtNWV2VEl3OU9sVmlFeEg1Mk9lVm1RNDBpa1FWdWRp?=
 =?utf-8?B?VXVVU0dzYWthZm5mYVJaL2ZlMmpDS2JxOVhEWVpDc1hkYkI0S24xaDRZV0JM?=
 =?utf-8?B?bWxGaSs5UzFwcG5pazU0NVlmRWlNZldlYitHK21YZG9tSTVJeEY0NzhxUVNO?=
 =?utf-8?B?ekZmY0ozb203NTZaWjdwZ0RyWjltUjc5MWtod2t2b0dEUHdETVRYRFhzUG9j?=
 =?utf-8?B?M21xUDNFNUV5VndaVURaRDFsNzY4bW5RM3ZtakhpTHRiYkgwelhmYWNQZTly?=
 =?utf-8?B?bW8weDRMblFONDd5dXFzeGdCRzhISmw2MzNkSCt4RzZSUW9oNjE1NTlCaWg1?=
 =?utf-8?B?Z2hyZDJybVNCK3Zicm1tRUh6bHoyRmorRkV1OU5ORDQzZzFHbjJNLzJyRCs4?=
 =?utf-8?B?Y2VTcXVETEcyMmFPdjlGV0VvckRTbmVBSVJneFRMZUVYNUdKSEhCd3A5enZM?=
 =?utf-8?B?U2crOFRZWW05S21JMmJTR1VkU0tGaWJiQldFWkRHWUZQMWd1RWFQcVVFQktu?=
 =?utf-8?B?MDN2MWdjTERMWVh3Z0dBek16OVVXYUszTWpjY3E4TFhTUEhWcHdQb3pRbVhF?=
 =?utf-8?B?QXJ5K0dTQ1gzRUhjMlltd1pqOHFjSW44WkRENmhPNUlaZi8wT3Bhb2txZHhW?=
 =?utf-8?B?Wk15Ym9sdEpRakYzVnNoaFE0T3NLRml3bGhpajhNMGMvUEJiR1l6a2FOdEpw?=
 =?utf-8?B?ZnM0T05aQlZhdlNxdWVJZWs5dVpFcjVrLzlJOXFkbVBPVnBrNjFiQlI4VGo3?=
 =?utf-8?B?ckJVT2lpZnNBVkE2QTBVeVRxT0QzZFBiV0pKSVVDZkF6dUhmV0Jicm9KM1N3?=
 =?utf-8?B?bHNraVJpOElwUFVtdzJ5c1dCd3k3aVR3Wk83ZGRUMFJhSFBPZElTVTVlK0lV?=
 =?utf-8?B?Z0hlZCtzdXdVdzh0b2RmUHFYU1pTSXJhUHJqRWduL2lQbGVCTFZiS3ZsNWxi?=
 =?utf-8?B?TzJBTk82M3hQQWRJZXFkNlZRWUZ6d0NYYW5PR2orN3F6UVFNeTBHUjVhQkZO?=
 =?utf-8?B?Q2Y2aFZZYmtsNVJ2bXU3eEdMR3l6c016SjdocjNJNkoxdE1kV3ByVEp5a08z?=
 =?utf-8?B?Y1BBWGdBR2pWOFNuRitVdDlJYjJLN01VWTBLbFVjQzNvZncyRjd6M2Y1YlFz?=
 =?utf-8?B?NkVwL2VJRUhDQkRIM3FqYXhPL3VjSnF0bnN1RjZMUDFiRnFOSUlOMzliYkI1?=
 =?utf-8?B?dDUvc1k4Ylk4RjBISHZCNmU3aEc2MkdlRzRsbDVScFM4TVZ4Tnc5ZzlPY2Yr?=
 =?utf-8?B?ZWJPb0JTaHVyY3hTQlVkWUR0MFMrYTJYdHVTbUhaQjJLK3dkejM2YmtyUU51?=
 =?utf-8?B?ZWpKcnRoU01iVUt5SUVZUmZ3a3BiT3lDNDhGTW0vcEhaRXpWNTlSVW0vdGFF?=
 =?utf-8?B?d0ZLbm1hK080QVJxU2wxazhMV01MRFF0UmxFY2hpdWczNkRhVVJIdkRGOEFw?=
 =?utf-8?B?VTlkWFNscUFHcWxQN0ZyUDJQeU5aeDQvL25DZjNNT0lYWEhaOXNmdGNyS256?=
 =?utf-8?B?SjUvSlJlVUVVMDZ5R3ZqMFBhbURyYWQrQVF2Q3BxTEJDNXB1VXg4TzNaS0Z5?=
 =?utf-8?B?by9yRnE0T3hnMXdJRDZXSExoRVIvRXRmZDh4OU5USFdGVzZoVkk4Z3k2UUNF?=
 =?utf-8?B?cXAwQm9sVlJvRWx1VlFTL21JZEtKMDAzU0YxNjdnWWxnUFhoTFNpTUE2WUh3?=
 =?utf-8?B?UnZQZ3p4VjF3S3p1THgxb2c0OG1wZnQ3bkZiYXNiNktBM2pGMnpaSXFCQS9a?=
 =?utf-8?B?NE5PZWFqQThtWDNlUUJMMHVpNEc4Ym5veWtpK3lSMnV6SGhpUmRCSWFNbS9B?=
 =?utf-8?B?NkYxN1Rrcm9yTGFPdWsrRWJJVnc0Sk1HRFJ0UG5nUm5DeVNPcnZpVUJ1bTNq?=
 =?utf-8?B?eXo3OWNEUFV4czVtb041bkpkUEp3L2xzV1UrSlRqcTNhSDQ5SEs5aXlSU053?=
 =?utf-8?Q?41Ysrlu3wivio96wmntd8027z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1451b9cd-6cea-441d-1b29-08dbab493d74
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2023 00:12:05.6310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvw6GDb4VNOhTKn7PFvtR4Apq38BJutmcoCAUrrmjBANiruFpHXMWiysWFG115sjaIgZglxdTKsMbdc6kGEsig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7097
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/2023 3:51 PM, Edgecombe, Rick P wrote:
> Putting reservations in sounds like a good idea in any case. I take it
> you would like to send the patch? Otherwise let me know.

Sure, I'll spin something up and send it out next week after running it
through 0day.
