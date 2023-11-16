Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0B47EDC9D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344874AbjKPIJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjKPIJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:09:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF9B19D;
        Thu, 16 Nov 2023 00:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700122160; x=1731658160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nQU7opSwxmFdXo+q64NsKxBf9EEBvzEoLjnlx8jTA9A=;
  b=ACmIXI8N14o8ycmSyQOtrtGlZLPR2maxsbVbR4tzxKnJAWcljERQFOD9
   J7s5fsvJMiOAdVv6gBvTI77jwIfEVIqjarpYjk3rzuaPe1OSwsSZLh/A0
   73+vOeZ/qwHPamkqO2GEMnpmtSvBP+mXKU4D7kQxYsxeSWltROPLC8LqM
   4YdBp2YxrZTV7+a0BnhQXT3yvaPwJRLtAC8gWcxwsfVeHcCn+vr6+ToRY
   iEwC0Gqs47OJjkFsUrvE4tF5R3niDkxKanMj+l6v9aoNGAzvh4r9Vzwdu
   +h9HAa+xyQ2FQAWuDmC3G34uB/Ir42RXfWCTUyQoSqWcTDwjK+b7L5SKw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="390831004"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="390831004"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 00:09:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="794421497"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="794421497"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 00:09:18 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 00:09:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 00:09:18 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 00:09:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBlfzc93zB4KrGX/VySg1lV4HZYzvzM1RqkunbwiW2mnxv1QK+zlgaKTYBJ+Xp9VvToXyxyqVrDFcRxe9GV1XZeb+hrTCA1YB9ZjXLBDMquQPixQumJkiGF/RFYe/0/Ax811ks6vRYoh8291hwwImOAZDjmQ/NBy9XE3lU+lEnFTG8WYziy8khuWEutRg3BPxf/XUEf1g2AndEbUu5hPznuX7844Cz1weLpfqgovlDnDYjkICkIlam2F5EvpQKUQ54YnH3zaLINZt/YSLo5aA2sox9w1KVP7MJpiwG1WrKxdguhJaXqZwsqOynMXZY3o82HwKydSuHeRmFy8M6YBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQU7opSwxmFdXo+q64NsKxBf9EEBvzEoLjnlx8jTA9A=;
 b=BHa5RVbUeLaVKnONjCzJXs5gpHs5RixDnjJ5akHC+ZDWgZp/YoqwDaNmh6/rmXmsAIv3u/LAH2ULbLbqTFwt0frexEDR+CnvylUD8Vbxq0F99CDRA/T4UVgPzNznADJg19+etg8IZDaEwR6LWsUxo+P8dWnYybMfJxWrq2YGLhplGDU65547xHDfYXVfHk0+UehMoFQREVCUsBea1dIMDMwZDbLTMFCX+2buUv//7EaqR+FusNGN3abN19ulgIoAy03DGuZbXdT01B2WiJrILrdwULVyi2rPgXUIHrm2VGUEAq0jt9S9BQquDSdJhPq+HZ1y61+Rm3WIycQBZabrig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB7446.namprd11.prod.outlook.com (2603:10b6:510:26d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 08:09:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 08:09:15 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Abdul Halim, Mohd Syazwan" <mohd.syazwan.abdul.halim@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Add MTL to quirk list to skip TE
 disabling
Thread-Topic: [PATCH 1/1] iommu/vt-d: Add MTL to quirk list to skip TE
 disabling
Thread-Index: AQHaGDSPS6uE3JB1iU+hol92LQE6VbB8R58QgABD8YCAAAwyEA==
Date:   Thu, 16 Nov 2023 08:09:14 +0000
Message-ID: <BN9PR11MB5276E104C72769026E1FA5C78CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231116022324.30120-1-baolu.lu@linux.intel.com>
 <BN9PR11MB527667F09E2FAD729AE2BC2C8CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b825e828-6dff-4064-896e-df4de24aa6d6@linux.intel.com>
In-Reply-To: <b825e828-6dff-4064-896e-df4de24aa6d6@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB7446:EE_
x-ms-office365-filtering-correlation-id: 3384d95e-5414-4981-90dc-08dbe67b52ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fjtGBRQA6kTQ55nRNviqAKA0Ogyx/+82I4aAwP1v0/9K8IsNnJ4FyL//wAkoOXKNFrkkhxcVXjic5IG39+liBg4dMkvgQiqU2SlMlfIyYCy1feN72ZNcMWG3lxsHFfpSLpEOTfSXgu6MgaBJ/2HJuEXpW2sNVrrliJ/KydVHqm+LobioNhMspkhUJB9Xc3iXootO0fnzGijlHC0FJncAELDYMKzImqptw0qIpNJR23/tU6u32/1CzoqMfwP36OiOifNEKYmjCMu+iWHYLje04obNtoZvrr0VJtKcY3296QDL/wV6qiAbH9FRcu0JcU4TB2VvCgEQWlCK+FjltyE/Y12Yz/UUFBnseqoLHBmo0J+7xM6lOn8jArjELk3gNHYy5Bq4qCvj4Xmju6b3zF0tLKR0NualT+cbJf2EyTW+Tw1orXFZDDBvz1dvIxNL0jVQRe/cEfwRFbQEqU0pMvdj5VbQe2+RvJ4UpSEXOFOVOCnwioKvXW3IDJcBo/v3DpxIgCrNLNssYsOdbbxHC4yZrus5Jvy3zs1+qOVTutvgR5t2SWZxkqJTmf7qjgkBQATLcjGe6V/i4mb3weA2G+O52KXeH/103lwSSocWMbKv+hxQWofzX4DImtD35EDBGUFQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(55016003)(38070700009)(86362001)(2906002)(41300700001)(5660300002)(33656002)(8936002)(52536014)(122000001)(8676002)(4326008)(82960400001)(83380400001)(9686003)(26005)(478600001)(6506007)(316002)(66556008)(71200400001)(110136005)(76116006)(64756008)(53546011)(7696005)(66476007)(66446008)(38100700002)(66946007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE9UWGFjaHVWR25nT2V4NTBvWHU3aFFiTDVpb3o5UlpUeW5tMDFoWm4vaW9i?=
 =?utf-8?B?bUhlNG1ETVdFVHV5d2c4OEw0WUtRWkRQMnZEZkxLZVpGOFc0bXlHUm9nZjFN?=
 =?utf-8?B?bVFrUTNwQVlkUzQ0T0Y3L3pQZ1Z0KzVQbUdxRitPeStjZ2I3OXIzNEdEOVJn?=
 =?utf-8?B?cDgxU0p5M1NrVFlMUjJXNEFIajJXcmsyRVAwaWJaVXo0TEplRVN3cTBVYU8w?=
 =?utf-8?B?cnJES21INjdVK1NkZjdYczhJVWpvSG9LV1VvWHorKzJjdGN3NUlqemFLZ1Bi?=
 =?utf-8?B?Z2VaM0NJbVdTRnljVldoUmJtbjN0anRyUC9mMG5ZRzJTMm1sRlRMWmFvWW1F?=
 =?utf-8?B?eFVkS2tiS09NanMwbEEzWm9zeGdCQlNrTEdYSUh1elVYS1JlN20ycmR6OUpw?=
 =?utf-8?B?ME1lbnhFVEwvUTJyWlRyZlNZRE5WVExDV3ZhWHhvdzFMb2k5N0FhZ2RjMjVH?=
 =?utf-8?B?ckRNcDdjQkV4SDV6Z1VuWEorenRWOFF0cFJLZG5jYjdNZm1HL0psRkQveTlR?=
 =?utf-8?B?Z0FSZzl5emVrektta1p3TWJYUWROaTEwRHlrRkp6T0lieWhQeEQyMGNBcFI0?=
 =?utf-8?B?WDJBcEtoVTNnRWlSZWEreVpiQm8zVzJJYjZDUTVXSWFwakpjYmtFUy9kNVp1?=
 =?utf-8?B?eEE3WHJTT25lQUNLT0lsYjFkRVY5MFhPeHI0VHJVUGtMTEtPYnpWZUFuaWVm?=
 =?utf-8?B?NkxULzM0OGxhenpEbkpJZ3lJbnVvVVdZUmhaSXlwQmZUWU1jOUpwSnBDbkE1?=
 =?utf-8?B?ekNBY2ZpTzlscEx2Z1JJRDV2NW40OEZXbm1oeGNxcjNNanJFQnpad2tuWFdl?=
 =?utf-8?B?T1pkNnZsTkVNWmdUb3N0ZG5xQ25oeEVPeEV3cnpWb1JLZkRvZWlXZUd3WmZn?=
 =?utf-8?B?Y1NOM3JxZXN3Z01aK1pNcDJob2YweWdBWXRYUFhaUmpvaW1EZ0haREpiaFJP?=
 =?utf-8?B?Y2U0R0E5cmRkTFVhelhYZk1tTDVmVUoxS1VXZzJlTDZEMlZJRy9XcmIrVklD?=
 =?utf-8?B?amQzbStmSVJBQlJpVXcrL0lVdEtNNDF5NGZiVUJ1S21iZFhJb21Qa3ByL20v?=
 =?utf-8?B?MXJRRjhNaFNMT3pISGtZQTI1M2Y3STkrTVRYUzRjdkNiRlRJeEo5VWpxckUr?=
 =?utf-8?B?eVRtaWVRNnFzbE1Bd0VOT2d1c1MvTW9NR0VNd1BTWkxIdFpzVjROOVdiZVhF?=
 =?utf-8?B?VDNjN2V2NnV0RGRWNGhPQURHMWdUNEc1MmRiY3g3aG5NWklTOG5TN2tsMUND?=
 =?utf-8?B?dWJoNUNyUW9Ec0IwblNaZkJWRDFMRzlFTGxlWHpncjNMQ3R4M1MwUGRPZXp2?=
 =?utf-8?B?enRaWitTVXpTMi9iWVRIM0N3OWpuWVdBY1F1dENNQ1kxK2lhYXNrUFZQdjJh?=
 =?utf-8?B?TDk5WHh1bkRLNXhxMnltclVXL2NwZEVnbmdOengyeDVDTWVobTdlRElVMnJW?=
 =?utf-8?B?VXVpK21uZ3crMEtjU1V1WXBoR0gwT25xVzJuamUzSlZhb1R1SXNBeTBSbTh6?=
 =?utf-8?B?YmhHcHZtT3VJdDZBZzE5U2huSURVaUF2K0NXRDlTNnJDdzVtaGFYRkNxdlBT?=
 =?utf-8?B?NVZaV0Y5SWRYakRsZlNzZ2lWZmNaOHl2b2srWERINk5GdW5jV2FxWEtwby93?=
 =?utf-8?B?SlhzaW51bnNvV09EdHZxUkp4QVVIcHlVQk5nRWszdHAybURJa2lZanJ5UWR1?=
 =?utf-8?B?V2pIYUc1QStLQlN6SzFEVDg2bWVjejl4R1lRR1JZWEZWTFordGZHUUNGTm90?=
 =?utf-8?B?TjJNUGRVb0ptTzVNWWJGeExscmpqWFY2cUZmMmRUQTdtaFpGSGh6aGtsVVZs?=
 =?utf-8?B?Y3FTbHdQU1U5L3dWcWE3clI5b1pWeFA3QjJHbXJqL3pEcGR4ZU44SktCdzgw?=
 =?utf-8?B?UUt4cnVnRjBIOFp1cnMwNnVNbXZ6SUhIZmdzbjZTSVVtN3puRkk5c0xFMW5i?=
 =?utf-8?B?NktpTHlWbFlkamVzaHhRMlp1SkhpVjVOcjdIaDJtRk14ZkFjR0lFemU5ZG8w?=
 =?utf-8?B?WFg1ZDRTSFBxRHA3TlNwTDFpK25aYUVnZ3lsV0dIZ3ExWkNoZGRMTUFPY3Jk?=
 =?utf-8?B?NXNqR3FJYVUwRytRRzdNL0tmUFZnOWFGQ1o5VmRZaEJIQkNkSVVsZmhJbGFN?=
 =?utf-8?Q?aXc/GRlLjFrgPDC6kQUohEwjR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3384d95e-5414-4981-90dc-08dbe67b52ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 08:09:14.9592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RefrKrB11HY3p65Mh00joyD8H16qIaKHYHX5v5mvrGwsWcpFDDipe9DRNcW2mefWjSv7KE7G9daC3muEy2wbxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7446
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgTm92ZW1iZXIgMTYsIDIwMjMgMzoyNSBQTQ0KPiANCj4gT24gMjAyMy8xMS8xNiAxMToy
NywgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51
eC5pbnRlbC5jb20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAxNiwgMjAyMyAxMDoy
MyBBTQ0KPiA+Pg0KPiA+PiBAQCAtNTA4MCw3ICs1MDgwLDcgQEAgc3RhdGljIHZvaWQgcXVpcmtf
aWdmeF9za2lwX3RlX2Rpc2FibGUoc3RydWN0DQo+ID4+IHBjaV9kZXYgKmRldikNCj4gPj4gICAJ
dmVyID0gKGRldi0+ZGV2aWNlID4+IDgpICYgMHhmZjsNCj4gPj4gICAJaWYgKHZlciAhPSAweDQ1
ICYmIHZlciAhPSAweDQ2ICYmIHZlciAhPSAweDRjICYmDQo+ID4+ICAgCSAgICB2ZXIgIT0gMHg0
ZSAmJiB2ZXIgIT0gMHg4YSAmJiB2ZXIgIT0gMHg5OCAmJg0KPiA+PiAtCSAgICB2ZXIgIT0gMHg5
YSAmJiB2ZXIgIT0gMHhhNykNCj4gPj4gKwkgICAgdmVyICE9IDB4OWEgJiYgdmVyICE9IDB4YTcg
JiYgdmVyICE9IDB4N2QpDQo+ID4+ICAgCQlyZXR1cm47DQo+ID4+DQo+ID4NCj4gPiB0aGlzIGZp
eCBhbG9uZSBpcyBmaW5lLCBidXQgSSBmb3VuZCB0aGlzIHF1aXJrIG92ZXJhbGwgaXMgbm90IGNs
ZWFubHkgaGFuZGxlZC4NCj4gPg0KPiA+IEJhc2ljYWxseSBpdCBzZXRzIGlvbW11X3NraXBfdGVf
ZGlzYWJsZSBhcyB0cnVlLCBsZWFkaW5nIHRvIGVhcmx5IHJldHVybg0KPiA+IGluIGlvbW11X2Rp
c2FibGVfdHJhbnNsYXRpb24oKToNCj4gPg0KPiA+IAlpZiAoaW9tbXVfc2tpcF90ZV9kaXNhYmxl
ICYmIGlvbW11LT5kcmhkLT5nZnhfZGVkaWNhdGVkICYmDQo+ID4gCSAgIChjYXBfcmVhZF9kcmFp
bihpb21tdS0+Y2FwKSB8fCBjYXBfd3JpdGVfZHJhaW4oaW9tbXUtPmNhcCkpKQ0KPiA+IAkJcmV0
dXJuOw0KPiA+DQo+ID4gSG93ZXZlciB0aGUgY2FsbGVyIG9mIGlvbW11X2Rpc2FibGVfdHJhbnNs
YXRpb24oKSBpcyBub3QgYXdhcmUgb2YgdGhpcw0KPiA+IHF1aXJrIGFuZCBjb250aW51ZXMgYXMg
aWYgdGhlIGlvbW11IGlzIGRpc2FibGVkLiBJTUhPIHRoaXMgaXMgcHJvYmxlbWF0aWMNCj4gPiB3
L28gbWVldGluZyB0aGUgY2FsbGVyJ3MgYXNzdW1wdGlvbi4NCj4gPg0KPiA+IGUuZy4ga2R1bXAg
YW5kIHN1c3BlbmQuIFdlIG1heSB3YW50IHRvIGFib3J0IHRob3NlIHBhdGhzIGVhcmx5IGluIGNh
c2UNCj4gPiBvZiBzdWNoIHF1aXJrLi4uDQo+IA0KPiBJIGNhbiBzZWUgeW91ciBwb2ludC4NCj4g
DQo+IFRoaXMgZml4IGlzIGp1c3QgdG8gYWRkIGEgbmV3IGRldmljZSBtb2RlbCB0byB0aGUgZXN0
YWJsaXNoZWQgcXVpcmsNCj4gbGlzdC4gQWxsIGRldmljZXMgKGluY2x1ZGluZyB0aGUgbmV3IG9u
ZSkgaW4gdGhpcyBxdWlyayBsaXN0IGhhdmUNCj4gdW5kZXJnb25lIHRob3JvdWdoIHZlcmlmaWNh
dGlvbi4gVGhlcmVmb3IsIEknZCBsaWtlIHRvIGtlZXAgaXQgYXMtaXMuDQo+IA0KPiBXZSBjYW4g
cmVmaW5lIHRoZSBxdWlyayBpbXBsZW1lbnRhdGlvbiBpbiBhIHNlcGFyYXRlZCBwYXRjaCBzZXJp
ZXMgd2l0aA0KPiBzdWZmaWNpZW50IGNvbnNpZGVyYXRpb24gYW5kIHZlcmlmaWNhdGlvbi4gRG9l
cyB0aGlzIHdvcmsgZm9yIHlvdT8NCg0Kc3VyZQ0K
