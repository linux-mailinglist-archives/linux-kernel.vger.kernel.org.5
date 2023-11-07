Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5A17E4001
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjKGNYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjKGNYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:24:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65A718D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699363419; x=1730899419;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aAirAttaj137fFCg1NKx0E5eBLShOZfI5NwCIP1EsEI=;
  b=B64a3mrtP2s91p+lLKbpr+54JMpEQIHu6PpGeerlb0kLFRT4BTgfsS/G
   C+N2kKeIfNLAsA697MTqBPtKirBNdOv+4G/iUD/ha4JvFmPQ9xrc8uHPO
   oUXHbHBcaGHxKofmjx+MgHWHBBc1INirfr7wTWdvzKdQPH6jn/beLFi6/
   iIU9Wk9zyOnC5D3i4EsF8bsNb8MxpOCPK/StBauLS/F3I3z6evcM3cS9Z
   3RbEHZM5vMp24i6WpL2RFoq5+FplyFLGU1PYt2HWi9QxCl29tHNnw0f4q
   SpRxd7NMWaC5KOdnKvmG2uLBhErw76vvV3H/VBhpo4ukwx66iPrkEO2EF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="374536187"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="374536187"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 05:23:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="10412617"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2023 05:23:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 05:23:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 05:23:38 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 05:23:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9ghz2mku28jS2YW4XaCI6U/hKAa0O5Ybax4BDzF/hPGczv3Uiwx772qqvMLxQt64v5sxKQL5oT58rwLYDOFTSzHOVSTYc92uSfNsjnpWrTuO1dw6uvVLdVAiO/KCx9D5o9SL2OOOy1PWK2gNQQy8PYE12IxpRGvXnBOcehQGyjXrrJTbI+EjCxGcpJiU7bNAo+pghLMBpiTHUVjfnw79TevrBcrriN+EnCAl9ibRb//VLPPfVFxSgT3ngdSXLoJVpnAjFAPJwB0K6GzOQPt6wvv1kg0rhqXtn7P/jcbqnJsip/Ay6Zq6cClFQA9Fe46lQ7D5fPNLajnLZ4fdr7aEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfPsnn96uDhOFuhZMW94VlIar6aDgo6f2On0Z2JgltA=;
 b=BmlzFbgO67ZtPAc2AnwlXIQ9zFXZcLuQl3HYjU0dUv1GEXccBHLKu3/7Yf1ypG0fQIA/GcruEXUB9917CD4QzC4Du0p71uOolvdiUd1HO/y6i+L888R0kLju20K64dZFOfG43F1VJvZvOvBRESeOD6xDBce+KxDTSkfSKidyCqdkgavMLCAns0VhyhzuybiREl3rfLzMVC8s9t2Bqxi1mK7WUDlG5vp9Vt455zHl1TeniSowkrsNGa5yPHkThanlg4Kei2bNabfsZRT6vR7Iy9fWTsIqfJNaW1gI0Kn8YDoIJXh9pY6o/jIG8dzV/hXI5c3XHEB57jhJmeqQZEM6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 13:23:36 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 13:23:37 +0000
Message-ID: <0a29df6b-bc27-43e9-a97d-57ecabb29a9e@intel.com>
Date:   Tue, 7 Nov 2023 14:21:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [alobakin:pfcp 11/19] include/linux/bitmap.h:642:17: warning:
 array subscript [1, 1024] is outside array bounds of 'long unsigned int[1]'
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Alexander Potapenko <glider@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        "kernel test robot" <lkp@intel.com>,
        <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <202310170708.fJzLlgDM-lkp@intel.com>
 <bd7fe929-c6fc-42be-9d2f-3f53ec21fd10@intel.com>
 <ZUkvOCxyiin_77qd@smile.fi.intel.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZUkvOCxyiin_77qd@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0138.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::14) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DS7PR11MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: a023b6b9-e51d-40ec-f050-08dbdf94bfc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxHSdG/EurFn6phgB4WIm42K7LULf8CBbxaU8tz4hkEryvIjvWefFv/za2Y+F8kgVRT5QOzsRlLK8xPgJswuWCGTXMYVi6dKthhNG5IcFeKsEG8u334lqgkQN56127AwknbSx+DjGHK0j81my1SEyPXKuMkVbm60ydYHMW9uY4LrgpPVNVGoLiLmL32Fy6wNFTrsI6oa2qc+qwFLzlKlJqcFLSqLgmGsfpNgjzaqZShkPwFu7hlzeJP7gDd8klbJKhDpaNGJ91WcvO12xs9YQm4UyL06WtyGqNGTM20+YQcdH/f75vxS7tlGfDx38AzfkUyLM6OAyC/Pi8w5sqdTT+Bvm7Y5b3rxjnLfdKS5Ay5Rw87sO+GQpSUP1hLuZULgl/IzRJj4BwdbXVKahnjnOuSxJrPiMaQADoOXoXvB6i1FlFG0xoFPL+3cT1hdQVDAUw6CRLF4GMO424X+z5lr0eph6QBSLWse7KV0eO+UswoYf54DabvJXyN/4GRHEMv+tXmVSmEcD65E3HB13QWVShsXZqUNvvIhwT88/8AwjybYnHaxwsszefTL0wuSoYFGxNGauekfh/geRFBM8PXfQyFHBUwahqhwV14OrURua4pzUG+hVJ4p46Td1s6oz1fX+vdo+DT+IZ01PRp2GQRz3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(83380400001)(31696002)(36756003)(8936002)(4326008)(41300700001)(2906002)(86362001)(4744005)(8676002)(316002)(478600001)(6486002)(966005)(6506007)(6916009)(82960400001)(5660300002)(38100700002)(66556008)(26005)(6512007)(54906003)(66946007)(2616005)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGhYeXlQWmF2S3B5NmdIa1RaeFAvWUhFMWRZRVdWUVF4ZVlvOVhlK0NiK0Rj?=
 =?utf-8?B?amxUMkRCQkFaUGRRb0dNMlpDa09pZHptLzV6MFgxTjdYR3dCY3VVeDJ4WU5H?=
 =?utf-8?B?RU45VHB2WWNYb2lXbXcwaCtnWUpvVXFPcWJGNjhmVFpka1ZlU2pWU0VtaVcx?=
 =?utf-8?B?QklaMk5vaGtJNmxpQXZKT3hMaWFNcm1Db3VrR1A3ekZrUzlXK0hpTlJDOGgv?=
 =?utf-8?B?OVlyQWFUeFdkejdWNFo5Zkp3eWxwTTdGVldrOUtZM05WajF6V0FsZnFrUFVi?=
 =?utf-8?B?eThFVTRRRmtXNEQvOXBLSVZRdVVsRTZ1YjE2L1pMRnhoQUtpQ3RpQUxIaXVz?=
 =?utf-8?B?Q2VoQ2JZSDZ6L29OaldjRW9pS1BOS0lMdXdKUFgxZUdDY05XeC9BS1RDRXdG?=
 =?utf-8?B?YW5SNGZWNEUrbEdmeElnc3g5TzhSVk0xTFZmOXZyZVBhaWp5bkowWXIwN2wz?=
 =?utf-8?B?QTQ2SFgxdXN2VG9IUXdRRlBZTTRpTW5JSU5XblNtc1RxdC9nRWozSXdvb0tR?=
 =?utf-8?B?QnBCdjdMK0ttYzZmSXdsRWlCVmJOUzdHclprOWpQdGowMldEdlRUYTVJY09G?=
 =?utf-8?B?RDlGTkxHbllXczRPbGRYRkEwNnJFcjBLVXR0cjB3K0R1SlByWFdsem5CWGc0?=
 =?utf-8?B?Ny9sdVYwS1M1UHdTMmRMTEExQldzWjRVTHhrUUErZkQwOUhEbXdqTU9jMGlz?=
 =?utf-8?B?TG1OM1J1ZXRCS1RYenY0WFNqcnBvVGJ2VlZURkdtbmFPUTgrT2dyWGlvb2Er?=
 =?utf-8?B?YlVoSHFVRjBvTTEzOEZGZmUwb2FtK3F3cm5La0FTYkJFWitoRXhaSis5TFJl?=
 =?utf-8?B?VFVJdVZMZVg1bFh4ckpaRk11MTdOVWdHOUZqaDNId0NYVitCQk8vSUVBT0lx?=
 =?utf-8?B?MUR1ZGF6Qk5BTXhjRnN5Tmk1OTVsZ2orTVdYNlN0NU85NklZTERTUzRCdU9K?=
 =?utf-8?B?VEtXdEN4aFZSWkZqekVMMlZDdFZ3LzMzWkdJOVJVRzExYnVubkt6ZnY1Yi95?=
 =?utf-8?B?UVIzR1J0bGxjK2FwR1oxczd5b1JUdXNsV1RUd0ZJbThLN0lFVVluMXc3dXpM?=
 =?utf-8?B?WWNPV3QzRnZWbHNHZGl4azBPT1FhRHRpeTEwT25VemVyWUQrSHV6dU55OGt0?=
 =?utf-8?B?WVlYa0Z6UVNVbjFEMEtHWTJzbUZMb3dWVVJwSjFzbVVVV2JNSGpOVmdURndp?=
 =?utf-8?B?S25teloxdjBZbXZzcHY0cno3RldmWHhoUVBqNzNhT1R4VEc3TldXTEY5VmVS?=
 =?utf-8?B?L1ZhWjRYRVg3MXR4RVdmc1dFSVJ3ZHpJdkttVFozdjZMWThzZkF2OG94NmNE?=
 =?utf-8?B?Ty8vb3cwaVlIMHpxMHpSYUFIVldtOEJYYjIwVXUyS2xCa0Z4TDkyK1ppRjhv?=
 =?utf-8?B?R21XeUJuYlpIMHVGK3pEL0NHWDJ4dDNmK2IxR2lrSy83c3A3NWZDL1RjNDZB?=
 =?utf-8?B?eVVLdmJUUERMSkRZR2tHMmFsWEhaZnBiZFFoYkE5L0hJcnBucXhuODlrMG43?=
 =?utf-8?B?REFwWm5qY2w4RmJPQnYyNnBnL0Q2bCtNd2k5Z2NiZlhaRy9iRkVQTGhyQVBz?=
 =?utf-8?B?VmlnR1N4dU0wMDhPbjJ0Q3hJVCtzUTJRVmVwYzkyT29GYVdLRmVleWFrYnFt?=
 =?utf-8?B?K0VydFZDeHE3SDV5Tk80QVJyalpGNXYybksrK0pGeUNBV3A5aHp1bXNneTlx?=
 =?utf-8?B?anE1THZFczdjM05MRlIvL0ttK1d0M204R1R5QUp0clE3QjVLQ29PWkNkQnd0?=
 =?utf-8?B?dU5sT2lZckRZSitsVk9xMjFycW5QUUhDWTlaK3ZneU01QmFweFVLbFhEZU9j?=
 =?utf-8?B?amQ5ZEo0RFdsYTd5MXYrVUZMNGVDNjVTdnlMVHliSkhSa0dHK3dVSnkxUUF0?=
 =?utf-8?B?emUvT3o2eXRLZmZ6Yk1wbzgyNGVYU2FxendpeDZwVTV0Z0F1dTdyTzhwaUZl?=
 =?utf-8?B?WmlXNmEycGJ0WlRSdzJDSjdPYXFIVDZCNEJkbmVxSGprVFpib0taVDFxdS9m?=
 =?utf-8?B?NmRNNXFaTFRwcnZvOEhMUENDYlM3cFRWd3I1SnI1SnFqNDlsS2t5Y2hHd0Vz?=
 =?utf-8?B?NFkzN1VqeG9kenZqcnNlbkkvL0Exdkp6Wng2WWlXZWdnOTRNSWM2Y2RuanVH?=
 =?utf-8?B?UEwvbWI0RlRFQ2ZpT0VOYkZ4THBaUkdHTTBaVG9xRkYzREk2RGNPa2Q4bjB4?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a023b6b9-e51d-40ec-f050-08dbdf94bfc4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 13:23:37.0679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kldQ3rA+ZWbaLrsj9klCSTAvm2OjMdO4P9wORmMshDQU9IMpwAoriju9+4wi+gjgiLB7/qqH+ule8c4v7dJHpYVjinYnxGeAuiGkiIwH5kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 6 Nov 2023 20:23:52 +0200

> On Mon, Nov 06, 2023 at 05:31:34PM +0100, Alexander Lobakin wrote:
> 
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202310170708.fJzLlgDM-lkp@intel.com/
> 
>> Not sure how to approach this :z It was also captured on the version you
>> sent 2 weeks ago, so this could've been resolved already.
> 
> Is it in the repository already? if so, we should revert it.
> Otherwise you have time to think and fix.

Nah, neither Alex' series nor mine. And I'd say this should rather be
resolved in the functions Alex introduce.

Thanks,
Olek
