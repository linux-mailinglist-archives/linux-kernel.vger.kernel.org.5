Return-Path: <linux-kernel+bounces-134844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E637589B7BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153591C21738
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C046B1755B;
	Mon,  8 Apr 2024 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DjjcCXGX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154DF111A8;
	Mon,  8 Apr 2024 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558363; cv=fail; b=ByOInwGXcrjRd9KKALoa3r1q461GQvU9YfCal6oIwlwHIKOL/k+mw3shlZHStSiaK0ykq9M1XoAVEfG2PfauBuwwpth/KJLG51wTcWPa4YG61r/uWJWFuiFi2yjVGMDqhNGQj2uoKMPtFv0NKhakKOXaPduuGHwx1DHc5RnxSQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558363; c=relaxed/simple;
	bh=oAk7ZHeaw6E3NlZSqIATceayczc4hILR4p8QmKP8Fh8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u0vuex+QBv75xrvq87K/tNmHwzy9SYdy0Ivg52nWkGOsiAhtcD8oCV6Zg3vjJsz0p46ykUhyrmZsk/QMYeQr0zUTm+ONU2A0hMTHgNm2XdZLvI0y7R0jJEaWspTrszyh9D0ZB/ePPtjFx04tPSY0BLllRil9OMohfDdcrLNZGXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DjjcCXGX; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712558363; x=1744094363;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oAk7ZHeaw6E3NlZSqIATceayczc4hILR4p8QmKP8Fh8=;
  b=DjjcCXGX6ahCg1BgeJYjWpzxPJ2qeaY5Mzk0PsZNiMHKMAPLZ7i4cNJc
   S/00jmlr9Bi8O8z7oi2n2y2sh25Q3Dpuh1XANoP7SsSWjuAaMF+oefKfa
   Y5gQ7ojLPWc2o0A5M2yyZz3i6HtKyv2jCYaX7u1m19L+TdW1H4Bl5oLwx
   hAJ0eQbk56GFOeTvByLkvNgcjTtFXjKIJwgkj+AKn2ZmUpAqQc742+XYE
   7LS9xi3svNyiCriDiq8/lu01tcsYF2BRnMVR08XetqwIBjMJgKPc5sUNl
   scw7kCvIljuqDIAVxhfJ4qKiNf2NWtbEgh8FBwU9B9HoowBAiTEMcV+g/
   A==;
X-CSE-ConnectionGUID: 1OmXA7qoS327NZkgpYtTxQ==
X-CSE-MsgGUID: 5Dpz0/NKSVKpjWeCaH1M3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="8045924"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="8045924"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 23:39:22 -0700
X-CSE-ConnectionGUID: btx/Zy5AQxKi/1kTmf6VvQ==
X-CSE-MsgGUID: BpDmw0ktSAiazbNEZA6Lbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19649589"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 23:39:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 23:39:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 23:39:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 23:39:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEZunGSQiECuSv+cYcoTjfw94QMW+Hmojm7zljPeDKDyJFBx2pg5jRbmLkGa4chZzM1F7nZNRQ628gy2QdocN/UwlTfuVi2GUxAiEp4xBaHOB1oAAp3MepdATzTdkJw9SGEh5S6run01hHvjlXcwXrSUg2cQd9hWpb/QELONAW4aIJGgrPrRpspk/A1zGNBIGn++qFhRbYPjdgaRoV1HO+yEcF8gifQHWsg7jWLDUzFEn0UQF0Fnox1T5DSdfPz05+6RRQeNh4Nh9fnTdCoAA9nKggtNZEU22tARqjx1PUY/mOfrmkBDcJkF4/HfMcic9O0LO+BQAQt9iyddiPDOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=in0Awr+bi6+/QuQ/0Tz+KL4Da4OYEkimdd8Z41X3Se8=;
 b=d9BvHu9bEvpMvdmBFadRh9B0Teet81fUvqgphhJJQm/SjOcFUiWyKOkz1gX0lRcoG62G64EtTcqxnVZp4Bw9yUJBly1gY8lauqcXASeb110wt97hStCiTIOPJmPZ3ENQCr87IfWOaj/6IP+mmRJOWwZqHO6nRdtlW7tJYjWqgRwe7mlviaVDlOkRfAHQTlKzdFyh7FUB5uLiPS8ft3/IIeXHPpSY/+cuEDBx6XBVJaLI9NiNtL/xAXQICmCd77HEp9rA3kpB/SJ0pj+iawLlivnabOldbgM1M4uojiWdPrs0XDw4mS2XYX8G4hJiqjR2fCjwKgk8ZHmWPk7+EQP3ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8436.namprd11.prod.outlook.com (2603:10b6:610:173::9)
 by DS0PR11MB8686.namprd11.prod.outlook.com (2603:10b6:8:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 8 Apr
 2024 06:39:05 +0000
Received: from CH3PR11MB8436.namprd11.prod.outlook.com
 ([fe80::8502:b1cd:d62:147c]) by CH3PR11MB8436.namprd11.prod.outlook.com
 ([fe80::8502:b1cd:d62:147c%7]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 06:39:05 +0000
From: "Liao, Bard" <bard.liao@intel.com>
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
CC: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
Subject: RE: [PATCH 4/7] soundwire: reconcile dp0_prop and dpn_prop
Thread-Topic: [PATCH 4/7] soundwire: reconcile dp0_prop and dpn_prop
Thread-Index: AQHaf1w3hJjp48qcEUmF4FwP+Ai227FZm1SAgARktRA=
Date: Mon, 8 Apr 2024 06:39:05 +0000
Message-ID: <CH3PR11MB8436016A3DE30D26823E320BFF002@CH3PR11MB8436.namprd11.prod.outlook.com>
References: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
 <20240326090122.1051806-5-yung-chuan.liao@linux.intel.com>
 <Zg_hcQ2RUBpkA_DG@matsya>
In-Reply-To: <Zg_hcQ2RUBpkA_DG@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8436:EE_|DS0PR11MB8686:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CFnW0t1V7J74B8gzi5DOI7DcbknddkYdIlibio74YpywaraLbdIwPkJH+p/FiBn1Ay0ays74XElCPkPZpV+jBNlUMTZDxZkO7efHy6W+NZGWCjdLJJkp3ful5SkpHaKIjGArs+CWJrntaxsrzGLLCS6IKdHfUr8tEOovPcA0n01v2Mrh/RHvznfivxG1Dc0X5pGF5TkKm8vtooa52YrDIlNZpK3tLVkbiSrYsUklybPPXJXFlvpkKfVfHcVy7wEejvqqD8RuNojBh6UErr3VkaSCc4HnIEpKRnneMjrpUra4e2Ii0JlBbVvqZuzhukrfbjayuQPl2mb8cC/9j/a9Ak4laQvFqFaeE5SXJy5ERPPF1zb02YkQKt72oflSWWhCzSpRrNITRjZlwdgiPT1ZvA3AyXO85OtAq6WDoD41VbFLBX5hTUmjqx/1kpmEJ8VKF+0S/ULtJNqMDaukrKskBun8cXuCtjGQpdjksNpMx8TEuPZAF3xIxtt2BfOSKrmiI4Wc//lnPK1U0IrNsxGFHPy2+AU8bYm2zIPaOd/eM9JuZRkTBaagC9i9uXKV6n5YuL5jWD9QN3vCbVnqfmn7E63ZBGNgI7gf+fHIIKOsd5/Pwh9qQW9BYaufmOZV2TWrfG1Dr4nLxPdvfY4f5ieujpASg5CaYTB85MkbhPT4Ab0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8436.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LkJit0oTF//BfDm46qUYQgJpkKZ0hETIpJue2vF3DFwwn+e3g+MDJGbh84GE?=
 =?us-ascii?Q?oBPErivlulzfIAYEhq+1Yc0h7qVKJfIw7do+e7bkycIltcGpJTUBN3gso860?=
 =?us-ascii?Q?pfOXryWJdw789jiHZEsc0O8ScNwY27EWejG/v5BZP6sWGdradYGW4c4Hfwei?=
 =?us-ascii?Q?TChGjRLYzNoVJJnc7jtUvBkyY9Kyo6ukTMX+ZJY027THF2cS1Swc4UlSWslS?=
 =?us-ascii?Q?7p9f8w1/wGHtZPbRKcIqUyeZZzckV1hriWQyUaTVDef06Zwe8t5wuPme5iIJ?=
 =?us-ascii?Q?d4oTnRbLBw37wlswYlbdhxd/NNso1HQtHGwzd7+ZEjpH9XlKU7VvAV7bI7M9?=
 =?us-ascii?Q?nlBKIhR2jtbAY6IPu5LOrnZs4rPGXjtYdsweN37DBj+ByQgiSba/iH3ULDqv?=
 =?us-ascii?Q?71NTiPocWtuuvOdnpQ51RF2wxo7Ve7sE57lwNene2gCs4iSVrdiZ8XlGELsJ?=
 =?us-ascii?Q?yH7Q+rtiu4rOJ5U5cGbRJSc7NlGoKyWpGXvSSXTu4XQOgIZk2FoPss1F2SEn?=
 =?us-ascii?Q?Jm1pt94t9UNOqhoN6R9udX5Xi7luXOrTmqoHIeBWv6mcOB5u8YylvuUdoX7j?=
 =?us-ascii?Q?+BL/otn+b7FtuzcJcEglZ84s1sgAgD4gSPD9Mr2vfga98gtfQjKtFyTKZFM/?=
 =?us-ascii?Q?aAj0bSTIdzFHl+sLfJ3+d3OlHKJCoKM8gipkX/upZH2RxvqTcuxwxhxuJwXD?=
 =?us-ascii?Q?oTR0fT1RC77aAr7klD8La0Tjz59AebQ5ZCaXtbIuruMlRqkpnSynHHYKVx0N?=
 =?us-ascii?Q?ukPGkWxAvn+L9bg13lqNlTyCxYHqvspLC4Qm47LoGkCYV2bHEPNCAtXhs8qm?=
 =?us-ascii?Q?oFePeZ9BRAyKIC6J+ghwaGsA9O1HJZXkqEpDlmRNAeiGcbPP1/bHOoySDTCB?=
 =?us-ascii?Q?eu9XGbjJkz655HrAOuvVatandLFuzNelZwUvY3/WCnVB16VAe3L+NrZ7LGy/?=
 =?us-ascii?Q?n8WBg13uZzA/wZJ3qbAqyTD5QUQm9kePT7RvaSBogsovhwP4V7Q3GrBy2XVQ?=
 =?us-ascii?Q?KcADbF5Bud+04RctbmS3J66yiIokDasiFISwFeC7yA8OmbKlioHZNuse7G8z?=
 =?us-ascii?Q?i1XomCVJQWUpfz/Hr55BIhdAjDYiws6Y/y6BTHC1gPdWL0Ph/NqIB91fUvvp?=
 =?us-ascii?Q?NxtYStcLzXhm+iVPk1Y6MuFo6P5LxGhfO10xqbzXD/Zek6JazTU8C1FnPg+A?=
 =?us-ascii?Q?tGW8L8LlYYz6etnS50qU7NYcsxwY3F+/z6pXC8acZpz8HPysPrXXBHR9Gnyz?=
 =?us-ascii?Q?h1Gd/Gxll206QV2N5vSUVy5S1a7jRM/l4KN67WQxgCu8iq3+4JHP2sD3mcSP?=
 =?us-ascii?Q?1vnrpNzVXOAI2MhAmy2MZpgTsRoXKyMSGrgvf98VTwWPjoipG0/Hlvv5qPSd?=
 =?us-ascii?Q?m8K3Q+rkH8lozUelPtcCsSpY7Sql5uxnTf3m+xVsnHMxSD0m2heu7YnmJDhL?=
 =?us-ascii?Q?Fa8Xcm4Oq1MWhT5GPE1/6TypCyE/gXl7TTc65GNx+Ke0J7MJ32tGWeP9/PdS?=
 =?us-ascii?Q?Uxk4hOEYKy1wYYoNQ0oocThHITmAWepkZ7NjHF7ikpcLQZIXvhmeoTWV2tkH?=
 =?us-ascii?Q?Ea8EmfZwuqql98UhiRQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8436.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2beef7-f5f1-4f2f-0a98-08dc57969631
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 06:39:05.6062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LdaM0F18HlDQ0as8xotzVSaAa7N7dt2LKnvXT2I+YpTaja1pbxN5yk78yMQO9HGWm2xHqNmE6NUpzsoGSq/hkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8686
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Friday, April 5, 2024 7:33 PM
> To: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: linux-sound@vger.kernel.org; linux-kernel@vger.kernel.org; pierre-
> louis.bossart@linux.intel.com; Liao, Bard <bard.liao@intel.com>
> Subject: Re: [PATCH 4/7] soundwire: reconcile dp0_prop and dpn_prop
>=20
> On 26-03-24, 09:01, Bard Liao wrote:
> > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >
> > The definitions for DP0 are missing a set of fields that are required
> > to reuse the same configuration code as DPn.
> >
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.c=
om>
> > Reviewed-by: Rander Wang <rander.wang@intel.com>
> > Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > ---
> >  include/linux/soundwire/sdw.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sd=
w.h
> > index e5d0aa58e7f6..e3a4bccc2a7e 100644
> > --- a/include/linux/soundwire/sdw.h
> > +++ b/include/linux/soundwire/sdw.h
> > @@ -235,7 +235,8 @@ enum sdw_clk_stop_mode {
> >   * @BRA_flow_controlled: Slave implementation results in an OK_NotRead=
y
> >   * response
> >   * @simple_ch_prep_sm: If channel prepare sequence is required
> > - * @imp_def_interrupts: If set, each bit corresponds to support for
> > +  * @ch_prep_timeout: Port-specific timeout value, in milliseconds
> > +  * @imp_def_interrupts: If set, each bit corresponds to support for
>=20
> why is this line modified? seems to be same as previous and leading
> space added which might not be correct

Thanks for pointing this out. Sent v2 to fix it.

>=20
>=20
> >   * implementation-defined interrupts
> >   *
> >   * The wordlengths are specified by Spec as max, min AND number of
> > @@ -249,6 +250,7 @@ struct sdw_dp0_prop {
> >  	u32 *words;
> >  	bool BRA_flow_controlled;
> >  	bool simple_ch_prep_sm;
> > +	u32 ch_prep_timeout;
> >  	bool imp_def_interrupts;
> >  };
> >
> > --
> > 2.34.1
>=20
> --
> ~Vinod

