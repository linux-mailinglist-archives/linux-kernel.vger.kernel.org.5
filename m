Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AA081088A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 04:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378383AbjLMDEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 22:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378288AbjLMDEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 22:04:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB4DAB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 19:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702436658; x=1733972658;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qj1/zrhcvYwWhkpCbszHZkXF4Yseau1dJ5t/Z+s2PiA=;
  b=GoTm3BuJPukwDZNjUIbMThxp0/enc40mnrKw/m1cruj2QwoocsyAsUL9
   PKOLAQCatGTpvGcD29eeuH4adCQo3GzFmN+fCwhHoqcHDc30kc41xPJ84
   9KLmk8wOFTfqcmoHDmsc0vuyODxn999uH1JFidZqPR5axaV2pgiu5sdRh
   VrBwcWlv5N3R6QwW2A4aVoEHkadkM8v54cQ4C8Bz1kPMRCVbQehY6pPyi
   vZE+EjGgVOPic6WLg0fXa7Zqc4YDqJwLrvLI7IOGh2AcQlMMtqDS6DX1b
   bUlSBwiNvwqYU8jTqGq8xH7X2LVNj353XV8LuoSIu1dl0Y8I08+7e4svC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2039365"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="2039365"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 19:04:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="808008177"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="808008177"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 19:04:16 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 19:04:16 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 19:04:16 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 19:04:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwRWo/ATBjRef3Ah6C57iVc0NLXRMxwehfQmgEJJcKDojJk9JoNoDrW3P6wvpOFrzNWZxTlDZW1eUtkWPYLlaGh5H21ulD0kIIIb/QOkVRKMak4Hj7UEP14yMl88HBi6ZEzL7UVUeFn8afx9IMWrWO/NxIN6uxdmBhaXY7Pb89mopVLP6YjK5mw941d9mdekIIeLWvBqf3AW+o7KvlhVCHdlTB7ZlnEsG0HF3WEgtQv6Cxy1V/EnghKlSRufCNhRZbEQrf5XeHEJAHdn3//L2hCr12no7/dZZieHRv4vO/O2FR8BrZerKaf7P4LrkV/UVJ56Xol7carV3aKI++8GHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj1/zrhcvYwWhkpCbszHZkXF4Yseau1dJ5t/Z+s2PiA=;
 b=QwaRHB3g8t38dOEXN1gAZR6lWltYABCsgpXf1vZ3x54+odZXs2gn0PDH0Ls1hm3j1gVD9xLAZJi4nAikKtA8SJ0kIkxL71el8EG87G5ecLq4/HHBPx0ZzD4cocURVpDmrHgqPU9aK5S9F97bbfh+I4uit6wVgGZ4+bVSWUTLElbd0EQNZ4cYMmGk+UAvwpZmxXbLVDNbKDq/KL5rQFUesz/M6BqsWVUnMpWnNXDiCrpS+73/6k1LljCacsXHbzre7MggeASY9DQzR0KRggkQ0wfJrlUNChZoECJdhuOV5/VCtwRflFcYjBc1vqh+MpO3EDA2fGu/PcRXaFzzNGEVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5278.namprd11.prod.outlook.com (2603:10b6:5:389::19)
 by CO1PR11MB4801.namprd11.prod.outlook.com (2603:10b6:303:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 03:04:13 +0000
Received: from DM4PR11MB5278.namprd11.prod.outlook.com
 ([fe80::38a4:25de:52c8:9e8b]) by DM4PR11MB5278.namprd11.prod.outlook.com
 ([fe80::38a4:25de:52c8:9e8b%7]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 03:04:12 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/6] iommu/vt-d: Remove 1:1 mappings from identity
 domain
Thread-Topic: [PATCH v2 4/6] iommu/vt-d: Remove 1:1 mappings from identity
 domain
Thread-Index: AQHaJxojfGMimdGl20KFwsu2wXzMo7CfGuwggAA/2YCABB9PUIABvnIAgAFOBFCAAAeTAIAAAxGA
Date:   Wed, 13 Dec 2023 03:04:12 +0000
Message-ID: <DM4PR11MB5278A37E1F30141D3DBF3FBF8C8DA@DM4PR11MB5278.namprd11.prod.outlook.com>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
 <20231205012203.244584-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52761FF9AB496B422596DDDF8C8AA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1161d8aa-9fcc-4e9e-a7d3-c461fee19a54@linux.intel.com>
 <BN9PR11MB5276AC40C423A0BAAE9F40A98C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <bef0f903-3665-492f-8999-fe759be5fed4@linux.intel.com>
 <BN9PR11MB5276614392E99F75B6A592C68C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d16460ff-f46f-4b20-8173-a81ac413b56d@linux.intel.com>
In-Reply-To: <d16460ff-f46f-4b20-8173-a81ac413b56d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5278:EE_|CO1PR11MB4801:EE_
x-ms-office365-filtering-correlation-id: 9e855a6f-84ff-4ab9-a0cd-08dbfb882f38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v+JQuknUYIBaz7Q39E0TOrUQgKAngrC/tU2t8PwNyFtOzKS92pCc0NbHuYKwkUFHGbA2rEtj6FfUVFYsq1nYSdoLoFm1YST+xWLtgghgxKW2NKF8tN+ts8Ca71w2LMnHT8BKYLq8Z7X5TRx8nL7Oc6Rlbn188HoYFuCgE6bRhBz50d73G8H/1QJ33+ZcBBO3fcPFivpIAi3YVFGuAH1fBTpF37/j7PSMQSZmzLcRIM25gL6QkSlVqHv0NiNOi4Fiqf8o2wphj69hibqMfGR6lPQ5QHut1xIA8b5/Lt91qAo2iMBnzlinpPOptpwh3e9tYsxYPQvHPl2GzhRlgR1NHFMkzvhv0KAIrk71Ey83nzWA3f6evIASux8uk59VMpA9517kh2KUjtD9hbYKFq9OdMpb45ZqRKmNLI1Ah2CTRTYhvTeJ8tzpzJKUW2aEErTb+WIUtV23C96qhsJfKRXdrYtRq8dRdlC1kGqewwJNdblTG9jtpj9nNnygyqBE+d0pI7T/ypmBlAjMODHRJkmggC5vJk/LWukwKtdA7iVYnAFstyGJHkJZCHylA6PIs1pYUxZmGrVksbsYXVSAC33t4yYqCeCf4wyNBr1/NpDoSfwTSV/+0AyV+8SgJGP+rqmD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(33656002)(38100700002)(5660300002)(122000001)(2906002)(41300700001)(86362001)(82960400001)(478600001)(38070700009)(64756008)(66446008)(316002)(54906003)(66476007)(66556008)(76116006)(66946007)(110136005)(26005)(55016003)(71200400001)(6506007)(7696005)(53546011)(9686003)(4326008)(8676002)(8936002)(52536014)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azB4QVR5bFhIWVh6WTJ2VFpROFFINEJ2MmR6RGg5ZWNyYnVhUVkrNVZXU2RM?=
 =?utf-8?B?Zmx3QzFaWkJLNGZkYWZvNXNYdnpzaC84ZWxTTWhDMVVIL0x6N3dTbkZueHo1?=
 =?utf-8?B?b0VJbnlZcmVnT3d3VUZ5UmhiSE1Udi9aWU43emt1cVBXQkpJZGwvM3FlMVF2?=
 =?utf-8?B?UlUweFBPUWlMODdzbTRKQXJUbktrMjVrdXF5bFJaVXdpOWZ5dlkwYzNtc3Uy?=
 =?utf-8?B?N0dmeXBSakp1V0hoSDV4KzVwOHhCVVJlMkVxay85anpkWSs2OFJQQ3hWOTBV?=
 =?utf-8?B?ZlZ3Y2tQQlFkNTk0K216SC92UXZpdGt3T21OS1A4Q0lHMGpyamVocUdRRmJS?=
 =?utf-8?B?M0NXenErODBxSGZ4S2I2VVNpWXhSSW5mN0dtbkprMW9MNGtSdjFOUHZrcHBK?=
 =?utf-8?B?MkdieHY3QzJobTVpakxQSWpoL1kyZGtKOWI0TE9lYk1EaWNLZzk0VGRIVUlq?=
 =?utf-8?B?LzRQZm9SVFBRWjFpV3VxVkRmOEhGMU05V01vR1F3dlRNWXBkWmN6T0k5Y2cv?=
 =?utf-8?B?K2I1NUJiY3V4d1FyRWVkbllsb2NqNGpCNytnVjJwZkhUTlU5eWxrQ2VCL0F0?=
 =?utf-8?B?WVBrNDArNFZacGFBWGVSQys1eldIYjZNc2dTYWp2eXdhRm96ZUVMNnpvd0FY?=
 =?utf-8?B?dDlhRUlyZDlHR2MrSXJOZll4a2RzTVdhZk9wODdQUE5BdjlmVEpOdW9mQmpQ?=
 =?utf-8?B?dDZ5elFDRFNRRjJ1ODRZQzhhV2hRUzdCczVvWEdoWmIvUXBIdFUvc3JueVpN?=
 =?utf-8?B?TGsyaXVTQ05nMUtCaGROWnFuWnlZbnBFNGhjNmRNOU9ZMXI1Yzl1WjZ2bTND?=
 =?utf-8?B?Zm53MmVBQ3d2WUt5MGQvTU9Ga0RNcHZ2bFg5OVVRQVg4c3FXOFN3RFYyTTR6?=
 =?utf-8?B?bDdiTEVHTFJITVZqdzNESHkvMnVsTmhZYTdnTWR1RXdncHRPNjROSUxPKzJ0?=
 =?utf-8?B?Z001WjBzSzk4d3N5Y0piZ09IOXJRR1VOQ0NHYUxocXZXQ3lZdVJLODA0Y3B0?=
 =?utf-8?B?VWZtZnZ6REtkMzZxL2UvTmNyK01uakRVVzd0SWVobkJWOSsycGRlWkh0ZHA4?=
 =?utf-8?B?SGlpakJTandGSng2VWZ4aGVzendSVVJaWFk3K1pka0ZpWTlnRk5WczVNNVlp?=
 =?utf-8?B?R1RiaWNrY0NsOWdQS0t2N0xiVWQ0dGRMcmloYkJBWGVZeTFkbE9jRG04VU5G?=
 =?utf-8?B?Y2grdG1mTFRMcFZMWUQ2TWZiRms3OUM2bjAzNHpETnd0NlA5c1B2MmF0UWcr?=
 =?utf-8?B?eGJQeWFvZW4zOGsyaWJvcU9wQjYzbmpGZjlMZFJwVGdWVS9YdXc1WWpQQVAv?=
 =?utf-8?B?M09QeW1aNkF3S0Q1MWpQcHJUVUpJT3ZKc1dhL0padmIvVjN1azlBeFhabWdC?=
 =?utf-8?B?R3RNTGFOUW1DQ0h4aFhoQVlSdGNWUi8yZWppZnFJZkpFcGpTaGZCRGkzdDVs?=
 =?utf-8?B?eGdFOFV5M3dpUmhpNFF3dVJUcmpJNEFiMDZmYlJ3V3g1K1RQVi9TQ0pUbUN6?=
 =?utf-8?B?U0tZUFljVHQ1OHB4NHRNaWpkeXc3dGhlWTViN2poZnZEUVFnYzNEWlFmNkdJ?=
 =?utf-8?B?cURiMUg1SkM0dGtJTVY2T3RaS0xnK2pTdEM2OFptUE1JK3NqK04wZk1FS0Va?=
 =?utf-8?B?NFZtenlsQkJEUURoQzRlcFY4Z2lZRFkrbk5BMVRKSEIwNXBHMjRiaHFZUmpL?=
 =?utf-8?B?SmRWdDhsNmtGVFlkKzhOKzZGeGdvQXdpZzExTGlTM3F4Z2MrOHdSZGJOUjMv?=
 =?utf-8?B?VzV4V3dxenBnMHVTQVNiclZEZjVvRk9EL0NmRUJKS2NTR2tMRGxXbWdmMGpH?=
 =?utf-8?B?emh4SitxbjFML0U5TDcrbGROYy9uNTdYVWJvaUVWRm9CRWVacEZWNm9IRzZG?=
 =?utf-8?B?dk8rdWprcUFyb1pJYjFKdXBjT0F4UXJvbUhYWDlOcndJamozTGtKUEpJV2o0?=
 =?utf-8?B?YlRHY2l2UER6a2xaMjhBUEVHMURMamdHZ2Y4TnpuQ2toNEI2dENCMDZ3SnNH?=
 =?utf-8?B?Y1YxVzRpUTA5N0E2QmVDbWxWeGdBMmxhWXJ1cC9DSGE1bGNHeXZDNk9uaW51?=
 =?utf-8?B?MjFLQmpYd2FFdlYycXJUc0JMdUFJVFB3aDh2NUg4R0x0MXhoZGdEdnJ3aXVu?=
 =?utf-8?Q?1ON4cwCB8dk+LDosKbQRWDA85?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e855a6f-84ff-4ab9-a0cd-08dbfb882f38
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 03:04:12.9071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: INaEJAoPMHP4N/8q3t3hutNPfrjHx2m/ve+IveEJ8B6iJrsDR/0VijhavXfodGl5hlJbpLfrNVg4W2tD7Fwbnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4801
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIERlY2VtYmVyIDEzLCAyMDIzIDEwOjQ0IEFNDQo+IA0KPiBPbiAxMi8xMy8yMyAxMDoy
MCBBTSwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+PiAJaWYgKCFkbWFyX21hcF9nZngpDQo+ID4+
PiAJCWlvbW11X2lkZW50aXR5X21hcHBpbmcgfD0gSURFTlRNQVBfR0ZYOw0KPiA+PiBTbyB3aXRo
IGFib3ZlIGNsZWFuZWQgdXAsIHdlIGhhdmUgbm8gbmVlZCB0byB3b3JyeSBhYm91dCBkcml2ZXJz
IHRoYXQNCj4gPj4gYXJlIG5vdCBjYXBhYmxlIG9mIGhhbmRsaW5nIHJlbWFwcGVkIGRtYSBhZGRy
ZXNzIGFueSBtb3JlLg0KPiA+Pg0KPiA+PiBEaWQgSSBtaXNzIGFueXRoaW5nPw0KPiA+IEkgcHJl
ZmVyIHRvIHJlbW92aW5nIElERU5UTUFQX0dGWCBpbiB0aGlzIHNlcmllcyBhbmQgcHV0IGEgY29t
bWVudA0KPiA+IGV4cGxhaW5pbmcgd2h5IEF6YWxpYSBkZXZpY2UgaGFzIG5vIHByb2JsZW0uDQo+
ID4NCj4gPiBUaGVuIHNlbmQgYSBzZXBhcmF0ZSBwYXRjaCB0byByZW1vdmUgdGhlIEdGWCB3b3Jr
YXJvdW5kIG9wdGlvbi4NCj4gPiBJZiB0aGVyZSBpcyBhbnkgdmFsaWQgdXNhZ2Ugc3RpbGwgcmVs
eWluZyBvbiB0aGF0LCBpdCdzIGVhc3kgdG8gcmV2ZXJ0Lg0KPiANCj4gQWdyZWVkLiBXZSBzaG91
bGQgYmUgbW9yZSBjYXV0aW91cy4gUGVyaGFwcyBJIHdpbGwgcG9zdHBvbmUgdGhpcyBzZXJpZXMN
Cj4gdG8gYSB0aW1lIHdoZW4gd2UgYXJlIHN1cmUgdGhhdCBncmFwaGljIGRyaXZlcnMgYXJlIG9r
YXkgd2l0aCB0aGlzDQo+IGNoYW5nZS4gQXMgYSBmaXJzdCBzdGVwLCBwZXJoYXBzIHdlIGNhbiBt
YWtlIGEgY2hhbmdlIHRvIHJlbW92ZSB0aGUNCj4gd29ya2Fyb3VuZCBmb3IgZ3JhcGhpYyBkcml2
ZXJzLCBzbyB0aGF0IGFueSBoaWRkZW4gYnVncyBpbiB0aGUgZ3JhcGhpYw0KPiBkcml2ZXIgY291
bGQgYmUgcmVwb3J0ZWQuDQo+IA0KPiBUaGUgcGF0Y2ggbG9va3MgbGlrZSwNCj4gDQo+IGlvbW11
L3Z0LWQ6IFJlbW92ZSBJTlRFTF9JT01NVV9CUk9LRU5fR0ZYX1dBDQo+IA0KPiBDb21taXQgNjJl
ZGY1ZGM0YTUyNCAoImludGVsLWlvbW11OiBSZXN0b3JlIERNQVJfQlJPS0VOX0dGWF9XQQ0KPiBv
cHRpb24gZm9yDQo+IGJyb2tlbiBncmFwaGljcyBkcml2ZXJzIikgd2FzIGludHJvZHVjZWQgMjQg
eWVhcnMgYWdvIGFzIGEgdGVtcG9yYXJ5DQo+IHdvcmthcm91bmQgZm9yIGdyYXBoaWNzIGRyaXZl
cnMgdGhhdCB1c2VkIHBoeXNpY2FsIGFkZHJlc3NlcyBmb3IgRE1BIGFuZA0KPiBhdm9pZGVkIERN
QSBBUElzLiBUaGlzIHdvcmthcm91bmQgd2FzIGRpc2FibGVkIGJ5IGRlZmF1bHQuDQo+IA0KPiBB
cyAyNCB5ZWFycyBoYXZlIHBhc3NlZCwgaXQgaXMgZXhwZWN0ZWQgdGhhdCBncmFwaGljcyBkcml2
ZXIgZGV2ZWxvcGVycw0KPiBoYXZlIG1pZ3JhdGVkIHRoZWlyIGRyaXZlcnMgdG8gdXNlIGtlcm5l
bCBETUEgQVBJcy4gVGhlcmVmb3JlLCB0aGlzDQo+IHdvcmthcm91bmQgaXMgbm8gbG9uZ2VyIHJl
cXVpcmVkIGFuZCBjb3VsZCBiZWVuIHJlbW92ZWQuDQoNCmFuZCBpZ2Z4X29mZiBvcHRpb24gaXMg
c3RpbGwgYXZhaWxhYmxlIGp1c3QgaW4gY2FzZS4NCg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBLZXZp
biBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTHUgQmFvbHUg
PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9pb21tdS9pbnRl
bC9pb21tdS5jIHwgMTAgLS0tLS0tLS0tLQ0KPiAgIGRyaXZlcnMvaW9tbXUvaW50ZWwvS2NvbmZp
ZyB8IDExIC0tLS0tLS0tLS0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyMSBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgYi9kcml2ZXJz
L2lvbW11L2ludGVsL2lvbW11LmMNCj4gaW5kZXggODRiNzhlNDJhNDcwLi4yN2I4NjM4MjkxZjIg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiArKysgYi9kcml2
ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gQEAgLTIzNTcsOSArMjM1Nyw2IEBAIHN0YXRpYyBp
bnQgZGV2aWNlX2RlZl9kb21haW5fdHlwZShzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYpDQo+IA0KPiAg
IAkJaWYgKChpb21tdV9pZGVudGl0eV9tYXBwaW5nICYgSURFTlRNQVBfQVpBTElBKSAmJg0KPiBJ
U19BWkFMSUEocGRldikpDQo+ICAgCQkJcmV0dXJuIElPTU1VX0RPTUFJTl9JREVOVElUWTsNCj4g
LQ0KPiAtCQlpZiAoKGlvbW11X2lkZW50aXR5X21hcHBpbmcgJiBJREVOVE1BUF9HRlgpICYmDQo+
IElTX0dGWF9ERVZJQ0UocGRldikpDQo+IC0JCQlyZXR1cm4gSU9NTVVfRE9NQUlOX0lERU5USVRZ
Ow0KPiAgIAl9DQo+IA0KPiAgIAlyZXR1cm4gMDsNCj4gQEAgLTI2NjAsMTMgKzI2NTcsNiBAQCBz
dGF0aWMgaW50IF9faW5pdCBpbml0X2RtYXJzKHZvaWQpDQo+ICAgCQlpb21tdV9zZXRfcm9vdF9l
bnRyeShpb21tdSk7DQo+ICAgCX0NCj4gDQo+IC0jaWZkZWYgQ09ORklHX0lOVEVMX0lPTU1VX0JS
T0tFTl9HRlhfV0ENCj4gLQlkbWFyX21hcF9nZnggPSAwOw0KPiAtI2VuZGlmDQo+IC0NCj4gLQlp
ZiAoIWRtYXJfbWFwX2dmeCkNCj4gLQkJaW9tbXVfaWRlbnRpdHlfbWFwcGluZyB8PSBJREVOVE1B
UF9HRlg7DQo+IC0NCg0KbGV0J3MgcmVtb3ZlIElERU5UTUFQX0dGWCAoYW5kIGFsbCBpdHMgcmVm
ZXJlbmNlcykgaW4gYSBzZXBhcmF0ZSBwYXRjaC4NCg0KdGhpcyBwYXRjaCBpcyBmb3IgcmVtb3Zp
bmcgdGhlIHdvcmthcm91bmQgb3B0aW9uLg0KDQphbm90aGVyIHBhdGNoIHJlbW92ZXMgSURFTlRN
QVBfR0ZYIGFzIGl0J3MgbWVhbmluZ2xlc3Mgd2hlbg0KZG1hcl9tYXBfZ2Z4IHNpbXBseSBpbXBs
aWVzIGRpc2FibGluZyB0aGUgZ2Z4IGlvbW11Lg0KDQo+ICAgCWNoZWNrX3R5bGVyc2J1cmdfaXNv
Y2goKTsNCj4gDQo+ICAgCXJldCA9IHNpX2RvbWFpbl9pbml0KGh3X3Bhc3NfdGhyb3VnaCk7DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL0tjb25maWcgYi9kcml2ZXJzL2lvbW11
L2ludGVsL0tjb25maWcNCj4gaW5kZXggMDEyY2QyNTQxYTY4Li5kMmQzNGViMjhkOTQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL2lv
bW11L2ludGVsL0tjb25maWcNCj4gQEAgLTY0LDE3ICs2NCw2IEBAIGNvbmZpZyBJTlRFTF9JT01N
VV9ERUZBVUxUX09ODQo+ICAgCSAgb25lIGlzIGZvdW5kLiBJZiB0aGlzIG9wdGlvbiBpcyBub3Qg
c2VsZWN0ZWQsIERNQVIgc3VwcG9ydCBjYW4NCj4gICAJICBiZSBlbmFibGVkIGJ5IHBhc3Npbmcg
aW50ZWxfaW9tbXU9b24gdG8gdGhlIGtlcm5lbC4NCj4gDQo+IC1jb25maWcgSU5URUxfSU9NTVVf
QlJPS0VOX0dGWF9XQQ0KPiAtCWJvb2wgIldvcmthcm91bmQgYnJva2VuIGdyYXBoaWNzIGRyaXZl
cnMgKGdvaW5nIGF3YXkgc29vbikiDQo+IC0JZGVwZW5kcyBvbiBCUk9LRU4gJiYgWDg2DQo+IC0J
aGVscA0KPiAtCSAgQ3VycmVudCBHcmFwaGljcyBkcml2ZXJzIHRlbmQgdG8gdXNlIHBoeXNpY2Fs
IGFkZHJlc3MNCj4gLQkgIGZvciBETUEgYW5kIGF2b2lkIHVzaW5nIERNQSBBUElzLiBTZXR0aW5n
IHRoaXMgY29uZmlnDQo+IC0JICBvcHRpb24gcGVybWl0cyB0aGUgSU9NTVUgZHJpdmVyIHRvIHNl
dCBhIHVuaXR5IG1hcCBmb3INCj4gLQkgIGFsbCB0aGUgT1MtdmlzaWJsZSBtZW1vcnkuIEhlbmNl
IHRoZSBkcml2ZXIgY2FuIGNvbnRpbnVlDQo+IC0JICB0byB1c2UgcGh5c2ljYWwgYWRkcmVzc2Vz
IGZvciBETUEsIGF0IGxlYXN0IHVudGlsIHRoaXMNCj4gLQkgIG9wdGlvbiBpcyByZW1vdmVkIGlu
IHRoZSAyLjYuMzIga2VybmVsLg0KPiAtDQo+ICAgY29uZmlnIElOVEVMX0lPTU1VX0ZMT1BQWV9X
QQ0KPiAgIAlkZWZfYm9vbCB5DQo+ICAgCWRlcGVuZHMgb24gWDg2DQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IGJhb2x1DQo=
