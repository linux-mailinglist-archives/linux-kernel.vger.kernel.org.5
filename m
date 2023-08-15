Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B00477D352
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbjHOTWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239934AbjHOTVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:21:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A8A1FF3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:21:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FHiH0N015627;
        Tue, 15 Aug 2023 19:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=bYGmI2G9gCygprOtchmx+o1AgHslp4umiahTu3YU1ww=;
 b=W5tAXrrdwMRsOxtsLvI6fX7H6l0l826tDltEP2ARTROXi9grZAK3i+nKkHaT0GFZRCvX
 BENQFAMTJqINwBofZopaam6SmclBSZmVPScYRP1VTCn6fjkM0g187UTBUXPbRW5jCzc0
 QQF4mFSbSsEEox2TysQWWA8rruFyIYCwjllebTxgY2BNTjQVPlPCnmwBkTKZD+uWg1rH
 OQwYql1yddGqb798YW0TNyS7Sl3p4TbWDX1N1ugCRT+chY/2I3qJJTAiE2Sv+AaTS3s8
 i7r4MC/Vj+pvlsQdJ7ovhASt9tgwdK3HUmCucdp6be9atod0PykqXAePTl6bJ+/BB8l/ 5w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2y2wfxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 19:19:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37FHm3Hi005518;
        Tue, 15 Aug 2023 19:19:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2dfdvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 19:19:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1d0dFGR+lKYo81ZY/yFJDCsZ/2mua/+u3wmtMHfRgeKvRuCinUu6tWRmbDFG+aYoHW3sN94urFb6cPB9PBUBb5jQxsex8JAsigaod4L5THPLoi1ipF7bRcR3nX8fdO9CHTKxVdVciYYUtPNNwegvmBBp52DYtJFBYonGxx+wn0mFWy77DKKA+L6hIy/7gJh+/0vSPREsw2xhoyBEatIHALV39FQ+HMFaFDUN6cYUDv1dlgTFuFYajeQmh3t41cb2LWDKxNjYX9Csw0iTSfPUZYvSKJ2ljV5F2/zmFPqEj4sQUAEdNddfOP5HSSXRsyZ67ECgjFzDLlAgBxI17Tt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYGmI2G9gCygprOtchmx+o1AgHslp4umiahTu3YU1ww=;
 b=HzI1Se9Nl11vOeC0SW2Cv7xOHif1QU7EEWRD/Hca+sRTheabIaT9NU0dkvoQzrpAIbAnP3O+UiohngmX8gMt/HzaLS9UuEPesffjTVVezeVorYx7bDsEQjsXFrJ1/ePr0DlGUJG4+Kb11WXl756RH4YlpOjm7oC4dG4iPyNUYVkXVCKmjJfBq1txJvqt8Gs+bOcmzV+zb2HtgTkbCoxd/gaJGJA3nXwzXV5sW1OSq1PCKIyXWJnl7lmnryaREyD7Lshal8Rr/yZ/2NzBAHKTI/sDYaGr+e7+/TK0hulixSClRy77CY5+5VOvMif+Jh+2DmFBo4oZuddeMDep3vJGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYGmI2G9gCygprOtchmx+o1AgHslp4umiahTu3YU1ww=;
 b=0FFbLmzng28fea8g6l5SkR+su5ibMDWlmml5KG/yZqe6V8cxWgeRw2Yec/k9BiZ8m0tvLRWxCD5S+lqcuuAIRJoHkh0Lq5TbvnvS5Hjd1yRGU+1cPTp1L/3s/RoZRqg3IiWFKlwUqafBMF2fSQVHTBTNn3NODJ01XvHQccpb6iA=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 19:19:37 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 19:19:37 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v5] mm/filemap: change ->index to PAGE_SIZE for hugetlb pages
Date:   Tue, 15 Aug 2023 12:19:32 -0700
Message-ID: <20230815191932.273054-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:74::18) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH2PR10MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: 663fe324-bb88-4691-177f-08db9dc490e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rp8RHqv+wKTzMwWp/DCnN9VeUl80ZtdVGdNkfTM3A/NykphjDol9fcxUohZmN35QySb0cObscGR9FnsSeCFbCzARYULyW0nWQgstKTHQ69tNHDVz8bPRD8lYHSnE105TDI46p2pbHh66la2UgFxmOHd/xiBi8EjqN6wP5x5vh2cl7co++H8b+Kzvs1PeRdDUnuf2zzcBKMSV47HYDn66zVseGg5eOO/QKqya4xA/FR0pKuoIQSPccGvzkexz2Ps8uVifFjAM7ewOwOYZwCU6w5mWmzy9UjJgHGpttSUfAAjTQqX92ylQepNvtakHDz/UVcZ2heD9Z1PResaXjBQ724jhKizCVzniklD/2aCfA9D9YAjPr5e8yPtsLgOvjljjHh6qwvD/OibrWpnd4DRMNwksDRJb126gza9UgFVMmKDsCEm/9c5I1QNxCA8MmWXHircz5Jq6pHR8F8S0PGousQzOqbOs+rKVlVSaL85nXsxU6hhmJYbTSMHMoUmByCwiw70dmqtFZJmgPwZp9FD8Mct6Rl01kBP2Yendk2qIr/pMURE7H4DUbnMKEtSyTDaeL35NXCrw+EjdjYxQZ9z88g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199024)(1800799009)(186009)(66899024)(966005)(6512007)(4326008)(36756003)(66946007)(66556008)(66476007)(30864003)(86362001)(316002)(2906002)(8676002)(83380400001)(478600001)(1076003)(2616005)(6506007)(6486002)(38100700002)(6666004)(5660300002)(44832011)(8936002)(41300700001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hFhbHoeknYyz4Kc5DdkagWt/Y0RlzWzMy1XiUT5GUK1N18L2dHOEpbb4p9On?=
 =?us-ascii?Q?qS78AkF1BKStCRx03kvhDhFPuLxX3l9TVqcBW07OSI861Qmdc48RddSMiHT/?=
 =?us-ascii?Q?XAH50igM1Zvc+/zXHwm6npqeVSdcncnRmYp5jyLN3yPTkes+A6fqK+Wzhys6?=
 =?us-ascii?Q?8uRJ7kfnvieZ4FRA6mM5I0Gp2ngNlAX1ekCi+lnIqh7I6Io26+niZm81jnlw?=
 =?us-ascii?Q?FuQtorllFADqTsHSbpRojtNByM3sK6RmazQ08Vs3L8X0TpkuDS+kxLvwP3Hx?=
 =?us-ascii?Q?mSnKt69lKNMlC2csE4ePBx12gs89gpOctw4A1oNo6tjHtuTRaHpsBRsqJ8JR?=
 =?us-ascii?Q?gJILTgQFqjlLP08R/A57pIjSs+WZ0H2J1QkrBJjp0OGiXt8quWCXIt6fzSLq?=
 =?us-ascii?Q?44a6b7DdOostIuLawjPkmpHLHW6B64grGwj0z8J+E+hO7Dh6YPmamtoJcrDy?=
 =?us-ascii?Q?GAC9JNR/qqpjPxwoIQ8y2mRPwWRZnUhmmBgQg81nBpgJs2MjVehZ8f5zL45l?=
 =?us-ascii?Q?xgiZo97eO/sAsy2AsxksW7W2KxaEQugXNzghaB5pyKfAv826mIm0tZVzwZZO?=
 =?us-ascii?Q?exSjEu8aM3yzSpp5FEh4UZXV7o+EE9rvYz6MRKV5E41l5IYBVClTzzwzpIGr?=
 =?us-ascii?Q?/BtG5Fh+bJZDA9ZSSNZM6SGTt/0fZJXjHT4EEq3UiDXnG4tdZJsZqM9+78i/?=
 =?us-ascii?Q?DaexYEfXFZnGpVpYmM1wug2KG2rdxmEIpOPHlPPVOkxq7bRZwfgfHblxhn+/?=
 =?us-ascii?Q?UkfIAOQTJ8Z5xOcCZGXfhAPnbnpkYnaMJOw6i3JWDFMPvrezuarYSsyixYIR?=
 =?us-ascii?Q?5GKbdWuSN0Hqmip3f2tdURk0JCR0hOiz+YpQ0UG7F2GLTFT4vJPaxL7djYpp?=
 =?us-ascii?Q?AZ49o22niwEyOXIsy0XfP6s+s8b1EHtGQW6Du5yk4xwPErj4+WzI+mvvEcYU?=
 =?us-ascii?Q?8Mf0vIfZ+HLXK7caRYBkhO2c+A6LP9Nq3py6QWRmWbFKweGi541QZWzp2vZS?=
 =?us-ascii?Q?v7nYvCpAVKHGH5OFlTVkBVG3+sTfwwvZA6YG9WSwOB/4maIeTD8yTI4yWT4W?=
 =?us-ascii?Q?VmreeM0fR9Cpe56qquOnN7feVU/5eW9Fwx59BproswGW0qNYkWZXqOhhrYZw?=
 =?us-ascii?Q?IwTgv5CaqpampyeOq+09rNOqdjm9UTgSmD+BtYFPs5r9YKUDIDvgiODalfXy?=
 =?us-ascii?Q?OLs2H+cgA+9DYZA/CEpiniXTifF+CJCkVLeLhydg9VrR/GDG+R7uaMQoM5zW?=
 =?us-ascii?Q?n55qqar9CBupw9Xfcz3tJmjuLwZ0JerUutD681YFfPH2b/RbYxbhuDYhAKul?=
 =?us-ascii?Q?mUtuei1+SuCFEYVgHJZY1TKb5ixb3RJTEdFBNmfcNtSOFH8DQGWlNFKVY+hu?=
 =?us-ascii?Q?/ll6qeecoryutAZkwYkKRVYmx8R0F23Fn6DnSANTstE58GlUC9zSyHf9Qz+J?=
 =?us-ascii?Q?TQQMcRFLjiZger4gFnFmjWmk9PNF325DinMWjcD8uZPVDM510uVqojVU9TAJ?=
 =?us-ascii?Q?7zXfdkjyga2WIqeDDqLwMRFqjbhSVTUR8djKq3rxMm+Y4WxEhx0xGISlAcpa?=
 =?us-ascii?Q?g/1ZUyBYAKWhvUK5ygBseQzvtSstOOTUpBJ04UndyMQ+oBp3lUm3LG6rwPoR?=
 =?us-ascii?Q?T3vulwsTVHB/qPpXmVpJimI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YZkuw7Ox3/4G3M6TzXlpPRS3OLIZ/HhbSCJKysus2rEy6u/TesCKZjyvCKiwQqCijEYPo1im0LW2TmVyNiSfQ88VJAIuRBPUBFXU5g8vzdpvRcGyi3Ul0qeEJxPvfqC1bYnZXA7mMrlZajdoS9b01QLlngKBPEKVgwx3OTKxH34rA9dSQsW4tv9WvZQiTpTW8+3lW2br1DneQg7ELEBXzgxVFOUyu876l9aakqtIvnkfdHrvIHn9P9/XY6EhLwYcXYW4YQHQlHeJZJ5gf60UNZcPNUyzQT6nBHVeap7MsQ5ya+c/WXzkvMSNZPsY54EQhXvat4MNO8EUyyFVJRZWhijaUVauzhLGOO0f0zH0TkWN5m3IsrCQamE4uEPO5sneGvA+sVRM6PBrbr39Y7Tp9hIXvnT6h9t0B20n3GbZqOvteBiOveYwziIxrSZbdplB/lIGCtKd9LaFXk1mUBrbrk6vO0e8P7YsB/Qv+i+uKwvI7c5Ws9j3k2kXAMg73T2EDWOY0GVZCj/+RAYcvZ/F38Ryu959jacWwYOxNl+uqOoLu4bBTAT17hf4Wg4kSfecam3Dllr5ENMOFHIZTzUBadcPf8doie3+YF/GWyjwG4E1lYMjNWLwMYZ28UKq/vVEPrBirnFwIMM1tgz1Up4Rj1Z2ko4Gz4DmdMb9d4Un5HztKa5GutMLK68EqzJRiTP7JXyQW22lfK2o7tJgGjS2xXaD1ctqmBQ3H5VzFb4gtvDEWPMqUjYYGSBVk9OS05QMssWvc6w4f6DbuDpe8KWVIzfk6miMwIfeeQqS/OZEf0h2BwakxhSTq+K8Rh9X2+QcBFmUCon2ZAwmb9/m1Eqv1Ehv6AaoCbfrYlOHRVTR+rr3Vc04qn+NH0UK3Ipg5n1VZi7t9uFKFIWfDSN9/d2rPRV+czwMZzVhMlNzuzAnIy0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663fe324-bb88-4691-177f-08db9dc490e0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 19:19:37.5843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /z25BFL3EiNQuodDtI7xUXG9/ChtyeaXU8142XU6buJehaA359OD/JOP6iDRLTq6e3aMvarRpc32QdEwVJhT8H4pdolNYbUpATVobmO70Ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_17,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150174
X-Proofpoint-ORIG-GUID: OnsxvkjJcxYumneougCV-0H06ijpW-x-
X-Proofpoint-GUID: OnsxvkjJcxYumneougCV-0H06ijpW-x-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset attempts to implement a listed filemap TODO which is
changing hugetlb folios to have ->index in PAGE_SIZE. This simplifies many
functions within filemap.c as they have to special case hugetlb pages.
New wrappers for hugetlb code are used to interact with the page cache
using a linear index.

========================= PERFORMANCE ======================================

Perf was used to check the performance differences after the patch. Overall
the performance is similar to mainline with a very small larger overhead that
occurs in __filemap_add_folio() and hugetlb_add_to_page_cache(). This is because
of the larger overhead that occurs in xa_load() and xa_store() as the
xarray is now using more entries to store hugetlb folios in the page cache.

Timing

aarch64
    2MB Page Size
        6.5-rc3 + this patch:
            [root@sidhakum-ol9-1 hugepages]# time fallocate -l 700GB test.txt
            real    1m49.568s
            user    0m0.000s
            sys     1m49.461s

        6.5-rc3:
            [root]# time fallocate -l 700GB test.txt
            real    1m47.495s
            user    0m0.000s
            sys     1m47.370s  
    1GB Page Size
        6.5-rc3 + this patch:
            [root@sidhakum-ol9-1 hugepages1G]# time fallocate -l 700GB test.txt
            real    1m47.024s
            user    0m0.000s
            sys     1m46.921s

        6.5-rc3:
            [root@sidhakum-ol9-1 hugepages1G]# time fallocate -l 700GB test.txt
            real    1m44.551s
            user    0m0.000s
            sys     1m44.438s

x86
    2MB Page Size
        6.5-rc3 + this patch:
            [root@sidhakum-ol9-2 hugepages]# time fallocate -l 100GB test.txt
            real    0m22.383s
            user    0m0.000s
            sys     0m22.255s

        6.5-rc3:
            [opc@sidhakum-ol9-2 hugepages]$ time sudo fallocate -l 100GB /dev/hugepages/test.txt
            real    0m22.735s
            user    0m0.038s
            sys     0m22.567s

    1GB Page Size
        6.5-rc3 + this patch:
            [root@sidhakum-ol9-2 hugepages1GB]# time fallocate -l 100GB test.txt
            real    0m25.786s
            user    0m0.001s
            sys     0m25.589s

        6.5-rc3:
            [root@sidhakum-ol9-2 hugepages1G]# time fallocate -l 100GB test.txt
            real    0m33.454s
            user    0m0.001s
            sys     0m33.193s


aarch64:
    workload - fallocate a 700GB file backed by huge pages 
    
    6.5-rc3 + this patch:
        2MB Page Size:
            --100.00%--__arm64_sys_fallocate
                          ksys_fallocate
                          vfs_fallocate
                          hugetlbfs_fallocate
                          |          
                          |--95.04%--__pi_clear_page
                          |          
                          |--3.57%--clear_huge_page
                          |          |          
                          |          |--2.63%--rcu_all_qs
                          |          |          
                          |           --0.91%--__cond_resched
                          |          
                           --0.67%--__cond_resched
            0.17%     0.00%             0  fallocate  [kernel.vmlinux]       [k] hugetlb_add_to_page_cache
            0.14%     0.10%            11  fallocate  [kernel.vmlinux]       [k] __filemap_add_folio

    6.5-rc3
        2MB Page Size:
                --100.00%--__arm64_sys_fallocate
                          ksys_fallocate
                          vfs_fallocate
                          hugetlbfs_fallocate
                          |          
                          |--94.91%--__pi_clear_page
                          |          
                          |--4.11%--clear_huge_page
                          |          |          
                          |          |--3.00%--rcu_all_qs
                          |          |          
                          |           --1.10%--__cond_resched
                          |          
                           --0.59%--__cond_resched
            0.08%     0.01%             1  fallocate  [kernel.kallsyms]  [k] hugetlb_add_to_page_cache
            0.05%     0.03%             3  fallocate  [kernel.kallsyms]  [k] __filemap_add_folio

x86
    workload - fallocate a 100GB file backed by huge pages 
    
    6.5-rc3 + this patch:
        2MB Page Size:
            hugetlbfs_fallocate
            |          
            --99.57%--clear_huge_page
                |          
                --98.47%--clear_page_erms
                    |          
                    --0.53%--asm_sysvec_apic_timer_interrupt
                
            0.04%     0.04%             1  fallocate  [kernel.kallsyms]     [k] xa_load
            0.04%     0.00%             0  fallocate  [kernel.kallsyms]     [k] hugetlb_add_to_page_cache
            0.04%     0.00%             0  fallocate  [kernel.kallsyms]     [k] __filemap_add_folio
            0.04%     0.00%             0  fallocate  [kernel.kallsyms]     [k] xas_store

    6.5-rc3
        2MB Page Size:
                --99.93%--__x64_sys_fallocate
                          vfs_fallocate
                          hugetlbfs_fallocate
                          |          
                           --99.38%--clear_huge_page
                                     |          
                                     |--98.40%--clear_page_erms
                                     |          
                                      --0.59%--__cond_resched
            0.03%     0.03%             1  fallocate  [kernel.kallsyms]  [k] __filemap_add_folio

========================= TESTING ======================================

This patch passes libhugetlbfs tests and LTP hugetlb tests

********** TEST SUMMARY                                                                                                                                                                                                                    
*                      2M                                                                                                                                                                                                                  
*                      32-bit 64-bit                                                                                                                                                                                                       
*     Total testcases:   110    113                                                                                                                                                                                                        
*             Skipped:     0      0                                                                                                                                                                                                        
*                PASS:   107    113                                                                                                                                                                                                        
*                FAIL:     0      0                                                                                                                                                                                                        
*    Killed by signal:     3      0                                                                                                                                                                                                        
*   Bad configuration:     0      0                                                                                                                                                                                                        
*       Expected FAIL:     0      0                                                                                                                                                                                                        
*     Unexpected PASS:     0      0                                                                                                                                                                                                        
*    Test not present:     0      0                                                                                                                                                                                                        
* Strange test result:     0      0                                                                                                                                                                                                        
**********

###############################################################                                                                                                                                                                                                                                                                                                                                                                                                           
    Done executing testcases.                                                                                                                                                                                                      
    LTP Version:  20220527-178-g2761a81c4                                                                                                                                                                                          
###############################################################

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---

rebased on mm-unstable 08/14/23

RFC v2[1] -> v1[2]
    -change direction of series to maintain both huge and base page size index
     rather than try to get rid of all references to a huge page sized index.

v1 -> v2[3]
    - squash seperate filemap and hugetlb changes into one patch to allow
      for bisection per Matthew
    - get rid of page_to_index()
    - fix errors in hugetlb_fallocate() and remove_inode_hugepages()

v2 -> v3[4]
    - gather performance data per Mike Kravetz
    - remove start variable in remove_inode_hugepages() per Mike Kravetz
    - remove hugetlb special case within folio_file_page()

v3 -> v4[5]
    - rebase to current mm-unstable
    - include time data per Mike Kravetz

v4 -> v5
	- fix build issue by removing hugetlb_basepage_index() definition 
	   per intel test robot

[1]: https://lore.kernel.org/linux-mm/20230519220142.212051-1-sidhartha.kumar@oracle.com/T/
[2]: https://lore.kernel.org/lkml/20230609194947.37196-1-sidhartha.kumar@oracle.com/
[3]: https://lore.kernel.org/lkml/ZLtVlJA+V2+2yjxc@casper.infradead.org/T/
[4]: https://lore.kernel.org/lkml/20230811233939.GA105247@monkey/T/
[5]: https://lore.kernel.org/linux-mm/202308151231.L2pfzOmu-lkp@intel.com/T/#t

 fs/hugetlbfs/inode.c    | 15 +++++++-------
 include/linux/hugetlb.h | 12 +++++++++++
 include/linux/pagemap.h | 29 ++-------------------------
 mm/filemap.c            | 44 +++++++++++++++++++----------------------
 mm/hugetlb.c            | 25 ++++++-----------------
 5 files changed, 48 insertions(+), 77 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index e7611ae1e6120..ec0f856a1228c 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -661,21 +661,20 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 {
 	struct hstate *h = hstate_inode(inode);
 	struct address_space *mapping = &inode->i_data;
-	const pgoff_t start = lstart >> huge_page_shift(h);
-	const pgoff_t end = lend >> huge_page_shift(h);
+	const pgoff_t end = lend >> PAGE_SHIFT;
 	struct folio_batch fbatch;
 	pgoff_t next, index;
 	int i, freed = 0;
 	bool truncate_op = (lend == LLONG_MAX);
 
 	folio_batch_init(&fbatch);
-	next = start;
+	next = lstart >> PAGE_SHIFT;
 	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
 		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
 			struct folio *folio = fbatch.folios[i];
 			u32 hash = 0;
 
-			index = folio->index;
+			index = folio->index >> huge_page_order(h);
 			hash = hugetlb_fault_mutex_hash(mapping, index);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -693,7 +692,9 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 	}
 
 	if (truncate_op)
-		(void)hugetlb_unreserve_pages(inode, start, LONG_MAX, freed);
+		(void)hugetlb_unreserve_pages(inode,
+				lstart >> huge_page_shift(h),
+				LONG_MAX, freed);
 }
 
 static void hugetlbfs_evict_inode(struct inode *inode)
@@ -741,7 +742,7 @@ static void hugetlbfs_zero_partial_page(struct hstate *h,
 	pgoff_t idx = start >> huge_page_shift(h);
 	struct folio *folio;
 
-	folio = filemap_lock_folio(mapping, idx);
+	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 	if (IS_ERR(folio))
 		return;
 
@@ -886,7 +887,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		/* See if already present in mapping to avoid alloc/free */
-		folio = filemap_get_folio(mapping, index);
+		folio = filemap_get_folio(mapping, index << huge_page_order(h));
 		if (!IS_ERR(folio)) {
 			folio_put(folio);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 0a393bc02f25b..1bb3fcacdcddf 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -811,6 +811,12 @@ static inline unsigned int blocks_per_huge_page(struct hstate *h)
 	return huge_page_size(h) / 512;
 }
 
+static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
+				struct address_space *mapping, pgoff_t idx)
+{
+	return filemap_lock_folio(mapping, idx << huge_page_order(h));
+}
+
 #include <asm/hugetlb.h>
 
 #ifndef is_hugepage_only_range
@@ -1005,6 +1011,12 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
 	return NULL;
 }
 
+static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
+				struct address_space *mapping, pgoff_t idx)
+{
+	return NULL;
+}
+
 static inline int isolate_or_dissolve_huge_page(struct page *page,
 						struct list_head *list)
 {
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 71dd79b4ae0ad..6816d3ccbd7e2 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -729,9 +729,6 @@ static inline pgoff_t folio_next_index(struct folio *folio)
  */
 static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
 {
-	/* HugeTLBfs indexes the page cache in units of hpage_size */
-	if (folio_test_hugetlb(folio))
-		return &folio->page;
 	return folio_page(folio, index & (folio_nr_pages(folio) - 1));
 }
 
@@ -747,9 +744,6 @@ static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
  */
 static inline bool folio_contains(struct folio *folio, pgoff_t index)
 {
-	/* HugeTLBfs indexes the page cache in units of hpage_size */
-	if (folio_test_hugetlb(folio))
-		return folio->index == index;
 	return index - folio_index(folio) < folio_nr_pages(folio);
 }
 
@@ -807,10 +801,9 @@ static inline struct folio *read_mapping_folio(struct address_space *mapping,
 }
 
 /*
- * Get index of the page within radix-tree (but not for hugetlb pages).
- * (TODO: remove once hugetlb pages will have ->index in PAGE_SIZE)
+ * Get the offset in PAGE_SIZE (even for hugetlb pages).
  */
-static inline pgoff_t page_to_index(struct page *page)
+static inline pgoff_t page_to_pgoff(struct page *page)
 {
 	struct page *head;
 
@@ -825,19 +818,6 @@ static inline pgoff_t page_to_index(struct page *page)
 	return head->index + page - head;
 }
 
-extern pgoff_t hugetlb_basepage_index(struct page *page);
-
-/*
- * Get the offset in PAGE_SIZE (even for hugetlb pages).
- * (TODO: hugetlb pages should have ->index in PAGE_SIZE)
- */
-static inline pgoff_t page_to_pgoff(struct page *page)
-{
-	if (unlikely(PageHuge(page)))
-		return hugetlb_basepage_index(page);
-	return page_to_index(page);
-}
-
 /*
  * Return byte-offset into filesystem object for page.
  */
@@ -874,12 +854,9 @@ static inline loff_t folio_file_pos(struct folio *folio)
 
 /*
  * Get the offset in PAGE_SIZE (even for hugetlb folios).
- * (TODO: hugetlb folios should have ->index in PAGE_SIZE)
  */
 static inline pgoff_t folio_pgoff(struct folio *folio)
 {
-	if (unlikely(folio_test_hugetlb(folio)))
-		return hugetlb_basepage_index(&folio->page);
 	return folio->index;
 }
 
@@ -890,8 +867,6 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 					unsigned long address)
 {
 	pgoff_t pgoff;
-	if (unlikely(is_vm_hugetlb_page(vma)))
-		return linear_hugepage_index(vma, address);
 	pgoff = (address - vma->vm_start) >> PAGE_SHIFT;
 	pgoff += vma->vm_pgoff;
 	return pgoff;
diff --git a/mm/filemap.c b/mm/filemap.c
index 014b73eb96a1d..ce70b0b7bbd43 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -134,11 +134,8 @@ static void page_cache_delete(struct address_space *mapping,
 
 	mapping_set_update(&xas, mapping);
 
-	/* hugetlb pages are represented by a single entry in the xarray */
-	if (!folio_test_hugetlb(folio)) {
-		xas_set_order(&xas, folio->index, folio_order(folio));
-		nr = folio_nr_pages(folio);
-	}
+	xas_set_order(&xas, folio->index, folio_order(folio));
+	nr = folio_nr_pages(folio);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
@@ -237,7 +234,7 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 	if (free_folio)
 		free_folio(folio);
 
-	if (folio_test_large(folio) && !folio_test_hugetlb(folio))
+	if (folio_test_large(folio))
 		refs = folio_nr_pages(folio);
 	folio_put_refs(folio, refs);
 }
@@ -858,14 +855,15 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 
 	if (!huge) {
 		int error = mem_cgroup_charge(folio, NULL, gfp);
-		VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
 		if (error)
 			return error;
 		charged = true;
-		xas_set_order(&xas, index, folio_order(folio));
-		nr = folio_nr_pages(folio);
 	}
 
+	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
+	xas_set_order(&xas, index, folio_order(folio));
+	nr = folio_nr_pages(folio);
+
 	gfp &= GFP_RECLAIM_MASK;
 	folio_ref_add(folio, nr);
 	folio->mapping = mapping;
@@ -2038,7 +2036,7 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
 		*start = indices[idx] + nr;
 	}
@@ -2102,7 +2100,7 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
 		*start = indices[idx] + nr;
 	}
@@ -2143,9 +2141,6 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
 			unsigned long nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
@@ -2168,6 +2163,16 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 }
 EXPORT_SYMBOL(filemap_get_folios);
 
+static inline
+bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)
+{
+	if (!folio_test_large(folio))
+		return false;
+	if (index >= max)
+		return false;
+	return index < folio_next_index(folio) - 1;
+}
+
 /**
  * filemap_get_folios_contig - Get a batch of contiguous folios
  * @mapping:	The address_space to search
@@ -2211,9 +2216,6 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
 		if (!folio_batch_add(fbatch, folio)) {
 			nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
@@ -2230,10 +2232,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
 	if (nr) {
 		folio = fbatch->folios[nr - 1];
-		if (folio_test_hugetlb(folio))
-			*start = folio->index + 1;
-		else
-			*start = folio_next_index(folio);
+		*start = folio->index + folio_nr_pages(folio);
 	}
 out:
 	rcu_read_unlock();
@@ -2271,9 +2270,6 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
 			unsigned long nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e327a5a7602cb..dfd5bc63e61a1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -952,7 +952,7 @@ static long region_count(struct resv_map *resv, long f, long t)
 
 /*
  * Convert the address within this vma to the page offset within
- * the mapping, in pagecache page units; huge pages here.
+ * the mapping, huge page units here.
  */
 static pgoff_t vma_hugecache_offset(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
@@ -2113,20 +2113,6 @@ struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage)
 	return NULL;
 }
 
-pgoff_t hugetlb_basepage_index(struct page *page)
-{
-	struct page *page_head = compound_head(page);
-	pgoff_t index = page_index(page_head);
-	unsigned long compound_idx;
-
-	if (compound_order(page_head) > MAX_ORDER)
-		compound_idx = page_to_pfn(page) - page_to_pfn(page_head);
-	else
-		compound_idx = page - page_head;
-
-	return (index << compound_order(page_head)) + compound_idx;
-}
-
 static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 		gfp_t gfp_mask, int nid, nodemask_t *nmask,
 		nodemask_t *node_alloc_noretry)
@@ -5750,7 +5736,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
 {
 	struct address_space *mapping = vma->vm_file->f_mapping;
-	pgoff_t idx = vma_hugecache_offset(h, vma, address);
+	pgoff_t idx = linear_page_index(vma, address);
 	struct folio *folio;
 
 	folio = filemap_get_folio(mapping, idx);
@@ -5767,6 +5753,7 @@ int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping
 	struct hstate *h = hstate_inode(inode);
 	int err;
 
+	idx <<= huge_page_order(h);
 	__folio_set_locked(folio);
 	err = __filemap_add_folio(mapping, folio, idx, GFP_KERNEL, NULL);
 
@@ -5874,7 +5861,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * before we get page_table_lock.
 	 */
 	new_folio = false;
-	folio = filemap_lock_folio(mapping, idx);
+	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 	if (IS_ERR(folio)) {
 		size = i_size_read(mapping->host) >> huge_page_shift(h);
 		if (idx >= size)
@@ -6183,7 +6170,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Just decrements count, does not deallocate */
 		vma_end_reservation(h, vma, haddr);
 
-		pagecache_folio = filemap_lock_folio(mapping, idx);
+		pagecache_folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 		if (IS_ERR(pagecache_folio))
 			pagecache_folio = NULL;
 	}
@@ -6315,7 +6302,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 
 	if (is_continue) {
 		ret = -EFAULT;
-		folio = filemap_lock_folio(mapping, idx);
+		folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 		if (IS_ERR(folio))
 			goto out;
 		folio_in_pagecache = true;
-- 
2.41.0

