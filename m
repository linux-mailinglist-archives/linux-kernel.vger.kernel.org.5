Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5917AF40B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjIZTVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjIZTVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:21:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3701DE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:21:00 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QFO6a4025549;
        Tue, 26 Sep 2023 19:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=O3umrKezqoFd1lyzXozt/Ov5Ah5XMnPPHGCef/lvpjM=;
 b=BtbRJ7sAuPwIicvsxJvdolL0hj4hC2BxzN5J65ej5OqcPK1+iIgPMrQ8Dnx3KOwAcZQR
 +0ODCuyXjg5rsRadMklUjrIdmN6lRblgFVGpmHpkaxcKPI9M9HLadTKmvzILVNPxxPbS
 aLr5ZHSS1X1o58N0iHrPtExaCkOd3vwAwAKk43X3QrCPOXrHllreXTyQz/9rOx4kBxyS
 EWyvp/T95RiIpurltl2CAKJYbRLr2hL87Lzd4iGGTsF/2wggTwFcImncw8tUoLLxmM2D
 i3btBtzBLbJ3FspSD3xCcS9EnzcBan/gt6FlXA00ao51fRwChHkqLSvdP2La5HXvIpDw Ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9r2dfk8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 19:20:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38QJFtVF003425;
        Tue, 26 Sep 2023 19:20:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf6uw73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 19:20:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKZ3ph11056+miVzr9nUUwzQLVPjvB9WjosHGArpxooxKtfxxdi2nBlu/04Iiqie3VtVegooXdKXKFhrr0TlMD0A6dHb91Q8XO2JePX932Ic/O8qIOCfxVVmmr414tdQPH8cIb3nSDQx2tQM+WIHbYLWwsmTa8PE3+25UKvNMKoy7TC9Docjc+jneoqP04HvnprbGH5mdaxcdx6r7sXCa72IlfGazZgYMvJxOkRb8zYuzH+SzdsTnWh/Bv0e/dQYhXPXfLWHd926Ft9VwN6bsMZJgZGI2JLtTvX6ayb8o6PzAie7b6f3dqVSe0DwWsWKD3JvQgo2kQrk0hcVDOVhHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3umrKezqoFd1lyzXozt/Ov5Ah5XMnPPHGCef/lvpjM=;
 b=Vi5gvGFQvjp5QDs+zuqK3mvL8FnBQDmdAktTaW4EG3ArJ4w8+0XhoDMEN880EVXZNClOEwMfmpPcIXTaw6hxRwSdFQywy70u8qVeBu6krUPBiEykuZci7CHrTW4DBI0c1tK7OhpRoEhGA1kVmYe0Nn438AGwuevjdEpYXJ2xgwc3Wz8IdBUQIUBekW/TyJsKZRBpCHmgSC5FMkm7TKZH7pXKkQkf41kmEhd7uXgPuhTZAUp9ibm7aZikHgjMi78mVnOuDG0orVm3IeKSOOwiuC5XF6xk9/KWg176Oh3U0N9+4SRQePQLKIqS8g93J80eqDtdrod1Bx1Yu640naEmUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3umrKezqoFd1lyzXozt/Ov5Ah5XMnPPHGCef/lvpjM=;
 b=jtF2qZhDEsbATZhlMa40XXuEdYPzzeHO3dkWmHnla7oEcNpmjPkqmiUMvuBCAuX/Pl24w9AIgEDdXLlUQzr6LVe4+6SZMGv8iBKtIXxBuaZzs8Z388aF3BLdVpSw9lAl+qyDBqbcaIn6UK5d/ZEOWOyeANj579AdtVwRhLAJZEc=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB6038.namprd10.prod.outlook.com (2603:10b6:8:8f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Tue, 26 Sep 2023 19:20:22 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::c96b:bc13:b1d3:2ef]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::c96b:bc13:b1d3:2ef%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 19:20:22 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        syzbot+c225dea486da4d5592bd@syzkaller.appspotmail.com
Subject: [PATCH v8] mm/filemap: remove hugetlb special casing in filemap.c
Date:   Tue, 26 Sep 2023 12:20:17 -0700
Message-ID: <20230926192017.98183-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:a03:333::19) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd8497b-12e3-4898-02b3-08dbbec5a133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DEeV14qBqA3y15yORC/oblhMKbInvYrvs3KpxbfEBYsNO4Py4ZdAbX+gRu/RAjsVZkZe0/Ms6nbEvpvmbSGkD2PI+3bdiLBBpV8bPeqiARKzD0IWFdYXVgaV/sCLYy9/C3cf4g1aW25WdfqJpJP8ydAIYGEytY3iCHH8QOwRPhJQEmrIBnzE5stkRh1Gnsi9HDmG0eD/J/nbmlkny29B1WBrlfl4uVhIGdfN9fft+qcg+oAITu/K4Tg9hziFV1Hqx3bjeZU6r7/Y/3wj7uOvsIV2T4RXW88ebCIkZMnunhKPx2P3Ckv3rJK6GCKVO1CTTOY1dVJJVPPOn4aJR2JeW1xwHBz2KvuujmQxmkT3CEX2zsumxOc45IAJE/jU2qGPiR7uRUoVbtR9MKJb9W/ntj1VwznWeQ4d+JyFbKckETBlrcvrJxrhLyj4D5nXJGw7WC1ouIeTLtYU6MzBChXyrWWedNdrIx3nNOE9AO6JzODsR5nn6Rj+7lllDLh7s4Uym2zgrEVgRB7ff+dTeDon8S+ldkJ7SvPBdlZbV6YqeWwR0P90xHTg+g2kac3VmX/aDWYhuID7A1e8uRmuWrcYG+t4SVyl2Td6pLgI43EfnrfWkdP/m5JQAClBshT2TtWeVitUA/hs0wbHBtQgeZzdMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(376002)(396003)(230922051799003)(451199024)(186009)(1800799009)(6506007)(6486002)(38100700002)(966005)(1076003)(2616005)(478600001)(6666004)(6512007)(66476007)(66946007)(66556008)(83380400001)(316002)(41300700001)(30864003)(66899024)(86362001)(2906002)(36756003)(44832011)(5660300002)(8676002)(4326008)(8936002)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wWLlSkIULXJhOZOw2Fs1Ps+Ia+Cd01YafPszqQsAn6YrnUDduuCcF3qA2S8+?=
 =?us-ascii?Q?1Z05Pd1Hxy3e5KOyQ81lQtXXpvcF1stUZXw/XHrjfYg8uWiHoTJ0kNBbZmqp?=
 =?us-ascii?Q?bCq5GB2ceguP/3IbUpdPstiRfQDOYbqDk5Za1v94xhuOIhrrkXgbtoCmW4aq?=
 =?us-ascii?Q?a+2b9Ro5lSfQmkINlMFME18MZVacGmKWqQmWIYmVbGIRvDL+QpBkrkDw2s+I?=
 =?us-ascii?Q?4IPVJRP7NeSNdV3QK5TrA2EUVeD2PC8FhuYi2sPdINrPyatKffCuXh/xYdIl?=
 =?us-ascii?Q?h+BrGe9BqDAjIJRl3ysCxcJMuVeTVeIsHTfW/MP+QK6LahXIQNQ+OsNO5qoz?=
 =?us-ascii?Q?ohrPemQZjQE43t/mnFPVnAaLKPJhGMN+T0TsxAzp0utEMIubrwqDKcgQxkS4?=
 =?us-ascii?Q?kIISDyiZupXXkO2yrudoeiYIxHnGVol1Zho0u17A+cAznEmeAOR1ReCxNwvO?=
 =?us-ascii?Q?7BmLy/HsqodmkaL/gYaY+V4G8Cs5TShl+maMB/zhQdVOWJW4XpZA1ek3LW3Y?=
 =?us-ascii?Q?lwxFw2AFerdQZ+RsTCqpNkX5iQreZK+fPhFOl9ODqe9qoVdyPD6y7rlQ5PBJ?=
 =?us-ascii?Q?RtAEYevi3uMUS+4ZU7YhDVw9sgYj1g+PBOmxnGSv33j0G4+0v7xDTCHDaSe7?=
 =?us-ascii?Q?AUx6CGBgJ/zsyOsjOtErIVd4UV6IzVtYMmy9AhtiL9JTeitl3ZfkAA18ISH/?=
 =?us-ascii?Q?PvN4dJuCXi9gfRoCT/j3ggX47IiJKzfMK+tpYkH3O8mylLvz2l4cVKe9V6C5?=
 =?us-ascii?Q?vEct4ray6H9J3p9OTSAu7QIOBRTnlKb1CxoD2q6sukSu3VlyFndoGQBVSb3E?=
 =?us-ascii?Q?D0wQS9cfmEQlSEB8Pax40r41SRp/R/BJGMvNZM0v9KLQ4eFM82ZD6VdJGYkV?=
 =?us-ascii?Q?XWDheNM36xv+gaGWZice6PuublFxiI7uNc2FI2EbnVDuqkA3rNuwMe/+mNKo?=
 =?us-ascii?Q?jmIxs75tYHEFzRncROiF8tFdfhtN5gqWH3BtqTTEcsEWlOUa5XAgE/2PS3O1?=
 =?us-ascii?Q?MYa1fM4eq+oTAhYbVQiBGoJLVZ8D4uJIXl7G8O6cUWW5822L4U+bP3noZ3x7?=
 =?us-ascii?Q?2LXj4yaVymIuNflBeBsCFyc9cboV26otgtObD8DFF0TCTqq0SzMDh4IdqO7x?=
 =?us-ascii?Q?uHvxkNLZcKvPeW7R4MHp8teOdqtMyVEcs/ZtNH45R4fA7eruUFBN7QV1yRNQ?=
 =?us-ascii?Q?dWSlHjzdPMQ0WB7TLY3IAb9zULAxkgejGj2xWdCBl319jUX9XOYlj8pMJU/3?=
 =?us-ascii?Q?pKmiWMRQ2DYCrZV95robA/lr29BDcpweRuuVfXJmMemi+Q0zixUSaav6KU6Q?=
 =?us-ascii?Q?YJ7vPouBc6onl06LhcVVu+nIcuTgsKbAUmcDlLPGKO0/JG0kZHYkImSNFnmr?=
 =?us-ascii?Q?y3llBt5GfAM/pAC2l6AaZb8WoV7w1dE+NLiwewNQXO96zMMVPpEnZg7bFU0N?=
 =?us-ascii?Q?ODeqgxY2+ciT+wJFTriKBmoaFyYCvFDSrAb5Cayn2SlKMxjU7MHUQJ6YEIQB?=
 =?us-ascii?Q?O88Dtw6e15QA6XWjRj3W6ZSoCuQf7C+xWhTCqMOINaqfW+LBIikOZKT3uOeo?=
 =?us-ascii?Q?cNR3/GS4FnwZA1e88vHkY3U7qjvMy5bF62u+2Jdbs9FfiGBylk/lIab90fnF?=
 =?us-ascii?Q?g+w+410M2Hlu+z3HYL4nhmY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?v/cwyyNKgyWxpI0ESny80I69chwdEZC2tgP67bwCcoH0hUMh0klHY/ASaWvO?=
 =?us-ascii?Q?RWhK9RjuaLwXU2mUh+NvDYWq1K5hl3BNEUV35LNslNvVbX4vq+2D6QfLqHa3?=
 =?us-ascii?Q?Vg3Dl6Rak14aGLW5ID5Ht1LWuPGlnb1z+xNuOyDL8ggXi6vwxqtHusab3Bb+?=
 =?us-ascii?Q?lqhJb5rhUDNIEi5QZ0aeZcOsPiIqExuEnGD+ymBMlm3TVHOqVjAGyp87sg3S?=
 =?us-ascii?Q?vFxTDwmqKq7+bia/U6hM6vr4R2voRMRaTm+sP8I+LGuEXHuSPChfJbxvrRYE?=
 =?us-ascii?Q?NSIuQs+kjY/PqW9XwGYhnzujYtvXI4ifx2aIxBooC4I2LgE7MLxjoZb+FS+d?=
 =?us-ascii?Q?sm3L7kgyegciLnAHi32/OPvAdk7gE4XD60Ez7nedvsQTSu+3+7Ja4TXg5NJR?=
 =?us-ascii?Q?umQwT8W7qBe8SHPsj5Nyubu58NrQcSL3cKjjFo+iNbLuoIvBhsDfORZEArif?=
 =?us-ascii?Q?fRgQlB0FDw6KtstTwpUY21dyymBqtsb0ooTgMuGy6FKP89gw5rPa1cGVcPmh?=
 =?us-ascii?Q?FcoHKVOUChvbVJjBWOvrqnhJ9buerjMt2Ez+X8R215xzrI8+6eXDZQTBhvbD?=
 =?us-ascii?Q?0iH92pddPw1qsUDqkwLC/BesQ52pvS+YKg6uVImmg2GWjstoneXYpWspVJ1D?=
 =?us-ascii?Q?K1bT6062daT1v2KMMdU1AICxERE1RKpF6aO3IrgKV4BGWGERSQ3SAZXBE8cQ?=
 =?us-ascii?Q?GlOf0LZxdaWl59fm8L+NnTJTAaUEW0NFhzSZ6dDbymXms0MQBw0IlIwz1rRD?=
 =?us-ascii?Q?AeBOe6s9Es27fY+bmGqrAjsv/Cgr1oYqSXNNPFDjNZkEXevA/9TDP+zgBT1k?=
 =?us-ascii?Q?2JmGe4lyUtGJuxnNnit9oOYGRFRecDiNz3sdRQfDEMUj/uKbbG7RqU2Y61Ir?=
 =?us-ascii?Q?UxGz5ty9/KmtWsgQ0oYUuPLyPajV4q8Z48dXdvsAkRWtatbskjQZiB9WqXAZ?=
 =?us-ascii?Q?iP03ryhYrYi242fKZ+/YUa0mhbMjkOTXRjLM9uJP0xU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd8497b-12e3-4898-02b3-08dbbec5a133
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 19:20:22.7036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hdq1vCkCSyz7xB5swZnP26sct4GWf8Fy9L4riBQStR7Vk8IZ9Rk8mIwuYFZ0YAqWHygsilRcswnqBzOek7go/W++ZFDuLBs1QvtONpAv6GQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6038
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309260167
X-Proofpoint-GUID: U1Y5P9HqrTOw3wYh_Tpe5qEtbuu7MYyi
X-Proofpoint-ORIG-GUID: U1Y5P9HqrTOw3wYh_Tpe5qEtbuu7MYyi
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove special cased hugetlb handling code within the page cache by
changing the granularity of ->index to the base page size rather than the
huge page size. The motivation of this patch is to reduce complexity
within the filemap code while also increasing performance by removing
branches that are evaluated on every page cache lookup.

To support the change in index, new wrappers for hugetlb page cache
interactions are added. These wrappers perform the conversion to a linear
index which is now expected by the page cache for huge pages.

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

    Done executing testcases.
    LTP Version:  20220527-178-g2761a81c4

page migration was also tested using Mike Kravetz's test program.[8]

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reported-and-tested-by: syzbot+c225dea486da4d5592bd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c225dea486da4d5592bd
---

rebased on mm-unstable 09/26/23

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

v4 -> v5[6]
    - fix build issue by removing hugetlb_basepage_index() definition
       per intel test robot

v5 -> v6[7]
    - remove folio_more_pages() from result of incorrect rebase

v6 -> v7[9]:
    - clarify commit message to demonstrate the benefits of this patch.
    - fix error in hugepage migration by using folio_expected_refs() rather
      than 2 in migrate_huge_page_move_mapping() and increase the dst folio
      ref count by folio_nr_pages().
        - this error is due to __filemap_add_folio() increasing the ref
          count of the huge folio by folio_nr_pages() which
          migrate_huge_page_move_mapping() did not handle
    - remove linear_hugepage_index() as it is no longer used per Matthew Wilcox.

v7 -> v8:
    - fix syzbot reported error in hugetlbfs_read_iter() by using
      filemap_lock_hugetlb_folio() for page cache lookup.


[1]: https://lore.kernel.org/linux-mm/20230519220142.212051-1-sidhartha.kumar@oracle.com/T/
[2]: https://lore.kernel.org/lkml/20230609194947.37196-1-sidhartha.kumar@oracle.com/
[3]: https://lore.kernel.org/lkml/ZLtVlJA+V2+2yjxc@casper.infradead.org/T/
[4]: https://lore.kernel.org/lkml/20230811233939.GA105247@monkey/T/
[5]: https://lore.kernel.org/linux-mm/202308151231.L2pfzOmu-lkp@intel.com/T/#t
[6]: https://lore.kernel.org/linux-mm/20230815191932.273054-1-sidhartha.kumar@oracle.com/T/
[7]: https://lore.kernel.org/linux-mm/ZOTtK1Kfa5gCS3Gb@casper.infradead.org/T/
[8]: https://lore.kernel.org/linux-mm/20230907001832.GA63356@monkey/T/#m35ed80fc2bb21d613bc4cc8771159d6ae0b5a264
[9]: https://lore.kernel.org/linux-mm/20230911215319.644224-1-sidhartha.kumar@oracle.com/T/


 fs/hugetlbfs/inode.c    | 37 +++++++++++++++++++------------------
 include/linux/hugetlb.h | 12 ++++++++++++
 include/linux/pagemap.h | 32 ++------------------------------
 mm/filemap.c            | 34 ++++++++++------------------------
 mm/hugetlb.c            | 32 ++++++--------------------------
 mm/migrate.c            |  6 +++---
 6 files changed, 52 insertions(+), 101 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 60fce26ff937..60bdf5967bff 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -334,7 +334,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	ssize_t retval = 0;
 
 	while (iov_iter_count(to)) {
-		struct page *page;
+		struct folio *folio;
 		size_t nr, copied, want;
 
 		/* nr is the maximum number of bytes to copy from this page */
@@ -352,18 +352,18 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		}
 		nr = nr - offset;
 
-		/* Find the page */
-		page = find_lock_page(mapping, index);
-		if (unlikely(page == NULL)) {
+		/* Find the folio */
+		folio = filemap_lock_hugetlb_folio(h, mapping, index);
+		if (unlikely(folio == NULL)) {
 			/*
 			 * We have a HOLE, zero out the user-buffer for the
 			 * length of the hole or request.
 			 */
 			copied = iov_iter_zero(nr, to);
 		} else {
-			unlock_page(page);
+			folio_unlock(folio);
 
-			if (!PageHWPoison(page))
+			if (!folio_test_has_hwpoisoned(folio))
 				want = nr;
 			else {
 				/*
@@ -371,19 +371,19 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 				 * touching the 1st raw HWPOISON subpage after
 				 * offset.
 				 */
-				want = adjust_range_hwpoison(page, offset, nr);
+				want = adjust_range_hwpoison(&folio->page, offset, nr);
 				if (want == 0) {
-					put_page(page);
+					folio_put(folio);
 					retval = -EIO;
 					break;
 				}
 			}
 
 			/*
-			 * We have the page, copy it to user space buffer.
+			 * We have the folio, copy it to user space buffer.
 			 */
-			copied = copy_page_to_iter(page, offset, want, to);
-			put_page(page);
+			copied = copy_folio_to_iter(folio, offset, want, to);
+			folio_put(folio);
 		}
 		offset += copied;
 		retval += copied;
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
index 547f8d5ec6f2..3c4427a2396d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -813,6 +813,12 @@ static inline unsigned int blocks_per_huge_page(struct hstate *h)
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
@@ -1009,6 +1015,12 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
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
index 351c3b7f93a1..759b29d9a69a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -789,9 +789,6 @@ static inline pgoff_t folio_next_index(struct folio *folio)
  */
 static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
 {
-	/* HugeTLBfs indexes the page cache in units of hpage_size */
-	if (folio_test_hugetlb(folio))
-		return &folio->page;
 	return folio_page(folio, index & (folio_nr_pages(folio) - 1));
 }
 
@@ -807,9 +804,6 @@ static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
  */
 static inline bool folio_contains(struct folio *folio, pgoff_t index)
 {
-	/* HugeTLBfs indexes the page cache in units of hpage_size */
-	if (folio_test_hugetlb(folio))
-		return folio->index == index;
 	return index - folio_index(folio) < folio_nr_pages(folio);
 }
 
@@ -867,10 +861,9 @@ static inline struct folio *read_mapping_folio(struct address_space *mapping,
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
 
@@ -885,19 +878,6 @@ static inline pgoff_t page_to_index(struct page *page)
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
@@ -934,24 +914,16 @@ static inline loff_t folio_file_pos(struct folio *folio)
 
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
 
-extern pgoff_t linear_hugepage_index(struct vm_area_struct *vma,
-				     unsigned long address);
-
 static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 					unsigned long address)
 {
 	pgoff_t pgoff;
-	if (unlikely(is_vm_hugetlb_page(vma)))
-		return linear_hugepage_index(vma, address);
 	pgoff = (address - vma->vm_start) >> PAGE_SHIFT;
 	pgoff += vma->vm_pgoff;
 	return pgoff;
diff --git a/mm/filemap.c b/mm/filemap.c
index 9481ffaf24e6..340c693112a9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -131,11 +131,8 @@ static void page_cache_delete(struct address_space *mapping,
 
 	mapping_set_update(&xas, mapping);
 
-	/* hugetlb pages are represented by a single entry in the xarray */
-	if (!folio_test_hugetlb(folio)) {
-		xas_set_order(&xas, folio->index, folio_order(folio));
-		nr = folio_nr_pages(folio);
-	}
+	xas_set_order(&xas, folio->index, folio_order(folio));
+	nr = folio_nr_pages(folio);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
@@ -234,7 +231,7 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 	if (free_folio)
 		free_folio(folio);
 
-	if (folio_test_large(folio) && !folio_test_hugetlb(folio))
+	if (folio_test_large(folio))
 		refs = folio_nr_pages(folio);
 	folio_put_refs(folio, refs);
 }
@@ -855,14 +852,15 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 
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
@@ -2040,7 +2038,7 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
 		*start = indices[idx] + nr;
 	}
@@ -2104,7 +2102,7 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
 		*start = indices[idx] + nr;
 	}
@@ -2145,9 +2143,6 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
 			unsigned long nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
@@ -2213,9 +2208,6 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
 		if (!folio_batch_add(fbatch, folio)) {
 			nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
@@ -2232,10 +2224,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
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
@@ -2273,9 +2262,6 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
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
index a82dc37669b0..dc35ae8fdd61 100644
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
@@ -961,13 +961,6 @@ static pgoff_t vma_hugecache_offset(struct hstate *h,
 			(vma->vm_pgoff >> huge_page_order(h));
 }
 
-pgoff_t linear_hugepage_index(struct vm_area_struct *vma,
-				     unsigned long address)
-{
-	return vma_hugecache_offset(hstate_vma(vma), vma, address);
-}
-EXPORT_SYMBOL_GPL(linear_hugepage_index);
-
 /**
  * vma_kernel_pagesize - Page size granularity for this VMA.
  * @vma: The user mapping.
@@ -2074,20 +2067,6 @@ struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage)
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
@@ -5772,7 +5751,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
 {
 	struct address_space *mapping = vma->vm_file->f_mapping;
-	pgoff_t idx = vma_hugecache_offset(h, vma, address);
+	pgoff_t idx = linear_page_index(vma, address);
 	struct folio *folio;
 
 	folio = filemap_get_folio(mapping, idx);
@@ -5789,6 +5768,7 @@ int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping
 	struct hstate *h = hstate_inode(inode);
 	int err;
 
+	idx <<= huge_page_order(h);
 	__folio_set_locked(folio);
 	err = __filemap_add_folio(mapping, folio, idx, GFP_KERNEL, NULL);
 
@@ -5896,7 +5876,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * before we get page_table_lock.
 	 */
 	new_folio = false;
-	folio = filemap_lock_folio(mapping, idx);
+	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 	if (IS_ERR(folio)) {
 		size = i_size_read(mapping->host) >> huge_page_shift(h);
 		if (idx >= size)
@@ -6205,7 +6185,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Just decrements count, does not deallocate */
 		vma_end_reservation(h, vma, haddr);
 
-		pagecache_folio = filemap_lock_folio(mapping, idx);
+		pagecache_folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 		if (IS_ERR(pagecache_folio))
 			pagecache_folio = NULL;
 	}
@@ -6345,7 +6325,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 
 	if (is_continue) {
 		ret = -EFAULT;
-		folio = filemap_lock_folio(mapping, idx);
+		folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 		if (IS_ERR(folio))
 			goto out;
 		folio_in_pagecache = true;
diff --git a/mm/migrate.c b/mm/migrate.c
index 7d1804c4a5d9..98cb580506fa 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -524,7 +524,7 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 	int expected_count;
 
 	xas_lock_irq(&xas);
-	expected_count = 2 + folio_has_private(src);
+	expected_count = folio_expected_refs(mapping, src);
 	if (!folio_ref_freeze(src, expected_count)) {
 		xas_unlock_irq(&xas);
 		return -EAGAIN;
@@ -533,11 +533,11 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 	dst->index = src->index;
 	dst->mapping = src->mapping;
 
-	folio_get(dst);
+	folio_ref_add(dst, folio_nr_pages(dst));
 
 	xas_store(&xas, dst);
 
-	folio_ref_unfreeze(src, expected_count - 1);
+	folio_ref_unfreeze(src, expected_count - folio_nr_pages(src));
 
 	xas_unlock_irq(&xas);
 
-- 
2.41.0

