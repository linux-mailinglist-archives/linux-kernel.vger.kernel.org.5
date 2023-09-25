Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF077AE1A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjIYWZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjIYWZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:25:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EF311C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:25:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PLOLqG022941;
        Mon, 25 Sep 2023 22:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=f6fdeNxRVgvsizmyCCMNvy5zWdWy7icxVmEKYvcT5HQ=;
 b=2X47QHlIh+lrZT/7TX8eW/cyWNBvFzMKI517eKiyf6Fk8E9Vy+4u78uRVFqFj5JhIX0g
 LHIov0mcIR424qTBnBB1CztM6b4chXemH4zRasNbpS4AyJZhAXcVTpTuIzOQlWDyq1Wb
 3zlknvqtovegroqmoo8ueZQarZGNKZ3J14txr8XBtcqJ63slhww/A2YQ/fldztQUhsdZ
 mOJwCsovSnetCiO0Skidf8nyqdie0YLgfzwOze8BkpkkYF7Rn9zNYgP3GhrOUqUpgruX
 K6/sXuB87M2UId8AEsjkFSF3mGrurL8d6xY+wHYb3tXh/pw9hNFYHo6ezF3XYF4vULpQ vA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qmud32r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 22:25:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PLP4AZ003278;
        Mon, 25 Sep 2023 22:25:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf5ctk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 22:25:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEj65AnRsOeHtbGAUVCaK/J+beoxbbZWyQgF2WedUZARa1paD6f7wd0KnU3rdgBkS6Htmew3GjF2dIkRA2rc165L+WF4WPMWnddB+fk+IfmoI5vhZNC4PC8gSI1GEcYj2D13fn7tIGSmtunjjnGClQhs+K1imfPFTWZDeRFjamlGrWmIKJjwyl+v0tlfhBJxLgWkqAUDns0JQeOL1dZ/bHJymVGF4eVPzUVUfmlylrM9x9ZKFw3KjQKojLQPwUNi21dWn5NY7rmecT6Zz5frrOdt+Ns4ldAmhcYY4bxM+963FwaAtUc23Eb+NWDwahqKkxZykqq7/DjI/5M77fl+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6fdeNxRVgvsizmyCCMNvy5zWdWy7icxVmEKYvcT5HQ=;
 b=EsVYmFULhJZYuY0eHR97HcPHQH0iM0vLiCXCHYB+Kym55Ie/fvONm9slN9FrHltoIHUp7ejZnU0lBIsFe677tmRcbittVEXIuTYPlk/Kd/L6uBQ1YTm8Ml5dSScNNJ/e4lHl8ckElqX8IdC9itokDm07k7KKA7clPtZvErt0N6cvhb3qGEzYRsngti2cQUQklac2joJ7gO6qDRtzFo5d5jTkygWI6mlj/ZLjWJRR03V2Jlg/95YEDU2k8/Zg0N6X++ICTYOJZ3DhKEqh4/RnF7uKUAjHLGp87EgS0i/I179iUf87LSvgjv9/zuPThu5EycpKXy45pm0mssTSTmgBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6fdeNxRVgvsizmyCCMNvy5zWdWy7icxVmEKYvcT5HQ=;
 b=wHBrAHf+fsfRC4uNsVgZoFczdYxkVteu1ZPsFBxc2MGk1yGJH+BPnibwJ2XQ1stXeBUlvyFr9A5pfWCrVG6NLjhO+tVT3QPC1lgdY9N3Gf1eAsQoHfE8ep8gXEqUEghMqTxvRJsGBV+KmGWPQqSNz39SN5sKNyhVGPnrwcGfs68=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA0PR10MB7229.namprd10.prod.outlook.com (2603:10b6:208:400::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Mon, 25 Sep
 2023 22:25:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 22:25:05 +0000
Date:   Mon, 25 Sep 2023 15:25:01 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org
Subject: Re: [PATCH 1/3] hugetlbfs: extend hugetlb_vma_lock to private VMAs
Message-ID: <20230925222501.GA55705@monkey>
References: <20230925203030.703439-1-riel@surriel.com>
 <20230925203030.703439-2-riel@surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925203030.703439-2-riel@surriel.com>
X-ClientProxiedBy: MW4PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:303:b8::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA0PR10MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e360ee-1523-4de2-12ad-08dbbe164419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V67varN4MRddKf1+0Wh40DlDGOl57QXcPiNf/cfaiWAvndV+mPsxo7F/wyBGy8mA+e/1QJ0Allxds97FeZXXL8vHjLS0IjxmwhloKoPCRQnrqoNMj8iObKVAN+vji0fhRLvMVmN1DbiDOKkZ+bWzeP6ZqnoKrECpMVNxHyvQPAxNtVXwsVZkc9LNa2oXL131D4gkZ9tWxe3sqJM6plc2KJwR+lVBVicFXOovRFRKO20lzYe97jZyEiJhz76aEuPhSniF1M5j1nE0XTfptqY+DpEWh3ouBAoi/McpwkScJyB98SEuHxtV1gf3u/Mt0KAYZksrYmetssCBvNBBIraYhJo79q38PXG002kd8vaB//lXQCsCDQzrHTlCaX0uqeEL54vjxv8HnDOeddvSuvLt0CrF0umuDB24nIMZ54NdE5Us4yzeUmpIh6qKV8fNa8QziibYZ6SgnBpyg2jyBrmK0z6AvVkAUKcrwUdUdjZ12cj+dQTywNjcHC8wHd3HiZySwpeThWa0eNn/RGfSeAgw0lrVr5WCBdW6osNX+Z6WyqkQSjJ3g0IRJ9nwvl8dunT8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(2906002)(5660300002)(66946007)(66476007)(44832011)(66556008)(478600001)(6666004)(33716001)(6512007)(53546011)(9686003)(1076003)(26005)(6506007)(6486002)(6916009)(316002)(8676002)(4326008)(8936002)(41300700001)(83380400001)(86362001)(38100700002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pqL4Qi1ypwXzmtMmCodoRDAFEV+q/Bhg9lmlNnQwrFSroMnps+6+xQQsDLm1?=
 =?us-ascii?Q?8Yes/MbGY0kNHkSe//Os0VGMrx9eccgYsl+RpMooBo3uSb9LUbgWot30tjXd?=
 =?us-ascii?Q?tZZOpCE9rsZfObXsmVQZBA8dAFBPh2ntuLtb6bXfJAtAMJM8KIwiZe3ZUFcE?=
 =?us-ascii?Q?k6HIMSMPe91+oloKrrawR7Tk1obtjzmRL8VveVWeToZY1+E0+k4ZbEGAD//x?=
 =?us-ascii?Q?Fk6Hh/k3Jlg0+6Dd1WKf+IrkO+/MUOTq67XM1+GHgtWaBVzgjtTDXlX1tKJJ?=
 =?us-ascii?Q?tSw3rt34Acmg6FKPGbTuO5rli16TF5/KtkGu3HC9nLPgBstmKmSA/uLkfqeq?=
 =?us-ascii?Q?6AlXE0lcnBOUk6GeLpUAoEO+u4PEz3O5D56+PoZ8BrK5nfRYLfk7/J6xZ6fF?=
 =?us-ascii?Q?fiwx2vb5kT8NRcJoU2HjalhDvGU4xV4c/zZt9/uyrtmJduxEYCIk0VEbe8i6?=
 =?us-ascii?Q?i1e5Oif6Zeqg81Y7tJYXav0vvetL4DrzeWUFiuI3HpcMlBoX8kXHS7PmseuE?=
 =?us-ascii?Q?ARk676I9inGayijQRKzw00M0WQTvWOsqhbKppV4W0XXZ0ORQg24vKliG/jnx?=
 =?us-ascii?Q?K7rAplB+OFHG7fsQ1iuXxOCgue7dSAISV3sL2Mt3ZD3TFgp/C+TvB2tl4aIk?=
 =?us-ascii?Q?UOAu740mY07kh0vb9ZZKucJB92gtkGjo3X9MNHnZUBGXni13A02JfvhHdFkL?=
 =?us-ascii?Q?P0vUmWDWnlK5VnOG2NK8+K8RPdtb6k8+wu1fJg9wZKHZJLmWD/+5Tbd1/Ew9?=
 =?us-ascii?Q?wa7GHdzwsw6bLs5hrIS4ccWCj86V8EwclJRyMAYOiZp7szdwcpXX1EZcXqYM?=
 =?us-ascii?Q?N0xHyU1znDZf//NvdvCJmBjxCwS1pacfQUWnsJb7cqmIQFsyQS7ybC+hX+i6?=
 =?us-ascii?Q?57I9w1+DVRJpoRu2GezPDffHbgi9sR84Nnn287cszUJyIO+LC8K4p4L0NWhm?=
 =?us-ascii?Q?UBxxr5dd5AUEPQh7L90HwiNdZzF2aVjxwEFjtdquy94oEIlKZ9alPRB5xIsm?=
 =?us-ascii?Q?u2eF/OWTaneTazH6UjzLfnypv6r0w0OAphinbN+t+c5FeV4mbu9ScxXqN9pd?=
 =?us-ascii?Q?SHQKPdPFao/dGeLpmHqGAHJuwe3PTVJn5upVgcdXhZJ9FHKJS3p1fkSCHVM+?=
 =?us-ascii?Q?k5b8LC/4mZJyN6/9TLZDSb/LmPTJZijDc1NwYqcmEZNcOjAFm4i1FdrbhAD+?=
 =?us-ascii?Q?JrBKx8HZptS4D/Q6Jw8zOAxyz8hcwOmEvQAx9uQkcOtQ43BXg34ZihPI1ED6?=
 =?us-ascii?Q?0/peE7vqYf1zcEq6AKxsyipDIPsEsWyCi/oOczPrSfLsTJJZJ9HGKwPK1jX8?=
 =?us-ascii?Q?/VwaoB+mJJ+QFEm+JgSDT8LuC9GglS2GKwkMMmhoOIGPE7GSLmcnxHkLpfic?=
 =?us-ascii?Q?aD8n9hdzVdYVnBdJKfvNhDNK2vIEdkVNufBV2wkR28J6X2bWKtcti3U55dRT?=
 =?us-ascii?Q?MiMJVJ85dFDTJphINDtbgxmvKwA00ubWhIN27qP+IyAFG1Xw880QH59BV52m?=
 =?us-ascii?Q?2qsNBcKyKGVVNRASnZeUhWVX6rTujOq7dBmz0XWIkmpneh4CzqwcVi2eumqQ?=
 =?us-ascii?Q?3s9u42ceNwWMOkCaT+zJv/kofICQOc/40SVjkolwYf0PGxtYBeQ6Ph5bkjAb?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?G1YVSGL86LoLXPNI/kVoWu2h22Aq8nrXD7WPxr4bi3/tHookBUM6YKQlPVeA?=
 =?us-ascii?Q?nkEtUPcm+BLXsSW4/ALa8CQjzTGFNUVaVPDB3D5uUuDsglEmRhWBjLXlb4EO?=
 =?us-ascii?Q?xqoab3PiEw7QCC8qdEpzOqf43I+HbAL+LxHfZI5FOqGPx3nZhh82o2k5lDc8?=
 =?us-ascii?Q?S2Vz6TyQUQ82Z28pAKnSdMPCHQmn8qKr7FIxcQWFqr0ovOPOt3Ah10sUZdTP?=
 =?us-ascii?Q?LUdqU8Xysg2KjLDaUMD6CdEShVoK/8N61kd1zeA9VJbfEUexDJ8v5P1cmJ3B?=
 =?us-ascii?Q?Cqu4CC+tnZua/io6798qagO5ejoSdsXJAo9M74BiyRNMC9YRGVUSlHSJVh91?=
 =?us-ascii?Q?uDIz2pLj+xxJUlZj2WjhHCkVWtW3L6Lzq95dOeXnOqyF3X19pqWYF86MohMQ?=
 =?us-ascii?Q?N30C5MVdMZvDpiCKD6HN57ijz9BKsjsW5YTlTUIo3RH6LGnAylUi5+5YYf8E?=
 =?us-ascii?Q?QrCAxLgstIm4eh+C5cyO/Mwb+9nGDj6CddAfgtuffj9udFzKHKb2pBEW4M1q?=
 =?us-ascii?Q?Do0PdCBEq2/VQcsNrqpnxSyOejdZijQFeEaDaO/mR9qOkAzYnQPulGZmEmas?=
 =?us-ascii?Q?KDUpLDY5+nudZBkLuQ/9oCP8eNrF1hibD6aRWDpj0jmsT9L+nsYCK1K/uCNP?=
 =?us-ascii?Q?657ec6nebLe/AFjfhuXxWUnUM2zYyWsw2zYM7IM9TGxSDzXw3fypyyEJ16H5?=
 =?us-ascii?Q?Vu+OPJNw0i4OKCqvRH/JnDyPfPXcQFIfPZXElUFOo/jX/bX6pdXkPS5kLjQJ?=
 =?us-ascii?Q?6zqPgaU8EHFXuG5NX5FKJBM5q1w2pTeBvS3AUshpvQTBEgkX7QLtzTR4HG1l?=
 =?us-ascii?Q?HqAbHnrpiOQww6dqpZGRt6LxSxqosG7Bzuvk8eQ0IMOYOJZomhNj4YkU50PG?=
 =?us-ascii?Q?3GLR5s3RpvzHEazilSQ9058YOyvR/9UN5NW3no7BIfWoSLD50Z/2CHIZ1oHY?=
 =?us-ascii?Q?/DKuFhC/ZFzkWqNwx6LIjA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e360ee-1523-4de2-12ad-08dbbe164419
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 22:25:05.7902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEXRDHScSx9xKpDGXsJXUISlW/W3X0Q3NH2kR0QJbbWzsBC1IQk5E/2PqUVxz0ZLHe/42nmaoCzS9D7P1udtOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=748 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250172
X-Proofpoint-GUID: lwt-JRZYDquTC2hZq1U_aPc0CP4JG33x
X-Proofpoint-ORIG-GUID: lwt-JRZYDquTC2hZq1U_aPc0CP4JG33x
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/23 16:28, riel@surriel.com wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> Extend the locking scheme used to protect shared hugetlb mappings
> from truncate vs page fault races, in order to protect private
> hugetlb mappings (with resv_map) against MADV_DONTNEED.

The only time an anon hugetlb mapping would not have a resv_map would
be in the case where MAP_NORESERVE was specified.  In this case the user
should be prepared for allocation failures.  I am good with this approach
not adding locking for the MAP_NORESERVE case.

> Add a read-write semaphore to the resv_map data structure, and
> use that from the hugetlb_vma_(un)lock_* functions, in preparation
> for closing the race between MADV_DONTNEED and page faults.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  include/linux/hugetlb.h |  6 ++++++
>  mm/hugetlb.c            | 41 +++++++++++++++++++++++++++++++++++++----
>  2 files changed, 43 insertions(+), 4 deletions(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
