Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11081809B90
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbjLHFLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjLHFK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:10:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20804A3;
        Thu,  7 Dec 2023 21:09:48 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B82TpIW021176;
        Fri, 8 Dec 2023 05:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=b7V4jM80a5YZ5rjhUwTfKSxgUKjp9SsS2oJaBa/C77s=;
 b=dRn8muuir3NK0qndcV3RXPAhVPizOOxjqfqeUq9KpA8tV474nFdk3yBKZzjjMC8Nzd+N
 F+YnKQh919m7SMqZnE/s7x7rqXT9wRYHhpKTTs7KUfk6qzKwiacZSXIoPfMVVLoqQOjW
 XT/zEhKdeoMJvd9gcdA8LyjmWqJu3zyL7O74XGFf11CV7KqOY72OPw/VNDz+lW0eP4Qh
 mJK+RYWsvRi+nQ2IqoTwMkU9P7mPTIdYUIX9jy9YuYKY/v5Ry//Q4LVyaPpiyRc5ahBb
 6lhtLtyhZrt09omOFYEoY/r6Op8+d4r12DtvQwydkeDD00qr6h14Fw8onJwNUcg+xbgV Gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdmbnd34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Dec 2023 05:09:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B84RHq7040287;
        Fri, 8 Dec 2023 05:09:37 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3utanef1wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Dec 2023 05:09:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDPYGz/bbsP+jma+durDL6zwyUUD4/VYfaUhThb11I6LJfsRTOSGvIvDijvx55m273U6JfF9MbPRSlz4vQNAKrPod5VWOSeexQxYAp1SJ7Mdv6AQ0rCN8z1JGna2jWJ7HAqnocZ7gsrMqIVFuOdO6r3htuDktuqAiyDD+05LjXUgtSsxPC40idAnrPhPzm2qi6tFdOgccF9UWmgi+C0PihtT2vghHk5RpdHdyogaIBcsUt9QF96s+ZSJ7OULZ/acxILl9rOoYh3c3TRdXVKExyal/aUOeX6kLR1NNjd/JJGNaOJakeYPSdtLHGEy62J3iUmpGLbZzRZHGft9DZjJ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7V4jM80a5YZ5rjhUwTfKSxgUKjp9SsS2oJaBa/C77s=;
 b=IW1Vi4j9yPxfSAmZmhnz0rYSqJfKUkz/ogIAEQssw3/UBOCrdJxBfvyWoOZLvDH8dQdSA6+bSOXy/g0EZI3bK1RbAL6/W6j7Yn69GdFbTMeEEAiiwJhVcARgBvI/cC/bvyIHd7muekJ8fZvhyC39UgsVVdYlMNra7B2ljy2fGOujIrcdAKpg/K6YZKuIgI3OpbIODQE163vUuZ8xiquZB6CKh3gvfg7d+m77u5+9mlrUJ0TSTjUFgvhWtGRUujc6jgt2jdu3U+vVF6eTh7K2Y0gtGGwn1bhcDLwfdk+RxdF93KrmvhhqUeCSuL6BmPm5xBTfYW21YtGY9rH/K8dDbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7V4jM80a5YZ5rjhUwTfKSxgUKjp9SsS2oJaBa/C77s=;
 b=TkjhGhVG7Cxt0V40vm/weFaoOVz7ChejcZs5iGLdKwxgdPBS2uA9ae+9FvqQmChZ6F5wX3xqQ47J9EDOkQTgaZPFIiIHmJWUdqk1QNHXVYgC0qZv7OFF/cdoJsH8OzMCdRUWAJklq+iFLtuTo8BNQEdQODVr8bsrFUrSLRB95Hw=
Received: from SN6PR10MB2975.namprd10.prod.outlook.com (2603:10b6:805:d2::10)
 by BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 05:09:35 +0000
Received: from SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::de47:3c1f:a55b:58d0]) by SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::de47:3c1f:a55b:58d0%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 05:09:34 +0000
From:   Kris Van Hees <kris.van.hees@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Nick Alcock <nick.alcock@oracle.com>,
        Kris Van Hees <kris.van.hees@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH 1/6] kbuild: add modules.builtin.objs
Date:   Fri,  8 Dec 2023 00:07:47 -0500
Message-ID: <20231208050752.2787575-2-kris.van.hees@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208050752.2787575-1-kris.van.hees@oracle.com>
References: <20231208050752.2787575-1-kris.van.hees@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::32) To SN6PR10MB2975.namprd10.prod.outlook.com
 (2603:10b6:805:d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2975:EE_|BLAPR10MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe2e076-12ff-4c00-a3a3-08dbf7abde86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ir2T41DtqNrhzhTmRy6Td53bSjLeCoY7iUL2chvE+Wri59vt4aTNKO1O0hftMovrNxJPd+Ok9/qYapErgXdJ2Y0OyX5LfuzocsZae+SKCBJiW+YTW/74kEmCzx34E4iLghkb776Rr+ZG80+lK60c2VqIuP6pe2PBPvbRevB4WQhaM4lgkn0d6W6m1PlC120NhN7SDQsUhY5psOHT6HWg69qzntxfc10t6OA9aifmQCxxvM6Sp+QCA5XNHQtpnFONr2Wc9A/Q4HvGzrg02vPIGtsriL3n8bn5eyp3PEaXk2mpD9ttgBuTGwaUXb77IDh0jk9axD+eYpvK1pnBorBBtBoLk2FH0/CD7fgLV58/a4cEL0G7Oa/NDUegpSxc+MowF01F4ftldHOHpmROlFYrqM1zjpPzMG+FAqtLDcLsNw2BVptJzeYdn5eBQiJwdLqf6dOozd1V+i7NYI01bdK7qCb4ZtJk8h5GhAkQwEVvb6en4OmsM3qpgVtZu8Pjd4p59K5C1W4rxzFnrMMDNcsRsGFgTbnThsI28fg34QWwqKOijf/z7GPRePmtCqwqSWnG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2975.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6486002)(478600001)(66556008)(66476007)(54906003)(66946007)(38100700002)(6512007)(83380400001)(26005)(316002)(6666004)(6506007)(2616005)(1076003)(2906002)(8936002)(8676002)(86362001)(4326008)(5660300002)(103116003)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tkbtj/cU6CbbfPNNT4Jcgs0NhSiP1mWGjy6v6fBvZ3StdZfR70ZhbzK3UJxh?=
 =?us-ascii?Q?Ge0cs82Qn76z+YkFs8HoLrT+yaEQ6Xw+QV1zbOfp3QO4zMto9LoUfXcwacIp?=
 =?us-ascii?Q?eQRsBogCFbjXtwRHUlQxxVmPgIz5onbrur7+dh1vojVeY/8BbR/4ktHlXfai?=
 =?us-ascii?Q?fxcn2WtXOEa5rRN42bdbqxAfmvu1e8E8luMCqU5Mp081uY1/ZWQby8vi9pjP?=
 =?us-ascii?Q?E0gA6BUzf+pOGNI3r/1T+BQ8DlvOQvWudwdOjvzl1NsUODv5+UuY9T7+tl8j?=
 =?us-ascii?Q?oR4Qnk9bROTFmQVYoyaCzRY+6INQlC9o6n9KGFYzk0SWi5KeogsqJqWED1jL?=
 =?us-ascii?Q?VZu3DuXTcq/T9qIq8IOohXiYXo+hGbmo7LlYj3NZzc2jQOKJS/L+wWRQ0zs6?=
 =?us-ascii?Q?519dCwKBA5c/u8fjH4AARIyvEUnFA+1c+aQBNcpxc0asmqw0F2r4badk4yop?=
 =?us-ascii?Q?iR7/PyLTaHg7gzYG24ss/o1zSpm+bjI2+8UwjIIH7tBQMF+PHSLjb93c2DIj?=
 =?us-ascii?Q?Nd3cU5U3e53HY5HYOKwfFKXOlhZjqt+TTmfObWmdkIn3+MNtcthaTE+1O3BB?=
 =?us-ascii?Q?wBkPNCwF2jCcgL9XGi0LbGgKcKkKdnmN4c2CI0GqznwSPt1pnJo8gLzkVyHT?=
 =?us-ascii?Q?mMMYuJjxn/nbeV1CmnpLugd+iFca+JKMkXfp5PIT6CXYPYE2bF0Tgu1OGjCw?=
 =?us-ascii?Q?EfGdUPKCJk2qt+dWWi+/B4Ep53cnGyAplxfVabIHVyvpHLKkaygDD+dlUFSJ?=
 =?us-ascii?Q?9an4/crNkOWI7+wk1VZ5im5h3xA1o/6PkuFWKsvxzTqGXGgsilfUXA61wBvH?=
 =?us-ascii?Q?chQ8pk4qYZo/8VG2wSTz5rNWJESF0a3Q18OxzoeWH1sGxOmq7/U9AabOhFPb?=
 =?us-ascii?Q?6iAS3nTVdVMoYuQJ19Ph7i15uubtTO8NlJFvNYX4SraQV8ifjQ7NqeOVPgn2?=
 =?us-ascii?Q?3oa/gegp/7dDJlEc0rnP6HRaRTZRfsgvz0D1v7Kte1mMjTQnW5eRRG+ckdLL?=
 =?us-ascii?Q?VNSyVTzPEEIVHekKfpveYhbvbXb3yyNDW+k7pGZdSuGoq2AtikQOBE138FBu?=
 =?us-ascii?Q?UTj5XgJ4f2eBBEWyTrY7mn18D1iKqCrCLYG3gcEt5hIg1t8z8jV0MYEJMfB2?=
 =?us-ascii?Q?dzTuITRy/gH5HNYgYdaO2+ZZkVG6uO2WqDDdt3MbDeOohUaa493WkBoXMv6X?=
 =?us-ascii?Q?+VO9B+24osu4Mnrx/I86dTe1x+1C7Eq9VihUj2zARX196UqiiDtP+Y2Tl25C?=
 =?us-ascii?Q?X5opEFh7mHX6nAWZ3nDFxmOcOnog5dGFn9dIMzDE/GElhYafkfE8B21Z/gHj?=
 =?us-ascii?Q?40yA4fURahDustpgj2+GyPtxjSjuPtJVBfVspA8+82nAPyM+svh0E8T7nLBX?=
 =?us-ascii?Q?cyqzd0HFln1/X7YGX/5ZolIgP/AWbqUZML5YUeOB86wE08Js0etSH8U2djbk?=
 =?us-ascii?Q?KYzAjPPN1KloIiNLEht4LSKLmwdyfpPNmWqY0RRB5q7KV67GJ3gu92j7xlgQ?=
 =?us-ascii?Q?BcyZDBXXGVicRBdga7Ob5bqMYhqeJjgmrxvVRdGlVMLimxAQmSlXY+UgKp3Z?=
 =?us-ascii?Q?JpibK3SAuKC+punKnU6A8bLWYOvjzngCGGcSGmAEGNKAYwGKnmg6GgIofjjW?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S5lsX5FwisHDIyDdTEHaYmxsst2TABrKR5UZBi9UBMyG5EF+i9jJl00LLyWxJQ8KgQWYN/Paouz+3y2wnPcmIaIBIAdcVCFYh9HMGFXLii53710uMTw3eQzeD3HjIhLzb5lz9ZwaRMg5mHVrZFfL64NjXJBESFyxw2FVrPP6jhWtbQr3zKPOHAsHB4DA9OOCGMevSAo/+a5MCv0eKZPF6BEbJvwDYXDbU9wEe2pmPk1qi/aLXLcrqBc4JuGQeQ8ftuU9qQXxREsUnkoldJyR3IOW5uKB4PLvtzEJ/Y88Fw/hb6oXVcXdBvEW+PsSOlhMbVXDLRBiwyKoSQg1tMqy7t5OrXQuWxnN3zwyzAoLgCPjR+Y1kqAJif+mTeBJsHJnQGd8pD4YGiLnKtV5d+gI8g5GTRXSKDNdkcstL49vfG6Cdlb8hHNU8ATBPBbsTdB7c/fwpKoFAeFaVM47K6k6yW37QlbHGoVj2b3P0qC+79J+9K+BUU4hOMqnP9+/9vhoWBV9P+2CCi7zocCHHcSU6PZEkIXBubSRKDhP9YG3HRsUckYpDb0YQsFrw7o9KeMzv7pJqHn9JXKjUyRXm0G2f2trUsFo/2Vh42/6XNIkXLZj/U7Jxhu+YyblUwEAP8O3YZ4aFVTEU1YYeK7ctpvDXgLBFwjblakjZdI6s6U5NWIetpiCMyiZL3U0GJ+YVSDmNeB0RxKhA6swm6eaRvQKa3txGLv7UX+9yHHtcdb9ttsnjPg2H5UXDm8Lj1T9Etd2BBMeOm5jHROxCz6MnoxlDhHomBnSb49y6jb7GeK5qFwg9URpBhy33rdNN9jQx3ebfvE51nLtmarlFJbqwx9MVeWILD+CrAgAi6sHY7s2x4Hes2nKB17/L1VZkcMjja7K
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe2e076-12ff-4c00-a3a3-08dbf7abde86
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2975.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 05:09:34.8923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fT9529/qqZbgGGi43laRrGd7/o2jARYcKMNQlFNk5jIsxv5dEn4dIZEeWNGLNIJmBMYS/pWXNTOJXhVQUOk7rRkk2fpxDdLK2QQghZ3/9t8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080038
X-Proofpoint-ORIG-GUID: Doqn6yQAvo371WcmbsYRRLRzMeZbAY3p
X-Proofpoint-GUID: Doqn6yQAvo371WcmbsYRRLRzMeZbAY3p
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

The file modules.builtin names all modules that are built into the
kernel; this is checked by modprobe to not fail when trying to load
something built-in. But for tools which want to see which object files
make up each module, we want to help them with such a mapping as it is
not easy to get this otherwise.

We do this by just extending scripts/Makefile.lib with a new variable
and define to capture all object files included in this module, store it
in a new objs= modinfo stanza, then extract it just before linking into
a new file modules.builtin.objs with a layout roughly modelled on a
makefile:

path/to/module.o: path/to/constituent.o path/to/other-constituent.o

Single-file built-in modules get a line reading

path/to/module.o:

Note that the .modinfo section is discarded at the link stage, so the
kernel is not bloated at all (see include/asm-generic/vmlinux.lds.h).

Orabug: 29891866
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---
 .gitignore                      |  2 +-
 Documentation/dontdiff          |  2 +-
 Documentation/kbuild/kbuild.rst |  5 +++++
 Makefile                        |  8 ++++++--
 include/linux/module.h          |  4 +++-
 scripts/Makefile.lib            |  5 ++++-
 scripts/Makefile.modinst        |  6 +++---
 scripts/Makefile.vmlinux_o      | 15 ++++++++++++++-
 8 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0bbae167bf93..7e3a0a1556a5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -68,7 +68,7 @@ modules.order
 /System.map
 /Module.markers
 /modules.builtin
-/modules.builtin.modinfo
+/modules.builtin.*
 /modules.nsdeps
 
 #
diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 3c399f132e2d..75b9655e5791 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -179,7 +179,7 @@ mkutf8data
 modpost
 modules-only.symvers
 modules.builtin
-modules.builtin.modinfo
+modules.builtin.*
 modules.nsdeps
 modules.order
 modversions.h*
diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index bd906407e307..15d1b61d9454 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -17,6 +17,11 @@ modules.builtin
 This file lists all modules that are built into the kernel. This is used
 by modprobe to not fail when trying to load something builtin.
 
+modules.builtin.objs
+-----------------------
+This file contains object mapping of modules that are built into the kernel
+to their corresponding object files used to build the module.
+
 modules.builtin.modinfo
 -----------------------
 This file contains modinfo from all modules that are built into the kernel.
diff --git a/Makefile b/Makefile
index cbe63ba9126e..7e48618771dd 100644
--- a/Makefile
+++ b/Makefile
@@ -1145,7 +1145,11 @@ PHONY += vmlinux_o
 vmlinux_o: vmlinux.a $(KBUILD_VMLINUX_LIBS)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_o
 
-vmlinux.o modules.builtin.modinfo modules.builtin: vmlinux_o
+MODULES_BUILTIN := modules.builtin.modinfo
+MODULES_BUILTIN += modules.builtin
+MODULES_BUILTIN += modules.builtin.objs
+
+vmlinux.o $(MODULES_BUILTIN): vmlinux_o
 	@:
 
 PHONY += vmlinux
@@ -1473,7 +1477,7 @@ endif # CONFIG_MODULES
 
 # Directories & files removed with 'make clean'
 CLEAN_FILES += vmlinux.symvers modules-only.symvers \
-	       modules.builtin modules.builtin.modinfo modules.nsdeps \
+	       modules.builtin modules.builtin.* modules.nsdeps \
 	       compile_commands.json .thinlto-cache rust/test \
 	       rust-project.json .vmlinux.objs .vmlinux.export.c
 
diff --git a/include/linux/module.h b/include/linux/module.h
index a98e188cf37b..53323e94b96e 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -180,7 +180,9 @@ extern void cleanup_module(void);
 #ifdef MODULE
 #define MODULE_FILE
 #else
-#define MODULE_FILE	MODULE_INFO(file, KBUILD_MODFILE);
+#define MODULE_FILE					                      \
+			MODULE_INFO(file, KBUILD_MODFILE);                    \
+			MODULE_INFO(objs, KBUILD_MODOBJS);
 #endif
 
 /*
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 68d0134bdbf9..40803f8faa5e 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -112,6 +112,8 @@ modname-multi = $(sort $(foreach m,$(multi-obj-ym),\
 __modname = $(or $(modname-multi),$(basetarget))
 
 modname = $(subst $(space),:,$(__modname))
+modname-objs = $($(modname)-objs) $($(modname)-y) $($(modname)-Y)
+modname-objs-prefixed = $(sort $(strip $(addprefix $(obj)/, $(modname-objs))))
 modfile = $(addprefix $(obj)/,$(__modname))
 
 # target with $(obj)/ and its suffix stripped
@@ -125,7 +127,8 @@ name-fix = $(call stringify,$(call name-fix-token,$1))
 basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
 modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname)) \
 		 -D__KBUILD_MODNAME=kmod_$(call name-fix-token,$(modname))
-modfile_flags  = -DKBUILD_MODFILE=$(call stringify,$(modfile))
+modfile_flags  = -DKBUILD_MODFILE=$(call stringify,$(modfile)) \
+                 -DKBUILD_MODOBJS=$(call stringify,$(modfile).o:$(subst $(space),|,$(modname-objs-prefixed)))
 
 _c_flags       = $(filter-out $(CFLAGS_REMOVE_$(target-stem).o), \
                      $(filter-out $(ccflags-remove-y), \
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 0afd75472679..b45586aa1de4 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -30,10 +30,10 @@ $(MODLIB)/modules.order: modules.order FORCE
 quiet_cmd_install_modorder = INSTALL $@
       cmd_install_modorder = sed 's:^\(.*\)\.o$$:kernel/\1.ko:' $< > $@
 
-# Install modules.builtin(.modinfo) even when CONFIG_MODULES is disabled.
-install-y += $(addprefix $(MODLIB)/, modules.builtin modules.builtin.modinfo)
+# Install modules.builtin(.modinfo,.objs) even when CONFIG_MODULES is disabled.
+install-y += $(addprefix $(MODLIB)/, modules.builtin modules.builtin.modinfo modules.builtin.objs)
 
-$(addprefix $(MODLIB)/, modules.builtin modules.builtin.modinfo): $(MODLIB)/%: % FORCE
+$(addprefix $(MODLIB)/, modules.builtin modules.builtin.modinfo modules.builtin.objs): $(MODLIB)/%: % FORCE
 	$(call cmd,install)
 
 endif
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 25b3b587d37c..bfb84efcef39 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 PHONY := __default
-__default: vmlinux.o modules.builtin.modinfo modules.builtin
+__default: vmlinux.o modules.builtin.modinfo modules.builtin modules.builtin.objs
 
 include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
@@ -87,6 +87,19 @@ targets += modules.builtin
 modules.builtin: modules.builtin.modinfo FORCE
 	$(call if_changed,modules_builtin)
 
+# module.builtin.objs
+# ---------------------------------------------------------------------------
+quiet_cmd_modules_builtin_objs = GEN     $@
+      cmd_modules_builtin_objs = \
+	tr '\0' '\n' < $< | \
+	sed -n 's/^[[:alnum:]:_]*\.objs=//p' | \
+	tr ' ' '\n' | uniq | sed -e 's|:|: |' -e 's:|: :g' | \
+	tr -s ' ' > $@
+
+targets += modules.builtin.objs
+modules.builtin.objs: modules.builtin.modinfo FORCE
+	$(call if_changed,modules_builtin_objs)
+
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
 
-- 
2.42.0

