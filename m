Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299487B98A6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbjJDXTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjJDXTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:19:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60E7C9;
        Wed,  4 Oct 2023 16:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696461577; x=1727997577;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Cunr3PFt+IcSzadQ/NQHrOSxzc5aIBKf02L3sO4OIN4=;
  b=GewETgp2doh1veJ7MI4BuEnuQcr3sQsuHS/0FT+YzZ2tRZaf7K6JdSd4
   GhzDtsBSwMuISEpJcvtc21dy5F2e5AlC2KCPmXYNNx9ux6LpOaPpldEIn
   PEASa4j+DIrmvno6WtutqqDB3EcRFuYIAQFkhBYsOKytzuowMkZanmgLS
   moQbAyrsebiW1wzfmB3vUESHK172mOuz2Gjzfx4xnwRbB3UtYhdQXOCDS
   SRVrvLApR2DzzHjvw6OjzsF3fw+ptjC9pI10ixYtbXtXXOXgxaz5Y6TzM
   wiOJtuEvDSNivpfnNt/pLCyoNXK0i9mQnbw66sQCnQqf5EhPIrU6Q6+IO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="373683239"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="373683239"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 16:19:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="701391090"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="701391090"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 16:19:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 16:19:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 16:19:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 16:19:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W22Cm+CitGFtz/zFTM8tzSC2rNwV8Jf82YwyF8JGMVP8ndG2dcsxUMRv1Rfezef4YGtMRr57zZqYYTDseJY30SmAWdvREDYjeu9PF8Yl7X1y0f0KEYgo/4aA4cj6NCNKFgXGOKzZ/AnGur8zo4pfOeEXhzJTK/0rJk9FSHcalTCpDtGwVLkrhUTh46o+3HAxToeEBF8og5eJiwYbXAV0NDDQtj0vyIjbsojwnYzgWZBhMkXSeKow720TcibaSBOJQFVq45FvVleXxZrb6ZxBB3BYykJfjorhJp676Vu9QCCSrWZvFgWz4M/ukzIn7RELc+rTEa0zhq3ZIBTnVDobEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cunr3PFt+IcSzadQ/NQHrOSxzc5aIBKf02L3sO4OIN4=;
 b=NJhzLaTfsI8IUn9ypQYZuRPxW3utquL97j2JPBdof/C3qSEZzOnJOlk7JZrCn8oRcuYQFoJ46S4+CIN25AR+b59wq6FFPgPxNnu+47imGe7JKKWXd6p+A5e//+gykR3GmGw4s+nOtRf0EzYmi7xFzCaYT70qsi39NT1YDO/7mxQ5BKxltWx+LFv7nLOS8+D2/vY5WhV99h/QOUTjLnepK/zFW99dj3CffZnsJvAliw7phC2KpZoJUN0vWAw8T8cHLZk1zCwJ+hfXO4GkGxmnLGB4GPI7zcIdl2TsgcdI/ZqmybEu8574TiP8y8wpFHSUebIb4niC/DRaZfvPg6wzXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by DM4PR11MB6094.namprd11.prod.outlook.com (2603:10b6:8:ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 4 Oct
 2023 23:19:30 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::1a1e:c953:cc6c:439]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::1a1e:c953:cc6c:439%5]) with mapi id 15.20.6792.020; Wed, 4 Oct 2023
 23:19:30 +0000
From:   "Colberg, Peter" <peter.colberg@intel.com>
To:     "russ.weight@linux.dev" <russ.weight@linux.dev>,
        "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>, "Rix, Tom" <trix@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH 2/3] fpga: m10bmc-sec: Change contact for secure update
 driver
Thread-Topic: [PATCH 2/3] fpga: m10bmc-sec: Change contact for secure update
 driver
Thread-Index: AQHZ8iuOUIjWU3XrwEC4jc8UymWuFLA6ThoA
Date:   Wed, 4 Oct 2023 23:19:30 +0000
Message-ID: <7e67b2684e5b58bd61fcc7110ca90e1387f5e0ea.camel@intel.com>
References: <20230928164753.278684-1-russell.h.weight@intel.com>
In-Reply-To: <20230928164753.278684-1-russell.h.weight@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|DM4PR11MB6094:EE_
x-ms-office365-filtering-correlation-id: 78cf4f84-1726-4ba3-4a6e-08dbc5305cba
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OSOvAF6Aso09fwCwfwkz9yqzpUIeb/cgFYSqxltr3D6+zITX6pTG5H8yxAtFys7XLnufIrfgI/+gV2G7VQXAb3xBqVVpo0szobMJxXP8tJVlR2oFKV5Ax9wBzBz5TUaAPJFldxq9ogTxHlB4LSZ7P5WHVDFyp04vJwA7+kRSOzWp13CN9zljl2IdMrSn9i4yM2DQGHEGSJ/DR/yvLPhivVrlkt10qfEiSTMTBhERubfOA2cA4c0igJsBtF7/+tTrMIValNeou2tv3jc8ovwKoy0RBKQSoZxonID1slb0hojUVx25Xjuxf+Hz0/SoIKRHEP1shJn0eBHYm5zRT2gjMtCfEiQSF9LaSZl5WS0YWmIOZChKQkqXPVhSWWaHX+bGHlk+vuQ+L5GLrNWPVYiAkel7/BKuee2/oKS9QpcRq/cvEoa030xD7GsFmcjTs0nWG3J7yMUeTfNstEIhuTHkR/4epThfQuR3mfpKurPBn0KlcI6jADUvqUwe9VtQKRAQoXNxQvYnDke7trsXFJ6VqY/cqc9VLpN/HrjXstSYezNw1TYWpD+1OacwNG6ymma9EW84tpkDBV7ylZ62mD8ZZRIEaZtia6cL+42zfdJfSP/XaUQ6ERnV103x2MR4WYSMWZbRHUamyAuBvnUQs1Wppg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(86362001)(8676002)(5660300002)(8936002)(15650500001)(4326008)(2906002)(478600001)(26005)(36756003)(921005)(82960400001)(122000001)(6512007)(2616005)(38100700002)(38070700005)(83380400001)(6486002)(6506007)(71200400001)(316002)(110136005)(91956017)(66946007)(76116006)(41300700001)(66556008)(66476007)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnZMTnhuMXpZSEs3dTZkMS9Vc01zZmlkb3JkL1ZHeldoZ1JXaDJUamQ3UVpE?=
 =?utf-8?B?SSt2cmNCbjVhUjNHRUlZbGNlTjdPNWp2eXNOZUtxWk1MQ2doM0JoeWtWcDh4?=
 =?utf-8?B?RGcyNlk2M1JTSUlZUnkwWStUSzVQaE0vVkpzTzY5UFVMbTNNRnJTQmgyaEJx?=
 =?utf-8?B?eUQzT0p3UkRwcm1QbDZCYUxRQXFxTUQzYzJ0bEFuSTZjUVNmeEF2bkhSRk52?=
 =?utf-8?B?aXp0cHVjZlhJUG8zdHZoKzFVYVlxSDdTc1BZc2o4aVN3bUpNdzRZbHRqV014?=
 =?utf-8?B?QVlGeXdQU1NxM2NiVUlHUWw3RVRjYlcycU00aFZvNllhWUZQYUY0cXVmWHor?=
 =?utf-8?B?RVFRR01vU1lMK1VVR1Q4M21HSGRpcUhTU21JWFNBaUI1RzQybUM3eVZrSWFu?=
 =?utf-8?B?SzRBeE4rTVcvdFc1TnJwN1M1LzVVUldvRjY2NTAyeFVVQ2tFejRtdkxzRkdn?=
 =?utf-8?B?bCswRHI0NUhGK3FCZmgvcURod2RBNE1kT1YrMENiRDBZSm0xSlNMZHJOYU85?=
 =?utf-8?B?ck92NDB2M0VlWlN0LzF0Y2VuT01meEVqRVlnOE93YjV0NHlmdnNZVkJvYlNh?=
 =?utf-8?B?ZmNEUXl5aXFrem9ESUQxTnpjdlNNQSsydVVUbks3WldWK3BXNm5iMDBPU0Yr?=
 =?utf-8?B?bjE1NnRWNEVUL2tDalFpbUhoZW0xQkhPNUNySm5FQ1B2dTVDbE1FaS96REZy?=
 =?utf-8?B?QlQweXR5TVcxS1VGNnZlRlpxVUlYdkp4WDBFS0I1dk00SE50RDdGOE5LLzRs?=
 =?utf-8?B?VThPUjA1N25hZ3o5L3N0dFJ1Zm41cFBnbUxWMmdlWUl0a2szQkpMWmpRSVZk?=
 =?utf-8?B?Q0MwSFZEdGZMcFpNR3BRV2dZNmo4aVVoNlVTa2tjb0Y3YjRQcFNPZDl1TUF5?=
 =?utf-8?B?RDhtaXJTc1JEcW44QnBPRG5DWVA2L1hKcjlmT0ZPU3RtZnpyWitvdUsySU1P?=
 =?utf-8?B?SnVqNzRzcDV2R1pNMGV0R0dVekU0NC80dm5uK3JMWTQybDFPajNkNmhKd2FY?=
 =?utf-8?B?YTFSRWtQRFRTQXhPN2U2ZFFxWUtUZFFVZm0rM0tlMjJXYjRhZVpOcms4V0Ez?=
 =?utf-8?B?N284R1pTakp1YzU1bUFha0tQbXFJSXAwUWxMUjd2R3N3bCt6dnM0cFhHaklJ?=
 =?utf-8?B?U1dNSCsrZTMrY2VrN0xwekR3Q092Z1NBSGJhYmhOTmJGUTZYVERmNXJZR0wx?=
 =?utf-8?B?c2F0SVF6WlNZSUo0K21ub0VpMVVmN2dHckxGUnpoR0RwR2tyMEV6cGQrRmp3?=
 =?utf-8?B?RURLK2Z6c3ZQQTVkajdjMXJHSGJFU2x3YXdjenRyT2M0QlE0M3ZWRTlObjdz?=
 =?utf-8?B?TjlTM2tCQXJaVHZjZllVUUJSREduc0g2blYydmpKR0p6SStmbmFsNVhINUVB?=
 =?utf-8?B?eWxNVkFkdVlzTVJ6cjdKTFhKUWowWE9idDhaUHVSTWJHRkNYNVNaMW11NGNq?=
 =?utf-8?B?Ny9rWWxJZFVKZjlyZ2o3Qm9CaEcrRmxaVTd2dms3QkRraGhxdDFNTEh5aXpC?=
 =?utf-8?B?VStyMzhjTSsrQ0lSZkNmOXNiRGw4NTFDOS9nNVlxazhPTzVlbGpwS0phTFVC?=
 =?utf-8?B?dGFSbHVWd0xycWljZkZMVklCTS9DL2MyYWxCeGVvM3poTEVsMSsvSno2V1I3?=
 =?utf-8?B?eVVpb2dSQjF4REh6SDg4RFZvVUN2TjF2SUE4MDE4VE5WOWYxYjk3T3ZJUTdr?=
 =?utf-8?B?M3B2Nm9LcHJ1cTN3R0JUYlhCcW5xTWNpb3Jqa1hPTWNUZjcrTXRTWndSanZa?=
 =?utf-8?B?S2wvNzRBT0N0RHhWLzhqR0FyMHpCemcyY0QzY1FtQ0x0VVY3bDZDcStteXpY?=
 =?utf-8?B?WVdtWnF6MWR2b25LUHkralpIVGQ4eXhsZEgySm5nMnExaGdtN2FGV2VJNnk1?=
 =?utf-8?B?S2N5TVNCOElOQTlCVlhoNDJrclhSUjFlVmhGNFJJWHNhQXNndWYyRDJvYVZo?=
 =?utf-8?B?enVsbGFwd0toYVZkUDdOV1N6WVBBQXkxQ0lXdEl5KzlQZ0NMV1FLc2tXbFBY?=
 =?utf-8?B?QmVjSGQ4bXUzR1JlUVVDcmpPbEVOK28rUzNEVjc5S2g0aFl0L1ZlMllhaGV3?=
 =?utf-8?B?RUZmeDRYMCtYM1VtRXY5RmcrWThFejkrNGhNNUNoVVBZZTBacGRDeXJOanlT?=
 =?utf-8?B?UEk0MFFOWVBuVUJzK2RGemhDN2djcnI3Tmg3QVJpMHlFbzViVjVVZ1VXWE42?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BC8AFAE6872C74E8D4CC0599E6101A4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cf4f84-1726-4ba3-4a6e-08dbc5305cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 23:19:30.7328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g3epxGMjuYv2F3t85g+T0s95aAr8Ugqc89UbzndDywGoxmT54i81aGVaal5zkcPeu/61vFuEB7wQRw7N3ObnWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6094
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA5LTI4IGF0IDA5OjQ3IC0wNzAwLCBSdXNzIFdlaWdodCB3cm90ZToNCj4g
Q2hhbmdlIHRoZSBtYWludGFpbmVyIGZvciB0aGUgSW50ZWwgTUFYMTAgQk1DIFNlY3VyZSBVcGRh
dGUgZHJpdmVyIGZyb20NCj4gUnVzcyBXZWlnaHQgdG8gUGV0ZXIgQ29sYmVyZy4gVXBkYXRlIHRo
ZSBBQkkgZG9jdW1lbnRhdGlvbiBjb250YWN0DQo+IGluZm9ybWF0aW9uIGFzIHdlbGwuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBSdXNzIFdlaWdodCA8cnVzc2VsbC5oLndlaWdodEBpbnRlbC5jb20+
DQoNCkFja2VkLWJ5OiBQZXRlciBDb2xiZXJnIDxwZXRlci5jb2xiZXJnQGludGVsLmNvbT4NCg0K
PiAtLS0NCj4gIC4uLi90ZXN0aW5nL3N5c2ZzLWRyaXZlci1pbnRlbC1tMTAtYm1jLXNlYy11cGRh
dGUgIHwgMTQgKysrKysrKy0tLS0tLS0NCj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vQUJJL3Rlc3Rpbmcvc3lzZnMtZHJpdmVyLWludGVsLW0xMC1ibWMtc2VjLXVwZGF0ZSBiL0Rv
Y3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZHJpdmVyLWludGVsLW0xMC1ibWMtc2VjLXVw
ZGF0ZQ0KPiBpbmRleCAwYTQxYWZlMGFiNGMuLjkwNTE2OTVkMjIxMSAxMDA2NDQNCj4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1kcml2ZXItaW50ZWwtbTEwLWJtYy1zZWMt
dXBkYXRlDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZHJpdmVyLWlu
dGVsLW0xMC1ibWMtc2VjLXVwZGF0ZQ0KPiBAQCAtMSw3ICsxLDcgQEANCj4gIFdoYXQ6CQkvc3lz
L2J1cy9wbGF0Zm9ybS9kcml2ZXJzL2ludGVsLW0xMGJtYy1zZWMtdXBkYXRlLy4uLi9zZWN1cml0
eS9zcl9yb290X2VudHJ5X2hhc2gNCj4gIERhdGU6CQlTZXAgMjAyMg0KPiAgS2VybmVsVmVyc2lv
bjoJNS4yMA0KPiAtQ29udGFjdDoJUnVzcyBXZWlnaHQgPHJ1c3NlbGwuaC53ZWlnaHRAaW50ZWwu
Y29tPg0KPiArQ29udGFjdDoJUGV0ZXIgQ29sYmVyZyA8cGV0ZXIuY29sYmVyZ0BpbnRlbC5jb20+
DQo+ICBEZXNjcmlwdGlvbjoJUmVhZCBvbmx5LiBSZXR1cm5zIHRoZSByb290IGVudHJ5IGhhc2gg
Zm9yIHRoZSBzdGF0aWMNCj4gIAkJcmVnaW9uIGlmIG9uZSBpcyBwcm9ncmFtbWVkLCBlbHNlIGl0
IHJldHVybnMgdGhlDQo+ICAJCXN0cmluZzogImhhc2ggbm90IHByb2dyYW1tZWQiLiAgVGhpcyBm
aWxlIGlzIG9ubHkNCj4gQEAgLTExLDcgKzExLDcgQEAgRGVzY3JpcHRpb246CVJlYWQgb25seS4g
UmV0dXJucyB0aGUgcm9vdCBlbnRyeSBoYXNoIGZvciB0aGUgc3RhdGljDQo+ICBXaGF0OgkJL3N5
cy9idXMvcGxhdGZvcm0vZHJpdmVycy9pbnRlbC1tMTBibWMtc2VjLXVwZGF0ZS8uLi4vc2VjdXJp
dHkvcHJfcm9vdF9lbnRyeV9oYXNoDQo+ICBEYXRlOgkJU2VwIDIwMjINCj4gIEtlcm5lbFZlcnNp
b246CTUuMjANCj4gLUNvbnRhY3Q6CVJ1c3MgV2VpZ2h0IDxydXNzZWxsLmgud2VpZ2h0QGludGVs
LmNvbT4NCj4gK0NvbnRhY3Q6CVBldGVyIENvbGJlcmcgPHBldGVyLmNvbGJlcmdAaW50ZWwuY29t
Pg0KPiAgRGVzY3JpcHRpb246CVJlYWQgb25seS4gUmV0dXJucyB0aGUgcm9vdCBlbnRyeSBoYXNo
IGZvciB0aGUgcGFydGlhbA0KPiAgCQlyZWNvbmZpZ3VyYXRpb24gcmVnaW9uIGlmIG9uZSBpcyBw
cm9ncmFtbWVkLCBlbHNlIGl0DQo+ICAJCXJldHVybnMgdGhlIHN0cmluZzogImhhc2ggbm90IHBy
b2dyYW1tZWQiLiAgVGhpcyBmaWxlDQo+IEBAIC0yMSw3ICsyMSw3IEBAIERlc2NyaXB0aW9uOglS
ZWFkIG9ubHkuIFJldHVybnMgdGhlIHJvb3QgZW50cnkgaGFzaCBmb3IgdGhlIHBhcnRpYWwNCj4g
IFdoYXQ6CQkvc3lzL2J1cy9wbGF0Zm9ybS9kcml2ZXJzL2ludGVsLW0xMGJtYy1zZWMtdXBkYXRl
Ly4uLi9zZWN1cml0eS9ibWNfcm9vdF9lbnRyeV9oYXNoDQo+ICBEYXRlOgkJU2VwIDIwMjINCj4g
IEtlcm5lbFZlcnNpb246CTUuMjANCj4gLUNvbnRhY3Q6CVJ1c3MgV2VpZ2h0IDxydXNzZWxsLmgu
d2VpZ2h0QGludGVsLmNvbT4NCj4gK0NvbnRhY3Q6CVBldGVyIENvbGJlcmcgPHBldGVyLmNvbGJl
cmdAaW50ZWwuY29tPg0KPiAgRGVzY3JpcHRpb246CVJlYWQgb25seS4gUmV0dXJucyB0aGUgcm9v
dCBlbnRyeSBoYXNoIGZvciB0aGUgQk1DIGltYWdlDQo+ICAJCWlmIG9uZSBpcyBwcm9ncmFtbWVk
LCBlbHNlIGl0IHJldHVybnMgdGhlIHN0cmluZzoNCj4gIAkJImhhc2ggbm90IHByb2dyYW1tZWQi
LiAgVGhpcyBmaWxlIGlzIG9ubHkgdmlzaWJsZSBpZiB0aGUNCj4gQEAgLTMxLDcgKzMxLDcgQEAg
RGVzY3JpcHRpb246CVJlYWQgb25seS4gUmV0dXJucyB0aGUgcm9vdCBlbnRyeSBoYXNoIGZvciB0
aGUgQk1DIGltYWdlDQo+ICBXaGF0OgkJL3N5cy9idXMvcGxhdGZvcm0vZHJpdmVycy9pbnRlbC1t
MTBibWMtc2VjLXVwZGF0ZS8uLi4vc2VjdXJpdHkvc3JfY2FuY2VsZWRfY3Nrcw0KPiAgRGF0ZToJ
CVNlcCAyMDIyDQo+ICBLZXJuZWxWZXJzaW9uOgk1LjIwDQo+IC1Db250YWN0OglSdXNzIFdlaWdo
dCA8cnVzc2VsbC5oLndlaWdodEBpbnRlbC5jb20+DQo+ICtDb250YWN0OglQZXRlciBDb2xiZXJn
IDxwZXRlci5jb2xiZXJnQGludGVsLmNvbT4NCj4gIERlc2NyaXB0aW9uOglSZWFkIG9ubHkuIFJl
dHVybnMgYSBsaXN0IG9mIGluZGljZXMgZm9yIGNhbmNlbGVkIGNvZGUNCj4gIAkJc2lnbmluZyBr
ZXlzIGZvciB0aGUgc3RhdGljIHJlZ2lvbi4gVGhlIHN0YW5kYXJkIGJpdG1hcA0KPiAgCQlsaXN0
IGZvcm1hdCBpcyB1c2VkIChlLmcuICIxLDItNiw5IikuDQo+IEBAIC0zOSw3ICszOSw3IEBAIERl
c2NyaXB0aW9uOglSZWFkIG9ubHkuIFJldHVybnMgYSBsaXN0IG9mIGluZGljZXMgZm9yIGNhbmNl
bGVkIGNvZGUNCj4gIFdoYXQ6CQkvc3lzL2J1cy9wbGF0Zm9ybS9kcml2ZXJzL2ludGVsLW0xMGJt
Yy1zZWMtdXBkYXRlLy4uLi9zZWN1cml0eS9wcl9jYW5jZWxlZF9jc2tzDQo+ICBEYXRlOgkJU2Vw
IDIwMjINCj4gIEtlcm5lbFZlcnNpb246CTUuMjANCj4gLUNvbnRhY3Q6CVJ1c3MgV2VpZ2h0IDxy
dXNzZWxsLmgud2VpZ2h0QGludGVsLmNvbT4NCj4gK0NvbnRhY3Q6CVBldGVyIENvbGJlcmcgPHBl
dGVyLmNvbGJlcmdAaW50ZWwuY29tPg0KPiAgRGVzY3JpcHRpb246CVJlYWQgb25seS4gUmV0dXJu
cyBhIGxpc3Qgb2YgaW5kaWNlcyBmb3IgY2FuY2VsZWQgY29kZQ0KPiAgCQlzaWduaW5nIGtleXMg
Zm9yIHRoZSBwYXJ0aWFsIHJlY29uZmlndXJhdGlvbiByZWdpb24uIFRoZQ0KPiAgCQlzdGFuZGFy
ZCBiaXRtYXAgbGlzdCBmb3JtYXQgaXMgdXNlZCAoZS5nLiAiMSwyLTYsOSIpLg0KPiBAQCAtNDcs
NyArNDcsNyBAQCBEZXNjcmlwdGlvbjoJUmVhZCBvbmx5LiBSZXR1cm5zIGEgbGlzdCBvZiBpbmRp
Y2VzIGZvciBjYW5jZWxlZCBjb2RlDQo+ICBXaGF0OgkJL3N5cy9idXMvcGxhdGZvcm0vZHJpdmVy
cy9pbnRlbC1tMTBibWMtc2VjLXVwZGF0ZS8uLi4vc2VjdXJpdHkvYm1jX2NhbmNlbGVkX2Nza3MN
Cj4gIERhdGU6CQlTZXAgMjAyMg0KPiAgS2VybmVsVmVyc2lvbjoJNS4yMA0KPiAtQ29udGFjdDoJ
UnVzcyBXZWlnaHQgPHJ1c3NlbGwuaC53ZWlnaHRAaW50ZWwuY29tPg0KPiArQ29udGFjdDoJUGV0
ZXIgQ29sYmVyZyA8cGV0ZXIuY29sYmVyZ0BpbnRlbC5jb20+DQo+ICBEZXNjcmlwdGlvbjoJUmVh
ZCBvbmx5LiBSZXR1cm5zIGEgbGlzdCBvZiBpbmRpY2VzIGZvciBjYW5jZWxlZCBjb2RlDQo+ICAJ
CXNpZ25pbmcga2V5cyBmb3IgdGhlIEJNQy4gIFRoZSBzdGFuZGFyZCBiaXRtYXAgbGlzdCBmb3Jt
YXQNCj4gIAkJaXMgdXNlZCAoZS5nLiAiMSwyLTYsOSIpLg0KPiBAQCAtNTUsNyArNTUsNyBAQCBE
ZXNjcmlwdGlvbjoJUmVhZCBvbmx5LiBSZXR1cm5zIGEgbGlzdCBvZiBpbmRpY2VzIGZvciBjYW5j
ZWxlZCBjb2RlDQo+ICBXaGF0OgkJL3N5cy9idXMvcGxhdGZvcm0vZHJpdmVycy9pbnRlbC1tMTBi
bWMtc2VjLXVwZGF0ZS8uLi4vc2VjdXJpdHkvZmxhc2hfY291bnQNCj4gIERhdGU6CQlTZXAgMjAy
Mg0KPiAgS2VybmVsVmVyc2lvbjoJNS4yMA0KPiAtQ29udGFjdDoJUnVzcyBXZWlnaHQgPHJ1c3Nl
bGwuaC53ZWlnaHRAaW50ZWwuY29tPg0KPiArQ29udGFjdDoJUGV0ZXIgQ29sYmVyZyA8cGV0ZXIu
Y29sYmVyZ0BpbnRlbC5jb20+DQo+ICBEZXNjcmlwdGlvbjoJUmVhZCBvbmx5LiBSZXR1cm5zIG51
bWJlciBvZiB0aW1lcyB0aGUgc2VjdXJlIHVwZGF0ZQ0KPiAgCQlzdGFnaW5nIGFyZWEgaGFzIGJl
ZW4gZmxhc2hlZC4NCj4gIAkJRm9ybWF0OiAiJXUiLg0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5F
UlMgYi9NQUlOVEFJTkVSUw0KPiBpbmRleCBiOTdlZTZmNTA2NzkuLjgwMDZjMzU5NTZiYiAxMDA2
NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5FUlMNCj4gQEAgLTEwNzU1
LDcgKzEwNzU1LDcgQEAgRjoJZHJpdmVycy9tZmQvaW50ZWwtbTEwLWJtYyoNCj4gIEY6CWluY2x1
ZGUvbGludXgvbWZkL2ludGVsLW0xMC1ibWMuaA0KPiAgDQo+ICBJTlRFTCBNQVgxMCBCTUMgU0VD
VVJFIFVQREFURVMNCj4gLU06CVJ1c3MgV2VpZ2h0IDxydXNzZWxsLmgud2VpZ2h0QGludGVsLmNv
bT4NCj4gK006CVBldGVyIENvbGJlcmcgPHBldGVyLmNvbGJlcmdAaW50ZWwuY29tPg0KPiAgTDoJ
bGludXgtZnBnYUB2Z2VyLmtlcm5lbC5vcmcNCj4gIFM6CU1haW50YWluZWQNCj4gIEY6CURvY3Vt
ZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZHJpdmVyLWludGVsLW0xMC1ibWMtc2VjLXVwZGF0
ZQ0KDQo=
