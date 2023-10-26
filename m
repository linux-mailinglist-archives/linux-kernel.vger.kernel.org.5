Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1607D7A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjJZCE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZCEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:04:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12469128
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 19:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698285862; x=1729821862;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Djdf/GDyvQoxs3AkZbBu60qzOALBHsfOZ+Crg8BK67w=;
  b=KgeQeDfxj6dg1eiJUsfJ9z9kJqDxRj6IeJ/mZ3isr+TGPcRP0bLDiFV/
   dcQAbw/3K3RiH1C4j7N0reqnrrmoBxPTrhYX1+qc01NDHmcx72kLLawAu
   lDW5iwFl8n7/xQCNNXtFbNc8B9oDa04iYDg5Flw088bWwaFe2mVx4MQZC
   7yDQ4qUeU7SHQvC9AfvAjdK5+YHG35vo5KYVX4+Z6KFTO3B/Vs8IicQ5T
   JrCg4l0Tc7oHcAN4S2tRzNyFzDYLyMZaBBhrziiPjEjbg3N6hw4Wefarr
   2b8kzMuVJPkF51beaiyl4cGeU790oNpwy2GHTa2iZ5+8skwBrxX9wPJF+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="418567144"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="418567144"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 19:04:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="1006213080"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="1006213080"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 19:04:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 19:04:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 19:04:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 19:04:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mN/yEw8TKeH9slzn7h8+gUE1gBOmlICyi8OaOLqJ6zkvRvCEaImFAXtw8nRlttyAfM2LzLTXb0PJtV9T+NduZ4ybdunTzgjv9VE7Ssnmb8qfpSPE7J23Fw67q9dxBtTxpPCQNm2RbihGAodhXGajIXMojWd4BvHRcajBWb7gC6jvfFVBiE4+KysAg86i/ioSEYdeeY/3rOnK3IQMWAOnuTtQ1HAVeSrnn/v4PeCbPtrpX8RhNJ5bxTuwQr70K8YwN6tfBepEzj4t8APoHWaAhA0iQLf2kGAeMAxGQzcMbSuXUKzZrP2/lJYxfZoQdW+8DVcRbxoYEQ7nULh1qf17Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Djdf/GDyvQoxs3AkZbBu60qzOALBHsfOZ+Crg8BK67w=;
 b=kEl9+exBda3myKcO7Sfe74r2VQtIeawZ/VTcFn1PxMgOZmrms+EmWAG6YHcv5RxiTjqkWzpZb0YE1gGGMIdqUx7zEL4zgPGXIjvtblBI3MNBw6pIKdIjATcblSJ9srgiEcIUIJ16Nh9rdx38ly6wKRbz/vESs3MrI1LpRKpIKZxoEmA/JdgZdX2NWJ19oSd/FE3xDHCDhQSoeYgjvhC/kL5enV3Geyb9prVrZE/G0RrfzWIFHolwvgGegx2qkcW4immwnSAjKKLIZYN/zJ9AyK13sRUAzzy+C1qSOJMOQSvIl/Q2JrNmujnpZW0PiaAec1KcY6vB4cfSvOmHnJ9TUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ0PR11MB5119.namprd11.prod.outlook.com (2603:10b6:a03:2d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 02:04:11 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1%4]) with mapi id 15.20.6907.028; Thu, 26 Oct 2023
 02:04:11 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Thread-Index: AQHaBtSoD4BaRGvpYEWdXJl+rjaNYrBaz2cAgACEWgA=
Date:   Thu, 26 Oct 2023 02:04:11 +0000
Message-ID: <2a5e4fdb3f2d9f32262c0ba23f5535cf09559fc1.camel@intel.com>
References: <20231024234829.1443125-1-rick.p.edgecombe@intel.com>
         <e30560cf-cb88-45de-963f-f99f9b06db75@linux.intel.com>
In-Reply-To: <e30560cf-cb88-45de-963f-f99f9b06db75@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ0PR11MB5119:EE_
x-ms-office365-filtering-correlation-id: 05027226-634a-49e4-4e37-08dbd5c7d887
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wIpLIWII249vf7FZy99eW45GAGoOnlbplYAy+Rz5XHBHcexWzlnLE/gpsc6fSNM+oIOgRN9AdSFRrXvZ0LyWTF7pvrF1MlPXPagoHF8/R0/KqZgeawcrjueqvh5MvXWXbo3tcus+9D/w4TU57+vIL+Ko4+/RG1/IO+p04cRlqub75IJ7FKc5R4lbBLVb7vm4x4APJUFmAZNDHIY3Xh/qmrmr1kriTRHDU0LAjqmF8/iFOgD8AEyKc+KZojjdQW45nqlZBNIfcZ+Fr56O3Z8T6W8OiiXae3uDR+WR1XS6KaHiOWmSeVBovGl1/vz6Sdxd20YLCI45QtLvEvWkmglmhJouMgMhzwrs2NoKroiCRoC8lKbXOgHLaK64toO8CjEuMu1bP5yv3gQF3IBXLH2GYD6i/rhOw2NYRhO3/SXqEBJe3c3D+AhQJmOT3wqTCk0Zn2aRyDrs86xWzC7+XJSaZjls25KPcqSaCfo6CyRvCIjbEC73KyaAbpaQTssdS8SbkRiRbEuz+A9k0CI6V4S4stdJkx6yfFtj9itbDJEDpGim0AD8PAvlnj2DE74DQbiUhcMYV/XkVpR2VPwt96UMQ2jKFAc7NzM5zCpK5bMPiLyVfxjthP4nxsCIzVmfPWlQRO9Zpruoix4/SPcbtoF5nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(2906002)(4744005)(5660300002)(4001150100001)(7416002)(41300700001)(8676002)(8936002)(2616005)(38100700002)(76116006)(921008)(38070700009)(91956017)(66946007)(36756003)(66556008)(316002)(66476007)(66446008)(64756008)(6506007)(26005)(86362001)(71200400001)(6512007)(110136005)(82960400001)(122000001)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDExek56ZFZJM00waHNpaHAzNFBITDVGYTA1UzdKUWU5OElsV2lHdWRIYllJ?=
 =?utf-8?B?OHRiYnlGY0lZWkU2eFFQeHdpelhMa05CQThjeU9uZFpndXpwb0ljb2E0d1Bl?=
 =?utf-8?B?Y0Q1Z25ub2ZMZURMdngxemNCOVpOSG1rWGF2VVVVTEpDdzhpSkRFWWxlb0gw?=
 =?utf-8?B?RXludVNOUkxSOUtsSEtsZlpTVGMxUmt4R2luRDlEZHBpRnh1NVJhWmFkVUxM?=
 =?utf-8?B?UTZkbU1MT0ZsVkwyajFiWVB5cDhjTGNhTExjamhHSEpkbDhTT09CZGtSNC9J?=
 =?utf-8?B?KzM1cEc5bWpJeVJudjRta2dCdEEwUnhHcUp5dnFUcnFIUWhvQk93ZmlrTno2?=
 =?utf-8?B?TGJLQVA3WldjbFF3aGVuWkhjNkdOLytQYkpGbTZxU3VzcnNFRGhocCtIT2NE?=
 =?utf-8?B?UVIzREFXcnpWczRVTWVMbDZRWWVMZlNnb1hKTmRPSjJ6NkM4ZmRpV1RHN29i?=
 =?utf-8?B?TDZSNy84cS91UFlUbmJ1cDl3Rjk3U09nZFhQSWFxbmhhMUFYeGdlYXZlUFAw?=
 =?utf-8?B?QWZSVkJFaWZtTXJOYitITVhkV1ZMSjhPdmlweDc0UGVkaGgydHRVbGpRaDFQ?=
 =?utf-8?B?NUk2MzlwY2ViUmQyRGdFVS8zMXFRRzJVS3hOZWFITE1lZDJXNUN3d2haSDI4?=
 =?utf-8?B?S0t1OU9zVWlZMnZPdTVaaTNjamRROFRWU2l4Nkw2NzA2SkZ6TUxXSlMwM2xK?=
 =?utf-8?B?TTJnT1AzN3FXaFF1S1pkOGpPOHRldFdxZEM4dDJvRm5Md0xHVllkTVorcXRq?=
 =?utf-8?B?YVRKUzhSY1ZrNEhGRER0Z251TzgzR092WmNLNE1ZNlg3WlFTTUxCSGkzb1lr?=
 =?utf-8?B?Wk1HeFk0dkNIT3NMNVpCalRrUW5xTENURVhlblQ3dFFOdFpwc2JiKzdLc21W?=
 =?utf-8?B?NzJDeXV3TXZKMWVMcDZITGtXeFpwSzFHVGZJVm15YzgyVjRPZjAwQWRSb1BD?=
 =?utf-8?B?ZjBOOFc5NFYyK3h4MjFHWHZyWk5ZYzkzK2ZsR2xHcU9xeDE1NjJsQTJVU3c0?=
 =?utf-8?B?SUs0N2J2S3RjU1czbkoxNDAzZEprM3VjMG9FOVhNMDc3azF3UzRqRXJoMEVw?=
 =?utf-8?B?Ymhqdnh3a0w3dFBFZFVPSUlPTzhrUmVySkMzNXlJbUdpbVd3SHo3K3NpRkpz?=
 =?utf-8?B?N2ZyVXFKZWgzZXRaWERCa0REYUprdzB1aE05c0lJbHlUL1JJbWErbVo4QUhS?=
 =?utf-8?B?OXJiVkpLcW4vcWhnU1kyaExLTmR6WjByQmIrdUltOVB4eWpkMmF2RFZ5V2pF?=
 =?utf-8?B?ejRtYXJrYVA0TmxYWFd5M1VGV3JXZXRzS0xXTFhqVDZUbjQ1WmlBaXFXc0Fr?=
 =?utf-8?B?cDl2bW9YNytrSVM0SDZqbmJTeVVhQTVkZVJKYTZlV1BYQy9NYm94ZnZScXZI?=
 =?utf-8?B?cWdHMFNBMWc3R2RrdWRucFZQRmEwRG5OeXh5NjhnTnBFOVU3MmNCZVlnTEVl?=
 =?utf-8?B?bU9IQVJ1RGl1RU1sZXp0d05oUFpmSlE2RkR0dm55czF2bUZJeUtJUVZyMXF0?=
 =?utf-8?B?S3ZNVUQ5blVsUjArc2xML0VIYVQzZDV2eHArOUtOa0NOMTNoMUg0VGI3QlU3?=
 =?utf-8?B?WDg2TGRPS2R5ckhndU02TGFDaThSTWczUE8wSU91bjA1OTdSVlQrWnRUamVt?=
 =?utf-8?B?a21KaWhHNGNMM0hOUm43Umd6eVVOMjYydFowNVJUQlI4elRNRkxBNzRQNThr?=
 =?utf-8?B?ZTBjcEM1TExERzNmR21neTRlNVd1RmhTTHlpM2R3dEJjRlFRRlRZc0tuR05o?=
 =?utf-8?B?VHJDMUxSK05OMmo3UDBiUXdDR0pyd3BxVFpsM09GdXVqRFlUM2dCcjZrbmdv?=
 =?utf-8?B?eVJhUUpibjFseVg0cklXbFBiMVNVWlVhSTVLcVJHN1BCT09ITHY4TkZnb1RN?=
 =?utf-8?B?ckhnMVdCbHNNSWxDcEM3elhhR2xHTDVGb0MwRmQ0dEpQaXd1L3JLSWVURktW?=
 =?utf-8?B?ZHhMNHpsOVZJWGJoOFc1UmxqQ2JpN1JkeUR2dnR1ejd5RDdnMzJuMVNrQlZH?=
 =?utf-8?B?T3g3eTdabEFLZURUcWtIM1Q4TzRmUnY3bWRnQkhMajg4Tk53bUp4WmI3d3hq?=
 =?utf-8?B?cVpRQ0hrUXF0ZXhYODZwaXVQRGxlUlBHd2tUK3pyeXI1M3JKTGptOTNlZHBW?=
 =?utf-8?B?OXZYVkFFcVI5SjZxOFp5ZUFEbHBDaVBoK3NFNW03c1Nsd3E5dzI2cjF5NHI5?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D20DCC6B71BB5A45983C5E2A0F4C05FC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05027226-634a-49e4-4e37-08dbd5c7d887
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 02:04:11.0946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OSZSjuMZ2eNbXokgDrBMlWJlpqeZ5UmRS24w8b9lnpZ9+NqCA2eVD4b0XjLydcftay2X4csC6mEk5CgWiU273843WbJGITmrt52EWkBtvGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5119
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTI1IGF0IDExOjEwIC0wNzAwLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5
YW5hbiB3cm90ZToNCj4gTG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IFJldmlld2VkLWJ5OiBLdXBw
dXN3YW15IFNhdGh5YW5hcmF5YW5hbg0KPiA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dhbXlAbGlu
dXguaW50ZWwuY29tPg0KPiANCg0KVGhhbmtzIQ0KDQo+IA0KPiBJTU8sIHlvdSBjYW4gYXZvaWQg
Im91dCIgbGFiZWwgd2l0aCAoIXJldCAmJiAheDg2X3BsYXRmb3JtLi4uLikNCj4gY2hlY2suIEJ1
dCBpdCBpcyB1cHRvDQo+IHlvdS4NCg0KSG1tLCB5ZXMgaXQgY291bGQuIEkgdGhpbmsgaXQncyBh
IGxpdHRsZSBlYXNpZXIgdG8gcmVhZCBhcyBpcywgYnV0IGp1c3QNCm15IG9waW5pb24gYXMgd2Vs
bC4NCg==
