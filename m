Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7DB7AFC31
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjI0HiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0HiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:38:15 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B17126
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1695800293; x=1727336293;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OgLH8RSBRJ+pkK8DCq0mE9OI7V12AQxrPf+A6K9PgWE=;
  b=lQcq/kVTAFQvjVcG2tYutfgScMUiYTZ6HdEq3amT0KC0C61AB82O+DaG
   XytxhGxrBCZhWa2ujPs3eQrJRb3+l7RCmieEBIs9wnRtgcvo1mHSqC96J
   z65duNhqz7N/xHWQpj9TMz2633qz5M0euQIvoOqT2usl6GAsU3j/1Y2tM
   r4LHQvvdtGlIQfShIyl1+KvTVcnrArlr0B9Q3ti5ixsYA6ERuPsnYY7d5
   cGesBCJWSIq9yBjORxPO5oLetD3/zcLcreaERdtFdoRTENL5ZqJqi5Cng
   oZTwt3a33GTH9+Y5WT4npkKpmTxzl5UaMNeRO2UQIkTVCs+gK3ry9WEwj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="96749685"
X-IronPort-AV: E=Sophos;i="6.03,179,1694703600"; 
   d="scan'208";a="96749685"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 16:38:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT3v6aVCejPIgaDQ3iapnU7m+xBrDHMzi9mkFCX76eofW6lZ5F2qFNvb1aCF6whfCJT0ifQDnf33lqtgsDQ//5ffTe8u2av1qCzWgMASe/IeGtzUuRI//opVhv7gmIVJ9MbmqHXxwjASYoy2YEGT0uPNavDj5Wv52oZ2Noo6RvNbKCrj/sRugjmbZX+3PHhJaU4DVv7++3M/bDR91ihcSq4c+ukYpMrkh55GdqOYra2R9ezMFzwEWj3P5eQHX/Zcbfyh97xMFkFBxl/O5RaN5PBKDIjh8LGWi4NI1s4dHLgBhfbj5E+iMYsVjneHDIgjCfpGRFR6QVUYvy5+g+/GuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgLH8RSBRJ+pkK8DCq0mE9OI7V12AQxrPf+A6K9PgWE=;
 b=lxvAzGEli72EENsqFSseONKhLQPd5x1cKHjNtg1LeomZrpFFDHnoX2MkBiWQcm6KSBNvlAxF97ijelpTdbxMO0MkqbcG67E5J/MdI2PSVt6yKS4wKMiT+R/LCckshWr0y8r+k4rsduDkJpOsmgrlo545p84Zebm4rMZCZt/O5EyRcRbstdYtuRXoIVGqDguc51BxKain+GHVozz7rUmxVVawvPkur6iQx7MiOiLOCqTfSI6UiFLg9s9IqL2W25eh9OhnTg1GTsJJX4DdcdFV3nXQrx0gI5p9dfKfk8pHsDbWys69gLZckZSmzLNsjAJvCyRo80lCyg6Feh025ISd8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TY3PR01MB11920.jpnprd01.prod.outlook.com (2603:1096:400:409::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 07:38:02 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26%3]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 07:38:02 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'James Morse' <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "dfustini@baylibre.com" <dfustini@baylibre.com>,
        "amitsinght@marvell.com" <amitsinght@marvell.com>
Subject: RE: [PATCH v6 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Thread-Topic: [PATCH v6 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Thread-Index: AQHZ5y/7dMhcBEU1O0SscMSkkztzzrAuWw7w
Date:   Wed, 27 Sep 2023 07:38:02 +0000
Message-ID: <TYAPR01MB6330B8C13D26A0B7BD3076878BC2A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230914172138.11977-1-james.morse@arm.com>
In-Reply-To: <20230914172138.11977-1-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9M2ExMjMxZjItMWYxYy00ZTNlLThlMmQtY2QzOWE4MDBj?=
 =?utf-8?B?M2RmO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wOS0yN1QwNzozMjowNVo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 28d6ab3d01ba4f93861e04027edbd055
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TY3PR01MB11920:EE_
x-ms-office365-filtering-correlation-id: 69162e7b-a756-4d61-cb00-08dbbf2cae50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JqAovs4mB4M5IfpVVF/TdWeHYjki/Feg8o8ATDM2btaStB+2ETY8HEw8z3Mrh6dTmw+3CGGDY6T5mOd2Yvc2y+pSR3iIK6WJuV0q+yhYU9Hnd03jJQvMrN1T7+xJe/U8U8eOfX5S/E7IqV6wbOVVtcyIxF4JM86efh1EJfg41GWvfpSOeKHF79kns6uIhI2Cgd0694B1lO4QZcgpHzWSbDcmBq6I9UxnFqSJ9cEKAbOCApBSuWt9DlqeHS1PcoBLo7n+v2vRYoPUE84D0PvfHfngwTwEF2ejct5Je5ynkrQw0Kv3VeAQJKlLZmpKyg9fShduS0D4OFg7lwRDzi6gDUHWGFU9vsgHBopLQ5PT5gtKINLJOV0APfM5wSFKK5U1JFb5DvSf97NIN8Kvy6qq2ZFGMmJq1pEjLb4xkp3ii3K2Rnpp1KwzKm+cjSyiTEYWrzaeVinABlcCNq6qLVclZB4c9xfjTmE8OhliIXb9phGv++vRIIzyDo2eBpTbTT72NOZ3NXSjM87fo6fWgqbkrvN4c0TaGTG/jiQjw6AmQl4HxGElO8Oul+XUb+Ynhfzr9rAEx34MkjQ+DWB4Y924S1e6+7D4pI6OPH+KJbvex1d5kBSIHLgR3awSOkyyqiQVw8FNoZbjjw8EzbIZAWri9pgQScmb5rYgqWLdCiUY7no=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(1590799021)(186009)(451199024)(1800799009)(38070700005)(33656002)(82960400001)(38100700002)(85182001)(86362001)(1580799018)(76116006)(55016003)(2906002)(9686003)(66446008)(66476007)(71200400001)(52536014)(316002)(41300700001)(110136005)(478600001)(66556008)(966005)(64756008)(66946007)(54906003)(7416002)(7696005)(6506007)(122000001)(5660300002)(83380400001)(66899024)(4326008)(8936002)(8676002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dE02ZFhQa1RmajFjMFF4SUlyUFN4L0ppWEJxcFFpSG10VUZDMzArZHFCdzRs?=
 =?utf-8?B?OXNKTXh4NmNGMFQ4QTZlSkF1M1FOTjcxK09GZFo0UjIzUGhJQ2w1Y3liSnJR?=
 =?utf-8?B?Yi9ORTUydnFzNVZzL3Fmbk42VU1vQ2tWVklsVDBaZG5GK2Nad1dkRmIxZFdt?=
 =?utf-8?B?NXJCdnN0U2lzamFnTDY1ZHBvcE1FWlFvTUhGOXlSTzFZWG1NYmNYOElKTjZ5?=
 =?utf-8?B?bzFFOWhGOC9yQzZyMWIxV25FOWFOWnRmR2hFSmg4YVhZVno3S3FBYmRZWUow?=
 =?utf-8?B?d1dwM0Q1T1JHVHJ2TEU5dTRzcmU2Ri9aMlN3UHQwUUQweFlBTDRqTURiVGd2?=
 =?utf-8?B?U3Q2UUZ3U3BGRE14cUMzUjUvT2ZwSm91UU03MGZJK1pXMUNoVmtXM2dURWFV?=
 =?utf-8?B?dERSOG9pYXJCU01ndkdLWDJCVVVTU0VIOEd1MzVZeDV6NVVXblcwOEJ2aEo1?=
 =?utf-8?B?Y1lWdWgvUEtGMVVFMTRIbTVrelYzV00vQ1pjOC9BcVI4U0F4MWovQUR1K25l?=
 =?utf-8?B?eHliVGdlU2lYRExxTVV5M0pNcTgwUFlMcEJmYXZnWTNOZzFwa0l4TUlLTWxw?=
 =?utf-8?B?d3VBUVdwWGlnaHU4RFJKdWZsWHhOM1ZDdStvY0pjTHhHQ21mdWNxMnVxc1Vw?=
 =?utf-8?B?TjBnTzhRUVNwTUQ4cTVVcHJBbE1sVjAvaGZLUjl6ME5rL3dteEp2N3JQdkl4?=
 =?utf-8?B?OHB1bG5RUFdYaDJjR2Q1QzhuUUQ0ZlBjMERVWFRUY3JPRFFaS0xkWjZmcEdu?=
 =?utf-8?B?eWFDcVB6ZENSbnVhaHh6RWVBTTA4ZUEyajF3bllaQ3JnMzQ0Nnk5aXdMYzBM?=
 =?utf-8?B?ZlM4cSs4QjhyeHpMWDZZMnRVazR4Ty91ZDQ5SnJWYjlUZWxZc3pzWXFMTWpp?=
 =?utf-8?B?SGErazdZRlZFbGtZbm1aMXZjU01KZllPdFZIUWxoOGgwZ1h5NisrZllmNjdj?=
 =?utf-8?B?ckRSbWlFam9JRnpsclQ2d2o1R1RGbHRxMlFmeERtN0ZXNms2QkJwYnh5bDN2?=
 =?utf-8?B?MjJXWlJVM1lsMFg4b3pGVGUrUHl1MkJuVDQ3TG1TUXhvaXBIRVc4elZYNVBF?=
 =?utf-8?B?RHRtMHBhWW92Y3IyL3orZHZEYjFONUtRMlloU0xoZFIzandJRFd2S1cvdWJx?=
 =?utf-8?B?ZTZVTk1PK2dxaWRicWdrQ29OYzVmVStVR2pycVh0SEtyUUoyT2szbWVWci9E?=
 =?utf-8?B?Vmw3Tk9CeWVDRVFVcG9YcmZ1cXhvWktEU3pDTHU4UjdqOU16aGdxR01IRzJF?=
 =?utf-8?B?cEpIcFZPZGZHUk8venlNMlBmK3Vwc3QvY2VOUlN4QzMzNzVJdmNYaTVUZlBy?=
 =?utf-8?B?Umxwa0xaOVQ5WE1Fc25nVnVteFFZd0l1c1lOaEFVYkNDRlVkZkJTdUVBQTAv?=
 =?utf-8?B?U1RCa3NneTJWby9wMkU3VnBhMXBFM0JsNmVuY2F4R0NjMTBtYmx3TktnREZr?=
 =?utf-8?B?U0c0VU9qS1JkVVBvSXRQWGhyVlc3Q081TUw4Q1NQQklwalo1ZGg2MENHb0k3?=
 =?utf-8?B?SDFCWU4vTTU1OEo0L2NCNXNJOG91dDV5b1VGdHp5TmFaMFMrNU5rU3lOd2U1?=
 =?utf-8?B?M3N6bDRGbjRDYWhrT2dTeXlXY2Q1L2I1VFdQUHlvbWs1WUlCTk9WTnlqVWlm?=
 =?utf-8?B?eWlDYkcyc3BzVm1MQW5vV1dOQlF1OGpyVG53Q2NBM2JtQUdJak5WbTdZY1Zh?=
 =?utf-8?B?YU1iTkpFdm9jRXF5R01WQnBQZkE5eVpCdU9GVXNtMzhQTVZvejZLenBGQmth?=
 =?utf-8?B?WnR6TDk0cUpxdVdoWTZSaXR3SWw1V05XWTNqZGROc1ZRNFVDRWN5K2FxbWhl?=
 =?utf-8?B?VWljMmhYWTE4bFY0TXo3aG1tZDNZK0RTSnRoMHdBSkR6VjI0UnRYRXh4bGJ2?=
 =?utf-8?B?MkJ2em1EalZhQU0wd3pNd0RHM3lqT1o4WThuckJFTFpZNjVxN01ZNU1pWDhS?=
 =?utf-8?B?Y0RTTzBSUUxTVHNuWHhmaFl6bW5NSVFiVEN5QWZ6NjFXKzRlRUtpbkR3bWFB?=
 =?utf-8?B?RHBENFRJWXM5M3FESlhwd2Z1bW9rVG16Y3BzRFZ3VEhzaTlCbFhFajZZeFpN?=
 =?utf-8?B?dzcxUXdobDZVZ0NuVWtCc001T0pJL0F1bzZYM3YxU0tTbHFvKzhCRWRDMHNk?=
 =?utf-8?B?SlhQWFNIM1gvVmFmc280Mnc1ZzRPcFkxazVxT2ljcEFqbGdOcnNGUENRZUQ2?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eHBHZ2dGL3R3ZzZ3bUplU3VXOUt6bkw4Wk1nUU1GRUlhSmlzS01TQm1qM20z?=
 =?utf-8?B?KzhOdDBOYmVZSDVaUUhTTVIrMytaTWtkWXRwZjZKOFhEYjFmZ3FMeU40WXVS?=
 =?utf-8?B?UlFkSEVZYVFldWNQSkpCcHBYMUdjYTZQVkNrVUk2OFFTRkQ3eSt6bFlwT25Y?=
 =?utf-8?B?VWk3WjQ2SEpyV0l0VDZiampEM1ZyVGlNL3dLblpDcnp0a0UwcWRZWlhJTEMr?=
 =?utf-8?B?OWE1OVpuOHJvVHB4NUdqQTI4d1NvRm9qSFM2b1psTkJJT1NHOXFrTmtzUEcr?=
 =?utf-8?B?dkdPVlFpclVVcDBTVUZqNmUyUUt0ZFhMMHJjS1lLM1Bxd0J1R21sZ1BmYnVv?=
 =?utf-8?B?SHNSSFc4VzhndEdZckE2YzV6a0xocDFMcTdmQ2RPRFRNTGdiL1AzdHBZcFgy?=
 =?utf-8?B?eFU0UnpaVVVERzZweFRmOU5LZFZUc0VlWE1SOWZJUVpPZWtsK2NwQlVFNTFJ?=
 =?utf-8?B?UXFlWWQ1cHlJZUU3TUdyMXcvNzlsTktPUUJ1eHRmM1l0YkRqckVYV2pDTTBV?=
 =?utf-8?B?dHBzOVZvdldiejBidTdyd3VFK0tsS29RME50a2NzTXNvbnZMdFNYeEVGWHFZ?=
 =?utf-8?B?cjRFY3NjaHBxckhZQ3dSR1ZnQlY4OGYrMTJ6cXU5UjJQRVlyR29qbTRkRlpi?=
 =?utf-8?B?RkgzZFFrUU1Hc3ZwU2JuNnE3YVU4LzFwV1R0c0lWZXczMlRudjhHd29kek12?=
 =?utf-8?B?d2pGTGNGQXV5MitDbkFHOWNBbGhMN3lsbWdQL0F1anUySFB0TlVtUm0xU3Q2?=
 =?utf-8?B?MFJhZ3BPZXYzMTJML3ZaVkdjclNoY1RpVGNMU1pGZlNQblAvcGtTUmRuNFZl?=
 =?utf-8?B?Sk51Mmx5VzVrQTZsb0czcWtITlZEcnJGeTcvYUZGaUtDNEQxam9YVkxRSzdt?=
 =?utf-8?B?TlY4dE1IZkNGVndDV0V3VktCdlRjMXBsWEZMeC81S2pYb2NtamlBUUhUUXZW?=
 =?utf-8?B?SkRac2NLU3p3d2RWM2ExS2V4Q05kRzhMT0tybGNpdDRxQm1jMTRncXoxOEJH?=
 =?utf-8?B?eXhMUDgvRE4vSVdBVHZmMVlqYTdnQWxjSUJOcVJQS3dvcVdtV0RKL2ZTU3hv?=
 =?utf-8?B?QVIyRHVNbGZ2azNtMkZyaEhGVEhkL2E2L3ZxSUlZL2NHWnd2YXBNTjZ0VTNQ?=
 =?utf-8?B?NWZNSnl1dTYzWVF6SXowQW1YcmxzQys4SllxSmFiRTAvRFpqOWFUS3pyRkNL?=
 =?utf-8?B?WWluNk9FYnpPdGxURFFWQVFhMllJeWNpNWVVMVVPNXhxNU9aRkhJdERlZndR?=
 =?utf-8?B?UE9neTRzckNkUUZjRlBpMHUvd0pkUzAvWHRpZ0Ivb1F1SDcxWnc0Qlk5VjJP?=
 =?utf-8?B?bFBUeENLdUtockIxamp3aFFOMlVlYng1Yk5QUERUZnFmQzJIMWRYY1J4OXFk?=
 =?utf-8?B?cGR1ckJDd1VhMG1aeTFZdWl5MHdOeGJwUGttSkZxT0ZPbWg2eGVqaW5jdUV1?=
 =?utf-8?B?WkpDcnhrS2I2V1hEbm1ZdmhCdEVQM1ZtcWtROEhrQmVlTHJFZFpwVEJsSFky?=
 =?utf-8?B?cG51Ry9UUnk4MlptUkFKc0daR2VycG1ISVR4NXV1amphZmJNMEhrRVdYWldr?=
 =?utf-8?B?d1Rac3c2YkY0L2tkRDMzV3A0NFYwaDUwZVBydkR2ZS8vUkllVjVlRVZGSk1m?=
 =?utf-8?B?RVNKRDJSL05LYkZ3Y2Z1eUExaENoRHJSU3RQQkUzdmRWM1NYT2hkVWZFMTk4?=
 =?utf-8?B?UXFSK0xJOXZiNVdwT29tS1VnYUgvZlowcS96QlhpSjZvYkVDWVllVVpPYnZq?=
 =?utf-8?Q?Rd85+x2/3PjXxtfXrY=3D?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69162e7b-a756-4d61-cb00-08dbbf2cae50
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 07:38:02.6801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V3SdG/3pj2Tgz3hlMh9F0R+466WetJ7W7RmBZTUzPPV70ugHJ4SgQ69q8gH82zIZmAXPftp2cD6+j3h58PtbWiDgqhNaekWAKUfjLtrZhZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11920
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gSmFtZXMsDQoNCkkgcmV2aWV3ZWQgdGhpcyBwYXRjaCBzZXJpZXModjYpIGFuZCByYW4g
cmVzY3RybCBzZWxmdGVzdCBvbiANCkludGVsKFIpIFhlb24oUikgR29sZCA2MjU0IENQVSB3aXRo
IG5vaHpfZnVsbCBlbmFibGVkL2Rpc2FibGVkLCANCnRoZXJlIGlzIG5vIHByb2JsZW0uDQoNCjxy
ZXZpZXdlZC1ieTp0YW4uc2hhb3BlbmdAanAuZnVqaXRzdS5jb20+DQo8dGVzdGVkLWJ5OnRhbi5z
aGFvcGVuZ0BqcC5mdWppdHN1LmNvbT4NCg0KDQo+IFRoaXMgc2VyaWVzIGRvZXMgdHdvIHRoaW5n
cywgaXQgY2hhbmdlcyByZXNjdHJsIHRvIGNhbGwgcmVzY3RybF9hcmNoX3JtaWRfcmVhZCgpDQo+
IGluIGEgd2F5IHRoYXQgd29ya3MgZm9yIE1QQU0sIGFuZCBpdCBzZXBhcmF0ZXMgdGhlIGxvY2tp
bmcgc28gdGhhdCB0aGUgYXJjaA0KPiBjb2RlIGFuZCBmaWxlc3lzdGVtIGNvZGUgZG9uJ3QgaGF2
ZSB0byBzaGFyZSBhIG11dGV4LiBJIHRyaWVkIHRvIHNwbGl0IHRoaXMgYXMgdHdvDQo+IHNlcmll
cywgYnV0IHRoZXNlIHRvdWNoIHNpbWlsYXIgY2FsbCBzaXRlcywgc28gaXQgd291bGQgY3JlYXRl
IG1vcmUgd29yay4NCj4gDQo+IChXaGF0J3MgTVBBTT8gU2VlIHRoZSBjb3ZlciBsZXR0ZXIgb2Yg
dGhlIGZpcnN0IHNlcmllcy4gWzFdKQ0KPiANCj4gT24geDg2IHRoZSBSTUlEIGlzIGFuIGluZGVw
ZW5kZW50IG51bWJlci4gTVBBTXMgZXF1aXZhbGVudCBpcyBQTUcsIGJ1dA0KPiB0aGlzIGlzbid0
IGFuIGluZGVwZW5kZW50IG51bWJlciAtIGl0IGV4dGVuZHMgdGhlIFBBUlRJRCAoc2FtZSBhcyBD
TE9TSUQpDQo+IHNwYWNlIHdpdGggYml0cyB0aGF0IGFyZW4ndCB1c2VkIHRvIHNlbGVjdCB0aGUg
Y29uZmlndXJhdGlvbi4gVGhlIG1vbml0b3JzIGNhbg0KPiB0aGVuIGJlIHRvbGQgdG8gbWF0Y2gg
c3BlY2lmaWMgUE1HIHZhbHVlcywgYWxsb3dpbmcgbW9uaXRvci1ncm91cHMgdG8gYmUNCj4gY3Jl
YXRlZC4NCj4gDQo+IEJ1dCwgTVBBTSBleHBlY3RzIHRoZSBtb25pdG9ycyB0byBhbHdheXMgbW9u
aXRvciBieSBQQVJUSUQuIFRoZQ0KPiBDYWNoZS1zdG9yYWdlLXV0aWxpc2F0aW9uIGNvdW50ZXJz
IGNhbiBvbmx5IHdvcmsgdGhpcyB3YXkuDQo+IChJbiB0aGUgTVBBTSBzcGVjIG5vdCBzZXR0aW5n
IHRoZSBNQVRDSF9QQVJUSUQgYml0IGlzIG1hZGUNCj4gQ09OU1RSQUlORUQgVU5QUkVESUNUQUJM
RSAtIHdoaWNoIGlzIEFybSdzIHRlcm0gdG8gbWVhbiBwb3J0YWJsZQ0KPiBzb2Z0d2FyZSBjYW4n
dCByZWx5IG9uDQo+IHRoaXMpDQo+IA0KPiBJdCBnZXRzIHdvcnNlLCBhcyBzb21lIFNvQ3MgbWF5
IGhhdmUgdmVyeSBmZXcgUE1HIGJpdHMuIEkndmUgc2VlbiB0aGUNCj4gZGF0YXNoZWV0IGZvciBv
bmUgdGhhdCBoYXMgYSBzaW5nbGUgYml0IG9mIFBNRyBzcGFjZS4NCj4gDQo+IFRvIGJlIHVzYWJs
ZSwgTVBBTSdzIGNvdW50ZXJzIGFsd2F5cyBuZWVkIHRoZSBQQVJUSUQgYW5kIHRoZSBQTUcuDQo+
IEZvciByZXNjdHJsLCB0aGlzIG1lYW5zIGFsd2F5cyBtYWtpbmcgdGhlIENMT1NJRCBhdmFpbGFi
bGUgd2hlbiB0aGUgUk1JRCBpcw0KPiB1c2VkLg0KPiANCj4gVG8gZW5zdXJlIFJNSUQgYXJlIGFs
d2F5cyB1bmlxdWUsIHRoaXMgc2VyaWVzIGNvbWJpbmVzIHRoZSBDTE9TSUQgYW5kDQo+IFJNSUQg
aW50byBhbiBpbmRleCwgYW5kIG1hbmFnZXMgUk1JRCBiYXNlZCBvbiB0aGF0LiBGb3IgeDg2LCB0
aGUgaW5kZXggYW5kDQo+IFJNSUQgd291bGQgYWx3YXlzIGJlIHRoZSBzYW1lLg0KPiANCj4gDQo+
IEN1cnJlbnRseSB0aGUgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGNvZGUgaW4gdGhlIGNwdWhwIGNh
bGxiYWNrcyB0YWtlcyB0aGUNCj4gcmR0Z3JvdXBfbXV0ZXguIFRoaXMgbWVhbnMgdGhlIGZpbGVz
eXN0ZW0gY29kZSB3b3VsZCBoYXZlIHRvIGV4cG9ydCB0aGlzIGxvY2ssDQo+IHJlc3VsdGluZyBp
biBhbiBpbGwtZGVmaW5lZCBpbnRlcmZhY2UgYmV0d2VlbiB0aGUgdHdvLCBhbmQgdGhlIHBvc3Np
YmlsaXR5IG9mDQo+IGNyb3NzLWFyY2hpdGVjdHVyZSBsb2NrLW9yZGVyaW5nIGhlYWQgYWNoZXMu
DQo+IA0KPiBUaGUgc2Vjb25kIHBhcnQgb2YgdGhpcyBzZXJpZXMgYWRkcyBhIGRvbWFpbl9saXN0
X2xvY2sgdG8gcHJvdGVjdCB3cml0ZXMgdG8gdGhlDQo+IGRvbWFpbiBsaXN0LCBhbmQgcHJvdGVj
dHMgdGhlIGRvbWFpbiBsaXN0IHdpdGggUkNVIC0gb3IgY3B1c19yZWFkX2xvY2soKS4NCj4gDQo+
IFVzZSBvZiBSQ1UgaXMgdG8gYWxsb3cgbG9ja2xlc3MgcmVhZGVycyBvZiB0aGUgZG9tYWluIGxp
c3QuIFRvIGdldCBNUEFNcw0KPiBtb25pdG9ycyB3b3JraW5nLCBpdHMgdmVyeSBsaWtlbHkgdGhl
eSdsbCBuZWVkIHRvIGJlIHBsdW1iZWQgdXAgdG8gcGVyZi4gQW4NCj4gdW5jb3JlIFBNVSBkcml2
ZXIgd291bGQgbmVlZCB0byBiZSBhIGxvY2tsZXNzIHJlYWRlciBvZiB0aGUgZG9tYWluIGxpc3Qu
DQo+IA0KPiBUaGlzIHNlcmllcyBpcyBiYXNlZCBvbiB2Ni42LXJjMSwgYW5kIGNhbiBiZSByZXRy
aWV2ZWQgZnJvbToNCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvbW9yc2UvbGludXguZ2l0DQo+IG1wYW0vbW9uaXRvcnNfYW5kX2xvY2tpbmcvdjYNCj4g
DQo+IEJ1Z3Mgd2VsY29tZSwNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEphbWVzDQo+IA0KPiBbMV0N
Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIxMDcyODE3MDYzNy4yNTYxMC0xLWph
bWVzLm1vcnNlQGFybS5jb20NCj4gLw0KPiBbdjFdDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDIyMTAyMTEzMTIwNC41NTgxLTEtamFtZXMubW9yc2VAYXJtLmNvbS8NCj4gW3YyXQ0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMwMTEzMTc1NDU5LjE0ODI1LTEtamFt
ZXMubW9yc2VAYXJtLmNvbQ0KPiAvDQo+IFt2M10NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
ci8yMDIzMDMyMDE3MjYyMC4xODI1NC0xLWphbWVzLm1vcnNlQGFybS5jb20NCj4gW3Y0XQ0KPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMwNTI1MTgwMjA5LjE5NDk3LTEtamFtZXMubW9y
c2VAYXJtLmNvbQ0KPiBbdjZdDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzA3
MjgxNjQyNTQuMjc1NjItMS1qYW1lcy5tb3JzZUBhcm0uY29tDQo+IC8NCj4gDQo+IA0KPiBKYW1l
cyBNb3JzZSAoMjQpOg0KPiAgIHRpY2svbm9oejogTW92ZSB0aWNrX25vaHpfZnVsbF9tYXNrIGRl
Y2xhcmF0aW9uIG91dHNpZGUgdGhlICNpZmRlZg0KPiAgIHg4Ni9yZXNjdHJsOiBrZnJlZSgpIHJt
aWRfcHRycyBmcm9tIHJkdGdyb3VwX2V4aXQoKQ0KPiAgIHg4Ni9yZXNjdHJsOiBDcmVhdGUgaGVs
cGVyIGZvciBSTUlEIGFsbG9jYXRpb24gYW5kIG1vbmRhdGEgZGlyDQo+ICAgICBjcmVhdGlvbg0K
PiAgIHg4Ni9yZXNjdHJsOiBNb3ZlIHJtaWQgYWxsb2NhdGlvbiBvdXQgb2YgbWtkaXJfcmR0X3By
ZXBhcmUoKQ0KPiAgIHg4Ni9yZXNjdHJsOiBUcmFjayB0aGUgY2xvc2lkIHdpdGggdGhlIHJtaWQN
Cj4gICB4ODYvcmVzY3RybDogQWNjZXNzIHBlci1ybWlkIHN0cnVjdHVyZXMgYnkgaW5kZXgNCj4g
ICB4ODYvcmVzY3RybDogQWxsb3cgUk1JRCBhbGxvY2F0aW9uIHRvIGJlIHNjb3BlZCBieSBDTE9T
SUQNCj4gICB4ODYvcmVzY3RybDogVHJhY2sgdGhlIG51bWJlciBvZiBkaXJ0eSBSTUlEIGEgQ0xP
U0lEIGhhcw0KPiAgIHg4Ni9yZXNjdHJsOiBVc2Ugc2V0X2JpdCgpL2NsZWFyX2JpdCgpIGluc3Rl
YWQgb2Ygb3BlbiBjb2RpbmcNCj4gICB4ODYvcmVzY3RybDogQWxsb2NhdGUgdGhlIGNsZWFuZXN0
IENMT1NJRCBieSBzZWFyY2hpbmcNCj4gICAgIGNsb3NpZF9udW1fZGlydHlfcm1pZA0KPiAgIHg4
Ni9yZXNjdHJsOiBNb3ZlIENMT1NJRC9STUlEIG1hdGNoaW5nIGFuZCBzZXR0aW5nIHRvIHVzZSBo
ZWxwZXJzDQo+ICAgeDg2L3Jlc2N0cmw6IEFkZCBjcHVtYXNrX2FueV9ob3VzZWtlZXBpbmcoKSBm
b3IgbGltYm8vb3ZlcmZsb3cNCj4gICB4ODYvcmVzY3RybDogUXVldWUgbW9uX2V2ZW50X3JlYWQo
KSBpbnN0ZWFkIG9mIHNlbmRpbmcgYW4gSVBJDQo+ICAgeDg2L3Jlc2N0cmw6IEFsbG93IHJlc2N0
cmxfYXJjaF9ybWlkX3JlYWQoKSB0byBzbGVlcA0KPiAgIHg4Ni9yZXNjdHJsOiBBbGxvdyBhcmNo
IHRvIGFsbG9jYXRlIG1lbW9yeSBuZWVkZWQgaW4NCj4gICAgIHJlc2N0cmxfYXJjaF9ybWlkX3Jl
YWQoKQ0KPiAgIHg4Ni9yZXNjdHJsOiBNYWtlIHJlc2N0cmxfbW91bnRlZCBjaGVja3MgZXhwbGlj
aXQNCj4gICB4ODYvcmVzY3RybDogTW92ZSBhbGxvYy9tb24gc3RhdGljIGtleXMgaW50byBoZWxw
ZXJzDQo+ICAgeDg2L3Jlc2N0cmw6IE1ha2UgcmR0X2VuYWJsZV9rZXkgdGhlIGFyY2gncyBkZWNp
c2lvbiB0byBzd2l0Y2gNCj4gICB4ODYvcmVzY3RybDogQWRkIGhlbHBlcnMgZm9yIHN5c3RlbSB3
aWRlIG1vbi9hbGxvYyBjYXBhYmxlDQo+ICAgeDg2L3Jlc2N0cmw6IEFkZCBDUFUgb25saW5lIGNh
bGxiYWNrIGZvciByZXNjdHJsIHdvcmsNCj4gICB4ODYvcmVzY3RybDogQWxsb3cgb3ZlcmZsb3cv
bGltYm8gaGFuZGxlcnMgdG8gYmUgc2NoZWR1bGVkIG9uIGFueS1idXQNCj4gICAgIGNwdQ0KPiAg
IHg4Ni9yZXNjdHJsOiBBZGQgY3B1IG9mZmxpbmUgY2FsbGJhY2sgZm9yIHJlc2N0cmwgd29yaw0K
PiAgIHg4Ni9yZXNjdHJsOiBNb3ZlIGRvbWFpbiBoZWxwZXIgbWlncmF0aW9uIGludG8gcmVzY3Ry
bF9vZmZsaW5lX2NwdSgpDQo+ICAgeDg2L3Jlc2N0cmw6IFNlcGFyYXRlIGFyY2ggYW5kIGZzIHJl
c2N0cmwgbG9ja3MNCj4gDQo+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9yZXNjdHJsLmggICAgICAg
ICAgICB8ICA5MCArKysrKw0KPiAgYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2NvcmUuYyAg
ICAgICAgfCAgNzggKystLQ0KPiAgYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2N0cmxtb25k
YXRhLmMgfCAgNDcgKystDQo+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvaW50ZXJuYWwu
aCAgICB8ICA1NiArKy0NCj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9tb25pdG9yLmMg
ICAgIHwgNDM0DQo+ICsrKysrKysrKysrKysrKysrLS0tLS0NCj4gIGFyY2gveDg2L2tlcm5lbC9j
cHUvcmVzY3RybC9wc2V1ZG9fbG9jay5jIHwgIDE1ICstDQo+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1
L3Jlc2N0cmwvcmR0Z3JvdXAuYyAgICB8IDM0NSArKysrKysrKysrKystLS0tLQ0KPiAgaW5jbHVk
ZS9saW51eC9yZXNjdHJsLmggICAgICAgICAgICAgICAgICAgfCAgNDMgKystDQo+ICBpbmNsdWRl
L2xpbnV4L3RpY2suaCAgICAgICAgICAgICAgICAgICAgICB8ICAgOSArLQ0KPiAgOSBmaWxlcyBj
aGFuZ2VkLCA4NTcgaW5zZXJ0aW9ucygrKSwgMjYwIGRlbGV0aW9ucygtKQ0KPiANCj4gLS0NCj4g
Mi4zOS4yDQoNCg==
