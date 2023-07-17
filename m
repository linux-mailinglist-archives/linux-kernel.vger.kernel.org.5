Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C413D756547
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjGQNlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGQNls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:41:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3692794;
        Mon, 17 Jul 2023 06:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689601307; x=1721137307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=GDdviRQAwqAUdRzcw5n6kdjwOy+XM9nmNiorDpGMKBk=;
  b=g0DgIYn9ujrAoQ0v72zpEpasoc0HbFKdm/ZL+RaRsjgO+ACXtTIvRN4m
   7hm55jtdb5iuu3R+Z4erxOUeUaAu2tsqb3n+gM6Ob6VVBCEO36H0cWO9V
   dBPusRhPoZ3FDQPcD4gQd1MRZ8XomfnJjbnUMdKtdewhqZpbQIkG+I0v6
   1vstyjDdrgdTA9pCmszlITybvdGQhdS1vPubn5GPIpsggAEe+ocHYQYg4
   a65O72LWXor+NsnEjhiqyjoBapsS9OZbU4dtfzMSj1HVtcZF3dBd7170u
   V5Zy40UvYAVwAcDgHY4EmO6c38VNEP4SxeoOosb2Xc06ox46kdbaW9EWO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="346236851"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208,223";a="346236851"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:41:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793251929"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208,223";a="793251929"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jul 2023 06:41:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 06:41:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 06:41:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 06:41:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUDgelgdWh0kei+vEZmbdtyounDWva1l8sEV8Q2aPBX4wEy7aJthqRni9J7ig/44Zi46VbRkchVZbfdahA2w7HVR6k2qZBKptVXyH0nkmXM91PnlvJJBudM8ey+/hgpN3An/QIRzpnyFGzJK9B0ZZilIKBT0gcQGWsPc7wmS9AMNs4bHiOyjFRMkiAxaKybIfomHWzquisNtnp1IIoGiSQN43fmicabNbFq3HmHtbVFBTgd1a5WSTs/gCRkJZALi9tzGUBQE6mE9j/qRyQliDXiVnc7WDTjQnKADNlhCDeOuQv9U82n9MI6+LjgPiJMMeR6mvXqN2meovlJRC2WtlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmuW+joUrSM4NCkf0wqxDqvcYdsrMnU4CZ9EIDRP/R0=;
 b=c4SkEnXFOmKYnZPuYAe0LCF/p+W+U/PiI+qvsC/h+V2KA2UhHXb9TEn3HGr8csT0GQQzZeN9wl3PS65eW7648cU6IwDh8Mqem6ZQB2nqLMcZKMNyqCyJ8vM90l3/XkyGpo7mXogEE10sprziBjaFyiCZ/tesG5NlKoZpEQeI8dHd/TzhFniqm+lF6Ne4AZhBb1BG35TgeKUOSfAI9O+WMzf8FukHiWXLZnMN0HX5GF4nKYmoH6vGGUJwYzHYJHMJR0JAjNqaulSdDyXuKblmzc3r5oA1yVQy+fROPNgTZx2WbIJmjXyQlbLYiM+BaqhrsyCr1LLeKpMPm8V7CWvekg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) by
 SA2PR11MB4842.namprd11.prod.outlook.com (2603:10b6:806:f8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 13:41:43 +0000
Received: from DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::e1a8:582d:1efc:dffc]) by DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::e1a8:582d:1efc:dffc%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 13:41:43 +0000
From:   "Peer, Ilan" <ilan.peer@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Rudi Heitbaum <rudi@heitbaum.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Regressions" <regressions@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Networking <netdev@vger.kernel.org>,
        "Linux Wireless" <linux-wireless@vger.kernel.org>
Subject: RE: mm/page_alloc.c:4453 with cfg80211_wiphy_work [cfg80211]
Thread-Topic: mm/page_alloc.c:4453 with cfg80211_wiphy_work [cfg80211]
Thread-Index: AQHZt9Y8Drzo+t4D60uEaI2mUoJeL6+9+JZA
Date:   Mon, 17 Jul 2023 13:41:43 +0000
Message-ID: <DM4PR11MB6043088A4A65CBF124F5D518E93BA@DM4PR11MB6043.namprd11.prod.outlook.com>
References: <51e53417-cfad-542c-54ee-0fb9e26c4a38@gmail.com>
In-Reply-To: <51e53417-cfad-542c-54ee-0fb9e26c4a38@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6043:EE_|SA2PR11MB4842:EE_
x-ms-office365-filtering-correlation-id: cb688c25-ee2e-4785-7481-08db86cb8ec3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i7DXEs7gGAsKZ9GQQxbxGsSGoZ5VS/143pUb49Lq9i5LdL0VZZpUC8Ri6ZN0gVwCYOrbgbIscL6PfqxSf5hk8yaF7YgknadN55ivz1Jpu2J+PTysAT2H6s7WfHQIKi7jAebU0IqBiHEv1LTHGLF5p4g3YRykkOu1hfgrPHdvyPXsqqqAc5twJoMFYgq9iKXmM1x3Eqn4PDDUlzR5jzHSiHJ6xOi+t6Y5U0EONXHM7V6/BxZ74qhj85R9B/Xk+s08pzsngEkt4svrVS2ig3Has4Z1pes7Ptm9+wC/83V5MNUuDZaCUOHBneVOrjSYsjr3bf6B4sZaUtvHkbV5WoNl9yuyYsSJSw+kMiQFMQDkfjMCvbRePejW3jDmBGxb3OaFyn3Cn6tZm1DNLqjhD4L/NrQ7vKud/VRU/YlaxrxalCs0CEmmsqr+lVz0Nx9R3IpkA6bGJWHYWdWQlH6XKqKeQU1xE/hDKEC0WZE+5euqLnMIYOViUNV+MRUbcFvYd/53Ec976j+0EQp1TKpbTfprVNhxVH6Ic78HMFbq5nQ89APdItSsXQDL3db7Qhjxo43HLkhs429aIJaOYChLhenxZsOSsEbz0PXcu4lfnmE0Y8uMMH6zFzSmbWTunctH8tk4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6043.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(110136005)(478600001)(71200400001)(45080400002)(7696005)(54906003)(186003)(53546011)(6506007)(26005)(9686003)(966005)(76116006)(2906002)(41300700001)(4326008)(316002)(64756008)(66556008)(66446008)(66946007)(5660300002)(52536014)(8936002)(7416002)(8676002)(66476007)(38100700002)(921005)(122000001)(82960400001)(99936003)(33656002)(86362001)(38070700005)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3lzT2NpeU40eU1GUWNNb0F4TVZtNmkwNlVRcUVRcVVDMWx4em0wdXFQeXl3?=
 =?utf-8?B?UDhPS0JTcDU0Qy9STmJnb3dSRDNmeU52Vi9FYXRBNVI3SHpCMzZ4MzE2cVRq?=
 =?utf-8?B?bGNobVNlbFVyVk9FOUR2Q29VblVGNXR1cDliQ1Y2emZEYVJiT0cwblB3eUR6?=
 =?utf-8?B?cS82ZWRGUVZ2OFovQU4rZWhIT1UrdGg3UVV2MjJFT3grT2pQNmg3ckNCSFRz?=
 =?utf-8?B?WGxCMDR2NEhIZjNNbXlwdDh6RXd1c044VVk2dW5YcjBaa0V5bjk3L1V5dXhF?=
 =?utf-8?B?VDh0Y2p1RnF6S29tLzRDQXpuZm92Vm1jOHJpS2tTZ0JrNERSZnFiMXFnSlE4?=
 =?utf-8?B?NU9wVmVOTUZVcUxFaG5SQnBCU1dLQXFnaHo2QUFqc0wzNnREd0toZGdkSlc4?=
 =?utf-8?B?dzJGUzNrQk1sdnJEQUU5VlJPbHFPRzdCdUNxQklPTXNhbWVYTGZSaU1IYVJC?=
 =?utf-8?B?dTlaSkZqM2F5R1g2QnUxNjUrSjYxbzh2UEE3MVVDM3pRREFrQmllamRKTjNY?=
 =?utf-8?B?OFNNQUNXZHh2bFFLelozWmdyY0tGSHNRSXZlZDRQYVB6R2Y3MnNOaEsyL3k3?=
 =?utf-8?B?Rm03Vi9ZZGVOUXh5M1dCai8yQmJ4eC9iQmNieUFpSGkxa3FOd2NMeUV3L2l0?=
 =?utf-8?B?ek9QbytBVjhFc0lvY0pscGlpMGIwamhWNEVvUHRFemo4SVNITm5QSkIwVWRj?=
 =?utf-8?B?a2dXTnpTNnV2b2E0WDZUaFBIOTFaYWdZSGFiVFFtODVIQlFYT24vRno3cS9i?=
 =?utf-8?B?RDVNbWRoeXlMZFZxUUZNVllnVDVnT0hQVUN3eTk1ei9SaWk4QzlPempNNGdl?=
 =?utf-8?B?ZXA2V2JsTjdtaUNpWVpRa3NPWU5ubGFpMFRGdGdOY3lpczF5RW9EWFM4bTNQ?=
 =?utf-8?B?NU5OK0N3V215Z01iSXRXblpndTZqc0pKbjl2bndrSGFMbDI0VzR6aU1ob05p?=
 =?utf-8?B?a0pZL2x1bUdleGh6aERQMWVQTEJHZE1CeUdXRWwvRm5lTjd3SnVWOGlOOUR6?=
 =?utf-8?B?VE1CMys2eXJUckN3bFBRbEVZTWloeUducUkycnZCbTlja0N6UXExdnNGSm12?=
 =?utf-8?B?QjVDVUQrTFBYVVR3QzBiOVF6TDVuQWlmUUVSLy9NWDcwZENTSTAvVEt5L2I5?=
 =?utf-8?B?WWcrb0NWMlRWUU81QUlseHcwWDh6SWhZU2hxNjFTZ1ZQU0pDaklkVENKY0pp?=
 =?utf-8?B?NEo0Nm9jUmFDL1VvMTUvbTdCWjhhSzNReEdtU0M3L1VzNFNRbEkwZUkrMEVS?=
 =?utf-8?B?UzhwdHI0dGlUemZQakxrTDkwSVA3bEp3Nm1ycC91NGluU0doS2xidmxZRjJT?=
 =?utf-8?B?Tkd2U1JVRVZCZlVuQWNObFh2TnNUaiswUzJoTDVHV0xmV1k4eWliT2NiUVFP?=
 =?utf-8?B?YmtlZHRLNHppYm1uVUZSbUFxYkdTY2IwNTZaeHQwdXdjbDd3ZlpLMlFZWm9Y?=
 =?utf-8?B?MUlDZGdYdGFwNlpQRXZpbzgvWmYwTnZzRFZyNjNHcThPTS9QdVhmTGpmSE9P?=
 =?utf-8?B?clJkU2lzQjlvUk1UQ1Q1UXRPdVVIVEZpSkJMUTgyWDdWbUR1M1JodXZMWHJh?=
 =?utf-8?B?V2pQQkZUWEhhUlZEQ1dzWnFGU1c1TWJ5QkVrREZMR29xTmxJMXdlVGZCTlhI?=
 =?utf-8?B?VnRSeGkzZ3c2MmJhWFAzbjRVK2k2MVg0VjFZelBXa053ZGZNR1U3RVV5TjAx?=
 =?utf-8?B?K1BuYjl4ZXk4WXFKR3hBcktib2IzL2ZOQzdPc2JQL0dUSE9ha20xNkwrb2Z4?=
 =?utf-8?B?ZmhEajR1WFUvMFQ0R1paSVA0S0YwQXlHellDckRaVU1EblpENWhVbFIwS0xu?=
 =?utf-8?B?ZElQOWVMaHAxdzlabjVyV3RTVUxOd3NHWkZBeTFWcEYrcUxwK3llN2VWSEZN?=
 =?utf-8?B?aW8rVGROSFhXWmN1REFzYkhSVEdKZDdVSVV0UnB2UWZZRFkyeUVudDJGR3Nu?=
 =?utf-8?B?NlZXWkhYcXMwV2RrdGlGc05rK25aaFA1NDlscG85MHRHYjRudTE4akZwQXZ6?=
 =?utf-8?B?RlBDcjh5R1VhUDA2ZjlMbGh5K1BIeXBzbSt6RjJEOWlvMWo2bHFlQ0Jnei9m?=
 =?utf-8?B?YjRGdmpXSUtJazM0a0QzL2RrOFhMd2JjYXdpUStkZmFxNysrcnBMbElyRGhn?=
 =?utf-8?Q?pq5OKZSSFkiy7stmAMTk8OwXC?=
Content-Type: multipart/mixed;
        boundary="_002_DM4PR11MB6043088A4A65CBF124F5D518E93BADM4PR11MB6043namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6043.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb688c25-ee2e-4785-7481-08db86cb8ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 13:41:43.4375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uEj+8tKfi1s0JJfL5JSr8Rvg7Az+S5sry/x+JXtHi383CnoL/5tG6cJcCCeUvr6f5YM0T9JKybyHJRFXx+PpiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4842
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

--_002_DM4PR11MB6043088A4A65CBF124F5D518E93BADM4PR11MB6043namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgU2FuamF5YSwNCg0KQ2FuIHlvdSBwbGVhc2UgY2hlY2sgaWYgdGhlIGF0dGFjaGVkIHBhdGNo
IGZpeGVzIHlvdXIgaXNzdWU/DQoNClRoYW5rcyBpbiBhZHZhbmNlLA0KDQpJbGFuLg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJhZ2FzIFNhbmpheWEgPGJhZ2FzZG90
bWVAZ21haWwuY29tPg0KPiBTZW50OiBTdW5kYXksIEp1bHkgMTYsIDIwMjMgMTQ6MTENCj4gVG86
IFJ1ZGkgSGVpdGJhdW0gPHJ1ZGlAaGVpdGJhdW0uY29tPjsgSm9oYW5uZXMgQmVyZw0KPiA8am9o
YW5uZXNAc2lwc29sdXRpb25zLm5ldD47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0
Lm5ldD47IEVyaWMNCj4gRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2lu
c2tpIDxrdWJhQGtlcm5lbC5vcmc+Ow0KPiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+
OyBLaXJpbGwgQS4gU2h1dGVtb3YNCj4gPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+
OyBNaWNoYWVsIEVsbGVybWFuDQo+IDxtcGVAZWxsZXJtYW4uaWQuYXU+OyBBbmRyZXcgTW9ydG9u
IDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiBDYzogTGludXggS2VybmVsIE1haWxpbmcg
TGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IExpbnV4DQo+IFJlZ3Jlc3Npb25z
IDxyZWdyZXNzaW9uc0BsaXN0cy5saW51eC5kZXY+OyBMaW51eCBNZW1vcnkgTWFuYWdlbWVudCBM
aXN0DQo+IDxsaW51eC1tbUBrdmFjay5vcmc+OyBMaW51eCBOZXR3b3JraW5nIDxuZXRkZXZAdmdl
ci5rZXJuZWwub3JnPjsgTGludXgNCj4gV2lyZWxlc3MgPGxpbnV4LXdpcmVsZXNzQHZnZXIua2Vy
bmVsLm9yZz4NCj4gU3ViamVjdDogRndkOiBtbS9wYWdlX2FsbG9jLmM6NDQ1MyB3aXRoIGNmZzgw
MjExX3dpcGh5X3dvcmsgW2NmZzgwMjExXQ0KPiANCj4gSGksDQo+IA0KPiBJIG5vdGljZSBhIHJl
Z3Jlc3Npb24gcmVwb3J0IG9uIEJ1Z3ppbGxhIFsxXS4gUXVvdGluZyBmcm9tIGl0Og0KPiANCj4g
PiBMaW51eCB2ZXJzaW9uIDYuNS4wLXJjMSsgLSB1cCB0bw0KPiA+IDgzMWZlMjg0ZDgyNzU5ODc1
OTZiN2Q2NDA1MThkZGRiYTU3MzVmNjENCj4gPg0KPiA+IFsgICAgNy4zMTI2NjVdIC0tLS0tLS0t
LS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiA+IFsgICAgNy4zMTI2NzFdIFdBUk5JTkc6
IENQVTogOCBQSUQ6IDY1OSBhdCBtbS9wYWdlX2FsbG9jLmM6NDQ1Mw0KPiBfX2FsbG9jX3BhZ2Vz
KzB4MzI5LzB4MzQwDQo+ID4gWyAgICA3LjMxMjY4M10gTW9kdWxlcyBsaW5rZWQgaW46IGV4ZmF0
IG50ZnMzIGJuZXAgYnR1c2IgYnRydGwgYnRiY20gYnRpbnRlbA0KPiBidG10ayBibHVldG9vdGgg
ZWNkaF9nZW5lcmljIGVjYyBpd2xtdm0gbWFjODAyMTEgbGliYXJjNA0KPiBzbmRfaGRhX2NvZGVj
X2hkbWkgaXdsd2lmaSBzbmRfaGRhX2NvZGVjX3JlYWx0ZWsNCj4gc25kX2hkYV9jb2RlY19nZW5l
cmljIGxlZHRyaWdfYXVkaW8gY2ZnODAyMTEgc25kX2hkYV9pbnRlbA0KPiBzbmRfaGRhX2NvZGVj
IHNuZF9od2RlcCBpbnRlbF9yYXBsX21zciB4ODZfcGtnX3RlbXBfdGhlcm1hbA0KPiBpbnRlbF9w
b3dlcmNsYW1wIHNuZF9oZGFfY29yZSB0cG1fdGlzIGludGVsX3JhcGxfY29tbW9uDQo+IHNuZF9p
bnRlbF9kc3BjZmcgdHBtX3Rpc19jb3JlIGlkbWE2NCByZmtpbGwgdHBtX2NyYiB0cG0gcm5nX2Nv
cmUNCj4gcGtjczhfa2V5X3BhcnNlciBmdXNlIGRtaV9zeXNmcw0KPiA+IFsgICAgNy4zMTI3MjVd
IENQVTogOCBQSUQ6IDY1OSBDb21tOiBrd29ya2VyLzg6MiBOb3QgdGFpbnRlZCA2LjUuMC1yYzEg
IzENCj4gPiBbICAgIDcuMzEyNzI5XSBIYXJkd2FyZSBuYW1lOiBJbnRlbChSKSBDbGllbnQgU3lz
dGVtcw0KPiBOVUMxMldTS2k3L05VQzEyV1NCaTcsIEJJT1MgV1NBREwzNTcuMDA4Ny4yMDIzLjAz
MDYuMTkzMSAwMy8wNi8yMDIzDQo+ID4gWyAgICA3LjMxMjczMV0gV29ya3F1ZXVlOiBldmVudHMg
Y2ZnODAyMTFfd2lwaHlfd29yayBbY2ZnODAyMTFdDQo+ID4gWyAgICA3LjMxMjc4NV0gUklQOiAw
MDEwOl9fYWxsb2NfcGFnZXMrMHgzMjkvMHgzNDANCj4gPiBbICAgIDcuMzEyNzkxXSBDb2RlOiBh
OCA0NCA4OSBlNiA4OSBkZiBjNiA0NSBjOCAwMCA0YyA4OSA2ZCBiMCA0MSA4OSBkZSBlOCAwYiBl
Zg0KPiBmZiBmZiA0OSA4OSBjNyBlOSA5MCBmZSBmZiBmZiA4MCBlMyAzZiBlYiBjMCBjNiAwNSA2
OSA0OSBmNyAwOSAwMSA8MGY+IDBiIGViIDk4IGU4DQo+IDFlIGVjIDZkIDAxIDY2IDY2IDJlIDBm
IDFmIDg0IDAwIDAwIDAwIDAwIDAwIDBmIDFmDQo+ID4gWyAgICA3LjMxMjc5NF0gUlNQOiAwMDE4
OmZmZmZhZDhlODBkZWZiZjggRUZMQUdTOiAwMDAxMDI0Ng0KPiA+IFsgICAgNy4zMTI3OThdIFJB
WDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IDAwMDAwMDAwMDAwNDBkYzAgUkNYOg0KPiAwMDAwMDAw
MDAwMDAwMDAwDQo+ID4gWyAgICA3LjMxMjgwMF0gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTog
MDAwMDAwMDAwMDAwMDAwMCBSREk6DQo+IDAwMDAwMDAwMDAwNDBkYzANCj4gPiBbICAgIDcuMzEy
ODAyXSBSQlA6IGZmZmZhZDhlODBkZWZjNTAgUjA4OiAwMDAwMDAwMDAwMDAwMDA1IFIwOToNCj4g
MDAwMDAwMDAwMDAwMDAxOA0KPiA+IFsgICAgNy4zMTI4MDRdIFIxMDogZmZmZjkzODg5OWQ0YTgw
MCBSMTE6IGZmZmY5Mzg4OTFhOWM4MDAgUjEyOg0KPiAwMDAwMDAwMDAwMDAwMDM0DQo+ID4gWyAg
ICA3LjMxMjgwNl0gUjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIxNDogZmZmZmZmZmZjMDJiMTUwZCBS
MTU6DQo+IGZmZmZmZmZmZmZmZmZjOTANCj4gPiBbICAgIDcuMzEyODA4XSBGUzogIDAwMDAwMDAw
MDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjkzOGZiNjYwMDAwMCgwMDAwKQ0KPiBrbmxHUzowMDAwMDAw
MDAwMDAwMDAwDQo+ID4gWyAgICA3LjMxMjgxMV0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAw
IENSMDogMDAwMDAwMDA4MDA1MDAzMw0KPiA+IFsgICAgNy4zMTI4MTNdIENSMjogMDAwMDdmNTQw
Yzk0YjcxMCBDUjM6IDAwMDAwMDA1OTUwMmMwMDAgQ1I0Og0KPiAwMDAwMDAwMDAwZjUwZWEwDQo+
ID4gWyAgICA3LjMxMjgxNV0gUEtSVTogNTU1NTU1NTQNCj4gPiBbICAgIDcuMzEyODE3XSBDYWxs
IFRyYWNlOg0KPiA+IFsgICAgNy4zMTI4MTldICA8VEFTSz4NCj4gPiBbICAgIDcuMzEyODIyXSAg
PyBzaG93X3JlZ3MrMHg2OS8weDgwDQo+ID4gWyAgICA3LjMxMjgyN10gID8gX193YXJuKzB4ODkv
MHgxNDANCj4gPiBbICAgIDcuMzEyODMzXSAgPyBfX2FsbG9jX3BhZ2VzKzB4MzI5LzB4MzQwDQo+
ID4gWyAgICA3LjMxMjgzN10gID8gcmVwb3J0X2J1ZysweDE1ZC8weDE4MA0KPiA+IFsgICAgNy4z
MTI4NDNdICA/IGhhbmRsZV9idWcrMHg0Mi8weDgwDQo+ID4gWyAgICA3LjMxMjg0OF0gID8gZXhj
X2ludmFsaWRfb3ArMHgxYy8weDcwDQo+ID4gWyAgICA3LjMxMjg1Ml0gID8gYXNtX2V4Y19pbnZh
bGlkX29wKzB4MWYvMHgzMA0KPiA+IFsgICAgNy4zMTI4NTddICA/IGNmZzgwMjExX3NjYW5fNmdo
eisweDEyZC8weGNiMCBbY2ZnODAyMTFdDQo+ID4gWyAgICA3LjMxMjkxMV0gID8gX19hbGxvY19w
YWdlcysweDMyOS8weDM0MA0KPiA+IFsgICAgNy4zMTI5MTZdICA/IGNmZzgwMjExX3NjYW5fNmdo
eisweDEyZC8weGNiMCBbY2ZnODAyMTFdDQo+ID4gWyAgICA3LjMxMjk2OF0gIF9fa21hbGxvY19s
YXJnZV9ub2RlKzB4N2UvMHgxNzANCj4gPiBbICAgIDcuMzEyOTczXSAgX19rbWFsbG9jKzB4Yjkv
MHgxMjANCj4gPiBbICAgIDcuMzEyOTc2XSAgY2ZnODAyMTFfc2Nhbl82Z2h6KzB4MTJkLzB4Y2Iw
IFtjZmc4MDIxMV0NCj4gPiBbICAgIDcuMzEzMDI4XSAgPyBzY2hlZF9jbG9ja19ub2luc3RyKzB4
ZC8weDIwDQo+ID4gWyAgICA3LjMxMzAzNF0gID8gc2NoZWRfY2xvY2tfY3B1KzB4MTQvMHgxOTAN
Cj4gPiBbICAgIDcuMzEzMDQwXSAgPyByYXdfc3Bpbl9ycV9sb2NrX25lc3RlZCsweDEyLzB4MjAN
Cj4gPiBbICAgIDcuMzEzMDQ2XSAgX19fY2ZnODAyMTFfc2Nhbl9kb25lKzB4MWUwLzB4MjUwIFtj
Zmc4MDIxMV0NCj4gPiBbICAgIDcuMzEzMDk5XSAgX19jZmc4MDIxMV9zY2FuX2RvbmUrMHgyMy8w
eDMwIFtjZmc4MDIxMV0NCj4gPiBbICAgIDcuMzEzMTUzXSAgY2ZnODAyMTFfd2lwaHlfd29yaysw
eGFlLzB4ZDAgW2NmZzgwMjExXQ0KPiA+IFsgICAgNy4zMTMyMDFdICBwcm9jZXNzX29uZV93b3Jr
KzB4MWYxLzB4M2UwDQo+ID4gWyAgICA3LjMxMzIwNF0gIHdvcmtlcl90aHJlYWQrMHg1MS8weDNm
MA0KPiA+IFsgICAgNy4zMTMyMDddICA/IF9yYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSsweDI2
LzB4MzANCj4gPiBbICAgIDcuMzEzMjEyXSAgPyBfX3BmeF93b3JrZXJfdGhyZWFkKzB4MTAvMHgx
MA0KPiA+IFsgICAgNy4zMTMyMTddICBrdGhyZWFkKzB4ZGIvMHgxMTANCj4gPiBbICAgIDcuMzEz
MjIyXSAgPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMA0KPiA+IFsgICAgNy4zMTMyMjZdICByZXRf
ZnJvbV9mb3JrKzB4M2UvMHg2MA0KPiA+IFsgICAgNy4zMTMyMjldICA/IF9fcGZ4X2t0aHJlYWQr
MHgxMC8weDEwDQo+ID4gWyAgICA3LjMxMzIzM10gIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWIvMHgz
MA0KPiA+IFsgICAgNy4zMTMyMzddICA8L1RBU0s+DQo+ID4gWyAgICA3LjMxMzIzOV0gLS0tWyBl
bmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tDQo+IA0KPiBTZWUgQnVnemlsbGEgZm9yIHRo
ZSBmdWxsIHRocmVhZC4NCj4gDQo+IEFueXdheSwgSSdtIGFkZGluZyBpdCB0byByZWd6Ym90IHRv
IG1ha2Ugc3VyZSBpdCBkb2Vzbid0IGZhbGwgdGhyb3VnaCBjcmFja3MNCj4gdW5ub3RpY2VkOg0K
PiANCj4gI3JlZ3pib3QgaW50cm9kdWNlZDogdjYuNS1yYzEuLjgzMWZlMjg0ZDgyNzU5DQo+IGh0
dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE3Njc1DQo+IA0KPiBU
aGFua3MuDQo+IA0KPiBbMV06IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5j
Z2k/aWQ9MjE3Njc1DQo+IA0KPiAtLQ0KPiBBbiBvbGQgbWFuIGRvbGwuLi4ganVzdCB3aGF0IEkg
YWx3YXlzIHdhbnRlZCEgLSBDbGFyYQ0K

--_002_DM4PR11MB6043088A4A65CBF124F5D518E93BADM4PR11MB6043namp_
Content-Type: application/octet-stream;
	name="0001-wifi-cfg80211-Fix-return-value-in-scan-logic.patch"
Content-Description: 0001-wifi-cfg80211-Fix-return-value-in-scan-logic.patch
Content-Disposition: attachment;
	filename="0001-wifi-cfg80211-Fix-return-value-in-scan-logic.patch";
	size=1036; creation-date="Mon, 17 Jul 2023 13:39:03 GMT";
	modification-date="Mon, 17 Jul 2023 13:41:43 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1YTZmY2M0YjJhOTE2MDg5MTc2OTdmODQ0NmVjM2UxMGIyY2U5MTc4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBJbGFuIFBlZXIgPGlsYW4ucGVlckBpbnRlbC5jb20+CkRhdGU6
IFR1ZSwgMTggSnVsIDIwMjMgMDA6MzM6MDQgKzAzMDAKU3ViamVjdDogW1BBVENIXSB3aWZpOiBj
Zmc4MDIxMTogRml4IHJldHVybiB2YWx1ZSBpbiBzY2FuIGxvZ2ljCgpBcyBjZmc4MDIxMV9wYXJz
ZV9jb2xvY2F0ZWRfYXAoKSBpcyBub3QgZXhwZWN0ZWQgdG8gcmV0dXJuIGEgbmVnYXRpdmUKdmFs
dWUgcmV0dXJuIDAgYW5kIG5vdCBhIG5lZ2F0aXZlIHZhbHVlIGlmIGNmZzgwMjExX2NhbGNfc2hv
cnRfc3NpZCgpCmZhaWxzLgoKVGhpcyBidWcgd2FzIGludHJvZHVjZWQgaW4gY29tbWl0IGM4Y2I1
Yjg1NGI0MGYKKCdubDgwMjExL2NmZzgwMjExOiBzdXBwb3J0IDYgR0h6IHNjYW5uaW5nJykuCgpT
aWduZWQtb2ZmLWJ5OiBJbGFuIFBlZXIgPGlsYW4ucGVlckBpbnRlbC5jb20+Ci0tLQogbmV0L3dp
cmVsZXNzL3NjYW4uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL25ldC93aXJlbGVzcy9zY2FuLmMgYi9uZXQvd2lyZWxl
c3Mvc2Nhbi5jCmluZGV4IDhiZjAwY2FmNWQyOS4uMGNmMWNlN2I2OTM0IDEwMDY0NAotLS0gYS9u
ZXQvd2lyZWxlc3Mvc2Nhbi5jCisrKyBiL25ldC93aXJlbGVzcy9zY2FuLmMKQEAgLTY1Nyw3ICs2
NTcsNyBAQCBzdGF0aWMgaW50IGNmZzgwMjExX3BhcnNlX2NvbG9jYXRlZF9hcChjb25zdCBzdHJ1
Y3QgY2ZnODAyMTFfYnNzX2llcyAqaWVzLAogCiAJcmV0ID0gY2ZnODAyMTFfY2FsY19zaG9ydF9z
c2lkKGllcywgJnNzaWRfZWxlbSwgJnNfc3NpZF90bXApOwogCWlmIChyZXQpCi0JCXJldHVybiBy
ZXQ7CisJCXJldHVybiAwOwogCiAJZm9yX2VhY2hfZWxlbWVudF9pZChlbGVtLCBXTEFOX0VJRF9S
RURVQ0VEX05FSUdIQk9SX1JFUE9SVCwKIAkJCSAgICBpZXMtPmRhdGEsIGllcy0+bGVuKSB7Ci0t
IAoyLjI1LjEKCg==

--_002_DM4PR11MB6043088A4A65CBF124F5D518E93BADM4PR11MB6043namp_--
