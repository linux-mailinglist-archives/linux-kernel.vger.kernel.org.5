Return-Path: <linux-kernel+bounces-33632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AFB836C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB16A28631A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F4A4A9B1;
	Mon, 22 Jan 2024 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sparknarrowcasting.nl header.i=@sparknarrowcasting.nl header.b="GQ8Rmj8r"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36033DB92
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938763; cv=fail; b=GddiNVwEd6aHdCqvQys6fADnM2ocQlwdMO8QXdYc4bfEZoJTduon0IM5Gmx29b2NI54JNigGPAcOBpW3x5ul5xy5slTJF39dIryYBJytscLlKBaa8U/9KYyFkN1ySH7IyOL6boG9ukv28zQHtagnPBhhFJ1BOkWBii/vqcN/s1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938763; c=relaxed/simple;
	bh=MHIyywpisYVD3KdU/dGP6gZOEN7yB8vDz+QzKZhGQiA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j6aRS4rh/Q/L4N5HYq89VueljUvsrG311vDY26krcjj19kcokGJl9TXheoT1gXiy632rpl86UgKyBAaz/RSY9yQNIBnACMnifzenTA6S8724E9iQ7D0a5KNRiG3ZT8dGzRnzIW2yrS6d20YWirdStVggs+k7Qhx+svsKykXkyTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sparknarrowcasting.nl; spf=pass smtp.mailfrom=sparknarrowcasting.nl; dkim=pass (2048-bit key) header.d=sparknarrowcasting.nl header.i=@sparknarrowcasting.nl header.b=GQ8Rmj8r; arc=fail smtp.client-ip=40.107.105.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sparknarrowcasting.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sparknarrowcasting.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXc0I3QovCGNEV/MJt5TU7rzWsrFEM16Z/uKJGyR4L8sy+3AjluFiJzpuugbDBmFRNe/B7CFyqtXx/JDUr/aOw94c1sRjIug290peJl3S86760cgD2OZyuyu9U41om7muBD3oVUWOtE0rElPX1jueS5fTiVa06vSH+uD2kHYpl/MpY+YZztjRfD1pPJHGSN8kpfYFaCuusy1o12EhOe0F8zBEF9w2Aem6qr6ISxTddvWGCEOL3GTVAu5EXR4xYeF+kwLN7K9GxjDSurmxV+h5s9lnFE8RtzGqVoYYyCdZVR1s7EB7zEZ9Hgx8W5kjEaS/ADSTnX8ms8yM0A6isAZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHIyywpisYVD3KdU/dGP6gZOEN7yB8vDz+QzKZhGQiA=;
 b=k+JIwytQ2gh7LcGnfycRawVtS+09zrKkrQWlnIBX5gtV/4IUi403v+6Du1lXApyy03+G/VwXPFI+KxMnoa8d+fESIYwcwhcPFrDm03ZALdmN2x+rMoNyZTpVlAPnPE+/sp0OxiclBsxW23dEQjY429irIrJq287DqLl9R2nRLU2kxNRZ2cEFwH5Z0RlGle2RPzQHTXTpicG+ociJ5g2I3dJysORte7hhd8w1Fk/l3mkVx/o+pAJ8RGzWpgTb+UBMNJNf9Xrp4EgLSEUsiJdB1KhKkuYp3Zp11kvQ/K/2pi7/tW/uFdrVULgZUjJVHKwPM4dkCRw4jW459hWhOfOzdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sparknarrowcasting.nl; dmarc=pass action=none
 header.from=sparknarrowcasting.nl; dkim=pass header.d=sparknarrowcasting.nl;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sparknarrowcasting.nl;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHIyywpisYVD3KdU/dGP6gZOEN7yB8vDz+QzKZhGQiA=;
 b=GQ8Rmj8rklp6443KNa/WNR0hWCxCOLasKs1JG4R3wPsj5qSy1PhqGE4CaZDCS7D41gvAtM3syMrtyM5GybbYE0LV4FkGTjRURpsAL0c/HZxDZ35+loZhtv4x8unq6JNZE1j2sV9tOZS4NN0sy75TS6LxGwOpqJjR/2bSV+H3o/yQpBHsdfe+4M7OACUt56KSDaTlBN8wO1IeYC0Ic/9uZ0SFIswBAeAWSdCmT0IivEcNaoGGcXQDCYoVhDgRic6qSsA73HcfpZ2E4iN20CPgQTsh8gaH3Yo1lRUn9YYQwPz2UGUn+m8M02UlOnQxzYC97/Kox4/RnvcQfJUXO7U3Dg==
Received: from DB7PR05MB5461.eurprd05.prod.outlook.com (2603:10a6:10:2c::21)
 by VE1PR05MB7472.eurprd05.prod.outlook.com (2603:10a6:800:1a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 15:52:34 +0000
Received: from DB7PR05MB5461.eurprd05.prod.outlook.com
 ([fe80::852f:218c:72e:15dc]) by DB7PR05MB5461.eurprd05.prod.outlook.com
 ([fe80::852f:218c:72e:15dc%7]) with mapi id 15.20.7202.028; Mon, 22 Jan 2024
 15:52:34 +0000
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
 AQHaMnxhIfb+xohLkE2RJYfuBf5C87CyY5AAgAxHDQuACDsggIABNHyAgAFwpZiABb2LgIACPsIZgA96D4CABS5VjA==
Date: Mon, 22 Jan 2024 15:52:34 +0000
Message-ID:
 <DB7PR05MB546127166A65CBC151379B0BB6752@DB7PR05MB5461.eurprd05.prod.outlook.com>
References:
 <DB3PR0502MB999347F512ECFDBE3BFA9941B697A@DB3PR0502MB9993.eurprd05.prod.outlook.com>
 <ZYMator0DDfq_moN@google.com>
 <AS1PR05MB939337F702FDD79AFDF18F56B69EA@AS1PR05MB9393.eurprd05.prod.outlook.com>
 <ZZRO4Y41UTNm88eg@google.com>
 <BL3PR16MB45703C79606C6A12CB4B24759960A@BL3PR16MB4570.namprd16.prod.outlook.com>
 <AS1PR05MB93931538EE9A569728EFA724B667A@AS1PR05MB9393.eurprd05.prod.outlook.com>
 <BL3PR16MB457082356327091E97765160996B2@BL3PR16MB4570.namprd16.prod.outlook.com>
 <AS1PR05MB9393CE09108738B4DE484F02B66A2@AS1PR05MB9393.eurprd05.prod.outlook.com>
 <BL3PR16MB45707B929A4AF86D392297DC99702@BL3PR16MB4570.namprd16.prod.outlook.com>
In-Reply-To:
 <BL3PR16MB45707B929A4AF86D392297DC99702@BL3PR16MB4570.namprd16.prod.outlook.com>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sparknarrowcasting.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR05MB5461:EE_|VE1PR05MB7472:EE_
x-ms-office365-filtering-correlation-id: 3bacf5b5-df67-4880-c4e2-08dc1b62266c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Pxt+1RzTdQjMhCS4yoVVW3MBbrrki1icaLYSsswhQc6mEVrOZ4MFhnF/hOyqxOJBmx8c9qZhpro9d4LdNdBufj/Y1fmEQLCSpwqvDAFp2NzuTYsauoo6981rv/+Guzsdevhz/fVF9AjOEvKJJ7GmE8ZQ8F/FIon92tLZhwUdX9a5MBEp6dPTzCSnYVsNXQyt22F/K62fV5LM0FHsUW/EwUNHZw3Grk+Zmy3EahrkLyRXAfXr8u0sLF1h9CO+wt3hmlI3k+6RKuEDbOfcXC38QQFr3OAIF0rJGQAlLJ2QDWH+36u9azEHM3f7k1t3tO1/BG4w0VZjndbDeduIKtLKZPLAdQ9Tfww9gu1agGp5Jzk3SX8JUC2JY5pbAyr58ghHzlF+8kUMbZ0gRKga+g3ZBu0RTcOH6+//3uHlKQbSjz3UO7/ap8LdxXEczMLnLK6jMMJhItosDgo2bm5kJHR1OwSplRMCJGtyUVOm1a7+Ctvb1uzzuxbiZDf2lTsBJvtLoKMONw4eUjoUEGXx6vUufefbhiNxQ2IZrdap+jozl1WWzhcoRU6k8G5lYLewrL01IWIX3ilW9XfMmep4Zofh2VDRuBz/u7Ta+uQ21O5wWBx0Gzu+FU5psSBSrz1YaYls
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR05MB5461.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(346002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(7696005)(26005)(9686003)(71200400001)(6506007)(83380400001)(5660300002)(122000001)(7416002)(52536014)(4326008)(8936002)(4744005)(8676002)(2906002)(66446008)(91956017)(478600001)(316002)(110136005)(76116006)(64756008)(66946007)(54906003)(66476007)(66556008)(41300700001)(38100700002)(86362001)(38070700009)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?r/QQgzsKENlAJlxbo702HL4VBNc8mGqW6TAx8S30ORmlT7h4aekiHIwmai?=
 =?iso-8859-1?Q?MgvvsjI4V04dpiKHJfsFP0hayysU4tEQlvsSrzczG/Cg/Vws2WOw3Kw3Lr?=
 =?iso-8859-1?Q?+2LNH/0tSHNEBHIlX8ig6kJGOo9ObEeVOmi/U6lLVgzoJTyd+ygjF26v90?=
 =?iso-8859-1?Q?3xRiLxMMXV5hAvdxVYR5V7SK36QK8mVuLGjQJm0yCJoaxfrN5FZYMbC55U?=
 =?iso-8859-1?Q?yKWZS6aIeRjwWfSAcRWAl4fACpk/tEViIT19y0+C+w6/vCB3W+3iBQ0jnV?=
 =?iso-8859-1?Q?QJF3NBRF2i97CXv6+rIj6lqdMTJLIbbJvNVbI+KyYy7B9horM/6WS4VBiU?=
 =?iso-8859-1?Q?CNoxdNorYZPF29nw8SvP0XMYwnuoCJ8fHTyprf5swgp+7M/31VS3VLZe8w?=
 =?iso-8859-1?Q?hrZBfZfFmmRNdwZqeyf+AkNxRXjE3uhELdLfm3bb+VqDyNZb/W8YceRnfw?=
 =?iso-8859-1?Q?zZ4OCjzvPSwWvCkeo4xXSi/PURrjHnYUa6TFBwwqbApe083os94LSmx3ZR?=
 =?iso-8859-1?Q?jG7LZyvb7nXeiFioNUD2Ou+wsglxNjea6cmW93mjNm71H4QySbrHc2cB7y?=
 =?iso-8859-1?Q?cAdSLMXZPw+0y7HfxABBo+9ICqih4oELhxz0Jl9JDMuqapqnzvcc2oto9j?=
 =?iso-8859-1?Q?UvGXOp7F/wK+LJ1Fwo3amYfYDIemITytn1GqPm8dEkN6NVbivueDvwzHBl?=
 =?iso-8859-1?Q?EqsaAg/oIinBmU8cFM+lNOREDQ3emjRzXKJrBjnfptfgtd+lYjj3GWKQUk?=
 =?iso-8859-1?Q?p8dLQuTV2DQILf+9I5ZWwxXPz1qdpt0wI54c3kRfOqDkyubAhBB+Y3zVns?=
 =?iso-8859-1?Q?OjvDZbkFna5+vgZ80oAXL19aLRUzjp5gcp7/2sDjyKZ6LB4MbXXdLiyf1E?=
 =?iso-8859-1?Q?FdwjY0quNPpOOiBZzNeA+arD92s/jpyyh4sORRpbN8nGHaCPZD5qC40fMg?=
 =?iso-8859-1?Q?bU/rrKVuGiKv8UPXsYOLaThiZlcVpe4oh9AlBYeyBSzYaZpLmRu+stbI6e?=
 =?iso-8859-1?Q?alPfPMPhlTjnRoUbGUgrZ4z4MpjWZJgDApY0ERA5LXbxmOF/qMScjTBKPW?=
 =?iso-8859-1?Q?4hjIWp9IHPpfcFTbPQtz8cYHVbsJiroCroXxSirEiIc/Qz6awh+2ilOEE0?=
 =?iso-8859-1?Q?z+FG7pR3JcWOCmn/dYmJqPBYCW0HuKCyZrxWzUImls8P76XMPNY5Ti8QfX?=
 =?iso-8859-1?Q?FUXKo9rhTYK8KrAJg1+PHOcDp6pzK/JdJ2uwRkbhZmcDRL40QDJNkfDmjL?=
 =?iso-8859-1?Q?5xa2SI4aez35UcFMu7Vkg1ldnADXj5IM+8ITWz87LR0VbyCmqCrTUBx6p4?=
 =?iso-8859-1?Q?41sz9JIyAadZ8EWeoAm09XoUlTgablrzfFm5aSAiPmTtctn3165LpMRhZs?=
 =?iso-8859-1?Q?av+hZ39dd2bwStrllHezg+v9cZbFLgp02lGBvH4Z8xKkBoscx2ONow1oHw?=
 =?iso-8859-1?Q?IOpqzTnpGse2m5ofsrWKpmVWuG6uBmEu2LYfLwd8ulBu39G+NG2Yq5URn4?=
 =?iso-8859-1?Q?UG5a5ui0FhsGULCdrk3FcG3AmvAKuGQtDPgp6CFGdKzENCV9HPYl5kXfPD?=
 =?iso-8859-1?Q?0AxwMUGuUTgeONUXph4KdAW51votBjMukiEJPN2EnaTuSnrSJQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB7PR05MB5461.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bacf5b5-df67-4880-c4e2-08dc1b62266c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 15:52:34.5053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2366a43-d0d0-4083-9a1a-2c45fd57a18f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhVPdy+SA9BnQUcoJDa5jEvCzlm+iBK2mDqjYjo5nSAdJPqoI8rC2Hvwr3jGjeE7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR05MB7472

Helllo Fred Ai,=0A=
=0A=
> Hi Ben Mesman,=0A=
> I changed the code by using "set_power" to recover clock source when powe=
r off card and provide the attachment code try to fix this issue, but I did=
n't test this path code. You can test attachment patch code > and give the =
feedback to me.=0A=
=0A=
I tested the attachment and this patch solves my issue, the HP t640 will no=
w succesfully do a warm reboot. Thank you for your patience and amazing wor=
k.=0A=
=0A=
Looking forward to sseing this patch in the mailline kernels :-)=0A=
=0A=
Kind regards,=0A=
Ben Mesman.=

