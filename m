Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6915A7B2F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjI2Ji3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjI2Ji0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:38:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83C419F;
        Fri, 29 Sep 2023 02:38:22 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK8wUn013176;
        Fri, 29 Sep 2023 09:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=7XOjzuMjfk2j+QCe92vGIHxnfuGoYWuw3/vr5tagzt0=;
 b=1/izO0lNRkaeigjkftR7NOUt/rK2N7ehlqE9WcPwUhcLkhCmBzsJW1sGArhhZJ78Tb+H
 VcXGrPLnsrSF5BoixKY44Est5X/JGdXawkVgfyQj8lf0mYGuXoFsfnGjT9tR1uVlkhi6
 lmD1FF2hMVqck/v/kyJDv9kHnfjGJdEpT3e338dCYvFeAla+zt0xkLOEhyxcD+/+vEv9
 wTTfXVil48AbmoAx6jPcQwZlXbKSUoEVJ0JbAUT9HtFWi/a9IjudGPndSN/+zdbQrrrq
 5B9YZa7mYycrfnXx141HyntqoOt1tnvNTQRRNwlL3Oa3GAbmvH4ivYlYaNmigOtqnnBy Yw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qmupbvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:38:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T7msw6014617;
        Fri, 29 Sep 2023 09:38:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfbk60g-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:38:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVd2koIQ8GS87HMbjETWZp/BzKttHhWu6YbGQaeimbQImZ49hpzKg5MFhqyQBDsC6OmU4ERtH/wwiIulmFECo/aw5BW9zZhXncqnJ2/qbdKOrRAkNRqcB4MOzseAkEhPua7AoR3yxIO+PmO7SE45gAS/Jev0ZIaQqeVolIvaJIYG0bCUIAm/UQqmlU0YshkuplQzLp708MyyC29rT0u95sH2YlMENvj+gxxwri0zdL7cVzeKDN1yK9wEB6zSyBrzDlHJZtS2d2U/gym8EZYWx8xSRt8OYgbJqsgB+bc3/5f7um2bwzRQ1Y2j30LOKRHsJdF5wSNQLN4S4n7xjWuUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XOjzuMjfk2j+QCe92vGIHxnfuGoYWuw3/vr5tagzt0=;
 b=Kp0L/ZuLKl63XBj5J/huNl9MhIZzHvF/uUhIA76jJ+Y01o4ItpcCN3Jt7f2NcS9IUavvjsHvriCa0mQegmEhNk4LATHI5z39qnsHl47kXCkcmoPLJ98eOO8ak8OHhr3X0r6Xl9w8yY2MokrWhkDEoQVmVz1g5OfKASLnjPLkUII1xhPXteXfP8lC8cHk+3Ab6hn/GmiYZOYu9AEuQkgfJrgi5fEc8pVM8r6K4cs81LyhRq1nKX/LJlNkOuE9/6S4a2Lt3EC6JxZy5dcMffnMum6pkEjiIa1ZWhsUfwlLewivuzVxpQHAYEfAwLPuVK1JGZXkFw3PBvz7llgmNmcuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XOjzuMjfk2j+QCe92vGIHxnfuGoYWuw3/vr5tagzt0=;
 b=XOWi/wDES3OR+50XEhGUwS7c+014xJJ02cF/4F8EmL34yOsqVMMjCyQQxrnHxbJPz+LqCKyzmoL5U3A/oXjel/9bjNvZOCdbKLT1IzUeBIaCbUHhHluirX/SNbfa+4hATb6RIRrUEVfVkzSRekWGRLkbme2eGMXjM5Ltb4GZQxo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7197.namprd10.prod.outlook.com (2603:10b6:208:3f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 09:37:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 09:37:53 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     martin.petersen@oracle.com, djwong@kernel.org, david@fromorbit.com,
        himanshu.madhani@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 3/4] man2/open.2: Document RWF_ATOMIC
Date:   Fri, 29 Sep 2023 09:37:16 +0000
Message-Id: <20230929093717.2972367-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929093717.2972367-1-john.g.garry@oracle.com>
References: <20230929093717.2972367-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f18aa7-1dd5-4a3a-94a8-08dbc0cfc0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8Bvlpv+pZYbGivheD+1qfJvmmIvwbSw1Phfm1aYJoTdugQIJAVLFMoRXHvTQx8bMKwUIZqdYQ5GNtj5YvH7PY31uousEAR0ZQvCsOQvHqVg1O86X4c/00MeRczpo/vgs+uGFKjtnwtWYvmhjmVDLVoCrFXXh8PCQDpGMJSeXOTSU1SSRoLgZIcfp2wjotlmb4tW5LYNc6CbOJYQbkzGKFQZCBA4RMQw54jRv3/zfgnynuQm5kWzstLbp34PyDKRZJhluxBWUvkqssk7TNMT4rK+dx55zsD4obwjLiaMpZzAKRGaDJ3YD6ay3bGM148po+N5sDG6fBa9eH+8p3G+5sUSGhvk785JngB4jbWxb6peX/YxDfYR7fabavy2N7K/wQUGgMm9vBGPQaHkH5NzlFMopVS+NB7CqalUWudSLo7scMrBwp/+vj7sTVTwCjJI38Er/f0zazs2UGE8e4oNMofAsuCuryk7bFcOu08M/9d4CKLyV+Mmmkm2uXOg/B+X56jf57MuJzURJ3WfISVqxJ53tiLxMWpyQjAPsYBqtJHD7/VrMhTdz151Ay+nmLy4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(86362001)(103116003)(6506007)(6666004)(83380400001)(6512007)(5660300002)(38100700002)(6486002)(478600001)(36756003)(8676002)(8936002)(4326008)(1076003)(107886003)(2616005)(41300700001)(26005)(66556008)(66946007)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GjrftV7ruvrqXEa91ICkNF42cGKIZzDK8j0DiiBNRGfHchXZ87l92wlpS8Hc?=
 =?us-ascii?Q?ILSDjavcyIuischCDmca9qMAxS1dWuvW5khyWNTKHtd9Wzm9mnLPFBdlCaQS?=
 =?us-ascii?Q?5Mu3Sg5WeCnyxQl3QcHmcItBLAqORstFKTUZvtcukH8RCa2dJlLkBgN7OPJ1?=
 =?us-ascii?Q?Rcvt1qUUBlbLEIyDlqu5oKdJh2lsPuZfydwR11tQ9UheddRKyIsr9rvPcBVm?=
 =?us-ascii?Q?aoTYFsLur4tbbHEh5iLUhPIAJTs9J0E63+VNLndt65CrVJHGewe0hdV6x4sj?=
 =?us-ascii?Q?lYGdHUF+gmD3urdW1uZYWpXeu+ZvJ1Im+712hWNTg7RZAMzirRUfJwpQdUKa?=
 =?us-ascii?Q?N0ZIiJU1p5MPOgF7Yh0MGowJcrIFShnjUgUvEI0kRjcRyvkxNZoNUuWPSpa5?=
 =?us-ascii?Q?OJyBgx3VFc+ztj7nEAAAtEzwYaodjYyZ8q0izb5/M5t6rLI4vocyxhB58M3f?=
 =?us-ascii?Q?B+sZwUSE/I9dBlrlbRKl48aU08vC6793jKMSuDq+K4xC2opShGur1RM+XAkt?=
 =?us-ascii?Q?bVVFpYmQO2cINzyp6zM5TX7r+Tlkms7kGF54cZtmw77Wun02lrcEFwlSuqbn?=
 =?us-ascii?Q?YEX92iRpvaOF0YeuVK4SxF/JILWjJdupBTLBl4/ht488syq7q0bTsjJMecJ/?=
 =?us-ascii?Q?Wx15JC2+2UEneX+eywHwoO0DxKrenUonHYGtlu/Fj6mjelZBmTe55vjV+m3H?=
 =?us-ascii?Q?wRpEgP8e1sAAm/SYtWmWVQdx+UZZ2r37mJgdWTnNtFSdwkReqMMv0FEbOjpw?=
 =?us-ascii?Q?3nnvZsnP77YDyJxhezoMNV9wPPBwW+iM9iauCMlUD3dHjEik44H1vL6wInb8?=
 =?us-ascii?Q?T/RmyH8OBoyL0YOrsy0fQxojW0pKROCjKDcneLyWfN58/dn4GjWAi6gqcylj?=
 =?us-ascii?Q?nqhXv/zw1AKNQy88pe9gajzX+cNnJepRodzqlXMH88uY6POgdT2ePQGdvISG?=
 =?us-ascii?Q?9NcWNj7TMrhV0QigGHEroz4NbDgZRSlb9SMwPQCeG92Dlg9WPZU+8rbZ4bag?=
 =?us-ascii?Q?HTY6/XHuGTtqZ5I5jw/Od+iVK8GSPaeF5sKhR68UsxsI+VE1rbHixqdwfy4O?=
 =?us-ascii?Q?pwxCciOKAgVLdJxgJtcIQCR+iw87ebax4ugNJ5zZK9gUB28Kvwb1bqyLxzL0?=
 =?us-ascii?Q?7KCsh5OTE3FGu9RvGq3cjmwDZ/8K+UyfRcqhtsiXNY04bQhhi64KpuP0m+Sj?=
 =?us-ascii?Q?BcNtSHlWIiS7sbB2jVZq6iMlBj1nVMx/vBGp7RCEI2FESrwKwFBdHlm5O2Is?=
 =?us-ascii?Q?vpa0niPVNU7kgy9hHWnLGxMWJPQONSaFMsn2Lc2v5xy1H1S+imSOhqPbB/Am?=
 =?us-ascii?Q?7MMZ5Pwpl6+6tbYP6yhtPx5kYNw93z+E1MkXkulm5S+9parzFKuaSfI1OO3B?=
 =?us-ascii?Q?fRmCqZvpK+e8PcxfHd7qxQJpKECsUs0OpEovFPP+PFFG/KTPjBFF4QzwHk3p?=
 =?us-ascii?Q?Dmhyd7KCAX2ytKFOVahTBLBNbQzecZORnidkc/f3gdAM/7se3Mm5DBlL/LJn?=
 =?us-ascii?Q?jcVBhOtOLtKbPe1bHt5KU+QJsOGvzE+Y4owhGfgcbm7xgT1+gfOYQXXx3uhw?=
 =?us-ascii?Q?HvxGeCp7AAJpYQ3nlb027wWqcYDAhCktRYSX1r34?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: USomWYX4Z2MzJ1xo5MYNSSdyJAqlON7bU3Zbh6NX5LWxWjHPTHEp+i2eI9wN1pmOJIL3VezA0CDvhciwKuUzit0KpYFGfr801i1m3sqnaxkIBzU45EK0bHyIAOc6vZa6H3+9oFOvKhfEZgZpa4BFDtfbjmm+nR/ev+liTYboExk2LJ//y+5knK81GDsGnjKCu3ZfAl8qo1U3qCMr5F5fYMqODny2m4IC9Ztmwxu19+JYNmQwWIbURBGTFMHxMZaMbNhsQadY2WwWl/4mbXB1AgAvP5Rlux+cWuqPGgCak/9DJ/Kfa//H2H14riFBkS7kg2zvsj8tNbbN9FmpNs7rZxTpPZY7xVA8MMhG9FHguLF0+OiYYARzs8U2AtfoUJfb9kIuoz0QAW9fUiTRMjreXYn1YzG/RbN/u6WndQzU/6VxLVVnDwunu3E6yP/BCM88Glb0Jw60iXNUjR7Dy+KEaYD9gz8Ge0/bEJdpLXwnhdifTSuG6aLwVWMR6BjrtfgKs/usJlH+OO+1YGyl3shrndu0p0h+y9W6jY5pK0i57S18K37KqNqw8JjVbAXSiEg/nnQz8TPhd5syAwiQqpjmbOF+KFNcEu25VtG6t4uvDs32A6wne0VDNdsGTDqeE1G5nrigyhRLinNNhWHHQ2aa6ciFXV+p9VQ289HNW0H4YmFkYdLfW/iU31hvB1OBziLVO7OJ+QFlK3Hmb2kfFVv+VK4oDIpGoKO4HkxDV8RJiN5QYDwG96t71W/r+zjtIZA9rOgCctPFO8OjbU9PiUbH7qMrGTFsPETRXTJ3IXAhaQ+C5GHZTqP3czxSJdPCRi/j5WNREGt45Bl5id3VvhSL7A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f18aa7-1dd5-4a3a-94a8-08dbc0cfc0ec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 09:37:53.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OK5iHTHm8863P3fbfVVBw6hofHBenhcwpywhCQk2ESzpe9QVPwwcqvuE5L6HKYb4+qOmnNWNJ/JHiIANh53QJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_07,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290083
X-Proofpoint-GUID: 8HL7VOI_6h7NURaMGP6Zc1pcMxu_k5N8
X-Proofpoint-ORIG-GUID: 8HL7VOI_6h7NURaMGP6Zc1pcMxu_k5N8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document special rule when using RWF_ATOMIC flag in conjunction with
O_DIRECT (which is the only time which it can be used).

Some block devices have a virtual boundary, which is a boundary at which
write iovec vectors start and end addresses need to align to - see
virt_boundary_mask in linux kernel sysfs-block Doc.

To avoid splitting writes with torn-write protection in the kernel for
when vectors cross this boundary, special iovec boundary rules are added
such that we don't cross this boundary.

Even though a virt_boundary_mask may be larger than the CPU page size,
we just impose that as a reasonable limit, which matches what the linux
kernel NVMe driver uses today - NVMe is of special interest for supporting
RWF_ATOMIC.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man2/open.2 | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/man2/open.2 b/man2/open.2
index 4c921723c95c..e5b9d107859a 100644
--- a/man2/open.2
+++ b/man2/open.2
@@ -1782,6 +1782,19 @@ blockdev \-\-getss
 .EE
 .in
 .PP
+When
+.B O_DIRECT
+is used in conjunction with
+.BR pwritev2 ()
+and
+.BR RWF_ATOMIC
+flag, in addition to any alignment rules already imposed by the filesystem and
+underlying block device, it must be ensured that
+.I iovec
+vectors have no gaps such that the end alignment of a vector must have the same
+start alignment of any subsequent vector and that alignment must be least
+at a page boundary.
+.PP
 .B O_DIRECT
 I/Os should never be run concurrently with the
 .BR fork (2)
-- 
2.31.1

