Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71CF7D1F22
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 21:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjJUTjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 15:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUTjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 15:39:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2355A1A3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 12:39:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39LGHneE010757;
        Sat, 21 Oct 2023 19:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=/IIx0/Oey3pq5tSc9C56nlQGZEuKNtx1TJnmlLNbNtE=;
 b=kXqEaLLM6Vef4yvmLUXu7+ow5Ta1ISS5Ur0UMLZ+maEoYUOlpdqre5dfaReYDUNY0ufY
 AbEFTjl6AwcGvg2CCXKORORB2USRZbzdFtX0r8+gzJtG1kBhNsIC8dUJTYgMNMGNRcv6
 I+wdr2E05L2mzXDSGZh7qQeFM84+bKEiOuxQZY7Ilw4zRn1dmgNdLmzx96H7c59HLM3T
 r/n16rjZSaN8LYj7YEupeYP8BcvzUGuxAfKHUbdCw6juBJp+uClWbbirLNyzZjNu5/pV
 hL39+Giicc0GjZ6FCjJyxlzn2LcIQVx3SpTS9hthoQQ/KLviTk3nY80E993yJt+Yy6Zz Ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv76u0wky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Oct 2023 19:39:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39LFhi05031225;
        Sat, 21 Oct 2023 19:39:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv5391jeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Oct 2023 19:39:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCwBx9VZ6adXF7j8uim0/v1QuVuH49uMahgiVH66W92P68Uo2fMDE798drnZ3wBMNSdOCMUlR0fvdDArIzeAbFM7IILz3F87tdxaxrC13GVZYWAIlCRb4m6ZuJnbUL7qCYpLxcqvpFUc3jZ+1qLXtFdemNQzgtxYNsWhK3nrOsRstLsLnsj1CfUFWUW0vD4Git6YrW+hxP8dMnXmNL543I3LwY0dlLOSswWusxa8SeAgik9Xf/D2zRmYQpSDg5HB5H/Ut4Z+tZGkTe12pA9q817EdsV36uqMqbLUh6nTzmNuBQgw0RZ53D4xQyQ1q4sAh2X/hJP6F36xJLAzLfLi7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IIx0/Oey3pq5tSc9C56nlQGZEuKNtx1TJnmlLNbNtE=;
 b=HG2aJC+l1QALQo1wBtcWQh25xy5mvitncA31L5pYebqFVf6uXzc1GOZJ577w8v8Qe/oMczYIwYwapDQ3stkBniEwN/aUOZB51nyyUt2XmIcL2DmafftM5aQljm50HMVQeLcAfrbggTAp3WLIsbQT+y1i2EqYGk5fL0cdQ5jjBqciF8oeA+C0jDL3tD7DhTqRVpLxuYHO1a18sws3LEBNAKrYyWJTP5lzZvn9FJdESVKxetxCdiYzUc0e+pNzMtzD3V0erPTDZ7q+w/wet9qQovzXMqjbzYOj0/0SAtPUvGSTmzuI/83yoY0A72IXyMfUGEAiK4YJKYVo//JqPf7DOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IIx0/Oey3pq5tSc9C56nlQGZEuKNtx1TJnmlLNbNtE=;
 b=Sd/4Fu3hqpj+L8tSur89uYGUXEneRN0OYUAetjTwc2BzOrS32tIxHlyZdX726vJlm/W2Acdxv9l+slZZlI/lu9xP8d9HcmfD1a1NK52eh06UjsjJTe3su4AT3hoPlmBV9RD/3cjMH8DPBpnIPPSppZ00AZ2IywR7ZVsqnT36Us4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by LV3PR10MB7867.namprd10.prod.outlook.com (2603:10b6:408:1b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Sat, 21 Oct
 2023 19:38:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Sat, 21 Oct 2023
 19:38:59 +0000
Date:   Sat, 21 Oct 2023 12:38:57 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 7/8] hugetlb: batch TLB flushes when freeing vmemmap
Message-ID: <20231021193857.GA6451@monkey>
References: <20231019023113.345257-1-mike.kravetz@oracle.com>
 <20231019023113.345257-8-mike.kravetz@oracle.com>
 <cbebac71-0be6-ae66-02b3-243d0f8c39e8@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbebac71-0be6-ae66-02b3-243d0f8c39e8@oracle.com>
X-ClientProxiedBy: MW4PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:303:8d::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|LV3PR10MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: d30ac607-df4e-4123-0d97-08dbd26d5f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VcyUb/j245a+ZFZNCz6HmFqWUG9gKIZFh76AZJtNGzFGUSOjDbn8KoEElglM73cW22NxxlJLWtpfJJClC5Hqbxft8QdGhlUMkESGNwU0mN0tA/aK/Qr5lowTNI725t/dOtrRnYc5phDHzXaGNdhiLTrRvokrfVF1GEK9NDQrjuZoKChKDzaSUvxZlm4LaRQYUKuUUaaiJLEQsEQdCZzuwEmTG1EtcpytWC4qUezAot4ELs8/alyNg9aZ8aiKcbulk7FW4/VMg04B5zJsrHa60YTqSHZ19hpStPshvlvJOeYFa+OkFtBXq+EqVVJagzdre47xGqvTgCKnXLJwJwKm3OWcu+Qbnp49OHVDJLDci2TvfgqpccKpzo/IC7G/zynEor5/03YmHtcthcCa0EJd33BQlz3ole5Uyc+C1OHrQdEQwYeNG4S9JZz03gydw6ZZ43FnpiX7hamU0RM32w71A1mstbk6qGMvgQ2AGvgIVGddgbY+G6yV1XQE8G5TdA1UcF+x1sRjDbLbMIiIePM9S7BzZ5f53GBwAZH7QRbyozhGfu472lQcCr/UP3Vn/gNn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(38100700002)(41300700001)(86362001)(33716001)(5660300002)(26005)(1076003)(6862004)(44832011)(83380400001)(66556008)(6506007)(53546011)(66476007)(9686003)(6512007)(8676002)(8936002)(316002)(478600001)(6486002)(33656002)(4326008)(66946007)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L3peS331aHT7/vyYRfrbPqOuj2AmlvCDB747FjOO+MXDLfVcFBmH1egenfxl?=
 =?us-ascii?Q?JLmN9OeiikCz9x651aB38AIcTgNu4cfZq6BTenTh5EtsF9e3ezoOByrS0FNp?=
 =?us-ascii?Q?5DlLzM834G4hkLpyF5cz6IA+WEKen/TcvKUnHun620Um/Hx0WZAf7bEKfsHf?=
 =?us-ascii?Q?wkfZQcwho5SDncjkozYCpbvIASr4iTvXQgqMu8XSzZfXONcU/IKh545AUeZb?=
 =?us-ascii?Q?2OR0R1BIgzHrEVLRgYIUyOtwhn3ZMwFuHLqBMk92bJQL+mzTLrzjvYwr+L7J?=
 =?us-ascii?Q?ytAvdEfxcBV6W65bo+ZiPX4zIbvf72ms7nXE+YGxN+FDO7zTnHCbOm7ggxNE?=
 =?us-ascii?Q?TszBEMO2kD1/dwES0qZgLj0zlkHt9G5dkSOtz3SKuygE3jtIe9TflgXyTBH7?=
 =?us-ascii?Q?ZdwI1K+Cbnfcy32r2ClXpmqR6gdi2iyyuQk4HsXuLfsTxrn8oHS69hBb47be?=
 =?us-ascii?Q?YulZLNs40ZWh7Iw/fpdvYDe0CmrWG2/lZiaNU9CcSrdkKX5Fpskkd7MnY2i+?=
 =?us-ascii?Q?II6HyWOe8Ng8E04+4kV4pJglJjHCkjGcCxPJZPv3LlikgI06EM19rSu43q6w?=
 =?us-ascii?Q?CQjwJMTc8oz5RGOllwzdf0+WEKom151rOqPAK9YqTFLgKVWAEzXvymw7Clzu?=
 =?us-ascii?Q?DHsfxzgr+30frgt86Hu4smO3SYA9PrSiDlsas1HDm1R3oarM7Qu/gxJN7U07?=
 =?us-ascii?Q?Va/Dsmh5bNKiP1C9H1sR/IG1O/UEZ9MGotsZqJdUcIavtLiX+VPJUvS9bJaw?=
 =?us-ascii?Q?UuL4XirCqoOASwyNYLVNx4RbsKe5zyWoXHV+bKuFT6+3GvlxG8DDQNq9VR9D?=
 =?us-ascii?Q?z+gyfhAH29MIT4l/R/FyWQGdTo6KQTbIrPhOJWCo+MCi3uhfMUN3HiHGD8y2?=
 =?us-ascii?Q?4iXvX/C5y/W7oqI9lJhQ5xVwuVbhcm5YavGmd7bMzo03PyCwLAL1McpyUs4y?=
 =?us-ascii?Q?Uvh4Ncv5gpk2oLMmQIbytBrF9E+Dbw8ecEYiekIeUqGOBFzjfucu3jiCXkp9?=
 =?us-ascii?Q?VuzF8R6sLwfUD05RwWC01wH5keK1YDh3EvolFZLzB/2wrbsWTWSU0gkstjkY?=
 =?us-ascii?Q?GXgIXOFioQbZCTcHRmCXPxWs9Gj1jWZUjT2FO2Rk6WTp4za2LsvSs9PzbPhu?=
 =?us-ascii?Q?PV8NGoZ28mTuaX5WuhS1816bmPd9ygO/x3BDrGqZCJ6VTkhrLp9EfCdypgR0?=
 =?us-ascii?Q?UxUuMB0Jf3/7GM64ioP0FvD8CR5YfmGkCaGa/+u3IF09sXYA2YnlAORPvMdH?=
 =?us-ascii?Q?I06RjO/nNlvHE3AAUjBSs8zpU+fASTFdutHJclJ+joOkAYCWjKmpmms0fKie?=
 =?us-ascii?Q?vbJnUi50WABGm5o2lYY6XDvGBHGUYOrjnhKP4YnCXFVjOHbVOdTa7d4mZDc2?=
 =?us-ascii?Q?tU38JHMVYLy/oeNT1tOWJA9Fq4yEBD4vNnWrTYwvpenbnRBsRFwqfbCIYGqE?=
 =?us-ascii?Q?QDlTdYbvKPpP0aUlT/zYYDLOdNlYikFVncx0I0WR7EnOq5PjfWiU2FjmG2Gu?=
 =?us-ascii?Q?lF8syjHX+5u0aQTumSOE7JDa1uE0o2iJBjzA4sBYcP+VW0f91NpLJUtwG1bZ?=
 =?us-ascii?Q?jp0eH5+ywc75NKi6E7Q1C2ofjE//4QoZTRlNpvZ9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oDQ+Qc3yRaaX7T35iZfyF8F1pNydDBd0HbPzKxxTc83sELJMEQ6a5bRGRPiHAfzw43s3Dk4My+imA1KEE7jemj6i1Y7D6JS4jed/FV3NlHuwuTDFd8buHSIe76VM/GcF5zlMZ7M9DdQhOjoyBm9hVV9Nvx/1B8RKma2wDank7bvunImlUL8GLH4eKtTRct8bjn0x4atwNTnuda+OIG+lXS24Q50wNb6TmKItjA9RZJXLoETz3y2FOQSQrTa7bEtR+h4BjTeiAa6FtMKpEwKj+2amaFPk9b5xPs9Bh5CQ3gxf9/z2+hD1tv3SnmStzXHftomhZrSuk8R8Iv49ml/t5a7d2yxcv3rDg1KckvMlGJrj1f5zSi5OWhYphgtOa11u6sfJTMGADlYlVE9R1X40q+pVSHbaM7yo3sej/LWkX7yu1JJ6Hr+4JiJV7trBtYm/HDeIXYSk2zOHnI8WhOMI8D8h0nYdBxQZbMvz8kPMhV1XXdNbMN+s7dNBszwdgZpQEY42Q98kx7r1ChXjJxqTmwth4ltxfSWACyVg7Is83+VMfYO57/gz06eflr3lUnA3f1stDyvsdwtIdmj1wwMR+jErPHj1RUJUG/P2EchoSsxAgENecvRmEYn6Ata0ip+r+MJgJ9u+u/MRY9ABkF+2O7LLl3mix8dCGkgh0XNIIJHQ3bHum1GSWk/GFbE8s6M6nH0e4QAfBNmJPq4oW/MDMDiQUYbQ4jQ86JyiWMI7Xs/vZ/O6pFggjpoR8FApTnk+T1Mk/tl7A1qj/F8T1iV2FASkhgWYR0Xqtc+4ORAOK/8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30ac607-df4e-4123-0d97-08dbd26d5f2c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 19:38:59.4906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nn2JyqPQW7ZSJLmSEJaZL98Oj3emRgdi1rjtHY4GrBtdj6dHeJ6qPZINl0RKBVutfKI2dAXaXsrM7osJfiZzDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7867
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-21_12,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310210180
X-Proofpoint-GUID: pK1RipoAqLZVMukh2N-sLLe4J-W3jXBe
X-Proofpoint-ORIG-GUID: pK1RipoAqLZVMukh2N-sLLe4J-W3jXBe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/23 11:20, Jane Chu wrote:
> Hi, Mike,
> 
> On 10/18/2023 7:31 PM, Mike Kravetz wrote:
> > From: Joao Martins <joao.m.martins@oracle.com>
> > 
> > Now that a list of pages is deduplicated at once, the TLB
> > flush can be batched for all vmemmap pages that got remapped.
> > 
> [..]
> 
> > @@ -719,19 +737,28 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
> >   	list_for_each_entry(folio, folio_list, lru) {
> >   		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
> > -								&vmemmap_pages);
> > +						&vmemmap_pages,
> > +						VMEMMAP_REMAP_NO_TLB_FLUSH);
> >   		/*
> >   		 * Pages to be freed may have been accumulated.  If we
> >   		 * encounter an ENOMEM,  free what we have and try again.
> > +		 * This can occur in the case that both spliting fails
> > +		 * halfway and head page allocation also failed. In this
> > +		 * case __hugetlb_vmemmap_optimize() would free memory
> > +		 * allowing more vmemmap remaps to occur.
> >   		 */
> >   		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
> > +			flush_tlb_all();
> >   			free_vmemmap_page_list(&vmemmap_pages);
> >   			INIT_LIST_HEAD(&vmemmap_pages);
> > -			__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
> > +			__hugetlb_vmemmap_optimize(h, &folio->page,
> > +						&vmemmap_pages,
> > +						VMEMMAP_REMAP_NO_TLB_FLUSH);
> >   		}
> >   	}
> > +	flush_tlb_all();
> 
> It seems that if folio_list is empty, we could spend a tlb flush here.
> perhaps it's worth to check against empty list up front and return ?

Good point.

hugetlb_vmemmap_optimize_folios is only called from
prep_and_add_allocated_folios and prep_and_add_bootmem_folios.  I
previously thought about adding a check like the following at the
beginning of those routines.

	if (list_empty(folio_list))
		return;

However that seemed like over optimizing.  But, such a check would avoid
the tlb flush as you point out above as well as an unnecessary
hugetlb_lock lock/unlock cycle.

We can add something like this as an optimization.  I am not too concerned
about this right now because these these routines are generally called very
infrequently as the result of a user request to change the size of hugetlb
pools.
-- 
Mike Kravetz
