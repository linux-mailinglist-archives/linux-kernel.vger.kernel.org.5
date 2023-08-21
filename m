Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C90782566
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjHUIaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjHUIaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:30:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2FEB5;
        Mon, 21 Aug 2023 01:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692606601; x=1724142601;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hD3Q28V5GmbC+vqZVnU6/fb8v0Tvtfh0I/F4Ts/LsuE=;
  b=UG1luKjVcAXyJW8YLGsbBwsZZYdoDLlw5LVifIh1Dj55j+k+lPTnXVbA
   jJATbtA1tnIT1axYdsQnxN6/6XhLTWKcxdlOulUS71KkQLLyQjcVziHcV
   J5ePvIKiCZf55afDfuy8ldlb8VWxIC8cIuCvlrLTcbloPDAfopwUFXcXw
   eeRQKjGR3scrtuOx5SIKubZe8X3tQ/4MhbhcQBhLKOru0XRYBpfKowhYk
   t8+B1jV3Cf9u1P8QcxgtWjkLXF1Y1bYIT65zSA2NRxf1n2BAGXjnwE9He
   DXYMKh12rabif8zY5kEzc8t8hPb5fyI88MYjriPI4LOydOTNIl9srzPtH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="353848243"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="353848243"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 01:30:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="982391924"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="982391924"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 21 Aug 2023 01:30:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 01:29:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 21 Aug 2023 01:29:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 21 Aug 2023 01:29:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C89RCjdL342MELCzp3Pniltghf+GHQcrSpXbx22GEVS83me6BBrsxnWx66IAyr8K2P1KZfAftmqHBDjtpCQMbKA8that2Ipskzm/pMnz6DJxVT6lwAYp/Gbd3HpUVArzmiJBsrYxk6ffRrIz2Dq/RksUh/P8JBplTeokImrRpW51IgGifCztK23kNwMRfa9PfdGEEpU19i0kazyQpJb3fjqmgreecJAdVyxuUASK1+N2mYYKFiBq98KFhJmpk8Fl63h/o07MwZ39I67ocrfrIY603lMAUqytIhPVUWWDxphz7kQO8JlYbt901xUlptSwx2Y7fclWoQE0863oGQzR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bhjm0TcvaGjm/T8lOk3Cd+zUyKIXgeqH6WZCO0YwVps=;
 b=TqRC+VDpOPnk0ar7AXdrNSGpzN7dormgw2+HF4ynaMHBpMuCFcJ0hZkcVYUTVjHNcNsKXhxWl4Rve+hTnbUpZgx385OsIfMsxFaBqIFDRgYF4M6Bw/ihLY2G/17BEEn/JFuOHrzeOJoNn8WuwOpc23hNAK94sDy2nXUOsEn/7vjKiNkXukq80NXVmWRwfCnpfAG9u4BoA1GLG+CEqTHTl+1MZ/rvkf8ZsoVwsUm+UovurIHGCONyfSadXpwLPVWNLmcZiVQvKUoZriH+YmdGnELXmP+f/MFxNqOrpoRUdIQJU4hgJfsieeXoeqnf7mYtwZtipPitKSS5GI0pjwjN+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by DM4PR11MB6215.namprd11.prod.outlook.com (2603:10b6:8:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 08:29:57 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2a21:609b:312:5cac]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2a21:609b:312:5cac%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 08:29:57 +0000
From:   "Romanowski, Rafal" <rafal.romanowski@intel.com>
To:     poros <poros@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "Laba, SlawomirX" <slawomirx.laba@intel.com>,
        "przemyslawx.patynowski@intel.com" <przemyslawx.patynowski@intel.com>,
        "Maziarz, Kamil" <kamil.maziarz@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Zulinski, NorbertX" <norbertx.zulinski@intel.com>,
        "dawidx.wesierski@intel.com" <dawidx.wesierski@intel.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v3 2/2] ice: Fix NULL pointer deref
 during VF reset
Thread-Topic: [Intel-wired-lan] [PATCH net v3 2/2] ice: Fix NULL pointer deref
 during VF reset
Thread-Index: AQHZzCr5HPoTXd/ep0CLPu8pwV5fxK/0euaw
Date:   Mon, 21 Aug 2023 08:29:57 +0000
Message-ID: <BL0PR11MB3521CEF763542EEF07090A818F1EA@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20230811080702.1254319-1-poros@redhat.com>
 <20230811080702.1254319-3-poros@redhat.com>
In-Reply-To: <20230811080702.1254319-3-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|DM4PR11MB6215:EE_
x-ms-office365-filtering-correlation-id: cb5af920-77b3-471f-3136-08dba220cd78
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 22NXCq08W5HQlaOfFOqwfJ7Ek5UVUpMUqBUyg6/in/8jJQKJT8DG0I9ufKwnWZHKAMIpv8Av0cHrgI6ZBk27Z1IEbzKZ9ZBFrycAdmoaEaqHsbf+aSaXUcFOYBWbKUhcRU/2KdgWjZkp8sUlaxVIu4YN6oFuZgLDrG/CkjfwQVDMfk1RtV5laqUgkii0U0+sbzL9H+6JBCkiK6KAlMtedlfi0J9Tuv8KTlhP/Ef4RO9MTBZZLCM3DhkGnlTd3UxEqzH8cBexwDVZy7q/B0kHumRuodJVk+mg93zfYpI2xVXnEOh9U5HfNt/OP/zCMgzKld4bON0qCvgbEfuQFi3k9a24bnUaetbnOZMmDidF9ngT7fzj0HxZOEznWETL/kNfF2OFNV2ZHA4156pJ9hhCH9MqWlFdmdIw5Aqmhsjy0MHqy1aDAbDJj3dY0Va4thuJUSuLuUPgAEtb7l1TmMU9QXHul1cwoMVc41k4RLTnf/nNCGtJAkknkyY8wom9iLlYX3q+m6bHThWt5XoPmUCqWDGZsOZpl9ybgm7Z4gStMXVnEwWGuF3zvzyOZSdkBjTb/SlCJTJDx9BmjsrX3G7F/biN0ipobqhzx5GCkIzDfW0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(66574015)(2906002)(83380400001)(45080400002)(53546011)(7696005)(38100700002)(38070700005)(6506007)(5660300002)(52536014)(33656002)(26005)(86362001)(8676002)(8936002)(4326008)(316002)(9686003)(66946007)(64756008)(54906003)(66446008)(66556008)(76116006)(66476007)(110136005)(82960400001)(966005)(478600001)(122000001)(55016003)(71200400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?SaOccjzvjTnmuARftI3DeJqNKIeaTWkKAUpMiOdBZfSXeFWImtF+cG+9Uv?=
 =?iso-8859-2?Q?Cl1XuDN8Al7OZud0F6PL/AYu5950YJTDqmVNiWp7t7yRvYCVl+vg+ojvph?=
 =?iso-8859-2?Q?MZvtSzTG6vY9yfRAT+V6RZiU/t9YiWfDGoSE2nB11sB+Jq7AIkF0IciWba?=
 =?iso-8859-2?Q?Wqv70p4YmMsnQ4G6nAcSJGZn2GWmeY+EsEKj/Wudv/zu4xtOwif98cw6QC?=
 =?iso-8859-2?Q?BvHqSoleWZXdu8ijSYXHVbwCtDeDQHM1jgNIBO55iUQiMqdo3a6KQ2ejW9?=
 =?iso-8859-2?Q?3QngXKUKtAx2fuwq6Ur2krN5hp47urncSBIaecrGJVXqiMj6Db8XwAgyP1?=
 =?iso-8859-2?Q?YBGF66QJdld2EvBU5LKWjPtgE1cbqgI0uFBjxDxCw7LsL35eu4ph6QxPtb?=
 =?iso-8859-2?Q?XwJTRnMbJ5YqtswNvvl0TrnsbtnawEEdDrHUQeTVIZiK+oagNsdk1pkRap?=
 =?iso-8859-2?Q?at+yXJ2GKjG7IuMmC1YLnCHSNsJ4HUUQRG2uDJ7Gv/oJYXuJFEojPlOfz0?=
 =?iso-8859-2?Q?a7LpaGYFAUKawbhV4tCxkNvJb9eJ2iEpqeuwvXNIg5poRzTQVT4/KdTky8?=
 =?iso-8859-2?Q?xWJniIuKtmh14hvUz3mlDL5Y4Mo3iz9s216Jrz0LpB13N5lGhBhL/AQ1pP?=
 =?iso-8859-2?Q?2uOujfM6IjtYKV8c8W3BhIjRpkOnu28kIguz4+0DhIK9YHVrHnEuAl9cIj?=
 =?iso-8859-2?Q?nv5q2q7fsA7JeqaxIt7XXX7US4ka/kUAXJ0yhuiK/+xDJ1F/H9PM/prKRT?=
 =?iso-8859-2?Q?0f3LkaTJeP3o5QWV/Digafj9FPE/bU1B+K9xBlSOX8nXvY63nqucC7K0hb?=
 =?iso-8859-2?Q?Zpheyqr/Q8A7dbhTtO6hdq7L2Rzq27P0B6tcn3n1nYSSz/7gC9rWjunE74?=
 =?iso-8859-2?Q?vpyspH6niqrph2tjne+gzJF6LmAuck7lSo3zbCuOmtnYDUv27SX3U2rLj6?=
 =?iso-8859-2?Q?xrgeD6YXY9WYFDy0hsW2m07AbRernjot+ffaa0gYSlw4+DSnxFSTswn29j?=
 =?iso-8859-2?Q?vIL8AHBwxNb8mPZ+e+6S1DLKwHfSCKIaeLJ1rqHEMrDAPMCBtEKlFeRAGC?=
 =?iso-8859-2?Q?0Sr8TXq5NUNzjn5WlYMfMIRvfXiPN6OmxBK5oJ8rOn/ErXpW2UsI2tHwpa?=
 =?iso-8859-2?Q?iaUN7J9QKw4OKdWag9hqKGOFzKsu6OD6HbxPsPxE1k8uppqmpGDQfFmyOI?=
 =?iso-8859-2?Q?0AN4crIjzhsig8c46YKAk1GfruRjfP2Zp4eicfDybLw95m+Aw/QqhlLc6T?=
 =?iso-8859-2?Q?Bq1lnvft5/GV8F5zZTb99VD3aOHtX3cn8896BGs5i6gyTCsp7pwZgIXnbh?=
 =?iso-8859-2?Q?+OJubSvw7VGYzVW6v8b4CD3Rhmh1dVzrrz0JYeE0XArcO+zNJo50p4VtFn?=
 =?iso-8859-2?Q?f/U2cE42QoKwPVa4CPFMJoizSDGDvMe3h8/Wk3pasLu6c9LoUoReXazJ+k?=
 =?iso-8859-2?Q?jsB2S6cTMjcExgFnRARkj2R0YZtx1R5b6KxzWh+K/vbkQ224Ynk9+tM81V?=
 =?iso-8859-2?Q?a7AV6jZzxElvdNbdZFatHqpBt2geV1p5Zi5mBtHrbDPCU7LoZ7l1++rLXO?=
 =?iso-8859-2?Q?pMlzXfA3KF1j7MLmyb2JG39oWOEOyD+DbukkT73wKdgao7auKZcODOaI2P?=
 =?iso-8859-2?Q?fQ23pktDfmlkSMx0AyPPyxxyPaWwhXYEHqcnGx6hSWRtO43nm5na/Ggw?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5af920-77b3-471f-3136-08dba220cd78
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 08:29:57.2921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TAZEc919sDF/4kZQUKmHjpfImwFOoRZN0fhxeSpEVYLhjXJfYTNao+aEiY072CLRS32wl50ARfRk/4G4nKeWhxfbsTtruaVcE4EnUO0oTd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6215
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

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Petr Oros
> Sent: pi=B1tek, 11 sierpnia 2023 10:07
> To: netdev@vger.kernel.org
> Cc: Laba, SlawomirX <slawomirx.laba@intel.com>;
> przemyslawx.patynowski@intel.com; Maziarz, Kamil
> <kamil.maziarz@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Zulinski, NorbertX
> <norbertx.zulinski@intel.com>; dawidx.wesierski@intel.com;
> edumazet@google.com; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; horms@kernel.org; intel-wired-
> lan@lists.osuosl.org; kuba@kernel.org; pabeni@redhat.com;
> davem@davemloft.net; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net v3 2/2] ice: Fix NULL pointer deref
> during VF reset
>=20
> During stress test with attaching and detaching VF from KVM and
> simultaneously changing VFs spoofcheck and trust there was a NULL pointer
> dereference in ice_reset_vf that VF's VSI is null.
>=20
> More than one instance of ice_reset_vf() can be running at a given time.
> When we rebuild the VSI in ice_reset_vf, another reset can be triaged fro=
m
> ice_service_task. In this case we can access the currently uninitialized =
VSI and
> cause panic. The window for this racing condition has been around for a l=
ong
> time but it's much worse after commit 227bf4500aaa ("ice: move VSI delete
> outside deconfig") because the reset runs faster. ice_reset_vf() using vf=
-
> >cfg_lock and when we move this lock before accessing to the VF VSI, we
> can fix BUG for all cases.
>=20
> Panic occurs sometimes in ice_vsi_is_rx_queue_active() and sometimes in
> ice_vsi_stop_all_rx_rings()
>=20
> With our reproducer, we can hit BUG:
> ~8h before commit 227bf4500aaa ("ice: move VSI delete outside deconfig").
> ~20m after commit 227bf4500aaa ("ice: move VSI delete outside deconfig").
> After this fix we are not able to reproduce it after ~48h
>=20
> There was commit cf90b74341ee ("ice: Fix call trace with null VSI during =
VF
> reset") which also tried to fix this issue, but it was only partially res=
olved and
> the bug still exists.
>=20
> [ 6420.658415] BUG: kernel NULL pointer dereference, address:
> 0000000000000000 [ 6420.665382] #PF: supervisor read access in kernel mod=
e
> [ 6420.670521] #PF: error_code(0x0000) - not-present page [ 6420.675659]
> PGD 0 [ 6420.677679] Oops: 0000 [#1] PREEMPT SMP NOPTI [ 6420.682038]
> CPU: 53 PID: 326472 Comm: kworker/53:0 Kdump: loaded Not tainted 5.14.0-
> 317.el9.x86_64 #1 [ 6420.691250] Hardware name: Dell Inc. PowerEdge
> R750/04V528, BIOS 1.6.5 04/15/2022 [ 6420.698729] Workqueue: ice
> ice_service_task [ice] [ 6420.703462] RIP:
> 0010:ice_vsi_is_rx_queue_active+0x2d/0x60 [ice] [ 6420.705860] ice
> 0000:ca:00.0: VF 0 is now untrusted [ 6420.709494] Code: 00 00 66 83 bf 7=
6 04
> 00 00 00 48 8b 77 10 74 3e 31 c0 eb 0f 0f b7 97 76 04 00 00 48 83 c0 01 3=
9 c2 7e
> 2b 48 8b 97 68 04 00 00 <0f> b7 0c 42 48 8b 96 20 13 00 00 48 8d 94 8a 00=
 00 12
> 00 8b 12 83 [ 6420.714426] ice 0000:ca:00.0 ens7f0: Setting MAC
> 22:22:22:22:22:00 on VF 0. VF driver will be reinitialized [ 6420.733120]=
 RSP:
> 0018:ff778d2ff383fdd8 EFLAGS: 00010246 [ 6420.733123] RAX:
> 0000000000000000 RBX: ff2acf1916294000 RCX: 0000000000000000 [
> 6420.733125] RDX: 0000000000000000 RSI: ff2acf1f2c6401a0 RDI:
> ff2acf1a27301828 [ 6420.762346] RBP: ff2acf1a27301828 R08:
> 0000000000000010 R09: 0000000000001000 [ 6420.769476] R10:
> ff2acf1916286000 R11: 00000000019eba3f R12: ff2acf19066460d0 [
> 6420.776611] R13: ff2acf1f2c6401a0 R14: ff2acf1f2c6401a0 R15:
> 00000000ffffffff [ 6420.783742] FS:  0000000000000000(0000)
> GS:ff2acf28ffa80000(0000) knlGS:0000000000000000 [ 6420.791829] CS:  0010
> DS: 0000 ES: 0000 CR0: 0000000080050033 [ 6420.797575] CR2:
> 0000000000000000 CR3: 00000016ad410003 CR4: 0000000000773ee0 [
> 6420.804708] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000 [ 6420.811034] vfio-pci 0000:ca:01.0: enabling device (0=
000
> -> 0002) [ 6420.811840] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400 [ 6420.811841] PKRU: 55555554 [ 6420.811842] Call Trace:
> [ 6420.811843]  <TASK>
> [ 6420.811844]  ice_reset_vf+0x9a/0x450 [ice] [ 6420.811876]
> ice_process_vflr_event+0x8f/0xc0 [ice] [ 6420.841343]
> ice_service_task+0x23b/0x600 [ice] [ 6420.845884]  ?
> __schedule+0x212/0x550 [ 6420.849550]  process_one_work+0x1e2/0x3b0 [
> 6420.853563]  ? rescuer_thread+0x390/0x390 [ 6420.857577]
> worker_thread+0x50/0x3a0 [ 6420.861242]  ? rescuer_thread+0x390/0x390 [
> 6420.865253]  kthread+0xdd/0x100 [ 6420.868400]  ?
> kthread_complete_and_exit+0x20/0x20
> [ 6420.873194]  ret_from_fork+0x1f/0x30
> [ 6420.876774]  </TASK>
> [ 6420.878967] Modules linked in: vfio_pci vfio_pci_core vfio_iommu_type1
> vfio iavf vhost_net vhost vhost_iotlb tap tun xt_CHECKSUM
> xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 nft_compat
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> nft_counter nf_tables bridge stp llc sctp ip6_udp_tunnel udp_tunnel nfp t=
ls
> nfnetlink bluetooth mlx4_en mlx4_core rpcsec_gss_krb5 auth_rpcgss nfsv4
> dns_resolver nfs lockd grace fscache netfs rfkill sunrpc intel_rapl_msr
> intel_rapl_common i10nm_edac nfit libnvdimm ipmi_ssif
> x86_pkg_temp_thermal intel_powerclamp coretemp irdma kvm_intel i40e
> kvm iTCO_wdt dcdbas ib_uverbs irqbypass iTCO_vendor_support mgag200
> mei_me ib_core dell_smbios isst_if_mmio isst_if_mbox_pci rapl i2c_algo_bi=
t
> drm_shmem_helper intel_cstate drm_kms_helper syscopyarea sysfillrect
> isst_if_common sysimgblt intel_uncore fb_sys_fops dell_wmi_descriptor
> wmi_bmof intel_vsec mei i2c_i801 acpi_ipmi ipmi_si i2c_smbus ipmi_devintf
> intel_pch_thermal acpi_power_meter pcspk  r
>=20
> Fixes: efe41860008e ("ice: Fix memory corruption in VF driver")
> Fixes: f23df5220d2b ("ice: Fix spurious interrupt during removal of trust=
ed
> VF")
> Signed-off-by: Petr Oros <poros@redhat.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> v3: added tags from previous reviews
> v2: fixed typos in the description
> ---
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> index 294e91c3453ccd..ea3310be8354cf 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> @@ -612,11 +612,17 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
>  		return 0;
>  	}
>=20
> +	if (flags & ICE_VF_RESET_LOCK)
> +		mutex_lock(&vf->cfg_lock);
> +	else
> +		lockdep_assert_held(&vf->cfg_lock);
> +
>  	if (ice_is_vf_disabled(vf)) {
>  		vsi =3D ice_get_vf_vsi(vf);
>  		if (!vsi) {
>  			dev_dbg(dev, "VF is already removed\n");
> -			return -EINVAL;
> +			err =3D -EINVAL;
> +			goto out_unlock;
>  		}
>  		ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, vf->vf_id);
>=20
> @@ -625,14 +631,9 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
>=20
>  		dev_dbg(dev, "VF is already disabled, there is no need for
> resetting it, telling VM, all is fine %d\n",
>  			vf->vf_id);
> -		return 0;
> +		goto out_unlock;
>  	}
>=20
> -	if (flags & ICE_VF_RESET_LOCK)
> -		mutex_lock(&vf->cfg_lock);
> -	else
> -		lockdep_assert_held(&vf->cfg_lock);
> -
>  	/* Set VF disable bit state here, before triggering reset */
>  	set_bit(ICE_VF_STATE_DIS, vf->vf_states);
>  	ice_trigger_vf_reset(vf, flags & ICE_VF_RESET_VFLR, false);
> --
> 2.41.0
>=20
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


