Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B7A7D3603
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjJWMCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbjJWMCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:02:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620E0FF;
        Mon, 23 Oct 2023 05:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698062556; x=1729598556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yPJJQOQnERGFugdrCg6MyX+2qRX2XX1x2k0dOdLzfT4=;
  b=gYKXdRTdY4yboOjU/baRnPRB6xDzRab7ltj3HXZ3k+OZsoXnqE3q1YLX
   MLqMbihvRYusEV9wfBBVDczeSocAH2xaszk4zCT6g8JO9zFTLLOhV4PtU
   IVGFG/Lsx09WKiAQsWSVEzEgjzQMjLkJ59xlwVtj/aM7Byp7WSlM5U3Qq
   kyNOM595C0qpvq892GBVV7pfqVzPyw3aYv5uqh0kCjXWy30D50ltUDkL1
   CHMPtL6dnJKAr+HuAnfPXUgTEeCsPHnd7KOtHEdEnn+AASqusv2iDSOaU
   DyIm3HTZiiaPMdhnvNNX5sv2fH146OPPRAKIhEjibcqHO9tSjLirO7Yjs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="473036979"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="473036979"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 05:02:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="734642461"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="734642461"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 05:02:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 05:02:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 05:02:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 05:02:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 05:02:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hurwYGyYwNhHINBjUUf9e9I+5OClwFVVTGBBVKgboCXYBuQ5Hq8ap+a3oM5SR90ANBqMx6rRMtLNQBOq/4g583SZOFUvIzRb0C/MezS+BGhJLCbIDw8NFl8drGz6PgttP61hEd3mTZirAu/ApiZaLCOD0DJMaXI09n5sAwiq81YqPV19DtkJFnOAHkSmU8/q9zixx3w4NxcqwE89OQeo9qqbUZtwf39jE/EG0dBzUBzi57vycYNFJynZzwXnVgLd4/A8m90yA3aRYMge85xl1ERr64p35/LlaZ6PzWDWv9a54Yz6bfOpkeUbgoa1ZI9yPW8Vs7S1U+aC3EOyDrZWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzzvK4pVDVjh3vRD8dIsF2LrfqHzYN3dIUO/YrIjVDQ=;
 b=aPAYREq/XnyTuC6QbIP83YCe5DmDUCBfpRTgwkQb1HFZwfxQJuvokyNNe0335GHTahCHL75l7V3uVDwKeNBiVZhfY1x0gnfuZo3X1SwOh+wyjTW/9/f2aR9LEljBIjHWyilqYdG0UzuhIr0VPfNWKymYnCUaZk7+vaLqIMYjWqHkjNpBw24sSKJDi44WMumaojFo+ZkJufS6QjtXfTVRtEYMIyRhJvkS2e5g3cF4S459g4iMmuu+unmluiR0b7+vKhe65h0Y3S700CuZLqk2f9+SMCYw+yXAImUaEuLwUCCzbmw0RH/vFdY920XQq72kDKMTqFgiQgz8iUwGLALWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by IA1PR11MB8151.namprd11.prod.outlook.com (2603:10b6:208:44d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 12:02:31 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ec0:108e:7afe:f1a4]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ec0:108e:7afe:f1a4%5]) with mapi id 15.20.6886.034; Mon, 23 Oct 2023
 12:02:31 +0000
From:   "Drewek, Wojciech" <wojciech.drewek@intel.com>
To:     Shinas Rasheed <srasheed@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "hgani@marvell.com" <hgani@marvell.com>,
        "vimleshk@marvell.com" <vimleshk@marvell.com>,
        "Gallen, Erwan" <egallen@redhat.com>,
        mschmidt <mschmidt@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: RE: [PATCH net-next 1/3] octeon_ep: remove dma sync in trasmit path
Thread-Topic: [PATCH net-next 1/3] octeon_ep: remove dma sync in trasmit path
Thread-Index: AQHaBaaCzcrb+QRMCk2jP0Wj9GkRKrBXRMrg
Date:   Mon, 23 Oct 2023 12:02:31 +0000
Message-ID: <MW4PR11MB5776017470E5871819D93D5BFDD8A@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <20231023114449.2362147-1-srasheed@marvell.com>
 <20231023114449.2362147-2-srasheed@marvell.com>
In-Reply-To: <20231023114449.2362147-2-srasheed@marvell.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5776:EE_|IA1PR11MB8151:EE_
x-ms-office365-filtering-correlation-id: f529d658-7feb-40a7-e9c7-08dbd3bfef62
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8/go1cw4SeUyktIvk9oTO1YsuQZIjeMK+XPCEZXGLbYt53jMyzKhUm1j0Ubrye5MXa2p/UN8HqgGWxlK0N9nR9m4vn3CNGBb0zJ6tBa6RcB73QmmSpqOeAnjh3SlfIlmzf17G4NEEHX1pLqGejgRl85d3OptwntMP+bctWeS1BPZ1vwNAwCbktdfCDBnpgTdHn2v6HzI6EozAynhdJTRKmaS3qr5zs63PbQVTmbiGJiPNTgx9J1b4g98z4mjvfi0Cf9MQFP0qwwX8VMrzGTmU6Qa/vAPlzrgq9iakVunD6v+4BQihSKBYYmrALUu1Q2NaNsjdwWW3z59J8Tz724MseTMxNiKezPzC4Ea8JbeermYL2A9DT5IQ6j6ks4zjByCsNHGL5kZfCouiEs696he8w2g9gv51Y2M3vzLrDmBFag0VMd3uCzvjngwYzXPIckAl43v5sfhv2Jt8QkWuAFxTk3HZw7/PKbLIrAVqF8WqmUcFJdqdgDoZl96mH+/O2sDPw8H3jy00MO3SjjNdeFlLHBbf7N5qMR7b4r1NKBz+MrX8LFrpyYFCJ7F1qWYIGTBl5vQ1kCtWXVxp6bjot074oQvamvl2k/hKaWA6XtJYVk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(55016003)(110136005)(76116006)(66946007)(66556008)(66476007)(64756008)(54906003)(122000001)(316002)(478600001)(82960400001)(86362001)(66446008)(33656002)(7416002)(52536014)(4326008)(8936002)(83380400001)(41300700001)(5660300002)(8676002)(7696005)(6506007)(38100700002)(71200400001)(9686003)(2906002)(53546011)(26005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kAyZLvyt3Zi7PUsm2kJdExA2jDfuZFtf6Tl+TGVRVeJl1uuicD9Be69PIgOz?=
 =?us-ascii?Q?AgyX8RNcxRO0bVGC7yEf94+Ps9DStfcMsVIbNxffXiSDDdt4TZmIPuOwz5oa?=
 =?us-ascii?Q?0a8jQDb8/LG6JdpNYiB+0wKCHNH93nLVUuDceNdyIQ8wSR1gm0xKFnGfUgnc?=
 =?us-ascii?Q?ZRFz9HedNYzCxu9hZRZMJeGldq7YqwvSpuFqQgZkx7YjmSLqNVRTQ6sY3kT5?=
 =?us-ascii?Q?Kedm91njKofAVXEuN8nUPzsMl+DiVh/k8y88KBiNzisC3+eGjBDDBW5+vEZ2?=
 =?us-ascii?Q?OvX9KWvdbBuRSC1ySXrmi6vp2QlQiGgsWkXlACq0XMkBmg9PtCpVU3uE+xxF?=
 =?us-ascii?Q?hED+4MCau5xXHbXuWYJlEROYTF2Xm2sM94yE123mO6LICCpjISuvWMG6UzrJ?=
 =?us-ascii?Q?YEzfRj+L5RDZuNqQ4FPfxJL3N15mKn+w62zYnihgTMvvQxc0XclLp7W/MLJO?=
 =?us-ascii?Q?bWcMPSXJrEGjFPjVik0aLXogJ6Mg49PhB7q7DG7d+6j825gb6gjBkc++qa0+?=
 =?us-ascii?Q?AZzseplKVea9srf9Yo+XA8lih1kPO/FllMZyAR76lhbD1TSpr/jMZJyLcAUX?=
 =?us-ascii?Q?tb8VefmN2AdDxsuhmWoxGuIFNTJLWNx/Wb7Htxm7NpYAYs2kXsfkKT7CEk6h?=
 =?us-ascii?Q?JHpX+w7PjVYQ0wn2jqRABTAU/n6mfM1pGFD3wL5J5/mlsMbrsiXPaaHCq2km?=
 =?us-ascii?Q?eUi3y8yvrUVRcKeo+GSUyUkG9O5oc/ZDvi7IVm7Og2GBhhkNURb9OLx9AXQZ?=
 =?us-ascii?Q?cQAlgTxcfJzldOewGxRhW6icfXpa8Rzpz/uO5fxXZ/Rux/rigkitk5BEufjG?=
 =?us-ascii?Q?ZDzEufgDrE5a65OMw0bXrt79qdG1/lifJCVQTRBBQpcpMWNPxMmH9gqSLSgv?=
 =?us-ascii?Q?E7pzB6MABzUr27vEtGrlR9n5qpgQ5/+iyVuAzQM7vFnIf7Yek73pS/xyC4RE?=
 =?us-ascii?Q?ksTLWF4M5XYIODv/8uQtCTfGFvKZs6yYpCatmZQecwL4cjpOA3819OUlkOab?=
 =?us-ascii?Q?Jw/uMZAE5rzoJMy2d82vv71RSIWIf7541ar6X2dytRdBWmb1pS459mS/TBxY?=
 =?us-ascii?Q?m8SDt1UyixK82JV7l4TSWbBpJbJcqiJhFMYIAt+PpNMBbAPjS2rhpKsCaWJQ?=
 =?us-ascii?Q?71dYY0J4GCrt/NwHKo8gqt9ThNFPxhBTNchSogPRAtT086W51tQgoPrVFPSY?=
 =?us-ascii?Q?rNxzM1CSvODYQRTee54pF7FhC0rmYw85VcNjemc0wWUZUPFr/99FGs2YhBcx?=
 =?us-ascii?Q?3zDswizITv3SG5kOAoT7YpMws0AkQE2FUAAHWcPVIvbBktG95ah5Y5FOo9ND?=
 =?us-ascii?Q?hxW29t4xHYbomDugdc/35ZwEK8VaaxioE0x+W1W+jCkqK2de4yk+G8xNYceI?=
 =?us-ascii?Q?YhG4EKRPkeU1JA8NbTogriXOlJV6gORuZeXZUW2sm7LdTn0t3Cp1Gf1e8lMr?=
 =?us-ascii?Q?ee2K4iVjBU/lTSC+0ag3THOUM9cOXuODK0xi4JmHCoAoKh8pF7T+uCfFL4q6?=
 =?us-ascii?Q?bf0xv311OC4KR/60VLaIF3LtsVrZjSTsSWvWOXUY5xdLSCWhuPm74nFK8d6v?=
 =?us-ascii?Q?Khy7Q7MbA8qmr/3E2clcz/f+uH4LE25eKyuV4eRt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f529d658-7feb-40a7-e9c7-08dbd3bfef62
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 12:02:31.1382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/TrKOJGzc4XN8/Nf0c7/VI1tPugIw+MC/PXTvVZfjIE2CWqYqqPqYJHLBbrjW9WWEUXUVrmJugyJquozh7ZXS3QsBw0OUvcIfWXLnK1pPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8151
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shinas Rasheed <srasheed@marvell.com>
> Sent: Monday, October 23, 2023 1:45 PM
> To: netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: hgani@marvell.com; vimleshk@marvell.com; Gallen, Erwan <egallen@redha=
t.com>; mschmidt <mschmidt@redhat.com>;
> pabeni@redhat.com; horms@kernel.org; kuba@kernel.org; davem@davemloft.net=
; Shinas Rasheed <srasheed@marvell.com>;
> Veerasenareddy Burru <vburru@marvell.com>; Sathesh Edara <sedara@marvell.=
com>; Eric Dumazet <edumazet@google.com>
> Subject: [PATCH net-next 1/3] octeon_ep: remove dma sync in trasmit path
>=20
> Cleanup dma sync calls for scatter gather
> mappings in trasmit path
>=20
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>

Hi Shinas,

The commit msg only says what changed without justification.
What is the reasoning behind those changes?

> ---
>  drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/driver=
s/net/ethernet/marvell/octeon_ep/octep_main.c
> index 552970c7dec0..bf1e376a4232 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -869,9 +869,6 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *s=
kb,
>  		if (dma_mapping_error(iq->dev, dma))
>  			goto dma_map_err;
>=20
> -		dma_sync_single_for_cpu(iq->dev, tx_buffer->sglist_dma,
> -					OCTEP_SGLIST_SIZE_PER_PKT,
> -					DMA_TO_DEVICE);
>  		memset(sglist, 0, OCTEP_SGLIST_SIZE_PER_PKT);
>  		sglist[0].len[3] =3D len;
>  		sglist[0].dma_ptr[0] =3D dma;
> @@ -891,10 +888,6 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *=
skb,
>  			frag++;
>  			si++;
>  		}
> -		dma_sync_single_for_device(iq->dev, tx_buffer->sglist_dma,
> -					   OCTEP_SGLIST_SIZE_PER_PKT,
> -					   DMA_TO_DEVICE);
> -
>  		hw_desc->dptr =3D tx_buffer->sglist_dma;
>  	}
>=20
> --
> 2.25.1
>=20

