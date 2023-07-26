Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737FE763026
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjGZIot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjGZIo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:44:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA548A79
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690360462; x=1721896462;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aNpBrU15hb71BP1UnsIrUOdwQVX5V7i76dUxWNFKOY8=;
  b=DBUK/Rp+jiJ8gxNAaeO8IVguiSeeEFerVMznROCvRtf0UAonNir3Sx79
   4L0RNOLcntpFyIUPJljL2zFPzFRFXM+Z+RbW7n8mBjZhqpQFZLyZis2BM
   0NZ8scnneI4B3ldzMJ8br4UCq0UAayXMPN971wW2QaZqf0yD1FT+5gmIr
   aTkO7YEh2tSofkUMvzcMk9P9K5aO/ugGFLDzYxUIDijv0cqO33lWDjDfa
   qcBYYndhBCL3+qx25IErqctMkNA/m4pFLwhsV34xK2vr2ggp63g9cMUk7
   qjRlYF1N5esg4Qb9J9WlSFjjvGD0MQZ0WJYva4fEWNZPpNor4veLKeVZ+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="348233939"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="348233939"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 01:34:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="676589020"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="676589020"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 26 Jul 2023 01:34:06 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 01:34:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 01:34:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 01:34:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMXNM9wjCuGHxcajj/9wHQQgofaAgqYrYcKyFb4W1ndHnyrEdqlUgkVYxprryu2abhDXe++RduqolVIO8P0rtb3SB218JX/Gj0dqAOAV/byyqA6C8BDTLhRiZ5StXZzCnreKiwL5evxyvZw9DDUgy72fAam+usoAskw9yzb2hX5sGfnA5Ky61JKCklD/LsRaS21YskjW56EG7woxNZIQ/GKWZk393U+WoH8modSpDmgcpM7BgEw4roPtyqQc5MU/Z1tM8X9qVPf172PbhZKc4EAivQzDrcjef0PYgZit+kGs8dPdUDtLcjYeH+g/Pga+0lWb/ekcszlRMDSWsgfoNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNpBrU15hb71BP1UnsIrUOdwQVX5V7i76dUxWNFKOY8=;
 b=PGJRPr7qLnyhR8r4BSknxj0LoDQRUahMI5EMUEhuuYgez13HIYGNK7cpf+TBghWSRtUTEiJ1nZU5hvF6HFQhN6xi21Neb42QP/l2PsF5JxnnFFYqOnf0cZGq43O/2O2TfI3+DOvXSkb4XCnUdrTxpvA+TYIFuZ2KT8FusFIhwc64KUnhBNIWYvruG4WsxL2sNd7JQ6qtsC+UUtfHtiExTCOs3P5oYenxZYHf+o3WKH6OQ4I8TegbJOvZvu3exUu8E/Dpcab5uVYGOUbAo06eiEGDTankHokx4kLVx2rgwvN0ZuEvliTNx1kvAANhDEpChRecr87Owg/bu0zLgBouZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22)
 by PH7PR11MB6474.namprd11.prod.outlook.com (2603:10b6:510:1f2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 08:33:58 +0000
Received: from CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::12c9:6f97:4016:eabb]) by CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::12c9:6f97:4016:eabb%7]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 08:33:58 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        "Bhat, Uday M" <uday.m.bhat@intel.com>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        "R, Dharageswari" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v2 1/2] ASoC: Intel: maxim-common: get codec number from
 ACPI
Thread-Topic: [PATCH v2 1/2] ASoC: Intel: maxim-common: get codec number from
 ACPI
Thread-Index: AQHZv4iOElXQr78YhkykGlIThIMz5K/Ls3wAgAADvOA=
Date:   Wed, 26 Jul 2023 08:33:58 +0000
Message-ID: <CY5PR11MB625741E8CCBA25EAA82739579700A@CY5PR11MB6257.namprd11.prod.outlook.com>
References: <20230726140848.2267568-1-brent.lu@intel.com>
 <20230726140848.2267568-2-brent.lu@intel.com>
 <7349d6f4-4866-6fb3-57c9-9ce2d6989576@linux.intel.com>
In-Reply-To: <7349d6f4-4866-6fb3-57c9-9ce2d6989576@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6257:EE_|PH7PR11MB6474:EE_
x-ms-office365-filtering-correlation-id: 30532ed4-14a7-47a2-3e7e-08db8db30e73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IQNXgyTqRdkmO9UkgsBTlCGh/SqYVmU2yIpc3O0yAJOFYCAIdgmE/MtezZVM7yanO1pE7S06/yvnsm7zS625qGBHZ61aR0vz0JKtrOB6kcBjUYdu7DMg+vbW2858u697gCVMUHqFPVAIqihu9cLphX5Zm7bbrG0gHFiH/pRpkZdNd2iSFBDocZTdfHt9wT/ClO5WjhT3oOGeNgHQIH9lPa/LDUExtpDTuQSqr5zKXCAxjs/la0sx7gUz248KWrQRrhbidkD/DnHCYFlCwxUSa0Trkrpjcma4I7poyGqLbFEwA8pqgDXvfIofuTZItQOF0Xay1cuhpASmyY8kk6VTvs9KKi7t0XqT3+MCk+kMT0TFOdb/5YhFXhzDKhvkR03pjcn3nVJ64fJH3cxhib+FjwM/SGjr5I70z6FGDA2pEFrJkw/GU7C4HBORIr15hDPLVcnHtE0j3vmExKjZu+++7dV5IBDFJczuqZtWQXlsfQXiZkASnSoXuIPxpOy4OGlxc3jb8FhvFxmTs9ikxwFsjTjquVkqWMMnUhkr/cVajBuPlALyge/yXAiPVtVU5BNsbjhuPhf9FjswlqhTKvT5ebDhLQufeoIuBxuYFWv9qbGJ+Vxb/ZyhS+Ky9M6TPZj3uj7s2rGIw9VLYXiXgLENuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6257.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(122000001)(52536014)(86362001)(478600001)(110136005)(41300700001)(5660300002)(8676002)(8936002)(7416002)(33656002)(4326008)(316002)(66556008)(54906003)(7696005)(76116006)(9686003)(66476007)(64756008)(66946007)(66446008)(26005)(6506007)(186003)(82960400001)(38100700002)(71200400001)(38070700005)(55016003)(2906002)(11716005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWlOR0xEVWRkZGl3cVIwL2tzR2duS2RRdFprNDFOZDc3UEluN2dLemdCd2lu?=
 =?utf-8?B?L2NCSHNXcjRmYm8vN0E4TjBkQjAwSG0xZjg0MlhEWWpRalZGQit4Z1cvK0Vt?=
 =?utf-8?B?Q1NGdnRWT2ZhbW01MmF0cTExem5kYWJ0RHRBa0FnbGovUWprZGVlZk85bzJk?=
 =?utf-8?B?LzEzczVydG1LTXQ4d0FDa3c1cndEQWtPYWQ4MFlRVEFmbVFOY25BY3hQV24r?=
 =?utf-8?B?cXNLekdVcE9SZzdYVExDaG9FblFqRE1sZUZrVFhFaXJwekwvTkZXRHpqUmZ1?=
 =?utf-8?B?SDJHMXN5MVQ2em9HOUsyMUxnTUQxM21CeFVIWW1iMzgvcXpOTjBNMERPd1VB?=
 =?utf-8?B?Y2FERlFqejVOa3paMEorZi8xc3piWWRnYTN5RGZVVWdkclRjN08xRXgyY2hE?=
 =?utf-8?B?KzJGcHVOdU9NU0hyRnhIeDRrMnhOWXY4U09WUWNFcnU1amxsMGR1dEdSMm1O?=
 =?utf-8?B?YWhpUmxhUnlMZlBzaW5JeDNSdExyaXFIM3FIa1JLZ0hON2dOUWhzaGhJRncx?=
 =?utf-8?B?K2xVNjNSOGpLZWhrZXdFNVB2c25UeDZmWU1lM0R4bVRIRm1ldnVHSkF1Mkd0?=
 =?utf-8?B?S2RieURyeGkrVXZINlJ2enB6byt0ZFBTVG9xZmEvR1htSm8xUjJXQTFTT3RS?=
 =?utf-8?B?ZkFWSFlOdjMvSk15VFhtdzJ2OVdhZm1JR1dwOEhYS25Za2VxWFl6Zlp1MVBC?=
 =?utf-8?B?d29XV1hmaFhTT1dhZ1owWmN5MkRkZ0dxQXkvb280N3lSQVo2L2dpS2pzVnVi?=
 =?utf-8?B?aDdhWEhOVlRzZHVLUlFaeWVGKzk5bU9RU0pQc1lWdFFlL1R6TlBybmxDN0dE?=
 =?utf-8?B?dnlOVHRMd0hrdU9haHFzTFJpNWtLbitCNWpaZDBzQkNzUlBjTWIrMnZ5Q2JO?=
 =?utf-8?B?Sy9kZWJOTGtSRG5TUXRVcDg0NDRqRkpncVZLbUREVmNLdTlwQXRkZG9wdm5O?=
 =?utf-8?B?Vnp4b2xnNnZXckNFMy9XQllpMXNLZGh3eDZzdjNBOFd1aDFHT2tkRU5UeTM1?=
 =?utf-8?B?RStxbkw4VmRYNnJEZkpoV00rWFp0bDlDTmp3U2RkSjJlS2lNQzUvQW1IbjNj?=
 =?utf-8?B?Ykp0U0wwVm1DQTAzRHVmMncydU03c2NoZlBnbWVxRWpSdmxscFp1WWFCazhR?=
 =?utf-8?B?VmVtZW9wQXZCd0pBcFZQMU82VUo0MU5VbGUxa3RQM2NydGpWRE5qMlhaK00v?=
 =?utf-8?B?dEVIZXlqeGlHdG9JbXExZUxJT1FWaWFhL2JYUXRQOWZ1ZDBqRk9ER3RaZmRm?=
 =?utf-8?B?Nk5oK1FJVDVjaXRod2g0ZHJTaStRVTJoZWtkMVR5NVNVaSt6Szc5YmdTZXNs?=
 =?utf-8?B?NVdFSFRSdkpVLzBWVnRPd1hzQTVvK0tpbVpWVzByblQxVEkzNmFlVE85MDg2?=
 =?utf-8?B?VWplSkYvUzJJL3Q2d1JhN3FKa2JnNUVVM3dBQU1vUGkveWNITW11dFRZeEFE?=
 =?utf-8?B?aUZBMXhNb1oycUNpSEFDUmlXZ0c5Ny8vM09abDJyUjNrSFBMbElpYnFkd2tL?=
 =?utf-8?B?eFZLaWovQ2NsdjdWTzVlK0pLYi9FRmtKQXcwNFo1ajVLL2xrc0JmdHdzVFBC?=
 =?utf-8?B?UjBUbFJOYUR2SmcwR29aZVdtSzZSREVJbktNTWhjTmZrMXdLaXpHeUErTmJB?=
 =?utf-8?B?Umh1OWY5OFhoOHZ1emErcG95cVJTWHNrYVZFOGZTUS9zZm5kaXJJcS9ZVEh6?=
 =?utf-8?B?cy9ZWHdYd3ZlWFVTRkx1UEdCODZpS0VLWXBaMDl1MmllNEpvUTRaWFVOS2tJ?=
 =?utf-8?B?RG9wZlhoNDNWeXZjUjNqZUxEYW1uY0VLZVNSMGprdHBpK0FkSG1NaTJ3WGJB?=
 =?utf-8?B?bHVOVHZLb25hUGNlSjFDNE82VXRDbzhLRk9XbmU1cEtRUjljYXlSSTAvNnV3?=
 =?utf-8?B?ZlN4c3VVN0l1WHh6aUhxdEwvZGFVVUtnc0VhYlJjc3p6cVk0bDNyK2ZUeVo3?=
 =?utf-8?B?L1FvOHphbldlRUZKMDl3Mzd4NGR0QVBFOC9LTGx3a0VScWY3clFNV2NkaTFq?=
 =?utf-8?B?TnFPVG5WK1VtRzkzTTdkeEtCc2pPS0ZHNEpmWEJrcm81NW9tV25sQUFOaEZ6?=
 =?utf-8?B?bC81aTYvL0s0UUt5MjlCckduS21uZUwyaWVLZlhadG1BVjBhMnVkRXJCd2JH?=
 =?utf-8?Q?pano=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6257.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30532ed4-14a7-47a2-3e7e-08db8db30e73
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 08:33:58.3838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KuYbjf+PVABGMUN2gYiju9GsZpJe01FD3x9USoiWDTBXZyvOww8ukM8PF6k2wzia0VL5fSWQm6NiIMi/utfbUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6474
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gICBjb25zdCBzdHJ1Y3Qgc25kX3NvY19kYXBtX3JvdXRlIG1heF85ODM3M19kYXBtX3Jv
dXRlc1tdID0geyBAQA0KPiA+IC0xNjgsMTcgKzE4MSw2IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3Nv
Y19jb2RlY19jb25mIG1heF85ODM5MF9jb2RlY19jb25mW10NCj4gPSB7DQo+ID4gICAJCS5kbGMg
PSBDT01QX0NPREVDX0NPTkYoTUFYXzk4MzkwX0RFVjFfTkFNRSksDQo+ID4gICAJCS5uYW1lX3By
ZWZpeCA9ICJMZWZ0IiwNCj4gPiAgIAl9LA0KPiA+IC19Ow0KPiA+IC0NCj4gPiAtc3RhdGljIHN0
cnVjdCBzbmRfc29jX2NvZGVjX2NvbmYgbWF4Xzk4MzkwXzRzcGtfY29kZWNfY29uZltdID0gew0K
PiA+IC0Jew0KPiA+IC0JCS5kbGMgPSBDT01QX0NPREVDX0NPTkYoTUFYXzk4MzkwX0RFVjBfTkFN
RSksDQo+ID4gLQkJLm5hbWVfcHJlZml4ID0gIlJpZ2h0IiwNCj4gPiAtCX0sDQo+ID4gLQl7DQo+
ID4gLQkJLmRsYyA9IENPTVBfQ09ERUNfQ09ORihNQVhfOTgzOTBfREVWMV9OQU1FKSwNCj4gPiAt
CQkubmFtZV9wcmVmaXggPSAiTGVmdCIsDQo+ID4gLQl9LA0KPiANCj4gaWYgeW91IHJlbW92ZSB0
aGUgY29kZWMgY29uZiwgZG9lc24ndCB0aGlzIGltcGFjdCB0aGUgS2NvbnRyb2xzIG5hbWVzPw0K
PiBEb2VzIHRoaXMgYnJlYWsgZXhpc3RpbmcgVUNNIGZpbGVzPw0KPiANCj4gSXQncyByYXRoZXIg
aGFyZCB0byByZXZpZXcgd2l0aCBqdXN0IHRoZSBkaWZmLg0KPiANCg0KSSBqdXN0IG1lcmdlIHR3
byBhcnJheXMsIG1heF85ODM3M19kYXBtX3JvdXRlcyBhbmQgbWF4Xzk4MzkwXzRzcGtfY29kZWNf
Y29uZiwNCnNpbmNlIHRoZSBmaXJzdCB0d28gZW50cmllcyBhcmUgdGhlIHNhbWUuDQoNCkxhdGVy
IGluIG1heF85ODM5MF9zZXRfY29kZWNfY29uZigpIGZ1bmN0aW9uIHdlIHdpbGwgc2V0IHRoZSBu
dW1fY29uZmlncyB3aXRoDQpudW1iZXIgb2YgYW1wbGlmaWVycy4NCg0Kdm9pZCBtYXhfOTgzOTBf
c2V0X2NvZGVjX2NvbmYoc3RydWN0IHNuZF9zb2NfY2FyZCAqY2FyZCkNCnsNCgl1bnNpZ25lZCBp
bnQgbnVtX2NvZGVjcyA9IGdldF9udW1fY29kZWNzKE1BWF85ODM5MF9BQ1BJX0hJRCk7DQoNCglj
YXJkLT5jb2RlY19jb25mID0gbWF4Xzk4MzkwX2NvZGVjX2NvbmY7DQoNCglzd2l0Y2ggKG51bV9j
b2RlY3MpIHsNCgljYXNlIDI6DQoJY2FzZSA0Og0KCQljYXJkLT5udW1fY29uZmlncyA9IG51bV9j
b2RlY3M7DQoNClJlZ2FyZHMsDQpCcmVudA0KDQo=
