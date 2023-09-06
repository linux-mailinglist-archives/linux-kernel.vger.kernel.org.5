Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DDB7934DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 07:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbjIFF11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 01:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjIFF10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 01:27:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F09CF4;
        Tue,  5 Sep 2023 22:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693978043; x=1725514043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Btw61B9DPT4IVq1q5YEEiqhgSjVMc5Iy7ZHni6w2p8E=;
  b=PetfkW+fUi0xI+qZTbZVR2O6sO4ByCANHOBLSXT9HP+bAkoJhdLtLIJP
   d9+0kpoowSmVkS0h2/z/MEenFbshb+bg1TZjuGEZzqa6GGPSwM5ojhIh7
   PlRN8Xgx3j/TdgU6DuNhcQcri2n0TRfaawfqD7EBqDMI8G1UBLvsrcf17
   5OMT//0l5hoYZ9n/i2mnSbqqtgzg5M1SkgOYVPgm5LeuElK2y7NtuJrPq
   X9jESb3SkA97oazCHZaNGfuFQ5It2nVYAy8C1uONw71UxLEc0t9h1x9yD
   NUAmqxRvUloRkw/FvCWtuCFl7aXiLDnpejDVMWByIc8fr8AHHlJuq2xlL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375877809"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="375877809"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 22:27:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="811521769"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="811521769"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 22:27:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 5 Sep 2023 22:27:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 22:27:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 22:27:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhk6yGXAtCZdvhIA8l/xSB088YOoU6r6gYLT9tfeCtpRP3vIX8r9QAMCCkWV90B9hNjFfDhAojLCR3UINaKMPBTTSdiVaDQ/Li9k5ZCSuQ8cDTKmHBOrW7CL4eep1ZwUtjXGtx1npr4IwET8QhAQ+yUjpkBj/pFDPolzU5IPZdwt7X7CvCV0U1Vm6AkBkMtyZBKAOjgnE8RkMnMg+eQsnyYyygprBXiyxFsU5mdRYi40GRQHv/7vuE68wHkS9NQIWaHy5L1wVDccB356i/a4eyJncy9WqTGsryWYFxLtT2A/96DKtBI/U9fuyTEH0sYGvZzTmzU8y/Aab58IUpG97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Btw61B9DPT4IVq1q5YEEiqhgSjVMc5Iy7ZHni6w2p8E=;
 b=mqy0JirVvGz36+pobepQEgmfqBviWQYgTQ0l3AaA6lwMEapdZHm8XczP8AsDkHIuqwYdClMs1OsQzbGAgDqnRdgfFXJp60VGUDb1ZwK6K6PC4++deBvlmz25Lw0NLrUh6H21+2Al1ci26BV3zESLF6IBG41esRC5GQuUF06lXRMWYUHR9spzvmDaWnGNgbpdZXs/w7p/tiU20InH14nY+qenZyQAnlSocbAB+/qzB3guxE3QrTqJ2Zdrgj8eYdNszmzrHt1ieYm6jcfiHqF8992ZSjPEsoVFWkuSc8YbmXVVQZFWE8+lP2Ck9kmC/RLxnVZ2Y+Zxb1MAsu/uyJ4VRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3226.namprd11.prod.outlook.com (2603:10b6:5:59::22) by
 IA0PR11MB7791.namprd11.prod.outlook.com (2603:10b6:208:401::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 05:27:20 +0000
Received: from DM6PR11MB3226.namprd11.prod.outlook.com
 ([fe80::f9df:48b7:4f05:5065]) by DM6PR11MB3226.namprd11.prod.outlook.com
 ([fe80::f9df:48b7:4f05:5065%3]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 05:27:20 +0000
From:   "Feng, ChenzhouX" <chenzhoux.feng@intel.com>
To:     "Chen, Yu C" <yu.c.chen@intel.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "syzbot+38d04642cea49f3a3d2e@syzkaller.appspotmail.com" 
        <syzbot+38d04642cea49f3a3d2e@syzkaller.appspotmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMi8yXSBQTTogaGliZXJuYXRlOiBGaXggdGhl?=
 =?utf-8?B?IGV4Y2x1c2l2ZSBnZXQgYmxvY2sgZGV2aWNlIGluIHRlc3RfcmVzdW1lIG1v?=
 =?utf-8?Q?de?=
Thread-Topic: [PATCH v2 2/2] PM: hibernate: Fix the exclusive get block device
 in test_resume mode
Thread-Index: AQHZ4HlOOkPpxtEkf0m3sq8NeeCfNLANRBeg
Date:   Wed, 6 Sep 2023 05:27:20 +0000
Message-ID: <DM6PR11MB32262DB7A51CCA139F8B56269BEFA@DM6PR11MB3226.namprd11.prod.outlook.com>
References: <cover.1693972725.git.yu.c.chen@intel.com>
 <e2279c339fcf919cffa4802b4e32974dc8950513.1693972725.git.yu.c.chen@intel.com>
In-Reply-To: <e2279c339fcf919cffa4802b4e32974dc8950513.1693972725.git.yu.c.chen@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3226:EE_|IA0PR11MB7791:EE_
x-ms-office365-filtering-correlation-id: 9b2773fe-dde4-4188-5644-08dbae99f110
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: og4hYkgD71gbb45DSwU7OkkKPQlBuh6X3Hn6oMzivM0yMtbzaA3pxcq1qJkkUzw25n9TSsnuC8H6qixviSlygTx4hRbUncg1m0FnaMvJQL/tNWuZ/FZlMHUp2pxBez3YtL5vkSUkJgtJ7EUesp7jDXB7Leisepu5bvVLdxexnjMxOUIa1wS4ui4sMiFX6DhxB8Rs/PfbElhwbr6ssOZKFfnAzbuVpgTuMzoWtw9dCI92P9v7nE7QhCOO2pt7bJR7CDaF/8KVaPFzYGlWJtBMctauaZBOUHbFscjAp1A+vaq/ZhQZkBBaP4feW/YlNiDQRyJzrEpf4xlHZjOaTEWyuDqBm2RLnIwdsRnUBUS2Tg3vVtGXjxltk4IDgEwP6bD+urJanR14zcMU8cHVMxa08cj7OVuTHEW2Y598VmGl777+R5MSpn7Kc79Ybz2Nrat7Dz/+DGtdgijOMcULr8k/HiD0y/3ciRVSVQ46jL/u+jb0ZF2+qE5SvIOuvD3QdCEOk2SDWgea4bghYBZbXhmgn0oUZMu4NJhtzCVuQv6zkGBJE2x2o2NsPtgeFyaTGs7B9Kro5OYiBiezlMO5HQ16soxm0gK1K6Z/betuJB7X24s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3226.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199024)(186009)(1800799009)(8936002)(5660300002)(2906002)(316002)(6636002)(64756008)(54906003)(66476007)(66446008)(66556008)(224303003)(66946007)(76116006)(4326008)(52536014)(6862004)(41300700001)(7696005)(6506007)(55016003)(9686003)(26005)(966005)(122000001)(86362001)(71200400001)(38070700005)(478600001)(38100700002)(83380400001)(33656002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXVUdWozQ1Zid21YajZMUlg1V25RN3FSTFJKbXp2UE00emk5ZjZxWWRGVHg4?=
 =?utf-8?B?ekxvTytVc1BQTC8zUWxwM2gvZWpKNFhJQnRncmhlRHpURDM2R21jdUdBbmFZ?=
 =?utf-8?B?d1NRSWlubHAra25HdjVxcUJwbkI4Y21rM1hDM2YzQ2FrcjEzY1RoY2dHdjgv?=
 =?utf-8?B?N2FGMU9MeG5BQTFFZEUxby9ieEZtNFR6ZStacDI0QnVjZzNYUCs0bm9mSUNk?=
 =?utf-8?B?VnV6MER1MmhnN0Z5bG13ZUV4M24wTk1CSWYxaHVNYTlVVnVEQk9kdkRmS2Jz?=
 =?utf-8?B?YkJIZXRCaHYxTUN6TmpzUUpLMTAwZXJnMzNQdW0wdThqajc2aU1sTDYvT0Fn?=
 =?utf-8?B?VXFySFFHT0h6Qzd6eVhOV0ZCRys1eVBYaDNxRXI2WXhwYlBxZllpV3pkUWM2?=
 =?utf-8?B?K3puSjBGVEMzVktCZ0RGbG5OZUVuZm5vdlY1TWNFUStLVC9nY3p1RzZpbGFO?=
 =?utf-8?B?bGtrNUIzQW91a042ZHA4ZmZiTmdsMFVMdkxKRlN4NUVYZGVLQU1yUVZLYnRm?=
 =?utf-8?B?RFNZOWE1Mm5qQWhZSitIWnNvcDVvQjUzek9wb281djJiYlZGTkpySk5JNTBM?=
 =?utf-8?B?OWVNT3M5U09mTzcrWlhWUHRVd1RnM0FHMkl2Snptdkp2WEtFdmx0ZzJoTXNQ?=
 =?utf-8?B?ckwwazRySEJWNmNhSk1sZ0c5Mk5veU9MUG9ueWx3MUNrYnEwYmozMXNROGJ5?=
 =?utf-8?B?UEZIN0IrVkJINDVaSSs4Nm9LMktSWjZEdG9YSktRTmNUKzg0YTdEZitQTFhV?=
 =?utf-8?B?ZEVzRHV0c0pmWGdxcGhla0o3NmFKR0NRT3JzcDFwU2ptbFNONGZsQ1hlUWJD?=
 =?utf-8?B?cDRycElsNGNkR2JaQXp5R2pQMHZGQ1g1UVFjajdwNUQ4SWV6WHNtY3BEVHZN?=
 =?utf-8?B?U2tNRWFyaW5rTUtQcHJsbEZCMUpuemZSZ3AzVWg1TWtoWW80bE9QTUlJRi9M?=
 =?utf-8?B?Q1V6SW5XbHNjVkhzaVprayszSTFYNXppeFFGU3FOeC9IMU1URldhQ1Q1Q2dS?=
 =?utf-8?B?VTZwa0RhVnlZSDAvTWJBNlhZU2x3a1gzSzBzVVhycERGcU44WC8zMUNmMndv?=
 =?utf-8?B?SXZGcWNTa1FZUGxXRnU5b25EbXJoMVlockVQTmtlVER5RXVKVCtMcW1kOXFz?=
 =?utf-8?B?T1RJZ0NmVWFkc1ZIYXk1a1ZZdE1rMnhlWk93VGp4UkJvYzNOMWZ1WnhOSW9u?=
 =?utf-8?B?SGp0NFJOL3lPQ0s4cDQ3MWdnL2pMZjBkVzQxeHpCbFJTL08wTWdiaXNHaTRq?=
 =?utf-8?B?MXpMeko2ZEswK3J6VDRvbWFqdi9uMGkzcXdkaE1lY2djZTRjS3dOZUFOWGl6?=
 =?utf-8?B?ZlQ3MmNwQ1Y5eW9sTk5kZit6cWNySUZQOU1qamd3ZVpGTUd1YkpjUmMzZG5j?=
 =?utf-8?B?aW92Nk5vcHVSOTdlSExrTS9oVWtQcHc1K0hUcHdESDh3Z0w2K3Nma2doYlVu?=
 =?utf-8?B?NVNRN2Y4dGV3M1M3R29uemZNUWsydEIzanpwdzBuNUhqajNobWVZaHF3YVVY?=
 =?utf-8?B?UEZTaUtXMmFQaEJaQnlpOHlsTEVNMFhoRExCdTJ4RyttZ2l4dzhYd0RmQ2I3?=
 =?utf-8?B?RExVNXFMQ3RDOFFxU2k5NElyTkZMMEZNOUVaR2sweFZJb2JLZVFUOVd4bHEw?=
 =?utf-8?B?Vm41UkJUQTFZdnUrK1c5VGVDVFJkajVSQzVBZTRDRUM3NHk2YjA0VlJTZGJl?=
 =?utf-8?B?bm1qT3JpRE1LWmtSZENteUJIMkVXQnNkYnNjTUEwQ1FCdjcwcmRtOUtFQ0ZO?=
 =?utf-8?B?OHVDaHpwRzduRlY1akVBQkZUb3hURGJiR0NFSzRnQlZzeVRxditOOW8rV2tn?=
 =?utf-8?B?cWthN29acjFhbjgwUXdrVThScWRGVFYwaTdlekt3S3lOT1hZMWRqUC9PbGgw?=
 =?utf-8?B?dUNCMERMUms1V1o1TFlSRklmOG1XU2h3NlNxVmpiVHVwdyszVmdCNlVBN1Ry?=
 =?utf-8?B?bndFQmpmYngvelNCd04xQUlkUFdteFVHWTh1aHQvL0FhSHpqSGRZL1JYaE1o?=
 =?utf-8?B?dzh0NndCb0tBVnh5Q3lQc0dNbTdSTkUydUVoeGQ2VzRGcTVEYkNNbEJqaTd3?=
 =?utf-8?B?ZkRveTI2Mm1FNWNtb2hibit1SGU5RTM2MnVyTlRjSm9sYUlBNmszQTZJVTNC?=
 =?utf-8?Q?tQExzv+FgO8gsgOUM/TIuMSqU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3226.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2773fe-dde4-4188-5644-08dbae99f110
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 05:27:20.0635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZw9ILBx7DIVHrd49mK/x0feeFZtrylI6ox2aaDPGxc4O+BMHQOAjW/pb4i0Y0lA4G5nDnQr0Tz30R5M0JJ12UlRLCS2rp3s8rhlznW9OdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7791
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IENoZW4sIFl1IEMgPHl1
LmMuY2hlbkBpbnRlbC5jb20+DQo+IOWPkemAgeaXtumXtDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIg
NiwgMjAyMyAxMjoxOQ0KPiDmlLbku7bkuro6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2Vy
bmVsLm9yZz47IEJyb3duLCBMZW4NCj4gPGxlbi5icm93bkBpbnRlbC5jb20+OyBQYXZlbCBNYWNo
ZWsgPHBhdmVsQHVjdy5jej4NCj4g5oqE6YCBOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEZlbmcsIENoZW56aG91WA0KPiA8Y2hlbnpob3V4
LmZlbmdAaW50ZWwuY29tPjsgWHUsIFBlbmdmZWkgPHBlbmdmZWkueHVAaW50ZWwuY29tPjsgQ2hl
biwgWXUgQw0KPiA8eXUuYy5jaGVuQGludGVsLmNvbT47DQo+IHN5emJvdCszOGQwNDY0MmNlYTQ5
ZjNhM2QyZUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tDQo+IOS4u+mimDogW1BBVENIIHYyIDIv
Ml0gUE06IGhpYmVybmF0ZTogRml4IHRoZSBleGNsdXNpdmUgZ2V0IGJsb2NrIGRldmljZSBpbg0K
PiB0ZXN0X3Jlc3VtZSBtb2RlDQo+IA0KPiBjb21taXQgNTkwNGRlMGQ3MzViICgiUE06IGhpYmVy
bmF0ZTogRG8gbm90IGdldCBibG9jayBkZXZpY2UgZXhjbHVzaXZlbHkgaW4NCj4gdGVzdF9yZXN1
bWUgbW9kZSIpIGZpeGVzIGEgaGliZXJuYXRpb24gaXNzdWUgdW5kZXIgdGVzdF9yZXN1bWUgbW9k
ZS4NCj4gVGhhdCBjb21taXQgaXMgc3VwcG9zZWQgdG8gb3BlbiB0aGUgYmxvY2sgZGV2aWNlIGlu
IG5vbi1leGNsdXNpdmUgbW9kZSB3aGVuIGluDQo+IHRlc3RfcmVzdW1lLiBIb3dldmVyIHRoZSBj
b2RlIGRpZCB0aGUgb3Bwb3NpdGUsIHdoaWNoIGlzIGFnYWluc3QgaXRzIGRlc2NyaXB0aW9uLg0K
PiANCj4gSW4gc3VtbWFyeSwgdGhlIHN3YXAgZGV2aWNlIGlzIG9ubHkgb3BlbmVkIGV4Y2x1c2l2
ZWx5IGJ5IHN3c3VzcF9jaGVjaygpIHdpdGgNCj4gaXRzIGNvcnJlc3BvbmRpbmcgKmNsb3NlKCks
IGFuZCBtdXN0IGJlIGluIG5vbiB0ZXN0X3Jlc3VtZSBtb2RlLg0KPiBUaGlzIGlzIHRvIGF2b2lk
IHRoZSByYWNlIGNvbmRpdGlvbiB0aGF0IGRpZmZlcmVudCBwcm9jZXNzZXMgc2NyaWJibGUgdGhl
IGRldmljZSBhdA0KPiB0aGUgc2FtZSB0aW1lLiBBbGwgdGhlIG90aGVyIGNhc2VzIHNob3VsZCB1
c2Ugbm9uLWV4Y2x1c2l2ZSBtb2RlLg0KPiANCj4gRml4IGl0IGJ5IHJlYWxseSBkaXNhYmxpbmcg
ZXhjbHVzaXZlIG1vZGUgdW5kZXIgdGVzdF9yZXN1bWUuDQo+IA0KPiBGaXhlczogNTkwNGRlMGQ3
MzViICgiUE06IGhpYmVybmF0ZTogRG8gbm90IGdldCBibG9jayBkZXZpY2UgZXhjbHVzaXZlbHkg
aW4NCj4gdGVzdF9yZXN1bWUgbW9kZSIpDQo+IFJlcG9ydGVkLWJ5OiBzeXpib3QrMzhkMDQ2NDJj
ZWE0OWYzYTNkMmVAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KPiBDbG9zZXM6DQo+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMDAwMDAwMDAwMDAwNzYxZjVmMDYwMzMyNDEyOUBnb29n
bGUuY29tLw0KPiBSZXBvcnRlZC1ieTogUGVuZ2ZlaSBYdSA8cGVuZ2ZlaS54dUBpbnRlbC5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IENoZW4gWXUgPHl1LmMuY2hlbkBpbnRlbC5jb20+DQoNCkl0IHdv
cmtzIG9uIG15IG1hY2hpbmUsIGZvciB0aGUgd2hvbGUgc2VyaWVzLA0KVGVzdGVkLWJ5OiBDaGVu
emhvdSBGZW5nIDxjaGVuemhvdXguZmVuZ0BpbnRlbC5jb20+DQoNCnRoYW5rcywNCkNoZW56aG91
DQoNCg==
