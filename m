Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C5E7BF52D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442596AbjJJIA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442613AbjJJIAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:00:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE46E1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696924847; x=1728460847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FXHRwvKsddVekndh9O+/F0lDAxL7VKCec+kG4p7yeds=;
  b=UXOyBUfFjDcPxj7aKW9ac4OF1fHTVEb+vKVaB1mOEbolXgCxrTVX53NY
   mJNxxWzX/KmzukA8Mf/IijfGXMND9sq4qK29di+u0PNam6JK2APkofR1M
   AkeSgbxB02q9A8Tq1RlHIA/WFqYUUSzzAt+tZUmOiK+VPvf6N6xvUu5Xe
   s/GZj11cZIeykJYkovlM0YIx+sWVkF0iZieowlg3dj7bvCKoe+53+ggnf
   7nRZAnPKu+zXs9mqZhFJabCveaKCqUjQh2FJhJQIu+28cgSjn/fUqbHBE
   THQ2zhRw01RaqEhRKj/erGFW+Gy48RyRS6BKOjB+n/sDFALHI/FVXh4XE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="470600619"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="470600619"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 01:00:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="788488671"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="788488671"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 01:00:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 01:00:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 01:00:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 01:00:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 01:00:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWbltlrnEW+ghmobE74yQPb/8n/Z12yKIRkBQ2rstjrjZHwDyZpVdAiYLHYbhXtdReqPDW+Wl4u/Vc2/0ugUE/Qa32sJgoUllcHlZ4EbGTY1W8fNjaHCUUVWUgS2i5reOdKLclpfvwBzlzlZwPVZX/N/Q/xJUZBYgvq7QyQ/gf99nMy0rqs/mL5TnjibJXWdS4S/cjRYIyjh2D2z673RFE3Scrpuja5+95+o1623ar9kZjN0SBSI+aZSsmkD7Up6BQzyo+AAgKAZmG9MWTiSCmZRFm9XtDmgNYs/Dx9mUC5AWLLUXbWLO8OuTRGQwn14RTgknDjDvOhbhVYKP+Li/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXHRwvKsddVekndh9O+/F0lDAxL7VKCec+kG4p7yeds=;
 b=QI/F7bHee9hkA4kLjl7+dnN5iaURQT0o90xbDBIRBczSd15rkFheEm/56T37m3YOuJRt9OOEv/ow5tdeEBJQCeJXIeBDzWjB4BMU1B32gpLN+zhkZqzd/ZCbbw6RJWWTXqko6akCJmIIzMaxlihMZFelOr0fyWWJ9H5oLvlrHj1obrkJe8/svPN5/Kh0/haw1MW1ldublX8n99b0VDkS5D8/kRMrsyjZPQSGRProaRzLJr3fZANZh2h6pBERMPjBWyhVGVJVOoRNlfR4E5t4GXi16+rhXSrpR4EuGsLG0ylTE23x0evSC7Kl8LbLz3zKQdl9aMg9u/QavyIH6n6tdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by BY1PR11MB7981.namprd11.prod.outlook.com (2603:10b6:a03:52f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 08:00:27 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::e30d:930b:e14d:bb7a]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::e30d:930b:e14d:bb7a%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 08:00:27 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [patch V4 00/30] x86/microcode: Cleanup and late loading
 enhancements
Thread-Topic: [patch V4 00/30] x86/microcode: Cleanup and late loading
 enhancements
Thread-Index: AQHZ+cUs2+mJdQ0iIkuJzDEkINjNBrA/3ZIAgALNVSA=
Date:   Tue, 10 Oct 2023 08:00:27 +0000
Message-ID: <CY8PR11MB713415003139D301D51824E789CDA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20231002115506.217091296@linutronix.de>
 <20231008085456.71646-1-qiuxu.zhuo@intel.com>
 <20231008130840.GCZSKp2NbHAOB3h69z@fat_crate.local>
In-Reply-To: <20231008130840.GCZSKp2NbHAOB3h69z@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|BY1PR11MB7981:EE_
x-ms-office365-filtering-correlation-id: b3b905c0-a3e6-461e-302d-08dbc966f768
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FOr4xF4uLGOx22HfZRri84RLG5gRFr40ZD6M1T/D0dm7qBqgJApH8O2WB0sHtdVdHFVdHALM9Kgq4hfnwGIjmZw14Ys3c5Y7viMELkBi3H2a8iOuChSiOexdXBGiMgK7vIHopX1AsqauT5jc/9EzejJlcpzevCO8BtAdr5VwPXq+3bYrPHC/xcsncnI8Bam97qlAQf46Wecl7kazQcK2aA1yOMFGNh1tUhcShcr1VjJfa93GNJnxrCeWVRA8KBgMOv7cf9F0bCSKgT/yXR5e9R4GQurx7Smw+fm6IqA6Z2ICp4JKAJQ3fxk7CU67dAO6ltRD4uAYWiHB4jzUrCyHkQOsuN60Ldi5cYPvd6g5i4W5nz7vdoAutgUhWb8e1W4TQ+QCLMKonuXmUo4c2mIphLPY3SSM01LO2wztbeeBa8p77SrnySthBvfsorzXnJGhuId2ugk6V58XrUHdIljcjC5xfiHqAVHJV8Y3ebM6irlIUhgDUahDaWoGH7xmn6T9DN5o2CRMzkVhLw0UttctAC/CYUUIm69c/ibUeHNJvIx1gVJgbrWZDQd2DyjVkHgE4MN2NwhmvLM0P+BL7nFn63NGyX1jPEnfBYY693WAp7qV02bHVH+jkQcyBAeHhF6U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82960400001)(86362001)(38070700005)(122000001)(38100700002)(33656002)(9686003)(55016003)(478600001)(4001150100001)(6506007)(2906002)(7696005)(52536014)(5660300002)(8676002)(41300700001)(8936002)(4326008)(71200400001)(83380400001)(316002)(66946007)(66476007)(66556008)(6916009)(64756008)(66446008)(54906003)(76116006)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2xnMHUxWjYyZGZnY1Y1cHZsVEkwMmF2QXJqQW8zYnJvZDNHRC9vZ1ZEZG9z?=
 =?utf-8?B?U2lFMis4UHVDb3BuVFZocnk5TE1FcHBGU0NrS05WRGRwRjZkOTFIMlkzZW5J?=
 =?utf-8?B?TXdLS3ErTmN0OXFHTmNsVWNkRTIyK2xFUGpLNG0vbmNHRTlveWMzblcvOTc0?=
 =?utf-8?B?UGVWQUhFalVEUGFVd1lkRUFtK0F4K2p1UnZQQUtyQUFwUWpObzFnQWtxSXBG?=
 =?utf-8?B?eWxMRFhKMlMzYTR0RllEc2txWm9hbGxHbTJPTTd0WXdpVUgxWHVUcXBxVmhk?=
 =?utf-8?B?K3JqYisyMDFzUTNVYnA2M0ZzdU1oQ0JiZXZPb09GSklNeXJQU2ZadUFLcElv?=
 =?utf-8?B?ZlEzNjU5c0l5V3NhNUN1dzZ4T3V5UmcwL29HL1Y0dXVlYlpnc24yOHNsMlNa?=
 =?utf-8?B?Sk9VQUtJbkZJYWUxa0EyOVBZQjZpU2dSeWl4eGRsa2xwaWZxaTFMK1R1N2tX?=
 =?utf-8?B?ZGtueVB2M1FwRER0Z0xSRnFoNEVjZjJkdFpUd01DV0lKQUo5NmR1VTFEVzRU?=
 =?utf-8?B?akNuamVaYXZXZjczLzZtZVgxYWo5QWtsYytLY0JlZnZoR3dUSGNZRmhKbnEr?=
 =?utf-8?B?bHZhMmVXdXg3ck1uU1p1MEdCMDhFUjVpRmJKNGtqQWNBOUVWVEdadjZsbG52?=
 =?utf-8?B?Tkx6NTNQV201TEFJMkQyczUrVGFlSSsxNjczZmEveUFuMWdBNzk3VHplNzBF?=
 =?utf-8?B?U1YrS3F4VjE4VkR6YTNTYmg2REVJeVFtNG81cy9FbWJ2M1dRRWZDb1pBR2F6?=
 =?utf-8?B?SEpseDJsZFJ5ZW5adkZOV2RvQ1BaS3psZUFoZkVqcGFOV0dDajZ3aWN2aFJa?=
 =?utf-8?B?aTRjcUQvb2NzRDRndHFPSzV3MzVrMVN6UExPNjZZZktleXhTUzFNdlZ5SDho?=
 =?utf-8?B?MDhoMkNGVVh3b3h3VTFqU3YrWHRZV05Ndkl5YVRicmYrdFdJL3k3Ny94VWcz?=
 =?utf-8?B?bVRMTjh1aFU0VWtiQUQ5L1VTcVFCbGhLbnVndUNnL3pKaEpBY3RwOTB0ZGQ3?=
 =?utf-8?B?eGozMlorSEg1aDFoYW5qU3Q5eWFSNGxUaE16REVZT1ZtWjdlZnQ5WkRJSW1x?=
 =?utf-8?B?NWk3YUNHZ05CNjh4NDMyNnJpaU9FZlpzM3ZqQ2RLeEtqajRjTTNtVjJwUFRj?=
 =?utf-8?B?aUJFbnJ6OGVhTk1DMXRhdWFNdjlIWC8xQXo3UHlRT0V5RjY3SjV6Z2tWTFhG?=
 =?utf-8?B?Z253TFRodFNxcjl4R1FxRmZucFJsU1VtY3lNcG9Xd2xHajQxKzhFMGdJMnpV?=
 =?utf-8?B?bHlnUTZzSzhkM1pZR3VObFV4N25FMnIwTDFuUU44MDFLZ01Ca3ZwNXc4REpu?=
 =?utf-8?B?RDR4RHNzVUppZmtOV1NyM21najdtY0JOMzdBcUZ1Z2JHZ0dFeTBReVFFcTlr?=
 =?utf-8?B?WkwzNVJFSjJ5aGxTc3U5OGNIMHdVTmg4OUJHVEx3SG9sR2EzZUdvMDJCaEty?=
 =?utf-8?B?V2xmVTVwSWc3a2RVTUlHMmE3cXFQYmg0NFFrb2E1VFRYTGtWUHZrVitRU0ph?=
 =?utf-8?B?cjBrN3psWVd2dWpTRkdHazliYVlMREVuMmJFbWk4RXlacDRrdHN0L2E1ai9D?=
 =?utf-8?B?MUxPR0R1UWE4dXFYV3VlOVc5OG5oM0hyTVVSUnlMakJjN1d3b3ZTN1B0QVVt?=
 =?utf-8?B?bng3aFVLWEJ5bVY2aTJtWWxKeDd2ZllseDVPZFMrWGJLS2pzRy9ra0QybTlS?=
 =?utf-8?B?NXROSVFrb24xY0lVbmVaRGFONnpURnMzajd4d25PSXVKOTVDaDJHeDBPNGhp?=
 =?utf-8?B?QjJrV0J3WmdCaFE0UWdVcXZoWTREUDdpbW5nMWc0Sy8rTWFxTUdQeHpzNmxu?=
 =?utf-8?B?MHJ1YUx3S0IrYkhneWlCdkRSSU5iVk1ydHhEd0ttL0pjcXNBRTlpQ0sxV3Jo?=
 =?utf-8?B?bDBYb0R4RVZmZTMxTThOV2NGVno5NWl1Vk5PNjdIbUVHeFcrWkU2aTdqcHJ2?=
 =?utf-8?B?R1pTblhYb0FYVFZPWjU4aC9xUTJST3VmMEliOC8vVnN0b3dsTVVxV0F0L3VQ?=
 =?utf-8?B?a3RNRTRFQjRrckZ4NWwzNXpiSGdOUDFPeTZHcmxKMEJDQnlHUFo0SEVaL0xH?=
 =?utf-8?B?TnJHNWJQUnpuN3FPM1VuRkFvb2tvdzFyTWs4VGVxQ0dEU0hkREQzSkZ2S0dV?=
 =?utf-8?Q?4DQrpIWJ2KgSImCT+pfnIC4le?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b905c0-a3e6-461e-302d-08dbc966f768
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 08:00:27.7254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6zDpLwS1rLlEWuNfDOUN+HlWeQJdyF37D89JGJ4N8HE6F+ctXXf38UkTZxueljOYnDJe9p65XLSWCDZuLbjWnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7981
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IC4u
Lg0KPiA+IFRlc3QgUmVzdWx0IChzYW1lIGFzIHVjb2RlLXYzKQ0KPiA+IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiA+IFRlc3RlZCAndWNvZGUtdjQnIG9uIGFuIEludGVsIFNhcHBo
aXJlIFJhcGlkcyBzZXJ2ZXIgdGhhdCBib3RoIGVhcmx5DQo+ID4gbG9hZCBhbmQgbGF0ZSBsb2Fk
IHdvcmtlZCB3ZWxsLiBGb3IgbW9yZSBkZXRhaWxzLCBwbGVhc2UgcmVmZXIgdG8gdGhlIHRlc3QN
Cj4gYmVsb3c6DQo+IA0KPiBUaGFua3MuDQo+IA0KPiBJJ3ZlIGZvdW5kIGEgY291cGxlIG9mIGlz
c3VlcyBhbmQgb25jZSBJJ20gZG9uZSB3aXRoIG15IHRlc3RpbmcsIEknbGwgcHVzaA0KPiB0aXA6
eDg2L21pY3JvY29kZSBhbmQgeW91IGNvdWxkIHJ1biBpdCB0aGVuIHRvIG1ha2Ugc3VyZSBpdCBh
bGwgaXMgc3RpbGwgb2suDQoNClRlc3QgUmVzdWx0IChzYW1lIGFzIHVjb2RlLXY0KQ0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogIFRlc3RlZCB0aXA6eDg2L21pY3JvY29kZSAodG9w
IGNvbW1pdCA5OTc1ODAyZDNmNzQpIG9uIGFuIEludGVsIFNhcHBoaXJlDQogIFJhcGlkcyBzZXJ2
ZXIgdGhhdCBib3RoIGVhcmx5IGxvYWQgYW5kIGxhdGUgbG9hZCB3b3JrZWQgd2VsbC4gRm9yIG1v
cmUNCiAgZGV0YWlscywgcGxlYXNlIHJlZmVyIHRvIHRoZSB0ZXN0IGJlbG93Og0KDQoNClRlc3Rl
ZCBNYWNoaW5lDQotLS0tLS0tLS0tLS0tLQ0KICBJbnRlbCBTYXBwaGlyZSBSYXBpZHMgc2VydmVy
IHdpdGggMiBzb2NrZXRzLCBlYWNoIGNvbnRhaW5pbmcgNDggY29yZXMsDQogIHJlc3VsdGluZyBp
biBhIHRvdGFsIG9mIDE5MiB0aHJlYWRzLg0KDQoNCk1pY3JvY29kZXMNCi0tLS0tLS0tLS0NCiAg
YSkgTWljcm9jb2RlIHJldmlzaXNvbiBvZiBDUFUgICAgICAgICAgICAgICAgICAgICAgICA6IDB4
YWIwMDAxMzANCiAgYikgTWljcm9jb2RlIHJldmlzaW9uIGluIHRoZSBpbml0cmFtZnMgICAgICAg
ICAgICAgICA6IDB4YWIwMDAxNDAgLy8gZm9yIGVhcmx5IGxvYWQNCiAgYykgTWljcm9jb2RlIHJl
dmlzaW9uIGluIC9saWIvZmlybXdhcmUvaW50ZWwtdWNvZGUvKiA6IDB4YWIwMDAxNjAgLy8gZm9y
IGxhdGUgbG9hZA0KDQogICAgIFsgTWljcm9jb2RlIGIpICYgYykgaGVhZGVycyBib3RoIGNvbnRh
aW4gbWluaXJldiAweDJiMDAwMGExLiBdDQoNCg0KRG1lc2cgbG9nDQotLS0tLS0tLS0NCiAgLy8g
RWFybHkgbG9hZCBPSy4NCiAgWyAgICAwLjAwMDAwMF0gbWljcm9jb2RlOiB1cGRhdGVkIGVhcmx5
OiAweGFiMDAwMTMwIC0+IDB4YWIwMDAxNDAsIGRhdGUgPSAyMDIyLTExLTA0DQoNCiAgLi4uDQog
IFsgICAyMC4yNjE5MjZdIG1pY3JvY29kZTogTWljcm9jb2RlIFVwZGF0ZSBEcml2ZXI6IHYyLjIu
DQogIC4uLg0KDQogIC8vIExhdGUgbG9hZCBPSy4NCiAgWyAgIDI3LjQwMDg1OF0gbWljcm9jb2Rl
OiBVcGRhdGVkIHRvIHJldmlzaW9uIDB4YWIwMDAxNjAsIGRhdGUgPSAyMDIyLTExLTE2DQogIFsg
ICAyNy40MDk5NzhdIG1pY3JvY29kZTogbG9hZDogdXBkYXRlZCBvbiA5NiBwcmltYXJ5IENQVXMg
d2l0aCA5NiBzaWJsaW5ncw0KICBbICAgMjcuNDA5OTk3XSBtaWNyb2NvZGU6IHJldmlzaW9uOiAw
eGFiMDAwMTQwIC0+IDB4YWIwMDAxNjANCg0KDQpjcHVpbmZvDQotLS0tLS0tDQogIGNhdCAvcHJv
Yy9jcHVpbmZvIHwgZ3JlcCAtbTEgIG1pY3JvY29kZQ0KICBtaWNyb2NvZGUgICAgICAgOiAweGFi
MDAwMTYwDQoNClRoYW5rcyENCi1RaXV4dQ0K
