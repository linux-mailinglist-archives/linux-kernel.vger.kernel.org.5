Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED0B80B4B7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 15:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjLIOAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 09:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjLIOAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 09:00:30 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D1EED;
        Sat,  9 Dec 2023 06:00:35 -0800 (PST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B9DZ3J6000632;
        Sat, 9 Dec 2023 13:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=gxUUQZsSKMWx3056Vvk6gt2fMgnrZKnYtKSZ1WBsb7o=; b=
        h+gR3r9HwAoTcqUnkk9/Z1gln0owe46TWJwtbThsb60X0meLBsb8AfJui7BN4VAK
        z8fCotaFuH9y8S7VR9HdVWLv1Nf6SvEHZbdbl/5lgtihHiqS5uXXgWYwWzsFahah
        1swhNoFgv3IRobdDG/4GR3pUuQgSLVV+0pE1q0v7CONp6DbXAaNqwgxv9TfP+9Pu
        DrtB4679qiC/EHx9skZPKsvnC0QbY8Rxqu0T56GZTNtUloguHRbF/q8U/R8WxGbk
        VqdbkXGGgAsvKJdg6nRJjE4qixKW/dQO8Ffm/i46gY4I3FNbVNnk7hMfE9k+l/4D
        FC4+XMRxYGkA855qiJl5jg==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uvf760a0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Dec 2023 13:59:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ET2+N6Rv0KqA7+KUILfWxNYXylD0nD4x8Jf9ryWeRBQOwMqkDkqR5DF+ZCz2Lm/DhIv/C72kpb5TUZFpBLw7dtCuv1rIdqNnutctDNb34XFPPRAIs76KX0DVQ4ebrn6Y7XyAjUrxiE0m/OCXrXsu59hAt1/H36r7eXJBK7hQ+kPe7+zJOBfRHFHMc4k7GOim64KmznAzT1stfHdupxo/11+nlqHKv31+pJxuS4cxezZCmn9WoHikhRRaS1mj2Ifq5AKioWLRjuu44moniw/vcffIRARElDYjqEAmLxB242VtMhtirByVM8ZcImvEksPCODvrIQ5HgObaSTX/TuTHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxUUQZsSKMWx3056Vvk6gt2fMgnrZKnYtKSZ1WBsb7o=;
 b=NQAxWY3kP6tyOTneYq3ZRU9K/jb64lFmAkfCMd6290xi9oT25TXkswitu3WyH2GpU4G8tKbXjrQOvJc7xmHZoNPpJf4vR2BLXWq4IJHol4HGo8sq6VMYOsPiEGn2MdwLPtnk7Lji0HdoP53bHjzcmtnIe3BRD9D00pVplo/QQaBJwhJv5z0v2ckLGasGGzbzh1PAF7PBrp20XOjHeOQEQ5pIKdhzyX+mGbJ9qVSKZPFStlb4gVoqHX+4KCT9GAUP27KBm75Mxl4F/GPo5JYMGW1nSOubyMnmb4IXnYHfNiYG9dBPBLWZoIjqw0mU4yfP9CFaj568njygYFjXCIPIHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sat, 9 Dec
 2023 13:59:48 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91%6]) with mapi id 15.20.7068.030; Sat, 9 Dec 2023
 13:59:48 +0000
From:   "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To:     "sxwjean@me.com" <sxwjean@me.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/4] mm/slub: correct the default value of
 slub_min_objects in doc
Thread-Topic: [PATCH v3 4/4] mm/slub: correct the default value of
 slub_min_objects in doc
Thread-Index: AQHaKqcV8dGsEfjopEGn6BLZnPOw/7Cg+bOw
Date:   Sat, 9 Dec 2023 13:59:47 +0000
Message-ID: <PH0PR11MB51928F0D78863B3E76457622EC89A@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20231209135203.303508-1-sxwjean@me.com>
 <20231209135203.303508-5-sxwjean@me.com>
In-Reply-To: <20231209135203.303508-5-sxwjean@me.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|CH0PR11MB8086:EE_
x-ms-office365-filtering-correlation-id: 3c25e55c-a86b-4719-448f-08dbf8bf1b0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FJtbVQJLp8c95ZwfsZbJTT2XheGoGNfyNHNWMwQpBq/pXgF7184oyNpWDASgtkUnaUzFvnt0yFCRn0v61YG5dUugVjvNlXgK9jt8mADe14vObgUH8FnbqyscFc0MmEjnUC1monQL4QoVndu2KBzzkkEG+xmXU8+Npzz4bYmXT1sa8rxqxtWg5Z2EEDoOqHv63f7hnkpB8kJVqJ4nyHr/F6zSDP5SL6zNMq46PEUdDCwYguUtNZpjFMFJrLuJc8F5pCoP+EeeXPvFiTUW/VwFTF5yYpxm4ggn8k2hz+/m46RoCu68ORGHAcLsZyDA+ZuNvE0uDk+ml8XIhF8nfVVQJdIduR6JmIBFI/mWPcDjA1Q3raRtKFVajazgTv+Jsu+JCrxw74bBVz0tqKKWD8NzfieMOKc+zJuTfagF3q715dvNiHRGbxh0VisYzMUXXwjl/J6tgS7unPv5ASVgS2Tdd+6UjAyJat/pAdo49gXZxP3XjAEtbzupJRzQFEwJJsZ7YPcg6WItMGI/Coab/rxRu54LMkhMV2Jek2ViwckvBX5Lw/8Xja1ML15K2FhWu2+XQPCmiseeWhZT/9qxaPKjG+dzqNah7scWwayL0MLwgI9oFSdUykkwT1JO2AVp9bZr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39850400004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(66899024)(52536014)(38070700009)(9686003)(2906002)(7416002)(38100700002)(122000001)(86362001)(41300700001)(83380400001)(33656002)(5660300002)(71200400001)(7696005)(64756008)(76116006)(66946007)(66556008)(66476007)(66446008)(54906003)(110136005)(316002)(478600001)(55016003)(6506007)(53546011)(8936002)(4326008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OxzN7wVr6IA8ilb9a+10Ta0DgrAJ8eBY74ALoEO4Mt836R27VEkzwtQYRb3v?=
 =?us-ascii?Q?2Yc93QRZ3zjVuzrOQYg4zmy3epdpuvR01AdbE/sIFqoPk8b5hch6eKKHtUPt?=
 =?us-ascii?Q?7iWQo/Jcj8v+92hvJ6FcpWTSzA7h3cjtYhS9iJCRz5Wdd8gvNnWuWbxvKGXV?=
 =?us-ascii?Q?T4MCYR+M8fElWhitR54DFtQY6X8YtWuWPbi3UQk1of0KuvhBuQ/p2/TLKf55?=
 =?us-ascii?Q?6lJnDdysQMeAW6+9IkEyPBFolO5R/oYxgIjagjQ55rf93k/rVapNJ1uwKgOD?=
 =?us-ascii?Q?kYXXR/WM9774gtsRYY4/6Cs1udb1wOLsjMUn8MoxsnM2oYnRj8LLfNse+JjZ?=
 =?us-ascii?Q?VhARWb0FzTiMMDsdvQPWUUSX42Lddi8wvEgKPWg65PMS5O2McgLkIP5zS7a/?=
 =?us-ascii?Q?spIqnd4rpmq+o5K++wLgTyAtEjS0eJVwCxLorXPP8GCsi1+wqu/FnM/Q+Mag?=
 =?us-ascii?Q?gZTR8tbeNPqAuzNnPPtJur2HfG21qO1FHUlJwshDu85Y9rmLEFWGnILRxDBp?=
 =?us-ascii?Q?4E/eWz8VOyXbfpB4WscNcZZAkGOme5Wx3ArSDO69ePMzNxpMXmTCpq277sl5?=
 =?us-ascii?Q?zSNp4co9y8MGggz8CtjvzIjx3D/kg7PkV863cRi1ngayIaaCByqgnq5DIr9F?=
 =?us-ascii?Q?JnAZkFZfjlmnEer5awh2TEZ16PzFhDmff14hLKRpxQGV76qiXQvjELZ05OeZ?=
 =?us-ascii?Q?KBSU366kxRyf35hjG9QAEtY96yj1oGoP0gEE487iydCCHHR9J28EBt4mNEXW?=
 =?us-ascii?Q?5P4rsyz6nUzQaCau1Kh/W6iQo869zDRaY/4J6BBrOrpxd+s1MFmgIRZt176O?=
 =?us-ascii?Q?Fr7JDFLgDLi0JTbLg1xsvH70v33iWCkll9ORaG4b2prf8LeYiysur8ccTli6?=
 =?us-ascii?Q?gkcpyMS+32QuY3wPnNhRGeuYVrDC+byh0Rm76dVU79vKb/NETLz8J3x3ffoc?=
 =?us-ascii?Q?vCSry+EG346HSHZs8PAS4X89zcF/hLaGqOqR0hY0PsNlUAr8PppJGqC9RWkp?=
 =?us-ascii?Q?pLb1tVc6PgcBxF801VwYofbZhurCnOEVQw6gCT7olhO6bLxTE+Jun555PMGW?=
 =?us-ascii?Q?8nWKsgbA0LgD4S1OU3isNgCqwhQWFL8YLwCuetXxej1d17As/wfJuIdmaAVQ?=
 =?us-ascii?Q?CeHDaOM+f8ML2uOmjpe5otLrVpZq7qjGiijysaupLDhtinNO5fMnWuUfU6bE?=
 =?us-ascii?Q?2xPYFGX0xIBxrPPXBebWFQBXzfFaopmAZM+E0LEnSIwXgMt6Rhf4831jRGBE?=
 =?us-ascii?Q?Mtx8Oyqw4sBInM5+eyasX65/anygy+Cz3NOlxS/5FHb7PawypJdcH9VcVbYA?=
 =?us-ascii?Q?sDMEySJXCKS8tcE1d7ix6dgr5SwftIqprrBL1+gGKrQanw25EzHXUXxgqgI2?=
 =?us-ascii?Q?3JJQ63RhhPnCLnFY00e8uwRQxMuTZxQOFCzmTcq5wlJU5EOSCeNENCqjYsh7?=
 =?us-ascii?Q?E9bIo3p/z7x4eCQ8J82oY6kZdmp4POKCcZTGTD832bwuNg1IP/ctWcgtxxhl?=
 =?us-ascii?Q?pyw2ZpaS0P0ghquGsp0/ezPpe3gtoXl1dRadqrxIAMCUkxs8APrt4EzNkqR2?=
 =?us-ascii?Q?vZViWb2NfjbhBDM3GW5uWR8QLI4LmKo07kxamSFSxXYC8fQOzBrdmd7SmyeY?=
 =?us-ascii?Q?+2Llwm6w37c7WEQ0gVeMt1EnnU/33VVBTAdBC3ejm1/xXiUxYFlh6I4cGfXU?=
 =?us-ascii?Q?4CpyJQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c25e55c-a86b-4719-448f-08dbf8bf1b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2023 13:59:47.9012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DvTgFdBXz5JDkK98TxcIr9M6vHuH0uFu5/ah4rDJAAbz8z284S4I8MjFGYv2xcx6RJlIlZsBz6A8gzb9Gujbi8sEQF+9oLINuI87c0T3KpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8086
X-Proofpoint-GUID: Fe09WIa3KjWJO4sXJt91qkoPu9zoUAi2
X-Proofpoint-ORIG-GUID: Fe09WIa3KjWJO4sXJt91qkoPu9zoUAi2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxscore=0 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312090121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlastimil,

I didn't change description as you mentioned because slab_min_objects doesn=
't
save the calculated value based on the number of processors, but the local
variables min_objects doesn't.

Regards,
Xiongwei=20

> -----Original Message-----
> From: owner-linux-mm@kvack.org <owner-linux-mm@kvack.org> On Behalf Of
> sxwjean@me.com
> Sent: Saturday, December 9, 2023 9:52 PM
> To: vbabka@suse.cz; 42.hyeyoo@gmail.com; cl@linux.com; linux-mm@kvack.org
> Cc: penberg@kernel.org; rientjes@google.com; iamjoonsoo.kim@lge.com;
> roman.gushchin@linux.dev; corbet@lwn.net; keescook@chromium.org; arnd@arn=
db.de;
> akpm@linux-foundation.org; gregkh@linuxfoundation.org; linux-doc@vger.ker=
nel.org; linux-
> kernel@vger.kernel.org; Song, Xiongwei <Xiongwei.Song@windriver.com>
> Subject: [PATCH v3 4/4] mm/slub: correct the default value of slub_min_ob=
jects in doc
>=20
> From: Xiongwei Song <xiongwei.song@windriver.com>
>=20
> There is no a value assigned to slub_min_objects by default, it always
> is 0 that is initialized by compiler if no assigned value by command line=
.
> min_objects is calculated based on processor numbers in calculate_order()=
.
> For more details, see commit 9b2cd506e5f2 ("slub: Calculate min_objects
> based on number of processors.")
>=20
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> ---
>  Documentation/mm/slub.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
> index 6579a55b7852..56b27f493ba7 100644
> --- a/Documentation/mm/slub.rst
> +++ b/Documentation/mm/slub.rst
> @@ -150,7 +150,7 @@ list_lock once in a while to deal with partial slabs.=
 That overhead is
>  governed by the order of the allocation for each slab. The allocations
>  can be influenced by kernel parameters:
>=20
> -.. slab_min_objects=3Dx          (default 4)
> +.. slab_min_objects=3Dx          (default 0)
>  .. slab_min_order=3Dx            (default 0)
>  .. slab_max_order=3Dx            (default 3 (PAGE_ALLOC_COSTLY_ORDER))
>=20
> --
> 2.34.1
>=20

