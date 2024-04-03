Return-Path: <linux-kernel+bounces-129688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00676896E73
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68912847E5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BEA143899;
	Wed,  3 Apr 2024 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WMuLA+nf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="T/2oeYFS"
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF417583;
	Wed,  3 Apr 2024 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144913; cv=fail; b=AKyapKJK9SGhsW4732zULzmCecF0Tib8S6UKV7D6VQb8TD9VCCCjAHE+MUrHPbixwzKgRArBOOUt64aDvOX3DIy/V/7ewZhpmB4wOAdFYTsGwcnR6UU2TzdgY0BdBLAUzb/D5Eq1KSeKQtJmeVgrMAjOg46UyYPPxuDt5Mnh77s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144913; c=relaxed/simple;
	bh=m3gWaZJJ2S4bEC7Eiq2lGy7y+bSAesVW1AKfM5nrnPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AE+OHqhqgLK4TX7Ap3xxlvwVSjxoa+VowJa/4u0nuetDECKGhCoLtaoFH9yuYU/4iD8fr6tWYArR5yPdyuxur0ac0FPI0pD0/6MKgCSkRrR3Hj+s5YGmVfNypUZZ32QHWHe4YYB/fQPkBl4hiqmy7UxnH1/kfhy/7M3PCHvFEao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WMuLA+nf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=T/2oeYFS; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712144911; x=1743680911;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m3gWaZJJ2S4bEC7Eiq2lGy7y+bSAesVW1AKfM5nrnPQ=;
  b=WMuLA+nf3cYq814WECj8PjBDuY/LR0E19xfEAOQ8Aw07ZcYfgqqM+aH4
   wANwCSjgP+iYpkPC8Op9UPCMJA6ddmjugdIZHgFVHhMiAkW/jLNaIgKR1
   Jxo9qkKmOLFo7/tX+USEHLHn0InH2uaLHKpdHNjjP3AbKefP/7QNUMz9f
   XCPycQDlsyeA8PJR2iCNrFQ3CU8V4aNNtJnUibwuZm8LrRB3Y7t4jMMiY
   woW76w0KJX9gFa8kvsTovsakTpZpOQ1ipZn8BvfcGjno9LKHeLyUpHFz3
   XQzB9cvhqYWbQOmcyhFLITVhH+QgBdGODCllmXHq9fQ5GMZMrxh1HA4Np
   w==;
X-CSE-ConnectionGUID: 9fQnMUwLSje06LufEYeS7w==
X-CSE-MsgGUID: UUJ9LQ4QQAyCRc/N0QVWgA==
X-IronPort-AV: E=Sophos;i="6.07,177,1708358400"; 
   d="scan'208";a="12633034"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2024 19:48:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJsiYUQbf9l+SgJmIf4GTdJtiPZK1hZKfxRQl5Rt2Ik/FbYaehagrUSQ5Ce6X06Ms0Jh/Praq42wktD+2zBqXwoN5kVh2OvhRBS1W05zjVeR1r9NXtAL4MyAkbzYwRGyveztXTwxoT31Sed6pjyFZsltuv+JvwNOFV1ErY8YW7No6Gnxpj7s+f0p1hZCRkvA5t8HSVnzqQKsesPZMvwHOith+B9N97WlzP56IyxDhvv13+TyJ/SllJrb9zbz6iEQM346Bsj8dR900nspqCoSV2FLq23oW3nW83JbgTWQfEb25XiVLcjNyNSCFwJgswxta1J+3rgT8wNT8NOnnnMlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ec0v5/taZyNZN/Do9/tBAB4vB7E/zrGlhmkAcIBEkiU=;
 b=WuGFXJhimJYnyozftInnSMh7RMuJyYznW+FiFOI9PQ5Zw5oZZ1UVOPms6L7XUGS0kb4kan51VWE9bdPnlyo1cs95SHDG02uY6HS5y+NuNvOh9UDdeotxSOsXd8AqQU/LjL1hW7xQUiW8UNUpHYDiHzk2YNXwcfwjdDlZDJhFHCWnpsJebQSvqPP1QXqz1GVgJvZysQZwfUmFSi/2IYugA1UGBFQq6OqZ1TdIjxOYS1TupsSLECGxEsow3roiHj0yW9YOGsGqUWj/DiXnMZKbQAOaw7GrWy5gTpk/x/LUmFQncV6djBWcG9m7fqr+ZHjFUErMl2mFVwquuQ21KrrLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ec0v5/taZyNZN/Do9/tBAB4vB7E/zrGlhmkAcIBEkiU=;
 b=T/2oeYFSSgbLmVuD5URyRlZevAUznxlcDX09oC1tNAPs6AbsC8rqdUyvP3jccnU2LQtPqZFgPvthgv0su0PY2VLk+t74aGR5DLHOj+TxdgnZ8ACJrhIdvMGK5wwtUXA0iWzky2j7cLhs244yQaatbSxIqF91z/XP7XFEfjn2paY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH7PR04MB8684.namprd04.prod.outlook.com (2603:10b6:510:24f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Wed, 3 Apr 2024 11:48:27 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 11:48:27 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Avri Altman <Avri.Altman@wdc.com>, "James E . J . Bottomley"
	<jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
CC: "hch@infradead.org" <hch@infradead.org>, Bart Van Assche
	<bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/1] Remove support for legacy UFS
Thread-Topic: [PATCH v2 0/1] Remove support for legacy UFS
Thread-Index: AQHagBbTPGmMe7yWeEGGwUC6QErk2LFWeSaw
Date: Wed, 3 Apr 2024 11:48:26 +0000
Message-ID:
 <DM6PR04MB6575D506E6E426B8B57F3C2DFC3D2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240327071714.757-1-avri.altman@wdc.com>
In-Reply-To: <20240327071714.757-1-avri.altman@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH7PR04MB8684:EE_
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uPHIAVfEYAmJUTMKhNcTo5uJKAj04X8XosvyZYktZqMjbDJFK1BexieS4iCMcbgoLOzKu15V5Ioo1sqLVdxJ14cbCMb/hmbc+JpIiqHR2tqdVJxFyk+bjday0RJW7x/6Kt8skkPP4dXrZFXwwZVm8pki3HkYzxZ4UD2P7PhOg9PQBYtEfjSneHiUqEs1FB+O4xGtaPNVrlzi1JUBjJXYdufS+ANg183edxasSUk0f32Y9adAhz8TV+dq2Qx2Q8jQ4X/a3dB5BoDvVgpu0RsMRGHOZ+r3XMw2OO9uT0xh2Td3YR913tdXJH9rGFzZ/YPv2lfb7PDLbKTD49QhI9Id+BQKg9xTGwrkXv0RRtV1/Z3H4EY68Xmt/wxGsWlS7q0Wx/Zz5gJaRbj8+C3uY3tk6B2vV7YF1jac1pSK6BUh+tYOVuBhhW4Rg8avHR64pjQD7n8m3gYhxQEyXzZQvrN7s/z9iAcPMfJDs0aGk5QOeUAzEPdYibFuQ5E8vv7iKsG6Yx9SjqCw+ieOV2vf9Qr7h8TICIl9QUgcaP6NayaTgwkubBVqWHTiy1UnfcorH8W9fPZGPlvcsmriaHbL1sDClSdMWj/3OK/4+9SMqrbfB3FjuTDOIY0NFfmVE6DWhjItDxTnZZ7ZzguLj+amMzRcTkYMgiU54bDn6acVGHOen44=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?76p1QBlanRl+fDj8RV3a40Z0o3AXm70jG9d2+X/rjgPeRvDedky9UCPdV7HB?=
 =?us-ascii?Q?N3wM+6pS4ZlOJnWTbM6KDq/EMYP9/jTXJy5WH6ioW3z0PAQVM+VN0ZrALStg?=
 =?us-ascii?Q?z0ClR2LjAGP8kYx/gH1kWio1RMlysRRv9k6xFurWKlKUEm1ywUh/aUxa8GA+?=
 =?us-ascii?Q?5yyTwPsyA1Sn+7uf4KAnetAO5HZ25x1lrTPQ624nPvlQLoVPaHpjyCnjWKTS?=
 =?us-ascii?Q?sKQ1BeNJWg/3EQcxUqHBS+EqRUArECrIi4Lz8NL3kn4gYpIu7Aa2wGDAjamI?=
 =?us-ascii?Q?3hEik5B8YnTrsMATNtj4lO9ogB2pVA8dNyBg5x0F5KKlj9bWl5L+BGZ4LDgv?=
 =?us-ascii?Q?aAd65Dkt1Dry05oH432KwhyVfcn1nweM/91XDoSvtFa4djQZOf9J65SE2ND1?=
 =?us-ascii?Q?IlWJhjpAH/mhwZUA4JhHM3EZ0ZvRBWV9OCDXPVAQTsDlhRobmko7sRpYp07m?=
 =?us-ascii?Q?N51/h6/1LxheKeZvGlj2zitBGCFyzHlHcbNeZj6oyHykO/FcEi5GTIj2JlJa?=
 =?us-ascii?Q?xVDnI7Ix55SqOdBzSsia0woZRkwfbIFm46G87d/2K5x2wSP9EsDYEb3OjGFn?=
 =?us-ascii?Q?6A8bhyIYn44kPnObZwzxNPl5+FW1wxSMbm0fT0DAp7X0WLyPT8kOSf0qqEYJ?=
 =?us-ascii?Q?FuBP6crKsWkJ09hY5zKzv8/4ZMTHMhDupX1IJNSvHPPPHi6hDr3xHZBQ9QzS?=
 =?us-ascii?Q?CsvMNvxrZgvDwYbFP6/1vUE+jXNfsYVNhn26zN8ElOwH8+sgi7P4FBpZu0Kx?=
 =?us-ascii?Q?VOKZFktjK5ve1PzFCclxKthlfhI69GutdkR/c6ffAgnLD0XCZidabUm7J9bW?=
 =?us-ascii?Q?AfNf2dI18EyZCk78f4uAZMIm9lMC8/47pXOTdL3L05+1C7LMtRpcEOYjWeac?=
 =?us-ascii?Q?puK2IuZy8sFGeHgflosE0rrGB6Qc6cztUuhXJ7utjkI3L9dd1NG1TYhtmAt3?=
 =?us-ascii?Q?TcsH6e+89kbaiYLtFoMD3OstmmMu2QmCEFNi3/DFa0L+1AulLdVBs1Dru34Q?=
 =?us-ascii?Q?1hsUolLYwyQ0FmEtys3TMgDyS2B2awlsDeIWkI+/TD1s20NdWKRnVWxYEIY6?=
 =?us-ascii?Q?V7rajLibHeGH5lV+aTVLs435fI+5GUHoTpzmqeLFhq+iZ/3GCZ2l5N98t25Z?=
 =?us-ascii?Q?dOFiDQw9plFyjG8C/u3Bs//lgzyALB8o3rxLkbZXx7QaKX2JU7wEcF3G021F?=
 =?us-ascii?Q?LEl0KmQVk7vCLDy1QAchK+DnDhmtfljZz4ac3CW0Lg+y1bEfi9Zg3OejlEh8?=
 =?us-ascii?Q?RYcAkEjJUOoZoAG6qWH+8sf5h6vzwXOUjb/oKQTMtgCpKo8OZ9qe+qiujDCP?=
 =?us-ascii?Q?NbMSmZJUeXGBpaCKeThKg1Bejds1dEj7+bLJbOB42Nok7g9pn912+LeNhUsT?=
 =?us-ascii?Q?2HuR/DWnRfcFbggKFZiA4DdIUSihXRhLvOVOn3y1CFiyaHXKDlJ3mHYBh0+s?=
 =?us-ascii?Q?AzLdk1V25j0HMpuTE6WxgybDEfxmUo9zs8zw4MZt/exY62567QpSlStqHlRt?=
 =?us-ascii?Q?3RjRnkth1JLnq7xGq1/A4uKe11YoUIz4GQ9iSf77saNVQxQOp/euA08dpKjI?=
 =?us-ascii?Q?3w1xaxnQjmZf5NJ+lzxZ1Wt9ipAJZjyxA7Gcm+O2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hx3bQULEPSmotFPfY1vmvLiVeJCZvofgJeGVXU+hQ3z4yzkI2Oornh6MKG0BXgKzTADzCBVU/zEpTfcqtXYczSwgXZh57WZ7VQ14ABna51U4Ur0Gc2/TxReS9QAkAp7fTQkeGqJC8gI7Ip4xNMg1ywjn1eJlrkX6ngh3qGmqIH5ULGUs4jq7ccUsO4Kw+bxvuXGXVUUEUKk2500DBEkRZDV0sLgvfDG69kUv1aca83Calw1FvgOP6pwOSj87j8N+q3fsBWn3UGxS0IyJ4OVTdavTdMFtnKi1b/3AKdBBDoBfrW/4YEiwGvPl/fzcb62gC2KeCQGQ8c8J8sKbm02UG9a+3+zcMVar245bm5l4NfN/Z3K/wk6tSeRvFbCJdxt55u97AlPaufyAqa5xjyiAkWmJmN1tn4iB4/h3WPL9FnU1JNYxwlT+86zdfY2sEE0Lu7HuEIagr0vu7Zkv0D0+18Fg20ybKykF/zJhlM2/vqbklO/w96uucSJ/4gNQggyVlPhc9S+SGY3ODNQAnXZOQtGCvChc4Qa7XT/1X2oBTNDTUIAATBb26a2Al5VibKI6a+xvuWyZjNr7vyjqFQ+GXu+6kuLH6eX/7a8V4ABBT1IRGJZAh5f46QJlKENjM5b9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4867168-b922-4be1-033c-08dc53d3f990
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 11:48:26.9396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8EyioNHS5u6Qmb19/+6mpYMm6wXMcF1qcGZFWle2F6INgtUMB2IuiGIu/0taYqnYSX1WnCm7ocnfeYnHCXGIKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8684

Martin hi,
Could you please take a look at this?
I have another cleanup series pending.

Thanks,
Avri

> UFS1.0 and UFS1.1, published in the early 2010s, were more of a proof of
> concept rather than a mature functional spec. Toshiba was the only
> device manufacturer with the most accomplished phy team to come up with
> a small UFS1.0 device. Alas, there were no commercial platforms it can
> be paired with. Even UFS2.0 that was published in 2013, didn't really
> make it to the market: too moot to take effect. It's not until UFS2.1
> that was published in 2016, were a myriad of devices and platforms
> flooded the market. Designated to mobile devices, dictates a rapid short
> lives for those platforms. Hence, we can safely remove those pre-UFS2.1
> pieces of code.
>=20
> Changes from v1:
>  - remove ufshcd_get_local_unipro_ver which practically mean squashing
>    patch 1 & 2 into a single patch (Christoph)
>  - restore an if clause to avoid functional change in
>    ufshcd_compl_one_cqe (Bart)
>=20
>=20
> Avri Altman (1):
>   scsi: ufs: Remove support for old UFSHCI versions
>=20
>  drivers/ufs/core/ufshcd.c   | 174 +++---------------------------------
>  drivers/ufs/host/ufs-qcom.c |   3 +-
>  include/ufs/ufshcd.h        |   2 -
>  include/ufs/ufshci.h        |   7 --
>  4 files changed, 15 insertions(+), 171 deletions(-)
>=20
> --
> 2.42.0


