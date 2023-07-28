Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14F976620A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjG1Cpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjG1Cps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:45:48 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F9A35BC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 19:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690512318; x=1722048318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XUM363fXBMDOvXz30rMR36X61mhEjvP2xLR25V3lM38=;
  b=gy53tKkQwvGA181BdVrHACnR+bXXoROD4e2qdfxKmEVGCtMl0JcGoUjE
   O5TS3jlUpcqoexyFviEPZZNa3LGsyuMXkbCfLCFFRdmyd5eBXgf9MeTgy
   Wsj0Q/+mRSCf3WnSx7L37BPaE5tzXcA0ESkRtE19higOX436jDxRwo1vn
   4vITWOw49ejV3RoeikXXRdzp28mMsk4nr+6QaTgDNnpKxv88wTRU/H8Dv
   GkBvJnzuxeOUKxBH//ozyVxRUS/IrslUx73RcYGopGzEjrxmkbWzppRAO
   jxkh6JWTXB06hb4Lv3P7VE8fO/prsyOYutISnCq+fY1qaM3soB5Z21iOb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="434776302"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="434776302"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 19:45:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="730581971"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="730581971"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jul 2023 19:45:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 19:45:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 19:45:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 19:45:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cq4AuPW2KdaK+ZnW0wtbMZwoHtuGSuX8uz3BDUAIyyC5bZMHBpb6wI+L5OY9evMJSnit4G5P6otU3Wv0yhm0iSYXuNHTpv4jzRpTAwh1d/uUmgLiyuP+kr+9NBE++NhVKu2wxcEMyvC/HmNSw4dFRBMa7tK88F+wNrKZwrPhFRamiB3xULK+3e6QNiqMKNqf1plHu2/JB7RbAKLuhJ/hUoi4MH0tkP2ety1aJLNOW5b38JvbY6F2Zr8H+GLt/j8CXtFBDv17NOFw7wFVwKbxJfJjax45RrO2yynxquh8dHaXRbGfX8dYDmBdFmjfpRzPqz3dO1Ywv90M0lwcY3LSag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUM363fXBMDOvXz30rMR36X61mhEjvP2xLR25V3lM38=;
 b=lre+Swpj6/mzhwrf5Z5glhRQhEtVqGEzkzYcE594/pZpipMSuwNZfY2UJnw14o3zoQTimhKQRB+qZB9OOh263nhJkRcgiMAN/og0E5XQbGl8RaMylJlaY0soP1t679dAADFSicjytoxrHSQxMCro25mLvjrlZErls9jPGVVb5EX0Q755omLGPcg5l6v/3z+tdkaZX3Fv18+rP4cSPb6DHurZvujbx/q7FjQN4JicLTRnC1ZBygb5pznZZeQqwhCAm+3DSRCQdZVKzgc7q2WTZqhpWQXi/PUFcMLIcxByWJPteA8igELCDCbo8zXKeBjjFxBc2jZdJ75xBZxmXdM5Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB7877.namprd11.prod.outlook.com (2603:10b6:8:f4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Fri, 28 Jul 2023 02:45:12 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 02:45:11 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v3 03/12] x86/tdx: Make macros of TDCALLs consistent with
 the spec
Thread-Topic: [PATCH v3 03/12] x86/tdx: Make macros of TDCALLs consistent with
 the spec
Thread-Index: AQHZv7Ev+nrPxLMJjkaVnFW5pMvVza/ObaWAgAAOBIA=
Date:   Fri, 28 Jul 2023 02:45:11 +0000
Message-ID: <2c5eb48ac9d2ae84dc0010bb0934486d09274724.camel@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
         <b3f5a25e72094a11add22e1a7c5dda3ea91d0e98.1690369495.git.kai.huang@intel.com>
         <b9fbbbb7-f855-5744-d6ad-c650b10ce135@linux.intel.com>
In-Reply-To: <b9fbbbb7-f855-5744-d6ad-c650b10ce135@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB7877:EE_
x-ms-office365-filtering-correlation-id: 4ff23b31-58bc-42a1-556d-08db8f14aa03
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S1plIJmv5y9xFtuw37p7zOdJXczxp45vhxzswy+rzT3dfB/a1MabKdbY3iIovnIeewmI0iOCB0Fkq4AlnMbt107N6cuOcPpqtvCOywZnpd++ZFCAz0p9nWQS3NTOdbdrMbP7UvivYS9GmLzgYOF3JHG30u6I55PkINnaWZOz5eUCZjpj8G0daJ+5NEdgt8GQqefr1DnXXbMOQszEv2PZODCEfH+MAh/l7ZUbyTt+9nwo8AdDIxjfAPyuXzDLgg7VCZchKoqtonbroFNeJgJUlIh43iicS4nj3jYTdNpWLgQxbjg9ZMx3M4dWXpNIBAmDSIynYFxs0o7rogK1wMCuMFj9CDdczIXQe4F8qOq80Po+ne882ZuoU/RUChPt3mNsKL+VCAKTxwPURN5E8WyEIEmEaRX/j8k7yt0jrChgaRT5XG+k6x9BrHeWp5EsHevvEkY06WlGtjsI8M1BETUn2DiyKNGsDR+vxwJ4cRYPMVkWvnbb/XM1KsvIPbsZN4U7ckOmIwYQtS3ZisrnfpjkXYbjSCqbV+FhMbu1PwFVsr1U6dotX2D3xWy6ggdhrShd/+ol82HoU9rEwUf1dv/sFmZlXRnj3PjjQciRX7CkyDElsCyCn4FpbzpI7rExCpj/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(2906002)(316002)(8936002)(8676002)(7416002)(5660300002)(38070700005)(41300700001)(36756003)(86362001)(6512007)(6486002)(71200400001)(122000001)(110136005)(54906003)(82960400001)(26005)(478600001)(6506007)(53546011)(186003)(2616005)(66946007)(91956017)(76116006)(38100700002)(66556008)(66476007)(64756008)(66446008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVhKUnNMYkNjb1dnR0dzVmFaaUE1VVQyWXNweVVqT0xManN1V0tiWk5Qc1F3?=
 =?utf-8?B?ZkNkd2JWYUk0Vmt6MUE3U2E4YUx4S1U1WjNiZ1dkWm9JcThac1VBUmJVK2t0?=
 =?utf-8?B?SmFXbi9kcG15SFZ4Y1VjK2NNTmxWbGRwaCt5RytOVkxJYXVwWFlTd1B6djhZ?=
 =?utf-8?B?SFVIWjNqKzNJaGZGNzNnZXFtcXgzUmFOVFVRMG16cU8wWjR6ZFF1MUJxOW4v?=
 =?utf-8?B?WldvMmpBcFNFRWlZZE4yMmdvaXVmT1IyelB0M1VsSEFpMThNY0pncEh0SkN1?=
 =?utf-8?B?RTNIWTJyNkZPMjB4dWNYODl3eks3UU9TdlFCZnhsTDUxQlR5eGU5YVlEa2Nx?=
 =?utf-8?B?c010ZWZ3K2c4VTdYeWNlQisyMGVTbTFNV2VFY2ZlTE4yUStsMDV4MjFzb3Jv?=
 =?utf-8?B?TVNUS04rSGtVNkQwaE9uUHdTNFlwd2RCd3hCbTBudWxWRm9EL1gra1B0ODZx?=
 =?utf-8?B?SktRc3Q0ODRUbjlJWEczUG1tYXV1NHR3Z0NBQzI5T0x1OXU5eUN6K3B6SENY?=
 =?utf-8?B?N3hQem1FMEZjd1kyQnlxR3c5amU4M1Bzb1NuSy9xYVUxcE40MWdGK1VuL1lX?=
 =?utf-8?B?T0hhV1Iva0FiME1OaXUvQm9qY29rNTJKM3VzSjlMNkdHenpYWjdLeHY0ekhw?=
 =?utf-8?B?WWJGYnh6SGR4T3l5ZUZoa3BzcnNaS2pRL3gwczhTUFEvN0dVeVBKL2toTnBm?=
 =?utf-8?B?UkhFRm5pRmJ1aDBRdmtza2JIUk9sVEV2WCtEc1BlMUdZY0FyUElvUnBtR3hq?=
 =?utf-8?B?MVJaV0hLY0d0UVhWSUFFK1dVaHMrTjBvSDluR0ZqY3BjaEU2Y0hxM3Jkczdu?=
 =?utf-8?B?NDZPQ2pzUStGMFdpUGJNWnRXQisvb2dyTElwRm9yZUkvTGYxbkU5Z0VZRXRG?=
 =?utf-8?B?QmxWdVM3elU0bWdsUEoxdHQ2dk84UXNyNVY5Y3NXSXpwWUEzSXhyVSt1TVNx?=
 =?utf-8?B?dFF1Z0ttaXE2TmdRd3AzT3NWbVZRSG02ZGR5eTY5TjJsZnhtMnhlYUVmb3VF?=
 =?utf-8?B?d0JsKzUvVlVVM0l0U2JNajRGV3YzU29IMGZQOGh3dmdpNHdjdVdUZmswVkdw?=
 =?utf-8?B?VEsrQUFsOEg0YzRGWmNPVGI4R2JYZEhPcW03T0svWHBjT3M5eHNHdmJsamRv?=
 =?utf-8?B?QWdIQkVscEpwVmo4N0FYMUZiWFg0QW05TzdGbkh4Q25zMW81bkF1Y3VndWZC?=
 =?utf-8?B?bHlSVUlVVW1KNzBCMS9zOE5aU1pJK0NiVXByMnJtMVBiL1lJQithMGZYWURo?=
 =?utf-8?B?WjFXZHE3eHJWUk1STzk5TC9DUThmTUdhcjNyYzZaVEozd2RTRzhxRis0L2NV?=
 =?utf-8?B?MzdONk9mVEo1OXBQSXpXZ3JGSTNwSHAyQ0xQbEpINWxmMTlHUTlRWlB2c0NE?=
 =?utf-8?B?TXE1MFZUZ2lRVUVYaURjcFlrNTYzK0JDWE9SRjVkR01TKzNYSnVwUXR0eTNC?=
 =?utf-8?B?UnB5dkEvZVFUbGxsa1RhcS9XRkFCM2ZqSUNGRldKODdXQWtEUWdmc2tncWc3?=
 =?utf-8?B?UGo2bWZpVjA4andxK2JETE1Qc3JFVjFOb1A0Q292WEE4RXp1RlV6M0hZeFlK?=
 =?utf-8?B?NFg5b0o0anR2bVpiNEVtVlJjYnllVnlpeUVqb0ErNkMrekNsdEtlNXVKZE9y?=
 =?utf-8?B?V1lub1Vzd2RydnNWSjZNM056V1A0Y0Z6Vy9sVEQ5amhDazBXM1R6eXdDMVpL?=
 =?utf-8?B?QmIwRlEwTlptUVRyM28wdzJUV2dhQXF2dFhGNXh4czJkOGVqTXR3a3hHenhB?=
 =?utf-8?B?MnA0TytxRFM4eHdEZ2pLTk9zU2xaY3hmZWpBWHFmdnZCV3lUMllZWTBPemFG?=
 =?utf-8?B?dlBIVXNJZmgxYlgxRWR2bHEzTFRFbXJ3dE1wZ1lXcWVjVnA4b2RCTXhYOU5R?=
 =?utf-8?B?alNwOVZjeUJ0MWlaQlBxYjgxZWFSOHpPWW1ib2UwbHNuNktualhhY0VqZWtn?=
 =?utf-8?B?RVM0bUpXTko1SWtwMEtIT1htLzlQTU16VDExREJubWtXWUVWaDc4L0FBQ0Zt?=
 =?utf-8?B?S1VzWDRaV01UUVRFdEpjV09jejBXU2lCazV1Ris2b2FQNExrMDZ0czc3cHBC?=
 =?utf-8?B?T2ZCV1MrVEZnTWdoWlNDVW92cHJJdWNrazZOdDJZcFFXV09XajJtK1NGNVNt?=
 =?utf-8?Q?x9d+5a7DSEppG2r1eRH6gweQn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <621AA939714E55488B977C771AE18E83@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff23b31-58bc-42a1-556d-08db8f14aa03
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 02:45:11.7064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ii9ZLmCvs1VERb/IZ8BR9jKUIVKulX5g+z9PvbgDWxJSCXEZQdW/+MBxrk8MpNsMaZhVNU5LARy9lXSJuTKDCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7877
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA3LTI3IGF0IDE4OjU0IC0wNzAwLCBTYXRoeWFuYXJheWFuYW4gS3VwcHVz
d2FteSB3cm90ZToNCj4gDQo+IE9uIDcvMjYvMjMgNDoyNSBBTSwgS2FpIEh1YW5nIHdyb3RlOg0K
PiA+IFRoZSBURFggc3BlYyBuYW1lcyBhbGwgVERDQUxMcyB3aXRoIHByZWZpeCAiVERHIi4gIEN1
cnJlbnRseSwgdGhlIGtlcm5lbA0KPiA+IGRvZXNuJ3QgZm9sbG93IHN1Y2ggY29udmVudGlvbiBm
b3IgdGhlIG1hY3JvcyBvZiB0aG9zZSBURENBTExzIGJ1dCB1c2VzDQo+ID4gcHJlZml4ICJURFhf
IiBmb3IgYWxsIG9mIHRoZW0uICBBbHRob3VnaCBpdCdzIGFyZ3VhYmxlIHdoZXRoZXIgdGhlIFRE
WA0KPiA+IHNwZWMgbmFtZXMgdGhvc2UgVERDQUxMcyBwcm9wZXJseSwgaXQncyBiZXR0ZXIgZm9y
IHRoZSBrZXJuZWwgdG8gZm9sbG93DQo+ID4gdGhlIHNwZWMgd2hlbiBuYW1pbmcgdGhvc2UgbWFj
cm9zLg0KPiA+IA0KPiA+IENoYW5nZSBhbGwgbWFjcm9zIG9mIFREQ0FMTHMgdG8gbWFrZSB0aGVt
IGNvbnNpc3RlbnQgd2l0aCB0aGUgc3BlYy4gIEFzDQo+ID4gYSBib251cywgdGhleSBnZXQgZGlz
dGluZ3Vpc2hlZCBlYXNpbHkgZnJvbSB0aGUgaG9zdC1zaWRlIFNFQU1DQUxMcywNCj4gPiB3aGlj
aCBhbGwgaGF2ZSBwcmVmaXggIlRESCIuDQo+ID4gDQo+ID4gTm8gZnVuY3Rpb25hbCBjaGFuZ2Ug
aW50ZW5kZWQuDQo+ID4gDQo+IA0KPiBXaGVuIHVwc3RyZWFtaW5nIHRoZSBURFggZ3Vlc3QgcGF0
Y2hlcywgdGhlcmUgd2FzIGEgZGlzY3Vzc2lvbiBhYm91dCB1c2luZw0KPiBUREcgdnMgVERYLiBG
aW5hbCBhZ3JlZW1lbnQgaXMgdG8gdXNlIFREWF8gcHJlZml4LiBJIHRoaW5rIGl0IG1ha2VzIHNl
bnNlDQo+IHRvIGFsaWduIHdpdGggdGhlIHNwZWMsIGJ1dCBpdCBpcyB1cCB0byB0aGUgbWFpbnRh
aW5lci4NCj4gDQo+IFdoYXQgYWJvdXQgdGhlIGZ1bmN0aW9uIG5hbWUgcHJlZml4PyBBcmUgeW91
IHBsYW5uaW5nIHRvIGNoYW5nZSB0aGVtIHRvIHRkZ18qPw0KDQpJIGNoYW5nZWQgdG8gX190ZGNh
bGwoKSBpbiB0aGUgbmV4dCBwYXRjaC4NCiANCj4gDQo+IFJldmlld2VkLWJ5OiBLdXBwdXN3YW15
IFNhdGh5YW5hcmF5YW5hbiA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dhbXlAbGludXguaW50ZWwu
Y29tPg0KDQpUaGFua3MuDQoNCg==
