Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6B8783048
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjHUSe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHUSe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:34:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1417F3AE55
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:34:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxRZb027428;
        Mon, 21 Aug 2023 18:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Rs7GQ00XdWWQKivGYwIY93U7aoObruD4n+B2dgyFnvw=;
 b=Sz7HCdbxbMM5r9mC3eWkAhgjyIneOfddSaqxl4uQEYuSBXfSEmNvLKW4R+uFeYaF4C3u
 UzYESd05hf8rp6bPWWZyhB22nYdEUzzkzr/m3B2Loub7mOSBzUeZJB2OQ6pcQYoFsvNk
 Q05mgwzBMy39+QXJVR4NOh9G4E7pB7QjVA9Ol9rYT7Mx+x8CFo3CJqQUiVEfiRYW8FpR
 ksOc7sp/by7XY3p2Xnu+CKRTeK0J39qHdoEZptr3XzDyWwrRisYhknHu5ReMKdM8tfLO
 v22aGsJ4jnKf/D+wtbubLOAWgIh7B75U9Qqn8hpggYJElJJfc6bJYyc+hVRsA6GQClTa ng== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmh3bkb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 18:33:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LHeGQH007716;
        Mon, 21 Aug 2023 18:33:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm63u69a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 18:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNeKRnvzlbRz031w5K5gaZHLrUPr0fil4aM8usaS5MKpja1wj7d1dxBJI5ePKBa3mT+i9xRcrGF1399tTYwzzbbQdSnutrZyRr+Hcl05tpznGerh8jCFxjNathxVfIT6UmhO0eN8VDtiyPM5TWMIRRm6yWjssoOArRTmoV1vlxWoo+rlZl9shI1sYH9q+ZdRqxeIwzSd4BfCbKEmIiWeJ9o5CnQnKgD4G0cmA+ORHSWIh/zr4iRGTl6gkpl/fw3HpJz+9ua34o54IMtHMkWR38/VTf5pQZzLJypbRKvSpIDhFs6JxPZAwFHZo5+DvgVE0ygh3NiI1Njz8XMEvp7mDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rs7GQ00XdWWQKivGYwIY93U7aoObruD4n+B2dgyFnvw=;
 b=cO1ITFVCnZgoA2hUoCHlZ5bee7Zpa7lmEHeCz7rrc7eJfAe/hcFS6wKoCLxWarPRAMPheRIztrskbCBE2wlHgkCfVkLTZXBEr6ZesQQg4A75/UjHkWBhUZut3O1mlWBBX9rGJ1zOjuTrWPnI7eLrDH9zpdR26RqXj+93BrJhXzCMeqgddRH7YaTxKcMove8Qo+RctadAcASJO1tSeBiwQoDxQas7AcbCzixXBLixFG/BQaTujZPib1q6DRf274GOIG9IBWgq1fEDxQWOM0K/fSQcP7DUiu/nBvC60DiPVhK7FBG4sWnNni9lpAi7PKe0ZecpMXbHbSoEOPJsEcPNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rs7GQ00XdWWQKivGYwIY93U7aoObruD4n+B2dgyFnvw=;
 b=SUAI5bJIeMCyGqCfkEa/qDvUNERUlOR75wwKOOo5xveC0w/JoigWCp92Bw+84pJYEYD0aEIMqK12lh32dIr+4BA6yfI5jL/1zLUYiOlOO2lcobaF4jxsQUXJzCfr5X4oNiVtaR2+3MOv9bc3VJR/rFTDd6XC1xDpWDUQD8QI4X0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4565.namprd10.prod.outlook.com (2603:10b6:510:31::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 18:33:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 18:33:54 +0000
Date:   Mon, 21 Aug 2023 11:33:51 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org
Subject: Re: [PATCH v6] mm/filemap: remove hugetlb special casing in filemap.c
Message-ID: <20230821183351.GA3377@monkey>
References: <20230817181836.103744-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817181836.103744-1-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW2PR16CA0042.namprd16.prod.outlook.com
 (2603:10b6:907:1::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: 71054f1f-3218-48a4-1bb7-08dba2752c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29VPl3ucZSyZCrUZcN7v6JlRKgNfmT5WsptEzkCZMkIIHvcCtm0l59FyXS0p+dehnJecRl7WmFNvP88bLB9ZsGY+O9Vq3FkN6qVBHihVdYly6ChFOE3QWtcvvugQ/50MceAabxkhnB5cBJDMTn4Om2IPnYl0cRUAnfUeVG5EjA6HoGE2bMI/0LiE2gIy++39dDSLOczIPWN8qcM196zETHIJc/sOopcZb6rsioxL70KNiQdf2LaO1bFbm88NLRMKl16HQVaAUUYsB+S/hGft1qLI4z1R+EHRfxr0IwkVHY5B7d3K575nfrE7ey5vfJki3KTgbFGU/klsS1F7201bH1Oo6YgWB5tXPDei3eyhe2o0JCZfgUe4I9QN+UAsMIERSxYX4gJsbOIv/xeumIuHqq3YEXZTR5UL0k8C4c++fr9YtjTsuAfcAGeuHZ5+b50yRmluLqPjXcboWeKp05C0I9Azyze5voDPfBcZoKDUaTOWEqPrTap1yKB0xPDswLzOlBkKgXlRrQ+U9ThuVAL8y519f4Sw/f8R7MgXjAzXv2j2qRADecbjUDiclQwDlRKd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(6636002)(66476007)(66556008)(316002)(9686003)(66946007)(6512007)(8676002)(8936002)(6862004)(4326008)(1076003)(33716001)(41300700001)(478600001)(6666004)(38100700002)(53546011)(6506007)(6486002)(83380400001)(2906002)(86362001)(44832011)(5660300002)(33656002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M91hZvVzHSlQ5mBye9L/4p55HeSxWO2kztEnZqY1rWKGtxJRf2sSEEtzCaXx?=
 =?us-ascii?Q?V1O4SIgfGawSIdLwrL/FV5TG1XL3fAD6vdVPvu3fJ2np/MCHj8EHk8/w85oT?=
 =?us-ascii?Q?Pvr0Xoo1ic5sc1RtTaQuDL44sPuJFiglVmMjvdGv1N9NQQ2FExxa2GiGeqRX?=
 =?us-ascii?Q?pERyRIadnT68AE5fs4ZqnAECQuLcswTEi/x+/OPGLy18Wy/jN/vzjXy6sHuu?=
 =?us-ascii?Q?SeAtoXWZqWKN4b5eGaciG1O/6HL39JBA67eyCc4a4zAOgjCefk4ZCUtQDTI4?=
 =?us-ascii?Q?/56+avWWl+fnYrq0VZFJ/X9TN+8sIlniUEgHolBZQ5eYI18xK+fLALpJ9J9O?=
 =?us-ascii?Q?uuG4vFZeWb419pi3Xmjy8ho5uHfHSVa+3fTOdONXAm56lBN0utzZtgMyW9y+?=
 =?us-ascii?Q?B8I5G9tenfWH3Wlqkb2s4NlgCDJSzu0Fb7OmC1ubyaiit4M1vpjZZszdYQuG?=
 =?us-ascii?Q?NmO2fhz3K5YUMtb5Ehsn65mth6Sg5GHLV2LnBxnbadER/CEJtU+28m2WXU5c?=
 =?us-ascii?Q?OK6lRBSjLGaG4xOK6I9BXOzXEc5Yky3jN1mGYAquGZ0P8snnBfWHz5SkBFKp?=
 =?us-ascii?Q?z7/dT997qrW4EgVu1FdPhRwuZD3d7wR9cG3tkgJr0ttL5TDUZYcv8ITDFCPA?=
 =?us-ascii?Q?4o21rurWCw8nA++cZlhmDeOsuCgxsRToL0JDieCh3nGh0w4nKyDgPOd/cJrJ?=
 =?us-ascii?Q?fs/HALh1q3TO3hURNL+17X0Ni6zdp1R3co8EY7fPl8n+17vPQgnkm/hvI2G9?=
 =?us-ascii?Q?lmFxCWbwtOkW4t3Ir3wJSSGf6oNmf9UFDvTc5vMEi6x2eqKPoI5Ze7ci0acx?=
 =?us-ascii?Q?6V2A3muKuK3DcvUA8C/giraU7JtXwPx+oaewdztMULyE5d62h4gn+S0jemZb?=
 =?us-ascii?Q?Z4XKw4r97qTKF2McJREFU2K1ZHpHOJHz7+6VpVcYlDBKUA3bNJh79lMt8s6y?=
 =?us-ascii?Q?jyExGImjpdFj059dFQg9LmZ0aHympDbOAl+p7tEviSwJBv8AOOFm2FUOX1lj?=
 =?us-ascii?Q?tGuN8DU61FQZnrmy63dAb7b8x+Dm2/NRmf9Jn/zxohXtKzt/1Jeg/Fy8drDc?=
 =?us-ascii?Q?Vz7pS2bgFgkXJL8HYOw1PhyljZ7MBwrGYnxpz+KnDPB2N6WCl1PuXI9NhD7S?=
 =?us-ascii?Q?3OUz9bMAHMqGAfFTacAKxc1N7tbcGOKxs//SFVN59drP4Z7BL8/EZ6VuX16x?=
 =?us-ascii?Q?hY5lH2WSe2aNDDE7Nq5ir+eX7tAL7K+m7y3Ba/GXKH3AAAeiZprHmqq47WED?=
 =?us-ascii?Q?WdhAV+5pmK8O5lawN3QdDfUmKewGJsrqgIk4zR3Cp37aLPBQIzMwFs0VZvwS?=
 =?us-ascii?Q?1gQVNUYE3gUqy5hXx5mNaMO/g6ZbWdUjbxlOg/V+Hr3OgPd2pOFHHwK43T6a?=
 =?us-ascii?Q?0PFNzp8syNbvpbKwJULAbqagYZHSldrYnwq+3az6JmY5IXZW6E9xx6Nv0JaH?=
 =?us-ascii?Q?LB0n3cU4MtYTrJ05Ar1PIMSjanWgxEPS1/+22H/SJT+VMutDlCewYvWVtTAV?=
 =?us-ascii?Q?PGI0I0XUnXSMULr/3r9/kr8kWqrVBzgaj+nCtHmyh5PXlpQOjjjDVRAR3HQa?=
 =?us-ascii?Q?+XMV4CI7MfYREB7GDEpRvOzoGn+fjt6ZS5hXW0fu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: slyR7uGEJrGunKzFAxojCiakkUEAx0+OU150gy1yylzVG5JOjFSqVxBivXRRUNZJ7PtOkR3PJqgDd7WQIwzt7ubwpw2AU716f8e8+2g7xHS1GlrsVb+4XI09OY05Gg4IDQMVCrzlbqcYzXGXgpGKnihkMVny9Z0Jje6SiuzPsXI3S5k098Pu3hCig0fENqmWQyO2/mNWTngxMWMbeveBrqJcWctkqWDxseKHmGT+MLj2DKYZ//iYTwLjZcj4/47RiKyKoIMnFr1+wKi6YZhF7LXRbEhlryOk0EswfNnbwguCe4tvDg+5jdAf1se8w1dMGjpZ7uateUWk2QFW6QiYpDb1CrlEjVro2hOMijqxhPuJ6w+R395u6GxkStJnR88qiclyOAdqjZDNoNLh6zUDq33yNKOpUTJhmHLRQ95Hy28ya6S83hx9inIfUNxa01XlifjTsPiQwPNbJ2aPqqj/d50a5n701H/89/AhX1TRjZEQNmnTHYzcqa2jNBh52Oii+TH0ZpYg5V49RR0ZN8XEFhbokvYPk3gM23q1z4TkiGApQ0PGZUpA3Oruyv4EJf+8hI70lwN2scCecmnWwzBVdEI//PNuG4bbcjnmFCbLWfk4SR7RNbsc9nvmZT4n7rJZHcidDaHM3aZJrOJNlFaR39Ar0sp44TGupEI8BDfpAe/JlOHqeJ1vCV63KPuUD5vmNDMwG61qpbstUqeWYCmcQSRxeggEQRD/epCVcGVw2dXC0f1bDhxHiVws6VM00OPn0ivq5Sx8fvzW2fwBgVv5I0ApSYWUjp0HJa6Ezy9CuOlj/dm93/HmojrGwgav08lbJesclgjQKBD0emCc3RpFSNWAN1eYmeHs7XWqXQtp7rDwWA6+ZkvrEy3NxGciit7o+FmHSDDbja/pSEgNxUuM8iidkLFKjcVeWAUcO6gny6Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71054f1f-3218-48a4-1bb7-08dba2752c45
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 18:33:54.2549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hO7ljSnccLHDLkl/IErezpsDMxPMa1nMKot7SkEWJnCKqq5d9jU2puJyeqcwSTtAGGXJdXv1vZEkDjyuaU8p2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4565
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_07,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210173
X-Proofpoint-ORIG-GUID: hlFHb4i9gaqRW66WxARw4s3FjmB63j-8
X-Proofpoint-GUID: hlFHb4i9gaqRW66WxARw4s3FjmB63j-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/23 11:18, Sidhartha Kumar wrote:
> Remove special cased hugetlb handling code within the page cache by
> changing the granularity of each index to the base page size rather than
> the huge page size. Adds new wrappers for hugetlb code to to interact with the
> page cache which convert to a linear index.
<snip>
> @@ -237,7 +234,7 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio)
>  	if (free_folio)
>  		free_folio(folio);
>  
> -	if (folio_test_large(folio) && !folio_test_hugetlb(folio))
> +	if (folio_test_large(folio))
>  		refs = folio_nr_pages(folio);
>  	folio_put_refs(folio, refs);
>  }
> @@ -858,14 +855,15 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>  
>  	if (!huge) {
>  		int error = mem_cgroup_charge(folio, NULL, gfp);
> -		VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
>  		if (error)
>  			return error;
>  		charged = true;
> -		xas_set_order(&xas, index, folio_order(folio));
> -		nr = folio_nr_pages(folio);
>  	}

When a hugetlb page is added to the page cache, the ref count will now
be increased by folio_nr_pages.  So, the ref count for a 2MB hugetlb page
on x86 will be increased by 512.

We will need a corresponding change to migrate_huge_page_move_mapping().
For migration, the ref count is checked as follows:

	xas_lock_irq(&xas);
	expected_count = 2 + folio_has_private(src);
	if (!folio_ref_freeze(src, expected_count)) {
		xas_unlock_irq(&xas);
		return -EAGAIN;
	}

So, this patch will break hugetlb migration of hugetlb pages in the page
cache.

Sorry for not noticing this earlier.
-- 
Mike Kravetz
