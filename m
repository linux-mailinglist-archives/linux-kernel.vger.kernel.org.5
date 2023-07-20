Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5AD75B812
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjGTTex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjGTTev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:34:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9D21B6;
        Thu, 20 Jul 2023 12:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689881686; x=1721417686;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VPohRliqRaN0HEOQlKROxk0Jdlk6iojl/kDc91xhlzA=;
  b=R36FGXjdfDjBpNSoEz+ArBibgj0owknlFS9HjZXN9jY9/0cNDjuAI7Ku
   qwoVpnj8EuuHWrj9Hp09l0x02pLqGRyEevOsleBIjXeftDkxIpIbWyFZQ
   Pl89iXahMZBTmH4ole+vIMcu4EuiNK6ZXielArZ6RD8NEza4E1ZqD2wnl
   108FX0MiCjSTlpJIGh9oPsJNigJaD5Jtpv/loOHdh4bo/JSbH7wOZe9T7
   dlgSjbvoKaign7+V4ZlJq8V2NP7nb74F9LCAZkrV4i1ySvXmoqx8pPAhr
   enL2G8IXQ+AqldfircmYJURhXM5SyBjKoSKxD3gclaPKwiQoZMvZbcu2B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="366882633"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="366882633"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 12:34:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="838254924"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="838254924"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jul 2023 12:34:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 12:34:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 12:34:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 12:34:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PN994TJDiAkQAXVVIGjONr8ic8c/8XoejHbPjCcdrfQV8SmTygKh0mC0FcadrGDxGMOIlQef7MmTyc4xJmNtXU7zlSepFuVZyhOOUO71I+gZU9HoxRz5giW7p/CGzh/Wk2fDxn4VQg063D/fzfrpfIx+Eh57puNIbAspjMnBKwACAYlQArnMHx0Q7mA6cM4ynW43a8emnlWpjZRAed0IBLwnIJvUcff69gbUGemPQJi8E8y6/FQUhNxfRKwOM0ahgNDSDTR8iXeUwL75mkPk5Dp37nWXzCGajBvSrMIr3XQ07hZHZdslktnjRly/pljCNtRUVu+DtdsyFpqDtDFFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nccfjSsezAM04353ActkJOw3zJKKWPDjFhxVo99rgTo=;
 b=iJJPPzuTvW+fCSnhHni9eRa3Cy5HBbqueXQiBgWDsLfo3UCHXGuF5N8TfbHQwjlQvnXQ/8rq5RKb0XBV5llD9z3Tv2uAhxi6iRrfm3rZLTg3A6kzY7dv6M2TGLD/v1UsCDpFU92WZMsVyFExJDQrhCcJjWvKwc1N89o9XPmj3XIYVXxA6dmgow8iuSLG99hVVgmZUrxPk09hhM2bpQybDBl9mp+Z1pLgOEb6KmOODYbIDVXgdQ0kWxLC5augK/Rw4fdgJlQJJk+f9+Dvo33rgIxRiv9QtvnUqLR9jh+g9gFSMM4tIo+duNM7eqVlBfJrVJrQYigS+BKI4BO3yxHQGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Thu, 20 Jul
 2023 19:34:43 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 19:34:42 +0000
Message-ID: <e542f6b5-4eea-5ac6-a034-47e9f92dbf7e@intel.com>
Date:   Thu, 20 Jul 2023 21:33:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next v2 7/7] net: skbuff: always try to recycle PP
 pages directly when in softirq
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
 <20230714170853.866018-10-aleksander.lobakin@intel.com>
 <20230718174042.67c02449@kernel.org>
 <d7cd1903-de0e-0fe3-eb15-0146b589c7b0@intel.com>
 <20230719135150.4da2f0ff@kernel.org>
 <48c1d70b-d4bd-04c0-ab46-d04eaeaf4af0@intel.com>
 <20230720101231.7a5ff6cd@kernel.org>
 <8e65c3d3-c628-2176-2fc2-a1bc675ad607@intel.com>
 <20230720110027.4bd43ee7@kernel.org>
 <988fc62d-2329-1560-983a-79ff5653a6a6@intel.com>
 <b3884ff9-d903-948d-797a-1830a39b1e71@intel.com>
 <20230720122015.1e7efc21@kernel.org>
Content-Language: en-US
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230720122015.1e7efc21@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::15) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|LV3PR11MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: ed85b46c-393a-4c7c-b65b-08db89585d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RDMMNNtKeMtQ3Zj3SlpDUHrPOC+sCxvAp8kW6x6AEFa81g/kvym4jsvCrenroRmNe/OeiKwspvSiFxTUPb1T2MbQAFFSu7xfPZ7+04YZA4nr2W7c5WoLetHsHk6+xeFtaTz0Rjf2oS05HbvtbrVZwXjfjOM95AE1Gh0rIOt3N/+/H+7SSKGtcrfK1zl8Ube8Y8glXqRvLFFCbVzOjImcWY0O3Z9+gMsYzq1aJOEzbza4NGkVtyd3/YPwLn30ysCE0Q5TsjIRncb3rDg6qiprhPdI6QAtiR5mp2Y6SpDJ6HwnTJPQc9Ti51CHV5D1ny79pjAMiw+1A4L8bXf821h0e54M8Ta11QtA9I8sopCDIb/ZEV8yiFHicyy3bhL8PJsUFVH4g8E8QeuN7vxFt1VIwymWiGilJXIWEdPI/6kLC3WiTvo1NmnH+WTvmyawK4LJeI5cWA5i3SbZuAwU/JpavKzlMPe9+vlsrjxaRBseAteKWOpjhLzUD+cI5NfAweFNljg53Q/9ECZgF9dqXu9uk6WAZed/SAtBSbbxwnVgTBGBTXgIkZzIVVkMP2olhhGi8hKTXJVpt1TkX4rOiHTDBC2HJtSffuxdMXdATdkxkT7q9Nfgvc5M+KFXOG8IeHSYx7sEwCt412A9i9zxImudCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199021)(26005)(186003)(6486002)(54906003)(82960400001)(6512007)(316002)(41300700001)(66556008)(7416002)(8676002)(4326008)(6916009)(5660300002)(38100700002)(8936002)(66476007)(36756003)(86362001)(31696002)(83380400001)(2616005)(478600001)(6506007)(2906002)(66946007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEE5NVBOMUIrTEZML2NUbWpzYWg5SUNVWk5aTlYyc1ZSVVcyQjMvVFpqTUVa?=
 =?utf-8?B?MWY4OUlERC9hOThJalg1MDNGdEJVNGZlY2RlUkh1cUhBbStUdkdJNlJ5bjJX?=
 =?utf-8?B?a3JTR1NPc21WU3JxVytlNGovT0p0U0dYaHNFQVEwV1JlZjZRcWxlV29MMUxF?=
 =?utf-8?B?TG1xTDdtT2tVVWFJdUFIVkNnekJnZWhveDRKQ3F3MFBrRTJJVS9EWC9UME1Y?=
 =?utf-8?B?NFBEbXdCMll1NGIxU3NRMGwwZ2VUWWludTRZemYwMjNQSFpXS3FrWDdJQXJn?=
 =?utf-8?B?SlVhNWppSVc5VDVjekhLZjVBTlNidXlpSVhTeS91WW9RZzl2MUEyMzg5K1dF?=
 =?utf-8?B?K09XRXd1MXBFdUhwZ1ZVR0JHWWhCQ2NicUphbEVzOE5GZ1pNQ25LVGc0YWVs?=
 =?utf-8?B?QllpRU1YRFc5aTRkdGxTUE9nMWJ1K2RwYmMyVG5BcHpFeUd2T3FHWU93ZXZ4?=
 =?utf-8?B?TFpxOVovMUdMOXorYU1WdWo4ekNKQkJhT1lLd0QyLzA3UHo3TzR2eFJTa2hm?=
 =?utf-8?B?anNLRzRjUHVJZmNZZWhGZk5XQ3hoN3J1RXMzTUlzajY2dXdWZ0xJUDMxMXQr?=
 =?utf-8?B?Wjl5akYveUlISXUwL09LZ0NFRU9HdFFKc0hFeUE5WVh6NmpLdHRJSW1VczlY?=
 =?utf-8?B?TjRmaDBVL1ZBZEgxWjl6UnBYY080RHkxL3NtcGdNZmFQTkFEbHFRZTYzejFs?=
 =?utf-8?B?Z3JjZ1IybEl5anB3NmJMaUgzSnZxQkpZMFpmR1JTOEZaMTVJUDZySmN2enFB?=
 =?utf-8?B?M2dqZUxRVk9yNjVhSFFTT1F0ZVo1RW92UGZRZ0VObVlpMXc4czFIRXJDLy81?=
 =?utf-8?B?Uzk4NnZZWnB1dVZ3THhBbEZSalZBUm1aZ3VrR1FtTmtwNjV2eDg2Q1BhbUFz?=
 =?utf-8?B?NnF6Y3YvMDhUeGxNQTZwTlp0dzY5eTBiMiswWUpiZE1aME9LYjdaYlRFeEtZ?=
 =?utf-8?B?RUNpR2FlYzB3Sk9pMG4waWNtVStHMUtuRjA5N093T3JIazNGSG1tUU9QZ1Vl?=
 =?utf-8?B?YXA1bW5VbkhYb1JPdElYeDRJOE40cnVhRXI1cHQ4dDdLVU80MHhqbTBsQzRW?=
 =?utf-8?B?UGdpRHBhY0I2M080TGpnRC83eVJZNWpCc2QvbmhsZk9EQmwvZEhXbDM0RzJ3?=
 =?utf-8?B?elJZSE1Rell4bHFPSG5YNytsSmpnaS9uZU04eTFsbW5pajE3SCtldlBkOUcy?=
 =?utf-8?B?T0JveGFkWmtFQ3U5NG9JOGpkcndBdkMxWmdLZ05iUTlSczYxMUM3NmltVHAr?=
 =?utf-8?B?NWZFdWh6UVlTa29wazVxVHZHMGVKeWVVL0NDbnhIUWd5cVBwMWJDRU81UHBC?=
 =?utf-8?B?QXp3SEFBWUFzYTJpZnFPSlB0VFk4ZEoyMWs0eXkveHdLRWlkTEoxcitXZDRZ?=
 =?utf-8?B?UDc2c3cxTWVobDhCWmdiVTdRdlJhdW9yY1ZPQ2ZtVWJFaUNxUVpVcGVpVTFi?=
 =?utf-8?B?MHZ2RDh2eW50dGhSMGdpZExld2htY2FXWFhhM0dqcURXaGhQL1dBTmhxaVJE?=
 =?utf-8?B?aUVuUXlZbEhOSHcvMVhOUnpaYmlpU3dlajg5Yis4MGY3V1ZQejZZNjBwRG9S?=
 =?utf-8?B?RjJBdTdVUitrTlM0STZ0NE9TWGxZOWM3a2JLMEhiV2xzKzZSOC9xdExFMWlB?=
 =?utf-8?B?VUZPZ0t2M1ZJa0JrK2c3aCsySEVqRUNQVGNrVDNpNC8wTjJ2TXlSc1Fld1Q5?=
 =?utf-8?B?VlB6U0d4V2xlZWNPV1NHb2JwNnZ5SVRPQzVtYldNZjRqTzVqSEVsWTJ2MjhS?=
 =?utf-8?B?ampBM0JGc2oxQ0o4dUxvTDJjekx2NUVOTjQ5L3BKWVJ4MHhJZEVPbER4cERT?=
 =?utf-8?B?czcyVWtNOXJVcXZ1SkhYaUhqdGpOdE9naDcxYTl5L2ZIMXB0cXM2d2ZjZ1hU?=
 =?utf-8?B?anlwaTc5TFRVeFhsY210VTFsMGgzdEtrRDhrOFpsK29FQU9OWlNhTXEwaUlR?=
 =?utf-8?B?N2grNWY4bkpCQzFqVTIwMlljVVkwckRMU09tUDg3U29EdkV0OTJlekZ1ckRI?=
 =?utf-8?B?TmNMSDU4dnc1Z2VyQUsxTmNNSmZVeTdZQnFBT0IrbUhuQkdic3kvYmRJRDl4?=
 =?utf-8?B?UHNpNGNLd3BPNy9vVmFYQlhWcDlNZ0FvR1JMdXhOMFlEaXFxYU1od2J4NXpL?=
 =?utf-8?B?cm1OaFIxQ3RJaGVLcXF3dW1VMGVhYW1MdGZmRjRyOXhXUzRsWFNnVTNrVDdY?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed85b46c-393a-4c7c-b65b-08db89585d9b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 19:34:42.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2O9S6CXkHcRKwGNRMbU3jZ1+q3hQRgI8cFmX1EHkNbsldv66SFCUiFNGMmHnKLi3GYhlHLk7MLfdAR+vKcsWdlYRkdKvux+xIZ0wN9v9zA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8768
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 20 Jul 2023 12:20:15 -0700

> On Thu, 20 Jul 2023 20:13:07 +0200 Alexander Lobakin wrote:
>> IOW, it reports we're in softirq no bloody matter if interrupts are
>> enabled or not. Either I did something wrong or the entire in_*irq()
>> family, including interrupt_context_level(), doesn't protect from
>> anything at all and doesn't work the way that most devs expect it to work?
>>
>> (or was it just me? :D)
>>
>> I guess the only way to be sure is to always check irqs_disabled() when
>> in_softirq() returns true.
> 
> We can as well check
> 	(in_softirq() && !irqs_disabled() && !in_hardirq())
> ?

Yes, something like that. Messy, but I see no other options...

So, I guess you want to add an assertion to make sure that we're *not*
in this:

in_hardirq() || irqs_disabled()

Does this mean that after it's added, my patch is sane? :p

> 
> The interrupt_context_level() thing is fairly new, I think.
> Who knows what happens to it going forward...

Well, it counts the number of active hard interrupts, but doesn't take
into account that if there are no hardirqs we can still disable them
manually. Meh.
Should I try to send a patch for it? :D

> 
>>>> Right now page pool only supports BH and process contexts. IOW the
>>>> "else" branch of if (in_softirq()) in page pool is expecting to be
>>>> in process context.
>>>>
>>>> Supporting hard irq would mean we need to switch to _irqsave() locking.
>>>> That's likely way too costly.
>>>>
>>>> Or stash the freed pages away and free them lazily.
>>>>
>>>> Or add a lockdep warning and hope nobody will ever free a page-pool
>>>> backed skb from hard IRQ context :)  
>>>
>>> I told you under the previous version that this function is not supposed
>>> to be called under hardirq context, so we don't need to check for it :D
>>> But I was assuming nobody would try to do that. Seems like not really
>>> (netcons) if you want to sanitize this...
> 
> netcons or anyone who freed socket-less skbs from hardirq.
> Until pp recycling was added freeing an skb from hardirq was legal,
> AFAICT.

I don't think so. Why do we have dev_kfree_skb_any() then? It checks for

in_hardirq() || irqs_disabled()

and if it's true, defers the skb to process it by backlog task.
"Regular" skb freeing functions don't do that. The _any() variant lives
here for a long time IIRC, so it's not something recent.

Thanks,
Olek
