Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7D57DD4AF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346167AbjJaR3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345489AbjJaR3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:29:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411CAC1;
        Tue, 31 Oct 2023 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698773382; x=1730309382;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UBQrrx7Xl05FlRaTJ1ELfHTzeIu5jTnFSJqughkoAc0=;
  b=h/8DVlaBqdXOisUXThaaHZB8qMuDiqZfSODAEXgb3bTiDhV+28+CmqJU
   6ovRcZ1ixeav95nCDnZHIwc4ILTYIXv5I6B8TX+GinHzSA69e2SL2bjDu
   4sd/mvCnEukPiYHlGuiY4WbUAVNq45aO5ISF/mKwmHcnWR2Hy7f96a4md
   6y48IS1+g35V7KwGPqD2X2jges3VvkD85H+EPdlc6lCVF48O3bYD1Adml
   /sMREpqJ6bJbxYXgsvRtLkgkCosxcAToJA01BDNw9miHzt/7U4YvMbuqn
   Ox2kxZ2Yjqg8qRiUJizqBIWhkGEM2s5QOJg7+ea4q8ni6EAmB4gVWUrgw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="385523254"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="385523254"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 10:29:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="764315896"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="764315896"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 10:29:40 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 10:29:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 10:29:40 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 10:29:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vv/ik8pcB0w4/PctC/k09bwnNtD1/WmFqRwzYfnCvp0Tog+toPhaKNPQIFTgkCUWymmFKLF8OQo8VxHpdRINS8O/dQ6JxnzUr08H0SZ1WJ3qb8Lb3AOwlQcwPS9Nq4jWEc8XQBXmPPUL7hH/DgjTqXYCu7ZKlou73Ys6y+RRMnxs91ORsO7gIVGY3B12eeNLtjv1YXvjSReZ0gmDUb5tpUnxdDQWcGRBobrTABegdm0Qf9tpTIpnM9vIqqhKt/PPxUNn1YNy/t/fWNpDdPk73UE3ViPB7lmL9Wo7DP+ccQQqoXW87suDpKOqars0SEZ4OoRMkKG4ruQ6XeLwzBk3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBQrrx7Xl05FlRaTJ1ELfHTzeIu5jTnFSJqughkoAc0=;
 b=gRlXQCM3EvBntJJ6+MH7EsmOZK+bm22bwOIjyjHn0hlBq1htGXTM4Bzjb8bRgJ/+TnVfBpMX8Wb6nHtDvvWefLCQzBhcCVWM1u93V1Ppe8qo9r19IHslt8tgUPvBSgVEcIr+Pi+kXSzbX3ZSDOgJ2U/c1rHzzMLQwL2G34wWjpopMt13TouO927rlX5ufnDSsIYzrFEgEdErITrYqLEwk0dcwIXNwGC8C403sUXJK2Uk2DED3AoOLpOQJkbluwymeHpzLft5P2NbWHG6woqWXnUR+/go1IownpMIIdIFF/g7RR7CBrCjhVvyjSWsCPadEYrU+k6vAqlGynWVdP0tCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB5928.namprd11.prod.outlook.com (2603:10b6:510:144::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Tue, 31 Oct
 2023 17:29:26 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1%5]) with mapi id 15.20.6954.019; Tue, 31 Oct 2023
 17:29:26 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "petr@tesarici.cz" <petr@tesarici.cz>
CC:     "Lutomirski, Andy" <luto@kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 04/10] swiotlb: Use free_decrypted_pages()
Thread-Topic: [PATCH 04/10] swiotlb: Use free_decrypted_pages()
Thread-Index: AQHaATgY0RLsz+xoMkWnZqzcXks5J7Bjy6sAgABXDoCAABYGAIAABGaA
Date:   Tue, 31 Oct 2023 17:29:25 +0000
Message-ID: <3903bbaade7ba9577da88d053b67b8bfdf0d3582.camel@intel.com>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
         <20231017202505.340906-5-rick.p.edgecombe@intel.com>
         <20231031114316.0bfa8d91@meshulam.tesarici.cz>
         <c0233c531965a69ffb55210ace6a8a9d0f844e74.camel@intel.com>
         <20231031181340.30233c17@meshulam.tesarici.cz>
In-Reply-To: <20231031181340.30233c17@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB5928:EE_
x-ms-office365-filtering-correlation-id: b60a9bea-be85-4001-6519-08dbda36edfe
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T3SQrA9V/pQAwUhlKfpZ1xOtD7os5Af2lVI2mMsSQfjtaalkgu82Fhv/ShsCGjvgktAupgvyS80dSGthrll1flEEYLTm4Hk6uOocoqpfcANViC94qZDgfvEpj+Z2aonPx1bOmXah63BtbMkN5ZTr0cgREmsSoA/DAaDP26TIvaMVfnOKOqfkJW6bFqOgbf5LxG1/Z2ZXkKw+4MITVttEzWJ+hUTU0dc487+USSTn8dYwZ8b4K0FQq/KD7gXWbCbFDXJE5/LKWraLroPFxz3qzx5GLNY355L4Ld1ATs3tj3a2lyXmTa/w1iiLsKC/PG44szdfJuWYJnLUzasWCITGM8bilACIw3cMNTlxdaVi/VGYMcRqWwdKZucS8ZMslukvKwfjapFevL53U6m+pS+hYCZo1aMSkPApbtUdtEeftM2C0+x1ZbAHn+8kgS4zuwQxsIFWe4Bmm7xXoLtgiZi6KiO4Wpf06UBHZmr9APeR5BMdp+s6Toz05xIsJCDWkZYpUjKNqJwJXPhQZ2pZFNZXo44dg4G1EOYxQJ9a26zhh5VLTvDnYEo3aIJYPmLBgkJSbM5beXjGDSywc3REP+bbf9GcVv8x99aGD+8i2Fka1v4nIjjNHstztYWMJC7xbq4p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(5660300002)(41300700001)(7416002)(2906002)(4001150100001)(66476007)(54906003)(91956017)(66946007)(66556008)(76116006)(66446008)(6486002)(8676002)(8936002)(4326008)(478600001)(316002)(6916009)(64756008)(86362001)(38100700002)(83380400001)(122000001)(38070700009)(36756003)(6512007)(6506007)(26005)(82960400001)(2616005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekEwZFJUaVRQR0hCcml6L2o3WnNQMVhReUYvczlMS0U4V09aOXhGRU4yb2h0?=
 =?utf-8?B?RVd5Sks2MEQvbUErZ0tqcFpHejBWWkJ6SzdBWEljMjFGd0IrMU5SUllLWUJZ?=
 =?utf-8?B?K3RYYWVMYWlzQm1hczlwTXZ6MzI5SHVibnYwbkZkdjNkRUY3dzdiYkZpUUJN?=
 =?utf-8?B?OXprdkxweXVJTlF3aS9US1ZLZ1JZMFNMYWVJVkFBOVdtWElEK0tNQS8zdHpz?=
 =?utf-8?B?TnV0VFNpbGkxaEoxY2F3THZPTWRzRE1NT0dpemhCK2RmQjRJTWpSR1BqZDIr?=
 =?utf-8?B?SUV5K3ZXTUxGSHJDbUFTd2xaZlk4cWZ5L2F2OVRhcE9OVFVuRVM3OXAwb3ZP?=
 =?utf-8?B?bHFZM211UnpuanlWeG9tTStuQ2ZlVnM4cXVZaGwyZC9mKytNUk9pSERmSWx5?=
 =?utf-8?B?enJoUmxjOWV0bUlnOTV4RDVHMFQ3MmErRytvZWU3bmMxL3Zwd3JCdHkzVU1I?=
 =?utf-8?B?aTNhcWNHempldWo4UnF5U0F1R3RzU242SnNaeXRGaG5DdjlTb3pXTXoyUkhH?=
 =?utf-8?B?ZjgrYm9CbytTYmlhV1gzamlDVUxTRmdaUXNsUUI3N0tOTG9TR0NWU2tOZVJm?=
 =?utf-8?B?U0lkZlkrLytzWXZES3lha3QvejRGMi9BdnhYdHUxNGhHSkxqWUUvWHRycW9U?=
 =?utf-8?B?NEpjS0JjbG83SG4rbGUxbG9kT0RtcDMyTXJ0WTdZOGc5U3daUHhUYytxZUFL?=
 =?utf-8?B?TVA4NU43ellWbHB3M1EwNHFJUWZOeTFyUlNYMFZXd0N6WkpZUFowSTdjN3Ur?=
 =?utf-8?B?bFJzVDVlTDlzb2pLeVhkUjJOWE0wWG1nV3hnSUR0L1hBdlo4S2VCdnN3eXBa?=
 =?utf-8?B?S3pPWWlFNzdreVRaZTBJN0xKbVdPSUVEaUpERWZsZUJxUTFyQUVndnN4UEJQ?=
 =?utf-8?B?QVhXN3gvRnF6OXJqMmV5andXTVFEU0lmVlRQZm00NDlueDcyYXZkRDI4cTkw?=
 =?utf-8?B?UGxSR09HZ2NhdFVKNExoT2k0bjA0aXBzTEhMdzRVOGJpcEFXY0NmaGI4a1hk?=
 =?utf-8?B?ZFkxMGNzV1ZJZTI5RDErdVgwN1FYMlB4YUt3NU5sbzBTTGJDY3NuZW1HajQ4?=
 =?utf-8?B?a3Naajlud2JMcFlOSFExYTRHZnVMaktDaFNKam9tL1dMbWxuc3laZFh3a094?=
 =?utf-8?B?bUxHSFRLalN0K1JHMUFsVGo4bzd4bG1ibXVLNEE1NyttaU55MElmejlVcVhz?=
 =?utf-8?B?eEw4Qno4UERWSEtOWjZNbXlWU3ZHbmhCWmVYT0F0MVovNzZDMGhUZDNUZGhq?=
 =?utf-8?B?eDhJeThRbG43cURoZlNvK2VEL2VGcXJnSDdTU2o5cmFCSUswaURRbUR0SjYy?=
 =?utf-8?B?dUFLaUlYZWdvZVIzUVVqSzRtOWRPdXRnZFdubHFwVVFuWVJPZm9GWC9KbU0w?=
 =?utf-8?B?bWlIcDBadzlxdzdvcy9iVmRzNktvZEtZY052elU4SjZ6Q0tCMDhYUDZjRFhh?=
 =?utf-8?B?M085Y1U4MEpLY01MclRRZlBoTFZia1AwWkM5bkdGY2lxUU9XV2dtS0U2UCsw?=
 =?utf-8?B?ZFdjRi9oZUJ0S1d4cjRPVjcwZTQzZzZyVUZlQWZ6SmVmTjhYdFBqY3Y3YVlv?=
 =?utf-8?B?d2hWd0ZuTTRwT1dNSlpOK0RUY0FlcEhPZlJNQVpyWlZTWW1rcFlxYTZ1QVdj?=
 =?utf-8?B?dkMwSGtMWFVrQ2pUNmtXRVJlSW8yNWN0RVJlRTNCR1NYNXJJZTJCd2JXdmsy?=
 =?utf-8?B?ZjJOSDlnS2xwRXB6N3Q4WWRlUEdidTRIa3prYzNhc2pQQVFybzg2TVlhM3l2?=
 =?utf-8?B?OWtjWVowM3VLM2JPWkEyb1NaVFFiODZva1FZVjZwaUN0RnNERXh1Q0gyUVpK?=
 =?utf-8?B?UGhsRUtXRjBIYjBJUGxDWVlmempHc1FseFlhak5vMGFBNWltUDRMSU1KK2d4?=
 =?utf-8?B?T2RpdTVVWFBqZXd0SVd0THhRd1FkdWNyV1QxTERybWNUYTJBcVloSGE5TVV1?=
 =?utf-8?B?TzROZHoycHl0UzFaSVRzQjlzVFdtL2xaNUl3dGVFT2xYbGp6TllMbDBMeTRt?=
 =?utf-8?B?SzdVS0VINGtKUXJELzJueHJka0RhVGpHMTF0SEI5bDgvOExVSGlQTEdFSkU2?=
 =?utf-8?B?WjM0dFJ3SkhIYXphdFk1T2lFUkFaOCtvd1BDZVZOY2plWWtCdUxNTXVGNDlF?=
 =?utf-8?B?aDAvdzQycmxtRzRPdkdmZ2t2ckJwVFZ6S1ppOU1jVDI4L2N4RFZOVUlwUjNE?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B7B6CD3A4DC7245892DEC315BE1796D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60a9bea-be85-4001-6519-08dbda36edfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 17:29:25.8522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LjTyKa98q396LB9J6tv7ppHKWCWoKdR/QLTabXnmJMfPwqwyaiALmA14h642I8P4sYIi6tO2Hp1M+H7j+oQSuAJqOJYJskjKKgMIXhY+/yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5928
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTEwLTMxIGF0IDE4OjEzICswMTAwLCBQZXRyIFRlc2HFmcOtayB3cm90ZToN
Cj4gVGhhbmsgeW91IGZvciB0aGUgZXhwbGFuYXRpb24uIFNvLCBhZnRlciBzZXRfbWVtb3J5X2Rl
Y3J5cHRlZCgpDQo+IGZhaWxzLA0KPiB0aGUgcGFnZXMgYmVjb21lIFNjaHJvZWRpbmdlci1jcnlw
dGVkLCBidXQgc2luY2UgaXRzIHRydWUgc3RhdGUNCj4gY2Fubm90DQo+IGJlIG9ic2VydmVkIGJ5
IHRoZSBndWVzdCBrZXJuZWwsIGl0IHN0YXlzIGFzIHN1Y2ggZm9yZXZlci4NCj4gDQo+IFN3ZWV0
Lg0KPiANClllcy4uLiBUaGUgdW50cnVzdGVkIGhvc3QgKHRoZSBwYXJ0IG9mIHRoZSBWTU0gVERY
IGlzIGRlZmVuZGluZw0KYWdhaW5zdCkgZ2V0cyB0byBzcGVjaWZ5IHRoZSByZXR1cm4gY29kZSBv
ZiB0aGVzZSBvcGVyYXRpb25zIChzdWNjZXNzDQpvciBmYWlsdXJlKS4gQnV0IHRoZSBjb2NvKGEg
Z2VuZXJhbCB0ZXJtIGZvciBURFggYW5kIHNpbWlsYXIgZnJvbSBvdGhlcg0KdmVuZG9ycykgdGhy
ZWF0IG1vZGVsIGRvZXNuJ3QgaW5jbHVkZSBET1MuIFNvIHRoZSBndWVzdCBzaG91bGQgdHJ1c3QN
CnRoZSByZXR1cm4gY29kZSBhcyBmYXIgYXMgdHJ5aW5nIHRvIG5vdCBjcmFzaCwgYnV0IG5vdCB0
cnVzdCBpdCBpbg0KcmVnYXJkcyB0byB0aGUgcG90ZW50aWFsIHRvIGxlYWsgZGF0YS4NCg0KSXQn
cyBhIGJpdCB0byBhc2sgb2YgdGhlIGNhbGxlcnMsIGJ1dCB0aGUgb3RoZXIgc29sdXRpb24gd2Ug
ZGlzY3Vzc2VkDQp3YXMgdG8gcGFuaWMgdGhlIGd1ZXN0IGlmIGFueSB3ZWlyZG5lc3MgaXMgb2Jz
ZXJ2ZWQgYnkgdGhlIFZNTSwgaW4NCndoaWNoIGNhc2UgdGhlIGNhbGxlcnMgd291bGQgbmV2ZXIg
c2VlIHRoZSBlcnJvci4gQW5kIG9mIGNvdXJzZQ0KcGFuaWNpbmcgdGhlIGtlcm5lbCBpcyBCYWQu
IFNvIHRoYXQgaXMgaG93IHdlIGFycml2ZWQgYXQgdGhpcyByZXF1ZXN0DQpvZiB0aGUgY2FsbGVy
cy4gQXBwcmVjaWF0ZSB0aGUgZWZmb3J0IHRvIGhhbmRsZSBpdCBvbiB0aGF0IHNpZGUuDQoNCg0K
PiBIbSwgc2hvdWxkIEkgaW5jb3Jwb3JhdGUgdGhpcyBrbm93bGVkZ2UgaW50byBhIHYyIG9mIG15
IHBhdGNoIGFuZA0KPiBhZGRyZXNzIGJvdGggaXNzdWVzPw0KDQpUaGF0IHNvdW5kcyBnb29kIHRv
IG1lISBGZWVsIGZyZWUgdG8gQ0MgbWUgaWYgeW91IHdvdWxkIGxpa2UsIGFuZCBJIGNhbg0Kc2Ny
dXRpbml6ZSBpdCBmb3IgdGhpcyBwYXJ0aWN1bGFyIGlzc3VlLg0K
