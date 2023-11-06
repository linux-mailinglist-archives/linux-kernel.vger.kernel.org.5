Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4B47E198C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 06:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjKFFDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 00:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFFDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 00:03:03 -0500
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A7CB8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 21:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1699246979; x=1730782979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jy46dYsRV04Md7MYP2yngYbS6uZvO/TRAV/ni9LXrlk=;
  b=r7VvQJJ80v+GNO2BVR6hTXEy10u7v3vC4jHeGaBwPYq0g+IbueUkKdCI
   Z2DqlHrwha8csdy+VcC4lThZAECy9bxqMoDkFyLDswYpNCYNmWyeqgL87
   UmRbBS8pBxpYW8DTqNsWcTYOIjwhNIixPYgSQoFe0W2a7mUOGhpmvJllb
   sPTofibCuEyMpkVJ72GyUNU0V+0iWj+1x8oCo1hXIUqThreP13OaoDPj/
   sREq3yWlR9KAfrQd5NLXQ2VWx2VKxu7y5PgUYcMXmNAK1zq33sltz9Zay
   BPOE/VWC/xO28uvsF77WZ21TDK05vB2uo8ZrPHOd/5o/2xgo2lWdJIYrI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="101525620"
X-IronPort-AV: E=Sophos;i="6.03,280,1694703600"; 
   d="scan'208";a="101525620"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 14:02:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1JIT5Ltp0n3X7whgo+SS4PNEsmH+bloa7mvtL0Uc/HmUhd9PyzdlYsPxAwa6KAsqSqR7/HEva5m42BUJaniRdUP4lWliVAAviRy7ds4WP6c2soKLSBUFME6sLMx3EaCXwFS37YT1HBofeXunsiyektpHHG9Wp7WxrIHCDdeIQGS7c2qio3zyYN2apSXPD/SVDOlo9x8ohgaRjvG/TaIX3JclsYDG9+DzSNrmHlW5pYs7bgdGnl2+XT5mlMSaKvV/vuYKrBpssTk4EfsTlxOr5prV+aUtbdkXf6L1my3RrTSFbIHLXNWSZGDQwlKB0am6APFRgktxnWci7me0hK+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jy46dYsRV04Md7MYP2yngYbS6uZvO/TRAV/ni9LXrlk=;
 b=URddRKoFdMaZM/JHZ/IyOeZOzr7BVein9G7R1le6pEs1OjTGuN7y/IAHWznw0v+XUlhvxEwJ5oYDr+jx4XbAzFwaXV0v1BdAIYE5ylqNGBr/Bv4TnWltDpTTWJ3UJfjaKr/va0zWZ2HJvwct2GaFymy0oQ9ju45XQGL+JKlVp4LAmW4OfunduJjd0lBq3XDXSLyYbsswxqhbY1QuVf/2VKJyqaO4+ObpHYLyEcmH5i1Jt4AZ6UGd27YtRvp80jDKtfTCOlrl1MTSRYzsDzZR8nmFKiHUXvhH4lc01+PKWB2cN8Lbob4ifYTpnyAtT8lxaEm0rlZmwwS11aL9m3ne/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com (2603:1096:400:1e3::8)
 by TY3PR01MB10353.jpnprd01.prod.outlook.com (2603:1096:400:251::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 05:02:53 +0000
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::a1fc:1572:ea47:eab6]) by TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::a1fc:1572:ea47:eab6%4]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 05:02:53 +0000
From:   "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To:     "'Huang, Ying'" <ying.huang@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: RE: [PATCH RFC 3/4] mm/vmstat: rename pgdemote_* to pgdemote_dst_*
 and add pgdemote_src_*
Thread-Topic: [PATCH RFC 3/4] mm/vmstat: rename pgdemote_* to pgdemote_dst_*
 and add pgdemote_src_*
Thread-Index: AQHaDTg/jDGQjRbPtEmu3LTh584c1rBmhavjgAANNwCAAAHoMIAAErLVgAAV9TCAAWK5YoAEod1g
Date:   Mon, 6 Nov 2023 05:02:52 +0000
Message-ID: <TYWPR01MB100822A154CC1D51DEE460F0490AAA@TYWPR01MB10082.jpnprd01.prod.outlook.com>
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
        <20231102025648.1285477-4-lizhijian@fujitsu.com>
        <87r0l81zfd.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <fbca99e1-40c4-4ffd-a0a1-89728dd0b900@fujitsu.com>
        <TYWPR01MB1008262A8FCBBEF0331EB16FD90A6A@TYWPR01MB10082.jpnprd01.prod.outlook.com>
        <871qd81ttm.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <TYWPR01MB10082911F0687F0674F991F3D90A6A@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <87sf5nz7lu.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87sf5nz7lu.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NjRkOWJhNjAtYzkyOS00YmExLTllZWItODNkNWM4ZjIy?=
 =?utf-8?B?ZTg1O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0xMS0wNlQwNTowMTowMFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 3e21c74992d74a45bc9f009c650004aa
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10082:EE_|TY3PR01MB10353:EE_
x-ms-office365-filtering-correlation-id: 61ff5586-8b87-4275-c84c-08dbde85a1ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xEfzUEQ85h0RiBaOHXxWUym4ZYdIcDxktrDChW7A3J0OMrFH5SlH9PTSR3Y4KHHymlpglN7m8Z4ZCNDti8rESF98AvxIe2KvqBRHS5TbHnSbk+uAY1ca9k3anOFO6g2xrQFfcUWCl+TigEi6CPI9s3MhVqdZ812RxE66/CHNoENkHDH6vxA2Ep2sQcl4SuBGySePtYIkB6FwOgClR7ORbOj/eC/XBG6MEu/brT4KWTwHQVr4fFDrV7TWj4Ni4tPGBPc1nfOhQL0M3mGUy/7Ux7AvpyixANWC2IIU0JmXIaR2kktsrlFwKoRgLolP/J4XlsKGV1isOYHmf5Kd3sTqAQaXGN28+4Ib5HRT2HPNayTSb8Sws7eHKzjj914wKvX/r69JVQdO0o6QicjXAHe1mzxb5mEixmCs23Hi+rg2q+33fLaWBz4EzyKfoIW5akK8gfMFnROd3KliYKGRKktBiRLUKMkhHYkZWgF7nWfycvRFK6TBGKAECZs301k23iXxEXijLEIClOz55Kp5n2AQFRO6N0chj8xxalE92+5BT8B35sRNw5OdzTgI006JEQvQhClWXE54n3qocM9ePJf3gp048JITKENU+wKIrRD+Frp8fIPrDVz945ymIod2OV0Tdex9UzopReZ9yyJvoLiphmuvn8J1KTHwVIMu/IxW2lI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB10082.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(1590799021)(64100799003)(1800799009)(451199024)(186009)(478600001)(41300700001)(9686003)(6506007)(7696005)(53546011)(71200400001)(52536014)(83380400001)(8676002)(4326008)(8936002)(2906002)(5660300002)(26005)(54906003)(64756008)(6916009)(66556008)(66476007)(76116006)(316002)(66946007)(66446008)(122000001)(82960400001)(86362001)(38100700002)(107886003)(33656002)(55016003)(85182001)(38070700009)(1580799018)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dW5JbkhRUktzVHRaZi9Bd1N5cFNaYWtiWHdTU0NTMStyaUdSZCs4ZXJ3NjE3?=
 =?utf-8?B?cnhRNTdXamJFYms0WXRINDZ1WVllQ3JBeG1DeEtNWDkxdGxreXhLc3hreUpz?=
 =?utf-8?B?bm1DNy9aVFRXaytJSklKbm5ZTUhhYWFGdUpiMWZWUGZqVkIzWVFVMWdjZjVK?=
 =?utf-8?B?K3dsZml0U2RKOHYzdFBSTnRkWDBuTG1iWmxqbC9YSzFyUzAvbGNVeFprMzNH?=
 =?utf-8?B?am1DTjhJQzFJay91SytuQ3orcm45MTZIQ0x2Q2oyMEN4SWwwbUt5WmZHNFNs?=
 =?utf-8?B?dzJBbUVpS3N1UXFUUUoxUmNVY0Z5RnloMUs3aFNpdVdsL0hnS1ExYXBqWFd2?=
 =?utf-8?B?L0xGbGI4S1FFdXBzeHhXaWtLNDE0d1M5dlBVUmRRZzlsZzg3VFN0MklhK2dq?=
 =?utf-8?B?cnNhazNqREI1QnJ1K0NYL0RWV2RUN1F6V1dLcDJaUjZWaVZFV3NmUWxPODFH?=
 =?utf-8?B?cEcrbVJRNm56RnJEeDlGWE9OUE5uUm5oWVl3L0lOMXFpN2dDQk9heERxQWdQ?=
 =?utf-8?B?MGd4SzliSXErenJ4QWcxQVpKeGpudG1KT0oreWFkV1ZsWHY4dFp3S0Q5c3ph?=
 =?utf-8?B?MldkR2NodDAvd0tFOEFLRHByWW53N0V0b3E4OXhSWng2N1BtZ092eTFCb200?=
 =?utf-8?B?enZYVzZ4THZGV04vcUN2L21mcW1ib2dOY1ZiNmsyam1uWjBhMkFZRTJDU3dt?=
 =?utf-8?B?S0s2TklKOXRmS1VhcWMzQkNyU21KQzNNRUhiVHFoOWh5dkR5NnZXR3poN1pB?=
 =?utf-8?B?SEZTZ2tjVGJGaUFjMGVQL1BzZkc0QUFRKzcyYWlvZDVtakJHVnc1eFBMM1l4?=
 =?utf-8?B?NGYwU3c1b3hDUHIrbjhMSnF3MGJsQkZOTU9ZVmN5ZnFsUHdrV2xoNVgyNWZ2?=
 =?utf-8?B?UTlLTmhWNHEyeWkvcWNPOGk3NEFUci9UaE9Sc1MrNkVSTnFkbWxVSExQWVdv?=
 =?utf-8?B?RlNPVGJNTzN0bkdBZ2x5ZnU5MGtwR0Yrem1aRFZwNnZWTzBvMnRVcjE4NEpR?=
 =?utf-8?B?aUVmRUREVzJWTko1K21IUXhNVVU2dS9HajJGUWhGOUdMWHc3K2UxaFc2b2F0?=
 =?utf-8?B?S3g4Q1VxNFk0Smd1OCtFSlczMnRqZGhRZnU3dS90S3cxY3Rkc3NPbzVac0p1?=
 =?utf-8?B?cktZRFRYS09NQTJxQXg5Z0Zlb29FS29rUDVKN0t5Z3Fpc1V0Q3h6UjVZRTZh?=
 =?utf-8?B?TE40YzM2cjM3cHJhSmNRZ29YYzkzWnFJZEpiZXFBSllmY1E4dWVvQmRpby8r?=
 =?utf-8?B?NisxeVFBSklrZlBjaTIzdDQ4NHRSQlFJMVZZRTdxUjJPcG0ra3NjQmhpQ1R1?=
 =?utf-8?B?K29YNTRQdU1ZeTh1M004UFV1SG01NU4yL05jdHplTjZyQm1PSitGZVB3OUQy?=
 =?utf-8?B?ZGZweFR3eWgyZWRtY0t4amFtdWx6Y0JQTFI5YWFwL0xYYkxBUzhKK3FkZUJL?=
 =?utf-8?B?cDB6R0o1QXZvMWs1ajhyYjBCY2ZvUzB1c0ZpbEYrbjN0MUpDL3BEVDBmTmtX?=
 =?utf-8?B?aHZpUkVwb2ZDeTUrM1pxTStpVFo2UnA5UURXYzVYZlh1eG05dzdhdGJVcHlE?=
 =?utf-8?B?azIwMlYzczlucnhSUFRLRDk1VHVKOUIrVXJSUjI1WVJ3YXJiWFlKaHR2TWlQ?=
 =?utf-8?B?SW9ab2VvWlNnTk5UUFFybm1TSGJvY1BvMjRiUlFTWHhIRzZSVDVtTW1XWXlW?=
 =?utf-8?B?VlRHZERRRHpFY05EWWJYYzdMNDZLcGRkOSs4L1VBTDVualZKQ1R6a2JuWkR2?=
 =?utf-8?B?bld2MXFjTWpmbndvcWlBU3lhb3RrNW1kNmY4dlZzcGFtamtycis0MU9JWFE5?=
 =?utf-8?B?RXhXalZPbW5GcnZXUkphZXVFdVA4aGdKV3Vua00reW1tRzNkNElmTHJ6dmdY?=
 =?utf-8?B?S1pjTFJZQVc1WmtUOElvSFErekpIUStRK0tHQlg5U0pNMUJrVzJqZllnc1E2?=
 =?utf-8?B?eVg0Tmx6Z3FkRTdobExrZGpVeUgrNjZaVitPSURFYTl1Tm9YNEJkd2lEZHdW?=
 =?utf-8?B?dFpYaldWQWQ4UFpDZ3B1dGJRYzI4NzIyRUtVbXczSTlDY2x3WFB2ZVpFRDdi?=
 =?utf-8?B?TVd6TjI5NlZZcTkzV2ZQSW1NamJtZ3pCOXI4dldNQUxZNTJIdUJGbElWUzdu?=
 =?utf-8?Q?kePDngjlG7fDKCAwhDBGI8vLM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N210ODNkVkdTcVdMMHhidXZkNTdCSjR2TjBNRkQxZmxxR1UzSkhMK25RZHVP?=
 =?utf-8?B?bDVpTTlKQTl1OGd1ZDdxT1VZZXpVT01kMjlzbHdqbmFkaWp1dHVTT2phQWpH?=
 =?utf-8?B?YzRpVFgwTWJwczI1Tnp0VTBuNENTREtYSUNpTVJBY3lON2ExRGtPbmM3UmIy?=
 =?utf-8?B?eUR1b2JlTWwvRTFGdHlsZW0wdzlDU0dtYUI4anZWYXJoSWYzM2RycGVQZXdI?=
 =?utf-8?B?emk5V2hVYXpId1pMUUpJRHB2QkptMzRWQkV2T2thZ3Evbko5YkZVR3JEWHBQ?=
 =?utf-8?B?TmpkcStBUjNZRmxlZ0NCK2NoY0hSR0FEd3pTWGdmemdoTk9XV0hqY1Avakt6?=
 =?utf-8?B?N05yRHk4R1p2c0tETisxdE9pUDNtc254ajBiTW9MVTlSMG1GZ0E3SU1pZGVH?=
 =?utf-8?B?Y29vZXFuUTFNREkzc1JYV1ZlZHc5a1BCaW0zeGxOQ2trRndEY2FKZXk5R05F?=
 =?utf-8?B?d2hvQWhrRS9PcDFMbHRFQzQ5eGRxVDFMOGpEbmI2QWxJRmx4S3MreENNVHNi?=
 =?utf-8?B?bjBTN1Z6Zm10d2pjRkJETWZ1SHF1bU1yUm1Cei9WSmtnUlpWeUxVR1ZWR0tm?=
 =?utf-8?B?Si9rSXdFQzh6aTIzQzJUREJCWldJcVlpVGU0TFJIRHB5QTRCVFZJWGczcjUw?=
 =?utf-8?B?NjVEUnArdE9yT0lKajA4c2tueElDeFNoT0Fvd2gxUGliZzZ1dE5xemFQbFdG?=
 =?utf-8?B?WFEyUFE2WEFVbURTQTROb0xsdXg0dW1namM4SE1HVUZvNER4TDU4NlM3VXg1?=
 =?utf-8?B?RkVuS1JpWFZsaU05dWFaTFk4NWg3cUZUQXhIbkZDd2pvTXFQUFdZenJIb25B?=
 =?utf-8?B?OEZtU3VWbWZESHFmRDBraDNHakhERnZwdURIbjQ2Q3Bjd0IyYkh5dGNkWjcx?=
 =?utf-8?B?TTRKSVpuWkRTS3JWQXZYNVNiYXM5c05CTEF1Tmg5b2NoaWlYb3kzMHA3R1VG?=
 =?utf-8?B?OUVVTWlSRDY3MDkvcUs4VTcwUFROcHpRVjM4bmk5UnFMMk4rTGFkV01UbGJn?=
 =?utf-8?B?RUJwcDR0eDlnaXlySWlFeTJoRGRsRmRKT0dBWGcvbnFHT21lcDVrYk80OXBn?=
 =?utf-8?B?MXFkRjVnbHJqSFZ0cVVaRXNEUzJnTE1pR3hVSlYyYmhIZXNqNWFWaTNQekFE?=
 =?utf-8?B?dmM1cjg4b01pYTQrdVFmUE8wYi9sVnY1ZFdNWS9qVmF1MnJPcWhWWG82cHc1?=
 =?utf-8?B?a0pWNDJVeGpPRUt1RzFEdHVsQzlZazJKeWNPZHRkV0xrTzBubTRXZXJWOEI1?=
 =?utf-8?B?dHVtRXlHY0U5aldtV1MzT0lkcTlwWXpKK0o5a2VOeUc2MmJLUT09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10082.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ff5586-8b87-4275-c84c-08dbde85a1ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 05:02:52.9745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 664Lceh1Kst/8ZrJW7Reg6+GpRaK452w8BSBFf1PCk811+HFDtze9rnF34qBXvFpHe88FvM6zYY9rs6HYtx0+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10353
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+PiA+IEhlbGxvLA0KPiA+PiA+DQo+ID4+ID4+IE9uIDAyLzExLzIwMjMgMTM6NDUsIEh1YW5n
LCBZaW5nIHdyb3RlOg0KPiA+PiA+PiA+IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNv
bT4gd3JpdGVzOg0KPiA+PiA+PiA+DQo+ID4+ID4+ID4+IHBnZGVtb3RlX3NyY18qOiBwYWdlcyBk
ZW1vdGVkIGZyb20gdGhpcyBub2RlLg0KPiA+PiA+PiA+PiBwZ2RlbW90ZV9kc3RfKjogcGFnZXMg
ZGVtb3RlZCB0byB0aGlzIG5vZGUuDQo+ID4+ID4+ID4+DQo+ID4+ID4+ID4+IFNvIHRoYXQgd2Ug
YXJlIGFibGUgdG8ga25vdyB0aGVpciBkZW1vdGlvbiBwZXItbm9kZSBzdGF0cyBieQ0KPiA+PiA+
PiA+PiBjaGVja2luZw0KPiA+PiB0aGlzLg0KPiA+PiA+PiA+Pg0KPiA+PiA+PiA+PiBJbiB0aGUg
ZW52aXJvbm1lbnQsIG5vZGUwIGFuZCBub2RlMSBhcmUgRFJBTSwgbm9kZTMgaXMgUE1FTS4NCj4g
Pj4gPj4gPj4NCj4gPj4gPj4gPj4gR2xvYmFsIHN0YXRzOg0KPiA+PiA+PiA+PiAkIGdyZXAgLUUg
J2RlbW90ZScgL3Byb2Mvdm1zdGF0IHBnZGVtb3RlX3NyY19rc3dhcGQgMTMwMTU1DQo+ID4+ID4+
ID4+IHBnZGVtb3RlX3NyY19kaXJlY3QgMTEzNDk3IHBnZGVtb3RlX3NyY19raHVnZXBhZ2VkIDAN
Cj4gPj4gPj4gPj4gcGdkZW1vdGVfZHN0X2tzd2FwZCAxMzAxNTUgcGdkZW1vdGVfZHN0X2RpcmVj
dCAxMTM0OTcNCj4gPj4gPj4gPj4gcGdkZW1vdGVfZHN0X2todWdlcGFnZWQgMA0KPiA+PiA+PiA+
Pg0KPiA+PiA+PiA+PiBQZXItbm9kZSBzdGF0czoNCj4gPj4gPj4gPj4gJCBncmVwIGRlbW90ZSAv
c3lzL2RldmljZXMvc3lzdGVtL25vZGUvbm9kZTAvdm1zdGF0DQo+ID4+ID4+ID4+IHBnZGVtb3Rl
X3NyY19rc3dhcGQgNjg0NTQNCj4gPj4gPj4gPj4gcGdkZW1vdGVfc3JjX2RpcmVjdCA4MzQzMQ0K
PiA+PiA+PiA+PiBwZ2RlbW90ZV9zcmNfa2h1Z2VwYWdlZCAwDQo+ID4+ID4+ID4+IHBnZGVtb3Rl
X2RzdF9rc3dhcGQgMA0KPiA+PiA+PiA+PiBwZ2RlbW90ZV9kc3RfZGlyZWN0IDANCj4gPj4gPj4g
Pj4gcGdkZW1vdGVfZHN0X2todWdlcGFnZWQgMA0KPiA+PiA+PiA+Pg0KPiA+PiA+PiA+PiAkIGdy
ZXAgZGVtb3RlIC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlMS92bXN0YXQNCj4gPj4gPj4g
Pj4gcGdkZW1vdGVfc3JjX2tzd2FwZCAxODU4MzQNCj4gPj4gPj4gPj4gcGdkZW1vdGVfc3JjX2Rp
cmVjdCAzMDA2Ng0KPiA+PiA+PiA+PiBwZ2RlbW90ZV9zcmNfa2h1Z2VwYWdlZCAwDQo+ID4+ID4+
ID4+IHBnZGVtb3RlX2RzdF9rc3dhcGQgMA0KPiA+PiA+PiA+PiBwZ2RlbW90ZV9kc3RfZGlyZWN0
IDANCj4gPj4gPj4gPj4gcGdkZW1vdGVfZHN0X2todWdlcGFnZWQgMA0KPiA+PiA+PiA+Pg0KPiA+
PiA+PiA+PiAkIGdyZXAgZGVtb3RlIC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlMy92bXN0
YXQNCj4gPj4gPj4gPj4gcGdkZW1vdGVfc3JjX2tzd2FwZCAwDQo+ID4+ID4+ID4+IHBnZGVtb3Rl
X3NyY19kaXJlY3QgMA0KPiA+PiA+PiA+PiBwZ2RlbW90ZV9zcmNfa2h1Z2VwYWdlZCAwDQo+ID4+
ID4+ID4+IHBnZGVtb3RlX2RzdF9rc3dhcGQgMjU0Mjg4DQo+ID4+ID4+ID4+IHBnZGVtb3RlX2Rz
dF9kaXJlY3QgMTEzNDk3DQo+ID4+ID4+ID4+IHBnZGVtb3RlX2RzdF9raHVnZXBhZ2VkIDANCj4g
Pj4gPj4gPj4NCj4gPj4gPj4gPj4gIEZyb20gYWJvdmUgc3RhdHMsIHdlIGtub3cgbm9kZTMgaXMg
dGhlIGRlbW90aW9uIGRlc3RpbmF0aW9uDQo+ID4+ID4+ID4+IHdoaWNoIG9uZSB0aGUgbm9kZTAg
YW5kIG5vZGUxIHdpbGwgZGVtb3RlIHRvLg0KPiA+PiA+PiA+DQo+ID4+ID4+ID4gV2h5IGRvIHdl
IG5lZWQgdGhlc2UgaW5mb3JtYXRpb24/ICBEbyB5b3UgaGF2ZSBzb21lIHVzZSBjYXNlPw0KPiA+
PiA+Pg0KPiA+PiA+PiBJIHJlY2FsbCBvdXIgY3VzdG9tZXJzIGhhdmUgbWVudGlvbmVkIHRoYXQg
dGhleSB3YW50IHRvIGtub3cgaG93DQo+ID4+ID4+IG11Y2ggdGhlIG1lbW9yeSBpcyBkZW1vdGVk
IHRvIHRoZSBDWEwgbWVtb3J5IGRldmljZSBpbiBhIHNwZWNpZmljDQo+IHBlcmlvZC4NCj4gPj4g
Pg0KPiA+PiA+IEknbGwgbWVudGlvbiBhYm91dCBpdCBtb3JlLg0KPiA+PiA+DQo+ID4+ID4gSSBo
YWQgYSBjb252ZXJzYXRpb24gd2l0aCBvbmUgb2Ygb3VyIGN1c3RvbWVycy4gSGUgZXhwcmVzc2Vk
IGENCj4gPj4gPiBkZXNpcmUgZm9yIG1vcmUgZGV0YWlsZWQgcHJvZmlsZSBpbmZvcm1hdGlvbiB0
byBhbmFseXplIHRoZQ0KPiA+PiA+IGJlaGF2aW9yIG9mIGRlbW90aW9uIChhbmQgcHJvbW90aW9u
KSB3aGVuIGhpcyB3b3JrbG9hZHMgYXJlIGV4ZWN1dGVkLg0KPiA+PiA+IElmIHRoZSByZXN1bHRz
IGFyZSBub3Qgc2F0aXNmYWN0b3J5IGZvciBoaXMgd29ya2xvYWRzLCBoZSB3YW50cyB0bw0KPiA+
PiA+IHR1bmUgaGlzIHNlcnZlcnMgZm9yIGhpcyB3b3JrbG9hZHMgd2l0aCB0aGVzZSBwcm9maWxl
cy4NCj4gPj4gPiBBZGRpdGlvbmFsbHksIGRlcGVuZGluZyBvbiB0aGUgcmVzdWx0cywgaGUgbWF5
IHdhbnQgdG8gY2hhbmdlIGhpcw0KPiA+PiA+IHNlcnZlcg0KPiA+PiBjb25maWd1cmF0aW9uLg0K
PiA+PiA+IEZvciBleGFtcGxlLCBoZSBtYXkgd2FudCB0byBidXkgbW9yZSBleHBlbnNpdmUgRERS
IG1lbW9yaWVzIHJhdGhlcg0KPiA+PiA+IHRoYW4NCj4gPj4gY2hlYXBlciBDWEwgbWVtb3J5Lg0K
PiA+PiA+DQo+ID4+ID4gSW4gbXkgaW1wcmVzc2lvbiwgb3VyIGN1c3RvbWVycyBzZWVtcyB0byB0
aGluayB0aGF0IENYTCBtZW1vcnkgaXMNCj4gPj4gPiBOT1QgYXMNCj4gPj4gcmVsaWFibGUgYXMg
RERSIG1lbW9yeSB5ZXQuDQo+ID4+ID4gVGhlcmVmb3JlLCB0aGV5IHdhbnQgdG8gcHJlcGFyZSBm
b3IgdGhlIG5ldyB3b3JsZCB0aGF0IENYTCB3aWxsDQo+ID4+ID4gYnJpbmcsIGFuZCB3YW50IHRv
IGhhdmUgYSBtZXRob2QgZm9yIHRoZSBwcmVwYXJhdGlvbiBieSBwcm9maWxpbmcNCj4gPj4gPiBp
bmZvcm1hdGlvbiBhcw0KPiA+PiBtdWNoIGFzIHBvc3NpYmxlLg0KPiA+PiA+DQo+ID4+ID4gaXQg
dGhpcyBlbm91Z2ggZm9yIHlvdXIgcXVlc3Rpb24/DQo+ID4+DQo+ID4+IEkgd2FudCBzb21lIG1v
cmUgZGV0YWlsZWQgaW5mb3JtYXRpb24gYWJvdXQgaG93IHRoZXNlIHN0YXRzIGFyZSB1c2VkPw0K
PiA+PiBXaHkgaXNuJ3QgcGVyLW5vZGUgcGdkZW1vdGVfeHh4IGNvdW50ZXIgZW5vdWdoPw0KPiA+
DQo+ID4gSSByZWNoZWNrZWQgdGhlIGN1c3RvbWVyJ3Mgb3JpZ2luYWwgcmVxdWVzdC4NCj4gPg0K
PiA+IC0gSWYgYSBtZW1vcnkgYXJlYSBpcyBkZW1vdGVkIHRvIGEgQ1hMIG1lbW9yeSBub2RlLCBo
ZSB3YW50ZWQgdG8NCj4gPiBhbmFseXplIGhvdyBpdCBhZmZlY3RzIHBlcmZvcm1hbmNlICBvZiB0
aGVpciB3b3JrbG9hZCwgc3VjaCBhcw0KPiA+IGxhdGVuY3kuIEhlIHdhbnRlZCB0byB1c2UgQ1hM
IE5vZGUgbWVtb3J5IHVzYWdlIGFzIGJhc2ljICBpbmZvcm1hdGlvbiBmb3INCj4gdGhlIGFuYWx5
c2lzLg0KPiA+DQo+ID4gLSBJZiBoZSBub3RpY2VzIHRoYXQgZGVtb3Rpb24gb2NjdXJzIHdlbGwg
b24gYSBzZXJ2ZXIgYW5kIENYTCBtZW1vcmllcyBhcmUNCj4gdXNlZCA4NSUgY29uc3RhbnRseSwg
aGUNCj4gPiAgIG1heSB3YW50IHRvIGFkZCBERFIgRFJBTSBvciBzZWxlY3Qgc29tZSBvdGhlciB3
YXlzIHRvIGF2b2lkIGRlbW90aW9uLg0KPiA+ICAgKEhpcyBpbWFnZSBpcyBsaWtlbHkgU3dhcCBm
cmVlL3VzZWQuKQ0KPiA+ICAgSUlSQywgZGVtb3Rpb24gdGFyZ2V0IGlzIG5vdCBzcHJlYWQgdG8g
YWxsIG9mIHRoZSBDWEwgbWVtb3J5IG5vZGUsIHJpZ2h0Pw0KPiA+ICAgVGhlbiwgaGUgbmVlZHMg
dG8ga25vdyBob3cgQ1hMIG1lbW9yeSBpcyBvY2N1cGllZCBieSBkZW1vdGVkDQo+IG1lbW9yeS4N
Cj4gPg0KPiA+IElmIEkgbWlzdW5kZXJzdGFuZCBzb21ldGhpbmcsIG9yIHlvdSBoYXZlIGFueSBi
ZXR0ZXIgaWRlYSwgcGxlYXNlIGxldA0KPiA+IHVzIGtub3cuIEknbGwgdGFsayB3aXRoIGhpbSBh
Z2Fpbi4gKEl0IHdpbGwgYmUgbmV4dCB3ZWVrLi4uKQ0KPiANCj4gDQo+IFRvIGNoZWNrIENYTCBt
ZW1vcnkgdXNhZ2UsIC9wcm9jL1BJRC9udW1hX21hcHMsDQo+IC9zeXMvZnMvY2dyb3VwL0NHUk9V
UC9tZW1vcnkubnVtYV9zdGF0LCBhbmQNCj4gL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGVO
L21lbWluZm8gY2FuIGJlIHVzZWQgZm9yIHByb2Nlc3MsIGNncm91cCwNCj4gYW5kIE5VTUEgbm9k
ZSByZXNwZWN0aXZlbHkuICBJcyB0aGlzIGVub3VnaD8NCg0KVGhhbmsgeW91IGZvciB5b3VyIGlk
ZWENCldlIHdpbGwgaW52ZXN0aWdhdGUgeW91ciBpZGVhIGFuZCB0YWxrIHdpdGggb3VyIGN1c3Rv
bWVyLg0KUGxlYXNlIHdhaXQuDQoNClRoYW5rcywNCi0tLQ0KWWFzdW5vcmkgR290bw0KDQoNCj4g
DQo+IC0tDQo+IEJlc3QgUmVnYXJkcywNCj4gSHVhbmcsIFlpbmcNCj4gDQo+ID4+ID4NCj4gPj4g
Pj4NCj4gPj4gPj4NCj4gPj4gPj4gPj4+ICAgCW1vZF9ub2RlX3BhZ2Vfc3RhdGUoTk9ERV9EQVRB
KHRhcmdldF9uaWQpLA0KPiA+PiA+PiA+Pj4gLQkJICAgIFBHREVNT1RFX0tTV0FQRCArIHJlY2xh
aW1lcl9vZmZzZXQoKSwNCj4gPj4gPj4gbnJfc3VjY2VlZGVkKTsNCj4gPj4gPj4gPj4+ICsJCSAg
ICBQR0RFTU9URV9EU1RfS1NXQVBEICsgcmVjbGFpbWVyX29mZnNldCgpLA0KPiA+PiA+PiBucl9z
dWNjZWVkZWQpOw0KPiA+PiA+Pg0KPiA+PiA+PiBCdXQgaWYgdGhlICp0YXJnZXRfbmlkKiBpcyBv
bmx5IGluZGljYXRlIHRoZSBwcmVmZXJyZWQgbm9kZSwgdGhpcw0KPiA+PiA+PiBhY2NvdW50aW5n
IG1heWJlIG5vdCBhY2N1cmF0ZS4NCj4gPj4gPj4NCj4gDQo+IFtzbmlwXQ0K
