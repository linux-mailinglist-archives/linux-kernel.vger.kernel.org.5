Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E4576DF28
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjHCDwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjHCDws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:52:48 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1362A30C7;
        Wed,  2 Aug 2023 20:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691034768; x=1722570768;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8ReHXk6bu1ceDYzKoBFCC9qXv0liuNV9Is5wajRM4tc=;
  b=hDGeEx5cDDg+buBDHp1doKe4iP9TF9KZYLogMj/Z3YztVQ9t42Fparls
   pV27UZB2234VVx1WTu3ImujNVS4+Pu44I3XRP7j7CVMhMf5lmewnEQpB+
   /eNUvtWPozIsgMK9R3zNaQXnI5QpYrdEJh7NcuP1gC/SGsKCkUcqm3V8O
   tql/xxMVvIcFoYNBzXu4i4YcL8MsOQiDMhr/evFYcLBihdY9ZbdhXj6lV
   pwV5TNdj9fJTOfZl2FKWPSQpH0O50pnHDHocoOvPy8tyNXXv3cTtr2yKf
   be9q6ZD4VixAevH2CoBpxFMGWIuQ2ZU2bFrDkEYyQNH2IXGu1QvEyd61T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="349359217"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="349359217"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 20:51:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="872763795"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2023 20:51:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 20:51:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 20:51:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 20:51:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqCBaGOEk+4Xtxk35dAWtwkN7Ktvbnu90uF4WkwG++5APtBNwujPskMjtnRql/A+7rPn9jtpK0OaJXSV92H64unNQ0P0IypMmHhq4LARiSsVS8jQ4ZN8IfoA59+jYeL0w52l34b4PE88EcAJmJM/e1m3Yj7g41HDZ6fV4fXIqLejQWoyy7PwhN3k34AT81UNu5USXXbg4Ieo5XGTBRLFuc5NF9ri5gEJBJHJ+faS7rt4BTE5DdQBuI/Kia4dzHVwLVY90HHFkPCgrCkQw+GYAVzJVkzozc+8WGszkcRgXjFD3b0iCzBQEPm2QdjtA7/XUYJmT5UirrmIcNof17pv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ReHXk6bu1ceDYzKoBFCC9qXv0liuNV9Is5wajRM4tc=;
 b=IEpSRtCXh1sG2nHzUmrHZObThB4JP/D/wPnl/t++ZajXvKQyAdhPOZS9v9BQldQops0HK0/E5mb23jLKAsG4vlPnajCoK8HT714DRN8l+iSVw89AYheMRTFHbarp/bkdVJdmlRBjnghvz7zdUb2we2SyQShKz7uygggW0TiuOVMpPvUvj6/XwpllTRBBogSU9P81SPTTUaC7xFPFIfsgDM9m4p3WmQvIK/kVmEwHAOUv37lTQQ5URiYJcR40/NNirSzcaxjCLAbd5edWAyZo3q6tLAmv+rHrwJpt2ERYLfrSOX4iA/qFmBqpKRYg9KzU95QMksLYSonSOXAkjSq3ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB6699.namprd11.prod.outlook.com (2603:10b6:510:1ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 03:51:39 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 03:51:36 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 1/5] selftests/sgx: Fix uninitialized pointer dereference
 in error path.
Thread-Topic: [PATCH 1/5] selftests/sgx: Fix uninitialized pointer dereference
 in error path.
Thread-Index: AQHZvlAr0s4WmgGnVUa2f6piGTBidK/X/vQA
Date:   Thu, 3 Aug 2023 03:51:36 +0000
Message-ID: <30cdc29283a6ed6ece205d9a91f44b44b2b3a73c.camel@intel.com>
References: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
         <20230724165832.15797-2-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230724165832.15797-2-jo.vanbulck@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB6699:EE_
x-ms-office365-filtering-correlation-id: b17ec66a-31ce-4c79-1cba-08db93d4ef7d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +TLczrPR/jLKEE5iWjQITf8fLPz6TjW4Hdv9tbPgFEUQQNOsEAUpAof5IbsDWiRbFImA/23LdUI/Me3s0c66CBoA/nDPi4h5ELHcor0e6aZO7JhU17PTSJzf3Byx0CW6YRyrgIkZqlprZrRM0TIXQvCesVuBPj9tEbZEAp7LHAkfFo7cCD8MZMd02dVR7oDkmSQA5JeTvpubLhOULSXhbvfqYMo4fiz3bS1t8zYoC2JeQBSIf6mF+omWA+XaUSiO8J+Z1ciQ0oIOeLirzRgtiOpxs8X/2In7pTOzL5GHhoOyJNKQlPb9Nnlp0/49pQ2jyfQD+oZbaFWIRm4akfq2hu96JmO4AP8t7wNOgyLKM7Z/X3eWTM4841Kf6goSdbUVhyoz9iq7RBthjy8/++h82KWPqt5zLI96JOpvVY5wvY3TVPdBaGU0Kl4HCuatAx0WtuXR3UW0ZT84UiX72e81FSCJMPQEN1ob4LFzIEKMu9JIZlXUX1EabnO+BZgkf2VVKrZsLcl/Z1XH2tMMXLRWMVyVGXMurJCRwFu/vUsgVQugdREEWBYOB5II/sLClZ7BdLVlZkXeM+afyvGa0lhMMw2SC24Zucaj/NCIIZo+T+YK5jh8WdKEuVKS8tZGGPSf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66946007)(64756008)(86362001)(66446008)(66476007)(66556008)(6486002)(71200400001)(91956017)(76116006)(6512007)(2906002)(4326008)(110136005)(36756003)(478600001)(83380400001)(38100700002)(41300700001)(122000001)(2616005)(82960400001)(5660300002)(8676002)(8936002)(26005)(38070700005)(6506007)(186003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUZlRjBVbmwwRlZLb3dxMGRDZXNoY1BIK3JUemh3dDBIZU1MN25NRFB3dDNO?=
 =?utf-8?B?NlF2MmY2cFFheUdnSVhuK0IzaS9UMDJadExXU3F2WXZNRG95QWwwYlRrZG9I?=
 =?utf-8?B?d1ZqbjRPc21MZXRnYmUzbThjbjE4eUNlNnNFbTNwOXY5K2kwRmhWWnlUOTI3?=
 =?utf-8?B?N0lMVVUvVkRDMVdPNmNwbzdtWkJPaGVtSG1ma29ONXB2QUNtdTBORHk4b3Vw?=
 =?utf-8?B?SDgzOGhEUkRXTU9oTW1mNUxzdklHOVBuR2t1RzJ1alZ3LzFkdjBzYzBxWWhV?=
 =?utf-8?B?b1VxN3NWZ3hGc0RBbEY3SWx0Ui9WRU9SYWI1Q3NySW1KSkluZjl4RVNsVTRo?=
 =?utf-8?B?MWNBSFpyT0F3MG5JamJnaXhEb1QvalJNQm9vT1BJazlHOERDdUc2VU9SN2hN?=
 =?utf-8?B?ZGpURzRwdGhuMWZnSnhTMWpwOHcvR0h1YmVtQi9BbjQ0OFFvTUg1Snc4bmUz?=
 =?utf-8?B?ZExiR3E3ME1QVnJxTGd2L1RuTkI0eTlJcDVBanZXc0k0Smk1NGtrMVBqeFUx?=
 =?utf-8?B?NnBCRlY3cVNkUnh6NWdRTzY0R0dxNW9MLzVvb1FhN0tCbDYvQ2xmOHMyQWUw?=
 =?utf-8?B?bHUvREc4Smc2Y0FXd0dOWDdydDM5NmdJNWJhMnpSWk5FTkU2bllGUFFRck41?=
 =?utf-8?B?dFI2VGltSUVrTWo2d0Q3d1BhLzFjbTV2Nm1sR2lwWlV3S1BQVnpaTklUU1Z0?=
 =?utf-8?B?WVJlWXQyUzA2bnViV2IwQXFiLzM0Z2dlTVBsMXdveldxUmlwTTVkOXJMcVZR?=
 =?utf-8?B?T1VDeVMrUU5BQXF4aTdiU29DcWt5N0VjUTFKRVFRVms2ZDRRVU9ZR1p2cU9z?=
 =?utf-8?B?cWxaaFJUK3pNQks2NkQrTnVycjlTbDcreTBNMytKYW9CQ0xRRDBMOTRnOHAv?=
 =?utf-8?B?K21wZ2hPUFZhbHRIbDNQQS9YQVZIZXY0RXkwcDFRSmtRcllWaDRyendMdU1l?=
 =?utf-8?B?NDA3Nk5qeEZSakV3OUFGc1hJNHBhbUVuTlRQYXZYQ0ZhU1hEL252d1Q1dkJm?=
 =?utf-8?B?cnFsdzlvRDl5TEovLytaNGNmMWFUaEhIc1dIZkhlbXNGLzJhYjlJam1WOGJY?=
 =?utf-8?B?cHhZTHZlUUhUY2x0a1hWdi9vOVRSR0VrV0FERUw5eTNrY3VGUGlQMENONUJa?=
 =?utf-8?B?d2hXWENlY0w3YkUrTDdaeEFXSE5mVk5vYjNNTmhFNnZiMUVnYkRnUkdrZ1FW?=
 =?utf-8?B?N2tSRmxRZWE4QTZMaXF2ZkhlaGppMDBwZFQ3UUdTZlJMQ2RsNmdMSEF0SFJ1?=
 =?utf-8?B?Q0lsU3Q4dG14SDBaUjVzZEtBMFFMV1pYRHNYM1RjbnNHRStWbjdGcEZHZmFV?=
 =?utf-8?B?M3MxeUJrQnliZXJRN1pPZk9Qc1N0WDNwZG1GN01xOExoZ2ptNmZMWnNJbFJZ?=
 =?utf-8?B?RGlMaDd2VnlmQ2JGcGxqeEx2WFEzRUNtMERKSG0xNzdLK1U5Rk03MmlDMW40?=
 =?utf-8?B?VEhaRHBZeDJvY0pGTDNSZGtWMFJ3UFpaQ25OaUROVC9KNXZWNXdxaDRSVlJF?=
 =?utf-8?B?Y2RzRDZxMGdqUTJ1b25ZY3N4bjRUWmlNS1VsakhrVkl1NzR1ZzJ5dW5xdUxj?=
 =?utf-8?B?cnR5ZFIyTXZtU3ZFb0dFT1UySWNDTmhJNHNRbkk4ZG55N09CWUdtc1FNZVdV?=
 =?utf-8?B?eHJ2b1R0WEsrZDNGRWhqcmNHNG1EVm52emoxRlhUNkNIa2MwUVpPaStuZm1Z?=
 =?utf-8?B?bzd6Ri92dk5HRURxQ0l1ZmFXQTVRQ2FRMXZOOVY2bDd2YjNTMjRORm9WNlZs?=
 =?utf-8?B?dlJVTXB6VzkwYzcyTlhZa0J2ZmdZR2MzKy9tVVl0OUZxUE9PQjZkWktDdWds?=
 =?utf-8?B?RlNiaFRHcnlpbVlVcnlwbHd1VDFYNzBjTWg1RFdHVkFSakNTTzVPOUZSVkxk?=
 =?utf-8?B?VDhZMWh3SjNtTWtKYUJwRzFVSUtRWk1EdnR1aFpHQ3VwcVdCWGlpd2NBekg5?=
 =?utf-8?B?bjZmT0l6U3JXdmwvZFpVa2F5cmx0dmZXVmhzQWJLZ1U0WEVlbGl6QWxOVnMy?=
 =?utf-8?B?Mkt5Q3llZUlRWDVrbHVZclpZdWtOVHZsTkpvS1BDRlJRNnhwUHN4YXRpdity?=
 =?utf-8?B?SXUrSnBlaDV3MXhPbi9xSFdzSThzSmVkN0FyenhPWnkvSExxUnZwQjdTNXgv?=
 =?utf-8?Q?yGX6u6blDpYu2Oa0cTWU3eQjU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1ECFEB3911217A4A9E63D6FE5AAFF589@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17ec66a-31ce-4c79-1cba-08db93d4ef7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 03:51:36.3239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kxXb8tnvuE1kYLAaMHrZIDBSc9v3OOgz9uQ9IEVuzo1BGvScvj03yahU3nJm9gb/uC8/bY8ey0g8Md/QKa9Exw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6699
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTI0IGF0IDE4OjU4ICswMjAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IEVuc3VyZSBjdHggaXMgemVyby1pbml0aWFsaXplZCwgc3VjaCB0aGF0IHRoZSBlbmNsX21lYXN1
cmUgZnVuY3Rpb24gd2lsbA0KPiBub3QgY2FsbCBFVlBfTURfQ1RYX2Rlc3Ryb3kgd2l0aCBhbiB1
bmluaXRpYWxpemVkIGN0eCBwb2ludGVyIGluIGNhc2Ugb2YgYW4NCj4gZWFybHkgZXJyb3IgZHVy
aW5nIGtleSBnZW5lcmF0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm8gVmFuIEJ1bGNrIDxq
by52YW5idWxja0Bjcy5rdWxldXZlbi5iZT4NCj4gLS0tDQo+ICB0b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9zZ3gvc2lnc3RydWN0LmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9zZ3gvc2lnc3RydWN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvc2ln
c3RydWN0LmMNCj4gaW5kZXggYTA3ODk2YTQ2MzY0Li5kZDFmZGFiOTBlMjYgMTAwNjQ0DQo+IC0t
LSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC9zaWdzdHJ1Y3QuYw0KPiArKysgYi90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvc2lnc3RydWN0LmMNCj4gQEAgLTMxOCw5ICszMTgsOSBA
QCBib29sIGVuY2xfbWVhc3VyZShzdHJ1Y3QgZW5jbCAqZW5jbCkNCj4gIAlzdHJ1Y3Qgc2d4X3Np
Z3N0cnVjdCAqc2lnc3RydWN0ID0gJmVuY2wtPnNpZ3N0cnVjdDsNCj4gIAlzdHJ1Y3Qgc2d4X3Np
Z3N0cnVjdF9wYXlsb2FkIHBheWxvYWQ7DQo+ICAJdWludDhfdCBkaWdlc3RbU0hBMjU2X0RJR0VT
VF9MRU5HVEhdOw0KPiArCUVWUF9NRF9DVFggKmN0eCA9IE5VTEw7DQo+ICAJdW5zaWduZWQgaW50
IHNpZ2xlbjsNCj4gIAlSU0EgKmtleSA9IE5VTEw7DQo+IC0JRVZQX01EX0NUWCAqY3R4Ow0KPiAg
CWludCBpOw0KPiAgDQo+ICAJbWVtc2V0KHNpZ3N0cnVjdCwgMCwgc2l6ZW9mKCpzaWdzdHJ1Y3Qp
KTsNCg0KSXMgaXQgc2FmZSB0byBhc3N1bWUgRVZQX01EX0NUWF9kZXN0cm95KCkgY2FuIGFsd2F5
cyBoYW5kbGUgYSBOVUxMIGN0eD8NCg0KVGhlIG1hbnBhZ2Ugc2F5czoNCg0KRVZQX01EX0NUWF9k
ZXN0cm95KCkgY2xlYW5zIHVwIGRpZ2VzdCBjb250ZXh0IGN0eCBhbmQgZnJlZXMgdXAgdGhlIHNw
YWNlDQphbGxvY2F0ZWQgdG8gaXQsIGl0IHNob3VsZCBiZSBjYWxsZWQgb25seSBvbiBhIGNvbnRl
eHQgY3JlYXRlZCB1c2luZw0KRVZQX01EX0NUWF9jcmVhdGUoKS4NCg==
