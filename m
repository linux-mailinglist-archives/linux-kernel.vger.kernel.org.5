Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874C37EEB55
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 04:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbjKQDPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 22:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQDPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 22:15:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681FC1AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 19:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700190930; x=1731726930;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3zZnWYJkzDizgVxB9VR/T3XXUyxCiiNmtOOcxnDANYA=;
  b=OSbM2nGMEsjoovh6rTbCLXYw6AChPMw16agizzgHsfUKwm9QF2s7uHq1
   WH8KoAtBtaA4V7FlHe4wX4v4YiR1xPhvxGgSyeV5HmdNPoCjVEwtTur9w
   1rBkhhuzjqEjtq3btYUCe6TIVqeFfzHrJVAaBSXqGShIcmH7qDjnLZGrl
   peGhqJ4K2wLVVlFFnk6EXop5WThXMOQRH1yJeA/H7Yh/JUpueERJAMFM0
   xR4sa8ddXi+475aseReeYtdbRl0mRXXenxiFeKHSza2p6wcLG9LKKS0B6
   efKfGAlIZZIYguibcrDQcHQckNLdoWxA8QQSiYviuGLn/aUc3hF4M0RXG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="455524601"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="455524601"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 19:15:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="882976253"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="882976253"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 19:15:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 19:15:29 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 19:15:29 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 19:15:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0gZr9pR3dhqtVrQR5UDwds2gB9jgVujRr/EVk4jl6z2dZ2epHCs/1yUc1aWmWL2YWEBuCak2nxFrX6UceeeXiRHbMaFFuY1dU6+h8+TIcY620QvqvKckb/WozknwQ4g6ZVuYkvkq7cMdtGsd1vxrRRKHNyYB1/d3fOGwNqgPaUrwVB0INr8gQkLln8RFJqitMJgf6QosFub2vj+CsHSsct2FTMeNIjGorIw+6wAPeIdOMTRjrI2fUNzw1eLPGhDi9/1jD9GGU6/u37Jnd4k3tD/ssW3A4FhjW5RmX8UyK2hOQBANa+Bnig5l/Ow++TtoIvTj8mYRnGCeiwJRj35tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zZnWYJkzDizgVxB9VR/T3XXUyxCiiNmtOOcxnDANYA=;
 b=Va2qMZeJ8qId3LpnmQ0nWTCXZMT0BOABBpFLhTi8dGhoTY3vDCkHv/rMkBU1vvsaEeJ22b8E1xYOkzbjj+jI+mpjmJDvnt/BnhLdoHn9fhnxAcJ1V3vS0bZp0CpkfVnvd3o9GdZ+k9A8AAXpBx7zgma1vMAyyQI5Srps1pjwOUeaFFBWq7qGMt5A1aA3JohHEhdIygq6/xttwreNnMKtzKIqrt5cJ3FZqch2TXiyCiavjZBk2OEX7kyP/nZe69I723dEabpQXAhkSK01fXmY7zLWhx8kCalBCYxi4jjoqGTQGAg1dV6UKQDTSQSiKXCAhpawFhHOq7/apnjOqM2AOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5252.namprd11.prod.outlook.com (2603:10b6:610:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 03:15:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 03:15:26 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommufd/selftest: Fix dirty_bitmap tests
Thread-Topic: [PATCH] iommufd/selftest: Fix dirty_bitmap tests
Thread-Index: AQHaGK1PaMc4ZYrzRUGxdbcAqgT2ELB9M2SAgAAEKoCAAJ91UA==
Date:   Fri, 17 Nov 2023 03:15:25 +0000
Message-ID: <BN9PR11MB52768448A70C9B3CCB2CDE3D8CB7A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <90e083045243ef407dd592bb1deec89cd1f4ddf2.1700153535.git.robin.murphy@arm.com>
 <72f0e75b-6c91-4c17-beb2-3f198ed05cd0@oracle.com>
 <b541f87c-fa8e-4b09-bf1c-68829bc9e6c9@arm.com>
In-Reply-To: <b541f87c-fa8e-4b09-bf1c-68829bc9e6c9@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5252:EE_
x-ms-office365-filtering-correlation-id: 8386037e-893c-4f53-fdaf-08dbe71b718b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HOPvMNwyK6w848EgMWMYN+MpJLWRtq2rzG4CgJHW92QSNC6KDiXiblfD4elfXC+piTnz++pJiSCIMP3xOIMesXWC5QMTn3Xy8cn0NPmSEbj8trBxQ8AQ8T4vtz4Ngulwm8YQUyI/IYzwF/0kx+RPcIM9Ckd1Wo3qzq09z6lmIO5Z3G9M6vGIyHJbaK/g5nNemdZEUoRCRh4rWnFre8Hb16ZLTfpnlFogYRmpRQN2o22aCPW5Hp8gsmgp4dxCYzpw1yffJ+GRaZ+Et4pAd+8DR9e/chSjW79bfW/Fv8Wk05lIz0JkJY6TTDr3XeMMUGT3635LNDTimWcgrVwy5Dn30IPsN2ynY/l0vghED4/Le50egmalLIfkhWqEDt3iEM0zaEhjyp+JyHOZRS2OxmoTkPPNGc+uXKZhhJiD3E/iKgh6DIft/saNlkPFJ7lXdIh6nq2T03IrbryXLDoK2/4YeqKkbuPDKApnMme3uaN50QmkvIt6GTIasd127KA4KP2nSK2NqEjDzgkl7SZiCw9kUZEvVWIQCvJwkQUA4y9jNkf71tYEAqkTHeI+D7AKn0Fwf8dADLJlGi4ZvQc8ZU8qHIRVUEHAtpdKlnfPtuTXB7qsffi4tPW6LMFu5x9nk/nqhz7ydWXlk7Yno80wBi3cnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82960400001)(2906002)(122000001)(38100700002)(5660300002)(55016003)(52536014)(8676002)(4326008)(86362001)(8936002)(41300700001)(316002)(64756008)(54906003)(66446008)(66556008)(66476007)(66946007)(110136005)(76116006)(38070700009)(478600001)(53546011)(83380400001)(26005)(33656002)(7696005)(9686003)(6506007)(71200400001)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekR2Y1ZERkhhYithRHlUK2xSK29vcWRUZmNBdzBBVmJ6TS85TWk3UW9NdXJh?=
 =?utf-8?B?V0MwRVJmTVpTNUN2M1hYZ1dqWkY0R1lmbHNJS04rbGE5cVhjTk4xWnJuTHZJ?=
 =?utf-8?B?R3Q3MkttdzNhMnFJTTRVQVlHS0c5TU1XK29DaDdhN0M0bTF0VEpRRjR3YU5w?=
 =?utf-8?B?UC9BNDRaRm9XMStvOXo4ZEh0TU9CUE5ZNmx0eG1TV3NOeS9uendXQUFLdEZO?=
 =?utf-8?B?WTVwSTlZelR5eGEyTGM4SHhmRm5NZGd6WWlMWmlPOXlZZ05lRjY3KzFCcTNt?=
 =?utf-8?B?UGs3WDRuSmZKQWxKVHdoTmhkOHhvZ3B6TjZVcmhZREpJT1VVVnlHNTU2eVdp?=
 =?utf-8?B?d1B3NVlRemVEM1RYRGs5WXBsY3ExRGFTeHd5MXRYRW9aYzdwWFJHeVZsaUpR?=
 =?utf-8?B?b3lFRGcyWVA1RDd6TjlRdm56QVFGSVZNMWl0M0V4YzRINUdvR28yeGxzakZT?=
 =?utf-8?B?WmZEeVlsSVpXSWxnMWJLVk9FWHBhYXdxb2psRit4V1RlcEtEQTNEOVBQUXV6?=
 =?utf-8?B?S1l4OG5WaklwZWlNM0RJWmdzS20yb1VoVWlLa2xJaTB5WlJ4Z25CK1JhZWFU?=
 =?utf-8?B?cWNZVHlnQ3BKdk1ZOE82SXFqbDVOSmRYb0hFOUphYVVYQjJkSnVack0xZC96?=
 =?utf-8?B?aEl1RnptYTBLdHZ0R0pnWmJEYnZ4S1BYNlpSZndNR3IzZmN2OUdCY3drdURj?=
 =?utf-8?B?TmlHRDI3NDdPQXlHZURUUjljWmpzRFlMK1BVTjZGdERkZGduYXRvRVgyUEJz?=
 =?utf-8?B?ZXZ5NmNQRVhsMEJEL01paDZMb2ZxN2FMdDViUU5hZFYxMEU3UGwwZkFJQlcw?=
 =?utf-8?B?dE0zaXlpdTFEMTBrbzUyem1OUDhUNlQ2RGVEY3hZQWoyaHAyQkZIakY5QW1I?=
 =?utf-8?B?QU5OSDU2TUNXN0JNc2xXNUZIRHBscmR3Sk9vRU56Z1lvbUtaWE91Qzl0RXBa?=
 =?utf-8?B?SHdhb0N1OE1pY0R2Ly9jckNHYktmVXFRcm9sSDlxcTRrUjFCTHp6enNERnE1?=
 =?utf-8?B?TENuQmpXUFdjYkhnRlBXSFpvVmVmU0pVZTNFWW1VRXF1TXhwODMrZ1o3TW1S?=
 =?utf-8?B?VEd5T3BXbGpEU0F2Qy84WktFMUcrb2I4U0ptOWU0YnRmTHV1QStxN3FkWDkw?=
 =?utf-8?B?NTArcVJZRUtXL2lxL2t0VmFia3JEUGxaNjdPUCtWem5nQkZvUm1pd0dBTUNM?=
 =?utf-8?B?YjFBTFhVYkdZT1V6M0hDbDZYQjBnVnRwREJFUkJ2NUlWOHpnbjhYTnUxaWZ5?=
 =?utf-8?B?eUgvb3ErY1c3Nmx6MWhxWDBiSFFWbWNWc1F5UXBsOFBlRGxRV3lGOVZCYjh0?=
 =?utf-8?B?Ukg2Y2FlMkkySnNmVkt1M2tuYUlkcUtscDdVOEpkbWV6VEdDTCsySDIxeThz?=
 =?utf-8?B?cnhJNjdGZnlISDJOclpLN3NjN25zc0lQb2RBcjBNNmtpamdmY21OQXBCaGZU?=
 =?utf-8?B?d0FVazdpQ3hCOXZpb3F2dEFBeUNGK3ZMNWRxbFR4ZEtJZUlzUTVURVBZbW5W?=
 =?utf-8?B?SWRrQ2dTcFF3dUJiaVV6aWRIWlJ0M2pNUmR0TTRFYkZqaWtPNWN6bVVqVjA3?=
 =?utf-8?B?WXF1YmlSeUlONkZBVWxXb2pLWFluZXgzM1ZqNnZQcnNmY29IenNhVnBVNzBa?=
 =?utf-8?B?UC9KeDdua3d3MHBkRXUyTWYyOHZaWTJaZEJuQ3piZWUwL2xWTHA1cll0Mmhv?=
 =?utf-8?B?bmhQSnlhcUJGdVQ4cCtidG8xM1VteXJFK1k1dUJtdGRjNXR2ZytlSG5DdmpT?=
 =?utf-8?B?dDlyQkg2a09ERkMrenBjZHErazd4NGZHV3lvVUJVOWxzZ1ZNL3JpdWszYWh5?=
 =?utf-8?B?Mlhqc0ZVUkw5bklHMTM4bFNFYmcwQTJ4dlpqK0NMVGcza2kvdHlsZU1jSHV6?=
 =?utf-8?B?c3dmSjBmZ3RDb0VsWlhmZUJWNVZwTjl0MlVCYSt6T1RHODRhdG9GVGIyMDRU?=
 =?utf-8?B?MW94VGpqL0kwbmtmUzJQWTlneFFDcU1EWlF6R0xRQ09mOGgyZU5EK2cxbjBJ?=
 =?utf-8?B?QngzdlNWMnNpQjBNWitkZlNqNkpkOUFzRFcrZXBSV2dySGN5a0V5ZzkvbUxs?=
 =?utf-8?B?REZJaVB3SWJtek9pWTl0QzRaQjlBdmdNOTVyZCsrUjhBN0hiY29FSjh3akxq?=
 =?utf-8?Q?AD3nP3UIc6qQcXrJFVY6j5gQR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8386037e-893c-4f53-fdaf-08dbe71b718b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 03:15:25.8170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +iTM5er8QG0+9gKu0T9KIjuCo9O2xy/J7vBMHF9Ws7zXrXP1/DRNtN5Rd9FazmWUF9ery+0WJ0WYRg9fNs5EYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5252
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBGcmlk
YXksIE5vdmVtYmVyIDE3LCAyMDIzIDE6NDQgQU0NCj4gDQo+IE9uIDE2LzExLzIwMjMgNToyOCBw
bSwgSm9hbyBNYXJ0aW5zIHdyb3RlOg0KPiA+IE9uIDE2LzExLzIwMjMgMTY6NTIsIFJvYmluIE11
cnBoeSB3cm90ZToNCj4gPj4gVGhlIEFTU0VSVF9FUSgpIG1hY3JvIHNuZWFraWx5IGV4cGFuZHMg
dG8gdHdvIHN0YXRlbWVudHMsIHNvIHRoZSBsb29wDQo+ID4+IGhlcmUgbmVlZHMgYnJhY2VzIHRv
IGVuc3VyZSBpdCBjYXB0dXJlcyBib3RoIGFuZCBhY3R1YWxseSB0ZXJtaW5hdGVzIHRoZQ0KPiA+
PiB0ZXN0IHVwb24gZmFpbHVyZS4NCj4gPg0KPiA+IFVnaA0KPiA+DQo+ID4+IFdoZXJlIHRoZXNl
IHRlc3RzIGFyZSBjdXJyZW50bHkgZmFpbGluZyBvbiBteSBhcm02NA0KPiA+PiBtYWNoaW5lLCB0
aGlzIHJlZHVjZXMgdGhlIG51bWJlciBvZiBsb2dnZWQgbGluZXMgZnJvbSBhIHJhdGhlcg0KPiA+
PiB1bnJlYXNvbmFibGUgfjE5NywwMDAgZG93biB0byAxMC4gV2hpbGUgd2UncmUgYXQgaXQsIHdl
IGNhbiBhbHNvIGNsZWFuDQo+ID4+IHVwIHRoZSB0YXV0b2xvZ291cyAiY291bnQiIGNhbGN1bGF0
aW9ucyB3aG9zZSBhc3NlcnRpb25zIGNhbiBuZXZlciBmYWlsDQo+ID4+IHVubGVzcyBtYXRoZW1h
dGljcyBhbmQvb3IgdGhlIEMgbGFuZ3VhZ2UgYmVjb21lIGZ1bmRhbWVudGFsbHkgYnJva2VuLg0K
PiA+Pg0KPiA+PiBGaXhlczogYTlhZjQ3ZTM4MmE0ICgiaW9tbXVmZC9zZWxmdGVzdDogVGVzdA0K
PiBJT01NVV9IV1BUX0dFVF9ESVJUWV9CSVRNQVAiKQ0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBSb2Jp
biBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiA+DQo+ID4gSSB3YXMgZ29pbmcgdG8g
c2F5IHRoYXQgdGhlIHNlY29uZCBhc3NlcnQgaXMgdXNlZnVsLCBidXQgd2UgYXJlIGFscmVhZHkg
dGVzdA0KPiB0aGUNCj4gPiBudW1iZXIgb2YgYml0cyB3ZSBzZXQgYWdhaW5zdCB3aGF0IHRoZSBt
b2NrIGRvbWFpbiBzZXQgYWZ0ZXINCj4gPiBtb2NrX2RvbWFpbl9zZXRfZGlydHkoKS4gU28gdGhl
IHNlY29uZCBpcyByZWR1bmRhbnRseSB0ZXN0aW5nIHRoZSBzYW1lLA0KPiBhbmQgY2FuDQo+ID4g
YmUgcmVtb3ZlZCBhcyB5b3UgYXJlIGRvaW5nLiBUaGFua3MgZm9yIGZpeGluZyB0aGlzLg0KPiAN
Cj4gWWVhaCwgaXQncyBzdGlsbCBlZmZlY3RpdmVseSBqdXN0IGNvdW50aW5nIGhhbGYgdGhlIG51
bWJlciBvZiBsb29wDQo+IGl0ZXJhdGlvbnMgZXhlY3V0ZWQsIGJ1dCBzaW5jZSB0aGVyZSdzIG5v
IGNvbnRyb2wgZmxvdyB0aGF0IGNvdWxkIGV4aXQNCj4gdGhlIGxvb3AgZWFybHkgYW5kIHN0aWxs
IHJlYWNoIHRoZSBhc3NlcnRpb24sIGl0IG11c3QgYWx3YXlzIGJlIHRydWUNCj4gZm9sbG93aW5n
IHRoZSBwcmV2aW91cyBhc3NlcnRpb24gdGhhdCBvdXRfZGlydHkgPT0gbnIgPT0gbmJpdHMvMi4N
Cj4gDQo+ID4gSSB3b3VsZCBzdWdnZXN0IHRoZSBzdWJqZWN0IHRvOg0KPiA+DQo+ID4gCWlvbW11
ZmQvc2VsZnRlc3Q6IEZpeCBfdGVzdF9tb2NrX2RpcnR5X2JpdG1hcHMoKQ0KPiA+DQo+ID4gQmVj
YXVzZSBkaXJ0eS1iaXRtYXAgdGVzdHMgc2VlbXMgdG8gaW1wbHkgdGhlIHdob2xlIGZpeHR1cmUs
IHdoaWNoIGNvdmVycw0KPiBtb3JlDQo+ID4gdGhhbiB0aGUgYml0bWFwcy4NCj4gDQo+IFN1cmUs
IHRoYXQgc291bmRzIHJlYXNvbmFibGUuIEphc29uLCBLZXZpbiwgd291bGQgeW91IHdhbnQgYSB2
MiBmb3IgdGhhdA0KPiBvciBjb3VsZCBpdCBiZSBmaXhlZCB1cCB3aGVuIGFwcGx5aW5nPw0KPiAN
Cg0KSmFzb24gY2FuIGhlbHAgZml4IGl0IHdoZW4gYXBwbHlpbmcuDQoNClJldmlld2VkLWJ5OiBL
ZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCg==
