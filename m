Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C2E7BAF56
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjJEXeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjJEXdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:33:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A273197
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:32:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395IQCF0014524;
        Thu, 5 Oct 2023 23:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CTdscpmRC90xh6rkofX2WcaeUCscmlK4KCHrM0n5XJw=;
 b=TdrHasCRIj7e093yGWJyNCGOKIhNT4Hy5nWNg8acup526R0cWaH4V09WVb7Q54b3w6X6
 LTlLA3kutu3PwALAz6XkKu/MLP3MxqKsehmAQPvpFmCbL6Bapb4qgRdNgGQvu1lQSIIg
 olebcaR9THsxAELW/RLOkq1lt9TpQh0jzGhLQOAofX+wRZCLm3jFPKzomG45m0HBXKFr
 YANmIQ08RgLkUHMzcytSLCek1MOq6G5pijZROC0mDkOdFaLiMYvHXbHCrtNIpwcROXJ0
 adWaQOgAUz4kxfqHBUS3nHkntO/qROO7e6vzX5KyX0O8zkgY0KSTR32adnF/zIRnQ3Vv Tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea92asnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 23:32:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 395N483p005786;
        Thu, 5 Oct 2023 23:32:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49uhq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 23:32:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3DllXdy4ib531iOGOD426oum0UeNd45EmGe71oaImJayy3vwxUPomKJfds+uMCTAeS5VOAgFFxb8PwwuDHq6BPgcWK4JpDmfBpFrQ0T7zRovcQcF9o2LVLRZuNlOUv7JRYC78T/JumbPETOdOEO3zPZ/nkMAarN423gS7BA38J254/s6eFE2GAD76nV5Wfp+H/DG6B7NQruNyX6FwWNAYHavucKwyeGk/54AUwxk/Z3bFtUECSFjdTLz1ESAHsHzaye5Sn/1VQo+GcGPPATvodzOiERH6Jwii4qoZQR0DCsfaYF675qgVBnPpnx/17MvKmgn4Z7Bb2OFwwoGa04fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTdscpmRC90xh6rkofX2WcaeUCscmlK4KCHrM0n5XJw=;
 b=h0MzMl7ug7e7+F/P9x3WsMTz7nIAoYSDRSqaGXneteMgJtZpNH+kXiVFUYHAH9iQSi7Ea7RTqmxab1iajJJtl+/sgNJmGU6TZYPJ4u2t+ePBUsXOiuJ6edElG2o238mEMjkbLtJZx7tvnReBPU/J36+TIhLHAX7Tt2h6zimKHhJHRpExxQhsKajmeXOg4Udal7T0zmsPt4NUIDGHZNvOxKyB+7QgZepVwXaDGv4TJUIGe85S8ozSbUyv0lMjnljwD+fluNFfQsx74dbuhpZAOFrOlzodv0/uaXqAmy9f7HVQY0Ha0hxhROP1ZyrfiynCgTKNhh+aTUjXTA1gD/Ulnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTdscpmRC90xh6rkofX2WcaeUCscmlK4KCHrM0n5XJw=;
 b=UaphyvNOf+WB1bEElWpNPVpDCGlgrZdEo8y3+v0LvPv6+cqIELUea3aAtEYHuX3vM8JNPhxRutnlSZ+oFuIXgdf9QicOtQpE1qdewARfsqnSDs62EnkFkA6Jb36Ae5m143BUeHtW5NGCRXY/Qrh+oiHCDG0lHm5gppgyDsUna9M=
Received: from SJ0PR10MB4479.namprd10.prod.outlook.com (2603:10b6:a03:2af::22)
 by SJ0PR10MB4768.namprd10.prod.outlook.com (2603:10b6:a03:2d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.42; Thu, 5 Oct
 2023 23:32:14 +0000
Received: from SJ0PR10MB4479.namprd10.prod.outlook.com
 ([fe80::203b:a78e:dd34:6571]) by SJ0PR10MB4479.namprd10.prod.outlook.com
 ([fe80::203b:a78e:dd34:6571%3]) with mapi id 15.20.6838.028; Thu, 5 Oct 2023
 23:32:13 +0000
Message-ID: <c87d7939-a88c-ad2d-82f2-866e04692882@oracle.com>
Date:   Fri, 6 Oct 2023 10:32:07 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH smp,csd] Throw an error if a CSD lock is stuck for too
 long
To:     paulmck@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Leonardo Bras <leobras@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bc7cc8b0-f587-4451-8bcd-0daae627bcc7@paulmck-laptop>
Content-Language: en-US
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <bc7cc8b0-f587-4451-8bcd-0daae627bcc7@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0009.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::22) To SJ0PR10MB4479.namprd10.prod.outlook.com
 (2603:10b6:a03:2af::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4479:EE_|SJ0PR10MB4768:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9c5d1a-d3ea-47e8-4020-08dbc5fb4d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tdrI3ezG6ovu1l6gSbr0TLA9g3eRlzwxswTGHra38SHs2JZRyXIYkTAPdFs9rRkohq5mwPfqBdD5VYwKRpdSPhisq0t6bhjcZun4zidsFibp2OY5r+4ijCjj4xmoTr8EthLZPzMABqG4qGsnRYGP1Ls4EKb4+2K4gR23l/09zZv0faBmBC+NQRRUZU8ta+CWFTj0OJNaW8mP3HXSiQkaP9SKa8vUvNfeodzlnUVeHcYgPr2jHWEpomfWYVffaRIc7gKuLL75w0V/knwZ+S7BTx/kkM7dHLSLPLEPoe/MLK4VyrKTd+ksBi45cVP1oLgqUlipCApyc8w1/85x9vXSmz/aRt8o+UtiV17ADP8UC+aqYKsLr9CSxxszfRKMSg3uE8q/XRhjP9T7yp7TW6Fz6kkU2CnyrMKSaWsHiEXs8ejMmFWoYH5S0a2zUPYzO7W5M5q4Vz3ehpdCSPeury7tRiPyx2v+Y5+UIfmj114OUFkEVKxJqzGOdArH/8C6ZHclr+zlP7Ov1qmLowsdIZUuat4/LPPLr7MxQ7+Nrsuse/NsCc+XCpdgCq3SJSORRmvrNb+9Wyqqf/1gmkCyTakQvKcgeNw+ZogLKj8ZMPZHG53CVRen3uXg2v3eMvq8f0UgIz8PimsfC3mQ2u/sW6Onfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4479.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(5660300002)(8676002)(8936002)(4326008)(6512007)(31686004)(6486002)(2616005)(83380400001)(53546011)(26005)(6506007)(478600001)(66476007)(38100700002)(6666004)(86362001)(31696002)(41300700001)(66946007)(6916009)(316002)(66556008)(54906003)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ry9kbjdXbFZpVkhmaUFtaktnRmdEeUlQRzlhSFp5WEJ5cFlqM3JWSmxYZkJm?=
 =?utf-8?B?SDgxSXQ1c3BzcEI5M2NvQlpjZEdPY3pLNTRsK1c0QzJ5bDVjUmVHaUZscDlz?=
 =?utf-8?B?YkswMU1kT1UyT3ozN2R6ZXdDaFMzamd4ZDZlSEZON0pDRy8xWW8rZ01nVFFB?=
 =?utf-8?B?YnZhRGFya3RwN3ZreWIxZjIyMnd6TlV0ZjBVY24zNEU3ekhTRCtVUWVTKzNz?=
 =?utf-8?B?MS9taTYxMGxpeEJYQUpkbjRHR01XbXRPOHNYZmJlelM2TlpvamVKbGVVa3dv?=
 =?utf-8?B?QjhuR3g0dXBuTTJYUUpwZmQ3S3p4SE1WYmpkM2p2dXp2ekx6cEowZkZyTXBP?=
 =?utf-8?B?akd1RUtjTUNkc3Jpb1IvV1pBOXh4YzdJV0w5VG5xOGp4bFBvQnJMR0hBem1R?=
 =?utf-8?B?RENadHBmN3ZPcHZIaVZlT2NPK3ZxQXllc0pJK0FwKzJJMGkvbEJnSW5EYkNH?=
 =?utf-8?B?TXd5bERESlhtZFBYM3ArUFQzaCtkWjFQK1hFYno4bkVITDMxT3RUNG8xWnFV?=
 =?utf-8?B?bDhmTDFjdXVWRVowWk4yYjE2T3NvNThhMUlDZDZPdUdkZmMvQmJtc1VQU0Zo?=
 =?utf-8?B?QzVaanhteU5wOWlVYmxSaEtVVWNuTDN6TmVibXhVbW8wY3VGWUlxV2NKZ3lq?=
 =?utf-8?B?cE1WNkZpQVZ2Um9BcGhjdlBIbmZPU0wwUDFlVkoyUUdzN1ZhMVZlYlRrSlpQ?=
 =?utf-8?B?WlNqMXowaGRsSjNEMDdmcHprcjhlb0lNMW1GbWtLM0prOGFXMUozSTRONENn?=
 =?utf-8?B?YWg2SU9pWG52MUdOTStZeHQrSUxXeTFNQ1BvZ0tyelpqSG9jL0JxZ0xoWFFk?=
 =?utf-8?B?b2I4Qm5USUN2SFBjYWJ3SW5VMmZNUnA1cW1meDF5SFljQngyb09TOEYrbjBZ?=
 =?utf-8?B?TUlqenBlNFRpcko1bEdBSzdoQ3NkNzkyenlBYVFzaThxcTc0UytKWmFmRFBY?=
 =?utf-8?B?YVF3OFpDeFdKbWx1akFuNkJEa1BKWlYvV0xLQzJZbURQc3I0S2dYN1huQy9r?=
 =?utf-8?B?YWJEa29FVmZKVUYrUjdKeWVxYjdmRTNLS2RqZUxoM2NhczFNRGdkZnZkcHRY?=
 =?utf-8?B?WHNUY3c3cjlvYlNJSE1pOGFienZGR0RRbkNBdDBZVFA0TlhlWkFsRXNmdVl0?=
 =?utf-8?B?NVpYVVQvVXNNaXJPMDZyb0tISCsyZnE5MGhoUmRwR0tvcGpGVkhRd09kSCtE?=
 =?utf-8?B?ZVJoMmxycllibnlrekVLbFlLdG45ZU1teWgxcGVYUzdNTXlkclZkUE1TUnp4?=
 =?utf-8?B?VXBpeldEVExCdTJXR2R6Q3NDTGdBUDZHU2ZMajFCWFlaUEdzajVyek02azY3?=
 =?utf-8?B?RlBCWFZnbUVPdEU4cmN4aHJiaEZCUERJR3lKSjFKRFVWN3NjbThFSEtJa2pM?=
 =?utf-8?B?cmFRK21pMFVYdzFmbXNyay9BbXR5UUhLdEtmdVlQQ3NtQ29tRm1YbnZBN3R4?=
 =?utf-8?B?azRjQk4xT3JIRlFHUUxRN2pYTXlMMzNlSHI4ZjQ3c1ZwTnlsSGIxNEUvREtN?=
 =?utf-8?B?Y3BBVnNmQlRHcm9zOHRNaDBQTUFSclA5QkZhSWxOSERWOWdqd1JJVzl6MUF5?=
 =?utf-8?B?SUxIUXBCQ1NOYlNSeUNsSjdNQ214Y2RadTYxTXlBcEcyQjBvUS9DNG5Gczhl?=
 =?utf-8?B?Q3V5d3MyNFJHUTd2UGdOZTBiMWpQNmZrMkQ3NU1DZWJYeVdNczk1UTN5V2N6?=
 =?utf-8?B?MlZjQW1FdmxEY214bWcyaURkQi8vemdLelZzdHVHMk4vakp1eVNJUXV6VFNQ?=
 =?utf-8?B?V3BENUZUQTVmaXFiTFF3NFFtcFIzbktkNndsZFM3YUFKWWpVczFBd2hLSzM3?=
 =?utf-8?B?OEhkbjdJQWZnblc1WkxYWE4xT29MNE8ycmJqZ3hYWE5IM2RvMkllOW1qMkNM?=
 =?utf-8?B?aFg2em95dHgvRkdUbTlZcVpJNWFUNjhDWDB0Um9VTzNoNGpMdmdRbDR6Y3RO?=
 =?utf-8?B?YW4ralFGZ1E0OVVrRzd4QkxaczZOTlJoaEwwZmRTS2p3TVBVNVQ4ZmN5cWpN?=
 =?utf-8?B?cjMzbzQ2azlBeDg0Ukw0K2ROSFkxK00ybFdET1EvdDNCWUV1YStxWXhwdGM4?=
 =?utf-8?B?SFVVN2FheGY2dXdGYzQ5UnNUZmZQRDJsSmpSREZRWlVwRndJNlVwU09RQWx0?=
 =?utf-8?Q?qnTDGQHW1cXmjM5xsEshoQzRx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: idjSE9b7ig+h3MSVPGw1+NC4iW7a+0m0p85lpQ7iyUnKnNJQMvo5tvm4WNwUYdOGO1TmmRMcDJcLu4D1EE2fA3AsG6aqiisp77GpolUeOtfE2KRGXbURU6S6P7hD3q/prG5ocabspCa0YoGxkICF8PtprCOfHvJ+835UBFwJ8Gl7J19HZ9K6ZBxhNECwzVW6iN6C5ibtO0jih3ymp53LDlJdSdKYTQfhrbRnfcNbYa5H/om4f1wsHQL8KIJQ7kgDHOUMS5w1rR/5zsOVqRJpBTGhpYgd87VUwwFwVr2lRBm4Pz+77EWy3lWc7OXP0jtNF1O57pk6TqzX7HEif4sydCdwyvKmMl64S8vBXoiHRbEGpRVzSuKkDrIMieHBAN4bdiRMs9B/BMa5wMTjS59crIeCvVL1Zm0eb8AOZBfRSrM0pRMLYc3GLzWS28/V+DMDJsnGKNI5wag1AHGIEk0ddAL57Fca2yCqsruxL1bOsXrCTqHrdXebLHNcHDxnZFj7Sm9gndivXuvOBQZBNMLQ1Vm41QTprfRmKwr5H5D6eszDEk7bIsyRWQu7VrihCAGFCzodoAeVmNgj9+h2TvRzFAU/ieOl9zH6x5SZT75f1C3D1CMPnyfLe1P5ynBiqd/UwfZnXN+oWxHnPOTTN1EZIm5we4ykQef6vQnZswNHrvLdbBITzo+PFiKTwCUzsrNxbnU3+ym/nsVCNiRYR+ZwsCLc4sYo/l5ZLk6SROBAdkHnK8wFG7Ih47yhZ2ruP9+/4nMdAAdOxxTeqHnpmUulCGQSZczdbFY2KeNcbuJheSJVYRwIG5DCOUHE5Shk9WLjevb9CT4SQQtG79l56lQGvQOmFiVG7Svm7P8gLORCDbO81CEAHYTlzDsbpghG2M3W
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9c5d1a-d3ea-47e8-4020-08dbc5fb4d70
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4479.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 23:32:13.1124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSu+xedySEjZLHiOaLolDHHDFAAKF7++MbVJGaYyWl23p/HVL+s+pANao5RKpvdcW6ldRgZLE3hCJCKMtx/cSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_18,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050179
X-Proofpoint-GUID: bWfZIAJcB5WRje3KsoONo35GSm4U-1T5
X-Proofpoint-ORIG-GUID: bWfZIAJcB5WRje3KsoONo35GSm4U-1T5
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

On 6/10/2023 3:48 am, Paul E. McKenney wrote:
> The CSD lock seems to get stuck in 2 "modes". When it gets stuck
> temporarily, it usually gets released in a few seconds, and sometimes
> up to one or two minutes.
> 
> If the CSD lock stays stuck for more than several minutes, it never
> seems to get unstuck, and gradually more and more things in the system
> end up also getting stuck.
> 
> In the latter case, we should just give up, so the system can dump out
> a little more information about what went wrong, and, with panic_on_oops
> and a kdump kernel loaded, dump a whole bunch more information about
> what might have gone wrong.
> 
> Question: should this have its own panic_on_ipistall switch in
> /proc/sys/kernel, or maybe piggyback on panic_on_oops in a different
> way than via BUG_ON?
> 
panic_on_ipistall (set to 1 by default) looks better option to me. For systems
where such delay is acceptable and system can eventually get back to sane state,
this option (set to 0 after boot) would prevent crashing the system for
apparently benign CSD hangs of long duration.

> Signed-off-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 8455a53465af..059f1f53fc6b 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -230,6 +230,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
>  	}
>  
>  	ts2 = sched_clock();
> +	/* How long since we last checked for a stuck CSD lock.*/
>  	ts_delta = ts2 - *ts1;
>  	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
>  		return false;
> @@ -243,9 +244,17 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
>  	else
>  		cpux = cpu;
>  	cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */
> +	/* How long since this CSD lock was stuck. */
> +	ts_delta = ts2 - ts0;
>  	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps).\n",
> -		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts2 - ts0,
> +		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts_delta,
>  		 cpu, csd->func, csd->info);
> +	/*
> +	 * If the CSD lock is still stuck after 5 minutes, it is unlikely
> +	 * to become unstuck. Use a signed comparison to avoid triggering
> +	 * on underflows when the TSC is out of sync between sockets.
> +	 */
> +	BUG_ON((s64)ts_delta > 300000000000LL);
Can we make this a module_param (default value 5 mins), so that if needed it can
be tweaked to a bigger/smaller value?
>  	if (cpu_cur_csd && csd != cpu_cur_csd) {
>  		pr_alert("\tcsd: CSD lock (#%d) handling prior %pS(%ps) request.\n",
>  			 *bug_id, READ_ONCE(per_cpu(cur_csd_func, cpux)),

Thanks,
Imran
