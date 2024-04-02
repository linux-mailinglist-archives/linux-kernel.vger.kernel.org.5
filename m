Return-Path: <linux-kernel+bounces-128843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC85896068
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA808282868
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90421127B73;
	Tue,  2 Apr 2024 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FqoEGl9F";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bwmTGMud"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431FD58AAC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712101837; cv=fail; b=cci8MQCqowuAAnGSLv4cMVkOCHLhY12ABU5tbJ39JYfevQjezxiPBrbNt2JPTnC/vFkNvuPwiYSyQIJEhQkNgbc/pJXYsZ13z9wUiCgfWyDwFBR3yC96WcjKdlzWdg3GQnlpCuzZdNEfETJ8DzblOUMwKUomgn9z/r5eEwB9s3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712101837; c=relaxed/simple;
	bh=v/UOZ8BspzHHp8PLaK9240Jj360ViKW8sy+phA7ak+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AFTZu0Mw8QzwUh2iB0hPTYJAgzgEwZocU7WqCXGxyj44gPoobk1n3DES05h6O4XxF0qCX5h9/5iF0qCjaHmS2h/IdgxGfkjk7FYdGTwMAHykn2NhTBOHwZ1WWfcsiLr8qxO89m5Jg/lyh20eEKqJObEP0UQiN/66BVcGIl+P+5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FqoEGl9F; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bwmTGMud; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712101835; x=1743637835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v/UOZ8BspzHHp8PLaK9240Jj360ViKW8sy+phA7ak+8=;
  b=FqoEGl9FR4qcMvxsbrXWeCPqJGJXxwNk0VJz2gCvMVgDVy5BJXjdo0fl
   BJ4JBIEyUPLz8zlu3lij+BSxALAKpZ8T9jJxIhU0eArEld0QBZHTkTtBy
   3Mu5Az8+Ffc8+DnZt/vPpGRNlxY/bPjMon6km+eW+17l+XXeEYk0bN/Nb
   1klBt6tpclhe7vrfzgs+mfqHnoJd34qdvxsILk9+JZ3NSAG9THGLOh4U/
   okTxWKmCzI35Wxs8ocQBHKkjX5yDTyddrAq6bA7+Ti9BCHt+d8geQcb2l
   sExMD9kJSrLqBFRs/LLpOgGXqVUiDF4xDXMEP7CH3zUARAwURvRaafS99
   g==;
X-CSE-ConnectionGUID: wi8SV49ESxGSr4B2jIJZYw==
X-CSE-MsgGUID: pU5xM6khRmWUHqfmo62z1A==
X-IronPort-AV: E=Sophos;i="6.07,176,1708358400"; 
   d="scan'208";a="13087077"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2024 07:50:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUs433/Fv4Ce3eDzwj2u7M5I5WLPuP47p+ipWuMXgpFuHtvWX58OeKAI6e/5Z+OSWDNfeshka5fkzQ19M8bCrk6KlFggBjNeBH81A0EPuxe6SJBfhFbignZwWs+pJvsesCIjAnl6SZ1cYo2CcGLppAMG7sfePbUPgr6ti/XvQUp/giIOkXvxp/lN0dYXSFV9246RvrGXCdSE3hC/HL3A2oMff0cGxRe9mpAkQyfdGJlnnqVcZG/MCsirdpLTGYBn0ihX8p/vwVv66PmkZqBFLlnRGp4pjv71/zLRmpkXam3nyeFIHz1/+fLuGPZ2b7MpRi8q+5WoUJiyXMmYOOY9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/UOZ8BspzHHp8PLaK9240Jj360ViKW8sy+phA7ak+8=;
 b=NebqiN+2eUK+gr10gLUlHnrCuba/zcfkkR5E9l5eId3VI4YIC9mun+6ACDIb4bNUN+eZvKQ8jdzv6fdBFxC+EhaLMN+pfbJ6Aqiuu5mJPDyPaJOBwJA2NTTYUdhPV3tlkjiwB8YXdOaF8l+1x+75bD4vYUMaMt3n0FUipfU8iJeIPwP+AdS/ep3wVIEj6lkOieK1gyNcMUjKPpdg1GuwBkDUrVUVdVOAJSz/9rTNphC7CuXBTxU8InLsZgJ7KhbyA4Fm+PqMuuET/goz8B2qyc0N/Sqe0brgO/k7cFdp1oMS/5Hirqy2ibZHwk/TMxhoxLVDJLZgqXEHH30+y1KyUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/UOZ8BspzHHp8PLaK9240Jj360ViKW8sy+phA7ak+8=;
 b=bwmTGMudhPscpn+hCGYvrEQGfLz1ydVjaKrfOln7ciNhDPJXDNBF1KQYMJ+hDIpNYVZ+UW55/gGifOoi4lmSkaxLU47CMBCgoA/7jLnLaBmX91wPvtye9PE52d/cJBOs40jHF3ekmfCuYYGRj0h4ysatM9GgW4WP3SKFd4QSH1o=
Received: from BYAPR04MB4151.namprd04.prod.outlook.com (2603:10b6:a02:ef::28)
 by PH0PR04MB8475.namprd04.prod.outlook.com (2603:10b6:510:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 23:50:29 +0000
Received: from BYAPR04MB4151.namprd04.prod.outlook.com
 ([fe80::3fff:8c2f:81ff:c80]) by BYAPR04MB4151.namprd04.prod.outlook.com
 ([fe80::3fff:8c2f:81ff:c80%4]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 23:50:28 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Sagi Grimberg
	<sagi@grimberg.me>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: WQ_UNBOUND workqueue warnings from multiple drivers
Thread-Topic: WQ_UNBOUND workqueue warnings from multiple drivers
Thread-Index: AQHaeXhd/UIUk2VZGEG0Qh+3CF4eQLFAWi8AgAIfawCAEyxD9w==
Date: Tue, 2 Apr 2024 23:50:28 +0000
Message-ID:
 <BYAPR04MB415196EC84756BA1876463DABC3E2@BYAPR04MB4151.namprd04.prod.outlook.com>
References:
 <BYAPR04MB41513F04DB2ECDC3601CC36ABC2D2@BYAPR04MB4151.namprd04.prod.outlook.com>
 <c4057654-97bd-4721-9bed-9dd5ef8b3f8d@grimberg.me>
 <6d3af8dd-30c3-48d4-9083-7f00ea21ff8c@nvidia.com>
In-Reply-To: <6d3af8dd-30c3-48d4-9083-7f00ea21ff8c@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB4151:EE_|PH0PR04MB8475:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dLC6zcrrknFRql0t1bbUUvBVl2Uk64ehon6eEFbuOXrLbknjgR/DGCPBEdk6IN5VDxj0WxqOqzRhhdENh4SjQZDawpHj8ISzkuGizZE4o1G66ESImv4y3WCn4G3dq/9LNGdNnDh8VDNQcFK+0VIohaT6KqZR52vEvhYgAf4BHfwz0P6SNHXik5f7/kKKsTdOI7vMGdD/JHDR4nfBoaoG/4pCGvYXcRHTy/niqR+uPQ7Tvo0FkUnuYeoTFWopqXbJtnNEv2+tJNC5FPnnyaAYt5noG2W4QSgGwI2kFoFAlvweL2Te4kS+APA81QgWcUazUe5FiagzkClH/K7+vwroLfm7j3VOxKuH/sPYnH5YiR0WXHHuV47mf1G2OX3uW5msfiZQvWw3NIxHHrZgpKnMdcr9bv3l5/EwKhb0VpLu4Qfg9fI6WgjkQc5E9evAX3QAlhtObHj/XKzmxTnnbM/mO3O1v0QCz9X00OKHcoRH+qiepokLUs9B1SkvQ9+2ziCws8EM7k+X5Ho+k6Mk2HsObUaaudwdhqTF0kam3MmmkvqcoJH5Krw5VsblGu9ZW2N4Swjpt4bwCp108pKZLveDRXMJwyr6qGPCzXqHTWI1GjQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ABVjOs2jIEvDvTxwaYraGlV8d1GeUZbuV7+E3CMdQvXoCLZSyzhfD42GJI?=
 =?iso-8859-1?Q?vH4VfznBqW9MV/I75/ciT+Wts+OB1FvgThM3eD8eUozALgsd2PhPVTxxEP?=
 =?iso-8859-1?Q?mjZMJOINwqOjIkznacLJ5PcRvG3EfqpepUFiEDw4qgr/CmFlu5DD6igfzY?=
 =?iso-8859-1?Q?A40SLgRb4Gg3gxrwVSeTK2Y0oJPQfovv9azPES1W49e8VORCUyQfK9FGbh?=
 =?iso-8859-1?Q?slJCL54PIHkmZNy3nMwF32rU/IPbPhgrKEi/IVnWE3dI4rZaHTEaua5UT+?=
 =?iso-8859-1?Q?/2R2g6frm9vbbqEKHAYgiffDztmhRnrtxRJkVQuZSSPdRcPsTjBCIDSYg2?=
 =?iso-8859-1?Q?YnNEU5tU4y1YaoBPBk87/Q66bl7MPPXcIbhqGyd5bgAGhYhs7QncAV5Svm?=
 =?iso-8859-1?Q?W39ZMUXwhvTvnwgSAYzSK/0OB5JP7nZuUeirQjMhgJPHXjheNTWfnpcPr7?=
 =?iso-8859-1?Q?QyGVpJ7gm8B0zOo+vTcLaokknJrRUgiWnGPwJQddesBlhGlHW+zCR9qP/z?=
 =?iso-8859-1?Q?lkUrxTb2u9xjvfylkoLeGabXVeNOpdi5RiPbNBEnUWKLqx+CxiBVrXGvnE?=
 =?iso-8859-1?Q?lbBskoCzIWz2mPRUnLnqO+icg9QEQ3DB+UYq3Z+x0VGsbDg8tAg53uetYh?=
 =?iso-8859-1?Q?GLraYUdUgydxcPIgb2YoNLAwAabg+z2f7pX3vPoE0weC1APRYqIUu00nXB?=
 =?iso-8859-1?Q?IlPuSaBxYGZv1tsXYMj1dfpD/UH+fyPUyWSwUm+pscgLM9E9ODhdlLe9e+?=
 =?iso-8859-1?Q?0BbAxUaDKlhHy/viBt5hi6vvk6lr6ZTP/TI+koJiqYM3dcdVVLyAC6tNis?=
 =?iso-8859-1?Q?hFkd8tSS16MSoalRcmF2zKgvKA3wyAXByy+DPog82Vpc/inZ6G/QgyhnsS?=
 =?iso-8859-1?Q?RU8GjrqMtWVuhpMQucgK39hCZn1UF8E9r6h8V5K5TSncL+NhUVBd9PGcYE?=
 =?iso-8859-1?Q?3dNix+XHbmRnX9SemUAD93fLIAHhApe1ZPAj4a7+HamFMVZ2HqHBAFrxWX?=
 =?iso-8859-1?Q?hxaJED8gBCyDOahohf2bWUtGPXbvUHMip/lXz6G/wptcq9evmyIoBeoqYJ?=
 =?iso-8859-1?Q?XTInxKATH31humn/D5FymNHDfCzRHxXhBVNPQbG4uONhAyGHg3x3TLHzUZ?=
 =?iso-8859-1?Q?BX31NIZBhlyHA4TJbokdtrspdMvdq9dToD76SYhhIZBmJ+y7C0ZVFbrGU/?=
 =?iso-8859-1?Q?1ax3uzb0L7OeGX9/5u9or/PhQwxhDfHDwxOxzLuIHRkqHclkOxdazMqobo?=
 =?iso-8859-1?Q?d5/lhlIeuajdmp+7iSWHhOvxTuQsm6uoc5qTHtc3u8tbAAREBl8Zz8QhRf?=
 =?iso-8859-1?Q?IFaefQKNxk/nNy3daEsWBRTixz6kIT/ZJpL6+eOiEkg7rqPo2f3u+2dtRC?=
 =?iso-8859-1?Q?K95gUtV0v9HhVCyG2QFrdpodUZdb2qcuOFCmTo0HidPKuFv0KNLLanF0+H?=
 =?iso-8859-1?Q?rS+mXK+5VVJ3kgPgkk5OAK0JowLtdg2wLan5OJf78cidkC84WLBSYRXRnP?=
 =?iso-8859-1?Q?+eKqMaGpNnQRQtyO4RAHrPHU8E6jRoGkM+68juBw9mAI9T13Z7DNpWrR6K?=
 =?iso-8859-1?Q?XSCYiWeze9GcXFqGsqpikdm9xyUq0wSB813YA3pr1PGMSqQ24nQKWmacIg?=
 =?iso-8859-1?Q?nKam0cth+p4uORSMXlljZzlfrOsAhbFdim?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IyEscXllXCsNJ5AZNsUtC4euFADutUZcqWEB0boc2dOJhnydc47amcbIx8ox2Y1jlPEaRmdGOLpMpglY1CdASDTYx3AiOsxfGXBsVPHrLG7frzToGzvUPcIeCwUXlzBAHcSpTBg7VDGp4mUndhYvwypd2R7hPU5WPssnq8bxJHOtjVcNO8Alk2B1ullscp2QDTZytNpTF7drZ/PEHWZwBPySEkm7e/+jEM2/AnZTXzRGzr5p8cxGKvp9PdbeeCq6elcm27D1PjJasPZOk3eKVcthrykmozvjyPr95oo7oipWbfuburCXoUKrz7BbjhSeJ1cwrR7AVjttOffwbu2ZEM+jF2aU4WGag9jvCdqsrcbAiqLqFa8uR+os1fupXTdz+44UBh06x2BYMIbUKI8wyCQP3mXyYp8sJ6wtUMe05aXmD4+4qMIGfORtNYWNpuIS/O5rvqhcQRxFsFmPc1u+Sdpboflx0zZc4SX2gL4Q734UtwuX6bJtDjIu5w/8jtwje4muC4qUOS5QDHFxzYeRtJfz9a27G0ppTgfyQqvGXQYjze1tagHTYrOPs435YfFXjex1PFLCQCpV/HOS2xq9oPZu4ZHppZCHW9OkV2gdOBucV5WdG7rHfBhbh62j1fxo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeba80fe-6b85-4889-3e65-08dc536face7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 23:50:28.6608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tHOjqFZyMpb6g0nVKqjunp4bO6wL4Z8BozbG8CEu3ZLMCQhAHEYYuy7r2g3QfbnbKBxzh2a9wvojgRWqDF88NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8475

Sagi, Chaitanya,=0A=
=A0=0A=
Sorry for the delay, found your replies in the junk folder :(=0A=
=A0=0A=
>=A0Was the test you were running read-heavy?=0A=
No, most of the failing fio=A0tests were doing heavy writes. All were with =
8 Controllers and 32 NS each. io-specs are below.=0A=
=0A=
[1] bs=3D16k, iodepth=3D16, rwmixread=3D0, numjobs=3D16=0A=
Failed in ~1 min=0A=
=0A=
Some others were:=0A=
[2] bs=3D8k, iodepth=3D16, rwmixread=3D5, numjobs=3D16 =0A=
[3] bs=3D8k, iodepth=3D16, rwmixread=3D50, numjobs=3D16 =0A=
=A0=0A=
Thanks,=0A=
Kamaljit=0A=
=A0=0A=
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>=0A=
Date: Thursday, March 21, 2024 at 10:36=0A=
To: Sagi Grimberg <sagi@grimberg.me>, Kamaljit Singh <Kamaljit.Singh1@wdc.c=
om>=0A=
Cc: kbusch@kernel.org <kbusch@kernel.org>, linux-kernel@vger.kernel.org <li=
nux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org <linux-nvme@lis=
ts.infradead.org>=0A=
Subject: Re: WQ_UNBOUND workqueue warnings from multiple drivers=0A=
CAUTION: This email originated from outside of Western Digital. Do not clic=
k on links or open attachments unless you recognize the sender and know tha=
t the content is safe.=0A=
=0A=
=0A=
On 3/20/24 02:11, Sagi Grimberg wrote:=0A=
>=0A=
>=0A=
> On 19/03/2024 0:33, Kamaljit Singh wrote:=0A=
>> Hello,=0A=
>>=0A=
>> After switching from Kernel v6.6.2 to v6.6.21 we're now seeing these=0A=
>> workqueue=0A=
>> warnings. I found a discussion thread about the the Intel drm driver=0A=
>> here=0A=
>> https://lore.kernel.org/lkml/ZO-BkaGuVCgdr3wc@slm.duckdns.org/T/=0A=
>>=0A=
>> and this related bug report=0A=
>> https://gitlab.freedesktop.org/drm/intel/-/issues/9245=0A=
>> but that that drm fix isn't merged into v6.6.21. It appears that we=0A=
>> may need the same=0A=
>> WQ_UNBOUND change to the nvme host tcp driver among others.=0A=
>>=A0=A0 [Fri Mar 15 22:30:06 2024] workqueue: nvme_tcp_io_work [nvme_tcp]=
=0A=
>> hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND=0A=
>> [Fri Mar 15 23:44:58 2024] workqueue: drain_vmap_area_work hogged CPU=0A=
>> for >10000us 4 times, consider switching to WQ_UNBOUND=0A=
>> [Sat Mar 16 09:55:27 2024] workqueue: drain_vmap_area_work hogged CPU=0A=
>> for >10000us 8 times, consider switching to WQ_UNBOUND=0A=
>> [Sat Mar 16 17:51:18 2024] workqueue: nvme_tcp_io_work [nvme_tcp]=0A=
>> hogged CPU for >10000us 8 times, consider switching to WQ_UNBOUND=0A=
>> [Sat Mar 16 23:04:14 2024] workqueue: nvme_tcp_io_work [nvme_tcp]=0A=
>> hogged CPU for >10000us 16 times, consider switching to WQ_UNBOUND=0A=
>> [Sun Mar 17 21:35:46 2024] perf: interrupt took too long (2707 >=0A=
>> 2500), lowering kernel.perf_event_max_sample_rate to 73750=0A=
>> [Sun Mar 17 21:49:34 2024] workqueue: drain_vmap_area_work hogged CPU=0A=
>> for >10000us 16 times, consider switching to WQ_UNBOUND=0A=
>> ...=0A=
>> workqueue: drm_fb_helper_damage_work [drm_kms_helper] hogged CPU for=0A=
>> >10000us 32 times, consider switching to WQ_UNBOUND=0A=
>=0A=
> Hey Kamaljit,=0A=
>=0A=
> Its interesting that this happens because nvme_tcp_io_work is bound to=0A=
> 1 jiffie.=0A=
> Although in theory we do not stop receiving from a socket once we=0A=
> started, so=0A=
> I guess this can happen in some extreme cases. Was the test you were=0A=
> running=0A=
> read-heavy?=0A=
>=0A=
> I was thinking that we may want to optionally move the recv path to=0A=
> softirq instead to=0A=
> get some latency improvements, although I don't know if that would=0A=
> improve the situation=0A=
> if we end up spending a lot of time in soft-irq...=0A=
>=0A=
>>=A0=A0=A0=A0 Thanks,=0A=
>> Kamaljit Singh=0A=
>=0A=
>=0A=
=0A=
we need a regular test for this in blktests as it doesn't look like we=0A=
caught this in=0A=
regular testing ...=0A=
=0A=
Kamaljit, can you please provide details of the tests you are running so=0A=
we can=0A=
reproduce ?=0A=
=0A=
-ck=0A=
=0A=

