Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C9D80680A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377010AbjLFHOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376923AbjLFHOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:14:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E1C135
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701846862; x=1733382862;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BCYXEMVn+UzF/4G9eGh9kp4wVDEQtHpT2EmqeL+G+/0=;
  b=jxixpAaUnL7aVMaAoXJ48JitiG4YZOXFCB6k/gdXq9dmQfaCOnWAMl/t
   PDYQaDde/Y8T4dMgMPphkHXmxOpaIZa3Jw5AhkIR3OvCx25SL1iuferJ3
   24c7eYhrgXmValQFgwWpfZffAUuzQqnyw2fYvGCDwI8glB3oemj/G0lKv
   L5b2nMJNwxCkE5x1436tDtY5j/s+kWQLQqDtAuCZMveGc3HmLtd91wvXM
   a9qGeibHONxtEN5WRzdno/imKqib5uJyOQaysLpbVWGdVUj+/yCpcwjlq
   vnKIGyew/5H/UiUDcFQaTOALWocWkRncKeTbO4QY4gofPZRWCo2yjlpFN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="393748007"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="393748007"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 23:14:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1018474056"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="1018474056"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 23:14:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 23:14:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 23:14:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 23:14:21 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Dec 2023 23:14:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvjxPgZ8GSrGzcLa9MBtoA4yA9Ph59c23uvo0G7QpgRaQ9xKnvtrv6vRJEgF3QPrDscCkzM8PhrCRRQcXay3EsoORyuhuA6Bi5a3s6K6LOK5XO7yC0Q4JhBvtxTrWtAxY4MNv1g5oLz/AomJzcip9THJ7yzaAqrbRlBVWq3ZCxPf/7YcWjmB9RH18jbz0JRYoaMhPdj0zfrrSniFaIhhvATkvMQJtle5RdPSsu1jKwJZ7UU11MpEW1nSYS7n0G69S3kjG8exb6sRh5RrQi7IoKdT8tAXl3JvFMGyhc49LUzv4LxJX1JdQJNjnyIXaFvfHR7CHVhwpCo4qyuxfET32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCYXEMVn+UzF/4G9eGh9kp4wVDEQtHpT2EmqeL+G+/0=;
 b=i5FvYfWF8uAQLpyE0BF3h6O0HV/rPxy5Q12ke8MgfWmXRGiVBAiq3cZpm8bgRFI0nEE5S6sxCSGEzbFl7g9pIRUYQCdWKs6EBuYm/9OqZ7e8qwFNDIMVcR7V7Tjn4CUyewAgB1uzu7FowpnVo4rAic/ER1AoeH/0+jozhE45tHibChpJyzbI2rkyBXAdJYO6V2bf33+ELsdxCyTRUMMwpmzSbqy99ppZ0+hLbWqhnEQ+5JLUONk7taSkcf7jbL6tuCKUC1LOX8h4FjOuvbY2ce2MfCKdanTV+ds9yyXpzru79H+qzVLGRzTKDPkRwk7AkSqHGXGyNHWcfO6biycalA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by IA1PR11MB7824.namprd11.prod.outlook.com (2603:10b6:208:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 07:14:14 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::2738:cbf0:1b80:8a78]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::2738:cbf0:1b80:8a78%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 07:14:13 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     "Yao, Hao" <hao.yao@intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] misc: mei: Add support for IVSC device
Thread-Topic: [PATCH v2 0/2] misc: mei: Add support for IVSC device
Thread-Index: AQHaJkytPIqTRLyU6k+ygbiuCvp5ubCbxbwAgAAUksA=
Date:   Wed, 6 Dec 2023 07:14:12 +0000
Message-ID: <DM6PR11MB43169EAC844BB2045F43A7E58D84A@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <1701651344-20723-1-git-send-email-wentong.wu@intel.com>
 <fdc7e70b-67a6-4e5d-a622-450cf4270690@intel.com>
In-Reply-To: <fdc7e70b-67a6-4e5d-a622-450cf4270690@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|IA1PR11MB7824:EE_
x-ms-office365-filtering-correlation-id: e373e982-eb01-4053-a563-08dbf62af2c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /WQoMF9N1+YnLXtPFjOj6nsX8T08NZTl7LLqsjgTsbLs+7Ls6bhj/YIFdRSb89v4LCcMtukpFuAzkhPJ+8ZzIfP3ENk5b0ViWG668moxDooyltDSgrY8dXSQRaEyVjqjv8tSMb8InkgL6z7jGJ1K4wXA36x6rCvpuW+DzNRPEq0JTaTdtI4jEmJI0CPi8pzGX1B2mima6lpaQa6ffPxybOYfdx9YFDVh8vFVOqMlxlzUF/75RdPaUHOOHA/TapwmjLRCYE4wwmsInlCucCXvDNQVdk57+o4JIKx/t0cvRaK11r2gC2wNVFLBHUMjxtKvbAUZ/PkSV2DO5oHDmygMi49RqoqhmGl1820YDwhb9Q4fDyLtArwQD7R14JsDIWrH+/gheZE2k/f9NBni88sdwWmjOKAn9PAR3YAludyHcC+HcA9zK3cJWxKvXOUxdlKzqwb8tic+BeTi2vKp3hxtBbTJ35s8+ejVvWK7EjX9ZbfQLY3QXoVJ9+K3M71QBeWQVHPUnphV5TkdNHF0mntZTE0m3o5IHiXjKm0HrN9MPVNmPGxE1Czjvf0usI+2EFZTfzq1ZgzR7F6wMM8ov5ukMvDpAuahUtI5/veNOdtfmvd+d1UZT817posGn+bRI4qB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(71200400001)(53546011)(26005)(478600001)(5660300002)(6506007)(7696005)(66556008)(54906003)(66476007)(316002)(76116006)(6636002)(55016003)(9686003)(66946007)(66446008)(64756008)(83380400001)(8936002)(6862004)(52536014)(41300700001)(38070700009)(2906002)(38100700002)(86362001)(33656002)(122000001)(4326008)(8676002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0IxTWFYV2ltVFVOOE1MVzJoLzJ0eFBlMWVmOFJwNXE4amxTWERDU3VOMjRW?=
 =?utf-8?B?U0gwWVFRVkdWS0F4SVFCZFJsOXh4UVc5cURheno1UTFKS3dTdkNVS2pzUS9j?=
 =?utf-8?B?RlVZbHBjUENoUk1POFNuMVRCZ3BqUjVkeW9LWXFCWHpQdWp3RVFJZnpoQTVW?=
 =?utf-8?B?ODk1WHhzUlpzNmUxM2dQWVEzbzZyWGdac1VqVS9hNERmWkFkNElMQ0FmYWpH?=
 =?utf-8?B?ckN0UzZYSmc1L2Q4QmZtSVVMdmZGd05JSUNTQmRRcDZ6cmdZUEg0U2hHNU1p?=
 =?utf-8?B?STVWemNFZVRmS1E2Y1EwQkV0ekwwa3RBVnp1MFdwV2k1LzFQRGw3dklDNGtt?=
 =?utf-8?B?R2t5dWlTQ2ZyTnBSVDUwQ2RwUmlFemxOdWNiS0Y5QklRTEFLeEc3WExsaHdH?=
 =?utf-8?B?dXVKSGU5K1IyMTJLUTI3RHI2dC9aQ0JJN2NvaGo1MmpDVGJTbXNQQWpoVzlJ?=
 =?utf-8?B?STFEcms4OEg0YXlrUENnWUtLQzIzM1VtS2xmR2F0OUlMak9NQzk1MGVpQXVD?=
 =?utf-8?B?QVNrdFA3b1Fhek10ZnNBVG5DOWdINDNyMGlOUHB6YXBTc29TWGJjVmNERG5k?=
 =?utf-8?B?NWQwT2svWnJqenRReFRNdXdlSnhSVS9qbDFrbHNvR0JwR3RiWTFKalo1eWRK?=
 =?utf-8?B?RGduY1lUWHZLMmtMMktXRjhWOE9BK1A5T2l3VHlUZGlBcElMSWQ5QXM4dXN2?=
 =?utf-8?B?NnFneCtvTmxxL3pDN3QxSkZGTlBROHk2dlZ0TGxSbEloMnFQM2ZKLzhodGll?=
 =?utf-8?B?VXFXZ1JSQml0OTBUMWRYYzltTEpZTlBvbkE0WUpKa2llaENkNTlLMXhXaFQ2?=
 =?utf-8?B?SSttakRyS3RHQitoRmJIQUcxU05KQUR4MHVvZU1aUXdoK2xmY05obSt2Zkd0?=
 =?utf-8?B?L3oxR2lVU2trdXJzVU1wVW5YK2Q3a1dpaFpkOThMY3d4aHE5MDFRRzd6VWFq?=
 =?utf-8?B?dDBsMlVmSHJKRS9icHFkd2Q0V3VZOUlEZmU1YXhTNWxZNTNmeU5ZaVpkdkRY?=
 =?utf-8?B?NUVybDk2T1gyNlFreGRNWTc2VmJCZVdCbjN2dzRaQTJvb2loTFhPeERkaEtC?=
 =?utf-8?B?N2hhTm5LWVJjS3JqYmsxRUlpNERHUHFDblpONEZGbFZUeTJiVW9MWG5nZDBS?=
 =?utf-8?B?KzBzNENsZWE1L3puUXUreUdRZzE3YUVwY3RQRU4xRkc1cHJtQWpOWU9nTGZD?=
 =?utf-8?B?RUVZdGx6VTRhTzlReWV1ZXhOZHA3QWRiZ1pCRFZnTWFJQW83Z3V2QmNpcEJh?=
 =?utf-8?B?M205b241VmJqRHAwSHpjd3RqNnZEMzVLNE9rczdLSjE0MWxOZXQvdnhOeTYy?=
 =?utf-8?B?THJxcjJUODBSandWVnZQRTh5aVRvdDg3dzdLYis4Rm0rcUx3a0hZNXF4NExy?=
 =?utf-8?B?YjJ4d2pIK2ZvQlZrRlZpOHlMQjhuRWRMaU5zN1B3VlVXWC9MdzlRdW84MHhy?=
 =?utf-8?B?eEgvMC8rK2ZKUi9mVHREYzZjMlN2dXJkRi9CQ2JCcTZ5WmMvNmt2ZGw5Zy95?=
 =?utf-8?B?SklnUTFLTVd4OUpWaHZxM3Q1cWw2TEQ3RlNEK01rVTVPbStOZ1lpcXF2YmtY?=
 =?utf-8?B?aGMxMXFlNkdQZGM4Y1VpT0NlZ1ZSR3NlK2RoYUU1OThzVVM3b0h4ckFDcVlN?=
 =?utf-8?B?TTlsbGVsVEErKzlCcG9DZXoxNlh5UEVvWW54bTFxeDAyUUp3Qm5sdDZIZDIz?=
 =?utf-8?B?OU5YWmtLWTJhUlN5TTRXSTVBVU5UOU1iT0xGSGJUS1VRbWpyOEw0czFuUnBi?=
 =?utf-8?B?bWJYSks2ZU42TTJpbEF6RHl4UUlGbEdHcG1rNnVKMDhuQnQ1UzVSeDBuZXBv?=
 =?utf-8?B?UlhCRGd5a2hiUEV6L0xIanNVZUNleFBrUVBWL29aM2o0VWpTMkt4R0RjRyt3?=
 =?utf-8?B?RTB0THBET3Q0NFNNUExVVmZNM0JOaE5ZWVNoVkZqaU5wRTFvWXZhZEJaS0dB?=
 =?utf-8?B?OGt5N0JhakJIdUZhdmhtSWllR0R4K2RtTWZwQXE0RjhSd0ZhT2NTR0d6SFFw?=
 =?utf-8?B?TEpQbHFrK05BZlo0OG9VdE1Kbno0V0E4S0FkaW1ob0wvKzNZV1VPdzV5VFhR?=
 =?utf-8?B?UExwU3BkSVg4WkYxZzR3a04yd0pSUXA2MlVVZ2lrMGY1REtVU0FGcHkwYnpn?=
 =?utf-8?Q?/P4v/gXJT+m7cmBKgtgTWao/E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e373e982-eb01-4053-a563-08dbf62af2c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 07:14:12.4416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R51I671iytSk8HsPpjFsPNNr9I9CBU2stedRGKwDxa8YWNwMfBdIc7ybhk6vhujkNLEx+z8Hij78zOI6wDZJJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7824
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

PiBGcm9tOiBZYW8sIEhhbyA8aGFvLnlhb0BpbnRlbC5jb20+DQo+IA0KPiBXZW50b25nLA0KPiAN
Cj4gT24gbWFpbmxpbmUgdjYuNiwgSSBjaGVycnktcGlja2VkIElWU0MvTENKQSByZWxhdGVkIHBh
dGNoZXMgYW5kIHRoZXNlIHYyDQo+IHBhdGNoZXMsIGFkZGVkIEludGVsIElQVTYgZHJpdmVyIG9u
IEdpdGh1YiwgdGhlbiBtYWRlIHNvbWUgY2hhbmdlcyBvbg0KPiBJUFU2IEhBTCB0byBhdXRvIGxp
bmsgSVZTQyBkZXZpY2UuIEkgdGVzdGVkIHRoZSBidWlsZCBvbiBhIERlbGwgTGF0aXR1ZGUNCj4g
NzQ0MCB3aGljaCBpcyB1c2luZyBISTU1NiBjYW1lcmEgc2Vuc29yIGFuZCBpdCBwcmV2aWV3cyBu
b3JtYWxseS4NCj4gDQo+IElmIGl0J3MgcHJvcGVybHksIHlvdSBjYW4gYWRkIG15ICJUZXN0ZWQt
Ynk6IiB0YWcuDQo+IA0KPiBUZXN0ZWQtYnk6IEhhbyBZYW8gPGhhby55YW9AaW50ZWwuY29tPg0K
DQpUaGFua3MsIHJlYWxseSBhcHByZWNpYXRlIHlvdXIgZWZmb3J0DQoNCkJSLA0KV2VudG9uZw0K
PiANCj4gT24gMjAyMy8xMi80IDA4OjU1LCBXZW50b25nIFd1IHdyb3RlOg0KPiA+IFRoZSBJbnRl
bCB2aXN1YWwgc2Vuc2luZyBjb250cm9sbGVyIChJVlNDKSBkZXZpY2UgaXMgZGVzaWduZWQgdG8N
Cj4gPiBjb250cm9sIHRoZSBjYW1lcmEgc2hhcmluZyBiZXR3ZWVuIGhvc3QgSVBVIGZvciBtZWRp
YSB1c2FnZSBhbmQgSVZTQw0KPiA+IGZvciBjb250ZXh0IHNlbnNpbmcgKGZhY2UgZGV0ZWN0aW9u
KS4NCj4gPg0KPiA+IElWU0MgaXMgZXhwb3NlZCB0byBob3N0IGFzIGEgU1BJIGRldmljZSBhbmQg
dGhlIHByb3RvY29sIHVzZWQgZm9yDQo+ID4gY29tbXVuaWNhdGluZyB3aXRoIGhvc3QgaXMgTUVJ
LiBUaGlzIGRyaXZlciBpbXBsZW1lbnRzIHRoZSB0cmFuc3BvcnQNCj4gPiBwcm90b2NvbCBhbmQg
TUVJIGhhcmR3YXJlIGludGVyZmFjZXMgZm9yIElWU0MgZGV2aWNlLg0KPiA+DQo+ID4gVGhlIGZp
cm13YXJlIGRvd25sb2FkaW5nIGZvciBJVlNDIGRldmljZSBpcyBpbXBsZW1lbnRlZCBhcyB3ZWxs
Lg0KPiA+DQo+ID4gLS0tDQo+ID4gdjI6DQo+ID4gICAgLSBjaGFuZ2UgdG8gYGRlcGVuZHMgb24g
SU5URUxfTUVJX1ZTQ19IV2AgZm9yIElOVEVMX01FSV9WU0MgS2NvbmZpZw0KPiA+ICAgIC0gcmVt
b3ZlIE1PRFVMRV9BTElBUyBhbmQgYWRkIE1PRFVMRV9ERVZJQ0VfVEFCTEUgaW4gcGxhdGZvcm0t
DQo+IHZzYy5jDQo+ID4NCj4gPiBXZW50b25nIFd1ICgyKToNCj4gPiAgICBtZWk6IEFkZCB0cmFu
c3BvcnQgZHJpdmVyIGZvciBJVlNDIGRldmljZQ0KPiA+ICAgIG1laTogQWRkIE1FSSBoYXJkd2Fy
ZSBzdXBwb3J0IGZvciBJVlNDIGRldmljZQ0KPiA+DQo+ID4gICBkcml2ZXJzL21pc2MvbWVpL0tj
b25maWcgICAgICAgICB8ICAyNCArKw0KPiA+ICAgZHJpdmVycy9taXNjL21laS9NYWtlZmlsZSAg
ICAgICAgfCAgIDcgKw0KPiA+ICAgZHJpdmVycy9taXNjL21laS9wbGF0Zm9ybS12c2MuYyAgfCA0
NTAgKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBkcml2ZXJzL21pc2MvbWVpL3ZzYy1mdy1s
b2FkZXIuYyB8IDgyMg0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiAgIGRyaXZlcnMvbWlzYy9tZWkvdnNjLXRwLmMgICAgICAgIHwgNTU1ICsrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gICBkcml2ZXJzL21pc2MvbWVpL3ZzYy10cC5oICAgICAgICB8
ICA1MCArKysNCj4gPiAgIDYgZmlsZXMgY2hhbmdlZCwgMTkwOCBpbnNlcnRpb25zKCspDQo+ID4g
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9taXNjL21laS9wbGF0Zm9ybS12c2MuYw0KPiA+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWlzYy9tZWkvdnNjLWZ3LWxvYWRlci5jDQo+
ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9taXNjL21laS92c2MtdHAuYw0KPiA+ICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWlzYy9tZWkvdnNjLXRwLmgNCg==
