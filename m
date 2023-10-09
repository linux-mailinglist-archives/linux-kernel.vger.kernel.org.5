Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D237BEB6E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378605AbjJIUR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378542AbjJIURW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:17:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628CAAF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:17:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399EY1D4011856;
        Mon, 9 Oct 2023 20:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=YwQb0DIxoJyP5+IFsFqNbGXDkpMjZDV85JlYJvKhtDU=;
 b=l9szEhTItZWqyQqDSDGmmXwyHmoD1dhCFwjZC8FrD47u1NwZHgmjk7BTIHrxcePaqyML
 A4yoFm6n/3Yrq7kl6+4ThaPzTCnCTB/+DSS/fnaut/xD+Bfm7h/xao0n/o18lTaAtvxf
 u/qDjCL22XpAdtP8P/FktRcau8QZmZ3ZZU2gcoki8eDsQuIVCiWQu3CD916aZB2rz40Q
 xu9QB3bcHeor0m6JP+hndZutI7Qa7zGpT9I+7HvrB1UhKYOR5pkpoCcBNz3FFg84q6YJ
 JAdUzBV97T7alAMfHhq7CwxbD2cw9iBKV5VMM5ODypvpKdRf4SSelkOJwkfeRjqNIq4+ OQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh89s0v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 20:16:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 399K8gk2016304;
        Mon, 9 Oct 2023 20:16:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws5p2n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 20:16:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P99TkhiIvh8yUVQRVwub/EaNKOuqmykMDv3EGYk6LnhkIIDQQmHoxn5baqV4VvHZe539jLkg0p3bS6ld2aRik0vdv+ztS19mjGOlGWNH3PHjqmMGI4Zdvh+4+2si8IEZehw7Vzi/tiSAuAjHiDkKMbZl548WZIMbZyaoluz69nQ4rVb9ixFHZYPDa8m/IxMDwirPbmCN2NicX8BjZGsHh0vfVrEPt0Z9w+693CMgPNHvcYtXI+ydJQObA7ox9DBE2013ITZ/4f0wKhffxneeW1usOcYuePkker6rfx0t+ItRKBLdNRckYZZ7ETQsFy+3MMg6EO3YRat6xqa9uQFwDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwQb0DIxoJyP5+IFsFqNbGXDkpMjZDV85JlYJvKhtDU=;
 b=BxsMdFpGUrsP5VlnQo8UMrlxliVwTH274GRSqrzx22OONKcLj6hu1fVuEKWfBbJgv/DxfRMEEcJMGbiWcZNHyMEI5y43Zp41/bN+aeSuDtycW6aOIpjgYjuh6NSBy+4Gq1W2dwTJGsJYMTXuuey+u1hlRuAIv9DVIYM07ee/l4Q6QhvUe0ot7PNQYHtkoOzVAxESSWoXnrLXvJYtYZu6oQ12hMCHVn7COSAGZCkdLhwhYt4O5RDFySUq+sAPq4DU2dcyqA3gnikqSLyldsb7cdKnEeT4umcLlzv98bbSLz1psFF9RPGc4syCiKwFo80S8r1RelbE6Sdep0YuyZe9Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwQb0DIxoJyP5+IFsFqNbGXDkpMjZDV85JlYJvKhtDU=;
 b=xNWs3o93lh6+YOy3DDCaOETdoNScvvMBtOFIHKTj10tddAwUXItGOB7X40yxKHZiF21JT8BXg9AYnj+KzQ8RdMJzsjSUBP9W5IOUHEawp6IUaXP35cIzssqynF3WT19AvBo+jYHKz3lRWI/xfLFALt5QE+FnaLeReaPpl4B7eGY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA3PR10MB6998.namprd10.prod.outlook.com (2603:10b6:806:31c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Mon, 9 Oct
 2023 20:16:45 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e391:f2a1:a9d:967d]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e391:f2a1:a9d:967d%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 20:16:45 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        liam.howlett@oracle.com, zhangpeng.00@bytedance.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 0/3] align maple tree write paths
Date:   Mon,  9 Oct 2023 13:16:36 -0700
Message-ID: <20231009201639.920512-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::39) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA3PR10MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 113e29e2-ba27-4b4e-58c6-08dbc904a88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTrkFpE2/17o29sYPqi5s6dkvhX2H5Ma7aGF1+qDm9sfeUFKFSHpD9nxPfpTX5/vtBhQk2Pq6TKxQiVXNF2Zp7sYtnNUDqOpnblOykZdRj66ZepNNEL8EK4UItAzf5D/B2dq5daSSm/c+w/0G757LbHBITIX0myi5KEB3zaS24RqXqlW1yPV4fNqrZJYwiJJjFzfy7dK722ko9N7CYuqhBq4eoWiEPJNBlzmMUaiWQRv56yRojEuWP0ZYU9CkgGM+D+O68O0bxlk7gwLEIfzyWomrMJTCm8DdtRXcvsecFDgxK1wNYETSivwSXss5LR3oiWzt+RRIL6GISMcY9fDjHROHkOqrz2M071Qtx1Put7LXtAI+ZimV8UC+xbekX61//+RaHMvTjI0p0DnKt4/Nknm8ZGdA+Z/J6lxSaWvsYn67hzYcXxFXqIKrrEgtyfGeo1xv5EfM2aT8Zm+0R6QS6UzjIJqIo5AxmhxnEWLcHQvubpYvbJv5Uk6TiZcg7NexZ7LY0UJzG9lA0EuA4qbj7KwiLTrfsmKBcKb/5V/OLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(86362001)(38100700002)(36756003)(6486002)(966005)(6512007)(2906002)(6666004)(478600001)(8936002)(44832011)(5660300002)(41300700001)(8676002)(6506007)(4326008)(107886003)(83380400001)(2616005)(1076003)(66946007)(66556008)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9QRuesUOQMIevQQq5ZiEOwna5iIba5g8KhRdpMqh+RW8jFbBtEy2WSfZ43KB?=
 =?us-ascii?Q?6yiWE+WOlrxZGmT6++M53aVAQIgWYN1PwpsJOE3aZ1X/5nn9X6Gu4boyYt8q?=
 =?us-ascii?Q?Nt1dyVEpNPbCvbdHKmezbzfhfnKVc/EE8nrABM/2x9IB4kZpMbz48aSkFaG6?=
 =?us-ascii?Q?sf1VHzmCYoer5OA1rz8KapYSk3uMUwELvBPk9FRFw03F0gmMdH0ipP3SxPwe?=
 =?us-ascii?Q?b/8IyOQhn/D4q8wSfc8ZxXWQ3tSnVutzjY7z/Qpm4lpQci2s9OP/wgBqAfZH?=
 =?us-ascii?Q?WRnASBXIURPYFMpPZRonjZTqtcLeLKUdSy6pn269y9JlRsIpCdJNNg+rTxIm?=
 =?us-ascii?Q?1QecO/kndz4hbLbeN6hHT6b2251RvLIDkbM+n9ZI0lt2MsRV9Pq/8EdFSX0a?=
 =?us-ascii?Q?UhZGVxh7Lxh5MOGbwYa0P2t1MO32rwaFbeVj1erOXS1f61A3LmDPKSkcD0wR?=
 =?us-ascii?Q?50N7Nketb0VKDHfA7rRr7r+ri7jMbmCbdlA+Ll0IS9LaDNLgl5moAfsWrvS8?=
 =?us-ascii?Q?Ne5fqCfu7gnng70MuDno4UxJHA0SjMgWYbRW75mz19tyFaMKadQ/qoox/nHQ?=
 =?us-ascii?Q?Ch3EwRReOPJeww1yAf6/r769/yOPPX35FH5yRlfIzDfrZgFYu2NF3TSLS3ks?=
 =?us-ascii?Q?MhZ2xExOMzIX8S8KVug2TvJLZkj1865rCHLhfRPn/OxPteKVmKBAcnpsU4gS?=
 =?us-ascii?Q?r0gY4P1qr8dznt3lRT9K4+AP8Dn0BnEuz0iUxKoGwRF8TrCmhvl7WGmjl8U9?=
 =?us-ascii?Q?ohQVRW7FvnIm7wfb/cOcPtyEKjpRpRbtlw36EL1WeNjazl7U1cyfPw9pXis8?=
 =?us-ascii?Q?wm5494+WWLoE7M1t3JmN4HTMsz5OWcAUtrEGNWfgJrdxMRfzhB2h8huxEWZV?=
 =?us-ascii?Q?yQcOpWX9z9dDN4BnrXYKjt21VK+IUmb6epTeGdZxIqvpuOSqpYVBYkn3+pE2?=
 =?us-ascii?Q?CKgrP4IfEEJX6WnGeuCG9WZiyvtQUmCCqV0fglOYFlhhDNiHJ1Fj11OLsv4O?=
 =?us-ascii?Q?7XK9eNJLCo3h5T1MLb19TiT9P9JHVGSRmx8tXHlTlhmrjjTh9rgcWL16TUP7?=
 =?us-ascii?Q?qIi8VUY+AEf/ZPDVTDsa3rrrABU3QMzwrszHgoimm8OKYNO1AzyRw2uiioMi?=
 =?us-ascii?Q?QkkOnjPs/oaV5lf0yM8Df16n4QQ5MZ55WdKVhikmQjz+ESMafLgB176UImea?=
 =?us-ascii?Q?XYmERnwkJSBneWRg+p5NirDD/QrBuMEEVd5GsCaVQvVCRu2Jf+NKmlrH6CWc?=
 =?us-ascii?Q?n6lwzZ81vg4oBIClwC2oQCOFV+W0wtyOfGMQve9Qj8/LBz0sQdPl8RNCToPL?=
 =?us-ascii?Q?zl7Q+HnT4q02vATMWlIyPB2dQnfFMrZc7d+7HMTLg3J7Cq+hPc3q+9pf5dwV?=
 =?us-ascii?Q?NolO8TfSUFoJ8vLLab+Ltz0EVzNiO27TJzHvo2nQJ+VA76yFV/t5zBVs5dGV?=
 =?us-ascii?Q?TLQjhtNmxNK4xIZzxkSxJnbJ9OiVoPR6UvOnyXdTbq4+I4YaPByHjE9Ld5ov?=
 =?us-ascii?Q?EJsqpTzN2rgN3/RJczpEMuhaXSVHTxpTz/zepOVbsDKGGmtccs7F43KzB4RX?=
 =?us-ascii?Q?N1DwEtyAFgx1eP9leFf7IS2FatV1MfwRXC2jl5qN6OwzR1UX+CZrN+LliQah?=
 =?us-ascii?Q?h5wq8pT3EiWVZsiEB7E9kyA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vLjVXcPqSpeiinnCOVt1+YAZgrDzZBHNWy0MOicjrbpxHr5zY3IIuC/0hwPf?=
 =?us-ascii?Q?Oy+NG1XGpz/Q+ABxdr4MrFCU00BEBzFEa3+XM0DY/cms72sBZrtTAsGdsQVZ?=
 =?us-ascii?Q?nd247TvAg9TkWTcMvymYEo1047dN/OyYgFbGVwI88pgWkWdSe92pL80pwHRY?=
 =?us-ascii?Q?m27YpyAeSnFWDV4iFomk8V8ctUmEr8CvnIqqfxNfLvliX9ZrnlI26SMaIA8c?=
 =?us-ascii?Q?nNQ95hYsamH7tDy9Gwv3xpY1tt75rTd3DTTLtDV5l4b+AuI40QuOLKHWhDJI?=
 =?us-ascii?Q?aFEuMj/oQ4oAkCUbckNNOh7DNT1OHi1RijeCtrjh7fOPx1Q1B4CSS2PnKmZl?=
 =?us-ascii?Q?D64VM2ob7Tw/Q8WNmQipK/k4MbasrlBYBTQk0ptZICx5UQuBMlS4flGVD16w?=
 =?us-ascii?Q?FUr9oaW+gwUgfrXiJ3+FX1yvav5M3FlysWwRqZaY7z0iPRhdwWiwNPpHr7YG?=
 =?us-ascii?Q?g2p9AoWopVwXYAkWA24HKdGkeG/yUHCJmnb+Pu8pfPArntsjS35OJdgugQ+c?=
 =?us-ascii?Q?FdHNdPuPbk24i0ZKBDZ/Yv0OuMnDQjh9BNtAsBXi3or2HAQRQcDD/5MwO4sS?=
 =?us-ascii?Q?he4o4VBD+o6VlvPwQJkwb1JGomzyyLkL238MLg8nUTW0F+45TPcOuObZHs8U?=
 =?us-ascii?Q?MeyDXk3sDx8WUhttmbzvrK8CpgZ8GOHTX1v10VcIZegYr7D17NG7pDRLcRZH?=
 =?us-ascii?Q?FYYRaS31IOJNUwmYwD0Zovt5zLfoe1ro+GQPABALDZwoFMY3o/18ahVG8RKf?=
 =?us-ascii?Q?4AesfPhif8BUUgaV7Ye+N2bJzJbFU09+8DToHbpfsW9gH9TSaOZZBzIK+1i1?=
 =?us-ascii?Q?ElKlYaFFVAxuo1GdQffGGLYlHWTK3pn7OcKsuKA4nRBkESa5w/YYIBjUOhjE?=
 =?us-ascii?Q?DAy702I0nDi34g2ZruSQmCLRZPc3FiOX2+JGa8ktSU1ub5ZcSw0RAbHkCLG7?=
 =?us-ascii?Q?0e0X8hvN3qcuye7SttZUgw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113e29e2-ba27-4b4e-58c6-08dbc904a88b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 20:16:44.9582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iK3VHi0q8Vm4ftwCEa4AZ5idqei2krlvB4/BfK/tEtKA+tkSLf1vsH++q14P+Zfn7qqY6Jxwir1X4T79JDKkNaaPW9AvdLnNNIHJk2T1qQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_18,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=971 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090163
X-Proofpoint-GUID: rjbNKu-VjJICPPECbvZSAbLrKOr15sdy
X-Proofpoint-ORIG-GUID: rjbNKu-VjJICPPECbvZSAbLrKOr15sdy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series modifies the store paths in mas_store_gfp() and mas_erase() to
use the newly refined preallocation calculation before their calls to 
mas_wr_store_entry(). This will avoid having to do worst case calculations.

Patch 1 abstracts the calculation outside of mas_preallocate() so it can
be used externally.

Patch 2 modifies the write path in mas_store_gfp() to use preallocations
and patch 3 does this in mas_erase().

The motivation for this series is part of the Maple Tree work list[1].


========== TESTING ==============
Testing was done with the maple tree test suite.
maple_tree: 570172962 of 570172962 tests passed

rebased on mm-unstable 10/09/23

[1]: https://lore.kernel.org/linux-mm/20230912172845.o54szwf33hc6p7ee@revolver/T/

Sidhartha Kumar (3):
  maple_tree: introduce mas_prealloc_calc()
  maple_tree: use preallocations in mas_store_gfp()
  maple_tree: use preallocations in mas_erase()

 lib/maple_tree.c | 128 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 88 insertions(+), 40 deletions(-)

-- 
2.41.0

