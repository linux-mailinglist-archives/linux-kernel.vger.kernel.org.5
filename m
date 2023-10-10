Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06B67BFF9A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjJJOuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjJJOuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:50:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2567FB8;
        Tue, 10 Oct 2023 07:50:03 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AElT59021625;
        Tue, 10 Oct 2023 14:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=QlZjv0TtgssmZwQUqHuSxCtQ1gAhVY69m0S30vwLtJY=;
 b=wkSaXU5kpLsjN0em5fOMT6nMCefUf5glsaUBYi6+bHT6Bn0v3kymp7bijDqx+wvILXCN
 cdIKRbR/K9M/8HAqfm6lzIhjA/MSr5IfzZLm33wk2tz+DbX1iepQP9fnYR59kkoBwIAt
 GBcCDolixXAvaVpv5QhN9fHnUQWj4SpltYUfxoGU69HInqzt3J1dCrau6hu2fZXKGj0J
 RwB70raN9K8fB1eIoINb3Y45S+OCjpdgZJ7ebTfpJhg27daBs89mw+HH/6Nklh3uGzY6
 DArCL1VS58ZClQSGNDB73p039Bqhrg3SetzgvWcmbAKuJ3eZpVIeCFXYC7THbmbVjyHu Fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjyvunbv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 14:49:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39ADnSYO032125;
        Tue, 10 Oct 2023 14:49:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tmfhq350y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 14:49:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgSoDd2TGHHNZ4wVGDl6kOowwfh/xki8oHuOJbpsHzhC6cFqlG6jJBhsDKK5BUiEL8GjApz3EZ7LphbiFksCsTC0zHMwj8eQIqkwoJQZtga0H5UgZIXjt0EvDGLyvSUAgk5YjrM68iVCvjWKv/yEyFY6VzQZSZMuE0phrt+17CqI12v9afwTZMRxv+WP/FOwxh/KCcNsDAkQ75amJ2vPYibmqhHSJZIq0rtxLhK4OcA3jzv/pO3rcsYhN/HCCKAWtgfHIOqHDckmSK9nrDCTEMqXCnYcxJMJMDuNTDosp9EmcuBLXzEFgRGkAIGEXjWoYwY9T92TJ7czNVYvpqtVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlZjv0TtgssmZwQUqHuSxCtQ1gAhVY69m0S30vwLtJY=;
 b=nhRFNe3WHiOqJF+0YIVVLyrvGdra/YDehjkQ9VQ9hc6HdSLAB6pngyjrNSeTQtZHroxBM7R15dLudU9u+C3iy+D8LHonC1NVNzBp7ePeLXxmTUBYSAodte9suKYWGO2rctYL67GiyTufTRMHuV/DWSaxn3KwSuFQtOqMezn4hDtgdBBjIq5UHG9K5CpSGY2YD0aX1dk9XLqxoJHn2JMZESNJZiisBS9ELnoccIUuksIQ9eF+iriChaWxRkp1J5l7fYSI38612bs3wNzcsEv7HVlM59lAgeUFmOkJk443QbA4SElZY7zZHTh0J6v9aoFWKRfvcimMi8Rd315ur0dT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlZjv0TtgssmZwQUqHuSxCtQ1gAhVY69m0S30vwLtJY=;
 b=CI9lHIhq0h/KlSSMybTsOOBu+yUIEpMXy2Z9PmIGfnBem4ATTfajB+oVXmqi/qaZagRWdFgXUZe5qeEX6nOdowyQsS+aKTs1R1jeeBA/cvH/R4Y2tDLaVwJD8ARzicbcmDtOFa2EYAdnMZna2U5qHZ+5brT5jtmM4TneqxjPrfY=
Received: from DM6PR10MB2969.namprd10.prod.outlook.com (2603:10b6:5:6a::10) by
 DM4PR10MB5991.namprd10.prod.outlook.com (2603:10b6:8:b0::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Tue, 10 Oct 2023 14:49:30 +0000
Received: from DM6PR10MB2969.namprd10.prod.outlook.com
 ([fe80::30f5:7e54:7ecb:83ff]) by DM6PR10MB2969.namprd10.prod.outlook.com
 ([fe80::30f5:7e54:7ecb:83ff%5]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 14:49:30 +0000
Date:   Tue, 10 Oct 2023 10:48:38 -0400
From:   Kris Van Hees <kris.van.hees@oracle.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Alessandro Carminati <alessandro.carminati@gmail.com>,
        Kris Van Hees <kris.van.hees@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Eugene Loh <eugene.loh@oracle.com>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Viktor Malik <vmalik@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5] scripts/link-vmlinux.sh: Add alias to duplicate
 symbols for kallsyms
Message-ID: <ZSVkRkf3DNyxb7Vw@oracle.com>
References: <20230927173516.1456594-1-alessandro.carminati@gmail.com>
 <ZR7jIxh/VNT6tMVr@oracle.com>
 <CAPp5cGThN5bKsGAqiVwOV2w4tH1LgjS3eoAgucaRwty4d8JVSQ@mail.gmail.com>
 <ZSU2dTTfLqIydSQU@alley>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSU2dTTfLqIydSQU@alley>
X-ClientProxiedBy: BL1PR13CA0401.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::16) To DM6PR10MB2969.namprd10.prod.outlook.com
 (2603:10b6:5:6a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB2969:EE_|DM4PR10MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: d7506abb-2ff4-4c16-c3d1-08dbc9a01c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u884iUAvB77ifw4ZbKYHQ09GLZY0pysejy3XsxtrZ3dRjVy/3QlUHMPyfTJF3NMyhvozXC4GaByAEktDAg5cO9x+vbg/MDiG97iKHUc86hIK82LNxaNVgP5SaXopXDAqhxBuXKfE25eLeIHogwWKMstqEb9iHaEDTriTVQoLzecM4dWgkc1ypp/UzcoEDslQ1hD4XoVP+8CQOoi1QzXkmKI594WkHHNDFx+sojUUtocImL8EssofJYdbzBE/hsS5Uyv22vW0aFylhql4lCaw0PHwZoDT3EDwq5NKAhA+EOJE/CTArT5L2zbdDcwqVIdKCDAGx8KcMcsKz7ySik/SwQLoyBAdN+xRd961dnM19C73wJl7bDebfAdWHYP2zExo9Ul3GCmg8l35DdjmOKA0dyk9Snt9kqem+zy969gro0/xHgfPirrXTBx9o5k/4bVxXMb5O29KdkooDJ8JCMCFAWjfPCZYhZtW7vOi5dpSQR2GV8tnhSz6Bp1NXK1iuotfK8pLt5QzfXpMt7vp4Ftrgp17RYDqwrQPH0WOpuaMleI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB2969.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(83380400001)(66899024)(8676002)(8936002)(66946007)(4326008)(7416002)(41300700001)(6916009)(66556008)(54906003)(66476007)(316002)(478600001)(966005)(2906002)(6486002)(86362001)(6506007)(5660300002)(2616005)(36756003)(26005)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OEms38wEAsKyQ7R++CXW/NlyyTFyy4rrvXVOhZmotnwbXOVlKDeZvx12sMKD?=
 =?us-ascii?Q?fPZ00sgpj3Zq9ElYebhigprbLbBdIGVblplPz5J9yHTFpL440nqzPrcEil/c?=
 =?us-ascii?Q?/nrdw58eyIfVFRop3laHcXZffo6s4emmpqxWHZiDyrLmI7zTQD7LVPCoSkqm?=
 =?us-ascii?Q?Tp506/tAxFpEdc0N3H9Y+rqCVzvsNCIfb4kDu5gEfMYyv9PIOwVez2cz4ail?=
 =?us-ascii?Q?bF8dWWEYxY+6QmUCf0h9fgA9zzyA6WZs0RzkIzP8eQGab2aLuUocqOKlI+LR?=
 =?us-ascii?Q?T3xWBqWzdtzSN2/zvYhkhBHn4TsyADjzcytgGsQR7U50PA31lKIBmdSuLCGs?=
 =?us-ascii?Q?a9fUohEPtVMP/ACcZTNRhiGB9Ytn4AXg16w51DPLl4RJopjdGNuFk8dcWC/Y?=
 =?us-ascii?Q?KzRrZoGSULpHFIvs7G8ZvwOlUhxt/utyh9hX3Dhr5mNNB429xMPosUKB9KHZ?=
 =?us-ascii?Q?qBKNetaDs8SUzqTVpLUr8qNQf8ezPQL1uK1Rfq44Xy9vI1jfeXOz5BFg3hR9?=
 =?us-ascii?Q?Lo2Zadcr2bS2+b00XrZPRqwo/JlOCgi8MEWInp/X2vBtFYyn3j1kBGnFc+9y?=
 =?us-ascii?Q?k6QSvgeZ9c7NzGM5UU6p5nJT8tcHMw+O61AksJXupKQ/m5KKNTzCROe2MGp8?=
 =?us-ascii?Q?M2rli4NLRgm0lR5yojtSkk1uKD8Iqo2G+0mkHjYJMxt1RTblm60pEuIKq312?=
 =?us-ascii?Q?rpIGho/zmGRUhEWhn+5Txrj4cqByGBK1JQkye1B/JEXSKQhVY067bCk0hSDj?=
 =?us-ascii?Q?pNoAdoid8kI75spECdoD748tNPZhcxFmVXluHQYY9NLeI7HHN+14kwSdpNGX?=
 =?us-ascii?Q?/C9Nx8OzeOfxDLnLbwCJD5RG3J/oaKlcEMXfeJEbR0Ba41COrTJfGcIzYmqL?=
 =?us-ascii?Q?xd+Q0hCkaBpbhcqjaYc552yNP1Fr4XdD2QtCr1u55Jc2KT81Pq/MLd1XTffK?=
 =?us-ascii?Q?ZDlvJdtz3gJ3lPXc+GDGgTGjRHqamMcyMLbZJS5WS8t8H5ngwS49qhtjtBOP?=
 =?us-ascii?Q?x5YL2uYxUXSekC2a2hc2CMg4nGg2fwkZEEpK05z8Aapx0Nh9niSxs7Q+n2Yx?=
 =?us-ascii?Q?32KzvKHSsKOyreOVv1WBPQqCuNLtbm3qEkD5FnhOwICrRRf7nqkgdPvZttf7?=
 =?us-ascii?Q?8Q20CZH2QCf5Ks7CWd7PD+lBRZjbS5hGPybTgb3n/0t8z5wh/fzr31/+7Mqv?=
 =?us-ascii?Q?WahYXLknuwKbdG+jTx0FkhcpMPTcflG4djuXuQUQ9ii8sQqur6DQNL0pHY9X?=
 =?us-ascii?Q?CpvlNpwBR3sziwd99gvP/UMBDDLs2SzYJILLbNYEgYOcaaXPo5yGrKynhwJZ?=
 =?us-ascii?Q?IUBuFq9X31WeQ8sJqoZbIKkpXflDLzwed+8uUGAo7r1Ly83zYFI8HxyijJG6?=
 =?us-ascii?Q?DVJEbj2CQtxvuuwXo6WS2xJJG6gJB8ojjDPSJXtGVCGzTYnQA+JqJWEM3uWr?=
 =?us-ascii?Q?e9z8FSBi0O5ffvuJcbJK72Zruk7hKifk86Ed4m1m13EAfXMFOfL4H7uxT3JP?=
 =?us-ascii?Q?VzHzR1E0JpPRy0UDTBy9ydk/LQXk/em9n0+9rTP+pLx8piKSWPLq/itvB7Ni?=
 =?us-ascii?Q?1tfGEkI0JkPXuuFir7HZXjY9FfN0AVOEU3GMdoDyAr3N1VOuH/rm1d8/STSe?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4DTlTsETIC4JTky1dd0WpKsm7h4HzQlR5kItGm57K9itys9qNEQ0nJEpXsaf?=
 =?us-ascii?Q?Rvi6M2IcmDV8C1ARSB0RfZjld6w4YuKUVgbuuAmMhzAH9FGJdVpOAzNfN4x/?=
 =?us-ascii?Q?XrUmK1RJ62YlJdfOycyAhHHxNGESvbC97uzi9st1Fm2Sod7yNE5VJOIl+wcQ?=
 =?us-ascii?Q?Z08tSwjWvTJPbLFqFNc+K/zQiMVHqVUc8ofCo1rI3+MSJbwqgNbgMy1xJ6xv?=
 =?us-ascii?Q?zSIPmLp6cl+NSR/6VQAxaS7RzhTQ3PbTHvMGWJFpXVVqBA6UfM4THkQACDbm?=
 =?us-ascii?Q?7vpsq1WPThymT9/wGPGUnIwL3Uzyy6jxwOwki/vHI7Mq7NybgWwzmfEMkyWM?=
 =?us-ascii?Q?kJ6FV7mwiB5ivDZFjBe+bAYLAi8Zy2QJip6sUpTLzVd2lEr1qyT8F2J9u5tp?=
 =?us-ascii?Q?bmEIaEm4aOfyjWOHhs0rq3BP1TNrXN1tIrBntCJdaMGI8EVRYHGezozm7dGu?=
 =?us-ascii?Q?1IUp9iMokTjDLQ4JOs11mTNdVT9SyDCfdzbXd1OsIY9Ksg5acvjvzxwe8ByT?=
 =?us-ascii?Q?1IKcy0FsSv5Ia6E+Z5OKdbeSfRdSx5/8yRQhfzynM/38YcZQoIbj3ooEMJqU?=
 =?us-ascii?Q?GdMdxIyAOer5CWA+cFF0cYP2ZyZ9eE0tmpSbRx/IHUKvkSAvscPflVmCyXX+?=
 =?us-ascii?Q?xNajERiVwR38C+WVi+n3S6R/J38H6is8KueOHJcEtBUcMKI3wq5XhK9GiqUD?=
 =?us-ascii?Q?hBCAhLc/G7nUHNSNYIRFTQ8ludzWECy8fYZeqWdvzWzonadaVrLL1rs3g2v3?=
 =?us-ascii?Q?NcZbO1T/+yQdK+iCs43qPyHxlYElcdVl7C/Yu9PD1dxVQlSIOuwM408nF2XS?=
 =?us-ascii?Q?jqUwd9dL0RTpsntNqTxZbXBZTnKAnDWuuUNPsQkhsBGmpZ/zGJXuKNB7/aPv?=
 =?us-ascii?Q?CwmpBmcV9J4xjL6twsZARk4qiS+2dsnuN8MhRPLMhgDzU27JldRp/GKKxNM9?=
 =?us-ascii?Q?h/UxlVtSIDTZUiwR0ur4ReqQVq4yqwuuhHV8TVnBjfpSpmCz6F7tKqDDoNQi?=
 =?us-ascii?Q?9Ea8a1H7/Y54Rqia574/wAliCOWFYiSCb29jb6g4ZOpoEPI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7506abb-2ff4-4c16-c3d1-08dbc9a01c0f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB2969.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:49:30.7297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVPrSBe3wqe+V0Ma+/optbYjDnwMuUEZyB+eBljhAzFXUDHb9VMGBhIZoyQ99y96pycthL6yb2PywiL29O5XSmndpnsuFj1xt5Qnj34vH9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_10,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100108
X-Proofpoint-ORIG-GUID: 8MWE_WZNQOzAdrUbvnvZK3DBQ-_X6lt8
X-Proofpoint-GUID: 8MWE_WZNQOzAdrUbvnvZK3DBQ-_X6lt8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 01:33:09PM +0200, Petr Mladek wrote:
> On Mon 2023-10-09 15:14:28, Alessandro Carminati wrote:
> > Hello Kris,
> > 
> > Thank you for your contribution and for having your thought shared with me.
> > 
> > Allow me to begin this conversation by explaining what came to mind when
> > I decided to propose a patch that creates aliases.
> > 
> > The objective was to address a specific problem I was facing while
> > minimizing any potential impact on other aspects.
> > My initial consideration was the existence of numerous tools, both in the
> > kernel and in userspace, that rely on the current kallsyms implementation.
> > Both Nick and I shared the concern that making changes to elements upon
> > which these tools depend on could have significant consequences.
> > 
> > To the best of my knowledge, Nick's strategy has been to duplicate kallsyms
> > with something new - a new, improved kallsyms file.
> > 
> > However, even if Nick's patch were to be accepted, it wouldn't fully meet
> > my personal requirements.
> > This is because my goal was to utilize kprobe on a symbol that shares its
> > name with others. Nick's work wouldn't allow me to do this, and that's why,
> > I proposed an alternative.
> > 
> > As a result, my strategy was more modest and focused solely on creating
> > aliases for duplicate symbols.
> > By adding these aliases, existing tools would remain unaffected, and the
> > current system state and ecosystem would be preserved.
> > For instance, mechanisms like live patching could continue to use the
> > symbol hit count.
> > 
> > On the flip side, introducing these new symbols would enable tracers to
> > directly employ the new names without any modifications, and humans could
> > easily identify the symbol they are dealing with just by examining the
> > name.
> > These are the fundamental principles behind my patch - introducing aliases.
> > 
> > Il giorno gio 5 ott 2023 alle ore 18:25 Kris Van Hees
> > <kris.van.hees@oracle.com> ha scritto:
> > >
> > > On Wed, Sep 27, 2023 at 05:35:16PM +0000, Alessandro Carminati (Red Hat) wrote:
> > > > It is not uncommon for drivers or modules related to similar peripherals
> > > > to have symbols with the exact same name.
> > > > While this is not a problem for the kernel's binary itself, it becomes an
> > > > issue when attempting to trace or probe specific functions using
> > > > infrastructure like ftrace or kprobe.
> > > >
> > > > The tracing subsystem relies on the `nm -n vmlinux` output, which provides
> > > > symbol information from the kernel's ELF binary. However, when multiple
> > > > symbols share the same name, the standard nm output does not differentiate
> > > > between them. This can lead to confusion and difficulty when trying to
> > > > probe the intended symbol.
> > > >
> > > >  ~ # cat /proc/kallsyms | grep " name_show"
> > > >  ffffffff8c4f76d0 t name_show
> > > >  ffffffff8c9cccb0 t name_show
> > > >  ffffffff8cb0ac20 t name_show
> > > >  ffffffff8cc728c0 t name_show
> > > >  ffffffff8ce0efd0 t name_show
> > > >  ffffffff8ce126c0 t name_show
> > > >  ffffffff8ce1dd20 t name_show
> > > >  ffffffff8ce24e70 t name_show
> > > >  ffffffff8d1104c0 t name_show
> > > >  ffffffff8d1fe480 t name_show
> > >
> > > One problem that remains as far as I can see is that this approach does not
> > > take into consideration that there can be duplicate symbols in the core
> > > kernel, but also between core kernel and loadable modules, and even between
> > > loadable modules.  So, I think more is needed to also ensure that this
> > > approach of adding alias symbols is also done for loadable modules.
> > 
> > To identify which symbols are duplicated, including those contained in
> > modules, it requires exploring all the objects. If I were to propose a
> > complementary tool to kas_alias that operates on modules, it would need to
> > run on all objects to ascertain the state of the names.
> > Only after this assessment could it produce its output.
> > This would entail postponing the second kallsyms pass until after all
> > modules have been processed.
> > Additionally, modules would need to be processed twice: once to assess the
> > names and a second time to generate aliases for duplicated symbols.
> > I am uncertain if the community would be willing to accept such a delay in
> > the build process to introduce this feature.
> 
> >From the livepatching POV:
> 
>   + It needs a way to distinguish duplicate symbols within a module.
> 
>   + It does _not_ need to distinguish symbols which have the same name
>     in two modules or in a module and vmlinux.
> 
> Background: The livepatch contains a structure where the livepatched
> symbols are already split per-livepatched objects: vmlinux or modules.
> I has to know whether a later loaded or removed module is livepatched
> or not and what functions need some tweaking.

Thank you for sharing the POV for livepatching.  That is cery helpful.

My follow-up email to my original response shows an example that demonstrates
this remaining problem...  a loadable module that contains a duplicate symbol,
so this issue does pop up (and is why I raise it here):

# grep ' metadata_show' /proc/kallsyms
ffffffffc05659c0 t metadata_show        [md_mod]
ffffffffc05739f0 t metadata_show        [md_mod]

This is certainly a harder problem to deal with because of how kallsyms data
for a module is handled, but unfortunately, there is a need because this
situation does occur.

> > > I'd be happy to work on something like this as a contribution to your work.
> > > I would envision the alias entry not needing to have the typical [module] added
> > > to it because that will already be annotated on the actual symbol entry.  So,
> > > the alias could be extended to be something like:
> > >
> > > ffffffffc0533720 t floppy_open  [floppy]
> > > ffffffffc0533720 t floppy_open@floppy:drivers_block_floppy_c_3988
> > >
> > > (absence of a name: prefix to the path would indicate the symbol is not
> > >  associated with any module)
> > >
> > > Doing this is more realistic now as a result of the clean-up patches that
> > > Nick introduced, e.g.
> > >
> > > https://lore.kernel.org/lkml/20230302211759.30135-1-nick.alcock@oracle.com/
> > >
> > 
> > Personally, I don't perceive any specific benefit in including the module name
> > as part of the decoration. Please don't get me wrong; I do recognize that it
> > enhances clarity in Nick's work.
> > In that context, a human can easily discern that a duplicated name originates
> > from a module, aiding in understanding which symbol they require as it is
> > already for duplicates coming from modules.
> > 
> > However, when it comes to my current implementation, I don't see a compelling
> > reason to include module name into the decoration I append to names aliases.
> > Please accept my apologies if I may not be taking into account any obvious use
> > cases, but as it stands, I don't find a strong rationale for incorporating
> > module names into the symbol decoration.
> >
> > In any case, as you've pointed out, duplicates can arise from names in code
> > that is not intended to be a module.
> > Therefore, relying solely on the module name would not fully address the
> > problem you initially aimed to solve.
> 
> >From my POV:
> 
> The source path and the line number is enough to distinguish duplicate
> symbols even in modules.
> 
> The added module name would just add extra complexity into the kernel
> and tools parsing and using the alias. The tracing tools would need to
> handle the source path and line number anyway for symbols duplicated
> within same module/vmlinux.
> 
> Adding module name for builtin modules might be misleading. It won't
> be clear which symbols are in vmlinux binary and which are in
> real modules.

The merit of having module names even for symbols that are in a module that is
built into the kernel image has been discussed before and there certainly is
a benefit for tracers.  Also, it is easy to avoid misleading information bu
making it easy to distinguish whether a module name is for a builtin module vs
a loaded module (e.g. Nick proposed {modname} vs [modname]). 

But I will defer that topic to a different mail thread, picking up from the
earlier discussions on this feature, and proposing a minimal patch to make
this data available in a way that is completely independent from this work
(and won't impact kallsyms data presentation in any way).

Thanks,
Kris
