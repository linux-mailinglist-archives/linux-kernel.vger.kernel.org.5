Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DB775B704
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjGTSmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGTSmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:42:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B1EE44
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:42:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KFEiuc020431;
        Thu, 20 Jul 2023 18:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=hbfOgu6be0WCI6H6CTTXN15GPKyTLkKQW29/NGBLmHk=;
 b=ZN1Wl2anwgaYgDNKFLuQCz938gE9BNnXUORcyE9QpF5u+5S2dz3Hyh0/CGJ6y0cv9zbA
 HbsFiU/VgP2zw6cKDZ5Jxty6zcHeHaaFmn3AtzN7x5HOG7j9li/agdddvAHCeogWs+y0
 ZnY6hw0CdS4qmGz5r65IyCzHtB0xyGetrSyfDoK1WiTowSHtNT2jpbVVg+skBSTYAEBK
 HSYVatQYKKIxHavCTFtodYHdLiwpIL0ZpnYuK7kTsyNF5CKEaoAgv1hgQVr+5gB3yjwH
 N9vAGLnZzWJeNiwXXbcB/b2KM1KFOLiIiELeILVwv+dYny6jqvfE4J0OQ2levgvdqA+J LA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run782f1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 18:41:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KIMZqd000852;
        Thu, 20 Jul 2023 18:41:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw92qp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 18:41:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtU0VTBRIjkIguQNi+gVCviO73wX9mirAEwQuSt3t6/1pkni7JnCtjKmCw3a7riwBjoOc7mBs34BvbVxqHkUSvzqubu4sjHJPj+lBC1nsBxfUuAlPp8d11VhKAW/N9a6o2LFCuc3D+jWoO9J8y1hQjQXdC5hZQ7A/rKpCabZUaslT/4CdOxJBRkDfJb2BtNxHRAqQrowOyS9qXhsjJNoYHBt7rpFZxy9F1ftYi8tMFOZk74fLtHegPjXX+RNXYX/Ki1seid0iF6sqlfJDWQ8MPLv1nGMrSGdfywLBHKk+RbprQuksorCjnsgvfjle6/L0eyJ079ZkMShMgSNoc5XZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbfOgu6be0WCI6H6CTTXN15GPKyTLkKQW29/NGBLmHk=;
 b=Z6flTUi0oUDDDQ9mfOvH5tv5D24/CBTHp24r1KPbHQfu/7qMLspiL8AoA3xx07sWqLEqkOWaQ8p1UX3WhpFrkX6spsuT6LfkhlTykWLpb9IDIccMYxrOynIPplFNEWbhasQuk5BJe84fNiNz4TtaUvRtYr/D7H4W+NvkptjOlYSSJacO80obB8hus+MqIDbjB8MdQnCaD/iPFwd8tycgudcnv5EtH7nf8Q0h26jXQuoRfQ6UxQ9qiPpoljwXtLdMGTnb1AlA6gVrNQXX+ePh/4CFJmau6pCTUr3EHx+BdZAMuPoQQzFIVUU8rQ++JLfFGh8Nnoc0TYwSVuIFmrO0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbfOgu6be0WCI6H6CTTXN15GPKyTLkKQW29/NGBLmHk=;
 b=myvaMZonu0/dNSObn6Bfe1e4M5D6mo+YYYSML82ncU0NKjQFBiMzizzWuNQF+hIN2wDvf1bVweUcX7kbS/5jtqz9lP9F0d965ku8+W1IbrzgJNT3qmjrD+LQMWfWqwG+H5Keym0khmi8MRDwL0FecrGGfhlitclFPqIY9uDbHm8=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by MN6PR10MB7466.namprd10.prod.outlook.com (2603:10b6:208:477::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 18:41:51 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a%4]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 18:41:51 +0000
Date:   Thu, 20 Jul 2023 11:41:48 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Linke Li <lilinke99@foxmail.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        dan.carpenter@linaro.org, Linke Li <lilinke99@gmail.com>
Subject: Re: [PATCH v3] hugetlbfs: Fix integer overflow check in
 hugetlbfs_file_mmap()
Message-ID: <20230720184148.GA3899@monkey>
References: <tencent_C2D6865561F23A8141BB145149ACC682B408@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_C2D6865561F23A8141BB145149ACC682B408@qq.com>
X-ClientProxiedBy: MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::28) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|MN6PR10MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: f15106b1-db37-4362-8bff-08db8950fb73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJp4hhU0PTIGAEaHB4Pmo79Jz96Vn3MQHFjuYZTt/m2u69S2snj38bUHRB1HVQhAvnYuDYXmJgXpChb2EXJvwDHW0vHxlrcJWThecPKi5hLrwuMDUSOavT0OMmO6mvFoY7ujhi0Q0FOPAY9GkKYxGyQCCl5238IjW26tiQUq9DZR0jlp1VGuCit4ENaqdWAnlIRuNMn5/oR0X0fcs/LLfzh7cqfXVTXdT2CwOQF6AVjKGnGuyz/TiPwaby9XRhhOPnRu64HqeX41OTX8xiyoGfViKFyBOrdblolvU8TZ7bKq6q/+dwYY65kYlzPL8pIq8xelzWdVSBCEy7YbNg4pS/M7LjcpgZJncmF5gudOXVKUdwyPMuKm6BItrRWxtOxvF3M03dcofXuVmtAmldBjFarokOOJHyWLfPESe9GQowxJAjtp+BtuARcf76dwZaT0QpL0uFsGICp5NLaOwweZKFfOl/1dwh4i3FTGPQZEOo1nBJ1nLXWCaB/SQWTSvD7+y71JzTuTvyDuDDHVHhj+6oybW38LyG1i6/eeqNavKVhrChYzEnOzmFnOI4p7Dt32
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199021)(6666004)(2906002)(6486002)(8936002)(8676002)(5660300002)(44832011)(7416002)(9686003)(6512007)(41300700001)(38100700002)(316002)(66946007)(33656002)(4326008)(478600001)(6916009)(66556008)(66476007)(186003)(33716001)(26005)(6506007)(86362001)(1076003)(83380400001)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?amk8ZozVqN3P0+pc/FYbQLrFquG8JBtBYyCVKS8k+04UL0WhtIV7fpm+PuMY?=
 =?us-ascii?Q?3nlGjStv1LTr+2xFRo0j+KfrGUnSe9eC8/KOMc80IEUO7TLVabe8CNQqIC36?=
 =?us-ascii?Q?WUucu52Jc4i40GdSevBs0Z2PmB4yXf0SwCxa1s5hJlbG+Ig+kEnIbhzMUqF1?=
 =?us-ascii?Q?bD1jsQeZ+1qewdLo7Mw2Vl3ltb/2ORAgWkQ5iJBOVMMkmoy+DEmT6EWsehAf?=
 =?us-ascii?Q?O2vlwZ1T0E4Ue6VBg7GuoIzYXibjJGI9cd0K8wRE6kI9vd0v35va953p4yr4?=
 =?us-ascii?Q?+5I9voMHgPp4a2T8j2tn78sM215Tu7/LuBH0FyhycFRpj4aQv2D9HLMSpP+d?=
 =?us-ascii?Q?UncBqrddRIOsIOY9cOT25QceXeoApyebquS2CfDgKYfj23sg6k1SEZ6tdccT?=
 =?us-ascii?Q?8/VpBesL2jeLX8DwbyGVzM2PfCcgFNuYPhQ20+lN+pBUTUZPSbfM71CA6h+H?=
 =?us-ascii?Q?ABtLzy62WA5x96ghI7yR+BAu6rvQkes76mZuvcJRlRlWTylXlFpFycEVdh4T?=
 =?us-ascii?Q?0SzhuqwzXwakAJvCQGvJcbd0o+RaxrbcxaN06Pf8OBP6ru2Tx0yQl3NsDhaD?=
 =?us-ascii?Q?guNrWsU1Oo7BJfY34FEmJUmLI4FCP9ZjjY6gyXvoWJDkeY/HeIXh+WkyN598?=
 =?us-ascii?Q?DX5yBbBEvIgXzfur09vcFTND3KaZGkxLqticKQmXTXogSi5Wao1YBAq90vBK?=
 =?us-ascii?Q?1jHKZGmNGdQE17xw7b6g7CU6edwWZAej22H6/N9P7Sk44DmPnNMtg4QDfCVt?=
 =?us-ascii?Q?HodZDBAIeRuj5mdznrHxiG+YuqfubgDBBgjGXbaMWpK+DeSdE7P2rI85X0XF?=
 =?us-ascii?Q?zlYTlnre6Eir6RmJjW7eC1gdbyszAijH55g1DqQYgM4OKTTzwPqmIlUyhs3c?=
 =?us-ascii?Q?jRZr7Xxi4IOnp3K3hD+jyZ2bsCi08OChzgDNCp2lubzYwBrLAngH+/NzG7Ef?=
 =?us-ascii?Q?pgijodlHO7b1pO9oEB437F/cDLJ0Aa/mEPnwa6bZjgL9I3/44fPvnX1tLE5I?=
 =?us-ascii?Q?G5HYIRf8v/ynzCCo+qVyv1tubXm9lCgWxITw6YOU80LPDfPG/8tKVWoo/avd?=
 =?us-ascii?Q?dNCSOfiioti1B+EbNM7UaASE/NNyKDEcVUzEtjEJKgi2EGqStuHNKAGFUnOC?=
 =?us-ascii?Q?Q+mNFr/YHU6RAuNbfhwydbigt9xmbyHzJhMbZEBSR9oq0U8r1jkVjHDG7DUW?=
 =?us-ascii?Q?0/+VTsqjibnQ+5iHCi0zSNl45PILj/RFPhHq+0I7ByqLbuE2dxz1OEZ38aBZ?=
 =?us-ascii?Q?LGO0GUXHBa6fncg/0mEBkYG0h5G2XbBYDDi4zc/MeoM4CFfk6wHCHLa249G+?=
 =?us-ascii?Q?BvCkMNwSxGDMWPHCtqC483sLIVIfXD6O7T1gf3G4APQbspyYrpbTmiG0AC42?=
 =?us-ascii?Q?/r0gifZHUyQC6pcXIvjfU3rT63FczIs4sdxVDZMCJQ7QZh6O0ntbKnMO4hDp?=
 =?us-ascii?Q?b9wReWpaZnhXqm5lCovTmOLQk6GwhsGEchFfPbfunI5GZvQkaZqGCJwe6+/m?=
 =?us-ascii?Q?7GjTkNOzD5P0r9xQgpIm9K4Kd1fUy+swiLUCpiKQPKvxZqsR6YAXQJjpf2kk?=
 =?us-ascii?Q?jMmdHfJ6BDKRkVvUU9Cq+JonVKv+JSk+jRxcbWVv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?hvNEGUFvMRS/7nl216rjFkTo9YAwZfGiTxC3Hs6T4zH/6De7EmRGiViarqqf?=
 =?us-ascii?Q?NNvsiHxXVh4o6DiBGtFZ3jHdZWRNqQWb8nqrx/KDnWxwJF9vK7YDMsZtHgZO?=
 =?us-ascii?Q?k1Wxa2jXxZYQa1I8i/hdIqkY8okxsUjQioxibeaVOoQ5fD/NdvomFCiS/ibJ?=
 =?us-ascii?Q?NpYUfM0nnRNdQSW9Vkoc/NKNUmYfd78apOzeL7guASlFDKVSvNRX5mSsdMU6?=
 =?us-ascii?Q?EqRyKscJxDZzdrAPaCiSVH9pAkqNif7zmhPiYi3p/Y6f7XEHvEOXhKPwM8Fw?=
 =?us-ascii?Q?Je15IBMdrVsHtxLItuFBa2oKy7wlHRpjHdNE1io3xXzaw5xMZYKlBLQe/51Y?=
 =?us-ascii?Q?80UDxoZeeiC3Na6qRtObjmakIjvOYKesOEhWaerNFPYmWgwTO93lrBia+ZG0?=
 =?us-ascii?Q?E1e/DkYo6bsrB9u61djMm27IyR5WGL1onuJfxhOCRhohnKV7UHoUZnYblFLE?=
 =?us-ascii?Q?MfgcP+WWb6nNzr6qnrmuJwpa7s4++aVq1XHAxFWwzP+xr8ufDSBM+k51A+9a?=
 =?us-ascii?Q?XcruekJkeR8omsBrFpM66iMMvbkWQpV/M0Dsc4Lv3MXY84lNdfYQIBUw+gqn?=
 =?us-ascii?Q?gu0BgQTUlk75/ZrNcna4hVwrTExzKvOi+pcoPpROpfa7h1sIEeIgqibU4cd9?=
 =?us-ascii?Q?MRW02C0z6U8jcGfPHyUjIdwZWIsVyLlkWk+N0t6xQnCZiUihyxGo1V94hTGk?=
 =?us-ascii?Q?TT2Z9VqxB+0br6+zrZhBt5wZkma/mjhayP97Rpr4dnKfxC2oVn7KGIxbmyJ3?=
 =?us-ascii?Q?BbRG95/xrkgSzz+UJTBNAwj7ltl66mEIMfrpCJGQvbZWY011DKCWQiNfqPEB?=
 =?us-ascii?Q?IrFVBls1HvLfb8ly4Ozgb3q+1xHXp/6UdWPSxsvgn13eLfz6ftujjKQ3MHD1?=
 =?us-ascii?Q?QjMuImC3qQ+ldj4JVPnHPXm/PDkdOO7rJWWaLh1qwxaUELiVdFw3H4fLBN2+?=
 =?us-ascii?Q?ldhTYHNyZTh499IKZlA98s/inn1u46LAoPPdSyQCFkttDuJyaXBI+YTrXOTW?=
 =?us-ascii?Q?+fKjs4xMYTidLqhmHkI/Y1nveQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15106b1-db37-4362-8bff-08db8950fb73
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 18:41:51.3702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0Dro+WuEgivlxW1PxeeaBEJf4J7XygvBONMivtjbMna03DXhSKPSUycJmNPLWQJdDdAg6p/qvHfvVWDTsSj9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7466
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200157
X-Proofpoint-GUID: C0buh3g5iPY1-RmIHWtK2SujXYQXXS-0
X-Proofpoint-ORIG-GUID: C0buh3g5iPY1-RmIHWtK2SujXYQXXS-0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/23 22:49, Linke Li wrote:
> From: Linke Li <lilinke99@gmail.com>
> 
> ```
> 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
> 	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> 	/* check for overflow */
> 	if (len < vma_len)
> 		return -EINVAL;
> ```
> 
> There is a signed integer overflow in the code, which is undefined
> behavior according to the C stacnard. Although this works, it's
> still a bit ugly and static checkers will complain.
> 
> Using macro "check_add_overflow" to do the overflow check can
> effectively detect integer overflow and avoid any undefined behavior.
> 
> Signed-off-by: Linke Li <lilinke99@gmail.com>
> ---
> v3: fix checkpatch warning and better description.
>  fs/hugetlbfs/inode.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 7b17ccfa039d..326a8c0af5f6 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -154,10 +154,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
>  		return -EINVAL;
>  
> -	vma_len = (loff_t)(vma->vm_end - vma->vm_start);

I don't think you wanted to delete the above line as ...

> -	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> -	/* check for overflow */
> -	if (len < vma_len)
> +	if (check_add_overflow(vma_len, (loff_t)vma->vm_pgoff << PAGE_SHIFT, &len))

.. vma_len is uninitialized here.

>  		return -EINVAL;
>  
>  	inode_lock(inode);
> -- 
> 2.25.1
> 

-- 
Mike Kravetz
