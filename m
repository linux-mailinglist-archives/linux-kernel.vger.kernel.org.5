Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67BF7AA446
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjIUWDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjIUWDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:03:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CD71708
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 15:00:33 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LIsMph011449;
        Thu, 21 Sep 2023 21:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=vXachriqI2G07DPHBdr1CjOKJjQtZ7Niln1CgrFGINo=;
 b=STB8aRU5VFb+g2YoUaaU55Nn/WU3i8x6eAxwotrOOgk/75hNvbXfT0gKTJYoihAl1EvC
 i4S/UrmOSUHH2YFRyzVv6KRUj938k2f4obUcfA6cXAWENVni9BQari944la5PVMrKiU1
 4KMH3gDSD1ZCXjm2UZWOnlmgDD5GvX5qUKGxnng7tGMkang6aUuEesYEZqrfYKS65UcZ
 k+Hct8Zem8d3u9XZyRp5Z1mHJ22BpeyUE7FdKv8k/vMqMGvqFplcahQzCEnltqUA+gpm
 aAYvmKLepSrTaUEg7b5HvGa2DfJiwRUVXWsa6I5RHViEeO0JxM+QdIC1tOCWqC2GYGWH 9Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsvrdxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 21:59:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38LK7lic039381;
        Thu, 21 Sep 2023 21:59:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t8ty1qkd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 21:59:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GG/kQ4x9Ldy3t6s6dnLAtqttLQOz/Ees2in+npZLNuYRtYM4KxL1zohCJBk1y49xzlOLzmsfRFA4QaVYkfGN/heqjbVdtnTZJ2zkLYTggf5mc1I9as9k2KHB2d2P9Y03ixKVHXaouuj6gdEqmWOCDztAdDn5bMhLEQWxI0V7MR1XX3LXpbg6sq4Dk3euCtlAKE+Y9xajc/PaoYZezUbZRmhsrsgoBB6oZwPazrxhGTZ8Vx94UcuoyMDjVAGe3vwPPeNSblWLxBZWwVlgY5EbQrR5hHQvRMop8zJ6Q+paX8o5+pjvca5g3cCL91PXocLBqpLBCxFiXGn3GLp6VjlpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXachriqI2G07DPHBdr1CjOKJjQtZ7Niln1CgrFGINo=;
 b=kQ5vZgVTfgAycRI2u/ddxK50m5ZCJzGMEnmNIdtEVABGeqN3ZQqVASBdWqD09UmB21YE+MzOOAfyhAhrdHx+OgMCBzOTu9KwWgLmb4Rgnrscy2LmjRUtLT40/Oku6fG7r5u1KFZqvYsb5kSXhhO+AfPjARobzf/G1M7LY0gie2rc+MPYFaG4/oG0//vNVZdLii3MIZqTRdnxmEodaVlSihuLFlvcQIzFC6ypUewyG4hd2ySSyUJ61ES3YZXzLThQ/tqVAij/Gu8EK0GYD/z+n46bjIB8ocK+HUeYJEHMoKxmeIaEdmqAJV4QkYa9DziAg130+DO5aZfTQY9lXyzsVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXachriqI2G07DPHBdr1CjOKJjQtZ7Niln1CgrFGINo=;
 b=gmrAtzT2jvFBF+y3XYiloQQQRVcvlD0EEQv1HYUjCqfYMCj0baGDi1g48uNO+HHrlNvmKttT5YAYDE/3wqrmORadfz7FYkUOYPh3Gj3oWhQMu2twzoMT58chOlOPLyApzXmDzdzBzXurga6KxOPsG5+r0VmPj9LXixJuY5MKkW4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM4PR10MB7528.namprd10.prod.outlook.com (2603:10b6:8:184::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 21:59:47 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::54eb:a3ee:c3d3:7bb2]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::54eb:a3ee:c3d3:7bb2%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 21:59:47 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH] kexec: change locking mechanism to a mutex
Date:   Thu, 21 Sep 2023 17:59:38 -0400
Message-Id: <20230921215938.2192-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0040.namprd17.prod.outlook.com
 (2603:10b6:510:323::26) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DM4PR10MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf2d952-0935-43bb-71a4-08dbbaee11f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /YnekiIwuXKxRrSyUYaqLORXEackSyBGHanMhNt8d/McCh5Sv6SFX9pFp9Y7X8viQuZKl00fQ2G1kEyBCwyY9N3fprFbvcFeDoVKm7UWFKvuyCd2o9RkCt3S0ad48URzPw+IyNl4nCa34rLVqxqj27+KT31+/Hd54CBb2UobRnmd/iHqWTQ0BAn0Wks1OuWWEPG8k/3vd9d5Zzl/Pp9OuIL/uiIS9WpGhaYT1yNEngrj4DO+UgHhxurGmVi7Gyvqcy4zAyU8nCvZLzpXgZfv/AQPMxt0inIIU0Kyp+d0JRJU5arR2V1Qt1ECYMeLfGd5eAGdoP5oqZAh9Zu7YklW2xix6UUpvJdxHzeADf32RTvl5wXMtN5VAUmEufkkePMQZqxlWuzRAqktfnA297krzkRaBEfn+Ru0ECkFz0NB5rUk1jUmXRlTMIGFZsoqyTJTJO+ai9RX3JXydnAboe8wQW/xD70/REYGhFk3gEZo3fD6p6sBXq1ZptIF/Ya2vB18tYGsQUXOW3RFanZ8Iw/xxPcY1ngOx6dVNwi0ot2lqdhLFCFg0z5lpJ2Las1NLNA7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(186009)(451199024)(1800799009)(478600001)(6486002)(6506007)(6666004)(83380400001)(6512007)(5660300002)(26005)(2906002)(66556008)(2616005)(316002)(8676002)(66946007)(4326008)(41300700001)(66476007)(107886003)(8936002)(86362001)(1076003)(36756003)(38100700002)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xLQuQucs7E1nWRIdovQH2npHE8vm3XyI5E6hy4Q3P2SCaL22nrS41FkDblDf?=
 =?us-ascii?Q?nUeoDWqa9Xlc+1h8Y1lCE44l983TbOpzAah6QfDf6DLgz55lK7Fw8KXzpGj9?=
 =?us-ascii?Q?E0qDv4WUdxKpZx3fOEkdFxS5JJZc4ZbczGG3iZ17SSYxHIy+NLRGk9/xcI1Q?=
 =?us-ascii?Q?Wr+2FIhHi+nqji6nwWfQka+FYbAdQXGmrc2Kq30a82iByPHeT1PONRCYkkn5?=
 =?us-ascii?Q?Vyc7UMs8Tjr3845XkrKnS+dnoVBrJKLkwi9vmPBHtLYGNxF7RwWbsJegr3OY?=
 =?us-ascii?Q?R0lwvBwxkBpOlEBl679KwH52522sIaTbKwA3P+IxVqTjmYLACheSvz2dMuT4?=
 =?us-ascii?Q?+nLEtyYzygDF/RGzA5wjtIA3LMudLKbyjXsvXwKtsg5QYT61tDXuDZsF4Abl?=
 =?us-ascii?Q?VFScmosfJIIDnhhcop8wmATnam30HLu81oUigV9He6L9leaaOWH5+7WerSXv?=
 =?us-ascii?Q?CPvEwnkNxrHk0wX0WrMqqQobSncnGm9vbkm0I2fh37KYru2YjG5NwV+Xj7fg?=
 =?us-ascii?Q?L3dCf2jkdAePm6tMbsQtxa+yFhrOm7MyuJmYKFmmkOHAFdsGEQJCzbla9nY6?=
 =?us-ascii?Q?Wf1G8/oQpmF63P96S9zL/ROCf2nMYdZXSASVyxAHs4sftbpONKf/alRx3oYi?=
 =?us-ascii?Q?HnzxUGiPNgDxKe/fRqOG90XlxRLckzJU6O+Ml8vco35TnpVLW1SE9TmPNrgo?=
 =?us-ascii?Q?zxz0SY24/ncA6xFpv4iKeiSaxt0o4UMZL/pYu7d/BRotiDRo3hjF/gVbISZq?=
 =?us-ascii?Q?0eysmTknbdv4D0RK0cFs7Am+2zgoQZqQ0XoUTok+DE1pARrWn2jLJPodKN4L?=
 =?us-ascii?Q?T//8FPLNugFGHrbDYbVQd72+wBV/wH8QzZHenOW1dviOXCsyNevTENNWrQq3?=
 =?us-ascii?Q?1c7VRzV+SJDXFc8fSuzAkraCCWnIpz/qSaHe9ZeZpRIWGCz8EWlgOGYCcIqg?=
 =?us-ascii?Q?HDiEI5UgLI+8WvmbszDKnjRWRhzTCkw2ahW35FjBE0h0WJYMcWAkDEseFftR?=
 =?us-ascii?Q?oVgCpSETZBZVso18O6VmNPFSm/b0MVdZF6T8BffL/vMDU5AAK7xGJIPPRSWt?=
 =?us-ascii?Q?Urzoz6WHyCpr/slW9hYzR78BQohCSlt4PZ84hjUVlzFkguccOSuoHPo249Z3?=
 =?us-ascii?Q?2t+2Sm3EH/isJFCRiFT1uesAU4aAg7zDWgCqTlXc/dr6dMw9xovDU4Ylmwo6?=
 =?us-ascii?Q?3qOa3a5f5Dj2kRqqVURkB7P5sshWLBy+Rx4HYnB1J/03e5UKWUv7lctIfDzH?=
 =?us-ascii?Q?0aPFBoyVp8GC3djSkjV7braA/oERRWaefP1txJ4k5cbrRnyWQbhW1mUiVPRS?=
 =?us-ascii?Q?SrMct3gvPYC3aEworXtdpkdGxPvoY8Nmxk2RjtgWHwWOA11s3vyyayHJy+CY?=
 =?us-ascii?Q?4LB8rZOifgl0m2UO2tSqNcFj0fJzdECanIrt9nCdLIQNGryYTUkH9whoQRKf?=
 =?us-ascii?Q?3TwbBcoaU9ZvPQc2Yb3cicPvuYbGzAdaAiPEsONuyuPbCnXsOy0Puwha2zpY?=
 =?us-ascii?Q?jXc3vTWgpdxAOaaD2RuYrvpluLaMEbIGcsZMP1gw1jdpP6PRs+0TD9iBcu/+?=
 =?us-ascii?Q?SajQY9KuOlk4BYEpWFXyasDuLE3fZnRcP/bwAdBI7vDqYaBZ2fyHV3/yHUZ0?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ytEeUQKCGDrUAdMpShQn8aZHgq0n8LEl9lgI2qyfjaqvmC//21Ane6Wq6y9ARFiISC75jMZ+MlGS40T4uKl5S4BDpYfyWQs6nq6A7FK0kpW7nRADnILisOFegc3d/Hv0SCHhL+Ei0Vdin0LXuc2iqOi5dqxEh54bNXTPpv3OrJ7xTeFYQusPcIPojcjlChSnT0xsQ0vuscXfqauVEPnS9130zKB/AeBf/dNCP55nV2B2vb56oBSn5zra5l/cn+iBbxemg/8GknKQt1vmDERSUE8gKCXOMmEssnbGPK/I46s40zg7t+yVv3iygwnX0FEykgH5QqWOPYqzLau8AzMT6Dn5JYywYqaobjKMVHSY3rUTF6yHGxFQP4mDgkJOC5GSMW/nK2WI/YcJGBBuyte0K7DL6USEex74MNa3RCoJxC5neZav35lAeNjeErLYLFOVGpFiBtmvEMvYLrahu9MWSvTuf12r2uftMWlQXiWv/gaS7nsaSSbiwJlMB5bL4JUwcGutjN4JRD+RCc3qsS29JIO0Klt/ProIxLz7oF2G8CO9hUXVQv9wlDXUhyd5eMeVlMLgfpADuYMNOnvuPh61LTOv8qjmFjf8J0LDdOLjN5Nt/fvP6MdaljWCrBb7gY9Xl4MksqRR8pM17UvTfzu8Ev8hFkU2kXpeXEvr7qY6cnn5LbKvPPRxVo48L8CxBRGYhHrvOdb//xsWsR8nXzYqWANRvnJ7DGo3nXIYwNlVMm19twsw2oo89wsVsUZ1MsYXK6yFhVdAECrIa7IKa3xLX6V6hcVjJhd6DKQaCDqGtx8Cl1fpndgqA1M6imEVngEI0ch6upPChEv+3oA0Tbe9UJ7U1ScyDFagmQiTbRu0ClzRpRtxLRgB1iNd433M/DbL+PT1xbTZuuP7xZyn4xpoCLgBGchi5o5AgaN91ufdDZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf2d952-0935-43bb-71a4-08dbbaee11f5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 21:59:47.0853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRNYtUTei6gE9sbQd5hiyoRDPAl9O7ptg3RWZXhHGl7Is7LTOi8739zeggmgEoSJGWNK/rHrHeCkOBf0anZ0r2pNmIqSAb78Q2ro8yGKtSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7528
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309210190
X-Proofpoint-GUID: V5323y-mFQnJg_ZRQrQyXhhQsw1J9TgM
X-Proofpoint-ORIG-GUID: V5323y-mFQnJg_ZRQrQyXhhQsw1J9TgM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scaled up testing has revealed that the kexec_trylock()
implementation leads to failures within the crash hotplug
infrastructure due to the inability to acquire the lock,
specifically the message:

 crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate

When hotplug events occur, the crash hotplug infrastructure first
attempts to obtain the lock via the kexec_trylock(). However, the
implementation either acquires the lock, or fails and returns; there
is no waiting on the lock. Here is the comment/explanation from
kernel/kexec_internal.h:kexec_trylock():

 * Whatever is used to serialize accesses to the kexec_crash_image needs to be
 * NMI safe, as __crash_kexec() can happen during nmi_panic(), so here we use a
 * "simple" atomic variable that is acquired with a cmpxchg().

While this in theory can happen for either CPU or memory hoptlug,
this problem is most prone to occur for memory hotplug.

When memory is hot plugged, the memory is converted into smaller
128MiB memblocks (typically). As each memblock is processed, a
kernel thread and a udev event thread are created. The udev thread
tries for the lock via the reading of the sysfs node
/sys/devices/system/memory/crash_hotplug node, and the kernel
worker thread tries for the lock upon entering the crash hotplug
infrastructure.

These threads then compete for the kexec lock.

For example, a 1GiB DIMM is converted into 8 memblocks, each
spawning two threads for a total of 16 threads that create a small
"swarm" all trying to acquire the lock. The larger the DIMM, the
more the memblocks and the larger the swarm.

At the root of the problem is the atomic lock behind kexec_trylock();
it works well for low lock traffic; ie loading/unloading a capture
kernel, things that happen basically once. But with the introduction
of crash hotplug, the traffic through the lock increases significantly,
and more importantly in bursts occurring at roughly the same time. Thus
there is a need to wait on the lock.

A possible workaround is to simply retry the lock, say up to N times.
There is, of course, the problem of determining a value of N that works for
all implementations, and for all the other call sites of kexec_trylock().
Not ideal.

The design decision to use the atomic lock is described in the comment
from kexec_internal.h, cited above. However, examining the code of
__crash_kexec():

        if (kexec_trylock()) {
                if (kexec_crash_image) {
                        ...
                }
                kexec_unlock();
        }

reveals that the use of kexec_trylock() here is actually a "best effort"
due to the atomic lock.  This atomic lock, prior to crash hotplug,
would almost always be assured (another kexec syscall could hold the lock
and prevent this, but that is about it).

So at the point where the capture kernel would be invoked, if the lock
is not obtained, then kdump doesn't occur.

It is possible to instead use a mutex with proper waiting, and utilize
mutex_trylock() as the "best effort" in __crash_kexec(). The use of a
mutex then avoids all the lock acquisition problems that were revealed
by the crash hotplug activity.

Convert the atomic lock to a mutex.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kernel/crash_core.c     | 10 ++--------
 kernel/kexec.c          |  3 +--
 kernel/kexec_core.c     | 13 +++++--------
 kernel/kexec_file.c     |  3 +--
 kernel/kexec_internal.h | 12 +++---------
 5 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 03a7932cde0a..9a8378fbdafa 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -749,10 +749,7 @@ int crash_check_update_elfcorehdr(void)
 	int rc = 0;
 
 	/* Obtain lock while reading crash information */
-	if (!kexec_trylock()) {
-		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
-		return 0;
-	}
+	kexec_lock();
 	if (kexec_crash_image) {
 		if (kexec_crash_image->file_mode)
 			rc = 1;
@@ -784,10 +781,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 	struct kimage *image;
 
 	/* Obtain lock while changing crash information */
-	if (!kexec_trylock()) {
-		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
-		return;
-	}
+	kexec_lock();
 
 	/* Check kdump is not loaded */
 	if (!kexec_crash_image)
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 107f355eac10..a2f687900bb5 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -96,8 +96,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	 * crash kernels we need a serialization here to prevent multiple crash
 	 * kernels from attempting to load simultaneously.
 	 */
-	if (!kexec_trylock())
-		return -EBUSY;
+	kexec_lock();
 
 	if (flags & KEXEC_ON_CRASH) {
 		dest_image = &kexec_crash_image;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 9dc728982d79..202e4590fc1c 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -47,7 +47,7 @@
 #include <crypto/hash.h>
 #include "kexec_internal.h"
 
-atomic_t __kexec_lock = ATOMIC_INIT(0);
+DEFINE_MUTEX(__kexec_lock);
 
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
@@ -1057,7 +1057,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 	 * of memory the xchg(&kexec_crash_image) would be
 	 * sufficient.  But since I reuse the memory...
 	 */
-	if (kexec_trylock()) {
+	if (mutex_trylock(&__kexec_lock)) {
 		if (kexec_crash_image) {
 			struct pt_regs fixed_regs;
 
@@ -1103,8 +1103,7 @@ ssize_t crash_get_memory_size(void)
 {
 	ssize_t size = 0;
 
-	if (!kexec_trylock())
-		return -EBUSY;
+	kexec_lock();
 
 	size += crash_resource_size(&crashk_res);
 	size += crash_resource_size(&crashk_low_res);
@@ -1146,8 +1145,7 @@ int crash_shrink_memory(unsigned long new_size)
 	int ret = 0;
 	unsigned long old_size, low_size;
 
-	if (!kexec_trylock())
-		return -EBUSY;
+	kexec_lock();
 
 	if (kexec_crash_image) {
 		ret = -ENOENT;
@@ -1229,8 +1227,7 @@ int kernel_kexec(void)
 {
 	int error = 0;
 
-	if (!kexec_trylock())
-		return -EBUSY;
+	kexec_lock();
 	if (!kexec_image) {
 		error = -EINVAL;
 		goto Unlock;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f9a419cd22d4..a4daaaab7fa7 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -341,8 +341,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	image = NULL;
 
-	if (!kexec_trylock())
-		return -EBUSY;
+	kexec_lock();
 
 	if (image_type == KEXEC_TYPE_CRASH) {
 		dest_image = &kexec_crash_image;
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 74da1409cd14..4fdae59767b6 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -18,15 +18,9 @@ int kimage_is_destination_range(struct kimage *image,
  * NMI safe, as __crash_kexec() can happen during nmi_panic(), so here we use a
  * "simple" atomic variable that is acquired with a cmpxchg().
  */
-extern atomic_t __kexec_lock;
-static inline bool kexec_trylock(void)
-{
-	return atomic_cmpxchg_acquire(&__kexec_lock, 0, 1) == 0;
-}
-static inline void kexec_unlock(void)
-{
-	atomic_set_release(&__kexec_lock, 0);
-}
+extern struct mutex __kexec_lock;
+#define kexec_lock() mutex_lock(&__kexec_lock)
+#define kexec_unlock() mutex_unlock(&__kexec_lock)
 
 #ifdef CONFIG_KEXEC_FILE
 #include <linux/purgatory.h>
-- 
2.39.3

