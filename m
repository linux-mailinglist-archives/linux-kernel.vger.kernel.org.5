Return-Path: <linux-kernel+bounces-15737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DC882310C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27EC01C237F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B8D1B298;
	Wed,  3 Jan 2024 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiac.onmicrosoft.com header.i=@aiac.onmicrosoft.com header.b="bprK3mvc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2133.outbound.protection.outlook.com [40.107.20.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E201B281
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allcircuits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allcircuits.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7H/Z8RFJTeEV9vtgI5CKK+OBlRRSEHHXBbwOKDIa5A5ZU5zE2Gq5FSIyOABxLYye6/BeGmu87sziXJnJpmReqnjiiVTO/LfpXlfzcUHvKXTACr7wejLEzE9kt2tEiLJQ9C2vP42fldaDHy9c23n6xpMk93Yip0CFrJg3AIqtS9ys+hyX1MEf2xKBHS1gpKb9gpGsG3dysrwlqFq1/yPQxgYVCPKSpJsUL8usUqMn21nwV8Ubl6f/xczpYq+hwh4snIlRd55NlokFiVr6vG981tvD9IR59vrd/2FzREup4lvP6Ua568E+bMFGoearuTYuErjADZB0wHcRTa81x5+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HME8mpNREfbHjIs2EwJXz5/4w40B8Td+R0ge2nkOVpA=;
 b=CgdNnUje4zyWeB0lfF5PY0BvnnlupTDdm9pPbpndTRZ13o/B8V+UH7rVulKPGDfq+LcvAp52M/lMypJAZCKOVqK47PPoKt6FJ+BT+oHqOc+MkZzAv67qMdVZ7haSBbEU9oZiP/yFarvMMG89Hc1DIezCtvBQk/XVOxww3MJIgMhS13fJRSgnm99f4cMje/MbFnuf9sCO59JgiAgdeZq4l9zDtnQmn4Rasqyzq6tTyjTuUpyQBaIDYG6K8xTiztp0w5lLbpJrQX3K4vw1kCUoXTuqJYPnIInjDWx+gt5YtQKdAxCVBeKQjnLrZd4M2e0SkhMs1lHj8ofFyflXUcQIAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=allcircuits.com; dmarc=pass action=none
 header.from=allcircuits.com; dkim=pass header.d=allcircuits.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aiac.onmicrosoft.com;
 s=selector2-aiac-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HME8mpNREfbHjIs2EwJXz5/4w40B8Td+R0ge2nkOVpA=;
 b=bprK3mvcU2/vez2znXiF6wnCZUcjpGD4LbXjCdiK9/MHdRuQ44T/iApejVPoj4TYGwB7/olV+qCPXtle1VJMnmHhoDOJdkbSd1ol8xTp+Aj3WOhxUWSqOizyCAkJTvYn6M/Xxkb3ThaiFFmg/IKRDkAyFMkaUAfPkjVDfJQbFqM=
Received: from AS8PR07MB8941.eurprd07.prod.outlook.com (2603:10a6:20b:53f::17)
 by DB9PR07MB9600.eurprd07.prod.outlook.com (2603:10a6:10:307::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 16:12:18 +0000
Received: from AS8PR07MB8941.eurprd07.prod.outlook.com
 ([fe80::3475:f288:b512:f1e5]) by AS8PR07MB8941.eurprd07.prod.outlook.com
 ([fe80::3475:f288:b512:f1e5%5]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 16:12:18 +0000
From: Anthony LOISEAU <anthony.loiseau@allcircuits.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Joe Perches <joe@perches.com>
Subject: get_maintainer.pl: penguin chiefs, maintainers and the rest
Thread-Topic: get_maintainer.pl: penguin chiefs, maintainers and the rest
Thread-Index: AQHaPluD96WSFaYhV0qpYD9FfGmlbA==
Date: Wed, 3 Jan 2024 16:12:18 +0000
Message-ID:
 <AS8PR07MB894183C6DE3473F23D5A046FF9602@AS8PR07MB8941.eurprd07.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=allcircuits.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB8941:EE_|DB9PR07MB9600:EE_
x-ms-office365-filtering-correlation-id: 02761132-18a6-4f20-8496-08dc0c76c231
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bPrtA0I/zx3C0OPTM8Rin94uuBpPV7Xc9OC2DzxJhxTEDFWmfkRzmhf7JqGdcPv4N7UFLIVp4+5xgO6PVWL+nRbVDlD6ChYV/wgQ1SPPUxCelU8Hvs7AM7MX4jUSNnOznu7lVcODDlnqMciqC2IH/SPwNJfosTgQBxlWcTGUMaIrMYNnuvV5s6ZzyLszgLxmZCkm2kAgSNu2er5yQHb8+HZMX5VGEQiq1LxRB3a6OXaR+rga42Yld07M9AuQNKjONiRQ9QIq8/1tA+D6AdT7N1IxZNpzbi3PHGHxu/SzbtI3dx2Dw8xXP+jJxxXnlbNAE+qR5heBV4xt+V0wLb9qCXi8t7oxECSaGE9VFKtMAphWcqinYMj9pnOKfLAHZrhDQuyRrvHC0yGpsgZjhV0H1EAUdQrCI3sGgJXFWyTx52IEn0p/lC/xdSS8DzEM13J6SZKVQQqx5HwOmHaVlRjq4UrSDTL3LcTdGsKmiX1t5cPQuTK3OLee+XzSP+Fua0PepP0yoBgR4/Ja35TOvBsRapo72sAFsZSYZL8RTh2u8Kz7NmMcdVCc4l5AYwHUYXrLqzvRwdeXxhZD0SUau3QqZmXFvWbNerGTT2Z6d66835670M//L8SUYuviJl2ZiDfsZJ3k4UWFfvHE0MjEMdc7PhXxKvDyrAcF6TUjSBrklofBet0KG2JCfJJ3KZOpbXI50cqjKbx8mOOq3y/WFmhZHw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB8941.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39850400004)(366004)(396003)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(64756008)(41300700001)(26005)(2906002)(38100700002)(122000001)(52536014)(8936002)(316002)(8676002)(5660300002)(4326008)(71200400001)(478600001)(6506007)(9686003)(66446008)(7696005)(91956017)(66556008)(66946007)(76116006)(66476007)(6916009)(86362001)(38070700009)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?q305IgtwAUFScNyQFYMOwPMYPLXWJH81pSsTcrI7EuVZojK/NEY5NCNMCR?=
 =?iso-8859-1?Q?eFINA/qftjSNVOmUg5vHyjNuNDqCV7saiUOdXMA2vihOFoU4goQycbszTH?=
 =?iso-8859-1?Q?9BUqoaZlkBeyOqJ5ML24+WXc57OjoeH68wjItDl2pHqrWhCUb2+RRkFss2?=
 =?iso-8859-1?Q?0OE5WWLSU9CJKQoh+eY4z6QTGvhuXpvMHNfRqJBgP9nMZfUzHq9Hm4ESnr?=
 =?iso-8859-1?Q?MueMkA3C8q3TEFKwBWlwEwDTfP4F5HYN07m2cHyVosyeRUZ3BAYwPdv0HN?=
 =?iso-8859-1?Q?B41Y/yMB9q8p3FWsqPSB/HY7i4p/EF3L+1q4qb+N/xN8Q1FWV/MmdrG36i?=
 =?iso-8859-1?Q?6OwXpa6mLh1kf0yvEMrKJvoyP4Xuew6iZsYKi2gttfd/jYBCH6/lYhEpud?=
 =?iso-8859-1?Q?ZASTpT924NdL7aK4Ja+rBTrF3dFGfyhc2OdmQmL5/CTbjVdNJa7PjnlYFy?=
 =?iso-8859-1?Q?wGdVU7THTL0oBy5h7o6PTQRWLnTx5Jr5CrRT530jmES1vZIKjHRwOzRUN/?=
 =?iso-8859-1?Q?BXr8t15Qz8Oaw1OZ6u83dKmUv50UWltkOBWQXpb2WDG+0wfGRMXrR8hiyv?=
 =?iso-8859-1?Q?KcZ5JiOb5+0FIraPR3TtQGbxQn+XjnqK57BPyUDu2tgArxEl+V6MosOI7c?=
 =?iso-8859-1?Q?eesQWei572zgADbIHci1FT6URO0y8V8qpN0mK8oDoEUI09zz1Qb4JoiV8E?=
 =?iso-8859-1?Q?Ynq9uSZ6DFOXDHdeK7E124KtWlBIVb9Jm5LNpvMO6ro87zCoZ7JgmBs0aY?=
 =?iso-8859-1?Q?+R/SJhv+K/25Jydh04t1XMdZX2L0jibSzWrm6JmZ7BdMalfRVb2ayELgJH?=
 =?iso-8859-1?Q?01s6pjcKdzCxmIFm0T0WaasVgxSW5FsuOdmsUA72SgMGMh05jFVgfnIqtT?=
 =?iso-8859-1?Q?4dU87RmO52q+zjO58AlsvecbzLALRdBAsjDeDgCgNgtBbQh2abfXD+kegP?=
 =?iso-8859-1?Q?yhWx9kx+wc57WjbAc67qi+f/k1IhcXWp5JG3dwfGd/bQRKeLdDSRfzPFq8?=
 =?iso-8859-1?Q?PqfKuaqOM18AbcgElflI4LISO2p6quVNlSfoT1EwDQffuc0UaCrm23Evtl?=
 =?iso-8859-1?Q?FrMzf/rMptqu2HcoiCp/HgtXZhqxhC4Zyfm97hMNboy8DGWGEw40HXmTOF?=
 =?iso-8859-1?Q?6jVCVr9qpBesZAbs5/Ba1yf+fryMlxNZHeS5v2JGGqSOfoxmpA6QMsMovX?=
 =?iso-8859-1?Q?Y+krq9n+ZXra6ztgGKdajIggEYVCrob19J0IRvChw3gN4WimQ12IV5zgi4?=
 =?iso-8859-1?Q?YeegLN4um+G2EKth5uX9PdADGpNb2Tk+m3I0M38au0SJhdCQ3Xzzn5tDn+?=
 =?iso-8859-1?Q?Fyg4ihiQ6ydLDT13j+uUDCZDC8yaYOQxOUtq+BU9zcY0ZPb7i1yPvo3BG+?=
 =?iso-8859-1?Q?M14b0PVnxssAJ23VUaLErzf58zPpVgzxKgoxrAR9TSuKXJehbYFzlJl/wQ?=
 =?iso-8859-1?Q?4rh+S3jt9DFSsW0gexeas+m34KbXHivgO1zIW+k7cDpoJN1zJ9Cv8A6dmw?=
 =?iso-8859-1?Q?9j4f/wtJUbAg05mnABrK2lsMnx0ooMo+GbV0Iq/J6PtXCCIrlxX5t9WzpQ?=
 =?iso-8859-1?Q?bgZMTrzb9KHisSFClFLlo4qRQm+nzl/wg3R61SIZwcvQHpxxCRAAhW9ATb?=
 =?iso-8859-1?Q?RiJXRJyZx/LZ8Z44fRXHwdPB8fx7+qcNVhgvhfrlmyiiL/j4L+yoynaw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: allcircuits.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB8941.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02761132-18a6-4f20-8496-08dc0c76c231
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 16:12:18.2935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b8617389-e867-4e05-8324-cbea2cda1861
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4qLmSFjP+6cmNE+zErf9NsCL8KrqKU9o/94CgUPOAbURjAoi17sLqhRMyko/qmHjNU9I+5nSeQbTKVF7sE1urhmKtKZsfYW8Mh42+9O79M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9600

Hello,=0A=
=0A=
I am a little bit cluttered about a few things around get_maintainer.pl and=
 the fact that penguin chiefs may also be maintainers, at least in third pa=
rty projects also using get_maintainer.pl script. My feeling is that get_ma=
intainer.pl mishandles penguin chiefs without it being an issue for Linux c=
ase, therefore a kind of silent bug. But since other projects do use get_ma=
intainer.pl, this "bug" may matter you (upstream).=0A=
=0A=
Penguin chief is an hard-coded list of name:email inside get_maintainer.pl =
script, which currently only lists Linus. When called with --git-chief-peng=
uins, the script also outputs penguin chiefs alongside found maintainers.=
=0A=
=0A=
When called with --no-git-chief-penguins (the default), the script actually=
 removes chief penguin from found maintainers. That is, if a penguin chief =
is also a maintainer of some files within MAINTAINERS file, asking maintain=
ers of those file will not list him/her and may list nobody if he/she was s=
ingle maintainer for those files.=0A=
=0A=
Hopefully, the issue is either minor or nonexistent/feature with Linux MAIN=
TAINERS file since Linus (hard-coded penguin chief) is only maintainer of "=
THE REST" final catch-all section. He is the only maintainer of this sectio=
n, therefore no maintainers at all are returned for files not covered in ot=
her sections. Also, thanks to this bug/feature, this catch-all section bein=
g somehow broken does not reports Linus as maintainer of every Linux files,=
 which may avoid flooding Linus.=0A=
=0A=
As a first sight I see several options:=0A=
=0A=
1. Upstream (Linux get_maintainer.pl) can be modified to not filter out chi=
efs within found maintainers.=0A=
2. Third-party projects can simply clear their static penguin chief list.=
=0A=
=0A=
Caution: in both cases (and especially the former), "THE REST" catch-all se=
ction will work again, listing Linus in all results, likely flooding him un=
til all git-email --cc-cmd gists are fixed. This can be handled within scri=
pt since the magic "Buried alive in reporters" section status makes its mai=
ntainers getting "chief penguin" role instead of "maintainer". Script can t=
hen properly ignore penguin chiefs only when they are referenced as such ("=
THE REST" case) while still listing the same author when listed as a role m=
aintainer.=0A=
=0A=
At the end, penguin chiefs may even be listed only in MAINTAINERS file, eit=
her as today (special S: changing role of M:) or using a dedicated letter (=
allowing maintainer/chief mix within a section). Script options --git-chief=
-penguins and --no-git-chief-penguins would then only parse and ignore matc=
hing chiefs inside MAINTAINERS, and script array @penguin_chief would disap=
pear.=0A=
=0A=
My feeling is that this would be the cleaner way to address this issue. Wha=
t is you opinion?=0A=
=0A=
Aside note for curious readers: I actually saw this issue within U-Boot, wh=
ere Tom Rini (hard-coded penguin chief) is also maintainer of some sections=
 for which get_maintainer.pl does now work as expected.=0A=
=0A=
Regards,=0A=
Anthony=

