Return-Path: <linux-kernel+bounces-156594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF538B0549
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7651C23A01
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB29158DC6;
	Wed, 24 Apr 2024 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="UvwPowPP"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C481D158D7F;
	Wed, 24 Apr 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949480; cv=fail; b=QeNafAAObPav5Zse1XO94yUCjJkvERwGUUW1/jaTGcN0eFZcQ68wyZs07nLKZ1mHDUtTrLbAq2jCtt+jtMJOCvi2rMul9m5G1MJGLOnpGMPkzj/hWiKxshzNpAj7Z/j5iVQpQ5L+G0HxV2bFON5LxRUC2qgPD38+E/q5YJteU+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949480; c=relaxed/simple;
	bh=OjVKo1eHTy0ktO9BdyvrCaxhYDqVIX8HQxf3NcGmMLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cYgnAMj6jJYmAW1zukiRX9EFLtIkZlxwg7WZ2WCPE2pAbvGfAivPZHNU7A4fssJLeKC1nncyLK13U6O+9aVQbvtCEMHw0XQAXGVrPFoQe9RSmheCbNiaoYXeXv+6cMNlKnxq+YfA21X+AmKINFHyNM8dr4KSKLtW76ZxH+Ca7bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=UvwPowPP; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O0lEFQ019475;
	Wed, 24 Apr 2024 02:04:24 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xpgpgu66j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 02:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwsModg8tElNZLigtymwABQIWlYrBLdv5JTJEAiN/88aT5+F8g/v/jWe+HoAKE5BsBpm5V0rGMfw9/djBQsz4T7g7/QagkKDMa8XzQsI1BrnPVbCJgsKaoDA8ITW3J04muZeQNcm+3+6ExWi6asEWhIIkwnOjZWbzAS/bK+OozFlI2uizEqjtHUt/wtvZUJmetIJyLxbkvYpKzneYqtUWHGbcj0nQnvvhv4jcAr2yFUxF6xrpmpqfgECTEwW6un6DzanqpUKlbT1RUw95gCSujxV4m3nci8pUk1hOHHs1qZVaG+wWuKrZXPTF5pyVAxgHLjYYmbs884UaL8dqUAWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZVsehhAFnepasVj6dBc6TYmw7NiFpXLT8iu/uqZmkM=;
 b=L+xUwrRRsvoBR5dKWXk6hPOKZF1oHmLH/6hIRxGEX4xHjanRKuPVRgDw0mth0Tv5GmyBsA3gGhDI93iyDmJIVgL0NM2cx0TpuH5tRdE8YPJ29WLEUwszRKnhe/VTc8RT3GqYI0+QbYaQM3+t7x+f9k306pv+RIHrPupTXSTtJjWOMGhe11GtS6S5Eu/Zyq2PTuWhScWSBHgS/tKUq74dXWUXNW+RG3nqwn8LaK21O1yUroBCnq1HpBS+TZupDsW0lphL1oCTzLAKL0hlaGHcGTsT3c73YQIYpqRsiojRhoy3fu5waIovSJnrpV80sPc/QfcVYsp+x/kblmMC60j9GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZVsehhAFnepasVj6dBc6TYmw7NiFpXLT8iu/uqZmkM=;
 b=UvwPowPPWJ0fJlKqzC8WPFAkIz4FMP5tmg3eSdHjnf92SOmBRF8SrJe/JeJ6GvC0H7SJtfCkPu8OzOkBXNu5cBawM5aL7CYbsI1tDL78If07OFL7atYr8bSGu48UhzPTHURzD6bCZgpOq9sCvFlAQQUYWZLBMxt1zfbxbXFLZj4=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by SN4PR18MB4840.namprd18.prod.outlook.com (2603:10b6:806:21f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 09:04:21 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916%5]) with mapi id 15.20.7452.049; Wed, 24 Apr 2024
 09:04:21 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Hayes Wang <hayeswang@realtek.com>, "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
Subject: [PATCH net-next] r8152: replace dev_info with dev_dbg for loading
 firmware
Thread-Topic: [PATCH net-next] r8152: replace dev_info with dev_dbg for
 loading firmware
Thread-Index: AQHaliZl1cms0fPnZ0yLRIDtVcUivw==
Date: Wed, 24 Apr 2024 09:04:21 +0000
Message-ID: 
 <PH0PR18MB447451E4C0CECE275218336CDE102@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240424084532.159649-1-hayeswang@realtek.com>
In-Reply-To: <20240424084532.159649-1-hayeswang@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|SN4PR18MB4840:EE_
x-ms-office365-filtering-correlation-id: 98437201-c9b7-4aad-dbb4-08dc643d8811
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?K1uzWGK0LtregRwiXqzdrXnm6Vb87CD7PlmejOoWn4UA+/XhsqDJkMYIryyh?=
 =?us-ascii?Q?5QzU6UT5TM8CLHBKjJC01vuaMsyKXN2IGh9gUB4MBwvSwC6oyGXoduHRzwLt?=
 =?us-ascii?Q?qiY6xgI+f59upxBQD5MZox/m6ABOBDleYhraoVwk8BsWc0CKypRGDDsDNjYh?=
 =?us-ascii?Q?ZHuALzsbExR/4V5K8KRTjTrVtB+0Dc0pddnZGxkYbM2KcqoVUrz7IYBBs/RI?=
 =?us-ascii?Q?KsVt0ExBPujiP/Ky5tJLUFqaE+zyXnXzGg68qPcGwIMZSdIkZFEp21cGOXqV?=
 =?us-ascii?Q?e54cG4nf5D2lD4fAXt0Eiu1EmCRYnNNjbbuGcEcmb1LuhNh9xM1nrrvGSrgr?=
 =?us-ascii?Q?GWbUbs7JlHRk42m3chswgAL8yysKdgz7oBJREDhbpMvm8AGU00w4MPfN9QC8?=
 =?us-ascii?Q?Dg9/yJmPN0N5PH3CwZUQ1+gQWhNqSlXqTL9G2kc29FCIIcrEJz2dU+h+5JF1?=
 =?us-ascii?Q?10x86b1WAnpcf0zKdiOQ9tn8gzZ0266PXQCnbrGZBjR3OAd5+C8EQNumwr9V?=
 =?us-ascii?Q?cOTTIOcwTjzJFcmqCdy8Th3obr0cqCDLyQKKwDQpkJvSwdxkiSjLzU83fTEi?=
 =?us-ascii?Q?Je93aTjrTlH6pIa5POOo8uI5EGAzuK05fXZh4WJPgvl6N/2SEQLMb6Bo4ftX?=
 =?us-ascii?Q?JCntpjPkaPwVLZ7FB0Nd1lGboXRlzEwEOGiW7GZv1vfkWcuDUjDcpZe04Awk?=
 =?us-ascii?Q?7AeTudbQ2TfXiHzowlpixTlrGRqyqowWSMQmohxgMGIvh/fH0oBIiVu+sh8J?=
 =?us-ascii?Q?ti7CW5x8f0nkpsX9jCgxT+mE5lxnvnrkoLHSs9/UvOGdLYo2ey1qMG4Zr07W?=
 =?us-ascii?Q?5jHdkwp+qjhGRP9+0/9eyZnQwpw0RDcJva7cDB6rwt2+JKukAFbaY4d8TzQc?=
 =?us-ascii?Q?WFnpVzLW2KTNi89DEYt2YgSa6Xe3yF/OHyVLKufc54a6s6NE/mX83QEGXbkf?=
 =?us-ascii?Q?lt4VFpYfuL2OdCRmfnxHaW2urUsxRf2ppor4K5Z9Hv/NeqCzp7pv0slDJcy4?=
 =?us-ascii?Q?96M7Qlpkqtusc8vPlzrpCziYtJGzJiU3COZEVVe9tVp/t5NjfuNAwtzotWCW?=
 =?us-ascii?Q?5pjsVehXXazkt0uc3914m6vFt608ctOJRVxx04MEsWKlgBEkmYDE+cS7FckZ?=
 =?us-ascii?Q?eXgeHgu3rMl9hn/bJPjJo3f5TAR3yGigqVq/R79Uq2hug3nixOOpxBer2Zv1?=
 =?us-ascii?Q?4rclEBY+C6XpN7H9z8bPomsa0k2pRwTwbm5xKUH1uncSA9A7cvIOzfjCgMqO?=
 =?us-ascii?Q?IfxfdSCLm3kl+/mug/4AfiOeYXAtFXDX0tQNtaS1h2SUkCh8W5GikKyMhhyF?=
 =?us-ascii?Q?etW8hdGuteSAwvnn9vyEy4kxAW6N5nj48ELWhMzKa1ykVQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?/p/ZCG0b68zbSafxw+eYS0xELa6PQ0jkwkP1jGXasKikdL2tMJbBF/uF7lLe?=
 =?us-ascii?Q?yL5bges+DTQXmZTZyoyWXLmc0iHndEYzscw5XtgN/RjnqQT+cFCp8xQMm3il?=
 =?us-ascii?Q?Bs4f/NYXy1ICsO3MAid7UqIWW6ItZy4bNtC/jK7Od+jVyM09DMWYNQrJq+Yt?=
 =?us-ascii?Q?UsvElFT9/OpQR6AlQhm0K0iLRYhp5+Z/QHEuMBHXsEBeC7T0UkpwfBGHheAl?=
 =?us-ascii?Q?Ol1yqD5k7IIC0YAZVu6eD0vBrqnotzr7pvCSS97F7rzrrvezPexQQXAuhboY?=
 =?us-ascii?Q?/U+nYxlGJTEGvMnk3+KLa2DKiPEWQVOnGN5vmHYb0KfMtRDPZFsdcIptQxQC?=
 =?us-ascii?Q?ej8qt53CT1JXr38UMM9qkcIrIapHQJRTBox82ZXUAMXUovTVvBmfJKvTuMt6?=
 =?us-ascii?Q?lj6r6vZwNk6GOZeWGr0oWeX6HQ0k4Too17lSVO9UsRuTMiK2fxS3BBinhOOp?=
 =?us-ascii?Q?xK19encz0uRNYX7BiHChIC9m9twYcpR1R1ZAKuX+klwfAJgS76GTUJGSFQeA?=
 =?us-ascii?Q?8AQENysOs7T5nF6R9LOrZOufVIvhhUxG9z1PfZ4QXrulvHkSH/AVW3CDMa4E?=
 =?us-ascii?Q?NncCrXP4ZqAmil5i+01ZQxAKvJlvN+wwFwbmj6g4SRwD206UGQFQFcgoqZ7t?=
 =?us-ascii?Q?VPeq+x0SKzIrHWkeHJmunapTD9NYWfRdue67/55pOY3TiADSbhevJnquqAjR?=
 =?us-ascii?Q?mKUNSmAXi8IRPG6CI88s9WqfMMjEgauY3srmLoue5ecpCpNMF1Sfin0muHaj?=
 =?us-ascii?Q?PPhuttkRnNddIDmd89v4VZIKIMUludyXGgCHX1BvJ+DzzMuZsv3cDlZLU3Y5?=
 =?us-ascii?Q?+ltyWMBVu9Omp2pWFcKr9qWH4P88TmuNriCeYKld6cYoUr6/LGzhfvoSKmcc?=
 =?us-ascii?Q?S267sKpdOb32VHVObcqD0SY8X15bqYu5MVOqhks3KqwPKFdlGdrBkqv738Vx?=
 =?us-ascii?Q?N11bCwyUcwg9kT1bd8P75vPewhyXpVuZTs/Rx8QAZld2Djjsrfn5S/0UrtCq?=
 =?us-ascii?Q?z7fL3z257KCO9flmHz8IJm4hmcmJ4qJiv0j0XgdM00GX3hfzfZ+ZERiE7ami?=
 =?us-ascii?Q?NtNFOhCgxOD7QaSFci2YurF07Djwi/B6xpGuipgukneOvk2o7/vSIibpqvAK?=
 =?us-ascii?Q?xMjgxWjpSw9oWzi8JFV1TTESI2ONwRpiHSrCVejGwVEbxySbG+BQmTvpxnhm?=
 =?us-ascii?Q?JHpd282zOGPHtaZzFCm4t8XEFLx7oQSlKGFE9S28RZmA68lln/Q2XV9k5C1F?=
 =?us-ascii?Q?HsOlBWKurFRP0Py+v00RPkl9QKjLq3yT5vJtruLpZzO9X1Tdn06IOBiw3PII?=
 =?us-ascii?Q?yW8TRuRzWKqbn5PMkyg68ZMDLRYpDFYgbSUk17QRKfEfSz6IaHEGFx6lE8bL?=
 =?us-ascii?Q?BnIOe97XE78F4DVGvCXPZij1RsiZL6NORtp3qNxv/T/hC+aXyHtfbXCC2Zon?=
 =?us-ascii?Q?R4iev2ejS9VBd8Llx2MO0CWqmzWuXX9TlmYTVBfK4bJ3kYQfK27iN4pwWFYt?=
 =?us-ascii?Q?9EgPGGM4IJet3rML78oQtPJM8yYRR6MQp8FzIxP98r63hMZgCW5P6jD3w18r?=
 =?us-ascii?Q?TTPQBuzEisMawAH4e9Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98437201-c9b7-4aad-dbb4-08dc643d8811
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 09:04:21.8082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4+yl7aQGSZJe21zATGt5mfmZjzgeZkluWHt+cuqI79EHYODO8pdRfNf/nqDOy1dsLq2knmQ82LAUH7PomVKbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR18MB4840
X-Proofpoint-GUID: o5CSDZNjTWb9L7ZXWEEUP86Uu9gJYhJR
X-Proofpoint-ORIG-GUID: o5CSDZNjTWb9L7ZXWEEUP86Uu9gJYhJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_06,2024-04-23_02,2023-05-22_02



> Someone complains the message appears continuously. This occurs because
> the device is woken from UPS mode, and the driver re-loads the firmware.
>=20
> When the device enters runtime suspend and cable is unplugged, the device
> would enter UPS mode. If the runtime resume occurs, and the device is
> woken from UPS mode, the driver has to re-load the firmware and causes th=
e
> message. If someone wakes the device continuously, the message would be
> shown continuously, too. Use dev_dbg to avoid it.
>=20
> Note that, the function could be called before register_netdev(), so I do=
n't use
> netif_info() or netif_dbg().
>=20
> Signed-off-by: Hayes Wang <hayeswang@realtek.com>
> ---
>  drivers/net/usb/r8152.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c index
> 5d6aeb086fc7..51e9f5b2dccf 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -5274,7 +5274,7 @@ static void rtl8152_apply_firmware(struct r8152 *tp=
,
> bool power_cut)
>=20
>  	rtl_reset_ocp_base(tp);
>  	strscpy(rtl_fw->version, fw_hdr->version, RTL_VER_SIZE);
> -	dev_info(&tp->intf->dev, "load %s successfully\n", rtl_fw->version);
> +	dev_dbg(&tp->intf->dev, "load %s successfully\n", rtl_fw->version);
Since enabling dev_dbg involves re-compiling kernel if CONFIG_DYNAMIC_DEBUG=
 not enabled,
 Does it make sense to use  "dev_info_ratelimited" here.

Thanks,
Hariprasad k
>  }
>=20
>  static void rtl8152_release_firmware(struct r8152 *tp)
> --
> 2.44.0
>=20


