Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A918752E02
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjGMXik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGMXij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:38:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088E22707;
        Thu, 13 Jul 2023 16:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689291517; x=1720827517;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=LPp44NDWEpqZiucKtKHsWJi0KIS3OeymkPkpzDsPPo8=;
  b=YXjlCJTTthtNWP+3J4hQjXe+gt076HeuURzC6E+x1zBUDbu1vU5XljZ7
   1JS/73W3H4XLwA+6N+nm7qgiTStHYcW0jQ1+S7k3AoiChxPb9whEARjrN
   o/UCnI6cxrV1EnyCGN6CXqUYXv948JvyXnq6XvW+1/plbqenEvi+H+HI8
   WNOg6GT+Heeyi1OozLoVGZq1jNBG0gfOucu+2fxlkgHDR+gVvJnw4b2Z0
   TPxhJV2UDC649Hdq64TbB/dWZObejfPoCC040Hb6SsGW/kdrO2QsHtogd
   P6KYPPqRgOeB3wVC5V87BN+eYtE2SJ3X0aGAPeNdFVOpKDVex6uu7cXl9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345661006"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="345661006"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 16:38:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="699448885"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="699448885"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 13 Jul 2023 16:38:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 16:38:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 16:38:36 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 16:38:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZt1S5oef8UiU26S2wDkb6DMty05j2epC02S6NnWIHu0kbJj7wspZZoczzTEAn2tZxR4AQdDyeHABcJTNjnexPQ4M4ImJUaD+baNs9QIb0Hj3UoJReF9FciCtF+osRuDyedQq09iz/Uzrpt4MEHeswzSwxeqM/o5gJgng4pHjRkQ3Ir7FLo/2AhXaeV0FvMdC+QPfKSkmBGs9ddXe+/oDul/wQyKtmjyCH9qaKdX4vaL9RxuErpAv7EPdnVxsrOl5oEy0v0kxQeIaayJNS8cwy96qhWwuBaCCSAESbgLjkcl0ILEAk6NRxpW/UkJP7F2EpkW4maIHjKM6SXgO3odGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq+OuGiNUS3CnBfTa+x0i6UJrgRUyWbAaQh0UiCa4NI=;
 b=SVEz60cuQPWmNVS6lR4Kc/DtMdshPIoNCgpOQfC5KeJI5C+/mI46N3DszImZnRS2qXzkNqQ7Wpa617bBzE95UBY6jlbjP2VEN6eHwB9PPOlT65RcF8kgRGKZRBdRJE3OTSs1+zW1aJYpIDBqEXcy+5gAUooFgzePTYssG5q6R5X40OpeVPwmNwMZLOzFAl0eNrcATOeOwXIt/FaDLjUSVGxDWNm5wZiFdZcIKnD0eY1DS9FKAwXM37p40JU0AfRW2Ppje/c6mi1SdqB8qVJ/HIrz58rE3SSh6VYSwr+l1yxdIw1Lc9N2UuQf13XzBPVIXXuk5u1cLHc+P8KaqrtxpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5028.namprd11.prod.outlook.com (2603:10b6:303:9a::12)
 by SJ1PR11MB6226.namprd11.prod.outlook.com (2603:10b6:a03:45b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 23:38:33 +0000
Received: from CO1PR11MB5028.namprd11.prod.outlook.com
 ([fe80::d166:2444:2f40:e0b6]) by CO1PR11MB5028.namprd11.prod.outlook.com
 ([fe80::d166:2444:2f40:e0b6%4]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 23:38:33 +0000
From:   "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To:     "Ma, Aaron" <aaron.ma@canonical.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jeff Garzik <jgarzik@redhat.com>,
        Auke Kok <auke-jan.h.kok@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v2] igb: fix hang issue of AER error
 during resume
Thread-Topic: [Intel-wired-lan] [PATCH net v2] igb: fix hang issue of AER
 error during resume
Thread-Index: AQHZmOOokxjOvODuMEq7FIpYqOTT2K+4k6ww
Date:   Thu, 13 Jul 2023 23:38:33 +0000
Message-ID: <CO1PR11MB5028DD73CD9601FEA281FC0DA037A@CO1PR11MB5028.namprd11.prod.outlook.com>
References: <20230526163001.67626-1-aaron.ma@canonical.com>
 <20230607015646.558534-1-aaron.ma@canonical.com>
In-Reply-To: <20230607015646.558534-1-aaron.ma@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5028:EE_|SJ1PR11MB6226:EE_
x-ms-office365-filtering-correlation-id: c094633e-309a-4bbf-aadc-08db83fa45c4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pavSv80tDw55nvFzuKbeFFa6jPKDc9MD0mqs1h9Im/8tMx6pk78zQc09b/ZFsDknCkNLjf9+CzWxhPHg3vN/0DTM2YpGyDHaMkzmwMsyVH7InfdPMJgHWXbiAMp7qz5+/DzeBiAaKwebmnQBPr3leiL7JthmNbLf8nx0PylXmwjYwtFzpC012AxpSViydjp1nIaKK1SCoc7M7W40kclV3Cqya9nVVDBT10h0sEWdeAIZ53EDyDMIx6taXYoHDaoWdEpcVmwcHP9D4Lp0Vf0pinzsf+FUUDZxuwVx48aoYzzi6vhOhto1SDtQu0Ufe5/S1Sfy7j7Dg+ha5XxpyNBsJGsiWSgL6FRh5TKo8wbo6ClVtZIQQA/DeKtLvaj3v+JQkNfNXSSAR8Uh5sIRgS5+v6ALSoHXbU1WlqEt+9BzE27jVZjzuQbJe9BKIghvcdY7cB2VUwWoyQHURLLPIioOmW+T6XiP9YYb2NY/K7r6a6qWSVKXZasDcYX5Zavqp3c5nOOXKzdaq1x2+1KzhXJV7OtI1ZeGEAC5rPOHmNPQjNZLS1xMZcgUFjouOb66fWfNaAnRzdW5R4xeBCEjyO5DXugNp6CLqjn0Lz74fLrn7yDmhCbljDqmR7tW+TGHctn2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5028.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199021)(8676002)(41300700001)(8936002)(55016003)(110136005)(7696005)(2906002)(316002)(52536014)(5660300002)(71200400001)(66476007)(66946007)(66556008)(76116006)(64756008)(66446008)(33656002)(9686003)(82960400001)(966005)(478600001)(86362001)(186003)(38070700005)(122000001)(921005)(38100700002)(83380400001)(53546011)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mFZP+7SIjqkudHFyPYabC4CYAKQxyNqR4gmXXGNqe8d6numrlWBtTzpCfl8m?=
 =?us-ascii?Q?9xrFT5C21QXDs8DFClDR5Gggg4Ty1FDMz6F42VGVjQZ9t2gJwfZWQRApKAmh?=
 =?us-ascii?Q?f3NudDr4MZlwd8BlYh5a5ze8G5cXh9tmC7J37QBcBCGInwxbKiEYQ+K0eaRW?=
 =?us-ascii?Q?03RzaR4/sMDa3cy4XpqqGn6sg/LmKwAyV1yUMf91y2WqswzENMyZiQsAFhPf?=
 =?us-ascii?Q?ooPq8Y8RqBnANDotc5nDcGo4vRvMv4D7WLuPU1pSEG19C3UWEePjutbJOCGu?=
 =?us-ascii?Q?tG3QeuG/oWXmu5bOmxo65ufu/mxSRMuO1WIAM5N7OuNRgY9D2uvOALck4W1Z?=
 =?us-ascii?Q?5UlFJO279h6OIJYSD5KnkFVjmSVFlOoOui3F0RV7DJ69LfQY0nzV9JRqsiXG?=
 =?us-ascii?Q?cTnjyIwJjNjJy+z7nnfIGFiyN18VVTRy10I0d17ANRKGwt3kwOluYVJOr+66?=
 =?us-ascii?Q?bkj2sEHNhMYJW30n+eZxZ5cgeCNeoofjSWi5RFEuC0eqQohmEkChx7sp63P3?=
 =?us-ascii?Q?a0z6WW0rCm9w5BOEt/3PSmimDhq7X+Wbb8nKKL6YVdMIXgqPGP/r9bGmIthA?=
 =?us-ascii?Q?dxB2Gg2nuywg2iqP84rMDsR8Zy9zJb9iHHjLv2MoT+mtRkuA6cffvvbRRTNb?=
 =?us-ascii?Q?KzgGtln2abyh9J978xSK9WbpyOF5mbLq1T1pyzxz3dcHKgfcuK9DhLt+6H7Z?=
 =?us-ascii?Q?9dyLzHbHpM3uXclmL/PNOzy5wc0D/0xIzx7Kk9qX4x17BcY82m+o4EhqLGhf?=
 =?us-ascii?Q?Ms02WfpvPOVvej5MQFkIRroCXQuw4jVHnBhMeEgns6abRKRHq01ruCQ4/Bsp?=
 =?us-ascii?Q?PGDoSTKZXRuW+ev8LBMVV5z3zWHIng29rmu0blmB7U/WELCE66lJBJ/eL/94?=
 =?us-ascii?Q?Gm7tLdigljHNrEr+XtGKSZqqLMHaDzdT+rYfrG52McAiaFj/Aim8hn0dmvVe?=
 =?us-ascii?Q?ON/K10/KaLdhuge7hHkLpTzGgO/2n/Cj72I02f6A7FmQVJv9O6UwqLwveFTk?=
 =?us-ascii?Q?6IxSkz8Rls4GQBqisZX1eR1mIAocEmtRncyUJObc5mG/YonBKUrZVzrpaR3d?=
 =?us-ascii?Q?ZOQp9PgacUVBJVM7P9Nr2zy/LETDlpnzVUDSqqT9rNKLD714sc2gvxUsLmu7?=
 =?us-ascii?Q?mw58jD54+K+plCSz6lzcuo5Nie0/nWa0OWQzomRl34HnHvRL+bFf92PXBg8h?=
 =?us-ascii?Q?0OQ4xCGWixXZYZvEEJ8/IP3VYN3wr7VVT4ALZAEjKtvPjyxjQLtHrCYC00Zb?=
 =?us-ascii?Q?7DW96loiWHy6DTLJN5frdGv812LLfeVeuYpCdDf5aLElPBAGzeqRDW1POkqM?=
 =?us-ascii?Q?xfuG9ufQfg8R8p+wheNBAelgVNJKBHGlP/3qTvh1CQQ6CRZhYAJi1VsfEHBM?=
 =?us-ascii?Q?HN/pFrn6lNXZzjlNx+4mJLjKXhS8F4fIS/bK5h92QFK9cKkdXs/a/eRr2idh?=
 =?us-ascii?Q?yjVHpf+TggJxVrkvN3n/jaT8utIwIHNSDpwYIbKGHzxg2XHAVI8X7oXBMZnE?=
 =?us-ascii?Q?QgP/oL0tiaTQrvTtGhGu96fBBwwLa+mNm/2YNhVMJOIH1t0bS3tL3XTLw0kF?=
 =?us-ascii?Q?FvRcPBeQ2GJVqtDmU/E0CKlJF9wBuUMySrQN5uODwxbiPsRmU0ti0d+XS4Oj?=
 =?us-ascii?Q?kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5028.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c094633e-309a-4bbf-aadc-08db83fa45c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 23:38:33.8458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ml87HlC/LErCyv1XeWrO9qArbl+SQuJiFzzjw+1ZwC9zv8e5ZEUCgxy/j7Lc2wHT8bBaMKuls0vC8Pi6dWL5Fi1VX+acAaaL5dryUs5zTQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6226
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

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
aron Ma
> Sent: Tuesday, June 6, 2023 6:57 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <an=
thony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Eric Duma=
zet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <p=
abeni@redhat.com>; Jeff Garzik <jgarzik@redhat.com>; Auke Kok <auke-jan.h.k=
ok@intel.com>; intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; li=
nux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net v2] igb: fix hang issue of AER erro=
r during resume
>
> PCIe AER error_detected caused a race issue with igb_resume.
> Protect error_detected when igb is in down state.
>
> Error logs:
> kernel: igb 0000:02:00.0: disabling already-disabled device
> kernel: WARNING: CPU: 0 PID: 277 at drivers/pci/pci.c:2248 pci_disable_de=
vice+0xc4/0xf0
> kernel: RIP: 0010:pci_disable_device+0xc4/0xf0
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  igb_io_error_detected+0x3e/0x60
> kernel:  report_error_detected+0xd6/0x1c0
> kernel:  ? __pfx_report_normal_detected+0x10/0x10
> kernel:  report_normal_detected+0x16/0x30
> kernel:  pci_walk_bus+0x74/0xa0
> kernel:  pcie_do_recovery+0xb9/0x340
> kernel:  ? __pfx_aer_root_reset+0x10/0x10
> kernel:  aer_process_err_devices+0x168/0x220
> kernel:  aer_isr+0x1b5/0x1e0
> kernel:  ? __pfx_irq_thread_fn+0x10/0x10
> kernel:  irq_thread_fn+0x21/0x70
> kernel:  irq_thread+0xf8/0x1c0
> kernel:  ? __pfx_irq_thread_dtor+0x10/0x10
> kernel:  ? __pfx_irq_thread+0x10/0x10
> kernel:  kthread+0xef/0x120
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork+0x29/0x50
> kernel:  </TASK>
> kernel: ---[ end trace 0000000000000000 ]---
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217446
> Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> Reviewed-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
> V1->V2: Add target tree tag net and Fixes tag.
>
>  drivers/net/ethernet/intel/igb/igb_main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
