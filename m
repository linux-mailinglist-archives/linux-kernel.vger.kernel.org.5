Return-Path: <linux-kernel+bounces-75754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9EC85EE77
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C5AB22BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAAB11712;
	Thu, 22 Feb 2024 01:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="o57G+e1k"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2D211181
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564280; cv=fail; b=n+UTsyZLp7CiCUt75+5/IcyqwsR0XCTQ6w6tGpqAzKwJWR0l91rI2dhM/q8a66w6D+RYqWLyYTYQ/3aELAnAIfWWVvrC6obDLSbKzQBmKpHai4T8BEvszNzuw2xoUIY2OUWJ5kZyp/tQGsQKf0UFkIuP4zPNNyNesHZmF39UoM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564280; c=relaxed/simple;
	bh=Divgb+yNAUqLBQV68rc44r6zKzRsL4vv4TMmw5HXLlI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jhAcNnO3t/lUtWdfohwkDjbQTFD7bbMZSnSi7p8mGZGdFMOHjV7c1s/4ee7yUM0c5cglJgAsnLsAgznoxPNFmvIuvr8LoxoWvdPSRe58/8dExCcBj3m/NQoiYmefuThMlTfwFsuGcJe2SaDbR8G77o9vX2vRoAqKomYPtXii41k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=o57G+e1k; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LMfBkX030647;
	Thu, 22 Feb 2024 01:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=RzWovPmZvUqzwJjkbYBCloIPTIZe+8rZG5rGgapZD/E=; b=
	o57G+e1k2Gq7Njv+59LDztrwKdsM1iGC/zQZKYKwRv3P9wDVDEJgfhGBQnsx+yfz
	+OatUfycfVoOz/dctXkdXkMkZ2AGlHNRGN65hZZEmX5O+HAXflE4rDjxioF3ySTo
	W5m7YlTpX1eP1FxSU9twmxYM02cH7LjeoJZwRYG5+qsnRMJ3faNSgfi+KbdpRNRZ
	fl9iP3DVHH/BMdkCPcPpcGSreCGxDB6/lKH0rKQDXiwbeTrD3kCL0T7lUcv846uP
	XPyrEqnibf9MracmUXsIUmE+MWj2rNcg7e+SLPVFqMzxDvvx+7t7Xjnv+cUrRkLq
	RNuNaZzMrRxFAkMgqn2Ykw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wd218hfat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 01:10:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRAb/xTbfEmU4t2rRjptNxyFhdb5qD0RLbP/91S61DJCAv+XoisrEaK0TOiryNtQJRCfl4z+PzdSb5RgvNIMmfuMvoycs8s3YzUT/wbwy7ae5vAFVoa9XGe5TN1ZJ4EPZ8bqIvIVAgsNsdr1jekbh7D9YoXfuSwn3e4sFFyWBH5MGTOoSkWh7u2taFsMxpkhJUnNl9fjNmUVky8MYzS48dTJJuGXCpcg0/x3yKHUD7Zoom/VUHsk0wj8ydzHj309MMXcUwd+GrHtMlF44r6h3ol+JItwPhzF01jX5BWZWhI0qSzj3vm4sQoK/Am0vQZePnHRlJcLw2YByPKafKgHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzWovPmZvUqzwJjkbYBCloIPTIZe+8rZG5rGgapZD/E=;
 b=ka80lFF06aPRqk1NwNLd4s7J66NUOMjA3Jrx3KlPAB6HZgGeVd3H3BlEAjoaizRk5hI7FntIvi0VOXn2CufN1Uz2deoMQ9zhvQtr4x386uiUvu4HNK2SpUCqiIGzq7b0zxZ5hr9YFkL1LlT9ZX5fR6SNHoqPXuokOeS1UgXZunkyqK7GWKL+dy+7qYHjSIY01KmdyStCecxICm3IzEy3FmJa5gNRcCq7HnEa4LCPrQDpyAzkS5r3eejoC6NVmTDRlUiqx/yDbcpkpbyFdMgPCwJzSTYNrVUXQEMIW0YxNZHUsVMxRVcE+sJtFgmhEbZSxA8sH7sHJcxDzsRUyLhKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB5185.namprd11.prod.outlook.com (2603:10b6:303:6e::11)
 by PH7PR11MB7595.namprd11.prod.outlook.com (2603:10b6:510:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 01:10:24 +0000
Received: from CO1PR11MB5185.namprd11.prod.outlook.com
 ([fe80::6bca:5feb:7ff0:c686]) by CO1PR11MB5185.namprd11.prod.outlook.com
 ([fe80::6bca:5feb:7ff0:c686%6]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 01:10:23 +0000
From: "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To: Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka
	<vbabka@suse.cz>
CC: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David
 Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko
	<glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov
	<dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Zheng
 Yejian <zhengyejian1@huawei.com>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: RE: [PATCH 1/3] mm, slab: deprecate SLAB_MEM_SPREAD flag
Thread-Topic: [PATCH 1/3] mm, slab: deprecate SLAB_MEM_SPREAD flag
Thread-Index: AQHaZB4V5G9cauwLMUeerVHZZ0FHGbEVH8qAgABvR8A=
Date: Thu, 22 Feb 2024 01:10:23 +0000
Message-ID: 
 <CO1PR11MB51854DA6F03753F12A540293EC562@CO1PR11MB5185.namprd11.prod.outlook.com>
References: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
 <20240220-slab-cleanup-flags-v1-1-e657e373944a@suse.cz>
 <ZdZBN_K8yJTVIbtC@P9FQF9L96D.corp.robot.car>
In-Reply-To: <ZdZBN_K8yJTVIbtC@P9FQF9L96D.corp.robot.car>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5185:EE_|PH7PR11MB7595:EE_
x-ms-office365-filtering-correlation-id: 7fdcda3b-37df-453c-bb01-08dc33430c26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 An7QVeMPPHLvsuCB5tWRRpsIMazYNtykSGe0JsCLMGihdG19/WbYSwS9QlU5wy9aJ2+TwITDyCPawMkAfY9woHhX/9npFjqOeUfkw8dHCE3WGo1nn6Zhuu9dhKElpdOp/qrodIqWYkmtp0+t2p8Fo/oywPnuvFxQCeXd5fqdOEaKAA0jproLBWU5FbLMU+WiI4vwxyrR45y8TE9YICSLF7PD4Mlm/ymgPzhob8pG/NAblWYmb+cEsm47kS3kpnAPltCnweNB6AfQ7rnzwr7MPs6YZBTD9KjyvoIqzw1UmHDuONh4zj+vDULAJlZOBxgH9gkZ8HLtprWgfPpwxm7XHy/PKhKFEZUQ/8ys2PZP57LnukPTcAQfbo6z4/rH5/3U66YVipny0Rq3CUrBj3U822DK1m0Ql6Ij81YhqzEUKxgbpz3F9c1XnDxJIaKZL2UeMinl9txwFJ/zAeEFv3h2/mcutJ+3mV48+JYqUgHeghg6WzN+rWSnDCu1AAYb6ud+WxklQsEscXzTaB/udO3JCvwziAjjbbeUpn8FQGv0E/2qU3CPJxPk+tWq+LoU3QGSzktZplwfbIBYSgYPvkGucn4vNO4NXYmn68t7ai7nhu0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Er60AqX8mo46Nrbmh793dQE+qaddbBEpXxIjBOmt0w7L9e36p0Yo+Q8Mqzsm?=
 =?us-ascii?Q?tPp3XLDzI0ZRjVPM032pATTYP5rbF0fEiMw1ZtYngyE1NvGCPPyZTWBqOIxs?=
 =?us-ascii?Q?ArrV3ZSMCh485kn4OJklTOUbR4hj4wJGzyXbBe5TxF55grKduvWIzcXGRo4Y?=
 =?us-ascii?Q?LY7GMQA0iSLWVvnzB0EIBuVj/jQmXhKOEkoz0AoWni0TS9K/hyJjIxpSmTTN?=
 =?us-ascii?Q?K8W5JPIJ/tuuQwrMd4j/ydCYEgHcYa5/Ew7JS8tqL1DsWVAQ7jlCeg8lpY/z?=
 =?us-ascii?Q?M1kytjz767h7s9H1lXCJE5ORona3l2bE5MIPnODx1p6aelV5evvVEPzyLyEk?=
 =?us-ascii?Q?SV/anC0MtHgQggXENeIsmNBQ6R+6vNKSQZVmZiItpwoV1dMJOSLAYFABk1tD?=
 =?us-ascii?Q?p2yKPfSRUQEwHl5keRWK3KZ23TMiHzydCNMtfMaDNC4FvGtr4m5VPEgnrlyp?=
 =?us-ascii?Q?qN9HDfe0c0MhfPZjfL4lpqKxvH4Ht5zdlWTZv63153jJwWQ61SaZ5Czk+/Hg?=
 =?us-ascii?Q?mIRyzmzC5k8lbLukKjHA72PK4mn6pVKH7/LHM07NpL6UxPHM5psv3eXL9DGY?=
 =?us-ascii?Q?/JnXdX7ClDHd7WmqfYtXmjgFlLPziUJVsriKtnrXYcaan1RxilemmUj47jq/?=
 =?us-ascii?Q?HfA36JGEBmfoiUYhkR8vGD5Bb+mOag0el1zxIdKn8duMsi8zGOZM8CWwRT+z?=
 =?us-ascii?Q?H31M+0ovfZAfSCdaczuwFa/uQIRInFqcT7cjonyUvbkKPR7TWDq1+0XsgZu2?=
 =?us-ascii?Q?sBIeBo0fnqldTpS+fUxZlrtO41e4dlbSA9oxQalFfZGS2vD7kg/rxOtWXJzK?=
 =?us-ascii?Q?SFZwoFvOrvDre7O63TMOebupept9gbRthd2CCJTSN/y0DKMeYKz0YUoGP2pU?=
 =?us-ascii?Q?lKeUuXb2fXiuCK+GLDa1W78qkKofWpYaBceEVzLqGRog2uw056RxW83Xvzvm?=
 =?us-ascii?Q?5Z/kaTRKqqPXe3OFG7MEiqoMVEZdKG6IRntzfbmWQ3SvyWTxM8aIWnz4GeR0?=
 =?us-ascii?Q?/6qDJuWMbLSr85UhxP9aFJY9XX9G68SePjT23NWfj5DZFzQbXerTyqJb/g2M?=
 =?us-ascii?Q?pu09fyt9+qwuKfCaExyrhPN/WAZ2j7kz7Ix4t+zZj9Di53LHRG/KkurGYXE0?=
 =?us-ascii?Q?K8kBXjvbWIO759WkmXspI2RsSQEU/DQWbW9MhGoqvByv8PAfkWpPHGU5vxCH?=
 =?us-ascii?Q?XJqn9t4lpN+4uptF3rxHOu5cpM2qgpxAlkwcskAWEC5DURzVvvbzaXxx0evS?=
 =?us-ascii?Q?59ZjgzCE5Jea43TaTf/Q9tvIOjAVStu9dDJEgLxbqHU2ditffxsM/wOPzYk1?=
 =?us-ascii?Q?IiBTA3xC3vtv3uyugNIhCs+tiAps68+tXppHt9L2TtFA1a7MirNjzOW97a7f?=
 =?us-ascii?Q?wGtSChbtJfhTyrr9AxSSid6pvNil3nY0pgBAl55U8gfuRsmr7CwhwJU4CGkZ?=
 =?us-ascii?Q?kI+5nY98P7vi5DZGM1YS0W0r5WdvNLLU923S9y3kqVWP0I+zWUreTNgS5H78?=
 =?us-ascii?Q?E3nbF6Lpyr04Z73Rau8XZzkFotUac9cMylAz0qGvxq16EGRVPG4k3z1hm4+L?=
 =?us-ascii?Q?ky5XLSAHajJQfjMxjtYC7LAvCyyp3V1S8u9zoCSrNPqjqYEU6bxovo+zdrNc?=
 =?us-ascii?Q?QA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdcda3b-37df-453c-bb01-08dc33430c26
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 01:10:23.9306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODxNRSoyYIHzGeKljsflMqmXhGKMkaqseLFaIs+gnr1Q116nV9mi20XtESL04tBA4HGXU+Gkpg57VB7CPrKqGK2cSgFsKlajI7LwWu/cnwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7595
X-Proofpoint-GUID: bTzno3AKQmfE3USkVLx3fNJnpuAmQhyb
X-Proofpoint-ORIG-GUID: bTzno3AKQmfE3USkVLx3fNJnpuAmQhyb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=525 mlxscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220007

Hi Vlastimil,

> On Tue, Feb 20, 2024 at 05:58:25PM +0100, Vlastimil Babka wrote:
> 0;95;0c> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which w=
as
> > removed.  SLUB instead relies on the page allocator's NUMA policies.
> > Change the flag's value to 0 to free up the value it had, and mark it
> > for full removal once all users are gone.
> >
> > Reported-by: Steven Rostedt <rostedt@goodmis.org>
> > Closes: https://lore.kernel.org/all/20240131172027.10f64405@gandalf.loc=
al.home/
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>=20
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
>=20
> Do you plan to follow up with a patch series removing all usages?

If you are not available with it, I can do.

Regards,
Xiongwei


