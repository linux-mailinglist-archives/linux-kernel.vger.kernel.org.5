Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A6078E191
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242379AbjH3Vpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbjH3Vph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:45:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FCBCF2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:45:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UInwQp013269;
        Wed, 30 Aug 2023 18:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=0CFuIMSxAiAQM8abfHcbcFv68C8S+dyPEtQxUd/f0nY=;
 b=H2ddvZEBlPaaRycR2QzhBh3qDFaS0XV/Veq8js5sITuJtXFJMv+tLR1Q4X1b0F1JxR0k
 XQi6T/Xz6daqY3Ypk7CGPrtx2byRBOPShj+6F/gXQX0jVHVB4tbirlMdFBWxyhB1ded9
 4iSLNBKOBJf07szxbD3cqIbqtB25relhYXSfNNgVePpG+uQFP2/fOOjmrUrQoyLxBmON
 JsZPhSXHga0GohX1OnVT+SnFRMlmzYks6tL9/styKKb8JKlNpYFIhu6Bgu5FcpBRqkAg
 A5/9ghV+ZNZaGGq1rWB3fwB1OSXfFq6kSJtay35Nud6a0ZKDBDyduNkfMzdv+3yoi1xr rA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9mcr5a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:50:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UInd6m014527;
        Wed, 30 Aug 2023 18:50:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6hpx511-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:50:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmyRVgTje48hquCSTrT9yJY3SQkDIayafsStvK/cn70EY89gcQpoQ3Qextl2EzLGC3bzdXvY95yBKRrGmgFKZiRIYaYBAG4evVnEGX1plSx+joGl5d73mrQHOcZURkj0Xh2Guyt5gW4ZLo7dGfin8Dgl0KUyG1vL4Ki3BGEBF3+dZO1pGH7CGfeT+wsp27qnyM7+I05I0KvxlL3h9BCcgdg/QZwhzlejK8twrMZgaIgRLLISPNyenn1dBYJfJ7VrdHuq+5tStWgmOaQ/xZoX/YQQ5Qfa/z+J2zt0yZfKojOcsaQ0/m/OD6KpoFx9EfBJhFLj/BDHc8rYPkg5kqCD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CFuIMSxAiAQM8abfHcbcFv68C8S+dyPEtQxUd/f0nY=;
 b=b6KKsV/ITFpnMG4lwCd4Ie2+4FwtaX6Qf+Du/0Zea9qxHtvFIrHgV4abON7w11PBJiUPT+NdgsLeQGOKmXhMH/IccpArqS2gmWcWIRPQ3rt3smXYkJiuKuXPKRrzWKwMAXQCXL8SmmLpGWKUkhOxpGNhhmdcQXZvQN6vqfOxhUdShieZaiOIHMaj/xVsLO03dqRogsdlNJEZFPdCZecDvR89Ly/WWQ2DXl6jj8il4P0QoKUtcHgj81OtYLuQn+sFeSHv1QeQ7D1zwaw1a2+7LlKBfhH4GVnNJa1me1AkKwCKVF48o+rr2mSm1El9RjLe/JiVBesFOGYnBD+GvFS+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CFuIMSxAiAQM8abfHcbcFv68C8S+dyPEtQxUd/f0nY=;
 b=md5Q25oBZoE75he6N18CNHPj01scRLe9cOwxe/nE/Itipe54yN0TY91U+sDn/X+TjFKSX4iqS6xgeIK3zfXMffU8/klbHv2l+1bkx/waEYAmpmZ6TnSTXXXpGGcDjwtp8JFpxbZ3BNub+zSn/dYpLjT1IbK4ZAdn8H8QCYEKTbA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYXPR10MB7897.namprd10.prod.outlook.com (2603:10b6:930:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 18:50:23 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::238e:5e86:cbd0:7415]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::238e:5e86:cbd0:7415%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 18:50:23 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Date:   Wed, 30 Aug 2023 11:49:56 -0700
Message-Id: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0373.namprd04.prod.outlook.com
 (2603:10b6:303:81::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYXPR10MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b8e4c2-af52-44f7-7b46-08dba989f745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lRl70Qk1TFTOZnxYSHzq7yJ+IdJYBeBcEtMPBK6AssB5D53UsG2GFV1MSKuCyAal6BC8F1YUxMP4VBgnno/Do5tozGABGw49zqK67ApigMH7VOUc5QY+xpfLC/2TLMsDNbQPMfh2hBoVf34xSH1CBjY5GPPV0ahO8RvtRbwNyJcEmrxO1E4OmrrYo1bmc/K1I9Zj2T0rcRfm7j+2OiYt2/QQUZHFNMppIu+4FqXWZJ9633eYXFC4LZxxaTnBpasIZoWiW01PWFndtk1hO5dIMQy6886xC9zIAnkMyRCC8/W4yYmBDS7T20RIT5ryPRu9KtVdf21qxNKhOe1r+CRyjFckD+Vai9DcVeMW38VWgmAAQudJK4pg5JIli0vSyvMUI9rukI4p1y3zr6LUx/5eyvMV85js1x44/70dV072hVp2C5MiAt1hFBi48c9+4BOQCdBTs6BWVHhBXgDdgQuqUTB2x5vYnzZiU0PTeOZZB5Upk/G0B9YHbtlHXutNyNh339MHFJPzSsVPCtbJpV/3omFdUq8zpfzcLkVHSZmblTCNb1vBevLe63s1futzZwj7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199024)(186009)(1800799009)(478600001)(38100700002)(26005)(1076003)(36756003)(66946007)(41300700001)(6512007)(83380400001)(2616005)(54906003)(66476007)(66556008)(6486002)(6506007)(316002)(6666004)(7416002)(5660300002)(4326008)(8676002)(103116003)(8936002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nmdBHd6KbfrGvPQSPYgi6HsVB3YEwN84lduLRI9ClA/+PkzFzsGcsGjtucJA?=
 =?us-ascii?Q?Aqg13I1xCg5VR5t9hpd2LoD1eOJm5qykKAuB2kdpIv/yWINT+8e/PkrPMhc9?=
 =?us-ascii?Q?1C3zR0vQHg4zwy01VjG2DDAAIil8QFrxRhX4CtTfQiPCWOzZ681W5cIF3E9H?=
 =?us-ascii?Q?TJEPO8heb/D65T+Xvyag0LNni7sc8nU5UkFDZReL4lL29ykz7LHEqXgjvKPf?=
 =?us-ascii?Q?kUrUjadm5J9yt7fF7ZThpWy4nwol+m6JaXpepLVZORGIdcnUEdFUkSma9t7S?=
 =?us-ascii?Q?FlsWxdA7zWV96wPPmNBjak0JtyR+zy5DzZEPbe4LKll+sYaumqbQ0idXlBpf?=
 =?us-ascii?Q?S7l0o/Il4KiLk8b9Jy4DHEiftxz0/8BPXpg9e4hHiRekCixCb987ygGdnmdf?=
 =?us-ascii?Q?bm3mZHq2tpRBGO+geZitjTD5HfnLA1rmJjeC9cmfbnSja4pH47bpKQQaldtu?=
 =?us-ascii?Q?0UFNkrmPHl+ibGBIRdT4dqW1s/XK0rmH9aZtHqL+oTDN/SgHecxno2g3ieFC?=
 =?us-ascii?Q?w6Sv6YAYazIxYIEQVbBMTWTHYa45/YTWfUthscHGQnnujD83n1uK3I0uv8TD?=
 =?us-ascii?Q?f1gYCGWSyQ6vSVj44jbLAFtVW/kUKcsk8qz10dL6APokMPPtAOFznNR9rZSj?=
 =?us-ascii?Q?Jzu0AfXsHXXOj8VdMz+Cho8lzM/JDARS7fDR425rMRbNPqdZUtO3b9HeR632?=
 =?us-ascii?Q?65FpZn9uGZ8Rjguu4x3Z6fJdyK9H3BN1zdCp1NGAfaLH/Yf5NwmvaUdHyvJ6?=
 =?us-ascii?Q?oKFZBPx1JROTfn8J2LIoAfi1DuefrWee6q4hLYQOHjU+8t0Oxs1HCYjGVqCa?=
 =?us-ascii?Q?Cf1/aGfGVNv+DP6CsAMwP+Vmku+4LSo6a74IQy4slYKRJhRlKyGjKFPcLMK7?=
 =?us-ascii?Q?I3EkqbYyFXac0MXw7bWvXjLoqC7h1vbYWuOU+smzEgyWG0rAldQZQwL2xFQp?=
 =?us-ascii?Q?539OIVeIG3DlMBX4CPYtg+VuA7cPJi1SjdQgYVfbzzPcbNwtrOSIiN9Gl9Kf?=
 =?us-ascii?Q?62QM+HNmB9R0N5WOg2lcmqHrgQIdH1R3NpFKI2pp7g+3lQosuHacxr9zBcLt?=
 =?us-ascii?Q?0tNgwtTO9FL2Qpns8FTCNYg/QSLSj5sMp7khTFkb7eYKN5eYNb6K45KBda77?=
 =?us-ascii?Q?3jNeLASlh2DiR13G4jiTiqQEJGFbE9hHLPb4eu+8idLC1M1grJ6A4r4SqThz?=
 =?us-ascii?Q?tmLYlc0y29+643yTHkBICMrxGRvulkHM4pfapMWrWBqUoEEqPveAXjNnHves?=
 =?us-ascii?Q?RekaGq4mZZfjuMNkvbt/lY1mklMZ39WaVogBsBtQTJY5qT1081YOOerIMqDx?=
 =?us-ascii?Q?sqeq9VyP5SMSA3dFrGdBIvhVgFAaoJDGmtu/njv6BL0Z9UpTDSAkb5nbOk/R?=
 =?us-ascii?Q?2JOqHDxH7wPx9t/pVcFV0SH+U+0BPVtlEoNEkPpNNQ9y4msPjbJbNFyOPdy3?=
 =?us-ascii?Q?pd5yLRIs9uajx+UzCkxun6owTBWYzj98I5nC9dxrCyI4Jte/1s0+OQFqIblK?=
 =?us-ascii?Q?Jx0FyaBSuW0c7+APIMh84L8LPSUVoT+3n0XPEm3Fo4TbYbkzEGz00Cvv1kv/?=
 =?us-ascii?Q?PfhI1Ne1g6ktSeATCztN3i95NUA/jQoLapLopkfbagiziSjWtbTCkiDJXFpB?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?kg6rMERIKfjGlwQm52+bAhJ6uapRFWZ8SL3ULoO1xyHhMtj3WFldD7kBxGHl?=
 =?us-ascii?Q?rh7f3d0C/oqPQv8EF46A73CY15xvXNjZRlq+amSGWCQ+srIy6kimGLNQpEMH?=
 =?us-ascii?Q?fIUxaDm3cnRbbqK7CseR5XvVBECOi0ijVsd6PtDlmRt1vuxXnzdcxeLtE842?=
 =?us-ascii?Q?B9sBMPgiQW63aTiIsfdQSX3/YTDJavkYwLgcKusxFjloTlCv7WDxbbi+yHla?=
 =?us-ascii?Q?9x1LI8BYLoAcYxbcDKaSZLCwFh/oqEK9rikAU6ERHNaN8l5B44ZJeP4B3bfu?=
 =?us-ascii?Q?I2XC5li0PNmFcJJSF+glmKfwFcbIig9JbFlQIRAkGF/8qZsQH43/el7CD29+?=
 =?us-ascii?Q?J6vsHTfRILob4Ze6d7Yq6J7CCe4uY+4NZFtVamWxUxpmLTF0mKRrcaJVAGEt?=
 =?us-ascii?Q?P5goSvKQiYB4RwGtgGPA6gBYl6wXplMGTYHVLIWkoptlgP2p1H1Bo72oXxne?=
 =?us-ascii?Q?P6eIs+BqkgOm/ANede1LB7OGNUhsSEzOZ5+z+/rD+1De8KCKPshTI+1C3E8D?=
 =?us-ascii?Q?J3rQnkEVYgnztEccKi7yLtJs/giD4f7n56bXzt4SB4zlHy0dwBTYsfpM22tA?=
 =?us-ascii?Q?MjMIHbwlnoA8TGgnTFq3T7RXWUoeIqP0mH3hKO+hfpr80KXAXRxTJPcREGf1?=
 =?us-ascii?Q?H7KYVpTXuJ+3kmUc2fYYs4g/f3iVC+5xfqzzpzxRstPKdrHDdphUW4uU1s0e?=
 =?us-ascii?Q?ZaNLhCypE/QV4GYz+NcoVeWP030TJQj8UAE1R6+pLC0tU+pUV9BAxpXejaUz?=
 =?us-ascii?Q?Hyd1xo1XzccWyqBnCbU0ukraQVChZiwbQnfEHRw6CmO2tHHmsybjXSrdQzeH?=
 =?us-ascii?Q?Nf/36vEvOsKHkjEpMUjltoQ+QsDomSutUD3gwYbr7y+CXbWIavDzYqZsoXXX?=
 =?us-ascii?Q?o0OGd9OeG24X8iT4jwgB3X2QqrpwARKxuWujmBdyvhWof2SNpc4/XVpyPLlT?=
 =?us-ascii?Q?nHx7qulbHH+xZaxRxq4hSqOMw9qKJh246Gr+xxcc67I1YC5PvfjoEb4hp9ft?=
 =?us-ascii?Q?4yrcvGoRt+cU8XANFW5cvpsVBqKqi2QUFHWrJMQDx5JzgO488RwOREi6qhAS?=
 =?us-ascii?Q?DJJkGi/O+4Ssv1CuOm5Pm18MkMZDm7kip8tAAIxnMxGu8qEIJLY7mENv3POG?=
 =?us-ascii?Q?JAkhh1WHShmqXzAWJWAca0Ykczvj5a7twqt+dLS2BbAJZhXw26WCbZQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b8e4c2-af52-44f7-7b46-08dba989f745
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 18:50:23.0004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiA87hyir+IIf3x+gRxj3JGnMFruFf/KE7nHJNJZqoHhYusqt/gmozUg9wtnurEkc5CnjNXBYnCuU5mkrwC5VASwSoX+slkEb5Ei1u5uxtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=997 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300170
X-Proofpoint-ORIG-GUID: J0hZYB6_6RDZYMCLXaArRS4EvQSaBzX9
X-Proofpoint-GUID: J0hZYB6_6RDZYMCLXaArRS4EvQSaBzX9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On preempt_model_none() or preempt_model_voluntary() configurations
rescheduling of kernel threads happens only when they allow it, and
only at explicit preemption points, via calls to cond_resched() or
similar.

That leaves out contexts where it is not convenient to periodically
call cond_resched() -- for instance when executing a potentially long
running primitive (such as REP; STOSB.)

This means that we either suffer high scheduling latency or avoid
certain constructs.

Define TIF_ALLOW_RESCHED to demarcate such sections.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/thread_info.h |  2 ++
 include/linux/sched.h              | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index d63b02940747..fc6f4121b412 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -100,6 +100,7 @@ struct thread_info {
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
+#define TIF_RESCHED_ALLOW	30	/* reschedule if needed */
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -122,6 +123,7 @@ struct thread_info {
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
+#define _TIF_RESCHED_ALLOW	(1 << TIF_RESCHED_ALLOW)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 177b3f3676ef..4dd3d91d990f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2245,6 +2245,36 @@ static __always_inline bool need_resched(void)
 	return unlikely(tif_need_resched());
 }
 
+#ifdef TIF_RESCHED_ALLOW
+/*
+ * allow_resched() .. disallow_resched() demarcate a preemptible section.
+ *
+ * Used around primitives where it might not be convenient to periodically
+ * call cond_resched().
+ */
+static inline void allow_resched(void)
+{
+	might_sleep();
+	set_tsk_thread_flag(current, TIF_RESCHED_ALLOW);
+}
+
+static inline void disallow_resched(void)
+{
+	clear_tsk_thread_flag(current, TIF_RESCHED_ALLOW);
+}
+
+static __always_inline bool resched_allowed(void)
+{
+	return unlikely(test_tsk_thread_flag(current, TIF_RESCHED_ALLOW));
+}
+
+#else
+static __always_inline bool resched_allowed(void)
+{
+	return false;
+}
+#endif /* TIF_RESCHED_ALLOW */
+
 /*
  * Wrappers for p->thread_info->cpu access. No-op on UP.
  */
-- 
2.31.1

