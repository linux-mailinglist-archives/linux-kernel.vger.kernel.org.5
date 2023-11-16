Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6EB7EDCD3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344939AbjKPIYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKPIYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:24:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA9F101
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700123072; x=1731659072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l3FblwjFWPY5RN2tO1kzqXX5GnOEjRF7HXXQ+atqUHs=;
  b=L0J5Cmw58mXS341dqTrau/2qMtSm2YRn0+ohnKP50cxODh5ZtuQ/deY+
   8Af/gVnYBrkmbnn+kN0nCvtDVUiHdV8MbW3/M7w+BnlABNayp5gSFzfst
   DdTHns9DHKJjS39mVUavdz7L99LCiTzd4jT2LtkctFaO0TYrXMbVFXEvq
   eZrj+MQUkdPqUyTBo6Y23H2dM0esPsH+zF+6ePyFPiZJc/ZFlKoSdLtiX
   vAap8aGsNCDTyvunB8MB/V/EjkTfIdqw9jUjxoyFvT4LzvJ9atKv0Ys1O
   HlFT3Lx/jTiGei2ulUC0yG21YO4AlPNk53CyVN+vqV38/QTse3cafFV2t
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="455333422"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="455333422"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 00:24:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="6449151"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 00:24:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 00:24:31 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 00:24:31 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 00:24:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoS7JBnAahwCyRpJ9RRFNEnr7KyHaGx0u151FJAIn/IC5F5ykp0FPHmTN3v42zbzv1TbzGN7BpiRtQSiDVC5CA8Gw+ZJaY4MjU2bZpG3gyVq+T8eSHKBvncKXDFAKMZzNaz049E30NbYjeGTFqicI/GQu+wrtHYmrN70TWlKh0BklLfARHFHNwnV+X66qxSnMIZpnBdtxYwlYFJDGHPYa0cWyYsMvF48R2k5uKCPKcXr5aTSdS8oWB2GdYfwabgo39lDniFjylxElH9/E/MeGTtWUqW7TfCHHl1XL4T984+IMvuOh4z0ILYy9019xfDeQf9amjSEBPwIiOw+7YAnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3FblwjFWPY5RN2tO1kzqXX5GnOEjRF7HXXQ+atqUHs=;
 b=kZ3MGX2fjEAdocFLDj2Te3Gzz8y8fWWLi5wl1o56kWB4IfyMr9dPej4r4P8thLFky+DzN7OysaDEsz4ro5AWkFZ4w+xFay6FYUnnrEl5C4M/KQaDIFuVnY0kJa+KGLwJtzceJBOQAqqFdWL+Hfgv11U4xD8CRDmYNqCQ+WKq4EWw3vJYOvQUmI8bdnXa7ocgtNz2VBYk8FOQXJWr24fbSLT6LZgLU+9bhOmVhxs4fK24TNEkG714fIrtdG+YGZodNCd5jTc47/uJxwmIbf0X7eLF46/Pwuwafn90LFyZefFy/wj3P5ROLGwEfmKsMWbY+gUi20+2rBYHWDMFuejHZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8209.namprd11.prod.outlook.com (2603:10b6:610:15d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Thu, 16 Nov
 2023 08:24:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 08:24:24 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Disable PCI ATS in legacy passthrough
 mode
Thread-Topic: [PATCH 1/1] iommu/vt-d: Disable PCI ATS in legacy passthrough
 mode
Thread-Index: AQHaFpgBxWBJti3g4kChnloBJh6r1bB8ka6AgAAMNYA=
Date:   Thu, 16 Nov 2023 08:24:23 +0000
Message-ID: <BN9PR11MB52761B8ECFC7A5724A61894E8CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-3-baolu.lu@linux.intel.com>
 <0f8c95f3-c16e-497e-9734-85936ae08f82@linux.intel.com>
In-Reply-To: <0f8c95f3-c16e-497e-9734-85936ae08f82@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8209:EE_
x-ms-office365-filtering-correlation-id: c306c6ff-3816-46bb-16a8-08dbe67d70aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NCTGdII+JGZws1sC9fzS0PF6rReWdka2gjX7pE261BAFGcjMMNGPeOpJ+yhvhfFiZJ2WKgtslyzZs2KqZpI2YXgPAx3MoiJ8YbsA7TVVEJixnnYqMRJs+yrzTpU3pozCI2jmD8KNECQXgywDPwUcXqxmYtoVcE2aCXIzoBX94Y1zMzDOw6xnoG/xXIEWF4IKs3sb8eeAFAGc0sgsE4FEaw5H0tQ+pV6h9neYdtLIt5oBv9WBHjNAycPvxMJ1NDsH8MlgsFcSzC4F22GT1g4lJIAIiI6zOsko1tbwey62w6qU7hLU3446xMJ7uC2y3l1WKfQcRJFbU+58scCHD6G/7fUvLBIgiMXV7fE07l8uFiNlxA1nQ6zu+OfH7ff+luN479nnFEQB2f63NCoxMSllp53d4iB76GBo27Vj4Bl6Q/BGkQqmevazW4larRnJ5EyX/teq+gtJVa/OdHtmhyD3WJCEQvkES8fbxFPw5GPu8mN5IO9jFqPepMDpy0smPl896PBkOAFR+9VNEcgFPipWzea6LptJP1yN5JuMzVUyGMpASKHGaVmjsZ5QK920d1YLMhxh4iVuypcwAYInp76Pt0gfhHb8miF4GC3Y1RDqWhzwNBcEBliQpp9rCsOYsQMH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(7696005)(76116006)(316002)(64756008)(66556008)(8676002)(4326008)(54906003)(66446008)(110136005)(66476007)(66946007)(8936002)(52536014)(71200400001)(478600001)(41300700001)(86362001)(33656002)(5660300002)(2906002)(122000001)(38100700002)(26005)(53546011)(9686003)(83380400001)(82960400001)(6506007)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjI2cXc0ekhvSmVWR0J1bUZ4ejZlTE0veFVhSlhBUFBTRzlKeXRFMXFwY0E3?=
 =?utf-8?B?Q2dmTHAwSm16VTFUSW5KaHN3OVlyWC9iaWNyMlk4N2N3WUJyMXNhVnJ2MGZv?=
 =?utf-8?B?WHlXSEtoSlc5NjBtNDJUVHRYMGpEcUlSb24wc0kraFhhcVBQWXRpVldtSGwz?=
 =?utf-8?B?cEpOS1ZTcUxuZVNmcmlBcHNuaWhZc0NGYkE1cTdUZVhKeTFySWducDlONEdm?=
 =?utf-8?B?SzY0STJJdFBkK3FEK2ZQV3lEN0hybHdOdmV3QU5tUnFEUWxDVjluVU1iZmgw?=
 =?utf-8?B?T2VYOFRZVVdRUnk2aXlXYm54aVFkNWZoUmMrMEdIb0V0NHl5RW91ZUlrbWV3?=
 =?utf-8?B?NmJ3clkrMG1rRkJ2UFdzWUFSdjdqYjk0QVh3WE9Cc3Q4eUZMTCt2a2wzTU9V?=
 =?utf-8?B?eXJoallNZ2VYWDVSdFF2QjIzSDU2b3dPbnhkTHBITVh4djBFUlBjbHd5Q1pL?=
 =?utf-8?B?OUN5QWpBdHErT0tmUTVOSHFUOWZNaUE0UjJUeXFZSnJMZUFLUFdDM1h6Z29v?=
 =?utf-8?B?VkF3MjhZUTdOak9BcHRYZ3lVSy9veUxkczlDRWlhb0c2RThlR0ZPZDkwdjlo?=
 =?utf-8?B?ZkFlTmJvT05YMjZDbm0wcmFlc2RMejc2SXk0TXVya2NHNXdIOUpzbmljRHh5?=
 =?utf-8?B?R2pKMHA2ZkdHQVVQMTI1RVNZV2tCYVJJUWtPVnZNclRpNEtvUG8rbXlvNDlp?=
 =?utf-8?B?SFU4bE9teTZQVmpRNis0UGdrNlpoRlJGM3BGMEZ4dVBKQ09SdlBFSHl0VUVi?=
 =?utf-8?B?U0o2NTdyblNRS2FVOEp5VDk5UFRGQzBRWGx3aHFxYzNvbkY5cmpyWmpZSEZP?=
 =?utf-8?B?WUdlNmFOamFSVldBSm5FaXFFV2duTzBDT3UvYVlETHcwVkwwaldVN09CVkhU?=
 =?utf-8?B?MVU0SkpVMCttMG4xdm5OaHJuOUUzd2hpMitidm8rNGJnSE1HVlRNOWZZdWpl?=
 =?utf-8?B?eUliV09TU2NyS2dyVjRqYTlNZDM5VGtveXdGazVraHorN2h5R1ZRQWd4SjAr?=
 =?utf-8?B?MVlNTks0L2F1bzBHUGdqVE1jN0NRZmY5amFZQVdKZXhBcVBCMkhidG5BVUhM?=
 =?utf-8?B?V3pUZFlpcmczZC90WlluekdYc2M4OTB2d3Zwc2FzdU1KdkxLUmVMeHcvQkx4?=
 =?utf-8?B?Q1ExWWc2K2dzelBpak11TDBlNkhxQTdZVDBZdXkwNXVLdEtmYmQ2aXQxYVU3?=
 =?utf-8?B?V0N0bGUzM2FtK2hQTjlUTHc1MzZhdUN4ZzM1MGNYRDN6UTYwRDJaL1BweGFR?=
 =?utf-8?B?amdwWm9zVityUFJoaEpZTDAyTktzNjJ5NHdlRjZPTkNTWWZhUUc3OG14c1Vv?=
 =?utf-8?B?ckpBTEZyWXArbDFNU0VBSjlXSzI5SEUyRkwyUmo5RWF0VWl2NDBaRVhnbTBH?=
 =?utf-8?B?bFJpZ3pSTUhVS294bmJidzQyeHZ1TkJKM0VsRkFBa3hlUmxOWmF4WUxWMnIw?=
 =?utf-8?B?OHF4V1oxcEdrTUFnaVhiaXd3UEJzd3dhOCtEZHBweC9vQjhrZitZcUhKdzlR?=
 =?utf-8?B?ODNSRGFPQ0ZCNXFGNHhOVnhQOUZaa3hZbitNenducFBYYUNFYUZ6M2FOZkpi?=
 =?utf-8?B?c3ZmK29Db0ZjSjhlMTU0TDlYbGZNclN1anNtU01qVUpFWjFXbUdwclpOQ0Rp?=
 =?utf-8?B?VTRCZjhRalZCb1RjUVhObVRUT09mbFNhbWowOEJ6bHFhUnJlcW1iWEJ6UWJG?=
 =?utf-8?B?QlZjb09DWThFMUdiZTVVSmFZWDFWSDd6N0xIU3hybGNDUFZiTktzN1d5Y201?=
 =?utf-8?B?bVJCQ3NmN3Vra2E4VjJPUm9oQ0Z1b3l3YXFjT0lYY2Z5QjJJVUw5bDd4MlhZ?=
 =?utf-8?B?UlpUdEZYdzRwZUxab0VWeVc5ZndqTzNMYVNNVjhxNDJmWHVhTUdKaEJpaXhC?=
 =?utf-8?B?ZDFPTWlpdWtqWGMybjRaVS92RzlzbGF1UmtTRnpLcitON3YxZGYvWFI5R1Bs?=
 =?utf-8?B?VmVkSUkzamNMYjNkTDNrUFhOT2k3K0xFRVlaZW5YVWNLOFczU09qc1g1WFNa?=
 =?utf-8?B?VFV1enBRaGhCd2gxSnRMRmY2WEVoTUJmZTZIek1TWC9LTVBHWU9RTjFRZzB1?=
 =?utf-8?B?U3FjVlRDeUdjekxleS94N1NDOWxpQ1JYcmFTcjU1bElrdTNKMVI5MEs0OHF2?=
 =?utf-8?Q?Y3ktNwKD3HwYLsk519Jtt6zwH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c306c6ff-3816-46bb-16a8-08dbe67d70aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 08:24:23.8046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRh2vQq40i4kWw7OOYRdqF7AWMH/jA0GHSLK++IJkaqFquY0P3Wq5gM0jnnz/p2GBTW5yBfkWBJ/tvuif7MRCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8209
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
c2RheSwgTm92ZW1iZXIgMTYsIDIwMjMgMzozNSBQTQ0KPiANCj4gT24gMjAyMy8xMS8xNCA5OjEw
LCBMdSBCYW9sdSB3cm90ZToNCj4gPiBXaGVuIElPTU1VIGhhcmR3YXJlIG9wZXJhdGVzIGluIGxl
Z2FjeSBtb2RlLCB0aGUgVFQgZmllbGQgb2YgdGhlDQo+IGNvbnRleHQNCj4gPiBlbnRyeSBkZXRl
cm1pbmVzIHRoZSB0cmFuc2xhdGlvbiB0eXBlLCB3aXRoIHRocmVlIHN1cHBvcnRlZCB0eXBlcyAo
U2VjdGlvbg0KPiA+IDkuMyBDb250ZXh0IEVudHJ5KToNCj4gPg0KPiA+IC0gRE1BIHRyYW5zbGF0
aW9uIHdpdGhvdXQgZGV2aWNlIFRMQiBzdXBwb3J0DQo+ID4gLSBETUEgdHJhbnNsYXRpb24gd2l0
aCBkZXZpY2UgVExCIHN1cHBvcnQNCj4gPiAtIFBhc3N0aHJvdWdoIG1vZGUgd2l0aCB0cmFuc2xh
dGVkIGFuZCB0cmFuc2xhdGlvbiByZXF1ZXN0cyBibG9ja2VkDQo+ID4NCj4gPiBEZXZpY2UgVExC
IHN1cHBvcnQgaXMgYWJzZW50IHdoZW4gaGFyZHdhcmUgaXMgY29uZmlndXJlZCBpbiBwYXNzdGhy
b3VnaA0KPiA+IG1vZGUuDQo+ID4NCj4gPiBEaXNhYmxlIHRoZSBQQ0kgQVRTIGZlYXR1cmUgd2hl
biBJT01NVSBpcyBjb25maWd1cmVkIGZvciBwYXNzdGhyb3VnaA0KPiA+IHRyYW5zbGF0aW9uIHR5
cGUgaW4gbGVnYWN5IChub24tc2NhbGFibGUpIG1vZGUuDQo+ID4NCj4gPiBGaXhlczogMGZhYTE5
YTE1MTVmICgiaW9tbXUvdnQtZDogRGVjb3VwbGUgUEFTSUQgJiBQUkkgZW5hYmxpbmcgZnJvbQ0K
PiBTVkEiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRl
bC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgfCA0ICsr
KysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2ludGVs
L2lvbW11LmMNCj4gPiBpbmRleCAxMTY3MGNkODEyYTMuLmMzZWMwOTExOGFiMSAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gPiArKysgYi9kcml2ZXJzL2lv
bW11L2ludGVsL2lvbW11LmMNCj4gPiBAQCAtMTQxMyw2ICsxNDEzLDEwIEBAIHN0YXRpYyB2b2lk
IGlvbW11X2VuYWJsZV9wY2lfY2FwcyhzdHJ1Y3QNCj4gZGV2aWNlX2RvbWFpbl9pbmZvICppbmZv
KQ0KPiA+ICAgCWlmICghZGV2X2lzX3BjaShpbmZvLT5kZXYpKQ0KPiA+ICAgCQlyZXR1cm47DQo+
ID4NCj4gPiArCWlmICghc21fc3VwcG9ydGVkKGluZm8tPmlvbW11KSAmJiBpbmZvLT5kb21haW4g
JiYNCj4gPiArCSAgICBkb21haW5fdHlwZV9pc19zaShpbmZvLT5kb21haW4pKQ0KPiA+ICsJCXJl
dHVybjsNCj4gPiArDQo+ID4gICAJcGRldiA9IHRvX3BjaV9kZXYoaW5mby0+ZGV2KTsNCj4gPg0K
PiA+ICAgCS8qIFRoZSBQQ0llIHNwZWMsIGluIGl0cyB3aXNkb20sIGRlY2xhcmVzIHRoYXQgdGhl
IGJlaGF2aW91ciBvZg0KPiANCj4gUGVyaGFwcyB3ZSBjb3VsZCBtb3ZlIHRoZSBjaGVjayBpbnRv
IHRoZSBjYWxsZXIgYW5kIG1ha2UgdGhpcyBoZWxwZXINCj4gdHJhbnNwYXJlbnQgdG8gdGhlIGlv
bW11IG1vZGUgYW5kIGRvbWFpbiB0eXBlPw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9t
bXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiBpbmRleCAx
MTY3MGNkODEyYTMuLjliZGRkNGZiYmRmOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9p
bnRlbC9pb21tdS5jDQo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiBAQCAt
MjQ5Miw3ICsyNDkyLDggQEAgc3RhdGljIGludCBkbWFyX2RvbWFpbl9hdHRhY2hfZGV2aWNlKHN0
cnVjdA0KPiBkbWFyX2RvbWFpbiAqZG9tYWluLA0KPiAgICAgICAgICAgICAgICAgIHJldHVybiBy
ZXQ7DQo+ICAgICAgICAgIH0NCj4gDQo+IC0gICAgICAgaW9tbXVfZW5hYmxlX3BjaV9jYXBzKGlu
Zm8pOw0KPiArICAgICAgIGlmIChzbV9zdXBwb3J0ZWQoaW5mby0+aW9tbXUpIHx8ICFkb21haW5f
dHlwZV9pc19zaShpbmZvLT5kb21haW4pKQ0KPiArICAgICAgICAgICAgICAgaW9tbXVfZW5hYmxl
X3BjaV9jYXBzKGluZm8pOw0KPiANCg0KSU1ITyBib3RoIG9sZCBhbmQgdGhpcyBuZXcgdmVyc2lv
biBhcmUgY29uZnVzaW5nIHJlZ2FyZGluZyB0byB0aGF0DQp0aGUgY29tbWl0IG1zZyB0YWxrcyBv
bmx5IGFib3V0IEFUUyBidXQgdGhlIGFjdHVhbCBjb2RlIGRpc2FibGUgYWxsDQpwY2kgY2Fwcy4g
SXQncyBjb3JyZWN0LCBiZWluZyB0aGF0IG9ubHkgQVRTIGlzIHJlbGV2YW50IGluIGxlZ2FjeSBt
b2RlLA0KYnV0IHRoZSByZWFkYWJpbGl0eSBpcyBub3QgZ29vZC4NCg0Kd2hhdCBhYm91dCBpbnRy
b2R1Y2luZyBhIGhlbHBlciBlLmcuIGRldmljZV9kb21haW5fYXRzX3N1cHBvcnRlZChpbmZvKQ0K
d2hpY2ggaW5jbHVkZXMgYWJvdmUgY2hlY2tzIHBsdXMgaW5mby0+YXRzX3N1cHBvcnRlZCBhbmQg
dGhlbiB1c2UgaXQNCnRvIHJlcGxhY2UgaW5mby0+YXRzX3N1cHBvcnRlZCBpbiBpb21tdV9lbmFi
bGVfcGNpX2NhcHMoKT8NCg0K
