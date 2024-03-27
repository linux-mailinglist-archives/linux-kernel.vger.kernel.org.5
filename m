Return-Path: <linux-kernel+bounces-121400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CF388E774
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545271F28D55
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325A814265F;
	Wed, 27 Mar 2024 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Kk+APwg/"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9D12D20C;
	Wed, 27 Mar 2024 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711548287; cv=fail; b=AzTPJiuoes+0tP2ynj2I17BNoPuz1r+sKD1NJwO72DnpNSZ322Vm2CftNwWQwWzWc/+MJepCBqyv6+C7D65LcncmuArHhr3xUp4geIczeaANJqlC1R/GGHY2sr/2MAmH8rzwSVN3jhovraskUj+jVj0fmJiFWWhXnhixEhkmFv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711548287; c=relaxed/simple;
	bh=duJksOyRTqdJm6FA0B5USLp1cU/CCSByJsecgjn0Xv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eg+cI1b9ql5/on7idOJjmL1ee4s6Lm4okUEN4UxPDfYGAa937a3mHFevIy+x90WBxa7kAzIVLM6QnnR7Eo6mYkoyWdt+qGT20HvnJamP3WZ3rdida99zaUMtkioM6Nfhv+uLvuW8lQcUiTMOXppCKBgZDg5o7/KQgjhe1vE+OBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Kk+APwg/; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42RALehI002352;
	Wed, 27 Mar 2024 07:04:13 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x4hmp8ukp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 07:04:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwCY0edAwQT9+tAqjbJXe7RGZfij1GzczZlPZVb/Wxltc9rlR02ZXcBQxEQHJyJmlhjJ5fU4j8ZvDWh4ZL6a9GP6Am1Z7gkHUtpQ+Agpdiyvd8Xov05fZehvritLOYRgi9tsTvL8bn6bz4/ZG8A4u8az9vos/fB5ARatvNXzAiay2rllnifiY79kl1J9F8x1viyqHvB41aGN9IzHbJkDP7ZSc7iUfgKkltDFsmAEKusvxhs/aDxMrGlzNv9AdF13QK6f/WvAnbRSZ3DM/N5+YZqVne4iFnEl+voGgb/+rAZKM3qbpew7/3HrA8N7RQIVy0DobZ7fnqsPLLAEQbQ8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFSFN1N/MMszTc5y48CDPmsHG3aljCPkM9AWrdbS098=;
 b=RAFomy6hb7uBnHv33IInhSR1wTM8oF1LTKF60S+daWLJY1s8lCA3rArlQz7PwcHa8OcePGb77JmPQAhGEaqmiFx7I9mKMCNvz8D9U9OJEublldSaUfqozeDNmO90F5TNj5NukknWTA5vqU/KiT2kY+yBxf9/yRZ4eqXvqFC65z77ujnbbh95+ZI1OHiHvo8BwasCVHqG7vo9OhbVAG+x7o/SqAXH71hO6byDdwvP7VOJzsC4OogVmOuZ5HHXVo0whKNJHY+1XLDqr2DucbpqRCzWXn5PqSP4uX/2bdLob85m9AuLGF+BRlXjN8Z/XOrJhLgDxOu2smuRkvhjnSLhaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFSFN1N/MMszTc5y48CDPmsHG3aljCPkM9AWrdbS098=;
 b=Kk+APwg/tCDWkStJgyocartU2GLciNe6Q2aCQOIFXtzvTBzSbUcPjhpflPNlS843E0Gd3LAF6vywmlhfiVUlV8htALquQWpR/ZmcKQ+CLoIQHUwB4+EgQFjsnmTOaqoD0Yruywbkkmqsg8gpJhxdmQ2hffwFx30yVHAVyC/45Ig=
Received: from CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24)
 by DM8PR18MB4405.namprd18.prod.outlook.com (2603:10b6:8:3d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 14:04:08 +0000
Received: from CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5087:a566:c473:1fef]) by CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5087:a566:c473:1fef%7]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 14:04:08 +0000
From: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
To: Arnd Bergmann <arnd@kernel.org>,
        "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>,
        Ariel Elior <aelior@marvell.com>, Manish Chopra
	<manishc@marvell.com>
CC: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick
 Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, Simon Horman <horms@kernel.org>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Sudarsana Reddy Kalluru
	<sudarsana.kalluru@cavium.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 3/9] qed: avoid truncating work queue length
Thread-Topic: [EXTERNAL] [PATCH 3/9] qed: avoid truncating work queue length
Thread-Index: AQHagCfC+qakUE/9NUWNrCxJqKFS87FLnkwQ
Date: Wed, 27 Mar 2024 14:04:08 +0000
Message-ID: 
 <CO1PR18MB4666DF3B7684D340C3A3646DA1342@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <20240326223825.4084412-1-arnd@kernel.org>
 <20240326223825.4084412-4-arnd@kernel.org>
In-Reply-To: <20240326223825.4084412-4-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4666:EE_|DM8PR18MB4405:EE_
x-ms-office365-filtering-correlation-id: 26483821-bf97-44d2-a348-08dc4e66c58f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 tmXKRPEvdAG7LExZGrG0N/D0iRrs2FSXbtqa59tQtxoV5jxMvOCMZvFQzRNEpGTzaM6u8nu40DHUG0wHZZRNVnu4SmP6RYaeWzxIyt8GoltZWEtgdKMxZnf59oHNmHbXuKQzzEO8iPrr9OM06YQ/YjjkpkV5airc6DP5vFJX6spy33TO2dhXCrncz0ASYE5AIFszD+7o2io5PYvDKOK09Yj+PTzRg3Fqis/UC3ppP3AbzvgXLXem8yE1nGYQkCmnLOFZHH6XG35mjsvIOrXNH9dAfdaeZRGoQxnjXMZnbfEi7F9Offq6BkRBETNP9PYEPtQfm2uHwCLCGxsp5DHbCHILMHDo7fbZed7OdABXiQY3DWgb1pSByxVYaXvapxI/ibT25CAUvtCAZq7l9GYTN1+2v9I9/GEoTNRl1KBPRxkd8u1dT5MpIO2hcqIXQWZnvSzqNyurAiRIC8QVXlS5P7KoIY0MMgIDnXZHXhbI5rtsXPTWV4MfZ07xYn9+xvHjOiQ8ssMjKi2b+bRVAcnfrx0XikVIrWXxxr2yosIGkBwx8SXsGVv7tj2+DygaDFveKsQbc6/u8ch5SgHuEJhRf8bFWERKuwo0/7wrBHZ/27vzck9mc37H5AW8B1d/3dQ/KLIHR1XrgJwDcUWjU9r0vUyWSjpE4hDU/TBNHYUxj3VqGizgOt/e5ha//XTJ1wWJFSqZ7HpJlk3dSVNaC51nPNdXWnvQsJ/rr9OLXGLfaFY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4666.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?i0fYQOqlFzAJCI2T6999OiIEFbs6aKK0zobenp/Y3BNe6b9nS1PvXsiDlXdW?=
 =?us-ascii?Q?k6O7NAnFqXOPDvNh0ZXg5b9B/HqUuaiG+ICvIfA2+1fqDG7eHIivyHIKpW4M?=
 =?us-ascii?Q?HoIjwEoWJlbf+f73nzGSe3x62gNGUfA/eF2/NQ6WtKYVJs5jWlDA9gamx/ew?=
 =?us-ascii?Q?18RN0jQADxYWLvtK26B99qrfX4hZhvN8CcFmoVEGiDgOakOfjVNYFv5Oes83?=
 =?us-ascii?Q?bf3zk/+DNV9OqoqFKGadQzkPIZ0BOsyKec+JTN9VryXzH7SUagbMhtY4oF1O?=
 =?us-ascii?Q?dI/z6DTgwvkkUvIpaj+aYFfR7Fd+oTim2/jq78dSei2KXk5NoBRuEqSbHNxZ?=
 =?us-ascii?Q?t6VIQ4pdvsaXdD+NALCzKFtOfr2zm4xI5GkObuQx7P6/ZiA+qdOE27lNLJXI?=
 =?us-ascii?Q?XOUbcdLFb0U8h7lAowLW7FKJJlTw0e+rSw0e+ExJsc0ciiOoo+RPqlOq/XMP?=
 =?us-ascii?Q?P1/ROnrrxJcKzxJizwQOZVwIeFPApRWQblpL2WmqR1NMCnA4IIxZiDMWkyiS?=
 =?us-ascii?Q?OhECy0B0BHvVSpkMHjpQy4u/I4lxDOshT5kJRZ6D54c0X3vDXvtKWY34IVk/?=
 =?us-ascii?Q?/dkuC0CJWB3bvBzGVMebqCipi/r5tOiNvUFk6Nay1DY3WT90hgHlqLB0TZQd?=
 =?us-ascii?Q?PCLQeerCrw8TQRBTMoWZszjWNWg7VEj+iIUX3xFffLKsyR4RWJEa7jMrwsAa?=
 =?us-ascii?Q?IIEnwYANUm9xSyc6dbr4Kx/DZn3LsWRl+775EZmQwncL9ZzQKXg3UzMZHQ6w?=
 =?us-ascii?Q?p+ypq9Bj/OX+RlnSIRT8kcjUsG31F5S/jQjjjDp9cj23suy/R6H1pKfh/IJN?=
 =?us-ascii?Q?fmAIL//XBCK4u13NxQoKoPty2Fb39Ju5W/RgzSkf+QxIUtR7ButfsEJnN+10?=
 =?us-ascii?Q?mqFNDrEJ5s0S6kzm0DrSoiZHL7U/t4UQJIIO1vUMLsX2Ko0q+2s7WnDd8AAI?=
 =?us-ascii?Q?xrPjx8yBxcrVkp87pgiXUikg5vMFLfjzLAiXwkzYT/oH7bF1dZnzutogY/Uu?=
 =?us-ascii?Q?ZfGTzsIw+/7dIHk5JfDbmUnHSFfvO28/8nzjFu1gN+cH37QWuCGhMmlQJHQR?=
 =?us-ascii?Q?3yXugrUWXYRmrgUC3YXMjzwBzFy8e+/6dB7XWKU+tegPsCynWBw6b8Cepuh8?=
 =?us-ascii?Q?2jPV8O4Ubju1f8bO6SoCkWOcxV8R44Iyo1/1s4bAx5IFNFpid3rSKpZ5wavs?=
 =?us-ascii?Q?kuvSuDbhBE0yQTmKzbKs19mN+VinPxaNIwNdFx9rA2tOBMAWBX2q3Ygphew+?=
 =?us-ascii?Q?j73PGuHFfEy4NKExZmMU0bykMhtOlIc9//6MLBMeN7kW6jgnzYj68wk5QVQv?=
 =?us-ascii?Q?ZxuKxACV40EIc7Ep7oZd9NozKivff8ycPS6MzEaSz2H7S9gAl8geHhjijSCE?=
 =?us-ascii?Q?GvE+fhTe2wJedUYMW3Sa05hWTWfZRQjWgJ7ZR+fuSxLf9Bzo9WX76Geug6Rg?=
 =?us-ascii?Q?xDvJb/EGVtXPkemSwQ3L61ZLL1DZ7awEdBe3CQfKZoW87LRA4E9+uLntynRI?=
 =?us-ascii?Q?+CZwEbBEezTxZu2aEIRPdUVIr5ab6LbbZmQwWbt6hM0RLb/ZvOABiNXMK7ei?=
 =?us-ascii?Q?+Rf2GnQi2EsezR3wOAFsWI96p0crGXrDiBzheKkO?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4666.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26483821-bf97-44d2-a348-08dc4e66c58f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 14:04:08.7499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yNVxVMz2udKX3VWn9TeEnT6fv404dwBsv3ZWCvDNVHOAeRhzNMI3zQaUodicATWr6oslrZLj8ZjvvLMqTrxGQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4405
X-Proofpoint-ORIG-GUID: CbGQTm4YubvupUOoGgPWobDcKzulcOkm
X-Proofpoint-GUID: CbGQTm4YubvupUOoGgPWobDcKzulcOkm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_08,2024-03-27_01,2023-05-22_02

Hi,

>-----Original Message-----
>From: Arnd Bergmann <arnd@kernel.org>
>Sent: Wednesday, March 27, 2024 4:08 AM
>To: llvm@lists.linux.dev; Ariel Elior <aelior@marvell.com>; Manish Chopra
><manishc@marvell.com>
>Cc: Arnd Bergmann <arnd@arndb.de>; David S. Miller <davem@davemloft.net>;
>Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paol=
o
>Abeni <pabeni@redhat.com>; Nathan Chancellor <nathan@kernel.org>; Nick
>Desaulniers <ndesaulniers@google.com>; Bill Wendling <morbo@google.com>;
>Justin Stitt <justinstitt@google.com>; Simon Horman <horms@kernel.org>;
>Konstantin Khorenko <khorenko@virtuozzo.com>; Sudarsana Reddy Kalluru
><sudarsana.kalluru@cavium.com>; netdev@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Subject: [PATCH 3/9] qed: avoid truncating work queue length
>
>From: Arnd Bergmann <arnd@arndb.de>
>
>clang complains that the temporary string for the name passed into
>alloc_workqueue() is too short for its contents:
>
>drivers/net/ethernet/qlogic/qed/qed_main.c:1218:3: error: 'snprintf' will =
always
>be truncated; specified size is 16, but format string expands to at least =
18 [-
>Werror,-Wformat-truncation]
>
>There is no need for a temporary buffer, and the actual name of a workqueu=
e=09
>is 32 bytes (WQ_NAME_LEN), so just use the interface as intended to avoid
>the truncation.
>
>Fixes: 59ccf86fe69a ("qed: Add driver infrastucture for handling mfw reque=
sts.")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>---
> drivers/net/ethernet/qlogic/qed/qed_main.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c
>b/drivers/net/ethernet/qlogic/qed/qed_main.c
>index c278f8893042..8159b4c315b5 100644
>--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
>+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
>@@ -1206,7 +1206,6 @@ static void qed_slowpath_task(struct work_struct
>*work)
> static int qed_slowpath_wq_start(struct qed_dev *cdev)
> {
> 	struct qed_hwfn *hwfn;
>-	char name[NAME_SIZE];
> 	int i;
>
> 	if (IS_VF(cdev))
>@@ -1215,11 +1214,11 @@ static int qed_slowpath_wq_start(struct qed_dev
>*cdev)
> 	for_each_hwfn(cdev, i) {
> 		hwfn =3D &cdev->hwfns[i];
>
>-		snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
>-			 cdev->pdev->bus->number,
>-			 PCI_SLOT(cdev->pdev->devfn), hwfn->abs_pf_id);
>+		hwfn->slowpath_wq =3D alloc_workqueue("slowpath-
>%02x:%02x.%02x",
>+					 0, 0, cdev->pdev->bus->number,
>+					 PCI_SLOT(cdev->pdev->devfn),
>+					 hwfn->abs_pf_id);

Confused. This should be alloc_workqueue("slowpath-%02x:%02x.%02x",  cdev->=
pdev->bus->number, PCI_SLOT(cdev->pdev->devfn), hwfn->abs_pf_id, 0, 0);
Right?

Thanks,
Sundeep
>
>-		hwfn->slowpath_wq =3D alloc_workqueue(name, 0, 0);
> 		if (!hwfn->slowpath_wq) {
> 			DP_NOTICE(hwfn, "Cannot create slowpath
>workqueue\n");
> 			return -ENOMEM;
>--
>2.39.2
>


