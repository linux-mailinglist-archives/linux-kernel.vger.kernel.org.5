Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43935769729
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjGaNG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjGaNFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:05:55 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19D32110;
        Mon, 31 Jul 2023 06:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690808715; x=1722344715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q2EScVu5xQwFbpZhtg4XSkxNFRub1ScVSfbZWkXhYOA=;
  b=Jx/nSFEOF3esOcZLGbll9SW4JlDZ+IQFAvqNDhK43pGOYhxjN4p0cXkL
   oy1ujJzkdQ+tXbBLyACyhUi+rRSZUSoF0JI2bKu2OOWtK34eDn5AUD2su
   kUQSePWiML1xi8a51VSE8OQSpK1vPxCLdXluUZt91doM2zpnhNKh5l+6K
   rK0Ckp7wLEurhEjizwKXyeaU+CSN2yASOfb36xBrfmVeGcpZocvI6sZAz
   Ykq6eSgE3o/AMV2JY4luDQ+H6O1Lmt+SuJR+m1p1tNSg8LJbhOvdIcqGW
   hJzhX4ZO6G8js9/F6m90aQhhog1dniWmqZFSaJpAqnAXJIlAmoJghYYUl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="432828945"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="432828945"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 06:04:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="902126234"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="902126234"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 31 Jul 2023 06:04:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 06:04:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 06:04:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 06:04:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwgSs63WXaToL6vdXIDXTQwcaMaGTPWLkhMcMVaswP0Sfb1ej6dSnP77wUe9UCZ/7iFNc7w2UDds2qvoccB6q5Bfi+jyBjI6v63nIAHQtQT+Ty75l31NJFIwHoRu+nielp1Y+vt7LoM7sxZaRSQ4vF/ZmpZmp9GFE8a/717Gje1IzifXQCCBl+a7KreXAPBhi5QkQlt9ZInCt1G6BxsT2M8++FYgbwbhUZ1AggD4bGOXjQNIiymmC8ejJy1x5oYxKd5xGqz1QNRQR50GsGjGTqPlDtkz0Af5kpN4Pluc4rKB7KovQsDL1R6shWnZ/kN3iD2Bgxka7Z/GnchvqV6zDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2EScVu5xQwFbpZhtg4XSkxNFRub1ScVSfbZWkXhYOA=;
 b=VI3ZeEq9d4C54UHh5KTyU7uGVjp1ePTyW2Aqkuvr87OMHSOqfys0xV01BtoYH15fDQceTUVZqAm3hWJfskchmN0ylaQdMxClrtyP33FSf4FnbgtLBmXqjtz1ZjNN1BSfyOUCPQ6OiJV7ADaYRlwKC+1OPFuv89bNvOFC/zfb7QlF7Rs4UwwEEh4ypvKwC7bS+LCXM0yZ5FSNPqMiqsiVbQXJLqcJtID1dzZx7QhEdbk0RNxq3vmJ+3DFlsAFBQmI835e3Bv0d8ChvhM6WE4Fddf1ALVLRjrRC3W8vDMh8zTvy9U3XrhQHb6XMU9fOu2a+3m8DiWM3yiS5AGiYLf2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CO6PR11MB5585.namprd11.prod.outlook.com (2603:10b6:5:356::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 13:04:01 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::75c5:4a90:a6c3:9d8d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::75c5:4a90:a6c3:9d8d%7]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 13:04:00 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tang, Feng" <feng.tang@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH] x86/acpi: Ignore invalid x2APIC entries
Thread-Topic: [RFC PATCH] x86/acpi: Ignore invalid x2APIC entries
Thread-Index: AQHZrQJTJL9E7mymmECwrZIZTwsK5K/PSoYAgABB5ACAAPBKAIADiDiA
Date:   Mon, 31 Jul 2023 13:04:00 +0000
Message-ID: <613df280116378115585d0c483f7e186cffaeb58.camel@intel.com>
References: <20230702162802.344176-1-rui.zhang@intel.com>
         <87jzukqjvf.ffs@tglx>
         <84216c743c6368691bc3fae924c6cbd33805ca9b.camel@intel.com>
         <87pm4bp54z.ffs@tglx>
In-Reply-To: <87pm4bp54z.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CO6PR11MB5585:EE_
x-ms-office365-filtering-correlation-id: bda69d29-ed56-4cf6-7745-08db91c69bd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xVERKIXu7O970uwaeN7gnk9PZbj9UHho4lLXNQOnH2tAaeOiK7qnwcDZomlGi0CUIac7QeOSxSNSoewKMLRpzZU+qeSCoIjx+pMSRqAayXwlQCTPOIDZu/wBuv7x1VFfH2Pypr9zIKEOamsCIih2cbWRjIf85X5HrXpnbGducNPEWO+wDcPQXdwj2eyO5FCVz6enGiLqyOih+1+XG00PU84YHT+cqJ8GKUiVdO7jRtl5Lr3dfnEYJkS8REJHY48/PfnUaZitBaVvfIxdNqvszqBSlLpc9NDAnUgx0Jg9XTd+CaIMODL39PY1jl8MJJwcYKY581mCGJUrF2IhbvyOYmpiYMjQENc/USEBLKyeGdGqAtQJcfZRcI1zlhwZsxysXKQTat8ov54GX7Qmk4f+qfK8fDj3h6r0/0Fq0ajIb03UUUeRE366EKwr9SEUjwX7jS86WQmCAvFxPUVcJnOzW7TInK0NmkqBUfEx7yOozKOMX7kXzvoTCYL6xdh17hGeD2knvKVuFLwI8hrFGqXvj1eofmdAcOUgm3yvBXOxWUa1BHAnVGPnfVLOBeUhqJ/zaUNaCJF17nPCkxDqxPtJJTQB5OzFaUgnG4F+5U9XJPc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(38100700002)(82960400001)(122000001)(86362001)(38070700005)(36756003)(6512007)(966005)(71200400001)(478600001)(6486002)(2616005)(186003)(26005)(8936002)(6506007)(8676002)(5660300002)(66556008)(76116006)(91956017)(66476007)(66946007)(54906003)(110136005)(64756008)(2906002)(66446008)(41300700001)(4326008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkVSWXo3cXBnN1lMazlmazRYQ2VVd1dya3A2M1h2dlg3anVuNHkwZXROWHhm?=
 =?utf-8?B?RmhOZUF5YjlFUXlsQkNveExNeGlJbWxmditLZnNXaXhUL3ZucGZLK1RaSG5y?=
 =?utf-8?B?RjJKY0F2TXIzbVM1UDl3RGx6UmJQWE1ZTWVPdWFsbjRPQ2ZlY0lTSHZrbU1o?=
 =?utf-8?B?eVlRNHpIT1pjTlAva1pJR2l2WkRqTjZPa3dLbnAwVnFsYloxUFFRNUVvTGlh?=
 =?utf-8?B?OHhROGM1cWY3VHIwYjM1QWJBQmZxSEtmemErMi9UU3JCdzFIR0JmZFRtMWRu?=
 =?utf-8?B?SkNTNjVLbVhYN0QxYlh5WTdNbm9qcVZUbVovRGR3ZS9icUtMbHV5NjVrU2hn?=
 =?utf-8?B?dUJnaGZia3hmbzZWVmF4L1BBZ1ZVcDBXUmNQRDFMbjIyMWJscVo3R241bTNp?=
 =?utf-8?B?TThyWGNxRW9IMTRnaGlsVlhaNUQwYlhWLzA2eTNDTDZVbXdNcCtCMUJLaUVU?=
 =?utf-8?B?czAwZDF2UTBsOG1KR1pRS1hKckkxUUVodHk4ZTBWZDhrWUkvclk5bkg0cUFs?=
 =?utf-8?B?MW9JTm5xMDQ5YWdUanUyRFJOUVd5SG43bU82Umx0VGY0c2tEV2Y0V2lrWFNx?=
 =?utf-8?B?SDR4cmZpZ2t5QlA5L3oyMEplUUhWRVcwWk9UTklSeWViRExhTmI1N3lSY1Z0?=
 =?utf-8?B?dk1DZzRBODBqR09uQkNtYmh2NTRPVzRrczBTZndBQWFTck9vMWZJL1VEU0pI?=
 =?utf-8?B?U2hVbTVSUklkeDJib0dQVHU4bkVYbDRXZ01jeEJwMENqVys5KzlDV3V4c0NH?=
 =?utf-8?B?MFZtVVFZTXpJZnAvL3dNWWp6UVhpQjV5Qk9yT2E4bFJhcG5XY3BhRVFpM0Vp?=
 =?utf-8?B?eThFREMxRmw2R3lDc0NROVdpNTVhUVZsSFVQZXBodFpYTS96RkRHZndGTkF6?=
 =?utf-8?B?Y2NzWXpHSUR3VmJtbVBHZFFHT0JuR21OM0o0MGVnRGxjYzd0aVFka1ZsRkNR?=
 =?utf-8?B?N1ZrWGFJeG1HMmMxZGxpVnhKODRoditQTFVoY2JiejAxVHZ4aUFvMi9WVjFj?=
 =?utf-8?B?T2xiNDFUbTVjb3dPU2p1a0ljWTNyNzc1c1BSNnpINVlzN29hRUVaRUswRTNX?=
 =?utf-8?B?eUZ5TUtDdzY5ZTVKbDZyRXdVck54ODR1a0hsMlFtVlZCRTFuNnRFZUdTV2xU?=
 =?utf-8?B?R1owOFlVdDZ4MVo2NXNHQlY2Y1ZWZmhlMlpMMEo5MGM5UXNnajdyQS95UXdQ?=
 =?utf-8?B?MWRqU2k0c2twcUhjWGtMcHd1cnBxaHZkTDU0bWJvdWRYOG5Bam1TdndnSGlQ?=
 =?utf-8?B?ZU1OSFFmVXN4M1lGdVlEcnhLUW5nTE82Q2pxK2dYL3l6NU9JK1VaUFVoaVo0?=
 =?utf-8?B?RjVrNWpsS3pLQ3JLWCtSNTFJUmRIL0s5UnhGTmxkekFpZEI0SHRDVmVvczlt?=
 =?utf-8?B?UTFKbmE1MXpRM2ErT2NqTjBweHliTHhVa2FKRTViRndXY0l4cjFQWUYzZnBM?=
 =?utf-8?B?Ym9QREZpRmNnL2IrVythajhGVCtwT3kvVGhqRmQxellvaUxWRDZKMm96SnVG?=
 =?utf-8?B?SHlkV2tCNXBMaGZVcGZQK2FjeVdXdVJxV0UvU01hM0lMRDY3N0hoKzZyWWhD?=
 =?utf-8?B?azZiTVVIdjhrcFdmYmxwUVdXaGlxU0xaOXhxdWdKSWtNYUU5YU5xenVVNW9i?=
 =?utf-8?B?QXNCWTcxWXdLWWlGd0J4ZmVVd1NROTJ3T1ZNcmI2S3ZIRGtJM1pJVDFZd0Q0?=
 =?utf-8?B?bEtEdU9JamtLaVU2UmJvVHkweDdYSzgvMEM1UkVLOW1nT0lnK2pFeXIxZC9n?=
 =?utf-8?B?eFJvTHZjMDU3NW43b1BQMEpPMkx3ZTNGUjM1emg4ZWsrb1k3ZEtDZDMva1F5?=
 =?utf-8?B?TmYvZEhlOXVzdnNLUjRONHJpWS80Yjc3d0JWMDNFRkkvczI4MjBPaFVWdW1Q?=
 =?utf-8?B?SDJFRWNwRGlCUDBQeVhta1gzV21JNk5nN1FEdEtCMHErdnJWQVZTME1tcEt1?=
 =?utf-8?B?NlpxN2IrTy9BSmRsNnJBSTRJKzVIRG9TcUNIK3p6MGc4MXVQQ05VUVZ0b0VM?=
 =?utf-8?B?bVNKM0tJb1FaTzdEdllsTm9oNnU5dm4yNS8yS203aGlkL1dPRkdlVkhsbGta?=
 =?utf-8?B?cGtBNVBQSVNPaTB3RVNoTGVuMlJ3SXM5b0EzdkZkUjRpMDYzV1dBWHhTT3ZR?=
 =?utf-8?Q?usUQVbgSh6gCWPDSaC5V7JWQR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12FA0D2C7B23C6468B74E30388D441D3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda69d29-ed56-4cf6-7745-08db91c69bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 13:04:00.6702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kRvPWS+VD6XFp66yuqayyF/8Luou7ElDfabXhYLCGIThDA8cQJ8HU66578AjOuKcuSb0PENvHWMbLjoUczJI9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5585
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA3LTI5IGF0IDA5OjA3ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
Cj4gT24gRnJpLCBKdWwgMjggMjAyMyBhdCAxNjo0NywgUnVpIFpoYW5nIHdyb3RlOgo+ID4gT24g
RnJpLCAyMDIzLTA3LTI4IGF0IDE0OjUxICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6Cj4g
PiA+IEFzIHRoZSBjYWxsIHNpdGVzIGR1cmluZyBNQURUIHBhcnNpbmcgaWdub3JlIHRoZSByZXR1
cm4gdmFsdWUKPiA+ID4gYW55d2F5LAo+ID4gPiB0aGVyZSBpcyBubyBoYXJtIGFuZCB0aGlzIGlz
IGEgcHJvcGVyIGRlZmVuc2UgYWdhaW5zdCBicm9rZW4KPiA+ID4gdGFibGVzCj4gPiA+IHdoaWNo
IGVudW1lcmF0ZSBhbiBBUElDIHR3aWNlLgo+ID4gCj4gPiBZZWFoLCB0aGlzIGNhbiBmaXggdGhl
IGR1cGxpY2F0ZSBBUElDIElEIGlzc3VlLgo+IAo+IFdlIHdhbnQgaXQgaW5kZXBlbmRlbnQgb2Yg
dGhlIGJlbG93Lgo+IAo+ID4gQnV0IGZvciB4MkFQSUMgQ1BVcyB3aXRoIHVuaXF1ZSBBUElDIElE
LCBidXQgc21hbGxlciB0aGFuIDI1NSwKPiA+IHNob3VsZAo+ID4gd2Ugc3RpbGwgZW51bWVyYXRl
IHRoZW0gd2hlbiB3ZSBhbHJlYWR5IGhhdmUgdmFsaWQgTEFQSUMgZW50cmllcz8KPiA+IAo+ID4g
Rm9yIHRoZSBJdmVicmlkZ2UtRVAgMi1zb2NrZXQgc3lzdGVtLAo+ID4gCj4gPiBMQVBJQzogQVBJ
QyBJRCBmcm9tIDB4MCAtIDB4QiwgMHgxMCAtIDB4MUIsIDB4MjAgLSAweDJCLCAweDMwIC0KPiA+
IDB4M0IKPiA+IHgyQVBJQzogQVBJQyBJRCBmcm9tIDB4MCAtIDB4NzcKPiA+IAo+ID4gIyBjcHVp
ZCAtMSAtbCAweGIgLXMgMQo+ID4gQ1BVOgo+ID4gwqDCoMKgwqDCoCAtLS0gbGV2ZWwgMSAoY29y
ZSkgLS0tCj4gPiDCoMKgwqDCoMKgIGJpdHMgdG8gc2hpZnQgQVBJQyBJRCB0byBnZXQgbmV4dCA9
IDB4NSAoNSkKPiA+IMKgwqDCoMKgwqAgbG9naWNhbCBwcm9jZXNzb3JzIGF0IHRoaXMgbGV2ZWzC
oCA9IDB4MTggKDI0KQo+ID4gwqDCoMKgwqDCoCBsZXZlbCBudW1iZXLCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSAweDEgKDEpCj4gPiDCoMKgwqDCoMKgIGxldmVs
IHR5cGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgID0gY29y
ZSAoMikKPiA+IMKgwqDCoMKgwqAgZXh0ZW5kZWQgQVBJQyBJRMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgPSAwCj4gPiAKPiA+IElmIHdlIHN0aWxsIGVudW1lcmF0ZXMgYWxsIHRo
ZSB4MkFQSUMgZW50cmllcywKPiA+IDEuIHdlIGdvdCA3MiBleHRyYSBwb3NzaWJsZSBDUFVzIGZy
b20geDJBUElDCj4gPiAyLsKgd2l0aCB0aGUgcGF0Y2ggYXQKPiA+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC84N2VkbTM2cXFiLmZmc0B0Z2x4L8KgLAo+ID4gX21heF9sb2dpY2FsX3BhY2th
Z2VzIGlzIHNldCB0byA0IGluc3RlYWQgb2YgMi4KPiA+IAo+ID4gdGhpcyBpcyBzdGlsbCBhIHBy
b2JsZW0sIHJpZ2h0Pwo+IAo+IFllcywgeW91IGFyZSByaWdodC4KPiAKPiBCdXQgSSBzdGlsbCBk
b24ndCBsaWtlIHRoZSBpbmRpcmVjdGlvbiBvZiB0aGUgcmV0dXJuZWQgQ1BVIG51bWJlci4KPiBJ
dCdzCj4gYW4gQUNQSSBzZWxmY29udGFpbmVkIGlzc3VlLCBubz8KPiAKPiBTbyBzb21ldGhpbmcg
bGlrZSB0aGlzIHNob3VsZCBkbyB0aGUgdHJpY2s6Cj4gCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGNvdW50ID0KPiBhY3BpX3RhYmxlX3BhcnNlX21hZHQoQUNQSV9NQURUX1RZUEVf
TE9DQUxfQVBJQywKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWNwaV9wYXJzZV9sYXBpYywKPiBN
QVhfTE9DQUxfQVBJQyk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChjb3Vu
dCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGhhc19s
YXBpY19jcHVzID0gdHJ1ZTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgeDJjb3Vu
dCA9Cj4gYWNwaV90YWJsZV9wYXJzZV9tYWR0KEFDUElfTUFEVF9UWVBFX0xPQ0FMX1gyQVBJQywK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWNwaV9wYXJzZV94MmFwaWMsCj4gTUFYX0xPQ0FMX0FQ
SUMpOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqDCoMKgwqDCoMKgwqDCoGlmICghY291bnQgJiYg
IXgyY291bnQpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByX2VycigiTm8g
TEFQSUMgZW50cmllcyBwcmVzZW50XG4iKTsKCkFncmVlZCwgdGhhbmtzIGZvciB0aGUgYWR2aWNl
LgpMZXQgbWUgdHJ5IHRvIGRvIHRoaXMgaW4gdjIgcGF0Y2ggc2VyaWVzLgoKdGhhbmtzLApydWkK
Cg==
