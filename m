Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AED754EE2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 15:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGPNpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 09:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPNpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 09:45:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3B1E71;
        Sun, 16 Jul 2023 06:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689515108; x=1721051108;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mYJKOHAWWn6o2KVzDaU0rvITEzhhvPoMeTti9b4B5o8=;
  b=Ho10A43azUTbREAdeXEGca+ePsg0VJvib+z/BuR5++o4g7OGRBr3J4R8
   uHnZn2McR8MnhmoM4QddWBkoYAqe3R7MK50B3xRRHE2AAPZU573cfKkDw
   u6OoprAn+kX7T5bBwctGqpOcz3V255cm7Cv2CcqgXz/+cbnB+0hEHTrNp
   tM6yQYTo9pbKet2tFY939sGyuA2BMUt76qP2jcwJa7jgoDIFpc0IIw4yb
   DKkoW3sPNlyxGtYTIJdNVYhlUjdUy8Pw8uEs/Wm2ByOtnzVS71XPILVkv
   C3sNeidHgBZcwC5ZAocax+C1xPRtWmtOhErLQnBPxJi7AbgqKS0q1F7FN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="350625909"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="350625909"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 06:45:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="969561202"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="969561202"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jul 2023 06:45:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 16 Jul 2023 06:45:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 16 Jul 2023 06:45:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 16 Jul 2023 06:45:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YN4vVy1bZxPrYSay/u6HvjpkmC8EsAfB/fM4oiuXXwbR2N6xnI6RHjwNdoizjwUPvr2gUAmxKuEAUGhVGcNe/NCorSC3rWwMmKOmlzIH4MYnVwQ8R47VIiaGx/kA/MmIcABq2W/NqDBCWvg8Adqr5ORtnje3n+FmHpRYU/1V1twVCfTrswI22OmFvWeq/ePLZxEZBnU5Oxx6n3i4zLXevfmGsVbTAltQeB73n70p20Pa9BEcip5f85Jucv6tys7aRkdGcZlmHdrPPaMg6g030NXU33ZUOw/L+BjEpw33W6F57CEPgdeBwL+NaRRafLcIDhNPS2IdWeGhQpbsNUSHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYJKOHAWWn6o2KVzDaU0rvITEzhhvPoMeTti9b4B5o8=;
 b=Yxp1uiuds0O6QP0M2npknfbVwNGMMfSkTJecsyoZHPVHcWV0Qlk1MAPmk6DqjnsISG7i6eg8K1InFTXXyDGsePNunUMmaCeGxfRzAKRh12+qvw8yMCvX1a4iibXTlFzZDoPZkVEa6GiiYvwNKh0F/MWZRhg7HJgHQ5X9U8CC1jL0M2KaDSpHuUzIE6cQsXnt3qui1zBoKsP+TOSntsnhL/SyiSWNYGmlMztcBHrQvnGAIjZx17+/ox/TCCCRrHONtj8jCU5tsENZ/eNKyQDQYcVlB+JJbYHJ+/zTojczkzP1JjIH36/Q5cj7lXtJdITs4dLqQsRaGw9qwIjzyPlBzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CY8PR11MB7687.namprd11.prod.outlook.com (2603:10b6:930:74::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sun, 16 Jul
 2023 13:45:05 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::2bc0:5e18:b0e6:6477]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::2bc0:5e18:b0e6:6477%4]) with mapi id 15.20.6588.031; Sun, 16 Jul 2023
 13:45:05 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "hpausten@protonmail.com" <hpausten@protonmail.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "Stern, Avraham" <avraham.stern@intel.com>
Subject: Re: [PATCH] wifi: iwlwifi: mvm: enable thermal zone only when
 firmware is loaded
Thread-Topic: [PATCH] wifi: iwlwifi: mvm: enable thermal zone only when
 firmware is loaded
Thread-Index: AQHZsxvy9RFMrkLtxkuVdDDYJUc21K+3dgsAgAT7LoA=
Date:   Sun, 16 Jul 2023 13:45:05 +0000
Message-ID: <7a45b2ed16645523a13d69290b27031f607b214a.camel@intel.com>
References: <20230710104626.8399-1-hpausten@protonmail.com>
         <e8777141-882c-d5a0-b93b-2dbeb6ea93f7@linaro.org>
In-Reply-To: <e8777141-882c-d5a0-b93b-2dbeb6ea93f7@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CY8PR11MB7687:EE_
x-ms-office365-filtering-correlation-id: 46b678bd-cda4-4323-d079-08db8602dcb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MVYyvn0sf/L7ns1cRXqSqFsLmpr1mOVKNzpgLVYjvoucGyDaMwVsa/G5t4lDK9KRke3Hr0ahJ6ZnMkybC8c9dq1Pz4sHLN9EJPIWhj8tHEOiX+PB+X3kQKNLcuqRvjidt6ew1wr895uTTfGNfj2nJnBNCuNdq5r6Mr8+VdGRW7BP0zFR1JLOcWgkyBR8CjEOAeaI8oEd5lFPJ3rcNHaYCw+PUMukzU0a1nqXRETS0KDG5HXUs7xPF/UoiJlejKwjiD1dX/JI6VIKX9OXDu53KVuK0umuuMaBUoNc1FIPsQWx9eWtUgE1YI2yP7uCIl7LdQ8Axt32AFgiQ4pqcbsNm2KNNDMRYFG1BUKhJROWWRAq5zV/grOYiiT5f3iAiT6LeneeQD28lNPi3/iGSttaps+AJRyX4qHYhxmBji9qNM7LKIegbQfYXVXLej7ktmNrvKNVzqNrkJybKcOPBQJJckEC1TwGa9fa995VSgouUCmKclVAKfVC1Z74vwjO8MAeQopkahNFz8sxm7/AV15/4rZTt9m+ODRB3o9f52VfZqBN/8Q1JKmiKeG00wnrqwdJ/JRPInSfhgylos7QOiU6AqRD5SRYUXbIOm0iBSvUuj3By/dB1z60ZMuGwqf+f44M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199021)(2906002)(38100700002)(122000001)(6512007)(82960400001)(83380400001)(2616005)(186003)(107886003)(26005)(6506007)(53546011)(86362001)(38070700005)(5660300002)(8936002)(36756003)(8676002)(478600001)(54906003)(110136005)(6486002)(71200400001)(316002)(41300700001)(91956017)(4326008)(64756008)(66476007)(66556008)(66946007)(66446008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW40VE5oYlovdk9PbUdQWVpBZVJLT1FqZ0ZmRGY5REl6QXlKRjBBYTlWUmRF?=
 =?utf-8?B?SWpLVkhJSnJrcnY2L0pGZ1hPb2NULzVRSGVON1U5Z05XdXFFMHoyQVRwMnVS?=
 =?utf-8?B?Q0dsOFFvelVGb0VGRTdRTEtSWkY5ak14eTdoSEM5Z1R5N29ob0daejBudVlz?=
 =?utf-8?B?Ykk0L2U1bHJ6YkRFUmhyK09JOFQwZ01iWXVZMUxyQXEvVUJzZEs0TVJlMTdZ?=
 =?utf-8?B?ei91TS9xL2lxRm1PbDc4NmdDRU8zbmZzaVpIZ3U3OFREMXJTMlNZcXZsOGNk?=
 =?utf-8?B?MVZGaW5LRVQvbUJ3NjNPMmR1RC84TURsV3pVWjdlR1hiaFoxU2RLdXdIemI2?=
 =?utf-8?B?SExUcktpbklBMVpjWVhVU1hOM0ZJR0pVTHprSmhjM3cwWW5mZ3FPVGNBclNR?=
 =?utf-8?B?RHQ1UWIydXdmYUd4REh2WUtuR2VJZHdyVHEwRXkxcXJpOGo4SStLT2tyTGtl?=
 =?utf-8?B?aEJFUGxVcGxSVzlDVThTdFBmWm5kUU1wYkhYM2QyMVVEdi9HcU9PK0RPbE5y?=
 =?utf-8?B?VjdETDdnR0FpSWFScFl0eHpDUmc5RmxUZjcwZXhqd29xSHJ5VFhZV3orVHcr?=
 =?utf-8?B?dzB3WEJuS1VFNHRNN3BvMWh6WWNOUDBJYUVEdmNkSlFza3AzZ00wbFJRT05O?=
 =?utf-8?B?dmxySVpvbS93KzVzQnZnVTMyeGM0TXhkSnVGdkMvaXYwSXFKejc3d1lHYU1p?=
 =?utf-8?B?Q0VnMkZaYzF1b3VvbHBTWHBOMG5tQkJ2NEVMNHBxT2JuTEZhdzRQaXB6S1N1?=
 =?utf-8?B?VUpndFNRdjFqa0pFM0h2cjJRSUhNT3RZSFNaYmw3TEloTDc3VXJhSEpyN2l1?=
 =?utf-8?B?QU5iZndNbFRKWG41OWhFemxlWFFsSW1xWVEySnN5dFRkV0hzSENZY0Zyand4?=
 =?utf-8?B?Z0FnZ2hXMzdTbzdUNFFnWi9KOFJNSitlVnl3OWVzRWV4bnJVTXhCaDI4ZTdB?=
 =?utf-8?B?VjNFMEZpUnlVYUVhVGdRVnlESU9YRXRldU80OVN5UEpqL1N4ako3Sk5lMHBP?=
 =?utf-8?B?Q01oUUFMUXNkNXlpT1pqKzJna0lJTmVMcWdQV0lFT1NYMEhqYWRNbXpJRS9h?=
 =?utf-8?B?cERRdENIN3plb1RNSWtKVDhCVlZvRjRQM3paUzY1L0pNeE9Xbmc3M0swYWFD?=
 =?utf-8?B?aUFoZlkzS05wNVVNNkorSCtRZTlXY082S05ZeWlSWTYvcW15QWVrWHJzUHI0?=
 =?utf-8?B?UWdoSkhsb3RzUklrVjM4ZUZtV0NCWGI3U3NjQlpvTHp5WVNyR20xSnBUejdI?=
 =?utf-8?B?Ykp1bWhVcVJuYmpES1VlUUNkeWlPYjI2Smovc0Q5V0NEbk54U2ZSa293ekpp?=
 =?utf-8?B?RlVLVEpnTWIwcmlXK0FNUUk0NWd1Nnh3THhxaCtZcXE1akRtVE9pTEhUZitE?=
 =?utf-8?B?RjB0SEdZMWhRbWFmR2JnUGxTUUNSeExSRENCVHh3alZBRmM3bndJdHBwOGtI?=
 =?utf-8?B?WXVOMTRQTy9KZFU4elhYQW02R2tldGhkTXRZOGVxRnRBRUd6bzBGMURvNVNv?=
 =?utf-8?B?VHpTaUFMeFhkZlBwVGNPeUF1QWRQejh4Y0lKTk5PRUxvSGxuZzRwclB6UGdE?=
 =?utf-8?B?OUVsZEZSelRFenkxQmRBWmRtVHJlTEhRRkc1bURMWVhncEowNEtqV2ZiYVlR?=
 =?utf-8?B?d2M1ZzJjd0FqWG9pbWx1TkJCM0kvSU1kejQ3VGpoZ0FHNHk3bWZmWlpTbitX?=
 =?utf-8?B?NXphQ2F1REFNdzZTN2Z4OWFDNGR0dUNnK2RTUVlrSFpxNVozeERadXMwOUxW?=
 =?utf-8?B?RUpRZ3BocWU4Qk10UXhaMjdjbURVKzY3YTNnYks3T2FiREZBWk13azFaU2pC?=
 =?utf-8?B?MjFZbnRvTzlLSXZVNThuYnU4MlBHa1ZlSk1kTUljbFZydk9tMHQwcG9tQlFE?=
 =?utf-8?B?dDFnbUxBVkxMei96S3JhNU53L0tLM1UvOXVqQnFGeUhBSHBVL015ajN4ZUlU?=
 =?utf-8?B?UHpjVHNvNHVpWnpZZno2dUNJS3BFNENjYTVZY0J6Ry9lZENYZENldmhqaUxO?=
 =?utf-8?B?N0pZY2x2THVKbzJ3NzdYL1lPeXNyZlkzRFRrZ0pOcnBWdWlHNjZWZWdZNCtW?=
 =?utf-8?B?Zm40RnNmQlB6ZlFPWkFGd1dxeXBLWGlMMTFxMVpaOUp1K0VaSEJtL2RVK1JJ?=
 =?utf-8?Q?gVg3otVFvLuC7WP42tvZ285MY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83D78E4A00AE3F49B6887C765EF3B110@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b678bd-cda4-4323-d079-08db8602dcb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2023 13:45:05.3692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2q2eVlOb8CHfFCP6pkY55oXrXAtdlDkaCdm4BGJ6esv77w6+NFpjYDzDF8EeP4xCaIwySglMXnTUVaqSS12KMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7687
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

T24gVGh1LCAyMDIzLTA3LTEzIGF0IDExOjQxICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gT24gMTAvMDcvMjAyMyAxMjo0NywgSGFycnkgQXVzdGVuIHdyb3RlOg0KPiA+IEluIGl3bF9t
dm1fdGhlcm1hbF96b25lX3JlZ2lzdGVyKCksIHdoZW4gcmVnaXN0ZXJpbmcgYSB0aGVybWFsDQo+
ID4gem9uZSwgdGhlDQo+ID4gdGhlcm1hbCBzdWJzeXN0ZW0gd2lsbCBldmFsdWF0ZSBpdHMgdGVt
cGVyYXR1cmUuDQo+ID4gQnV0IGl3bF9tdm1fdHpvbmVfZ2V0X3RlbXAoKSBmYWlscyBhdCB0aGlz
IHRpbWUgYmVjYXVzZQ0KPiA+IGl3bF9tdm1fZmlybXdhcmVfcnVubmluZygpIHJldHVybnMgZmFs
c2UuDQo+ID4gQW5kIHRoYXQncyB3aHkgbWFueSB1c2VycyByZXBvcnQgdGhhdCB0aGV5IHNlZQ0K
PiA+ICJ0aGVybWFsIHRoZXJtYWxfem9uZVg6IGZhaWxlZCB0byByZWFkIG91dCB0aGVybWFsIHpv
bmUgKC02MSkiDQo+ID4gbWVzc2FnZSBkdXJpbmcgd2lmaSBkcml2ZXIgcHJvYmluZy4NCj4gPiAN
Cj4gPiBUaGlzIHBhdGNoIGF0dGVtcHRzIHRvIGZpeCB0aGlzIGJ5IGRlbGF5aW5nIGVuYWJsaW5n
IG9mIHRoZSB0aGVybWFsDQo+ID4gem9uZQ0KPiA+IHVudGlsIGFmdGVyIHRoZSBmaXJtd2FyZSBo
YXMgYmVlbiBsb2FkZWQvaW5pdGlhbGl6ZWQuIEl0IGFsc28gZ2V0cw0KPiA+IGRpc2FibGVkIHdo
ZW4gZ29pbmcgaW50byBzdXNwZW5kLg0KPiANCj4gVGhhbmtzIGZvciB0YWtpbmcgY2FyZSBvZiB0
aGlzIGJ1Zy4NCj4gDQo+IFRoZSB0aGVybWFsIHpvbmUgd2lsbCBiZSBhY2Nlc3NpYmxlIGZyb20g
dXNlcnNwYWNlDQoNCkN1cnJlbnRseSwgSSBzZWUgdGhhdCB0aGUgbW9kZSBpcyBjaGVja2VkIG9u
bHkgaW4NCl9fdGhlcm1hbF96b25lX2RldmljZV91cGRhdGUoKS4NCg0Kc2hvdWxkIHdlIGxpbWl0
IHRoZSB1c2Vyc3BhY2UgYWNjZXNzIGZvciBkaXNhYmxlZCB0aGVybWFsIHpvbmU/IEZvcg0KZXhh
bXBsZSwgcmV0dXJuIGZhaWx1cmUgd2hlbiByZWFkaW5nICd0ZW1wJyBzeXNmcyBhdHRyaWJ1dGUu
DQoNCj4gIGFuZCBjYW4gYmUgZW5hYmxlZA0KPiBtYW51YWxseS4NCg0KbWF5YmUgd2Ugc2hvdWxk
IGhhdmUgYSAuY2hhbmdlX21vZGUoKSBjYWxsYmFjayBhbmQgcmV0dXJuIGZhaWx1cmUgd2hlbg0K
ZW5hYmxpbmcgdGhlIHRoZXJtYWwgem9uZSB3aXRoIHdpZmkgZmlybXdhcmUgdW5sb2FkZWQuDQoN
Cj4gIFRoZSByZXN1bHRpbmcgdGVtcGVyYXR1cmUgcmVhZCBlcnJvciB3aWxsIGJlIHRoZSBzYW1l
IGluIHRoaXMgDQo+IGNhc2UuDQo+IA0KPiBJTU8sIGl0IGlzIGNsZWFuZXIgdG8gYWN0dWFsbHkg
W3VuXXJlZ2lzdGVyIHRoZSB0aGVybWFsIHpvbmUgd2hlbiB0aGUNCj4gZmlybXdhcmUgaXMgW3Vu
XWxvYWRlZA0KDQpBdXN0ZW4sDQptYXkgSSBrbm93IGhvdyBvZnRlbiBpcyB0aGlzIHdpZmkgZmly
bXdhcmUgbG9hZGVkL3VubG9hZGVkPw0KDQp0aGFua3MsDQpydWkNCj4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogSGFycnkgQXVzdGVuIDxocGF1c3RlbkBwcm90b25tYWlsLmNvbT4NCj4gPiAtLS0NCj4g
PiDCoCAuLi4vbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL21hYzgwMjExLmPCoCB8IDE4
DQo+ID4gKysrKysrKysrKysrKysrKysrDQo+ID4gwqAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9tdm0vdHQuY8KgwqDCoCB8wqAgOSArLS0tLS0tLS0NCj4gPiDCoCAyIGZpbGVz
IGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL21hYzgwMjEx
LmMNCj4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL21hYzgwMjEx
LmMNCj4gPiBpbmRleCBjZTc5MDVmYWEwOGYuLmE0N2QyOWE2NGRkNCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tYWM4MDIxMS5jDQo+ID4g
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWFjODAyMTEuYw0K
PiA+IEBAIC0xMTg3LDYgKzExODcsMTcgQEAgaW50IGl3bF9tdm1fbWFjX3N0YXJ0KHN0cnVjdCBp
ZWVlODAyMTFfaHcNCj4gPiAqaHcpDQo+ID4gDQo+ID4gwqDCoMKgwqDCoMKgwqDCoG11dGV4X3Vu
bG9jaygmbXZtLT5tdXRleCk7DQo+ID4gDQo+ID4gKyNpZmRlZiBDT05GSUdfVEhFUk1BTA0KPiA+
ICvCoMKgwqDCoMKgwqDCoC8qIE5lZWRzIHRvIGJlIGRvbmUgb3V0c2lkZSBvZiBtdXRleCBndWFy
ZGVkIHNlY3Rpb24gdG8NCj4gPiBwcmV2ZW50IGRlYWRsb2NrLCBzaW5jZSBlbmFibGluZw0KPiA+
ICvCoMKgwqDCoMKgwqDCoCAqIHRoZSB0aGVybWFsIHpvbmUgY2FsbHMgdGhlIC5nZXRfdGVtcCgp
IGNhbGxiYWNrLCB3aGljaA0KPiA+IGF0dGVtcHRzIHRvIGFjcXVpcmUgdGhlIG11dGV4Lg0KPiA+
ICvCoMKgwqDCoMKgwqDCoCAqLw0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmICghcmV0KSB7DQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IHRoZXJtYWxfem9uZV9kZXZpY2Vf
ZW5hYmxlKG12bS0NCj4gPiA+dHpfZGV2aWNlLnR6b25lKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaWYgKHJldCkNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoElXTF9ERUJVR19URU1QKG12bSwgIkZhaWxlZCB0byBlbmFibGUN
Cj4gPiB0aGVybWFsIHpvbmUgKGVyciA9ICVkKVxuIiwgcmV0KTsNCj4gPiArwqDCoMKgwqDCoMKg
wqB9DQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgaXdsX212bV9tZWlf
c2V0X3N3X3Jma2lsbF9zdGF0ZShtdm0pOw0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gcmV0Ow0KPiA+IEBAIC0xMjgyLDYgKzEyOTMsNyBAQCB2b2lkIF9faXdsX212bV9tYWNfc3Rv
cChzdHJ1Y3QgaXdsX212bSAqbXZtKQ0KPiA+IMKgIHZvaWQgaXdsX212bV9tYWNfc3RvcChzdHJ1
Y3QgaWVlZTgwMjExX2h3ICpodykNCj4gPiDCoCB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVj
dCBpd2xfbXZtICptdm0gPSBJV0xfTUFDODAyMTFfR0VUX01WTShodyk7DQo+ID4gK8KgwqDCoMKg
wqDCoMKgaW50IHJldDsNCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDCoMKgZmx1c2hfd29yaygmbXZt
LT5hc3luY19oYW5kbGVyc193ayk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoGZsdXNoX3dvcmsoJm12
bS0+YWRkX3N0cmVhbV93ayk7DQo+ID4gQEAgLTEzMDcsNiArMTMxOSwxMiBAQCB2b2lkIGl3bF9t
dm1fbWFjX3N0b3Aoc3RydWN0IGllZWU4MDIxMV9odw0KPiA+ICpodykNCj4gPiANCj4gPiDCoMKg
wqDCoMKgwqDCoMKgaXdsX212bV9tZWlfc2V0X3N3X3Jma2lsbF9zdGF0ZShtdm0pOw0KPiA+IA0K
PiA+ICsjaWZkZWYgQ09ORklHX1RIRVJNQUwNCj4gPiArwqDCoMKgwqDCoMKgwqByZXQgPSB0aGVy
bWFsX3pvbmVfZGV2aWNlX2Rpc2FibGUobXZtLT50el9kZXZpY2UudHpvbmUpOw0KPiA+ICvCoMKg
wqDCoMKgwqDCoGlmIChyZXQpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoElX
TF9ERUJVR19URU1QKG12bSwgIkZhaWxlZCB0byBkaXNhYmxlIHRoZXJtYWwgem9uZQ0KPiA+IChl
cnIgPSAlZClcbiIsIHJldCk7DQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgbXV0ZXhfbG9jaygmbXZtLT5tdXRleCk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoF9faXdsX212
bV9tYWNfc3RvcChtdm0pOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJm12bS0+
bXV0ZXgpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL212bS90dC5jDQo+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212
bS90dC5jDQo+ID4gaW5kZXggMTU3ZTk2ZmEyM2MxLi45NjRkMmQwMTFjNmIgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdHQuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3R0LmMNCj4gPiBAQCAt
NjgwLDcgKzY4MCw3IEBAIHN0YXRpY8KgIHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlX29wcw0K
PiA+IHR6b25lX29wcyA9IHsNCj4gPiANCj4gPiDCoCBzdGF0aWMgdm9pZCBpd2xfbXZtX3RoZXJt
YWxfem9uZV9yZWdpc3RlcihzdHJ1Y3QgaXdsX212bSAqbXZtKQ0KPiA+IMKgIHsNCj4gPiAtwqDC
oMKgwqDCoMKgwqBpbnQgaSwgcmV0Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoGludCBpOw0KPiA+IMKg
wqDCoMKgwqDCoMKgwqBjaGFyIG5hbWVbMTZdOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBzdGF0aWMg
YXRvbWljX3QgY291bnRlciA9IEFUT01JQ19JTklUKDApOw0KPiA+IA0KPiA+IEBAIC03MDcsMTMg
KzcwNyw2IEBAIHN0YXRpYyB2b2lkDQo+ID4gaXdsX212bV90aGVybWFsX3pvbmVfcmVnaXN0ZXIo
c3RydWN0IGl3bF9tdm0gKm12bSkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJldHVybjsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiA+IA0KPiA+IC3CoMKgwqDCoMKgwqDC
oHJldCA9IHRoZXJtYWxfem9uZV9kZXZpY2VfZW5hYmxlKG12bS0+dHpfZGV2aWNlLnR6b25lKTsN
Cj4gPiAtwqDCoMKgwqDCoMKgwqBpZiAocmV0KSB7DQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoElXTF9ERUJVR19URU1QKG12bSwgIkZhaWxlZCB0byBlbmFibGUgdGhlcm1hbA0K
PiA+IHpvbmVcbiIpOw0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0aGVybWFs
X3pvbmVfZGV2aWNlX3VucmVnaXN0ZXIobXZtLQ0KPiA+ID50el9kZXZpY2UudHpvbmUpOw0KPiA+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm47DQo+ID4gLcKgwqDCoMKgwqDC
oMKgfQ0KPiA+IC0NCj4gPiDCoMKgwqDCoMKgwqDCoMKgLyogMCBpcyBhIHZhbGlkIHRlbXBlcmF0
dXJlLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgKiBzbyBpbml0aWFsaXplIHRoZSBhcnJheSB3aXRo
IFMxNl9NSU4gd2hpY2ggaW52YWxpZA0KPiA+IHRlbXBlcmF0dXJlDQo+ID4gwqDCoMKgwqDCoMKg
wqDCoCAqLw0KPiA+IC0tDQo+ID4gMi40MS4wDQo+ID4gDQo+ID4gDQo+IA0KDQo=
