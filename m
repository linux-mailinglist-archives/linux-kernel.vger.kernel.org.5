Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC080787DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239264AbjHYC3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbjHYC2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:28:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1AB1BFD;
        Thu, 24 Aug 2023 19:28:33 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P2S6v2026896;
        Fri, 25 Aug 2023 02:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=t1RCT2QLuoDIXbGRYJN9QJg8eVTQHuqXja2VZJHTbb4=;
 b=Ymps7LqsptgRPC3M3nXZyVsu3whj5UTNVa/gawIBEhQXczSotG5lOJfRBW2MFeb1gkKt
 +AFgFZ4F0Hn8xUqWi9Lx9SwlgOSt8K32bMNehBF4MC6MTivYJ0o6bOt9VJaYQn/wsgdY
 SpqPHEIVsEgFXX8QuyW05pmxyzWy6aWJ5mTDYTWJsLk1acogkq/PfsCgXt/umi0A8ak1
 EOWie5EdpKg3oIgJwXsqPlhyYmcCbx3yW/HneYMURec25gLm8izuPK8IoPnuxHDw1Jv6
 Xuok0EA/OavbTNrSF5r48tnppU3RMC5AfjQ9crBAR80xTf/dGWAe04eSmy/WgSWd9Jjy ZA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20dde9j-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 02:28:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37P0Guwh033219;
        Fri, 25 Aug 2023 02:07:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yx98sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 02:07:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAlP2wDiwZ+Fb6apHHVNpCitF7+Q1YZMH+jD9qT8+Lekjr1pk4ejuCDrZSHlgZuxqYR5eX7Ed3DdgvQ33ANNmm7tDcQxgO+/+qkxLJ+n5PYLP4AjpjM4tIDcMBhZLmLB7zOUQhV/puuJBngaENco6Q6P8tFJL5g4sheNqPyNcNBZP9gDWROBK1yPOvVLMNvTJuQJ5pwf6WckM60P4sb9ha8lu09DOGFbpqBLROMhUbzlKZRVIsWrHGS9i1kYJNA3a7HIDcoD2pc9QbdRvbzTxQmOToD7lM62nBPdCOBJ/XRwPQyz2VC+TMnj5fjzmREbrMn0sXmiOfKypP/SqjXHfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1RCT2QLuoDIXbGRYJN9QJg8eVTQHuqXja2VZJHTbb4=;
 b=PQ6FQyCBepnaMlllt5QJbwF9rpCMCuFo6uxOQS6iHPSycbuKz/EiUQgqJkfhGVqlRySglGnSx48NkuXfhybWDyGGsN1a0WbYWTDzLwHAe3VLiX2fG0JNjIcxA/XeccnH9QYERcvVo4GWGKMMNL1nccJsASHVVN7wcCppENwhbh4BtZ2v72dEx2djEwhi44TpboMs3bsm+Y71z7IbPUqBeWo6VEFg/Gya2c2uR1UfyrpZOjFQAPj9XTZYE39yq507IOKexvfhy7msEHcxc0/R3LXrlvM95oXAi8MIBL4Hpy8KfCAqxZnHiuhot8llncZVYMcACC+GBWbaUZSpScVGbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1RCT2QLuoDIXbGRYJN9QJg8eVTQHuqXja2VZJHTbb4=;
 b=eY5aYZeP8til5K6j/VsNLN8TEB/YeNXe3iKfYSHFf3ZRehoA7gUjffK74rHZzZ7NPzg4iDg2sz58DDcayijc1lqX/g/VfoCDxKmIdqByvbGkk66xGm1d5NY1tIiPQVPgStUvbmupAeaydcM1iXEsYpkBkWI6nenbkohIulE1vQA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB5021.namprd10.prod.outlook.com (2603:10b6:5:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 02:07:17 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 02:07:17 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        xen-devel@lists.xenproject.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] xen/scsifront: shost_priv() can never return NULL
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o7iv3mf9.fsf@ca-mkp.ca.oracle.com>
References: <20230822064817.27257-1-jgross@suse.com>
Date:   Thu, 24 Aug 2023 22:07:15 -0400
In-Reply-To: <20230822064817.27257-1-jgross@suse.com> (Juergen Gross's message
        of "Tue, 22 Aug 2023 08:48:17 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS7PR10MB5021:EE_
X-MS-Office365-Filtering-Correlation-Id: e30cf004-ed96-4481-b91d-08dba5100201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ObHSyQ9G1AEUz54ihGthAWJXJEEZ9gi8toCjlcBLlBIDKMFQ0ZZCYtTi3xcVXlQZo5mNUQf5FCVqNV5bZUYCV5CeFHrr8KvMJCTS6bCZw8C3wXESAY7GdOGwEdGu+Y9I+5D/F1u7w+Y9JFOZ1FfPg4SJnIfW8mLRETx2N4v3zyWzUIYGireCbsaFhu2+m8u9R1GwrbzjDoJGVlUwD71ssuye/umpDaQw51W1m2k1YKjKYR8omcJQaklFGIiU/SB7KPLMsEgMEU0XrfzHDdfnOsOaQ6OTjd7DlxfOgiMjAXcQomE2jXE38xqFa3vXiazLiYvARhMY0+wpPWTLIzsuJbctNCcBzyV6MJ+zbEwaiFYlA+SaEX0ouEXRfjUGSM1HrDnGm+za+uSrBRpoty+2K76OwfmDjkNm91z74ygCcIMhbls5567ChCkMIKcimDliW+ajHCccOcC9XlIWyMGlXLYKaCTTXfg0vhNWZjs1MQRPRwfw8pv4vrJ0o6+F5jfNK7BoniKn8lh4E3vx+UK0eMkjLjQhKf4wKKNhuDCgzYXXpvE1rPyOE25iuA+EJRLv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(186009)(1800799009)(451199024)(5660300002)(8936002)(4326008)(8676002)(4744005)(26005)(38100700002)(66556008)(66946007)(66476007)(6506007)(54906003)(6916009)(316002)(478600001)(41300700001)(2906002)(6512007)(86362001)(36916002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q6E6GCRHTGmkIrf1u+8F2wVXI1lpr/gyJrRYmsmdIgjuxTVc98TqVviXsYRL?=
 =?us-ascii?Q?ej/kdTkf4KFJslkWdzdQVC9rO/mnrDQJxvSXJ5JgMBNXTD/k7fxgJxWGNi4p?=
 =?us-ascii?Q?2G9z0njTsphZWA9gr9dUF67D9bE7+JguMdTzb1/FFmzVhADDVtvHRsbSxt8d?=
 =?us-ascii?Q?junCFL6VG7utQxmgql1OuUk0z2hzZUihs9sy8Da+AfHQiNqGPt3sVTeUV+qF?=
 =?us-ascii?Q?bLa3bpqaCfAARB/B/zuUv/4KBkPBYhOB1A+au1eJ2zgBwwM0phbs4fXgzhJm?=
 =?us-ascii?Q?HgPKftVLltaZQB44DvsIpdyZWDGx3Cl1KKqT6qNE+qg4W5j35KuRzIGmpvu/?=
 =?us-ascii?Q?jLp3TNwRagzvwjH96RfoQRP9bjm+YkCRUkED6cg2zZ3OymVpO/9pQWf9mG8h?=
 =?us-ascii?Q?ijEcq1J9EahmC2Ek6+a4NgcVEwbKBVz3eNmZCyhgEHzHyjMvbX8cAktsZV/A?=
 =?us-ascii?Q?Q1L8eQFeShIV3h++3xPwe209uA58J4azLeGqMViSZaK1G3Libf8glI7AqZ71?=
 =?us-ascii?Q?YSKEeVDNG5C5Egoa+Y3TtQqx85gXJV6i4GlaVmrcgIy3OSB29gTXltLvNYq1?=
 =?us-ascii?Q?rK1osP0kq7TfC4akI/LbkeacxkKm2uRGu1qWGVN/lCOpfrLfYStpT5vycZuy?=
 =?us-ascii?Q?0WWx3ClyXBoSK9i/XDiXSGL3yr9s55ZhzetwCgzAyCCJAK3sBfZXxO9sOzD3?=
 =?us-ascii?Q?FZQQNlTO4fX3RUU+p7/VryL9DzHj6gkdOmSVJmVKg7KdxX5IPNULrnWMz7rW?=
 =?us-ascii?Q?FA4bcpCaSzorAa41EUY24J2Eatm2rSAJZ4xtTKto4ry5bJOC24dbOqpcxKSW?=
 =?us-ascii?Q?XKhMs7/dkxnnaSnyPnZjJGfQO5O7eGFa9uzwboWHl+iV9T3SpMKDa7mcVUnf?=
 =?us-ascii?Q?NBQvwXDlesJjdvt/5hMwHgeXUHY0m4adD5qO4DevaIv4AffdWJD0YSWz7ere?=
 =?us-ascii?Q?tklWiGRePhBYemFxTb7ItojdYwY7gr0B1yFvaP9mmo6FXnTkMKcMEF9/jm4B?=
 =?us-ascii?Q?RfhJXo4FwXZ4adjqtLEAYHNqsAcZQKXrcLTMI4ijoLLXsHGKh1fbgTT4NeDL?=
 =?us-ascii?Q?M51zapVWPor7y4Ep8owCzRwtPtwn3HCtluduoZ+U9cDlfigjvHb0KvyYRONz?=
 =?us-ascii?Q?lc3lmlG6FKnZ11jNmysoxURkQs7UFyXSZGD62sTweddHpq38AbLoBRuUILby?=
 =?us-ascii?Q?kxzfNjEV2LhfVw7ZQJWYol+NCVa+qKg0+SNQDOGDYUVcJoiqoP3pTSaSvV2B?=
 =?us-ascii?Q?jWeJaBxPwu9doJ4dY2h8Hkj4MNSNr0TzvoifuMymBjnN6dDWFeg/VQhYrEIC?=
 =?us-ascii?Q?5H9WWDQDmhzN4hWVfoj6qhf24IcKdq+ORn1emkqngFFG1c9CUMGZKkiwKHAR?=
 =?us-ascii?Q?nNWgXshc1S1aKord3OIiqP1GzYghAXp1WhMF4wntqBZZjDWGcbcdtlGgDgJo?=
 =?us-ascii?Q?VcT68rf4BZqkx7+n1dXQnjITSfYSIR5+ykXueeP3bQDnB0AiWBOz2FwZ08sf?=
 =?us-ascii?Q?DBtZhSl3eZfCG9AWis5YJUVEtJC1V+Yuyq3enaTAk4UYOYodtRps2IEtDBGt?=
 =?us-ascii?Q?AoeOKmXvXOGiLupZr3HbtZaMs4ozFo9I1Q1ZJCV8hu4IAn3EKQm30gA5k73/?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qIdwLF3R3SBXmkYdw4bxeijoChR9e55kwaR9q9dMmIVHWkfZxDUW+G0Wb/wF?=
 =?us-ascii?Q?0vFRJNi50unx1RpFXsvtGkgxGlkiqkcfVbnmbpEezbsb20ek/AIgAx2l9fXV?=
 =?us-ascii?Q?aPuR4V8b+Uycci7xxpeMUjAgD8ZB3tGuAOUYS268g/51OUs8EG/cHDrX2VPr?=
 =?us-ascii?Q?GWbS6bZrEP9TswnM3H0dW5P8Oyw/fhZX5ZdfEROCyDA01qjxCpbqm+Ada3Tk?=
 =?us-ascii?Q?Keoq/fGC9juyYs51eDv1rvOyUj/19eMG8Y4F8J6bcJQSOpmiBkmQZGlRsg5G?=
 =?us-ascii?Q?35o3vCK335mc1MYO4ylZ3kl9t0z/+vot0Y5x10VS9M8sbCf8ZKp20uLbFld3?=
 =?us-ascii?Q?g/tx3jOSP6OShpoVhFUiVMZadKjSUTi7yrf9Z+8GHG7n8fmpTZ05kk9zTLmq?=
 =?us-ascii?Q?wRzJaTFF/FYUf+TMaZAXCRSRyd5b3QHvoGsNrVmeunnGRcjEz6H35VvjpOfp?=
 =?us-ascii?Q?sVCfEwt0glVbUsjmIL8z6igCBr6wtrIlErNxn2LRF6SUmlxnKMYpy2MOenAD?=
 =?us-ascii?Q?PhTwDtS9z8rcwWgPkA4Vf3akwk6zAn/ON356nS1oJ5k+fNaCqNriXnWp2d7X?=
 =?us-ascii?Q?YRHsfWb1/jfVNUvN/W7k9WP7GBSDAhjOudHCoVfAiWyQ3nkwDWJUySYFqSvD?=
 =?us-ascii?Q?99dVhyPIaRi7UoyBxKHzXREDX26c98cn/Qd2k7KeUEoJ41ftL13uL4gHt7Bb?=
 =?us-ascii?Q?lhHBJ6dXcRd/hXrZKfVkO+RH5yJyG88ko73tcbXSOpHEVHI9mXjiZr+HOEW0?=
 =?us-ascii?Q?/Ueu7ioUL4Yo5QY5hqnzaTh9q/pBtXVhZYzf+bLFzI6z1XtuBzzYGsJkX8eX?=
 =?us-ascii?Q?y2tKNHYAV4hguk3AmdPoiNOVgVThPVeSTFtELD2V12lSzeq7CWMPK+jZL/If?=
 =?us-ascii?Q?OeJTcmqCVme5KvCK6vwnrcU+n+DhVu8xSHEree7Wawwzd77xcYLFMvokM1hO?=
 =?us-ascii?Q?VHy4/F5xgps/x2hwd38oSA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30cf004-ed96-4481-b91d-08dba5100201
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 02:07:17.5749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLZIrM6YjLuyNZ8b2Wesr7Hx1/gtjOB3Idcj+raE3AIGtCNL97nwJ6Ql1OBYOBa6x+ulCsj4147OJL/SMARcCxeuxLGsMEUD8pDXtGBlOOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5021
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_01,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=824 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250016
X-Proofpoint-GUID: OttLoPkS60hXdAJoRBvwsjWhkZ4pzVeO
X-Proofpoint-ORIG-GUID: OttLoPkS60hXdAJoRBvwsjWhkZ4pzVeO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Juergen,

> There is no need to check whether shost_priv() returns a non-NULL
> value, as the pointer returned is just an offset to the passed in
> parameter.
>
> While at it replace an open coded shost_priv() instance.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
