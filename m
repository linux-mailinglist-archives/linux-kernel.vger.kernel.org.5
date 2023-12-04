Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900F0803C03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjLDRvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjLDRvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:51:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74D2FA;
        Mon,  4 Dec 2023 09:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701712278; x=1733248278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RTmNTIEt+JU4xAY6wdjmaFwY6DHDBxrebStPgtsUF/Q=;
  b=g4AjAS/66s+eNL0k8oP+93DBsravLu8rkDqn9N1FfFc33o1a0q7NJb0T
   kV8UU267w6ID87hdpoIXvhq2GeUIiLpySs7/+e8Gw7ff3+r+9Xx409ndu
   M+IUZaRorYEAt7uYRKN/6fnTyuIHIfPKU55s97Wm0M7D9vRXG0g+/Vg7Q
   1nRBnDHkCCiPDLtZcM1TOeNhBbMshSw34NxvuwnBu1TkBiMvIoOg1/7PV
   gjAhWq8j88IvnYHpTjHSjUXNZYj1i2KUVCjBMxZzxVgBeKxDT3BIWqtrt
   Zvm4d9KprDvIj1D8WR/uhmhUKpO8vvLpg3BtcOr4d8f5iFMIhGExgi4aa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="373953104"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="373953104"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 09:51:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="770601473"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="770601473"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 09:51:17 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 09:51:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Dec 2023 09:51:17 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 09:51:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZPMUd76gAv2E8G6SqTH+i19sF6EDy6kP+9FpA3H/T5Cw5Ui32VO0eOywqV0CINO0eTTzdcYR+Elmd+EZEGJLOCEh93IvWsmLBHvbdicedvmVhc2obDD9z+wfOIxzst0UXOSKkjIGbVSAg5ODAzTdnWLOOy/Xkk32yswgrCZx9jv7VFn8jGdaQd/zB8baOhhspPDnpdfR/m+6N1n04rg1RSjZppzlFR/n/SBaM1+zQJKrA1oH9ngXiG68t+e8i9vktNtgD9I2OPEW1tNCDgznCodV99iqSJlD/ln7dMNXcgHkMDzoPYRNnQ3mSmcqsm56kFVan+lQSD9OoGdFGFysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTmNTIEt+JU4xAY6wdjmaFwY6DHDBxrebStPgtsUF/Q=;
 b=KbYtL1/KfajEVLm7r+ixQUahB5WfqwIxLVwviQwj3w4N7HX3DKhnBzeziV/XyoyTIUfcFzdKzM6N7NJtBHFWTgCSDOvvGGINKBCzF/cH38I8J1cWe+Re+Fi8iEJ+J17oUevYQD8i9gH3WRxK3OwpHhnt5QxM1PoFHjOiSrP+wZV0A19weIQdwpgNgmmRkTog65SzbIpNV6zyW0Q8S5aQ1AJkP8o2zZniUUlW2Xc5I02U/g8UGZ2o+/7AFQuyY5YB0rZSfbLdakU1tIwTPzQDTyRV2xzlrdptZjtMhxg3ofvhiy4+2dU0N07xlzVd9iaTnWsmly3qll4izxLkbIu0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB8428.namprd11.prod.outlook.com (2603:10b6:806:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 17:51:15 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%6]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 17:51:15 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "babu.moger@amd.com" <babu.moger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: RE: [PATCH v12 8/8] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
Thread-Topic: [PATCH v12 8/8] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
Thread-Index: AQHaIyT+YENZrzcDNkKP4jmyUzMNjbCZXvWAgAAPOFA=
Date:   Mon, 4 Dec 2023 17:51:14 +0000
Message-ID: <SJ1PR11MB6083856054D76B155F005465FC86A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231109230915.73600-1-tony.luck@intel.com>
 <20231130003418.89964-1-tony.luck@intel.com>
 <20231130003418.89964-9-tony.luck@intel.com>
 <6e91d85c-8cf4-4df9-838a-e5265daed726@amd.com>
In-Reply-To: <6e91d85c-8cf4-4df9-838a-e5265daed726@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB8428:EE_
x-ms-office365-filtering-correlation-id: da2a39b2-5ff7-464c-c4ca-08dbf4f19c50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L1u6D3bJY1eIuZdsKHA9fLHEHj0ME1HYrM2HBw+PPM9aquZHxUvUb3PHdRnQFWFwfxhzXeppe0o9PZp6tWF7LwuHQoBazXGHJhhDFVUEQGpAIpAzHJoMoJsZ/PtmTxWMS/BR0P5ME/vJ1D8bzG3T6OdngVRhA0yAq/zgUXz4docFtaGJPHC1y4HEZxOLmONGkVYwRFp6aJpxT44DO0Ac4aLAUIRfUdpYMPulamQAs9Da33AhEDoTYGWrRCEr+/l3X1GTEwXQjEV/6tGP4wDzjyOEMAjh7IdNGLEe5PYukk26OJiFDE5q3miQ3PSuMWAk1aly/9A9k+wSPohQVmTzkTfTfbc4R0w2LRaG9dJKG3SgURR1Cd04MqzKRKHRrF68At/mqDVrsZC+0AWEYxYtwvtWpjAKFcdOEEx6DXQnXUN1uZdVg0ON20Nm5rhJvG3QY6nli5cW9gjla89deAaey0d6Ml32j2lUYUZRPDsSuUEeo+V6MWkKwkBu06itB9AoqVJ210ddRobnqRyZMvrotiuw526Di9Xro9dKxfsxJFVYSh7IFJhRQ5AT6yorJy4jyzZMzI6gfQeMrTapPsg1QDrpglxXhR+oAT0FXb06IKtacjPeFnR6teN6jUA4FzlW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66476007)(76116006)(66556008)(66446008)(66946007)(316002)(110136005)(54906003)(64756008)(38100700002)(7416002)(2906002)(5660300002)(558084003)(86362001)(33656002)(41300700001)(38070700009)(122000001)(4326008)(8936002)(8676002)(82960400001)(52536014)(9686003)(7696005)(6506007)(26005)(55016003)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3ZTT2pXaVI3RDArWVBicHlrbDNGU3dnTWozUDBISjQ2Y3p6dzNpcGYyWFFj?=
 =?utf-8?B?aktYaVBURmljY0RYV05KY2xkTXJVSlUwWXVzdTJvMW1OLzZ6SERJTXlFZmFa?=
 =?utf-8?B?OVZVeXFkOXh6RlMwOE5EUWQ4TC9iZGJIYzhIZE9RcW5kWUlJcUhNL2tVb0xr?=
 =?utf-8?B?OXRMem5ZZHBjWjJHbkE1ZWo2N0lsbEdDT05FUitXZHNKL0JGRHZ1NUFiUEl6?=
 =?utf-8?B?S3BLZWY5VHRKZVl0c0RDZHZjcHAyK0F4ajkwZzl5UkZ1bWJmYzd0eXBRWE5W?=
 =?utf-8?B?alZDV1pEMjhLQXNvZDRJRHBPc000SWlkSWZLVGIvTndrWFhvbmZ6QVdWNTV3?=
 =?utf-8?B?dms5dU5mVzJLd2QxeWR1cUZ1bFJqTWc0RkQzaUgzWU04SUd6RXU2YTV3d2VH?=
 =?utf-8?B?bmtvQWU2SUxWSTNxeDVwUkd2YkVNbGRVRVplY1hhVm1mY3V3TmFCK1lUVUNZ?=
 =?utf-8?B?d3I0cHdkSWJhUGNoL24vWTRLRXNDSnpCZ0ZJSlAyK3lYTUxVS1JnaGRyVm82?=
 =?utf-8?B?ZGVaOWsrZVBkUHl5NUZVZTBaME4wZ1k4QlU1M2dpL0Y1T0E0MHZYZkVRYlow?=
 =?utf-8?B?MGJwVmZaNUFyUSttSWxkNm5ZSzFQWk9xcDVabXFhWEtkVzF2RDBzR3Roc0Nt?=
 =?utf-8?B?WUVMcTA0Wk5CYkRNUUdJb25CcU5KU1FnUXdGdFZBb3gxUThOOWJjQ0lrcnRJ?=
 =?utf-8?B?N1QyWUdGeWd3RTVTUzRlS0xsdWg3OXF6d1VXbnRXYjV3SThhREhqNGNXOUIy?=
 =?utf-8?B?bXpQMXVZT21nN1RBUGlYU3grKy9LS3ZOVFo2eVpkNVNHWmVyRjY0OExickl6?=
 =?utf-8?B?dWpWRWl1RG14NlhJZC9PZ0xBTkY4b1Y4bHJDczQ2aHZMMjBFNWF3QmZ2T2Jm?=
 =?utf-8?B?OUtWK1hKRFFNY1ArZ1hFRGpyc0d1NDQ1SzdGUG9ZVU82T0U0NDF3eFcrRCti?=
 =?utf-8?B?aDNENlVkaDJFMksxVkNFRUFOazZDSVdMSjZqQnd6Qm9pMkllMjd4TGpzbXpj?=
 =?utf-8?B?QUdRZEZsbCtiZGlJaU9iRnJGUjlJSXd2ck1raFJoT3paZjZZVGt3bVp0d0tP?=
 =?utf-8?B?Y2NJK1NJYkljSTdxZ3hKd25nSWhVUllySXdhVHpzd0tCcTJTaTRucTV1c0Y2?=
 =?utf-8?B?R1BCekFzdDFOMFdXbEtSeUFKWXZPK2NBa2ZOSEtSSHNyL2M1enVZOXdReGgw?=
 =?utf-8?B?a2d6THQyTmkxV0N1WTdraVFjc2FDdEpKejNQdm9vdzd2bkNVUGpyNkNnR3NO?=
 =?utf-8?B?V3NrLzNmNHRJWVRzUmRSMEkyalMwMUhySGdZWHFETW92a0NWRnhHb3NDbzFO?=
 =?utf-8?B?a0JzZWdKeHhISkhSNU9RNHlDRmlFR1djMUxrSlBqLzQ4TXljRjRrRnFudlRo?=
 =?utf-8?B?eFNKakJianYyRDJKS2ExVDJvVzFZdDVncTlwTGNvVForbVhzMjFkSGg1a1kr?=
 =?utf-8?B?WThJYzk4eU9MVmxDL0JHQXlyeVlLcllRRC8zY2xpbGRpb28vZ295enFRUGNJ?=
 =?utf-8?B?SXFYbWdHcTVPYWplN2xueTgvZi83bHc3TXFaNnNpMTBBSkxmd2hTL3c5V2VX?=
 =?utf-8?B?YnMxaXZXVGhtMHRSSU9VWVcyYjYrTUpFdnQya1dIaUhFdzVFMFRWbElhd3dW?=
 =?utf-8?B?WVVLajRtVmRUcU02Ly9WSEdXWnZEMlJXUit5ejFqZnVjeUZsYVpiSitXMzdq?=
 =?utf-8?B?dHpKWEJwSlVPNm9nRjd2cmUxZGpXdnI3Sis3TXNVM0l1ZmVEc3J2eTQ4ak5U?=
 =?utf-8?B?dnNGR2lITkx2WTlua2JzbWt4WXJoUk9PMnVsNkhmQXBXWFV6RW93SU9mU1hY?=
 =?utf-8?B?aUFWQVhjenNYSVVuN0R0S3cyb1Fid1I1ajBKVENuTGNYUHU0Kyt0US9KUnVP?=
 =?utf-8?B?K2lsQUV2Kzc5S0ZzRnA0YWNzSkxqNllVdTh3b3VSeWtNTjRKT21OWEtFNHNO?=
 =?utf-8?B?SW1sSDZ0cTRpd0JHUUxQbXZwaEM3b2dpcWlJeDI5UkxBVkxkSyt3OHg4TFF0?=
 =?utf-8?B?NmJDbHJuSmUxL042NHRuajdwdkttWHV5UitsUlhPRVlPc3NNNEZkUnVEdjJh?=
 =?utf-8?B?NytCWDN6REJFcUVkS09JOE12R3A1SEFSS1hrbzMvQjl6WUlCSll6VzVmNXgv?=
 =?utf-8?Q?1+2LOTkTb8UMk3f8q7+UYtd6n?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2a39b2-5ff7-464c-c4ca-08dbf4f19c50
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 17:51:14.9468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuQkrtAuOA+TU7rjV6Zyc61UmEiFy7x7JhNQSs8Y4BUKmVLv0KWv/tTCZC5s/Zl4neGkb/An7qLwZdnVAS4rhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8428
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

Pj4gK05vdGVzIG9uIFN1Yi1OVU1BIENsdXN0ZXIgbW9kZQ0KPj4gKz09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQ0KPj4gK1doZW4gU05DIG1vZGUgaXMgZW5hYmxlZCBMaW51eCBtYXkgbG9h
ZCBiYWxhbmNlIHRhc2tzIGJldHdlZW4gU3ViLU5VTUENCj4NCj4gZW5hYmxlZCwgTGludXgNCg0K
QmFidSwNCg0KVGhhbmtzLiBJJ3ZlIGFkZGVkIHRoYXQgIiwiIHJlYWR5IGZvciBuZXh0IHZlcnNp
b24uDQoNCi1Ub255DQoNCg==
