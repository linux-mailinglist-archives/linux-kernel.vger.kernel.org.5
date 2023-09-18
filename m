Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C807A49FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241413AbjIRMmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241970AbjIRMmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:42:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B34C7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:42:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IA3Vrr007465;
        Mon, 18 Sep 2023 12:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wxX64/T08DnCnAWrjRgRqMiv8bRIDvdu9LLtHPfmBgg=;
 b=wLmCbrlVXF5zGDvGvrAJ2Hfv/o/z4dlMOPtKFW+P16ChVfkSQ9Wpb6nqm2EUMq7acizt
 Q6P4dme3JpeILlofiQigiMI6EmjAnY3Y7PDLOBBOZwPmvda35nw75lM8Hd35rSWeDAvy
 HnsNjrmAKHN8y1YV1rPm0UU21u3zh7+JgPI3IUVpswHoMx+0CpiZPq1QhLDbsklfYKjD
 Nb2tL0gPioYOuO4BuvRkYTnC49440KYliLtkDQdwyh682m0a654y+C/lSIerukHmi1e4
 WDkY3gIWBq0lzdL/LVGA6YU1HcwHg3fanyYbg8lSC15xjlcB6WUGnIx+gzVDXMk7Tqgd 6A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t52sdtfh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 12:41:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38ICVCg8027011;
        Mon, 18 Sep 2023 12:41:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t4fvtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 12:41:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jatiegxr3jM1+/cQT5JzDBYiEHxNv8q1skHgIA83lUBLobEuvNFJeKOH4w5jzU9oZTzGBWJgmxx02x0C6XXxir78XcP88FehmNEdeYNM+gHo6cye4DrUW6296t8iKL9u1i7/gpyowhknX0dTNg4xQD0fF0kdaO6mrkO79j4SaBMUPGarn3fAgr/aSi4Wr0U4Y2D4VibiogPQOjbqoB8nnMxU/+TdC2QR60EMI7s+gqR4ZwKPY4dLHXiSsVTWHriMizy4X45CXyjP5cwz4OCNLl3Cp6g0cl+n/yNH9OCvg6ueRU8tHLNI74srHm3LQ13U/+I6JojdvM5fmN4E/JPMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxX64/T08DnCnAWrjRgRqMiv8bRIDvdu9LLtHPfmBgg=;
 b=QXAcd3i7aevBEXEcSOBko0BX3t7XE1YUYdv/XNoUIKlpJv2oQaONG9q2zU0s7DtiR7xvPdoT/u3wY1HlD6govnVxsyEjpmeVW28wNn3qV66A8SozAt/7gyiul+1FTZykzVy/dXZu6iAgZWQeehT9fEus5wCHc346r0826PP+qTsd/s0RkvhpcyBsYTV7wX3/c5Tjn8ifdgfoetwCOVZDug/KCnY+ywhUvCC9uw5Xz4arGCZrl6Az54AUokQXhH4T3VURsrBs0HGritvqVPGONeMr8vu2X/awg/6YynsqI9QgRB/YUZjMytQThmlxi1exV723WUctofr/hSn60ZZxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxX64/T08DnCnAWrjRgRqMiv8bRIDvdu9LLtHPfmBgg=;
 b=Fco8LTbLFpy8a0Ecxyxdozrc190lJkTpEZFKMR+Rd4C/8+N0BAZNeDk32bTn6rmyvoWaxhT+HyuQ3v23fNbE2eiwR2WUX0GhhmAPT9mgaL25IyzOaUAW3N7mlbKE4FYWQVcCmyGRcLcz+22VF1gquWtVWoFqhpuS5dzISjyhc9o=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CH0PR10MB5033.namprd10.prod.outlook.com (2603:10b6:610:c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 12:41:46 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::76c:cb31:2005:d10c]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::76c:cb31:2005:d10c%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 12:41:45 +0000
From:   Miguel Luis <miguel.luis@oracle.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>
Subject: Re: [PATCH 3/3] KVM: arm64: nv: Handle all _EL02 and _EL12 registers
Thread-Topic: [PATCH 3/3] KVM: arm64: nv: Handle all _EL02 and _EL12 registers
Thread-Index: AQHZ5nOMBvQnuUHm90CBvgZS5x/04LAgXHOAgAAxjwA=
Date:   Mon, 18 Sep 2023 12:41:45 +0000
Message-ID: <4A24B4EC-B221-48B6-BA91-DB7AC72CAA8D@oracle.com>
References: <20230913185209.32282-1-miguel.luis@oracle.com>
 <20230913185209.32282-4-miguel.luis@oracle.com>
 <867conerys.wl-maz@kernel.org>
In-Reply-To: <867conerys.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|CH0PR10MB5033:EE_
x-ms-office365-filtering-correlation-id: acc9f579-cb24-40f4-ed43-08dbb8449e18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JlFdgMNMRP1T+XjUZEpPZXY95Uh5ak/Jn6ZHtKfZKgQ5i2ByGqMgTJFDPY7kSRC1kGiNz8rwh2SleueFnQqhAqX0rk9xHD/MA/tgOL1HukdkeOjTcm90bWRMyd4BH+/JGR94DNDf5Vv2LrH7IDr54crScjhLHr+kHclNtFks+v0uT9+7O4pHEEIyzDmjjrOB8Vv1KK1jYWvT+wm0HsCPCVSpuM2j/ZVozKEWj8ORY3fNzHemH0sfSp+9WX+J04YeEXbKHVoC5iUoRRM4IcD0t9DHqOmrKOpyxH1Ns4tlV6ZDljFrBfgBTnAYl/nzAJFeVvzdqyEP19B9E9tQGyQ/TR88UzO6s3SfKO7JNjFrz2Vk4NVrxMeKtbSOpFjJIhye2pRyizsWu5RXJhuMnvc3WJuza2tBrJGTjTP8Oh8Vc+N2JrjzB4URkb6Q+ABvPIG/nFa/ZzWWIg5N+zL8cd3ubhxRmhXPFxKGQ9zn5mOCt9P2WXswqdjPEujQLiYQKsrW9lCPVY0i5CYfZAlzldnB5mQMXyn5E+Hr5Xc4IIRmGOhkzoSGxt/G2w7R8+vfxMEflRcjty7AvJrob1c4nltwAwxk33m65mehG4JqUq6t/Y9ChYDbYq28vmal56uOfsypYoEGzo1bYr20x1p7mXE2nQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199024)(1800799009)(186009)(122000001)(38070700005)(38100700002)(36756003)(86362001)(33656002)(6506007)(53546011)(478600001)(44832011)(5660300002)(66946007)(66446008)(54906003)(66556008)(64756008)(66476007)(76116006)(71200400001)(2906002)(8936002)(4326008)(8676002)(6512007)(83380400001)(6486002)(41300700001)(7416002)(91956017)(6916009)(316002)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MWxhzEN3LwoGBL3E2cI8N/M2oBpGg2Z51zwlaW9MNNTMuKH0da3a4nyN819f?=
 =?us-ascii?Q?0YWh0prvs2ax79vt5xzfURurCt7r3FLHJD76NDwOy71y2g56fGEpUwVYC8jP?=
 =?us-ascii?Q?8JS/Bq27lqOM1w0MDyupKKr2Z4mgfatH0cRxoeJVjlL4lOKL05sDwcd3wLvZ?=
 =?us-ascii?Q?M5+szJSziA6KOBcgQncwuqf9u/vB/yRtdR6fz3L3UtkNQvZkFTPlPBAuNvyO?=
 =?us-ascii?Q?x7JvTX6THULAzQcw8fLR6/vKfwi1JPcGbGX1JQhhIphbEsTIwiCeMwx5BxAU?=
 =?us-ascii?Q?ulYWn1kl+fp9RDLVXRxNNwPUQxP8bBpJ3T2PsAVwOS5YvxZ/DtxYKnwK/A2x?=
 =?us-ascii?Q?GmRGz8tkY9Hp7RFhkMgAcgkLMcBZ/ZQFdp0PI56kPQcDW7DsnOqWfOARxu86?=
 =?us-ascii?Q?T72i223yimSmVNa25RGT6BUBsS0rLtVJMCSQZ6bysVsdJtc77eGP/gObWJEy?=
 =?us-ascii?Q?fLqEMY8VT1j3zKBtHQNPdDld7OxRQs8UK1bdH+0WmsTP2+gmnIV68Bc8+mPO?=
 =?us-ascii?Q?CHXDyM1N2FJZeFuO4tECt8gb2xwcta3rL4VA+hlj7rZjh3qaZ3EqlhaNX6y/?=
 =?us-ascii?Q?6WZu1BGAsCVG2jzS3gwsd4br732TcLQUi/Kk3drLRdIdRBeQlY+H13umR/4A?=
 =?us-ascii?Q?Tyx3eAyuDxa8W8CVBNkP2hs68HFF5QZR+HFMdUKMPIR9Wu7PF65+Dp463BW6?=
 =?us-ascii?Q?ADun8r0qZMXsIqRP6eZwcsC2unl9QuqDrQfwCRM1JuON5+n4z6lOKnhiKhBh?=
 =?us-ascii?Q?Xd6ISZZce8fdbo2ZbSTu4TG+FaQ01IABRXOWNX3MJ1MeXMc1vIBUAhxF1FVM?=
 =?us-ascii?Q?SSV9l84sBy5vubQCmGs/t5WQqRP/cMkjFhlJOI3H+e/6knyvbUg3D2zQ+0QL?=
 =?us-ascii?Q?wFhpEfeFHk9r99imXMlPmOvdO4r79QJGgzGiQ7MbNk+FZx8q3KPtfstjcFo0?=
 =?us-ascii?Q?GZpKywkFscoYDBEzwR3hPhAHfEXdHvogAr+6N3JGsLypUTTjc89fZCuHwF1A?=
 =?us-ascii?Q?277RJNySwcoTXIpIzIS00co3Staq2Kh3lx+P9cEEro1F90ezlol6DYXXIUoK?=
 =?us-ascii?Q?i8/kXMIbzaiA4XmGtxhWsfPphA+hETBnch8xqKZwyu+aZX8WStNEQh13rk+q?=
 =?us-ascii?Q?0I+1+O29Zex08ZssPbM48WZwfjBtpPjh1r5lntPEST/EU6TzPkz4YV5L0kB4?=
 =?us-ascii?Q?zQ12RJtnbFrJpCOolI5YlfClYeUvnPlLg0eFfmdTGdt7rV6GFASJEFviqfXM?=
 =?us-ascii?Q?AnlX4k8LLAvOwarod/5Nl3VN4Bx5xX4HTZa8QckbNYpbVbYmPivfKo95/GSZ?=
 =?us-ascii?Q?hDK+uOTamA46ou4drHsmL+JB4vULkHFkeatG9FxP7JQMK+ZIBemXiRohiwhw?=
 =?us-ascii?Q?Z7agdjtC44vXninDRgYEz6js2/hOanGPJRVyFOKKRYAJJ3tBb/lgU0sTq4zP?=
 =?us-ascii?Q?AcVHqt5FxZiMC7alGnMnFWcXE+bstly7WJNiJuSxaSBW+DGEG6zscDVjj0Tg?=
 =?us-ascii?Q?p+VouFEw9WLjHaU6lYQ7UPcwIqIboIhdcURnkBQ3RJV79qA2BuEQFcgop0JQ?=
 =?us-ascii?Q?mfnuxnXxTY5Ak4xmbBz6tTljWaKR80FLtKuHlfR1cZMz4/FdzGcwShTws1Fm?=
 =?us-ascii?Q?k2sFMPTttMwHtxKhc5erPHA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AEC69BE701B5964286B8037B5242E2BA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8YXCjV/H4bPJn6/jb3367prMAiyxkkFYH7Ycc6+VBD4k8ZciDsnZ6hISpIjf?=
 =?us-ascii?Q?lq7RnaVzmnq5GMis38JDEDTIpV5M2KHWgh9R1seq7zHH1JRYGexiIfqcsj1A?=
 =?us-ascii?Q?FBBrWN1i73PcWB57py6/53t19gKuTWu4wpQojj/W7oFO7M6OqoxTQyrCnJPv?=
 =?us-ascii?Q?5WsS5UM753+BsHPQYw1Wp8RvN+syyDdv7DBG1O1xDXppY/06guP5V4aOWkUF?=
 =?us-ascii?Q?aEY1kHWc65XscpmU8ZBHaDq6F77va7TyuyMuYcIzOURgDe0Cnv4qaojKVwdv?=
 =?us-ascii?Q?wy0Luo7e7UlI4GjyqKzyDG/pg61EB/9r/P9LpANn1NfVg5B0HEbkYBBoVCEA?=
 =?us-ascii?Q?Qq7h2siVXdqKZb48yZXKJ6AdIeZ+pzDpwjqLqh7ZjgkhDSD/OWNoaxuqn9f+?=
 =?us-ascii?Q?gPl6W0V+n9QGyoooBXJV9y+c3JsRAh0sD/JyU13H5qkXvkUposAUfsJ1n8hq?=
 =?us-ascii?Q?QIHxo4yIOL+OtdKpDBGU6+PukoPJEQEEevfY5CJy4AgV/7O0vcAOyL8bCmi2?=
 =?us-ascii?Q?OR8wKOuOPcmGN5rm1mKHDBh4Zv66t635D1dJ9F9z8jcFw92okwugv3luegch?=
 =?us-ascii?Q?KIr+tmgL/NpBn6HhBwzoqedEYy5VynV0fD680nc1TGS8QXJQxpjt+1PuKX3R?=
 =?us-ascii?Q?xc4sbgs79pwY4zppBttxSHH+hSnaMq1azmnb5fL9kY2MC+/eQbLnyNG6LLtg?=
 =?us-ascii?Q?YsweslGKUvnb+W4guVdJJAWVgMhWNb/C+TPFAvyWo1c3sTmcXSh1gAMzdK2i?=
 =?us-ascii?Q?SBRuckqeLQahgmjxRxXgbT3xq7w+Cn2Z7uBuxYAsLGNdb6CLbY/XUjmex3b5?=
 =?us-ascii?Q?A1PAx5UAPMK+Wkb7y69gVlgpyc/akgEPgPCDxhnE/GVidnyJMK0El664gDQ+?=
 =?us-ascii?Q?mOxF8RVwHH+2TTGoRgpyLKdLi2LBbeOyST1qGqAAEFFzXOIKuTybkFqXO3rs?=
 =?us-ascii?Q?U4xj6pIJn5YexJV6lZHDIw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc9f579-cb24-40f4-ed43-08dbb8449e18
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 12:41:45.2580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0norJqhCSCGkS7AdM3x2mSZuDkrlSDuZJB9G30gE/lVRpf+Ry0+5kNlrqd6mP5hMAA4Ye3krg9A5yX39vXpv/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5033
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_05,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180111
X-Proofpoint-GUID: ErM6tf3KnuTiSJis0HfzVjAz5d00KwLG
X-Proofpoint-ORIG-GUID: ErM6tf3KnuTiSJis0HfzVjAz5d00KwLG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> On 18 Sep 2023, at 09:44, Marc Zyngier <maz@kernel.org> wrote:
>=20
> On Wed, 13 Sep 2023 19:52:08 +0100,
> Miguel Luis <miguel.luis@oracle.com> wrote:
>>=20
>> Specify both _EL02 and _EL12 system registers.
>>=20
>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
>> ---
>> arch/arm64/kvm/emulate-nested.c | 35 +++++++++++++++++++++++++++++----
>> 1 file changed, 31 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-ne=
sted.c
>> index 9aa1c06abdb7..957afd97e488 100644
>> --- a/arch/arm64/kvm/emulate-nested.c
>> +++ b/arch/arm64/kvm/emulate-nested.c
>> @@ -690,10 +690,37 @@ static const struct encoding_to_trap_config encodi=
ng_to_cgt[] __initconst =3D {
>> SR_RANGE_TRAP(sys_reg(3, 4, 14, 0, 3),
>> sys_reg(3, 4, 14, 5, 2), CGT_HCR_NV),
>> /* All _EL02, _EL12 registers */
>> - SR_RANGE_TRAP(sys_reg(3, 5, 0, 0, 0),
>> -       sys_reg(3, 5, 10, 15, 7), CGT_HCR_NV),
>> - SR_RANGE_TRAP(sys_reg(3, 5, 12, 0, 0),
>> -       sys_reg(3, 5, 14, 15, 7), CGT_HCR_NV),
>> + SR_TRAP(SYS_SCTLR_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_CPACR_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_SCTLR2_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_ZCR_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_TRFCR_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_SMCR_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_TTBR0_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_TTBR1_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_TCR_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_TCR2_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_SPSR_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_ELR_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_AFSR0_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_AFSR1_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_ESR_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_TFSR_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_FAR_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_BRBCR_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_PMSCR_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_MAIR_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_AMAIR_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_VBAR_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_CONTEXTIDR_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_SCXTNUM_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_CNTKCTL_EL12, CGT_HCR_NV),
>> + SR_TRAP(SYS_CNTP_TVAL_EL02, CGT_HCR_NV),
>> + SR_TRAP(SYS_CNTP_CTL_EL02, CGT_HCR_NV),
>> + SR_TRAP(SYS_CNTP_CVAL_EL02, CGT_HCR_NV),
>> + SR_TRAP(SYS_CNTV_TVAL_EL02, CGT_HCR_NV),
>> + SR_TRAP(SYS_CNTV_CTL_EL02, CGT_HCR_NV),
>> + SR_TRAP(SYS_CNTV_CVAL_EL02, CGT_HCR_NV),
>> SR_TRAP(OP_AT_S1E2R, CGT_HCR_NV),
>> SR_TRAP(OP_AT_S1E2W, CGT_HCR_NV),
>> SR_TRAP(OP_AT_S12E1R, CGT_HCR_NV),
>=20
> While I could see the problem with the EL2 registers, I'm not
> convinced by this patch. Is there an actual case for non _EL02, non
> _EL12 registers that are included in the two ranges above?
>=20

Having DDI0487Ja as reference, there is none. It is not clear to me having =
two
separate ranges. If it is to cover _EL02 and _EL12 ranges separately then t=
he
second range is covering both aliases. I couldn't find the reason for these
aliases start and end other than SYS_SCTLR_EL12 and SYS_CNTV_CVAL_EL02,
respectively.

Thanks
Miguel

> Thanks,
>=20
> M.
>=20
> --=20
> Without deviation from the norm, progress is not possible.


