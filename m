Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B5D813959
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjLNSDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjLNSD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:03:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007C4A6;
        Thu, 14 Dec 2023 10:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702577015; x=1734113015;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ClHfFN+YrhDKbhyevEBnFH9k3xzGdCVQPIHYkP7//KY=;
  b=PPaHNLuT2BH+NHFgN3CpRkhy4LVYOOEI0VvzOk4dT66HExaFtWIZbRDa
   NaYnRmzn1mrEOCMoxZa1anOKnbdFDq1e68/0JZc/aMUJqBadNFbldSuxZ
   rnLbsiLeCmm6S1S/CGL7cdIH7c2v7PMS6zLGwFiP9J9hJTCzyY9iIyUce
   AVjYAYTrcyD4WTmuM/VPFndL5ZlAamL4Eyq/kU/fwIk2CclDx5oD8rXRM
   DPHdTiVKeemMv7cC2I/GvdwMnsnvcZFV8brB6pE31Axec9OK/dDFp+nsK
   aBl4Q69EQ9k+B4lmBxLbPvmFnlk3xWdb7yqaX+Tm3eBuhMqeyjtIZ+r/B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="459481393"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="459481393"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 10:03:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="844803911"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="844803911"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 10:03:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 10:03:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 10:03:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 10:03:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJteLwfwUOeAeAr+8f1FH1rIcLMGMorJO9fhHqUeCwMEiZKcY9Ib1f1bcBm7VHgr+84qGubBcKvCCfV9m2UnTcUrNyolC4d4hG/o0lcduv/K0cdchspG+FLM+/kxomu4x4GWh2CBaZvZzjUR0yp68gwoS0/TYEHihIJAyn7BTiyqhB+9U2KIzi3l/wfVUJmMGYZz2cBIXUKEAJ+pLf80FMzoEFX2Ctftnk6CKXT4MEpmmWwWimu7P6n7FG5Okn1ZQPLljduxgZ2FjwvJKlUNZLTTvJCL4+Lblo+4qHYqeJzjXiAfDPc+czQFUYdk4h9uZfFRyvvguQoLASE73FT1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClHfFN+YrhDKbhyevEBnFH9k3xzGdCVQPIHYkP7//KY=;
 b=XUlvmAwEAprjIJxDf9YLhHioZlRkkoaXG9AuEbdjt7/OuOCyukHUua6k5OJN3rlQ4JLVBLz7l5EmNAu+DVzAA7T2xy6yD1IWWIZKwpS+uxhTRm6GJs/Xwms9uZRJnAscEAswvaTI60/LcI1YdO8SL7IwS+6YXkNSklWkcNipSWuet+b4aQc1pGS5OXo3Ak3H93ksY4I12wHjaX55Rxj0r/c2nRZEHV2TLe2sqRaHNYGIvbKlrYoxRYMYWgijSn2oG/XMdPNJ3vqpzHKOcnSsBchs2Wi326iogZFthUzxrLfLDwWUGVJ1plvREsE/snTZbsbGFwqRo8NutD950A7ZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH0PR11MB5708.namprd11.prod.outlook.com (2603:10b6:610:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 18:03:30 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%6]) with mapi id 15.20.7068.038; Thu, 14 Dec 2023
 18:03:29 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Thread-Topic: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Thread-Index: AQHZ9vG7TU6w8G+TdkO4n2sYy/mmYrBRT2CAgCki9lqACoMBKYAkerA0gAARZJA=
Date:   Thu, 14 Dec 2023 18:03:29 +0000
Message-ID: <SJ1PR11MB60835BC38ECD8F1CC382100FFC8CA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231004183623.17067-1-tony.luck@intel.com>
 <20231004183623.17067-3-tony.luck@intel.com>
 <20231019151211.GHZTFHS3osBIL1IJbF@fat_crate.local>
 <ZTa37L2nlnbok8dz@agluck-desk3>
 <20231114192324.GAZVPJLGZmfJBS181/@fat_crate.local>
 <ZVPu/hX9b7lUkrBY@agluck-desk3>
 <20231121115448.GCZVyaiNkNvb4t2NxB@fat_crate.local>
 <ZWTzAujHdrJ950F3@agluck-desk3> <ZWT4pAJ6g0i78wec@agluck-desk3>
 <ZWU3WkmUMz3Wk9wT@agluck-desk3>
 <20231214165846.GOZXs0RqkbpovdQWKH@fat_crate.local>
In-Reply-To: <20231214165846.GOZXs0RqkbpovdQWKH@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH0PR11MB5708:EE_
x-ms-office365-filtering-correlation-id: 61a9ea0a-45d8-4c6e-f83c-08dbfccefa7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FPE0D9QCyI/mfY9Y2XIaE0f3cLRYmSMjPHnvue8YcKPKgOOgBRiCoTwoKhHLOVivbQZxM92LUi1eAPnRmjj629cd0ZFJXspOfJGdjhAb4pN1/SyjQhcd6AE7bMRSuWw1zn+NJpUdYGRQo5xtIzOtgke9CgoVhsQxGHI9dFqGH2IDugzxlT45wcGpikhaEvBs6DUB3OghCkDCTSHMGPgDZw8JAcyDcmYdya1luzmaqkrt4wp2Qdk66oPpAwhkcZAP6pTUG7wCEgd5q3dOKySuJZoMD0+Yj8kMGXSDzKX+eVK3tlwgUsUghj+AACp2OcN/ZCKsWKZqbtgCowmdmkDfd95TVKTi1YMl0DsI4yKwMR2w4+6pP2Clf6NTys5JCFnKba7Cs+0oJJu8S+TOIXtNiKLXAVVL/gXSO5APxgXv+408UF4PG+n8evXO6Hqaq5fYtcG2nOnobsZlbZHgr/LXjFlACnm7dWognaGvd8Cj/KGuLXpr+erT84S/rRKUer28bA7ac0UPeLGaSMGxpgz6f5zMX8tHqKVMBR4QDD1vvtnAJUf4JMLezg7ghwpaQseeny/f/tG3eiwZsamZWwfUKsHHIuXHImVFgHExbtOFUU1KBui5guVk0AjZZw/4yisV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(71200400001)(478600001)(55016003)(122000001)(82960400001)(4744005)(38100700002)(26005)(83380400001)(9686003)(6506007)(7696005)(5660300002)(2906002)(8676002)(33656002)(41300700001)(15650500001)(38070700009)(8936002)(4326008)(86362001)(52536014)(6916009)(54906003)(66556008)(64756008)(316002)(66446008)(66946007)(66476007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHJxZzI0Nkh2NUZONXpRazdJaDFZUXE1TUtVemg0YTBSOFRoTi9DL2swMVpO?=
 =?utf-8?B?WUhHdG1YVEY1TXo2WG0wbFl6NHA1TjJwa1hUNm1Yc1N5dTJoQnVORmtOa3Mr?=
 =?utf-8?B?c2pCUmFENGNyOFNUOFVybmJjSENzYS9tT09BNVVFVUdHMFNFUnN6WmU5Wm9D?=
 =?utf-8?B?RkFXN0lUaVp3Y3N0MHplMkpaY1dSV01EWkpSRTJ1N1lOOW5UYXdTdFZ4OWFE?=
 =?utf-8?B?a0kwOXQzK200R1JXTTBucTdlMkhrK3YvWVBwVFhxQ3JnV3h1dW9mNEFlS0hH?=
 =?utf-8?B?eDlEQXdJZTZaYUlidXdKT0lHSFE0b1NaWm90Vm1aeFJaK2EvUjJ4SjU2bG9V?=
 =?utf-8?B?MmRhbHp0elkxa2xjdXZNaW5ZTjRSMzBkbUkrakxBdi9IQWxRQ3BnME9zckVM?=
 =?utf-8?B?WnprazVNaHpmQ2tFQXlHZmRuZlVNUUVWeG9FR2Y4T1VOL2YrM3Q3UWpMckRE?=
 =?utf-8?B?dVR2WHpFWjNFTmNOOUZuZWVWS2V0QTA3aXVaVlBvak9rTFo4RDBmTXVSQmg5?=
 =?utf-8?B?YTRkNlorQjhWWVZCZHk2dE5nVXBwUFFCOWVHMEZYWmc4NHdHL3JGR1pPQ2Rz?=
 =?utf-8?B?b1JYVjE3NkZvSmlpR0xxL3FWV2xJSWltRDlwSjdkcUNhY3ZWY3R2bUxyR1d2?=
 =?utf-8?B?Q1dqRDR3ZDJGa1h1UU1rbHp2S01RQ3c1cmlGWXJmVlNyV3BNRVlkVG44Nkc5?=
 =?utf-8?B?NjQ1Ui9rZHRQUzJROGNoeThYQnltb0VNUUNBOE5sWGVYNC9yOGNuY29vWVpY?=
 =?utf-8?B?KzBVcHVJajV4TjV6V0RqejFuZG12eWJOQUJST0dQbmtIb3YvUXVOcmF1bndW?=
 =?utf-8?B?YlV6MWNMRitFV0F6ZGRjS3lwNm5pWFdoTFZIVTdsb2VsRTJ3ZCtGaTA0RjdN?=
 =?utf-8?B?ekRmS1BEeVBkbUdtT2Z4UmZXMTh1NkZJNHJCMjJvK3VyM1BZRmM5UTNLUFR2?=
 =?utf-8?B?U2tINFJJKzl2VjJRRmNRTlFCN2FLZ2VSdTFVREhseWg1dnJUVE1LelFBcjdD?=
 =?utf-8?B?aGgyUFgwcHFxOVh6bHZwS2VkMjJWbEJFSnFubDFEWTNFdFJmZGtYS0hic0w0?=
 =?utf-8?B?MnIxZnp3UlZtemdVS0p0UWhsME1WcUxjdGZranJOV3RURXdBRU80SEV4d054?=
 =?utf-8?B?cDdRSWJ4dFBJWkdFSzNQd1FTa1l2dk5kVnZaTzJSckVzcUNJck1HbmhOUDB6?=
 =?utf-8?B?Q3BYKzNlbjQrOXlIMlkxSHZjbEtxVjdzc09HWkZQSFE0TCtzK1lleWU5ODlB?=
 =?utf-8?B?TmE2ME15V0U2L0h1dUFvNUc1emhYalB5NkM4alljV0Nhc2gvcmt4S3pVdGJE?=
 =?utf-8?B?RHk4V0ZCeWgrcnJqN1FMSDNpWUc5ZlN3NmR0RlVTYW1wVXlIZ0pDVlZQLzlm?=
 =?utf-8?B?NURZTUpjcC9CaEo2YmFxZWVpUUxyRStxRkpKRHJtNmZhbGRTSnJZMkxnM2Zw?=
 =?utf-8?B?em9NbCtRck5sd05nSS9weEsyeWpFb2FRd3IxMHNSQnkyYWc5K2JHYWR3TFFQ?=
 =?utf-8?B?UXh4elA4U1ByNVBRTnRZQ2REM0ExSlFPaFF0clZiZjMzZUxRaXZwbHJkeFlh?=
 =?utf-8?B?OXE2L2E4RkI3VUtwd3g0SzBDMWhKYU1qNEcrckFpaGo3dzVMRHN3ZFRLejhV?=
 =?utf-8?B?RHJQQWdvOU1sQm12anBCL3E4c3RDRG1zbDIwa3F0Yi9uVDRXeExLY3ZUQVh4?=
 =?utf-8?B?ZjVRVGpZaC95RURIcUJVaUk0MVg1SENVNUVIWXNvVFpnWkJrZWNsUW1ENHFK?=
 =?utf-8?B?R0FDOURsMW5udVRJVnc5NzJIRkJXdjdjK2tVSjdSQ211cnB5SzQ0dktpV01U?=
 =?utf-8?B?cFc4U3ZKbG9uT0R6YURZYnUzbDRnVDhqTHlERWpMek5VTmpSaFA2RUs4cjZt?=
 =?utf-8?B?V3RzTUs5SlJ2eW1FOGhiOFhnUzdCd1JUS0ZvcVJGNUl3bkNEK2tDMkNwSFNO?=
 =?utf-8?B?bVVuNGxGTXNSZEN4MmpNeUtGUW1PNmlHTnJ2SVM1emdPakM1SSthTjRSZ2xP?=
 =?utf-8?B?bERpQWxQcUdDTVpjSVNSWTdxN1NqaVRnRFZzQVhrWkdISGhpdWRpYjhlTi92?=
 =?utf-8?B?MXV0TWxxOGxFclg3WHFFZHdFOUM5MHE1c0NERkVOSVA4S3hpMlRsV1BLdFZr?=
 =?utf-8?Q?Z0dhuKlA9c6b/ZV6pb0gyKNOt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a9ea0a-45d8-4c6e-f83c-08dbfccefa7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 18:03:29.8696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T8tfMwz/6lKz2h9pKJeufqj0gQshd8FP+wnkJlwv5hanacqovjbvmYirXPFxLxn4UiImr1z8r4uomI1F1Vg0vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5708
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

PiBhbmQgeW91J3JlIHNheWluZw0KPg0KPgltY2VfcG9sbF9iYW5rcyBhbmQgbWNlX2JhbmtzX293
bmVkDQo+DQo+IGFyZSBkaXNqb2ludC4NCj4NCj4gVGhhdCdzIHdoYXQgeW91IG1lYW4sIHJpZ2h0
Pw0KDQpZZXMuIEEgYmFuayBpcyBvbmUgb3IgdGhlIG90aGVyIGJpdG1hcCwgYnV0IG5vdCBib3Ro
Lg0KDQo+IEJlY2F1c2UgaWYgc28sIHllcywgdGhhdCBtYWtlcyBzZW5zZS4gSWYgdGhlIHNldHMg
b2YgTUNBIGJhbmtzIHBvbGxlZA0KPiBhbmQgaGFuZGxlZCBpbiB0aGUgdGhyZXNob2xkaW5nIGlu
dGVycnVwdCBhcmUgZGlzam9pbnQsIHdlIHNob3VsZCBiZSBvay4NCg0KWWVzLg0KDQotVG9ueQ0K
