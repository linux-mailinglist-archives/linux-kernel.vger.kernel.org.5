Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C80C81074A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378090AbjLMBHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbjLMBH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:07:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE3ECF;
        Tue, 12 Dec 2023 17:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702429655; x=1733965655;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dJq1e46TL53O74OaEN+GDsa7oGGdAb5z6tg7yx/Bj24=;
  b=BpYIYm6mJYGPBqGfAo/vhUiDRa45sBnOOBBgfecgJyHe+ia7doHe9dMa
   gACYrZTHvXFa/eTM+nkvJWgTtjbZ7ANV7lH+9lujVJEM/lE7E2gTTpaSZ
   sx3I/lB2eA59kXcDxlNKlr7656Ib9/3qj/6GpEdB0Uyxs5fT3VimNQb4k
   /CsdX3Xq7X+EAUMVsFBtsHDVKsuTgfhVezfo9oMjlrCKBn+VD3+sl3snU
   3AxEoluGtKQ35O9PVxwEvb3YAFer+bWjqE0z9tP0sT4dgvpWLLKX90IpW
   KMZZmPSMqaIxlYYO1ccSu4IgcI6VowRP0Xmh5uLmsDYfAAuxqwwK3Dqz6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="385313831"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="385313831"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 17:07:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="767018742"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="767018742"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 17:07:17 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 17:07:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 17:07:15 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 17:07:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2eC1hC9RVKhrvf/wdnIXzYl77dw3E5gL3kCb3F3YRZ4JP5Q3vybFt+e/5bMsgXilErFZSR+PzhSdm29ZaZkMU+nokIN1tzDCWE6J+oQOeHX3lxkZV1R20B1hPAH39r7V+l96wyAzwAAqiT5DiUzol+eLe+KVORVfnxqda2qBu86Rd1QL9JIvXmvIZvqH9837jHvgY2lBnpmgB21h7k1ySp9r61FM+cTQZZ6ZZoLuRS7qe83orjlI4OV75AN2q66kE9QKQHdngiQxeF+0RfOoVogKvQ4UR3mtvxx3/0jvfXu6DzU9UrgF9Pqkmp+GjtRXXxYT2mAI+jf2yHa0t1vdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJq1e46TL53O74OaEN+GDsa7oGGdAb5z6tg7yx/Bj24=;
 b=V6qnLIo47XcIYZQh42YOH+JjfnZgcWBIsqyMSOyWTwPhB5559/OiFId+23sgGsjXIGssmoL2+rCA+VzqjAL0XsqYd7K0Vs07dADuZb958NvTlVthrxVo3BRuJ5xPNRIb70Xu1uij9mufCwzfq1w4JYerHG7H4sQNgJ+OwfMW1gGzDcGnlLDLWUb/YS2LJ5z9QPpF5Ep7FvLUqMkylh/Db7/fwIYpuLElxD/x7rbraUaio5cVASLLOSVzKrcM8i0roCOlgCX4iv3wQVaCtDb/Ni1lptHTUG1ZMvS3T0jmpzeYnVz9dcH0PDakpFN0okKH9Mwqd58ca5IGaJB50ziHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW5PR11MB5859.namprd11.prod.outlook.com (2603:10b6:303:19e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.36; Wed, 13 Dec
 2023 01:07:13 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%6]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 01:07:13 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>
CC:     Peter Newman <peternewman@google.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v6 1/3] x86/resctrl: Add mount option "mba_MBps_event"
Thread-Topic: [PATCH v6 1/3] x86/resctrl: Add mount option "mba_MBps_event"
Thread-Index: AQHaKUd4vbZ9pzma9keuObpvNWgZXLCfsvMAgABDQMqABf/KAIAAP8kygAA3C8A=
Date:   Wed, 13 Dec 2023 01:07:13 +0000
Message-ID: <SJ1PR11MB6083DA80600EC76FDBCECF79FC8DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20231207195613.153980-1-tony.luck@intel.com>
 <20231207195613.153980-2-tony.luck@intel.com>
 <CALPaoCji1yzfkA=tms3LhYMvRB+wSJQM3qzPKrHNEa7a+KduTA@mail.gmail.com>
 <ZXORTTIUKWXOsd9p@agluck-desk3>
 <CALPaoCj_OvMzD8W9+jEORewwDquM6F-sOW32Ngcy+Gm6A1+OcQ@mail.gmail.com>
 <2377bfb8-00bc-4863-8d70-425cb70c9c0b@intel.com>
 <ZXi8Rj3znA6lmjE9@agluck-desk3>
 <5215fe1e-52e1-4ca4-8bd2-a42152f3e0e3@intel.com>
In-Reply-To: <5215fe1e-52e1-4ca4-8bd2-a42152f3e0e3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW5PR11MB5859:EE_
x-ms-office365-filtering-correlation-id: 9b43f396-8aa4-4b32-99a6-08dbfb77d759
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eX+6s/dhgelbeH0UwpUM01CWggCxE1gpY5B1DuD+6SBy10heU8WcZVojkRCgs6qKzKtyQyZT2kX0f/Y4OpEYq3ssP4RF94GhSAjDDcqTnXeYAIo92vwO360tLaj13945FCL6lURxe4D9bZ9tSopbpmorAj/5aftOEFsbo42fgVnGz8EyOIF/i05hiPyXq5x+I8Br60XQ82H2kg/jrtMpuSfGRBzgOUWkM/M4aRvOTv/RCMsUB8S3bUoPg0Hgu0jlUFm/TuJCyVuNkmVuoZucAWb5I04wyzrEeX6Qoknxas5+M1R7T/QPBJS9EieLonVz2V8QevGKq463h7gXfuRTQ0FNFJJryC8/Dkl9q5rOTjm4Ci4fnEkH8rAr+VMnKdzX0a3ecwncuzsqvwJVokxXPVB0XoJKLGgvhx8TRRlM5qDETpRflz+f8iTMHBYTuctP2F6SEqMXWlmTnvRwg/Tbb9SjpVPEE4M/y4FX3EGKnClLtN2VrCZmNCkbq5HXSSrn+WvLMH0E0eL+gKf1ABcmrqoHPvS21r49DjX1fl7Q1NzfMSPDFQ8SHWXfrQu5t1gmP4V542lu3/YTMjKx7nqEGE16iXtBleh3mqUXf5JqqkRYyHl5qnwyjlvua3+ewzQg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(41300700001)(6636002)(2906002)(4744005)(8676002)(8936002)(38070700009)(316002)(5660300002)(7416002)(4326008)(52536014)(6862004)(82960400001)(9686003)(7696005)(6506007)(71200400001)(478600001)(86362001)(54906003)(64756008)(33656002)(66946007)(66476007)(66446008)(66556008)(38100700002)(76116006)(122000001)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3Q0ZXFQRHhIRVpDclFSTHJHRU1NOTJaU2cyMkZ2eU1wTTkxNW9pUzB6VDhy?=
 =?utf-8?B?clVISDFDZlB0Nm9IbnFVWUdWNmVTMlZ1TkZUMVJkcGlzdEtWYytzRXFkUm9W?=
 =?utf-8?B?ZmJXS2VzdnIwNW1YWVNxNkZuWk9xUXBUWENleTdNWG9GaWpqOGlDWUg3U1V6?=
 =?utf-8?B?NFR1aXJrK3c0RC9NdEZnVDk4eFdCSjc3eDQ1c3RKYXh0SVFMYmhtY1JnNjdw?=
 =?utf-8?B?K2k5L25vaWtLa1g2aVdVcHhGemVHZk9NMkRKMkJPU3diUXEzUFRRM3J4UTdQ?=
 =?utf-8?B?Um82VDc5SU00dFcrY0hJSEVqY3c5OG1yVG9vaE53azFKMU5BMGwyazgvY2dx?=
 =?utf-8?B?QkY3YzEvVlgyYnU3U0JyNEZvSDAxczh3VXJoVkY4T2Y2bGVRYlBqc0Y2SCtj?=
 =?utf-8?B?UnBsN2ZQd1pZLzJSREFkNFdLeDhSdDA1QlpCbWIvMmdRSFhsb2dERDZwUnZP?=
 =?utf-8?B?Vi9xamsvVXJDdXdOenVvQVhNaFZCSTk1ZHU2blJSTXMyMEtNVmxJa1BjTDV1?=
 =?utf-8?B?QzV0amd1SlJjTkdrd2doWHZPWjE1ZkJXZHcxZE5acHFieXhlYVBiUk1YQStv?=
 =?utf-8?B?VUJKRkFLNTlETzBSVTQvU09Ha2NVdDBESGZDTkUybHVwYktic24xcTQyY1R0?=
 =?utf-8?B?NHRMdFR0K1BTdmNrSlBhUmdLcDZEbE1qbjZGSFVZRmJLeGVYTnlma2VKS01S?=
 =?utf-8?B?ZjZDM1J5aS8wdFQxdkVTU2VoUVFoZWFEa2ZHTVNoMHZ1cWpSN2VUWFFOazdE?=
 =?utf-8?B?b2hwdEp2YUdJZXRxdE5ma0JBOUJqV05EWnRpWUhqZ25oTm1rYnErbTF6UTVt?=
 =?utf-8?B?UjVMQ0xYODROcjFmR0Zyc0NSU3NhWGFJL1RzRVN3d1R4N3k2WG1FUGhwTFNv?=
 =?utf-8?B?emdLVjZQb1R5dWNaWUlXczBnM1ptcllkYk1JNnZUeTFiR3Vrdm1IMXhlZFlL?=
 =?utf-8?B?emtRaGZ4SFdNdndrTzVUWUFaK0FZRnEwcUdIZ1k0aEptd3lUb2dPUm0wdEln?=
 =?utf-8?B?NURRTjNGWE9sdGpDaVY2bVUwNTBoYkpmZ0R6S0FSRVZVNGtpd0JZc3ZpUlFD?=
 =?utf-8?B?UnNDS0VFWTZ2QzV0QkNpZmN1QzVaSFZDdk1Xanpzc2w1QUEzZUZjamFYWUNq?=
 =?utf-8?B?MWN1OU9rdmMzOGJTNVlJd2JqYlAvcWtFaWkzcmhqa05FSDdpZGxaMXo1VnVR?=
 =?utf-8?B?UDFoTWxKZlRpSDFRTXJndTZNcm1HTmdhekxGOXRlMUlmUlVPdGJuQ09QMWlM?=
 =?utf-8?B?S1BMOTZYdFBPeUhpWmVKNVN1M2QwdmdmSyszbEJkVHEyYzNQM0RYZFQ4TEUr?=
 =?utf-8?B?OU11TEFtMmpTaGNJYnJleDg1Ni9vTVpNNzM3TWtxNFdTS3h4Vm9HdkVUWHdO?=
 =?utf-8?B?K1haT1RIMXUybmREMmMydU5kUUtJbHB5MlFJNjdxcVdwZVVORE13WXhLWDVF?=
 =?utf-8?B?dkRSL1lNWnM3aElTZjVzeG1JbHJZMzk5Uy83TE9iV1h2VGpCdVltT0gzaVFp?=
 =?utf-8?B?NFZzNHhHclQwVmE3LzRrYzE4M1pyRENPSGtBN1ZrM0MveWpzVnVDallMUWoz?=
 =?utf-8?B?RmMxQXVkZEg1aWoyUjAvbVhwbWNXMUNPaXNoYkFJb2lHbW00bitsWTc2Mlli?=
 =?utf-8?B?SWVqU1U0eisvMlByQU5URTVZMDVEbUZxRHpadFhQUVZBNkgzdlloV2JBWkNt?=
 =?utf-8?B?bG82TkI1dzVMS0ZPU1hwRGtvak9QeTNHZnIvQWNuZFBDRVlqWUpXNUhYbkFX?=
 =?utf-8?B?WHhwOFRyN0QwajZhVCtvMkNkajR2eW8xY05OK0NoSG9HajUvcEZQY3o1Rmlj?=
 =?utf-8?B?Z1RFUDFDdHo4MEptcXM4VlN5bDkxUEl5elQ0RUZiK09lVGE1QklvRlZVYytm?=
 =?utf-8?B?OE9ldmlqQzNhYmFXR1ZoU3B0WHhaOTFiQWhZOEs0Rlg0NHhZUWp5Uyt0dlZl?=
 =?utf-8?B?SVhpV0VNeURsSWxDK3FOazZCS2ZCVE9OSXRzTG10SHF6bWN6em5XaGVwTEY1?=
 =?utf-8?B?TWpZV2RoMk50ZjdsTURCeG5JYzlIenAvQ2dnYnJZNCt3RzhaN0F2KzQwbjJi?=
 =?utf-8?B?bjVYOEMxNVpxVzduQVNjR0RQRWZIWkFBdXZ6NGZDMmhLRHU2TlJjRDFORWly?=
 =?utf-8?Q?WY3YnDCbXo/DqjtKNJNMe1c/B?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b43f396-8aa4-4b32-99a6-08dbfb77d759
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 01:07:13.5405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J2IIw9KubgZG3OVHZ/SljHPUU9vKGSm05/ElqdB1asv3+Q/ZlNtv91btLFakWQMs1jNZastj8Ou1hY79ZcQUsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5859
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gCWNhc2UgT3B0X21iYV9tYnBzOg0KPj4gCQlpZiAoIXN1cHBvcnRzX21iYV9tYnBzKCkgfHwg
Y3R4LT5lbmFibGVfbWJhX21icHMpDQo+PiAJCQlyZXR1cm4gLUVJTlZBTDsNCj4NCj4gSSBhbSBu
b3QgZmFtaWxpYXIgd2l0aCB0aGUgQVBJIGJ1dCBpdCBzZWVtcyB0aGF0IGludmFsZmMoKSBpcyBh
dmFpbGFibGUNCj4gdG8gY29tbXVuaWNhdGUgYSBtb3JlIHVzZWZ1bCBtZXNzYWdlIHRvIHVzZXIg
c3BhY2UgdGhhbiB0aGUgZGVmYXVsdCBvbmUNCj4gc2hvd24gaW4gY2hhbmdlbG9nIG9mIHBhdGNo
ICMyLg0KDQpJIGV4cGVyaW1lbnRlZCB3aXRoIGludmFsZmMoKS4gSXQgc2VlbXMgdG8gYmUgdGhl
IGFuc3dlciB0byB0aGlzIHBhcnQgb2YgdGhlDQptb3VudCBlcnJvciBtZXNzYWdlOg0KDQogICAg
ICAgZG1lc2coMSkgbWF5IGhhdmUgbW9yZSBpbmZvcm1hdGlvbiBhZnRlciBmYWlsZWQgbW91bnQg
c3lzdGVtIGNhbGwuDQoNCmJlY2F1c2UgZG1lc2coMSkgZG9lcyBpbmRlZWQgaW5jbHVkZSB3aGF0
ZXZlciBtZXNzYWdlIHRoYXQgaXMgcHJvdmlkZWQNCmJ5IHRoZSBpbnZhbGZjKCkgY2FsbCAoaW5j
bHVkaW5nIGF1dG9tYXRpY2FsbHkgYWRkaW5nIHRoZSBwcmVmaXggInJlc2N0cmw6ICIpLg0KDQpJ
J2xsIHdvcmsgb24gaW5jb3Jwb3JhdGluZyB5b3VyIG90aGVyIGZlZWRiYWNrLCBidXQgSSdtIHVu
bGlrZWx5IHRvIGdldCBpdA0KYWxsIGRvbmUgYW5kIHRlc3RlZCBiZWZvcmUgdGhlIGVuZCBvZiB0
aGlzIHdlZWsuIEknbGwgYmUgb24gdmFjYXRpb24NCnRoZSBsYXN0IHR3byB3ZWVrcyBvZiB0aGUg
eWVhci4gU28gdjcgb2YgdGhpcyBzZXJpZXMgd2lsbCBoYXZlIHRvIHdhaXQNCnVudGlsIDIwMjQu
DQoNClRoYW5rcw0KDQotVG9ueQ0KDQoNCg==
