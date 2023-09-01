Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C507903C7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347998AbjIAWvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350985AbjIAWvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:51:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EBBCDA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 15:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693608692; x=1725144692;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MBI6/KC17PENfAMXi5AqXHNT9KTe4jA8mtzxTooUf80=;
  b=OYYyD0w06MbtrC5tACavjTYMpmiBmCHZkdFxN2WfIpTAoaSLH+OrrLY1
   5YUcHw5rQNp3DyyQFmGz5OsSDw3R9KKaff712lYN2zZIYsPLh6wkdj4uU
   EShO++GRxZh2oaj45PosGq9WsXW4U0xYytasA8P8ys9JXEruyqc0cMVbC
   Z0BKJkgra3ZmC1KvF+KhIn2j+o8vzoixyxEw4jXhbVRvsbcVWzjSTyC7M
   aDrm8djWrwK3TwQ/c2awdmeGRK6IT/31aud0di/7DAUnXL6eB0paXX+ja
   kyHhaIvtXFAgr8Iggy+zPbObhRmDndDdY1MrTOAn8uDTMf5VGCd6Ln8re
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="356634248"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="356634248"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 15:51:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="689910042"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="689910042"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 15:51:26 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 15:51:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 15:51:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 15:51:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGs9LMtFEILjJbIfzdOcIULCHwa/qlPJ0Kd/XpglWs8aQfkTxauLQ93W5Ip0Ej5zeuVQ//hVvBoTFGslLDus3Vug5kTRmSQZGXKn3qrtHynyU4lkU/USyszu5cg8yG5cObv4k1HW6VjKBgMVyyiUblSIV2atnfm3UbKIqGj8Tz2zFvtncTh00Xt8iVtvkEOjFFobpTfzuE3llCqV7M/EfrVoTjmpAFfMFqBxNnTtfv/2Vyr2taLxGi+Tgl5E1FjN1lqDY2BzmcJEW6rpyBWC7W0yw9cs2hdDvU8E0pApX5Cg4QQZvDw/EEKuJqXnviWpQGGQOiBA5T0yjgtvM7kmxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBI6/KC17PENfAMXi5AqXHNT9KTe4jA8mtzxTooUf80=;
 b=S7aiyWthFCRkq965FUZxbtrOGlgxrbZYG13HZnKO0AQsBn/RmSjuOrXFTbk57sKBO/4IGTk56qaZz2/H1mwgl83DXCogU8b01NQsKR1F2SlXuhjbf/fuTwgiGFy8jClnzGXTqWPn46Ffvg+nTpHG2VBhH/cHDEzKyB+NN9DVitJ0P9vW+xRAR5oyU1oOsHmu3niKIQiZ46rNXHpnx3PkAnLV1kxSz5aZX47zOHXkJ1SMocGk1HBcOa9gMeQDoMuZreK9l5ixQ/QppQvIuMg/cQCNO7dGIXR/KFrwsKYp0RivLjRF6HrV2WdNOtn9B+prL63ud0ActwDm4b2gENdSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB6747.namprd11.prod.outlook.com (2603:10b6:510:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Fri, 1 Sep
 2023 22:51:23 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6745.020; Fri, 1 Sep 2023
 22:51:23 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH] selftests/x86: Update map_shadow_stack syscall nr
Thread-Topic: [PATCH] selftests/x86: Update map_shadow_stack syscall nr
Thread-Index: AQHZ3QCRI1z+rI8HBEKSGAcvQRk7hLAGXFwAgAARa4CAABzpgIAACPYA
Date:   Fri, 1 Sep 2023 22:51:23 +0000
Message-ID: <339cd90a9b77706bd65b6d45f49edf009a9d46a0.camel@intel.com>
References: <20230901181652.2583861-1-rick.p.edgecombe@intel.com>
         <e2ae1d89-9abf-338e-e56a-dc4be19b9bfc@intel.com>
         <b92afa6dbd074409095e525204d538f451ee4823.camel@intel.com>
         <148522e4-a4ec-a35b-df25-e04eeb5f51c4@intel.com>
In-Reply-To: <148522e4-a4ec-a35b-df25-e04eeb5f51c4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB6747:EE_
x-ms-office365-filtering-correlation-id: 2ba8fd55-6ab5-4d81-86cc-08dbab3df782
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VQ2WmllAHrUQDJrAVD7cmRnnHekmbJ0Q6Rl9O4/lcFq9R6krKgx6++1m/plqkC5hdwUQD/PkbRVZDGGrwJRuj237YvGBPg9aRkpF5gD2sO9h/d2lvOrPxDuhIm8xLbLKXemviTDffHC2QI4AaRZsAuyR5jBCQUJ3cEAdRkOlGwAlxOV0P+Q8ry3+LxOfalJG2rOv8j/S6Ejoo5FnnJLVJIGG0t/uQatQjqUylB2rsYRmWMQp2MqmyYy9mBB86Z7G3ikCmRG6iZvgXfZjk96ZPTb7pssva99xKS+4N8UausIpr4MUmNJUD8NzT5c9tsDZSzjq9lxEYgh8S99Q90IrZvzzszkQEEpWdkaXB3cqLxotxRfLaDnsTSn9vPXmj9O9VMBrTwFqQPO1m60eiebJ9s5u3aYQqIWGOZOV8beiq67xi45P3ZSE+2/ASEHoy1sx0qbTx0hD1tou5O6YGoJqMlyPTfSykF2/Prki1AZvf67nE/Y+LGyser2Emwu+VMSQv0XIC7z8qYbLmNIt5TETjPP6JwZk7nd+pIRIFaXpNpke7ll0TTDJkXkhSDaWrOgFOUqKTvGGmpPNZ/Izh4KG/nBaA3ccLxKN14udzlsN7hzAhL/WL5GcALjo6GkF/ttHFa5mrYUhlxy1tZOZWPk5Zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(186009)(1800799009)(451199024)(110136005)(7416002)(4744005)(6512007)(2616005)(6506007)(71200400001)(6486002)(478600001)(66446008)(66946007)(64756008)(66556008)(316002)(91956017)(4326008)(8936002)(8676002)(5660300002)(26005)(86362001)(122000001)(66476007)(76116006)(36756003)(921005)(2906002)(82960400001)(38100700002)(38070700005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2pXWmJwSEYvMklKVzBVREExOGorYlBKRDF5MzliM0N4VE0rWlBsc1lpa2Ni?=
 =?utf-8?B?Z3JWRGJua3k2YnRrS3ZDSFphMjRxQWlPak1sMG04SXE5ZjdzWUIwSUlaNTJm?=
 =?utf-8?B?WGs5MHJ1QnNFMTVKcXNKdFZJK045TFVZUVlWb3c5bXhuSW03NGFDL3lDMGdK?=
 =?utf-8?B?RmN3Q1E2RU9mTHd2bmhpNUhDSExuUUFOc09DbnYrMGNqUVA4ZkhkOE03VUU3?=
 =?utf-8?B?Q0xISnd5SGkxaVhMaVFsNWpzRGdJZ25lQ2prVWxwODN3blg2YW8xREJrSS9v?=
 =?utf-8?B?dDlVOEtwVlRjWk1yOWpNdDV3SGhIU3hOSFZURWIyZDN2cVpHd1I5Y0ZyLzNj?=
 =?utf-8?B?cmErcHFDb0x5T0pOVkI3cTFrZituWmtoaXh6VWFkcU9lakpLZHBWV3pjS2NW?=
 =?utf-8?B?YmUxNVM3MEQ4eER6UWNiMXVPckJ2ckxSN215andpTnVTV0dRQ0tJSkxxQ3lT?=
 =?utf-8?B?U2lCRXVmVGVQNGwyS1I3MElZK2tFVEI4OTh0eFI1K2RwYkJoWjhRM1dwVklv?=
 =?utf-8?B?OGJBcXQ1K2JFbjlkME42NUl2VWNvR20wQWtsOUFzWk5hMWtTSW82QU1rREU3?=
 =?utf-8?B?NnByODJqUXlyRWRPNkpQYldrNEVHSG14SEVQZG5nWkJDVXh1WVZFaWZMVVE5?=
 =?utf-8?B?alVWSnVxMmJ6bEVDVSszL3JuMjZjSk5vaFVvUTc4MnhhZGN0OWhtUVMyd085?=
 =?utf-8?B?Z3NNRElKYk9IbTRaNTJ2VEQ2MDgwOHVIUDN5L1NIRGZQSjgwUWZZeU4zSUZ5?=
 =?utf-8?B?MnIvOGpIYmZNbU91SThVV3hoZUQ1RDlrcnFmZktETks1b0FnUzBxb1lKSVdE?=
 =?utf-8?B?eEpKOVJIVlU4UVNlSGJGMmpXNER6VkpRa2tOOElrUVRtc3pJTnZQYzA5WG1I?=
 =?utf-8?B?MnNOSVhHcThVbEdCOC9QS3lUVmtnMm9wanFIMkIzek0zWWhSZC9SOU1KbXFX?=
 =?utf-8?B?ZlpqUHN5dWNPQ0I1SVRwb1NreXB1KzFHenJzeDg4R3h3Y1RLcTRUUmJuSU5J?=
 =?utf-8?B?cFJQUkdhK1Z3Y3lmZk1RTlFKYm5Ha2xGYXFtSzZHcW82VXgwZnhLSWpVNzQ3?=
 =?utf-8?B?ejE0MDdGdkVZWUd4OTAzTG80SUtyL3ZWcjR4Y0tybUt4L09xQ2pVUkJ1Z0dB?=
 =?utf-8?B?OHdYMExhTzdpRm9ZMEY0aWRlalJZVGJXS2FwSG8zaEJ1bjY4NVpOQ0krODJK?=
 =?utf-8?B?K0NTeWVadDVjWE9VajVGRmVNMVVZVjBDRjZXdkc0QURHQlFDZVQvSVgvbnAv?=
 =?utf-8?B?QjBmbEdGRlI3UFhORlZza0Y2UHpIV1d6Zmw5U3dWeGxwalVCRW1CNG5MM1dW?=
 =?utf-8?B?d2htZWNkZys4SlZEdXZpRElSRWxuenJXaGpEVklSSStDL0RRenZZZzJlREs2?=
 =?utf-8?B?c3Q0MkR3M2U2bDVWQ1l5YXdlczA3WENkeUNPSzcwUFN4QjR4RVRoRlRxRnYw?=
 =?utf-8?B?dlQyV0JwTTRjQWd1V2lBczN3S21JTGJCTC80aUo4MTJ1a04yN1IxOWdjTS9z?=
 =?utf-8?B?Nm9CZnh6QmhINDJORE1zbmNwYS91T2NsQ0VsSEpnSUtFKzBQQzVkNG92ZG1p?=
 =?utf-8?B?T2F1bDlhQWpNUjcxS2FMOXQzNEpjMlJ3RmQwZkplNDdyRFdrVm15TmQ1VlVM?=
 =?utf-8?B?c29rMlNyT1R4eWFQOStLd1BORGhVVHJUeVcxSTI0dlppei9RamdiNHl0OEpN?=
 =?utf-8?B?UFhvUEV5QzZzNGtIdmR0SXJCU1BvMlZGQStibXhEWE9RUDV5a0hWcTRxUVhJ?=
 =?utf-8?B?RnMwNXUzanYvSm16TDJwMlZaeC9SRkNlYnFKYU5NSzBWSDJDTktLNUw4Ymsy?=
 =?utf-8?B?NVFFV0dBUHpQbTZmdnBnQ3FoZUJpdUVzNFVYbzlVVllPZGtBbzZxT2RSN1Mv?=
 =?utf-8?B?SHoxNEVQbENyOUtHSTFhMUlUTFNFNTd4cks1MFVxRFlYZjlha0tCekJKSDRn?=
 =?utf-8?B?ZE90WHVyTGdxRnZnNlRYbEU5aWw1UDFJQUpxNkZFL2owQk8vNm0vbGlzQUs3?=
 =?utf-8?B?cm1oNTQxbVFXREN1YVpTU1hMYWpBeW9EbDU2VkdKWU4xdVMwRUpWN0R4ZWNk?=
 =?utf-8?B?NHo3T2hEVVRJRXZWaUhybDh0OHB5dHIvL1VSNmxyVU15YVV0MlQ0NTV2d0Rn?=
 =?utf-8?B?YVAzRjduZFJqbDZtQkJFeTdOVzNmNzNmR3JMZHlUZHNCS1NUNk54MTVTMU9r?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0FE9989C560D940A6CB809C62194BDF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba8fd55-6ab5-4d81-86cc-08dbab3df782
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 22:51:23.6593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tXMgPHgtbXhqz3K6PWCo6knrGS6NWusGcTAvW5r8o69VstHh5mN11V/CvFifBoM3Ch8shUMaKbnj39s8qofhU470YJn7qOxgH7d2dwe8+xE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6747
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTAxIGF0IDE1OjE5IC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
TXkgc3VnZ2VzdGlvbiBpcyBvcmlnaW5hdGluZyBmcm9tIHRoZSBiZWxpZWYgdGhhdCBhdCBzb21l
cG9pbnQgdGhlDQo+IGNvbW11bml0eSBkZWNpZGVkIHRoYXQgYWxsICpuZXcqIHN5c3RlbSBjYWxs
IG51bWJlcnMgd291bGQgYmUgdGhlDQo+IGNvbnNpc3RlbnQgYWNyb3NzIGFyY2hpdGVjdHVyZXMg
KGV4Y2VwdCBhbHBoYSkuIFNvIHRoYXQgd291bGQgbWVhbg0KPiBzeXNjYWxsIG51bWJlciA0NTMg
aGFzIHRvIGJlIHJlc2VydmVkIG9uIG90aGVycyBldmVuIGlmIGl0IGlzIGFuDQo+IHg4Ni1vbmx5
IHN5c2NhbGwuDQo+IA0KPiBJZiB3ZSBkb24ndCBkbyB0aGlzLCBhbmQgbGV0IHNheSBhIGdlbmVy
aWMgc3lzX2ZvbyBjb21lcyBhbG9uZyB3aGljaA0KPiB1c2VzIHRoZSBuZXh0IGF2YWlsYWJsZSBz
eXNjYWxsIG51bWJlciA0NTMgb24gb3RoZXIgYXJjaHMsIGl0IHdvdWxkDQo+IGxlYWQNCj4gdG8g
YW4gaW5jb25zaXN0ZW5jeSBiZWNhdXNlIDQ1MyBpdCBpcyBhbHJlYWR5IHVzZWQgdXAgb24geDg2
Lg0KPiANCj4gTXkgbWVtb3J5IG9mIHRoaXMgaXMgYSBiaXQgaGF6eSBmcm9tIG15IGltcGxlbWVu
dGF0aW9uIG9mIFVzZXINCj4gSW50ZXJydXB0cyBtb3JlIHRoYW4gYSBjb3VwbGUgb2YgeWVhcnMg
YmFjay4gQWxzbywgSSBjb3VsZG4ndCBmaW5kDQo+IGFueQ0KPiBoYW5keSBkb2N1bWVudGF0aW9u
IHRvIHN1cHBvcnQgbXkgYmVsaWVmLiBJJ2xsIHRyeSB0byBkaWcgbW9yZS4NCg0KUHV0dGluZyBy
ZXNlcnZhdGlvbnMgaW4gc291bmRzIGxpa2UgYSBnb29kIGlkZWEgaW4gYW55IGNhc2UuIEkgdGFr
ZSBpdA0KeW91IHdvdWxkIGxpa2UgdG8gc2VuZCB0aGUgcGF0Y2g/IE90aGVyd2lzZSBsZXQgbWUg
a25vdy4NCg==
