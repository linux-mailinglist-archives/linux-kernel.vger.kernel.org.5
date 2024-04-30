Return-Path: <linux-kernel+bounces-164560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE928B7F50
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D971F22DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1656F18130A;
	Tue, 30 Apr 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="myISCsA+"
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED03175560;
	Tue, 30 Apr 2024 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499918; cv=fail; b=fs8+q0uaFHWY2dNU0due50MuNkwNVQ8LdFLhRsYApgZyJUHFRfme8mTC7US4af1KlTRihgxE9LjFWHXh/dCbMbO5LgutXfRZcvqMFNijgLp4DG38Z0Gcru9GpZQOTiYwDSyGqgBtShALOUZGcQryCut2g27vhAUbeJ5cFLPDkus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499918; c=relaxed/simple;
	bh=4Agl+fcCzYn8PnIq8toF858m+KRcaeOOQLS2JrB/S4w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B5LDZYAxqIbOLObyWaOssXO6mXgSfAbqOYQUJwC/LkdhZkM+hq47hVpmb4L1rPTpI+zttn0H0Z6DlIPUl+/WBBPiTWRG/dcQtINTBnb/mCZ/fTgjxmitgjM/ihEk4RC0oklxWg18bnp0lEJHnDvyY7zTWBL+IW5VzI5tNNxUEsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=myISCsA+; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43UFwVtT032558;
	Tue, 30 Apr 2024 17:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=pca2joePjy0RMdNvE2UeCqkqSvYmtISFWhl+yhcfR/M=;
 b=myISCsA+V2zZLJxNx5Ux40qy6BVgHvK8QWyHKjk8CU3KDtyVQJzYOaOC776AjJTCgdn1
 KvkAw665ZWw1dV47ur7qilUh7Y2qCus2XFwMuVva3bOs1gGa9l6koNuR7i9/WWDqeM3c
 hfd8ZArLV2wseJEkFiNvHicdiYFk/YnEeRslT92+FGf+PcuI3vwrf8SPn6dgrjSe5VHA
 SPMVm0N+G+SOnm55bLIIY97yK/9jEbFd4595gP2FBsWdqPmnvTD+ctetAllX6in+fYUo
 FcZTcn87sGPrMdtTa03X/jSugSOFgArvDH8+qJUmJALySBZPuFk+Cxo+Ab7fQx/B5dYH 1Q== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3xrqjjubdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 17:58:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUV/AFk2p1ad158oJzsE2LENdY3QEJ7sWmw0EHOaamNWDyivcCBvU8yWIGVWn1qJojq33vgqefJ39ZzW+K+brmZ+jz4j9MoQS9aXZAdFMuqrbuPAkVKcXw6JXfgLiZXVSn9PIGYFA1SfZipc+Y05CPkT850/e9rUFBfrYRFujV1K2NQNf70fXdg8izB2rHBG3cy2YPrjbMTNTdZPQifskkCBphMLUe+u0IxU0jHLCPNjWXZ3fSgIMYmQGC9oOc81fWbvlqd0t00Ke0DXkRBBV3aqPTYt4pMZLgFpHzdQ5iYujXtWa7pQyBjLPG41ds19l2sHPbk0SaRBRH7ZBghyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pca2joePjy0RMdNvE2UeCqkqSvYmtISFWhl+yhcfR/M=;
 b=b9TK/C9yfuR20AiqPwdKiXAX3m0Ny08XencMIMI5ikN2QAuMlraO5qxICK1DF0pXk8wwfJ0QF4DwN2j3caupsQ70YkybkQIDmnRl29EpLI62JksYBy/HWW89WuyhX3tx/lg7LfEm5ehRg2hz4jaTPEQqT6z52OzATH8JxcU6Z7q0LnCy/gCztGUyaExYXEV0n8BewPv/Wu11WBl0T3CWvHWbENHCzV+vGEcDbveZ3bQSA5VAnUm6vH28ltNNmKr7k0zgAsQcrXQwH5ZXCynBl14EKsONJ5B6EPvl0RuaKo1GtEX+91yFGPe63PLDzk7EoJ+T5oGE5hrdMgUPKfBtLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from SA3PR13MB6372.namprd13.prod.outlook.com (2603:10b6:806:37d::13)
 by IA2PR13MB6752.namprd13.prod.outlook.com (2603:10b6:208:4bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21; Tue, 30 Apr
 2024 17:58:13 +0000
Received: from SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::2dee:b93e:d9f:d7b6]) by SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::2dee:b93e:d9f:d7b6%5]) with mapi id 15.20.7544.019; Tue, 30 Apr 2024
 17:58:13 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>,
        Greg KroahHartman
	<gregkh@linuxfoundation.org>
CC: "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] scripts/spdxcheck: Add count of missing files to stats output
Thread-Topic: [PATCH] scripts/spdxcheck: Add count of missing files to stats
 output
Thread-Index: AdqbJ9yxHa6H1Sw/QPWZskNLY/y5Pg==
Date: Tue, 30 Apr 2024 17:58:13 +0000
Message-ID: 
 <SA3PR13MB6372DB9F9F2C09F8A1E1B99BFD1A2@SA3PR13MB6372.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR13MB6372:EE_|IA2PR13MB6752:EE_
x-ms-office365-filtering-correlation-id: b19c6c9c-19c2-47fb-8d78-08dc693f1b03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?F8FpTqbapDPIaF+pVRp8PbmZHcraFxgL9FiEpH3mxoXAwEGSL8qkuFgSZs3z?=
 =?us-ascii?Q?JJ1HRv8TeDfe/8QLkJrZZjAyP0VIx+Wz1Z/tDJYEX9dxJw7oEyr8qcSCEYd0?=
 =?us-ascii?Q?3h61apISTpJ+x5TNUUSQEvnaodegDA84IsDu8SpNnTVXGZcRhCNDX67HIHcp?=
 =?us-ascii?Q?xjPOqa9Oel4jjV7gy0DoZP7GsEfGHdgf0pBMeWB5JTXaW9n55oiTC9ID+oDn?=
 =?us-ascii?Q?9sznrQK3uqqlckGveOK4UVAPwnHWrI+lRVpHCRI1RfjGPW8+hpCko1A49dQS?=
 =?us-ascii?Q?Fd0nKVeVpqhUQjUIMuC5AYTSAs6NfaWYMVjdSxU4/YHepgN70+jbf8b7qrSq?=
 =?us-ascii?Q?yA4ZoMxi5VVOT3+EPInwPbiMb7aMjqOktuhT85718CY1Y1I647PpLllLPKBb?=
 =?us-ascii?Q?pG31I9XfPUZCzGJfdv6lDhssxV6Wm2RvrBd71GIXMxTzdghgLw1aaLLqSSmX?=
 =?us-ascii?Q?9Usdle8BDStmQ4/OmK0dYBNnoZcAGFeuvd0vYS62heEDWWZmPCxG5xGKOJRl?=
 =?us-ascii?Q?AkMCeJ37hsG00lQpPiYRHBvhITXsY4G/fT0JdUkkUtZRE2nLdvGq1akn1vkE?=
 =?us-ascii?Q?YluKji5elDhZ0b9G3X6jg6gK2EHVPwkCmpJ8feABtw4hDhh/lh9uggNcvx5d?=
 =?us-ascii?Q?mxHHVLEzD5XDBpUE6WpZ5iCKr6w6I5fGtVw5FEHuuc17ns6J2ip6B/Bxummi?=
 =?us-ascii?Q?vMYTN8+tiHW0VImX2BcG5tuN2H50tHSG7ArGicEIuiEah94nuwcg73gBZJ7r?=
 =?us-ascii?Q?MmaT+KoB0dgOOxsZ0uzaJYyZbUf1cs1CVeVl/VQIKyzUg7ar8bdRmXTB1DJk?=
 =?us-ascii?Q?0mROgVccmIl5Ax5qtLBT9ZdeRwhvduaEip51bzSgMRYtgin2lFZgRKL7/V/1?=
 =?us-ascii?Q?bMkyeGxkVkXh1rLWzj02JIf3ImuGChqh6KNpE+ldv8c/dgHuPnZPtP80wTYk?=
 =?us-ascii?Q?vKEvk1sUA6GjYWPVP+1aXVdRsFafGgUe4ww9f3E8hOGqh5v6jRWTbSstSEfa?=
 =?us-ascii?Q?wShTvX7qIWNvhQhTJ9YtIFXKWnTXATqPTtYsQmrnz6cBeRYAVzfk5IdwiytU?=
 =?us-ascii?Q?LsbYHq9ral3hVTCJIjzTvGjpxX4gJjW2+bTi0Z7S4c0DKuq6dPw+GTo0zuHd?=
 =?us-ascii?Q?p5+NSB40/EO5Hqxy8le6pXQ3EHs4zzjpg5ZVSSVEIZ7j2midhCELP4XCO69N?=
 =?us-ascii?Q?mTSM6wdLntXCWR/D31jA7zGnPuLwssre3cf69Re3QX//No1tgaHoNVyhnUvJ?=
 =?us-ascii?Q?SCA3j4T2l0jQ9uiV0BAYpQHpU2SG+mwDo6v39mzNjXdjdQSDzMt29fiO1U1G?=
 =?us-ascii?Q?SonEFzUYnGEYr/iP/VnztMCqR3tIirtBA7LrMST4kCdBwA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR13MB6372.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?usQ806AaCD5x4kHOGgINH6icgG5d1ZWPn/1/hRCTmS8jorN28Kgoa5+ivCyB?=
 =?us-ascii?Q?Bxo3WUYZPP62wU04wODcSOoaNxt+Eux0l461bY0pIzViBBqrMhzG4emkfs5a?=
 =?us-ascii?Q?UWKq6eWh6bxGLS5WwsNtliw9xMhm0Le3Q9CYIKtoWUTFlQVnnkjpYVLM1ADo?=
 =?us-ascii?Q?dEZGtH4NNYNHcKCoQEFAxb5LSeapDXBb6jKnSYDCC1blewPVQdiyU9LBvhZG?=
 =?us-ascii?Q?1b/ESJKRRYX/niqet1sdpJPH60hgSQIse3BgLlaPKStIKwFVUno2dxKgKTVV?=
 =?us-ascii?Q?X9CQ6Fkh1MkV5mmvltQ9oyeb9FFTGu10D60YBCpH+kSOGCgaMsGruLd0XgNT?=
 =?us-ascii?Q?N3EKgW6gZSoGyx6jB0PaqPSoRsetXGNN/gd9b5Pl/7SNzZPJ0hL81NL47h0l?=
 =?us-ascii?Q?E2K3itqwK8yD5kfTT2NfXMHEDaAQf9/Wk4ElxmlwHbI2PvQTUSXHOkbv/cMs?=
 =?us-ascii?Q?+2VAkUeNLvSJ3gT3ymNu332D7GTGpHQtXTPumIGA0uQFD3+CyZJeYO7HHcL4?=
 =?us-ascii?Q?S5UCejEZohgMye3Z45GdmMyZ9iRnA6x5+mjVnJRwWObXANubdRF6GVuFon71?=
 =?us-ascii?Q?B3kUyIKMeNqtyuidAnlyxuCGMn6iiphhc3LblZHfqedPQWnJrMJ/zObuod5u?=
 =?us-ascii?Q?byLs2NwoEGtJPzt9u3Q7W6ukP9zl7csJkWmmhs42xldcYbzjL/nVALI0GnIc?=
 =?us-ascii?Q?ByErRYhofsbGMHCew7ASjc27MHefiU1SIbyUctpxn+8wYlmEq76F1zdGdm42?=
 =?us-ascii?Q?C1/O4Ov1IUVmKSYvXO2d3jO8kAEkrgVjMvdZt+v2FxKDJexoy4OkZHNkaILg?=
 =?us-ascii?Q?ANoPil1snT+89+izah16c+gLZ0f9qKPWHWExAofkwdTJRaPnXDkulw6IRUMk?=
 =?us-ascii?Q?jKzi9POhuZDIhRphhbwGSRajB+yNoLVGqzDfQKtH8hDVA0hYCINezz8qawAQ?=
 =?us-ascii?Q?hF8ZejI5X1P22+ZbDLGbze266Sri1RBD3EJFH5FzlT7U9oSGq9m0Cypep2r2?=
 =?us-ascii?Q?92t6d5HWgZ9ntb55Rx7BmLrna7lPyilbHSnLeFpEQqslBI6Q+EdjvUnfvaMm?=
 =?us-ascii?Q?m6unkfr3pV+gFk8R7wXXa18VUXhpTGMo16e8v24NzhIgoDyyz5bWbZ8DCy1e?=
 =?us-ascii?Q?4xxVs9YsngnAGNtXvgr4Hs3MuM4k7BQQLK+tTdrPu+9J3Rz5VnTOwQkmWKXP?=
 =?us-ascii?Q?yAkqu0A5GS/7w0gbmf0CNUewzInTfc2rXo5IglDOMRqHj17fITW+gJjNk4m/?=
 =?us-ascii?Q?e2BZjDvUWpmPIaNjfQ1rHKUt9S1FmcH9GcOHsZX4bGBXhFKaLJ+RtK2KT2iT?=
 =?us-ascii?Q?4QgNczKDYP74mZJPm/6MR6Nvfl+PSJy5jBBEPgK4ENpjFyCx3vWwujO1edmU?=
 =?us-ascii?Q?gj1io2TNVXO7QwoXPrYM1TLuE5gNSvaLdgDKaCVaAHzHPm+bJrT33vx4Nhq2?=
 =?us-ascii?Q?aBVrYZ9tNZ8uJo+7ZMtIHvJXSl/3QBp0/YD3om5aOVYEKu0AsbaEbMPI3C2V?=
 =?us-ascii?Q?PMl0zUwjtOR90SVDkksk4P5RqjUnie/kBLL6eEWS19mjwDG/2FGgvUcH3AjQ?=
 =?us-ascii?Q?mHaXm++c5vn4iMSdTx0=3D?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GnM5moPi1SpHfQU6a3mJ4YbCgeq3DcN/7o5m1Eo8JPPI5ua4Iem4LoTh1JBkYEVeVenzUIQbxjlfTbJqP4Po9igYapSRR64o+UxVRSRgonpTyJ8c6QEO0xoNsQ+LF7CK5pHjqJtVwlXbPyi3FElZreps41KkjrDWtgIo+aCVm94BHxPjbyIzZ01CdUI+9qSE44FF5Z9dXkfLiKxYh3K5J4iDLnU7NUzJatpYdNkK1hg7UWl/YlZ8DQZNbb9bhaGehpawx9YpKGnjg8jFd2uBTfwWzH+5Jq0oe2msdmnezQ5bq8Se8WqCwXxnr7Mz0t+LPA/gcXNAbKpQs28LZjlZwrhjh4gxC/I3gPz0PEGROyZrqr7PM2mlVF4QvnA+1aYzU97mGlFTHuV6xWqJEANPTASfzYaH07xmvzBa8dQWK287GbO5VPtywjn5Q6Qfes/csaNKwW6pqLMW5b6yjIfmiZsONObO8Ema/n967wS7skdgbyAhLmkENo5LoqaVf19e2jToXgtj3+KTBhIQc4Ge/7NuQxMjBVuK2ZOIR/UKWlXEoyfTyjGEL/oirVHt2WIfWd/WDvPX8mxdDN5d1BPEDYEGqtjNK6zLFVo2ebDo/mZxp13zaaW8vp5wvvnDRgn3
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR13MB6372.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19c6c9c-19c2-47fb-8d78-08dc693f1b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 17:58:13.6440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KkQxmhEHDSpm52/+S1Y7MM1YmCPEIjlN+H2KKURxqA2BSE3TsNqIHRPIJ3fSQOAUK8qIcb+NuFeE7+93NEx8/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR13MB6752
X-Proofpoint-ORIG-GUID: ixuBitgZeCGO_DYhg773i1dKd6G6v2kJ
X-Proofpoint-GUID: ixuBitgZeCGO_DYhg773i1dKd6G6v2kJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Sony-Outbound-GUID: ixuBitgZeCGO_DYhg773i1dKd6G6v2kJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_10,2024-04-30_01,2023-05-22_02

Add a count of files missing an SPDX header to the stats
output.  This is useful detailed information for working
on SPDX header additions.

Signed-off-by: Tim Bird <tim.bird@sony.com>
---
 scripts/spdxcheck.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 18cb9f5b3d3d..8b8fb115fc81 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -412,6 +412,9 @@ if __name__ =3D=3D '__main__':
                 if parser.checked:
                     pc =3D int(100 * parser.spdx_valid / parser.checked)
                     sys.stderr.write('Files with SPDX:   %12d %3d%%\n' %(p=
arser.spdx_valid, pc))
+                    missing =3D parser.checked - parser.spdx_valid
+                    mpc =3D int(100 * missing / parser.checked)
+                    sys.stderr.write('Files without SPDX:%12d %3d%%\n' %(m=
issing, mpc))
                 sys.stderr.write('Files with errors: %12d\n' %parser.spdx_=
errors)
                 if ndirs:
                     sys.stderr.write('\n')
--=20
2.25.1


