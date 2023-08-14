Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E5B77C1AA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjHNUnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjHNUnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:43:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25712D1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692045819; x=1723581819;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wo+uCWU2Gvy5Bbk11TYo+KxixuOaK3eSV3e8mTaLrzI=;
  b=AWWECsQF0/V/XDGAUZnzNqhyWodg7mlA7HzwhJOFPh0OC+TZLa0RW6xR
   j+FducQCWKllwOHKz86uvi254VrkSsTg32ldXFrwkLG1GSbH0O6IoC13y
   m4bk1DrG4yxLKsROAq4j4JwR0uY+tdnUGvxTbRm0c9NJHiH5jjiFfkKns
   Nl3GvGE1pOSRL/d16FSUsVnhWp5chyWP+gDBcApoFm0A/bCjmLVTeu+jX
   cLSqsdjpypv42zsD/Mi48q7XedlA1SxyFNKBaYxoOQXetVD4hOs+Jcyx5
   e5i94UZ2SNZeya/y5zhpxzKgm3DY3bcT3EkYVsrqhB4bHw/Tp/Lw4iaIX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="362284292"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="362284292"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 13:43:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="980134929"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="980134929"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 14 Aug 2023 13:43:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 13:43:37 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 13:43:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 13:43:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 13:43:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6X5LGgRht0Kzj1LO85XVVutzxN5d/HzIu2w+89hE9wkFK97qLudRKyCSxqZEa6tmN/0tlDLh6BSgEWyCQOUS9OAcB6JAIW0phFI+wDtg0pbwfTdfmP1MrK/Ph6dhCoJgVwX0OfOrNqJd5hGmXPwRBLMvI0rqVwD8zK+D43IPNOqQ97wQO8EAkiyxZPUJr9UK+LYw2zrIwtglYPpyYcHatHHeV04dS4+9ORSMoVK5PatKuYpsmN8ecqBjExasFxTcCR9QW51p+buh/PiKr5rXaHUWcYY/iBC0+C2D5uSwU1ReiWAipzj87C2X7St0/5M5nIbpdIryFMMi2oWxSLdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L42aNHtXzblLNn5eot+mNAqYObFHLzGnaI41E/f2Xuo=;
 b=Rv4dWWZitSJKqa93KMNDNqRJjsi2Goo+icURVYVTOi7BBug7JsVllOHhcb7VEI7FZMKbtNW7fWqlKsH3NShMF32pjbtdQuQJKZ4sr1TEqFxlJvj59nHfqxoXC2heB4T/d8F2+JzpNynSkwsLDxplwZunWz3UFOMMAZYznhRFbg95dXq09mUHiki+0TgDgACND9UDu2+mkBizfT9mCLvNlTLsJFuyHR5C3YOL4irVcWgWOVhCMVteXG+W5ds3VRkb8V4NrWDqeCba/d9t0UNFbh4J8cNCtXAzWprws9+NGBhoA8xkcuJdtiN3oI74ryxuX9UObhNWF7ceXqkD0XwzJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MN6PR11MB8148.namprd11.prod.outlook.com (2603:10b6:208:472::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 20:43:29 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::ad4c:86ce:d99e:9740]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::ad4c:86ce:d99e:9740%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 20:43:29 +0000
Message-ID: <906599be-2fb2-a9fc-7d1c-77e9dd6f986d@intel.com>
Date:   Mon, 14 Aug 2023 13:43:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 0/1] x86/pti: Fix kernel warnings for pti= and nopti
 cmdline options.
To:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        <linux-kernel@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <luto@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>
CC:     <x86@kernel.org>, <bp@alien8.de>, <tglx@linutronix.de>,
        <hpa@zytor.com>
References: <20230812155448.8865-1-jo.vanbulck@cs.kuleuven.be>
Content-Language: en-US
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230812155448.8865-1-jo.vanbulck@cs.kuleuven.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0098.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::39) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MN6PR11MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ea70aa-a96d-4d62-9c63-08db9d071d9a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZfxNAESok8sCBn2QUY8kkDN8OCFSCZh8qJCAowWpQJoTMYF/3heBiPbs4iJzK+eznOlSBArFUFrWpxDPQbAVRcficZbmRvMSk+UP62pstKo5jhiqm2r9dNmkthWPBtnGcyG5fwxU5ILvCDsUGRsWyBSjSF3qRy6Ej/9qSFjo5fXRto9OJoRfd5jkzUfFB9pXE2pjUrXIM+vCwTyL7gc8Ry2z4UPYTOIWpii/+gRklggCuKh9V1LUQn+hvlMH1cb8ORNIG0elFznJY1pNxE6Pt0+wuQXd73rIyxb9IwnHs0lrQtMQ2acYJGArSg4P4aWpiZ4jh8QuAEYyPJlmx9b1bhh7/uq6QHAlz3XTut54Vw/X0wMvpDCz46aP8mZy3+3BsxWu1gIoU63gMIAw3XOzR+9Z+tJLA9w1LNQPfYbORVWA8vW65bbMXEK0qHxVhl5+nMIAe4xH4jiD3hdhtfpPzaPRVWpB9EsXnhf00b0YZu4crS2JfaSC2FLxTQZ+H3NvfH4HtIDAjJgETv4/iaRLILayaDofgCoOW0dY3hdOYafZjqQAloEhLr5zG/TweI1nu1zc7EMk2vS5Z2Jo1w+bc6bxsUQgCmpckl1AnNiOZVkti3LzRo1+epyZMNGStL5y2bjp4I6yIpTRF/ChfqckA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199021)(186006)(1800799006)(36756003)(44832011)(5660300002)(7416002)(31696002)(86362001)(2906002)(4744005)(31686004)(66556008)(66946007)(66476007)(4326008)(38100700002)(316002)(41300700001)(26005)(2616005)(6512007)(53546011)(6486002)(6506007)(8676002)(8936002)(478600001)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1hSYkhackZBTEI0NmhQK2ZjQ0h2Z0gwRS81ODFzaitFZ0dkdXNYTGlNdUJM?=
 =?utf-8?B?cmFCSVRwQUxLMVEwbUYwbGU4ZldBUEJIbjM2Y3dWM01Xa2o0NDR4WTIyc2dn?=
 =?utf-8?B?b2hkZDNyL3lqOC9aZXBaTHl3Tm5ETGs4ZGJzUnZzQXdTbVJnZjNnNFBnUHhp?=
 =?utf-8?B?bnJTRWtVaDMyelFVS3hHRXNBTWZXby9HcUsxK2tQbHlGTnRjT0hBd2tuUGk5?=
 =?utf-8?B?Y0QvTFh3UXNGM281bWUvYVpWek16Y05nVmRDTktBaG1hVW9OK0h1c0ltam5G?=
 =?utf-8?B?Sy9JWWtHTVVqMHFseGVrUzV3eHg1Q29CTDduSmc0OGFrbEIvZTJTWENxc1hP?=
 =?utf-8?B?S0NHYzR0UTJ5UnJBVlJCWXU0a3FrZElVTk1ORzB6ak9Mb0s0Q0tpZ0UwWGdJ?=
 =?utf-8?B?NjdhTWdlcWRIVi9NQjlRRUl4b3hNRGJ5Zmd5L25PbW5yM1I2YlhPNDJzN3RT?=
 =?utf-8?B?UFBGWE5hTkxaQ3JYNnFTWDg2aVRIYjhzRTBER2I3ZmsydmtIRk5wWXNRMXdN?=
 =?utf-8?B?QzR1dFJqbGVvM3J4YVEyMUs0OUt0NWJBOVNRRCtNdWJubDdxTFI3MlFxeHR1?=
 =?utf-8?B?akpFZ2o3VEJCSTZBT2dENGxFNXJoelFyWFowN29KWjdLa05lMUpCenJoMHlJ?=
 =?utf-8?B?dklQRWtNQU5RTFBzWDY5LzNGSkgyaVliVEJlYmV6WkYyQTJKaHJWZW9SQlJX?=
 =?utf-8?B?NzB0UHlSU1RGZkZOT21IMmlaSnY1a096VU16Q1Fkd1BzVmhWRUdFak5wSTZV?=
 =?utf-8?B?S2dUSkx2Z3RBUTZUS2FJangxNGtoSVdQdUg1a29ZVWxsS3BrNFpVL2tGUHRR?=
 =?utf-8?B?aHhDcTZ6VFRwOW8rTUZHWXIzZ2JEVzZQVnV4K1FWN01wN1lTSnRmdjJIZ2Zn?=
 =?utf-8?B?ZHlCYXBUT3pJL3ZFQ0VBakZDK283dlpwRVF1UjdNL0xhMWJDWndrNjl6ZU9G?=
 =?utf-8?B?SDl5cXZQa2FsWjYveG5zSFR1bjZURDlwUUZhczFSblF3Y3ZiTmUvMnNnS1pK?=
 =?utf-8?B?MDFWdzY2TUdzWW4reXlMajQxMFQ1YlpURUxVVldVdnNzTVNRcnUwN2djQU13?=
 =?utf-8?B?NzlRaFhTU0c5V1hrTWc5WlhWZmRFc3p1SnROUlZYbkh3ak4vc28vekl2MzVD?=
 =?utf-8?B?YWs2U3h4TS9YN1dDUWZjelFDdmJsUHM4bG5mR1MrRFdaZUtuNkFXSllSS0RF?=
 =?utf-8?B?bThtOG9ycVpCd003am5aYVVoZlc1OExBMVhxQllaUWhqNi9RRVRma3EySUdN?=
 =?utf-8?B?RGxtcG1JcGNVZytJUUd3S2d6S012NE5UUkpGODlHY3FhUjFSN1JlaDBUVW9H?=
 =?utf-8?B?cXB6YXZFdEdkMkxIQThuYkNMczk0OGtOOXlDY1E2cmtLK3UxVnp0VGwxWmxH?=
 =?utf-8?B?ODcwc0Z5Tjd3WWVMZzB4SEJhampacDlTeXFoaWZqSThBWlFLR090a2hDODdt?=
 =?utf-8?B?SGlpVDhsL1ZKU2o5Z0xDQ0RsUk1aODBqZmNacHRHaGdCaHZwdnlUVW5nazBq?=
 =?utf-8?B?YWN5T3FKQWVEVjU1TWFxbHZ3eEMzUVN6MXJ0T1FxNUVPRW02TFd5SmtmRFdD?=
 =?utf-8?B?RENucDdFclUxTGsreHMvbkJRUktMS3gvOC9YNHVUd25jeEdLK1VHOHcxTDFz?=
 =?utf-8?B?QjAvNE5aTW9oeTV6amFXejd0RlFjZEYxdnlPMURETVM0aTMycEkrMnNCZTBG?=
 =?utf-8?B?N2ZIVzJPYkV1MUFOamtZRTRYK3BaelRIUUJSNDJ2NjJQbFdkM01aYS94bFMy?=
 =?utf-8?B?dkY4UzArbUhwbnlSNVJpVnA5ZmRQZThjaVZLOXlYalozampXNGhUMGJwWE5l?=
 =?utf-8?B?MElSdUFjSjVma1h2TEE1OXZqYmpYbE5ESjhQNzJzdnBraVhlZWJYN0NYRGRh?=
 =?utf-8?B?cHBqT2lRZk9qb3YrdVR5RVNJZmFRNUNMU1d0UnVqejBuZ3hNMjlMUlFua3dM?=
 =?utf-8?B?S1M4c2I3bDJNaDBUVFgreW9YU0hWTzh0Uy9Xb2JQajVIZHg2YW9NaHR4QWI4?=
 =?utf-8?B?NFM0MXRKa0hwNUdjM0R3bVoyTUVNdVdRNG0zSHpEWE9QZUVENEdhSTBNRGRv?=
 =?utf-8?B?VkdLUGxPbitmSEY0MldJUlVydGowWlB0c29vdTRxdHJyMEwxNDloV0h4YTVp?=
 =?utf-8?Q?6QZ6slqgXN5NxGTL4bqguZuq0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ea70aa-a96d-4d62-9c63-08db9d071d9a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 20:43:29.1797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8FIQRIPkNMz0chBBNZoikAImtUzXE7mM+yi8+Ymg9TNlt68f/CB9TxHaRGlZd+Pm2DfrhF2m3U8R/WJgMA33Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8148
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jo,

On 8/12/2023 8:54 AM, Jo Van Bulck wrote:
> Hi,
> 
> This is the third iteration of a patch to improve the cmdline option parsing
> for PTI.

You missed updating the version number in the cover letter subject.
Also, it is useful to have the version number in the individual patch
subject as well. (Just something to keep in mind for future patches.)

Usually git takes care of it automatically, if you do this:

	git format-patch --cover-letter -v3 -1 -o patches/

Sohil
