Return-Path: <linux-kernel+bounces-12642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5B981F83A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3251F2426B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816D0749D;
	Thu, 28 Dec 2023 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sparknarrowcasting.nl header.i=@sparknarrowcasting.nl header.b="SX/ikquC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2072.outbound.protection.outlook.com [40.107.14.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D377499
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sparknarrowcasting.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sparknarrowcasting.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STIn2Xv/1yS5A4XHhJ/onbRB5cxXgxWKcHTuaqRLFQW8/b5+YF6fk7ccikTEJ258WTl04iYZaLSYzRPqw7f06vuXEKJBp0q5HeBPDrVACqBy4DTF/VWHLELKkacN7l6PSFd4bOOP2W4o3JLGloMfviBn22k6K5Yo+Ph6gE5cUlKPqIJIZTNFsqoiA5IMsvoqCZmf9Z/uq1xcTokwBeolRlmt5z0rJyreO6G+o5g8pezVpNs34rA8ChOtvtEKfz+dOB6pCN0+RQbYV6Bag34X8IDIYlrOzQmEyAxYHiYpRwICq+4N1oTvcb7CVBoDLxmm0aNHWU6AFwXhoCw0ba/fIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meafkefoXtEkEuGLeY8GnxbFFglJ8hHKhU4O57IpZlk=;
 b=W6d+IbQUPoA3Wmp+UhAsCMvCUUWZ3E4UHJDBZn8RayRMUPIubRxBr3Aei+kN5/h53yfky+JAClflFPxnwmVG7GOhBe92SkucN9B73n9lfPy7giLGo1rYkibiqv+WrZy12lgPMh2LsTzgRamyKRb6829tdJJqn9l91IOJ6kyxQKTz3Gshc2tbgKkxXrCZGNqYU7Pc6gQyD4ysYyDC1QY68qWrPr5kpFNeZjyTC0Q2DzZ+T8uB02L0Z89HrVo3rd/vBvDuDFv2EBEEV9Q7xT9xbywBOz4yjm9Got2x/B5OYB56mOUFLjyPapdOBYI2BxQDBmF1fZ+ihGYZGX6bI4uRrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sparknarrowcasting.nl; dmarc=pass action=none
 header.from=sparknarrowcasting.nl; dkim=pass header.d=sparknarrowcasting.nl;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sparknarrowcasting.nl;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meafkefoXtEkEuGLeY8GnxbFFglJ8hHKhU4O57IpZlk=;
 b=SX/ikquCifreus04uGU6sl4MGhzZTL8KEszdHnGHB1+/JUUkxlj4n/v4qPW8/BV+t0wgSq1ry+0SIhfY4irdiDhlrINC8zT6+QVP6zfmaWS4f8DRJP21KcYS7Kkr5go7PxCumBud1TLcAWH1WDy1sLsML/w7YeQAFs6hMsLD8tyXALcjdC0jTZsZcuq2lD4JTctKxm6eOdZtyrkYz5bXayIoA90Y1TWspMngRhB5KavLUpjE+r0dKkAvmibujhLIzTDfLZgCENd/8F+j6FLIAklwqqd1hhmwvvUdB9VVNTkdRTbOpDDwoGNedwDF4PoDBJqqIydE7oOFZYYNfYE7tw==
Received: from AS1PR05MB9393.eurprd05.prod.outlook.com (2603:10a6:20b:4d3::17)
 by AS2PR05MB10151.eurprd05.prod.outlook.com (2603:10a6:20b:601::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18; Thu, 28 Dec
 2023 12:39:45 +0000
Received: from AS1PR05MB9393.eurprd05.prod.outlook.com
 ([fe80::3017:1a1a:672a:8316]) by AS1PR05MB9393.eurprd05.prod.outlook.com
 ([fe80::3017:1a1a:672a:8316%6]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 12:39:45 +0000
From: Ben Mesman | Spark Narrowcasting <ben@sparknarrowcasting.nl>
To: Sean Christopherson <seanjc@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: Bug: After a 'warm' reboot the disk is missing (not detected by
 the bios) on a HP t640
Thread-Topic: Bug: After a 'warm' reboot the disk is missing (not detected by
 the bios) on a HP t640
Thread-Index: AQHaMnxhIfb+xohLkE2RJYfuBf5C87CyY5AAgAxHDQs=
Date: Thu, 28 Dec 2023 12:39:45 +0000
Message-ID:
 <AS1PR05MB939337F702FDD79AFDF18F56B69EA@AS1PR05MB9393.eurprd05.prod.outlook.com>
References:
 <DB3PR0502MB999347F512ECFDBE3BFA9941B697A@DB3PR0502MB9993.eurprd05.prod.outlook.com>
 <ZYMator0DDfq_moN@google.com>
In-Reply-To: <ZYMator0DDfq_moN@google.com>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sparknarrowcasting.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR05MB9393:EE_|AS2PR05MB10151:EE_
x-ms-office365-filtering-correlation-id: ccd4f55b-6be3-41c4-0940-08dc07a2124d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 01h6onfwktsGK/qV54WixhIqm3r4k2QN/BsKKClMD1lEORSaNEoPTLCnzxTyfgw12SejQWd0UG+UdP0xi1A3i4B3v6xJ1QSwBgK5QAYPTJpb8zDL1caI6tHXGfXDLuRscgskTX1uSlpyL19mEwQI0h4WpDOBe8g6oGuUIHi+Vmo7Fi4R7b/fpoeX6VFjRxmuY7dwsgsLRr7+iuOeJqc27PqCKZ13PQV2JuK7yHdVrKnSacOMK+EF8kkqT0vtC2iVxV1RnnOlt9qlwJTNNFl6dYopN/YMM0c+d34TfFDMCEylLM28LGub99y2RFPUDrq6+IkhW0/gUUiy9jpA2gWu7J+6xOf6qnW1Mnn5xl+rEQYKjGPCah0zUsBhR59pO7otEW51BBeFUlTJDEm/k9LKIJ31xe3n0xgw4ClRThwy21wW3HzQV7IcbdRGtceMZZf3gO6qVTVaZTELw87ZyBZKuXAho0goqTfUOIr/TyMLmdnM3G1HSkCBtx6EOcKNAbDPvFLkTsjIQ21fz+ju5quLTDLNmPbVUb1QFpLodqxFAn0I748rgwnxNHIDif60mepJ0ykDoT5vmkSmJ+LXfB2dAeXnAYirpICnztPyDMmhJ9o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR05MB9393.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39840400004)(366004)(396003)(136003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(7696005)(9686003)(71200400001)(6506007)(83380400001)(55016003)(6916009)(478600001)(4326008)(52536014)(8936002)(5660300002)(86362001)(966005)(8676002)(66556008)(33656002)(76116006)(66476007)(66446008)(66946007)(64756008)(54906003)(91956017)(38100700002)(122000001)(316002)(41300700001)(38070700009)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?MLpsk8w0ZkFLhmWgED4+gnQiI/58Ib0wmZ3Csu7ZQ8V5WP6dODVjzwFisx?=
 =?iso-8859-1?Q?1/R/6vPkG44NauNOOQUxZ1LZXcKppUe6EFwbO8SrCmFoyoDv6OD6VXAfQX?=
 =?iso-8859-1?Q?6uDFIf9Kop2A9l5cIWXPPTx2vrUlK66IXKB6yysE55ten+jk34m3gmCBWR?=
 =?iso-8859-1?Q?00qzK6RDRJKta2AYPa55dCt4fik5Pe2Y50tFKbBLlXmB4ycP2tTjYERiw2?=
 =?iso-8859-1?Q?0cBbJGSAlS5PIC1FJydqUIqj7Y5gfOQ+fL7Ta5Rz63oOAuA6ZabElTpcT3?=
 =?iso-8859-1?Q?MZXGSb0eL/p9P93TCNRdaP/v9VUKObOobrtbUGl7o2M8ceDgllYx9c9w2w?=
 =?iso-8859-1?Q?fw4bY4mM5VE7r7n6aRo2jvEVXC7ZUqZShbvfoyyWCt49alx0I3ARhaJaiT?=
 =?iso-8859-1?Q?ihsWgkWj7cvu/3eVFnOncuqrDggHi6rwxF2+pr9UmLvYhaxDXJVBDlLrJU?=
 =?iso-8859-1?Q?qPkRG+ii45olEXVfMPfh+0I9a3V35V8x+rRxoJG+mTtnN8ekPT/n1Y0cEV?=
 =?iso-8859-1?Q?/XkvgL1LtmBM8q34UK9nA+ikri9dSqkG8SSN32DZbr3qNZayNmP/domqQl?=
 =?iso-8859-1?Q?230bE2FJrxWRsq6HuwwWaY+A3yroJuDj57/4Jkkg6NuN1IL/H+Hj/e4T5t?=
 =?iso-8859-1?Q?jjQ7h9kD4XUX1mHbSL+s90q8R5R3pZMsFIK7rMMDgxwntW86PN4Uu9iH2J?=
 =?iso-8859-1?Q?unNEt9g173U2xh9v/LHE5NXk2e1orNHzzbou4YS7vXdDLE9Gi/vtxalaKc?=
 =?iso-8859-1?Q?S09B2fKs9uxR/SYE8LdPdce9QpvXjCLwa6GXganOofZB41F4pQvEx29ba2?=
 =?iso-8859-1?Q?pAAXvznmWyThY2g5Z9OEdqqu3grev+jugmNMm1rfGRWsC0TWohSAsTBAX/?=
 =?iso-8859-1?Q?QNOCmDukl81aZHOpB3YqGdqvNiGEe5hec8XYZBb/shRRwsAyvSCsY3O39P?=
 =?iso-8859-1?Q?EqavRhhvfcE1EpORwRoWB7GrdEuTXILjnBUSIINczHivPnKVLzP3erEQ3m?=
 =?iso-8859-1?Q?CDG+jOhtKKLIcVE45jR45bp24u0lCAyiqZdCeVhBPW2jHHyXIFGgpownVB?=
 =?iso-8859-1?Q?akVVx7w0tDjDwTfPqhRGaKRhVeEoM+r2bGBAryDn1y1mim/bRfB0s2BmVx?=
 =?iso-8859-1?Q?Q7HhgHdw2D2SR/CwLhT0m6gdCMdN7jF36HIrnvtnwhdIeucywHzVsmlhvv?=
 =?iso-8859-1?Q?Fi/9bNxTQExY7FD9LpDzs323aDNisu52gbhKe+vKNewn18RqukAmu6IlUQ?=
 =?iso-8859-1?Q?q4T6qolEHBsuYKTbSSskYAGbO41ynjl8DgH+GP7y1C/OUu/xfgesZjVzI1?=
 =?iso-8859-1?Q?G2o7OpOXBYZYfHJfv3/OFgslM3paSzsOfuite41KXtKhpRROry3XqHB2Cf?=
 =?iso-8859-1?Q?zXLvpBlbUoLdkHNOVhwTPGFGi6R36vPrY8zbJlkD87bJlFJeDydD+IupKj?=
 =?iso-8859-1?Q?weRrtmGIFfQB+4hWWFWvk+uWtmUL67glQuHrh8C0zTdEF/dohblD1VTkZM?=
 =?iso-8859-1?Q?69IumkzLwi3Ktv+H+2JeVpOFo9PHHIWOpFE9PC1QWYE4W85BrpI8PwflUq?=
 =?iso-8859-1?Q?I4OkxrTWJ315IF92Tx7kUqvv/Z1t22StFdBGt3FGh7xSbujUHg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sparknarrowcasting.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR05MB9393.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd4f55b-6be3-41c4-0940-08dc07a2124d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 12:39:45.2653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2366a43-d0d0-4083-9a1a-2c45fd57a18f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBvgz3ba/CG1UuByzaENA+USNQjybV0Rx2ypczRoZYyh6OWAXOfpj2VZIKc9VJrU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR05MB10151

> Please don't send private mails.=A0 Kudos for using get_maintainer.pl, bu=
t a demerit=0A=
> for not Cc'ing the mailing lists :-)=0A=
> =0A=
> https://people.kernel.org/tglx/notes-about-netiquette=0A=
=0A=
Definitely saving that in my URLs-cache. Might need it again in a few years=
 :-)=0A=
(last time I needed it was about 10 years ago)=0A=
=0A=
> > I recently started upgrading some of my remote managed thin-clients fro=
m a=0A=
> > 5.15.x kernel to a 6.1.x kernel. When rebooting with the new(er) kernel=
, the=0A=
> > HP t640 clients failed. The problem is that after the warm reboot, the =
BIOS=0A=
> > is unable to locate the internal storage (so it can't boot a valid OS).=
=0A=
> >=0A=
> > With some digging around I found that adding "reboot=3Dp" will solve th=
e=0A=
> > problem, but because the systems are remote managed, I am unable to add=
 this=0A=
> > boot-parameter in any straightforward way.=0A=
[snip]=0A=
> I'm not familiar with this code (I'm not actually a maintainer/reviewer f=
or this=0A=
> code, by default get_maintainer.pl Cc's people that have recently modifie=
d the=0A=
> file in question), but this looks like a hack to workaround a bug elsewhe=
re.=0A=
> =0A=
> All of these quirks are obviously workarounds for some kind of bug, but A=
FAICT=0A=
> the quirks are to workaround hardware or firmware bugs, not kernel bugs.=
=A0 Since=0A=
> 5.15.x kernels worked, odds are good a bug was introduced between 5.15 an=
d 6.1,=0A=
> i.e. that this is fudging around a kernel bug that can and should be fixe=
d.=0A=
> =0A=
> Are you able to bisect the kernel between 6.1 and 5.15 to try and pinpoin=
t an=0A=
> exact commit that introduced the problem?=0A=
=0A=
That took a few days, but resulted in the following:=0A=
=0A=
4be33cf187036744b4ed84824e7157cfc09c6f4c is the first bad commit=0A=
commit 4be33cf187036744b4ed84824e7157cfc09c6f4c=0A=
Author: Fred Ai <fred.ai@bayhubtech.com>=0A=
Date:   Mon Dec 20 20:09:40 2021 -0800=0A=
=0A=
    mmc: sdhci-pci-o2micro: Improve card input timing at SDR104/HS200 mode=
=0A=
    =0A=
    Card input timing is margin, need to adjust the hold timing of card inp=
ut.=0A=
    =0A=
    Signed-off-by: Fred Ai <fred.ai@bayhubtech.com>=0A=
    Link: https://lore.kernel.org/r/20211221040940.484-1-fred.ai@bayhubtech=
.com=0A=
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>=0A=
=0A=
 drivers/mmc/host/sdhci-pci-o2micro.c | 57 ++++++++++++++++++++++++++++++--=
----=0A=
 1 file changed, 48 insertions(+), 9 deletions(-)=0A=
=0A=
I'm not sure how this code impacts this device, but it does contain a "HS20=
0 MMC card":=0A=
$ dmesg | grep mmc=0A=
[    1.044708] mmc0: emmc 1.8v flag is set, force 1.8v signaling voltage=0A=
[    1.044937] mmc0: SDHCI controller on PCI [0000:01:00.0] using ADMA=0A=
[    2.120632] mmc0: new HS200 MMC card at address 0001=0A=
[    2.122912] mmcblk0: mmc0:0001 hA8aP> 14.7 GiB =0A=
[    2.124810]  mmcblk0: p1 p2 p3=0A=
=0A=
I can provide more info on the hardware, which is also available in https:/=
/bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1056056=0A=
=0A=
-- =0A=
Kind regards,=0A=
Ben Mesman=0A=
ben@sparknarrowcasting.nl=

