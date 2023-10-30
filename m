Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E787DB3CF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjJ3HEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJ3HEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:04:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FE983;
        Mon, 30 Oct 2023 00:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698649473; x=1730185473;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WPwJzOOshzfZZT7twljiD5v0vcseNpV020AKz4quf8g=;
  b=n1rtKangrzM//vOGZ4fuRYOXbEljXbNdRREWWvCkjthYI5v32DK1R+Df
   YxNi+CiCv/nWPXGnbwWNrqhHbvrSmsLViYWDqv8GCLwvuAjfO6X6XY49b
   ylfRmEImeSRdzSP0jj0jKvIm+gSwbNs0BveZtmv4XEo2KJSAsYp6+cHJa
   FR8o9/h6r4AlEgykoo1Du1HL1orfArhuLh/TRC9kPESGWq24LSF2w3E7f
   8axs2PPnsQBEOZ6eEkYMbf+bvJROB2HWnhRQMLCP/4mlEle9OyNtAaSaP
   WvfI4MknVl80FMrx/AR/xdecLxlYkOiLhI018x9Ia8CPgRifsFuLbkJ8S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="6655774"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="6655774"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 00:04:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="760183781"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="760183781"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 00:04:31 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 00:04:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 00:04:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 00:04:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch2iYjYo3C3m/23jZ4B9WydQE6zZ7iA6C/1/fZ3+LYoOUmqvbKBZvqkXOn8NL9mm+WsNdutZYGccn0dGRw16RbMup9aMthGRa6ZP6rXWBKdsSqnXjRxvgZ+Pj9UgYqaNQ8XCSLH+7tx7DM7OtSiZ33lw0H+Wkja3TPQ7yW0LjEjoMY8DcxbPbFLDe/YZy+kdE4jHflpeiaDj/HDNC+EDYNziNCwOalTrl85k6kMGgrrHDdpXfHree20m0kfjPbLKr4KeAZXNaY+B/tPbkSPVj1ba81MiynOq3vq5LhD0ddP9NpdtjC8ekaCBxiqvm14t/zwdAc4F9Zi9RGDslAp8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcRJ2FGuUIgnAyxc8NGWF+lOhGY95FwmQLEaQ8Ywz5Y=;
 b=X67Q3a1qiRCa525QQ2whWgLeWgt8iyEzMNG0Y2B5JhPwlYIRs6AGGjvDmYWtrz0MwDPoB5ays+kJFSrkY58RajGxSBcgHsqDHossZ9Y2JDQM7py3Yxz+IveojR1GRViMAVr6ggLG578Br4oTFmhjHscrEYSbzkQWJVI6MlUPDgjYeodMdLz8j2ZNhx5xSXxcTXuJkFdG6DVPCoFT3XZvq3mxsP0yCir8k+ltwO/XWBU2DAwAGfZF5PCygWs07wxc46mMzX32ip/I7ZxYMCi5vJ3JNIVMq2flH3O6wdXNtXBVdSJkle1qn2Nt8+Mk02tuhV/6Xb8XdADDV+FkUFwNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by CH0PR11MB8236.namprd11.prod.outlook.com (2603:10b6:610:184::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 07:04:27 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::7911:8ae6:fc73:1097]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::7911:8ae6:fc73:1097%6]) with mapi id 15.20.6907.032; Mon, 30 Oct 2023
 07:04:26 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     ivecera <ivecera@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "Drewek, Wojciech" <wojciech.drewek@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] i40e: Delete unused and
 useless i40e_pf fields
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] i40e: Delete unused and
 useless i40e_pf fields
Thread-Index: AQHaB1P8axEddTwy3UCkIkMohiluE7Bh7vbw
Date:   Mon, 30 Oct 2023 07:04:25 +0000
Message-ID: <BL0PR11MB312257E7B85EC1E71ED49E98BDA1A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231025145937.1873040-1-ivecera@redhat.com>
In-Reply-To: <20231025145937.1873040-1-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|CH0PR11MB8236:EE_
x-ms-office365-filtering-correlation-id: a1713c1f-ea57-47dd-781f-08dbd91673e2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: svwZ/XyT2OEOB0MfuJvUm6X62KQsUZeaUN/x6CeReFgzCic0d80IYsk9OwzJHiZB+owtf6zFaDFkY+za2SQWfMBTDiHqwL4NVe977iE9LW6+0SI6+D3zUQ8xCiKnhHgqP1mO8hmOy/eJ6JFHRBYz+iM5C8ME0yCVYhg3W3+57JJg7Xap8uX0GuZCf7/9WyEVHdnYDu706yKQL3PgAoekLAOdWG5p35mvTTqlJLTiemJx9BCWnEzynXZxxI7BZLon4gs7kAsdrBOLoWiXNQ7oHrgWzJGMcL3jf6ms8catCqibSfdxkAha4iLYGphuSOWmBxdLGw8384w4f6fidpU2dxdKiBjCl28Vddx3Sxd5lNaBXG1B9ZXpgjSxJyMGjU/X8SRBRQFX4KDLYV4b2QiUdzWmkCdFxvw+7kgor/4lY53nXdWfRzD/zdgjjKnSsY9C0T2SsJ7l16XvGmpvLdtE6m0bRS7pCVtmkex5QJ49BCBzpUr1YvzEmSNM25fnENuj6HJamKH1J3C5eG8NYRZ/0IpyPnXDYi0yqPcwXh5LfIx+Vb4lFFL2hnsmozUFVqblRn6Bs0F6x3PF4DXkGfhLTI9AHvDfgLQjzr0sPEDlHI3ktINx29wAiFClAMWmO/t0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(55016003)(9686003)(26005)(53546011)(478600001)(6506007)(7696005)(71200400001)(83380400001)(2906002)(5660300002)(41300700001)(66946007)(76116006)(66556008)(110136005)(66476007)(64756008)(8936002)(8676002)(52536014)(66446008)(4326008)(316002)(54906003)(38100700002)(82960400001)(122000001)(86362001)(33656002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yr5l9yNZrMb2lnZIbWUSBsWSk7TmmKb+wAL3Rd4p6BWcF20d09IB4DEum06+?=
 =?us-ascii?Q?QCLaNER2Z3jW/wF67KFId3LGiNdm83kEnUnquUBvhF4TovE+fbtuC0NYns06?=
 =?us-ascii?Q?fsW/n2m+GIoz9lcyJLLceKdV/J37lHC99MBU5YKQAYkcfm7H/qXXaXD2wAhl?=
 =?us-ascii?Q?UnSMiYCGPe+fuLTh4te+58EOQms6ezg8RSNt/bRiTixlQ36/4Ie9l9mv62Tm?=
 =?us-ascii?Q?mnvBhfoDAU8dAMI6mT9ajSvs8kaJF5CIzyveLT4fIJs6jN+VUmwjsX9DOE1M?=
 =?us-ascii?Q?5o7qMhSTICIzRw/+8PURgXIyHlMndnowaxhOKpg4vxgiCHudvmfq+vm39HX3?=
 =?us-ascii?Q?Y97JyFZjvSFIOoxoq6Tcv0O1idN1YcMRrABUAn/mQhF5b4hW3Ckt6Y21E65A?=
 =?us-ascii?Q?EY+RSxf3vMKMAa2n+Guuz+hFPl05UmnP+eQ2J49WmwBtsuIOzZw5AizycVuc?=
 =?us-ascii?Q?wEl/AiVlM4SBYgKiAdMMPrs2GJf17i6CssC9tgbIXKzkaC0zB/5p7gSwMHc5?=
 =?us-ascii?Q?LICTSjTAacqjqTKSOOwwQ8PCXvimnR4FRWyI6xwuJsdmbf92Ow3jU+60kZqR?=
 =?us-ascii?Q?LHR68+DzZwNreSASoZNcHJMrozMHZuohHCkyz18sTgA74VsQRLT4ewgWAF2u?=
 =?us-ascii?Q?ShM8uSvNaDUmb7K1IPyQd6Xv0G17U+3KZpg1WUE9b2HrAvNj0s9vLdHcpZMG?=
 =?us-ascii?Q?d0e6yLcyspfrQdu8C9fGsuZnlnCw6b949hClYugZ5JyU3oAFo8q05GZPnAjY?=
 =?us-ascii?Q?RCKhQ6Bu7WuXYuFGXVf47dNo73Si0zXGvnXEcRC/8gsiVeD7geuJygiGZP9l?=
 =?us-ascii?Q?ZiXXPjG3HYcMp+ZOim7GCqfLlRzEKLjHZxh/kGTHTthlGv1KSKDYLIf5IveV?=
 =?us-ascii?Q?aAY4OTQFM8N6tMapxZU7ftKVKFc8qtskQIDIngv+KkNVT0fp0NM1fYcfD2Pv?=
 =?us-ascii?Q?FOqbXYQM++OM1TiL+CSH/i0LVZgk83HmfQ+BWLeOzXIinJc5A3aA2CqmaAWb?=
 =?us-ascii?Q?pcVcsEVx3XqEdQaNpLcyV483sRgAbJAZ15bOBaC+nC9rnOKvlFzUxWXTm21y?=
 =?us-ascii?Q?3sPlkqOnfJTCExk44yHZNlP/EsgL6QORSfgMvRoL83Hv4rDB9ASbqcdCQras?=
 =?us-ascii?Q?4FRuOe4fFLdZbrVygmAY5848XG1qin3NcIfwXYrkDlmA6Z7jtIetfwuNPJo4?=
 =?us-ascii?Q?DVGxBr8LM6aJCe+18bFu6bcF9HTVMok3uevUnAwDJX3jy3Y3YJ19yndhT+Ds?=
 =?us-ascii?Q?WCjhU6p58HrG8IKyVg7rfJGk1QwxT2qfiFf8pieG5+boKyGhpETqKPQoOxiU?=
 =?us-ascii?Q?KWPMlhrDHiAneEnLJL0tKKXAJVcxmG3KKNUKh3mG2G/OfuWEBNFPEunOUXZg?=
 =?us-ascii?Q?WOlhYpfhh4jOo/jJy9UEZGwk9NM++eXghGNBPEtt/6I7JhSuNLQmoQX53aRp?=
 =?us-ascii?Q?fi5z9m5Jym04dR7Cj29SqsTlSRyWifiL7A7+fQ9MSgHM+VMezxlaKTungwZl?=
 =?us-ascii?Q?amZDaFambCm3WSDoB/ZygB1LTDk7H3kaKbog23ENNxlkbN+B16d5wbeQljv0?=
 =?us-ascii?Q?wSUfaHdnC1LmcdjtEc6wi3h9zPfhRGNoX313lzqROC3/G9f+cexvHN1Pjjxl?=
 =?us-ascii?Q?qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1713c1f-ea57-47dd-781f-08dbd91673e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 07:04:25.9678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQEtdcipPrINIPGcwXWZHeOPcA3lzdiuYIr5OURNoik4TtEbL0jDHT8gpDf4TIgekaUtJMEGTyObOmWPIomEjaqaVw4JJTGBcrnVQpVJw/zeJLthX7/q/JTxm4Ow6vr/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8236
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Wednesday, October 25, 2023 8:30 PM
> To: netdev@vger.kernel.org
> Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; intel-wired-lan@lists.o=
suosl.org; Brandeburg, Jesse <jesse.brandeburg@intel.com>; linux-kernel@vge=
r.kernel.org; Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L <anthon=
y.l.nguyen@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>; Jakub Ki=
cinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller =
<davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-next] i40e: Delete unused and usele=
ss i40e_pf fields
>
> Removed fields:
> .fc_autoneg_status
>     Since commit c56999f94876 ("i40e/i40evf: Add set_fc and init of
>     FC settings") write-only and otherwise unused
> .eeprom_version
>     Write-only and otherwise unused
> .atr_sample_rate
>     Has only one possible value (I40E_DEFAULT_ATR_SAMPLE_RATE). Remove
>     it and replace its occurrences by I40E_DEFAULT_ATR_SAMPLE_RATE
> .adminq_work_limit
>     Has only one possible value (I40E_AQ_WORK_LIMIT). Remove it and
>     replace its occurrences by I40E_AQ_WORK_LIMIT
> .tx_sluggish_count
>     Unused, never written
> .pf_seid
>     Used to store VSI downlink seid and it is referenced only once
>     in the same codepath. There is no need to save it into i40e_pf.
>     Remove it and use downlink_seid directly in the mentioned log
>     message.
> .instance
>     Write only. Remove it as well as ugly static local variable
>     'pfs_found' in i40e_probe.
> .int_policy
> .switch_kobj
> .ptp_pps_work
> .ptp_extts1_work
> .ptp_pps_start
> .pps_delay
> .ptp_pin
> .override_q_count
>     All these unused at all
>
> Prior the patch:
> pahole -Ci40e_pf drivers/net/ethernet/intel/i40e/i40e.ko | tail -5
>        /* size: 5368, cachelines: 84, members: 127 */
>        /* sum members: 5297, holes: 20, sum holes: 71 */
>        /* paddings: 6, sum paddings: 19 */
>        /* last cacheline: 56 bytes */
> };
>
> After the patch:
> pahole -Ci40e_pf drivers/net/ethernet/intel/i40e/i40e.ko | tail -5
>        /* size: 4976, cachelines: 78, members: 112 */
>         /* sum members: 4905, holes: 17, sum holes: 71 */
>         /* paddings: 6, sum paddings: 19 */
>         /* last cacheline: 48 bytes */
> };
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         | 16 ----------------
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  3 ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 18 ++++--------------
>  3 files changed, 4 insertions(+), 33 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

