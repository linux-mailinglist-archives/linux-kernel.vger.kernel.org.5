Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36AF7B09A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjI0QJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjI0QJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:09:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A10292
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:09:26 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RFtnid011846;
        Wed, 27 Sep 2023 16:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=oqBlX4M5rM78uLOs4RJ0kCjmcY3RQeZAYB9nLkDsL14=;
 b=LnrCc9QXS6HNkCO0qdfM8Q9/NuHLfGfT8DXxD6rSweX4uX+IjhoeiojDNghNduZTxfqJ
 hmdUYsj0By6AH7zLW9owcrNA6A5t0HR2uiU3LhqNfBv6OQX4st3wJh8+1sVpvMJ5atqn
 Uo0ffJAYkyDoUZPg0rJxuWZTm3rJKnPxtlnNDSELQV+wLRiFTPFWj4OGqn1jhaSX2RXG
 W30c6RlTdPoHHu2a9CdC2TE33N8lk8Ap5rI6K4OOM695v/ahE/wNualLfHEO/UCqMy7O
 JS85O/cr1LjnAOas2okQPpiD0si84nQql4/Pfv6FlN+kxyTklnhxkksjbintwKwr//vv QQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9r2dj2xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 16:09:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RF07mI003188;
        Wed, 27 Sep 2023 16:09:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf8fds4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 16:09:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFvCqk8bRpYYsWWrgmn6I/bq6idcZcEdWaQHXanjzLY6OsXGi191y0lFLX9z0tOUzxQCpPM0ndhgDxDEmXhS/0pmS25dw0ByAl/lSzW7xcp5H90GqKyMCVSPvbsvUYa0OpU6WZMXbJlsc7ek+VVXyFAm+LKoEMPc+HbXYBKjt5woxDCC2ZUGfTRscIY6uyQTlzrWCxDtCUAYSPtoONgMY7q83UmkMCuBuZ1z8/v3CMP2Yk3x2HaCOShFd7lpsxWmXuJrZSXoe4RRVPUZG8x/KFLLRcVbUT1ZOz2G+XQd9RKW2ysMwRIrD64fJL8T98wDg4a3KupFYJafZ5EZzzF4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqBlX4M5rM78uLOs4RJ0kCjmcY3RQeZAYB9nLkDsL14=;
 b=MNE70n33LsJ0hS4/lcFg4HG8kAocjxoAkdMcT3e0A4s4orU6vzftRZTuBYsGzY5PUu+7Vrw7JQVKtgOSwjejwP+li7x7H2ECwfZkDrv3XI4b1/STLVv+Fq/VBfyHavuHyV2+RH9rqDq7zLyrnsqNqrJE2Y+oZMGf6cG2jofJn123TdCszCApK8lG/iPHhQTxZ0cIjGSwDqrlQQua2qFyHI/Cae8hZ70/LWL8wVSJpxP6pQgUN8UPz94T3cyDDw2g0v9ALibe2K2T7Qe0XqHYyGPctFvPjpbe9P2rrovTpAj7HDZ2F7+/GvG//16dZ8Cd4S71Ph2ccgHPuYoOiCXBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqBlX4M5rM78uLOs4RJ0kCjmcY3RQeZAYB9nLkDsL14=;
 b=RWL3FX6D2GulVbl90FBSxrDxcK4odSlU1hMNTuEMjnhBdzONgUZmaS/7WEFVlFtk0xrNrq8egpaJejBfiAp06K5kNC0UHg/Ar5Xs+wpV6xMsLFPZPW87Wu0rfm5DaCeWdd4nd3W0e69UYEMYfO07AjudSFX71BhJcr3jMZ727RU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6122.namprd10.prod.outlook.com (2603:10b6:208:3aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 16:09:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 16:09:10 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 3/3] mmap: Add clarifying comment to vma_merge() code
Date:   Wed, 27 Sep 2023 12:07:46 -0400
Message-Id: <20230927160746.1928098-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927160746.1928098-1-Liam.Howlett@oracle.com>
References: <20230927160746.1928098-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0467.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 5907b717-65c9-4527-0bc2-08dbbf7415bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GzqrwfoIxVMHmuax0JIhDby6Udm3jXlVqAHxhoVkaWmxivXx/gN5DsNYlkfg7KHv2O5wS1zWRpSWnliL9Zt0zrcHTJqLUu4SSvyFyFMDgoLz05W8Oq/06Z6JNhXL3olGFVWdDOzHEC2kdvN4fHlUnFVgVfGxuDadflPCN3FR5K3BboPq25GhFpdosHVrfnH1Czbt0rG9eTTO+fMTZKy2B5tx9fdu7G++DSJm0uDTPf5JYNBBN/i/w/pHnh+p5fA04+pTKf4t4CHeYHkM61L6XQtYY4DL71AW+rCodmYh4E7KH0T5OlkgR15za2d4LpCohgcIo0XBKgeYoElmW+ipk2nmxxMUWUBnrYbML2IlVxkD1eAZ/3by/zQ28PsPAzSQq2WaqrJn1zzXOn4dnqYAlunTdKR0DlINUKtorDg0gCRTKzlliGBfFflel+YFQp0tYGCEicjLUAgz1bLEDU4u0ypQRvmSTlJvMelMn+2xUCXA/Q4w8TNypYQPjnbvGd8BoJo8QDjlLkYV3Ce9j5ailAhwvzEAxmyPhEop5nd437o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(1800799009)(451199024)(186009)(66946007)(66556008)(66476007)(38100700002)(6916009)(54906003)(478600001)(86362001)(2906002)(316002)(6666004)(36756003)(4744005)(5660300002)(8936002)(4326008)(26005)(966005)(2616005)(8676002)(1076003)(107886003)(41300700001)(6512007)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5PG5RNV8iCqNUqIpdtldL9RIvXKJGSVxtHrfmAAUdJUhzD4kds0LdHLU9DIZ?=
 =?us-ascii?Q?hMXyPelwTdfVPM/dqLT/hFM9TZiENkQVCDlwJ1AGrdkPNu2d3eOcts4X1S8N?=
 =?us-ascii?Q?9wzQ9QhkNmvnEupRKzjRNE5szR+nJshSIcxBPtmlOcQuWWBwfkgVBCdUa3Km?=
 =?us-ascii?Q?yfaroBdhlTWvh2qkK9U7YBz9aIu1KXqEZ0vKoHa7I4OmCfFjjsGZcJOWtHV1?=
 =?us-ascii?Q?1Jgygarh/TZ/FPTlVjQP1/Qo8JyHC0FeigbByDbjVgRwXCRWmNs/Jp4y1T1e?=
 =?us-ascii?Q?BahpuLW8hZXnBmjx2mQQ4qy+I+m/R8mdbgGI0DfNp4BUZGk/uLVaB45JmOpr?=
 =?us-ascii?Q?yO6UCunqwr8SNrvw+4P2GsUIWd6UeB61LgsRb79KOlea6hnK05czZtD4/EER?=
 =?us-ascii?Q?1TZwfQt7B2gkyOR3NKIxYhlE1JD4owq2iOBogJSweTEhHOVhPcccrZTPCq3O?=
 =?us-ascii?Q?YloPeMrkPKpMlGdimUOjqITtQe5eqNgCeZSzWpnGmdKmjTPR+0HUykqNtvET?=
 =?us-ascii?Q?N/DEaYFPqBnIy5DHQsonrnAFLLSTgu+0AEFt+43dMI6pVCppfw3zV0li4aQo?=
 =?us-ascii?Q?v5Ti8HS+LC8kpnjDULJeSdHcGXlWRA9ZsHCtMvxZjeYEen4G/hgycqIvgD3c?=
 =?us-ascii?Q?u/LlT7NuqJDc5fDAUPCAo7FfIl8zmkkmZMwqf1sARjbphGkV+xLjx3uJaMuE?=
 =?us-ascii?Q?K8iwb9zqzDI3IrZqUbzTupC0DhZTbUsUwMWy5vEOwlN/+rDaqDue2fHENPAH?=
 =?us-ascii?Q?yNqC7ROU8e5iXa0b06d9USG1Bolw6x/m5x1LBHVeEX3qkhUP+5W1KPuNDf7g?=
 =?us-ascii?Q?82YxWn2DJO+EQwLyMiU++CQxZVcxYqjsG/1KSGllexrX3DUr7jWibZC1oHvM?=
 =?us-ascii?Q?v1IOFrs8fYJedxRmHGbQVYDiakjlvIX8pXYMbvflIkjQb+S3xXDGZVElnrlr?=
 =?us-ascii?Q?qNXU5XFZaRyBEs1NNMu94o2UaaYr5DrzCrD5Hdklr+8z/fgWJ2Bb37PKiKl0?=
 =?us-ascii?Q?Ekj6I/CStxBt41rrwqmTwQ6oRvutOpVbGmH4e2jc9CR1RGeKPrs4ny/Vf1HD?=
 =?us-ascii?Q?rV5IX0JfkoRPKc1eKqp73/Tvy0Adr9QRsyV5ANdFdgDE86FcZefDIsqq9kKJ?=
 =?us-ascii?Q?OWp5ysADEAOe1WCthxdVia2XZVf4E9nQlyYo93HZnFIQTwGEgJvNoI8KoWkB?=
 =?us-ascii?Q?CuWe+N55IhEkw2KlfdleRTfa2ad33NHYtTwV8/D/HaG179Dp5kyEVwRYE3fL?=
 =?us-ascii?Q?x12iFh/qALiavqfAlXAEOWd6ycO8Bye2SNWkm2h3lKQZ6VZK9LnKuhP04ar8?=
 =?us-ascii?Q?r58UQsfCRy15/fPBibNJykEzVPc1qjtQylT/CfZAEHWXeYIq9/L8UiJBG4RV?=
 =?us-ascii?Q?NqhrfIeEaUMJ6hEFHKUOJYj3N6Bd+mlUfV5PKWysO+3jJMn+T18WFHRQCWuQ?=
 =?us-ascii?Q?iuYfinlAn+sNViBFZTreCZkoNN1mNZW8MPx5XaqoWtUWgvOyeCUlOsAEBm/7?=
 =?us-ascii?Q?58H8OGUnoNArjoGUuagrFT7BiLPBwjbmQhWyHcycujBU2Z0n+tjaiWDAwT7H?=
 =?us-ascii?Q?zUEeSSO3GgRta6+fjdWS3iBwYdXiyiSl7Ot/c5zx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PLfz7B5OKMWWBRONlFKBSOShyHEeCjeFus2BcT3m0JolHjYok/AASEsvfYvm?=
 =?us-ascii?Q?G7ZUFTS3gwns+oY1JMLN46tySEwowBMxfX5kdwvq5ogIeAxHhI0zHy2z6L32?=
 =?us-ascii?Q?ZfRGwUKLYW2iKTCSEY4CepLnoRw4JX4sISS6EZWjWacdAIYu3aaPxIlONVWC?=
 =?us-ascii?Q?/hinsil3/6c6qkFgIORdCz+/yqRd6dB8HA49FR3Mk/E4t+zw3ApgqOpL7INv?=
 =?us-ascii?Q?G5sg40TlvvS0e9Xf8Nc3PWFi0ND3zIYtSUH2NP6qhrwSi3WfjmAWmY2lp5ZC?=
 =?us-ascii?Q?zk7Dd5ik8XwBDigCmC7tgtIyX6cjqBEV0K8jtXbughAvy6aK10Vh4skLAhrv?=
 =?us-ascii?Q?K3FIlnxNuvRwpduokwHy9zRGsf/4GESs94eN5lCIgKxkS7vAHaHqQtBe5H4X?=
 =?us-ascii?Q?h2a9ErBug+l3O4M+FzsnsnFhaD1N7iIrIdjo1hQFmYPv9Bu2kWmUQbwRqwak?=
 =?us-ascii?Q?8mYeQnVHYmbKCsx0i7laLCwmL9N1UHAyUWwordUlVFJMiF9s3yYpdrU2TvPA?=
 =?us-ascii?Q?UdGJLrFyivLycCdJlIMXTrv6kLoi5CbpVqWCtqhLomNIpsT33kzmX0N+QpD4?=
 =?us-ascii?Q?QaHn4j3i/AaP8RzyVV630xhfF5noKHwOdqLuBPNm/kf1L2QhFaKM55p4kaIN?=
 =?us-ascii?Q?MA0yjBnSqDPJgCUkOEijejMORCLu8rshefTA6a/sIRZt9c03cZhaTYtM9hkh?=
 =?us-ascii?Q?oPfYViokME3a2AThfZPSY0Kp6cUa/uQ+QY9IOvifbIYzyKBkKxOZz7ORx683?=
 =?us-ascii?Q?c0KVaoiApNxQpl67WhqDa6yFcgakBsGbnJSEKZSawfz0LhXw3NgXh3Ko/kvM?=
 =?us-ascii?Q?MB8Llvp0GQm9oRpMYkvGympfW/pdWaXKPQ7tphOymNjinq/97F71lSU21a8B?=
 =?us-ascii?Q?66vlCDtFpIlaJ8Mb0NvfExxRb9OcvW+UZbqc59PFznxQ3v/u6kpCli2ZtB9M?=
 =?us-ascii?Q?+L93yzM9GYNPOQbRWFfVl3Lr1+DK75vISWB35JwjkggsUIvjKF9wkvJchKnc?=
 =?us-ascii?Q?0Rtv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5907b717-65c9-4527-0bc2-08dbbf7415bb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:09:10.5455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHSykIWf3rT2jFGjGW6Gj69G+1FIZAmXDhD6K9lRWil99ZA2nUMrjkCHb1qA27nKVpReAPhB2qs0pN/RVVKhvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_10,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270137
X-Proofpoint-GUID: 0xVaS_hhujfNjjALrxXp5q4OSLjiHGe7
X-Proofpoint-ORIG-GUID: 0xVaS_hhujfNjjALrxXp5q4OSLjiHGe7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When tracing through the code in vma_merge(), it was not completely
clear why the error return to a dup_anon_vma() call would not overwrite
a previous attempt to the same function.  This commit adds a comment
specifying why it is safe.

Suggested-by: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/linux-mm/CAG48ez3iDwFPR=Ed1BfrNuyUJPMK_=StjxhUsCkL6po1s7bONg@mail.gmail.com/
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2f0ee489db8a..3c78afb707cf 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -937,6 +937,11 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_start_write(curr);
 			remove = curr;
 			remove2 = next;
+			/*
+			 * Note that the dup_anon_vma below cannot overwrite err
+			 * since the first caller would do nothing unless next
+			 * has an anon_vma.
+			 */
 			if (!next->anon_vma)
 				err = dup_anon_vma(prev, curr, &anon_dup);
 		}
-- 
2.40.1

