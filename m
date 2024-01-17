Return-Path: <linux-kernel+bounces-28508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A874D82FF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3314D1F2568D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320BD63D5;
	Wed, 17 Jan 2024 03:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="D+UT7s2P"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5854696;
	Wed, 17 Jan 2024 03:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705463744; cv=fail; b=fhrNjFuO7m7LD1hf2yhaUypxUG669bp6dPgzJeTz8/2I5yvJpPj9yfH77xGzYY0pS0Ni3UMrdx8ITjcZ1hj5kQZr9qBu/QrZOPAX4VoF7hhXVjzK1s5SHj0X2Rv2HqBrjADkudABwSk0uDzKJeh1XBUotYGMCKXNBBL+Lj4R6cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705463744; c=relaxed/simple;
	bh=EXPbj5vjbjQPQvUiov/ygrB9Esqo+gzTwcE0rnE1HsU=;
	h=Received:Received:ARC-Message-Signature:
	 ARC-Authentication-Results:DKIM-Signature:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-dg-rorf:x-dg-ref:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version; b=azvcqXb7+nOHnWYlYre7stA6qytycbKY5UrLzuBYOWHqRVHkmI0a7ns/NQkZmGD/aN5R1l6OHtprZyvPQp/R+ZH2B3MR4uZmUaIIOt5VVOrqcJZ8a3bxgnUaHCEr2XLMX5dsFAYvru3458OoM876+hzf1yhE8tOV3x/BvuikDvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=D+UT7s2P; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40GI9D2P002854;
	Tue, 16 Jan 2024 19:55:17 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vnxu1j18p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 19:55:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXBQdVO7zl83EdIGMKklFXbQvnvd+DB0FZbGfwkKOUPGvKUCGSGnEAqqkRGhx1j9Ry3NwuzZZ8G+h58dzSl+zJbkod/VC8y8maI5+DljJZen2KgC64TE7GVkqtAH/1uH7/x8aBFWg/dTkqYDuR9ugC/2ZnHzOrdkt7CZdwQ2pGo/N3/sKaLyCk0YxNG2/oRN3WSXtX8dPQTq+q9B5f7k3I47DVFSsMaDRSiBGpL/hEb55T2yLmbXjF0a0t0agsL7/IDezmClvV6M0z+p6H7juMKiMjmPGMzppAezbAG3A3bJxm2ohxqX8kiY3AWhODMFw55bD0PHh51jst0/0y+5Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXPbj5vjbjQPQvUiov/ygrB9Esqo+gzTwcE0rnE1HsU=;
 b=RxLiC2/MnA79lVCeV4EPggVKdtpXpxrUSCIpt35hSaBYzUPxCBjxjb9Hn5U51aYpF+PVNEEYNbcPzWIvN+wuCw4pVCkt52vVK2FbIsLH+OKyr3hIXKtu5GsEc3dwzliE1gE86jhA7tnS8DXxTwKGzA0CaGnUSxJ19EewO/1u6ceF2TolKs52omzOzP1liWrAx/aa9l5Ziaj93/wUabgNt7GrineS1Zl1nuppeSFVYfdknHQ/YKH4+C4+BUp6qpkTh5YORzE408Rhx3yLCZcr8+F2+u43mm5W2ZtpwNGwnms/zv4MJPVjRwWOm8PYvh2GMyehST2p+oGDRLXN6EJxZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXPbj5vjbjQPQvUiov/ygrB9Esqo+gzTwcE0rnE1HsU=;
 b=D+UT7s2PfjXYn9H01BUfQIrGWsLDgmn+771TMofD0unAw1hreMftRrqs1u71jy5u2qUyndkJLO5e73reBRra9z8bZ0bf9A+Vo6i6tbR2Kog8ey4sKTP8KAIw/gARe+qB8taLDeXyorgfxeVv5Ao6nv91Slf+XHWB7/STDa1PyKw=
Received: from PH0PR18MB4543.namprd18.prod.outlook.com (2603:10b6:510:ac::22)
 by SA1PR18MB5767.namprd18.prod.outlook.com (2603:10b6:806:3af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 03:55:13 +0000
Received: from PH0PR18MB4543.namprd18.prod.outlook.com
 ([fe80::f8e5:bce7:49c8:f0f9]) by PH0PR18MB4543.namprd18.prod.outlook.com
 ([fe80::f8e5:bce7:49c8:f0f9%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 03:55:13 +0000
From: "Jenishkumar Patel [C]" <jpatel2@marvell.com>
To: 'Jakub Kicinski' <kuba@kernel.org>
CC: "marcin.s.wojtas@gmail.com" <marcin.s.wojtas@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 1/1] net: mvpp2: clear BM pool before
 initialization
Thread-Topic: [EXT] Re: [PATCH 1/1] net: mvpp2: clear BM pool before
 initialization
Thread-Index: AQHaSED3tkBbnIbaJEakXSpW8Z3u47Dci/4AgADU+MA=
Date: Wed, 17 Jan 2024 03:55:13 +0000
Message-ID: 
 <PH0PR18MB4543D125A30B59379B4EDF2DEC722@PH0PR18MB4543.namprd18.prod.outlook.com>
References: <20240116055754.279560-1-jpatel2@marvell.com>
 <20240116071116.7964ad76@kernel.org>
In-Reply-To: <20240116071116.7964ad76@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: 
 PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcanBhdGVsMlxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTMyMWVmNWI5LWI0ZWMtMTFlZS1iYTJlLTAwMjI0ODZiODBmOVxhbWUtdGVzdFwzMjFlZjViYi1iNGVjLTExZWUtYmEyZS0wMDIyNDg2YjgwZjlib2R5LnR4dCIgc3o9IjEwOTgiIHQ9IjEzMzQ5OTM3MzA4MDgwMTEzOCIgaD0iaHcvZW1JWkZvUXRKeFhNc2FERXJqTG5FcHowPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4543:EE_|SA1PR18MB5767:EE_
x-ms-office365-filtering-correlation-id: d064c10f-c343-445a-0612-08dc17101bbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Psg4P8+AB1WU12spCooYSlK6uflDXEWjqoOO5gz6dRGJ3+lTKOpDO6rPSWF6W3dpSEb22CzW8eW0C/GjFZZDdnvIXl/oVAGHD9JeM5XHNAktKT1gPb75igpgyZLQClfdYGsR11oU1Qp2cYlcrU3O4APmiEi+Zhv1OATIigi/jELr9WYVGqkINlxQp8fBRyXEObL0kqhLNq0dchyfFzvIdKchhwV+WUU8D8JtsmUEf8jvmSMZRV53O5P5OdxCrlQN2rUFheMupJ+hBSamrKNfC3tVyiS4UK/4tOWAXQL8YhRFr0A7o6NjcZDw6ftD+RB9mBsxVggaev/1RBCUDJvYuIqDZ0PV6hQQxePIirU/Abpa4M7A39t5wBNvvKgPWqh+bpoUooozzJs5hcuOp6ef8pHkWsl3GD74JRNBlF2ZyG5IZt4J9OekbEICAnE/eJJo3KYaJ0q6oYT3/Gmg6i38wL/l7T8aecGyRwku4hRs2sKCVA7o7YgloE4OJGwcX9KVy3ch75cBnXlx8V0E/5GWkknAoqhfoNxPGGMqBf1WpDfwlJyaifJWiennbhT91hJ9XaAXtImMCkDpvJFkGAi4VMicoKV9KIQS65AmyY00DyjTYwN5DJM+oP37w1DKfc/CgeKX6LOSI4fZHrnzbI7zNPrqkkoD+l9x2+1V7OXfGjs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4543.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230273577357003)(230922051799003)(230173577357003)(186009)(1800799012)(64100799003)(451199024)(4744005)(52536014)(55016003)(4326008)(8676002)(8936002)(316002)(54906003)(2906002)(5660300002)(66946007)(76116006)(64756008)(66446008)(66476007)(6916009)(66556008)(33656002)(478600001)(41300700001)(71200400001)(38070700009)(6506007)(7696005)(53546011)(9686003)(26005)(38100700002)(83380400001)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?DZVQELRHZq/oWHca4J/gqnHt2WZ5xGZD9xyn+owod1DHPB1Jr4bj9iea36Dc?=
 =?us-ascii?Q?JvEz16s/PEyZJKF5EcsJ6M5qHvQzfs58Dt9dcjMg1rep8dhg+CjHcV5zkLBc?=
 =?us-ascii?Q?BHk6q0Np0GczzdUgzu93mfxMfJBPQQYfDDAIljiui+TNHfExrhhL/92LKvAI?=
 =?us-ascii?Q?e5+dXD2B4ZVwnCeM19M858lDkqfFccQLiMEaQRfl+hoWekp6Qii9ayPfORLy?=
 =?us-ascii?Q?jI6FSX8hLseNlRWizBqhmFh57Lfus5lPku3tAKhP20xbvcbl+aFKiu3bVs/Q?=
 =?us-ascii?Q?oeQUYmMMQarZNiZvOEHBElCVh6V9lqqHGcKO/N2H2nRZAwoYNHbN6f2Uh/lD?=
 =?us-ascii?Q?ioLs7oLyfo008qhYent21j/MPgX92D9+2zr7PJ5+gb/17s7/uUucGYxLe2nh?=
 =?us-ascii?Q?3ozvonefn6hnjy6oczz6AIgs9dLOYz4fMj1huQdxwjwogUg8V4QVoRUEi9K4?=
 =?us-ascii?Q?YChGU8dp/XOgdjWHYgNCZlZrajfhuD1u5h2BG5yEdekAiCgzabCqZ+MnJMr3?=
 =?us-ascii?Q?78ppsHr2M9YoM5/F6ncwt26p8hFwLVWUIFrJnOt6XloUgrsqLsqjNo25kH9N?=
 =?us-ascii?Q?my3q4I9HCsLjCRTwbv7rBCOERR5/dqacQk9bDeiqihU8X/uq6JVBNgUsgSL8?=
 =?us-ascii?Q?NcbXlHo7bIOx8u2fegP+dKPz6LDxgNTg4iRwYRoYVcJB1at4h3r83xzG3Yms?=
 =?us-ascii?Q?SMosIrto41rGnyGa1zztjkwvuje7TeSaOHqPVFz2WehirMelX/wq5ND29z4s?=
 =?us-ascii?Q?LnKJhq+UiNidBzTVfbw2dlFIQKydH5ec3ZQ4GMUHBH2ZQLvyeyOyWmMpwsIs?=
 =?us-ascii?Q?T8+SnzJPv7e7WgqZFTNjhh+/r4tOHFDsjphb0Nwq/e23E/PXRgsb8E61BpJ/?=
 =?us-ascii?Q?hkMhMHOOW5I3xFN/MBgNKqIjsPKVZQvKj5XPo2UDltW2z8Jhyb63Y/b4LYXM?=
 =?us-ascii?Q?KJkmusPwQGWhGueGhJVMAFaeuEg8B2rTfGcD9twsMn74ZLAavdQ8aqQu+8fx?=
 =?us-ascii?Q?nr9x2GUPGRYBbG3f9SjhDHG3TLgXHIstCvRcaK1OZuEPkP8KcpNj39j+tF3h?=
 =?us-ascii?Q?UholKCni/TXjD2uf9hLcnCdzmXFP9YM1iE1/ExExbEV3x7IxxqBI+fzm57um?=
 =?us-ascii?Q?A+NUrwR4nGGDLXJabwDveb7vQlBwLbi+CeswKkVycy/BWhYE0Av9TdHi6jw+?=
 =?us-ascii?Q?mRoNCZAWwq1LQCmqD5DqV03EIEbI5K0ixtSONE8Z/UqR+dxmP/rQelAV3WIl?=
 =?us-ascii?Q?B0/2uq8ejo09AuotrbMBY5ZCzanJe8Q5ZhsdLA0PcdL+020OAZ3PHDsuzVIZ?=
 =?us-ascii?Q?vepFCLHT2XC1sLod7xiWNv9j+rajNCfOuTiCTwLoixEJ0mRH2Xm/Ea4wU5iK?=
 =?us-ascii?Q?IzWVrA9m12jI/RIfiLBnN0A6enrT+mkrz3wFSsYbvr8bqsGOlShx8xNZv4ip?=
 =?us-ascii?Q?IjvFCG1PzPCo0kYiljN4zitH6oNkMVEsPQ64RBoULRTkmy/4N5W/HoNV1ybD?=
 =?us-ascii?Q?eLUodGKCsbRltZm3AQnp95jxH+9J1P3XXU1ZUgwJllsCrO9isF7o/UKooufK?=
 =?us-ascii?Q?tfXSyrT6fqsveC9tBHs=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4543.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d064c10f-c343-445a-0612-08dc17101bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 03:55:13.1412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gdWc2BkpAJ1p2KfPyKPyDzZt7SmAlnN9ge61X4W1mzVp+jdy6DQ+cUGUTm9PQZPL1ZWut41JlMnfBsUCq19STA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5767
X-Proofpoint-GUID: QF5Jf1Q5Ig450rIy-OG_bAkRlgh0-svJ
X-Proofpoint-ORIG-GUID: QF5Jf1Q5Ig450rIy-OG_bAkRlgh0-svJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02


-----Original Message-----
From: Jakub Kicinski <kuba@kernel.org>=20
Sent: Tuesday, January 16, 2024 8:41 PM
To: Jenishkumar Patel [C] <jpatel2@marvell.com>
Cc: marcin.s.wojtas@gmail.com; linux@armlinux.org.uk; davem@davemloft.net; =
edumazet@google.com; pabeni@redhat.com; netdev@vger.kernel.org; linux-kerne=
l@vger.kernel.org
Subject: [EXT] Re: [PATCH 1/1] net: mvpp2: clear BM pool before initializat=
ion

External Email

----------------------------------------------------------------------
On Mon, 15 Jan 2024 21:57:54 -0800 Jenishkumar Maheshbhai Patel wrote:
> Register value persisted after booting the kernel using kexec which=20
> resulted in kernel panic. Thus cleared the BM pool registers before=20
> initialisation to fix the issue.

s/persisted/persist/
s/resulted/results/
s/cleared/clear/

When you post v2 please add a Fixes tag -- it may be the first commit that =
added this driver if the issue has always been there.

I will make corrections and post it in v2.

