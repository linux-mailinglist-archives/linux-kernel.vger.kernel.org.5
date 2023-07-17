Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F6C756502
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjGQNaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjGQNaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:30:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6703AA8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:29:12 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HAnK7d019338;
        Mon, 17 Jul 2023 13:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=zlPD57sSPlsT2nZoQyVy5Ywh3P/yzn2C3O2nksU3W+I=;
 b=Tw0bDxSpS1SdcDMFl8zhg5ICVhdBHJ/N19MDQSFxRfU1XCbci/Vcn9GGdN0peyzYVFUy
 Wc/FkJyawyT9RJBZ05x4ljz6LEEkarsZm+zpP5jRXBSVQQ+uXoShxMTTJS9GwUG/m7Sc
 kDAF6m4+HbOV137mSqL50NInKn0FWJ44oIIzcL9V9Cq5EV+3U314zWCTluklw2baPTy3
 kYpk7h2VFD+fTsBMiTBVeTOHLzaigYl8NxhJWYtVc7t5Q3H8KJ3Rl25UgkWHZtFrKjI6
 dWgFIni8Oi05rphIi6bf2KDOEv1zowhICmzKOGyPZUOTufif9MuxFBs1P6ZwXAqK4EZV kA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88jp8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 13:28:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36HDDhNa038163;
        Mon, 17 Jul 2023 13:28:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw3n1h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 13:28:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcOQotMMIVRTXdOiDG5alMwgY6+kYH1FMAl1W6jSGQASEL2n+8xVYLBaiPxNgTTa6EnhDCkd9jtql2c0gubGRZSftRsLzz355cJTcGiGp0tHkg2O1C66svIaLsFpaLj3gIx0lUrgEVTqvwpvA4vWl78HGRE5NKBTvUT+hiIQ5TVxqf/fn8SVbHUtHHWpgaSOUwWjVsrzxJzOe9plp06ddem3iSi/0S02MBNsjpLJwNFabe/D4fhkPRT0GFyrVKB4w+32e5RBb3jSaUc4BD7ylCpoyttJZbmkI/7Pe/bTkbSvddYKm33j6vX+d3dLyAuhtIyH6IM6e9DiuJX18EXQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlPD57sSPlsT2nZoQyVy5Ywh3P/yzn2C3O2nksU3W+I=;
 b=VJ1dhExSZrtNrxTzco+k3lN+TDpw5YDZN48+dEWIiOUiLsJVG/8pn8vEa/FiSSAFuPW/8Wb+WbswxS+nVC9diyFY03KOVMk/9sb0YnPf2kIwkpD38tSvShcXUZMjWCgxWEjVMf0phM0lDL04WB0rmHRpH76LzXeOQGIyR3uUG/za9vyTh2I7gUVK08rlYzc/ETtYfnGXpBRntLQSl+IOlBQX7Tuh9D/tgyDzvCZNm3O1ZgImD5VWzZEF42sCgVBQ+WGZgG7CCsPbB0MKaRkBnZF0W8OlhUecZ2o0ZVTnQ7J8wVhDasHh0yS9QG6xWoWMw6XiCm7YvV0zuMZTHaCMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlPD57sSPlsT2nZoQyVy5Ywh3P/yzn2C3O2nksU3W+I=;
 b=eMjiFIRNgBMx+Z5/lwJd15aRU7v2AAH4zgW2pUE+JkPM3EJcko0AnzhymmZPejo5Qnt/I8TB8gGsy6JvuKlh7qyGbJhPUSMAMi+HMVXElEcoxFfy4bZYNnnmRRBA3NWOunjFXVpVGr4+C9KiJHdbUuEUEbiVvkslTMMivHdi3Rw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6861.namprd10.prod.outlook.com (2603:10b6:8:106::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 13:28:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6588.028; Mon, 17 Jul 2023
 13:28:10 +0000
Date:   Mon, 17 Jul 2023 09:28:08 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: mtree_insert*: fix typo in kernel-doc
 description
Message-ID: <20230717132808.6t6sza773qw5uinh@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230715143920.994812-1-rppt@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230715143920.994812-1-rppt@kernel.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0495.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e670c69-6bcf-44bf-4592-08db86c9aa53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPhZEctyIAEwK5y8ExEmVyuhknjX6WWpQxjNvZUfvFIPf6lzdLXZdCd+ukrq5fVbJIodXvOag6hBZnWqJM0JzCHse6ALvO/EsAu55Ed0Dx9Vd1vbIraWIzoLxl1sg2buyzQAjRvOz9Ksf4z5PjMa//+yT4g9N2D7FqNF30WGBdxCptVsGr9IwcGT4cFMZbl5GtgMpzfAmFswhdT/3aEpHBIesqRL8JsT1pXVEuf89uvV4LSKY321uRJ/dGW4c8SjFQuBPZjOtCnhMVIbUkEQVhEpdqOnAfDqtiRsYaqVhBj7AHfMlm6aN77JXdDlBObW/y0v4nCwIBV7B3X4UdvGZvIbkA2Des+qAsa23is6hmuoz0J7+nUZMgpvd14RGvDGRXdUXAoCBmB9JrnnPEAQ4GiWf2dTADzSdfYMKh+9nxXNLN3F7OmaJ+dMN1JPDZXoRYvHug6Q3YkP8uPEJgJ1fvE+fqd10Tu7c+2CSW/Ba7psHaHxnwdORjOgz7ELSPYX9VzuuOFgHlPBOwgB53ReLVVvwzVt6U0n6p+LdI0ZYNZzeOlpJCS/ahPOercXEFh+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199021)(478600001)(6486002)(1076003)(6506007)(186003)(26005)(6512007)(316002)(9686003)(2906002)(33716001)(41300700001)(4326008)(6916009)(66946007)(66476007)(5660300002)(8936002)(8676002)(66556008)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vlGzu+je+eHkKN5paXuuA/CeSsP6uLTxiOTb9z4xjn7F9boLFr46Jtgtero5?=
 =?us-ascii?Q?RCn0XQWwlBxI8fLtmklH7sqMa8Q/Q3yAH0Xls+QphuKhusw73zt18tJscl7Z?=
 =?us-ascii?Q?kFTu7QIV0X1nvSc6moWSRHk9q/AQoY0APiQmoVy05YJAW8AtaSZ92EG/+Zvm?=
 =?us-ascii?Q?xlfgRUZK0ReYyHtYYRpvTj/MSp69TlhTuyLlM+D8O3bsyEkJCiiubs57HPNG?=
 =?us-ascii?Q?Qct3hSIEFyv8xcYnRBEZ8nahdZ9HjzjW/nKhMdDsHwCWWh1p/QWcSwVHlS4M?=
 =?us-ascii?Q?Y4TWZjdNwRA5wJj8p87vdZ6NLhyr5zF1dRpvw+nsGssA6tYD+xiHQQ4Xj03P?=
 =?us-ascii?Q?9hzlyVAXZ0ACG2I+hbSV95QBNVl7ACh1O/eRSiALvtcwUvItJ3a56lbIcdrI?=
 =?us-ascii?Q?5rjvYiP9Hplp6NYMFn8UgBzGsx2gJcqAS2+772CuFC8uUV/mjSPXsfpCT2G5?=
 =?us-ascii?Q?L9iDx+axXQZcJ4WhoNLx4ZoVbPtyRNHDom8XmDnX8u71Ok1OFHqbQlbpD2EC?=
 =?us-ascii?Q?oHd/pThAg/1TZFa/hpFqPxFgihJWIYDgQ+pZzAydZjj+FE1Jem4chaDd+cYF?=
 =?us-ascii?Q?/2dA+JCDtBkIgoF/J50ezlJQWfQVTGW9syCVWlQgzCFPND7e2Ee24sAw9xEJ?=
 =?us-ascii?Q?BbCWSJLykPDKxe4tnEsgxt2E9p9zQxYXPE9C/ryx0asRNHLfzkL+9/0imb6d?=
 =?us-ascii?Q?B0WUyeinIW/GAWNJrs/HkxHXUlm7jm7JMi5hsdteDwwd/c26P1JggBovLcpL?=
 =?us-ascii?Q?ECobDagC3pracRQu5TiCZSILHmw7VZ/xWPu6HezQ5Vach35VKhiObUPxEig+?=
 =?us-ascii?Q?pVZvJU6LR1sGpXCoXLYVUi8NrMCXr01T6NGAGuQ+Ndn5uX5JO793HbweY+wS?=
 =?us-ascii?Q?ZUdO/TbkdS62A0IuvCim36iPu/Ibn/6CigNzJjHaZgOa0E1oN4nZ+HDU9tDA?=
 =?us-ascii?Q?3VsJujo7qo3VPKoWd8xN/GhUyL4s9Z+pujWh74aFFRbmEdeAw4MJSMiAlLKw?=
 =?us-ascii?Q?U8QjsEdUlqujgfl5oqatm4MVCDbRdr4p2ShgjvseGtS0Tb2fxJjdpeWAuAij?=
 =?us-ascii?Q?byzDDQR0oz4IDjCHjXWKC0bgrzPfvtkl2fxzne3Npr6PbZtSvCeLnCjGxwfI?=
 =?us-ascii?Q?d4jgFLIOW9IH2tOU0V6q2H0Ji+bF+DIxjyLnN87be7kTjAitb2bmeX2oTQJx?=
 =?us-ascii?Q?24F6jbpaTYBlSehsKy2ols6lREjxkmeDQE3nRQlEx8koYvNCqwNzWFVmqA+5?=
 =?us-ascii?Q?xFMPHu4Z+P+BccbnMFj8GUuQ1YWlQS4XlBCMehKnfBsG6FbyLFX+mI9b8XpB?=
 =?us-ascii?Q?S4ZYK70REoFbGERXZof95Sn/GdJ8EB0K4yOYpOb8aDUwkQYDucVqaaM2YrLV?=
 =?us-ascii?Q?/L+R/4vWHMlvMu0irBK4h/LbD549qfutpxp9I8F8zfUy4eigELZzL0KM1w7K?=
 =?us-ascii?Q?Tt0TNgmNwMPlsBiq7bKcf3Erj7VO5oOAffxgJ8Sj/Ypv3sp1s2yQikJH4Eeg?=
 =?us-ascii?Q?H4dGnXhw0X0psgJoYELDLBsM56+/FdQ9j1yaj8wGBbSiwFzwtQ5Fm2Bh1vF8?=
 =?us-ascii?Q?M5wS8V1zZYL7Zrf2KOmvGQhJywaFELvHrV/MLTorI81uGjG/n1w580lLe15x?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LXtdfpmWFfmd1K7KNti5iZuc9FtKou6JEGDMSUiUZaEGeLZaNjuOZbN5nd4xVq8ePYmjLBAOD4Nb2LUTfBGd0Koa5OJPXHnMeFel6OX6pOGWQY33RsmkuhJFfjLKHh01CajVmTOJKoFxD452lausITTcSAANw2ILwDw2xH306AyfxNoKAhHYmxlu3n0BkVsNGWWFhwEqkFtmM0aCJlF9CcEGCVhGMYJDgc4jN392dT25Aoz+VT628kZtLfDN0dp4QOA9raVxvZzLVdz6V88Zlwu8MhiKGZU/aYDw7WXJ0+xpdqkttJPfzChzD3kj/sdmek60qAOmC17Z+KS1yu0x8y5LVGqTjZ5IqFxvvF9KfrM+r/WQzc+1JZcdifhMJ2Z7WnB5w5jl/EQ8AsjVkYjZEt6JBACVg0ECpDjezYbn9OCK+vu0YKUlv59qaIdkKKfeRN9MzZHD8aJqMPtm00o8RDPUC/oJAd1b12ORteWndCxWg+CUDGRPA12i6f4SFbUVPJOwRfWuQpzEVAiN53cySae9IESF0FEjP58qBofvNYBmePGSarBk38ziVHeGV3dRKXQWFduhNvRm74JCvPgzklxZmRHXxDRjIB3Hfug+uj1J29FRNowPlKxXUoeWlp63HAmfHX3CtgnHPWRvY3Fn4Z0TzCNmk8KmFCYkj/xbcRneSiC+1/EhIc+vG4sWbSapduh0Xaub3I8XoGuauShsFyif7tFAFJA8JdaTxjcMbMmMs89VbyZT1iDWCwCWxv6po6fPbSRj4wHZ0XjdJf/UOaDzHBC6RKdeD6eZYLKiMLwo1AHQRhBu33lDqEP/jreQNjNqE+fpSJ3+S+tA46p05ReLSoqsMhBv7IfiHB7W1W5SxQbAdW5zDZGqtUgz59QY
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e670c69-6bcf-44bf-4592-08db86c9aa53
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 13:28:10.8527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnTlm0hSYwx6YKPCDCEA35syxePVnRjprs1rz0Yn68GAEImDf6RoNMBltA2G7ChLDUhrLEgQHA/68EHgE8HZcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_11,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307170122
X-Proofpoint-GUID: _i7DZQsRRoThXQXC63v4riVhRZvYSHJg
X-Proofpoint-ORIG-GUID: _i7DZQsRRoThXQXC63v4riVhRZvYSHJg
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mike Rapoport <rppt@kernel.org> [230715 10:39]:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Replace "Insert and entry at a give index" with "Insert an entry at a
> given index"
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 92da9c27fbd9..da07c720c380 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -6299,7 +6299,7 @@ int mtree_store(struct maple_tree *mt, unsigned long index, void *entry,
>  EXPORT_SYMBOL(mtree_store);
>  
>  /**
> - * mtree_insert_range() - Insert an entry at a give range if there is no value.
> + * mtree_insert_range() - Insert an entry at a given range if there is no value.
>   * @mt: The maple tree
>   * @first: The start of the range
>   * @last: The end of the range
> @@ -6335,7 +6335,7 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
>  EXPORT_SYMBOL(mtree_insert_range);
>  
>  /**
> - * mtree_insert() - Insert an entry at a give index if there is no value.
> + * mtree_insert() - Insert an entry at a given index if there is no value.
>   * @mt: The maple tree
>   * @index : The index to store the value
>   * @entry: The entry to store
> -- 
> 2.39.2
> 
