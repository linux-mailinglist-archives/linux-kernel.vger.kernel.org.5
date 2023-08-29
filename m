Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A2D78C316
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjH2LHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjH2LHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:07:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EB997;
        Tue, 29 Aug 2023 04:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693307242; x=1724843242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w06oKvHwaImLst3/zT97MdCnmP1w+Lj1JDWi8kmYi1Q=;
  b=ghWY8ZhKOu2/ILsRMsgE/1oD2QbYDV+MUAp7f6BrODBcLw/HtAw8qkJF
   JEk/y7+vKA1QsD9JupsY67lPzzK9ZAUsg4RtU/Ettury9YgGcTHjVxUxP
   X8/HU/SLOcYktOfmUybOxDwDYHxKsRU40yQbXsgg/AIXKJuU/+6P+iqjv
   BjH25i3Dt1RRZnXcwTJQfhQ4Crbycm1S9CIjKon5dVkLhe5bjykE3OEgq
   dT/GQcSgVDLMYVe2OSvD8W32iCOoWQ5tlIRJKYQMYL3IBEZTX9hcTXwmW
   fdEWoajmPxccRpK1BPErhqh7H9dOOnK0C0KJ5ZaGwQYpdw41xGbK+nuTx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="374229157"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="374229157"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 04:07:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="768034904"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="768034904"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 29 Aug 2023 04:07:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 04:07:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 04:07:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 04:07:20 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 04:07:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2x7wRx0zQIY5j39rNLBLWfAL+q3i4gnG5NHM8uhnEWXVsTiQ57S/2Z111jTbNRDwe7lAi+TGWjfI/7OZp3bm7zpruaFXU4nbtkg8Q8Oy71rMlXcj8CHVeRAH6c3x9Fg3wY256fkpGBZD3H9M8nVW70fRkvW2Eq2w/YnrbQush/vx2UlqaChZL8Ej0iXbZ9nrf0W1xa5q0+32QXNwjUpiDuUN+ioaKv9afXa1tzMFpXqvq1oPqdlQatJeIMa6vgnOIgaJutYGXYkNNmL3qVH2ckgr/k2jSpAl91rjZTgHsQ/IC3GU5QmjmBZ2RxceI2lSYsIg8JM1s45zB7GKXzi2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w06oKvHwaImLst3/zT97MdCnmP1w+Lj1JDWi8kmYi1Q=;
 b=XIXZa+QA+22EoWrC3OvravaLqr9Sqp5c+Vn4CmVG/XBUZwarFyIiM6U0m1JBy8mjebcaE7awfOleyYncrC0lZWLU4iyBhi54UUAxsXi4u+1U65rLMY3yXcV0rcGq/REQuVmUfpxoA0eXO7DS6wjMVZoBKddyT0RH749RyXjmuSNwdJ0nLW+IXfBY3H3EcSIxL0Bg9zHg9tYvwZIyGHd2yQXmuYJmf9L5APkSOqy4B10Q+1109iys7V9h7mvLxscOTZTqRnoFBNB4DnBBZ081B3/U33L6KS+unqy59+OGqAk7ArGroasqjSHSgu0adogaqbqngsw5WMqBgQml2ThTYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS7PR11MB6014.namprd11.prod.outlook.com (2603:10b6:8:73::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Tue, 29 Aug
 2023 11:07:17 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 11:07:17 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 05/13] selftests/sgx: Include memory clobber for inline
 asm in test enclave
Thread-Topic: [PATCH v4 05/13] selftests/sgx: Include memory clobber for
 inline asm in test enclave
Thread-Index: AQHZ11jXLhA2IkU8Q0etZTaFtAcpk7ABIzwA
Date:   Tue, 29 Aug 2023 11:07:16 +0000
Message-ID: <72d6a82f9069ffd209a47f7ba7817ac90b14593e.camel@intel.com>
References: <20230825133252.9056-1-jo.vanbulck@cs.kuleuven.be>
         <20230825133252.9056-6-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230825133252.9056-6-jo.vanbulck@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS7PR11MB6014:EE_
x-ms-office365-filtering-correlation-id: b156f14c-d824-454f-c7cc-08dba8801b4a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nn7IZNBMWQm0xx6U9myrixaIK8E4oSp+R4ekXVJ+hQEB9ZAiqM8uwgr+Ku5jzcjDwa0QQj9/Tl9vPizoqoF4N8qpalh/2SEMUDAFvL+F6ql8mwpqKA9qhrwxqnxg6j9GE/s8M1IblyE/f1lX5t425oLv38rsUTGPrlgBx0McokJEZBwS/idDKrArnq1FCe6E1m6DrkFn2D0DiKvx2hVwPB9itgZtIUG0vt8bxn7sPcWzGFmkuUhpNMFYehfz8e2HXlZQOkMZ+0IYYwo2uEr3tPy8yObTw+w952wBoFual9RtrUnKlkSq/wW6hkawqT5EG4FJtMjkszCbN5yCDkuQeOCW6YNh/rtUVzB9p0ArES7dnGdu/u+1K7alNDDvrh1TrmERptjNmnOMOuNQqfuBPQCcPOTS1M6BaNps3wJ/dhkKGtc9vaLpP3WyCfATB5Hn/OFz+sZKxEDp4XTaBIkcCSoWZ8PsCrEEcmQwUoqsJPQUtphgA11NDOyhRh+qlh1TWrFrGHx0wTogi1M4frtj6NUWXZQNdPeFAcGpfjHLtDTJft/CYPdIJcVRojhPiI5vk4lTVz460h/VBEm6/DGgBRG1be5mpMCdJC3Jvz8nRk4Qfz92AzPfz7N07WDxaOVZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199024)(1800799009)(186009)(8936002)(122000001)(110136005)(91956017)(76116006)(478600001)(6506007)(71200400001)(64756008)(66446008)(66556008)(66476007)(66946007)(6486002)(38070700005)(316002)(38100700002)(41300700001)(82960400001)(6512007)(36756003)(26005)(8676002)(5660300002)(83380400001)(2906002)(2616005)(86362001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aC9SVm5IWWE4cmg2ZjlqanFpOVJNcTZrMEdlMkxVT3lrWnpxSkVDc0tNaUVq?=
 =?utf-8?B?VjVsVXk4Y01Da0dFWVNxbXZueG8zZEgyYW51ZmhGQ0RXVnY2ODZvQkdzQ2s5?=
 =?utf-8?B?OU1BaFVCRm5kQXhiSDZMckIyQXh3ci94ZkNwOWYwYU1BMWJPTjNoNTF5Q2ZG?=
 =?utf-8?B?d3B0WUVIeGpsMjgvYlBLM3Q2VEdNUXl6dGxSWThROW54WklHcXhoajk0TU5i?=
 =?utf-8?B?WFVzZk9MYUM2WXZrU2ZBNFFhK2t2MENLN3p5YUJodFBqSmZQNVl1SjkyNDZJ?=
 =?utf-8?B?TmtBWXgzbEM4UFRVYnJpTWdOUWFEcFVya1lnWVZsZEc3L3Z5UzMyS3FRL3Ey?=
 =?utf-8?B?VVkyUGg0V3dkWW9hUW13ZXRmcG8ySW5GbDJwUGtWcWVmbVhGay8zc1hzdTFF?=
 =?utf-8?B?WldCSGwyVGZ2bU1sNFBEYVNwVUtJelBTTVJxT2ZGUlVpbVgxODZtbHRpTjIw?=
 =?utf-8?B?SGRCdzVoMzUzaER0QkQ2aGxLM05IMUlSQWRxbHBBMGRrUm5EV0tlN1dUL1Vs?=
 =?utf-8?B?Uzc5MGJSY1BwUnM0ejFEUCtsa01PVGtFQkYycFp4UlRzUWNyclc4Q3JLUm01?=
 =?utf-8?B?M0Q2TXlJaEZCZWtYc0VCMGl4TFF2bW9ZZVhtWThmc3ltZ3VlV1J1c2VUdzZM?=
 =?utf-8?B?OEZ3NlhaSEdhckRKYW5JdStOSm1sUlB6V2JLYkptSnVpU24xQ0ZSSmVHZkND?=
 =?utf-8?B?N21XSExTdVNxdzlFS0JrbHlOeUNFQUF4TEc2Y1NpckZoVEJVUEhkNjRBM0wv?=
 =?utf-8?B?QmwzQVR2R3FGS2Q2TUhoSjhVdDhEUmhJQTFub05YUzFiTi9jS04zdnRXd21q?=
 =?utf-8?B?S1VvVTVnOUt5cytsVmF1RktaSUFiRzhSTnlPenNqVmFOY3k4OFU3ODBJNkZr?=
 =?utf-8?B?NUNITW16WDYxL1lSTUdCLzEydmFpamRhV3dPaGJjMUwxYXhMOFFGWnZWaVpD?=
 =?utf-8?B?S0FRaTBqR2VLcUx0NzFnM3JNb0xkOHladEdNb0M0d3BDWXZMVTM4TEZFYnBa?=
 =?utf-8?B?eUJETWp4LzFyY0VHSE0wZ1c1MjFvOXJrdURCaDgvcDdGYk9xeE1IMXdkUkg3?=
 =?utf-8?B?d0NOalpJMGdRTWVWa0lQZFlzR1ppTU4rYWN3UWJQdXYzWmhYem9yNGVPZ29k?=
 =?utf-8?B?VWthNWFsRm5zRnFGd0tBVk5ZUkpoUmJoWlBIOUxmZXRHWlNuNW5UTEk5cWdk?=
 =?utf-8?B?SytyNWRpWml3ZWsxQU5lOVduM1VQQi93Q0VJOEFtWVZBTGJYUE1Fa092OVoz?=
 =?utf-8?B?TDN1RmVJNU1QSFVuTUNBalJ3ZWJ2bTB3ZFNTMmJKSDJscnJLUUxTVmdyanhu?=
 =?utf-8?B?Tk1BUFNpd3paM0oxbVB1N2VvUnBoM1lzeXZseWhTVnhIaWIwOHRQblRvU2Iz?=
 =?utf-8?B?d0E3UWRydG9aMGRyeFRiS2FSVUZaTzUyenkrelpZak8zNkFXZDlSdThZWHVo?=
 =?utf-8?B?OHU4NzF2S3VpcFkyTmlBd3ExaFNwMy9vQ3FGUGd6c2kvcEJsbFFyYnFEVjlW?=
 =?utf-8?B?QnE2b3p2UXp2NHhETFJzVm5Yc21jbk9nc2lVMjgzRWF1SFVzWEN5NzlPSUNr?=
 =?utf-8?B?WXVhQTh6SmlSOHlQRENjVUY4WXRrTWpXWmFydWUrdTYwSDhpRGtHbG9qS1lG?=
 =?utf-8?B?bTB2aWlQWlQ1ZnNPYmlYZFRXZUxjdzBaMnA4WnhlRFg2d3pNY0Fwek1VbmZt?=
 =?utf-8?B?K3Q2ZHE2V0M1V2ErVXNocnpoRm0vcFZKK2U4cHZUaFFMOWVqYS9ZTjhIYSsx?=
 =?utf-8?B?YWpoYUR5aEMrSHZJVFM1V3Q2VGorUEhIbTRQL05lcnV4VjNCa1k2d1NkY28x?=
 =?utf-8?B?YnRhOTlmbkhCZjR0MUlkL0x3aVpmZ1FCR2ZwOHVCWXhqeHV1cTFRRTluTGJV?=
 =?utf-8?B?RmVZaFdzTmUyblZTTXk2NUdrNHFEczBjZTg0Z3QzS3R0VzZJU2EvdkhzOGxY?=
 =?utf-8?B?dnNZQXlhNmhLVzhJMUVsc1E1RVpWYkN1Y0xRV2RpTFowc1VwQUJrV0VvZUtt?=
 =?utf-8?B?MWFSMk5EOENRUTgyZ2FpUFVGRkQyUVA5cko3WVc3RFRXZW1wT0RXMWpteTBV?=
 =?utf-8?B?bkpRdjFSUmtQdXJ6N2wvbjROZDNqNmdrbW9wQ1FvRmVUcDQ1UXV2YUhLVzBL?=
 =?utf-8?Q?Bypl+1Qc073BmJoKUe6X0bNFI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <528292232219B941B3A94769F28230DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b156f14c-d824-454f-c7cc-08dba8801b4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 11:07:16.9899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UiFSYMnrNP5eO+gRoLQ4hLkiOy7tB5K9JD8VXj6mhHRrwenvT3FsD6U5/yW6Fldzr5a62IUhTsIG5c3/MhOeow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6014
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA4LTI1IGF0IDE1OjMyICswMjAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IEFkZCB0aGUgIm1lbW9yeSIgY2xvYmJlciB0byB0aGUgRU1PRFBFIGFuZCBFQUNDRVBUIGFzbSBi
bG9ja3MgdG8gdGVsbCB0aGUNCj4gY29tcGlsZXIgdGhlIGFzc2VtYmx5IGNvZGUgYWNjZXNzZXMg
dG8gdGhlIHNlY2luZm8gc3RydWN0LiBUaGlzIGVuc3VyZXMNCj4gdGhlIGNvbXBpbGVyIHRyZWF0
cyB0aGUgYXNtIGJsb2NrIGFzIGEgbWVtb3J5IGJhcnJpZXIgYW5kIHRoZSB3cml0ZSB0bw0KPiBz
ZWNpbmZvIHdpbGwgYmUgdmlzaWJsZSB0byBFTkNMVS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpv
IFZhbiBCdWxjayA8am8udmFuYnVsY2tAY3Mua3VsZXV2ZW4uYmU+DQo+IFJldmlld2VkLWJ5OiBL
YWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBKYXJra28gU2Fr
a2luZW4gPGphcmtrb0BrZXJuZWwub3JnPg0KPiAtLS0NCj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3NneC90ZXN0X2VuY2wuYyB8IDggKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
c2d4L3Rlc3RfZW5jbC5jDQo+IGluZGV4IDcwNmMxZjcyNjBmZi4uZGZlNTMxYzVmNTYwIDEwMDY0
NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsLmMNCj4gKysr
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbC5jDQo+IEBAIC0yNCwxMCAr
MjQsMTEgQEAgc3RhdGljIHZvaWQgZG9fZW5jbF9lbW9kcGUodm9pZCAqX29wKQ0KPiAgCXNlY2lu
Zm8uZmxhZ3MgPSBvcC0+ZmxhZ3M7DQo+ICANCj4gIAlhc20gdm9sYXRpbGUoIi5ieXRlIDB4MGYs
IDB4MDEsIDB4ZDciDQo+IC0JCQkJOg0KPiArCQkJCTogLyogbm8gb3V0cHV0cyAqLw0KPiAgCQkJ
CTogImEiIChFTU9EUEUpLA0KPiAgCQkJCSAgImIiICgmc2VjaW5mbyksDQo+IC0JCQkJICAiYyIg
KG9wLT5lcGNfYWRkcikpOw0KPiArCQkJCSAgImMiIChvcC0+ZXBjX2FkZHIpDQo+ICsJCQkJOiAi
bWVtb3J5IiAvKiByZWFkIGZyb20gc2VjaW5mbyBwb2ludGVyICovKTsNCj4gIH0NCj4gIA0KPiAg
c3RhdGljIHZvaWQgZG9fZW5jbF9lYWNjZXB0KHZvaWQgKl9vcCkNCj4gQEAgLTQyLDcgKzQzLDgg
QEAgc3RhdGljIHZvaWQgZG9fZW5jbF9lYWNjZXB0KHZvaWQgKl9vcCkNCj4gIAkJCQk6ICI9YSIg
KHJheCkNCj4gIAkJCQk6ICJhIiAoRUFDQ0VQVCksDQo+ICAJCQkJICAiYiIgKCZzZWNpbmZvKSwN
Cj4gLQkJCQkgICJjIiAob3AtPmVwY19hZGRyKSk7DQo+ICsJCQkJICAiYyIgKG9wLT5lcGNfYWRk
cikNCj4gKwkJCQk6ICJtZW1vcnkiIC8qIHJlYWQgZnJvbSBzZWNpbmZvIHBvaW50ZXIgKi8pOw0K
PiAgDQo+ICAJb3AtPnJldCA9IHJheDsNCj4gIH0NCg0KVG8gbWUgdGhpcyBpcyBhbHNvIGEgYnVn
IGZpeCBwYXRjaCwgdGh1cyBhcyBKYXJra28gc2FpZCBzaG91bGQgYmUgYWhlYWQgb2Ygb3RoZXIN
Cm5vbi1idWcgZml4IHBhdGNoZXMuDQoNCkFuZCBhbHNvIGluY2x1ZGUgdGhlIEZpeGVzIHRhZz8N
Cg==
