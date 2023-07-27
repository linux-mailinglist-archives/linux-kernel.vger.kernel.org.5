Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA3C76601B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 01:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjG0XFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 19:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjG0XFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 19:05:47 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3396C30C5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690499146; x=1722035146;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kGZIs7MT6wwmmn5G7hHXAacyNdZlrE4JpExO8rJtWGc=;
  b=La/LMKqkf1guXD43C21AZQ1hBM2wb4TLdk84V/ts6s6flIOrP7YJbV/n
   vrhanKUePBmKDw/MW5NF2SqsBdRlm3HcmrUkiRojm2M79EQN4i9+yGAa/
   9sLXTRET/8evIeAW02ziMGnCWgRh6FSL48ayxf096rehf9sapLTAJBLJw
   ldDnKEq+06HRcWNI78DaMgkGRYrma3+KQj7qhKSH25QRibD4hsSCAUUDc
   489QgVWUHND50l+TgeOAx33Fd/KiwnRkD6bKWPlLWtgptf9RSRN1ovLyw
   uGcPYbf4QeWSGOq68TdxfwluzCNuoIUJukSMPSzpXhPQEf2quFT0dgqOW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348733414"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="348733414"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 16:05:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="901014803"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="901014803"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 27 Jul 2023 16:05:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 16:05:45 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 16:05:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 16:05:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 16:05:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrZziMsb2ayw8oF0P6VBOX4E2pzsJsoxwXIeJoR18cjXrw+h1Dg91ael2W4UjkUDkfbcQlkOZDBXcYCpVWUvprjYpjWZCmgp8326uH9tEosqiZEu9UU7nT2QMY1qPbKujblFZjeBxVOXqV3G0KZRkPSAcBZ4Gs2BH5bILFRR5gh/DcqeNjClnG6rsbz6FIdceDZx8jQGBwFPFsg8cD8iXWjeeOhgy5tTQ4ZIz3pebSOGlbD52xmZKrcS0a0qT21FJ8FJ4FYqX8QJL4dVRG33/Fp2mvd4DcZWJvu+FBaXZWu71PTiyGKBBgSdPtG4aiJNQUW9NgbLPQdYj7QjaNFcnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGZIs7MT6wwmmn5G7hHXAacyNdZlrE4JpExO8rJtWGc=;
 b=Ez/MnjB4ceMnGlU7hyZPrXPdSmqvWHsyaCMohG1/j+4tdlHXVpdVpaU/M9p9EBoo6xXF9NwMdr6jTbot8wED4wHfwG/t9iE69kQjSfmPpggxWWrOHatfBDEcNnqA4ugGO8HKrWZvvSnpJyvL8YQK6+Cwloc2wLACdv3j+cKX9hJTV6BXJPhywOM8PzcfIJRMNFIIJtCBxc8gnNzW6f+dhoo58CPh+PM5ruLedfjNv9fvFVJo27ycEWI5g6koeSOJpYmZiY8Zl9DNG+GL0wx4liUdYOEfoXsymNGPqIX3ck9ky6I1bnqFV1rwLgEbUIsCHKeZmBrHdBDPspj69G07eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB7121.namprd11.prod.outlook.com (2603:10b6:510:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 23:05:35 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 23:05:35 +0000
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
Subject: Re: [PATCH v3 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Thread-Topic: [PATCH v3 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Thread-Index: AQHZv7Ew9wXfCjaIFkeFM7YTTvK7Ya/N2wEAgABjTAA=
Date:   Thu, 27 Jul 2023 23:05:35 +0000
Message-ID: <e75603996f88941892a19181c852ecfdc9adf06c.camel@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
         <6f92d08855491b3e9ff1221d2bb7af873d546afd.1690369495.git.kai.huang@intel.com>
         <20230727171008.aw3z6oxh4vfnahep@box.shutemov.name>
In-Reply-To: <20230727171008.aw3z6oxh4vfnahep@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB7121:EE_
x-ms-office365-filtering-correlation-id: e4a22c5d-f6e0-4729-ea2b-08db8ef5fc32
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3HqtY37B1AxvGdQurpHLouQ2vVNPOURHzqcwt1fZmuK37wAdZjUP3g7CUdo45AkMzaDizxoD2EvoXXSxmRs73tjRyFhY0PYdTqs/613sitlvcQ9d+/7XMq/UgoYadRz7M3PplNjkWumvPOXvISnMukvb5dFVPszgoZE/ZpR2ClEsGbl2x6tcaCGcB2GmYWIJ+qYYUXvhN0FqARlYgoTQiHLGmSi4rJy+ln0LctJ2VGqi7PiMLcqA9EY3E7mih0rtokdGljy23udA19aCTWLP+Y3KEfvZ0E15mdmtd6556kCVmyAF31WiZkDqBBnFB6VUE5DYVbgihGQS5yU86gZ54apPeUtV1xNzPQi4m1L02KtRRZcrf2SPukxXhNumQuQDsfPVu72SGbAQv5vs9GPJwT9dO8qsD9hB6gN7Q564M1qiijFzsK/Jf3EZOb8qvkCoeZMXbv2FC6tt/wxNVBJRK9jWBRCChkeinnJY6EjMo/kmz0lOLB8VsdzHEk6vJtCXPz4gyvRq46CleaWw8aaOv6hdopJiDXgyZk2GqeR4Wu4hJLF/clqeGNmzuB6DDxdrSQDKQxe98PP/5rgxlz7FLJ9i3m+78tQiaugRq1iokntWoTCdljWQxhu/eRks2lox
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(54906003)(6512007)(6486002)(478600001)(71200400001)(186003)(26005)(6506007)(5660300002)(66446008)(4744005)(66556008)(2906002)(66476007)(6916009)(316002)(76116006)(7416002)(2616005)(41300700001)(8676002)(91956017)(66946007)(4326008)(8936002)(122000001)(64756008)(82960400001)(38100700002)(86362001)(36756003)(38070700005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGF0WE1tTzY4NExaZUVrV2hyZU5FQllvbjgzSVh4QktudDJYMzJod1AzRDR1?=
 =?utf-8?B?OTJxMjBQOTA3aHpFUDNjT0g2L1Bsa2NVazlwdkZzRWp5NzUxSHFYbC9NbmdE?=
 =?utf-8?B?UG9CQmQ5YzdBcGVUUUNiMTluL2lGVU5kbE9HSnJjekZvTnFCcFJhZWFLMEVL?=
 =?utf-8?B?V1B0YkhwcjMyc1RoQ2hwYmJZbXdpRlFXNzgxTFIrNVFTVGhKS1czMWVLQXlv?=
 =?utf-8?B?bFFFbS9mWkJHLzY3R09aazRQcnpieXg4NGx1RktYTHhYalQzOXpsckhlYnQr?=
 =?utf-8?B?dlFTZFJ2RFJlY2hEZWRtMjNkRFZ6YnUxT1FCaGxRbjZ2RGU0MFhka2wvUTRN?=
 =?utf-8?B?OHZ6MjIxRVE3NithT2dWVW5HbEVjSU9KYjJVT1V2ZEdLWjd3S0RJNVMzY0wz?=
 =?utf-8?B?RWNKOHdRSU44YkJDcmZlS0tVVlJTNkwyVUhqYVhIUkVpdURCMmdlenAwNmZG?=
 =?utf-8?B?U0tDT3lHamFyVFdGeWVKVjdEanFIa2RQRXZabStIOExQa291MTQwZVBaWGND?=
 =?utf-8?B?SS9maG9nOWN3YmVSaURObHdlbXU4Z1BwTEZVZmRQOENmRTJLc29kaWhyVkk4?=
 =?utf-8?B?eVEwMUZROG1BRjNzTGRXZkdGamZPLzRiOWFBd2Q5VFJxTFZMM3JzaCtkR3BY?=
 =?utf-8?B?ZmVXSnU4ZlhLbTNlUS9Tcml0UnlpL01LRlZ0Z2pvS05BWGdXdUVYWEx4V3B3?=
 =?utf-8?B?Rnh2Vm9QR21oR2pnZmcyeHlmYzhWa3VMVVBLdEpoSGZYNzYvQWluSk5Oam96?=
 =?utf-8?B?TzFlZzFYTUd1OHV6MEZPbnE3N2ZuS05oZmxubDFxMTVpUjFhd1ZzbldGa1ht?=
 =?utf-8?B?cTN0Q3cyNUpGbGZETGszUGtZQ0JNc2Rtbzg5aGpjMExOMHh1VWl4cTVoODFU?=
 =?utf-8?B?bUp6TFI2blc2d01yTkVPenVZR3ZDM0ZDdDcwSGQ1ZGtOMVhiNElYN2ZFdmNj?=
 =?utf-8?B?MWMyZmRIaEJ0NU1EVzNqaU1sdXE4UGJkOGFrWTIxam9Hb1drcTY0Y2lhSjJH?=
 =?utf-8?B?SHMvTGVwazRYUHJvTE1BUy8zUEhwNGxjS3dhYWxxUFJkTzlKMzJ0SEpscXFx?=
 =?utf-8?B?bUh5U0R4UXlwM0xpRWRQNDV3THBlbzBQOG81alM0ajArNnJOQ0ZncVRvc3dj?=
 =?utf-8?B?blRIU0xZdHFGWkVuTjRWd1ZlRkhXWC9NRU9wZGRFNFNWUzduVjZJL2NRSzJ4?=
 =?utf-8?B?RTVxT1BsV2lpeDVtbEhMSjFZVzVOMGxiYTdQcjVHMmovd1o3cUFST0RleHQw?=
 =?utf-8?B?bWpBcytEajlBTERMUlA2MzFSdUFtdU1XVHJkcUxUSndXZ3hGWTJ5VlNIcUQ0?=
 =?utf-8?B?L2JtVVRWUzNpSlVaWGZSY0VsSzlUSUtWaTRPQmVRVXVQVzg2T3VJaUJDNzJX?=
 =?utf-8?B?V09zN3pyMmNNZFFHaURwTnRCbDk0RTZtSUs0TUZjQ3ZCNTN4alp4Zm9qZXFD?=
 =?utf-8?B?VjZEVCtueUZGRVROcC9UMDhmWVM3ZjlKK3BNR2p6S3V4Wk42V1pOR1VvS0ZU?=
 =?utf-8?B?MThWYzVQdHFzenRBc0pPUkUrcjc0SkplUnN5Z1U5YWhmQkFPczl0VVB3Q3pV?=
 =?utf-8?B?cGVXVWlJZm5EeXZiNk5ha25ZRmdvKzZnTTRUV1kvWmw2N2F0dEgxbUdEMTJZ?=
 =?utf-8?B?TFdOQWUvL0czK3pnaWpOVWZ3aXh0OFNiaDNXbVVScWphUEI2MmZXeGppSHR4?=
 =?utf-8?B?TXdHdWJmemhOdml3c0krQWtVTHpBYmtXc3VjeGtUQUVnRFdkM2kwd1g5K1pW?=
 =?utf-8?B?RzZLekJXUllPWVE4S0IrSzVmRm56SDhPOWYzbHFWOXUzK1NWb3RKNGhmNVh1?=
 =?utf-8?B?ZlU1bmFzdmliSHQ1STQwS0NCckFoVkplNGpRcUR2aTgzL3Z1M3JKSk9xaWx2?=
 =?utf-8?B?cTQ3T1c4N0s0N29zLzN6MFN0RjQ5R1lPSm5mTStLNXRNQWE1OWFlUzJ5VC9k?=
 =?utf-8?B?SkY2QVNYQUVEQVJ1dVQ3UGIzaDBHMUdwRmIyNUdzblBuYWwrUExzMXhUVzVk?=
 =?utf-8?B?VGtEY0dFeEhQYVVYcVIvQWdJaTM1WUNnckhqTkhTcWdaWFoyYTFvOHpmblJq?=
 =?utf-8?B?ZUkwM2tTWG12TWFNcGJrOWVxWlI4dUc0NlFtbnZoWFFxM2MwV1d5clVJTXlm?=
 =?utf-8?Q?DVCLuZ2t7dIfmGFzEdYVGne+V?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1734DC0DB682144DB01BDD1AE2623CF7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a22c5d-f6e0-4729-ea2b-08db8ef5fc32
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 23:05:35.2149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03GWwRvNlzaFV6bjKgEkxXGq71txH95JQViITq6QMenc3lfJvz/AtYVet2sy+d99CZvvoJhiTIuatukim5xSmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7121
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

T24gVGh1LCAyMDIzLTA3LTI3IGF0IDIwOjEwICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBXZWQsIEp1bCAyNiwgMjAyMyBhdCAxMToyNTowOVBNICsx
MjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gDQo+ID4gUmVtb3ZlIHRoZSBfX3RkeF9oeXBlcmNh
bGxfcmV0KCkgYXMgX190ZHhfaHlwZXJjYWxsKCkgYWxyZWFkeSBkb2VzIHNvLg0KPiANCj4gSG0u
IFNvIHdlIG5vdyB1cGRhdGUgc3RydWN0IG9uIGFsbCBWTUNBTExzLiBJcyBpdCBhIGdvb2QgaWRl
YT/CoA0KPiANCg0KRG8geW91IG1lYW4gd2UgInVuY29uZGl0aW9uYWxseSBzYXZlIG91dHB1dCBy
ZWdpc3RlcnMgdG8gIHRoZSBzdHJ1Y3R1cmUiLCByaWdodD8NCg0KPiBXZSBnaXZlDQo+IG1vcmUg
Y29udHJvbCB0byBWTU0gd2hlcmUgaXQgaXMgbm90IG5lZWRlZC7CoA0KPiANCg0KSSBkb24ndCBx
dWl0ZSBmb2xsb3cgdGhpcy4gIENhbiB5b3UgZWxhYm9yYXRlPw0KDQpEbyB5b3Ugd29ycnkgYWJv
dXQgVk1NIGJlaW5nIG1hbGljaW91cyBhbmQgcHV0dGluZyBtYWxpY2lvdXMgdmFsdWVzIHRvIHRo
ZQ0KcmVnaXN0ZXJzPw0KDQo+IEkgd291bGQgcmF0aGVyIGtlZXAgdGhlIHN0cnVjdA0KPiByZWFk
LW9ubHkgd2hlcmUgcG9zc2libGUuDQo+IA0KDQpXZSBjYW4gYWNoaWV2ZSB0aGlzIGlmIHRoZXJl
J3MgYSBjbGVhbiB3YXkgdG8gZG8sIGJ1dCBJIGRvbid0IHNlZSB0aGF0Lg0K
