Return-Path: <linux-kernel+bounces-158013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71B78B1A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E381C2178A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B7C3B1A4;
	Thu, 25 Apr 2024 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="LUNk3Gh1"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DAC23CE;
	Thu, 25 Apr 2024 05:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714021757; cv=fail; b=ekh5CosxiSFVepyDmkMtRHMQcNYFNwRd30vpCNvb8BCifNMtw0V9bG8oRsv4fgeXDxdxuAcmnpDyz5thn9MkdTCfwVr5VNCRWxmQWaMlx+LJm3zvjH5dddgcc2RQ7285sxFx5EY8E2f3s88Pa6DF4Bm9a82/K0kIvUP2JIhwQIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714021757; c=relaxed/simple;
	bh=+VzGnFS0cAr2C607Da7BRDFiHkkiHl8VzLjFxeZid/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nrxz06uUoKhWx+p7nDQwmKhoo0mNY1xorfRcKGgLBznNpBU6+oTxW6ICWzuLw0JjJxVdtcpt9EQBn9XgavI2oYfKEDGLqxggUtLUabiPA8QeMPx288sOoYxjj3Y0bEV/ZaTo2iJNlxiTWx8ZdidXmnz7ikaej5KMa++XWSNmaRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=LUNk3Gh1; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P1VLhG032478;
	Wed, 24 Apr 2024 22:09:06 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xq284bafc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 22:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bV0cVWKIeQcL+JarCaC6uX291GzVTmo4tKayYTzciorsPRv0LnvxC5nXG1Vwbi9OzHiSWo5XiFMwgdIvcRwiowdyznjgWstN3zn1/FP/uKnXFi2VSQwTUH9VIMUtOCUQipVkpMun6IagpBqovznw3K+Jazh+Fr8rUU6L8hhIMfQRsBapWTDsk8LFwGxefPAxvYKRgvJ6W/3zN5dyxeop2jsslVlJvH1yoAeUNVdunAHzpMBM0+FxlhI4mVQUn8adb35bruxNw7kBpbxxWp5fZBsldpdMBgltXqztAt2s0qNpKgnx8+vr+2MUjlX4gVtC2NBIN7sl0LQ44py77uhUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEP/rmBx/G5fVpMv93L0CYiDW+bOptV3m5fpmYb5yDI=;
 b=ApeCojGbFLSSxALF8xcqTh9/ydJ00+FbLi1r2kGBmRN8iT9rIHDhtUc2U8TLAvsyTTAATipbRBnQqnw1Uu2+Bfkzz4vNecNpm3Z/xEYIwjW/zgWnYkI/AUeiZKtUZQWrEd41OS/2u62EG2igPQ2qcxUnOKgD91QdGVS6MHM+tPOFRqw2c6qdWuCCXwma8qF4DhRVLFxi3zvzs3CR1sb1Ivao06VfTooH1yNvJXz8wIO0it5LItj+cATXXEdcFwZC/QId6cWJ3bkuvSEeBFSuTB/jiKcy98oZ2C+Drsf/6tdZoWIAaTl+bxW+1yFUmNnuDu+6FzA0GjsUizXvCIIpEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEP/rmBx/G5fVpMv93L0CYiDW+bOptV3m5fpmYb5yDI=;
 b=LUNk3Gh1iVRWPKY+EF+25CrMeE0/W80nl2J+ibDlvLLjcKChc+5qSCgNwi9Pxa6vcQ0+2viMpL127FGU9h7RGo6tyuZWP8vRiKXl5f5TlgtiK4eAJmyBr3nEQztVVIULAv0Rn6ufkfBByYd1nD/mpkb30Z12W+hXHcFTt/h3+e8=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by PH7PR18MB5332.namprd18.prod.outlook.com (2603:10b6:510:24c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 05:09:02 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 05:09:02 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v2 0/9] Introduce RVU representors
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v2 0/9] Introduce RVU
 representors
Thread-Index: AQHalJsFkqfhspWruUiIYa8/IeAzYbF10/0AgAAqKiCAAYPOgIAA57JA
Date: Thu, 25 Apr 2024 05:09:01 +0000
Message-ID: 
 <CH0PR18MB4339CF300EB8D1C50EB60E78CD172@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240422095401.14245-1-gakula@marvell.com>
 <Ziexkkz8HCtIVRap@nanopsycho>
 <BL1PR18MB434216126F143177DE9A1D9ACD112@BL1PR18MB4342.namprd18.prod.outlook.com>
 <ZikaQQbAb2Manu72@nanopsycho>
In-Reply-To: <ZikaQQbAb2Manu72@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|PH7PR18MB5332:EE_
x-ms-office365-filtering-correlation-id: 3c6a6bbb-f426-4118-21aa-08dc64e5d265
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?CBdFluCIOUHY/Y6ypK7yWuyTDNDbbmc3DCifxqYw/+AaotXzBq/Wu1qMda9p?=
 =?us-ascii?Q?Vyt5Xd/wAldcijmROf0K3hFmYZz+MwEd3g5TH3s9m7H+tw8CPmCu764lIxFa?=
 =?us-ascii?Q?13SvY3qAmZ2yo7myfJzIZTAtizs+55tH8ZGM+1BGrGYOJhQwb/g/1eFnutqc?=
 =?us-ascii?Q?54GXM9Qg5Jc+2d/KteceNBQ3NYowM8n9XZEIocm64/hhbHlXRDxZoyRZp7Y4?=
 =?us-ascii?Q?2L2PiF3r5EaQu5z4xLUjMfkPwCxtGVTEdS7Z77ir/wYfsoLM6srkiKpEmzR/?=
 =?us-ascii?Q?xN0QtgIXOV9GE/79J05DaLIzeQO14f0ZT1Sjeit2YPMXmE0GY07a3+7Rvwh0?=
 =?us-ascii?Q?gb7WeMyeKtCw02/UHedHo9GoAt/HmWQ0hW9o2EjvajOptXlWaKTrYTP8YMsf?=
 =?us-ascii?Q?fwjl441gWZd5EmzUJLut3wwDnjsEBUzIoDtX30xhsMeXx5soIsAwUacdkJsO?=
 =?us-ascii?Q?zeuXN+rA0el6Y230/mVsqk4v2VVOxSfJWvjUG8GEDtKSmFf0Ff1DhD4/podO?=
 =?us-ascii?Q?7BbVUJASxTztRwI4Bf6HfyTLm4hKdDrIna5DUDPmVOwtPbpwTk6ZRG2UyZ6Y?=
 =?us-ascii?Q?JUg8uZ/qIJzCI5yxqAyQnpLoRcRya81my+OlhpMaBEhSSV6aPBfR83X8ywQI?=
 =?us-ascii?Q?WBPKpjcO1NJn+lA4+YH0kX3NFfU7v6WkGZxUHEVOsAbevZxvAgLhgfNNQEAG?=
 =?us-ascii?Q?89Qc7iRJG5c+QW3L4thBwMUGY9eP7sjZwrkslry12fbYJUNxjiwdC3ZpRJ4z?=
 =?us-ascii?Q?5CFqgrnMO6qoN3Bd/wMkmBf9izFrU7xrTQKh6PEObZtK0Az4fpJEWQhOiRjs?=
 =?us-ascii?Q?bMrH0x9x6ZqSKfcK4atfaWCD4cbWONQ9YX9oSEtIMrNUnEHn5TxieW1sc4xg?=
 =?us-ascii?Q?9xR4ABkZB3QlCmuVeR/dnQ16PnT70t86d0MaMOoNLHjJm1OvSo/ZscKy7PNB?=
 =?us-ascii?Q?sytW6rsYKa2cu00t+au023MCaLwv3R9b/33p6p19PCnaWKHb5ksgIjzuHg4I?=
 =?us-ascii?Q?IkBur8rFqT9W9lhA1A8GlG8uNJPBYO9iee3pne12HkCPJKXXxjMQoOH5WTo6?=
 =?us-ascii?Q?29L21NqQevQqE2AXZF/NJSPT1q60w9zZVBUs/ABlarNiCGgj/7DjQWXFnGtK?=
 =?us-ascii?Q?2u7Rnyilg5hMcnei5uuxI5HaOrer2fXw19PrWEJ0DhHVDkb1h9AEZau+15ye?=
 =?us-ascii?Q?ay6rlfc53frHEnu3CW9YlUSUwIiqX3sYnf8EyjLjr8aFS9fEwzQ3zelSgm7z?=
 =?us-ascii?Q?tviIlPgaJQZxFCw4DSVHfI/0ntgWRX9kGdmZ7bj5nohmXuGXn02bQbqhVCz4?=
 =?us-ascii?Q?O0LytTp7sW7OHqdMNdzuUnMz?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?djVzucfk9mo2RbIuVsqQ1e9EYVXnnSPp6kaUx4+8mFBzdr8llRAwgDRLwEPL?=
 =?us-ascii?Q?hwRW9NGmUh+fjj00SzA6hqMfSlO4JbpGvz6IPTPjF08E5mIPSrucHIIGXYFg?=
 =?us-ascii?Q?5ZuW6qS4MAavUaTZGBBkk2P1LHvOlGewpef4T794/53/bG9TheaedAV/gAtb?=
 =?us-ascii?Q?pJ3NEtkjDg5v2nNxZ1Dk2pYl5vtIxjmlC8EOT1XLDtukR8JXIa9vxYZpGkjE?=
 =?us-ascii?Q?bvxgcFDs2ltF9IDSsNqxh0M+2vEZQifhDPnZKIcZASdQJlSM4zo/imiuJRNk?=
 =?us-ascii?Q?F7cURx/pmEZ5CdDSRNrEGCJhdgE/BhlI/Q7Ay548zX54jS3tyK/DAQQwT2oo?=
 =?us-ascii?Q?8CpjfPDc45OXDfwcuvnWlIO1zNQI7nf0LpGcV3qvgjOuHMqg5SQtNysENnMo?=
 =?us-ascii?Q?/3f5rb0j1ifMlABGlXhCWfqXpRJFs5My4wHKxPyzoHamvxBgfZdBxEK8t4cp?=
 =?us-ascii?Q?WBZFvUjJIkCuGJHalC1IN3BwAUglMOqMTHEpYrw2lc4VJSc339cyy9LdkXLx?=
 =?us-ascii?Q?EKyLn6bSC3CiwNQAsHldLVYmxdlXZg8HeO0miuXdazmvKGxpCDncpq0887ba?=
 =?us-ascii?Q?OmkTf0qgNJRxvWH4bJS6ewn90f/uDrMRYT7GPAkbFdHqKewzd7r0xHlCdgeL?=
 =?us-ascii?Q?vUk4AChUEjAEbgIxVGkSFtHjcY87Sj1fKvH9LWIDuH2Mu6fHbdE7h2o6pfdj?=
 =?us-ascii?Q?io+O8Cn9ifnYF+kWl+b64k0zCfNQyFCVHBvKhkA+JxEf7GtpryDfqyZWohD+?=
 =?us-ascii?Q?OapxRmPFPZcEEp0nchTuawReYbBCMzRvgqpCbbzU82b3wHflMuXWmTWFASXf?=
 =?us-ascii?Q?4opnoEaIOmC76oV1N2FETIIugtsUjij1pevgrRO8FeryyoOqmccqrcq5OFco?=
 =?us-ascii?Q?CAvexqhKVkP3Lw976YdocGIg0kjQE6lmadglrWBBNgkBmVUSwL3Nertalyry?=
 =?us-ascii?Q?A37+zyLXJoAB29gfenX7wyCnKTnmx/pD8/XU4f8X8XH8m4FmzhGK98UqNnie?=
 =?us-ascii?Q?pCZoM+4HF/srFdVXwvDw/dAcEzA6mnYK3L2cv6gldGVJsfl9zbCSX2J90rgL?=
 =?us-ascii?Q?7WlH4mekfCui3uCYyPpqmplNhYCo5uk+WzWYaZRPfmOwjokQMLmoUjP8SJUS?=
 =?us-ascii?Q?urIwx7yaPpjsySV68J1rW3lgyOOD5GU3cmDVE0xYenoxnlNcxb900BuE95wn?=
 =?us-ascii?Q?F0fhCEKBZCSfX2K6cLvW9choEBj/hAmYpCYkUdaxeKCKoZgClseag/21hYir?=
 =?us-ascii?Q?c9+R/LYh0XxmabWSXOaOIHbnabAsy4k5VfE4p45eSCMeHcsxSRO8k0MvyzA3?=
 =?us-ascii?Q?vJh9qSI9+jH5HvivrQZkdpZKlqglRG+JH7FO5+gyqio9I7tZWhzLRAPRDz4L?=
 =?us-ascii?Q?hXpDK++vSvmFS3lhVNplqgka/4Rh9XNtidxa2U65vL0wu411TfwF0nhlPN9P?=
 =?us-ascii?Q?WsXg3Cr8bXXZjibZzZcpnOaJ65OHBApGCBlLo6o5L6EYTuDvYace7+5/j8BZ?=
 =?us-ascii?Q?t4oUfJdF5K2IPVbYiAhLBPSTF24EbjGbp99dS1rAcr/lGEhTdX4WVc9ekdwo?=
 =?us-ascii?Q?bw0HktU6VEKEELBi8RU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6a6bbb-f426-4118-21aa-08dc64e5d265
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 05:09:01.9271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJEj9Jdw7MA6g9aD+kkaBIREM5AxRKyzO88ObntQH2++MwF+lYLbwKRgIDMkru32tEd6LZze76lZEMbWAdgtTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5332
X-Proofpoint-GUID: nyhzBqvq_bzBQUwa5ZwY8HTcg4sEBMTC
X-Proofpoint-ORIG-GUID: nyhzBqvq_bzBQUwa5ZwY8HTcg4sEBMTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_04,2024-04-24_01,2023-05-22_02



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Wednesday, April 24, 2024 8:12 PM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org=
;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: Re: [EXTERNAL] Re: [net-next PATCH v2 0/9] Introduce RVU
> representors
>=20
> Tue, Apr 23, 2024 at 05:39:15PM CEST, gakula@marvell.com wrote:
> >
> >
> >> -----Original Message-----
> >> From: Jiri Pirko <jiri@resnulli.us>
> >> Sent: Tuesday, April 23, 2024 6:33 PM
> >> To: Geethasowjanya Akula <gakula@marvell.com>
> >> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> kuba@kernel.org; davem@davemloft.net; pabeni@redhat.com;
> >> edumazet@google.com; Sunil Kovvuri Goutham
> <sgoutham@marvell.com>;
> >> Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasad Kelam
> >> <hkelam@marvell.com>
> >> Subject: [EXTERNAL] Re: [net-next PATCH v2 0/9] Introduce RVU
> >> representors
> >> ---------------------------------------------------------------------
> >> - Mon, Apr 22, 2024 at 11:53:52AM CEST, gakula@marvell.com wrote:
> >> >This series adds representor support for each rvu devices.
> >> >When switchdev mode is enabled, representor netdev is registered for
> >> >each rvu device. In implementation of representor model, one NIX HW
> >> >LF with multiple SQ and RQ is reserved, where each RQ and SQ of the
> >> >LF are mapped to a representor. A loopback channel is reserved to
> >> >support packet path between representors and VFs.
> >> >CN10K silicon supports 2 types of MACs, RPM and SDP. This patch set
> >> >adds representor support for both RPM and SDP MAC interfaces.
> >> >
> >> >- Patch 1: Refactors and exports the shared service functions.
> >> >- Patch 2: Implements basic representor driver.
> >> >- Patch 3: Add devlink support to create representor netdevs that
> >> >  can be used to manage VFs.
> >> >- Patch 4: Implements basec netdev_ndo_ops.
> >> >- Patch 5: Installs tcam rules to route packets between representor a=
nd
> >> >	   VFs.
> >> >- Patch 6: Enables fetching VF stats via representor interface.
> >> >- Patch 7: Adds support to sync link state between representors and V=
Fs.
> >> >- Patch 8: Enables configuring VF MTU via representor netdevs.
> >> >- Patch 9: Add representors for sdp MAC.
> >>
> >>
> >> Could you please add some command outputs to the cover letter? Like $
> >> devlink dev $ devlink port
> >>
> >#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
VF representors are created for each VF when switch mode is set switchdev o=
n representor PCI device
# devlink dev eswitch set pci/0002:1c:00.0  mode switchdev=20
# ip link show
25: r0p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT=
 group default qlen 1000
    link/ether 32:0f:0f:f0:60:f1 brd ff:ff:ff:ff:ff:ff
26: r1p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT=
 group default qlen 1000
    link/ether 3e:5d:9a:4d:e7:7b brd ff:ff:ff:ff:ff:ff

Sorry if I was not clear before. Hope these answers you question.

>=20
> ?
>=20
> >> outputs at least.
> >>
> >>
> >> >
> >> >-----------
> >> >v1-v2:
> >> > -Fixed build warnings.
> >> > -Address review comments provided by "Kalesh Anakkur Purayil".
> >> >
> >> >Geetha sowjanya (9):
> >> >  octeontx2-pf: Refactoring RVU driver
> >> >  octeontx2-pf: RVU representor driver
> >> >  octeontx2-pf: Create representor netdev
> >> >  octeontx2-pf: Add basic net_device_ops
> >> >  octeontx2-af: Add packet path between representor and VF
> >> >  octeontx2-pf: Get VF stats via representor
> >> >  octeontx2-pf: Add support to sync link state between representor an=
d
> >> >    VFs
> >> >  octeontx2-pf: Configure VF mtu via representor
> >> >  octeontx2-pf: Add representors for sdp MAC
> >> >
> >> > .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
> >> > .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
> >> > .../ethernet/marvell/octeontx2/af/common.h    |   2 +
> >> > .../net/ethernet/marvell/octeontx2/af/mbox.h  |  73 +++
> >> > .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
> >> > .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
> >> > .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
> >> > .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
> >> > .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  75 ++-
> >> > .../marvell/octeontx2/af/rvu_npc_fs.c         |   4 +
> >> > .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 457 ++++++++++++++
> >> > .../marvell/octeontx2/af/rvu_struct.h         |  26 +
> >> > .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
> >> > .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
> >> > .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
> >> > .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
> >> > .../marvell/octeontx2/nic/otx2_common.c       |  53 +-
> >> > .../marvell/octeontx2/nic/otx2_common.h       |  83 ++-
> >> > .../marvell/octeontx2/nic/otx2_devlink.c      |  47 ++
> >> > .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 ++++++---
> >> > .../ethernet/marvell/octeontx2/nic/otx2_reg.h |   1 +
> >> > .../marvell/octeontx2/nic/otx2_txrx.c         |  35 +-
> >> > .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
> >> > .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  18 +-
> >> > .../net/ethernet/marvell/octeontx2/nic/rep.c  | 596
> >> > ++++++++++++++++++ .../net/ethernet/marvell/octeontx2/nic/rep.h  |
> >> > 51 ++
> >> > 26 files changed, 1707 insertions(+), 225 deletions(-) create mode
> >> > 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> >> > create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> >> > create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> >> >
> >> >--
> >> >2.25.1
> >> >
> >> >

