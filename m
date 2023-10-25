Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA687D7308
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjJYSMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjJYSMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:12:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B7B9D;
        Wed, 25 Oct 2023 11:12:40 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PEwkb3004619;
        Wed, 25 Oct 2023 18:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=0MXSe0wr2uo00lmf9Y5A5UWAfNPAE30jdeAczyVMlyk=;
 b=uo48wAR7OfmrZym6gWqWCVyAU1+hSt7O/FmdteWuy78kbOalor+nw8LyvCRquFJ6fDOp
 /DQw6EsWDlbfQJA55GvYMoXQy7hiNcnXmAqQDm+ERB1W3+WOf43mY2buog7pRtEblwbm
 irlOgVMsar8ECFvV97B1Y1aPicOZpl7oz8YuaMaWj3wzkKDLtpTidirdvR/trOrgVyuk
 yGufxHkI1+to3O0TE/TgFsMquEDGYC7PxjY7sRyU+jc7Xy9ak/owfJYAQwYm1pb8mfF4
 zLgjfn7/dOroDf6Peo0QbIfmFKkkkOlDThOXHbIw0chSYdlCBIxwCNyWx833afdtv/3L Zg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e38e9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 18:12:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PHB4g8034608;
        Wed, 25 Oct 2023 18:12:36 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv5370s8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 18:12:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dtfoe2i3wD3FXOe0aF5AYfRq6zu5K0X2JNOrJNBnzQmHmyrFol9Er7mw64LL+v8NaOIDHexR32b7hGz17ou5mADla6SdaMMBfFKuKzD1EzTfl5iR4KmCQf0Uz1XkZ3YNb6i3oTDGl5jEs+LoC0Slxd+jCZPLJtAdI5iFImI+8zriVxGrhEHGg3W5wagyiIy1v2FSKBPMLoK+70msuGzMMxqDwBOFNGRGfXhTEvKk/74th9sNJYUt8CNh1Wu1zxCRzWguYQeMZxcMEOkk2dt8rpeQYRG42YWQEy86R9pqlDDvmwcaKr3An0yCoIa7myP/gQRp+Q9D7f68o9bJiZWZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MXSe0wr2uo00lmf9Y5A5UWAfNPAE30jdeAczyVMlyk=;
 b=jMvaohQ/YmBDBPPMF0tKxE53WYDcmEB7Y3sZNXLoglpwQMNvexSejnoYq3PjB1vivtL+nz9oiZF+Tk/KcMPKwz/C9AYCR/g+T2MLQSWgly4oPNoMtEjDmiQs9GPn9G9XSrn1RidZD1WgKUBfY7lHKFt2/P6ltsGLVYR+am88MIWklzN5irbvauaRsyW7jotN/zZlJR/8bWxdq/0aXLK/07oirVv6bKxzEPkIc/xPujMMdQg5btMslj5IGHwb3aOB/soPbgeBxETUv1eKN7NzYLvXmDRdscF2XBnyLzMq61JjGJVpLiaNtQCRMam7RwQlUq5ocSaI/Vur/uZgBegZvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MXSe0wr2uo00lmf9Y5A5UWAfNPAE30jdeAczyVMlyk=;
 b=u9/s1sc2fnxJJyNsoopDIgzE3wIztgwSjJjoZph0Anbf4KwhIe1IRzkYwvc+eQdWKbKAUp2uruw2OTaNWmmBRav3eMdnDL4uaJ1VG8TsrzaoYbj67FFepdO94sQQRByFf9mW8kwBKeKMuCC0h553uNWR157dFKbxWkiysxCjzgY=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SA2PR10MB4761.namprd10.prod.outlook.com (2603:10b6:806:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Wed, 25 Oct
 2023 18:12:34 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c0d2:a35b:46a0:d4ad]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c0d2:a35b:46a0:d4ad%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 18:12:34 +0000
Date:   Wed, 25 Oct 2023 14:12:31 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Wang Jinchao <wangjinchao@xfusion.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stone.xulei@xfusion.com
Subject: Re: [RFC/REFACT] Refactoring and significantly reducing code
 complexity
Message-ID: <x7jww3a7lebhjbwfxwabtypqzq2s752nh6xo4vpchuz2dnsefo@45aftcl4wlyx>
References: <ZRU/EjubEH/5QLlG@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRU/EjubEH/5QLlG@fedora>
X-ClientProxiedBy: MN2PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::39) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SA2PR10MB4761:EE_
X-MS-Office365-Filtering-Correlation-Id: e11e62dc-7226-4147-f6a1-08dbd585f638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qX01tnbspXkV1Y73BGi9kPeYcgytc+xhPYxlDgKt6yXl5Rrf10hOPaDRQ5WQ7xSYRxek7xOLnviJKzfTFkzwC1mBwaE0fszDKBfH/j/ddJv66fLc+EkLtmeOQhB+21xzWV9B6Fyc8ZLG8I3Wn7pwC1VfZAQ1doCw8NNAtsH7p6b3hoEEZiXPtga7/Ox89eOK+7EvJZW2A9vSO7Vlr42j9jJHMWiIn45oN+MUHZ3dTqWApoYwPWLvP0VB3RHHpFeQpPYjYxCnsNXVAH4VE/LtSliWngNy83JjCOojqNPwbr6eMSUaOrpqOFyBCDG7jVRDg6RBirGHVJU/ZTfJPoB0gX09Fvo6td/DOGtRZ/KAqWeucrtl3AYTqcaE5N1F/0sAByqebNPF09XHYhB8cDPamekPLWsZ5lqv2fb5tr+1V4USUjYztt9GocYCB5l6Y7NL8Lc2/V3nHsqf27xNgooVNMUUpSWZ9O17yVtNVWoaRY2LN7M8isjKftaBSIxfx95RI7G0SIq7fvluyYzqsVu+zHb/n2PLQgRXiry1TELpRa9Jlc2MpE74Kg3hUIKPn5WT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(9686003)(316002)(83380400001)(26005)(6512007)(6486002)(86362001)(66476007)(6666004)(33716001)(6506007)(478600001)(45080400002)(66556008)(5660300002)(8676002)(8936002)(66946007)(41300700001)(38100700002)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d4pW/KfnPH8o08Om2OFGJUDqIpSXmDKLyr1o/UsEou085KefOUHR2Gg6j7V5?=
 =?us-ascii?Q?ut1fuEXWzBugkIw0ZCOlHWRv232IXUV5OiLnFJdvF0xib/RM7xtk52LB7wOg?=
 =?us-ascii?Q?k09Hygv+I+FgXNS70+XgHsCIEL2feGMZ+q+dZRPzUrX1LqB8QlO8q9N6fSai?=
 =?us-ascii?Q?YtaGCU3OpGM3hCGrad0hqtqL7aMhv15lnn2ZUHcN15TQue5Xz01LV3SysZ6X?=
 =?us-ascii?Q?asnQPWs6x26UY5/u/U/Z8KzcQrrjk4Z6AY0knyrELYti19Qkb4CfMAHB8ZK9?=
 =?us-ascii?Q?Jz2EVGXai41xYQpTacIXfVo5Zs0gL4vVAj1f/QAQVh6pJRAmv+gUPsfKwG7s?=
 =?us-ascii?Q?jXNVPkfpt3O8Yl2JJajHkplVZhvAXTxAvHr76k5C5Dsowvo+BbOKZ0hSsbVi?=
 =?us-ascii?Q?l8nu25fm0n9iKdAPfeDYK4LYeeaovXA5uq0nZyz1jr9IdCcgYmhLAvqiu2KL?=
 =?us-ascii?Q?c7HwWrjovsTnfu9JMKAj/cc/jhCyMLL+oTBgzWI5pHC8w+Bw73TJF+hLjy7/?=
 =?us-ascii?Q?8ZfLEe9HLacscFZWEnW/GOA+4/SZlCkOV8i9r/on23WGfndK4zbpqEdLuUDn?=
 =?us-ascii?Q?w2UYzTnegHpX2yk70IZqoWypjTZpA9gsv8S3uJx3+pw1CyLBuelfB/lvgmAn?=
 =?us-ascii?Q?pWJkyU5Aj1wDQFfAsnD7lmljT0x6GhCe1iglkcRH8O8e00C4QpvoCvNbv5pw?=
 =?us-ascii?Q?otNKI+hUUrmMKZ8d4vigkR09A78zo0nuCDS7nytmfoqbICtUZv5IJ54511/C?=
 =?us-ascii?Q?k4azaoA/4KeHaGfwqudJsdkzZv92gZE2ZxHSeW8wSZQBYbYTM7cPIxOgOYLy?=
 =?us-ascii?Q?+ZmgRJTXqFIt7dXl67x8gxHgOtWokpdWXSQjYU7FYukBBof+iHhPyM6jJLj/?=
 =?us-ascii?Q?pkovF9+7Suz8yXAM+p+2oMG9feo7kkycBdUOshHwktAZwUT9GUMID50wg2H1?=
 =?us-ascii?Q?OBeqpliJdAnrB6OBAa23OC5IHGeZiJB5anuldHhg/ADCLclLMA1VX6w1cR5t?=
 =?us-ascii?Q?AoxEK5awcLnqmKTdLwjNqNs9zUKqbgMKZxwFBqk4KH/k5DwUwVqqkO1awsQG?=
 =?us-ascii?Q?HJF/TNNjTXz58o/13OBln3KqRo95eoHhXB+ED1GNzwjjdgpMGZEbS50yInGZ?=
 =?us-ascii?Q?oHUpHZwDMUqLrrAtHp4EQWQHwrVQXGwKvfz1UjohO0kSX0VxhQ/hwRyuSysC?=
 =?us-ascii?Q?iKU8yc0V4X0YVctHPaUOMfHehmBieD3y8LtagchtpMgx8vFmWSrCRsPqZZnz?=
 =?us-ascii?Q?zqNnzo6qet89zPSnIqvv0HsWM29NfK2JqRl+eEvGfLqi+we9tUsZZZtnXUUq?=
 =?us-ascii?Q?Jiapf5Mp0JT3ZtMo+NkBSV5AANJ7IXNe1NmnVyX9jH/GdNhdYV71D3WxSsTA?=
 =?us-ascii?Q?PndqMM4Ti92r/IZRxqnB7i33Gd2+Y81WD5jpW/6pbNhb9pRDNR2aiU1X+ZhP?=
 =?us-ascii?Q?+ZkM6JYV1BYrgQIRthhZ8b2SOJiW9WBXVDeUECRUAhQZxXyNFo7sGOQN2phv?=
 =?us-ascii?Q?vEs1E3fIQn6VYMK8zpVncZuHPavbTXpCCaaYj183qd6EqNObZLlBoxsk2ow3?=
 =?us-ascii?Q?H6mfyhl+fgxIhRZuKlynsLA6vLf9zy1b3+iLsNjrEtyX4KhyhDU+VOqYH1sj?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S4MsqYW0p/lLKlo+sYVZZV0jE91gITgWyElQ6g7I6JlcLYNgtPT/SAxQkC5cYQhI5swmvqjwiSV++UrfxJmpivurw08p4PqKBXeWrgRZY6xb91LP9gxUejWTvVtq2zBFGVxXWx1JKOFb0n8J0anXGOhtA7Sd6uBHfkOEZCsutQS9phNIegYEhE7d2yFN0VqfWjpC4dM0C0fjzNuPOjBJXLeqrK+81ut10WkT1qLMxNAdGNsvmuaDCN4ciWB+dXdUHSncB/qSdhlxd1L5rmMUsx0RkLPsfZFQPmvaq7aUPa8CVakEjB+U19F2Olsyavet1V9w78o0MHKbZzPiRUFR8RFfDZ41D9XNwE4aLPsxgCpdu6pHGFlscZ2xV4QbYHpCWmBA5qw2VO5Gf2UK6s1048EuaWr0U2+NjODBLGpdtrVc32BuZ/kobxn4yURzYQYdAmUDmcdzKG2j31An0gL3GTj6wrS47QcTtzEdIAtCNwzfOubKiC4TA31xhFeVVQnjq6UvxuF7taft2Ya4cerBfA4knV3WFINze2+hBeXsszfJW56t2cDQy8QV6cZT3r1Xp9DZhH7D9anSBohBZKzpwKMdHXs5341yREO9HegVNVZzgr80mKqxILgUY/2s9oC4L9Igva5KLfY3vEwJEfvJVJXu+XHfZKeTuo+JWxGsjIJ69DSElvSSsXGvrldIisMe/4BrhCHnRcH07/t8Fxf0E7LGVFZyqKdERV0+nln1UxUOASfZV7t9mnXPRp5IxWLLIvuIaEiTmNDoPyn0AynWonCTljnBPTPSj4ZZv2CWaDmq+J+gHmj8uxfLPgXn6cZTGrmWEIsC+dqhnp0jSKXZ2g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11e62dc-7226-4147-f6a1-08dbd585f638
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 18:12:34.3166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4832WmxmEqwnU5IkYcqfmmOcCq/EXbp28+SjHthqiB3+EVR0li0c/VI6HLJ2ki5S8AmxTHxwvX7HJbsgF2RF10YtQDUPApnTvrZVJqOrLNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_07,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=995 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250158
X-Proofpoint-GUID: FdYLLPnSyKeaz9D6DnoJAkRTfABm9MM-
X-Proofpoint-ORIG-GUID: FdYLLPnSyKeaz9D6DnoJAkRTfABm9MM-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 04:53:38PM +0800, Wang Jinchao wrote:
> -/**
> - * struct parallel_data - Internal control structure, covers everything
> - * that depends on the cpumask in use.
> - *
> - * @ps: padata_shell object.
> - * @reorder_list: percpu reorder lists
> - * @squeue: percpu padata queues used for serialuzation.
> - * @refcnt: Number of objects holding a reference on this parallel_data.
> - * @seq_nr: Sequence number of the parallelized data object.
> - * @processed: Number of already processed objects.
> - * @cpu: Next CPU to be processed.
> - * @cpumask: The cpumasks in use for parallel and serial workers.
> - * @reorder_work: work struct for reordering.
> - * @lock: Reorder lock.
> - */
> -struct parallel_data {
> -	struct padata_shell		*ps;
> -	struct padata_list		__percpu *reorder_list;
> -	struct padata_serial_queue	__percpu *squeue;
> -	refcount_t			refcnt;
> -	unsigned int			seq_nr;
> -	unsigned int			processed;
> -	int				cpu;
> -	struct padata_cpumask		cpumask;
> -	struct work_struct		reorder_work;
> -	spinlock_t                      ____cacheline_aligned lock;
> -};

reorder_list used to serialize one sequence of objects per padata_shell,
but now serial_wq serializes all sequences of objects in one list of
work_structs.  That works in theory, since a total order can maintain
each sequence's order, but it's possible (not sure yet, need to think
more) that this could lead to deadlocks or other issues in odd cases
such as the one that padata_shell was introduced for in bbefa1dd6a6d
("crypto: pcrypt - Avoid deadlock by using per-instance padata queues").

The reproducer in that commit produces this splat when testing the RFC.
Not sure if it's related to the above though.

[   40.084146] alg: aead: pcrypt(pcrypt(rfc4106-gcm-aesni)) encryption test failed (wrong result) on test vector 1, cfg="in-place (one sglist)"
[   40.087192] alg: self-tests for rfc4106(gcm(aes)) using pcrypt(pcrypt(rfc4106-gcm-aesni)) failed (rc=-22)
[   40.087195] ------------[ cut here ]------------
[   40.090296] alg: self-tests for rfc4106(gcm(aes)) using pcrypt(pcrypt(rfc4106-gcm-aesni)) failed (rc=-22)
[   40.090313] WARNING: CPU: 4 PID: 321 at crypto/testmgr.c:5936 alg_test+0x404/0x510
[   40.094020] Modules linked in: pcrypt
[   40.094882] CPU: 4 PID: 321 Comm: cryptomgr_test Not tainted 6.6.0-rc6-padata-refact-rfc-v1-test+ #3
[   40.096856] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.2-2-2 04/01/2014
[   40.098838] RIP: 0010:alg_test+0x404/0x510
[   40.099664] Code: e9 4a fd ff ff c6 44 24 17 01 41 bd ff ff ff ff e9 d1 fc ff ff 44 89 e9 48 89 da 4c 89 e6 48 c7 c7 a0 59 1d 82 e8 1c 45 c4 ff <0f> 0b e9 aa fe ff ff 0f 0b 48 c7 c7 80 58 1d 82 e8 e7 c6 cc ff e9
[   40.103180] RSP: 0018:ffffc90000343e10 EFLAGS: 00010286
[   40.104322] RAX: 0000000000000000 RBX: ffff88800421cc00 RCX: 0000000000000000
[   40.105875] RDX: 0000000000000002 RSI: ffffc90000343cc0 RDI: 00000000ffffffff
[   40.107467] RBP: 0000000000000883 R08: 00000000ffffdfff R09: 0000000000000001
[   40.109249] R10: 00000000ffffdfff R11: ffffffff824722a0 R12: ffff88800421cc80
[   40.110862] R13: 00000000ffffffea R14: 00000000ffffffff R15: 0000000000000000
[   40.112354] FS:  0000000000000000(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[   40.114132] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   40.115130] CR2: 00007f1808faba38 CR3: 000000000243e002 CR4: 0000000000170ea0
[   40.115959] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   40.116630] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   40.117261] Call Trace:
[   40.117559]  <TASK>
[   40.117811]  ? __warn+0x7d/0x140
[   40.118165]  ? alg_test+0x404/0x510
[   40.118452]  ? report_bug+0x18d/0x1c0
[   40.118743]  ? handle_bug+0x3a/0x70
[   40.118998]  ? exc_invalid_op+0x13/0x60
[   40.119265]  ? asm_exc_invalid_op+0x16/0x20
[   40.119597]  ? alg_test+0x404/0x510
[   40.119918]  ? _raw_spin_unlock_irqrestore+0x1b/0x40
[   40.120390]  ? try_to_wake_up+0x9a/0x6a0
[   40.120749]  ? preempt_count_add+0x6a/0xa0
[   40.121121]  ? __pfx_cryptomgr_test+0x10/0x10
[   40.121494]  cryptomgr_test+0x20/0x40
[   40.121751]  kthread+0x100/0x130
[   40.121979]  ? __pfx_kthread+0x10/0x10
[   40.122247]  ret_from_fork+0x30/0x50
[   40.122511]  ? __pfx_kthread+0x10/0x10
[   40.122775]  ret_from_fork_asm+0x1b/0x30
[   40.123050]  </TASK>
[   40.123207] ---[ end trace 0000000000000000 ]---
