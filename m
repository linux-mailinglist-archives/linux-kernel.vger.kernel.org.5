Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE118062F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjLEXZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjLEXZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:25:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575F6122;
        Tue,  5 Dec 2023 15:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701818761; x=1733354761;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=01vhjvExvCyDnUWI+HUuNgQ6ve0OkqHkG7WtL9E5hsI=;
  b=SkLeUlCUZdOMDioh93isr4142saiqejpU6a1h4c8It5R0+uvdtyPNvdu
   fQhQE6+giiIAjv4TTc1wj3xiLLC3AuGQdJhhZBwkKjRF4eKkObDZsIeAy
   HC5+tGstn449bSQYk9v3MjMAO3mIDPLsYcMuLiOYy/rlqSyX/c19w99wr
   li5dNWeybbJZrpmZPOwyL6UGagCLZByYwW+Vx0KNwjh1JAR7xIYAXG1kT
   H3YGFvm51i61LeriJKKNFEaFEsK2EFR55o8fXouD/AAqUoXy2XFsOkiFI
   z3RcF5D5i9ACAVvhb0jIoIupKjfriElmxjw3jenKAaWKiWyE19RzePDWE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="374156631"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="374156631"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 15:26:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="914971272"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="914971272"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 15:26:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 15:26:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 15:26:00 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 15:25:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3ilY+bbKacsB+E59yF1FpmciAPJaAVTfFVe50N4j9ruMu2fnOgM94fRCx6TdUMcIEW1UicCWHuhxxmpGc0S2+W5Ch65NR0e9n5HUqaUGVIGtHZ9G4CSU1S0GXztJNZiYy412XU1heV6bP408RDj0FnmnKX9Yh98cqK8NNdGsxeRvzaAY21sTQZlqUcfRnwvgcdJYgVti8YOr9L3G9I7/HbuPWVdgADAUpdCx900i5iUSc/9OelJy075r9SwpO+fdtNehDiHzhW58j48v+yUAyba1RzAfL/EP89g4EKevM9sxCaRmRQFtp8PViqEREVLxZUceRuuzc4iPB/oEcmLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApewfYvbvG+QR4ErLJaJtcKjMHgTP6UhzylUui4XeU0=;
 b=d9mw2wLaDoJMblGD+uZviz+Yi3+PMmujRQzGCAJFfiQtzQ7yBjrDkgq0B0sqQ6gZ4/F8jDjEwFX0uuIGrPgVCEHxrl97DNeF5PnS9qDYLDpTTcAEeX6pn0bbvyofiEB6wnSI8q7ABm9JIt95DXic8kszt6YPURp4HxKNvG2hBkZoJIMjantCGUo5p/HY7DA5Bx4Y3/0eixWPGNH5OGZc86NQRPlbt8W9r6Kh6D5f0IpLGnQ36B2LpQaA/zx92O4vxOrpZ9mr5WmpEQMVsYT3moQFSByR3bCk+7I2ixjS9hIDFiHZRrpzpkh8F1a1lj/qPdZ+srAOHg4KgAPegCccxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB7680.namprd11.prod.outlook.com (2603:10b6:208:3fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 23:25:52 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%6]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 23:25:52 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC:     Borislav Petkov <bp@alien8.de>, Aristeu Rozanski <aris@redhat.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/5] EDAC/igen6: Add EDAC support for several Intel SoCs
 with IBECC
Thread-Topic: [PATCH 0/5] EDAC/igen6: Add EDAC support for several Intel SoCs
 with IBECC
Thread-Index: AQHaFg79xlMaldO9dEGBYjF4lzIXLLCbeH7Q
Date:   Tue, 5 Dec 2023 23:25:52 +0000
Message-ID: <SJ1PR11MB60835628D38AD099BE401C47FC85A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231113085318.26783-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20231113085318.26783-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB7680:EE_
x-ms-office365-filtering-correlation-id: beb33b83-73f4-470f-fa2c-08dbf5e985db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZRGl5I8D4tJjotFVH4+eMgeIuyErsTT+QLkp7PgkiNtjimZXvemXkVGuIsLo5RSYggBcxQAJa1pSBuWnRihqL+s3whq4eok360aVWerUgjJ6B04yv2HEDgObM34b056OHFeyp50Sw0fbWUYhFu88jGvGBQ2k6XyfBYVIKffj6OEaAZ41YzO/DwU9EImSx2JYD4rutdDc682Q2Dd8NptKVJu7E9B46Fo74c5va5RhKUdfTzMa9CeFz62fpRH6By4x9Bma+jwk1iXApH8Pz3Zeo79ojQeTUjZn7zMTaRVfTNHR5QG0x66D4/fIRfXzh+tdtZYW80muJEYNQKLLRFLskQdF6i5bicHj7h5BozTw3IQhwzu0oCYTQADzAXZfoMt6OwbiHq1d3I3P9pcJJ6L09keaXfnpz98UvZj1tD9ZK4Ju0SymcPfxDXDgmLD03Z+e0HZXmhspE320xpJ1XARY3wlEXTeBpuTdC0RU4GA6ZK/jSaoKvdyoYVYCZCVJufCwrNmaHRY1WxeNT5+7W99MbLEIpW9V5wQOBNs/OZPXwLbLfr6jdAop84ncX35ITiG2VTQVQtuOGB/2n4pkAaW/jQDQg5Jd1CemTmtpjtqBA9zKhXA0AsEceP+7PlLaTcgS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66476007)(6636002)(316002)(66446008)(66946007)(76116006)(54906003)(64756008)(66556008)(478600001)(71200400001)(5660300002)(41300700001)(38070700009)(2906002)(33656002)(4744005)(86362001)(52536014)(4326008)(6862004)(8936002)(38100700002)(83380400001)(82960400001)(26005)(122000001)(8676002)(55016003)(6506007)(9686003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9cvjX9f8IrPal82htcxsjRfxnLpY59VrKOqMWQ6IABRE+QhEdZEfeV237mQo?=
 =?us-ascii?Q?6X68DksrS8Q1DUgKm6KNeeySM6fzANfdXStMhsT5ZhIp84IyQU4S+PW1SL1p?=
 =?us-ascii?Q?EUHPNXnmQo91KLHP/trrVrxSx/i0Jj3qQEmayT9by8e5tdf7VKVpgppE56RT?=
 =?us-ascii?Q?i/cA/ivqeDLKz4wDlAxvJx0TOVJnGggw0uYpZ3e121s8/rwEj37cIL1TBfNu?=
 =?us-ascii?Q?svjdSQSajCVxWASUovLHB13xgp2XUKeI2h4ruon0Ou6mti/uOPG565ouUlOz?=
 =?us-ascii?Q?6hSFfbkZNddixpQvaFEkwU7u4nSEBY2weQiFBVR+3cLhWEhpALQCcRNFRVzp?=
 =?us-ascii?Q?aYIRFLDrW8bfbKJ0OYKUFbQqz0JNawh5rT96yDePeFBhghWrSzB2fYs+AO6b?=
 =?us-ascii?Q?25Lj//aqXAu+AJ7ZohnrCjM6ZlIe4MS8jBk/GjbypB1G4eb5qXrO+x53AAUE?=
 =?us-ascii?Q?hTERRTXf6zQ2WX6Royt0X886avkjSqa8J7uczApohspbxjQ9JqkrtSqU789v?=
 =?us-ascii?Q?hfJ0mGlS+gzd8QCe4HcIOCGmEnWqV2C7E0Bw5blfUXcpwGM0ZA6I7/dwuBUA?=
 =?us-ascii?Q?35DjR0S1fvesjzjXErQpadRAijNpqhsmUCwRPcJ6CUSunaViASL8IAYXpw+h?=
 =?us-ascii?Q?7kOXyjOy1X0GOkeTnVl1bOXBAWRy+KsyTKqNeCcBpE1YlmOgVn2WIYYl8hId?=
 =?us-ascii?Q?IaeZzHrBvHi1lGn/u4s79i6sPNV/YbSfZlsJWOkF2epNnGq2Eb3MiBnCZH/i?=
 =?us-ascii?Q?PBFsc7VJJu3hdGcyWtLmbbg0Bj4r1WWJEiBRvmm5n5JKcPZxZA91+5x0xm0d?=
 =?us-ascii?Q?5Q8u2OnbttnkQjl4VLoBV3ctSKpiTxBGomb1BwskOmHVBZ136FZPWuDPeWG4?=
 =?us-ascii?Q?DTTDFMoHjzU4koseDJh0V9gJ1hZf6tk42M6aIXqpjEnAwxqCwXSxv0RDdvSl?=
 =?us-ascii?Q?Qw8PHQMe/4agev6pUgXAtX7jYoYI9/hgnHjgYh6zXiRjkiMhoIN5ONDD/nDx?=
 =?us-ascii?Q?H74sfnUXZV7bvCTgY/2AzF4j7M+udWKQ8axabXYpGUM3ANPyWxhAouPd8b2S?=
 =?us-ascii?Q?1MWxGtMSJxLUYFyIW5dxTmhTMriIj5igEk4f+I6WqGzIUfe7xAyKx52Nl/2N?=
 =?us-ascii?Q?qACson6+lX1V+13NoPnGOlOXNA9asI/uE2OTtkRhRAJ09Qozp/ahNnJrKqE9?=
 =?us-ascii?Q?mH2VoDVE8GlweP7zfrY3atqnG35dexREZULn7Hfy0V/cezJxSi8j2uQJoFA2?=
 =?us-ascii?Q?KAkRNpEjn5SRlMq9YyabMJU5dmF+YVnJpIfySnJ46F67VIQ5WSuE9kXp8c88?=
 =?us-ascii?Q?gno4jUTHtOAuLlHQufHnJpBRMhBysoKA4b7YZbYpatkzLwUiEGWr/kuZ+7AA?=
 =?us-ascii?Q?8ss0CQnyfuMeJ4CvKc3YHRXmgZwk5+BhKp/QCc1PkTxrDlE/D2ONSsjFiN2t?=
 =?us-ascii?Q?+4XJlJE5FmInS9SDaMGAUbMD6VzEh5hXgcNDwDmmO9Vp0ofzD4tBm+ivAmJB?=
 =?us-ascii?Q?0uzYubw1PI//Z/0/aD8OeSDN2wARLltSzbPDU9rXRQkrcKm0tacvUjAtTxYW?=
 =?us-ascii?Q?VvD3viX0D9jPuQpqEcTU12Lcm4OU7hoM+Cn8+ZXA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb33b83-73f4-470f-fa2c-08dbf5e985db
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 23:25:52.4871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfVBGTM59YfBLtznMChr17tLbd/TJHwRJnBrKqusRzyKXPIGz6pHNGGdqNlshZb6wxv+KpnagXZSjFprtlyOaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7680
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

> As these SoCs share similar IBECC registers, most of them are having
> compute die IDs added for EDAC support. There are some minor differences
> among them regarding IBECC presence detection, the number of memory
> controllers, and the most significant bit of the error address.

Applied series.  Thanks.

-Tony
