Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C027FB1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343651AbjK1GYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343625AbjK1GYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:24:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83FC183;
        Mon, 27 Nov 2023 22:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701152688; x=1732688688;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=b+N1PkfmiMHVyFKv/OMTtkLb+aTVxrwgLpzDZcDB7+g=;
  b=WqRnG+y5LUDKB2Du0oBNWH34G2haPVGFllq69gtsIim8OfNFvFX4eHke
   +uGc3YrPn0BR+VYzNZ4hmeYcMBkebjRtB1bZ5tVN1H4OL+UYzP0j/eTJd
   C69ZNqwh6TdZiXSIMAV9ANegoQbyHAUXCusryBv3SVcnol6DLHulXj8Ih
   Ulu3wfOv3HHYhgJQwxb6382YiQrPxnIrTIR4yPzCA8yVXXD+8DPmQn/4O
   GNj/08bu1tNmwevXPuSmg4gn8Nct1yyD8RiKawqTiFPAdW1gTrCeFKXaF
   kTrFK4UUIIlp7PbcQ6QNa+FUKrl9ejBCpxzMTG72fe332yODrPMNpo+/r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="6117268"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="6117268"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 22:24:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="834552099"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="834552099"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 22:24:47 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 22:24:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 22:24:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 22:24:46 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 22:24:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hc9tJjLYGTewJuqxx7n9hcdx4yj0OgirPxw4sP8/INJdXaim/zQG6mrNR872Gg/P/8i6x8Z6sKpeZ+1euEendc+Si0HDq4Ch3ZOuTvHJ1jmRjdXJFdvfwuRLXaADPTpdoerGoKbIy13OvvGIzDnr2tlBsFPZ/EY2O9fXE+MhOeP9rgKWYVQvK2/ujuG02Nmd9kaF8P4WeRSRZhj5XeQstbBSTJdgKt/26r7FkGLHkqO4AWoGQqQZhgjM/qDH2TnKql+TcYgehh0PSeJ+rEi6KzCZMqhJ9e9roIw7o1U30QgahmStBcBG9OVLnZ51fsCqyaDiS3on0iPtmQcj2nkonw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+N1PkfmiMHVyFKv/OMTtkLb+aTVxrwgLpzDZcDB7+g=;
 b=RRCEdJRD7imB+wCbpPUyjAs0YltvyJa1hV8u8ABFMPM3FXoXMHR0z9bvjBSGnj5D1Eqy9IR6WzaO4JCtPY8HvYLKOt3zkEcfTErsyCI+My9/ew2DoNC7zQrkD+NWSF6bNOvf//eZ2B2P8KzyXLOZBw1/pFkc4eny5hgEOZHi85KVF0dGFm0HAKYP4UfimHTiP6LDZh2UB6KU6b37crK9QrnMcFsLUZ5clcbgYuigbFyeprqjzorLHzPWABzlCN05BpmSjYWRjNDm3ddwLBeJjWC/qWj1dXJE8CUxnpQGTXUS7TcGxmjB9v9bwd7rcuw0FauyxW8xacflVtEimSve7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by CY5PR11MB6090.namprd11.prod.outlook.com (2603:10b6:930:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 06:24:44 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::b9ce:466:8397:a2c2]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::b9ce:466:8397:a2c2%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 06:24:43 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH v4 1/3] igb: Use FIELD_GET() to extract
 Link Width
Thread-Topic: [Intel-wired-lan] [PATCH v4 1/3] igb: Use FIELD_GET() to extract
 Link Width
Thread-Index: AQHaHHc0fDkXB8bAZkiLDJ9TS6/cQLCPTejg
Date:   Tue, 28 Nov 2023 06:24:42 +0000
Message-ID: <BL0PR11MB3122AB32A034C59FE87A6D1DBDBCA@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231121123428.20907-1-ilpo.jarvinen@linux.intel.com>
 <20231121123428.20907-2-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20231121123428.20907-2-ilpo.jarvinen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|CY5PR11MB6090:EE_
x-ms-office365-filtering-correlation-id: cc3b0bcb-580f-4601-1dc1-08dbefdab56b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NDV6rCyTL2ylQKA3RSLfy3QwKccUd0xEvrGM4DcxyuzWjY7V/T0L8E5cH2WHpRubRi3C2IZnk1Ah2IohqNPa3Lv+oP41jkPwc8GtgCLaflxj5tA8cUHulnzM0mvoTBeas+BdrmZGFXMV0dFVpyd9hg0ux00dsKWCv1IZGOWbT8kRFw4JN+cW+oQGDmIg8B5Z1vyn9xGUg/oII6BOLcnD/7Njh5TTWZ238Gj4k+sbpBfWMITd2GknSkzHJDcpXcjafOoO8VNiyGAe4oOb7bKttqx3pZ4Fq4eT1kZ+jgivEeW0s1Gvk7LIQ4fF0r2LZ6cXFOgs9yDny9FgO/lnRTprUiOubnOpqSI4KOhvRhNDRKQv8YDdisgqGleSgx1u29eqqF5mbShXJvv/JJ1ae+lHkgSAL7gqxETVJaXdzzDLhPCX2kDSvPWj4Q0kHpDlgc/0C8T2vlzZGtt4L8Xo1+Ld04AuF1GGLFdWGaEI2wHyJCSGX35T4LPFLP33LP4baaeOe/HNKMdbA2qSGxjuE3GabN8Jaf4XJA7Iv9YA0EboqjGQSGYWTnF9dajbCvQTnWQegJhz6a35BetpCxXJby/Am7eHYsOmiv9VsjP506OZ7D41k2joI8CMsEbQAnWhE7VU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(396003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(122000001)(82960400001)(478600001)(33656002)(41300700001)(7696005)(8936002)(8676002)(6506007)(110136005)(66946007)(86362001)(66556008)(64756008)(66446008)(316002)(26005)(76116006)(53546011)(66476007)(83380400001)(55236004)(71200400001)(9686003)(38070700009)(52536014)(921008)(55016003)(2906002)(4744005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWtJa2JvWm83SGFsdUpISkhkWWVmWTFOQzg4d1pXNHlsWm81K3R4ajBPeHkx?=
 =?utf-8?B?S2JteDdZcys5RjBWOU1qNXQzSUZ5c3Z3SCtRUm50Zmg4QStwazIvaEJLSnZZ?=
 =?utf-8?B?SHVXYmd1dEk1YlNhVUNLUTFQc1VOdUFIN2JaZC9KVkJGOEZzdlhXWEJlUmlL?=
 =?utf-8?B?UnZWbWl6RGhOV2s2OC8yeVUzYjlUZHRQU0dadG9sZEJIdFFLNzlwZUVhZVR2?=
 =?utf-8?B?cEd4WHFoZlg3Q0s1REhHekVwTnV6ZzQxdkJWNDFYbG9zWDd6dWJhTWtrK0xB?=
 =?utf-8?B?YklQR2JmUU44ckx1V2VnN0doYUp4UC96TWZ6MFdaaGpRbFAzQ3BTMnp4QXB4?=
 =?utf-8?B?RUsyMkVjYUJ0cEFHSC82c1ZsTGYzeVp2WWxzTUlNcjRERXBPeXRUak8rVTZT?=
 =?utf-8?B?eTh3S0wvSlVqWGFPQWc0cVJJam5SUzBIN3J6TzlnTTFwWFJ1Y2tIZWhMbDRG?=
 =?utf-8?B?K3lxRWE2SHZGMWVGMTFDNksyVlNxTEdETUtGVWxXdysrK290ZnhWWktKZ1lp?=
 =?utf-8?B?a3hRdy9BS29DMGVOQWJGcGFNTDJibmRvUHlaWlVIQ29NMVBFNjYvenhXSyt2?=
 =?utf-8?B?UWVoRXFqYUNPdGZuOHdMUGZUSU1tR21vUWlTT0hIU0dWUW9nNnZyUzJ2aFRo?=
 =?utf-8?B?Ym9nWE9qQVQrNGMrcE41N29PUitzT0VURFU0Sy8yUURsWTJpRXpYcEZwNjE1?=
 =?utf-8?B?OEpUZDhNS1ExV3ZHb1oxR2xuWkhVSUUyZXFVYS9BYmdjdmU0Wkx6NTBic2My?=
 =?utf-8?B?OEJNWHg4MXBVSS8wbUVHQkp4MHRrK0tQNnovcUtYYkRHRkpvRDRQQmtOOVEv?=
 =?utf-8?B?RnhVRS91UEhMR1c5dHJaQldPejJNWkdNUkZnQWtueWJudlMwZ0JCcnluSVRp?=
 =?utf-8?B?aXhWZUJXb1JtQ0xDU1BlV3JzcXFvYXBnQ0c4Yjc0MG5jWUFVNG9zMmErTWdw?=
 =?utf-8?B?ZjBsZmN3blZRcEZzU0hqTFgwbFluaEVwMkpNVG1oOUwrazFqSHc0eXU3RmJH?=
 =?utf-8?B?Ui96cktYOUZOQ0l0WTZrdXR0YU9QVSs5QXZ3dkJobFlERzl6dlFNNDhLNVpz?=
 =?utf-8?B?M1UrdWVXSGVRY011eHQyVCtkK1loLzdoL2g4SEI2QlZIVW4rV2lRMlJHdWda?=
 =?utf-8?B?ZE85Zi9YUzlLaEkvV0IwVmJXZE9xS0hFQmZLQW1YRTRqVUdiKzJrVVJuK0V0?=
 =?utf-8?B?bVRpaS9ocHhMVzM4QW9XS1p4NmNOWGZmWGRvTTNydFFodVZEdThlRVhpVDVX?=
 =?utf-8?B?RzZnWncwZ3BkcGpVb3VFcGlUMmNJazZhRTIxY28rUzFreCtkcWFoV3kvU214?=
 =?utf-8?B?SkxwR0o3V1RxRkVmTFpnZFVrT0xvQWZQNThrOC85UW8zS1hkdnFmYVJTdHA4?=
 =?utf-8?B?QTV1QWZVcTlJOEdWYWRmS2VUWU1vYkhBdmdyWFpDbE1JeG1pNnB2czdnejNm?=
 =?utf-8?B?b3UyQjMvZHdKaWxYVnJjSVgwWG03SkRMNnZaL0RjUHlRQXZBVCsxNDIzL2hj?=
 =?utf-8?B?RWxXY0pHZUQrQnVLNHU1MU9Jc1k0cUhBZjRpYjQ5d01LL0pOVzc5a3RaWXVN?=
 =?utf-8?B?ZGtGRVRQeWFsUlo4c2VHcW9vUmZIYlR6MDhVc3QvcUc3V255elRhMzNDSGVS?=
 =?utf-8?B?OGJCa3Vqc2sxZ21ORENqN2xPOURzdDNvSGxDeDJ1THVWbEZpNkw4VWdkWCtu?=
 =?utf-8?B?Smd2c2hUU2ZLUzZJaTc5bUFvbWdCNjJ0TUVpZmpvMUUvOGIyMGliK0h5R2Ju?=
 =?utf-8?B?V0VzVWFWMDlRMVoySmhlZGRJRXZFWFJ1cUNSc0dvNUthbGUvakgwV0lCcm9p?=
 =?utf-8?B?VzRTdlMwVEt0dlh3RUMxaDRCQkRxZ1lNaENaZkJIZ0wxMjl6M0FWWnBZQXJx?=
 =?utf-8?B?djlxdy9Oc1ZPams2OGNNRjA3alA1d1FEYkZLRDhVVHFxQ2RYWkR2cmtsdlc3?=
 =?utf-8?B?UXZpbytPSUVaMHVEVjZrSVIwTUZXVUtNMC9YUlprM0cvVGxmaVhhS01pL0hX?=
 =?utf-8?B?RHJVcUFxUDB6MTZnOU5rUElJb0V4RFZkU09SOU1kSkxnWURWeFA4MEtiTkE0?=
 =?utf-8?B?Y0ZOUWJkbCtmd3Jocy9ZK2ZUZGJicXVaWDRJUXZoOGJYZWRvZVU1UlYwSlgx?=
 =?utf-8?B?aTkzU2dSeFhYN3B2UzJiYm9pYXNhV2dPcnFoNjduR2JmZERxcis1S1c3REZw?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3b0bcb-580f-4601-1dc1-08dbefdab56b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 06:24:42.8310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nx9yQQCbW8WuJPM/df8cUoKcjvF9Lb5bJ3HVYK/DRF9vj5BdRSCJTz//a4VlSebzUbvU3e8FtnIBk9otypMmIb1jHhUi5io47/8OVMS9mJcEsnCD81EiE4SA2qMNIHhS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6090
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBJbHBvIErDpHJ2
aW5lbg0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAyMSwgMjAyMyA2OjA0IFBNDQo+IFRvOiBE
YXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+OyBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgSmFrdWIg
S2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IEJyYW5kZWJ1cmcsIEplc3NlIDxqZXNzZS5icmFu
ZGVidXJnQGludGVsLmNvbT47IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVh
d2VpLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVk
aGF0LmNvbT47IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IElscG8gSsOkcnZpbmVuIDxpbHBv
LmphcnZpbmVuQGxpbnV4LmludGVsLmNvbT4NCj4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0g
W1BBVENIIHY0IDEvM10gaWdiOiBVc2UgRklFTERfR0VUKCkgdG8gZXh0cmFjdCBMaW5rIFdpZHRo
DQo+DQo+IFVzZSBGSUVMRF9HRVQoKSB0byBleHRyYWN0IFBDSWUgTmVnb3RpYXRlZCBMaW5rIFdp
ZHRoIGZpZWxkIGluc3RlYWQgb2YNCj4gY3VzdG9tIG1hc2tpbmcgYW5kIHNoaWZ0aW5nLg0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRl
bC5jb20+DQo+IFJldmlld2VkLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9u
QGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2Ux
MDAwX21hYy5jIHwgNiArKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQo+DQoNClRlc3RlZC1ieTogUHVjaGEgSGltYXNla2hhciBSZWRkeSA8
aGltYXNla2hhcngucmVkZHkucHVjaGFAaW50ZWwuY29tPiAoQSBDb250aW5nZW50IHdvcmtlciBh
dCBJbnRlbCkNCg0K
