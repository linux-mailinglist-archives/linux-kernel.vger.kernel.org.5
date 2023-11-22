Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACADF7F4F78
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjKVS0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjKVSZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:25:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765BB1FEC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 10:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700677508; x=1732213508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m+KeDiFPGCVRDdzXqmZgr7/InfUFUFxjpOFJ/WkX41g=;
  b=P8QJxKPm54ZSH1OM/TfgpRL5K27O0eAMTM25gd/aO7pryR3ytnjO1/J+
   m/Owwz3X83Ioatp+49Cl6eJtjgWT7590aRzbuBSNSdptVZuwPRvizpuD7
   P/bghxHq/cuBrV8qVOV32oxiQ7B3Rc5m83xKkDtjnTs1LH5s74m3fyggM
   Bl9Kgv7VE0I1iuWeOXiwtiIGIFmxa9Bu8PAT8HLuKIn1sdUBa0vRSCjwe
   td6qRP2tB/Wz3bZ/GHr9EUPiKYsATxIn8WioqfrbnEIqYen6rm6wRzQXC
   q3Q7GqqijqE++5kA1UBGcHvWCMWhWZQFT/fRBYB/VpBJ1NzVlJBwRMIv3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="382518852"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="382518852"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 10:25:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="766950817"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="766950817"
Received: from unknown (HELO fmsmsx602.amr.corp.intel.com) ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 02:10:17 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 02:07:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 02:07:50 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 02:07:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyP+kBiF0xu0DGlZ5QtiyNYXH0+eeHeflW5XScN07CJGIRsDjTEIiF/xFYVYeeXbUHDOif1FUfQOleC+wndVsK5e5a0D8gVZ2CDUBPPDRYUVML3smEeq90VYbmby8kAvn7WHdwHGvinmtqEW137WFWRdBKcevPBAgiAQoPbIYrapywSSF9n8z1enm9h6Ybkckqcp10pml0bp9bp05Zn7TdzS6ipWjWLS+pEMUeGc1p/EHN9HinMpWvoOMsFDVoCnE4b0UDFv/cBuEZQhkxTdsk3X877+Y76O/bd9AiepBQQ1W6FWiqtV7474uLywUHPOrQsL3dBJBQC34vxXm7CWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+KeDiFPGCVRDdzXqmZgr7/InfUFUFxjpOFJ/WkX41g=;
 b=Atgx9und6LJgyO0VtqfHeKmsY0wblISymTNH/5rqC10wQCpsjy2fHkDfFGzw+wyKptoN2qNrZqSXEiMoh3dRAexVxdBnUPV+DNvp0QL0/xf13K7YE66RF/vZ5AaUw2tZsiuiX4n0G5TOANLlZI/XdxHsuNuVY7flaw1v8Gmm0CqRLXnJVj8JGYzKE7vmU1UApxHgKmMhJQohyqo6M8RnDd908ywEg39vomKZBQb0MIxukUt48rlhzBlXKzca48FoYsBpOqrGKKZlV10tNNDAD6LZ+iHik4Y15vNn+tNuNjxXIgsLYF7GrcE/z4qjOYVffSGbqLzTTe2At/laslSUpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA2PR11MB5098.namprd11.prod.outlook.com (2603:10b6:806:11c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 10:07:44 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 10:07:44 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv3 10/14] x86/tdx: Convert shared memory back to private on
 kexec
Thread-Topic: [PATCHv3 10/14] x86/tdx: Convert shared memory back to private
 on kexec
Thread-Index: AQHaF7t4jzxmtwRfDku+BnGgRkzK3LCEKzGAgABoCYCAAZTDgA==
Date:   Wed, 22 Nov 2023 10:07:44 +0000
Message-ID: <d7ac53b76217abbb9bc06717b76ec91a376ba210.camel@intel.com>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
         <20231115120044.8034-11-kirill.shutemov@linux.intel.com>
         <8277e9a1df4c3fd968edf670b0aa7dc1dd50dcf8.camel@intel.com>
         <20231121095859.36xiltn2gwgyxmwy@box.shutemov.name>
In-Reply-To: <20231121095859.36xiltn2gwgyxmwy@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA2PR11MB5098:EE_
x-ms-office365-filtering-correlation-id: 06e71cee-b5d0-4598-d380-08dbeb42dee8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pUyDlV3RJ8eKznxbnHH7pleGCcHWBU0MoojcVQZgMIutqYregAngvaAzjG7UhVXkG0ByD5LX11k/20c3s622i/P7EG9r8V6E2Hvq4U9P0KEHsUqeUuHjAPtldEg5VLKtpAjaD37bnvbLL9ccRQIg2bznmZgNd/ewSMs3GWoDt+QUyOc3spuLaswj30zPoHFdCGzPkeSK4z9dO/8EdOopRBDh50H/63S4B9c+/WVLKfFuGhA7+aQHaCJJhbATJjVfcF0dw9KrEYEp0zuLyoOqzNcxuResxT/rC6tQlVrOt2DT6N/pNxubmAfk4aTYGVZC9atOWtvJyUALr5VMFX3bj568Xm/wXN2VPkbFNZVhEqsviBVnV7CFQRQHC9o7Id9sju9EdQecvA3Dre58L0z4/Qpf+yWATVIMJye4blrQ02IlDp88tGIasXBavLYMgiOJqAIjTPYh+LAR4A9q2RmErQzHJBw5/GblXt1jYv1GHEIwt1wl6OSE9W6ftIaa/ZLnyB5JtK5XfTdzEhxv2zcpft0Ijnm/l5XWNTE5PJc/DKVIHcxojUV2sOR1+6NHCVKveMX9RnUGRBLviKvRSckaASlyyqaegzQqaXGs/1AIX174NVsuKw0XAoFeM0tEbKdpo/SEFsm2I0BkFRFuqux9iA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(2616005)(6486002)(6512007)(83380400001)(6506007)(71200400001)(8676002)(4326008)(8936002)(41300700001)(2906002)(4001150100001)(7416002)(478600001)(5660300002)(316002)(6916009)(91956017)(54906003)(64756008)(66446008)(66556008)(66946007)(76116006)(66476007)(86362001)(36756003)(38100700002)(82960400001)(122000001)(38070700009)(60764002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjdxTFQvc0VMQTVXaHozZFFUbVl1cVRrcVRBVnVVc0hTcnhkQzA3Z3VDNVhD?=
 =?utf-8?B?cnBKUUFoWDBUQ1pOb1NOcldWY2FvYStnWHVPZmluTHhNbjlMK2dJcVVRdVJ0?=
 =?utf-8?B?T242Mmp2RTRETGtTMU5FMVZzRlM3V3kzMEE3OHQ4S3lJV0k4aFJIVVhLVENs?=
 =?utf-8?B?WWZESDI2czBwYkdBMDhMekIrSUpGTlFEWkZqZ0RycUozZWxJdFZmcGRTVkNI?=
 =?utf-8?B?NTdtK2c4UmdEcTNIM0trdG51a1EzWlpBVk5WQ1BMSGE5SGlmK0NZQW9XcWd0?=
 =?utf-8?B?NDUyQWo2aDBqbkpCWmFFVElIb1MzamQ2WlJqekZqM1ZBYnV2am1kNHhTZEs5?=
 =?utf-8?B?eFVmSC9GYjY1VzBQREVrcThNL0ZXVms1SHQ3RWgyQ1JCaWJwTWlwMFpKRXpX?=
 =?utf-8?B?QXk4TE9tRkdvSks4VUYyMW1hbDNJcW5XVTI2eDVTMTc4U2EyVVc5ZW9qdGtZ?=
 =?utf-8?B?L0w4cWpaRVNicTNUSlpmaHJZRUJrYWpNS1phYSt6MDdPNkM0UXpaaW1mOFRx?=
 =?utf-8?B?Wi9BV1BBK0xLa1d4cWx6eHo4b2gwMEcwOXUybHVzWTB4MGdwUDNMK0cwV2FB?=
 =?utf-8?B?WkhCOFR2c0xXVzlBcEc5Mi8wOFF6bzdaRlNBUEdDRXUvaktuMlJ6U0hGbzVT?=
 =?utf-8?B?dlFmSmF5bTlqYmlONVcwSEhYZElYenBWRXJjVEdqNVlHUlVpQzFCaHJGdmNE?=
 =?utf-8?B?SXVFNkc3amZzZENHRG44eDkwNTh3TWtnYmk5Z1A5ZkJvUXNKa1FIc3NpZVpE?=
 =?utf-8?B?dXpFS1pTQUxlb29NRmpuZU9ySnAvS2F1Wm9Ia2lEQk8xcVJaaHQ5YU8wcjJR?=
 =?utf-8?B?ak5KQnE5RElMVHZnRnNxdEdISTNHOEpQNTlUN2U1aWxKcmVCckR5blBSR282?=
 =?utf-8?B?VFJ6OEFtVDZkc2lQUWFDcWdTcmVCQVZHNXJ6dzVWNWQxcHZLRTMrQ3hyRmk5?=
 =?utf-8?B?dW9lUHduM09FbVBRR0JsbndRNTBJMCtpc3NQL1pmL2NvTzFNYVdYYkUybzFU?=
 =?utf-8?B?Smc4TXhzY1l5dGo3MFBaWFJkczZETVN1K1J1V0NGOGF5U3QwVlNpK2Ivb01k?=
 =?utf-8?B?VnVEMWgvRmV2d0dXeDBLYmZWK00yL0RqRVBuYS9TTENpSTlGVWV2MnRUNXV6?=
 =?utf-8?B?WDJoUUtOei9jTGVSaS9RSm5YcDgwOVpuQXNKK3FOaXhaeWFIdnFJMitxSlM3?=
 =?utf-8?B?ejFjZXYxOXlveFF4akRLVFF1YTZHTUlpOHZSQUZiNDcydjJ1cTl1dUU3Q2pj?=
 =?utf-8?B?UU01WERkdFpxOW5ISTZ4OVVaUE1VZmJiKzFrYzV0cytuZ1VOWWpyVkZXWHN2?=
 =?utf-8?B?bGtOcTNUZXNFbkEyRTVqbUQ0cDA3aWt2cXh6c0dvU2pYc1RJcGZRYVo0elht?=
 =?utf-8?B?bVBzMVdERldLR0VxNUg5UStES0Z0VzJ3MzFCMDZtNXJhT0tFbFlic1hoa0cw?=
 =?utf-8?B?RTBjVEhXUzM3aVZtN3ZFQ3B2eGhHQVlnVXEzMzlKUXpnVmdLZSt0TFBKbDRJ?=
 =?utf-8?B?RXJIMmlnWVhuQXYxLytIMDhJbXRwcmVQcnVydEUxalBjWDdhbDNpcG9FTkFw?=
 =?utf-8?B?SkFid0VxR0lDbEl0dGhTUmdMY3pLL2sya1VxbWlvSldBdWZnZm5jeS9mYzNv?=
 =?utf-8?B?VTk2ckJ0L3dlVTV4WjhYNmFhbHFLd0g5YmczYW5JTThycVc2SDUwZlNPV1VB?=
 =?utf-8?B?cHNzVlRYeW14MmUweDdiRnhLejFveWJBUmJHNEY5WWdyZGZVRWEvNGdhaVNY?=
 =?utf-8?B?Vk0xdlRNQ2tta0FPRENFcWNjKzFYQzZDOTkwQm1VendWZUxIWktxa2pNdm5B?=
 =?utf-8?B?bVl0M2daZ1JXT1pUMU9CNFZ2RzFJMFJPN1VPT2poMStRelZFNlJyaUpySDRK?=
 =?utf-8?B?S1Z3WjllZmJRZERaTlo3WTdBSXpDelU5VUE5QmNaeTVVRElXRzh6eitYNFNn?=
 =?utf-8?B?eHBPelREVFlFOWJzakVkNXc0WU5xWFhENzJJcjMzU0FianV3amZEdmNhMGZF?=
 =?utf-8?B?WlJ2UWM5TjVnVkRRUTh0U3ZKY0Z4cGh5MkpmYXFHdmJpQkxYMlVjYXN3cm1V?=
 =?utf-8?B?bFcyWXBPZ09ESjFvbk5yZGwycXRCMktQQXBRNjIwS0JEc1lyMkQ3YWNRTHZq?=
 =?utf-8?B?eWpsVnhZUE1RS2RvL014SE5tUWVKa2UzTnUrcGRCK05mdGpkcEFVWGNPc29N?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F35F81FE9B284D4EA0939E818DDA7C7C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e71cee-b5d0-4598-d380-08dbeb42dee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 10:07:44.2729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHtqhsHJtCosm9fwu/G6c4LFQNMZGveu2yVn61gYg7NscimrEqK64WyXWNtVTNPil2lMIESYE6iBE+w9y0ELmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5098
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTExLTIxIGF0IDEyOjU4ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBUdWUsIE5vdiAyMSwgMjAyMyBhdCAwMzo0Njo0MUFNICsw
MDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+IA0KPiA+ID4gIA0KPiA+ID4gK3N0YXRpYyBhdG9t
aWNfdCBjb252ZXJzaW9uc19pbl9wcm9ncmVzczsNCj4gPiA+ICtzdGF0aWMgYm9vbCBjb252ZXJz
aW9uX2FsbG93ZWQgPSB0cnVlOw0KPiA+ID4gDQo+ID4gDQo+ID4gWy4uLl0NCj4gPiANCj4gPiA+
ICAvKiBVc2VkIHdoaWxlIHByZXBhcmluZyBtZW1vcnkgbWFwIGVudHJpZXMgZm9yIHNlY29uZCBr
ZXJuZWwgKi8NCj4gPiA+ICBzdHJ1Y3QgY3Jhc2hfbWVtbWFwX2RhdGEgew0KPiA+ID4gQEAgLTEw
Nyw2ICsxMDgsOSBAQCB2b2lkIG5hdGl2ZV9tYWNoaW5lX2NyYXNoX3NodXRkb3duKHN0cnVjdCBw
dF9yZWdzICpyZWdzKQ0KPiA+ID4gIA0KPiA+ID4gIAljcmFzaF9zbXBfc2VuZF9zdG9wKCk7DQo+
ID4gPiAgDQo+ID4gPiArCWlmIChjY19wbGF0Zm9ybV9oYXMoQ0NfQVRUUl9HVUVTVF9NRU1fRU5D
UllQVCkpDQo+ID4gPiArCQl4ODZfcGxhdGZvcm0uZ3Vlc3QuZW5jX2tleGVjX3Vuc2hhcmVfbWVt
KHRydWUpOw0KPiA+ID4gKw0KPiA+ID4gIAljcHVfZW1lcmdlbmN5X2Rpc2FibGVfdmlydHVhbGl6
YXRpb24oKTsNCj4gPiA+ICANCj4gPiA+ICAJLyoNCj4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9rZXJuZWwvcmVib290LmMgYi9hcmNoL3g4Ni9rZXJuZWwvcmVib290LmMNCj4gPiA+IGluZGV4
IDgzMDQyNWU2ZDM4ZS4uOWZiMzAyNTYyYmZkIDEwMDY0NA0KPiA+ID4gLS0tIGEvYXJjaC94ODYv
a2VybmVsL3JlYm9vdC5jDQo+ID4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvcmVib290LmMNCj4g
PiA+IEBAIC0xMiw2ICsxMiw3IEBADQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+
ID4gPiAgI2luY2x1ZGUgPGxpbnV4L29ianRvb2wuaD4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgv
cGd0YWJsZS5oPg0KPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9rZXhlYy5oPg0KPiA+ID4gICNpbmNs
dWRlIDxhY3BpL3JlYm9vdC5oPg0KPiA+ID4gICNpbmNsdWRlIDxhc20vaW8uaD4NCj4gPiA+ICAj
aW5jbHVkZSA8YXNtL2FwaWMuaD4NCj4gPiA+IEBAIC0zMSw2ICszMiw3IEBADQo+ID4gPiAgI2lu
Y2x1ZGUgPGFzbS9yZWFsbW9kZS5oPg0KPiA+ID4gICNpbmNsdWRlIDxhc20veDg2X2luaXQuaD4N
Cj4gPiA+ICAjaW5jbHVkZSA8YXNtL2VmaS5oPg0KPiA+ID4gKyNpbmNsdWRlIDxhc20vdGR4Lmg+
DQo+ID4gPiAgDQo+ID4gPiAgLyoNCj4gPiA+ICAgKiBQb3dlciBvZmYgZnVuY3Rpb24sIGlmIGFu
eQ0KPiA+ID4gQEAgLTcxNiw2ICs3MTgsOSBAQCBzdGF0aWMgdm9pZCBuYXRpdmVfbWFjaGluZV9l
bWVyZ2VuY3lfcmVzdGFydCh2b2lkKQ0KPiA+ID4gIA0KPiA+ID4gIHZvaWQgbmF0aXZlX21hY2hp
bmVfc2h1dGRvd24odm9pZCkNCj4gPiA+ICB7DQo+ID4gPiArCWlmIChjY19wbGF0Zm9ybV9oYXMo
Q0NfQVRUUl9HVUVTVF9NRU1fRU5DUllQVCkgJiYga2V4ZWNfaW5fcHJvZ3Jlc3MpDQo+ID4gPiAr
CQl4ODZfcGxhdGZvcm0uZ3Vlc3QuZW5jX2tleGVjX3Vuc2hhcmVfbWVtKGZhbHNlKTsNCj4gPiA+
ICsNCj4gPiA+ICAJLyogU3RvcCB0aGUgY3B1cyBhbmQgYXBpY3MgKi8NCj4gPiA+ICAjaWZkZWYg
Q09ORklHX1g4Nl9JT19BUElDDQo+ID4gPiAgCS8qDQo+ID4gDQo+ID4gSW4gbmF0aXZlX21hY2hp
bmVfY3Jhc2hfc2h1dGRvd24oKSB0aGUgInVuc2hhcmUiIGlzIGNhbGxlZCBhZnRlcg0KPiA+IGNy
YXNoX3NtcF9zZW5kX3N0b3AoKSwgYnV0IGhlcmUgaXQncyBjYWxsZWQgYmVmb3JlIHRoZSBzdG9w
X290aGVyX2NwdXMoKS4NCj4gPiANCj4gPiBJIGFtIHdvbmRlcmluZyBpZiB5b3UgY2FsbCAidW5z
aGFyZSIgYWZ0ZXIgc3RvcF9vdGhlcl9jcHVzKCksIGNhbiB3ZSBndWFyYW50ZWUNCj4gPiB0aGVy
ZSdzIG9ubHkgb25lIGNwdSBydW5uaW5nIGluIGJvdGggbm9ybWFsIGFuZCBjcmFzaCBrZXhlYyBp
biB3aGljaCBjYXNlIHlvdQ0KPiA+IG1pZ2h0IGJlIGFibGUgdG8gZ2V0IHJpZCBvZiB0aGUgImNv
bnZlcnNpb25zX2luX3Byb2dyZXNzIiBhbmQNCj4gPiAiY29udmVyc2lvbl9hbGxvd2VkIiBhYm92
ZT8NCj4gDQo+IEZvciBub3JtYWwga2V4ZWMgd2UgbmVlZCB0byBrZWVwIG90aGVyIENQVXMgZ29p
bmcgc28gdGhleSBjYW4gZmluaXNoDQo+IGNvbnZlcnNpb24gY2xlYW5seSBhbmQgZ2V0IHVzIHRv
IHRoZSBrbm93biBzdGF0ZS4gTm90ZSB0aGF0IHRoZSBjb252ZXJzaW9uDQo+IGlzIG5vdCBhdG9t
aWMgd3J0IHByZWVtcHRpb24uDQoNClllYWggbWFrZXMgc2Vuc2UuDQoNCkFkZCBhIGNvbW1lbnQg
dG8gZXhwbGFpbiB0aGlzPyAgVGhhdCB3b3VsZCBoZWxwIHRvIHJlbWluZCB1cyB3aGVuIHdlIGxv
b2sgYXQgdGhlDQpjb2RlIGxpa2UgeWVhcnMgbGF0ZXIuDQoNCj4gDQo+IEluIGNyYXNoIHNjZW5h
cmlvIHdlIGRvIHRoZSBiZXN0IGVmZm9ydDogZGV0ZWN0IGlmIHdlIHJhY2Ugd2l0aCBjb252ZXJz
aW9uDQo+IGFuZCByZXBvcnQuIFdlIGNhbm5vdCByZWFsbHkgd2FpdCBmb3IgY29udmVyc2lvbnMg
dG8gZmluaXNoOiB3ZSBnZXQgaW50bw0KPiBjcmFzaCBwYXRoIHdpdGggSVJRcyBkaXNhYmxlZCBh
bmQgaW4gZ2VuZXJhbGx5IHVua25vd24gc3RhdGUuDQo+IA0KDQpNYXliZSBpdCdzIGdvb2QgaWRl
YSB0byBhZGQgYSBURFZNQ0FMTCB0byBxdWVyeSBwYWdlIHN0YXR1cyBmcm9tIHRoZSBURFggbW9k
dWxlPw0KSW4gdGhhdCBjYXNlIHdlIGNhbiBhdm9pZCB0aGUgaW5hY2N1cmFjeSB3aGVuIGxvb2tp
bmcgYXQgdGhlIHBhZ2UgdGFibGUuDQoNCg0K
