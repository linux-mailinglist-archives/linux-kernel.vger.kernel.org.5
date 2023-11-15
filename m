Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B6B7EBADF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 02:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbjKOBR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 20:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKOBR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 20:17:26 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509B3C1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 17:17:23 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF1B1jT005163
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 17:17:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id : mime-version;
 s=s2048-2021-q4; bh=n0qVFkp8+CRlhtgaViEaByzGlKNbf3wNq63IJmn23Vk=;
 b=XipbJeV7nII0HCyTeEN5cl1YGEx1Zxg2z/lG9rP+n7dImUqI7ITsS2HAp99lyKrEs1s2
 20CqBM1p0wBGc9DivS8twQNxye9SOeBPB7qqv2N+ZhZ5SxkAW0UEnU+8Ktu2T9igW3nG
 W1Ji+h/0a2r3tzMfGAm/JI8PeztBp6jfkBWVK+dBiBA129veAdCV9MdgdJyrP0g3k9oa
 1A/x2nXTg7/MJIRUIJq3SXD8fWJZFjOA00guvlZDzv6NJkYqJS7pEajCXu5DpOIk58vq
 K+B+qlPYviDzSCETCtgmtXAEZ36dxoxE518ibK4R+pqj7MvKs5uBiLt6AWgZwGJH9tZm 9g== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ucd3su7v8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 17:17:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmuMsw4F0JNQvYESFy2z2WklKqNNq7yuC6SNKOyH7J7sfBCZBbMH8SkuJF1da7A3zSyRrg9Rr/MCLXSYZSrqwo3WEuN8GaitDeW2Sv65hZmLFvBYuFhZyba9d/09FhwEmRM+YHDhQY0bIq+RuXQFZsCSE4gh1PmTs/3n3KETbc4ty5Pn5STXdcbYQejIwaXbeZMwgkqoEGm+B3fEXgXA4Mw+XYz4P0BffSY0mpAooBh10iYJbQdC1zu+yl9FpUSec/JbRswsQOfZOydNZUj1QYZvS+I/CCihmC2e95anqlFnuLmHTskrzQxPMNZrK9nnITszV9p14DEeZ2/n3Uu9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0qVFkp8+CRlhtgaViEaByzGlKNbf3wNq63IJmn23Vk=;
 b=kHKt7ZhMyE89nZ+fJp99AZnF0or2kzz5BNSE3b5c1aUrR9rLBFeYul6Z1ETmhnwl76QtqBFLGr6YZdxwDq+3vaiGn4W49DqKGuvqEMBKaUePM/PYAh6xE1AhAixRQNlIgRKJCXBQX/fMPhSB2M/z3lp15rZH2nlU6M1FrlUEJe0ZgZW3yCGO/CJZqTFsavhyARlUJ8bs528B+KaV/TVOZb91UD+XuXytlnzqQLeS8hYgXKD0lP0WWSYHGIDxyEyAAwKaiIym6Sh3e+/i39HnOhwBrmv5XYzda+bfXEjeT6ZFhVL8G1tDL0XGABLuzmWeMqMEugGXRLflGpb1ASft9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from CH2PR15MB3672.namprd15.prod.outlook.com (2603:10b6:610:5::14)
 by BL3PR15MB5385.namprd15.prod.outlook.com (2603:10b6:208:3b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Wed, 15 Nov
 2023 01:17:19 +0000
Received: from CH2PR15MB3672.namprd15.prod.outlook.com
 ([fe80::69fb:5834:35fc:767b]) by CH2PR15MB3672.namprd15.prod.outlook.com
 ([fe80::69fb:5834:35fc:767b%6]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 01:17:19 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     Nick Terrell <terrelln@meta.com>,
        Nick Terrell <nickrterrell@gmail.com>
Subject: [GIT PULL] Zstd fixes for v6.7
Thread-Topic: [GIT PULL] Zstd fixes for v6.7
Thread-Index: AQHaF2F6q9TPJrt0ikm0E0QPYbFUPw==
Date:   Wed, 15 Nov 2023 01:17:19 +0000
Message-ID: <11692A57-6A65-4ADE-BAE3-169D50A1FC16@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR15MB3672:EE_|BL3PR15MB5385:EE_
x-ms-office365-filtering-correlation-id: d2e7e53d-18f2-401b-992c-08dbe5789cbf
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FMbEaGUIhwM5xngzYAM1dv3o/jqVxVlPrqo5W/Qw8CF5nZ5xsJZVDU7fCjO4LlpKLfTGautGbiZvqHuC05AWOpWfuvTmWP2eJFgSv02+S1PL3PDWKS04gviu/I2IucunWbM0L1ww1BTHNTePqejyZiZK90FCPLaukW5QFn1cCxmXNTk+AOws65mN3LrIYjZguOrMMvAYdWlZV0NpEuHpoYSA0p7PG5OQP+f1Qt4kjKqGyZYTmBDUiwZWPieE9ebHVkdkKQN+xMODXN8/WNG3f8RGmzqYgtaWPVeFzfRZkyK9CMQkA9ELqJYfCRbr7CeqgyQGJTOJi3fOKWqgR8d7aS6QZHoEhhrTuaySVv2DkjEOv5Of/cbB4iKWvGCmPLVNfhOWU8HsU6OO+Agbnoh0VfCERFc0G6fj9HcKhdYcTj/5DXegyrG/mv0MieZ6TmoNJQxOM7p8vFvaF1F2slWaBy2rusYcj0BPO/p7oIPhmvYFppWRxjbFLIlW8zNTLEfN+FCFgDGRM7osqLx/t2Ge6QWpW5TiT/W7NKhGch4rV7AiPhh5kMyVT5kdjWXTdAjdtUO/uSj/sGW3L+JwVmTL2i0/cKtromT+26wNur3ms6ig7Wrd0XxEJcHLSzq6SVOvyaIUpArgmozN+4UjfqBnlAkc/M5vc8Q+arRTO2c1s8pIDoMesk8pPCgjaIVqiiYy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR15MB3672.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(376002)(366004)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(36756003)(38070700009)(4001150100001)(2906002)(5660300002)(4744005)(122000001)(41300700001)(38100700002)(6506007)(8676002)(86362001)(71200400001)(316002)(4326008)(8936002)(83380400001)(966005)(6486002)(478600001)(2616005)(33656002)(6512007)(66446008)(66556008)(64756008)(26005)(66476007)(76116006)(54906003)(91956017)(110136005)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L704trSp8vmc+curveQZ2hGLBcGDbdVijQdJrNdednBn3hm2C8koWmKxvsS3?=
 =?us-ascii?Q?JCCq1wbu0URdLQmItmdONXyWZztrbxn5ALxaxrO67NwyCjwOAZlCk87jL774?=
 =?us-ascii?Q?SUbNmlPHMV4rBqOHzd5dCtFm8dpFsEv371ot4gqsrkk37A46sPqHm/R3o/Pc?=
 =?us-ascii?Q?/lOQ02PVXrrbeuBJ2UGEKC8Rwc8dyjKmMZ3STUpXIOcMU4kwY3NdBjlcHpDA?=
 =?us-ascii?Q?6HKLgPf0hmqd9F3FKVPv8KvAVDH3Fb7NvYHgx+7SAI0py75I0fnCKK51snyi?=
 =?us-ascii?Q?/OsD1aQmMVAIIOeSdI7Kd7APuQ3lqaCKAsnH1FJqZg45oFT6V862Hvsz9GDI?=
 =?us-ascii?Q?ZYYpiUKe/BsnBRFYe2RehIZAfDw7PitxqGo6cqsLZcJQ8EYc4J7hepXTjCcQ?=
 =?us-ascii?Q?XOwbK0t2J3DQHDStw4s+6+5hdVBD/ep+RIB7Ody3wTxyvmsf5m5mJ4jhbJ7O?=
 =?us-ascii?Q?rGgAbVHXS193odXQJ+0UjQUxsb9wOUSZeGAWbv4vdCuqdKi7Ud3wqWE6x1Kx?=
 =?us-ascii?Q?82Ca3CJ77GU8mmQ16P/Uh9Ujtin9VDkGWC0mRRfdqD8AxePEUJD1UWLP7zfv?=
 =?us-ascii?Q?A3Y75mNSQMtr7H8FUGxMtQ5IO5O6RKyhZJGOX2UFx0kcugujCy0pwNthtR+k?=
 =?us-ascii?Q?FBv1REidvnrPs0vfbem9t0YkZuGTTNT3OPQvh8d3d3oFOewRFgDVXbnGnNe1?=
 =?us-ascii?Q?B/+7vvL6Q4EIhRaJsISouBYHkt3+VNZ4V4eaSejnZWHLZvPb1+D+A4zuj6wv?=
 =?us-ascii?Q?VtU8aA4aLjmgg6GAY6FMZ1CKSpXVe/DtFdbdORyLRc/A7F5Rd+g7lst0Lisf?=
 =?us-ascii?Q?x10Iscc5cz4eyAOh/VSRkHPrt0g/Y3t8hMjv2lYTWVwcLN15VeOOOrv4vJRl?=
 =?us-ascii?Q?Nv4Kc72u1LrCM4Vxhqv5Eiw2tWQRMikBscljDaHOUR6Xvj5AIPgw/LdB5hRc?=
 =?us-ascii?Q?WoWWGtQTHZjkvNsdm0VyBBH2HBSgVdYPjvDEQl8//8a4tUsXMLbCaL8hvq8b?=
 =?us-ascii?Q?vQvNk+OuMw+ZRcDZwY/BiXALQU64hfLYjKp5k2gfbDjUrDRSzayTwChM6LkL?=
 =?us-ascii?Q?2lU9/2mBO1hQCS6tYijqXZMa+TAVUJzdxtGxuj/JYgx7SJensbBneQB4SKme?=
 =?us-ascii?Q?o14xeTAQ9PxhRS/gKKs+HZchRRb5b9IgXXl+QL6cx2kcoEJkiT24W/hvC5LO?=
 =?us-ascii?Q?wcEfDCsGwx4NfeWEirK7ZeqgvxcWIajPy5zpw9r9Rmu0fJQRkPhYUSwsKxyJ?=
 =?us-ascii?Q?k5kbNdWdYCWNQzaro/6kXxdfEB2vp9eIH8B073nukDDBFiJF2uvm2Lf7gXYW?=
 =?us-ascii?Q?/7c5aesvOTX7QxTJNyy1L4B4K/A0kdFmmWjJNCxIV1SmxmxD1rvlYRBZ7Kbw?=
 =?us-ascii?Q?90an4Me/0qFxTyS2bWSYhmfbF92kB5Z9GKh9CTxx/4YH90wJvarwaFBCnUux?=
 =?us-ascii?Q?BVclb9oN6gLz0c7w+AVi9wA8QTFD25axlv9f2iyTObyKDNarun/tmcChzH5B?=
 =?us-ascii?Q?wkDpaEPbb6BTkicuOziYzANigz5MBB3AFwIqvnUGerjwZcnckotXGO18+mIs?=
 =?us-ascii?Q?pQLd2jeJqIg29Qu1+8VmrrCGHMCZRWlafFcidb+4?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CBFCF571B0A5834DA0937FE281529EEF@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR15MB3672.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e7e53d-18f2-401b-992c-08dbe5789cbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 01:17:19.1378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fNGIMoUf+MPh3UCEiBHY95g5n1sTka+ad1EbAOXQK7YlgrRO+mETL3WCpNoZO3LWR6g6WVL7jf3Q/NCeyEwFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR15MB5385
X-Proofpoint-GUID: IeBMo0yV8FfaIk_BJQNCECcCvt8ZD1V4
X-Proofpoint-ORIG-GUID: IeBMo0yV8FfaIk_BJQNCECcCvt8ZD1V4
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_01,2023-11-14_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ffc253263a1375a65fa6c9f62a893e9767fbebfa:

  Linux 6.6 (2023-10-29 16:31:08 -1000)

are available in the Git repository at:

  https://github.com/terrelln/linux.git tags/zstd-linus-v6.7-rc2

for you to fetch changes up to 77618db346455129424fadbbaec596a09feaf3bb:

  zstd: Fix array-index-out-of-bounds UBSAN warning (2023-11-14 17:12:52 -0800)

----------------------------------------------------------------
Zstd fixes for v6.7

Only a single line change to fix a benign UBSAN warning that has been
baking in linux-next for a month. I just missed the merge window, but I
think it is worthwhile to include this fix in the v6.7 kernel. If you
would like me to wait for v6.8 please let me know.

Signed-off-by: Nick Terrell <terrelln@fb.com>

----------------------------------------------------------------
Nick Terrell (1):
      zstd: Fix array-index-out-of-bounds UBSAN warning

 lib/zstd/common/fse_decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

