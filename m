Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5717D8B67
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 00:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjJZWH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 18:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjJZWH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 18:07:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF24CA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 15:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698358074; x=1729894074;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=SEMwZnE5/GcSepFRXfTB3sFyA5NQ3bAqz9hAG1+OPuc=;
  b=IzO/EMdjturMJjyfohzkRmVjeCZiQg5EXB9SVX44cmojPUFJMRfQ4JVu
   XN/ztodyZPuVLFXCSsltZH5dKtt+rIjYAhrcMmq1Pj4b71rj7wF5z9nRO
   REPTFD3nyoGwDrtITeHzAwxa1V18rLysUjq0c2hzHUNBBZzmrzd57fVao
   aIUM/zel3mf/eYAutKPVsfJ1nZju9yvf3CLEIE0xpQPVRXvPFu5jjJMPB
   6Aokv/vY0oeod3aXPmrk9CNt8himkEcuf4pXxP2I3eEZ31NZeEVa3ROOB
   K388RKuh05pq2ArdQYJvgVEWvD5JqCKmWlvnPRFNJpq47+2qq7MdGO600
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="454121986"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="454121986"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 15:07:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="709226261"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="709226261"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 15:07:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 15:07:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 15:07:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 15:07:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehAIbVtxYOKJgyDHV1hCPhj/KxbiK27OxcmeudJgbsEvue1gJ36eHohpCez3nMfs47PA5qC467xOKaAv43jEbMehbQ5aqg2Z0uHinBBl8uYa2uqvZCRwzgSuc2GhEYKbh0yjIBp8UATq4+TI/veXSD9oZ4gxJvdbAsA/eY9ZhkEMGessSLlzhkm9Knye0NUhBGeZxVuiRRpNZZ21lIOEHsjh0Zp+EcTuEI9695zMGYpOu0ufSgBgZPZKNPs8eIYSeynZHTz21z07Iaxjw/yujS5/9Yuy0HfGtOPsUMLkhbdJMPVAaXt/dHo7j7kzuAVjuRVXyvWIiBUZWfBwWlTT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEMwZnE5/GcSepFRXfTB3sFyA5NQ3bAqz9hAG1+OPuc=;
 b=UbXuS7okytcu9+6TVoNraRGo9en761fFmVQZ//4bcZaPFE62j/Fgmcwo7O5HHVXYfrWlWCjzdnuPNVgaS5t/aDapfuKmJMOcTxZFIAqAo4FYuzufyuZYHYk59fnTpO58HXwFrFex2r1Km9b4He+cJSFyD1vIkTvbvm22UU52gA3h2NTjLftXxFZGliC38MAC8qSO/jTyj34jfFDW89XoNI/ukVSey0qTZFkGFNk83YEmIbURyHxzLWK799aO2CatZFqEbi07c2YsEdGU2xEvW70/ES15OCNNvWR5GFVP+O/pj5UXJodteQOv9G2lFkW7SBD4pUi27zIoHGoEJRcX6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 22:07:49 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1%4]) with mapi id 15.20.6907.028; Thu, 26 Oct 2023
 22:07:49 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Thread-Topic: [PATCH] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Thread-Index: AQHaBtSoD4BaRGvpYEWdXJl+rjaNYrBaz2cAgACEWgCAAMG2gIAAjpUA
Date:   Thu, 26 Oct 2023 22:07:48 +0000
Message-ID: <52fce857c1ad34417b0b0ced2e99c48ad3f746f6.camel@intel.com>
References: <20231024234829.1443125-1-rick.p.edgecombe@intel.com>
         <e30560cf-cb88-45de-963f-f99f9b06db75@linux.intel.com>
         <2a5e4fdb3f2d9f32262c0ba23f5535cf09559fc1.camel@intel.com>
         <06f701e6-f74e-1dbd-d021-07a78523900c@amd.com>
In-Reply-To: <06f701e6-f74e-1dbd-d021-07a78523900c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB7457:EE_
x-ms-office365-filtering-correlation-id: 092024c1-2e93-4736-52ae-08dbd66ffdc2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZE9vjMGmsHHliFGFaHM/fN1gYt1acl/0l8iGbNp7Hk7b+qpFKo61CNrSjbmmvBpHYfcVYllgT4KFTpdRqc2OIE1TdTZCeLINHYWNjaJK7LvN09o0YQG6n/agW0lE1sXeS122nUpzuzRyDJ2H8MYwA0CRTODY50Gaq6cmCvG+cdV9cIh2e9zfk63QlxLsh8J0q6e6bhmPvQEf2KsaAB3yqCkR+xcbGvSyAwAkKx8knFHmK6C2D2HWw5MwNy18syinakQjIGmfL/ixP5mokPs6NkWBmC2vW3f4E9TdMSAnDtotBLEmeXwDaMdWaXSDQHTXAISad9DDunBs8uazH/3i4RkmNQGGTFsj/dXJkPiFHkVU+V4W3YnQqzBTH0VyKuesqNrCiPcpDTWULyVKrRqiHpYgCjE76RBinjaynC4GPXj2SGbxjn6bD2JtkDUkUmvCKMuAfuMDs87czcpK9KDEtasWqfQDlQI44iXYTKEqC4c4ndSuu214G3LJDTtgqpirPqtC7Ok/dospcsHP1jcBhVmhED7Mz8OFxeRKGRgXncsWeRh3M86sKwdsMn/4umu8nB5FFZua6M53IZG1cGHD2yAvj2p4DV4Ta1AkyzvFslCeLWEGPeV/yYk6bvt0pRBc+VQWPmYZfHJJCWi42FcW2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(316002)(2906002)(4001150100001)(921008)(7416002)(5660300002)(26005)(82960400001)(38100700002)(66556008)(41300700001)(38070700009)(8676002)(8936002)(76116006)(91956017)(66946007)(2616005)(64756008)(66476007)(122000001)(6512007)(36756003)(110136005)(6506007)(71200400001)(478600001)(66446008)(558084003)(86362001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEtPVjJwSkRKZW16NkpxbER6OWdwcitUYmswSWlNeU1LemZkYkJ3YjlZNUxX?=
 =?utf-8?B?a2ZUaXkvVktmWStmTlVvd1JVTHNEVXNRMzJRVDJ2UWp5UCtWZFg3RHFSV2NB?=
 =?utf-8?B?MVNBK0lUbEJsdmkvZUZmWHdzRHJObzFtYW5mNzMrTjNLNFRoYnZxUHNOc2dC?=
 =?utf-8?B?U2pCY3JwcHRRd2xCbWxIL29ERUVIL29VYjM4OS9OV0dOa2g4SmYzbE1Na2hs?=
 =?utf-8?B?aStxSHRxZ0dkdjB3MGxLM1dFSDdsdTBBU2xGemNLVitjTzQxTGk0UjBkQVYy?=
 =?utf-8?B?MkE4enEwNkZsSmJmZHFNWHNUaFMvdVprd1BnS1dBUzZadGZXSGs2ODZKMmho?=
 =?utf-8?B?dzU1ZEFCNTRBMUJHTXRaOXdZVHRHWjhWb1hHN0QzdFBySzhVVngwVU9ZWEdz?=
 =?utf-8?B?UkhaLzBQR3NxdnhIcllFWTY0eXI4L09PZG9FTWZGSUI0Zmt5eWhDNG5qcnhv?=
 =?utf-8?B?S0R0M2FoMlBhUU02alA2TENMSitUa3MzK2k2elA4SDFTam83a0ZLWkZzOFIz?=
 =?utf-8?B?RWhuaDYyR2RTYjg3WmhjWWo1MEVKbE9HSFJsKzNVSExBZjBpQkltbWJoOElE?=
 =?utf-8?B?S1VZMEl4SElhdG8yOG9uQ01UR0ZDZUNQUU9wamNyN21LUVpQYXMzY2xFc1NC?=
 =?utf-8?B?VVNFVVZUa1hERlFNa0tVOXpncUF4ZWNNNkZSVkVNdnhyWmFtMWNzQnB2enV4?=
 =?utf-8?B?UWZzSGJrVzdkWFNnV25QR0duRTM1WmZnM3dmR21sUFlOd0tyZUk3UHYvZGQv?=
 =?utf-8?B?SXdzZ2dhazVNU1NEQ044QjZkaUhvRjZrcFF0ejh5QzlZUmNQQ0Vkbk1wVjhL?=
 =?utf-8?B?ZjA1MEZjMm9rRGVxWFg3blFlbHNXMENQVWRwOWhxaVdpR0kzb1BFeEhKbThE?=
 =?utf-8?B?RmJ5NjI2QWpNb1QvLzhnY3M5aU9icnVPRTNZV1JmTEpSb2dVRHRQT3FPYkNw?=
 =?utf-8?B?cU4yOTZTVTlIQm5LSFcwRTdpRkdtOXptNjNFaEJMcjRobmZ5MU55aG5wZ2ZQ?=
 =?utf-8?B?dklOZnlQWjlNN0JLMTNJaU40MVk0cVRVWTFvem5hSEZJNURPNnJZTkI0bXBD?=
 =?utf-8?B?eHQyRkJnYTd1SXpTcVhXSXRrVUVxNDN4MnQrSE1PUnBuY2VRNmVZclE0ci8y?=
 =?utf-8?B?MUhNTTd1TVR1dytiR0swYmNibkxSZG81eDN5ZGduTVZSRG1mYXBBNU5JU25X?=
 =?utf-8?B?ZWN6S2lUVlBjOWdxY3h5QW1BRHRqTE5IbGU4Q0xCa0VndTlGNWh1V2dyZFVD?=
 =?utf-8?B?RlIyRDl2b1lZQWlDcXBpK1o1d0x4ZnN2N2JmSFdTSk5STTBlSXVJUWR3akpu?=
 =?utf-8?B?NTNjeGxiYnhnV0dMV3BORm9RdjJaSlJNV0JraTJjM3dEa2ZjbnRkd0d2NEJK?=
 =?utf-8?B?T2tFMXZpTGVyR2U4YVl4bDMwV1dVY3p1dGlSR3VJdDNycVRoSUJOdU9SNjlv?=
 =?utf-8?B?L3JkMXoyYjJkWWxqMEZzVHg0RXRRbUZLS2ZWWDZEZkdtOFpwNnZOdHhIRUVF?=
 =?utf-8?B?SEdBMmtCT2pWZDVJMmRUNlQ2RmJPVk0zN3d1VGN2ekZySUhmTFBPQ1NpUy80?=
 =?utf-8?B?OWdqNmlrL3VrQm8rK3N2dURSS3N3MStEM2s2bnZ3UytMbnhuSEt6dkdHTy9E?=
 =?utf-8?B?dENLZU1kWXNjZ1ZwamlrQzBlWHN4cVAyYnpEQ2VlelBjKzI5MzYxaVVsNnJ6?=
 =?utf-8?B?RjVuR1crdU42aU1jV1VYMGNMYzN0L1V6YjEySDRVNmkycHBmQUV0NFkxd2hN?=
 =?utf-8?B?V1R0SllDaW44NDB5UDE0TjZKaFg4b0R3KzcyZThiaWgvVkZVSHJvaVJoem85?=
 =?utf-8?B?TFpjaEVQQ1dwSHBkMDBRU1R5aVVHRkZWTWh0Z08vVTdMcDhNRW5mRXFsQzZF?=
 =?utf-8?B?NXcrdEk5WFp0dzgzRVozZm93RXVmcGxzZThkQ3lkcWlpZUJqK1ZYaGFJZ1R1?=
 =?utf-8?B?MkNOdFQ0aHdod0QyMWRBcTNYdFNuR01nak1XVUI4L05ldXdDeFVIb1pnNFR6?=
 =?utf-8?B?SjVSbFhIbGZxTXpmQ1VqMVZNcGk0UEpGd3NwRERjZDIvR3JTZXBKd2pIUEZZ?=
 =?utf-8?B?M1VCTm9OemU0OTE3QWZhRk9jemR0cFZNeXo4TisxRmp3Y1NMVUV5emRyQjVK?=
 =?utf-8?B?ZW85NjdscXFibDBBT0xFSGkzMVNjZ0YzbjB3RVF6dXpJVmE5czY1MU5aMWVP?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D5CF7C930712243B38154D6F2E788C9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092024c1-2e93-4736-52ae-08dbd66ffdc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 22:07:49.0057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DqvjVDGnxLqO+XpZvekm+cSCmggYH4wN+kHDVWXt5Rd1hsOxCbBmhaPL6xvD7G36vvfYa5IXvwC0V1cTHVlWEykhksNA/lt/eWgco5s/0bI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7457
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTEwLTI2IGF0IDA4OjM3IC0wNTAwLCBUb20gTGVuZGFja3kgd3JvdGU6Cj4g
SXQgbWlnaHQgYmUgZXZlbiBlYXNpZXIgdG8gcmVhZCB0byBqdXN0IGhhdmU6Cj4gCj4gwqDCoMKg
wqDCoMKgwqDCoGlmIChyZXQpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gcmV0Owo+IAo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIXg4Nl9wbGF0Zm9ybS4uLikKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gdm1tX2ZhaWwKPiAKPiDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuIDA7Cj4gCj4gc2luY2UganVtcGluZyB0byB0aGUgb3V0OiBsYWJlbCBqdXN0
IGRvZXMgYSByZXR1cm4gYW55d2F5LgoKRXJyLCByaWdodC4gSSdsbCBjaGFuZ2UgaXQuCg==
