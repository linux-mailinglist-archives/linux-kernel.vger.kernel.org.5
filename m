Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A5F7BF050
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379342AbjJJBb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379294AbjJJBbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:31:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C5991;
        Mon,  9 Oct 2023 18:31:54 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399NwkCe007696;
        Tue, 10 Oct 2023 01:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=uErNPlCttzdTbQKjixbwlncWSOrvVGllj37yo0rxM/0=;
 b=eqLZPg5kr+ECWvO5sbs3S/eYf+bd8utGZYuffMUbkDxuxiQagTa23f+P6gvepB63h8AB
 sTJ1KnprJgY+1P/iR3Ns8mDBZxxRAFz3cYcBZ5bA9pEZJagL0mXUsc29WBHQ9HPLVsUG
 8G0mFvJS7SMI7Db3THhGp4kJCzDSxFPurhDeiPW1RJUFBionBvaUI0moslyDoPuQAFRm
 JaPpl8zrbgU3pJRbV+2QrHQ7beSZ6iDeUUm+qxRolE28vM9WaRAo8GTD4Pc3FEloHO5S
 fdAMSX5/NgPSSr2IAjpudo/qsRgV3oVq5k1dzx+LktRCEyZTQYVfxhnE2bS8X1NFKaZ4 iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjycdkyjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 01:31:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 399Nbjou004890;
        Tue, 10 Oct 2023 01:31:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws5satn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 01:31:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZRbuyElgqAeTv2H4EopEH4nFOQEWp5HAmsvbomNzwRM13ThozFYE7CHG56S/F/gI2dsr3HBKLPYfLV0ef+OeM8XdHyrThj5sMrV270PYRcO2Jq/hUxVC2YbAM13na8Ht+kld4fRnLyjCbYqCD6uMrZbScKiiFgLGS+La5oXOfGulmwOdJeJ5TY9K12r+f6KeaKjB3v1/lSwTWsDDng53bWyonGSxouFRx09vh8xnO+qC9JXPGIsgunCI6IdrY6gl8vbjOqqkU5ynO+Wac16yyRql6dimM74GdiwDn+/owupwJljiwooa4q4ey2XM55ojC+RnMZmwVC4a91Mi+svWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uErNPlCttzdTbQKjixbwlncWSOrvVGllj37yo0rxM/0=;
 b=b444388uaLjih6hL6uHBqMaL21kO+ZyTG7oOf9tQCnbNL/doDuf9Lx59SmXcR0Oz57y+WgOsV4qqZqAZjJX7poOZ8Oi4R/x2MUpsMcCUoksj0VJHv8nHAiZqL57LMK6Fb5L98uDyRgN/ftnCwfaU+6V/909Mum/rxC4bH7HSnaG9vrUO0BG1HGTmLcSO6zgBsSBL0gAwy2WRe1964c2IpVZuM8IPjNiChR9jwcg+1is4hldCkrFS9kKjFdhRRSdUiQ5K3kF3bVlohupXyOxnKmjuzsKZ//umAieRzBCVIDfXKM06tiq7J00YH2pfGtHRSF3wCHlrFp4+mbkFNy5XLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uErNPlCttzdTbQKjixbwlncWSOrvVGllj37yo0rxM/0=;
 b=XbNfJqbeN11K1Y3+VlZi+OZJLpaURN5lWYmqPnzqaptBXNr0moop657tbKbDNer/ZLiUVCuqY31zP7woeNjB4TXqLkwX7GDSZtE4N14m1xCe37m3Ppt/6am+C4yXcSQNEtOQbxCbZReLQDRa50wMvNFACXy7ktiWYmFYwENGt/s=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA1PR10MB6195.namprd10.prod.outlook.com (2603:10b6:208:3a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 01:31:46 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1ae3:44f0:f5b:2383]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1ae3:44f0:f5b:2383%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 01:31:44 +0000
To:     Justin Stitt <justinstitt@google.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] scsi: message: fusion: replace deprecated strncpy
 with strscpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq134yjp8ju.fsf@ca-mkp.ca.oracle.com>
References: <20231003-strncpy-drivers-message-fusion-mptsas-c-v2-1-5ce07e60bd21@google.com>
Date:   Mon, 09 Oct 2023 21:31:42 -0400
In-Reply-To: <20231003-strncpy-drivers-message-fusion-mptsas-c-v2-1-5ce07e60bd21@google.com>
        (Justin Stitt's message of "Tue, 03 Oct 2023 22:15:45 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA1PR10MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 32cf55fa-473d-4206-1982-08dbc930a9b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ji9buEToNR2AfJoSFxMVmMYCO9+EmYutU2KTPd0vxX/vltZwicrQATFZzzv/Oul7nxMh7ioetJXO93vzTV0jIy7xWP7yYmRuMe8gLIYc6OCRpFxN8evkNe9ZGMsB0dhUuCdWzQPqUUZFP/qSBWCDh1/z4P78BW5VhPUKaNPuBbEhPZ0sZY4SIyZc7NamJUFBsrfKfFHxFo0rw5uimY6iOWVVu3Jt5bBKlh14KXqLC6icPDhRKne/a1UfoEDbnawWzGkhHDQHZSrVl7VTWI4kRngzaR73kaVMrmI+djfrx9f3twWrE2VmxCSRnlpVcJxQAN+vshD9LD5GJATDRrovrVZcOe/Etd1qTpauYdXTlnWtfpG5toKpm4EXTdHkA4zKfYtHNpr5Nyb9vbO2zuwXhnHCF/ZhkmcTGZT0ezGi840/pNMRd4v8LTOhQeKJwcbJ8w72MWwtTwulAgjbox5fVCjGmky7MkI/jRyMyROVy232NclVv73rhRhDdw2syXJZFukP30Y2YfCu7YOOCyI7InrbfYeYr8dABk2WgswsHNVRTfDEkF4oOcbiMDtsN/YGX9eUZpBsHk9WT46Cv9K2TwVsav0MJBCyj2ap9qanhZs5t8gufJc4h1/XvYczpFUo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(366004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(66946007)(6506007)(26005)(316002)(6916009)(54906003)(66476007)(66556008)(4326008)(8936002)(5660300002)(41300700001)(6486002)(6512007)(478600001)(8676002)(36916002)(558084003)(86362001)(38100700002)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tjYdugkjGXRmwoGUTbC4z2nkR/lDoiZa8ygaC9mzWPxNrBFq6Q2UZ8p+WL+O?=
 =?us-ascii?Q?h6hM5tbBczTOWiytMfhL7xTFesiVuBpwZjRfnjPb7tXhNbytRFH+48jgliRm?=
 =?us-ascii?Q?5JGz3Geho6F4S2f5h62LWN6lXdPLwwqucgiR/kS2aev4/JgvaLf5Kk/p/Tgl?=
 =?us-ascii?Q?88vZpM8Md0hkdFgdtmRlFYgSC5tCC++KGMFDwYgTq6PtsZ7vSn4SivRe6oiw?=
 =?us-ascii?Q?5ii/AwUUfCjlOYRnZ20SSzci4nkDHHQG94C7S0vCyyr3nrZvsO0iYUlBuk9O?=
 =?us-ascii?Q?3GTRHvRkfTfw6ee4a3bGUH6l5ZToZyY3UUrnz/V1tJNVO1Beg+gdHs7O90bk?=
 =?us-ascii?Q?k9yjOcHaeeDD6wXVMh6YQFT+DwLNRC2bn3vWzBloaPtlzKsMF4znxezljiN+?=
 =?us-ascii?Q?AQgtCfq0yMtRVSIaYTo5IDeTp+Z1tMsSLTbT08F5qZhKm0gPlNDPmRm2VPNe?=
 =?us-ascii?Q?1ZIrIQkBohzI4u5ExPnQCFyyYqorkFolvN+A8xpYUexMA9+O6e7MBIRMRJNZ?=
 =?us-ascii?Q?B/qxEXo4JHpqWcLl6n+kL6m5LX47799FyJFMnhEDFmg7hrTEH3bm/e9/S/dk?=
 =?us-ascii?Q?yehLVfAPbvxaAtVxFw0B//yqYeytvmOYQrvjM82jCatz4O02TIgeqPP8u66s?=
 =?us-ascii?Q?fUqtIj0BKXmgtx6lHLGhTNA5tmzLM8I5fAOgrHjNmUw0ubMimHmzM9ARqI+h?=
 =?us-ascii?Q?KfSRCf8zGQRQj+dQvCxYNaSu3LtVk6KA9jREkTM/5ZAOg1HdG7lwbW35syyD?=
 =?us-ascii?Q?+qp9AFs3iAWXHu8KG53nfvo6FIHQwicsbX0LkpV4m7J6Sbr0lm5+D4ewj0UA?=
 =?us-ascii?Q?i9boG+J28ytRjTsnaBlLtC7vrmq11UiovqvEN2B7IOsCLB+uYPhkw2Jr5rpl?=
 =?us-ascii?Q?ZwztmsjOKOI+h4WwYGzckY5WW1tNwBvnAM0P48h4wWST0vEaoOEDsuLFAhgH?=
 =?us-ascii?Q?WSQKofqBCSrH1cw4obm6vhN8bJqZ9OryFlye/k1Y5h3qpzEkhQ6CeGxvDi35?=
 =?us-ascii?Q?nUu3Cn1Gg8rlNk8p0slPYF7PZTFJOflhQPZJEhNG5Iabc37Ncq3y9hbM8+FP?=
 =?us-ascii?Q?2n0MGIYTlshr4WYoAdvSzQhcwHCz4GVBW71xmrHui8ErLttW59/8Qli0zwqg?=
 =?us-ascii?Q?a+1hVymBkDMDqWdfJASNa9aIQk+TZznxWr0dSNJaEtEg1HTomlHBHh2xvHPn?=
 =?us-ascii?Q?NqrPOyd157pSNEYLV++lmbyak4dr7KNLyJZ/PEju/+Mrc3dLjCCb8Km8SXJ6?=
 =?us-ascii?Q?ryfuu10a+czOqe38gyv6IiSFxbcf5ZYrjGem8RnrqbgGd/W/E5w6xrEO17bS?=
 =?us-ascii?Q?0UQeUzJd9U7YF7NAnHEevMZA9PeTxb69mwlUebx+YnaW4t6YIcGxw6+Dovlv?=
 =?us-ascii?Q?vSXW180KyFWcJFUVxFP+7RC4y4qn5xhcNBZ/n4ka3+072TSEjkM0dN8an8oA?=
 =?us-ascii?Q?Nh4/35mWmZQ82FPb1ESAbbxX5UIUcYZI4Zd4gONzfAmboXG1APUvxJOrkdve?=
 =?us-ascii?Q?I/9Swzfjfl62g8NDXYzd79CsWX3mYjbfNcU/92aLjHb5W1PIuS4i4K7DEKvZ?=
 =?us-ascii?Q?QKg9fgY0eMljYBZfaexve2iwleuOddy10ADUyz5VyzpRoacuMj1+ABTM/Srb?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fijZKHQgtVGhdspFBl3iB/O5cj5VOBSiO+KuxKNFg0z7fgWrZa+v3hBiYS7jfxq26/kgciNFCuGs5oTGiNwCit0/deii7TrZ679VKP3jdpxEDhzHrwqGRusCtooCsc3Gm8d7bwmZxCuHzGvQ1yYviqYyORLC8HjG01CBj0MJpgn3H78d0FT1Xo+iN9bdRlFFjcNIvoWbb80AstfxD4APq+6SqL1EPLgGeCUAx+zYJ1hNWjEWTJT9UZYwb6qgdtBja9mR8U2s+P4oQcegswG+y/CNb317aQmIibThtzcDxSiWm3cRYi+Q7dzkyD4nlWfkyw6jDhZGdSi3i68oa0HNnWVANBZRXK65G8J0VrLkXwy0UXfcV9hbUnuvCmh/SVSJ0SiPEOtfNCTvayQ7Ui8GeL5htwN2OlBAXl/LrRbyV6gqVjphMPrKmFDgjNYT7Dzw0ONOvhp8eYyRMSU5cjBlz/fHmK5BNXS+4po/IsueiQOhXeFZL3w63/E51QmOjl2afQVrU3PUd2Izjn0FPgd2aM/j3/sEY6pkLud//4kJL/T/BjWxfSzDdfn230O9QHtzo2eq7OZOZN0pMOrw0laTuNNYLL2oQz4vfm0nTfc/6OTOCGZjkGPRhw/aCUYRu5Xvy3NqjOhmVJzt9ckPW3SRtckNneYSxut5JpxgKCve1jLeKGcOyED7Dt0F6nFlfIE6acxx1Uk1fm7mLpaRXpMow6sje2+A2I94WzwSvvy6Y6dHd2VWOVqSTfMzL2k68YHJswSaNOy5MnjNIW/7a0L0QOqYPNJoB3azAYAY126izD5rIQPbSYd2iwXocZ0u+0vNtWtvVUNXtWagGQTyAxpqDGys/UiEGQ20IJQWN3sCRh8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cf55fa-473d-4206-1982-08dbc930a9b5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 01:31:44.7870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCBsTU8oUdV8SvEU2NAwOi/PoN6Pvhn9O5LEhL0tfCyy99NCCiekYGlzFCG5vj30HDyexuQJDh6bdWzWD8wpXDwEVh3s9y7utMaLbL0OT2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6195
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_01,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=792 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100009
X-Proofpoint-ORIG-GUID: h-Zi8IDmEhVdQrX-HDSHHLleHWBETeLf
X-Proofpoint-GUID: h-Zi8IDmEhVdQrX-HDSHHLleHWBETeLf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Justin,

> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
