Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55137E4E95
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344346AbjKHB2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344383AbjKHB2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:28:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1799210EC;
        Tue,  7 Nov 2023 17:28:45 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJwDJ004992;
        Wed, 8 Nov 2023 01:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=mM24EpShFpk88nOlYIOCr/oMAUhnexH0+KpVjZWSBOY=;
 b=tjFRP+nIDJ1NjLo/shAQFtIEjlIxRBT88LikAUSOGGa1TEVGcJHnLq0brnGDz180FtnM
 ohZ1J6eCZVTUMwm6jlbyac3rpY1Gl4/XZ8L+g4eSP0HkqHiidgdaHkQny/SHP+DqHIeG
 PnL+nlqa4Kkwh0hSZmOXsNHzD2bQNO6cCTodVjVNf4IC9nAw38rfpKpttvrNfk+2AOSf
 5pWNdVYrY0nsctNKZueFhft7E0Bdse/CX2tfaYzvpNQ80C2dcOb+ytn6h1+XXApeOqEE
 3jrI4JTXQoVcLS2abDTqJHhbb2QscH5RNuHquQRMxggJ0zeZgY4jvdDegCj+Tapt7VMr cQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22gb9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 01:28:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A81DstX000370;
        Wed, 8 Nov 2023 01:28:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vgges-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 01:28:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLE4S4qrBwFnWeiLtx5Ll9T8Eyman2Sh4wOdx/p2kH3iLh+abazKRvB4Jdtf+KJf+N6YXmdbnlUdZBjnJ+ZxePgoSPJReWZ8i9pyE17OwXQ5jp3pZZFvcWNOCr+o/WyyFr4seFQuTF8406bnzG+y5Xnr5a2gcIN9hDvNfQXZbfDxzm/FvYO0b8vSxAiJVI2X1if3ZCnL/UMt9OKrl7MCNtB/3O/iwE5pdCRZjNqmQmvKYZ2txDy1zWPw9EExo0c4YeJYaUxd6uGKu6EiT+3gW7YzQgvO4QImHniiR5EE3VP6mTAQu7bwsGxftbXQRWhl+oILQqw3e8YnC1SL+qZtZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mM24EpShFpk88nOlYIOCr/oMAUhnexH0+KpVjZWSBOY=;
 b=b9j6CTP/OyxxH14AauJN5bbcGLJyIbbss9ZFNW2VzLGaTEvpcglIbdSXmWkrAhywL74jxSDQiPV6PruAffPmVVMAoU7R/QmDX7w5B7dw1b+PbZYCbqkKvnGeYMoC8HDcMnlaQKjM5zkD4e5z2naEXTXGLLDURzWlPGCmhtXvMwDVGQpebM/u/4SOot3q/ZOm/4DiYROb/3+mxTPHFYYBhdH+bY8UN4lXgx2IWrQeivwxU3Xkl0MUeE0IYPO0wRRPIQbf1Zt4dvJc/P4J3x8wag85kdvvUzY9cQuDoHZIKr1PBmyrDEHMVnW/jDe8ghC4ucvmZJr/rsmHYd4h5pObxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM24EpShFpk88nOlYIOCr/oMAUhnexH0+KpVjZWSBOY=;
 b=kG09kYCuiE1zqacZ88C5N0dxO6FtDoBM6cFWSGdU9UaYqa6xiMxu//QHvccmRgS9xd3bvSqFWuiwsb3/8805x87s/gFSYY+KxOYBbV4OlMsfpHirEBS9NrjpMg/yUxnVLTLz+3PI2lA4lxAOo8hsBkGbm18eanzT9jebUtb7qhM=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by CO1PR10MB4708.namprd10.prod.outlook.com (2603:10b6:303:90::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 01:28:29 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::915a:381e:a853:cf7f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::915a:381e:a853:cf7f%3]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 01:28:29 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-raid@vger.kernel.org, tj@kernel.org, jiangshanlai@gmail.com,
        song@kernel.org, junxiao.bi@oracle.com
Subject: [RFC] workqueue: allow system workqueue be used in memory reclaim
Date:   Tue,  7 Nov 2023 17:28:21 -0800
Message-Id: <20231108012821.56104-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:a03:255::13) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|CO1PR10MB4708:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d3dbac-8acf-4845-6df6-08dbdffa0361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FPjgUp7YhF3m+ntQvNC2Lu3LsmHEiVKnHkQVpqcP49vvKMrwhWybksA5oYz43gzdfDOd+zhwKsjbj3fBAzAl32X1tGNIoJiwycnot6yDSyEO7wbI/2n5Y6iYudjomCplW+D4aZQQ6snOf0gGyDS15asRlc3BH52dGgFEKAmTWMb60bd6oVIppsQ+xqTuY5Dmuurs1JiX+E8nToCVIKU80K2xTVZ3yQkC2qLIhgUQ9/xjS2p/uioung+6Ki8fV84RqDe7Ww77cSsZoFSSkcn33Ro/dFs62/1h5+uQBXxIudTtGv8j36MZ10V6gK93DxFuL/9uj6fCB1sn9XNCHAuHXiirQHYbu2ZB3j9Qp+L5LpthdfpMnoVbEEQEQ4yZAPGG4/ZVi1rvyKkO0j71fuScQv8ZycTiOg/3X2GbbExAMyU2uKKyedd3sVJkxCj23cmtaqvu8n/KEICU3O6XjE0JwIAd06fhu7xPA5cHsfGT9Oxq18Lx9ewKXikAn9ep+LjsOLndmFQRa5zE5kUFj/VQqokBiOj05f+dueVL7mpw2bQGtgTTGO5K2JTx6lBW4kx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(6486002)(8936002)(107886003)(83380400001)(26005)(2616005)(1076003)(38100700002)(44832011)(316002)(5660300002)(2906002)(41300700001)(8676002)(6916009)(4326008)(6666004)(66556008)(478600001)(6512007)(6506007)(66946007)(36756003)(86362001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gP2V83EtPvaHdLtMzSFPb+kC87NWBMK/evDGIYjU0EomuGvSSx9MRbTO/t8V?=
 =?us-ascii?Q?dG6Kj71MIKUURidaCKVOrw61oFXp7vIxeNQwToGEP4FUQ7YnVusv4X5CYSTt?=
 =?us-ascii?Q?jICrZPy5LTi9sRrZzSw2p06Nt/6qXcGR1Q9LxbLDQYLaWyxbjjPbzU386YNp?=
 =?us-ascii?Q?xrQzZaPycvs6Bj/V7hjvgodeTIlkQwQbWO1Ybvm5TahPdbHjaIsXOK01p9tM?=
 =?us-ascii?Q?K4lQrfyEz55y3ey3WJUEJv+/Qbb4QfGKS2NVoqwBUubLELtfqkn2NUIgEq8S?=
 =?us-ascii?Q?A5Nod9hii9AWbI5h0wUHdmTvsDFopncHCVxhcJxF8GSi+b9Nx8mUBa15IgXA?=
 =?us-ascii?Q?uxpG+R5ZQCW2eVf4CDBJez97ch3tkd79A9fcuANJaDYcJWdfwBVPPs0Wx1sB?=
 =?us-ascii?Q?4Riau4M1e+RYQRG1anDkituWm7sE3pWkReS5HHtPg8RILnzRFDIRxEKt0lqG?=
 =?us-ascii?Q?3RAKwjkukhjynci/VzqotCPXjMJT1H+JXKboMYwIgyO3SG9nlJ/ywcTORlMM?=
 =?us-ascii?Q?MSnbMlkSndF2U7T5w3iXvGpKZ+bfEpU8w9Gpr9F5riAy/mNonsanvjd7vOjd?=
 =?us-ascii?Q?TfB0y6pUsEHdwURIJrjr+HrmgqWkfbYvc30Q/vBU4Y7q2UeW0qDixvCB9g30?=
 =?us-ascii?Q?z2COVQR1Mqr1k/+lwOcbKQSSVDvEyf9svMU26NmD7vsDGq7coxKog9uOi5Fm?=
 =?us-ascii?Q?1ZovzatoIHSgWiPNO3f7WLKhRrtCn7cTs+kJuS2VWP/AmMpI7fVTyg8qMObs?=
 =?us-ascii?Q?pMLj1KCXtKnntiM22p00qeQn/Ay1qy3oh5XFIC5PwCPX1XYrpc/yGWs+Wc6S?=
 =?us-ascii?Q?vY7JF6VaSPfT2s9UGNzvmGXEXqVoUiN1Q5HvKeQSKNXYowp4ZMpX7X+KbA0L?=
 =?us-ascii?Q?Q8ZypwMToYEE+w4HHNg7UQPTGJrbhacWUfc9qml64qxAKcMeIiM+QOJSnLNI?=
 =?us-ascii?Q?Co9y7aVbCdXz73cUZmLtOX2xtVUcE/eb7pkmIzgeMWoIg7sLxgBj3cjSwRC8?=
 =?us-ascii?Q?RbID+l0H8mkzRDedXU1qC1/pINWC3Jkis9y5qxwRYFJrRUfvy4czJ2rYs9da?=
 =?us-ascii?Q?UMuqupdm4c+o4dnMMjCEQy+dFZXkslA9/iQnu3LqhcUyA9oDHQbNr2p63pBH?=
 =?us-ascii?Q?dhPoOx8LVeUMxKNiRs4k6CMz1l5Vwo6I+CooIc0uJKEncAd7mZYV43Fb22SA?=
 =?us-ascii?Q?NGjDmodPbRnqkhCOU/zwWrJXuZvT4TTKjYt1qsqnH3mZ4h/J0sEyYzeNDovs?=
 =?us-ascii?Q?LmR0E9R2O9VUDz2MoQxL5cGVjVTsqulD+ZzxLsVmSfrKL6S5NJReQgZacEmU?=
 =?us-ascii?Q?CPHN7OIOC3LVwpsXU7f8hRB+OWl20QRnsK4gUlspsGYscLfNLkN/MoRPfl1m?=
 =?us-ascii?Q?a+CXT/u/Z95qXG2EJqaZu1MffJakBL8RISH7nSDg7E1lsybfQLB5f87PJ5Au?=
 =?us-ascii?Q?Q4cUJ5sGXcrvjVXOZK/fUhTijmDrF4RBXirqMMQfW6BYdJeqB3C8RNNhGejP?=
 =?us-ascii?Q?AQ77BcuZM87bAco7yMbwX5ilmhPj8IsoZrDP0VqCXiyJZcl9H+hVTJZuTZuK?=
 =?us-ascii?Q?waaq1QfFkGUvYksC4Yq4wVK0kD0FHewE3g4a4I3k?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9xC0cXBuYoflfCabmkwm6D+HqnSElcqNdJZxjI48gBrU3+2tnG33dV1YBRbERZ4k/ZL223uZ0gDtFqK/ygoP8j8yi+lKP4cDBOiuD1x6UJYbUvA7qorXvB7S8KlmzmWR9k41fV/Sg7T4kNk/k1TxlzOmDcjWReHF1EOyQ2TK2pqjKaKUi/v07WktI3++iv0t/UdaJmBQzHDbz8F+kpgh0zMXuE3GBesbsixt8Z0FwHvJq+8giWYboUOQZBh4PpcC8iUFt/yWzeqdKsBsFt232YO2+w9XqZJM6KjEd3FqZM1sr794DIPCOyG/Yf1gKfoqn5uUqegQh8lXQ5S+xfS2ckFBDMOK3zVKotpQgIW6+hzuBT/IvujVpGMHS2uy4RNGAiSodS1nyzHKtrCI8pSVYYVQV8lSeFlFC3Lsw6FaZbWZwRKdtHJSjai/jihVge1duCJev0i/74Qo5SfMQ5zH4GztDNInneBosoNKYfHpsyXOT7BKx+pDCGwa/NiSkj/aV6xU++8W+wlG7YUa8HqxAdKxbvXCCtqX8Y0lXStpFKQNVHnBK7LsRCYZ1Q1f//R9tYdMCDWt7BcoXEVcUleFFDBJMPdac7xm/vpExkNNl1GGmctyaVGSfGKUci1u2VMutkBISoQrw65bg/rV+23PonLbng1KKLqXGzH5nETYJbpEVbPmwn6+bCaK+nuMEcSkixPRoFVa35MD3ayj1DnHt8ztYwbjEalV2kvzSt045tqn90daihO09l7d4cX+qfv1vHmIvHHkq0BvjhZOQXATGepEScwI5KSiMPPyzzqXgl32PV0nmKonoP2q01h3HHiP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d3dbac-8acf-4845-6df6-08dbdffa0361
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 01:28:29.6512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyGRFAdTd/tEg3/4nXflvEJsqm567F8sqlnJrw4/YvNLJwXrfX5ApE683Ilgee/pRVSR4hbbEOTfs50dp/5XqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080011
X-Proofpoint-ORIG-GUID: llof-xG6e9BgWK6ZqV8X3fgDgo95Cq2F
X-Proofpoint-GUID: llof-xG6e9BgWK6ZqV8X3fgDgo95Cq2F
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following deadlock was triggered on Intel IMSM raid1 volumes.

The sequence of the event is this:

1. memory reclaim was waiting xfs journal flushing and get stucked by
md flush work.

2. md flush work was queued into "md" workqueue, but never get executed,
kworker thread can not be created and also the rescuer thread was executing
md flush work for another md disk and get stuck because
"MD_SB_CHANGE_PENDING" flag was set.

3. That flag should be set by some md write process which was asking to
update md superblock to change in_sync status to 0, and then it used
kernfs_notify to ask "mdmon" process to update superblock, after that,
write process waited that flag to be cleared.

4. But "mdmon" was never wake up, because kernfs_notify() depended on
system wide workqueue "system_wq" to do the notify, but since that
workqueue doesn't have a rescuer thread, notify will not happen.

Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6e578f576a6f..e3338e3be700 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6597,7 +6597,7 @@ void __init workqueue_init_early(void)
 		ordered_wq_attrs[i] = attrs;
 	}
 
-	system_wq = alloc_workqueue("events", 0, 0);
+	system_wq = alloc_workqueue("events", WQ_MEM_RECLAIM, 0);
 	system_highpri_wq = alloc_workqueue("events_highpri", WQ_HIGHPRI, 0);
 	system_long_wq = alloc_workqueue("events_long", 0, 0);
 	system_unbound_wq = alloc_workqueue("events_unbound", WQ_UNBOUND,
-- 
2.39.3 (Apple Git-145)

