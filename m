Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72E87AA1CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjIUVGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjIUVFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:05:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA77EADF37
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:14:22 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LI5AY7011191;
        Thu, 21 Sep 2023 18:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=MSdCmzhVS/I/zLXGiVcgOOj2URLRbWRWQQI6ktXwUqc=;
 b=KWLP1lWVS42YjPYeF7/6cIiDdrZoF2QoZYdKHFOtgo/g7YwxSQpY27Wm8m48sSU3X7jj
 cxHrulV/V53DfbzlYCQNBblM6r4um8a3+1SlXNmlZrLtoN7NYC6cdEPTA/V6cRT2MRkY
 /FoS0qvfxiqhVafq+z4wzGAldfPe0rGae9YS/DLA9A69DdyHbHoy3D/rsbpMd5RS/l9x
 NlUzun+UHw+xVcopiHRZU9G6ferPbOGzJ4Qf1iQ/M4HGi0B4rcoKfANYtsZ+0NoDUIcz
 I7a0UMBzKfnW700N+cX7gL8CCQc/GXsb5RxboFNjmyU+O0kwe7keA/dnNWXD+4mRXSmR /Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsxr0jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 18:13:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38LHPC1D030875;
        Thu, 21 Sep 2023 18:13:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t8yn2k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 18:13:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPF95kHVJ17aCy1mt72a98S6AyDgfAp0AYC2TanZJDh2afyFo/bYhaOuWTH2f6JG57uFc4ZhAdQ3NJiquJCByk/PDy9Q/tx8BWkpQ5oQWNgOuxJMe9WTvhxIPF3giCXQfnO8gjNahRcrcqg+wDTTUExMeukY2cbOqRiYoFy7wwfFzQyB1/Optad+qY9aTWHt07NZdMcMly7zpqJw1qqBWJKMxCzf9ib6cjrmIreY0+weV7hachRd7KT8cBKRh4KupcgCr7vn8ftREeCkXEYn91lp3WnZlUnHkOQSSsV8BqIGsyVmmMXqomBtZpeKf4nddXjAWzvOp2fJeTGPkjMm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSdCmzhVS/I/zLXGiVcgOOj2URLRbWRWQQI6ktXwUqc=;
 b=CrI9aAoVHeaZ0ZUNTONr5xZeayJ1om0rgwR3bt2fmDy5lMKUQLmX2pBNhQU3vXv65cO1Xf2mv6UJB0gvs46/x3wID8mZ9ADdAShylFKh+hTuoI1946wgz31nqu2kzPbz/GtTVe2Ur1f8oBQfn3hAbcHOPSmALSEVbjTXeQYqVSNb0VgTj2C96u9CqnYkY750i3bjAa+NqThAKMXtu8q8Lr+hXiGzLQyFEfrUtBFYWkXwlo1cLBp9DhPTiB2o6CIdFozSbmhpZjQpnu8YSW9R2s8G7TW1O/RjG3IlBojyMRIFsLm07awe/OTSMeQ26RD3smKeRvW61wvTFoKxlQH2HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSdCmzhVS/I/zLXGiVcgOOj2URLRbWRWQQI6ktXwUqc=;
 b=Nk7IWFaDC/+78Xz4QQbaf+R5QyIiCwsA5XrHtnWp3d4y8ijOWDeV/6py1UXDFtLyH4+RgpxqWnWTxc/051NtBGTuDkjKi0OL6889qAUd8MzqdPD2f/n1lLRlNt56qxXjyv5shjGYxWrTsgNCnsuXkPYQmExFKxz17llkOR9P16M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB5158.namprd10.prod.outlook.com (2603:10b6:408:120::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Thu, 21 Sep
 2023 18:12:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 18:12:58 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        stable <stable@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 2/2] maple_tree: Add MAS_UNDERFLOW and MAS_OVERFLOW states
Date:   Thu, 21 Sep 2023 14:12:36 -0400
Message-Id: <20230921181236.509072-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230921181236.509072-1-Liam.Howlett@oracle.com>
References: <20230921181236.509072-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BN0PR10MB5158:EE_
X-MS-Office365-Filtering-Correlation-Id: bd54530a-175d-4bd2-2ebd-08dbbace628e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUMruCIqigI42Zl92GiZda2pzTfCvK+EStnCG9MMer2f6HkoaVGQVbKxrgrc/uIOk9AUWOXC+Qz6uaqfMyjso0q4cTZkYBXVbCwh1neFz37SvAhltoInTzGY5VPseBJGtg1QF6nYLTZS9dWRjh4IpucawHvHvbfbLFCC1fr0wdqRFCk3Ouu+hBxiZHkkS+AvBhU47lT0XZrh+Tdhu2XEpbk3RwYa3yONLnoL98EQfLkoY+zjmjoPdH6kTY/R/sc/BEbo2Y0fQdczJEClTyt0zpP2FfLvduYAk+tMTvOxcYmBi8TzIrJBo0ZZ34wMVJHTwLCqbmBm7ICCFrGfAlPHwTXBLsX9Lf7F1kNnCrX+h7Th8BXBDwsyxEs0AACoAE4rDSUUHt55reFHlsFS3CGb9Sbd3hGxL7ehaSupLBLMNypEg47K7r4LLVJdV0GJEK7TSyP6m0DVfX7wg9mYneDZTFJlzapoKUcepP9oy3QkJN0dXs4yezfKd9ekjXVgNygkhQAELIfVy7gEI/0PEYL4UPTIZJMc1IvH/dVfGNkdXbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(5660300002)(2906002)(30864003)(4326008)(41300700001)(38100700002)(8936002)(8676002)(316002)(66476007)(66556008)(66946007)(6916009)(54906003)(86362001)(36756003)(26005)(83380400001)(6512007)(2616005)(1076003)(107886003)(6486002)(6506007)(478600001)(6666004)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VN0TrkaYcCR3YKAMFR/f1sDp1TMg6Bn70XGZRy+yjJ0jXdW0iuLU97Dzir/q?=
 =?us-ascii?Q?ytVIKR5SYdwY+vAbc21tnctgrcKiI0Qg5tuA3Um5lE00dcb00j3+FyG9GYv2?=
 =?us-ascii?Q?g3LgGSsx2ejedaYKMSEHgHD467ofK28i+STxpF69cKUlfoOtcaSmaGGQi6ce?=
 =?us-ascii?Q?x6IzhAI8yrf3BEump1NspGvAJMIZJV8aRzNa/SjScHzqaeZcLDGCQbZPrcBj?=
 =?us-ascii?Q?SdjKFYdkjfL9JjuSzmy0ep8f+aOERervfhjfrnN2m6eKaf7dFaxItS5W30vh?=
 =?us-ascii?Q?d1pjr1ibzrqy8afJmQWNEuclPVJQaY3baUihzPHpQ73wyMzGIorggw/Hp4ca?=
 =?us-ascii?Q?0ASLeT3inPXENegV91nSn2AZQV3CGVjz547Q1YUevm+AnYRre4gy6TzzAJDa?=
 =?us-ascii?Q?l3/jJ5w1LFKljemB2rjVQXLWun08m88cj/a0QBMBRtu2kF/bRnOuH8s4UDPv?=
 =?us-ascii?Q?e/s+2835kSFk5XBZvstFdxVibtbvj0LlygwOwtNm6Hlsi3h6jiTQVAt5k1Xo?=
 =?us-ascii?Q?ir8ISDM8YKft4mmrcOFBb37RkDzxEANLkWLlainEbujE0dtDZPftm/v2Ff1G?=
 =?us-ascii?Q?op+JdNNoIJvqiqayHYTgHwyN31WYCzdMyFxroMeAI6bweHIGP04OPttlL6Gm?=
 =?us-ascii?Q?D78SK+QdGZVRu3UzPsj+6BTnY2k17hlVrk/HBUbpZ/fitMualfeAfGkU+VVF?=
 =?us-ascii?Q?R5tLYVZRWSOW9WyiXd97mV5NombuWuq4z+DYQNU8XUD+gnQovyOqBLDSkOaH?=
 =?us-ascii?Q?PTnKvDY8hV9DIAlyhindG+PpnUIywTjTrWhMGd+epO1W6ogGFEHInpcpSbZh?=
 =?us-ascii?Q?YtjfrXNpKRrpZaJ+dSDWdVyXEttiy3ZzpktVuJX/sqVMUn+wvm9bgiyR3K4d?=
 =?us-ascii?Q?I+HY8mgzoZC4X8aLL1QaNGvJ6ppC/fgxsKd0PLp4dMKSntxfywG88ApXXU1J?=
 =?us-ascii?Q?eUK79T85m+x65klVW25mQHJbM9j0qDyruvGBZCdEcF3JUZRoga7a4QOsZzmU?=
 =?us-ascii?Q?gZ1h7SW5g91qhDCJE6LRsnxOfv/Di7eCekPlzQkGZrKqkAocJkGL+j7+zn77?=
 =?us-ascii?Q?Mw3u6rHx0J2vwl8BVc8MthlwJvqmABqVsUpdGya8cM2pYUX1QMbAm1ZbR1Eb?=
 =?us-ascii?Q?6i1FF+oBFdAWbyl/Bndn3+DD9Q5/nZ2Vq8mSF9hnEb8xd+F3oj6+wvkNcyTx?=
 =?us-ascii?Q?+sCfW427BzMHbEYWels+668JbgBFJfEPajgc3uXhE0eJ7UHEsEHzqMYv4B/s?=
 =?us-ascii?Q?NVSJaS0T7Y6zYswZwrzDbO7afYPN0zNWRhpsD/Qlcu6YT8sC2Vs6OxLAJLxD?=
 =?us-ascii?Q?OTZ+BR0sAJgpqrE8q4Nco41oUBsA8dRRXW05ATD/q7fLckmg0mahogJ1syR3?=
 =?us-ascii?Q?aYWe9yjfC/qg5Pq3OvpgYp8SOOyo86FVfcrKavNPVW6M9WwLNjjb6W4nbj54?=
 =?us-ascii?Q?IMs+PN/Om+SX+lD/5CbekWVdO9V0l/hyjiMJuQFDoT/YWlJn0MVRDupU+FZj?=
 =?us-ascii?Q?mxH7NfPB9qVz5WJf4Iz1WWYlpAB1xNIdzCK7cSmvQObOJg+8skFeT4uYSaPz?=
 =?us-ascii?Q?90Ms5OdP4Yne7rr7BK3pJmPJx6F/pvYP08358dXF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?a3mEdCfLpgmMKHhQ5g4HNi7abSn5/z35gV6+YvRslA1joH/aetJIIGH4WyO7?=
 =?us-ascii?Q?DOGfwk8P9XGjKdF0N+BP4+P7G90oQgq8Dlclx2ePrwp4GtiYqRFcvSbCWrsF?=
 =?us-ascii?Q?kZpElWVtbNVae/sB+SXFW4T+hunYsM1NOTo6IuIoZ7O6uo0j0W0aWyOreJ3n?=
 =?us-ascii?Q?pbp8D/2MjSdmvn5fg5XfKKxjBOPzjYAiP1SmCH/I98PwR9TPV0v44sRx76xq?=
 =?us-ascii?Q?eMPu/xkgfv6gGOuEoF8q2pYG+nWeSAc8IVXDdf7rEH9U0en1ypboSZX6L/Df?=
 =?us-ascii?Q?p/pQmE/H2eDfgW/1YK1BQOHLjZm+Ny6b6JQtHs5tCrqNj9fdLXfoER91OT6E?=
 =?us-ascii?Q?Y0z193C1fQ1KPCDuSAzhRhfU8j44B6Q7D4P79RR/rtrBVsFYawFLUnzoajah?=
 =?us-ascii?Q?LgASLmFpkThAWUMSEA3ojJKgkvgzlrHOVBK7JR8is+a5YPTV2B1zDKsWael2?=
 =?us-ascii?Q?lPNdwZN4gW6BM0EilvLFq6Q4iDEBSVNDZeTGPhVraVtdbFQOUpCD1M1dEGaI?=
 =?us-ascii?Q?qCakJNHcCywa/4hD4Z4EYIy1oKg8IFSZZdKynxkReu56AdaAcYr4kFxu65vL?=
 =?us-ascii?Q?cQ87NwpPy8DM4U22sITxCczASZijsS2eDJ77DkzMsZVf3H7lzF2JZBSL4xT4?=
 =?us-ascii?Q?wD6penwrLKQ9pOHaWaCj9gfiKpTOpbwXcgAToO5Pm/u7tqOz1+eCF/vyMILP?=
 =?us-ascii?Q?UWGJdcHQ2fstqEwi5jELTcM7aPkK5l068KGgJZ/uoEy/mAwgq+dorrXHxzq7?=
 =?us-ascii?Q?DMtRyLXfu1o13bDfxxB4wDYMOfumLrSK8+286zDS56bToNowuBP4EccTcV0e?=
 =?us-ascii?Q?G867MBT3Y9jSRtzePOfgtgZowq7qkAQbfabwsFU8BO9koW8Z+DNYvWo3Tn2I?=
 =?us-ascii?Q?utGiKQHjSbCMGoazEn4QiB1g3HIS3OTsETX/zDcIqUCCra7sctzch230J8aH?=
 =?us-ascii?Q?vCdNigbI5OvyHjmwjS+EjA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd54530a-175d-4bd2-2ebd-08dbbace628e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 18:12:58.4195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IyEOZ+ZY9KzvS2/8zbrUuaVQWu3hzsHDH2cny3Oo3oYf9fXp0DXgJhy6AUXa1A21Nj35STiJ/y1O4IHV7WqWgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_16,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309210159
X-Proofpoint-ORIG-GUID: UmPb45QrXnD4_1u4JegkvXMQp1aJD73w
X-Proofpoint-GUID: UmPb45QrXnD4_1u4JegkvXMQp1aJD73w
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When updating the maple tree iterator to avoid rewalks, an issue was
introduced when shifting beyond the limits.  This can be seen by trying
to go to the previous address of 0, which would set the maple node to
MAS_NONE and keep the range as the last entry.

Subsequent calls to mas_find() would then search upwards from mas->last
and skip the value at mas->index/mas->last.  This showed up as a bug in
mprotect which skips the actual VMA at the current range after
attempting to go to the previous VMA from 0.

Since MAS_NONE is used for handling of the maple tree when it's a single
entry at 0 (just a pointer), changing the handling of MAS_NONE in
mas_find() would make the code more complicated and error prone.
Furthermore, there was no way to tell which limit was hit, and thus
which action to take (next or the entry at the current range).

This solution is to add two states to track what happened with the
previous iterator action.  This allows for the expected behaviour of the
next command to return the correct item (either the item at the range
requested, or the next/previous).

Tests are also added and updated accordingly.

Reported-by: pedro.falcato@gmail.com
Link: https://gist.github.com/heatd/85d2971fae1501b55b6ea401fbbe485b
Fixes: 39193685d585 ("maple_tree: try harder to keep active node with mas_prev()")
Cc: stable <stable@kernel.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h |   2 +
 lib/maple_tree.c           | 221 +++++++++++++++++++++++++++----------
 lib/test_maple_tree.c      |  87 ++++++++++++---
 3 files changed, 237 insertions(+), 73 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index f66f5f78f8cf..d01e850b570f 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -428,6 +428,8 @@ struct ma_wr_state {
 #define MAS_ROOT	((struct maple_enode *)5UL)
 #define MAS_NONE	((struct maple_enode *)9UL)
 #define MAS_PAUSE	((struct maple_enode *)17UL)
+#define MAS_OVERFLOW	((struct maple_enode *)33UL)
+#define MAS_UNDERFLOW	((struct maple_enode *)65UL)
 #define MA_ERROR(err) \
 		((struct maple_enode *)(((unsigned long)err << 2) | 2UL))
 
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ee1ff0c59fd7..0e00a84e8e8f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -256,6 +256,22 @@ bool mas_is_err(struct ma_state *mas)
 	return xa_is_err(mas->node);
 }
 
+static __always_inline bool mas_is_overflow(struct ma_state *mas)
+{
+	if (unlikely(mas->node == MAS_OVERFLOW))
+		return true;
+
+	return false;
+}
+
+static __always_inline bool mas_is_underflow(struct ma_state *mas)
+{
+	if (unlikely(mas->node == MAS_UNDERFLOW))
+		return true;
+
+	return false;
+}
+
 static inline bool mas_searchable(struct ma_state *mas)
 {
 	if (mas_is_none(mas))
@@ -4415,10 +4431,13 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
  *
  * @mas: The maple state
  * @max: The minimum starting range
+ * @empty: Can be empty
+ * @set_underflow: Set the @mas->node to underflow state on limit.
  *
  * Return: The entry in the previous slot which is possibly NULL
  */
-static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
+static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty,
+			   bool set_underflow)
 {
 	void *entry;
 	void __rcu **slots;
@@ -4435,7 +4454,6 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
 	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 		goto retry;
 
-again:
 	if (mas->min <= min) {
 		pivot = mas_safe_min(mas, pivots, mas->offset);
 
@@ -4443,9 +4461,10 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
 			goto retry;
 
 		if (pivot <= min)
-			return NULL;
+			goto underflow;
 	}
 
+again:
 	if (likely(mas->offset)) {
 		mas->offset--;
 		mas->last = mas->index - 1;
@@ -4457,7 +4476,7 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
 		}
 
 		if (mas_is_none(mas))
-			return NULL;
+			goto underflow;
 
 		mas->last = mas->max;
 		node = mas_mn(mas);
@@ -4474,10 +4493,19 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
 	if (likely(entry))
 		return entry;
 
-	if (!empty)
+	if (!empty) {
+		if (mas->index <= min)
+			goto underflow;
+
 		goto again;
+	}
 
 	return entry;
+
+underflow:
+	if (set_underflow)
+		mas->node = MAS_UNDERFLOW;
+	return NULL;
 }
 
 /*
@@ -4567,10 +4595,13 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
  * @mas: The maple state
  * @max: The maximum starting range
  * @empty: Can be empty
+ * @set_overflow: Should @mas->node be set to overflow when the limit is
+ * reached.
  *
  * Return: The entry in the next slot which is possibly NULL
  */
-static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
+static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
+			   bool set_overflow)
 {
 	void __rcu **slots;
 	unsigned long *pivots;
@@ -4589,22 +4620,22 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
 	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 		goto retry;
 
-again:
 	if (mas->max >= max) {
 		if (likely(mas->offset < data_end))
 			pivot = pivots[mas->offset];
 		else
-			return NULL; /* must be mas->max */
+			goto overflow;
 
 		if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 			goto retry;
 
 		if (pivot >= max)
-			return NULL;
+			goto overflow;
 	}
 
 	if (likely(mas->offset < data_end)) {
 		mas->index = pivots[mas->offset] + 1;
+again:
 		mas->offset++;
 		if (likely(mas->offset < data_end))
 			mas->last = pivots[mas->offset];
@@ -4616,8 +4647,11 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
 			goto retry;
 		}
 
-		if (mas_is_none(mas))
+		if (WARN_ON_ONCE(mas_is_none(mas))) {
+			mas->node = MAS_OVERFLOW;
 			return NULL;
+			goto overflow;
+		}
 
 		mas->offset = 0;
 		mas->index = mas->min;
@@ -4636,12 +4670,20 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
 		return entry;
 
 	if (!empty) {
-		if (!mas->offset)
-			data_end = 2;
+		if (mas->last >= max)
+			goto overflow;
+
+		mas->index = mas->last + 1;
+		/* Node cannot end on NULL, so it's safe to short-cut here */
 		goto again;
 	}
 
 	return entry;
+
+overflow:
+	if (set_overflow)
+		mas->node = MAS_OVERFLOW;
+	return NULL;
 }
 
 /*
@@ -4651,17 +4693,20 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
  *
  * Set the @mas->node to the next entry and the range_start to
  * the beginning value for the entry.  Does not check beyond @limit.
- * Sets @mas->index and @mas->last to the limit if it is hit.
+ * Sets @mas->index and @mas->last to the range, Does not update @mas->index and
+ * @mas->last on overflow.
  * Restarts on dead nodes.
  *
  * Return: the next entry or %NULL.
  */
 static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 {
-	if (mas->last >= limit)
+	if (mas->last >= limit) {
+		mas->node = MAS_OVERFLOW;
 		return NULL;
+	}
 
-	return mas_next_slot(mas, limit, false);
+	return mas_next_slot(mas, limit, false, true);
 }
 
 /*
@@ -4837,7 +4882,7 @@ void *mas_walk(struct ma_state *mas)
 {
 	void *entry;
 
-	if (mas_is_none(mas) || mas_is_paused(mas) || mas_is_ptr(mas))
+	if (!mas_is_active(mas) || !mas_is_start(mas))
 		mas->node = MAS_START;
 retry:
 	entry = mas_state_walk(mas);
@@ -5294,14 +5339,22 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
 
 static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
 {
-	if (mas_is_start(wr_mas->mas))
-		return;
+	if (!mas_is_active(wr_mas->mas)) {
+		if (mas_is_start(wr_mas->mas))
+			return;
 
-	if (unlikely(mas_is_paused(wr_mas->mas)))
-		goto reset;
+		if (unlikely(mas_is_paused(wr_mas->mas)))
+			goto reset;
 
-	if (unlikely(mas_is_none(wr_mas->mas)))
-		goto reset;
+		if (unlikely(mas_is_none(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_overflow(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_underflow(wr_mas->mas)))
+			goto reset;
+	}
 
 	/*
 	 * A less strict version of mas_is_span_wr() where we allow spanning
@@ -5595,8 +5648,25 @@ static inline bool mas_next_setup(struct ma_state *mas, unsigned long max,
 {
 	bool was_none = mas_is_none(mas);
 
-	if (mas_is_none(mas) || mas_is_paused(mas))
+	if (unlikely(mas->last >= max)) {
+		mas->node = MAS_OVERFLOW;
+		return true;
+	}
+
+	if (mas_is_active(mas))
+		return false;
+
+	if (mas_is_none(mas) || mas_is_paused(mas)) {
+		mas->node = MAS_START;
+	} else if (mas_is_overflow(mas)) {
+		/* Overflowed before, but the max changed */
 		mas->node = MAS_START;
+	} else if (mas_is_underflow(mas)) {
+		mas->node = MAS_START;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
+	}
 
 	if (mas_is_start(mas))
 		*entry = mas_walk(mas); /* Retries on dead nodes handled by mas_walk */
@@ -5615,6 +5685,7 @@ static inline bool mas_next_setup(struct ma_state *mas, unsigned long max,
 
 	if (mas_is_none(mas))
 		return true;
+
 	return false;
 }
 
@@ -5637,7 +5708,7 @@ void *mas_next(struct ma_state *mas, unsigned long max)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, false);
+	return mas_next_slot(mas, max, false, true);
 }
 EXPORT_SYMBOL_GPL(mas_next);
 
@@ -5660,7 +5731,7 @@ void *mas_next_range(struct ma_state *mas, unsigned long max)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, true);
+	return mas_next_slot(mas, max, true, true);
 }
 EXPORT_SYMBOL_GPL(mas_next_range);
 
@@ -5691,18 +5762,31 @@ EXPORT_SYMBOL_GPL(mt_next);
 static inline bool mas_prev_setup(struct ma_state *mas, unsigned long min,
 		void **entry)
 {
-	if (mas->index <= min)
-		goto none;
+	if (unlikely(mas->index <= min)) {
+		mas->node = MAS_UNDERFLOW;
+		return true;
+	}
 
-	if (mas_is_none(mas) || mas_is_paused(mas))
+	if (mas_is_active(mas))
+		return false;
+
+	if (mas_is_overflow(mas)) {
 		mas->node = MAS_START;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
+	}
 
-	if (mas_is_start(mas)) {
-		mas_walk(mas);
-		if (!mas->index)
-			goto none;
+	if (mas_is_none(mas) || mas_is_paused(mas)) {
+		mas->node = MAS_START;
+	} else if (mas_is_underflow(mas)) {
+		/* underflowed before but the min changed */
+		mas->node = MAS_START;
 	}
 
+	if (mas_is_start(mas))
+		mas_walk(mas);
+
 	if (unlikely(mas_is_ptr(mas))) {
 		if (!mas->index)
 			goto none;
@@ -5747,7 +5831,7 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 	if (mas_prev_setup(mas, min, &entry))
 		return entry;
 
-	return mas_prev_slot(mas, min, false);
+	return mas_prev_slot(mas, min, false, true);
 }
 EXPORT_SYMBOL_GPL(mas_prev);
 
@@ -5770,7 +5854,7 @@ void *mas_prev_range(struct ma_state *mas, unsigned long min)
 	if (mas_prev_setup(mas, min, &entry))
 		return entry;
 
-	return mas_prev_slot(mas, min, true);
+	return mas_prev_slot(mas, min, true, true);
 }
 EXPORT_SYMBOL_GPL(mas_prev_range);
 
@@ -5828,24 +5912,35 @@ EXPORT_SYMBOL_GPL(mas_pause);
 static inline bool mas_find_setup(struct ma_state *mas, unsigned long max,
 		void **entry)
 {
-	*entry = NULL;
+	if (mas_is_active(mas)) {
+		if (mas->last < max)
+			return false;
 
-	if (unlikely(mas_is_none(mas))) {
+		return true;
+	}
+
+	if (mas_is_paused(mas)) {
 		if (unlikely(mas->last >= max))
 			return true;
 
-		mas->index = mas->last;
+		mas->index = ++mas->last;
 		mas->node = MAS_START;
-	} else if (unlikely(mas_is_paused(mas))) {
+	} else if (mas_is_none(mas)) {
 		if (unlikely(mas->last >= max))
 			return true;
 
+		mas->index = mas->last;
 		mas->node = MAS_START;
-		mas->index = ++mas->last;
-	} else if (unlikely(mas_is_ptr(mas)))
-		goto ptr_out_of_range;
+	} else if (mas_is_overflow(mas) || mas_is_underflow(mas)) {
+		if (mas->index > max) {
+			mas->node = MAS_OVERFLOW;
+			return true;
+		}
+
+		mas->node = MAS_START;
+	}
 
-	if (unlikely(mas_is_start(mas))) {
+	if (mas_is_start(mas)) {
 		/* First run or continue */
 		if (mas->index > max)
 			return true;
@@ -5895,7 +5990,7 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, false);
+	return mas_next_slot(mas, max, false, false);
 }
 EXPORT_SYMBOL_GPL(mas_find);
 
@@ -5913,13 +6008,13 @@ EXPORT_SYMBOL_GPL(mas_find);
  */
 void *mas_find_range(struct ma_state *mas, unsigned long max)
 {
-	void *entry;
+	void *entry = NULL;
 
 	if (mas_find_setup(mas, max, &entry))
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, true);
+	return mas_next_slot(mas, max, true, false);
 }
 EXPORT_SYMBOL_GPL(mas_find_range);
 
@@ -5934,26 +6029,36 @@ EXPORT_SYMBOL_GPL(mas_find_range);
 static inline bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
 		void **entry)
 {
-	*entry = NULL;
-
-	if (unlikely(mas_is_none(mas))) {
-		if (mas->index <= min)
-			goto none;
+	if (mas_is_active(mas)) {
+		if (mas->index > min)
+			return false;
 
-		mas->last = mas->index;
-		mas->node = MAS_START;
+		return true;
 	}
 
-	if (unlikely(mas_is_paused(mas))) {
+	if (mas_is_paused(mas)) {
 		if (unlikely(mas->index <= min)) {
 			mas->node = MAS_NONE;
 			return true;
 		}
 		mas->node = MAS_START;
 		mas->last = --mas->index;
+	} else if (mas_is_none(mas)) {
+		if (mas->index <= min)
+			goto none;
+
+		mas->last = mas->index;
+		mas->node = MAS_START;
+	} else if (mas_is_underflow(mas) || mas_is_overflow(mas)) {
+		if (mas->last <= min) {
+			mas->node = MAS_UNDERFLOW;
+			return true;
+		}
+
+		mas->node = MAS_START;
 	}
 
-	if (unlikely(mas_is_start(mas))) {
+	if (mas_is_start(mas)) {
 		/* First run or continue */
 		if (mas->index < min)
 			return true;
@@ -6004,13 +6109,13 @@ static inline bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
  */
 void *mas_find_rev(struct ma_state *mas, unsigned long min)
 {
-	void *entry;
+	void *entry = NULL;
 
 	if (mas_find_rev_setup(mas, min, &entry))
 		return entry;
 
 	/* Retries on dead nodes handled by mas_prev_slot */
-	return mas_prev_slot(mas, min, false);
+	return mas_prev_slot(mas, min, false, false);
 
 }
 EXPORT_SYMBOL_GPL(mas_find_rev);
@@ -6030,13 +6135,13 @@ EXPORT_SYMBOL_GPL(mas_find_rev);
  */
 void *mas_find_range_rev(struct ma_state *mas, unsigned long min)
 {
-	void *entry;
+	void *entry = NULL;
 
 	if (mas_find_rev_setup(mas, min, &entry))
 		return entry;
 
 	/* Retries on dead nodes handled by mas_prev_slot */
-	return mas_prev_slot(mas, min, true);
+	return mas_prev_slot(mas, min, true, false);
 }
 EXPORT_SYMBOL_GPL(mas_find_range_rev);
 
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 0674aebd4423..06959165e2f9 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -2166,7 +2166,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 	MT_BUG_ON(mt, val != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 5);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
 
 	mas.index = 0;
 	mas.last = 5;
@@ -2917,6 +2917,7 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
  *		exists	MAS_NONE	active		range
  *		exists	active		active		range
  *		DNE	active		active		set to last range
+ *		ERANGE	active		MAS_OVERFLOW	last range
  *
  * Function	ENTRY	Start		Result		index & last
  * mas_prev()
@@ -2945,6 +2946,7 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
  *		any	MAS_ROOT	MAS_NONE	0
  *		exists	active		active		range
  *		DNE	active		active		last range
+ *		ERANGE	active		MAS_UNDERFLOW	last range
  *
  * Function	ENTRY	Start		Result		index & last
  * mas_find()
@@ -2955,7 +2957,7 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
  *		DNE	MAS_START	MAS_NONE	0
  *		DNE	MAS_PAUSE	MAS_NONE	0
  *		DNE	MAS_ROOT	MAS_NONE	0
- *		DNE	MAS_NONE	MAS_NONE	0
+ *		DNE	MAS_NONE	MAS_NONE	1
  *				if index ==  0
  *		exists	MAS_START	MAS_ROOT	0
  *		exists	MAS_PAUSE	MAS_ROOT	0
@@ -2967,7 +2969,7 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
  *		DNE	MAS_START	active		set to max
  *		exists	MAS_PAUSE	active		range
  *		DNE	MAS_PAUSE	active		set to max
- *		exists	MAS_NONE	active		range
+ *		exists	MAS_NONE	active		range (start at last)
  *		exists	active		active		range
  *		DNE	active		active		last range (max < last)
  *
@@ -2992,7 +2994,7 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
  *		DNE	MAS_START	active		set to min
  *		exists	MAS_PAUSE	active		range
  *		DNE	MAS_PAUSE	active		set to min
- *		exists	MAS_NONE	active		range
+ *		exists	MAS_NONE	active		range (start at index)
  *		exists	active		active		range
  *		DNE	active		active		last range (min > index)
  *
@@ -3039,10 +3041,10 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	mtree_store_range(mt, 0, 0, ptr, GFP_KERNEL);
 
 	mas_lock(&mas);
-	/* prev: Start -> none */
+	/* prev: Start -> underflow*/
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
 
 	/* prev: Start -> root */
 	mas_set(&mas, 10);
@@ -3069,7 +3071,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.node != MAS_NONE);
 
-	/* next: start -> none */
+	/* next: start -> none*/
 	mas_set(&mas, 10);
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, mas.index != 1);
@@ -3268,25 +3270,46 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.last != 0x2500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* next:active -> active out of range*/
+	/* next:active -> active beyond data */
 	entry = mas_next(&mas, 0x2999);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x2501);
 	MT_BUG_ON(mt, mas.last != 0x2fff);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* Continue after out of range*/
+	/* Continue after last range ends after max */
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != ptr3);
 	MT_BUG_ON(mt, mas.index != 0x3000);
 	MT_BUG_ON(mt, mas.last != 0x3500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* next:active -> active out of range*/
+	/* next:active -> active continued */
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x3501);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* next:active -> overflow  */
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x3501);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_OVERFLOW);
+
+	/* next:overflow -> overflow  */
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x3501);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_OVERFLOW);
+
+	/* prev:overflow -> active  */
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr3);
+	MT_BUG_ON(mt, mas.index != 0x3000);
+	MT_BUG_ON(mt, mas.last != 0x3500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
 	/* next: none -> active, skip value at location */
@@ -3307,11 +3330,46 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.last != 0x1500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* prev:active -> active out of range*/
+	/* prev:active -> active spanning end range */
+	entry = mas_prev(&mas, 0x0100);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0x0FFF);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* prev:active -> underflow */
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0x0FFF);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+
+	/* prev:underflow -> underflow */
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0x0FFF);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+
+	/* next:underflow -> active */
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* prev:first value -> underflow */
+	entry = mas_prev(&mas, 0x1000);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+
+	/* find:underflow -> first value */
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
 	/* prev: pause ->active */
@@ -3325,14 +3383,14 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.last != 0x2500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* prev:active -> active out of range*/
+	/* prev:active -> active spanning min */
 	entry = mas_prev(&mas, 0x1600);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x1501);
 	MT_BUG_ON(mt, mas.last != 0x1FFF);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* prev: active ->active, continue*/
+	/* prev: active ->active, continue */
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
@@ -3379,7 +3437,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.last != 0x2FFF);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* find: none ->active */
+	/* find: overflow ->active */
 	entry = mas_find(&mas, 0x5000);
 	MT_BUG_ON(mt, entry != ptr3);
 	MT_BUG_ON(mt, mas.index != 0x3000);
@@ -3778,7 +3836,6 @@ static int __init maple_tree_seed(void)
 	check_empty_area_fill(&tree);
 	mtree_destroy(&tree);
 
-
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_state_handling(&tree);
 	mtree_destroy(&tree);
-- 
2.39.2

