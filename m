Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204B780E0A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 02:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345639AbjLLBCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 20:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345624AbjLLBCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 20:02:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD11B5;
        Mon, 11 Dec 2023 17:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702342965; x=1733878965;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vezsuIUPZDhN69ypA7xfWk7jIkjSsdEK9TrJmqT6rGo=;
  b=cMDudnkbpppNxvFHSK58Sp4aA2xtcLkLfqlrOOdQKiGqum14tFGEAatW
   QmMjVRyWq1jLxUMjeZsjP2AwTXZtpJmNS2qfCkSAJSzJjrUFrJMZaywBX
   3cRq+tE9o+/L8VuD4XkjNFUFdiahVuUMcuOAJq+T1ydEDJ6qNuz+pNrbL
   NnkhfzsvPJa1GX+5iX3zvIoC8uLqBrS40zHExnG6dk3/+luYvtMtyywpI
   w7SrijG6lv7ugdtWegJ9CGiic9bXYg3xNfPn+gdzhpzmy1N5uxD6Ot2NB
   OaIH5cqdCKLguSwNJz/w4r/soVx2pQjCZO8lm0whNuxUVC7Lwk0A3ry9P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="459047063"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="459047063"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 17:02:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="917078335"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="917078335"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 17:02:43 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 17:02:43 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 17:02:43 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 17:02:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDYOXuhaylUXxQ/8wyF0XD800Ht37h2/ezIFQ/v8uSMt0Xi7HO5NrrXLx/PjRfB5sHzhaA+v58ND+fkDuRhrWzzifeOfLsILdiUoR3pN/tR40N1iDICeSCGeO4mzSBpvTfyEKYhqrJfepP7OmFonwq5BLVSThp64kAwLQ83nvw9QEXJozxfdCT8zC/PEdsKhS6VjrMtcIScvDeVkzIJmlujESJ2RSpBubkUlAYHbHYA1KSG37vANE2ZNtJXg3FyyJZbyiX7OL0ql/5dHJcaSZPTw1/YnfrjI8QRcxRVL1cGzSM36ILZ//H76HSNGvTjDJvvnTT29T3p3OV7va6YZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vezsuIUPZDhN69ypA7xfWk7jIkjSsdEK9TrJmqT6rGo=;
 b=Aw0I+NxLXZVoo+/ceT4N6CNk5xtF0n61lXGPMG7+8kysS3r9ZKKKuZX5Iha7ySZ1GRp0VRmiqotmsOaYaknz7pPBJ6Nfb6f+wHv015INbgl4xtUrtLqJk3Ue8bFG9szZ/3SfMyEgSyFiWgZmb0CjD++h+YxlmO1VjvhP6CEkif1duY4Fd4Dw53b3y6R/fnYgBDNk0zaAAqtaVvTI1/1OSGbGBGJXS0niRcqdzJMRNkJZloTwJMGrPfXlQmcM2KoQezXpfS7QpaVB60EsKPTt6GsMJtRlfX1V8XvmkXtv6z1wpq5jzVbWj/XEvSjw/q7enQuwjfdplLIaWEJ1hd8KWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by SJ2PR11MB8369.namprd11.prod.outlook.com (2603:10b6:a03:53d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 01:02:35 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694%7]) with mapi id 15.20.7025.022; Tue, 12 Dec 2023
 01:02:35 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [PATCH v3 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
Thread-Topic: [PATCH v3 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
Thread-Index: AQHaLIS7j/mMkSc9X0yJtHKbaRMzBLCkzGJ9gAACUACAAAT9RoAAAQ6A
Date:   Tue, 12 Dec 2023 01:02:35 +0000
Message-ID: <4b61641bdeea6aeeef0e5d76d2f6c7212dcb4ed7.camel@intel.com>
References: <20231211-vv-dax_abi-v3-0-acf6cc1bde9f@intel.com>
         <20231211-vv-dax_abi-v3-2-acf6cc1bde9f@intel.com>
         <87msugxnx9.fsf@yhuang6-desk2.ccr.corp.intel.com>
         <aac91f0ae8774c521469d518585a499da52912a8.camel@intel.com>
         <87il54xmpq.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87il54xmpq.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|SJ2PR11MB8369:EE_
x-ms-office365-filtering-correlation-id: 140bf39c-9901-47e7-a33f-08dbfaae0702
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zrgj1rQU5CmRPyi1y9S8RvLHX5uauH8yg3K+FlTHg3IUiP4rr2GU1Ln9XrGH1h3q/6xh0gnCr2I/c24Upn3QLoqYp/bdcN3Dl0f0+ixq5S+jucqasPNC8uZfXrHUosW2ztczRguacihmvQcNy3B7tmTjFEHmr5HAf94Lb0xxIjGnPV2OKklG5yXINrhlh3MrZppySaFpAFrSaJ5HQQbq+dy+CXBumA5qQ/tdbtM13dTCBBmR2+4zwAdInECxw3qfVJZ1rvkz88neA4/XuBPyWogt1HGRoA6rHfFYXbpS0vSSrJM+k/0VTsUjqwa/2tVrlt5nIJXc/R6Ae8rXlJnnafEsM/sELtmWIViNF8txiAt/kcn6+OZBKl9BNHQRQN4Qlqx913gHTXXbFxNvyy/MMFmWKdbAQfj7dCBMOFlyGDS2+Ov4uLhVNaC+i+NJ+TM8MfpC80jNRRSjDo2OLSHbqJqzCuAb6fTIjO7zRLP+r5CgC/pIRJHAxfmo2Y7+rG/6pamj1gXkBhQRMxHwgyifR3HpvtZHNj3XJVo/zUI9DwVwSmA0qTEmhAINTE+5MuAO+ds3CcjbEMZ25JzRFtdl8A0RrlMN2nrFF5bx+RbP8ISbPrp0U+k+O1EMkOBoH5/p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(6506007)(5660300002)(26005)(2616005)(36756003)(38070700009)(4001150100001)(64756008)(6486002)(66946007)(66476007)(66446008)(66556008)(6636002)(76116006)(54906003)(2906002)(83380400001)(82960400001)(86362001)(41300700001)(478600001)(6862004)(8936002)(4326008)(8676002)(122000001)(316002)(38100700002)(37006003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFJqKzdtUVlYa3pESGFsWHUxYnE3Y0FxY1oyeDFlcXA0Rno2ZS9HVjQ1dzVu?=
 =?utf-8?B?YUJqL1BuU3A1SDBpU0FoSFVKeHlrWTJWYkdoOS9lazc5LzZNcEs0UWhMQVIy?=
 =?utf-8?B?MUZXZW5VUzZySUJieTZNanFnZjJnYWpqbEV1RGdoOG5IQmNOZE1WbitDSW10?=
 =?utf-8?B?LzZjZmdhR0d5aDZDaTRodnB6dWRCbGpvRjU4ZjIwZUlrNHlyb1Z4NXZYckNl?=
 =?utf-8?B?QUpxZ1Z1K2J1dHdxaFZ4aHhYVzhaZ1JodkhWbnJiYkNVdEhYd3hkai9QdkVQ?=
 =?utf-8?B?NVo4cUF1VzNrVzA0bWMwVGsvYVdyZk83NUpmNjJlZXpKVm14Z1dlL0JDSjUx?=
 =?utf-8?B?d0x4cFdJSjZsK2FKNmRmRWh5UUlqbFRKZ1pYdXkrYlM4bnRGSmNQTVdlN3Jh?=
 =?utf-8?B?RHhqckpreVVDYmNmbDlnaEdOZDJBVHlMeU1PeG4rK2hDckl5VzlXaG9zS293?=
 =?utf-8?B?aDMwZWhGY00xWHkwVjhKUTJHTjBJUmRMMG9YUEd2QXA2TTRNbStlRU1iUTZQ?=
 =?utf-8?B?VXptaHZIdjk0cXZFZ3pYa282dmFoUVBHUUN2N1l3ZS9PZS9NQlRCMWlsY3ds?=
 =?utf-8?B?ZTErd2tkdW1EU1Z4Q2FhUm1qYmpsWXp5cGx1UGRlMXUxYTJNSFJKMjFpc1Zy?=
 =?utf-8?B?TjhlZzhqSUN5bGs2R2RNTjlzOEg5S3BXRFlXTmtkU0NBbCtZUkxtaTJkVC92?=
 =?utf-8?B?d0lCVC8xTCtFalhjbDduVWc2MXlGTkloeFJ4ZWlyNjBSTThaczdVNjRVRjJj?=
 =?utf-8?B?ZktwbzRZejRnQ0ZYTWw1eHJTWG1wSHVuc0ZzSDJrV1gvM0hVOEo3WVNhTmxT?=
 =?utf-8?B?djAxSVoxT2R4Qzh5Mm9zYWxSN2EzK3RXNlN2VENTenRiWlJySmpyYndrdS9Z?=
 =?utf-8?B?VFAyZFBpaDU4dzdxclg3VXd5b1laV05vZUhlUFZ2SHVJbm8rcmVKTTZaZ1BB?=
 =?utf-8?B?UVBZNmR2UUhjQkpZWGtIK0NsUEZUV2VDT2pvYjl0TGJRZloxaWRlOGtqWVFu?=
 =?utf-8?B?ek9ndzRqNVRTRGJMRWgwRDFLeVdmOWVCdWlzMTd6UXVVdjB0ZUpDenpTL0NR?=
 =?utf-8?B?NExTS3M0aS8zbUMxUGFEbEZqNmlYQ3phR2R5a1dla0FJSHpIS05DVGhsdXlP?=
 =?utf-8?B?WmxRdWRyeHI0WU55QmhOcWpPUVQ5MCtnaEJFWHRPT2hqdUFvUi80elR3b2Nk?=
 =?utf-8?B?RzN3R0lCbllUWE5udUp3dXUveFpUU1dTbXYvWjEwT3E1VjgyYVhLa1oxdXlv?=
 =?utf-8?B?QlVwWjVRN2JqdXZFM3F5cW16cFVZeHZYYzJUUDFFRVVES1hmelpLOXpKdVpG?=
 =?utf-8?B?L3ErMXc2QkUxNjNGVnpFU000YnFxTmdod2Nab0w5ZEM0eUUyQjUzSCsxUjFp?=
 =?utf-8?B?YS9xQUFWMkR5dGswTjErS09HdXhEZG5zMWc2MXNBaUVEeUo2WUFxM1BBaE40?=
 =?utf-8?B?aTRwR3FNcVNidVJXWFBQNGlJLzdlM1Njbk9tTDBLN3F1eFpRVVc1d2tPOHRt?=
 =?utf-8?B?aXhRcXluL3g1MHZzUzhzUWU4NDVhMmFBcGJmQmI1ZlVRYi9hQ01IdUxXZHlz?=
 =?utf-8?B?dXpibmsvVzNFMldiVFJHLzBJSGRqZ24zUnErT3ovNEdtOWUzT05JbDNTbUox?=
 =?utf-8?B?bkxhZ2hXNFg4Y25VeU1OK1ZpdkY3WXdvK1ZqZENpd3E5MUZSWWhXSWRIck5P?=
 =?utf-8?B?VUlPd0JNMHA1RW90Q2FFS2o2TkhIOHF6YlVkRXppelMwY0RqbE5iUDVzdU0v?=
 =?utf-8?B?K0hUK0w3dkEvRFNKS2xsRzZOUHBjeHp5VkhZNy9jejg3WmRGMGF4UGxRK01a?=
 =?utf-8?B?VXpBYUJ1cmk4WVVueFBzSXRNNnVGbEdQOGNKcDBzVWpTdE0veTIzQ1NIRXI4?=
 =?utf-8?B?dEh2cjVlQjFBS2NrZjczUnFLS3ZFWlNkRlFjeWlrNnQ4QllMQ1A1cHVXZ3ly?=
 =?utf-8?B?dmtGYmduUWVPMlp1K0dXaCtoN214SW5hRlcvQS9DSTljRFZjMlY5bThpTStT?=
 =?utf-8?B?VzMvLzVMbEQxcFMvY2JaYSs0SUd6RHJ0MlN1ZURvUVR4U0traDdQSVRNTXVa?=
 =?utf-8?B?UjJQYWZFc25HNG9VMkRYUSt4QkxQbkgrOHdLMTVSbkljZ0VLc0REcER2ZnpC?=
 =?utf-8?B?aVlDa0JUN3lXdUExUVJON0t4aHB2cGRjOGpLQ0t1dlJ4cnZjV2xDUEFuSTFl?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F02F6342C6C9E543A94FC187B6940003@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140bf39c-9901-47e7-a33f-08dbfaae0702
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 01:02:35.1453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4QED1tqJzBd9xRu/aERuG/Whqr2VALlCY952OZewJ0W1SejYQ8CsSzY86U1ILUovN5onHUbH9bHxdi43I4s7c92pzLuK1JHskERvXPcFFMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8369
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

T24gVHVlLCAyMDIzLTEyLTEyIGF0IDA4OjU2ICswODAwLCBIdWFuZywgWWluZyB3cm90ZToKPiAi
VmVybWEsIFZpc2hhbCBMIiA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPiB3cml0ZXM6Cj4gCj4g
PiBPbiBUdWUsIDIwMjMtMTItMTIgYXQgMDg6MzAgKzA4MDAsIEh1YW5nLCBZaW5nIHdyb3RlOgo+
ID4gPiAKPiA+ID4gPiArCj4gPiA+ID4gK3N0YXRpYyBzc2l6ZV90IG1lbW1hcF9vbl9tZW1vcnlf
c3RvcmUoc3RydWN0IGRldmljZSAqZGV2LAo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0
IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBj
aGFyICpidWYsIHNpemVfdCBsZW4pCj4gPiA+ID4gK3sKPiA+ID4gPiArwqDCoMKgwqDCoMKgIHN0
cnVjdCBkZXZpY2VfZHJpdmVyICpkcnYgPSBkZXYtPmRyaXZlcjsKPiA+ID4gPiArwqDCoMKgwqDC
oMKgIHN0cnVjdCBkZXZfZGF4ICpkZXZfZGF4ID0gdG9fZGV2X2RheChkZXYpOwo+ID4gPiA+ICvC
oMKgwqDCoMKgwqAgc3RydWN0IGRheF9yZWdpb24gKmRheF9yZWdpb24gPSBkZXZfZGF4LT5yZWdp
b247Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgZGF4X2RldmljZV9kcml2ZXIgKmRheF9k
cnYgPSB0b19kYXhfZHJ2KGRydik7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoCBzc2l6ZV90IHJjOwo+
ID4gPiA+ICvCoMKgwqDCoMKgwqAgYm9vbCB2YWw7Cj4gPiA+ID4gKwo+ID4gPiA+ICvCoMKgwqDC
oMKgwqAgcmMgPSBrc3RydG9ib29sKGJ1ZiwgJnZhbCk7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoCBp
ZiAocmMpCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJjOwo+
ID4gPiA+ICsKPiA+ID4gPiArwqDCoMKgwqDCoMKgIGlmIChkZXZfZGF4LT5tZW1tYXBfb25fbWVt
b3J5ID09IHZhbCkKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
bGVuOwo+ID4gPiA+ICsKPiA+ID4gPiArwqDCoMKgwqDCoMKgIGRldmljZV9sb2NrKGRheF9yZWdp
b24tPmRldik7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoCBpZiAoIWRheF9yZWdpb24tPmRldi0+ZHJp
dmVyKSB7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2aWNlX3VubG9j
ayhkYXhfcmVnaW9uLT5kZXYpOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiAtRU5YSU87Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoCB9Cj4gPiA+IAo+ID4gPiBJIHRo
aW5rIHRoYXQgaXQgc2hvdWxkIGJlIE9LIHRvIHdyaXRlIHRvICJtZW1tYXBfb25fbWVtb3J5IiBp
ZiBubyBkcml2ZXIKPiA+ID4gaXMgYm91bmQgdG8gdGhlIGRldmljZS7CoCBXZSBqdXN0IG5lZWQg
dG8gYXZvaWQgdG8gd3JpdGUgdG8gaXQgd2hlbiBrbWVtCj4gPiA+IGRyaXZlciBpcyBib3VuZC4K
PiA+IAo+ID4gT2ggdGhpcyBpcyBqdXN0IGEgY2hlY2sgb24gdGhlIHJlZ2lvbiBkcml2ZXIsIG5v
dCBmb3IgYSBkYXggZHJpdmVyCj4gPiBiZWluZyBib3VuZCB0byB0aGUgZGV2aWNlLiBJdCdzIHRo
ZSBzYW1lIGFzIHdoYXQgdGhpbmdzIGxpa2UKPiA+IGFsaWduX3N0b3JlKCksIHNpemVfc3RvcmUo
KSBldGMuIGRvIGZvciBkYXggZGV2aWNlIHJlY29uZmlndXJhdGlvbi4KPiAKPiBTb3JyeSwgSSBt
aXN1bmRlcnN0b29kIGl0Lgo+IAo+ID4gVGhhdCBzYWlkLCBpdCBtaWdodCBiZSBva2F5IHRvIHJl
bW92ZSB0aGlzIGNoZWNrLCBhcyB0aGlzIG9wZXJhdGlvbgo+ID4gZG9lc24ndCBjaGFuZ2UgYW55
IGF0dHJpYnV0ZXMgb2YgdGhlIGRheCByZWdpb24gKHRoZSBvdGhlciBpbnRlcmZhY2VzIEkKPiA+
IG1lbnRpb25lZCBhYm92ZSBjYW4gYWZmZWN0IHJlZ2lvbnMsIHNvIHdlIHdhbnQgdG8gbG9jayB0
aGUgcmVnaW9uCj4gPiBkZXZpY2UpLiBJZiByZW1vdmluZyB0aGUgY2hlY2ssIHdlJ2QgZHJvcCB0
aGUgcmVnaW9uIGxvY2sgYWNxdWlzaXRpb24KPiA+IGFzIHdlbGwuCj4gCj4gVGhpcyBzb3VuZHMg
Z29vZCB0byBtZS4KPiAKPiBBbmQgaXMgaXQgbmVjZXNzYXJ5IHRvIGNoZWNrIGRyaXZlciB0eXBl
IHdpdGggZGV2aWNlX2xvY2soKT/CoCBDYW4gZHJpdmVyCj4gYmUgY2hhbmdlZCBiZXR3ZWVuIGNo
ZWNraW5nIGFuZCBsb2NrPwo+IApPaCwgZ29vZCBwb2ludCwgdGhlIHR5cGUgY2hlY2sgc2hvdWxk
IGhhcHBlbiB3aXRoIHRoZSBkZXZpY2UgbG9jayBoZWxkLgpJJ2xsIG1ha2UgdGhhdCBjaGFuZ2Uu
Cg==
