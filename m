Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC3275FF1B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjGXScu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjGXScl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:32:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F64510F4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:32:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFOGR8028670;
        Mon, 24 Jul 2023 18:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=QJ/wh9XxLuYUXhIhj/5p7uOZwrX+JqWhlqmK3ikmStQ=;
 b=K3EjfPfNYy7HYZSTzx/9rL+uvVXS3jL0vV5DHLVNkc58XnP4hPKRHag8pKwyCi914N/O
 k3QKgBDg2ly/WuYPo3/CGAifNkFacK2aO5ph+CGQ46ab5CSQg3xWG7sQEWRFJYAgQj7P
 BcZcb5fHVsJ1PT+aGmxVgYv0NNeN1KNYtEsGpTbSXZ/mNgc8RPopVnmr+n8vxMGKtYIv
 fxv6YnKWs9SyCyXVyM2p7xhCAUMJusSdSC0/hdgqL9F6Msymtne1DbuCZjhjiczFyJ14
 TwGc47od+loRq9YZcYLK8xxzXtfmMORwFZVJGsmNuf/lIYI3mMKjOENO+mjLLdXoY3/9 Qw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q1ufas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OHNmgS003911;
        Mon, 24 Jul 2023 18:32:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3ss31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfBqMl6IG7rKHp8mBAjLV7wBcJPNl5DAApPPGZMpUePh0nceX856bamUWG6j9V4Ca4/5dHgs0qawVnxzFPh9xVphLNL0ot5KlD2jZ8ffuHz9chkqlRdIGu5jp2A7C2ZlUT6DWb9Y51ciamjtGudTj4cJipKGJ4/gmQEIALuBOb3Dz4GcQmzBbZ4+iAM4VhV5NXzlIIBk4QwdfGDnfoa5R/JJB2AZxQnq3VhnerBmnvgjlvya8PWKS+HnBi/WJBHmqCUe0cQGtzYPNxB8zsqiyabHpMEUtcBdvGFdahKMb/b9GT5PNkQXDy8UroA7ryjO2ogjwFj8FBUWE+Su42z3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJ/wh9XxLuYUXhIhj/5p7uOZwrX+JqWhlqmK3ikmStQ=;
 b=UmmX9A24FhHHPqQIRyci02nYUsrXJuzwX1VCCUyeJObOsx8vNslg2pk7Bz2++YFZpHnJ862rJH4iNeWxax4XdkiegEobtsgm90zy/DdyO1/wWq4J5AYMtBcNWkvJmuKHQpoc1sAeqJO8Gof8cwWeCbG3xfZ9UAlr03nREmNe8wIdkCmHUozoDvaF8pBhcsVqhrnH+OD2XrEHkHdeEfuvd7xa3phIQWol3edIlFSPtbT6nNdprRUiWj05Jj4TVipztVUDdFv2lWFPX0PMhcbtfijVa4PKevF0EdGq5MrIOtA/6Hv0VuxLEJSbjPDF2NUGkT3OMdcVZ9yVpzdBaxhXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ/wh9XxLuYUXhIhj/5p7uOZwrX+JqWhlqmK3ikmStQ=;
 b=zxxPSF3Za1/mSKm1G5KgKZ+Wf2VIqGfD82cF0QANDdzFTrJICygbNYOXINyqrelJqIa1qkNvznzoYszLjKv1Vi/a0A8kS7RZtnnVAcTlYWYGHO31oyWgWj4uIR7mZ02oy7WAnZOhfH09gQnzr/8Cu2zBAgw1evMPbT/hfaCHDI8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5376.namprd10.prod.outlook.com (2603:10b6:5:3a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 18:32:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 18:32:27 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 04/15] mm: Remove prev check from do_vmi_align_munmap()
Date:   Mon, 24 Jul 2023 14:31:46 -0400
Message-Id: <20230724183157.3939892-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::35) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: 189598c9-01b3-4e06-af34-08db8c74553b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjQnAfq1MWe6+nxUTAHsJSjIEz+Eiesc0548WK/jwSk3/3CQoROUmE3YMEkQV+uv6hJ4oaIyJiq8ytCaiUuK4fQ60J752UXQ+fLPr9DMHuNOOX3hXpAeI6RjY6plJq7vpljkzx8X5LIIVsqBqYGfD7SaYMMfDln+lLtnZuYjnt0RAz5r4aeQ5hY8EEsqhR7c0vyyEoy7eWR8cQUr2cBdLw3x9C+BZjnjKOMmieS4v+3ikKMvpzncDfzi/yxAm+Gv0MupL67o1Ok/oIknthVm0ZyybQX3pB2cCjHyArc28cW+CusXrmyOrSe89g0jsuXc31vSMKTe58zGcqB6Qi5DPW8/OButjVDn8TjjHRZBeheC6ZLnTh8WLQpaaTzmlvQa+0vD7u7luvGkH+hirmL8Q3Ead/Y0vyR8BCmXrZg7ltsuvFLHwDdB1r/4X+E6ZG+Umb7Q4AFS9dO668DMPgi1gl2FQU6NljWfOApxF5QjzRozThyohLKwp2kMkG4c0GLvMWC/h5mVGDQKBWRVBrLp25+KSOyLJx8Al9JLGL99ZBk6pig4PUWx6MHcJEkMIbNo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(6506007)(26005)(1076003)(186003)(36756003)(5660300002)(8936002)(8676002)(4744005)(2906002)(38100700002)(107886003)(86362001)(6666004)(6486002)(66476007)(66556008)(6512007)(66946007)(83380400001)(54906003)(478600001)(41300700001)(2616005)(4326008)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DYCvg3uEXxO40XZ/pJBSTPdOdVByKknCZCqCvvot9zYey1o0KpiLE9dtWvg6?=
 =?us-ascii?Q?HqPQPtSZ4v0iz2QC3053zTOjfaZpafBeaFgjzvYyect/FzDixugDY2cKP0Vn?=
 =?us-ascii?Q?oSReucP99daspPa8KQWrhOCoubfXlFNtrTL8ViZxeo/SCabq5FDAPO+GRic1?=
 =?us-ascii?Q?QH9m6owJtoteMFnghEw3IwZnB1Jg6J7GwUStzCf+YV2T/HF1DkWmiyRJSgbG?=
 =?us-ascii?Q?xFtnfbz9hWeJ3XyyUlqfaRpl6qu9smpZ/v1rwbwfZdcmNhQjd9YWAie2lJ1y?=
 =?us-ascii?Q?YZ6AO3jgE7xbYaMl+BY6SSkxFIGTJba8mtSVqc49rwQIK/9Uzt5NfZGgaF//?=
 =?us-ascii?Q?EofNw8tMfVE+3k8hoVnLeWAJ5ygOfVbCcs2IYmdmhhAtoKAmMhNxQny4B1T7?=
 =?us-ascii?Q?x8n3zhCg+j6rHHNjhYPntFdHMEDMVL/KOIYFLuVmiHJ5SoQ1m0VLH3MJ5mzt?=
 =?us-ascii?Q?STc+26CGc4ZdH0jmNd2J/ZbNd7pI85UPVJ0wQH5SVBAUmIRzZdbyp62ZWSw/?=
 =?us-ascii?Q?i2Gs2wjB6+t0VHHW5iIslLlnicNC+R14jphrxAma0lN7dCVm3KhXR+E2+fs6?=
 =?us-ascii?Q?GsAQudu7iLmrzonuPEok0r0I8e0A9NENcbPbVyjbWgN5eq1y8xYTieAxNCJ9?=
 =?us-ascii?Q?0BhdNwWAPxQNbkl9hR8Xl/R6hkGr38RIEUo6D+nsWpW8AnON+lUZ80TIBQro?=
 =?us-ascii?Q?6z8qEhYuf+gMzfrodV/G4e90Pr6UapVp7aWTzvrV5rf/ZrjiLWZ6jevDntdf?=
 =?us-ascii?Q?P4VX7FD72QYeqomgn4+YiaUTFxz89xdRYBeJccZXa5tyM2kjIxT8D7OlLQT7?=
 =?us-ascii?Q?dueyfUSTxfVLBQqPLDycYN2wukhrmwY0yLcSLNW+lSkbQxvSgP6ki3RukxH1?=
 =?us-ascii?Q?ziAQVjz2OUsABex+LCuJ6wS/RB0ynT/uF29fgikRV5VDPNMC1pE68natWAOg?=
 =?us-ascii?Q?n3a+cIKZN8jeRDoxpTM21iOC7iROb7qOyWqeymGjOckRQk/IGUvuhrwtXkp9?=
 =?us-ascii?Q?vVUmmEAC/ZIzqmxwqH5EKLuQpV+znch66iJagvJ/JbqfSueb9TvpEdLz+Hnq?=
 =?us-ascii?Q?mWIZNclrcidg+5Yx5hhzpTIDWh80yHPjOa3oTGhtVb3F7OoL8rXWJL9R61s5?=
 =?us-ascii?Q?FShTGHuspcGXBNhroF3SO/kqFIiKQ/EDxk0ML2PG3Ldn8f73w7DQ9ioeGHRE?=
 =?us-ascii?Q?5vCg3+lSIAkZswWDr2NpxjeycHn78zVi/93b4vNkLTdgDj0sgXHdwrso3VAe?=
 =?us-ascii?Q?B6171YHxghb2wpzQu30ith0YSJkTJw4pmBU+P2fGU6CnTyYfl0ExEmkjNtZO?=
 =?us-ascii?Q?tXnXAtwcCtM+FyJVhkD8+9xe0363lvBub9Ra8pQX96gIhLEXWageahdrSWoA?=
 =?us-ascii?Q?meInmQPfYcHpWyMpSm7U1SQ4zFeLKah1vdgKdYhjeBQM4px6oHI70l0uyPTI?=
 =?us-ascii?Q?cgt8pZFieUn8mCvuWFrF6VW2u05TSy58hztq1j/GkxoSF0nRWBlHbFRV10rM?=
 =?us-ascii?Q?aFUJHYrIFsbUBhBHyZBU1WKAJEv2aTc2yO2Yp8lHWUXBZahOLt+ScPigJVVb?=
 =?us-ascii?Q?qDabvCFF9Uwfv/n7VCjIjcYhwPWZp8LCa1s7vhkNL4kn6RWxiZG5eC74j6vc?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kyNxLnYp+oaegKlV/zldtfKvI9DqBU/ZZS2L44QamqrDGQdJtRTHkcC81cmaO5Ev0+GQGyg2j3OpQXaqm5/iPtlcOrN0eY2uzGZPnPnUIzjFNLeMwBHaztU2jMDcEkD+U9daErED+0RtcJElE9MgV6nBu0IkXSCocazdGiamsnUixxBvREWOqnhrWVXK2na93tYnYqjfxXgpmUIso4VUysYbHW12p587xebWHk5Zqp9VdA6KLEJ57eYqXsjCD8awr1obNHnfexp81LBrnl+OASOLSOmb+b7r3rzsESD5DOEOxw+m4yTnQg1E4ssJh9Byf6aq+sox0/9fn6wOdhwchldJkrp+WSUvvnB8djEAM2REi4VYN1kXxtgo32PoApqhC+Dt9b6QgEEGlZPhtRkjvG1epFnDi/MtR8mtqAxD5ipHaXYzYo6xPXvteI5M1SJ82cBA4WupP+rBXfFfBIFW4GhPwJAndMVOBVWHa444GeEU7Jq1fSTcoPUadf78yqWYvVTlp2BxLt1fg0dC0n6QPSqX4+JG/QNkbG/0fCjrbXulA23TWS7d1QaQ3v/M6fdiaTJ49WWxAQblOL4TdYVli3owE6kqgpv+XEoR6BrUab/Fjkqd9tE4KtYytq1hKjc27n9f9FgE59Am1srjqEdK0MIytBhe+1S5szpYU9QhEYVD5I46cwt16T08eUrOanK6d60B9sgz84TFJ1GiE3pV3d3t7fEUiqbBgZOjG6z2fZbxNq+Kr55HCfO9ERZ4l3pgcL94xisdJzfsU7u3Mkb9x/Xh5yTRTOFT+uDOEoC2UisXzvZ6JsuRTIHzoEs1AnrIe5jPyCHtXBfS7E8pUZ13Z3AaynSz0V9fU5p0jwbZLuGwBYjuiq30bpZhPW5EA8zk/G/w2dQeq66A3oYycGm1evmqmgWYe1m3XaqhEUKNgJ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189598c9-01b3-4e06-af34-08db8c74553b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:32:27.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8lwNTpgv+6X/5RpewHNe12+/TPiXPg2b3hHP2Xa9dFlP8NorYPHhQAaWH+6z3+xClf6U6rOiwPyJFe+0ofCjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240164
X-Proofpoint-GUID: g4tisq40P4vHYtaworXoWym7MvP4Yr5u
X-Proofpoint-ORIG-GUID: g4tisq40P4vHYtaworXoWym7MvP4Yr5u
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the prev does not exist, the vma iterator will be set to MAS_NONE,
which will be treated as a MAS_START when the mas_next or mas_find is
used.  In this case, the next caller will be the vma iterator, which
uses mas_find() under the hood and will now do what the user expects.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index fa388eab8074..d4056d1de7fa 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2458,8 +2458,6 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	}
 
 	prev = vma_prev(vmi);
-	if (unlikely((!prev)))
-		vma_iter_set(vmi, start);
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
-- 
2.39.2

