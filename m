Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736A478B0F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjH1MsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjH1Mrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:47:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930E1102;
        Mon, 28 Aug 2023 05:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693226861; x=1724762861;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OqBz1/gqikD1qdP7C0yzNDju8W+Uja9HDvN+mCa0fhc=;
  b=gbo2MzaYQY3bQVl7gE0RAEFl5eeeqzETzm3ZsW1ZmeEwH3+thMNErYCM
   IgJ7MLdtfhC0TCQcauNxRkkuGlwB9szQnXywQYwz2FaoFWd0+eZhm/N7j
   7TD0+5RsjNvwq+zF+o0w/TL+hLa/BmC++1irAIyLQgYx7pl4m/ADG5/m6
   mmjAw9HuzTmOF+xYx6PouN9u7FYYdzSLYi33k0s8KASIyRHgictnUfE8Z
   fqcYsXJqbw5EyhQadKoEnFNRcbkv5E0o0A7CrotOVaD1HCps8a4oBnGNw
   GDt1E2KJpuM3cNe0fnxdg/I7Vpc+eVk80H5lfedDAwvdSQiiL6EJAFv5z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="439038092"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="439038092"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 05:47:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="912042352"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="912042352"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 28 Aug 2023 05:47:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 05:47:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 05:47:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 05:47:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 05:47:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RB+ERFBIMEEyv4U0mJGyWWckhvaxXeWaeeo9zuRPCam4ge1rf6/RfzWFv0sWb/eEps9NPPTz3qN6PBN7A3vTO2A+xcYPlnf3jrGdI3iEeBiBIpwb92VYH0uDkbnhPTjIJ0ZXJ181yp2I2rjsebG2rAc89r52rSVBa0IWl2X8P1MY3YXod2BvVDetFtcmCtoEBpZ7AGHGrinGJ3CFap73KD6E9wX3/YbjxyvJAC6P7PnNBTkNpCExXTKEFQdSoJmdTO52x3ZE3C/qdVzZTOaxxbSXuqENFO4XLo9ePfsBDSSfErvRXugKtiUwzRKer1s+x2GI/tT56vHTUGKsBAElSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqBz1/gqikD1qdP7C0yzNDju8W+Uja9HDvN+mCa0fhc=;
 b=TPyYgeM391K5wCqadRRHhUUKWwQp4POWLq+8/FHdDFjozv1rDbpl8UlOsVPap93JHQcdrzAcVwAaKGwmKwU29P0GdfOEhWfKTnNVdLSY/AM68sizklO/ePRUGBdy5Mk02MPa8VGA5ppxtfQUbzm470hLYllX3kqh4Ih/nLSHvDlAy2hZKdi81WnuEVTGeX045foeaJP1yNCnHS+yCt/KNzyIITmo9qncPDylfSuKF9hWremt1JS/CvtHag2AGmVtE2xVXrg2/WLNjwFZ0UszFIL+k/qoWuHTbueFc8BDoDvV7Y+DtqY+Mxc0eFpHCr3TdsMLiFnvy5PsTWx6DPmDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by SJ0PR11MB5631.namprd11.prod.outlook.com (2603:10b6:a03:3ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 12:47:39 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::c733:b6c6:fe0d:d4c4]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::c733:b6c6:fe0d:d4c4%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 12:47:39 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH wireless] wifi: iwlwifi: mvm: Fix a memory corruption
 issue
Thread-Topic: [PATCH wireless] wifi: iwlwifi: mvm: Fix a memory corruption
 issue
Thread-Index: AQHZvaPSJ5Tzmbv0hUeWaOzDlU0ozq//4F2A
Date:   Mon, 28 Aug 2023 12:47:39 +0000
Message-ID: <30c0426cfff334163d6b92f5255dd70ac44692c4.camel@intel.com>
References: <23f0ec986ef1529055f4f93dcb3940a6cf8d9a94.1690143750.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <23f0ec986ef1529055f4f93dcb3940a6cf8d9a94.1690143750.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|SJ0PR11MB5631:EE_
x-ms-office365-filtering-correlation-id: 2ba6dfdc-a9ee-4c7f-4095-08dba7c4f669
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sp4V4O38PVAyJ6Ktr/iRGSWwCM2YbZxFIXEKanxoZPU9DjEYk/clmdmolDFdvCqHc4nMJ+pfXA/fGgWb2KEFFazqGvEr56nyLb6nWcjNVeflJrLXBkRkcehwB1B3I3coD4jqCZ0o7KmQMkFtiw75gyVZcgrB9wfJY9p9C9Xe77Wyr2tF0D4L8KgCIYrwUrvkhTrA1jHRgTnJ9zfYnDjT41f4jqeulAlSV6rhrj+z7qCg7cKZcJDxC5ht+nCiNmKnNLlJqN4eMh8qaZI8J7X7CCkH07bjCcpCNKxhYQ8f5naiSYKrEKHir6sG8H2hKRakwTt8Tney3RQKRerHiNM7/h3Yh6yAquKiIAj8ltdqJiHwoduM4d2SrMvHSaNXLXRwNW4cygszBMFcmeuGkLVlKw26Dlo/dcvi05DrYh+hFDcK2UOsxFXFsnT8eTjZ/JtFHBXPmmVoeouW6MqOVZ9X5+Th7uq66DlOGvjeN7PG9sVv3XyTDM/PL6jQAnJ+SEANwTPxnkVPzRcDSHvt/o6VR+3g3JLlrfeid9zlq5/R3BLLA1z/HvJPUe7uhh8c7pVkME6USpozMMehz84spsrMCo2FhFv9rDOTys6Ro9FaquUSBWV11P4AKYEpKepziTMp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(186009)(451199024)(1800799009)(71200400001)(6486002)(6506007)(110136005)(86362001)(36756003)(38100700002)(82960400001)(38070700005)(122000001)(2616005)(91956017)(83380400001)(2906002)(76116006)(26005)(478600001)(66946007)(8676002)(4326008)(66446008)(6512007)(64756008)(8936002)(66476007)(5660300002)(66556008)(316002)(41300700001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVZ0ZzNaQWxPM3ZMaVZKdGhVZU83enNNZW5jS3JlSWxpUDgwMXpxWEFrbFRZ?=
 =?utf-8?B?NXdtbW9UYVF1b0FnUjZ1QUtPbE9xeEhlS2cvQ1dVQXpncnJWcUNmM0kvRkt5?=
 =?utf-8?B?dXZUWDdxRlBZbG9UOGlNTDRqZFp1REhjV0cwT1JEY0dzUEVuUW5kd21iQi9n?=
 =?utf-8?B?RitaZDFEazV5WUxES1d0NlBRLzZGMVptTHArZWhtVEVMMkk4T3NySC9JS0dD?=
 =?utf-8?B?dGJWSGh2ZG9acnJZdnU4anFab3hOR1JsNUZ6SlZicG5rK29aUis2ejJWOW9k?=
 =?utf-8?B?QU9sNlZucE9Ebk40a1I2WXNoMGFZb0pmM01rdUxqNVJPa0h3K1BRdmRsRE01?=
 =?utf-8?B?UGF0TTYycGEwNW1idGt2b3dCNUFpSnhTZTF1TnRvMzgrNWpyelVXNEZUeTMw?=
 =?utf-8?B?U2VVZld4c2lJSFFIdUtLbnpnbWEwYllna3RXTGlXc1NlR2wwamtlb0xkSnBE?=
 =?utf-8?B?Uk5vNVltaTZiMmxOblBadklhVDd6YXRnNEdUMHdMTThocTBhTUx0T0xuY3dl?=
 =?utf-8?B?bnpQbWZBN3h0aVN5VGRDK25IOExQdVlwTHlBS3BTMkxDakZYR3JtdGlmc1pj?=
 =?utf-8?B?SFVGWDlpQVR2Y2tVYmY5K3FheUlySGZJRDJIMVQzaGxEVHQzSGswdUJUY2sy?=
 =?utf-8?B?am9mY1h5aVhJaWc5Lzd3UXdMUEVaT0ZVcWhha2dHcmFpVHZBODZxVDNDUFZY?=
 =?utf-8?B?WFlublJyQjhYTTBnbVdKYW5PWndxWkVoTWhMdWF0ak4wQkFSY3RZN213Y0VL?=
 =?utf-8?B?Ry8rck12Y2FJV3R1MmV6VnRnR2hkdTFFTVVzYmpnRXp2dFBNM2tPM0F3V1Fu?=
 =?utf-8?B?bElWZXAzNW1OWTRkdHBtL2lBM2JkTGsxYzBEMWdxRitIWEZSTVJvei91Z2Na?=
 =?utf-8?B?VWtIenUvWHZ3b0NGRGlFb3MxeW9oYUZnNGJsN0sxSVVZUGM3Wm9JTytmd291?=
 =?utf-8?B?Y2IxK1k3M08yaVBwWkdoZExuWDhLQ2JBMmtQdUtlOUZwMnhtYmM1d1JROXVh?=
 =?utf-8?B?SVdXUm9nODQ1QURad2xHNWU5SDJmc0ZnY05iN05GOU9Uc2RpVjBiZzU4S25s?=
 =?utf-8?B?V2crRks2QXdZdVhKeC9kb1NMNnZUem95eG93M2puRldNSitLSnlzYU9KdVI3?=
 =?utf-8?B?MjlYYzdJbjhYdEFzWmJici91eE9KdjA5Nno4MGZlcHFiMm9ZajVlc2VKMUI0?=
 =?utf-8?B?MmVRWW1XeHpjemlXNUwyWE50V3h3OERvbTVGK3lRMEhxTU9HTmpDQUtVK1Jy?=
 =?utf-8?B?MVZ0ZDRmYjJ4UTMrcTFuaXZqNHdRZ0R4b01Qc1VWS2tscUFQZEtSSTlwcGM2?=
 =?utf-8?B?RUdQbHIwMVAwdVBWU2tEWjlXdnpGaVhGSG9jT2JFcTJQNnNaODRlS0I0NHc3?=
 =?utf-8?B?RmpuRFZPdlRyemYxMnoxcS9wb2p5VVlrdzQyL1h1YjBUV3prOHVPOFJFZWVQ?=
 =?utf-8?B?aGUxZ0xsQmRHZmg0RkQ4Nm96NFVENS8xNlZwWHBOTUxpYWN5SDNSV016cGpE?=
 =?utf-8?B?ZlM2KzMxZk4zYVJteXAyVXdEdkNhd3hGUmRSZ0pqaEg1NEVlSS9iQndWU3V0?=
 =?utf-8?B?UyswK2dydm5LQ1IzczllZndEZ3F3S2FqRW5BUGxaYktBVGlsOVRRKzhFN0Ew?=
 =?utf-8?B?dVNqeEErLzF4eFhJcDBTU3hrdDBNRmJTN2J6L1NMMXlRakJkcWR6cmZSQk1F?=
 =?utf-8?B?YUo0bENlTXVMV2pSNWloNFNYN2V4UGhNOFdHdlAyRTlmM0twZzVBckJoTHlW?=
 =?utf-8?B?UTFoVUtvb2dPNFNxaWFDenQ4Yjd1bkxPeks4bkZLUERVdldBcUE1cnIzSjZx?=
 =?utf-8?B?ZDRzRW5PcVNoWEFuaFdDd3hpSzhGZTdUQ2hOcGNXQlVUK25xbUkzUzJWT1d3?=
 =?utf-8?B?UGMzVXp2MVR4ai90MnhnZThKeGZvd1RIbEo1MTk3UFF0MFFqZHFXQ2hJa2FZ?=
 =?utf-8?B?TzZha1MyaFAxZmFrcVBSSkNpNnk1UURCWWFoS1psbkp5UDB5Ujd4c3BidWFm?=
 =?utf-8?B?REc4Szc0RHA4MDlHNDNaVWRWS0Z4QlhJaStXLzhqUUtDQlhmbG9JYy9VQ2wz?=
 =?utf-8?B?VTdMZDk1MS96N0lERHgrdUk3cTBCMmlNQWUxd1dHM0Y3MzRkNTNRR0pDbDR6?=
 =?utf-8?B?RzBPZVNKdE8vWmlQYVhRT1pTYnFyVytlVVkzT1QvNzQ1ZXdpb1dUbHYzU1Zm?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34F17760C9B73044A005BD849AFDF9A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba6dfdc-a9ee-4c7f-4095-08dba7c4f669
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 12:47:39.2076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hHmmAzIA5yuN885/fAl7PAqpwcgaH0FW7tUcbcLLZTh/aNWOQglxw+Fa8wJkcUIN1gZs6JbKcMYDC1YqnYyqVvvYgSFZJHgXcXdbttTJFEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5631
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIzLTA3LTIzIGF0IDIyOjI0ICswMjAwLCBDaHJpc3RvcGhlIEpBSUxMRVQgd3Jv
dGU6Cj4gQSBmZXcgbGluZXMgYWJvdmUsIHNwYWNlIGlzIGt6YWxsb2MoKSdlZCBmb3I6Cj4gwqDC
oMKgwqDCoMKgwqDCoHNpemVvZihzdHJ1Y3QgaXdsX252bV9kYXRhKSArCj4gwqDCoMKgwqDCoMKg
wqDCoHNpemVvZihzdHJ1Y3QgaWVlZTgwMjExX2NoYW5uZWwpICsKPiDCoMKgwqDCoMKgwqDCoMKg
c2l6ZW9mKHN0cnVjdCBpZWVlODAyMTFfcmF0ZSkKPiAKPiAnbXZtLT5udm1fZGF0YScgaXMgYSAn
c3RydWN0IGl3bF9udm1fZGF0YScsIHNvIGl0IGlzIGZpbmUuCj4gCj4gQXQgdGhlIGVuZCBvZiB0
aGlzIHN0cnVjdHVyZSwgdGhlcmUgaXMgdGhlICdjaGFubmVscycgZmxleCBhcnJheS4KPiBFYWNo
IGVsZW1lbnQgaXMgb2YgdHlwZSAnc3RydWN0IGllZWU4MDIxMV9jaGFubmVsJy4KPiBTbyBvbmx5
IDEgZWxlbWVudCBpcyBhbGxvY2F0ZWQgaW4gdGhpcyBhcnJheS4KPiAKPiBXaGVuIGRvaW5nOgo+
IMKgIG12bS0+bnZtX2RhdGEtPmJhbmRzWzBdLmNoYW5uZWxzID0gbXZtLT5udm1fZGF0YS0+Y2hh
bm5lbHM7Cj4gV2UgcG9pbnQgYXQgdGhlIGZpcnN0IGVsZW1lbnQgb2YgdGhlICdjaGFubmVscycg
ZmxleCBhcnJheS4KPiBTbyB0aGlzIGlzIGZpbmUuCj4gCj4gSG93ZXZlciwgd2hlbiBkb2luZzoK
PiDCoCBtdm0tPm52bV9kYXRhLT5iYW5kc1swXS5iaXRyYXRlcyA9Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKHZvaWQgKikoKHU4ICopbXZtLT5udm1f
ZGF0YS0+Y2hhbm5lbHMgKyAxKTsKPiBiZWNhdXNlIG9mIHRoZSAiKHU4ICopIiBjYXN0LCB3ZSBh
ZGQgb25seSAxIHRvIHRoZSBhZGRyZXNzIG9mIHRoZSBiZWdpbm5pbmcKPiBvZiB0aGUgZmxleCBh
cnJheS4KPiAKPiBJdCBpcyBsaWtlbHkgdGhhdCB3ZSB3YW50IHBvaW50IGF0IHRoZSAnc3RydWN0
IGllZWU4MDIxMV9yYXRlJyBhbGxvY2F0ZWQKPiBqdXN0IGFmdGVyLgo+IAo+IFJlbW92ZSB0aGUg
c3B1cmlvdXMgY2FzdGluZyBzbyB0aGF0IHRoZSBwb2ludGVyIGFyaXRobWV0aWMgd29ya3MgYXMK
PiBleHBlY3RlZC4KPiAKPiBGaXhlczogOGNhMTUxYjU2OGI2ICgiaXdsd2lmaTogYWRkIHRoZSBN
Vk0gZHJpdmVyIikKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9w
aGUuamFpbGxldEB3YW5hZG9vLmZyPgo+IC0tLQo+IEkndmUgY2hlY2tlZCBpbiB0aGUgLnMgZmls
ZXMsIGFuZCA6Cj4gCj4gQmVmb3JlCj4gPT09PT09Cj4gIyBkcml2ZXJzL25ldC93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL212bS9mdy5jOjgwMTrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbXZt
LT5udm1fZGF0YS0+YmFuZHNbMF0uY2hhbm5lbHMgPSBtdm0tPm52bV9kYXRhLT5jaGFubmVsczsK
PiDCoMKgwqDCoMKgwqDCoMKgbGVhccKgwqDCoMKgMTQ0OCglcjEzKSwgJXJheMKgwqDCoMKgwqDC
oMKgwqAjLCB0bXAyNDgKPiAKPiAjIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
bXZtL2Z3LmM6ODA1OsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
KHZvaWQgKikoKHU4ICopbXZtLT5udm1fZGF0YS0+Y2hhbm5lbHMgKyAxKTsKPiDCoMKgwqDCoMKg
wqDCoMKgbGVhccKgwqDCoMKgMTQ0OSglcjEzKSwgJXJheMKgwqDCoMKgwqDCoMKgwqAjLCB0bXAy
NTIKPiAKPiAKPiBBZnRlcjoKPiA9PT09PQo+ICMgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9tdm0vZncuYzo4MDE6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG12bS0+bnZt
X2RhdGEtPmJhbmRzWzBdLmNoYW5uZWxzID0gbXZtLT5udm1fZGF0YS0+Y2hhbm5lbHM7Cj4gwqDC
oMKgwqDCoMKgwqDCoGxlYXHCoMKgwqDCoDE0NDgoJXIxMyksICVyYXjCoMKgwqDCoMKgwqDCoMKg
IywgdG1wMjQ4Cj4gCj4gIyBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9m
dy5jOjgwNTrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCh2b2lk
ICopKG12bS0+bnZtX2RhdGEtPmNoYW5uZWxzICsgMSk7Cj4gwqDCoMKgwqDCoMKgwqDCoGxlYXHC
oMKgwqDCoDE1MTIoJXIxMyksICVyYXjCoMKgwqDCoMKgwqDCoMKgIywgdG1wMjUyCj4gCj4gQW5k
IG9uIG15IHN5c3RlbSBzaXplb2Yoc3RydWN0IGllZWU4MDIxMV9jaGFubmVsKSA9IDY0Cj4gCj4g
LyFcIFRoaXMgcGF0Y2ggaXMgb25seSBzcGVjdWxhdGl2ZSBhbmQgdW50ZXN0ZWQuIC8hXAo+IAo+
IEl0IGlzIHN0cmFuZ2UgdGhhdCBhIG1lbW9yeSBjb3JydXB0aW9uIGlzc3VlIGhhcyBiZWVuIHVu
LW5vdGljZWQgZm9yIG1vcmUKPiB0aGFuIDEwIHllYXJzLgo+IAo+IFNvIHJldmlldyB3aXRoIGNh
cmUuCj4gLS0tCj4gwqBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9mdy5j
IHwgMiArLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
Cj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZt
L2Z3LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9mdy5jCj4gaW5k
ZXggMWY1ZGI2NWEwODhkLi4xZDVlZTQzMzBmMjkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZncuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvbXZtL2Z3LmMKCj4gQEAgLTgwMiw3ICs4MDIsNyBAQCBpbnQgaXds
X3J1bl9pbml0X212bV91Y29kZShzdHJ1Y3QgaXdsX212bSAqbXZtKQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgbXZtLT5udm1fZGF0YS0+YmFuZHNbMF0ubl9jaGFubmVscyA9IDE7
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtdm0tPm52bV9kYXRhLT5iYW5kc1sw
XS5uX2JpdHJhdGVzID0gMTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG12bS0+
bnZtX2RhdGEtPmJhbmRzWzBdLmJpdHJhdGVzID0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCh2b2lkICopKCh1OCAqKW12bS0+bnZtX2RhdGEtPmNoYW5u
ZWxzICsgMSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAodm9pZCAqKShtdm0tPm52bV9kYXRhLT5jaGFubmVscyArIDEpOwo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgbXZtLT5udm1fZGF0YS0+YmFuZHNbMF0uYml0cmF0ZXMtPmh3X3Zh
bHVlID0gMTA7Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDCoApBY2tlZC1ieTogR3JlZ29yeSBHcmVl
bm1hbiA8Z3JlZ29yeS5ncmVlbm1hbkBpbnRlbC5jb20+Cgo=
