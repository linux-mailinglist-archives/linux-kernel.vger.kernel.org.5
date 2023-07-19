Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79247759F28
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjGSUBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjGSUBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:01:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B21B3;
        Wed, 19 Jul 2023 13:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689796869; x=1721332869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q0txgRTYiyQq7O45Ep0vgu4f0U+J8LSFZ4rj9RlUk2E=;
  b=n0B6ISGryi4MXAbClqMF65K8MpocXeC4c9N/iSbmAMG2lMA19d3OmA3+
   sjddhNqfKobohwfkvzSdkVmfvEGzlYmh/Zq+yKAVv0UXtYO8Dqp+fOPTb
   7NCTFxsnSLgFfRZEn/IF1O3IFlrrsMsgS3XHgW192IKp2GDYXN8keOWql
   DE1M+wqte7bHThi+3bPhqk3yzayzcxxZCxgNp7pasch3gxjLezFHTBdHm
   ceFe/p/7L3j0eGNUhZnf2LbQfsEzGJjMmcBzDZxFGPyRExVbVsEJoaX1x
   hzFrqdYdmJYWwuICbfP1RVDy51QPH6OpCsGkt3xF9j4s1VR6b5rapO4Jb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="346150143"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="346150143"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 13:01:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="724115383"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="724115383"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 19 Jul 2023 13:01:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 13:01:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 13:01:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 13:01:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqVqoKfbva6cIYVhqU+XR4ZTIrr0cL/POtirRygkLdgyOqfhAwb5z8FhroXafbbmLPA1sBNcO7tfrceVT1ZzQFiLHI/Dr36/q6EaBG95WWIKMzhCB9uNEVn/14cdzHEMXQStLQhWh6pmMkdGv6q2X8EBuZhqJ4tGLkrxMfIjekCtZqkM8ooFe2zvSS9Wl/ZANh59AYrsly1ZSkYc5IfF6ELk9HZ8eaaSmz3h1tEcidohJaAa+qPFTra+v0+qfgVTq4GwBqMSXItKH2NFS5fXX4L2dcW+fhPBxaZLipA9G8drkGDSYqMD76D5rSscNQyHD4aabN/9DXQMm01beLpVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0txgRTYiyQq7O45Ep0vgu4f0U+J8LSFZ4rj9RlUk2E=;
 b=nFK9B37/1cjajJqdV7BAQRDDOPKRQFeNz5mw+xicJYulanSAJZAOfRhiFdzn7ETEOICVwWMs8eEpMYrddaszcC5r3557+N9NwitSvEXuuaLx9X6wioqoyfJScZNY0b3j9PiabVDOi4GFbOmx9n1BEL3VSLgm9f0jXKZf82LMAtfKhsvSCzxekYusKhD3lwtdYlKCo5BIF7LBic55EHvapLMQK7JUDthg78S9z46j1l4zApB7FTg1W9RYE5ofprE+INn/aFfYzKR0nOm5+/C34GmjBxHn7DCxlvSpoiRmnruhmrambiNOnXA1NsTbqrZt/p8bopNf0LJOAWTiPcjFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12)
 by PH7PR11MB8550.namprd11.prod.outlook.com (2603:10b6:510:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 20:01:01 +0000
Received: from MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::2f24:2dc9:60b:a244]) by MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::2f24:2dc9:60b:a244%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 20:01:01 +0000
From:   "Winiarska, Iwona" <iwona.winiarska@intel.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Solanki, Naresh" <naresh.solanki@9elements.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "Rudolph, Patrick" <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v3 2/3] hwmon: (peci/cputemp) Add Intel Sapphire Rapids
 support
Thread-Topic: [PATCH v3 2/3] hwmon: (peci/cputemp) Add Intel Sapphire Rapids
 support
Thread-Index: AQHZunC7tFRJebcb802qUlBmCBVSSa/BgpCA
Date:   Wed, 19 Jul 2023 20:01:01 +0000
Message-ID: <f3e6303e867b7a335289bf2ea3aacec5a637fb8b.camel@intel.com>
References: <20230719184155.59375-1-Naresh.Solanki@9elements.com>
         <20230719184155.59375-2-Naresh.Solanki@9elements.com>
In-Reply-To: <20230719184155.59375-2-Naresh.Solanki@9elements.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5823:EE_|PH7PR11MB8550:EE_
x-ms-office365-filtering-correlation-id: fcb8b607-2f5a-483c-d75e-08db8892e07b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QeZkHUHjyP+FRcUfw9pGdspnh5u4RJCZEcp4aFxJXJnVtu79DiE306nWwnnYMazvzRGNBntd2F1ngFC9Yvk9yk5bROZbX7tf9HxLh1Ok+5f2s6OR7bVOTGMJ+QiTGMG/Hhj2zXUbYucq+ZE1qHDF1tnXiahjcC8uJXCF8m4JQeYIW5mnXEawa246fmiSfW8AYuyeJjFXOuzPsIT4kzKS8bwhvghWvDkIJyWt0eJlpwTmBaHRl7C5egml7f3Qdj+8Fl4XkEhfQzJPfYV4UeTWY5yfhVvJCFE1emOGSCyzWfL9q/t49vYGzDcfFQpqLngU8/WerLgAXUtKNEYR6NiVCnRAyKYVva3J1uy/QNlxTYAdRmI6fxPFWWsIvSvcKjey43czJd+v79MMTddXtS6l2YztcNhpzIUwRtzmvKsFOcROsvj8Ni2SXNgh370E9Z7KVOWL1EW90Mq7CH2STKIQ0n9dsizOAtxo/RLiOsI1WmRw4prdxTY46QeNdvdPiojY0WSPzo9wJeXsEQQB1Hl/8PrJwwnLlJVAc2hmp/11+rIaLowq+z216AuRQDIkedTou/eMzZsaqJkRS1lH676D4wbyf+NghgHlDyEIhZGiMK981XGnqTdHZfwgCbTYWzy/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5823.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199021)(2616005)(316002)(41300700001)(83380400001)(186003)(6512007)(6506007)(26005)(6486002)(478600001)(82960400001)(110136005)(91956017)(122000001)(71200400001)(66446008)(4326008)(76116006)(66476007)(66946007)(66556008)(64756008)(38100700002)(86362001)(38070700005)(8676002)(2906002)(5660300002)(8936002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0ovalFGVTFFR0lybWExMkZjUjdxdm8zMUwvZXo0UE12UUxOby84QXREVHdS?=
 =?utf-8?B?dkJ0bVg3UTU1d1BQZmZ2YjJRTThiUzkyZkFEbllMN3B1ZFBHU3diMXZMZFd4?=
 =?utf-8?B?ZGNUUHdZQmRSZFlDQndrSXJsdG1jcHhZcldUS0FtWUsveVdQY1lJczdGdkc3?=
 =?utf-8?B?UlF5dVdzYzV0UWU2MDYxdDZXNzhRYXZBbEVMRzV4djV3TEliMlkxVDBuM28r?=
 =?utf-8?B?VGp4STI0d1NlWmFyK25YU0xselRlc2VMZ2s5T0pwdGNUT0d1UGJMb3dtNHlD?=
 =?utf-8?B?b2RON2w5TG1IdGdoUTJ1ay94eGs0OU9iTCtteGF0ci9VZWlDUGNsVWg0ZHVQ?=
 =?utf-8?B?VkNMWisvV0QwK3pyUE4xNEsrSWZ4R0NIZUk5c0dEOVpDNUFLdE43SXFrSXlv?=
 =?utf-8?B?L2FpY3VacGJGNXNwSVozTGxNdDBTYnJKSlloWDduai8wcHFZU0E3eWhERDZX?=
 =?utf-8?B?Y1RMZS9IcUhmQ25qak1VWU5Ec3pGVGYxaUg1eFhWa29yOVhqSzVIVkZzVDBp?=
 =?utf-8?B?VDM0N1FKT3RpQURzTUJWNWR1ZmxWeHdBcUlBTjQ5T2M4REh1U1ArelFBbXhZ?=
 =?utf-8?B?ZFdtaHJiMmZzcFRwSlQ5R1VEcDVIRUYxS3Z6SnNiWFhFcFlpQjduY2VXbTRT?=
 =?utf-8?B?WFBsanBkVCtRT3VJS1FsLy9WN0tZS0lzVzd5WnlkR3k2VmowMGM4U3c3RlZK?=
 =?utf-8?B?MVpaQUZrUjE5S2NxNm5BWHczY0laV1JNNnJ5VDVkNDFVTnJkZnUrUmlwbkdO?=
 =?utf-8?B?eC9zRVVCVzdEVTBNR0Fhdk9GUVJScFNqRVBVbmZBak9KMlRPT0UyYVFtMm8v?=
 =?utf-8?B?bGtXa2NXTVd6ZTNqVVF2RnBKYWw3OFhXSDdNTkQ2b0lYL1ZZanVENnlncDBV?=
 =?utf-8?B?SnNYTjFCQmVoaXJHekJQaXhERUpDc0NaMXJEdlQ4SDJqc0FqdUtNRzBYTzJI?=
 =?utf-8?B?S3I0VjdOby9qMTk1aFBKZ3hQU3QwdTd2a2NhZjA2RER2WXdRTGx2SmVxaDF4?=
 =?utf-8?B?bVRVVkxpVXBSck9vYk5waW15UXJvNEM2Vlc5N2ZhQ2NiTEtkbzhGbGdQdXZ1?=
 =?utf-8?B?Y01lVjhjSllQVHJ5dnNnWmRDOEYrYjZJRXN5RlBnckF4djBKRzVreTNqSkJa?=
 =?utf-8?B?Y1hXN2t5NU0xdWRtRkovVjRxYXI5OEJLL2VIMnNsMkhsZmlWbU02Vi9Od0I0?=
 =?utf-8?B?RStiSjFPT29KM2dwVmxQTmtDTmNBYTM0elVQYW5WbnRuYTJzQys0djBlcXpI?=
 =?utf-8?B?VUlOZW9NZ1JOSFErWEVRbjBmdXllenNmZ3daMEhWVXIvSWx0RXoxdmt5bTJH?=
 =?utf-8?B?UkdMQmdDbjlmQzczd3ozc08ybE0rdE5OT2V1TFN0OTMzd3BDTHl0SXh6WDU0?=
 =?utf-8?B?cEF5Qmo3NWVSMGVIajRNYi9pZmF5eU1Bd21URDZrNVFzS3pGTGlnYjV0RmlW?=
 =?utf-8?B?RUVRam4vdXNPZjgrcFN1WDh4Mjh3WEg4V1hKZW1qcDQzRUc5RTE4eHZJODRG?=
 =?utf-8?B?ak5nTHZuMTJYSWFPd2FpMGE3aVdoc1FKZ3ZidkpDbzlLMXp0UVpqajVYRVJ1?=
 =?utf-8?B?VUtFYUdhZ0JFczB4b25XaHhhc2cvR3FiU1MzT09yZDRFSkZHTWYrM1cxNXo0?=
 =?utf-8?B?VGd4c3lLSDRTdmVvTUg3a0lBbzNtSjY1QytTM1Q2aDd3YU1jZ2E3ZnViUVEr?=
 =?utf-8?B?a0xRbkYxUDBrSWx2S3hZLzlhZlVXUVBqRTFYVFByYlF3ZnM0MDV6a1MrK09I?=
 =?utf-8?B?aXc0TWRsNXo2Uy9jN2hrc01xRG5FdkppcENEZkV4SzZkNWhTcFJ3L05hZDdm?=
 =?utf-8?B?Z2g5TTVpNHEweTVIMGhUbCtNT21MdXc3aFRrK3RreUtvYy9YK2ZjVllVcExX?=
 =?utf-8?B?ZldZd3NWbzZiSC9ZN2lZY21aYzhQcHova2lhWkZaRUFqdC9KL05OTFJWRzBr?=
 =?utf-8?B?ZHBjQ2VGZng5aTlZWWR3Rm9tVG5JelIyVzZzSXhzYTRYYzV0QitlTk5jbjJE?=
 =?utf-8?B?VG85dXQvanVkS1A2QnprbDZiYVpHd1ZNTWZ1SmNJbVcxU0swUmhTRWU3R0Ji?=
 =?utf-8?B?Y2dPZTM3bC9QS2FJb21sTTk4MTZrTGZueTFRUWh2b3FmWVdoeDRuaHlVSisy?=
 =?utf-8?B?WDRzdHFEN2czUnFKTkwrRmQvNDRJdEpLQ3IvWlRNWnI0ODloY2ppa1BsbFB6?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B5C685A6802B54BA95F85E4E9AE7109@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5823.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb8b607-2f5a-483c-d75e-08db8892e07b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 20:01:01.5816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTHxCyzC1kDkU9vNRPuoo7Epj9DcOTs7zR06LNDcCkHnbUeLstfW7QvSnXXR0OF1fQ77uQmqGcUvmXAZKHFwtG6uk/ngi1pF7V8/zbiBOuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8550
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA3LTE5IGF0IDIwOjQxICswMjAwLCBOYXJlc2ggU29sYW5raSB3cm90ZToK
PiBGcm9tOiBQYXRyaWNrIFJ1ZG9scGggPHBhdHJpY2sucnVkb2xwaEA5ZWxlbWVudHMuY29tPgo+
IAo+IEFkZCBzdXBwb3J0IHRvIHJlYWQgRFRTIGZvciByZWFkaW5nIEludGVsIFNhcHBoaXJlIFJh
cGlkcyBwbGF0Zm9ybS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBQYXRyaWNrIFJ1ZG9scGggPHBhdHJp
Y2sucnVkb2xwaEA5ZWxlbWVudHMuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE5hcmVzaCBTb2xhbmtp
IDxOYXJlc2guU29sYW5raUA5ZWxlbWVudHMuY29tPgo+IEFja2VkLWJ5OiBHdWVudGVyIFJvZWNr
IDxsaW51eEByb2Vjay11cy5uZXQ+CgpSZXZpZXdlZC1ieTogSXdvbmEgV2luaWFyc2thIDxpd29u
YS53aW5pYXJza2FAaW50ZWwuY29tPgoKVGhhbmtzCi1Jd29uYQoKPiAtLS0KPiBDaGFnbmVzIGlu
IFYzOgo+IC0gVXBkYXRlIEFja2VkLWJ5IGluIGNvbW1pdCBtZXNzYWdlLgo+IENoYW5nZXMgaW4g
VjI6Cj4gLSBSZWZhY3RvcmVkIGZyb20gcHJldmlvdXMgcGF0Y2hzZXQgYXMgc2VwZXJhdGUgcGF0
Y2ggYmFzZWQgb24gc3Vic3lzdGVtLgo+IC0tLQo+IMKgZHJpdmVycy9od21vbi9wZWNpL2NwdXRl
bXAuYyB8IDE4ICsrKysrKysrKysrKysrKysrKwo+IMKgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2Vy
dGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9od21vbi9wZWNpL2NwdXRlbXAuYyBi
L2RyaXZlcnMvaHdtb24vcGVjaS9jcHV0ZW1wLmMKPiBpbmRleCBlNWI2NWEzODI3NzIuLmE4MTJj
MTU5NDhkOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2h3bW9uL3BlY2kvY3B1dGVtcC5jCj4gKysr
IGIvZHJpdmVycy9od21vbi9wZWNpL2NwdXRlbXAuYwo+IEBAIC0zNjMsNiArMzYzLDcgQEAgc3Rh
dGljIGludCBpbml0X2NvcmVfbWFzayhzdHJ1Y3QgcGVjaV9jcHV0ZW1wICpwcml2KQo+IMKgwqDC
oMKgwqDCoMKgwqBzd2l0Y2ggKHBlY2lfZGV2LT5pbmZvLm1vZGVsKSB7Cj4gwqDCoMKgwqDCoMKg
wqDCoGNhc2UgSU5URUxfRkFNNl9JQ0VMQUtFX1g6Cj4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgSU5U
RUxfRkFNNl9JQ0VMQUtFX0Q6Cj4gK8KgwqDCoMKgwqDCoMKgY2FzZSBJTlRFTF9GQU02X1NBUFBI
SVJFUkFQSURTX1g6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSBwZWNp
X2VwX3BjaV9sb2NhbF9yZWFkKHBlY2lfZGV2LCAwLCByZWctPmJ1cywgcmVnLT5kZXYsCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWctPmZ1bmMsIHJlZy0+b2Zmc2V0ICsgNCwK
PiAmZGF0YSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+IEBA
IC01MzEsNiArNTMyLDEzIEBAIHN0YXRpYyBzdHJ1Y3QgcmVzb2x2ZWRfY29yZXNfcmVnIHJlc29s
dmVkX2NvcmVzX3JlZ19pY3ggPQo+IHsKPiDCoMKgwqDCoMKgwqDCoMKgLm9mZnNldCA9IDB4ZDAs
Cj4gwqB9Owo+IMKgCj4gK3N0YXRpYyBzdHJ1Y3QgcmVzb2x2ZWRfY29yZXNfcmVnIHJlc29sdmVk
X2NvcmVzX3JlZ19zcHIgPSB7Cj4gK8KgwqDCoMKgwqDCoMKgLmJ1cyA9IDMxLAo+ICvCoMKgwqDC
oMKgwqDCoC5kZXYgPSAzMCwKPiArwqDCoMKgwqDCoMKgwqAuZnVuYyA9IDYsCj4gK8KgwqDCoMKg
wqDCoMKgLm9mZnNldCA9IDB4ODAsCj4gK307Cj4gKwo+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCBj
cHVfaW5mbyBjcHVfaHN4ID0gewo+IMKgwqDCoMKgwqDCoMKgwqAucmVnwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgPSAmcmVzb2x2ZWRfY29yZXNfcmVnX2hzeCwKPiDCoMKgwqDCoMKgwqDCoMKgLm1p
bl9wZWNpX3JldmlzaW9uID0gMHgzMywKPiBAQCAtNTQ5LDYgKzU1NywxMiBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGNwdV9pbmZvIGNwdV9pY3ggPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoC50aGVybWFs
X21hcmdpbl90b19taWxsaWRlZ3JlZSA9ICZkdHNfdGVuX2RvdF9zaXhfdG9fbWlsbGlkZWdyZWUs
Cj4gwqB9Owo+IMKgCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgY3B1X2luZm8gY3B1X3NwciA9IHsK
PiArwqDCoMKgwqDCoMKgwqAucmVnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPSAmcmVzb2x2ZWRf
Y29yZXNfcmVnX3NwciwKPiArwqDCoMKgwqDCoMKgwqAubWluX3BlY2lfcmV2aXNpb24gPSAweDQw
LAo+ICvCoMKgwqDCoMKgwqDCoC50aGVybWFsX21hcmdpbl90b19taWxsaWRlZ3JlZSA9ICZkdHNf
dGVuX2RvdF9zaXhfdG9fbWlsbGlkZWdyZWUsCj4gK307Cj4gKwo+IMKgc3RhdGljIGNvbnN0IHN0
cnVjdCBhdXhpbGlhcnlfZGV2aWNlX2lkIHBlY2lfY3B1dGVtcF9pZHNbXSA9IHsKPiDCoMKgwqDC
oMKgwqDCoMKgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm5hbWUgPSAicGVj
aV9jcHUuY3B1dGVtcC5oc3giLAo+IEBAIC01NzQsNiArNTg4LDEwIEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgYXV4aWxpYXJ5X2RldmljZV9pZAo+IHBlY2lfY3B1dGVtcF9pZHNbXSA9IHsKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5uYW1lID0gInBlY2lfY3B1LmNwdXRlbXAuaWN4
ZCIsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuZHJpdmVyX2RhdGEgPSAoa2Vy
bmVsX3Vsb25nX3QpJmNwdV9pY3gsCj4gwqDCoMKgwqDCoMKgwqDCoH0sCj4gK8KgwqDCoMKgwqDC
oMKgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAubmFtZSA9ICJwZWNpX2NwdS5j
cHV0ZW1wLnNwciIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5kcml2ZXJfZGF0
YSA9IChrZXJuZWxfdWxvbmdfdCkmY3B1X3NwciwKPiArwqDCoMKgwqDCoMKgwqB9LAo+IMKgwqDC
oMKgwqDCoMKgwqB7IH0KPiDCoH07Cj4gwqBNT0RVTEVfREVWSUNFX1RBQkxFKGF1eGlsaWFyeSwg
cGVjaV9jcHV0ZW1wX2lkcyk7Cgo=
