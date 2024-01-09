Return-Path: <linux-kernel+bounces-20840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8D58285FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FAF1F24596
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116D4381C0;
	Tue,  9 Jan 2024 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sparknarrowcasting.nl header.i=@sparknarrowcasting.nl header.b="dcyK98KG"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2043.outbound.protection.outlook.com [40.107.241.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F923588B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sparknarrowcasting.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sparknarrowcasting.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWx/Lb+tUOwf+iNLqrNrCq6B9aSk8bE/eFqvYpp3mGuQdzi3+gU2KIX06so86kb0dEez1RHqJZGex0uT30GPNgHgA2JDSbghuei9VxZxbKsOHTBmpYxAxCOIWteTfUk0MBxOJLbKcx/8vOkQHuI7IbYPtwlTdHWwvWeZ9Ie8SbgFGR+BbeIMA1blolzxWO3yu+9FGgQoufIWGOHwldCp3fHEkA9iPdFc/O89w0vcoizyIvtHSHSZ04W7/aNpxQ6TOMWUXW7rZX8ucyfjPHP6ZbRx0SjOjGIOEJot4/kSQCIeYRcPh++IufwQv4aP4VRcKD1yUbAAUQqfO0aTaxF7rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z62pONsxfL+qehvWJsejsxIGHGtWU+dy7OeSy78oT4Y=;
 b=Np1i2TCCj35vwlreb/+/6JA26cRasWlF+HNn9qYUjXblm2wNymJoxG/FZM8WvwXJziwFRgxTOUMCzeocIYwgVwIiy7OlGy81/rvuETOKVEnGJsbzPH1/MyHVPl85SE3oe3zxE91cBKibQFUjrfmDM9F0q1x6NYxQM8cwZR9bdTd3DjahOYiiLvFtxTb+0siXtKR7HiazieWuHC4g1D/586oMKygQ2HmQEGWJiZFLBKY6SpPWBJK9iCjabG7wTuF6SezC6lpEsNhBR+EB3wkQeblFcw584UF3cVauPSXYMe4fhE6aPQMVd9YvyM/cSZgoaum45eofZgL8vFkegDnnfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sparknarrowcasting.nl; dmarc=pass action=none
 header.from=sparknarrowcasting.nl; dkim=pass header.d=sparknarrowcasting.nl;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sparknarrowcasting.nl;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z62pONsxfL+qehvWJsejsxIGHGtWU+dy7OeSy78oT4Y=;
 b=dcyK98KG9q8Sck9Kp/IotO4yT2W+0J0LCIGgvpc5b4btbETgNuKW3b0x3PbNcFdeeh7Pz3pT+klqrjS//s3ksmpOAACWsZx/7VuTiFu9jpDft02OehfNFzqJH2YoIcG7xi0dL1Km3Mqn3owectbR/DsGpTzBrCT/VvKXlxZppFurcP+00gDlFWkDdwm+dOZfMt9frSd5LJG9paQwzKYoWzHh5EgH1vB12ybJ/glWMQH607EpH/uJgfNRDmrzGjScMKDiA1Oy/LptMqFYJ06fvwar9puDz08ARDLFQtnsKcvsPaEHZ0YiwJrYFTrxdetfygTYKZGH79n1zCxTpkDP1w==
Received: from AS1PR05MB9393.eurprd05.prod.outlook.com (2603:10a6:20b:4d3::17)
 by DU0PR05MB9865.eurprd05.prod.outlook.com (2603:10a6:10:475::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 12:25:49 +0000
Received: from AS1PR05MB9393.eurprd05.prod.outlook.com
 ([fe80::3017:1a1a:672a:8316]) by AS1PR05MB9393.eurprd05.prod.outlook.com
 ([fe80::3017:1a1a:672a:8316%6]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 12:25:49 +0000
From: Ben Mesman | Spark Narrowcasting <ben@sparknarrowcasting.nl>
To: "Fred Ai(WH)" <fred.ai@bayhubtech.com>, Sean Christopherson
	<seanjc@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian
 Hunter <adrian.hunter@intel.com>, "Chevron Li (WH)"
	<chevron.li@bayhubtech.com>, "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>
Subject: Re: Bug: After a 'warm' reboot the disk is missing (not detected by
 the bios) on a HP t640
Thread-Topic: Bug: After a 'warm' reboot the disk is missing (not detected by
 the bios) on a HP t640
Thread-Index:
 AQHaMnxhIfb+xohLkE2RJYfuBf5C87CyY5AAgAxHDQuACDsggIABNHyAgAFwpZiABb2LgIACPsIZ
Date: Tue, 9 Jan 2024 12:25:49 +0000
Message-ID:
 <AS1PR05MB9393CE09108738B4DE484F02B66A2@AS1PR05MB9393.eurprd05.prod.outlook.com>
References:
 <DB3PR0502MB999347F512ECFDBE3BFA9941B697A@DB3PR0502MB9993.eurprd05.prod.outlook.com>
 <ZYMator0DDfq_moN@google.com>
 <AS1PR05MB939337F702FDD79AFDF18F56B69EA@AS1PR05MB9393.eurprd05.prod.outlook.com>
 <ZZRO4Y41UTNm88eg@google.com>
 <BL3PR16MB45703C79606C6A12CB4B24759960A@BL3PR16MB4570.namprd16.prod.outlook.com>
 <AS1PR05MB93931538EE9A569728EFA724B667A@AS1PR05MB9393.eurprd05.prod.outlook.com>
 <BL3PR16MB457082356327091E97765160996B2@BL3PR16MB4570.namprd16.prod.outlook.com>
In-Reply-To:
 <BL3PR16MB457082356327091E97765160996B2@BL3PR16MB4570.namprd16.prod.outlook.com>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sparknarrowcasting.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR05MB9393:EE_|DU0PR05MB9865:EE_
x-ms-office365-filtering-correlation-id: 591aeedb-a79a-4fe2-1fe0-08dc110e1d04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SuCZ6FTc9DmzbG4HCsiea5G5Bs1av3zsXfiH0ihBMiQz5YyKyA1M/vCHve/6+QEday6F0tnfqzs+Th0jEoWBKtPPZQ0lS3SJnvzY4Gk7gIytcf796EUIsRX2B/LvmUlUl92kLqajEd2FUt03vyZfZClNT2u952IFfNdbUXGuqejDZniiQZwivuRUGFARBNrp7fg3ht3vb2LqhOcd6UVUjnXr/dw0ceFLI9FKX7j7OL0MbfzizEssflvkQ5KVoeL5SJnpvIMRqEFe1VnsKvkTNefwzzT8RqaPP072utxfAtse8Zogqj/bzU/0F90sF5b43UDF8J8DyYYQdvToa5XzvEDMEuX+FGJqBqAM3o0AEbwVkmn+nKAxpl2lRHJxhTq8oDbcMRtcE7N7hfqg4gj2Yk6Uv7eC5mIByRDhJ91wPQjksgKQOg8aB9jXVYaAswcaJ9gGmLXqWEnFwbwiiIyMTdrqH6pUjEcWnPwovMqmXjRZvoGBZeCOtUKNOHBnyIF56GL32d6cLxliAtQNoyHqXQn428moQmqordWOpuokIvHEKmAnLA6a0godt/kGv5pacBfWnGK2c8M0a6P2FyP+x9E8CxrTMsAYNpY1MIMNTlW05Wr+Vw31hpZCnCtLVaWZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR05MB9393.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(346002)(376002)(396003)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(83380400001)(9686003)(7696005)(33656002)(55016003)(122000001)(38070700009)(4744005)(110136005)(2906002)(66946007)(66476007)(66446008)(76116006)(54906003)(64756008)(6506007)(71200400001)(26005)(38100700002)(86362001)(91956017)(66556008)(52536014)(8936002)(5660300002)(478600001)(4326008)(8676002)(316002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?h7Y9yd3PVeCSd+ZLCeByZDwWdkYnKtReKvk0xNd+ZPnGw52w2GF/wig5qa?=
 =?iso-8859-1?Q?y4WhSkTyM4GHQxk5ebv6BXrTK4Gyx/BIDGh9b/r4wnrn9yb7T57xoC3mPN?=
 =?iso-8859-1?Q?tPLUzqLSF2pYHT58AZ1eI+w5mQ19zDKQWOlzdn1w3+h7kPg0y1bshe4pbR?=
 =?iso-8859-1?Q?wK0UwlPcrAu4PzYYlNMK46GT1t5f/jUwlB/otcYAlBX7KFCDFZPG5EQvZR?=
 =?iso-8859-1?Q?ok8WkvXXWcKUFFE4IlAF3en+YrM7yOdk/AFU7cvh5hHeZUYJ7R2EDpHGpd?=
 =?iso-8859-1?Q?fY1CHCisCzKgv81pjCUMKMKW/urfxbLV1TAAHHuCYoGA7FBuft3PGeBOJi?=
 =?iso-8859-1?Q?Q/DKbtuWSqCiZUzo2wKrGT2DYUKkMcPE53n4iimEl9/7skZBsl+Qp2o90c?=
 =?iso-8859-1?Q?zKZngotYePo/4Hs9lCEVPHBYUUzfk4gftH7NOEn8IfLtKN6bwa1KH43fXI?=
 =?iso-8859-1?Q?Ks7jjow7Py4G0bb15cBrMPr1MrfXaoARFPIPZ3TfQLtxWE0CllRYH37glh?=
 =?iso-8859-1?Q?UWQ5v/5x98zQggLpcnnRz2pBX9oBHa0mZZEkRRM6eMU+fW+AYjMAu0HNXs?=
 =?iso-8859-1?Q?HyxMmXu27cMTxDQHJhORQUq2Ela706rjNVC8EviigAQhQ38VPqCnewG0Q8?=
 =?iso-8859-1?Q?lIjcnigrzqd8VriAHZuXhn8WYMp/s8GW2LGBHFuwsYBc577lcyJ/oSYk8d?=
 =?iso-8859-1?Q?UWSmfeoxC1GofMv7SyIzqHyo1nOeHZBXj8UMagfkZh6gt7Ia1EEpOZd9fz?=
 =?iso-8859-1?Q?fQrPWJqvTiDWOGOBu2mulLJIiGlvcUMEWWxslcejga5Xd6iNT/5R4VF5ES?=
 =?iso-8859-1?Q?P9kNT/P2luNva+KafYrCveq/hotPYJq9X20BVptT+kXsH0c28IwuqSAmbn?=
 =?iso-8859-1?Q?8ZGdUi6V5sXc97+u729HovEXOnwQisw4iHFPJYT6N7IBbE31/idHSMPD8k?=
 =?iso-8859-1?Q?mhIYKJHwGZr5GObqvyMSVWXHFp/ZW9hAvXqpGRM7Ax2dgEGiBWqafq/zWU?=
 =?iso-8859-1?Q?B7obdOexhOodXQcYqO3Zjj/b0jouwDUMMy6vKBOQf4cymZ40yYd+ImG+PS?=
 =?iso-8859-1?Q?wc0tMkY87a6tEUZg9Ozp92CahBSUtGKIeJTR0kz3k04Yplh5mgsyWvpXpF?=
 =?iso-8859-1?Q?Ifpf9cKzp9P3WtqYb/e2Nc/XMbUiLdJasuD1RTVU6x98c8v5d6ae+DHAAX?=
 =?iso-8859-1?Q?j2U1FPjefKpSsPPGh3BLwKk025UvSnRrQcyw98ru8tN0fye9fQQ0+0FPgs?=
 =?iso-8859-1?Q?PWXUCfHz8qkj/VGS8Y8Lov7UKiXBDog6RECbUr9cTxuWa3R1sgH92rlqln?=
 =?iso-8859-1?Q?yvz+Rzv9MRhRNLUbKnaD87tRlKWsWQbSZKy3+Hu1U/Ug35PH9bPBzepYPp?=
 =?iso-8859-1?Q?WAqmNqlYOtsrF/x9eI1eLDTDKjucK6Bf4Fx3Vh6M70ank4NIT9ax9FXDP8?=
 =?iso-8859-1?Q?L3idoH0woGUH7EmcyQ5ofNrr8inu0SVEsfrNgCOwI9CChYkY6mSnjURR30?=
 =?iso-8859-1?Q?rawAyG5T+gZBlvQz6NGfRoYdkCX6mKBaqAWDWRKtKuJ7R38ezqRrVlmBwZ?=
 =?iso-8859-1?Q?1DLwYwjr6RNW5zZVHdXXYVV9hDE07sA1QZ3OfPyWd5jaXNNhmg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 591aeedb-a79a-4fe2-1fe0-08dc110e1d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 12:25:49.3092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2366a43-d0d0-4083-9a1a-2c45fd57a18f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mfwg0ktXY9VQTCO0SFtQfotILdmm49w+Skj2OBKgHDnoVI5vmnBRhHe3hkuL7RCx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR05MB9865

Hi Fred,=0A=
=0A=
> Hi Ben Mesman,=0A=
> =0A=
> > I tried the patch, but it didn't solve the issue, sorry.=0A=
> =0A=
> > Do you need any extra info? Any other help I can give to solve this pro=
blem?=0A=
> =0A=
> Please make sure you compile in a way that allows our patch to take effec=
t, or you can add debugging information to ensure that our patch works.=0A=
=0A=
I did a checkout (v6.1.70) and a compile (with the .config from debian) to =
check for the 'bad' situation. Then I did a 'make clean', patched the tree =
and did a new compile. I think that should have activated the patch.=0A=
=0A=
Maybe the extra .remove_slot function is not executed (or only applicable f=
or a newer kernel version?), but I don't know how to add debugging info, so=
rry.=0A=
=0A=
Thanks,=0A=
Ben Mesman.=

