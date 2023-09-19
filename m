Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800DA7A66D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjISOgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjISOge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:36:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FEABE;
        Tue, 19 Sep 2023 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695134188; x=1726670188;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OI/c3YpgOm9GdA6eymWMPF/UAEItTPfe9wWtBhqmXZ8=;
  b=gipkjHlAPt2NQSh2jTxMM1/P2QbwfV2npm16RRuWTy2iBe+T4PXQr8jF
   0DUVgXYWnjZ4cdm9abqaAjAso1EmGw4MmuSoFOD92JyBvb18E5gJ/9We/
   3fSagvn1NjY4RzVYupRvDNjTkxQC+zQaKoxpcD0biTqMrMnX/KzelFkbH
   adb5UssCCK8VhpfENDUsQdnH6N+hOb2r+MVgEJgZs8fcfsE+9hrGiYsJ6
   iKFpoFUfkInVG7lrvaDMUXeadih70lU2koKyrIcV8x2Y9xec0QoBsIcUf
   qSwoTWEpYTdmYrmFlbqZMTfE1r5UBq6UhbUbYlDYgRS3lMAu+tFv+klC6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="382709761"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="382709761"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 07:36:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746262825"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="746262825"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2023 07:36:09 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 07:36:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 07:36:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 19 Sep 2023 07:36:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmtqiL7PGpGz7vxCf2ZE3CPUquLKGJ8T3rTamOG6nUpfQPxHhP1q8CQ4x5HwV+/YWY1hma/oSD76DPRipxlEDXBzm3jd42wq4f5Ew0GG6s1PXtFohLI1GHQQUc2/HYmJPc7wkKbLKmIxujakVm9t0c7y6LJ05oYcLxK2pR0lJ9MxyEirbeUJfnrCzOCIADWh0XMkr8YG0XNSIFNGN0BlGghlH/Xp1O3fWx9O+MbpHXadj5Gjo8f63MNx9pGrm/yw/4awgQtpPyXF5BIdSyS6+pTUolEt+EVBGE72bqc6wKxlkUMrGUmBa0WQZC7xYycFKk6vq+w5LNDKgXclJrsw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OI/c3YpgOm9GdA6eymWMPF/UAEItTPfe9wWtBhqmXZ8=;
 b=hw/gFBWex81hTJPawnXp9fyGayw+0Vyemdv24oYRd65grr7RDZD70/RthTDo4FSi8KA1LnvbH+pwiaMIQrdKCwt2rh/GeyOQQutLMnBfCXIPaUHl5WKddq+tR8uzyMJuTTYD5BeGccDa0C7h4yZeBlaiKfw3F/62MKYF4fyCjhG9ueEOsNbBP67CL/Dlb/UbRJ8dUrTVsulU3QvZeSwJuDNetokGqLZJW4nxuW4kudcaFs5KC91p66HyAD42skj+GtyOz+qPgdFl/kUtsVHAxnJG/a3jzoji6ZTiLZiqcvMuq/VPlFFZ9lVTAI6NTaB40em9yqgxw7qop0q6Mb91ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY8PR11MB6867.namprd11.prod.outlook.com (2603:10b6:930:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 14:36:07 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 14:36:07 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
CC:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "Babu Moger" <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 8/8] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Thread-Topic: [PATCH v5 8/8] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Thread-Index: AQHZ2tLQzZViQZuDwEGXIVxBB0yNB7AO4J8AgAC3GnCAEj3NgIAAfdyA
Date:   Tue, 19 Sep 2023 14:36:06 +0000
Message-ID: <SJ1PR11MB608362BE12F47FFA54381FB9FCFAA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-9-tony.luck@intel.com>
 <TYAPR01MB633033C489AAC0E514CBC6688BEEA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <SJ1PR11MB60839EB5CC3D172D864DF7A7FCEEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <7gbxb6kxwa6anvcc4dquyuu7yronww6ztelazn2xllplorhbp5@i7o4fum5tjuf>
In-Reply-To: <7gbxb6kxwa6anvcc4dquyuu7yronww6ztelazn2xllplorhbp5@i7o4fum5tjuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY8PR11MB6867:EE_
x-ms-office365-filtering-correlation-id: 39fea4c7-aa40-480c-dfe2-08dbb91dc261
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/tEP3qhq8xGDRljW4UzxT2Bsm2rfJDT+x3EiD48QZyp68NfApy5dgMCucQsFpJSrTqZUJupF8LUsyZd9n8ZczRRSqBUllNKRqSYODm9+GOyM6CoUSfflwjgedr7SAr5wllIENh1ioiuP3rZ8JtFRL9/X+6udVDzcsouAZBBm89BncbA2mhfrhZxi9usWZQqvS2hKu5DkajDStd1vbN8GjkgvdF1IcjOVSi4G+b77YvdBDdl5GST/nFEMS5YsdVh855bLdixCJZv0nsdCJshL7CrmrOI8DMYDKTXAyeNz5vf7FA+0iUHhWsu81OqN0JxJIr9QbSjsAQjBh8Y4omy282e5xaoxOdVCXczGWL1JPfKIdr+NTGJ1+uBR+RPy8rqPNmZKpHModTewv0+wAt8aW+urNMfjFspPL0h33OYT3C828wjDtBG6BonMcZnH3N/djp5K8ftUUenL9mQxthpj87WQIaG/1dhAz6ZhESfkw1HRIuDbJxEkjcEpSlMs7aOW+kGSUcBl3fcN2O8aLQJcs/ZNntYv48EDbN9/79s0G7NYz/BLtBDMjVpnf0iFwEel2l6fxKuZGTh58qytzNdkZSZbnG+b2QJ6CQcXkTSRcsTPArXkvD9AN+6K0zjgwJO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199024)(186009)(1800799009)(122000001)(38100700002)(82960400001)(38070700005)(55016003)(33656002)(86362001)(478600001)(66446008)(66946007)(6636002)(54906003)(64756008)(66556008)(66476007)(71200400001)(9686003)(2906002)(76116006)(6506007)(7696005)(8676002)(8936002)(5660300002)(4326008)(6862004)(52536014)(7416002)(41300700001)(316002)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2U1NXRJc1pYbmUzZXJ2R01OQWRkdDN5d1U4a0ozMFhSSU9ERDJaU01qRVlW?=
 =?utf-8?B?UGtsTzlzSkg5eGpFcUEvbGJPK0lSRUVEMlJlWGRtYStQOWlBRjgrTGpQN2dZ?=
 =?utf-8?B?Y1VFSnZESmh2d1RTa1ppTTRnTlBnTHVYVXl5OVRseXJ1MmovdWJQeVBYWkhU?=
 =?utf-8?B?Nm02Yk15WFoxQUIwenc5NXNBM1BzNXhodW8yTDFFdDN0OXNLV3Jvc0N2Wk1j?=
 =?utf-8?B?SmlYZkdjdHlZTkdGN2pPd2NLTWhRUms4bjA0eU1wWkt3a0JBeW5kRkdTdG9I?=
 =?utf-8?B?VFZ2WkREMFE5VGl3SHc3azExVFdsVzFBeDlsMzU0d1VuZi91YmcwQ3JZQUtN?=
 =?utf-8?B?U1FmMjlxSy9qcWxwdjYwYjRoSkxRNU5jeEpWNjBoYlQ0YVAzUmdLeUJ2c0NB?=
 =?utf-8?B?bXhyaXZXQjlnM0xVeTgzY3J1SThZYll3MUZoU3RZKzNuZ3gzT2M1cHNOa2ZZ?=
 =?utf-8?B?R1JhTUhSczVoS05wSzU0bHlVelU1QXNWRUg2bnFtQjBULzRwMGQxaFoydk9B?=
 =?utf-8?B?Nk9rQi9Remo5eENFS2NNZGR3UHF0NHMyU25tZUlScEd4ZStYdjI4L1BZZldh?=
 =?utf-8?B?QVF6cWl0R084YW1OS09iUkV5MTEwK1BKRHN4QUJXb3U0ZnNuYnFrd296cnhj?=
 =?utf-8?B?elNMT1BSTjYxcjRWY05FTCtRYmpndDZobkk2Tzg1ZkxGekNOS3RnMzg4WjRv?=
 =?utf-8?B?UU1idXQ5V3J4VmpQeWVWbkdCMXBSeGhIblR3TGVUYlNzdHo3N3ArSVQyREFz?=
 =?utf-8?B?Zkw5c1NDWTdLb0h5WXljdHljeUV2em45NG12UlhCODdxZkw4bWpBWXpDNHNT?=
 =?utf-8?B?QVJxYm1pbU1rbXpaNXhRTkJNcllXTXlqMGIwZUxGNkNvVFBzemZ0Q3ZpWUQ4?=
 =?utf-8?B?RFFQLzZ5NXM2N0Y0NmpoY0M4MFVLWXB4T3NDR1BXNWZUK09IY1I5OFBlN3p4?=
 =?utf-8?B?YW9mWVR0eSt5eTBJY1dYN0RJajA4Wk0yU2gxUTJHa3RmZHRHLy9GZTZXVmxR?=
 =?utf-8?B?clZoY3ZEa3k5MWlSTVZ5MXVWNisxeExuRHVWRy9tMGE1QlEybGtYY2dPMW9q?=
 =?utf-8?B?SzlTZ2g2bjQ2TEtsdzlZMlNOTmZ6cVhHOFgwL3Y2TS9QaFR0Vi9aRElhMzhh?=
 =?utf-8?B?VGFiVzRZbkc1Z1lsN29NK2RUWWJJQzFEQmtObTRHc001Wi9Sd2lreWV5L2FE?=
 =?utf-8?B?OE5XTjFIc1l5VmVMbVc4UXNpVmQ2eERLRGYwR2U5Nmkwc2hhOGFBejBIZk5l?=
 =?utf-8?B?N2hnRnJwQnpEYzB1aUJ2T3FGZFhFZXVLRGdaYkVXSWxnL3l1dVgwR3JSWm1V?=
 =?utf-8?B?eDYwT2RNVVdRRU5pL0IyVGR4L2pBMG1BTUpkMFZ6b0JoUGk2cnZpUml6cVBX?=
 =?utf-8?B?MEFHVlpob2lHVFAzbGQvUndrZmFQdnh6dHhMQ3JqSVd5Z2xVaG1MMzFOT2Fm?=
 =?utf-8?B?ZHl5YW13MFdKeEFNMkRNMUJVTklQS2o1Y3Fxbm1xYVhRSGovZmVUMzJZVXdT?=
 =?utf-8?B?ekRiUzl4V1lqclYydnQrL0ZxZTVDZGtoRnFGbWplRGNWZ29weUkzRmhKSHV5?=
 =?utf-8?B?UlB4NWtrSTc4QU53WXVVazRDUC9qS0k0SFFkODc1amJhcFMwVUREWXk1cWI0?=
 =?utf-8?B?VHFpQU0zV1E5R0FtSmp0aklyalljQ1pJZnBWTVI2WDEyby84MFJYckRUeGdo?=
 =?utf-8?B?UHlYVld6eFJHTk91cjdiL3lTc0lKM3BvMWRyL0hvZ0dObUVYNTlEWW5KbG5P?=
 =?utf-8?B?c3pFbm53T1c3QkxCNFYveTFZN3BOam5nOUxXQ0xTaEF4ZFpMYkJlV1hCWXJ2?=
 =?utf-8?B?RG5aUEtWU2xrem4wSVF5bGIxZVBpM2N4MGJPNzV6RTJtK1ZQNmFjSVhPTXIv?=
 =?utf-8?B?clR5Tm5jWXp6dE9oejNFNG54NUI4WFpucXhmZytreXFmbWc2aGhyQ01rZWti?=
 =?utf-8?B?ZElRcTZEMTVpdkoydWxSVW5nYnJIVWxMY3krUFdRa2pHbFk3UXV6K2NyeGUz?=
 =?utf-8?B?c3hhaEpFd1dyeFNDbyt3djFTdlZsTGFDaTVzcVhBaGxPY3lLMjNheEQyUFVH?=
 =?utf-8?B?M2xoTThVakJwa3h3dThWS0l6Yk5DSGNVd2VjdytrbHh6eGlLTG9Va2ZwdTQx?=
 =?utf-8?Q?fEAAxph5+iXuLxow+m6nHZiIZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fea4c7-aa40-480c-dfe2-08dbb91dc261
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 14:36:06.9189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOx9keliS4/h02KZicR3B+lvw5ZsKknSm35KsaU6YNzMKf3lYVbVMBLJ4I6/JqchwDLAUEBLD67RUYLJ901MXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6867
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBhIHN5c3RlbSB0aGF0IGhhcyBTTkMgZGlzYWJsZWQgdGhlIGZ1bmN0aW9uIHJlcG9ydHMg
Ym90aCAibm9kZV9jcHVzIg0KPiBhbmQgImNhY2hlX2NwdXMiIGVxdWFsIHRvIDU2LiBJbiB0aGlz
IGNhc2Ugc25jX3dheXMoKSByZXR1cm5zICIyIi4gSXQgaXMNCj4gdGhlIHNhbWUgb24gYSBzeXN0
ZW0gd2l0aCBTTkMgZW5hYmxlZCB0aGF0IHJlcG9ydHMgdGhlIHByZXZpb3VzbHkgbWVudGlvbmVk
DQo+IHZhcmlhYmxlcyB0byBiZSBkaWZmZXJlbnQgYnkgYSBmYWN0b3Igb2YgdHdvICgzNiBhbmQg
NzIpLg0KDQo+IElzIGl0IHBvc3NpYmxlIGZvciBub2RlX2NwdXMgYW5kIGNhY2hlX2NwdXMgdG8g
bm90IGJlIG11bHRpcGxlcyBvZiBlYWNoDQo+IG90aGVyPyAoYXMgaW4gZm9yIGV4YW1wbGUgY2Fj
aGVfY3B1cyBiZWluZyAxMCBhbmQgbm9kZV9jcHVzIGJlaW5nIDIxPykuDQo+IElmIG5vdCBJJ2Qg
c3VnZ2VzdCB1c2luZyAiPT0iIGluc3RlYWQgb2YgIj49Ii4NCg0KU29tZSBDUFVzIG1heSBiZSBv
ZmZsaW5lIHdoZW4gdGhlIHRlc3QgaXMgcnVuLiBFLmcuIHdpdGggb25lIENQVSBvZmZsaW5lIG9u
IFNOQw0Kbm9kZSAwLCB5b3UnZCBzZWUgbm9kZV9jcHVzID0gMzUgYW5kIGNhY2hlX2NwdXMgPSA3
MS4gQnV0IHdpdGggb25lIENQVSBvZmZsaW5lDQpvbiBub2RlIDEsIHlvdSdkIGhhdmUgbm9kZV9j
cHVzID0gMzYsIGNhY2hlX2NwdXMgPSA3MS4NCg0KDQoNCj4gSWYgeWVzIHRoZW4gSSBndWVzcyBz
b21ldGhpbmcgbGlrZSB0aGlzIGNvdWxkIHdvcms/IDoNCg0KKyAgICAgaWYgKG5vZGVfY3B1cyA+
PSBjYWNoZV9jcHVzKQ0KKyAgICAgICAgICAgICByZXR1cm4gMTsNCisgICAgIGVsc2UgaWYgKDIg
KiBub2RlX2NwdXMgPj0gY2FjaGVfY3B1cykNCisgICAgICAgICAgICAgcmV0dXJuIDI7DQorICAg
ICBlbHNlIGlmICg0ICogbm9kZV9jcHVzID49IGNhY2hlX2NwdXMpDQorICAgICAgICAgICAgIHJl
dHVybiA0Ow0KDQpUaGlzIHJldHVybnMgIjQiIGZvciB0aGUgMzYgNzEgY2FzZS4gQnV0IHNob3Vs
ZCBzdGlsbCBiZSAiMiIuDQoNCj4+IFBTLiBJIGRpZCBteSB0ZXN0cyBvbiB0d28gSW50ZWwgSWNl
IExha2VzLg0KDQpQZXJoYXBzIGVhc2llciB0byBwbGF5IHdpdGggdGhlIGFsZ29yaXRobSBpbiB1
c2VyIGNvZGU/DQoNCiNpbmNsdWRlIDxzdGRpby5oPg0KI2luY2x1ZGUgPHN0ZGxpYi5oPg0KDQpz
dGF0aWMgaW50IHNuYyhpbnQgbm9kZV9jcHVzLCBpbnQgY2FjaGVfY3B1cykNCnsNCiAgICAgaWYg
KG5vZGVfY3B1cyA+PSBjYWNoZV9jcHVzKQ0KICAgICAgICAgICAgIHJldHVybiAxOw0KICAgICBl
bHNlIGlmICgyICogbm9kZV9jcHVzID49IGNhY2hlX2NwdXMpDQogICAgICAgICAgICAgcmV0dXJu
IDI7DQogICAgIGVsc2UgaWYgKDQgKiBub2RlX2NwdXMgPj0gY2FjaGVfY3B1cykNCiAgICAgICAg
ICAgICByZXR1cm4gNDsNCiAgICAgcmV0dXJuIC0xOw0KfQ0KDQppbnQgbWFpbihpbnQgYXJnYywg
Y2hhciAqKmFyZ3YpDQp7DQogICAgICAgIHByaW50ZigiJWRcbiIsIHNuYyhhdG9pKGFyZ3ZbMV0p
LCBhdG9pKGFyZ3ZbMl0pKSk7DQoNCiAgICAgICAgcmV0dXJuIDA7DQp9DQoNCk4uQi4gaXQncyBw
cm9iYWJseSBub3QgcG9zc2libGUgdG8gaGFuZGxlIHRoZSBjYXNlIHdoZXJlIHNvbWVib2R5IHRv
b2sgQUxMIHRoZSBDUFVzIGluIFNOQw0Kbm9kZSAxIG9mZmxpbmUgKG9yIFNOQyBub2RlcyAxLDIs
MyBmb3IgdGhlIFNOQyA0IGNhc2UpLg0KDQpJIHRoaW5rIGl0IHJlYXNvbmFibGUgdGhhdCB0aGUg
Y29kZSBoYW5kbGUgc29tZSBzaW1wbGUgInNtYWxsIG51bWJlciBvZiBDUFVzIG9mZmxpbmUiIGNh
c2VzLg0KQnV0IGRvbid0IHdvcnJ5IHRvbyBtdWNoIGFib3V0IGNhc2VzIHdoZXJlIHRoZSB1c2Vy
IGhhcyBkb25lIHNvbWV0aGluZyBleHRyZW1lLg0KDQotVG9ueQ0KDQoNCg==
