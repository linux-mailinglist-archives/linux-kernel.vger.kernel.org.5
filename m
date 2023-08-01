Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF0976BE22
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjHATvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjHATvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:51:06 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648FC2115
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690919465; x=1722455465;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=OCjlTcV8t7npJXB0qj248jQN1CJ2rE+B25JACd2JNIA=;
  b=ST6Ek7cXiKW0oAnyALwdw9HWH6ztzszE/UHMZJqr44MDhnCRnfhc/cee
   szgUkhwOX+aH6xVVeY0BkBlh0/KVgDJzExt1l9vc7SEF7l9FVP9P29XnH
   WC3eI5B/ft91sQG1P9ZduwDJKif35j5B1DHYbXzBpPV43C0wxwQonjXJ+
   NzD/+pF1QaHtJX0DtXmsBUhJQlHpIoz30Y2aga+jvmHT3PizXb3eTeIIn
   i4ZGjxCvInWSzEzymimgFwoJH+VRaLHqg6toGGzvxdhspK87ygsk5hjBC
   uG6uHWWuJ1tI+znjViqQV2GIGD2cvlJg2jlIaoE044rHlIoLmrAjaoXVu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="372127999"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="372127999"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 12:51:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="758465065"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="758465065"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 01 Aug 2023 12:51:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 12:51:04 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 12:51:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 12:51:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 12:51:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIQJmLRe4vEj1YSXvIJaiHtqJPzKwv5SQpW2blIiLD3jeAJyWWNM3tHPvOxikLyQ8WoiH44gdeLjeGhIj5hXw4ob56/20wQ3r3L13CZIHO35Z9KNv5HERQc5qYxZlPSfb58Tz1U2MTtFp6e8Wv2zz9UY+/ys14mLK7wsrWA1LOVYxY5Nc5YP94YuyuMGfCiCnAmSmZeeXo99LZ9wyIp1LEzzH3+QC6LgfZDCR3A0CRes8dRJ342f7ytwFZM0pqGMUy03UoPLeOGTWuS9MNKxFy78/MZAh2Xpk/moFDK/v7AFFQoBgg2Fd5+9yohR9yAcJhCKrtYa1MjTv+y1eTANVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnIYyhcWGRvGVLuz0JnWy44BOQGIjunh735lbJccoF4=;
 b=c38P6oWYthOmPDenPC2yXjhEWYDUeYsLDT5iG4K0nYc3ZZW0lp4NXNNcSOsVv6coyCoj4FOf+pnvueg5THTbn7Eh+LKmqoi5XVYfyAYok0y9p5DBgfDdiLdlKYUmC6NvrgooJK68skARXzBODCwOii6IwffdDSFkBhrd3HlFOw77ZgxTUc9njUghIaoNPvJTHpwjjws0iZT91PjGhAXQQp+XGpfzypJ1e1iJeHw5mHQxRd2WWHv2ae410kXqaBOva1Pgh8xM8yPorhmkfQzQJg66Bvn0wwocCSbs/xFqjOkwEvHKRFyaaHZp16UtVUc8B5GhIXUzhybm58/2OEB48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB8083.namprd11.prod.outlook.com (2603:10b6:8:15e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 19:50:58 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::b5c2:7049:2735:2943]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::b5c2:7049:2735:2943%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 19:50:58 +0000
Message-ID: <24f0902d-3375-b0de-e985-6174c70b394c@intel.com>
Date:   Tue, 1 Aug 2023 12:50:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 00/12] Enable Linear Address Space Separation support
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>
References: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
 <d6b79dd5d85a30baf2eb138036910890fb060e52.camel@intel.com>
Content-Language: en-US
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <d6b79dd5d85a30baf2eb138036910890fb060e52.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0050.namprd17.prod.outlook.com
 (2603:10b6:a03:167::27) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f071df2-298c-4574-f3a8-08db92c89ff5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZiSFOEMNFI4PjWpg/ZJgDeI+KQIn8F9T6T0XIYgVwuUuapdvTOF9uN3vBT2uWLeaRAPY8r3eJ4mG/oggzTmakrec4EiaukRrBZVWj+X65hEjdp+Fwkg164QH+MmffcpmnWLwFmUCesbm3PLm63C6Mw7MBQa01iDoembHMxo0GCeOtGWbtkTHct5jDsLkwjTyx1FqczCpzv0HhGVgZnVL1pNaLuFgOsuXjg7725CwUgki+syt6+fJ+T9W6zdYmRiqrD6w7r1K+LX1KxPOzVn7d+pBYoaeqdkria87+ITCW5/70THL5+w6+0MMcPph2n5NwV560QakXVnqUvC5lXGulUM9+x1g3GVnHbsV+EcV0A9COgebHxB+TJ+zTDYDNQIeIcYy+E+y3KofVYaWhfPUxcxXnicbXqerqq25MEINnuth8hB8XXgG5qdMif/AC0atob8GsMhDU7QwUr2q37bbnjXLa9N4aI4+z11tHi52uQGo+o4hUqWk5lhQRbdCPQZQaLQfWeDHSvl5soIT0Fvd0yy3NhqFQvMf2Wo2oj/2mq8+TaO2l3RVMi99pZka6lfxofviT0Xt9fof4vC1o98jyF+YQZ43K/VbRw/ZPHTfxeyL5Znzv5hIE9Qq3GbZZxT4454xHtLkADGbbDp4k/i9sPDOO1FXQsSP52ODUMdzvs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(2906002)(66556008)(66476007)(66946007)(6636002)(110136005)(44832011)(31686004)(5660300002)(41300700001)(316002)(4744005)(2616005)(6486002)(26005)(8936002)(6506007)(8676002)(53546011)(186003)(83380400001)(82960400001)(921005)(36756003)(478600001)(38100700002)(6512007)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1JFeit6QTZyVUxBNHhxODkyTHpwaEdjU0RrTmhyRmhjcGZtb25ySWdLaUZE?=
 =?utf-8?B?L3djbEFvS2ZmRVdtSTZHQmk1MkJvQll0S0k0U0VGdExmMEdMQi9oR3FwaXJE?=
 =?utf-8?B?dDRjQ0JqZTA1MC9aSm9nOTZ1eW0rbytPUG9lYkptd2dWSExrWngzV1Vwb2o2?=
 =?utf-8?B?SUJOSmN2RlRERmpwNndNS20xZUVwbmlmd3VFcVM4djArcVo2MXVkRXZwVFFL?=
 =?utf-8?B?T29ZMVdkeklXRGRXbVpMYnZZQ29pd0xkQUtKbEJ3VXEyWjlhNmx5bWhEQlR0?=
 =?utf-8?B?Y1BPejdnUkdNKzloaGpkUlZiNFVhZGx0T0xPUGd2RmNrNnRSTm85L09wbVJY?=
 =?utf-8?B?d25FVkN3SzIyU0VYMWR4cjd0andKQ1crYk5ZUFlZdkZYYkYyTWM0b2NiSUNu?=
 =?utf-8?B?b0d4cWJxUXUzZVBTWGRmbnpSSDVqUEdCb0pkbWs3U0REMWg5blFldGV0VmtF?=
 =?utf-8?B?eVhjV0N1KzI4U21VMDRxaThpczhudStWQklab1NyRmhldnd3TmtUc1VrNkpk?=
 =?utf-8?B?RHRqMHZwRFB3Qk9wU1d3QVloREw4N3ZEeVBWMWZkQVNYTjR0Vjd6c3c3ZUFJ?=
 =?utf-8?B?L1RNQ1ZCeGxsNmFtbDJlUUxYUm5zZWg1S2kzNVlYRUJKWHYxM1crNDlYYW5V?=
 =?utf-8?B?eTlkZnVCYUE4YjJkblZpbnBQOWpuY3M0Vng1YUVLMmxJeWRvK1pqRy9UUWtj?=
 =?utf-8?B?eWl3WDVZYnVkR1ZGRWxUSzBkVDRRalNWeXJHL2lCSkU4bWJuTmg3dFh1NjF4?=
 =?utf-8?B?disxdFNTQVpRNnNnVjV5RUErZXVMN2trbEVxMlFuL25GRXJxV0RhMU1SOTBz?=
 =?utf-8?B?RTVNMUEvRFd5OHhnMnZ4RFdLRkxNSVVrdGZJTVMzY2hYMTFxOWxaMVh5R1cr?=
 =?utf-8?B?b3ZEWjZSam80L2gyS1NkdkFVZjFtNjRSZnpJdkZOVWFubEh2SmZEa2Rod3JK?=
 =?utf-8?B?OE1wTFBPRlNIYkx6Qm1mT1VsaGg2YXUwS3FxNlNGMmJ4dXdnSVhWS1Y2MTUy?=
 =?utf-8?B?TFEvSFA3WWcrN1lDQ1U1ZnpMTjAxQ0pKc0ZUTEFqOW1lTUR1UU9aeHUyeDMx?=
 =?utf-8?B?SGhtZ3hsT2lUWHQ5TVl5SDRJaHU2SW9NUDlaYjlEN3A2bzN2LzdaSDdFRkNF?=
 =?utf-8?B?M201MHpsZDdlK3ZMQzNhVGxUQzA0R2wrZytlT0N1TGNzYndWRTlCY2o5aTRD?=
 =?utf-8?B?a1VleTJzQndEVkFaL3A1elB3bWVSQ3ZsMVN5OGZHNmp2R1Zkc0dGRjd0dGVB?=
 =?utf-8?B?RTVyZWdKMTlLTDN0UW5ZbnV5MFNxOVpFOTVUVit4cEVIejZ0eTdXd2xBUUo0?=
 =?utf-8?B?NXB4bXBDMWdySGtUbmZ1MEx0SksyR1ViekJmVXV4WThYVlp2L1oydkFZalVi?=
 =?utf-8?B?eFYyNWJNdXk4Y01LWUtpVnVvMlJ0MGxiUmVpRWFWVi9YcjFJc0k3ZGVMMity?=
 =?utf-8?B?Z1V0cDdGU3FyYTJvd2xmZS9NLzloTy96ZTdCaDlNK1loTzlTd0MwVmUwV2hB?=
 =?utf-8?B?ZW9vazUxYnJqR3g5SDEvelBPWUZOa3lqbGR6dzgrTXNla2I4bUxTUC95ZTVm?=
 =?utf-8?B?ZHBNa1ZEaXdnbWZJV2Y4eW50QU5YaHpodWphbXk3Z09KeTQ4TVBUYUhCRlJG?=
 =?utf-8?B?cW5FWnAvMUpOMUZSTTRkdzQ3V2wxd2RYZlZsc0QyVUJEMXdjYzBMTXEvcnNs?=
 =?utf-8?B?Zk9YL2YzbTVqOS9wSmIrelhyK2dNaG1PaHZ4S0pOcDFPb25kRTdDcmFoUlo4?=
 =?utf-8?B?QzgvYlNmb2VkNFo1MXgyUVBrWTlrQTQwaHg2c0R3TjZkZ1k4THprNFZXdU5x?=
 =?utf-8?B?aDdoTDVCSm9EWHp5eVZ6UkEwMVJxUVNwdzQ1N2ZGREE0TjR5OVhvZFNvYnQx?=
 =?utf-8?B?aTR6aHlNY21KRnY4VU83azhGbHhHMUlQSmltS0RhWG9zSjJCdm1icWpFQ2pB?=
 =?utf-8?B?ZW1SY0g0Uzkzakd2M1RxOWhIb0doYStsMEdGbTZCRXVHdDV4cmtuR3hPaTJI?=
 =?utf-8?B?a1U4TENTWWt6Zk1sN253QWFHbzFYZml2MTM5Rzg5ZDNHck4rRjJDNE9aSDF1?=
 =?utf-8?B?ZmFENjYxZW9NOEF2Zm5LTXJ2QjlyMWp3a3o4cm9nV2JiVmhPMnhXRmw0L3hq?=
 =?utf-8?Q?XduC3eFnc2mR5cvY0ttFzUOJj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f071df2-298c-4574-f3a8-08db92c89ff5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 19:50:57.9429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEjLTjg0dhyIAnTK1RZIX25E1q+RWiHvtslakVA1oGgHdp9DKAdSoTTID0buMSw7OY7HMOYKV31uIdmI/WoRiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8083
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/2023 3:36 PM, Edgecombe, Rick P wrote:
> CET introduces this unusual instruction called WRUSS. It allows you to
> make user memory accesses while executing in the kernel. Because of
> this special property, the CET shadow stack patches don't toggle
> stac/clac while executing this instruction. So I think LASS will need
> it to behave more like a normal userspace access from the kernel.
> Shadow stack is not upstream yet, so just something to keep in mind for
> the future.
> 

This is a good point. We should definitely test this out to confirm.

But, isn't WRUSS already defined as a user-mode access? So, in theory, a
user-mode access to a user address space *should* not be blocked by LASS
(even with CPL=0).

Are you suggesting that we might need to do something special for WRUSS
with LASS enabled?

Sohil
