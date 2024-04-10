Return-Path: <linux-kernel+bounces-137911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F029189E968
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F218282DC0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A6112E73;
	Wed, 10 Apr 2024 05:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lPZaNSDw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nhOPiYSp"
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2831F10A3E;
	Wed, 10 Apr 2024 05:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712725461; cv=fail; b=jl/dX8m3n1KDHmnKZEAHrZ27YFPD4Lw4sBfNT+EzZ3SSYddKbXQl9LPXENgtctAnjo9dcYESfuXvM9w983wFv51cfaXptmktfuM4naG9N3KK9gCpGEdAoRR/aIVHB99XEiGWmWbF5phGy2ngUYRqlYtNCigIBrmW54d/irPyDUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712725461; c=relaxed/simple;
	bh=ocszDJN4Z+Y1tmo2oXCuffBrtgJ71KTsDAsaEUHOHy0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i6HxIZy5q5IrLu95cDSv10YXbCqeeCDT+nNbOLeyp8wY1Un+bvz83JjteEoxMnrtk2ncxoE9Yk4Hd2uvS3z/WAO8/FMRv3ZUx2czaiaVlKPdwvpmsTbsP14M+9e0asY5ov4Ti9L66ylwiMSGy8W5sC8BSZvRoH+rlZeIXufRmLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lPZaNSDw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nhOPiYSp; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712725459; x=1744261459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ocszDJN4Z+Y1tmo2oXCuffBrtgJ71KTsDAsaEUHOHy0=;
  b=lPZaNSDwuNCf4Ka8vt7iJX0IQa7YLTtYdS0gJiBANGO81TSPMRG+V5dl
   46dijUt4BVZdfLE0opmPZroBzA9nRdBL7TJiPFfb4nYN1si82xJ/f0qhJ
   LhM4aYotZDxTibpVDN7ZpVVW97TzXAHh9E6w/MAdf+x9QZRXwE/IvdMC0
   18merxUTWz3ierzX+GKq18thUxZx7sbocL7KIjDJ6xU8Hx7vfgUQn8ccc
   Lj+/rPwrwC4lgH5acbbctMJzIpmW0A09dvSarcxdERgHOvSRGYqo3sw0B
   Ljh20at/Psaffz93+ABdWvrZNNMVvhWFFKIsnvWedvi6rkYGCfSD0dwTu
   w==;
X-CSE-ConnectionGUID: TK6DG4sLRlC4Bn2iQlUSFA==
X-CSE-MsgGUID: JL5jn0PbSPmvO+1BqzptUg==
X-IronPort-AV: E=Sophos;i="6.07,190,1708358400"; 
   d="scan'208";a="13124618"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2024 13:04:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h52R8pGy0NTfuPEIX+Pj55X9R56S16K0ZuX5cR7xH8HosPKVYYnImKtBTnfoFZeAWuHFGEkgRpmVIIHEZeTtjIihGMtcGiU9OyHBeEdQLRRvpJObc4n2BByiTICSO5JVWCKp0a+q43VniASEQ1t7uZAh7LuyJeu5sOmLL5yzGv1l4ralYaIgiQbwgXvAhcT9tDARdjEWvurihgb61jBXv3OZ51F4PB3cSEu1gYidghMHJkrWIhJxuzfsCmFXle7CnmCX5NIIXWdngw0cEylaenarhfgQ4v3nvX3lDYDdCHpl4J8BSldOso6MVtE4MbTxuAeeGRD+9NzOTiVxffMHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wh7k7aKicQo52F25igkjG4t2Ga3zDK4dcWPr3ghLXh8=;
 b=Zsl3t3MCLPQi4r4TMO+iaH18fLx2pAH0F7vE3xM15ZlIVWoWfirVkTEaQpZspehZS6EhXKLZ/WmeMG1uE1RaHJpoA3iHftPxOJmblz05IxAjHW7FwGx0wnBHrTTUAaMUkdaofVgDu4jJDezNgdqQfDw70aH97KlOsfGI036aJQOBdt85EciZpUGympnJ6sd2pEzGfCSsb9o06/0ZvOveaskHIoSm61EeWUmFZknLCX7dzkTmIaB1zTrvGukTSMZO4j0J8JAvRbno4Ea+WFSbVCMNpPbSIZgPzDeo63VV/0e7Dqvf+DSydQb/EhwJSJ+W1/DsCmQO5N9CC3EEsopTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh7k7aKicQo52F25igkjG4t2Ga3zDK4dcWPr3ghLXh8=;
 b=nhOPiYSpzbanVMUoXldl5GhoD8Yy1SD8+JbN9GDSAsdu/gRapvNrPVd1Ybk6wZBDJIKIC/8cTjIg+bTx/0eyV459/XxrAA3IJZt2fsf9MIgRDLIGKc9kkQuAYgqdY9B3+8kvG2MV8DYtxO/I6wg7zOTamHvqToiRrv+lsfVQEpk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA1PR04MB8286.namprd04.prod.outlook.com (2603:10b6:806:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 05:04:15 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 05:04:15 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Saranya Muruganandam <saranyamohan@google.com>
CC: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "tj@kernel.org"
	<tj@kernel.org>, "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>
Subject: Re: [PATCH] block: Fix BLKRRPART regression
Thread-Topic: [PATCH] block: Fix BLKRRPART regression
Thread-Index: AQHaiwSINB8WBnJl30qPCQCcaD9o8w==
Date: Wed, 10 Apr 2024 05:04:15 +0000
Message-ID: <tnqg4la2bhbhfbty3aa74uorkfhz76v5sntd3md44lfctjhjb7@7qbx5z2o7hzm>
References: <20240405065333.GB4023@lst.de>
 <20240406044643.2475360-1-saranyamohan@google.com>
In-Reply-To: <20240406044643.2475360-1-saranyamohan@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA1PR04MB8286:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BgHX5s9YOXlQoQpJBafC0nNzT9iPoiVwJltZAN6lpMMi3YQQwXnFYbkbeLtKQK0lrsCm/o6GuFs69g2T5OF1myl0hwgWeHBFSEXtLXlgQFFs8Xe4GCLGIZMq0PbQjcEpi3hmvtHXi/3bqRy6nn5JdnwEBNIJfWT4s8K9WON4ZMElquryjhZ+epRQE/2TFIZ3e64zP5A1j1BUV9JX3kGJdYwqpO6Q2LYGhwFpMHO+vMHig0QSXCnRRNvRGf0Fyh2xrrP9oTdFeBIys1hGmkyEb71lkK9EjF6N6+q4p2PM62ZEXBvkTxysa+BIIkU6VH3p7rq5NnE8mm5NbFTkUpM55cnzAecZohZZ4DkN1pDqNmHs130u1NjUPDU824naW1b3Y49+YkpwtbqMBwjcoPoEh8gJAldFPDhGon8ZbSD+2uKopdTIKzzhRDFJsVFQSAu1K/J2Qx6ZSqaIsRSaIJ/seOZzrqxBHj/he+H5zPxNThjZURDL0epQZ1fmsLw/t+wuCj7kuNaxazmYjjROIPJ0s4CV/EsjX8c8VfDTnZJB/qYoDfSMPZlC61RSwapoIqq4PQkrecQ2xKopU+/Hd+6Du0cQ+2PZaKQ+HnYsiHcvKHk0RRF3nuiSVyxMy89TcBr7z7fy87N1Y0APv2RpNCIOZd4ihPSou2RwHpxoqetWhS4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YdhWMZE42lJFwUY8Vght2ONJefIBsPpaJ3KJEcjWcQblHzStWqHkJsFjOPZZ?=
 =?us-ascii?Q?IcvA0MiyrVkehC7geq4u/6LkrkFTPnbdTbwHyTO2OVPEgRfkCIniKo1TyREv?=
 =?us-ascii?Q?r1Vidt6ht+IVAAxBxgMa2xb9MBsuOcC+wePIq+jV7g6EddXfkxhp3GazQgJ5?=
 =?us-ascii?Q?Y/VX0cROgknJUXvAQJjnOPnwd8+HceUwLpp1eTaWt1MyLulluDCEej+snzxw?=
 =?us-ascii?Q?Ln1KhsCfXlsCrnXWGvD5SjwOSLXtdDv6vUKTOQp6xdUfQ5apnejhQ5Oz+6rj?=
 =?us-ascii?Q?aJB+EQ5LJ80k3xNu+lD1VIXBmB/59gB7ce8HHUJE6YTuqlStpUJb3vx2tJtw?=
 =?us-ascii?Q?ZTMQVFLlVX4TLPfv9m52twX321a/dlCPa8KhohjVSOthIyn49iTX42JWRn72?=
 =?us-ascii?Q?2mPy3fAkYakuFAkIKrZDqBAZNygGkjemZkfZaROsf5WOlLeYqYsPqSzqgwS+?=
 =?us-ascii?Q?CPnYpBDMwrhaRcM0EL0MkSgwNfJJv9RU+G5vHcMZLHMH8bdmYXNS7REY9Wkm?=
 =?us-ascii?Q?9EaHGze2VamI8rclFzXk3A/kbeedjICGWmGZKOHpnapjpi04EQRmkdePb3Bv?=
 =?us-ascii?Q?JIdOR37D2KaFCaDwBesiW4Tb0d7CYxOD93wrKw3QIWE34xLsBIcX4kt8rRsN?=
 =?us-ascii?Q?K0PsHe0jl7WyYCP0dYZfb9/fFaD9xIki/keD3ZCEYrGspICoYMlqQi48ZDdz?=
 =?us-ascii?Q?xMpRLdymLQuHuJQMadWYiImCIvrqaHcpD5AytoCXCGxX6hkjcWMZDTugydCY?=
 =?us-ascii?Q?10BaHjICJF3RGlJatLFmMR3Dj1NYIv69QkqLllc9s+v4Hrwx25zWvW21cDU0?=
 =?us-ascii?Q?zNbKzQPUMf1lU3W0fzJuzJlxdMZExR1zL43kpz7t7gIcio74KmRGEvuwi8zH?=
 =?us-ascii?Q?6Db3aNjDL5SIO8WWxcLdMMwpMFPcNYWu0Ve5BzmwJWQdM0cafsGd/X1V4SGX?=
 =?us-ascii?Q?xw2GEEXznN1Oe+I5OP5OY4Gy5U0DofuJPoqDP5tXDpZWwpUiwyvOOlDkP8TK?=
 =?us-ascii?Q?uyNwRdOiKJzATbFvpn7ebFlWn8yYFILa8KBIb5cMHrjuTeIxb+s6xC2nC2jV?=
 =?us-ascii?Q?rkTDzxHohRGgCzBNYoubLz7XKUjnivrMERkIlgGjGypnMUw168IwogOXOMdQ?=
 =?us-ascii?Q?Ol6siH2v45vqYzsTQx5b3rVd6zwJWs/jrfb1eOG5H131WRitwHV8P8UqbJgW?=
 =?us-ascii?Q?7HwEvwPA/swrf2hfQziAxR3I2dLQ0HLoTQpgIdcfrUiwd7NXGqhKCVyAGILs?=
 =?us-ascii?Q?WhfIKqgO9sGtUGm07yfYVMS4IkxYv7UGlE+/EXPVYALsV37nkw5fQkG//2T1?=
 =?us-ascii?Q?J4Q9CRKGU0Owj/lj3CFAbaJznzbxd/ZJ6Odqo38pvG/Dos1MBsTS2qnPi8ET?=
 =?us-ascii?Q?k48vWDiIfAwjbbCkv/xIM4RRCgvNcd3jfRKSV37nUPj0/cGyy+ZLzz3ucfxF?=
 =?us-ascii?Q?fL0tgoSdf6bA17q30MdKdhDdwVTINCj+CX5HW/5CB9o849ysEmPAObxDlNqE?=
 =?us-ascii?Q?U7sabuMqccyQFHyxroUKZjIVm/PTtqpm4a0vB/wQiO0Ac3IQOXRT6J2DIMIM?=
 =?us-ascii?Q?rGTUyPeeNqVe8DWIlJ6K/V8zMz64FFLh7V8cf280+W6dHt04lXLsQrPZttsw?=
 =?us-ascii?Q?VbZbU+3MVX6GGxzYjmfBmcg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65A3F779849B304B9061A17F417F6BB4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/3sQT5EN8wCAvcSTJGTAN5zt3d5dxcMZNxDU5jZiT7Ne5se3wrZp1hreLZaDRyfh1BmicAvUIXwh3N7fM3LwSmWXh22wbfWTKWEl/0zZz9iMVkiFSExcsN4zeB/odCKKjucEn4jexJN8v6UOJK51ut6fXBsQ3EUgRcnLFTrtQCCiEo4/Kc7zrFv5Yn5WPcB62H64IYQ//U6Vh0Ar9YPcvRd462+ibQb/wJdcSAGcIe/+JjeLWpIArYSCSVr11sEaDboBNPGGrFz3JsRxIo92hcvOVNAV4c0S5NXDbpYzStlzhdy+/6Ss9D2XU2y3GF9F13zycvaXakYuwHflf27BGuAaCh2A5ueuXtpo+85UgccJI2fnY0SMT3kjd6mzhehnDIpwWYRLBea5pBEi81Swp6fWlo4aSgeqLkrctU/8ovrWdVjBUZzdJImaA+PPzavS5vNwflWwcXx2Nt3QHs54V7sX9V32gHlb1+FXGaoKBEJAVK9LpzGq/ljC3OGJna+Zy70gmXwm87xoih4GRHHT3zgXS9aWxeWMHOJm9I8pUoQkJM6oK65WSs+X/zZxVPG4Ijs5R53SH9At/n8hmbRk1VsqVfBTxbQzhJQ5GL80oN89eSSJSM4m/o5OSqOD8C/5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ce4edd-b865-44f3-0928-08dc591bab3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 05:04:15.1413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZsvAlDGE+amYMatj9lbUzZYxS/Dv3TDIuy8GR6zasMrnbuTTks3NdG7w0nQ0+ZHh9dkqG2DuxGEietKyIBdEiy9+BJ8dnh20ZTMa34JH7Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8286

Saranya, while I evaluate the corresponding patch for blktests, I found a
weird behavior, and had a chance to look into this patch. Please find my
comments in line.

On Apr 06, 2024 / 04:46, Saranya Muruganandam wrote:
> The BLKRRPART ioctl used to report errors such as EIO before we changed
> the blkdev_reread_part() logic.
>=20
> Lets add a flag and capture the errors returned by bdev_disk_changed()
> when the flag is set. Setting this flag for the BLKRRPART path when we
> want the errors to be reported when rereading partitions on the disk.

Documentation/process/submitting-patches.rst guides to describe changes in
imperative mood, then the sentences above can be rephrased like,

   Add a flag...
   Set this flag...

>=20
> Link: https://lore.kernel.org/all/20240320015134.GA14267@lst.de/
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Tested: Tested by simulating failure to the block device and will
> propose a new test to blktests.
> Fixes: 4601b4b130de ("block: reopen the device in blkdev_reread_part")
> Reported-by: Saranya Muruganandam <saranyamohan@google.com>
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
>=20
> Change-Id: Idf3d97390ed78061556f8468d10d6cab24ae20b1
> ---
>  block/bdev.c           | 29 +++++++++++++++++++----------
>  block/ioctl.c          |  3 ++-
>  include/linux/blkdev.h |  2 ++
>  3 files changed, 23 insertions(+), 11 deletions(-)
>=20
> diff --git a/block/bdev.c b/block/bdev.c
> index 7a5f611c3d2e3..42940bced33bb 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -652,6 +652,14 @@ static void blkdev_flush_mapping(struct block_device=
 *bdev)
>  	bdev_write_inode(bdev);
>  }
> =20
> +static void blkdev_put_whole(struct block_device *bdev)
> +{
> +	if (atomic_dec_and_test(&bdev->bd_openers))
> +		blkdev_flush_mapping(bdev);
> +	if (bdev->bd_disk->fops->release)
> +		bdev->bd_disk->fops->release(bdev->bd_disk);
> +}
> +
>  static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
>  {
>  	struct gendisk *disk =3D bdev->bd_disk;
> @@ -670,20 +678,21 @@ static int blkdev_get_whole(struct block_device *bd=
ev, blk_mode_t mode)
> =20
>  	if (!atomic_read(&bdev->bd_openers))
>  		set_init_blocksize(bdev);
> -	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
> -		bdev_disk_changed(disk, false);
>  	atomic_inc(&bdev->bd_openers);
> +	if (test_bit(GD_NEED_PART_SCAN, &disk->state)) {
> +		/*
> +		 * Only return scanning errors if we are called from conexts

s/conexts/contexts/

> +		 * that explicitly want them, e.g. the BLKRRPART ioctl.
> +		 */
> +		ret =3D bdev_disk_changed(disk, false);
> +		if (ret && (mode & BLK_OPEN_STRICT_SCAN)) {
> +			blkdev_put_whole(bdev);
> +			return ret;
> +		}
> +	}
>  	return 0;
>  }
> =20
> -static void blkdev_put_whole(struct block_device *bdev)
> -{
> -	if (atomic_dec_and_test(&bdev->bd_openers))
> -		blkdev_flush_mapping(bdev);
> -	if (bdev->bd_disk->fops->release)
> -		bdev->bd_disk->fops->release(bdev->bd_disk);
> -}
> -
>  static int blkdev_get_part(struct block_device *part, blk_mode_t mode)
>  {
>  	struct gendisk *disk =3D part->bd_disk;
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 0c76137adcaaa..128f503828cee 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -562,7 +562,8 @@ static int blkdev_common_ioctl(struct block_device *b=
dev, blk_mode_t mode,
>  			return -EACCES;
>  		if (bdev_is_partition(bdev))
>  			return -EINVAL;
> -		return disk_scan_partitions(bdev->bd_disk, mode);
> +		return disk_scan_partitions(bdev->bd_disk,
> +				mode | BLK_OPEN_STRICT_SCAN);
>  	case BLKTRACESTART:
>  	case BLKTRACESTOP:
>  	case BLKTRACETEARDOWN:
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index c3e8f7cf96be9..3ed5e03109c29 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -128,6 +128,8 @@ typedef unsigned int __bitwise blk_mode_t;
>  #define BLK_OPEN_WRITE_IOCTL	((__force blk_mode_t)(1 << 4))
>  /* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
>  #define BLK_OPEN_RESTRICT_WRITES	((__force blk_mode_t)(1 << 5))
> +/* return partition scanning errors */
> +#define BLK_OPEN_STRICT_SCAN	((__force blk_mode_t)(1 << 5))

The line above assigns the same number for BLK_OPEN_STRICT_SCAN and
BLK_OPEN_RESTRICT_WRITES, then blockdev --rereadpt fails with EINVAL,
not EIO. I modified it to "1 << 6", then it looks working good.

> =20
>  struct gendisk {
>  	/*
> --=20
> 2.44.0.478.gd926399ef9-goog
> =

