Return-Path: <linux-kernel+bounces-155470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 206ED8AEAF5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23C21F232BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF8E13C694;
	Tue, 23 Apr 2024 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ja2yq1jH"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5C97F499;
	Tue, 23 Apr 2024 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885857; cv=fail; b=u3rK+HgH5+HGtpk8KI30n25qSSVfhG3al3shIBvP3sF7oeGuTZoKwPiVYz1dPkjf9IW35p0w+YQnQxcakyKb8BKdDoNihZiNjGNRIj4ZXENbCaOFnzkPJ4D+4rRUgXk2b24zAekJuFbJbnrW20mS0pwv6ffhEC9NzDtPIGqOORY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885857; c=relaxed/simple;
	bh=8TcDKY7K8Mfiq1PJmxacbbwN9CG/mCV0szsxsIeCF6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gD48O1hlZ8RU3YiP3Oi16RlvhpAx1SekNXpN5KKDf1hFtJRzW/VloJtrpvkfsKBRNkMI7EeGQNsb9ztDNaAtsO+G8LZsvDINnmJc06OY8kZHH0bNeEALRbig/s//SyWJPWsFQ2nqvv4wxOt9eE+gHNEQ3/ayl3rI50M9XUM266g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ja2yq1jH; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N5bmdm016941;
	Tue, 23 Apr 2024 08:23:54 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xmd7ghkqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 08:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1W8PqfHQ8X6GtswrT76gA4EGM/FUtVw4QjsxymQXLcO0qjSxRJi7NQe7decFzvDFLrOHhsp2qDQQC7A/dGcWZPRtJFpcFyzSQKRO5TDzvpdDoJJkTTJqLYDG6iwc5f7jKSe4JkgGU3T2oQzXSfpwJstgKbsXC7TKg739XBJNMbdYBEUOnMnJEvi2UEUMIX2YQeFpaIbtaQoauK4Vn1QJ+BY2ZdNYdj8H+eL+grHBqrU4IDVmjBGV9OYbE/rh2ViEtIZBMs3pBa2LvHdzeiJkNKRd7wLnpS5hwPlzOZtv0+yT0s0BwcazW3WsUnC57k3/k3F5IRDkt5QO37OxUkKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Zr+6zs+lVZ4wV3+Fx8Sr/Cd7VeGq5c3svsfrRiWnJI=;
 b=kbYkr6QK4wIOyiiakh6onNkcwCtRTlrByhiyjQKWr9NCBhTjqVeQ5Y0H0GxR0n2ezAUL9Bl5gcBmHho9fnKFocoTxqBADvK1kY+sqXw+OcyGGVxrrkodwx3phpgJ4pAqVa85Y66X3Jynd5vZiIghBEA0NB5P2iYn5rhDQ9iArStVKkF70ANf/x2xAR3lRnrKvJm4QehZtiRmHDDABEHPxg58nChO57Vd39YVCUu7rulzeVq+KAtwywubV/XbbStBrVNjIvih5OWSMY4Wg5QkIAwtL88QDLim7Jb+4PiGrWfoPSCop2YO5byj/GxowTH9tzTaKpiUod7hiOvWwMWLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Zr+6zs+lVZ4wV3+Fx8Sr/Cd7VeGq5c3svsfrRiWnJI=;
 b=Ja2yq1jHknVC8XTHdbc5UnwaI6UlGQu0LST00b5k+kJRhpXGyUg2Kr9yBRP8Umt87tujwHyhepyJi/+U6XcnSYDRqVnPAxiT+Jkpq65z712pPbEjTgTVQG8QlPuLgH8R/bJw6k5S80ORmg2lDUSTLx4GFldz2iGfSbObG4L0DQU=
Received: from BL1PR18MB4342.namprd18.prod.outlook.com (2603:10b6:208:31e::16)
 by MN2PR18MB3770.namprd18.prod.outlook.com (2603:10b6:208:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 15:23:51 +0000
Received: from BL1PR18MB4342.namprd18.prod.outlook.com
 ([fe80::9e3c:b30b:67cf:1d16]) by BL1PR18MB4342.namprd18.prod.outlook.com
 ([fe80::9e3c:b30b:67cf:1d16%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 15:23:51 +0000
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
Subject: RE: [EXTERNAL] Re: [net-next PATCH v2 2/9] octeontx2-pf: RVU
 representor driver
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v2 2/9] octeontx2-pf: RVU
 representor driver
Thread-Index: AQHalJsLI8blgzN1skyhkoWUGf+mIbF0g3+AgAF15gA=
Date: Tue, 23 Apr 2024 15:23:51 +0000
Message-ID: 
 <BL1PR18MB43425CC9FB0530CB37EAEC06CD112@BL1PR18MB4342.namprd18.prod.outlook.com>
References: <20240422095401.14245-1-gakula@marvell.com>
 <20240422095401.14245-3-gakula@marvell.com> <ZiaXTZYVXd8Ud-n5@nanopsycho>
In-Reply-To: <ZiaXTZYVXd8Ud-n5@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR18MB4342:EE_|MN2PR18MB3770:EE_
x-ms-office365-filtering-correlation-id: e8c088ff-d90e-4b1e-24c0-08dc63a96140
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?g0REcfOK3AZDEWwgLwlFAOTFznl+feCRgJlNic0H8pNnBpUL5sjaF0yr0oJW?=
 =?us-ascii?Q?4Vozvs15wL+vyOhwcpc5hhbCgs5aSPWtFLaVY1mT5+PYFyAX/k/hWKHT1HHU?=
 =?us-ascii?Q?UWK3Q22X1Sbqipi3g9BOM5YQ59g1wGL7IsNSznNfZMdqE6u+5K3HbJTbvx0C?=
 =?us-ascii?Q?iekRP/RpWUytcGooBmHmGUIHqhEaGwFkjko7OYudO10WB0R9k+z0I7d9sBSx?=
 =?us-ascii?Q?Lur6feCdtC+GpSvCg63p8HAotSwyyY+y5eHoeWqD1KGS0jdsi7gtjxV63JXL?=
 =?us-ascii?Q?F6hLX37fNcGfD6UY4uk886QYAgqrOEYsuVZa69LhU7h74nDwzjEJB6XKfg3p?=
 =?us-ascii?Q?mUcGJvwyX6MapQIjit85zaLz36DdXoPWP+PwAxlNpvVzOPQiAqzcfSF1+Klq?=
 =?us-ascii?Q?2FoZ8rZ09mYvU/EarlbC2C/5AgyLxptlxTSmo3lmZvZNv45aLb++p9R7vtg5?=
 =?us-ascii?Q?mzWj2hF/2Ynl7fdCYoLuPsS+hyOJF3xJ3CYKprLjDhtsJS3IcZmARgAYj/iU?=
 =?us-ascii?Q?HBAj5sbIZYaNsK12NKHjxwJDQrJGo2S7u6danpV671XBYU44sm9uF4f9Xlgd?=
 =?us-ascii?Q?2nA9LWiFFZx/6mV/ZC+34+NWxByoLYzxkg6vLDoBBeDvmrICtr7n8ME5vwfx?=
 =?us-ascii?Q?orzIyPasCER8Qkt7JP++8A1R5E/UjIufrlnd9MDgXxjz1T+N3b0zzJZRioub?=
 =?us-ascii?Q?5HAfCWjEolyiFHTcVzTP9Vp5cJdjr1TWTyWgqjQCNoa0ILk8NIi3lPmmShQM?=
 =?us-ascii?Q?ru0Qr6gUj2lDMbub/EeRkLbpe4bxak3Sj+DcHfMlIeu/MD+Zgzo9dFnNbUVt?=
 =?us-ascii?Q?CIGvwWVn7maOoP/EO/MA/bcuNEwpQAMPnjAwV2Ndtk82SzaUtLoDaOmIv2lO?=
 =?us-ascii?Q?dYA9rnRGP8ZLcQd+lsaPG2dxCMTnEJd5oQ/rwHRX47vROGUqLWFLQIZTLH1l?=
 =?us-ascii?Q?Wqq/gCV+DfhyPnqWKcD0NAOOeUXgPzisCZV4Rva56oom5BmuHOqf1d6kNK5Z?=
 =?us-ascii?Q?qDVS7/KgXlFOCjD4czmNn/f81ClHr9U2tJfLnEy6Y1DB7ktv6YeK7vFnTM+Y?=
 =?us-ascii?Q?W9BNeR6jWp8oebyKZSmRBwjEEVcZmKiyRYN++W4KNKmQ+LU5noCnBPKfhpty?=
 =?us-ascii?Q?DhXSDb3GrQTUKbPQEOKnjdT0M+yxIuaQE1VLxIlpOjSKK/n0XEOmPNgPmQLi?=
 =?us-ascii?Q?SVXuSkL1LtKBM7fiKCUw3Sf0YejXdxOK6IG8sL18114SbfcN/+CylDLri0LX?=
 =?us-ascii?Q?JgC8MRYIJyuWdcSUdd78Z1Td95eS7UCEUw8MlEGx6D8InznawZOW3megh358?=
 =?us-ascii?Q?SlD1OnTzLxLYUNN0XkabyeT7AaT85Ot2GXm3qfCJdM1Fqg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR18MB4342.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?8Jlwi0NWFWz7mA7MZzKoQYeJjWktsVX6AhqrRUU6HuBEE00ft80UlBUwNI0N?=
 =?us-ascii?Q?jI++1k6A0THwZGZkuI7TajyCwPAZmzF+LRXq2Yzs7LaSluhuW14OfpMOTofB?=
 =?us-ascii?Q?TFLYZsedDzWYC7HeT8SZaqyfAsNTLPAK9KMWxRDwgLexXoRsPGqIscRjgR2V?=
 =?us-ascii?Q?cNlTCnwM7D++1RS4Xb4AX8iF7S/xLIbMB3z4PVkPGKlA3s+ezmBTT7p527Nz?=
 =?us-ascii?Q?bU1jmWtSc9aGlDPZB0lK0PmbZTRcxRC4o1nWM/VBBbM51ZQgcSU8ew5D/2PY?=
 =?us-ascii?Q?4aJng3DnZ32jeJ4s86hf+jyB0Yrx+gGbq1X47PslbOWBJE6gNoLCsltDFZiO?=
 =?us-ascii?Q?SQfhHC52aQMjC6D2g64ejYAfmXrga9/PhAIyzAQ0fjxFKD+czLV4XGUlbAhJ?=
 =?us-ascii?Q?VXWyc35+l4H21DL8TUpixZNIk57b7TuGY8WHU0IRIuYqBmr2oPtbgOYjqL4y?=
 =?us-ascii?Q?kx/oWjt7efF/VbUsrTCiYx2D3ia0gVoxd5d43oilpI5wDtuFZulL/aAocqk7?=
 =?us-ascii?Q?MWnPtJvQfD6xPA4f6OjN06Z8KSyntSsS/uzveAXys+6cbS0Gsg43Nqngq88z?=
 =?us-ascii?Q?BAvOUey9SCDMQI4NNZ+uJOoi4CQp9R1iOESqEA30z1oTlQkUfDHrIFf/8rQO?=
 =?us-ascii?Q?9e/RApyfXLTOubwaeP9LZumIL/HKar6UY08wO4kg7qni9ULyRTYV+8JLz61A?=
 =?us-ascii?Q?eGM3imvbGiPQT0EU2OqnujXMFqniI1BOb8PyLzUNEfWbVze3CCNctfcWNujm?=
 =?us-ascii?Q?pc5VvQ34BmYBpp546A4UmvNXFhFZtKM7ljF8t4zYMmL40TikeerVcV9ZQcl1?=
 =?us-ascii?Q?jV5lXARoTDSbHAqeDO88FSV2GWZxa7MnbyzMLzwrXvTWxvM5BEpgAeVAZGk1?=
 =?us-ascii?Q?LRCDRkVfU9F+EKFbHh6rqTcx+2CrdHQCMJCWnIHwjiwVS8ZYDBIs1aGnCLvM?=
 =?us-ascii?Q?Xu+oHF78gfLWMh0ZfR42EJAHF7PzgSBvfqiIT/pzwPJsYJS4wtNQL6zwEifb?=
 =?us-ascii?Q?crYIaABzn3Wz/+quVDvIbGvuoNjVXd0unQ5X/GS9WP7vnkg7ttOVJvMzegr1?=
 =?us-ascii?Q?1Lj0/sCS3cz2zQBShYJQAM0P9odlhtRkHMhAWaplh1aDObaMjrJMCjGQP7jh?=
 =?us-ascii?Q?Fa0GUXnza8FfiyEBIy/vnhbiq7vwyXL7NukuVXO0x9q9CrZUeh/scyMX518B?=
 =?us-ascii?Q?CVT8W8luW/SiPSAWzfep8rjGRkBL5/TAk7JV+RQ4ZfsZ5WC1kKe3PoOTSyge?=
 =?us-ascii?Q?RUO1A7XZlJqcRAmI5s5+MpIhXRP6PGKIupn2UUqGvGW8cbBEfrc0dEHJVdo3?=
 =?us-ascii?Q?EoFu93zIvQ1OSFCwdsL5ZsHF2vcCFjR9JRoT47RqYNiJZhxlCQrKJjeU45RZ?=
 =?us-ascii?Q?3GVqAjaqIAyqAv+hK5TxxJg5qQUkADttNcaxQ3B4UMhpDkl28Sif2BeBxEbK?=
 =?us-ascii?Q?G8c/P40Grmxmhh6vLTlZ+xU3yGUpb+Gg2GVNSa4V7De4DY06xjGtIrOI+qeb?=
 =?us-ascii?Q?cyteW+dTQAkQo3Wz19yztTwAGWFnXsFffpjAW6On7poABLl0iB2RANpvJTjI?=
 =?us-ascii?Q?wcPnK+3l547qc78CbrU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c088ff-d90e-4b1e-24c0-08dc63a96140
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 15:23:51.1799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a0YhaMZogwlRc+VbptvIytCYVXFA4OF6HMPYJropYN4VYHWhdHW08A5CH7TKl20ciPnsUPQr8NWELCvt4aWGpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3770
X-Proofpoint-ORIG-GUID: It7Q-eWsHTZqEpsRE35_T0tWRNUSQ345
X-Proofpoint-GUID: It7Q-eWsHTZqEpsRE35_T0tWRNUSQ345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_02,2023-05-22_02



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Monday, April 22, 2024 10:29 PM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org=
;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: [EXTERNAL] Re: [net-next PATCH v2 2/9] octeontx2-pf: RVU
> representor driver
> ----------------------------------------------------------------------
> Mon, Apr 22, 2024 at 11:53:54AM CEST, gakula@marvell.com wrote:
> >This patch adds basic driver for the RVU representor.
> >Driver on probe does pci specific initialization and does hw resources
> >configuration.
> >Introduces RVU_ESWITCH kernel config to enable/disable this driver.
> >Representor and NIC shares the code but represenotrs
>=20
> s/represenotrs/representor/
>=20
Ack.
>=20
> >netdev support subset of NIC functionality. Hence "is_rep_dev"
> >api helps to skip the features initialization that are not supported by
> >the representors.
> >
> >Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> >---
> > .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
> > .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
> > .../net/ethernet/marvell/octeontx2/af/mbox.h  |   8 +
> > .../net/ethernet/marvell/octeontx2/af/rvu.h   |  11 +
> > .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  19 +-
> > .../ethernet/marvell/octeontx2/af/rvu_rep.c   |  48 ++++
> > .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
> > .../marvell/octeontx2/nic/otx2_common.h       |  12 +-
> > .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  17 +-
> > .../marvell/octeontx2/nic/otx2_txrx.c         |  21 +-
> > .../net/ethernet/marvell/octeontx2/nic/rep.c  | 222 ++++++++++++++++++
> >.../net/ethernet/marvell/octeontx2/nic/rep.h  |  32 +++
> > 12 files changed, 386 insertions(+), 17 deletions(-)  create mode
> >100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> > create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> > create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> >
> >diff --git a/drivers/net/ethernet/marvell/octeontx2/Kconfig
> >b/drivers/net/ethernet/marvell/octeontx2/Kconfig
> >index a32d85d6f599..72f57d6f8a87 100644
> >--- a/drivers/net/ethernet/marvell/octeontx2/Kconfig
> >+++ b/drivers/net/ethernet/marvell/octeontx2/Kconfig
> >@@ -46,3 +46,11 @@ config OCTEONTX2_VF
> > 	depends on OCTEONTX2_PF
> > 	help
> > 	  This driver supports Marvell's OcteonTX2 NIC virtual function.
> >+
> >+config RVU_ESWITCH
> >+	tristate "Marvell RVU E-Switch support"
> >+	depends on OCTEONTX2_PF && NET_SWITCHDEV
>=20
> Why do you depend on NET_SWITCHDEV? Do you implement bridge offload?
>=20
In current patch doesn't implement it. Will remove the dependency.
>=20
> >+	default m
> >+	help
> >+	  This driver supports Marvell's RVU E-Switch that
> >+	  provides internal SRIOV packet steering and switching for the
> >diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
> >b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
> >index 3cf4c8285c90..ccea37847df8 100644
> >--- a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
> >+++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
> >@@ -11,4 +11,5 @@ rvu_mbox-y :=3D mbox.o rvu_trace.o  rvu_af-y :=3D cgx.=
o
> >rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o \
> > 		  rvu_reg.o rvu_npc.o rvu_debugfs.o ptp.o rvu_npc_fs.o \
> > 		  rvu_cpt.o rvu_devlink.o rpm.o rvu_cn10k.o rvu_switch.o \
> >-		  rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o
> mcs_cnf10kb.o
> >+		  rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o
> mcs_cnf10kb.o \
> >+		  rvu_rep.o
> >diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> >b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> >index 10efbd56abd1..c77c02730cf9 100644
> >--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> >+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> >@@ -143,6 +143,7 @@ M(LMTST_TBL_SETUP,	0x00a, lmtst_tbl_setup,
> lmtst_tbl_setup_req,    \
> > 				msg_rsp)				\
> > M(SET_VF_PERM,		0x00b, set_vf_perm, set_vf_perm, msg_rsp)
> 	\
> > M(PTP_GET_CAP,		0x00c, ptp_get_cap, msg_req,
> ptp_get_cap_rsp)	\
> >+M(GET_REP_CNT,		0x00d, get_rep_cnt, msg_req,
> get_rep_cnt_rsp)	\
> > /* CGX mbox IDs (range 0x200 - 0x3FF) */				\
> > M(CGX_START_RXTX,	0x200, cgx_start_rxtx, msg_req, msg_rsp)	\
> > M(CGX_STOP_RXTX,	0x201, cgx_stop_rxtx, msg_req, msg_rsp)
> 	\
> >@@ -1524,6 +1525,13 @@ struct ptp_get_cap_rsp {
> > 	u64 cap;
> > };
> >
> >+struct get_rep_cnt_rsp {
> >+	struct mbox_msghdr hdr;
> >+	u16 rep_cnt;
> >+	u16 rep_pf_map[64];
> >+	u64 rsvd;
> >+};
> >+
> > struct flow_msg {
> > 	unsigned char dmac[6];
> > 	unsigned char smac[6];
> >diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> >b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> >index e7ff2f1b021f..1d76d52d7a5d 100644
> >--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> >+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> >@@ -593,6 +593,9 @@ struct rvu {
> > 	spinlock_t		cpt_intr_lock;
> >
> > 	struct mutex		mbox_lock; /* Serialize mbox up and down
> msgs */
> >+	u16			rep_pcifunc;
> >+	int			rep_cnt;
> >+	u16			*rep2pfvf_map;
> > };
> >
> > static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset,
> >u64 val) @@ -821,6 +824,14 @@ bool is_sdp_pfvf(u16 pcifunc);  bool
> >is_sdp_pf(u16 pcifunc);  bool is_sdp_vf(struct rvu *rvu, u16 pcifunc);
> >
> >+static inline bool is_rep_dev(struct rvu *rvu, u16 pcifunc) {
> >+	if (rvu->rep_pcifunc && rvu->rep_pcifunc =3D=3D pcifunc)
> >+		return true;
> >+
> >+	return false;
> >+}
> >+
> > /* CGX APIs */
> > static inline bool is_pf_cgxmapped(struct rvu *rvu, u8 pf)  { diff
> >--git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> >b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> >index fd565edf9aa4..988c0920d6ca 100644
> >--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> >+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> >@@ -329,7 +329,8 @@ static bool is_valid_txschq(struct rvu *rvu, int
> >blkaddr,
> >
> > 	/* TLs aggegating traffic are shared across PF and VFs */
> > 	if (lvl >=3D hw->cap.nix_tx_aggr_lvl) {
> >-		if (rvu_get_pf(map_func) !=3D rvu_get_pf(pcifunc))
> >+		if ((nix_get_tx_link(rvu, map_func) !=3D nix_get_tx_link(rvu,
> pcifunc)) &&
> >+		    (rvu_get_pf(map_func) !=3D rvu_get_pf(pcifunc)))
> > 			return false;
> > 		else
> > 			return true;
> >@@ -1634,6 +1635,12 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu
> *rvu,
> > 	cfg =3D NPC_TX_DEF_PKIND;
> > 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
> >
> >+	if (is_rep_dev(rvu, pcifunc)) {
> >+		pfvf->tx_chan_base =3D RVU_SWITCH_LBK_CHAN;
> >+		pfvf->tx_chan_cnt =3D 1;
> >+		goto exit;
> >+	}
> >+
> > 	intf =3D is_lbk_vf(rvu, pcifunc) ? NIX_INTF_TYPE_LBK :
> NIX_INTF_TYPE_CGX;
> > 	if (is_sdp_pfvf(pcifunc))
> > 		intf =3D NIX_INTF_TYPE_SDP;
> >@@ -1704,6 +1711,9 @@ int rvu_mbox_handler_nix_lf_free(struct rvu *rvu,
> struct nix_lf_free_req *req,
> > 	if (nixlf < 0)
> > 		return NIX_AF_ERR_AF_LF_INVALID;
> >
> >+	if (is_rep_dev(rvu, pcifunc))
> >+		goto free_lf;
> >+
> > 	if (req->flags & NIX_LF_DISABLE_FLOWS)
> > 		rvu_npc_disable_mcam_entries(rvu, pcifunc, nixlf);
> > 	else
> >@@ -1715,6 +1725,7 @@ int rvu_mbox_handler_nix_lf_free(struct rvu *rvu,
> >struct nix_lf_free_req *req,
> >
> > 	nix_interface_deinit(rvu, pcifunc, nixlf);
> >
> >+free_lf:
> > 	/* Reset this NIX LF */
> > 	err =3D rvu_lf_reset(rvu, block, nixlf);
> > 	if (err) {
> >@@ -2010,7 +2021,7 @@ static void nix_get_txschq_range(struct rvu *rvu,
> u16 pcifunc,
> > 	struct rvu_hwinfo *hw =3D rvu->hw;
> > 	int pf =3D rvu_get_pf(pcifunc);
> >
> >-	if (is_lbk_vf(rvu, pcifunc)) { /* LBK links */
> >+	if (is_lbk_vf(rvu, pcifunc) || is_rep_dev(rvu, pcifunc)) { /* LBK
> >+links */
> > 		*start =3D hw->cap.nix_txsch_per_cgx_lmac * link;
> > 		*end =3D *start + hw->cap.nix_txsch_per_lbk_lmac;
> > 	} else if (is_pf_cgxmapped(rvu, pf)) { /* CGX links */ @@ -4522,7
> >+4533,7 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct
> nix_frs_cfg *req,
> > 	if (!nix_hw)
> > 		return NIX_AF_ERR_INVALID_NIXBLK;
> >
> >-	if (is_lbk_vf(rvu, pcifunc))
> >+	if (is_lbk_vf(rvu, pcifunc) || is_rep_dev(rvu, pcifunc))
> > 		rvu_get_lbk_link_max_frs(rvu, &max_mtu);
> > 	else
> > 		rvu_get_lmac_link_max_frs(rvu, &max_mtu); @@ -4550,6
> +4561,8 @@ int
> >rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req=
,
> > 		/* For VFs of PF0 ingress is LBK port, so config LBK link */
> > 		pfvf =3D rvu_get_pfvf(rvu, pcifunc);
> > 		link =3D hw->cgx_links + pfvf->lbkid;
> >+	} else if (is_rep_dev(rvu, pcifunc)) {
> >+		link =3D hw->cgx_links + 0;
> > 	}
> >
> > 	if (link < 0)
> >diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> >b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> >new file mode 100644
> >index 000000000000..d07cb356d3d6
> >--- /dev/null
> >+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> >@@ -0,0 +1,48 @@
> >+// SPDX-License-Identifier: GPL-2.0
> >+/* Marvell RVU Admin Function driver
> >+ *
> >+ * Copyright (C) 2024 Marvell.
> >+ *
> >+ */
> >+
> >+#include <linux/types.h>
> >+#include <linux/device.h>
> >+#include <linux/module.h>
> >+#include <linux/pci.h>
> >+
> >+#include "rvu.h"
> >+#include "rvu_reg.h"
> >+
> >+int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
> >+				 struct get_rep_cnt_rsp *rsp)
> >+{
> >+	int pf, vf, numvfs, hwvf, rep =3D 0;
> >+	u16 pcifunc;
> >+
> >+	rvu->rep_pcifunc =3D req->hdr.pcifunc;
> >+	rsp->rep_cnt =3D rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
> >+	rvu->rep_cnt =3D rsp->rep_cnt;
> >+
> >+	rvu->rep2pfvf_map =3D devm_kzalloc(rvu->dev, rvu->rep_cnt *
> >+					 sizeof(u16), GFP_KERNEL);
> >+	if (!rvu->rep2pfvf_map)
> >+		return -ENOMEM;
> >+
> >+	for (pf =3D 0; pf < rvu->hw->total_pfs; pf++) {
> >+		if (!is_pf_cgxmapped(rvu, pf))
> >+			continue;
> >+		pcifunc =3D pf << RVU_PFVF_PF_SHIFT;
> >+		rvu->rep2pfvf_map[rep] =3D pcifunc;
> >+		rsp->rep_pf_map[rep] =3D pcifunc;
> >+		rep++;
> >+		rvu_get_pf_numvfs(rvu, pf, &numvfs, &hwvf);
> >+		for (vf =3D 0; vf < numvfs; vf++) {
> >+			rvu->rep2pfvf_map[rep] =3D pcifunc |
> >+				((vf + 1) & RVU_PFVF_FUNC_MASK);
> >+			rsp->rep_pf_map[rep] =3D rvu->rep2pfvf_map[rep];
> >+			rep++;
> >+		}
> >+	}
> >+	return 0;
> >+}
> >+
> >diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
> >b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
> >index 5664f768cb0c..69ee78dc8aad 100644
> >--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
> >+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
> >@@ -5,11 +5,13 @@
> >
> > obj-$(CONFIG_OCTEONTX2_PF) +=3D rvu_nicpf.o otx2_ptp.o
> > obj-$(CONFIG_OCTEONTX2_VF) +=3D rvu_nicvf.o otx2_ptp.o
> >+obj-$(CONFIG_RVU_ESWITCH) +=3D rvu_rep.o
> >
> > rvu_nicpf-y :=3D otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
> >                otx2_flows.o otx2_tc.o cn10k.o otx2_dmac_flt.o \
> >                otx2_devlink.o qos_sq.o qos.o rvu_nicvf-y :=3D otx2_vf.o
> > otx2_devlink.o
> >+rvu_rep-y :=3D rep.o
> >
> > rvu_nicpf-$(CONFIG_DCB) +=3D otx2_dcbnl.o
> > rvu_nicvf-$(CONFIG_DCB) +=3D otx2_dcbnl.o diff --git
> >a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> >b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> >index e6d7b2487ed1..79ec86035c16 100644
> >--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> >+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> >@@ -29,6 +29,7 @@
> > #include "otx2_devlink.h"
> > #include <rvu_trace.h>
> > #include "qos.h"
> >+#include "rep.h"
> >
> > /* IPv4 flag more fragment bit */
> > #define IPV4_FLAG_MORE				0x20
> >@@ -439,6 +440,7 @@ struct otx2_nic {
> > #define OTX2_FLAG_DMACFLTR_SUPPORT		BIT_ULL(14)
> > #define OTX2_FLAG_PTP_ONESTEP_SYNC		BIT_ULL(15)
> > #define OTX2_FLAG_ADPTV_INT_COAL_ENABLED BIT_ULL(16)
> >+#define OTX2_FLAG_REP_MODE_ENABLED		 BIT_ULL(17)
> > 	u64			flags;
> > 	u64			*cq_op_addr;
> >
> >@@ -506,11 +508,19 @@ struct otx2_nic {  #if
> IS_ENABLED(CONFIG_MACSEC)
> > 	struct cn10k_mcs_cfg	*macsec_cfg;
> > #endif
> >+
> >+#if IS_ENABLED(CONFIG_RVU_ESWITCH)
> >+	struct rep_dev		**reps;
> >+	int			rep_cnt;
> >+	u16			rep_pf_map[RVU_MAX_REP];
> >+	u16			esw_mode;
> >+#endif
> > };
> >
> > static inline bool is_otx2_lbkvf(struct pci_dev *pdev)  {
> >-	return pdev->device =3D=3D PCI_DEVID_OCTEONTX2_RVU_AFVF;
> >+	return (pdev->device =3D=3D PCI_DEVID_OCTEONTX2_RVU_AFVF) ||
> >+		(pdev->device =3D=3D PCI_DEVID_RVU_REP);
> > }
> >
> > static inline bool is_96xx_A0(struct pci_dev *pdev) diff --git
> >a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> >b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> >index 88886ea864cc..119c99768a85 100644
> >--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> >+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> >@@ -1502,10 +1502,11 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
> > 	hw->sqpool_cnt =3D otx2_get_total_tx_queues(pf);
> > 	hw->pool_cnt =3D hw->rqpool_cnt + hw->sqpool_cnt;
> >
> >-	/* Maximum hardware supported transmit length */
> >-	pf->tx_max_pktlen =3D pf->netdev->max_mtu + OTX2_ETH_HLEN;
> >-
> >-	pf->rbsize =3D otx2_get_rbuf_size(pf, pf->netdev->mtu);
> >+	if (!is_rep_dev(pf->pdev)) {
> >+		/* Maximum hardware supported transmit length */
> >+		pf->tx_max_pktlen =3D pf->netdev->max_mtu +
> OTX2_ETH_HLEN;
> >+		pf->rbsize =3D otx2_get_rbuf_size(pf, pf->netdev->mtu);
> >+	}
> >
> > 	mutex_lock(&mbox->lock);
> > 	/* NPA init */
> >@@ -1634,11 +1635,12 @@ void otx2_free_hw_resources(struct otx2_nic
> *pf)
> > 		otx2_pfc_txschq_stop(pf);
> > #endif
> >
> >-	otx2_clean_qos_queues(pf);
> >+	if (!is_rep_dev(pf->pdev))
> >+		otx2_clean_qos_queues(pf);
> >
> > 	mutex_lock(&mbox->lock);
> > 	/* Disable backpressure */
> >-	if (!(pf->pcifunc & RVU_PFVF_FUNC_MASK))
> >+	if (!is_otx2_lbkvf(pf->pdev))
> > 		otx2_nix_config_bp(pf, false);
> > 	mutex_unlock(&mbox->lock);
> >
> >@@ -1670,7 +1672,8 @@ void otx2_free_hw_resources(struct otx2_nic *pf)
> > 	otx2_free_cq_res(pf);
> >
> > 	/* Free all ingress bandwidth profiles allocated */
> >-	cn10k_free_all_ipolicers(pf);
> >+	if (!is_rep_dev(pf->pdev))
> >+		cn10k_free_all_ipolicers(pf);
> >
> > 	mutex_lock(&mbox->lock);
> > 	/* Reset NIX LF */
> >diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> >b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> >index 8223780fc269..498a7867a5f4 100644
> >--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> >+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> >@@ -375,11 +375,13 @@ static void otx2_rcv_pkt_handler(struct otx2_nic
> *pfvf,
> > 		}
> > 		start +=3D sizeof(*sg);
> > 	}
> >-	otx2_set_rxhash(pfvf, cqe, skb);
> >
> >-	skb_record_rx_queue(skb, cq->cq_idx);
> >-	if (pfvf->netdev->features & NETIF_F_RXCSUM)
> >-		skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> >+	if (!(pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)) {
> >+		otx2_set_rxhash(pfvf, cqe, skb);
> >+		skb_record_rx_queue(skb, cq->cq_idx);
> >+		if (pfvf->netdev->features & NETIF_F_RXCSUM)
> >+			skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> >+	}
> >
> > 	skb_mark_for_recycle(skb);
> >
> >@@ -463,7 +465,13 @@ static int otx2_tx_napi_handler(struct otx2_nic
> >*pfvf,
> > process_cqe:
> > 	qidx =3D cq->cq_idx - pfvf->hw.rx_queues;
> > 	sq =3D &pfvf->qset.sq[qidx];
> >-	ndev =3D pfvf->netdev;
> >+
> >+#if IS_ENABLED(CONFIG_RVU_ESWITCH)
> >+	if (pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)
> >+		ndev =3D pfvf->reps[qidx]->netdev;
> >+	else
> >+#endif
> >+		ndev =3D pfvf->netdev;
> >
> > 	while (likely(processed_cqe < budget) && cq->pend_cqe) {
> > 		cqe =3D (struct nix_cqe_tx_s *)otx2_get_next_cqe(cq); @@ -
> 500,6 +508,9
> >@@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
> >
> > 		if (qidx >=3D pfvf->hw.tx_queues)
> > 			qidx -=3D pfvf->hw.xdp_queues;
> >+
> >+		if (pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)
> >+			qidx =3D 0;
> > 		txq =3D netdev_get_tx_queue(pfvf->netdev, qidx);
> > 		netdev_tx_completed_queue(txq, tx_pkts, tx_bytes);
> > 		/* Check if queue was stopped earlier due to ring full */ diff --
> git
> >a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> >b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> >new file mode 100644
> >index 000000000000..0e19b938d197
> >--- /dev/null
> >+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> >@@ -0,0 +1,222 @@
> >+// SPDX-License-Identifier: GPL-2.0
> >+/* Marvell RVU representor driver
> >+ *
> >+ * Copyright (C) 2024 Marvell.
> >+ *
> >+ */
> >+
> >+#include <linux/etherdevice.h>
> >+#include <linux/module.h>
> >+#include <linux/pci.h>
> >+#include <linux/net_tstamp.h>
> >+
> >+#include "otx2_common.h"
> >+#include "cn10k.h"
> >+#include "otx2_reg.h"
> >+#include "rep.h"
> >+
> >+#define DRV_NAME	"rvu_rep"
> >+#define DRV_STRING	"Marvell RVU Representor Driver"
> >+
> >+static const struct pci_device_id rvu_rep_id_table[] =3D {
> >+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_RVU_REP) },
>=20
> Interesting. So you have a seperate PCI PF for representors? How is the u=
plink
> port represented, is it a separate PCI PF?
In our hardware everything is a pci device.
>=20
>=20
> >+	{ }
> >+};
> >+
> >+MODULE_AUTHOR("Marvell International Ltd.");
> >+MODULE_DESCRIPTION(DRV_STRING); MODULE_LICENSE("GPL");
> >+MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
> >+
> >+static int rvu_rep_rsrc_free(struct otx2_nic *priv) {
> >+	struct otx2_qset *qset =3D &priv->qset;
> >+	int wrk;
> >+
> >+	for (wrk =3D 0; wrk < priv->qset.cq_cnt; wrk++)
> >+		cancel_delayed_work_sync(&priv-
> >refill_wrk[wrk].pool_refill_work);
> >+	devm_kfree(priv->dev, priv->refill_wrk);
> >+
> >+	otx2_free_hw_resources(priv);
> >+	otx2_free_queue_mem(qset);
> >+	return 0;
> >+}
> >+
> >+static int rvu_rep_rsrc_init(struct otx2_nic *priv) {
> >+	struct otx2_qset *qset =3D &priv->qset;
> >+	int err =3D 0;
> >+
> >+	err =3D otx2_alloc_queue_mem(priv);
> >+	if (err)
> >+		return err;
> >+
> >+	priv->hw.max_mtu =3D otx2_get_max_mtu(priv);
> >+	priv->tx_max_pktlen =3D priv->hw.max_mtu + OTX2_ETH_HLEN;
> >+	priv->rbsize =3D ALIGN(priv->hw.rbuf_len, OTX2_ALIGN) +
> OTX2_HEAD_ROOM;
> >+
> >+	err =3D otx2_init_hw_resources(priv);
> >+	if (err)
> >+		goto err_free_rsrc;
> >+
> >+	/* Set maximum frame size allowed in HW */
> >+	err =3D otx2_hw_set_mtu(priv, priv->hw.max_mtu);
> >+	if (err) {
> >+		dev_err(priv->dev, "Failed to set HW MTU\n");
> >+		goto err_free_rsrc;
> >+	}
> >+	return 0;
> >+
> >+err_free_rsrc:
> >+	otx2_free_hw_resources(priv);
> >+	otx2_free_queue_mem(qset);
> >+	return err;
> >+}
> >+
> >+static int rvu_get_rep_cnt(struct otx2_nic *priv) {
> >+	struct get_rep_cnt_rsp *rsp;
> >+	struct mbox_msghdr *msghdr;
> >+	struct msg_req *req;
> >+	int err, rep;
> >+
> >+	mutex_lock(&priv->mbox.lock);
> >+	req =3D otx2_mbox_alloc_msg_get_rep_cnt(&priv->mbox);
> >+	if (!req) {
> >+		mutex_unlock(&priv->mbox.lock);
> >+		return -ENOMEM;
> >+	}
> >+	err =3D otx2_sync_mbox_msg(&priv->mbox);
> >+	if (err)
> >+		goto exit;
> >+
> >+	msghdr =3D otx2_mbox_get_rsp(&priv->mbox.mbox, 0, &req->hdr);
> >+	if (IS_ERR(msghdr)) {
> >+		err =3D PTR_ERR(msghdr);
> >+		goto exit;
> >+	}
> >+
> >+	rsp =3D (struct get_rep_cnt_rsp *)msghdr;
> >+	priv->hw.tx_queues =3D rsp->rep_cnt;
> >+	priv->hw.rx_queues =3D rsp->rep_cnt;
> >+	priv->rep_cnt =3D rsp->rep_cnt;
> >+	for (rep =3D 0; rep < priv->rep_cnt; rep++)
> >+		priv->rep_pf_map[rep] =3D rsp->rep_pf_map[rep];
> >+
> >+exit:
> >+	mutex_unlock(&priv->mbox.lock);
> >+	return err;
> >+}
> >+
> >+static int rvu_rep_probe(struct pci_dev *pdev, const struct
> >+pci_device_id *id) {
> >+	struct device *dev =3D &pdev->dev;
> >+	struct otx2_nic *priv;
> >+	struct otx2_hw *hw;
> >+	int err;
> >+
> >+	err =3D pcim_enable_device(pdev);
> >+	if (err) {
> >+		dev_err(dev, "Failed to enable PCI device\n");
> >+		return err;
> >+	}
> >+
> >+	err =3D pci_request_regions(pdev, DRV_NAME);
> >+	if (err) {
> >+		dev_err(dev, "PCI request regions failed 0x%x\n", err);
> >+		return err;
> >+	}
> >+
> >+	err =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
> >+	if (err) {
> >+		dev_err(dev, "DMA mask config failed, abort\n");
> >+		goto err_release_regions;
> >+	}
> >+
> >+	pci_set_master(pdev);
> >+
> >+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >+	if (!priv)
> >+		goto err_release_regions;
> >+
> >+	pci_set_drvdata(pdev, priv);
> >+	priv->pdev =3D pdev;
> >+	priv->dev =3D dev;
> >+	priv->flags |=3D OTX2_FLAG_INTF_DOWN;
> >+	priv->flags |=3D OTX2_FLAG_REP_MODE_ENABLED;
> >+
> >+	hw =3D &priv->hw;
> >+	hw->pdev =3D pdev;
> >+	hw->max_queues =3D OTX2_MAX_CQ_CNT;
> >+	hw->rbuf_len =3D OTX2_DEFAULT_RBUF_LEN;
> >+	hw->xqe_size =3D 128;
> >+
> >+	err =3D otx2_init_rsrc(pdev, priv);
> >+	if (err)
> >+		goto err_release_regions;
> >+
> >+	err =3D rvu_get_rep_cnt(priv);
> >+	if (err)
> >+		goto err_detach_rsrc;
> >+
> >+	err =3D rvu_rep_rsrc_init(priv);
> >+	if (err)
> >+		goto err_detach_rsrc;
> >+
> >+	return 0;
> >+
> >+err_detach_rsrc:
> >+	if (priv->hw.lmt_info)
> >+		free_percpu(priv->hw.lmt_info);
> >+	if (test_bit(CN10K_LMTST, &priv->hw.cap_flag))
> >+		qmem_free(priv->dev, priv->dync_lmt);
> >+	otx2_detach_resources(&priv->mbox);
> >+	otx2_disable_mbox_intr(priv);
> >+	otx2_pfaf_mbox_destroy(priv);
> >+	pci_free_irq_vectors(pdev);
> >+err_release_regions:
> >+	pci_set_drvdata(pdev, NULL);
> >+	pci_release_regions(pdev);
> >+	return err;
> >+}
> >+
> >+static void rvu_rep_remove(struct pci_dev *pdev) {
> >+	struct otx2_nic *priv =3D pci_get_drvdata(pdev);
> >+
> >+	rvu_rep_rsrc_free(priv);
> >+	otx2_detach_resources(&priv->mbox);
> >+	if (priv->hw.lmt_info)
> >+		free_percpu(priv->hw.lmt_info);
> >+	if (test_bit(CN10K_LMTST, &priv->hw.cap_flag))
> >+		qmem_free(priv->dev, priv->dync_lmt);
> >+	otx2_disable_mbox_intr(priv);
> >+	otx2_pfaf_mbox_destroy(priv);
> >+	pci_free_irq_vectors(priv->pdev);
> >+	pci_set_drvdata(pdev, NULL);
> >+	pci_release_regions(pdev);
> >+}
> >+
> >+static struct pci_driver rvu_rep_driver =3D {
> >+	.name =3D DRV_NAME,
> >+	.id_table =3D rvu_rep_id_table,
> >+	.probe =3D rvu_rep_probe,
> >+	.remove =3D rvu_rep_remove,
> >+	.shutdown =3D rvu_rep_remove,
> >+};
> >+
> >+static int __init rvu_rep_init_module(void) {
> >+	pr_info("%s: %s\n", DRV_NAME, DRV_STRING);
>=20
> Please avoid pointless dmesg output like this one.
>=20
>=20
> >+
> >+	return pci_register_driver(&rvu_rep_driver);
> >+}
> >+
> >+static void __exit rvu_rep_cleanup_module(void) {
> >+	pci_unregister_driver(&rvu_rep_driver);
> >+}
> >+
> >+module_init(rvu_rep_init_module);
> >+module_exit(rvu_rep_cleanup_module);
> >+
> >diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> >b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> >new file mode 100644
> >index 000000000000..30cce17eb48b
> >--- /dev/null
> >+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> >@@ -0,0 +1,32 @@
> >+/* SPDX-License-Identifier: GPL-2.0 */
> >+/* Marvell RVU REPRESENTOR driver
> >+ *
> >+ * Copyright (C) 2024 Marvell.
> >+ *
> >+ */
> >+
> >+#ifndef REP_H
> >+#define REP_H
> >+
> >+#include <linux/pci.h>
> >+
> >+#include "otx2_reg.h"
> >+#include "otx2_txrx.h"
> >+#include "otx2_common.h"
> >+
> >+#define PCI_DEVID_RVU_REP	0xA0E0
> >+
> >+#define RVU_MAX_REP	OTX2_MAX_CQ_CNT
> >+struct rep_dev {
> >+	struct otx2_nic *mdev;
> >+	struct net_device *netdev;
> >+	u16 rep_id;
> >+	u16 pcifunc;
> >+};
> >+
> >+static inline bool is_rep_dev(struct pci_dev *pdev)
>=20
> It is good habit to prefix the structs and functions in you driver by one=
 prefix
> string, like "otx2_" or something.
Ack.

Thanks for reviewing. Will address the comments in next version.
>=20
>=20
>=20
> >+{
> >+	return pdev->device =3D=3D PCI_DEVID_RVU_REP; }
> >+
> >+#endif /* REP_H */
> >--
> >2.25.1
> >
> >

