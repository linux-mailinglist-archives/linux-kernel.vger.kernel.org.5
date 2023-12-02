Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAC2801AA1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 05:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442003AbjLBEYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 23:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjLBEYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 23:24:08 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25263F4;
        Fri,  1 Dec 2023 20:24:15 -0800 (PST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B24KYaS008541;
        Sat, 2 Dec 2023 04:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=50g6IoPNxp5USiLjIXN23SAuawMb4ClDxHGte/6F5rE=; b=
        E8hsIctMPta7unmmxHc7r6Y3z+35qqdeJyLE75Yx5p+c/RjKc79PisJXMvIvLQel
        W6qA3bo1iKnvtoj5K//jnM3xpYxMvN1XoS77E5q5KnxCqlm9Acuwr3B/VkAONe58
        EMFIJN15gJUoKnh9PA7TH2g34amm9NAw/dABmcmthLlmw1JSfOCDGDdgHLxngMsx
        i8ibwEjlE9dfB2eTMJvdtjMMagYQJCg3TQNUxse1iGbJKF8Ax3uEQtcfTeQqqoX3
        qrKowmo3/GTOfFwpPxyFj/YGvAxNHfGDshBblgArbq1pqW3BYndjMoS3NEj42TkR
        mPsss1cA2t2GECLvVtPbIA==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uquj681w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 02 Dec 2023 04:23:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxam8VffZn8pnWNRevfLmQ8TM90r4AaXBy7xEQgv4GT+Cjz/TaVdSaUPTxhehwsesP+myxJyFz3Q6K4TnYIp2TmUHIQ6Es2hH5z1BeIn57j9b205oKP5nrqbIRMJrgwyVKeeAu058px91EXy2DT1R/a6WLU0RnyFBv8+hY+1TLhcQEACap/1cQExC0GzuwMhHcabucQ1p7Trhnnw9MgeByzEhgbZgkAi9TpS9xoH507CBdlxu1AbNgtttT9Ab8b03ZK60tDff/jliiYzDgsL1LiI3Ed1tBKRFAo3mviKKtQXOU/o6gMGVadEWZ1Oy+kCpyD/6EQwTGQ2o3hhAMrOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50g6IoPNxp5USiLjIXN23SAuawMb4ClDxHGte/6F5rE=;
 b=R+6k/IJ+9dBb3YzUDumspeYG2oRMvol6/SsEwk8zanXm5Pitp7zgHYGhhPNcbe2MCV69Os42692FgD4pbTEpR6Q70FtwQJgqOL+pLJTOA4gD9oDqQ0U1oIqJGYdZDmieJ3IMvks7Pi9ZAW6Jl2m0yurApcZx5MLS4KwwkvAMAS0L+16CqF4r7l09OH7rr7sa4Es9tfCAVb0+GO4bx13MLGZSfhv6lUn9i0YV3/uyDdztSZGnjubhepO3xIYU/rXQCAIyicNJhY4Tu91pfaC5Jyz4NdLVf4bpm5PPhrVL9EUPwmN5KoZ2ehlpXWWKsjZDGIOXl4t0V/MAJOgl7PL0MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Sat, 2 Dec
 2023 04:23:29 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91%5]) with mapi id 15.20.7046.027; Sat, 2 Dec 2023
 04:23:29 +0000
From:   "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To:     Kees Cook <keescook@chromium.org>,
        "sxwjean@me.com" <sxwjean@me.com>
CC:     "vbabka@suse.cz" <vbabka@suse.cz>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "corbet@lwn.net" <corbet@lwn.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 2/3] mm/slub: unify all sl[au]b parameters with
 "slab_$param"
Thread-Topic: [RFC PATCH 2/3] mm/slub: unify all sl[au]b parameters with
 "slab_$param"
Thread-Index: AQHaJAS7NylgWPHDL0CTsOtYEw3Wl7CUtO0AgACxhYA=
Date:   Sat, 2 Dec 2023 04:23:29 +0000
Message-ID: <PH0PR11MB51923F916D8FB7D94270BBA7EC80A@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20231201031505.286117-1-sxwjean@me.com>
 <20231201031505.286117-3-sxwjean@me.com> <202312010945.7C5DB1FBB@keescook>
In-Reply-To: <202312010945.7C5DB1FBB@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|PH7PR11MB6522:EE_
x-ms-office365-filtering-correlation-id: 1fab227f-8695-4ac8-6bfd-08dbf2ee6fd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s/8PG1CKVyHy6WL/qAVjpFkAWsVSThHndAEfM9n9DbjfU1aZ7C0F3bksOtofXr1EOQ1U1MYXPxMIHnYhzI78kNK4KBn2ZaTOKTprlxUd3U7cDguJZB7CuW4HEKvWGITGnlBI9P7k45WLvb+UT0ewo511og5uCpQkimXVFSFE7uFOK4yA2LWCgTC8DofHxQNvYYusfikvHyN604MsyTJWybFb+eTRsbjYKHhJDslb9gc+BnLzt4XZw0VHVBkgVJNuDXtYylWeK9uaUbJkDpfI6c2OlXBPcUh33T4vP2YauedJAgdzqZKAmn1xtjtUVGGcAWPL1IPDDWZH+SXP6Kso1YpsRVeqFrdN48lMwSnthT5XLgT01sTQgM56zq9AsDFOPoaV4rqS8NA8Ym3toYARyM8EUKNWRhdHWDX9YeLcXYllAEexqA1sTyQBZ2y85xabKMS44FQzz4uO84UVrTV+gL2B4JPpyQSDAANgz9z0N7cgWgjzEb/glsM5TgOknx/8F0or9N912vLvaELMgHcvbkME58hgAZrOZgHu36EWHRbSE0A5N1qAq8E1kZWVAOdk1hca6h1xoZNrYR9mQCfXm3p4D7jzdcswvXxIWWSgog8639PqzRdG6JTc302NLYBazQ/Xenz/vgspDnZvgNzZa5NrlcVodA+o0/fkYlNOAUc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(346002)(376002)(396003)(136003)(230922051799003)(230173577357003)(230273577357003)(1800799012)(186009)(451199024)(64100799003)(38070700009)(55016003)(5660300002)(33656002)(122000001)(86362001)(7416002)(2906002)(53546011)(83380400001)(71200400001)(7696005)(38100700002)(9686003)(6506007)(76116006)(110136005)(478600001)(41300700001)(66446008)(64756008)(54906003)(66476007)(66556008)(4326008)(66946007)(8676002)(8936002)(52536014)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?76AUCfCGZJ6Ycz0kpWYnTrnz3LoT2wh6bzSxwffKOMTop9d/KHMjno1zRCHq?=
 =?us-ascii?Q?FhFyGsLPJp3wfWQoqqfaBwppjUz0XetVHY7oWEXuoKLxuxKR4TDJ0D0Di/Dt?=
 =?us-ascii?Q?BBWesJbfTVDJWyYI5n7h3xk4bCB87P+cRsLMras0/NSlb8UGRIjYZMC2NvFr?=
 =?us-ascii?Q?MTQM9ApDoJalWhVAgxKRe7tL24SSHOb/3k9fe+kQ2qCyCA1a8ua8bRSbLR0p?=
 =?us-ascii?Q?JgJbIAtHZx09KEYFiSs4HdP3aI3pH8h+33/YsI2jpk5eJxnLnyAoeBub6IQU?=
 =?us-ascii?Q?IqmQAfhiRWgjvKGRH9ipSCsPQkwXJRS4d1G7pdjJBLalPIvPnJBwi52S3Ipu?=
 =?us-ascii?Q?m8w5vU/xSddJdm/jTUA0uUl2h8i5SEZCgqHeTS8rFCUpohJczDrpbknUCJFo?=
 =?us-ascii?Q?GoNGFtgRuFvf++9Zz4fxuqyIWZBM6qf8SqxzvzkRdHfHg8PVp20vyPVztY0b?=
 =?us-ascii?Q?LGwuV+QyDNcIwZVqhHx/DxVkgP2vXyktSv141YvJnUoFLcPCSLqU1BLPlFJL?=
 =?us-ascii?Q?WHXu9dTMqXeRMAKgASKwQuTpI01TD7vMYnsCOgDNc6lBuAMJTADivbFSpjd4?=
 =?us-ascii?Q?oDUPxq4zBgbBWqPZUeMMx23Oq3rqVriXAWjZiJNoNUrWFt0JzYGio0N4qTU3?=
 =?us-ascii?Q?cpAPTSBhNeghEO5vs+KFLu2WpRQUPNpFnrVXGtcy14jFdGJiChoWgYHfTlMt?=
 =?us-ascii?Q?30nGvjYIDxZyrgPENxuvyPycaEgYBfMVrYTInVPgW72JBd9VOj7NTvCG+aWw?=
 =?us-ascii?Q?vKo94PNwJvsM6QNGGFEd18qcI8Rsp1fFdeiFTTcQ8djjcimMkOsKsV3G0qP0?=
 =?us-ascii?Q?YGweIBjVbv16FnzZFxVmXg9u7wMcbGp1eYbgMRgn9NhzUUGEhlLc02ModU9m?=
 =?us-ascii?Q?kKmKrYcTphEKW1/iLiBjFELYHLRrE2DtjNxKraRi9Vdn+HJXdoKFwxn79AN0?=
 =?us-ascii?Q?FsEMU5qJo/BUkEgRMCuqoDa7y8kovnKOqoeOqrS+u+jmP7qSGVc5BPBV/HuH?=
 =?us-ascii?Q?dYiriOfz8mgOT5LXY61eHBI87CFZGoRYgrVgcWRylGK+mhAqTl6g4taABug+?=
 =?us-ascii?Q?38wfkWF27jVYqrrlDsr60Mbcwa6r3zneouq3lr9/D208Ylipvnk5rVJt0fea?=
 =?us-ascii?Q?O1OJcXPJUfqhQnBVY12cr/yKw1aE55tm9sOYBtbNhI4WE30F64outnJqs0ma?=
 =?us-ascii?Q?um/cXXIF7r9sGsWL6HMW8/gIA7IE+qsoGpP5kbIeXO700HMH30IR7v63miCa?=
 =?us-ascii?Q?O8vnuPdxttAs2uefvBvT8Kip6ZOkYPSfmftjHGJxya6mQlM0ZYJAYOQon371?=
 =?us-ascii?Q?bIkfiKGc06GNMtsMGnX9U81sQcwyIOaj8VTIB7/EuCb2efH3klzeSpkOLIom?=
 =?us-ascii?Q?NW+BKKoS3kra4sPmT5b3DKadYLeRHdAU/KnQi0B1Pc+9hJxWkt3x+R9Se5TE?=
 =?us-ascii?Q?RGXWSs2l5XAIg5VqvEHM0+qaR6QnGYo8dHBa7P+XO6AiQYEQ9ctLuRUc7AlW?=
 =?us-ascii?Q?6gerJrKx1SI4fT9KECGSmGOg9tOYB4obEiVhp9a5Rd0N4WIhxTjDwG6ER5S4?=
 =?us-ascii?Q?jGnVrOLhWlFR0DKvdjvTiAzXeehStZ5GT3YBWDKeoLfc8VEOLBzWLUblWJ99?=
 =?us-ascii?Q?jXO00NGAknLDJmyL/sZvysX0k67BBAfpbhHhbJQ1H6F+5i+Q+pnfugmzQ0yB?=
 =?us-ascii?Q?ASFqBQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fab227f-8695-4ac8-6bfd-08dbf2ee6fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2023 04:23:29.4593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cmFZQLCN4Td6bxVYR6T5Wgd0kEzJW7kBCfGzOhfGZnb21/ZktPYflRejUHkfUCRh7rtMnuUC0FlE293sKYizmq56pH/x2opTTGEgcUJpMZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6522
X-Proofpoint-GUID: etungtlaxaBYQuD8-aVLbFQfCNSEJRPY
X-Proofpoint-ORIG-GUID: etungtlaxaBYQuD8-aVLbFQfCNSEJRPY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2312020031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Kees Cook <keescook@chromium.org>
> Sent: Saturday, December 2, 2023 1:48 AM
> To: sxwjean@me.com
> Cc: vbabka@suse.cz; 42.hyeyoo@gmail.com; cl@linux.com; linux-mm@kvack.org=
;
> penberg@kernel.org; rientjes@google.com; iamjoonsoo.kim@lge.com;
> roman.gushchin@linux.dev; corbet@lwn.net; arnd@arndb.de; akpm@linux-
> foundation.org; gregkh@linuxfoundation.org; linux-doc@vger.kernel.org; li=
nux-
> kernel@vger.kernel.org; Song, Xiongwei <Xiongwei.Song@windriver.com>
> Subject: Re: [RFC PATCH 2/3] mm/slub: unify all sl[au]b parameters with "=
slab_$param"
>=20
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender an=
d know the
> content is safe.
>=20
> On Fri, Dec 01, 2023 at 11:15:04AM +0800, sxwjean@me.com wrote:
> > From: Xiongwei Song <xiongwei.song@windriver.com>
> >
> > Since the SLAB allocator has been removed, so we need to clean up the
> > sl[au]b_$params. However, the "slab/SLAB" terms should be keep for
> > long-term rather than "slub/SLUB". Hence, we should use "slab_$param"
> > as the primary prefix, which is pointed out by Vlastimil Babka. For mor=
e
> > information please see [1].
> >
> > This patch is changing the following slab parameters
> > - slub_max_order
> > - slub_min_order
> > - slub_min_objects
> > - slub_debug
> > to
> > - slab_max_order
> > - slab_min_order
> > - slab_min_objects
> > - slab_debug
> > as the primary slab parameters in
> > Documentation/admin-guide/kernel-parameters.txt and source, and rename =
all
> > setup functions of them too. Meanwhile, "slub_$params" can also be pass=
ed
> > by command line, which is to keep backward compatibility. Also mark all
> > "slub_$params" as legacy.
>=20
> *If* we do this, I think the old names need to be recognized, perhaps
> with a boot pr_warn() about their deprecation/renaming for several
> releases (likely across LTSes). I think it's not a good idea to
> wholesale rename these with no warning. That's going to cause a lot of
> surprises and broken userspace...

Oh, yes, that's a good idea. Will update.

Regards,
Xiongwei
>=20
> --
> Kees Cook
