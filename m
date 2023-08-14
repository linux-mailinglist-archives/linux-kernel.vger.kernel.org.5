Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A21377BCFC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjHNP3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjHNP2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:28:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168E210E4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692026922; x=1723562922;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DZ7u0mp36FB0b/Uejgkb2suYyKQ1sPXhGe+/WjW09vU=;
  b=MxBCZ0eckwW9Fe3IN49RD7W+EUSNEdve3vb62eU7WA3QCrRh9as0RUuL
   uUzqODAptJKAy30TcZxOU9M8Cl2WQ8ityn38bpUY2pyoTp1SIxrvBfXUG
   C9r2nK+d9IOpkfoILGGWdCxSBfXAUk/3mhWDRIIm+7DPdjWmtEUX7BAQB
   Jc42cRla/k4pzLlPsmx6EgmxEiDZwUfDTGtyWo/mRtp28JuZXOaVeKsHb
   bV1WwZ1bXf957n4Ji1mHtLFqGpOClY8eCdryEifUel59hnrquJ77NQIT1
   WSq/yMEEBDHeW+ILCFxe85keWnXw2aCqn1hvJSWUPQG52X4McqyVbnvZS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="369535561"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="369535561"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 08:28:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="736553721"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="736553721"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 14 Aug 2023 08:28:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 08:28:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 08:28:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 08:28:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EA6sMepoXywVB7HMRLR/qKzm01Ra2dDDSy5bKWp4smYcOTrbYElACgDzXemvIRO1L6zZannQXI2x7uw8quDTEB94DZn5rI3fsIUcKOTAIVf6wDN+Yrh4SiEUQfY8EBnXq6jluC/3ew0d7arYhoxU96C21iZptCAyqJ0gOd0C150hcwjJHrmtKV99CKM9YCfvF/fSNzBZWN2OWkhSdrM37h4XdAHwj75jM2ML1Ny93xYsk6AcoAJ4LYXn31ygkzrxVkh0xVpLiJKxRA6WwICHegZ0/DcCRwibQqirSFH72FdD5kLgozpqXAyowwHXowQ6tbMxHpf+b7DcHUxXROnZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZ7u0mp36FB0b/Uejgkb2suYyKQ1sPXhGe+/WjW09vU=;
 b=FC65J6NoDmMJ5duLUJFiUAs9ZBr5xB+++yWPmHGC1VHSZdLx4d9selhmqe12MGihSSPZgsUyGAyy6VUE2bKpZmWULGSJI5AKT/jbkSgUbZpJfcLLcFTRT+Ahcq7gNZZq9KtYWvJFFQkU2+cWVW2OAWcgFI6+nyRYjiRjxSTM3fef1/pZyK9RWJOewkFIGfzk/TCwoKQxcUnXOX5f3nmaZQBPbbwqqo0xUE13MeZK2KLqXfAXSLiqK2RrVHw43hcVoaCTHKM4BKAHIgINLAvB2uL/nn4xRdrpko3uWOdIQc0TPqliVZkSCdDGIBgyGnUE9YGgyklYFpziKSZNJiaD/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH8PR11MB6854.namprd11.prod.outlook.com (2603:10b6:510:22d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 15:28:08 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85%6]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:28:08 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Brown, Len" <len.brown@intel.com>,
        "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: Re: [patch V3 27/40] x86/cpu: Provide a sane leaf 0xb/0x1f parser
Thread-Topic: [patch V3 27/40] x86/cpu: Provide a sane leaf 0xb/0x1f parser
Thread-Index: AQHZxSuNHqTVYruCfUiH6AgMgzkGq6/mYcAAgADEZgCAAT52gIABItGAgABDd4CAADKdAA==
Date:   Mon, 14 Aug 2023 15:28:08 +0000
Message-ID: <265f4f8a3eceebd1acef4c8a9ff99a6d78a0126d.camel@intel.com>
References: <20230802101635.459108805@linutronix.de>
         <20230802101934.258937135@linutronix.de>
         <8e5bbbc91ff9f74244efe916a4113999abc52213.camel@intel.com>
         <87350ogh7j.ffs@tglx> <87ttt3f0fu.ffs@tglx>
         <b8637c8c92751f791bf2eae7418977c0fd0c611d.camel@intel.com>
         <87il9hg67i.ffs@tglx>
In-Reply-To: <87il9hg67i.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH8PR11MB6854:EE_
x-ms-office365-filtering-correlation-id: 066ea002-a8e8-457e-d6bd-08db9cdb0fe8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZX4iTeHhz9tAKAn+pUOGZgnqW2NErbi4krCWoCnZy1DjmwaWHwFHzUxmoux3fRkR8LPt43bbW2TaElknJrnIyFq3eydCiXjiPnryKQU3hn+8DSstNuInvpW9X7xJORG4BsmY2Vc+gQcP3SvPw+jmdg6PQ9QaIfwuPWQhqD5THm2TFqCq6cnyc973xjF2/SRmEcbPnzcTzs3euBsTeSmgI9Vvp+OYIVrfnPfa+YglhmyyQw6Cijv1AjVHmGviPK+jrFL+a2Hxwp/1Hp+/jpDw72c6Mv59da951JgJTQm4+NTbi7q62zJq3EM92x1FVAKe8SkAz+K3LDGbChJKpk4OX0JiHLWurnAOMh/ZvAEQkCilNxDsmqlHLlhmv/bt/QX+7gk//lRirEJ5bm6JqLpbva6Qkz1HAI3ZWJRExpp1ulv5UNbaI2+AIn5vNIcw2Y8gLJ1RTBFABJqIeJ/MzIQBKwf7E1BLuIF6t7+z0WLDantYywSRLq3Ta8v4EACPizJDHz+f8FD8JEI1cOgR3S7C652OJQXKu2QpF56IHOBFYO0CTCHAJTfaNuGa2p7AG7pgSg22bX/CqCoqVdvFuj+zE4poG4nn0hu9sRXdCpna7UGuWaWDE3wLVzuuc3wysQz3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(1800799006)(186006)(38070700005)(82960400001)(38100700002)(122000001)(6486002)(86362001)(36756003)(6512007)(26005)(6506007)(2906002)(2616005)(8676002)(41300700001)(71200400001)(110136005)(54906003)(8936002)(478600001)(4326008)(91956017)(316002)(66556008)(66446008)(5660300002)(64756008)(66946007)(7416002)(66476007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnNpNmdtYk44bXZlY01CTER2di9IWE1vV1kzNDFRNHkyYTZsUHhvakxXMC8y?=
 =?utf-8?B?K3poMnFObTFoYlh4Z1lRb2FzQUJnV1Q5K01tSGtGSkpUQ0RLODVNdk9uc0g2?=
 =?utf-8?B?eGxiVEc0WEFiU01EREZxU2tLc0xHZ1loZFZRcU40c25RMXFIaHVPYytqeGgw?=
 =?utf-8?B?WXpHOGw3NVFFc2tiMytQMzNrUkxTenNsV2pUVkpveEg1STF4SS9WOFFYcXg3?=
 =?utf-8?B?Rzc5Zm8rQnY1bmVPSmliVUl1dkovQjRHenZodjRPd1JuZUNySkZyUGdWR1RD?=
 =?utf-8?B?aEFoN3V5MUlPZVhyMGllSUlIMDQrMDBIRzAvaWp4V2h5TnM1VkRKUGJueVdy?=
 =?utf-8?B?Ti9pTytlRDV0MlpQc3FrNGJGVHhhbXhMRGE1N0RsMjNEMFo1VG1UYkh0akRX?=
 =?utf-8?B?cHZRaEp0eDYyaFBkRWFkdmE0L3l4Y09zVG5QMytpcm9JbFJkYi9GR2o5eitu?=
 =?utf-8?B?SGRVNVRQckZmejFFMmlJanRYYi9NMHpVU1IzaXFTSUx6dzdvdHNSRHovdWcv?=
 =?utf-8?B?dEdkcXh5Mmg4QU9oYnEzdWhaY1I5K2FJcHhpMEMrYWx1RzZEYldCT0lDcUp1?=
 =?utf-8?B?dkRKSE9YYWgwR3NLZjkyeVNSaUdzQitneUVYRHNYZU5DNUpuL3JuNm1SbTNH?=
 =?utf-8?B?RCtvRDB2MnN0cCtSNFhYL0lxWmhVYmZLbzcxaDdqSVhqNmowazVXMEI3dmt4?=
 =?utf-8?B?clpramtiNGZIUmpJTTRIRDFXZnZPSjVpNDNsV0c0aWllM1ZBN2FtWkN4VUR1?=
 =?utf-8?B?TWtiZFQvMUY4cTc0cnNhblFNTW50eWhCZ25CK1lMWk1WZklxU3c2NXFLS1lv?=
 =?utf-8?B?bk1rekJTbXBBWjZ6aUh3ZkRRMjRzZGNjdTJWaGJDTjFzN0UrdTFtYXIySmsz?=
 =?utf-8?B?eFNocEJpSkloSXFXRGZPRzBVcTQzaHREcUdqSmxOWU93RFF1MlVmOHZWSmc2?=
 =?utf-8?B?NmdLNFd1Zk5IMXAwSXhMZGxDQ0cvdlk4N0lUSXNaajlMRUw0QThNMEJBSU8y?=
 =?utf-8?B?T0tqbFlRSk56N2h1UzV6ZlZRd0x0TkJZSXVQb0ExQ2czaWp6WDB2ZGJrcnky?=
 =?utf-8?B?OFVGcXJsUVg3RFpLY2lUN1BVT2pGVE9yY3AzWjF6SE1mUUdJZ2EyUFR1NW4v?=
 =?utf-8?B?b054UVZMd3Zzb3p1V3RYYXNBRHovblhJUU1IaDIwRFYvRFRHSE5UaUQ0QS9D?=
 =?utf-8?B?K3h2YlBMWHNTMUN2Y2Vydk5kUWt5Y25WcTlYU0l2UXFLL2t5a1RQSFcrbjRa?=
 =?utf-8?B?TWsyWTV1QitEK0JFZW5FNDVOVkF4NnFCMWhMak1mNm1taXoyT3VMWndhbnhD?=
 =?utf-8?B?akxEZ1JmY1p2My9WRGZhT1ZNTU5sTlNhTWlEdUpPZjY5MiswMGlFMEdBMWRU?=
 =?utf-8?B?TXRiY3ZMbklFNStLKzVsS0xjWVNvQjkySSt0UGwybnMyYWt6Z1BmSXVEeTdq?=
 =?utf-8?B?N0hZTW9QUERyYkgyRnFMKzJKRzhUeDhWcndtR2FZdU56czFjQkdEVHliU1ho?=
 =?utf-8?B?emRvLy9telcxM1k3cXRKRjlDdlpYSENHOEtsdTc2NmQzcjExOHI1QmZCT21C?=
 =?utf-8?B?MmtRZkRoWlhHL3dyQjRNZ3hIV1dFbm5FUjg5N1JKTUhvWDRzVXI4VGNkVHc2?=
 =?utf-8?B?Z2MxVDJNVXZwVWNOc21xWGRsQlhoc09WQW5tWW50b3MxbmkwTGZ2VU1iRExS?=
 =?utf-8?B?NWZGVUwxd1V6YWtTVE94SElKcUhXRWFCOWtZdUlyQTZ6dGcwaWxSaVVJU3lR?=
 =?utf-8?B?MkZmYmRNbVM5aDV4clQwZktRU01sTEQ1cldMUXRiMGNibGFuZC9MenBxaUFw?=
 =?utf-8?B?STg5L0FCU2hHSk1DcXViMW5OUXcrVWZUWXNWaTBxZVdZQ2JsYVFZNTNaVHgw?=
 =?utf-8?B?QmRlUSs0MmIybXRIOG1jS1lFeFQ2Wms5WkEva1BPUXZyaUJGNStPUWJQejRI?=
 =?utf-8?B?Y2p6Ylp3NWlaeEN0OXcrSTQrc3hKT3BVOUx5TUY0LzBWWVZMZG5jUG5ERjVH?=
 =?utf-8?B?OWI1anM1YjlQQzgzVDF5WjM4cXV4ZjcwWWhXV2NIRFdzK243TVRKQkhvNmdz?=
 =?utf-8?B?c0dEQXMvcmtaQi9xbUVnMkIvNFUxS3NZcDVURHZseVY4SndocjJlU3NiRmxB?=
 =?utf-8?Q?r9DL0UHUMeuHxbATwdhJH+zsA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C98C7736DC6311469A0D8403DD0C5C5C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066ea002-a8e8-457e-d6bd-08db9cdb0fe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 15:28:08.1282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UwaTPkcBAR9C+GgEKUoejuoiL1RdQXLaZ/dqebeC4scaepiYAJ3eWzuYRLtbvLndZ9+G/XKWGdCTkKcVElntVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6854
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFRob21hcywNCg0KT24gTW9uLCAyMDIzLTA4LTE0IGF0IDE0OjI2ICswMjAwLCBUaG9tYXMg
R2xlaXhuZXIgd3JvdGU6DQo+ID4gT24gU3VuLCAyMDIzLTA4LTEzIGF0IDE3OjA0ICswMjAwLCBU
aG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+ID4gDQo+ID4gV2l0aCB0aGlzLCB3ZSBzZXQgZG9tX29m
ZnNldFtESUVdIHRvIDcgZmlyc3Qgd2hlbiBwYXJzaW5nIFRJTEUsIGFuZA0KPiA+IHRoZW4gb3Zl
cndyaXRlIGl0IHRvIDggd2hlbiBwYXJzaW5nIFVCRVJfVElMRSwgYW5kIHNldA0KPiA+IGRvbV9v
ZmZzZXRbUEFDS0FHRV0gdG8gOSB3aGVuIHBhcnNpbmlnIERJRS4NCj4gPiANCj4gPiBsb3NzaW5n
IFRJTEUuZWF4LnNoaWZ0cyBpcyBva2F5LCBiZWNhdXNlIGl0IGlzIGZvciBVQkVSX1RJTEUgaWQu
DQo+IA0KPiBOby4gVGhhdCdzIGp1c3Qgd3JvbmcuIFRJTEUgaXMgZGVmaW5lZCBhbmQgcG90ZW50
aWFsbHkgdXNlZCBpbiB0aGUNCj4ga2VybmVsLg0KDQpTdXJlLg0KDQo+ICBIb3cgY2FuIHlvdSBy
aWdodGZ1bGx5IGFzc3VtZSB0aGF0IFVCRVIgVElMRSBpcyBhIHZhbGlkDQo+IHN1YnN0aXR1dGlv
bj8gWW91IGNhbid0Lg0KDQpUSUxFLmVheC5zaGlmdHMgdGVsbHMNCjEuIHRoZSBudW1iZXIgb2Yg
bWF4aW11bSBhZGRyZXNzYWJsZSB0aHJlYWRzIGluIFRJTEUgZG9tYWluLCB3aGljaA0KICAgc2hv
dWxkIGJlIHNhdmVkIGluIHg4Nl90b3BvX3N5c3RlbS5kb21fc2l6ZVtUSUxFXQ0KMi4gdGhlIGhp
Z2hlc3QgYml0IGluIEFQSUMgSUQgZm9yIHRpbGUgaWQsIGJ1dCB3ZSBkb24ndCBuZWVkIHRoaXMg
aWYNCiAgIHdlwqB1c2UgcGFja2FnZS9zeXN0ZW0gc2NvcGUgdW5pcXVlIHRpbGUgaWQNCjMuIHRo
ZSBsb3dlc3QgYml0IGluIEFQSUMgSUQgZm9yIHRoZSB1cHBlciBsZXZlbCBvZiB0aWxlDQogICBp
ZiB0aGUgdXBwZXIgbGV2ZWwgaXMgYSBrbm93biBsZXZlbCwgc2F5LCBkaWUsIHRoaXMgaW5mbyBp
cyBzYXZlZCBpbg0KZG9tX29mZnNldFtkaWVdDQogICBpZiB0aGUgdXBwZXIgbGV2ZWwgaXMgYW4g
dW5rbm93biBsZXZlbCwgdGhlbiB3ZSBkb24ndCBuZWVkIHRoaXMgdG8NCmRlY29kZSB0aGUgdG9w
b2xvZ3kgaW5mb3JtYXRpb24gZm9yIHRoZSB1bmtub3duIGxldmVsLg0KDQptYXliZSBJIG1pc3Nl
ZCBzb21ldGhpbmcsIGZvciBub3cgSSBkb24ndCBzZWUgaG93IHRoaW5ncyBicmVhayBoZXJlLg0K
DQo+IA0KPiA+IEN1cnJlbnRseSwgZGllIHRvcG9sb2d5IGluZm9ybWF0aW9uIGlzIG1hbmRhdG9y
eSBpbiBMaW51eCwgd2UNCj4gPiBjYW5ub3QNCj4gPiBtYWtlIGl0IHJpZ2h0IHdpdGhvdXQgcGF0
Y2hpbmcgZW51bSB0b3BvX3R5cGVzL2VudW0NCj4gPiB4ODZfdG9wb2xvZ3lfZG9tYWlucy90b3Bv
X2RvbWFpbl9tYXAgKHdoaWNoIGluIGZhY3QgdGVsbHMgdGhlDQo+ID4gcmVsYXRpb25zaGlwIGJl
dHdlZW4gRElFIGFuZCBGT08pLg0KPiANCj4gWW91IGNhbm5vdCBqdXN0IG5pbGx5IHdpbGx5IGFz
c3VtZSBhdCB3aGljaCBkb21haW4gbGV2ZWwgRk9PIHNpdHMuDQoNCmV4YWN0bHkuDQoNCj4gTG9v
aw0KPiBhdCB5b3VyIGV4YW1wbGU6DQo+IA0KPiA+IFNheSwgd2UgaGF2ZSBuZXcgbGV2ZWwgRk9P
LCBhbmQgdGhlIENQVUlEIGlzIGxpa2UgdGhpcw0KPiA+IGxldmVswqDCoMKgdHlwZcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGVheC5zaGlmdHMNCj4gPiAwwqDCoMKgwqDCoMKgwqBTTVTCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoDENCj4gPiAxwqDCoMKgwqDCoMKgwqBDT1JFwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgNQ0KPiA+IDLCoMKgwqDCoMKgwqDCoEZPT8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgOA0KPiANCj4gRk9PIGNhbiBiZSBhbnl0aGluZyBiZXR3ZWVuIENPUkUgYW5kIFBLRywg
c28geW91IGNhbm5vdCB0ZWxsIHdoYXQgaXQNCj4gbWVhbnMuDQoNCkV4YWN0bHkuIEFueXRoaW5n
IHJlbGF0ZWQgd2l0aCBNT0RVTEUvVElMRS9ESUUgY2FuIGJyZWFrIGluIHRoaXMgY2FzZS4NCg0K
U2F5IHRoaXMgaXMgYSBzeXN0ZW0gd2l0aCAxIHBhY2thZ2UsIDIgRk9PcywgOCBjb3Jlcy4NCg0K
SW4gY3VycmVudCBkZXNpZ24gKGluIHRoaXMgcGF0Y2ggc2V0KSwga2VybmVsIGhhcyB0byB0ZWxs
IGhvdyBtYW55DQpkaWVzL3RpbGVzL21vZHVsZXMgdGhpcyBzeXN0ZW0gaGFzLCBhbmQga2VybmVs
IGNhbm5vdCBkbyB0aGlzIHJpZ2h0Lg0KDQpCdXQgaWYgdXNpbmcgb3B0aW9uYWwgRGllIChhbmQg
c3VyZWx5IG9wdGlvbmFsIG1vZHVsZS90aWxlKSwga2VybmVsIGNhbg0KdGVsbCB0aGF0IHRoaXMg
aXMgYSAxLXBhY2thZ2UtMC1kaWUtMC10aWxlLTAtbW9kdWxlLTgtY29yZSBzeXN0ZW0NCmJlZm9y
ZSBrbm93aW5nIHdoYXQgRk9PIG1lYW5zLCB3ZSBkb24ndCBuZWVkIHRvIG1ha2UgdXAgYW55dGhp
bmcgd2UNCmRvbid0IGtub3cuDQoNCj4gDQo+IFNpbXBseSBoZXVyaXN0aWNzIF9jYW5ub3RfIGJl
IGNvcnJlY3QgYnkgZGVmaW5pdGlvbi4gU28gd2h5IHRyeWluZyB0bw0KPiBjb21lIHVwIHdpdGgg
dGhlbSBqdXN0IGJlY2F1c2U/DQo+IA0KPiBXaGF0J3MgdGhlIHByb2JsZW0geW91IGFyZSB0cnlp
bmcgdG8gc29sdmU/IFNvbWUgcmVhbCB3b3JsZCBpc3N1ZSBvcg0KPiBzb21lIGFjYWRlbWljIHRo
b3VnaCBleHBlcmltZW50IHdoaWNoIG1pZ2h0IG5ldmVyIGJlY29tZSBhIHJlYWwNCj4gcHJvYmxl
bT8NCj4gDQpNYXliZSBJIHdhcyBtaXNsZWFkaW5nIHByZXZpb3VzbHksIElNTywgSSB0b3RhbGx5
IGFncmVlIHdpdGggeW91cg0KcG9pbnRzLCBhbmQgInVzaW5nIG9wdGlvbmFsIGRpZS90aWxlL21v
ZHVsZSIgaXMgd2hhdCBJIHByb3Bvc2UgdG8NCmFkZHJlc3MgdGhlc2UgY29uY2VybnMuDQoNCnRo
YW5rcywNCnJ1aQ0K
