Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1263878C2DA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjH2K7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjH2K7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:59:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5746DCC5;
        Tue, 29 Aug 2023 03:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693306755; x=1724842755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vM2NIuqWAZh5lDNPxos1Nze3JxTY39QcwbnpDkQYINo=;
  b=C2zIYhxD7nrxpfjpPZPjp6GLPz4NKcCRYD5I7p/XhXeMaZjSZYG59nWS
   h90N/C6HpHm9IOPN+mNTutyC4Z0xk9ZYf2oJLB7k47Bs/Ace9UWL0ccVK
   HJJoukEsGof7QV7IdVpnHeKWtIpvg1dACwEP6X4zfu+H6tEdAG4Opg64S
   hO8vImF7y9GgOvCwWzL8weeZj1szMGSzaN002XV5eBhkx1G3qi//i2IF0
   IW4eLLUWiFNh3sFuTlbrd7fwaJKh4DvKq/dzaE7bqS6EAZsOnuosfs6DY
   olBj4CVZ1F1nnRX3RGcTMdA4Nw+3n9Y+JRQmSCTmI+ekPEaWhAEaK76zm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="374226853"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="374226853"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 03:56:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="1069422013"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="1069422013"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2023 03:56:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 03:56:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 03:56:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 03:56:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJpl+YaOpOWQaOFy7pqkjS5hoj2m/InA4zZ8ioKAEdsm7wG/ZnqH23cbLOm+5MdAJ8xPcbUnChlE3XpDwLIEngSPTiol5O7q2DIqk3UFWFQO4iwg74K8tKP0n2q8kOAYmoYU4/JiTjKk5wfIODYhwRM8rZHruNhbtiLwXR2aAVnEjZV7GWs9c8Qkxag0+Jpu4hmVMcoFCWF3zXTNOOuwJpDJgmd5VGkyPokRtVuGJbAGbfyXEFxerGNiB6ZHrMD3v5VjV8fMKiuzuLq7sCZ/uomlaksmywZFmVxiesz8ZTXSy7OW+DcbheFtojRCo28qIbiTGyJEjJlzF+U1MmXWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vM2NIuqWAZh5lDNPxos1Nze3JxTY39QcwbnpDkQYINo=;
 b=FcBsMFm6b+qP5rfL/1S4Vx2Z2ZdT3CwhbsdjVwRDmDMVf4yyS56glFPVUlX9jIm2Pl9i3SOPpTz+v6UV5w1aYKuEqXktX6kQXzVvhYgHRdm0tBZHbJg7P0iNgGy8S5qTo+NJBQkuwhKlEkq9mB1MQ52JYNZUatFodiDmX1DaS4KsroBSJx/tP6XOlkp9pZ1rAT3PnXJSvPKT7kpgCh4fx6EQSuloE7vsg8H8+JMkKtjgZF7StgQ/3MNgMJ3onhHLpDurQvIJCwZPc+BpoQrfxVG7Sa0QkudLu21T5SPWD1RmhRxSkdamB0n+bJCHFv5QmYdYt1r4OmZUpoWWceALjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY5PR11MB6234.namprd11.prod.outlook.com (2603:10b6:930:25::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 10:55:54 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 10:55:54 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 02/13] selftests/sgx: Produce static-pie executable for
 test enclave
Thread-Topic: [PATCH v4 02/13] selftests/sgx: Produce static-pie executable
 for test enclave
Thread-Index: AQHZ11jQ9ldfcU32ikyVQp1Kjbve57ABIA8A
Date:   Tue, 29 Aug 2023 10:55:54 +0000
Message-ID: <8eeec322fa4c85749c05dcbc570ac385d8ad88b6.camel@intel.com>
References: <20230825133252.9056-1-jo.vanbulck@cs.kuleuven.be>
         <20230825133252.9056-3-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230825133252.9056-3-jo.vanbulck@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CY5PR11MB6234:EE_
x-ms-office365-filtering-correlation-id: 67aa13b2-f362-4a00-ade4-08dba87e8495
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oc2S0ROEr7FYGYBMxG3Fl9kfm4fB9ZBzHSSs18TPX5sgTVY9yjDJMm6Sskywfu52IWvf752Lv0rf5+s2zxGKh/LSjpQmb40nMm2j1S4AVESrN/uF4yLlK6qLUGfByjc6bGbWG0Ah/6fsJG2imEzi5IZtHS8bZNTq29bfuajWlHag8KyWeZU8wYkVxMAv3imohkAos1tJh+SPV47Z9tI7BPTI74a36HDhYmFRv9q/rhrUHSgNuCruO+UkYzbZBdaj1hLY3nhzwtHIEeReczq6i9mTFdeUu+90TejmAXYMN5Sf02lBIr/thBaIt6y+X9+wEcq7KUuxGn3er+bXvGFhJ1zPPPWZyIr8ArStwitK9iJUGcQE4ePiUx2XNjwwFIY9VsaTtW/oAlxXHwh40sPvV1ufrhRa3UuuB5MyoYFqMljrGlic7Dmk1LyUIuiaNfKyqvP5/l4Xqp3Wnm3tKX7dkt7l/r1cw+f2vxzw7B6ztI0R2FQAFScwhLKf4k7ivYRaNjsZDKSP/SdW9WiVLoQ4MKW9uY6/o9tCJCbIdPIiBp+dclQnMtwNIHBvTYIsIUuZAp8JwbSnD5onz+VyP9p5bBng4I8z4YOAdDbDK/+oJSs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(1800799009)(186009)(451199024)(6512007)(71200400001)(6506007)(6486002)(36756003)(86362001)(82960400001)(38100700002)(38070700005)(122000001)(76116006)(83380400001)(2906002)(26005)(966005)(478600001)(110136005)(91956017)(41300700001)(66556008)(66476007)(8936002)(66946007)(8676002)(4326008)(5660300002)(2616005)(66446008)(64756008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHk3bkZBcVB4Qk5lOGphcWwwcm9ybTBJVkMyeEVIaFE3SVRiUm5ZVzFMQ3E3?=
 =?utf-8?B?U0xMaFNtM0ZqekRqbDJURHJad0lCVXNkcjduTE1nNFBOd1ZldlhHV2hnSWpn?=
 =?utf-8?B?SnNJVExKcyt6NWNNcEdlK3B5aWZtanVMSmhRanpiQTBMekx1WTljVHM2NEVB?=
 =?utf-8?B?ZnpBSnJaYjZkcE9WV3JxS01MbmRTWFpIUTJsZzV1YlNkNHFCbWV0VWVha3V6?=
 =?utf-8?B?KzlyU3UreGRqUUxuSnRtU1RrRUwyeVh5T05CTHJxOFJCVUtlakxVemFZSGV6?=
 =?utf-8?B?NGdlMHlITERUbG41TkNkU0NiOFdDalViSW1IV0NoQlhUbVo4allwd3NLK2l0?=
 =?utf-8?B?ZCtYY1NzQXRwQVZOMFI3OGNGWWp1dy9MdDF2Zk5PcHI2dXc1V1kvU0VKN0xo?=
 =?utf-8?B?K0Ira2hXUzE4TG9TT3dvbWVMcUZ3VXZMNHlvSDY0MHJTODBpSHcxNWlRNko0?=
 =?utf-8?B?bUZ2ZlBRV2dhUjlaeTg0VGxaaEJ0U3dxYy8wUkpCVURiU01mVXIweWhMa3Nh?=
 =?utf-8?B?MjRXeUkyVmswM1hVQ2RBSXdMaHFzMEFSc2RNQjBjRHgzRW5uZlpBSU9kZUNR?=
 =?utf-8?B?Z0d0Zkg2ek0vVGl0OGQ2bmlyeWZucjNZSjZEVXZiQzMzcE9ZTHJTaWVka0tv?=
 =?utf-8?B?WXNQOGJhOWQ0OVJocDFvYVp4ZXhnc0tWQlRnZWVlbjZYdSsyT0FMTXcrYXlO?=
 =?utf-8?B?OTFmemFYUTFJME9JUGZsUzdUcy9sVzJaQkQ1U0ZsN293WThnWU1yZW1GYldO?=
 =?utf-8?B?R2NEbG8xbXlTRkMxcW9IYlNQSUs0MjByUFRqMnJsQmJVUjJYTlVJWlhweFBp?=
 =?utf-8?B?Wjc2KzRod0JMOWNBeWYvUXVpZTRFUVdmUHV1aFZJYzc3QUpxVXZ1Zkw3NDZ6?=
 =?utf-8?B?T0pFSytoQUtGYkpmanMzZ1VJOHN2ODlHejRoU1JvYVd6L3lUSnhqdVBjK2VT?=
 =?utf-8?B?MGxYSEVxZ0tWTytCV0NabTJZallWY0Y1cDEzSGh3SHhJRUloOHhUZ2xHK3lF?=
 =?utf-8?B?VFdPVW5pdjFXWGpvMFJJcGhoSklLbGUxOWVrWHpOckQvWGsrUzM0MWhJSG82?=
 =?utf-8?B?aVRjdUt6V2ZXVFkxbitYY1hGSC95YU1tcVNyRmF6VGRqbjlnY0N5RGgwRGls?=
 =?utf-8?B?ZytpSHdxdkVDVzJ1MjJwaTIrTVVib0t1MzMyRk1RSnRIK2ppVzYrUHkxQ2kr?=
 =?utf-8?B?ZFJoYjY0M1FjZ2Y0Wm1XT2paNXcwbGsxY05vV0xHRXFRNmEwS0ZqVDNkcjYz?=
 =?utf-8?B?UWJLS094NGZ6cDN1M2JmTUIrZUJvVXN6bG1PaDRITE5XOXhGekpIR3laUmFH?=
 =?utf-8?B?cXlLSFQveGcyazZmVHIxdE05ejhaNkZoY0pjZWxMNDBNMTJ0RlZybDZtdGJs?=
 =?utf-8?B?a21GUGZJYWQ5YUhyR2l6eUV2Z2h4VFp1ZDczUTdLOXh3aHlZOU9VTVdDRVJX?=
 =?utf-8?B?N2Y4TEdGK0lEUFJQTXVDdU9sVytwZEt1NHdJNHNsLy9ReDhDQ0k0dUtFbTVE?=
 =?utf-8?B?Y2pLV1l2VTBWMmtUOE11b1g3LzBPWWc3dHpKMTZocDViMS9aRXA3QU9kYnBK?=
 =?utf-8?B?QXJUR2VEL2dnVUtzWnRyaGhhNDJvZEVVd08wMFFNQ0IyangxUTFKYjJNUHI3?=
 =?utf-8?B?a2l6akp6azZqRU5YcUFVbHdqa1RrTXErckN1M3ExYkFZa29tQklaZTNERmcz?=
 =?utf-8?B?WkMvdGRwa3BGMTI4QzVtMFpGQ3NEOGtxR00weFI0UTI1bjJPMHBRenVOVzlp?=
 =?utf-8?B?NWZITTBEaVhsb2cvaElIVHpZQTNvcFdBbWJTVmk5Ny9wSFhCUitSTTU5dGEw?=
 =?utf-8?B?dEswYVZiRHVUanQwM2tlNmkvYnVXbzBQN2tPbjVmT0JLN0dIeit3SFA0N0RH?=
 =?utf-8?B?TDBmdm5TaXZGMW5RNTIvTHRwVUZsazhhUXM0VWRLK3ZEMHFGbjdDbnJXMzZW?=
 =?utf-8?B?NjFUdk82dW8xby9SUFFZTjhOZTdCbHJ2RTFXalJrYmNnMytWTmJIYkZmOWdD?=
 =?utf-8?B?cmk4RVRsMmZ5RThJTkNpQTF3bHNFYzUyS2pFMzVYZFlHTElMK2d4QTc2dzho?=
 =?utf-8?B?QVJZb0I5aTFMYTUreWxCem9hRnI4YXJjNHdtRDFDdXM0WjVPc3hVTElWV1Fq?=
 =?utf-8?Q?JtX5Tz1QfcrYGHK3X/uhtG078?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4F48F914628A54796A84EFBD35B90BA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67aa13b2-f362-4a00-ade4-08dba87e8495
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 10:55:54.6767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K4C4OXUG1btaJsOBcILB+G4FI9kRmWMHM4Dm3N6ks0u+t60foO5QB6MoR9E39JMnw28zeQSl+YAZ6gJapLTpew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6234
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA4LTI1IGF0IDE1OjMyICswMjAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IFRoZSBjdXJyZW50IGNvbWJpbmF0aW9uIG9mIC1zdGF0aWMgYW5kIC1mUElDIGNyZWF0ZXMgYSBz
dGF0aWMgZXhlY3V0YWJsZQ0KPiB3aXRoIHBvc2l0aW9uLWRlcGVuZGVudCBhZGRyZXNzZXMgZm9y
IGdsb2JhbCB2YXJpYWJsZXMuIFVzZSAtc3RhdGljLXBpZQ0KPiBhbmQgLWZQSUUgdG8gY3JlYXRl
IGEgcHJvcGVyIHN0YXRpYyBwb3NpdGlvbiBpbmRlcGVuZGVudCBleGVjdXRhYmxlIHRoYXQNCj4g
Y2FuIGJlIGxvYWRlZCBhdCBhbnkgYWRkcmVzcyB3aXRob3V0IGEgZHluYW1pYyBsaW5rZXIuDQo+
IA0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvZjljMjRkODktZWQ3Mi03ZDll
LWM2NTAtMDUwZDcyMmM2YjA0QGNzLmt1bGV1dmVuLmJlLw0KPiBTaWduZWQtb2ZmLWJ5OiBKbyBW
YW4gQnVsY2sgPGpvLnZhbmJ1bGNrQGNzLmt1bGV1dmVuLmJlPg0KPiBSZXZpZXdlZC1ieTogSmFy
a2tvIFNha2tpbmVuIDxqYXJra29Aa2VybmVsLm9yZz4NCj4gLS0tDQo+ICB0b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9zZ3gvTWFrZWZpbGUgICAgICAgICAgICAgIHwgMiArLQ0KPiAgdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbC5sZHMgICAgICAgICB8IDEgKw0KPiAgdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbF9ib290c3RyYXAuUyB8IDkgKysrKysrLS0t
DQo+ICAzIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvTWFrZWZpbGUgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvTWFrZWZpbGUNCj4gaW5kZXggNTBhYWI2YjU3ZGEz
Li4xZDYzMTVhMmU1ZjUgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Nn
eC9NYWtlZmlsZQ0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvTWFrZWZpbGUN
Cj4gQEAgLTEzLDcgKzEzLDcgQEAgZW5kaWYNCj4gIA0KPiAgSU5DTFVERVMgOj0gLUkkKHRvcF9z
cmNkaXIpL3Rvb2xzL2luY2x1ZGUNCj4gIEhPU1RfQ0ZMQUdTIDo9IC1XYWxsIC1XZXJyb3IgLWcg
JChJTkNMVURFUykgLWZQSUMgLXogbm9leGVjc3RhY2sNCj4gLUVOQ0xfQ0ZMQUdTIDo9IC1XYWxs
IC1XZXJyb3IgLXN0YXRpYyAtbm9zdGRsaWIgLW5vc3RhcnRmaWxlcyAtZlBJQyBcDQo+ICtFTkNM
X0NGTEFHUyA6PSAtV2FsbCAtV2Vycm9yIC1zdGF0aWMtcGllIC1ub3N0ZGxpYiAtbm9zdGFydGZp
bGVzIC1mUElFIFwNCj4gIAkgICAgICAgLWZuby1zdGFjay1wcm90ZWN0b3IgLW1yZHJuZCAkKElO
Q0xVREVTKQ0KPiAgDQo+ICBURVNUX0NVU1RPTV9QUk9HUyA6PSAkKE9VVFBVVCkvdGVzdF9zZ3gN
Cj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wubGRz
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbC5sZHMNCj4gaW5kZXggYTFl
YzY0ZjdkOTFmLi42MmQzNzE2MGY1OWIgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3NneC90ZXN0X2VuY2wubGRzDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3NneC90ZXN0X2VuY2wubGRzDQo+IEBAIC0xMCw2ICsxMCw3IEBAIFBIRFJTDQo+ICBTRUNUSU9O
Uw0KPiAgew0KPiAgCS4gPSAwOw0KPiArICAgICAgICBfX2VuY2xfYmFzZSA9IC47DQo+ICAJLnRj
cyA6IHsNCj4gIAkJKigudGNzKikNCj4gIAl9IDogdGNzDQo+IGRpZmYgLS1naXQgYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsX2Jvb3RzdHJhcC5TIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbF9ib290c3RyYXAuUw0KPiBpbmRleCAwM2FlMGY1N2Uy
OWQuLjRlNTVkOTE1NjZjNCAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
c2d4L3Rlc3RfZW5jbF9ib290c3RyYXAuUw0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9zZ3gvdGVzdF9lbmNsX2Jvb3RzdHJhcC5TDQo+IEBAIC00Miw5ICs0MiwxMiBAQA0KPiAgZW5j
bF9lbnRyeToNCj4gIAkjIFJCWCBjb250YWlucyB0aGUgYmFzZSBhZGRyZXNzIGZvciBUQ1MsIHdo
aWNoIGlzIHRoZSBmaXJzdCBhZGRyZXNzDQo+ICAJIyBpbnNpZGUgdGhlIGVuY2xhdmUgZm9yIFRD
UyAjMSBhbmQgb25lIHBhZ2UgaW50byB0aGUgZW5jbGF2ZSBmb3INCj4gLQkjIFRDUyAjMi4gQnkg
YWRkaW5nIHRoZSB2YWx1ZSBvZiBlbmNsX3N0YWNrIHRvIGl0LCB3ZSBnZXQNCj4gLQkjIHRoZSBh
YnNvbHV0ZSBhZGRyZXNzIGZvciB0aGUgc3RhY2suDQo+IC0JbGVhCShlbmNsX3N0YWNrKSglcmJ4
KSwgJXJheA0KPiArCSMgVENTICMyLiBGaXJzdCBtYWtlIGl0IHJlbGF0aXZlIGJ5IHN1YnN0cmFj
dGluZyBfX2VuY2xfYmFzZSBhbmQNCj4gKwkjIHRoZW4gYWRkIHRoZSBhZGRyZXNzIG9mIGVuY2xf
c3RhY2sgdG8gZ2V0IHRoZSBhZGRyZXNzIGZvciB0aGUgc3RhY2suDQo+ICsJbGVhIF9fZW5jbF9i
YXNlKCVyaXApLCAlcmF4DQo+ICsJc3ViICVyYXgsICVyYngNCj4gKwlsZWEgZW5jbF9zdGFjaygl
cmlwKSwgJXJheA0KPiArCWFkZCAlcmJ4LCAlcmF4DQoNCkNvdWxkIHlvdSBwbGVhc2UgYWRkIHRo
ZSBsaW5rZXIgZXJyb3IgKGFzIHlvdSBtZW50aW9uZWQgaW4gdGhlIHYzKSB0byB0aGUNCmNoYW5n
ZWxvZyB0byBqdXN0aWZ5IHRoaXMgY29kZSBjaGFuZ2U/DQoNCkFuZCBzaWdoLi4gSSBzdGlsbCBk
b24ndCBxdWl0ZSB1bmRlcnN0YW5kIHdoeSBsaW5rZXIgY29tcGxhaW5zDQoNCglsZWEJKGVuY2xf
c3RhY2spKCVyYngpLCAlcmF4DQoNCmJlY2F1c2UgLi4uLg0KDQo+ICAJam1wIGVuY2xfZW50cnlf
Y29yZQ0KPiAgZW5jbF9keW5fZW50cnk6DQo+ICAJIyBFbnRyeSBwb2ludCBmb3IgZHluYW1pY2Fs
bHkgY3JlYXRlZCBUQ1MgcGFnZSBleHBlY3RlZCB0byBmb2xsb3cNCg0Kd2UgaGF2ZSBhIA0KDQoJ
bGVhIC0xKCVyYngpLCAlcmF4DQoNCnJpZ2h0IGhlcmUuDQoNCkNhbid0IHRoZSBjb21waWxlci9s
aW5rZXIganVzdCB0cmVhdCBpdCBhcyBhbiBpbW1lZGlhdGUganVzdCBsaWtlIC0xPyAgOi0oDQoN
CkFueXdheSwgSSBsaWtlIHRoaXMgY29kZSBjaGFuZ2U6DQoNCkFja2VkLWJ5OiBLYWkgSHVhbmcg
PGthaS5odWFuZ0BpbnRlbC5jb20+DQoNCg==
