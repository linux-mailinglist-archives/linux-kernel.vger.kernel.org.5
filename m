Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DF97771EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjHJHu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjHJHu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:50:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CBDA8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691653826; x=1723189826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lk0TAwXWPyFsenbFmQImMV3edED68cv7AaRYjDUMMmw=;
  b=bkoFqVLnLIemaDLaAxJOhwBZlvLNDdUR3MiLnO3UUU+XJOtJiZEVI6Ub
   JtHtFJJBnja5Xscw0yW4wy8pcKEr7buzcWFXbBUAImOj6rsDraSd7yCVI
   5sAyKbZ/JauONJF6wEX4VnjBqRmcSf8C7f8L3iJAPa7ADzMS7I1vorEnc
   6bZ1nK2cDs43z2f0fbdEzMqQxEahkHR+7ZKOmR+QzLrdZFUprJJU4MOs1
   c3WiwtPQZ3hGmi5ZAaUD498C7v4o0r48iN8XylGKtNhVOkfz1pvukCU1w
   FFL0jjHRB8+f4N0LC91oGz+3y8tzc++Osa85CogsuRIe2fXvTpjuN3+T0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="375043714"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="375043714"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 00:49:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="822140481"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="822140481"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Aug 2023 00:49:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 00:49:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 00:49:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 00:49:14 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 00:49:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWJOfthcfwV0S4jRlqg3IS4WURAhxxbm7lBY4ZR2Iet/afqj9oWgd3LhVGjiZtE7f3D3T/RJkywLrjISkiDXYuar0ExTFV17hP6GT6CqW+JppWW/uqkAdcOjSQ18Qjs4iQo6yILMrQ/9YzCQlYkLu9h8iF2pnY5Y2aQQGMtpg0wvvX1Y/Pg0jz1IUieDkT+uWh6+sqqjq2JRTPy6/uw83vBM3NGOTaDng0nRhaMxw6gceIF6fwbCgWewemvQ4t4RToL36z9f8eDBXIowQC2+bNhICURe9VMQ+iv4nWF2PyKixxd2NBCtTiBhh90yO6btXn1vVfdk2WLBZxWsL8oY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lk0TAwXWPyFsenbFmQImMV3edED68cv7AaRYjDUMMmw=;
 b=iuqbQpVycnmX1Og73ywGw4n5Dk6p+cuaL5FH5psSz5Y33Mz6ZjLzVVu9vTL+RjjkOS24En1J302858QBewUqBpxJI7GwcpAA7DpStVl0M2k5OfKhGUmFs+jHDNtt/8qCikEK2n/IjUy4pJ0IEGY345Pg8Thqm85Ne+PgMpkavGnRKJKMG9mYqDonf5FUc5D2/YjjrmPZn5uVxtJHyRiVnpeq+gfPi+PKk9Cx5qP3I8cNsoSEsMOQNQJyrykRGsxKl5iAhHKvD9ovFS7jor1WpKDJ8uzSPjuCdwUISE06eprE0yIpBgOjhZK5b6BVdgvThXT+A4Q0oMMw+FwqJ6/LXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7247.namprd11.prod.outlook.com (2603:10b6:208:42d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 07:49:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 07:49:11 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Zhang, Tina" <tina.zhang@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/5] Share sva domains with all devices bound to a mm
Thread-Topic: [PATCH 0/5] Share sva domains with all devices bound to a mm
Thread-Index: AQHZyczwIC26PTEzeEyQLUQIHK3R/q/htz1ggAEJ/ICAAGiLoA==
Date:   Thu, 10 Aug 2023 07:49:11 +0000
Message-ID: <BN9PR11MB52760CE856F69A3FFD7EE2C88C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <BN9PR11MB527638E7361714F8AA5FD4448C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <bfc2eb22-54af-dab8-72e3-a142470590c3@intel.com>
In-Reply-To: <bfc2eb22-54af-dab8-72e3-a142470590c3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7247:EE_
x-ms-office365-filtering-correlation-id: f9a2698d-35b3-423b-98a6-08db9976495e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nn6ElF1xEiaX+i/XVrB1NPB35GELPXSBadL62UFvd5KraqMrMY6yR6ybgBvxsDvyI93ZnSC7H31Jfj7P4oSltWydeOwgTQKOyScq3FnKaJ0Ig0XZphXcv6S5UeHeHL3xBBshdPYZjWtdvsZLGj0J2DD+1SmxvjSiC4zJFod7ULQ/2W6jE0rZsR2vveVUMw0KyMW+06GFvCIrHhQvssN7lUJIgTkRFvuBeHaTLmxxAP0+mHFm2IRrhmIBRaIfHN0XJTN4Zwp93I/zzCVELtxUS6PmOCzTQdv0A3o3BEQTzq9tKVeeofCS/tjGD4faJi6a2YJ9AT2iSPSNJVJLKBXN8YuV4cywjOTVDoj7UCFiVj0gG3W3Sv3K7li1jQjianW7YUjKo5Lh6jEg4gV/0xQ93MruqXhxd/pAEcR6haolK65VtyLd35T9vr46ZBRkTnWKCqm/kAJB+TdDbV6pUwgewEbQltbRDKbGvDOBgH8j7nnEnHF1uG1MH8SQ4eD77r9FVA1bUFJ8Vg1WBrHsITaQ5cm67nhi9uqyBzyRmLvIkNJduCVEYxee6sjtl3hqfhVAZXuie3hxFLg04CJh0FKL7Xt1umpUGMifMfz5TAufSRFq3R2X/j+aM1SnWEBueOPI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(346002)(366004)(186006)(1800799006)(451199021)(38070700005)(7696005)(478600001)(110136005)(71200400001)(54906003)(86362001)(6506007)(53546011)(38100700002)(122000001)(82960400001)(4326008)(66476007)(66556008)(66946007)(64756008)(66446008)(316002)(76116006)(33656002)(9686003)(26005)(41300700001)(5660300002)(2906002)(8936002)(8676002)(55016003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzRmT2xzMDN4RXhYazNmNkZ3eTZEY2grY0gyVnRieGQ5MWNjZHJvMFJoMTBE?=
 =?utf-8?B?UnVkV1g4eHlKVGNORnhXYzJjY1A1NUlDSUJBR2cwMCtCNXdLcmpoUUNZNlhj?=
 =?utf-8?B?SFJicktsUG5DcUNGSTI5QjBsM0x1UHVwcjdGSjdRQ1Y1cmdldHV0R2M5c0tp?=
 =?utf-8?B?Y21FTnZzT1JlSmtORFpTVlRYWEdiNldmUU05V1Vyb0VkWVlvcGpqTzkxMEls?=
 =?utf-8?B?UEdPei9BNURwZUF5VW9qaUw1V0U1d2R6SGIyQUdiazU1cGNSTWpwODNST1F1?=
 =?utf-8?B?bmdyZTg4Sm1JUFpZeldGWCtWZFlMTHdWMkQybXdZSUtpMkdNS1lnaldObTJm?=
 =?utf-8?B?SFA3ZDNMUzFXQW1VZmNjRXY4dlJxaXJEK3B0ajJTdFg5YmdBY281L2hkUWxj?=
 =?utf-8?B?bXVjRlpvS2xuQmtyQ1ZZK0lxRG04N3FnTnNoNUZBR016bUdvNEVFSnJhWGlL?=
 =?utf-8?B?UkNZdXBxalBmWDA3WTdxUXdLbDVuYjZHYVFoWS9rWFVzS0F5Y3ViQlZ6cXU3?=
 =?utf-8?B?algwUkZuTTRIMUNNK3VwRjB6RXFRSDNFWnp0bzVGZGxLOFNZWm9rZXdQRFQ5?=
 =?utf-8?B?Zk43N2NKN3VwTFhpVXJhSGd0c0gxdzFnVnhlM2VtaFpicTViRDBKcUZXOTN1?=
 =?utf-8?B?MHZ0NndTMnlNUmtTL2d6QXBWclYzdVU3MmdSMnBFejdxcjE1QU5GWHd3VE9S?=
 =?utf-8?B?UXRFNHFEb0E1ZkR2L2FSdmMvM0lxamQ0cmFaYkJTVVp6OXMyalFpM0NVUDBu?=
 =?utf-8?B?UWtnU3NKdU42TTNZVVIzWERBM1l3dnBrSlFqdEdmRmJ1c1F5akJ0RkVLb1E0?=
 =?utf-8?B?Rlg4dmpoNWNlNjRsYy9SbXYxbG8yS1JzOUhwQlV3TlRtMUZodDRnMURqZzc1?=
 =?utf-8?B?U2sybXNZbXJwZ1dvbkx2eWdtODVKYVhrUi9nUG8yNXdSakNMbEdablBOV3dF?=
 =?utf-8?B?WGsrbndEREwzakk5M2ZrMm5sbGFwSmc2NWZQMGZJcjgrTUdVRWw1RDAyZ2Nu?=
 =?utf-8?B?RlFKZXMwWFZNcTgzaGV2aWRGeVJIekY0YnBWc3B2Tk9mMm95Qmx2TDg1MytM?=
 =?utf-8?B?eEpOZXlvcHNEamJpYUZKYklOUWhVdWhlbkRBNWpkL3VHR29mMmNnRWlDZGxi?=
 =?utf-8?B?cHRaMVQyeDdEQWFycVRaRU5SVUR5ZlNHSXRGaTNlNDlMWGFiWThrV1M4QVRE?=
 =?utf-8?B?V3RGVGxyT25jSERVbXdJTGZKUzl0dEVpTGVXZXZPaDQ1ZWNPNEhOZTlNVjdW?=
 =?utf-8?B?S2pVMjhUdFZtYmdoMldrcm9wMlA2U202eUVheFVSKzVBOGFjRWtSeUJ1UFFs?=
 =?utf-8?B?WWo4OHBSYWxSWU9HRWNmOHduV1JsajdXTENxelc0aDRxYkhnbWFpUmhFbHB3?=
 =?utf-8?B?a0xFSzEydDliK3QwcWd4RzJvczVXSGtobUcwTm1EWFFNY3RMYjE1TjJ5eXph?=
 =?utf-8?B?N3RSTzhLTExsdTFuZVdzVGc5aW9BUS9NZ29Wemtvd2tGZXZmVlJtTXZvcVFl?=
 =?utf-8?B?cUNZc0Z5UVdzYVdXb1RSYVZwbDE2cUppVFNkQ1BCV01lYmlwZkpQRk95Z2FF?=
 =?utf-8?B?eUFYUGZzalI0bTltZXVsbE5lZk5WL1VLaUh4N3lTbE0yazJXVldBVmZ1Zjhy?=
 =?utf-8?B?ejVvd1Bic3dOcytoVEprbDdRUVJYbkFobmxWTVpvQTNyNWdFYVFkQisxSXpM?=
 =?utf-8?B?VkM0MEZDMFowaUlydzhQcEFObjY0dXZpc3NnUlk0Q2FjcldMUWtXclovK3Jw?=
 =?utf-8?B?bHRkUlBuNEpWczJEMkRUNTVBUDZVbm04a05qempEd1pEMGdkTExjU0NqUHdz?=
 =?utf-8?B?NkJ0MFVNdFNEWWNubklmbDlyYkZvZkNtSWs3TTBrQ3RBWnpGOHEzemFKUjI5?=
 =?utf-8?B?S29sZWRDL3Y5KzlGOVhyU2xqYjVFVExUQ3VXS3ZwNTNucWRxeFVUbG5vR1dN?=
 =?utf-8?B?MkZqaS9jRlFGN1FYdWhkaFZzS2hrVHU5R1ZuaHArZ3lQbXgxWXFDSGVqTFpj?=
 =?utf-8?B?bHRuU1E2eFVyTFFkbllTbGN4aUkxd3VXOVpWaS9iQWRzTnE5OGpvTk5xQnlZ?=
 =?utf-8?B?NERXZVp5RkZka01OV2o0L3kveEthSFNUcHc5Vnp5cTUzYlBYa1FqendrN2hR?=
 =?utf-8?Q?bpHSxupxAA+640mTI8+81wYVm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a2698d-35b3-423b-98a6-08db9976495e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 07:49:11.8770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AM9w6rQ153Dcx3iEET+RnDvRyvpII07xlZFrCFaYeZaqWpO4IFOd+/hCzhV+i6647rpVNYfZvIv2NHFbcaePpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7247
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBaaGFuZywgVGluYSA8dGluYS56aGFuZ0BpbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBBdWd1c3QgMTAsIDIwMjMgOTozMiBBTQ0KPiANCj4gSGksDQo+IA0KPiBPbiA4LzkvMjMg
MTc6NDEsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBaaGFuZywgVGluYSA8dGluYS56
aGFuZ0BpbnRlbC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA4LCAyMDIzIDM6NTAg
UE0NCj4gPj4NCj4gPj4gQSBzdmEgZG9tYWluJ3MgbGlmZXRpbWUgYmVnaW5zIHdpdGggYmluZGlu
ZyBhIGRldmljZSB0byBhIG1tIGFuZCBlbmRzDQo+ID4+IGJ5IHJlbGVhc2luZyBhbGwgdGhlIGJv
dW5kIGRldmljZXMgZnJvbSB0aGF0IHN2YSBkb21haW4uIFRlY2huaWNhbGx5LA0KPiA+PiB0aGVy
ZSBjb3VsZCBiZSBtb3JlIHRoYW4gb25lIHN2YSBkb21haW4gaWRlbnRpZmllZCBieSB0aGUgbW0g
UEFTSUQgZm9yDQo+ID4+IHRoZSB1c2Ugb2YgYm91bmQgZGV2aWNlcyBpc3N1aW5nIERNQSB0cmFu
c2FjdGlvbnMuDQo+ID4NCj4gPiBDb3VsZCB5b3UgZWxhYm9yYXRlIGl0IHdpdGggc29tZSBjb25j
cmV0ZSBleGFtcGxlcyB3aGljaCBtb3RpdmF0ZQ0KPiA+IHRoaXMgY2hhbmdlPw0KPiBUaGUgbW90
aXZhdGlvbiBpcyB0byByZW1vdmUgdGhlIHN1cGVyZmx1b3VzIElPVExCIGludmFsaWRhdGlvbiBp
bg0KPiBjdXJyZW50IFZULWQgZHJpdmVyLg0KPiANCj4gQ3VycmVudGx5LCBpbiBWVC1kIGRyaXZl
ciwgZHVlIHRvIGxhY2tpbmcgc2hhcmVkIHN2YSBkb21haW4gaW5mbywgaW4NCj4gaW50ZWxfZmx1
c2hfc3ZtX3JhbmdlKCksIGJvdGggaW90bGIgYW5kIGRldi10bGIgaW52YWxpZGF0aW9uIG9wZXJh
dGlvbnMNCj4gYXJlIHBlcmZvcm1lZCBwZXItZGV2aWNlLiBIb3dldmVyLCBkaWZmZXJlbmNlIGRl
dmljZXMgY291bGQgYmUgYmVoaW5kDQo+IG9uZSBJT01NVSAoZS5nLiwgZm91ciBkZXZpY2VzIGFy
ZSBiZWhpbmQgb25lIElPTU1VKSBhbmQgaW52b2tpbmcgaW90bGINCj4gcGVyLWRldmljZSBnaXZl
cyB1cyBtb3JlIGlvdGxiIGludmFsaWRhdGlvbiB0aGFuIG5lY2Vzc2FyeSAoNCBpb3RsYg0KPiBp
bnZhbGlkYXRpb24gaW5zdGVhZCBvZiAxKS4gVGhpcyBpc3N1ZSBtYXkgZ2l2ZSBtb3JlIHBlcmZv
cm1hbmNlIGltcGFjdA0KPiB3aGVuIGluIGEgdmlydHVhbCBtYWNoaW5lIGd1ZXN0LCBhcyBjdXJy
ZW50bHkgd2UgaGF2ZSBvbmUgdmlydHVhbCBWVC1kDQo+IGZvciBpbiBmcm9udCBvZiB0aG9zZSB2
aXJ0dWFsIGRldmljZXMuDQo+IA0KPiANCj4gVGhpcyBwYXRjaCBmaXhlcyB0aGlzIGlzc3VlIGJ5
IGF0dGFjaGluZyBzaGFyZWQgc3ZhIGRvbWFpbiBpbmZvcm1hdGlvbg0KPiB0byBtbSwgc28gdGhh
dCBpdCBjYW4gYmUgdXRpbGl6ZWQgaW4gdGhlIG1tX25vdGlmaWVyX29wcyBjYWxsYmFja3MuDQo+
IA0KDQp0aGF0IGlzIG9uZSBvZiB0aGUgbW90aXZhdGlvbnMuIGUuZy4gYW5vdGhlciBvbmUgYXMg
SmFzb24gc3VnZ2VzdGVkDQppcyB0byBjbGVhbnVwIHRvIGRlY291cGxlIHRoZSBjb21tb24gc3Zh
IGxvZ2ljIGZyb20gZW5xY21kLiBCb3RoDQpzaG91bGQgYmUgbWVudGlvbmVkIGluIG5leHQgdmVy
c2lvbiBjb3ZlciBsZXR0ZXIuDQo=
