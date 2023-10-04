Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889D97B803C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242325AbjJDNKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjJDNKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:10:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01072A1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 06:10:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3948inr1030736;
        Wed, 4 Oct 2023 13:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=PNNuW8v9PkKaE7b/8IxpUp7CQk8zY5XteN8HwpQfEG8=;
 b=XWBWb4QWWHBCJ44hscPhz1ZgiJFnG9WT3530H48JRCuZ/ZV6r69evyse1C/ZmBwv7saY
 d276enIHXHJPL7Dy5m0JA2BvLBS3TDhnYggaGSfl/2Vwm7zyIJ+ICsq/YPD7wzXV/OM8
 HujxdCFAEEUvtGTafWsoh1Cj9J/n/AgAR93T4PfuFtUeTeKKhI5KhINOXpomy6HgzZHg
 CtMD1FNPAWjTa98svjXnsTSvk+EmNpTAdvOQZ0UeqkyP1cVTsu3lbiyzswHnN25O0qI1
 GdeL+RgSPpVboxQfaE6O2DymOl65Dcx5mA/VsayPsxq0H5HDhaAUAD8L0TdOs1F6sUC+ CA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9uf1rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 13:09:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394BPHI1005863;
        Wed, 4 Oct 2023 13:09:17 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea47k4kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 13:09:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niWMDsPODfRiOu2m09bfIo9/WS9uj9Rck3F5pepU6iIvhIQPykSspGLpaaWHNAwtkTs1uWia6nDdVkoL42HCQmQnjpr8zTSXeYSDXS6BI+oH2NNpW3ZtnfrdoR/Uth6kD6EJMUY/YmRRBp8K5LwJXIkjgQ4kyzXI8KU8f9a+lskG1J8yhNgKO/kKS4kUKwMXIZdpy38mtYWKxq/qF/pa41VYbrWSRWlWIhsowZa8wSABKdDjuTCc6ajqU7A3tIx4DHkW3s9sok7LV1WV1lAwM94hQpC20a8kazT6iOlJka2k3u3oTgwpDOLoLQsJJsBu7XdNmJzEPjdAbIOtgMH2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNNuW8v9PkKaE7b/8IxpUp7CQk8zY5XteN8HwpQfEG8=;
 b=arLw74kGewP+sXxHz8PbzB6hNHnNsyWwTHKkZKZYwbOacXUfEhifIiZn1lXvLeGi5EEyjlphKQD2iQw4yfEpj+Knl9+WP0DZ4sE4S0TzEMbClyG8v8MJWkThLAew+idH7y/FfQ/0MBFBHQed9PK/FlCfcCpzpnQm7V2fzP8/VCYcfga5fSl6cId+xE2KYY9UlURXCLKiaRVWaFPR0tTq+14ky9bfL6cn05/LEi6qRs7qS7yMG8mxr7BTYH/OJ+SVEpuo0gQTRiWYgPKEUrWYg2wNAQ9mjxKLpgnUzoPokziCkgy8jFbjSnrcfa32rQ5T/bbzMc0ojvD4d5WssHFdZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNNuW8v9PkKaE7b/8IxpUp7CQk8zY5XteN8HwpQfEG8=;
 b=gvT3YHS6/X8uv0uFzvhnYr0BZlt8+x3Z8OddIYxetnG6ivdDeMCiHsifN2Q2hcjIt41u+vJaV5J2WFRvTwSt81RuSFD+1iDJ9+irGZnGpcHKoq4cNwKbaVrZ7kBsuz+20LbO4xLaq0opnuCRj1Bzo0ATviw5oAnDERoU6M/VXtc=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by CH2PR10MB4168.namprd10.prod.outlook.com (2603:10b6:610:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.35; Wed, 4 Oct
 2023 13:09:14 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48%4]) with mapi id 15.20.6792.026; Wed, 4 Oct 2023
 13:09:14 +0000
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     peterz@infradead.org
Cc:     bristot@redhat.com, bsegall@google.com, chris.hyser@oracle.com,
        corbet@lwn.net, dietmar.eggemann@arm.com, efault@gmx.de,
        joel@joelfernandes.org, joshdon@google.com, juri.lelli@redhat.com,
        kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@kernel.org, patrick.bellasi@matbug.net,
        pavel@ucw.cz, pjt@google.com, qperret@google.com,
        qyousef@layalina.io, rostedt@goodmis.org, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, timj@gnu.org,
        vincent.guittot@linaro.org, youssefesmat@chromium.org,
        yu.c.chen@intel.com, daniel.m.jordan@oracle.com
Subject: [PATCH v2] sched/fair: Preserve PLACE_DEADLINE_INITIAL deadline
Date:   Wed,  4 Oct 2023 09:09:08 -0400
Message-ID: <20231004130908.238992-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004011737.188682-1-daniel.m.jordan@oracle.com>
References: <20231004011737.188682-1-daniel.m.jordan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0233.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::21) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|CH2PR10MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: c951f26b-56be-4cee-2bb6-08dbc4db1b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHnB8WIAYPy6oADxTxClyoA1LXg1+ZItTpMlnrFZR0rwYPaqcvx2aJA21Zj5BYzHduegiS0mM34KdpQBWn+J2a92VnlhYX8Q+KZEF4pb98bsoksKgr+1wVxzYMs+xpOkyvRudgJ+uJm434ssFuHroVfIpf1NSC5ve0/c6Sz+oa14nmC3wHhfrvmpscTSD5xzADC+CMaIiyb5ZbH4VskeDpXeu0z1750L03x1GgH9bO1CtPvj/I/yATJQlzeDAwfdwcAjPDA3SIjnjdaFMidPtcXFGz0QE3bYtBZYj8LE+YeRIsKsAmwcgdPshnmg2uBDJGEa6eCp3CLcEFQJI8IuvHSXsMFIWKmsmZ3aA6jWDzs9GezgcavNKFtKFsvLmfMJMDyfhciOLvCs5xswry6TYz60etWexoeOIsLYaV5aCEKsWWATZk+JhKDA18HpRaMJJPSK8ORN46N8lJeeTtauGMRFFqjignZNhqlGnUOjZn2w0YBNf1vlkQV+hD87+1/52wGj9bJXacMTehbvMRmp7OAAXs3kQuU37QfhezOiZSLQL+Tv5xqe7cYyzfcHDhl5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(478600001)(107886003)(1076003)(2616005)(26005)(103116003)(36756003)(5660300002)(6506007)(41300700001)(6666004)(38100700002)(6486002)(4326008)(86362001)(66476007)(66946007)(8936002)(66556008)(2906002)(8676002)(6512007)(7416002)(83380400001)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZJx6iYH0Ua02eTLwlCPAg80Cm1hxp7c9b53Gs/uCsk4r2BNpGbFzX7230Eln?=
 =?us-ascii?Q?vJvZEa9f6SvM2oel/EtvshzTPlTkiMc1oNm9F74yQo8Hr1L3COjuHL42odIJ?=
 =?us-ascii?Q?iCfd+0zNhAOspl4YsCo84SQMsgvCjHllKtvWaPVwOoodU47SdRfkVk5cFN6/?=
 =?us-ascii?Q?8fTDfxPpQP0hnC6+sV4O6zCfvILXV/2YC1/DtDdgcV0BnAHUdizcqZltyown?=
 =?us-ascii?Q?KhG23F774LVU1wgAVu4Isg4pEivxEW8d8JYmqDzKSf9JhzDq74Z3Ux7SzRh3?=
 =?us-ascii?Q?cJmZXGfRmuYXVoCLzjO1yLWQ+GSil+UQDIiOuwFY9xnRqj9G6rIVEaq/92RJ?=
 =?us-ascii?Q?JHJG2SbH3hy0n98YssAT7k72svebvDj/fetOJPCZQ/ZZ5jq2yNAQTe2O1awb?=
 =?us-ascii?Q?fod+NirfdqVJrIsNi0mA6dmlTYO9TRytAc4kHQNyYfvRSLYsYqfLsrBzw8nr?=
 =?us-ascii?Q?j5SdO72DI4JgF22yRqzBCE1nXlTpL9JV1af8B/lz+56OBF5jtsaGrSDBTXuF?=
 =?us-ascii?Q?XbUd2lKwXtLil/3HsUMO4GCujDTnr4TdxD39srwCPxDRZg8SIjqs6b4qAsC/?=
 =?us-ascii?Q?kQMu17hxZXkFzO4EFGRwcRvnOHXqbonFKSuYzQqB4uQVAQcSwYUK01+NtSCU?=
 =?us-ascii?Q?JcHObY/7QcWMQ0oB86fUZ5urD1xyw8ukMLYi+nIEI/q4Rc0T89DO9GKdSQy/?=
 =?us-ascii?Q?VaN4/m8g8y2igh9kkpdxt5i+eZIGjHa3dmTMERh4EPTgLCisSfPgFwXLeQS3?=
 =?us-ascii?Q?QRYaUoVUqH0rcaydJnboAQUKj4miV7lEDSUFa0v2Z7+AcIXCSRJUQqfmMTMa?=
 =?us-ascii?Q?DR3H0w9IZ3HxraQrnpPkmJN0oCDbnlcL+aCSagLBZSQtai8nJHDMz6ConqOe?=
 =?us-ascii?Q?tdbAfkYGig7ajWaL2s1Bn9eeek9ZgXSKXUmD0NLaljIQ7qIE8Vj6J9sOMegy?=
 =?us-ascii?Q?EQa9pzORVVD0qzx73D40mh/+B8HF1csYiVZiEOqVEbk4VHpJP8z2ojQgr3X5?=
 =?us-ascii?Q?xG1jl4T8vEo9jwBh/aRdF/dSfhpjaIbuwB+9EKz6FsF7/pQOcArm+EtGYaAC?=
 =?us-ascii?Q?rcNvWQoEop2mfV8DGu/UxHFz2WaO8+e+uHkFQbFaZ8lhGf14z+f1l2tYgUEd?=
 =?us-ascii?Q?1tRVw7ykKftsSVO+agM384VA3jNxOyAxormLaOFzk3grIwTRTILlJcvPDf68?=
 =?us-ascii?Q?mLQ4iHn2VEk4U3k8jGwg+OX4pGDVPUjrYz7FB/CXh0HlJs5zRm8NaQBzXK1d?=
 =?us-ascii?Q?ZNgU55iEI83IncYHr0BTydYe9Vn5RbQ+z8uCx6g63rckw3WShdhoKFLfhH+A?=
 =?us-ascii?Q?gTwXg8QqdsLwdtoXPgayRizXn2EK3NEN2zD3UES5CAfIHvWLy0Ls/lBoxAzS?=
 =?us-ascii?Q?CSUDCWWWThTvJ7dI2L+TGNupFUgbi686L+9esIHbLUWNi0K/uvn5uuwIPmHq?=
 =?us-ascii?Q?t32hkWr6kOKkij3M9eK2OgTLTash2JgJZhbOdbbKtFt2BJnW/3rUs8EVErST?=
 =?us-ascii?Q?UGGpqF4b1zZ6lay2y826JKysoLUAnvphGbkgNgQZHTdbbdES8Qi1cLg+yRML?=
 =?us-ascii?Q?PUq/UfliFRtskDm3Nd/JAAxVb+tsgTYhPI4Sh+FxpkKByqeVCyzOo1TEaGnI?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Hy7plqC6dZREWzOgccQOGZ3R4/z5sXDJ+kvukm0dIG+ixrf/SCaUkgeNM+Ot?=
 =?us-ascii?Q?+V6F1nvWjxtwMolnDGfVQcy27K5X9eiTa46Y3sjyOlJUy0ZUqm9Jk/g26hlh?=
 =?us-ascii?Q?HgarS/aJewCQ9woDF/K4eEPdKwvJTCds1ctV6YgiuCcTCWh/yY/3yAleXVvB?=
 =?us-ascii?Q?sXUSVDq7CWRWqgysbNRMqdqVGPLRYkE4+KPxmyglOH2CLfvR7V0+Sq9vCoIo?=
 =?us-ascii?Q?R64KVMDXigw0tFS+9/qO5K2+KsiDwsPRdDMJ3D8J2e4sNxwlzqBY05goMNo1?=
 =?us-ascii?Q?ATYaNVsUVwuArHJBQKBvXcsayXUUnWukDS5nACwdiBhNYl2PYp0efY4rtaIl?=
 =?us-ascii?Q?b4W8oZgm5/yiJuHS3In/e3ngTvclZeJ3ijUruqoDYzTHEJ73EJgX7ERsa5lb?=
 =?us-ascii?Q?L6frO7e/AaELyUOgBts0B8aV0689GZ2KrkzHzyFbtZ+QNT+4qAfu+Ra8KHkc?=
 =?us-ascii?Q?34IzQ/ud4NkEiPjiOP90y5BlkKol9fMB6rCIsv/iDcoFQWaf8Nc9HMt9t21d?=
 =?us-ascii?Q?BPxwS/rjoS6/vpsYKjLstuTWsTayvIlPW/F8ij66uDZIUZn7muPUmvYnAIc/?=
 =?us-ascii?Q?Jsu+Au3bfMi+tz2G2QTkn17ZsUDjF7BdX0VqV4+SHGqASgl2WtracowqnZAx?=
 =?us-ascii?Q?8+CApLpHl9odn7fIemst6wuCZr7UoA//DmUzp2/r3fZGGXerhR/p4LZRtPn8?=
 =?us-ascii?Q?7+Jlp2AyUu4znqCSIjdrRSD7t8opNAm2VY2m61IAS7pDhl6729cYoIVqn+Fn?=
 =?us-ascii?Q?8Xz82CvtsFjIhn7SlKBOgpK5OZ4kTXzaOmbKiXakTKSGcyJySN8kRqPIuRr4?=
 =?us-ascii?Q?BBEGOz/DVh2pWdkbDYCgdfsB0FLtQivr5tIzQLAHKS+XRPPHHMXctQ+vsaY5?=
 =?us-ascii?Q?wgVPmPk8BtD5WqjX6GkgpK9OymJ+/1poC2XrT0+0Ng6/tTqZDQHJeglUs24e?=
 =?us-ascii?Q?d2sy+4hWFEjTxjyrrEr294NpdKV/bAk9nqOXL/Jt3p0qD8rlvjT63LtfUoUn?=
 =?us-ascii?Q?f2yCpnRZ1mfkDAKfS6PEajdOxMHhMIDDqYJVOzesrk00PAjQMvt5hdZgOzDR?=
 =?us-ascii?Q?QHl8spWt6+ZneC+Ke2VJh7kMPakJnFcWKao+d06L3zBXDCa1OIB7x01SoYk+?=
 =?us-ascii?Q?f0y5WrgnATRV2q4yMmSU4mFeqnJ5rC5t+zjN1xTPACKn0FZfR2D4G8NXs0TJ?=
 =?us-ascii?Q?SniFRxAxH7nmOzJGKySzZACepuiQUx2oDYQ1ptQe8GOz+Pnnwf8SghLU+IUC?=
 =?us-ascii?Q?QVTJwKqgmUyx9vZcRVSUAowf5UmGNgKnN8snKSdMeBJCnslsypl80cvncHQD?=
 =?us-ascii?Q?ylQQlVmfnpUuq9PAQpqKewMTNmgRmOiZoPJlXT7UYdgWUg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c951f26b-56be-4cee-2bb6-08dbc4db1b3d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 13:09:14.1484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjCqAjBSY5HHxjXDhfL/nBwlv3BepfJLZJuNH8ZVKoHZy6ejycuY6Ga6rY5ad9XW20T8E2pzA8ehcpoBHku9ToFXGVyBjL0tiYt6xi/a92U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4168
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040095
X-Proofpoint-ORIG-GUID: eou5nZ__xfbad5mmSn9zuw31ZMBajUoX
X-Proofpoint-GUID: eou5nZ__xfbad5mmSn9zuw31ZMBajUoX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An entity is supposed to get an earlier deadline with
PLACE_DEADLINE_INITIAL when it's forked, but the deadline gets
overwritten soon after in enqueue_entity() the first time a forked
entity is woken so that PLACE_DEADLINE_INITIAL is effectively a no-op.

Placing in task_fork_fair() seems unnecessary since none of the values
that get set (slice, vruntime, deadline) are used before they're set
again at enqueue time, so get rid of that (and with it all of
task_fork_fair()) and just pass ENQUEUE_INITIAL to enqueue_entity() via
wake_up_new_task().

Fixes: e8f331bcc270 ("sched/smp: Use lag to simplify cross-runqueue placement")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---

v2
 - place_entity() seems like the only reason for task_fork_fair() to exist
   after the recent removal of sysctl_sched_child_runs_first, so take out
   the whole function.

Still based on today's peterz/sched/eevdf

 kernel/sched/core.c |  2 +-
 kernel/sched/fair.c | 24 ------------------------
 2 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 779cdc7969c81..500e2dbfd41dd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4854,7 +4854,7 @@ void wake_up_new_task(struct task_struct *p)
 	update_rq_clock(rq);
 	post_init_entity_util_avg(p);
 
-	activate_task(rq, p, ENQUEUE_NOCLOCK);
+	activate_task(rq, p, ENQUEUE_INITIAL | ENQUEUE_NOCLOCK);
 	trace_sched_wakeup_new(p);
 	wakeup_preempt(rq, p, WF_FORK);
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a0b4dac2662c9..3827b302eeb9b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12427,29 +12427,6 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	task_tick_core(rq, curr);
 }
 
-/*
- * called on fork with the child task as argument from the parent's context
- *  - child not yet on the tasklist
- *  - preemption disabled
- */
-static void task_fork_fair(struct task_struct *p)
-{
-	struct sched_entity *se = &p->se, *curr;
-	struct cfs_rq *cfs_rq;
-	struct rq *rq = this_rq();
-	struct rq_flags rf;
-
-	rq_lock(rq, &rf);
-	update_rq_clock(rq);
-
-	cfs_rq = task_cfs_rq(current);
-	curr = cfs_rq->curr;
-	if (curr)
-		update_curr(cfs_rq);
-	place_entity(cfs_rq, se, ENQUEUE_INITIAL);
-	rq_unlock(rq, &rf);
-}
-
 /*
  * Priority of the task has changed. Check to see if we preempt
  * the current task.
@@ -12953,7 +12930,6 @@ DEFINE_SCHED_CLASS(fair) = {
 #endif
 
 	.task_tick		= task_tick_fair,
-	.task_fork		= task_fork_fair,
 
 	.prio_changed		= prio_changed_fair,
 	.switched_from		= switched_from_fair,
-- 
2.41.0

