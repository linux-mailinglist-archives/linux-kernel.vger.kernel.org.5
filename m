Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDDE7D5FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjJYCGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjJYCF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:05:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB2310D4;
        Tue, 24 Oct 2023 19:05:57 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OLUU0e014935;
        Wed, 25 Oct 2023 02:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=fsR2h4k+yR7xOt+jnmxEPOl1ofqickFE6SOeXm3lrR4=;
 b=SvWRV8VGxSMIsLRl1fZ72wluX/s/X2FdniomoungZ7u09W7XISLq9PTNpTW5ha9tthiF
 Q2NrTnSHbYz86bQlsYiCv1t3RBAFqihDixhRXKHIs7xZDdTiISocmxZiNZ/s4TuES0BE
 4eg5QwEShW2M5mqD5Ijo9ni2es8USi3VvLcqPjlvwRkgnC1wBIRfdit/jB4wNH6Y1ozd
 KjHIA/VpkkToNUEJv/lFmxE1+ftMpRXCUJ54Pta32mJC3nD1A5XeCKZLg5WWW9LGkeF7
 fbkDs0YIPDeVOn9tbkwKBQn5q0nZ2eiSGNRiBXZekuRHu3jcAGy9+Mhh4jCyqo4yZEAN 0Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5jber82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 02:05:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39P074It034563;
        Wed, 25 Oct 2023 02:05:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv5361an3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 02:05:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtDFPCpkrDESmGF86jgeNHaOfR+NzzdDSQaKrPrxCQg89HqZjKPDfKOJBvExM7SsX3UjESS4HaSZYBa+g25/vtcfm8zPv1xxh9YUpAm6NRl5LC4a7fpr7+P41YhELu102U2HFjS4yWRiIewSSzJAreDxaygGUKsXQIvKphkKOnlPI87SU7Dkh+zjuNTxZXOh00oRC0WnIt3fgZOMXwLUmyus9tO/fIDu3i7ugrk2Xoinc10xMF8oap2GmKKnMsPfhwahnDDhkN2MXDIGajy1KNI52NBhVRpe3Q4DBYK0/ejUXWYzZKDUodRTCVn572Xu2QQoQDOMHOUI6SJvFbhzOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsR2h4k+yR7xOt+jnmxEPOl1ofqickFE6SOeXm3lrR4=;
 b=COFtJniiBjzj5SJUb4DnyM+PPk8WmlsN0hS5BTOVXL2jIu8Fd7ljP95x2G4lglnJQBP4zQz55kU+hZk7yRhaATABT5NpdXyREWu7jbZj0JfGicaBuX71GmMcQYQK2RJJp8CL+tCCNhVZPTYDFz3bmfRtXm5mWaYteztVyLr2kP2Un+z2FJiavN4T8TRupa9GrlxWUjsui6WpheI9bxt6THlS0gCk3YnIJ6PBLSNddEvqsj0LOpW49GRDTygb2W7Ax29nyN8lj5DE6M6E5FesMLavnvwfuRjFcdeVYPpjnxO8lox6x70/uqN0u6TfVoyWybj2+0Yj48dvQsmUP9S28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsR2h4k+yR7xOt+jnmxEPOl1ofqickFE6SOeXm3lrR4=;
 b=cE42cC1PHtao7qRSaLMEdSVMR9TpWIjojlgZPdNXz1F8zgFfSSKUJySBkmdKstHTz00hrqMsEgWK/UfikIOCeA4UeVjsfqW3Izn6U3cv0VdbItDUPVTN/J2Je8VpXuof05rL8owOmBkOAsE+wRXtCbHgrWd8gMW9itp1XjIMqbc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Wed, 25 Oct
 2023 02:05:35 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7afa:f0a6:e2d6:8e20]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7afa:f0a6:e2d6:8e20%3]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 02:05:35 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        James Seo <james@equiv.tech>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] scsi: mpt3sas: Use flexible arrays and do a
 few cleanups
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1il6vfoiu.fsf@ca-mkp.ca.oracle.com>
References: <20230806170604.16143-1-james@equiv.tech>
        <202310230929.494FD6E14E@keescook>
Date:   Tue, 24 Oct 2023 22:05:33 -0400
In-Reply-To: <202310230929.494FD6E14E@keescook> (Kees Cook's message of "Mon,
        23 Oct 2023 09:30:07 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 67118c4d-4b77-4c78-9a70-08dbd4fee054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7tTH+/zdwv/RpaWjj/hYFrp3nXh4Kg607CPXjHYyoj7rzoilKsEvtoAMTOOJxPEanUiml5u0soFeWTrUlkrkuKesdqm7gKacnHodpFisqF1Vmx7OcEzYnUIfdDahlSrW6Kjt0tkLRD2CrvPtWa/6h626I/Kiz5KV9cjf6FZVHX10SuQLGBJFTd8SvjOjkgML5pQRUCuEpqATmH3p77EkcA3eNRIJVdz2Xc4bLV/bN+na12CUdF8nD7zoFLPx7u6JWn/gTU2GL8jvwNC7j++CuGHGioqrJIxnuDxwmy0WnMOmoTvA0GUnUY88GeNXgGFiDvsxq0+w6iJv0I0PAnrR4FWaTv/9CYI+M69hPgzrMI7kRFztLOvQTglmAo2xp2entnnV7ZCrx87/vgmXiT1Nco3Q71wi3XCiY9A8ODrhzsHJxx2l3eyokS7LKpyU4g5KMifpBulkxQzNidWF3M1FTRWAebZUqrzADeredAZov8COGUfRNJrau1fcSZyOgOBIhB+CShtOR/Ou92Z1eIiAKz4wVppoMk3LJ+/rDEh7ifPT6WBKaBWamlFutsUpD5G9/dPK9hFt38CMZ6BrVl9UR5ULw1YBNyxkYUkdmBWWQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(8676002)(8936002)(7416002)(2906002)(4326008)(558084003)(38100700002)(26005)(5660300002)(316002)(54906003)(36916002)(6916009)(6506007)(6486002)(966005)(6512007)(41300700001)(86362001)(66556008)(478600001)(66946007)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BU9j8DdW0Ng6EKgUHChtgVwyS8PZqXJNTDDuT/wvWOlkMammDcPfWeCuGmSL?=
 =?us-ascii?Q?xz8FdSCvRBzrpBCNE3qcd0ncYv4uLarYTrNwZ3TTt6a+AcCOVGu/DIW8Roaf?=
 =?us-ascii?Q?HeDL5O2NIxpyUMYC54dB0PFex4o39G/zVaxEW5sBAWTMc0pyUjfL+pUItfcM?=
 =?us-ascii?Q?le4rBCBjESA+0vfnM4yc+Qo2XMPAtH94/gMYYx4FhA7Us6W+0roW1/umLdD0?=
 =?us-ascii?Q?X6UHWk4iTE3Zrt6SpyOLjsxPiY/ja6y1NBRpW3octY/vyIN3Wpjt/+4VWSoU?=
 =?us-ascii?Q?u1hfCpsSyf1R8qdc5FSe1wbsXrfzE0JRc4Uhgg4pQzAZNwXmOInpY4eVCotd?=
 =?us-ascii?Q?9CEv9+zvx5wviSeK1rsh1pSDYYK+QojcSRmjF/25jUM7NNTlVWytGteGfnhl?=
 =?us-ascii?Q?E2RjhPeBs7BiEXXXBzFwAPRNfYS/IdnUuzQxQwByEs0hIVzOZIXLpx+R1cKl?=
 =?us-ascii?Q?ImLB7G7gJcbOUIQDWVGJPhp2FUj/C5aqtGEI9AHQXrFAZBiobMz7/pp07WmS?=
 =?us-ascii?Q?4D+aXg6V070EL9OTIyUZUTae2oU6b05GARlS0ZzJ0c62H8woqYEBPVVh9wGE?=
 =?us-ascii?Q?hb9qNxvCIvh15ZFbCtruHYTMCwSMUw1kTds1dxUCl4ETEfbiFTT62kHJhiYg?=
 =?us-ascii?Q?s5WwCkP2uM5lySRHtjdX00qiL28+5RFLXrzQmUk+6yQ3V0ynuA+rnsjPcbfc?=
 =?us-ascii?Q?i+uLDbm4SbeudbwTgiexddboptaBTroifPSt18s8fFaBFw7xa9NNQL+VZwnP?=
 =?us-ascii?Q?Kv6NMlA0Flirz4E3gaIiYeQe4VT6rwbLZFxiHPIGqFv5RsO+qRIoLsLcwPUj?=
 =?us-ascii?Q?RRPNeWCH1Gy1IoeSBp6TcwjAsjXWcQxaR/8HJuXw53lXvBSCceV6mdD9B4qM?=
 =?us-ascii?Q?TtP/KGQdYVZDJL5HWRUK/jXs35eiGuSswLFvEQa9ppte6orr8opdZ6Lyis01?=
 =?us-ascii?Q?uUm2GdHba+oO+jmsR5CY1POwSgjOSSCwxpuv7jl3C1WgdMHd+/3fstg0B68u?=
 =?us-ascii?Q?XdXdwDFy0aci63KqRSMLBarBpfJTdSzDrEuJ2DIlXjWhXLM6GAUkKuGtGTDT?=
 =?us-ascii?Q?Ju46QEOwugo5n/K75DVHvHC/9aUTURI4ni8/+E68JDpOBv/au71Z0z+dWi7s?=
 =?us-ascii?Q?eQxirDSZZh/cLdUAYyIxgvEE1TgtyL2Jnvp8sbKdlRU0RjpQu9kB/tE0fE+t?=
 =?us-ascii?Q?3Un2mYBibMqiSD1kw3lgO1CVUuggqWrfKAXxDJX71wpLV855NEOkIzAtb52Q?=
 =?us-ascii?Q?N5SSVLO47EqALJ2+0OIJODdvYE9B5aiq5pRQVFkxc9TOVEci7w8Ycowd+Wpr?=
 =?us-ascii?Q?eBTdZUyeFv8j06Tom8PJhIiySy5wSbvwgoz4yMkCL20Zfeeo6bsQxXk4Pzzn?=
 =?us-ascii?Q?/sEcjy3C2yrGNdF/NaqRihEZmJwhYwhxeNLl0RKWEshjrAiDH1fL/XSGHue6?=
 =?us-ascii?Q?UtyylV2CwVwps0I48besFnxjzjskfeUCwBD3FdHXAChHAqEOtUOTn6JYLeGJ?=
 =?us-ascii?Q?IVcTe/8jDWwA5iPmyYOYMaYfkwOF4nS0HvWpwidpC5/s7o2q0s2dlnwlL4U3?=
 =?us-ascii?Q?+Fm/1BkXMlOkSG+qTRw3k7bcJ2O2Vg4cicfl8iRpGqNojuhFZ94jYhXBa5+e?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?UAVnPG52sCBNXQ9+kwH6WzWJZTi6av/xTe37WCfG0qtGKhwkFEAJXjpmyC5X?=
 =?us-ascii?Q?axPyVJd0AZG2hsCuaM62F3XQpQ+BWgnmsqrhsWdNib06vUwkt0HNY8j8WC4I?=
 =?us-ascii?Q?tBq9mb7tcQYlmWsFOGq/ga+swOOo/ENO28CW4PYKxSDDxbD6zNLiBAsdAHTu?=
 =?us-ascii?Q?OJK9dfYgQOp3HnQZBfKG/4/ULShcRrrt3xKL9E04N+sx3hL4a5qCKj3BdY0Z?=
 =?us-ascii?Q?aCYc7p/IoVNC5nE+H+nkgpTtQ2iyMqsgF1WRG6+6qFocrNAttnxm7INl4d31?=
 =?us-ascii?Q?WciTaRGs2na2sXkgQjvAIGsVfpLLIAk2NgfNX60IdSFzrAh3ChCIRWqhbNM5?=
 =?us-ascii?Q?UnC3lxyCqY8U4mZp2bnKjzk+2OZKUA1Vqo0OgFADROKQAOpq4I1nu/Z2bWY/?=
 =?us-ascii?Q?PUDEWid4mTE0q5mpRwMLYVHl/kJlRK3HYbcHdgjTY+QIMg7TIsVz2yB61E1a?=
 =?us-ascii?Q?X5eQtG0ADmN7hqZSkdre9uQuFFQWf/RZNbDZQsxtaSwR08gsUL8OUKkqj8sW?=
 =?us-ascii?Q?MXDnNSjNTdhiuFslwBYsmO7AIjgI9WFG9OvAv6OeOIfwI32FpFKgaACaDKCw?=
 =?us-ascii?Q?BwQt+/ca7NwDS05j11izwQRyJ8bC5GcyTsJxHCvvqkQ3L43EBrPdX3VXz3/L?=
 =?us-ascii?Q?Be523gA1CiRpuBztKoQWgdrV1gl9cPKfhwjuvMFi6by5GxG7WdsvdJaT38x1?=
 =?us-ascii?Q?Q5rKkC93LUNcu5wlrhXYreejg1jLW4Sxs8CV9JozEf1WWymTup+HJnbEy/8x?=
 =?us-ascii?Q?z+/l6eVr3nF1sEP4rW3mxw3eEgMUJaM9A4pQPnWetW53ND77RElEi7kjq+Nj?=
 =?us-ascii?Q?sqovCuTQt7sZcgmUlmG8beVlCknf2Cg86bp3CYI6k/zUgKTrvEZlMhs5qOUB?=
 =?us-ascii?Q?2ZW9V7lVM1Df9uYs1rE9xVbY7GdON/P9XhBJ7vY6sWxYuAHARK81WqYAdWp3?=
 =?us-ascii?Q?E1NzXHaF3XzAyeByAgKSPt8H1jjUOV3v7Z00q+RHaDE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67118c4d-4b77-4c78-9a70-08dbd4fee054
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:05:35.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkXIjvVQuxKy6bw9m6S+ycKdI3rX6pvo9BsKf2WtEyZUZkkdzAasduJLjQtbD6LFoT3bnKLsqa/tFgGj3EcCEN4DUTu1AAENJ0utpOWgZG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250016
X-Proofpoint-GUID: Dw9YiEYD5Y-mjrBZxOoMDaKTOdXomVgv
X-Proofpoint-ORIG-GUID: Dw9YiEYD5Y-mjrBZxOoMDaKTOdXomVgv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> Here's a tested-by: from Boris:
>
> https://lore.kernel.org/all/20231023135615.GBZTZ7fwRh48euq3ew@fat_crate.local

I'm a bit concerned bringing this in just before the merge window.
Please ping me if I forget to merge once -rc1 is out.

-- 
Martin K. Petersen	Oracle Linux Engineering
