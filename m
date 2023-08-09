Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE6D776BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjHIWEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjHIWEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:04:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFECA3;
        Wed,  9 Aug 2023 15:04:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379IiTQL012717;
        Wed, 9 Aug 2023 22:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=hD6/uulQTPJKkn8TRnYvQADwFGzyJ+yE4+mo35JTcfs=;
 b=OeZ6/agwrt0vVsUiZxYpDWgKlUtthl5QXGF/i96ff5K51rBENVUbI2M+PoH6l1tjOPOM
 nJ292ITrrCayZ5hn2bnjo1tmtUWTPFKgRGh3/tfgQ0ozMoqHzZ9EUOVIiCzmM2LoQt8X
 3wxMYH15AlO1htddrIhJZ8ETSWLwWO9S9v1kXMks363SBIQ+nDBsXvQ0Zw0jkl1rNOl1
 TTtpsPEqdYElza6fNZMmbWLexUzXcXn/0hyx7KUK2zk9Ka2MOYDykh6eUQufyT5xzDOD
 MQ4BEGc3JXedNiq6Z38iAyqctiZtH2/bvZLNr4ZvRbVnk2iXLKi7aynOdyWLbZ3uDVv3 Rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9d12hwk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 22:04:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 379LDTbZ017575;
        Wed, 9 Aug 2023 22:04:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv85mde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 22:04:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAj1SrEFa8BGQYiYydm50wa1Eqqi21p2B33WfZMLC2UCKulPAFP132DZTrDeXDCyP/YDD6pALIWKzQBgVUS21mKal7d+R3BOYazP/jtJEOqmAoJn351eX0j758HesOO6CO/XqVrJxx14cUaTL0kYTtxkUn3Kk36MDuEYwD8NqzfyNsyEDnojBq4wDT+nnBWi6T1DYWZjVNkXMWUQghm0nUHqbbu/xP4GFYsaboLizxQwde+Hp3XOatnc5qzOHSkwYXdwXUluqNoC2a8H4O05uclOOrC3Un/MxDYVc5NniL3+zUVxx3I8rJ5eKKxGmjAE3tI+i6qfXi7q+4SQXRFYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD6/uulQTPJKkn8TRnYvQADwFGzyJ+yE4+mo35JTcfs=;
 b=alJh4TNPsPaHjd7fVihE4HFlY56bA5sJlKdsdARpOvWtoGa7kWG/xgJugYvVMnZKTY7KajMjblSH6F7+x/YV4SM+UzZqKTjU4TrDCcYYnGaFramdnUAHqmW4FVI9+z9xxqU/EpgWyjhs7iCrZSSkaQEb+6UGDw6TqZfWOLI5lfBt9KxaEM37sZb1li4Rh5ZePIGZ5m1MuxYE9NRmw+ykosV+60Fc9q4PvYyevz9v5G8vrry3VsFZWIh9bTzVVBR+Hr/TF6vKGyn2pzVUvYe9xYPYVEJUdL6g8jtvCBXFFjSuEFQLYYo3lHP++mRDxMregGjRK/nqO9NT+opd1SxLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD6/uulQTPJKkn8TRnYvQADwFGzyJ+yE4+mo35JTcfs=;
 b=q1jip+vMHUufa58ORxxMZNuSgNKN6uMCISnucT4UO6hJ2yPVodJHDz4g2KSLUB+NPkWqlKLcKg45p22ExBHzjjrxhp1nnZVJeLB2UDTCbN30asJnjXqtiz9tjGrUFa/dKNcQn6TIgGu9dBRnXh64Y4ML1TRqt2TaTfoVCjhJEdM=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by CO6PR10MB5789.namprd10.prod.outlook.com (2603:10b6:303:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Wed, 9 Aug
 2023 22:04:10 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536%7]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 22:04:10 +0000
To:     Jinyoung Choi <j-young.choi@samsung.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] multi-page bvec configuration for integrity payload
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1ijho3e.fsf@ca-mkp.ca.oracle.com>
References: <CGME20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p4>
        <20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p4>
        <yq1zg31hubf.fsf@ca-mkp.ca.oracle.com>
Date:   Wed, 09 Aug 2023 18:04:07 -0400
In-Reply-To: <yq1zg31hubf.fsf@ca-mkp.ca.oracle.com> (Martin K. Petersen's
        message of "Tue, 08 Aug 2023 21:36:41 -0400")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR06CA0075.namprd06.prod.outlook.com
 (2603:10b6:5:336::8) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|CO6PR10MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 02cb1efe-4d9d-45d7-7252-08db99248ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/8pvW+qOjxmIzo40Y9ZcXl5hw0Ebs49dZryNY9Yy9WXZdtI78qgmaQffEivxrAr0z/9LAN4M5kuMx2d47Px2auPgKwH5GGDy3vrYGKe4K3YH2uzqTZ4seqAqQkxNyX5DHMWDgKQQgxqGgpIQbVXnRLfaYQSmuIb7y0l1CgPzW6dyUApV2WFioRMGSQHATnJ1daNs/8rptGeFcVleBtirosdeXoGAuhNj64aD9sVK73eBR3nUC936xY0EoJsd6NpvDkLZrzOMynPalKOUolBwY9GKSACjV+Kto8EozJzXBfUBUSSOGfRB6jzmYIouOBh5f0pnpgA6BmNelUZaZhdiqQYWg5ZK3W46NBs0EKEKUMm55fQun9BkRndZDl7YYwj5Nf2ejhKHDLAtvQt7lOEqCFlj4lNAMtykwrrBb6cEOYdKqwkbMX3B0VW1KIgiVbAjihwd6d3W2oMfsUr4ELaRirQulwFeZT9wj/+OcGykJb+vmuqoxFzk61ryOwrfunOsQNGHjVI/hxJbnT1TIxFFFZS+PCwT2kkJqC1O4gDWWjGrsE1Vq3aUlPENLlpADuU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(346002)(39860400002)(376002)(1800799006)(451199021)(186006)(6666004)(2906002)(478600001)(41300700001)(6512007)(6506007)(316002)(26005)(66476007)(66946007)(66556008)(558084003)(6916009)(4326008)(38100700002)(54906003)(36916002)(86362001)(6486002)(8936002)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d+syRJPNh3t0Hl1Lbx+2TSVHRHaUmWwKRm1vVu7zKOZaj3h1/VsYAZACPGaq?=
 =?us-ascii?Q?nvZbA6rk6sSof/sQZG4fJW7H9tGev2g7dF6ttP0B4AgZ1rECH1cTMywH0zqL?=
 =?us-ascii?Q?nAv3W/Yr+laWH7yo3p2MXd1LZgy7K+tGnzQf2N0q/JDy98ZeVm45AjOP9wg6?=
 =?us-ascii?Q?0GiquhByjlC+8plUDGrGu6FcKvFrGzrNsj8G4EXso7frc2eBHWf8ENjLNz6C?=
 =?us-ascii?Q?mM8Eq0vvUUczo3BvsCkfEOmKMgf6kdUmHTwkv6MJ6y5rsIfGdsjcSalWmMmL?=
 =?us-ascii?Q?lPJ1ohSxgap3gkjpjW6UuA3N21/CsPF+8BzAzni5RFa7TT60KN4qWkT+jErX?=
 =?us-ascii?Q?GZKAH9B2KtMJUHadPDHIY4cqh36fd/ZnHzUl+SpaSzG1dw/8DR2LZErp+Mff?=
 =?us-ascii?Q?KrJ/a8+8CvZMQX9NVfozRo/9cXzDnP6NKo7ZCn3VoNQw65ZYJIcnndKlhn3o?=
 =?us-ascii?Q?P7Hg6C7exIxQFUt5w6nqtTlSoowvYkRduvh/wl+6ZvdRA4vqVgQx16z8PxVr?=
 =?us-ascii?Q?FX/lFhJeebl52LJg8a+MIFOLDjoZZu12b6yKy3Aqv43CieU7yoCS3F9hc83U?=
 =?us-ascii?Q?8iSpw4ApTq4MV3mpr0Pll1dyKw/en1V3GmVsb3oFCs2q7NuP3z+dDYe8+E46?=
 =?us-ascii?Q?cXl9u4mDi6XvBoB2Yk99mptdbrX7vGMmPaQh6aRDiY6OTdNSBIc5crGggydx?=
 =?us-ascii?Q?bY6RygfMnjsWAfz82VkqjIHWZ3PMkd0wfMnksvXgnCqIqiLDf7pyPNufsdJa?=
 =?us-ascii?Q?6dVAojXEDXAEnfDlkiFnykwvk446U2MCqGeCio4yMuWhFHIyJEwd2TtHxT25?=
 =?us-ascii?Q?G5otnI7OrmPfADZ0XloIkNb3aKffDZ+PgZItj9vi0Uvppm2kmMiYDrNMeagn?=
 =?us-ascii?Q?sdbtTrNjLgr2GaaU/3L03Xf2k97wGyq72crmRqG8zJo1+rayKYnHei1twkmO?=
 =?us-ascii?Q?QZkI0zAwJtlIj3Oe1MlRSUHofZU/xD/RGub+GCoKYL5jTQmzGdYy+sO8Dc5W?=
 =?us-ascii?Q?I6Gh0jJnXT5ifTOi3ZoVLxMTM+D8Pzp+0RnJH55zBok4Wm5+5R6EmGzONEj+?=
 =?us-ascii?Q?3gmWAcuRcP3JIrvVTRV/VI88rtQ/t31u2yG7LaJLJMLWy6Xgq9dgN1vbiDQM?=
 =?us-ascii?Q?QC9yobmO6i47O8KbwU2aARnDDI+B3RGPTgrICaYGWt662uMOeomCJVL1pdCR?=
 =?us-ascii?Q?017QJGerM91HqDwQyc1a7qGqdcTest154jbH4fXqmd4yqdtJ4phndXow9ZvF?=
 =?us-ascii?Q?FPUt3hzyN71x1pU66gbZWRtz36Fl48gl1P81m0cWLNTsFiMpn3U7PdeDA/xy?=
 =?us-ascii?Q?mTCd9VTHFNstRmRpCyA8FXyLOSMG1i6FQMCda1CGwmkAhgQquBajyZl/m3p7?=
 =?us-ascii?Q?SmSdg5jYizaO5fS0aE3yl9SlGwuI/HTrBrPF/n+Obqy8QJ75DbeDH2WCuvH1?=
 =?us-ascii?Q?QArNm24JWF3Zh7T3ji70QamVDttr9e0INVSoCpZdAqvusMqFs0lJErF2rMbJ?=
 =?us-ascii?Q?wEdGw8OLLhDsE+YfinZudm+SAs/VVXvcOWdNeS8yL8463c6kCFF+rEhhltlF?=
 =?us-ascii?Q?K5b63NiIM6yJe6KHfT3ZbD8s4P81CnVug1oQnc2SICLn4wb0xJzdsg6NbXwG?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?MgzUUSeqkSxQSqbM+zojKsihvIvBAqaPrvJ7xRq/aluwP0IfHcarFRocv+BG?=
 =?us-ascii?Q?GBlgJqkT7I9D7kBCFLCYJolwQBjyntuXqB2FAxuGTrWlCefeErhx0GZ1jJU1?=
 =?us-ascii?Q?UGoFNhRkCEVt1tJONETbm/515+OD3o/oYTehvFxD+DRPn1AHquRQDCuaeLKa?=
 =?us-ascii?Q?/p5mmNqgKIouVA35Lu4zrfhNpdKwEFpw6r6+Jovw3kI7F46xeS7CMn2j4q7J?=
 =?us-ascii?Q?09/wh1ktkLZJ1TmP3+fdNK5PHbNO5xauHuGqNF1A69a30APA3QhZrTBQH+8+?=
 =?us-ascii?Q?o2aCIhX7m8/tNfRwAswDwLjCbLjsAPHgYyg+W5XQTYcfhpXxiIflsdbmsYc5?=
 =?us-ascii?Q?IaBCWZuB5qRy2UU9wDh/n4bA+kPL0TNCwLATy1eQzeAKYUOmZP2Ze+RQj8C9?=
 =?us-ascii?Q?Mf0vT7MXceC6Tp0FqYE3RbGW4L+oJm/E4tJToXRvc5xYEpbQP/Qd2ujzsSMV?=
 =?us-ascii?Q?ykwAKgOXey9UHcwlJzdw8Z8ih7q6oMUGvBZ/0w7l2JUeuxmZxYoCwF4s5aaz?=
 =?us-ascii?Q?gq1vdbjuhJUIpTf529zXRf4bl8ZHiM6XYcJvrF5aCCmvWjcydL7Ub0xond5a?=
 =?us-ascii?Q?eS73rGaHpcy2XcY50QmJf55Hq8zd0TgIwtq4R+P/buVSNE320ZzhzEI8wQV8?=
 =?us-ascii?Q?tjLFeRL9aHr50L9zOV1qv7AbendTSlVSKaDk3gfCjcEZeJTpLWWcxv9Mvn0l?=
 =?us-ascii?Q?BKfgykdsTRX6pLd0WDUsVWBTgtrfYjgWmxW4sgyzzsZ9XtM0NxbWMgX3tPkc?=
 =?us-ascii?Q?yRiXP74d/QLjAA0a57K6ZkGsxh3uGCZ24hFm01p3UY0VMsRgMY9N+yMwf3gA?=
 =?us-ascii?Q?hlC7NUF62UAphtbOxxdckp2+22yi2l/I5Maa9lO//v4OhzJVPt/BtH9d+aPe?=
 =?us-ascii?Q?EPpWbMpBa34mM6vil6UDEkZhA9Ynwhle4bNigsDZhxAuxPIEpQA4bgdZWl26?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cb1efe-4d9d-45d7-7252-08db99248ecf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 22:04:09.9571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIV5uolHoELHLlXADzBf/Jdg5tW9VQZIVSgDyZzw41Kkg7j5c1bbwXrYcE8sGD41PP3R0aHgku4NaxBm5MUWrHzNbqFpSwWjmwsRP1PGwCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_19,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=898 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090190
X-Proofpoint-GUID: t75kGeNnIHP1gSnp8hs9hBH5TZUjuEhQ
X-Proofpoint-ORIG-GUID: t75kGeNnIHP1gSnp8hs9hBH5TZUjuEhQ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jinyoung,

> This looks OK to me. I'll test on physical SCSI hardware tomorrow to
> make sure there are no regressions.

Lab test complete, no regressions seen.

Tested-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
