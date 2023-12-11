Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA5780C03E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 05:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjLKEG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 23:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLKEGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 23:06:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71B3F1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 20:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702267589; x=1733803589;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sl/oh4GDynFCiDM5GD/zn5wPVyrvWiocOosWuiC7EuM=;
  b=OTLMFthjwWyAUdxCKM9qz6PrzO8FAWRPKkBRrkwli0VMcSIiZmYFAPVi
   vKHm8yv5DEkwO0GQUjfJy/Zt6U/N+o8/8ynVoFvZm+s2fs1rcKoazXD6I
   ck2vRVWpt7CCP9KqELl1QVpQVZwkG7D3mHqnSlK7FqbbhOSPZA4lgXDch
   e6+dwssLUU5Hi4+Sk/HRusUkJhXTGAbP0oJfPF3S6Erx0T3eKordRganp
   xMfdXyQOcKqz6d8EnZK9gOCXaxx4YTz3cucKsA2OdQ0fGF0xy77easPBx
   qC1oPA0ApwT9vyWx6zTIIRcDiwgrKr0fOKWQR1O/EhNcMyHFUcB6+Vxup
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1403097"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1403097"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 20:06:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="807140793"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="807140793"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2023 20:06:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 20:06:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 20:06:27 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 20:06:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ak69UdGNc978MIZA6+Ap0BzyqPSL8LQBGC6M9PkJs/fQZ/cFW+4ARHI3t8j/hk+n7awSzRG94YdWHeGrhkaIXkGMzx2+xQDKF4Ll+SIqbIAwHdYt8uRzW0JbKfvkwfYJTQGkt17A4T/JSkMwKqJfEnWwELjSE+hJlUqvFpXEo8iLnM1klfDW/m/qZqr6JqyVvqZcdgbsV0fhJO6BoJGHrDHxKCm9VjVkbsW75UQMnK7V/PpIJEmvBV48BYf8OOHaYRp7aagGJeoKkFzoTKItj2Mfn/VfqCRxq6y8KMBri3/MTnGjvME2B/9dpkDaK17W07yyphzw9sT829qINnhdOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sl/oh4GDynFCiDM5GD/zn5wPVyrvWiocOosWuiC7EuM=;
 b=YDOB7fzQPU9olpet/0h133BLdKNDAsvs1YK4SCEXK2qVpCTswH1a0fELtQH6nVhC9+AW3qiTHAyDraQhLvNbnK0YSCLcCjX5luxoEo4weIYtT7KVXo2+iawKtbIm4UDZNUFud6GLQcAWvSyimDC/WznPVuXUvYNaEFuaNLEZKnXjmtKk3T2ZHHuZu+c+gwfpxoWNd1ei25BXUKO+2nAWAxMuPMXbAuS9L6AAJkKr8ORcm+xZUdoRKqHcvqGACnvDIqsVGAYKjb5lfnpPQkaOZrNH05VspD8PlEehqM8Y/tEftS5Ff4AMZ3W2UM1+27K6LnqscTRrCJMqQV/2NeRPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8500.namprd11.prod.outlook.com (2603:10b6:a03:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 04:06:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 04:06:23 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] iommu/vt-d: Setup scalable mode context entry in
 probe path
Thread-Topic: [PATCH v2 1/6] iommu/vt-d: Setup scalable mode context entry in
 probe path
Thread-Index: AQHaJxokPxGF/GdwxUyj9CpRvu5z47CfFpuAgAGEkwCAAuNx8A==
Date:   Mon, 11 Dec 2023 04:06:22 +0000
Message-ID: <BN9PR11MB527662E58256CC4BF8255C3E8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
 <20231205012203.244584-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A5F34EA7CBBF026E264E8C8AA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <0008adc6-57fd-4ac8-8e8e-5a966596ad61@linux.intel.com>
In-Reply-To: <0008adc6-57fd-4ac8-8e8e-5a966596ad61@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8500:EE_
x-ms-office365-filtering-correlation-id: c4133860-f49e-496e-7b90-08dbf9fe8982
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wUJHaAm4baiWgQe7l4tjc27zWD2vcUGrwBxiVe5FKjAGQDo9ojvwKHAFEuf+0GD0FzsXBtWE1mdrWwgEe3mrusGATeJQspLEBLc7L9YwA+syj1ehvn3bpsN+vcJkhR6WR4PtJWlEMMDmvQSEZWZsKFu4/N23sdNi5HVs7qS+vYvj+mqp/uWxt5YFydQ2GWgAKfEuTCIigRFx/vPodfSoqjvXrNobZT5oUZxvQBWF9v1k5wEZK2vd5w4L1DW2/895Zi0zDLULlGRjwrjWrlm2DCvJkcfwCHFMQ58jemkC5aLMvo4huCXco2ceV1X8mIQYM1iRL9KuQPr/KffcS9n7iZ2cbOTKD7G4WrEGqJgS7AsTq2Ta5i+KN5nWtwZIppraTQBJjpqZsgrR7akUSYHVJhiWTYIa6zaXJU9FmPgnuPQJYgwRRm6ZrKwxkLVLeLWS8cW27vVM0/3Z3t7CUTog8/lMq/dfmhfWPDR/h9NSpOA7O5G0zVedb9Lmv14QLC9boKrliOi4fT9oRwHYEc3Vvgjs91w1dTw5BLeG+lWFiFZXI7hKibL7UOoYqrVONe+mG02y0dW9o8vazOmCAkUSKhijrR/LlV8BWE9Bt49cjx1US60i4nO3efHQBeG2qg7B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(26005)(83380400001)(82960400001)(38070700009)(33656002)(86362001)(38100700002)(122000001)(5660300002)(316002)(8936002)(8676002)(4326008)(52536014)(2906002)(7696005)(6506007)(9686003)(71200400001)(53546011)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(76116006)(110136005)(478600001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFZRUDZXb2Q4c25UNE5MYklUQk9SSXhRbG0yNStGb2JTL1hCdDh0dzduN0lp?=
 =?utf-8?B?bmFVd3VQTXZ0Q0hKQUxFR3k0L0RvVEhlS1JKZEFCSEE4RnVjbmZwUlEyaSto?=
 =?utf-8?B?elBxdFQxUTB6UlczN1lmQzdqVWpmTndvSDhyS1laTEhvRGFGQkVZL0FVWnlo?=
 =?utf-8?B?bmMyNS9HS3IrUWV5K2hJaFFDUGtsdTRDcEVsc0NIdGxSbnNkbTVzNmNXeWxp?=
 =?utf-8?B?TWd0U2RmT3ptWEtqQ2xMVFV0YnpwdUp6TW1NZXBIQnFlSnFNWFlxT2Q4U2o4?=
 =?utf-8?B?MWZNL0lndHpGdXV0RUlzTG5QVXZyRFFNdlg3UEYyWGNPNEtadTdKNVlEUFox?=
 =?utf-8?B?UmV6Z1RYYU1JOXhGVElQeVFmMmtOMktoWmpwNExXUzdBSVRiV3h0VlFXYkI5?=
 =?utf-8?B?QlFlb1dSK1orOHJaWjNXTG9zSXhKL2VhUWppbCtrdWRqb0JrakVUeTFNVFZz?=
 =?utf-8?B?NmVPaG01Qnk1bzFpRjNiNk9PbElXbUp6U3M4WVBJMlcwZHVjckpMUFNPdkE2?=
 =?utf-8?B?V1I3dG5PV3pxd0hob01ROFppQ0JNRUdkUEM5ekkxQytVTUlmVzAwRlhYVVh5?=
 =?utf-8?B?TjcxdDUwYk9uZUF3OWZnUmt6blpBQVRrS2VsSENLT2lJYW5mRVpoeUlCWWFH?=
 =?utf-8?B?LzVHZHA4aU4wWUxWZ1VwSDJWSUpyNC9hWGtjWU5HV21WNFZDNWhVcFoxTmVl?=
 =?utf-8?B?WVVLWmFLa2JuTUNzeVJHdDRrajZqMlNoWXRFSUh5TjBCQUxpamJxS2tIcjRr?=
 =?utf-8?B?TXUxcEdjcHFqT1JONDkrZmZsNzE4TStnMEZXaEtWaVFJd2lwZW5ORDk3RUFz?=
 =?utf-8?B?VUdQSHcwNzdjSGJrbWF5SzBWUWJhMlYyN3piYmx1V2R0MUp6dC8wUnlhVUlo?=
 =?utf-8?B?dnhZenM0NVh6WGRMMVE3ZStBc2lVMzAzbW1LaUJvQUIwbHBCd2YzOHRLSkYv?=
 =?utf-8?B?ZHVoZUd2YzJBZUl6UTF0TjZBQkdZUlY2R0VUTmtwT3ZIZ25KenNjb3RacHlT?=
 =?utf-8?B?V1hyYkpzbVkrOUN6WUVXcVZKK0dYN0FiQnJIbytmVU9mek9KSFlxYTIwcTNL?=
 =?utf-8?B?cWpOTzRJMzdSNXlqdm0xRmZZTFdiUEgrNFJsdGJjNFhUc2ZSMndDNnZiTVJU?=
 =?utf-8?B?czFnSExKbEprUEgvRGx5Tm5XSHVYZUpudTRGNzFGMG8ybWJiWmJYMDdtT3o0?=
 =?utf-8?B?YjF4MEwrZFNaK3pnV0YzN1poMitXYTFRTUNDSHhtYzlkOStlRDVuLzlMNVEw?=
 =?utf-8?B?UCtrMVFJYzl5eVpUc2Z0L0ZmWFVXMEVXYjVVWmwzZW16NkFzL2dOeVhGcFQw?=
 =?utf-8?B?MFpZbC9qOUN4eWV3UENuRmFLK1FjY2JKT3hNbHBONTAxekMvYlVJRXFpUi9M?=
 =?utf-8?B?M3U0QytJbmRjSUZZVkR0M2RxNjV2TlBVT0luVlAzYnMzTDdBaWU3T1hER0tU?=
 =?utf-8?B?N3VPQVRXb0p3b2NXS1VyWkJRdUxHUVVhN3lxZTcwbHpKSXNYMk1Jc1VVWlR0?=
 =?utf-8?B?QTZmRS9tdTVoRXpPVmxYMVZDV3pFaFRVc29ZQ0dMbVBIYlFXYmdnVEk4T0ZD?=
 =?utf-8?B?ZFdDYmI3SjM5M3dLSWQyYzRvdGNyWTRYY0FCR245NXMvSkUxai9ieVduaG9V?=
 =?utf-8?B?eHp1WTdQbnYvNkFVZlZiRUs5VXI3NjEwZUpNNzRPRCsyb1hGUGlKOTVYVDJV?=
 =?utf-8?B?NXA3Z1lnNThGY2xsNlBIT0ZDSkkvVUcyaVM0SDdtcU8ydzBwVTRjOWNrWDh4?=
 =?utf-8?B?ckhxYisxTnhVUkduM2NuelJMd0tDb3NDVGJWelYxdnZIQ0ZwUGxDT0ZYWGlE?=
 =?utf-8?B?eStYV1hNWnJXWmlZOEdiclFWd0pmZHFUb1JmaXc0T09PbDVTeTlxZVduMG9B?=
 =?utf-8?B?Y2NjTjF5bmdGR2tTc1V6M29ZYkw5R2c5MmR4QzlZQ2IxNnFDNzFhQ2hTRFpw?=
 =?utf-8?B?VWNhdEQ0dWlhQ1RLSlpvTCtNVlRqZmMydUVBMXJnY09aSGlKcThVT1ZQaUFp?=
 =?utf-8?B?SWsyVjhidlRyOVZzekk1ajhHNXFjVm5Sbk9XMXNGTEdYRlJqY1V6dzBiS2gv?=
 =?utf-8?B?YWp5SlVuRWhrVkF1YUhvUW1KWFpSMFdCQXJKSndTODRvMzE0MWNxS25JQnlm?=
 =?utf-8?Q?7EEFpOp23foZFh1ceLWMNcRjB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4133860-f49e-496e-7b90-08dbf9fe8982
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 04:06:22.7007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: armd8C7k0FVBJlDoKGQk/waE0FBnSVTo0O34psLqnXtv7uN2ZgHPt16ss6R2uarz36bQy8seC/IQwruoDXzAAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8500
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

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTYXR1
cmRheSwgRGVjZW1iZXIgOSwgMjAyMyAzOjUzIFBNDQo+IA0KPiBPbiAxMi84LzIzIDQ6NTAgUE0s
IFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXgu
aW50ZWwuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciA1LCAyMDIzIDk6MjIgQU0N
Cj4gPj4NCj4gPj4gQEAgLTMwNCw2ICszMDQsMTEgQEAgaW50IGludGVsX3Bhc2lkX3NldHVwX2Zp
cnN0X2xldmVsKHN0cnVjdA0KPiBpbnRlbF9pb21tdQ0KPiA+PiAqaW9tbXUsDQo+ID4+ICAgCQly
ZXR1cm4gLUVJTlZBTDsNCj4gPj4gICAJfQ0KPiA+Pg0KPiA+PiArCWlmIChpbnRlbF9wYXNpZF9z
ZXR1cF9zbV9jb250ZXh0KGRldiwgdHJ1ZSkpIHsNCj4gPj4gKwkJZGV2X2VycihkZXYsICJDb250
ZXh0IGVudHJ5IGlzIG5vdCBjb25maWd1cmVkXG4iKTsNCj4gPj4gKwkJcmV0dXJuIC1FTk9ERVY7
DQo+ID4+ICsJfQ0KPiA+PiArDQo+ID4+ICAgCXNwaW5fbG9jaygmaW9tbXUtPmxvY2spOw0KPiA+
PiAgIAlwdGUgPSBpbnRlbF9wYXNpZF9nZXRfZW50cnkoZGV2LCBwYXNpZCk7DQo+ID4+ICAgCWlm
ICghcHRlKSB7DQo+ID4+IEBAIC0zODQsNiArMzg5LDExIEBAIGludCBpbnRlbF9wYXNpZF9zZXR1
cF9zZWNvbmRfbGV2ZWwoc3RydWN0DQo+ID4+IGludGVsX2lvbW11ICppb21tdSwNCj4gPj4gICAJ
CXJldHVybiAtRUlOVkFMOw0KPiA+PiAgIAl9DQo+ID4+DQo+ID4+ICsJaWYgKGludGVsX3Bhc2lk
X3NldHVwX3NtX2NvbnRleHQoZGV2LCB0cnVlKSkgew0KPiA+PiArCQlkZXZfZXJyKGRldiwgIkNv
bnRleHQgZW50cnkgaXMgbm90IGNvbmZpZ3VyZWRcbiIpOw0KPiA+PiArCQlyZXR1cm4gLUVOT0RF
VjsNCj4gPj4gKwl9DQo+ID4+ICsNCj4gPj4gICAJcGdkID0gZG9tYWluLT5wZ2Q7DQo+ID4+ICAg
CWFnYXcgPSBpb21tdV9za2lwX2FnYXcoZG9tYWluLCBpb21tdSwgJnBnZCk7DQo+ID4+ICAgCWlm
IChhZ2F3IDwgMCkgew0KPiA+PiBAQCAtNTA1LDYgKzUxNSwxMSBAQCBpbnQgaW50ZWxfcGFzaWRf
c2V0dXBfcGFzc190aHJvdWdoKHN0cnVjdA0KPiA+PiBpbnRlbF9pb21tdSAqaW9tbXUsDQo+ID4+
ICAgCXUxNiBkaWQgPSBGTFBUX0RFRkFVTFRfRElEOw0KPiA+PiAgIAlzdHJ1Y3QgcGFzaWRfZW50
cnkgKnB0ZTsNCj4gPj4NCj4gPj4gKwlpZiAoaW50ZWxfcGFzaWRfc2V0dXBfc21fY29udGV4dChk
ZXYsIHRydWUpKSB7DQo+ID4+ICsJCWRldl9lcnIoZGV2LCAiQ29udGV4dCBlbnRyeSBpcyBub3Qg
Y29uZmlndXJlZFxuIik7DQo+ID4+ICsJCXJldHVybiAtRU5PREVWOw0KPiA+PiArCX0NCj4gPj4g
Kw0KPiA+PiAgIAlzcGluX2xvY2soJmlvbW11LT5sb2NrKTsNCj4gPj4gICAJcHRlID0gaW50ZWxf
cGFzaWRfZ2V0X2VudHJ5KGRldiwgcGFzaWQpOw0KPiA+PiAgIAlpZiAoIXB0ZSkgew0KPiA+DQo+
ID4gaW5zdGVhZCBvZiByZXBsaWNhdGluZyB0aGUgaW52b2NhdGlvbiBpbiBhbGwgdGhyZWUgc3R1
YnMgaXQncyBzaW1wbGVyIHRvDQo+ID4gZG8gb25jZSBpbiBkbWFyX2RvbWFpbl9hdHRhY2hfZGV2
aWNlKCkgZm9yIGFsbCBvZiB0aGVtLg0KPiANCj4gSXQncyBub3QgZ29vZCB0byByZXBlYXQgdGhl
IGNvZGUuIFBlcmhhcHMgd2UgY2FuIGFkZCB0aGlzIGNoZWNrIHRvDQo+IGludGVsX3Bhc2lkX2dl
dF9lbnRyeSgpPyBUaGUgcnVsZSBpcyB0aGF0IHlvdSBjYW4ndCBnZXQgdGhlIHBhc2lkIGVudHJ5
DQo+IGlmIHRoZSBjb250ZXh0IGlzIGNvcGllZC4NCg0KWW91IGNhbiBhZGQgYSBjaGVjayBpbiBp
bnRlbF9wYXNpZF9nZXRfZW50cnkoKSBidXQgaXQncyBub3QgYSBjbGVhbg0KY29kZSBwdXR0aW5n
IGRlbGF5ZWQgc2V0dXAgaW5zaWRlIGl0IGFzIHdlIGRvbid0IGtub3cgd2hlbiB0aGF0DQpoZWxw
ZXIgbWlnaHQgYmUgY2FsbGVkLiBJdCdzIGNsZWFyZXIgdG8gZG8gZGVsYXllZCBzZXR1cCByaWdo
dCBpbiB0aGlzDQphdHRhY2ggcG9pbnQuDQoNCj4gPg0KPiA+PiArDQo+ID4+ICsJLyoNCj4gPj4g
KwkgKiBDYWNoZSBpbnZhbGlkYXRpb24gZm9yIGNoYW5nZXMgdG8gYSBzY2FsYWJsZS1tb2RlIGNv
bnRleHQgdGFibGUNCj4gPj4gKwkgKiBlbnRyeS4NCj4gPj4gKwkgKg0KPiA+PiArCSAqIFNlY3Rp
b24gNi41LjMuMyBvZiB0aGUgVlQtZCBzcGVjOg0KPiA+PiArCSAqIC0gRGV2aWNlLXNlbGVjdGl2
ZSBjb250ZXh0LWNhY2hlIGludmFsaWRhdGlvbjsNCj4gPj4gKwkgKiAtIERvbWFpbi1zZWxlY3Rp
dmUgUEFTSUQtY2FjaGUgaW52YWxpZGF0aW9uIHRvIGFmZmVjdGVkIGRvbWFpbnMNCj4gPj4gKwkg
KiAgIChjYW4gYmUgc2tpcHBlZCBpZiBhbGwgUEFTSUQgZW50cmllcyB3ZXJlIG5vdC1wcmVzZW50
KTsNCj4gPj4gKwkgKiAtIERvbWFpbi1zZWxlY3RpdmUgSU9UTEIgaW52YWxpZGF0aW9uIHRvIGFm
ZmVjdGVkIGRvbWFpbnM7DQo+ID4+ICsJICogLSBHbG9iYWwgRGV2aWNlLVRMQiBpbnZhbGlkYXRp
b24gdG8gYWZmZWN0ZWQgZnVuY3Rpb25zLg0KPiA+PiArCSAqDQo+ID4+ICsJICogRm9yIGtkdW1w
IGNhc2VzLCBvbGQgdmFsaWQgZW50cmllcyBtYXkgYmUgY2FjaGVkIGR1ZSB0byB0aGUNCj4gPj4g
KwkgKiBpbi1mbGlnaHQgRE1BIGFuZCBjb3BpZWQgcGd0YWJsZSwgYnV0IHRoZXJlIGlzIG5vIHVu
bWFwcGluZw0KPiA+PiArCSAqIGJlaGF2aW91ciBmb3IgdGhlbSwgdGh1cyB3ZSBuZWVkIGV4cGxp
Y2l0IGNhY2hlIGZsdXNoZXMgZm9yIGFsbA0KPiA+PiArCSAqIGFmZmVjdGVkIGRvbWFpbiBJRHMg
YW5kIFBBU0lEcyB1c2VkIGluIHRoZSBjb3BpZWQgUEFTSUQgdGFibGUuDQo+ID4+ICsJICogR2l2
ZW4gdGhhdCB3ZSBoYXZlIG5vIGlkZWEgYWJvdXQgd2hpY2ggZG9tYWluIElEcyBhbmQgUEFTSURz
DQo+ID4+IHdlcmUNCj4gPj4gKwkgKiB1c2VkIGluIHRoZSBjb3BpZWQgdGFibGVzLCB1cGdyYWRl
IHRoZW0gdG8gZ2xvYmFsIFBBU0lEIGFuZCBJT1RMQg0KPiA+PiArCSAqIGNhY2hlIGludmFsaWRh
dGlvbi4NCj4gPj4gKwkgKg0KPiA+PiArCSAqIEZvciBrZHVtcCBjYXNlLCBhdCB0aGlzIHBvaW50
LCB0aGUgZGV2aWNlIGlzIHN1cHBvc2VkIHRvIGZpbmlzaA0KPiA+PiArCSAqIHJlc2V0IGF0IGl0
cyBkcml2ZXIgcHJvYmUgc3RhZ2UsIHNvIG5vIGluLWZsaWdodCBETUEgd2lsbCBleGlzdCwNCj4g
Pj4gKwkgKiBhbmQgd2UgZG9uJ3QgbmVlZCB0byB3b3JyeSBhbnltb3JlIGhlcmVhZnRlci4NCj4g
Pj4gKwkgKi8NCj4gPj4gKwlpZiAoY29udGV4dF9jb3BpZWQoaW9tbXUsIGJ1cywgZGV2Zm4pKSB7
DQo+ID4+ICsJCWNvbnRleHRfY2xlYXJfZW50cnkoY29udGV4dCk7DQo+ID4+ICsJCWNsZWFyX2Nv
bnRleHRfY29waWVkKGlvbW11LCBidXMsIGRldmZuKTsNCj4gPj4gKwkJaW9tbXUtPmZsdXNoLmZs
dXNoX2NvbnRleHQoaW9tbXUsIDAsDQo+ID4+ICsJCQkJCSAgICgoKHUxNilidXMpIDw8IDgpIHwg
ZGV2Zm4sDQo+ID4+ICsJCQkJCSAgIERNQV9DQ01EX01BU0tfTk9CSVQsDQo+ID4+ICsJCQkJCSAg
IERNQV9DQ01EX0RFVklDRV9JTlZMKTsNCj4gPj4gKwkJcWlfZmx1c2hfcGFzaWRfY2FjaGUoaW9t
bXUsIDAsIFFJX1BDX0dMT0JBTCwgMCk7DQo+ID4+ICsJCWlvbW11LT5mbHVzaC5mbHVzaF9pb3Rs
Yihpb21tdSwgMCwgMCwgMCwNCj4gPj4gRE1BX1RMQl9HTE9CQUxfRkxVU0gpOw0KPiA+PiArCQlk
ZXZ0bGJfaW52YWxpZGF0aW9uX3dpdGhfcGFzaWQoaW9tbXUsIGRldiwNCj4gPj4gSU9NTVVfTk9f
UEFTSUQpOw0KPiA+PiArCX0NCj4gPg0KPiA+IEkgZG9uJ3Qgc2VlIHRoaXMgbG9naWMgZnJvbSBl
eGlzdGluZyBjb2RlLiBJZiBpdCdzIGEgYnVnIGZpeCB0aGVuDQo+ID4gcGxlYXNlIHNlbmQgaXQg
c2VwYXJhdGVseSBmaXJzdC4NCj4gDQo+IFRoaXMgY29kZSBvcmlnaW5hdGVzIGZyb20gZG9tYWlu
X2NvbnRleHRfbWFwcGluZ19vbmUoKS4gSXQncyBub3QgYSBidWcNCj4gZml4Lg0KDQpidXQgaXQn
cyBub3QgdGhlIHNhbWUgZmxvdzoNCg0KICAgICAgICAvKg0KICAgICAgICAgKiBGb3Iga2R1bXAg
Y2FzZXMsIG9sZCB2YWxpZCBlbnRyaWVzIG1heSBiZSBjYWNoZWQgZHVlIHRvIHRoZQ0KICAgICAg
ICAgKiBpbi1mbGlnaHQgRE1BIGFuZCBjb3BpZWQgcGd0YWJsZSwgYnV0IHRoZXJlIGlzIG5vIHVu
bWFwcGluZw0KICAgICAgICAgKiBiZWhhdmlvdXIgZm9yIHRoZW0sIHRodXMgd2UgbmVlZCBhbiBl
eHBsaWNpdCBjYWNoZSBmbHVzaCBmb3INCiAgICAgICAgICogdGhlIG5ld2x5LW1hcHBlZCBkZXZp
Y2UuIEZvciBrZHVtcCwgYXQgdGhpcyBwb2ludCwgdGhlIGRldmljZQ0KICAgICAgICAgKiBpcyBz
dXBwb3NlZCB0byBmaW5pc2ggcmVzZXQgYXQgaXRzIGRyaXZlciBwcm9iZSBzdGFnZSwgc28gbm8N
CiAgICAgICAgICogaW4tZmxpZ2h0IERNQSB3aWxsIGV4aXN0LCBhbmQgd2UgZG9uJ3QgbmVlZCB0
byB3b3JyeSBhbnltb3JlDQogICAgICAgICAqIGhlcmVhZnRlci4NCiAgICAgICAgICovDQogICAg
ICAgIGlmIChjb250ZXh0X2NvcGllZChpb21tdSwgYnVzLCBkZXZmbikpIHsNCiAgICAgICAgICAg
ICAgICB1MTYgZGlkX29sZCA9IGNvbnRleHRfZG9tYWluX2lkKGNvbnRleHQpOw0KDQogICAgICAg
ICAgICAgICAgaWYgKGRpZF9vbGQgPCBjYXBfbmRvbXMoaW9tbXUtPmNhcCkpIHsNCiAgICAgICAg
ICAgICAgICAgICAgICAgIGlvbW11LT5mbHVzaC5mbHVzaF9jb250ZXh0KGlvbW11LCBkaWRfb2xk
LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKCgo
dTE2KWJ1cykgPDwgOCkgfCBkZXZmbiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIERNQV9DQ01EX01BU0tfTk9CSVQsDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBETUFfQ0NNRF9ERVZJQ0VfSU5WTCk7
DQogICAgICAgICAgICAgICAgICAgICAgICBpb21tdS0+Zmx1c2guZmx1c2hfaW90bGIoaW9tbXUs
IGRpZF9vbGQsIDAsIDAsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRE1BX1RMQl9EU0lfRkxVU0gpOw0KICAgICAgICAgICAgICAgIH0NCg0KICAgICAg
ICAgICAgICAgIGNsZWFyX2NvbnRleHRfY29waWVkKGlvbW11LCBidXMsIGRldmZuKTsNCiAgICAg
ICAgfQ0KDQo+IA0KPiA+PiArDQo+ID4+ICsJY29udGV4dF9lbnRyeV9zZXRfcGFzaWRfdGFibGUo
Y29udGV4dCwgZGV2KTsNCj4gPg0KPiA+IGFuZCBoZXJlIGlzIGFkZGl0aW9uYWwgY2hhbmdlIHRv
IHRoZSBjb250ZXh0IGVudHJ5LiBXaHkgaXMgdGhlDQo+ID4gY29udGV4dCBjYWNoZSBpbnZhbGlk
YXRlZCBpbiB0aGUgc3RhcnQ/DQo+IA0KPiBUaGUgcHJldmlvdXMgY29udGV4dCBlbnRyeSBtYXkg
YmUgY29waWVkIGZyb20gYSBwcmV2aW91cyBrZXJuZWwuDQo+IFRoZXJlZm9yZSwgd2UgbmVlZCB0
byB0ZWFyIGRvd24gdGhlIGVudHJ5IGFuZCBmbHVzaCB0aGUgY2FjaGVzIGJlZm9yZQ0KPiByZXVz
aW5nIGl0Lg0KDQp0aGVyZSBpcyBubyByZXVzZSBiZWZvcmUgdGhpcyBmdW5jdGlvbiByZXR1cm5z
LiB0aGVuIHdoeSBub3QgZG9pbmcganVzdA0Kb25lIGZsdXNoIGluIHRoZSBlbmQ/DQoNCg==
