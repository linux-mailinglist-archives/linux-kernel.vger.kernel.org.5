Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5C1788E41
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjHYSKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjHYSKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:10:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C151BF1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692987018; x=1724523018;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kxmawZOmD5IQan1BCIQUtpZlWTOXPhAMdca2S80xs5Y=;
  b=IAHpvVUQfE1bIBToTRCNpFU1zLUV3GsGVn+X31I7I9coV3bzpvZM6LR7
   u3z00UuC6eQV9c+tSeEUTYXepjPX44+eAaiMOEH9bKzBTEbl82PQRerjz
   CwQv1TNoACTcpFE2VRmz+vCs3A166Kyd3vbGniBo1giYtGytqGXhduALw
   hsDrcqMifX0ZKzzq78KTpIaHiUh6txAkf5W5balsGnFcCnc2Gtj2H3muc
   7S1Lx7z7JM/+x4lGFgYQd/smlNIXCZIu8BKeDzufBA45dh3BIZu/Yw+m/
   aoVbA426ex6Or6fikfCaUOOGksuhO7i0m1QTDpjWPCxLLWCv1dnVprKSs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="405771026"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="405771026"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 11:09:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="984184956"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="984184956"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 25 Aug 2023 11:09:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 11:09:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 11:09:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 11:09:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 11:09:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JasY67ryKGAzfMa6Z3V1PbWiVORoumyYpPiWMhA9/IhGnDhHBkidCdr+I31CPxhg+A4GppDZlXBE7KGCKap6a5pnYZ3BU8dV4xlQ5OFPUov9oLXEoCOajzdH44FJRv8o8DluDe8AtjCEQxjfgz5JgrbxAyZqcXltZe+dYBgNy6ZsY6gjOL26gyD26IlRsNsmm+xpo5PtubR2KmcPoex2uxfRDtnFPHYr3kKMZr4a3Mlj50b9iH7IR41geRnRFw+TqeNaI7u7ipUhDcWTObU7ZSxIJoX4EOv0p/3XrG9DSvjcdME8LHxfIeOaWGDSAkN6q4DmMxYWrAH71gK3HEDz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxmawZOmD5IQan1BCIQUtpZlWTOXPhAMdca2S80xs5Y=;
 b=G2/5nUMdwQbPFD5Jc7BGNVhoTI9bMRhRGHf4Qi6guX3H9qMHpG/+upgRBB01B+Lanv6aklBDB9lS7wGMmR2qXwP57OoaKMuQqdMNg7YFU2UImWXR8EFNDXhyQn7xlIzs99ZU8dC2Znq3mKd9IUtpf48w9MO4Bm/i5AZxi5w2ScQlCqtJZoXictbObVS0YpwKxD16SmanCj6KyI8SSqSx5Zhzp7+TK2GMgiB2/Wx5PRI0aYEZUNxsu/JGt5M37/rL1kDkUOc6oZfPttqwtpknt6K/MWVjiTCSgwPEJANNCWyzUmvqZRxrew6vazZYxzLn5umay/tjF5fnrSqMtSDtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA0PR11MB7693.namprd11.prod.outlook.com (2603:10b6:208:401::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Fri, 25 Aug
 2023 18:09:45 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::b163:747e:e3c2:7087]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::b163:747e:e3c2:7087%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 18:09:44 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        Drew Fustini <dfustini@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: resctrl2 - status
Thread-Topic: resctrl2 - status
Thread-Index: AdnWr6S/HyyETPT3Q2GfFYcuexQ3cgAzIiMAAACLZdA=
Date:   Fri, 25 Aug 2023 18:09:44 +0000
Message-ID: <SJ1PR11MB6083BC6B330FA7B7DFD3E76AFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <DS7PR11MB6077FE180B11A9138D8E7ED7FC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
 <35f05064-a412-ad29-5352-277fb147bbc4@intel.com>
In-Reply-To: <35f05064-a412-ad29-5352-277fb147bbc4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA0PR11MB7693:EE_
x-ms-office365-filtering-correlation-id: 488ac329-110c-4ba8-1f6a-08dba5967606
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: St4Z/riD50ArO/oe080ZtgDeNhvsKMcdfbMD7JBVDEHFzKneJawlLgLnq6g/kLjM3OdfOqMKRxFoSO8fB51wBrkE5V+qBt4ADfuWerHHWcS/dXabBoIs3PfXCxSaHlSrtQu02bMfoK/5aR65YjVkCnpCHpHN9amPXTou00LGpHukm+s/5w50CuGgHpBced2hP20iD4eNT6Mm36/J7Gom3Bt+6ZER4aBpyKmjg8HJ++4phlvr3nIRs5Ub0b/vJwK6k6JZta8g1m+kqrzsyh0dCpfyY0X79fDl5ABEqHRBOIH0vWIDxajLFCi/07VOxufjGdEh1SsSFvWQY6aLiEBRRIeak0s7mgkK4b4RHZvWMIKhUuhZZxAyOmgcuSrIIg6B7XHitYg8YBV6TADrh+0I2WkBGkQVejlosQqL54CTHUAzvLav29eNB8RnSVTk6CGUFxXnzyecBZ7opHmVCJreKbjpFZ/KuH3gZ4YzAMEEOLH44qgPzRDbrkKOdDazcfPxSUE9FC/NKNibLTpMPsRyCtqaWNOWZLChlvwuTgrNTTwfAsnkyG1kIRzsrjMfpaqKX6gSLhO9gKDrL/DSSs0kiVFkttehJpRgb6QWIBC2pC8HisrQOgzOq71X+MdLwBqK8EbL6gyhWHOHH1epbDw+1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199024)(1800799009)(186009)(9686003)(6506007)(71200400001)(7696005)(4326008)(33656002)(66556008)(86362001)(38100700002)(38070700005)(921005)(82960400001)(122000001)(55016003)(83380400001)(2906002)(66446008)(4744005)(26005)(110136005)(478600001)(5660300002)(66946007)(52536014)(66476007)(8676002)(8936002)(41300700001)(316002)(76116006)(54906003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEJwbWpuMXlVWWpkNWxpcFo3RTYyUmN3NEp2Wm9NTEp6OUwzU3l3UDR4Nmsv?=
 =?utf-8?B?Wlo3MnpndzNMZURDOFlpUkM4blc5c2txcXlsbXNhMjFWTDMvTkhXMk1wT1pw?=
 =?utf-8?B?eEZMYkF2bnlqdGcrYVVtQU0xZjFjVitUNWI4RXlmRVlaUDBIT1hKcmNjQnBv?=
 =?utf-8?B?RGFGY1dDalpMMzZXOXRnL0JlSzBIVDVCTllwTEFnRXkyblQ5a2ZCVDZoM0ZP?=
 =?utf-8?B?dHNBMXljZG4vd254bVZ6a1U2Sjd4djFxb2NiODM4a0tGMHNvYmxpOGUrLzBO?=
 =?utf-8?B?TGE1RHlFdEJVWlNyZHFHUitCQjBtaXF3Q2JkdHFiVWlFZ1JqSzdvK3BMRE5R?=
 =?utf-8?B?NEQ0WVJFbGNxZGxiMWUzSkVYMEVQTDNtMm41YnNhamJodEhSeW1mWXQrNTd5?=
 =?utf-8?B?NldmN0kzVjZORnkxaVB0U0s2ZlJHYTRrQjU0S3lIMGVXNFNIMzJHVW1LMFZG?=
 =?utf-8?B?WnhBUFhJYmtHT25TcGhNNkl4NnYvcUV1N05xRHJJNS9LTWtmZUY5cUJpVXZv?=
 =?utf-8?B?ejRRb0pnNGlHbnBNb0FhdHlvbmx3L1lCelEzL3ZDdWt0U25yZERQa2ZQK0N4?=
 =?utf-8?B?OXdoWWMyclhRYlhPeGtvVDBiTFg5VzV5NDcyaVB2SWxLUERaTDFVTEJUMklZ?=
 =?utf-8?B?TGpjUlFuM0xnaDNLb2dtdVlQRHpGdW1KTnNFMUxpR1ZmWGp2dXFIaUs1SVJn?=
 =?utf-8?B?b1RlUHZnSjVreXJEam1TY2l6QjF1d1F3QmhQdFBHL01rN0h4dCtFQ2R1Tk1M?=
 =?utf-8?B?ZnBaRXRmczMxaWc0aHd3b2t3cXNBVG42Z3BPYW1FUmZ6V1Nobno2TGZSd1ZB?=
 =?utf-8?B?NjhTS1ZodnUvWjAxVE9XL1BXR0RyUHdLRXJXaDJXUjV3aXpEcFJTKytHT25z?=
 =?utf-8?B?TTNYMllvY1BtNmhGQVYrNkYwTy84UlM5TEFMRVRENm81TlMvYjkxWlBwSDdo?=
 =?utf-8?B?NVhxVzhETk1nQ0pGa0dWeFRTUGlCZmJud2E1ZFJFMmVObDhJZHE0U1lwdVFh?=
 =?utf-8?B?RVJGbERydzRlNkJKTTVuUzdkcHR3VWF2ZUJrU0w5MXNKRnk4TnNCdFYwY21H?=
 =?utf-8?B?UVhMVFpvZWpmcStTWXdpY0w3ZTV5V3l2Q05TR05lV011SUQycHdZSDFWZjF2?=
 =?utf-8?B?WWhYK1JtbzVjVFVqNjN3bzFjSktZZGpqUkFLbk1SNFNKckJMSWJzcXI1SWoz?=
 =?utf-8?B?RG8vQXB1d3dpVFkxVEt6V01HRmlOa0VGdHR2b0Evd056RUUxcHNEY3RjNXc0?=
 =?utf-8?B?Z0dkREhWZndqYVdwODY0alQyQ1BGZDhqT3NnTGdTaFVFcno1SW1BbzRxY3Vi?=
 =?utf-8?B?dmVFUzRlQkNUaHh0MHNUVUNqcmxwMXdiZEd2cWR5WWhUNE5MWm8wajdxNGlQ?=
 =?utf-8?B?ZDZqTS9rRTNwS3MvazRZQ0RjUUt3Z1BoOGZLWjZFNnBYZm96NVEwd0dzQzVQ?=
 =?utf-8?B?UXRpamR0YmpVQ0xrMTFuWSsrQU0vUlZEU0hoRDBlSHFEeVZDTTdGMVdYaHha?=
 =?utf-8?B?blFPS0JkL2VZZFJKZUFQck9PK3d1SlNnQldqVU9NY3lxM1NtQ1BZN1ovVmhJ?=
 =?utf-8?B?ZzBWVHRrcitQRWk4dGdaekJkV24yRW9ldHhadnp3clBYOXROQjVBc2hjOGJI?=
 =?utf-8?B?ODhoSGhyYzhNYmdsSkowZ1VtMGUweU54azFTN2tDa2l2U3ladlBZOTZqTWtq?=
 =?utf-8?B?SFZOUGRGdTlGZjFsL1gvR0YxZGxRMmdOSmhPbTdCYUladU92ckZmdzZOdVB1?=
 =?utf-8?B?Q0ZPa0llRHBzcjg3REhzbjNLSGlFaDV4eDdTM1Bkd2VPWTRjQ21uaDRDeFYz?=
 =?utf-8?B?aXRjTVF5d2dQdzhGbDRTNkprSzczVUpIREdac2NGTjJCL3JyRFdzb3R0cGx6?=
 =?utf-8?B?UStQMEt0N1JVejhIaFFReUZ6dHl5ZGtpMEhFaUFjcUViWkVmTWRTYVQwbjg2?=
 =?utf-8?B?ckF4UUNwTi9PY2txM1haOHR1TGJ6OUNrSGNpSFRHWWJndklJRlVCbFZDekgv?=
 =?utf-8?B?NysxMzdqYkpyZjRwZWJWV094K3pHUHNGUWFLUVZjMjZDeGFJb1lEb1ZnTEtr?=
 =?utf-8?B?ZUZpQXJrK1lWMmhJR3FyZkQ3ak5kczQreXUyWXR1ajVJajBKc1FLeCttaGRx?=
 =?utf-8?Q?BjsE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488ac329-110c-4ba8-1f6a-08dba5967606
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 18:09:44.6602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0EamhPlI/yesN/qvJy8CK4FZ7kKiLmOzbk+921AZyRemI3q33xiJTf2ttAmTBldDEmDpD+XKmzjNCRR4lThqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7693
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

PiBBbHRlcm5hdGl2ZWx5LCBjYW4gdXNlciBzcGFjZSBqdXN0IHRha2UgYSAibG9hZCBhbGwgcmVz
Y3RybCBtb2R1bGVzDQo+IGFuZCBzZWUgd2hhdCBzdGlja3MiIChldmVuIG1vZHVsZXMgb2YgZGlm
ZmVyZW50IGFyY2hpdGVjdHVyZXMgc2luY2UNCj4gYSB1c2VyIHNwYWNlIG1heSB3YW50IHRvIGJl
IGdlbmVyaWMpIGFwcHJvYWNoPyANCg0KVGhpcyBtb3N0bHkgd29ya3MuIEV4Y2VwdCBmb3IgdGhl
IGNhc2VzIHdoZXJlIGRpZmZlcmVudCBtb2R1bGVzIGFjY2Vzcw0KdGhlIHNhbWUgdW5kZXJseWlu
ZyBoYXJkd2FyZSwgc28gY2FuJ3QgYmUgbG9hZGVkIHRvZ2V0aGVyLg0KDQpFeGFtcGxlczoNCg0K
cmR0X2wzX2NhdCB2cy4gcmR0X2wzX2NkcCAtIHVzZXIgbmVlZHMgdG8gZGVjaWRlIHdoZXRoZXIg
dGhleSB3YW50IENEUCBvciBub3QuDQpCdXQgdGhpcyBpcyBhbHJlYWR5IHRydWUgLi4uIHRoZXkg
aGF2ZSB0byBkZWNpZGUgd2hldGhlciB0byBwYXNzIHRoZSAiLW8gY2RwIiBvcHRpb24NCnRvIG1v
dW50Lg0KDQpyZHRfbDNfbWJhIHZzLiByZHRfbDNfbWJhX01CcHMgLSBkb2VzIHRoZSB1c2VyIHdh
bnQgdG8gY29udHJvbCBtZW1vcnkgYmFuZHdpZHRoDQp3aXRoIHBlcmNlbnRhZ2VzLCBvciB3aXRo
IE1CL3NlYyB2YWx1ZXMuIEFnYWluIHRoZSB1c2VyIGFscmVhZHkgaGFzIHRvIG1ha2UgdGhpcw0K
ZGVjaXNpb24gd2hlbiBjaG9vc2luZyBtb3VudCBvcHRpb25zLg0KDQoNCk1heWJlIHRoZSAiV2hh
dCByZXNjdHJsIG9wdGlvbnMgZG9lcyB0aGlzIG1hY2hpbmUgc3VwcG9ydD8iIHF1ZXN0aW9uIHdv
dWxkIGJlDQpiZXN0IGFuc3dlcmVkIHdpdGggYSBzbWFsbCB1dGlsaXR5Pw0KDQotVG9ueQ0K
