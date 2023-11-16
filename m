Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3787EE5F9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345040AbjKPRcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjKPRcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:32:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E14C4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:32:43 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGHMxga026344;
        Thu, 16 Nov 2023 17:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=pbgyqNBUEKqXbLccAmW5IiD9LO//VhKSTUakfSjU8us=;
 b=nyoHm53q8XzGEiP4ORPB0NeEe7G29e24xscCe4YakWvsimMlFCk9EvJw0Me+k3XuN5nB
 OOw/DJsUAM/a5RNu2pUDGHjVilsQ4nVigxzsthV5djHoNqyw25f4tL6CY0kENAMmAx7Z
 JAqg5/uVHx6vKUQ/n4DiOkO5klm87rWGEm98bEica57oMzcwKCyynuo9YUTuVU7MEDMx
 sJwSNKKrAhWAYs0OP4zyKsCOrUxFzF7ck4Lp9hXcVRchoL/c8Dk4ClnrohCUdGz8gTu6
 LEAihkRk2wos6XR6oXAV0xKwn+44ZiPlB1HAuohQASAb1gZoyKaoQJ8bxsEVAWgUny4v MQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qjup28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 17:32:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGGV301036936;
        Thu, 16 Nov 2023 17:32:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ub5k7867p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 17:32:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPkOs7fj/63sBDD91daeMNmVBHHmLdjMWCVzpvMCgk2LKsGrn3Vd95jaHVqiJSBzdtjw1qk9Mx0Z+4207awskApx675s4SqNm1TF8j9JsJWbtSwbBthD94wKN/QMzJWhu0XtH+RvytCa3KstzebHxmvw4WUHcvvXmuHnfj2GIGRiCBwODwphEl1eG30U6DV4H35aPetIOR2EWdqDAYgpX9o/kgn1cNYXETA0W3YQIv6a9F4GqKaJxgqOj/OaoxPM8EC2PRR0A+oZ6FhfeJoChRf4fuZMDe3kZh7q9H5rftgXU6cyHeveyz624YcEb+B774mPhnbuAwrWpBR0yA0bXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbgyqNBUEKqXbLccAmW5IiD9LO//VhKSTUakfSjU8us=;
 b=EI3e2/XFZu9gEfzgO0AwEsFZfrycZLPkchhYyl4i+4izBqbquaXFGB/h7viRDpHtSzKEWqT/4F9fvFzCSAsEeXFKNY9A2evQKHrWM8cGZDE8h8af1Wm6wSVUCZWY2gTKBgrMnlgqTJUyJYCNRo8XHUJnBKtGVgC25y1FQ9FqKQs3mePva8wf/bfy8sf/mLOtk2v/pDTbXFaUy/O4DT2lW3dEvDiEDl53QDaCnRKhTKMwgWjGQDlPqGhvuYWT+xyYH36UqHYUwKAhIEnbA8/vmMD3P2xES6ihADkYtLwM9yWg/rg2IlTC3I0YLppKm7Fufp5JJygwR6hiYrNChtuONQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbgyqNBUEKqXbLccAmW5IiD9LO//VhKSTUakfSjU8us=;
 b=G7DqNb4RnANzFDl65KP2gbvF6A3sH8tzi/43mhc6rFaapDdnLMQJEcSwZDIzxng5E76VhbCkAN7q37VbpJ/VvLpANBgfufWiV71LslVs2294KQbrHHG1UgHuKo2ozuY6YrTWW4TExgdW1ongal+1I7wKz7rkrZzCxZ8Vm9USVos=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB6715.namprd10.prod.outlook.com (2603:10b6:610:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Thu, 16 Nov
 2023 17:32:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 17:32:19 +0000
Date:   Thu, 16 Nov 2023 09:32:16 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     xingwei lee <xrivendell7@gmail.com>
Cc:     syzbot+93e7c679006f0d4e6105@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, muchun.song@linux.dev,
        Nathan Chancellor <nathan@kernel.org>, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [mm?] general protection fault in hugetlb_vma_lock_read
Message-ID: <20231116173216.GA7883@monkey>
References: <CABOYnLzpDMPd3fJhi38N_jcQS6ZSa8RNik5j_APKQYNk0kJRkw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABOYnLzpDMPd3fJhi38N_jcQS6ZSa8RNik5j_APKQYNk0kJRkw@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0321.namprd04.prod.outlook.com
 (2603:10b6:303:82::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: a14b14ae-24a7-456e-6997-08dbe6c9fbbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ciyzpkmkbqRhD8fFGgu6rtkH0HiTXzF8oypcVeon43pidgyXWK8xsgMsy05L9c9kJstsna43m8xsi2qdcd2fRfdYWHVn7Wm5vgGsQgGYPp3qNAQdAQQYRG79m5x27chTyqU0dcpwSHb/Cug3sFtGpmb/VTiYgsHNEpAgORW+FA9y8UJauvvd+6IJsGk4fQ5P+E8+8Tc6fixf+P8lZSvWH8psNBNH1uIiDx6mt2Qo/lWvGCH7CZtPk1oosJK+IQIBK6h9Fc9DaNWNnin4kyoiobLqjdUecQyvk51COEM5654JyeyCZJkAMxMhwIMuEki3ZihRv5ELNBBnkyewerTGAQDg2nrjmP2FY49zPwcSDMJn+c2O+TC3qH9MmSxrJGw5nfd1Jb755F6U1UjFZQAmh+qC1gAWHLP3J5XbMSSTaH+WXcw9peOyNTLGC4ctcZrsmW76DMf1tqTpA2T37A0XeiSC6v3Al6gXvcI0hp04Li7UwuDzeQbw+GRNEJhOP3YDYg2XNugkNV+smhSRdqgWQZBWCb9bw1ZuSrNvFCOInI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(366004)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(38100700002)(53546011)(6666004)(6512007)(33716001)(41300700001)(83380400001)(6506007)(9686003)(1076003)(26005)(44832011)(2906002)(7416002)(4744005)(8936002)(8676002)(4326008)(86362001)(5660300002)(66946007)(316002)(66556008)(66476007)(6916009)(6486002)(966005)(33656002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?urn8AzUmorxU0hLDWLLbwGtmVNIfyA71wFiQvRUdHacuIAxK1pNCw8RLEFeX?=
 =?us-ascii?Q?RyO4Bn7bGl4/dUDMkdd0jgfcb3XONK63Awye7vcGPcHwHNr7oxvEaXzuHwhq?=
 =?us-ascii?Q?aS5h39qsmxDX+ZtT0s496nIpfoJV2ezo8MXWXj+TUGStHMO4mZhb1W5+Mt7V?=
 =?us-ascii?Q?lB+QA+90ticTgKCGpCwyVdry8t87FJBlopESvOJhuEFLQzhaNoBXdVISf5jf?=
 =?us-ascii?Q?9VvrXjIbss6BZkPc3r8Oiz3avi3XYGftbFxm3HG+QVOYES/LaoltlBS3iiDC?=
 =?us-ascii?Q?gR/MWk+qejI8dCHP+u2cYBSvVMw6XwNevBDYZyvztfYIWH/VdKCchf7LxCO4?=
 =?us-ascii?Q?CpT0w2YI2Bq+67ECXAXgLqCsHF6tCrSuX6oXLWl5B/CYGH7TkcP2ZV7rTDdL?=
 =?us-ascii?Q?adrsbfYXo5XBqhJDbqcc9H8eHIJe9VwT1MIfA4k78L0bVPKsyft/vBIJZwgd?=
 =?us-ascii?Q?4YRYzQMRpqLkVOC7SwvICA4Z9Gxdd1FPpsoiz+2kxmCifuF6gNBp42Ww4Bic?=
 =?us-ascii?Q?PMFluZiobgkudvgbbquT06aUc34f+ACgHYwmTIeq7l6psZ+aUhyvB0xms04p?=
 =?us-ascii?Q?T8CMOtJoY4YQ8ZgtemM0+nj0P49N3U3/5JURGqqKSrIJ1wi2xUgeb2eiEf5N?=
 =?us-ascii?Q?yOb879UnHnftU6+kWRNtn8k7iQTL936kUsxzjIqJpZYykcrYQchDAGblYKHs?=
 =?us-ascii?Q?qulBBYpGRs994xcTsj+bIBrKwPsKXnlpVP2jSP1vnyDQXjqYUUjDFAq9BvHb?=
 =?us-ascii?Q?IDl2+ffjNXFIs1/sWJijz2CfCEd/EKHbCjZvOV+CQl3Z+FKyPg78OiPT3IHe?=
 =?us-ascii?Q?f9KkhYBejUuiBV5e+UyQI63daSDAROYqvNMVjHOaeXuKcDqv4ppM/W5rOcpv?=
 =?us-ascii?Q?kmT5oYe335i8azh1fytwa7gSveAzax8OdYH17YGGyhJ99nhkfYZ4oiKYTDHw?=
 =?us-ascii?Q?dewIVSSqYFhlGWG303KhUURoy5v4jG5l/fbubWAfJ33UU8pDKhcCcKEstmiS?=
 =?us-ascii?Q?oD4gsJuKjrO/QnVuOqANRXvWiv7rFUUcHofhE6hBEpAKhtIAx0TtCf8ShjL5?=
 =?us-ascii?Q?Giz8ceYlW+ewcChJ6Xcx29UF6HP3frdFoVkon752afhpDMLpJo9XG4g9ExfU?=
 =?us-ascii?Q?yf5gl7xtfXHPBOLt+dJ2W+n/HuhN8q7axrHQXpESDHUJwpNCaDQWZrhaNEUc?=
 =?us-ascii?Q?h4qhqG9w229hQ4fLEr1YJAOvwcl5jyXHbz46BF0HpG/+dkgE53bJwYmZf3+8?=
 =?us-ascii?Q?MKMRz/EcMdeiEhEtJruSWlAcv1m45GnYIXcjIA7FbgBdETorxl/A6nF25Xc1?=
 =?us-ascii?Q?FmL2H8ZIQfdu6P+HOwbXiBC4RoSIwhHRJggiT8ZPwFa0eoqx4LZ14Cc+Hb/v?=
 =?us-ascii?Q?E4/YXJBIes1xjHC1WbA8n7vYmqchTpkkUEXWgvc4eiA/WNEpKDWTjnruj/uq?=
 =?us-ascii?Q?9BKft3Vw4DnfX3nfVIsrG1eWOhIOQnETT8KKPo7a6Rh4QYS8lqCq+NZRKbiU?=
 =?us-ascii?Q?K6qo2iUukssDt0xxdkdOdUMt3vyqzQSqfj5hQ4bVw9sqi7nzG29goU98zcKl?=
 =?us-ascii?Q?eZh8dOFNUOSRCddqXRCm2Bj2fh4XE4pri6SEB9eg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pFOX2yoRkkCZRuguJ4wMgW6KeMmvjrRytnXq92B72lVnDznPBxyyZ1b4Cwl9?=
 =?us-ascii?Q?rS73z1ugtMTSyN8jwDpiU/EmZr0idsfgVI9jMgg45X6fMY3YOTNmenukymTV?=
 =?us-ascii?Q?wbXGRHbd02BtRwFTeS2++5Nj6SqSApGYBUAcHt4at0Z9M0YxKLYnkDiPSuYP?=
 =?us-ascii?Q?7EIT3xb2OYhSr4pKmhVzoKO42y++djKZpxIp9xqM4dXOuckDomVN+3ixC5Kr?=
 =?us-ascii?Q?h8dAQKEgsggXww4EFLF6+8d3Hcx+VffwFHKThaKz8V4GhOBWQC3aejGqWfcJ?=
 =?us-ascii?Q?ojkV3rEZo3LALzvzqrABiUniNzzipunJtfKY6OteFp5K8jPLWV8Nq1F7KuwB?=
 =?us-ascii?Q?BORTChXOHmEODj9gwhNB475IhxR4zsOU2d3olu150Oaw9/x+Jo8S5Fgv25eO?=
 =?us-ascii?Q?5iM7vNbPNce6n7UNvqkFG1/7aUZSgUzQCs+tSYnnNJfqdTkvcxL04C46JCp2?=
 =?us-ascii?Q?xedkRIDielQJbWnhsRVlAoxj8WnrK1umL07Niooy9VNzxa10LSYabeX7m7l/?=
 =?us-ascii?Q?CxwbeG+7RsBiXcLoxMNohF1SvhGdVIJtYYr56aVNKoaG8v7FVYefGAv4MUlb?=
 =?us-ascii?Q?3qCtPhUS70J27yF+zCaa8vgXB33Q+48JJ7roFGX8+wKDeOTonRofYf1bHXsr?=
 =?us-ascii?Q?bW0LD9+6/q2VllaQ5b3Tfx7+okf3EWdjhsYQRYrolknuUF+nTSn409JWHS4I?=
 =?us-ascii?Q?uxui34eN4E42KlO0ITGSPy6rrr411zC5vfXPAw89eEqYhn2tffTG1cgfI307?=
 =?us-ascii?Q?unAv71EVKiekIhtkQDxWOjYivk4V29Dzp0Jzmh+LxxPqQgwJ2VmOw/uXiu2s?=
 =?us-ascii?Q?idAYqkyd9izqUV03P83H94OBzeV5Kgl02pt2G83hWzUbXuhc3ja8FJaluHEX?=
 =?us-ascii?Q?h2sCQHUoRLFKjvzjtTzT73e5NXsS6Fny+NqRzE8rMDYBSrrorS9FXP4qKi58?=
 =?us-ascii?Q?eGyxZeqx0OFv92owsknmyD0Cx22sJS9IflVU+TvF36B0gfz+VUVm6+3KyRIY?=
 =?us-ascii?Q?BTBdNhWwzcMuPBGz6ih2ZrAVedPNeYcv5LqBEXLjFKnkRNre4CF9cPxRbdBo?=
 =?us-ascii?Q?iIRlxhB0Me5PldiSQHuwY1FJCjzfk40b7iWpmqCL/FmhgaBCMHAK2Y+7O7pD?=
 =?us-ascii?Q?gOhX8N8phW7QS+trz3AjekYuLUPyzebmGw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14b14ae-24a7-456e-6997-08dbe6c9fbbf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 17:32:19.1605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HscHnyLP241b43Sv0+TxPc+LxEhwH9LJVHkkU4/G6CTzsW36JbvSSKN3Ambq27IonIrGWalN6AgeLX/m2ibm+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_18,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160137
X-Proofpoint-GUID: Ksz4E0u7JAwgvOgGmjsyByygKROZ5GAA
X-Proofpoint-ORIG-GUID: Ksz4E0u7JAwgvOgGmjsyByygKROZ5GAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 15:53, xingwei lee wrote:
> Hello, since I found there is no reproduce from then to now. I try to
> reproduce this bug to generate repro.c.
> Maybe this bug is the same bug as [syzbot] [mm?] general protection fault
> in hugetlb_vma_lock_write I guess...
> But no matter what, with the reproduce.c, we can quickly fix this bug or
> check the correctness of our fix.

I am not sure what fix you suggested for this issue.  The following was
sent upstream and is now included in Andrew's tree and linux-next.

https://lore.kernel.org/linux-mm/20231114012033.259600-1-mike.kravetz@oracle.com/

I tested with a reproducer previously provided by syzbot, and assume this
resolves the issue with your reproducer as well.
-- 
Mike Kravetz
