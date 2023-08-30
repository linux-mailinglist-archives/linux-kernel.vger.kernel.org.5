Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE0E78E0DD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbjH3Unw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240259AbjH3Unm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:43:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B0549CA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:30:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UInXRV032362;
        Wed, 30 Aug 2023 18:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=STjuB//DGiYu0SsVjaSTCr94if90opeu8m7UAeTADmE=;
 b=gwUTTtv/KL2nwpy5reEzy58WWGFh9LtJ/pRyqpSAmGvjEG3gexJtYdvbnXG1n1zjBZV5
 Kb/jPUrsCtBm10iAWqbmxtIpEI1RcWEV6Dwk39V+NheZxZ/uSlGJL8GAmR4OCcpywAoN
 BsUTe1Ow9QkOXRU/1zI5e93T4jwnTsD/RlvueaDnyciTfHv5wqpgUv8zHUuyrdp15vOB
 Z8smGx4uWVYhjGE8aOGJFP3bcXPwh//h0Paok+TC0xBRLh0ApfFcmrmDpkSoqG0NkP7N
 4+YJsLZsfGRZJpe4crrtLWoQV/0nSd1Um7GCRtZb1sRZOiBAsU0dTmZtV9IHythIMdeJ CA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9k686b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:50:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UHkegk032779;
        Wed, 30 Aug 2023 18:50:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dqehb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:50:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHFLRJCpCqDLcLtOEMcvU8AEqCjfW5zZOnEmiYsfn5pYhZeFBRuKJvf03vnDoXi2j/z8U82kgX3p+UVgAA0JUsqw3R0IOwTy/jO/fGV+6n6lU0YrcVvJRU1RPxpEVSfsWc8CVuIWlHt8fnGJVlXIb7RbmmaRRJi/u0uHo2hXuISns8mArNKf7XCoslTKublwPjy1mp5urgeiHaQqJYDrlG79PY7SBpIdFIRoJ1Q7OKPS1vPksi3MEtTdeFEiFX0xCKSw95i2gGQGQPpNEX+DQkmJAAquINXrNuNtR+kC0ZVEBMryy+i9BMfFdkF0KcP/OpsIKtixtKhwwdWYp0ecyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STjuB//DGiYu0SsVjaSTCr94if90opeu8m7UAeTADmE=;
 b=T2xqmRS+LWlaOeXK49MXP6fmB39rNUbDzFrQqPjGmySBb+zntKigJjw04QzlZvYd0PrgFmppxDp9H8LWfca+wXB0LsMgaT1jTk3h3pgmHT7EZvX5RVPlTjmHzNhnXUqhN3Tx8mfr8RB3Ta8h5i/vrHKO05rjZBf7f0fhC2pzWpPs1ewtx9cV5fGR0Glcbxf9M6I6Ak2KSw4cDML2Kt4N+qsfeYhS+IyE9AJlQIZ4dFykgh6PjMf0mFZfuZ/iHTeZ3ZIltPnUXQA0H17s5TPUZ9zvqQQg9VDetUc7MU+PRc2neeaJtdE0/88X1ppj731lv26uHiJK7dd/xgDu1Q5n5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STjuB//DGiYu0SsVjaSTCr94if90opeu8m7UAeTADmE=;
 b=iUeKoDF9rM2SgdD4KDp0VTJs45j3mAK44jjoGju3EpRuFuyOSm8hcHj79X4LS8tSNYuwZQUQF+2XkcgWwxMvi3rx4Lx1m8bCJRTprtIKI0DZyv6vi1o+ER7zH/jNBN5MArpHeq8w6oC0vpkmC0XuFVzlr0mpYosELADS6iXZkRE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BLAPR10MB5203.namprd10.prod.outlook.com (2603:10b6:208:30d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 18:50:01 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::238e:5e86:cbd0:7415]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::238e:5e86:cbd0:7415%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 18:50:01 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v2 0/9] x86/clear_huge_page: multi-page clearing
Date:   Wed, 30 Aug 2023 11:49:49 -0700
Message-Id: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:a03:505::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BLAPR10MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: 90710399-c4eb-4475-7858-08dba989ea88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6qVl30TiWkw6z3zoQgNDl/Sb9hUiBI/Qj2+exc7ciIGT+AipzRw9i4E4kvUFCGZTVrrmXDSKyXstE0f2Idd0NHM2wVMh4fZIu08dZgUPtB4aZp1glV+NcivYrPdkfazprG6k8E56pgYkrXB5HvVIkD4XOaRWBxlEC3kb6j6496uDGx9pt6FhAsQyhh7HGcceFvuxxOure4Kfrh5opOMBYun0dfX6AQQp0yic4A6TWAxRzXeCk8w2mk7Syab2f39Cj8bLWsvbMBr37JLMOz3CJWi14BU46Miv1UmUidU93azCSxoyTAnCH+HVdgWJHFpyc1Z0Yc2iDuFFY4VtYH80wujoRXWGG4rHfEan2Y6ADkQkfaomkcHdvcfYrj10x0aO2Cj78dEHIMByS8aW3m83Psv/35M75lpp3dwkuHCaExEhz/SbUFsCchoNW5X3AHlShctCWYYg9sg8wo8PaiyxGluE2EsmERG0hE+Rq/OQBhfoW11jhmu98V9MRgo7KwuVxhzj1N1O02yBs/uXzjmfxpav5HZPXQBY860LsCRE8OSVO47b/FB1kLbeB4b7yOBVJiVFo98RR1mJerZrGDzcE473w7atTdu9Fh6T/jRfstnhz6Z+gH1wuX7R0dRZBZmGO8fa8uInAYrl5nonoL1YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199024)(1800799009)(186009)(6512007)(6666004)(6486002)(6506007)(107886003)(2616005)(26005)(1076003)(86362001)(38100700002)(7416002)(103116003)(5660300002)(4326008)(2906002)(8676002)(41300700001)(66946007)(8936002)(36756003)(66476007)(66556008)(316002)(478600001)(966005)(84970400001)(83380400001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d7bLn2bYICDWTOaiQ+4OH+A8z+AOUUVvAdwjNqpBtLtKb1T+RCPoGDWCy4m3?=
 =?us-ascii?Q?V4oODB7Cb3yUBIeBHXILodqJTR+owHq4fSkkP4a+RP6sGc/jCXIgYKbDNZZF?=
 =?us-ascii?Q?rzvmX7u2RSOH2DBvGkw5mdsv/OYKroJc6WIIM90xQNYEx+/OzwNF9O7ABhbb?=
 =?us-ascii?Q?ZLLYIgjJ5CvXxeHPyoD4OhuE0cQUtu9nY1bxTkD54yTjbKY7/GikjFhMqYda?=
 =?us-ascii?Q?Bx31PmWYCZtoN5/9gCaW3udd0AiJaGraCEug7p2JijntRnWizLAEVv/vwV22?=
 =?us-ascii?Q?jWY2q5n90xlR+/nNOQBaeHNX+3gqbqIkH1DcWVhshoYrYpVY7k9SRDaaUKEQ?=
 =?us-ascii?Q?l0yu8ilQtHSpf2FeuNXaelT/J9p1bQ/at66vOdLS34aGggZGYqbfZC3R9bmw?=
 =?us-ascii?Q?uqwc5vTquOjOyiuK+C4s/9ZaCA+Ah5vKUDzLbVf4DE7dWbRbz0CcG7YC9KyV?=
 =?us-ascii?Q?dN0FWoB/pQ53unexJJLT0DbIukMSPcFjfflPkLOn78JdC3dBm8ksSY5uedh6?=
 =?us-ascii?Q?y4g4iYzXPG6UDfAdv3uUjTqxhnq5f6g6DUErBM9nAjPy1bjsrTgS4tgXXxko?=
 =?us-ascii?Q?x444CWunA62bs5SF2qIT4k5F0Ehnw4mJ3HSa3K662zhxR+pCCbXGnp5hzRbc?=
 =?us-ascii?Q?YbM1FSJShcuge5AOAQaVCDGc5lSU7La7ebGtKCiVPtZRReLv6o+RA/CNhr+B?=
 =?us-ascii?Q?hUruc9LwYhmNbzDnsW3kSS/p2TNSTWu2hsCJS2IDLu0YL3GNh7gP673fzGOf?=
 =?us-ascii?Q?3ThNrbBLtLRVAM0rnMJO0KXDQ5UJ7VQ86+1f0E2ViiSdUt4hf3dlUV/NXnH8?=
 =?us-ascii?Q?HMDsBmH+K3CMCQk6104HoXsh9XM5nq7DMwwoHXYMXsJBBg6nmtRWPAigDgKO?=
 =?us-ascii?Q?ZJ6vq+sO9dE4XIGrx6Huc49Ei59E2N/Kp02DjTYG1zt5+GSv+iCG0E637EMp?=
 =?us-ascii?Q?BmVQSHkTkN+3gV/+AByt5T9KBzenWcu9TKR4EYR2Y5bsnuMQ6/lwf5ClSeCn?=
 =?us-ascii?Q?LS5qU2H9RgxOe01eTU1SLdvMOvHZcqaR7W3HpMBjDR21nSVhwumBtufGIjC0?=
 =?us-ascii?Q?waFHnWp+zO+3WA5hXZoGJ+CAsjLDatCMKrYEHxp4QOJEdCgW6KSeV22u1Is4?=
 =?us-ascii?Q?Ux3cvbztDHYjA3C4G1WecnRS4Hd0zDSndwxt94BPjpA6tbFIS4MJEE2u78hU?=
 =?us-ascii?Q?k99hzSCGZVK83lLme2c+UGAUjlHvbqO/KYqBicItU8RTTcc/Z/XWmPx6RYHs?=
 =?us-ascii?Q?g1bq3Kvgsek+XqwNIVYz3DuGVfHhQW82d4sD10uV4PzZGqWE+W7Tu275Y70l?=
 =?us-ascii?Q?MaVuOQUUXpvE8IcBeuUaxvTNpEHYSWby+UKG8MMJuXq4ugjLhSiv/U57aD4w?=
 =?us-ascii?Q?hLl+bBLg4z19qeF6cTJdusMxAWU1Z9Qs6MiH9Tiy00GvI0XGHdyNIGUQLdBa?=
 =?us-ascii?Q?rL37fjnI8ggtsF2TFrir+HbZoLmyjjwH7Vin2mmEwVXe61Q42LrThUKbbmof?=
 =?us-ascii?Q?Dyuiz+Q+ctTha2Z3TT7kLDy24qwnmSLHshIyOPRIvBpZnXB/MkjblSNb+ehN?=
 =?us-ascii?Q?NHB0eBs6KaFQN697Qx8ENIsloX8vzPe+R86CUAhNvFHoKgNrxyN5aDxDHsQn?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?W5PTQU9ZhNoJTzrHQum0/ibn/7dLuUOhlL6rRNTKzgj4+9HvjIL9dIKoVjv/?=
 =?us-ascii?Q?B2JAz9+xEKAPK+h7jA1R8dqCiQAmCwjObQYW5+YehWg5BC4uD5XXA2txf+66?=
 =?us-ascii?Q?h9otxN6z1z9bUHfIzZ+wcr44VZOH62igvFt83RWDwORjjEA8cO0SiJdFQZBs?=
 =?us-ascii?Q?I0RKdDDKKnHG3Uvlm0ZcMitMiCIcI7Zp2MSGIu42GlCnmBqwEMObWZFAOrQG?=
 =?us-ascii?Q?bzu0cJ9d4Gtd1bZq/qw1E6OoEZhV/tyit049p1zvKAutWXkZe5Mgzo+34Jv4?=
 =?us-ascii?Q?8VUWFS2OO6vr/0IjQ/b/Q7HnFNI4lm6wLMNQp3UUi+XlBk+B73/gqiF3pLx5?=
 =?us-ascii?Q?ooSNNacAM/FdzMm7wGXBHR6VGu+xaXIo1drSaHwtwt8Ee7RoBD1dvxt5J1Nu?=
 =?us-ascii?Q?4WHWxKTwOP8XGvBnffFKpcaCBrwab1AX0ngobYsMsYYbe36ULNLia4prLk3W?=
 =?us-ascii?Q?NCt3g9mFPRbQUoDUOx/lRcDPwap9+nxptpL+Ol5YrxjKL3PSU5rcUqu5nUyp?=
 =?us-ascii?Q?0sm5YMRCNo0DewcgBOuWHLdcW86Tfqt9YaQyOKlCHGSw2CFtIIbvNcY+h6kw?=
 =?us-ascii?Q?DhCyRusQWgkdIZnE00oGYS356iWy649+hMh/E/jZcNF53gh5hOE3A9T62YI1?=
 =?us-ascii?Q?n55bts+JZ1G8JkhIUh4+CvDRyWbRL1NDQA+39tIpkvmYlUvxZaiJTov1K/3a?=
 =?us-ascii?Q?I/WhfyNxArIOr9/fAtZnK14LXHibOPTcjX2hifnuaxSsujgGFbvm6V7SLp3J?=
 =?us-ascii?Q?FbLaNmx96F86DBDB91ZD6T1HhTFfsNMDXsCUjNfVI/3jiPgYw1ovc19+58IA?=
 =?us-ascii?Q?YrAhhLMNFuqngjGeV/LSEwgn64030JlmMmSoDlnC6dXZ+Ha6RaVG0nfyZ0z1?=
 =?us-ascii?Q?wOjf1LhqEv9F8+P+C8Tq057QwAAkURroW62GCJ7gKjHCloUuCPVCBCUPwap9?=
 =?us-ascii?Q?0q04gLrxTqN9nf9IWrNwYdNQA+0vWc3f8zr4J6jxCM7pueUVw6iJ2bbULs0n?=
 =?us-ascii?Q?17oPxhzLOKKPzdZaNgo2HxV6NCwZZkeHPR6BVbeU2JECa2zMkKDWXG/7eWX7?=
 =?us-ascii?Q?z0d2jgBLSPnpRUiWInFQL+6tO33WZqxMPySnBKVFPyjWov9GgoHsFWm9XVzS?=
 =?us-ascii?Q?CU9lPXl/zUHRmJ6oh/gGOHgh1DGxUC/l7njk/5WUMGOj/kOma37pMF8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90710399-c4eb-4475-7858-08dba989ea88
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 18:50:01.6678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y39ROT3ScOPr8Gic0tQMKFYlA1y6KlYQMowVL0YMcMA//0c7wVlBVD9MD0j1CaVhWXImNIb7L4TOrnOjagxRmSP3y/uzOP/xDygMjYuSAAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300170
X-Proofpoint-GUID: O-k1aiO4XuQKK-XH7lsbSGqEZG6uRabD
X-Proofpoint-ORIG-GUID: O-k1aiO4XuQKK-XH7lsbSGqEZG6uRabD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a multi-page clearing primitive, clear_pages(),
which enables more effective use of x86 string instructions by
advertising the real region-size to be cleared. 

Region-size can be used as a hint by uarchs to optimize the
clearing.

Also add allow_resched() which marks a code-section as allowing
rescheduling in the irqentry_exit path. This allows clear_pages()
to get by without having to call cond_sched() periodically.
(preempt_model_full() already handles this via
irqentry_exit_cond_resched(), so we handle this similarly for
preempt_model_none() and preempt_model_voluntary().)

Performance
==

With this demand fault performance gets a decent increase:

  *Milan*     mm/clear_huge_page   x86/clear_huge_page   change    
                          (GB/s)                (GB/s)             
                                                                   
  pg-sz=2MB                14.55                 19.29    +32.5%
  pg-sz=1GB                19.34                 49.60   +156.4%  

Milan (and some other AMD Zen uarchs tested) take advantage of the
hint to elide cacheline allocation for pg-sz=1GB. The cut-off for
this optimization seems to be at around region-size > LLC-size so
the pg-sz=2MB load still allocates cachelines.


  *Icelakex*  mm/clear_huge_page   x86/clear_huge_page   change   
                          (GB/s)                (GB/s)            
                                                                  
  pg-sz=2MB                 9.19                 12.94   +40.8%  
  pg-sz=1GB                 9.36                 12.97   +38.5%  

Icelakex sees a decent improvement in performance but for both
region-sizes does continue to allocate cachelines.


Negative: there is, a downside to clearing in larger chunks: the
current approach clears page-at-a-time, narrowing towards
the faulting subpage. This has better cache characteristics for
some sequential access workloads where subpages near the faulting
page have a greater likelihood of access.

I'm not sure if there are real cases which care about this workload
but one example is the vm-scalability/case-anon-w-seq-hugetlb test.
This test starts a process for each online CPU, with each process
writing sequentially to its set of hugepages.

The bottleneck here is the memory pipe and so the improvement in
stime is limited, and because the clearing is less cache-optimal 
now, utime suffers from worse user cache misses.

  *Icelakex*               mm/clear_huge_page  x86/clear_huge_page  change
  (tasks=128, mem=4GB/task)

  stime                        286.8 +- 3.6%      243.9 +- 4.1%     -14.9%
  utime                        497.7 +- 4.1%      553.5 +- 2.0%     +11.2%
  wall-clock                     6.9 +- 2.8%        7.0 +- 1.4%     + 1.4%


  *Milan*                  mm/clear_huge_page  x86/clear_huge_page  change
  (mem=1GB/task, tasks=512)

  stime                        501.3 +- 1.4%      498.0 +- 0.9%      -0.5%
  utime                        298.7 +- 1.1%      335.0 +- 2.2%     +12.1%
  wall-clock                     3.5 +- 2.8%        3.8 +- 2.6%      +8.5%

The same test performs better if we have a smaller number of processes,
since there is more backend BW available, and thus the improved stime
compensates for the worse utime.

This could be improved by using more circuitous chunking (somewhat
like this:
https://lore.kernel.org/lkml/20220606203725.1313715-1-ankur.a.arora@oracle.com/).
But I'm not sure if it is worth doing. Opinions?

Patches
==

Patch 1, 2, 3:
  "mm/clear_huge_page: allow arch override for clear_huge_page()",
  "mm/huge_page: separate clear_huge_page() and copy_huge_page()",
  "mm/huge_page: cleanup clear_/copy_subpage()"
are minor. The first one allows clear_huge_page() to have an
arch specific version and the other two are mechanical cleanup
patches.

Patches 3, 4, 5:
  "x86/clear_page: extend clear_page*() for multi-page clearing",
  "x86/clear_page: add clear_pages()",
  "x86/clear_huge_page: multi-page clearing"
define the x86 specific clear_pages() and clear_huge_pages().

Patches 6, 7, 8:
  "sched: define TIF_ALLOW_RESCHED"
  "irqentry: define irqentry_exit_allow_resched()"
which defines allow_resched() to demarcate preemptible sections.

This gets used in patch 9:
  "x86/clear_huge_page: make clear_contig_region() preemptible".

Changelog:

v2:
  - Addressed review comments from peterz, tglx.
  - Removed clear_user_pages(), and CONFIG_X86_32:clear_pages()
  - General code cleanup

Also at:
  github.com/terminus/linux clear-pages.v2

Comments appreciated!

Ankur Arora (9):
  mm/clear_huge_page: allow arch override for clear_huge_page()
  mm/huge_page: separate clear_huge_page() and copy_huge_page()
  mm/huge_page: cleanup clear_/copy_subpage()
  x86/clear_page: extend clear_page*() for multi-page clearing
  x86/clear_page: add clear_pages()
  x86/clear_huge_page: multi-page clearing
  sched: define TIF_ALLOW_RESCHED
  irqentry: define irqentry_exit_allow_resched()
  x86/clear_huge_page: make clear_contig_region() preemptible

 arch/x86/include/asm/page_64.h     |  27 +++--
 arch/x86/include/asm/thread_info.h |   2 +
 arch/x86/lib/clear_page_64.S       |  52 ++++++---
 arch/x86/mm/hugetlbpage.c          |  59 ++++++++++
 include/linux/entry-common.h       |  13 +++
 include/linux/sched.h              |  30 +++++
 kernel/entry/common.c              |  13 ++-
 kernel/sched/core.c                |  32 ++---
 mm/memory.c                        | 181 +++++++++++++++++------------
 9 files changed, 297 insertions(+), 112 deletions(-)

-- 
2.31.1

