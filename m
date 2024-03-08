Return-Path: <linux-kernel+bounces-96625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED00875F10
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F341F23870
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502405102E;
	Fri,  8 Mar 2024 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e7HQhaUO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Fue4satL"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163624F891;
	Fri,  8 Mar 2024 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709885109; cv=fail; b=KlBF36CgBWIkBf8SIBmuj7BgLOF/skdxsoKe8YGGfEQoRCVzv6OHTQIPD3fz4mub6VyhkxApDqN8ZBOg2FgpMt4YMZ2vdhnKE0rIzaTz6GT9m+hDDWKIK3Om8BsLbsVNyyP0PbjpziniJ3WpJuAY5wLgki5iZOJV7gtQ8Q/0lAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709885109; c=relaxed/simple;
	bh=aaqlfjj76/uCfH1MEXvlp5gPzbMwQHh26cj1WZh1w44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BdD/dYsJJh47K8cgNgML10BCWXA5ExYP3+JR1AlTbhCoWxRX30AyfoZIfwQGuGD6kQhWBAbxPNpeQ0BJv1/Ca42T5JLPuy7BXdPdNn3Qdb8cYKS7wXf3SLtzVS7DGsfAfu976dEA0mIXZlbzeHNmgS9NKTUuLM8DoLH80Gqnk8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e7HQhaUO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Fue4satL; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709885107; x=1741421107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aaqlfjj76/uCfH1MEXvlp5gPzbMwQHh26cj1WZh1w44=;
  b=e7HQhaUObHB17Apzd1I5iqwoL8oLSaHnLdcMrKF6NfADbaDl0IOLXNKt
   +JLt5nFOfXCSQ82wIqvGJO1v2ByOWIyD6hYHdBsslHm/dC8QABgsfj7GG
   xbKo9P3MHXHAwrjGTsi7En3bBtzC78x/REFI3hTSFadxNzdGsZ9oQRgZ7
   UiCDzfGIhMKPAIslSlAq10MqERBJhnpUkKOZ7yBKTO7Oz8mXor24wmfAt
   LqgQSA+WCkjQTLF66/jlwt8c5dZ8K/Xp5L+u9k83ZPj7K9Z2X0UXXWp6O
   zLZTY5SGeyR+Wo0DACi8+dLWiFF3sT0Bl1lGMsm3ggYRRNJH9dzoTghdm
   w==;
X-CSE-ConnectionGUID: Q0X+x4rMQuqz//mi+U3a+A==
X-CSE-MsgGUID: hrbg39foT02UFnrXwNYwyA==
X-IronPort-AV: E=Sophos;i="6.07,108,1708358400"; 
   d="scan'208";a="11356051"
Received: from mail-bn8nam04lp2040.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.40])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2024 16:04:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=by6ZFfkBt4yuSzU0m23ks4mfukchKDCzClavcRgzwIbws+v7kdqUZA/rQriMM7tZWxDVCDhZ6WVtXH+EXGZowbghfS+qRHT7qg1TJRgRXCgjEhRETLNI8vns0Q+RnM6Ue4wrj2W6AYAZl+Mts47/Xa75YymOUwUq0iXUSVWej6vK7Kkum0gjJrhmt3+JFaNYZjXTkyWIQDpGa0tZBU/ZDw+cPBVTstCz9mb7uDyTl1Q812X5yjEC0lxW683X7FXqCeGDot05P9SgkJ+C3bVjZrEFzd82kHAxm6CR5vKlN1WEtCwJ704/0C6ZNSef3YD8NOQf+4tQ6RsLr0lTdiWgVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6ofbXNDyByy7pShjCBYWKt7KkrvIKcS40cX85Bc560=;
 b=n0Pphn/VjnXI69V4A109ngLE3jQiOzPmST53JBnJLwKnIIcyjBSuzApBNOtYGHtk8Zi2/flaN4thWzTg0s9EIA7XFYv9bupaghbVmvbXkWyETiQ58IAOg8pOdO0mmMkfQxxEErStiDYvELM7gh73S/OewLD9x+zgPKJCMSyD6QVPC4jbncFKub39JJR1T3qRlJgebQHY7e3o4zaABGbLqYKEdSvgLKDhYAFZ9P+W2HNKsJK76UkEKNBjS97THrwd7J6DUY7m0zsLhQ9EzQvPGh8YAQhrcl8BvJ67ehs2Rsc5ezjKtdisFWkJNcQUkjdM2eWk9Xe2WKcEHsvxKw0B9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6ofbXNDyByy7pShjCBYWKt7KkrvIKcS40cX85Bc560=;
 b=Fue4satL/WwTAs46y8LyJ6gf1ehqkDlIBi30vgBG4Iq8gPEOHHjGBHlgfz8ezRDSTFVEudlxqqnA8E3IK4nCU2sQlEAszyHLOR2yO1tNRwKU5WmSaGlT+nZE1YyEYegMjFdhWxWLSW7/+J+EyvK+O2qwRM7JzSW85S8zW9/l0Go=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH3PR04MB8861.namprd04.prod.outlook.com (2603:10b6:610:172::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28; Fri, 8 Mar
 2024 08:04:54 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 08:04:54 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Daniel Golle <daniel@makrotopia.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe
	<axboe@kernel.dk>, Dave Chinner <dchinner@redhat.com>, Jan Kara
	<jack@suse.cz>, =?iso-8859-1?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
	Christian Brauner <brauner@kernel.org>, Li Lingfeng <lilingfeng3@huawei.com>,
	Damien Le Moal <dlemoal@kernel.org>, Min Li <min15.li@samsung.com>, Adrian
 Hunter <adrian.hunter@intel.com>, Hannes Reinecke <hare@suse.de>, Christian
 Loehle <CLoehle@hyperstone.com>, Bean Huo <beanhuo@micron.com>, Yeqi Fu
	<asuk4.q@gmail.com>, Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "Ricardo B. Marliere"
	<ricardo@marliere.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Diping Zhang <diping.zhang@gl-inet.com>, Jianhui Zhao
	<zhaojh329@gmail.com>, Jieying Zeng <jieying.zeng@gl-inet.com>, Chad Monroe
	<chad.monroe@adtran.com>, Adam Fox <adam.fox@adtran.com>, John Crispin
	<john@phrozen.org>
Subject: RE: [RFC PATCH v2 6/8] mmc: core: set card fwnode_handle
Thread-Topic: [RFC PATCH v2 6/8] mmc: core: set card fwnode_handle
Thread-Index: AQHabzsoqnu1cWr8NEek9PCEYV4EaLEtf6cA
Date: Fri, 8 Mar 2024 08:04:54 +0000
Message-ID:
 <DM6PR04MB6575C0FB6376681697C97DE8FC272@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <cover.1709667858.git.daniel@makrotopia.org>
 <055787bb6085c32907ee1772522a6bfa49d5d2ef.1709667858.git.daniel@makrotopia.org>
In-Reply-To:
 <055787bb6085c32907ee1772522a6bfa49d5d2ef.1709667858.git.daniel@makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH3PR04MB8861:EE_
x-ms-office365-filtering-correlation-id: fca20e09-979f-4286-723b-08dc3f46704d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1stF/RnKMo4cFMeATbvbE/q+C+lCNODyZGBHwEX4+HuOBA4Tu9GH63zjzyaabkNz7DB8qUWLbFrXF9kAlxrJKW6YMi5ZQVSJWvVu7F2GbDrb62tXvipaxZLjLRyO/99ZF2me199ttt4+nq2GoxNkNs1bLTIheU/dqgSs2K49xqBOER0Pv98Y7zMLx/hdCItZjGx7hRG9es8r6M9b/blH9KvmeOBbPUVYcbY54YQLW1EO3PBfh3sPnER3JHAIToOMfbLMrNMRIuGXaS/0+DMui0hfhmSamgw1XcLbnHOXz5Psjhvbb4FBg0tKIzgT4wkkMC4Bjdag5RDPv1NSut4O4LGHAfgdPJAVRXa2q+VAfd9e2g2s+Kjj05zmazoR9zHdGQvvKWvd626ptWXDEHwcUleZHdAbRKJS3kdyCR+NqjCaLyWj4h8+dx7/QknBSzBg3Tyhh/3b6G9/1gfop3XnV3ZQBNcgqJMCq1Y1UV4lGd11aqFHuaMJxxy2AkMvdJYdPdIq9VCX0DaVLb2gdMsqutu7Brqe/wwVIMAQSWdi8U2SYF5EaYxq2G7lEhGbQ1yyAmM01l14TQUXugqd6Vr865YMB8Om/HtnkOyU5Z/lXhjZH3gZEwnR3WxeYCAiLDR3YuTxpnE4xI36v/e4mo1zp5z7RtVvWCShX7fyWicXH6nrk3A363p+MhvdpKqQMhqHvcyd1DBNEyt3kqb7jiTHZZCVFyZY3frfEKsfOf4MBkE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?JNk1zdkdEEy2DabasCPQlewVFdZFgUtVNcA59F97DJ8ejNscnAKeS/nkdX?=
 =?iso-8859-1?Q?ae9Y3q9Tt8bew2Zw9dTMguZe4TZquA+eYCtn64Wa8y6A6mc9BuBhuKabJH?=
 =?iso-8859-1?Q?rA5edW+y62sx/b5JTl3QpjDyI4PYNIWqzUW4tMKppF4BG6Kgr7aoZ5xPbI?=
 =?iso-8859-1?Q?XqdjbugJOQDpkseb3iFSaAhf7l4AzvjNZs4H0wEI/2j+QS+BW6wqMAz3wO?=
 =?iso-8859-1?Q?832QzFVKsu1Oa4n3iRK4eJ7Lp+F7Q15/SgRxydxVVa7eV8ZkE4e05QrDF7?=
 =?iso-8859-1?Q?eV+6FYQfb2XKUsPX86szK5SkkCBBGeWTD9p1q5DLh4Sqy/j46Ft+C7w2/7?=
 =?iso-8859-1?Q?COpd0Hrrcnh+T7sqBWM6J9bTP/m4fx0vG+krioub3YqYZWvbU1ZisuB/A5?=
 =?iso-8859-1?Q?T1NQlFfbPJtDHaCgH4hSumoksXFiOdasEyBOgT//icmfZG156J5J1WlUzk?=
 =?iso-8859-1?Q?Xv940ni45d6vGR+GeM+4jl06ElfI63ITcNm9o0mR8n0nr6zDbZjvWbhDQV?=
 =?iso-8859-1?Q?Ox63Mm6raQuK/+fAWjS2VJbrukJP3N9v+VJ8pyMflFa27bJYDvzs/KpCfr?=
 =?iso-8859-1?Q?WU2bjBtOT7MtOBfTDD+DrBZ9ZeBRyCF0YgGNeX8+C+7G5kACwe4xN0RGL2?=
 =?iso-8859-1?Q?BUy9K1w7VBg3+6nP/NtKB3ZyOVbkO7NVsTGzHzGwEanWneqj/VK5iugrh1?=
 =?iso-8859-1?Q?ZxfpRlLDwBQJGFrXZrtTtakgcI8s+Qai/ht8bzf++i9qPWm83YTMI0gm39?=
 =?iso-8859-1?Q?gumObBgyPZ6bvQugEvXlVFL70ePZoys+Kvc314Gc+uPbssRk+shk2zwFsQ?=
 =?iso-8859-1?Q?okrSF7J0zEa6NOVutVHK0BlvtmpvLNboZU7b64UYgbpoQN02b75/SVDEXb?=
 =?iso-8859-1?Q?+RLM1tLFbybumwx6etOQya33V1SvQw0rVCwDmavnMIg4m52PEdk1qvsq9X?=
 =?iso-8859-1?Q?QdvsKBF7/1EdAWNLmSaM0e1EPeu9f01IeE211r4IIS4mba9xj+9JwOZczy?=
 =?iso-8859-1?Q?nZaorUJir3/eW77NADCtM2eCZeLZWe94sMDGs8wEIrxKYpD9tOK7Ksi9vV?=
 =?iso-8859-1?Q?H7IwF5kIIRiyFxFOKsI2Eqk10UUXWcxWliiXNmHzc0m5BqVrA0muDw3tw9?=
 =?iso-8859-1?Q?xbZIelrs1q5Fn3WsPuEXb7m0QeDT7kl5mi0wk6EoE4AoomWjEws5BTA/bi?=
 =?iso-8859-1?Q?ilG+/W+tdBxYirA/OIfqTt/rDn3q6bGo9bu3I1BG1TcTI5YcSL9iMNBUYB?=
 =?iso-8859-1?Q?1Pl1hMIZuh/tAKl24j3DDptYwtjsZ/S/J+g/InYssWmRNQ8MY6bsdKnUVP?=
 =?iso-8859-1?Q?WTAQIhBDePEWI1Nh0OGZB247LGyFo9WG5NUOG1SrO3K+FeE8HQc5aJvQ2M?=
 =?iso-8859-1?Q?mEEeRw9CKfgdyzq0WCedcBVo8bG8kx571xhqoBbCD9KaLo9Y3pSeudLmg5?=
 =?iso-8859-1?Q?XWhveY9iwCVla91XnF/rmtGIeD7MkVfuWnYspE9xTuVweeP5kM0C3cXWyW?=
 =?iso-8859-1?Q?Gdzd0bEOFSjecxNGvBN8dmwO1Ya42Z+bvLeJ4kdO6s3Jd56GLyxxgWjJVd?=
 =?iso-8859-1?Q?IOnqmugcsUaNbH+KzsjS+kV3GSN6XIyYsMiK7jSPccT464f+dVOBhbHtnh?=
 =?iso-8859-1?Q?FUilyReSlFevMkbYUNYhSkcZmq2JFd0Z20?=
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
	JSM48ALQn5YRsG2eKQeauKM6OmH/5aLOlyrkwPQ35D6C2rHC0N3hZLourSZjfWHmEbaMbhfxxdqX3Y6sq1TsCgrBfNY4kuEocQFhUcqYPatFFjDfNbJIxvnqo3ljjEjN7nEst1CijQDk8WjB/7mncUAFuYXUJQh1ixkJbpw9CRnDBHJreBe1xE8NujZopnPht/QvOrwbT7k/4yyZryn7ydoC/mXtLWPwORW43FT0XQWnIZnjDN8Sp9sp3uwUZTP2iRnhIcWueBrPawqSRbgY2pt3XpUXMN6Siiv5yo0yBqyYDp+/A6AX5UGJCk3FyEA5GdDiDYbxOkqmSkfbgbGI8KPsLKrf+x2l4T9JqZmPiAkGpi6ZoKUQyxIuOEHADv902cuCtv06Zt/3Xt5H48JLZ2L3yh32S0bv9JRxqFezjusO0Q0r2KtmKV49Ei1EvwDKmWfvSyleWkhj+4ayR8/ai7ltuE76O4cf4wUIrOoFEc25ohFiO4bWCsOgaeUYSNozxnBvX2ruMmKFRZ0vUZ6QG2l4S5wf1URML8fmNlaID1n/5gKeZ7F/AkhG9iEO2SonqQCjK3XQrvi9y+VeEBcV4+mH0SZM5y9UwFn9NttpL5LrAwGxD9NaDibCY0ItGZ3J
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca20e09-979f-4286-723b-08dc3f46704d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 08:04:54.4090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ADaP+VnWmxsqfoq3/IImFLPBB09UGS06VnDT1wmrnuNMMAAxCa+Tzd/nI0j3NzSJAWUGRvQKOFiZUw8ZV7wDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8861

=20
> Set fwnode in case it isn't set yet and of_node is present.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/mmc/core/bus.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c index
> 0ddaee0eae54f..e1c5fc1b3ce4b 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -364,6 +364,8 @@ int mmc_add_card(struct mmc_card *card)
>=20
>         mmc_add_card_debugfs(card);
>         card->dev.of_node =3D mmc_of_find_child_device(card->host, 0);
> +       if (card->dev.of_node && !card->dev.fwnode)
> +               card->dev.fwnode =3D &card->dev.of_node->fwnode;
Should this be restricted to eMMC only, or is it fine to be called for SD a=
s well?

Thanks,
Avri

>=20
>         device_enable_async_suspend(&card->dev);
>=20
> --
> 2.44.0

