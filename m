Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C187E4F6E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 04:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjKHDXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 22:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjKHDXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 22:23:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B4A18C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 19:23:50 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJWp5005429;
        Wed, 8 Nov 2023 03:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Y/ma+TVxMg5TyzLp0yxypyh7G3CZZGo4VUFyqZCLhGk=;
 b=OHtqhYac33pRrd22aMolZIaASl4GA/j7/YmBZJJITX0hsLaNNgmLbWqPUhvZNcJnrd9U
 z5SE+sRIkqxynyLu9cDqb0ZudxiGIC+fglC97js6/6wsK+Qie5Yi7Sb6zyKp0Hqwxbqy
 ltYJnEZD/32kLtr15gI+VgCbdyqVjtcby/rtymUC03guUzQyYXSqotxYro88T/IC5knJ
 uW7eHcrHBHfQ0jPSrldkqXXrMilQ3sFC95c0ZX9YD757OHyjCwmS1eR6NZPgoFEPgXl8
 oBoeCW8DLdetJDynxHnxn7adglCZlLrE61CZ94/KfbS5RwhUEYprj3fH88b/o3k9KBFw Bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23gfbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 03:22:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A81F4Vu003959;
        Wed, 8 Nov 2023 03:22:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1w38cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 03:22:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFzng3fnrjDmxfGfEE1DF7W/BmCSiPB0v+KeNt94UuC8CRdWms+U/WOsXtp77XCerPre9cwxJGGViq5Sz33zFELlPJ6L+UO4j6SOyNmxcPWlMJmin1kvImngMx5pTafMLWyd8bXBQyEGYvE00wj1sDDFoaiFtSV0paEQs/852gmSA+nSEzfZX6sGglbGh3PwCZMbxbfHe3ZEdjSQtZWRTOBDa9WL7S0CH0rc+yGMnW2CHgi6Yg5SCtYtpbXEWtMz9/GzzrpyNYv4EVhXWDR/4y2h9F5L1w2ut6qoSHvhJI38/qcwQc47sKKYhIlwry7da/ITtpUWrFb/1ZfnnQgHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/ma+TVxMg5TyzLp0yxypyh7G3CZZGo4VUFyqZCLhGk=;
 b=e1eo8ylsqlYUq7M39tgbevfAF+RdhMWSH9zyT8eTL/RHDIu0hkUQAOhxWpExx8TYk8d2fkjmlg2mGk4K4P6FiqgJJKbXBXOKw9v3Yb3eeFwoCAaVmAjrp24T/3Ra6TfytLMfWqSa/7Fsoatszdg6/b0uVs4VZtG9+D4yaNAkdIjdGayAtjLj4A7Yz5s7vt05TEvmO0XANQ58jkbGYRCTLvmizOQx1E3z0DcZiMipJoX6zyZfD7vrUXt1PKNQGfIa8c/9lOa1TjEw7eycc+Qo3FOlVhYDhoXxgYotIzbIDiobrjUONpIx8veHJBihBhxZiNsF22O9202Z9ZOEy9/8bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/ma+TVxMg5TyzLp0yxypyh7G3CZZGo4VUFyqZCLhGk=;
 b=Ql9zuo/LhC78PXzbSNJNEUtsfdl/d1lUk7FG3yxvwynvNrV4xcU0g0jgDeHctqBmGAQmSkMmexZzqi6cFED0uaFvUt0K0h/1U9hUSzZJo+Y7T3pBVSpTq+E1RVaoDScqapBxrNoNleYlOHR3ZNlivAVF6pwIKvhs8/vGwvQYKl0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB7117.namprd10.prod.outlook.com (2603:10b6:610:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 03:22:48 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0%6]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 03:22:48 +0000
Date:   Tue, 7 Nov 2023 19:22:46 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     riel@surriel.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, muchun.song@linux.dev, nathan@kernel.org,
        ndesaulniers@google.com,
        syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [PATCH] mm/hugetlb: fix null ptr defer in hugetlb_vma_lock_write
Message-ID: <20231108032246.GC41505@monkey>
References: <3382634358afa9b95dc4f6db8a53a136d4b9e9cb.camel@surriel.com>
 <tencent_164A247533766D667C3D873798968236C409@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_164A247533766D667C3D873798968236C409@qq.com>
X-ClientProxiedBy: MW4P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da1eaaf-5d23-4261-b4e6-08dbe009fb9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5+0gxYOxdXoVA+S/TIEPrwAadNcTM3WMAMbPw7NU5aLVanNybjM97wfN7+Bb9CAuksTZEe42nF1yP7a3fTyit8Kfk0G2nOxZuzwZpqHQ1h31IuofEb69D68NnjRnA44V2Y5BZy/Ews5kLUNwTq0VccxmZMdfS6sEUFRA2oyHX/qLmzrDEsr0gfOuG/G3MhqX1YZjWtLlrNNnFHbHOFBe1zeFFRPCejRNj5h5E5ToPEGZ/rxporeICFKe07YYqw0+FCLomMw4lln3+u1E6+64GNyT4T9xzJabwXvytUNOQNSOjbC8aAOM27mCMrfsnmc8K/trOhugAjd9uBr8NIM7tD9aYzH+n/JX5dPtTHYXwEw1dEDgyZ21RgsIi1H53Ngo4tIluxrbtSBi2CoDdid7ACYVAcgQFqi+zH8TdsDNPMabzogEKnJcSzjOj14zulzh9BN6ZB+Rg+Xp2x+cz3bd6JlsmBP3SPqAxCO+SrL1qhW23+pICDXTx4q/MXiNBv1KtfD/zKSQRYWIbhBoPjqu+K6H1/Y+Fp3E6c7SyvcUzCeUyeK7Qjl8Sfrd0ozdaGx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(346002)(366004)(376002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(33656002)(558084003)(41300700001)(66556008)(478600001)(6916009)(4326008)(316002)(66946007)(1076003)(66476007)(8936002)(8676002)(38100700002)(6486002)(33716001)(44832011)(5660300002)(7416002)(86362001)(83380400001)(6506007)(26005)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wTJGh10ec4YyGdqIdJ/VMRoxnjevZf9RPmRn0MsF6aOJWcu7TDhRUW9UWRmC?=
 =?us-ascii?Q?VP+qePqZLrme0Ljv0DAM5rw/GzvXTPmoPtaA9kcuzLmINuwYpAWfgExpnJMn?=
 =?us-ascii?Q?HvDOfk2lp3pyY6JbETyid73id66Fg1q5+RfX8k5zwQEBNgY02rcGbVI0HOAo?=
 =?us-ascii?Q?PxQm9c8/eodqoqJciO6mr4SVHbPY1RpWgsIaj0uV85ThLQkp9mG1e8aeCH+E?=
 =?us-ascii?Q?fHyUpjwzJRxRC3WgsplcMza5aequ3g+mmFRCpcgdq4GpG7E19Umfj8FVM0l5?=
 =?us-ascii?Q?fv4oe2dCfEzVLLMblf/3weUKOZ0ZSVpAprdAESjkQpSwzmJRe9IOjVN1cEaa?=
 =?us-ascii?Q?Yd5qeQtZVEYEM7+40/y+5Ra//Ppn5H7m4NFxlbiLveMIISI3hz6RSH/9kWVN?=
 =?us-ascii?Q?l4dUXhNRm33FYFymgwnIxSUk5VHZ4s1VrCyZbuXqUNpRgbl0WmxTk25C57RK?=
 =?us-ascii?Q?NUN9cxkRrszwwjepgRS6d/ChHr53c/gMD/4ES71xopC1kab4XDaWIy+UXcAy?=
 =?us-ascii?Q?azsrqtaKRk8NeBftdDQ0ThvFoE0WbjjTneqU4SB/MtutNvaMA+XBcD3yV2q0?=
 =?us-ascii?Q?9CLiNJWD0XP93Pu/UutB5LsZ67uJiUpTYIvrOK9uvzNDcKXc7eDdVMKQSkr7?=
 =?us-ascii?Q?meDsGvgLqGZICpttYGAOuCTvb8psvN85tz6djKxum8U3u3qOlwKS57Vwlgsq?=
 =?us-ascii?Q?0jpICaEjt7ynsCj/umUcxYx7zUglPwzUPQtx02XxYLq9koRsPA5E7g4jszI7?=
 =?us-ascii?Q?itdfoJvoRmj3ZR7W4C9YP14bKXQHFjeUqIChkZjc2flaFfxZ2Y95kVfSryCD?=
 =?us-ascii?Q?8TrI7SmK8JSlhezLPktuF4k1tFnkI4QmA71IMpLl7eDSjzUxQl8DP55lUMfu?=
 =?us-ascii?Q?SkVg/lllq74nWWE2o9wmU3rZI2Qt+jBetVwzCrOwMeTr8xdUBbg4bhIPQZUY?=
 =?us-ascii?Q?y5wT7Cv+92pySKOivE6T/19Vk2GfywckU0dpplQiuh5SfgRvR6gJCvGT5srM?=
 =?us-ascii?Q?oVhcwbzWy6ciX9Wg1LcJ67rV+nvntrUeRKBGkHtdlKVhCvNXxW0A4HVROTJQ?=
 =?us-ascii?Q?knmvjKwVU6Cd65Yhl8uU9/fhPbUMxOyJJSbNFtYVIzM+oMiqI6NcHh+mAlJP?=
 =?us-ascii?Q?koA9yJ+phK7chxQ95PSTLj+mu7lQ7uxTB6BTmBUzYLLBe+IsHneCZqD+IArL?=
 =?us-ascii?Q?Eqj8MP01Tu/8aL1HNE+2hSXlgppJ4JDYWyrBx8j/aJUHyLUTahWMW4fuOffd?=
 =?us-ascii?Q?80R7ueGyCjNyNHJl2d3UKRNwEB/OTeBbLtXLoK7YF9tPsBo1GA5bXkIL2dOu?=
 =?us-ascii?Q?0pP7uRpUmcC77MFjgezhhyjiAV9rAKYH9iSLah+Gr+NNbHZT4gg/MofGHzUr?=
 =?us-ascii?Q?+KGHM45pQB/SxtO0rAbvfVCduxc1IPU4zpja8JomADcJxDoIzR7BhBKevab2?=
 =?us-ascii?Q?dVig1M9K1LTX4+PSN8gHzk1TlABmh7V6Ke+wR7XdzxM/8EO+hkYZisnQUsOZ?=
 =?us-ascii?Q?VYvr+Pd/Bno1xg/zz1fAckc5VRYuudHCfNUAg3p+Bw4cyGO3Z3JYsbZWty31?=
 =?us-ascii?Q?sYKfkfIPGw3v55dxv4HizecDBr33n+DIBmjIlHXFtt33lj547oRLIXRRBUyi?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?efcdtadKeN55ybGAw0LP0dKRkk1yzGlJfsKakMA24OjnozE43JDJiOU4teHa?=
 =?us-ascii?Q?+qxWwajVWpNm9hXFqCZM8DO2ZwChJlNkutVu0nX8y7J8An92nVBk+atobEds?=
 =?us-ascii?Q?kHz+OdkHBIWfxIE4i7efw63aFcyai1w+UDgJcdQQmG28rYSHah9K85va3+hz?=
 =?us-ascii?Q?le5pX7dAe6FvFqYfl/597ihnjIY/AAN7Xm2zlTUWrvb72DVXbspwV/+8fJL2?=
 =?us-ascii?Q?mqz4XeY4Fp8fNnDBMHDa1TydjZT2p2NvRwe3d0V+TTiv0L2TRRcF+WO0hJ/H?=
 =?us-ascii?Q?WbxPpnv5hMOPvppWOWaDf3yuZlRSDURL52FKPvuD2wNQNw0J6Bs9UCtW/QQc?=
 =?us-ascii?Q?1+zJsdww78L5nQqVNodZ0CtD5U3On7xQiEjIvXvt+don59+SOJVRVw9ycETF?=
 =?us-ascii?Q?AXlw+WRdSjSkQJ9z0gmZp1aWVBkM7B03D+p5/0EjHAQ5o9onhhsNKJsJFXMx?=
 =?us-ascii?Q?wlJ+QmU1c3RKVmM5QIo2VkYIEuaLXQMXrl29t+8/11PH9HNDfErfJdU7M6JB?=
 =?us-ascii?Q?i8r7zTyDCET5DdmVH7/7Ev6CpJC3xwHZGLoPcATj0gqWtUPkBn1drQ3svkXy?=
 =?us-ascii?Q?18vs6kRGbv0robtkU8c7JYWF4FLezP2Pn7UETZ5Tt7kz0OgL8XT1/N7wLhu4?=
 =?us-ascii?Q?pX+eWc0xl+7ELCusu7sYQnIrJD8tqNuPC7qZszgLcGs24koAWIwnUyipRM++?=
 =?us-ascii?Q?aDpQwbZFh4btRvbYi2OseVNby4ZpCNj2hB+m18GvCfHcYF6JKOOOn71jCbbd?=
 =?us-ascii?Q?RMXdl5urnxzr5NcO0fZinORDqbC1uI0RujELkbUs10FXTvSKT39ZkPw/9GyY?=
 =?us-ascii?Q?V4N9+bq0ZagEiUtuMy0ToTKmOfc85lBra6Lh7aZNrSojiiaSNedAyF14w24z?=
 =?us-ascii?Q?VVjHr44fynbmD6xH17d0IMWGkaKXOOtkNAI2a936On3DLI0458D6TYUYzwEC?=
 =?us-ascii?Q?pcO5OqUnNp47s8BO//fU898Jo6Q8DwSr1oDXr8ZQpX32IOizEbgr7gq+PLwL?=
 =?us-ascii?Q?/eVmySGPbUOXa13NZETzm9ufBCXptBAE2CiuBhkGFNhLSbtikGgJNt5asufr?=
 =?us-ascii?Q?IAY9tP2UPbd3T5sckMQddQlwWQXz2dDe/kCJyAyKsQJn9CrlNYgAMNiGCx+8?=
 =?us-ascii?Q?O3Rnab4MoeL3TZSBxSVPmZ3Tcj0xk2KCuLXzQMOd9sA/sRqnIb9sAdM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da1eaaf-5d23-4261-b4e6-08dbe009fb9c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 03:22:48.4949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJ5dsE0MhBOB9h3s1IWjJd9AartEQYDB5q+iM8Zti8Kt80g3H/t2Mfg4cAYl/70pGQVd2V51oRLXTwrq/2UuUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=540 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311080026
X-Proofpoint-GUID: pgZorAXomQkF3lizc6EOBWqvCX9SwsrE
X-Proofpoint-ORIG-GUID: pgZorAXomQkF3lizc6EOBWqvCX9SwsrE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Edward,

Do you plan on following up with a new version of the patch?

My suggestion would be:
- Move __vma_private_lock into hugetlb.c as suggeted by Rik.
- Change __vma_private_lock to check for NULL resv_map even if low bit
  flags are set as well as HPAGE_RESV_OWNER.

-- 
Mike Kravetz
