Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B61876DF3E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 06:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjHCEB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 00:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjHCEA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 00:00:59 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1310B2D69;
        Wed,  2 Aug 2023 21:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691035258; x=1722571258;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T6mah4laGiEH0Zy6EYZqYIocbkcmRhdBRGwD6nARZ7k=;
  b=WYjx6gg3O38J50er6/Von5gs+LAhAKzrmNKlYyYtzKV6BXZxey+p+s+P
   6ZkSLQnA/UwSTuGjo6rt/10BrYb2to8ZjQI2todGF0be9a4/Fs+Ai6pjw
   CZDr45afCOu9NtI8mG/jyV8afbEYvpQAAfe2JZ5xPqIrQNS56SA08lrG+
   uGP6yNlETEWS5Yj1E4lTs4s1AGwxd2lqMp7Swnsm8pLJEKj9o7jQHGvBc
   lQHotV07BBtkEFRywSlZQqQym2h5vT8aevfjoawks2sajTmyYDMVU4Ibe
   NvQEp+KtTAxj7eyoJS9LRiWR7emmZZKB4dySjW2tP9+FKdstH7KV2DFBB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="368662825"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="368662825"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 21:00:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="706393997"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="706393997"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 02 Aug 2023 21:00:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 21:00:56 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 21:00:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 21:00:56 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 21:00:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRocrT9wWQ2BoDaIkl9xPLlasA52V6n4NokZfbaggjj0s0sinmruGCJj31UNlC3BcfrrjjH8cxc8Vy7NQ9mYba+sCZ7mS45AIuPmVRdcaEDt87htfNp9MngdSRO8eF4Od17kSW7xBFvZepl2s3duEpAu3hkhH5uGGNBMVLT8qJX1/sWFxEV2DRV9n0CHLUAfAYBs3n1pqn2ujQGRhLaFooK3vfb80xL3ysFkpwML/U1FWcwzIe6BQ355kjDKajcudLud9HBlOTW4FD7Bq655mOpOStY4Z81dHlkb5KNE8NQlNCr7p2pj5D2Z8tPM3+YSN48NmZovt53Dm/+XlKoeug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6mah4laGiEH0Zy6EYZqYIocbkcmRhdBRGwD6nARZ7k=;
 b=Uqf3Sg+PjoU91jrzbn0WDIA7EwVPd5uYo3XYUz18lU424oxkFcMOlqjLV+EPEkinLWnI8A+d0EmzyCWDCXndILptzUJ6k2lGIs1Unjo5a4fA9izLnWit8hsZS2wzZ+CgGQHkFfng+yMt5FAdwKOwbY3TqR+QSYpu9vtS3SOfRNMLRthXV2pZH07X/blaX1nrJxFR9CAKJPWoFRSvYK5G6MTJWTZxHHt4qU0VmS53kwgH7r4f+4asyBfd5GB+NQLPCW2rR/LPJRFtm9lE9zphYZvZwA6I3viqqEoNWoWdHobQK7i6+cPUtsUMRcWJZl2289D7kAKw7Zzt0F+SDFG64w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB6699.namprd11.prod.outlook.com (2603:10b6:510:1ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 04:00:54 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 04:00:54 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 3/5] selftests/sgx: Ensure correct secinfo struct
 alignment in test enclave.
Thread-Topic: [PATCH 3/5] selftests/sgx: Ensure correct secinfo struct
 alignment in test enclave.
Thread-Index: AQHZvlAufQuNdeWWjUOlxEJX4LmJ5a/YAY6A
Date:   Thu, 3 Aug 2023 04:00:54 +0000
Message-ID: <4f4c7b98a707a7d5916d8e62681cc1a4b772dde4.camel@intel.com>
References: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
         <20230724165832.15797-4-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230724165832.15797-4-jo.vanbulck@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB6699:EE_
x-ms-office365-filtering-correlation-id: a693ec45-67a3-4610-c317-08db93d63bfb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QWV/MrMG7JN+I8R/NylGNKpcI2f7rZ/Knst5+ckCeuKZql4pkjbQdRTSDQ4HUPezUwnnriwOsXCT6akn5u6S8aTocstt397rRMlEnxndVeFpMD4k1/h15eLnpzVd2k6XA8WiHv82SCHH3EyPulQSrepjySS256yq6FaRZ+ghBUPvByoDf5qQZmtxC8DuevdYIHLBEzMDb6v6W7q1oKWmMukyXSGR7u1Lvl+Qnpbn8uSwnRPTO1suujoUt5S8wPJvQ7uu7iyFhaLCXCxlhgJ9gYNiCuGKoT1q5K9+XsPMcqAe9guLORg/fpiCbqThwuwy3QoIv07CF/zVs8ecENa0IZ4uFBKHRyZ8SdMb6T6LsbTKLM26FpSlsG4PYVBwouAmsgDhpCEP5ZvbLuYEIpu72loYgs+HCGIY6PZigjmpV4+CYWIz38O/gPWfz95laf3vUmOStYqaKTkeT7ElMJJPU7NMuj8DmfrmYfzUp8yWNjrT+kdXdrxATDe+Hy9B84Id+PgN/eLFKWS05Tg8u2lItnKCMMVpDaNLOsVJW6m092AVjcJyPp6rZqlSowiptBMkVzL8ikYzRfFKEZ5/UrJ3TmQmQjLYBlX0DKECHNoe+HIRJUIecH5D2qYu/O/iMyWa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66946007)(64756008)(86362001)(66446008)(66476007)(66556008)(6486002)(71200400001)(91956017)(76116006)(6512007)(2906002)(4326008)(110136005)(36756003)(478600001)(83380400001)(38100700002)(41300700001)(122000001)(2616005)(82960400001)(5660300002)(8676002)(8936002)(26005)(38070700005)(6506007)(186003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEdHRTJ1Y1lOTXpoWnhhYXV4Tm0zRnFpWkpRa3c5bGJZbnV0SkhpUDV3WmVl?=
 =?utf-8?B?RmFBOVBsNzk2N1ZRc1dpdVM2UHp4R0RJdmlTUE12U3QwNDRpblFDTFRPQkFQ?=
 =?utf-8?B?QXJ4cWZROVB0MXBEQzVBa0FXTkVJeTBqR1RKM00wOERTSWovZG45NXU5ekRm?=
 =?utf-8?B?bVlzdGJCcy8rTVVHak5DZkUzblZEVlhGWGpGdnlwMGk0TFplQ3VHZWtLSjZp?=
 =?utf-8?B?TUdFWWZaMkxSWWd0WmgwbEN3eE5GaFRQNjVMRWUxRzBtMkVDd1NHcEJhWVdt?=
 =?utf-8?B?d2Eyc25NdG1KcDJZVmtNM3pHM2RDYVJsVUdoelgyTER5L3E3cyt4Nk9VL2ht?=
 =?utf-8?B?Qzl0MVlZT1VtMjNuTXRYd2ZYTTR4Q2J1K1lGQ3VrRVp3eVJXS2p2eXNkYmdw?=
 =?utf-8?B?MUlMekhHdEprMlF4bHpvSXgwZzdwVW0zSGhBaVJyRjNyc0ZvY2xWWHJLZ0tL?=
 =?utf-8?B?ZUlkR3F1S2tBcEJMdjk0Q2hnc3JmSVBpM1hxSWRieldOSEl6amlMaVRXdThV?=
 =?utf-8?B?U0tRcWJHdGxHQXhOVGtYaXJMR3BQbnc2K21vT3ZjUVdrNHVLNHYrUDVSVnJu?=
 =?utf-8?B?UWVkdVZadTk2U2ZqRklWTkVhdjdySVhuWm9LTzJyNDB0dmxOSHFJUlR1dE93?=
 =?utf-8?B?WGJ4Z2lFcnUzOU9IcUpwN08yRG9UdVhLV2Z4MVF0VTZSSHhxd3ZmWWhyYmtN?=
 =?utf-8?B?TVpLSlJneXcvOE95Zkl2ZG8rV0FwYmRPL0RlTnNacXpXem5qcDlsZ0NmMUpC?=
 =?utf-8?B?aFFETS9pL1BVTkU5MEFuZm12MEJnNzFSZkQxYlNWekkrTnFKeXZ1eFNkTHQr?=
 =?utf-8?B?dWMvYVAyK29Sb29ldHQ3TmJPTDN1QlJoRnR1NGlidm9UVUhreGI4RVJiUkVB?=
 =?utf-8?B?aURRQTdKUkg0clYwQ2RSUDJTeVYrc1lXT2ZGWC9HK1VrWUZDYzBrb1RFbkk1?=
 =?utf-8?B?bFV2ZU9GSTRHREc1bmM3bGhOR056UTFxaUgrNzArOFdZejRBODJZQy9kRk56?=
 =?utf-8?B?dlNITUk4QWVaWUJhcG8xdjJGMjR5MnYvd2lIcDROY2dZMW5jSHZiUU81TUdV?=
 =?utf-8?B?NVNHS0lOZVJOUmhOTEhvYklMcHpZMHFZcVpoN0RLRU1vSStJZGwvZm1Fb014?=
 =?utf-8?B?TWNZRVBTcldPRnBWT2IrN0xHRk5qUlY1czFja0hHNzRJTUtGNTdQZkdidzdx?=
 =?utf-8?B?UkxqblI5aThGN2xyZmtHMjJMSUhrcGdsRStmYWlpbWNmVmp4Q0xTTmxrbGpX?=
 =?utf-8?B?aEtJK0pxSXVLMlA5OGZSdVJXcFBzUzhhbmtjZDBwenl6bVNKcTErOU1tZGxz?=
 =?utf-8?B?VC9tY01wVll6bncwQVFEZUhPc0hIUTROUTc4RFpPVENZeTd4T0hDTmljbzdM?=
 =?utf-8?B?emZhbVVBc3JIdkk0eGVnRloyQ0JMT2JIWGhHQnZRR3BVRXhYNWVEbDZhOUZo?=
 =?utf-8?B?NE5HQmtvK08rWHh4R2hkYlo1OWprQ1dneVRoVXZoUFFHeVBURmtVRHZkaDdK?=
 =?utf-8?B?aFp3VitrQ3dqMDFkYnRUTEZNYWtOS1Y2dkV2d3EzS2N4RWJ0WDZKWjlzWVJH?=
 =?utf-8?B?cnhGU3BDeGRmQ2MvSUJUVFVISW4wUTBOOUY5N1ZaM0NVMVNVYWx5T0J0UXBy?=
 =?utf-8?B?RUxOeGdLSVZ4ME4rZm9QdnVrM1M3cXk5V0NoQldXbWlBSDVCV3Q0ZnJveFJi?=
 =?utf-8?B?Y2oxYzNyTUFSVlgvM1VwT3hFeE5NaFkvdG0wMncyMUdUQjdDYk1ETDdKbFo1?=
 =?utf-8?B?dkQyc2F3M0QwTGdPQmE3K2FRYU5Pc3NsdndNTzJpL3duMG5nY1ByMWN3YlRl?=
 =?utf-8?B?OVlrejFHVGo4dkUrUTdQVHlicTkwbDR4alRkRmN5VnZuaWNnN3FqUTJOMlpl?=
 =?utf-8?B?UU54OFI4QytPa3NmODVYa0E0YmtLYlRtN2RUY09vT2tvVS9DalRvTmsxSjhR?=
 =?utf-8?B?WUZZNEJ3STE5TVo5VU13TnF2dTlvQ3VUUE5kam9JR3VsZjRGQUt2RFUxY25v?=
 =?utf-8?B?QkVvOHU1MmhlU2hzRDF0OGlHc1hUMmM2SFZMblB5MzdEcFc4K3BJa2lwMmN4?=
 =?utf-8?B?OEJXRkZpK0dQY085eGZqYytGUHJWT2kxSWVCV2sxTXVJTUd6YW5GMmMycDZC?=
 =?utf-8?Q?PY0nPmc5IcfCJcatEqTDF9R2Q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <115E9541777FFD4CB3048C021D7C7452@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a693ec45-67a3-4610-c317-08db93d63bfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 04:00:54.1567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAvONi1slLRYBZwBVqLzDruZby2Gaj0opArrHOeRFIikg697xR02707n22pJFVvIj2dZmEwTqxZI8+cHKbKf0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6699
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

T24gTW9uLCAyMDIzLTA3LTI0IGF0IDE4OjU4ICswMjAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IERlY2xhcmUgdGhlIHNlY2luZm8gc3RydWN0IGFzIHZvbGF0aWxlIHRvIHByZXZlbnQgY29tcGls
ZXIgb3B0aW1pemF0aW9ucw0KPiBmcm9tIHBhc3NpbmcgYW4gdW5hbGlnbmVkIHBvaW50ZXIgdG8g
RU5DTFUuDQoNCldlIGFscmVhZHkgaGF2ZSBfX2FsaWduZWQuICBDYW4geW91IHByb3ZpZGUgbW9y
ZSBpbmZvcm1hdGlvbiBpbiB3aGF0DQpjaXJjdW1zdGFuY2VzIHRoYXQgX19hbGlnbmVkIGlzbid0
IGVub3VnaCB0byBndWFyYW50ZWUgdGhlIGFsaWdubWVudD8NCg0KV2UgaGF2ZSBhIGxvdCBvZiBr
ZXJuZWwgY29kZSB3aGljaCBoYXMgX19hbGlnbmVkIGJ1dCBkb2Vzbid0IGhhdmUgdm9sYXRpbGUu
DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvIFZhbiBCdWxjayA8am8udmFuYnVsY2tAY3Mua3Vs
ZXV2ZW4uYmU+DQo+IC0tLQ0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5j
bC5jIHwgNiArKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4
L3Rlc3RfZW5jbC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbC5jDQo+
IGluZGV4IDRlMzFhNmMzZDY3My4uYWJhMzAxYWJlZmI4IDEwMDY0NA0KPiAtLS0gYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsLmMNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbC5jDQo+IEBAIC0xOCw3ICsxOCw4IEBAIGVudW0gc2d4X2Vu
Y2x1X2Z1bmN0aW9uIHsNCj4gIA0KPiAgc3RhdGljIHZvaWQgZG9fZW5jbF9lbW9kcGUodm9pZCAq
X29wKQ0KPiAgew0KPiAtCXN0cnVjdCBzZ3hfc2VjaW5mbyBzZWNpbmZvIF9fYWxpZ25lZChzaXpl
b2Yoc3RydWN0IHNneF9zZWNpbmZvKSkgPSB7MH07DQo+ICsJLyogZGVjbGFyZSBzZWNpbmZvIHZv
bGF0aWxlIHRvIHByZXNlcnZlIGFsaWdubWVudCAqLw0KPiArCXZvbGF0aWxlIHN0cnVjdCBzZ3hf
c2VjaW5mbyBzZWNpbmZvIF9fYWxpZ25lZChzaXplb2Yoc3RydWN0IHNneF9zZWNpbmZvKSkgPSB7
MH07DQo+ICAJc3RydWN0IGVuY2xfb3BfZW1vZHBlICpvcCA9IF9vcDsNCj4gIA0KPiAgCXNlY2lu
Zm8uZmxhZ3MgPSBvcC0+ZmxhZ3M7DQo+IEBAIC0zMiw3ICszMyw4IEBAIHN0YXRpYyB2b2lkIGRv
X2VuY2xfZW1vZHBlKHZvaWQgKl9vcCkNCj4gIA0KPiAgc3RhdGljIHZvaWQgZG9fZW5jbF9lYWNj
ZXB0KHZvaWQgKl9vcCkNCj4gIHsNCj4gLQlzdHJ1Y3Qgc2d4X3NlY2luZm8gc2VjaW5mbyBfX2Fs
aWduZWQoc2l6ZW9mKHN0cnVjdCBzZ3hfc2VjaW5mbykpID0gezB9Ow0KPiArCS8qIGRlY2xhcmUg
c2VjaW5mbyB2b2xhdGlsZSB0byBwcmVzZXJ2ZSBhbGlnbm1lbnQgKi8NCj4gKwl2b2xhdGlsZSBz
dHJ1Y3Qgc2d4X3NlY2luZm8gc2VjaW5mbyBfX2FsaWduZWQoc2l6ZW9mKHN0cnVjdCBzZ3hfc2Vj
aW5mbykpID0gezB9Ow0KPiAgCXN0cnVjdCBlbmNsX29wX2VhY2NlcHQgKm9wID0gX29wOw0KPiAg
CWludCByYXg7DQo+ICANCg0K
