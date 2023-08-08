Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB61E7740BA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjHHRIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjHHRIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:08:07 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E613AA7A7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1691510597;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n6eM9+x4dbjVDnCPJGKYoFe4YXMHs/e0XrZAZZJGExk=;
  b=Xja9DI/uRqPBZthWccxyO3o9iohAz5tEG7J2VTr+dj/ZcjetImySLcz3
   SPAqsDlktSfxD914YyoXsS6FOTaLgYFx3ZI5wmj6uIn0YU30n+DnuMGpe
   d4QPqeXtxvAD30Ab/pGVbyr0eQaDv+OZ0e9y7AveOn1uV8F2MdQ2DPt7A
   w=;
X-IronPort-RemoteIP: 104.47.55.177
X-IronPort-MID: 121488691
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:C9JviK1gfSSujSG9NfbD5Rtxkn2cJEfYwER7XKvMYLTBsI5bp2dVz
 GAcWmzVPamCYGTwf9xxaovko0MO6pbRmIMxQQtupC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK6ULWeUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8teTb8XuDgNyo4GlD5gxmNagS1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfPDFfr
 6QgISIxQTOKq/+0wuiAZ7BFmZF2RCXrFNt3VnBI6xj8VKxja7aTBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxqvi6Kk1MZPLvFabI5fvSjQ8lPk1nej
 WXB52njWTkRNcCFyCrD+XWp7gPKtXqhAd5CROPpr5aGhnWU/jI3Uj8Qb2GRsMSXm1yieoJ1e
 k0tr39GQa8asRbDosPGdx+3unmfpTYHRsFdVeY97Wml1qXQ8y6dB24ZUiRGbt028sM7LRQu1
 1mUj5bqCCZpvbm9V32Q7PGXoCm0NCxTKnUNDQcUHVUt4NT5pow3yBXVQb5LDK6yi9TuXzX9x
 TyDpysvr7wWgYgA0KDT1VndgTuqjpzISBMloATRQm+hqAh+YeaNfYW5r1jG5PBPBI+cQh+Ku
 31ss8Sf6eESF5DLjy2TSeMMF7GB5+6IdjbbhDZHGpgi+jCp9m+LeIFb+jZlI0l1dM0DfFfBe
 0jTuAcX4ZJTIHKCbKlrbob3AMMvpYDjDc7sSv3ZbZxIa4l4dyeO+S0obkmVt0jumU5qlaA2P
 5izdceqEGZcCKJ7wT7wTOAYuZcx2yF412PaQ5/TzhK73L7Yb3mQIZ8dOUaKa+s6xKCJugPY9
 5BYLcTi4xtSVuK4fiDR/qYSK0wHKT4wApWeg8VRev+rIwxoAmgtBvbdh7Q7dORYc799k+7J+
 jS3XB9ewV+m33nfc1zVNTZkda/lWot5oTQjJyswMF202n8lJ4Gy8KMYcJhxdr4inAB+8cNJo
 zA+U53oKpxypv7voVzxsbGVQFReSSmW
IronPort-HdrOrdr: A9a23:oUTAY6l2g6pK//AvGRUNq7YkkSzpDfNKiWdD5ihNYBxZY6Wkfp
 +V8cjzhCWftN9OYhodcLC7V5Voj0msjKKdkrNhWotKOzOWxVdATbsSl7cKpgeNJ8SQzJ8/6U
 4NSdkaNDS0NykAsS+Y2njHLz9D+rm6GcmT7I+xrkuFDzsaE52Ihz0JdTpzeXcGIDWua6BJcq
 Z0qvA3xQZJLh8sH7iG7zQ+LqH+juyOsKijTQ8NBhYh5gXLpTS06ITiGxzd8gYCXyhJybIC93
 GAtwDi/K2sv9yy1xeZjgbontlrseqk7uEGKN2Hi8ATJDmpogG0ZL55U7nHkCEprPqp4FMKls
 CJhxs7Jcx8517YY2nwixrw3AvL1ioo9hbZuBWlqEqmhfa8aCMxCsJHi44cWhzF63A4tNU59K
 5QxWqWu7deEBuFxU3GlpP1fiAvsnDxjWspkOYVgXAaeYwCaIVJpYha2E9OCp8PEA/z9YhiOu
 hzC8P34upQbDqhHjjkl1gq5ObpcmU4Hx+ATERHksuJ0wJOlHQ89EcczNx3pAZ1yLsND71/o8
 jUOKVhk79DCuUMa7hmOesHScyrTkTQXBPlKgupUBXaPZBCH0iIh4/84b0z6u3vUocP1oEOlJ
 PIV04dnXIuenjpFdaF0PRwg17wqV2GLHfQI/xlltpEUuWWfsuvDcTDciFgryKYmYRePiWBMM
 zDfK6/AJfYXB7T8MhyrkrDsqJpWAojuf0uy6cGsm2107L2w63Rx5vmmaXoVczQOAdhfF/DKV
 0+exW2DPl8zymQKw3FaV7qKj/QRnA=
X-Talos-CUID: 9a23:e9grNWx+7QZXkhx+6rlFBgUpStF/KkXU3kv/AEaUFGRrEoa4EHaPrfY=
X-Talos-MUID: 9a23:Xmz7egniJtf1sqXWEEqcdnplDJlMuYaoMnongKgoqtuYFHxaajak2WE=
X-IronPort-AV: E=Sophos;i="6.01,156,1684814400"; 
   d="scan'208";a="121488691"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Aug 2023 07:20:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0tjIegbMAaCNOegwl9ZujvpOIJTvJtoVh79eVAWE2K7p/bkKNNaDlOIQOFKjjhmf7AxAPpZwV/wSOv+Fxry4ViirAJ5EpDyyFPyjkPbmppvuU6YkStbTr3ksXX1n4+jY6ELk6jLJ5B+hcg3/yAX7YQWJgvHCNZKPl4sIxVoSFuUhvziYvJ0tCci5SBT8aBjLBTZH6EdZc5iWzOu95gkc6TQrxnkAFEbXBSP7pj0haiFCrHRnQM6zCSJgTLYAklwtLmM0kDPuXWwpBsbMbNxUD8ApDyIzBrlBI0f2E3CncJc07qiVqG2Do0teGcrh0xMvCs57E4f7E7eqlCgdjlQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6eM9+x4dbjVDnCPJGKYoFe4YXMHs/e0XrZAZZJGExk=;
 b=SEmq2+ViWgFDnslaB2e+4H3diIuKOdaa1AqAfK+IB8kVjdyhl8kGUPP+Dk+Z7S9awPiuEd0hZCBI9bm1Id+ugC/+GNOhlA9BoisvzNkWezpVKvHM19fZ4oy6ievzcQq8wAJG6BYqSkPx9BF/v0+Gk7fGlrHrFzS4Twid/021xaQTlWA41ZylL4NaRe6+mlS7mfLQyN102bpuKMR2r6VZL6ZnPIJ1X+T9VIgCWpY73ElJzXyV8ineaGDbTHd3N939GvxYiIl4VjZPfa1LwnSqib5pGp5mpDTTlnO+ze7eREkMmThoQgZl3fe38D3JwVV9F3hMxfQmmCXSH5Ch4Y9PAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6eM9+x4dbjVDnCPJGKYoFe4YXMHs/e0XrZAZZJGExk=;
 b=bTwLV0DvvGm0fGHgEA5mhS/KaSkRCfueQXnwcxxnjqykazhfxYyY+DqqkbNUKnfefwEMnfJJaKZV+aMurXh9Ws+YIm6NCl8oJqcFPBaxVO7ftYKyjCOZ+xQ8xgaTZWFYcgOiAkfCiJfgIa+nTOS9g58dzpEPFnNx4ZrbWNg/kEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by BY1PR03MB7261.namprd03.prod.outlook.com (2603:10b6:a03:526::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 11:20:37 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::6bfe:c2d3:2c8e:d2ea]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::6bfe:c2d3:2c8e:d2ea%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 11:20:36 +0000
Message-ID: <a08e9457-cb8f-6b57-8f4d-4a1f856ce60e@citrix.com>
Date:   Tue, 8 Aug 2023 12:20:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [patch 00/53] x86/topology: The final installment
Content-Language: en-GB
To:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
References: <20230807130108.853357011@linutronix.de>
 <8d650d5c-e7b8-99c3-e561-3d177e6189bd@suse.com>
In-Reply-To: <8d650d5c-e7b8-99c3-e561-3d177e6189bd@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0288.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::36) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|BY1PR03MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b74698a-6acc-41f3-b920-08db98017cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y9/6nwAOM1VU87HO19qOpccKAnE0QT93XyjeRq9dDY3mcXpgKTyrIZMGjoMYx2cTIp6jFf0bSVU8CqswXx6tk0/14yphxq5jtX9zwACM5G/RRFSQwj463N3vgm4GB0Pu4rRgmpMyDavtaWAbtyI8uZPCn3df/zJp7r0O5BBM8yFDC0N/zlZ/RXEKuIUBKA6XiZuUS9JKBEO/VCOtTL5I5i/hPh/KtmmmCya25iskJxx1d9uf4SWpdQZ0/Ng0QBEeY/XVG/KYd0C0p97909qpvHaPYkIMkDsJUiI3XZnZnN9tzLQ1bTKypEnKMV7yJ2OyiShhgDP36xaQDaWmp57+5N6XAlXhlZQRpoHIB33jXMig1u2RKdRw86Co7Y+9WBAU8YZlZMPbXlKFWz84OQ9y0jTsnO8arwqmpccCyRhoaRJZK9zcnFpJ1Ly56kFcU00dc60I5f4S5wiozmZ8Kx1jMnjiRTJEIlqHW5Yy4a5E4id9yGxfHRVl69Pfu6ySmy9QkCz9yaHg8D5pkCcgRndIfhzCEpEOszoyLVqC/lcxPxJ7DE+A5xiUll7C75Ob6cRa1RD4f3mjdja+d/gvlnOfR2BRPC9GJ8WuDdKWdXcqZLlBZAlDCcwfBlN4OxFDr+d8PeCX9uHYOoAMA6Trrrpcgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(1800799003)(451199021)(186006)(31686004)(316002)(83380400001)(2616005)(2906002)(82960400001)(36756003)(4744005)(53546011)(8936002)(26005)(8676002)(38100700002)(5660300002)(6666004)(6486002)(7416002)(66556008)(41300700001)(66476007)(4326008)(66946007)(6506007)(478600001)(54906003)(110136005)(86362001)(31696002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFg4YjhOd1VOVG1CS1BpQ1RFdzlSSURiRzFGeDBUZThUbTdTT2pWdTVSS2tu?=
 =?utf-8?B?bzFFbGo5bnhRZUd1TUREb05OWlZmZ00zcVg0eXQ1NnNiNlhKUjNua2JRNi90?=
 =?utf-8?B?RFFIejdPVnY1dFIzWm5XdmFtQmNxbkhoVTl1ZTVFTDFYaTN2d2xUYTZtUm13?=
 =?utf-8?B?MXVFbEJ1VjA4eVQ2ZTJnd25jWFg1SHBEYmxjRkduMDlWUmRRSkRrNCtjQjlI?=
 =?utf-8?B?Vk11dXdPeXJ2c0dxZEZ2SzF1TmJsRGJvVGRSQUtQU2pWd1E0aTFlTlF5Q1RL?=
 =?utf-8?B?RjB2cmhlM3h0Nm5UWjRZcy9wWEtDUCtNazg0Ym1ZRGt1Mm9EaU8za0c4ZWg4?=
 =?utf-8?B?Sjk3NkhQby9Gb3F3UEMvNHZkWVRSbU4zZWhHOGxYUGFLM3Y1U1JWRHczTVlX?=
 =?utf-8?B?YloycUpRMnV1MmI4UWE2SSttOGJIaTIzSlMxS2ZnQWFpdjJIREcyUGJWeVNy?=
 =?utf-8?B?bkxhVUZNVFRjV1lJWS9hMFNIR3hYYTFaY24xODJLcThSSnQ0cWdQRXIxeFB2?=
 =?utf-8?B?WXFVNzBhTUZ4c0Z4UjJKNXF0Y2pZbDJoYXZyUFdkQ2VMbG5MVG1ra2YvS2tp?=
 =?utf-8?B?dDFpaWtvR0dmaWZ2RlpnS1JsTzgvTElOSkVINkVBWStmUjVNWUsrcEh2ZVpl?=
 =?utf-8?B?SWYwOFBRb25NZm1COHFKWVV6UmV2VXIxbTkwNm44aTVYakpoTStoQ3JPWXlt?=
 =?utf-8?B?b0lydjIrU1R4Ymg4WXFPNTIzeUdxTkpCNHVCWFhYYVpqT2VFMVBZNWg0ZzQy?=
 =?utf-8?B?azRrU1pKOG9JRmNXUDJkdzZhYlNMemhGSlh5bnRWL2JiaVVGaHMxc3B5S2lj?=
 =?utf-8?B?ayt6SUFBMWNJUVBMTXhEOFB4QU1OWFJTTS8zQmdLTGJQNzF2elRKZmZXRmxm?=
 =?utf-8?B?WVFReVNXN214MWcrWkx2bkZjdlJyOGpqQlpDZkZ1OTQxeHl3NE5oVGlXL1lK?=
 =?utf-8?B?RUw2c29RNUl2RDQ1Vkd6UGsrRm92YmtSalNJNnhnTEp6OWk3cnFQWjhEWDZW?=
 =?utf-8?B?b2xaelo0aXpUbkNmMXIydHpmZlM1T01KVUQ3bVlOaWFBR09EMUZlRmZxakto?=
 =?utf-8?B?bDkzcXlUaCtIMWdJYXQzeGhZWnFrdmVSZVFpSEJVcHRQUFYxWWt2ZithMW9p?=
 =?utf-8?B?WElQb1hQbG5Tb2JRcnR2NDNiQzdYRHpWQy8vVGUrTXp0QUd6bEJYcVhuU01X?=
 =?utf-8?B?UmNKcmlnMXJoYWRoem0wbFA0K2dvZ2RMazF3K1FXSDYrakh3QW01WnllT3ZH?=
 =?utf-8?B?azhJZkkvc0dwZU9KTVdTMVJYSmFhS0RNZ1ZoVXZSKzNWNk1CS0lzdFdValVn?=
 =?utf-8?B?clFIa3REK3pIaW1PZnhseGgzS3lxZ3V2TjY0T2MzdlVGdW9LbFZjL3I1UzJv?=
 =?utf-8?B?WGdXcEkwMEM0Q0VvT1k4eis1L1NTTE9JTDhSZ1VNcG5tMkFZUENJeDdlZWoz?=
 =?utf-8?B?enNOQklHaUY0ejJESVJtRVlWQm1nT3A3cTdZWm1QMnQwTmlTRHJkNWtYYnZ1?=
 =?utf-8?B?MzdLdXlmOThIZzlQQTVoNmg3UFNVSEJka3pzOFlTT1RKVU44TTA5NTkxcWcr?=
 =?utf-8?B?SXg1bmpSWVQxRUJidjA3UDE3dEJsellVdkpCRE1IYWxndmtsaEhGRXJkWjlM?=
 =?utf-8?B?NmJjbmlVSXV0K0VKK1l3dng1RVZkSHZ0cCtZbHV1RnArS001a0RLT3RxRVVW?=
 =?utf-8?B?VWdhRWh6QXRxbDZOckh3TUpLYW1pSWYrTU41TDVUWUFqNUM3cVZWZElFellC?=
 =?utf-8?B?MzBJNlFuV0taV2FoVTZUem41RkFEK3NWdm1JOG1aQzZsWmdUSE1BdVpVbFQ1?=
 =?utf-8?B?SG1VTmJiQnoxTDN1a0VFTG1sVURYMmV4STVkZDlrMDdRb2NqZjFwRDJucEJB?=
 =?utf-8?B?UDlYU1cvTFlKVUJBQXJzZzAzM2tac3JEOWxXUmNKUnBpNXp6OFE1WTQ4UDU1?=
 =?utf-8?B?Q1BzdTczbEtNOWVsMHNzUThobVZnSmVkOHZodThldjl5VDZWNUYzRWZkUm5U?=
 =?utf-8?B?aE9BZmZmczY3a3k2bGhUaXpvSWdXTHpnOWdBRGJsUXRUK1d2aG1ZbldVcUtl?=
 =?utf-8?B?UXlxRS8ycTdqZ0MwZjBjSWpXOFlsdkxvL1NJSnNRWG9YT3RseGpGM0hIZFZH?=
 =?utf-8?B?eXpVdmJEbEpGbWdMaktBbUxLSWlWazhVUU9iVSszQ0JmTlQ1V2EyWExRR3I5?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZEJHZUYzcG9xVW5Cb2U3bmxvWDFVWW5GK2tRWHVoanI3T1VPY25iTVFNZWt2?=
 =?utf-8?B?SWRWb0ZmR2R3MnFzS3dLTW5qcW0yTVcrYnNVYUN5SFptU0pBNWtOL2k1S2VO?=
 =?utf-8?B?STd3a2FPeGprcWNyQzc0QSt2dWxRT1gxWFdkem8zK0tyVDEzTjVwZU4zZnFn?=
 =?utf-8?B?VitwSi9FWlN6d3htVW4rMUtHbElacndVR3k1aDVrMU8wK2R5TFJzVGtQSWt5?=
 =?utf-8?B?LzdaVVJoM1FHOHY4ZmtRVUlnREs2TFBQUVpmNWZEVkpNN2pmS0drQ0lqa21O?=
 =?utf-8?B?L1JrMGFkSUtzUEhNMFdwaFB6ZE9ad3gxNUpjcHdRcmdMdzJCYk9UVWw3NHpE?=
 =?utf-8?B?S3M1V1AzV0FGZG16aDlTbG1SUkwrd3crNHlIVjhaNEJVc2VPeDF1OWc0bGpU?=
 =?utf-8?B?WUdKa3owaTJsTnIyeHl2bDNOcEFUcDdabmcrUmh2MHI4bnNTOFlrZTFZNXVY?=
 =?utf-8?B?NDRmWnNWM1J6VUh3RlMvUzB4Q2MyaGZEZVdHbHBkdTZ4UFpudmNKQktYZXk1?=
 =?utf-8?B?eTJYVWVDb3lKYXVVSURhTDE3Z0N3NURucjdhNnJiSUQyT2tyWkxPMzNHNjky?=
 =?utf-8?B?UDJUUk80YjlUdnY4MVpVTE1yR1htL2lCN0NZM0J0dkpkSFJmTWZTd2FseTJ0?=
 =?utf-8?B?cDUyb1VDMWsrVVJSQ2JkdjBBK0xnbm4vSWh3bGJwNWhzTDhUWE43Zk13V3lV?=
 =?utf-8?B?RlU1NWRCR0x1R0lxbEVNNFVDNU9YQi9KSlI3OTdPb0RUTVBzTDNnclo0SWpu?=
 =?utf-8?B?aC9TMTFEdHI0K0ZEcjZoYmYzRzl1VUtCYWZsSlpYSW9lRU5ad3hGdnQ1Y2dQ?=
 =?utf-8?B?NWxDRUxkNjRxdTFyU1cyWC9zcm0vZTdNRE5IZGpibE0zYklKZFB6blhNWjVS?=
 =?utf-8?B?VVlsMld1eDc0dThZaTN4WDdseUtPUVlmMHZmR010UCtoTXdUZWUrNFhDbnIv?=
 =?utf-8?B?Wi9yT1hFeTRMOS9wRndHSHd4MkVnMHFCSjdVRmIrODc3b2ZkbElseWtiWTVU?=
 =?utf-8?B?eTdRNXVNODk0ak1aS1B0UmQvOXc0ZjROMGg4eHBsSE5GN0oza21Wa0V4d1pm?=
 =?utf-8?B?Zk5aVisxR09KeFJXdlUyTTdZdjBJbzlnK3Exdkl2RlhxdVNtbDF3UEt0dWto?=
 =?utf-8?B?bVRuQzQybmZWMmFQc1Z2YjAvcU4yOUFuSjc3L1kxSDZaWkY2bWZ4Y0hXK2Vw?=
 =?utf-8?B?U3FkU3dKRC9ETFNBejZ2SUNIQmpMSmVJN1Z6eTd1MElyQ0xtOU1QMnVZYkpV?=
 =?utf-8?B?QlVvaHdxd1pYaERYdnk3VHNKY2M2V2FYQjFFVEFETEtvMzdER2xXNys2bnRF?=
 =?utf-8?B?N1lLdDhHcEhrWXo2ZVQzczY4OWRwYzlSek83aCthN29BNHBUWlozNEJxS0k2?=
 =?utf-8?Q?ByGZ5VlF2plQOA7fPRMPOMWe9ieGDHRE=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b74698a-6acc-41f3-b920-08db98017cfd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 11:20:36.5881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfqkX42nsBURajwXAgAIya8WL0RrrU86q0UiMdU4bj1CCLeyKPHd1faBY6nl1ljqiYAC3E4WpT4ab1AGkjjYt83jFnxMziTHI0nftkyJ0DI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7261
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 8:40 am, Juergen Gross wrote:
> Tested on an Intel system with Xen:
>
> - PV dom0 is working fine. I couldn't test physical cpu hotplug, but
> removing
>   and then re-adding vcpus to dom0 worked.

It turns out that physical CPU hotplug with XenPV is broken in at least
two ways.

It's dom0 (not Xen) that gets the hot-unplug event, after which the Xen
code in Linux succumbs to a preempt-check failure while trying to
offline the vCPU that aliases the pCPU wanting to go offline.

~Andrew
