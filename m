Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C0E7DF733
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377010AbjKBP6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376952AbjKBP6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:58:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8066719F;
        Thu,  2 Nov 2023 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698940680; x=1730476680;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BW/l8AGO+MA72rHeWemu2P6vKfVJ0dCkBj2Wf/boGJc=;
  b=GBmHa1pGJn9i2EPk7lexptl6QPDcwd7V9JqtDPNdVz130m5FV9caaPar
   txJUN8GzXk+32LaulKbNGv2ovzXfDLdsnUpdL6LcKKWXaTzTa2en/FjVv
   iC07j3Mz5SlK6Zq1u01kuMg3mmG6ccLO03ElKT68/KJ5bdqaErHyBhTHh
   vqvcfRGn5j9EcnDiWMkmcDWZMEN9dNYSrZ44J7MuBSbhW4eWRh/2mhgWy
   sbwtc+I7q7l5WvzyFg1uM1n61Nrws4KOrp1oBOPJjasNHjo15LwLXA+rl
   WcyammUlNuydJ+0LGCq06kQsjy3YKD35EEAoFRIsl65xK+/KKoOlDmg3i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="391609525"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="391609525"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:57:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1008507416"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="1008507416"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 08:57:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 08:57:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 08:57:57 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 08:57:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SX6fH7fWJ7IoPcQxVJKfWZ5hr8+6FwUj7FWeUrJIxRJ/z8yJHpTa/DiNNUtkHCmoIfdDR0nLOJ2GCqsXQAIlrb8TVwi2awlP0UuRVMqR0ENwLMjohMax7tro0dTAH+cFcHRfKXJOFM/ZP9LMG0zbpFGfC5VQv2McFr740rAQs1TTweKg8TpAThQEu7jKgTX50F8okwAD+iHkmgpTJvPQbGUige6tkZWGWn3TTKzeenAupC6YGOasyxiiAdjdRjNMBidHMsoetcVGuIvX7nPPCmpbANvq1Zx28MfEKVb9qXUUeNCbTLRj1PawkMMhZVsV27rGqeAk5lHB5yksGuiwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BW/l8AGO+MA72rHeWemu2P6vKfVJ0dCkBj2Wf/boGJc=;
 b=dHQS7kU7QsplLehcNEAef+Op8peQVakxnBrfPDLsqTJb/WHDvgaNfiYi0xUFaDcyP5PjvgpmaUTEZjatVdW8LIqM1XKttiFmQJJa1F2FB7F9bS4w/SB+nyFRqeWP7v1+LNGwtYmxqWVvypzAz7Rtg6ZS812fCGTOa9A6CJQApAKJm1phg2PucP6XfURvvJF9ln3Mz36VBVfDU4dWvfveGJpD2poSVpzeK8Jqt4fTGuwz/kt2Npgw8t016THYXmfzRJw37TqDf8En9PA/EkT2DsPR5Ifq+HygokFldDiHyrUM6D7WNAyunlMa9dNMw/Kv3ZE2PJbl5qB+GaxclWi1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH0PR11MB5561.namprd11.prod.outlook.com (2603:10b6:610:d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 15:57:55 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 15:57:55 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "hch@lst.de" <hch@lst.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "patchwork@huawei.com" <patchwork@huawei.com>,
        "petrtesarik@huaweicloud.com" <petrtesarik@huaweicloud.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "petr.tesarik1@huawei-partners.com" 
        <petr.tesarik1@huawei-partners.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "miaoxie@huawei.com" <miaoxie@huawei.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "leijitang@huawei.com" <leijitang@huawei.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "huawei.libin@huawei.com" <huawei.libin@huawei.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "johnny.chenyi@huawei.com" <johnny.chenyi@huawei.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "petr@tesarici.cz" <petr@tesarici.cz>,
        "roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>,
        "ming.fu@huawei.com" <ming.fu@huawei.com>,
        "zhujianwei7@huawei.com" <zhujianwei7@huawei.com>
Subject: Re: [PATCH v2 1/1] swiotlb: do not free decrypted pages if dynamic
Thread-Topic: [PATCH v2 1/1] swiotlb: do not free decrypted pages if dynamic
Thread-Index: AQHaDXBIahseLAG2M0+GbWknWZfxe7BnL80A
Date:   Thu, 2 Nov 2023 15:57:55 +0000
Message-ID: <e0129428bc80f9deaf7a6852007d48103e133e27.camel@intel.com>
References: <20231102071821.431-1-petrtesarik@huaweicloud.com>
         <20231102071821.431-2-petrtesarik@huaweicloud.com>
In-Reply-To: <20231102071821.431-2-petrtesarik@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH0PR11MB5561:EE_
x-ms-office365-filtering-correlation-id: 0d1f2863-225a-406c-edfc-08dbdbbc7a3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +DczEF/tidM2aUf7MpwjHNZg+Dk6kFibOYx+BIPWJejY9zTA+4u8+C8Nzfjem4mWI+k1+S77VwPC7iKrvHFtJ+D6WW7uE5Om0yCsBywKNcOdrvmdga/pyyxy3vtDAPGfc78KpfvOyTAh6W8J6QQR+THgzORIFVq6ah9aheKXgaDN7x/HyYkfZYYyOsGzt+Y5bru2S1gw80yrNEUlrx5ZaOt4da/8JE2v97KEYgQC55J6rUJ0YUadDpbuY5ktRhcNeLy5UsbKjx/DMLn/oqmZ2jzul2POLl3fRt1mfLGtSgjfDvCQv88ZnqBC52yfDkUFNZP+D7wwEy/Zo4XV6OF5QSY5chSW327N6ywW4k69x2RkgPiMrmGMLbP4IiJpO21tSFnTRaweaDEIa8rDvUwSRYatjd8NQVLoRi9q8TI2al/fkf31UMoVKUcLTHiC3rMmYbq+MDQQL+kNd0rcszXPer7tEueFrcuNkDkdKmr3K7gsaM7FXlxKCPcFhyNoVhfJUOMW2AvPhH1iEhwm9KfuZqSj0hT+rx2o0da02t5pStA2nwbfGxu6/Cs68KQcrwiE0l0vLjW5a89tgjCiZjol8+Qz+2vefk8QR5GhldJHYjF8SS9dxrCpwU63omk40Y2W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(26005)(38100700002)(91956017)(110136005)(76116006)(316002)(54906003)(64756008)(66446008)(66476007)(66556008)(7416002)(66946007)(5660300002)(8936002)(4326008)(8676002)(6512007)(2616005)(2906002)(6486002)(71200400001)(4744005)(478600001)(41300700001)(6506007)(86362001)(122000001)(82960400001)(36756003)(38070700009)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bktIdEMrOHRDUmVKVWkyZXZZZ2RhY3ArRXNtRk8zY0R3R1dzdExpOFZpL0VU?=
 =?utf-8?B?RkN2Z1N4d1hXMXRjQzlzQzdRQmUxVi9zdU1QVWxxZ21CTWNEa2QyR2lBQXd6?=
 =?utf-8?B?aUk5VWNVOEwyOWUvUUE4Z0s5SUh3K05OWVlOVG0ySVA2THR5YVA3anNlOGxE?=
 =?utf-8?B?aDh4Zzl1WkN6ZlZYTmtXaFhFejhaemEzTEZDOEdXTTIraFJDOEF5M1E4Nmt0?=
 =?utf-8?B?ZkR3ai9QazM0dTZKbUlqUDhYYmhwVGFvTVJvRW0wZzg2ZHlLTVNTalRPanJI?=
 =?utf-8?B?ZUJwbXFZZTJKYmtwTURFeU5IZjBmSXlaalZNVHBxOU41d0lkTm9XUlFkWlFH?=
 =?utf-8?B?MUJJbDBwMzJva0xwRkQ1NjNVbks3QjcvMGNpbUZ4bDlRTk14b3U0TE1DWkFp?=
 =?utf-8?B?UUpOZWVMQUJrMEM2MjFsa2F2QVlyZWNSTDMyVWw2MzRKdmR2ZHBROTNOYkls?=
 =?utf-8?B?SGQ2MUR1dXo2RUdQaXFCcmplWlJVNEZKRUZaRXZ3UnNqbHA3MG9acTlOSzY1?=
 =?utf-8?B?ZFZtMExHaHkzQmlNNTRxdGRrTTJ4ZFFVUUVNc1F3SWMxU01EaHYvTmlqUWxk?=
 =?utf-8?B?b1J6a05UK0ZZd2ZtQThLbUV2UFJEQXU1QVd0dy80VU50N1I4cUdMeHVOVGhO?=
 =?utf-8?B?MmdEMXJrQk1OR0I4QTdDWXd0eEpGbVZtMzdCWW5PSzByUi95dUVhZHJQdDkr?=
 =?utf-8?B?WDZnc0wrZzZOQ2h2Z0hBZk9xSTl2eXhBb1c5bGJHNDVrdmo1Z25LMU9yL096?=
 =?utf-8?B?aE5YUWZxait4aXo2WnBXYWRVdnpVYm1NUi9VbW5CSWREUm5xWExpLzB5Rldk?=
 =?utf-8?B?QmYyL3VkaE9yR0tnUTZjNkdzUlN5alFpWGxNRWIrMmxHS3NpSEVUTVVuVm5O?=
 =?utf-8?B?K2dkdUdaYTBXQ3dxWERRc0NpeUg1T05kbERacG9PYktGQlM3MDltdlgwazRl?=
 =?utf-8?B?NVNxc1Zxby9GdVFJUFFoS2NwaDhUNmU1TUJSZm9NK3d4SGdmZ2NiVkZ4Tkdn?=
 =?utf-8?B?L3Fta25UVmc5VTVlREpkdmpmUlNueHdnOXVVdENJUHdadnAzYWIxWDl5OThD?=
 =?utf-8?B?ZWUwRlVxZGtPR01nRzJCYUt6NmFsMUVSSVUyRWx6WVNpVG1iWlhabEJlYXVv?=
 =?utf-8?B?UUF5YWl0SXZqYkh0RTRtOFpGWFV2VE9GNnNuMTBPT3M1QXdVY3UyeVk1bity?=
 =?utf-8?B?bjBnVmczYXFKUjJ3dWFrSG9pNFdPdVFKenB3UUw3aEZ6UlhpYS9OWXkvK0p2?=
 =?utf-8?B?UHhDS1M5YWRlWHE2SEhWcG0xRzN5LzJndVprSWZRY2FPUnlwbWNFMER5YTFH?=
 =?utf-8?B?TGpzcDlDRUhxQUpPMXlaMWtyVk53UnZGRjFydE1xeXpoU1VSQVcxeGZQaU1h?=
 =?utf-8?B?VzlzMUl1K01TbWVLenJqSzNCRmFiYnZTaGlBY2daY2VPckV0VitNSkhnNXMz?=
 =?utf-8?B?c2VxY0FXMmhKQmxmUldPQjhpUDlRQ2FaY2tDQjltcDFtYkkrUWVkWTNVN0kz?=
 =?utf-8?B?S2ZKb1FDT1Vxd2hwNGhvV2V0dUIwcjhlb21iK25qVGI5YWxwSVlHZmk4Zlg2?=
 =?utf-8?B?OGlJejZmaDlhU0RDL3V3a0Q5WW1uaHJpSTY2RUlxME9aR1UxQ0tBZkxIdmo2?=
 =?utf-8?B?b0Yra0VseGt3c1crUExSdzQzUjVnZGVwR3lLS1VrODV5NjZ3MnlmNzlCTjR0?=
 =?utf-8?B?YkNCWGhoNENJbzM4dWhieXYxd0p1dW0za3JBOWZpUlJzYnNDTFQ2dU9KdWxm?=
 =?utf-8?B?dTlyOS96bmppQzc1T0hVcTdnRzZlcHZNRUJKdU1aVnZvNFhqT3cwVlNjQU16?=
 =?utf-8?B?OU1rTk03Tk1vVitpWElsRENZajJEbngxdnFLWDF3eE84T0M3RkZRUXk3SXY5?=
 =?utf-8?B?QVJ6QXQrNUo3UzU4TXJPSjBJRkRlRGtVMzJJRWZDU1JCTHZsdXFjNHhCc2d3?=
 =?utf-8?B?MkozbWFPMW84M0ZoSStUNVJJNmY4bi9NMG13bTVFWUFYb3BkeDhYVFZnUzZZ?=
 =?utf-8?B?aVpQZzc5SC8xRkgzZjFjbmhFYmNicStwcUQ4RGRHcU5yc1FMam15YjYramxt?=
 =?utf-8?B?Q3BSdStwRWFTbzYrUVRTV21pYm5RY1dGOE4xTFRnbnNEeHhrMnpJbTVBTFY0?=
 =?utf-8?B?czdDNVU5RnJKSzZuaTUvT2E4V1Fjb21naTIveTFGeHI2Y043K25icXE1ZEhm?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB2938800E777141A189A994B018CECD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1f2863-225a-406c-edfc-08dbdbbc7a3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 15:57:55.4070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: djDccF/tGCz+I5vzkp6aLKkBq4LEWucBF/m8R188El7Gck5IaRD26t1LzkUwlE5g3CAH6e9IcFtX9KwQhGAC0wJV6R9yr7Cq+zFlwRgs/BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5561
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTExLTAyIGF0IDEwOjM2ICswMTAwLCBQZXRyIFRlc2FyaWsgd3JvdGU6Cj4g
K8KgwqDCoMKgwqDCoMKgdmFkZHIgPSBwaHlzX3RvX3ZpcnQocGFkZHIpOwo+IMKgwqDCoMKgwqDC
oMKgwqBpZiAoc2V0X21lbW9yeV9kZWNyeXB0ZWQoKHVuc2lnbmVkIGxvbmcpdmFkZHIsCj4gUEZO
X1VQKGJ5dGVzKSkpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGVycm9y
Owo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcGFnZTsKPiDCoAo+IMKgZXJyb3I6Cj4gLcKgwqDC
oMKgwqDCoMKgX19mcmVlX3BhZ2VzKHBhZ2UsIG9yZGVyKTsKPiArwqDCoMKgwqDCoMKgwqAvKiBJ
bnRlbnRpb25hbCBsZWFrIGlmIHBhZ2VzIGNhbm5vdCBiZSBlbmNyeXB0ZWQgYWdhaW4uICovCj4g
K8KgwqDCoMKgwqDCoMKgaWYgKCFzZXRfbWVtb3J5X2VuY3J5cHRlZCgodW5zaWduZWQgbG9uZyl2
YWRkciwKPiBQRk5fVVAoYnl0ZXMpKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
X19mcmVlX3BhZ2VzKHBhZ2UsIG9yZGVyKTsKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIE5VTEw7
Cj4gwqB9CgpNeSBwYXRjaCB3YXMgZ29pbmcgdG8ganVzdCBsZWFrIHRoZSBwYWdlcyBpZiBzZXRf
bWVtb3J5X2RlY3J5cHRlZCgpCmZhaWxzLCBhbmQgbm90IHRyeSB0byByZS1lbmNyeXB0LiBJdCBk
aWRuJ3Qgc2VlbSB3b3J0aCB0aGUgZXh0cmEgbG9naWMKZm9yIHRoZSByYXJlIGNhc2UuIEJ1dCB0
aGlzIHdvcmtzIHRvby4KClJldmlld2VkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vj
b21iZUBpbnRlbC5jb20+Cg==
