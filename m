Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B887AE388
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 04:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjIZCAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 22:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIZCAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 22:00:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232A5D8;
        Mon, 25 Sep 2023 19:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695693631; x=1727229631;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bRiIY5mP0/gRgAX137I/RM5VkyLNIe3uaE0HF4zoDDM=;
  b=UNw/ACF34d0c1ao8Ffq7NH0KtfZ3ZBRv6aXXbcww8JhAYBC7m0o3YAl7
   F9UXiO1dBt1BX7FcUZQPGk6JEMZtfUEwoeADbHb1UecbLMNgEGFPf280p
   R/I5X9+j4QLdgu4jNlay7vw5D77aQ+blJdFtiqrGEzgIWG9VBUBk82wW6
   B2g3LkerxW6XfdAlUM1cnRKRWuU5puqcr4DnfVxCKPCEIxuhWRTlNveCJ
   6jXbDVvHNiNMHW6LVefAH3qXzjaMPwTbaaMirbQi+gxkW6aNAFOnP0Y34
   an70K6eDWm5io/XvgRrUY8CQ1DLt6fAk5rLCB81o2fPYeJv6TMS7gyzTq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412377770"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="412377770"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 19:00:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818862054"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="818862054"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 19:00:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 19:00:28 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 19:00:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 19:00:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 19:00:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUyWD7uSwNsDQbYQ1gdcF0cqqANuMrEoXWqY8zdUC2BXfSySFqBPimKv8zVViPk65gz/URjrMxndxhmjbmnKd8CS919Z5tKTVscfBL0ofoqy/EJbR5B9RnkR41MnjSDCdk+/95t2pWQR5uSlVzd3OteCB8OY9z2akr/FMHh+Yn5Z5SlLctNnOBGTwSZt6zDY8mUy0qbiM1Ru//KTTKbo1s9hOVvnWBAaNB8q9xoa2cx027AzTXB7DaXu+1aVNM1CMtiWmGYASGabT3aC5bNR5rDAhlrzW80LxSj/FHSNlHNrj8ejLNTNkhx28G/IsNreKqjhf81iG4glfgCOchu34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRiIY5mP0/gRgAX137I/RM5VkyLNIe3uaE0HF4zoDDM=;
 b=nxGJdDUvttuuNOyXpHgPGy/k2Vq8SF41a28mI9v43YHzGTk598FMKWAjYggvxaJoQHDOLwzXeYVfYhDig7cMzdcr5yg+4SwUR3V5R7QoxsFRG7Cc9gWU5s0suFkgYHgjTqBkUNahCLWsYF52n5y2vkADx63m5sPt9wRrm2Rj9DGH8cWCCufBxH4M+Q69uIgSfDxzA1gJ9vfIsWCq53BzOu7nXPM06rNK/f5oln0/wKv+Uc1zLVyRHO57NMFgcghh1EIOP8ETm3bctOUHxvzMWiBt5VEhqc2PctNmTOSb7dgmYNpxaIYP7LeeHVw3D4ojHbNtQH15RrMhrtHW02uY9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB0037.namprd11.prod.outlook.com (2603:10b6:910:77::29)
 by DS0PR11MB8739.namprd11.prod.outlook.com (2603:10b6:8:1bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 02:00:25 +0000
Received: from CY4PR11MB0037.namprd11.prod.outlook.com
 ([fe80::7de:e06d:bb71:4345]) by CY4PR11MB0037.namprd11.prod.outlook.com
 ([fe80::7de:e06d:bb71:4345%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 02:00:25 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v4 5/5] usb: typec: intel_pmc_mux: Configure Displayport
 Alternate mode 2.1
Thread-Topic: [PATCH v4 5/5] usb: typec: intel_pmc_mux: Configure Displayport
 Alternate mode 2.1
Thread-Index: AQHZ62rbwpQ8dap4LEKCYkC68sHlmbAjbbqAgAj1l6A=
Date:   Tue, 26 Sep 2023 02:00:24 +0000
Message-ID: <CY4PR11MB00371BE5AF3D802F205D7AEEA9C3A@CY4PR11MB0037.namprd11.prod.outlook.com>
References: <20230920023243.2494410-1-utkarsh.h.patel@intel.com>
 <20230920023243.2494410-6-utkarsh.h.patel@intel.com>
 <086a35c5-6402-3e3e-1ac4-fade2797b63a@gmail.com>
In-Reply-To: <086a35c5-6402-3e3e-1ac4-fade2797b63a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB0037:EE_|DS0PR11MB8739:EE_
x-ms-office365-filtering-correlation-id: 3f34049f-736b-4961-3c19-08dbbe34595e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zGW6BKGuIspALiCW6vZQ3bnTfx0X1qeB/RnNbAEifC2/RXLL4+hBoYprxU+kCHR4y96KYoLn90oibWabmAW52swfWl8PNrmpAcHCmA/Vpf21h3hFwKAvSBVSr+XdEmdfNOIhZkOJyir6TvFiEc+Qgq0iyJQ/ed5Ar/3qnhmpJiKmV4B7/k/Iw7kNkxFOZF3xb/5b+RRJP6ss/XdV/k8U7R+cmpYrDuxggr8uCjhVzpe0YziLAhueOtYFHA20Cce8BMLv2hruYE09BFd8vvyncoSnx9DoYKgP77Ew02ekin2mVMWQfxgV5qFXEv4+evL2fWhQVPrwFQX3lM3BaFi8irruo3n8p4Gq4i1MPwU6xyh4gTE4EZO6/QwAzAbeQVpWF/Z8QkIa4NWTQJ3V7mNj6zAJSbD/+E7zMsfQNxqKyu4xAgRcZ2iHT/f1wReuoMPTfimwaY/NAZP/0l8Gb3ARoq+H9sqMg33gj1A6P2nIiJ1quHUXRvkBvepFQbvGcpXvBjxvnGIuLspWHSGsVfifZx4DYZ0XjZR/KuFYkGOWKuOY1RJ0mAvbP4oaIa5SPhlFXs/OJVTOU8NPLH2SBm+9ULe8YBiY6E3sFO2GsMxbKwkYIIpBmOBwQWok4uTYJEzU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0037.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799009)(9686003)(53546011)(38070700005)(478600001)(7696005)(71200400001)(33656002)(6506007)(110136005)(83380400001)(86362001)(38100700002)(54906003)(82960400001)(66946007)(122000001)(66446008)(26005)(66556008)(64756008)(8676002)(41300700001)(55016003)(52536014)(316002)(5660300002)(76116006)(8936002)(4326008)(66476007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXJhQnFkTFlZbHN4ZHMvdHpkTi91bm9pZlNXRjF5dDR0S2VsZGRja3BNYjls?=
 =?utf-8?B?eEJqUExaSmM1N0ZtMG1tbXlqWDhZSjRNaVdjeDFpU0pxMXRwV2FDMExFNWp0?=
 =?utf-8?B?N01HWVFGZERqc2VjaWdkR1psN2dycU1RenlyblZkVGQvQWhUZVk0dzJJS3Bl?=
 =?utf-8?B?azAvSTVpb1E3TllCdUlyT09FVXg1aUw1WWo5eWl2RXZZVE5vd2RWckk5MVlF?=
 =?utf-8?B?MmxOSlloVXE1MXVOcklHMmQ4Q3FsWVdUMWlkaGxPOCtGL3EvTzRmRlZKckpS?=
 =?utf-8?B?S3dXU1J5NGZWVTlBQy9kY0ZRcXNVMTYyN01saFNaUXVlMGorMHVLeHlGYnlF?=
 =?utf-8?B?elRrZUFBZnV1aEN5MCtmVmJJanBtSDJRQmo0ZFBMbDRyZHZVUWZKWXNqMXFs?=
 =?utf-8?B?Rnc3VTMrY09SdVB2NkZHSWJSRWhyTFB3cTlrWGpBM1Z5YnUvMk5icGhyMHpF?=
 =?utf-8?B?M2IxUGNRUjN6NU00eTlBMVhGWlZDbjl6VnZBSTZIR0FxTStpazZYRStPUyt6?=
 =?utf-8?B?cnpmSjFKZGlTUDBhVVVSeHVBeHVDbk1ibm5TbjJ3NlFnUkdoNDAxVHJOWTBU?=
 =?utf-8?B?dDAyYXBBODVjUzMrWXRlSkZFMnp6VmdvekZxVHVXVDJ2UUdaZktpK1VqbW00?=
 =?utf-8?B?Zisxdmt1N2pKRnhxOFVBbG45ZFdWRENZZUNjZ05WN1R3dXIzUDRFVnhtYWs1?=
 =?utf-8?B?UURub0R1UzR2bm5yY0VUdW1jWktuak9id0hPYzcvRExQU1Fxd0dPYVJMZUI2?=
 =?utf-8?B?cXV6U0Fwemx1NUNFNkhZQ0RqOW9jMkgrNGF0ekFXSHFVOUV2a2l6cmlTam04?=
 =?utf-8?B?QTRwRzh6bTY4bFFPNzZQS01SM1hFZXdDRGIrTnRPdFk1dGcvRGl0M25tUVhS?=
 =?utf-8?B?eSsxTE11NFhJRTFVdy9hdG51UjAvTDR2R2ZzNVR3YStwdXRLellyUCt4bWpq?=
 =?utf-8?B?a1RQSFduVGZCZ1luV0VCWjc4RGtrK0hoV2FkQ1JxVjBoeXV4cGpVMWdicjBU?=
 =?utf-8?B?Smo2cDQ1alBkeS90ZTF5MmxzQnU5ZnFIVWxUZU1yQU1XUXNZckU2WU4veHIy?=
 =?utf-8?B?cXloT3VOei9nK0pZaE40Wmd4ZE1uWDRZbmhMOHZrQ2dZOXFhVDFIWUtjN3Bj?=
 =?utf-8?B?MGVwaGxYaG1WKzlic3FmS08xbXpFdEdwZHJPM0VHcmdpN0pnSlZBNFNweHNy?=
 =?utf-8?B?SmxvT3p5bkl3eVp4dWM1Zi9MYnJoeTBRQ0xxL3AwRUFPSU40NUxIeXBnOXAy?=
 =?utf-8?B?NE5Gc1VNbGc4L2VDOVZrVy9YMWdqSGdDVWNDZmpxV0ZVeHlERy9zb3A1Nzc0?=
 =?utf-8?B?TUg4RWhId21NYkt0K01TVE5Na2huKytzMmJ3WVBqUW1aaXEyK1kySXpJSjUv?=
 =?utf-8?B?dVdlNUxmTGdxcWF4L2hUemcvUHJpQXUzS1QxWnZHcWd0c05LaWwxaHJVNTYx?=
 =?utf-8?B?aFZVbk1kWUtIdWlLK2tqNXJFYm5iSDBJRkNIWVhqMnJ0ak1POXpuaHJrNlRH?=
 =?utf-8?B?d2hxak92ZXZCeXdnSWIvM3kwT2NheGxoYkRCcEJ4VGpnUlI3c05FZngyb0pN?=
 =?utf-8?B?ck9GYmN2WktJV3JTN04yeE0rZHh4Y1VGei8xMC9IdmpTN3VJRlNxMFRWd2NI?=
 =?utf-8?B?RnFOVjN6ZVBFbHMwNDMyay9MNG84bEJETHNrZWdUNE1WWmg2WFpiYkpDWStU?=
 =?utf-8?B?MjRNcU4xTUhCeWRUOUlOVS85R0txRHlRTE9HZzBia0owY3BOeEIyM3FHYnZV?=
 =?utf-8?B?SnpuekRTQ1gxb2Mvdm9YTytrTEd4NWhGTjk3eThCbE5nb0pmaU8yZGx4STh0?=
 =?utf-8?B?cVF0ZU9kV3hzZTRXYU9ldXZnMnhvMEcrL2xzcDVZS3NQRzV6OGMrc09VVUF5?=
 =?utf-8?B?M29HODZUQWhPRFpQdmZ4NjVLN1FTZU0wcWtrZlBCOGt0WGxuSnB0YmJpSndi?=
 =?utf-8?B?dlY0OXJzMjhjODNXZU1XYWlTV3V5ZDhjc0t4TXdlUHA1eHZYUkdqaWdUNkU2?=
 =?utf-8?B?cW1tWFFFUG1uUUd2ZUdLclpHQkl6RUdmYkhIVHBFK3RJMEFiWlU0NkQ0YW82?=
 =?utf-8?B?U0hWaDdLQ1l6YlNIUm5ZenovbE5PaGt2bWVOM3VCRmowS3h2bVJZOU4zL2lx?=
 =?utf-8?Q?fOwvBdRaVFZUfozvgnFllncnl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0037.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f34049f-736b-4961-3c19-08dbbe34595e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 02:00:24.9851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8sHi7RatRjzOH2xrOkF7zvj9MxUczxBVFlsKYkT9pyPgbhSeDn6yyjY8yXwwpyC+3QxaeFmrL5TcHmSC6SA2anAyNKxirxC/Am6/btGBD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8739
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2VyZ2VpLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2VyZ2VpIFNodHlseW92IDxzZXJnZWkuc2h0eWx5b3ZA
Z21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMyAyOjEwIEFN
DQo+IFRvOiBQYXRlbCwgVXRrYXJzaCBIIDx1dGthcnNoLmgucGF0ZWxAaW50ZWwuY29tPjsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcN
Cj4gQ2M6IGhlaWtraS5rcm9nZXJ1c0BsaW51eC5pbnRlbC5jb207IHBtYWxhbmlAY2hyb21pdW0u
b3JnOyBjaHJvbWUtDQo+IHBsYXRmb3JtQGxpc3RzLmxpbnV4LmRldjsgYW5kcml5LnNoZXZjaGVu
a29AbGludXguaW50ZWwuY29tOw0KPiBibGV1bmdAY2hyb21pdW0ub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjQgNS81XSB1c2I6IHR5cGVjOiBpbnRlbF9wbWNfbXV4OiBDb25maWd1cmUgRGlz
cGxheXBvcnQNCj4gQWx0ZXJuYXRlIG1vZGUgMi4xDQo+IA0KPiBPbiA5LzIwLzIzIDU6MzIgQU0s
IFV0a2Fyc2ggUGF0ZWwgd3JvdGU6DQo+IA0KPiA+IE11eCBhZ2VudCBkcml2ZXIgY2FuIGNvbmZp
Z3VyZSBjYWJsZSBkZXRhaWxzIHN1Y2ggYXMgY2FibGUgdHlwZSBhbmQNCj4gPiBjYWJsZSBzcGVl
ZCByZWNlaXZlZCBhcyBhIHBhcnQgb2YgZGlzcGxheXBvcnQgY29uZmlndXJhdGlvbiB0byBzdXBw
b3J0DQo+ID4gRGlzcGxheXBvcnQgQWx0ZXJuYXRlIG1vZGUgMi4xLg0KPiA+DQo+ID4gUmV2aWV3
ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29t
Pg0KPiA+IFJldmlld2VkLWJ5OiBIZWlra2kgS3JvZ2VydXMgPGhlaWtraS5rcm9nZXJ1c0BsaW51
eC5pbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVXRrYXJzaCBQYXRlbCA8dXRrYXJzaC5o
LnBhdGVsQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIHY0Og0KPiA+IC0gTm8g
Y2hhbmdlLg0KPiA+DQo+ID4gQ2hhbmdlcyBpbiB2MzoNCj4gPiAtIE5vIGNoYW5nZS4NCj4gPg0K
PiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBObyBjaGFuZ2UuDQo+ID4NCj4gPiAgZHJpdmVycy91
c2IvdHlwZWMvbXV4L2ludGVsX3BtY19tdXguYyB8IDI0DQo+ICsrKysrKysrKysrKysrKysrKysr
KysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL3R5cGVjL211eC9pbnRlbF9wbWNfbXV4LmMNCj4gPiBiL2Ry
aXZlcnMvdXNiL3R5cGVjL211eC9pbnRlbF9wbWNfbXV4LmMNCj4gPiBpbmRleCA2MGVkMWY4MDkx
MzAuLjIzMzk1ODA4NGI0MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi90eXBlYy9tdXgv
aW50ZWxfcG1jX211eC5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvdHlwZWMvbXV4L2ludGVsX3Bt
Y19tdXguYw0KPiBbLi4uXQ0KPiA+IEBAIC0yOTMsNiArMjk5LDI0IEBAIHBtY191c2JfbXV4X2Rw
KHN0cnVjdCBwbWNfdXNiX3BvcnQgKnBvcnQsDQo+IHN0cnVjdCB0eXBlY19tdXhfc3RhdGUgKnN0
YXRlKQ0KPiA+ICAJcmVxLm1vZGVfZGF0YSB8PSAoc3RhdGUtPm1vZGUgLSBUWVBFQ19TVEFURV9N
T0RBTCkgPDwNCj4gPiAgCQkJIFBNQ19VU0JfQUxUTU9ERV9EUF9NT0RFX1NISUZUOw0KPiA+DQo+
ID4gKwlpZiAoIWlzX3BtY19tdXhfdGJ0KHBvcnQtPnBtYy0+aW9tX2FkZXYpKSB7DQo+ID4gKwkJ
dTggY2FibGVfc3BlZWQgPSAoZGF0YS0+Y29uZiAmDQo+IERQX0NPTkZfU0lHTkFMTElOR19NQVNL
KSA+Pg0KPiA+ICsJCQkJICBEUF9DT05GX1NJR05BTExJTkdfU0hJRlQ7DQo+ID4gKw0KPiA+ICsJ
CXU4IGNhYmxlX3R5cGUgPSAoZGF0YS0+Y29uZiAmIERQX0NPTkZfQ0FCTEVfVFlQRV9NQVNLKQ0K
PiA+Pg0KPiA+ICsJCQkJIERQX0NPTkZfQ0FCTEVfVFlQRV9TSElGVDsNCj4gPiArDQo+ID4gKwkJ
cmVxLm1vZGVfZGF0YSB8PQ0KPiBQTUNfVVNCX0FMVE1PREVfQ0FCTEVfU1BEKGNhYmxlX3NwZWVk
KTsNCj4gPiArDQo+ID4gKwkJaWYgKGNhYmxlX3R5cGUgPT0gRFBfQ09ORl9DQUJMRV9UWVBFX09Q
VElDQUwpDQo+ID4gKwkJCXJlcS5tb2RlX2RhdGEgfD0gUE1DX1VTQl9BTFRNT0RFX0NBQkxFX1RZ
UEU7DQo+ID4gKwkJZWxzZSBpZiAoY2FibGVfdHlwZSA9PSBEUF9DT05GX0NBQkxFX1RZUEVfUkVf
VElNRVIpDQo+ID4gKwkJCXJlcS5tb2RlX2RhdGEgfD0NCj4gUE1DX1VTQl9BTFRNT0RFX0FDVElW
RV9DQUJMRSB8DQo+ID4gKw0KPiBQTUNfVVNCX0FMVE1PREVfUkVUSU1FUl9DQUJMRTsNCj4gPiAr
CQllbHNlIGlmIChjYWJsZV90eXBlID09IERQX0NPTkZfQ0FCTEVfVFlQRV9SRV9EUklWRVIpDQo+
ID4gKwkJCXJlcS5tb2RlX2RhdGEgfD0NCj4gUE1DX1VTQl9BTFRNT0RFX0FDVElWRV9DQUJMRTsN
Cj4gDQo+ICAgIFdoeSBub3QgKnN3aXRjaCogaW5zdGVhZCBvZiBzdHJpbmcgb2YgKmlmKnM/DQo+
IA0KDQpTd2l0Y2ggY2FuIGJlIHVzZWQgaGVyZSBidXQgaWYgdGhlcmUgaXMgbm8gYWRkZWQgYmVu
ZWZpdCwgd291bGQgc3RpY2sgdG8gaWYvZWxzZS4gDQoNClNpbmNlcmVseSwNClV0a2Fyc2ggUGF0
ZWwuIA0K
