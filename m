Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA23780C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377147AbjHRNaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377182AbjHRN37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:29:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD62C26A5;
        Fri, 18 Aug 2023 06:29:57 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IC8oC8013726;
        Fri, 18 Aug 2023 13:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5kcubmNF5Fj+r5bDi2OxltrvmZWSQGFzZpexRGyI/S4=;
 b=NSpaK12GcVwYxsco8ZL0IUrWepnSafqOx3o/DX7BXq30Upcv1l7b3ne0wNJMUVVkuByy
 MHEHnxSXpVAcK26RclXgFTLt9jVQjkEoKE/4pigiNtHiRIym1w4bblvXpVlfNqB8VNTb
 YHMpKih8EOInXznXwWdC3chbdq/aNWqkMceBNIBlBtbW0M8xDRXu10KIyh3pj3mHh3Lj
 S7S0Kgr0toRnfmIsOCxO4O0/1uceRWOWPyfSPo2gHa20reejnkN0avK5rWqX0U0vE/vt
 Qn6LNW8LUhIXFKh0R3f6gCoowSw2itgFSS0MCBvzDcFc1LvEhJwTx233ymhFesIifqoE 3g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se30t3ysv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 13:29:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37IBJ0Li040096;
        Fri, 18 Aug 2023 13:29:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0uvvby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 13:29:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Le83jXAi7YyaRhfpBl3nLIvt7ANGBpSISvL2ZObKYImZ4Sy0Rqy4TdvcukBHvsgLjxG3WLH1HEfvPAzZfP99TZ+fNErfM8pikStTSjB14h8UNwkZV2Lhe9YukaT2mIfH7IQsxzT+4toeBPTThjuv0a0PnDmz1ZsyL+JgwM4YAb4VgpFnFrMG7wptK2CozpY7Syr8HWcngZGmjtb9ePyP3SqbPAdMMCBWAD91KJzHPCTayVQTnAw8YCqmzA0+8OAJrObznHpkrNOpldJ0mU/13/rczmEEfwFZNFx1b671442DLadU9A9Sl+DbiKqCF8uTrtEDAM6Q3XTSHrAG9EVk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kcubmNF5Fj+r5bDi2OxltrvmZWSQGFzZpexRGyI/S4=;
 b=H6R9X0VW3+7Acts5s5Hc9Fv2/mmD33BraYFm747Cx+Lx9prhPuQvMvF/XC6gJ4uGohMy3HRHjDD4lbZqxwObDcYEUUSDrTFqiD+TdtjWiA0ONXp4CBq2t18dbv5BSOt0mk7YSCBWI360FQ6whlbEXwgy/rOkKZxoWAaI6K8A1v6pmf+34k2m0tlN2aEZcMZAp3AmaL0RMViYvClGOqQJRVduQfWxfoEPLz3lJ3l6a8WshXW+5MdjndffgB98IxiBDT506jZhAxyYWrXWrNJUT4Owbeqn4WmRuWXMJMZbQ4/L6fBjyz0NT23pGBMiaXCa45WqRZCFCt9Jdpu5SLTZcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kcubmNF5Fj+r5bDi2OxltrvmZWSQGFzZpexRGyI/S4=;
 b=BQ4wakblo8eU/mc5ZTKumqjv38zRe9U7vFTtofMUWV1Y8JmmjIhWZv9lbcirtyMSyMGYgGarAtit5jQ4l7bi8uN7XAqyuBf4o2Ze2n5w4u4Bj/AtdK7VaOJ8dBUeyd0YJLfudF5Mpu81ciU1+AV2+Ym+ARvzVbXfYBhIWq8fhO8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4311.namprd10.prod.outlook.com (2603:10b6:610:79::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 13:29:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 13:29:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the nfsd tree
Thread-Topic: linux-next: duplicate patch in the nfsd tree
Thread-Index: AQHZ0V3JXyMr9pyJvEm9IU1bWgs1z6/wDTwA
Date:   Fri, 18 Aug 2023 13:29:26 +0000
Message-ID: <27D91A77-C590-481B-A4AC-C0036CD175C7@oracle.com>
References: <20230818085423.436d3b72@canb.auug.org.au>
In-Reply-To: <20230818085423.436d3b72@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4311:EE_
x-ms-office365-filtering-correlation-id: 61614567-9d31-4522-c471-08db9fef24d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7QQ12nvfy1QoS6R7J8sBdRLd7Mr0aVQ0fCrfTK+rsBaOnxNl8KC8RvZ50Mix5X5yuKfVd0ZeQQ4OwXio/Wq/CPSPsr/XQFAAaTghj1gJOMiXYDBn9kyvTRKK89uFEhO+VAKOPyP5I7q7Y9zJOA0MMwVq9E5M5amqfaJHkamKMArdSuEFLs4Y0iBgTYW6g5yaGD0x34syeOEUGjKLeiWzUQ36lSCR1D3Ome9kIB7ZYQzb+emYrXK1iytQOEmYomBwFW+zCe9KXtcvVdUyITFb8gIXOZF0bJb+vdklaFrgABDmNzxHKQwqfvhg0LE6HtUnANA+DN5L7Vh6aAu5vusLqDBuGsVlY5KIpNK3dI83UN0lsxBhVv1+bqNCPG07y3L+Q9kwQjMe8inKsHCbLAfTlhKdvdHqzPnC/S7k8R2Poesvahe+Uca6guHeLDYiiByUNqiU5RgSHiV3afz9W+YAbK5EBsAAcyW76NtobpThzLsupxnPX9fordZIWZgU2Yxct0ofFqseuzrjZasKOCqH/ciNHLgBOiFhcniLOqukNYUq0mvpENMcRbKRBM3cAaag4qeh9o3cttcQrt3Ze3YbMuCrkghtLFN7jK7JQmpiq0FqsCChuL2WNDp1fkkFoK2TtFbYfBCW8WIgQJxs3YCIyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(186009)(1800799009)(451199024)(36756003)(86362001)(33656002)(122000001)(64756008)(66946007)(6916009)(54906003)(66446008)(66476007)(316002)(66556008)(478600001)(91956017)(76116006)(41300700001)(38100700002)(38070700005)(6486002)(26005)(71200400001)(6512007)(6506007)(53546011)(2616005)(8676002)(8936002)(5660300002)(4326008)(4744005)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Q4GDSA4pTzseucYjAIrx5QR1QAaCZr9Tq678Veo6Jjy330sZduyL3Bd1sLS?=
 =?us-ascii?Q?3dryAwtDVRMmmy3TCbDwdsF7blEW5J0dAO3lAS1LLkM47YtNbV87DmnxkiZ3?=
 =?us-ascii?Q?xM4svv8pFErje2OYybE47b+1cK3zKT5X5UBLtnB1Us6WCufFhhnVmOIJXxUa?=
 =?us-ascii?Q?CC5bTs2e2T4OpI8rc/gj+XNORzum8lsEM2cVQ+vVYBgN+dqLl5/e4KJbf2wt?=
 =?us-ascii?Q?inmkcNLUS+beFgy7xdWc0WvGluwqiiKRvDEySQoZSB5CM2bXHLSBhG3NPa7e?=
 =?us-ascii?Q?VWQI/P2l9AuQt8KUa+LROw9PkEqwaAJ0KWEW7g3rTbknbnQL+miXhaGIItgi?=
 =?us-ascii?Q?c7siTTIBJa9+BnAPSgmjSJT6PjgjE7vGeJQMs1wKshm6QnEAv92hNa0HLXni?=
 =?us-ascii?Q?VyOgJDjzPXaeccvhp5GbDR1X/0Q42iSyz/hiUgkyDoYI/OLnJvV3X7PxxRtr?=
 =?us-ascii?Q?b2cXfFD4rrOKbNk1nTH5p2kW9NqkDwDwlP4n3JGB9APH1zCJ8/R4e0RJJqhp?=
 =?us-ascii?Q?Q3Y7XJyuw10XwxGotTeF0tE/k1qRqdLFwPcimzZLAb0VoZ4oapBnnZwEJUJY?=
 =?us-ascii?Q?dN+/P2GeT2OdEKbApi6/n4N/JpPkv7jg3UNC+kILvKuqa4xYLBeQjqYpi7Ix?=
 =?us-ascii?Q?HXbLwFPUrOq4T+UHNIhlfbU0aUKB4q2eGe6mYjOM1Y6zruhqrVQld8ua1IVP?=
 =?us-ascii?Q?RxZvuuoadmkE70aRSpb4GOk8Irs8YesQEizzvhZd+11ctMUZzIPSCf/FGIKO?=
 =?us-ascii?Q?m0FyO1Mu0JV12fF5pDI6tVCKbG5C6uq+LCjftfU+ojmwTNC7/hd3dDXpgGxa?=
 =?us-ascii?Q?Q9YOJFpoL4TKIzmKpssTuWrJiB9CJZk3zPzcxgSK5ZdzFuOiNa+ZVC0bBQoP?=
 =?us-ascii?Q?Q+WjrB77t0w8Sr6V951eN5+fIQ9QJb4V8HRi8TrPtT3n0By7rrNZIdbWmO6J?=
 =?us-ascii?Q?oSRt3YWnjS1pCdTQRMnm5sA/RFrXjti5/67cl/dK2MdpQamjjfTwi4ncxwAj?=
 =?us-ascii?Q?xbzcIbEhkqED4+6usREHUkWqBviwi0jOqGbFOMa3UXYnExhwwCV8BpIcXJe5?=
 =?us-ascii?Q?uhqKPl4gamh41TxXG8CLVSfxLTsYLoM0oiVSgjzoK2yN/wc4U8gXa6h7cJxa?=
 =?us-ascii?Q?f9I/oTDKBmE1fv2Y/oaVNe+A8anEgpEbuY/btqxdvgCdq7C1eY4mxZng07aM?=
 =?us-ascii?Q?a614j7d9KFa00x12jPQ8dq19gLwfgLer2IP50k03DsDQZSQaNUYXhPq3Y0L8?=
 =?us-ascii?Q?D8DOq2341XETgHMEYcaJpaeOZotCjubaJ5Sr1KLbputAjMd9Fjz633c6uv6m?=
 =?us-ascii?Q?BUG11hYXS3Y9WqzLbmJqbXJoH70BHmJ7gElYk3ZRo55k5JgBxN3odg17vZPv?=
 =?us-ascii?Q?BvtIR8EBg2xWbFcS7U1ZMAtXoIu95+wwmQGFXhgJ7DM/r5qm8BVW/weSmnhQ?=
 =?us-ascii?Q?cY9CJEj7mfGBWSo2RDXT5f62o6SuFJzAmOKeplSEx2DCd6Uy74Tz3CA0dchz?=
 =?us-ascii?Q?msyIgKqduNyJXb1SPCd3vzpjLVLR/kg84y7Ob8EWiNdQEKsh6a3B8iJ6KH+A?=
 =?us-ascii?Q?nX0M723HUAWu+anOVbQIzU3LUeq/hNsrr8y8urOIz9EdQ1rE4X0MrVoZT8CQ?=
 =?us-ascii?Q?PQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <52B18868BB702845B178A489537F1245@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tubdNjbgqeUuaU4UARo35dbeqH/4SHP3dBEgDxzLQkje45pWx08OLSivAhoOmfrpMHFQIAhxsBZfuaVqPHqaQAP2dnw6DJeiz2dktkUfXyv3OT03fnkhm7xvT+0W/uxP/WKzc8DJ+zu3QzISlQuwRPUHuB6ikT55nSRxs3msj3saGm9Kj9ltSU9t38tdpygwCr9VcPB3KAJGDlBf6YFWLLpbf7Ls7JTn1EovzlCv/3yZmSGjFI+8KX9+iuCqQi8YFZJtqJMVC0QAF7uzwcc58N0VOH/4S/22TedBn0vbKNKgUuG9WNJyZo0mhWnLRjVH7SDg7nDKJXxCmrsGkt/Hp+swNle7fnes7xN2OfNxcQd4b2Y5a+Et5p0OGVzq2ExLSXWYbTkRItzZNkeAMNeCePBRyNZkPn++QOr69zx+zmNBvolno3zbzkFbL5wIe9+P9ZGTu3vDDuoucMqQGSmneZ/CiWZZo8tZ3EbkluPg2fkwV4dQ5OMXXWCZ/cuqYoxGeM0TiXp2Qqee1zedZWeMPc6FmKwsV4xBoeTjyqlmSEChyCz+fsebXEF2mxT+U/Sr4ovwD+g/Rin7NBdUgoORt0IKc+0tM19TdnvoqiOVHwXafoQ6eYmTluO22muYO7h9RQp+kEYp/nHe0Xmvu5EOf5Qgdl8fwqv4s+EU4Lz00NIcPSVJp3n/fbLgL/zc1K948/anFyjHre9ceSZMCTsv5qLv428tSFWgiCVwymZdsh+qxez8AyAOFars77kAmC8V1zqpD9NGidiIHBA7vwUGIKXpGv+auB2UYgHQrfQ/4ojihejQzginOtHyIusp3dNGaneBytL/6PhXjT5sqPMOsQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61614567-9d31-4522-c471-08db9fef24d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 13:29:26.6702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vOWBA+4HTXLnfH+Q/qjEfxx4Mz2RxbR0M+45A+u2sEWXUvgxsGGhyR9EIEUrGEhfLu5z7JmLeTzRv52+oIWQVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4311
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_17,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308180124
X-Proofpoint-GUID: XHz7NjwJVi87_SI-h26BC8y2cBJDwaRc
X-Proofpoint-ORIG-GUID: XHz7NjwJVi87_SI-h26BC8y2cBJDwaRc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 17, 2023, at 6:54 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrot=
e:
>=20
> Hi all,
>=20
> The following commit is also in Linus Torvalds' tree as a different commi=
t
> (but the same patch):
>=20
>  7f55e3c57a81 ("sunrpc: set the bv_offset of first bvec in svc_tcp_sendms=
g")
>=20
> This is commit
>=20
>  c96e2a695e00 ("sunrpc: set the bv_offset of first bvec in svc_tcp_sendms=
g")
>=20
> in Linus' tree.

For the record, I've dropped 7f55e3c57a81 from nfsd-fixes. I'm at a loss
for why the commit hashes differ.


--
Chuck Lever


