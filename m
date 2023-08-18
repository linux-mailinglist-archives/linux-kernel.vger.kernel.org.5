Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDB7780393
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357141AbjHRB4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357155AbjHRB4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:56:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5C92D58
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692323778; x=1723859778;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hPvGhcoF5IkwNWfT9heK3Y4m52I0NPkVifm3nYqbFRE=;
  b=e3/MgV3rHCTx/HgEORyReT9YwvRIAl7j9WDHPx5HEIG/NdI01upLRDFg
   JDk4pBxnIs7xtVozaUMcX9NSy9ctWReTq3meaH/TTGPXiyFPNG4vdomGA
   QiFGyfdBGayuYPMtoppnWC0M2eDU731csgk6HLAf49i82/fYz8xIUZShp
   S1Aaq+jDhatpjskhkuWygwTCALybjBAnWw0bsyPpTd9xEf8ywP3wianBs
   qcbg/OAUjU/cxURiquEFFtpltS8b5bdoRZmEPi9iFBNuNWWiKs2Xlsbeg
   NxQ0WyceaOAGsPFbdo03IxKdLcv6OIGYncAUpL76wlx+Dx0ywrYDOzlky
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="352575068"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="352575068"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 18:56:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="1065546676"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="1065546676"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2023 18:56:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 18:56:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 18:56:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 18:56:11 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 18:56:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBVhkmSeuu/AOeXP8B/J3tMWVUtVmfi1iVGaaaDnbb4nSrWc+NObfhtnFBpTBhEI7HkWCgCC974LOutb5aFHRXMPjvEu3SUEqe87qZomtUYCieieYeXsDXUcR1z4QZR0I2G5Ctmt2YrVMAxapa2FCLJ61qXo57kXdgi+Yn5H9PeCWGP615Z8m1e2Fk1Rm3vyA261HLc9LZ2PJFoBEw7x5QM9/MWLgQhojZTYhs6Lv8Wua6wCcT66HMCZfHAxdvTg7AL8a5Z1SyRbD9H9R3V0f16dvSounY4dByv4GWpNkLyil1s9TkdhtsuXt3pRmr+hQxht9kO7T+fNKmODpG3Mhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPvGhcoF5IkwNWfT9heK3Y4m52I0NPkVifm3nYqbFRE=;
 b=INGEH0vHZnImJTiz+fQxqAQq8+pRxYqcUzJHwZGasMhFGTrX/8bJu9hj6LcpBdmUv/mZaQN0A361DCFCAKhW+AgqbMCB1m2W4Wtyr2VwS5L2Q0v1lnFPfmDj63Oz9bxaY+IP3RjRB8+QlVy/BUsEK2ftD3R2f50Ruzj099n9cPWhOPtYaqDndj7wKoaH9S44jEfmNxLl+zxChxzY2g9bolr1x0HSqQmgYOkPdNGHHqvt4dd/RtxR5hqY7vnoZzd5qby6JpWB5yFJKkRBXM17SrrbbnYcaGN+oNOqWFzhC5p7dMljedAJh0r8Ps9YtXnTONaU82lva5cTSk7zHWTcYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5673.namprd11.prod.outlook.com (2603:10b6:510:d6::7)
 by DS0PR11MB8761.namprd11.prod.outlook.com (2603:10b6:8:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 01:56:04 +0000
Received: from PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::f0e6:e227:51d6:e0a0]) by PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::f0e6:e227:51d6:e0a0%7]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 01:56:03 +0000
From:   "Lee, Kah Jing" <kah.jing.lee@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ang, Tien Sung" <tien.sung.ang@intel.com>
Subject: RE: [PATCH] drivers: firmware: stratix10-rsu: Fix max_retry counter
 value
Thread-Topic: [PATCH] drivers: firmware: stratix10-rsu: Fix max_retry counter
 value
Thread-Index: AQHZxnTawEYIyKtqmE6GhiAuPD/kAa/dkHSAgBHQpXA=
Date:   Fri, 18 Aug 2023 01:56:03 +0000
Message-ID: <PH0PR11MB567394BD9C528AADC231DC6FCB1BA@PH0PR11MB5673.namprd11.prod.outlook.com>
References: <88b79f4cfe1c28e31b902d2f12b81e431b09e125.1691112823.git.kah.jing.lee@intel.com>
 <711f42de-34d8-c27a-e058-5fa460012a69@kernel.org>
In-Reply-To: <711f42de-34d8-c27a-e058-5fa460012a69@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5673:EE_|DS0PR11MB8761:EE_
x-ms-office365-filtering-correlation-id: 7585ac9d-32d2-4be4-21f4-08db9f8e479b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 82m2EWKKsMF0eD+eVVcPGKCc+JyMDYKz2drD0T7Yv/NEnpFXUyFkiCpobU0K6hfY3K8nQD980TCZGuO5UA9jri1wa/LJzf5ZlFqcnCAPdkg31RqiOrZsRw7GdhMBcsWaWFgUGPG/sCrQd5M0GmVJ9APykEfdxuFsozkA4n73ukKADLkE+WBiovSPGufQS8cj6EqDojkUzwQKLDAn6zrsdlj4IzxjaLEfI7AEjBfn8gVyzpM4smDgIBUWyBPzY4dJYmhCktze/iOvVi5evwTWiGWToiin2JN769VXyTwcHU/i8qgX5FeeUtorsUEQ2hsmTekQCJVMJbLJeazn8K3Qr7ohC9DJtaPz7v7HT7CHCWKjxnO2jVob6q92AKtAeFB8gu0OZtJd7yrsr59sWSDF2cpj6vvr8alDNFt5nzsJwKGnyEGgMA0nI2n+yjrMBy9x3VctbtmXvkUauw3h7j6AU3kdmCGW7EaclxUCLw2xBOzVO8QhzyzT8IfodAczl84Z/wQOyA8exN9CR1nu00BzpLWjEqrFclCdJ6tJ5blIMau0NZa3BMXJJHnCsZPmQmO5IBhJUG5HQxZrLqpUt3attcqYrLSKa7OIoU0KCAcXHGW3nwSYq+M30TViezjzJhE9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(1800799009)(451199024)(186009)(38070700005)(33656002)(71200400001)(6506007)(9686003)(53546011)(7696005)(83380400001)(38100700002)(26005)(122000001)(86362001)(82960400001)(107886003)(55016003)(6916009)(41300700001)(2906002)(316002)(4744005)(66556008)(66476007)(66946007)(54906003)(64756008)(76116006)(66446008)(5660300002)(8676002)(8936002)(4326008)(52536014)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlNtTUhpTmtETEpkcmNWN2Q3VStmbkV2YkRYUThKUkRuVGtISzh6WmJDZ3lo?=
 =?utf-8?B?U3duMmRZeFZDTC9SZ09UYUhWOHJPblhOd0Z2aGxzK0ZFSHROZ1hZTnFZTCtj?=
 =?utf-8?B?NWtOZWhJY3lVRXVLUW00Z3BEWUpJaGphK1NIb2F1Q3VyWVcvR2tQL1J4L09u?=
 =?utf-8?B?NUJDdHFDKzBVdGJqWm0zL1NERXhqNG93dnYrQ3JYOWQ5SUFBZ1hSM29KNENH?=
 =?utf-8?B?RUZLeHU5R2ZEZnpSTkZCRmRqVjhyaGhZUzc0ZFpJZis4MnY1TDlmeWZCV0ti?=
 =?utf-8?B?ZXZld1ZBUDBxYUtDSUQ4b3dSbUh5RGFWMlc2YTFoSkJELzZUVjAxWExhcVZX?=
 =?utf-8?B?SS9FbjNmSW5kd28xb1lyQzdCbWIyQUJxUml5ZDlKanJXRzIrcTlXVGtmRkov?=
 =?utf-8?B?ZVhlY3ZFdlhtSkpBMllKSUdmWXNQWnV6KzVXejFueDV1bHdHcTlLZFBWSVVi?=
 =?utf-8?B?eHpIbXd5Rm53U3g0cUQwK0k0SXJHQmx4VG5DcUJ0N084dEVkTlZkWkMvemFj?=
 =?utf-8?B?S2ROUDlPWnVPSzNkS1JrTzBFRjFIVURtalJTYWJIdUovbXlqUmZjM0ZiNHp4?=
 =?utf-8?B?bUhSb0pIRnNDTFpnb2psQVFoWC9RZVUxZEp3M0hrN3FrVTdoSU9hTGlFMnlU?=
 =?utf-8?B?aldoZ0g0UjlXZXhUcHdHOHRpdC8wLzM4cVJDUC8vY1B6dmZ3K09NcG1ENzBv?=
 =?utf-8?B?UGhKV3pWU3FjMXhBWGo5aThDbVUvcURNbEQzOFp3S3FIT0Y4ZUU2cmVaTW1V?=
 =?utf-8?B?ZWhnSmg1VWtqTmJYeHN3SW1xbWtDUjNPWDV3UzN2YVdyODI4SkdQQUlwZm9J?=
 =?utf-8?B?dnkyNVRLanJKM0ZMMVVMTy8ySVorSnpHb3VaankrTHAxakRsZTQ4bjdwU1B3?=
 =?utf-8?B?bDRjbVUwMUdJRVhtRnR4eGMybXhEMVdnQnVFKytyMlNBYVU3MURhMys0ak1i?=
 =?utf-8?B?Zk5xZkNraG40aWNpNlBRQ3Y4Nnk3WnhSTy8zTXU1RXF4cE5Xd01pQnlwN09o?=
 =?utf-8?B?MnJwNkpic3JLYTI0Z09ic0JCMndiWWY5QkE5RmtWSzc3WGkvTWU0NHVOK2s5?=
 =?utf-8?B?TVlnSTdIQ2lPd3lWMlU2MzBNUzlpUEJ1czdUMFZrQStpNXl3MFNrTUFORHY2?=
 =?utf-8?B?Y1R3RTJ6MmlxY1RrYXNDV3N1NXc0MTdrems5eWZKbXJ0VXZUU3BZNktmbUFn?=
 =?utf-8?B?WFBkN1NXWi9XMVVTUnlzNlJFYnE3a3hIejNIQU9Yc1ZGc3NqT0VERGxtSW9G?=
 =?utf-8?B?N1ZYWUJ4UHdsOUJoWnBkaTAwMWlrRmZPZ1JDbUdjLzMxRGk0b1N5Z1NraVlS?=
 =?utf-8?B?NTRtYjdWUmNZTTJPb3dSaUdrR01TTkpKcTZPOFVOQjVFOTJWT1V3TEsvKzJH?=
 =?utf-8?B?TTVpbkk0MHppeC9jeW02MEl4UGkrc3k0Mmg3bHkvR1RpeEV4aEhGSXoraEsy?=
 =?utf-8?B?Tkh6YlVITTdCdmlpUzdmV2xLVWZFZndKYklJd0NJbFNLZnRleHB3VjFFc0ZY?=
 =?utf-8?B?K0tjenVNSTVyR2dnMXNZTFA5dU9DaWRrdnZQSlBKdUtMLzJsdVdlZmRDUUxZ?=
 =?utf-8?B?a0gvMFhjRzVVTEtNazYvQ0pEeWdoTytuSXZhb3dpd2FtcTBIdkVGODBGWjFM?=
 =?utf-8?B?a0lrOWp1a2pub01LbzFFWC9uVnNSaUZ6dFZuM0k2TmhQcVBaMTZsT2F4Q1Vi?=
 =?utf-8?B?MzZuc2lzbFFkRGNrU3RaSmNGVjJBaXRROXNDNVJBZFZDVU1waGNYQ2x3NEpi?=
 =?utf-8?B?TnBNWEdKNmxUbGphSWZNUEtOUDN3WTJ3YzltZGpvMUptTlRqZmpOeTBBVkox?=
 =?utf-8?B?MldlbThRZDdEcGl5aVpXZ0dmYzc5anp6R21Uc2RLSElETDR6d0h2V3c2dW5k?=
 =?utf-8?B?VEtlZlVzRVAwM093UlNXN2kvL3VFVTJXZGx5QUxrdm80Z1JSeDlPWnh4UXhY?=
 =?utf-8?B?OVFMYnlPcE9BU3pGTE5mQlZsb1VuR2R6NVJGM09EcnpIbDBraFpEN0pnaGo3?=
 =?utf-8?B?ZjE3VGIxaGtIYVp2OXZ3V3JpL2JLUUduQURWNldZNWVtTDMzUjdrY253TEFj?=
 =?utf-8?B?c3k3Z0RWbDRRYjFhZkh1dXpaWG5VK24rdG10K1pPOXp6V1BTbFdncTRtUWF3?=
 =?utf-8?Q?AH71KJ2658wfcznZv9dEosjcP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7585ac9d-32d2-4be4-21f4-08db9f8e479b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 01:56:03.8302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mwXshJ87bwtAm/7DruUVCmwfT8T7sZ+ZW5eKz1/k7nxmiMgvjWR/K/guM6JA4WvGcfnHnH48ok9jg4IjnZSlOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8761
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiA4LzMvMjMgMjA6MzUsIGthaC5qaW5nLmxlZUBpbnRlbC5jb20gd3JvdGU6DQo+ID4gRnJv
bTogS2FoIEppbmcgTGVlIDxrYWguamluZy5sZWVAaW50ZWwuY29tPg0KPiA+DQo+ID4gRml4IHRo
ZSBtYXhfcmV0cnkgdmFsdWUgYmVjYXVzZSB0aGUgdmFsdWUgaXMgdHJ1bmNhdGVkIGF0IHNjbnBy
aW50Zg0KPiA+IGZvcm1hdCBzcGVjaWZpZXIsIHdpdGggYWRkZWQgaGV4IHN5bWJvbCBhbmQgbmV3
bGluZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEthaCBKaW5nIExlZSA8a2FoLmppbmcubGVl
QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZmlybXdhcmUvc3RyYXRpeDEwLXJz
dS5jIHwgMyArLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL3N0cmF0aXgx
MC1yc3UuYw0KPiA+IGIvZHJpdmVycy9maXJtd2FyZS9zdHJhdGl4MTAtcnN1LmMNCj4gPiBpbmRl
eCBlNTFjOTVmOGQ0NDUuLjk4ZWMzOWY2ZGFlOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Zp
cm13YXJlL3N0cmF0aXgxMC1yc3UuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUvc3RyYXRp
eDEwLXJzdS5jDQo+ID4gQEAgLTQwNSw4ICs0MDUsNyBAQCBzdGF0aWMgc3NpemVfdCBtYXhfcmV0
cnlfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gICAJaWYgKCFwcml2KQ0KPiA+ICAgCQly
ZXR1cm4gLUVOT0RFVjsNCj4gPg0KPiA+IC0JcmV0dXJuIHNjbnByaW50ZihidWYsIHNpemVvZihw
cml2LT5tYXhfcmV0cnkpLA0KPiA+IC0JCQkgIjB4JTA4eFxuIiwgcHJpdi0+bWF4X3JldHJ5KTsN
Cj4gPiArCXJldHVybiBzY25wcmludGYoYnVmLCBQQUdFX1NJWkUsICIweCUwOHhcbiIsIHByaXYt
Pm1heF9yZXRyeSk7DQo+ID4gICB9DQo+ID4NCj4gDQo+IFRoaXMgd291bGQgYmUgYSBnb29kIHRp
bWUgdG8gc3dpdGNoIG92ZXIgdG8gdXNlIHN5c2ZzX2VtaXQoKQ0KTGV0IG1lIHVwZGF0ZSBhbmQg
c2VuZCBpbiB2Mi4NClRoYW5rcy4NCj4gDQo+IERpbmgNCg==
