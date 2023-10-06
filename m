Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8149F7BB13B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 07:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjJFFbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 01:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjJFFbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 01:31:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7F7CA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 22:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696570305; x=1728106305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=mxHy37EXPqZfY0DQ1KtgoVlZsZtvpsxFcSdhmRHEFIU=;
  b=Y7P7x+VbxMVXmUfGa0U4RZroH/607b1MZ1sZAB3huK4UGs15DZkXNtNi
   eju+8JJNERrj3TzOU3gzls1FhgpF6+mcnXOdp8gUSXUuyamL5nMZbrZan
   VnrRcn6rzpWuxfydMCoRScZpdouXzS5sJP5yZtsjiM7xhD9M8ETHqgfyX
   tqjFsX1+WkiUpWK7UXLpgdnHwBZI2JKMyLZeKEejSBcYDvD/zKHiakNZ2
   Kg4rcAH3vPHXra7p26agzSZlCFDP2B0EzHljodl2yWnSgL00xZWnfk4F2
   F6+mg0yFkhn7Rgxl1fyznj4Xj2JjGqKRCVKtG1PEYm9BOylChH8FYUdIH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="447870173"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208,223";a="447870173"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 22:31:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="1083315749"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208,223";a="1083315749"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 22:31:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 22:31:43 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 22:31:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 22:31:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 22:31:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhuaC2DOL47z/oee5S8n/G+uKak5Mlv+KtB0vGQBw8dVYI7BEff9DJ/Vor1yMHUR4zVC/onVxjlPi4XkMkiiffibyxe/p07f/9ZidUQoKqsys6w0J1awUcxw9DkpGcxgtZYq7LRjYFNpM3i0HERIx+xuTxjxMQGVT2LcW45zrEAt0smdRnFX7cDDIrl3ARmW4ddYrPxNtUVcbQcPGL3pJWKoi5BGf8lt+D9mxo8qIwgEhbM1g42JhKjUaRdHWzvLEfQ2eXXFRZDeoOjrjthqXdS1+3DkRqJXfE63GOZk3xTm9eC+jr+lc/qyp4Hb65g76nNzef+UbpIlRHGMC85gDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yi+fbhqjkPjyJaAIADqhuO53WWUOZqqfBw5yOK6BbUo=;
 b=K3MZWFAfnG/j6cflGz6fH+jJJeHRRUATTTLAtR/gvM9x3bJMAkwXSBUC70dgMpyJjvF64KkDWRAA//3nWQTEEy3AsA+TAdJ0x/LFL8q3jItRAbOCyt1iawVHENCEckPxEfi2Bp0MrXfmKkJKt5Ai9KaILvxnRjCeIWqa4wgSzbtRVKjcZJu748LZHy6tn9HSB+NkkO3CIt+0UG2miNnbz/nFe2PkD4Ov8DRyfixC8Clg4KVV7n3UOuUcEZB7OhnE2L0W3ydaLDWw/+h5P0dx8VG3Blr/tVdJXM9dNbWdpvDAXhizf/QvAxkreE5ixg/DmXPV0eLC9M7UCC9Wt4jo/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3240.namprd11.prod.outlook.com (2603:10b6:a03:18::19)
 by MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 05:31:28 +0000
Received: from BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::ed75:93e2:fff2:e433]) by BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::ed75:93e2:fff2:e433%4]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 05:31:28 +0000
From:   "N, Pandith" <pandith.n@intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Gross, Mark" <mark.gross@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Subject: RE: PPS functionality for Intel Timed I/O
Thread-Topic: PPS functionality for Intel Timed I/O
Thread-Index: Adk0qfZfZVvAvtJ8SP+qSzpYuQsN4wAByXCAAACHHGAAAOuigAFW0rTQAAGFloABu/WBcAACXxyALcD8UoA=
Date:   Fri, 6 Oct 2023 05:31:27 +0000
Message-ID: <BYAPR11MB32405694C3C9A1DE083EA673E1C9A@BYAPR11MB3240.namprd11.prod.outlook.com>
References: <BYAPR11MB3240A86B426158623DB9983EE1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <fa3f1765-eb59-bf69-7f7b-14621caef6ea@enneenne.com>
 <BYAPR11MB3240801F21598EEFAEA79605E1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <1e02cc71-baee-1e75-9160-062d563af795@enneenne.com>
 <BYAPR11MB32408E2D9758BD01EC65FB49E1DA9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <f2788a74-19f8-8992-5b92-427c7b2a27ab@enneenne.com>
 <BYAPR11MB3240C6789B4C04F3BDAE34D5E1A39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <f8a97493-a5ab-565f-825a-dd0a508f2b66@enneenne.com>
In-Reply-To: <f8a97493-a5ab-565f-825a-dd0a508f2b66@enneenne.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3240:EE_|MN2PR11MB4517:EE_
x-ms-office365-filtering-correlation-id: 5a9334cd-47df-4310-2a16-08dbc62d7d47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L4CGrbEQ5fbqLKYinoPICX195NIFLrjZ9Fb8BE9awHiYXIQtghOxf7J/8eeO5ajoZKVzaFdERLaGIGReT0ShszKSGSpfZPmmZNwx8/PfDZp5LjHdHny09aTJwI8w+doyKX37OQOtll19z5kgJ9M5Wzud24ZedrIawnocCteJUtck02GKEjz9S1ACqWINNp7E/8YNq7LQm8D4Hx1X8B7W3QB9ioEa26h/ZdTiXXj4/wWEXhIjHMaHBPAGFarKC3UNFfN/ilWDqP9Nuc8D3yUkZDfYj+EQk129unrg9hYyEwIMy+Dx8pkEnK1/E//ahTr0pDbAregkQJsMM/A6CbfVKT2Y0JOaDZ/aB3kbqpvV8HUxdIHrwD6kmx4U8I2EzcONB0IVrBTZsJT7pJ5uzHh1y71lzzW9asfpWRsR/i7eyt0fSRuWPvmCMoQfieorFNuiy3jxFOZui1zC8jHNfU9qFJ8SyV/aZuKgdU7MbB6lYq6X8lqkLJcx1P/iHdampXKBj4iImh5ydmWpghYuYqGKXyCATSxI5hHZ7/Oy8UcdUKwkzgHWTY+P8BW7YA6JL6ISZSHNHUis61QuDd4tIWSR0dCjYQDAVlxvX7li02MSAsuKwfNQ6pwNxlv3QEqXIKIJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3240.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(55016003)(41300700001)(82960400001)(9686003)(7696005)(6506007)(122000001)(99936003)(38100700002)(38070700005)(33656002)(86362001)(2906002)(83380400001)(5660300002)(52536014)(4326008)(8676002)(26005)(478600001)(54906003)(53546011)(8936002)(66476007)(66446008)(64756008)(66556008)(66946007)(76116006)(316002)(71200400001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkhSTDN6dEdhc2ZKSjJNZWVhVUZobDBMWEhxSGNTZmNwc3JEdTl4WmdNREhM?=
 =?utf-8?B?OURyNzFBd2xYTzJpVFF5bFhhNHQ3QTd4Qk9ROHNBSWdDbGplREkrb2RJTUkw?=
 =?utf-8?B?WVI0Lyt3NENjSUNQVXVKazJSSGpqUTVxODk4VGE1c29oVE1YVTNPeFhka1pY?=
 =?utf-8?B?WktNbnZ5Zmw3ZUMwYUhaNUp4My81QTBUK0tmNE5qeXptLzhvcEora0VkS2Y0?=
 =?utf-8?B?QVVUY2xEd1FybTBXNkU1ci9nMTZmTGtTYUlqT2ZVMENNUjdVVWtGcEtFTzJ5?=
 =?utf-8?B?TVY5NmZOZXNsMzBpS2d4aE5tekRjTDF5TmVQMFAyNDBLSEhwSE80THlmZjJO?=
 =?utf-8?B?SlkzdHdSMW5zNk14dCtxZzZnclAzR29BMXl6MXZZdWVYSStUT1pGMlFWN1di?=
 =?utf-8?B?OGhnaEZtL1ZpYzEyWVBuYThrRjRmTi9YcU1FQ2RjZVU5U3hoSFFWRjYwaVNG?=
 =?utf-8?B?eFJ0Z3A5Vnc4NWtDTzdvU2NxN2xGYUtROEY4UXRLR2o5R0J6VzNURWgycVZt?=
 =?utf-8?B?V1pJWE5PM1p3L2JPUHhXY2NaTmpPOGpuVEgrdWdObFphSVdkK24yTGNmdlc1?=
 =?utf-8?B?aXRtQW1peEZKU0JQUFlTckt6UDNPaTNQendERk9TRk1rNHJjbW9CS0hWWFR4?=
 =?utf-8?B?T2ZiclBWbFV6RmhIaWU5ZHdLVUk2cFdmLzUxelBzdW1PbGhkWXRyVlJXT1dW?=
 =?utf-8?B?NW5INDkraVNubXVJSGN5cWlwUUZkUnJ1c1VOOW9MOTQyZnBjKzVhQWtMSjFp?=
 =?utf-8?B?bkpDb3pKZU93UGtjTi9ObmJHOHR1U1dJZG9za05GRzdmTk8zQ1dsYTdnTkZJ?=
 =?utf-8?B?OVRncjRlbDhKV0VZa2syWitxeW1BMXk4M1ZXZzA4ZFhaS0p1V0prVks5VE5v?=
 =?utf-8?B?dVR4N0oyRVJJN0NIVGw1eGNXcEZhQXBucUFydnpVRHJYUWtPclI5cGJUVmRE?=
 =?utf-8?B?dUw0OXV5V2VuNEJkWXhoa3I3SFVyZ0t5MW0waWF4aWhGakhnUCtDZEJTdFB2?=
 =?utf-8?B?bFNBbmU0V29zUm96amgwTTJLdHo1K2JVLzlCdGJGdS82THM1aVNjZ284Q3Iz?=
 =?utf-8?B?TFZCZ3NrQjFRNFZIaFVuRFRQMzdVeFNkeTBGMUFWTUFSbnRrOXpsTEpvWnI4?=
 =?utf-8?B?M1BxQTVjcWNhZXNTK2xYM1dTbXhLSFc5VWwwSExFWEpYTVpKOTBEMTk3dFd6?=
 =?utf-8?B?WWN3SFFHK0VzNmw4VmZraklqdDVqYXBaTGhWU3FtSEFUUGFTRnFDT0djN2oy?=
 =?utf-8?B?c1o5WGxXZ2NHWG5XL0p1NHdnV1RvTkVvaFFNeEpDV0hMT2NrOXM1U2tFcWw2?=
 =?utf-8?B?bnlIMnNzbTBmMTNlV3FQSnVwa3JaVGM0Q3pPOXEzV1dyUWxPVTg5ZWg0YUxE?=
 =?utf-8?B?TDRPRlhOWDFiQXlwKzdiaTZwUFZyUFd5eWFsdGJWTU9CYnRYb2UweUh6K2Vu?=
 =?utf-8?B?WS9ZRGgrQnFqRmY0dHNBZVE4K1EyWDYzVEtUclNrRHdDUGxDdTFEWlYxVmtX?=
 =?utf-8?B?U3Mxcit0cFlJbUxXemxHVWJ1MldFR0swMUFwcE5CYy9WSEVvZFI1cUJhQUZB?=
 =?utf-8?B?RitQNWMzdUR6Nk9saVdIQllMcWkyTk5ya1BxQUNldXViQ0Y5d2dpS280cmRy?=
 =?utf-8?B?NkZ4NUg1TDkxaW0rb0JORHZ2bjlOOEt4QjRkTk13Ti9YZEJVWFVKcVlmZE9j?=
 =?utf-8?B?REtTbjB2S1hsdm9wRU43dlJ0cGVTQm9HNE8wTG5HT01sR1NWU0xLeDBpWG80?=
 =?utf-8?B?WXp1RnlnSnZzQzA4NkpxMFdrWVpQZ3JGdXNXcUJhdWVseU9YZ3FOWlg5RUlD?=
 =?utf-8?B?SXRlTGw2Nk9uWXVOd2xJZzFQRlZ4c3hqY2FBdUZBbmRiWFpFZXpUbmhySmp0?=
 =?utf-8?B?WitHSlRzZVFaNUY4cG1uakZGY2RaUlFOZWNudVBDVndvY2VwUm81YTZsTGF4?=
 =?utf-8?B?RzA5NGxyWFpTUkFGWDYwWWh0K0xJUVVNenFDU0lJUzFqOXlWS0IrVEs2UU1I?=
 =?utf-8?B?NnJuMjRpR2puTDc2V2luUjB4MXJodDF3YXFqZHU4MFlCZ2hsUlNKTy8rOUZm?=
 =?utf-8?B?OXNPU2E2cjdJeG8vZmdzY2w1bUhkMjBCQjUzTUVjZ0xzVUdNQTV0Q05JYnpn?=
 =?utf-8?Q?+AI18/VmG+KfGVhs+WcP57VPf?=
Content-Type: multipart/mixed;
        boundary="_002_BYAPR11MB32405694C3C9A1DE083EA673E1C9ABYAPR11MB3240namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3240.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9334cd-47df-4310-2a16-08dbc62d7d47
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 05:31:28.0463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iG/Ygz551lNP7/1bXS2XqLYlFH9MajzO2722AHE7bAilR0nHvZBSkeYFomlqVT7olEt6KmEvRua+cr0etjh1dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_BYAPR11MB32405694C3C9A1DE083EA673E1C9ABYAPR11MB3240namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9kb2xmbyBHaW9t
ZXR0aSA8Z2lvbWV0dGlAZW5uZWVubmUuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5
IDE1LCAyMDIzIDE6MTYgUE0NCj4gVG86IE4sIFBhbmRpdGggPHBhbmRpdGgubkBpbnRlbC5jb20+
DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTYW5nYW5uYXZhciwgTWFsbGlr
YXJqdW5hcHBhDQo+IDxtYWxsaWthcmp1bmFwcGEuc2FuZ2FubmF2YXJAaW50ZWwuY29tPjsgRCwg
TGFrc2htaSBTb3dqYW55YQ0KPiA8bGFrc2htaS5zb3dqYW55YS5kQGludGVsLmNvbT47IFQgUiwg
VGhlamVzaCBSZWRkeQ0KPiA8dGhlamVzaC5yZWRkeS50LnJAaW50ZWwuY29tPjsgSGFsbCwgQ2hy
aXN0b3BoZXIgUw0KPiA8Y2hyaXN0b3BoZXIucy5oYWxsQGludGVsLmNvbT47IEdyb3NzLCBNYXJr
IDxtYXJrLmdyb3NzQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFBQUyBmdW5jdGlvbmFsaXR5
IGZvciBJbnRlbCBUaW1lZCBJL08NCj4gDQo+IE9uIDE1LzAyLzIzIDA4OjA5LCBOLCBQYW5kaXRo
IHdyb3RlOg0KPiA+IEhpIFJvZG9sZm8sDQo+IA0KPiBIZWxsby4NCj4gDQo+ID4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFJvZG9sZm8gR2lvbWV0dGkgPGdpb21ldHRp
QGVubmVlbm5lLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSA2LCAyMDIzIDQ6MTcg
UE0NCj4gPj4gVG86IE4sIFBhbmRpdGggPHBhbmRpdGgubkBpbnRlbC5jb20+DQo+ID4+IENjOiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTYW5nYW5uYXZhciwgTWFsbGlrYXJqdW5hcHBh
DQo+ID4+IDxtYWxsaWthcmp1bmFwcGEuc2FuZ2FubmF2YXJAaW50ZWwuY29tPjsgRCwgTGFrc2ht
aSBTb3dqYW55YQ0KPiA+PiA8bGFrc2htaS5zb3dqYW55YS5kQGludGVsLmNvbT47IFQgUiwgVGhl
amVzaCBSZWRkeQ0KPiA+PiA8dGhlamVzaC5yZWRkeS50LnJAaW50ZWwuY29tPjsgSGFsbCwgQ2hy
aXN0b3BoZXIgUw0KPiA+PiA8Y2hyaXN0b3BoZXIucy5oYWxsQGludGVsLmNvbT4NCj4gPj4gU3Vi
amVjdDogUmU6IFBQUyBmdW5jdGlvbmFsaXR5IGZvciBJbnRlbCBUaW1lZCBJL08NCj4gDQo+IFtz
bmlwXQ0KPiANCj4gPj4gTW1tLi4uIEknbSBub3Qgc3VyZSB0aGlzIGlzIGNvcnJlY3Qgc2luY2Ug
UFBTIGdlbmVyYXRvcnMgc2hvdWxkDQo+ID4+IGdlbmVyYXRlIHRoZWlyIHB1bHNlcyBhY2NvcmRp
bmcgdG8gc3lzdGVtIGNsb2NrIGFuZCBub3QgYWNjb3JkaW5nIHRvDQo+ID4+IHRoZWlyIGludGVy
bmFsIGNsb2NrcyBldmVuIGlmIHRoZXkgYXJlIHN5bmNlZCB3aXRoIHRoZSBzeXN0ZW0gY2xvY2su
DQo+ID4+DQo+ID4gVGltZWQgSS9PIGFuZCBzeXN0ZW0gdGltZSBhcmUgYm90aCBkcml2ZW4gYnkg
dGhlICpzYW1lKiBoYXJkd2FyZSBjbG9jay4NCj4gPiBUaW1lZCBJL08gaXMgYSBoaWdoIHByZWNp
c2lvbiBkZXZpY2UgKG5hbm9zZWNvbmRzKSwgYWJsZSB0byBvdXRwdXQgcHVsc2VzLg0KPiA+IFRo
ZSBkcml2ZXIgZ2V0cyB0aGUgc3lzdGVtIHRpbWUgYW5kIHNjaGVkdWxlcyBvdXRwdXQgYXQgdGFy
Z2V0X3RpbWUgaW4NCj4gPiB0aGUgZnV0dXJlLg0KPiANCj4gT0ssIGluIHRoaXMgY2FzZSBpdCB3
b3VsZCBiZSBPSy4gUGxlYXNlIHB1dCBhbiBhcHByb3ByaWF0ZSBub3RlIHdpdGhpbiB0aGUNCj4g
Z2VuZXJhdG9yJ3MgY29kZSBhbmQgYSBkZXRhaWxlZCBvbmUgd2l0aGluIERvY3VtZW50YXRpb24v
ZHJpdmVyLWFwaS9wcHMucnN0Lg0KPiANCj4gUmVnYXJkaW5nIERvY3VtZW50YXRpb24vZHJpdmVy
LWFwaS9wcHMucnN0IGxldCBtZSBzdWdnZXN0IHlvdSB0byBwcm9zZSBhDQo+IHNlcGFyYXRlIHBh
dGNoIHRvIHJld3JpdGUgdGhlIEdlbmVyYXRvcnMgc2VjdGlvbiBpbiBzdWNoIGEgd2F5IHlvdSBl
YXNpbHkgY2FuIGFkZA0KPiB5b3VyIHNvbHV0aW9uIGF0IHRoZSBlbmQuIEEgcG9zc2libGUgZXhh
bXBsZSBpcyBhdHRhY2hlZCBidXQgZmVlbCBmcmVlIHRvIHJld3JpdGUgaXQNCj4gYWNjb3JkaW5n
IHRvIHlvdXIgbmVlZHMuDQo+IA0KT2ssIHdlIGFyZSB1cGRhdGluZyBkb2N1bWVudGF0aW9uIGFz
IHlvdSBoYXZlIHN1Z2dlc3RlZCBhcyBhIHNlcGFyYXRlIHBhdGNoLg0KQ2FuIHdlIHVzZSB5b3Vy
ICJTaWduZWQtb2ZmLWJ5IiB0YWcgZm9yIGF0dGFjaGVkIHBhdGNoLg0KDQpXZSBhcmUgYWRkaW5n
IEludGVsIHRpbWVkIEkvTyBkb2N1bWVudGF0aW9uIGFzIGEgc2VwYXJhdGUgcGF0Y2guDQoNCj4g
PiBzdHJ1Y3QgdGltZXNwZWM2NCBjdXJyZW50X3RpbWU7DQo+ID4gY3VycmVudF90aW1lID0ga3Rp
bWVfZ2V0X3JlYWxfdHM2NCgmY3VycmVudF90aW1lKTsNCj4gPg0KPiA+IHRhcmdldF90aW1lID0g
Y3VycmVudF90aW1lICsgb2Zmc2V0X3RpbWU7IGN5Y2xlcyA9DQo+ID4gdHJhbnNsYXRlX3N5c3Rl
bV90aW1lX3RvX2Nsb2NrX2N5Y2xlcyh0YXJnZXRfdGltZSk7DQo+ID4gLyogVHJhbnNsYXRlIGZ1
bmN0aW9uIGlzIGRldmVsb3BlZCBhcyBwYXJ0IG9mIHRoaXMgZHJpdmVyIGRldmVsb3BtZW50DQo+
ID4gKi8NCj4gPg0KPiA+IC8qIFNjaGVkdWxlIHB1bHNlIGF0IHRhcmdldF90aW1lICovDQo+ID4g
d3JpdGVfdGltZWRpb19yZWcoVElNRURJT19UUklHR0VSLCBjeWNsZXMpOw0KPiA+DQo+ID4gVGhl
IG91dHB1dCBhbHdheXMgdHJpZ2dlcnMgd2l0aCB+MjAgbnMgcHJlY2lzaW9uLg0KPiA+IEl0J3Mg
bm90IGFmZmVjdGVkIGJ5IHN5c3RlbSBsb2FkIG9yIG5vIG5lZWQgZm9yIGRyaXZlcnMgdG8gZGlz
YWJsZSBpbnRlcnJ1cHRzIGZvcg0KPiBsb25nZXIgZHVyYXRpb25zLg0KPiA+IFdpdGggdGhpcyBk
cml2ZXIgcHJvcG9zYWwsIEludGVsIFRpbWVkIEkvTyBhcyBQUFMgZ2VuZXJhdG9yIHdpbGwgYmUg
dXNlZnVsIGluIElvVA0KPiBhbmQgc2VydmVyIGFwcGxpY2F0aW9ucy4NCj4gDQo+IEdyZWF0ISBQ
bGVhc2UgYWxzbyBhZGQgdGhlc2Ugbm90ZXMgdG8gdGhlIGZpbmFsIERvY3VtZW50YXRpb24uDQo+
IA0KPiBDaWFvLA0KPiANCj4gUm9kb2xmbw0KPiANCj4gLS0NCj4gR05VL0xpbnV4IFNvbHV0aW9u
cyAgICAgICAgICAgICAgICAgIGUtbWFpbDogZ2lvbWV0dGlAZW5uZWVubmUuY29tDQo+IExpbnV4
IERldmljZSBEcml2ZXIgICAgICAgICAgICAgICAgICAgICAgICAgIGdpb21ldHRpQGxpbnV4Lml0
DQo+IEVtYmVkZGVkIFN5c3RlbXMgICAgICAgICAgICAgICAgICAgICBwaG9uZTogICszOSAzNDkg
MjQzMjEyNw0KPiBVTklYIHByb2dyYW1taW5nICAgICAgICAgICAgICAgICAgICAgc2t5cGU6ICBy
b2RvbGZvLmdpb21ldHRpDQoNClJlZ2FyZHMsDQpQYW5kaXRoDQo=

--_002_BYAPR11MB32405694C3C9A1DE083EA673E1C9ABYAPR11MB3240namp_
Content-Type: application/octet-stream;
	name="0001-Documentation-driver-api-pps-Update-PPS-generator-do.patch"
Content-Description: 0001-Documentation-driver-api-pps-Update-PPS-generator-do.patch
Content-Disposition: attachment;
	filename="0001-Documentation-driver-api-pps-Update-PPS-generator-do.patch";
	size=1739; creation-date="Fri, 06 Oct 2023 05:30:16 GMT";
	modification-date="Fri, 06 Oct 2023 05:31:27 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5YTIxZTlmYjQ0NWI5NDczYzdlOTRiNGZmYzgxYjgyZjQ4Yzc0MGE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQYW5kaXRoIE4gPHBhbmRpdGgubkBpbnRlbC5jb20+CkRhdGU6
IFR1ZSwgMTQgTWFyIDIwMjMgMTM6MTc6MTQgKzA1MzAKU3ViamVjdDogW1BBVENIIHYxXSBEb2N1
bWVudGF0aW9uOiBkcml2ZXItYXBpOiBwcHM6IFVwZGF0ZSBQUFMgZ2VuZXJhdG9yCiBkb2N1bWVu
dGF0aW9uCgpQUFMgZG9jdW1lbnRhdGlvbiBoYXMgYSBnZW5lcmFsaXplZCBzZWN0aW9uIGZvciBn
ZW5lcmF0b3JzLiBVcGRhdGUgdGhlCnNlY3Rpb24gc28gYW55IG5ldyBnZW5lcmF0b3IgZG9jdW1l
bnRhdGlvbiBjYW4gYmUgYXBwZW5kZWQuCgpTaWduZWQtb2ZmLWJ5OiBQYW5kaXRoIE4gPHBhbmRp
dGgubkBpbnRlbC5jb20+Ci0tLQogRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3Bwcy5yc3QgfCAx
NiArKysrKysrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvcHBzLnJz
dCBiL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9wcHMucnN0CmluZGV4IDJkNmI5OTc2NmVlOC4u
NzhkZGVkMDNlNWQ4IDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvcHBzLnJz
dAorKysgYi9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvcHBzLnJzdApAQCAtMjAwLDExICsyMDAs
MTcgQEAgR2VuZXJhdG9ycwogCiBTb21ldGltZXMgb25lIG5lZWRzIHRvIGJlIGFibGUgbm90IG9u
bHkgdG8gY2F0Y2ggUFBTIHNpZ25hbHMgYnV0IHRvIHByb2R1Y2UKIHRoZW0gYWxzby4gRm9yIGV4
YW1wbGUsIHJ1bm5pbmcgYSBkaXN0cmlidXRlZCBzaW11bGF0aW9uLCB3aGljaCByZXF1aXJlcwot
Y29tcHV0ZXJzJyBjbG9jayB0byBiZSBzeW5jaHJvbml6ZWQgdmVyeSB0aWdodGx5LiBPbmUgd2F5
IHRvIGRvIHRoaXMgaXMgdG8KLWludmVudCBzb21lIGNvbXBsaWNhdGVkIGhhcmR3YXJlIHNvbHV0
aW9ucyBidXQgaXQgbWF5IGJlIG5laXRoZXIgbmVjZXNzYXJ5Ci1ub3IgYWZmb3JkYWJsZS4gVGhl
IGNoZWFwIHdheSBpcyB0byBsb2FkIGEgUFBTIGdlbmVyYXRvciBvbiBvbmUgb2YgdGhlCi1jb21w
dXRlcnMgKG1hc3RlcikgYW5kIFBQUyBjbGllbnRzIG9uIG90aGVycyAoc2xhdmVzKSwgYW5kIHVz
ZSB2ZXJ5IHNpbXBsZQotY2FibGVzIHRvIGRlbGl2ZXIgc2lnbmFscyB1c2luZyBwYXJhbGxlbCBw
b3J0cywgZm9yIGV4YW1wbGUuCitjb21wdXRlcnMnIGNsb2NrIHRvIGJlIHN5bmNocm9uaXplZCB2
ZXJ5IHRpZ2h0bHkuCisKKworUGFyYWxsZWwgcG9ydCBnZW5lcmF0b3IKKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQorCitPbmUgd2F5IHRvIGRvIHRoaXMgaXMgdG8gaW52ZW50IHNvbWUgY29tcGxp
Y2F0ZWQgaGFyZHdhcmUgc29sdXRpb25zIGJ1dCBpdAorbWF5IGJlIG5laXRoZXIgbmVjZXNzYXJ5
IG5vciBhZmZvcmRhYmxlLiBUaGUgY2hlYXAgd2F5IGlzIHRvIGxvYWQgYSBQUFMKK2dlbmVyYXRv
ciBvbiBvbmUgb2YgdGhlIGNvbXB1dGVycyAobWFzdGVyKSBhbmQgUFBTIGNsaWVudHMgb24gb3Ro
ZXJzCisoc2xhdmVzKSwgYW5kIHVzZSB2ZXJ5IHNpbXBsZSBjYWJsZXMgdG8gZGVsaXZlciBzaWdu
YWxzIHVzaW5nIHBhcmFsbGVsCitwb3J0cywgZm9yIGV4YW1wbGUuCiAKIFBhcmFsbGVsIHBvcnQg
Y2FibGUgcGlub3V0OjoKIAotLSAKMi4xNy4xCgo=

--_002_BYAPR11MB32405694C3C9A1DE083EA673E1C9ABYAPR11MB3240namp_--
