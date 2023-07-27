Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B49A766002
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjG0Wzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjG0Wzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:55:39 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EA694
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690498538; x=1722034538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=la0pyaxtZOiofOcFttqC2NCknXAIbgzuqQd78HPXSEk=;
  b=Qvx9UKXrTfERM2bVzBlGNmbSQ8vL1OM3FO0Dzsd455eM6xd3mJ0KTw2e
   jqI5a/tRxRgYWXxxKU7uQS5EJ9RSxa04MzWGV2PP4DdpkVfMx+eD5c/g8
   5VzKcnKc+vsQyo92I/78C0kkwgfsHsbPtrFxvkggOzXStsXP563psRYF0
   /cMclGMI0c8U8pet5i72XIUsuim+uAWgg2ue9kVRs0saZjsmhrAx7XYXc
   UAUExzQixXmSJsAp93Q5cV0PvBle7Jso+uvZrYDWS2aIxGO6AlCxQxU11
   +5vttRJGY98rwcgQ17STEO3jI1QAIMOSnm3r7GDPw8wgxVBiicPcqWC0E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="454818119"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="454818119"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 15:55:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817254042"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="817254042"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2023 15:55:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 15:55:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 15:55:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 15:55:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qg5DanHkHwhAmiFQbKPNbmTntCiK6Iqzd0z55KN6z9oqXOby62mg30m8erqpyo51zqHb44TlmFhuEnDeRp7mZxVlkU+lH2HEMnOzgXQee26LkjHPhZ+dizZ+WIKdc8HihN2Bq768LYEo6l3Pu2Gb8SfSyBncFL10EGpjJTyOdxUcWXqks4KfcPgzMddvKkxLa1ImKz4NwScNgEs90f1g4koOvF3aKtg+v6NUVnC2SKubYpOK9os3Tgb+/qRXKqzhVKDosDqlbdUijhL/B0XEA12akASY8LGb80yfaLptW6z6tNXGfC4qGifGdpZnQFmN0PGsenLBuKLICo1u4e720w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=la0pyaxtZOiofOcFttqC2NCknXAIbgzuqQd78HPXSEk=;
 b=FpzFa+ZpWxBYCKbaoTGAEE5NitSQB7DJbNOWbGIoDiHb6vH8H1hwcnuIqktNyIOm/gxzdupwQZ8RZX2dOWWFrQmo26Vii0bCR++I2+x69REPZ3mkEwYIQPY/7wOmNdDYoJq2w2MmY3ss4erlz2KiN+Leg17wMDN3/omzXFxhfWoWsQtAlQdrPfXAxS95GZo5WyLtNdkclSZMnY3quX0AvJCSOFV9sKYpXr/cutqUMiN7IwkS+uE14TqM8IYHRiRItkMppE8qOLHZHBD+DeughN2b4XGbJcdz6Ys2szW6DVARs3JZEZlpiSILSoh67ZSs67aQ7Ko+7aSIQz35oD1imQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB6717.namprd11.prod.outlook.com (2603:10b6:a03:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 22:55:33 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 22:55:32 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v3 02/12] x86/tdx: Skip saving output regs when SEAMCALL
 fails with VMFailInvalid
Thread-Topic: [PATCH v3 02/12] x86/tdx: Skip saving output regs when SEAMCALL
 fails with VMFailInvalid
Thread-Index: AQHZv7En4WxYWca3QkuZv1vleGwAlq/NkwMAgACofAA=
Date:   Thu, 27 Jul 2023 22:55:32 +0000
Message-ID: <5065c767eecb1c02101f031cd346892e09d79433.camel@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
         <a825cbf3d8b7f994330ce8c4481ac750d2935cf7.1690369495.git.kai.huang@intel.com>
         <20230727125228.rtayk33s3diflqkm@box.shutemov.name>
In-Reply-To: <20230727125228.rtayk33s3diflqkm@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB6717:EE_
x-ms-office365-filtering-correlation-id: 796527f2-0c96-444d-9e41-08db8ef4952a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a03rrv7EB6vAq/WYx0tUt/sDNeWoEaEujTWWv7ycYiI+nPG2vJG/jjAZJWgWwIxCzMD/TX0xvcHBm/EvrOL7esXoWPBtmbAdQMaRVvm6qywATbVGSFMpYuGiJSwVqWd9JIpbzoYY6/hPwqmw1Q8sh49Rl+/6vSYVUDtwljHSF+Q3pmsTReKyKcj/dxxytawifh/V+LwqFL6ULkQvUe3xNUV8UgCi9b4PaBh5Zchrcot2Wxz1v5nf9/dZdqIG0Y3inH3fsHVxBwMd5DVrg5zPeZE+CW+3RaGPRT3eNemki47WXIdboyjiqVArgvN/ke5tlqQ9IaWQMkVCDFDAGcQMY20IY3MyDH89Qy/v9F/c941SdyGHypDqwfmvvPCTnz0ORa8Q5QJ/7ory2zF4DGZWoq+l5CIk+QFwuaQE5JhrgP+B1c+OJQK9vtoTOoYW/OTQIOgIGweopWFScx/kRMS8JKQ3EylrlGbJYrUtzuFtCluD1tARRQaOMynOJvjhdzsfi53rDbf9s+HtjJijyZRR2oQvLIDqQTAVrg3hRm4sXGICT3X6D0b1mrOT0n3P8IdIbYvFH+0ugWyeTPjPX24aYuKZlnPahSO8GOV1+/tS5j4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199021)(316002)(2906002)(8936002)(8676002)(7416002)(5660300002)(38070700005)(41300700001)(36756003)(86362001)(6486002)(71200400001)(122000001)(478600001)(26005)(82960400001)(6506007)(186003)(54906003)(2616005)(76116006)(66946007)(66556008)(91956017)(83380400001)(6512007)(38100700002)(64756008)(66476007)(4326008)(6916009)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmljdHpiVnkxUmFtUHpQcXdKTUFYeGpYaEUrbVcwUk9OR25wQmZsNVJjOHU5?=
 =?utf-8?B?WlFsSDVXRm9ZR2lBQ2dMUmtNZy9xSy9yTFVVeitXRHN6dDNWYUdGcHFQNXM0?=
 =?utf-8?B?OHhEditrOEg3ZzIwRkh0ejlsNGo0VDVHcEp1UGg4UDRNazl1RGdYNldNSGRj?=
 =?utf-8?B?dzFsTjBnS3ZGQk9JTHJWM1lTNG1IVmFDK2JOa0hEb0hDTVkxWC9VWndQWERI?=
 =?utf-8?B?NWROcHJZSUF4c0FSOE5pVGpFd2J5UE9PZ3BTdHh3N21xT09BSXB2UkVlaHBS?=
 =?utf-8?B?WUlVak1GSHZVd0tJN1M5Q2hYQlRYVmR1UEZobnp6eXB2MGYxbENvU01pbVJP?=
 =?utf-8?B?OG96T3IwRTRsaGhjT0FVTGdrdmM1dzlaMStOUmhGVy8xRlN0dUk3bmZmZEtp?=
 =?utf-8?B?eElRSC9rRXg0aE9rQ0diaVFOUXdPUlBTOW9OMm9MaEN0cERWemxRdUlVTklF?=
 =?utf-8?B?cW9ab1BEMnNKWWtUVm1LLzZrQVJyRHZmN1FlZXI3aXN5ZWpnSVJvd3UxZGha?=
 =?utf-8?B?NDJCbmVaN3N5OWIzZkVlQWZwazBMUEhhYjY2Vk5qalh4bGx2Z05ET2hqTS9i?=
 =?utf-8?B?c2Z6TE53S1lLN0NWbnBoeFI0bUg2alpQTTZvVjJGS0F4Mjdmd2syTlBMY1NN?=
 =?utf-8?B?OW5NUndwclJxVEJGYTBNaG9NQVhvVll4L2FzS2N3LysvUnBhN3MwaCttZWRY?=
 =?utf-8?B?NTBPdnpjTDFsTzJBV0xmYmFtdjUyWXpNTldJRTlSZHd2NWlEWndGM1Y1clZB?=
 =?utf-8?B?aitCTUt3T0hLZWRlVEM2ZGRSbDZKVk93SU1BUjVQamx5RnFnNWw1VE5ia2FF?=
 =?utf-8?B?aWNjNlNCcUQ4Ry9HSm5GdXRrdVNyVU16SUZoYy94M3B4Q3dGaWkrZ0VmNGVa?=
 =?utf-8?B?cldKNGJqQjg2NlpjdC9xQzlTRVV0ZU0zM1VNQWpCR0JFemtLUnoxOHFjUlZw?=
 =?utf-8?B?Z3NxYURQS0c2VXJKa3RoMTJIMmtNRDlkK2lyMDNVc1pJRzd0aWdjeWkxU0VJ?=
 =?utf-8?B?a3Y5TWczcFdmcXlBZDJpTDU5TVVuUU9BWDltUzgyYXRGNDdEaGs1Tk1FREMy?=
 =?utf-8?B?aUd3Y3R1L3J1YzFYbVdzTzRRRjROTVBxRHArQzdwSlhzNHZhdHF3bVRnVlhH?=
 =?utf-8?B?eUFlMmNXdkUzR2RHaWIyVXlzYWxVVnN5Z0VvMEo0bFhjQmMwK1BnSEN2dFJj?=
 =?utf-8?B?cm4yN3FiQzRBQlRxbnNVK3IrNEwwN1dGTzJTSU56czUxVHgzTklKVWJncnZs?=
 =?utf-8?B?R3hrU01pdlR2Q1cvTWlvL2ZnMm9nQ2lSZEdkZ1NFYVhiZVhkeENXSVMwbE1G?=
 =?utf-8?B?YVpoRElRUmNPR05Oa1RIZjRWR2xtTE1zWkpYKzhiK1htUDZNeEtuTHlaUmNv?=
 =?utf-8?B?RFUrVVdLWGhSdWREV1dYSDFkaVVNU2g1OGU4WjE3ZkVOc0Nwc0sxdjc2MW9R?=
 =?utf-8?B?anF4Z01HdnVvRGFPN2Z5cFJjRDdpWHcwRkE5dmFGZ3hyWnFGOU1wWG5LRmNO?=
 =?utf-8?B?S3JhRGJyZzRjTmZoUWRwQ1l6OHBiVHM2RHBla2dOMDN4K3VNeVNJaU1BOHp5?=
 =?utf-8?B?MTF2RkVqM3d0MExSY1ZFQStGS0tiWjIrYmRib0syYjFOeGp1aEl3NDcrcGJG?=
 =?utf-8?B?WW5aZHYrcVhiYldLZ21SZVZEczdyTTl1RU5zdHZrM1dQNjY0dk5kZ3hoWlVE?=
 =?utf-8?B?VGhCTXg5Q3lsaFp0eGpXU0pUaWpaYTNBT1FDK2VwR1pKMkh1Q1J0c2VFTnRq?=
 =?utf-8?B?NmwzWXdITXJKcmdHK0xWU2ltclUxeExCV2JBc3QwSFoyK1grRWZJZmxleEhl?=
 =?utf-8?B?WFBsazhzUUZoby81Z3VpdUNlMktDbUJzMjFZY1F3UWFUMlVNdm94aHE3K0J5?=
 =?utf-8?B?dDJUVVI2V1YyZHdOTjRVYW5NVnZDc3BwYVFKc0dUamVCYVE0SlkzMWJ3NS94?=
 =?utf-8?B?ZUFRa0VHWld1Z24vZHNHK3NOL3lYWUQrZjJvK25XeFYxbmFKVE9MZXU5NVJv?=
 =?utf-8?B?VGtoR2pGNFdlUUFieWVpQlkwWnJrS3lwSWNkVndzb3BNaFlkN1JGZkU1Y3hQ?=
 =?utf-8?B?S2Y5ejFpU0xldlA4YjEwb2wwNkhLdUZ3N3hpNzYwcllQRSs3RjQwUXlvaXBl?=
 =?utf-8?Q?KpqKPAX5Kruj2nIlCzetebFv2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0682419017022C44B74147292EDCEEFA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796527f2-0c96-444d-9e41-08db8ef4952a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 22:55:32.8435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KxLlqIOIwDROI+RRM5y0a7mOw9hZaA2SFRpkHAfp6yru6q5LPXLlgS55qtoxc7bgwVKjeYtXZTdV43qWNq1mZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6717
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

T24gVGh1LCAyMDIzLTA3LTI3IGF0IDE1OjUyICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBXZWQsIEp1bCAyNiwgMjAyMyBhdCAxMToyNTowNFBNICsx
MjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gSWYgU0VBTUNBTEwgZmFpbHMgd2l0aCBWTUZhaWxJ
bnZhbGlkLCB0aGUgU0VBTSBzb2Z0d2FyZSAoZS5nLiwgdGhlIFREWA0KPiA+IG1vZHVsZSkgd29u
J3QgaGF2ZSBjaGFuY2UgdG8gc2V0IGFueSBvdXRwdXQgcmVnaXN0ZXIuICBTa2lwIHNhdmluZyB0
aGUNCj4gPiBvdXRwdXQgcmVnaXN0ZXJzIHRvIHRoZSBzdHJ1Y3R1cmUgaW4gdGhpcyBjYXNlLg0K
PiA+IA0KPiA+IEFsc28sIGFzICcuTG5vX291dHB1dF9zdHJ1Y3QnIGlzIHRoZSB2ZXJ5IGxhc3Qg
c3ltYm9sIGJlZm9yZSBSRVQsIHJlbmFtZQ0KPiA+IGl0IHRvICcuTG91dCcgdG8gbWFrZSBpdCBz
aG9ydC4NCj4gPiANCj4gPiBPcHBvcnR1bmlzdGljYWxseSBtYWtlIHRoZSBhc20gZGlyZWN0aXZl
cyB1bmluZGVudGVkLg0KPiA+IA0KPiA+IENjOiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5z
aHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNl
bkBsaW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFk
ZWFkLm9yZz4NCj4gPiBTdWdnZXN0ZWQtYnk6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFk
ZWFkLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5j
b20+DQo+ID4gLS0tDQo+ID4gDQo+ID4gdjIgLT4gdjM6DQo+ID4gIC0gTm8gY2hhbmdlLg0KPiA+
IA0KPiA+IHYxIC0+IHYyOg0KPiA+ICAtIEEgbmV3IHBhdGNoIHRvIGltcHJvdmUgU0VBTUNBTEwg
Vk1GYWlsSW52YWxpZCBmYWlsdXJlLCB3aXRoIHYxIHBhdGNoDQo+ID4gICAgIng4Ni90ZHg6IE1v
dmUgRlJBTUVfQkVHSU4vRU5EIHRvIFREWF9NT0RVTEVfQ0FMTCBhc20gbWFjcm8iIG1lcmdlZC4N
Cj4gPiANCj4gPiAtLS0NCj4gPiAgYXJjaC94ODYvY29jby90ZHgvdGRjYWxsLlMgICAgICB8ICAz
IC0tLQ0KPiA+ICBhcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4Y2FsbC5TIHwgMjkgKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25z
KCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvY29j
by90ZHgvdGRjYWxsLlMgYi9hcmNoL3g4Ni9jb2NvL3RkeC90ZGNhbGwuUw0KPiA+IGluZGV4IDJl
Y2E1ZjQzNzM0Zi4uZTVkNGI3ZDhlY2Q0IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2NvY28v
dGR4L3RkY2FsbC5TDQo+ID4gKysrIGIvYXJjaC94ODYvY29jby90ZHgvdGRjYWxsLlMNCj4gPiBA
QCAtNzgsMTAgKzc4LDcgQEANCj4gPiAgICogUmV0dXJuIHN0YXR1cyBvZiBURENBTEwgdmlhIFJB
WC4NCj4gPiAgICovDQo+ID4gIFNZTV9GVU5DX1NUQVJUKF9fdGR4X21vZHVsZV9jYWxsKQ0KPiA+
IC0JRlJBTUVfQkVHSU4NCj4gPiAgCVREWF9NT0RVTEVfQ0FMTCBob3N0PTANCj4gPiAtCUZSQU1F
X0VORA0KPiA+IC0JUkVUDQo+ID4gIFNZTV9GVU5DX0VORChfX3RkeF9tb2R1bGVfY2FsbCkNCj4g
PiAgDQo+IA0KPiBEbyB3ZSBzdGlsbCBuZWVkIHRvIGluY2x1ZGUgYXNtL2ZyYW1lLmggYWZ0ZXIg
dGhlIGNoYW5nZT8NCj4gDQoNCkZvciB0aGlzIHBhdGNoIHllcyBiZWNhdXNlIHdlIHN0aWxsIGhh
dmUgVERYX0hZUEVSQ0FMTCBtYWNybyBoZXJlLg0KDQpXZSBwcm9iYWJseSBjYW4gcmVtb3ZlIGl0
IGluIHRoZSBwYXRjaCB3aGVyZSBURFhfSFlQRVJDQUxMIGdldHMgcmVtb3ZlZC4NCg==
