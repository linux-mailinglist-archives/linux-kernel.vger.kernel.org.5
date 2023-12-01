Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840EA8011BE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378934AbjLARbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjLARba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:31:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E76170B;
        Fri,  1 Dec 2023 09:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701451896; x=1732987896;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=02NLGA95FcR4Cu7i/MTICDe/T+2HcM9PtGS0aT0OokM=;
  b=brBbfwqjmM4oWS//I9hhjqePNlY4/dGhrl4JxdHdJ+RMgxzXFFjP6D49
   sJeKSeXzaSv29BhY6RZ/rl46t6q/7z1jwN5R9JyZTSng6J9PIy7ku4Ymg
   uWf8oq32AIJAt+ACKsgWcYrapGz7vOk59KpDCHSYqIOAFHvRXyE8OD2li
   TJx1qxzDSvq5Ibt3PAot0EDLokWqq+CqTmBsPfFTbfo5KjgkZQPJIkaAg
   T0qKcVlVDO+1BAgrBg+0rFDtZops44p27mB4AtpVdB7btE3EdyGrys6xc
   II8/iZMyw0BcH0lLR9h0zfWxZKjaN0SUtMMNGH9F4ri/WsZeewwATitcC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="424684557"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="424684557"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 09:31:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="798792605"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="798792605"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 09:31:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 09:31:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 09:31:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 09:31:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTtRJGg9t9hSiwOdNVKZva7YbDP8GuvrTmDuMzWAHFY6G65rnQRd9FO8meSqWKmckpI8KqgmlbDsPLc4QtUH4jnT558e8Jr9KGwxclMhg8YGX/bAg8k/GY13z0Nb4T6oiP/N1+tkGyaCU/JmQprx54QRT1z8D7gy7Z0pc4Rb8CVr1zvxF+OMLjdsCIxJaH6DpBqUI8Jo0kL+H4xZlkQ8UfWP6aNLO7sPJAsaqDkweUgQfFF3sASQctyKjg8pqVMcu2PUySRMZ9wjOLVT9zAwEfNaTfR4tAtzZhL+wpPw143Qt0GJSqOsnjGHyv9Vr4csSOacQFmP99ud2a9IwXzsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02NLGA95FcR4Cu7i/MTICDe/T+2HcM9PtGS0aT0OokM=;
 b=IoniTrMdvtC+VhV+RGErV9LN7QfOqW16qcxjO6Ae5rXUwvBqpeeD2Isahi3vRkS5Vd6N0jFMCfyELXNR5hbD7Pyrs6kItJ6k/BsVGPzLXEvSrP8ZlrLAfIqvVk96vndCkJmwoSuq+upvJCcd0riarmHxcfBwqOzHciUrDcV9wtT27iMF6trrxdjz07ryWnbFfNWWy38G1tK2fi7McB6a0Ng49cEOOkLTPCNocr/Ku3F9m6Pr+grkTRcKoV/3LXh4kRQGkDpZZWRTqwD9eV4/f6sm0O0p2n4gLDCqIIpQsMyu6NgxV1aDgpuqwi0RlmAva6p2rhKDLsP3iAvP2udJtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 17:31:32 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d%6]) with mapi id 15.20.7025.022; Fri, 1 Dec 2023
 17:31:32 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "ashok_raj@linux.intel.com" <ashok_raj@linux.intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>
Subject: Re: [PATCH 2/3] hwmon: (coretemp) Remove unnecessary dependency of
 array index
Thread-Topic: [PATCH 2/3] hwmon: (coretemp) Remove unnecessary dependency of
 array index
Thread-Index: AQHaITQXCxl0zeU+3kak6dR4reLyB7CTqI4AgAAhZICAAOwXgA==
Date:   Fri, 1 Dec 2023 17:31:32 +0000
Message-ID: <f22c891c38f01af65f7f51176045a66e537ad176.camel@intel.com>
References: <20231127131651.476795-1-rui.zhang@intel.com>
         <20231127131651.476795-3-rui.zhang@intel.com>
         <ZWk2ZAxuyOFDCTmv@araj-dh-work.jf.intel.com>
         <b4723259-92a1-4c9a-8f4a-52b4b61940c5@roeck-us.net>
In-Reply-To: <b4723259-92a1-4c9a-8f4a-52b4b61940c5@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH7PR11MB6498:EE_
x-ms-office365-filtering-correlation-id: caa34e93-0ba8-43f7-6df7-08dbf2935c61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uHMjxCqz3rnNJknesfa1xeG0oIkhQkY9vZ2+wYhSzlSKMCFfPQtRMhCggzBIukJQt+0mLzScmbdkU/MmUx/LFjlLL2jP5zRYScecNlaXCLoSOJ9G8GckczTV2l4RZM3honp8e64DKNQUOHvz9M/eG271RmE1U/eVWpk7lCQpjHte6G3J2rk02fDGa9kJzClMIQ5dGeUqqBHgcCtw2ZLXcoFmF5CSdZkxQfAKMzh4jsN8AAj933Fr8SdCUlfqF9TYPK0ofE4qwNe6BdZcnejS41hYymd/STdnaXIoZ0U/LyGf3WOuZwwATflAEnCnquXNHEtxTSm8GHH50DnSfT0kArU7aK2s43BUdp9xAwvfyJ/Tx95Zn1g7GfE6GW9YLvin0IG8k2bJJRWPfu1eYdPo0i61Sp/kAyG0uiYzsMrIbT8X1MrioFUdH3vUU7rhUqNv0EGZZMMvQNQyDat39s1MB1QeeyDmrJPa2AVITgXFamqrNx5DzusspNuU4vRny+RlHVT5z0NyhBlSSKH21A+Fg4aKe32EG+o1N7IF5JFI1mVNfz070dc/PYMzRDsJ6wPlrZPw1pV/ICm+dQw+tMUM0AiTmkMH85nk6/XwBVS5Jp3p3XsZICd7vuvnWyKsOhDe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(4744005)(5660300002)(2906002)(8676002)(4326008)(64756008)(316002)(54906003)(66476007)(66556008)(66446008)(8936002)(66946007)(91956017)(76116006)(110136005)(26005)(6506007)(71200400001)(41300700001)(6486002)(478600001)(6512007)(2616005)(83380400001)(38100700002)(122000001)(38070700009)(82960400001)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDR1WnlIMHVyTWFBdGFtRElDSkdZcU1xZ3BHSzVXMm9nMHExMjlFNG5pZVJ2?=
 =?utf-8?B?bDBPZTVKM2NYaXpXL01PYU9HUXIzT0paajYvZWdvU1JFWnFMQUtkUUhjbDlm?=
 =?utf-8?B?SzgrbG10cHpJSnVsbUE5cmZHbUh3ai8yTTl6Wmk4NmZ2Z05SaFVFSzlUQllV?=
 =?utf-8?B?cWpVUlF4Q1RVZ3NINkhTL0RRVW5Sck1ZeU5mdjcwZk5MTlVkRkVOS3NnSzRZ?=
 =?utf-8?B?SkVDRzgvNUovNTVzWGc0NmNOWmR0aDBXT3Z4TU5HOVNycUJvK3U4UzVxblg4?=
 =?utf-8?B?YTJpQ3d1L2FHYlhGU1hEWGNOalhQd3ppZlZtRGtBK3dyUEJMYXRXUTdqU1dR?=
 =?utf-8?B?YXQ1K3YxbGtNMk8wU1Zhbzh0WU9kRnVXYmh4ZWM3V1UyR2RCTW05NXRnZEFI?=
 =?utf-8?B?dnlkMzBDU3ZTNThyaHpGRThLWjE0L1ZkSDhZK2JNUEpNZk9pQUxiZ0R4dElr?=
 =?utf-8?B?eVhhL0NVcnJFQ0xGUDVWUWJGejUyaVZic3N0RXFHSmlFa2hlMlVsck5yTk52?=
 =?utf-8?B?VGQ1NE9mdmhkTkpaYURCUkpYakZjUmxFMFdoT3BtSHRYYmljZDdudllYL0Fj?=
 =?utf-8?B?YW9LU1JZMTQ5REZEd3FqdnNISVJ5b0xjVlNLdzQ2b2tYQ1Y5SmhKdGxvdHVq?=
 =?utf-8?B?YUJMSUVsMkdVMEUvNEdvNUE3S2ZGcmJQbWR3TWhoWFZaT3NaR3VNdnpyYlJp?=
 =?utf-8?B?cTZWUE8rU1A1R0tXYy8xNFdYem5McTBJVk5nQ2xYQXVXNDJ4TlZ2aWRvTk43?=
 =?utf-8?B?N013RnZwUmUzTU95ZnpJK1EwbzVJVFk2emxqY0FEb0JzcXVIWHcxM2x0MGs3?=
 =?utf-8?B?ZDk5Szl2TllPVnQ4MVpDUnR5cnJjS09IUmtxT1kzalFOdEFjeUVkVUJrajNt?=
 =?utf-8?B?Wk9XS1VObzl5QlU0MDJnMmJud0dXNUdUbVFCNXVuWDZoQi9JQlhtbHBFek9r?=
 =?utf-8?B?c1NZcTBSWmowS3Zjc2pMMlN4NERUOUhWdG5TL2YxOFRpaXZLaER6QmFiNW1P?=
 =?utf-8?B?V0lTWEg2cDVwMDNaUWxIUUlPcGJjYXlQbTV1alg2QVRKNEI2Y3pPbjVVZHhl?=
 =?utf-8?B?YWRQWHJJblVUN1Zidzc3OHFyYW42SmNnYVhFOXRvZ1praGZoaEVDWlpkVzdo?=
 =?utf-8?B?emRSSU04Wm9ESkhxb1U1aG1qeHhUZ3VaQTIzNDI1b2Z4VktnbFlldUllRjhM?=
 =?utf-8?B?bytJbCsvTXJnblZaV3NCbFhkM1VDcDZqSzZUVFgrSS9YbjJlemRLOGNyelg4?=
 =?utf-8?B?R2x4YXdyTlFLcmNKZGUzYW9vZWFwSkw5dFVaR3FDZyt3ME1wdmlJR2I0azZP?=
 =?utf-8?B?emRORW9XNnZRb3M0d0RHUG5Ncjg2ZEdXMzRhUnFUZmU3UHJaUWdKMVFWV21F?=
 =?utf-8?B?WjJycW5kd0d1dGkxY3dLNHRqdXo2bkdsOFhnb2lvNlNHWG9QRnBjN1pLRk05?=
 =?utf-8?B?OWlaRFBOWnBnWGhuUnY5VUg2UjdYRTczKzFvTDF4MGNZeEwxWVM0Tm54NHdn?=
 =?utf-8?B?WTY4RGx3by9xakJydTlZbGJYKzNPZ01JbytVUUZYSGNxL1hsaUJaR1NxaGhk?=
 =?utf-8?B?aDcwV2pwMWFUZDNlb3dWMEVSMkMwNkJOOVFmM0YwWkl2SGhNZ1lJcHBNTkRF?=
 =?utf-8?B?d0dFTGcxQXBXdE5sdVVsYzdjNVcxTG9TMmI1aXVCUHJQWC9RdWwzWHlSdjV4?=
 =?utf-8?B?VEpXZk5MMjlTNnFVZGRtY0JDd3FqeDJ4d0dpeHYxSlBCUUpRNHRoU0dHaXB1?=
 =?utf-8?B?cmVRRUZzK25TRmFEdEh0cXE5ejBSY2FRODhzS3pZS0VoRWRwR01BdElUN3VR?=
 =?utf-8?B?dngwOUl6dG1PNElWWkJvaEpmempDKzVHWTRNdTZzenc0NCtVN012RDYvdjJn?=
 =?utf-8?B?QWQ2SGJBU3V3OEZSVWRZbFUxaU9UdHFlV1dPT2pSelR1NXpTblN6ZlBnNXhN?=
 =?utf-8?B?WTdmeWpIYUc5cE1XdmltajUvNm1HWFk2MlRyR2Q5L1E3MjNweTZLK2oyb2E3?=
 =?utf-8?B?alg3ZUxLMEVFZmZzZUcvTzlHb3FBMDZCQldNU3NPeGliZkk1SllCMGlhNG5G?=
 =?utf-8?B?Y0NrQXFTUHRmcXNuTEY2THIrbnFteWlJcnRNQjFmR3dpMCtZejAyWmtQSmpV?=
 =?utf-8?Q?2COPgGipSY23Iu7N5GYGHT/nT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36B318F8BF7A5240B01D6A4FB9D5B107@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa34e93-0ba8-43f7-6df7-08dbf2935c61
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 17:31:32.6873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26MdazYVd2cM6s94P1AvA0+I7s56EBjsJKPELaLT0C72+Fi79p+jCZbAOUHIwwbqZCCSyYOZKvX4JsATWjAKqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6498
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgbXV0ZXhfbG9jaygmdGRhdGEtPnVwZGF0ZV9sb2NrKTsN
Cj4gPiA+IEBAIC00NDUsNyArNDQxLDYgQEAgc3RhdGljIGludCBjcmVhdGVfY29yZV9hdHRycyhz
dHJ1Y3QgdGVtcF9kYXRhDQo+ID4gPiAqdGRhdGEsIHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGRhdGEtPnNkX2F0dHJzW2ldLmRldl9h
dHRyLmF0dHIubmFtZSA9IHRkYXRhLQ0KPiA+ID4gPmF0dHJfbmFtZVtpXTsNCj4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGRhdGEtPnNkX2F0dHJzW2ldLmRldl9hdHRyLmF0
dHIubW9kZSA9IDA0NDQ7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRk
YXRhLT5zZF9hdHRyc1tpXS5kZXZfYXR0ci5zaG93ID0gcmRfcHRyW2ldOw0KPiA+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRkYXRhLT5zZF9hdHRyc1tpXS5pbmRleCA9IGF0dHJf
bm87DQo+ID4gDQo+ID4gSSB3YXMgbmFpdmVseSB0aGlua2luZyBpZiB3ZSBjb3VsZCBudWtlIHRo
YXQgImluZGV4Ii4gSSBjYW4gc2VlDQo+ID4gdGhhdCB1c2VkDQo+ID4gaW4gY291cGxlIG1hY3Jv
cywgYnV0IHNlZW1zIGxpa2Ugd2UgY2FuIGxvc2UgaXQ/DQo+ID4gDQo+ID4gQ29tcGxldGVseSB1
bnRlc3RlZC4uIGFuZCB1bmNlcnRhaW4gOi0pDQo+ID4gDQo+IA0KPiBJZiB5b3UgaGFkIHN1Z2dl
c3RlZCB0byByZXBsYWNlDQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgc2Vuc29yX2RldmljZV9h
dHRyaWJ1dGUgc2RfYXR0cnNbVE9UQUxfQVRUUlNdOw0KPiB3aXRoDQo+IMKgwqDCoMKgwqDCoMKg
wqBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSBzZF9hdHRyc1tUT1RBTF9BVFRSU107DQo+IHdoYXQg
eW91IHN1Z2dlc3RlZCBtYXkgYWN0dWFsbHkgYmUgcG9zc2libGUgYW5kIG1ha2Ugc2Vuc2UuDQoN
ClRvbyBsYXRlIGZvciBtZSB0b2RheS4NCkxldCBtZSBjaGVjayBpZiBJIGNhbiBjb252ZXJ0IGl0
IHRvIHVzZSBkZXZpY2VfYXR0cmlidXRlIGluc3RlYWQNCnRvbW9ycm93Lg0KDQp0aGFua3MsDQpy
dWkNCg0K
