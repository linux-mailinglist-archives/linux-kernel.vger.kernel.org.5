Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA5F75A299
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjGSXDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGSXDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:03:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCBA171E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:03:30 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFOZir000537;
        Wed, 19 Jul 2023 23:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=L1Hnb9H/GAa8Aos6qjg2Rx7wo9szTbu2arLppYDiat0=;
 b=0aXq3y0gl+IqOBcXF315+qhIMNsiMWy8W8PmFsA9aP4gu5DZvG04Qxo1CfvJ9zAqNq+U
 xMLvUxci5AUtENjuUy1NlI8B8oAXHp9kKCqzYMI8oqgHXEtdf9bd27wko0f1eKk3WIte
 bg+I3CVMCZFsP+q56lk0YmIEGJN2H8OSDfnsvILeLC8/Cqw7kC3uOlV9YfB2lgq+v8a5
 GLhi7yNqiJE0x4I5T+bt0vbI6dzFN+Xx9nw4tfvsz0QZIaI+VWi6HiZSa8VmrEUTcb02
 KDHQlbC0wh0dLyBippwEh5wGJb+CDlxcaTrrQr3ymRcg396p2+/4qVX/Z+TS3KoYBPzF 3g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run78gjf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 23:02:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JLw66X007771;
        Wed, 19 Jul 2023 23:02:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw7eagv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 23:02:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA+souYoP4INPhA1HA7Do2/Imb8A+GFuD1TI5GnSXBJYrCzK+7P/7k7zwNOYGCYA0cSyTQTD7f4SAcGjJMi7ArQjGa3V6oHhBUiWYF5zJGiwIO5lTOIztGe8Qvevd7hR/3DLenkhEnXkYFh6+MXzFWNZzqeifbo9ndCAS4cGV6pORP9deGJsxZX7MZ0qYQvF5bJ1+uMWvneqqJH4bB8Jo9SXzVd9omevem/ESMedVR49+/cqCbdHYoIzMt7ExxhjojS+9M217F/SqUAFevomSl80s55PFC6prbBduiP0keXwyHsjucyzD2mPjkdOKxlN1AyCeiQW59VCx9LacOL/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1Hnb9H/GAa8Aos6qjg2Rx7wo9szTbu2arLppYDiat0=;
 b=DEABYdqzd4rZiipp3aOHcqoOaOBd1EAGQ7yDO5kzO42+74KeWIwL6p7DzTSNPlhnnY+WqSW3O7iOopp18tEBW4YuDTC8JJB3ioMIuiBRNa6l+aHdk2loZKV22NIRBcpTHBpQU8aQOUFGX8iNoIx7Tx9Blkf0Qb/0hWKUeM04RNbNCUyKoMmpZGfVPas/od/KQ6Q3PlRmlHvHCn4PQVdDKUu1PgotL+NZWPg+qOyhF+6OxP/XB3NiuMh4mR5pmtI+uOyiNkSA2WiKX8zTeFMvGpnWE1KAJOw9lDc5QfkfMmn9Bo7Twejx4HYBIK1iZOY0ySQCtn7qvMhWbsKp0wRFWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1Hnb9H/GAa8Aos6qjg2Rx7wo9szTbu2arLppYDiat0=;
 b=DZLf9OO3f6l9MPXjd68yOBBfUiefQ7xk47oWXWu9cJT6ScWeABW6cRkY9qfJWz0igOk+KytnwfFpS5Hw8m5XvjPSnq6tQNW56/5EBI77qBEbUzKdmud+/moDC3d85ZWsxlINSb6Mf/CtspYblWFyQy1xlI0M4jTE8Jy97U9qU9Q=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB6172.namprd10.prod.outlook.com (2603:10b6:208:3a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 23:02:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6588.017; Wed, 19 Jul 2023
 23:02:33 +0000
Date:   Wed, 19 Jul 2023 16:02:30 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org
Subject: Re: [PATCH v2] mm/hugetlb: get rid of page_hstate()
Message-ID: <20230719230230.GB3240@monkey>
References: <20230719184145.301911-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719184145.301911-1-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MWH0EPF00056D13.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5fc900-6d83-4a12-de8b-08db88ac3c50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1j8M+9YA485i/3RL7f9eS33bNvChvWkjK/A88cRkWBIbk/7PS2HMJv+gqU25+dFbfJnj96HJjXKofo1scKcBxCbQHpVjDw5bywAI62DXfQHWM3poI+86mzD5f23UcImrGiNTg/9V4i6aecDh9T2IioXxuJ426Yj4InhffkdUqWFnOIgxIx6DYYslmGawC14kNqj9k/O3Rm1kYJ94ais1L/M+IvpLm+zU8mxal44GjqGGx1YhPuITvGD9yL6bT3D5yseleXD3+qFNJRsz0SOM1XLPSCU3mEvaFi/dMgQ8YZeODAygBEcSQ3GeMX8yEfF4rYEt1giWl6pqg38yneah3OxXl0ZnNKvpiKaIHEg2wrIDdmX4Q7FOBiHzKLQFEc9xMziSqpvT+lb9AqlW59p89wNYDRiekyQKOzgKscCeR+o2dpKO6pY0Armfa1UGdwovWNiF/1vNTsr9Dm5aPu54yZotv753kD1F/G2W+c7TmrQMBx6Vu6swxBQJnm2e6E568LhwvWaN9M2jsy2KydxTXDDlbKDGubIWks671ri10C3J10/Zsyu+7JUId1aYT+YpfqG9I9Rj+M2C4KRxo2m8WgfW8fAwWcRwCq21ftDO24=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199021)(38100700002)(6486002)(6636002)(478600001)(8676002)(5660300002)(8936002)(6862004)(41300700001)(66946007)(4326008)(316002)(66556008)(66476007)(186003)(83380400001)(9686003)(6512007)(26005)(1076003)(53546011)(6506007)(86362001)(33716001)(33656002)(44832011)(2906002)(26583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MYOcBo3N8eIXQ2n/h+ZPgYfYx5TBx8ibeac51mIuF8yK+FmiYQilBhuX5GUQ?=
 =?us-ascii?Q?GoNqqSkSz0p+Ika8VBSu2av4C2FcheQ608oq2mr7v89OgaBQp3A9SHNmnmJh?=
 =?us-ascii?Q?KZyJDE4YeBNF7lfeVyhMOoJXKaiAOkuiVKOqej8O2FiHcqDTt68Z3goEa0V6?=
 =?us-ascii?Q?3Y6Sr3xG7Pc0OC4ictl4cUP845f1BEia5u3FbcnVDNozINMSL1+egcYLRdGf?=
 =?us-ascii?Q?CHccvKbikv36e/f+eIpq3wG7jgyloLAraykci/bGiQH29CG5U8zS1RW1b3xs?=
 =?us-ascii?Q?OUdo6xAde8+CL+/eVihmKk+dpxMShxApLn1COgFoQgVrYcBliR3UoY1Mtv2O?=
 =?us-ascii?Q?J8HRujfpPO8BFA4toLWwkZtnNyZ7oI8/2ha11LU1QsgQXqKmMG89+OnXOMKc?=
 =?us-ascii?Q?GZROgWCtLtQo0bZ8QLlYX6iaQkIKH7QZ9MQEc1G0z0L3xDX/ubR7mB1xxoqm?=
 =?us-ascii?Q?30J42mCVzuDHTcnGG0W9w8shVjLcHWSrp1URBJJmBLgta87M5Bbifzf0mZBM?=
 =?us-ascii?Q?qR3fLcu4IH5DItwXtf0a0xDgCzn4rQG7NPo8f6wVegFMg5AzQ2hfK7+uYqys?=
 =?us-ascii?Q?7gGT/9C3VF3RQXupN3QEM8HAn5q+A7C3DpvYo3z75fQNRKBanK6gJJYE8EYh?=
 =?us-ascii?Q?AiqGeW/kKZBqqZ2aUrasYI3ejz+IKdZBTsu/lvUOCp/e0SIl05dQ+a/rFJm/?=
 =?us-ascii?Q?Dim1Cq493NANoYac46Ja3RbR6QbNnRxq+owLqWzTX0pFDLQ7ZhSUOgkW/FU0?=
 =?us-ascii?Q?zLFtWbfxK0fVGxnkhlWWOvukrbXj3QuXRk/noTkikECOGzV3cBQ+sFpAh0g/?=
 =?us-ascii?Q?QusG6QAsV9HSNOx+eCE1mTp51O4xbMO/mdakX6I+KFgppcmLNuFQYsj5UskG?=
 =?us-ascii?Q?KjypBq//W27jiGbZbvBe6vmhVbShTT351AlSb6mkvK+ciG1v6mpjsATaVaOv?=
 =?us-ascii?Q?ibcYJEr66e6TtArUjqodX5pMdaClMiFlKY5qqDsiRjWA0Whq6I00rK3Axa8W?=
 =?us-ascii?Q?fS9UnKc+xJ7C6rJ2BH8mjbGFCFuf+LFRSnsKgbTNTxRw4kmN1N9lPwyhVSSa?=
 =?us-ascii?Q?Rc6UUOcsvH+xYtRObW1yUNPU/Sj2zGkbI1ENH/nWeEXelQm30mQdB4bLBe8e?=
 =?us-ascii?Q?51A210S4eKk72JXHdCdfsllXW7urTHgT8UJqtMdIVST3wLSqC72g+zWZoVbB?=
 =?us-ascii?Q?2wwds01LMgmcSMGkL7CTi57cyQxiNWS0hSZmnR/DkhCnZ7+/FCVpTGPldf41?=
 =?us-ascii?Q?NgTyGZZEwjah1vCXxcF9F8h91505T3cCh5Sn5OzQT3CxRH2rh6d/Xl232gzb?=
 =?us-ascii?Q?KVg4BweOJCCmNiO2XdI8pHEb5kNC8sObI9FaQ77YW62N/aCwJrJDNrZumyIt?=
 =?us-ascii?Q?TLBJYMpvERDqU904fndpVL9IRtu0iCWcrNlDDASkW5JLJVUTLu5xEDvYd7dl?=
 =?us-ascii?Q?A/9JMbKRm7GBXtxtF0RyNI5iDtbyPh7UcT7gGLnboa86ZTiNe5ICwopQJJqD?=
 =?us-ascii?Q?zdseEJLPvot4OcFduRvbma6vZEJ3eqB7tck/J0z5AnqseDwMLUwDb2HYg1JW?=
 =?us-ascii?Q?gRTD92rNC60V3mHwgd3LfPrgf0wFsA9KxNU/u337?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TCHdMr8vULDScMaXzV3/KRH3sbybUisWZPwf6P0fDA5uqsNTmZVgDpeKQIERKPby1LxPeeJds4GCt1hkHUXIGWtl+nKcoIfwoteNmkriguwOkOLPoF0iIhp9T7tfDC5k+uBIcerK4XBfHXw1N4GB3+vSRhYXbFqBAK0kHWInX0qef/enj9ivAWFJ/94AQsoItZe2fUkLHjELcE/xjVwdPwsGpH5//cbACF30ixPENNOjGmluGTvQWVViSwzsA6kEgyUWHIkkGDAsj+OtnNbzfj8cs4sa5V+qGUVaub7Ezl1qi0gCwRXodZJ8lKjEDVY4E1zz7eXmQeiIbZDskAdvjJbL0go5tsY8Mn1wB5HN+B05GZR9LppfQr7jzMFpaPvN8U4C82jj5kzBHKuaOaiqqSXbjCpfVsXEibLumyabycHdtnJp95BaUj3PXHKTF+kIbyTA9/S3nnfegPSGPALKhT+E3S4nALymc8sqAIcgeDEJj1sV3T10ez6RhQIefsCOIi8fX98kHv9IXkoY8KDZMnhuqpzybMCUTFjLk+NYSVzIM054Pheklm20s0+y40uR/1K4AfcdjEY6UJwfRp+8sSvOT7ZtSckiQp5jnr2k47Oa+htxNEH1UPhwNct/5CKc0iBas8mQLvFl4uYThqb0G08XfUTb28oAsF5sEwO6Rvo08ZB6l63pJEC901rE5m1knY2jmXyqKV0/TR3+MJDsfpCNoIFezlcZZ4ejTD8yHoAQ1bJma2aRVn5Wg9+JXod3DXHzz15f+2f9JV3i2z2z3x59P3ixr3JTjZ8vhjxj6wAb4KPduf1UYPrWtoXZueOH/Xy2WUx9csyRAIQdYz+4SNst5molhjvAl0E9tkEskZM2sD9oUB5b4mZedb414As9GrdqJ/kc5vRPHAfH4CX8NgFLVdrI7XsaOPuSAnOVsY0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5fc900-6d83-4a12-de8b-08db88ac3c50
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 23:02:33.7516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXUf4cEHLQwm3YJWfYjgtosaZgu/yE57x+TLoRR2uFxSWGA3xerQabgkr4HnRn1QNXoQp3XPj2NXLZnnDaIQiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190207
X-Proofpoint-ORIG-GUID: -Lu0AKvze3-kU4NlPZO_EDJgulibmmAp
X-Proofpoint-GUID: -Lu0AKvze3-kU4NlPZO_EDJgulibmmAp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/23 11:41, Sidhartha Kumar wrote:
> Converts the last page_hstate() user to use folio_hstate() so
> page_hstate() can be safely removed.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
> v1->v2:
> 	-change (page - &folio->page) to folio_page_idx(folio, page)
> 	 per Matthew Wilcox
> 
>  include/linux/hugetlb.h | 10 ----------
>  mm/hugetlb.c            |  6 +++---
>  mm/page_isolation.c     |  8 ++++----
>  3 files changed, 7 insertions(+), 17 deletions(-)

Thanks Sid and Matthew!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 9f4bac3df59e4..0a393bc02f25b 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -841,11 +841,6 @@ static inline struct hstate *folio_hstate(struct folio *folio)
>  	return size_to_hstate(folio_size(folio));
>  }
>  
> -static inline struct hstate *page_hstate(struct page *page)
> -{
> -	return folio_hstate(page_folio(page));
> -}
> -
>  static inline unsigned hstate_index_to_shift(unsigned index)
>  {
>  	return hstates[index].order + PAGE_SHIFT;
> @@ -1062,11 +1057,6 @@ static inline struct hstate *folio_hstate(struct folio *folio)
>  	return NULL;
>  }
>  
> -static inline struct hstate *page_hstate(struct page *page)
> -{
> -	return NULL;
> -}
> -
>  static inline struct hstate *size_to_hstate(unsigned long size)
>  {
>  	return NULL;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e0028cbb86c09..154cc5b315727 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1812,10 +1812,10 @@ static void free_hpage_workfn(struct work_struct *work)
>  		node = node->next;
>  		page->mapping = NULL;
>  		/*
> -		 * The VM_BUG_ON_PAGE(!PageHuge(page), page) in page_hstate()
> -		 * is going to trigger because a previous call to
> +		 * The VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio) in
> +		 * folio_hstate() is going to trigger because a previous call to
>  		 * remove_hugetlb_folio() will call folio_set_compound_dtor
> -		 * (folio, NULL_COMPOUND_DTOR), so do not use page_hstate()
> +		 * (folio, NULL_COMPOUND_DTOR), so do not use folio_hstate()
>  		 * directly.

Looks like the code was updated in a commit prior to this comment change.
Thanks for updating the comment!

>  		 */
>  		h = size_to_hstate(page_size(page));
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 6599cc965e216..bcf99ba747a05 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -79,17 +79,17 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
>  		 * handle each tail page individually in migration.
>  		 */
>  		if (PageHuge(page) || PageTransCompound(page)) {
> -			struct page *head = compound_head(page);
> +			struct folio *folio = page_folio(page);
>  			unsigned int skip_pages;
>  
>  			if (PageHuge(page)) {
> -				if (!hugepage_migration_supported(page_hstate(head)))
> +				if (!hugepage_migration_supported(folio_hstate(folio)))
>  					return page;
> -			} else if (!PageLRU(head) && !__PageMovable(head)) {
> +			} else if (!folio_test_lru(folio) && !__folio_test_movable(folio)) {
>  				return page;
>  			}
>  
> -			skip_pages = compound_nr(head) - (page - head);
> +			skip_pages = folio_nr_pages(folio) - folio_page_idx(folio, page);
>  			pfn += skip_pages - 1;
>  			continue;
>  		}
> -- 
> 2.41.0
> 
