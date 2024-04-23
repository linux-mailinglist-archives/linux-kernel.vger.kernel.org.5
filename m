Return-Path: <linux-kernel+bounces-155472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E02C38AEAFC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3D31F22DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE58513C68D;
	Tue, 23 Apr 2024 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="WN8TXdmA"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B197F499;
	Tue, 23 Apr 2024 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886014; cv=fail; b=QaCjsMyqYMcdB++v9tzAv5OEJffUE6z/lL66kzp4llRbdsKUufOTe6dUlobUQb+gGVA4PsbBedVYoxSBpNGeCxMQrWk2g/Pd6ghEmQUJlXSIjn0G9BicZTBjBUoUhDHTUIPhbXkYn9pRnYEHoiZZYD/vC+EyMRdO137IHHqz0sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886014; c=relaxed/simple;
	bh=mUVyHD+3gbV3GfLFPQtdY1SO8+tCO6au8vUqi8AcjdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uxzxNsHKshpMrE0Lx0bo72IJXoxgekilNajQe+5Euj9Ph5amOW20PTWuG82r1lvx6SZ6i7bicrOwY1MlEJfnyyqpRq48L/emjLtJd36IfxICIvGoBBjdunktovFYQwIzBgaI7oRCEOibneBH5hv6AQHgKD0mZXGAQ4Xc3DWepL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=WN8TXdmA; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N5bme2016941;
	Tue, 23 Apr 2024 08:26:45 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xmd7ghkyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 08:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKnSDuLRAmhr1zLnbS5kRKSst8fxzdroMVgt3UsWfM8pQ9Qepx6k/sFnRvDSVincG0j82H1K8WvKzJHDfQbTnbNioYDjs6rbifqUpwZoHhSWbEO+G2n2XLxcBwZicawDWBYhNIPGFQAyvSjjcjRN9ogbRWKL2KjCN/p3++MBBbjfehtk0lS1rZhB7IjdTIglyadRSd/vRWr+nVVortKUL2Nbho82SUq+hPgIowLBfUrppsT4rWEWI8bORPtsHdN31MwWReVCTtI2mfiaZc8+0hp62d91zaf0TMkflFBN9JMc0MuTIcRnSCGyL3r6f5U8MLKKQGzidgdRxedhRKGuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6QLWrWy7GSUtq8F5QJH0M1NZv3PZ2qc7d97UNR9IUY=;
 b=lOjdzlk1RNx5+EroWOqj8Neexv2bIidWXTP6U5A62I4EukoLchNSVrkKnjxzIUQyz30FKtb6RSYTra9UJtYtqi+RJns3y3NC6F+7SbgfLb+ipJBditYR1nkF0ICwkBPWSNv/T6u9u85c10qNpr5hgSg2Gn5Bkqlta76vLQu+RDsrfLIdnmRglflXq8idP6QBRs0GgRakzJ+/cHsMLTlISS89cKldq/bTT5TIDDPcdeVAjxHjOV81DDfDl1ShqSbHnodPUq9sB9orKQ0/YaeccRsXpOKJj4FJADdOC6dTtaS+nwTWttU/yNtvTtAQ7y53Of6CN38cLuK0LeEmTCXPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6QLWrWy7GSUtq8F5QJH0M1NZv3PZ2qc7d97UNR9IUY=;
 b=WN8TXdmAVDgxtE+OneJGfQHQHpT1lLtk0fn1NKL0uEan2OWmTmwXHERJJpaOgTN2z4T5uvYxCYk1PghJIOFlPyI1qi4nec2pRf2dS7SH7/5oghjb9nOKw6GTFLmUP6o1cXo1IFuaRvHxYXmB/QZwKI9pJ1rf37pGKAiEbd/TW/4=
Received: from BL1PR18MB4342.namprd18.prod.outlook.com (2603:10b6:208:31e::16)
 by BN9PR18MB4171.namprd18.prod.outlook.com (2603:10b6:408:135::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 15:26:42 +0000
Received: from BL1PR18MB4342.namprd18.prod.outlook.com
 ([fe80::9e3c:b30b:67cf:1d16]) by BL1PR18MB4342.namprd18.prod.outlook.com
 ([fe80::9e3c:b30b:67cf:1d16%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 15:26:42 +0000
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
Subject: RE: [EXTERNAL] Re: [net-next PATCH v2 3/9] octeontx2-pf: Create
 representor netdev
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v2 3/9] octeontx2-pf: Create
 representor netdev
Thread-Index: AQHalJsM+VEDDMZXiEiAfPrHGMJ1t7F0hM+AgAF2g7A=
Date: Tue, 23 Apr 2024 15:26:41 +0000
Message-ID: 
 <BL1PR18MB4342B90F7B97221386A10FAACD112@BL1PR18MB4342.namprd18.prod.outlook.com>
References: <20240422095401.14245-1-gakula@marvell.com>
 <20240422095401.14245-4-gakula@marvell.com> <ZiaYZ7EWwauvQiBr@nanopsycho>
In-Reply-To: <ZiaYZ7EWwauvQiBr@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR18MB4342:EE_|BN9PR18MB4171:EE_
x-ms-office365-filtering-correlation-id: 211c6039-765c-4e7c-9f3b-08dc63a9c710
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?CpbyjhYiknF72OCXMHdUtEFsBUFd9TR63gFZnHm7geP444gzJENH+UnyZvtj?=
 =?us-ascii?Q?dvbvdpyfkKUWNGSrbbo1PDJ5PsquMq6LThOFbKcYvOWXpDG4Q7+aN1aAGTjA?=
 =?us-ascii?Q?Y6MkVrrtr5vpfnepLOvuSnBpp8mUTHQ7m+rhEo/6fatFydGkBE2/iws/ppeA?=
 =?us-ascii?Q?sIJhVDWfwHkPsvsRB21S0zPOjorTaCAqpuT9yMxnsLJU/hmW+FzrXXA/aX9f?=
 =?us-ascii?Q?O7p8ke2tbHchpS0MXXG/xCPMQQuDweGlx8m7yUd26/G72Pn+Hok6NcnVcDUI?=
 =?us-ascii?Q?hTg7f6X/daKAOcf40jeQsvyAirbEIdcOPx5loE+1SX18ytlZrPAK/f0cOkPj?=
 =?us-ascii?Q?CFiaZmOVe/KoLQtOTYsF4IS4I7ecpB2RHXI2RP9kZj053q7VEs3CtgndYl9I?=
 =?us-ascii?Q?zudF24aDxg7ErkRcIa0cVP80NEK8Gq53FkoFfzh6gX08fyTMbu8IDxSY+R4M?=
 =?us-ascii?Q?+unrSOCHm3zvG5hfzyrxWQkXSQ4ihYCOpEZ4VXL9iaRgPK1+6EavJFWkRXXT?=
 =?us-ascii?Q?4r2H32yG6PITMnpsHXV6d7kgHhWMz0w971qzdj1WZACOtMJQmhKE/Bpqqgcr?=
 =?us-ascii?Q?P484oSFs877q6NdMLO0xaAv6PiEAwY9XqN+/tA4XQFVKXjht9VFAH0E6nahi?=
 =?us-ascii?Q?3/uHExZLIhUp2il0ucJplBINYvxJNopYoaOy83t/hUySr6ozQy1mtvI1RwCx?=
 =?us-ascii?Q?yaixABwuS9cOPp6OOCYZmpR3sdFXH7HsfWlVo7w6eZm9O0KH6v0PyjDxzp8X?=
 =?us-ascii?Q?ImB8WlnnZaKRt3ohCJekXz0D1wcD3PRxDn/H55zmUjog02vmSQZ1PjPnllBH?=
 =?us-ascii?Q?2lQ4r82FoKLHe5R85EZJVUD/9JbOlAjbk0kdXYZPwzyZ1PK0gmvzYYH5ZmaQ?=
 =?us-ascii?Q?X8LjHhNkBkXQJgxXu23WcA4RSHi90CZAsu2S4OmbPDd9qDln9LgUJTQP89eg?=
 =?us-ascii?Q?5uOt6pvaAbOfNaUJZmw47IoNvBwLOzFgSAptvAO6VusT+qOBcj5w7uSPuOiD?=
 =?us-ascii?Q?dMZk+RRCiMm++iQ54xNZkKxroqOOk5M+qjeiYmH0azXsm0KLRUIXviOlZdmW?=
 =?us-ascii?Q?o3yfua1myH9/QwMilkG06cnt+9b/ja2aOThIyy1+4gZVacteCBP2j1uNzyMI?=
 =?us-ascii?Q?MGdM5MzOo366QEtgol8mXg9zD6zCYGrIq19VL38eRpzM6d13pOdrUSsjxE3E?=
 =?us-ascii?Q?/fi0eGmv9ej4j9Wn7GB8O4EkJ0197QzQf+KTH6BNxk69+5TulceFmScjhHDy?=
 =?us-ascii?Q?ZeT+20/LAeO1HjU95BvroqweiGPRFk8ex+luDh+03NWE5Mzk/INPE8lqNd8v?=
 =?us-ascii?Q?MLI+7e4M3kCOfbEznY9HGxUxfDf247ux/WcslkCaCdoC2Q=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR18MB4342.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?KCwBEA5uZeU8qP+T65+hyJEKrnefcf3foPr4x8uXil+cKQzvFa0o4LXNrqkg?=
 =?us-ascii?Q?ccUh5JsNyE3gzKrQ+ARg4gvrISDJ5EBO3NvNm0/wJWFKGxDmPytDHH+dwXDx?=
 =?us-ascii?Q?enKIfpg6/OKSxFsxw5QqS97wEmq9foab+kiNZsEV1Gngig3qVrFzyv0TLJFS?=
 =?us-ascii?Q?vx14hYX2eRiE8fDjLCyl1ERM5pHZHg6JHp2u1pYDpgf9P9K7LJhEnJNYLhj1?=
 =?us-ascii?Q?R+gyu2MD/5M/X0cS37FS77Bkf3c++P5iQuV5CyUL/tE+KobZsOjnP270sxH/?=
 =?us-ascii?Q?7zvS9K6bGTWP8F/NH6z4U6HAdfiXVpT5qO+VsNM+rnH4+TFgR9vXIdTTe/IV?=
 =?us-ascii?Q?HvrmBQ8iMZg8DQfZXIpwSJCLD/cNvtNZjSqwVZezfuw931CGBvv2NxYu89DS?=
 =?us-ascii?Q?BQ30F6NT2yOdLQMD25B2TvoZGL80wn0wnl44XSlI9wDmz2+Yv9zWAD4Pj2N0?=
 =?us-ascii?Q?HOcKhvakRsLb9M0cr0oJZrRGnRLUp1qAGZc208NcKCe8ls1F+/4xU2iepRdR?=
 =?us-ascii?Q?AFSwvLpM9aUj+TlrcYn333RqJeZQsdFa4muzgBSpQltz+Ga2C1gx7HQhfSLz?=
 =?us-ascii?Q?i2uxWjQI7DqIwpNc9KN0USmMqLpBHp5q5AunSqDpnI5qJtBPaXNvlEMSYMlR?=
 =?us-ascii?Q?2/bMM6N5dfpNDP/Fm73kK2uy91OGk/nd67UWBLn9AQPgKujWVeA123/rZoAq?=
 =?us-ascii?Q?vzz0LBU5hFYlwQtNpC+fr3Zdzc2v0D6sOBITK+MBWOQKA8xS4xWdW9h3y4GV?=
 =?us-ascii?Q?hEisoa/CQGgfPo9dZa6M4vg8pgjZFhEd+AcEGsbiAdCWe83NiiRAfI7U7D3y?=
 =?us-ascii?Q?uGCVwUTcfJq3YPUL7QGLxnLBH39E4rKWOxKg70iDtPgYpL8L0Ep6ochRoFKo?=
 =?us-ascii?Q?L2J1qgc8DizsrKi5s7lOz/GwOwX/R4XVuTo/TUu83s0dWQIKWO7By/lHsjYI?=
 =?us-ascii?Q?dGT/43oH9thySp4DBv/aSzHjxxBrwdcVFrqjZmlJPkfRgdPWE4X4PL3pI1l2?=
 =?us-ascii?Q?vU1CjDxFNNemb59S5zh5H1nlnMnCnaquwBFeSsWevq7Pqox7bQHq26KdWLsG?=
 =?us-ascii?Q?StQYgUanfQCucDqmG7G9G/Qjh1lqB+gexz5exr5SLsizrcZyEXweBf6WxY5x?=
 =?us-ascii?Q?o5nJAM/tLfEPqNfenoeG2QYVJ7TMGkrRlj1S9/hmqt1GGRHfZEk/QbvfiG6P?=
 =?us-ascii?Q?RSzGqvwLxDbJeA7IbnDj7yErkx5pAIzzznC8W8aHSnWozg3xyFwtUrnkt9f1?=
 =?us-ascii?Q?85WggvS+xYOmZ/eaADDNg6R2UQPDYSLmxWPLoGX0qo0+h4QGGYKbWBT1+499?=
 =?us-ascii?Q?Iqv6OOg5jrTnrydab1HoNStJl1X3u4uY90RHRIIQ7aafrvZzDEdhHmlgQxap?=
 =?us-ascii?Q?q7NC4OrciAR802HpLFlqsb5USe6ANtYGnEYTDUv66+rTru5QO0uSb5gT81N/?=
 =?us-ascii?Q?p5WJYL8GHZswE+2viaWvDaLgiC4HebLGVsdlF8PhSxBtF+k6+nLO4aRZpBKD?=
 =?us-ascii?Q?Dq9xGBMVB5g6RO+T4qd+bHz4dP+nV+PnFpaLd8ffU6k4xBjkO1nLYDuoOYMP?=
 =?us-ascii?Q?tIiscZta5sIEeyF4c2g=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR18MB4342.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211c6039-765c-4e7c-9f3b-08dc63a9c710
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 15:26:42.0004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4J54ebh7i45fVdEhM5Ogk61oPfQAa32wWcPThk0jCqhUGoTlOgA2yjMbHiGZK66uwNqx+rtZLYils4rYpB4V/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4171
X-Proofpoint-ORIG-GUID: h2GgDRhXDh8QMu3d0WcVZlylhRObZn0b
X-Proofpoint-GUID: h2GgDRhXDh8QMu3d0WcVZlylhRObZn0b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_02,2023-05-22_02



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Monday, April 22, 2024 10:34 PM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org=
;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: [EXTERNAL] Re: [net-next PATCH v2 3/9] octeontx2-pf: Create
> representor netdev
> ----------------------------------------------------------------------
> Mon, Apr 22, 2024 at 11:53:55AM CEST, gakula@marvell.com wrote:
> >Adds initial devlink support to set/get the switchdev mode.
> >Representor netdevs are created for each rvu devices when the switch
> >mode is set to 'switchdev'. These netdevs are be used to control and
> >configure VFs.
> >
> >Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> >---
> > .../marvell/octeontx2/nic/otx2_devlink.c      |  47 ++++++
> > .../net/ethernet/marvell/octeontx2/nic/rep.c  | 154 ++++++++++++++++++
> > .../net/ethernet/marvell/octeontx2/nic/rep.h  |   2 +
> > 3 files changed, 203 insertions(+)
> >
> >diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
> >b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
> >index 4e1130496573..60156c7ebe45 100644
> >--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
> >+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
> >@@ -76,7 +76,52 @@ static const struct devlink_param otx2_dl_params[] =
=3D {
> > 			     otx2_dl_mcam_count_validate),
> > };
> >
> >+#ifdef CONFIG_RVU_ESWITCH
> >+static int otx2_devlink_eswitch_mode_get(struct devlink *devlink, u16
> >+*mode) {
> >+	struct otx2_devlink *otx2_dl =3D devlink_priv(devlink);
> >+	struct otx2_nic *pfvf =3D otx2_dl->pfvf;
> >+
> >+	if (!is_rep_dev(pfvf->pdev))
> >+		return -EOPNOTSUPP;
> >+
> >+	*mode =3D pfvf->esw_mode;
> >+
> >+	return 0;
> >+}
> >+
> >+static int otx2_devlink_eswitch_mode_set(struct devlink *devlink, u16
> mode,
> >+					 struct netlink_ext_ack *extack)
> >+{
> >+	struct otx2_devlink *otx2_dl =3D devlink_priv(devlink);
> >+	struct otx2_nic *pfvf =3D otx2_dl->pfvf;
> >+
> >+	if (!is_rep_dev(pfvf->pdev))
> >+		return -EOPNOTSUPP;
> >+
> >+	if (pfvf->esw_mode =3D=3D mode)
> >+		return 0;
> >+
> >+	switch (mode) {
> >+	case DEVLINK_ESWITCH_MODE_LEGACY:
> >+		rvu_rep_destroy(pfvf);
> >+		break;
> >+	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
> >+		rvu_rep_create(pfvf);
>=20
>=20
> rvu_rep_create() returns int. Return that from this function. Also, pass =
extack
> and let rvu_rep_create() fill up the message in case of any error.
Ack.
>=20
>=20
> >+		break;
> >+	default:
> >+		return -EINVAL;
> >+	}
> >+	pfvf->esw_mode =3D mode;
> >+	return 0;
> >+}
> >+#endif
> >+
> > static const struct devlink_ops otx2_devlink_ops =3D {
> >+#ifdef CONFIG_RVU_ESWITCH
> >+	.eswitch_mode_get =3D otx2_devlink_eswitch_mode_get,
> >+	.eswitch_mode_set =3D otx2_devlink_eswitch_mode_set, #endif
> > };
> >
> > int otx2_register_dl(struct otx2_nic *pfvf) @@ -112,6 +157,7 @@ int
> >otx2_register_dl(struct otx2_nic *pfvf)
> > 	devlink_free(dl);
> > 	return err;
> > }
> >+EXPORT_SYMBOL(otx2_register_dl);
> >
> > void otx2_unregister_dl(struct otx2_nic *pfvf)  { @@ -123,3 +169,4 @@
> >void otx2_unregister_dl(struct otx2_nic *pfvf)
> > 				  ARRAY_SIZE(otx2_dl_params));
> > 	devlink_free(dl);
> > }
> >+EXPORT_SYMBOL(otx2_unregister_dl);
> >diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> >b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> >index 0e19b938d197..e2571728cb0d 100644
> >--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> >+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> >@@ -28,6 +28,154 @@ MODULE_DESCRIPTION(DRV_STRING);
> >MODULE_LICENSE("GPL");  MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
> >
> >+static int rvu_rep_napi_init(struct otx2_nic *priv) {
> >+	struct otx2_cq_poll *cq_poll =3D NULL;
> >+	struct otx2_qset *qset =3D &priv->qset;
> >+	struct otx2_hw *hw =3D &priv->hw;
> >+	int err =3D 0, qidx, vec;
> >+	char *irq_name;
> >+
> >+	qset->napi =3D kcalloc(hw->cint_cnt, sizeof(*cq_poll), GFP_KERNEL);
> >+	if (!qset->napi)
> >+		return -ENOMEM;
> >+
> >+	/* Register NAPI handler */
> >+	for (qidx =3D 0; qidx < hw->cint_cnt; qidx++) {
> >+		cq_poll =3D &qset->napi[qidx];
> >+		cq_poll->cint_idx =3D qidx;
> >+		cq_poll->cq_ids[CQ_RX] =3D
> >+			(qidx <  hw->rx_queues) ? qidx : CINT_INVALID_CQ;
> >+		cq_poll->cq_ids[CQ_TX] =3D (qidx < hw->tx_queues) ?
> >+					  qidx + hw->rx_queues :
> CINT_INVALID_CQ;
> >+		cq_poll->cq_ids[CQ_XDP] =3D CINT_INVALID_CQ;
> >+		cq_poll->cq_ids[CQ_QOS] =3D CINT_INVALID_CQ;
> >+
> >+		cq_poll->dev =3D (void *)priv;
> >+		netif_napi_add(priv->reps[qidx]->netdev, &cq_poll->napi,
> >+			       otx2_napi_handler);
> >+		napi_enable(&cq_poll->napi);
> >+	}
> >+	/* Register CQ IRQ handlers */
> >+	vec =3D hw->nix_msixoff + NIX_LF_CINT_VEC_START;
> >+	for (qidx =3D 0; qidx < hw->cint_cnt; qidx++) {
> >+		irq_name =3D &hw->irq_name[vec * NAME_SIZE];
> >+
> >+		snprintf(irq_name, NAME_SIZE, "rep%d-rxtx-%d", qidx, qidx);
> >+
> >+		err =3D request_irq(pci_irq_vector(priv->pdev, vec),
> >+				  otx2_cq_intr_handler, 0, irq_name,
> >+				  &qset->napi[qidx]);
> >+		if (err) {
> >+			dev_err(priv->dev,
> >+				"RVU REP IRQ registration failed for CQ%d\n",
> qidx);
> >+			goto err_free_cints;
> >+		}
> >+		vec++;
> >+
> >+		/* Enable CQ IRQ */
> >+		otx2_write64(priv, NIX_LF_CINTX_INT(qidx), BIT_ULL(0));
> >+		otx2_write64(priv, NIX_LF_CINTX_ENA_W1S(qidx),
> BIT_ULL(0));
> >+	}
> >+	priv->flags &=3D ~OTX2_FLAG_INTF_DOWN;
> >+	return 0;
> >+
> >+err_free_cints:
> >+	otx2_free_cints(priv, qidx);
> >+	otx2_disable_napi(priv);
> >+	return err;
> >+}
> >+
> >+static void rvu_rep_free_cq_rsrc(struct otx2_nic *priv) {
> >+	struct otx2_cq_poll *cq_poll =3D NULL;
> >+	struct otx2_qset *qset =3D &priv->qset;
> >+	int qidx, vec;
> >+
> >+	/* Cleanup CQ NAPI and IRQ */
> >+	vec =3D priv->hw.nix_msixoff + NIX_LF_CINT_VEC_START;
> >+	for (qidx =3D 0; qidx < priv->hw.cint_cnt; qidx++) {
> >+		/* Disable interrupt */
> >+		otx2_write64(priv, NIX_LF_CINTX_ENA_W1C(qidx),
> BIT_ULL(0));
> >+
> >+		synchronize_irq(pci_irq_vector(priv->pdev, vec));
> >+
> >+		cq_poll =3D &qset->napi[qidx];
> >+		napi_synchronize(&cq_poll->napi);
> >+		vec++;
> >+	}
> >+	otx2_free_cints(priv, priv->hw.cint_cnt);
> >+	otx2_disable_napi(priv);
> >+}
> >+
> >+void rvu_rep_destroy(struct otx2_nic *priv) {
> >+	struct rep_dev *rep;
> >+	int rep_id;
> >+
> >+	rvu_rep_free_cq_rsrc(priv);
> >+	for (rep_id =3D 0; rep_id < priv->rep_cnt; rep_id++) {
> >+		rep =3D priv->reps[rep_id];
> >+		unregister_netdev(rep->netdev);
> >+		free_netdev(rep->netdev);
> >+	}
> >+}
> >+
> >+int rvu_rep_create(struct otx2_nic *priv) {
> >+	int rep_cnt =3D priv->rep_cnt;
> >+	struct net_device *ndev;
> >+	struct rep_dev *rep;
> >+	int rep_id, err;
> >+	u16 pcifunc;
> >+
> >+	priv->reps =3D devm_kcalloc(priv->dev, rep_cnt, sizeof(struct rep_dev)=
,
> GFP_KERNEL);
> >+	if (!priv->reps)
> >+		return -ENOMEM;
> >+
> >+	for (rep_id =3D 0; rep_id < rep_cnt; rep_id++) {
> >+		ndev =3D alloc_etherdev(sizeof(*rep));
> >+		if (!ndev) {
> >+			dev_err(priv->dev, "PFVF representor:%d creation
> failed\n",
> >+rep_id);
>=20
> Please avoid dmesg prints like this, use extack instead.
> Please follow this with the functions you call, like rvu_rep_napi_init()
>=20
Ack. Will address it in the next version.
>=20
> >+			err =3D -ENOMEM;
> >+			goto exit;
> >+		}
> >+
> >+		rep =3D netdev_priv(ndev);
> >+		priv->reps[rep_id] =3D rep;
> >+		rep->mdev =3D priv;
> >+		rep->netdev =3D ndev;
> >+		rep->rep_id =3D rep_id;
> >+
> >+		ndev->min_mtu =3D OTX2_MIN_MTU;
> >+		ndev->max_mtu =3D priv->hw.max_mtu;
> >+		pcifunc =3D priv->rep_pf_map[rep_id];
> >+		rep->pcifunc =3D pcifunc;
> >+
> >+		snprintf(ndev->name, sizeof(ndev->name), "r%dp%d", rep_id,
> >+			 rvu_get_pf(pcifunc));
> >+
> >+		eth_hw_addr_random(ndev);
> >+		err =3D register_netdev(ndev);
> >+		if (err) {
> >+			dev_err(priv->dev, "PFVF reprentator registration
> failed\n");
> >+			goto exit;
> >+		}
> >+	}
> >+	err =3D rvu_rep_napi_init(priv);
> >+	if (err)
> >+		goto exit;
> >+
> >+	return 0;
> >+exit:
> >+	while (--rep_id >=3D 0) {
> >+		rep =3D priv->reps[rep_id];
> >+		unregister_netdev(rep->netdev);
> >+		free_netdev(rep->netdev);
> >+	}
> >+	return err;
> >+}
> >+
> > static int rvu_rep_rsrc_free(struct otx2_nic *priv)  {
> > 	struct otx2_qset *qset =3D &priv->qset; @@ -163,6 +311,10 @@ static
> int
> >rvu_rep_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > 	if (err)
> > 		goto err_detach_rsrc;
> >
> >+	err =3D otx2_register_dl(priv);
> >+	if (err)
> >+		goto err_detach_rsrc;
> >+
> > 	return 0;
> >
> > err_detach_rsrc:
> >@@ -184,6 +336,8 @@ static void rvu_rep_remove(struct pci_dev *pdev)  {
> > 	struct otx2_nic *priv =3D pci_get_drvdata(pdev);
> >
> >+	otx2_unregister_dl(priv);
> >+	rvu_rep_destroy(priv);
> > 	rvu_rep_rsrc_free(priv);
> > 	otx2_detach_resources(&priv->mbox);
> > 	if (priv->hw.lmt_info)
> >diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> >b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> >index 30cce17eb48b..be6c939e5cba 100644
> >--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> >+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> >@@ -29,4 +29,6 @@ static inline bool is_rep_dev(struct pci_dev *pdev)
> > 	return pdev->device =3D=3D PCI_DEVID_RVU_REP;  }
> >
> >+int rvu_rep_create(struct otx2_nic *priv); void rvu_rep_destroy(struct
> >+otx2_nic *priv);
> > #endif /* REP_H */
> >--
> >2.25.1
> >
> >

