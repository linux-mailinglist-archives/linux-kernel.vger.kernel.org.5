Return-Path: <linux-kernel+bounces-2897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551FC8163ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A07B5B21B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5561FC4;
	Mon, 18 Dec 2023 01:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="YsL7Bpw4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE07A1FA3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 01:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI0jFK7007922;
	Sun, 17 Dec 2023 17:03:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=KXX4iixkN/mAmWty4PRHFvK8naY4pvj0L2/tA2FYvGY=; b=
	YsL7Bpw4rJ/PBLUggERMD11OhzpXxt6Ew/lieh1arnW9LLE8/ld5JeXvdNCGffG1
	PYE72iTfv8KnLmzdWjTNDNkgn/6q33APEnMsB3hmT8LO9sAwdKV9GlyuZbSG/lJu
	75coAxccdNwHvJGv6nV+U2Fr3WrUumK9SAaa09GbxpF8uV4Z5j5GKp0j56MKuVFE
	5z64drtO3QxHzC7Z78Q3Zqmpx4uTQaptRrZcos/sxMjf+c+0MaxeM0xeaeAS2BZo
	X4gCsZyRCPo5YVv0/IX2ylz6GF3o4RUPn2WzZGDQrU4fvhEn/ZQd9/zWWOrz/Gzc
	zb4xwSVtNrpeDcAChntgUQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v1824h7v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Dec 2023 17:03:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OC/GFWwgL0cvaFP/cveOa/bQNxOnF28Lc3Vk6x/lwu4kd6h3PovgYQfl7bRZ5SUWBmAT4W4vSD0oKfq/zTX7LZIZbZeSV4WL8MmxB6BussVY90ZInSNsHEQMw0jDF03x3fbreu57tURk9JngnnSBnhOa2m0fSK9JDbHshF+tSB3bCaUlpVYF9wqXCWGNuoJP6ti42CFIov8FMingZLgxWx9E0g2c7kFisaJQ6i2JvzboYBLsr5dAj4cPGNYQ7cS9JTFUGXKPcY2fw1XPnxGzQjlUGie1QofP6GP+Ab4C4suqlQW290e5Qg1K7DURX0v/AbV5R0xfIlPEEKVsU7P5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXX4iixkN/mAmWty4PRHFvK8naY4pvj0L2/tA2FYvGY=;
 b=O2PZzZP//HUkcS4zFny0r+3uWN5oagzIMgEcImB3nEWGbdvUQUr2z7c/YsbYE6bQDdzLs3dpsU3aE+c2TNw4E5rlZ0mEpGzCALtPNEHoWt/Uu6/8BKLhMWgVI8wpBbS5ghODCufl5Cgc81ff67uYdP8N8Vo/i/4xQ/CY0SXMghqfus6I73XHNKJVOTncEw0/VztHSpj/+SWwxyAIC8ppxSJOTVWbBTPDWIOEKiU6+cjGxop/4h6Kt4BiKpntmx05yNFp6tD6n/zL4ryznjC8+dC2TbIlAqWcjwtOO6dPjsZBk4Be9d+Owh/lmCUORiCFha8JRM0zDfW/qC0fKaJ8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by DS7PR11MB7886.namprd11.prod.outlook.com (2603:10b6:8:d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 01:03:38 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91%6]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 01:03:37 +0000
From: "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To: "Parker, Amy" <amyipdev@csu.fullerton.edu>, "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] slab: fix include indentation
Thread-Topic: [PATCH] slab: fix include indentation
Thread-Index: AQHaMLlk1MmNKn6Zb0KQLeT23KdZcrCuOdag
Date: Mon, 18 Dec 2023 01:03:37 +0000
Message-ID: 
 <PH0PR11MB5192B04F9FECDC6F7460EF2EEC90A@PH0PR11MB5192.namprd11.prod.outlook.com>
References: 
 <SA2PR08MB6716A0570D4EDAAD4221A7788191A@SA2PR08MB6716.namprd08.prod.outlook.com>
In-Reply-To: 
 <SA2PR08MB6716A0570D4EDAAD4221A7788191A@SA2PR08MB6716.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|DS7PR11MB7886:EE_
x-ms-office365-filtering-correlation-id: 21c04161-6a05-48fc-035d-08dbff652a7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QUCut/vzH/PnucE7DSw3ahavdJHSeltKi4a68anZ6KxuSTll4F5SciUQT4sMk6KbeHBz+MGj4UfhaBJxPciqy6Sai04gPLti/4EUaWCU9oT4jVYjXw98dbPgCRkvI/l73Wjo3immJsem+X9LMhMd8mHZxJ/YA9iTF4p5a9rRAO9BLXhU9ATxcZZDtKEtIoALiCiAKKfnJMHVzw4hkwutZxSWyYZaUHl9u7L1TBS9jnCuqNzdLEiXA9VolyQpuSFuNgTRBLxFHExYtS7B8j6nC2kYKMDaJsI5sB7K67wVpII4YX5SfPuiv6ShIwLa5DYTYrFPaoyf7S0AbU2lIp5qfB0jQ88KEiS9lBPClrhfi5N1MMSkZFeddLCg0o1cAc9Er/RI1uYe2YursFtTQS6UD1Mw6+NhHso7PbWvlHaX+lcPXhWPcxfnTzcPmggRXaniTS3JxvWxKaT7Ru7hfckwbDpbl0Tcr1jwANZfytdmPTsnE3LXU3TtluHVHHti7nsZNvI7d3xW8IBN6MW2YYTMDKPQ6MPAT4BDZM2969cfYBgUnyftVp6U6K5MQwWDoO1eSomFl3UC3JDeJjrv4CdOfOKBBqW7cY1FOEyfTx1PSNs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(396003)(136003)(366004)(376002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38070700009)(55016003)(66476007)(66556008)(64756008)(66446008)(76116006)(38100700002)(122000001)(33656002)(86362001)(66946007)(83380400001)(26005)(5660300002)(9686003)(53546011)(6506007)(7696005)(2906002)(316002)(296002)(8676002)(8936002)(54906003)(110136005)(71200400001)(966005)(478600001)(41300700001)(4326008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?5MSNCukfu7tE2Wn2Qewb9zX0e7+WjmkSjeESdImKPb2yh0p2d5pzG6wgrYBi?=
 =?us-ascii?Q?ymGK2Fai2LDrUfIMWeTWMefurK1VCXbnWVbSL3x6j854q1HwhSZbXMFLD14b?=
 =?us-ascii?Q?D6psXCOs3uN36T3wns86U7HVdaFmpeWBqYXa2oTjxLwFWtfX6JG9P7ViFNUT?=
 =?us-ascii?Q?XTvyzg7+b6uppVoacaX0C5rsTEEBRvzKi0b1KGjZLomhKaaXiUvCbvx9hyBj?=
 =?us-ascii?Q?dzg5LW1G/RyHK3CKzKuoCizZSaRyDTg0AA9e3D00/51o7YFnGby8NHxlP+9u?=
 =?us-ascii?Q?62fhgHP3T+iBHXeK69T1Cl2brtfTg2OsS8xYqQFklwxW8iveIkG3fX1BwoUp?=
 =?us-ascii?Q?GMaOLn0vNosQ+YbZbq1ar3Q08qF4IIbImSJCiSBYqpanZGuXpzLBe+/yMRYu?=
 =?us-ascii?Q?EzWBR/rQzTPTv++QMCQvxbUKfaAa2aL2g0y2tjhB+dcBQp45JOGAPfPnU4Jq?=
 =?us-ascii?Q?GJmIuZRTOgNqFmAm8KCEdhK84ZS+enJWLzWluR1yFZ2IbrJvIEfYS+3urPvv?=
 =?us-ascii?Q?Wyr2VBZynNvaeIsY2z0JvxHaLci/8DFS8WHQqNZ8+BK4+m4EPmN8jAdpTckH?=
 =?us-ascii?Q?CUrXB5Zg2ZyUNZ/X5oM13/ct0Uyy/wlFCP5WM5J2Oqv9ktNGNQUMOo7qrqbC?=
 =?us-ascii?Q?yl2UIwNMGXi8aW4Ka7skp8pdtbWR2HVuvNqmStUmj11MDndxuIbS9aQAeMjW?=
 =?us-ascii?Q?4FmCYlkN8VrmKwlxFxLAqwN1PK10e0UF5KpJYymXR/Hb2HIG3ROlOTuFeZgp?=
 =?us-ascii?Q?qgM5+JnuAZxpVNjJQO8432Y9AEVLNr74uYI2hJvzOjdJxO87YGz/VDS1+f2i?=
 =?us-ascii?Q?A58SDdlQ6Y0eHdNqqjty7eNZvNr8sRsy0TjAE2htCb0F7VKr9dE9GbsShXqB?=
 =?us-ascii?Q?Qp6zzWjkT2o/CA6roJ/DlCvmO3UZ+hRtjrLW7+XFgKSjKec+SEb8kVvTJrLb?=
 =?us-ascii?Q?p6Ww7GFa0M898Am4SFgkbxKkuiJE6dcP3AnTFw8I7+TxQq0Jv3gr0T+ZH1fN?=
 =?us-ascii?Q?dUL1UzueYlZ1FaIeiTi8t5V6uW6GmhYLHtxHjMt80QOeLMErdXpNU/9jSKEv?=
 =?us-ascii?Q?FrpStCBe0EkgoklpGBhzsOPS08oewGHxJBnRxXBsNhZK/JCFBp1rpyrkmWiO?=
 =?us-ascii?Q?wp13QoHT5F9Uk8GhND1EB5gshtJqZJ+7+tuK4Yf4x2HVJIrcabqgM08YT2FH?=
 =?us-ascii?Q?haaxEFHcL6QwVSNCiiKiV5mwe+8vfqzIFfOjeV9CJLnNROdR0Kn16rAfFlCW?=
 =?us-ascii?Q?tzVGj7stxfIHT/3MjbqxEFpqBt1p4HzMdXmTttIefXPBI4m4wgy5wydDyKu8?=
 =?us-ascii?Q?WARSiAb2ETT9YMKRDlKltbVzMbZ4RTR49+yTkoW0GTCmiL+UQHSuvPEVcfbu?=
 =?us-ascii?Q?gkj5xgtO9syzdQkLADL5MYtMPvMisCraI/xJR66ImyeLk1DB9gS1SIsUsD83?=
 =?us-ascii?Q?ptstkJswhWODwsvixRYF0FU1p6xs8HY8GEQKukay/DHLZefYvaKLlyGxAzPn?=
 =?us-ascii?Q?A1k8etYodqJy+u7quI4oZVHH1i2WnzNpyGOk3n2eeUTnQKkV/vnBbgPyrryp?=
 =?us-ascii?Q?tCytroJHDx2X/m+z5DF6cHtV3KvFbo20Vb3CRqoB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c04161-6a05-48fc-035d-08dbff652a7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 01:03:37.2109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2T6zWjEjR6lDIq9zf1rPZ3VGP/wmwqHnXlMZAAt2uClsRumJgSH+IueLt97DKjQfEAggYx07khOZHQMctjGq2fZ8FnEGy0dkkqWMgo05yac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7886
X-Proofpoint-ORIG-GUID: JN2xU0lcKaR-QI1GfcNPFvCkgohbxK39
X-Proofpoint-GUID: JN2xU0lcKaR-QI1GfcNPFvCkgohbxK39
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=870 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180006

> -----Original Message-----
> From: owner-linux-mm@kvack.org <owner-linux-mm@kvack.org> On Behalf
> Of Parker, Amy
> Sent: Sunday, December 17, 2023 3:23 PM
> To: cl@linux.com; penberg@kernel.org
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] slab: fix include indentation
>=20
> Include directives in slab are indented by tabs, except for
> trace/events/kmem.h, which is indented with a single space.
> This aligns in some editors depending on tab width setting,
> but on others causes the directives to be misaligned.
> This patch fixes that alignment.
>=20
> Signed-off-by: Amy Parker <amyipdev@csu.fullerton.edu>
>=20
> ---
>  mm/slab.c | 2 +-

The current slab allocator  is going to be removed.

https://lore.kernel.org/linux-mm/ZXEx1%2Fp9ejRmkVTS@localhost.localdomain/T=
/#m1a5899625baa61ad31a0e99eea6fc02258513ac1

Thanks.

>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/slab.c b/mm/slab.c
> index 9ad3d0f2d1a5..e09c44f5b5ac 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -125,7 +125,7 @@
>  #include       <asm/tlbflush.h>
>  #include       <asm/page.h>
>=20
> -#include <trace/events/kmem.h>
> +#include       <trace/events/kmem.h>
>=20
>  #include       "internal.h"
>=20
> --
> 2.43.0


