Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1459576DF2E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjHCD6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHCD6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:58:22 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A75128;
        Wed,  2 Aug 2023 20:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691035101; x=1722571101;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=phpiiPOtfRKuitQ2KlfeVmV4N5MATBciyAP08vinE60=;
  b=l9dTAOjpNvzdYPqMudKyT7qZZZyD701YpmENd74qwhCMXBCAmjPul8zi
   qY9pcESNfZd9zA5Fp7OlORSsaOyi1we5TB+glcn7tQVqhAqyfmcA54rag
   hvaRUbZCdr9KAZemVd1XsaHZQ/slJ8givG0dEb0v00RnD7g5fnmiQIKMD
   xUSLOrqLkpQ5HapNVJg2SVNYB3ptxvsirpMT79p2561CBZMrnNyOdRGjJ
   +W5H8EkQTNg2oCDtVJ+znK5fVUvvLV6dFZA1xYKDroz/wlZjh9PYTv8Hn
   e/9EVUYbZq00YIDPSt5u2l1xzP7rKfrEMoar+wZdf8C3Jjntl335lb27I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="368662453"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="368662453"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 20:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="758965512"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="758965512"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 02 Aug 2023 20:58:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 20:58:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 20:58:20 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 20:58:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSbTsTnX1EUvLfk4v1AN7T+E7+cGuAUWiAjsQbBOnPn6CK/N4Ub/1N/RH3KrAY3/O1pnNl/bOyenz0oskNv6kuYfUqwanKKbQQKIeckXaKBqMXNzqhWw5i2B8IfbmQceaVeSUuaWj8CGoULAlaxFS42sqg6SS27CSRg1LH6xqySmP7qx7Kx0i8ZQpoKjdv9frHJ60uL7b0lu4MTsJMIO++xB0w/zneMTm85sXbjq+8HPmcrQhNpS4dFAtl1MYfZhxC8rSnXdM7gLrD+87p8CL9+8D2MdxsmXq18dLJPBrXZMCZSg7hspiAbiJuTsABrbhkcrF1bNsjv3Da/PLWkOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phpiiPOtfRKuitQ2KlfeVmV4N5MATBciyAP08vinE60=;
 b=Pe465StOmcNaH/IS2oTwOQKg7XBjm1uD76LtCVVsrMOlG0InTbNGTdIVHaOYKB8CoXIoR6X2iWLyTPb4RO5pHBYF8kTTeTtfcV+GQYpuMbPp0qjr1D16WBI18pmEDsE2BIObcT3wriJ6EGR9ocqpYW0Hf0UURGW46TdmG0x6m0bPkWAtga7JcO5GnfzQTDDl2vlpCT+6SGXnl1a0HgSQPR2FWUmmL/TPOu3TJGkrfZDL6lM0+OacJk0drouIdcRqgOMKo4dO7SCnzA2kMhlgS4cfXHLZ2SWYMW9M8MdTyO3u3n0NRG1+dvbE2iOspTxhwJ4TQ3GyX7bDMjE6cG4E1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB6699.namprd11.prod.outlook.com (2603:10b6:510:1ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 03:58:16 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 03:58:16 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 2/5] selftests/sgx: Fix function pointer relocation in
 test enclave.
Thread-Topic: [PATCH 2/5] selftests/sgx: Fix function pointer relocation in
 test enclave.
Thread-Index: AQHZvlAqEIBAuQlfhEOT34Pp/w7z0q/YANMA
Date:   Thu, 3 Aug 2023 03:58:16 +0000
Message-ID: <8266f771d0d34317f1e9b10a3ac6a6e2e8c156d4.camel@intel.com>
References: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
         <20230724165832.15797-3-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230724165832.15797-3-jo.vanbulck@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB6699:EE_
x-ms-office365-filtering-correlation-id: 5dd2da90-5bc6-4faf-f470-08db93d5de0e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fGwPsFhFn/ivLzUT1YQGEFLHtkXW5VhBVfa60ypnvN8YBxOZl/R9laZ93NhBHse5tq0WtjkDjyCEuBpiqIwdABKLUSisJFBLft0wMd2orSB8vStXwHXVKTfipLjopfusOc828qGLzWeZZrgjEt8dlOljClm/fTw6htl9woBWN7r4Pt5tgkpjb4F7dN1PZiHNoypEJDVM1emW3fjlK0/VGaO4a4N3dO/JfY93frVmk3W96GPIdVYJY6Ray9WBkl1erJYnPmD2ALjSNs6MkTq+aEs1MM0ktdIgSX6a4fquSP4fSRVrtJqb4YjP0HOJ1Nx5KprOOtMJUHvBURuoTWI6HoYkvvWZSYPQq5K/hDioyJbzcAhACL+nJ1xUqmWfbcjA9kJIFHIDrtkPKi73Yn42ramQ2/at8+c3arZCtKM9WEpVs8KNbpF6/+KQrzB3KypTI/wJvMwniksWOeA4udIEhLkWt6wvZAC5fK+TOMB8jWIDiQX8C+axsaUgh9M0bFLkBVOF67qYfjtKd97NJgqupr/sfGDAvtDpYmRf3VSUQ9U49tFsU2urjqGLP2HWVGUiFQgyVjVmq/mWCAr3LoTgXMeu1Q6hMOH2A3+Gbi/9Lmy7+V5jTN4DrRN/KBw/zP+x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66946007)(64756008)(86362001)(66446008)(66476007)(66556008)(6486002)(71200400001)(91956017)(76116006)(6512007)(2906002)(4326008)(110136005)(36756003)(478600001)(83380400001)(38100700002)(41300700001)(122000001)(2616005)(82960400001)(5660300002)(8676002)(8936002)(26005)(38070700005)(6506007)(186003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUEybk5MY0pxNVAwUEZVUUNLRC81VWo0dFpCZFFJcms3bmErekFWdWdFaVJQ?=
 =?utf-8?B?WGMwNDNGM1lOMkpoaGRjSG9CSGplZHBOeFRMa21nVTdMSEVzUjNqVXlQUFZN?=
 =?utf-8?B?RDdmRzNVYVJJaDliVVBMT2hwM3QxWkZpNkhRV0l5THlydVVhd201a0l5d1V4?=
 =?utf-8?B?ZkZubXRYV0dtUFBhZHNpMmV1K1IyMTZFSzBDdGJEZ0xQYTBLQmZWQUJmdE81?=
 =?utf-8?B?ekVPZ0dhYmI4djlpM3ZVVzdnMUZaM1NFUitwOFd0Z2JUd21nNGkwNHYvSG9t?=
 =?utf-8?B?MWZWNGlYN0FQbytXc0ZPK0h1NnBENFEwWWJiNlRsZkNqOWRsQW12bjlKL2RG?=
 =?utf-8?B?a2ZVZTBtVzdNM1ROdTFJSjVYZlJUd1RTeUNJN2F1TGprTys0RFMzNFNYZkE0?=
 =?utf-8?B?S09lelhDL2RUc3dmWk5udlhldjBka0xlbEtXai83Y09veXA1V25pY0x3QXgv?=
 =?utf-8?B?b0hYQjAxVGpDVVR2WjFlVjZMekw1OUR1dE5sc3RXemRjNmVnblBJVWoxU3l1?=
 =?utf-8?B?WUhUWkNZNXZVQ09udzVtM3RqbzdTenI1MUkvOFZhQVIrcEN2dGNSMVk5YTZ0?=
 =?utf-8?B?eUdEZnQwc0pGTVFsRWw2aGlTV3Bxalg5V21wWVBGc3lpMVhQNGg5cThGOUVw?=
 =?utf-8?B?TktPUFByRWYzbGM3MXNTV0UrQjVkeDZ5aDFzYk56V0pldEFrQkdlTks0ckNC?=
 =?utf-8?B?NDAxTDM1RGhHcTJnREZZcWNlVTJDbjgvYmFselBsTFdYQU14a3BKT1lhU1Fr?=
 =?utf-8?B?Q3Y3UG1GT1g0TmtnaThFWWxmQjR0aEZzck1GTXlmT3ArUk04Q3ZpV2JnczJU?=
 =?utf-8?B?S3Yrd2puMlVUcENacU56NXpLenIwM29vVk5pVFFmU3FMRWlabXlTNWRpcm5N?=
 =?utf-8?B?ckg0OGtwUDhmaERueittbDN2b2xwYXdjNGlPTVA4aThCUHlCb29vR0MrYVpW?=
 =?utf-8?B?a3k1MU40all1VWNIWTVXZnNwMHBRRjBrMVVzNjdBVXVlWUU4SU5DVW9mS0lK?=
 =?utf-8?B?VVpQZGZxVlRNYXErSFdxMk16K01NcE50NWxhYkczcHZUOGprNm95dWoxR0pG?=
 =?utf-8?B?WlRZcU1Ga3NhK25XTWVjUlIvUjVxd3lyYjZ5dW5Cb0VhT3J2dXZ2R1BMZlp2?=
 =?utf-8?B?dnJQZjlETHcrYjYwNmNtTDdyUU1jbzQvUlhWek1MNXVqN3JKV01IYW9JWEpr?=
 =?utf-8?B?cnprTm1vWXhXb1FsR2lSZUF6Z3NtcUY2RkhXR0QxamJRaDJHcUxORmdRZE5I?=
 =?utf-8?B?OFdGZVo2TzMzRmlsbGM2cnpnMmZpOCszcG9tc05zbFdFTExYY2VKU2QwT1hJ?=
 =?utf-8?B?MzVEaWtzdkplaGlDb3g1TkZ4SDF0NjVSWjdqMDBNMWdWSklyaUYxNlRHNjhZ?=
 =?utf-8?B?NE9iTWkrbVlpeEVTK2RzdnVxeWVJYzJpelVFdk9wYncxVCtrTHdISzhmZ0lT?=
 =?utf-8?B?UjF6Zk5yeGdpMmlpck1oeEpQSEdYR1Z5VzdGUGtmY0pMSUdpUVA3NXRUeWY3?=
 =?utf-8?B?TVR4MjVtc3lBWElpdmdxcno5V0FSZERkL2haUFRNbGFObWVJWUd0NVp4L0pS?=
 =?utf-8?B?Ykp4bmlEVW5EOXh1TXoxMHI4U2V2Tm5yd1hEdkEyL2lTbW1RQXNJdTQ0eXE4?=
 =?utf-8?B?d1IzN2xIN2FsdDdhYzdGVUhzeS9QcUVDbWJCb3poMVFKcnc0TzlISHZIY1RS?=
 =?utf-8?B?UlI2UXgzSVZoL2M1bXFPRVg2emxDZjNTWFJYaXJUZytKU1pwVUxXcC9zYmpk?=
 =?utf-8?B?YXlDazlyK0NZQmxPOS9rWDM1cjhIK1lHd3RDcjM3RnFXLzJGSnZWUEliKzlu?=
 =?utf-8?B?aHY3TytyOW5SU2VFcGpYVFJ2eFE5ZThBZ2gzN1pzNkNFRE1HdytBdWZPbE5X?=
 =?utf-8?B?a1luYldUOGZsWG1iUU9nSDlpK1RiWUFINzRaQVVDUTF2SHpoL3IyeGlSS0Ey?=
 =?utf-8?B?MWdiMFI1Zk8yTjk1REYvVm4vaVN4cnl5cGNsbGpHdmNzUXB2M1Urc0toUVZo?=
 =?utf-8?B?SVFtdkJ0c2pkK21nZXNJVjUxaml6N05kcWV1TGNkSXpKeVg3cERucEJ1N3RW?=
 =?utf-8?B?d1JOeGc0TjAvcXdId2dEM2Z5dnd3ZXZZTHAzQllkeVVlODBwaC9QM05pZzJm?=
 =?utf-8?Q?fHzcTr56t9zSxbkCY603jaYOY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8A45CD0BD273E4EBF309FA0850AE0C2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd2da90-5bc6-4faf-f470-08db93d5de0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 03:58:16.5633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O9BS1VjDOhIQ7CBbpWt/4ezYduemb/mxafnOI1QZn2iWNiqVk4ctQGnz+3vW7i+AM+E63i9JFtt4jrNEdzrySQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6699
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

T24gTW9uLCAyMDIzLTA3LTI0IGF0IDE4OjU4ICswMjAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IFJlbG9jYXRlIGVuY2xfb3BfYXJyYXkgZW50cmllcyBhdCBydW50aW1lIHJlbGF0aXZlIHRvIHRo
ZSBlbmNsYXZlIGJhc2UgdG8NCj4gZW5zdXJlIGNvcnJlY3QgZnVuY3Rpb24gcG9pbnRlciB3aGVu
IGNvbXBpbGluZyB0aGUgdGVzdCBlbmNsYXZlIHdpdGggLU9zLg0KDQpQdXR0aW5nIGFzaWRlIHdo
ZXRoZXIgd2Ugc2hvdWxkIGNvbnNpZGVyIGJ1aWxkaW5nIHRoZSBzZWxmdGVzdHMgdXNpbmcgIi1P
cyIsIGl0DQp3b3VsZCBiZSBoZWxwZnVsIHRvIGV4cGxhaW4gaG93IGNhbiB0aGUgIi1PcyIgYnJl
YWsgdGhlIGV4aXN0aW5nIGNvZGUsIHNvIHRoYXQNCndlIGNhbiByZXZpZXcgd2h5IHRoaXMgZml4
IGlzIHJlYXNvbmFibGUuICBQZXJoYXBzIGl0J3Mgb2J2aW91cyB0byBvdGhlcnMgYnV0DQppdCdz
IG5vdCBvYnZpb3VzIHRvIG1lIHdoYXQgY2FuIGdvIHdyb25nIGhlcmUuIA0KDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBKbyBWYW4gQnVsY2sgPGpvLnZhbmJ1bGNrQGNzLmt1bGV1dmVuLmJlPg0KPiAt
LS0NCj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wuYyAgICAgICAgICAg
fCA2ICsrKystLQ0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbC5sZHMg
ICAgICAgICB8IDEgKw0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbF9i
b290c3RyYXAuUyB8IDUgKysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9zZ3gvdGVzdF9lbmNsLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9l
bmNsLmMNCj4gaW5kZXggYzBkNjM5NzI5NWUzLi40ZTMxYTZjM2Q2NzMgMTAwNjQ0DQo+IC0tLSBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wuYw0KPiArKysgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsLmMNCj4gQEAgLTExOSw5ICsxMTksMTEgQEAg
c3RhdGljIHZvaWQgZG9fZW5jbF9vcF9ub3Aodm9pZCAqX29wKQ0KPiAgDQo+ICB9DQo+ICANCj4g
K3VpbnQ2NF90IGdldF9lbmNsYXZlX2Jhc2Uodm9pZCk7DQo+ICsNCj4gIHZvaWQgZW5jbF9ib2R5
KHZvaWQgKnJkaSwgIHZvaWQgKnJzaSkNCj4gIHsNCj4gLQljb25zdCB2b2lkICgqZW5jbF9vcF9h
cnJheVtFTkNMX09QX01BWF0pKHZvaWQgKikgPSB7DQo+ICsJc3RhdGljIHZvaWQgKCplbmNsX29w
X2FycmF5W0VOQ0xfT1BfTUFYXSkodm9pZCAqKSA9IHsNCj4gIAkJZG9fZW5jbF9vcF9wdXRfdG9f
YnVmLA0KPiAgCQlkb19lbmNsX29wX2dldF9mcm9tX2J1ZiwNCj4gIAkJZG9fZW5jbF9vcF9wdXRf
dG9fYWRkciwNCj4gQEAgLTEzNSw1ICsxMzcsNSBAQCB2b2lkIGVuY2xfYm9keSh2b2lkICpyZGks
ICB2b2lkICpyc2kpDQo+ICAJc3RydWN0IGVuY2xfb3BfaGVhZGVyICpvcCA9IChzdHJ1Y3QgZW5j
bF9vcF9oZWFkZXIgKilyZGk7DQo+ICANCj4gIAlpZiAob3AtPnR5cGUgPCBFTkNMX09QX01BWCkN
Cj4gLQkJKCplbmNsX29wX2FycmF5W29wLT50eXBlXSkob3ApOw0KPiArCQkoKihnZXRfZW5jbGF2
ZV9iYXNlKCkgKyBlbmNsX29wX2FycmF5W29wLT50eXBlXSkpKG9wKTsNCj4gIH0NCj4gZGlmZiAt
LWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wubGRzIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbC5sZHMNCj4gaW5kZXggYTFlYzY0ZjdkOTFm
Li5jYTY1OWRiMmE1MzQgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Nn
eC90ZXN0X2VuY2wubGRzDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0
X2VuY2wubGRzDQo+IEBAIC0xMCw2ICsxMCw3IEBAIFBIRFJTDQo+ICBTRUNUSU9OUw0KPiAgew0K
PiAgCS4gPSAwOw0KPiArICAgICAgICBfX2VuY2xhdmVfYmFzZSA9IC47DQo+ICAJLnRjcyA6IHsN
Cj4gIAkJKigudGNzKikNCj4gIAl9IDogdGNzDQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsX2Jvb3RzdHJhcC5TIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvc2d4L3Rlc3RfZW5jbF9ib290c3RyYXAuUw0KPiBpbmRleCAwM2FlMGY1N2UyOWQuLjYx
MjZkYmQ3YWQxYyAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rl
c3RfZW5jbF9ib290c3RyYXAuUw0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gv
dGVzdF9lbmNsX2Jvb3RzdHJhcC5TDQo+IEBAIC04Niw2ICs4NiwxMSBAQCBlbmNsX2VudHJ5X2Nv
cmU6DQo+ICAJbW92CSQ0LCAlcmF4DQo+ICAJZW5jbHUNCj4gIA0KPiArCS5nbG9iYWwgZ2V0X2Vu
Y2xhdmVfYmFzZQ0KPiArZ2V0X2VuY2xhdmVfYmFzZToNCj4gKwlsZWEgX19lbmNsYXZlX2Jhc2Uo
JXJpcCksICVyYXgNCj4gKwlyZXQNCj4gKw0KPiAgCS5zZWN0aW9uICIuZGF0YSIsICJhdyINCj4g
IA0KPiAgZW5jbF9zc2FfdGNzMToNCg0K
