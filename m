Return-Path: <linux-kernel+bounces-84843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E646886AC55
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98381284BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC28212CD89;
	Wed, 28 Feb 2024 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="W9G5CEGF"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF5512BF3D;
	Wed, 28 Feb 2024 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709117120; cv=fail; b=j86dXjevXbOogvRqMscwtTf5gO+noMPuF2ZbAK19Ax7/wqkucBN+rwETkJ/td4dqEW3jdTWvAjjOoYCZRdtdfVDrqtZaWu70+614XJV82hRqnjiq/UAy1McSRjkq23mhZ1g062pqDV5DRW+dUXgKfAfE6bBmj4s1ps46GEJRJjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709117120; c=relaxed/simple;
	bh=EnGAmgBVXEzUq9UBzjm9aeYgJzEg2lJXntXnXdlXJEI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=smRXcbdzOLLFRbysVQzxt32bVnf/2H6rl4pKazd5cEb+dpijfncv7gXExejxhyhDSchUhwYX5kF0en9lqBQgQmqYb7p5UWtq3qygjXIRCeXdP/EfGsIzhJpg098tcxRyTiowiYENFYcW/cWMNjYruxS2oqXxWqiheCLck7tZadE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=W9G5CEGF; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S13QD0005646;
	Wed, 28 Feb 2024 02:45:06 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3whjm6bq57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 02:45:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVPH7DZLIqYy/PfMJLEVRNZEd+yruh2ukvNaHoSmuCh60DMP2es/g+6VQvZpvNq0xo8ugdplHJZKx5kcxDNbRqtQ4Z8EHdwHd7ssxUSmSvrwNjPwuZAQgjJo5bJqc9LedqyT6Uvgv5BASl6njD77RNKVeoIShoTFCznVxcaCufuVEivMjpAOTjdmHnjT8axAeQ/RXKFTl10FWV5LdvBcEV4uheaoXFozaN/6DoTNXwwS2uBlzNz2LtFPoLdWEK1dpSUjwanQXVYVolyPN4KBGCewcxqKRXxkfNeaI09QNfNZyQTqSl+2DrqAstiwwYS15xmOQ+dk/obDNs9BcvuDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuQmCTCL7btCEKANFbaoLPvcIKkqQ2Ou4Mp8/FKNgRw=;
 b=SckJBotUwGQJdFQR4dAZ6XYIk/c/UK8qlUVh9e0pq+9y/WA1jcXChHlx0IUi8HKXNgBHgF1ED9YJ0NaZ5OCL0fv4UmUbpBwj+fS4jibRD+aDUlNJI5TAhj6SSd3I/qnHfqNBlz7JJS8XXjRa7gmkKRRkexAm+xnigWIlmq7YrbMBPmn57l0EIlh7Nytwxuts2ERkG6ZRuM2os0dNUt/4/5dKb3YGviYmkvxeKY8YEdQ7lr6xripXZaFujJhwLTHXZQnONzbZ77B6Cv8EDqaTySeVYT1O2jgPUtkC2dOfD1ZhQUpIkILHILZEY1eYPWVxg8PHoAqzZl3PoVedbLeYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuQmCTCL7btCEKANFbaoLPvcIKkqQ2Ou4Mp8/FKNgRw=;
 b=W9G5CEGFTK8Q5Xx8EvVC19GVZv4p5hIQGugzwqfcEbOMYwYlVLA51qC3q9UaUfIPh3ncNidM7vo4I6nf8fOgjCMFrW/dNZ3dfo2e6DZSAtL4351+ONphGtogEnWgTOvmaW6B0DSQVe/zMIspk6ZxF03L5UOogcLQK3gxuT+d1T0=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by SA1PR18MB5901.namprd18.prod.outlook.com (2603:10b6:806:3ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 10:45:03 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::bd81:17d2:f4eb:525c]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::bd81:17d2:f4eb:525c%4]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 10:45:02 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>
Subject: RE: [EXT] Re: [net-next PatchV3] octeontx2-pf: Add support to read
 eeprom information
Thread-Topic: [EXT] Re: [net-next PatchV3] octeontx2-pf: Add support to read
 eeprom information
Thread-Index: AQHaaZROIGbxXr4C5kqkRYmpzf+/FLEfgzHw
Date: Wed, 28 Feb 2024 10:45:02 +0000
Message-ID: 
 <PH0PR18MB4474F9F96EDDC1FD22E1B5F9DE582@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240227084722.27110-1-hkelam@marvell.com>
 <28d5c5b8-bd8f-458a-a62e-bb233add4a2b@lunn.ch>
In-Reply-To: <28d5c5b8-bd8f-458a-a62e-bb233add4a2b@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|SA1PR18MB5901:EE_
x-ms-office365-filtering-correlation-id: 212ab055-67ac-4de1-7ac7-08dc384a516d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Zs8j/J/R6/hhZU6SnPJKkqN9csAwQpvjWbO8yzdomNsAwuA3FlM4/GSSeENORra53vLmn1/wokfNdbZ/frufP9CWccK/xEpc9HRVtaewbcJ7X54aSjSxq0oCN5rTqgEAoSK5vtVM0kZ9lQFbgiUyRuJD33rynC1Ufyx4QCo5jp0Y33OcT6e/MN27Kzv9CWnPTzIPSKEPgYrU1oNO32xi9reLU1f8il2/aCmmjSu3G0zL9vrmh/Mvht+Ty3k5nGxby8AlMjMpk/5GKtqzYWutBg2/dHhQ3yhZszyIxjGOuB3qrkqChRkvP/ivuTdLvnUYCr2HgFvPOOgIKGqrouTi2K+56DhcNEEsyQqZDwtT7rnCTODTTiewNENGsc1W6GCpsy+30S7F9PuSh3GkqEmY5+CFK+IiTvorS2lN1N6w4NmegGFapMXogpq3Xq8Tb/SRrcBMuK8964jT3pJlL7A9iDGNvNKNWhf8lGlHlNeRLD6XnCqFrOEocBXXLIIfiCSpyTqIEq56ysqtrzKO5f1/vW8/O+I4npDSUswoG9VGboOUvo4hEhODlApiLoUl5RcIZUXF7Vzy5v3/inCvyxgMF24qEnJg48s3OWeAJW3pkC0t/551p33QAvNyJ6HgLTDi28/Wi3KTXFm/w3otW7fgUGokeDalz1BOpV0H13oAHmnSZcs4lkRNJoR6hmNJCH7Btrdf1P8UDXwVBUj52qmbADMqtbs7OvbvTAUonDKnJnc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?jad2P8dnb1q3Z2B2BiQjfCb+B26fo8qDbH3eQn/TVZ04kxFx7ICTZcfJqkMa?=
 =?us-ascii?Q?pD9jhSA/+eVjsQ2c3GLJAoW5if98ICEbCgQYEhtqYmDqOnDMA3d6AACjwfsS?=
 =?us-ascii?Q?G2xfbXM2H//KLnNfG4+0aSthwF+nqQW/mZiCN+vf+wbnNy6Zn0TvZeELtn6q?=
 =?us-ascii?Q?XGVHU/IU9lxCO8N3Npx3nm7a2pQEQiXHP9wh76WslNyRHsu5sUexFbd3K/Ro?=
 =?us-ascii?Q?ByKjxN1RXr2m6q0QN0njmItlyd9e3cIYCadESQ09SIKPyGJUru3TenlNw/uW?=
 =?us-ascii?Q?a+GkUVW6s8eMXK7OKVn8YF8lRoXYXvDg7iU2gjTQkQ7FjFgFjCDC15xJflKE?=
 =?us-ascii?Q?fixDmFVSYa7xcZ0w0kUCVV4qLpVyOD2kjVG+i+xVL3h0AVg0i+hJfJY5jax2?=
 =?us-ascii?Q?gKuVKexiW8huX9uz3WS2/sWsDEHPDUn9lnlmfameYCa4HcvOtdjtcPMnk+8w?=
 =?us-ascii?Q?ONVlYRQUTF1dZuOJTX8PUb6c23vE0fU+offADAkc/xIU0VQbZUP4obCJJIZP?=
 =?us-ascii?Q?pDkYoyJlJGn0jSVhfbYpkPUbX3A1ft3TgHVPcb8BfYXTm+wwqV5ieVPc8Q8N?=
 =?us-ascii?Q?RCqKesFuoyHoWiTZ9gjFGJx+Sx39vc2kkxa2lvOTx31zEoB5xk5mMT0t417n?=
 =?us-ascii?Q?Z7La1M67+jRxHTrjtAatpR7KHEQPWqqdFEQaMxsziy6Mh0TY9p5lSMKkzF4c?=
 =?us-ascii?Q?5NiB6o8Hvfeub/W0Px+2gM6zVG4FwNG7utmk8GrOyo2QmUkZLhjvetrZ24G+?=
 =?us-ascii?Q?bl7LtdNfiDpP68eSGYGI1zjkBTHPxG+NSR9UDdRSf2z6auEudFA59v8+49sY?=
 =?us-ascii?Q?U/hXmlnl+NtTTp2Jwz9+bB5BpDMiAUnREAxOeQjWqiY+6BQxk3tzUPmPSun+?=
 =?us-ascii?Q?ZRDQsIcvPu9MMtX0iKZwUBE7g/ZFgw9yawKJE0126Wh5s8oPLLcSKXQluhCn?=
 =?us-ascii?Q?IK/ez8UcS+bdrh2Ez0oa73rvzaqmxYvqoY6djJUhEsLnWkqLF3PAdUf3QKAi?=
 =?us-ascii?Q?Y0yGpN80I7aqTYqfV1AsAG0zLUlfLBdP/6ZW/ol83HkvWKPjA3R7cMTqIJkP?=
 =?us-ascii?Q?+7PyqA1xc76Vdxrc9inSQRiKud2Zcrtc/ctim23z8sCN+8OE0xkrm5x4Vv/L?=
 =?us-ascii?Q?Y7k2LPItuSU9nkHkY9gJbhsMhQwl7LMvYLz3DwkJFl3yGhxWivnyTChfGTf9?=
 =?us-ascii?Q?IqOgePIzVOZTExdV+BL9L0KRAKgv9HilhWCloXHL4UhdM5wJpu1G50WQ2R4Q?=
 =?us-ascii?Q?a9jPhYhi/nDhgnh+oXxiWGOBo7PrL5AP5AQWXfVq4rn3I73kg+8rrwFD8V0c?=
 =?us-ascii?Q?oFoOds5ceNlIiUCy/BkMeNFi7npGQiPZXXxbaPYUL1EGPYNaNQ3qkRm4/B4q?=
 =?us-ascii?Q?3aMNrxgSACMzK5fuVTb4ARTvm5VTo/E/QF0IWrOBFhn1tNlg0Qup4g57ajDQ?=
 =?us-ascii?Q?OckskuhXCS4v0JL1AO9QD4RP5qcUwmQ7LyJlOavJngM3N0VcgVvsH6R1W5pD?=
 =?us-ascii?Q?bDgfUVonr7bPHoI158d+OosXxTu7I/SDwxZcEp/67zAVa5HhaQ2HLwZRKD1q?=
 =?us-ascii?Q?kWO29hzUZKoNIWvVlxk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212ab055-67ac-4de1-7ac7-08dc384a516d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 10:45:02.4539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqMl+405nkazHHAg5WXUZtJxMJR4wM24Y7kR4Rlhlwosl131+cAi/8dNBsso7QJVYh0F8EnKgewZr/6vb640OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5901
X-Proofpoint-ORIG-GUID: u6tV6IBAha8Ad8OXvXhebANDg_7NpNp9
X-Proofpoint-GUID: u6tV6IBAha8Ad8OXvXhebANDg_7NpNp9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02


> On Tue, Feb 27, 2024 at 02:17:22PM +0530, Hariprasad Kelam wrote:
> > Add support to read/decode EEPROM module information using ethtool.
> > Usage: ethtool -m <interface>
> >
> > Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> > Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> > ---
> > V3 * remove redundant checks as stack is already doing it.
>=20
> So still only access to the first 256 bytes, using the old internal API.
>=20
Firmware and Kernel shares the data over a shared memory region.=20

  Firmware   <-- Shared memory -->   Kernel

As per our design, firmware updates the shared memory region by reading eep=
rom data from the MAC.=20
Upon receiving ethtool request to read eeprom data, Kernel maps this shared=
 memory and copies the eeprom data to the user.

Currently firmware supports updating only the first page of eeprom. Due to =
this we are limited to support the first page.

, using the old internal API.

While copying the data, the current patch does considers the offset/length =
fields.
         ethtool -m ethx offset x length x

Could please point us what are we missing here?

Thanks,
Hariprasad k


> Disappointing.
>=20
> And the Signed-of-by: appear to be in the wrong order.
>=20
>     Andrew

