Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394FC7D4BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjJXJQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbjJXJQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:16:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0F012C;
        Tue, 24 Oct 2023 02:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698138969; x=1729674969;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LqxnPVNZacQan5rNVWNs2+WP8yp3kSIcOAco8O1mmrY=;
  b=dBnP0z6Xp1Q8BFnlCRfbdEko9zhFkY0e2iGwwPj1TeZdISElSpaA1Yjt
   V+O1PlBMVcK/1LguhU4p0ylFWsVE3xaqHuSz8KjLmJic2vc1+iQHeQ4y3
   zHu/60LaP9PxPOimg1I6TOOZRcnHaUvMBBFgEpOMYhuogflOHeuIKlQRA
   LtaQuUN+FHJZ3WEhKGZvg7WbVUdkt0emEuusjTbOnsRM5dz6x60RWVYTJ
   PD9hJElRC4+CWW5F86ViwewAFNlJrn1sExLYSbZ+J7H0m3eW2+qUCo2P/
   Hsc62CBDym1lB8FAyxgyN9tl9t3x2ssN9Fm/V1bpzv3un3SmQ06sG7tfy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="366362294"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="366362294"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:16:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="762042580"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="762042580"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 02:16:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 02:16:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 02:16:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 02:16:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 02:16:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/GmEJd2Sf+DaKjpyTB2kiC0xmfvhmlLP1l4Jve70NFsnj13N8Q3U6YbCBz/q1mOXZzlyP1pQqvgBCDip5ySFAsygq8Y6mbuGbe55IRpNJf0n6dN9B6W6tyPHXtVXvYxLjxwbDDNmjRJ605WwwClHgP6zsX0MSmf+Zgs1BjDOaWbg7RXZjELYhyz2J9kYcqviv95OQyeJ8gmZMI5EAqpVpMH7/tZ91R8WNsf68tSvGv6FIAPioaAPcm4XH/qAVZXl7bkBPInXJ0yeyuajrnbLlP+5G7tJNc7PWraUSxv8gVlVPOb1a/KQrfu0KrP4PAqlbHuA7UT/n3XbSCcee4X0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyTeYGeWuXBKnbjsgbYDBeaT0pvRadRj8uH0UChgDu4=;
 b=Pfc+cWRhnFe6BMFSEUd2K2GqDeOwphl4bb2w7T92d2MA/eX6Q/ctU7zetHMnxIVnH9+85yR0q3SsF2Qkyw5h8Dft7MOXXTZKdvM5Mo+Zvu8aUHJzXUy8JEHyT8ERWvIAw5+MPyvQwKARm6mfRjOOqps8Fv5jxPcObn//AmV3Qc8uuDM6xTJbNnxvG2lAYHBZCVbqJYVeb5ZHKgClsCXbQ/pJ0vcpQhf1fn50dxhXDGpWTDaueMqY1EF2JthlrlDEcFOAldWh4iKOQfL5VaQhaDP5/T8HJVAH6mHCEhBDyKHqPhwyGE3yL6pMG8FgjQy3cQevnQjVrwHKP5e5TG8iDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by PH7PR11MB7049.namprd11.prod.outlook.com (2603:10b6:510:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 09:15:57 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Tue, 24 Oct 2023
 09:15:57 +0000
Message-ID: <9c7f1643-2384-e458-23c1-8cd2326bcbf4@intel.com>
Date:   Tue, 24 Oct 2023 11:15:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] checkpatch: allow tags between co-developed-by and their
 sign-off
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        <workflows@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>
References: <20231023102846.14830-1-przemyslaw.kitszel@intel.com>
 <CAKXUXMyOk+06ZRc7gvYMA=KHvZZp1FXiCJC5Tp9M=SUQfQnBVQ@mail.gmail.com>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <CAKXUXMyOk+06ZRc7gvYMA=KHvZZp1FXiCJC5Tp9M=SUQfQnBVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::20) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|PH7PR11MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: c48c5417-a687-4d31-8ad1-08dbd471d41f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: deAdNPnmFuh2X5+GmSxW3MWseHmQiCtxo4yBFtq0ihtv7VkPWG5WAzFKklqEdoMB9VAbSGIG/6Wot+ZiOgHMMZgpusAcbcFXrpfdnm91WXPeLdPkVhoZFwGj+yc2+Sjay/lEj0hKCoO8GfiE+880wfLHDzGYsa4tyYaZnMKXdEOZdMyHcBHiLAopUZ16oNI1tCakvpkJoWofNkD0RueDbujZ8doLfDPCMk7DZZxui7nVQsDHlCYAsVmfZxL2+JwDJnI6YeQOMPJVqgRk1dJ/5bhH782cOJPGSKAQaBCB6pJRK+OTBOE6hmJmTeAAEuPVDiR582NZ1lUqkC0UFYV6fTDS8319UHpG1ndfh24YO9CkeH5Xcsjdkc836wuiTSljhhHnvr3lA0HhfgdJR6Zr9ElBag3gWByAMVIaEIOEYtl2pRQOvQLplQ6czmqiUglK4idMltR06+mKjcCgx/SOCidXpC8skOuWRo9BgmzMl57EAEREijTPpFGZwmWhPCYlABWk7Rz0zn/u5qj/OB3zGUV6BVy7iMpzZRna3zHcUtSwX3fO95FSVxR675Cvm1zq0B7sWWqC7X8EDXv78c6MCy8lYkRJ/v7JlpzLSNXdraykL4FKwneU4F7ELxstYyYkBYTkiByYckzzyUPNvd9MGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(107886003)(6666004)(6506007)(54906003)(6512007)(53546011)(83380400001)(2616005)(2906002)(6486002)(5660300002)(4326008)(8676002)(8936002)(478600001)(41300700001)(316002)(66556008)(6916009)(66476007)(66946007)(82960400001)(86362001)(31696002)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFh3dXV6YldmYkNaYXVYMHhPZVVGeFRBMnBiYVZmYzJvQnR1UEhWMGhCbURR?=
 =?utf-8?B?R0RqSWNLamo2WExxL1dGWEhEcHYvbjlBbVdsNlNzcVo0NzNLTCt3UFBjUWdP?=
 =?utf-8?B?dEQ1VTdrVmNSdjZ3Tm9QOEUvSWpiV3dPcldYUUFOTUFXbUsycnNBRDlZWUN2?=
 =?utf-8?B?Q3ZBd1JJSGVvbG1OcmwySkJ1SU1FeFp2RGJxV1BTNHBWSkRhQzVNTkNPdUg2?=
 =?utf-8?B?dkVBU3p3SzJkbGtQczFwRmJRdk9WUjkxbUtIckNQeW1wQURPU0pKM1dXVFRU?=
 =?utf-8?B?cmJGSk5GTmVUSmdKSGc1VUl2bDNGdGZyVStCRjN0YXh6d2RsU1IxN1MxcjEw?=
 =?utf-8?B?b1hNbTZrSnJuUzVsR3dVdzJiUE9IeVRWMGZzc0R6SXdvNlVlN3hXckhieTlt?=
 =?utf-8?B?UDhEd29RU1ovRG5ZbTh0dFlaRFUyTEFqcHJ0akhuZ2tkTjhDbG8veDRyVGhu?=
 =?utf-8?B?a3Bkbjh6SHVCRUJrb3Vnc1o2bjRiMVgydUNvdDZYTWN2RWtKUE05SkFUMk1u?=
 =?utf-8?B?dVpzUTl0bzFQMUR6bzBSZDl6STc3TjlBRlhrc3lLRkN4bmticm5pSXB5aUpl?=
 =?utf-8?B?dHNqTzRReEJlNTdHd0VveS9HM1VqOHhaN21ZdC9zTmhkc1VHVGQ0eUZ1Rnd0?=
 =?utf-8?B?T3lJd0Q2d245WDFPblNYaEhiWlA1aCtpYnY1S2xoUG1kUWxBdVE2SWpMZDBX?=
 =?utf-8?B?Wi90YkU5VmlMR1p6WGFLT1dRdzFwYUFSc3ZjZlJqdmVzNVgyZlF3WGE4dUVI?=
 =?utf-8?B?TkF5QkE4dk00TlFxNEdaMDRObVhEVHRGZnVwbDY1eVdFNmx6V3U4eTV4bHp6?=
 =?utf-8?B?cEw5cFdTandJelp1VDBCZlB4QTdmcFdkdGlHR3M5ZWFYNEtZUmtHazFOdWll?=
 =?utf-8?B?eDNuU3g2T3lEeWQ1Vm1ZU0RkWEg4dHJPTkt6cTRBYzlwalh5Q3BPZlFtRmNu?=
 =?utf-8?B?Z0F3UmpweFcvNHFiMXdOOWNzcW56WUgxNk5oTnlaM0k1RUJoMjdlWlJ2UDd2?=
 =?utf-8?B?R3RGcnNuYmhGS2pkdDJiNnFiNjE4b1JZYVdUU2J3Ryt1anZlUWg1bEU1bmE5?=
 =?utf-8?B?MENWK29FTzhuY01HT2dSZTdEREY4UFBndVpXNEZPbmRvdW5CQWQ1b1VuSEpE?=
 =?utf-8?B?eVhDeVYzdGhkdW1RdVRxcS81dm1MWjRuZTZSekdxaExXcitGL2xWL3VWbmxW?=
 =?utf-8?B?THJuVVlVQ1BGVUxLbFFIK2NieFM0NUx3UW5IWHFkZEZ3Y0pqbmlCdjR3SC9D?=
 =?utf-8?B?amNhRWRSNGVvWHlQNkoxUUxBeFA0ZjN6c2l1NlhSRlBvRlgxdWY1YzhLelY1?=
 =?utf-8?B?aG1kOXlGZ0hzRVNpQlZhNlQ2dGFTaExoN1hYOFBWQmpKN3NkYXVlS1FJTzRM?=
 =?utf-8?B?THRNR2Y1TGxNais2SkNBVVZ1SGFtWjRTQjBiN01sNTVRclhpZ1BuaWVoSnFj?=
 =?utf-8?B?RFR1NVRoNGJGYXNueVpLQWpRd0kwOVhpZC9NN1VGdEtGaFZKY0hTbjRkbWsr?=
 =?utf-8?B?VFNpaW9lekJlcU50UTlyNFo0QW0zei9EdENxdFY5YXBVNlNSenMrOXRRSHNL?=
 =?utf-8?B?SXNIeVpBZ3NHcGhSdVFqQVJBL0JaZ1JMTFkxWFZkeHNJZE1kQ2lXejBnYUlU?=
 =?utf-8?B?dkQxSzJBamthVndGbFB5UCs1M1haczd0K3lRb0hSZ2I1WEFONlFZdmdWMjRE?=
 =?utf-8?B?UXVleHFTZkFMSnhHYUxuaHVKendqaXdQK0F6UXNDdVE5SWc5R01va3o5bHFm?=
 =?utf-8?B?SFRFd3RkMXo3MUZQSWFiTnJTS1N0dzlJOTlKOGtXM3l1Q245OEdiVXE5U3Ru?=
 =?utf-8?B?d2FxcEN1dm9VM2orTjQ5dXR0QUN4c3gxY2tjVGVnQ0IrUXFSbkNWVEUwa0Vs?=
 =?utf-8?B?aElNYTZFWVpNMjBVS3BxZGZrV1dNMm5ZRWVxb0FFbGVlL1RLOTgzUTV0WEx3?=
 =?utf-8?B?cEpNWnlTb3VWbER0Y0xrcUlYTHphY0NlN2kxdTg0a1lmb2d1L2hxZUIwQ2lK?=
 =?utf-8?B?K3UwV2VtRmlOVit0Y2txT0lUUk9UWHd1cVV0ZHdVVkY3N3dkUTFldzhPQytF?=
 =?utf-8?B?RWQzTTJaTGo5OGZwYTZsOFNWUzlOSFN3MW9XdGlKQUJ5QzlPdW1nQzFVVElP?=
 =?utf-8?B?bXpYQm9lUHcyaDNMU0paN25RakxjTHNVNnNwbytqOUVCWFV3YnVJWDZ0Z2dz?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c48c5417-a687-4d31-8ad1-08dbd471d41f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 09:15:55.9785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jg6bsf6me2AgfUlJzjVM/FvtfwHKSnJTzoEDKk2fyGmnvElftiVtEIiiiK/OFmzFpyL8Gou8H1BjVEprlqmgyKNoQldomCrcYQ3TpEb/DqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7049
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/23 16:16, Lukas Bulwahn wrote:
> Hi Przemek,
> 
> On Mon, Oct 23, 2023 at 12:29 PM Przemek Kitszel
> <przemyslaw.kitszel@intel.com> wrote:
>>
>> Allow additional tags between Co-developed-by: and Signed-off-by:.
>>
>> Removing the "immediately" word from the doc is a great summary of the
>> change - there is no need for the two tags to be glued together, barring
>> ease of checkpatch implementation.
>>
> 
> I think the currently suggested process of keeping Co-developed-by and
> Signed-off-by glued together is good, and I see no reason why this
> should be changed, nor do I see any drawbacks.
> 
> 
>> Additional tags between Co-developed-by and corresponding Signed-off-by
>> could include Reviewed-by tags collected by Submitter, which is also
>> a Co-developer, but should sign-off at the very end of tags provided by
>> the Submitter.
>>
> 
> The other tags, Reviewed-by, etc., can go anywhere just not between
> Co-developed-by and corresponding Signed-off-by. So, why do you have
> this need to put it exactly there rather than putting it anywhere
> else?

Multiple times during review it was odd for me to look at thw SoB of 
submitter not being the last thing, and that's the result of the current
rule - co-dev authors put collected RB as last thing, only to keep their
CdB and SoB together.

> 
> The commit message tells me what you are proposing, but there is no
> rationale in the commit message and that is put up for discussion here
> with the proposed change.
> 
> I see many potential areas of work for the checkpatch script, but in
> my humble opinion, this really is not one of the rules that needs to
> be improved.

I started the other way, identified what was pissing me off, then tried
to fix that, despite of requirement of writing in perl.

> 
> Lukas
> 
> (...snipped the rest...)

